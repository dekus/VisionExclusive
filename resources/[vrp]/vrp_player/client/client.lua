-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
client = {}
Tunnel.bindInterface("vrp_player",client)
vSERVER = Tunnel.getInterface("vrp_player")
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- TIMER GARMAS
-- -----------------------------------------------------------------------------------------------------------------------------------------
local statusGarmas = false
local delayGarmas = 60
--local delayTratas = 0 
local delayReboque = 0
RegisterNetEvent("rusher:GerarDelayGarmas")
AddEventHandler("rusher:GerarDelayGarmas",function()
	statusGarmas = true
end)

CreateThread(function()
  local ped = PlayerPedId()
  SetPedCanBeKnockedOffVehicle(ped, false)
end)

CreateThread(function()
	while true do
		local peaga = 1000
		if statusGarmas then
			if delayGarmas > 0 then
				delayGarmas = delayGarmas - 1
			else
				statusGarmas = false
				TriggerServerEvent('rusher:ZerarStatusGarmas')
				delayGarmas = 60
			end
		end

		--if delayTratas > 0 then delayTratas = delayTratas - 1 end
		if delayReboque > 0 then delayReboque = delayReboque - 1 end
		Wait(peaga)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAÇÃO DE ANIMAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function client.FazendoAnim(animDict, animName)
	local ped = PlayerPedId()
	local PlayingAnim = IsEntityPlayingAnim(ped, animDict, animName, 3)	 
	return PlayingAnim
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(30*60000)
		vSERVER.WekakdjinWKKkdeinIAIASAO()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STAYONLINEBATTLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(60*60000)
		vSERVER.WekakdjinWKKkdeinIAIASAO1()
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- /VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
  
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify",'importante',"Tuning","<b>Motor:</b> "..motor.."<br><b>Freno:</b> "..freio.."<br><b>Trasmissioni:</b> "..transmissao.."<br><b>Sospensioni:</b> "..suspensao.."<br><b>Armatura:</b> "..blindagem.."<br><b>Telaio:</b> "..parseInt(body/10).."%<br><b>Motore:</b> "..parseInt(engine/10).."%",15000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone",function(veh,doors)
	SetVehicleDoorsLocked(veh,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kit",function(source,args)
	local ped = PlayerPedId()
	if vSERVER.CheckVip('ambos') or vSERVER.PossuiCompArma() or vSERVER.Checkpolizia() then
	local arma = GetSelectedPedWeapon(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_RAIL"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_FLSH_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_COMP"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
			GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_SIGHTS'))
			GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_combatpdw") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SR_SUPP"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("weapon_specialcarbine_mk2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SIGHTS"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_06"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_03"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_BARREL_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_04"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYRIFLE") then
			GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
			GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
			GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_FLSH'))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_snspistol_mk2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") or arma == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_07"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_04"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_heavysniper_mk2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MAX"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_NV"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_THERMAL"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SR_SUPP_03"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_FLSH"))
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
			TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
		end
	else
		TriggerEvent('Notify', 'negato','Nessun ruolo o elemento trovato per l\'attivazione del componente.')
	end
end)

RegisterCommand("silenziatore",function(source,args)
	local ped = PlayerPedId()
	if vSERVER.CheckVip('ambos') or vSERVER.PossuiCompArma() or vSERVER.Checkpolizia() then
	local arma = GetSelectedPedWeapon(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("weapon_snspistol_mk2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") or arma == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("weapon_specialcarbine_mk2") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_SUPP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
			GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP"))
		end
		TriggerEvent('Notify', 'successo','I tuoi componenti sono stati <b>ABILITATI</b>.')
	else
		TriggerEvent('Notify', 'negato','Nessun ruolo o elemento trovato per l\'attivazione del componente.')
	end
end)

RegisterNetEvent('rusher:attachs2')
AddEventHandler('rusher:attachs2', function()
	local ped = PlayerPedId()
	local arma = GetSelectedPedWeapon(ped)
	if arma == GetHashKey('WEAPON_CARBINERIFLE_MK2') then
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_AFGRIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM_MK2'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_SUPP'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_FLSH'))
	elseif arma == GetHashKey('WEAPON_ASSAULTRIFLE_MK2') then
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_ASSAULTRIFLE_MK2_CLIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_AFGRIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_FLSH'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_SIGHTS'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	elseif arma == GetHashKey('WEAPON_HEAVYRIFLE') then
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_FLSH'))
	elseif arma == GetHashKey('WEAPON_PISTOL_MK2') then
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_PISTOL_MK2_CLIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_PI_RAIL'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_PI_FLSH_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_PI_SUPP_02'))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CR
-----------------------------------------------------------------------------------------------------------------------------------------
local cruising = false
local valorCruising = 290
RegisterCommand('cr',function(source,args)
  
	local veh = GetVehiclePedIsIn(PlayerPedId(),false)
	local maxspeed = GetVehicleMaxSpeed(GetEntityModel(veh))
	local vehspeed = GetEntitySpeed(veh)*3.6
	if GetPedInVehicleSeat(veh,-1) == PlayerPedId() and math.ceil(vehspeed) >= 0 and not IsEntityInAir(veh) then
		if args[1] == nil then
			cruising = false
			valorCruising = 290
			TriggerEvent('Notify', 'successo','Cruiser spento con successo.')
		elseif parseInt(args[1]) >= 10 and parseInt(args[1]) <= 320 then
			cruising = true
			SetEntityMaxSpeed(veh,0.278*args[1])
			valorCruising = args[1]
			TriggerEvent('Notify', 'successo','Velocità massima bloccata in <b>'.. parseInt(args[1])..' km/h</b>.')
		elseif parseInt(args[1]) < 10 or parseInt(args[1]) > 320 then
            TriggerEvent('Notify',"negato","negato",'La velocità di cruising deve essere compresa tra 10KMH e 320KMH.')
            valorCruising = 290
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUISERADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:Cruiser')
AddEventHandler('rusher:Cruiser', function(cruisador)
	if cruisador then
		valorCruising = cruisador
		TriggerEvent('Notify', 'successo','Velocità massima bloccata a <b>'.. cruisador..' km/h</b>.')
	else
		valorCruising = 9999
		TriggerEvent('Notify', 'successo','Hai disattivato il limitatore di velocità.')
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function() 
	while true do
		local peaga = 10000
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped,false)
		if veh then
			SetEntityMaxSpeed(veh,0.280*valorCruising)
		end
		Wait(peaga)
	end
end)

function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

RegisterCommand("colorazione",function(source,args)
  
	local tinta = parseInt(args[1])	
	if vSERVER.CheckVip('ambos') or vSERVER.CheckBooster() then	
		if tinta >= 0 then
			SetPedWeaponTintIndex(PlayerPedId(),GetSelectedPedWeapon(PlayerPedId()),tinta)
			TriggerEvent('Notify', 'successo','Hai colorato la tua pistola con la vernice ' .. tinta .. '.')
		else
			TriggerEvent('Notify', 'negato','Devi specificare un colore valido.')
		end
	else
		TriggerEvent('Notify', 'negato','Solo i membri <b>VIP</b> e <b>Booster</b> può colorare l\'arma.')
	end
end)

RegisterCommand("pittura",function(source,args)
  
	local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
	local pintura = parseInt(args[1])
	if vSERVER.CheckVip('ambos') or vSERVER.CheckBooster() then
		if args[1] then
			if arma == GetHashKey('WEAPON_ASSAULTRIFLE_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"))
				end
			elseif arma == GetHashKey('WEAPON_SPECIALCARBINE') then
				if pintura then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER"))
				end
			elseif arma == GetHashKey('WEAPON_PISTOL_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_IND_01"))
				elseif pintura == 12 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_SLIDE"))
				elseif pintura == 13 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_02_SLIDE"))
				elseif pintura == 14 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_03_SLIDE"))
				elseif pintura == 15 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_04_SLIDE"))
				elseif pintura == 16 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_05_SLIDE"))
				elseif pintura == 17 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_06_SLIDE"))
				elseif pintura == 18 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_07_SLIDE"))
				elseif pintura == 19 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_08_SLIDE"))
				elseif pintura == 20 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_09_SLIDE"))
				elseif pintura == 21 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_10_SLIDE"))
				elseif pintura == 22 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_IND_01_SLIDE"))
				end
			elseif arma == GetHashKey('WEAPON_CARBINERIFLE_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01"))
				end
			elseif arma == GetHashKey('WEAPON_SPECIALCARBINE_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_IND_01"))
				end
			else
				TriggerEvent('Notify', 'negato','Questo comando funziona solo su armi del tipo <b>MK2</b>.')
			end
		else
			TriggerEvent('Notify', 'negato','Specificare un numero di colore.')
		end
	else
		TriggerEvent('Notify', 'negato','Solo i membri <b>VIP</b> e <b>Booster</b> può colorare l\'arma.')
	end
end)
local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function()
	energetico = true
	SetRunSprintMultiplierForPlayer(PlayerId(),1.2)
	Wait(60000)
	energetico = false
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	TriggerEvent('Notify', 'avviso','L\'effetto è finito, sei tornato alla normalità.')
end)

local melzinho = false
RegisterNetEvent('melzinho')
AddEventHandler('melzinho',function()
	melzinho = true
	SetRunSprintMultiplierForPlayer(PlayerId(),1.28)
	Wait(120000)
	melzinho = false
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	TriggerEvent('Notify', 'avviso','L\'effetto è finito, sei tornato alla normalità.')
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)

CreateThread(function()
	while true do
		local peaga = 1000
		if cancelando then
			ORTiming = 4
			BlockWeaponWheelThisFrame()
			DisablePlayerFiring(PlayerId(),true)
			DisableControlAction(0,75)
			DisableControlAction(0,20,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,137,true)
		end
		Wait(peaga)
	end
end)

CreateThread(function()
	while true do
		local ORTiming = 1000
		RestorePlayerStamina(PlayerId(),1.0)
		Wait(ORTiming)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local peaga = 1000
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        if x == px and y == py then
            if tempo > 0 then
                tempo = tempo - 1
                if tempo == 60 then
                    TriggerEvent('Notify', 'avviso',"Verrai disconnesso tra <b>60 secondi</b>.")
                end
            else
                TriggerServerEvent("kickAFK")
            end
        else
            tempo = 1800
        end
        px = x
        py = y
		Wait(peaga)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APRIRE CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("capo",function(source,args)
  
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand("vidros",function(source,args)
  
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APRIRE PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pmalas",function(source,args)
  
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APRIRE CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args)
  
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if vidros then
				vidros = false
				RollUpWindow(v,0)
				RollUpWindow(v,1)
				RollUpWindow(v,2)
				RollUpWindow(v,3)
				else
				vidros = true
				RollDownWindow(v,0)
				RollDownWindow(v,1)
				RollDownWindow(v,2)
				RollDownWindow(v,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APRIRE PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("portas",function(source,args)
  
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		if parseInt(args[1]) == -1 then
			TriggerServerEvent("trytrunk",VehToNet(vehicle))
		else
			TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
		end
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS direita/esquerda
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaosd')
AddEventHandler('setmaosd',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId()) then
		if not modelo then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			ClearPedProp(ped,6)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,6,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,6,parseInt(modelo),parseInt(cor),2)
		end
	end
end)

RegisterNetEvent('setmaose')
AddEventHandler('setmaose',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId()) then
		if not modelo then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			ClearPedProp(ped,7)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,7,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmascara')
AddEventHandler('setmascara',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId())  then
		if modelo == nil then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(1100)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setblusa')
AddEventHandler('setblusa',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId())  then
		if not modelo then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcolete')
AddEventHandler('setcolete',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId()) then
		if not modelo then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setjaqueta')
AddEventHandler('setjaqueta',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId())  then
		if not modelo then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmochila')
AddEventHandler('setmochila',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId())  then
		if not modelo then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaos')
AddEventHandler('setmaos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId()) then
		if not modelo then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCALCA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcalca')
AddEventHandler('setcalca',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId())  then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(true,{"re@construction","out_of_breath"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(true,{"re@construction","out_of_breath"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,15,0,2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"re@construction","out_of_breath"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"re@construction","out_of_breath"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACESSORIOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setacessorios')
AddEventHandler('setacessorios',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId())  then
		if not modelo then
			SetPedComponentVariation(ped,7,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setsapatos')
AddEventHandler('setsapatos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId()) then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(false,{"random@domestic","pickup_low"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,34,0,2)
				Wait(500)
				ClearPedTasks(ped)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(false,{"random@domestic","pickup_low"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,35,0,2)
				Wait(500)
				ClearPedTasks(ped)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{"random@domestic","pickup_low"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{"random@domestic","pickup_low"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setchapeu')
AddEventHandler('setchapeu',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId()) then
		if not modelo then
			vRP._playAnim(true,{"missheist_agency2ahelmet","take_off_helmet_stand"},false)
			Wait(1200)
			ClearPedProp(ped,0)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") and parseInt(modelo) ~= 39 then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") and parseInt(modelo) ~= 38 then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setoculos')
AddEventHandler('setoculos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas(PlayerPedId()) then
		if not modelo then
			vRP._playAnim(true,{"missheist_agency2ahelmet", "take_off_helmet_stand"},false)
			Wait(1200)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW
-----------------------------------------------------------------------------------------------------------------------------------------
local VeiculosNoReboque = {}
RegisterCommand("tow",function(source,args)
	local vehicle = GetPlayersLastVehicle()
	local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

	if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
		local rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
		if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
			TriggerServerEvent("trytow",VehToNet(vehicle) --[[ caminhao reboque ]],VehToNet(rebocado) --[[ veiculo rebocado ]])
		end
	end
end)

RegisterNetEvent('synctow')
AddEventHandler('synctow',function(vehid,rebid)
	if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
		local CaminhaoReboque = NetToVeh(vehid)
		local VeiculoRebocado = NetToVeh(rebid)
		if DoesEntityExist(VeiculoRebocado) and DoesEntityExist(CaminhaoReboque) then
			if not VeiculosNoReboque[vehid] or VeiculosNoReboque[vehid] == nil then
				if VeiculoRebocado ~= CaminhaoReboque then
					local min,max = GetModelDimensions(GetEntityModel(VeiculoRebocado))
					AttachEntityToEntity(VeiculoRebocado,CaminhaoReboque,GetEntityBoneIndexByName(CaminhaoReboque,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
					VeiculosNoReboque[vehid] = rebid
				end
			else
				for k, v in pairs(VeiculosNoReboque) do
					if vehid == k then
						k, v = NetToVeh(k), NetToVeh(v)
						AttachEntityToEntity(v,k,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
						DetachEntity(v,false,false)
						PlaceObjectOnGroundProperly(v)
						VeiculosNoReboque[k] = nil
					end
				end				
			end
		end
	end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reparar')
AddEventHandler('reparar',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				SetVehicleOnGroundProperly(v)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- bende
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusherbende')
AddEventHandler('rusherbende',function()
    local ped = PlayerPedId()
    local bende = 0
    repeat
		local peaga = 1000
        bende = bende + 1
        if GetEntityHealth(ped) > 101 then
            SetEntityHealth(ped,GetEntityHealth(ped)+2)
        end
		Wait(peaga)
    until GetEntityHealth(ped) >= 399 or GetEntityHealth(ped) <= 101 or bende == 60
	TriggerEvent("Notify",'successo',"Trattamento concluso.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararpneus')
AddEventHandler('repararpneus',function(vehicle)
	TriggerServerEvent("trypneus",VehToNet(vehicle))
end)

RegisterNetEvent('syncpneus')
AddEventHandler('syncpneus',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			for i = 0,5 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if custom[1] == -1 then
			SetPedComponentVariation(ped,1,0,0,2)
		else
			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
		end

		if custom[3] == -1 then
			SetPedComponentVariation(ped,5,0,0,2)
		else
			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
		end

		if custom[5] == -1 then
			SetPedComponentVariation(ped,7,0,0,2)
		else
			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
		end

		if custom[7] == -1 then
			SetPedComponentVariation(ped,3,15,0,2)
		else
			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
		end

		if custom[9] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,4,15,0,2)
			end
		else
			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
		end

		if custom[11] == -1 then
			SetPedComponentVariation(ped,8,15,0,2)
		else
			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
		end

		if custom[13] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,6,35,0,2)
			end
		else
			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
		end

		if custom[15] == -1 then
			SetPedComponentVariation(ped,11,15,0,2)
		else
			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
		end

		if custom[17] == -1 then
			SetPedComponentVariation(ped,9,0,0,2)
		else
			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
		end

		if custom[19] == -1 then
			SetPedComponentVariation(ped,10,0,0,2)
		else
			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
		end

		if custom[21] == -1 then
			ClearPedProp(ped,0)
		else
			SetPedPropIndex(ped,0,custom[21],custom[22],2)
		end

		if custom[23] == -1 then
			ClearPedProp(ped,1)
		else
			SetPedPropIndex(ped,1,custom[23],custom[24],2)
		end

		if custom[25] == -1 then
			ClearPedProp(ped,2)
		else
			SetPedPropIndex(ped,2,custom[25],custom[26],2)
		end

		if custom[27] == -1 then
			ClearPedProp(ped,6)
		else
			SetPedPropIndex(ped,6,custom[27],custom[28],2)
		end

		if custom[29] == -1 then
			ClearPedProp(ped,7)
		else
			SetPedPropIndex(ped,7,custom[29],custom[30],2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- -- PEÇA MECANICO 
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('manufactureboard', function(source, args, rawCmd)
	if vSERVER.checkPermission() then
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = GetDistanceBetweenCoords(-196.43,-1319.26,31.09,x,y,z,true)
		local distance2 = GetDistanceBetweenCoords(-198.92,-1315.28,31.09,x,y,z,true)
		if distance or distance2 <= 3 then
			vSERVER.MecAskItem('placa')
		end
	end
end)
RegisterCommand('manufacturecan', function(source, args, rawCmd)
	if vSERVER.checkPermission() then
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = GetDistanceBetweenCoords(-196.43,-1319.26,31.09,x,y,z,true)
		local distance2 = GetDistanceBetweenCoords(-198.92,-1315.28,31.09,x,y,z,true)
		if distance or distance2 <= 3 then
			vSERVER.MecAskItem('latadetinta')
		end
	end
end)

RegisterNetEvent('rusher:MecAnim')
AddEventHandler('rusher:MecAnim', function(item)
	if item == 'placa' then 
		vRP._playAnim(false,{task="WORLD_HUMAN_WELDING"},false)
		TriggerEvent("progress",15000,"Montando kit")
		Wait(15000)
		ClearPedTasks(PlayerPedId())
	elseif item == 'latadetinta' then
		vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		TriggerEvent("progress",15000,"Mescolando le vernici")
		Wait(15000)
		ClearPedTasks(PlayerPedId())
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT BAHAMAS
-----------------------------------------------------------------------------------------------------------------------------------------
function client.ChecarDist(x1,y1,z1) 
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local distance = GetDistanceBetweenCoords(x1, y1, z1, x,y,z,true)
	return distance
end

function client.CheckEstaEmCarro()
	return IsPedInAnyVehicle(PlayerPedId(), false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OFICINA CLANDESTINA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function(placa)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local clonada = GetVehicleNumberPlateText(vehicle)
    if IsEntityAVehicle(vehicle) then
        PlateIndex = GetVehicleNumberPlateText(vehicle)
        SetVehicleNumberPlateText(vehicle,placa)
        FreezeEntityPosition(vehicle,false)
        if clonada == CLONADA then 
            SetVehicleNumberPlateText(vehicle,PlateIndex)
            PlateIndex = nil
        end
    end
end)

local oficinasClandestinas = {
	[1] = {732.0,-1089.0,22.17}, -- Próximo aos trilhos de trem
	[2] = {1175.2,2639.95,37.76} -- Mecânica do norte
}

local camuflando = false
RegisterCommand('clonarvehs', function(source, args, rawCmd)
	if not camuflando then
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		for k, v in pairs(oficinasClandestinas) do
			if (Vdist2(GetEntityCoords(ped),v[1], v[2], v[3]) <= 7 and GetPedInVehicleSeat(vehicle,-1) == ped) then
				if vSERVER.checkCamuflagem('placa') then
					local placa = vSERVER.GetPlacaLivre()
					DisableControlAction(0,75,true)
					camuflando = true
					FreezeEntityPosition(vehicle,true)
					TriggerEvent("progress",10*1000,"Cambiando le piastre")
					Wait(10*1000)
					TriggerEvent('cloneplates', placa)
					camuflando = false
					FreezeEntityPosition(vehicle,false)
					DisableControlAction(0,75,false)
				end
			end
		end
	end
end)
RegisterCommand('pintarvehs', function(source, args, rawCmd)
	if not camuflando then
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(ped)
		for b, n in pairs(oficinasClandestinas) do
			local x,y,z = table.unpack(n)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z,true)
			if distance <= 7 and GetPedInVehicleSeat(vehicle,-1) == ped then
					if vSERVER.checkCamuflagem('pintura') then
					DisableControlAction(0,75,true)
					camuflando = true
					FreezeEntityPosition(vehicle,true)
					TriggerEvent("progress",4*1000,"Cambiando vernice")
					Wait(4*1000)
					local r,g,b = math.random(0,255), math.random(0,255), math.random(0,255)
					TriggerEvent('carroCor', vehicle, r, g, b)
					camuflando = false
					FreezeEntityPosition(vehicle,false)
					DisableControlAction(0,75,false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPRISION
-----------------------------------------------------------------------------------------------------------------------------------------
function client.isInPrision()
	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1698.96,2538.06,45.38,true)
	if distance <= 145 then
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
local inCamera = false
local camSelect = nil
local cameras = {
	["1"] = { 433.93,-978.23,34.72,104.89 },
	["2"] = { 424.59,-996.6,34.72,119.06 },
	["3"] = { 438.16,-999.32,33.72,192.76 },
	["4"] = { 148.99,-1036.29,32.34,306.15 },
	["5"] = { 300.97,-582.22,45.29,218.27 },
	["6"] = { 227.4,-577.62,46.86,269.3 },
	["7"] = { 22.0,-1602.84,32.37,153.08 }
}

RegisterNetEvent("rusher:serviceCamera")
AddEventHandler("rusher:serviceCamera",function(num)
	local ped = PlayerPedId()

	if inCamera then
		ClearTimecycleModifier()
		DestroyCam(camSelect,false)
		RenderScriptCams(false,false,0,1,0)
		PlaySoundFrontend(-1,"HACKING_SUCCESS",false)
        TriggerEvent('active:checkcam',true)
		inCamera = false
		camSelect = nil
	else
		if cameras[num] then
			TriggerEvent('active:checkcam',false)
			inCamera = true
			SetTimecycleModifier("heliGunCam")
			PlaySoundFrontend(-1,"HACKING_SUCCESS",false)
			camSelect = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
			SetCamCoord(camSelect,cameras[num][1],cameras[num][2],cameras[num][3])
			SetCamRot(camSelect,-20.0,0.0,cameras[num][4])
			RenderScriptCams(true,false,0,1,0)
		end
	end
end)


function GetPlayers()
	local players = {}
	for k,v in ipairs(GetActivePlayers()) do
		table.insert(players,v)
	end
	return players
end

function GetTouchedPlayers()
	local players = {}
	for k,v in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(),GetPlayerPed(v)) then
			table.insert(players,v)
		end
	end
	return players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES EXTRASUNNY/CLEAR/NEUTRAL/SMOG/FOGGY/OVERCAST/CLOUDS/CLEARING/RAIN/THUNDER/SNOW/BLIZZARD/SNOWLIGHT/XMAS/HALLOWEEN
-----------------------------------------------------------------------------------------------------------------------------------------
local minutes = 1
local hours = 0
local actualWeather = "CLEAR"
local weathers = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "HALLOWEEN"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notte",function(source,args)
    minutes = parseInt(00)
    hours = parseInt(00)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("giorno",function(source,args)
    minutes = parseInt(00)
    hours = parseInt(12)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("orario",function(source,args)
    if args[1] and args[2] then
        hours = parseInt(args[1])
        minutes = parseInt(args[2])
    else
        TriggerEvent('Notify', 'negato', 'Utilizza: /hora ore minuti')
    end
end)
--------------------------------------------------------------------------------------------------------------------------------
-- SYNC : CLIMA
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clima', function(source, args)
    if args[1] then
        local weather = parseInt(args[1])
        if weather > 0 then
            if weathers[weather] then
                actualWeather = weathers[weather]
                TriggerEvent('Notify', 'successo', 'Hai cambiato il tempo in <b>'..actualWeather..'</b>.')
            end
        else
            TriggerEvent('Notify', 'negato', 'È necessario specificare un numero di <b>1 a ' .. #weathers .. '</b>.')
        end
    else
        TriggerEvent('Notify', 'negato', 'È necessario specificare un numero di <b>1 a ' .. #weathers .. '</b>.')
    end
end)
---------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
		local peaga = 100
        SetWeatherTypeNow(actualWeather)
        SetWeatherTypePersist(actualWeather)
        SetWeatherTypeNowPersist(actualWeather)
        NetworkOverrideClockTime(hours,minutes,00)
        Wait(peaga)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
-------- x na mira
------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local sleep = 1000
        if IsPedArmed(PlayerPedId(),6) then
			sleep = 4
            DisableControlAction(1,140,true)
            DisableControlAction(1,141,true)
            DisableControlAction(1,142,true)
        end
        Wait(sleep)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR O Q
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
  while true do
    local peaga = 500
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    if health >= 101 then
        DisableControlAction(0,44,true)
    end
	Wait(peaga)
  end
end)

CreateThread(function()

	StatSetInt(GetHashKey("MP0_SHOOTING_ABILITY"), 100, true) --        // Shooting
	StatSetInt(GetHashKey("MP0_STRENGTH"), 100, true) --                // Strength
	StatSetInt(GetHashKey("MP0_STEALTH_ABILITY"), 100, true) --         // Stealth
	StatSetInt(GetHashKey("MP0_FLYING_ABILITY"), 100, true) --          // Flying
	StatSetInt(GetHashKey("MP0_WHEELIE_ABILITY"), 100, true) --         // Driving
	StatSetInt(GetHashKey("MP0_LUNG_CAPACITY"), 100, true) --           // Lung Capacity
	StatSetFloat(GetHashKey("MP0_PLAYER_MENTAL_STATE"), tonumber("0.0"), true) --    // Mental State
	StatSetInt(GetHashKey("MP0_STAMINA"), 100, true)
	Citizen.InvokeNative(0xDC0F817884CDD85, 1, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 4, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 6, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 12, false)

	SetPlayerCanUseCover(PlayerId(), false)
	
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.1) 

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.1) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"), 0.1) --7 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 0.5) --9 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"), 0.5) --9 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPDW"), 0.5) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG_MK2"), 0.6) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE_MK2"), 0.40) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 0.40) --8 colpi


	N_0x4757f00bc6323cfe(GetHashKey("weapon_specialcarbine_mk2"), 0.40) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"), 0.2) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"), 0.2) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.2) --8 colpi

	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.2) 
	
		


	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("PoliceScannerDisabled", true)
	local w1 = GetHashKey("PICKUP_WEAPON_PISTOL")
	local w2 = GetHashKey("PICKUP_WEAPON_MINISMG")
	local w3 = GetHashKey("PICKUP_WEAPON_PUMPSHOTGUN")
	local w4 = GetHashKey("PICKUP_WEAPON_CARBINERIFLE")
    while true do
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        RemoveVehiclesFromGeneratorsInArea(x-9999.0,y-9999.0,z-9999.0,x+9999.0,y+9999.0,z+9999.0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.1) 
        -----------------------------------------------------------------------------------------
        HideHudComponentThisFrame( 1 ) -- Wanted Stars 
        HideHudComponentThisFrame( 2 ) -- Weapon Icon
        HideHudComponentThisFrame( 3 ) -- Cash
        HideHudComponentThisFrame( 4 ) -- MP Cash
        HideHudComponentThisFrame( 6 ) -- Vehicle Name
        HideHudComponentThisFrame( 7 ) -- Area Name
        HideHudComponentThisFrame( 8 ) -- Vehicle Class
        HideHudComponentThisFrame( 9 ) -- Street Name
        HideHudComponentThisFrame( 13 ) -- Cash Change
        HideHudComponentThisFrame( 17 ) -- Save Game  
        HideHudComponentThisFrame( 20 ) -- Weapon Stats
		HideHudComponentThisFrame( 21 ) -- Weapon Stats
        HideHudComponentThisFrame( 22 ) -- 
        SetPedCanLosePropsOnDamage(PlayerPedId(), false)
        SetPedSuffersCriticalHits(GetPlayerPed(-1), true)
        DisableControlAction(0,44,true)
        DisablePlayerVehicleRewards(PlayerId())
        ForceAmbientSiren(false)
		SetCreateRandomCops(false)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetDispatchCopsForPlayer(GetPlayerPed(-1),true)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
        DisableControlAction(1,157,false)
        DisableControlAction(1,158,false)
        ForceAmbientSiren(false)
		SetCreateRandomCops(false)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetDispatchCopsForPlayer(GetPlayerPed(-1),true)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
        Citizen.Wait(1)
    end
end)