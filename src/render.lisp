




;;transparent-blt
(defun trans-blt (x y w-src h-src w-dest h-dest)
  (transparent-blt *hmemdc* x y *hogememdc* 0 0 :width-source w-src
		   :height-source h-src
		   :width-dest w-dest :height-dest h-dest
		   :transparent-color (encode-rgb 0 255 0)))

(defun new-trans-blt (x y x-src y-src w-src h-src w-dest h-dest)
  (transparent-blt *hmemdc* x y *hogememdc* x-src y-src :width-source w-src
		   :height-source h-src
		   :width-dest w-dest :height-dest h-dest
		   :transparent-color (encode-rgb 0 255 0)))




;;アニメ表示
(defun render-enemy (e)
  (when (null (dead e)) ;;死んでなかったら表示
    (select-object *hogememdc* *anime-monsters-img*)
    (new-trans-blt (posx e) (posy e) (* (moto-w e) (img e)) (* *obj-h* (img-h e))
		   (moto-w e) (moto-h e) (w e) (h e))))

;;敵表示
(defun render-enemies ()
  (loop for e in (enemies *donjon*)
     do (Render-enemy e)))




;;現在の方向
(defun p-dir-num ()
  (case (dir *p*)
    (:up +up+)
    (:down +down+)
    (:left +left+)
    (:right +right+)))

;;攻撃時の描画
(defun render-p-atk (atk-img)
  (with-slots (buki) *p*
    (let ((dir (p-dir-num)))
      (cond
	((eq dir +down+)
	 (select-object *hogememdc* *p-atk-img*)
	 (new-trans-blt (x *p*) (y *p*) (* *p-w* (img *p*)) (* *p-h* dir)
			(moto-w *p*) (moto-h *p*) (w *p*) (h *p*))
	 (select-object *hogememdc* atk-img)
	 (new-trans-blt (x buki) (y buki) (* *p-w* (img *p*)) (* *p-h* dir)
			(moto-w buki) (moto-h buki) (w buki) (h buki)))
	(t
	 (select-object *hogememdc* atk-img)
	 (new-trans-blt (x buki) (y buki) (* *p-w* (img *p*)) (* *p-h* dir)
			(moto-w buki) (moto-h buki) (w buki) (h buki))
	 (select-object *hogememdc* *p-atk-img*)
	 (new-trans-blt (x *p*) (y *p*) (* *p-w* (img *p*)) (* *p-h* dir)
			(moto-w *p*) (moto-h *p*) (w *p*) (h *p*)))))))

;;プレイヤー表示
(defun render-player ()
  (cond
    ;; ((atk-now *p*)
    ;;  (render-p-atk *buki-img*))
    ;; ((hammer-now *p*)
    ;;  (render-p-atk *hammer-img*))
    (t
     (select-object *hogememdc* *p-img*)
     (let ((x (+ (* (car (pos *p*)) *obj-w*) (atk-pos-x *p*)))
	   (y (+ (* (cadr (pos *p*)) *obj-h*) (atk-pos-y *p*))))
       (new-trans-blt x y (* *p-w* (img *p*)) (* *p-h* (p-dir-num))
		      (moto-w *p*) (moto-h *p*) (w *p*) (h *p*))))))


(defun render-arrow ()
  (when (arrow *donjon*)
    (with-slots (arrow) *donjon*
      (select-object *hogememdc* (img-src arrow))
      (new-trans-blt (x arrow) (y arrow) (* *obj-w* (img arrow)) (* *obj-h* (img-h arrow))
		     *obj-w* *obj-h* *obj-w* *obj-h*))))

;;*objs-img*の描画
(defun render-objs-img (x y img)
  (select-object *hogememdc* *objs-img*)
  (new-trans-blt (* x *obj-w*) (* y *obj-h*) (* *obj-w* img) 0
		 *obj-w* *obj-h* *obj-w* *obj-h*))


(defun render-field (&optional battle)
  (when *donjon*
    (with-slots (field player-init-pos) *donjon*
      (let* ((yx (array-dimensions field))
	     (xmin (getf player-init-pos :xmin))
	     (xmax (getf player-init-pos :xmax))
	     (ymin (getf player-init-pos :ymin))
	     (ymax (getf player-init-pos :ymax))
	     (field-ymax (car yx)) (field-xmax (cadr yx)))
	(loop :for y :from 0 :below field-ymax
	   :do (loop :for x :from 0 :below field-xmax
		  :do
		    (render-objs-img x y (aref field y x))
		    (when (and (null battle)
			       (and (>= xmax x xmin)
				    (>= ymax y ymin)))
		      (select-object *hogememdc* *waku-img*)
		      (new-trans-blt (* x *obj-w*) (* y *obj-h*) 0 0
				     128 128 *obj-w* *obj-h*))))))))



