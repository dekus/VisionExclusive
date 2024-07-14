local cfg = {}

cfg.groups = {
	["dev"] = {
		_config = {
			title = "Developer",
			gtype = "gerente"
		},
		"dev.autorizzazione",
		"ceo.autorizzazione",
		"admin.autorizzazione",
		"mod.autorizzazione",
		"god.autorizzazione",
		"support.autorizzazione",
		"aprovadorwl.autorizzazione",
		"chatadm.autorizzazione",
		"chamadoadmin.autorizzazione",
		"dv.autorizzazione",

		"request.screenshot"  
	},
	["ceo"] = {
		_config = {
			title = "C.E.O",
			gtype = "gerente"
		},
		"ceo.autorizzazione",
		"admin.autorizzazione",
		"mod.autorizzazione",
		"support.autorizzazione",
		"aprovadorwl.autorizzazione",
		"chatadm.autorizzazione",
		"dv.autorizzazione",
		"chamadoadmin.autorizzazione",
		"god.autorizzazione",
	},
	["manager"] = {
		_config = {
			title = "Manager",
			gtype = "gerente"
		},
		"ceo.autorizzazione",
		"admin.autorizzazione",
		"mod.autorizzazione",
		"god.autorizzazione",
		"support.autorizzazione",
		"aprovadorwl.autorizzazione",
		"chatadm.autorizzazione",
		"dv.autorizzazione",
		"chamadoadmin.autorizzazione",
		"adm2.autorizzazione",
	},
	["admin"] = {
		_config = {
			title = "Administrator",
			gtype = "gerente"
		},
		"admin.autorizzazione",
		"mod.autorizzazione",
		"support.autorizzazione",
		"aprovadorwl.autorizzazione",
		"chatadm.autorizzazione",
		"god.autorizzazione",
		"dv.autorizzazione",
		"chamadoadmin.autorizzazione",
		"adm2.autorizzazione",
	},
	["mod"] = {
		_config = {
			title = "Moderator",
			gtype = "gerente"
		},
		"mod.autorizzazione",
		"support.autorizzazione",
		"aprovadorwl.autorizzazione",
		"chatadm.autorizzazione",
		"god.autorizzazione",
		"dv.autorizzazione",
		"chamadoadmin.autorizzazione",
		"mod2.autorizzazione",
	},
	["support"] = {
		_config = {
			title = "Support",
			gtype = "gerente"
		},
		"support.autorizzazione",
		"chatadm.autorizzazione",
		"dv.autorizzazione",
		"sup2.autorizzazione",
		"chamadoadmin.autorizzazione",
		"god.autorizzazione",
	},
	["influencer"] = {
		_config = {
			title = "Influenciador",
			gtype = "jobdois"
		},
		"god.autorizzazione",
		"influencer.autorizzazione",

		"painel.autorizzazione",
		"reviver.autorizzazione"
	},
	["partner"] = {
		_config = {
			title = "Parceiro",
			gtype = "jobdois"
		},
		"god.autorizzazione",
		"influencer.autorizzazione",
		"partner.autorizzazione",
		"painel.autorizzazione"
	},
	["liderfac"] = {
		_config = {
			title = "Leader Fazione",
			gtype = "jobdois"
		},
		"liderfac.autorizzazione",
	},

	["acesspm"] = {
		_config = {
			title = "polizia Acess",
			gtype = "jobdois"
		},
		"polizia.autorizzazione",
		"ultra.autorizzazione",
		"painel.autorizzazione"
	},
	-----------------------------------------------------------------------------
	--[	Setagens Vips ]----------------------------------------------------------
	-----------------------------------------------------------------------------
	["colaborador"] = {
		_config = {
			title = "Colaborador Plus",
			gtype = "jobdois"
		},
		"car.autorizzazione",
		"ultra.autorizzazione",
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["colab"] = {
		_config = {
			title = "Colaborador",
			gtype = "jobdois"
		},
		"colaborador.autorizzazione",
		"ultra.autorizzazione",
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["ultra"] = {
		_config = {
			title = "Ultra",
			gtype = "vip"
		},
		"ultra.autorizzazione",
		"plus.autorizzazione",
		"basic.autorizzazione",
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["plus"] = {
		_config = {
			title = "Plus",
			gtype = "vip"
		},
		"plus.autorizzazione",
		"basic.autorizzazione",
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["basic"] = {
		_config = {
			title = "Basic",
			gtype = "vip"
		},
		"basic.autorizzazione",
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["special"] = {
		_config = {
			title = "Investidor Special",
			gtype = "vip"
		},
		"special.autorizzazione",
		"car.autorizzazione",
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["plus"] = {
		_config = {
			title = "Investidor Plus",
			gtype = "vip"
		},
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["rental"] = {
		_config = {
			title = "Rental",
			gtype = "vip"
		},
		"basic.autorizzazione",
		"mochila.autorizzazione",
		"cor.autorizzazione"
	},
	["booster"] = {
		_config = {
			title = "Vision Booster",
			gtype = "vip"
		},
		"booster.autorizzazione",
		"cor.autorizzazione"
	},
	["streamer"] = {
		_config = {
			title = "Vision Streamer",
			gtype = "vip"
		},
		"streamer.autorizzazione",
	},
	-----------------------------------------------------------------------------
	--[	Departamento de polizia ]------------------------------------------------
	-----------------------------------------------------------------------------
	["polizia"] = {
		_config = {
			title = "Poliziotto",
			gtype = "job"
		},
		"polizia.autorizzazione",
		"chatpolizia.autorizzazione",
		"poliziaatirando.autorizzazione",
		"poliziasaque.autorizzazione",
		"carpolizia.autorizzazione"
	},
	["poliziaazione"] = {
		_config = {
			title = "Polizia in Azione",
			gtype = "job"
		},
		"poliziaazione.autorizzazione",
		"mochila.autorizzazione",
		"chatpolizia.autorizzazione",
		"carpolizia.autorizzazione",
		"poliziasaque.autorizzazione"
	},
	["poliziacopertura"] = {
		_config = {
			title = "Polizia Sotto Copertura",
			gtype = "job"
		},
		"paisanapolizia.autorizzazione",
		"poliziasaque.autorizzazione"
	},
	-----------------------------------------------------------------------------
	--[	Departamento Médico ]----------------------------------------------------
	-----------------------------------------------------------------------------
	["medico"] = {
		_config = {
			title = "Medico",
			gtype = "job"
		},
		"medico.autorizzazione"
	}, 
	["medicocopertura"] = {
		_config = {
			title = "Medico (fuori servizio)",
			gtype = "job"
		},
		"paisanamedico.autorizzazione"
	},
	-----------------------------------------------------------------------------
	--[	Mecânico e Bennys ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["meccanico"] = {
		_config = {
			title = "Meccanico",
			gtype = "job"
		},
		"mecanico.autorizzazione"
	},
	["mecanicocopertura"] = {
		_config = {
			title = "meccanico (fuori servizio)",
			gtype = "job"
		},
		"paisanamecanico.autorizzazione"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de drogas ]------------------------------
	-----------------------------------------------------------------------------
	["ballas"] = { -- BALLAS
		_config = {
			title = "Ballas",
			gtype = "job",
		},
		"ballas.autorizzazione",
		"drogas.autorizzazione"
	},

	["groove"] = { -- GROVE
		_config = {
			title = "Groove",
			gtype = "job",
		},
		"grove.autorizzazione",
		"drogas.autorizzazione"
	},

	["vagos"] = { -- VAGOS
		_config = {
			title = "Vagos",
			gtype = "job",
		},
		"vagos.autorizzazione",
		"drogas.autorizzazione"
	},
	-----------------------------------------------------------------------------
	--[	Organizzazione della produzione e vendita di armi ]-------------------------------
	-----------------------------------------------------------------------------
	["crips"] = {
		_config = {
			title = "Crips",
			gtype = "job",
		},
		"crips.autorizzazione",
		"armas.autorizzazione"
	},

	["bloods"] = { -- BLOODS
		_config = {
			title = "Bloods",
			gtype = "job",
		},
		"bloods.autorizzazione",
		"armas.autorizzazione"
	},
	-----------------------------------------------------------------------------
	--[	Organizzazione della produzione e vendita di munizioni ]----------------------------
	-----------------------------------------------------------------------------
	["yardie"] = {
		_config = {
			title = "Mafia Yardie",
			gtype = "job",
		},
		"yardie.autorizzazione",
		"municao.autorizzazione"
	},

	["siciliana"] = {
		_config = {
			title = "Mafia Siciliana",
			gtype = "job",
		},
		"siciliana.autorizzazione",
		"municao.autorizzazione"
	},
	-----------------------------------------------------------------------------
	--[	Organizzazione lavaggi e produzione candeggina ]------------------------
	-----------------------------------------------------------------------------
	["lifeinvader"] = {
	_config = {
		title = "Life Invader",
		gtype = "job",
	},
	"life.autorizzazione",
	"lavagem.autorizzazione"
    },

	["bahamas"] = { -- BAHAMAS
	_config = {
		title = "Bahamas",
		gtype = "job",
	},
	"bahamas.autorizzazione",
	"lavagem.autorizzazione"
    },
	-----------------------------------------------------------------------------
	--[	Lavoro secondario ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["chiefpolizia"] = {
		_config = {
			title = "Comandante di Polizia",
			gtype = "jobdois"
		},
		"chiefpm.autorizzazione",
		"acesspm.autorizzazione",
		"dv.autorizzazione"
	},
	["poliziafto"] = {
		_config = {
			title = "F.T.O Polizia",
			gtype = "jobdois"
		},
		"poliziafto.autorizzazione",
		"dv.autorizzazione"
	},
	["direttore"] = {
		_config = {
			title = "Direttore dell'ospedale",
			gtype = "jobdois"
		},
		"diretor.autorizzazione"
	},

	["capomec"] = {
		_config = {
			title = "capo meccanico",
			gtype = "jobdois"
		},
		"mecanico.autorizzazione"
	}
}

cfg.users = {
	[1] = { "dev" },
	[2] = { "dev" }

}

cfg.selectors = {}

return cfg