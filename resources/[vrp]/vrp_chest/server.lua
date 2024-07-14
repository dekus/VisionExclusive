-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookBAULEpolizias = "https://discord.com/api/webhooks/1130281633421988012/eR4SGdDr9ZofFEABsFpkSDuZzm_5FduU4DCt1MeNOLVXx-PU5hSapgTvxKs7zOvIeig_"
local webhookBAULEpolizias = "https://discord.com/api/webhooks/1131597782029963416/-KRzFPoOq8GUPCe3qKHIvTfpeAUbjQQAjgaru-PBH3su7zB45RG8EntkNCBsjgoR-6Un"
local webhookBAULEgangues = "https://discord.com/api/webhooks/1130281790402203698/I1stD4Q-a_lr2v4yu-EN-I_KZtFtsELz-DsuvearBxkIW113VgqF4hYsKj-pHYK40TJ8"

local webhookBAULEpoliziasul = "https://discord.com/api/webhooks/1131597782029963416/-KRzFPoOq8GUPCe3qKHIvTfpeAUbjQQAjgaru-PBH3su7zB45RG8EntkNCBsjgoR-6Un"
local webhookBAULEpoliziasul = "https://discord.com/api/webhooks/1130281633421988012/eR4SGdDr9ZofFEABsFpkSDuZzm_5FduU4DCt1MeNOLVXx-PU5hSapgTvxKs7zOvIeig_"

local webhookBAULEbloods = "https://discord.com/api/webhooks/1130281917615460412/eI8Wepm0We8ykreotryMs4Ty-3_kqxSoookcQ0ojKWXWOCd-vSxf9OKQXIqEgjFQEBgZ"
local webhookBAULEbloods = "https://discord.com/api/webhooks/1137019075227299851/VAYklP1bNdU2Tsq6zAFeJ6BjaJnXT6ZFqT6AR8gY0EX2Y7dnbmSKBKYHIF0GC9-r1OIe"
local webhookBAULEcrips = "https://discord.com/api/webhooks/1130281996644520027/3WK6gi49kJGOIHkkl4pBAp5azER-0ll5D3LkYpAhhMDosBdln_G10a8DJpp1cfjPgNke"

local webhookBAULEyardie = "https://discord.com/api/webhooks/1130282100122210429/WEf0CwyUCvJNKc6ox-tZkcQ0zXlrmoQay-Jb3GaThA4_egANOAKD3U-EcqSqRZFgfJJ_"
local webhookBAULEsiciliana = "https://discord.com/api/webhooks/1130282199728533634/ihaG_XgutALdjJ1Nr0wmwmH6dPJomaFVqmjwAhOO8cN7Mor68zEUPOFNNnYRXJ0f7fRO"


local webhookBAULEballas = "https://discord.com/api/webhooks/1130282261720354957/LwQ6CN3Mj493LqxlrrA3qmciUjrcUAHXg5B3dicI-Wxa8sGWmEEi756qlaPztRLBLDNP"
local webhookBAULEvagos = "https://discord.com/api/webhooks/1130282476963647568/Fau9eGWX1FtQky8mXr3WhpScbl5aIYMdao3rXdrl0pYG88zYfX65tM3WDs1I_osxbmMW"
local webhookBAULEgrove = "https://discord.com/api/webhooks/1130282557733347368/OaqimUTW2A6e9BpuUuKxgZek48Ssir37-c4AM9Ba2fmgiqqKoskNwUVZ9X9OWBhChfmi"

local webhookBAULEhospital = "https://discord.com/api/webhooks/1130282643209068574/sGtjn0BZm1yTp7kmJogpOO5s7K1bLuFtuqfBIARPFf8B-yDGS936WhmsRSEwUMKVqUpK"
local webhookBAULE = ""


local webhookfarmgroove = "https://discord.com/api/webhooks/1130282746116325397/Nt3uutr96xuO3z6iNEOVv4_lH5NT_NsZ6Iai8YISOSOKtQ575rUsm4bWKVVremD3rbjQ"
local webhookfarmballas = "https://discord.com/api/webhooks/1130282802030587964/O3cR-_kE0wWD3dxeLycQYKsjBybrv1-Sd-B90lYnt0SzMg12fwMmAGAJKoJGUddQFyy0"
local webhookfarmvagos = "https://discord.com/api/webhooks/1130282882234069112/cScv6asmWoeRo0CpHDjvxxr7dwXfa_wMP33FmD2OFvrHEprELdza9lYlLH83MuRWrj3H"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------

