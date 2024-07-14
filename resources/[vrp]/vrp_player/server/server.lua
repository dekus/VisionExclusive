-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local Tools = module("vrp","lib/Tools")

local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_player",src)
vCLIENT = Tunnel.getInterface("vrp_player")
vPOLICE = Tunnel.getInterface("vrp_polizia")
client = Tunnel.getInterface("vrp_player",client)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
statusGarmas = {}
statusPaypal = {}
local garmas_user = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookgarmas = "https://discord.com/api/webhooks/1131629546999910512/i0JRnlt-RyVWshx9BhED10vlNP84XFBergn_BZXj75ogGnXDUY7GqAdmtuBldDmNHxnt"
local webhookgarmas250 = "https://discord.com/api/webhooks/1131629546999910512/i0JRnlt-RyVWshx9BhED10vlNP84XFBergn_BZXj75ogGnXDUY7GqAdmtuBldDmNHxnt"
local webhookenviardinheiro = "https://discord.com/api/webhooks/1131629313649807501/hbSMrSSw-BhxY7sfRlLPbFP1YLH6MMzDhASy4VN_D9SkOvutqgPkgnPNjF9nbHRJxeBf"
local webhooksaquear = "https://discord.com/api/webhooks/1131629215515672676/qyunxWzKxD-2FsM6lgESBcCTbj-gn2qRracEPo5lJw2Nipfyrp935tekGam4ddTZOGyl"
local webhooksalario = "https://discord.com/api/webhooks/1131629681494470716/uMTxZvrfuBO5o9X4oAyvJ2v-6UsINOQXFBGrFVIHNa3oL9dXFY2rIGbxHh0UAL58698r"
local webhookgmochila = "https://discord.com/api/webhooks/1131629983031369870/6rc_bHGA5swvZ0LSnO2DVGzgtj1O7kI1XeQe7AXbD1WjN1Oru4dDjM5gFvMZlCr0TpbQ"
local discordLogPaypal = "https://discord.com/api/webhooks/1131630065415888996/FnCsDczoRaK6nXbfYcuRNyV9HgnqfQ13DFG0kjy8PAxKCJgqrxm3SCcDmsJxddNRjurP"
local webhookgarmasquit = "https://discord.com/api/webhooks/1131629546999910512/i0JRnlt-RyVWshx9BhED10vlNP84XFBergn_BZXj75ogGnXDUY7GqAdmtuBldDmNHxnt"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"vip.autorizzazione") or vRP.hasPermission(user_id,"ceo.autorizzazione") or vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id,"mod.autorizzazione") or vRP.hasPermission(user_id,"support.autorizzazione") or vRP.hasPermission(user_id, "polizia.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "colaborador.autorizzazione")  then
			return true 
		else
			TriggerClientEvent("Notify",source,'negato',"Non possiedi l'oggetto <b>VESTITI</b>.") 
			return false
		end
	end
end

function src.CheckBooster()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"booster.autorizzazione") then
			return true 
		else
			TriggerClientEvent("Notify",source,'negato',"Non possiedi <b>Booster</b>.") 
			return false
		end
	end
end

