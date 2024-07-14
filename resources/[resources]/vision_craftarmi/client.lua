local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vision = Tunnel.getInterface(GetCurrentResourceName())
src = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
    menuactive = not menuactive
    if menuactive then
        SetNuiFocus(true, true)
        TransitionToBlurred(1000)
        SendNUIMessage({action = 'open'})
    else
        SetNuiFocus(false)
        TransitionFromBlurred(1000)
        SendNUIMessage({action = 'close'})
    end
end

RegisterNetEvent("vision:TravarPed")
AddEventHandler(
    "vision:TravarPed",
    function(status)
        FreezeEntityPosition(PlayerPedId(), status)
    end
)

RegisterNetEvent("armas:anin")
AddEventHandler(
    "armas:anin",
    function()
        vRP.playAnim(false, {"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}, true)
        Wait(5000)
        vRP._stopAnim(source, false)
    end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback(
    "getItem",
    function(data, cb)
        local data = data.modeName
        if data == "FIVE SEVEN" then
            TriggerServerEvent("vision:ArmasTransformar", "wbody|WEAPON_PISTOL_MK2")
        elseif data == "TEC-9" then
            TriggerServerEvent("vision:ArmasTransformar", "wbody|WEAPON_MACHINEPISTOL")
        elseif data == "SMG" then
            TriggerServerEvent("vision:ArmasTransformar", "wbody|WEAPON_SMG_MK2")
        elseif data == "SCAR" then
            TriggerServerEvent("vision:ArmasTransformar", "wbody|WEAPON_SPECIALCARBINE")
        elseif data == "G36" then
            TriggerServerEvent("vision:ArmasTransformar", "wbody|WEAPON_SPECIALCARBINE_MK2")
        elseif data == "GLOCK 18" then
            TriggerServerEvent("vision:ArmasTransformar", "wbody|WEAPON_APPISTOL")
        end
    end
)


RegisterNUICallback('close',function(data,cb)
    SendNUIMessage({action = 'close'})
    SetNuiFocus(false, false)
    TransitionFromBlurred(1000)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local markers = {
    {1279.34,-1696.81,49.91}, -- CRIPS  
    {1278.83,-1694.04,49.92}, -- CRIPS  
    {1284.31,-1691.85,49.91}, -- CRIPS  
    {-1106.37,-1638.28,-1.0}, -- BLOODS
    {-1104.07,-1637.47,-0.99}, -- BLOODS
    {-1100.57,-1642.24,-1.0}, -- BLOODS
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local innerTable = {}
    for k, v in pairs(markers) do
        table.insert(innerTable,{ v[1],v[2],v[3],1,"E","craft armi","apri","premi" })
    end
    TriggerEvent("hoverfy:insertTable", innerTable)
end)

RegisterKeyMapping("farma", "vision", "keyboard", "e")

RegisterCommand(
    "farma",
    function(source, args, rawCommand)
        for _, mark in pairs(markers) do
            local x, y, z = table.unpack(mark)
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x, y, z, true)
            if distance <= 1 then
                if vision.checkPermission() then
                    SendNUIMessage({action = 'open'})
                    SetNuiFocus(true, true)
                    TransitionToBlurred(1000)
                end
            end
        end
    end
)
