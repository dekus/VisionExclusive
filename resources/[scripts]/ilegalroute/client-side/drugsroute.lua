local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

rusherDrugRoute = Tunnel.getInterface("entrega_drogas")
vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")


local PosDrogas = {
    [1] = {['x'] = -102.52, ['y'] = -11.47, ['z'] = 66.36},
    [2] = {['x'] = 51.35, ['y'] = -1317.7, ['z'] = 29.29},
    [3] = {['x'] = 36.35, ['y'] = -1284.07, ['z'] = 29.3}, 
    [4] = {['x'] = 106.06, ['y'] = -1281.0, ['z'] = 29.27},
    [5] = {['x'] = 175.73, ['y'] = -1279.81, ['z'] = 29.27},
    [6] = {['x'] = 311.67, ['y'] = -1287.48, ['z'] = 31.16},
    [7] = {['x'] = 373.77, ['y'] = -1267.74, ['z'] = 32.52},
    [8] = {['x'] = 445.91, ['y'] = -1241.65, ['z'] = 30.28},
    [9] = {['x'] = 382.3, ['y'] = -1076.63, ['z'] = 29.43},
    [10] = {['x'] = 311.96, ['y'] = -1005.56, ['z'] = 29.32},
    [11] = {['x'] = 288.16, ['y'] = -920.52, ['z'] = 29.47},
    [12] = {['x'] = 289.45, ['y'] = -778.64, ['z'] = 29.34},
    [13] = {['x'] = 202.79, ['y'] = -587.72, ['z'] = 29.44},
    [14] = {['x'] = -116.76, ['y'] = -603.05, ['z'] = 36.29},
    [15] = {['x'] = -52.74, ['y'] = -397.59, ['z'] = 38.13},
    [16] = {['x'] = -17.87, ['y'] = -296.63, ['z'] = 45.75},
    [17] = {['x'] = 76.45, ['y'] = -232.62, ['z'] = 51.4},
    [18] = {['x'] = 66.12, ['y'] = -137.26, ['z'] = 55.12},
    [19] = {['x'] = 113.86, ['y'] = -5.35, ['z'] = 67.83},
    [20] = {['x'] = 193.35, ['y'] = 103.71, ['z'] = 93.53},
    [21] = {['x'] = 262.94, ['y'] = 133.65, ['z'] = 103.24},
    [22] = {['x'] = 303.96, ['y'] = 134.12, ['z'] = 104.12},
    [23] = {['x'] = 358.88, ['y'] = 88.84, ['z'] = 100.36},
    [24] = {['x'] = 288.04, ['y'] = -22.72, ['z'] = 74.59},
    [25] = {['x'] = 332.75, ['y'] = -132.51, ['z'] = 66.39},
    [26] = {['x'] = 313.31, ['y'] = -174.43, ['z'] = 58.12},
    [27] = {['x'] = 196.79, ['y'] = -162.6, ['z'] = 56.34},
    [28] = {['x'] = 52.73, ['y'] = -179.72, ['z'] = 54.98},
    [29] = {['x'] = -6.76, ['y'] = -102.54, ['z'] = 57.3},
    [30] = {['x'] = -82.36, ['y'] = -68.65, ['z'] = 58.56},
    [31] = {['x'] = -144.74, ['y'] = -64.65, ['z'] = 54.58},
    [32] = {['x'] = -315.52, ['y'] = -4.01, ['z'] = 48.24},
    [33] = {['x'] = -471.9, ['y'] = -18.93, ['z'] = 45.76},
    [34] = {['x'] = -677.8, ['y'] = -117.24, ['z'] = 37.93},
    [35] = {['x'] = -623.1, ['y'] = -212.03, ['z'] = 37.74},
    [36] = {['x'] = -570.18, ['y'] = -324.4, ['z'] = 35.16},
    [37] = {['x'] = -664.45, ['y'] = -391.87, ['z'] = 34.61},
    [38] = {['x'] = -769.04, ['y'] = -355.92, ['z'] = 37.34},
    [39] = {['x'] = -875.3, ['y'] = -309.48, ['z'] = 39.54},
    [40] = {['x'] = -961.49, ['y'] = -256.24, ['z'] = 38.67},
    [41] = {['x'] = -1253.5, ['y'] = -295.91, ['z'] = 37.32},
    [42] = {['x'] = -1298.56, ['y'] = -392.82, ['z'] = 36.63},
    [43] = {['x'] = -1521.44, ['y'] = -575.73, ['z'] = 33.36},
    [43] = {['x'] = -1662.19, ['y'] = -532.64, ['z'] = 36.03},
    [44] = {['x'] = -1712.69, ['y'] = -492.34, ['z'] = 38.12},
    [45] = {['x'] = -1788.34, ['y'] = -379.43, ['z'] = 44.94},
    [46] = {['x'] = -1828.64, ['y'] = -234.21, ['z'] = 40.81},
    [47] = {['x'] = -2065.76, ['y'] = -312.92, ['z'] = 13.3},
    [48] = {['x'] = -1977.68, ['y'] = -531.85, ['z'] = 11.82},
    [49] = {['x'] = -1828.54, ['y'] = -658.78, ['z'] = 10.58},
    [50] = {['x'] = -1567.03, ['y'] = -910.17, ['z'] = 9.23},
    [51] = {['x'] = -1475.78, ['y'] = -1015.42, ['z'] = 6.29},
}