;;鍵とか描画
(defun render-items ()
  (loop for obj in (chest *donjon*)
     do (render-objs-img (x obj) (y obj) (img obj))))

;;武器経験値表示
(defun render-bugu-exp (exp num)
  (let* ((len (floor (* (/ exp 100) *bukiexpbar-max*)))
	 (left *map-w*)
	 (bottom num)
	 (top (- bottom 15))
	 (hp-w (+ left len)))
    ;;残りHP
    (select-object *hmemdc* (aref *brush* +green+))
    (rectangle *hmemdc* left top hp-w bottom)
    ;;減ったHP
    (select-object *hmemdc* (aref *brush* +red+))
    (rectangle *hmemdc* hp-w top (+ hp-w (- *bukiexpbar-max* len)) bottom)))








(defun create-render-button (x1 x2 y1 y2 str strx stry &key (font *font40*))
  (select-object *hmemdc* font)
  ;;(set-bk-mode *hmemdc* :transparent)
  (if (and (>= x2 (x *mouse*) x1)
	   (>= y2 (y *mouse*) y1))
      (progn (select-object *hmemdc* (get-stock-object :white-brush))
	     (rectangle *hmemdc* x1 y1 x2 y2)
	     (set-text-color *hmemdc* (encode-rgb 0 0 0)))
      (progn (select-object *hogememdc* *waku-img*)
	     (new-trans-blt x1 y1 0 0 128 128 (- x2 x1) (- y2 y1))
	     (set-text-color *hmemdc* (encode-rgb 255 255 255))))
  (text-out *hmemdc* (format nil "~a" str) strx stry))

(defun create-render-button-no-waku (x1 x2 y1 y2 str strx stry &key (font *font40*))
  (select-object *hmemdc* font)
  ;;(set-bk-mode *hmemdc* :transparent)
  (if (and (>= x2 (x *mouse*) x1)
	   (>= y2 (y *mouse*) y1))
      (progn (select-object *hmemdc* (get-stock-object :white-brush))
	     (rectangle *hmemdc* x1 y1 x2 y2)
	     (set-text-color *hmemdc* (encode-rgb 0 0 0)))
      (progn 
	     (set-text-color *hmemdc* (encode-rgb 255 255 255))))
  (text-out *hmemdc* (format nil "~a" str) strx stry))

;;バックグラウンド
(defun render-background ()
  (select-object *hmemdc* (get-stock-object :black-brush))
  (rectangle *hmemdc* 0 0 *change-screen-w* *change-screen-h*))



;;持っている武器を表示 TODO 
(Defun render-weapon-list ()
  (select-object *hmemdc* *font30*)
  (text-out *hmemdc* "所持品リスト" 60 5)
  (select-object *hogememdc* *waku-img*)
  (new-trans-blt 30 35 0 0 128 128 200 450)
  (create-render-button *item-next-btn-x1* *item-next-btn-x2* *item-next-btn-y1* *item-next-btn-y2*
			"次へ" *item-next-btn-x1* *item-next-btn-y1* :font *font30*)
  (create-render-button *item-prev-btn-x1* *item-prev-btn-x2* *item-prev-btn-y1* *item-prev-btn-y2*
			"前へ" *item-prev-btn-x1* *item-prev-btn-y1* :font *font30*)
  (create-render-button *item-decision-x1* *item-decision-x2* *item-decision-y1*
			*item-decision-y2* "完了" (+ *item-decision-x1* 3)
			*item-decision-y1* :font *font30*)
  (loop ;;:for buki :in (item *p*)
     :for x = 50
     :for y :from 45 :by 30
     :for b :from 0 :below *item-show-max*
     ;;:repeat 10
     :do (let* ((num (+ b (* (item-page *p*) *item-show-max*))))
	   (if (>= num (length (item *P*)))
	       (return)
	       (let ((buki (nth num (item *P*))))
		 (cond
		   ((new buki)
		    (select-object *hmemdc* *font2*)
		    (set-text-color *hmemdc* (encode-rgb 255 255 255))
		    (text-out *hmemdc* "N" 35 y)
		    (text-out *hmemdc* "e" 40 (+ y 8))
		    (text-out *hmemdc* "w" 45 (+ y 16)))
		   ((equiped buki)
		    (select-object *hmemdc* *font20*)
		    (set-text-color *hmemdc* (encode-rgb 255 255 255))
		    (text-out *hmemdc* "E" 34 y)))
		 (create-render-button-no-waku x (+ x 170) y (+ y 25)
					       (name buki) (+ x 4) y :font *font30*))))))


