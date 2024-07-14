local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")


function ExtractIdentifiers(src)
    
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

local logs = "https://discord.com/api/webhooks/1130290727302205600/N539iTpYBnFr29RTBTCXlgpJtpI_OoLPwnaTwcoy4_Fir1AoTluW5lI-2nbsDS67odxA"

local kick_msg = "Non dumpare amigo ahhahaha"
local discord_msg = '`Player try to use nui_devtools`\n`and he got a kick`\n`ANTI NUI_DEVTOOLS`'
local color_msg = 16767235

function sendToDiscord (source,message,color,identifier)
    
    local name = GetPlayerName(source)
    if not color then
        color = color_msg
    end
    local sendD = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = "`Player`: **"..name.."**\nSteam: **"..identifier.steam.."** \nIP: **"..identifier.ip.."**\nDiscord: **"..identifier.discord.."**\nFivem: **"..identifier.license.."**",
            ["footer"] = {
                ["text"] = "© Vision Exclusive - "..os.date("%x %X %p")
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "YourRP - Anti nui_devtools", embeds = sendD}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent(GetCurrentResourceName())
AddEventHandler(GetCurrentResourceName(), function()
    local _source = source
    local identifier = ExtractIdentifiers(_source)
    local identifierDb
    if extendedVersionV1Final then
        identifierDb = identifier.license
    else
        identifierDb = identifier.steam
    end
    if checkmethod == 'steam' then
	if json.encode(allowlist) == "[]" then
	   sendToDiscord (_source, discord_msg, color_msg,identifier)
            vRP.kick(source,'Sei stato espulso per aver utilizzato Dev Tools, non scherzare!')
	end
	for _, v in pairs(allowlist) do
           if v ~= identifierDb then
	      sendToDiscord (_source, discord_msg, color_msg,identifier)
            vRP.kick(source,'Sei stato espulso per aver utilizzato Dev Tools, non scherzare!')
           end
        end
     elseif checkmethod == 'SQL' then
        MySQL.Async.fetchAll("SELECT group FROM users WHERE identifier = @identifier",{['@identifier'] = identifierDb }, function(results) 
            if results[1].group ~= 'admin' or 'superadmin' then
               sendToDiscord (source, discord_msg, color_msg,identifier)
                vRP.kick(source,'Sei stato espulso per aver utilizzato Dev Tools, non scherzare!')
            end
        end)
     end
end)
