
_RegisterCommand = RegisterCommand
function RegisterCommand(command, callback)
    _RegisterCommand(command, function(...)
        if not LocalPlayer.state.inRoyale then
            return callback(...)
        end
    end)
end

_IsControlJustPressed = IsControlJustPressed
function IsControlJustPressed(...)
    if LocalPlayer.state.inRoyale then
        return false
    else
        return _IsControlJustPressed(...)
    end
end

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_inventory")

client = {}
Tunnel.bindInterface("vrp_inventory_client",client)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end)

function client.FecharInventario()
    StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APRIRE INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("inv","Aprire Inventario","keyboard","F2")

RegisterCommand('inv',function(source,args)
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
        if not invOpen then
            StartScreenEffect("MenuMGSelectionIn", 0, true)
            invOpen = true
            SetNuiFocus(true,true)
            SendNUIMessage({ 
                action = "showMenu",
            })
        else
            StopScreenEffect("MenuMGSelectionIn")
            SetNuiFocus(false,false)
            SendNUIMessage({ action = "hideMenu" })
            invOpen = false
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR FAZENDO ANIMACAO
-----------------------------------------------------------------------------------------------------------------------------------------
function client.EstiverFazendoAnimacao(zoio, tandera)
    local ped = PlayerPedId()
    if IsEntityPlayingAnim(ped, zoio, tandera, 3) then 
        return true  
    else 
        return false 
    end
end
RegisterNetEvent('barney:TravarPed')
AddEventHandler('barney:TravarPed', function(status)
	FreezeEntityPosition(PlayerPedId(), status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
    client.FecharInventario()
	vRPNserver.dropItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
    if data.item == "test" or
        data.item == "wbody|WEAPON_STUNGUN" or
        data.item == "wbody|WEAPON_FLASHLIGHT" or
        data.item == "wbody|WEAPON_NIGHTSTICK" or
        data.item == "wbody|WEAPON_COMBATPISTOL" or
        data.item == "wbody|WEAPON_HEAVYPISTOL" or
        data.item == "wbody|WEAPON_COMBATPDW" or
        data.item == "wbody|WEAPON_CARBINERIFLE" or
        data.item == "wbody|WEAPON_CARBINERIFLE_MK2" or
        data.item == "wbody|WEAPON_SMG" or
        data.item == "wammo|WEAPON_COMBATPISTOL" or
        data.item == "wammo|WEAPON_HEAVYPISTOL" or
        data.item == "wammo|WEAPON_COMBATPDW" or
        data.item == "wammo|WEAPON_CARBINERIFLE" or
        data.item == "wammo|WEAPON_CARBINERIFLE_MK2" and
        data.item == "wammo|WEAPON_SMG" then
        TriggerEvent("Notify","importante","Non puoi inviare item dell'armeria della polizia.")
        return
    end

    StopScreenEffect("MenuMGSelectionIn")
    SetNuiFocus(false,false)
    SendNUIMessage({ action = "hideMenu" })
    invOpen = false

    TriggerEvent("nfesx_targeting:beginTargeting", function(plyId)

        vRPNserver.sendItem(plyId, data.item, data.amount)

    end, 5)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	vRPNserver.useItem(data.item,data.type,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('requestMochila', function(data, cb)
    local inventario, weight, maxWeight = vRPNserver.Mochila()
    if inventario then
        cb({ inventario = inventario, weight = weight, maxWeight = maxWeight })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_inventory:Update')
AddEventHandler('vrp_inventory:Update', function(action)
    SendNUIMessage({ action = 'updateMochila' })
end)