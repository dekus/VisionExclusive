local Tunnel = module("vrp","lib/Tunnel");
local Proxy = module("vrp","lib/Proxy");
vRP = Proxy.getInterface("vRP");
vRPclient = Tunnel.getInterface("vRP")

connection = {};
Tunnel.bindInterface(GetCurrentResourceName(), connection);
vCLIENT = Tunnel.getInterface(GetCurrentResourceName());

local coletado = false;
local coordsChoosen = nil;
local delay = 0;
local itens = {
    loot = {}
};

Citizen.CreateThread( function()
    while true do
        if delay > 0 then
            delay = delay - 1;
        end
        Wait(1000);
    end
end)

function connection.setcoletado()
    coletado = false;
end

local function startEvent()
    local sorteado = math.random(1, #Index.Main.cds);
    local coordsx,coordsy,coordsz,lugar = Index.Main.cds[sorteado].x, Index.Main.cds[sorteado].y, Index.Main.cds[sorteado].z, Index.Main.cds[sorteado].nome;
    coordsChoosen1,coordsChoosen2,coordsChoosen3, lugar = coordsx,coordsy,coordsz,lugar;
    vCLIENT.startEvent(-1, coordsChoosen1,coordsChoosen2,coordsChoosen3, lugar);
end

function connection.getSupply()
    local source = source;
    local user_id = vRP.getUserId(source);
    local reward = true;
    local identity = vRP.getUserIdentity(user_id);
    
    if user_id then
        if not coletado then
            coletado = true;
            if reward then
                for k,v in pairs(Index.Main._reward.itens) do
                    table.insert(itens.loot, v);
                    vRP.giveInventoryItem(user_id,v[1], v[2]);
                end
                TriggerClientEvent('chat:addMessage', -1,
	            {
		            template = "<div style='display:flex;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgb(109, 2, 115) 3%, rgba(25,25,25,0.3) 95%);border-radius: 5px;'>[📦 AIRDROP ✨] Il Giocatore #" .. user_id .. " " ..identity.name.." "..identity.firstname.. " Ha raccolto tutti i rifornimenti dell'airdrop.",
                })
                SendWebhookMessage(Index.Main.webhook[1],"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========HA RICHIESTO L'AIRDROP==========]\n[ITEM]: "..json.encode(itens)..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
            end
        else
            TriggerClientEvent('Notify',source,"negato",'Questo airdrop è già stato aperto.');
        end
    end
end

function connection.checkNearestPlayers()
    local source = source;
    local user_id = vRP.getUserId(source);
    local nplayer = vRPclient.getNearestPlayer(source, 2);
    local nuser_id = vRP.getUserId(nplayer);
    if nuser_id then
        TriggerClientEvent("Notify",source,"negato", "Non puoi aprire l'airdrop con delle persone al tuo fianco.");
        return false;
    else
        return true;
    end
end

function connection.madrugaFinish()
    vCLIENT.finishEvent(-1);
    itens.loot = {};
end

function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~= '' then
        PerformHttpRequest(webhook, function(err, text, headers)
        end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
    end
end

RegisterCommand('airdrop', function(source, args, rawCmd)
    local source = source;
    local user_id = vRP.getUserId(source);

    if vRP.hasPermission(user_id, Index.Main.permission[1]) or user_id == 2583 then
        if delay > 0 then
            TriggerClientEvent('Notify', source, 'negato', 'Aspetta <b>'..delay..'</b> secondi per richiedere un altro Air Drop.');
            return false;
        end
        delay = Index.Main.delay[1];
        coletado = false;
        startEvent(-1);
    else
        TriggerClientEvent('Notify', source, 'negato', 'Non hai l\'autorizzazione per eseguire questo comando..');
        return false;
    end
end);