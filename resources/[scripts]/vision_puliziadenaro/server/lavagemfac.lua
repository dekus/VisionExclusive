-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPc = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface('lavagemfac',src)
vCLIENT = Tunnel.getInterface('lavagemfac')

local Config = {
	['porcentagem'] = 0.8,
	['minimo'] = 10000,
	['perm'] = 'lavagem.autorizzazione'
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LAVAR
-----------------------------------------------------------------------------------------------------------------------------------------
function src.lavar(perm,x,y,z,h)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, perm) then
		local quantidade = vRP.prompt(source, "Digita la quantità da pulire:", "")


		
		if vRP.getInventoryItemAmount(user_id,"denarosporco") >= parseInt(quantidade) then
			if parseInt(quantidade) >= Config['minimo'] then

				
				local candeggina = math.floor(quantidade / 5000)
				if vRP.tryGetInventoryItem(user_id,"candeggina",candeggina) then
					vRP.tryGetInventoryItem(user_id,"denarosporco",quantidade)		
					vCLIENT.setHeading(source,x,y,z,h)
					TriggerClientEvent('progress', source, 5000, 'Lavando')
					vRPc.playAnim(source, false, {"mp_fbi_heist", "loop"}, true)
					TriggerEvent("cancelando",true)
					vCLIENT.TravarPed(source,true)
					SetTimeout(5000,function()
						vCLIENT.TravarPed(source,false)
						TriggerEvent("cancelando",false)
						vRPc._stopAnim(source,false)
						vRP.giveMoney(user_id,parseInt(quantidade*Config['porcentagem']))
						TriggerClientEvent("Notify",source,"avviso","Ricevuto "..parseInt(quantidade*Config['porcentagem']).." denaro pulito.")
					end)
				else
					TriggerClientEvent("Notify",source,"negato","Non hai abbastanza candeggina. Te ne servono "..candeggina..".")
				end
			else
				TriggerClientEvent("Notify",source,"negato","La quantità minima da lavare è "..vRP.format(Config['minimo'])..".") 
			end

		else
			TriggerClientEvent("Notify",source,"negato","Denaro sporco insufficiente.") 
		end
	else
		if not vRP.hasPermission(user_id, Config['perm']) then
			TriggerClientEvent("Notify",source,"negato","Non tieni il permesso di riciclare il denaro.")
		else
			TriggerClientEvent("Notify",source,"negato","Non tieni il permesso di accedere al lavaggio di questo locale.")
		end
	end
end

	



