local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")

local cfg = module("vrp","cfg/groups")
local groups = cfg.groups

local src = {}
Tunnel.bindInterface("identity",src)


function src.getIdentity()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local Banca = vRP.getBankMoney(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local job = Groups:getUserGroupByType(user_id,"Emprego")
		local jobdois = Groups:getUserGroupByType(user_id,"Emprego2")
		local staff = Groups:getUserGroupByType(user_id,"Staff")
		local vip = Groups:getUserGroupByType(user_id,"Vip")
		if identity then
			return vRP.format(parseInt(cash)),vRP.format(parseInt(Banca)),identity.name..' '..identity.firstname,identity.age,identity.user_id,identity.registration,identity.phone,job,jobdois,staff,vip
		end
	end
end

Groups.getUserGroupByType = function(self,user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype then
				if not self[gtype] and (kgroup._config.gtype == gtype) or (kgroup._config.gtype == self[gtype]) then
					return kgroup._config.title
				end
			end
		end
	end
	return ""
end