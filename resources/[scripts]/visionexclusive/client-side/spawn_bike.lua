local bikeTaken = false

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
        local distance = #(coords - vector3(216.0,-1389.86,30.59))
        if distance <= 15 then
            timeDistance = 1
            DrawMarker(27, 216.0,-1389.86,30.59-1, 0, 0, 0, 0.0, 0, 0, 0.90, 0.90, 0.90, 192, 16, 236,180, 0, 0, 0, 1)
            if distance <= 2 then
                DrawText3Ds(216.0,-1389.86,30.59+1,"~q~E~w~   PRENDERE IL VEICOLO")
                if IsControlJustPressed(1,38) then

                    if IsPedOnFoot(PlayerPedId()) then
                        if not bikeTaken then
                            bikeTaken = true
                            SpawnVehicle("fixter")
                        end
                    elseif IsPedOnAnyBike(PlayerPedId()) then
                        bikeTaken = false
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                    end
                end
            end
        end
		Citizen.Wait(timeDistance)
	end
end)

function SpawnVehicle(vehicle)
    local coords = vector3(218.97,-1384.63,30.58)
    local x,y,z = table.unpack(coords)
    local model = GetHashKey(vehicle)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    local vehicle = CreateVehicle(model, x, y, z, 0.0, true, false)
    SetEntityHeading(vehicle, 272.42)
    

    SetEntityAsMissionEntity(vehicle, true, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(model)

    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

end

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end