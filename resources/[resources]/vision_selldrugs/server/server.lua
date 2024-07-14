local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

srr = {}
Tunnel.bindInterface(GetCurrentResourceName(), srr)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

function srr.sellDrugs(k,v)
    local source = source
    local user_id = vRP.getUserId(source)

    local chest = vRP.getSData('chest:'..k)
    local balance = json.decode(chest) or {}
    local citem = balance[Config.SellDrugs[k]["item"]]
    
    if not citem then TriggerClientEvent("Notify",source,"negato","Esaurito") return end
    
    local camount = citem.amount

    TriggerClientEvent("Notify",source,"successo","Quantità di " ..vRP.itemNameList(Config.SellDrugs[k]["item"]).. " in magazzino: " ..camount)

    local amount = vRP.prompt(source, "Quantità di droghe", "")
    amount = tonumber(parseInt(amount))

    if not amount then return end
    
    if amount < 0 then amount = 1 end
    
    if user_id then
        if CheckDrugs(amount,k,v) then
            local price = parseInt(v.value)
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(Config.SellDrugs[k]["item"])*amount <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.tryPayment(user_id, amount * price) then -- PARA COLOCAR PARA PUXAR O DINHEIRO DO Banca TBM SO MUDAR DE "tryPayment" PARA "tryFullPayment"
                    balance[Config.SellDrugs[k]["item"]].amount = parseInt(balance[Config.SellDrugs[k]["item"]].amount) - parseInt(amount)
                    vRP.setSData("chest:"..tostring(k),json.encode(balance))
                    DepositMoney(k,v,amount * price)
                    vRP.giveInventoryItem(user_id,Config.SellDrugs[k]["item"],amount)
                else 
                    TriggerClientEvent("Notify",source,"negato","Denaro insufficiente")
                end
            else
                TriggerClientEvent("Notify",source,"negato","Zaino pieno")
            end
        end
    end
end

function CheckDrugs(amount,k,v)
    local value = vRP.getSData('chest:'..k)
    local balance = json.decode(value) or {}
    local camount = balance[Config.SellDrugs[k]["item"]].amount
    if camount >= amount then
        return true
    else 
        TriggerClientEvent("Notify",source,"negato","Quantità non valida")
        return false
    end
end

function DepositMoney(k,v,payment) 
    local value = vRP.getSData('Bank:'..k)
    local balance = json.decode(value) or 0
    vRP.setSData('Bank:'..k,balance+payment)
end

function CheckBank(amount,k)
    local value = vRP.getSData('Bank:'..k)
    value = tonumber(value)
    if amount <= value then
        return true
    else 
        TriggerClientEvent("Notify",source,"negato","Valore non valido")
        return false
    end
end

RegisterCommand("ritirarefaz", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then 
        
        local amount = vRP.prompt(source, "Importo da prelevare", "")
        
        amount = tonumber(parseInt(amount))
        
        if not amount then return end

        if string.sub(tonumber(amount), 1, 1) == "-" then return end

        if amount < 0 then amount = 1 end
        
        for k,v in pairs(Config.SellDrugs) do

            if vRP.hasPermission(user_id,v.permission) then 
                local balance = vRP.getSData('Bank:'..k)
                local distance = #(GetEntityCoords(GetPlayerPed(source)) - vector3(v.x2,v.y2,v.z2))
                if CheckBank(amount,k) then
                    if distance <= 3 then
                        amount = tonumber(amount)
                        vRP.setSData('Bank:'..k,balance-amount)
                        vRP.giveMoney(user_id,amount)
                        TriggerClientEvent("Notify",source,"successo","Prelievo effettuato con successo")
                    end
                else 
                    TriggerClientEvent("Notify",source,"negato","Valore non valido")
                end
            end
        end
    end
end)

RegisterCommand("saldofac", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then 

        for k,v in pairs(Config.SellDrugs) do

            if vRP.hasPermission(user_id,v.permission) then
                local balance = vRP.getSData('Bank:'..k) or 0 
                TriggerClientEvent("Notify",source,"avviso","Il saldo della tua fazione "  ..balance)
            end
        end
        
        if vRP.hasPermission(user_id,Config.PermAdmin) then
            if Config.SellDrugs[args[1]] then
                local balance = vRP.getSData('Bank:'..args[1]) or 0
            end
        end

    end
end)


