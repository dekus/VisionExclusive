local Proxy = module("lib/Proxy");
local Tunnel = module("lib/Tunnel");
vRP = {};
Proxy.addInterface("vRP", vRP);
tvRP = {};
Tunnel.bindInterface("vRP", tvRP);
vRPclient = Tunnel.getInterface("vRP");
vRP.users = {};
vRP.rusers = {};
vRP.user_tables = {};
vRP.user_tmp_tables = {};
vRP.user_sources = {};
local db_drivers = {};
local db_driver;
local cached_prepares = {};
local cached_queries = {};
local prepared_queries = {}; 
local db_initialized = false;
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
function ExtractIdentifiers(src)
	local identifiers = {
		steam = "N/E",
		ip = "N/E",
		discord = "N/E",
		license = "N/E",
		xbl = "N/E",
		live = "N/E"
	};
	for i = 0, GetNumPlayerIdentifiers(src) - 1 do
		local id = GetPlayerIdentifier(src, i);
		if string.find(id, "steam") then
			identifiers.steam = id;
		elseif string.find(id, "ip") then
			identifiers.ip = id;
		elseif string.find(id, "discord") then
			identifiers.discord = id;
		elseif string.find(id, "license") then
			identifiers.license = id;
		elseif string.find(id, "xbl") then
			identifiers.xbl = id;
		elseif string.find(id, "live") then
			identifiers.live = id;
		end;
	end;
	return identifiers;
end;
function vRP.registerDBDriver(name, on_init, on_prepare, on_query)
	if not db_drivers[name] then
		db_drivers[name] = { on_init, on_prepare, on_query };
		if name == Config.Main.db_driver[1] then
			db_driver = db_drivers[name];
			local ok = on_init(Config.Main.Bancadedados[1]);
			if ok then
				db_initialized = true;
				for _, prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare, 1, table.maxn(prepare)));
				end;
				for _, query in pairs(cached_queries) do
					query[2](on_query(table.unpack(query[1], 1, table.maxn(query[1]))));
				end;
				cached_prepares = nil;
				cached_queries = nil;
			end;
		end;
	end;
end;
function vRP.format(n)
	local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)$");
	return left .. ((num:reverse()):gsub("(%d%d%d)", "%1.")):reverse() .. right;
end;
function vRP.prepare(name, query)
	prepared_queries[name] = true;
	if db_initialized then
		db_driver[2](name, query);
	else
		table.insert(cached_prepares, {
			name,
			query
		});
	end;
end;
function vRP.query(name, params, mode)
	if not mode then
		mode = "query";
	end;
	if db_initialized then
		return db_driver[3](name, params or {}, mode);
	else
		local r = async();
		table.insert(cached_queries, {
			{
				name,
				params or {},
				mode
			},
			r
		});
		return r:wait();
	end;
end;
function vRP.execute(name, params)
	return vRP.query(name, params, "execute");
end;
vRP.prepare("vRP/create_user", "INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id");
vRP.prepare("vRP/add_identifier", "INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)");
vRP.prepare("vRP/userid_byidentifier", "SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier");
vRP.prepare("vRP/set_userdata", "REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)");
vRP.prepare("vRP/get_userdata", "SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key");
vRP.prepare("vRP/set_srvdata", "REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)");
vRP.prepare("vRP/get_srvdata", "SELECT dvalue FROM vrp_srv_data WHERE dkey = @key");
vRP.prepare("vRP/get_banned", "SELECT banned FROM vrp_users WHERE id = @user_id");
vRP.prepare("vRP/set_banned", "UPDATE vrp_users SET banned = @banned WHERE id = @user_id");
vRP.prepare("vRP/get_whitelisted", "SELECT whitelisted FROM vrp_users WHERE id = @user_id");
vRP.prepare("vRP/set_whitelisted", "UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id");
vRP.prepare("vRP/set_last_login", "UPDATE vrp_users SET last_login = @last_login, ip = @ip WHERE id = @user_id");
vRP.prepare("vRP/getall", "SELECT identifier FROM vrp_user_ids");
vRP.prepare("storeEstoque", "SELECT estoque FROM vrp_estoque WHERE vehicle = @vehicle");
vRP.prepare("updateStock", "UPDATE vrp_estoque SET estoque = @estoque  WHERE vehicle = @vehicle");
vRP.prepare("insertEstoque", "INSERT INTO vrp_estoque(vehicle,estoque) VALUES(@vehicle,0)");
vRP.prepare("vRP/get_discord","SELECT discord FROM vrp_users WHERE id = @user_id")

