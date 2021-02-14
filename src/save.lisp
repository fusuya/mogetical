;;ドンジョンのデータも

(defun save-party-data ()
  (loop :for p :in (party *p*)
     :collect (list (name p) (job p) (hp p) (maxhp p) (agi p)
		    (str p) (vit p) (res p) (int p) (expe p)
		    (lvup-exp p) (img-h p) (w p) (h p) (moto-w p) (moto-h p))))


(defun save-party-item-data ()
  (loop :for item :in (item *p*)
     :collect (list (itemnum item) (equiped item))))


;;セーブする
(defun save-suru (slot)
  (let* ((path "../save/save")
	 (str (concatenate 'string path (write-to-string slot))))
    (with-open-file (out str :direction :output
			 :if-exists :supersede)
      (format out "(setf *load-units-data* '~s)~%" (save-party-data))
      (format out "(setf *load-stage* ~d)~%" (donjonnum *donjon*))
      (format out "(setf *load-party-item* '~s)" (save-party-item-data)))))


(defun load-suru (slot)
  (let* ((path "../save/")
	 (filename (concatenate 'string "save" (write-to-string slot)))
	 (str (concatenate 'string path filename))
	 (files (map 'list #'pathname-name  (directory "../save/*"))))
    (cond
      ((find filename files :test #'equal)
       (load str)
       (setf (party *p*)
	     (loop :for p :in *load-units-data*
		:collect (make-instance 'unit :name (nth 0 p) :job (nth 1 p)
					:hp (nth 2 p) :maxhp (nth 3 p) :agi (nth 4 p) :str (nth 5 p)
					:vit (nth 6 p) :res (nth 7 p) :int (nth 8 p) :expe (nth 9 p)
					:lvup-exp (nth 10 p) :img-h (nth 11 p) :w (nth 12 p)
					:h (nth 13 p) :moto-w (nth 14 p) :moto-h (nth 15 p)
					:team :ally)))
       (loop :for i :in *load-party-item*
	  :do (let* ((item (item-make (car i)))
		     (name (cadr i))
		     (unit (find name (party *p*) :test #'equal :key #'name)))
		(setf (equiped item) name)
		(when unit
		  (cond
		    ((eq (categoly item) :armor)
		     (setf (armor unit) item))
		    (t (setf (buki unit) item))))
		(push item (item *p*))))
       (create-stage *load-stage*)
       (set-chara-init-position)
       (setf (state *p*) :battle-preparation))
      (t (setf (state *p*) :title)))))
