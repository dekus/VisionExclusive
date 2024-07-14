local colors = {
	{ name = "Nero", colorindex = 0 },
	{ name = "Carbonio", colorindex = 147 },
	{ name = "Grafite", colorindex = 1 },
	{ name = "Nero Antracite", colorindex = 11 },
	{ name = "Acciaio nero", colorindex = 2 },
	{ name = "Acciaio scuro", colorindex = 3 },
	{ name = "Argento", colorindex = 4 },
	{ name = "Argento bluastro", colorindex = 5 },
	{ name = "Acciaio laminato", colorindex = 6 },
	{ name = "Ombretto argento", colorindex = 7 },
	{ name = "Pietra d'argento", colorindex = 8 },
	{ name = "Argento di mezzanotte", colorindex = 9 },
	{ name = "Ghisa argentata", colorindex = 10 },
	{ name = "Rosso", colorindex = 27 },
	{ name = "Rosso Torino", colorindex = 28 },
	{ name = "Formula rossa", colorindex = 29 },
	{ name = "Rosso lava", colorindex = 150 },
	{ name = "Rosso fuoco", colorindex = 30 },
	{ name = "Grazia rossa", colorindex = 31 },
	{ name = "Rosso granato", colorindex = 32 },
	{ name = "Rosso tramonto", colorindex = 33 },
	{ name = "Rosso Cabernet", colorindex = 34 },
	{ name = "Vino rosso", colorindex = 143 },
	{ name = "Dolce rosso", colorindex = 35 },
	{ name = "Rosa caldo", colorindex = 135 },
	{ name = "Pfister Rosa", colorindex = 137 },
	{ name = "Rosa Salmone", colorindex = 136 },
	{ name = "Alba arancione", colorindex = 36 },
	{ name = "Arancia", colorindex = 38 },
	{ name = "Arancione brillante", colorindex = 138 },
	{ name = "Oro", colorindex = 99 },
	{ name = "Bronzo", colorindex = 90 },
	{ name = "Giallo", colorindex = 88 },
	{ name = "Razza Gialla", colorindex = 89 },
	{ name = "Giallo rugiada", colorindex = 91 },
	{ name = "Verde scuro", colorindex = 49 },
	{ name = "Corsa Verde", colorindex = 50 },
	{ name = "Verde Ultra", colorindex = 51 },
	{ name = "Verde oliva", colorindex = 52 },
	{ name = "Verde chiaro", colorindex = 53 },
	{ name = "Benzina Verde", colorindex = 54 },
	{ name = "Limone Verde", colorindex = 92 },
	{ name = "Blu notte", colorindex = 141 },
	{ name = "Blu Galassia", colorindex = 61 },
	{ name = "Blu scuro", colorindex = 62 },
	{ name = "Blu sassone", colorindex = 63 },
	{ name = "Blu", colorindex = 64 },
	{ name = "Blu Mare", colorindex = 65 },
	{ name = "Blu porto", colorindex = 66 },
	{ name = "Blu Diamante", colorindex = 67 },
	{ name = "Blu surf", colorindex = 68 },
	{ name = "Blu nautico", colorindex = 69 },
	{ name = "Blu da corsa", colorindex = 73 },
	{ name = "Blu ultra", colorindex = 70 },
	{ name = "Azzurro", colorindex = 74 },
	{ name = "Marrone cioccolato", colorindex = 96 },
	{ name = "bisonte marrone", colorindex = 101 },
	{ name = "Marrone creen", colorindex = 95 },
	{ name = "Feltzer Marrone", colorindex = 94 },
	{ name = "Marrone acero", colorindex = 97 },
	{ name = "Legno di faggio marrone", colorindex = 103 },
	{ name = "Marrone terra di Siena", colorindex = 104 },
	{ name = "Sella Marrone", colorindex = 98 },
	{ name = "Marrone muschio", colorindex = 100 },
	{ name = "Legno di faggio marrone", colorindex = 102 },
	{ name = "Paglia marrone", colorindex = 99 },
	{ name = "Marrone sabbia", colorindex = 105 },
	{ name = "Marrone sbiancato", colorindex = 106 },
	{ name = "Schafter viola", colorindex = 71 },
	{ name = "Spinnaker viola", colorindex = 72 },
	{ name = "Viola di mezzanotte", colorindex = 142 },
	{ name = "Viola brillante", colorindex = 145 },
	{ name = "Crema", colorindex = 107 },
	{ name = "Ghiaccio bianco", colorindex = 111 },
	{ name = "Ghiaccio bianco", colorindex = 112 }
}

