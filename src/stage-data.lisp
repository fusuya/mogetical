
(defparameter *appear-enemy-rate-list*
  '((:slime . 100) (:orc . 90) (:brigand . 80) (:hydra . 70) (:goron . 60)
    (:warrior . 50) (:sorcerer . 40) (:priest . 40) (:archer . 50) (:thief . 40)
    (:knight . 30) (:pknight . 30) (:dragon . 10)))


;;アイテムリストの確率部分を20以上のモノを1下げる
(defun rate-decf (rate-lst)
  (loop :for i :in rate-lst
     :collect (if (> (cdr i) 20)
		  (cons (car i) (decf (cdr i)))
		  i)))

;;絵画進むごとに敵が強い武器装備する確率を上げる
(defun adjust-enemy-equip-rate ()
  (setf *warrior-weapon*  (rate-decf *warrior-weapon*)
	*sorcerar-weapon* (rate-decf *sorcerar-weapon*)
	*priest-weapon*   (rate-decf *priest-weapon*)
	*thief-weapon*    (rate-decf *thief-weapon*)
	*archer-weapon*   (rate-decf *archer-weapon*)
	*knight-weapon*   (rate-decf *knight-weapon*)))


(defun adjust-appear-enemy ()
  (setf (appear-enemy-rate *donjon*)
	(rate-decf (appear-enemy-rate *donjon*))))

;;出現する敵 階層によって出現率を変える
(defun appear-enemy (donjon)
  (weightpick (appear-enemy-rate donjon)))

;;階層+-２
(defun set-enemy-level ()
  (max 1
       (+ (stage *donjon*) (if (= (random 2) 0)
			       (random 3) (- (random 3))))))

;;敵生成時に装備してる武器
(defun enemy-equip-weapon (e-type job)
  (case e-type
    ((:slime :orc :brigand :hydra :dragon :yote1 :goron)
     (job-init-weapon job))
    (:warrior
     (item-make  (weightpick *warrior-weapon*)))
    (:sorcerer
     (item-make  (weightpick *sorcerar-weapon*)))
    (:priest
     (item-make  (weightpick *priest-weapon*)))
    (:thief
     (item-make  (weightpick *thief-weapon*)))
    (:archer
     (item-make  (weightpick *archer-weapon*)))
    ((:knight :pknight)
     (item-make  (weightpick *knight-weapon*)))))

;;敵生成時に装備する防具
(defun enemy-equip-armor ()
  (item-make (weightpick *armor-list*)))


;;レヴェルアップ時ステータス上昇
(defun status-up (atker)
  (let ((lvup-rate (get-job-data (job atker) :lvuprate)))
    (when (>= (getf lvup-rate :hp) (random 100))
      (incf (maxhp atker))
      (setf (hp atker) (maxhp atker)))
    (when (>= (getf lvup-rate :str) (random 100))
      (incf (str atker)))
    (when (>= (getf lvup-rate :vit) (random 100))
      (incf (vit atker)))
    (when (>= (getf lvup-rate :int) (random 100))
      (incf (int atker)))
    (when (>= (getf lvup-rate :res) (random 100))
      (incf (res atker)))
    (when (>= (getf lvup-rate :agi) (random 100))
      (incf (agi atker)))))


(defun create-enemy (e-type e-pos hp str def int res agi expe job)
  (let* ((level (set-enemy-level))
	 (e (make-instance 'unit :posx (* (car e-pos) *obj-w*)
			  :name (nth (random (length *name-list*)) *name-list*) 
			  :posy (* (cadr e-pos) *obj-h*) :level level
			  :x (car e-pos) :y (cadr e-pos)
			  :atk-spd 10 :buki (enemy-equip-weapon e-type job)
			  :armor (enemy-equip-armor)
			  :moto-w *obj-w* :moto-h *obj-h*
			  :str str :vit def :hp hp :maxhp hp :int int :res res
			  :expe (+ expe level) :agi agi
			  :w *obj-w* :h *obj-h*
			  :w/2 (floor *obj-w* 2) :h/2 (floor *obj-h* 2)
			  :obj-type e-type :img-h job
			  :team :enemy :job job
			  :img 1)))
    (dotimes (i (level e))
      (status-up e))
    e))

