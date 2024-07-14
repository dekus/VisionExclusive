local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local bende = {
    {308.1,-595.15,43.3},
}

local adrenalina = {
    {305.03,-596.0,43.3},
}

local shop = {
    {961.74,-194.04,73.24},
}

Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        for k,v in pairs(bende) do
            local distance = Vdist(x,y,z,v[1],v[2],v[3])
            if distance <= 10 then
                timeDistance = 4
                if distance <= 1.2 then
                    if IsControlJustPressed(0,38) then
                        vSERVER.bende()
                        end
                    end
                end
            end
        Citizen.Wait(timeDistance)
    end
end)

Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        for k,v in pairs(shop) do
            local distance = Vdist(x,y,z,v[1],v[2],v[3])
            if distance <= 10 then
                timeDistance = 4
                if distance <= 1.2 then
                    if IsControlJustPressed(0,38) then
                        vSERVER.shop()
                        end
                    end
                end
            end
        Citizen.Wait(timeDistance)
    end
end)

Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        for k,v in pairs(adrenalina) do
            local distance = Vdist(x,y,z,v[1],v[2],v[3])
            if distance <= 10 then
                timeDistance = 4
                if distance <= 1.2 then
                    if IsControlJustPressed(0,38) then
                        vSERVER.adrenalina()
                        end
                    end
                end
            end
        Citizen.Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(adrenalina) do
		table.insert(innerTable,{ v[1],v[2],v[3],2,"E","Adrenalina","Comprare","Premi" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(bende) do
		table.insert(innerTable,{ v[1],v[2],v[3],2,"E","Bende","Comprare","Premi" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)

function src.buyarmas()
    vSERVER.armas()
end