function vRP.getDiscord(user_id,cbr)
    local rows = vRP.query("vRP/get_discord",{ user_id = user_id })
    if #rows > 0 then
        return rows[1].discord
    else
        return ""
    end
end
function vRP.getUserIdByIdentifier(ids)
	local rows = vRP.query("vRP/userid_byidentifier", {
		identifier = ids
	});
	if #rows > 0 then
		return rows[1].user_id;
	else
		return -1;
	end;
end;
function vRP.getUserIdByIdentifiers(ids)
	if ids and (#ids) then
		for i = 1, #ids do
			if string.find(ids[i], "ip:") == nil then
				local rows = vRP.query("vRP/userid_byidentifier", {
					identifier = ids[i]
				});
				if #rows > 0 then
					return rows[1].user_id;
				end;
			end;
		end;
		local affected, rows = vRP.query("vRP/create_user", {});
		if #rows > 0 then
			local user_id = rows[1].id;
			for l, w in pairs(ids) do
				if string.find(w, "ip:") == nil then
					vRP.execute("vRP/add_identifier", {
						user_id = user_id,
						identifier = w
					});
				end;
			end;
			return user_id;
		end;
	end;
end;
function vRP.getPlayerEndpoint(player)
	return GetPlayerEP(player) or "0.0.0.0";
end;
function vRP.isBanned(user_id, cbr)
	local rows = vRP.query("vRP/get_banned", {
		user_id = user_id
	});
	if #rows > 0 then
		return rows[1].banned;
	else
		return false;
	end;
end;
function vRP.setBanned(user_id, banned)
	vRP.execute("vRP/set_banned", {
		user_id = user_id,
		banned = banned
	});
end;
function vRP.isWhitelisted(user_id, cbr)
	local rows = vRP.query("vRP/get_whitelisted", {
		user_id = user_id
	});
	if #rows > 0 then
		return rows[1].whitelisted;
	else
		return false;
	end;
end;
function vRP.setWhitelisted(user_id, whitelisted)
	vRP.execute("vRP/set_whitelisted", {
		user_id = user_id,
		whitelisted = whitelisted
	});
end;
function vRP.setUData(user_id, key, value)
	vRP.execute("vRP/set_userdata", {
		user_id = parseInt(user_id),
		key = key,
		value = value
	});
end;
function vRP.getUData(user_id, key, cbr)
	local rows = vRP.query("vRP/get_userdata", {
		user_id = user_id,
		key = key
	});
	if #rows > 0 then
		return rows[1].dvalue;
	else
		return "";
	end;
end;
function vRP.getDiscord(user_id, cbr)
	local rows = vRP.query("vRP/get_discord", {
		user_id = user_id
	});
	if #rows > 0 then
		return rows[1].discord;
	else
		return "";
	end;
end;

function vRP.setSData(key, value)
	vRP.execute("vRP/set_srvdata", {
		key = key,
		value = value
	});
end;

function vRP.getSData(key, cbr)
	local rows = vRP.query("vRP/get_srvdata", {
		key = key
	});
	if #rows > 0 then
		return rows[1].dvalue;
	else
		return "";
	end;
end;

function vRP.getUserDataTable(user_id)
	return vRP.user_tables[user_id];
end;
function vRP.getUserTmpTable(user_id)
	return vRP.user_tmp_tables[user_id];
end;
function vRP.getUserId(source)
	if source ~= nil then
		local ids = GetPlayerIdentifiers(source);
		if ids ~= nil and #ids > 0 then
			return vRP.users[ids[1]];
		end;
	end;
	return nil;
end;
function vRP.getUsers()
	local users = {};
	for k, v in pairs(vRP.user_sources) do
		users[k] = v;
	end;
	return users;
end;
function vRP.getUserSource(user_id)
	return vRP.user_sources[user_id];
end;
function vRP.kick(source, reason)
	DropPlayer(source, reason);
end;
function vRP.dropPlayer(source, motivo)
	local source = source;
	local user_id = vRP.getUserId(source);
	local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)));
	local VidaQuitou = GetEntityHealth(GetPlayerPed(source));
	local status = "VIVO";
	if VidaQuitou <= 101 then
		status = "MORTO";
	end;
	vRPclient._removePlayer(-1, source);
	if user_id then
		if user_id and source then
			local DataTable = vRP.getUserDataTable(user_id);
			local TableInv = DataTable.inventory;
			local TableArmas = DataTable.weapons;
			TriggerEvent("vRP:playerLeave", user_id, source);
			local marquezids = ExtractIdentifiers(source);
			local xblID = "\n**Xbox ID:  **" .. marquezids.xbl;
			local _steamID = "\n**Steam ID:  **" .. marquezids.steam;
			local _liveID = "\n**Live ID:  **" .. marquezids.live;
			local _licenseID = "\n**License ID: ** " .. marquezids.license;
			local _steamURL = "";
			local _discordID = "";
			if marquezids.discord ~= "N/E" then
				_discordID = "\n**Discord ID: ** <@" .. marquezids.discord:gsub("discord:", "") .. ">";
			end;
			if marquezids.steam ~= "N/E" then
				_steamURL = "\n\n **Steam Url: **https://steamcommunity.com/profiles/" .. tonumber(marquezids.steam:gsub("steam:", ""), 16);
			end;
			if parseInt(DataTable.health) <= parseInt(101) then
				if Config.Main.webhookmorto[1] ~= "" then
					SendWebhookMessage(Config.Main.webhookmorto[1], "```prolog\n[ID]: " .. user_id .. "  \n[IP]: " .. GetPlayerEndpoint(source) .. " \n[POS]: " .. x .. ", " .. y .. ", " .. z .. "\n[VIDA]: " .. VidaQuitou .. "\n[STATUS]: " .. status .. "\n[MOTIVO PER LASCIARE]: " .. motivo .. "\n\n[INVENTARIO]:" .. concatInv(TableInv) .. "\n\n[ARMI EQUIPAGGIATE]:" .. concatArmas(TableArmas) .. "\n\n[=========LASCIATO IL SERVER=========]" .. os.date("\n[Data]: %d/%m/%Y [Ora]: %H:%M:%S") .. " \r```" .. xblID .. _steamID .. _liveID .. _discordID .. _licenseID .. _steamURL);
				end;
			elseif Config.Main.webhookexit[1] ~= "" then
				SendWebhookMessage(Config.Main.webhookexit[1], "```prolog\n[ID]: " .. user_id .. " \n[IP]: " .. GetPlayerEndpoint(source) .. " \n[POS]: " .. x .. ", " .. y .. ", " .. z .. "\n[VIDA]: " .. VidaQuitou .. "\n[STATUS]: " .. status .. "\n[MOTIVO PER LASCIARE]: " .. motivo .. "\n\n[INVENTARIO]:" .. concatInv(TableInv) .. "\n\n[ARMI EQUIPAGGIATE]:" .. concatArmas(TableArmas) .. "\n\n[=========LASCIATO IL SERVER=========]" .. os.date("\n[Data]: %d/%m/%Y [Ora]: %H:%M:%S") .. " \r```" .. xblID .. _steamID .. _liveID .. _discordID .. _licenseID .. _steamURL);
			end;
		end;
		local identity = vRP.getUserIdentity(user_id);
		print("^5[ + ] > ^7Dati del giocatore ^5(" .. user_id .. " " .. identity.name .. " " .. identity.firstname .. ") ^7sono stati salvati con successo nel database.");
		vRP.setUData(user_id, "vRP:datatable", json.encode(vRP.getUserDataTable(user_id)));
		vRP.users[vRP.rusers[user_id]] = nil;
		vRP.rusers[user_id] = nil;
		vRP.user_tables[user_id] = nil;
		vRP.user_tmp_tables[user_id] = nil;
		vRP.user_sources[user_id] = nil;
	end;
