-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- 60309 hand ESQUERDA
-- 28422 hand DIREITA
-- 50 NÃO REPETE
-- 49 REPETE
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_min = 5.0
local fov_max = 70.0
local binoculos = false
local camera = false
local fov = (fov_max+fov_min)*0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local animacoes = {
	-- ANIMACOES FAST VIADO
	{ nome = "lanca", dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca" , flag = 49 , hand = 28422 },
    { nome = "lanca2", dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca_02" , flag = 49 , hand = 28422 },
	-- ANIMACOES NORMAIS
	{ nome = "radio2" , prop = "prop_boombox_01" , flag = 50 , hand = 57005 , pos1 = 0.30 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "radio3" , prop = "prop_portable_hifi_01" , flag = 50 , hand = 28422 , pos1 = 0.26 , pos2 = 0.1 , pos3 = 0.08 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa" , prop = "prop_ld_case_01" , flag = 50 , hand = 57005 , pos1 = 0.16 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa2" , prop = "prop_ld_case_01_s" , flag = 50 , hand = 57005 , pos1 = 0.16 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa3" , prop = "prop_security_case_01" , flag = 50 , hand = 57005 , pos1 = 0.16 , pos2 = 0 , pos3 = -0.01 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa4" , prop = "w_am_case" , flag = 50 , hand = 57005 , pos1 = 0.08 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 266.0 , pos6 = 60.0 },
	{ nome = "bolsa5" , prop = "prop_ld_suitcase_01" , flag = 50 , hand = 57005 , pos1 = 0.39 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa6" , prop = "xm_prop_x17_bag_med_01a" , flag = 50 , hand = 57005 , pos1 = 0.43 , pos2 = 0 , pos3 = 0.04 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "lixo" , prop = "prop_cs_rub_binbag_01" , flag = 50 , hand = 57005 , pos1 = 0.11 , pos2 = 0 , pos3 = 0.0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "mic" , prop = "prop_microphone_02" , flag = 50 , hand = 60309 , pos1 = 0.08 , pos2 = 0.03 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "mic2" , prop = "p_ing_microphonel_01" , flag = 50 , hand = 60309 , pos1 = 0.08 , pos2 = 0.03 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "mic3" , dict = "missfra1" , anim = "mcs2_crew_idle_m_boom" , prop = "prop_v_bmike_01" , flag = 50 , hand = 28422 },
	{ nome = "mic4" , dict = "missmic4premiere" , anim = "interview_short_lazlow" , prop = "p_ing_microphonel_01" , flag = 50 , hand = 28422 },
	{ nome = "mic5" , dict = "anim@random@shop_clothes@watches" , anim = "base" , prop = "p_ing_microphonel_01" , andar = true , loop = true , flag = 49 , hand = 60309 , pos1 = 0.10 , pos2 = 0.04 , pos3 = 0.012 , pos4 = -60.0 , pos5 = 60.0 , pos6 = -30.0 , propAnim = true },
	{ nome = "buque" , prop = "prop_snow_flower_02" , flag = 50 , hand = 60309 , pos1 = 0.0 , pos2 = 0.0 , pos3 = 0.0 , pos4 = 300.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "rosa" , prop = "prop_single_rose" , flag = 50 , hand = 60309 , pos1 = 0.055 , pos2 = 0.05 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "cigarro" , prop = "prop_cigar_02" , flag = 49 , hand = 47419 , pos1 = 0.010 , pos2 = 0 , pos3 = 0 , pos4 = 50.0 , pos5 = 0.0 , pos6 = -80.0 },
	{ nome = "prebeber" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_fib_coffee" , flag = 49 , hand = 28422 },
	{ nome = "prebeber2" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_ld_flow_bottle" , flag = 49 , hand = 28422 },
	{ nome = "prebeber3" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_cs_bs_cup" , flag = 49 , hand = 28422 },
	{ nome = "verificar" , dict = "amb@medic@standing@tendtodead@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "mexer" , dict = "amb@prop_human_parking_meter@female@idle_a" , anim = "idle_a_female" , andar = true , loop = true },
	{ nome = "cuidar" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_pumpchest" , andar = true , loop = true, ProibidoArmado = true },
	{ nome = "cuidar2" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_kol" , andar = true , loop = true, ProibidoArmado = true },
	{ nome = "cuidar3" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_kol_idle" , andar = true , loop = true, ProibidoArmado = true },
	{ nome = "cansado" , dict = "rcmbarry" , anim = "idle_d" , andar = false , loop = true },
	{ nome = "spiderman" , dict = "missexile3" , anim = "ex03_train_roof_idle" , andar = false , loop = true },
	{ nome = "meleca" , dict = "anim@mp_player_intuppernose_pick" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "meleca2" , dict = "anim@mp_player_intcelebrationfemale@nose_pick" , anim = "nose_pick" , andar = false , loop = false },
	{ nome = "meleca3" , dict = "move_p_m_two_idles@generic" , anim = "fidget_sniff_fingers" , andar = true , loop = false },
	{ nome = "bora" , dict = "missfam4" , anim = "say_hurry_up_a_trevor" , andar = true , loop = false },
	{ nome = "selimpar" , dict = "missfbi3_camcrew" , anim = "final_loop_guy" , andar = true , loop = false },
	{ nome = "galinha" , dict = "random@peyote@chicken" , anim = "wakeup" , andar = true , loop = true },
	{ nome = "amem" , dict = "rcmepsilonism8" , anim = "worship_base" , andar = true , loop = true },
	{ nome = "nervoso" , dict = "rcmme_tracey1" , anim = "nervous_loop" , andar = true , loop = true },
	{ nome = "morrer" , dict = "misslamar1dead_body" , anim = "dead_idle" , andar = false , loop = true },
	{ nome = "ajoelhar" , dict = "amb@medic@standing@kneel@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "naruto" , dict = "missfbi1" , anim = "ledge_loop" , andar = true , loop = true },
	{ nome = "naruto2" , dict = "missfam5_yoga" , anim = "a2_pose" , andar = true , loop = true },
	{ nome = "rebolar" , dict = "switch@trevor@mocks_lapdance" , anim = "001443_01_trvs_28_idle_stripper" , andar = false , loop = true },
	{ nome = "celebrar" , dict = "rcmfanatic1celebrate" , anim = "celebrate" , andar = false , loop = false },
	{ nome = "morto" , dict = "anim@mp_player_intcelebrationmale@cut_throat" , anim = "cut_throat" , andar = true , loop = false },
	{ nome = "morto2" , dict = "anim@mp_player_intcelebrationfemale@cut_throat" , anim = "cut_throat" , andar = true , loop = false },
	{ nome = "sinalizar" , dict = "amb@world_human_car_park_attendant@male@base" , anim = "base" , prop = "prop_parking_wand_01" , flag = 49 , hand = 28422 },
	{ nome = "placa" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_01" , flag = 49 , hand = 28422 },
	{ nome = "placa2" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_03" , flag = 49 , hand = 28422 },
	{ nome = "placa3" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_04" , flag = 49 , hand = 28422 },
	{ nome = "tablet" , dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a" , anim = "idle_b" , prop = "prop_cs_tablet" , flag = 49 , hand = 60309 },
	{ nome = "abanar" , dict = "timetable@amanda@facemask@base" , anim = "base" , andar = true , loop = true },
	{ nome = "cocada" , dict = "mp_player_int_upperarse_pick" , anim = "mp_player_int_arse_pick" , andar = true , loop = true },
	{ nome = "cocada2" , dict = "mp_player_int_uppergrab_crotch" , anim = "mp_player_int_grab_crotch" , andar = true , loop = true },
	{ nome = "lero" , dict = "anim@mp_player_intselfiejazz_hands" , anim = "idle_a" , andar = true , loop = false },
	{ nome = "lero2" , dict = "anim@mp_player_intcelebrationfemale@thumb_on_ears" , anim = "thumb_on_ears" , andar = false , loop = false },
	{ nome = "lero3" , dict = "anim@mp_player_intcelebrationfemale@cry_baby" , anim = "cry_baby" , andar = false , loop = false },
	{ nome = "beijo" , dict = "anim@mp_player_intselfieblow_kiss" , anim = "exit" , andar = true , loop = false, ProibidoArmado = true },
	{ nome = "beijo2" , dict = "anim@mp_player_intcelebrationfemale@blow_kiss" , anim = "blow_kiss" , andar = true , loop = false, ProibidoArmado = true },
	{ nome = "malicia" , dict = "anim@mp_player_intupperdock" , anim = "idle_a" , andar = true , loop = false, ProibidoArmado = true },
	{ nome = "ligar" , dict = "cellphone@" , anim = "cellphone_call_in" , prop = "prop_amb_phone" , flag = 50 , hand = 28422 },
	{ nome = "radio" , dict = "cellphone@" , anim = "cellphone_call_in" , prop = "prop_cs_hand_radio" , flag = 50 , hand = 28422 },
	{ nome = "cafe" , dict = "amb@world_human_aa_coffee@base" , anim = "base" , prop = "prop_fib_coffee" , flag = 50 , hand = 28422 },
	{ nome = "cafe2" , dict = "amb@world_human_aa_coffee@idle_a" , anim = "idle_a" , prop = "prop_fib_coffee" , flag = 49 , hand = 28422 },
	{ nome = "caixa" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "hei_prop_heist_box" , flag = 50 , hand = 28422 },
	{ nome = "caixa2" , prop = "prop_tool_box_04" , flag = 50 , hand = 57005 , pos1 = 0.45 , pos2 = 0 , pos3 = 0.05 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "caixa3" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "xm_prop_smug_crate_s_medical" , flag = 50 , hand = 28422 },
	{ nome = "bateria" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "prop_car_battery_01" , flag = 50 , hand = 28422 },
	{ nome = "pneu" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "prop_wheel_tyre" , flag = 50 , hand = 28422 },
	{ nome = "chuva" , dict = "amb@world_human_drinking@coffee@male@base" , anim = "base" , prop = "p_amb_brolly_01" , flag = 50 , hand = 28422 },
	{ nome = "chuva2" , dict = "amb@world_human_drinking@coffee@male@base" , anim = "base" , prop = "p_amb_brolly_01_s" , flag = 50 , hand = 28422 },
	{ nome = "comer" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_cs_burger_01" , flag = 49 , hand = 28422 },
	{ nome = "comer2" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_cs_hotdog_01" , flag = 49 , hand = 28422 },
	{ nome = "comer3" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_amb_donut" , flag = 49 , hand = 28422 },
	{ nome = "comer4" , dict = "mp_player_inteat@burger" , anim = "mp_player_int_eat_burger" , prop = "prop_sandwich_01" , flag = 49 , hand = 60309 },
	{ nome = "comer5" , dict = "mp_player_inteat@burger" , anim = "mp_player_int_eat_burger" , prop = "prop_choc_ego" , flag = 49 , hand = 60309 },
	{ nome = "beber" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "p_cs_bottle_01" , flag = 49 , hand = 28422 },
	{ nome = "beber2" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_energy_drink" , flag = 49 , hand = 28422 },
	{ nome = "beber3" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_amb_beer_bottle" , flag = 49 , hand = 28422 },
	{ nome = "beber4" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "p_whiskey_notop" , flag = 49 , hand = 28422 },
	{ nome = "beber5" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_beer_logopen" , flag = 49 , hand = 28422 },
	{ nome = "beber6" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_beer_blr" , flag = 49 , hand = 28422 },
	{ nome = "beber7" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_ld_flow_bottle" , flag = 49 , hand = 28422 },
	{ nome = "beber8" , dict = "amb@world_human_drinking@coffee@male@idle_a" , anim = "idle_c" , prop = "prop_drink_whisky" , flag = 49 , hand = 28422 },
	{ nome = "champanhe" , dict = "anim@mp_player_intupperspray_champagne" , anim = "idle_a" , prop = "ba_prop_battle_champ_open" , flag = 49 , hand = 28422 },
	{ nome = "digitar" , dict = "anim@heists@prison_heistig1_p1_guard_checks_bus" , anim = "loop" , andar = false , loop = true },
	{ nome = "digitar2" , dict = "mp_fbi_heist" , anim = "loop" , andar = false , loop = true },
	{ nome = "continencia" , dict = "mp_player_int_uppersalute" , anim = "mp_player_int_salute" , andar = true , loop = true },
	{ nome = "atm" , dict = "amb@prop_human_atm@male@idle_a" , anim = "idle_a" , andar = false , loop = false },
	{ nome = "no" , dict = "mp_player_int_upper_nod" , anim = "mp_player_int_nod_no" , andar = true , loop = true },
	{ nome = "palmas" , dict = "anim@mp_player_intcelebrationfemale@slow_clap" , anim = "slow_clap" , andar = true , loop = false },
	{ nome = "palmas2" , dict = "amb@world_human_cheering@male_b" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas3" , dict = "amb@world_human_cheering@male_d" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas4" , dict = "amb@world_human_cheering@male_e" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas5" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "angry_clap_a_player_a" , andar = true , loop = false },
	{ nome = "palmas6" , dict = "anim@mp_player_intupperslow_clap" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "postura" , dict = "anim@heists@prison_heiststation@cop_reactions" , anim = "cop_a_idle" , andar = true , loop = true },
	{ nome = "postura2" , dict = "amb@world_human_cop_idles@female@base" , anim = "base" , andar = true , loop = true },
	{ nome = "postura3" , dict = "missbigscore2aleadinout@bs_2a_mcs_3" , anim = "bankman_leadout_action" , andar = true , loop = true },
	{ nome = "varrer" , dict = "amb@world_human_janitor@male@idle_a" , anim = "idle_a" , prop = "prop_tool_broom" , flag = 49 , hand = 28422, ProibidoArmado = true },
	{ nome = "musica" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_01" , flag = 49 , hand = 60309 },
	{ nome = "musica2" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_02" , flag = 49 , hand = 60309 },
	{ nome = "musica3" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_03" , flag = 49 , hand = 60309 },
	{ nome = "musica4" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_acc_guitar_01" , flag = 49 , hand = 60309 },
	{ nome = "camera" , dict = "amb@world_human_paparazzi@male@base" , anim = "base" , prop = "prop_pap_camera_01" , flag = 49 , hand = 28422 },
	{ nome = "prancheta" , dict = "amb@world_human_clipboard@male@base" , anim = "base" , prop = "p_amb_clipboard_01" , flag = 50 , hand = 60309 },
	{ nome = "mapa" , dict = "amb@world_human_clipboard@male@base" , anim = "base" , prop = "prop_tourist_map_01" , flag = 50 , hand = 60309 },
	{ nome = "anotar" , dict = "amb@medic@standing@timeofdeath@base" , anim = "base" , prop = "prop_notepad_01" , flag = 49 , hand = 60309 },
	{ nome = "peace" , dict = "mp_player_int_upperpeace_sign" , anim = "mp_player_int_peace_sign" , andar = true , loop = true },
	{ nome = "peace2" , dict = "anim@mp_player_intupperpeace" , anim = "idle_a" , andar = true , loop = true },
	--{ nome = "deitar" , dict = "anim@gangops@morgue@table@" , anim = "ko_front" , andar = false , loop = true },
	{ nome = "deitar2" , dict = "amb@world_human_sunbathe@female@back@idle_a" , anim = "idle_a" , andar = false , loop = true, ProibidoArmado = true },
	{ nome = "deitar3" , dict = "amb@world_human_sunbathe@female@front@idle_a" , anim = "idle_a" , andar = false , loop = true, ProibidoArmado = true },
	{ nome = "deitar4" , dict = "amb@world_human_sunbathe@male@back@idle_a" , anim = "idle_a" , andar = false , loop = true, ProibidoArmado = true },
	--{ nome = "deitar5" , dict = "amb@world_human_sunbathe@male@front@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar6" , dict = "mini@cpr@char_b@cpr_str" , anim = "cpr_kol_idle" , andar = false , loop = true, ProibidoArmado = true },
	{ nome = "deitar7" , dict = "switch@trevor@scares_tramp" , anim = "trev_scares_tramp_idle_tramp" , andar = false , loop = true, ProibidoArmado = true },
	{ nome = "deitar8" , dict = "switch@trevor@annoys_sunbathers" , anim = "trev_annoys_sunbathers_loop_girl" , andar = false , loop = true, ProibidoArmado = true },		
	{ nome = "deitar9" , dict = "switch@trevor@annoys_sunbathers" , anim = "trev_annoys_sunbathers_loop_guy" , andar = false , loop = true, ProibidoArmado = true },
	{ nome = "debrucar" , dict = "amb@prop_human_bum_shopping_cart@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "debrucar2" , dict = "anim@amb@casino@valet_scenario@pose_b@" , anim = "base_a_m_y_vinewood_01" , andar = false , loop = true },
	{ nome = "debrucar3" , dict = "anim@amb@casino@valet_scenario@pose_a@" , anim = "base_a_m_y_vinewood_01" , andar = false , loop = true },
	{ nome = "debrucar4" , dict = "anim@amb@casino@out_of_money@ped_female@02a@base" , anim = "base" , andar = false , loop = true },
	{ nome = "debrucar5" , dict = "anim@mini@yacht@bar@drink@four" , anim = "four_bartender" , andar = false , loop = true },
	{ nome = "ballo" , dict = "rcmnigel1bnmt_1b" , anim = "dance_loop_tyler" , andar = false , loop = true },
	{ nome = "ballo2" , dict = "mp_safehouse" , anim = "lap_dance_girl" , andar = false , loop = true },
	{ nome = "ballo3" , dict = "misschinese2_crystalmazemcs1_cs" , anim = "dance_loop_tao" , andar = false , loop = true },
	{ nome = "ballo4" , dict = "mini@strip_club@private_dance@part1" , anim = "priv_dance_p1" , andar = false , loop = true },
	{ nome = "ballo5" , dict = "mini@strip_club@private_dance@part2" , anim = "priv_dance_p2" , andar = false , loop = true },
	{ nome = "ballo6" , dict = "mini@strip_club@private_dance@part3" , anim = "priv_dance_p3" , andar = false , loop = true },
	{ nome = "ballo7" , dict = "special_ped@mountain_dancer@monologue_2@monologue_2a" , anim = "mnt_dnc_angel" , andar = false , loop = true },
	{ nome = "ballo8" , dict = "special_ped@mountain_dancer@monologue_3@monologue_3a" , anim = "mnt_dnc_buttwag" , andar = false , loop = true },
	{ nome = "ballo9" , dict = "missfbi3_sniping" , anim = "dance_m_default" , andar = false , loop = true },
	{ nome = "ballo10" , dict = "anim@amb@nightclub@dancers@black_madonna_entourage@" , anim = "hi_dance_facedj_09_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo11" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo12" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo13" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo14" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo15" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo16" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo17" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo18" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo19" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo20" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo21" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo22" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo23" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo24" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo25" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo26" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo27" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo28" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo29" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo30" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo31" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo32" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo33" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo34" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo35" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo36" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo37" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo38" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo39" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo40" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo41" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo42" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo43" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo44" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo45" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo46" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo47" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo48" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo49" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo50" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo51" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo52" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo53" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo54" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo55" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo56" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo57" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo58" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo59" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo60" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo61" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo62" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo63" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo64" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo65" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo66" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo67" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo68" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo69" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo70" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo71" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo72" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo73" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo74" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo75" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo76" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo77" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo78" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo79" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo80" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo81" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo82" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo83" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo84" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo85" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo86" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo87" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo88" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo89" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo90" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo91" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo92" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo93" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo94" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo95" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo96" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo97" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo98" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo99" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo100" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo101" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo102" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo103" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo104" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo105" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo106" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo107" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo108" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo109" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo110" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo111" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo112" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo113" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo114" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo115" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo116" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo117" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo118" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo119" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo120" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo121" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo122" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo123" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo124" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo125" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo126" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo127" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo128" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo129" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo130" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo131" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo132" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo133" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo134" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo135" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo136" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo137" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo138" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo139" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo140" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo141" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo142" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo143" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo144" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo145" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo146" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo147" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo148" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo149" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo150" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo151" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo152" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo153" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo154" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo155" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo156" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo157" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo158" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo159" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo160" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo161" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo162" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo163" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo164" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo165" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo166" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo167" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo168" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo169" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo170" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo171" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo172" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo173" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo174" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo175" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo176" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo177" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo178" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo179" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo180" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo181" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo182" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo183" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo184" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo185" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo186" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo187" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo188" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo189" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo190" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo191" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo192" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo193" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo194" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo195" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo196" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo197" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo198" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo199" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo200" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo201" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo202" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo203" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo204" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^2" , andar = false , loop = true },
	{ nome = "ballo205" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^3" , andar = false , loop = true },
	{ nome = "ballo206" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^4" , andar = false , loop = true },
	{ nome = "ballo207" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^5" , andar = false , loop = true },
	{ nome = "ballo208" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^6" , andar = false , loop = true },
	{ nome = "ballo209" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^1" , andar = false , loop = true },
	{ nome = "ballo210" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^2" , andar = false , loop = true },
	{ nome = "ballo211" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^3" , andar = false , loop = true },
	{ nome = "ballo212" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^4" , andar = false , loop = true },
	{ nome = "ballo213" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^5" , andar = false , loop = true },
	{ nome = "ballo214" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^6" , andar = false , loop = true },
	{ nome = "ballo215" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^1" , andar = false , loop = true },
	{ nome = "ballo216" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^2" , andar = false , loop = true },
	{ nome = "ballo217" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^3" , andar = false , loop = true },
	{ nome = "ballo218" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^4" , andar = false , loop = true },
	{ nome = "ballo219" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^5" , andar = false , loop = true },
	{ nome = "ballo220" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^6" , andar = false , loop = true },
	{ nome = "ballo221" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^1" , andar = false , loop = true },
	{ nome = "ballo222" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^2" , andar = false , loop = true },
	{ nome = "ballo223" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^3" , andar = false , loop = true },
	{ nome = "ballo224" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^4" , andar = false , loop = true },
	{ nome = "ballo225" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo226" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^6" , andar = false , loop = true },
	{ nome = "ballo227" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_center_up" , andar = false , loop = true },	
	{ nome = "ballo228" , dict = "timetable@tracy@ig_8@idle_b" , anim = "idle_d" , andar = false , loop = true },
	{ nome = "ballo229" , dict = "timetable@tracy@ig_5@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "ballo230" , dict = "anim@amb@nightclub@lazlow@hi_podium@" , anim = "danceidle_hi_11_buttwiggle_b_laz" , andar = false , loop = true },
	{ nome = "ballo231" , dict = "move_clown@p_m_two_idles@" , anim = "fidget_short_dance" , andar = false , loop = true },
	{ nome = "ballo232" , dict = "move_clown@p_m_zero_idles@" , anim = "fidget_short_dance" , andar = false , loop = true },
	{ nome = "ballo233" , dict = "misschinese2_crystalmazemcs1_ig" , anim = "dance_loop_tao" , andar = false , loop = true },
	{ nome = "ballo234" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "ballo235" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_center_down" , andar = false , loop = true },
	{ nome = "ballo236" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "ballo237" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "ballo238" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_center" , andar = true , loop = true },
	{ nome = "ballo239" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "ballo240" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_center" , andar = false , loop = true },
	{ nome = "ballo241" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_center_down" , andar = false , loop = true },
	{ nome = "ballo242" , dict = "anim@amb@nightclub@dancers@podium_dancers@" , anim = "hi_dance_facedj_17_v2_male^5" , andar = false , loop = true },
	{ nome = "ballo243" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "ballo244" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_center_down" , andar = false , loop = true },
	{ nome = "ballo245" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "ballo246" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "ballo247" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_center" , andar = false , loop = true },
	{ nome = "ballo248" , dict = "anim@amb@nightclub@dancers@solomun_entourage@" , anim = "mi_dance_facedj_17_v1_female^1" , andar = false , loop = true },
	{ nome = "ballo249" , dict = "anim@mp_player_intcelebrationfemale@the_woogie" , anim = "the_woogie" , andar = false , loop = true },	
	{ nome = "ballo250" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_center_up" , andar = false , loop = true },	
	{ nome = "ballo251" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_center" , andar = false , loop = true },	
	{ nome = "ballo252" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_center" , andar = false , loop = true },
	{ nome = "ballo253" , dict = "mini@strip_club@private_dance@idle" , anim = "priv_dance_idle" , andar = false , loop = true },
	{ nome = "ballo254" , dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p2" , anim = "ld_girl_a_song_a_p2_f" , andar = false , loop = true },
	{ nome = "ballo255" , dict = "mini@strip_club@lap_dance_2g@ld_2g_p1" , anim = "ld_2g_p1_s2" , andar = false , loop = true },
	{ nome = "ballo256" , dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1" , anim = "ld_girl_a_song_a_p1_f" , andar = false , loop = true },
	{ nome = "ballo260" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_center_down" , andar = false , loop = true },
	{ nome = "ballo261" , dict = "anim@arena@celeb@podium@no_prop@" , anim = "dance_a_1st" , andar = false , loop = false },
	{ nome = "ballo262" , dict = "anim@amb@nightclub@lazlow@hi_podium@" , anim = "danceidle_mi_13_enticing_laz" , andar = false , loop = true },
	{ nome = "ballo263" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_right" , andar = false , loop = true },
	{ nome = "poledance" , dict = "mini@strip_club@pole_dance@pole_dance1" , anim = "pd_dance_01" , andar = false , loop = true },
	{ nome = "poledance1" , dict = "mini@strip_club@pole_dance@pole_dance2" , anim = "pd_dance_02" , andar = false , loop = true },
	{ nome = "poledance2" , dict = "mini@strip_club@pole_dance@pole_dance3" , anim = "pd_dance_03" , andar = false , loop = true },
	{ nome = "sexo" , dict = "rcmpaparazzo_2" , anim = "shag_loop_poppy" , andar = false , loop = true },
	{ nome = "sexo2" , dict = "rcmpaparazzo_2" , anim = "shag_loop_a" , andar = false , loop = true },
	{ nome = "sexo3" , dict = "anim@mp_player_intcelebrationfemale@air_shagging" , anim = "air_shagging" , andar = false , loop = true },
	{ nome = "sexo4" , dict = "oddjobs@towing" , anim = "m_blow_job_loop" , andar = false , loop = true , carros = true },
	{ nome = "sexo5" , dict = "oddjobs@towing" , anim = "f_blow_job_loop" , andar = false , loop = true , carros = true },
	{ nome = "sexo6" , dict = "mini@prostitutes@sexlow_veh" , anim = "low_car_sex_loop_female" , andar = false , loop = true , carros = true },
	{ nome = "sexo7" , dict = "timetable@trevor@skull_loving_bear" , anim = "skull_loving_bear" , andar = false , loop = true },
	
	{ nome = "assaltar" , dict = "random@countryside_gang_fight" , anim = "biker_02_stickup_loop" , andar = false , loop = true },
	{ nome = "rendido" , dict = "missminuteman_1ig_2" , anim = "handsup_base" , andar = false , loop = true },
	{ nome = "mano" , dict = "mp_ped_interaction" , anim = "hugs_guy_b" , andar = false , loop = true },
	{ nome = "baixo" , dict = "gestures@f@standing@casual" , anim = "gesture_hand_down" , andar = true , loop = false },
	{ nome = "espreguicar" , dict = "amb@world_human_jog_standing@female@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "toctoc" , dict = "missheistfbi3b_ig7" , anim = "lift_fibagent_loop" , andar = false , loop = true },
	{ nome = "debochar", anim = "WORLD_HUMAN_HANG_OUT_STREET", ProibidoArmado = true  },
	{ nome = "seguranca", anim = "WORLD_HUMAN_GUARD_STAND", ProibidoArmado = true  },
	{ nome = "tossir" , dict = "timetable@gardener@smoking_joint" , anim = "idle_cough" , andar = true , loop = false },

	{ nome = "sentar2" , dict = "amb@world_human_picnic@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar3" , dict = "anim@heists@fleeca_bank@ig_7_jetski_owner" , anim = "owner_idle" , andar = false , loop = true },
	{ nome = "sentar4" , dict = "amb@world_human_stupor@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar5" , dict = "amb@world_human_picnic@female@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar6" , dict = "anim@amb@nightclub@lazlow@lo_alone@" , anim = "lowalone_base_laz" , andar = false , loop = true },
	{ nome = "sentar7" , dict = "anim@amb@business@bgen@bgen_no_work@" , anim = "sit_phone_phoneputdown_idle_nowork" , andar = false , loop = true },
	{ nome = "sentar8" , dict = "rcm_barry3" , anim = "barry_3_sit_loop" , andar = false , loop = true },
	{ nome = "sentar9" , dict = "amb@world_human_picnic@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sentar10" , dict = "amb@world_human_picnic@female@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sentar11" , dict = "timetable@jimmy@mics3_ig_15@" , anim = "idle_a_jimmy" , andar = false , loop = true },
	{ nome = "sentar12" , dict = "timetable@jimmy@mics3_ig_15@" , anim = "mics3_15_base_jimmy" , andar = false , loop = true },
	{ nome = "sentar13" , dict = "amb@world_human_stupor@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sentar14" , dict = "timetable@tracy@ig_14@" , anim = "ig_14_base_tracy" , andar = false , loop = true },
	{ nome = "sentar15" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_loop_ped_b" , andar = false , loop = true },
	{ nome = "sentar16" , dict = "timetable@ron@ig_5_p3" , anim = "ig_5_p3_base" , andar = false , loop = true },
	{ nome = "sentar17" , dict = "timetable@reunited@ig_10" , anim = "base_amanda" , andar = false , loop = true },
	{ nome = "sentar18" , dict = "timetable@ron@ig_3_couch" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar19" , dict = "timetable@jimmy@mics3_ig_15@" , anim = "mics3_15_base_tracy" , andar = false , loop = true },
	{ nome = "sentar20" , dict = "timetable@maid@couch@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar21" , dict = "timetable@ron@ron_ig_2_alt1" , anim = "ig_2_alt1_base" , andar = false , loop = true },
	{ nome = "sentar22" , dict = "mp_am_stripper" , anim = "lap_dance_player" , andar = false , loop = true },
	{ nome = "w" , dict = "anim@mp_player_intcelebrationmale@bang_bang" , anim = "bang_bang" , andar = true , loop = false },
	{ nome = "w2" , dict = "anim@mp_player_intcelebrationmale@air_drums" , anim = "air_drums" , andar = true , loop = false },
	{ nome = "w3" , dict = "anim@mp_player_intcelebrationmale@call_me" , anim = "call_me" , andar = true , loop = false },
	{ nome = "w4" , dict = "anim@mp_player_intcelebrationmale@coin_roll_and_toss" , anim = "coin_roll_and_toss" , andar = true , loop = false },
	{ nome = "w5" , dict = "anim@mp_player_intcelebrationmale@mind_blown" , anim = "mind_blown" , andar = true , loop = false },
	{ nome = "w6" , dict = "anim@mp_player_intcelebrationmale@respect" , anim = "respect" , andar = true , loop = false },
	{ nome = "w7" , dict = "anim@amb@casino@hangout@ped_male@stand@01a@base" , anim = "base" , andar = true , loop = true },
	{ nome = "w8" , dict = "anim@amb@casino@hangout@ped_male@stand@01b@enter" , anim = "enter" , andar = true , loop = false },
	{ nome = "w9" , dict = "anim@amb@casino@hangout@ped_male@stand@01b@exit" , anim = "exit" , andar = true , loop = false },
	--{ nome = "beijar" , dict = "mp_ped_interaction" , anim = "kisses_guy_a" , andar = false , loop = false },
	{ nome = "striper" , dict = "mini@strip_club@idles@stripper" , anim = "stripper_idle_02" , andar = false , loop = true },
	{ nome = "escutar" , dict = "mini@safe_cracking" , anim = "idle_base" , andar = false , loop = true },
	{ nome = "alongar" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_e" , andar = false , loop = true },
	{ nome = "alongar2" , dict = "mini@triathlon" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "alongar3" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_c" , andar = false , loop = false },
	{ nome = "alongar4" , dict = "mini@triathlon" , anim = "idle_f" , andar = false , loop = true },
	{ nome = "alongar5" , dict = "mini@triathlon" , anim = "idle_d" , andar = false , loop = true },
	{ nome = "alongar6" , dict = "rcmfanatic1maryann_stretchidle_b" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "alongar7" , dict = "timetable@reunited@ig_2" , anim = "jimmy_getknocked" , andar = false , loop = true },
	{ nome = "dj" , dict = "anim@mp_player_intupperdj" , anim = "idle_a", andar = true , loop = true },
	{ nome = "dj2" , dict = "anim@mp_player_intupperair_synth" , anim = "idle_a_fp" , andar = false , loop = true },
	{ nome = "dj3" , dict = "anim@mp_player_intcelebrationfemale@air_synth" , anim = "air_synth" , andar = false , loop = false },
	{ nome = "rock" , dict = "anim@mp_player_intcelebrationmale@air_guitar" , anim = "air_guitar" , andar = false , loop = false },
	{ nome = "rock2" , dict = "mp_player_introck" , anim = "mp_player_int_rock" , andar = false , loop = false },
	--{ nome = "abracar" , dict = "mp_ped_interaction" , anim = "hugs_guy_a" , andar = false , loop = false },
	--{ nome = "abracar2" , dict = "mp_ped_interaction" , anim = "kisses_guy_b" , andar = false , loop = false },
	{ nome = "peitos" , dict = "mini@strip_club@backroom@" , anim = "stripper_b_backroom_idle_b" , andar = false , loop = false },
	{ nome = "espernear" , dict = "missfam4leadinoutmcs2" , anim = "tracy_loop" , andar = false , loop = true },
	{ nome = "arrumar" , dict = "anim@amb@business@coc@coc_packing_hi@" , anim = "full_cycle_v1_pressoperator" , andar = false , loop = true },
	{ nome = "bebado" , dict = "missfam5_blackout" , anim = "pass_out" , andar = false , loop = false },
	{ nome = "bebado2" , dict = "missheist_agency3astumble_getup" , anim = "stumble_getup" , andar = false , loop = false },
	{ nome = "bebado3" , dict = "missfam5_blackout" , anim = "vomit" , andar = false , loop = false },
	{ nome = "bebado4" , dict = "random@drunk_driver_1" , anim = "drunk_fall_over" , andar = false , loop = false },
	{ nome = "bebado5" , dict = "misscarsteal4@actor" , anim = "stumble" , andar = false , loop = false },
	{ nome = "bebado6" , dict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@drunk" , anim = "outro_fallover" , andar = false , loop = false },
	{ nome = "bebado7" , dict = "switch@trevor@puking_into_fountain" , anim = "trev_fountain_puke_loop" , andar = false , loop = true },
	{ nome = "bebado8" , dict = "switch@trevor@head_in_sink" , anim = "trev_sink_idle" , andar = false , loop = true },
	{ nome = "yoga" , dict = "missfam5_yoga" , anim = "f_yogapose_a" , andar = false , loop = true },
	{ nome = "yoga2" , dict = "amb@world_human_yoga@male@base" , anim = "base_a" , andar = false , loop = true },
	{ nome = "abdominal" , dict = "amb@world_human_sit_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "bixa" , anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" },
	{ nome = "britadeira" , dict = "amb@world_human_const_drill@male@drill@base" , anim = "base" , prop = "prop_tool_jackham" , flag = 15 , hand = 28422 },
	{ nome = "cerveja" , anim = "WORLD_HUMAN_PARTYING" },
	{ nome = "churrasco" , anim = "PROP_HUMAN_BBQ" },
	{ nome = "consertar" , anim = "WORLD_HUMAN_WELDING" },
	{ nome = "dormir" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_a" , andar = false , loop = true },
	{ nome = "dormir2" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_e" , andar = false , loop = true, ProibidoArmado = true },
	{ nome = "dormir3" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_h" , andar = false , loop = true },
	{ nome = "dormir4" , dict = "mp_sleep" , anim = "sleep_loop" , andar = true , loop = true, ProibidoArmado = true },
	{ nome = "dormir5" , dict = "missarmenian2" , anim = "drunk_loop" , andar = false , loop = true, ProibidoArmado = true },
	{ nome = "encostar" , dict = "amb@lo_res_idles@" , anim = "world_human_lean_male_foot_up_lo_res_base" , andar = false , loop = true },
	{ nome = "encostar2" , dict = "bs_2a_mcs_10-0" , anim = "hc_gunman_dual-0" , andar = false , loop = true },
	{ nome = "encostar3" , dict = "misscarstealfinalecar_5_ig_1" , anim = "waitloop_lamar" , andar = false , loop = true },
	{ nome = "encostar4" , dict = "anim@amb@casino@out_of_money@ped_female@02b@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar5" , dict = "anim@amb@casino@hangout@ped_male@stand@03b@base" , anim = "base" , andar = true , loop = true },
	{ nome = "encostar6" , dict = "anim@amb@casino@hangout@ped_female@stand@02b@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar7" , dict = "anim@amb@casino@hangout@ped_female@stand@02a@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar8" , dict = "anim@amb@casino@hangout@ped_female@stand@01b@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar9" , dict = "anim@amb@clubhouse@bar@bartender@" , anim = "base_bartender" , andar = false , loop = true },
	{ nome = "encostar10" , dict = "missclothing" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "encostar11" , dict = "misscarstealfinale" , anim = "packer_idle_1_trevor" , andar = false , loop = true },
	{ nome = "encostar12" , dict = "missarmenian1leadinoutarm_1_ig_14_leadinout" , anim = "leadin_loop" , andar = false , loop = true },
	{ nome = "estatua" , dict = "amb@world_human_statue@base" , anim = "base" , andar = false , loop = true },
	{ nome = "estatua2" , dict = "club_intro2-0" , anim = "csb_englishdave_dual-0" , andar = false , loop = true },
	{ nome = "flexao" , dict = "amb@world_human_push_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "flexao2" , anim = "WORLD_HUMAN_MUSCLE_FLEX" },
	{ nome = "fumar" , anim = "WORLD_HUMAN_SMOKING" },
	{ nome = "fumar2" , anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" },
	{ nome = "fumar3" , anim = "WORLD_HUMAN_AA_SMOKE" },
	{ nome = "fumar4" , anim = "WORLD_HUMAN_SMOKING_POT" },
	{ nome = "fumar5" , dict = "amb@world_human_aa_smoke@male@idle_a" , anim = "idle_c" , prop = "prop_cs_ciggy_01" , flag = 49 , hand = 28422 },
	{ nome = "fumar6" , dict = "amb@world_human_smoking@female@idle_a" , anim = "idle_b" , prop = "prop_cs_ciggy_01" , flag = 49 , hand = 28422 },
	{ nome = "malhar" , dict = "amb@world_human_muscle_free_weights@male@barbell@base" , anim = "base" , prop = "prop_curl_bar_01" , flag = 49 , hand = 28422 },
	{ nome = "malhar2" , dict = "amb@prop_human_muscle_chin_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "martelo" , dict = "amb@world_human_hammering@male@base" , anim = "base" , prop = "prop_tool_hammer" , flag = 49 , hand = 28422 },
	{ nome = "pescar" , dict = "amb@world_human_stand_fishing@base" , anim = "base" , prop = "prop_fishing_rod_01" , flag = 49 , hand = 60309 },
	{ nome = "pescar2" , dict = "amb@world_human_stand_fishing@idle_a" , anim = "idle_c" , prop = "prop_fishing_rod_01" , flag = 49 , hand = 60309 },
	{ nome = "plantar" , dict = "amb@world_human_gardener_plant@female@base" , anim = "base_female" , andar = false , loop = true },
	{ nome = "plantar2" , dict = "amb@world_human_gardener_plant@female@idle_a" , anim = "idle_a_female" , andar = false , loop = true },
	{ nome = "procurar" , dict = "amb@world_human_bum_wash@male@high@base" , anim = "base" , andar = false , loop = true },
	{ nome = "soprador" , dict = "amb@code_human_wander_gardener_leaf_blower@base" , anim = "static" , prop = "prop_leaf_blower_01" , flag = 49 , hand = 28422 },
	{ nome = "soprador2" , dict = "amb@code_human_wander_gardener_leaf_blower@idle_a" , anim = "idle_a" , prop = "prop_leaf_blower_01" , flag = 49 , hand = 28422 },
	{ nome = "soprador3" , dict = "amb@code_human_wander_gardener_leaf_blower@idle_a" , anim = "idle_b" , prop = "prop_leaf_blower_01" , flag = 49 , hand = 28422 },
	{ nome = "tragar" , anim = "WORLD_HUMAN_DRUG_DEALER" },
	{ nome = "trotar" , dict = "amb@world_human_jog_standing@male@fitidle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "esquentar" , anim = "WORLD_HUMAN_STAND_FIRE" },
	{ nome = "selfie" , dict = "cellphone@self" , anim = "selfie_in_from_text" , prop = "prop_amb_phone" , flag = 50 , hand = 28422 },
	{ nome = "selfie2" , dict = "cellphone@" , anim = "cellphone_text_read_base_cover_low" , prop = "prop_amb_phone" , flag = 50 , hand = 28422 },
	{ nome = "mecanico" , dict = "amb@world_human_vehicle_mechanic@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "mecanico2" , dict = "mini@repair" , anim = "fixing_a_player" , andar = false , loop = true },
	{ nome = "mecanico3" , dict = "mini@repair" , anim = "fixing_a_ped" , andar = false , loop = true },
	{ nome = "mecanico4" , dict = "anim@amb@garage@chassis_repair@" , anim = "look_tool_01_amy_skater_01" , andar = false , loop = true },
	{ nome = "puto" , dict = "misscarsteal4@actor" , anim = "actor_berating_loop" , andar = true , loop = false },
	{ nome = "puto2" , dict = "oddjobs@assassinate@vice@hooker" , anim = "argue_a" , andar = true , loop = false },
	{ nome = "puto3" , dict = "mini@triathlon" , anim = "want_some_of_this" , andar = true , loop = false },
	{ nome = "bale" , dict = "anim@mp_player_intcelebrationpaired@f_f_sarcastic" , anim = "sarcastic_left" , andar = false , loop = true },
	{ nome = "bonzao" , dict = "misscommon@response" , anim = "bring_it_on" , andar = true , loop = false },
	{ nome = "wtf" , dict = "anim@mp_player_intcelebrationfemale@face_palm" , anim = "face_palm" , andar = true , loop = false },
	{ nome = "wtf2" , dict = "random@car_thief@agitated@idle_a" , anim = "agitated_idle_a" , andar = true , loop = false },
	{ nome = "wtf3" , dict = "missminuteman_1ig_2" , anim = "tasered_2" , andar = true , loop = false },
	{ nome = "wtf4" , dict = "anim@mp_player_intupperface_palm" , anim = "idle_a" , andar = true , loop = false },
	--{ nome = "meditar" , dict = "rcmcollect_paperleadinout@" , anim = "meditiate_idle" , andar = false , loop = true },
	{ nome = "meditar2" , dict = "timetable@amanda@ig_4" , anim = "ig_4_base" , andar = false , loop = true },
	{ nome = "meditar3" , dict = "mp_fm_intro_cut" , anim = "base_loop" , andar = false , loop = true },
	{ nome = "joia" , dict = "anim@mp_player_intincarthumbs_uplow@ds@" , anim = "enter" , andar = false , loop = false, ProibidoArmado = true  },
	{ nome = "joia2" , dict = "anim@mp_player_intselfiethumbs_up" , anim = "idle_a" , andar = false , loop = false, ProibidoArmado = true  },
	{ nome = "yeah" , dict = "anim@mp_player_intupperair_shagging" , anim = "idle_a" , andar = false , loop = false, ProibidoArmado = true },
	{ nome = "carona" , dict = "random@hitch_lift" , anim = "idle_f" , andar = true , loop = false },
	--{ nome = "rastejar" , dict = "move_crawl" , anim = "onfront_fwd" , andar = false , loop = true },
	--{ nome = "rastejar2" , dict = "move_injured_ground" , anim = "front_loop" , andar = false , loop = true },
	--{ nome = "rastejar3" , dict = "missfbi3_sniping" , anim = "prone_dave" , andar = false , loop = true },
	{ nome = "pirueta" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "cap_a_player_a" , andar = false , loop = false },
	{ nome = "pirueta2" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "flip_a_player_a" , andar = false , loop = false },
	{ nome = "onda" , dict = "anim@mp_player_intupperfind_the_fish" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "heroi" , dict = "rcmbarry" , anim = "base" , andar = true , loop = true },
	{ nome = "boboalegre" , dict = "rcm_barry2" , anim = "clown_idle_0" , andar = false , loop = false },
	{ nome = "boboalegre2" , dict = "rcm_barry2" , anim = "clown_idle_1" , andar = false , loop = false },
	{ nome = "boboalegre3" , dict = "rcm_barry2" , anim = "clown_idle_2" , andar = false , loop = false },
	{ nome = "boboalegre4" , dict = "rcm_barry2" , anim = "clown_idle_3" , andar = false , loop = false },
	{ nome = "boboalegre5" , dict = "rcm_barry2" , anim = "clown_idle_6" , andar = false , loop = false },
	{ nome = "passaro" , dict = "random@peyote@bird" , anim = "wakeup" , andar = false , loop = false },
	{ nome = "cachorro" , dict = "random@peyote@dog" , anim = "wakeup" , andar = false , loop = false },
	{ nome = "tiltado" , dict = "anim@mp_player_intcelebrationfemale@freakout" , anim = "freakout" , andar = false , loop = false },
	{ nome = "dedo" , dict = "anim@mp_player_intcelebrationfemale@finger" , anim = "finger" , andar = true , loop = false, ProibidoArmado = true },
	{ nome = "dedo2" , dict = "anim@arena@celeb@podium@no_prop@" , anim = "flip_off_a_1st" , andar = false , loop = false, ProibidoArmado = true },
	{ nome = "dedo3" , dict = "anim@arena@celeb@podium@no_prop@" , anim = "flip_off_c_1st" , andar = true , loop = false, ProibidoArmado = true },
	{ nome = "mamamia" , dict = "anim@mp_player_intcelebrationmale@finger_kiss" , anim = "finger_kiss" , andar = true , loop = false },
	{ nome = "louco" , dict = "anim@mp_player_intincaryou_locobodhi@ds@" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "xiu" , dict = "anim@mp_player_intincarshushbodhi@ds@" , anim = "idle_a_fp" , andar = true , loop = true },
	{ nome = "ok" , dict = "anim@mp_player_intselfiedock" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "escorregar" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "slide_a_player_a" , andar = false , loop = false },
	{ nome = "escorregar2" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "slide_c_player_a" , andar = false , loop = false },
	{ nome = "gang" , dict = "mp_player_int_uppergang_sign_a" , anim = "mp_player_int_gang_sign_a" , andar = true , loop = true },
	{ nome = "gang2" , dict = "mp_player_int_uppergang_sign_b" , anim = "mp_player_int_gang_sign_b" , andar = true , loop = true },
	{ nome = "cruzar" , dict = "amb@world_human_cop_idles@female@idle_b" , anim = "idle_e" , andar = true , loop = true },
	{ nome = "cruzar2" , dict = "anim@amb@casino@hangout@ped_male@stand@02b@idles" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "cruzar3" , dict = "amb@world_human_hang_out_street@male_c@idle_a" , anim = "idle_b" , andar = true , loop = true },
	{ nome = "cruzar4" , dict = "random@street_race" , anim = "_car_b_lookout" , andar = true , loop = true },
	{ nome = "cruzar5" , dict = "random@shop_gunstore" , anim = "_idle" , andar = true , loop = true },
	{ nome = "cruzar6" , dict = "move_m@hiking" , anim = "idle" , andar = true , loop = true },
	{ nome = "cruzar7" , dict = "anim@amb@casino@valet_scenario@pose_d@" , anim = "base_a_m_y_vinewood_01" , andar = true , loop = true },
	{ nome = "cruzar8" , dict = "anim@amb@casino@shop@ped_female@01a@base" , anim = "base" , andar = true , loop = true },
	{ nome = "cruzar9" , dict = "anim@amb@casino@valet_scenario@pose_c@" , anim = "shuffle_feet_a_m_y_vinewood_01" , andar = true , loop = true },
	{ nome = "cruzar10" , dict = "anim@amb@casino@hangout@ped_male@stand@03a@idles_convo" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "fera" , dict = "anim@mp_fm_event@intro" , anim = "beast_transform" , andar = true , loop = false },
	{ nome = "karate" , dict = "anim@mp_player_intcelebrationfemale@karate_chops" , anim = "karate_chops" , andar = false , loop = false },
	{ nome = "karate2" , dict = "anim@mp_player_intcelebrationmale@karate_chops" , anim = "karate_chops" , andar = false , loop = false },
	{ nome = "boxe" , dict = "anim@mp_player_intcelebrationmale@shadow_boxing" , anim = "shadow_boxing" , andar = false , loop = false },
	{ nome = "boxe2" , dict = "anim@mp_player_intcelebrationfemale@shadow_boxing" , anim = "shadow_boxing" , andar = false , loop = false },
	{ nome = "explodir" , dict = "anim@mp_player_intcelebrationmale@mind_blown" , anim = "mind_blown" , andar = false , loop = false },
	{ nome = "fedo" , dict = "anim@mp_player_intcelebrationfemale@stinker" , anim = "stinker" , andar = false , loop = false },
	{ nome = "pensar" , dict = "anim@amb@casino@out_of_money@ped_male@01b@base" , anim = "base" , andar = true , loop = true },
	{ nome = "pensar2" , dict = "misscarsteal4@aliens" , anim = "rehearsal_base_idle_director" , andar = true , loop = true },
	{ nome = "ferido" , dict = "anim@amb@casino@hangout@ped_female@stand_withdrink@01b@base" , anim = "base" , andar = true , loop = true },
	{ nome = "ferido2" , dict = "combat@damage@injured_pistol@to_writhe" , anim = "variation_d" , andar = false , loop = false },
	{ nome = "olhar" , dict = "oddjobs@basejump@" , anim = "ped_d_loop" , andar = true , loop = true },
	{ nome = "olhar2" , dict = "friends@fra@ig_1" , anim = "base_idle" , andar = true , loop = true },
	{ nome = "suicidio" , dict = "mp_suicide" , anim = "pistol" , andar = false , loop = false },
	{ nome = "suicidio2" , dict = "mp_suicide" , anim = "pill" , andar = false , loop = false },
	{ nome = "senha" , dict = "mp_heists@keypad@" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "lavar" , dict = "missheist_agency3aig_23" , anim = "urinal_sink_loop" , andar = true , loop = true },
	{ nome = "triste" , dict = "misscarsteal2car_stolen" , anim = "chad_car_stolen_reaction" , andar = false , loop = false },
	{ nome = "aqc" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_a" , andar = false , loop = false },
	{ nome = "aqc2" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_d" , andar = false , loop = false },
	{ nome = "inspec" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = true },
	{ nome = "inspec2" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	{ nome = "inspec3" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	{ nome = "inspec4" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	{ nome = "inspec5" , dict = "mp_deathmatch_intros@1hmale" , anim = "intro_male_1h_a_michael" , andar = false , loop = false },
	{ nome = "inspec6" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_a" , andar = false , loop = false },
	{ nome = "inspec7" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_b" , andar = false , loop = false },
	{ nome = "inspec8" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_c" , andar = false , loop = false },
	{ nome = "inspec9" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_d" , andar = false , loop = false },
	{ nome = "inspec10" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_e" , andar = false , loop = false },
	{ nome = "inspec11" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_a" , andar = false , loop = false },
	{ nome = "inspec12" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = false },
	{ nome = "inspec13" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	{ nome = "inspec14" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	{ nome = "inspec15" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	{ nome = "inspec16" , dict = "anim@deathmatch_intros@1hmale" , anim = "intro_male_1h_d_michael" , andar = true , loop = false },
	{ nome = "swat" , dict = "swat" , anim = "come" , andar = true , loop = false },
	{ nome = "swat2" , dict = "swat" , anim = "freeze" , andar = true , loop = false },
	{ nome = "swat3" , dict = "swat" , anim = "go_fwd" , andar = true , loop = false },
	{ nome = "swat4" , dict = "swat" , anim = "rally_point" , andar = true , loop = false },
	{ nome = "swat5" , dict = "swat" , anim = "understood" , andar = true , loop = false },
	{ nome = "swat6" , dict = "swat" , anim = "you_back" , andar = true , loop = false },
	{ nome = "swat7" , dict = "swat" , anim = "you_fwd" , andar = true , loop = false },
	{ nome = "swat8" , dict = "swat" , anim = "you_left" , andar = true , loop = false },
	{ nome = "swat9" , dict = "swat" , anim = "you_right" , andar = true , loop = false },

	{ nome = "binoculos" , dict = "amb@world_human_binoculars@male@enter" , anim = "enter" , prop = "prop_binoc_01" , flag = 50 , hand = 28422 , extra = function()
	 	binoculos = true
	end },
	{ nome = "camera2" , dict = "missfinale_c2mcs_1" , anim = "fin_c2_mcs_1_camman" , prop = "prop_v_cam_01" , flag = 49 , hand = 28422 , extra = function() 
		camera = true
	end },
	{ nome = "camera3" , dict = "missmic4premiere" , anim = "interview_short_camman" , prop = "prop_v_cam_01" , flag = 49 , hand = 28422 , extra = function() 
		camera = true
	end },
	{ nome = "limpar" , dict = "timetable@maid@cleaning_window@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , hand = 28422 , extra = function()
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerEvent('cancelando',true,true)
			TriggerEvent("progress",15000,"limpando")
			SetTimeout(15000,function()
				TriggerEvent("cancelando",false)
				TriggerServerEvent("tryclean",VehToNet(vehicle))
				vRP.DeletarObjeto()
			end)
		end
	end },
	{ nome = "limpar2" , dict = "timetable@maid@cleaning_surface@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , hand = 28422 , extra = function()
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerEvent('cancelando',true,true)
			TriggerEvent("progress",15000,"limpando")
			SetTimeout(15000,function()
				TriggerEvent("cancelando",false)
				TriggerServerEvent("tryclean",VehToNet(vehicle))
				vRP.DeletarObjeto()
			end)
		end
	end },
	{ nome = "limpar3" , dict = "timetable@floyd@clean_kitchen@base" , anim = "base" , prop = "prop_sponge_01" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = 0.0 , pos2 = 0.0 , pos3 = -0.01 , pos4 = 90.0 , pos5 = 0.0 , pos6 = 0.0 , propAnim = true , extra = function()
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerEvent('cancelando',true,true)
			TriggerEvent("progress",15000,"limpando")
			SetTimeout(15000,function()
				TriggerEvent("cancelando",false)
				TriggerServerEvent("tryclean",VehToNet(vehicle))
				vRP.DeletarObjeto()
			end)
		end
	end },
	{ nome = "limpar4" , dict = "amb@world_human_maid_clean@" , anim = "base" , prop = "prop_sponge_01" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = 0.0 , pos2 = 0.0 , pos3 = -0.01 , pos4 = 90.0 , pos5 = 0.0 , pos6 = 0.0 , propAnim = true , extra = function()
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerEvent('cancelando',true,true)
			TriggerEvent("progress",15000,"limpando")
			SetTimeout(15000,function()
				TriggerEvent("cancelando",false)
				TriggerServerEvent("tryclean",VehToNet(vehicle))
				vRP.DeletarObjeto()
			end)
		end
	end },
	{ nome = "livro" , dict = "cellphone@" , anim = "cellphone_text_read_base" , prop = "prop_novel_01" , andar = true , loop = true , flag = 49 , hand = 6286 , pos1 = 0.15 , pos2 = 0.03 , pos3 = -0.065 , pos4 = 0.0 , pos5 = 180.0 , pos6 = 90.0 , propAnim = true },
	{ nome = "urso" , dict = "impexp_int-0" , anim = "mp_m_waremech_01_dual-0" , prop = "v_ilev_mr_rasberryclean" , andar = true , loop = true , flag = 49 , hand = 24817 , pos1 = -0.20 , pos2 = 0.46 , pos3 = -0.016 , pos4 = -180.0 , pos5 = -90.0 , pos6 = 0.0 , propAnim = true },
	{ nome = "dinheiro" , dict = "anim@mp_player_intupperraining_cash" , anim = "idle_a" , prop = "prop_anim_cash_pile_01" , andar = true , loop = true , flag = 49 , hand = 60309 , pos1 = 0.0 , pos2 = 0.0 , pos3 = 0.0 , pos4 = 180.0 , pos5 = 0.0 , pos6 = 70.0 , propAnim = true },
	{ nome = "capo" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "imp_prop_impexp_bonnet_03a" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = 0.2 , pos2 = 0.2 , pos3 = -0.1 , pos4 = 0.0 , pos5 = 0.0 , pos6 = 180.0 , propAnim = true },
	{ nome = "porta" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "imp_prop_impexp_car_door_04a" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = -0.5 , pos2 = -0.15 , pos3 = -0.1 , pos4 = 0.0 , pos5 = 0.0 , pos6 = 90.0 , propAnim = true },
	{ nome = "parachoque" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "imp_prop_impexp_front_bumper_02a" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = 0.0 , pos2 = 0.1 , pos3 = 0.05 , pos4 = 0.0 , pos5 = 0.0 , pos6 = 0.0 , propAnim = true },
	{ nome = "megaphone" , dict = "anim@random@shop_clothes@watches" , anim = "base" , prop = "prop_megaphone_01" , andar = true , loop = true , flag = 49 , hand = 60309 , pos1 = 0.10 , pos2 = 0.04 , pos3 = 0.012 , pos4 = -60.0 , pos5 = 100.0 , pos6 = -30.0 , propAnim = true },
	{ nome = "casalm2" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_trevor" , andar = false , loop = true },
    { nome = "casalf2" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_patricia" , andar = false , loop = true },
    { nome = "casalm3" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_trevor" , andar = false , loop = true },
    { nome = "casalf3" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_patricia" , andar = false , loop = true },
}

function CheckExistencia(anim)
	for k, v in pairs(animacoes) do
		if v.nome == anim then
			return true
		end
	end
	return false
end

RegisterNetEvent('emotes')
AddEventHandler('emotes',function(nome)
	local ped = PlayerPedId()

	if not CheckExistencia(nome) then
		return
	end

	if GetEntityHealth(ped) > 101 then
		if not vRP.isHandcuffed() then
			vRP.DeletarObjeto("one")
			for _,emote in pairs(animacoes) do
				if not IsPedInAnyVehicle(ped) and not emote.carros then
					if nome == emote.nome then

						if emote.ProibidoArmado then
							if IsPedArmed(ped,7) then
								TriggerEvent('Notify', 'negado','Você não pode fazer essa animação armado.')
								return
							end
						end

						if emote.extra then emote.extra() end
						if emote.propAnim then 
							vRP.CarregarObjeto(emote.dict,emote.anim,emote.prop,emote.flag,emote.hand,emote.pos1,emote.pos2,emote.pos3,emote.pos4,emote.pos5,emote.pos6)
						elseif emote.pos1 then
							vRP.CarregarObjeto("","",emote.prop,emote.flag,emote.hand,emote.pos1,emote.pos2,emote.pos3,emote.pos4,emote.pos5,emote.pos6)
						elseif emote.prop then
							vRP.CarregarObjeto(emote.dict,emote.anim,emote.prop,emote.flag,emote.hand)
						elseif emote.dict then
							vRP._playAnim(emote.andar,{emote.dict,emote.anim},emote.loop)
						else
							vRP._playAnim(false,{task=emote.anim},false)
						end
					end
				else
					if IsPedInAnyVehicle(ped) and emote.carros then
						local vehicle = GetVehiclePedIsIn(ped,false)
						if nome == emote.nome then
							if (GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,1) == ped) and emote.nome == "sexo4" then
								vRP._playAnim(emote.andar,{emote.dict,emote.anim},emote.loop)
							elseif (GetPedInVehicleSeat(vehicle,0) == ped or GetPedInVehicleSeat(vehicle,2) == ped) and (emote.nome == "sexo5" or emote.nome == "sexo6") then
								vRP._playAnim(emote.andar,{emote.dict,emote.anim},emote.loop)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCED ANIMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('syncAnim')
AddEventHandler('syncAnim',function(pos)
	local ped = PlayerPedId()
 	local pedInFront = GetPlayerPed(GetClosestPlayer())
    local heading = GetEntityHeading(pedInFront)
    local coords = GetOffsetFromEntityInWorldCoords(pedInFront,0.0,pos,0.0)
    SetEntityHeading(ped,heading-180.1)
    SetEntityCoordsNoOffset(ped,coords.x,coords.y,coords.z,0)
end)

RegisterNetEvent('syncAnimAll')
AddEventHandler('syncAnimAll',function(status,person)
	vRP.DeletarObjeto()
	if status == "beijar" then
		vRP._playAnim(false,{"mp_ped_interaction","kisses_guy_a"},false)
	elseif status == "abracar" then
		vRP._playAnim(false,{"mp_ped_interaction","hugs_guy_a"},false)
	elseif status == "abracar2" then
		vRP._playAnim(false,{"mp_ped_interaction","kisses_guy_b"},false)
	elseif status == "abracar3" then
		vRP._playAnim(false,{"mp_ped_interaction","handshake_guy_a"},false)
	elseif status == "abracar4" then
		vRP._playAnim(false,{"mp_ped_interaction","handshake_guy_b"},false)
	elseif status == "ballo257" then
		vRP._playAnim(false,{"anim@amb@nightclub@lazlow@hi_railing@","ambclub_13_mi_hi_sexualgriding_laz"},false)
		vRP.CarregarObjeto("","","ba_prop_battle_glowstick_01",49,28422,0.0700,0.1400,0.0,-80.0,20.0)
		vRP.CarregarObjeto2("","","ba_prop_battle_glowstick_01",49,60309,0.0700,0.0900,0.0,-120.0,-20.0)
	elseif status == "ballo258" then
		vRP._playAnim(false,{"anim@amb@nightclub@lazlow@hi_railing@","ambclub_12_mi_hi_bootyshake_laz"},false)
		vRP.CarregarObjeto("","","ba_prop_battle_glowstick_01",49,28422,0.0700,0.1400,0.0,-80.0,20.0)
		vRP.CarregarObjeto2("","","ba_prop_battle_glowstick_01",49,60309,0.0700,0.0900,0.0,-120.0,-20.0)
	elseif status == "ballo259" then
		vRP._playAnim(false,{"anim@amb@nightclub@lazlow@hi_dancefloor@","crowddance_hi_11_handup_laz"},false)
		vRP.CarregarObjeto("","","ba_prop_battle_hobby_horse",49,28422,0.0,0.0,0.0,0.0,0.0,0.0)
	elseif status == "casal" then
		if person == 1 then
			vRP._playAnim(false,{"misscarsteal2chad_goodbye","chad_armsaround_girl"},true)
		elseif person == 2 then
			vRP._playAnim(false,{"misscarsteal2chad_goodbye","chad_armsaround_chad"},true)
		end
	elseif status == "casal2" then
		if person == 1 then
			vRP._playAnim(false,{"timetable@trevor@ig_1","ig_1_thedontknowwhy_patricia"},true)
		elseif person == 2 then
			vRP._playAnim(false,{"timetable@trevor@ig_1","ig_1_thedontknowwhy_trevor"},true)
		end
	elseif status == "casal3" then
		if person == 1 then
			vRP._playAnim(false,{"timetable@trevor@ig_1","ig_1_thedesertissobeautiful_patricia"},true)
		elseif person == 2 then
			vRP._playAnim(false,{"timetable@trevor@ig_1","ig_1_thedesertissobeautiful_trevor"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCED PARTICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("startSyncParticle")
AddEventHandler("startSyncParticle",function(asset,index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToPed(index)
		if DoesEntityExist(v) then
			if asset == "champagne" then
				vRP.PtfxThis("scr_ba_club")
				StartParticleFxLoopedOnPedBone("scr_ba_club_champagne_spray",v,0.0,0.4,0.2,-50.0,0.0,0.0,GetPedBoneIndex(v,11816),2.0,false,false,false)
			elseif asset == "money" then
				vRP.PtfxThis("scr_xs_celebration")
				StartParticleFxLoopedOnPedBone("scr_xs_money_rain",v,0.0,0.4,0.6,-50.0,0.0,0.0,GetPedBoneIndex(v,11816),1.0,false,false,false)
			elseif asset == "peeing" then
				vRP.PtfxThis("core")
				StartParticleFxLoopedOnPedBone("ent_amb_peeing",v,0.0,0.35,-0.15,-140.0,0.0,0.0,GetPedBoneIndex(v,11816),2.5,false,false,false)
			elseif asset == "poo" then
				vRP.PtfxThis("scr_amb_chop")
				StartParticleFxLoopedOnPedBone("ent_anim_dog_poo",v,0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(v,11816),2.0,false,false,false)
				StartParticleFxLoopedOnPedBone("ent_anim_dog_poo",v,0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(v,11816),2.0,false,false,false)
			end
		end
	end
end)

RegisterNetEvent("stopSyncParticle")
AddEventHandler("stopSyncParticle",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToPed(index)
		if DoesEntityExist(v) then
			RemoveParticleFxFromEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('bong')
AddEventHandler('bong',function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		TriggerEvent('cancelando',true,true)
		TriggerEvent("progress",8700,"fumando")
		TriggerEvent("sound:source",'bong',0.5)
		vRP.CarregarObjeto("anim@safehouse@bong","bong_stage1","prop_bong_01",50,60309)
		SetTimeout(8700,function()
			vRP.DeletarObjeto()
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE',0.5)
		end)
		SetTimeout(9000,function()
			vRP.loadAnimSet("MOVE_M@DRUNK@VERYDRUNK")
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
			StartScreenEffect("DMT_flight",120000,false)
			Citizen.Wait(120000)
			TriggerEvent("cancelando",false)
			SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
			ResetPedMovementClipset(ped,0.0)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINOCULOS E CAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("binoculos")
AddEventHandler("binoculos",function(status)
	binoculos = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if binoculos then
			local scaleform = RequestScaleformMovie("BINOCULARS")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end

			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,ped,0.0,0.0,1.0,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(ped))
			SetCamFov(cam,fov)
			RenderScriptCams(true,false,0,1,0)

			while binoculos and true do
				Citizen.Wait(100)
				BlockWeaponWheelThisFrame()
				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam,zoomvalue)
				HandleZoom(cam)
				DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
			end

			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false,false,0,1,0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam,false)
			SetNightvision(false)
			SetSeethrough(false)
		end
		if IsControlJustPressed(0,38) and IsInputDisabled(0) then
			if IsEntityPlayingAnim(ped,"missfinale_c2mcs_1","fin_c2_mcs_1_camman",3) then
				camera = true
			end
			if camera then
				local scaleform = RequestScaleformMovie("breaking_news")
				local scaleform2 = RequestScaleformMovie("security_camera")
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(10)
				end
				while not HasScaleformMovieLoaded(scaleform2) do
					Citizen.Wait(10)
				end

				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
				AttachCamToEntity(cam,ped,0.0,0.0,1.0,true)
				SetCamRot(cam,0.0,0.0,GetEntityHeading(ped))
				SetCamFov(cam,fov)
				RenderScriptCams(true,false,0,1,0)

				while camera and true do
					Citizen.Wait(1)
					BlockWeaponWheelThisFrame()
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam,zoomvalue)
					HandleZoom(cam)
					DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
					DrawScaleformMovieFullscreen(scaleform2,255,255,255,255)
					--Breaking("DISNEYLANDIA NEWS")
					if IsControlJustPressed(0,38) and IsInputDisabled(0) then
						camera = false
					end
				end

				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false,false,0,1,0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				SetScaleformMovieAsNoLongerNeeded(scaleform2)
				DestroyCam(cam,false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end
		if IsControlJustPressed(0,38) and IsInputDisabled(0) then
			if IsEntityPlayingAnim(ped,"anim@mp_player_intupperspray_champagne","idle_a",3) then
				TriggerServerEvent("trySyncParticle","champagne",PedToNet(ped))
			elseif IsEntityPlayingAnim(ped,"anim@mp_player_intupperraining_cash","idle_a",3) then
				TriggerServerEvent("trySyncParticle","money",PedToNet(ped))
			end
		elseif IsControlJustReleased(0,38) and IsInputDisabled(0) then
			TriggerServerEvent("tryStopParticle",PedToNet(ped))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z+rightAxisX*-1.0*(8.0)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(8.0)*(zoomvalue+0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) and IsInputDisabled(0) then
		fov = math.max(fov-10.0,fov_min)
	end

	if IsControlJustPressed(0,242) and IsInputDisabled(0) then
		fov = math.min(fov+10.0,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then
		fov = current_fov
	end
	SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply,0)
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if (target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value),0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"],targetCoords["y"],targetCoords["z"],plyCoords["x"],plyCoords["y"],plyCoords["z"],true)
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer,closestDistance
end

function GetPlayers()
    local players = {}
    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players,i)
        end
    end
    return players
end

function Breaking(text)
	SetTextColour(255,255,255,255)
	SetTextFont(8)
	SetTextScale(1.2,1.2)
	SetTextWrap(0.0,1.0)
	SetTextCentre(false)
	SetTextDropshadow(0,0,0,0,255)
	SetTextEdge(1,0,0,0,205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.2,0.85)
end