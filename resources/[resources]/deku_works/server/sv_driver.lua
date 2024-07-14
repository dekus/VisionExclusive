-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local driveR = {}
Tunnel.bindInterface("vrp_driver",driveR)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookmotorista = "https://discord.com/api/webhooks/1130283478320160869/TjiG_Mw2yMN4LU3K_E3LjobrKTwAGZ2ZFbxoVIpOOvbqWoTqgqBRTX74CwDX39v4voAk"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local Delayre = {}

function driveR.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(status,bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local value = 1400

		if Delayre[user_id] == nil then
			Delayre[user_id] = 0;
		end

		if Delayre[user_id] > 0 then
			vRP.kick(source,"Sei stato bannato!")
			vRP.setBanned(user_id,true)
			SendWebhookMessage('https://discord.com/api/webhooks/1130283478320160869/TjiG_Mw2yMN4LU3K_E3LjobrKTwAGZ2ZFbxoVIpOOvbqWoTqgqBRTX74CwDX39v4voAk',"```ini\n[ID]: "..user_id.." "..identity["name"].." "..identity["firstname"].."\n[GANHOU]: € "..vRP.format(parseInt(value)).."\nPRENDE SOLDI DALL'HACK SULL'IMPIEGO IN AUTOBUS\nTEMPO: "..os.date("%H:%M:%S").."\n```")
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
		
		TriggerClientEvent("Notify",source,"finanziario","Hai ricevuto <b>€ "..vRP.format(parseInt(value)).."</b>")
		SendWebhookMessage(webhookmotorista,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[VOGLIO AUTISTA]: € "..value.." "..os.date("\n[Data]: %d/%m/%Y [Tempo]: %H:%M:%S").." \r```")
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