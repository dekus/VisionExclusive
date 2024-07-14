local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local cfg = module("vrp","cfg/groups")

local groups = cfg.groups

vRPN = {}
Tunnel.bindInterface("vrp_inventory",vRPN)
Proxy.addInterface("vrp_inventory",vRPN)

client = Tunnel.getInterface("vrp_inventory_client")

local webhookequipar = "https://discord.com/api/webhooks/1131628575653638248/8D3Qo9sw-pwh3P7eNj38YRGUuxCQykq4chukx5rHRGfk1dWu01QiVo1dWvEaDKe_F6yx";
local webhookenviaritem = "https://discord.com/api/webhooks/1131628680607711311/wSvpxFB-6AOOa4UgCyLRFCMAklR5ewCv-o6h4lebEOnd3H9aI0qeYz-5mqfSX2iNUaNg";
local webhookdropar = "https://discord.com/api/webhooks/1131628845087338546/VdFvVtRbbBn1hNvquQEscdIRMILYspAN30b25lY4z5-GdYXIzJzwqyy4W1KcZgD085lU";
local webhookadrenalina = "https://discord.com/api/webhooks/1131628936695132251/q3VggQ79z7qejSqvUkIN1nTvJXCRmttjbaq8KJIxGgrDyYRvCC0WRBB5Q3cKjRWvrYGv";
function SendWebhookMessage(webhook, message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers)
		end, "POST", json.encode({
			content = message
		}), {
			["Content-Type"] = "application/json"
		});
	end;
end;

local idgens = Tools.newIDGenerator()

