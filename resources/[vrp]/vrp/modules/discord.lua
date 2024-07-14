Discord = {
	DiscordToken = "MTEyODM4NTk5NDY2MDUxNTkyMg.GmP6R_.iMm2LkB-KV1hXTmW_BvDPkpAaSkxyJSBDTqSY0",
	GuildId = "1089299408803344445",  
	Roles = {
		["booster"] = "1128366903937728644",
	}
}


local FormattedToken = "Bot "..Discord.DiscordToken

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetRoles(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			print("Found discord id: "..discordId)
			break
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Discord.GuildId, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		else
			print("An error occured, maybe they arent in the discord? Error: "..member.data)
			return false
		end
	else
		print("missing identifier")
		return false
	end
end

function IsRolePresent(user, role)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
		--	print("Found discord id: "..discordId)
			break
		end
	end

	local theRole = nil
	if type(role) == "number" then
		theRole = tostring(role)
	else
		theRole = Discord.Roles[role]
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Discord.GuildId, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			for i=1, #roles do
				if roles[i] == theRole then
					return true
				end
			end
			return false
		else
			return false
		end
	else
		return false
	end
end

Citizen.CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/"..Discord.GuildId, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		print("[DISCORD PERMS STARTED]: "..data.name.." ("..data.id..")")
	else
		print("An error occured, please check your Discord and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
end)


function vRP.GetUserRoles(src, roles)
  local user_id = vRP.getUserId(src)
  if IsRolePresent(user_id, roles) then
    return true
  else
    return false
  end
end
