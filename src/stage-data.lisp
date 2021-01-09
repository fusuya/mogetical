
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
		 :atk-spd 10 :buki (weapon-make (aref *weapondescs* +w_knuckle+ ))
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

;;敵を配置する
(defun set-enemies (donjon)
  (with-slots (enemy-init-pos enemies field) donjon
    (let ((enemy-num (min (length enemy-init-pos) (+ 3 (random (+ 3 (floor (stage donjon) 5))))))) ;;1フロアに出る敵の数
      (loop
	 :for i :from 0 :to enemy-num
	 :for pos :in enemy-init-pos
	 :do
	   (let* ((e-type (appear-enemy donjon))
		  (e (create-enemies pos e-type donjon)))
	     (setf (cell e) (aref field (y e) (x e)))
		   ;;(aref field (y e) (x e)) :e)
	     (push e enemies))))))


(defun create-stage ()
  (let ((stage (copy-tree (nth (random (length *stage-list*)) *stage-list*))))
    (setf (field *donjon*) (getf stage :field)
	  (player-init-pos *donjon*) (getf stage :player-init-pos)
	  (enemy-init-pos *donjon*) (getf stage :enemy-init-pos))
    (set-enemies *donjon*)))
