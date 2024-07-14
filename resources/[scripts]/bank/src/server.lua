local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local mrqz = {}
Tunnel.bindInterface(GetCurrentResourceName(), mrqz)
vCl = Tunnel.getInterface(GetCurrentResourceName())

function mrqz.getInfos()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local money = vRP.getBankMoney(user_id)
	Player(source)["state"]["information"] = {
		['bank'] = money, 
		['name'] = identity.name .. ' ' .. identity.firstname,
		['id'] = user_id
	}
end

function mrqz.deposit(qtd)  
    local amount = tonumber(qtd)
    local user_id = vRP.getUserId(source)
    if amount == nil or amount <= 0 or type(amount) == "string" then
        TriggerClientEvent("Notify", source, "negato", "Digita un valore valido")
    elseif amount > vRP.getMoney(user_id) then
        TriggerClientEvent("Notify", source, "negato", Config.notify.deposito.noMoney:format(vRP.format(amount)))
    else
        vRP.tryDeposit(user_id, tonumber(amount))
        TriggerClientEvent("Notify", source, "successo", Config.notify.deposito.success:format(vRP.format(amount)))
        vCl.updateBank(source)
        return {
            method = "+"
        }
    end
end

function mrqz.withdraw(qtd)
    local amount = tonumber(qtd)
    local user_id = vRP.getUserId(source)
    if amount == nil or amount <= 0 then
        TriggerClientEvent("Notify", source, "negato", "Inserire un valore valido.")
    elseif amount > vRP.getBankMoney(user_id) then
        TriggerClientEvent("Notify", source, "negato", Config.notify.saque.noMoney:format(vRP.format(amount)))
    else
        vRP.tryWithdraw(user_id, amount)
        TriggerClientEvent("Notify", source, "successo", Config.notify.saque.success:format(vRP.format(amount)))
        vCl.updateBank(source)
        return {
            method = "-" 
        }
    end
end