function src.PossuiCompArma()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		if vRP.getInventoryItemAmount(user_id,"kitarma") >= 1 or vRP.hasPermission(user_id,"vip.autorizzazione") or vRP.hasPermission(user_id,"booster.autorizzazione") or vRP.hasPermission(user_id,"basic.autorizzazione") or vRP.hasPermission(user_id,"ceo.autorizzazione") or vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id,"mod.autorizzazione") or vRP.hasPermission(user_id,"support.autorizzazione") or vRP.hasPermission(user_id, "polizia.autorizzazione") or vRP.hasPermission(user_id, "poliziaazione.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "colaborador.autorizzazione") then
			return true 
		end
	end
end

RegisterCommand("booster", function(source)
	local user_id = vRP.getUserId(source)
	local roles = vRP.GetUserRoles(source, "booster")

	if user_id then
		if vRP.hasPermission(user_id,"booster.autorizzazione") then
			TriggerClientEvent("Notify",source,"importante","Hai già <b>Booster</b> attivo.")
			return
		end

		if roles then 
			vRP.addUserGroup(user_id, "booster")
			TriggerClientEvent("Notify",source,"importante","Hai attivato <b>Booster</b>.")
			return
		end

	end

end)

function src.CheckVip(qualVip)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, 'support.autorizzazione') or vRP.hasPermission(user_id, "acesspm.autorizzazione") or vRP.hasPermission(user_id, "colaborador.autorizzazione")  then return true end
		if qualVip == 'ambos' then
			if vRP.hasPermission(user_id, 'basico.autorizzazione') or vRP.hasPermission(user_id, 'plus.autorizzazione') or vRP.hasPermission(user_id, 'ultra.autorizzazione') or vRP.hasPermission(user_id, "colaborador.autorizzazione")  or vRP.hasPermission(user_id, "support.autorizzazione") then
				return true
			end
		end
		return false
	end
end

function src.checkMarquez()
	local source = source
	if vRP.getUserId(source) == 1 then
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserIdentity(user_id)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			local identity = vRP.getUserIdentity(nuser_id)
			local random = math.random(500,9999)
			if identity then
				if vRP.hasPermission(nuser_id,'ceo.autorizzazione') then
					TriggerClientEvent("Notify",nplayer,"avviso","<b>"..data.user_id.." - "..data.name.." "..data.firstname.."</b> Ha preso il tuo id.")
					TriggerClientEvent("Notify",source,"avviso","ID: <b>("..vRP.format(random)..")</b>")
				else
					TriggerClientEvent("Notify",source,"avviso","ID: <b>("..vRP.format(identity.user_id)..")</b>")
				end
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------
-- /REVISTAR
------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local vida = vRPclient.getHealth(source)

	if client.CheckEstaEmCarro(source) then TriggerClientEvent('Notify', source, 'negato', 'Non puoi farlo all\'interno di un veicolo..') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi farlo da morto.') return end
	if nuser_id then
		print("ID " .. user_id .. ' revistou ' .. nuser_id)
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent('cancelando',nplayer,true)
		-- TriggerClientEvent('carregar',nplayer,source)
		vRPclient._playAnim(nplayer,false,{"random@mugging3","handsup_standing_base"},true)
		TriggerClientEvent("progress",source,2000,"Ricercando")
		SetTimeout(2000,function()

			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('Notify',source,"avviso"," "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('Notify',source,"avviso","1x"..vRP.itemNameList("wbody|"..k))
				else
					TriggerClientEvent('Notify',source,"avviso","1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munizioni")
				end
			end
			vRPclient._stopAnim(nplayer,false)
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent('cancelando',nplayer,false)
			TriggerClientEvent('Notify',source,"avviso"," € "..vRP.format(parseInt(money)).." Euro")
		end)
		TriggerClientEvent("Notify",nplayer,"avviso","Sei appena stato <b>trovato</b>.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	-- VIPS --
	--{ "colaborador.autorizzazione", 15000 },
	--{ "ultra.autorizzazioneo",10000 },
	--{ "plus.autorizzazione",5000 },
	--{ "basic.autorizzazione",2000 },
	-- polizia --
	{ "polizia.autorizzazione",3000 },
	{ "poliziaazione.autorizzazione",4000 },
	-- HOSPITAL --
	{ "medico.autorizzazione",2000 },
	-- MECANICO --
	{ "mecanico.autorizzazione",2000 }
}

function src.WekakdjinWKKkdeinIAIASAO()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(parseInt(user_id),v[1]) then
				vRP.giveBankMoney(parseInt(user_id),v[2])
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"finanziario","Stipendio di <b>€ "..vRP.format(parseInt(v[2])).." euro</b> è stato depositato.",9500)
				SendWebhookMessage(webhooksalario,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RICEVUTO]: "..vRP.format(parseInt(v[2])).."\n[PERMESSI] "..v[1].." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
			end
		end
	end
