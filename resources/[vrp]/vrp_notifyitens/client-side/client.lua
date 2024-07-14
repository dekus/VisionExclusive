RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify", function(type, amount, name, item)
	local newitem = string.sub(item, 1, 6) 
	if newitem == k then
		item = v['index']
	elseif newitem == "wammo|" then
		item = 'wammo|'..item:sub(7)..''
	end

	if item == "wbody|WEAPON_STUNGUN" then
		item = "taser"
	end
	SendNUIMessage({ type = type, amount = amount, name = name, image = item })
end)