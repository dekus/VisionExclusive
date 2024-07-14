-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL:IMPORT FRAMEWORK - VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel");
local Proxy = module("vrp","lib/Proxy");
vRP = Proxy.getInterface("vRP");
--------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL:VARIABLES
--------------------------------------------------------------------------------------------------------------------------------
src = {};
Tunnel.bindInterface("arsenal-Client", src);
serverAPI = Tunnel.getInterface("arsenal-Server");

--------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL:OPEN NUI FUNCTION
--------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("arsenal", 'Aprire Arsenal', 'keyboard', 'E')
RegisterCommand('arsenal',function()
  if IsPedInAnyVehicle(PlayerPedId()) then return end
  local Coords = GetEntityCoords(PlayerPedId())
  local distance = #(Coords - vec3(Config.Coords[1], Config.Coords[2], Config.Coords[3]))
  if distance <= 1.5 then
    if not serverAPI.requestPermission() then return end
    local isFto = serverAPI.requestFto()
    SetNuiFocus(true, true)
    StartScreenEffect("MenuMGSelectionIn", 0, true)
    SendNUIMessage({ show = true, isFto = isFto, localImages = Config.Arsenal.localImages, guns = Config.Arsenal.Weapons, ftoGuns = Config.Arsenal.FTO })
  end
end)



-------------------------------------------------------------------------------------------------------------------------------

CreateThread(function()
	local innerTable = {}
	table.insert(innerTable,{ Config.Coords[1], Config.Coords[2], Config.Coords[3], 1.5, "E", "arsenale","apri","premi" })
	TriggerEvent("hoverfy:insertTable",innerTable)
end)

RegisterNUICallback("equipWeapon", function(data,cb)
  local getWeapon = serverAPI.getWeapon(data)
  cb({ success = getWeapon })
end)

RegisterNUICallback("clearWeapons", function(_,cb)
  local clearWeapons = serverAPI.clearWeapons()
  if clearWeapons then
    cb({ success = "close" })
  else
    cb({ success = clearWeapons })
  end
end)

RegisterNUICallback("removeFocus", function(_, cb)
	StopScreenEffect("MenuMGSelectionIn")
  SetNuiFocus(false, false)
  cb({ success = true })
end)


