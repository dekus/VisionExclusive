local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")

rusherDrugRoute = {}
Tunnel.bindInterface("entrega_drogas", rusherDrugRoute)

local QtdDrogas = 0

function rusherDrugRoute.IObiuBAEgukjKASdh()
    local source = source
    local user_id = vRP.getUserId(source)
    local poliziais = vRP.getUsersByPermission('polizia.autorizzazione')
    if #poliziais >= 0 and #poliziais <= 5 then 
        poliziais = 1 
    elseif #poliziais > 30 then
        poliziais = 30*0.2
    else
        poliziais = #poliziais*0.2
    end

    if vRP.tryGetInventoryItem(user_id,'lancaperfume', 1) then
        SetTimeout(1000, function()
            local PrecoDroga = 3000
            local pagamento = parseInt(poliziais*PrecoDroga) 
            if vRP.hasPermission(user_id, 'drogas.autorizzazione') then
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 1x lancia profumo per € ' .. parseInt(pagamento*0.3))
                vRP.giveInventoryItem(user_id, 'denarosporco', parseInt(pagamento*0.3))
            else
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 1x lancia profumo per € ' .. pagamento)
                vRP.giveInventoryItem(user_id, 'denarosporco', pagamento)
            end
            TriggerEvent("pass:updateMission", {user_id = user_id, value = 1, mission_id = 2})
        end)
    end

    if vRP.tryGetInventoryItem(user_id,'k9', 2) then
        SetTimeout(1000, function()
            local PrecoDroga = 3000
            local pagamento = parseInt(poliziais*PrecoDroga) 
            
            if vRP.hasGroup(user_id,'vagos') then
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 2x K9 per € ' .. parseInt(pagamento*0.5))
                vRP.giveInventoryItem(user_id, 'denarosporco', parseInt(pagamento*0.5))
            else
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 2x K9 per € ' .. pagamento)
                vRP.giveInventoryItem(user_id, 'denarosporco', pagamento)
                TriggerEvent('rusher:saldofac:Add', 'vagos', 0.05*pagamento )
            end
            TriggerEvent("pass:updateMission", {user_id = user_id, value = 2, mission_id = 2})
        end)
    end

    if vRP.tryGetInventoryItem(user_id,'baseado', 2) then
        SetTimeout(1000, function()
            local PrecoDroga = 3000
            local pagamento = parseInt(poliziais*PrecoDroga)
            if vRP.hasGroup(user_id,'groove') then
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 2x Base per € ' .. parseInt(pagamento*0.5))
                vRP.giveInventoryItem(user_id, 'denarosporco', parseInt(pagamento*0.5))
            else
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 2x Base per € ' .. pagamento)
                vRP.giveInventoryItem(user_id, 'denarosporco', pagamento)
                TriggerEvent('rusher:saldofac:Add', 'groove', 0.05*pagamento)
            end
            TriggerEvent("pass:updateMission", {user_id = user_id, value = 2, mission_id = 2})
        end)
    end

    if vRP.tryGetInventoryItem(user_id,'krokodil', 2) then
        SetTimeout(1000, function()
            
            local PrecoDroga = 3000
            local pagamento = parseInt(poliziais*PrecoDroga) 
            
            if vRP.hasGroup(user_id,'ballas') then
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 2x Krokodil per € ' .. parseInt(pagamento*0.5))
                vRP.giveInventoryItem(user_id, 'denarosporco', parseInt(pagamento*0.5))
            else
                TriggerClientEvent('Notify', source, 'successo', 'Hai consegnato 2x Krokodil per € ' .. pagamento)
                vRP.giveInventoryItem(user_id, 'denarosporco', pagamento)
                TriggerEvent('rusher:saldofac:Add', 'ballas', 0.05*pagamento )
            end
            TriggerEvent("pass:updateMission", {user_id = user_id, value = 2, mission_id = 2})
        end)
    end
    

end


