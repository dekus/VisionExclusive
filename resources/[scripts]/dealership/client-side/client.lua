local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local inTest = false 
local maxDistance = 300
local openedConce = 0
local conces = { 
    [1] = { -29.73,-1104.38,26.43,
     test_locais = { 
            { coords = vec3(-1328.86,-2382.94,13.95), h = 129.4 },
            { coords = vec3(-1341.57,-2377.35,13.95), h = 122.02 },
            { coords = vec3(-1358.54,-2408.93,13.95), h = 126.74 },
            { coords = vec3(-1328.3,-2426.46,13.95), h = 117.45 }
        }
    }
}

Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(conces) do
		table.insert(innerTable,{ v[1],v[2],v[3],2.5,"E","listino","apri","premi" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)

local vehicleTable 

RegisterKeyMapping("conce", 'Abrir Conce',"keyboard","E")
RegisterCommand("conce", function(source, args, rawCmd)
	SetNuiFocus(false,false)
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped) and not inTest and GetEntityHealth(ped) > 101 then 
        local coords = GetEntityCoords(ped)
        for k,v in pairs(conces) do 
            local distance = #(coords - vec3(v[1],v[2],v[3]))
            if distance <= 5 then
                openConce()
                openedConce = k
            end
        end
    end
end) 

openConce = function()
    local veiculos,infos = vSERVER.returnVehList()
    if veiculos and infos then 
        vehicleTable = veiculos
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = "open",
            infos = infos,
        })
    end
end

closeConce = function()
    SetNuiFocus(false,false)
    SetCursorLocation(0.5,0.5)
    SendNUIMessage({ action = "close" })
end

RegisterNUICallback("close",function(data,cb)
    closeConce()
end)

RegisterNUICallback("requestVeh",function(data,cb)
    cb(vehicleTable[data.category])
end)


RegisterNUICallback("startTest",function(data,cb)
    closeConce()
    vSERVER.startTest({data.category, data.vehicle})
end)

