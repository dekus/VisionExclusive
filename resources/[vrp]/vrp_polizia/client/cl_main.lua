-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_polizia",src)
vSERVER = Tunnel.getInterface("vrp_polizia")
rusher = Tunnel.getInterface("vrp_polizia")

Citizen.CreateThread( function()
	while true do
		local peaga = 1000
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 101 then
			rusher.toggle()
		end
		Citizen.Wait(peaga)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENT P
-----------------------------------------------------------------------------------------------------------------------------------------
local rusher = 0
RegisterCommand("callpm",function(source,args,rawCommand)
	if vSERVER.CheckPolice() then
		if rusher <= 0 then
			rusher = 10
			TriggerServerEvent("rusher:1020Police")
		else
			TriggerEvent('Notify','importante','Aspetta <b>'..parseInt(rusher)..'</b> secondi.')
		end
	end
end)

RegisterKeyMapping('callpm','QRR','keyboard','next')

-----------------------------------------------------------------------------------------------------------------------------------------
-- DIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("die",function(source,args,rawCommand)
	if vSERVER.CheckPolice() then
		TriggerServerEvent("rusher:1020Police")
		TriggerEvent('Notify','aviso','Ti sei suicidato.')
		SetEntityHealth(PlayerPedId(),0)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local peaga = 10
		if rusher > 0 then
			rusher = rusher - 1
		end
		Citizen.Wait(peaga)
	end
end)

RegisterNetEvent('desligarRadios')
AddEventHandler('desligarRadios',function()
	local i = 0
    while i < 1033 do
      if exports.tokovoip_script:isPlayerInChannel(i) == true then
		exports.tokovoip_script:removePlayerFromRadio(i)
	  end	
      i = i + 1
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkDistance(x2,y2,z2,radius)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(x2,y2,z2)
	local distance = GetDistanceBetweenCoords(x2,y2,cdz,x,y,z,true)
	if distance <= radius then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET & REMOVE ALGEMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setalgemas")
AddEventHandler("setalgemas",function()
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,7,41,0,2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,7,25,0,2)
	end
end)

RegisterNetEvent("removealgemas")
AddEventHandler("removealgemas",function()
	SetPedComponentVariation(PlayerPedId(),7,0,0,2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function src.CarregarDif(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end	
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
--------------------------------------------------------------------------------------------------------------------------------------------------
other = nil
drag = false
carregado = false
RegisterNetEvent("carregar")
AddEventHandler("carregar",function(p1)
    other = p1
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
    	local timeDistance = 1000
		if drag and other then
			timeDistance = 4
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
			carregado = true
        else
        	if carregado then
				DetachEntity(PlayerPedId(),true,false)
				carregado = false
			end
		end
		Citizen.Wait(timeDistance)
	end
end)


RegisterCommand('+carregar',function()
	TriggerServerEvent("vrp_polizia:carregaradm")
end)

RegisterKeyMapping('+algemar', '[rusher] ALGEMAR', 'keyboard', 'g')
RegisterKeyMapping('+carregar', '[rusher] CARREGAR', 'keyboard', 'h')
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
local blacklistedWeapons = {
	"WEAPON_DAGGER",
	"WEAPON_BAT",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_FLASHLIGHT",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE",
	"WEAPON_KNIFE",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_STUNGUN",
	"WEAPON_FLARE",
	"GADGET_PARACHUTE",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_RAYPISTOL",
	"WEAPON_FIREWORK",
	"WEAPON_BZGAS",
	"WEAPON_MUSKET"
}

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedArmed(ped,6) then
			timeDistance = 1000
			local blacklistweapon = false
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			local armaNaMao = GetSelectedPedWeapon(ped)

			for k,v in ipairs(blacklistedWeapons) do
				if armaNaMao == GetHashKey(v) then
					blacklistweapon = true
				end
			end

			if IsPedShooting(ped) and not blacklistweapon then
				TriggerServerEvent('atirando',x,y,z)
			end
		end
		blacklistweapon = false
		Citizen.Wait(timeDistance)
	end
end)



local blips = {}
RegisterNetEvent('notificacao')
AddEventHandler('notificacao',function(x,y,z,user_id,time)
	if not DoesBlipExist(blips[user_id]) then
		local tempo = 7000
		TriggerEvent("NotifyPush",{ code = '10-71', title = "Colpi di arma da fuoco", x = x, y = y, z = z, time = time})
		blips[user_id] = AddBlipForCoord(x,y,z)
		SetBlipScale(blips[user_id],0.5)
		SetBlipSprite(blips[user_id],10)
		SetBlipColour(blips[user_id],49)
		SetBlipDisplay(blips[user_id],8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Colpi di arma da fuoco")
		EndTextCommandSetBlipName(blips[user_id])
		SetBlipAsShortRange(blips[user_id],false)
		SetTimeout(tempo,function()
			if DoesBlipExist(blips[user_id]) then
				RemoveBlip(blips[user_id])
			end
		end)
	end
end)

local combatSeconds = 0
--------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
--------------------------------------------------------------------------------------------------------------------------------------------------
--[[ Citizen.CreateThread( function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		if IsPedArmed(ped, 6) then 
			timeDistance = 4
			
			if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_STUNGUN") then 
				if IsPedShooting(ped) and not IsPedCurrentWeaponSilenced(PlayerPedId()) then 
					for k, v in ipairs(blackWeapons) do
						if GetSelectedPedWeapon(ped) == GetHashKey(v) then
							bWeapons = true
						end
					end
					if not bWeapons then
						vSERVER.alertShoot()
						combatSeconds = 20 * 1000
					end
	
					bWeapons = false
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- combatSeconds
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if combatSeconds > 0 then
            combatSeconds = combatSeconds - 1000
        end
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getCombatSeconds()
    return parseInt(combatSeconds / 1000)
end

function src.checkCombat()
    return (combatSeconds > 0)
end

function src.setCombatMode(seconds)
    combatSeconds = seconds * 1000
end

AddEventHandler("vrp_polizia:setCombatMode")
RegisterNetEvent("vrp_polizia:setCombatMode", src.setCombatMode)

exports("setCombatMode", src.setCombatMode)
exports("isOnCombatMode", src.isOnCombatMode)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.putVehicle(seat)
	local veh = vRP.getNearestVehicle(11)
	if IsEntityAVehicle(veh) then
		if parseInt(seat) <= 1 or seat == nil then
			seat = -1
		elseif parseInt(seat) == 2 then
			seat = 0
		elseif parseInt(seat) == 3 then
			seat = 1
		elseif parseInt(seat) == 4 then
			seat = 2
		elseif parseInt(seat) == 5 then
			seat = 3
		elseif parseInt(seat) == 6 then
			seat = 4
		elseif parseInt(seat) == 7 then
			seat = 5
		elseif parseInt(seat) >= 8 then
			seat = 6
		end

		local ped = PlayerPedId()
		if IsVehicleSeatFree(veh,seat) then
			ClearPedTasks(ped)
			ClearPedSecondaryTask(ped)
			SetPedIntoVehicle(ped,veh,seat)
		end
	end
end