-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE:VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE:VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
src = {};
Tunnel.bindInterface("store-Server", src);
clientAPI = Tunnel.getInterface("store-Client");

function src.buyItem(data)
  for _,v in pairs(data.cart) do
    if not vRP.itemNameList(v.spawn) then
      TriggerClientEvent("Notify", source, "negato", "Questo articolo non esiste, contatta lo staff!")
      print("ERRORE | Lo spawn: '"..v.spawn.."' non esiste! Controllare la configurazione dell'elemento: "..v.name)
      return false
    end
  end;
  local user_id = vRP.getUserId(source)
  if not user_id and not data then return false end
  local totalWeight = 0
  for _,v in pairs(data.cart) do
    totalWeight = totalWeight + vRP.getItemWeight(v.spawn)
  end;
  if parseInt(vRP.getInventoryWeight(user_id) + totalWeight) > vRP.getInventoryMaxWeight(user_id) then
    TriggerClientEvent("Notify", source, "negato", "Non hai <b>spazio</b> nello zaino!") 
    return false
  end
  if vRP.tryFullPayment(user_id, data.totalPrice) then
    TriggerClientEvent("Notify", source, "successo", "Ha pagato <b>€ "..vRP.format(data.totalPrice).."!")
    for _,v in pairs(data.cart) do
      vRP.giveInventoryItem(user_id, v.spawn, v.quantity)
    end
    return true
  else
    TriggerClientEvent("Notify", source, "negato", "Non hai <b>€ "..vRP.format(data.totalPrice).."!</b>")
    return false
  end
end