;;プレイヤーのいる階層で敵の強さが変わる hp str def int res agi expe job
(defun create-enemies (e-pos e-type)
  (case e-type
    (:slime    (create-enemy e-type e-pos 6  1  1 1  1  1   3  +job_slime+))
    (:orc      (create-enemy e-type e-pos 10 4  1 1  1  2   5  +job_orc+))
    (:brigand  (create-enemy e-type e-pos 6  2  2 7  4  3   7  +job_brigand+ ))
    (:hydra    (create-enemy e-type e-pos 12 2  5 2  3  3  10  +job_hydra+ ))
    (:dragon   (create-enemy e-type e-pos 20 5  6 5  6  5  20  +job_dragon+ ))
    (:yote1    (create-enemy e-type e-pos 3  3 50 3 50 33 300  +job_yote1+ ))
    (:goron    (create-enemy e-type e-pos 5  2  3 3  3  3   4  +job_goron+ ))
    (:warrior  (create-enemy e-type e-pos 10 4  5 1  2  2   8  +job_warrior+))
    (:sorcerer (create-enemy e-type e-pos 5  1  2 7  5  1   8  +job_sorcerer+))
    (:priest   (create-enemy e-type e-pos 5  1  4 4  8  3   8  +job_priest+))
    (:thief    (create-enemy e-type e-pos 6  3  3 3  3  9   8  +job_thief+ ))
    (:archer   (create-enemy e-type e-pos 5  3  3 3  3  3   8  +job_archer+ ))
    (:knight   (create-enemy e-type e-pos 12 6  4 3  5  3   8  +job_s_knight+ ))
    (:pknight  (create-enemy e-type e-pos 10 7  2 3  2  2   8  +job_p_knight+ ))
    ))

;;範囲内ランダム初期位置
(defun get-init-pos (epos xmin xmax ymin ymax)
  (let* ((x (+ xmin (random (1+ (- xmax xmin)))))
	 (y (+ ymin (random (1+ (- ymax ymin)))))
	 (pos  (list x y) ))
    (if (or (= (aref (field *donjon*) y x) +kaidan+)
	    (find pos epos :test #'equal))
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
		  (e (create-enemies pos e-type)))
	     (push pos e-position) ;;かぶらないように記憶しておく
	     (setf (cell e) (aref field (y e) (x e)))
		   ;;(aref field (y e) (x e)) :e)
	     (push e enemies))))))

;;階段セット
(defun set-kaidan (donjon)
  (with-slots (field kaidan-init-pos kaidan) donjon
    (let* ((xmin (getf kaidan-init-pos :xmin)) (xmax (getf kaidan-init-pos :xmax))
	   (ymin (getf kaidan-init-pos :ymin)) (ymax (getf kaidan-init-pos :ymax)))
      (destructuring-bind (x y)
	  (get-init-pos nil xmin xmax ymin ymax)
	(setf (aref field y x) +kaidan+
	      kaidan (list x y))))))

;;宝箱セット
(defun set-chest (donjon)
  (with-slots (field chest-init-pos chest-max chest) donjon
    (let* ((xmin (getf chest-init-pos :xmin)) (xmax (getf chest-init-pos :xmax))
	   (ymin (getf chest-init-pos :ymin)) (ymax (getf chest-init-pos :ymax))
	   (chest-pos nil))
      (dotimes (i (+ (random chest-max) 2))
	(destructuring-bind (x y)
	    (get-init-pos chest-pos xmin xmax ymin ymax)
	  (push (make-instance 'obj :x x :y y :posx (* x *obj-w*) :posy (* y *obj-h*)
			       :img +chest+)
		chest)
	  (push (list x y) chest-pos))))))


;;ドロップアイテムセット
(defun adjust-drop-item-rate (donjon)
  (with-slots (stage drop-item) donjon
    ;;(when (= (floor stage 2) 0)
      (setf drop-item
	    (rate-decf drop-item))))

(defun create-stage (&optional (num nil))
  (let* ((num (if num num (random (length *stage-list*))))
	 (stage (copy-tree (nth num *stage-list*))))
    (setf (field *donjon*) (make-array (list 15 15) :initial-contents (getf stage :field))
	  (player-init-pos *donjon*) (getf stage :player-init-pos)
	  (enemy-init-pos *donjon*)  (getf stage :enemy-init-pos)
	  (kaidan-init-pos *donjon*) (getf stage :kaidan-init-pos)
	  (chest-init-pos *donjon*)  (getf stage :chest-init-pos)
	  (chest-max *donjon*)       (getf stage :chest-max)
	  (donjonnum *donjon*)       num
	  (chest *donjon*)           nil
	  (enemies *donjon*)         nil)
    (set-kaidan *donjon*)
    (set-chest *donjon*)
    (set-enemies *donjon*)))
