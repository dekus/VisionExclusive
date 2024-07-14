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
Tunnel.bindInterface("vrp_polizia",src)
vCLIENT = Tunnel.getInterface("vrp_polizia")
rusher = {}
Tunnel.bindInterface("vrp_polizia", rusher)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDGENS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookocorrenciassul = "https://discord.com/api/webhooks/1131630444518064228/euf5sQOWXrzsijTk5ramsSwEHQQY4v1KMw-QLretO_XOx2mrhtbWLMtWeCPluH0wKGYf"

--local webhookdetidosul = "https://discord.com/api/webhooks/961686402083459192/Vsk_I3yj6o37WEUyv6EEPL4qXevvLehMRvpjFSYFAWkZXi93Q1YsYpS9s2OOUE7DL0qf"
--local webhookdetidoadm = ""

local webhookpolizia = "https://discord.com/api/webhooks/1131630596850978977/gW9ThgfKSrspFvkwkD5GQymtA0khBfRcDNBCS8Vzn6fXhSicakbwykrlCvsP2qkO7N_X" --polizia sul

local webhookpoliziaapreendidos = "https://discord.com/api/webhooks/1131630733212008578/pocNo29-tRFVHEyT2f0Ky8M5OXjrMnI3fj6OAv9F64PxWj336XAr57mi3mZhHf_X-TD-"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
local plateOne = {
	[1] = { "Dylan" },
	[2] = { "Adam" },
	[3] = { "Alan" },
	[4] = { "Alvin" },
	[5] = { "Andrew" },
	[6] = { "Antony" },
	[7] = { "Arnold" },
	[8] = { "Bernard" },
	[9] = { "Bryan" },
	[10] = { "Calvin" },
	[11] = { "Charlie" },
	[12] = { "David" },
	[13] = { "Edward" },
	[14] = { "Enrico" },
	[15] = { "Eric" },
	[16] = { "Tom" },
	[17] = { "Oliver" },
	[18] = { "Patrick" },
	[19] = { "Richard" },
	[20] = { "Robert" },
	[21] = { "Ashley" },
	[22] = { "Adele" },
	[23] = { "Agnella" },
	[24] = { "Darla" },
	[25] = { "Emily" },
	[26] = { "Emma" },
	[27] = { "Francine" },
	[28] = { "Karolyn" },
	[29] = { "Katelyn" },
	[30] = { "Katherine" },
	[31] = { "Katie" },
	[32] = { "Mary" },
	[33] = { "Melanie" },
	[34] = { "Micheline" },
	[35] = { "Natalie" },
	[36] = { "Sophie" },
	[37] = { "Stephanie" },
	[38] = { "Susan" },
	[39] = { "Valerie" },
	[40] = { "Wendy" }
}

local plateTwo = {
	[1] = { "Wright" },
	[2] = { "Smith" },
	[3] = { "Johnson" },
	[4] = { "Williams" },
	[5] = { "Jones" },
	[6] = { "Scott" },
	[7] = { "Hall" },
	[8] = { "Adams" },
	[9] = { "Carter" },
	[10] = { "Mitchell" },
	[11] = { "Parker" },
	[12] = { "Evans" },
	[13] = { "Edwards" },
	[14] = { "Collins" },
	[15] = { "Stewart" },
	[16] = { "Morris" },
	[17] = { "Reed" },
	[18] = { "Moore" },
	[19] = { "Cooper" },
	[20] = { "Taylor" },
	[21] = { "Jackson" },
	[22] = { "White" },
	[23] = { "Harris" },
	[24] = { "Thompson" },
	[25] = { "Martinez" },
	[26] = { "Torres" },
	[27] = { "Watson" },
	[28] = { "Sanders" },
	[29] = { "Bennett" },
	[30] = { "Lee" },
	[31] = { "Baker" },
	[32] = { "Barnes" },
	[33] = { "Ross" },
	[34] = { "Jenkins" },
	[35] = { "Perry" },
	[36] = { "Patterson" },
	[37] = { "Hughes" },
	[38] = { "Simmons" },
	[39] = { "Foster" },
	[40] = { "Gonzalez" }
}

