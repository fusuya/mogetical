;;武器 heal:傷薬
(my-enum +w_wood_sword+ +w_knife+ +w_dagger+ +w_silver_knife+ +w_iron_sword +w_Ancient_sword+
	 +w_coral_sword+ +w_broad_sword+  +w_silver_sword+ +w_Mithril_knife+ +w_flame_sword+ +w_ice_sword+
	 +w_Mage_masher+ +w_mithril_sword+ +w_Break_blade+ +w_flame_tan +w_ice_brand+ +w_blood_sword+  +w_Triton_dagger+ +w_defender+
	 +w_shadow_sword+ +w_Assassin_dagger+ +w_death_sword+ +w_Excalibur+ +w_Apocalypse+
	 +w_light_bringer+ +w_Ragnarok+
	 
	 +w_spear+ +w_yari+ +w_iron_spear+ +w_trident+ +w_iron_hand_spear+
	 +w_heavy_lance+  +w_wind_spear+ +w_flame_spoear+ +w_ice_spear+
	 +w_Javelin+
	 +w_silver_spear+ +w_silver_hand_spear+ +w_blood_spear+
	 +w_partisan+ +w_mithril_hand_spear+ +w_Gungnir+ +w_hiryu_spear+
	 +w_holy_spear+ +w_Longinus+
	 +w_cain_spear+
	 
	 +w_bow+  +w_cross_bow+ +w_big_bow+ +w_power_bow+ +w_killer_bow+
	 +w_bowgun+ +w_deadly_bow+
	 +w_steel_bow+ +w_flame_bow+ +w_ice_bow+ +w_thunder_bow+
	 +w_Gale_bow+ +w_fairy_bow+
	 +w_elfin_bow_ +w_elf_bow+ +w_yoichi_bow+ +w_Artemis_bow+
	 
	 
	 +w_ax+ +w_iron_ax+ +w_hammer+ +w_Dwarf_ax+ +w_orc_killer+ +w_poison_ax+ +w_ground_hammer+
	 +w_rune_ax+ +w_silver_ax+ +w_steel_ax+ +w_battle_ax+
	 +w_death_sickle+ +w_giant_ax+ +w_Thor_hammer+ +w_gigant_ax+
	 +w_earth_breaker+
	 w_Flare_Sledge+ +w_destroyer+

	 +w_staff+ +w_flail+ +w_heal_staff+ +w_rune_staff+ +w_power_staff+
	 +w_judgment_staff+ +w_wave_staff+ +w_wonder_staff+ +w_light_staff+
	 +w_sage_staff+
	 +w_seraphim_mace+ +w_live+ +w_Mace_of_Zeus+  +w_Nirvana+
	 
	 +w_rod+ +w_magic_rod+ +w_ice_rod+ +w_flame_rod+ +w_thunder_rod+ +w_witch_rod+ +w_wizard_rod+
	 +w_change_rod+ +w_poison_rod+  +w_fairy_rod+ +w_lure_rod+
	 +w_lilith_rod+ +w_wonder_rod+  +w_stardust_rod+
	 +w_daemon_rod+ +w_asura_rod+

	 +w_knuckle+ +w_dragon_crow+ +w_hydra_fang+ +w_numenume+
	 
	 +a_clothes+ +a_Leather_armor+ +a_Iron_armor+ +a_ground_clothes+ +a_magic_robe+
	 +a_dark_armor+ +a_kenpo_wear+ +a_bone_armor+ +a_hades_armor+ +a_black_robe+ +a_black_belt_dogi+
	 +a_knight_armor+ +a_mithril_armor+ +a_flame_aarmor+
	 +a_ice_armor+ +a_thunder_armor+ +a_dia_armor+
	 +a_crystal_armor+ +a_mirror_armor+ +a_genzi_armor+
	 +a_Maximilian+
	 
	 +a_Leather_shield+ +a_buckler+ +a_iron_shield+ +a_big_shield+ +a_bronze_shield+
	 +a_dark_shield+ +a_silver_shield+  +a_shadow_shield+ +a_gold_shield+
	 +a_light_shield+
	 +a_mithril_shield+ +a_flame_shield+ +a_ice_shield+ +a_force_shield+
	 +a_dia_shield+ +a_aegis_shield+
	 +a_dragon_shield+ +a_crystal_shield+ +a_genzi_shield+ +a_hero_shield+
	 
	 +w_potion+
	 +w_max+
	 )

