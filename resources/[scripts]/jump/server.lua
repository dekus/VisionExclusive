--[[ local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("jump",src)
 ]]
--[[ local allowed =
{
    "steam:11000013f0d19ae",
    "steam:steamhex2",
    "steam:steamhex3",
    "steam:steamhex4"
}
--You can get your steamhex from http://www.vacbanned.com/ and entering your steam id then copying Steam3 ID (64bit) HEX and not DEC
RegisterCommand("jumpscareon", function(source, args)
    -- Usage: /jumpscareon <ID>
    -- Creates a popup on the players screen and starts playing a sound.
    local nuser_id = vRP.getUserId(parseInt(args[1]))
    local nsource = vRP.getUserSource(nuser_id)
    local identifier = GetPlayerIdentifiers(source)
    if vRP.hasPermission(user_id, 'support.autorizzazione') then
      if args[1] == nil then
        print("^1Error, you must provide a player ID.")
	return
      end
      local target = args[1]
      TriggerClientEvent("jumpscare:toggleNUI", nsource, true)
    end
end)

RegisterCommand("jumpscareoff", function(source, args)
    -- Usage: /jumpscareoff <ID>
    -- Removes the popup from the players screen.
    local identifier = GetPlayerIdentifiers(source)[1]
    if checkAllowed(identifier) then
        if args[1] == nil then
            print("^1Error, you must provide a player ID.")
	    return
        end

        local target = args[1]
        TriggerClientEvent("jumpscare:toggleNUI", target, false)
    end
end)

function checkAllowed(id)
    for k, v in pairs(allowed) do
        if id == v then
	    return true
        end
    end
    return false
end
 ]]