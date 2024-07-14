local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("trade-serverAPI")

local Config = {
  path = "https://images.visionexclusive.it/images/",

  ticket = {
    spawn = "ticketazione",
    image = "ticketazione.png"
  },
  
  weapons = {
    {
      name = "FIVE",
      quantity = 1,
      price = 20,
      spawn = "wbody|WEAPON_PISTOL_MK2"
    },
    --{
      --name = "SMG",
      --quantity = 1,
      --price = 10,
      --spawn = "wbody|WEAPON_SMG_MK2"
    --},
    --{
      --name = "AK-47",
      --quantity = 1,
      --price = 15,
      --spawn = "wbody|WEAPON_ASSAULTRIFLE_MK2"
    --}
  }
}

function DrawText3D(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.325, 0.325)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03,0,0,0,68)
end

local onNui = false
CreateThread(function()
  while true do
    timeDistance = 1000
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pedCoords, vec3(707.28,-966.99,30.42))
    if distance <= 2 then
      if not onNui then
        DrawText3D(707.28,-966.99,30.42, "~p~[~w~E~p~]~w~ Apri Scambio")
      end
      timeDistance = 1
      if IsControlJustPressed(1, 38) then
        onNui = true
        SetNuiFocus(true, true)
        SendNUIMessage({ action = "setVisible", visible = true, imagePath = Config.path, ticket = { spawn = Config.ticket.spawn, image = Config.ticket.image }, weapons = Config.weapons })
      end
    end
    Wait(timeDistance)
  end
end)

RegisterNUICallback("removeFocus", function(data, cb)
  onNui = false
  SetNuiFocus(false, false)
  cb({success = true})
end)

RegisterNUICallback("trade", function(data,cb)
  local trade = vSERVER.tradeItem(data)
  if trade then
    onNui = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
  end
  cb({success = true})
end)