(defparameter *sword-list*
  (list +w_wood_sword+ +w_knife+ +w_dagger+ +w_silver_knife+ +w_iron_sword +w_Ancient_sword+
	 +w_coral_sword+ +w_broad_sword+  +w_silver_sword+ +w_Mithril_knife+ +w_flame_sword+ +w_ice_sword+
	 +w_Mage_masher+ +w_mithril_sword+ +w_Break_blade+ +w_flame_tan +w_ice_brand+ +w_blood_sword+  +w_Triton_dagger+ +w_defender+
	 +w_shadow_sword+ +w_Assassin_dagger+ +w_death_sword+ +w_Excalibur+ +w_Apocalypse+
	 +w_light_bringer+ +w_Ragnarok+))

(defparameter *spear-list* 
  (list +w_spear+ +w_yari+ +w_iron_spear+ +w_trident+ +w_iron_hand_spear+
	 +w_heavy_lance+  +w_wind_spear+ +w_flame_spoear+ +w_ice_spear+
	 +w_Javelin+
	 +w_silver_spear+ +w_silver_hand_spear+ +w_blood_spear+
	 +w_partisan+ +w_mithril_hand_spear+ +w_Gungnir+ +w_hiryu_spear+
	 +w_holy_spear+ +w_Longinus+
	 +w_cain_spear+))

(defparameter *bow-list*
  (list +w_bow+  +w_cross_bow+ +w_big_bow+ +w_power_bow+ +w_killer_bow+
	 +w_bowgun+ +w_deadly_bow+
	 +w_steel_bow+ +w_flame_bow+ +w_ice_bow+ +w_thunder_bow+
	 +w_Gale_bow+ +w_fairy_bow+
	 +w_elfin_bow_ +w_elf_bow+ +w_yoichi_bow+ +w_Artemis_bow+))

(defparameter *ax-list*
  (list +w_ax+ +w_iron_ax+ +w_hammer+ +w_Dwarf_ax+ +w_orc_killer+ +w_poison_ax+ +w_ground_hammer+
	 +w_rune_ax+ +w_silver_ax+ +w_steel_ax+ +w_battle_ax+
	 +w_death_sickle+ +w_giant_ax+ +w_Thor_hammer+ +w_gigant_ax+
	 +w_earth_breaker+
	 w_Flare_Sledge+ +w_destroyer+))

(defparameter *staff-list*
  (list +w_staff+ +w_flail+ +w_heal_staff+ +w_rune_staff+ +w_power_staff+
	 +w_judgment_staff+ +w_wave_staff+ +w_wonder_staff+ +w_light_staff+
	 +w_sage_staff+
	 +w_seraphim_mace+ +w_live+ +w_Mace_of_Zeus+  +w_Nirvana+))

(defparameter *rod-list*
  (list +w_rod+ +w_magic_rod+ +w_ice_rod+ +w_flame_rod+ +w_thunder_rod+ +w_witch_rod+ +w_wizard_rod+
	 +w_change_rod+ +w_poison_rod+  +w_fairy_rod+ +w_lure_rod+
	 +w_lilith_rod+ +w_wonder_rod+  +w_stardust_rod+
	 +w_daemon_rod+ +w_asura_rod+))

(defparameter *knuckle-list*
  (list +w_knuckle+ +w_dragon_crow+ +w_hydra_fang+ +w_numenume+))
	 
(defparameter *clothes-list*
  (list +a_clothes+ +a_Leather_armor+ +a_Iron_armor+ +a_ground_clothes+ +a_magic_robe+
	 +a_dark_armor+ +a_kenpo_wear+ +a_bone_armor+ +a_hades_armor+ +a_black_robe+ +a_black_belt_dogi+
	 +a_knight_armor+ +a_mithril_armor+ +a_flame_aarmor+
	 +a_ice_armor+ +a_thunder_armor+ +a_dia_armor+
	 +a_crystal_armor+ +a_mirror_armor+ +a_genzi_armor+
	 +a_Maximilian+))

(defparameter *shield-list*
  (list  +a_Leather_shield+ +a_buckler+ +a_iron_shield+ +a_big_shield+ +a_bronze_shield+
	 +a_dark_shield+ +a_silver_shield+  +a_shadow_shield+ +a_gold_shield+
	 +a_light_shield+
	 +a_mithril_shield+ +a_flame_shield+ +a_ice_shield+ +a_force_shield+
	 +a_dia_shield+ +a_aegis_shield+
	 +a_dragon_shield+ +a_crystal_shield+ +a_genzi_shield+ +a_hero_shield+))
	 



(defun drop-list (lst)
  (loop :for i :in (reverse lst)
     :for rate :from 1 
     :collect (cons i (expt 1.27 rate))))


