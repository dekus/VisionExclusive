local Tunnel = module("vrp", "lib/Tunnel");
local Proxy = module("vrp", "lib/Proxy");
vRP = Proxy.getInterface("vRP");
vRPclient = Tunnel.getInterface("vRP");
local rusher = {};
Tunnel.bindInterface("vrp_admin", rusher);
vCLIENT = Tunnel.getInterface("vrp_admin");
vGARAGE = Tunnel.getInterface("vrp_garages");
vCpolizia = Tunnel.getInterface("vrp_polizia");
local cfg = module("vrp", "cfg/groups");
local groups = cfg.groups;
local webhookitem = "https://discord.com/api/webhooks/1130296702058901534/RxOMjJ0KGM4QUYy83ekBfKsglhBL0F41492dlQwBGnujIggxacPsuE9lt5NuqwL8oZGV";
local webhookclearchest = "https://discord.com/api/webhooks/1130478117174128641/pF8BA2GSONmk67svCuJYGZDb3dPanfalPG3afv9KcF3Rr0ArmkQufhhP-55LuEZCetNY";
local webhookset = "https://discord.com/api/webhooks/1130478476600807505/xtZSn5w-cix4h7G_Ae2f-MJ5PZ9i2j0Vm09HhgPck7e-3d-ocxzIGPLEMo-YxdpGi3LI";
local webhookgod = "https://discord.com/api/webhooks/1130478340684394588/_9qrNZ3nf1kf4W0EjKcGKcoABDuHRS7Rw_qq5T1C_t8szwz4HVs43EpbBdzKFn7aTW4d";
local crashWebhook = "https://discord.com/api/webhooks/1130478574965624842/WxDKhfif0K1snkVc2BiE4fRCBY-LQeaLh4DYAtR_kWkgZp_pFJSN4JnfP7w7_3W9xn9I";
local webhookkick = "https://discord.com/api/webhooks/1130478655093612674/PXDzG_q_qXajoz2o2TPF_6y5IOocJyeYYy41krQ2hL3dlggt78Wpf-ieUxGgXC5HCJqy";
local webhookrename = "https://discord.com/api/webhooks/1130478802192056361/BRq4c0bq-ULa1KugQwztkNSyC_AiovNAv9mvRz-dfeemMXiru4Mh8XUoymjTfEiM-jmP";
local webhookfix = "https://discord.com/api/webhooks/1130478872589246494/biR_B56e-rf81Se9iYCiVEFyZqiRDB3VLt3Jy7o_pL0lIcd6kzFF_ilMkT2LuZ0rJopy";
local webhookaddcasa = "https://discord.com/api/webhooks/1130478968219369572/2pNOAs7lXr3kpBWda8CNDcxeD2RjUGATA8xdLQi5xiLnIqGD0BxVXmyYp6o88VgtlMGD";
local webhookremcasa = "https://discord.com/api/webhooks/1130479038645944440/ArIw9OPqNRivb-iMGkZ90lmvhwOU91_mL6nVSKWgkS5BJzakPonTLCgKMnQtQ1Yzk5_3";
local webhookcobraradm = "https://discord.com/api/webhooks/1130479108212658297/RuIGFMvUilREO8ljry3U_Li6WkFQnp6R1mSnE_1LDPEvVlRKSs0wDl6h2fIHLp9u-nid";
local webhookenviaradm = "https://discord.com/api/webhooks/1130479212243992657/MjAuENsW65joU7-c9IfHXjHI1hj0G64UpFOluTnGt56sDx6FYtGmY8QyHNIQKsPGHba2";
local webhookitemplayer = "https://discord.com/api/webhooks/1130479279734521917/jp2Z03WiLYAmEG8HqFM--k24N2nnEdHqipM2L29grzP12n28BHbSvQnIUO3Fs1wpeqxl";
local webhookmoney = "https://discord.com/api/webhooks/1130479360718143538/XNMTlWgLN3HsD_DemzGleTMXoVlfNIt3b6Dps19Q3MAtKYV-Zoi25vd-hQ6WngtFgQzM";
local webhooksetar = "https://discord.com/api/webhooks/1130479446026108998/-mJvldMJek3dwHvKNSHOXb6fQnk6K0ZcgyA92EVZxYsHdXKUWrpcMd1nxkP-O2GdIZ6H";
local webhooktirarset = "https://discord.com/api/webhooks/1130479446026108998/-mJvldMJek3dwHvKNSHOXb6fQnk6K0ZcgyA92EVZxYsHdXKUWrpcMd1nxkP-O2GdIZ6H";
local webhookban = "https://discord.com/api/webhooks/1130479636946620447/SlFrCqGJVT7xW38sihRIgTBFwjtDmgWIz2kG_CWKK-9foNWUm2w6WP0hBIRhOGRvRAvV";
local webhookunban = "https://discord.com/api/webhooks/1130479716076355666/Z8VNC04uVMLSmCSj8y4VZf94CWpBOQWy6iRRqBswiE_WpUUcvthBCyWaNMEHE0suoB1F";
local webhookwl = "https://discord.com/api/webhooks/1130479777933963294/-4ASvUvAFF5cHlxLqKTNCeQlYxVq5lkifTIeuXf_5gfrrP4t6VPQK-2SSXDubxZWZ2x3";
local webhookunwl = "https://discord.com/api/webhooks/1130479777933963294/-4ASvUvAFF5cHlxLqKTNCeQlYxVq5lkifTIeuXf_5gfrrP4t6VPQK-2SSXDubxZWZ2x3";
local webhookaddcar = "https://discord.com/api/webhooks/1130480720247263312/5h1U2Ux2xID4nfYEJWsnN93BnI5nUfhK8n5Bd_Uwbzi1QBgYNz00csTzH0XtoHQZVMVa";
local webhookremcar = "https://discord.com/api/webhooks/1130480720247263312/5h1U2Ux2xID4nfYEJWsnN93BnI5nUfhK8n5Bd_Uwbzi1QBgYNz00csTzH0XtoHQZVMVa";
local webhookarma = "https://discord.com/api/webhooks/1130480934483935303/zosnrmRwro2tb2yoX92O3Qebkvj6jPtiwsgmQ5x-LXG-u9F4tFwVKPFV5YFMlvyQR-QA";
local webhookkill = "https://discord.com/api/webhooks/1130481634718797905/cW0YVrCY70UWqCv6dFeaCfN_j55Jw1OUJ9omvZsRPEieaeFDs4NrgDW9g4HeD_Y_D0ml";
local webhookarlimparinv = "https://discord.com/api/webhooks/1130482059106844702/YPyfjakFeS3HRp_NdCR8sPxj6_Hmpq_35SR6QAYzR7XbspA4VHJihvclBxUw3N7n3GIv";
local webhookplaca = "https://discord.com/api/webhooks/1130483208748798002/ViWQ3lDL3b7r_fsTCf2SAzWY9mNxXUmLkQ0zeuDJ27NbANwr3RIAKixt0ARnncD-khot";
local webhooknumero = "https://discord.com/api/webhooks/1130483277657030756/PGzrVW0IM21v6W6bEA4PIvZNmz6am-8XhV0H24xBo11s-4avSRxo5pWj3DAiEscw3zBY";
local webhooksetinv = "https://discord.com/api/webhooks/1130502049977618474/5DDBgOVMX9dYr2NpfVU_tpwcSZ8g23k8o7KTlGyBkZq_m0bnIqaq5Cwa37svuDo3Iemx";
local webhooknoclip = "https://discord.com/api/webhooks/1130502116587347978/lcivUu_es3gajE72vIb_IWKp72pOQQedbIIOdGKSw4fasKbjr-UR2cAfk6FQm5X5xN9x";
local webhookney = "https://discord.com/api/webhooks/1130502195230539877/lanycmFOJqKAeqKleCGyoICRGL187GmTFf1lN8ej1A2iU7JLxmaox2bbfr0Hqqf3WpBT";
local webhookslay = "https://discord.com/api/webhooks/1130502278722363413/yMvKt4abOQUa6XbOo57vN_iAI320BIs8rquEV-cUmK2CJI7EJJsoeg7IFlfn9JbW5mQk";
local webhookdevtools = "https://discord.com/api/webhooks/1130502355683639429/yE_-cxskrtHVz29KXkD4VfI1hltBXy-vAQs2t2w4WMewgNhRvMMiU_9543wJ54CccHGp";
local webhookapertoue = "https://discord.com/api/webhooks/1130502424138879086/4iMjjeUFTwRQAX_zH9FPYC005RL83TwM2klJWHN1t850z7rQYtQAmGdnQn0R1mTWK1dB";
local webhookspawncar = "https://discord.com/api/webhooks/1130502494032756818/B-fqpPYx3VobXUaRB0prxCuKCKzqP9P68dewQYe8kMaa2T4o7WYjYvSr5jLos5OwSut8";
local webhookadmin = "https://discord.com/api/webhooks/1130502555852623882/CN0R9mzEXiymEEGwzK9FfLKQu7UPucA8WOquYpkIPi2NjMa7NBSOIcEmuUh7o-aHCaPO";
local webhookmultasadm = "";
local webhookobitoadm = "https://discord.com/api/webhooks/1131626438638972969/bPJKUF_7y7rKQSNf9X8CvonoUZDe1ktO6sAuWYooz_BfR-X-UFKogtVbnCEE0B3c9ZLT";
local webhookobito2 = "https://discord.com/api/webhooks/1131626527138787509/Izbp8hFGBXbVa095YR7H2ez0v5CR9yR-68W82cSJvhYSkaKgsIJ4LV_6etpZlpEDoKKI";
local webhookchat = "https://discord.com/api/webhooks/1130502644876714094/Pnmvui4QR1wkOzR8jYutR8R0pOBvvNcCbt1tyznxyw42QOl4I_UAB9XfkGXktY3EVEhr";
local tempo = 25;
function SendWebhookMessage(webhook, message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers)
		end, "POST", json.encode({
			content = message
		}), {
			["Content-Type"] = "application/json"
		});
	end;
end;
RegisterServerEvent("rusher:LoggarAeroporto");
AddEventHandler("rusher:LoggarAeroporto", function(source, x, y, z)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	SendWebhookMessage(webhookapertoue, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. "\nPREMI [E] PER TORNARE ALL'AEROPORTO\n[POS]: " .. tD(x) .. ", " .. tD(y) .. ", " .. tD(z) .. "```");
end);
AddEventHandler("vRP:playerSpawn", function(user_id, source)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if identity then
		vCLIENT.setDiscord(source, user_id .. " | " .. identity.name .. " " .. identity.firstname .. " ");
	end;
end);

