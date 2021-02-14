
(defmacro my-enum (&rest names)
  `(progn
     ,@(loop for i from 0
             for name in names
        collect `(defparameter ,name ,i))))

;;".\\images\\*.*" ロードした画像の配列を作る
(defun make-imgs-array (img-path)
  (let* ((img-list (mapcar #'namestring (directory img-path)))
         (imgs (make-array (length img-list))))
    (loop for str in img-list
          for i from 0
          do (setf (aref imgs i)
                   (load-image str :type :bitmap
                               :flags '(:load-from-file :create-dib-section))))
    imgs))

;;class copy
(defun shallow-copy-object (original)
  (let* ((class (class-of original))
         (copy (allocate-instance class)))
    (dolist (slot (mapcar #'sb-mop:slot-definition-name (sb-mop:class-slots class)))
      (when (slot-boundp original slot)
        (setf (slot-value copy slot)
              (slot-value original slot))))
    copy))

(defparameter *atk-width* 8)
(defparameter *atk-pos-max* (* *atk-width* 3))

(defparameter *p-img* nil)
(defparameter *p-atk-img* nil)
(defparameter *buki-img* nil)
(defparameter *hammer-img* nil)
(defparameter *job-monsters* nil)
(defparameter *objs-img* nil)
(defparameter *arrow-img* nil)
(defvar *waku-img* nil)
(defvar *waku2-img* nil)
(defvar *waku-ao* nil)
(defvar *waku-aka* nil)
(defparameter *job-img* nil)

(defparameter *load-units-data* nil)
(defparameter *load-stage* nil)
(defparameter *load-party-item* nil)

(defun load-images ()
  (setf *objs-img* (load-image "../img/new-objs-img.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*job-img*  (load-image "../img/class.bmp" :type :bitmap
			                         :flags '(:load-from-file :create-dib-section))
      	*arrow-img* (load-image "../img/arrow.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*p-img* (load-image "../img/p-ido-anime.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*p-atk-img* (load-image "../img/p-atk-anime.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*hammer-img* (load-image "../img/hammer-anime.bmp" :type :bitmap
      			     :flags '(:load-from-file :create-dib-section))
      	*job-monsters* (load-image "../img/job-monsters.bmp" :type :bitmap
      					 :flags '(:load-from-file :create-dib-section))
      	*buki-img* (load-image "../img/buki-anime.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*job-img* (load-image "../img/job-img.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*waku-img* (load-image "../img/waku.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*waku-ao* (load-image "../img/aowaku.bmp" :type :bitmap
			      :flags '(:load-from-file :create-dib-section))
	*waku-aka* (load-image "../img/akawaku.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))
	*waku2-img* (load-image "../img/hoge.bmp" :type :bitmap
			       :flags '(:load-from-file :create-dib-section))))

;;プレイヤー画像切り替えよう
(defconstant +down+ 0)
(defconstant +left+ 2)
(defconstant +right+ 3)
(defconstant +up+ 1)

;;敵画像切り替えよう
(defconstant +brigand-anime+ 0)
(defconstant +dragon-anime+ 1)
(defconstant +hydra-anime+ 2)
(defconstant +yote-anime+ 3)
(defconstant +orc-anime+ 4)
(defconstant +slime-anime+ 5)
(defconstant +boss-anime+ 11)
(defconstant +hydra-atk+ 6)
(defconstant +brigand-ball+ 7)
(defconstant +dragon-fire+ 8)
(defconstant +orc-atk+ 9)

;;敵の攻撃演出時間
(defparameter *orc-atk-effect-time* 30)
(defparameter *hydra-atk-effect-time* 30)

;;透過用
(defcfun (%set-layered-window-attributes "SetLayeredWindowAttributes" :convention :stdcall)
         :boolean
  (hwnd :pointer)
  (crkey :int32)
  (balpha :uint8)
  (dwflags :uint32))

(defun set-layered-window-attributes (hwnd crkey balpha dwflags)
  (%set-layered-window-attributes hwnd crkey balpha dwflags))




(defparameter *backup-player-data* nil)
(defparameter *backup-donjon-data* nil)
;;(defparameter *tate* 11) ;;マップサイズ
;;(defparameter *yoko* 11)
(defparameter *monsters* nil)
(defparameter *monster-builders* nil)

(defparameter *map* nil)
(defparameter *ido?* nil)
(defparameter *p* nil)
(defparameter *pt* nil)

(defparameter *battle?* nil)
(defparameter *monster-num* 10)
(defparameter *monster-level* 1) ;;階数によるモンスターのレベル
(defparameter *boss?* 0)
(defparameter *end* 0)
(defparameter *lv-exp* 100)
(defparameter *images* nil)
(defparameter *anime-monsters-img* nil)

(defparameter *knuckle-wav*    "../sound/knuckle90.wav")
(defparameter *ax-wav*         "../sound/ax90.wav")
(defparameter *sword-wav*      "../sound/sword90.wav")
(defparameter *spear-wav*      "../sound/spear90.wav")
(defparameter *bow-wav*        "../sound/bow90.wav")
(defparameter *wand-wav*       "../sound/wand90.wav")
(defparameter *heal-wav*       "../sound/heal90.wav")
(defparameter *chest-wav*      "../sound/chest90.wav")
(defparameter *move-wav*       "../sound/move90.wav")
(defparameter *lvup-wav*       "../sound/lvup90.wav")
(defparameter *mouse-move-wav* "../sound/mouse-select90.wav")
(defparameter *select-wav*     "../sound/select90.wav")
;;bgm
(defparameter *title-bgm-path*      "../sound/titleBGM.wav")
(defparameter *edit-bgm-path*       "../sound/editBGM.wav")
(defparameter *prebattle-bgm-path*  "../sound/prebattle.wav")
(defparameter *battle1-bgm-path*    "../sound/battle1.wav")
(defparameter *battle2-bgm-path*    "../sound/battle2.wav")
(defparameter *battle3-bgm-path*    "../sound/battle3.wav")
(defparameter *battle4-bgm-path*    "../sound/battle4.wav")
(defparameter *battle5-bgm-path*    "../sound/battle5.wav")

;;alias
(defparameter *titlebgm*      "title")
(defparameter *editbgm*       "edit")
(defparameter *prebattle*     "prebattle")
(defparameter *battle1bgm*    "battle1")
(defparameter *battle2bgm*    "battle2")
(defparameter *battle3bgm*    "battle3")
(defparameter *battle4bgm*    "battle4")
(defparameter *battle5bgm*    "battle5")
(defparameter *bgm* nil)

(defparameter *battle-bgm-list* (list *battle1bgm* *battle2bgm* *battle3bgm* *battle4bgm* *battle5bgm*))

;;拡大
(Defparameter *mag-w* 1)
(Defparameter *mag-h* 1)

;;基本サイズ 元の画像サイズ
(defparameter *obj-w* 32)
(defparameter *obj-h* 32)


;;元のブロック画像のサイズ
(defparameter *blo-w* 32)
(defparameter *blo-h* 32)
;;表示するブロック画像のサイズ
(defparameter *blo-w46* 42)
(defparameter *blo-h46* 42)

;;炎サイズ
(defparameter *fire-w* 32)
(defparameter *fire-h* 32)
(defparameter *fire-w/2* (floor *fire-w* 2))
(defparameter *fire-h/2* (floor *fire-h* 2))

;;プレイヤーのサイズ
(defparameter *p-w* 24)
(defparameter *p-h* 32)
(defparameter *p-w/2* (floor *p-w* 2))
(defparameter *p-h/2* (floor *p-h* 2))



(defparameter *w/2* (floor *obj-w* 2))
(defparameter *h/2* (floor *obj-h* 2))

;;オブジェクト画像表示サイズ
(defparameter *w-test* 36)
(defparameter *h-test* 36)

;;
(defparameter *tate* 15)
(defparameter *yoko* 15)

(defparameter *yoko-block-num* 15)
(defparameter *tate-block-num* 15)

;;ゲームマップ領域
(defparameter *map-w* (* *yoko-block-num* *obj-w*))
(defparameter *map-h* (* *tate-block-num* *obj-h*))
;;プレイヤーのステータス表示用領域サイズ
(defparameter *status-w* 400)
(defparameter *status-h* 120)


(defparameter *screen-w* (+ *map-w* *status-w*))
(defparameter *screen-h* (+ *map-h* *status-h*))

(defparameter *change-screen-w* *screen-w*)
(defparameter *change-screen-h* *screen-h*)

(defparameter *waku-size* 10) ;;ゲームフィールドの周りの枠太さ
(defparameter *c-rect* nil) ;;クライアント領域

(defparameter *start-time* 0)
(defparameter *name* nil)
(defparameter *donjon* nil)

;;画面領域
(defparameter *client-w* (+ *map-w* 150))
(defparameter *client-h* (* *blo-h46* *tate*))

(defparameter *screen-center-x* nil)

(defparameter *brush* nil)
(defparameter *start* nil)
(defparameter *hmemDC* nil)
(defparameter *hbitmap* nil)


(defparameter *hogememDC* nil)
(defparameter *hogebitmap* nil)

(defparameter *kabe-break* nil)
(defparameter *HPbar-max* 40)
(defparameter *bukiexpbar-max* 100)

(defparameter *droppos* '((0 0) (0 1) (0 -1) (1 0) (-1 0) (1 1) (-1 -1) (-1 1) (1 -1)))
(defparameter *around* '((0 1) (0 -1) (1 0) (-1 0) (1 1) (-1 -1) (-1 1) (1 -1)))
(defparameter *tonari* '((0 1) (0 -1) (1 0) (-1 0)))
(defparameter *tonari-dir* '(:right :left :down :up))

(defparameter *mouse-hosei-x* 1)
(defparameter *mouse-hosei-y* 1)

(defparameter *selected-unit-status-x* (+ *map-w* 10))
(defparameter *cursor-pos-unit-status-x* (+ *selected-unit-status-x* 200))

;;BGMOFFボタン
(defparameter *bgmoff-x1* 760)
(defparameter *bgmoff-x2* 860)
(defparameter *bgmoff-y1* 535)
(defparameter *bgmoff-y2* 560)

;;タイトル画面スタートボタン
(defparameter *title-start-x1* 330)
(defparameter *title-start-x2* 500)
(defparameter *title-start-y1* 360)
(defparameter *title-start-y2* 405)
;;タイトル画面終了ボタン
(defparameter *title-end-x1* 330)
(defparameter *title-end-x2* 420)
(defparameter *title-end-y1* 460)
(defparameter *title-end-y2* 505)
;;コンテニューボタン
(defparameter *continue-x1* 330)
(defparameter *continue-x2* 500)
(defparameter *continue-y1* 410)
(defparameter *continue-y2* 455)

;;ターンエンドボタン
(defparameter *turn-end-x1* 350)
(defparameter *turn-end-x2* 500)
(defparameter *turn-end-y1* 480)
(defparameter *turn-end-y2* 520)

;;装備変更ボタン
(defparameter *w-change-btn-x1* 170)
(defparameter *w-change-btn-x2* 320)
(defparameter *w-change-btn-y1* 480)
(defparameter *w-change-btn-y2* 520)
;;出撃ボタン
(defparameter *battle-btn-x1* 495)
(defparameter *battle-btn-x2* 580)
(defparameter *battle-btn-y1* 450)
(defparameter *battle-btn-y2* 490)
;;セーブボタン
(defparameter *save-x1* 495)
(defparameter *save-x2* 590)
(defparameter *save-y1* 500)
(defparameter *save-y2* 540)
;;セーブスロット1
(defparameter *save-slot1-x1* 200)
(defparameter *save-slot1-x2* 400)
(defparameter *save-slot1-y1* 200)
(defparameter *save-slot1-y2* 250)
;;セーブ終わり
(defparameter *save-end-x1* 500)
(defparameter *save-end-x2* 580)
(defparameter *save-end-y1* 500)
(defparameter *save-end-y2* 550)
;;アイテムリストの次へボタン
(defparameter *item-next-btn-x1* 180)
(defparameter *item-next-btn-x2* 230)
(defparameter *item-next-btn-y1* 490)
(defparameter *item-next-btn-y2* 520)
;;アイテムリストの次へボタン
(defparameter *item-prev-btn-x1* 30)
(defparameter *item-prev-btn-x2* 80)
(defparameter *item-prev-btn-y1* 490)
(defparameter *item-prev-btn-y2* 520)
;;装備変更完了ボタン
(defparameter *item-decision-x1* 105)
(defparameter *item-decision-x2* 155)
(defparameter *item-decision-y1* 520)
(defparameter *item-decision-y2* 550)
;;アイテムリスト表示マックス
(defparameter *item-show-max* 14)

;;所持品リストx座標
(defparameter *item-x1* 50)
(defparameter *item-x2* 220)
;;所持品リストy座標
;;アイテム1
(defparameter *item1-y1* 45)
(defparameter *item1-y2* 75)
;;アイテム2
(defparameter *item2-y1* 75)
(defparameter *item2-y2* 105)
;;アイテム3
(defparameter *item3-y1* 105)
(defparameter *item3-y2* 135)
;;アイテム4
(defparameter *item4-y1* 135)
(defparameter *item4-y2* 165)
;;アイテム5
(defparameter *item5-y1* 165)
(defparameter *item5-y2* 195)
;;アイテム6
(defparameter *item6-y1* 195)
(defparameter *item6-y2* 225)
;;アイテム7
(defparameter *item7-y1* 225)
(defparameter *item7-y2* 255)
;;アイテム8
(defparameter *item8-y1* 255)
(defparameter *item8-y2* 285)
;;アイテム9
(defparameter *item9-y1* 285)
(defparameter *item9-y2* 315)
;;アイテム10
(defparameter *item10-y1* 315)
(defparameter *item10-y2* 345)
;;アイテム11
(defparameter *item11-y1* 345)
(defparameter *item11-y2* 375)
;;アイテム12
(defparameter *item12-y1* 375)
(defparameter *item12-y2* 405)
;;アイテム13
(defparameter *item13-y1* 405)
(defparameter *item13-y2* 435)
;;アイテム14
(defparameter *item14-y1* 435)
(defparameter *item14-y2* 465)



(my-enum +purple+ +red+ +green+ +blue+ +yellow+ +cyan+ +pink+ +white+)

(my-enum +arrow-right+ +arrow-left+ +arrow-down+ +arrow-up+)

(my-enum +title-bgm+)


(defclass cell ()
  ((name  :accessor name  :initform nil :initarg :name)
   (def   :accessor def   :initform 0   :initarg :def)
   (heal  :accessor heal  :initform nil :initarg :heal)
   (avoid :accessor avoid :initform 0   :initarg :avoid)))

(defclass keystate ()
  ((right :accessor right :initform nil :initarg :right)
   (left  :accessor left  :initform nil :initarg :left)
   (down  :accessor down  :initform nil :initarg :down)
   (up    :accessor up    :initform nil :initarg :up)
   (enter :accessor enter :initform nil :initarg :enter)
   (shift :accessor shift :initform nil :initarg :shift)
   (z     :accessor z     :initform nil :initarg :z)
   (x     :accessor x     :initform nil :initarg :x)
   (c     :accessor c     :initform nil :initarg :c)))

(defclass mouse ()
  ((right :accessor right :initform nil :initarg :right)
   (left  :accessor left  :initform nil :initarg :left)
   (selected  :accessor selected  :initform nil :initarg :selected)
   (x     :accessor x :initform 0 :initarg :x)
   (y     :accessor y  :initform 0 :initarg :y)))

(defparameter *keystate* (make-instance 'keystate))
(defvar *mouse* (make-instance 'mouse))


(my-enum +yuka+ +wall+ +block+ +forest+ +mtlow+ +mthigh+ +water+ +fort+ +kaidan+ +chest+ +cursor+ +obj-max+)


(defparameter *celldescs*
  (make-array +obj-max+ :initial-contents 
	      (list (make-instance 'cell :name "草原" :heal nil :def 0 :avoid 0)
		    (make-instance 'cell :name "壁")
		    (make-instance 'cell :name "脆い壁")
		    (make-instance 'cell :name "森"   :heal nil :def 5  :avoid 5)
		    (make-instance 'cell :name "山"   :heal nil :def 10 :avoid 10)
		    (make-instance 'cell :name "高山" :heal nil :def 10 :avoid 10)
		    (make-instance 'cell :name "川"   :heal nil :def 10 :avoid 0)
		    (make-instance 'cell :name "砦"   :heal 20  :def 20 :avoid 10)
		    (make-instance 'cell :name "階段" :heal nil :def 0  :avoid 0)
		    (make-instance 'cell :name "dummy" :heal nil :def 0 :avoid 0)
		    (make-instance 'cell :name "dummy" :heal nil :def 0 :avoid 0))))

;;ドロップアイテムリスト
(defparameter *drop-item*
  '(:boots :atkup :defup))

(defclass donjon ()
  ((field :accessor field :initform nil :initarg :field)  ;;マップ
   (tate :accessor tate :initform *tate* :initarg :tate)  ;;縦幅
   (yoko :accessor yoko :initform *yoko* :initarg :yoko)  ;;横幅
   (enemy-init-pos :accessor enemy-init-pos :initform nil :initarg :enemy-init-pos)
   (player-init-pos :accessor player-init-pos :initform nil :initarg :player-init-pos)
   (enemies :accessor enemies :initform nil :initarg :enemies)
   (chest-max :accessor chest-max :initform 0 :initarg :chest-max)
   (kaidan-init-pos :accessor kaidan-init-pos :initform nil :initarg :kaidan-init-pos)
   (appear-enemy-rate :accessor appear-enemy-rate  :initform nil  :initarg :appear-enemy-rate) ;;床
   (donjonnum     :accessor donjonnum      :initform nil  :initarg :donjonnum)
   (blocks    :accessor blocks     :initform nil  :initarg :blocks) ;;ブロック
   (chest     :accessor chest    :initform nil  :initarg :chest) ;;宝箱
   (stage      :accessor stage       :initform 1   :initarg :stage)
   (chest-init-pos :accessor chest-init-pos  :initform nil  :initarg :chest-init-pos)
   (drop-item :accessor drop-item  :initform nil :initarg :drop-item))) ;;行き止まりリスト


;;ブロックとか
(defclass obj ()
  ((x        :accessor x        :initform 0      :initarg :x)
   (y        :accessor y        :initform 0      :initarg :y)
   (x2       :accessor x2       :initform 0      :initarg :x2)
   (y2       :accessor y2       :initform 0      :initarg :y2)
   (w        :accessor w        :initform 0      :initarg :w)
   (h        :accessor h        :initform 0      :initarg :h)
   (moto-w   :accessor moto-w   :initform 0      :initarg :moto-w)
   (moto-h   :accessor moto-h   :initform 0      :initarg :moto-h)
   (posx      :accessor posx      :initform 0      :initarg :posx)
   (posy      :accessor posy      :initform 0      :initarg :posy)
   (w/2      :accessor w/2      :initform 0      :initarg :w/2)
   (h/2      :accessor h/2      :initform 0      :initarg :h/2)
   (obj-type :accessor obj-type :initform 0      :initarg :obj-type)
   (img-h    :accessor img-h    :initform 0      :initarg :img-h)
   (img-src  :accessor img-src    :initform 0      :initarg :img-src)
   (dir       :accessor dir       :initform :down :initarg :dir)     ;;現在の方向
   (level    :accessor level     :initform 1     :initarg :level)
   (img      :accessor img      :initform nil    :initarg :img)))

(defclass dmg-font (obj)
  ((dmg-num  :accessor dmg-num   :initform 0     :initarg :dmg-num)
   (miny     :accessor miny      :initform 0     :initarg :miny)
   (maxy     :accessor maxy      :initform 0     :initarg :maxy)
   (y-dir    :accessor y-dir     :initform :up   :initarg :y-dir)
   (x-dir    :accessor x-dir     :initform :left :initarg :x-dir)
   (color    :accessor color     :initform :left :initarg :color)
   ))

(defclass itemtext (dmg-font)
  ((name :accessor name      :initform nil :initarg :name)
   (timer :accessor timer      :initform 0     :initarg :timer)))

;;プレイヤーと敵で共通で使うやつ
(defclass common (obj)
  ((hp        :accessor hp        :initform 30    :initarg :hp)
   (maxhp     :accessor maxhp     :initform 30    :initarg :maxhp)
   (agi       :accessor agi       :initform 30    :initarg :agi)
   (vit       :accessor vit       :initform 30    :initarg :vit)
   (str       :accessor str       :initform 30    :initarg :str)
   (res       :accessor res       :initform 30    :initarg :res)
   (int       :accessor int       :initform 30    :initarg :int)
   (cell      :accessor cell      :initform nil   :initarg :cell)
   (dead      :accessor dead      :initform nil   :initarg :dead)    ;;死亡判定
   (ido-spd   :accessor ido-spd   :initform 2     :initarg :ido-spd) ;;移動速度
   (atk-pos-x :accessor atk-pos-x   :initform 0     :initarg :atk-pos-x)
   (atk-pos-y :accessor atk-pos-y   :initform 0     :initarg :atk-pos-y)
   (atk-pos-f :accessor atk-pos-f :initform nil   :initarg :atk-pos-f)
   (dmg       :accessor dmg       :initform nil   :initarg :dmg)     ;;ダメージ表示用
   (dmg-c     :accessor dmg-c     :initform 0     :initarg :dmg-c)   ;;ダメージを受ける間隔
   (race      :accessor race      :initform nil   :initarg :race)    ;;種族  0:プレイヤー 1:オーク 2:スライム 3:ヒドラ 4:ブリガンド 5 メテルヨテイチ
   (walk-c    :accessor walk-c    :initform 0     :initarg :walk-c)  ;;歩行アニメカウンター
   (walk-func :accessor walk-func :initform #'+   :initarg :walk-func)

   (dir-c     :accessor dir-c     :initform 0     :initarg :dir-c)   ;;方向転換用カウンター
   (atk-now   :accessor atk-now   :initform nil   :initarg :atk-now) ;;攻撃中か
   (atk-c     :accessor atk-c     :initform 0     :initarg :atk-c)   ;;攻撃モーション更新用
   (atk-img   :accessor atk-img   :initform 0     :initarg :atk-img) ;;攻撃画像番号 ０～２
   (atk-spd   :accessor atk-spd   :initform 10    :initarg :atk-spd) ;;攻撃速度
   (expe      :accessor expe      :initform 0     :initarg :expe) ;;もらえる経験値orプレイヤーの所持経験値
   (lvup-exp  :accessor lvup-exp  :initform 50   :initarg :lvup-exp) ;;次のレベルアップに必要な経験値
   ))

;;適用
(defclass enemy (common)
  ((centerx      :accessor centerx    :initform 30  :initarg :centerx)
   (centery      :accessor centery    :initform 30  :initarg :centery)
   (drop         :accessor drop       :initform nil :initarg :drop)    ;;ドロップするアイテム
   (vx           :accessor vx         :initform 2   :initarg :vx)
   (vy           :accessor vy         :initform 2   :initarg :vy)
   (deg          :accessor deg        :initform 10  :initarg :deg)))

;;プレイヤー用
(defclass unit (common)
  ( 
   (name        :accessor name        :initform nil :initarg :name)     ;;名前
   (buki        :accessor buki        :initform nil :initarg :buki)
   (movearea    :accessor movearea    :initform nil :initarg :movearea)
   (move        :accessor move        :initform nil :initarg :move)
   (movecost    :accessor movecost    :initform nil :initarg :movecost)
   (job         :accessor job         :initform nil :initarg :job)
   (team        :accessor team        :initform nil :initarg :team)
   (armor       :accessor armor       :initform nil :initarg :armor)
   (accessory   :accessor accessory   :initform nil :initarg :accessory)
   (state       :accessor state       :initform :action :initarg :state)
   (canatkenemy :accessor canatkenemy :initform nil   :initarg :canatkenemy)
   (atkedarea   :accessor atkedarea   :initform nil :initarg :atkedarea)
   ))

(defclass player ()
  ((party           :accessor party       :initform nil    :initarg :party)
   (cursor          :accessor cursor      :initform 0      :initarg :cursor)
   (item            :accessor item        :initform nil    :initarg :item)
   (bgm             :accessor bgm         :initform :on    :initarg :bgm)
   (endtime         :accessor endtime     :initform 0      :initarg :endtime)
   (starttime       :accessor starttime   :initform 0      :initarg :starttime)
   (save            :accessor save        :initform nil    :initarg :save)
   (item-page       :accessor item-page   :initform 0      :initarg :item-page)
   (getitem         :accessor getitem     :initform nil    :initarg :getitem)
   (turn            :accessor turn        :initform :ally  :initarg :turn)
   (prestate        :accessor prestate    :initform nil    :initarg :prestate)
   (state           :accessor state       :initform :title :initarg :state)))     ;;武器



;;ジョブデータ
(defclass jobdesc ()
  ((name      :accessor name      :initform nil :initarg :name)
   (img       :accessor img       :initform 0   :initarg :img)
   (id        :accessor id        :initform 0   :initarg :id)
   (canequip  :accessor canequip  :initform nil :initarg :canequip)
   (move      :accessor move      :initform 0   :initarg :move)
   (lvuprate  :accessor lvuprate  :initform 0   :initarg :lvuprate)
   (movecost  :accessor movecost  :initform nil :initarg :movecost)))


(defparameter *move-cost* (make-array 50 :initial-element 0))
(setf (aref *move-cost* 40) 10
      (aref *move-cost* 30) 10
      (aref *move-cost* 0)   0)


(defparameter *init-class-list*
  '(:warrior :sorcerer :priest :archer :knight :thief :p-knight))

(defparameter *show-class*
  '(:warrior "戦士" :sorcerer "魔術師" :priest "僧侶" :archer "射手" :knight "騎士" :thief "盗賊"
    :p-knight "天馬騎士"))

(my-enum +job_warrior+ +job_sorcerer+ +job_priest+ +job_archer+ +job_s_knight+ +job_thief+
	 +job_p_knight+
	 +job_brigand+ +job_dragon+ +job_hydra+ +job_yote1+ +job_orc+ +job_slime+ +job_goron+
	 +job_max+)
;;ジョブ
;; (my-enum +job_lord+ +job_paradin+ +job_s_knight+ +job_a_knight+ +job_archer+
;; 	 +job_p_knight+ +job_pirate+ +job_hunter+ +job_thief+ +job_bandit+
;; 	 +job_d_knight+ +job_shogun+ +job_mercenary+ +job_yusha+ +job_max+)

;;movecost= (草原 壁 弱壁 森 低山 高山 水 砦 階段)
(defparameter *jobdescs*
  (make-array +job_max+ :initial-contents
	      (list (make-instance 'jobdesc :name "戦士" :move 2 :img +job_warrior+
				   :canequip '(:sword :spear :ax :item :armor)
				   :lvuprate '(:hp 90 :str 60 :vit 70 :agi 30 :int 10 :res 30)
				   :movecost #(1 -1 -1 2 2 3 -1 1 1) :id :warrior)
		    (make-instance 'jobdesc :name "魔術師" :move 2 :img +job_sorcerer+
				   :canequip '(:wand :item :armor)
				   :lvuprate '(:hp 60 :str 10 :vit 30 :agi 20 :int 90 :res 60)
				   :movecost #(1 -1 -1 2 2 -1 -1 1 1) :id :sorcerer)
		    (make-instance 'jobdesc :name "僧侶" :move 2 :img +job_priest+
				   :canequip '(:staff :item :armor)
				   :lvuprate '(:hp 60 :str 10 :vit 30 :agi 30 :int 80 :res 90)
				   :movecost #(1 -1 -1 2 2 -1 -1 1 1) :id :priest)
		    (make-instance 'jobdesc :name "射手" :move 2 :img +job_archer+
				   :canequip '(:bow :item :armor)
				   :lvuprate '(:hp 70 :str 60 :vit 50 :agi 60 :int 10 :res 40)
				   :movecost #(1 -1 -1 2 2 -1 -1 1 1) :id :archer)
		    (make-instance 'jobdesc :name "騎士" :move 3 :img +job_s_knight+
				   :canequip '(:spear :item :armor)
				   :lvuprate '(:hp 80 :str 90 :vit 70 :agi 40 :int 10 :res 40)
				   :movecost #(1 -1 -1 2 2 3 -1 1 1) :id :s_knight)
		    (make-instance 'jobdesc :name "盗賊" :move 3 :img +job_thief+
				   :canequip '(:sword :item :armor)
				   :lvuprate '(:hp 70 :str 60 :vit 50 :agi 80 :int 10 :res 40)
				   :movecost #(1 -1 -1 2 3 3 2 1 1) :id :thief)
		    (make-instance 'jobdesc :name "天馬騎士" :move 3 :img +job_p_knight+
				   :canequip '(:spear :item :armor)
				   :lvuprate '(:hp 80 :str 60 :vit 70 :agi 60 :int 10 :res 80)
				   :movecost #(1 -1 -1 1 1 1 1 1 1) :id :p_knight)
		    ;;敵
		    (make-instance 'jobdesc :name "ブリガンド" :move 2 :img +job_brigand+
				   :canequip '(:bow :item :armor)
				   :lvuprate '(:hp 70 :str 60 :vit 50 :agi 40 :int 10 :res 40)
				   :movecost #(1 -1 -1 2 2 3 -1 2 1) :id :brigand)
		    (make-instance 'jobdesc :name "ドラゴン" :move 3 :img +job_dragon+
				   :canequip '(:item :armor)
				   :lvuprate '(:hp 90 :str 60 :vit 80 :agi 30 :int 60 :res 60)
				   :movecost #(1 -1 -1 2 2 2 2 1 1) :id :dragon)
		    (make-instance 'jobdesc :name "ヒドラ" :move 2 :img +job_hydra+
				   :canequip '(:item :armor)
				   :lvuprate '(:hp 90 :str 50 :vit 80 :agi 20 :int 10 :res 30)
				   :movecost #(1 -1 -1 2 3 3 1 1 1) :id :hydra)
		    (make-instance 'jobdesc :name "メタルよていち" :move 3 :img +job_yote1+
				   :canequip '(:item :armor)
				   :lvuprate '(:hp 0 :str 20 :vit 90 :agi 90 :int 10 :res 90)
				   :movecost #(1 -1 -1 1 1 1 1 1 1) :id :yote1)
		    (make-instance 'jobdesc :name "オーク" :move 2 :img +job_orc+
				   :canequip '(:spear :item :armor)
				   :lvuprate '(:hp 70 :str 90 :vit 70 :agi 20 :int 10 :res 20)
				   :movecost #(1 -1 -1 2 2 3 -1 1 1) :id :orc)
		    (make-instance 'jobdesc :name "スライム" :move 2 :img +job_slime+
				   :canequip '(:spear :item :armor)
				   :lvuprate '(:hp 50 :str 30 :vit 40 :agi 30 :int 10 :res 30)
				   :movecost #(1 -1 -1 2 2 2 2 1 1) :id :slime)
		    (make-instance 'jobdesc :name "ゴロン" :move 2 :img +job_goron+
				   :canequip '(:item :armor)
				   :lvuprate '(:hp 50 :str 50 :vit 50 :agi 30 :int 10 :res 30)
				   :movecost #(1 -1 -1 2 2 1 1 1 1) :id :goron)
		    )))
		       


;;初期パーティ編成画面用枠
(defparameter *init-party-edit-gamen-btn-pos-list*
  '((40 110 180 150) (40 160 180 200) (40 210 180 250)
    (40 260 180 300) (40 310 180 350) (40 360 180 400)
    (40 410 180 450) (330 110 470 150) (330 160 470 200)
    (330 210 470 250) (330 260 470 300) (330 310 470 350)
    (540 400 680 470)
    ))
(defparameter *init-job1-x1* 40)
(defparameter *init-job1-x2* 180)

(defparameter *init-job1-y1* 110)
(defparameter *init-job1-y2* 150)
(defparameter *init-job2-y1* 160)
(defparameter *init-job2-y2* 200)
(defparameter *init-job3-y1* 210)
(defparameter *init-job3-y2* 250)
(defparameter *init-job4-y1* 260)
(defparameter *init-job4-y2* 300)
(defparameter *init-job5-y1* 310)
(defparameter *init-job5-y2* 350)
(defparameter *init-job6-y1* 360)
(defparameter *init-job6-y2* 400)
(defparameter *init-job7-y1* 410)
(defparameter *init-job7-y2* 450)


(defparameter *init-select-job1-x1* 330)
(defparameter *init-select-job1-x2* 470)

(defparameter *init-select-job1-y1* 110)
(defparameter *init-select-job1-y2* 150)
(defparameter *init-select-job2-y1* 160)
(defparameter *init-select-job2-y2* 200)
(defparameter *init-select-job3-y1* 210)
(defparameter *init-select-job3-y2* 250)
(defparameter *init-select-job4-y1* 260)
(defparameter *init-select-job4-y2* 300)
(defparameter *init-select-job5-y1* 310)
(defparameter *init-select-job5-y2* 350)

(defparameter *init-party-edit-end-x1* 540)
(defparameter *init-party-edit-end-x1* 680)
(defparameter *init-party-edit-end-x1* 400)
(defparameter *init-party-edit-end-x1* 470)



(defclass itemdesc ()
  ((name       :accessor name      :initform nil :initarg :name)
   (price      :accessor price     :initform 0   :initarg :price)
   (new        :accessor new       :initform nil :initarg :new)
   (categoly   :accessor categoly  :initform nil :initarg :categoly)
   (equiped    :accessor equiped   :initform nil :initarg :equiped)
   (damage     :accessor damage    :initform 0   :initarg :damage)
   (hit        :accessor hit       :initform 0   :initarg :hit)
   (atktype    :accessor atktype   :initform :atk :initarg :atktype)
   (tokkou     :accessor tokkou    :initform 0   :initarg :tokkou)
   (critical   :accessor critical  :initform 0   :initarg :critical)
   (rangemin   :accessor rangemin  :initform 0   :initarg :rangemin)
   (rangemax   :accessor rangemax  :initform 0   :initarg :rangemax)
   (blk        :accessor blk      :initform nil :initarg :blk)
   (def        :accessor def       :initform 0   :initarg :def)
   (itemnum        :accessor itemnum      :initform nil :initarg :itemnum)))

(defclass weapondesc (itemdesc)
  ())


(defclass armordesc (itemdesc)
  ())



(defun weapon-make (item)
  (make-instance 'weapondesc :name (getf item :name) :damage (getf item :damage)
		 :hit (getf item :hit) :critical (getf item :critical) :categoly (getf item :categoly)
		 :rangemin (getf item :rangemin) :rangemax (getf item :rangemax)
		 :price (getf item :price) :atktype (getf item :atktype)))

(defun armor-make (item)
  (make-instance 'armordesc :name (getf item :name) :def (getf item :def)
		 :categoly (getf item :categoly)
		 :blk (getf item :blk) :price (getf item :price)))


;;ブラシ生成
(defun set-brush ()
  (setf *brush* (make-array 8 :initial-contents
                              (list
                                (create-solid-brush (encode-rgb 128 0 255))
                                (create-solid-brush (encode-rgb 255 0 0))
                                (create-solid-brush (encode-rgb 1 255 0))
                                (create-solid-brush (encode-rgb 0 0 255))
                                (create-solid-brush (encode-rgb 255 255 0))
                                (create-solid-brush (encode-rgb 0 255 255))
                                (create-solid-brush (encode-rgb 255 0 255))
				(create-solid-brush (encode-rgb 255 255 255))))))

;;font----------------------------------------------------------
(defparameter *font140* nil)
(defparameter *font90* nil)
(defparameter *font70* nil)
(defparameter *font40* nil)
(defparameter *font30* nil)
(defparameter *font20* nil)
(defparameter *font2* nil)

(defun set-font ()
  (setf *font140* (create-font "MSゴシック" :height 140)
        *font90* (create-font "MSゴシック" :height 90)
        *font70* (create-font "MSゴシック" :height 70)
        *font40* (create-font "MSゴシック" :height 40)
        *font30* (create-font "MSゴシック" :height 30)
        *font20* (create-font "MSゴシック" :height 25)
	*font2* (create-font "MSゴシック" :height 15)));; :width 12 :weight (const +fw-bold+))))






;;ジョブデータ取得
(defun get-job-data (job ability)
  (case ability
    (:name     (name     (aref *jobdescs* job)))
    (:move     (move     (aref *jobdescs* job)))
    (:movecost (movecost (aref *jobdescs* job)))
    (:canequip (canequip (aref *jobdescs* job)))
    (:lvuprate (lvuprate (aref *jobdescs* job)))
    (:img      (img      (aref *jobdescs* job)))))

(defun get-cell-data (cell data)
  (case data
    (:heal    (heal  (aref *celldescs* cell)))
    (:def     (def   (aref *celldescs* cell)))
    (:avoid   (avoid (aref *celldescs* cell)))
    (:name    (name  (aref *celldescs* cell)))))
;;-------------------------------------------------------------------
;;武器データ
;; (defstruct weapondesc2
;;   (name   nil)
;;   (price    0) ;;価格
;;   (num      0) ;;使用可能回数
;;   (damage   0)
;;   (weight   0)
;;   (hit      0)
;;   (tokkou   nil)
;;   (critical 0)
;;   (rangeMin 0)
;;   (rangeMax 0))









;武器データ配列
;; (defparameter *weapondescs*
;;   (make-array +w_max+ :initial-contents
;;         (list (make-instance 'weapondesc :name "鉄の剣" :damage 5 
;;                                :hit 100 :critical 0 :rangemin 1
;;                                :rangemax 1 :price 320)
;;               (make-instance 'weapondesc :name "レイピア" :damage 5 
;; 			       :hit 100 :critical 10 :rangemin 1
;; 			       :tokkou (list +job_paradin+ +job_a_knight+ +job_s_knight+
;; 					     +job_shogun+)
;; 			       :rangemax 1 :price 9999)
;;               (make-instance 'weapondesc :name "やり" :damage 8 
;; 			       :hit 80 :critical 0 :rangemin 1
;; 			       :rangemax 1 :price 450)
;;               (make-instance 'weapondesc :name "銀の槍" :damage 12 
;; 			       :hit 80 :critical 0 :rangemin 1
;; 			       :rangemax 1 :price 1800)
;;               (make-instance 'weapondesc :name "てやり" :damage 7 
;; 			       :hit 70 :critical 0 :rangemin 1
;; 			       :rangemax 2 :price 820)
;;               (make-instance 'weapondesc :name "ゆみ" :damage 4 
;; 			       :hit 90 :critical 0 :rangemin 2
;; 			       :tokkou (list +job_p_knight+ +job_d_knight+)
;; 			       :rangemax 2 :price 400)
;;               (make-instance 'weapondesc :name "鋼の弓" :damage 7 
;; 			       :hit 80 :critical 0 :rangemin 2
;; 			       :tokkou (list +job_p_knight+ +job_d_knight+)
;; 			       :rangemax 2 :price 560)
;;               (make-instance 'weapondesc :name "ボウガン" :damage 5 
;; 			       :hit 100 :critical 20 :rangemin 2
;; 			       :tokkou (list +job_p_knight+ +job_d_knight+)
;; 			       :rangemax 2 :price 950)
;;               (make-instance 'weapondesc :name "おの" :damage 7 
;; 			       :hit 80 :critical 0 :rangemin 1
;; 			       :rangemax 1 :price 360)
;;               (make-instance 'weapondesc :name "鋼の斧" :damage 9 
;; 			       :hit 70 :critical 0 :rangemin 1
;; 			       :rangemax 1 :price 550)
;; 	      (make-instance 'weapondesc :name "銀の剣" :damage 12 
;; 			       :hit 100 :critical 0 :rangemin 1
;; 			       :rangemax 1 :price 2000)
;; 	      (make-instance 'weapondesc :name "アーマーキラー" :damage 5 
;; 			       :hit 80 :critical 0 :rangemin 1
;; 			       :tokkou (list +job_a_knight+ +job_shogun+)
;; 			       :rangemax 1 :price 760)
;; 	      (make-instance 'weapondesc :name "ナイトキラー" :damage 5 
;; 			       :hit 90 :critical 0 :rangemin 1
;; 			       :tokkou (list +job_s_knight+)
;; 			       :rangemax 1 :price 820)
;; 	      (make-instance 'weapondesc :name "ハンマー" :damage 6 
;; 			       :hit 70 :critical 0 :rangemin 1
;; 			       :tokkou (list +job_a_knight+ +job_shogun+)
;; 			       :rangemax 1 :price 300)
;; 	      (make-instance 'weapondesc :name "ドラゴンキラー" :damage 6 
;; 			       :hit 80 :critical 0 :rangemin 1
;; 			       :tokkou (list +job_d_knight+)
;; 			       :rangemax 1 :price 5000)
;; 	      (make-instance 'weapondesc :name "ライブ" :damage 0 
;; 			       :hit 100 :critical 0 :rangemin 1 :atktype :heal
;; 			       :rangemax 1 :price 99999)
;; 	      (make-instance 'weapondesc :name "傷薬" :damage 0 
;; 			       :hit 100 :critical 0 :rangemin 1 :atktype :heal
;; 			       :rangemax 1 :price 220)
;; 	      (make-instance 'weapondesc :name "コブシ" :damage 1 
;; 			       :hit 100 :critical 0 :rangemin 1 :atktype :atk
;; 			       :rangemax 1 :price 0)
;; 	      ;;鎧
;; 	      (armor-make "服" 1 0 10)
;; 	      (armor-make "皮の鎧" 2 0 50)
;; 	      (armor-make "鉄の鎧" 3 0 100)
;; 	      ;;盾
;; 	      (armor-make "皮の盾" 0 5 30)
;; 	      (armor-make "鉄の盾" 1 8 80)
;; 	      )))
