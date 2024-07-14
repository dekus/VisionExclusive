local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())


function src.bende()
    local source = source 
    local user_id = vRP.getUserId(source)
    local request = vRP.request(source, 'Vuoi comprare 3 bende per € 4000 ?', 30)
    if request then 
    if vRP.tryFullPayment(user_id, parseInt(4000)) then
        TriggerClientEvent("Notify",source,"successo","Pagato con successo.")
        vRP.giveInventoryItem(user_id, "bende", 3)
        vRP.tryFullPayment(user_id,4000)
    else
        TriggerClientEvent("Notify",source,"negato","Non hai <b>€ 4000.<b>")
    end
else
    TriggerClientEvent("Notify",source,"negato","Acquisto non riuscito.")
    end
end

function src.adrenalina()
    local source = source 
    local user_id = vRP.getUserId(source)
    local request = vRP.request(source, 'Desideri comprare 1 di ADRENALINA per 500K?', 30)
    if request then 
    if vRP.tryFullPayment(user_id, parseInt(500000)) then
        TriggerClientEvent("Notify",source,"successo","Pagato con successo.")
        vRP.giveInventoryItem(user_id, "adrenalina", 1)
    else
        TriggerClientEvent("Notify",source,"negato","Non tieni abbastanza soldi.")
    end
else
    TriggerClientEvent("Notify",source,"negato","Acquisto non riuscito.")
    end
end

function src.shop()
    local source = source
    local user_id = vRP.getUserId(source)
    local prompt = vRP.prompt(source, 'SCEGLI QUELLO CHE VUOI COMPRARE - ARMI / DROGA / ALTRO', '')
    if prompt == "ARMAS" then
        TriggerClientEvent("Notify",source,"successo","La Fiera Illegale non è ancora iniziata.")
        return
    end
    if prompt == "DROGAS" then
        TriggerClientEvent("Notify",source,"successo","La Fiera Illegale non è ancora iniziata.")
        return
        end
    if prompt == "OUTROS" then
        TriggerClientEvent("Notify",source,"successo","La Fiera Illegale non è ancora iniziata.")
        return
    end
end