local metalcolors = {
	{ name = "Acciaio spazzolato", colorindex = 117 },
	{ name = "Acciaio nero spazzolato", colorindex = 118 },
	{ name = "Alluminio spazzolato", colorindex = 119 },
	{ name = "Zecchino d'Oro", colorindex = 158 },
	{ name = "Oro spazzolato", colorindex = 159 }
}

local mattecolors = {
	{ name = "Nero", colorindex = 12 },
	{ name = "Grigio", colorindex = 13 },
	{ name = "Grigio chiaro", colorindex = 14 },
	{ name = "Ghiaccio bianco", colorindex = 131 },
	{ name = "Blu", colorindex = 83 },
	{ name = "Blu scuro", colorindex = 82 },
	{ name = "Blu notte", colorindex = 84 },
	{ name = "Viola mezzanotte", colorindex = 149 },
	{ name = "Schafter viola", colorindex = 148 },
	{ name = "Rosso", colorindex = 39 },
	{ name = "Rosso scuro", colorindex = 40 },
	{ name = "Arancia", colorindex = 41 },
	{ name = "Giallo", colorindex = 42 },
	{ name = "Limone Verde", colorindex = 55 },
	{ name = "Verde", colorindex = 128 },
	{ name = "Verde ghiaccio", colorindex = 151 },
	{ name = "Fogliame verde", colorindex = 155 },
	{ name = "Dardo olivastro", colorindex = 152 },
	{ name = "Terra nera", colorindex = 153 },
	{ name = "Abbronzatura del deserto", colorindex = 154 }
}

