local Tunnel = module("vrp", "lib/Tunnel");
local Proxy = module("vrp", "lib/Proxy");
vRP = Proxy.getInterface("vRP");
serverAPI = Tunnel.getInterface("marketplace-Server");

RegisterKeyMapping("marketplace", "Open marketplace", "keyboard", "E")
RegisterCommand("marketplace", function()
	local playerPed = PlayerPedId()
	for k,v in pairs(Config.Market) do
		local distance = #(GetEntityCoords(playerPed) - vec3(v.x, v.y, v.z))
		local inv, list = serverAPI.getMochila(), serverAPI.getAnnouncedItems()
		if inv == {} and list == {} then TriggerClientEvent("Notify",source,"negato","Il Marketplace non è al momento disponibile") end
		if distance <= 3 then
			SetNuiFocus(true, true);
			StartScreenEffect("MenuMGSelectionIn", 0, true);
			SendNUIMessage({ show = true, config = Config.localImages, list = list, inventory = inv });
		end;
	end
end)

CreateThread(function()
	local innerTable = {}
	for k,v in pairs(Config.Market) do
		table.insert(innerTable,{ v.x, v.y, v.z ,3,"E","marketplace","apri","premi" })
	end
	TriggerEvent("hoverfy:insertTable",innerTable)
end)

RegisterNUICallback("comprare", function(data, cb)
	local action = serverAPI.buy(data)
	if action then
		StopScreenEffect("MenuMGSelectionIn");
		SetNuiFocus(false, false);
	end
	cb({success = action})
end);

RegisterNUICallback("vendere", function(data, cb)
	cb({success = true})
	StopScreenEffect("MenuMGSelectionIn");
	SetNuiFocus(false, false);
	serverAPI.announce(data)
end);

RegisterNUICallback("removeFocus", function(_, cb)
	StopScreenEffect("MenuMGSelectionIn");
	SetNuiFocus(false, false);
	cb({success = true})
end);

CreateThread(function()
	local time = 1000
	for k,v in pairs(Config.Market) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Wait(time)
		end
		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)