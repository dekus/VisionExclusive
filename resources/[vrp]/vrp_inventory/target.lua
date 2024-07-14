local cb_ = nil
local maxDistance2 = 10.0

isSelectingActive = false
isNuiActive = false
isSelectNpcMode = false

function closeNui()
    SetNuiFocus(false, false)
    isNuiActive = false
end

RegisterNetEvent('nfesx_targeting:beginTargeting')
AddEventHandler('nfesx_targeting:beginTargeting', function(cb, maxDistance, isSelectCorpse)
    cb_ = cb
    startTargeting()
    

    maxDistance2 = maxDistance or maxDistance2
    isSelectNpcMode = isSelectCorpse or false


end)

local closestPed = nil

Citizen.CreateThread(function()
    local plyPed = PlayerPedId()
    while true do
        if(canBillingMode) then
            if(isSelectingActive) then
                local plyPos = GetEntityCoords(plyPed)
                
                local xClosestDistance = 5.0
                local yClosestDistance = 5.0
                for currentPed in EnumeratePeds() do
                    if(IsPedAPlayer(currentPed)) or (isSelectNpcMode and IsPedDeadOrDying(currentPed, 1)) then
                        local currentPedCoords = GetPedBoneCoords(currentPed, 24818, 0.0, 0.0, 0.0)

                        local distance = GetDistanceBetweenCoords(currentPedCoords, plyPos, true)

                        if(distance < maxDistance2) then
                            local _, screenX, screenY = GetScreenCoordFromWorldCoord(currentPedCoords.x, currentPedCoords.y, currentPedCoords.z)
                            
                            if(screenX > 0 and screenY > 0) then
                                local mouseX, mouseY = GetNuiCursorPosition()
                                
                                local screenWidth, screenHeight = GetActiveScreenResolution()
                                
                                if(mouseX <= screenWidth and mouseY <= screenHeight) then
                                    mouseX = mouseX/screenWidth
                                    mouseY = mouseY/screenHeight

                                    local xScreenDistance = math.abs(mouseX-screenX)
                                    local yScreenDistance = math.abs(mouseY-screenY)

                                    if(xScreenDistance < 0.03 and yScreenDistance < 0.1) then
                                        if(xClosestDistance > xScreenDistance and yClosestDistance > yScreenDistance and plyPed ~= currentPed) then
                                            xClosestDistance = xScreenDistance
                                            yClosestDistance = yScreenDistance
                                            closestPed = currentPed
                                        end
                                    else
                                        if(currentPed == closestPed) then
                                            closestPed = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            
                Citizen.Wait(100)
            else
                plyPed = PlayerPedId()
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(5000)
            canBillingMode = true
        end

        Citizen.Wait(0)
    end
end)

function startTargeting() 
    isSelectingActive = true
    
    Citizen.CreateThread(function()

        SetNuiFocus(false, true)
        
        while isSelectingActive do

            if(closestPed) then
                local pedCoords = GetPedBoneCoords(closestPed, 24817, 0.0, 0.0, 0.0)
                DrawMarker(20, 
                pedCoords.x, pedCoords.y, pedCoords.z + 0.8, 
                0.0, 0.0, 0.0,
                0.0, 180.0, 0.0,
                0.2, 0.2, 0.2,
                174, 11, 245, 100, 
                false, true, 2, false, nil, nil, nil)
            end
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 200, true)

            ---
            DisablePlayerFiring(PlayerPedId(), true)

            Citizen.Wait(0)
        end


        closestPed = nil
        DisablePlayerFiring(PlayerPedId(), false)
    end)
end

Citizen.CreateThread(function()

    AddTextEntry("nfesx-targeting-select-player", "Seleziona un ~p~giocatore~s~ ")

    while true do
        Citizen.Wait(0)

        if(isSelectingActive) then
            DisplayHelpTextThisFrame("nfesx-targeting-select-player", false)
        end

        if(canBillingMode) then
            if(not isNuiActive) then
                if IsDisabledControlJustReleased(0, 200) or IsDisabledControlJustReleased(0, 202) then
                    isSelectingActive = false
                    closeNui()
                elseif(IsDisabledControlJustReleased(0, 24)) then
                    if(closestPed and not isSelectNpcMode)  then
                        local targetPlayer = NetworkGetPlayerIndexFromPed(closestPed)
                        local targetId = GetPlayerServerId(targetPlayer)
                        SetNuiFocus(false, false)
                        isNuiActive = false
                        local sourceLocation = GetEntityCoords(PlayerPedId())
                        local targetLocation = GetEntityCoords(closestPed)

                        if (#(sourceLocation - targetLocation) < maxDistance2) then   
                            cb_(targetId, closestPed)
                        else
                            TriggerEvent("Notify","negato","Sei troppo distante dal bersaglio")
                        end

                        isSelectingActive = false

                    elseif(closestPed and isSelectNpcMode) then
                        SetNuiFocus(false, false)
                        isNuiActive = false
                        local sourceLocation = GetEntityCoords(PlayerPedId())
                        local targetLocation = GetEntityCoords(closestPed)
                        if (#(sourceLocation - targetLocation) < maxDistance2) then   
                            cb_(closestPed)
                        else
                            TriggerEvent("Notify","negato","Sei troppo distante dal bersaglio")
                        end
                        isSelectingActive = false
                    end
                end
            else
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
		
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
		
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end