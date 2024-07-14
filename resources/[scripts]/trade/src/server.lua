local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("trade-serverAPI", src)

function src.tradeItem(data)
  local source = source
  local user_id = vRP.getUserId(source)
  if vRP.tryGetInventoryItem(user_id, "ticketazione", data[1]) then
    vRP.giveInventoryItem(user_id, data[2], 1)
    TriggerClientEvent("Notify", source, "successo", "Hai scambiato <b>"..data[1].." ticket</b> per una <b>"..vRP.itemNameList(data[2]).."</b>!")
    return true
  else
    TriggerClientEvent("Notify", source, "negato", "Non possiedi <b>"..data[1].." ticket</b>!")
    return false
  end
end