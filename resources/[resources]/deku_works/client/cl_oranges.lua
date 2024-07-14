local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")

local vSERVER = Tunnel.getInterface("works_orange")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local inService = false
local driverPosition = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local innerTable = {}
	for k, v in pairs(Config.collectSpots) do
		table.insert(innerTable,{ v[1], v[2], v[3], 2,"E","arance","raccogliere","premi" })
	end
	table.insert(innerTable,{ Config.startSellSpot[1], Config.startSellSpot[2], Config.startSellSpot[3], 2,"E","vendere arance","iniziare a","premi" })
	TriggerEvent("hoverfy:insertTable", innerTable)
end)

local isCollecting = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTORANGES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(Config.collectSpots) do
			local distance = #(coords - vec3(v[1], v[2], v[3]))

				if distance <= 15 then
					timeDistance = 1
					DrawMarker(20, v[1], v[2], v[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,69,0,180, 1, 0, 0, 1)
				end



				if distance <= 1 then
					timeDistance = 1
					if not isCollecting then
						if IsControlJustPressed(1,38) then
							if (isCollecting) then
								return TriggerEvent('Notify', 'Negato', 'Aspetta per raccogliere di nuovo.')
							end
							isCollecting = true
							FreezeEntityPosition(ped, true)
							SetEntityCoords(ped, v[1], v[2], v[3] - 1)
							vRP._playAnim(false,{"amb@prop_human_movie_bulb@base","base"},true)
							TriggerEvent('progress', 5000, 'Raccogliendo Arance')
							TriggerEvent('cancelando', true)
							SetTimeout(5000, function()
								vRP._stopAnim(false)
								TriggerEvent('cancelando', false)
								FreezeEntityPosition(ped, false)
								vSERVER.Collect()
								isCollecting = false
							end)
						end
					end
				end
			end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vec3(Config.startSellSpot[1], Config.startSellSpot[2], Config.startSellSpot[3]))
		if distance <= 30.0 then
			timeDistance = 1
			if not inService then
				DrawMarker(21,Config.startSellSpot[1], Config.startSellSpot[2], Config.startSellSpot[3],0,0,0,0,0,0,0.5,0.5,0.5,101, 190, 101,180,1,0,0,1)	
			end
			if distance <= 1.1 then
				if IsControlJustPressed(1,38) then
					if not inService then
						startSellingOranges()
						inService = true
						makeOrangesBlips()
						TriggerEvent("Notify","successo","Hai iniziato a vendere <b>Arance</b>.",5000)
					end
				end
			end
		end
		if inService then
			timeDistance = 1
			drawTxt("PREMI ~g~F7~w~ PER TERMINARE",4,0.5,0.96,0.50,255,255,255,200)
		end

		if inService then
			timeDistance = 1
			if IsControlJustPressed(0,168) then
				inService = false
				TriggerEvent("Notify","avviso","Hai finito di vendere le <b>Arance</b>.",5000)
				if DoesBlipExist(blip) then
					RemoveBlip(blip)
					blip = nil
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startSellingOranges()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				local coordsPed = GetEntityCoords(ped)
				local distance = #(coordsPed - vector3(Config.sellSpots[driverPosition][1],Config.sellSpots[driverPosition][2],Config.sellSpots[driverPosition][3]))
				if distance <= 10 then
					timeDistance = 1
					drawTxt("PREMI ~g~[~w~E~g~]~w~ VENDERE ~o~ARANCE",4,0.5,0.925,0.50,255,255,255,200)
					if distance <= 10 then
						if IsControlJustPressed(1,38) then
							if driverPosition == #Config.sellSpots then
								driverPosition = 1
								vSERVER.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(true,500)
							else
								driverPosition = driverPosition + 1
								vSERVER.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(false,0)
							end
							makeOrangesBlips()
						end
					end
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPSPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function makeOrangesBlips()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(Config.sellSpots[driverPosition][1],Config.sellSpots[driverPosition][2],Config.sellSpots[driverPosition][3])
		SetBlipSprite(blip,433)
		SetBlipColour(blip,2)
		SetBlipScale(blip,0.4)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Via delle Arance")
		EndTextCommandSetBlipName(blip)
	end
end