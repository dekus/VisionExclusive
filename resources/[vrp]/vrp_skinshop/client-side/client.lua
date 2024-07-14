-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_skinshop", cRP)
vSERVER = Tunnel.getInterface("vrp_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local skinData = {}
local heading = 332.219879
local previousSkinData = {}
local customCamLocation = nil
local creatingCharacter = false
local oldData = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
local skinData = {
    ["pants"] = { item = 0, texture = 0 },
    ["arms"] = { item = 0, texture = 0 },
    ["tshirt"] = { item = 1, texture = 0 },
    ["torso"] = { item = 0, texture = 0 },
    ["vest"] = { item = 0, texture = 0 },
    ["shoes"] = { item = 0, texture = 0 },
    ["mask"] = { item = 0, texture = 0 },
    ["hat"] = { item = -1, texture = 0 },
    ["glass"] = { item = 0, texture = 0 },
    ["ear"] = { item = -1, texture = 0 },
    ["watch"] = { item = -1, texture = 0 },
    ["bracelet"] = { item = -1, texture = 0 },
    ["accessory"] = { item = 0, texture = 0 },
    ["decals"] = { item = 0, texture = 0 },
    ["bag"] = { item = 0, texture = 0 },
    ["decals"] = { item = 0, texture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:skinData")
AddEventHandler("vrp_skinshop:skinData", function(status)
    if status ~= "clean" then
        skinData["pants"] = { item = status["6"][1], texture = status["6"][2] }
        skinData["arms"] = { item = status["3"][1], texture = status["3"][2] }
        skinData["bag"] = { item = status["5"][1], texture = status["5"][2] }
        skinData["tshirt"] = { item = status["8"][1], texture = status["8"][2] }
        skinData["torso"] = { item = status["11"][1], texture = status["11"][2] }
        skinData["vest"] = { item = status["9"][1], texture = status["9"][2] }
        skinData["shoes"] = { item = status["6"][1], texture = status["6"][2] }
        skinData["mask"] = { item = status["1"][1], texture = status["1"][2] }
        skinData["hat"] = { item = status["p0"][1], texture = status["p0"][2] }
        skinData["glass"] = { item = status["p1"][1], texture = status["p1"][2] }
        skinData["ear"] = { item = status["p2"][1], texture = status["p2"][2] }
        skinData["watch"] = { item = status["p6"][1], texture = status["p6"][2] }
        skinData["bracelet"] = { item = status["p7"][1], texture = status["p7"][2] }
        skinData["accessory"] = { item = status["7"][1], texture = status["7"][2] }
        skinData["decals"] = { item = status["10"][1], texture = status["10"][2] }
        vRP.setClothes(status)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas", function(custom)
    local ped = PlayerPedId()
    if not IsPedSwimming(ped) and GetEntityHealth(ped) > 101 then
        if custom[1] == -1 then
            SetPedComponentVariation(ped, 1, 0, 0, 2)
        else
            SetPedComponentVariation(ped, 1, custom[1], custom[2], 2)
        end

        if custom[3] == -1 then
            SetPedComponentVariation(ped, 5, 0, 0, 2)
        else
            SetPedComponentVariation(ped, 5, custom[3], custom[4], 2)
        end

        if custom[5] == -1 then
            SetPedComponentVariation(ped, 7, 0, 0, 2)
        else
            SetPedComponentVariation(ped, 7, custom[5], custom[6], 2)
        end

        if custom[7] == -1 then
            SetPedComponentVariation(ped, 3, 15, 0, 2)
        else
            SetPedComponentVariation(ped, 3, custom[7], custom[8], 2)
        end

        if custom[9] == -1 then
            if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
                SetPedComponentVariation(ped, 4, 18, 0, 2)
            elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
                SetPedComponentVariation(ped, 4, 15, 0, 2)
            end
        else
            SetPedComponentVariation(ped, 4, custom[9], custom[10], 2)
        end

        if custom[11] == -1 then
            SetPedComponentVariation(ped, 8, 15, 0, 2)
        else
            SetPedComponentVariation(ped, 8, custom[11], custom[12], 2)
        end

        if custom[13] == -1 then
            if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
                SetPedComponentVariation(ped, 6, 34, 0, 2)
            elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
                SetPedComponentVariation(ped, 6, 35, 0, 2)
            end
        else
            SetPedComponentVariation(ped, 6, custom[13], custom[14], 2)
        end

        if custom[15] == -1 then
            SetPedComponentVariation(ped, 11, 15, 0, 2)
        else
            SetPedComponentVariation(ped, 11, custom[15], custom[16], 2)
        end

        if custom[17] == -1 then
            SetPedComponentVariation(ped, 9, 0, 0, 2)
        else
            SetPedComponentVariation(ped, 9, custom[17], custom[18], 2)
        end

        if custom[19] == -1 then
            SetPedComponentVariation(ped, 10, 0, 0, 2)
        else
            SetPedComponentVariation(ped, 10, custom[19], custom[20], 2)
        end

        if custom[21] == -1 then
            ClearPedProp(ped, 0)
        else
            SetPedPropIndex(ped, 0, custom[21], custom[22], 2)
        end

        if custom[23] == -1 then
            ClearPedProp(ped, 1)
        else
            SetPedPropIndex(ped, 1, custom[23], custom[24], 2)
        end

        if custom[25] == -1 then
            ClearPedProp(ped, 2)
        else
            SetPedPropIndex(ped, 2, custom[25], custom[26], 2)
        end

        if custom[27] == -1 then
            ClearPedProp(ped, 6)
        else
            SetPedPropIndex(ped, 6, custom[27], custom[28], 2)
        end

        if custom[29] == -1 then
            ClearPedProp(ped, 7)
        else
            SetPedPropIndex(ped, 7, custom[29], custom[30], 2)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updateRoupasPreset")
AddEventHandler("updateRoupasPreset", function(custom)
    skinData = custom
    resetClothing(custom)
    --vSERVER.updateClothes(json.encode(custom))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATESHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local locateShops = {
    { 75.40, -1392.92, 29.37 },
    { -709.40, -153.66, 37.41 },
    { -163.20, -302.03, 39.73 },
    { 425.58, -806.23, 29.49 },
    { -822.34, -1073.49, 11.32 },
    { -1193.81, -768.49, 17.31 },
    { -1450.85, -238.15, 49.81 },
    { 4.90, 6512.47, 31.87 },
    { 1693.95, 4822.67, 42.06 },
    { 126.05, -223.10, 54.55 },
    { 614.26, 2761.91, 42.08 },
    { 1196.74, 2710.21, 38.22 },
    { -3170.18, 1044.54, 20.86 },
    { -1101.46, 2710.57, 19.10 },
    { 461.99, -995.85, 30.68 },
    { 461.89, -999.75, 30.68 },
    { 300.73, -597.31, 43.29 },
    { 1844.91, 2593.87, 45.88 },
    { 1825.88, 3675.0, 34.27 },
    { 1850.19, 3694.66, 34.26 },
    { 443.78, -974.38, 25.7 },
    { -1665.99,185.07,61.76 }, -- DP
    { -1612.41, -1076.52, 13.02 } -- PIER
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN SKINSHOP EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped) and not creatingCharacter then
            local coords = GetEntityCoords(ped)
            for k, v in pairs(locateShops) do
                local distance = #(coords - vector3(v[1], v[2], v[3]))
                if distance <= 2 then
                    timeDistance = 4
                    if IsControlJustPressed(0, 38) then
                        customCamLocation = nil
                        oldData = vRP.getCustomPlayer()
                        openMenu({ { menu = "character", label = "Vestiti", selected = true }, { menu = "accessoires", label = "Utilità", selected = false } })
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)

RegisterCommand("negozio", function(source, args)
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped) and not creatingCharacter then
        if vSERVER.checkPermission() or vSERVER.booster()  then
            customCamLocation = nil
            oldData = vRP.getCustomPlayer()
            openMenu({ { menu = "character", label = "Vestiti", selected = true }, { menu = "accessoires", label = "Utilità", selected = false } })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local innerTable = {}
    for k, v in pairs(locateShops) do
        table.insert(innerTable, { v[1], v[2], v[3], 1, "E", "Negozio di Vestiti", "Apri","Premi" })
    end
    TriggerEvent("hoverfy:insertTable", innerTable)
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    SetTextFont(4)
    SetTextCentre(1)
    SetTextEntry("STRING")
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 150)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text) / 400) + 0.01
    DrawRect(0.0, 0.0125, factor, 0.03, 25, 25, 25, 200)
    ClearDrawOrigin()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("resetOutfit", function()
    TriggerEvent("updateRoupas", oldData)
    oldData = {}
    skinData = json.decode(previousSkinData)
    previousSkinData = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATERIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateRight", function()
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)
    SetEntityHeading(ped, heading + 30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateLeft", function()
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)
    SetEntityHeading(ped, heading - 30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHINGCATEGORYS
-----------------------------------------------------------------------------------------------------------------------------------------
local clothingCategorys = {
    ["arms"] = { type = "variation", id = 3 },
    ["tshirt"] = { type = "variation", id = 8 },
    ["torso"] = { type = "variation", id = 11 },
    ["pants"] = { type = "variation", id = 4 },
    ["vest"] = { type = "variation", id = 9 },
    ["shoes"] = { type = "variation", id = 6 },
    ["mask"] = { type = "mask", id = 1 },
    ["hat"] = { type = "prop", id = 0 },
    ["glass"] = { type = "prop", id = 1 },
    ["ear"] = { type = "prop", id = 2 },
    ["watch"] = { type = "prop", id = 6 },
    ["bracelet"] = { type = "prop", id = 7 },
    ["accessory"] = { type = "variation", id = 7 },
    ["decals"] = { type = "variation", id = 10 },
    ["bag"] = { type = "variation", id = 5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMaxValues()
    maxModelValues = {
        ["arms"] = { type = "character", item = 0, texture = 0 },
        ["tshirt"] = { type = "character", item = 0, texture = 0 },
        ["torso"] = { type = "character", item = 0, texture = 0 },
        ["pants"] = { type = "character", item = 0, texture = 0 },
        ["shoes"] = { type = "character", item = 0, texture = 0 },
        ["vest"] = { type = "character", item = 0, texture = 0 },
        ["accessory"] = { type = "character", item = 0, texture = 0 },
        ["decals"] = { type = "character", item = 0, texture = 0 },
        ["bag"] = { type = "character", item = 0, texture = 0 },
        ["mask"] = { type = "accessoires", item = 0, texture = 0 },
        ["hat"] = { type = "accessoires", item = 0, texture = 0 },
        ["glass"] = { type = "accessoires", item = 0, texture = 0 },
        ["ear"] = { type = "accessoires", item = 0, texture = 0 },
        ["watch"] = { type = "accessoires", item = 0, texture = 0 },
        ["bracelet"] = { type = "accessoires", item = 0, texture = 0 }
    }

    local ped = PlayerPedId()
    for k, v in pairs(clothingCategorys) do
        if v.type == "variation" then
            maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped, v.id) - 1
            maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped, v.id, GetPedDrawableVariation(ped, v.id)) - 1

            if maxModelValues[k].texture <= 0 then
                maxModelValues[k].texture = 0
            end
        end

        if v.type == "mask" then
            maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped, v.id) - 1
            maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped, v.id, GetPedDrawableVariation(ped, v.id)) - 1

            if maxModelValues[k].texture <= 0 then
                maxModelValues[k].texture = 0
            end
        end

        if v.type == "prop" then
            maxModelValues[k].item = GetNumberOfPedPropDrawableVariations(ped, v.id) - 1
            maxModelValues[k].texture = GetNumberOfPedPropTextureVariations(ped, v.id, GetPedPropIndex(ped, v.id)) - 1

            if maxModelValues[k].texture <= 0 then
                maxModelValues[k].texture = 0
            end
        end
    end

    SendNUIMessage({ action = "updateMax", maxValues = maxModelValues })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function openMenu(allowedMenus)
    creatingCharacter = true
    previousSkinData = json.encode(skinData)

    GetMaxValues()

    SendNUIMessage({ action = "open", menus = allowedMenus, currentClothing = skinData })

    SetNuiFocus(true, true)
    SetCursorLocation(0.9, 0.25)

    TaskPlayAnim(PlayerPedId(), "move_f@multiplayer", "idle", 11.0, -1, -1, 3, 0, false, false, false)

    enableCam()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function enableCam()
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)

    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(PlayerPedId()) + 180)
    end

    if customCamLocation ~= nil then
        SetCamCoord(cam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATECAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateCam", function(data)
    local rotType = data.type
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 2.0, 0)

    if rotType == "left" then
        SetEntityHeading(ped, GetEntityHeading(ped) - 10)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(ped) + 180)
    else
        SetEntityHeading(ped, GetEntityHeading(ped) + 10)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(ped) + 180)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setupCam", function(data)
    local value = data.value

    if value == 1 then
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0.75, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.65)
    elseif value == 2 then
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.0, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
    elseif value == 3 then
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.0, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + -0.5)
    else
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function disableCam()
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function closeMenu()
    SendNUIMessage({ action = "close" })
    oldData = {}
    disableCam()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETCLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
