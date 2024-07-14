local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP_Server = {}
Tunnel.bindInterface("vrp_codes", vRP_Server)

function vRP_Server.CheckPermessi(perm)
    local source = source
    local user_id = vRP.getUserId(source)

    return vRP.hasPermission(user_id, perm)
end