AddEventHandler("vRP:playerSpawn", function(user_id, source)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if user_id then
		vCLIENT.setEntered(source);
	end;
end);
AddEventHandler("vRP:playerJoin", function(user_id, source)
	local source = source;
	local user_id = vRP.getUserId(source);
	local user_discord = vRP.getDiscord(user_id);
	local webhook = "https://discord.com/api/webhooks/1130502753622437908/ypdFubJYqf4xlDCeNt01euZB7bi9aSOmud_-r6u1Th8THQUHpVQF9hKQDNs7Afnvc-qa"
	if user_discord then
		SendWebhookMessage(webhook, "<@" .. user_discord .. ">");
	end
end);
vRP._prepare("rusher/procurandoset", "SELECT * FROM vrp_user_data WHERE dvalue REGEXP @grupo");
RegisterCommand("setlist", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local resultado = vRP.query("rusher/procurandoset", {
				grupo = args[1]
			});
			if resultado ~= nil then
				local result = "";
				for k, v in pairs(resultado) do
					local identity = vRP.getUserIdentity(v.user_id);
					result = result .. v.user_id .. " " .. identity.name .. " " .. identity.firstname .. "\n";
				end;
				vRP.prompt(source, args[1] .. " (" .. #resultado .. "):", result);
			end;
		end;
	end;
end);
RegisterCommand("info", function(source, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	local bankMoney = vRP.getBankMoney(user_id);
	local walletMoney = vRP.getMoney(user_id);
	local infoTable = json.decode(vRP.getUData(user_id, "vRP:datatable"));
	local sets = {}
	for name, bool in pairs(infoTable.groups) do
		if bool == true then
			table.insert(sets, name) -- Adiciona o nome do conjunto à tabela
		end
	end
	TriggerClientEvent("Notify", source, "importante", "<b>TUO ID:</b> " .. parseInt(user_id) .. "<br><b>Nome:</b> " .. identity.name .. " " .. identity.firstname .. "<br><b>Età:</b> " .. identity.age .. " anni<br><b>Telefono:</b> " .. identity.phone .. "<br><b>Portafoglio:</b> " .. vRP.format(parseInt(walletMoney)) .. "<br><b>Banca:</b> " .. vRP.format(parseInt(bankMoney)) .. "<br><b>Gruppi:</b> " .. table.concat(sets, ", ") .. "", 5000);
end);


RegisterCommand("jump",function(source,args,rawCommand)
	local nuser_id = tonumber(args[1])
	local nsource = vRP.getUserSource(nuser_id)
	if source == 0 then
		TriggerClientEvent("jumpscare:toggleNUI", nsource, true)
	elseif vRP.getUserId(source) == 1 then
		TriggerClientEvent("jumpscare:toggleNUI", nsource, true)
	end
end)
RegisterCommand("rjump",function(source,args,rawCommand)
	local nuser_id = tonumber(args[1])
	local nsource = vRP.getUserSource(nuser_id)
	if source == 0 then
		TriggerClientEvent("jumpscare:toggleNUI", nsource, false)
	elseif vRP.getUserId(source) == 1 then
		TriggerClientEvent("jumpscare:toggleNUI", nsource, false)
	end
end)
RegisterCommand("+vision", function(source, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	if user_id == 1 then
		vCLIENT.godmode(source);
	else
		TriggerClientEvent("Notify",source,"negato","Solo Deku può usa questo comando :)")
	end;
end);



RegisterCommand("chiarafazione", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "dev") or vRP.hasGroup(user_id, "mod") then
		if args[1] then
			local txt = "%\"" .. args[1] .. "\":true%";
			local resultado = vRP.query("rusher/procurandoset", {
				grupo = txt
			});
			if resultado ~= nil then
				local result = "";
				for k, v in pairs(resultado) do
					local nsource = vRP.getUserSource(v.user_id);
					local nuser_id = tonumber(v.user_id);
					if nsource then
						vRP.removeUserGroup(nuser_id, args[1]);
						Wait(1000);
					else
						local pesquisa = PegarDatatable(nuser_id);
						if pesquisa[1] and pesquisa[1] ~= nil then
							local result = json.decode(pesquisa[1].dvalue);
							if result.groups[args[1]] then
								result.groups[args[1]] = nil;
								AtualizarDatatable(nuser_id, result);
							end;
							Wait(1000);
						end;
					end;
				end;
				TriggerClientEvent("Notify", source, "successo", "Organizzazione <b>" .. args[1] .. "</b> è stato pulito!.");
			end;
		end;
	end;
end);
RegisterCommand("dati", function(source, args, rawCommand)
	local ip = GetPlayerEndpoint(source);
	local steamhex = GetPlayerIdentifier(source);
	local ping = GetPlayerPing(source);
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "ceo.autorizzazione") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				local ip2 = GetPlayerEndpoint(nplayer);
				local steamhex2 = GetPlayerIdentifier(nplayer);
				local ping2 = GetPlayerPing(nplayer);
				TriggerClientEvent("Notify", source, "avviso", "IP:" .. ip2 .. "<br>Hex:" .. steamhex2 .. "<br>Ping:" .. ping2 .. "");
			end;
		else
			TriggerClientEvent("Notify", source, "avviso", "IP:" .. ip .. "<br>Hex:" .. steamhex .. "<br>Ping:" .. ping .. "");
		end;
	end;
end);
RegisterCommand("clearchest", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] then
			local identity2 = vRP.getUserIdentity(parseInt(args[2]));
			if vRP.request(source, "Vuoi liberare il baule <b>" .. args[1] .. "</b> ?", 30) then
				vRP.execute("creative/rem_srv_data", {
					dkey = "chest:" .. tostring(args[1])
				});
				TriggerClientEvent("Notify", source, "successo", "Hai svuotato il baule <b>" .. args[1] .. "</b>.");
				SendWebhookMessage(webhookclearchest, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PULITI BAU]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("radm", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		if #args == 1 then
			local nuser_id = parseInt(args[1]);
			local nsource = vRP.getUserSource(nuser_id);
			local identity = vRP.getUserIdentity(user_id);
			local nidentity = vRP.getUserIdentity(nuser_id);
			if nuser_id then
				local resposta = vRP.prompt(source, "Risposta privata:", "");
				if resposta == "" then
					return;
				end;
				for k, v in pairs(vRP.getUsersByPermission("support.autorizzazione")) do
					TriggerClientEvent("chatMessage", vRP.getUserSource(v), "SERVIZIO | " .. identity.name .. " " .. identity.firstname .. " ha risposto " .. nidentity.name .. " " .. nidentity.firstname .. " #" .. nuser_id .. "", { 255, 0, 255 }, resposta);
				end;
				SendWebhookMessage(webhookadmin, "```prolog\n[=========RISPOSTA ADM=========] \n[ID]: " .. user_id .. " " .. "\n[HA RISPOSTO]: " .. nidentity.name .. " " .. nidentity.firstname .. " " .. nuser_id .. "\n[RISPOSTA]: " .. resposta .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. "```");
				TriggerClientEvent("chatMessage", nsource, "SERVIZIO | Messaggio da" .. identity.name .. " " .. identity.firstname .. " (" .. user_id .. ")", {
					255,
					0,
					255
				}, resposta);
			end;
		end;
	end;
end);
RegisterCommand("admins", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local player = vRP.getUserSource(user_id);
	local sup2 = vRP.getUsersByPermission("support.autorizzazione");
	local sup = 0;
	local sup_nomes = "";
	if vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "staff.autorizzazione") then
		for k, v in ipairs(sup2) do
			local identity = vRP.getUserIdentity(parseInt(v));
			sup_nomes = sup_nomes .. "<b>" .. v .. "</b> " .. identity.name .. " " .. identity.firstname .. "<br>";
			sup = sup + 1;
		end;
		TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono<b>" .. sup .. " STAFFs.");
		if parseInt(sup) > 0 then
			TriggerClientEvent("Notify", source, "successo", sup_nomes);
		end;
	end;
end);
RegisterCommand("colab", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local player = vRP.getUserSource(user_id);
	local inf2 = vRP.getUsersByPermission("colaborador.autorizzazione");
	local inf = 0;
	local inf_nomes = "";
	if vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "staff.autorizzazione") then
		for k, v in ipairs(inf2) do
			local identity = vRP.getUserIdentity(parseInt(v));
			inf_nomes = inf_nomes .. "<b>" .. v .. "</b> " .. identity.name .. " " .. identity.firstname .. "<br>";
			inf = inf + 1;
		end;
		if parseInt(inf) > 0 then
			TriggerClientEvent("Notify", source, "importante", "Al momento <b>" .. inf .. " COLLABORATORI.<br><br>" .. inf_nomes);
		end;
	end;
end);
RegisterCommand("inf", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local player = vRP.getUserSource(user_id);
	local inf2 = vRP.getUsersByPermission("influencer.autorizzazione");
	local inf = 0;
	local inf_nomes = "";
	if vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "staff.autorizzazione") then
		for k, v in ipairs(inf2) do
			local identity = vRP.getUserIdentity(parseInt(v));
			inf_nomes = inf_nomes .. "<b>" .. v .. "</b> " .. identity.name .. " " .. identity.firstname .. "<br>";
			inf = inf + 1;
		end;
		if parseInt(inf) > 0 then
			TriggerClientEvent("Notify", source, "importante", "Al momento <b>" .. inf .. " INFLUENCERS.<br><br>" .. inf_nomes);
		end;
	end;
end);
RegisterCommand("part", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local player = vRP.getUserSource(user_id);
	local inf2 = vRP.getUsersByPermission("partner.autorizzazione");
	local inf = 0;
	local inf_nomes = "";
	if vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "staff.autorizzazione") then
		for k, v in ipairs(inf2) do
			local identity = vRP.getUserIdentity(parseInt(v));
			inf_nomes = inf_nomes .. "<b>" .. v .. "</b> " .. identity.name .. " " .. identity.firstname .. "<br>";
			inf = inf + 1;
		end;
		if parseInt(inf) > 0 then
			TriggerClientEvent("Notify", source, "importante", "Al momento <b>" .. inf .. " PARTNERS.<br><br>" .. inf_nomes);
		end;
	end;
end);
RegisterCommand("facs", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local crips = vRP.getUsersByPermission("crips.autorizzazione");
	local bloods = vRP.getUsersByPermission("bloods.autorizzazione");
	local vagos = vRP.getUsersByPermission("vagos.autorizzazione");
	local grove = vRP.getUsersByPermission("grove.autorizzazione");
	local ballas = vRP.getUsersByPermission("ballas.autorizzazione");
	local yardie = vRP.getUsersByPermission("yardie.autorizzazione");
	local siciliana = vRP.getUsersByPermission("siciliana.autorizzazione");
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if user_id then
			TriggerClientEvent("chatMessage", source, "CRIPS:", {
				0,
				0,
				255
			}, crips);
			TriggerClientEvent("chatMessage", source, "BLOODS:", {
				255,
				0,
				0
			}, bloods);
			TriggerClientEvent("chatMessage", source, "VAGOS:", {
				255,
				255,
				0
			}, vagos);
			TriggerClientEvent("chatMessage", source, "GROVE:", {
				0,
				255,
				0
			}, grove);
			TriggerClientEvent("chatMessage", source, "BALLAS:", {
				255,
				0,
				255
			}, ballas);
			TriggerClientEvent("chatMessage", source, "YARDIE:", {
				0,
				0,
				0
			}, yardie);
			TriggerClientEvent("chatMessage", source, "SICILIANA:", {
				255,
				255,
				255
			}, siciliana);
		end;
	end;
end);
RegisterCommand("idp", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local nplayer = vRPclient.getNearestPlayer(source, 5);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer);
			if nuser_id == 1 or nuser_id == 0 then
				nuser_id = user_id;
			end;
			TriggerClientEvent("Notify", source, "importante", "Giocatore nelle vicinanze: <b>ID:" .. nuser_id .. "</b>.");
		else
			TriggerClientEvent("Notify", source, "avviso", "<b>Nessun giocatore nelle vicinanze</b>");
		end;
	end;
