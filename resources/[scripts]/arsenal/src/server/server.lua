-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL:VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL:VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
src = {};
Tunnel.bindInterface("arsenal-Server", src);
clientAPI = Tunnel.getInterface("arsenal-Client");
-----------------------------------------------------------------------------------------------------------------------------------------
-- SendWebhookMessage
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook, message)
  if not webhook or webhook == '' then
    return
  end

  PerformHttpRequest(webhook, function(err, text, headers)
  end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL:REQUESTPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.requestPermission(src)
  if not src then
    src = source
  end
  local user_id = vRP.getUserId(src)
  for k,v in pairs(Config.Permissions) do
    local isPerm = vRP.hasPermission(user_id,v[1])

    if not isPerm then
      TriggerClientEvent('Notify', src, 'negato', Config.Notify.negato.permission);
    end

    return isPerm
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL:REQUESTFTO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.requestFto(src)
  if not src then
    src = source
  end
  local user_id = vRP.getUserId(src)
  local isPerm = vRP.hasPermission(user_id,"poliziafto.autorizzazione")
  return isPerm
end

function src.getWeapon(data)
  local user_id = vRP.getUserId(source)

  if not src.requestPermission(source) then
    return false
  end

  if data.isItem then
    vRP.giveInventoryItem(user_id, data.spawn, 1)
    TriggerClientEvent('Notify', source, 'successo', Config.Notify.successo.getItem:format(vRP.itemNameList(data.spawn)));
    return true
  end

  vRPclient.giveWeapons(source, { [data.spawn] = { ammo = 250 }});
  TriggerClientEvent('Notify', source, 'successo', Config.Notify.successo.getWeapon:format(data.name));
  return true
end

function src.clearWeapons()
  local user_id = vRP.getUserId(source)
  if not src.requestPermission(source) then
    return false
  end

  vRPclient.giveWeapons(source, {}, true);
  TriggerClientEvent('Notify', source, 'successo', Config.Notify.successo.clearWeapons);
  return true
end