end;
function task_save_datatables()
	SetTimeout(5 * 60000, task_save_datatables);
	TriggerEvent("vRP:save");
	for k, v in pairs(vRP.user_tables) do
		vRP.setUData(k, "vRP:datatable", json.encode(v));
	end;
end;
async(function()
	task_save_datatables();
end);
function concatInv(TableInv)
	local txt = "";
	if TableInv and type(TableInv) == "table" then
		for k, v in pairs(TableInv) do
			if not v or (not k) or k == nil or v == nil then
				return;
			end;
			txt = "\n   " .. vRP.format(v.amount) .. "x " .. vRP.itemNameList(k) .. txt;
		end;
		if txt == "" then
			return "ZAINO VUOTO"
		else
			return txt;
		end;
	end;
	return "ERRORE TROVARE INVENTARIO";
end;
function concatArmas(TableInv)
	local txt = "";
	if TableInv and type(TableInv) == "table" then
		for k, v in pairs(TableInv) do
			if not v or (not k) or k == nil or v == nil then
				return;
			end;
			txt = "\n   " .. vRP.itemNameList(("wbody|" .. k)) .. " [" .. v.ammo .. "]" .. txt;
		end;
		if txt == "" then
			return "DISARMATO";
		else
			return txt;
		end;
	end;
	return "ERRORE TROVARE ARMI";
