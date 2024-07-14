fx_version "cerulean"
game "gta5"

ui_page "gui/index.html"
ui_page_preload "yes"

shared_scripts {
	'cfg/config.lua',
}

server_scripts { 
    'lib/utils.lua',
	"base.lua",
	"queue.lua",
	"modules/discord.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/identity.lua",
	"modules/aptitude.lua",
	"modules/basic_items.lua",
}

client_scripts {
    'lib/utils.lua',
    "client/*",
	"map.lua",
	"metas-side/*",
    "ipl.lua",
	'data/**/*.lua',
    'data/**/*.lua',
}

files {
	"loading/*",
	"lib/*",
	"gui/*",
	'mp_m_freemode_01_mp_m_addonrj.meta',
	'mp_f_freemode_01_mp_f_addonrj.meta',
	"interiorproxies.meta",
	"audio/*",
    "audio/**/*",
	"data/*",
	"data/**/*",
    'metas-side/loadouts.meta',
	'data/**/vehicles.meta',
	'data/**/carvariations.meta',
	'data/**/carcols.meta',
	'data/**/handling.meta',
	'data/**/vehiclelayouts.meta',
	'audioconfig/ea888_game.dat151.rel',
	'audioconfig/ea888_sounds.dat54.rel',
	'sfx/dlc_ea888/ea888.awc',
	'sfx/dlc_ea888/ea888_npc.awc',
}

data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_m_freemode_01_mp_m_addonrj.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_f_freemode_01_mp_f_addonrj.meta'    



--[[ VESTITI ]]
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file "SHOP_PED_APPAREL_META_FILE" "data/mp_f_freemode_01_mp_f_police.meta"
data_file "SHOP_PED_APPAREL_META_FILE" "data/mp_m_freemode_01_mp_m_police.meta"
data_file "SHOP_PED_APPAREL_META_FILE" "data/mp_f_freemode_01_mp_f_cabelos.meta"
data_file "SHOP_PED_APPAREL_META_FILE" "data/mp_f_freemode_01_mp_f_roupasfemale.meta"
data_file "SHOP_PED_APPAREL_META_FILE" "data/mp_m_freemode_01_mp_m_roupasmale.meta"

--[[ ARMI ]]--
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/handling.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weapons.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weaponcombatpdw.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weaponheavypistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weapons_assaultrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weapons_carbinerifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weapons_pistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weapons_smg_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weaponsnspistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weaponspecialcarbine.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'metas-side/weapons_specialcarbine_mk2.meta'
data_file "LOADOUTS_FILE" 'metas-side/loadouts.meta'
data_file "INTERIOR_PROXY_ORDER_FILE" "interiorproxies.meta"
data_file "DLC_ITYP_REQUEST" "stream/creative_hotel.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/creative_middle.ytyp"
data_file 'DLC_ITYP_REQUEST' 'stream/graf_dem00'
data_file "DLC_ITYP_REQUEST" "stream/creative_hotel.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/creative_middle.ytyp"
data_file 'DLC_ITYP_REQUEST' 'stream/graf_dem00'
data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'HANDLING_FILE' 'data/**/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/**/carvariations.meta'
data_file "DLC_ITYP_REQUEST" "stream/creative_props.ytyp"   
data_file 'DLC_ITYP_REQUEST' 'stream/v_int_40.ytyp'
data_file 'PED_METADATA_FILE' 'peds.meta'    
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_casino_art_03.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_casino_backarea.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_casino_main.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/int_club.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_casino_accs_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/int_medical.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/pill_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sum_int_mp_h_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sum_prop_sum_collectibles.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_accs.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_accs_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_arcade_claw.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_arcade_street.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_casino_accs_02.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sum_prop_sum_arcade_strength.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_casino_art_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_casino_art_04.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_casino_art_05.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_screens.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vw_prop_vw_casino_art_02.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/v_int_40.ytyp'

data_file 'HANDLING_FILE' 'data/addon1/handling_addon1.meta' --1
data_file 'VEHICLE_METADATA_FILE' 'data/addon1/vehicles_addon1.meta' --1
data_file 'CARCOLS_FILE' 'data/addon1/carcols_addon1.meta' --1
data_file 'VEHICLE_VARIATION_FILE' 'data/addon1/carvariations_addon1.meta' --1

data_file 'HANDLING_FILE' 'data/addon2/handling_addon2.meta' --2
data_file 'VEHICLE_METADATA_FILE' 'data/addon2/vehicles_addon2.meta' --2
data_file 'CARCOLS_FILE' 'data/addon2/carcols_addon2.meta' --2
data_file 'VEHICLE_VARIATION_FILE' 'data/addon2/carvariations_addon2.meta' --2
data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'
data_file 'AUDIO_GAMEDATA' 'audioconfig/ea888_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ea888_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ea888'                                                        


loadscreen "loading/index.html"
server_export "AddPriority"
server_export "RemovePriority"

              