-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local vSERVER = Tunnel.getInterface("vrp_taxi")
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
	[1] = { -501.24,-1388.74,29.44 },
	[2] = { -473.24,-1211.13,21.01 },
	[3] = { -604.31,-953.54,22.0 },
	[4] = { -1020.39,-793.36,17.02 },
	[5] = { -1298.93,-651.33,26.46 },
	[6] = { -1667.86,-542.84,34.95 },
	[7] = { -2110.87,-355.02,12.91 },
	[8] = { -3007.99,130.93,14.99 },
	[9] = { -2976.45,451.73,15.13 },
	[10] = { -3149.49,1096.81,20.71 },
	[11] = { -2700.09,2321.43,17.48 },
	[12] = { -2469.39,3618.12,14.11 },
	[13] = { -2208.19,4298.42,48.18 },
	[14] = { -1914.77,4597.48,57.06 },
	[15] = { -1521.25,4956.75,62.21 },
	[16] = { -1048.12,5330.68,44.71 },
	[17] = { -397.78,5966.19,31.77 },
	[18] = { 153.18,6517.65,31.62 },
	[19] = { 807.19,6490.4,23.48 },
	[20] = { 1470.36,6508.12,20.88 },
	[21] = { 1938.19,6246.57,43.69 },
	[22] = { 2448.37,5617.47,44.98 },
	[23] = { 2713.94,4660.46,44.45 },
	[24] = { 2682.87,3262.44,55.25 },
	[25] = { 2105.63,2690.51,50.27 },
	[26] = { 1856.04,2587.15,45.68 },
	[27] = { 1691.53,1471.03,85.23 },
	[28] = { 1535.32,846.07,77.45 },
	[29] = { 1058.43,462.43,93.11 },
	[30] = { 729.48,192.86,86.03 },
	[31] = { 321.07,-89.14,68.97 },
	[32] = { 38.17,-243.04,48.58 },
	[33] = { -389.65,-375.58,31.76 },
	[34] = { -653.0,-606.49,33.26 },
	[35] = { -530.27,-845.37,29.83 },
	[36] = { -545.46,-1021.42,22.85 },
	[37] = { -309.64,-1147.63,23.75 },
	[38] = { -111.97,-1269.5,29.28 },
	[39] = { -180.6,-1395.22,30.72 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
local inLocate = { -229.76,-1377.14,31.26 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000

		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vector3(inLocate[1],inLocate[2],inLocate[3]))

		if distance <= 15.0 then
			timeDistance = 2
			if not inService then
				DrawMarker(21,inLocate[1],inLocate[2],inLocate[3],0,0,0,0,0,0,0.5,0.5,0.5,101, 190, 101,180,1,0,0,1)	
			end
			
			if distance <= 1.1 then
				timeDistance = 1
				if not inService then
					drawTxt("PREMI ~g~E~w~ PER INIZIARE IL CORSO",4,0.5,0.96,0.50,255,255,255,200)
				end
				if IsControlJustPressed(1,38) then
					if not inService then
						starttaxiservice()
						inService = true
						makeTaxiBlips()
						TriggerEvent("Notify","successo","Hai iniziato il lavoro di <b>Taxi Driver</b>.",5000)
						TriggerEvent("Notify","successo","<b>Recati al ped dietro per prendere il veicolo ed iniziare il lavoro.<b>",10000)
					end
				end
			end
		end

		if inService then
			drawTxt("PREMI ~g~F7~w~ PER FINIRE",4,0.5,0.96,0.50,255,255,255,200)
		end

		if inService then
			timeDistance = 1
			local veh = vRP.getNearestVehicle(7)
			if IsControlJustPressed(0,168) then
				inService = false
				TriggerEvent("Notify","avviso","Hai terminato il lavoro <b>Taxi Driver</b> e il tuo veicolo funzionante è stato eliminato.",5000)
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
function starttaxiservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					local veh = GetVehiclePedIsUsing(ped)
					local coordsPed = GetEntityCoords(ped)
					local distance = #(coordsPed - vector3(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]))
					if distance <= 300 and IsVehicleModel(veh,GetHashKey("taxi")) then
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
								makeTaxiBlips()
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
-- makeTaxiBlips
-----------------------------------------------------------------------------------------------------------------------------------------
function makeTaxiBlips()
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
		AddTextComponentString("Percorso Taxi")
		EndTextCommandSetBlipName(blip)
	end
end