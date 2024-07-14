local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local rusher = {}
Tunnel.bindInterface("vrp_admin",rusher)
vSERVER = Tunnel.getInterface("vrp_admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD RICH PRESENCE CLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.setDiscord(status)
    SetDiscordAppId(1129096066801868801)
    SetDiscordRichPresenceAsset('perfil')
    SetDiscordRichPresenceAction(0,'DISCORD','https://discord.gg/visionexclusive')
    SetRichPresence(status)
end

function rusher.setEntered()
	ExecuteCommand("giorno")
end


RegisterCommand("moto", function(source, args,)
    local player = source
    if player then
        local x, y, z = table.unpack(GetEntityCoords(player))
        local vehicle = CreateVehicle("bati", x, y, z + 1.0, GetEntityHeading(player), true, false)    
        SetPedIntoVehicle(player, vehicle, -1)
    end
end)




RegisterCommand("ammo",function (src,arg)
    local Ped = GetPlayerPed(-1)
    if IsPedArmed(Ped, 4) then 
        local WeaponHash = GetSelectedPedWeapon(Ped)
        if WeaponHash ~= nil then
            AddAmmoToPed(Ped, WeaponHash,250)
			TriggerEvent("Notify","successo","Hai caricato <b>250</b> Munizioni.")
        end   
    else
		TriggerEvent("Notify","errore","Non hai un arma in mano!")
    end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('adminClothes')
AddEventHandler('adminClothes',function(custom)
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
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
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
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
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
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.syncArea(x,y,z)
    ClearAreaOfVehicles(x,y,z,2000.0,false,false,false,false,false)
    ClearAreaOfEverything(x,y,z,2000.0,false,false,false,false)
end

function rusher.spawnpolice()
	local ped = PlayerPedId()
	SetEntityHealth(ped,400)
	SetEntityInvincible(ped,false)
	FreezeEntityPosition(ped,false)
end

local godmode = false 
function rusher.godmode()
	local ped = PlayerPedId()
	if not godmode then
	godmode = true
	SetEntityInvincible(ped,true)
	TriggerEvent("Notify","successo","Vita infinita attivata.")
	else
		godmode = false 
		SetEntityInvincible(ped,false)
		TriggerEvent("Notify","negato","Vita infinita spenta.")
		end
end

ghostmode = false
function rusher.ghostmode()
	local ped = PlayerPedId()
	if not ghostmode then
    ghostmode = true
	SetEntityVisible(ped,false)
	TriggerEvent("Notify","successo","Sei invisibile.")
	else
		ghostmode = false 
		SetEntityCollision(ped,true)
		SetEntityVisible(ped,true)
		TriggerEvent("Notify","successo","Sei visibile.")
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.applySkinAdmin(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEADING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h",function(source,args)
    vRP.prompt("Heading:",GetEntityHeading(PlayerPedId()))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.vehicleHash(vehicle)
	vRP.prompt("Hash:",GetEntityModel(vehicle))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.spawnVeh(name)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local ped = PlayerPedId()
		local nveh = CreateVehicle(mhash,GetEntityCoords(ped),GetEntityHeading(ped),true,false)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		SetVehicleOnGroundProperly(nveh)
		SetVehicleAsNoLongerNeeded(nveh)
		SetVehicleIsStolen(nveh,false)
		SetPedIntoVehicle(ped,nveh,-1)
		SetVehicleNeedsToBeHotwired(nveh,false)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehRadioStation(nveh,"OFF")

		SetModelAsNoLongerNeeded(mhash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- efeitinhonoclip
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('efeitinholgbt')
AddEventHandler('efeitinholgbt',function()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
    local particleDictionary = "scr_rcbarry2"
    local particleName = "scr_clown_death"
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall(particleDictionary)
    local effect = StartParticleFxLoopedOnPedBone("scr_clown_death",v,0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(v,11816),2.0,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.tptoWay()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		ped = GetVehiclePedIsUsing(ped)
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,1,0,0)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(1)
		end

		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(ped,0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,1,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROLLS
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.makeFly()
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))

    SetEntityCoords(ped,x,y,z+1000)
	vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1000 }})
end

function rusher.neyMar(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)
end

function rusher.ExplodirPessoa(x,y,z)
	AddExplosion(x,y,z, 6, 100.0, true, false, 5.0)
end

RegisterNetEvent('rusher:FurarPneuTeleguiado')
AddEventHandler('rusher:FurarPneuTeleguiado', function(roda)
	if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1)  == PlayerPedId() then
		SetVehicleTyreBurst(GetVehiclePedIsIn(PlayerPedId(), false), roda, true, 1000.0)
	end
end)

function rusher.SyncPneuFurado(veh,index)
	local carro = NetToVeh(veh)
	if veh and carro then
		SetVehicleTyreBurst(carro, index, true, 1000.0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj",function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToEnt(index)
        if DoesEntityExist(v) then
            SetEntityAsMissionEntity(v,false,false)
            DeleteEntity(v)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
function rusher.vehicleTuning()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
        SetVehicleWindowTint(vehicle,1)
	end
end

function rusher.vehicleTuning2(vehicle)
	local ped = PlayerPedId()
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-1,false)
		ToggleVehicleMod(vehicle,18,true)
	end
end

------------------------------------------------------------------------------------------------------------------------------
-- COR FAROL
------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:CorFarolCl')
AddEventHandler('rusher:CorFarolCl',function(vehicle, cor)
	TriggerServerEvent("rusher:SyncCorFarol",VehToNet(vehicle), cor)
end)

RegisterNetEvent("rusher:SyncCorFarolCl")
AddEventHandler("rusher:SyncCorFarolCl",function(index, cor)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				ToggleVehicleMod(v, 22, true)
				SetVehicleHeadlightsColour(v, cor)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('foguinho')
AddEventHandler('foguinho',function(source)
    local ped = PlayerPedId(-1)
    if not blutzadafire then
        blutzadafire = true
        Citizen.Wait(100)
        StartEntityFire(ped);
    else
        blutzadafire = false
        StopEntityFire(ped);
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('bigar')
AddEventHandler('bigar',function()
	local ped = PlayerPedId()
    vRP._stopAnim(true)
    FreezeEntityPosition(ped,true)
    TriggerEvent("cancelando",true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('desbigar')
AddEventHandler('desbigar',function()
	local ped = PlayerPedId()
    vRP._stopAnim(false)
    FreezeEntityPosition(ped,false)
    TriggerEvent("cancelando",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICAÇÃO /ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusherUi:MostrarNotAdm')
AddEventHandler('rusherUi:MostrarNotAdm', function (args)
	local title = args[1]
	local message = args[2]
	SendNUIMessage({ action = 'sendNotification', title = title, message = message })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:AdminSetPlaca')
AddEventHandler('rusher:AdminSetPlaca', function(nveh, placa)
	SetVehicleNumberPlateText(nveh,placa)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('admcuff')
AddEventHandler('admcuff',function()
	local ped = PlayerPedId()
	if vRP.isHandcuffed() then
		vRP._setHandcuffed(source,false)
		SetPedComponentVariation(PlayerPedId(),7,0,0,2)
	end
end)

local showMe = {}

RegisterNetEvent("vrp_showme:pressMe")
AddEventHandler("vrp_showme:pressMe", function(source, text, v)
    local pedSource = GetPlayerFromServerId(source)
    if pedSource ~= -1 and v ~= nil then
        showMe[GetPlayerPed(pedSource)] = { text, v[1], v[2], v[3], v[4], v[5] }
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOWMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(showMe) do
			local coordsMe = GetEntityCoords(k)
			local distance = #(coords - coordsMe)
			if distance <= 5 then
				timeDistance = 4
				if HasEntityClearLosToEntity(ped,k,17) then
					showMe3D(coordsMe.x,coordsMe.y,coordsMe.z+0.90,string.upper(v[1]),v[3],v[4],v[5],v[6])
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRHEADSHOWMETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(showMe) do
			if v[2] > 0 then
				v[2] = v[2] - 1
				if v[2] <= 0 then
					showMe[k] = nil
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWME3D
-----------------------------------------------------------------------------------------------------------------------------------------
function showMe3D(x,y,z,text,h,back,color,opacity)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(color,color,color,opacity)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / h
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,back,back,back,150)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:ZerarArmas')
AddEventHandler('rusher:ZerarArmas', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:SetarDentroDocarro')
AddEventHandler('rusher:SetarDentroDocarro', function(nsource)
	local nplayer = GetPlayerFromServerId(nsource)
	local nped = GetPlayerPed(nplayer)
	local ncarro = GetVehiclePedIsUsing(nped)
	local ped = PlayerPedId()
	if ncarro then
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:SetarDentroDocarro2')
AddEventHandler('rusher:SetarDentroDocarro2', function()
	local ped = PlayerPedId()
	local ncarro = vRP.getNearestVehicle(15)
	if IsVehicleSeatFree(ncarro, -1) then
		SetPedIntoVehicle(ped, ncarro, -1)
	else
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)

RegisterNetEvent('rusher:VerCustom:MostrarCl')
AddEventHandler('rusher:VerCustom:MostrarCl', function()
	local ped = PlayerPedId()
	local custom = {}
	custom[1] = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1) }
	custom[3] = { GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3) }
	custom[4] = { GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4) }
	custom[5] = { GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5) }
	custom[6] = { GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6) }
	custom[7] = { GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7) }
	custom[8] = { GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8) }
	custom[9] = { GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9) }
	custom[10] = { GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10) }
	custom[11] = { GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11) }
	custom["p0"] = { GetPedPropIndex(ped,0),math.max(GetPedPropTextureIndex(ped,0),0) }
	custom["p1"] = { GetPedPropIndex(ped,1),math.max(GetPedPropTextureIndex(ped,1),0) }
	custom["p2"] = { GetPedPropIndex(ped,2),math.max(GetPedPropTextureIndex(ped,2),0) }
	custom["p6"] = { GetPedPropIndex(ped,6),math.max(GetPedPropTextureIndex(ped,6),0) }
	custom["p7"] = { GetPedPropIndex(ped,7),math.max(GetPedPropTextureIndex(ped,7),0) }
	TriggerServerEvent('rusher:VerCustom:Mostrar', custom) 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('carroCor')
AddEventHandler('carroCor',function(vehicle, r, g, b)
	TriggerServerEvent("trycorveh",VehToNet(vehicle), r, g, b)
end)
RegisterNetEvent("synccorveh")
AddEventHandler("synccorveh",function(index, r, g, b)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				SetVehicleCustomPrimaryColour(v, r, g, b)
				SetVehicleCustomSecondaryColour(v, r, g, b)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PINTAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('pintarveiculo')
AddEventHandler('pintarveiculo',function(vehicle, tipo, valor)
	TriggerServerEvent("trypintarveh",VehToNet(vehicle), tipo, valor)
end)
RegisterNetEvent("syncpintarveh")
AddEventHandler("syncpintarveh",function(index, tipo, valor)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				SetVehicleModColor_1(v, tipo, valor, 0)
				SetVehicleModColor_2(v, tipo, valor)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPAR PLAYER - /marcar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:MarcarPlayer')
AddEventHandler('rusher:MarcarPlayer',function(x,y,z,id)
	jogador = AddBlipForCoord(x,y,z)
	SetBlipSprite(jogador,126)
	SetBlipColour(jogador,43)
	SetBlipScale(jogador,0.4)
	SetBlipAsShortRange(jogador,false)
	SetBlipRoute(jogador,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("ID " .. id)
	EndTextCommandSetBlipName(jogador)
	SetTimeout(60000, function()
		if jogador then
			RemoveBlip(jogador)
		end
	end)
end)

RegisterNetEvent('rusher:rMarcarPlayer')
AddEventHandler('rusher:rMarcarPlayer',function()
	RemoveBlip(jogador)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher:MarcarGps')
AddEventHandler('rusher:MarcarGps', function (x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rusher:RepararMotor")
AddEventHandler("rusher:RepararMotor",function(vida)
    SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false), vida)
end)

local wasd = false
local drifttroll = false
function rusher.CheckWasd()
	wasd = not wasd
	return wasd
end

function rusher.CheckDrift()
	drifttroll = not drifttroll
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsIn(ped, false)
		SetVehicleReduceGrip(veh,drifttroll)
	end
	return drifttroll
end

Citizen.CreateThread(function() 
	while true do
		local ThreadDelay = 2000
		local ped = PlayerPedId()
		if drifttroll then
			ThreadDelay = 5
			if IsPedInAnyVehicle(ped, false) then
				local veh = GetVehiclePedIsIn(ped, false)
				SetVehicleReduceGrip(veh,true)
			end
		end

		if wasd then
			ThreadDelay = 5
			for i = 0, 357 do
				DisableControlAction(0, i, true)
			end
		end
		Citizen.Wait(ThreadDelay)
	end
end)


