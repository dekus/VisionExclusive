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
Tunnel.bindInterface('lavagemfac',src)
vSERVER = Tunnel.getInterface('lavagemfac')
-----------------------------------------------------------------------------------------------------------------------------------------
-- LAVAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['x'] = -1365.24, ['y'] = -623.5, ['z'] = 29.33, ['h'] = 38.14, ['perm'] = 'bahamas.autorizzazione' },
	{ ['x'] = -1056.88, ['y'] = -233.16, ['z'] = 43.03, ['h'] = 311.14, ['perm'] = 'life.autorizzazione' }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(locais) do
			local distance = Vdist(x,y,z,v['x'],v['y'],v['z'])
			if distance <= 10 then
				timeDistance = 4
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						vSERVER.lavar(v['perm'],v['x'],v['y'],v['z'],v['h'])
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)


CreateThread(function()
	local innerTable = {}
	for k,v in pairs(locais) do
		table.insert(innerTable,{ v.x,v.y,v.z,1.5,"E","riciclaggio di denaro","apri","premi" })
	end
	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.TravarPed(status)
	FreezeEntityPosition(PlayerPedId(), status)
end

function src.setHeading(x, y, z, h)
	local ped = PlayerPedId()
	SetEntityCoords(ped,x,y,z)
	SetEntityHeading(ped,h)
end

RegisterCommand('az', function()
	vSERVER.lavar(-1365.26,-623.54,28.33,38.14)
end)