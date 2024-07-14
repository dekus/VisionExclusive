local cfg = module("cfg/inventory")

local itemlist = {
	["bombacaseira"] = { index = "bombacaseira", nome = "Bomba fatta in casa", type = "usa" },
	["gasosavazia"] = { index = "gasosavazia", nome = "Bombola di gas vuota", type = "usa" },
	["gasosacheia"] = { index = "gasosacheia", nome = "Pieno di benzina", type = "usa" },
	["pecadecarro"] = { index = "pecadecarro", nome = "Parte auto", type = "usa" },
	["aliancaouro"] = { index = "aliancaouro", nome = "Anello d'oro", type = "usa" },
	["shield"] = { index = "shield", nome = "Shield", type = "usa" },
	["colete"] = { index = "colete", nome = "Colete", type = "usa" },
	["aliancaprata"] = { index = "aliancaprata", nome = "Fede nuziale in argento", type = "usa" },
	["compeletronico"] = { index = "compeletronico", nome = "Comp. elettronico", type = "usa" },
	["latadetinta"] = { index = "latadetinta", nome = "Barattolo di vernice", type = "usa" },
	["lata"] = { index = "lata", nome = "Lata", type = "usa" },
	["r1"] = { index = "r1", nome = "Yamaha R1", type = "usa" },
	["cordas"] = { index = "cordas", nome = "Corda", type = "usa" },
	["ferramenta"] = { index = "ferramenta", nome = "Attrezzo", type = "usa" },
	["encomenda"] = { index = "encomenda", nome = "Ordine", type = "usa" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Busta della spazzatura", type = "usa" },
	["cellulare"] = { index = "cellulare", nome = "Cellulare", type = "usa" },
	["pneumatici"] = { index = "pneumatici", nome = "Pneumatici", type = "usa" },
	["alianca"] = { index = "alianca", nome = "Alleanza", type = "usa" },
	["bende"] = { index = "bende", nome = "Bende", type = "usa" },
	["adrenalina"] = { index = "adrenalina", nome = "Adrenalina", type = "usa" },
	["melzinho"] = { index = "melzinho", nome = "Melzinho", type = "usa" },
	["denarosporco"] = { index = "denarosporco", nome = "Denaro Sporco", type = "usa" },
	["repairkit"] = { index = "repairkit", nome = "Kit Riparazione", type = "usa" },
	["funcionalpol"] = { index = "funcionalpol", nome = "Distintivo", type = "usa" },
	["arance"] = { index = "arance", nome = "Arance", type = "usa" },
	["placa"] = { index = "placa", nome = "Scheda", type = "usa" },
	["algemas"] = { index = "algemas", nome = "Manette", type = "usa" },
	["capuz"] = { index = "capuz", nome = "Capuccino", type = "usa" },
	["kitarma"] = { index = "kitarma", nome = "Kit arma", type = "usa" },
	["lockpick"] = { index = "lockpick", nome = "Grimaldello", type = "usa" },
	["identidade"] = { index = "identidade", nome = "Identità", type = "usa" },
	["masterpick"] = { index = "masterpick", nome = "Capolavoro", type = "usa" },
	["militec"] = { index = "militec", nome = "Militec 1", type = "usa" },
	["vestiti"] = { index = "vestiti", nome = "Vestiti", type = "usa" },

	["material9mm"] = { index = "material9mm", nome = "Materiale di 9MM", type = "usa" },
	["material762"] = { index = "material762", nome = "Materiale di 7.62", type = "usa" },

	["capsula9mm"] = { index = "capsula9mm", nome = "Capsula di 9MM", type = "usa" },
	["capsula762"] = { index = "capsula762", nome = "Capsula di 7.62", type = "usa" },

	["polvora9mm"] = { index = "polvora9mm", nome = "Polvere da sparo di 9MM", type = "usa" },
	["polvora762"] = { index = "polvora762", nome = "Polvere da sparo di 7.62", type = "usa" },

	["pecadearma"] = { index = "pecadearma", nome = "Pezzo Arma", type = "usa" },
	["pecadetec"] = { index = "pecadetec", nome = "Pezzo di Tec-9", type = "usa" },
	["pecademp5"] = { index = "pecademp5", nome = "Pezzo di MP5", type = "usa" },
	["pecadescar"] = { index = "pecadescar", nome = "Pezzo di Scar", type = "usa" },
	["pecadeg3"] = { index = "pecadeg3", nome = "Pezzo di G3", type = "usa" },
	
	["armacaodearma"] = { index = "armacaodearma", nome = "Componente Pistola", type = "usa" },
	["armacaodemp5"] = { index = "armacaodemp5", nome = "Componente MP5", type = "usa" },
	["armacaodeg3"] = { index = "armacaodeg3", nome = "Componente G36", type = "usa" },
	["armacaodescar"] = { index = "armacaodescar", nome = "Componente Scar", type = "usa" },
	["armacaodeglockrj"] = { index = "armacaodeglockr", nome = "Componente Glock 18.", type = "user" },

	["materialarmas"] = { index = "materialarmas", nome = "Materiale per armi", type = "usa" },
	["materialtec"] = { index = "materialtec", nome = "Materiale di TEC-9", type = "usa" },
	["materialmp5"] = { index = "materialmp5", nome = "Materiale di MP5", type = "usa" },
	["materialg3"] = { index = "materialg3", nome = "Materiale di G36", type = "usa" },
	["materialak"] = { index = "materialak", nome = "Materiale di AK", type = "usa" },
	["baseado"] = { index = "baseado", nome = "Canna", type = "usa" },
	["energetico"] = { index = "energetico", nome = "Energetico", type = "usa" },
	["chocolate"] = { index = "chocolate", nome = "Cioccolato", type = "usa" },
	["zaino"] = { index = "zaino", nome = "Zaino", type = "usa" },
	["candeggina"] = { index = "candeggina", nome = "Candeggina", type = "usa" },
	["candegginamodificata"] = { index = "candegginamodificata", nome = "Candeggina modificata", type = "usa" },
	["folhademaconha"] = { index = "folhademaconha", nome = "Foglia di marijuana", type = "usa" },
	["maconhamacerada"] = { index = "maconhamacerada", nome = "Marijuana macerata", type = "usa" },
	["capsula"] = { index = "capsula", nome = "Capsula", type = "usa" },
	["polvora"] = { index = "polvora", nome = "Polvere da sparo", type = "usa" },
	["pendrive"] = { index = "pendrive", nome = "Pendrive", type = "usa" },
	["notebook"] = { index = "notebook", nome = "Notebook", type = "usa" },

	["folhadecoca"] = { index = "folhadecoca", nome = "Foglia di coca", type = "usa" },
	["canabinol"] = { index = "canabinol", nome = "Cannabinolo", type = "usa" },
	["k9"] = { index = "k9", nome = "K9", type = "usa" },
	["essenciadeecstasy"] = { index = "essenciadeecstasy", nome = "Essenzia di Ecstasy", type = "usa" },
	["pastadeecstasy"] = { index = "pastadeecstasy", nome = "Pasta di Ecstasy", type = "usa" },
	["ecstasy"] = { index = "ecstasy", nome = "Ecstasy", type = "usa" },

	["bateria"] = { index = "bateria", nome = "Batteria", type = "usa" },
	["gps"] = { index = "gps", nome = "GPS", type = "usa" },
	["ticketazione"] = { index = "ticketazione", nome = "Ticket Azione", type = "usa" },

  ["dietilamina"] = { index = "dietilamina", nome = "Dietilammina", type = "usa" },
  ["lancaperfume"] = { index = "lancaperfume", nome = "Lanciatore di profumo", type = "usa" },
	["canabidinol"] = { index = "canabidinol", nome = "Cannabidinolo", type = "usa" },
	["iodo"] = { index = "iodo", nome = "Iodio", type = "usa" },
	["codeina"] = { index = "codeina", nome = "Codeina", type = "usa" },
	["krokodil"] = { index = "krokodil", nome = "Krokodil", type = "usa" },
	["logsinvasao"] = { index = "logsinvasao", nome = "logsinvasion", type = "usa" },
	["keysinvasao"] = { index = "keysinvasao", nome = "keysinvasion", type = "usa" },
	["pendriveinformacoes"] = { index = "pendriveinformacoes", nome = "P. Info.", type = "usa" },
	["acessodeepweb"] = { index = "acessodeepweb", nome = "P. DeepWeb", type = "usa" },
	["radio"] = { index = "radio", nome = "Radio", type = "usa" },
	["c4"] = { index = "c4", nome = "C4", type = "usa" },
	["keycard"] = { index = "keycard", nome = "Carta clonata", type = "usa" },
	["aneldecompromisso"] = { index = "aneldecompromisso", nome = "Anello di impegno", type = "usa" },
	-----------------------------------------------------------
	-- ARMAS
	-----------------------------------------------------------
	["wbody|WEAPON_DAGGER"] = { index = "pugnale", nome = "Pugnale", type = "equipaggiare" },
	["wbody|WEAPON_APPISTOL"] = { index = "appistol", nome = "Glock 18", type = "equipaggiare" },
	["wbody|WEAPON_BAT"] = { index = "stecca", nome = "Stecca", type = "equipaggiare" },
	["wbody|WEAPON_BOTTLE"] = { index = "bottiglia", nome = "Bottiglia", type = "equipaggiare" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Piede di Porco", type = "equipaggiare" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "torcia", nome = "Torcia Elettrica", type = "equipaggiare" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Stecca di Golf", type = "equipaggiare" },
	["wbody|WEAPON_HAMMER"] = { index = "martello", nome = "MartelLo", type = "equipaggiare" },
	["wbody|WEAPON_HATCHET"] = { index = "ascia", nome = "Ascia", type = "equipaggiare" },
	["wbody|WEAPON_KNUCKLE"] = { index = "tirapugni", nome = "Tirapugni", type = "equipaggiare" },
	["wbody|WEAPON_KNIFE"] = { index = "fare", nome = "Fare", type = "equipaggiare" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete", type = "equipaggiare" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "coltello", nome = "Coltello", type = "equipaggiare" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete", type = "equipaggiare" },
	["wbody|WEAPON_WRENCH"] = { index = "giratubi", nome = "Chiave Giratubi", type = "equipaggiare" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "battaglia", nome = "Ascia di Battaglia", type = "equipaggiare" },
	["wbody|WEAPON_POOLCUE"] = { index = "biliardo", nome = "Stecca di Biliardo", type = "equipaggiare" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pietra", nome = "Ascia di Pietra", type = "equipaggiare" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911", type = "equipaggiare" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "Pistola MK2", type = "equipaggiare" },
	["wbody|WEAPON_SPECIALCARBINE_MK2"] = { index = "g36mk2", nome = "G36", type = "equipaggiare" },
	["wbody|WEAPON_HEAVYRIFLE"] = { index = "scar", nome = "Scar", type = "equipaggiare" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sig", nome = "Sig Sauer", type = "equipaggiare" },
	["wbody|WEAPON_HEAVYPISTOL"] = { index = "desert", nome = "Deagle", type = "equipaggiare" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock", type = "equipaggiare" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser", type = "equipaggiare" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10", type = "equipaggiare" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922", type = "equipaggiare" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44", type = "equipaggiare" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum357", nome = "Magnum 357", type = "equipaggiare" },
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22", type = "equipaggiare" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador", type = "equipaggiare" },
	["wbody|GADGET_PARACHUTE"] = { index = "GADGET_PARACHUTE", nome = "Paracadute", type = "equipaggiare" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor", type = "equipaggiare" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi", type = "equipaggiare" },
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5", type = "equipaggiare" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21", type = "equipaggiare" },
	["wbody|WEAPON_SMG_MK2"] = { index = "mp5mk2", nome = "MP5 MK2", type = "equipaggiare" },
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = { index = "remington", nome = "Shotgun Sawnoff", type = "equipaggiare" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "m4a1", nome = "M4A1", type = "equipaggiare" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak103", nome = "AK-103 MK2", type = "equipaggiare" },
	["wbody|WEAPON_PUMPSHOTGUN"] = { index = "pumpp", nome = "Shotgun", type = "equipaggiare" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Benzina", type = "equipaggiare" },	
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson", type = "equipaggiare" },		
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9", type = "equipaggiare" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS", type = "equipaggiare" }, 
	["wbody|WEAPON_BULLPUPRIFLE_MK2"] = { index = "bullpurifle", nome = "FAMAS", type = "equipaggiare" },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "mpx", nome = "MPX", type = "equipaggiare" },

	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M.M1911", type = "ricaricare" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-five", nome = "M.FN Pistola MK2", type = "ricaricare" },
	["wammo|WEAPON_SPECIALCARBINE_MK2"] = { index = "m-g36mk2", nome = "M.G36", type = "ricaricare" },
	["wammo|WEAPON_HEAVYRIFLE"] = { index = "m-scar", nome = "M.Scar", type = "ricaricare" },
	["wammo|WEAPON_HEAVYPISTOL"] = { index = "m-desert", nome = "M.Deagle", type = "ricaricare" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock", type = "ricaricare" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser", type = "ricaricare" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "M.HK P7M10", type = "ricaricare" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "M.M1922", type = "ricaricare" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sig", nome = "M.Sig Sauer PM", type = "ricaricare" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-magnum44", nome = "M.Magnum 44", type = "ricaricare" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "M.Magnum 357", type = "ricaricare" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22", type = "ricaricare" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "Pistola lanciarazzi", type = "ricaricare" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Estintore", type = "ricaricare" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.Uzi", type = "ricaricare" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "M.MP5", type = "ricaricare" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "M.MTAR-21", type = "ricaricare" },
	["wammo|WEAPON_SMG_MK2"] = { index = "m-mp5mk2", nome = "M.MP5 MK2", type = "ricaricare" },
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-shotgun", nome = "M.Shotgun PM", type = "ricaricare" },
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = { index = "m-remington", nome = "M.Shotgun Sawnoff", type = "ricaricare" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-m4a1", nome = "M.M4A1", type = "ricaricare" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak103", nome = "M.AK-103 MK2", type = "ricaricare" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "M.Thompson", type = "ricaricare" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "M.Tec-9", type = "ricaricare" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS", type = "ricaricare" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-mpx", nome = "M.MPX", type = "ricaricare" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-appistol", nome = "M.GLOCK-18", type = "ricaricare" },
	["wammo|WEAPON_BULLPUPRIFLE_MK2"] = { index = "m-bullprifle", nome = "M.BULLPUP-RIFLE MK2", type = "ricaricare" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Carburante", type = "ricaricare" }
}

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

vRP.items = {}
function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

function vRP.tryGetInventoryItem(user_id,idname,amount)
	local source = vRP.getUserSource(user_id)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
			local entry = data.inventory[idname]
			if entry and entry.amount >= amount then
					entry.amount = entry.amount - amount

					if entry.amount <= 0 then
							data.inventory[idname] = nil
					end
					for k,v in pairs(itemlist) do
							if idname == k then
									TriggerClientEvent("itensNotify",source,"rimosso",vRP.format(amount),vRP.itemNameList(idname), v.index)
							end
					end
					return true
			end
	end
	return false
end

function vRP.giveInventoryItem(user_id,idname,amount)
	local source = vRP.getUserSource(user_id)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
			local entry = data.inventory[idname]
			if entry then
					entry.amount = entry.amount + amount
			else
					data.inventory[idname] = { amount = amount }
			end
			for k,v in pairs(itemlist) do
					if idname == k then
							TriggerClientEvent("itensNotify",source,"ricevuto",vRP.format(amount),vRP.itemNameList(idname), v.index)
					end
			end
	end
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.setMoney(user_id,0)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)

        if not vRP.hasPermission(user_id,"mochila.autorizzazione") then
            vRP.setExp(user_id,"physical","strength",20)
        end
    end
end)


