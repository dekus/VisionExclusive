local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local cfg = module("vrp","cfg/groups")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("loginServer", src)
vRP.prepare("login/getUserData", "SELECT * FROM vrp_users WHERE id = @user_id");
vRP.prepare("login/set_last_position", "UPDATE vrp_users SET last_position = @last_position WHERE id = @user_id");
-----------------------------------------------------------------------------------------------------------------------------------------
-- SESSION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.sessionManager(status)
    local source = source
    local user_id = vRP.getUserId(source)
    local spawn = status == 1 and user_id or 0
    SetPlayerRoutingBucket(source, spawn)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.permission()
    local source = source
    local user_id = vRP.getUserId(source)
    local groups = cfg.groups
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
            for _, perms in pairs(kgroup) do
                if perms == "armas.permissao" or perms == "drogas.permissao" or perms == "municao.permissao" then
                    return "ilegal"
                elseif perms == "polizia.permissao" or perms == "paisanapolizia.permissao" or perms == "poliziaazione.permissao" then
                    return "polizia"
                end          
            end
		end
	end
	return nil
end

function src.getLastLocation()
    local source = source
    local user_id = vRP.getUserId(source)
    local query = vRP.query("login/getUserData", {user_id = user_id})
    local position = json.decode(query[1].last_position)
    return position
end

AddEventHandler("vRP:playerLeave", function(user_id, source)
    local position = GetEntityCoords(GetPlayerPed(source));
	vRP.execute("login/set_last_position", {user_id = user_id, last_position = json.encode(position)})
end);