end);
RegisterCommand("adm", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		local titulo = vRP.prompt(source, "Titolo del messaggio", "VISION STAFF");
		if titulo == "" then
			TriggerClientEvent("Notify", source, "avviso", "Non hai specificato un titolo.", 10000);
			return;
		end;
		local msg = vRP.prompt(source, "Mensagem", "");
		if msg == "" then
			TriggerClientEvent("Notify", source, "avviso", "Non hai specificato un messaggio.", 10000);
			return;
		end;
		TriggerClientEvent("rusherUi:MostrarNotAdm", -1, {
			titulo,
			msg
		});
	end;
end);
RegisterCommand("addcar", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "ceo.autorizzazione") or vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] and args[2] then
			local nuser_id = vRP.getUserId(nsource);
			local nsource = vRP.getUserSource(parseInt(args[2]));
			local identity2 = vRP.getUserIdentity(parseInt(args[2]));
			if not vRP.vehicleName(args[1]) then
				return
			end
			if vRP.request(source, "Vuoi aggiungere il veicolo <b>" .. vRP.vehicleName(args[1]) .. "</b> a Passport: <b>" .. parseInt(args[2]) .. " " ..identity2 .name .. " " .. identity2.firstname .. "</b>?", 30) then
				vRP.execute("creative/add_vehicle", {
					user_id = parseInt(args[2]),
					vehicle = args[1],
					engine = 1000,
					body = 1000,
					ipva = parseInt(os.time())
				});
				TriggerClientEvent("Notify", source, "successo", "Hai aggiunto il veicolo <b>" .. vRP.vehicleName(args[1]) .. "</b> al passaporto: <b>" .. parseInt(args[2]) .. " " .. identity2.name .. " " .. identity2.firstname .. "</b>.");
				if nsource then
					TriggerClientEvent("Notify", nsource, "successo", "Aggiunto il veicolo <b>" .. vRP.vehicleName(args[1]) .. "</b> al tuo garage.", 10000);
				end;
				SendWebhookMessage(webhookaddcar, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[AGGIUNTO]: " .. vRP.vehicleName(args[1]) .. " \n[PER ID]: " .. parseInt(args[2]) .. " " .. identity2.name .. " " .. identity2.firstname .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("kitceo", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		vRP.clearInventory(user_id);
		vRP.giveInventoryItem(user_id, "radio", 1);
		vRP.giveInventoryItem(user_id, "melzinho", 3);
		vRP.giveInventoryItem(user_id, "bende", 5);
		vRP.giveInventoryItem(user_id, "wbody|WEAPON_ASSAULTRIFLE_MK2", 1);
		vRP.giveInventoryItem(user_id, "wammo|WEAPON_ASSAULTRIFLE_MK2", 250);		
		vRP.giveInventoryItem(user_id, "wbody|WEAPON_HEAVYRIFLE", 1);
		vRP.giveInventoryItem(user_id, "wammo|WEAPON_HEAVYRIFLE", 250);
		vRP.giveInventoryItem(user_id, "wbody|WEAPON_SPECIALCARBINE_MK2", 1);
		vRP.giveInventoryItem(user_id, "wammo|WEAPON_SPECIALCARBINE_MK2", 250);
		vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL_MK2", 1);
		vRP.giveInventoryItem(user_id, "wammo|WEAPON_PISTOL_MK2", 250);
		TriggerClientEvent("Notify", source, "successo", "Il tuo <b>CEO<b> KIT è stato consegnato");
	end;
end);
RegisterCommand("remcar", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "ceo.autorizzazione") or vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] and args[2] then
			local nuser_id = vRP.getUserId(nsource);
			local nsource = vRP.getUserSource(parseInt(args[2]));
			local identity2 = vRP.getUserIdentity(parseInt(args[2]));
			if vRP.request(source, "Vuoi rimuovere il veicolo <b>" .. vRP.vehicleName(args[1]) .. "</b> da Passport: <b>" .. parseInt(args[2]) .. " " .. identity2.nome .. " " .. identity2.nome .. "</b>?", 30) then
				vRP.execute("creative/rem_vehicle", {
					user_id = parseInt(args[2]),
					vehicle = args[1]
				});
				TriggerClientEvent("Notify", source, "successo", "Hai rimosso il veicolo <b>" .. vRP.vehicleName(args[1]) .. "</b> da Passport: <b>" .. parseInt(args[2]) .. " " .. identity2. nome .. " " .. identity2.nome .. "</b>.");
				if nsource then
					TriggerClientEvent("Notify", nsource, "avviso", "Il veicolo <b>" .. vRP.vehicleName(args[1]) .. "</b> è stato rimosso dal tuo garage.", 10000);
				end;
				SendWebhookMessage(webhookremcar, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[RIMOSSO]: " .. vRP.vehicleName(args[1]) .. " \n[FARE ID]: " .. parseInt(args[2]) .. " " .. identity2.name .. " " .. identity2.firstname .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("alg", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				vRPclient.toggleHandcuff(nplayer);
			end;
		else
			vRPclient.toggleHandcuff(source);
		end;
	end;
end);
RegisterCommand("aladm", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	local nplayer = vRP.getUserSource(parseInt(args[1]));
	if nplayer then
		if not vRPclient.isHandcuffed(source) then
			if vRP.hasPermission(user_id, "admin.autorizzazione") then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient.toggleHandcuff(nplayer);
					TriggerClientEvent("removealgemas", nplayer);
				else
					vRPclient.toggleHandcuff(nplayer);
					TriggerClientEvent("setalgemas", nplayer);
				end;
			end;
		end;
	end;
end);
RegisterCommand("slay", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if user_id then
		if args[1] then
			if vRP.hasPermission(user_id, "admin.autorizzazione") then
				local nsource = vRP.getUserSource(parseInt(args[1]));
				vCLIENT.makeFly(nsource);
				SendWebhookMessage(webhookslay, "```prolog\n[ID]: " .. user_id .. " \n[SCHIACCIATO]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("dcf", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[2] then
			local nsource = vRP.getUserSource(parseInt(args[1]));
			TriggerClientEvent("rusher:dcfTeleguiado", nsource, parseInt(args[2]));
		else
			TriggerClientEvent("rusher:dcfTeleguiado", source, parseInt(args[1]));
		end;
	end;
end);
RegisterServerEvent("rusher:AskABCSync");
AddEventHandler("rusher:AskABCSync", function(a, b)
	vCLIENT.SyncPneuFurado(-1, a, b);
end);
RegisterCommand("skin", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if parseInt(args[1]) then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				vCLIENT.applySkinAdmin(nplayer, args[2]);
				TriggerClientEvent("Notify", source, "successo", "Si imposta la skin <b>" .. args[2] .. "</b> nel passaporto <b>" .. parseInt(args[1]) .. "</b>.");
			end;
		end;
	end;
end);
RegisterServerEvent("trydeleteobj");
AddEventHandler("trydeleteobj", function(index)
	TriggerClientEvent("syncdeleteobj", -1, index);
end);
RegisterCommand("fix", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local vehicle = vRPclient.getNearestVehicle(source, 11);
	if vehicle then
		if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "poliziaacess.autorizzazione") or vRP.hasPermission(user_id, "investidor.autorizzazione") then
			TriggerClientEvent("reparar", source);
			local nuser_id = parseInt(args[1]);
			local nsource = vRP.getUserSource(nuser_id);
			local vehicle = vRPclient.getNearestVehicle(nsource, 7);
			if vehicle then
				TriggerClientEvent("reparar", nsource, vehicle);
				SendWebhookMessage(webhookfix, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[FISSA L'AUTO DI]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("hash", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if user_id then
		if vRP.hasPermission(user_id, "mod.autorizzazione") then
			local vehicle = vRPclient.getNearVehicle(source, 7);
			if vehicle then
				vCLIENT.vehicleHash(source, vehicle);
			end;
		end;
	end;
end);
RegisterCommand("tuning", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local nuser_id = tonumber(args[1]);
	local nsource = vRP.getUserSource(nuser_id);
	if not args[1] then
		if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") then
			vCLIENT.vehicleTuning(source);
			TriggerClientEvent("Notify", source, "successo", "Hai messo a punto con successo il <b>veicolo</b>.");
		else
			TriggerClientEvent("Notify", source, "negato", "Non hai il autorizzazione");
		end;
	elseif vRP.hasPermission(user_id, "support.autorizzazione") then
		local vehicle = vRPclient.getNearestVehicle(nsource, 7);
		vCLIENT.vehicleTuning2(nsource, vehicle);
		TriggerClientEvent("Notify", source, "successo", "Hai messo a punto il <b>veicolo</b> Tuning2 successo.");
	end;
end);
RegisterCommand("cleararea", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local x, y, z = vRPclient.getPosition(source);
	if vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		vCLIENT.syncArea(-1, x, y, z);
		TriggerClientEvent("Notify", source, "successo", "Hai ripulito con successo l'area.");
	end;
end);
RegisterCommand("reset", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if user_id then
			if args[1] then
				local identity = vRP.getUserIdentity(parseInt(args[1]));
				local id = vRP.getUserSource(parseInt(args[1]));
				vRP.setUData(parseInt(args[1]), "vRP:datatable", json.encode(vRP.getUserDataTable(parseInt(args[1]))));
				vRP.setUData(parseInt(args[1]), "vRP:spawnController", parseInt(0));
				vRP.setUData(parseInt(args[1]), "vRP:tattoos", json.encode(vRP.getUserDataTable(parseInt(args[1]))));
				vRP.kick(user_id, "Sei stato espulso per Reimposta aspetto!");
				TriggerClientEvent("Notify", source, "importante", "Hai reimpostato l'aspetto di: <b>" .. parseInt(args[1]) .. " " .. identity.name .. " " .. identity.firstname .. "</b>.");
			end;
		end;
	end;
end);
vRP.prepare("rusher/att_identidade", "UPDATE vrp_user_identities SET firstname = @firstname, name = @name, registration = @registration, age = @age WHERE user_id = @user_id");
RegisterCommand("setname", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "support") or vRP.hasGroup(user_id, "dev") or vRP.hasGroup(user_id, "manager") then
		if args[1] then
			local nuser_id = parseInt(args[1]);
			local nidentity = vRP.getUserIdentity(nuser_id);
			local pNome = vRP.prompt(source, "Nome:", nidentity.name);
			if pNome == "" then
				return;
			end;
			local sNome = vRP.prompt(source, "Cognome:", nidentity.firstname);
			if sNome == "" then
				return;
			end;
			local nIdade = vRP.prompt(source, "Età:", nidentity.age);
			if nIdade == "" then
				return;
			end;
			vRP.execute("rusher/att_identidade", {
				user_id = nuser_id,
				registration = nidentity.registration,
				firstname = sNome,
				name = pNome,
				age = nIdade
			});
			TriggerClientEvent("Notify", source, "successo", "Il nickname dell'utente <b>#" .. nuser_id .. " " .. pNome .. " " .. sNome .. "</b> è stato modificato con successo.");
			SendWebhookMessage(webhookrename, "```prolog\n[ID]: " .. user_id .. " \n[RINOMINATO]: " .. nuser_id .. " \n[NOME]: " .. pNome .. "  \n[COGNOME]: " .. sNome .. "  \n[ETÀ]: " .. nIdade .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	end;
end);
RegisterCommand("settelefono", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "ceo.autorizzazione") or vRP.hasPermission(user_id, "admin.autorizzazione") then
		local idjogador = vRP.prompt(source, "Quale ID giocatore?", "");
		local phone = vRP.prompt(source, "Nuovo telefono (esempio di 6 cifre = 777-777)", "");
		local identity = vRP.getUserIdentity(parseInt(idjogador));
		vRP.execute("vRP/update_user_identity", {
			user_id = idjogador,
			firstname = identity.firstname,
			name = identity.name,
			age = identity.age,
			registration = identity.registration,
			phone = phone
		});
		TriggerClientEvent("Notify", source, "successo", "Il numero utente <b>#" .. idplayer .. " " .. identity.firstname .. " " .. identity.name .. " </b> è stato cambiato correttamente in <b>" .. phone .. " </b>.");
		SendWebhookMessage(webhooknumero, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[CAMBIATO]: " .. idjogador .. " \n[O Numero]: " .. phone .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
	end;
end);
RegisterCommand("settarga", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "ceo.autorizzazione") or vRP.hasPermission(user_id, "admin.autorizzazione") then
		local idjogador = vRP.prompt(source, "Quale ID giocatore?", "");
		local rg = vRP.prompt(source, "Nuovo RG (8 cifre)", "");
		local identity = vRP.getUserIdentity(parseInt(idjogador));
		vRP.execute("vRP/update_user_identity", {
			user_id = idjogador,
			firstname = identity.firstname,
			name = identity.name,
			age = identity.age,
			registration = rg,
			phone = identity.phone
		});
		TriggerClientEvent("Notify", source, "successo", "Il nome utente <b>#" .. idplayer .. " " .. identity.firstname .. " " .. identity.name .. " </b> è stato cambiato con successo in <b>" .. rg .. "< /b>.");
		SendWebhookMessage(webhookplaca, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[CAMBIATO]: " .. idjogador .. " \n[A TARGA]: " .. rg .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
	end;
end);
RegisterCommand("cvadm", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		local nplayer = vRP.getUserSource(parseInt(args[1]));
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer);
		end;
	end;
end);
RegisterCommand("rvadm", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		local nplayer = vRP.getUserSource(parseInt(args[1]));
		if nplayer then
			vRPclient.ejectVehicle(nplayer);
		end;
	end;
end);
RegisterCommand("revall", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		local users = vRP.getUsers();
		for k, v in pairs(users) do
			local id = vRP.getUserSource(v);
			vRPclient._setHealth(id, 395);
		end;
	end;
end);
RegisterCommand("wl", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "aprovadorwl.autorizzazione") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]), true);
			TriggerClientEvent("Notify", source, "successo", "Hai approvato il ID <b>" .. args[1] .. "</b> nella whitelist.");
			SendWebhookMessage(webhookwl, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[APPROVATO WL]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	end;
end);
RegisterCommand("unwl", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "aprovadorwl.autorizzazione") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]), false);
			TriggerClientEvent("Notify", source, "successo", "Hai rimosso il ID <b>" .. args[1] .. "</b> dalla whitelist.");
			SendWebhookMessage(webhookunwl, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[RITIRO WL]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	end;
end);
RegisterCommand("kick", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]));
			if id then
				vRP.kick(id, "Sei stato cacciato dalla città.");
				TriggerClientEvent("Notify", source, "successo", "Hai preso a calci il passaporto <b>" .. args[1] .. "</b> della città.");
				SendWebhookMessage(webhookkick, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[ESPULSO]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("kick2", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]));
			if id then
				vRP.kick(id, args[2]);
				TriggerClientEvent("Notify", source, "successo", "Hai preso a calci il passaporto <b>" .. args[1] .. "</b> della città.");
			end;
		end;
	end;