RegisterCommand('placa',function(source,args,rawCommand)
	 

	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi farlo da morto.') return end
	if vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id,"mod.autorizzazione") or vRP.hasPermission(user_id,"polizia.autorizzazione")  then
		if args[1] then
			local user_id = vRP.getUserByRegistration(args[1])
			if user_id then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent("Notify",source,"importante","<b>Passaporto: </b>"..identity.user_id.."<br><b>Documentazione: </b>"..identity.registration.."<br><b>Proprietario: </b>"..identity.name.." "..identity.firstname.."<br><b>Età: </b>"..identity.age.." Anni<br><b>Telefono: </b>"..identity.phone,10000)
				end
			else
				vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"importante","<b>Passaporto: </b>"..vRP.format(parseInt(math.random(5000,9999))).."<br><b>Documentazione: </b>"..args[1].."<br><b>Proprietario: </b>"..plateOne[math.random(#plateOne)][1].." "..plateTwo[math.random(#plateTwo)][1].."<br><b>Telefono: </b>"..vRP.generatePhoneNumber(),10000)
			end
		else
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			local placa_user_id = vRP.getUserByRegistration(placa)
			if placa_user_id then
				local identity = vRP.getUserIdentity(placa_user_id)
				if identity then
					local vehicleName = vRP.vehicleName(vname)
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent("Notify",source,"importante","<b>Passaporto: </b>"..identity.user_id.."<br><b>Documentazione: </b>"..identity.registration.."<br><b>Proprietario: </b>"..identity.name.." "..identity.firstname.."<br><b>Modello: </b>"..vehicleName.."<br><b>Età: </b>"..identity.age.." anos<br><b>Telefono: </b>"..identity.phone,10000)
				end
			else
				vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"importante","<b>Passaporto: </b>"..vRP.format(parseInt(math.random(5000,9999))).."<br><b>Documentazione: </b>"..placa.."<br><b>Proprietario: </b>"..plateOne[math.random(#plateOne)][1].." "..plateTwo[math.random(#plateTwo)][1].."<br><b>Telefono: </b>"..vRP.generatePhoneNumber(),10000)
			end
		end
	end
end)

RegisterCommand('ptr', function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("polizia.autorizzazione")
	local poliziais = 0
	local oficiais_nomes = ""
	if vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id,"mod.autorizzazione") then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			poliziais = poliziais + 1
			end
			--TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..poliziais.." Oficiais</b> em serviço.")
			if parseInt(poliziais) > 0 then
				
				TriggerClientEvent("Notify",source,"importante","Attualmente <b>"..poliziais.." Officiali</b> In servizio.<br><br>".. oficiais_nomes)
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ T2 ]----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptr2', function(source,args,rawCommand)
	 
   local user_id = vRP.getUserId(source)
   local player = vRP.getUserSource(user_id)
   local oficiais = vRP.getUsersByPermission("poliziaazione.autorizzazione")
   local poliziais = 0
   local oficiais_nomes = ""
   if vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id,"mod.autorizzazione")  then
	   for k,v in ipairs(oficiais) do
		   local identity = vRP.getUserIdentity(parseInt(v))
		   oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
		   poliziais = poliziais + 1
	   		end
	   		if parseInt(poliziais) > 0 then
				TriggerClientEvent("Notify",source,"importante","Attualmente <b>"..poliziais.." Officiali</b> In azione.<br><br>".. oficiais_nomes)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /p
-----------------------------------------------------------------------------------------------------------------------------------------
local polizia = {}
local acaopolizia = {}
local paramedico = {}
RegisterServerEvent('rusher:1020Police')
AddEventHandler('rusher:1020Police',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) then
		return
	end
	if vRP.hasPermission(user_id,"polizia.autorizzazione") then
		local polizia = vRP.getUsersByPermission("polizia.autorizzazione") 
		for l,w in pairs(polizia) do
			local npolizia = vRP.getUserSource(parseInt(w))
			if npolizia and npolizia ~= uplayer then
				async(function()
					local id = idgens:gen()
					polizia[id] = vRPclient.addBlip(npolizia,x,y,z,153,84,"posizione di "..identity.name.." "..identity.firstname,0.5,false)
					TriggerClientEvent("Notify",npolizia,"importante","Importante","Posizione ricevuta da <b>"..identity.name.." "..identity.firstname.."</b>.")
					vRPclient._playSound(npolizia,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					SetTimeout(60000,function() vRPclient.removeBlip(npolizia,polizia[id]) idgens:free(id) end)
				end)
			end
		end
		TriggerClientEvent("Notify",source,"successo","Posizione inviata con successo.")
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "polizia.autorizzazione") then
				TriggerClientEvent('chatMessage',-1,"VPD | "..identity.name.." "..identity.firstname..": ",{65,130,255},rawCommand:sub(4))
			end
		end
	end