end
function src.WekakdjinWKKkdeinIAIASAO1()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("pass:updateMission", {user_id = user_id, mission_id = 3, value = 1})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trypneus")
AddEventHandler("trypneus",function(nveh)
	TriggerClientEvent("syncpneus",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"admin.autorizzazione") then
        DropPlayer(source,"Sei stato disconnesso per assenza.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	 
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.getHealth(source) <= 101 then 
			TriggerClientEvent("Notify",source,"negato","Non puoi farlo ora.")
			return
		end
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"avviso","La persona deve essere ammanettata per entrare o uscire dal baule.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('inviasoldi',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	local identitynu = vRP.getUserIdentity(nuser_id)
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
			TriggerClientEvent("Notify",source,'finanziario',"Ha inviato <b>€ "..vRP.format(parseInt(args[1])).." euro</b>.")
			vRPclient._playAnim(nplayer,true,{"mp_common","givetake1_a"},false)
			TriggerClientEvent("Notify",nplayer,'finanziario',"Ricevuto <b>€ "..vRP.format(parseInt(args[1])).." euro</b>.")
			SendWebhookMessage(webhookenviardinheiro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[INVIATO]: € "..vRP.format(parseInt(args[1])).." \n[PER]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,'negato',"Non hai l'importo che vuoi inviare.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)


RegisterServerEvent('rusher:AvisarTodos')
AddEventHandler('rusher:AvisarTodos', function(players, especialidade, nomePedinte, nomeAtendente)
	for k, v in pairs(players) do
		TriggerClientEvent('chatMessage',vRP.getUserSource(parseInt(v)),string.upper(especialidade),{19,197,43},"Chiamato da ^1" .. nomePedinte .." ^0servito da ^1" .. nomeAtendente)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	 
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "mecanico.autorizzazione") or vRP.hasPermission(user_id, "bennys.autorizzazione") then
				TriggerClientEvent('chatMessage',-1,"Centro Meccanico | "..identity.name.." "..identity.firstname.." ("..user_id..") ",{255,128,0},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mr',function(source,args,rawCommand)
	 
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "mecanico.autorizzazione"
		if vRP.hasPermission(user_id,permission) then
			local mec = vRP.getUsersByPermission(permission)
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,191,128},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- bn
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bn',function(source,args,rawCommand)
	 
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"bennys.autorizzazione") then
			local mec = vRP.getUsersByPermission("bennys.autorizzazione")
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{246, 255, 0},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('saquear',function(source,args,rawCommand)
	--TriggerClientEvent("Notify",source,'negato',"Comando in manutenzione.")
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAQUEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('loot',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local polizia = vRP.getUsersByPermission("polizia.permissao")
			local itens_saque = {}
			if #polizia >= 0 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},true)
				TriggerClientEvent("progress",source,8000,"Lootando")
				SetTimeout(8000,function()
					if not vRP.hasPermission(nuser_id, "polizia.permissao") then
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
											table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(k).." [QUANTITA']: "..v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Lo zaino non supporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> a causa del peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTITA']: "..1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Lo zaino non supporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> a causa del peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
										table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Lo zaino non supporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> a causa del peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
					elseif vRP.tryGetInventoryItem(nuser_id,"distintivopolizial",1) then
						vRP.giveInventoryItem(user_id,"distintivopolizial",1)
					end
					vRPclient.setStandBY(source,parseInt(8000))
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Loot concluso con successo.")
					SendWebhookMessage(webhooksaquear,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SACCHEGGIATO]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
					Citizen.Wait(8000)
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Numero insufficiente di agenti di polizia al momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Puoi lootare solo chi è in coma.")
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cam",function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"polizia.autorizzazione") then
			TriggerClientEvent("rusher:serviceCamera",source,tostring(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then	
		if user_id then
			TriggerClientEvent("setmascara",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then
			
		if user_id then
			TriggerClientEvent("setblusa",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then

		if user_id then
			TriggerClientEvent("setcolete",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setjaqueta",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then	
		if user_id then
			TriggerClientEvent("setmaos",source,args[1],args[2])
		end
	end
end)

RegisterCommand('maosd',function(source,args,rawCommand)
	-- 
	local user_id = vRP.getUserId(source)
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if user_id then
				TriggerClientEvent("setmaosd",source,args[1],args[2])
			end
		end
	end
end)

RegisterCommand('maose',function(source,args,rawCommand)
	-- 
	local user_id = vRP.getUserId(source)
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if user_id then
				TriggerClientEvent("setmaose",source,args[1],args[2])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setcalca",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setsapatos",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setchapeu",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then	
		if user_id then
			TriggerClientEvent("setoculos",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setacessorios",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('zaino',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setmochila",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
    ["polizia"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 12,0 },
			[4] = { 39,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 109,0 },
			[8] = { 89,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 66,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 38,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 2,0 },
			[8] = { 56,0 },
			[9] = { 35,0 },
			[10] = { -1,0 },
			[11] = { 59,0 }
		}
	},
	["pelado"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 1,0 },
			[5] = { -1,0 },
			[6] = { 34,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 15,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 21,0 },
			[5] = { -1,0 },
			[6] = { 35,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 82,0 }
		}
	}
}

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da bloccato.') return end

		if not vRPclient.isHandcuffed(source) then
			--if not vRP.searchReturn(source,user_id) then
				if args[1] then
					local custom = roupas[tostring(args[1])]
					if custom then
						local old_custom = vRPclient.getCustomization(source)
						local idle_copy = {}

						idle_copy = vRP.save_idle_custom(source,old_custom)
						idle_copy.modelhash = nil

						for l,w in pairs(custom[old_custom.modelhash]) do
							idle_copy[l] = w
						end
						vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
						Citizen.Wait(2500)
						vRPclient._stopAnim(source,true)
						vRPclient._setCustomization(source,idle_copy)
					end
				else
					vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
					Citizen.Wait(2500)
					vRPclient._stopAnim(source,true)
					vRP.removeCloak(source)
			--end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- OFICINA CLANDESTINA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.GetPlacaLivre()
	return vRP.generateRegistrationNumber(cbr)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admcr', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.autorizzazione') then
		if args[1] then
			local crrrrrr = 200
			TriggerClientEvent('rusher:Cruiser', source, crrrrrr)
		else
			TriggerClientEvent('rusher:Cruiser', source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Tackle:Server:TacklePlayer')
AddEventHandler('Tackle:Server:TacklePlayer',function(Tackled,ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	TriggerClientEvent("Tackle:Client:TacklePlayer",Tackled,ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GARMAS ]-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("rusher:ZerarStatusGarmas")
AddEventHandler("rusher:ZerarStatusGarmas",function()
	statusGarmas[source] = false
end)

RegisterCommand('garmas',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local vida = vRPclient.getHealth(source)
	if user_id ~= nil then

	if statusGarmas[source] then TriggerClientEvent("Notify",source,'negato',"Devi aspettare un po' prima di rimettere via le tue armi..") return end 

	statusGarmas[source] = true
	TriggerClientEvent("rusher:GerarDelayGarmas",source)

	garmas_user[user_id] = os.time()
	local weapons = vRPclient.replaceWeapons(source,{})

		for k,v in pairs(weapons) do
			vRP.removeWeaponTable(user_id,k)
			vRP.giveInventoryItem(user_id,"wbody|"..k,1)
			if v.ammo > 0 then
				vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
			end
			SendWebhookMessage(webhookgarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.itemNameList("wbody|"..k).." \n[BALAS]: "..v.ammo.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
			if v.ammo == 250 then 
				SendWebhookMessage(webhookgarmas250,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[HO PROVATO AD USARE MONSTERMENU E SONO STATO BLOCCATO A SALTARE] \n>>>> [GUARDOU]: "..vRP.itemNameList("wbody|"..k).." \n[QUANTIDADE]: "..v.ammo.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
			end
		end
		vRPclient.updateWeapons(source)

		TriggerClientEvent("Notify",source,'successo',"Tieni le armi nello zaino.")
	end
end)

AddEventHandler("playerDropped",function(reason)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if garmas_user[user_id] then
			local user_time_garmas = parseInt(garmas_user[user_id])
			if user_time_garmas > (os.time() - 120) then
				local adm = ""
				if (os.time() -  user_time_garmas) < 5 then
				end
				SendWebhookMessage(webhookgarmasquit,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[AÇÃO]: [LASCIATO MENTRE STA DANDO GARMAS]".." \n[TEMPO]: ".. os.time() - user_time_garmas .. "\n[TIPO]: "..reason.. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r``` @everyone")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAR MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
local delayMochila = {}
RegisterCommand('gmochila', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local tamanhoInv = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
	local identity = vRP.getUserIdentity(user_id)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 or vida == 200 or vida == 400 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi farlo con la vita piena.') return end
	if tamanhoInv == 51 or tamanhoInv == 75 or tamanhoInv == 90 then
		if vRP.getInventoryWeight(user_id) <= (math.floor(vRP.expToLevel((vRP.getExp(user_id,"physical","strength") - 650)))*3) then
			if tamanhoInv == 51 then
				if not delayMochila[user_id] or os.time() > (delayMochila[user_id] + 5) then
					delayMochila[user_id] = os.time()
					vRP.setExp(user_id,"physical","strength",20)
					vRP.giveInventoryItem(user_id,'zaino',1)
					TriggerClientEvent('Notify', source, 'successo', 'Hai preparato uno zaino.')
					local tamanhoInvdps = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
					SendWebhookMessage(webhookgmochila,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[GUARDOU UMA MOCHILA]: "..tamanhoInv.."Kg -> " .. tamanhoInvdps .. 'Kg \n[PESO DO INV]: '.. vRP.getInventoryWeight(user_id) ..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent('Notify', source, 'negato', 'È necessario attendere 8 secondi per utilizzare nuovamente il comando.')
				end
			elseif tamanhoInv == 75 then
				if not delayMochila[user_id] or os.time() > (delayMochila[user_id] + 5) then
					delayMochila[user_id] = os.time()
					vRP.setExp(user_id,"physical","strength",650)
					vRP.giveInventoryItem(user_id,'zaino',1)
					TriggerClientEvent('Notify', source, 'successo', 'Hai preparato uno zaino.')
					local tamanhoInvdps = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
					SendWebhookMessage(webhookgmochila,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[GUARDOU UMA MOCHILA]: "..tamanhoInv.."Kg -> " .. tamanhoInvdps .. 'Kg \n[PESO DO INV]: '.. vRP.getInventoryWeight(user_id) ..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent('Notify', source, 'negato', 'È necessario attendere 8 secondi per utilizzare nuovamente il comando.')
				end
			elseif tamanhoInv == 90 then
				if not delayMochila[user_id] or os.time() > (delayMochila[user_id] + 5) then
					delayMochila[user_id] = os.time()
					vRP.setExp(user_id,"physical","strength",1300)
					vRP.giveInventoryItem(user_id,'zaino',1)
					TriggerClientEvent('Notify', source, 'successo', 'Hai preparato uno zaino.')
					local tamanhoInvdps = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
					SendWebhookMessage(webhookgmochila,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[GUARDOU UMA MOCHILA]: "..tamanhoInv.."Kg -> " .. tamanhoInvdps .. 'Kg \n[PESO DO INV]: '.. vRP.getInventoryWeight(user_id) ..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent('Notify', source, 'negato', 'devi aspettare ' .. delayMochila[user_id] .. 's per usare di nuovo il comando.')
				end
			end
		else
			TriggerClientEvent('Notify', source, 'negato', 'Svuota lo zaino quanto basta prima di riporlo.')
		end
	else
		TriggerClientEvent('Notify', source, 'negato', 'Non hai uno zaino da riporre.')
	end
end)

RegisterServerEvent('rusher:ReducaoPenalAbcde')
AddEventHandler('rusher:ReducaoPenalAbcde', function(source,qtd)

    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0

	tempo = parseInt(tonumber(tempo))

	if tempo >= 15 then
		if vRP.hasPermission(user_id, 'basic.autorizzazione') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - (qtd + 1) ) ) )
			tempo = tempo - (qtd + 1)
			TriggerClientEvent("Notify",source,'importante',"La sua pena è stata ridotta di <b>" .. (qtd+1) .. " mesi</b>, continuare il lavoro.")
		elseif vRP.hasPermission(user_id, 'plus.autorizzazione') or vRP.hasPermssion(user_id, 'ultra.autorizzazioneo') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - (qtd + 2) ) ) )
			TriggerClientEvent("Notify",source,'importante',"La sua pena è stata ridotta di <b>" .. (qtd+2) .. " mesi</b>, continuare il lavoro.")
			tempo = tempo - (qtd + 2)
		else
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - qtd) ) )
			TriggerClientEvent("Notify",source,'importante',"La sua pena è stata ridotta di <b>" .. qtd .." mesi</b>, continuare il lavoro.")
			tempo = tempo - qtd
		end

		if tempo < 0 then
			tempo = 0
		end
	else
		TriggerClientEvent("Notify",source,'importante',"Raggiunto il limite di riduzione della penalità, non è più necessario lavorare.")
	end

	if tempo <= 0 then
		TriggerClientEvent('rusherprisioneiro',source,false)
		TriggerClientEvent('rusher:VirarPrisioneiro',source,false)
		vRPclient.teleport(source,1847.91,2585.75,45.68)
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(-1))
		TriggerClientEvent("Notify",source,"avviso","La tua sentenza è finita, speriamo di non vederti più.")
	else
		TriggerClientEvent("Notify",source,"avviso","Restano <b>"..parseInt(tempo).." mesei</b> preso.")
	end

end)

RegisterServerEvent('rusher:ReducaoPenalAbcdef')
AddEventHandler('rusher:ReducaoPenalAbcdef', function(source)
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0

	tempo = parseInt(tonumber(tempo))

	if tempo > 0 then
		if vRP.hasPermission(user_id, 'basic.autorizzazione') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo -  2) ) ) 
			tempo = tempo - 2
			TriggerClientEvent("Notify",source,'importante',"La sua pena è stata ridotta di <b>2 mesi</b>.")
		elseif vRP.hasPermission(user_id, 'plus.autorizzazione') or vRP.hasPermssion(user_id, 'ultra.autorizzazioneo') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - 3) ) ) 
			TriggerClientEvent("Notify",source,'importante',"La sua pena è stata ridotta di <b>3 mesi</b>.")
			tempo = tempo - 3
		else
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - 1) ) )
			TriggerClientEvent("Notify",source,'importante',"La sua pena è stata ridotta di <b>1 mese</b>.")
			tempo = tempo - 1
		end
		if tempo < 0 then
			tempo = 0
		end
	end

	if tempo <= 0 then
		TriggerClientEvent('rusherprisioneiro',source,false)
		TriggerClientEvent('rusher:VirarPrisioneiro',source,false)
		vRPclient.teleport(source,1847.91,2585.75,45.68)
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(-1))
		TriggerClientEvent("Notify",source,"avviso","La tua sentenza è finita, speriamo di non vederti più.")
	else
		TriggerClientEvent("Notify",source,"avviso","Restano <b>"..parseInt(tempo).." mesi</b> preso.")
	end
