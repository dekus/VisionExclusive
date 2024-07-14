local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP_server = Tunnel.getInterface("vrp_codes")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local CreateThread = CreateThread
local Wait = Wait
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ORTiming = 100

		if IsPedArmed(PlayerPedId(),6) then
			ORTiming = 4
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end
		Wait(ORTiming)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _, i in ipairs(GetActivePlayers()) do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Q COVER LOJA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetPlayerCanUseCover(PlayerId(),false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 4
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			local speed = GetEntitySpeed(vehicle)*3.6
			if GetEntityModel(vehicle) ~= GetEntityModel(vehicle) ~= GetHashKey('polmav') and GetEntityModel(vehicle) ~= GetHashKey('poliziaheli') then
				timeDistance = 4
				SetPedConfigFlag(PlayerPedId(),35,false) 
				if speed >= 40 or GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_STUNGUN") then
					timeDistance = 4
					DisableControlAction(0,69,true)
					DisableControlAction(0,92,true)
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			local speed = GetEntitySpeed(vehicle)*3.6
			timeDistance = 4
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				if speed <= 100.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end    
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEB COR NO TAB
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	ReplaceHudColourWithRgba(116, 127, 38, 193, 200)
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId(ped)
    local nome = GetPlayerName(ped)
    AddTextEntry('FE_THDR_GTAO', '~p~Vision Exclusive')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
    { -56.38, -1096.81, 26.43, 523, 4, "Concessionaria", 0.4 },
    { 55.43, -876.19, 30.66, 357, 4, "Garage", 0.4 },
    { 317.25, 2623.14, 44.46, 357, 4, "Garage", 0.4 },
    { -773.34, 5598.15, 33.60, 357, 4, "Garage", 0.4 },
    { 275.23, -345.54, 45.17, 357, 4, "Garage", 0.4 },
    { -340.76, 265.97, 85.67, 357, 4, "Garage", 0.4 },
    { -2030.01, -465.97, 11.60, 357, 4, "Garage", 0.4 },
    { -1184.92, -1510.00, 4.64, 357, 4, "Garage", 0.4 },
    { -73.44, -2004.99, 18.27, 357, 4, "Garage", 0.4 },
    { 214.02, -808.44, 31.01, 357, 4, "Garage", 0.4 },
    { -348.88, -874.02, 31.31, 357, 4, "Garage", 0.4 },
    { 67.74, 12.27, 69.21, 357, 4, "Garage", 0.4 },
    { 361.90, 297.81, 103.88, 357, 4, "Garage", 0.4 },
    { 1035.89, -763.89, 57.99, 357, 4, "Garage", 0.4 },
    { -796.63, -2022.77, 9.16, 357, 4, "Garage", 0.4 },
    { 453.27, -1146.76, 29.52, 357, 4, "Garage", 0.4 },
    { 528.66, -146.3, 58.38, 357, 4, "Garage", 0.4 },
    { -1159.48, -739.32, 19.89, 357, 4, "Garage", 0.4 },
    { 101.22, -1073.68, 29.38, 357, 4, "Garage", 0.4 },
    { -1592.35, -1005.43, 13.03, 357, 4, "Garage", 0.4 },
	{ 1160.74,-1643.59,36.95, 357, 4, "Garage", 0.4 },
	{ 118.11,-1951.03,20.75, 357, 4, "Garage", 0.4 },
	{ -32.07,-1391.3,29.42, 357, 4, "Garage", 0.4 },
	{ 362.06,297.81,103.89, 357, 4, "Garage", 0.4 },
	{ -1044.58,-223.75,37.88, 357, 4, "Garage", 0.4 },
	{ -1451.68,-579.49,31.25, 357, 4, "Garage", 0.4 },
	{ 1011.61,901.7,212.76, 357, 4, "Garage", 0.4 },
	{ -1824.23,806.02,138.85, 357, 4, "Garage", 0.4 },

    { -1610.26,181.06,59.78, 526, 27, "[!] Centrale di Polizia", 0.8 },
    { -1146.07,-1991.53,13.19, 643, 27, "[!] Meccanico", 0.8 },
    { 299.71, -584.75, 43.29, 621, 27, "[!] Ospedale", 0.8 },

    { 453.68,-600.89,28.6, 513, 2, "Autista", 0.6 },
    { -556.42,274.55,83.02, 522, 2, "VisionEat", 0.6 },
    { -229.76,-1377.14,31.26, 198, 2, "Tassista", 0.6 },
    { 2434.59,4678.23,33.38, 478, 2, "Arance", 0.6 },

    { 25.68, -1346.6, 29.5, 52, 66, "Negozio", 0.5 },
    { 2556.47, 382.05, 108.63, 52, 66, "Negozio", 0.5 },
    { 1163.55, -323.02, 69.21, 52, 66, "Negozio", 0.5 },
    { -707.31, -913.75, 19.22, 52, 66, "Negozio", 0.5 },
    { -47.72, -1757.23, 29.43, 52, 66, "Negozio", 0.5 },
    { 373.89, 326.86, 103.57, 52, 66, "Negozio", 0.5 },
    { -3242.95, 1001.28, 12.84, 52, 66, "Negozio", 0.5 },
    { 1729.3, 6415.48, 35.04, 52, 66, "Negozio", 0.5 },
    { 548.0, 2670.35, 42.16, 52, 66, "Negozio", 0.5 },
    { 1960.69, 3741.34, 32.35, 52, 66, "Negozio", 0.5 },
    { 2677.92, 3280.85, 55.25, 52, 66, "Negozio", 0.5 },
    { 1698.5, 4924.09, 42.07, 52, 66, "Negozio", 0.5 },
    { -1820.82, 793.21, 138.12, 52, 66, "Negozio", 0.5 },
    { 1393.21, 3605.26, 34.99, 52, 66, "Negozio", 0.5 },
    { -2967.78, 390.92, 15.05, 52, 66, "Negozio", 0.5 },
    { -3040.14, 585.44, 7.91, 52, 66, "Negozio", 0.5 },
    { 1135.56, -982.24, 46.42, 52, 66, "Negozio", 0.5 },
    { 1166.0, 2709.45, 38.16, 52, 66, "Negozio", 0.5 },
    { -1487.21, -378.99, 40.17, 52, 66, "Negozio", 0.5 },
    { -1222.76, -907.21, 12.33, 52, 66, "Negozio", 0.5 },

    { 1692.62, 3759.50, 34.70, 76, 66, "Armeria", 0.5 },
    { 252.89, -49.25, 69.94, 76, 66, "Armeria", 0.5 },
    { 843.28, -1034.02, 28.19, 76, 66, "Armeria", 0.5 },
    { -331.35, 6083.45, 31.45, 76, 66, "Armeria", 0.5 },
    { -663.15, -934.92, 21.82, 76, 66, "Armeria", 0.5 },
    { -1305.18, -393.48, 36.69, 76, 66, "Armeria", 0.5 },
    { -1118.80, 2698.22, 18.55, 76, 66, "Armeria", 0.5 },
    { 2568.83, 293.89, 108.73, 76, 66, "Armeria", 0.5 },
    { -3172.68, 1087.10, 20.83, 76, 66, "Armeria", 0.5 },
    { 21.32, -1106.44, 29.79, 76, 66, "Armeria", 0.5 },
    { 811.19, -2157.67, 29.61, 76, 66, "Armeria", 0.5 },

    { -815.12, -184.15, 37.57, 71, 4, "Barbiere", 0.4 },
    { 138.13, -1706.46, 29.3, 71, 4, "Barbiere", 0.4 },
    { -1280.92, -1117.07, 7.0, 71, 4, "Barbiere", 0.4 },
    { 1930.54, 3732.06, 32.85, 71, 4, "Barbiere", 0.4 },
    { 1214.2, -473.18, 66.21, 71, 4, "Barbiere", 0.4 },
    { -33.61, -154.52, 57.08, 71, 4, "Barbiere", 0.4 },
    { -276.65, 6226.76, 31.7, 71, 4, "Barbiere", 0.4 },
    { -1605.04, -1074.22, 13.02, 71, 4, "Barbiere", 0.4 },

    { 75.35, -1392.92, 29.38, 73, 4, "Negozio di Vestiti", 0.5 },
    { -710.15, -152.36, 37.42, 73, 4, "Negozio di Vestiti", 0.5 },
    { -163.73, -303.62, 39.74, 73, 4, "Negozio di Vestiti", 0.5 },
    { -822.38, -1073.52, 11.33, 73, 4, "Negozio di Vestiti", 0.5 },
    { -1193.13, -767.93, 17.32, 73, 4, "Negozio di Vestiti", 0.5 },
    { -1449.83, -237.01, 49.82, 73, 4, "Negozio di Vestiti", 0.5 },
    { 4.83, 6512.44, 31.88, 73, 4, "Negozio di Vestiti", 0.5 },
    { 1693.95, 4822.78, 42.07, 73, 4, "Negozio di Vestiti", 0.5 },
    { 125.82, -223.82, 54.56, 73, 4, "Negozio di Vestiti", 0.5 },
    { 614.2, 2762.83, 42.09, 73, 4, "Negozio di Vestiti", 0.5 },
    { 1196.72, 2710.26, 38.23, 73, 4, "Negozio di Vestiti", 0.5 },
    { -3170.53, 1043.68, 20.87, 73, 4, "Negozio di Vestiti", 0.5 },
    { -1101.42, 2710.63, 19.11, 73, 4, "Negozio di Vestiti", 0.5 },
    { 425.6, -806.25, 29.5, 73, 4, "Negozio di Vestiti", 0.5 },
    { -1612.43, -1076.81, 13.02, 73, 4, "Negozio di Vestiti", 0.5 },

    { 1322.93, -1652.29, 52.27, 75, 4, "Negozio di Tatuaggi", 0.4 },
    { -1154.42, -1425.9, 4.95, 75, 4, "Negozio di Tatuaggi", 0.4 },
    { 322.84, 180.16, 103.58, 75, 4, "Negozio di Tatuaggi", 0.4 },
    { -3169.62, 1075.8, 20.83, 75, 4, "Negozio di Tatuaggi", 0.4 },
    { 1864.07, 3747.9, 33.03, 75, 4, "Negozio di Tatuaggi", 0.4 },
    { -293.57, 6199.85, 31.48, 75, 4, "Negozio di Tatuaggi", 0.4 },
    { 47.01,-1749.98,29.61, 564, 0, "Marketplace", 0.5 },
    { 81.99,-1615.39,29.6, 51, 3, "Vendita di droga", 0.4 },
	{ 707.28, -966.92, 30.42, 459, 2, "Scambio", 0.6 },
	{ -1082.8,-254.28,37.77, 77, 1, "Life Invader", 0.6 },
	{ -1391.16,-595.93,30.15, 93, 27, "Bahama Mamas", 0.6 },

	

    { -1071.7,-1668.48,4.43,429,1, "Organizzazione Illegale", 0.6 }, -- bloods
    { 1280.27,-1732.8,52.56,429,3, "Organizzazione Illegale", 0.6 }, -- crips
    { 1002.78,898.38,210.23,429,45, "Organizzazione Illegale", 0.6 }, -- yardie
    { -1829.21,857.16,150.55,429,40, "Organizzazione Illegale", 0.7 }, -- siciliana
    { -162.56,-1698.82,31.56,429,2, "Organizzazione Illegale", 0.6 }, -- groove
    { 86.06,-1924.46,20.79,429,27, "Organizzazione Illegale", 0.6 }, -- ballas
    { 323.04,-2030.81,20.8,429,5, "Organizzazione Illegale", 0.6 } -- vagos

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)



