RegisterNetEvent("Notify")
AddEventHandler("Notify", function(type, message, delay)
    if not delay then
        delay = 6000
    end
    SendNUIMessage({ type = type, message = message, delay = delay })
end)



