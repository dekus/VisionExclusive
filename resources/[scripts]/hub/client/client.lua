RegisterNetEvent("hub:open",function()
    TriggerEvent("dynamic:closeSystem")
    Citizen.Wait(250)
    SetNuiFocus(true,true)
    SendNUIMessage({ action = "open" })
end)

RegisterNUICallback("close",function(data,cb)
    SetNuiFocus(false,false)
    cb("ok")
end)

RegisterNUICallback("tryAcceptRequest",function(data,cb)
    if data.id then
        server.tryAcceptRequest(data.id)
    end
    cb({})
end)

RegisterNetEvent("hub:deleteRequest", function(id)
    SendNUIMessage({ action = "deleteRequest", delete = tonumber(id) })
end)

RegisterNetEvent("hub:sendRequest", function(title, description, id)
    SendNUIMessage({ action = "addRequest", title = title, description = description, id = id })
end)

RegisterNetEvent("hub:setAcceptedRequest", function(requestId, userId)
    SendNUIMessage({ action = "setAcceptedRequest", id = requestId, user_id = userId })
end)

RegisterCommand("chiamateadm",function()
    if server.CheckPermission() then
        SendNUIMessage({ action = "open" })
        SetNuiFocus(true,true)
    end
end)

RegisterKeyMapping('chiamateadm', '[MRQZ] Hub delle chiamate', 'keyboard', 'F9')

RegisterNetEvent('hub:blipMap', function (x,y,z)
    local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,358)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,48)
	SetBlipScale(blip,0.4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("~¦~ Chiamato")
	EndTextCommandSetBlipName(blip)
    Wait(120000)
    RemoveBlip(blip)
end)

