-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("garages",src)
vCLIENT = Tunnel.getInterface("garages")
local inventory = module("vrp","cfg/inventory")
local idgens = Tools.newIDGenerator()

local taxipva = ""
local segurocarro = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("creative/get_vehicle","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_update_vehicles","UPDATE vrp_user_vehicles SET engine = @engine, body = @body WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_detido","UPDATE vrp_user_vehicles SET detido = @detido WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_ipva","UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,@ipva)")
vRP._prepare("creative/con_maxvehs","SELECT COUNT(vehicle) as qtd FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP._prepare("creative/get_estoque","SELECT * FROM vrp_estoque WHERE vehicle = @vehicle")
vRP._prepare("creative/set_estoque","UPDATE vrp_estoque SET quantidade = @quantidade WHERE vehicle = @vehicle")
vRP._prepare("creative/get_users","SELECT * FROM vrp_users WHERE id = @user_id")


vRP.prepare('rusher/check_trusts', "SELECT * FROM carkeys WHERE placa = @placa")
vRP.prepare('rusher/sel_truste', "SELECT * FROM carkeys WHERE user_id = @user_id AND placa = @placa")
vRP.prepare('rusher/add_truste', "INSERT INTO carkeys(user_id, placa) VALUES(@user_id, @placa)")
vRP.prepare('rusher/rem_truste', "DELETE FROM carkeys WHERE user_id = @user_id AND placa = @placa")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local police = {}
local vehlist = {}
local trydoors = {}
trydoors["CLONADOS"] = true
trydoors["AAAAAAAA"] = true

-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNVEHICLESEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.returnVehicleEveryone(placa)
	return trydoors[placa]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("setPlateEveryone")
AddEventHandler("setPlateEveryone",function(placa)
	trydoors[placa] = true
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local garages = {
	[1] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[2] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[3] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[4] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[5] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[6] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[7] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[8] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[9] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[10] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[11] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[12] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[13] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[14] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[15] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },

	[649] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[650] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[651] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[652] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[653] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[654] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[655] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[656] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[657] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[658] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[659] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[663] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[664] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[1557] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[1558] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[1559] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[5050] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[1560] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[1561] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[1562] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[1563] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	
	[661] = { ['name'] = "polizia", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[662] = { ['name'] = "Garagem", ['payment'] = true, ['public'] = true },
	[16] = { ['name'] = "polizia2", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[17] = { ['name'] = "poliziaNorte", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[18] = { ['name'] = "poliziaHN", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[19] = { ['name'] = "polizia", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[20] = { ['name'] = "poliziaB", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[21] = { ['name'] = "poliziaH", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[22] = { ['name'] = "poliziaA", ['payment'] = true, ['perm'] = "polizia.autorizzazione" },
	[23] = { ['name'] = "Paramedico", ['payment'] = false, ['perm'] = "paramedico.autorizzazione" },
	[24] = { ['name'] = "Paramedico", ['payment'] = false, ['perm'] = "paramedico.autorizzazione" },
	[25] = { ['name'] = "Paramedico", ['payment'] = false, ['perm'] = "paramedico.autorizzazione" },
	[26] = { ['name'] = "ParamedicoH", ['payment'] = false, ['perm'] = "paramedico.autorizzazione" },
	[660] = { ['name'] = "Paramedico", ['payment'] = false, ['perm'] = "paramedico.autorizzazione" }, -- NORTE
	[28] = { ['name'] = "Mecanico", ['payment'] = false, ['perm'] = "mecanico.autorizzazione" },
	[29] = { ['name'] = "Mecanico", ['payment'] = false, ['perm'] = "mecanico.autorizzazione" },
	[38] = { ['name'] = "Embarcações", ['payment'] = false, ['perm'] = "livre" },
	[39] = { ['name'] = "Embarcações", ['payment'] = false, ['perm'] = "livre" },
	[40] = { ['name'] = "Embarcações", ['payment'] = false, ['perm'] = "livre" },
	[41] = { ['name'] = "Embarcações", ['payment'] = false, ['perm'] = "livre" },
	[42] = { ['name'] = "Embarcações", ['payment'] = false, ['perm'] = "livre" },
	[43] = { ['name'] = "Embarcações", ['payment'] = false, ['perm'] = "livre" },
	[58] = { ['name'] = "Bicicletario", ['payment'] = false, ['perm'] = "livre" },
	[59] = { ['name'] = "Bicicletario", ['payment'] = false, ['perm'] = "livre" },
	-----------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------FORTHILLS-----------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[145] = { ['name'] = "FH01", ['payment'] = false, ['public'] = false },
	[146] = { ['name'] = "FH02", ['payment'] = false, ['public'] = false },
	[147] = { ['name'] = "FH03", ['payment'] = false, ['public'] = false },
	[148] = { ['name'] = "FH04", ['payment'] = false, ['public'] = false },
	[149] = { ['name'] = "FH05", ['payment'] = false, ['public'] = false },
	[150] = { ['name'] = "FH06", ['payment'] = false, ['public'] = false },
	[151] = { ['name'] = "FH07", ['payment'] = false, ['public'] = false },
	[152] = { ['name'] = "FH08", ['payment'] = false, ['public'] = false },
	[153] = { ['name'] = "FH09", ['payment'] = false, ['public'] = false },
	[154] = { ['name'] = "FH10", ['payment'] = false, ['public'] = false },	
	[155] = { ['name'] = "FH11", ['payment'] = false, ['public'] = false },
	[156] = { ['name'] = "FH12", ['payment'] = false, ['public'] = false },
	[157] = { ['name'] = "FH13", ['payment'] = false, ['public'] = false },
	[158] = { ['name'] = "FH14", ['payment'] = false, ['public'] = false },
	[159] = { ['name'] = "FH15", ['payment'] = false, ['public'] = false },
	[160] = { ['name'] = "FH16", ['payment'] = false, ['public'] = false },
	[161] = { ['name'] = "FH17", ['payment'] = false, ['public'] = false },
	[162] = { ['name'] = "FH18", ['payment'] = false, ['public'] = false },
	[163] = { ['name'] = "FH19", ['payment'] = false, ['public'] = false },
	[164] = { ['name'] = "FH20", ['payment'] = false, ['public'] = false },
	[165] = { ['name'] = "FH21", ['payment'] = false, ['public'] = false },
	[166] = { ['name'] = "FH22", ['payment'] = false, ['public'] = false },
	[167] = { ['name'] = "FH23", ['payment'] = false, ['public'] = false },
	[168] = { ['name'] = "FH24", ['payment'] = false, ['public'] = false },
	[170] = { ['name'] = "FH26", ['payment'] = false, ['public'] = false },
	[171] = { ['name'] = "FH27", ['payment'] = false, ['public'] = false },
	[172] = { ['name'] = "FH28", ['payment'] = false, ['public'] = false },
	[173] = { ['name'] = "FH29", ['payment'] = false, ['public'] = false },
	[174] = { ['name'] = "FH30", ['payment'] = false, ['public'] = false },
	[175] = { ['name'] = "FH31", ['payment'] = false, ['public'] = false },
	[176] = { ['name'] = "FH32", ['payment'] = false, ['public'] = false },
	[177] = { ['name'] = "FH33", ['payment'] = false, ['public'] = false },
	[178] = { ['name'] = "FH34", ['payment'] = false, ['public'] = false },
	[180] = { ['name'] = "FH36", ['payment'] = false, ['public'] = false },
	[181] = { ['name'] = "FH37", ['payment'] = false, ['public'] = false },
	[182] = { ['name'] = "FH38", ['payment'] = false, ['public'] = false },
	[183] = { ['name'] = "FH39", ['payment'] = false, ['public'] = false },
	[184] = { ['name'] = "FH40", ['payment'] = false, ['public'] = false },
	[185] = { ['name'] = "FH41", ['payment'] = false, ['public'] = false },
	[186] = { ['name'] = "FH42", ['payment'] = false, ['public'] = false },
	[187] = { ['name'] = "FH43", ['payment'] = false, ['public'] = false },
	[188] = { ['name'] = "FH44", ['payment'] = false, ['public'] = false },
	[189] = { ['name'] = "FH45", ['payment'] = false, ['public'] = false },
	[190] = { ['name'] = "FH46", ['payment'] = false, ['public'] = false },
	[191] = { ['name'] = "FH47", ['payment'] = false, ['public'] = false },
	[192] = { ['name'] = "FH48", ['payment'] = false, ['public'] = false },
	[193] = { ['name'] = "FH49", ['payment'] = false, ['public'] = false },
	[194] = { ['name'] = "FH50", ['payment'] = false, ['public'] = false },
	[195] = { ['name'] = "FH51", ['payment'] = false, ['public'] = false },
	[196] = { ['name'] = "FH52", ['payment'] = false, ['public'] = false },
	[197] = { ['name'] = "FH53", ['payment'] = false, ['public'] = false },
	[198] = { ['name'] = "FH54", ['payment'] = false, ['public'] = false },
	[199] = { ['name'] = "FH55", ['payment'] = false, ['public'] = false },
	[200] = { ['name'] = "FH56", ['payment'] = false, ['public'] = false },
	[201] = { ['name'] = "FH57", ['payment'] = false, ['public'] = false },
	[202] = { ['name'] = "FH58", ['payment'] = false, ['public'] = false },
	[203] = { ['name'] = "FH59", ['payment'] = false, ['public'] = false },
	[204] = { ['name'] = "FH60", ['payment'] = false, ['public'] = false },
	[205] = { ['name'] = "FH61", ['payment'] = false, ['public'] = false },
	[206] = { ['name'] = "FH62", ['payment'] = false, ['public'] = false },
	[207] = { ['name'] = "FH63", ['payment'] = false, ['public'] = false },
	[208] = { ['name'] = "FH64", ['payment'] = false, ['public'] = false },
	[209] = { ['name'] = "FH65", ['payment'] = false, ['public'] = false },
	[210] = { ['name'] = "FH66", ['payment'] = false, ['public'] = false },
	[211] = { ['name'] = "FH67", ['payment'] = false, ['public'] = false },
	[212] = { ['name'] = "FH68", ['payment'] = false, ['public'] = false },
	[213] = { ['name'] = "FH69", ['payment'] = false, ['public'] = false },
	[214] = { ['name'] = "FH70", ['payment'] = false, ['public'] = false },
	[215] = { ['name'] = "FH71", ['payment'] = false, ['public'] = false },
	[216] = { ['name'] = "FH72", ['payment'] = false, ['public'] = false },
	[217] = { ['name'] = "FH73", ['payment'] = false, ['public'] = false },
	[218] = { ['name'] = "FH74", ['payment'] = false, ['public'] = false },
	[219] = { ['name'] = "FH75", ['payment'] = false, ['public'] = false },
	[220] = { ['name'] = "FH76", ['payment'] = false, ['public'] = false },
	[221] = { ['name'] = "FH77", ['payment'] = false, ['public'] = false },
	[222] = { ['name'] = "FH78", ['payment'] = false, ['public'] = false },
	[223] = { ['name'] = "FH79", ['payment'] = false, ['public'] = false },
	[224] = { ['name'] = "FH80", ['payment'] = false, ['public'] = false },
	[225] = { ['name'] = "FH81", ['payment'] = false, ['public'] = false },
	[226] = { ['name'] = "FH82", ['payment'] = false, ['public'] = false },
	[227] = { ['name'] = "FH83", ['payment'] = false, ['public'] = false },
	[228] = { ['name'] = "FH84", ['payment'] = false, ['public'] = false },
	[229] = { ['name'] = "FH85", ['payment'] = false, ['public'] = false },
	[230] = { ['name'] = "FH86", ['payment'] = false, ['public'] = false },
	[231] = { ['name'] = "FH87", ['payment'] = false, ['public'] = false },
	[232] = { ['name'] = "FH88", ['payment'] = false, ['public'] = false },
	[233] = { ['name'] = "FH89", ['payment'] = false, ['public'] = false },
	[234] = { ['name'] = "FH90", ['payment'] = false, ['public'] = false },
	[235] = { ['name'] = "FH91", ['payment'] = false, ['public'] = false },
	[236] = { ['name'] = "FH92", ['payment'] = false, ['public'] = false },
	[237] = { ['name'] = "FH93", ['payment'] = false, ['public'] = false },
	[238] = { ['name'] = "FH94", ['payment'] = false, ['public'] = false },
	[239] = { ['name'] = "FH95", ['payment'] = false, ['public'] = false },
	[240] = { ['name'] = "FH96", ['payment'] = false, ['public'] = false },
	[241] = { ['name'] = "FH97", ['payment'] = false, ['public'] = false },
	[242] = { ['name'] = "FH98", ['payment'] = false, ['public'] = false },
	[243] = { ['name'] = "FH99", ['payment'] = false, ['public'] = false },
	[244] = { ['name'] = "FH100", ['payment'] = false, ['public'] = false },
	-----------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------LUXURY--------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[245] = { ['name'] = "LX01", ['payment'] = false, ['public'] = false },
	[246] = { ['name'] = "LX02", ['payment'] = false, ['public'] = false },
	[247] = { ['name'] = "LX03", ['payment'] = false, ['public'] = false },
	[248] = { ['name'] = "LX04", ['payment'] = false, ['public'] = false },
	[249] = { ['name'] = "LX05", ['payment'] = false, ['public'] = false },
	[250] = { ['name'] = "LX06", ['payment'] = false, ['public'] = false },
	[251] = { ['name'] = "LX07", ['payment'] = false, ['public'] = false },
	[252] = { ['name'] = "LX08", ['payment'] = false, ['public'] = false },
	[253] = { ['name'] = "LX09", ['payment'] = false, ['public'] = false },
	[254] = { ['name'] = "LX10", ['payment'] = false, ['public'] = false },
	[255] = { ['name'] = "LX11", ['payment'] = false, ['public'] = false },
	[256] = { ['name'] = "LX12", ['payment'] = false, ['public'] = false },
	[257] = { ['name'] = "LX13", ['payment'] = false, ['public'] = false },
	[258] = { ['name'] = "LX14", ['payment'] = false, ['public'] = false },
	[259] = { ['name'] = "LX15", ['payment'] = false, ['public'] = false },
	[260] = { ['name'] = "LX16", ['payment'] = false, ['public'] = false },
	[261] = { ['name'] = "LX17", ['payment'] = false, ['public'] = false },
	[262] = { ['name'] = "LX18", ['payment'] = false, ['public'] = false },
	[263] = { ['name'] = "LX19", ['payment'] = false, ['public'] = false },
	[264] = { ['name'] = "LX20", ['payment'] = false, ['public'] = false },
	[265] = { ['name'] = "LX21", ['payment'] = false, ['public'] = false },
	[266] = { ['name'] = "LX22", ['payment'] = false, ['public'] = false },
	[267] = { ['name'] = "LX23", ['payment'] = false, ['public'] = false },
	[268] = { ['name'] = "LX24", ['payment'] = false, ['public'] = false },
	[269] = { ['name'] = "LX25", ['payment'] = false, ['public'] = false },
	[270] = { ['name'] = "LX26", ['payment'] = false, ['public'] = false },
	[271] = { ['name'] = "LX27", ['payment'] = false, ['public'] = false },
	[272] = { ['name'] = "LX28", ['payment'] = false, ['public'] = false },
	[273] = { ['name'] = "LX29", ['payment'] = false, ['public'] = false },
	[274] = { ['name'] = "LX30", ['payment'] = false, ['public'] = false },
	[275] = { ['name'] = "LX31", ['payment'] = false, ['public'] = false },
	[276] = { ['name'] = "LX32", ['payment'] = false, ['public'] = false },
	[277] = { ['name'] = "LX33", ['payment'] = false, ['public'] = false },
	[278] = { ['name'] = "LX34", ['payment'] = false, ['public'] = false },
	[279] = { ['name'] = "LX35", ['payment'] = false, ['public'] = false },
	[280] = { ['name'] = "LX36", ['payment'] = false, ['public'] = false },
	[281] = { ['name'] = "LX37", ['payment'] = false, ['public'] = false },
	[282] = { ['name'] = "LX38", ['payment'] = false, ['public'] = false },
	[283] = { ['name'] = "LX39", ['payment'] = false, ['public'] = false },
	[284] = { ['name'] = "LX40", ['payment'] = false, ['public'] = false },
	[285] = { ['name'] = "LX41", ['payment'] = false, ['public'] = false },
	[286] = { ['name'] = "LX42", ['payment'] = false, ['public'] = false },
	[287] = { ['name'] = "LX43", ['payment'] = false, ['public'] = false },
	[288] = { ['name'] = "LX44", ['payment'] = false, ['public'] = false },
	[289] = { ['name'] = "LX45", ['payment'] = false, ['public'] = false },
	[290] = { ['name'] = "LX46", ['payment'] = false, ['public'] = false },
	[291] = { ['name'] = "LX47", ['payment'] = false, ['public'] = false },
	[292] = { ['name'] = "LX48", ['payment'] = false, ['public'] = false },
	[293] = { ['name'] = "LX49", ['payment'] = false, ['public'] = false },
	[294] = { ['name'] = "LX50", ['payment'] = false, ['public'] = false },
	[295] = { ['name'] = "LX51", ['payment'] = false, ['public'] = false },
	[296] = { ['name'] = "LX52", ['payment'] = false, ['public'] = false },
	[297] = { ['name'] = "LX53", ['payment'] = false, ['public'] = false },
	[298] = { ['name'] = "LX54", ['payment'] = false, ['public'] = false },
	[299] = { ['name'] = "LX55", ['payment'] = false, ['public'] = false },
	[300] = { ['name'] = "LX56", ['payment'] = false, ['public'] = false },
	[301] = { ['name'] = "LX57", ['payment'] = false, ['public'] = false },
	[302] = { ['name'] = "LX58", ['payment'] = false, ['public'] = false },
	[303] = { ['name'] = "LX59", ['payment'] = false, ['public'] = false },
	[304] = { ['name'] = "LX60", ['payment'] = false, ['public'] = false },
	[305] = { ['name'] = "LX61", ['payment'] = false, ['public'] = false },
	[306] = { ['name'] = "LX62", ['payment'] = false, ['public'] = false },
	[307] = { ['name'] = "LX63", ['payment'] = false, ['public'] = false },
	[308] = { ['name'] = "LX64", ['payment'] = false, ['public'] = false },
	[309] = { ['name'] = "LX65", ['payment'] = false, ['public'] = false },
	[310] = { ['name'] = "LX66", ['payment'] = false, ['public'] = false },
	[311] = { ['name'] = "LX67", ['payment'] = false, ['public'] = false },
	[312] = { ['name'] = "LX68", ['payment'] = false, ['public'] = false },
	[313] = { ['name'] = "LX69", ['payment'] = false, ['public'] = false },
	[314] = { ['name'] = "LX70", ['payment'] = false, ['public'] = false },
	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------SAMIR-------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[315] = { ['name'] = "LS01", ['payment'] = false, ['public'] = false },
	[316] = { ['name'] = "LS02", ['payment'] = false, ['public'] = false },
	[317] = { ['name'] = "LS03", ['payment'] = false, ['public'] = false },
	[318] = { ['name'] = "LS04", ['payment'] = false, ['public'] = false },
	[319] = { ['name'] = "LS05", ['payment'] = false, ['public'] = false },
	[320] = { ['name'] = "LS06", ['payment'] = false, ['public'] = false },
	[321] = { ['name'] = "LS07", ['payment'] = false, ['public'] = false },
	[322] = { ['name'] = "LS08", ['payment'] = false, ['public'] = false },
	[323] = { ['name'] = "LS09", ['payment'] = false, ['public'] = false },
	[324] = { ['name'] = "LS10", ['payment'] = false, ['public'] = false },
	[325] = { ['name'] = "LS11", ['payment'] = false, ['public'] = false },
	[326] = { ['name'] = "LS12", ['payment'] = false, ['public'] = false },
	[327] = { ['name'] = "LS13", ['payment'] = false, ['public'] = false },
	[328] = { ['name'] = "LS14", ['payment'] = false, ['public'] = false },
	[329] = { ['name'] = "LS15", ['payment'] = false, ['public'] = false },
	[330] = { ['name'] = "LS16", ['payment'] = false, ['public'] = false },
	[331] = { ['name'] = "LS17", ['payment'] = false, ['public'] = false },
	[332] = { ['name'] = "LS18", ['payment'] = false, ['public'] = false },
	[333] = { ['name'] = "LS19", ['payment'] = false, ['public'] = false },
	[334] = { ['name'] = "LS20", ['payment'] = false, ['public'] = false },
	[335] = { ['name'] = "LS21", ['payment'] = false, ['public'] = false },
	[336] = { ['name'] = "LS22", ['payment'] = false, ['public'] = false },
	[337] = { ['name'] = "LS23", ['payment'] = false, ['public'] = false },
	[338] = { ['name'] = "LS24", ['payment'] = false, ['public'] = false },
	[339] = { ['name'] = "LS25", ['payment'] = false, ['public'] = false },
	[340] = { ['name'] = "LS26", ['payment'] = false, ['public'] = false },
	[341] = { ['name'] = "LS27", ['payment'] = false, ['public'] = false },
	[342] = { ['name'] = "LS28", ['payment'] = false, ['public'] = false },
	[343] = { ['name'] = "LS29", ['payment'] = false, ['public'] = false },
	[344] = { ['name'] = "LS30", ['payment'] = false, ['public'] = false },
	[345] = { ['name'] = "LS31", ['payment'] = false, ['public'] = false },
	[346] = { ['name'] = "LS32", ['payment'] = false, ['public'] = false },
	[347] = { ['name'] = "LS33", ['payment'] = false, ['public'] = false },
	[348] = { ['name'] = "LS34", ['payment'] = false, ['public'] = false },
	[349] = { ['name'] = "LS35", ['payment'] = false, ['public'] = false },
	[350] = { ['name'] = "LS36", ['payment'] = false, ['public'] = false },
	[351] = { ['name'] = "LS37", ['payment'] = false, ['public'] = false },
	[352] = { ['name'] = "LS38", ['payment'] = false, ['public'] = false },
	[353] = { ['name'] = "LS39", ['payment'] = false, ['public'] = false },
	[354] = { ['name'] = "LS40", ['payment'] = false, ['public'] = false },
	[355] = { ['name'] = "LS41", ['payment'] = false, ['public'] = false },
	[356] = { ['name'] = "LS42", ['payment'] = false, ['public'] = false },
	[357] = { ['name'] = "LS43", ['payment'] = false, ['public'] = false },
	[358] = { ['name'] = "LS44", ['payment'] = false, ['public'] = false },
	[359] = { ['name'] = "LS45", ['payment'] = false, ['public'] = false },
	[360] = { ['name'] = "LS46", ['payment'] = false, ['public'] = false },
	[361] = { ['name'] = "LS47", ['payment'] = false, ['public'] = false },
	[362] = { ['name'] = "LS48", ['payment'] = false, ['public'] = false },
	[363] = { ['name'] = "LS49", ['payment'] = false, ['public'] = false },
	[364] = { ['name'] = "LS50", ['payment'] = false, ['public'] = false },
	[365] = { ['name'] = "LS51", ['payment'] = false, ['public'] = false },
	[366] = { ['name'] = "LS52", ['payment'] = false, ['public'] = false },
	[367] = { ['name'] = "LS53", ['payment'] = false, ['public'] = false },
	[368] = { ['name'] = "LS54", ['payment'] = false, ['public'] = false },
	[369] = { ['name'] = "LS55", ['payment'] = false, ['public'] = false },
	[370] = { ['name'] = "LS56", ['payment'] = false, ['public'] = false },
	[371] = { ['name'] = "LS57", ['payment'] = false, ['public'] = false },
	[372] = { ['name'] = "LS58", ['payment'] = false, ['public'] = false },
	[373] = { ['name'] = "LS59", ['payment'] = false, ['public'] = false },
	[374] = { ['name'] = "LS60", ['payment'] = false, ['public'] = false },
	[375] = { ['name'] = "LS61", ['payment'] = false, ['public'] = false },
	[376] = { ['name'] = "LS62", ['payment'] = false, ['public'] = false },
	[377] = { ['name'] = "LS63", ['payment'] = false, ['public'] = false },
	[378] = { ['name'] = "LS64", ['payment'] = false, ['public'] = false },
	[379] = { ['name'] = "LS65", ['payment'] = false, ['public'] = false },
	[380] = { ['name'] = "LS66", ['payment'] = false, ['public'] = false },
	[381] = { ['name'] = "LS67", ['payment'] = false, ['public'] = false },
	[382] = { ['name'] = "LS68", ['payment'] = false, ['public'] = false },
	[383] = { ['name'] = "LS69", ['payment'] = false, ['public'] = false },
	[384] = { ['name'] = "LS70", ['payment'] = false, ['public'] = false },
	[385] = { ['name'] = "LS71", ['payment'] = false, ['public'] = false },
	[386] = { ['name'] = "LS72", ['payment'] = false, ['public'] = false },
	-----------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------KRONDORS------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[387] = { ['name'] = "KR01", ['payment'] = false, ['public'] = false },
	[388] = { ['name'] = "KR02", ['payment'] = false, ['public'] = false },
	[389] = { ['name'] = "KR03", ['payment'] = false, ['public'] = false },
	[390] = { ['name'] = "KR04", ['payment'] = false, ['public'] = false },
	[391] = { ['name'] = "KR05", ['payment'] = false, ['public'] = false },
	[392] = { ['name'] = "KR06", ['payment'] = false, ['public'] = false },
	[393] = { ['name'] = "KR07", ['payment'] = false, ['public'] = false },
	[394] = { ['name'] = "KR08", ['payment'] = false, ['public'] = false },
	[395] = { ['name'] = "KR09", ['payment'] = false, ['public'] = false },
	[396] = { ['name'] = "KR10", ['payment'] = false, ['public'] = false },
	[397] = { ['name'] = "KR11", ['payment'] = false, ['public'] = false },
	[398] = { ['name'] = "KR12", ['payment'] = false, ['public'] = false },
	[399] = { ['name'] = "KR13", ['payment'] = false, ['public'] = false },
	[400] = { ['name'] = "KR14", ['payment'] = false, ['public'] = false },
	[401] = { ['name'] = "KR15", ['payment'] = false, ['public'] = false },
	[402] = { ['name'] = "KR16", ['payment'] = false, ['public'] = false },
	[403] = { ['name'] = "KR17", ['payment'] = false, ['public'] = false },
	[404] = { ['name'] = "KR18", ['payment'] = false, ['public'] = false },
	[405] = { ['name'] = "KR19", ['payment'] = false, ['public'] = false },
	[406] = { ['name'] = "KR20", ['payment'] = false, ['public'] = false },
	[407] = { ['name'] = "KR21", ['payment'] = false, ['public'] = false },
	[408] = { ['name'] = "KR22", ['payment'] = false, ['public'] = false },
	[409] = { ['name'] = "KR23", ['payment'] = false, ['public'] = false },
	[410] = { ['name'] = "KR24", ['payment'] = false, ['public'] = false },
	[411] = { ['name'] = "KR25", ['payment'] = false, ['public'] = false },
	[412] = { ['name'] = "KR26", ['payment'] = false, ['public'] = false },
	[413] = { ['name'] = "KR27", ['payment'] = false, ['public'] = false },
	[414] = { ['name'] = "KR28", ['payment'] = false, ['public'] = false },
	[415] = { ['name'] = "KR29", ['payment'] = false, ['public'] = false },
	[416] = { ['name'] = "KR30", ['payment'] = false, ['public'] = false },
	[417] = { ['name'] = "KR31", ['payment'] = false, ['public'] = false },
	[418] = { ['name'] = "KR32", ['payment'] = false, ['public'] = false },
	[419] = { ['name'] = "KR33", ['payment'] = false, ['public'] = false },
	[420] = { ['name'] = "KR34", ['payment'] = false, ['public'] = false },
	[421] = { ['name'] = "KR35", ['payment'] = false, ['public'] = false },
	[422] = { ['name'] = "KR36", ['payment'] = false, ['public'] = false },
	[423] = { ['name'] = "KR37", ['payment'] = false, ['public'] = false },
	[424] = { ['name'] = "KR38", ['payment'] = false, ['public'] = false },
	[425] = { ['name'] = "KR39", ['payment'] = false, ['public'] = false },
	[426] = { ['name'] = "KR40", ['payment'] = false, ['public'] = false },
	[427] = { ['name'] = "KR41", ['payment'] = false, ['public'] = false },
	-----------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------LOSVAGOS------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[428] = { ['name'] = "LV01", ['payment'] = false, ['public'] = false },
	[429] = { ['name'] = "LV02", ['payment'] = false, ['public'] = false },
	[430] = { ['name'] = "LV03", ['payment'] = false, ['public'] = false },
	[431] = { ['name'] = "LV04", ['payment'] = false, ['public'] = false },
	[432] = { ['name'] = "LV05", ['payment'] = false, ['public'] = false },
	[433] = { ['name'] = "LV06", ['payment'] = false, ['public'] = false },
	[434] = { ['name'] = "LV07", ['payment'] = false, ['public'] = false },
	[435] = { ['name'] = "LV08", ['payment'] = false, ['public'] = false },
	[436] = { ['name'] = "LV09", ['payment'] = false, ['public'] = false },
	[437] = { ['name'] = "LV10", ['payment'] = false, ['public'] = false },
	[438] = { ['name'] = "LV11", ['payment'] = false, ['public'] = false },
	[439] = { ['name'] = "LV12", ['payment'] = false, ['public'] = false },
	[440] = { ['name'] = "LV13", ['payment'] = false, ['public'] = false },
	[441] = { ['name'] = "LV14", ['payment'] = false, ['public'] = false },
	[442] = { ['name'] = "LV15", ['payment'] = false, ['public'] = false },
	[443] = { ['name'] = "LV16", ['payment'] = false, ['public'] = false },
	[444] = { ['name'] = "LV17", ['payment'] = false, ['public'] = false },
	[445] = { ['name'] = "LV18", ['payment'] = false, ['public'] = false },
	[446] = { ['name'] = "LV19", ['payment'] = false, ['public'] = false },
	[447] = { ['name'] = "LV20", ['payment'] = false, ['public'] = false },
	[448] = { ['name'] = "LV21", ['payment'] = false, ['public'] = false },
	[449] = { ['name'] = "LV22", ['payment'] = false, ['public'] = false },
	[450] = { ['name'] = "LV23", ['payment'] = false, ['public'] = false },
	[451] = { ['name'] = "LV24", ['payment'] = false, ['public'] = false },
	[452] = { ['name'] = "LV25", ['payment'] = false, ['public'] = false },
	[453] = { ['name'] = "LV26", ['payment'] = false, ['public'] = false },
	[454] = { ['name'] = "LV27", ['payment'] = false, ['public'] = false },
	[455] = { ['name'] = "LV28", ['payment'] = false, ['public'] = false },
	[456] = { ['name'] = "LV29", ['payment'] = false, ['public'] = false },
	[457] = { ['name'] = "LV30", ['payment'] = false, ['public'] = false },
	[458] = { ['name'] = "LV31", ['payment'] = false, ['public'] = false },
	[459] = { ['name'] = "LV32", ['payment'] = false, ['public'] = false },
	[460] = { ['name'] = "LV33", ['payment'] = false, ['public'] = false },
	[461] = { ['name'] = "LV34", ['payment'] = false, ['public'] = false },
	[462] = { ['name'] = "LV35", ['payment'] = false, ['public'] = false },
	-----------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------PALETOBAY-------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[463] = { ['name'] = "PB01", ['payment'] = false, ['public'] = false },
	[464] = { ['name'] = "PB02", ['payment'] = false, ['public'] = false },
	[465] = { ['name'] = "PB03", ['payment'] = false, ['public'] = false },
	[466] = { ['name'] = "PB04", ['payment'] = false, ['public'] = false },
	[467] = { ['name'] = "PB05", ['payment'] = false, ['public'] = false },
	[468] = { ['name'] = "PB06", ['payment'] = false, ['public'] = false },
	[469] = { ['name'] = "PB07", ['payment'] = false, ['public'] = false },
	[470] = { ['name'] = "PB08", ['payment'] = false, ['public'] = false },
	[471] = { ['name'] = "PB09", ['payment'] = false, ['public'] = false },
	[472] = { ['name'] = "PB10", ['payment'] = false, ['public'] = false },
	[473] = { ['name'] = "PB11", ['payment'] = false, ['public'] = false },
	[474] = { ['name'] = "PB12", ['payment'] = false, ['public'] = false },
	[475] = { ['name'] = "PB13", ['payment'] = false, ['public'] = false },
	[476] = { ['name'] = "PB14", ['payment'] = false, ['public'] = false },
	[477] = { ['name'] = "PB15", ['payment'] = false, ['public'] = false },
	[478] = { ['name'] = "PB16", ['payment'] = false, ['public'] = false },
	[479] = { ['name'] = "PB17", ['payment'] = false, ['public'] = false },
	[480] = { ['name'] = "PB18", ['payment'] = false, ['public'] = false },
	[481] = { ['name'] = "PB19", ['payment'] = false, ['public'] = false },
	[482] = { ['name'] = "PB20", ['payment'] = false, ['public'] = false },
	[483] = { ['name'] = "PB21", ['payment'] = false, ['public'] = false },
	[484] = { ['name'] = "PB22", ['payment'] = false, ['public'] = false },
	[485] = { ['name'] = "PB23", ['payment'] = false, ['public'] = false },
	[486] = { ['name'] = "PB24", ['payment'] = false, ['public'] = false },
	[487] = { ['name'] = "PB25", ['payment'] = false, ['public'] = false },
	[488] = { ['name'] = "PB26", ['payment'] = false, ['public'] = false },
	[489] = { ['name'] = "PB27", ['payment'] = false, ['public'] = false },
	[490] = { ['name'] = "PB28", ['payment'] = false, ['public'] = false },
	[491] = { ['name'] = "PB29", ['payment'] = false, ['public'] = false },
	[492] = { ['name'] = "PB30", ['payment'] = false, ['public'] = false },
	[493] = { ['name'] = "PB31", ['payment'] = false, ['public'] = false },
	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------MANSAO------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[600] = { ['name'] = "MS01", ['payment'] = false, ['public'] = false },
	[601] = { ['name'] = "MS02", ['payment'] = false, ['public'] = false },
	[602] = { ['name'] = "MS03", ['payment'] = false, ['public'] = false },
	[603] = { ['name'] = "MS04", ['payment'] = false, ['public'] = false },
	[604] = { ['name'] = "MS05", ['payment'] = false, ['public'] = false },
	[605] = { ['name'] = "MS09", ['payment'] = false, ['public'] = false },
	[606] = { ['name'] = "SS01", ['payment'] = false, ['public'] = false },
	[607] = { ['name'] = "MS08", ['payment'] = false, ['public'] = false },
	[608] = { ['name'] = "MS06", ['payment'] = false, ['public'] = false },
	[609] = { ['name'] = "FZ01", ['payment'] = false, ['public'] = false },

	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------BLOODS------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[610] = { ['name'] = "BD01", ['payment'] = false, ['public'] = false },
	[611] = { ['name'] = "BD02", ['payment'] = false, ['public'] = false },
	[612] = { ['name'] = "BD03", ['payment'] = false, ['public'] = false },
	[613] = { ['name'] = "BD04", ['payment'] = false, ['public'] = false },
	[614] = { ['name'] = "BD05", ['payment'] = false, ['public'] = false },
	[615] = { ['name'] = "BD06", ['payment'] = false, ['public'] = false },
	[616] = { ['name'] = "BD07", ['payment'] = false, ['public'] = false },
	[617] = { ['name'] = "BD08", ['payment'] = false, ['public'] = false },
	[618] = { ['name'] = "BD09", ['payment'] = false, ['public'] = false },
	[619] = { ['name'] = "BD10", ['payment'] = false, ['public'] = false },

	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------CRIPS------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[620] = { ['name'] = "CR01", ['payment'] = false, ['public'] = false },
	[621] = { ['name'] = "CR02", ['payment'] = false, ['public'] = false },
	[622] = { ['name'] = "CR03", ['payment'] = false, ['public'] = false },
	[623] = { ['name'] = "CR04", ['payment'] = false, ['public'] = false },
	[624] = { ['name'] = "CR05", ['payment'] = false, ['public'] = false },
	[625] = { ['name'] = "CR06", ['payment'] = false, ['public'] = false },
	[626] = { ['name'] = "CR07", ['payment'] = false, ['public'] = false },
	[627] = { ['name'] = "CR08", ['payment'] = false, ['public'] = false },
	[628] = { ['name'] = "CR09", ['payment'] = false, ['public'] = false },
	[629] = { ['name'] = "CR10", ['payment'] = false, ['public'] = false },
	[630] = { ['name'] = "CR11", ['payment'] = false, ['public'] = false },
	[631] = { ['name'] = "CR12", ['payment'] = false, ['public'] = false },
	[632] = { ['name'] = "CR13", ['payment'] = false, ['public'] = false },
	[633] = { ['name'] = "CR14", ['payment'] = false, ['public'] = false },
	[634] = { ['name'] = "CR15", ['payment'] = false, ['public'] = false },
	[635] = { ['name'] = "CR16", ['payment'] = false, ['public'] = false },
	[636] = { ['name'] = "CR17", ['payment'] = false, ['public'] = false },
	-----------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------EXCLUSIVOS----------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[637] = { ['name'] = "PLAYBOY", ['payment'] = false, ['public'] = false },
	[638] = { ['name'] = "GOLF", ['payment'] = true, ['public'] = false },
	
	-----------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------PRAIA VESPUCCI--------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	[1000] = { ['name'] = "PV01", ['payment'] = false, ['public'] = false },
	[1001] = { ['name'] = "PV02", ['payment'] = false, ['public'] = false },
	[1002] = { ['name'] = "PV03", ['payment'] = false, ['public'] = false },
	[1003] = { ['name'] = "PV04", ['payment'] = false, ['public'] = false },
	[1004] = { ['name'] = "PV05", ['payment'] = false, ['public'] = false },
	[1005] = { ['name'] = "PV06", ['payment'] = false, ['public'] = false },
	[1006] = { ['name'] = "PV07", ['payment'] = false, ['public'] = false },
	[1007] = { ['name'] = "PV08", ['payment'] = false, ['public'] = false },
	[1008] = { ['name'] = "PV09", ['payment'] = false, ['public'] = false },
	[1009] = { ['name'] = "PV10", ['payment'] = false, ['public'] = false },
	[1010] = { ['name'] = "PV11", ['payment'] = false, ['public'] = false },
	[1011] = { ['name'] = "PV12", ['payment'] = false, ['public'] = false },
	[1012] = { ['name'] = "PV13", ['payment'] = false, ['public'] = false },
	[1013] = { ['name'] = "PV14", ['payment'] = false, ['public'] = false },
	[1014] = { ['name'] = "PV15", ['payment'] = false, ['public'] = false },
	[1015] = { ['name'] = "PV16", ['payment'] = false, ['public'] = false },
	[1016] = { ['name'] = "PV17", ['payment'] = false, ['public'] = false },
	[1017] = { ['name'] = "PV18", ['payment'] = false, ['public'] = false },
	[1018] = { ['name'] = "PV19", ['payment'] = false, ['public'] = false },
	[1019] = { ['name'] = "PV20", ['payment'] = false, ['public'] = false },
	[1020] = { ['name'] = "PV21", ['payment'] = false, ['public'] = false },
	[1021] = { ['name'] = "PV22", ['payment'] = false, ['public'] = false },
	[1022] = { ['name'] = "PV23", ['payment'] = false, ['public'] = false },
	[1023] = { ['name'] = "PV24", ['payment'] = false, ['public'] = false },
	[1026] = { ['name'] = "hpmorto", ['payment'] = false, ['public'] = true },
	[1027] = { ['name'] = "inicial", ['payment'] = false, ['public'] = true },
	[1026] = { ['name'] = "bus", ['payment'] = false, ['public'] = true },
	[1028] = { ['name'] = "taxi", ['payment'] = false, ['public'] = true },
	[1029] = { ['name'] = "garagem", ['payment'] = false, ['public'] = true },
	[1030] = { ['name'] = "Bloods", ['payment'] = false, ['perm'] = "bloods.autorizzazione" },
	[1031] = { ['name'] = "hpmorto", ['payment'] = false, ['public'] = true },
	[1032] = { ['name'] = "hpmorto", ['payment'] = false, ['public'] = true },
	[1033] = { ['name'] = "hpmorto", ['payment'] = false, ['public'] = true },	
	[1035] = { ['name'] = "Siciliana", ['payment'] = false, ['public'] = true },
	[1036] = { ['name'] = "Italiana", ['payment'] = false, ['public'] = true },
	[1037] = { ['name'] = "Vagos", ['payment'] = false, ['public'] = true },
	[1038] = { ['name'] = "Ballas", ['payment'] = false, ['public'] = true },
	[1039] = { ['name'] = "Groove", ['payment'] = false, ['public'] = true },
	[1040] = { ['name'] = "hpmorto", ['payment'] = false, ['public'] = true },	
	[1041] = { ['name'] = "Crips", ['payment'] = false, ['perm'] = "crips.autorizzazione" },
	[1042] = { ['name'] = "garagem", ['payment'] = false, ['public'] = true },	
	[1043] = { ['name'] = "garagem", ['payment'] = false, ['public'] = true },	
	[1044] = { ['name'] = "garagem", ['payment'] = false, ['public'] = true },	
	[1045] = { ['name'] = "garagem", ['payment'] = false, ['public'] = true },	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
local workgarage = {
	["polizia"] = {
		"WRa45",
		"WRbmwx7",
		"WRc7pm",
		"WRcorollapm",
		"xxxxxcore",
		"xxxxxpol",
		"WRr1200pol",
	},
	["hpmorto"] = {
		"bmx",
	},
	["bus"] = {
		"bus"
	},
	["taxi"] = {
		"taxi"
	},
	["poliziaH"] = {
		'poliziaheli'
	},
	["Paramedico"] = {
		'ambulance',
		'emstalker'
	},
	["ParamedicoH"] = {
		"polmav",
		"seasparrow"
	},
	["Mecanico"] = {
		"flatbed",
		"towtruck",
		"checol17",
		"towtruck2"
	},
	["Bicicletario"] = {
		"scorcher",
		"tribike",
		"tribike2",
		"tribike3",
		"fixter",
		"cruiser",
		"bmx"
	},
	["Embarcações"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark3",
		"speeder",
		"speeder2",
		"squalo",
		"suntrap",
		"toro",
		"toro2",
		"tropic",
		"tropic2"
	},
	["Siciliana"] = {
		"akuma"
    },
	["Italiana"] = {
		"akuma"
    },
    ["Ballas"] = {
        "akuma"
    },
    ["Vagos"] = {
        "akuma"
    },
    ["Groove"] = {
        "akuma"
    },
    ["Crips"] = {
        "akuma"
    },
    ["Bloods"] = {
        "akuma"
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.myVehicles(work)
	local source = source
	local user_id = vRP.getUserId(source)
	local myvehicles = {}
	if user_id then
		if workgarage[work] then
			for k,v in pairs(workgarage) do
				if k == work then
					for k2,v2 in pairs(v) do
						table.insert(myvehicles,{ name = vRP.vehicleName(v2), spawn = v2, cartype = "serviço", image = "https://images.visionexclusive.it/veicoli/"..v2..".png"})
					end
				end
			end
			return myvehicles
		else
			local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
			local address = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if #address > 0 then
				for k,v in pairs(address) do
					if v.home == work then
						for k2,v2 in pairs(vehicle) do
							table.insert(myvehicles,{ name = vRP.vehicleName(vehicle[k2].vehicle), spawn = vehicle[k2].vehicle, body = v2.body, image = "https://images.visionexclusive.it/veicoli/"..vehicle[k2].vehicle..".png"})
						end
						return myvehicles
					else
						for k2,v2 in pairs(vehicle) do
							table.insert(myvehicles,{ name = vRP.vehicleName(vehicle[k2].vehicle), spawn = vehicle[k2].vehicle, body = v2.body, image = "https://images.visionexclusive.it/veicoli/"..vehicle[k2].vehicle..".png"})
						end
						return myvehicles
					end
				end
			else
				for k,v in pairs(vehicle) do
					table.insert(myvehicles,{ name = vRP.vehicleName(vehicle[k].vehicle), spawn = vehicle[k].vehicle, body = v.body, image = "https://images.visionexclusive.it/veicoli/"..vehicle[k].vehicle..".png"})
				end
				return myvehicles
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.spawnVehicles(name,use)
	if name then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
			local value = vRP.getUData(parseInt(user_id),"vRP:multas")
			local multas = json.decode(value) or 0
			if multas >= 10000 then
				TriggerClientEvent("Notify",source,"negato","Tieni molte multe da pagare")
				return true
			end
			if not vCLIENT.returnVehicle(source,name) then
				local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
				local tuning = vRP.getSData("custom:u"..user_id.."veh_"..name) or {}
				local custom = json.decode(tuning) or {}
				if vehicle[1] ~= nil then
					if parseInt(vehicle[1].detido) >= 1 then
						local ok = vRP.request(source,"Il veicolo è sequestrato , devi pagare per riprenderlo <b>€ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b>?",60)
						if ok then
							if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then
								vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0 })
								TriggerClientEvent("Notify",source,"successo","Veicolo sbloccato.")
							else
								TriggerClientEvent("Notify",source,"negato","Non abbastanza soldi.")
							end
						end
					else
						if parseInt(os.time()) <= parseInt(vehicle[1].ipva+24*15*60*60) then
							if garages[use].payment then
								if vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental" then
									local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,100,custom)
									vehlist[vehid] = { parseInt(user_id),name }
									TriggerEvent("setPlateEveryone",identity.registration)
									TriggerClientEvent("Notify",source,"successo","Veicolo <b>Esclusivo o Affittato</b>, Non pagherai per liberarlo.")
								end
								if (vRP.getBankMoney(user_id)+vRP.getMoney(user_id)) >= parseInt(vRP.vehiclePrice(name)*0.005 and not vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental") then
									local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,100,custom)
									if spawnveh and vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.005)) then
										vehlist[vehid] = { parseInt(user_id),name }
										TriggerEvent("setPlateEveryone",identity.registration)
										TriggerClientEvent("Notify",source,"finanziario","Hai pagato <b>$ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.005)).." </b> per prendere il veicolo.")
									end
								else
									TriggerClientEvent("Notify",source,"negato","Non abbastanza soldi.")
								end
							else
								local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,100,custom,parseInt(vehicle[1].colorR),parseInt(vehicle[1].colorG),parseInt(vehicle[1].colorB),parseInt(vehicle[1].color2R),parseInt(vehicle[1].color2G),parseInt(vehicle[1].color2B),false)
								if spawnveh then
									vehlist[vehid] = { user_id,name }
									TriggerEvent("setPlateEveryone",identity.registration)
								end
							end
						else
							if vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental" then
								local ok = vRP.request(source,"Pagare la tassa del veicolo <b>"..vRP.vehicleName(name).."</b> per <b>€ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.00)).."</b>?",60)
								if ok then
									if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.00)) then
										vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = name, ipva = parseInt(os.time()) })
										TriggerClientEvent("Notify",source,"successo","Il pagamento della <b>Tassa</b> di circolazione è stato effettuato con successo.")
									else
										TriggerClientEvent("Notify",source,"negato","Non abbastanza soldi.")
									end
								end
							else
								local price_tax = parseInt(vRP.vehiclePrice(name)*0.10)
								if price_tax > 100000 then
									price_tax = 100000
								end
								local ok = vRP.request(source,"Pagare la tassa del veicolo <b>"..vRP.vehicleName(name).."</b> per <b>€ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.00)).."</b>?",60)
								if ok then
									if vRP.tryFullPayment(user_id,price_tax) then
										vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = name, ipva = parseInt(os.time()) })
										TriggerClientEvent("Notify",source,"successo","Il pagamento della <b>Tassa</b> di circolazione è stato effettuato con successo.")
									else
										TriggerClientEvent("Notify",source,"negato","Non abbastanza soldi.")
									end
								end
							end
						end
					end
				else
					local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,1000,1000,100,custom,0,0,0,0,0,0,true)
					if spawnveh then
						vehlist[vehid] = { user_id,name }
						TriggerEvent("setPlateEveryone",identity.registration)
					end
				end
			else
				TriggerClientEvent("Notify",source,"avviso","Questo veicolo è già stato rimosso dal garage.")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.deleteVehicles2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRPclient.getNearestVehicle(source,30)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dv',function(source,args,rawCommand)

	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") then
		if not args[1] then
			local vehicle = vRPclient.getNearestVehicle(source,7)
			if vehicle then
				vCLIENT.deleteVehicle(source,vehicle)
			end
		else 
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			local vehicle = vRPclient.getNearestVehicle(nsource,7)
			if vehicle then
				vCLIENT.deleteVehicle(nsource,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addtrust', function(source, args, rawCmd)
     
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non si può fare in coma.') return end
	local placaid = identity.registration
	if args[1] then
		local nuser_id = parseInt(args[1])
		local rows = vRP.query("creative/sel_truste", {user_id = nuser_id, placa = placaid})
		if not rows[1] then
			vRP.execute("creative/add_truste", {user_id = nuser_id, placa = placaid})
			TriggerClientEvent('Notify', source, 'successo','Fiducia data al passaporto <b>' .. nuser_id .. '</b>.')
		else
			TriggerClientEvent('Notify', source, 'negato', 'Questo passaporto <b>GIÀ</b> ha la tua fiducia.')
		end
	else
		TriggerClientEvent('Notify', source, 'negato', 'È necessario specificare un passaporto.')
	end
end)

RegisterCommand('remtrust', function(source, args, rawCmd)
     
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non si può fare in coma.') return end
	local placaid = identity.registration
	if args[1] then
		local nuser_id = parseInt(args[1])
		local rows = vRP.query("creative/sel_truste", {user_id = nuser_id, placa = placaid})
		if rows[1] then
			vRP.execute("creative/rem_truste", {user_id = nuser_id, placa = placaid})
			TriggerClientEvent('Notify', source, 'successo','Il passaporto ha revocato la fiducia <b>' .. nuser_id .. '</b>.')
		else
			TriggerClientEvent('Notify', source, 'negato', 'Questo passaporto <b>NON</b> ha la tua fiducia.')
		end
	else
		TriggerClientEvent('Notify', source, 'negato', 'È necessario specificare un passaporto.')
	end
end)

RegisterCommand('trusts', function(source, args, rawCmd)
     
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non si può fare in coma.') return end
	local placaid = identity.registration
	local rows = vRP.query("creative/check_trusts", {placa = placaid})
	local acessos = ''
	for k, v in pairs(rows) do
		local nuser_id = parseInt(v.user_id)
		local nidentity = vRP.getUserIdentity(nuser_id)
		acessos = acessos .. '<br> - <b>' .. nidentity.name .. ' ' .. nidentity.firstname .. ' (' .. nuser_id .. ')</b>'
	end
	TriggerClientEvent('Notify', source, 'avviso','Acessos à placa: ' .. placaid, acessos)
end)

function src.vehicleLock()
	local source = source
	local user_id = vRP.getUserId(source)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato','Non si può fare in coma.') return end
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle and placa then
			local placa_user_id = vRP.getUserByRegistration(placa)
			local row = vRP.query("rusher/sel_truste", {user_id = user_id, placa = placa})
			if user_id == placa_user_id or row[1] or user_id == 0 then
				vCLIENT.vehicleClientLock(-1,vnetid,lock)

				if not vRPclient.isInVehicle(source) then
					vRPclient.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
				end

				if lock == 1 then
					TriggerClientEvent("Notify",source,'importante',"Veicolo <b>chiuso</b> correttamente.",8000)
				else
					TriggerClientEvent("Notify",source,'importante',"Veicolo <b>aperto</b> correttamente.",8000)
				end
				TriggerClientEvent("vrp_sound:source",source,"lock",0.5)
			end
		end
	end
end

RegisterCommand('lk', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, 'admin.autorizzazione') then
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			if vehicle and placa then
				vCLIENT.vehicleClientLock(-1,vnetid,lock)
				TriggerClientEvent("sound:source",source,'lock',0.5)
				vRPclient.playAnim(source,true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
				if lock == 1 then
					TriggerClientEvent("Notify",source,'importante',"Veicolo <b>chiuso</b> correttamente.")
				else
					TriggerClientEvent("Notify",source,'importante',"Veicolo <b>aperto</b> correttamente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.tryDelete(vehid,vehengine,vehbody)
	if vehlist[vehid] and vehid ~= 0 then
		local user_id = vehlist[vehid][1]
		local vehname = vehlist[vehid][2]
		local player = vRP.getUserSource(user_id)
		if player then
			vCLIENT.syncNameDelete(player,vehname)
		end

		if vehengine <= 100 then
			vehengine = 1000
		end

		if vehbody <= 100 then
			vehbody = 1000
		end

		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehname })
		if vehicle[1] ~= nil then
			vRP.execute("creative/set_update_vehicles",{ user_id = parseInt(user_id), vehicle = vehname, engine = parseInt(vehengine), body = parseInt(vehbody) })
		end
	end
	vCLIENT.syncVehicle(-1,vehid)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- trydeleteveh546357
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh546357")
AddEventHandler("trydeleteveh546357",function(vehid)
	vCLIENT.syncVehicle(-1,vehid)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNHOUSES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.returnHouses(nome,garage)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--if not vRP.searchReturn(source,user_id) then
			local address = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if #address > 0 then
				for k,v in pairs(address) do
					if v.home == garages[garage].name then
						if parseInt(v.garage) == 1 then
							local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(nome) })
							if resultOwner[1] then
								--if not vRP.hasGroup(user_id,"Platina") then
									if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) then
										TriggerClientEvent("Notify",source,'avviso',"La <b>TASSA</b> di soggiorno è scaduta.")
										return false
									else
										vCLIENT.openGarage(source,nome,garage)
									end
								--end
							end
						end
					end
				end
			end
			if garages[garage].perm == "livre" then
				return vCLIENT.openGarage(source,nome,garage)
			elseif garages[garage].perm then
				if vRP.hasPermission(user_id,garages[garage].perm) or user_id == 1 then -- acessar garagens dos empregos
					return vCLIENT.openGarage(source,nome,garage)
				end
			elseif garages[garage].public then
				return vCLIENT.openGarage(source,nome,garage)
			end
		--end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEALERT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.policeAlert()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
		if vehicle then
			if math.random(100) >= 50 then
				local policia = vRP.getUsersByPermission("policia.autorizzazione")
				local x,y,z = vRPclient.getPosition(source)
				for k,v in pairs(policia) do
					local player = vRP.getUserSource(parseInt(v))
					if player then
						async(function()
							local id = idgens:gen()
							TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Rapina in ^1"..street.."^0 di un veicolo ^1"..model.."^0 targa ^1"..placa.."^0 controlla cosa è successo.")
							police[id] = vRPclient.addBlip(player,x,y,z,304,3,"Ocorrência",0.6,false)
							SetTimeout(60000,function() vRPclient.removeBlip(player,police[id]) idgens:free(id) end)
						end)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local delayVehs = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vehs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] and parseInt(args[2]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[2]))
			local myvehicles = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(args[1]) })
			if myvehicles[1] then
				if vRP.vehicleType(tostring(args[1])) == "exclusive" or vRP.vehicleType(tostring(args[1])) == "noleggio" and not vRP.hasPermission(user_id,"admin.autorizzazione") then
					TriggerClientEvent("Notify",source,"negato","<b>"..vRP.vehicleName(tostring(args[1])).."</b> non può essere trasferito perché è un veicolo <b>in esclusiva o in leasing</b>.")
				else
					local identity = vRP.getUserIdentity(parseInt(args[2]))
					local identity2 = vRP.getUserIdentity(user_id)
					local price = tonumber(sanitizeString(vRP.prompt(source,"Valor:",""),"\"[]{}+=?!_()#@%/\\|,.",false))			
					if vRP.request(source,"vuoi venderne un <b>"..vRP.vehicleName(tostring(args[1])).."</b> da <b>"..identity.name.." "..identity.firstname.."</b> per <b>€ "..vRP.format(parseInt(price)).."</b> dollari ?",30) then	
						if vRP.request(nplayer,"accettare di acquistarne un <b>"..vRP.vehicleName(tostring(args[1])).."</b> da <b>"..identity2.name.." "..identity2.firstname.."</b> per <b>€ "..vRP.format(parseInt(price)).."</b> dollari ?",30) then
							local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(args[2]), vehicle = tostring(args[1]) })
							if parseInt(price) > 0 then
								if vRP.tryFullPayment(parseInt(args[2]),parseInt(price)) then
									if vehicle[1] then
										TriggerClientEvent("Notify",source,"negato", "<b>"..identity.name.." "..identity.firstname.."</b> Già possiedi questo veicolo.")
									else
										vRP.execute("creative/move_vehicle",{ user_id = parseInt(user_id), nuser_id = parseInt(args[2]), vehicle = tostring(args[1]) })

										local custom = vRP.getSData("custom:u"..parseInt(user_id).."veh_"..tostring(args[1]))
										local custom2 = json.decode(custom)
										if custom2 then
											vRP.setSData("custom:u"..parseInt(args[2]).."veh_"..tostring(args[1]),json.encode(custom2))
											vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..tostring(args[1]) })
										end

										local chest = vRP.getSData("chest:u"..parseInt(user_id).."veh_"..tostring(args[1]))
										local chest2 = json.decode(chest)
										if chest2 then
											vRP.setSData("chest:u"..parseInt(args[2]).."veh_"..tostring(args[1]),json.encode(chest2))
											vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(user_id).."veh_"..tostring(args[1]) })
										end

										TriggerClientEvent("Notify",source,"successo","Hai venduto <b>"..vRP.vehicleName(tostring(args[1])).."</b> e hai ricevuto <b>€ "..vRP.format(parseInt(price)).."</b> dollari.")
										TriggerClientEvent("Notify",nplayer,"importante","Hai ricevuto le chiavi del veicolo?o <b>"..vRP.vehicleName(tostring(args[1])).."</b> da <b>"..identity2.name.." "..identity2.firstname.."</b> e hai pagato <b>€ "..vRP.format(parseInt(price)).."</b> dollari.")
											vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
											vRPclient.playSound(nplayer,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
											local consulta = vRP.getUData(user_id,"vRP:paypal")
											local resultado = json.decode(consulta) or 0
											vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado + price)))

											exports["creative-misc"]:sendLogs(user_id,{ webhook = "logGarages", text = "[VENDUTO]: "..vRP.vehicleName(tostring(args[1])).." \n[A]: "..(args[2]).." "..identity.name.." "..identity.firstname.." \n[PER]: € "..vRP.format(parseInt(price)).." " })
										end
									else
										TriggerClientEvent("Notify",nplayer,"negato","Non hai abbastanza soldi.")
										TriggerClientEvent("Notify",source,"negato","Non hai abbastanza soldi.")
									end
								end	
							end
						end
					end
				end
			else
				local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
				if #vehicle > 0 then 
	                local car_names = {}
	                for k,v in pairs(vehicle) do
	                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b> ("..v.vehicle..")")
	                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle)
	                end
	                car_names = table.concat(car_names, ", ")
	                TriggerClientEvent("Notify",source,"importante","Tuoi veicoli: " .. car_names)
				else 
					TriggerClientEvent("Notify",source,"importante","Non possiedi nessun veicolo.")
				end
			end
		end
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id,"mod.autorizzazione") or vRP.hasPermission(user_id,"influencer.autorizzazione") or vRP.hasPermission(user_id,"streamer.autorizzazione") or vRP.hasPermission(user_id,"special.autorizzazione") then
			if args[1] then
				local tuning = vRP.getSData("custom:u"..user_id.."veh_"..args[1]) or {}
				local custom = json.decode(tuning) or {}
				vCLIENT.spawnVehicleAdmin(source,args[1],custom)
				TriggerEvent("setPlateEveryone",identity.registration)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('savelivery',function(source,args,rawCommand)
    
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.autorizzazione") then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				local custom = json.decode(vRP.getSData("custom:u"..parseInt(puser_id).."veh_"..vname))
				local livery = vCLIENT.returnlivery(source,livery)
				custom.liveries = livery
				vRP.setSData("custom:u"..parseInt(puser_id).."veh_"..vname,json.encode(custom))	
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK LIVERY PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CheckLiveryPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"admin.autorizzazione") 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
    
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.autorizzazione") then
        local vehassh = vCLIENT.getHash(source,vehiclehash)
        vRP.prompt(source,"Hash:",""..vehassh)
    end
