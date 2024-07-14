local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local JoinCoolDown = {}
local BannedAlready = false
local BannedAlready2 = false
local isBypassing = false
local isBypassing2 = false
local DatabaseStuff = {}
local BannedAccounts = {}
local Admins = {
    "steam:110000113deaa22", --Deku
    "steam:110000117fddb76", --Snail
    "steam:110000111e77422", --Gepp
    'steam:11000013d070831', --itz_big_smoke
}


AddEventHandler('Initiate:BanSql', function(hex, id, reason, name, day, staffer)
    local src = source

    local time
    local motivazione

    if tonumber(day) == -1 then
        time = 99999
    else
        time = day
    end


    if reason == "" or reason == nil then
        motivazione = "Sei stato bannato"
    else
        motivazione = reason
    end

    exports.oxmysql:update('UPDATE bansystem SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
    {
        ['@isBanned'] = 1,
        ['@Reason'] = motivazione,
        ['@Steam'] = hex,
        ['@Expire'] = os.time() + (time * 86400)
    })


    
    local embed = {
        {
            ["color"] = "9830400",
            ["author"] = {
                ["name"] = "Italian Freeroam Logs",
                ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
            },
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
            },
            ["title"] = "Log Ban Utente Online",
            ["footer"] = {
                ["text"] = "Italian Freeroam",
                ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
            },
            ["timestamp"] = os.date("!%Y-%m-%d %H:%M:%S"),

            ["fields"] = {
                {
                    ["name"] = "Staffer",
                    ["value"] = "<@"..staffer..">",
                    ["inline"] = true
                },
                {
                    ["name"] = "Utente Bannato",
                    ["value"] = hex,
                    ["inline"] = true
                },
                {
                    ["name"] = "Motivazione",
                    ["value"] = motivazione,
                    ["inline"] = true
                },
                {
                    ["name"] = "Durata",
                    ["value"] = "Giorni: "..time,
                    ["inline"] = false
                }
            }
        
        }
    }


    PerformHttpRequest('https://discord.com/api/webhooks/1130479636946620447/SlFrCqGJVT7xW38sihRIgTBFwjtDmgWIz2kG_CWKK-9foNWUm2w6WP0hBIRhOGRvRAvV', function(err, text, headers) end, 'POST', json.encode({username = "ItalianFreeroam", embeds = embed}), { ['Content-Type'] = 'application/json' })

    TriggerClientEvent('Notify', src, 'successo', "Bannato con successo: " .. hex .. " Motivazione: " .. reason .. " Durata: " .. time .. " Giorni. :)")


    DropPlayer(id, reason)

    SetTimeout(5000, function()
        ReloadBans()
    end)

end)

AddEventHandler('TargetPlayerIsOffline', function(hex, reason, day, staffer)
    local src = source
    local Ttime
    local Tmotivazione

    if tonumber(day) == -1 then
        Ttime = 9999
    else
        Ttime = day
    end


    if reason == nil then
        Tmotivazione = "Sei Stato Bannato!"
    else
        Tmotivazione = reason
    end



    exports.oxmysql:query('SELECT Steam FROM bansystem WHERE Steam = @Steam',
    {
        ['@Steam'] = hex

    }, function(data)
        if data[1] then
            exports.oxmysql:update('UPDATE bansystem SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
            {
                ['@isBanned'] = 1,
                ['@Reason'] = Tmotivazione,
                ['@Steam'] = hex,
                ['@Expire'] = os.time() + (Ttime * 86400)
            })


            TriggerClientEvent('Notify', src, 'successo', "Bannato con successo: " .. hex .. " Motivazione: " .. reason .. " Durata: " .. time .. " Giorni. :)")


            local embed = {
                {
                    ["color"] = "9830400",
                    ["author"] = {
                        ["name"] = "Italian Freeroam Logs",
                        ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                    },
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                    },
                    ["title"] = "Log Ban Utente Offline",
                    ["footer"] = {
                        ["text"] = "Italian Freeroam",
                        ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                    },

                    ["fields"] = {
                        {
                            ["name"] = "Staffer",
                            ["value"] = "<@"..staffer..">",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Utente Bannato",
                            ["value"] = hex,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Motivazione",
                            ["value"] = Tmotivazione,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Durata",
                            ["value"] = "Giorni: "..Ttime,
                        }
                    }
                
                }
            }
        
            PerformHttpRequest('https://discord.com/api/webhooks/1130479636946620447/SlFrCqGJVT7xW38sihRIgTBFwjtDmgWIz2kG_CWKK-9foNWUm2w6WP0hBIRhOGRvRAvV', function(err, text, headers) end, 'POST', json.encode({username = "ItalianFreeroam", embeds = embed}), { ['Content-Type'] = 'application/json' })

            SetTimeout(5000, function()
                ReloadBans()
            end)

        else
            TriggerClientEvent('Notify', src, 'negato', "Non riesco a trovare questo Steam Hex. :( Non è corretto")
        end
    end)