end)

RegisterCommand('interdetto',function(source)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id, "polizia.autorizzazione") then
			local acao = vRP.prompt(source, 'Immettere il nome dell\'azione:', '')
			if acao ~= '' then
				TriggerClientEvent('chatMessage',-1,"10-76",{105,170,255},'Civico Interdetto: '..acao..'')
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /PD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pd',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "chatpolizia.autorizzazione"
		local vida = vRPclient.getHealth(source)

		if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
		if vRP.hasPermission(user_id,permission,permission2) then
			local soldado = vRP.getUsersByPermission(permission,permission2)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
					--	TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{64,179,255},string.sub(rawCommand, 4))
						TriggerClientEvent('chatMessage',player,"CENTRALE | "..identity.name.." "..identity.firstname.." (#"..identity.user_id..")",{64,179,255},string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[CHAT POLIZIA]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle',function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local funcionais = vRP.getInventoryItemAmount(user_id,'funcionalpol')


	if vRP.hasPermission(user_id,"polizia.autorizzazione") then
		if funcionais > 0 then
			vRP.tryGetInventoryItem(user_id,'funcionalpol',funcionais)
		end
		TriggerEvent("vrp_blipsystem:serviceExit",source)
		vRP.addUserGroup(user_id,"paisanapolizia")
		--vRP.DelSetpolizia(user_id)
		TriggerClientEvent("Notify",source,'avviso',"Sei andato fuori servizio.")
		SendWebhookMessage(webhookpolizia,"```prolog\n[poliziaL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========USCITO DAL SERVIZIO==========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		--TriggerClientEvent('desligarRadios',source)

	elseif vRP.hasPermission(user_id,"paisanapolizia.autorizzazione") then
				
			if funcionais <= 0 then
				vRP.giveInventoryItem(user_id,'funcionalpol',1)
			end
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"polizial",51)
			vRP.addUserGroup(user_id,"polizia")
			TriggerClientEvent('Notify', source, 'avviso', 'Sei entrato in servizio come ufficiale <b>Polizia</b>.')
			SendWebhookMessage(webhookpolizia,"```prolog\n[poliziaL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTRATO IN SERVIZIO=========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		--end

	elseif vRP.hasPermission(user_id,"medico.autorizzazione") then
		TriggerEvent("vrp_blipsystem:serviceExit",source)
		vRP.addUserGroup(user_id,"paisanamedico")
		TriggerClientEvent("Notify",source,'avviso',"Sei andato fuori servizio.")
		SendWebhookMessage(webhookmedicosul,"```prolog\n[MEDICO SUL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========USCITO DAL SERVIZIO==========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"paisanamedico.autorizzazione") then
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Medico Sul",61)
		vRP.addUserGroup(user_id,"medico")
		TriggerClientEvent("Notify",source,'successo',"Sei entrato in servizio.")
		SendWebhookMessage(webhookmedicosul,"```prolog\n[MEDICO SUL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTRATO IN SERVIZIO=========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")


	elseif vRP.hasPermission(user_id,"mecanico.autorizzazione") then
		vRP.addUserGroup(user_id,"paisanamecanico")
		TriggerClientEvent("Notify",source,'avviso',"Sei andato fuori servizio.")
		SendWebhookMessage(webhookmecanico,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========USCITO DAL SERVIZIO==========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"paisanamecanico.autorizzazione") then
		vRP.addUserGroup(user_id,"mecanico")
		TriggerClientEvent("Notify",source,'successo',"Sei entrato in servizio.")
		SendWebhookMessage(webhookmecanico,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTRATO IN SERVIZIO=========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle2',function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local funcionais = vRP.getInventoryItemAmount(user_id,'funcionalpol')

	if vRP.hasPermission(user_id,"polizia.autorizzazione") then

		if funcionais <= 0 then
			vRP.giveInventoryItem(user_id,'funcionalpol',1)
		end
		vRP.addUserGroup(user_id,"poliziaazione")
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"polizial",25)
		TriggerClientEvent("toogle:police",source,true)
		TriggerClientEvent("Notify",source,'avviso',"Sei entrato in azioneo.")
		SendWebhookMessage(webhookpolizia,"```prolog\n[poliziaL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========ENTRATO IN AZIONE==========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")

	elseif vRP.hasPermission(user_id,"poliziaazione.autorizzazione") then
			if funcionais > 0 then
				vRP.tryGetInventoryItem(user_id,'funcionalpol',funcionais)
			end
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"polizial",25)
			vRP.addUserGroup(user_id,"polizia")
			TriggerClientEvent("toogle:police",source,false)
			TriggerClientEvent("Notify",source,'avviso',"Hai lasciato l'azione.")
			SendWebhookMessage(webhookpolizia,"```prolog\n[poliziaL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========USCITO DALL'AZIONE=========] "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		--end
	end
end)

RegisterCommand('detido',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
    if vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"poliziaazione.autorizzazione") then
        local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,5)
        local motivo = vRP.prompt(source,"Motivo:","")
        if motivo == "" then
			return
		end
		local oficialid = vRP.getUserIdentity(user_id)
        if vehicle then
            local puser_id = vRP.getUserByRegistration(placa)
            local rows = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
            if rows[1] then
                if parseInt(rows[1].detido) == 1 then
					if vRP.request(source, 'Questo veicolo è già sequestrato, vuoi liberarlo?', 30) then
						local identity = vRP.getUserIdentity(puser_id)
						local nplayer = vRP.getUserSource(parseInt(puser_id))
						SendWebhookMessage(webhookdetidosul,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============TIROU DA DETENÇÃO==============] \n[CARRO]: "..vname.." \n[PASSAPORTE]: "..puser_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
						SendWebhookMessage(webhookdetidoadm,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============TIROU DA DETENÇÃO==============] \n[CARRO]: "..vname.." \n[PASSAPORTE]: "..puser_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
						vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 0, time = 0 })

						TriggerClientEvent("Notify",source,'successo',"CAuto rilasciata con successo.")
						TriggerClientEvent("Notify",nplayer,"importante","Il tuo veicolo e <b>RILASCIATO</b>.<br><b>Motivo:</b> "..motivo..".")
						vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
					end
                else
                	local identity = vRP.getUserIdentity(puser_id)
                	local nplayer = vRP.getUserSource(parseInt(puser_id))
                	SendWebhookMessage(webhookdetidosul,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[CARRO]: "..vname.." \n[PASSAPORTE]: "..puser_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
                	SendWebhookMessage(webhookdetidoadm,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[CARRO]: "..vname.." \n[PASSAPORTE]: "..puser_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
                    vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })

					randmoney = math.random(300,600)
					vRP.giveMoney(user_id,parseInt(randmoney))
					TriggerClientEvent("Notify",source,'successo',"Auto sequestrata con successo.")
					TriggerClientEvent("Notify",source,'importante',"Importante","Hai ricevuto <b>€ "..vRP.format(parseInt(randmoney)).." euro</b> di bonifico.")
					TriggerClientEvent("Notify",nplayer,"importante","Il tuo veicolo e <b>DETENUTO</b>.<br><b>Motivo:</b> "..motivo..".")
					vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
                end
            end
        end
    end
