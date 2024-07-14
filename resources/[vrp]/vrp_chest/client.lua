

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

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vSERVER = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestTimer = 0
local chestOpen = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	StopScreenEffect("MenuMGSelectionIn")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	local ped = PlayerPedId()
	SetNuiFocus(false,false)
	StopScreenEffect("MenuMGSelectionIn")
	SendNUIMessage({ action = "hideMenu" })
	TriggerEvent("vrp_sound:source",'zipperclose',0.2)
	FreezeEntityPosition(ped, false)
	inchest = false
	chestTimer = 5
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
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
        TriggerEvent("Notify","importante","Non puoi prelevare oggetti dall'armeria della polizia.")
        return
    end
	if chestTimer <= 0 then
		chestTimer = 5
		TriggerEvent('cancelando', true)
		vRP.playAnim(false, {"amb@world_human_security_shine_torch@male@exit", "exit"}, false)
		vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
		Wait(1000)
		TriggerEvent('cancelando', false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
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
        TriggerEvent("Notify","importante","Non puoi prelevare oggetti dall'armeria della polizia.")
        return
    end
	if chestTimer <= 0 then
		chestTimer = 5
		TriggerEvent('cancelando', true)
		vRP.playAnim(false,{"mp_common","givetake1_a"},false)
		vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
		Wait(1000)
		TriggerEvent('cancelando', false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateChest")
AddEventHandler("Creative:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vSERVER.openChest(tostring(chestOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	{ "Ballas", 124.42,-1949.79,20.73 },
	{ "Vagos", 371.44,-2040.73,22.2 },
	{ "Grove", -150.35,-1625.63,36.85 },
	{ "Yardie", 1058.67,958.52,240.68}, 
	{ "Siciliana", -1861.03,888.59,165.88 }, 
		
	{ "Bloods", -1113.55,-1647.22,-0.98 },
	{ "Crips", 1286.29,-1705.6,49.93 },
		
	{ "Bahamas", -1366.05,-616.81,30.32 },
	{ "Life Invader",-1062.85,-250.11,44.03 },

	{ "Polizia", -1642.62,159.4,61.76 },
	{ "Hospital",321.35,-570.31,43.32 },
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if chestTimer > 0 then
			chestTimer = chestTimer - 1
		end
		Citizen.Wait(100)
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("chest", 'Apri Baule',"keyboard","E")
RegisterCommand("chest",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then return end
	if IsPedInAnyVehicle(ped, false) then return end
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(chest) do
		local distance = Vdist(x,y,z,v[2],v[3],v[4])
		if distance <= 1.5 and chestTimer <= 0 then
			chestTimer = 3

			if vSERVER.checkIntPermissions(v[1]) then
				TriggerEvent('Notify',"successo",'Chest aperta...')
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				StartScreenEffect("MenuMGSelectionIn", 0, true)
				TriggerEvent("vrp_sound:source","zipperclose",0.2)
				chestOpen = v[1]
				FreezeEntityPosition(ped, true)
			end
		end
	end
end)




Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(chest) do
		table.insert(innerTable,{ v[2],v[3],v[4],1.5,"E","Chest","apri","premi" })
	end
	TriggerEvent("hoverfy:insertTable",innerTable)
end)

RegisterCommand('chestadm',function(source,args)
	if not args[1] then
		return 
	end

	if vSERVER.CheckAdm() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = 'showMenu' })
		StartScreenEffect("MenuMGSelectionIn", 0, true)
		chestOpen = args[1] 
	end
end)