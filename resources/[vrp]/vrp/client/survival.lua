-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getHealth()
	return GetEntityHealth(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setHealth(health)
	--TriggerEvent('rusher:ExcecaoVida')
	SetEntityHealth(PlayerPedId(),parseInt(health))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETFRIENDLYFIRE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setFriendlyFire(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCAUTEVAR
-----------------------------------------------------------------------------------------------------------------------------------------
local nocauteado = false
local deathtimer = 200
local facs = false
local norte = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCAUTEADO
-----------------------------------------------------------------------------------------------------------------------------------------

function tvRP.CheckSegundosMorto()
	return deathtimer
end

function tvRP.SetSegundosMorto(seg)
	deathtimer = seg
end


function tvRP.showred()
	SendNUIMessage({ act = "showredot" })
end

Citizen.CreateThread(function()
	while true do
		local idle = 100
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
			idle = 0
			if not nocauteado then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				NetworkResurrectLocalPlayer(x,y,z,true,true,false)
				deathtimer = 100
				nocauteado = true
				SendNUIMessage({ death = true })
				vRPserver._updateHealth(101)
				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)
				
				if IsPedInAnyVehicle(ped) then
					TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
				end
			else

				if deathtimer > 0 then
					drawTxt("HAI ~p~"..deathtimer.." ~w~SECONDI DA VIVERE",4,0.5,0.93,0.50,255,255,255,255)
				else
					drawTxt("PREMI ~p~E ~w~NASCERE NELL'OSPEDALE DEL SUD",4,0.5,0.84,0.50,255,255,255,255)
					drawTxt("PREMI ~p~X ~w~PER RIENTRARE NELLA TUA BASE",4,0.5,0.87,0.50,255,255,255,255)
					drawTxt("PREMI ~p~G ~w~PER NASCERE A CASA TUA",4,0.5,0.90,0.50,255,255,255,255)
					drawTxt("O ASPETTARE ~r~AIUTO MEDICO",4,0.5,0.95,0.50,255,255,255,255)
					if IsControlJustPressed(0,38)  then -- E
						TriggerServerEvent('rusher:Aeroporto:Server', 1)
						norte = false
						facs = false
					end
					if IsControlJustPressed(0,120) then -- X
						facs = true
						norte = false
						TriggerServerEvent('rusher:Aeroporto:Server', 3)
					end
					if IsControlJustPressed(0,113) then -- G
						TriggerServerEvent('rusher:Aeroporto:Server2', 4)
						facs = false
						norte = false
					end
				end

				SetEntityHealth(ped,101)
				BlockWeaponWheelThisFrame()
				DisablePlayerFiring(PlayerId(),true)
				DisableControlAction(0,21,true)
				DisableControlAction(0,22,true)
				DisableControlAction(0,23,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,29,true)
				DisableControlAction(0,32,true)
				DisableControlAction(0,33,true)
				DisableControlAction(0,34,true)
				DisableControlAction(0,35,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,56,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,73,true)
				DisableControlAction(0,75,true)
				DisableControlAction(0,137,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
				DisableControlAction(0,166,true)
				DisableControlAction(0,167,true)
				DisableControlAction(0,168,true)
				DisableControlAction(0,169,true)
				DisableControlAction(0,170,true)
				DisableControlAction(0,177,true)
				DisableControlAction(0,182,true)
				DisableControlAction(0,187,true)
				DisableControlAction(0,188,true)
				DisableControlAction(0,189,true)
				DisableControlAction(0,190,true)
				DisableControlAction(0,243,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,268,true)
				DisableControlAction(0,269,true)
				DisableControlAction(0,270,true)
				DisableControlAction(0,271,true)
				DisableControlAction(0,288,true)
				DisableControlAction(0,289,true)
				DisableControlAction(0,311,true)
				DisableControlAction(0,344,true)
				SetPedToRagdoll(ped,2000,2000,0,0,0,0)
			end
		end
		Citizen.Wait(idle)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.AeroportoClient(pulica,ballas,groove,vagos,yardie,siciliana,bloods,crips,bahamas,life)
    local ped = PlayerPedId()
    TriggerEvent('rusher:ExcecaoTp')
    TriggerEvent('rusher:ExcecaoVida')
    TriggerEvent('rusher:ExcecaoGod')
    deathtimer = 200
    nocauteado = false
    ClearPedBloodDamage(ped)
    SetEntityInvincible(ped,false)
    DoScreenFadeOut(1000)
    SetEntityHealth(ped,399)
    Citizen.Wait(1000)
    
    if pulica then
        SetEntityCoords(ped,-1645.35,216.81,60.65,1,0,0,1)
    elseif facs then
        if ballas then
          SetEntityCoords(ped,103.45,-1957.59,20.75,1,0,0,1)
        elseif groove then
          SetEntityCoords(ped,-197.6,-1699.96,33.5,1,0,0,1)
        elseif vagos then
          SetEntityCoords(ped,302.86,-2018.93,20.29,1,0,0,1)
        elseif yardie then
          SetEntityCoords(ped,-1527.07,870.36,181.69,1,0,0,1)
        elseif siciliana then
          SetEntityCoords(ped,-1463.28,-42.84,54.65,1,0,0,1)
        elseif bloods then
          SetEntityCoords(ped,-1088.02,-1672.13,4.71,1,0,0,1)
        elseif crips then
          SetEntityCoords(ped,1279.94,-1722.44,54.66,1,0,0,1)
				elseif bahamas then
          SetEntityCoords(ped,-1393.81,-639.45,28.68,1,0,0,1)
				elseif life then
          SetEntityCoords(ped,-1043.11,-237.03,37.97,1,0,0,1)
				else
					SetEntityCoords(ped,296.28,-614.8,43.43,1,0,0,1)
				end
    else
      SetEntityCoords(ped,296.28,-614.8,43.43,1,0,0,1)
    end
    FreezeEntityPosition(ped,true)
    SetTimeout(5000,function()
        SetEntityHealth(ped,399)
        FreezeEntityPosition(ped,false)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end)
end

function tvRP.AeroportoClient2()
	local ped = PlayerPedId()
	TriggerEvent('rusher:ExcecaoTp')
	TriggerEvent('rusher:ExcecaoVida')
	TriggerEvent('rusher:ExcecaoGod')
	deathtimer = 200
	nocauteado = false
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	DoScreenFadeOut(1000)
	SetEntityHealth(ped,399)
	Citizen.Wait(1000)
	TriggerServerEvent('rusher:Login:SpawnCasa')
	FreezeEntityPosition(ped,true)
	SetTimeout(5000,function()
		SetEntityHealth(ped,399)
		FreezeEntityPosition(ped,false)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
        Citizen.Wait(100)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if nocauteado and deathtimer > 0 then
			deathtimer = deathtimer -1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISINCOMA
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.isInComa()
	return nocauteado
end



-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKRESSURECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.killGod()
	nocauteado = false
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,102)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PrisionGod()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		nocauteado = false
		ClearPedBloodDamage(ped)
		SetEntityInvincible(ped,false)
		SetEntityHealth(ped,201)
		ClearPedTasks(ped)
		ClearPedSecondaryTask(ped)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

