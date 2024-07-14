local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vServer = {}
Tunnel.bindInterface("rankingServer",vServer)

vRP.prepare('mrqz/getGangsRank','SELECT * FROM ranking')
vRP.prepare('mrqz/updateGangsRank','UPDATE ranking SET actions=@actions WHERE gang=@gang')
vRP.prepare('mrqz/createGangsRank','INSERT INTO ranking(gang,actions) VALUES(@gang,@actions)')

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    local query = vRP.query('mrqz/getGangsRank')
    if #query <= 0 then
        for i=1,#Config.Gangs do
            vRP.execute("mrqz/createGangsRank", { gang = Config.Gangs[i], actions = 0 })
        end
    end
end)

AddEventHandler("ranking:update", function(gang)
    if gang ~= "" then
        local queryGet = vRP.query("mrqz/getGangsRank")
        for k,v in pairs(queryGet) do
            if v.gang == gang then
                vRP.execute('mrqz/updateGangsRank', { actions = v.actions + 1, gang = gang })
            end
        end
    end
end)

vServer.getRanks = function()
    local query = vRP.query('mrqz/getGangsRank')
    local tableGangs = {}
    for k,v in pairs(query) do 
        table.insert(tableGangs,{ name = v.gang, actions = v.actions })
    end
    return tableGangs
end