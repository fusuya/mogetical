;;TODO 武器と防具のリスト分けるか



(defun delete-font ()
  (delete-object *font140*)
  (delete-object *font90*)
  (delete-object *font70*)
  (delete-object *font40*)
  (delete-object *font30*)
  (delete-object *font20*)
  (delete-object *font2*))

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
  (delete-object *job-monsters*)
  (delete-object *arrow-img*)
  (delete-object *waku-img*)
  (delete-object *waku2-img*)
  (delete-object *waku-aka*)
  (delete-object *waku-ao*)
  (delete-object *job-img*)
  (delete-object *buki-img*))



(defun init-mouse-button ()
  (with-slots (left right) *mouse*
    (setf left nil
	  right nil)))

(defun init-keystate ()
  (with-slots (left right down up z x c enter shift) *keystate*
    (setf left nil right nil down nil up nil z nil x nil c nil enter nil shift nil)))





;;ゲーム初期化
(defun init-game ()
  (setf *p* (make-instance 'player :item nil :state :title :starttime (get-internal-real-time)) ;;*test-buki-item*)
	*backup-player-data* (make-instance 'player)
	*mouse* (make-instance 'mouse)
	*bgm* *titlebgm*
        *donjon* (make-instance 'donjon :drop-item  (create-drop-item-list (list *sword-list* *spear-list* *ax-list* *rod-list* *staff-list* *bow-list* *clothes-list* *shield-list*))
				:appear-enemy-rate (copy-tree *appear-enemy-rate-list*)
				:stage 1));;(car *stage-list*)) ;;(nth (length *stage-list*) *stage-list*))
  (init-weapon-list)
  (init-bgm)
  (create-stage)
  ;;(set-test-item-list)
  
  (init-keystate))


;;次のステージデータ生成
(defun set-next-stage ()
  (setf (save *p*) nil)
  (incf (stage *donjon*))
  (if (= (stage *donjon*) 101) ;;100界でｵﾜﾘ
      (setf (endtime *p*) (get-internal-real-time)
	    (state *p*) :ending)
      (progn (adjust-appear-enemy)
	     (adjust-drop-item-rate *donjon*)
	     (adjust-enemy-equip-rate)
	     (create-stage))))



;つつけるようにプレイヤーデータを保存しておく
(defun save-player-data (moto saki)
  (with-slots (party cursor item bgm item-page getitem turn prestate state) moto
    (setf (party saki) (loop :for p :in party
			  :collect (shallow-copy-object p))
	  (item saki) (loop :for i :in item
			 :collect (shallow-copy-object i))
	  (item-page saki) 0
	  (turn saki) :ally
	  (prestate saki) prestate
	  (state saki) state)))

(defun save-donjon-data ()
  )



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




;;bgm 
(defun set-bgm (&optional (new-alias nil))
  (cond
    ((or (equal *bgm* new-alias)
	 (and (eq (state *p*) :battle)
	      (find *bgm* *battle-bgm-list* :test #'equal)))
     (let ((st (bgm-status *bgm*)))
       (when (equal st "stopped")
	 (bgm-play *bgm*))))
    (t
     (when (eq (state *p*) :battle)
       (setf new-alias (nth (random (length *battle-bgm-list*)) *battle-bgm-list*)))
     (bgm-stop *bgm*)
     (setf *bgm* new-alias)
     (bgm-play *bgm*))))



;;ユニットとユニットの距離
(defun unit-dist (unit1 unit2)
  (+ (abs (- (x unit1) (x unit2)))
     (abs (- (y unit1) (y unit2)))))

;;ダメージ計算
(defmethod damage-calc (atker defender)
  (with-slots (buki str int) atker
    (cond
      ;;回復
      ((eq (atktype buki) :heal)
       (+ (int atker) (random (damage buki))))
      ;;ブロック
      ((< (random 100) (blk (armor defender)))
       0)
      ;;地形回避
      ((< (random 100) (get-cell-data (cell defender) :avoid))
       0)
      (t
       (let* ((atkhosei (if (eq (categoly buki) :wand) int str))
	      (defhosei (if (eq (categoly buki) :wand) (res defender) (vit defender)))
	      (tokkou-dmg (if (find (job defender) (tokkou buki)) 1.5 1))
	      (cri (if (> (critical buki) (random 100)) 1.3 1))
	      (atkdmg (if buki (+ (* (damage buki) tokkou-dmg cri) atkhosei) atkhosei))
	      
	      (def1 (if (armor defender) (+ (def (armor defender)) defhosei)
			defhosei))
	      (base-dmg (- (floor atkdmg 2) (floor (+ def1 (get-cell-data (cell defender) :def)) 4)))
	      (rand-dmg (1+ (floor base-dmg 16))))
	 (if (= (random 2) 0)
	     (max 1 (+ base-dmg rand-dmg))
	     (max 1 (- base-dmg rand-dmg))))))))



;;経験値取得
(defun player-get-exp (atker defender)
  (incf (expe atker) (expe defender))
  (loop while (>= (expe atker) (lvup-exp atker))
     do
       (sound-play *lvup-wav*)
       (status-up atker)
       (incf (level atker))
       (setf (expe atker) (- (expe atker) (lvup-exp atker)))
       (incf (lvup-exp atker) 5)))

;;ダメージ表示要obj
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
      (setf (state defender) :dead)
      (player-get-exp atker defender))))






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
(defun update-damage-fonts (def)
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

;;攻撃効果音
(defun play-atk-sound (unit)
  (sound-play 
   (case (categoly (buki unit))
     (:sword   *sword-wav*)
     (:ax      *ax-wav*)
     (:spear   *spear-wav*)
     (:bow     *bow-wav*)
     (:wand    *wand-wav*)
     (:knuckle *knuckle-wav*)
     (:staff   *heal-wav*))))

;;攻撃アニメ終わるまでループ
(defun update-atk-anime (atk hwnd &key (def nil))
  (play-atk-sound atk)
  (loop
     :for i :from 0 :to 23
     :do
       (when (= 7 i)
	 (set-damage atk def))
       ;;(incf (atk-c atk))
       (update-atk-img atk i)
       (when def
	 (update-damage-fonts def))
       (invalidate-rect hwnd nil nil)
       (update-window hwnd))
  (when def
    (delete-damage-font def)))



;;自身を回復した時のフォント
(defun update-heal-font (atk hwnd)
  (set-damage atk atk)
  (loop :for i :from 0 :to 18
     :do (update-damage-fonts atk)
       (invalidate-rect hwnd nil nil)
       (update-window hwnd))
  (delete-damage-font atk))



(defun gameover? ()
  (every #'(lambda (x) (eq (state x) :dead)) (party *p*)))

;;移動後に攻撃できる敵ゲット
(defun get-can-atk-enemy-after-move (unit enemies)
  (with-slots (buki) unit
    (let ((x (x unit)) (y (y unit)))
      (loop
	 :for e :in enemies
	 :do (let ((ex (x e)) (ey (y e)))
	       (when (>= (rangemax buki) (+ (abs (- ex x)) (abs (- ey y))) (rangemin buki))
		 (push e (canatkenemy unit))))))))


;;敵に攻撃可能な場所を探す
(defun get-can-atk-enemy (unit targets)
  (loop
     :for e :in targets
     :do
       (cond
	 ((or (and (not (eq (state e) :dead))
		   (>= (rangemax (buki unit)) (unit-dist unit e) (rangemin (buki unit))))
	      (and (= (unit-dist unit e) 0)
		   (eq (atktype (buki unit)) :heal)))
	  (setf (atkedarea e) (list (x unit) (y unit)))
	  (push e (canatkenemy unit)))
	 (t
	  (loop
	     :for area :in (movearea unit)
	     :do (let ((x (car area)) (y (cadr area))
		       (ex (x e)) (ey (y e)))
		   (if (and (not (eq (state e) :dead))
			    (>= (rangemax (buki unit)) (+ (abs (- ex x)) (abs (- ey y))) (rangemin (buki unit))))
		       (progn (setf (atkedarea e) area)
			      (push e (canatkenemy unit))
			      (return))
		       (setf (atkedarea e) nil))))))))

;;ユニットの移動可能範囲取得
(defun can-move-area (unit x y move movecost i enemies allies)
  (when (and (>= (1- *yoko-block-num*) x 0) (>= (1- *tate-block-num*) y 0))
    (let* ((cell (aref (field *donjon*) y x))
           (cost (if (= i 0) 0 (aref movecost cell)))
	   (enemy (find-if #'(lambda (p) (and (= x (x p)) (= y (y p)))) enemies))
	   (ally (find-if #'(lambda (p) (and (= x (x p)) (= y (y p)))) allies)))
      (when (and (>= move cost) (>= cost 0)
                 (or (null enemy)
		     (eq (state enemy) :dead))) ;;死んでる敵の上は移動できる
	(when (and (not (find (list x y) (movearea unit) :test #'equal))
		   (or (null ally)
		       (eq (state ally) :dead)))
	  (push (list x y) (movearea unit)))
        (loop for v in '((0 1) (0 -1) (1 0) (-1 0))
              do
              (can-move-area unit (+ x (car v)) (+ y (cadr v))
                             (- move cost) movecost (1+ i) enemies allies))))))

;;atk可能なユニットをゲット
(defun get-can-atk-target (unit allies enemies)
  (cond
    ((eq (atktype (buki unit)) :atk)
     (get-can-atk-enemy unit enemies))
    ((eq (atktype (buki unit)) :heal)
     (get-can-atk-enemy unit allies))))

;;ユニットの移動可能範囲取得
(defun get-move-area (select-unit enemies allies)
  (let* ((move (get-job-data (job select-unit) :move))
	 (x (x select-unit)) (y (y select-unit))
	 (movecost (get-job-data (job select-unit) :movecost)))
    (can-move-area select-unit x y move movecost 0 enemies allies)
    (get-can-atk-target select-unit allies enemies)))
















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


;;ダンジョンのキャラ初期位置セット
(defun set-chara-init-position ()
  (with-slots (player-init-pos field) *donjon*
    (let ((num 0))
      (loop
	 ;;:for chara :in (party *p*)
	 :for posy :from (getf player-init-pos :ymin) :to (getf player-init-pos :ymax)
	 :do (loop :for posx :from (getf player-init-pos :xmin) :to (getf player-init-pos :xmax)
		:do (let ((chara (nth num (party *p*))))
		      (setf (x chara) posx
			    (y chara) posy
			    (posx chara) (* (x chara) *obj-w*)
			    (posy chara) (* (y chara) *obj-h*)
			    (cell chara) (aref field (y chara) (x chara)))
		      (incf num)
		      (when (= num (length (party *p*)))
			(return-from set-chara-init-position))))
		      ;;(setf (aref field (y chara) (x chara)) :p)
	   ))))


;;全滅したとこから再戦 backupから*p*にコピーする
;;ステージデータは新しく作る
(defun continue-game ()
  (save-player-data *backup-player-data* *p*)
  (create-stage)
  (set-chara-init-position))


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



;;タイトル画面とクリア画面での操作
(defun update-title-and-ending-gamen (hwnd)
  (with-slots (left x y) *mouse*
    (set-bgm *titlebgm*)
    (when left
      (cond
	((and (>= *title-start-x2* x *title-start-x1*)
	      (>= *title-start-y2* y *title-start-y1*))
	 (sound-play *select-wav*)
	 (start-game))
	((and (>= *title-end-x2* x *title-end-x1*)
	      (>= *title-end-y2* y *title-end-y1*))
	 (sound-play *select-wav*)
	 (send-message hwnd (const +wm-close+) nil nil))))))

;;コンテニュー画面
(defun update-gameover-gamen (hwnd)
  (with-slots (left x y) *mouse*
    (when left
      (cond
	((and (>= *title-start-x2* x *title-start-x1*)
	      (>= *title-start-y2* y *title-start-y1*))
	 (sound-play *select-wav*)
	 (start-game))
	((and (>= *continue-x2* x *continue-x1*)
	      (>= *continue-y2* y *continue-y1*))
	 (sound-play *select-wav*)
	 (continue-game))
	((and (>= *title-end-x2* x *title-end-x1*)
	      (>= *title-end-y2* y *title-end-y1*))
	 (sound-play *select-wav*)
	 (send-message hwnd (const +wm-close+) nil nil))))))



;;キャラクターを追加
(defun push-chara-init-party (num)
  (when (> 5 (length (party *p*)))
    (let* ((weapon (job-init-weapon num))
	   (armor (item-make (aref *weapondescs* +a_clothes+)))
	   (chara (make-instance 'unit :job num :hp 30 :maxhp 30
				 :buki weapon :vit 3 :str 7 :agi 2 :res 3 :int 3
				 :armor armor :state :action
				 :team :ally :w 32 :h 32 :moto-w 32 :moto-h 32
				 :name (nth (random (length *name-list*)) *name-list*)
				 :img-h num)))
      (setf (equiped weapon) (name chara)
	    (equiped armor)  (name chara)
	    (party *p*) (append (party *p*) (list chara)))
      (push weapon (item *p*))
      (push armor (item *p*)))))

;;キャラクターをパーティから削除
(defun delete-chara-init-party (mouse)
  (let* ((x (- mouse 7))
	 (d (nth x (party *p*))))
    (setf (party *p*)
	  (remove d (party *p*) :test #'equal))))



;;初期パーティ編成画面
(defun update-init-party-edit-gamen ()
  (with-slots (left right) *mouse*
    (set-bgm *editbgm*)
    (when (or left right)
      (let ((mouse (party-edit-gamen-mouse-pos)))
	(cond
	  ((null mouse))
	  ((and left (= mouse 12) (>= 5 (length (party *p*)) 1))
	   (sound-play *select-wav*) 
	   (setf (state *p*) :battle-preparation)
	   (set-chara-init-position))
	  ((and right (>= 11 mouse 7)) (delete-chara-init-party mouse))
	  ((and left (>= 6 mouse))
	   (sound-play *select-wav*) 
	   (push-chara-init-party mouse)))))))


;;出撃準備画面 マウスアクション
(defun update-battle-preparation ()
  (set-bgm *prebattle*)
  (when (null (save *p*)) ;;プレイヤーデータセーブ
    (setf (save *p*) t)
    (save-player-data *p* *backup-player-data*))
  (with-slots (left right selected x y) *mouse*
    (cond
      ;;出撃ボタン
      ((and left ;;(null selected)
	    (>= *battle-btn-x2* x *battle-btn-x1*)
	    (>= *battle-btn-y2* y *battle-btn-y1*))
       (sound-play *select-wav*) 
       (setf (prestate *P*) :battle-preparation
	     (state *p*) :battle
	     selected nil))
      ;;装備変更ボタン
      ((and left selected
	    (>= *w-change-btn-y2* y *w-change-btn-y1* )
	    (>= *w-change-btn-x2* x *w-change-btn-x1* ))
       (sound-play *select-wav*) 
       (setf (prestate *P*) :battle-preparation
	     (state *p*) :weaponchange))
      ((and left ;;選択中のキャラがいない時
	    (null selected))
       (loop :for p :in (party *p*)
	  :do (when (and (>= (+ (posx p) *obj-w*) x (posx p))
			 (>= (+ (posy p) *obj-h*) y (posy p)))
		(sound-play *select-wav*) 
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
      ((>= diffx 1)
       (setf (dir selected) :left))
      ((<= diffx -1)
       (setf (dir selected) :right))
      ((and (>= diffy 1)
	    (= diffx 0))
       (setf (dir selected) :up))
      ((and (<= diffy -1)
	    (= diffx 0))
       (setf (dir selected) :down)))))

;;相手ユニットがいて移動できないcellリストを返す
(defun get-block-cell (enemies)
  (mapcar #'(lambda (u) (list (x u) (y u)))
              (remove-if #'(lambda (u) (eq (state u) :dead))
			 enemies)))


;;goalまでの道順ゲット
(defun get-move-path (start goal movecost enemies)
  (let* ((block-cell (get-block-cell enemies))
	 (cost) (paths))
    (setf (values cost paths)
	  (astar start goal (field *donjon*) movecost block-cell))
    paths))


;;移動アニメーション
(defun move-anime (unit goal enemies hwnd)
  ;;(with-slots (selected) *mouse*
    (let* ((x (x unit)) (y (y unit))
	   (start (list x y))
	   (paths (get-move-path start goal (get-job-data (job unit) :movecost) enemies)))
      (loop :for path :in paths
	 :do (let* ((goalposx (* (car path) *obj-w*))
		    (goalposy (* (cadr path) *obj-h*)))
	       (sound-play *move-wav*) 
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
	   (sound-play *select-wav*)
	   (setf (selected *mouse*) p)
	   (get-move-area (selected *mouse*) (enemies *donjon*) (party *p*))
	   (return))))

;;敵を選択したか
(defun select-enemy? (x y)
  (loop :for p :in (enemies *donjon*)
     :when (and (>= (+ (posx p) *obj-w*) x (posx p))
		(>= (+ (posy p) *obj-h*) y (posy p))
		(eq (state p) :action))
     :do (setf (selected *mouse*) p)
       (get-move-area (selected *mouse*) (party *p*) (enemies *donjon*))
       (return)))

;;階段に止まったか
(defun stop-kaidan (x y)
  (eq (aref (field *donjon*) y x) +kaidan+))


;;宝箱にとまったか
(defun chest-check (unit)
  (loop :for item :in (chest *donjon*)
     :do (when (and (= (x item) (x unit))
		    (= (y item) (y unit)))
	   (sound-play *chest-wav*) 
	   ;;プレイヤーのアイテムリストに追加
	   (let* ((item-data (if (> (random 5) 3)
				 (aref *weapondescs* +w_potion+)
				 (aref *weapondescs* (weightpick (drop-item *donjon*)))))
		  (new-item (item-make item-data)))
	     (setf (new new-item) t
		   (getitem *p*) (make-instance 'itemtext :name (name new-item)
						:posx (- (posx unit)
						      (* (length (name new-item)) 10))
						:posy (posy unit)
						:maxy (- (posy unit) 20)))
	     
	     (push new-item (item *p*))
	     ;;宝箱消す
	     (setf (chest *donjon*) (remove item (chest *donjon*) :test #'equal))
	     (return)))))

;;次のステージ行く前の処理 
(defun reset-unit-data ()
  (loop :for p :in (party *p*)
     :do (when (eq (state p) :dead)
	   (setf (hp p) 1))
       (setf (canatkenemy p) nil
	     (movearea p) nil
	     (atkedarea p) nil
	     (state p) :action))
     ;;死んだユニット復活
       
  (setf (selected *mouse*) nil
	(state *p*) :battle-preparation))


;;アイテムを使用したら消す bukiをコブシにする
(defun delete-use-item (unit)
  (with-slots (buki) unit
    (when (eq (categoly buki) :item)
      (setf (item *p*) (remove buki (item *p*) ::test #'equal)
	    buki (item-make (aref *weapondescs* +w_knuckle+))))))


;;選択キャラ解除
(defun clear-selected-unit (selected)
  (when (eq (state selected) :moved)
    (setf (state selected) :end))
  (setf (canatkenemy selected) nil
	(movearea selected) nil))

;;移動して攻撃 e:対象
(defun move-and-atk (e hwnd)
  (with-slots (selected) *mouse*
    (cond
      ((equal e selected) ;;自分自身を回復
       (sound-play *heal-wav*) 
       (update-heal-font selected hwnd)
       (delete-use-item selected)
       (setf (state selected) :end
	     (canatkenemy selected) nil
	     (movearea selected) nil
	     selected nil
	     (atkedarea e) nil))
      (e
       (when (movearea selected) ;;移動
	 (move-anime selected (atkedarea e) (enemies *donjon*) hwnd)
	 (setf (x selected) (car (atkedarea e))
	       (y selected) (cadr (atkedarea e))
	       (cell selected) (aref (field *donjon*) (y selected) (x selected)))
	 (chest-check selected))
       (set-atk-unit-dir selected e)
       (update-atk-anime selected hwnd :def e)
       (delete-use-item selected)
       (setf (state selected) :end
	     (canatkenemy selected) nil
	     (movearea selected) nil
	     selected nil
	     (atkedarea e) nil)))))


;;ユニットの状態を行動可にする
(defun init-action (units)
  (loop :for u :in units
     :unless (eq (state u) :dead)
     :do (setf (state u) :action)))



;;砦回復
(defun turn-end-heal (units)
  (loop :for u :in units
     :when (eq (cell u) +fort+)
     :do (incf (hp u) (floor (* (/ (maxhp u) 100) (get-cell-data (cell u) :heal))))
       (when (> (hp u) (maxhp u))
	 (setf (hp u) (maxhp u)))))

;;バトル中のマウスアクション
(defun update-battle-ally-mouse-act (hwnd)
  (with-slots (left right selected x y) *mouse*
    (cond
      ;;装備変更ボタン
      ((and left selected (eq (team selected) :ally)
	    (>= *w-change-btn-y2* y *w-change-btn-y1* )
	    (>= *w-change-btn-x2* x *w-change-btn-x1* ))
       (setf (prestate *p*) :battle
	     (state *p*) :weaponchange))
      ;;ターン終了ボタン
      ((and left ;;(or (null selected) (eq (team selected) :enemy))
	    (>= *turn-end-x2* x *turn-end-x1*)
	    (>= *turn-end-y2* y *turn-end-y1*))
       (when selected
	 (clear-selected-unit selected)
	 (setf selected nil))
       (turn-end-heal (party *p*))
       (setf (turn *p*) :enemy)
       (init-action (party *p*)))
      ((and right ;;選択してるキャラ解除
	    selected)
       (clear-selected-unit selected)
       (setf selected nil))
      ((and left ;;選択中のキャラがいない時ユニットをsekectedにセット
	    (null selected))
       (select-ally? x y)
       (select-enemy? x y))
      ((and left ;;敵を選択中に他のとこをクリック
	    selected
	    (eq (team selected) :enemy))
       (select-ally? x y)
       (select-enemy? x y))
      ((and selected ;;選択中のプレイヤーキャラがいるとき
	    (eq (team selected) :ally)
	    left)
       (let* ((x1 (floor x *obj-w*))
	      (y1 (floor y *obj-h*))
	      (xy (list x1 y1))
	      (p1 (find-if #'(lambda (p) (and (= x1 (x p)) (= y1 (y p)))) (party *p*)))
	      (e  (find-if #'(lambda (p) (and (= x1 (x p)) (= y1 (y p)))) (enemies *donjon*))))
	 (cond
	   ((and p1 (eq (state p1) :action) (eq (atktype (buki selected)) :atk))
	    (clear-selected-unit selected)
	    (sound-play *select-wav*)
	    (setf selected p1)
	    (get-move-area p1 (enemies *donjon*) (party *p*)))
	   ;;移動だけ
	   ((and (or (null p1)
		     (eq (state p1) :dead))
		 (find xy (movearea selected) :test #'equal))
	    (move-anime selected xy (enemies *donjon*) hwnd)
	    (setf (x selected) x1
		  (y selected) y1
		  (cell selected) (aref (field *donjon*) y1 x1)
		  (canatkenemy selected) nil
		  (movearea selected) nil)
	    (if (stop-kaidan x1 y1) ;;階段にとまったら次のステージへ
		(progn (reset-unit-data)
		       (set-next-stage)
		       (set-chara-init-position))
		(progn
		  (chest-check selected)
		  (get-can-atk-target selected (party *p*) (enemies *donjon*))
		  (if (null (canatkenemy selected))
		      (setf (state selected) :end
			    selected nil)
		      (setf (state selected) :moved)))))
	   ;;移動して攻撃
	   ((find e (canatkenemy selected) :test #'equal)
	    (move-and-atk e hwnd))
	   ((find p1 (canatkenemy selected) :test #'equal)
	    (move-and-atk p1 hwnd))
	   (e
	    (clear-selected-unit selected)
	    (sound-play *select-wav*)
	    (setf selected e)
	    (get-move-area e (party *p*) (enemies *donjon*)))))))))




;;バトル中 全員行動済みなら敵のターンへ
(defun update-battle-ally (hwnd)
  (if (every #'(lambda (p) (or (eq (state p) :end)
			       (eq (state p) :dead))) (party *p*))

      (when (null (getitem *p*))
	(turn-end-heal (party *p*))
	(setf (turn *p*) :enemy))
	;;(init-action (enemies *donjon*)))
      (update-battle-ally-mouse-act hwnd)))







;;unitに一番近いキャラ
(defun near-chara (unit cells targets func pred)
  (let ((movecost (get-job-data (job unit) :movecost))
	(start (list (x unit) (y unit)))) ;;自分の位置
    (first
     (sort (remove-if (lambda (u)
			(let* ((goal (list (x u) (y u)))
			       (block-cell (remove goal (get-block-cell targets)
						   :test #'equal)))
			  (or (eq (state u) :dead) ;;deadウニっと除外
			      ;;多取り付けないウニっと除外
			      (equal "hoge" (astar start goal cells movecost block-cell)))))
			      
			      ;;(> r-min (unit-dist unit u))))) ;;最小射程以下の敵消す
		      targets)
	   pred
	   :key func))))

;;敵の攻撃
(defun enemy-attack (unit target hwnd)
  (set-atk-unit-dir unit target)
  (update-atk-anime unit hwnd :def target))


;;目標に一番近くなる移動可能な場所までの道を返す 最大射程になるように
(defun get-goal-to-near-target (unit target r-min r-max cells movecost block-cell)
  (when (movearea unit)
    (let* ((goal (list (x target) (y target)))
	   (area (sort (remove-if #'(lambda (x) (equal "hoge" (astar goal x cells movecost block-cell)))
				  (movearea unit))
		       #'<
		       :key #'(lambda (x) (astar goal x cells movecost block-cell)))))
      (or (find r-max area :key #'(lambda (x) (manhatan goal x)))
	  (find r-min area :key #'(lambda (x) (manhatan goal x)))
	  (first area)))))
    

;;敵の移動
(defun enemy-move (unit target r-min r-max enemies cells hwnd)
  (let ((shin-goal nil)
	;;(goal (list (x target) (y target)))
	(block-cell (get-block-cell enemies)))
    (get-move-area unit (party *p*) (enemies *donjon*))
    (setf shin-goal
	  (get-goal-to-near-target unit target r-min r-max cells (get-job-data (job unit) :movecost) block-cell))
    (if shin-goal
	(move-anime unit shin-goal (party *p*) hwnd)
	(setf shin-goal (list (x unit) (y unit)))) ;;移動先がなかったら元に位置
    (setf (movearea unit) nil
	  (canatkenemy  unit) nil
	  (x unit) (car shin-goal)
	  (y unit) (cadr shin-goal)
	  (cell unit) (aref (field *donjon*) (y unit) (x unit)))))

;;攻撃or回復する相手を取得
(defun get-target (atker)
  (with-slots (buki) atker
    (cond
      ((eq (atktype buki) :heal)
       (near-chara atker (field *donjon*) (enemies *donjon*) #'(lambda (x)
								 (- (maxhp x) (hp x))) #'>))
      (t
       (near-chara atker (field *donjon*) (party *p*) #'(lambda (x)
							  (unit-dist atker x)) #'<)))))


;;敵の行動 攻撃範囲に相手ユニットがいたら攻撃する
(defun enemy-act (hwnd)
  (loop :for u :in (enemies *donjon*)
     :when (eq (state u) :action)
     :do
       (let* ((r-min (rangemin (buki u)))
	      (r-max (rangemax (buki u)))
	      (target (get-target u))
	      (dist (unit-dist u target)))
	 (if (or (>= r-max dist r-min) ;;攻撃範囲に相手がいる
		 (and (eq (atktype (buki u)) :heal) ;;ヒーラー
		      (>= r-max dist 0)))
	     (enemy-attack u target hwnd)
	     (progn ;;移動後に攻撃範囲に相手がいたら攻撃
	       (enemy-move u target r-min r-max (party *p*) (field *donjon*) hwnd)
	       (setf target (get-target u)) ;;移動後ターゲット再設定
	       (when (or (>= r-max (unit-dist u target) r-min)
			 (and (eq (atktype (buki u)) :heal) ;;ヒーラー
			      (>= r-max dist 0)))
		 (enemy-attack u target hwnd))))
	 (setf (movearea u) nil
	       (canatkenemy u) nil
	       (atkedarea u) nil
	       (state u) :end)
	 (when (gameover?)
	   (setf (state *p*) :dead)
	   (return)))))


;;敵の行動
(defun update-battle-enemy (hwnd)
  ;;(if (find :action (enemies *donjon*) :key #'state)
  (enemy-act hwnd)
  (turn-end-heal (enemies *donjon*))
  (setf (turn *p*) :ally)
  (init-action (enemies *donjon*))
  (init-action (party *p*)))
  

;;ゲットしたアイテムのテキスト動かす
(defun update-get-item-text ()
  (with-slots (getitem) *p*
    (when getitem
      (decf (posy getitem) 1)
      (when (> (maxy getitem) (posy getitem))
	(setf getitem nil)))))


;;バトル更新
(defun update-battle (hwnd)
  (set-bgm)
  (if (eq (turn *p*) :ally)
      (update-battle-ally hwnd)
      (update-battle-enemy hwnd))
  (update-get-item-text)
  (delete-enemies ))


;;選択したアイテムを装備
(defun equip-item (item)
  (with-slots (selected) *mouse*
    (when (and (null (equiped item))
	       (find (categoly item) (get-job-data (job selected) :canequip) :test #'equal))
      (setf (equiped item) (name selected))
      (cond
	((eq (type-of item) 'weapondesc)
	 (when (buki selected)
	   (setf (equiped (buki selected)) nil))
	 (setf (buki selected) item))
	((eq (type-of item) 'armordesc)
	 (when (armor selected)
	   (setf (equiped (armor selected)) nil))
	 (setf (armor selected) item))))))

;;武器変更画面のマウスアクション
(defun update-weapon-change ()
  (with-slots (left right selected x y) *mouse*
    (let ((itemmax (floor (length (item *p*)) *item-show-max*))
	  (select-item (get-item-mouse-pos)))
      (when select-item
	(setf (new select-item) nil))
      (cond
	;;捨てる
	((and right select-item (null (equiped select-item)))
	 (setf (item *p*) (remove select-item (item *p*) :test #'equal)))
	(right
	 (setf (canatkenemy selected) nil
	       (movearea selected) nil
	       selected nil
	       (state *p*) (prestate *p*)))
	((and left ;;決定ボタン
	      (>= *item-decision-x2* x *item-decision-x1*)
	      (>= *item-decision-y2* y *item-decision-y1*))
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
	 (when select-item
	   (equip-item select-item)))))))



	  

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
    (:dead
     (update-gameover-gamen hwnd))
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
       (select-object *hogememdc* *hogebitmap*))
     (set-bk-mode *hmemdc* :transparent))
    ((const +wm-paint+)
     (with-paint (hwnd hdc)
       (render-game hdc)))
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
     (bgm-stop (bgm *p*))
     (close-bgms)
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