(defun create-drop-item-list (lst)
  (sort (loop :for i :in lst
	   :append (drop-list i))
	#'>= :key #'cdr))


(defparameter *warrior-weapon*  nil)
(defparameter *sorcerar-weapon* nil)
(defparameter *priest-weapon*   nil)
(defparameter *thief-weapon*    nil)
(defparameter *archer-weapon*   nil)
(defparameter *knight-weapon*   nil)
(defparameter *armor-list*      nil)

(defun init-weapon-list ()
  (setf *warrior-weapon* (create-drop-item-list (list *sword-list* *spear-list* *ax-list*))
	*sorcerar-weapon* (create-drop-item-list (list *rod-list*))
	*priest-weapon* (create-drop-item-list (list *staff-list*))
	*thief-weapon* (create-drop-item-list (list *sword-list*))
	*archer-weapon* (create-drop-item-list (list *bow-list*))
	*knight-weapon* (create-drop-item-list (list *spear-list*))
	*armor-list* (create-drop-item-list (list *clothes-list* *shield-list* ))))

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
	       '(:categoly :sword :name "ブロードソード" :damage 8 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "銀の剣" :damage 9 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 2000)
	       '(:categoly :sword :name "白銀のナイフ" :damage 9 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "炎の剣" :damage 10 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "氷の剣" :damage 11 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "メイジマッシャー" :damage 11 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "白銀の剣" :damage 12 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "石化剣" :damage 13 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "フレイムタン" :damage 14 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "アイスブランド" :damage 15 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "ブラッドソード" :damage 16 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "トリトンダガー" :damage 17 :atktype :atk
		 :hit 100 :critical 15 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "ディフェンダー" :damage 18 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "影の剣" :damage 19 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "アサシンダガー" :damage 19 :atktype :atk
		 :hit 100 :critical 20 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "死の剣" :damage 20 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "エクスカリバー" :damage 21 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "アポカリプス" :damage 22 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "光の剣" :damage 23 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)
	       '(:categoly :sword :name "ラグナロク" :damage 24 :atktype :atk
		 :hit 90 :critical 10 :rangemin 1 :rangemax 1 :price 150)

	       ;;やり
	       '(:categoly :spear :name "スピア" :damage 1 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "やり" :damage 2 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "鉄の槍" :damage 3 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "トライデント" :damage 4 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "鉄の手槍" :damage 3 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 70 :critical 5 :rangemin 1 :rangemax 2 :price 820)
	       '(:categoly :spear :name "ヘビィランス" :damage 5 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "風の槍" :damage 6 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "炎の槍" :damage 7 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "氷の槍" :damage 8 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "ジャベリン" :damage 8 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 2 :price 450)
	       '(:categoly :spear :name "銀の槍" :damage 10 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 1800)
	       '(:categoly :spear :name "銀の手槍" :damage 10 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 70 :critical 5 :rangemin 1 :rangemax 2 :price 820)
	       '(:categoly :spear :name "血の槍" :damage 11 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "パルチザン" :damage 12 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "白銀の手槍" :damage 12 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 70 :critical 5 :rangemin 1 :rangemax 2 :price 820)
	       '(:categoly :spear :name "グングニル" :damage 13 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "飛竜の槍" :damage 14 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "聖なる槍" :damage 15 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "ロンギヌス" :damage 16 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       '(:categoly :spear :name "カインの槍" :damage 17 :atktype :atk
		 :tokkou (list +job_s_knight+)
		 :hit 80 :critical 20 :rangemin 1 :rangemax 1 :price 450)
	       
	      
	       
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
	       '(:categoly :bow :name "ボウガン" :damage 5 :atktype :atk
		 :hit 100 :critical 5 :rangemin 2 :rangemax 3 :price 950
		:tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "必殺の弓" :damage 6 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "鋼の弓" :damage 7 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 560
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "炎の弓" :damage 8 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "氷の弓" :damage 9 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "雷の弓" :damage 10 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "疾風の弓" :damage 11 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "妖精の弓" :damage 12 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "エルフィンボウ" :damage 13 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "エルフの弓" :damage 14 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "与一の弓" :damage 15 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       '(:categoly :bow :name "アルテミスの弓" :damage 16 :atktype :atk
		 :hit 90 :critical 10 :rangemin 2 :rangemax 2 :price 400
		 :tokkou (list +job_p_knight+ +job_d_knight+))
	       
	      ;;斧
              '(:categoly :ax :name "おの" :damage 1 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "鉄の斧" :damage 2 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "ハンマー" :damage 3 :atktype :atk
		:hit 70 :critical 0 :rangemin 1 :rangemax 1 :price 300)
	      '(:categoly :ax :name "ドワーフの斧" :damage 4 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "鬼殺し" :damage 5 :atktype :atk
		:tokkou (list +job_orc+)
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "毒の斧" :damage 6 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "大地のハンマー" :damage 7 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "ルーンアクス" :damage 8 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "銀の斧" :damage 9 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
              '(:categoly :ax :name "鋼の斧" :damage 10 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      '(:categoly :ax :name "バトルアクス" :damage 11 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      '(:categoly :ax :name "デスシックル" :damage 12 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      '(:categoly :ax :name "巨人の斧" :damage 13 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      '(:categoly :ax :name "トールハンマー" :damage 14 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "ギガントアクス" :damage 15 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "アースブレイカー" :damage 16 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      '(:categoly :ax :name "フレアスレッジ" :damage 17 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 360)
	      '(:categoly :ax :name "デストロイヤー" :damage 18 :atktype :atk
		:hit 70 :critical 40 :rangemin 1 :rangemax 1 :price 550)
	      
	      ;;杖
	      '(:categoly :staff :name "杖" :damage 1 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "フレイル" :damage 2 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "癒しの杖" :damage 3 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "ルーンの杖" :damage 4 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "力の杖" :damage 5 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "裁きの杖" :damage 6 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "波動の杖" :damage 7 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "不思議な杖" :damage 8 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "光の杖" :damage 9 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "賢者の杖" :damage 10 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "セラフィムメイス" :damage 11 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "ライブ" :damage 12
		:hit 100 :critical 0 :rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "メイスオブゼウス" :damage 13 :hit 100 :critical 0
		:rangemin 1 :atktype :heal :rangemax 1 :price 999)
	      '(:categoly :staff :name "ニルヴァーナ" :damage 14 :hit 100 :critical 0
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
	      '(:categoly :wand :name "ウィザードロッド" :damage 7 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "変化のロッド" :damage 8 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "毒のロッド" :damage 9 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "妖精のロッド" :damage 10 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "誘惑のロッド" :damage 11 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "リリスのロッド" :damage 12 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "ワンダーロッド" :damage 13 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "星屑のロッド" :damage 14 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "デモンズロッド" :damage 15 :hit 100 :critical 0
		:rangemin 1 :atktype :atk :rangemax 2 :price 999)
	      '(:categoly :wand :name "アスラのロッド" :damage 16 :hit 100 :critical 0
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
	      '(:categoly :armor :name "服"             :def 5   :blk 0 :price 10)
	      '(:categoly :armor :name "皮の鎧"         :def 7   :blk 0 :price 50)
	      '(:categoly :armor :name "鉄の鎧"         :def 9   :blk 0 :price 100)
	      '(:categoly :armor :name "大地の衣"       :def 11  :blk 0 :price 100)
	      '(:categoly :armor :name "魔法のローブ"   :def 13  :blk 0 :price 100)
	      '(:categoly :armor :name "暗黒の鎧    "   :def 15  :blk 0 :price 100)
	      '(:categoly :armor :name "拳法着"         :def 17  :blk 0 :price 100)
	      '(:categoly :armor :name "骨の鎧"         :def 19  :blk 0 :price 100)
	      '(:categoly :armor :name "ハデスの鎧"     :def 21  :blk 0 :price 100)
	      '(:categoly :armor :name "黒のローブ"     :def 22  :blk 0 :price 100)
	      '(:categoly :armor :name "黒帯道着"       :def 24  :blk 0 :price 100)
	      '(:categoly :armor :name "ナイトの鎧"     :def 26  :blk 0 :price 100)
	      '(:categoly :armor :name "白銀の鎧"       :def 28  :blk 0 :price 100)
	      '(:categoly :armor :name "炎の鎧"         :def 30  :blk 0 :price 100)
	      '(:categoly :armor :name "氷の鎧"         :def 32  :blk 0 :price 100)
	      '(:categoly :armor :name "雷の鎧"         :def 34  :blk 0 :price 100)
	      '(:categoly :armor :name "ダイアの鎧"     :def 36  :blk 0 :price 100)
	      '(:categoly :armor :name "水晶の鎧"       :def 38  :blk 0 :price 100)
	      '(:categoly :armor :name "鏡の鎧"         :def 40  :blk 0 :price 100)
	      '(:categoly :armor :name "源氏の鎧"       :def 42  :blk 0 :price 100)
	      '(:categoly :armor :name "マクシミリアン" :def 44  :blk 0 :price 100)
	      
	      ;;盾
	      '(:categoly :armor :name "皮の盾"       :def 0  :blk 15 :price 30)
	      '(:categoly :armor :name "バックラー"   :def 1  :blk 16 :price 30)
	      '(:categoly :armor :name "鉄の盾"       :def 2  :blk 17 :price 80)
	      '(:categoly :armor :name "大盾"         :def 3  :blk 18 :price 80)
	      '(:categoly :armor :name "銅の盾"       :def 4  :blk 19 :price 80)
	      '(:categoly :armor :name "暗黒の盾"     :def 5  :blk 21 :price 80)
	      '(:categoly :armor :name "銀の盾"       :def 6  :blk 23 :price 80)
	      '(:categoly :armor :name "闇の盾"       :def 7  :blk 25 :price 80)
	      '(:categoly :armor :name "金の盾"       :def 8  :blk 27 :price 80)
	      '(:categoly :armor :name "光の盾"       :def 9  :blk 29 :price 80)
	      '(:categoly :armor :name "白銀の盾"     :def 10 :blk 31 :price 80)
	      '(:categoly :armor :name "炎の盾"       :def 11 :blk 32 :price 80)
	      '(:categoly :armor :name "氷の盾"       :def 12 :blk 33 :price 80)
	      '(:categoly :armor :name "力の盾"       :def 13 :blk 34 :price 80)
	      '(:categoly :armor :name "ダイアの盾"   :def 14 :blk 35 :price 80)
	      '(:categoly :armor :name "イージスの盾" :def 15 :blk 36 :price 80)
	      '(:categoly :armor :name "龍の盾"       :def 16 :blk 37 :price 80)
	      '(:categoly :armor :name "水晶の盾"     :def 17 :blk 38 :price 80)
	      '(:categoly :armor :name "源氏の盾"     :def 18 :blk 39 :price 80)
	      '(:categoly :armor :name "英雄の盾"     :def 20 :blk 40 :price 80)

	      
	      '(:categoly :item :name "傷薬" :damage 8 
		:hit 100 :critical 0 :rangemin 1 :atktype :heal
		:rangemax 1 :price 220)
	      ))