end)
RegisterCommand('pvp',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.autorizzazione") then
      vRPclient.giveWeapons(source,{["WEAPON_PISTOL_MK2"] = { ammo = 250 }})
      vRPclient.giveWeapons(source,{["WEAPON_SPECIALCARBINE_MK2"] = { ammo = 250 }})
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rg",function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"support.autorizzazione") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer == nil then
					TriggerClientEvent("Notify",source,"avviso","Passaporto <b>"..vRP.format(args[1]).."</b> attualmente non disponibile.")
					return
				end
				local nuser_id = parseInt(args[1])
				local identity = vRP.getUserIdentity(nuser_id)
				if identity then
					local fines = vRP.getUData(nuser_id,"vRP:multas")
					local price = json.decode(fines) or 0
					local cash = vRP.getMoney(nuser_id)
					
					if vRP.hasPermission(nuser_id,"ceo.autorizzazione") then
						local rusher = math.random(500,7000)
						TriggerClientEvent("Notify",source,"importante","<b>Passaporto:</b> "..vRP.format(tostring(rusher)).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefono:</b> "..identity.phone.."<br><b>Portafoglio:</b> € "..vRP.format(parseInt(cash)).."<br><b>Multe da pagare:</b> € "..vRP.format(parseInt(price)),20000)
					else
						TriggerClientEvent("Notify",source,"importante","<b>Passaporto:</b> "..vRP.format(identity.user_id).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefono:</b> "..identity.phone.."<br><b>Portafoglio:</b> € "..vRP.format(parseInt(cash)).."<br><b>Multe da pagare:</b> € "..vRP.format(parseInt(price)),20000)
					end
					
				end
			else
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						local identity = vRP.getUserIdentity(nuser_id)
						local data = vRP.getUserIdentity(user_id)
						if identity then
							local fines = vRP.getUData(nuser_id,"vRP:multas")
							local price = json.decode(fines) or 0
							local cash = vRP.getMoney(nuser_id)
							if vRP.hasPermission(nuser_id,"ceo.autorizzazione") then
								local rusher = math.random(500,7000)
								TriggerClientEvent("Notify",nplayer,"avviso","Il tuo documento è in fase di verifica da parte di <b>"..data.name.." "..data.firstname.."</b>.")
								TriggerClientEvent("Notify",source,"importante","<b>Passaporto:</b> "..vRP.format(tostring(rusher)).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefono:</b> "..identity.phone.."<br><b>Portafoglio:</b> € "..vRP.format(parseInt(cash)).."<br><b>Multe da pagare:</b> € "..vRP.format(parseInt(price)),20000)
							else
								TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..vRP.format(identity.user_id).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefono:</b> "..identity.phone.."<br><b>Portafoglio:</b> € "..vRP.format(parseInt(cash)).."<br><b>Multe da pagare:</b> € "..vRP.format(parseInt(price)),20000)
								TriggerClientEvent("Notify",nplayer,"avviso","Il tuo documento è in fase di verifica da parte di <b>"..data.name.." "..data.firstname.."</b>.")
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('manette',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if not vRPclient.isHandcuffed(source) then
			if vRP.getInventoryItemAmount(user_id,"algemas") >= 1 then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient._playAnim(source,false,{"mp_arresting","a_uncuff"},false)
					SetTimeout(5000,function()
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
						TriggerClientEvent('removealgemas',nplayer)
					end)
				else
					TriggerClientEvent("cancelando",source,true)
					TriggerClientEvent('cancelando',nplayer,true)
					vRPclient._playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)
					vRPclient._playAnim(nplayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent("cancelando",source,false)
						TriggerClientEvent("cancelando",nplayer,false)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
						TriggerClientEvent('setalgemas',nplayer)
					end)
				end
			else
				if vRP.hasPermission(user_id,"support.autorizzazione") or vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"poliziaazione.autorizzazione")  then	
					if vRPclient.isHandcuffed(nplayer) then
						vRPclient._playAnim(source,false,{"mp_arresting","a_uncuff"},false)
						SetTimeout(5000,function()
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
							TriggerClientEvent('removealgemas',nplayer)
						end)
					else
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent('cancelando',nplayer,true)
						vRPclient._playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)
						vRPclient._playAnim(nplayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
						SetTimeout(3500,function()
							vRPclient._stopAnim(source,false)
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent("cancelando",source,false)
							TriggerClientEvent("cancelando",nplayer,false)
							TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
							TriggerClientEvent('setalgemas',nplayer)
						end)
					end
				end
			end
		end
	end
end)

function rusher.toggle()
    local user_id = vRP.getUserId(source)
	if user_id then 
    	if vRP.hasPermission(user_id, 'poliziaazione.autorizzazione') then 
			if vRPclient.CheckSegundosMorto(source) > 5 then
				if vRPclient.isInComa(source) then
					vRPclient.SetSegundosMorto(source, 5 ) 
				end
			end
		end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('trascina',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRP.hasPermission(user_id,"support.autorizzazione") or vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"poliziaazione.autorizzazione") or vRP.hasPermission(user_id,"medico.autorizzazione") then	
		if nplayer then
			if not vRPclient.isHandcuffed(source) then
				vCLIENT.CarregarDif(nplayer,source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_polizia:carregaradm")
AddEventHandler("vrp_polizia:carregaradm",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRP.hasPermission(user_id,"admin.autorizzazione") or vRP.hasPermission(user_id,"mod.autorizzazione")  or vRP.hasPermission(user_id,"support.autorizzazione") then
		if nplayer then
			if not vRPclient.isHandcuffed(source) then
				TriggerClientEvent('carregar',nplayer,source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cv',function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 and not vRPclient.isHandcuffed(source) then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if vRP.hasPermission(user_id,"mod.autorizzazione") or vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"poliziaazione.autorizzazione") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vCLIENT.putVehicle(nplayer,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rv',function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 and not vRPclient.isHandcuffed(source) then TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo da morto.') return end
	if vRP.hasPermission(user_id,"mod.autorizzazione") or vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"poliziaazione.autorizzazione") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"denarosporco",
	"algemas",
	"lockpick",
	"capuz",
	"placa",
	"c4",
	"canabidinol",
	"pecadearma",
	"candeggina",
	"candegginamodificata",
	"materialmunicao",
	"pseudoefedrina",
	"eter",
	"anfetamina",
	"krokodil",
	"k9",
	"querosene",
	"baseado",
	"folhademaconha",
	"maconhamacerada",
	"pecadominacao",
	"lancaperfume",
	"materialmunicao",
	"fertilizante",
	"adubo",
	"molas",
	"placa-metal",
	"gatilho",
	"capsulas",
	"polvora",
	"cordas",
	"material9mm",
	"material762",
	"capsula9mm",
	"capsula762",
	"polvora762",
	"polvora9mm",
	"armacaodearma",

	"wbody|WEAPON_DAGGER",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_BOTTLE",
	"wbody|WEAPON_CROWBAR",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_GOLFCLUB",
	"wbody|WEAPON_HAMMER",
	"wbody|WEAPON_HATCHET",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_KNIFE",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_WRENCH",
	"wbody|WEAPON_BATTLEAXE",
	"wbody|WEAPON_POOLCUE",
	--"wbody|WEAPON_STONE_HATCHET",
	"wbody|WEAPON_PISTOL",
	"wbody|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_SAWNOFFSHOTGUN",
	"wbody|WEAPON_PUMPSHOTGUN",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_SNSPISTOL",
	"wbody|WEAPON_SPECIALCARBINE_MK2",
	"wbody|WEAPON_ASSAULTRIFLE_MK2",
	"wbody|WEAPON_FIREEXTINGUISHER",
	"wbody|WEAPON_FLARE",
	"wbody|WEAPON_HEAVYPISTOL",
	"wbody|WEAPON_PISTOL_MK2",
	"wbody|WEAPON_VINTAGEPISTOL",
	"wbody|WEAPON_MUSKET",
	"wbody|WEAPON_GUSENBERG",
	"wbody|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_COMBATPDW",
	"wbody|WEAPON_COMPACTRIFLE",
	"wbody|WEAPON_CARBINERIFLE_MK2",
 	"wbody|WEAPON_MACHINEPISTOL",
	"wbody|WEAPON_SMG_MK2",
	"wammo|WEAPON_DAGGER",
	"wammo|WEAPON_BAT",
	"wammo|WEAPON_BOTTLE",
	"wammo|WEAPON_CROWBAR",
	"wammo|WEAPON_FLASHLIGHT",
	"wammo|WEAPON_GOLFCLUB",
	"wammo|WEAPON_HAMMER",
	"wammo|WEAPON_HATCHET",
	"wammo|WEAPON_KNUCKLE",
	"wammo|WEAPON_KNIFE",
	"wammo|WEAPON_MACHETE",
	"wammo|WEAPON_SWITCHBLADE",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_WRENCH",
	"wammo|WEAPON_BATTLEAXE",
	"wammo|WEAPON_POOLCUE",
	--"wammo|WEAPON_STONE_HATCHET",
	"wammo|WEAPON_PISTOL",
	"wammo|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_SAWNOFFSHOTGUN",
	"wammo|WEAPON_SPECIALCARBINE_MK2",
	"wammo|WEAPON_PUMPSHOTGUN",
	"wammo|WEAPON_STUNGUN",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_SNSPISTOL",
	"wammo|WEAPON_MICROSMG",
	"wammo|WEAPON_ASSAULTRIFLE_MK2",
	"wammo|WEAPON_FIREEXTINGUISHER",
	"wammo|WEAPON_FLARE",
	"wammo|WEAPON_HEAVYPISTOL",
	"wammo|WEAPON_REVOLVER",
	"wammo|WEAPON_PISTOL_MK2",
	"wammo|WEAPON_VINTAGEPISTOL",
	"wammo|WEAPON_MUSKET",
	"wammo|WEAPON_GUSENBERG",
	"wammo|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_COMBATPDW",
	"wammo|WEAPON_MACHINEPISTOL",
	"wammo|WEAPON_CARBINERIFLE_MK2",
	"wammo|WEAPON_COMPACTRIFLE",
	"wammo|WEAPON_SMG_MK2"
}

RegisterCommand('apreender',function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negato', 'Non puoi farlo in coma.') return end
	if vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"poliziaazione.autorizzazione") or vRP.hasPermission(user_id,"admin.autorizzazione") then
		local user_id = vRP.getUserId(source)

		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				vRPclient.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)
				SetTimeout(5000, function()
					vRPclient.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},false)
					if vRPclient.FazendoAnim(source, "oddjobs@shop_robbery@rob_till","loop") then
						
						local nidentity = vRP.getUserIdentity(nuser_id)
						local itens_apreendidos = ''
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							end
						end
		
						local inv = vRP.getInventory(nuser_id)
						for k,v in pairs(itemlist) do
							local sub_items = { v }
							if string.sub(v,1,1) == "*" then
								local idname = string.sub(v,2)
								sub_items = {}
								for fidname,_ in pairs(inv) do
									if splitString(fidname,"|")[1] == idname then
										table.insert(sub_items,fidname)
		
									end
								end
							end
		
							for _,idname in pairs(sub_items) do
								local amount = vRP.getInventoryItemAmount(nuser_id,idname)
								if amount > 0 then
									if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
										vRP.giveInventoryItem(user_id,idname,amount)
										itens_apreendidos = itens_apreendidos .. "[ITEM]: "..vRP.itemNameList(idname) .." [QUANTITA']: "..amount .. '\n'
									end
								end
							end
						end
						SendWebhookMessage(webhookpoliziaapreendidos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APREENDEU DE]:  "..nuser_id.." "..nidentity.name.." "..nidentity.firstname.."\n" .. itens_apreendidos ..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
						TriggerClientEvent('Notify', source, 'successo','successo', 'Oggetti sequestrati.')
					end
				end)
				
				TriggerClientEvent("Notify",nplayer,"importante","Tutti i tuoi averi sono stati sequestrati..")
				TriggerClientEvent("Notify",source,'importante',"Importante","Sequestrati tutti i beni della persona.")
			end
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando',function(x,y,z, time)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"poliziaatirando.autorizzazione") then
			local poliziais = vRP.getUsersByPermission("polizia.autorizzazione")
			for l,w in pairs(poliziais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacao',player,x,y,z,user_id,time)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('annuncio',function(source,args,rawCommand)
	 
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"polizia.autorizzazione") or vRP.hasPermission(user_id,"vendedor.autorizzazione") or vRP.hasPermission(user_id,"news.autorizzazione") then
			local mensagem = vRP.prompt(source,"Mensagem:","")
			local nome = vRP.prompt(source,"Nome:","")
			if mensagem == "" or nome == "" then
				return
			end
			TriggerClientEvent("Notify",-1,"importante",mensagem.."<br><b>Messaggio inviato da:</b> "..nome,60000)
			SendWebhookMessage(webhookanunciosul,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[INVIATO UN ANNUNCIO]: "..mensagem.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		end
	end
end)

function src.CheckPolice()
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,'polizia.autorizzazione')
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if vRP.hasGroup(user_id,"polizia") then 
		vRP.addUserGroup(user_id,"paisanapolizia")
	end

	if vRP.hasGroup(user_id,"poliziaazione") then 
		vRP.addUserGroup(user_id,"paisanapolizia")
	end

	if vRP.hasGroup(user_id,"medico") then 
		vRP.addUserGroup(user_id,"paisanamedico")
	end
end)