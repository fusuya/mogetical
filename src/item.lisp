;;武器 heal:傷薬
(my-enum +w_wood_sword+ +w_knife+ +w_dagger+ +w_silver_knife+ +w_iron_sword +w_Ancient_sword+
	 +w_coral_sword+ +w_silver_sword+ +w_Mithril_knife+ +w_flame_sword+ +w_ice_sword+
	 +w_Mage_masher+ +w_mithril_sword+ +w_Break_blade+ +w_Triton_dagger+ +w_defender+
	 +w_shadow_sword+ +w_Assassin_dagger+ +w_death_sword+ +w_Excalibur+
	 +w_light_bringer+ +w_Ragnarok+
	 
	 +w_spear+ +w_yari+ +w_iron_spear+ +w_wind_spear+ +w_flame_spoear+ +w_ice_spear+
	 +w_silver_spear+ +w_blood_spear+ +w_Gungnir+ +w_hiryu_spear+ +w_holy_spear+
	 +w_cain_spear+ +w_iron_hand_spear+ +w_silver_hand_spear+ +w_mithril_hand_spear+
	 
	 +w_bow+  +w_cross_bow+ +w_big_bow+ +w_power_bow+ +w_killer_bow+ +w_deadly_bow+
	 +w_steel_bow+ +w_elfin_bow_ +w_elf_bow+ +w_yoichi_bow+ +w_Artemis_bow+
	 +w_bowgun+
	 
	 +w_ax+ +w_iron_ax+ +w_Dwarf_ax+ +w_orc_killer+ +w_poison_ax+ +w_ground_hammer+
	 +w_rune_ax+ +w_silver_ax+ +w_steel_ax+ w_Thor_hammer+ +w_gigant_ax+
	 w_Flare_Sledge+ +w_hammer+

	 +w_staff+ +w_heal_staff+ +w_rune_staff+ +w_power_staff+ +w_wave_staff+ +w_sage_staff+
	 +w_seraphim_mace+ +w_live+ +w_Nirvana+
	 
	 +w_rod+ +w_magic_rod+ +w_ice_rod+ +w_flame_rod+ +w_thunder_rod+ +w_witch_rod+
	 +w_change_rod+ +w_fairy_rod+ +w_lure_rod+ +w_stardust_rod+ +w_asura_rod+

	 +w_knuckle+ +w_dragon_crow+ +w_hydra_fang+ +w_numenume+
	 
	 +a_clothes+ +a_Leather_armor+ +a_Iron_armor+ +a_ground_clothes+ +a_magic_robe+
	 +a_dark_armor+ +a_kenpo_wear+ +a_hades_armor+ +a_black_robe+ +a_black_belt_dogi+
	 +a_knight_armor+ +a_mithril_armor+ +a_flame_aarmor+
	 
	 +a_Leather_shield a_iron_shield+ +a_dark_shield+ +a_shadow_shield+ +a_light_shield+
	 +a_mithril_shield+ +a_flame_shield+ +a_ice_shield+ +a_dia_shield+ +a_aegis_shield+
	 +a_dragon_shield+ +a_crystal_shield+ +a_hero_shield+
	 
	 +w_potion+
	 +w_max+
	 )

(defparameter *sword-list*
  (list +w_wood_sword+ +w_knife+ +w_dagger+ +w_silver_knife+ +w_iron_sword +w_Ancient_sword+
	 +w_coral_sword+ +w_silver_sword+ +w_Mithril_knife+ +w_flame_sword+ +w_ice_sword+
	 +w_Mage_masher+ +w_mithril_sword+ +w_Break_blade+ +w_Triton_dagger+ +w_defender+
	 +w_shadow_sword+ +w_Assassin_dagger+ +w_death_sword+ +w_Excalibur+
	 +w_light_bringer+ +w_Ragnarok+))

(defparameter *spear-list* 
  (list +w_spear+ +w_yari+ +w_iron_spear+ +w_wind_spear+ +w_flame_spoear+ +w_ice_spear+
	+w_silver_spear+ +w_blood_spear+ +w_Gungnir+ +w_hiryu_spear+ +w_holy_spear+
	+w_cain_spear+ +w_iron_hand_spear+ +w_silver_hand_spear+ +w_mithril_hand_spear+))