(defparameter *weapondescs*
  (make-array (length *weapon-data*)
	      :initial-contents *weapon-data*))


(defun item-make (itemnum)
  (let* ((item (aref *weapondescs* itemnum))
	(cat (getf item :categoly)))
    (case cat
      (:armor
       (make-instance 'armordesc :name (getf item :name) :def (getf item :def)
		 :categoly cat :itemnum itemnum
		 :blk (getf item :blk) :price (getf item :price)))
      (otherwise
       (make-instance 'weapondesc :name (getf item :name) :damage (getf item :damage)
		 :hit (getf item :hit) :critical (getf item :critical) :categoly cat
		 :rangemin (getf item :rangemin) :rangemax (getf item :rangemax)
		 :tokkou (getf item :tokkou) :itemnum itemnum
		 :price (getf item :price) :atktype (getf item :atktype))))))

(defparameter *test-buki-item* nil)

(defun set-test-item-list ()
  (setf *test-buki-item* 
	(loop :for n :from 0 :below (length *weapondescs*)
	   :collect (item-make n))))


;;重み付け抽選-----------------------------------------------
(defun rnd-pick (i rnd lst len)
  (if (= i len)
      (1- i)
      (if (< rnd (nth i lst))
	  i
	  (rnd-pick (1+ i) (- rnd (nth i lst)) lst len))))