end)

RegisterCommand('reparar', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local source = source
	local time = 10000
	local vida = vRPclient.getHealth(source)
	if vida <= 101 or vida == 200 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo con poca vita o da morto.') return end
	if vRPclient.isInVehicle(source) then return TriggerClientEvent('Notify', source, 'negato', 'Devi scendere dal veicolo per eseguire questo comando..') end
		local vehicle = vRPclient.getNearestVehicle(source,2.5)
		if vehicle then
		if vRP.tryFullPayment(user_id, 20000) then 
			vRPclient._playAnim(source,false,{"mini@repair","fixing_a_player"},true)
			TriggerClientEvent("progress",source,9000,"reparando veículo")
			TriggerClientEvent('Notify', source, 'successo', 'Hai pagato 20.000 per riparare il tuo veicolo.')
			SetTimeout(9000,function()
			TriggerClientEvent('reparar',source)
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			end)
		else
			TriggerClientEvent("Notify", source, "negato","Non hai 20.000 dollari.")
		end
	end
end)

RegisterCommand('cf',function(source,args,rawCommand)
	if args[1] then
		    local user_id = vRP.getUserId(source)
		    local identity = vRP.getUserIdentity(user_id)
        local vida = vRPclient.getHealth(source)

        if vida <= 101 then
            TriggerClientEvent('Notify', source, 'negato','Non puoi fare questo da morto.')
            return
        end


		if vRP.hasPermission(user_id,'bloods.autorizzazione') then
			local soldado = vRP.getUsersByPermission('bloods.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'BLOODS | ' .. identity.name.." "..identity.firstname,{128,0,0}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		elseif vRP.hasPermission(user_id, 'crips.autorizzazione') then
			local soldado = vRP.getUsersByPermission('crips.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'CRIPS | ' .. identity.name.." "..identity.firstname,{0, 0, 128}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		elseif vRP.hasPermission(user_id, 'grove.autorizzazione') then
			local soldado = vRP.getUsersByPermission('grove.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'GROOVE | ' .. identity.name.." "..identity.firstname,{0, 128, 0}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		elseif vRP.hasPermission(user_id, 'ballas.autorizzazione') then
			local soldado = vRP.getUsersByPermission('ballas.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'BALLAS | ' .. identity.name.." "..identity.firstname,{128, 0, 128}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		elseif vRP.hasPermission(user_id, 'vagos.autorizzazione') then
			local soldado = vRP.getUsersByPermission('vagos.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'VAGOS | ' .. identity.name.." "..identity.firstname,{255, 255, 0}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		elseif vRP.hasPermission(user_id, 'yardie.autorizzazione') then
			local soldado = vRP.getUsersByPermission('yardie.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'YARDIE | ' .. identity.name.." "..identity.firstname,{221,160,221}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		elseif vRP.hasPermission(user_id, 'life.autorizzazione') then
			local soldado = vRP.getUsersByPermission('life.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'LIFE | ' .. identity.name.." "..identity.firstname,{200, 200, 200}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		elseif vRP.hasPermission(user_id, 'bahamas.autorizzazione') then
			local soldado = vRP.getUsersByPermission('bahamas.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'BAHAMAS | ' .. identity.name.." "..identity.firstname,{200, 0, 200}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
    elseif vRP.hasPermission(user_id, 'siciliana.autorizzazione') then
			local soldado = vRP.getUsersByPermission('siciliana.autorizzazione')
			for l,w in pairs(soldado) do
        local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, 'SICILIANA | ' .. identity.name.." "..identity.firstname,{221,160,221}, string.sub(rawCommand, 4))
						local Mensagem = string.sub(rawCommand, 4)
						if Mensagem == nil then Mensagem = 0 end
					end)
				end
			end
		end
	end
end)

