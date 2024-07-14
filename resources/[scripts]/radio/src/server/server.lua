-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
src = {};
Tunnel.bindInterface("radio-Server", src);
clientAPI = Tunnel.getInterface("radio-Client");

function src.checkRadio()
  local user_id = vRP.getUserId(source)
  if vRP.getInventoryItemAmount(user_id, "radio") >= 1 then
    return true
  else
    TriggerClientEvent("Notify", source, "negato", "Non hai una <b>Radio</b> nello zaino!")
  end
end

function src.checkPermission(e)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, e) then
    return true
  else
    TriggerClientEvent("Notify", source, "negato", "Non hai il permesso")
  end
end