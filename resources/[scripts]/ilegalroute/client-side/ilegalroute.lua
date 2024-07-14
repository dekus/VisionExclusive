local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

rusherFarm = Tunnel.getInterface("npc_farms")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


local LocaisRotas = {
    ['bloods.autorizzazione'] =  {-1075.27,-1678.72,4.58},
    ['crips.autorizzazione'] =  {1272.39,-1714.5,54.78},
    ['siciliana.autorizzazione'] =  {-1857.74,884.84,165.88},
    ['yardie.autorizzazione'] =  {1063.48,957.11,240.68},
    ['bahamas.autorizzazione'] =  {-1386.03,-591.27,30.32},
    ['life.autorizzazione'] =  {-1066.69,-243.88,44.03}
}


local RotasFarms = { -- Le fazioni che hanno materie prime indiscusse dovranno fare dei percorsi per ottenere i COMPONENTI base
    [1] = { ['x'] = -1816.41, ['y'] = 796.09, ['z'] = 138.12 }, -- YARDIE
    [2] = { ['x'] = -1996.32, ['y'] = 548.07, ['z'] = 110.16 },
    [3] = { ['x'] = -1561.53, ['y'] = -210.57, ['z'] = 55.54 },
    [4] = { ['x'] = -1151.28, ['y'] = -163.41, ['z'] = 40.1 },
    [5] = { ['x'] = -767.02, ['y'] = -23.19, ['z'] = 41.09 },
    [6] = { ['x'] = -96.96, ['y'] = 42.69, ['z'] = 71.62 },
    [7] = { ['x'] = 173.16, ['y'] = -26.03, ['z'] = 68.35 },
    [8] = { ['x'] = 538.51, ['y'] = 101.72, ['z'] = 96.54 },
    [9] = { ['x'] = 649.73, ['y'] = 246.54, ['z'] = 103.43 },
    [10] = { ['x'] = 814.34, ['y'] = -93.54, ['z'] = 80.6 },
    [11] = { ['x'] = 1169.07, ['y'] = -291.67, ['z'] = 69.03 },
    [12] = { ['x'] = 1121.21, ['y'] = -645.85, ['z'] = 56.82 },
    [13] = { ['x'] = 910.7, ['y'] = -1025.33, ['z'] = 38.16 },
    [14] = { ['x'] = 765.16, ['y'] = -1225.62, ['z'] = 25.21 },
    [15] = { ['x'] = 746.63, ['y'] = -1399.4, ['z'] = 26.63 },
    [16] = { ['x'] = 343.14, ['y'] = -1298.02, ['z'] = 32.51 },
    [17] = { ['x'] = 12.22, ['y'] = -1300.05, ['z'] = 29.23 },
    [18] = { ['x'] = -287.19, ['y'] = -1061.79, ['z'] = 27.21 },
    [19] = { ['x'] = -512.57, ['y'] = -734.46, ['z'] = 32.7 },
    [20] = { ['x'] = -773.38, ['y'] = -633.55, ['z'] = 29.83 },

    [21] = { ['x'] = -1816.41, ['y'] = 796.09, ['z'] = 138.12 }, -- SICILIANA
    [22] = { ['x'] = -1996.32, ['y'] = 548.07, ['z'] = 110.16 },
    [23] = { ['x'] = -1561.53, ['y'] = -210.57, ['z'] = 55.54 },
    [24] = { ['x'] = -1151.28, ['y'] = -163.41, ['z'] = 40.1 },
    [25] = { ['x'] = -767.02, ['y'] = -23.19, ['z'] = 41.09 },
    [26] = { ['x'] = -96.96, ['y'] = 42.69, ['z'] = 71.62 },
    [27] = { ['x'] = 173.16, ['y'] = -26.03, ['z'] = 68.35 },
    [28] = { ['x'] = 538.51, ['y'] = 101.72, ['z'] = 96.54 },
    [29] = { ['x'] = 649.73, ['y'] = 246.54, ['z'] = 103.43 },
    [30] = { ['x'] = 814.34, ['y'] = -93.54, ['z'] = 80.6 },
    [31] = { ['x'] = 1169.07, ['y'] = -291.67, ['z'] = 69.03 },
    [32] = { ['x'] = 1121.21, ['y'] = -645.85, ['z'] = 56.82 },
    [33] = { ['x'] = 910.7, ['y'] = -1025.33, ['z'] = 38.16 },
    [34] = { ['x'] = 765.16, ['y'] = -1225.62, ['z'] = 25.21 },
    [35] = { ['x'] = 746.63, ['y'] = -1399.4, ['z'] = 26.63 },
    [36] = { ['x'] = 343.14, ['y'] = -1298.02, ['z'] = 32.51 },
    [37] = { ['x'] = 12.22, ['y'] = -1300.05, ['z'] = 29.23 },
    [38] = { ['x'] = -287.19, ['y'] = -1061.79, ['z'] = 27.21 },
    [39] = { ['x'] = -512.57, ['y'] = -734.46, ['z'] = 32.7 },
    [40] = { ['x'] = -773.38, ['y'] = -633.55, ['z'] = 29.83 },

    [41] = {['x'] = 963.79, ['y'] = -1780.22, ['z'] = 31.24}, -- CRIPS 
    [42] = {['x'] = 939.19, ['y'] = -1877.22, ['z'] = 32.48},
    [43] = {['x'] = 784.07, ['y'] = -2254.21, ['z'] = 29.5},
    [44] = {['x'] = 182.92, ['y'] = -2027.68, ['z'] = 18.28},
    [45] = {['x'] = -621.37, ['y'] = -1640.13, ['z'] = 26.11},
    [46] = {['x'] = -703.88, ['y'] = -1398.17, ['z'] = 5.5},
    [47] = {['x'] = -812.52, ['y'] = -980.46, ['z'] = 14.26},
    [48] = {['x'] = -1285.35, ['y'] = -566.73, ['z'] = 31.72},
    [49] = {['x'] = -1413.44, ['y'] = -139.03, ['z'] = 48.77},
    [50] = {['x'] = -1384.06, ['y'] = 267.73, ['z'] = 61.24},
    [51] = {['x'] = -756.42, ['y'] = 240.85, ['z'] = 75.67},
    [52] = {['x'] = -304.64, ['y'] = 104.47, ['z'] = 67.89},
    [53] = {['x'] = -84.41, ['y'] = 234.95, ['z'] = 100.57},
    [54] = {['x'] = 412.21, ['y'] = 315.06, ['z'] = 103.14},
    [55] = {['x'] = 646.39, ['y'] = 267.43, ['z'] = 103.27},
    [56] = {['x'] = 751.3, ['y'] = 224.0, ['z'] = 87.43},
    [57] = {['x'] = 896.06, ['y'] = -144.82, ['z'] = 76.87},
    [58] = {['x'] = 1249.36, ['y'] = -350.59, ['z'] = 69.21},
    [59] = {['x'] = 1154.6, ['y'] = -785.3, ['z'] = 57.6},
    [60] = {['x'] = 1213.83, ['y'] = -1256.38, ['z'] = 35.23},

    [61] = {['x'] = -1244.15, ['y'] = -1489.11, ['z'] = 4.37}, -- BLOODS
    [62] = {['x'] = -2002.24, ['y'] = -557.44, ['z'] = 12.89},
    [63] = {['x'] = -1952.99, ['y'] = -301.89, ['z'] = 43.82},
    [64] = {['x'] = -1681.26, ['y'] = -291.16, ['z'] = 51.89},
    [65] = {['x'] = -1409.12, ['y'] = -109.28, ['z'] = 51.66},
    [66] = {['x'] = -880.72, ['y'] = -194.73, ['z'] = 38.79},
    [67] = {['x'] = -509.35, ['y'] = -22.84, ['z'] = 45.61},
    [68] = {['x'] = -242.07, ['y'] = 279.84, ['z'] = 92.04},
    [69] = {['x'] = 120.89, ['y'] = 337.83, ['z'] = 112.1},
    [70] = {['x'] = 571.62, ['y'] = 194.01, ['z'] = 101.65},
    [71] = {['x'] = 418.64, ['y'] = -207.09, ['z'] = 59.92},
    [72] = {['x'] = 20.89, ['y'] = -207.76, ['z'] = 52.86},
    [73] = {['x'] = -156.43, ['y'] = -154.89, ['z'] = 43.63},
    [74] = {['x'] = -783.69, ['y'] = -390.94, ['z'] = 37.35},
    [75] = {['x'] = -827.3, ['y'] = -691.49, ['z'] = 28.06},
    [76] = {['x'] = -812.47, ['y'] = -980.6, ['z'] = 14.25},
    [77] = {['x'] = -956.44, ['y'] = -1105.35, ['z'] = 2.16},
    [78] = {['x'] = -1154.88, ['y'] = -931.27, ['z'] = 2.78},
    [79] = {['x'] = -1556.54, ['y'] = -1154.53, ['z'] = 3.92},
    [80] = {['x'] = -1392.89, ['y'] = -1326.67, ['z'] = 4.16},

    [81] = {['x'] = -1484.33, ['y'] = -390.18, ['z'] = 39.1}, -- BAHAMAS / LIFE
    [82] = {['x'] = -1582.83, ['y'] = -234.81, ['z'] = 54.85},
    [83] = {['x'] = -1995.71, ['y'] = 547.08, ['z'] = 110.16},
    [84] = {['x'] = -3179.0, ['y'] = 1301.0, ['z'] = 14.59},
    [85] = {['x'] = -3206.0, ['y'] = 1139.0, ['z'] = 9.91},
    [86] = {['x'] = -3068.89, ['y'] = 784.04, ['z'] = 21.37},
    [87] = {['x'] = -2949.84, ['y'] = 455.0, ['z'] = 15.31},
    [88] = {['x'] = -3099.79, ['y'] = 211.69, ['z'] = 14.08},
    [89] = {['x'] = -3024.32, ['y'] = 80.33, ['z'] = 11.61},
    [90] = {['x'] = -2223.06, ['y'] = -365.68, ['z'] = 13.33},
    [91] = {['x'] = -1356.66, ['y'] = -791.27, ['z'] = 20.25},
    [92] = {['x'] = -1152.99, ['y'] = -797.99, ['z'] = 15.5},
    [93] = {['x'] = -1316.18, ['y'] = -383.69, ['z'] = 36.68}

}

