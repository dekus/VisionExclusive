-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-----------------------------------------------------------------------------------------------------------------------------------------
local src = {}
Tunnel.bindInterface("notifypush",src)
vSERVER = Tunnel.getInterface("notifypush")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showBlips = {}
local timeBlips = {}
local numberBlips = 0
local notifyPolice = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notifys",function(source,args)
	notifyPolice = not notifyPolice
	if notifyPolice then
		TriggerEvent("Notify","avviso","Hai attivato il <b>suono</b> delle segnalazioni di polizia.")
	else
		TriggerEvent("Notify","avviso","Hai disattivato il <b>suono</b> delle segnalazioni di polizia.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notify",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		SetCurrentPedWeapon(ped,"WEAPON_UNARMED",true)
		if vSERVER.checkPolice() then
		SendNUIMessage({ action = "showAll" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("notify","Aprire le notifiche","keyboard","f1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(data, time)
	data["street"] = GetStreetNameFromHashKey(GetStreetNameAtCoord(data["x"],data["y"],data["z"]))

	SendNUIMessage({ action = "notify", data = data, time = time })

	numberBlips = numberBlips + 1

	timeBlips[numberBlips] = 60
	showBlips[numberBlips] = AddBlipForRadius(data["x"],data["y"],data["z"])
	SetBlipColour(showBlips[numberBlips],data["blipColor"])
	SetBlipAlpha(showBlips[numberBlips],304)
end)

RegisterNetEvent("NotifyPushRoubos")
AddEventHandler("NotifyPushRoubos",function(data, time)
	data["street"] = GetStreetNameFromHashKey(GetStreetNameAtCoord(data["x"],data["y"],data["z"]))
	data["name"] = '#'..data.user_idd..' '..data.name

	SendNUIMessage({ action = "notify", data = data, time = time })

	numberBlips = numberBlips + 1

	timeBlips[numberBlips] = 60
	showBlips[numberBlips] = AddBlipForRadius(data["x"],data["y"],data["z"])
	SetBlipColour(showBlips[numberBlips],data["blipColor"])
	SetBlipAlpha(showBlips[numberBlips],304)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(timeBlips) do
			if timeBlips[k] > 0 then
				timeBlips[k] = timeBlips[k] - 1

				if timeBlips[k] <= 0 then
					RemoveBlip(showBlips[k])
					showBlips[k] = nil
					timeBlips[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function()
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setWay",function(data)
	SetNewWaypoint(data["x"] + 0.0001,data["y"] + 0.0001)
	SendNUIMessage({ action = "hideAll" })
end)