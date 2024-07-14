local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")


src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local conceOpened = true
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("conceadm",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"chamadoadmin.autorizzazione") then
        if conceOpened then 
            conceOpened = false
            TriggerClientEvent("Notify",source,"importante","Hai chiuso la concessionaria")
        else
            TriggerClientEvent("Notify",source,"importante","Hai aperto la concessionaria")
            conceOpened = true 
            reloadStock()
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET VEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
src.returnVehList = function()
    local source = source 
    local user_id = vRP.getUserId(source)
    if conceOpened then 
        local identity = vRP.getUserIdentity(user_id)
        return vehicleList,{ identity["name"],identity["firstname"],vRP.format(parseInt(vRP.getBankMoney(user_id))),vRP.format(parseInt(vRP.getMoney(user_id))) }
    end
    TriggerClientEvent("Notify",source,"negato","Il concessionario è chiuso")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
src.getVehicles = function()
    local source = source 
    local user_id = vRP.getUserId(source)
    local vehicle = vRP.query("creative/get_vehicle",{ user_id = user_id })
    if user_id and parseInt(#vehicle) > 0 then 
        local vehicles = {}
        for k,v in pairs(vehicle) do 
            if v.financiado == 0 then 
                vehicles[v.vehicle] = { spawn = v.vehicle, name = vRP.vehicleName(v.vehicle), price = vRP.vehiclePrice(v.vehicle)*0.50, category = vRP.vehicleClass(v.vehicle)  }
            end
        end
        return vehicles
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
src.buyVehicle = function(vehicleInfos)
    local source = source
	local user_id = vRP.getUserId(source)
    local category = vehicleInfos[1]
    local car = string.lower(vehicleInfos[2])
    local classe = vRP.vehicleClass(car)
	if user_id then 
        local value = vRP.getUData(parseInt(user_id),"vRP:multas")
		local multas = json.decode(value) or 0
        if multas > 50000 then
            TriggerClientEvent("Notify",source,"negato","Tieni delle multe da pagare.")
            return
        end

        local estoque = getEstoque(category,car)
        if parseInt(estoque) <= 0 then
            TriggerClientEvent("Notify",source,"importante","Scorta di <b>"..car.."</b> non disponibile.")
            return
        end
        
		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = car })
		if not vehicle[1] then
            if vehicleInfos[3] == "avista" then
                if vRP.request(source,"Vuoi comprarne un <b>"..vRP.vehicleName(car).."</b> per <b>€ "..vRP.format(vehInfos(category,car).valor).." Dollari</b>?",30) then
                    if vRP.tryFullPayment(user_id,parseInt(vehInfos(category,car).valor)) then
                        vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = car, ipva = parseInt(os.time())  })
                        TriggerEvent("vRP:save")
                        TriggerClientEvent("Notify",source,"importante","Hai comprato un <b>"..vRP.vehicleName(car).."</b> per <b>€ "..vRP.format(vehInfos(category,car).valor).." dollari</b>.")
                        -- exports["logs"]:sendLogs(user_id,{ webhook = "LogCompraCarro", text = " \n[COMPRATO AUTO]: "..vRP.vehicleName(car).."</b> por <b>€ "..vRP.format(vehInfos(category,car).valor).." "})
                        reduceEstoque(category,car)
                    else
                        TriggerClientEvent("Notify",source,"negato","Non abbastanza soldi.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negato","Acquisto annullato." )
                end 
            else
            end
        else
			TriggerClientEvent("Notify",source,"importante","possiedi già un <b>"..vRP.vehicleName(car).."</b> nel tuo garage.")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
removeVeh = function(plyInfos,sell)
    if plyInfos then 
        local haveChest = json.decode(vRP.getSData("chest:u"..parseInt(plyInfos.plyId).."veh_"..plyInfos.vehicle)) or {}
        if haveChest then
            vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(plyInfos.plyId).."veh_"..string.lower(plyInfos.vehicle) })
        end

        vRP.execute("creative/rem_vehicle", { user_id = parseInt(plyInfos.plyId), vehicle = plyInfos.vehicle })
        if sell then return true end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- START TEST
-----------------------------------------------------------------------------------------------------------------------------------------
src.startTest = function(vehicleInfos)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id and vehicleInfos then 
        local category = vehicleInfos[1]
        local car = string.lower(vehicleInfos[2])
        if vehicleList[category][car] then 
            local price = vehicleList[category][car].valor * 0.003
            local choice = vRP.request(source, "Vuoi iniziare il test drive con <b>€ "..vRP.format(price).."</b>?",30)
            if choice and vRP.getBankMoney(user_id) + vRP.getMoney(user_id) >= price then
                if vRP.tryFullPayment(user_id,price) then 
                    vCLIENT.testDrive(source,car,price)
                    exports["logs"]:sendLogs(user_id,{ webhook = "LogTestDrive", text = " \n[INIZIATO TEST DRIVE]: "..vRP.vehicleName(car).."</b> per <b>€ "..vRP.format(price).." "})
                end
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCA SESSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src.changeSession = function(status)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then 
        if status then
            SetPlayerRoutingBucket(source, user_id)
        else
            SetPlayerRoutingBucket(source, 0)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARGEBACK DO TESTE
-----------------------------------------------------------------------------------------------------------------------------------------
src.chargeBack = function(price)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then 
        vRP.giveBankMoney(user_id,parseInt(price),"Vendedor")
		TriggerClientEvent("Notify",source,"importante", "Hai ricevuto il tuo <b>€ "..vRP.format(price).."</b> Indietro.", 3000)                                                                              
    end
end