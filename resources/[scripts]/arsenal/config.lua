_G.Config = {};
Config.Coords = {-1631.89,166.45,61.76};
Config.Permissions = {
	{ "polizia.autorizzazione" },
	{ "poliziaazione.autorizzazione" }
};
Config.Notify = {
	successo = {
		getItem = "Hai equipaggiato un <b>%s</b>",
		getWeapon = "Hai equipaggiato un <b>%s</b>",
		clearWeapons = "Hai pulito la tua attrezzatura!"
	},
	negato = {
		permission = "Non sei autorizzato ad accedere all'armeria!"
	}
};
Config.Arsenal = {
	localImages = "https://images.visionexclusive.it/images/",
	FTO = {
		{
			name = "Five-Seven",
			description = "Calibro: 9mm",
			spawn = "WEAPON_PISTOL_MK2",
			image = "fiveseven"
		},
		{
			name = "Glock 18",
			description = "Calibro: 9mm",
			spawn = "WEAPON_APPISTOL",
			image = "appistol"
		},
		{
			name = "MP5 MK2",
			description = "Calibro: 9mm",
			spawn = "WEAPON_SMG_MK2",
			image = "mp5mk2"
		},
		{
			name = "G3 MK2",
			description = "Calibro: 5.56mm",
			spawn = "WEAPON_SPECIALCARBINE_MK2",
			image = "g36"
		},
		{
			name = "Scar",
			description = "Calibro: 7.62mm",
			spawn = "WEAPON_HEAVYRIFLE",
			image = "scar"
		}
	},
	Weapons = {
		{
			name = "Glock",
			description = "Calibro: 9mm",
			spawn = "WEAPON_COMBATPISTOL",
			image = "glock"
		},
		{
			name = "Energetico",
			description = "Consumabile",
			spawn = "energetico",
			image = "energetico",
			isItem = true
		},
		{
			name = "Radio",
			description = "Comunicatore",
			spawn = "radio",
			image = "radio",
			isItem = true
		},
		--{
			--name = "MP5",
			--description = "Calibro: 9mm",
			--spawn = "WEAPON_SMG",
			--image = "mp5"
		--},
		--{
			--name = "Sig Sauer",
			--description = "Calibro: 9mm",
			--spawn = "WEAPON_ASSAULTRIFLE_MK2",
			--image = "sig"
		--},
		--{
		--	name = "MPX",
			--description = "Calibro: 5.56mm",
			--spawn = "WEAPON_CARBINERIFLE_MK2",
			--image = "mpx"
		--},
		--{
			---name = "M4A1",
			--description = "Calibro: 5.56mm",
			--spawn = "WEAPON_CARBINERIFLE",
			--image = "m4a1"
		--},
	--	{
			--name = "Pompa",
			--description = "Calibro: 12 gauge",
			--spawn = "WEAPON_PUMPSHOTGUN",
			--image = "pumpp"
		--}
	}
};
