local Tunnel = module("vrp","lib/Tunnel");
local Proxy = module("vrp","lib/Proxy");
vRP = Proxy.getInterface("vRP");
--------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
--------------------------------------------------------------------------------------------------------------------------------
connection = {};
Tunnel.bindInterface(GetCurrentResourceName(), connection);
vSERVER = Tunnel.getInterface(GetCurrentResourceName());
--------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------
local blips = {};
local coords = nil;
local crate = nil;
local parachute = nil;
local pickingAirDrop = false;
local particleId = 0;
local x,y,z = nil;
local evento = nil;
local dropNoChao = false;
local delay = 0;
local time = Index.Main.time[1];
local minute = false;
local string = tostring(Index.Main.minutos[1]);
local delayToRobbery = Index.Main.delayToRobbery[1];
local seconds;
local start = false;
local tempo = false;

--------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPARTICLE
--------------------------------------------------------------------------------------------------------------------------------
local function requestParticle(dict)
    RequestNamedPtfxAsset(dict);
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict);
        Citizen.Wait(50);
    end
    UseParticleFxAssetNextCall(dict);
end
--------------------------------------------------------------------------------------------------------------------------------
-- DRAWPARTICLE
--------------------------------------------------------------------------------------------------------------------------------
local function drawParticle(x, y, z, particleDict, particleName)
    requestParticle(particleDict);
    particleId = StartParticleFxLoopedAtCoord(particleName, x, y, z, 0.0, 0.0, 0.0, 2.0, false, false, false, false);
end
--------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
--------------------------------------------------------------------------------------------------------------------------------
local function drawText(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z);
	SetTextFont(6);
	SetTextScale(0.35,0.35);
	SetTextColour(255,255,255,150);
	SetTextEntry("STRING");
	SetTextCentre(1);
	AddTextComponentString(text);
	DrawText(_x,_y);
	local factor = (string.len(text))/330;
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80);
end
--------------------------------------------------------------------------------------------------------------------------------
-- DRAWSCREEN
--------------------------------------------------------------------------------------------------------------------------------
local function drawScreen(text,font,x,y,scale)
	SetTextFont(font);
	SetTextScale(scale,scale);
	SetTextColour(255,255,255,150);
	SetTextOutline();
	SetTextCentre(1);
	SetTextEntry("STRING");
	AddTextComponentString(text);
	DrawText(x,y);
end
--------------------------------------------------------------------------------------------------------------------------------
-- CREATEAIRSUPPLYBLIP
--------------------------------------------------------------------------------------------------------------------------------
local function createAirSupplyBlip(index, delete, x, y, z, sprite, colour, scale, text)
    if not delete then
        blips[index] = AddBlipForCoord(x, y, z);
        SetBlipSprite(blips[index],sprite);
        SetBlipColour(blips[index],colour);
        SetBlipScale(blips[index],scale);
        SetBlipAsShortRange(blips[index],true);

        BeginTextCommandSetBlipName("STRING");
        AddTextComponentString(text);
        EndTextCommandSetBlipName(blips[index]);
    else
        if DoesBlipExist(blips[index]) then
            RemoveBlip(blips[index]);
        end
        blips[index] = nil;
    end
end
--------------------------------------------------------------------------------------------------------------------------------
-- PICKUPAIRDROP
--------------------------------------------------------------------------------------------------------------------------------
local function pickupAirDrop()
    local ped = PlayerPedId();
    local count = 0;

    pickingAirDrop = true;

    FreezeEntityPosition(ped, true);

    local function cancel()
        pickingAirDrop = false;
        FreezeEntityPosition(ped, false);
        ClearPedTasks(ped);
    end

    while count <= delayToRobbery do

        count = count + 1;
        if not IsEntityPlayingAnim(ped, "amb@medic@standing@tendtodead@idle_a", "idle_a", 3) then
            ClearPedTasksImmediately(ped); 
            vRP.playAnim(false, {"amb@medic@standing@tendtodead@idle_a", "idle_a"}, true)
            Wait(500);
        end
        if GetEntityHealth(ped) <= 101 or IsControlJustPressed(0, 168) then
            cancel();
            return false;
        end

        drawText(x,y,z, 'ASPETTA ~p~'..math.ceil((delayToRobbery-count)/100)..' ~w~SECONDI, LOOTANDO... (~p~F7~w~ PER CANCELLARE)')

        Citizen.Wait(4);
    end

    cancel();
    return true;
end
--------------------------------------------------------------------------------------------------------------------------------
-- CHECKAREACLEAROFPLAYER
--------------------------------------------------------------------------------------------------------------------------------
local function checkAreaClearOfPlayer(radius)

    local ped = PlayerPedId();
    local pedCoords = GetEntityCoords(ped);

    for k, v in pairs(GetActivePlayers()) do
        local nped = GetPlayerPed(v);
        local npedCoords = GetEntityCoords(nped);
        if ped ~= nped then
            if Vdist2(pedCoords,npedCoords) <= radius then
                if GetEntityHealth(nped) > 101 then
                    return false;
                end
            end
        end
    end

    return true;
end
--------------------------------------------------------------------------------------------------------------------------------
-- FINISHEVENT
--------------------------------------------------------------------------------------------------------------------------------
function connection.finishEvent()

    if DoesEntityExist(crate) then
        DeleteEntity(crate);
    end

    if DoesEntityExist(dropNoChao) then
        DeleteEntity(dropNoChao);
    end

    if DoesEntityExist(parachute) then
        DeleteEntity(parachute);
    end

    DeleteObject(parachuteObj);
    DeleteObject(crateObj);

    coords = nil;
    crate = nil;
    parachute = nil;
    dropNoChao = false;
    minute = false;
    start = false;
    delay = 0;
    string = tostring(Index.Main.minutos[1]);
    seconds = '';

    createAirSupplyBlip('airSupplyArea', true);
    createAirSupplyBlip('airSupplyCenterFalling', true);
    createAirSupplyBlip('airSupplyCenterOnFloor', true);
    local ped = PlayerPedId();
    FreezeEntityPosition(ped, false);
