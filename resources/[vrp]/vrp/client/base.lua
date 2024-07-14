-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS/PROXY/TOOLS
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
local players = {}
Tunnel.bindInterface("vRP",tvRP)
vRPserver = Tunnel.getInterface("vRP")
Proxy.addInterface("vRP",tvRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUSERID
-----------------------------------------------------------------------------------------------------------------------------------------
local user_id
function tvRP.setUserId(_user_id)
	user_id = _user_id
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERID
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getUserId()
	return user_id
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERHEADING
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getUserHeading()
    return GetEntityHeading(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.teleport(x, y, z)
    SetEntityCoords(PlayerPedId(), x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    vRPserver._updatePos(x, y, z)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.clearWeapons()
    RemoveAllPedWeapons(PlayerPedId(),true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISINSIDE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.isInside()
	local x,y,z = tvRP.getPosition()
	return not (GetInteriorAtCoords(x,y,z) == 0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ function tvRP.getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end
	return x,y,z
end ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.addPlayer(player)
	players[player] = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.removePlayer(player)
	players[player] = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getPlayers()
    return players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getNearestPlayers(radius)
	local r = {}
	local ped = GetPlayerPed(i)
	local pid = PlayerId()
	local px,py,pz = tvRP.getPosition()

	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= pid and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local x,y,z = table.unpack(GetEntityCoords(oped,true))
			local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
			if distance <= radius then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getNearestPlayer(radius)
	local p = nil
	local players = tvRP.getNearestPlayers(radius)
	local min = radius+0.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARANIM
-----------------------------------------------------------------------------------------------------------------------------------------
local animActived = false
local animDict = nil
local animName = nil
local animFlags = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playAnim(upper,seq,looping)
	tvRP.stopAnimActived()

	local ped = PlayerPedId()
	if seq.task then
		tvRP.stopAnim(true)
		if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			TaskStartScenarioAtPosition(ped,seq.task,x,y,z-1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,seq.task,0,not seq.play_exit)
		end
	else
		tvRP.stopAnim(upper)

		local flags = 0

		if upper then
			flags = flags + 48
		end

		if looping then
			flags = flags + 1
		end

		Citizen.CreateThread(function()
			RequestAnimDict(seq[1])
			while not HasAnimDictLoaded(seq[1]) do
				RequestAnimDict(seq[1])
				Citizen.Wait(10)
			end

			if HasAnimDictLoaded(seq[1]) then
				animDict = seq[1]
				animName = seq[2]
				animFlags = flags
				if flags == 49 then
					animActived = true
				end
				TaskPlayAnim(ped,seq[1],seq[2],3.0,3.0,-1,flags,0,0,0,0)
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIMACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopAnimActived()
    animActived = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopAnim(upper)
    anims = {}
    if upper then
        ClearPedSecondaryTask(PlayerPedId())
    else
        ClearPedTasks(PlayerPedId())
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSCREEN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playScreenEffect(name,duration)
	if duration < 0 then
		StartScreenEffect(name,0,true)
	else
		StartScreenEffect(name,0,true)

		Citizen.CreateThread(function()
			Citizen.Wait(math.floor((duration+1)*1000))
			StopScreenEffect(name)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPLAYERSPAWNED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerSpawned",function()
	TriggerServerEvent("vRPcli:playerSpawned")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(1)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Queue:playerActivated")
			return
		end
	end
end)