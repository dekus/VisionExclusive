--[[
    PROPOSTA:



]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

mrqz = {}
Tunnel.bindInterface("drogas_farm", mrqz)

function mrqz.TemPermissao(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, perm)
end

function mrqz.iojnoIBAIUGFVBUIABSdkj(perm, Item, Qtd, ItemReq)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, perm) then
        if not ItemReq then
            if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(Item) <= vRP.getInventoryMaxWeight(user_id) then    
                vRP.giveInventoryItem(user_id,Item,1)
                TriggerClientEvent('Notify', source, 'successo','Hai preso 1x '..  vRP.itemNameList(Item) .. '.')
            else
                TriggerClientEvent('Notify', source, 'negato','Il tuo zaino è pieno!')
            end
        else   
            if type(ItemReq) == 'table' then

                for k,v in pairs(ItemReq) do
                    if vRP.getInventoryItemAmount(user_id,k) < v then
                        TriggerClientEvent('Notify', source, 'negato','Non possiedi ' .. v .. 'x ' .. vRP.itemNameList(k) .. '.')
                        return 
                    end
                end

                for k,v in pairs(ItemReq) do
                    if not vRP.tryGetInventoryItem(user_id,k,v) then
                        TriggerClientEvent('Notify', source, 'negato','Non possiedi ' .. v .. 'x ' .. vRP.itemNameList(k) .. '.')
                        return 
                    end
                end

                vRP.giveInventoryItem(user_id,Item,Qtd)
                TriggerClientEvent('Notify', source, 'successo','Hai finito ' .. Qtd .. 'x '..  vRP.itemNameList(Item) .. '.')


            else

                if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(Item)*Qtd <= vRP.getInventoryMaxWeight(user_id) then  
                    if vRP.tryGetInventoryItem(user_id,ItemReq,1) then
                        vRP.giveInventoryItem(user_id,Item,Qtd)
                        TriggerClientEvent('Notify', source, 'successo','Hai trasformato 1x '..  vRP.itemNameList(ItemReq) .. ' in ' .. Qtd .. 'x ' .. vRP.itemNameList(Item) .. '.')
                    else
                        TriggerClientEvent('Notify', source, 'negato','Non possiedi 1x ' .. vRP.itemNameList(ItemReq) .. '.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negato','Il tuo zaino è pieno!')
                end
            end
        end
    end
end
