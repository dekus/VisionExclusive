-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_hud", cRP)
vSERVER = Tunnel.getInterface("vrp_hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local voice = 2
local showHud = true
local showMovie = false
local showHood = false
local talking = false
local radioDisplay = ""
local pauseBreak = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress", function(time, text)
    SendNUIMessage({ type = "ui", display = true, time = time })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VOICETALKING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vrp_hud:talking", function(status)
    talking = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud", function(source, args)
    showHud = not showHud
    updateDisplayHud()
    SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand("movie", function(source, args)
    --showMovie = not showMovie
   -- updateDisplayHud()
    --SendNUIMessage({ movie = showMovie })
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if IsPauseMenuActive() then
            SendNUIMessage({ hud = false })
            pauseBreak = true
        else
            if pauseBreak and showHud then
                SendNUIMessage({ hud = true })
                pauseBreak = false
            end
        end

        if showHud then
            updateDisplayHud()
        end

        Citizen.Wait(200)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function updateDisplayHud()
    local ped = PlayerPedId()
    local health = (GetEntityHealth(ped) - 100) / 300 * 100
    local vehicle = GetVehiclePedIsUsing(ped)
    local speed = GetEntitySpeed(vehicle) * 3.6

    if IsPedInAnyVehicle(ped) then
        SendNUIMessage({ health = health, radio = radioDisplay, voice = voice, hood = showHood, car = true, speed = speed })
    else
        SendNUIMessage({ health = health, radio = radioDisplay, voice = voice, hood = showHood })
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    DisplayRadar(false)

    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Citizen.Wait(100)
    end

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    SetMinimapClipType(1)

    SetMinimapComponentPosition("minimap", "L", "B", 0.0, 0.0, 0.158, 0.28)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.155, 0.12, 0.080, 0.164)
    SetMinimapComponentPosition("minimap_blur", "L", "B", -0.005, 0.021, 0.240, 0.302)

    Citizen.Wait(5000)

    SetBigmapActive(true, false)

    Citizen.Wait(100)

    SetBigmapActive(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:toggleHood")
AddEventHandler("vrp_hud:toggleHood", function()
    showHood = not showHood
    if showHood then
        SetPedComponentVariation(PlayerPedId(), 1, 69, 0, 1)
    else
        SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:removeHood")
AddEventHandler("vrp_hud:removeHood", function()
    if showHood then
        showHood = false
        SendNUIMessage({ hood = showHood })
        SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) and showHud then
            if not IsMinimapRendering() then
                DisplayRadar(true)
            end
        else
            if IsMinimapRendering() then
                DisplayRadar(false)
            end
        end

        Citizen.Wait(1000)
    end
end)

local agachar = false
local crouchCooldown = 0

local function agachando()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            local ped = PlayerPedId()
            local player = PlayerId()
            if agachar then 
                DisablePlayerFiring(player, true)
            else
                break
            end
        end
    end)
end


RegisterKeyMapping('ctrl+' , 'Agachar' , 'keyboard' , 'LCONTROL' )
RegisterCommand('ctrl+', function()
    DisableControlAction(0,36,true)
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped) then
        RequestAnimSet("move_ped_crouched")
        RequestAnimSet("move_ped_crouched_strafing")
        if IsDisabledControlJustPressed(0,36) then
            if agachar then
                ResetPedStrafeClipset(ped)
                ResetPedMovementClipset(ped,0.30)
                agachar = false
            else
				if GetGameTimer() >= crouchCooldown then
                	SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                	SetPedMovementClipset(ped,"move_ped_crouched",0.30)
                	agachar = true
					crouchCooldown = GetGameTimer() + 2000
                	agachando()
				end
            end
        end
    end
end, false)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SEAT (/seat)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seat2",function(source,args)
	if vSERVER.CheckAdmin() then
		if args[1] then
			local pos = parseInt(args[1])
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)

			if veh and pos >= 1 and pos <= 6 then
				local seatPos = pos - 2
				if IsVehicleSeatFree(veh,seatPos) then
					SetPedIntoVehicle(PlayerPedId(),veh,seatPos)
				end
			end
		end
	end
end)

RegisterCommand('seat', function(source, args, rawCmd)
	local ped = PlayerPedId()
	if not exports["chat"]:statusChat() then return end
	if IsPedInAnyVehicle(ped, false) then	
		local carrinhu = GetVehiclePedIsIn(ped, false)
		--if not CintoSeguranca then
			if args[1] then
				local acento = parseInt(args[1])
				
				if acento == 1 then
					if IsVehicleSeatFree(carrinhu, -1) then 
						if GetPedInVehicleSeat(carrinhu, 0) == ped then
							SetPedIntoVehicle(ped, carrinhu, -1)
						else
							TriggerEvent('Notify', "negado", 'Puoi passare a P1 solo da P2.')
						end
					else
						TriggerEvent('Notify', "negado", 'L\'accento deve essere libero.')
					end
				elseif acento == 2 then
					if IsVehicleSeatFree(carrinhu, 0) then 
						if GetPedInVehicleSeat(carrinhu, -1) == ped then
							SetPedIntoVehicle(ped, carrinhu, 0)
						else
							TriggerEvent('Notify', "negado",'Puoi passare a P2 solo da P1.')
						end
					else
						TriggerEvent('Notify', "negado", 'L\'accento deve essere libero.')
					end
				elseif acento == 3 then
					if IsVehicleSeatFree(carrinhu, 1) then 
						if GetPedInVehicleSeat(carrinhu, 2) == ped then
							SetPedIntoVehicle(ped, carrinhu, 1)
						else
							TriggerEvent('Notify', "negado", 'Puoi passare a P3 solo da P4.')
						end
					else
						TriggerEvent('Notify', "negado", 'L\'accento deve essere libero.')
					end
				elseif acento == 4 then
					if IsVehicleSeatFree(carrinhu, 2) then 
						if GetPedInVehicleSeat(carrinhu, 1) == ped then
							SetPedIntoVehicle(ped, carrinhu, 2)
						else
							TriggerEvent('Notify', "negado", 'Puoi passare a P4 solo da P3.')
						end
					else
						TriggerEvent('Notify', "negado",'L\'accento deve essere libero.')
					end
				end
			else
				TriggerEvent('Notify', "negado", 'Specifica l\'accento che vuoi usare!')
			end
		--else
		--end
	end
end)