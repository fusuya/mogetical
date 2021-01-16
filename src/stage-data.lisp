
;;出現する敵 階層によって出現率を変える
(defun appear-enemy (donjon)
  (let* ((m (random 101))
	 (slime-rate-max (- 70 (* (stage donjon) 3))) ;;70
	 (orc-rate-min   (1+ slime-rate-max))
	 (orc-rate-max   (+ (- 30 (stage donjon)) orc-rate-min))
	 (bri-rate-min (1+ orc-rate-max))
	 (bri-rate-max (+ 10 (stage donjon) bri-rate-min))
	 (hydra-rate-min (1+ bri-rate-max))
	 (hydra-rate-max (+ 10 (stage donjon) hydra-rate-min))
	 (dragon-rate-min (1+ hydra-rate-max))
	 (dragon-rate-max (+ 10 (stage donjon) dragon-rate-min)))
    ;;(format t "slime:~d~%orc~d~%bri:~d~%hydra:~d~%dragon:~d~%"
	;;    slime-rate-max orc-rate-max bri-rate-max hydra-rate-max dragon-rate-max)
    (cond
      ((>= 1 m 0) :yote1)
      ((>= slime-rate-max m 2) :slime)
      ((>= orc-rate-max m orc-rate-min) :orc)
      ((>= bri-rate-max m bri-rate-min) :brigand)
      ((>= hydra-rate-max m hydra-rate-min) :hydra)
      ((>= dragon-rate-max m dragon-rate-min) :dragon)
      (t :slime))))

(defun create-enemy (e-type e-pos hp str def expe ido-spd img-h)
  (make-instance 'unit :posx (* (car e-pos) *obj-w*)
		 :name (nth (random (length *name-list*)) *name-list*) 
		 :posy (* (cadr e-pos) *obj-h*) :level str
		 :x (car e-pos) :y (cadr e-pos)
		 :atk-spd 10 :buki (weapon-make (aref *weapondescs* +w_wood_sword+))
		 :moto-w *obj-w* :moto-h *obj-h*
		 :str str :vit def :hp hp :maxhp hp
		 :ido-spd ido-spd :expe expe
		 :w *obj-w* :h *obj-h*
		 :w/2 (floor *obj-w* 2) :h/2 (floor *obj-h* 2)
		 :obj-type e-type :img-h img-h
		 :movecost (movecost (nth 0 *jobdescs*))
		 :move (move (nth 0 *jobdescs*))
		 :team :enemy
		 :img 1))

;;プレイヤーのいる階層で敵の強さが変わる
(defun create-enemies (e-pos e-type p)
  (case e-type
    (:slime   (create-enemy e-type e-pos
			    (+ 6 (floor (random (stage p)) 2))
			    (+ 1 (floor (random (stage p)) 2))
			    (+ 1 (floor (random (stage p)) 2))
			    (+ 3 (floor (random (stage p)) 3))
			    1 +slime-anime+))
    (:orc     (create-enemy e-type e-pos
			    (+ 10 (floor (random (stage p)) 2))
			    (+ 4 (floor (random (stage p)) 1.3))
			    (+ 1 (floor (random (stage p)) 1.4))
			    (+ 5 (floor (random (stage p)) 2))
			    1 +orc-anime+ ))
    (:brigand (create-enemy e-type e-pos
			    (+ 6 (floor (random (stage p)) 1.2))
			    (+ 2 (floor (random (stage p)) 2))
			    (+ 2 (floor (random (stage p)) 2))
			    (+ 7 (floor (random (stage p)) 2))
			    1 +brigand-anime+ ))
    (:hydra   (create-enemy e-type e-pos
			    (+ 12 (floor (random (stage p)) 1))
			    (+ 2 (floor (random (stage p)) 2))
			    (+ 5 (floor (random (stage p)) 1.3))
			    (+ 10 (floor (random (stage p)) 2))
			    1 +hydra-anime+ ))
    (:dragon  (create-enemy e-type e-pos
			    (+ 20 (floor (random (stage p)) 1.4))
			    (+ 5 (floor (random (stage p)) 1.3))
			    (+ 6 (floor (random (stage p)) 1.3))
			    (+ 20 (floor (random (stage p)) 2))
			    2 +dragon-anime+ ))
    (:yote1   (create-enemy e-type e-pos 3 3 50 300 20 +yote-anime+ ))))

