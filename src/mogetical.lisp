;;TODO 武器と防具のリスト分けるか

;;ブラシ生成
(defun set-brush ()
  (setf *brush* (make-array 7 :initial-contents
                              (list
                                (create-solid-brush (encode-rgb 128 0 255))
                                (create-solid-brush (encode-rgb 255 0 0))
                                (create-solid-brush (encode-rgb 1 255 0))
                                (create-solid-brush (encode-rgb 0 0 255))
                                (create-solid-brush (encode-rgb 255 255 0))
                                (create-solid-brush (encode-rgb 0 255 255))
                                (create-solid-brush (encode-rgb 255 0 255))))))

(defun set-font ()
  (setf *font140* (create-font "MSゴシック" :height 140)
	*font90* (create-font "MSゴシック" :height 90)
	*font70* (create-font "MSゴシック" :height 70)
        *font40* (create-font "MSゴシック" :height 40)
	*font30* (create-font "MSゴシック" :height 30)
        *font20* (create-font "MSゴシック" :height 25 :width 12 :weight (const +fw-bold+))))

(defun delete-font ()
  (delete-object *font140*)
  (delete-object *font90*)
  (delete-object *font70*)
  (delete-object *font40*)
  (delete-object *font30*)
  (delete-object *font20*))

(defun delete-object-array (arr)
  (loop for i across arr
     do (delete-object i)))

(defun delete-brush ()
  (delete-object-array *brush*))

(defun delete-images ()
  (delete-object *p-img*)
  (delete-object *objs-img*)
  (delete-object *p-atk-img*)
  (delete-object *hammer-img*)
  (delete-object *anime-monsters-img*)
  (delete-object *arrow-img*)
  (delete-object *waku-img*)
  (delete-object *waku-ao*)
  (delete-object *buki-img*))

