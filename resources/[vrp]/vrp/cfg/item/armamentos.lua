local items = {}

local nomes = {
	Knife = "Fare",
	Dagger = "Pugnale",
	Knuckle = "Tirapugni",
	Machete = "Machete",
	Switchblade = "Coltello",
	Wrench = "Chiave Giratubi",
	Hammer = "Martelo",
	Golfclub = "Stecca di Golf",
	Crowbar = "Pé de Cabra",
	Hatchet = "Ascia",
	Flashlight = "Torcia Elettrica",
	Bat = "Stecca",
	Bottle = "Bottiglia",
	Battleaxe = "Ascia di Battaglia",
	Poolcue = "Stecca di Biliardo",
	Stone_hatchet = "Ascia di Pietra",
	Pistol = "M1911",
	Machinepistol = "TEC-9",
	Gadget_parachute = "Paracadute",
	Combatpistol = "Glock 19",
	Carbinerifle = "M4A1",
	Carbinerifle_mk2 = "MPX",
	Compactrifle = "AKS-74U",
	Smg = "MP5",
	Pumpshotgun = "Shotgun",
	Sawnoffshotgun = "Remington 870",
	Stungun = "Taser",
	Nightstick = "Cassetete",
	Snspistol = "HK P7M10",
	Microsmg = "Uzi",
	Assaultrifle_mk2 = "AK-103",
	Fireextinguisher = "Extintor",
	Flare = "Sinalizador",
	Sig = "Sig Sauer PM",
	Revolver = "Magnum 44",
	Revolver_mk2 = "Magnum 357",
	Pistol_mk2 = "FN Five Seven",
	Vintagepistol = "M1922",
	Assaultsmg = "MTAR-21",
	Musket = "Winchester 22",
	Gusenberg = "Thompson",
	Smg_mk2 = "Sig Sauer MPX",
	Heavysniper = "M82",
	Bzgas = "Granada",
	Specialcarbine_mk2 = "G36",
	Combatpdw = "Sig",
	Petrolcan = "Galão de Gasolina"
}

local get_wname = function(weapon_id)
	local name = string.gsub(weapon_id,"WEAPON_","")
	name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
	return nomes[name]
end

local wammo_name = function(args)
	if args[2] == "WEAPON_PETROLCAN" then
		return "Combustível"
	else
		return "Munição de "..get_wname(args[2])
	end
end

local wbody_name = function(args)
	return get_wname(args[2])
end

items["wbody"] = { wbody_name,5 }
items["wammo"] = { wammo_name,0.03 }

return items