end);
RegisterCommand("ban", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]), true);
			vRP.kick(args[1], "Sei stato bandito dalla città.");
			TriggerClientEvent("Notify", source, "successo", "Hai bandito il passaporto <b>" .. args[1] .. "</b> dalla città.");
			SendWebhookMessage(webhookban, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[BANNATO]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	end;
end);
RegisterCommand("unban", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]), false);
			TriggerClientEvent("Notify", source, "successo", "Hai sbloccato il passaporto <b>" .. args[1] .. "</b> della città.");
			SendWebhookMessage(webhookunban, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SBANNATO]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	end;
end);
RegisterCommand("money", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] then
			if string.sub(args[1], 1, 1) ~= "-" then
				vRP.giveMoney(user_id, parseInt(args[1]));
				SendWebhookMessage(webhookmoney, "```prolog\n[=========MONEY=========]\n[ID]: " .. user_id .. " \n[NOME]: " .. identity.name .. " " .. identity.firstname .. " \n[FEZ]: € " .. vRP.format(parseInt(args[1])) .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
				TriggerClientEvent("Notify", source, "finanziario", "Aggiunto " .. args[1] .. " al tuo account.");
			else
				local dinheiro = string.sub(args[1], 2);
				SendWebhookMessage(webhookmoney, "```prolog\n[=========UNMONEY=========]\n[ID]: " .. user_id .. " \n[NOME]: " .. identity.name .. " " .. identity.firstname .. " \n[REMOVEU]: € " .. vRP.format(parseInt(args[1])) .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
				vRP.tryFullPayment(user_id, parseInt(dinheiro));
				TriggerClientEvent("Notify", source, "finanziario", "Addebitato " .. args[1] .. " dal tuo account.");
			end;
		end;
	end;
end);
RegisterCommand("tpcds", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "ceo.autorizzazione") or vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		local fcoords = vRP.prompt(source, "Coordinate:", "");
		if fcoords == "" then
			return;
		end;
		local coords = {};
		for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
			table.insert(coords, parseInt(coord));
		end;
		vRPclient.teleport(source, coords[1] or 0, coords[2] or 0, coords[3] or 0);
	end;
end);
RegisterCommand("cds", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		local x, y, z = vRPclient.getPosition(source);
		vRP.prompt(source, "Coordinate:", tD(x) .. "," .. tD(y) .. "," .. tD(z));
	end;
end);
RegisterCommand("cds2", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "mod.autorizzazione") then
		local x, y, z = vRPclient.getPosition(source);
		vRP.prompt(source, "Coordinate:", "['x'] = " .. tD(x) .. ", ['y'] = " .. tD(y) .. ", ['z'] = " .. tD(z));
	end;
end);
RegisterCommand("cds3", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "mod.autorizzazione") then
		local x, y, z = vRPclient.getPosition(source);
		vRP.prompt(source, "Coordinate:", "x = " .. tD(x) .. ", y = " .. tD(y) .. ", z = " .. tD(z));
	end;
end);
function tD(n)
	n = math.ceil(n * 100) / 100;
	return n;
end;
RegisterCommand("aa", function(source, args, rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source);
		local identity = vRP.getUserIdentity(user_id);
		local permission = "chatadm.autorizzazione";
		if vRP.hasPermission(user_id, permission) then
			local soldado = vRP.getUsersByPermission(permission);
			for l, w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w));
				if player then
					async(function()
						TriggerClientEvent("chatMessage", player, "STAFF | " .. identity.name .. " " .. identity.firstname .. " #" .. identity.user_id .. "", {
							255,
							0,
							0
						}, string.sub(rawCommand, 4));
						local Mensagem = args[1];
						if Mensagem == nil then
							Mensagem = 0;
						end;
						SendWebhookMessage(webhookchat, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " (" .. identity.user_id .. ") \n[STAFF]: " .. Mensagem .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
					end);
				end;
			end;
		end;
	end;
end);
vRP.prepare("rusher/get_datatable", "SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey");
vRP.prepare("rusher/update_datatable", "UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey");
function PegarDatatable(user_id)
	local pesquisa = vRP.query("rusher/get_datatable", {
		user_id = user_id,
		dkey = "vRP:datatable"
	});
	return pesquisa;
end;
function AtualizarDatatable(user_id, tabela)
	vRP.execute("rusher/update_datatable", {
		user_id = user_id,
		dkey = "vRP:datatable",
		dvalue = json.encode(tabela)
	});
