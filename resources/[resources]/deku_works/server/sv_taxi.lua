-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local taxi = {}
Tunnel.bindInterface("vrp_taxi",taxi)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooktaxista = "https://discord.com/api/webhooks/1130284540091441153/FD2kQVsfUde56gYSWrJGtNdiz2JxodTb5KKDK4l4bLeRTdgBs1P1a8sRXSl8MnjIUo4s"
local webhooktaxistahack = "https://discord.com/api/webhooks/1130284540091441153/FD2kQVsfUde56gYSWrJGtNdiz2JxodTb5KKDK4l4bLeRTdgBs1P1a8sRXSl8MnjIUo4s"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
local Delayre = {}
function taxi.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(status,bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local value = 1500

		if Delayre[user_id] == nil then
			Delayre[user_id] = 0;
		end

		if Delayre[user_id] > 0 then
			vRP.kick(source,"Sei stato bannato!")
			vRP.setBanned(user_id,true)
			SendWebhookMessage(webhooktaxistahack,"```ini\n[PASSAPORTO]: "..user_id.." "..identity["name"].." "..identity["firstname"].."\n[Guadagnato]: € "..vRP.format(parseInt(value)).."\nESTA PUXANDO DINHEIRO PELO HACK NO EMPREGO DE TAXI\nHORÁRIO: "..os.date("%H:%M:%S").."\n```")
			return;
		end

		Delayre[user_id] = 2

		if not status then
			vRP.giveMoney(user_id,value)
			TriggerEvent('pass:mission',source,'EMPREGO')
		else
			vRP.giveMoney(user_id,value)
			TriggerEvent('pass:mission',source,'EMPREGO')
		end
		
		TriggerClientEvent("Notify",source,"finanziario","Hai ricevuto <b>$ "..vRP.format(parseInt(value)).." dollari</b>")
		SendWebhookMessage(webhooktaxista,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Guadagnato nel taxi]: € "..value.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
		TriggerClientEvent("vrp_sound:source",source,"coins",0.5)
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