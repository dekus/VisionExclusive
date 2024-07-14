local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('report',function(source,args,rawCommand,type,description)
	local user = vRP.getUserId(source)
	local adminsOn = vRP.getUsersByPermission(Config.autorizzazione)
	local identity = vRP.getUserIdentity(user)

	local description = vRP.prompt(source,"Motivo della chiamata:","")
		if description == "" then
			TriggerClientEvent("Notify",source,'negato',"Non è possibile inviare un ticket vuoto..")
			return
		end
		for k,v in pairs(Config.TermosProibidos) do
			if string.match(description, v) then
				TriggerClientEvent("Notify",source,'importante',"Queste tipo di chiamate <b>NON</b> si possono fare.")
				return
			end
		end
	if vRP.request(source, '<c>Vuoi confermare l\'invio del tuo biglietto allo staff con la descrizione?:</c> <b>"'..description..'</b>"?', 15) then
		if #adminsOn == 0 then
			TriggerClientEvent('Notify', source, 'negato', 'Non c\'è nessun membro dello <b>Staff</b> online al momento, apri un TICKET.')
			return false
		end
		function log(desc)
			local logo = 'https://media.discordapp.net/attachments/967414526926524527/1128123576600506458/GIF_VISION.gif'
			if Config.Logo == '' then
				logolog = logo
			else
				logolog = Config.Logo
			end
			local content = {
			{
				["color"] = 3092790, -- #2f3136
				["author"] = {
					["name"] = 'REGISTRO DELLE CHIAMATE',
					["url"] = Config.Discord,
				},
				["description"] = desc,
				["footer"] = {
					["text"] = '💙 By: Vision Exclusive',
				},
				["thumbnail"] = {
					['url'] = logo
				},
			}
		  }
			PerformHttpRequest(Config.WebhookLog, function(err, text, headers) end, 'POST', json.encode({ username = 'Chiamata | '..Config.Servername, avatar_url = logolog, embeds = content}), { ['Content-Type'] = 'application/json' })
		end
		for k,v in pairs(adminsOn) do
			TriggerClientEvent('Notify', vRP.getUserSource(user), 'successo', 'La tua chiamata è stata inviata con successo!')
			TriggerClientEvent('hub:sendRequest', vRP.getUserSource(v), '#' ..user..' ' ..identity.name..' ' ..identity.firstname, description, user)
			log('>>> **🙍‍♂️ Giocatore**\n```ini\n[NOME]: ' ..identity.name..' '..identity.firstname..'\n[ID]: '..user..'```\n**📱 Chiamata** ```ini\n[DATA]: '..os.date("%x")..'\n[DATA]: '..os.date("%X")..'\n[Descrizione]: '..description.. '```')
		end
	end
end)
function src.tryAcceptRequest(id, delete)
	local source = source
	local user = vRP.getUserId(source)
	local nsource = vRP.getUserSource(tonumber(id))
	local nuser = vRP.getUserId(nsource)
	local identity = vRP.getUserIdentity(user)
	local nidentity = vRP.getUserIdentity(nuser)
	local x,y,z = vRPC.getPosition(nsource)

	if vRP.hasPermission(user,Config.autorizzazione) then
		TriggerClientEvent("Notify",nsource,'importante',"Chiamata con risposta da <b>"..identity.name.." "..identity.firstname.."</b>, aspetta sul posto.")
		
		TriggerClientEvent("Notify",source,'successo',"Tutte le chiamate per questo giocatore sono stati eliminati.<br><br>#"..nuser.." "..nidentity.name.." "..nidentity.firstname)
		TriggerClientEvent('hub:deleteRequest',-1, tonumber(id))
		TriggerClientEvent('hub:blipMap', source, x,y,z)
		
		vRPC.toggleNoclip(source)

		Wait(500)

		vRPC.teleport(source,x,y,z)

	end
end

function src.CheckPermission()
	local source = source
	if vRP.hasPermission(vRP.getUserId(source), Config.autorizzazione) then
		return true
	else
		return false
	end
end