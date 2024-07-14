RegisterNetEvent('progress')
AddEventHandler('progress', function(time, action)
    if not action then
        action = "Caricando"
    end
    SendNUIMessage({ delay = time, action = action })
end)