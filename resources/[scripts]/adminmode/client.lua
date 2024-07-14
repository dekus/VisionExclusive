local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local mrqz = {}
Tunnel.bindInterface("mrqz_adminmode",mrqz)
vSERVER = Tunnel.getInterface("mrqz_adminmode")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local updateam = {}
local adminMode = false
local distancia = 1500 
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('resetdistanzanomi', function(source, args, rawCmd)
    players = {}
    adminMode = false
    TriggerEvent('Notify','successo','<b>Admin Mode</b> Resettato!')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nomidistanza',function(source, args, rawCmd)
    if args[1] then
        distancia = parseInt(args[1])
        if distancia < 15 then TriggerEvent('Notify','negato','la distanza dell\'<b>Admin mode</b> non può essere inferiore a 15 m.') return end
        TriggerEvent('Notify','successo','La distanza dell\' <b>Admin mode</b> cambiato in '..distancia) 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE LIST
-----------------------------------------------------------------------------------------------------------------------------------------
function mrqz.updateList(status)
    updateam = status 
end

CreateThread(function()
    while true do
        Wait(1000)
        if adminMode then
            vSERVER.infos()
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE AM
-----------------------------------------------------------------------------------------------------------------------------------------
function mrqz.adminMode()
    if adminMode then
        adminMode = false
        -- vSERVER.reportLog("DESATIVOU")
        return false
    else
        adminMode = true
        -- vSERVER.reportLog("ATIVOU")
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD AM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 500
        if adminMode then
            timeDistance = 1
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            for k,v in pairs(GetActivePlayers()) do 
                local nsource = GetPlayerServerId(v)
                local target = GetPlayerFromServerId(v)
                local nped = GetPlayerPed(v)
                local ncoords = GetEntityCoords(nped)
                if ped ~= nped then
                    if updateam[nsource] and updateam[nsource] ~= nil and nped and nped ~= nil then
                        if #(coords - ncoords) <= distancia then
                            local data = updateam[nsource]
                            local vida = parseInt(GetEntityHealth(nped) - 100) / 3
                            local isTalking = " "

                            if NetworkIsPlayerTalking(v) then
                                isTalking = "~r~(PARLANDO)"
                            end



                           	if vida <= 1 then
                                if data.job == '' then
									if data.gerente == '' then
										drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~r~(MORTO)")
									else
										drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.gerente.."~b~]\n[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~r~(MORTO)")
									end
								else
									if data.gerente == '' then
										drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.job.."~b~]\n[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~r~(MORTO)")
									else
                           	    		drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.gerente.."~b~] ~w~| ~b~[~w~"..data.job.."~b~]\n[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~r~(MORTO)")
									end
								end
                           	else
								if data.job == '' then
									if data.gerente == '' then
										drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~g~("..parseInt(vida).."%) \n"..isTalking)
									else
										drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.gerente.."~b~]\n[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~g~("..parseInt(vida).."%) \n"..isTalking)
									end
								else
									if data.gerente == '' then
										drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.job.."~b~]\n[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~g~("..parseInt(vida).."%) "..isTalking)
									else
                           	    		drawTxt(ncoords.x,ncoords.y,ncoords.z+0.85,"~b~[~w~"..data.gerente.."~b~] ~w~| ~b~[~w~"..data.job.."~b~]\n[~w~"..data.user_id.."~b~]~w~ "..data.name.." ~g~("..parseInt(vida).."%) "..isTalking)
									end
								end
                           	end
                        end
                    end
                end
            end
        end
        Wait(timeDistance) 
    end
end)

function drawTxt(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.325, 0.325)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropshadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end