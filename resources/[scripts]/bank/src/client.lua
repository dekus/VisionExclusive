local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local mrqz = {}
Tunnel.bindInterface(GetCurrentResourceName(),mrqz)
vSv = Tunnel.getInterface(GetCurrentResourceName())

local onNui = false
CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped) then
            local x, y, z = table.unpack(GetEntityCoords(ped))
			for k,v in ipairs(Config['locaisBanca']) do
            	local distance = Vdist(x, y, z, v[1],v[2],v[3])
            	if distance <= 4.0 then
            	    sleep = 1
                    if not onNui then
					    DrawText3D(v[1],v[2],v[3], Config['openMessage'])
                    end
            	    if distance <= 1.5 then
            	        sleep = 1
            	        if IsControlJustPressed(1, 38) then
							mrqz.openUi(Config['ui'])
            	        end
            	    end
            	end
			end
        end
        Wait(sleep)
    end
end)


AddEventHandler("onResourceStart", function(resName)
	Wait(1000)
	if GetCurrentResourceName() ~= resName then
		return
	end
    vSv.getInfos();
end)

function mrqz.openUi(dataC)
    vSv.getInfos()
    SetTimeout(10, function()
        onNui = true
	    SendNUIMessage({show = true, serverName = Config['bankName'], name = LocalPlayer['state']["information"]['name'], balance = LocalPlayer['state']["information"]['bank'], config = dataC})
	    StartScreenEffect("MenuMGSelectionIn", 0, true)
	    SetNuiFocus(true, true)
    end)
end

RegisterNUICallback('updateInfos', function(data, cb)
    vSv.getInfos()
    SetTimeout(5, function()
	    cb({value = LocalPlayer['state']["information"]['name']})
    end)
end)  

RegisterNUICallback('saque', function(data, cb)
    if data.valor then
        cb(vSv.withdraw(data.valor))
    end
end)

RegisterNUICallback('deposito', function(data, cb)
    if data.valor then
        cb(vSv.deposit(data.valor))
    end
end)

RegisterNUICallback('fast', function(data,cb)
    cb(vSv.withdraw(data.valor))
end)

RegisterNUICallback('removeFocus', function()
    onNui = false
	StopScreenEffect("MenuMGSelectionIn")
    SetNuiFocus(false, false)
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.325, 0.325)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03,0,0,0,68)
end