local chest = {
	-- polizia
	["Polizia"] = { 50000,"polizia.autorizzazione" },
	-- hospital
	["Hospital"] = { 50000,"medico.autorizzazione" },
	-- drogas
	["Ballas"] = { 50000,"ballas.autorizzazione" },
	["Vagos"] = { 50000,"vagos.autorizzazione" },
	["Grove"] = { 50000,"grove.autorizzazione" },
	-- armas
	["Crips"] = { 50000,"crips.autorizzazione" },
	["Bloods"] = { 50000,"bloods.autorizzazione" },
	-- munição
	["Yardie"] = { 50000,"yardie.autorizzazione" },
	["Siciliana"] = { 50000,"siciliana.autorizzazione" },
	-- lavagem
	["Bahamas"] = { 50000,"bahamas.autorizzazione" },
	["Life Invader"] = { 50000,"life.autorizzazione" },
	-- desmanche
	["Warlocks"] = { 50000,"warlocks.autorizzazione" },
	["HellAngels"] = { 50000,"hells.autorizzazione" },
	-- mecanicas
	["Bennys"] = { 50000,"bennys.autorizzazione" },
	["Mecanico"] = { 50000,"mecanico.autorizzazione" },
	-- scorp
	["Scripted"] = { 50000,"scripted.autorizzazione" },
	-- farms
	["Farmgroove"] = { 25000,"grove.autorizzazione" },
	["Farmballas"] = { 25000,"ballas.autorizzazione" },
	["Farmvagos"] = { 25000,"vagos.autorizzazione" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1

				if actived[k] <= 0 then
					actived[k] = nil
				end
			end
		end
		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK ADM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CheckAdm()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"admin.autorizzazione")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--if not vRP.searchReturn(source,user_id) then
			if chestName == 'bahamas' then 
				if vRP.hasGroup(user_id,'bahamas') then 
					return true 
				end 
			end

			if chestName == 'medico' then
				if user_id == 0 or vRP.hasPermission(user_id, 'admin.autorizzazione') then  
					return true
				else
					return false
				end
			end
			if vRP.hasPermission(user_id,chest[chestName][2]) or vRP.hasPermission(user_id, 'admin.autorizzazione') then
				return true
			end
		--end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])	
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local DelayTirarItem = {}
function src.storeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		local delay = math.random(2,3)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,'importante',"Impossibile salvare questo elemento.")
				return
			end

			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				-- CÓDIGO ANTIDUPE AQUI
				if DelayTirarItem[user_id] and (DelayTirarItem[user_id] + delay) > os.time() then TriggerClientEvent('Notify', source, 'negado','In questo BAULE le transazioni vengono effettuate troppo velocemente.') return end
				DelayTirarItem[user_id] = os.time()
				if parseInt(amount) > 0 then

					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(chest[tostring(chestName)][1]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then

							if chestName == "Polizia" or chestName == "Paramedico" or chestName == "Polizianord" then
								SendWebhookMessage(webhookBAULEpolizias,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." \n[SET]: "..job.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
							else
								if chestName == "Poliziasud" then
									SendWebhookMessage(webhookBAULEpoliziasul,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Ballas" then
									SendWebhookMessage(webhookBAULEballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Vagos" then
									SendWebhookMessage(webhookBAULEvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Grove" then
									SendWebhookMessage(webhookBAULEgrove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Crips" then
									SendWebhookMessage(webhookBAULEcrips,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Warlocks" then
									SendWebhookMessage(webhookBAULEwarlocks,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Bahamas" then
									SendWebhookMessage(webhookBAULEbahamas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Bloods" then
									SendWebhookMessage(webhookBAULEbloods,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")	
								elseif chestName == "Siciliana" then 
									SendWebhookMessage(webhookBAULEsiciliana,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Yardie" then
									SendWebhookMessage(webhookBAULEyardie,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Ospedale" then
									SendWebhookMessage(webhookBAULEhospital,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmballas" then
									SendWebhookMessage(webhookfarmballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmgroove" then
									SendWebhookMessage(webhookfarmgroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmvagos" then
									SendWebhookMessage(webhookfarmvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								end

								SendWebhookMessage(webhookBAULEgangues,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SALVATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
							end

								if items[itemName] ~= nil then
									items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
								else
									items[itemName] = { amount = parseInt(amount) }
								end
								actived[parseInt(user_id)] = 4
							end
						else
							TriggerClientEvent("Notify",source,'negado',"<b>Bale</b> pieno.")
						end
					else
						local inv = vRP.getInventory(parseInt(user_id))
						for k,v in pairs(inv) do
							if itemName == k then
								local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
								if new_weight <= parseInt(chest[tostring(chestName)][1]) then
									if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then
	
										if items[itemName] ~= nil then
											items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
										else
											items[itemName] = { amount = parseInt(v.amount) }
										end

										if chestName == "Polizia" or chestName == "Medico" or chestName == "PoliziaNorte" then
											SendWebhookMessage(webhookBAULEpolizias,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." \n[SET]: "..job.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										else
										if chestName == "PoliziaSul" then
											SendWebhookMessage(webhookBAULEpoliziasul,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Ballas" then
											SendWebhookMessage(webhookBAULEballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Vagos" then
											SendWebhookMessage(webhookBAULEvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Grove" then
											SendWebhookMessage(webhookBAULEgrove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Crips" then
											SendWebhookMessage(webhookBAULEbahamas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Bloods" then
											SendWebhookMessage(webhookBAULEbloods,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")	
										elseif chestName == "Siciliana" then 
											SendWebhookMessage(webhookBAULEsiciliana,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Yardie" then
											SendWebhookMessage(webhookBAULEyardie,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Hospital" then
											SendWebhookMessage(webhookBAULEhospital,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Farmballas" then
											SendWebhookMessage(webhookfarmballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Farmgroove" then
											SendWebhookMessage(webhookfarmgroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										elseif chestName == "Farmvagos" then
											SendWebhookMessage(webhookfarmvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
										end

										SendWebhookMessage(webhookBAULEgangues,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
									end

									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,'negado',"<b>BAULE</b> pieno.")
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		local delay = math.random(3,7)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if DelayTirarItem[user_id] and (DelayTirarItem[user_id] + delay) > os.time() then TriggerClientEvent('Notify', source, 'negado','In questo BAULE le transazioni vengono effettuate troppo velocemente.') return end
				DelayTirarItem[user_id] = os.time()
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "Polizia" or chestName == "Medico" or chestName == "PoliziaNorte" then
								SendWebhookMessage(webhookBAULEpolizias,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." \n[SET]: "..job.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
							else
								if chestName == "PoliziaSul" then
									SendWebhookMessage(webhookBAULEpoliziasul,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Ballas" then
									SendWebhookMessage(webhookBAULEballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Vagos" then
									SendWebhookMessage(webhookBAULEvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Grove" then
									SendWebhookMessage(webhookBAULEgrove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Crips" then
									SendWebhookMessage(webhookBAULEcrips,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Bahamas" then
									SendWebhookMessage(webhookBAULEbahamas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Bloods" then
									SendWebhookMessage(webhookBAULEbloods,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")	
								elseif chestName == "Siciliana" then 
									SendWebhookMessage(webhookBAULEsiciliana,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Yardie" then
									SendWebhookMessage(webhookBAULEyardie,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Hospital" then
									SendWebhookMessage(webhookBAULEhospital,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmballas" then
									SendWebhookMessage(webhookfarmballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmgroove" then
									SendWebhookMessage(webhookfarmgroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmvagos" then
									SendWebhookMessage(webhookfarmvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								end

								SendWebhookMessage(webhookBAULEgangues,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RITIRATO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
							end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)

							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,'negado',"<b>Zaino</b> pieno.")
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "Polizia" or chestName == "Medico" or chestName == "PoliziaNorte" then
								SendWebhookMessage(webhookBAULEpolizias,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MESSO]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." \n[SET]: "..job.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
							else
								if chestName == "PoliziaSul" then
									SendWebhookMessage(webhookBAULEpoliziasul,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Ballas" then
									SendWebhookMessage(webhookBAULEballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Vagos" then
									SendWebhookMessage(webhookBAULEvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Grove" then
									SendWebhookMessage(webhookBAULEgrove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Crips" then
									SendWebhookMessage(webhookBAULEcrips,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Bloods" then
									SendWebhookMessage(webhookBAULEbloods,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")	
								elseif chestName == "Siciliana" then 
									SendWebhookMessage(webhookBAULEsiciliana,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Yardie" then
									SendWebhookMessage(webhookBAULEyardie,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Hospital" then
									SendWebhookMessage(webhookBAULEhospital,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmballas" then
									SendWebhookMessage(webhookfarmballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmgroove" then
									SendWebhookMessage(webhookfarmgroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								elseif chestName == "Farmgvagos" then
									SendWebhookMessage(webhookfarmvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
								end

								SendWebhookMessage(webhookBAULEgangues,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAULE]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S").." \r```")
							end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,'negado',"<b>Zaino</b> pieno.")
						end
					end
				end
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
			end
		end
	end
	return false
end

local BAULEAberto = {}
RegisterServerEvent('lsk:SetarBAULEAberto')
AddEventHandler('lsk:SetarBAULEAberto', function(chestOpen)
	local source = source
	local user_id = vRP.getUserId(source)
	BAULEAberto[chestOpen] = true
end)

RegisterServerEvent('lsk:SetarBAULEFechado')
AddEventHandler('lsk:SetarBAULEFechado', function(chestOpen)
	local source = source
	local user_id = vRP.getUserId(source)
 	BAULEAberto[chestOpen] = false
 end)

 function src.ChecarBAULEAberto(chestOpen)
 	return BAULEAberto[chestOpen]
end