;;lst = *copy-buki*
(defun weightpick (lst)
  (let* ((lst1 (mapcar #'cdr lst))
	 (total-weight (apply #'+ lst1))
	 (len (length lst1))
	 (rnd (random total-weight)))
    (car (nth (rnd-pick 0 rnd lst1 len) lst))))
;;------------------------------------------------------------

;;ジョブ別初期武器
(defun job-init-weapon (job)
  (cond
    ((= job +job_warrior+)  (item-make +w_wood_sword+))
    ((= job +job_sorcerer+) (item-make +w_rod+))
    ((= job +job_priest+)   (item-make +w_staff+))
    ((= job +job_archer+)   (item-make +w_bow+))
    ((= job +job_s_knight+) (item-make +w_spear+))
    ((= job +job_thief+)    (item-make +w_knife+))
    ((= job +job_p_knight+) (item-make +w_spear+))
    ((= job +job_brigand+)  (item-make +w_bow+))
    ((= job +job_dragon+)   (item-make +w_dragon_crow+))
    ((= job +job_hydra+)    (item-make +w_hydra_fang+))
    ((= job +job_orc+)      (item-make +w_ax+))
    ((= job +job_slime+)    (item-make +w_numenume+))
    ((= job +job_yote1+)    (item-make +w_numenume+))
    ((= job +job_goron+)    (item-make +w_numenume+))))
    


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