end)

RegisterCommand("offlineban:italianfreeroam", function(source, args)

    local src = source
    local ds = json.decode(args[1])

    local hex = ds.steamhex
    local motivazione = ds.reason
    local day = ds.giorni
    local staffer = ds.staffer


    if source == 0 then

        if args[1] == nil then return end

        TriggerEvent('TargetPlayerIsOffline', hex, motivazione, tonumber(day), staffer)

    end


end)

RegisterCommand('offlineunban:italianfreeroam', function(source, args)

    if source == 0 then

        local ds = json.decode(args[1])

        local steamhex = ds.steamhex
        local staffer = ds.staffer

        if tostring(steamhex) then
            exports.oxmysql:query('SELECT Steam FROM bansystem WHERE Steam = @Steam',
            {
                ['@Steam'] = steamhex
    
            }, function(data)
                if data[1] then
                    exports.oxmysql:update('UPDATE bansystem SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
                    {
                        ['@isBanned'] = 0,
                        ['@Reason'] = "",
                        ['@Steam'] = steamhex,
                        ['@Expire'] = 0
                    })
                    SetTimeout(5000, function()
                        ReloadBans()
                    end)

                    local embed = {
                        {
                            ["color"] = "9830400",
                            ["author"] = {
                                ["name"] = "Italian Freeroam Logs",
                                ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                            },
                            ["thumbnail"] = {
                                ["url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                            },
                            ["title"] = "Log Ban Unban",
                            ["footer"] = {
                                ["text"] = "Italian Freeroam",
                                ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                            },
                
                            ["fields"] = {
                                {
                                  ["name"] = "Staffer",
                                  ["value"] = "<@"..staffer..">",
                                  ["inline"] = true
                                },
                                {
                                  ["name"] = "Utente Sbannato",
                                  ["value"] = steamhex,
                                  ["inline"] = true
                                },
                            }
                        
                        }
                    }
                
                  
                    PerformHttpRequest('https://discord.com/api/webhooks/1130479636946620447/SlFrCqGJVT7xW38sihRIgTBFwjtDmgWIz2kG_CWKK-9foNWUm2w6WP0hBIRhOGRvRAvV', function(err, text, headers) end, 'POST', json.encode({username = "ItalianFreeroam", embeds = embed}), { ['Content-Type'] = 'application/json' })

                else
                    print("Inserisci lo steamhex giusto.!")
                end
            end)
        else
            print("Lo Steam Hex inserito non è valido.!")
        end
    else
        if source ~= 0 then
            print("Player ^1"..GetPlayerName(source).." ^0sta provando ad eseeguire un comando di ban.")
        end
    end
end)
AddEventHandler('playerConnecting', function(name, setKickReason)
    local source = source
    local Steam = "NONE"
    local Lice = "NONE"
    local Live = "NONE"
    local Xbox = "NONE"
    local Discord = "NONE"
    local IP = "NONE"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            Steam = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            Lice = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            Live = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            Discord = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IP = v
        end
    end

    if Steam == nil or Lice == nil or Steam == "" or Lice == "" or Steam == "NONE" or Lice == "NONE" then
        setKickReason("\n \n ITF: \n La tua app di Steam non è aperta, prima apri l'app di Steam. \n Riavvia FiveM.")
        CancelEvent()
        return
    end

    if GetNumPlayerTokens(source) == 0 or GetNumPlayerTokens(source) == nil or GetNumPlayerTokens(source) < 0 or GetNumPlayerTokens(source) == "null" or GetNumPlayerTokens(source) == "**Invalid**" or not GetNumPlayerTokens(source) then
        DiscordLog(source, "Molti token sono nil o non sono validi.")
        setKickReason("\n \n ITF: \n Si è verificato un problema durante il recupero delle informazioni! \n Riavvia Fivem.")
        CancelEvent()
        return
    end

    if JoinCoolDown[Steam] == nil then
        JoinCoolDown[Steam] = os.time()
    elseif os.time() - JoinCoolDown[Steam] < 15 then 
        setKickReason("\n \n ITF: \n ErrorCode : #12\n \n Non spammare il pulsante di connessione.")
        CancelEvent()
        return
    else
        JoinCoolDown[Steam] = nil
    end
    for a, b in pairs(BannedAccounts) do
        for c, d in pairs(b) do 
            for e, f in pairs(json.decode(d.Tokens)) do
                for g = 0, GetNumPlayerTokens(source) - 1 do
                    if GetPlayerToken(source, g) == f or d.License == tostring(Lice) or d.Live == tostring(Live) or d.Xbox == tostring(Xbox) or d.Discord == tostring(Discord) or d.IP == tostring(IP) or d.Steam == tostring(Steam) then
                        if os.time() < tonumber(d.Expire) then
                            BannedAlready = true
                            if d.Steam ~= tostring(Steam) then
                                isBypassing = true
                            end
                            setKickReason("\n \n Italian Freeroam Ban System: \n Ban ID: #"..d.ID.."\n Motivazione: "..d.Reason.."\n Durata: "..math.floor(((tonumber(d.Expire) - os.time())/86400)).." Giorni! \nHWID: "..f)
                            CancelEvent()
                            break
                        else
                            CreateUnbanThread(tostring(d.Steam))
                            break
                        end
                    end
                end
            end
        end
    end
    if not BannedAlready and not isBypassing then
        InitiateDatabase(tonumber(source))
    end
    if BannedAlready then
        BannedAlready = false
        DiscordLog(source, "Ha provato ad accedere ma è bannato!")
    end
    if isBypassing then
        isBypassing = false
        DiscordLog(source, "Ha tentato di accedere utilizzando il metodo di BYPASS (modificato Steam Hex (nuovo account bannato prima di entrare nel server))")
        BanNewAccount(tonumber(source), "Hai provato a bypassare il ban!", os.time() + (4900 * 86400))
    end
end)

function CreateUnbanThread(Steam)
    exports.oxmysql:query('SELECT Steam FROM bansystem WHERE Steam = @Steam',
    {
        ['@Steam'] = Steam

    }, function(data)
        if data[1] then
            exports.oxmysql:update('UPDATE bansystem SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
            {
                ['@isBanned'] = 0,
                ['@Reason'] = "",
                ['@Steam'] = Steam,
                ['@Expire'] = 0
            })
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end
    end)
end

function InitiateDatabase(source)
    local source = source
    local ST = "None"
    local LC = "None"
    local LV = "None"
    local XB = "None"
    local DS = "None"
    local IiP = "None"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            ST  = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            LC  = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            LV  = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            XB = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            DS = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IiP = v
        end
    end
    if ST == "None" then print(source.." Failed To Create User") return end
    DatabaseStuff[ST] = {}
    for i = 0, GetNumPlayerTokens(source) - 1 do 
        table.insert(DatabaseStuff[ST], GetPlayerToken(source, i))
    end
    exports.oxmysql:query('SELECT * FROM bansystem WHERE Steam = @Steam',
    {
        ['@Steam'] = ST

    }, function(data) 
        if data[1] == nil then
            exports.oxmysql:update('INSERT INTO bansystem (Steam, License, Tokens, Discord, IP, Xbox, Live, Reason, Expire, isBanned) VALUES (@Steam, @License, @Tokens, @Discord, @IP, @Xbox, @Live, @Reason, @Expire, @isBanned)',
            {
                ['@Steam'] = ST,
                ['@License'] = LC,
                ['@Discord'] = DS,
                ['@Xbox'] = XB,
                ['@IP'] = IiP,
                ['@Live'] = LV,
                ['@Reason'] = "",
                ['@Tokens'] = json.encode(DatabaseStuff[ST]),
                ['@Expire'] = 0,
                ['@isBanned'] = 0
            })
            DatabaseStuff[ST] = nil
        end 
    end)
end


function BanNewAccount(source, Reason, Time)
    local source = source
    local ST = "None"
    local LC = "None"
    local LV = "None"
    local XB = "None"
    local DS = "None"
    local IiP = "None"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            ST  = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            LC  = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            LV  = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            XB = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            DS = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IiP = v
        end
    end
    if ST == "None" then print(source.." Failed To Create User") return end
    DatabaseStuff[ST] = {}
    for i = 0, GetNumPlayerTokens(source) - 1 do 
        table.insert(DatabaseStuff[ST], GetPlayerToken(source, i))
    end
    exports.oxmysql:query('SELECT * FROM bansystem WHERE Steam = @Steam',
    {
        ['@Steam'] = ST

    }, function(data) 
        if data[1] == nil then
            exports.oxmysql:update('INSERT INTO bansystem (Steam, License, Tokens, Discord, IP, Xbox, Live, Reason, Expire, isBanned) VALUES (@Steam, @License, @Tokens, @Discord, @IP, @Xbox, @Live, @Reason, @Expire, @isBanned)',
            {
                ['@Steam'] = ST,
                ['@License'] = LC,
                ['@Discord'] = DS,
                ['@Xbox'] = XB,
                ['@IP'] = IiP,
                ['@Live'] = LV,
                ['@Reason'] = Reason,
                ['@Tokens'] = json.encode(DatabaseStuff[ST]),
                ['@Expire'] = Time,
                ['@isBanned'] = 1
            })
            DatabaseStuff[ST] = nil
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end 
    end)
end


RegisterCommand('banreload', function(source, args)
    if IsPlayerAllowedToBan(source) or source == 0 then
        ReloadBans()
        TriggerClientEvent('Notify', source, 'successo', "Ban List Ricaricata")
    end
end)

RegisterCommand('_banreload', function(source, args)

    if source == 0 then

        ReloadBans()
        print("Ban ricaricati")

    end
    
end)


RegisterCommand('bans', function(source, args)


    local target = vRP.getUserId(tonumber(args[1]))

    if IsPlayerAllowedToBan(source) or source == 0 then
        if args[1] then
            if tonumber(args[2]) then
                if args[3] then
                    if tonumber(args[1]) then
                        if GetPlayerName(target) then

                            for k, v in ipairs(GetPlayerIdentifiers(target)) do
                                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                                    Hex = v
                                end
                            end



                            TriggerEvent('Initiate:BanSql', Hex, tonumber(target), table.concat(args, " ",3), GetPlayerName(target), tonumber(args[2]), discord_user(source))

                            TriggerClientEvent('Notify', source, 'successo', "Il giocatore è stato bannato")



                        else
                            TTriggerClientEvent('Notify', source, 'negado', "Il giocatore non è online.")
                        end
                    else
                        if string.find(args[1], "steam:") ~= nil then


                            TriggerEvent('TargetPlayerIsOffline', args[1], table.concat(args, " ",3), tonumber(args[2]), discord_user(source))

                            TriggerClientEvent('Notify', source, 'successo', "Il giocatore è stato bannato offline.")


                        else
                            TriggerClientEvent('Notify', source, 'negato', "SteamHex Invalido.")
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'negato', "Inserisci una Motivazione del ban.")
                end
            else
                TriggerClientEvent('Notify', source, 'negato', "Inserisci la durata bel ban.")
            end
        else
            TriggerClientEvent('Notify', source, 'negato', "Inserisci l'id del giocatore o lo steamhex.")
        end
    else
        if source ~= 0 then
            print("Player "..GetPlayerName(source).." sta provando ad eseeguire un comando di ban.")
        end
    end
end)


RegisterCommand('unban', function(source, args)
    if IsPlayerAllowedToBan(source) or source == 0 then
        if tostring(args[1]) then
            exports.oxmysql:query('SELECT Steam FROM bansystem WHERE Steam = @Steam',
            {
                ['@Steam'] = args[1]
    
            }, function(data)
                if data[1] then
                    exports.oxmysql:update('UPDATE bansystem SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
                    {
                        ['@isBanned'] = 0,
                        ['@Reason'] = "",
                        ['@Steam'] = args[1],
                        ['@Expire'] = 0
                    })
                    SetTimeout(5000, function()
                        ReloadBans()
                    end)

                    local embed = {
                        {
                            ["color"] = "9830400",
                            ["author"] = {
                                ["name"] = "Italian Freeroam Logs",
                                ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                            },
                            ["thumbnail"] = {
                                ["url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                            },
                            ["title"] = "Log Ban Unban",
                            ["footer"] = {
                                ["text"] = "Italian Freeroam",
                                ["icon_url"] = "https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif"
                            },
                
                            ["fields"] = {
                                {
                                  ["name"] = "Staffer",
                                  ["value"] = "<@"..discord_user(source)..">",
                                  ["inline"] = true
                                },
                                {
                                  ["name"] = "Utente Sbannato",
                                  ["value"] = args[1],
                                  ["inline"] = true
                                },
                            }
                        
                        }
                    }
                
                  
                    PerformHttpRequest('https://discord.com/api/webhooks/1130479636946620447/SlFrCqGJVT7xW38sihRIgTBFwjtDmgWIz2kG_CWKK-9foNWUm2w6WP0hBIRhOGRvRAvV', function(err, text, headers) end, 'POST', json.encode({username = "ItalianFreeroam", embeds = embed}), { ['Content-Type'] = 'application/json' })

                    TriggerClientEvent('Notify', source, 'successo', "Unban effettuato con successo.")

                else
                    TriggerClientEvent('Notify', source, 'negato', "Inserisci lo steamhex giusto.")
                end
            end)
        else
            TriggerClientEvent('Notify', source, 'negato', "Lo Steam Hex inserito non è valido.")
        end
    else
        if source ~= 0 then
            print("Player ^1"..GetPlayerName(source).." ^0sta provando ad eseeguire un comando di ban.")
        end
    end
end)



function ReloadBans()
    Citizen.CreateThread(function()
        BannedAccounts = {}
        exports.oxmysql:query('SELECT * FROM bansystem', {}, function(info)
            for i = 1, #info do
                if info[i].isBanned == 1 then
                    Citizen.Wait(20)
                    table.insert(BannedAccounts, {info[i]})
                end
            end
        end)
    end)
end

function IsPlayerAllowedToBan(player)
    local allowed = false
	for i, id in ipairs(Admins) do
		for x, pid in ipairs(GetPlayerIdentifiers(player)) do
			if string.lower(pid) == string.lower(id) then
				allowed = true
			end
		end
	end		
    return allowed
end

function DiscordLog(source, method)
    PerformHttpRequest('https://discord.com/api/webhooks/1130479636946620447/SlFrCqGJVT7xW38sihRIgTBFwjtDmgWIz2kG_CWKK-9foNWUm2w6WP0hBIRhOGRvRAvV', function(err, text, headers)
    end, 'POST',
        json.encode(
            {
                username = 'Ban Evading - Info',
                embeds = {  
                            {    
                                ["color"] = 9830400,

                                ["author"] = {
                                    ["name"] = 'Italian Freeroam Logs ',
                                    ["icon_url"] = 'https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif'
                                },

                                ["description"] = "**Ban Log **\n```css\n[Giocatore]: " ..GetPlayerName(source).. "\n[Discord]: " ..discord_user(source).. "\n[Licenza]: " ..GetPlayerIdentifiers(source)[2].."\n[Steam]: " ..GetPlayerIdentifiers(source)[1].. "\n [Id]: " .. source.. "\n" .. "[Metodo]: " .. method .. "\n```",
                                
                                ["footer"] = {
                                    ["text"] = "Italian Freeroam Logs- "..os.date("%x %X  %p"),
                                    ["icon_url"] = 'https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif',
                                },
                            }
                        },
                avatar_url = 'https://cdn.discordapp.com/attachments/721282285051052123/897566357200187432/ItalianGifEdited.gif'
            }    
        ),
        {
            ['Content-Type'] = 'application/json'
        }
    )
end


function discord_user(src)

	for k,v in pairs(GetPlayerIdentifiers(src)) do

        if string.match(v, 'discord:') then

            if 'discord:' == 'discord:' then

                local discord = string.gsub(v, 'discord:', '')

                return discord

            end

        end

	end

end

DumpTable = function(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s ..DumpTable(v, nb + 1) .. '\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. ''
	else
		return tostring(table)
	end
end

ReloadBans()
print("Ban List Ricaricata!")