local PosEntregas = {
    [1] = {['x'] = 82.18, ['y'] = -1615.45, ['z'] = 29.6, ['CorBlipR'] = 185, ['CorBlipG'] = 16, ['CorBlipB'] = 86}
}

local EstaEntregando = false
local EntregaSorteada = false
local blip = false
local PontoDeEntrega = 0

RegisterNetEvent('rusher:AdminEntregaDrogas')
AddEventHandler('rusher:AdminEntregaDrogas', function()
    EstaEntregando = true
end)


Citizen.CreateThread(function()
	local innerTable = {}
	for k, v in pairs(PosEntregas) do

		table.insert(innerTable, { v.x, v.y, v.z, 2, "E", "VENDITA", "INIZIARE","premi" })

        

	end
	TriggerEvent("hoverfy:insertTable", innerTable)



end)






Citizen.CreateThread(function() 
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if not EstaEntregando then
            for _, InfoEntregas in pairs(PosEntregas) do
                local distance = Vdist(GetEntityCoords(ped), InfoEntregas.x, InfoEntregas.y, InfoEntregas.z)
                if distance <= 5 then
                    timeDistance = 1
                    DrawMarker(27, InfoEntregas.x, InfoEntregas.y, InfoEntregas.z-1, 0, 0, 0, 0, 0, 0,1.0, 1.0, 1.0, InfoEntregas.CorBlipR, InfoEntregas.CorBlipG, InfoEntregas.CorBlipB,55, 0, 0, 0, 1)
                    if IsControlJustPressed(0,38) then
                        if rusherDrugRoute.CooldownLiberado() then
                            rusherDrugRoute.SetCooldown()
                            TriggerEvent('Notify', 'successo','Hai iniziato una vendita di droga.')
                            EstaEntregando = true
                        end
                    end
                end
            end
        else
            if not EntregaSorteada then
                EntregaSorteada = true
                PontoDeEntrega = math.random(#PosDrogas)
                if not blip then
                    CriandoBlipDR(PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z)
                    blip = true
                end
            else
                local distDrogas = Vdist(GetEntityCoords(ped), PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z)
                if distDrogas < 15 then
                    timeDistance = 4
                    DrawMarker(21, PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z, 0, 0, 0, 0, 0, 0,0.5,0.5,0.5, 255,0,0,55, 0, 0, 0, 1)
                    if distDrogas < 0.5 then
                        DT3DDR(PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z, 'PREMI ~r~[E] ~w~PER VENDERE IL TUO PRODOTTO', 255,255,255)
                        if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                            local ChanceChamarPm = math.random(100)
                            if ChanceChamarPm > 45 then
                                TriggerServerEvent('rusher:DrogasChamarpolizia', PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z)
                            end
                            rusherDrugRoute.IObiuBAEgukjKASdh()
                            EntregaSorteada = false
                            if blip then
                                RemoveBlip(blips)
                                blip = false
                            end
                            vRP._playAnim(false,{"pickup_object","pickup_low"},false)
                            TriggerEvent("progress",1000)
                            FreezeEntityPosition(ped, true)
                            Wait(1000)
                            FreezeEntityPosition(ped, false)
                            SpawnObject(PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z)
                            ClearPedTasks(ped)
                            Wait(math.random(5,12)*1000)
                            DeleteOBJ()
                        end
                    end
                end
            end

            if EstaEntregando then
                timeDistance = 4
                if IsControlJustPressed(0,168) then
                    rusherDrugRoute.SetCooldown()
                    if blip then
                        RemoveBlip(blips)
                        blip = false
                    end
                    EstaEntregando = false
                    EntregaSorteada = false
                    
                    PontoDeEntrega = 0
                    TriggerEvent('Notify', 'successo','Hai cancellato la vendita di <b>DROGA<b>.')
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)

local blipsDenuncia = {}
RegisterNetEvent('rusher:DrogasChamarpolizia')
AddEventHandler('rusher:DrogasChamarpolizia',function(x,y,z,user_id)
    if not DoesBlipExist(blipsDenuncia[user_id]) then
        TriggerEvent("NotifyPush",{ code = 31, title = "Denúncia de droga", x = x, y = y, z = z })
        blipsDenuncia[user_id] = AddBlipForCoord(x,y,z)
        SetBlipScale(blipsDenuncia[user_id],0.5)
        SetBlipSprite(blipsDenuncia[user_id],164)
        SetBlipColour(blipsDenuncia[user_id],49)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Denúncia de droga")
        EndTextCommandSetBlipName(blipsDenuncia[user_id])
        SetBlipAsShortRange(blipsDenuncia[user_id],false)
        SetTimeout(30000,function()
            if DoesBlipExist(blipsDenuncia[user_id]) then
                RemoveBlip(blipsDenuncia[user_id])
            end
        end)
    end
end)

local obj
function SpawnObject(x,y,z)
    local objectname = 'prop_drug_package'
    RequestModel(objectname)
    while not HasModelLoaded(objectname) do
	    Citizen.Wait(1)
    end

    obj = CreateObject(GetHashKey(objectname), x,y,z-1, true, true, true)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)

end

function DeleteOBJ()
    DeleteObject(obj)
end

function CriandoBlipDR(x,y,z)
    vRPclient.playSound(source, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET");
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,501)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Vendita di droga")
	EndTextCommandSetBlipName(blips)
end

function DT3DDR(x,y,z, text, r,g,b)
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


--------------------------------------------------------------------------
-- BONUS FACÇÕES
--------------------------------------------------------------------------

local saldosfacs = {
    {'groove', -150.45,-1625.36,36.85},
    {'vagos', 371.59,-2040.58,22.2},
    {'ballas', 125.56,-1946.08,20.5},
}

RegisterCommand('saldofac', function(source, args, rawCmd)
    for k, v in pairs (saldosfacs) do
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v[2], v[3], v[4]) < 1.5 then
            if args[1] then
                if args[1] == 'check' then
                    TriggerServerEvent('rusher:saldofac:Check', v[1])
                elseif args[1] == 'sacar' then
                    if args[2] then
                        local quantia = parseInt(args[2])
                        TriggerServerEvent('rusher:saldofac:Sacar', v[1], quantia )
                    end
                end
            end
        end
    end
end)