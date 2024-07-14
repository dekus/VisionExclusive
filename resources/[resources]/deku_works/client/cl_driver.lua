-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local driveR = {}
Tunnel.bindInterface("vrp_driver",driveR)
--driverServer = Tunnel.getInterface("vrp_driver")
local vSERVER = Tunnel.getInterface("vrp_driver")
local vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local inService = false
local driverPosition = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local coords = {
	[1] = { 309.95,-760.52,30.09 },
	[2] = { 69.59,-974.80,30.14 },
	[3] = { 95.00,-634.89,45.02 },
	[4] = { 58.27,-283.32,48.20 },
	[5] = { 47.74,-160.44,56.03 },
	[6] = { 323.93,-267.58,54.71 },
	[7] = { 443.75,119.16,100.41 },
	[8] = { 125.62,-4.42,68.48 },
	[9] = { -524.08,133.59,63.91 },
	[10] = { -586.64,268.39,83.24 },
	[11] = { -640.38,-163.16,38.49 },
	[12] = { -597.89,-361.27,35.77 },
	[13] = { -646.06,-804.09,25.78 },
	[14] = { -932.63,-1199.67,5.91 },
	[15] = { -1234.65,-1080.87,9.12 },
	[16] = { -1373.99,-793.23,20.09 },
	[17] = { -2011.25,-160.04,29.40 },
	[18] = { -2981.70,404.50,15.75 },
	[19] = { -3101.58,1112.65,21.28 },
	[20] = { -2556.10,2322.01,33.89 },
	[21] = { -1094.86,2675.87,20.08 },
	[22] = { -72.63,2813.83,54.60 },
	[23] = { 540.55,2685.25,43.20 },
	[24] = { 1119.93,2682.04,39.31 },
	[25] = { 1470.51,2725.47,38.48 },
	[26] = { 2002.62,2603.65,55.07 },
	[27] = { 379.58,-599.20,29.58 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
local inLocate = { 453.09,-607.79,28.6 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000

		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vector3(inLocate[1],inLocate[2],inLocate[3]))

		if distance <= 30.0 then
			timeDistance = 4
			if not inService then
				DrawMarker(21,inLocate[1],inLocate[2],inLocate[3],0,0,0,0,0,0,0.5,0.5,0.5,101, 190, 101,180,1,0,0,1)	
			end
			
			if distance <= 1.1 then
				if not inService then
					drawTxt("PREMI ~g~E~w~ PER INIZIARE",4,0.5,0.96,0.50,255,255,255,200)
				end
				if IsControlJustPressed(1,38) then
					if not inService then
						startdriveservice()
						inService = true
						makeDriverBlips()
						TriggerEvent("Notify","successo","Hai iniziato il lavoro di <b>Autista</b>.",5000)
						TriggerEvent("Notify","successo","<b>Recati al ped per prendere il veicolo ed inziare la corsa.<b>",5000)
					end
				end
			end
		end

		if inService then
			drawTxt("PREMI ~g~F7~w~ PER FINIRE",4,0.5,0.96,0.50,255,255,255,200)
		end

		if inService then
			timeDistance = 4
			local veh = vRP.getNearestVehicle(7)
			if IsControlJustPressed(0,168) then
				inService = false
				TriggerEvent("Notify","avviso","Hai terminato il lavoro di <b>Autista</b> e il tuo veicolo funzionante è stato eliminato.",5000)
				if DoesBlipExist(blip) then
					RemoveBlip(blip)
					blip = nil
				end
				vGARAGE.deleteVehicles2(veh)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startdriveservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					local veh = GetVehiclePedIsUsing(ped)
					local coordsPed = GetEntityCoords(ped)
					local distance = #(coordsPed - vector3(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]))
					if distance <= 300 and IsVehicleModel(veh,GetHashKey("bus")) then
						timeDistance = 4
						DrawMarker(21,coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]+0.60,0,0,0,0,180.0,130.0,2.0,2.0,1.0,101, 190, 101,180,1,0,0,1)
						if distance <= 15 then
							if IsControlJustPressed(1,38) then
								if driverPosition == #coords then
									driverPosition = 1
									vSERVER.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(true,500)
								else
									driverPosition = driverPosition + 1
									vSERVER.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(false,0)
								end
								makeDriverBlips()
							end
						end
					end
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- makeDriverBlips
-----------------------------------------------------------------------------------------------------------------------------------------
function makeDriverBlips()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3])
		SetBlipSprite(blip,433)
		SetBlipColour(blip,2)
		SetBlipScale(blip,0.4)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Percorso dell'autobus")
		EndTextCommandSetBlipName(blip)
	end
end