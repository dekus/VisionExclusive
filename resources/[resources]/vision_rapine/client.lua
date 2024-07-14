local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vSERVER = Tunnel.getInterface("rusher_roubos")

src = {}
Tunnel.bindInterface("rusher_roubos", src)
---------------------------------------------------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------------------------------------------------
local Config = {
    ['Negozio China'] = { -- Nome do estabelecimento
        ['x'] = -709.38, ['y'] = -904.17, ['z'] = 19.22, ['h'] = 85.48, -- Posição 2549.26,384.78,108.63
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'NegozioChina', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Molo del caffè'] = { -- Nome do estabelecimento 
    ['x'] = -3412.3, ['y'] = 961.1, ['z'] = 8.35, ['h'] = 92.45, -- Posição
    ['TempoRoubo'] = 30, -- Tempo que demorará pra terminar o roubo 
    ['Recompensa'] = 30000, -- Recompensa de dinheiro sujo no roubo
    ['TipoCooldown'] = 'Molo del caffè', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
    ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
    ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
    ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
    ['MaxPolizia'] = 4, 
    ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
    ['Prioridade'] = 'sul' 
   },
  ['Skate'] = {
    ['x'] = 291.78, ['y'] = -219.24, ['z'] = 61.58, ['h'] = 249.91, -- Add a comma after '61.58'
    ['TempoRoubo'] = 30,
    ['Recompensa'] = 100000,
    ['TipoCooldown'] = 'Skate',
    ['Cooldown'] = 100,
    ['ItemReq'] = nil,
    ['MinPolizia'] = 4,
    ['MaxPolizia'] = 6,
    ['PermDosPm'] = 'polizia.autorizzazione',
    ['Prioridade'] = 'sul'
},

    ['Negozio Diga'] = { -- Nome do estabelecimento
        ['x'] = 1159.49, ['y'] = -314.0, ['z'] = 69.21, ['h'] = 101.47, -- Posição 1159.58,-314.14,69.21
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'NegozioDiga', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Negozio Keke'] = { -- Nome do estabelecimento
        ['x'] = -43.24, ['y'] = -1748.5, ['z'] = 29.43, ['h'] = 89.02, -- Posição -709.68,-904.07,19.22
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Negozio Keke', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Negozio Mord'] = { -- Nome do estabelecimento
        ['x'] = 546.27, ['y'] = 2662.84, ['z'] = 42.16, ['h'] = 89.02, -- Posição -709.68,-904.07,19.22
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Loja Norte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Negozio Liquori'] = { -- Nome do estabelecimento
        ['x'] = 1126.86, ['y'] = -980.08, ['z'] = 45.42, ['h'] = 168.66, -- Posição -2959.59,387.15,14.05
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Negozio Liquori', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Liquori Nord'] = { -- Nome do estabelecimento
        ['x'] = 1169.24, ['y'] = 2717.79, ['z'] = 37.16, ['h'] = 8.67, -- Posição 1126.87,-980.14,45.42
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Liquori Nord', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Liquori Life'] = { -- Nome do estabelecimento
        ['x'] = -1479.13, ['y'] = -375.43, ['z'] = 39.17, ['h'] = 266.23, -- Posição 1169.3,2717.75,37.16
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000,   -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Liquori Life', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Praca'] = { -- Nome do estabelecimento
        ['x'] = 17.46, ['y'] = -1108.42, ['z'] = 29.8, ['h'] = 225.96, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 25000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuPraca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 1,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 2,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Porto'] = { -- Nome do estabelecimento
        ['x'] = 814.02, ['y'] = -2154.83, ['z'] = 29.62, ['h'] = 228.74, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 25000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuPorto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 1,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 2,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Teatro'] = { -- Nome do estabelecimento
        ['x'] = -1117.16, ['y'] = -503.12, ['z'] = 35.81, ['h'] = 119.74, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 300000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Teatro', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 10,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 14,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Prefettura'] = { -- Nome do estabelecimento
        ['x'] = 2468.95, ['y'] = -419.91, ['z'] = 93.4, ['h'] = 86.55, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 250000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Prefettura', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 12,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Porto'] = { -- Nome do estabelecimento
        ['x'] = 247.69, ['y'] = -3315.71, ['z'] = 5.8, ['h'] = 2.56, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 325000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Porto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 14,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 17,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Yatch'] = { -- Nome do estabelecimento
        ['x'] = -2124.79, ['y'] = -1005.02, ['z'] = 8.58, ['h'] = 2.56, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Yatch', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['FuenteBlanca'] = { -- Nome do estabelecimento
        ['x'] = 1459.92, ['y'] = 1133.96, ['z'] = 114.33, ['h'] = 128.29, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'FuenteBlanca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Osservatorio'] = { -- Nome do estabelecimento
        ['x'] = 717.6, ['y'] = 565.57, ['z'] = 129.23, ['h'] = 254.06, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Osservatorio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 12,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['MotoClub Sud'] = { -- Nome do estabelecimento
        ['x'] = 978.63, ['y'] = -91.92, ['z'] = 74.85, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 150000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'McSud', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 6,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 8,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Aeroporto abbandonato'] = { -- Nome do estabelecimento
        ['x'] = 2403.72, ['y'] = 3128.07, ['z'] = 48.16, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AeroAbbandonato', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 6,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 8,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Industria'] = { -- Nome do estabelecimento
        ['x'] = 2748.32, ['y'] = 1453.84, ['z'] = 24.5, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 250000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Industria', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Macelleria'] = { -- Nome do estabelecimento
        ['x'] = 968.74, ['y'] = -2160.42, ['z'] = 29.48, ['h'] = 79.52, -- Posição 968.74,-2160.42,29.48
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AçougueSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Trevor'] = { -- Nome do estabelecimento
        ['x'] = 1700.93, ['y'] = 3293.71, ['z'] = 48.93, ['h'] = 298.85, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AeroTrevor', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 300,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Resort'] = { -- Nome do estabelecimento
        ['x'] = -2953.17, ['y'] = 49.19, ['z'] = 11.61, ['h'] = 155.99, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 225000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Resort', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 300,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 7,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 12,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Zancudo'] = { -- Nome do estabelecimento
        ['x'] = -2357.13, ['y'] = 3251.32, ['z'] = 101.46, ['h'] = 149.3, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 300000,   -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Zancudo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 13,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 15,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Humane'] = { -- Nome do estabelecimento
        ['x'] = 3536.93, ['y'] = 3668.57, ['z'] = 28.13, ['h'] = 353.41, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 300000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Humane', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 15,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 16,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['DP di Paleto'] = { -- Nome do estabelecimento
        ['x'] = -450.81, ['y'] = 6011.2, ['z'] = 31.72, ['h'] = 135.86, -- Posição -450.81,6011.2,31.72
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'DipartimentoNord', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 12,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Yellow'] = { -- Nome do estabelecimento
        ['x'] = 1982.39, ['y'] = 3053.46, ['z'] = 47.22, ['h'] = 60.72, -- Posição 1982.39,3053.46,47.22
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 100000,  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Yellow', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 5,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 6,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial
        ['Prioridade'] = 'sul'
    },
    ['Comedy Club'] = { -- Nome do estabelecimento 
        ['x'] = -424.62, ['y'] = 284.1, ['z'] = 83.2, ['h'] = 82.21, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 15000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'ComedyClub', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 6,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 8, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul'
    },
    ['DP Sandy Shores'] = { -- Nome do estabelecimento 
        ['x'] = 1849.94, ['y'] = 3686.25, ['z'] = 34.27, ['h'] = 140.99, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'DipartimentoSandy', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 12,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Ippodromo'] = { -- Nome do estabelecimento 
        ['x'] = 1219.85, ['y'] = 333.3, ['z'] = 82.0, ['h'] = 291.57, -- Posição
        ['TempoRoubo'] = 40, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = 75000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Ippodromo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 4,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 6, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Posto Crips'] = { -- Nome do estabelecimento 
    	['x'] = 1200.38, ['y'] = -1277.13, ['z'] = 35.38, ['h'] = 169.99, -- Posição
    	['TempoRoubo'] = 30, -- Tempo que demorará pra terminar o roubo 
    	['Recompensa'] = 200000, -- Recompensa de dinheiro sujo no roubo
    	['TipoCooldown'] = 'Posto Crips', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
    	['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
    	['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
    	['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
    	['MaxPolizia'] = 12, 
    	['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
    	['Prioridade'] = 'sul' 
    },
    ['Mini Fattoria '] = { -- Nome do estabelecimento 
        ['x'] = 791.53, ['y'] = 2176.45, ['z'] = 52.64, ['h'] = 146.71, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Mini Fattoria', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Auditorium'] = { -- Nome do estabelecimento 
        ['x'] = 185.03, ['y'] = 1214.12, ['z'] = 225.6, ['h'] = 24.83, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Auditorium', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Playboy'] = { -- Nome do estabelecimento 
        ['x'] = -1537.18, ['y'] = 130.9, ['z'] = 57.38, ['h'] = 303.39, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Playboy', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10,
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },  
    ['Ricambi auto'] = { -- Nome do estabelecimento 
        ['x'] = 820.37, ['y'] = -808.43, ['z'] = 26.4, ['h'] = 78.7, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 125000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Ricambi auto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 5,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 7, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    }, 
    ['Festa Junina'] = { -- Nome do estabelecimento 
        ['x'] = 376.1, ['y'] = -347.01, ['z'] = 46.67, ['h'] = 84.98, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 125000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Festa Junina', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 6,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 8, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Planet'] = { -- Nome do estabelecimento 
        ['x'] = -700.61, ['y'] = -1142.68, ['z'] = 10.82, ['h'] = 217.55, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 150000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Planet', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 5,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 8, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Campo Da Golf'] = { -- Nome do estabelecimento 
        ['x'] = -1345.02, ['y'] = 47.12, ['z'] = 55.25, ['h'] = 83.94, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 175000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Campo De Golf', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 7,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 9, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Cimitero'] = { -- Nome do estabelecimento 
        ['x'] = -1685.26, ['y'] = -291.73, ['z'] = 51.9, ['h'] = 311.72, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 150000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Cimitero', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 6,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 8, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Mini Porto'] = { -- Nome do estabelecimento 
        ['x'] = -416.65, ['y'] = -2763.19, ['z'] = 6.01, ['h'] = 13.87, -- Posição
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 200000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Mini Porto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 8,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 10, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Ipermercato'] = { -- Nome do estabelecimento 
        ['x'] = 1082.5, ['y'] = -787.45, ['z'] = 58.36, ['h'] = 18.52,
        ['TempoRoubo'] = 30,  -- 
        ['Recompensa'] = 100000,
        ['TipoCooldown'] = 'Ipermercato',
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPolizia'] = 4,
        ['MaxPolizia'] = 6,
        ['PermDosPm'] = 'polizia.autorizzazione', 
        ['Prioridade'] = 'sul'
    },
    ['Vigile del fuoco'] = { -- Nome do estabelecimento 
        ['x'] = 210.05, ['y'] = -1656.84, ['z'] = 29.81, ['h'] = 42.3, -- Posição
        ['TempoRoubo'] = 30, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = 75000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Vigile del fuoco', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 4,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 5, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Fast Food'] = { -- Nome do estabelecimento 
        ['x'] = 1241.55, ['y'] = -367.21, ['z'] = 69.09, ['h'] = 351.88, -- Posição
        ['TempoRoubo'] = 70, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = 75000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fast Food', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 4,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 5, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Pescheria'] = { -- Nome do estabelecimento 
        ['x'] = -1039.12, ['y'] = -1353.37, ['z'] = 5.56, ['h'] = 201.09, -- Posição
        ['TempoRoubo'] = 30, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = 150000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Pescheria ', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 6,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 8, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Cartiera'] = { -- Nome do estabelecimento 
        ['x'] = -600.97, ['y'] = -1618.81, ['z'] = 33.02, ['h'] = 350.94, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = 300000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Cartiera', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 10,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 14, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Mc Donald'] = { -- Nome do estabelecimento 
        ['x'] = 81.33, ['y'] = 275.11, ['z'] = 110.22, ['h'] = 34.16, -- Posição
        ['TempoRoubo'] = 30, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = 100000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Mc Donald', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 4,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 6, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul'  
    },
    ['Spit Roasters'] = { -- Nome do estabelecimento 
    ['x'] = -231.79, ['y'] = 289.76, ['z'] = 92.06, ['h'] = 124.94, -- Posição
        ['TempoRoubo'] = 30, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = 75000, -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Spit Roasters', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 3,  -- Mínimo de poliziais em serviço pra iniciar o roubo
        ['MaxPolizia'] = 4, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
         ['Prioridade'] = 'sul' 
    }, 
    ['Ronnies'] = { -- Nome do estabelecimento 
        ['x'] = 170.56, ['y'] = -1723.51, ['z'] = 29.4, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000, -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Ronnies', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 2,  -- Mínimo de poliziais em serviço pra iniciar o roubo  
        ['MaxPolizia'] = 3, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
    ['Kaliclub'] = { -- Nome do estabelecimento 
        ['x'] = 1096.52, ['y'] = 74.61, ['z'] = 80.9, -- Posição  
        ['TempoRoubo'] = 30,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = 50000, -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Kali Club', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPolizia'] = 2,  -- Mínimo de poliziais em serviço pra iniciar o roubo  
        ['MaxPolizia'] = 3, 
        ['PermDosPm'] = 'polizia.autorizzazione', -- O que o sistema considerará polizial 
        ['Prioridade'] = 'sul' 
    },
}
---------------------------------------------------------------------------------------------------------
-- CÓDIGO
---------------------------------------------------------------------------------------------------------
local Roubando = false
local TempoRoubando = 0
local Recompensa = 0
local DelayPuxar = 0
local Estabelecimento = ''

Citizen.CreateThread(function() 
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if not Roubando then
            for k , v in pairs(Config) do
                local dist = Vdist2(pedCoords, v.x, v.y, v.z)
                if dist < 10 then
                    timeDistance = 4
                    if dist < 1.5 then
                        DrawText3Ds(v.x, v.y, v.z, '~w~PREMI ~p~[E] ~w~PER INIZIARE LA RAPINA')
                        if IsControlJustPressed(0,38) then
                            if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
                                if DelayPuxar <= 0 then
                                    if not vRP.getNearestPlayer(4) then
                                        DelayPuxar = math.random(10,45)
                                        if vSERVER.CheckCooldown(v.TipoCooldown, v.Cooldown, v.ItemReq, v.MinPolizia, v.PermDosPm, k, v.x, v.y, v.z,v.MaxPolizia, v.Prioridade) then
                                            FreezeEntityPosition(ped, true)
                                            Roubando = true
                                            TempoRoubando = v.TempoRoubo
                                            Recompensa = v.Recompensa
                                            Estabelecimento = k
                                            SetEntityHeading(ped, v.h)
                                        end
                                    else
                                        TriggerEvent('Notify', 'negato', 'Non ci può essere più di una persona vicina al furto.')
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            
            if Roubando and TempoRoubando <= 0 then
                vSERVER.nIOUGBAIksdnklajbIUYVBEW(Estabelecimento, Recompensa)
                TempoRoubando = 0 
                Roubando = false
                Recompensa = 0
                Estabelecimento = ''
                FreezeEntityPosition(ped, false)
                ClearPedTasks(ped)
                TriggerEvent('Notify', 'successo' ,'La <b>rapina</b> è <b>conclusa</b>.')
            end

        end

        if TempoRoubando > 0 then
            timeDistance = 1
            drawTxt('~w~ASPETTA ~y~' .. TempoRoubando .. ' ~w~SECONDI PER FINIRE', 4,0.5,0.93,0.45,255,255,255,255)
            drawTxt('~w~PREMI ~y~F7 ~w~PER CANCELLARE', 4,0.5,0.96,0.45,255,255,255,255)

            if IsControlJustPressed(0,168) or not IsEntityPlayingAnim(ped,"anim@heists@ornate_bank@grab_cash", "grab",3) then
                TempoRoubando = 0
                Roubando = false
                Recompensa = 0
                Estabelecimento = ''
                FreezeEntityPosition(ped, false)
                ClearPedTasks(ped)
                TriggerEvent('Notify', 'negato' , 'La <b>rapina</b> è stata <b>annullata</b>.')
            end

        end
        Citizen.Wait(timeDistance)
    end
end)

Citizen.CreateThread(function() 
    while true do
        Wait(1000)
        if Roubando then
            if TempoRoubando > 0 then
                TempoRoubando = TempoRoubando - 1
            end
        end

        if DelayPuxar > 0 then
            DelayPuxar = DelayPuxar - 1
        end
    end
end)

function src.SetMochila()
    SetPedComponentVariation(GetPlayerPed(-1),5,21,0,2)
	SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
end
---------------------------------------------------------------------------------------------------------
-- FUNCOES
---------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3Ds(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,47 ,57, 70,200)
	ClearDrawOrigin()
end



local blips = {}
local roubos = false
RegisterCommand("rapine",function(source, args)
        roubos = not roubos
        if roubos then
            TriggerEvent("Notify", "successo", "Aggiunte in mappa i blip delle rapine.")
            for k, v in pairs(Config) do
                blips[k] = AddBlipForCoord(v["x"], v["y"], v["z"])
                SetBlipSprite(blips[k], 310)
                SetBlipAsShortRange(blips[k], true)
                SetBlipColour(blips[k], 5)
                SetBlipScale(blips[k], 0.5)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("~y~<b>RAPINA:</b> ~w~" .. v["TipoCooldown"])
                EndTextCommandSetBlipName(blips[k])
            end
        else
            TriggerEvent("Notify", "avviso", "Rimossi blip delle rapine.")
            for k, v in pairs(blips) do
                if DoesBlipExist(v) then
                    RemoveBlip(v)
                end
            end
        end
    end
)