end)


vRP.prepare('creative/start_maisgaragem_Get', 'SELECT * FROM moregarages WHERE user_id = @user_id')
vRP.prepare('creative/start_maisgaragem_Criar', 'INSERT INTO moregarages(user_id,vagas) VALUES(@user_id,@vagas)')
vRP.prepare('creative/start_maisgaragem_Add', 'UPDATE moregarages SET vagas = @vagas WHERE user_id = @user_id')

function src.deleteVehicles()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		local identity = vRP.getUserIdentity(user_id)
		vRP.kick(source, 'Sei stato bannato dal server.')
		vRP.setBanned(user_id, 1)
    end
end



RegisterServerEvent('garages:dimensao')
AddEventHandler('garages:dimensao', function()
	local source = source
    local user_id = vRP.getUserId(source)
	if 2 == 2 then
		SetPlayerRoutingBucket(source, 0)
	end
end)

local qtdDesmancheFerro2 = math.random(3,6)
local qtdDesmancheArame2 = math.random(4,10)
local qtdDesmancheParafuso2 = math.random(4,10)

RegisterServerEvent("rusher:desmancheVehs")
AddEventHandler("rusher:desmancheVehs",function(faccao)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if not vRP.hasPermission(user_id, 'admin.autorizzazione') and not vRP.hasPermission(user_id, 'warlocks.autorizzazione') and not vRP.hasPermission(user_id, 'hells.autorizzazione') then
			vRP.kick(source, 'Sei stato bannato dal server.')
			vRP.setBanned(user_id, 1)
			exports["creative-misc"]:sendLogs(user_id,{ webhook = "logDesmanchePrevent", text = "è stato bandito dal tentativo di truccare l'evento rusher:desmancheVehs"})
			return
		end

		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)

		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then

				local query = vRP.query('creative/get_vehicles', {user_id = puser_id, vehicle = vname})
				if (query[1] and query[1] ~= nil) or banned then 
					if (query[1] and query[1].detido ~= 1) or banned then
						
						
						local valor = 0
						local chancinha = math.random(8,12)
						if not banned then
							vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1 })
							valor = parseInt(vRP.vehiclePrice(vname)*(chancinha/100))
						else
							valor = math.random(112000,505000)
							local value = vRP.getUData(parseInt(puser_id),"vRP:multas")
							local multas = json.decode(value) or 0
							vRP.setUData(parseInt(puser_id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
						end
						local nsource = vRP.getUserSource(puser_id)
						if nsource then
							local carro = vRP.vehicleName(vname)
							TriggerClientEvent('Notify', nsource, 'avviso', 'ASSICURAZIONE Il tuo veicolo <b>' .. carro .. '</b> è stato trovato in uno stato di perdita totale. L\'assicurazione è scattata.')
						end
						
						vRP.giveInventoryItem(user_id,"dinheirosujo", valor)
						vRP.giveInventoryItem(user_id, 'ferro', qtdDesmancheFerro2)
						vRP.giveInventoryItem(user_id, 'arame', qtdDesmancheArame2)
						vRP.giveInventoryItem(user_id, 'parafuso', qtdDesmancheParafuso2)

						TriggerClientEvent('Notify', source, 'successo', 'Hai ricevuto ' .. qtdDesmancheFerro2 .. 'x ferro / ' .. qtdDesmancheArame2 .. 'x di fili / ' .. qtdDesmancheParafuso2 .. 'x di viti e'.. vRP.format(valor) ..' soldi sporchi')
						
						exports["creative-misc"]:sendLogs(user_id,{ webhook = "logDesmanche", text = "[SMANTELLARE]: "..vname.." [ID]: "..puser_id.." \n[VALOR]: € "..vRP.format(valor).." "})

						-- if faccao == 'warlocks' then
						-- 	exports["creative-misc"]:sendLogs(user_id,{ webhook = "logDesmanche", text = "[WARLOCKS-DESMANCHE]: "..vname.." [ID]: "..puser_id.." \n[VALOR]: € "..vRP.format(valor).." "})
						-- elseif faccao == 'hells' then
						-- 	exports["creative-misc"]:sendLogs(user_id,{ webhook = "logDesmanche", text = "[HELLS-DESMANCHE]: "..vname.." [ID]: "..puser_id.." \n[VALOR]: € "..vRP.format(valor).." "})
						-- end

					else
						TriggerClientEvent('Notify', source, 'negato', 'ERRORE DI ESECUZIONE! Questo veicolo è già rottamato.')
					end
					vCLIENT.deleteVehicle(source,vehicle)
				end
			end
		end
	end
end)