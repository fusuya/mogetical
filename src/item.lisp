;;武器 heal:傷薬
(my-enum +w_wood_sword+ +w_knife+ +w_dagger+ +w_silver_knife+ +w_iron_sword +w_Ancient_sword+
	 +w_coral_sword+ +w_silver_sword+ +w_Mithril_knife+ +w_flame_sword+ +w_ice_sword+
	 +w_Mage_masher+ +w_mithril_sword+ +w_Break_blade+ w_Triton_dagger+ +w_defender+
	 +w_rapier+ +w_spear+ +w_silver_spear+ +w_hand_spear+
	 +w_bow+ +w_steal_bow+ +w_cross_bow+ +w_ax+ +w_steal_ax+
	 +w_silver_sword+ +w_armor_killer+ +w_knight_killer+ +w_hammer+
	 +w_dragon_killer+ +w_live+ +w_heal+ +w_knuckle+
	 +a_clothes +a_Leather_armor+ +a_Iron_armor+ +a_Leather_shield
	 a_iron_shield+ +w_max+)

(defparameter *drop1-10* `((,+w_wood_sword+ . 100) (,+w_knife+ . 90) (,+w_dagger+ . 90) (,+w_silver_knife+ . 80)
			   (,+w_iron_sword . 80) (,+w_ancient_sword+ . 70) (,+w_coral_sword+ . 60)))

;武器データ配列
(defparameter *weapon-data*
  ;;剣
	      (list
	       '(:categoly :sword :name "木刀" :damage 1 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 50)
	       '(:categoly :sword :name "ナイフ" :damage 2 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 100)
	       '(:categoly :sword :name "ダガー" :damage 3 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "銀のナイフ" :damage 4 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "鉄の剣" :damage 5 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 320)
	       '(:categoly :sword :name "古代の剣" :damage 6 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "珊瑚の剣" :damage 7 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "銀の剣" :damage 8 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 2000)
	       '(:categoly :sword :name "白銀のナイフ" :damage 8 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "炎の剣" :damage 9 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "氷の剣" :damage 10 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "メイジマッシャー" :damage 10 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "白銀の剣" :damage 11 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "石化剣" :damage 12 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "トリトンダガー" :damage 12 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "ディフェンダー" :damage 13 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "影の剣" :damage 14 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "アサシンダガー" :damage 14 :atktype :atk
		 :hit 100 :critical 20 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "死の剣" :damage 15 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "エクスカリバー" :damage 16 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "光の剣" :damage 17 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "ラグナロク" :damage 18 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)

	       ;;やり
	       '(:categoly :spear :name "スピア" :damage 1 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "やり" :damage 2 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "鉄の槍" :damage 3 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "風の槍" :damage 4 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "炎の槍" :damage 5 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "氷の槍" :damage 6 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "銀の槍" :damage 7 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 1800)
	       '(:categoly :spear :name "血の槍" :damage 8 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "グングニル" :damage 9 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "飛竜の槍" :damage 10 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "聖なる槍" :damage 11 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "カインの槍" :damage 12 :atktype :atk
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "鉄の手槍" :damage 3 :atktype :atk
		 :hit 70 :critical 5 :rangemin 1 :rangemax 2 :price 820)
	       '(:categoly :spear :name "銀の手槍" :damage 6 :atktype :atk
		 :hit 70 :critical 5 :rangemin 1 :rangemax 2 :price 820)
	       '(:categoly :spear :name "白銀の手槍" :damage 8 :atktype :atk
		 :hit 70 :critical 5 :rangemin 1 :rangemax 2 :price 820)
	       ;;弓
	       '(:categoly :bow :name "ゆみ" :damage 1 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "クロスボウ" :damage 2 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "大弓" :damage 3 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "力の弓" :damage 4 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "キラーボウ" :damage 5 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "必殺の弓" :damage 6 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "鋼の弓" :damage 7 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 560
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "エルフィンボウ" :damage 8 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "エルフの弓" :damage 9 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "与一の弓" :damage 10 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "アルテミスの弓" :damage 11 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "ボウガン" :damage 5 :atktype :atk
		 :hit 100 :critical 5 :rangemin 2 :rangemax 2 :price 950
		:tokkou (list +job_p_knight+ +job_d_knight+))
	      ;;斧
              '(:categoly :axe :name "おの" :damage 1 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "鉄の斧" :damage 2 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "ドワーフの斧" :damage 3 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "鬼殺し" :damage 4 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "毒の斧" :damage 5 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "大地のハンマー" :damage 6 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "ルーンアクス" :damage 7 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "銀の斧" :damage 8 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
              '(:categoly :axe :name "鋼の斧" :damage 9 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      '(:categoly :axe :name "トールハンマー" :damage 10 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "ギガントアクス" :damage 11 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "フレアスレッジ" :damage 12 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :axe :name "ハンマー" :damage 6 :atktype :atk
		:hit 70 :critical 0 :rangemin 1
		:tokkou (list +job_a_knight+ +job_shogun+)
		:rangemax 1 :price 300)
	      ;;杖
	      '(:categoly :staff :name "杖" :damage 1 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "癒しの杖" :damage 2 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "ルーンの杖" :damage 3 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "力の杖" :damage 4 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "波動の杖" :damage 5 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "賢者の杖" :damage 6 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "セラフィムメイス" :damage 7 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "ライブ" :damage 8
		:hit 100 :critical 0 :rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "ニルヴァーナ" :damage 9 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      ;;ロッド
	      '(:categoly :wand :name "ロッド" :damage 1 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      
	      '(:categoly :item :name "傷薬" :damage 8 
		:hit 100 :critical 0 :rangemin 1 :atktype :heal
		:rangemax 1 :price 220)
	      '(:categoly :knuckle :name "コブシ" :damage 1 
		:hit 100 :critical 0 :rangemin 1 :atktype :atk
		:rangemax 1 :price 0)
	      ;;鎧
	      '(:categoly :armour :name "服" :def 1 :blk 0 :price 10)
	      '(:categoly :armour :name "皮の鎧" :def 2 :blk 0 :price 50)
	      '(:categoly :armour :name "鉄の鎧" :def 3 :blk 0 :price 100)
	      ;;盾
	      '(:categoly :armour :name "皮の盾" :def 0 :blk 5 :price 30)
	      '(:categoly :armour :name "鉄の盾" :def 1 :blk 8 :price 80)
	      ))

(defparameter *weapondescs*
  (make-array (length *weapon-data*)
	      :initial-contents *weapon-data*))


(defparameter *test-buki-item* nil)

(defun set-test-item-list ()
  (setf *test-buki-item* 
	(loop :for n :from 0 :below (length *weapondescs*)
	   :collect (let ((i (aref *weapondescs* n)))
		      (cond
			((eq :armour (getf i :categoly))
			 (armour-make i))
			(t (weapon-make i)))))))



