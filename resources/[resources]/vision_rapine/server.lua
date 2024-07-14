local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

src = {}
Tunnel.bindInterface("rusher_roubos", src)

vCLIENT = Tunnel.getInterface("rusher_roubos")

local Cooldowns = {}
local police = {}
--local escalando = false
local PermissoesBloqueadas = {
    'polizia.autorizzazione',
    'poliziaazione.autorizzazione',
    'poliziafuoriservizio.autorizzazione',
    'medico.autorizzazione',
    'bennys.autorizzazione',
    'mecanico.autorizzazione',
}

local webhookderoubos = "https://discord.com/api/webhooks/1130285028220354701/7QL-R5duvkN2MWE7wids52tVaT8jlK21XXyn4zFTW_Niehyt0bgEiVB1mM6LlQCoHW8-"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local CooldownAcao = {}

function shuffle(tbl)
    local temp = {}
    for k, v in pairs(tbl) do
        table.insert(temp, k)
    end
    for i = #temp, 2, -1 do
        local j = math.random(i)
        temp[i], temp[j] = temp[j], temp[i]
    end
    return temp
end

function src.CheckCooldown(Lugar, TempoCooldown, ItemNecessario, Minpolizia, PermDosPm, Estabelecimento, x, y, z, Maxpolizia, Prioridade, time)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local horaAgora = os.time()

    for k, v in pairs(PermissoesBloqueadas) do
        if vRP.hasPermission(user_id, v) then
            TriggerClientEvent('Notify', source, 'negato', 'Non puoi fare questo se sei un poliziotto.')
            return false
        end
    end

    if not Cooldowns[Lugar] or horaAgora >= Cooldowns[Lugar] + TempoCooldown then

        local polizia = vRP.getUsersByPermission(PermDosPm)
        if Minpolizia and Maxpolizia > 2 then
            if #polizia < Minpolizia then
                TriggerClientEvent('Notify', source, 'negato', 'Non c\'è abbastanza polizia, aspetta!')
                return false
            end
        end
        
        for k,v in pairs(polizia) do
            local player = vRP.getUserSource(parseInt(v))
            if player then
                async(function()
                    local id = idgens:gen()
                    TriggerClientEvent("NotifyPushRoubos",player,{ code = '157', user_idd = user_id, name = identity.name, firstname = identity.firstname, title = "Rapina a(o) "..Estabelecimento, x = x, y = y, z = z, time = time})
		            --TriggerEvent("NotifyPush",{ code = '10-71', title = "Disparos de arma de fogo", x = x, y = y, z = z, time = time})
                    police[id] = vRPclient.addBlip(player,x,y,z,437,1,"Rapina a(o) " .. Estabelecimento,0.8,false)
                    SetTimeout(80000,function() vRPclient.removeBlip(player,police[id]) idgens:free(id) end)
                end)
            end
        end

        Cooldowns[Lugar] = horaAgora
        SendWebhookMessage(webhookderoubos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[INICIOU " .. Estabelecimento .. "]"..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
        vRPclient.playAnim(source, false, {"anim@heists@ornate_bank@grab_cash", "grab"}, true)
        Citizen.Wait(50)
        return true

    end
    TriggerClientEvent('Notify', source, 'negato', 'Rapina in attesa, aspetta <b>' .. (Cooldowns[Lugar]+TempoCooldown) - horaAgora .. 's</b>.')
    --escalando = false
    return false
end


function src.nIOUGBAIksdnklajbIUYVBEW(Estabelecimento, Recompensa)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local item = 'denarosporco'
    local chanceDeTicket = math.random(1,3)
    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item)*parseInt(Recompensa) <= vRP.getInventoryMaxWeight(user_id) then
        vRP.giveInventoryItem(user_id,item,Recompensa)
        if chanceDeTicket == 2 then
            vRP.giveInventoryItem(user_id,"ticketazione",1)
        end
        local playerGang = vRP.getUserGroupByType(user_id,"job")
        TriggerEvent('ranking:update', playerGang)
        TriggerEvent("pass:updateMission", {user_id = user_id, value = 1, mission_id = 4})
        SendWebhookMessage(webhookderoubos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.. "\n[RICEVUTO]: € " .. vRP.format(Recompensa) .. 'x Denaro Sporco' .. "\n[FINITO " .. Estabelecimento .. "]"..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
        return
    end
    TriggerClientEvent('Notify', source, 'negato', 'I soldi non entrano nel tuo zaino.')
    return false
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end