end
--------------------------------------------------------------------------------------------------------------------------------
-- STARTEVENT
--------------------------------------------------------------------------------------------------------------------------------
function connection.startEvent(c,v,r, name)
    evento = 1;
    tempo = true;
    TriggerEvent('chat:addMessage', 
	{
	    template = "<div style='display:flex;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgb(0,68,170) 3%, rgba(25,25,25,0.3) 95%);border-radius: 5px;'>[✈️ AIRDROP ✈️] Una cassa di rifornimenti sta cadendo dal cielo, controlla la tua mappa.",
    })
    TriggerEvent('vrp_sound:source', 'drop', 0.3);
    x, y, z = c,v,r;
    local crateObj = GetHashKey('hei_prop_crate_stack_01');
    local parachuteObj = GetHashKey('p_parachute1_mp_dec');

    local sky = z + 200;
    local floor = z - 1.0;

    crate = CreateObject(crateObj, x, y, sky, false, true, false);
    SetEntityLodDist(crate, 450);
    SetEntityAsMissionEntity(crate,true,true);

    parachute = CreateObject(parachuteObj, x, y, sky, false, true, false);

    FreezeEntityPosition(crate, true);
    FreezeEntityPosition(parachute, true);

    AttachEntityToEntity(parachute, crate, 0, 0.0, 0.0, 3.4, 0.0, 0.0, 0.0, false, false, false, true, 2, true);

    blips['airSupplyArea'] = AddBlipForRadius(x, y, z, 115.0);
    SetBlipColour(blips['airSupplyArea'], 67);
    SetBlipAlpha(blips['airSupplyArea'], 38);

    createAirSupplyBlip('airSupplyCenterFalling', false, x, y, z, 94, 63, 0.9, '~p~Locale: ~w~Scatola di rifornimento');
    drawParticle(x, y, z-1.0, 'core', 'exp_grd_flare');

    while sky > floor do
        sky = sky - 0.1;
        SetEntityCoords(crate, x, y, sky);

        local ped = PlayerPedId();
        local pedCoords = GetEntityCoords(ped);
        local _, _, pedZ = table.unpack(pedCoords);

        if #(pedCoords - vector3( x, y, sky)) <= 1.7 then
            --SetEntityHealth(ped, 101)
            vRP.setHealth(101);
            TriggerEvent("Hud:sendStatus");
        end

        if sky - floor <= 1 then
            if parachute then
                DeleteEntity(parachute);
            end

            RemoveBlip(blips['airSupplyArea']);
            blips['airSupplyArea'] = AddBlipForRadius(x, y, z, 115.0);
            SetBlipColour(blips['airSupplyArea'], 73);
            SetBlipAlpha(blips['airSupplyArea'], 38);
            createAirSupplyBlip('airSupplyCenterFalling', true);
            createAirSupplyBlip('airSupplyCenterOnFloor', false, x, y, z, 478, 5, 0.9, '~p~Local: ~w~Cassa di rifornimento STATUS: ~p~LOOT');
            StopParticleFxLooped(particleId, false);
            SetEntityCoords(crate,x,y,floor);
            PlaceObjectOnGroundProperly(crate);

            coords = c,v,r;
            dropNoChao = true;
            start = true;
            minute = true;
            delay = Index.Main.minutos[1];
            break;
        end
        Citizen.Wait(time);
    end
end
--------------------------------------------------------------------------------------------------------------------------------
-- MAINTHREAD
--------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local ped = PlayerPedId();
        local pedCoords = GetEntityCoords(ped);
        local timeDistance = 2000;
        if evento ~= nil then
            timeDistance = 0;
            local dist = #(pedCoords - vector3(x,y,z));
            local alive = GetEntityHealth(ped) > 101;
            if not IsPedInAnyVehicle(ped) and alive and not pickingAirDrop and not create ~= nil and not dropNoChao == false then
                if dist <= 3.0 then
                    if delay > 0 then
                        drawText(x,y,z,'ASPETTA ~p~['..delay..']~w~ SECONDI');
                    else
                        drawText(x,y,z,'~w~PREMI ~p~[E]~w~ PER APRIRE LA CASSA');
                    end
                    if dist <= 1.5 then
                        if IsControlJustPressed(0, 38) and delay == 0 then
                            if vSERVER.checkNearestPlayers() then
                                if pickupAirDrop() then
                                    if alive then
                                        local src = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped));
                                        vSERVER.madrugaFinish(-1);
                                        vSERVER.getSupply(src);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(timeDistance);
    end
end)

CreateThread( function()
    while true do
        if dropNoChao then
            if delay > 0 then
                delay = delay - 1;
            elseif delay == 0 and start then
                TriggerEvent('Notify', 'airdrop', 'La cassa di rifornimento può essere aperta, prendila prima che arrivi qualcun altro..', 9000);
                start = false;
            end
            if dropNoChao and minute then
                if string == '0' then
                    return
                else
                    TriggerEvent('Notify', 'airdrop', 'La cassa di rifornimento potrà essere aperta tra <b>'..string.. '</b> secondi.', 9000);
                    minute = false;
                end
            end
        end
        Wait(1000);
    end
end)