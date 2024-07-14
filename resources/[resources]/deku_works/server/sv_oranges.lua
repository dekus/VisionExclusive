local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP")

local orangeA = {}
Tunnel.bindInterface("works_orange", orangeA)

local webhooklaranja = "https://discord.com/api/webhooks/1130284155335352320/DJWBp8YgmlIORISqS76XpGgM1RLc61u20nrDhZef-OrcwLPVo7B7cp5yP6lhj5U9zDmB"
local webhooklaranjahack = "https://discord.com/api/webhooks/1130284155335352320/DJWBp8YgmlIORISqS76XpGgM1RLc61u20nrDhZef-OrcwLPVo7B7cp5yP6lhj5U9zDmB"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local Delayre = {}

function orangeA.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(status)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local valuePerOrange = 300
		local sellQtd = math.random(1,3)

		local value = parseInt(sellQtd * valuePerOrange)

		if Delayre[user_id] == nil then
			Delayre[user_id] = 0;
		end

		if Delayre[user_id] > 0 then
			vRP.kick(source,"Sei stato bannato!")
			vRP.setBanned(user_id,true)
			SendWebhookMessage(webhooklaranjahack,"```ini\n[ID]: "..user_id.." "..identity["name"].." "..identity["firstname"].."\n[HA RICEVUTO]: € "..vRP.format(parseInt(value)).."\nSTA GUADAGNANDO SOLDI ATTRAVERSO L'HACK NEL LAVORO DI VENDITA DI ARANCIO\nTEMPO:"..os.date("%H:%M:%S").."\n```")
			return;
		end
		if vRP.getInventoryItemAmount(user_id, "arance") >= sellQtd then
			if vRP.tryGetInventoryItem(user_id, "arance", sellQtd) then
				Delayre[user_id] = 2
				TriggerClientEvent("Notify",source,"finanziario","Hai ricevuto <b>€ "..vRP.format(parseInt(value)).."</b>")
				SendWebhookMessage(webhooklaranja,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[HA VENDUTO "..sellQtd.." ARANCE]: € "..value.." "..os.date("\n[Data]: %d/%m/%Y [Tempo]: %H:%M:%S").." \r```")
				TriggerClientEvent("vrp_sound:source",source,"coins",0.5)
			end
		else
			TriggerClientEvent("Notify",source,"negato","Tu non hai <b>"..vRP.format(parseInt(sellQtd)).." arance</b>")
		end
	end
end

Citizen.CreateThread(function()
  while true do
    for k,v in pairs(Delayre) do
      if v > 0 then
        Delayre[k] = v - 1
      end
    end
    Citizen.Wait(1000)
  end
end)

function orangeA.Collect()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local orangeCount = math.random(1,3)
		if parseInt(vRP.getInventoryWeight(user_id) + parseInt(vRP.getItemWeight("arance") * orangeCount)) < vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id, "arance", parseInt(orangeCount))
		else
			TriggerClientEvent("Notify", source, "negato", "Non hai più <b>spazio</b> nello zaino!") 
		end
	end
end