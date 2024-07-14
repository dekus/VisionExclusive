local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local vRP = Proxy.getInterface("vRP")

local pizzA = {}
Tunnel.bindInterface("uber",pizzA)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function pizzA.PegarPlaca()
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	return identity.registration
end

local webhookpizza = "https://discord.com/api/webhooks/1130284355483353098/xKCSr6r5XkV-rN6gGTBCfRZ_9RtsrUiHgnGTKho_Ixb4ZuNeKukg1ga1dyNidUgwpfFn"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


function pizzA.x6NiGfpALlLSxRi()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		randmoney = 2000
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"finanziario","Hai ricevuto <b>€ "..vRP.format(parseInt(randmoney)).." dollari</b>.")
		SendWebhookMessage(webhookpizza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[HA VENDUTO LA PIZZA]: € "..randmoney.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		return true
	end
end