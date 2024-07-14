-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE:IMPORT FRAMEWORK - VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel");
local Proxy = module("vrp","lib/Proxy");
vRP = Proxy.getInterface("vRP");
---------------------------------------------------------------------------------------------------------------------------------------
-- STORE:VARIABLES
---------------------------------------------------------------------------------------------------------------------------------------
src = {};
Tunnel.bindInterface("store-Client", src);
serverAPI = Tunnel.getInterface("store-Server");
---------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
---------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("dcomprar","Apri Negozio","keyboard","e")
RegisterCommand("dcomprar", function() 
	for _,mark in pairs(Config.Coords["store"]) do
	local x,y,z = table.unpack(mark)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
		if distance <= 2 then
			SetNuiFocus(true, true)
			StartScreenEffect("MenuMGSelectionIn", 0, true)
			SendNUIMessage({ show = true, store = "store", itens = Config.Itens["store"] })
		end
	end
end)




---------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
---------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("acomprar","Apri Armeria","keyboard","e")
RegisterCommand("acomprar", function() 
	for _,mark in pairs(Config.Coords["ammunation"]) do
	local x,y,z = table.unpack(mark)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
		if distance <= 2 then
			SetNuiFocus(true, true)
      StartScreenEffect("MenuMGSelectionIn", 0, true)
      SendNUIMessage({ show = true, store = "ammunation", itens = Config.Itens["ammunation"] })
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k, v in pairs(Config.Coords["ammunation"]) do
		table.insert(innerTable, { v[1], v[2], v[3], 2, "E", "armeria", "apri","premi" })
	end
	for k, v in pairs(Config.Coords["store"]) do
		table.insert(innerTable, { v[1], v[2], v[3], 2, "E", "negozio", "apri","premi" })
	end
	TriggerEvent("hoverfy:insertTable", innerTable)

end)

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500

		for k,v in pairs(Config.Coords["ammunation"]) do
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[1], v[2], v[3],true)
			if distance <= 15 then
				timeDistance = 0
				DrawMarker(20, v[1], v[2], v[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 192, 16, 236,180, 1, 0, 0, 1)
			end
		end

		for k,v in pairs(Config.Coords["store"]) do
			local x,y,z = table.unpack(v)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[1], v[2], v[3],true)
			if distance <= 10 then
				timeDistance = 0
				DrawMarker(20, v[1], v[2], v[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 192, 16, 236,180, 1, 0, 0, 1)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

RegisterNUICallback("buying", function(data,cb)
	local buyFunc = serverAPI.buyItem(data)
  cb({ success = buyFunc })
end)

RegisterNUICallback("removeFocus", function(_, cb)
	StopScreenEffect("MenuMGSelectionIn")
  SetNuiFocus(false, false)
	cb({ success = true })
end)