(defparameter *bow-list*
  (list +w_bow+  +w_cross_bow+ +w_big_bow+ +w_power_bow+ +w_killer_bow+ +w_deadly_bow+
	 +w_steel_bow+ +w_elfin_bow_ +w_elf_bow+ +w_yoichi_bow+ +w_Artemis_bow+
	 +w_bowgun+))

(defparameter *ax-list*
  (list +w_ax+ +w_iron_ax+ +w_Dwarf_ax+ +w_orc_killer+ +w_poison_ax+ +w_ground_hammer+
	+w_rune_ax+ +w_silver_ax+ +w_steel_ax+ w_Thor_hammer+ +w_gigant_ax+
	w_Flare_Sledge+ +w_hammer+))

(defparameter *staff-list*
  (list +w_staff+ +w_heal_staff+ +w_rune_staff+ +w_power_staff+ +w_wave_staff+ +w_sage_staff+
	+w_seraphim_mace+ +w_live+ +w_Nirvana+))

(defparameter *rod-list*
  (list +w_rod+ +w_magic_rod+ +w_ice_rod+ +w_flame_rod+ +w_thunder_rod+ +w_witch_rod+
	+w_change_rod+ +w_fairy_rod+ +w_lure_rod+ +w_stardust_rod+ +w_asura_rod+))

(defparameter *knuckle-list*
  (list +w_knuckle+ +w_dragon_crow+ +w_hydra_fang+ +w_numenume+))
	 
(defparameter *clothes-list*
  (list +a_clothes+ +a_Leather_armor+ +a_Iron_armor+ +a_ground_clothes+ +a_magic_robe+
	+a_dark_armor+ +a_kenpo_wear+ +a_hades_armor+ +a_black_robe+ +a_black_belt_dogi+
	+a_knight_armor+ +a_mithril_armor+ +a_flame_aarmor+))

(defparameter *shield-list*
  (list  +a_Leather_shield a_iron_shield+ +a_dark_shield+ +a_shadow_shield+ +a_light_shield+
	 +a_mithril_shield+ +a_flame_shield+ +a_ice_shield+ +a_dia_shield+ +a_aegis_shield+
	 +a_dragon_shield+ +a_crystal_shield+ +a_hero_shield+))
	 