RegisterNUICallback("buyVehicle",function(data,cb)
    closeConce()
    vSERVER.buyVehicle({data.category, data.vehicle, data.payment})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEST DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.testDrive(model,price)
	local mhash = loadModel(model)
	closeConce()
	if mhash then
	local count = 0
        for k,v in pairs(conces[parseInt(openedConce)].test_locais) do
            local spawnCoords = v.coords
            local closestVehicleOnSpot = GetClosestVehicle(spawnCoords.x,spawnCoords.y,spawnCoords.z,3.001,0,71)
            if DoesEntityExist(closestVehicleOnSpot) then
                count = count + 1
                if count >= 4 then
                   
                    TriggerEvent('Notify', 'negato', 'Tutti i posti vacanti sono attualmente occupati.', 3000)
                    vSERVER.chargeBack(price)
                    vSERVER.changeSession(false)
                    return
                end
            else
                Citizen.CreateThread(function()
                    inTest = true
                    vSERVER.changeSession(true)
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    local myCoords = GetEntityCoords(PlayerPedId())
                    SetEntityCoords(PlayerPedId(), spawnCoords)
                    local veh = createVehicle(mhash,spawnCoords)
                    SetEntityHeading(veh, v.h)
                    SetPedIntoVehicle(PlayerPedId(), veh, -1)
                    SetVehicleDoorsLocked(veh,4)
                    DoScreenFadeIn(1000)
                    TriggerEvent("Notify","importante","hai 1 minuto.",10000)
                    waitTest()
                    while inTest and IsPedInAnyVehicle(PlayerPedId(),false) and #(GetEntityCoords(PlayerPedId()) - spawnCoords) < maxDistance
                    and GetPedInVehicleSeat(veh,-1) == PlayerPedId() do
                        Citizen.Wait(500)
                    end
                    if inTest then
                        inTest = false
                        TriggerEvent("Notify","importante","Testi drive eliminato.",10000)
                        if #(GetEntityCoords(PlayerPedId()) - spawnCoords) >= maxDistance then
                            TriggerEvent("Notify","importante","Ti sei allontanato troppo dall'area del test.",10000)
                        end
                        vSERVER.changeSession(false)
                    else
                        TriggerEvent("Notify","importante","Test Drive finito con successo.",10000)
                        vSERVER.changeSession(false)
                    end
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetEntityAsNoLongerNeeded(veh)
                    SetEntityAsMissionEntity(veh,true,true)
                    DeleteVehicle(veh)
                    SetEntityCoords(PlayerPedId(), myCoords)
                    Wait(1000)
                    DoScreenFadeIn(1000)
                    if GetEntityHealth(PlayerPedId()) < 102 then
                        vRP.killGod()
                        vRP.setHealth(150)
                    end
                end)
             return
         end
    end

	else
		TriggerEvent("Notify","importante","Veicolo non disponibile per il test drive.",10000)
		vSERVER.chargeBack(price)
	end
end


--- CRIA O VEÍCULO DO TEST DRIVE

function createVehicle(mhash, spawnCoords)
	local vehicle = CreateVehicle(mhash,spawnCoords.x,spawnCoords.y,spawnCoords.z,0.0,true,true)
	if DoesEntityExist(vehicle) then
		local netveh = VehToNet(vehicle)
		NetworkRegisterEntityAsNetworked(vehicle)
		while not NetworkGetEntityIsNetworked(vehicle) do
			NetworkRegisterEntityAsNetworked(vehicle)
			Citizen.Wait(1)
		end
		if NetworkDoesNetworkIdExist(netveh) then
			SetEntitySomething(vehicle,true)
			if NetworkGetEntityIsNetworked(vehicle) then
				SetNetworkIdExistsOnAllMachines(netveh,true)
			end
		end
		SetVehicleIsStolen(vehicle,false)
		SetVehicleNeedsToBeHotwired(vehicle,false)
		SetEntityInvincible(vehicle,false)
		SetEntityAsMissionEntity(vehicle,true,true)
		SetVehicleHasBeenOwnedByPlayer(vehicle,true)
		SetVehicleNumberPlateText(vehicle,vRP.getRegistrationNumber())

		SetVehRadioStation(vehicle,"OFF")
		SetModelAsNoLongerNeeded(mhash)
	end
	return vehicle
end


-- CARREGAR O MODEL DO VEÍCULO --
function loadModel(model)
	local mhash = GetHashKey(model)
	local timeout = 5000
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		timeout = timeout - 1
		if timeout <= 0 then
			return false
		end
		Citizen.Wait(1)
	end
	return mhash
end

--- EXPOSIÇÃO DE CARROS

local vehs = {  
 --   [1] = { ["model"] = "sultan3", ["name"] = "sultan3", ['x'] = -41.37, ['y'] = -1096.08, ['z'] = 26.43, ["h"] = 130.60},
 --   [2] = { ["model"] = "coquette4", ["name"] = "coquette4", ['x'] = -44.76, ['y'] = -1093.98, ['z'] = 26.43, ["h"] = 130.01},
 --   [3] = { ["model"] = "growler", ["name"] = "growler", ['x'] = -48.73, ['y'] = -1092.49, ['z'] = 26.43, ["h"] = 130.43},
 --   [4] = { ["model"] = "bati2", ["name"] = "bati2", ['x'] = -38.93, ['y'] = -1097.35, ['z'] = 26.43, ["h"] = 130.43},
 --   [5] = { ["model"] = "s10", ["name"] = "s10", ['x'] = 811.06, ['y'] = -956.3, ['z'] = 26.78, ["h"] = 241.43},
 --   [6] = { ["model"] = "mansm8", ["name"] = "mansm8", ['x'] = 811.14, ['y'] = -968.13, ['z'] = 26.78, ["h"] = 241.43},
  --  [7] = { ["model"] = "s10", ["name"] = "s10", ['x'] = 810.54, ['y'] = -980.03, ['z'] = 26.78, ["h"] = 241.43},
}              


Citizen.CreateThread(function()
    for i = 0,#vehs do
        if vehs[i] then
            local carmodel = GetHashKey(vehs[i].model)
            RequestModel(carmodel)

            while not HasModelLoaded(carmodel) do
                Wait(0)
            end

            vehicle = CreateVehicle(carmodel, vehs[i].x, vehs[i].y, vehs[i].z -1, vehs[i].h, false, false)
            FreezeEntityPosition(vehicle, true)
            SetEntityInvincible(vehicle, true)
            SetVehicleDoorsLocked(vehicle, 2)
        end
        
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CHAMAR
-----------------------------------------------------------------------------------------------------------------------------------------
waitTest = function()
    Wait(45000)
    inTest = false
end
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
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
--local vehs = {  
--    [1] = { ["model"] = "deluxo", ["name"] = "deluxo", ['x'] = -48.93, ['y'] = -1101.94, ['z'] = 26.43, ["h"] = 130.60},
--}              


--Citizen.CreateThread(function()
--    for i = 0,#vehs do
--        if vehs[i] then
--            local carmodel = GetHashKey(vehs[i].model)
--            RequestModel(carmodel)
--
---            while not HasModelLoaded(carmodel) do
--                Wait(0)
--            end
--
--           vehicle = CreateVehicle(carmodel, vehs[i].x, vehs[i].y, vehs[i].z -1, vehs[i].h, false, false)
--           FreezeEntityPosition(vehicle, true)
--           SetEntityInvincible(vehicle, true)
--            SetVehicleDoorsLocked(vehicle, 2)
--        end
--        
--    end
--end)
----------------