local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("loginServer")
vCONFIGS = Tunnel.getInterface("loginConfigS")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = nil
-- local sceneCoords = vector3(-2822.91,1423.31,100.82)
local sceneCoords = vec3(-2822.85,1423.65,100.82)
local camera = nil
local cameratwo = nil

local femaleAnimList = {
    { "anim@mp_player_intcelebrationfemale@shooting", "shooting", true },
}
local maleAnimList = {
    { "anim@amb@nightclub@mini@dance@dance_paired@dance_j@", "ped_a_dance_idle", true },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function removeCamActive()
    if camera and cameratwo then
        SetCamCoord(camera, GetGameplayCamCoords())
        SetCamRot(camera, GetGameplayCamRot(2), 2)
        SetCamCoord(cameratwo, GetGameplayCamCoords())
        SetCamRot(cameratwo, GetGameplayCamRot(2), 2)
        RenderScriptCams(0, 0, 0, 0, 0)
        EnableGameplayCam(true)
        SetCamActive(camera, false)
        SetCamActive(cameratwo, false)
        DestroyCam(camera, true)
        DestroyCam(cameratwo, true)
        DestroyAllCams(true)
		ClearPedTasksImmediately(PlayerId())
        SetFocusEntity(PlayerPedId())
        camera,cameratwo = nil, nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLELOGIN
-----------------------------------------------------------------------------------------------------------------------------------------


RegisterNetEvent("vrp:ToogleLoginMenu")
AddEventHandler("vrp:ToogleLoginMenu",function(status)
	local ped = PlayerPedId()
	vSERVER.sessionManager(1)
	StartPlayerTeleport(PlayerId(),sceneCoords["x"],sceneCoords["y"],sceneCoords["z"],77.02,0,1,0)
    camera  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -2828.46,1424.45,100.72, 0.00, 0.0, -135.0, 35.0, true, 2)
    cameratwo = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -2825.64,1424.37,100.72, 10.0, 0.0, -105.0, 35.0, true, 2)
    RenderScriptCams(1, 1, 0, 0, 0)
    Wait(0)
    SetFocusPosAndVel(GetCamCoord(camera), 0.0, 0.0, 0.0)
    SetCamActiveWithInterp(cameratwo, camera, 5000, 1, 1)
    Wait(0)
    SetEntityVisible(PlayerPedId(),true,true)
    SetFocusPosAndVel(GetCamCoord(cameratwo), 0.0, 0.0, 0.0)
    Wait(5000)
    if GetEntityModel(ped) == `mp_f_freemode_01` then
        local randomAnim = math.random(#femaleAnimList)
        vRP.playAnim(false, { femaleAnimList[randomAnim][1], femaleAnimList[randomAnim][2] }, femaleAnimList[randomAnim][3])
        SetEntityHeading(ped, 140.02)
    else
        local randomAnim = math.random(#maleAnimList)
        vRP.playAnim(false, { maleAnimList[randomAnim][1], maleAnimList[randomAnim][2] }, maleAnimList[randomAnim][3])
        SetEntityHeading(ped, 140.02)
    end
    FreezeEntityPosition(ped, false)
	SetNuiFocus(true,true)
	SendNUIMessage({ open = true, permission = vSERVER.permission(), locations = ClientCFG.locations})
	TriggerEvent("ToogleBackCharacter")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawn",function(data,cb)
	local ped = PlayerPedId()
    if data.coords == "ult" then
        local lastCoords = vSERVER.getLastLocation()
        coords = {lastCoords.x, lastCoords.y, lastCoords.z}
    else
        coords = data and (data.name == "base" and vCONFIGS.getCoords() or data.coords) or nil
    end
    if coords then
        cb({ success = "close" })
        SetNuiFocus(false,false)
        removeCamActive()
        SwitchOutPlayer(ped, 0, 1)
        CreateThread(function()
            while true do
                local isSwitch = N_0x933bbeeb8c61b5f4()
                if isSwitch then
                    SetEntityCoords(ped,coords[1],coords[2],coords[3])
                    SwitchInPlayer(ped)
                    vSERVER.sessionManager(2)
                    break
                end
                Citizen.Wait(1)
            end
        end)
    end
end)

RegisterCommand("relog", function()
    TriggerEvent("vrp:ToogleLoginMenu")
end, false)