(defparameter *drop1-10* `((,+w_wood_sword+ . 100) (,+w_knife+ . 90) (,+w_dagger+ . 90) (,+w_silver_knife+ . 80)
			   (,+w_iron_sword . 80) (,+w_ancient_sword+ . 70) (,+w_coral_sword+ . 60)
			   (,+w_silver_sword+ . 50) (,+w_Mithril_knife+ . 40)  +w_flame_sword+ +w_ice_sword+
			   +w_Mage_masher+ +w_mithril_sword+ +w_Break_blade+ +w_Triton_dagger+ +w_defender+
			   +w_shadow_sword+ +w_Assassin_dagger+ +w_death_sword+ +w_Excalibur+
			   +w_light_bringer+ +w_Ragnarok+
			   ))

(defun drop-list (lst)
  (loop :for i :in (reverse lst)
     :for rate :from 1 :by (ceiling 100 (length lst))
     :collect (cons i rate)))


(defun create-drop-item-list ()
  (sort (loop :for i :in (list *sword-list* *spear-list* *ax-list* *rod-list* *staff-list* *bow-list* *clothes-list*
			 *shield-list*)
	   :append (drop-list i))
	#'>= :key #'cdr))

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
		 :hit 100 :critical 5 :rangemin 2 :rangemax 3 :price 950
		:tokkou (list +job_p_knight+ +job_d_knight+))
	      ;;斧
              '(:categoly :ax :name "おの" :damage 1 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "鉄の斧" :damage 2 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "ドワーフの斧" :damage 3 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "鬼殺し" :damage 4 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "毒の斧" :damage 5 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "大地のハンマー" :damage 6 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "ルーンアクス" :damage 7 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "銀の斧" :damage 8 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
              '(:categoly :ax :name "鋼の斧" :damage 9 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      '(:categoly :ax :name "トールハンマー" :damage 10 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "ギガントアクス" :damage 11 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "フレアスレッジ" :damage 12 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "ハンマー" :damage 6 :atktype :atk
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
	      '(:categoly :wand :name "魔法のロッド" :damage 2 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "氷のロッド" :damage 3 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "炎のロッド" :damage 4 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "雷のロッド" :damage 5 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "魔女のロッド" :damage 6 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "変化のロッド" :damage 7 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "妖精のロッド" :damage 8 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "誘惑のロッド" :damage 9 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "星屑のロッド" :damage 10 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "アスラのロッド" :damage 11 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)

	      '(:categoly :knuckle :name "コブシ" :damage 1 
		:hit 100 :critical 0 :rangemin 1 :atktype :atk
		:rangemax 1 :price 0)
	      '(:categoly :knuckle :name "ドラゴンの爪" :damage 5 
		:hit 100 :critical 0 :rangemin 1 :atktype :atk
		:rangemax 1 :price 0)
	      '(:categoly :knuckle :name "ヒドラの牙" :damage 3 
		:hit 100 :critical 0 :rangemin 1 :atktype :atk
		:rangemax 1 :price 0)
	      '(:categoly :knuckle :name "ヌメヌメ" :damage 1 
		:hit 100 :critical 0 :rangemin 1 :atktype :atk
		:rangemax 1 :price 0)

	      
	      
	      ;;鎧
	      '(:categoly :armor :name "服"           :def 1  :blk 0 :price 10)
	      '(:categoly :armor :name "皮の鎧"       :def 2  :blk 0 :price 50)
	      '(:categoly :armor :name "鉄の鎧"       :def 3  :blk 0 :price 100)
	      '(:categoly :armor :name "大地の衣"     :def 4  :blk 0 :price 100)
	      '(:categoly :armor :name "魔法のローブ" :def 5  :blk 0 :price 100)
	      '(:categoly :armor :name "暗黒の鎧    " :def 6  :blk 0 :price 100)
	      '(:categoly :armor :name "拳法着"       :def 7  :blk 0 :price 100)
	      '(:categoly :armor :name "ハデスの鎧"   :def 8  :blk 0 :price 100)
	      '(:categoly :armor :name "黒のローブ"   :def 9  :blk 0 :price 100)
	      '(:categoly :armor :name "黒帯道着"     :def 10 :blk 0 :price 100)
	      '(:categoly :armor :name "ナイトの鎧"   :def 11 :blk 0 :price 100)
	      '(:categoly :armor :name "白銀の鎧"     :def 12 :blk 0 :price 100)
	      '(:categoly :armor :name "炎の鎧"       :def 13 :blk 0 :price 100)
	      
	      ;;盾
	      '(:categoly :armor :name "皮の盾"       :def 0  :blk 15 :price 30)
	      '(:categoly :armor :name "鉄の盾"       :def 1  :blk 16 :price 80)
	      '(:categoly :armor :name "暗黒の盾"     :def 2  :blk 16 :price 80)
	      '(:categoly :armor :name "闇の盾"       :def 2  :blk 17 :price 80)
	      '(:categoly :armor :name "光の盾"       :def 3  :blk 17 :price 80)
	      '(:categoly :armor :name "白銀の盾"     :def 4  :blk 18 :price 80)
	      '(:categoly :armor :name "炎の盾"       :def 4  :blk 19 :price 80)
	      '(:categoly :armor :name "氷の盾"       :def 5  :blk 19 :price 80)
	      '(:categoly :armor :name "ダイアの盾"   :def 5  :blk 20 :price 80)
	      '(:categoly :armor :name "イージスの盾" :def 6  :blk 20 :price 80)
	      '(:categoly :armor :name "龍の盾"       :def 6  :blk 22 :price 80)
	      '(:categoly :armor :name "水晶の盾"     :def 7  :blk 22 :price 80)
	      '(:categoly :armor :name "英雄の盾"     :def 8  :blk 25 :price 80)

	      
	      '(:categoly :item :name "傷薬" :damage 8 
		:hit 100 :critical 0 :rangemin 1 :atktype :heal
		:rangemax 1 :price 220)
	      ))

(defparameter *weapondescs*
  (make-array (length *weapon-data*)
	      :initial-contents *weapon-data*))


(defparameter *test-buki-item* nil)

(defun set-test-item-list ()
  (setf *test-buki-item* 
	(loop :for n :from 0 :below (length *weapondescs*)
	   :collect (item-make (aref *weapondescs* n)))))



