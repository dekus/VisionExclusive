local peds = {
	{ ['x'] = 308.28, ['y'] = -595.42, ['z'] = 43.3, ['h'] = 5.75, ['hash2'] = "s_m_m_scientist_01" }, --bende HP
	{ ['x'] = 326.38, ['y'] = -1073.2, ['z'] = 29.48, ['h'] = 3.7949631214142, ['hash2'] = "mp_m_boatstaff_01" }, --ADRENALINA HP
	{ ['x'] = 82.18, ['y'] = -1615.45, ['z'] = 29.6, ['h'] = 230.64, ['hash2'] = "s_m_y_factory_01" }, --ADRENALINA HP
	{ ['x'] = -238.94, ['y'] = -1397.84, ['z'] = 31.29, ['h'] = 284.25, ['hash2'] = "s_m_o_busker_01" }, --TAXI
	{ ['x'] = 453.69, ['y'] = -600.48, ['z'] = 28.6, ['h'] = 277.20, ['hash2'] = "ig_manuel" }, --AUTOBUS
	{ ['x'] = -1601.7, ['y'] = 206.63, ['z'] = 59.29, ['h'] = 116.19, ['hash2'] = "s_f_y_cop_01" }, --POLIZIA
	{ ['x'] = 216.0, ['y'] = -1389.86, ['z'] = 30.59, ['h'] = 322.13, ['hash2'] = "a_m_y_downtown_01" }, --swpan bici
	
}


local fixedPeds = {}

CreateThread(function()
	while true do
		local gomesh = 1000
		for k,v in pairs(peds) do
			local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.x,v.y,v.z))
			if distance <= 30 then
				if not fixedPeds[k] then
					RequestModel(GetHashKey(v.hash2))
					while not HasModelLoaded(GetHashKey(v.hash2)) do
						Citizen.Wait(gomesh)
					end

					ped = CreatePed(4,GetHashKey(v.hash2),v.x,v.y,v.z-1,v.h,false,true)
					FreezeEntityPosition(ped,true)
					SetEntityInvincible(ped,true)
					SetEntityCollision(ped,true)
					SetBlockingOfNonTemporaryEvents(ped,true)
					fixedPeds[k] = ped

				end
			else
				if fixedPeds[k] then
					DeleteEntity(ped)
					fixedPeds[k] = nil
				end
			end

		end
		Wait(gomesh)
	end
end)