(defun load-images ()
  (setf *objs-img* (load-image "../img/new-objs-img.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*class-img*  (load-image "../img/class.bmp" :type :bitmap
			                         :flags '(:load-from-file :create-dib-section))
      	*arrow-img* (load-image "../img/arrow.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*p-img* (load-image "../img/p-ido-anime.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*p-atk-img* (load-image "../img/p-atk-anime.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*hammer-img* (load-image "../img/hammer-anime.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*anime-monsters-img* (load-image "../img/monsters.bmp" :type :bitmap
      					 :flags '(:load-from-file :create-dib-section))
      	*buki-img* (load-image "../img/buki-anime.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*waku-img* (load-image "../img/waku.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*waku-ao* (load-image "../img/aowaku.bmp" :type :bitmap
			      :flags '(:load-from-file :create-dib-section))
	*waku-aka* (load-image "../img/akawaku.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*waku2-img* (load-image "../img/hoge.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))))

(defun init-mouse-button ()
  (with-slots (left right) *mouse*
    (setf left nil
	  right nil)))

(defun init-keystate ()
  (with-slots (left right down up z x c enter shift) *keystate*
    (setf left nil right nil down nil up nil z nil x nil c nil enter nil shift nil)))


;;ゲーム初期化
(defun init-game ()
  (setf *p* (make-instance 'player :item *test-buki-item*)
	*mouse* (make-instance 'mouse)
        *donjon* (make-instance 'donjon));;(car *stage-list*)) ;;(nth (length *stage-list*) *stage-list*))
  (create-stage)
  (set-test-item-list)
  (init-keystate))

;;効果音ならす
(defun sound-play (path)
  (play-sound path '(:filename :async)))


;;キー押したとき
(defun moge-keydown (hwnd wparam)
  (with-slots (left right down up z x c enter shift) *keystate*
    (let ((key (virtual-code-key wparam)))
      (case key
        (:left (setf left t))
	      (:shift (setf shift t))
        (:right (setf right t))
        (:down (setf down t))
        (:up (setf up t))
        (:return (setf enter t))
        (:keyz (setf z t))
        (:keyx (setf x t))
	      (:keyc (setf c t))
        (:keyq ;; quit
          (send-message hwnd (const +wm-close+) nil nil))))))

;;キー話したとき
(defun moge-keyup (wparam)
  (with-slots (left right down up z x c enter shift) *keystate*
    (let ((key (virtual-code-key wparam)))
      (case key
        (:left (setf left nil))
	(:shift (setf shift nil))
        (:right (setf right nil))
        (:down (setf down nil))
        (:up (setf up nil))
        (:return (setf enter nil))
        (:keyx (setf x nil))
	(:keyc (setf c nil))
        (:keyz (setf z nil))))))




;;時間変換
(defun get-hms (n)
  (multiple-value-bind (h m1) (floor n 3600000)
    (multiple-value-bind (m s1) (floor m1 60000)
      (multiple-value-bind (s ms1) (floor s1 1000)
	(multiple-value-bind (ms) (floor ms1 10)
	  (values h m s ms))))))

;;1以上のランダムな数
(defun randval (n)
  (1+ (random n)))

(defun rand+- (n)
  (let ((a (1+ (random n))))
    (if (= (random 2) 1)
	a
	(- a))))

;;'(:up :down :right :left)
(defun rand-dir (lst new-lst)
  (if (null lst)
      new-lst
      (let ((hoge (nth (random (length lst)) lst)))
	(rand-dir (remove hoge lst) (cons hoge new-lst)))))






;;ボスを倒したら
(defun go-ending ()
  (setf (state *p*) :ending
	(endtime *p*) (get-internal-real-time)))

;;プレイヤーとフロアにあるアイテムの当たり判定
(defun player-hit-item (p)
  (with-slots (items stage) *donjon*
    (let ((item (find (pos p) items :key #'pos :test #'equal)))
      (setf (door p) nil)
      (when item
	(cond
	  ((= (img item) +potion+)
	   (sound-play *get-potion-wav*)
	   (incf (potion p))
	   (setf (items *donjon*)
		 (remove item (items *donjon*) :test #'equal)))
	  ((= (img item) +sword+)
	   (with-slots (buki-lv buki-exp) p
	     (sound-play *get-item-wav*)
	     (setf (items *donjon*)
		   (remove item (items *donjon*) :test #'equal))
	     (incf  buki-exp (* (level item) 2))
	     (when (>= buki-exp 100)
	       (incf buki-lv)
	       (decf buki-exp 100)))) ;;武器の攻撃力は１づつ上がる))
	  ((= (img item) +armour+)
	   (with-slots (armour-lv armour-exp) p
	     (sound-play *get-item-wav*)
	     (setf (items *donjon*)
		   (remove item (items *donjon*) :test #'equal))
	     (incf  armour-exp (* (level item) 2))
	     (when (>= armour-exp 100)
	       (incf armour-lv)
	       (decf armour-exp 100)))) ;;武器の攻撃力は１づつ上がる))
	  ((= (img item) +hammer+)
	   (sound-play *get-item-wav*)
	   (incf (hammer p))
	   (setf (items *donjon*)
		 (remove item (items *donjon*) :test #'equal)))
	  ((= (img item) +arrow+)
	   (sound-play *get-item-wav*)
	   (incf (arrow-num p))
	   (setf (items *donjon*)
		 (remove item (items *donjon*) :test #'equal)))
	  ((= (img item) +orb+)
	   (incf (orb p))
	   (sound-play *get-orb*)
	   (setf (items *donjon*)
		 (remove item (items *donjon*) :test #'equal)))
	  ((= (img item) +door+)
	   (setf (door p) t)
	   (when (enter *keystate*)
	     (setf (door p) nil)
	     (sound-play *door-wav*)
	     (if (= (orb p) 1)
		 (if (= stage 1)
		     (go-ending)
		     (decf stage))
		 (incf stage))
	     (maze *donjon* p))))))))


;;武器のステータス取得
(defun get-item-abi (weapon ablility)
  (cond
    ((null weapon)
     "なし")
    (t
     (case ablility
       (:name     (name     (aref *weapondescs* weapon)))
       (:rangemin (rangemin (aref *weapondescs* weapon)))
       (:rangemax (rangemax (aref *weapondescs* weapon)))
       (:def      (def      (aref *weapondescs* weapon)))
       (:hit      (hit      (aref *weapondescs* weapon)))
       (:critical (critical (aref *weapondescs* weapon)))
       (:damage   (damage   (aref *weapondescs* weapon)))
       (:blk      (blk      (aref *weapondescs* weapon)))))))



;;ダメージ計算
(defmethod damage-calc (atker defender)
  (with-slots (buki str) atker
    (cond
      ((eq (atktype buki) :heal)
       (damage buki))
      (t 
       (let* ((atkdmg (if buki (+ (damage buki) str) str))
	      (def1 (if (armour defender) (+ (def (armour defender)) (vit defender))
			(vit defender)))
	      (base-dmg (- (floor atkdmg 2) (floor def1 4)))
	      (rand-dmg (1+ (floor base-dmg 16))))
	 (if (= (random 2) 0)
	     (max 1 (+ base-dmg rand-dmg))
	     (max 1 (- base-dmg rand-dmg))))))))


;;レヴェルアップ時ステータス上昇
(defun status-up (atker)
  (incf (maxhp atker) (1+ (random 3)))
  (incf (str atker) (random 3))
  (incf (def atker) (random 3)))

;;経験値取得
(defun player-get-exp (atker defender)
  (when (eq 'player (type-of atker))
    (incf (expe atker) (expe defender))
    (sound-play *lvup-wav*)
    (loop while (>= (expe atker) (lvup-exp atker))
       do
	 (status-up atker)
	 (incf (level atker))
	 (setf (expe atker) (- (expe atker) (lvup-exp atker)))
	 (incf (lvup-exp atker) 20))))

;;ダメージ表示
(defun add-damage-font (atker defender)
  (with-slots (x y posx posy obj-type hp atk-spd) defender
    (let* ((dmg-x (+ posx 10))
	   (dmg-y (+ posy 15))
	   (dmg-num (damage-calc atker defender))
	   (x-dir (if (eq (dir atker) :left) :left :right))
	   (dmg (make-instance 'dmg-font :posx dmg-x :posy dmg-y
			       :dmg-num  dmg-num :y-dir :up :x-dir x-dir
			       :maxy dmg-y :miny (- dmg-y 15))))
      (if (eq (atktype (buki atker)) :heal)
	  (progn (incf (hp defender) dmg-num)
		 (when (> (hp defender) (maxhp defender))
		   (setf (hp defender) (maxhp defender)))
		 (setf (color dmg) (encode-rgb 0 254 0)))
	  (progn (decf (hp defender) dmg-num);;hpを減らす
		 (setf (color dmg) (encode-rgb 255 255 255))))
      (setf (dmg defender) dmg)))) ;;ダメージを表示するためのもの

;;ダメージ計算して表示する位置とか設定
(defun set-damage (atker defender)
  (with-slots (x y pos obj-type hp atk-spd) defender
    (add-damage-font atker defender)
    (when (>= 0 (hp defender)) ;; hpが0以下になったら死亡
      (setf (state defender) :dead))))
      ;;(player-get-exp atker defender))))






;;ダメージフォントの位置更新
(defun update-damage-font (e)
  (with-slots (dmg) e
    (when dmg
      (cond
	((eq :up (y-dir dmg))
	 (if (eq (x-dir dmg) :right)
	     (incf (posx dmg))
	     (decf (posx dmg)))
	 (decf (posy dmg) 2)
	 (when (<= (posy dmg) (miny dmg))
	   (setf (y-dir dmg) :down)))
	((eq :down (y-dir dmg))
	 (if (eq (x-dir dmg) :right)
	     (incf (posx dmg))
	     (decf (posx dmg)))
	 (incf (posy dmg) 2)
	 (when (>= (posy dmg) (maxy dmg))
	   (setf dmg nil)))))))

;;ダメージフォントの位置更新
(defun update-damage-fonts (atk def)
  ;;(when (zerop (mod (atk-c atk) 3))
    (update-damage-font def))


(defun delete-damage-font (def)
  (setf (dmg def) nil))


;;攻撃した時の移動アニメーション計算
(defun update-atk-img-pos (atk-pos i)
  (cond
    ((>= 11 i)
     (+ atk-pos 2))
    ((>= i 12)
     (- atk-pos 2))))

;;攻撃移動更新
(defun update-atk-img (p i)
  (case (dir p)
    (:right(setf (posx p) (update-atk-img-pos  (posx p) i)))
    (:left (setf (posx p) (- (update-atk-img-pos (- (posx p)) i))))
    (:down (setf (posy p) (update-atk-img-pos (posy p) i )))
    (:up   (setf (posy p) (- (update-atk-img-pos (- (posy p)) i))))))


;;攻撃アニメ終わるまでループ
(defun update-atk-anime (atk hwnd &key (def nil))
  (loop
     :for i :from 0 :to 23
     :do
       (when (= 7 i)
	 (set-damage atk def))
       ;;(incf (atk-c atk))
       (update-atk-img atk i)
       (when def
	 (update-damage-fonts atk def))
       (invalidate-rect hwnd nil nil)
       (update-window hwnd))
  (when def
    (delete-damage-font def)))


(defun update-heal-font (atk hwnd)
  (set-damage atk atk)
  (loop :for i :from 0 :to 18
     :do (update-damage-fonts atk atk)
       (invalidate-rect hwnd nil nil)
       (update-window hwnd))
  (delete-damage-font atk))


;;隣に敵がいるか調べる
(defun check-neighbour (p e)
  (let ((dir (mapcar #'- (pos p) (pos e))))
    (cond
      ((equal dir '(1 0))
       :left)
      ((equal dir '(-1 0))
       :right)
      ((equal dir '(0 1))
       :up)
      ((equal dir '(0 -1))
       :down))))






;;移動可能場所生成
(defun where-to-go-next (e)
  (loop :for nextpos :in '((0 1) (0 -1) (1 0) (-1 0) (0 0))
     :unless (hit-hantei (mapcar #'+ (pos e) nextpos) :walls t :blocks t :enemies t)
     :collect nextpos))



;;移動後に攻撃できる敵ゲット
(defun get-can-atk-enemy-after-move (unit enemies)
  (with-slots (buki) unit
    (let ((x (x unit)) (y (y unit)))
      (loop
	 :for e :in enemies
	 :do (let ((ex (x e)) (ey (y e)))
	       (when (= (rangemax buki) (+ (abs (- ex x)) (abs (- ey y))) (rangemin buki))
		 (push e (canatkenemy unit))))))))


;;敵に攻撃可能な場所を探す
(defun get-can-atk-enemy (unit targets)
  (loop
     :for e :in targets
     :do
       (cond
	 ((>= (rangemax (buki unit)) (unit-dist unit e) (rangemin (buki unit)))
	  (setf (atkedarea e) (list (x unit) (y unit)))
	  (push e (canatkenemy unit)))
	 (t
	  (loop
	     :for area :in (movearea unit)
	     :do (let ((x (car area)) (y (cadr area))
		       (ex (x e)) (ey (y e)))
		   (when (>= (rangemax (buki unit)) (+ (abs (- ex x)) (abs (- ey y))) (rangemin (buki unit))) ;;1は武器のレンジに切り替える
		     (setf (atkedarea e) area)
		     (push e (canatkenemy unit)))))))))

;;ユニットの移動可能範囲取得
(defun can-move-area (unit x y move movecost i enemies allies)
  (when (and (>= (1- *map-w*) x 0) (>= (1- *map-h*) y 0))
    (let* ((cell (aref (field *donjon*) y x))
           (cost (if (= i 0) 0 (aref movecost cell)))
	   (enemy (find-if #'(lambda (p) (and (= x (x p)) (= y (y p)))) enemies))
	   (ally (find-if #'(lambda (p) (and (= x (x p)) (= y (y p)))) allies)))
	     
      (when (and (>= move cost) (>= cost 0)
                 (null enemy))
		 ;; (and (> i 0)
		 ;;      (null ally)))
                 ;;    (= team (unit-team unit?))))
	(when (and (not (find (list x y) (movearea unit) :test #'equal))
		   (null ally))
	  (push (list x y) (movearea unit)))
        (loop for v in '((0 1) (0 -1) (1 0) (-1 0))
              do
              (can-move-area unit (+ x (car v)) (+ y (cadr v))
                             (- move cost) movecost (1+ i) enemies allies))))))

;;ユニットの移動可能範囲取得
(defun get-move-area (select-unit enemies allies)
  (let* ((move (move select-unit)) (x (x select-unit))
	 (y (y select-unit)) 
	 (movecost (movecost select-unit)))
    (can-move-area select-unit x y move movecost 0 enemies allies)
    (cond
      ((eq (atktype (buki select-unit)) :atk)
       (get-can-atk-enemy select-unit enemies))
      ((eq (atktype (buki select-unit)) :heal)
       (get-can-atk-enemy select-unit allies)))))



;;アイテムリストからマウス位置のアイテムを帰す
(defun get-item-mouse-pos ()
  (with-slots (x y) *mouse*
    (cond
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item1-y2* y *item1-y1*))
       (nth (+ 0 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item2-y2* y *item2-y1*))
       (nth (+ 1 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item3-y2* y *item3-y1*))
       (nth (+ 2 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item4-y2* y *item4-y1*))
       (nth (+ 3 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item5-y2* y *item5-y1*))
       (nth (+ 4 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item6-y2* y *item6-y1*))
       (nth (+ 5 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item7-y2* y *item7-y1*))
       (nth (+ 6 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item8-y2* y *item8-y1*))
       (nth (+ 7 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item9-y2* y *item9-y1*))
       (nth (+ 8 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item10-y2* y *item10-y1*))
       (nth (+ 9 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item11-y2* y *item11-y1*))
       (nth (+ 10 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item12-y2* y *item12-y1*))
       (nth (+ 11 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item13-y2* y *item13-y1*))
       (nth (+ 12 (* (item-page *p*) *item-show-max*)) (item *p*)))
      ((and 
	    (>= *item-x2* x *item-x1*)
	    (>= *item14-y2* y *item14-y1*))
       (nth (+ 13 (* (item-page *p*) *item-show-max*)) (item *p*)))
      )))





;;宝箱
(defun chest-drop-item ()
  (let* ((n (random 12)))
    (cond
      ((>= 1 n 0) +arrow+)
      ((>= 4 n 2)  +potion+)
      ((>= 7 n 5) +armour+)
      ((>= 10  n 8) +sword+)
      ((>=  n 11) +hammer+))))

;;スライムのドロップ品
(defun slime-drop-item ()
  (when (> 1 (random 10))
    +potion+))
;;ブリガンドのドロップ品
(defun brigand-drop-item ()
  (when (> (random 10) 4)
    +arrow+))

(defun orc-drop-item ()
  (let ((n (random 7)))
    (case n
      (0 +armour+)
      (1 +sword+))))

(defun hydra-drop-item ()
  (let ((n (random 7)))
    (case n
      (0 +armour+)
      (1 +potion+))))

(defun dragon-drop-item ()
  (let ((n (random 7)))
    (case n
      (0 +armour+)
      (1 +sword+)
      (2 +potion+)
      )))

;;通常のドロップアイテム
(defun normal-drop-item ()
  (let* ((n (random 100)))
    (cond
      ((>= 9 n 0) +arrow+)
      ((>= 20 n 10)  +potion+)
      ((>= 36 n 26) +hammer+)
      ((>= 51  n 46) +sword+)
      ((>= 57  n 52) +armour+)
      (t nil))))

;;アイテム落ちそうな場所
(defun can-drop-pos (pos)
  (loop :for n :in *droppos*
     :for new = (mapcar #'+ pos n)
     :unless (hit-hantei new :blocks t :walls t :player t :items t)
     :collect new))

;;アイテムの靴を落とす
(defun enemy-drop-item (e)
  (let* ((droppos (can-drop-pos (pos e))))
    (when droppos
      (loop
	 :repeat (max 1 (random (length droppos)))
	 :for pos :in droppos
	 :do
	   (let ((item (case (obj-type e)
			 (:slime (slime-drop-item))
			 (:brigand (brigand-drop-item))
			 (:orc (orc-drop-item ))
			 (:chest (chest-drop-item))
			 (:dragon (dragon-drop-item))
			 (:hydra (hydra-drop-item))
			 (otherwise (normal-drop-item)))))
	     (when item
	       (let ((drop-item (make-instance 'obj :img item :level (level e)
					       :pos pos
					       :x (x e) :y (y e) :w 32 :h 32 :w/2 16 :h/2 16
					       :moto-w 32 :moto-h 32 :obj-type item)))
		 (push drop-item (items *donjon*))))
	     (when (eq (obj-type e) :chest)
	       (return)))))))



;;死んだ敵の情報を消す
(defun delete-enemies ()
  (loop for e in (enemies *donjon*)
     do (when (and (null (dmg e))
		   (eq (state e) :dead))
	  ;;(when (eq (obj-type e) :boss)
	  ;;  (go-ending))
	  ;;(enemy-drop-item e)
	  (setf (enemies *donjon*)
		(remove e (enemies *donjon*) :test #'equal)))))


(defun start-name ()
  (setf (state *p*) :name
	(atk-c *p*) 0
	(cursor *p*) 0))


;;ゲームを開始する
(defun start-game ()
  (init-game)
  (setf (state *p*) :initpartyedit))
;; *start-time* (get-internal-real-time)))


(defun update-move-cursor (num)
  (with-slots (up down enter) *keystate*
    (cond
      (up
       (decf (cursor *p*))
       (when (> 0 (cursor *p*))
	 (setf (cursor *p*) (1- num))))
      (down
       (incf (cursor *p*))
       (when (>= (cursor *p*) num)
	 (setf (cursor *p*) 0))))))

;;タイトル画面での操作 330 360
(defun update-title-and-ending-gamen (hwnd)
  (with-slots (left) *mouse*
    (when left
      (case (title-gamen-mouse-pos)
	(1 (start-game))
	(2)
	(3 (send-message hwnd (const +wm-close+) nil nil))))))


;;キャラクターを追加
(defun push-chara-init-party (num)
  (when (> 5 (length (party *p*)))
    (let* ((job (nth num *jobdescs*))
	   (chara (make-instance 'unit :job (id job) :move (move job)
				 :buki (weapon-make (aref *weapondescs* +w_knuckle+ ))
				 :movecost (movecost job) :team :ally
				 :name (nth (random (length *name-list*)) *name-list*)
				 :img (img job))))
      (setf (party *p*) (append (party *p*) (list chara))))))

;;キャラクターをパーティから削除
(defun delete-chara-init-party (mouse)
  (let* ((x (- mouse 7))
	 (d (nth x (party *p*))))
    (setf (party *p*)
	  (remove d (party *p*) :test #'equal))))

;;ダンジョンのキャラ初期位置セット
(defun set-chara-init-position ()
  (with-slots (player-init-pos field) *donjon*
    
    (loop
       :for chara :in (party *p*)
       :for posx :from (getf player-init-pos :xmin) :to (getf player-init-pos :xmax)
       :for posy :from (getf player-init-pos :ymin) :to (getf player-init-pos :ymax)
       :do (setf (x chara) posx
		 (y chara) posy
		 (posx chara) (* (x chara) *obj-w*)
		 (posy chara) (* (y chara) *obj-h*))
	 (setf (cell chara) (aref field (y chara) (x chara)))
	 ;;(setf (aref field (y chara) (x chara)) :p)
	 )))

;;初期パーティ編成画面
(defun update-init-party-edit-gamen ()
  (with-slots (left right) *mouse*
    (when (or left right)
      (let ((mouse (party-edit-gamen-mouse-pos)))
	(cond
	  ((null mouse))
	  ((and left (= mouse 12) (>= 5 (length (party *p*)) 1))
	   (setf (state *p*) :battle-preparation)
	   (set-chara-init-position))
	  ((and right (>= 11 mouse 7)) (delete-chara-init-party mouse))
	  ((and left (>= 6 mouse)) (push-chara-init-party mouse)))))))


;;出撃準備画面 マウスアクション
(defun update-battle-preparation ()
  (with-slots (left right selected x y) *mouse*
    (cond
      ((and left (null selected)
	    (>= *battle-btn-x2* x *battle-btn-x1* ) (>= *battle-btn-y2* y *battle-btn-y1* ))
       (setf (prestate *P*) :battle-preparation
	     (state *p*) :battle
	     selected nil))
      ((and left selected
	    (>= *w-change-btn-y2* y *w-change-btn-y1* )
	    (>= *w-change-btn-x2* x *w-change-btn-x1* ))
       (setf (state *p*) :weaponchange))
      ((and left ;;選択中のキャラがいない時
	    (null selected))
       (loop :for p :in (party *p*)
	  :do (when (and (>= (+ (posx p) *obj-w*) x (posx p))
			 (>= (+ (posy p) *obj-h*) y (posy p)))
		(setf selected p))))
		      ;;(party *p*)
		      ;;(remove p (party *p*) :test #'equal)))))
      ((and selected ;;選択中のキャラがいるとき
	    (eq (team selected) :ally)
	    left)
       (let* ((x1 (floor x *obj-w*))
	     (y1 (floor y *obj-h*))
	     (p1 (find-if #'(lambda (p) (and (= x1 (x p)) (= y1 (y p)))) (party *p*))))
	 (cond
	   (p1 ;;置きたい場所にキャラがいたら交換
	    (setf (x p1) (x selected)
		  (y p1) (y selected)
		  (posx p1) (* (x p1) *obj-w*)
		  (posy p1) (* (y p1) *obj-h*)
		  (posx selected) (* x1 *obj-w*)
		  (posy selected) (* y1 *obj-h*)
		  (x selected) x1
		  (y selected) y1)
	    ;;(push selected (party *p*))
	    (setf selected nil))
	   ((and (>= (getf (player-init-pos *donjon*) :xmax) x1 (getf (player-init-pos *donjon*) :xmin))
		 (>= (getf (player-init-pos *donjon*) :ymax) y1 (getf (player-init-pos *donjon*) :ymin)))
	    (setf (posx selected) (* x1 *obj-w*)
		  (posy selected) (* y1 *obj-h*)
		  (x selected) x1
		  (y selected) y1)
	    (push selected (party *p*))
	    (setf selected nil))))))))
    ;;(when selected
     ;; (setf (posx selected) (floor x)
;;	    (posy selected) (floor y)))))

;;selectedの攻撃方向
(defun set-atk-unit-dir (selected e)
  (let* ((diffx (- (x selected) (x e)))
	 (diffy (- (y selected) (y e))))
    (cond
      ((and (>= diffx 1)
	    (= diffy 0))
       (setf (dir selected) :left))
      ((and (<= diffx -1)
	    (= diffy 0))
       (setf (dir selected) :right))
      ((and (>= diffy 1)
	    (= diffx 0))
       (setf (dir selected) :up))
      ((and (<= diffy -1)
	    (= diffx 0))
       (setf (dir selected) :down)))))


;;goalまでの道順ゲット
(defun get-move-path (start goal movecost enemies)
  (let* ((block-cell (get-enemy-cell enemies))
	 (cost) (paths))
    (setf (values cost paths)
	  (astar start goal (field *donjon*) movecost block-cell))
    paths))


;;移動アニメーション
(defun move-anime (unit goal enemies hwnd)
  ;;(with-slots (selected) *mouse*
    (let* ((x (x unit)) (y (y unit))
	   (start (list x y))
	   (paths (get-move-path start goal (movecost unit) enemies)))
      (loop :for path :in paths
	 :do (let* ((goalposx (* (car path) *obj-w*))
		    (goalposy (* (cadr path) *obj-h*)))
	       (loop :while (or  (/= (posx unit) goalposx)
				 (/= (posy unit) goalposy))
		  :do (let ((diffx (- goalposx (posx unit)))
			    (diffy (- goalposy (posy unit))))
			(cond
			  ((> diffx 0)
			   (incf (posx unit) 4))
			  ((< diffx 0)
			   (decf (posx unit) 4))
			  ((> diffy 0)
			   (incf (posy unit) 4))
			  ((< diffy 0)
			   (decf (posy unit) 4)))
		    (invalidate-rect hwnd nil nil)
		    (update-window hwnd)))))))

;;味方ユニットを選択したか
(defun select-ally? (x y)
  (loop :for p :in (party *p*)
     :do (when (and (>= (+ (posx p) *obj-w*) x (posx p))
		    (>= (+ (posy p) *obj-h*) y (posy p))
		    (eq (state p) :action))
	   (setf (selected *mouse*) p)
	   (get-move-area (selected *mouse*) (enemies *donjon*) (party *p*)))))

;;敵を選択したか
(defun select-enemy? (x y)
  (loop :for p :in (enemies *donjon*)
     :do (when (and (>= (+ (posx p) *obj-w*) x (posx p))
		    (>= (+ (posy p) *obj-h*) y (posy p))
		    (eq (state p) :action))
	   (setf (selected *mouse*) p)
	   (get-move-area (selected *mouse*) (party *p*) (enemies *donjon*)))))


;;バトル中のマウスアクション
(defun update-battle-ally-mouse-act (hwnd)
  (with-slots (left right selected x y) *mouse*
    (cond
      ;;装備変更ボタン
      ((and left selected
	    (>= *w-change-btn-y2* y *w-change-btn-y1* )
	    (>= *w-change-btn-x2* x *w-change-btn-x1* ))
       (setf (prestate *p*) :battle
	     (state *p*) :weaponchange))
      ;;ターン終了ボタン
      ((and left (null selected)
	    (>= 660 x 495) (>= 490 y 450))
       (setf (turn *p*) :enemy)
       (init-action (party *p*)))
      ((and right
	    selected)
       (when (eq (state selected) :moved)
	 (setf (state selected) :end))
       (setf (canatkenemy selected) nil
	     (movearea selected) nil
	      selected nil))
      ((and left ;;選択中のキャラがいない時
	    (null selected))
       (select-ally? x y)
       (select-enemy? x y))
      ((and selected ;;選択中のキャラがいるとき
	    (eq (team selected) :ally)
	    left)
       (let* ((x1 (floor x *obj-w*))
	      (y1 (floor y *obj-h*))
	      (xy (list x1 y1))
	      (p1 (find-if #'(lambda (p) (and (= x1 (x p)) (= y1 (y p)))) (party *p*))))
	 (cond
	   ;;移動だけ
	   ((and (null p1)
		 (find xy (movearea selected) :test #'equal))
	    (move-anime selected xy (enemies *donjon*) hwnd)
	    (setf (x selected) x1
		  (y selected) y1
		  (canatkenemy selected) nil
		  (movearea selected) nil)
	    (get-can-atk-enemy-after-move selected (enemies *donjon*))
	    (if (null (canatkenemy selected))
		(setf (state selected) :end
		      selected nil)
		(setf (state selected) :moved)))
	   ;;移動して攻撃
	   ((canatkenemy selected)
	    (let ((e (find-if #'(lambda (p) (and (= x1 (x p)) (= y1 (y p)))) (canatkenemy selected))))
	      (cond
		((equal e selected)
		 (update-heal-font selected hwnd)
		 (setf (state selected) :end
		       (canatkenemy selected) nil
		       (movearea selected) nil
		       selected nil
		       (atkedarea e) nil))
		(e
		 (when (movearea selected)
		   (move-anime selected (atkedarea e) (enemies *donjon*) hwnd)
		   (setf (x selected) (car (atkedarea e))
			 (y selected) (cadr (atkedarea e))))
		 (set-atk-unit-dir selected e)
		 (update-atk-anime selected hwnd :def e)
		 (setf (state selected) :end
		       (canatkenemy selected) nil
		       (movearea selected) nil
		       selected nil
		       (atkedarea e) nil)))))))))))

;;ユニットの状態を行動可にする
(defun init-action (units)
  (loop :for u :in units
       :do (setf (state u) :action)))

;;バトル中 全員行動済みなら敵のターンへ
(defun update-battle-ally (hwnd)
  (if (every #'(lambda (p) (eq (state p) :end)) (party *p*))
      
      (progn (setf (turn *p*) :enemy)
	     (init-action (enemies *donjon*)))
      (update-battle-ally-mouse-act hwnd)))


;;ユニットとユニットの距離
(defun unit-dist (unit1 unit2)
  (+ (abs (- (x unit1) (x unit2)))
     (abs (- (y unit1) (y unit2)))))

;;相手ユニットがいて移動できないcellリストを返す
(defun get-block-cell (enemies)
  (mapcar #'(lambda (u) (list (x u) (y u)))
              (remove-if #'(lambda (u) (not (eq (state u) :dead)))
			 enemies)))


;;unitに一番近いキャラ
(defun near-chara (unit r-min cells enemies)
  (let ((movecost (movecost unit))
	(start (list (x unit) (y unit)))) ;;自分の位置
    (first
     (sort (remove-if (lambda (u)
			(let* ((goal (list (x u) (y u)))
			       (block-cell (remove goal (get-block-cell enemies)
						   :test #'equal)))
			  (or (eq (state u) :dead)
			      (equal "hoge" (astar start goal cells movecost block-cell))
			      (> r-min (unit-dist unit u))))) ;;最小射程以下の敵消す
		      enemies)
	   #'<
	   :key (lambda (u)
		  (unit-dist unit u))))))

;;敵の攻撃
(defun enemy-attack (unit target hwnd)
  (set-atk-unit-dir unit target)
  (update-atk-anime unit hwnd :def target)
  (setf (state unit) :end))


;;目標に一番近くなる移動可能な場所までの道を返す
(defun get-goal-to-near-target (unit goal cells movecost block-cell)
  (first (sort (movearea unit)
	       #'<
	       :key #'(lambda (x) (astar goal x cells movecost block-cell)))))

;;敵の移動
(defun enemy-move (unit target r-min r-max enemies cells hwnd)
  (let ((shin-goal nil)
	(goal (list (x target) (y target)))
	(block-cell (get-block-cell enemies)))
    (get-move-area unit (party *p*) (enemies *donjon*))
    (setf shin-goal
	  (get-goal-to-near-target unit goal cells (movecost unit) block-cell))
    (move-anime unit shin-goal (party *p*) hwnd)
    (setf (movearea unit) nil
	  (canatkenemy  unit) nil
	  (x unit) (car shin-goal)
	  (y unit) (cadr shin-goal)
	  (state unit) :end)))


;;敵の行動 攻撃範囲に相手ユニットがいたら攻撃する
(defun enemy-act (hwnd)
  (loop :for u :in (enemies *donjon*)
     :when (and (not (eq (state u) :dead))
		(eq (state u) :action))
     :do
       (let* ((r-min (rangemin (buki u)))
	      (r-max (rangemax(buki u)))
	      (target (near-chara u  r-min (field *donjon*) (party *p*)))
	      (dist (unit-dist u target)))
	 (if (>= r-max dist r-min) ;;攻撃範囲に相手がいる
	     (enemy-attack u target hwnd)
	     (progn ;;移動後に攻撃範囲に相手がいたら攻撃
	       ;;(format t "name:~a x:~d y:~d~%" (name u) (x u) (y u))
	       (enemy-move u target r-min r-max (party *p*) (field *donjon*) hwnd)
	      ;; (format t "name:~a x:~d y:~d~%" (name u) (x u) (y u))
	       (setf target (near-chara u r-min (field *donjon*) (party *p*)))
	       (when (>= r-max (unit-dist u target) r-min)
		 (enemy-attack u target hwnd)))))))


;;敵の行動
(defun update-battle-enemy (hwnd)
  (if (find :action (enemies *donjon*) :key #'state)
      (enemy-act hwnd)
      (progn (setf (turn *p*) :ally)
	     (init-action (party *p*)))))


;;バトル更新
(defun update-battle (hwnd)
  (if (eq (turn *p*) :ally)
      (update-battle-ally hwnd)
      (update-battle-enemy hwnd))
  (delete-enemies ))

;;ゲームオーバー判定
(defun game-over? ()
  (when (dead *p*)
    (setf (state *p*) :dead)))

;;選択したアイテムを装備
(defun equip-item (item)
  (with-slots (selected) *mouse*
    (when (null (equiped item))
      (setf (equiped item) (name selected))
      (cond
	((eq (type-of item) 'weapondesc)
	 (when (buki selected)
	   (setf (equiped (buki selected)) nil))
	 (setf (buki selected) item))
	((eq (type-of item) 'armourdesc)
	 (when (armour selected)
	   (setf (equiped (armour selected)) nil))
	 (setf (armour selected) item))))))

;;武器変更画面のマウスアクション
(defun update-weapon-change ()
  (with-slots (left right selected x y) *mouse*
    (let ((itemmax (floor (length (item *p*)) *item-show-max*))
	  (select-item nil))
      (cond
	(right
	 (setf (canatkenemy selected) nil
	       (movearea selected) nil
	       selected nil
	       (state *p*) (prestate *p*)))
	((and left ;;次へボタン
	      (>= *item-next-btn-x2* x *item-next-btn-x1*)
	      (>= *item-next-btn-y2* y *item-next-btn-y1*))
	 (if (= (item-page *p*) itemmax)
	     (setf (item-page *p*) 0)
	     (incf (item-page *p*))))
	((and left ;;前へボタン
	      (>= *item-prev-btn-x2* x *item-prev-btn-x1* )
	      (>= *item-prev-btn-y2* y *item-prev-btn-y1* ))
	 (if (= (item-page *p*) 0)
	     (setf (item-page *p*) itemmax)
	     (decf (item-page *p*))))
	(left
	 (setf select-item (get-item-mouse-pos ))))
      (when select-item
	(equip-item select-item)))))



;;ゲームループ
(defun main-game-loop (hwnd)
  (case (state *p*)
    (:title
     (update-title-and-ending-gamen hwnd))
    (:initpartyedit
     (update-init-party-edit-gamen))
    (:battle-preparation
     (update-battle-preparation))
    (:weaponchange
     (update-weapon-change))
    (:battle
     (update-battle hwnd))
    (:playing
     (with-slots (left right down up z x c shift enter) *keystate*
       (when (or left right down up z x c shift enter)
      	 ;;(update-player *p* hwnd)
      	 ;;(update-enemies hwnd)
      	 ;;(delete-enemies)
      	 ;;(game-over?)
         )))
    (:dead
     (update-title-and-ending-gamen hwnd))
    (:ending
     (update-title-and-ending-gamen hwnd)))
  (init-mouse-button)
  (init-keystate )
  (invalidate-rect hwnd nil nil))

;;ウィンドウサイズ変更時に画像拡大縮小する
(defun change-screen-size (lp)
  (let* ((change-w (loword lp))
	 (change-h (hiword lp)))
    (setf *change-screen-w* change-w
	  *change-screen-h* change-h
	  *mouse-hosei-x* (/ *change-screen-w*  (rect-right *c-rect*))
	  *mouse-hosei-y* (/ *change-screen-h*  (rect-bottom *c-rect*)))))


;;クライアント領域を*client-w* *client-h*に設定
(defun set-client-size (hwnd)
  (let* ((rc (get-client-rect hwnd))
         (rw (get-window-rect hwnd))
         (new-w (+ *client-w* (- (- (rect-right rw) (rect-left rw))
                               (- (rect-right rc) (rect-left rc)))))
         (new-h (+ *client-h* (- (- (rect-bottom rw) (rect-top rw))
                               (- (rect-bottom rc) (rect-top rc))))))
    (set-window-pos hwnd nil 0 0 new-w new-h '(:no-move :no-zorder))))

;;proc
(defwndproc moge-wndproc (hwnd msg wparam lparam)
  (switch msg
    ((const +wm-create+)
     ;; (setf sb-ext:*invoke-debugger-hook*  
     ;;  (lambda (condition hook) 
     ;;    (declare (ignore condition hook))
     ;; 	(destroy-window hwnd)))
     (set-brush)
     (set-font)
     (load-images)
     (init-game)
     ;;(set-client-size hwnd)
     (setf *c-rect* (get-client-rect hwnd))
     ;;(setf *screen-w* (rect-right *c-rect*)
	;;   *screen-h* (rect-bottom *c-rect*))
     ;;(setf *screen-center-x* (+ (rect-right *c-rect*)
     ;;                         (floor (- (rect-left *c-rect*) (rect-right *c-rect*)) 2)))

     ;;(set-layered-window-attributes hwnd (encode-rgb 255 0 0) 0 (const +lwa-colorkey+))
     (with-dc (hdc hwnd)
       (setf *hmemdc* (create-compatible-dc hdc)
             *hbitmap* (create-compatible-bitmap hdc (rect-right *c-rect*) (rect-bottom *c-rect*))
	     *hogememdc* (create-compatible-dc hdc)
             *hogebitmap* (create-compatible-bitmap hdc (rect-right *c-rect*) (rect-bottom *c-rect*)))
       (select-object *hmemdc* *hbitmap*)
       (select-object *hogememdc* *hogebitmap*)))
    ((const +wm-paint+)
     (with-paint (hwnd hdc)
       (render-game hdc hwnd)))
    ((const +wm-size+)
     (change-screen-size lparam))
    ((const +wm-close+)
     (destroy-window hwnd))
    ;;((const +wm-timer+)
    ;; (invalidate-rect hwnd nil nil))
    ((const +wm-lbuttondown+)
     (setf (left *mouse*) t))
    ((const +wm-rbuttondown+)
     (setf (right *mouse*) t))
    ((const +wm-lbuttonup+)
     (setf (left *mouse*) nil))
    ((const +wm-rbuttonup+)
     (setf (right *mouse*) nil))
    ((const +wm-mousemove+)
     (setf (y *mouse*) (/ (hiword lparam) *mouse-hosei-y*)
	   (x *mouse*) (/ (loword lparam) *mouse-hosei-x*)))
    ((const +wm-keydown+)
     (moge-keydown hwnd wparam))
    ((const +wm-keyup+)
     (moge-keyup wparam))
    ((const +wm-destroy+)
     (delete-dc *hmemdc*)
     (delete-object *hbitmap*)
     (delete-dc *hogememdc*)
     (delete-object *hogebitmap*)
     (delete-brush)
     (delete-images)
     (delete-font)
     (post-quit-message)))
  (default-window-proc hwnd msg wparam lparam))


;;メイン
(defun moge ()
  (setf *random-state* (make-random-state t))
  (register-class "MOGE" (callback moge-wndproc)
		  :styles (logior-consts +cs-hredraw+ +cs-vredraw+)
                  :cursor (load-cursor :arrow)
                  :background (create-solid-brush (encode-rgb 0 255 0)))
  (let ((hwnd (create-window "MOGE"
                             :window-name "なぞのゲーム"
                             :ex-styles  (logior-consts +WS-EX-LAYERED+ +ws-ex-composited+) ;;透明
                             :styles (logior-consts +ws-overlappedwindow+ +ws-visible+)
                             :x 400 :y 100 :width *screen-w* :height *screen-h*))
        (msg (make-msg)))
    ;;(init-game)
    (unwind-protect
	 (progn
	   (show-window hwnd)
	   (update-window hwnd)
	   (do ((done nil))
	       (done)
	     (let ((m (ftw:peek-message msg :remove-msg :remove :error-p nil)))
	       (cond
		 (m
		  ;;(let ((r (get-message msg)))
		  (cond
		    ((= (msg-message msg) (const +wm-quit+))
		     (setf done t))
		    (t
		     (translate-message msg)
		     (dispatch-message msg))))
		 (t
		  (sleep 0.01)
		  (main-game-loop hwnd))))))
      (unregister-class "MOGE"))))
