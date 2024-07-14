-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_skinshop", cRP)
vCLIENT = Tunnel.getInterface("vrp_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Permission = {
    'support.autorizzazione',
    'booster.autorizzazione',
    'vip.autorizzazione'
}

function cRP.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    for k,v in pairs(Permission) do
        if vRP.hasPermission(user_id,v) then
            return true
        end
    end
end

function cRP.booster()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then 
		if vRP.hasPermission(user_id,"booster.autorizzazione") then 
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateClothes(clothes)
    local source = source
    local user_id = vRP.getUserId(source)
    if clothes ~= nil then
        vRP.setUData(user_id,"clothingData",json.encode(clothes))
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local player = vRP.getUData(user_id,"clothingData")
	local result = json.decode(playerData)
	if result ~= nil then
        TriggerClientEvent("updateRoupasPreset",source,result)
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE ROUPAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "mascara", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('oculos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "oculos", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('chapeu', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "chapeu", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('colete', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "colete", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestitis.")
		end
	end
end)

RegisterCommand('acessorio', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "acessorio", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('sapatos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "sapato", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('mochila', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "mochila", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('jaqueta', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "jaqueta", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('maos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "mao", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('calca', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "calca", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)

RegisterCommand('blusa', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id, "mochila.autorizzazione") or vRP.hasPermission(user_id, "chamadoadmin.autorizzazione") then
			vCLIENT.updateClothes(source, "blusa", tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent("Notify",source,"negato","Non possiedi l'item dei vestiti.")
		end
	end
end)