function resetClothing(data)
    local ped = PlayerPedId()

    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 2)
    SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 2)
    SetPedComponentVariation(ped, 8, data["tshirt"].item, data["tshirt"].texture, 2)
    SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 2)
    SetPedComponentVariation(ped, 11, data["torso"].item, data["torso"].texture, 2)
    SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 2)
    SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 2)
    SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 2)
    SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 2)
    SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 2)

    if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
        SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, 2)
    else
        ClearPedProp(ped, 0)
    end

    if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
        SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, 2)
    else
        ClearPedProp(ped, 1)
    end

    if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
        SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, 2)
    else
        ClearPedProp(ped, 2)
    end

    if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
        SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, 2)
    else
        ClearPedProp(ped, 6)
    end

    if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
        SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, 2)
    else
        ClearPedProp(ped, 7)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function()
    disableCam()
    SetNuiFocus(false, false)
    creatingCharacter = false
    StopAnimTask(PlayerPedId(), "move_f@multiplayer", "idle", 2.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin", function(data)
    ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKINONINPUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkinOnInput", function(data)
    ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEVARIATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeVariation(data)
    local ped = PlayerPedId()
    local clothingCategory = data.clothingType
    local type = data.type
    local item = data.articleNumber

    if clothingCategory == "pants" then
        if type == "item" then
            SetPedComponentVariation(ped, 4, item, 0, 2)
            skinData["pants"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 4)
            SetPedComponentVariation(ped, 4, curItem, item, 2)
            skinData["pants"].texture = item
        end
    elseif clothingCategory == "arms" then
        if type == "item" then
            SetPedComponentVariation(ped, 3, item, 0, 2)
            skinData["arms"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 3)
            SetPedComponentVariation(ped, 3, curItem, item, 2)
            skinData["arms"].texture = item
        end
    elseif clothingCategory == "tshirt" then
        if type == "item" then
            SetPedComponentVariation(ped, 8, item, 0, 2)
            skinData["tshirt"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 8)
            SetPedComponentVariation(ped, 8, curItem, item, 2)
            skinData["tshirt"].texture = item
        end
    elseif clothingCategory == "vest" then
        if type == "item" then
            SetPedComponentVariation(ped, 9, item, 0, 2)
            skinData["vest"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 9, skinData["vest"].item, item, 2)
            skinData["vest"].texture = item
        end
    elseif clothingCategory == "decals" then
        if type == "item" then
            SetPedComponentVariation(ped, 10, item, 0, 2)
            skinData["decals"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 10, skinData["decals"].item, item, 2)
            skinData["decals"].texture = item
        end
    elseif clothingCategory == "bag" then
        if type == "item" then
            SetPedComponentVariation(ped, 5, item, 0, 2)
            skinData["bag"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 5, skinData["bag"].item, item, 2)
            skinData["bag"].texture = item
        end
    elseif clothingCategory == "accessory" then
        if type == "item" then
            SetPedComponentVariation(ped, 7, item, 0, 2)
            skinData["accessory"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 7, skinData["accessory"].item, item, 2)
            skinData["accessory"].texture = item
        end
    elseif clothingCategory == "torso" then
        if type == "item" then
            SetPedComponentVariation(ped, 11, item, 0, 2)
            skinData["torso"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 11)
            SetPedComponentVariation(ped, 11, curItem, item, 2)
            skinData["torso"].texture = item
        end
    elseif clothingCategory == "shoes" then
        if type == "item" then
            SetPedComponentVariation(ped, 6, item, 0, 2)
            skinData["shoes"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 6)
            SetPedComponentVariation(ped, 6, curItem, item, 2)
            skinData["shoes"].texture = item
        end
    elseif clothingCategory == "mask" then
        if type == "item" then
            SetPedComponentVariation(ped, 1, item, 0, 2)
            skinData["mask"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 1)
            SetPedComponentVariation(ped, 1, curItem, item, 2)
            skinData["mask"].texture = item
        end
    elseif clothingCategory == "hat" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 0, item, skinData["hat"].texture, 2)
            else
                ClearPedProp(ped, 0)
            end
            skinData["hat"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 0, skinData["hat"].item, item, 2)
            skinData["hat"].texture = item
        end
    elseif clothingCategory == "glass" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 1, item, skinData["glass"].texture, 2)
                skinData["glass"].item = item
            else
                ClearPedProp(ped, 1)
            end
        elseif type == "texture" then
            SetPedPropIndex(ped, 1, skinData["glass"].item, item, 2)
            skinData["glass"].texture = item
        end
    elseif clothingCategory == "ear" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 2, item, skinData["ear"].texture, 2)
            else
                ClearPedProp(ped, 2)
            end
            skinData["ear"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 2, skinData["ear"].item, item, 2)
            skinData["ear"].texture = item
        end
    elseif clothingCategory == "watch" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 6, item, skinData["watch"].texture, 2)
            else
                ClearPedProp(ped, 6)
            end
            skinData["watch"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 6, skinData["watch"].item, item, 2)
            skinData["watch"].texture = item
        end
    elseif clothingCategory == "bracelet" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 7, item, skinData["bracelet"].texture, 2)
            else
                ClearPedProp(ped, 7)
            end
            skinData["bracelet"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 7, skinData["bracelet"].item, item, 2)
            skinData["bracelet"].texture = item
        end
    end

    GetMaxValues()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveClothing", function(data)
    SaveSkin()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function SaveSkin()
    oldData = {}
    vSERVER.updateClothes(getCustomization())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESKIN 2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:updateClothes")