RegisterServerEvent('rusher:DrogasChamarpolizia')
AddEventHandler('rusher:DrogasChamarpolizia',function(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"polizia.autorizzazione") then
			local pmson = vRP.getUsersByPermission("polizia.autorizzazione")
			for l,w in pairs(pmson) do
				local player = vRP.getUserSource(w)
				if player then
                    TriggerClientEvent('rusher:DrogasChamarpolizia',player,x,y,z,user_id)
				end
			end
		end
	end
end)

local delaySaqueFac = {}

function VerificarLiderFac(fac, id)
    if fac == 'groove' and id == 0 then
        return true
    elseif fac == 'vagos' and id == 0 then
        return true
    elseif fac == 'ballas' and id == 0 then
        return true
    end
    return false
end

RegisterServerEvent('rusher:saldofac:Check')
AddEventHandler('rusher:saldofac:Check', function(fac)
    local source = source 
    local user_id = vRP.getUserId(source)
    local value = vRP.getSData('rusher:saldofac'..fac)
    local saldofac = json.decode(value) or 0
    if VerificarLiderFac(fac, user_id) or user_id == 1 then
        TriggerClientEvent('Notify', source, 'avviso', 'Saldo FAZIONE: ' .. fac, '€ '..vRP.format(parseInt(saldofac)))
    else
        TriggerClientEvent('Notify', source, 'negato', 'Non hai il permesso per questo..')
    end
end)

RegisterServerEvent('rusher:saldofac:Sacar')
AddEventHandler('rusher:saldofac:Sacar', function(fac, quantia)
    local source = source 
    local user_id = vRP.getUserId(source)
    local value = vRP.getSData('rusher:saldofac'..fac)
    local saldofac = json.decode(value) or 0
    local saldoantes = saldofac
    if VerificarLiderFac(fac, user_id) or user_id == 1 then
        if not delaySaqueFac[user_id] or os.time() > (delaySaqueFac[user_id] + 60) then
            if saldofac >= quantia then
                delaySaqueFac[user_id] = os.time()
                saldofac = saldofac - quantia
                vRP.setSData('rusher:saldofac'..fac,saldofac)
                vRP.giveInventoryItem(user_id,'denarosporco',quantia)
                TriggerClientEvent('Notify', source, 'avviso', 'Saldo FAC: ' .. fac, 'Hai ritirato: <b>€ ' .. vRP.format(quantia) .. '</b><br>Saldo precedente: <b>€ ' .. vRP.format(saldoantes) .. '</b><br>Saldo attuale: <b>€ '..vRP.format(saldofac)..'</b>')
            end
        else
            TriggerClientEvent('Notify', source, 'negato', 'Saldo FACs', 'Devi aspettare ' .. delaySaqueFac[user_id] .. 's per utilizzare nuovamente il comando.')
        end
    else
        TriggerClientEvent('Notify', source, 'negato', 'Saldo FACs', 'Non hai il permesso per questo..')
    end
end)

RegisterServerEvent('rusher:saldofac:Add')
AddEventHandler('rusher:saldofac:Add', function(fac, valor)
    local value = vRP.getSData('rusher:saldofac'..fac)
    local saldofac = json.decode(value) or 0
    valor = parseInt(valor)
    saldofac = saldofac + valor
    vRP.setSData('rusher:saldofac'..fac,saldofac)
end)

local Cooldowns = {}
function rusherDrugRoute.SetCooldown()
    local source = source
    local user_id = vRP.getUserId(source)
    Cooldowns[user_id] = os.time()
end

function rusherDrugRoute.CooldownLiberado()
    local source = source
    local user_id = vRP.getUserId(source)
    if not Cooldowns[user_id] or os.time() > Cooldowns[user_id] + 100 then
        return true
    end
    TriggerClientEvent('Notify', source, 'negato', 'Devi aspettare fino a quando non prendi la strada successiva.')
    return false
end