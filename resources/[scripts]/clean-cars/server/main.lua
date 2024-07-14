local Tunnel = module("vrp", "lib/Tunnel");
vGARAGE = Tunnel.getInterface("vrp_garages");
vCLIENT = Tunnel.getInterface("ccars");
local time = 1000;
local delay = time;
CreateThread(function()
	while true do
		local cooldown = 1500;
		if delay > 0 then
			delay = delay - 1;
		end;
		if delay == 61 then
			TriggerClientEvent("Notify", -1, "importante", "Tutti i veicoli abbandonati verranno eliminati in <b>1 minuto.</b>");
		end;
		local vehicles = {};
		for k, v in pairs(GetAllVehicles()) do
			table.insert(vehicles, {
				veh = v
			});
		end;
		for k, v in pairs(vehicles) do
			if delay == 0 then
				if InsideTheCar(v.veh) then
					vGARAGE.tryDelete(v.veh, GetVehicleEngineHealth(v.veh), GetVehicleBodyHealth(v.veh));
				end;
			end;
		end;
		if delay == 0 then
			TriggerClientEvent("Notify", -1, "avviso", "Tutti i veicoli abbandonati sono stati <b>eliminati.</b>");
			delay = time;
		end;
		Wait(cooldown);
	end; 
end);

function InsideTheCar(vehicle)
	for i=-2, 8 do
		if GetPedInVehicleSeat(vehicle, i) > 0 then
			return false;
		end
	end
	return true;
end