LSC_Config = {}
LSC_Config.prices = {}
LSC_Config.prices = {
	bennysweels = {},
	goldenweels = {},
	windowtint = {
		{ name = "Nero assoluto", tint = 1, price = 0 },
		{ name = "Fumo nero", tint = 2, price = 0 },
		{ name = "Fumo", tint = 3, price = 0 },
		{ name = "Limousine", tint = 4, price = 0 },
		{ name = "Verde", tint = 5, price = 0 },
	},
	chrome = {
		colors = {
			{ name = "Cromato", colorindex = 120 }
		},
		price = 0
	},
	classic = {
		colors = colors,
		price = 0
	},
	matte = {
		colors = mattecolors,
		price = 0
	},
	metallic = {
		colors = colors,
		price = 0
	},
	metal = {
		colors = metalcolors,
		price = 0
	},
	chrome2 = {
		colors = {
			{ name = "Cromato", colorindex = 120 }
		},
		price = 0
	},
	classic2 = {
		colors = colors,
		price = 0
	},
	matte2 = {
		colors = mattecolors,
		price = 0
	},
	metallic2 = {
		colors = colors,
		price = 0
	},
	metal2 = {
		colors = metalcolors,
		price = 0
	},
	neonlayout = {
		{ name = "Fronte, Retro e Lati", price = 0 }
	},
	neoncolor = {
		{ name = "Bianco", neon = {255,255,255}, price = 0 },
		{ name = "Blu", neon = {0,0,255}, price = 0 },
		{ name = "Blu elettrico", neon = {0,150,255}, price = 0 },
		{ name = "Menta verde", neon = {50,255,155}, price = 0 },
		{ name = "Limone Verde", neon = {0,255,0}, price = 0 },
		{ name = "Giallo", neon = {255,255,0}, price = 0 }, 
		{ name = "Doccia dorata", neon = {204,204,0}, price = 0 },
		{ name = "Arancia", neon = {255,128,0}, price = 0 },
		{ name = "Rosso", neon = {255,0,0}, price = 0 },
		{ name = "Cavallino rosa", neon = {255,102,255}, price = 0 },
		{ name = "Rosa caldoe",neon = {255,0,255}, price = 0 },
		{ name = "Viola", neon = {153,0,153}, price = 0 },
		{ name = "Marrone", neon = {139,69,19}, price = 0 }
	},
	plates = {
		{ name = "Blu e bianco 1", plateindex = 0, price = 0 },
		{ name = "Blu e bianco 2", plateindex = 3, price = 0 },
		{ name = "Blu e bianco 3", plateindex = 4, price = 0 },
		{ name = "Giallo e blu", plateindex = 2, price = 0 },
		{ name = "Giallo e nero", plateindex = 1, price = 0 }
	},
	coresXenon = {
		{ name = "Bianco", corxenon = 0, price = 0 },
		{ name = "Blu navy", corxenon = 1, price = 0 },
		{ name = "Bambina blu", corxenon = 2, price = 0 },
		{ name = "Verde acqua", corxenon = 3, price = 0 },
		{ name = "Verde lime", corxenon = 4, price = 0 },
		{ name = "Verde giallastro", corxenon = 5, price = 0 },
		{ name = "Arancione chiaro", corxenon = 6, price = 0 },
		{ name = "Arancia", corxenon = 7, price = 0 },
		{ name = "Ross", corxenon = 8, price = 0 },
		{ name = "Rosa baby", corxenon = 9, price = 0 },
		{ name = "Rosa caldo", corxenon = 10, price = 0 },
		{ name = "Viola", corxenon = 11, price = 0 },
		{ name = "Viola", corxenon = 12, price = 0 }
	},
	wheelaccessories = {
		{ name = "Stock di pneumatici", price = 0 },
		{ name = "Pneumatici personalizzati", price = 0 },
		{ name = "Fumo di pneumatici bianchi", smokecolor = {254,254,254}, price = 0 },
		{ name = "Fumo di pneumatici neri", smokecolor = {1,1,1}, price = 0 },
		{ name = "Fumo di pneumatici blu", smokecolor = {0,150,255}, price = 0 },
		{ name = "Fumo di pneumatici gialli", smokecolor = {255,255,50}, price = 0 },
		{ name = "Fumo di pneumatici arancione", smokecolor = {255,153,51}, price = 0 },
		{ name = "Fumo di pneumatici rossi", smokecolor = {255,10,10}, price = 0 },
		{ name = "Fumo di gomma verde", smokecolor = {10,255,10}, price = 0 },
		{ name = "Fumo di pneumatici viola", smokecolor = {153,10,153}, price = 0 },
		{ name = "Fumo di pneumatici rosa", smokecolor = {255,102,178}, price = 0 },
		{ name = "Fumo di pneumatici grigio",smokecolor = {128,128,128}, price = 0 }
	},
	wheelcolor = {
		colors = colors,
		price = 0
	},
	frontwheel = {
		{ name = "Azione", wtype = 6, mod = -1, price = 0 },
		{ name = "Superstrada", wtype = 6, mod = 0, price = 0 },
		{ name = "Speciale di strada", wtype = 6, mod = 1, price = 0 },
		{ name = "Racer", wtype = 6, mod = 2, price = 0 },
		{ name = "Trackstar", wtype = 6, mod = 3, price = 0 },
		{ name = "Overlord", wtype = 6, mod = 4, price = 0 },
		{ name = "Tridente", wtype = 6, mod = 5, price = 0 },
		{ name = "Triplethreat", wtype = 6, mod = 6, price = 0 },
		{ name = "Stilleto", wtype = 6, mod = 7, price = 0 },
		{ name = "Wires", wtype = 6, mod = 8, price = 0 },
		{ name = "Bobber", wtype = 6, mod = 9, price = 0 },
		{ name = "Solido", wtype = 6, mod = 10, price = 0 },
		{ name = "Scudo di ghiaccio", wtype = 6, mod = 11, price = 0 },
		{ name = "loop", wtype = 6, mod = 12, price = 0 }
	},
	backwheel = {
		{ name = "Estoque", wtype = 6, mod = -1, price = 0 },
		{ name = "Speedway", wtype = 6, mod = 0, price = 0 },
		{ name = "Streetspecial", wtype = 6, mod = 1, price = 0 },
		{ name = "Racer", wtype = 6, mod = 2, price = 0 },
		{ name = "Trackstar", wtype = 6, mod = 3, price = 0 },
		{ name = "Overlord", wtype = 6, mod = 4, price = 0 },
		{ name = "Trident", wtype = 6, mod = 5, price = 0 },
		{ name = "Triplethreat", wtype = 6, mod = 6, price = 0 },
		{ name = "Stilleto", wtype = 6, mod = 7, price = 0 },
		{ name = "Wires", wtype = 6, mod = 8, price = 0 },
		{ name = "Bobber", wtype = 6, mod = 9, price = 0 },
		{ name = "Solidus", wtype = 6, mod = 10, price = 0 },
		{ name = "Iceshield", wtype = 6, mod = 11, price = 0 },
		{ name = "Loops", wtype = 6, mod = 12, price = 0 }
	},
	sportwheels = {
		{ name = "Estoque", wtype = 0, mod = -1, price = 0 },
		{ name = "Inferno", wtype = 0, mod = 0, price = 0 },
		{ name = "Deepfive", wtype = 0, mod = 1, price = 0 },
		{ name = "Lozspeed", wtype = 0, mod = 2, price = 0 },
		{ name = "Diamondcut", wtype = 0, mod = 3, price = 0 },
		{ name = "Chrono", wtype = 0, mod = 4, price = 0 },
		{ name = "Feroccirr", wtype = 0, mod = 5, price = 0 },
		{ name = "Fiftynine", wtype = 0, mod = 6, price = 0 },
		{ name = "Mercie", wtype = 0, mod = 7, price = 0 },
		{ name = "Syntheticz", wtype = 0, mod = 8, price = 0 },
		{ name = "Organictyped", wtype = 0, mod = 9, price = 0 },
		{ name = "Endov1", wtype = 0, mod = 10, price = 0 },
		{ name = "Duper7", wtype = 0, mod = 11, price = 0 },
		{ name = "Uzer", wtype = 0, mod = 12, price = 0 },
		{ name = "Groundride", wtype = 0, mod = 13, price = 0 },
		{ name = "Spacer", wtype = 0, mod = 14, price = 0 },
		{ name = "Venum", wtype = 0, mod = 15, price = 0 },
		{ name = "Cosmo", wtype = 0, mod = 16, price = 0 },
		{ name = "Dashvip", wtype = 0, mod = 17, price = 0 },
		{ name = "Icekid", wtype = 0, mod = 18, price = 0 },
		{ name = "Ruffeld", wtype = 0, mod = 19, price = 0 },
		{ name = "Wangenmaster", wtype = 0, mod = 20, price = 0 },
		{ name = "Superfive", wtype = 0, mod = 21, price = 0 },
		{ name = "Endov2", wtype = 0, mod = 22, price = 0 },
		{ name = "Slitsix", wtype = 0, mod = 23, price = 0 }
	},
	suvwheels = {
		{ name = "Azione", wtype = 3, mod = -1, price = 0 },
		{ name = "Energia", wtype = 3, mod = 0, price = 0 },
		{ name = "Benefattore", wtype = 3, mod = 1, price = 0 },
		{ name = "Cosmo", wtype = 3, mod = 2, price = 0 },
		{ name = "Bippo", wtype = 3, mod = 3, price = 0 },
		{ name = "Royalsix", wtype = 3, mod = 4, price = 0 },
		{ name = "Fagorme", wtype = 3, mod = 5, price = 0 },
		{ name = "Deluxe", wtype = 3, mod = 6, price = 0 },
		{ name = "Icedout", wtype = 3, mod = 7, price = 0 },
		{ name = "Cognscenti", wtype = 3, mod = 8, price = 0 },
		{ name = "Lozspeedten", wtype = 3, mod = 9, price = 0 },
		{ name = "Supernova", wtype = 3, mod = 10, price = 0 },
		{ name = "Obeyrs", wtype = 3, mod = 11, price = 0 },
		{ name = "Lozspeedballer", wtype = 3, mod = 12, price = 0 },
		{ name = "Extra vaganzo", wtype = 3, mod = 13, price = 0 },
		{ name = "Splitsix", wtype = 3, mod = 14, price = 0 },
		{ name = "Empowered", wtype = 3, mod = 15, price = 0 },
		{ name = "Sunrise", wtype = 3, mod = 16, price = 0 },
		{ name = "Dashvip", wtype = 3, mod = 17, price = 0 },
		{ name = "Cutter", wtype = 3, mod = 18, price = 0 }
	},
	offroadwheels = {
		{ name = "Azione", wtype = 4, mod = -1, price = 0 },
		{ name = "Raider", wtype = 4, mod = 0, price = 0 },
		{ name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 0 },
		{ name = "Nevis", wtype = 4, mod = 2, price = 0 },
		{ name = "Cairngorm", wtype = 4, mod = 3, price = 0 },
		{ name = "Amazon", wtype = 4, mod = 4, price = 0 },
		{ name = "Challenger", wtype = 4, mod = 5, price = 0 },
		{ name = "Dunebasher", wtype = 4, mod = 6, price = 0 },
		{ name = "Fivestar", wtype = 4, mod = 7, price = 0 },
		{ name = "Rockcrawler", wtype = 4, mod = 8, price = 0 },
		{ name = "Milspecsteelie", wtype = 4, mod = 9, price = 0 },
	},
	tunerwheels = {
		{ name = "Azione", wtype = 5, mod = -1, price = 0 },
		{ name = "Cosmo", wtype = 5, mod = 0, price = 0 },
		{ name = "Supermesh", wtype = 5, mod = 1, price = 0 },
		{ name = "Outsider", wtype = 5, mod = 2, price = 0 },
		{ name = "Rollas", wtype = 5, mod = 3, price = 0 },
		{ name = "Driffmeister", wtype = 5, mod = 4, price = 0 },
		{ name = "Slicer", wtype = 5, mod = 5, price = 0 },
		{ name = "Elquatro", wtype = 5, mod = 6, price = 0 },
		{ name = "Dubbed", wtype = 5, mod = 7, price = 0 },
		{ name = "Fivestar", wtype = 5, mod = 8, price = 0 },
		{ name = "Slideways", wtype = 5, mod = 9, price = 0 },
		{ name = "Apex", wtype = 5, mod = 10, price = 0 },
		{ name = "Stancedeg", wtype = 5, mod = 11, price = 0 },
		{ name = "Countersteer", wtype = 5, mod = 12, price = 0 },
		{ name = "Endov1", wtype = 5, mod = 13, price = 0 },
		{ name = "Endov2dish", wtype = 5, mod = 14, price = 0 },
		{ name = "Guppez", wtype = 5, mod = 15, price = 0 },
		{ name = "Chokadori", wtype = 5, mod = 16, price = 0 },
		{ name = "Chicane", wtype = 5, mod = 17, price = 0 },
		{ name = "Saisoku", wtype = 5, mod = 18, price = 0 },
		{ name = "Dishedeight", wtype = 5, mod = 19, price = 0 },
		{ name = "Fujiwara", wtype = 5, mod = 20, price = 0 },
		{ name = "Zokusha", wtype = 5, mod = 21, price = 0 },
		{ name = "Battlevill", wtype = 5, mod = 22, price = 0 },
		{ name = "Rallymaster", wtype = 5, mod = 23, price = 0 }
	},
	importwheels = {
		{ name = "Azione", wtype = 0, mod = -1, price = 0 },
		{ name = "Cosmo", wtype = 0, mod = 50, price = 0 },
		{ name = "Supermesh", wtype = 0, mod = 51, price = 0 },
		{ name = "Outsider", wtype = 0, mod = 52, price = 0 },
		{ name = "Rollas", wtype = 0, mod = 53, price = 0 },
		{ name = "Driffmeister", wtype = 0, mod = 54, price = 0 },
		{ name = "Slicer", wtype = 0, mod = 55, price = 0 },
		{ name = "Elquatro", wtype = 0, mod = 56, price = 0 },
		{ name = "Dubbed", wtype = 0, mod = 57, price = 0 },
		{ name = "Fivestar", wtype = 0, mod = 58, price = 0 },
		{ name = "Slideways", wtype = 0, mod = 59, price = 0 },
		{ name = "Apex", wtype = 0, mod = 60, price = 0 },
		{ name = "Stancedeg", wtype = 0, mod = 61, price = 0 },
		{ name = "Countersteer", wtype = 0, mod = 62, price = 0 },
		{ name = "Endov1", wtype = 0, mod = 63, price = 0 },
		{ name = "Endov2dish", wtype = 0, mod = 64, price = 0 },
		{ name = "Guppez", wtype = 0, mod = 65, price = 0 },
		{ name = "Chokadori", wtype = 0, mod = 66, price = 0 },
		{ name = "Chicane", wtype = 0, mod = 67, price = 0 },
		{ name = "Saisoku", wtype = 0, mod = 68, price = 0 },
		{ name = "Dishedeight", wtype = 0, mod = 69, price = 0 },
		{ name = "Fujiwara", wtype = 0, mod = 70, price = 0 },
		{ name = "Zokusha", wtype = 0, mod = 71, price = 0 },
		{ name = "Battlevill", wtype = 0, mod = 72, price = 0 },
		{ name = "Rallymaster", wtype = 0, mod = 73, price = 0 },
		{ name = "Enercy", wtype = 0, mod = 74, price = 0 },
		{ name = "Benefactor", wtype = 0, mod = 75, price = 0 },
		{ name = "Bippu", wtype = 0, mod = 76, price = 0 },
		{ name = "Royalsix", wtype = 0, mod = 77, price = 0 },
		{ name = "Fagorme", wtype = 0, mod = 78, price = 0 },
		{ name = "Deluxe", wtype = 0, mod = 79, price = 0 },
		{ name = "Icedout", wtype = 0, mod = 80, price = 0 },
		{ name = "Cognscenti", wtype = 0, mod = 81, price = 0 },
		{ name = "Empowered", wtype = 0, mod = 82, price = 0 }
	},
	highendwheels = {
		{ name = "Azione", wtype = 7, mod = -1, price = 0 },
		{ name = "Shadow", wtype = 7, mod = 0, price = 0 },
		{ name = "Hyper", wtype = 7, mod = 1, price = 0 },
		{ name = "Blade", wtype = 7, mod = 2, price = 0 },
		{ name = "Diamond", wtype = 7, mod = 3, price = 0 },
		{ name = "Supagee", wtype = 7, mod = 4, price = 0 },
		{ name = "Chromaticz", wtype = 7, mod = 5, price = 0 },
		{ name = "Merciechlip", wtype = 7, mod = 6, price = 0 },
		{ name = "Obeyrs", wtype = 7, mod = 7, price = 0 },
		{ name = "Gtchrome", wtype = 7, mod = 8, price = 0 },
		{ name = "Cheetahr", wtype = 7, mod = 9, price = 0 },
		{ name = "Solar", wtype = 7, mod = 10, price = 0 },
		{ name = "Splitten", wtype = 7, mod = 11, price = 0 },
		{ name = "Dashvip", wtype = 7, mod = 12, price = 0 },
		{ name = "Lozspeedten", wtype = 7, mod = 13, price = 0 },
		{ name = "Carboninferno", wtype = 7, mod = 14, price = 0 },
		{ name = "Carbonshadow", wtype = 7, mod = 15, price = 0 },
		{ name = "Carbonz", wtype = 7, mod = 16, price = 0 },
		{ name = "Carbonsolar", wtype = 7, mod = 17, price = 0 },
		{ name = "Carboncheetahr", wtype = 7, mod = 18, price = 0 },
		{ name = "Carbonsracer", wtype = 7, mod = 19, price = 0 }
	},
	lowriderwheels = {
		{ name = "Azione", wtype = 2, mod = -1, price = 0 },
		{ name = "Flare", wtype = 2, mod = 0, price = 0 },
		{ name = "Wired", wtype = 2, mod = 1, price = 0 },
		{ name = "Triplegolds", wtype = 2, mod = 2, price = 0 },
		{ name = "Bigworm", wtype = 2, mod = 3, price = 0 },
		{ name = "Sevenfives", wtype = 2, mod = 4, price = 0 },
		{ name = "Splitsix", wtype = 2, mod = 5, price = 0 },
		{ name = "Freshmesh", wtype = 2, mod = 6, price = 0 },
		{ name = "Leadsled", wtype = 2, mod = 7, price = 0 },
		{ name = "Turbine", wtype = 2, mod = 8, price = 0 },
		{ name = "Superfin", wtype = 2, mod = 9, price = 0 },
		{ name = "Classicrod", wtype = 2, mod = 10, price = 0 },
		{ name = "Dollar", wtype = 2, mod = 11, price = 0 },
		{ name = "Dukes", wtype = 2, mod = 12, price = 0 },
		{ name = "Lowfive", wtype = 2, mod = 13, price = 0 },
		{ name = "Gooch", wtype = 2, mod = 14, price = 0 }
	},
	musclewheels = {
		{ name = "Azione", wtype = 1, mod = -1, price = 0 },
		{ name = "Classicfive", wtype = 1, mod = 0, price = 0 },
		{ name = "Dukes", wtype = 1, mod = 1, price = 0 },
		{ name = "Musclefreak", wtype = 1, mod = 2, price = 0 },
		{ name = "Kracka", wtype = 1, mod = 3, price = 0 },
		{ name = "Azrea", wtype = 1, mod = 4, price = 0 },
		{ name = "Mecha", wtype = 1, mod = 5, price = 0 },
		{ name = "Blacktop", wtype = 1, mod = 6, price = 0 },
		{ name = "Dragspl", wtype = 1, mod = 7, price = 0 },
		{ name = "Revolver", wtype = 1, mod = 8, price = 0 },
		{ name = "Classicrod", wtype = 1, mod = 9, price = 0 },
		{ name = "Spooner", wtype = 1, mod = 10, price = 0 },
		{ name = "Fivestar", wtype = 1, mod = 11, price = 0 },
		{ name = "Oldschool", wtype = 1, mod = 12, price = 0 },
		{ name = "Eljefe", wtype = 1, mod = 13, price = 0 },
		{ name = "Dodman", wtype = 1, mod = 14, price = 0 },
		{ name = "Sixgun", wtype = 1, mod = 15, price = 0 },
		{ name = "Mercenary", wtype = 1, mod = 16, price = 0 }
	},
	trim = {
		colors = colors,
		price = 0
	},
	mods = {
		[48] = {
			startprice = 0,
			increaseby = 0
		},
		[46] = {
			startprice = 0,
			increaseby = 0
		},
		[45] = {
			startprice = 0,
			increaseby = 0
		},
		[44] = {
			startprice = 0,
			increaseby = 0
		},
		[43] = {
			startprice = 0,
			increaseby = 0
		},
		[42] = {
			startprice = 0,
			increaseby = 0
		},
		[41] = {
			startprice = 0,
			increaseby = 0
		},
		[40] = {
			startprice = 0,
			increaseby = 0
		},
		[39] = {
			startprice = 0,
			increaseby = 0
		},
		[38] = {
			startprice = 0,
			increaseby = 0
		},
		[37] = {
			startprice = 0,
			increaseby = 0
		},
		[36] = {
			startprice = 0,
			increaseby = 0
		},
		[35] = {
			startprice = 0,
			increaseby = 0
		},
		[34] = {
			startprice = 0,
			increaseby = 0
		},
		[33] = {
			startprice = 0,
			increaseby = 0
		},
		[32] = {
			startprice = 0,
			increaseby = 0
		},
		[31] = {
			startprice = 0,
			increaseby = 0
		},
		[30] = {
			startprice = 0,
			increaseby = 0
		},
		[29] = {
			startprice = 0,
			increaseby = 0
		},
		[28] = {
			startprice = 0,
			increaseby = 0
		},
		[27] = {
			startprice = 0,
			increaseby = 0
		},
		[26] = {
			startprice = 0,
			increaseby = 0
		},
		[25] = {
			startprice = 0,
			increaseby = 0
		},
		[22] = {
			{ name = "Azione", mod = 0, price = 0 },
			{ name = "Xeno", mod = 1, price = 0 }
		},
		[18] = {
			{ name = "Nessuno", mod = 0, price = 0 },
			{ name = "Turbo", mod = 1, price = 0 }
		},
		[16] = {
			--{ name = "Blindagem 20%", modtype = 16, mod = 0, price = 0 },
			--{ name = "Blindagem 40%", modtype = 16, mod = 1, price = 0 },
			--{ name = "Blindagem 60%", modtype = 16, mod = 2, price = 0 },
			--{ name = "Blindagem 80%", modtype = 16, mod = 3, price = 0 },
			{ name = "Armatura 100%", modtype = 16, mod = 4, price = 0 }
		},
		[15] = {
			{ name = "Sospensione 1", mod = 0, price = 0 },
			{ name = "Sospensione 2", mod = 1, price = 0 },
			{ name = "Sospensione 3", mod = 2, price = 0 },
			{ name = "Sospensione 4", mod = 3, price = 0 }
		},
		[14] = {
			{ name = "Camion", mod = 0, price = 0 },
			{ name = "Polizia", mod = 1, price = 0 },
			{ name = "Clown", mod = 2, price = 0 },
			{ name = "Musical 1", mod = 3, price = 0 },
			{ name = "Musical 2", mod = 4, price = 0 },
			{ name = "Musical 3", mod = 5, price = 0 },
			{ name = "Musical 4", mod = 6, price = 0 },
			{ name = "Musical 5", mod = 7, price = 0 },
			{ name = "Triste", mod = 8, price = 0 },
			{ name = "Classico 1", mod = 9, price = 0 },
			{ name = "Classico 2", mod = 10, price = 0 },
			{ name = "Classico 3", mod = 11, price = 0 },
			{ name = "Classico 4", mod = 12, price = 0 },
			{ name = "Classico 5", mod = 13, price = 0 },
			{ name = "Classico 6", mod = 14, price = 0 },
			{ name = "Classico 7", mod = 15, price = 0 },
			{ name = "Scala Do", mod = 16, price = 0 },
			{ name = "Scala Re", mod = 17, price = 0 },
			{ name = "Scala Mi", mod = 18, price = 0 },
			{ name = "Scala Fa", mod = 19, price = 0 },
			{ name = "Scala Sol", mod = 20, price = 0 },
			{ name = "Scala La", mod = 21, price = 0 },
			{ name = "Scala Ti", mod = 22, price = 0 },
			{ name = "Scala Do (Alto)", mod = 23, price = 0 },
			{ name = "Jazz  1", mod = 24, price = 0 },
			{ name = "Jazz  2", mod = 25, price = 0 },
			{ name = "Jazz  3", mod = 26, price = 0 },
			{ name = "Jazz  Loop", mod = 27, price = 0 },
			{ name = "Stendardo a stelle e strisce 1", mod = 28, price = 0 },
			{ name = "Stendardo a stelle e strisce 2", mod = 29, price = 0 },
			{ name = "Stendardo a stelle e strisce 3", mod = 30, price = 0 },
			{ name = "Stendardo a stelle e strisce 4", mod = 31, price = 0 },
			{ name = "Classico  Loop 1", mod = 32, price = 0 },
			{ name = "Classico  8", mod = 33, price = 0 },
			{ name = "Classico  Loop 2", mod = 34, price = 0 },
			{ name = "Halloween Loop 1", mod = 38, price = 0 },
			{ name = "Halloween Loop 2", mod = 40, price = 0 },
			{ name = "San Andreas Loop", mod = 42, price = 0 },
			{ name = "Liberty City Loop", mod = 44, price = 0 },
			{ name = "Festivo Loop 1", mod = 46, price = 0 },
			{ name = "Festivo Loop 2", mod = 47, price = 0 },
			{ name = "Festivo Loop 3", mod = 48, price = 0 }
		},
		[13] = {
			--{ name = "Street Transmission", mod = 0, price = 0 },
			--{ name = "Sports Transmission", mod = 1, price = 0 },
			{ name = "Streaming 100%", mod = 2, price = 0 }
		},
		[12] = {
			--{ name = "Street Brakes", mod = 0, price = 0 },
			--{ name = "Sport Brakes", mod = 1, price = 0 },
			{ name = "Freno 100%", mod = 2, price = 0 }
		},
		[11] = {
			--{ name = "Motor 1", mod = 0, price = 0 },
			--{ name = "Motor 2", mod = 1, price = 0 },
			--{ name = "Motor 3", mod = 2, price = 0 },
			{ name = "Motore Massimo", mod = 3, price = 0 }
		},
		[10] = {
			startprice = 0,
			increaseby = 0
		},
		[8] = {
			startprice = 0,
			increaseby = 0
		},
		[7] = {
			startprice = 0,
			increaseby = 0
		},
		[6] = {
			startprice = 0,
			increaseby = 0
		},
		[5] = {
			startprice = 0,
			increaseby = 0
		},
		[4] = {
			startprice = 0,
			increaseby = 0
		},
		[3] = {
			startprice = 0,
			increaseby = 0
		},
		[2] = {
			startprice = 0,
			increaseby = 0
		},
		[1] = {
			startprice = 0,
			increaseby = 0
		},
		[0] = {
			startprice = 0,
			increaseby = 0
		}
	}
}

for i = 0,185 do
	table.insert(LSC_Config.prices["bennysweels"],{ name = "Bennys "..i, wtype = 8, mod = i, price = 0 })
	table.insert(LSC_Config.prices["goldenweels"],{ name = "Golden "..i, wtype = 9, mod = i, price = 0 })
end

LSC_Config.ModelBlacklist = {
	--"police"
}

LSC_Config.lock = true
LSC_Config.oldenter = true

LSC_Config.menu = {
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},
	position = "left",
	theme = "light",
	maxbuttons = 10,
	width = 0.24,
	height = 0.36
}