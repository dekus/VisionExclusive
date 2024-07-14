local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

srr = {}
Tunnel.bindInterface(GetCurrentResourceName(), srr)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local fixedPeds = {}

CreateThread(function()
    while true do
        local sleep = 1000
        for k,v in pairs(Config.SellDrugs) do
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.x,v.y,v.z))
            if distance <= 30 then
                if not fixedPeds[k] then
                    RequestModel(v.hashped)
                    while not HasModelLoaded(v.hashped) do
                        Wait(1)
                    end
                    ped = CreatePed(4,v.hashped,v.x,v.y,v.z-1,v.h,false,false)
                    FreezeEntityPosition(ped,true)
                    SetEntityInvincible(ped,true)
                    SetBlockingOfNonTemporaryEvents(ped,true)
                    fixedPeds[k] = ped
                else
                    if distance <= 4 then
                        sleep = 4
                        DrawText3D(v.x,v.y,v.z,"~p~E~w~   APRIRE")
                        if IsControlJustPressed(0,38) then
                            vSERVER.sellDrugs(k,v)
                        end
                    end
                end
            else 
                if fixedPeds[k] then
                    DeletePed(ped)
                    fixedPeds[k] = false
                end
            end
        end
        Wait(sleep)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,40,36,52,240)
	ClearDrawOrigin()
end