-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- TELEPORT
-- -----------------------------------------------------------------------------------------------------------------------------------------
 local teleport = {
 	{ from = {96.96,6323.8,31.38}, to = {-154.46,-1623.91,33.72} },    -- GROOVE
 	{ from = {-154.46,-1623.91,33.72}, to = {96.96,6323.8,31.38} },	   -- GROOVE
 	{ from = {297.88,-2034.73,19.84}, to = {-1090.0,4949.01,218.35} }, -- VAGOS
 	{ from = {-1090.0,4949.01,218.35}, to = {297.88,-2034.73,19.84} }, -- VAGOS
	{ from = { 84.26,-1966.71,20.94 }, to = {1480.57,6382.86,23.31} }, -- BALLAS
	{ from = { 1480.57,6382.86,23.31 }, to = {84.26,-1966.71,20.94} }, -- BALLAS
 }
 Citizen.CreateThread(function()
 	while true do
 		local timeDistance = 500
 		local ped = PlayerPedId()
 		if not IsPedInAnyVehicle(ped) then
 			local coords = GetEntityCoords(ped)
 			for k,v in pairs(teleport) do
				local distance = #(coords - vector3(v.from[1],v.from[2],v.from[3]))
				if distance <= 3 then
					timeDistance = 4
					if distance <= 1 and IsControlJustPressed(1,38) then
						Wait(300)
						SetEntityCoords(ped,v.to[1],v.to[2],v.to[3])
					end
				end
 			end
 		end
 		Citizen.Wait(timeDistance)
 	end
 end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedBeingStunned(ped) then
			timeDistance = 4
			SetPedToRagdoll(ped,7500,7500,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			timeDistance = 4
			TriggerEvent("cancelando",true)
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR X NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
				timeDistance = 4
				DisableControlAction(0,345,true)
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVAR CAMERA AFK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        InvalidateIdleCam()
        InvalidateVehicleIdleCam()
        Wait(1000)
    end
end)