;;範囲内ランダム初期位置
(defun get-init-pos (epos xmin xmax ymin ymax)
  (let ((pos  (list (+ xmin (random (1+ (- xmax xmin))))
		    (+ ymin (random (1+ (- ymax ymin)))))))
    (if (find pos epos :test #'equal)
	(get-init-pos epos xmin xmax ymin ymax)
	pos)))

;;敵を配置する
(defun set-enemies (donjon)
  (with-slots (enemy-init-pos enemies field stage) donjon
    (let ((enemy-num (min (length enemy-init-pos) (+ 3 (random (+ 3 (floor stage 5)))))) ;;1フロアに出る敵の数
	  (e-position nil)
	  (xmin (getf enemy-init-pos :xmin)) (xmax (getf enemy-init-pos :xmax))
	  (ymin (getf enemy-init-pos :ymin)) (ymax (getf enemy-init-pos :ymax)))
      (loop
	 :for i :from 0 :to enemy-num
	 :do
	   (let* ((e-type (appear-enemy donjon))
		  (pos (get-init-pos e-position xmin xmax ymin ymax))
		  (e (create-enemies pos e-type donjon)))
	     (push pos e-position) ;;かぶらないように記憶しておく
	     (setf (cell e) (aref field (y e) (x e)))
		   ;;(aref field (y e) (x e)) :e)
	     (push e enemies))))))

;;階段セット
(defun set-kaidan (donjon)
  (with-slots (field kaidan-init-pos) donjon
    (let* ((xmin (getf kaidan-init-pos :xmin)) (xmax (getf kaidan-init-pos :xmax))
	   (ymin (getf kaidan-init-pos :ymin)) (ymax (getf kaidan-init-pos :ymax)))
      (destructuring-bind (x y)
	  (get-init-pos nil xmin xmax ymin ymax)
	(setf (aref field y x) +kaidan+)))))

;;宝箱セット
(defun set-chest (donjon)
  (with-slots (field chest-init-pos chest-max chest) donjon
    (let* ((xmin (getf chest-init-pos :xmin)) (xmax (getf chest-init-pos :xmax))
	   (ymin (getf chest-init-pos :ymin)) (ymax (getf chest-init-pos :ymax))
	   (chest-pos nil))
      (dotimes (i (+ (random chest-max) 10))
	(destructuring-bind (x y)
	    (get-init-pos chest-pos xmin xmax ymin ymax)
	  (push (make-instance 'obj :x x :y y :posx (* x *obj-w*) :posy (* y *obj-h*)
			       :img +chest+)
		chest)
	  (push (list x y) chest-pos))))))


;;ドロップアイテムセット
(defun set-drop-item (donjon)
  (with-slots (stage drop-item) donjon
    (cond
      ((>= 10 stage) (setf drop-item (copy-tree *drop1-10*))))))

(defun create-stage ()
  (let ((stage (copy-tree (nth (random (length *stage-list*)) *stage-list*))))
    (setf (field *donjon*) (make-array (list 15 15) :initial-contents (getf stage :field))
	  (player-init-pos *donjon*) (getf stage :player-init-pos)
	  (enemy-init-pos *donjon*)  (getf stage :enemy-init-pos)
	  (kaidan-init-pos *donjon*) (getf stage :kaidan-init-pos)
	  (chest-init-pos *donjon*)  (getf stage :chest-init-pos)
	  (chest-max *donjon*)       (getf stage :chest-max)
	  (drop-item *donjon*)       nil
	  (chest *donjon*)           nil
	  (enemies *donjon*)         nil)
    (set-drop-item *donjon*)
    (set-chest *donjon*)
    (set-kaidan *donjon*)
    (set-enemies *donjon*)))
