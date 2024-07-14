local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

rusherFarm = {}
Tunnel.bindInterface("npc_farms", rusherFarm)
cFarm = Tunnel.getInterface("npc_farms")

local farms = ""
local farms2 = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

--local delayIniciarRota = {}

function rusherFarm.OFlyNcqwyVnLBLqXkEnJeScFb(permissao)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, permissao) or vRP.hasPermission(user_id, 'admin.autorizzazione') then
        --if not delayIniciarRota[user_id] or os.time() > (delayIniciarRota[user_id] + 400) then
           --delayIniciarRota[user_id] = os.time()
            return true, permissao
        --else
            --TriggerClientEvent('Notify', source, 'negato', 'negato', 'Devi aspettare per ricominciare un altro percorso.')
        --end
    end
    return false
end 

function rusherFarm.rqkWrVlbDiRADhQwchLtLdZuk(PermCliente)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, PermCliente) then
        local qtdPolvora = math.random(5,10)
        local qtdArmacaoDeArma = math.random(6,8)
        local qtdBns = math.random(10,15)
        local qtdSujo = math.random(1600,3600)
        local qtdSujo2 = math.random(2600,3600)
        local qtdSujo3 = math.random(1000,3000)
        local qtdAlvejante = math.random(5,9)

        if PermCliente == 'bloods.autorizzazione' or PermCliente == 'crips.autorizzazione' then
            if vRP.getInventoryWeight(user_id) + vRP.getItemWeight('armacaodearma') * qtdArmacaoDeArma <= vRP.getInventoryMaxWeight(user_id) then
                vRP.giveInventoryItem(user_id, 'armacaodearma', qtdArmacaoDeArma)
                vRP.giveInventoryItem(user_id, 'denarosporco', qtdSujo)
                local rdm = math.random(0, 85)
                if rdm <= 1 then --3
                    vRP.giveInventoryItem(user_id, 'armacaodescar',1)
                    vRP.giveInventoryItem(user_id, 'armacaodeglockrj',1)
                    vRP.giveInventoryItem(user_id, 'armacaodemp5',1)
                    SendWebhookMessage(farms2,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RICEVUTO 1 AK NELLA FATTORIA BLIP]: \n[CHANCE]: "..rdm.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
                end
                TriggerClientEvent('Notify', source, 'successo','Hai preso ' .. qtdArmacaoDeArma .. 'x armi ' .. qtdSujo .. 'x soldi sporchi.')
            else
                TriggerClientEvent('Notify', source, 'negato','Non hai abbastanza spazio per questo.')
            end

        elseif PermCliente == 'siciliana.autorizzazione' or PermCliente == 'yardie.autorizzazione' then
            if vRP.getInventoryWeight(user_id) + vRP.getItemWeight('polvora9mm') * qtdPolvora <= vRP.getInventoryMaxWeight(user_id) then
                vRP.giveInventoryItem(user_id, 'polvora9mm', qtdPolvora)
                vRP.giveInventoryItem(user_id, 'denarosporco', qtdSujo2)
                local rdm = math.random(0,50)
                if rdm <= 1 then
                    local qtd762 = math.random(4,10)
                    vRP.giveInventoryItem(user_id, 'polvora762', qtd762)
                    SendWebhookMessage(farms2,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RICEVUTO]: "..qtd762.."x polvere di 762 \n[CHANCE]: "..rdm.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
                  end
                TriggerClientEvent('Notify', source, 'successo','Hai preso ' .. qtdPolvora .. 'x polvere e ' .. qtdSujo2 .. 'x soldi sporchi.')
            else
                TriggerClientEvent('Notify', source, 'negato','Non hai abbastanza spazio per questo.')
            end

        elseif PermCliente == 'bahamas.autorizzazione' or PermCliente == 'life.autorizzazione' then
            if vRP.getInventoryWeight(user_id) + vRP.getItemWeight('candeggina') * qtdAlvejante <= vRP.getInventoryMaxWeight(user_id) then
                vRP.giveInventoryItem(user_id, 'candeggina', qtdAlvejante)
                vRP.giveInventoryItem(user_id, 'denarosporco', qtdSujo3)
                local rdm = math.random(0,50)
                if rdm <= 2 then
                    local qtdalvejantemodificado = math.random(1,2)
                    vRP.giveInventoryItem(user_id, 'candegginamodificata', qtdalvejantemodificado)
                    SendWebhookMessage(farms2,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RICEVERE]: "..qtdalvejantemodificado.."x polvere da sparo del 762 \n[CHANCE]: "..rdm.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
                end
                TriggerClientEvent('Notify', source, 'successo','Hai preso ' .. qtdAlvejante .. 'x sbiancanti e ' .. qtdSujo3 .. 'x di denaro sporco.')
            else
                TriggerClientEvent('Notify', source, 'negato','Non hai abbastanza spazio per questo..')
            end
        end
    end
end