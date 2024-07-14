local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("dnotify",src)
vCLIENT = Tunnel.getInterface("dnotify")

RegisterCommand('dnotify',function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'support.autorizzazione') then
		vCLIENT.dN(source)
    end
end)

notidead = false

local LogKill = ''

function synterinho(corzinha, titulopika, logfull)
    local synter = {
      {
        ["color"] = corzinha,
        ["title"] = titulopika,
        ["description"] = logfull,
        ["footer"] = {
            ["text"] = marcadagua,
            ["icon_url"] = img,
        },
      }
  	}
	PerformHttpRequest(LogKill, function(err, text, headers) end, 'POST', json.encode({avatar_url = img, username = marcadagua, embeds = synter}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('src:KLog')
AddEventHandler('src:KLog',function(nplayer, armaUsada)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
  local x, y, z = vRPclient.getPosition(source)
	if nplayer ~= 0 then
		local nuser_id = vRP.getUserId(nplayer);
		local identity2 = vRP.getUserIdentity(nuser_id)
		if identity and identity2 then
			local nomeAlvo = identity.name
			local nomeAssassino = identity2.name
			for k, v in pairs(vRP.getUsersByPermission('support.autorizzazione')) do
				async(function()
					local player = vRP.getUserSource(v)
					TriggerClientEvent("NotifyKill",player, {weapon_killer = armaUsada, killer_name = nomeAssassino, killer_id = nuser_id, victim_name = nomeAlvo, victim_id = user_id})
				end)
			end
      synterinho(3553599,"🔫 LOG DE KILL", "> **__QUEM MATOU:__** \n```yaml\n"..nuser_id.." " .. identity2.name .. "```\n> **__QUEM MORREU:__** \n```yaml\n"..user_id.." "..identity.name.."```\n> **__ARMA:__** \n```yaml\n "..armaUsada.." ```\n> **__COORDENADAS:__** \n```yaml\n " .. mathLegth(x) .. "," .. mathLegth(y) .. "," .. mathLegth(z) .. "  "..'```')
		end
	end
end)

function mathLegth(n)
    n = math.ceil(n * 100) / 100
    return n
end