vGARAGE = Tunnel.getInterface("vrp_garages")
vHOMES = Tunnel.getInterface("vrp_homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}

vRP.prepare("vRP/rem_user_dkey","DELETE FROM vrp_user_data WHERE dkey = @dkey AND user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local inventario = {}
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if vRP.itemBodyList(k) then
				table.insert(inventario,{ 
					amount = parseInt(v.amount),
					name = vRP.itemNameList(k),
					index = vRP.itemIndexList(k),
					key = k,
					type = vRP.itemTypeList(k),
					weight = vRP.getItemWeight(k)
				})
			end
		end
		return inventario,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id)
	end
end

function CheckRelacionamento(user_id)

	local query = vRP.query('relacionamento/GetUserRelacinamento', {user_id = user_id})

	if not query or not query[1] or query[1] == nil then
		vRP.execute('relacionamento/InsertRelacionamento', {user_id = user_id, relacionamento = 0, relacionamentoCom = -1})
		return 'Solteiro(a)'
	end

    if query[1] and query[1] ~= nil then
		local row = query[1] 
		local other = ''
        if row.relacionamento == 0 then
            return 'Solteiro(a)'
		elseif row.relacionamento == 1 then
            local nomeOutro = vRP.getUserIdentity(parseInt(row.relacionamentoCom))
			if nomeOutro then
				other = nomeOutro.name .. ' ' .. nomeOutro.firstname
			end
            other = 'Namorando com ' .. other
            return other
		elseif row.relacionamento == 2 then
			local nomeOutro = vRP.getUserIdentity(parseInt(row.relacionamentoCom))
			if nomeOutro then
				other = nomeOutro.name .. ' ' .. nomeOutro.firstname
			end
            other = 'Noivado(a) com ' .. other
            return other
		elseif row.relacionamento == 3 then
            local nomeOutro = vRP.getUserIdentity(parseInt(row.relacionamentoCom))
			if nomeOutro then
				other = nomeOutro.name .. ' ' .. nomeOutro.firstname
			end
            other = 'Casado(a) com ' .. other
            return other
        end
    end
end
function vRPN.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end


function vRPN.GetUserID(player)
	local user_id = vRP.getUserId(player)
	return user_id

end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.sendItem(id, itemName, amount)
	local source = source;
	if itemName then

		local user_id = vRP.getUserId(source);
		local nplayer = id;
		local nuser_id = vRP.getUserId(nplayer);
		local identity = vRP.getUserIdentity(user_id);
		local identitynu = vRP.getUserIdentity(nuser_id);
		local job = vRP.getUserGroupByType(user_id, "job");
		local job2 = vRP.getUserGroupByType(nuser_id, "job");

		if nuser_id and vRP.itemIndexList(itemName) and item ~= vRP.itemIndexList("identidade") then
			if parseInt(amount) > 0 then

				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount >= vRP.getInventoryMaxWeight(nuser_id) then
					TriggerClientEvent("Notify", source, "negato", "La persona non ha spazio nell'inventario.");
					return false;
				end;
					
		
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id, itemName, amount) then
						vRP.giveInventoryItem(nuser_id, itemName, amount);
						vRPclient._playAnim(source, true, {
							"mp_common",
							"givetake1_a"
						}, false);

						TriggerClientEvent("Notify", source, "successo", "Inviato <b>" .. vRP.format(amount) .. "x " .. vRP.itemNameList(itemName) .. "</b>.");
						SendWebhookMessage(webhookenviaritem, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[INVIATO]: " .. vRP.format(amount) .. " " .. vRP.itemNameList(itemName) .. " \n[PER ID]: " .. nuser_id .. " " .. identitynu.name .. " " .. identitynu.firstname .. " \n[SET INVIATO]: " .. job .. " \n[SET RICEVUTO]: " .. job2 .. "  " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
						TriggerClientEvent("Notify", nplayer, "successo", "Ricevuto <b>" .. vRP.format(amount) .. "x " .. vRP.itemNameList(itemName) .. "</b>.");
						vRPclient._playAnim(nplayer, true, {
							"mp_common",
							"givetake1_a"
						}, false);
						TriggerClientEvent('vrp_inventory:Update', source)
						TriggerClientEvent("Creative:Update", nplayer, "updateMochila");
						return true;
					end;
				end;
			else
				local data = vRP.getUserDataTable(user_id);
				for k, v in pairs(data.inventory) do
					if itemName == k then
						if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * parseInt(v.amount) <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id, itemName, parseInt(v.amount)) then
								vRP.giveInventoryItem(nuser_id, itemName, parseInt(v.amount));
								vRPclient._playAnim(source, true, {
									"mp_common",
									"givetake1_a"
								}, false);
								TriggerClientEvent("Notify", source, "successo", "Inviato <b>" .. vRP.format(parseInt(v.amount)) .. "x " .. vRP.itemNameList(itemName) .. "</b>.");
								SendWebhookMessage(webhookenviaritem, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[ENVIOU]: " .. vRP.format(parseInt(v.amount)) .. " " .. vRP.itemNameList(itemName) .. " \n[PARA O ID]: " .. nuser_id .. " " .. identitynu.name .. " " .. identitynu.firstname .. " \n[SET]: " .. job .. " \n[SET RECEBEU]: " .. job2 .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
								TriggerClientEvent("Notify", nplayer, "successo", "Ricevuto <b>" .. vRP.format(parseInt(v.amount)) .. "x " .. vRP.itemNameList(itemName) .. "</b>.");
								vRPclient._playAnim(nplayer, true, {
									"mp_common",
									"givetake1_a"
								}, false);
								TriggerClientEvent('vrp_inventory:Update', source)
								TriggerClientEvent("Creative:Update", nplayer, "updateMochila");
								return true;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
	return false;
end;
------------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local BlacklistDelete = {
	--"raceticket",
	"lsd",
	"valeacoes",
	"cocaina",
	"marijuana",
	"placa",
	"pecadearma",
	"cocamisturada",
	"complsd",
	"acidolisergico",
	"folhademaconha",
	"maconhamacerada",
	"bende",
	"zaino",
	"polvora",
	"adrenalina",
	"capsula",
	"materialarmas",
	"denarosporco",
	"folhadecoca",
	"packarmas",
	"packfaccao",
	"packdinheiro",
	"resetname",
	"vipvabasico",
	"vipva",
	"vipvaelite",
	"resetpersonagem",
	-- Armas brancas
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|GADGET_PARACHUTE",
	"wbody|WEAPON_HATCHET",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_BOTTLE",
	"wbody|WEAPON_BATTLEAXE",
	"wbody|WEAPON_POOLCUE",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_GOLFCLUB",
	"wbody|WEAPON_KNIFE",
	"wbody|WEAPON_DAGGER",
	"wbody|WEAPON_CROWBAR",
	"wbody|WEAPON_HAMMER",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_WRENCH",
	-- Armas
	"wbody|WEAPON_PISTOL_MK2",
	"wammo|WEAPON_PISTOL_MK2",
	"wbody|WEAPON_COMPACTRIFLE",
	"wammo|WEAPON_COMPACTRIFLE",
	"wbody|WEAPON_ASSAULTRIFLE_MK2",
	"wammo|WEAPON_ASSAULTRIFLE_MK2",
	"wbody|WEAPON_SPECIALCARBINE_MK2",
	"wammo|WEAPON_SPECIALCARBINE_MK2",
	"wbody|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_COMBATPDW",
	"wammo|WEAPON_COMBATPDW",
	"wbody|WEAPON_SMG",
	"wammo|WEAPON_SMG",
	"wbody|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_CARBINERIFLE_MK2",
	"wammo|WEAPON_CARBINERIFLE_MK2",
	"wbody|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_HEAVYRIFLE",
	"wammo|WEAPON_HEAVYRIFLE",
	"wbody|WEAPON_SMG_MK2",
	"wammo|WEAPON_SMG_MK2",
	"wbody|WEAPON_MACHINEPISTOL",
	"wammo|WEAPON_MACHINEPISTOL",
	"wbody|WEAPON_APPISTOL",
	"wammo|WEAPON_APPISTOL",
	"wbody|WEAPON_HEAVYRIFLE",
	"wammo|WEAPON_HEAVYRIFLE",
	"wbody|WEAPON_TACTICALRIFLE",
	"wammo|WEAPON_TACTICALRIFLE"

}

function vRPN.dropItem(itemName,itemAmount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		for k, v in pairs(BlacklistDelete) do
			if itemName == v then 
				TriggerClientEvent('Notify', source, "importante", 'Non puoi distruggere questo tipo di item.')
				return
			end
		end

		if parseInt(itemAmount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,itemAmount) then
			vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
			exports["logs"]:sendLogs(user_id,{ webhook = "LogDropar", text = " \n[DESTRUIU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(itemAmount))..""})
			TriggerClientEvent('vrp_inventory:Update', source)
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
						-- exports["logs"]:sendLogs(user_id,{ webhook = "LogDropar", text = " \n[DESTRUIU]: "..vRP.itemNameList(itemName).." \n[DESTRUIU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(v.amount)).."" })
						TriggerClientEvent('vrp_inventory:Update', source)
						return true
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- bende
-----------------------------------------------------------------------------------------------------------------------------------------
local bende = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bende) do
			if v > 0 then
				bende[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KITMEDICO
-----------------------------------------------------------------------------------------------------------------------------------------
local kitmedico = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(kitmedico) do
			if v > 0 then
				kitmedico[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local pick = {};
local blips = {};
local usando = {};
function vRPN.useItem(itemName, type, ramount)
	local source = source;
	local user_id = vRP.getUserId(source);
	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and (not actived[user_id]) and actived[user_id] == nil then
		if type == "usa" then
			if itemName == "bende" then
				client.FecharInventario(source)
				if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 399 then
					if bende[user_id] == 0 or (not bende[user_id]) then
						if vRP.tryGetInventoryItem(user_id, "bende", 1) then
							bende[user_id] = 120;
							actived[user_id] = true;
							vRPclient._CarregarObjeto(source, "amb@world_human_clipboard@male@idle_a", "idle_c", "v_ret_ta_firstaid", 49, 60309);
							TriggerClientEvent('vrp_inventory:Update', source)
							TriggerClientEvent("rusher:DesativarAtirar", source, true);
							TriggerClientEvent("cancelando", source, true);
							TriggerClientEvent("progress", source, 4000, "curando");
							
							SetTimeout(8000, function()
								actived[user_id] = nil;
								TriggerClientEvent("rusherbende", source);
								TriggerClientEvent("cancelando", source, false);
								TriggerClientEvent("rusher:DesativarAtirar", source, false);
								vRPclient._DeletarObjeto(source);
								TriggerClientEvent("Notify", source, "successo", "Bende utilizzata con successo.");
							end);
						end;
					else
						TriggerClientEvent("Notify", source, "negato", "Aguarde " .. vRPclient.getTimeFunction(source, parseInt(bende[user_id])) .. ".");
					end;
				else
					TriggerClientEvent("Notify", source, "avviso", "Non puoi utilizzare con tutta la vita o quando sei morto.");
				end;
			elseif itemName == "xerelto" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "xerelto", 1) then
					vRPclient._CarregarObjeto(source, "mp_player_intdrink", "loop_bottle", "ng_proc_drug01a002", 49, 60309);
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("rusher:DesativarAtirar", source, true);
					TriggerClientEvent("progress", source, 20500, "xerelto");
					SetTimeout(20500, function()
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("rusher:DesativarAtirar", source, false);
						TriggerClientEvent("resetBleeding", source);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "xerelto utilizzato con successo.");
					end);
				end;
			elseif itemName == "coumadin" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "coumadin", 1) then
					vRPclient._CarregarObjeto(source, "mp_player_intdrink", "loop_bottle", "ng_proc_drug01a002", 49, 60309);
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("rusher:DesativarAtirar", source, true);
					TriggerClientEvent("progress", source, 20500, "coumadin");
					SetTimeout(20500, function()
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("rusher:DesativarAtirar", source, false);
						TriggerClientEvent("resetBleeding", source);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Coumadin utilizzato con successo.");
					end);
				end;
			elseif itemName == "keycard" then
				client.FecharInventario(source)
				local percentage = math.random(100000, 300000)
				if vRP.tryGetInventoryItem(user_id, "keycard", 1) then
					TriggerClientEvent('vrp_inventory:Update', source)
					vRPclient.playSound(source, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET");
					TriggerClientEvent("Notify", source, "successo", "Hai clonato una carta e ricevuto "..vRP.format(percentage).." soldi sporchi!");
					vRP.giveInventoryItem(user_id, 'denarosporco', percentage)
				end;
			elseif itemName == "shield" then
				if vRP.tryGetInventoryItem(user_id, "shield", 1) then
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					SetTimeout(1, function()
						SetEntityInvincible(ped, true);
						TriggerClientEvent("shield", source);
					end);
				end;
				if vRP.tryGetInventoryItem(user_id, "colete", 1) then
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					SetTimeout(1, function()
						TriggerClientEvent("colete", source);
					end);
				end;
			elseif itemName == "corda" then
				client.FecharInventario(source)
				local nsource = vRPclient.getNearestPlayer(source, 2);
				if nsource then
					if not vRPclient.isHandcuffed(source) and vRPclient.isHandcuffed(nsource) then
						if vRP.tryGetInventoryItem(user_id, "corda", 1) then
							TriggerClientEvent("carregar", nsource, source);
							SetTimeout(20000, function()
								TriggerClientEvent("carregar", nsource, source);
							end);
						end;
					end;
				end;
			elseif itemName == "kittid" then
				client.FecharInventario(source)
				local nplayer = vRPclient.getNearestPlayer(source, 3);
				if nplayer then
					if vRP.getInventoryItemAmount(user_id, "kittid") > 0 then
						client.FecharInventario(source);
						Wait(200);
						TriggerClientEvent("rusher:AbrirKitAnalise", source);
					end;
				else
					TriggerClientEvent("Notify", source, "negato", "Non c'è nessuno in giro da analizzare.");
				end;
			elseif itemName == "cellulare" then
				TriggerEvent("rusher:GcPhone:ToggleAviao", user_id);
			elseif itemName == "dorflex" or itemName == "cicatricure" or itemName == "dipiroca" or itemName == "nocucedin" or itemName == "paracetanal" or itemName == "decupramim" or itemName == "buscopau" or itemName == "navagina" or itemName == "analdor" or itemName == "sefodex" or itemName == "nokusin" or itemName == "glicoanal" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "dorflex", 1) or vRP.tryGetInventoryItem(user_id, "cicatricure", 1) or vRP.tryGetInventoryItem(user_id, "dipiroca", 1) or vRP.tryGetInventoryItem(user_id, "nocucedin", 1) or vRP.tryGetInventoryItem(user_id, "paracetanal", 1) or vRP.tryGetInventoryItem(user_id, "decupramim", 1) or vRP.tryGetInventoryItem(user_id, "buscopau", 1) or vRP.tryGetInventoryItem(user_id, "navagina", 1) or vRP.tryGetInventoryItem(user_id, "analdor", 1) or vRP.tryGetInventoryItem(user_id, "sefodex", 1) or vRP.tryGetInventoryItem(user_id, "nokusin", 1) or vRP.tryGetInventoryItem(user_id, "glicoanal", 1) then
					TriggerClientEvent('vrp_inventory:Update', source)
					vRPclient._playAnim(source, true, {
						{
							"mp_player_intdrink",
							"loop_bottle"
						}
					}, true);
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("rusher:DesativarAtirar", source, true);
					TriggerClientEvent("progress", source, 5000, "remedio");
					SetTimeout(5000, function()
						vRPclient._stopAnim(source, false);
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("rusher:DesativarAtirar", source, false);
						TriggerClientEvent("Notify", source, "successo", "Medicina usata con successo.");
					end);
				end;
			elseif itemName == "zaino" then
				if vRP.tryGetInventoryItem(user_id, "zaino", 1) then
					TriggerClientEvent('vrp_inventory:Update', source)
					vRP.varyExp(user_id, "physical", "strength", 650);
					TriggerClientEvent("Notify", source, "successo", "Zaino usata con successo.");
				end;
			elseif itemName == "cerveja" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "cerveja", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_amb_beer_bottle", 49, 28422);
					TriggerClientEvent("progress", source, 30000, "bebendo");
					SetTimeout(30000, function()
						actived[user_id] = nil;
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("cancelando", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Birra usata con successo.");
					end);
				end;
			elseif itemName == "tequila" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "tequila", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_amb_beer_bottle", 49, 28422);
					TriggerClientEvent("progress", source, 30000, "bebendo");
					SetTimeout(30000, function()
						actived[user_id] = nil;
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("cancelando", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Tequila usata con successo.");
					end);
				end;
			elseif itemName == "vodka" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "vodka", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_amb_beer_bottle", 49, 28422);
					TriggerClientEvent("progress", source, 30000, "bebendo");
					SetTimeout(30000, function()
						actived[user_id] = nil;
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("cancelando", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Vodka usato con successo.");
					end);
				end;
			elseif itemName == "whisky" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "whisky", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "p_whiskey_notop", 49, 28422);
					TriggerClientEvent("progress", source, 30000, "bebendo");
					SetTimeout(30000, function()
						actived[user_id] = nil;
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("cancelando", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Whisky usato con successo.");
					end);
				end;
			elseif itemName == "conhaque" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "conhaque", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_amb_beer_bottle", 49, 28422);
					TriggerClientEvent("progress", source, 30000, "bebendo");
					SetTimeout(30000, function()
						actived[user_id] = nil;
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("cancelando", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Cognac usato con successo.");
					end);
				end;
			elseif itemName == "absinto" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "absinto", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_amb_beer_bottle", 49, 28422);
					TriggerClientEvent("progress", source, 30000, "Bevendo");
					SetTimeout(30000, function()
						actived[user_id] = nil;
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("cancelando", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Assenzio usato con successo.");
					end);
				end;
			elseif itemName == "baseado" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "baseado", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					vRPclient._playAnim(source, true, {
						task = "WORLD_HUMAN_DRUG_DEALER"
					}, true);
					TriggerClientEvent("progress", source, 10000, "Utilizzando");
					SetTimeout(10000, function()
						actived[user_id] = nil;
						vRPclient._stopAnim(source, false);
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("Notify", source, "successo", "Canna usato con successo.");
					end);
				end;
			elseif itemName == "k9" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "k9", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					vRPclient._playAnim(source, true, { "mp_player_int_uppersmoke", "mp_player_int_smoke" }, true);
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("rusher:DesativarAtirar", source, true);
					TriggerClientEvent("progress", source, 10000, "Utilizzando");
					SetTimeout(10000, function()
						actived[user_id] = nil;
						vRPclient._stopAnim(source, false);
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("rusher:DesativarAtirar", source, false);
						vRPclient.playScreenEffect(source, "RaceTurbo", 120);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 120);
						vRPclient._playAnim(source, true, { "amb@world_human_statue@base", "base" }, true);
						TriggerClientEvent("Notify", source, "successo", "K9 utilizzata con successo.");
					end);
					SetTimeout(120000, function()
						TriggerClientEvent("energeticos", source, false);
						TriggerClientEvent("Notify", source, "avviso", "L'effetto del K9 svanì e il cuore riprese a battere normalmente..");
					end);
				end;
			elseif itemName == "krokodil" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "krokodil", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					vRPclient._playAnim(source, true, {
						"mp_player_int_uppersmoke",
						"mp_player_int_smoke"
					}, true);
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("rusher:DesativarAtirar", source, true);
					TriggerClientEvent("progress", source, 10000, "dando un teak");
					SetTimeout(10000, function()
						actived[user_id] = nil;
						vRPclient._stopAnim(source, false);
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("rusher:DesativarAtirar", source, false);
						vRPclient.playScreenEffect(source, "RaceTurbo", 120);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 120);
						TriggerClientEvent("Notify", source, "successo", "Krokodil usato con successo.");
						SetTimeout(5000, function()
							vRPclient._setHealth(source, 101);
						end);
					end);
				end;
			elseif itemName == "lancaperfume" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "lancaperfume", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					vRPclient.CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "j_lancaperf", 49, 28422);
					TriggerClientEvent("progress", source, 10000, "baforando");
					SetTimeout(10000, function()
						actived[user_id] = nil;
						vRPclient._stopAnim(source, false);
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("Notify", source, "successo", "Lanci di profumi usati con successo.");
					end);
				end;
			elseif itemName == "lsd" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "lsd", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					vRPclient._playAnim(source, true, {
						"mp_player_int_uppersmoke",
						"mp_player_int_smoke"
					}, true);
					TriggerClientEvent("progress", source, 10000, "dropando");
					SetTimeout(10000, function()
						actived[user_id] = nil;
						vRPclient._stopAnim(source, false);
						vRPclient.playScreenEffect(source, "RaceTurbo", 180);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 180);
						TriggerClientEvent("Notify", source, "successo", "LSD usato con successo.");
					end);
				end;
			elseif itemName == "rebite" then
				client.FecharInventario(source)
				if vRP.tryGetInventoryItem(user_id, "rebite", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("rusher:DesativarAtirar", source, true);
					vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_energy_drink", 49, 28422);
					TriggerClientEvent("progress", source, 10000, "bebendo");
					SetTimeout(10000, function()
						actived[user_id] = nil;
						vRPclient.playScreenEffect(source, "RaceTurbo", 90);
						vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 90);
						TriggerClientEvent("energeticos", source);
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("rusher:DesativarAtirar", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Rivetto utilizzato con successo.");
					end);
				end;
			elseif itemName == "capuz" then
				client.FecharInventario(source)
				if vRP.getInventoryItemAmount(user_id, "capuz") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source, 2);
					if nplayer then
						vRPclient.setCapuz(nplayer);
						vRP.closeMenu(nplayer);
						TriggerClientEvent("Notify", source, "successo", "Cappuccino utilizzato con successo.");
					end;
				end;
			elseif itemName == "energetico" then
				client.FecharInventario(source)
				if usando[user_id] then
					TriggerClientEvent("Notify", source, "negato", "Stai già eseguendo un'azione!");
					return;
				end;
				usando[user_id] = true;
				if vRP.tryGetInventoryItem(user_id, "energetico", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					vRPclient._CarregarObjeto(source, "mp_player_intdrink", "loop_bottle", "prop_energy_drink", 49, 60309, 0, 0, 0, 0, 0, 0);
					TriggerClientEvent("progress", source, 4000, "bebendo");
					SetTimeout(4000, function()
						vRPclient._DeletarObjeto(source);
						actived[user_id] = nil;
						TriggerClientEvent("energeticos", source);
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("Notify", source, "successo", "Energetico usato con successo.");
					end)
					usando[user_id] = false;
				end;
			elseif itemName == "chocolate" then
				client.FecharInventario(source)
				if usando[user_id] then
					TriggerClientEvent("Notify", source, "negato", "Stai già eseguendo un'azione!");
					return;
				end;
				usando[user_id] = true;
				if vRP.tryGetInventoryItem(user_id, "chocolate", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("progress", source, 3000, "comendo");
					SetTimeout(3000, function()
						actived[user_id] = nil;
						TriggerClientEvent("energeticos", source);
						TriggerClientEvent("cancelando", source, false);
						TriggerClientEvent("Notify", source, "successo", "Hai mangiato il cioccolato.");
					end);
					usando[user_id] = false;
				end;
			elseif itemName == "melzinho" then
				client.FecharInventario(source)
				if usando[user_id] then
					TriggerClientEvent("Notify", source, "negato", "Stai già eseguendo un'azione!");
					return;
				end;
				usando[user_id] = true;
				if vRP.tryGetInventoryItem(user_id, "melzinho", 1) then
					actived[user_id] = true;
					TriggerClientEvent('vrp_inventory:Update', source)
					TriggerClientEvent("cancelando", source, true);
					TriggerClientEvent("progress", source, 6000, "usando");
					SetTimeout(7000, function()
						actived[user_id] = nil;
						TriggerClientEvent("melzinho", source);
						TriggerClientEvent("rusherbende", source);
						TriggerClientEvent("cancelando", source, false);
						vRPclient._DeletarObjeto(source);
						TriggerClientEvent("Notify", source, "successo", "Melzinho usato con successo.");
					end);
					usando[user_id] = false;
				end;
			elseif itemName == "lockpick" then
				client.FecharInventario(source)
				local vehicle, vnetid, placa, vname, lock, banned, trunk, model, street = vRPclient.vehList(source, 7);
				if vRP.vehicleType(vname) == "exclusive" then
					TriggerClientEvent("Notify", source, "negato", "Il lockpick comune non funziona su veicoli esclusivi!");
					return;
				end;
				if vRP.vehicleType(vname) == "import" then
					TriggerClientEvent("Notify", source, "negato", "Il lockpick ordinario non funziona sui veicoli importati!");
					return;
				end;
				if vRP.getInventoryItemAmount(user_id, "lockpick") >= 1 and vRP.tryGetInventoryItem(user_id, "lockpick", 1) and vehicle then
					actived[user_id] = true;
					TriggerClientEvent("cancelando", source, true);
					vRPclient._playAnim(source, false, {
						"amb@prop_human_parking_meter@female@idle_a",
						"idle_a_female"
					}, true);
					TriggerClientEvent("progress", source, "rubando");
					SetTimeout(8000, function()
						actived[user_id] = nil;
						TriggerClientEvent("cancelando", source, false);
						if not vRPclient.FazendoAnim(source, "amb@prop_human_parking_meter@female@idle_a", "idle_a_female") then
							return;
						end;
						vRPclient._stopAnim(source, false);
						local iddoroubado = vRP.getUserByRegistration(placa);
						local nuser_id = vRP.getUserSource(iddoroubado);
						if iddoroubado then
							TriggerClientEvent("Notify", nuser_id, "avviso", "Il Veicolo <b>" .. vRP.vehicleName(vname) .. "</b> è stato rubato.", 7000);
						end;
						if math.random(100) >= 60 then
							TriggerEvent("setPlateEveryone", placa);
							vGARAGE.vehicleClientLock(-1, vnetid, lock);
							TriggerClientEvent("vrp_sound:source", source, "lock", 0);
						else
							TriggerClientEvent("Notify", source, "negato", "Il furto del veicolo è fallito e sono state chiamate le autorità.");
							local polizia = vRP.getUsersByPermission("polizia.autorizzazione");
							local x, y, z = vRPclient.getPosition(source);
							for k, v in pairs(polizia) do
								local player = vRP.getUserSource(parseInt(v));
								if player then
									async(function()
										local id = idgens:gen();
										TriggerClientEvent("NotifyPush", player, {
											code = 31,
											title = "Roubo de Veículo",
											x = x,
											y = y,
											z = z,
											badge = model .. " - " .. placa
										});
										pick[id] = vRPclient.addBlip(player, x, y, z, 10, 5, "Ocorrência", 0, false);
										SetTimeout(20000, function()
											vRPclient.removeBlip(player, pick[id]);
											idgens:free(id);
										end);
									end);
								end;
							end;
						end;
					end);
				end;
			elseif itemName == "masterpick" then
				client.FecharInventario(source)
				local vehicle, vnetid, placa, vname, lock, banned, trunk, model, street = vRPclient.vehList(source, 7);
				if vRP.getInventoryItemAmount(user_id, "masterpick") >= 1 and vehicle then
					actived[user_id] = true;
					TriggerClientEvent("cancelando", source, true);
					vRPclient._playAnim(source, false, {
						"amb@prop_human_parking_meter@female@idle_a",
						"idle_a_female"
					}, true);
					TriggerClientEvent("progress", source, 12000);
					SetTimeout(12000, function()
						actived[user_id] = nil;
						TriggerClientEvent("cancelando", source, false);
						if not vRPclient.FazendoAnim(source, "amb@prop_human_parking_meter@female@idle_a", "idle_a_female") then
							return;
						end;
						vRPclient._stopAnim(source, false);
						if parseInt(math.random(1000)) >= 950 then
							vRP.tryGetInventoryItem(user_id, itemName, 1);
						end;
						local iddoroubado = vRP.getUserByRegistration(placa);
						local nuser_id = vRP.getUserSource(iddoroubado);
						if iddoroubado then
							TriggerClientEvent("Notify", nuser_id, "avviso", "Il Veicolo <b>" .. vRP.vehicleName(vname) .. "</b> è stato rubato.", 7000);
						end;
						if math.random(100) >= 20 then
							TriggerEvent("setPlateEveryone", placa);
							vGARAGE.vehicleClientLock(-1, vnetid, lock);
							TriggerClientEvent("vrp_sound:source", source, "lock", 0);
						else
							TriggerClientEvent("Notify", source, "negato", "Il furto del veicolo è fallito e sono state chiamate le autorità.");
							local polizia = vRP.getUsersByPermission("polizia.autorizzazione");
							local x, y, z = vRPclient.getPosition(source);
							for k, v in pairs(polizia) do
								local player = vRP.getUserSource(parseInt(v));
								if player then
									async(function()
										local id = idgens:gen();
										TriggerClientEvent("NotifyPush", player, {
											code = 31,
											title = "Roubo de Veículo",
											x = x,
											y = y,
											z = z,
											badge = model .. " - " .. placa
										});
										pick[id] = vRPclient.addBlip(player, x, y, z, 10, 5, "Evento", 0, false);
										SetTimeout(20000, function()
											vRPclient.removeBlip(player, pick[id]);
											idgens:free(id);
										end);
									end);
								end;
							end;
						end;
					end);
				end;
			elseif itemName == "militec" then
				client.FecharInventario(source)
				local mecanicos = vRP.getUsersByPermission("mecanico.autorizzazione");
				if #mecanicos > 1 and (not vRP.hasPermission(user_id, "mecanico.autorizzazione")) then
					TriggerClientEvent("Notify", source, "negato", "Ci sono dei meccanici in città, chiamane uno!");
					return;
				end;
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source, 3);
					if vehicle then
						if vRP.hasPermission(user_id, "mecanico.autorizzazione") then
							actived[user_id] = true;
							TriggerClientEvent("cancelando", source, true);
							vRPclient._playAnim(source, false, {
								{
									"mini@repair",
									"fixing_a_player"
								}
							}, true);
							TriggerClientEvent("progress", source, 7000, "Riparando motore");
							SetTimeout(7000, function()
								actived[user_id] = nil;
								TriggerClientEvent("cancelando", source, false);
								TriggerClientEvent("repararmotor", source, vehicle);
								vRPclient._stopAnim(source, false);
							end);
						elseif vRP.tryGetInventoryItem(user_id, "militec", 1) then
							actived[user_id] = true;
							TriggerClientEvent('vrp_inventory:Update', source)
							TriggerClientEvent("cancelando", source, true);
							vRPclient._playAnim(source, false, {
								{
									"mini@repair",
									"fixing_a_player"
								}
							}, true);
							TriggerClientEvent("progress", source, 7000, "Riparando motore");
							SetTimeout(7000, function()
								actived[user_id] = nil;
								TriggerClientEvent("cancelando", source, false);
								TriggerClientEvent("repararmotor", source, vehicle);
								vRPclient._stopAnim(source, false);
							end);
						end;
					end;
				else
					TriggerClientEvent("Notify", source, "negato", "Devi essere fuori dal veicolo per utilizzarlo.");
				end;
			elseif itemName == "repairkit" then
				client.FecharInventario(source)
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source, 3);
					if vehicle then
						if vRP.hasPermission(user_id, "mecanico.autorizzazione") then
							actived[user_id] = true;
							TriggerClientEvent("cancelando", source, true);
							vRPclient._playAnim(source, false, {
								"mini@repair",
								"fixing_a_player"
							}, true);
							TriggerClientEvent("progress", source, 9000, "Veicolo in riparazione");
							SetTimeout(9000, function()
								actived[user_id] = nil;
								TriggerClientEvent("cancelando", source, false);
								if vRPclient.FazendoAnim(source, "mini@repair", "fixing_a_player") then
									TriggerClientEvent("reparar", source);
								else
									TriggerClientEvent("Notify", source, "negato", "Non stavi riparando il veicolo, quindi il tuo kit era inutile.");
								end;
								vRPclient._stopAnim(source, false);
							end);
						elseif vRP.tryGetInventoryItem(user_id, "repairkit", 1) then
							actived[user_id] = true;
							TriggerClientEvent('vrp_inventory:Update', source)
							TriggerClientEvent("cancelando", source, true);
							vRPclient._playAnim(source, false, {
								"mini@repair",
								"fixing_a_player"
							}, true);
							TriggerClientEvent("progress", source, 9000, "Veicolo in riparazione");
							SetTimeout(9000, function()
								actived[user_id] = nil;
								TriggerClientEvent("cancelando", source, false);
								if vRPclient.FazendoAnim(source, "mini@repair", "fixing_a_player") then
									TriggerClientEvent("reparar", source);
								else
									TriggerClientEvent("Notify", source, "negato", "Non stavi riparando il veicolo, quindi il tuo kit era inutile.");
								end;
								vRPclient._stopAnim(source, false);
							end);
						end;
					end;
				end;
			elseif itemName == "pneumatici" then
				client.FecharInventario(source)
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source, 3);
					if vehicle then
						if vRP.hasPermission(user_id, "mecanico.autorizzazione") then
							actived[user_id] = true;
							TriggerClientEvent("cancelando", source, true);
							vRPclient._playAnim(source, false, {
								"anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								"machinic_loop_mechandplayer"
							}, true);
							TriggerClientEvent("progress", source, 9000, "Mettendo le gomme");
							SetTimeout(9000, function()
								actived[user_id] = nil;
								TriggerClientEvent("cancelando", source, false);
								TriggerClientEvent("repararpneus", source, vehicle);
								vRPclient._stopAnim(source, false);
							end);
						elseif vRP.tryGetInventoryItem(user_id, "pneumatici", 1) then
							actived[user_id] = true;
							TriggerClientEvent('vrp_inventory:Update', source)
							TriggerClientEvent("cancelando", source, true);
							vRPclient._playAnim(source, false, {
								"anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								"machinic_loop_mechandplayer"
							}, true);
							TriggerClientEvent("progress", source, 9000, "Mettendo le gomme");
							SetTimeout(9000, function()
								actived[user_id] = nil;
								TriggerClientEvent("cancelando", source, false);
								TriggerClientEvent("repararpneus", source, vehicle);
								vRPclient._stopAnim(source, false);
							end);
						end;
					end;
				end;
			elseif itemName == "notebook" then
				client.FecharInventario(source)
				if vRPclient.isInVehicle(source) then
					local vehicle, vnetid, placa, vname, lock, banned = vRPclient.vehList(source, 7);
					if vehicle and placa then
						actived[user_id] = true;
						vGARAGE.freezeVehicleNotebook(source, vehicle);
						TriggerClientEvent("cancelando", source, true);
						TriggerClientEvent("progress", source, 59500, "Rimozione del localizzatore");
						SetTimeout(60000, function()
							actived[user_id] = nil;
							TriggerClientEvent("cancelando", source, false);
							local placa_user_id = vRP.getUserByRegistration(placa);
							if placa_user_id then
								local player = vRP.getUserSource(placa_user_id);
								if player then
									vGARAGE.removeGpsVehicle(player, vname);
								end;
							end;
						end);
					end;
				end;
			elseif itemName == "secador" then
				client.FecharInventario(source)
				local dinheiromolhado = vRP.getInventoryItemAmount(user_id, "dinheiromolhado");
				if dinheiromolhado > 0 then
					if usando[user_id] then
						TriggerClientEvent("Notify", source, "negato", "Stai già eseguendo un'azione!");
						return;
					end;
					usando[user_id] = true;
					if vRP.tryGetInventoryItem(user_id, "secador", 1) then
						if dinheiromolhado >= 5000 then
							if vRP.tryGetInventoryItem(user_id, "dinheiromolhado", 5000) then
								TriggerClientEvent("progress", source, 15000, "secando dinheiro");
								TriggerClientEvent('vrp_inventory:Update', source)
								SetTimeout(15000, function()
									TriggerClientEvent("Notify", source, "successo", "Soldi secchi di successo.");
									vRP.giveMoney(user_id, 5000);
								end);
							end;
						elseif vRP.tryGetInventoryItem(user_id, "dinheiromolhado", dinheiromolhado) then
							TriggerClientEvent("progress", source, 15000, "secando dinheiro");
							TriggerClientEvent('vrp_inventory:Update', source)
							SetTimeout(15000, function()
								TriggerClientEvent("Notify", source, "successo", "Soldi secchi di successo.");
								vRP.giveMoney(user_id, dinheiromolhado);
							end);
						end;
						usando[user_id] = false;
					end;
				end;
			elseif itemName == "ticketazione" then
				TriggerClientEvent("Notify", source, "avviso", "Questo ticket può essere scambiato nel blip sul tuo GPS")
				client.FecharInventario(source)
			elseif itemName == "adrenalina" then
				client.FecharInventario(source)
				local nplayer = vRPclient.getNearestPlayer(source, 2);
				local vida = vRPclient.getHealth(nplayer);
				local user_id = vRP.getUserId(source);
				local identity = vRP.getUserIdentity(user_id);
				local identity2 = vRP.getUserIdentity(nplayer);
				local x, y, z = vRPclient.getPosition(source);
				if nplayer then
					if vRPclient.isInComa(nplayer) then
						if vRP.tryGetInventoryItem(user_id, "adrenalina", 1) then
							TriggerClientEvent('vrp_inventory:Update', source)
							TriggerClientEvent("cancelando", source, true);
							vRPclient._playAnim(source, false, {
								"amb@medic@standing@tendtodead@base",
								"base"
							}, {
								"mini@cpr@char_a@cpr_str",
								"cpr_pumpchest"
							}, true);
							TriggerClientEvent("chatMessage", nplayer, "SISTEMA", {
								255,
								0,
								0
							}, "Stai prendendo una scarica di adrenalina erogata da " .. identity.name .. " " .. identity.firstname .. ", presto sarai rianimato.");
							TriggerClientEvent("progress", source, "Curando");
							TriggerClientEvent("progress", nplayer, "Curando");
							SetTimeout(8000, function()
								vRPclient.killGod(nplayer);
								vRPclient._stopAnim(source, false);
								TriggerClientEvent("cancelando", source, false);
								SendWebhookMessage(webhookadrenalina, "O **ID** ``#" .. nplayer .. " " .. identity2.name .. " " .. identity2.firstname .. "`` è stato rianimato da **ID** ``#" .. user_id .. " " .. identity.name .. " " .. identity.firstname .. "``.");
							end);
						end;
					else
						TriggerClientEvent("Notify", source, "negato", "Puoi farlo solo su qualcuno che è morto..");
						return false;
					end;
				else
					TriggerClientEvent("Notify", source, "negato", "Non ci sono giocatori nelle vicinanze.");
					return;
				end;
			elseif itemName == "gasosavazia" then
				client.FecharInventario(source)
				local carro = client.PegarCarro(source, 5);
				if carro and carro ~= 0 then
					local gasolina = client.GetGasosaDoCarro(source, carro);
					if gasolina > 30 then
						if vRP.tryGetInventoryItem(user_id, "gasosavazia", 1) then
							TriggerClientEvent("rusher:RoubarGasolina", source, carro, gasolina);
						end;
					else
						TriggerClientEvent("Notify", source, "negato", "Questa macchina è senza <b>benzina</b>.");
					end;
				end;
			elseif itemName == "gasosacheia" then
				client.FecharInventario(source)
				local carro = client.PegarCarro(source, 5);
				if carro and carro ~= 0 then
					local gasolina = client.GetGasosaDoCarro(source, carro);
					local adicionar = 30;
					if gasolina > 70 then
						adicionar = 100 - gasolina;
					end;
					if vRP.tryGetInventoryItem(user_id, "gasosacheia", 1) then
						TriggerClientEvent("rusher:AbastecerCarro", source, carro, gasolina + adicionar);
					end;
				end;
			end;
		elseif type == "equipaggiare" then
			if vRP.tryGetInventoryItem(user_id, itemName, 1) then
				local weapons = {};
				local identity = vRP.getUserIdentity(user_id);
				weapons[string.gsub(itemName, "wbody|", "")] = {
					ammo = 0
				};
				vRPclient._giveWeapons(source, weapons);
				SendWebhookMessage(webhookequipar, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[ATTREZZATO]: " .. vRP.itemNameList(itemName) .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
				TriggerClientEvent('vrp_inventory:Update', source)
			end;
		elseif type == "ricaricare" then
			local uweapons = vRPclient.getWeapons(source);
			local weaponuse = string.gsub(itemName, "wammo|", "");
			local weaponusename = "wammo|" .. weaponuse;
			local identity = vRP.getUserIdentity(user_id);
			if uweapons[weaponuse] then
				local itemAmount = 0;
				local data = vRP.getUserDataTable(user_id);
				for k, v in pairs(data.inventory) do
					if weaponusename == k then
						if v.amount > 250 then
							v.amount = 250;
						end;
						itemAmount = v.amount;
						if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
							local weapons = {};
							weapons[weaponuse] = {
								ammo = v.amount
							};
							itemAmount = v.amount;
							vRPclient._giveWeapons(source, weapons, false);
							SendWebhookMessage(webhookequipar, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[RICARICATO]: " .. vRP.itemNameList(itemName) .. " \n[MUNICAO]: " .. parseInt(v.amount) .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
							TriggerClientEvent('vrp_inventory:Update', source)
						end;
					end;
				end;
			end;
		end;
	end;
end;
RegisterCommand("bende", function(source, args, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRPclient.getHealth(source) > 101 then
		if bende[user_id] == 0 or (not bende[user_id]) then
			if vRP.tryGetInventoryItem(user_id, "bende", 1) then
				bende[user_id] = 180;
				actived[user_id] = true;
				vRPclient._CarregarObjeto(source, "amb@world_human_clipboard@male@idle_a", "idle_c", "v_ret_ta_firstaid", 49, 60309);
				TriggerClientEvent("cancelando", source, true);
				TriggerClientEvent("rusher:DesativarAtirar", source, true);
				TriggerClientEvent("progress", source, 5000, "curando");
				SetTimeout(5000, function()
					actived[user_id] = nil;
					TriggerClientEvent("rusherbende", source);
					TriggerClientEvent("cancelando", source, false);
					TriggerClientEvent("rusher:DesativarAtirar", source, false);
					vRPclient._DeletarObjeto(source);
					TriggerClientEvent("Notify", source, "successo", "Benda utilizzata con successo.");
				end);
			else
				TriggerClientEvent("Notify", source, "negato", "Non hai una benda nello zaino.");
			end;
		else
			TriggerClientEvent("Notify", source, "negato", "Aspetta " .. vRPclient.getTimeFunction(source, parseInt(bende[user_id])) .. ".");
		end;
	else
		TriggerClientEvent("Notify", source, "avviso", "Non puoi usare con la vita piena o da morto.");
	end;
end);
RegisterCommand("energetico", function(source, args, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.tryGetInventoryItem(user_id, "energetico", 1) then
		if usando[user_id] then
			TriggerClientEvent("Notify", source, "negato", "Stai già eseguendo un'azione!");
			return;
		end;
		usando[user_id] = true;
		actived[user_id] = true;
		TriggerClientEvent("cancelando", source, true);
		TriggerClientEvent("progress", source, 4000, "bebendo");
		SetTimeout(4000, function()
			actived[user_id] = nil;
			TriggerClientEvent("energeticos", source);
			TriggerClientEvent("cancelando", source, false);
			vRPclient._DeletarObjeto(source);
			TriggerClientEvent("Notify", source, "successo", "Energetico utilizzato con successo.");
			usando[user_id] = false;
		end);
	end;
end);
RegisterCommand("melzinho", function(source, args, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.tryGetInventoryItem(user_id, "melzinho", 1) then
		if usando[user_id] then
			TriggerClientEvent("Notify", source, "negato", "Stai già eseguendo un'azione!");
			return;
		end;
		usando[user_id] = true;
		actived[user_id] = true;
		TriggerClientEvent("cancelando", source, true);
		TriggerClientEvent("progress", source, 5000, "tomando");
		SetTimeout(5000, function()
			actived[user_id] = nil;
			TriggerClientEvent("melzinho", source);
			TriggerClientEvent("cancelando", source, false);
			vRPclient._DeletarObjeto(source);
			TriggerClientEvent("Notify", source, "successo", "Melzinho utilizzato con successo.");
			usando[user_id] = false;
		end);
	end;
end);
RegisterCommand("chocolate", function(source, args, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.tryGetInventoryItem(user_id, "chocolate", 1) then
		if usando[user_id] then
			TriggerClientEvent("Notify", source, "negato", "Stai già eseguendo un'azione!");
			return;
		end;
		usando[user_id] = true;
		actived[user_id] = true;
		TriggerClientEvent("cancelando", source, true);
		TriggerClientEvent("progress", source, 5000, "comendo");
		SetTimeout(5000, function()
			actived[user_id] = nil;
			TriggerClientEvent("chocolate", source);
			TriggerClientEvent("cancelando", source, false);
			vRPclient._DeletarObjeto(source);
			TriggerClientEvent("Notify", source, "successo", "Cioccolato utilizzato con successo.");
			usando[user_id] = false;
		end);
	end;
end);
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)