--local TempoDeAnimacao = 15 -- segundos
local PegandoMateriaPrima = false
local PosRota = 0
local blip = false
local PermCliente = nil
local TemPerm = false

Citizen.CreateThread(function() 
   while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        -------------------------------------------------
        --- FARM DE MATÉRIAS PRIMAS PARA BLOODS/CRIPS/MÁFIAS
        -------------------------------------------------
        if not PegandoMateriaPrima then 
            for k, v in pairs(LocaisRotas) do     
                local distPonto = GetDistanceBetweenCoords(x,y,z, v[1], v[2], v[3], true)
                if  distPonto < 15 then
                    timeDistance = 4 
                    DrawMarker(21, v[1], v[2], v[3]-0.3, 0, 0, 0, 180.0, 0, 0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1)
                    if distPonto < 1.5 then
                        if IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 then
                            TemPerm, PermCliente = rusherFarm.OFlyNcqwyVnLBLqXkEnJeScFb(k)
                            if TemPerm then
                                TriggerEvent('Notify', 'successo','Raccolta iniziata con successo.')
                                PegandoMateriaPrima = true
                                if PermCliente == 'yardie.autorizzazione' then -- OK
                                    PosRota = 1
                                elseif PermCliente == 'siciliana.autorizzazione' then -- OK
                                    PosRota = 21
                                elseif PermCliente == 'crips.autorizzazione' then -- OK
                                    PosRota = 41
                                elseif PermCliente == 'bloods.autorizzazione' then -- OK
                                    PosRota = 61
                                elseif PermCliente == 'bahamas.autorizzazione' or PermCliente == 'life.autorizzazione' then -- OK
                                    PosRota = 81
                                end
                                makeBlipMarked(RotasFarms,PosRota)
                            end
                        end
                    end
                end
            end
        end

        if PegandoMateriaPrima then
            local distPonto = GetDistanceBetweenCoords(x,y,z, RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z, true)
            if distPonto < 15 then
                timeDistance = 4 
                DrawMarker(21, RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z-0.3, 0, 0, 0, 180.0, 0, 0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1)
                if distPonto < 5.0 then
                    DT3DFarm(RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z, '~p~[E] ~w~PER PRENDERE IL MATERIALE',255,255,255)
                    if IsControlJustPressed(0, 38) then
                        if not IsPedInAnyVehicle(ped) and TemPerm then
                            if blip then
                                timeDistance = 4 
                                RemoveBlip(blips)
                                blip = false
                            end
                            rusherFarm.rqkWrVlbDiRADhQwchLtLdZuk(PermCliente)
                            FreezeEntityPosition(PlayerPedId(), true)
                            vRP._playAnim(false,{"pickup_object","pickup_low"},false)
                            TriggerEvent('progress', 2000)
                            Wait(2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(ped)
                            if PosRota == 20 then
                                PosRota = 1
                            elseif PosRota == 40 then
                                PosRota = 21
                            elseif PosRota == 60 then
                                PosRota = 41
                            elseif PosRota == 80 then
                                PosRota = 61
                            elseif PosRota == 93 then
                                PosRota = 81
                            else
                                PosRota = PosRota + 1
                            end
                            makeBlipMarked(RotasFarms,PosRota)
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- HOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(LocaisRotas) do
		table.insert(innerTable,{ v[1],v[2],v[3],1.5,"E","Raccolta","Iniziare","Premi" })
	end
	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if PegandoMateriaPrima then
			timeDistance = 4
			if IsControlJustPressed(0,168) then
				PegandoMateriaPrima = false
				RemoveBlip(blips)
				TriggerEvent('Notify', 'avviso','Hai annullato la raccolta.')
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------

function dTFarm(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(10)
	end
end

function makeBlipMarked(RotasFarms,PosRota)
    if DoesBlipExist(blips) then
        RemoveBlip(blips)
        blips = nil
    end

    blips = AddBlipForCoord(RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z)
    SetBlipSprite(blips,501)
    SetBlipColour(blips,5)
    SetBlipScale(blips,0.4)
    SetBlipAsShortRange(blips,false)
    SetBlipRoute(blips,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Raccolta di materiali")
    EndTextCommandSetBlipName(blips)
end

function DT3DFarm(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.35, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 55, 55, 55, 68)
    end
end

