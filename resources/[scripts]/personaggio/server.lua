RegisterServerEvent("personagem:finishedIntro")
RegisterServerEvent("personagem:finishedCharacter")

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local userlogin = {}

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
        local data = vRP.getUData(user_id,"vRP:spawnController")
        local spawnStatus = json.decode(data) or 0
        SetTimeout(5000, function() -- tunnel/proxy delay
            processSpawnController(source, spawnStatus, user_id)
        end)
    end
end)

function processSpawnController(source,statusSent,user_id)
    local source = source
    if statusSent == 2 then
        if not userlogin[user_id] then
            userlogin[user_id] = true
            doSpawnPlayer(source,user_id,false)
        else
            doSpawnPlayer(source,user_id,true)
        end
    elseif statusSent == 1 or statusSent == 0 then
        userlogin[user_id] = true
        TriggerClientEvent("personagem:characterCreate",source)
    end
end

AddEventHandler("personagem:finishedIntro", function()
    TriggerClientEvent("character:characterCreate", source)
end)

AddEventHandler("personagem:finishedCharacter", function(characterNome, characterSobrenome, characterAge, currentCharacterMode)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local player = vRP.getUserSource(user_id)
        vRP.setUData(user_id,"currentCharacterMode", json.encode(currentCharacterMode))
        vRP.setUData(user_id,"vRP:spawnController", json.encode(2))
        vRP.execute("vRP/update_user_first_spawn", {user_id = user_id,name = characterNome,firstname = characterSobrenome,age = characterAge})
        doSpawnPlayer(source,user_id,true)
    end
end)

function doSpawnPlayer(source,user_id,firstspawn)
    TriggerClientEvent("personagem:normalSpawn",source,firstspawn)
    TriggerEvent("vrp_barbershop:init",user_id)
end