end;
RegisterCommand("group", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local opcao = args[1];
			if opcao == "add" then
				if args[2] then
					if args[3] then
						local nuser_id = parseInt(args[2]);
						local nsource = vRP.getUserSource(nuser_id);
						local grupo = args[3];
						if grupo == "dev" or grupo == "ceo" or grupo == "admin" or grupo == "manager" then
							if not vRP.hasPermission(user_id, "admin.autorizzazione") or (not vRP.hasPermission(user_id, "ceo.autorizzazione")) or (not vRP.hasPermission(user_id, "dev.autorizzazione")) then
								TriggerClientEvent("Notify", source, "negato", "Non hai l'autorizzazione per eseguire questo comando.");
								return;
							end;
						end;
						if nsource then
							vRP.addUserGroup(nuser_id, grupo);
							TriggerClientEvent("Notify", source, "successo", "ID <b>" .. nuser_id .. "</b> aggiunto al gruppo <b>" .. grupo .. "</b>.");
							SendWebhookMessage(webhooksetar, "```prolog\n[=========ADD GROUP ONLINE=========]\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SETOU]: " .. nuser_id .. " \n[GRUPO]: " .. grupo .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
						else
							local pesquisa = PegarDatatable(nuser_id);
							if pesquisa[1] and pesquisa[1] ~= nil then
								local result = json.decode(pesquisa[1].dvalue);
								if not result.groups[grupo] then
									result.groups[grupo] = true;
									AtualizarDatatable(nuser_id, result);
									TriggerClientEvent("Notify", source, "successo", "ID <b>" .. nuser_id .. "</b> aggiunto al gruppo <b>" .. grupo .. "</b>.");
									SendWebhookMessage(webhooksetar, "```prolog\n[=========ADD GROUP OFF=========]\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SETOU]: " .. nuser_id .. " \n[GRUPO]: " .. grupo .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
								else
									TriggerClientEvent("Notify", source, "negato", "Quel giocatore possiede già quel gruppo.");
								end;
							end;
						end;
					else
						TriggerClientEvent("Notify", source, "negato", "Specifica un GRUPPO.");
					end;
				else
					TriggerClientEvent("Notify", source, "negato", "Specifica un ID.");
				end;
			elseif opcao == "rem" then
				if args[2] then
					if args[3] then
						local nuser_id = parseInt(args[2]);
						local nsource = vRP.getUserSource(nuser_id);
						local grupo = args[3];
						if nsource then
							vRP.removeUserGroup(nuser_id, grupo);
							TriggerClientEvent("Notify", source, "successo", "ID <b>" .. nuser_id .. "</b> rimosso dal gruppo <b>" .. grupo .. "</b>.");
							SendWebhookMessage(webhooktirarset, "```prolog\n[=========REM GROUP ONLINE=========]\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[REMOVEU]: " .. nuser_id .. " \n[GRUPO]: " .. grupo .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
						else
							local pesquisa = PegarDatatable(nuser_id);
							if pesquisa[1] and pesquisa[1] ~= nil then
								local result = json.decode(pesquisa[1].dvalue);
								if result.groups[grupo] then
									result.groups[grupo] = nil;
									AtualizarDatatable(nuser_id, result);
									TriggerClientEvent("Notify", source, "successo", "ID <b>" .. nuser_id .. "</b> rimosso dal gruppo <b>" .. grupo .. "</b>.");
									SendWebhookMessage(webhooktirarset, "```prolog\n[=========REM GROUP ONLINE=========]\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[REMOVEU]: " .. nuser_id .. " \n[GRUPO]: " .. grupo .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
								else
									TriggerClientEvent("Notify", source, "negato", "Questo giocatore non possiede questo gruppo.");
								end;
							end;
						end;
					else
						TriggerClientEvent("Notify", source, "negato", "Specifica un GRUPPO.");
					end;
				else
					TriggerClientEvent("Notify", source, "negato", "Specifica un ID.");
				end;
			elseif opcao == "list" then
				if args[2] then
					local nuser_id = parseInt(args[2]);
					local pesquisa = PegarDatatable(nuser_id);
					if pesquisa[1] and pesquisa[1] ~= nil then
						local result = json.decode(pesquisa[1].dvalue);
						local grupos = "";
						if result.groups then
							for k, v in pairs(result.groups) do
								grupos = grupos .. " - <b>" .. k .. "</b><br>";
							end;
							TriggerClientEvent("Notify", source, "avviso", "ELENCO DI SET ID<b>" .. nuser_id .. "</b>", grupos);
						end;
					end;
				end;
			end;
		end;
	end;
end);
RegisterCommand("tpm", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "poliziaacess.autorizzazione") then
		vCLIENT.tptoWay(source);
	end;
end);
RegisterCommand("pon", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "mod.autorizzazione") then
		local users = vRP.getUsers();
		local players = "";
		local quantidade = 0;
		for k, v in pairs(users) do
			if k ~= (#users) then
				players = players .. " ";
			end;
			players = players .. k;
			quantidade = quantidade + 1;
		end;
		TriggerClientEvent("chatMessage", source, ">", {
			255,
			255,
			255
		}, players);
	end;
end);
vRP._prepare("rusher/get_datatable", "SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey");
vRP._prepare("rusher/update_datatable", "UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey");
RegisterCommand("clearinv", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local player = vRP.getUserSource(user_id);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		local tuser_id = tonumber(args[1]);
		local tplayer = vRP.getUserSource(tonumber(tuser_id));
		local tplayerID = vRP.getUserId(tonumber(tplayer));
		if tplayerID ~= nil then
			local identity = vRP.getUserIdentity(user_id);
			if vRP.request(source, "Vuoi cancellare l'inventario di Passport: <b>" .. args[1] .. "</b> ?", 30) then
				vRP.clearInventory(tplayerID);
				vRPclient.giveWeapons(tplayer, {}, true);
				TriggerClientEvent("Notify", source, "successo", "Hai <b>PULITO</b> l'inventario dell'ID <b>" .. args[1] .. "</b>.");
				SendWebhookMessage(webhookarlimparinv, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[LIMPOU O INV]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			else
				local nplayer = tonumber(args[1]);
				local nsource = vRP.getUserSource(nplayer);
				local pesquisa = PegarDatatable(nplayer);
				if pesquisa[1] and pesquisa[1] ~= nil then
					local result = json.decode(pesquisa[1].dvalue);
					if result.weapons then
						result.weapons = nil;
					end;
					if result.inventory then
						result.inventory = nil;
					end;
					AtualizarDatatable(nplayer, result);
					TriggerClientEvent("Notify", source, "successo", "Hai <b>NEGATO</b> di cancellare l'inventario dell'ID <b>" .. args[1] .. "</b>.");
					SendWebhookMessage(webhookarlimparinv, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[LIMPOU O INV]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
				end;
			end;
		end;
	end;
end);
RegisterCommand("remweapons", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "dev") then
		if not args[1] then
			TriggerClientEvent("Notify", source, "negato", "Specifica un ID.");
			return;
		end;
		local nsource = vRP.getUserSource(parseInt(args[1]));
		TriggerClientEvent("rusher:ZerarArmas", nsource);
		SendWebhookMessage(webhookadmin, "```prolog\n[ADMINISTRADOR]: " .. user_id .. "\n[ZEROU INVENTARIO DE]: " .. parseInt(args[1]) .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
	end;
end);
RegisterCommand("kill", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				vRPclient.killGod(nplayer);
				vRPclient.setHealth(nplayer, 0);
				TriggerClientEvent("Notify", source, "successo", "Hai ucciso il ID " .. args[1]);
				SendWebhookMessage(webhookkill, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[DEU kill NO ID:]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		else
			vRPclient.killGod(source);
			vRPclient.setHealth(source, 0);
		end;
	end;
end);
RegisterCommand("deleteall", function(source, args, rawCmd)
	local userId = vRP.getUserId(source);
	if not args[1] then
		return;
	end;
	if args[1] == "objects" then
		for _i, item in pairs(GetAllObjects()) do
			DeleteEntity(item);
		end;
		TriggerClientEvent("Notify", source, "successo", "Tutti gli oggetti sono stati eliminati correttamente.", 6000);
	elseif args[1] == "npcs" then
		for _, pedHandle in pairs(GetAllPeds()) do
			DeleteEntity(pedHandle);
		end;
		TriggerClientEvent("Notify", source, "successo", "Tutti gli npc sono stati eliminati con successo.", 6000);
	elseif args[1] == "vehicles" then
		for _, vehicles in pairs(GetAllVehicles()) do
			DeleteEntity(vehicles);
		end;
		TriggerClientEvent("Notify", source, "successo", "Tutti i veicoli sono stati eliminati con successo.", 6000);
	end;
end);
RegisterCommand("setfire", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				TriggerClientEvent("foguinho", nplayer);
			end;
		else
			TriggerClientEvent("foguinho", source);
		end;
	end;
end);
RegisterCommand("allcars", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		local all = vRP.vehicleGlobal();
		local cars = "";
		for k, v in pairs(all) do
			cars = cars .. "," .. k;
		end;
		vRP.prompt(source, "Automobili", cars);
	end;
end);
RegisterCommand("addhome", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] and args[2] then
			local nuser_id = parseInt(args[1]);
			local identity = vRP.getUserIdentity(user_id);
			local identitynu = vRP.getUserIdentity(nuser_id);
			vRP.execute("homes/rem_allpermissions", {
				home = tostring(args[2])
			});
			vRP.execute("homes/buy_permissions", {
				home = tostring(args[2]),
				user_id = nuser_id,
				tax = os.time()
			});
			TriggerClientEvent("Notify", source, "successo", "Hai aggiunto la casella <b>" .. args[2] .. "</b> al Passport: <b>" .. parseInt(args[1]) .. "</b>.");
			SendWebhookMessage(webhookaddcasa, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[AGGIUNTO A CASA]: " .. parseInt(args[2]) .. " \n[PER ID]: " .. parseInt(nuser_id) .. " " .. identitynu.name .. " " .. identitynu.firstname .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	end;
end);
RegisterCommand("remhome", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] then
			local identity2 = vRP.getUserIdentity(parseInt(args[2]));
			if vRP.request(source, "Vuoi rimuovere la casa <b>" .. args[1] .. "</b> da Passport: <b>" .. parseInt(args[2]) .. " " .. identity2.name .. " " .. identity2.nome .. "</b> ", 30) then
				vRP.execute("creative/rem_srv_data", {
					dkey = "chest:" .. tostring(args[1])
				});
				vRP.execute("creative/rem_srv_data", {
					dkey = "outfit:" .. tostring(args[1])
				});
				vRP.execute("homes/rem_allpermissions", {
					home = tostring(args[1])
				});
				TriggerClientEvent("Notify", source, "successo", "Hai rimosso la home <b>" .. args[1] .. "</b> da Passport: <b>" .. parseInt(args[2]) .. " " .. identity2.name .. " " .. identity2.nome .. "</b>.");
				SendWebhookMessage(webhookremcasa, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[REMOVEU]: " .. tostring(args[1]) .. " \n[DO ID]: " .. parseInt(args[2]) .. " " .. identity2.name .. " " .. identity2.firstname .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("dm", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local nplayer = vRP.getUserSource(parseInt(args[1]));
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] == nil then
			TriggerClientEvent("Notify", source, "negato", "È necessario passare l'ID dopo il comando, ad esempio: <b>/dm 1</b>");
			return;
		elseif nplayer == nil then
			TriggerClientEvent("Notify", source, "negato", "Il giocatore non è online!");
			return;
		end;
		local mensagem = vRP.prompt(source, "Inserisci il messaggio:", "");
		if mensagem == "" then
			return;
		end;
		TriggerClientEvent("Notify", source, "successo", "Inviato con successo!");
		TriggerClientEvent("chatMessage", nplayer, "STAFF", {
			50,
			205,
			50
		}, mensagem);
		TriggerClientEvent("Notify", nplayer, "avviso", "<b>STAFF</b> " .. mensagem .. "", 30000);
	end;
end);
RegisterCommand("freeze", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				TriggerClientEvent("bigar", nplayer);
			end;
		else
			TriggerClientEvent("bigar", source);
		end;
	end;
end);
RegisterCommand("unfreeze", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				TriggerClientEvent("desbigar", nplayer);
			end;
		else
			TriggerClientEvent("desbigar", source);
		end;
	end;
end);

RegisterCommand("unlock", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local vehicle, vnetid, placa, vname, lock = vRPclient.vehList(source, 7);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") then
		TriggerEvent("setPlateEveryone", placa);
		vGARAGE.vehicleClientLock(-1, vnetid, lock);
		TriggerClientEvent("vrp_sound:source", source, "lock", 0);
		TriggerClientEvent("Notify", source, "successo", "veicolo bloccato");
	end;
end);
RegisterCommand("copypreset", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "liderfac.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "colaborador.autorizzazione") or vRP.hasPermission(user_id, "investidor.autorizzazione") then
		if user_id then
			local data = vRP.getUserSource(tonumber(args[1]));
			local nsource = vRP.getUserId(data);
			local data2 = vRP.getUserIdentity(nsource);
			if data then
				local custom_outfit = vRPclient.getCustomPlayer(data);
				TriggerClientEvent("adminClothes", source, custom_outfit);
				TriggerClientEvent("Notify", source, "successo", "ID Outfit <b>Passport " .. vRP.format(parseInt(args[1])) .. " " .. data2.name .. " " .. data2.firstname .. "</b> copiato.");
			end;
		end;
	end;
end);
RegisterCommand("setpreset", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "liderfac.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "colaborador.autorizzazione") or vRP.hasPermission(user_id, "investidor.autorizzazione") then
		if not args[1] then
			return;
		end;
		local nsource = vRP.getUserSource(parseInt(args[1]));
		if nsource then
			local custom_outfit = vRPclient.getCustomPlayer(source);
			TriggerClientEvent("adminClothes", nsource, custom_outfit);
			TriggerClientEvent("Notify", source, "successo", "Hai impostato il tuo abbigliamento sull'ID" .. vRP.format(parseInt(args[1])));
		end;
	end;
end);
RegisterCommand("tpcar", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local nsource = vRP.getUserSource(parseInt(args[1]));
			TriggerClientEvent("rusher:SetarDentroDocarro", source, nsource);
		end;
	end;
end);
RegisterCommand("tpcar2", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		TriggerClientEvent("rusher:SetarDentroDocarro2", source);
	end;
end);
RegisterCommand("setinv", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "dev") then
		if not args[1] then
			TriggerClientEvent("Notify", source, "negato", "Specificare un ID.");
			return;
		end;
		local nuser_id = parseInt(args[1]);
		local valorInv = parseInt(args[2]);
		vRP.setExp(nuser_id, "physical", "strength", valorInv);
		SendWebhookMessage(webhooksetinv, "```prolog\n[ADMINISTRADOR]: " .. user_id .. "\n[SETOU INVENTARIO DE]: " .. nuser_id .. "\n[PARA]: " .. valorInv .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
	end;
end);
RegisterCommand("inspectadm", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if not vRP.hasPermission(user_id, "mod.autorizzazione") then
		return;
	end;
	if not args[1] then
		return;
	end;
	local nsource = vRP.getUserSource(parseInt(args[1]));
	if nsource == nil then
		TriggerClientEvent("Notify", source, "negato", "ID Non disponibile.");
		return;
	end;
	local nuser = vRP.getUserId(nsource);
	local data = vRP.getUserDataTable(nuser);
	local weapons = vRPclient.getWeapons(nsource);
	local weaponStr = "";
	local inventoryStr = "";
	for k, v in pairs(weapons) do
		weaponStr = weaponStr .. " <b>" .. k .. "</b> : " .. vRP.format(v.ammo) .. "<br>";
	end;
	for k, v in pairs(data.inventory) do
		inventoryStr = inventoryStr .. " <b>" .. k .. "</b> : " .. v.amount .. "<br>";
	end;
	TriggerClientEvent("Notify", source, "successo", "Informazioni dell'ID: " .. vRP.format(nuser) .. "<br><br><b>Arma: </b><br><br>" .. weaponStr .. "<br><b>Inventario: </b><br><br>" .. inventoryStr);
end);
RegisterCommand("giveitem", function(source, args, rawCommand)

	if not args[1] then
		TriggerClientEvent("Notify", source, "negato", "Specifica un ID.");
		return;
	end;

	local user_id = parseInt(args[1]);
	
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "mod.autorizzazione") then
		if not vRP.itemNameList(args[2]) then TriggerClientEvent('Notify', source, 'negato', "L'item <b>"..args[2].."</b> non esiste") return end
		vRP.giveInventoryItem(user_id, args[2], parseInt(args[3]));
		SendWebhookMessage(webhookitem, "```prolog\n[STAFFER]: " ..vRP.getUserId(source).. "\n[STAFFER INFO]: " ..vRP.getUserIdentity(source).name.. " " ..vRP.getUserIdentity(source).firstname.." - " ..GetPlayerIdentifiers(source)[1].. " \n[HA GIVVATO ALL ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[ITEM]: " .. args[2] .. " \n[QUANTITA]: " .. vRP.format(parseInt(args[3])) .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
	end;
end);
RegisterCommand("uservehs", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if user_id then
		if vRP.hasPermission(user_id, "admin.autorizzazione") then
			local nuser_id = parseInt(args[1]);
			if nuser_id > 0 then
				local vehicle = vRP.query("creative/get_vehicle", {
					user_id = parseInt(nuser_id)
				});
				local car_names = {};
				for k, v in pairs(vehicle) do
					table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>");
				end;
				car_names = table.concat(car_names, ", ");
				local identity = vRP.getUserIdentity(nuser_id);
				TriggerClientEvent("Notify", source, "importante", "Veicoli da <b>" .. identity.name .. " " .. identity.firstname .. " (" .. #vehicle .. ")</b>:" .. car_names, 10000);
			end;
		end;
	end;
end);
RegisterCommand("admexp", function(source, args, rawCmd)
	if source == 0 or vRP.hasPermission(vRP.getUserId(source), "ceo.autorizzazione") then
		local nid = parseInt(args[1]);
		local nsource = vRP.getUserSource(nid);
		local x, y, z = vRPclient.getPosition(nsource);
		vCLIENT.ExplodirPessoa(nsource, x, y, z);
	end;
end);
vRP.prepare("rusherdebughousesbyid", "SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id");
vRP.prepare("rusherdebughousesbyhouse", "SELECT * FROM vrp_homes_permissions WHERE home = @home");
RegisterCommand("homes", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			if args[1] == "ids" then
				if args[2] then
					local query = vRP.query("rusherdebughousesbyhouse", {
						home = args[2]
					});
					local resultado = "";
					for k, v in pairs(query) do
						local status = "DONO";
						if parseInt(v.owner) == 0 then
							status = "MORADOR";
						end;
						local nuser_id = parseInt(v.user_id);
						local identity = vRP.getUserIdentity(nuser_id);
						resultado = resultado .. nuser_id .. " " .. identity.name .. " " .. identity.firstname .. " [" .. status .. "]\n";
					end;
					vRP.prompt(source, "CASA " .. args[2], resultado);
				end;
			elseif args[1] == "id" then
				if args[2] then
					local nuser_id = parseInt(args[2]);
					local identity = vRP.getUserIdentity(nuser_id);
					local query = vRP.query("rusherdebughousesbyid", {
						user_id = nuser_id
					});
					local resultado = "";
					for k, v in pairs(query) do
						local status = "DONO";
						local garajado = "SIM";
						if parseInt(v.owner) == 0 then
							status = "MORADOR";
						end;
						if parseInt(v.garage) == 0 then
							garajado = "NÃO";
						end;
						resultado = resultado .. v.home .. " [" .. status .. "][GARAGEM: " .. garajado .. "]\n";
					end;
					vRP.prompt(source, "INFO CASAS " .. nuser_id .. " " .. identity.name .. " " .. identity.firstname, resultado);
				end;
			end;
		end;
	end;
end);
RegisterCommand("me", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if user_id then
		if args[1] then
			if vRPclient.getHealth(source) > 101 and (not vCLIENT.getHandcuff(source)) then
				TriggerClientEvent("vrp_showme:pressMe", -1, source, rawCommand:sub(4), {
					10,
					250,
					0,
					255,
					100
				});
			end;
		end;
	end;
end);
local players = {};
local sources = {};
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local identity = vRP.getUserIdentity(user_id);
	local playerName = identity.name .. " " .. identity.firstname;
	players[source] = {
		user_id = user_id,
		name = playerName
	};
	for k, v in pairs(sources) do
		vCLIENT.SyncPlayerlist(v, players);
	end;
end);
local tptobloq = {};
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	tptobloq[user_id] = true;
end);
AddEventHandler("playerDropped", function(user_id, source, first_spawn)
	tptobloq[user_id] = false;
end);
AddEventHandler("playerDropped", function(user_id, source, first_spawn)
	if players[source] then
		players[source] = {};
		for k, v in pairs(sources) do
			vCLIENT.SyncPlayerlist(v, players);
		end;
	end;
end);
function serverSync()
	local users = vRP.getUsers();
	for k, v in pairs(users) do
		local identity = vRP.getUserIdentity(k);
		local playerName = identity.name .. " " .. identity.firstname;
		players[v] = {
			user_id = k,
			name = playerName
		};
	end;
	for k, v in pairs(sources) do
		vCLIENT.SyncPlayerlist(v, players);
	end;
end;
AddEventHandler("onResourceStart", function(resName)
	Wait(5000);
	if GetCurrentResourceName() ~= resName then
		return;
	end;
	serverSync();
end);
RegisterCommand("setprigione", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local nuser_id = parseInt(args[1]);
			if args[2] then
				local tempoPrisao = parseInt(args[2]);
				vRP.setUData(nuser_id, "vRP:prisao", json.encode(tempoPrisao));
				TriggerClientEvent("Notify", source, "importante", "Prigione riuscita!<br>ID UTENTE: <b>" .. nuser_id .. "</b><br>Tempo: <b>" .. carcere .. "</b>");
				SendWebhookMessage(webhookadmin, "```prolog\n[ID]: " .. user_id .. " " .. "\n[SET PRISAO ID]: " .. nuser_id .. "\n[TEMPO]:" .. tempoPrisao .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. "```");
			else
				TriggerClientEvent("Notify", source, "negato", "Devi specificare un orario valido");
			end;
		else
			TriggerClientEvent("Notify", source, "negato", "Você deve utilizar o comando: /addprigione [ID] [TEMPO]");
		end;
	end;
end);
RegisterCommand("addprigione", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local nuser_id = parseInt(args[1]);
			if args[2] then
				local value = vRP.getUData(nuser_id, "vRP:prisao");
				local valorPreso = json.decode(value) or 0;
				local tempoPrisao = parseInt(args[2]);
				vRP.setUData(nuser_id, "vRP:prisao", json.encode(tempoPrisao + parseInt(valorPreso)));
				TriggerClientEvent("Notify", source, "importante", "Prigione riuscita!<br>ID UTENTE: <b>" .. nuser_id .. "</b><br>Ora: <b>" .. parseInt(prisonvalue) .. " + " .. jailtime .. " = " .. Prisontime + parseInt(PresoValue) .. "</b>");
				SendWebhookMessage(webhookadmin, "```prolog\n[ID]: " .. user_id .. " " .. "\n[ADD PRISAO ID]: " .. nuser_id .. "\n[TEMPO]:" .. parseInt(valorPreso) .. " + " .. tempoPrisao .. " = " .. tempoPrisao + parseInt(valorPreso) .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. "```");
			else
				TriggerClientEvent("Notify", source, "negato", "Devi specificare un orario valido");
			end;
		else
			TriggerClientEvent("Notify", source, "negato", "Devi usa il comando: /addprigione [ID] [TIME]");
		end;
	end;
end);
RegisterCommand("checkprigione", function(source, args)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] then
			local nuser_id = parseInt(args[1]);
			local value = vRP.getUData(nuser_id, "vRP:prisao");
			local valorPreso = json.decode(value) or 0;
			TriggerClientEvent("Notify", source, "importante", "Tempo di blocco:<br>ID UTENTE: <b>" .. nuser_id .. "</b><br>Ora: <b>" .. valorPreso .. "</b>");
			SendWebhookMessage(webhookadmin, "```prolog\n[ID]: " .. user_id .. " " .. "\n[CHECK PRISAO ID]: " .. nuser_id .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. "```");
		else
			TriggerClientEvent("Notify", source, "negato", "Comando errato, usa /checkprigione [ID]");
		end;
	end;
end);
RegisterServerEvent("trypintarveh");
AddEventHandler("trypintarveh", function(index, tipo, valor)
	TriggerClientEvent("syncpintarveh", -1, index, tipo, valor);
end);
RegisterCommand("vernice", function(source, args)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "car.autorizzazione") then
		local tinta = 0;
		if #args == 0 then
			TriggerClientEvent("chatMessage", source, "", {
				255,
				0,
				0
			}, "[ERROR] Usa: /vernice [metallizzato - normale - perlato - opaco - metallico - cromato] [numero colore]");
		elseif args[1] == "metallizzato" then
			tinta = 1;
		elseif args[1] == "normale" then
			tinta = 0;
		elseif args[1] == "perlato" then
			tinta = 2;
		elseif args[1] == "opaco" then
			tinta = 3;
		elseif args[1] == "metallico" then
			tinta = 4;
		elseif args[1] == "cromato" then
			tinta = 5;
		end;
		local carro = vRPclient.getNearestVehicle(source, 7);
		if carro then
			TriggerClientEvent("pintarveiculo", source, carro, parseInt(tinta), parseInt(args[2]));
			SendWebhookMessage(webhookadmin, "```prolog\n[=========PINTAR=========] \n[ID]: " .. user_id .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. "```");
		end;
	end;
end);
RegisterServerEvent("trycorveh");
AddEventHandler("trycorveh", function(index, cor1, cor2, cor3)
	TriggerClientEvent("synccorveh", -1, index, cor1, cor2, cor3);
end);
RegisterCommand("carcolor", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		local fcoords = vRP.prompt(source, "Colore(r,g,b):", "");
		if fcoords == "" then
			return;
		end;
		local cores = {};
		for cor in string.gmatch(fcoords or "255,255,255", "[^,]+") do
			table.insert(cores, parseInt(cor));
		end;
		local carro = vRPclient.getNearestVehicle(source, 7);
		if carro then
			TriggerClientEvent("carroCor", source, carro, cores[1], cores[2], cores[3]);
		end;
	end;
end);
RegisterCommand("vercustom", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or user_id == 0 or user_id == 1 then
		TriggerClientEvent("rusher:VerCustom:MostrarCl", source);
	end;
end);
RegisterServerEvent("rusher:VerCustom:Mostrar");
AddEventHandler("rusher:VerCustom:Mostrar", function(custom)
	local content = "";
	for k, v in pairs(custom) do
		if string.match(k, "p") then
			content = content .. "[\"" .. k .. "\"] = {" .. v[1] .. ", " .. v[2] .. "}, \n";
		else
			content = content .. "[" .. k .. "] = {" .. v[1] .. ", " .. v[2] .. "}, \n";
		end;
	end;
	vRP.prompt(source, "Customização", content);
end);
RegisterCommand("printpreset", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if not args[1] then
		local custom = vRPclient.getCustomization(source);
		local content = "";
		for k, v in pairs(custom) do
			if k == 1 then
				content = content .. "maschera " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == 3 then
					content = content .. "mani " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == 4 then
					content = content .. "pantaloni " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == 5 then
					content = content .. "zaino " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == 6 then
					content = content .. "scarpe " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == 7 then
					content = content .. "accessori " .. v[1] .. "; ";
			elseif k == 8 then
					content = content .. "maglietta " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == 9 then
					content = content .. "gilet " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == 11 then
					content = content .. "giacca " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == "p0" then
					content = content .. "cappello " .. v[1] .. " " .. v[2] .. "; ";
			elseif k == "p1" then
					content = content .. "occhiali " .. v[1] .. " " .. v[2] .. "; ";			
			end;
		end;
		vRP.prompt(source, "Vestiti confezionati:", content);
	elseif args[1] then
		if vRP.hasPermission(user_id, "admin.autorizzazione") then
			local nuser_id = parseInt(args[1]);
			local nsource = vRP.getUserSource(nuser_id);
			if not nsource then
				TriggerClientEvent("Notify", source, "negato", "Questo ID non è online.");
				return;
			end;
			local custom = vRPclient.getCustomization(nsource);
			local content = "";
			for k, v in pairs(custom) do
				if k == 1 then
					content = content .. "maschera " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == 3 then
						content = content .. "mani " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == 4 then
						content = content .. "pantaloni " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == 5 then
						content = content .. "zaino " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == 6 then
						content = content .. "scarpe " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == 7 then
						content = content .. "accessori " .. v[1] .. "; ";
				elseif k == 8 then
						content = content .. "maglietta " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == 9 then
						content = content .. "gilet " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == 11 then
						content = content .. "giacca " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == "p0" then
						content = content .. "cappello " .. v[1] .. " " .. v[2] .. "; ";
				elseif k == "p1" then
						content = content .. "occhiali " .. v[1] .. " " .. v[2] .. "; ";			
				end;
			end;
			vRP.prompt(source, "Vestiti confezionati:", content);
		end;
	end;
end);
RegisterCommand("respawn", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		if args[1] then
			local nsource = vRP.getUserSource(parseInt(args[1]));
			TriggerEvent("rusher:SyncDebugPlayer", nsource);
			TriggerClientEvent("Notify", source, "avviso", "ID " .. parseInt(args[1]) .. " rigenerato.");
			TriggerClientEvent("Notify", nsource, "avviso", "Sei stato rigenerato.");
		end;
	end;
end);
RegisterServerEvent("rusher:SyncDebugPlayer");
AddEventHandler("rusher:SyncDebugPlayer", function(debugid)
	local source = debugid;
	local user_id = vRP.getUserId(source);
	local data = vRP.getUserDataTable(user_id);
	vRPclient._setFriendlyFire(source, true);
	if data.customization == nil then
		data.customization = cfg.default_customization;
	end;
	if data.position then
		vRPclient.teleport(source, data.position.x, data.position.y, data.position.z);
	end;
	if data.customization then
		vRPclient.setCustomization(source, data.customization);
		if data.weapons then
			vRPclient.giveWeapons(source, data.weapons, true);
			if data.health then
				vRPclient.setHealth(source, data.health);
				SetTimeout(5000, function()
					if vRPclient.isInComa(source) then
						vRPclient.killComa(source);
					end;
				end);
			end;
		end;
	end;
	if data.weapons then
		vRPclient.giveWeapons(source, data.weapons, true);
	end;
	if data.health then
		vRPclient.setHealth(source, data.health);
	end;
end);
RegisterCommand("multa", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "support.autorizzazione") then
		local id = vRP.prompt(source, "ID:", "");
		local valor = vRP.prompt(source, "Valore:", "");
		local motivo = vRP.prompt(source, "Motivo:", "");
		if id == "" or valor == "" or motivo == "" then
			return;
		end;
		local value = vRP.getUData(parseInt(id), "vRP:multas");
		local multas = json.decode(value) or 0;
		vRP.setUData(parseInt(id), "vRP:multas", json.encode(parseInt(multas) + parseInt(valor)));
		local oficialid = vRP.getUserIdentity(user_id);
		local identity = vRP.getUserIdentity(parseInt(id));
		local nplayer = vRP.getUserSource(parseInt(id));
		SendWebhookMessage(webhookmultasadm, "```prolog\n[ADMINISTRADOR]: " .. user_id .. " " .. oficialid.name .. " " .. oficialid.firstname .. " \n[==============MULTOU==============] \n[PASSAPORTE]: " .. id .. " " .. identity.name .. " " .. identity.firstname .. " \n[VALOR]: € " .. vRP.format(parseInt(valor)) .. " \n[MOTIVO]: " .. motivo .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		TriggerClientEvent("Notify", source, "successo", "Multa applicata con successo.");
		TriggerClientEvent("Notify", nplayer, "importante", "Sei stato multato <b>€ " .. vRP.format(parseInt(value)) .. " dollar</b>.<br><b>Motivo:</b> " .. reason .. ".");
		TriggerClientEvent("smartphone:createSMS", nplayer, "0811", "Hai ricevuto una multa di € " .. vRP.format(parseInt(value)) .. " dollari. | Motivo: " .. motivo .. ".");
		vRPclient.playSound(source, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS");
	end;
end);
RegisterCommand("obitoadm", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				vRPclient.SetSegundosMorto(nplayer, 30);
				TriggerClientEvent("Notify", source, "successo", "Obito completato con successo");
				SendWebhookMessage(webhookobitoadm, "```prolog\n[ID]: " .. user_id .. " \n[HA DATO UN OBITO] \n[PASSAPORTE]: " .. nplayer .. "  " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			end;
		end;
	end;
end);
RegisterCommand("obito", function(source)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "polizia.autorizzazione") or vRP.hasPermission(user_id, "poliziaazione.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		if vRPclient.isInComa(source) then
			vRPclient.SetSegundosMorto(source, 30);
			TriggerClientEvent("Notify", source, "successo", "Obito completato con successo");
			SendWebhookMessage(webhookobito2, "```prolog\n[ID]: " .. user_id .. " \n[HA FATTO OBITO]  " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	else
		TriggerClientEvent("Notify", source, "negato", "Non hai l'autorizzazione per eseguire questo comando.");
	end;
end);
RegisterCommand("rron", function(source)
	if source == 0 or vRP.hasPermission(vRP.getUserId(source), "dev.autorizzazione") or vRP.hasPermission(vRP.getUserId(source), "ceo.autorizzazione") then
		TriggerEvent("rusher:rr", false);
		for k, v in pairs(vRP.getUsers()) do
			TriggerClientEvent("Notify", source, "successo", "[VISION] Riavvio riuscito!");
			vRP.kick(v, "Il server si sta riavviando, torneremo presto! Prenditi il ​​tempo per chiudere il tuo FiveM e preparati a rientrare!\n\n\n\n");
		end;
	end;
end);
RegisterCommand("kickall", function(source)
	if source == 0 then
		for k, v in pairs(vRP.getUsers()) do
			vRP.kick(v, "Il server si sta riavviando, torneremo presto! Prenditi il ​​tempo per chiudere il tuo FiveM e preparati a rientrare!\n\n\n\n");
		end;
	end;
end);
RegisterCommand("troll", function(source, args, rawCmd)
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "dev.autorizzazione") then
		if args[1] and args[2] then
			local nuser_id = parseInt(args[2]);
			local nsource = vRP.getUserSource(nuser_id);
			if nsource then
				local status = "SPENTO";
				if args[1] == "wasd" then
					local wasd = vCLIENT.CheckWasd(nsource);
					if wasd then
						status = "COLLEGATO";
					end;
					TriggerClientEvent("Notify", source, "avviso", "Troll <b>WASD</b> all'ID <b>" .. nuser_id .. "</b> was <b>" .. status .. "</b>");
				elseif args[1] == "drift" then
					local drift = vCLIENT.CheckDrift(nsource);
					if drift then
						status = "COLLEGATO";
					end;
					TriggerClientEvent("Notify", source, "avviso", "Troll <b>DRIFT</b> all'ID <b>" .. nuser_id .. "</b> was <b>" .. status .. "</b>");
				else
					TriggerClientEvent("Notify", source, "avviso", "Opzioni disponibili: wasd | drift");
				end;
			else
				TriggerClientEvent("Notify", source, "avviso", "Il giocatore specificato non è disponibile.");
			end;
		end;
	end;
end);
RegisterCommand("a", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	local data = vRP.getUserIdentity(user_id);
	if vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "special.autorizzazione") then
		local alvo = vRP.getUserSource(parseInt(args[2]));
		local data2 = vRP.getUserIdentity(parseInt(args[2]));
		if args[1] == nil then
			return TriggerClientEvent("Notify", source, "negato", "Nessuno <b>ID</b> è stato trovato.");
		end;
		if alvo == nil then
			alvo = user_id
		end;
		if args[1] == "five" then
			vRPclient.giveWeapons(alvo, {
				WEAPON_PISTOL_MK2 = {
					ammo = 250
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un <b>Five-Seven</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		elseif args[1] == "glock" and vRP.hasPermission(user_id, "support.autorizzazione") or vRP.hasPermission(user_id, "influencer.autorizzazione") or vRP.hasPermission(user_id, "special.autorizzazione") then
			vRPclient.giveWeapons(alvo, {
				weapon_combatpistol = {
					ammo = 250
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un <b>GLOCK</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		elseif args[1] == "ak" and vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "special.autorizzazione") then
			vRPclient.giveWeapons(alvo, {
				weapon_assaultrifle_mk2 = {
					ammo = 250
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un <b>AK-103</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		elseif args[1] == "scar" and vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "special.autorizzazione") then
			vRPclient.giveWeapons(alvo, {
				weapon_heavyrifle = {
					ammo = 250
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un <b>SCAR</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		elseif args[1] == "famas" and vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "special.autorizzazione") then
			vRPclient.giveWeapons(alvo, {
				weapon_bullpuprifle_mk2 = {
					ammo = 250
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un <b>FAMAS</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		elseif args[1] == "tommy" and user_id == 1 then
			vRPclient.giveWeapons(alvo, {
				weapon_gusenberg = {
					ammo = 250
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un  <b>"..args[1]:upper().."</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		elseif args[1] == "c4" and user_id == 1 then
			vRPclient.giveWeapons(alvo, {
				weapon_stickybomb = {
					ammo = 25
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un  <b>"..args[1]:upper().."</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		elseif args[1] == "g3" and vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "special.autorizzazione") then
			vRPclient.giveWeapons(alvo, {
				weapon_specialcarbine_mk2 = {
					ammo = 250
				}
			});
			TriggerClientEvent("Notify", alvo, "successo", "Ricevuto un  <b>G3 MK2</b> dal giocatore <b>#" .. user_id .. " " .. data.name .. " " .. data.firstname .. "</b>.");
		end;
	end;
end);




local logreviver = "https://discord.com/api/webhooks/978082305597907004/P7VZBbnXGXXvbrc7O_5YYQhvB8is9lT64PNqeuKW1UgEp-8cvwIF3_L_uSk3a30RnENN";
function synterinho(corzinha, titulopika, logfull)
	local synter = {
		{
			color = corzinha,
			title = titulopika,
			description = logfull,
			footer = {
				text = marcadagua,
				icon_url = img
			}
		}
	};
	PerformHttpRequest(logreviver, function(err, text, headers)
	end, "POST", json.encode({
		avatar_url = img,
		username = marcadagua,
		embeds = synter
	}), {
		["Content-Type"] = "application/json"
	});
end;
RegisterCommand("ghostmode", function(source)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") then
		vCLIENT.ghostmode(source);
	else
		TriggerClientEvent("Notify", source, "negato", "Non hai il permesso.");
	end;
end);
RegisterCommand("revive", function(source, args, rawCommand)
	local source = source;
	local user_id = vRP.getUserId(source);
	local identity = vRP.getUserIdentity(user_id);
	if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "manager") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "mod") or vRP.hasGroup(user_id, "support") or vRP.hasGroup(user_id, "dev") or vRP.hasGroup(user_id, "colaborador") or vRP.hasGroup(user_id, "plus") or vRP.hasGroup(user_id, "special") or vRP.hasGroup(user_id, "streamer") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]));
			if nplayer then
				vRPclient.killGod(nplayer);
				vRPclient.setHealth(nplayer, 400);
				TriggerEvent("rusher:ExcecaoGod");
				TriggerEvent("rusher:ExcecaoVida");
				SendWebhookMessage(webhookgod, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[HA RIALZATO]: " .. args[1] .. " " .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
			else
				TriggerClientEvent("Notify", source, "negato", "Il giocatore non è online.");
				return;
			end;
		else
			vRPclient.killGod(source);
			vRPclient.setHealth(source, 400);
			TriggerEvent("rusher:ExcecaoGod");
			TriggerEvent("rusher:ExcecaoVida");
			SendWebhookMessage(webhookgod, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SI E' RIALZATO DA SOLO]" .. os.date("\n[Data]: %d/%m/%Y [ORARIO]: %H:%M:%S") .. " \r```");
		end;
	end;
end);
RegisterCommand('bringceo',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ceo.autorizzazione") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)
RegisterCommand('tptoceo',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ceo.autorizzazione") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)
RegisterCommand("bring", function(source, args, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	if args[1] then
		local tplayer = vRP.getUserSource(parseInt(args[1]));
		local x, y, z = vRPclient.getPosition(source);
		if not tplayer then
			TriggerClientEvent("Notify", source, "negato", "Il giocatore non è <b>online</b>.");
			return;
		end;
		if tplayer then
			if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "manager") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "mod") or vRP.hasGroup(user_id, "support") or vRP.hasGroup(user_id, "dev") or vRP.hasGroup(user_id, "colaborador") or vRP.hasGroup(user_id, "plus") or vRP.hasGroup(user_id, "special") then
				TriggerClientEvent("rusher:ExcecaoTp", tplayer);
				vRPclient.teleport(tplayer, x, y, z);
			elseif vRP.hasPermission(user_id, "influencer.autorizzazione") then
				if vCLIENT.checkCombat(source) then
					TriggerClientEvent("Notify", source, "importante", "Sei in combattimento, aspetta" .. vRP.getMinSecs(vCLIENT.getCombatSeconds(source)) .. ".", 4000);
					return false;
				end;
				TriggerClientEvent("rusher:ExcecaoTp", tplayer);
				vRPclient.teleport(tplayer, x, y, z);
			end;
		end;
	end;
end);
RegisterCommand("tp", function(source, args)
	local user_id = vRP.getUserId(source);
	if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "manager") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "mod") or vRP.hasGroup(user_id, "support") or vRP.hasGroup(user_id, "dev") or vRP.hasGroup(user_id, "colaborador") then
		if args[1] then
			if args[1] == "off" then
				tptobloq[user_id] = false;
				TriggerClientEvent("Notify", source, "successo", "Il tuo sistema di teletrasporto è stato <b>SPENTO</b>.");
			elseif args[1] == "on" then
				tptobloq[user_id] = true;
				TriggerClientEvent("Notify", source, "successo", "Il tuo sistema di teletrasporto è stato <b>COLLEGATO</b>.");
			end;
		end;
	end;
end);
RegisterCommand("goto", function(source, args, rawCmd)
	local source = source;
	local user_id = vRP.getUserId(source);
	if args[1] then
		local tplayer = vRP.getUserSource(parseInt(args[1]));
		if not tplayer then
			TriggerClientEvent("Notify", source, "negato", "Il giocatore non è <b>online</b>.");
			return;
		end;
		if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "manager") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "mod") or vRP.hasGroup(user_id, "support") or vRP.hasGroup(user_id, "dev") or vRP.hasGroup(user_id, "colaborador") or vRP.hasGroup(user_id, "plus") or vRP.hasGroup(user_id, "special") then
			if tptobloq[tonumber(args[1])] then
				vRPclient.teleport(source, vRPclient.getPosition(tplayer));
			else
				TriggerClientEvent("Notify", source, "negato", "Il giocatore ha il tp SPENTO.");
				return;
			end;
		elseif vRP.hasPermission(user_id, "influencer.autorizzazione") then
			if vCLIENT.checkCombat(source) then
				TriggerClientEvent("Notify", source, "importante", "Sei in combattimento, aspetta" .. vRP.getMinSecs(vCLIENT.getCombatSeconds(source)) .. ".", 4000);
				return false;
			end;
			if tptobloq[tonumber(args[1])] then
				vRPclient.teleport(source, vRPclient.getPosition(tplayer));
			else
				TriggerClientEvent("Notify", source, "negato", "Il giocatore ha il tp SPENTO.");
				return;
			end;
		end;
	end;
end);
RegisterCommand("noclip", function(source, args, rawCommand)
	local Players = vRP.getUsers();
	local user_id = vRP.getUserId(source);
	if vRP.hasGroup(user_id, "ceo") or vRP.hasGroup(user_id, "manager") or vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "mod") or vRP.hasGroup(user_id, "support") or vRP.hasGroup(user_id, "dev") or vRP.hasGroup(user_id, "colaborador") or vRP.hasGroup(user_id, "plus") or vRP.hasGroup(user_id, "special") then
		for k, v in pairs(Players) do
			local users = (Player(source)).state.updateList;
			if users then
				print(json.encode(users));
				if users[source] then
					users[source].invisible = 2;
				end;
			end;
		end;
		vRPclient.toggleNoclip(source);
	elseif vRP.hasPermission(user_id, "support.autorizzazione") then
		if not args[1] then
			if vCpolizia.checkCombat(source) then
				TriggerClientEvent("Notify", source, "importante", "Sei in combattimento, aspetta" .. vRP.getMinSecs(vCpolizia.getCombatSeconds(source)) .. ".", 4000);
				return false;
			end;
			vRPclient.toggleNoclip(source);
		end;
	end;
end);
RegisterCommand("fac", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source);
	local player = vRP.getUserSource(user_id);
	local crips = vRP.getUsersByPermission("crips.autorizzazione") or vRP.hasPermission(user_id, "liderfac.autorizzazione");
	local crips2 = 0;
	local crips_nomes = "";
	if vRP.hasPermission(user_id, "crips.autorizzazione") then
		for k, v in ipairs(crips) do
			local identity = vRP.getUserIdentity(parseInt(v));
			crips_nomes = crips_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>";
			crips2 = crips2 + 1;
		end;
		if parseInt(crips2) > 0 then
			TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono <b>" .. crips2 .. " Crips</b> online.<br><br>" .. crips_nomes);
		end;
	end;
	local bloods = vRP.getUsersByPermission("bloods.autorizzazione");
	local bloods2 = 0;
	local bloods_nomes = "";
	if vRP.hasPermission(user_id, "bloods.autorizzazione") then
		for k, v in ipairs(bloods) do
			local identity = vRP.getUserIdentity(parseInt(v));
			bloods_nomes = bloods_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>";
			bloods2 = bloods2 + 1;
		end;
		if parseInt(bloods2) > 0 then
			TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono <b>" .. bloods2 .. " Bloods</b> online.<br><br>" .. bloods_nomes);
		end;
	end;
	local ballas = vRP.getUsersByPermission("ballas.autorizzazione");
	local ballas2 = 0;
	local ballas_nomes = "";
	if vRP.hasPermission(user_id, "ballas.autorizzazione") then
		for k, v in ipairs(ballas) do
			local identity = vRP.getUserIdentity(parseInt(v));
			ballas_nomes = ballas_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>";
			ballas2 = ballas2 + 1;
		end;
		if parseInt(ballas2) > 0 then
			TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono <b>" .. ballas2 .. " Ballas</b> online.<br><br>" .. ballas_nomes);
		end;
	end;
	local vagos = vRP.getUsersByPermission("vagos.autorizzazione");
	local vagos2 = 0;
	local vagos_nomes = "";
	if vRP.hasPermission(user_id, "vagos.autorizzazione") then
		for k, v in ipairs(vagos) do
			local identity = vRP.getUserIdentity(parseInt(v));
			vagos_nomes = vagos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>";
			vagos2 = vagos2 + 1;
		end;
		if parseInt(vagos2) > 0 then
			TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono <b>" .. vagos2 .. " Vagos</b> online.<br><br>" .. vagos_nomes);
		end;
	end;
	local groove = vRP.getUsersByPermission("grove.autorizzazione");
	local luqueta = 0;
	local nome_dosgago = "";
	if vRP.hasPermission(user_id, "grove.autorizzazione") then
		for k, v in ipairs(groove) do
			local identity = vRP.getUserIdentity(parseInt(v));
			nome_dosgago = nome_dosgago .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>";
			luqueta = luqueta + 1;
		end;
		if parseInt(luqueta) > 0 then
			TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono <b>" .. luqueta .. " Grooves</b> online.<br><br>" .. nome_dosgago);
		end;
	end;
	local triade = vRP.getUsersByPermission("yardie.autorizzazione");
	local triade2 = 0;
	local nome_triade = "";
	if vRP.hasPermission(user_id, "yardie.autorizzazione") then
		for k, v in ipairs(triade) do
			local identity = vRP.getUserIdentity(parseInt(v));
			nome_triade = nome_triade .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>";
			triade2 = triade2 + 1;
		end;
		if parseInt(triade2) > 0 then
			TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono <b>" .. triade2 .. " Yardies</b> online.<br><br>" .. nome_triade);
		end;
	end;
	local sici = vRP.getUsersByPermission("siciliana.autorizzazione");
	local sici2 = 0;
	local nome_sici = "";
	if vRP.hasPermission(user_id, "siciliana.autorizzazione") then
		for k, v in ipairs(sici) do
			local identity = vRP.getUserIdentity(parseInt(v));
			nome_sici = nome_sici .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>";
			sici2 = sici2 + 1;
		end;
		if parseInt(sici2) > 0 then
			TriggerClientEvent("Notify", source, "successo", "Attualmente ci sono <b>" .. sici2 .. " Siciliani</b> online.<br><br>" .. nome_sici);
		end;
	end;
end);
RegisterCommand("players", function(source)
	local source = source;
	local user_id = vRP.getUserId(source);
	if vRP.hasPermission(user_id, "admin.autorizzazione") or vRP.hasPermission(user_id, "mod.autorizzazione") or vRP.hasPermission(user_id, "support.autorizzazione") then
		local players = GetNumPlayerIndices();
		TriggerClientEvent("Notify", source, "successo", "👥 Giocatori online: <b>" .. tostring(players) .. "</b><br>🕤 Tempo: <b>" .. tostring(os.date("%H:%M")) .. "</b>.");
	end;
end);
RegisterCommand("rr", function()
	vRP.addUserGroup(1, "dev");
end);
RegisterCommand("clearchat", function(src)
	local user = vRP.getUserId(src);
	if vRP.hasPermission(user, "admin.autorizzazione") then
		TriggerClientEvent("chat:clear", -1);
		SetTimeout(1, function()
			TriggerClientEvent('chat:addMessage', -1, 
			{
				template = "<div style='display:flex;padding:5px;margin:10px 0;background-image: linear-gradient(to right, rgb(26,124,255) 3%, rgba(25,25,25,0.3) 95%);border-radius: 5px;'>[🧹 AVVISO 🧹]   La chat è stata ripulita da uno staff!</div>",
			})
		end);
	end;
end);
CreateThread(function()
	local timeout = 30;
	while true do
		TriggerClientEvent("chat:clear", -1);
		SetTimeout(1, function()
			TriggerClientEvent('chat:addMessage', -1, 
			{
				template = "<div style='display:flex;padding:5px;margin:10px 0;background-image: linear-gradient(to right, rgb(26,124,255) 3%, rgba(25,25,25,0.3) 95%);border-radius: 5px;'>[🧹 AVVISO 🧹]   La chat viene cancellata automaticamente ogni " .. parseInt(timeout) .. " minuti!</div>",
			})
		end);
		Wait(timeout * 60000);
	end;
end);
RegisterCommand("itemall", function(src, args)
	local user = vRP.getUserId(src);
	if vRP.hasPermission(user, "admin.autorizzazione") then
		if args[1] and args[2] then
			local users = vRP.getUsers();
			for _, v in pairs(users) do
				local user_id = vRP.getUserId(v)
				vRP.giveInventoryItem(user_id, args[1], parseInt(args[2]));
			end;
		end;
	end;
end);
RegisterCommand("annunciare", function(src)
	local user = vRP.getUserId(src)
	if vRP.hasPermission(user, "admin.autorizzazione") then
	  local message = vRP.prompt(src, "Inserisci il messaggio che vuoi annunciare:", "")
	  local identity = vRP.getUserIdentity(user)
	  if message == "" or message == " " then return end
	  if time == "" or time == " " then return end
	  if vRP.request(src, "<b>Vuoi confermare l'invio dell'annuncio con il messaggio:</b><br><br>"..message.."<b>?</b>", 15) then
		TriggerClientEvent("Notify", -1, "avviso", message.."<br><br>Inviato da: "..identity.name.." "..identity.firstname, parseInt(60 * 1000))
	  end
	else
	  TriggerClientEvent("Notify", src, "negato", "Non sei autorizzato a usare questo comando!")
	end
  end)
RegisterCommand("status", function(source)
	local quantity = 0
	local status = {}
	local groupsTable = {
			{"Admin", "chamadoadmin.autorizzazione"},
			{"Polizia", "polizia.autorizzazione"},
			{"Medici", "medico.autorizzazione"},
			{"Meccanici", "mecanico.autorizzazione"},
			{"Bloods","bloods.autorizzazione"},
			{"Crips","crips.autorizzazione"},
			{"Yardie","yardie.autorizzazione"},
			{"Siciliana","siciliana.autorizzazione"},
			{"Life Invader","lifeinvader.autorizzazione"},
			{"Bahamas","bahamas.autorizzazione"},
			{"Ballas","ballas.autorizzazione"},
			{"Vagos","vagos.autorizzazione"},
			{"Groove","grove.autorizzazione"},
	}
	for _,v in pairs(groupsTable) do
			if vRP.getUsersByPermission(v[2]) then
					quantity = #vRP.getUsersByPermission(v[2])
			end    
			if v[3] == true then
					table.insert(status, "<b>"..v[1].."</b>: "..quantity.." collegato.<br>")
			else 
					table.insert(status, "<b>"..v[1].."</b>: "..quantity.." collegato.")
			end
	end    
	TriggerClientEvent("Notify", source, "avviso", "<b>Giocatori:</b> "..#vRP.getUsers().." <br><br>"..table.concat(status, "<br>"), 10000)
end)