function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.inventory = {}
    end
end

RegisterServerEvent('rusher:Aeroporto:Server')
AddEventHandler('rusher:Aeroporto:Server', function()
	
	-- ZERA O INVENTARIO DO CARA
	local source = source
    local user_id = vRP.getUserId(source)

	::reiniciarinventario::

	--[[local data = vRP.getUserDataTable(user_id)
	if data and not vRP.hasPermission(user_id, 'polizia.autorizzazione') and not vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') then
		data.inventory = {};
	end
	
	vRP.setMoney(user_id,0)

	if not vRP.hasPermission(user_id, 'polizia.autorizzazione') and not vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') then
		vRPclient._clearWeapons(source)
	end
	vRPclient._setHandcuffed(source,false)
	
	if not vRP.hasPermission(user_id,"mochila.autorizzazione") and not vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') then
		vRP.setExp(user_id,"physical","strength",20)
	end--]]
	
	-- ENVIA O LOG PRO DISCORD
	local x,y,z = vRPclient.getPosition(source)
	TriggerEvent('rusher:LoggarAeroporto', source, x,y,z)

	-- RESPAWNA
	local pulica = false
	if vRP.hasPermission(user_id, 'polizia.autorizzazione') or vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') or vRP.hasGroup(user_id, 'paisanapolizia') then
		pulica = true
	end

	local crips = false
	local bloods = false
	local siciliana = false
	local yardie = false
	local groove = false
	local vagos = false
	local ballas = false

	if vRP.hasPermission(user_id, 'crips.autorizzazione') then
		crips = true
	elseif vRP.hasPermission(user_id, 'bloods.autorizzazione') then
		bloods = true
	elseif vRP.hasPermission(user_id, 'siciliana.autorizzazione') then
		siciliana = true
	elseif vRP.hasPermission(user_id, 'yardie.autorizzazione') then
		yardie = true
	elseif vRP.hasPermission(user_id, 'vagos.autorizzazione') then
		vagos = true
	elseif vRP.hasPermission(user_id, 'grove.autorizzazione') then
		groove = true
	elseif vRP.hasPermission(user_id,"ballas.autorizzazione") then
		ballas = true
	elseif vRP.hasPermission(user_id,"bahamas.autorizzazione") then
		bahamas = true
	elseif vRP.hasPermission(user_id,"life.autorizzazione") then
		life = true
	end


	local data2 = vRP.getUserDataTable(user_id)
	if #data2 > 0 then
		data2.inventory = {}
		print( "L'ID " .. user_id .. " È MORTO E L'INVENTARIO AVEVA ANCORA QUALCOSA, AZZERANDO DI NUOVO.")
		print(1)
		goto reiniciarinventario
	end
	
	vRPclient.AeroportoClient(source,pulica,ballas,groove,vagos,yardie,siciliana,bloods,crips,bahamas,life)
end)


RegisterServerEvent('rusher:Aeroporto:Server2')
AddEventHandler('rusher:Aeroporto:Server2', function()
	
	-- ZERA O INVENTARIO DO CARA
	local source = source
    local user_id = vRP.getUserId(source)

	::reiniciarinventario::

	local data = vRP.getUserDataTable(user_id)
	if data and not vRP.hasPermission(user_id, 'polizia.autorizzazione') and not vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') then
		data.inventory = {};
	end
	
	vRP.setMoney(user_id,0)
	if not vRP.hasPermission(user_id, 'polizia.autorizzazione') and not vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') then
		vRPclient._clearWeapons(source)
	end
	vRPclient._setHandcuffed(source,false)
	
	if not vRP.hasPermission(user_id,"mochila.autorizzazione") and not vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') then
		vRP.setExp(user_id,"physical","strength",20)
	end
	
	-- ENVIA O LOG PRO DISCORD
	local x,y,z = vRPclient.getPosition(source)
	TriggerEvent('rusher:LoggarAeroporto', source, x,y,z)


	local data2 = vRP.getUserDataTable(user_id)
	if #data2 > 0 then
		data2.inventory = {}
		print( "L'ID " .. user_id .. " È MORTO E L'INVENTARIO AVEVA ANCORA QUALCOSA, AZZERANDO DI NUOVO.")
		goto reiniciarinventario
	end
	
	vRPclient.AeroportoClient2(source)
end)

