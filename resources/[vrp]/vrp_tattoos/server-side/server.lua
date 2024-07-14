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
Tunnel.bindInterface("vrp_tattoos", cRP)
vCLIENT = Tunnel.getInterface("vrp_tattoos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
local Permission = {
    'support.autorizzazione',
    'stremer.autorizzazione'
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateTattoo(atualTattoo)
    local source = source
    local user_id = vRP.getUserId(source)
    if atualTattoo ~= nil then
        vRP.setUData(user_id,"vRP:tattoos",json.encode(atualTattoo))
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local consult = vRP.getUData(user_id,"vRP:tattoos")
	local result = json.decode(consult)
	if result then
		TriggerClientEvent("vrp_tattoos:setTattoos",source,result)
	end
end)
