local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


local radiojoin = "https://discord.com/api/webhooks/1135607511467175958/1BIPtecgXcn_rlrwMK_eJg7ZSaweMahDERAvvb0Qywo6yozgA2vSfmSfy9lbeQpOK4gD"
local radioleft = "https://discord.com/api/webhooks/1135607549689872396/QbBcrm0J9yRPAWal4H1P4ShcpxaVURWSLFpUBFeRbPYFH_WHe-LrIsk5y7Mky_um5a6P"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


local radioChecks = {}

function canJoinChannel(source,radioChannel)
	if radioChecks[radioChannel] then
		return radioChecks[radioChannel](source)
	end

	return true
end

function addChannelCheck(channel,cb)
	radioChecks[channel] = cb
end
exports("addChannelCheck",addChannelCheck)

local function radioNameGetter_orig(source)
	return GetPlayerName(source)
end
local radioNameGetter = radioNameGetter_orig

function overrideRadioNameGetter(channel,cb)
	local cbType = type(cb)
	radioNameGetter = cb
end
exports("overrideRadioNameGetter",overrideRadioNameGetter)

function addPlayerToRadio(source,radioChannel)
	if not canJoinChannel(source,radioChannel) then
		return TriggerClientEvent("pma-voice:removePlayerFromRadio",source,source)
	end

	radioData[radioChannel] = radioData[radioChannel] or {}
	local plyName = radioNameGetter(source)
	for player,_ in pairs(radioData[radioChannel]) do
		TriggerClientEvent("pma-voice:addPlayerToRadio",player,source,plyName)
	end

	voiceData[source] = voiceData[source] or defaultTable(source)

	voiceData[source].radio = radioChannel
	radioData[radioChannel][source] = false
	TriggerClientEvent("pma-voice:syncRadioData",source,radioData[radioChannel],plyName)
end

function removePlayerFromRadio(source, radioChannel)

	local user_id = vRP.getUserId(source)
	SendWebhookMessage(radioleft,"```prolog\n[ID]: "..user_id.." \n[STEAM HEX]: " ..GetPlayerIdentifiers(source)[1].. " \n[È USCITO DALLA FREQUENZA]: "..radioChannel.." "..os.date("\n[Data]: %d/%m/%Y [Tempo]: %H:%M:%S").." \r```")
	radioData[radioChannel] = radioData[radioChannel] or {}
	for player,_ in pairs(radioData[radioChannel]) do
		TriggerClientEvent("pma-voice:removePlayerFromRadio",player,source)
	end

	radioData[radioChannel][source] = nil
	voiceData[source] = voiceData[source] or defaultTable(source)
	voiceData[source].radio = 0
end

function setPlayerRadio(source,_radioChannel)
	voiceData[source] = voiceData[source] or defaultTable(source)
	local isResource = GetInvokingResource()
	local plyVoice = voiceData[source]
	local radioChannel = tonumber(_radioChannel)

	if not radioChannel then
		if not isResource then
			return
		end
	end

	if isResource then
		TriggerClientEvent("pma-voice:clSetPlayerRadio",source,radioChannel)
	end

	Player(source).state.radioChannel = radioChannel

	if radioChannel ~= 0 and plyVoice.radio == 0 then
		addPlayerToRadio(source,radioChannel)
	elseif radioChannel == 0 then
		removePlayerFromRadio(source,plyVoice.radio)
	elseif plyVoice.radio > 0 then
		removePlayerFromRadio(source,plyVoice.radio)
		addPlayerToRadio(source,radioChannel)
	end
end
exports("setPlayerRadio",setPlayerRadio)

RegisterNetEvent("pma-voice:setPlayerRadio",function(radioChannel)
	local user_id = vRP.getUserId(source)
	setPlayerRadio(source,radioChannel)
	SendWebhookMessage(radiojoin,"```prolog\n[ID]: "..user_id.." \n[STEAM HEX]: " ..GetPlayerIdentifiers(source)[1].. " \n[È ENTRATO NELLA FREQUENZA]: "..radioChannel.." "..os.date("\n[Data]: %d/%m/%Y [Tempo]: %H:%M:%S").." \r```")

end)

function setTalkingOnRadio(talking)
	voiceData[source] = voiceData[source] or defaultTable(source)
	local plyVoice = voiceData[source]
	local radioTbl = radioData[plyVoice.radio]
	if radioTbl then
		radioTbl[source] = talking
		for player,_ in pairs(radioTbl) do
			if player ~= source then
				TriggerClientEvent("pma-voice:setTalkingOnRadio",player,source,talking)
			end
		end
	end
end
RegisterNetEvent("pma-voice:setTalkingOnRadio",setTalkingOnRadio)

AddEventHandler("onResourceStop",function(resource)
	for channel,cfxFunctionRef in pairs(radioChecks) do
		local functionRef = cfxFunctionRef.__cfx_functionReference
		local functionResource = string.match(functionRef,resource)
		if functionResource then
			radioChecks[channel] = nil
		end
	end

	if type(radioNameGetter) == "table" then
		local radioRef = radioNameGetter.__cfx_functionReference
		if radioRef then
			local isResource = string.match(functionRef,resource)
			if isResource then
				radioNameGetter = radioNameGetter_orig
			end
		end
	end
end)