-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:IMPORT FRAMEWORK - VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel");
local Proxy = module("vrp","lib/Proxy");
vRP = Proxy.getInterface("vRP");
--------------------------------------------------------------------------------------------------------------------------------
-- RADIO:VARIABLES
--------------------------------------------------------------------------------------------------------------------------------
src = {};
Tunnel.bindInterface("radio-Client", src);
serverAPI = Tunnel.getInterface("radio-Server");

--------------------------------------------------------------------------------------------------------------------------------
-- RADIO:OPEN NUI FUNCTION
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('radio',function()
  if serverAPI.checkRadio() then
    if GetEntityHealth(PlayerPedId()) <= 101 then 
      TriggerEvent('Notify', "negato", 'Non puoi farlo da morto.')
      return
    end
    SetNuiFocus(true, true)
    SendNUIMessage({ show = true, frequencies = Config.Frequencies })
  end
end)
RegisterCommand("radiof",function(source,args)
  if GetEntityHealth(PlayerPedId()) <= 101 then 
    TriggerEvent('Notify', "negato", 'Non puoi farlo da morto.')
    return
  end
  if args[1] and serverAPI.checkRadio() then
    if parseInt(args[1]) < 1000 and parseInt(args[1]) > 0 then
    TriggerEvent("Notify","successo","Hai inserito la frequenza <b>"..args[1].."</b> della radio.")
      if Config.Voip == "tokovoip_script" then
        exports.tokovoip_script:addPlayerToRadio(parseInt(args[1]))
      elseif Config.Voip == "pma-voice" then
        exports["pma-voice"]:setRadioChannel(tonumber(args[1]))
      end
    else
      TriggerEvent("Notify","negato","Frequenza non valida!")
    end
  end
end)
RegisterCommand("radiod",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then TriggerEvent('Notify', 'negato', 'Non puoi farlo da morto.') return end
	TriggerEvent("Notify",'successo',"Ti sei disconnesso da tutte le frequenze.")
	disconnect()
end)

RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
  disconnect()
end)

RegisterNUICallback("connect", function(data, cb)
  if serverAPI.checkRadio() then
    if serverAPI.checkPermission(data.permission) then
      TriggerEvent('Notify', 'successo', 'Hai inserito la frequenza <b>'..data.frequency..'</b>.')
      if Config.Voip == "tokovoip_script" then
        exports.tokovoip_script:addPlayerToRadio(data.frequency)
      elseif Config.Voip == "pma-voice" then
        exports["pma-voice"]:setRadioChannel(tonumber(data.frequency))
      end
    end
  end
  cb({success = true})
end)

RegisterNUICallback("disconnect", function(_,cb)
  TriggerEvent("Notify",'successo',"Ti sei disconnesso da tutte le frequenze.")
  disconnect()
  cb({ success = true})
end)

RegisterNUICallback("removeFocus", function(_,cb)
  SetNuiFocus(false, false)
  cb({success = true})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function disconnect()
  if Config.Voip == "tokovoip_script" then
    local i = 0
    while i < 1050 do
      if exports.tokovoip_script:isPlayerInChannel(i) == true then
	      exports.tokovoip_script:removePlayerFromRadio(i)
	    end	
      i = i + 1
    end
    return true
  elseif Config.Voip == "pma-voice" then
    exports["pma-voice"]:removePlayerFromRadio()
  end
end