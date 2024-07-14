config = {
    ['webhook'] = 'https://discord.com/api/webhooks/1135233115795759204/Qf9lDepuWh_fGEBVWfFBlV1H9IYUq_Nr-rp0YBDi8ofVZmH82vo6PLuhHsA6S1Iy2kCt',
    ['creative'] = true,
    ['items'] = {
        {'cellulare',1},
        {'radio',1},
        {'zaino',1},
    },
    ['vehicles'] = {
        'r1',
    },
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('visionexclusive/selectkit','SELECT * FROM kitinicial WHERE user_id = @user_id')
vRP._prepare('visionexclusive/insertkit','INSERT IGNORE INTO kitinicial(user_id,collected) VALUES(@user_id,@collected)')
vRP._prepare('visionexclusive/updatekit','UPDATE kitinicial SET collected = @collected WHERE user_id = @user_id')
vRP._prepare('visionexclusive/selectvehicle','SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle')
vRP._prepare("visionexclusive/insertvehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,@ipva)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kitiniziale', function(source,args)
    local user_id = vRP.getUserId(source)
    local query = vRP.query('visionexclusive/selectkit', { user_id = user_id })
    if not query[1] then
        vRP.execute('visionexclusive/insertkit', { user_id = user_id, collected = true })
        if not config['creative'] then
            if config['items'] ~= nil and #config['items'] > 0 then
                vRP.giveInventoryItem(user_id, "radio", 1);
                vRP.giveInventoryItem(user_id, "zaino", 1);
                vRP.giveInventoryItem(user_id, "cellulare", 1);
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL_MK2", 1);
            end
        else
            if config['items'] ~= nil and #config['items'] > 0 then
                vRP.giveInventoryItem(user_id, "radio", 1);
                vRP.giveInventoryItem(user_id, "zaino", 1);
                vRP.giveInventoryItem(user_id, "cellulare", 1);
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL_MK2", 1);
            end
        end

        if config['vehicles'] ~= nil and #config['vehicles'] > 0 then
            for k,v in pairs(config['vehicles']) do
                local query = vRP.query('visionexclusive/selectvehicle', { user_id = user_id, vehicle = v })
                if not query[1] then
                    vRP.execute("visionexclusive/insertvehicle",{ user_id = user_id, vehicle = v, ipva = parseInt(os.time()) }) 
                end
                Wait(100)
            end
        end

        TriggerClientEvent('Notify', source, 'successo', "Kit iniziale riscattato con successo")
        SendWebhookMessage(config['webhook'],"```prolog\n[ID]: "..user_id.."\n[HA RISCATTATO IL KIT INIZIALE]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
    else
        if query[1].collected ~= 1 then
            vRP.execute('visionexclusive/updatekit', { user_id = user_id, collected = true })
            if not config['creative'] then
                vRP.giveInventoryItem(user_id, "radio", 1);
                vRP.giveInventoryItem(user_id, "zaino", 1);
                vRP.giveInventoryItem(user_id, "cellulare", 1);
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL_MK2", 1);
            else
                vRP.giveInventoryItem(user_id, "radio", 1);
                vRP.giveInventoryItem(user_id, "zaino", 1);
                vRP.giveInventoryItem(user_id, "cellulare", 1);
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL_MK2", 1);
            end
            TriggerClientEvent('Notify', source, 'successo', "Kit iniziale riscattato con successo")
            SendWebhookMessage(config['webhook'],"```prolog\n[ID]: "..user_id.."\n[HA RISCATTATO IL KIT INIZIALE]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
        else
            TriggerClientEvent('Notify', source, 'negato', "Hai gia riscattato il kit iniziale")
        end
    end
end)