end;
function vRP.removeWeaponTable(user_id, index)
	if vRP.user_tables[user_id].weapons then
		for k, v in pairs(vRP.user_tables[user_id].weapons) do
			vRP.user_tables[user_id].weapons[index] = nil;
			vRP.setUData(user_id, "vRP:datatable", json.encode(vRP.getUserDataTable(user_id)));
		end;
	end;
end;
AddEventHandler("queue:playerConnecting",function(source,ids,name,setKickReason,deferrals)
	deferrals.defer()
	local source = source
	local ids = ids

	if ids ~= nil and #ids > 0 then
		deferrals.update("Caricamento identità...")
		local user_id = vRP.getUserIdByIdentifiers(ids)
		if user_id then
			if(vRP.user_sources[user_id]~=nil)then
				if(GetPlayerName(vRP.user_sources[user_id])~=nil)then
				  deferrals.done("Sei buggato, riavvia FiveM!")
				  TriggerEvent("queue:playerConnectingRemoveQueues",ids)
				  DropPlayer(vRP.user_sources[user_id],"Sei stato espulso, prova ad accedere di nuovo.")
					vRP.users[vRP.rusers[user_id]] = nil
					vRP.rusers[user_id] = nil
					vRP.user_tables[user_id] = nil
					vRP.user_tmp_tables[user_id] = nil
					vRP.user_sources[user_id] = nil
				  return
				end
			end
			deferrals.update("Caricamento divieti...")
			if not vRP.isBanned(user_id) then
				deferrals.update("Caricamento whitelist...")
				if vRP.isWhitelisted(user_id) then
					if vRP.rusers[user_id] == nil then
						deferrals.update("Caricamento database...")
						local sdata = vRP.getUData(user_id,"vRP:datatable")

						vRP.users[ids[1]] = user_id
						vRP.rusers[user_id] = ids[1]
						vRP.user_tables[user_id] = {}
						vRP.user_tmp_tables[user_id] = {}
						vRP.user_sources[user_id] = source

						local data = json.decode(sdata)
						if type(data) == "table" then vRP.user_tables[user_id] = data end

						local tmpdata = vRP.getUserTmpTable(user_id)
						tmpdata.spawns = 0

						vRP.execute("vRP/set_last_login",{ user_id = user_id, last_login = os.date("%d.%m.%Y"), ip = GetPlayerEndpoint(source) or '0.0.0.0' })

						TriggerEvent("vRP:playerJoin",user_id,source,name)

						local rusher = ExtractIdentifiers(source)

						local xblID ="\n**Xbox ID:  **" ..rusher.xbl
						local _steamID ="\n**Steam ID:  **" ..rusher.steam
						local _liveID ="\n**Live ID:  **" ..rusher.live
						local _licenseID ="\n**License ID: ** " ..rusher.license
						local _steamURL = ''
						local _discordID = '' 
						
						if rusher.discord ~= 'N/E' then
							_discordID = "\n**Discord ID: ** <@" ..rusher.discord:gsub("discord:", "")..">"
						end

						if rusher.steam ~= 'N/E' then
							_steamURL ="\n\n **Steam Url: **https://steamcommunity.com/profiles/" ..tonumber(rusher.steam:gsub("steam:", ""),16)
						end
						if Config.Main.webhookjoins[1] ~= "" then
							SendWebhookMessage(Config.Main.webhookjoins[1],"```prolog\n[ID]: "..user_id.." \n[IP]: "..GetPlayerEndpoint(source).." \n[IDENTIFICATORE UTILIZZATO]: "..GetPlayerIdentifier(source).." \n[=========ISCRIZIONE DAL SERVER=========] "..os.date("\n[Data]: %d/%m/%Y [Ora]: %H:%M:%S").." \r```"..xblID.._steamID.._liveID.._discordID.._licenseID.._steamURL)
						end
						deferrals.done()
					else
						local tmpdata = vRP.getUserTmpTable(user_id)
						tmpdata.spawns = 0

						TriggerEvent("vRP:playerRejoin",user_id,source,name)
						deferrals.done()
					end
				else
					deferrals.done("Richiedi la tua whitelist sul nostro Discord! Tuo ID: [ "..user_id.." ] | [ "..Config.Main.discord[1].." ]")
					TriggerEvent("queue:playerConnectingRemoveQueues",ids)
				end
			else
				deferrals.done("Sei stato escluso! Tuo ID: [ "..user_id.." ] | [Maggiori informazioni su: "..Config.Main.discord[1].."]")
				TriggerEvent("queue:playerConnectingRemoveQueues",ids)
			end
		else
			deferrals.done("Si è verificato un problema di identificazione.")
			TriggerEvent("queue:playerConnectingRemoveQueues",ids)
		end
	else
		deferrals.done("Si è verificato un problema di identità.")
		TriggerEvent("queue:playerConnectingRemoveQueues",ids)
	end
end)
AddEventHandler("playerDropped", function(reason)
	local source = source;
	vRP.dropPlayer(source, reason);
end);
RegisterServerEvent("vRPcli:playerSpawned");
AddEventHandler("vRPcli:playerSpawned", function()
	local user_id = vRP.getUserId(source);
	if user_id then
		vRP.user_sources[user_id] = source;
		local tmp = vRP.getUserTmpTable(user_id);
		tmp.spawns = tmp.spawns + 1;
		local first_spawn = tmp.spawns == 1;
		if first_spawn then
			for k, v in pairs(vRP.user_sources) do
				vRPclient._addPlayer(source, v);
			end;
			vRPclient._addPlayer(-1, source);
			Tunnel.setDestDelay(source, 0);
		end;
		TriggerEvent("vRP:playerSpawn", user_id, source, first_spawn);
	end;
end);
function vRP.getDayHours(seconds)
	local days = math.floor(seconds / 86400);
	seconds = seconds - days * 86400;
	local hours = math.floor(seconds / 3600);
	if days > 0 then
		return string.format("<b>%d Giorni</b> e <b>%d Ore</b>", days, hours);
	else
		return string.format("<b>%d Ore</b>", hours);
	end;
end;
function vRP.getMinSecs(seconds)
	local days = math.floor(seconds / 86400);
	seconds = seconds - days * 86400;
	local hours = math.floor(seconds / 3600);
	seconds = seconds - hours * 3600;
	local minutes = math.floor(seconds / 60);
	seconds = seconds - minutes * 60;
	if minutes > 0 then
		return string.format("<b>%d Minuti</b> e <b>%d Secondi</b>", minutes, seconds);
	else
		return string.format("<b>%d Secondi</b>", seconds);
	end;
end;