AddEventHandler("vrp_skinshop:updateClothes", function()
    vSERVER.updateClothes(getCustomization())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function getCustomization()
    local ped = PlayerPedId()
    local custom = {}

    for i = 0, 20 do
        custom[i] = { GetPedDrawableVariation(ped, i), GetPedTextureVariation(ped, i), GetPedPaletteVariation(ped, i) }
    end

    for i = 0, 10 do
        custom["p" .. i] = { GetPedPropIndex(ped, i), math.max(GetPedPropTextureIndex(ped, i), 0) }
    end
    return custom
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setmascara")
AddEventHandler("vrp_skinshop:setmascara", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP._playAnim(true, { "missfbi4", "takeoff_mask" }, false)
        Wait(1100)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 1, 0, 0, 2)
        TriggerEvent("vrp_clothes:updateClothes", "mask", 0, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(true, { "misscommon@van_put_on_masks", "put_on_mask_ps" }, false)
        Wait(1500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 1, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "mask", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setblusa")
AddEventHandler("vrp_skinshop:setblusa", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 8, 15, 0, 2)
        TriggerEvent("vrp_clothes:updateClothes", "tshirt", 15, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 8, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "tshirt", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 8, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "tshirt", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setcolete")
AddEventHandler("vrp_skinshop:setcolete", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 9, 0, 0, 2)
        TriggerEvent("vrp_clothes:updateClothes", "vest", 0, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 9, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "vest", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 9, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "vest", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setjaqueta")
AddEventHandler("vrp_skinshop:setjaqueta", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(1200)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 11, 15, 0, 2)
        TriggerEvent("vrp_clothes:updateClothes", "torso", 15, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(1200)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 11, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "torso", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(1200)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 11, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "torso", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setmaos")
AddEventHandler("vrp_skinshop:setmaos", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 3, 15, 0, 2)
        TriggerEvent("vrp_clothes:updateClothes", "arms", 15, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 3, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "arms", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(true, { "clothingshirt", "try_shirt_positive_d" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 3, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "arms", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCALCAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setcalcas")
AddEventHandler("vrp_skinshop:setcalcas", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            vRP._playAnim(true, { "clothingtrousers", "try_trousers_neutral_c" }, false)
            Wait(2500)
            ClearPedTasks(ped)
            SetPedComponentVariation(ped, 4, 18, 0, 2)
            TriggerEvent("vrp_clothes:updateClothes", "pants", 18, 0)
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
            vRP._playAnim(true, { "clothingtrousers", "try_trousers_neutral_c" }, false)
            Wait(2500)
            ClearPedTasks(ped)
            SetPedComponentVariation(ped, 4, 15, 0, 2)
            TriggerEvent("vrp_clothes:updateClothes", "pants", 15, 0)
        end
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP._playAnim(true, { "clothingtrousers", "try_trousers_neutral_c" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 4, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "pants", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(true, { "clothingtrousers", "try_trousers_neutral_c" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 4, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "pants", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACESSORIOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setacessorios")
AddEventHandler("vrp_skinshop:setacessorios", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        SetPedComponentVariation(ped, 7, 0, 0, 2)
        TriggerEvent("vrp_clothes:updateClothes", "bracelet", 0, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped, 7, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "bracelet", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped, 7, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "bracelet", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setmochila")
AddEventHandler("vrp_skinshop:setmochila", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP.playAnim(true, { "missmic4", "michael_tux_fidget" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 5, 0, 0, 2)
        TriggerEvent("vrp_clothes:updateClothes", "bag", 0, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP.playAnim(true, { "missmic4", "michael_tux_fidget" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 5, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "bag", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP.playAnim(true, { "missmic4", "michael_tux_fidget" }, false)
        Wait(2500)
        ClearPedTasks(ped)
        SetPedComponentVariation(ped, 5, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "bag", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setsapatos")
AddEventHandler("vrp_skinshop:setsapatos", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            vRP._playAnim(false, { "clothingshoes", "try_shoes_positive_d" }, false)
            Wait(2200)
            SetPedComponentVariation(ped, 6, 34, 0, 2)
            Wait(500)
            ClearPedTasks(ped)
            TriggerEvent("vrp_clothes:updateClothes", "shoes", 34, 0)
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
            vRP._playAnim(false, { "clothingshoes", "try_shoes_positive_d" }, false)
            Wait(2200)
            SetPedComponentVariation(ped, 6, 35, 0, 2)
            Wait(500)
            ClearPedTasks(ped)
            TriggerEvent("vrp_clothes:updateClothes", "shoes", 35, 0)
        end
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP._playAnim(false, { "clothingshoes", "try_shoes_positive_d" }, false)
        Wait(2200)
        SetPedComponentVariation(ped, 6, parseInt(modelo), parseInt(cor), 2)
        Wait(500)
        ClearPedTasks(ped)
        TriggerEvent("vrp_clothes:updateClothes", "shoes", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(false, { "clothingshoes", "try_shoes_positive_d" }, false)
        Wait(2200)
        SetPedComponentVariation(ped, 6, parseInt(modelo), parseInt(cor), 2)
        Wait(500)
        ClearPedTasks(ped)
        TriggerEvent("vrp_clothes:updateClothes", "shoes", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setchapeu")
AddEventHandler("vrp_skinshop:setchapeu", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP._playAnim(true, { "veh@common@fp_helmet@", "take_off_helmet_stand" }, false)
        Wait(700)
        ClearPedProp(ped, 0)
        TriggerEvent("vrp_clothes:updateClothes", "hat", -1, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") and parseInt(modelo) ~= 39 then
        vRP._playAnim(true, { "veh@common@fp_helmet@", "put_on_helmet" }, false)
        Wait(1700)
        SetPedPropIndex(ped, 0, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "hat", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") and parseInt(modelo) ~= 38 then
        vRP._playAnim(true, { "veh@common@fp_helmet@", "put_on_helmet" }, false)
        Wait(1700)
        SetPedPropIndex(ped, 0, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "hat", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setoculos")
AddEventHandler("vrp_skinshop:setoculos", function(modelo, cor)
    local ped = PlayerPedId()
    if not modelo then
        vRP._playAnim(true, { "clothingspecs", "take_off" }, false)
        Wait(500)
        ClearPedTasks(ped)
        ClearPedProp(ped, 1)
        TriggerEvent("vrp_clothes:updateClothes", "glass", 0, 0)
        return
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        vRP._playAnim(true, { "clothingspecs", "take_off" }, false)
        Wait(800)
        ClearPedTasks(ped)
        SetPedPropIndex(ped, 1, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "glass", modelo, cor)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        vRP._playAnim(true, { "clothingspecs", "take_off" }, false)
        Wait(800)
        ClearPedTasks(ped)
        SetPedPropIndex(ped, 1, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "glass", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPULSEIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setpulseira")
AddEventHandler("vrp_skinshop:setpulseira", function(modelo, cor)
    local ped = PlayerPedId()
    if modelo == nil then
        ClearPedProp(ped, 7)
        TriggerEvent("vrp_clothes:updateClothes", "bracelet", 0, 0)
    else
        SetPedPropIndex(ped, 7, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "bracelet", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPULSEIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_skinshop:setrelogio")
AddEventHandler("vrp_skinshop:setrelogio", function(modelo, cor)
    local ped = PlayerPedId()
    if modelo == nil then
        ClearPedProp(ped, 6)
        TriggerEvent("vrp_clothes:updateClothes", "watch", 0, 0)
    else
        SetPedPropIndex(ped, 6, parseInt(modelo), parseInt(cor), 2)
        TriggerEvent("vrp_clothes:updateClothes", "watch", modelo, cor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- updateClothes
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_clothes:updateClothes")
AddEventHandler("vrp_clothes:updateClothes", function(type, modelo, cor)
    if type and modelo then
        skinData[type]["item"] = modelo
    end
    if type and cor then
        skinData[type]["texture"] = cor
    end
    SaveSkin()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getCustomization()
    return skinData
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ppreset", function()
    local chapeu, jaqueta, blusa, mascara, calca, maos, acessorios, sapatos, oculos, mochila, colete = ""
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 then
        chapeu = "cappello " .. (GetPedPropIndex(ped, 0) > 0 and GetPedPropIndex(ped, 0) or "") .. " " .. (GetPedPropTextureIndex(ped, 0) > 0 and GetPedPropTextureIndex(ped, 0) or "")
        oculos = "occhiali " .. (GetPedPropIndex(ped, 1) > 0 and GetPedPropIndex(ped, 1) or "") .. " " .. (GetPedPropTextureIndex(ped, 1) > 0 and GetPedPropTextureIndex(ped, 1) or "")
        mascara = "maschera " .. GetPedDrawableVariation(ped, 1) .. " " .. GetPedTextureVariation(ped, 1)
        maos = "braccia " .. GetPedDrawableVariation(ped, 3) .. " " .. GetPedTextureVariation(ped, 3)
        calca = "pantaloni " .. GetPedDrawableVariation(ped, 4) .. " " .. GetPedTextureVariation(ped, 4)
        mochila = "zaino " .. GetPedDrawableVariation(ped, 5) .. " " .. GetPedTextureVariation(ped, 5)
        sapatos = "scarpe " .. GetPedDrawableVariation(ped, 6) .. " " .. GetPedTextureVariation(ped, 6)
        acessorios = "accessori " .. GetPedDrawableVariation(ped, 7) .. " " .. GetPedTextureVariation(ped, 7)
        blusa = "camicetta " .. GetPedDrawableVariation(ped, 8) .. " " .. GetPedTextureVariation(ped, 8)
        colete = "veste " .. GetPedDrawableVariation(ped, 9) .. " " .. GetPedTextureVariation(ped, 9)
        jaqueta = "giacca " .. GetPedDrawableVariation(ped, 11) .. " " .. GetPedTextureVariation(ped, 11)
        vRP.prompt("Preset:", chapeu .. "; " .. mascara .. "; " .. jaqueta .. "; " .. blusa .. "; " .. maos .. "; " .. calca .. "; " .. sapatos .. "; " .. acessorios .. "; " .. oculos .. "; " .. mochila .. "; " .. colete)
    end
end)

function cRP.updateClothes(tipo,item,textura)
	local ped = PlayerPedId()

	if textura == nil then
		textura = 0
	end
	
	if tipo == "occhiali" then
		SetPedPropIndex(ped, 1, item,textura,2)
	elseif tipo == "cappello" then
		if not item or item == '' then
			SetPedPropIndex(ped, 0, 8,textura,2)
		else
			SetPedPropIndex(ped, 0, item,textura,2)
		end
	elseif tipo == "veste" then
		SetPedComponentVariation(ped, 9,item,textura,2)
	elseif tipo == "accessori" then
		SetPedComponentVariation(ped, 7,item,textura,2)
	elseif tipo == "scarpe" then
		SetPedComponentVariation(ped, 6,item,textura,2)
	elseif tipo == "zaino" then
		SetPedComponentVariation(ped, 5,item,textura,2)
	elseif tipo == "maschera" then
		SetPedComponentVariation(ped, 1,item,textura,2)
	elseif tipo == "giacca" then
		SetPedComponentVariation(ped, 11,item,textura,2)
	elseif tipo == "braccia" then
		SetPedComponentVariation(ped, 3,item,textura,2)
	elseif tipo == "pantaloni" then
		SetPedComponentVariation(ped, 4,item,textura,2)
	elseif tipo == "camicetta" then
		SetPedComponentVariation(ped, 8,item,textura,2)
	elseif tipo == "zaino" then
		SetPedComponentVariation(ped, 5,item,textura,2)
	end
end