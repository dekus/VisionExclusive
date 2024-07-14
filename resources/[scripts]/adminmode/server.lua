local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local mrqz = {}
Tunnel.bindInterface("mrqz_adminmode",mrqz)
vCLIENT = Tunnel.getInterface("mrqz_adminmode")
local cfg = module("vrp","cfg/groups")
local groups = cfg.groups

local webhookadminmode = "https://discord.com/api/webhooks/1130285438498783282/9I4JmjPS3nM-5b3Z2Px2bWA3tH6J8JxRp9eiB77A40zg4J3ZMarzSNJF33HZPQk2nYS4"

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function mrqz.getUserGroupByType(user_id,gtype)
    local user_groups = vRP.getUserGroups(user_id)
    for k,v in pairs(user_groups) do
        local kgroup = groups[k]
        if kgroup then
            if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
                return kgroup._config.title
            end
        end
    end
    return ""
end

--[[ function mrqz.reportLog(status)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    SendWebhookMessage(webhookadminmode,"```prolog\n[ID]: "..user_id.." | "..identity.name.."\n["..status.." O MODO ADMIN]"..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S```").." \r")
end ]]

RegisterCommand('nomi',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id,"support.autorizzazione") then
            vCLIENT.adminMode(source)
            local users = {}
            local Players = vRP.getUsers()
            for k,v in pairs(Players) do
                local identity, gerente, job = vRP.getUserIdentity(k), mrqz.getUserGroupByType(k,"gerente"), mrqz.getUserGroupByType(k,"job")
                users[v] = { name = identity.name..' '..identity.firstname, user_id = k, job = job, gerente = gerente }
            end
            vCLIENT.updateList(source,users)
        end
    end
end)

function mrqz.infos()
    local source = source
    local users = {}
    local Players = vRP.getUsers()
    for k,v in pairs(Players) do
        local identity, gerente, job = vRP.getUserIdentity(k), mrqz.getUserGroupByType(k,"gerente"), mrqz.getUserGroupByType(k,"job")
        users[v] = { name = identity.name..' '..identity.firstname, user_id = k, job = job, gerente = gerente }
    end
    vCLIENT.updateList(source,users)
end