function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.inventory = {}
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERJOIN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehglobal = {
	["blista"] = { ['name'] = "Blista", ['price'] = 60000, ['tipo'] = "automobili" },
	["brioso"] = { ['name'] = "Brioso", ['price'] = 35000, ['tipo'] = "automobili" },
	["emperor"] = { ['name'] = "Emperor", ['price'] = 50000, ['tipo'] = "automobili" },
	["emperor2"] = { ['name'] = "Emperor 2", ['price'] = 50000, ['tipo'] = "automobili" },
	["dilettante"] = { ['name'] = "Dilettante", ['price'] = 60000, ['tipo'] = "automobili" },
	["issi2"] = { ['name'] = "Issi2", ['price'] = 90000, ['tipo'] = "automobili" },
	["panto"] = { ['name'] = "Panto", ['price'] = 25000, ['tipo'] = "automobili" },
	["prairie"] = { ['name'] = "Prairie", ['price'] = 10000, ['tipo'] = "automobili" },
	["rhapsody"] = { ['name'] = "Rhapsody", ['price'] = 70000, ['tipo'] = "automobili" },
	["cogcabrio"] = { ['name'] = "Cogcabrio", ['price'] = 130000, ['tipo'] = "automobili" },
	["exemplar"] = { ['name'] = "Exemplar", ['price'] = 80000, ['tipo'] = "automobili" },
	["f620"] = { ['name'] = "F620", ['price'] = 55000, ['tipo'] = "automobili" },
	["felon"] = { ['name'] = "Felon", ['price'] = 70000, ['tipo'] = "automobili" },
	["ingot"] = { ['name'] = "Ingot", ['price'] = 160000, ['tipo'] = "automobili" },
	["oracle"] = { ['name'] = "Oracle", ['price'] = 60000, ['tipo'] = "automobili" },
	["oracle2"] = { ['name'] = "Oracle2", ['price'] = 80000, ['tipo'] = "automobili" },
	["sentinel"] = { ['name'] = "Sentinel", ['price'] = 50000, ['tipo'] = "automobili" },
	["sentinel2"] = { ['name'] = "Sentinel2", ['price'] = 60000, ['tipo'] = "automobili" },
	["windsor"] = { ['name'] = "Windsor", ['price'] = 150000, ['tipo'] = "automobili" },
	["windsor2"] = { ['name'] = "Windsor2", ['price'] = 170000, ['tipo'] = "automobili" },
	["zion"] = { ['name'] = "Zion", ['price'] = 50000, ['tipo'] = "automobili" },
	["zion2"] = { ['name'] = "Zion2", ['price'] = 60000, ['tipo'] = "automobili" },
	["blade"] = { ['name'] = "Blade", ['price'] = 110000, ['tipo'] = "automobili" },
	["buccaneer"] = { ['name'] = "Buccaneer", ['price'] = 130000, ['tipo'] = "automobili" },
	["buccaneer2"] = { ['name'] = "Buccaneer2", ['price'] = 260000, ['tipo'] = "automobili" },
	["primo"] = { ['name'] = "Primo", ['price'] = 130000, ['tipo'] = "automobili" },
	["chino"] = { ['name'] = "Chino", ['price'] = 130000, ['tipo'] = "automobili" },
	["coquette3"] = { ['name'] = "Coquette3", ['price'] = 195000, ['tipo'] = "automobili" },
	["dukes"] = { ['name'] = "Dukes", ['price'] = 150000, ['tipo'] = "automobili" },
	["faction"] = { ['name'] = "Faction", ['price'] = 150000, ['tipo'] = "automobili" },
	["faction3"] = { ['name'] = "Faction3", ['price'] = 350000, ['tipo'] = "automobili" },
	["gauntlet"] = { ['name'] = "Gauntlet", ['price'] = 165000, ['tipo'] = "automobili" },
	["gauntlet2"] = { ['name'] = "Gauntlet2", ['price'] = 165000, ['tipo'] = "automobili" },
	["hermes"] = { ['name'] = "Hermes", ['price'] = 280000, ['tipo'] = "automobili" },
	["hotknife"] = { ['name'] = "Hotknife", ['price'] = 180000, ['tipo'] = "automobili" },
	["moonbeam"] = { ['name'] = "Moonbeam", ['price'] = 220000, ['tipo'] = "automobili" },
	["moonbeam2"] = { ['name'] = "Moonbeam2", ['price'] = 250000, ['tipo'] = "automobili" },
	["nightshade"] = { ['name'] = "Nightshade", ['price'] = 270000, ['tipo'] = "automobili" },
	["picador"] = { ['name'] = "Picador", ['price'] = 150000, ['tipo'] = "automobili" },
	["ruiner"] = { ['name'] = "Ruiner", ['price'] = 150000, ['tipo'] = "automobili" },
	["sabregt"] = { ['name'] = "Sabregt", ['price'] = 260000, ['tipo'] = "automobili" },
	["sabregt2"] = { ['name'] = "Sabregt2", ['price'] = 250000, ['tipo'] = "automobili" },
	["slamvan"] = { ['name'] = "Slamvan", ['price'] = 180000, ['tipo'] = "automobili" },
	["slamvan3"] = { ['name'] = "Slamvan3", ['price'] = 230000, ['tipo'] = "automobili" },
	["stalion"] = { ['name'] = "Stalion", ['price'] = 150000, ['tipo'] = "automobili" },
	["stalion2"] = { ['name'] = "Stalion2", ['price'] = 150000, ['tipo'] = "automobili" },
	["tampa"] = { ['name'] = "Tampa", ['price'] = 170000, ['tipo'] = "automobili" },
	["vigero"] = { ['name'] = "Vigero", ['price'] = 170000, ['tipo'] = "automobili" },
	["virgo"] = { ['name'] = "Virgo", ['price'] = 150000, ['tipo'] = "automobili" },
	["virgo2"] = { ['name'] = "Virgo2", ['price'] = 250000, ['tipo'] = "automobili" },
	["virgo3"] = { ['name'] = "Virgo3", ['price'] = 180000, ['tipo'] = "automobili" },
	["voodoo"] = { ['name'] = "Voodoo", ['price'] = 220000, ['tipo'] = "automobili" },
	["voodoo2"] = { ['name'] = "Voodoo2", ['price'] = 220000, ['tipo'] = "automobili" },
	["yosemite"] = { ['name'] = "Yosemite", ['price'] = 350000, ['tipo'] = "automobili" },
	["bfinjection"] = { ['name'] = "Bfinjection", ['price'] = 80000, ['tipo'] = "automobili" },
	["bifta"] = { ['name'] = "Bifta", ['price'] = 210000, ['tipo'] = "automobili" },
	["bodhi2"] = { ['name'] = "Bodhi2", ['price'] = 170000, ['tipo'] = "automobili" },
	["brawler"] = { ['name'] = "Brawler", ['price'] = 250000, ['tipo'] = "automobili" },
	["trophytruck"] = { ['name'] = "Trophytruck", ['price'] = 400000, ['tipo'] = "automobili" },
	["trophytruck2"] = { ['name'] = "Trophytruck2", ['price'] = 400000, ['tipo'] = "automobili" },
	["dubsta3"] = { ['name'] = "Dubsta3", ['price'] = 300000, ['tipo'] = "automobili" },
	["mesa3"] = { ['name'] = "Mesa3", ['price'] = 300000, ['tipo'] = "automobili" },
	["rancherxl"] = { ['name'] = "Rancherxl", ['price'] = 220000, ['tipo'] = "automobili" },
	["rebel2"] = { ['name'] = "Rebel2", ['price'] = 250000, ['tipo'] = "automobili" },
	["riata"] = { ['name'] = "Riata", ['price'] = 250000, ['tipo'] = "automobili" },
	["dloader"] = { ['name'] = "Dloader", ['price'] = 150000, ['tipo'] = "automobili" },
	["sandking"] = { ['name'] = "Sandking", ['price'] = 400000, ['tipo'] = "automobili" },
	["sandking2"] = { ['name'] = "Sandking2", ['price'] = 370000, ['tipo'] = "automobili" },
	["baller"] = { ['name'] = "Baller", ['price'] = 400000, ['tipo'] = "automobili" },
	["baller2"] = { ['name'] = "Baller2", ['price'] = 420000, ['tipo'] = "automobili" },
	["baller3"] = { ['name'] = "Baller3", ['price'] = 430000, ['tipo'] = "automobili" },
	["baller4"] = { ['name'] = "Baller4", ['price'] = 440000, ['tipo'] = "automobili" },
	["baller5"] = { ['name'] = "Baller5", ['price'] = 450000, ['tipo'] = "automobili" },
	["baller6"] = { ['name'] = "Baller6", ['price'] = 460000, ['tipo'] = "automobili" },
	["bjxl"] = { ['name'] = "Bjxl", ['price'] = 110000, ['tipo'] = "automobili" },
	["cavalcade"] = { ['name'] = "Cavalcade", ['price'] = 110000, ['tipo'] = "automobili" },
	["cavalcade2"] = { ['name'] = "Cavalcade2", ['price'] = 130000, ['tipo'] = "automobili" },
	["contender"] = { ['name'] = "Contender", ['price'] = 300000, ['tipo'] = "automobili" },
	["dubsta"] = { ['name'] = "Dubsta", ['price'] = 210000, ['tipo'] = "automobili" },
	["dubsta2"] = { ['name'] = "Dubsta2", ['price'] = 240000, ['tipo'] = "automobili" },
	["fq2"] = { ['name'] = "Fq2", ['price'] = 110000, ['tipo'] = "automobili" },
	["granger"] = { ['name'] = "Granger", ['price'] = 445000, ['tipo'] = "automobili" },
	["gresley"] = { ['name'] = "Gresley", ['price'] = 150000, ['tipo'] = "automobili" },
	["habanero"] = { ['name'] = "Habanero", ['price'] = 110000, ['tipo'] = "automobili" },
	["seminole"] = { ['name'] = "Seminole", ['price'] = 110000, ['tipo'] = "automobili" },
	["serrano"] = { ['name'] = "Serrano", ['price'] = 150000, ['tipo'] = "automobili" },
	["xls"] = { ['name'] = "Xls", ['price'] = 450000, ['tipo'] = "automobili" },
	["xls2"] = { ['name'] = "Xls2", ['price'] = 450000, ['tipo'] = "automobili" },
	["asea"] = { ['name'] = "Asea", ['price'] = 55000, ['tipo'] = "automobili" },
	["asterope"] = { ['name'] = "Asterope", ['price'] = 65000, ['tipo'] = "automobili" },
	["cog552"] = { ['name'] = "Cog552", ['price'] = 400000, ['tipo'] = "automobili" },
	["cognoscenti"] = { ['name'] = "Cognoscenti", ['price'] = 280000, ['tipo'] = "automobili" },
	["cognoscenti2"] = { ['name'] = "Cognoscenti2", ['price'] = 400000, ['tipo'] = "automobili" },
	["stanier"] = { ['name'] = "Stanier", ['price'] = 60000, ['tipo'] = "automobili" },
	["stratum"] = { ['name'] = "Stratum", ['price'] = 90000, ['tipo'] = "automobili" },
	["surge"] = { ['name'] = "Surge", ['price'] = 210000, ['tipo'] = "automobili" },
	["tailgater"] = { ['name'] = "Tailgater", ['price'] = 110000, ['tipo'] = "automobili" },
	["warrener"] = { ['name'] = "Warrener", ['price'] = 90000, ['tipo'] = "automobili" },
	["washington"] = { ['name'] = "Washington", ['price'] = 130000, ['tipo'] = "automobili" },
	["alpha"] = { ['name'] = "Alpha", ['price'] = 330000, ['tipo'] = "automobili" },
	["banshee"] = { ['name'] = "Banshee", ['price'] = 300000, ['tipo'] = "automobili" },
	["bestiagts"] = { ['name'] = "Bestiagts", ['price'] = 400000, ['tipo'] = "automobili" },
	["blista2"] = { ['name'] = "Blista2", ['price'] = 55000, ['tipo'] = "automobili" },
	["blista3"] = { ['name'] = "Blista3", ['price'] = 80000, ['tipo'] = "automobili" },
	["buffalo"] = { ['name'] = "Buffalo", ['price'] = 300000, ['tipo'] = "automobili" },
	["buffalo2"] = { ['name'] = "Buffalo2", ['price'] = 300000, ['tipo'] = "automobili" },
	["buffalo3"] = { ['name'] = "Buffalo3", ['price'] = 300000, ['tipo'] = "automobili" },
	["carbonizzare"] = { ['name'] = "Carbonizzare", ['price'] = 490000, ['tipo'] = "automobili" },
	["comet2"] = { ['name'] = "Comet2", ['price'] = 350000, ['tipo'] = "automobili" },
	["comet3"] = { ['name'] = "Comet3", ['price'] = 390000, ['tipo'] = "automobili" },
	["comet5"] = { ['name'] = "Comet5", ['price'] = 400000, ['tipo'] = "automobili" },
	["coquette"] = { ['name'] = "Coquette", ['price'] = 450000, ['tipo'] = "automobili" },
	["elegy"] = { ['name'] = "Elegy", ['price'] = 550000, ['tipo'] = "automobili" },
	["elegy2"] = { ['name'] = "Elegy2", ['price'] = 655000, ['tipo'] = "automobili" },
	["feltzer2"] = { ['name'] = "Feltzer2", ['price'] = 255000, ['tipo'] = "automobili" },
	["furoregt"] = { ['name'] = "Furoregt", ['price'] = 290000, ['tipo'] = "automobili" },
	["fusilade"] = { ['name'] = "Fusilade", ['price'] = 210000, ['tipo'] = "automobili" },
	["futo"] = { ['name'] = "Futo", ['price'] = 200000, ['tipo'] = "automobili" },
	["jester"] = { ['name'] = "Jester", ['price'] = 600000, ['tipo'] = "automobili" },
	["khamelion"] = { ['name'] = "Khamelion", ['price'] = 210000, ['tipo'] = "automobili" },
	["kuruma"] = { ['name'] = "Kuruma", ['price'] = 330000, ['tipo'] = "automobili" },
	["massacro"] = { ['name'] = "Massacro", ['price'] = 330000, ['tipo'] = "automobili" },
	["massacro2"] = { ['name'] = "Massacro2", ['price'] = 330000, ['tipo'] = "automobili" },
	["ninef"] = { ['name'] = "Ninef", ['price'] = 290000, ['tipo'] = "automobili" },
	["ninef2"] = { ['name'] = "Ninef2", ['price'] = 290000, ['tipo'] = "automobili" },
	["omnis"] = { ['name'] = "Omnis", ['price'] = 240000, ['tipo'] = "automobili" },
	["pariah"] = { ['name'] = "Pariah", ['price'] = 500000, ['tipo'] = "automobili" },
	["penumbra"] = { ['name'] = "Penumbra", ['price'] = 150000, ['tipo'] = "automobili" },
	["raiden"] = { ['name'] = "Raiden", ['price'] = 240000, ['tipo'] = "automobili" },
	["rapidgt"] = { ['name'] = "Rapidgt", ['price'] = 450000, ['tipo'] = "automobili" },
	["rapidgt2"] = { ['name'] = "Rapidgt2", ['price'] = 300000, ['tipo'] = "automobili" },
	["ruston"] = { ['name'] = "Ruston", ['price'] = 370000, ['tipo'] = "automobili" },
	["schafter3"] = { ['name'] = "Schafter3", ['price'] = 275000, ['tipo'] = "automobili" },
	["schafter4"] = { ['name'] = "Schafter4", ['price'] = 275000, ['tipo'] = "automobili" },
	["schafter5"] = { ['name'] = "Schafter5", ['price'] = 275000, ['tipo'] = "automobili" },
	["schwarzer"] = { ['name'] = "Schwarzer", ['price'] = 170000, ['tipo'] = "automobili" },
	["sentinel3"] = { ['name'] = "Sentinel3", ['price'] = 170000, ['tipo'] = "automobili" },
	["seven70"] = { ['name'] = "Seven70", ['price'] = 770000, ['tipo'] = "automobili" },
	["specter"] = { ['name'] = "Specter", ['price'] = 320000, ['tipo'] = "automobili" },
	["specter2"] = { ['name'] = "Specter2", ['price'] = 355000, ['tipo'] = "automobili" },
	["streiter"] = { ['name'] = "Streiter", ['price'] = 250000, ['tipo'] = "automobili" },
	["sultan"] = { ['name'] = "Sultan", ['price'] = 510000, ['tipo'] = "automobili" },
	["surano"] = { ['name'] = "Surano", ['price'] = 310000, ['tipo'] = "automobili" },
	["tampa2"] = { ['name'] = "Tampa2", ['price'] = 200000, ['tipo'] = "automobili" },
	["tropos"] = { ['name'] = "Tropos", ['price'] = 170000, ['tipo'] = "automobili" },
	["verlierer2"] = { ['name'] = "Verlierer2", ['price'] = 380000, ['tipo'] = "automobili" },
	["btype2"] = { ['name'] = "Btype2", ['price'] = 460000, ['tipo'] = "automobili" },
	["btype3"] = { ['name'] = "Btype3", ['price'] = 390000, ['tipo'] = "automobili" },
	["casco"] = { ['name'] = "Casco", ['price'] = 355000, ['tipo'] = "automobili" },
	["cheetah"] = { ['name'] = "Cheetah", ['price'] = 425000, ['tipo'] = "automobili" },
	["coquette2"] = { ['name'] = "Coquette2", ['price'] = 285000, ['tipo'] = "automobili" },
	["feltzer3"] = { ['name'] = "Feltzer3", ['price'] = 220000, ['tipo'] = "automobili" },
	["gt500"] = { ['name'] = "Gt500", ['price'] = 250000, ['tipo'] = "automobili" },
	["infernus2"] = { ['name'] = "Infernus2", ['price'] = 250000, ['tipo'] = "automobili" },
	["jb700"] = { ['name'] = "Jb700", ['price'] = 220000, ['tipo'] = "automobili" },
	["mamba"] = { ['name'] = "Mamba", ['price'] = 300000, ['tipo'] = "automobili" },
	["manana"] = { ['name'] = "Manana", ['price'] = 130000, ['tipo'] = "automobili" },
	["monroe"] = { ['name'] = "Monroe", ['price'] = 260000, ['tipo'] = "automobili" },
	["peyote"] = { ['name'] = "Peyote", ['price'] = 150000, ['tipo'] = "automobili" },
	["pigalle"] = { ['name'] = "Pigalle", ['price'] = 250000, ['tipo'] = "automobili" },
	["rapidgt3"] = { ['name'] = "Rapidgt3", ['price'] = 220000, ['tipo'] = "automobili" },
	["retinue"] = { ['name'] = "Retinue", ['price'] = 200000, ['tipo'] = "automobili" },
	["stinger"] = { ['name'] = "Stinger", ['price'] = 220000, ['tipo'] = "automobili" },
	["stingergt"] = { ['name'] = "Stingergt", ['price'] = 230000, ['tipo'] = "automobili" },
	["torero"] = { ['name'] = "Torero", ['price'] = 250000, ['tipo'] = "automobili" },
	["tornado"] = { ['name'] = "Tornado", ['price'] = 150000, ['tipo'] = "automobili" },
	["tornado2"] = { ['name'] = "Tornado2", ['price'] = 400000, ['tipo'] = "automobili" },
	["tornado6"] = { ['name'] = "Tornado6", ['price'] = 450000, ['tipo'] = "automobili" },
	["turismo2"] = { ['name'] = "Turismo2", ['price'] = 420000, ['tipo'] = "automobili" },
	["ztype"] = { ['name'] = "Ztype", ['price'] = 500000, ['tipo'] = "automobili" },
	["adder"] = { ['name'] = "Adder", ['price'] = 1500000, ['tipo'] = "automobili" },
	["autarch"] = { ['name'] = "Autarch", ['price'] = 760000, ['tipo'] = "automobili" },
	["banshee2"] = { ['name'] = "Banshee2", ['price'] = 370000, ['tipo'] = "automobili" },
	["bullet"] = { ['name'] = "Bullet", ['price'] = 600000, ['tipo'] = "automobili" },
	["cheetah2"] = { ['name'] = "Cheetah2", ['price'] = 240000, ['tipo'] = "automobili" },
	["entityxf"] = { ['name'] = "Entityxf", ['price'] = 4060000, ['tipo'] = "automobili" },
	["fmj"] = { ['name'] = "Fmj", ['price'] = 520000, ['tipo'] = "automobili" },
	["gp1"] = { ['name'] = "Gp1", ['price'] = 495000, ['tipo'] = "automobili" },
	["infernus"] = { ['name'] = "Infernus", ['price'] = 600000, ['tipo'] = "automobili" },
	["nero"] = { ['name'] = "Nero", ['price'] = 1000000, ['tipo'] = "automobili" },
	["nero2"] = { ['name'] = "Nero2", ['price'] = 1200000, ['tipo'] = "automobili" },
	["osiris"] = { ['name'] = "Osiris", ['price'] = 1200000, ['tipo'] = "automobili" },
	["penetrator"] = { ['name'] = "Penetrator", ['price'] = 480000, ['tipo'] = "automobili" },
	["pfister811"] = { ['name'] = "Pfister811", ['price'] = 530000, ['tipo'] = "automobili" },
	["reaper"] = { ['name'] = "Reaper", ['price'] = 620000, ['tipo'] = "automobili" },
	["sc1"] = { ['name'] = "Sc1", ['price'] = 1250000, ['tipo'] = "automobili" },
	["sultanrs"] = { ['name'] = "Sultan RS", ['price'] = 1000000, ['tipo'] = "automobili" },
	["t20"] = { ['name'] = "T20", ['price'] = 1900000, ['tipo'] = "automobili" },
	["tempesta"] = { ['name'] = "Tempesta", ['price'] = 600000, ['tipo'] = "automobili" },
	["turismor"] = { ['name'] = "Turismor", ['price'] = 620000, ['tipo'] = "automobili" },
	["tyrus"] = { ['name'] = "Tyrus", ['price'] = 620000, ['tipo'] = "automobili" },
	["vacca"] = { ['name'] = "Vacca", ['price'] = 620000, ['tipo'] = "automobili" },
	["visione"] = { ['name'] = "Visione", ['price'] = 690000, ['tipo'] = "automobili" },
	["voltic"] = { ['name'] = "Voltic", ['price'] = 440000, ['tipo'] = "automobili" },
	["zentorno"] = { ['name'] = "Zentorno", ['price'] = 920000, ['tipo'] = "automobili" },
	["sadler"] = { ['name'] = "Sadler", ['price'] = 180000, ['tipo'] = "automobili" },
	["bison"] = { ['name'] = "Bison", ['price'] = 220000, ['tipo'] = "automobili" },
	["bison2"] = { ['name'] = "Bison2", ['price'] = 180000, ['tipo'] = "automobili" },
	["bobcatxl"] = { ['name'] = "Bobcatxl", ['price'] = 260000, ['tipo'] = "automobili" },
	["burrito"] = { ['name'] = "Burrito", ['price'] = 260000, ['tipo'] = "automobili" },
	["burrito2"] = { ['name'] = "Burrito2", ['price'] = 260000, ['tipo'] = "automobili" },
	["burrito3"] = { ['name'] = "Burrito3", ['price'] = 260000, ['tipo'] = "automobili" },
	["burrito4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "automobili" },
	["mule4"] = { ['name'] = "Mule4", ['price'] = 260000, ['tipo'] = "automobili" },
	["rallytruck"] = { ['name'] = "Rallytruck", ['price'] = 6900000, ['tipo'] = "automobili" },
	["minivan"] = { ['name'] = "Minivan", ['price'] = 110000, ['tipo'] = "automobili" },
	["minivan2"] = { ['name'] = "Minivan2", ['price'] = 220000, ['tipo'] = "automobili" },
	["paradise"] = { ['name'] = "Paradise", ['price'] = 260000, ['tipo'] = "automobili" },
	["pony"] = { ['name'] = "Pony", ['price'] = 260000, ['tipo'] = "automobili" },
	["pony2"] = { ['name'] = "Pony2", ['price'] = 260000, ['tipo'] = "automobili" },
	["rumpo"] = { ['name'] = "Rumpo", ['price'] = 260000, ['tipo'] = "automobili" },
	["rumpo2"] = { ['name'] = "Rumpo2", ['price'] = 260000, ['tipo'] = "automobili" },
	["rumpo3"] = { ['name'] = "Rumpo3", ['price'] = 350000, ['tipo'] = "automobili" },
	["surfer"] = { ['name'] = "Surfer", ['price'] = 100000, ['tipo'] = "automobili" },
	["youga"] = { ['name'] = "Youga", ['price'] = 260000, ['tipo'] = "automobili" },
	["huntley"] = { ['name'] = "Huntley", ['price'] = 110000, ['tipo'] = "automobili" },
	["landstalker"] = { ['name'] = "Landstalker", ['price'] = 130000, ['tipo'] = "automobili" },
	["mesa"] = { ['name'] = "Mesa", ['price'] = 200000, ['tipo'] = "automobili" },
	["patriot"] = { ['name'] = "Patriot", ['price'] = 250000, ['tipo'] = "automobili" },
	["radi"] = { ['name'] = "Radi", ['price'] = 110000, ['tipo'] = "automobili" },
	["rocoto"] = { ['name'] = "Rocoto", ['price'] = 110000, ['tipo'] = "automobili" },
	["tyrant"] = { ['name'] = "Tyrant", ['price'] = 690000, ['tipo'] = "automobili" },
	["entity2"] = { ['name'] = "Entity2", ['price'] = 5050000, ['tipo'] = "automobili" },
	["cheburek"] = { ['name'] = "Cheburek", ['price'] = 170000, ['tipo'] = "automobili" },
	["hotring"] = { ['name'] = "Hotring", ['price'] = 300000, ['tipo'] = "automobili" },
	["jester3"] = { ['name'] = "Jester3", ['price'] = 650000, ['tipo'] = "automobili" },
	["flashgt"] = { ['name'] = "Flashgt", ['price'] = 370000, ['tipo'] = "automobili" },
	["ellie"] = { ['name'] = "Ellie", ['price'] = 320000, ['tipo'] = "automobili" },
	["michelli"] = { ['name'] = "Michelli", ['price'] = 160000, ['tipo'] = "automobili" },
	["fagaloa"] = { ['name'] = "Fagaloa", ['price'] = 320000, ['tipo'] = "automobili" },
	["dominator"] = { ['name'] = "Dominator", ['price'] = 230000, ['tipo'] = "automobili" },
	["dominator2"] = { ['name'] = "Dominator2", ['price'] = 230000, ['tipo'] = "automobili" },
	["dominator3"] = { ['name'] = "Dominator3", ['price'] = 370000, ['tipo'] = "automobili" },
	["issi3"] = { ['name'] = "Issi3", ['price'] = 190000, ['tipo'] = "automobili" },
	["taipan"] = { ['name'] = "Taipan", ['price'] = 620000, ['tipo'] = "automobili" },
	["gb200"] = { ['name'] = "Gb200", ['price'] = 195000, ['tipo'] = "automobili" },
	["stretch"] = { ['name'] = "Stretch", ['price'] = 520000, ['tipo'] = "automobili" },
	["guardian"] = { ['name'] = "Guardian", ['price'] = 540000, ['tipo'] = "automobili" },
	["kamacho"] = { ['name'] = "Kamacho", ['price'] = 460000, ['tipo'] = "automobili" },
	["neon"] = { ['name'] = "Neon", ['price'] = 370000, ['tipo'] = "automobili" },
	["cyclone"] = { ['name'] = "Cyclone", ['price'] = 920000, ['tipo'] = "automobili" },
	["italigtb"] = { ['name'] = "Italigtb", ['price'] = 600000, ['tipo'] = "automobili" },
	["italigtb2"] = { ['name'] = "Italigtb2", ['price'] = 610000, ['tipo'] = "automobili" },
	["vagner"] = { ['name'] = "Vagner", ['price'] = 680000, ['tipo'] = "automobili" },
	["xa21"] = { ['name'] = "Xa21", ['price'] = 630000, ['tipo'] = "automobili" },
	["tezeract"] = { ['name'] = "Tezeract", ['price'] = 920000, ['tipo'] = "automobili" },
	["prototipo"] = { ['name'] = "Prototipo", ['price'] = 1030000, ['tipo'] = "automobili" },
	["patriot2"] = { ['name'] = "Patriot2", ['price'] = 550000, ['tipo'] = "automobili" },
	["swinger"] = { ['name'] = "Swinger", ['price'] = 250000, ['tipo'] = "automobili" },
	["clique"] = { ['name'] = "Clique", ['price'] = 360000, ['tipo'] = "automobili" },
	["deveste"] = { ['name'] = "Deveste", ['price'] = 920000, ['tipo'] = "automobili" },
	["deviant"] = { ['name'] = "Deviant", ['price'] = 370000, ['tipo'] = "automobili" },
	["impaler"] = { ['name'] = "Impaler", ['price'] = 450000, ['tipo'] = "automobili" },
	["italigto"] = { ['name'] = "Italigto", ['price'] = 1200000, ['tipo'] = "automobili" },
	["schlagen"] = { ['name'] = "Schlagen", ['price'] = 690000, ['tipo'] = "automobili" },
	["toros"] = { ['name'] = "Toros", ['price'] = 700000, ['tipo'] = "automobili" },
	["tulip"] = { ['name'] = "Tulip", ['price'] = 320000, ['tipo'] = "automobili" },
	["vamos"] = { ['name'] = "Vamos", ['price'] = 320000, ['tipo'] = "automobili" },
	["freecrawler"] = { ['name'] = "Freecrawler", ['price'] = 350000, ['tipo'] = "automobili" },
	["fugitive"] = { ['name'] = "Fugitive", ['price'] = 50000, ['tipo'] = "automobili" },
	["glendale"] = { ['name'] = "Glendale", ['price'] = 70000, ['tipo'] = "automobili" },
	["intruder"] = { ['name'] = "Intruder", ['price'] = 60000, ['tipo'] = "automobili" },
	["le7b"] = { ['name'] = "Le7b", ['price'] = 900000, ['tipo'] = "automobili" },
	["lurcher"] = { ['name'] = "Lurcher", ['price'] = 150000, ['tipo'] = "automobili" },
	["lynx"] = { ['name'] = "Lynx", ['price'] = 650000, ['tipo'] = "automobili" },
	["phoenix"] = { ['name'] = "Phoenix", ['price'] = 250000, ['tipo'] = "automobili" },
	["premier"] = { ['name'] = "Premier", ['price'] = 35000, ['tipo'] = "automobili" },
	["raptor"] = { ['name'] = "Raptor", ['price'] = 350000, ['tipo'] = "automobili" },
	["sheava"] = { ['name'] = "Sheava", ['price'] = 700000, ['tipo'] = "automobili" },
	["z190"] = { ['name'] = "Z190", ['price'] = 400000, ['tipo'] = "automobili" },

	--MOTOS
	["akuma"] = { ['name'] = "Akuma", ['price'] = 6800000, ['tipo'] = "motos" },
	["avarus"] = { ['name'] = "Avarus", ['price'] = 440000, ['tipo'] = "motos" },
	["bagger"] = { ['name'] = "Bagger", ['price'] = 300000, ['tipo'] = "motos" },
	["bati"] = { ['name'] = "Bati", ['price'] = 4700000, ['tipo'] = "motos" },
	["bati2"] = { ['name'] = "Bati2", ['price'] = 4800000, ['tipo'] = "motos" },
	["bf400"] = { ['name'] = "Bf400", ['price'] = 5000000, ['tipo'] = "motos" },
	["carbonrs"] = { ['name'] = "Carbonrs", ['price'] = 370000, ['tipo'] = "motos" },
	["chimera"] = { ['name'] = "Chimera", ['price'] = 345000, ['tipo'] = "motos" },
	["cliffhanger"] = { ['name'] = "Cliffhanger", ['price'] = 310000, ['tipo'] = "motos" },
	["daemon2"]  = { ['name'] = "Daemon2", ['price'] = 240000, ['tipo'] = "motos" },
	["defiler"] = { ['name'] = "Defiler", ['price'] = 560000, ['tipo'] = "motos" },
	["diablous"] = { ['name'] = "Diablous", ['price'] = 430000, ['tipo'] = "motos" },
	["diablous2"] = { ['name'] = "Diablous2", ['price'] = 460000, ['tipo'] = "motos" },
	["double"] = { ['name'] = "Double", ['price'] = 5000000, ['tipo'] = "motos" },
	["enduro"] = { ['name'] = "Enduro", ['price'] = 300000, ['tipo'] = "motos" },
	["esskey"] = { ['name'] = "Esskey", ['price'] = 320000, ['tipo'] = "motos" },
	["faggio"] = { ['name'] = "Faggio", ['price'] = 7000, ['tipo'] = "motos" },
	["faggio2"] = { ['name'] = "Faggio2", ['price'] = 20000, ['tipo'] = "motos" },
	["faggio3"] = { ['name'] = "Faggio3", ['price'] = 8000, ['tipo'] = "motos" },
	["fcr"] = { ['name'] = "Fcr", ['price'] = 390000, ['tipo'] = "motos" },
	["fcr2"] = { ['name'] = "Fcr2", ['price'] = 390000, ['tipo'] = "motos" },
	["gargoyle"] = { ['name'] = "Gargoyle", ['price'] = 345000, ['tipo'] = "motos" },
	["hakuchou"] = { ['name'] = "Hakuchou", ['price'] = 5900000, ['tipo'] = "motos" },
	["hakuchou2"] = { ['name'] = "Hakuchou2", ['price'] = 5050000, ['tipo'] = "motos" },
	["hexer"] = { ['name'] = "Hexer", ['price'] = 250000, ['tipo'] = "motos" },
	["innovation"] = { ['name'] = "Innovation", ['price'] = 250000, ['tipo'] = "motos" },
	["lectro"] = { ['name'] = "Lectro", ['price'] = 380000, ['tipo'] = "motos" },
	["manchez"] = { ['name'] = "Manchez", ['price'] = 380000, ['tipo'] = "motos" },
	["nemesis"] = { ['name'] = "Nemesis", ['price'] = 550000, ['tipo'] = "motos" },
	["nightblade"] = { ['name'] = "Nightblade", ['price'] = 415000, ['tipo'] = "motos" },
	["pcj"] = { ['name'] = "Pcj", ['price'] = 80000, ['tipo'] = "motos" },
	["ruffian"] = { ['name'] = "Ruffian", ['price'] = 845000, ['tipo'] = "motos" },
	["sanchez"] = { ['name'] = "Sanchez", ['price'] = 185000, ['tipo'] = "motos" },
	["sanchez2"] = { ['name'] = "Sanchez2", ['price'] = 185000, ['tipo'] = "motos" },
	["sovereign"] = { ['name'] = "Sovereign", ['price'] = 285000, ['tipo'] = "motos" },
	["thrust"] = { ['name'] = "Thrust", ['price'] = 375000, ['tipo'] = "motos" },
	["vader"] = { ['name'] = "Vader", ['price'] = 345000, ['tipo'] = "motos" },
	["vindicator"] = { ['name'] = "Vindicator", ['price'] = 340000, ['tipo'] = "motos" },
	["vortex"] = { ['name'] = "Vortex", ['price'] = 1500000, ['tipo'] = "motos" },
	["wolfsbane"] = { ['name'] = "Wolfsbane", ['price'] = 290000, ['tipo'] = "motos" },
	["zombiea"] = { ['name'] = "Zombiea", ['price'] = 290000, ['tipo'] = "motos" },
	["zombieb"] = { ['name'] = "Zombieb", ['price'] = 300000, ['tipo'] = "motos" },
	["shotaro"] = { ['name'] = "Shotaro", ['price'] = 1000000, ['tipo'] = "motos" },
	["ratbike"] = { ['name'] = "Ratbike", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer"] = { ['name'] = "Blazer", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer4"] = { ['name'] = "Blazer4", ['price'] = 370000, ['tipo'] = "motos" },
	-- polizia/PARAMEDICO
	["vra3"] = { ['name'] = "Audi A3", ['price'] = 1000, ['tipo'] = "work" },
	["vra4"] = { ['name'] = "Audi A4", ['price'] = 1000, ['tipo'] = "work" },
	["vrq8"] = { ['name'] = "Audi Q8", ['price'] = 1000, ['tipo'] = "work" },
	["vrrs6"] = { ['name'] = "Audi RS7", ['price'] = 1000, ['tipo'] = "work" },
	["vrrs6av"] = { ['name'] = "Audi RS6", ['price'] = 1000, ['tipo'] = "work" },
	["vrrs5"] = { ['name'] = "Audi RS5", ['price'] = 1000, ['tipo'] = "work" },
	["vrraptor"] = { ['name'] = "Ford Raptor", ['price'] = 1000, ['tipo'] = "work" },
	["vrtahoe"] = { ['name'] = "Chevrolet Tahoe", ['price'] = 1000, ['tipo'] = "work" },
	["vrdm1200"] = { ['name'] = "Ducati DM1200", ['price'] = 1000, ['tipo'] = "work" },
	["polmav"] = { ['name'] = "Heli polizia", ['price'] = 1000, ['tipo'] = "work" },

	-- polizia NOVOS
	
	["WRa45"] = { ['name'] = "A45", ['price'] = 1000, ['tipo'] = "work" },
	["WRbmwx7"] = { ['name'] = "BMWx7", ['price'] = 1000, ['tipo'] = "work" },
	["WRc7pm"] = { ['name'] = "Corvette", ['price'] = 1000, ['tipo'] = "work" },
	["WRcorollapm"] = { ['name'] = "Corolla", ['price'] = 1000, ['tipo'] = "work" },
	["xxxxxcore"] = { ['name'] = "C.O.R.E Suv", ['price'] = 1000, ['tipo'] = "work" },
	["xxxxxpol"] = { ['name'] = "B.O.P.E Suv", ['price'] = 1000, ['tipo'] = "work" },
	["WRr1200pol"] = { ['name'] = "G.R.R Moto", ['price'] = 1000, ['tipo'] = "work" },

	-- HOSPITAL NOVOS
	["r1200rtp"] = { ['name'] = "R1200 Hospital", ['price'] = 1000, ['tipo'] = "work" },
	["qrv"] = { ['name'] = "QRV Hospital", ['price'] = 1000, ['tipo'] = "work" },
	["raiosprinter"] = { ['name'] = "Ambulância", ['price'] = 1000, ['tipo'] = "work" },


	["pbus"] = { ['name'] = "PBus", ['price'] = 1000, ['tipo'] = "work" },
	["riot"] = { ['name'] = "Blindado", ['price'] = 1000, ['tipo'] = "work" },

	["seasparrow"] = { ['name'] = "Seasparrow", ['price'] = 1000, ['tipo'] = "work" },
	["ambulance"] = { ['name'] = "Ambulance", ['price'] = 1000, ['tipo'] = "work" },
	["emstalker"] = { ['name'] = "Stalker", ['price'] = 1000, ['tipo'] = "work" },
	["palmav"] = { ['name'] = "Polmav", ['price'] = 1000, ['tipo'] = "work" },

	--TRABALHO
	["youga2"] = { ['name'] = "Youga2", ['price'] = 1000, ['tipo'] = "work" },
	["felon2"] = { ['name'] = "Felon2", ['price'] = 1000, ['tipo'] = "work" },
	["coach"] = { ['name'] = "Coach", ['price'] = 1000, ['tipo'] = "work" },
	["bus"] = { ['name'] = "Ônibus", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed"] = { ['name'] = "Reboque", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck"] = { ['name'] = "Towtruck", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck2"] = { ['name'] = "Towtruck2", ['price'] = 1000, ['tipo'] = "work" },
	["ratloader"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["ratloader2"] = { ['name'] = "Ratloader2", ['price'] = 1000, ['tipo'] = "work" },
	["rubble"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["taxi"] = { ['name'] = "Taxi", ['price'] = 1000, ['tipo'] = "work" },
	["boxville4"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["trash2"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["tiptruck"] = { ['name'] = "Tiptruck", ['price'] = 1000, ['tipo'] = "work" },
	["scorcher"] = { ['name'] = "Scorcher", ['price'] = 1000, ['tipo'] = "work" },
	["tribike"] = { ['name'] = "Tribike", ['price'] = 1000, ['tipo'] = "work" },
	["tribike2"] = { ['name'] = "Tribike2", ['price'] = 1000, ['tipo'] = "work" },
	["tribike3"] = { ['name'] = "Tribike3", ['price'] = 1000, ['tipo'] = "work" },
	["fixter"] = { ['name'] = "Fixter", ['price'] = 1000, ['tipo'] = "work" },
	["cruiser"] = { ['name'] = "Cruiser", ['price'] = 1000, ['tipo'] = "work" },
	["bmx"] = { ['name'] = "Bmx", ['price'] = 1000, ['tipo'] = "work" },
	["dinghy"] = { ['name'] = "Dinghy", ['price'] = 1000, ['tipo'] = "work" },
	["jetmax"] = { ['name'] = "Jetmax", ['price'] = 1000, ['tipo'] = "work" },
	["marquis"] = { ['name'] = "Marquis", ['price'] = 1000, ['tipo'] = "work" },
	["seashark3"] = { ['name'] = "Seashark3", ['price'] = 1000, ['tipo'] = "work" },
	["speeder"] = { ['name'] = "Speeder", ['price'] = 1000, ['tipo'] = "work" },
	["speeder2"] = { ['name'] = "Speeder2", ['price'] = 1000, ['tipo'] = "work" },
	["squalo"] = { ['name'] = "Squalo", ['price'] = 1000, ['tipo'] = "work" },
	["suntrap"] = { ['name'] = "Suntrap", ['price'] = 1000, ['tipo'] = "work" },
	["toro"] = { ['name'] = "Toro", ['price'] = 1000, ['tipo'] = "work" },
	["toro2"] = { ['name'] = "Toro2", ['price'] = 1000, ['tipo'] = "work" },
	["tropic"] = { ['name'] = "Tropic", ['price'] = 1000, ['tipo'] = "work" },
	["tropic2"] = { ['name'] = "Tropic2", ['price'] = 1000, ['tipo'] = "work" },
	["phantom"] = { ['name'] = "Phantom", ['price'] = 1000, ['tipo'] = "work" },
	["packer"] = { ['name'] = "Packer", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito"] = { ['name'] = "Supervolito", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito2"] = { ['name'] = "Supervolito2", ['price'] = 1000, ['tipo'] = "work" },
	["cuban800"] = { ['name'] = "Cuban800", ['price'] = 1000, ['tipo'] = "work" },
	["mammatus"] = { ['name'] = "Mammatus", ['price'] = 1000, ['tipo'] = "work" },
	["vestra"] = { ['name'] = "Vestra", ['price'] = 1000, ['tipo'] = "work" },
	["velum2"] = { ['name'] = "Velum2", ['price'] = 1000, ['tipo'] = "work" },
	["buzzard2"] = { ['name'] = "Buzzard2", ['price'] = 1000, ['tipo'] = "work" },
	["frogger"] = { ['name'] = "Frogger", ['price'] = 1000, ['tipo'] = "work" },
	["maverick"] = { ['name'] = "Maverick", ['price'] = 1000, ['tipo'] = "work" },
	["tanker2"] = { ['name'] = "Gas", ['price'] = 1000, ['tipo'] = "work" },
	["armytanker"] = { ['name'] = "Diesel", ['price'] = 1000, ['tipo'] = "work" },
	["tvtrailer"] = { ['name'] = "Show", ['price'] = 1000, ['tipo'] = "work" },
	["trailerlogs"] = { ['name'] = "Woods", ['price'] = 1000, ['tipo'] = "work" },
	["tr4"] = { ['name'] = "Cars", ['price'] = 1000, ['tipo'] = "work" },
	["speedo"] = { ['name'] = "Speedo", ['price'] = 200000, ['tipo'] = "work" },
	["primo2"] = { ['name'] = "Primo2", ['price'] = 200000, ['tipo'] = "work" },
	["faction2"] = { ['name'] = "Faction2", ['price'] = 200000, ['tipo'] = "work" },
	["chino2"] = { ['name'] = "Chino2", ['price'] = 200000, ['tipo'] = "work" },
	["tornado5"] = { ['name'] = "Tornado5", ['price'] = 200000, ['tipo'] = "work" },
	["daemon"] = { ['name'] = "Daemon", ['price'] = 200000, ['tipo'] = "work" },
	["sanctus"] = { ['name'] = "Sanctus", ['price'] = 200000, ['tipo'] = "work" },
	["gburrito"] = { ['name'] = "GBurrito", ['price'] = 200000, ['tipo'] = "work" },
	["slamvan2"] = { ['name'] = "Slamvan2", ['price'] = 200000, ['tipo'] = "work" },
	["stafford"] = { ['name'] = "Stafford", ['price'] = 200000, ['tipo'] = "work" },
	["cog55"] = { ['name'] = "Cog55", ['price'] = 200000, ['tipo'] = "work" },
	["superd"] = { ['name'] = "Superd", ['price'] = 200000, ['tipo'] = "work" },
	["btype"] = { ['name'] = "Btype", ['price'] = 200000, ['tipo'] = "work" },
	["tractor2"] = { ['name'] = "Tractor2", ['price'] = 1000, ['tipo'] = "work" },
	["rebel"] = { ['name'] = "Rebel", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed3"] = { ['name'] = "flatbed3", ['price'] = 1000, ['tipo'] = "work" },
	["volatus"] = { ['name'] = "Volatus", ['price'] = 1000000, ['tipo'] = "work" },
	["cargobob2"] = { ['name'] = "Cargo Bob", ['price'] = 1000000, ['tipo'] = "work" },		
	

	---IMPORTADOS ATT

	-- TUNERS
	["sultan3"] = { ['name'] = "Sultan3", ['price'] =  3000000, ['tipo'] = "import" },
	["cypher"] = { ['name'] = "Cypher", ['price'] =  2900000, ['tipo'] = "import" },
	["jester4"] = { ['name'] = "Jester4", ['price'] =  2500000, ['tipo'] = "import" },
	["comet6"] = { ['name'] = "Comet6", ['price'] =  2900000, ['tipo'] = "import" },
	["zr350"] = { ['name'] = "Zr350", ['price'] =  2000000, ['tipo'] = "import" },
	["calico"] = { ['name'] = "Calico", ['price'] =  1900000, ['tipo'] = "import" },
	["euros"] = { ['name'] = "Euros", ['price'] =  2500000, ['tipo'] = "import" },
	["growler"] = { ['name'] = "Growler", ['price'] =  1900000, ['tipo'] = "import" },
	["rt3000"] = { ['name'] = "Rt3000", ['price'] =  3500000, ['tipo'] = "import" },
	-- CAYO PERICO
	["jugular"] = { ['name'] = "Jugular", ['price'] =  4000000, ['tipo'] = "import" },
	["sultan2"] = { ['name'] = "Sultan2", ['price'] =  1900000, ['tipo'] = "import" },
	["emerus"] = { ['name'] = "Emerus", ['price'] =  6050000, ['tipo'] = "import" },
	["furia"] = { ['name'] = "Furia", ['price'] =  690000, ['tipo'] = "import" },
	["krieger"] = { ['name'] = "Krieger", ['price'] =  500000, ['tipo'] = "import" },
	["thrax"] = { ['name'] = "Thrax", ['price'] =  2000000, ['tipo'] = "import" },
	["rebla"] = { ['name'] = "Rebla", ['price'] =  4000000, ['tipo'] = "import" },

	["stryder"] = { ['name'] = "Stryder", ['price'] =  270000, ['tipo'] = "motos" },
	["manchez2"] = { ['name'] = "Manchez2", ['price'] =  120000, ['tipo'] = "motos" },
	["verus"] = { ['name'] = "Verus", ['price'] =  170000, ['tipo'] = "motos" },

	["kanjo"] = { ['name'] = "Kanjo", ['price'] =  37000, ['tipo'] = "automobili" },
	["asbo"] = { ['name'] = "Asbo", ['price'] =  30000, ['tipo'] = "automobili" },
	["club"] = { ['name'] = "Club", ['price'] =  20000, ['tipo'] = "automobili" },
	["brioso2"] = { ['name'] = "Brioso2", ['price'] =  10000, ['tipo'] = "automobili" },
	["weevil"] = { ['name'] = "Weevil", ['price'] =  12000, ['tipo'] = "automobili" },
	["rrocket"] = { ['name'] = "Rrocket", ['price'] =  250000, ['tipo'] = "automobili" },
	["gauntlet3"] = { ['name'] = "Gauntlet3", ['price'] =  250000, ['tipo'] = "automobili" },
	["gauntlet4"] = { ['name'] = "Gauntlet4", ['price'] =  400000, ['tipo'] = "automobili" },
	["gauntlet5"] = { ['name'] = "Gauntlet5", ['price'] =  290000, ['tipo'] = "automobili" },
	["yosemite2"] = { ['name'] = "Yosemite2", ['price'] =  127000, ['tipo'] = "automobili" },
	["yosemite3"] = { ['name'] = "Yosemite3", ['price'] =  190000, ['tipo'] = "automobili" },
	["caracara2"] = { ['name'] = "Caracara2", ['price'] =  450000, ['tipo'] = "automobili" },
	["everon"] = { ['name'] = "Everon", ['price'] =  460000, ['tipo'] = "automobili" },
	["hellion"] = { ['name'] = "Hellion", ['price'] =  90000, ['tipo'] = "automobili" },
	["outlaw"] = { ['name'] = "Outlaw", ['price'] =  50000, ['tipo'] = "automobili" },
	["vagrant"] = { ['name'] = "Vagrant", ['price'] =  99000, ['tipo'] = "automobili" },
	["winky"] = { ['name'] = "Winky", ['price'] =  120000, ['tipo'] = "automobili" },
	["landstalker2"] = { ['name'] = "Landstalker2", ['price'] =  400000, ['tipo'] = "automobili" },
	["novak"] = { ['name'] = "Novak", ['price'] =  400000, ['tipo'] = "automobili" },
	["seminole2"] = { ['name'] = "Seminole2", ['price'] =  10000, ['tipo'] = "automobili" },
	["glendale2"] = { ['name'] = "Glendale2", ['price'] =  370000, ['tipo'] = "automobili" },
	["coquette4"] = { ['name'] = "Coquette4", ['price'] =  550000, ['tipo'] = "automobili" },
	["drafter"] = { ['name'] = "Drafter", ['price'] =  400000, ['tipo'] = "automobili" },
	["komoda"] = { ['name'] = "Komoda", ['price'] =  570000, ['tipo'] = "automobili" },
	["imorgon"] = { ['name'] = "Imorgon", ['price'] =  380000, ['tipo'] = "automobili" },
	["issi7"] = { ['name'] = "Issi7", ['price'] =  100000, ['tipo'] = "automobili" },
	["locust"] = { ['name'] = "Locust", ['price'] =  200000, ['tipo'] = "automobili" },
	["neo"] = { ['name'] = "Neo", ['price'] =  550000, ['tipo'] = "automobili" },
	["paragon"] = { ['name'] = "Paragon", ['price'] =  650000, ['tipo'] = "automobili" },
	["penumbra2"] = { ['name'] = "Penumbra2", ['price'] =  500000, ['tipo'] = "automobili" },
	["sugoi"] = { ['name'] = "Sugoi", ['price'] =  540000, ['tipo'] = "automobili" },
	["vstr"] = { ['name'] = "Vstr", ['price'] =  350000, ['tipo'] = "automobili" },
	["veto"] = { ['name'] = "Veto", ['price'] =  10000, ['tipo'] = "automobili" },
	["veto2"] = { ['name'] = "Veto2", ['price'] =  10000, ['tipo'] = "automobili" },
	["peyote3"] = { ['name'] = "Peyote3", ['price'] =  103000, ['tipo'] = "automobili" },
	["retinue2"] = { ['name'] = "Retinue2", ['price'] =  100000, ['tipo'] = "automobili" },
	["nebula"] = { ['name'] = "Nebula", ['price'] =  10000, ['tipo'] = "automobili" },
	["zion3"] = { ['name'] = "Zion3", ['price'] =  19000, ['tipo'] = "automobili" },
	["s80"] = { ['name'] = "S80", ['price'] =  490000, ['tipo'] = "automobili" },
	["tigon"] = { ['name'] = "Tigon", ['price'] =  1200000, ['tipo'] = "automobili" },
	["zorrusso"] = { ['name'] = "Zorrusso", ['price'] =  1200000, ['tipo'] = "automobili" },
	["youga3"] = { ['name'] = "Youga3", ['price'] =  890000, ['tipo'] = "automobili" },
	["slamtruck"] = { ['name'] = "Slamtruck", ['price'] =  1000, ['tipo'] = "work" },
	["hiluxsw4"] = { ['name'] = "Hilux SW4", ['price'] =  9000000, ['tipo'] = "import" },
	
	--IMPORTADOS
	["bmci"] = { ['name'] = "BMW M5 F90", ['price'] = 6200000, ['tipo'] = "import" },
	["bmwm4gts"] = { ['name'] = "BMW M4 GTS", ['price'] = 3500000, ['tipo'] = "import" },
	["audirs7"] = { ['name'] = "Audi RS7", ['price'] = 6700000, ['tipo'] = "import" },

	["f800"] = { ['name'] = "BMW F800", ['price'] = 4000000, ['tipo'] = "import" },
	["mazdarx7"] = { ['name'] = "Mazda RX7", ['price'] = 3500000, ['tipo'] = "import" },
	["bmwi8"] = { ['name'] = "BMW I8", ['price'] = 7500000, ['tipo'] = "import" },
	["h2carb"] = { ['name'] = "Kawasaki H2R", ['price'] = 6600000, ['tipo'] = "import" },
	["r1"] = { ['name'] = "Yamaha R1", ['price'] = 7000000, ['tipo'] = "import" },
	["r6"] = { ['name'] = "Yamaha R6", ['price'] = 8950000, ['tipo'] = "import" },
	["765lt"] = { ['name'] = "McLaren 765LT", ['price'] = 8000000, ['tipo'] = "import" },
	["brz13"] = { ['name'] = "Subaru STI", ['price'] = 4800000, ['tipo'] = "import" },
	["rmodx6"] = { ['name'] = "BMW X6", ['price'] = 4500000, ['tipo'] = "import" },
	["gt2rsmr"] = { ['name'] = "Porsche 911 GT2 RS", ['price'] = 4500000, ['tipo'] = "import" },
	["africat"] = { ['name'] = "Honda CRF 1000", ['price'] = 2900000, ['tipo'] = "import" },
	["mlnovitec"] = { ['name'] = "Maserati Novitec", ['price'] = 4200000, ['tipo'] = "import" },
	["toyotasupra"] = { ['name'] = "Toyota Supra", ['price'] = 9000000, ['tipo'] = "import" },
	["160"] = { ['name'] = "Honda 160", ['price'] = 650000, ['tipo'] = "import" },
	["hb20"] = { ['name'] = "Hyundai HB20", ['price'] = 1000000, ['tipo'] = "import" },
	["mobi"] = { ['name'] = "Mobilete", ['price'] = 700000, ['tipo'] = "import" },
	["jettagli"] = { ['name'] = "Jetta GLI", ['price'] = 1250000, ['tipo'] = "import" },

	--EXCLUSIVE
	["porscherusher"] = { ['name'] = "911 Porsche", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xnsgt"] = { ['name'] = "Hennessey Venom GT", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lamborghinihuracan"] = { ['name'] = "Lamborghini Huracan", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pcx"] = { ['name'] = "Yamaha Xmax", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["f8t"] = { ['name'] = "Ferrari F8 Tributo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["golfgti7"] = { ['name'] = "Golf GTI MK7", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbr1000rrr"] = { ['name'] = "CBR 1000 RRR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedesgt63"] = { ['name'] = "Mercedes AMG GT 63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r820"] = { ['name'] = "Audi R8 2020", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["gs1200"] = { ['name'] = "BMW GS 1200", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xt700"] = { ['name'] = "Yamaha XT-700", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["nissangtr"] = { ['name'] = "Nissan GTR 2017", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissanskylinerocket"] = { ['name'] = "Nissan Skyline Rocket", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissanskyliner34"] = { ['name'] = "Nissan Skyline R34", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["tiger"] = { ['name'] = "Triumph Tiger 800", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pturismo"] = { ['name'] = "Porsche Panamera", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pcs18"] = { ['name'] = "Porsche Cayenne", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["amarok"] = { ['name'] = "Volkswagen Amarok", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ben17"] = { ['name'] = "Bentley Super Sport", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwm8"] = { ['name'] = "BMW M8", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cb500x"] = { ['name'] = "Honda CB 500X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution 09", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["urus"] = { ['name'] = "Lamborghini Urus", ['price'] = 1000000, ['tipo'] = "exclusive" },

	["bmwm3e36"] = { ['name'] = "BMW M3 E36", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ferrarif12"] = { ['name'] = "Ferrari F12", ['price'] = 1000000, ['tipo'] = "exclusive" },

	["coquettessd"] = { ['name'] = "HPD Coquette", ['price'] = 10020, ['tipo'] = "work" },
    ["carbonssd"] = { ['name'] = "HPD Carbon", ['price'] = 10200, ['tipo'] = "work" },
    ["caracarastd"] = { ['name'] = "HPD Caracara", ['price'] = 10200, ['tipo'] = "work" },
    ["komodahc"] = { ['name'] = "HPD Komodahc", ['price'] = 10200, ['tipo'] = "work" },
    ["jugularspd"] = { ['name'] = "HPD Jugular", ['price'] = 10020, ['tipo'] = "work" },
    ["sugoispd"] = { ['name'] = "HPD Sugoi", ['price'] = 10020, ['tipo'] = "work" },
	["VRcontender"] = { ['name'] = "HPD Contender", ['price'] = 1000, ['tipo'] = "work" },
    ["VRdubsta"] = { ['name'] = "HPD Dubsta", ['price'] = 1000, ['tipo'] = "work" },

	["r820"] = { ['name'] = "Audi R8", ['price'] = 1000000, ['tipo'] = "importado" },
	["subaruwrx"] = { ['name'] = "Subaru", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["audirs5"] = { ['name'] = "Audi rs5", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmci"] = { ['name'] = "Bmw M5", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwm4gts"] = { ['name'] = "BMW M4", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["MLNOVITEC"] = { ['name'] = "Masserati Novitec", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["h2carb"] = { ['name'] = "H2R", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbr1000rrr"] = { ['name'] = "CBR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r1"] = { ['name'] = "Yamaha R1", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r6"] = { ['name'] = "Yamaha R6", ['price'] = 1000000, ['tipo'] = "importado" },
	["AFRICAT"] = { ['name'] = "africa twin", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["20xmax"] = { ['name'] = "Xmax", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["f800"] = { ['name'] = "Bmw F800", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["160"] = { ['name'] = "CG160", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["a6"] = { ['name'] = "Audi A6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["c63"] = { ['name'] = "Mercedes C63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbb"] = { ['name'] = "CBB", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbr17"] = { ['name'] = "CBR17", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["spincivil"] = { ['name'] = "Spin", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["fordfocus"] = { ['name'] = "Ford Focus", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["giulia"] = { ['name'] = "Giulia", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gol"] = { ['name'] = "Gol", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["golfgti7"] = { ['name'] = "Golf GTI", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gs310"] = { ['name'] = "GS310", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hiluxsw4"] = { ['name'] = "Hilux SW4", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["meccx"] = { ['name'] = "Mercedes X-Class", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mk3vr6"] = { ['name'] = "Mk3 VR6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["panamera17turbo"] = { ['name'] = "Panamera Turbo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pgt3"] = { ['name'] = "Porsche GT3", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodgtr50"] = { ['name'] = "Nissan GTR-50", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rs3"] = { ['name'] = "Audi RS3", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["sonata20"] = { ['name'] = "Sonata", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["up"] = { ['name'] = "UP", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["WRTiger900"] = { ['name'] = "Tiger 900", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xj6"] = { ['name'] = "XJ6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xt"] = { ['name'] = "XT", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["jettagli"] = { ['name'] = "Jetta GLI", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["barricada"] = { ['name'] = "Barricada", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gcmcity14"] = { ['name'] = "Honda City", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hondacivic20"] = { ['name'] = "Honda Civic", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hornet"] = { ['name'] = "Hornetera", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["765lt"] = { ['name'] = "Mc Larem", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["toyotasupra"] = { ['name'] = "Toyota Supra", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lamborghinihuracan"] = { ['name'] = "Lamborghini Huracan", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["porscherusher"] = { ['name'] = "Porche 911", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["brz13"] = { ['name'] = "Subaru BRZ", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gt2rsmr"] = { ['name'] = "Porche GT3RS", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwi8"] = { ['name'] = "BMW i8", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodx6"] = { ['name'] = "BMW X6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissanskyliner34"] = { ['name'] = "Nissan Skyline R34", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedesgt63"] = { ['name'] = "Mercedes GT63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mazdrx7"] = { ['name'] = "Mazda RX7", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xnsgt"] = { ['name'] = "Hennessey Venom GT ", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mk7"] = { ['name'] = "Golf Mk7 GTI", ['price'] = 4000000, ['tipo'] = "importado" },
	["180sx"] = { ['name'] = "Nissan 180SX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["filthynsx"] = { ['name'] = "Honda NSX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["tiger"] = { ['name'] = "Triumph Tiger 800", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["s1000rr"] = { ['name'] = "BMW S1000rr", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["911turbos"] = { ['name'] = "Porsche 911", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissangtr2"] = { ['name'] = "Nissan GTR R35", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedesgt63"] = { ['name'] = "Mercedes AMG GT63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedespolizia"] = { ['name'] = "Mercedes polizia", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["civictyper"] = { ['name'] = "Civic Typer", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["subaruimpreza"] = { ['name'] = "Subaru Impreza", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r820"] = { ['name'] = "Audi R8", ['price'] = 1000000, ['tipo'] = "importado" },
	["subaruwrx"] = { ['name'] = "Subaru", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["audirs5"] = { ['name'] = "Audi rs5", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmci"] = { ['name'] = "Bmw M5", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwm4gts"] = { ['name'] = "BMW M4", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["MLNOVITEC"] = { ['name'] = "Masserati Novitec", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["h2carb"] = { ['name'] = "H2R", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbr1000rrr"] = { ['name'] = "CBR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r1"] = { ['name'] = "Yamaha R1", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r6"] = { ['name'] = "Yamaha R6", ['price'] = 1000000, ['tipo'] = "importado" },
	["AFRICAT"] = { ['name'] = "africa twin", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["20xmax"] = { ['name'] = "Xmax", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["f800"] = { ['name'] = "Bmw F800", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["160"] = { ['name'] = "CG160", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["a6"] = { ['name'] = "Audi A6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["c63"] = { ['name'] = "Mercedes C63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbb"] = { ['name'] = "CBB", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbr17"] = { ['name'] = "CBR17", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["spincivil"] = { ['name'] = "Spin", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["fordfocus"] = { ['name'] = "Ford Focus", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["giulia"] = { ['name'] = "Giulia", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gol"] = { ['name'] = "Gol", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["golfgti7"] = { ['name'] = "Golf GTI", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gs310"] = { ['name'] = "GS310", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hiluxsw4"] = { ['name'] = "Hilux SW4", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["meccx"] = { ['name'] = "Mercedes X-Class", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mk3vr6"] = { ['name'] = "Mk3 VR6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["panamera17turbo"] = { ['name'] = "Panamera Turbo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pgt3"] = { ['name'] = "Porsche GT3", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodgtr50"] = { ['name'] = "Nissan GTR-50", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rs3"] = { ['name'] = "Audi RS3", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["sonata20"] = { ['name'] = "Sonata", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["up"] = { ['name'] = "UP", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["WRTiger900"] = { ['name'] = "Tiger 900", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xj6"] = { ['name'] = "XJ6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xt"] = { ['name'] = "XT", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["jettagli"] = { ['name'] = "Jetta GLI", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["barricada"] = { ['name'] = "Barricada", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gcmcity14"] = { ['name'] = "Honda City", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hondacivic20"] = { ['name'] = "Honda Civic", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hornet"] = { ['name'] = "Hornetera", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["765lt"] = { ['name'] = "Mc Larem", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["toyotasupra"] = { ['name'] = "Toyota Supra", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lamborghinihuracan"] = { ['name'] = "Lamborghini Huracan", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["porscherusher"] = { ['name'] = "Porche 911", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["brz13"] = { ['name'] = "Subaru BRZ", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gt2rsmr"] = { ['name'] = "Porche GT3RS", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwi8"] = { ['name'] = "BMW i8", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodx6"] = { ['name'] = "BMW X6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissanskyliner34"] = { ['name'] = "Nissan Skyline R34", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedesgt63"] = { ['name'] = "Mercedes GT63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mazdrx7"] = { ['name'] = "Mazda RX7", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xnsgt"] = { ['name'] = "Hennessey Venom GT ", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mk7"] = { ['name'] = "Golf Mk7 GTI", ['price'] = 4000000, ['tipo'] = "importado" },
	["180sx"] = { ['name'] = "Nissan 180SX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["filthynsx"] = { ['name'] = "Honda NSX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["tiger"] = { ['name'] = "Triumph Tiger 800", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["s1000rr"] = { ['name'] = "BMW S1000rr", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["911turbos"] = { ['name'] = "Porsche 911", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissangtr2"] = { ['name'] = "Nissan GTR R35", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedesgt63"] = { ['name'] = "Mercedes AMG GT63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedespolizia"] = { ['name'] = "Mercedes polizia", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["civictyper"] = { ['name'] = "Civic Typer", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["subaruimpreza"] = { ['name'] = "Subaru Impreza", ['price'] = 1000000, ['tipo'] = "exclusive" },	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleGlobal()
	return vehglobal
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleName(vname)
	return vehglobal[vname].name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehiclePrice(vname)
	return vehglobal[vname].price
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleType(vname)
	return vehglobal[string.lower(tostring(vname))].tipo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VAR : ANTI MULTI OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
local OpenedChest = {}

function vRP.DupOpenChest(chest, user_id)
    OpenedChest[chest] = user_id
    print('^4[!] ^0Abrindo ^4' .. chest .. ' ^0no ID ^4' .. user_id)
end

function vRP.DupCheckChest(chest, nuser_id)
    if chest ~= '' then
        if OpenedChest[chest] then
            print('^4[!] ^0Checando ^4' .. chest .. ' ^0no ID ^4' .. nuser_id .. ' ^0- ID aberto: ^4' .. OpenedChest[chest])
            if OpenedChest[chest] == nuser_id then
                return true
            end
        end
    end
    return false
end