(defun render-selecting-item ()
  (let* ((item (get-item-mouse-pos )))
    (text-out *hmemdc* "選択中のアイテム" 270 250)
    (cond
      ((and item
	    (eq (type-of item) 'weapondesc))
       (text-out *hmemdc* (format nil "名前 : ~a" (name item)) 270 285)
       (text-out *hmemdc* (format nil "攻撃力 : ~a" (damage item)) 270 315)
       (text-out *hmemdc* (format nil "命中 : ~a" (hit item)) 270 350)
       (text-out *hmemdc* (format nil "射程 : ~a～~a" (rangemin item)
				  (rangemax item)) 270 385)
       (text-out *hmemdc* (format nil "装備者 : ~a" (equiped item)) 270 420))
      ((and item
	    (eq (type-of item) 'armourdesc))
       (text-out *hmemdc* (format nil "名前 : ~a" (name item)) 270 285)
       (text-out *hmemdc* (format nil "防御力 : ~a" (def item)) 270 315)
       (text-out *hmemdc* (format nil "ブロック率 : ~a%" (blk item)) 270 350)
       (text-out *hmemdc* (format nil "装備者 : ~a" (equiped item)) 270 385)))))



;;武器変更画面
(defun render-weapon-change-gamen ()
  (render-background )
  (render-weapon-list)
  (with-slots (selected) *mouse*
    (select-object *hmemdc* *font30*)
    (set-text-color *hmemdc* (encode-rgb 255 255 255))
    ;;(set-bk-mode *hmemdc* :transparent)    
    (text-out *hmemdc* (format nil "~aの現在の武器" (name selected)) 270 5)
    (when (buki selected)
      (text-out *hmemdc* (format nil "名前 : ~a" (name (buki selected))) 270 40)
      (text-out *hmemdc* (format nil "攻撃力 : ~a" (damage (buki selected))) 270 70)
      (text-out *hmemdc* (format nil "命中 : ~a" (hit (buki selected))) 270 100)
      (text-out *hmemdc* (format nil "射程 : ~a～~a" (rangemin (buki selected))
				 (rangemax (buki selected))) 270 130))
    (text-out *hmemdc* (format nil "~aの現在の防具" (name selected)) 570 5)
    (when (armour selected)
      (text-out *hmemdc* (format nil "名前 : ~a" (name (armour selected))) 570 40)
      (text-out *hmemdc* (format nil "防御力 : ~a" (def (armour selected))) 570 70)
      (text-out *hmemdc* (format nil "ブロック率 : ~a%" (blk (armour selected))) 570 100))
    (render-selecting-item)
    (select-object *hogememdc* *waku-img*)
    (new-trans-blt 260 35 0 0 128 128 250 150)
    (new-trans-blt 560 35 0 0 128 128 250 150)
    (new-trans-blt 260 280 0 0 128 128 250 250)))




;;キャラのステータス表示
(defun render-chara-status (p x)
  (let* ((num 30)
	 (cell (aref *cell-data* (aref (field *donjon*) (y p) (x p)))))
    (macrolet ((hoge (n)
		 `(incf ,n 25)))
      
      (text-out *hmemdc* (format nil "~a" (name p)) x num)
      (text-out *hmemdc* (format nil "Lv:~2d" (level p)) x (hoge num))
      (text-out *hmemdc* (format nil "HP:~2d/~2d" (hp p) (maxhp p)) x (hoge num))
      (text-out *hmemdc* (format nil "攻:~2d" (str p)) x (hoge num))
      (text-out *hmemdc* (format nil "防:~2d" (vit p)) x (hoge num))
      (text-out *hmemdc* (format nil "exp") x (hoge num))
      (when (buki p)
	(text-out *hmemdc* (format nil "武器：~a" (name (buki p))) x (hoge num)))
      (text-out *hmemdc* (format nil "地形:~a" (name cell)) x (hoge num))
      (text-out *hmemdc* (format nil "~a" (if (eq (state p) :action) "行動可" "行動済み")) x (hoge num)))))
      ;; (hoge num)
      ;; (create-render-button x (+ x (* 23 (length (get-buki-name (buki p))))) *st-buki-y* *st-buki-y2*
      ;; 			    (format nil "~a" (get-buki-name (buki p)))
      ;; 			    (+ x 4) *st-buki-y* :font *font20*))))


;;selectedキャラに枠つける
(defun render-select-waku ()
  (with-slots (selected) *mouse*
    (when selected
      (select-object *hmemdc* (get-stock-object :white-brush))
      (rectangle *hmemdc* (posx selected) (posy selected) (+ (posx selected) 32)
		 (+ (posy selected) 32)))))
      ;;(delete-object (select-object *hmemdc* (create-solid-brush (encode-rgb 255 255 255)))))))
      ;;(select-object *hogememdc* *waku-ao*)
      ;;(new-trans-blt (* (x selected) *obj-w*) (* (y selected) *obj-h*) 0 0 32 32 32 32))))

;;マウスカーソルのある場所に枠付ける
(defun render-mouse-cursor-waku-and-cell-info ()
  (let* ((x1 (floor (x *mouse*) *obj-w*))
	 (y1 (floor (y *mouse*) *obj-h*)))
    (when (>= *map-w* (x *mouse*))
      (select-object *hogememdc* *waku-img*)
      (new-trans-blt (* x1 *obj-w*) (* y1 *obj-h*) 0 0 128 128 32 32))
    (when (and (> *yoko-block-num* x1)
	       (> *tate-block-num* y1))
      (let* ((cell (aref *cell-data* (aref (field *donjon*) y1 x1)))
	     (heal-str (if (heal cell)
			 (format nil "回復:~d%" (heal cell))
			 (format nil "回復:なし"))))
	(select-object *hmemdc* *font30*)
	(set-text-color *hmemdc* (encode-rgb 255 255 255))
	(text-out *hmemdc* (format nil "地形:~a" (name cell)) 500 300)
	(text-out *hmemdc* (format nil "回避:+~d%" (avoid cell)) 500 330)
	(text-out *hmemdc* heal-str 500 360)))))

;;攻撃可能な敵に枠つける
(defun render-can-atk-waku ()
  (with-slots (selected) *mouse*
    (when (and selected
	       (canatkenemy selected))
      (if (and (buki selected)
	       (eq (atktype (buki selected)) :atk))
	  (select-object *hmemdc* (aref *brush* +red+))
	  (select-object *hmemdc* (aref *brush* +yellow+)))
      (loop :for e :in (canatkenemy selected)
	 :do (rectangle *hmemdc* (posx e) (posy e) (+ (posx e) 32) (+ (posy e) 32) )))))
	  
	 ;;(delete-object br)))))
;;(select-object *hogememdc* *waku-aka*)
	      ;;(new-trans-blt (* (x e) *obj-w*) (* (y e) *obj-h*) 0 0 32 32 32 32)))))
  


;;選択してるキャラの移動できる範囲表示
(defun render-move-waku ()
  (with-slots (selected) *mouse*
    (when (and selected
	       (movearea selected))
      (let ((x1 (floor (x *mouse*) *obj-w*))
	    (y1 (floor (y *mouse*) *obj-h*)))
	;;(select-object *hogememdc* *waku-img*)
	(loop :for area :in (movearea selected)
	   :do (let ((x (car area)) (y (cadr area)))
		 (cond
		   ((and (= x x1) (= y y1)) ;;移動可能範囲内にマウスがあったら
		    (select-object *hogememdc* *waku-ao*)
		    (new-trans-blt (* x *obj-w*) (* y *obj-h*) 0 0 32 32 32 32))
		   (t
		    (select-object *hogememdc* *waku-aka*)
		    (new-trans-blt (* x *obj-w*) (* y *obj-h*) 0 0 32 32 32 32)))))))))


;;マウスと重なってる敵キャラのステータス表示
(defun render-enemy-status-on-mouse ()
  (loop :for p :in (enemies *donjon*)
       :do (when (and (>= (+ (posx p) *obj-w*) (x *mouse*) (posx p))
		      (>= (+ (posy p) *obj-h*) (y *mouse*) (posy p)))
	     (render-chara-status p *cursor-pos-unit-status-x*))))

;;マウスと重なってるキャラのステータス表示
(defun render-party-status-on-mouse ()
  (loop :for p :in (party *p*)
       :do (when (and (>= (+ (posx p) *obj-w*) (x *mouse*) (posx p))
		      (>= (+ (posy p) *obj-h*) (y *mouse*) (posy p)))
	     (render-chara-status p *cursor-pos-unit-status-x* ))))

(defun render-unit-status-on-mouse ()
  (select-object *hmemdc* *font30*)
  (set-text-color *hmemdc* (encode-rgb 255 255 255))
  ;;(set-bk-mode *hmemdc* :transparent)
  (render-party-status-on-mouse)
  (render-enemy-status-on-mouse))

(defun render-selected-unit-status ()
  (with-slots (selected) *mouse*
    (when selected
      (select-object *hmemdc* *font30*)
      (set-text-color *hmemdc* (encode-rgb 255 255 255))
      (render-chara-status selected *selected-unit-status-x*))))

;;行動できるウニっとの色付け
(defun can-action-unit-waku ()
  (select-object *hmemdc* (aref *brush* +cyan+))
  (loop
     :for p :in (party *p*)
     :do (when (eq (state p) :action)
	   (rectangle *hmemdc* (posx p) (posy p) (+ (posx p) 32) (+ (posy p) 32)))))
	   ;;(delete-object (select-object *hmemdc* (create-solid-brush (encode-rgb 157 204 227)))))))


;;出撃キャラを表示
(defun render-fight-party ()
  (select-object  *hogememdc* *class-img*)
  (loop
     :for p :in (party *p*)
     :do (new-trans-blt (posx p) (posy p) 0 (* (img p) 32) 32 32 32 32)))


;;選択中のキャラ
(defun render-selected-chara ()
  (with-slots (selected) *mouse*
    (when (and selected
	       (eq (team selected) :ally))
      (select-object  *hogememdc* *class-img*)
      (new-trans-blt (posx selected) (posy selected) 0 (* (img selected) 32) 32 32 32 32))))



;;装備変更ボタン
(defun render-weapon-change-btn ()
  (when (selected *mouse*)
    (create-render-button *w-change-btn-x1* *w-change-btn-x2* *w-change-btn-y1* *w-change-btn-y2*
			  "装備変更" 500 400 :font *font40*)))

;;出撃ボタン
(defun render-ready-btn ()
  (create-render-button *battle-btn-x1* *battle-btn-x2* *battle-btn-y1* *battle-btn-y2*
			"出撃" 500 450 :font *font40*))

;;いろいろ表示
(defun render-status ()
  (select-object *hmemdc* *font20* )
  (set-text-color *hmemdc* (encode-rgb 255 255 255))
  (if (eq (turn *p*) :ally)
      (text-out *hmemdc* "プレイヤーのターン" 500 5)
      (text-out *hmemdc* "敵のターン" 500 5))
  ;;ターン終了ボタン
  (select-object *hmemdc* *font40*)
  (create-render-button *turn-end-x1* *turn-end-x2* *turn-end-y1*  *turn-end-y2*
			"ターン終了" *turn-end-x1* *turn-end-y1* :font *font40*))
  

;;出撃準備画面を表示
(defun render-battle-preparation ()
  (render-background)
  (render-field)
  (render-enemies)
  (render-fight-party)
  (render-items)
  (render-selected-unit-status)
  (render-unit-status-on-mouse)
  (render-mouse-cursor-waku-and-cell-info)
  (render-select-waku)
  (render-selected-chara)
  (render-weapon-change-btn )
  (render-ready-btn))

;;バトル画面を表示
(defun render-battle ()
  (render-background)
  (render-field t)
  (render-items)
  (render-status)
 
  (can-action-unit-waku )
  (render-select-waku)
  (render-can-atk-waku)
  (render-enemies)
  (render-fight-party)
  (render-selected-unit-status)
  (render-unit-status-on-mouse)
  
  (render-mouse-cursor-waku-and-cell-info )
  (render-move-waku)
  
  (render-selected-chara)
  (render-all-damage)
  (render-weapon-change-btn )
  ;;(render-select-waku)
  )

;;マップを表示
(defun render-donjon ()
  (render-background)
  (render-field)
  (render-fight-party)
  (render-chara-status-on-mouse)
  (render-select-waku)
  
  (render-selected-chara)
  ;; (render-yuka)
  ;; (render-block)
   ;;(render-item)
   )


;;HPバー表示
(defun render-hpbar (e)
  (let* ((len (floor (* (/ (hp e) (maxhp e)) *hpbar-max*)))
	 (left (* (car (pos e)) *obj-w*))
	 (bottom (* (cadr (pos e)) *obj-h*))
	 (top (- bottom 8))
	 (hp-w (+ left len)))
    ;;残りHP
    (select-object *hmemdc* (aref *brush* +green+))
    (rectangle *hmemdc* left top hp-w bottom)
    ;;減ったHP
    (select-object *hmemdc* (aref *brush* +red+))
    (rectangle *hmemdc* hp-w top (+ hp-w (- *hpbar-max* len)) bottom)))

;;ダメージ表示
(defun render-damage (e)
  (with-slots (dmg) e
    (when dmg
      (select-object *hmemdc* *font20*)
      
      ;;(set-bk-mode *hmemdc* :transparent)
      ;;縁取り
      (set-text-color *hmemdc* (encode-rgb 0 0 0))
      (text-out *hmemdc* (format nil "~d" (dmg-num dmg)) (- (posx dmg) 2) (posy dmg))
      (text-out *hmemdc* (format nil "~d" (dmg-num dmg)) (+ (posx dmg) 2) (posy dmg))
      (text-out *hmemdc* (format nil "~d" (dmg-num dmg)) (posx dmg) (- (posy dmg) 2))
      (text-out *hmemdc* (format nil "~d" (dmg-num dmg)) (posx dmg) (+ (posy dmg) 2))
      ;;
      (set-text-color *hmemdc* (color dmg))
      (text-out *hmemdc* (format nil "~d" (dmg-num dmg)) (posx dmg) (posy dmg))
      )))

;;全てのダメージ表示
(defun render-all-damage ()
  ;;(render-damage *p*  (encode-rgb 255 147 122))
  ;;(render-hpbar *p*)
  (loop for e in (party *p*)
     do (render-damage e))
  (loop for e in (enemies *donjon*)
     do (render-damage e)))
       ;; (when (and (/= (maxhp e) (hp e))
       ;; 		  (null (dead e)))
       ;; 	 (render-hpbar e))))


;;test
(defun render-test ()
  (select-object *hogememdc*  *anime-monsters-img*)
  (transparent-blt *hmemdc* 0 0 *hogememdc* 0 32 :width-source 32
		   :height-source 32
		   :width-dest 32 :height-dest 32
		   :transparent-color (encode-rgb 0 255 0)))

;;タイトル画面のボタンの位置
(defun title-gamen-mouse-pos ()
  (cond
    ((and (>= 475 (x *mouse*) 330)
  	  (>= 405 (y *mouse*) 360))
     1)
    ((and (>= 475 (x *mouse*) 330)
  	  (>= 455 (y *mouse*) 410))
     2)
    ((and (>= 420 (x *mouse*) 330)
  	  (>= 505 (y *mouse*) 460))
     3)))

;;タイトル画面
(defun render-title-gamen (hwnd)
  (let ((hit1) (hit2) (hit3))
    (render-background)
    (select-object *hmemdc* *font140*)
    ;;(set-bk-mode *hmemdc* :transparent)
    (set-text-color *hmemdc* (encode-rgb 0 155 255))
    (text-out *hmemdc* "もげてぃかる仮" 50 70)
    
    (case (title-gamen-mouse-pos)
      (1
       (select-object *hmemdc* (get-stock-object :white-brush))
       (rectangle *hmemdc* 330 360 475 405)
       (setf hit1 t))
      (2
       (setf hit2 t)
       (select-object *hmemdc* (get-stock-object :white-brush))
       (rectangle *hmemdc* 330 410 475 455))
      (3
       (setf hit3 t)
       (select-object *hmemdc* (get-stock-object :white-brush))
       (rectangle *hmemdc* 330 460 420 505)))
    (select-object *hmemdc* *font40*)
    (set-text-color *hmemdc* (encode-rgb 255 255 255))
    (text-out *hmemdc* (format nil "x:~d y:~d" (x *mouse*) (y *mouse*)) 300 200)
    (text-out *hmemdc* (format nil "winx:~d winy:~d" *change-screen-w* *change-screen-h*) 300 250)
    (if hit1
	(set-text-color *hmemdc* (encode-rgb 0 0 0))
	(set-text-color *hmemdc* (encode-rgb 255 255 255)))
    (text-out *hmemdc* "はじめから" 330 360)
    (if hit2
	(set-text-color *hmemdc* (encode-rgb 0 0 0))
	(set-text-color *hmemdc* (encode-rgb 255 255 255)))
    (text-out *hmemdc* "つづきから" 330 410)
    (if hit3
	(set-text-color *hmemdc* (encode-rgb 0 0 0))
	(set-text-color *hmemdc* (encode-rgb 255 255 255)))
    (text-out *hmemdc* "おわる" 330 460)))
    ;; (select-object *hogememdc* *waku2-img*)
    ;; (alpha-blend *hmemdc* 0 0 *hogememdc* 0 0 :width-dest 128 :height-dest 128
    ;; 		 :width-source 128 :height-source 128)));;source-constant-alpha 50)))

;;ゲームオーバー画面
(defun render-gameover-gamen ()
  (render-background)
  (select-object *hmemdc* *font140*)
  ;;(set-bk-mode *hmemdc* :transparent)
  (set-text-color *hmemdc* (encode-rgb 0 155 255))
  (text-out *hmemdc* "GAME OVER" 50 70)
  (select-object *hogememdc* *objs-img*)
  (cond
    ((= (cursor *p*) 0)
     (new-trans-blt 280 360 (* 32 +cursor+) 0 32 32 32 32))
    ((= (cursor *p*) 1)
     (new-trans-blt 280 410 (* 32 +cursor+) 0 32 32 32 32))
    ((= (cursor *p*) 2)
     (new-trans-blt 280 460 (* 32 +cursor+) 0 32 32 32 32)))
  (select-object *hmemdc* *font40*)
  (set-text-color *hmemdc* (encode-rgb 255 255 255))
  (text-out *hmemdc* (format nil "~d階で力尽きた" (stage *donjon*)) 5 200)
  (text-out *hmemdc* "リトライ" 330 360)
  (text-out *hmemdc* "最深のセーブから" 330 410)
  (text-out *hmemdc* "おわる" 330 460))
  



;;エンディング画面
(defun render-ending-gamen ()
  (let ((time1 (- (endtime *p*) *start-time*)))
    (multiple-value-bind (h m s ms) (get-hms time1)
      (render-background)
      (select-object *hmemdc* *font70*)
      ;;(set-bk-mode *hmemdc* :transparent)
      (set-text-color *hmemdc* (encode-rgb 0 155 255))
      (text-out *hmemdc* (format nil "~a は" (name *p*)) 10 10)
      (text-out *hmemdc* (format nil "もげぞうの迷宮を制覇した！") 100 100)
      (select-object *hmemdc* *font70*)
      (set-text-color *hmemdc* (encode-rgb 255 255 255))
      (text-out *hmemdc* (format nil "クリアタイム") 270 200)
      (text-out *hmemdc* (format nil  "~2,'0d 時間 ~2,'0d 分 ~2,'0d 秒 ~2,'0d" h m s ms) 100 280)
      (select-object *hogememdc* *objs-img*)
      (if (= (cursor *p*) 0)
	  (new-trans-blt 280 400 (* 32 +cursor+) 0 32 32 32 32)
	  (new-trans-blt 280 450 (* 32 +cursor+) 0 32 32 32 32))
      (select-object *hmemdc* *font40*)
      (set-text-color *hmemdc* (encode-rgb 255 255 255))
      (text-out *hmemdc* (format nil "もう一度やる") 330 400)
      (text-out *hmemdc* (format nil "おわる") 330 450))))

;;初期パーティ編成画面のボタンの位置
(defun party-edit-gamen-mouse-pos ()
  (loop
     :for num = 0 :then num
     :for btn-pos :in *init-party-edit-gamen-btn-pos-list*
     :do
       (multiple-value-bind (xmin ymin xmax ymax)
	   (apply #'values btn-pos)
	 (when (and (>= xmax (x *mouse*) xmin)
		    (>= ymax (y *mouse*) ymin))
	   (return-from party-edit-gamen-mouse-pos num))
	 (incf num))))

;;選んだ初期パーティ表示
(defun render-my-init-party-list (mouse)
  (set-text-color *hmemdc* (encode-rgb 255 255 255))
  (loop
     :for chara :in (party *p*)
     :for y :from 110 :by 50
     :for mousepos :from 7
     :do (if (and mouse
		  (= mouse mousepos))
	     (progn
	       (select-object *hmemdc* (get-stock-object :white-brush))
	       (multiple-value-bind (x1 y1 x2 y2)
		   (apply #'values (nth mouse *init-party-edit-gamen-btn-pos-list*))
		 (rectangle *hmemdc* x1 y1 x2 y2))
	       (set-text-color *hmemdc* (encode-rgb 0 0 0)))
	     (set-text-color *hmemdc* (encode-rgb 255 255 255)))
       (text-out *hmemdc* (format nil "~a" (getf *show-class* (job chara))) 330 y)))

;;初期クラス表示
(defun render-init-class ()
  (let ((mouse (party-edit-gamen-mouse-pos)))
    (select-object *hmemdc* (get-stock-object :white-brush))
    (cond
      ((and mouse (>= 6 mouse))
       (multiple-value-bind (x1 y1 x2 y2)
	   (apply #'values (nth mouse *init-party-edit-gamen-btn-pos-list*))
	 (rectangle *hmemdc* x1 y1 x2 y2)))
      ((and mouse (= mouse 12))
       (multiple-value-bind (x1 y1 x2 y2)
	   (apply #'values (nth mouse *init-party-edit-gamen-btn-pos-list*))
	 (rectangle *hmemdc* x1 y1 x2 y2))
       (set-text-color *hmemdc* (encode-rgb 0 0 0))
       (select-object *hmemdc* *font70*)
       (text-out *hmemdc* "出発" 550 400)))
    (loop
       :for name :in '("戦士" "魔術師" "僧侶" "弓使い" "騎士" "盗賊" "天馬騎士")
       :for y :from 110 :by 50
       :for mousepos :from 0
       :do
	 (select-object *hmemdc* *font40*)
	 (if (and mouse
		  (= mouse mousepos))
	     (set-text-color *hmemdc* (encode-rgb 0 0 0))
	     (set-text-color *hmemdc* (encode-rgb 255 255 255)))
	 (text-out *hmemdc* (format nil "~a" name) 40 y))
    (render-my-init-party-list mouse)))


       
;;初期パーティ画面
(defun render-party-edit-gamen ()
  (render-background)
  (select-object *hmemdc* *font70*)
  ;;(set-bk-mode *hmemdc* :transparent)
  (set-text-color *hmemdc* (encode-rgb 0 155 255))
  (text-out *hmemdc* "初期パーティを作ってください(5人)" 5 10)
  (text-out *hmemdc* "→" 225 260)
  (text-out *hmemdc* "出発" 550 400)
  (select-object *hogememdc* *waku-img*)
  (new-trans-blt 10 100 0 0 128 128 200 400)
  (new-trans-blt 300 100 0 0 128 128 200 400)
  (new-trans-blt 540 400 0 0 128 128 140 70)
  (select-object *hmemdc* *font40*)
  (text-out *hmemdc* (format nil "x:~d y:~d" (x *mouse*) (y *mouse*)) 500 200)
  (text-out *hmemdc* "右クリでキャラ削除" 510 150)
  (set-text-color *hmemdc* (encode-rgb 255 255 255))
  (render-init-class))




;;ゲーム全体描画
(defun render-game (hdc hwnd)
  (case (state *p*)
    (:title ;;タイトル画面
     (render-title-gamen hwnd))
    (:initpartyedit
     (render-party-edit-gamen))
    (:battle-preparation
     (render-battle-preparation))
    (:weaponchange
     (render-weapon-change-gamen))
    (:battle
     (render-battle))
    (:playing ;;ゲーム
     (render-donjon)
     ;;(render-enemies)
     ;;(render-player)
     ;;(render-arrow)
     ;;(render-all-damage)
     ;;(render-p-status)
     )
     ;;(render-test)
    (:dead
     (render-gameover-gamen))
    (:ending ;;エンディング画面
     (render-ending-gamen)
     ))
  (transparent-blt hdc 0 0 *hmemdc* 0 0
  		   :width-dest *change-screen-w* :height-dest *change-screen-h*
  		   :width-source (rect-right *c-rect*) :height-source (rect-bottom *c-rect*)
  		   :transparent-color (encode-rgb 0 255 0)))
  ;; (select-object *hmemdc* *waku2-img*)
  ;; (alpha-blend hdc 0 0 *hmemdc* 0 0 :width-dest 128 :height-dest 128
  ;; 	       :width-source 128 :height-source 128 :source-constant-alpha 50))
