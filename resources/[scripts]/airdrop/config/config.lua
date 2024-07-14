_G.Index = {}; -- nao mexa

Index.Main = {
    --[[
        opcoes disponives de minutos: 

        60 - 1 minuto;
        120 - 2 minutos;
        180 - 3 minutos;
        240 - 4 minutos;
        300 - 5 minutos;
    ]]
    ['minutos'] = { -- Minuti per liberare l'airdrop (Secondi)
        45
    },

    ['cds'] = { -- coordenadas dos airdrops
        [1] = {['x'] = 978.17, ['y'] = -3086.34, ['z'] = 5.91, ['nome'] = 'Porto'},
        [2] = {['x'] = 591.66, ['y'] = -853.9, ['z'] = 41.36, ['nome'] = 'Ponte sud'},
        [3] = {['x'] = 1177.01, ['y'] = -1511.16, ['z'] = 34.7, ['nome'] = 'Parcheggio'},
        [4] = {['x'] = -205.3, ['y'] = -1799.76, ['z'] = 29.89, ['nome'] = 'Ponte'},
        [5] = {['x'] = -1304.63, ['y'] = -1589.25, ['z'] = 4.24, ['nome'] = 'Spiaggia'},
        [6] = {['x'] = 893.26, ['y'] = -2456.96, ['z'] = 28.58, ['nome'] = 'Magazzino Cipressi'},
        [7] = {['x'] = -1138.53, ['y'] = -523.52, ['z'] = 33.02, ['nome'] = 'Teatro'},
        [8] = {['x'] = -1173.04, ['y'] = -2609.28, ['z'] = 13.95, ['nome'] = 'Aeroporto'},
        [9] = {['x'] = 770.63, ['y'] = -234.66, ['z'] = 66.12, ['nome'] = 'Piccolo campo'},
        [10] = {['x'] = -1328.69, ['y'] = 107.08, ['z'] = 56.47, ['nome'] = 'Campo de Golf'},
        [11] = {['x'] = -2943.02, ['y'] = 2122.41, ['z'] = 41.08, ['nome'] = 'Strada'},
        [12] = {['x'] = -196.56, ['y'] = -2004.1, ['z'] = 27.63, ['nome'] = 'Stadio'},
        [14] = {['x'] = 1667.48, ['y'] = 4867.78, ['z'] = 42.08, ['nome'] = 'Norte 1'}
        --[15] = {['x'] = 1739.31, ['y'] = 3287.96, ['z'] = 41.13, ['nome'] = 'nil 1'},
       -- [16] = {['x'] = 2772.93, ['y'] = 3463.94, ['z'] = 55.55, ['nome'] = 'nil 1'},
        --[17] = {['x'] = 1044.28, ['y'] = 72.94, ['z'] = 81.89, ['nome'] = 'nil 1'},
       -- [18] = {['x'] = -2160.13, ['y'] = -399.51, ['z'] = 13.39, ['nome'] = 'nil 1'},
       -- [19] = {['x'] = -2241.49, ['y'] = 265.06, ['z'] = 174.62, ['nome'] = 'nil 1'}
    },

    ['time'] = { -- tempo in millisecondi, che l'airdrop cadrà dal cielo, più alto è questo numero più lentamente cadrà, più piccolo è il numero, più velocemente cadrà (consigliato 15 o 20)
        20
    },

    ['_reward'] = { -- Ricompense airdrop
        itens = {
            {'wbody|WEAPON_PISTOL_MK2', math.random(1, 3)},
            {'wammo|WEAPON_PISTOL_MK2', math.random(50, 150)},
            {'denarosporco', math.random(25000, 100000)},
            {'melzinho', math.random(1,2)},
        }
    },

    ['webhook'] = { -- webhook de ganhadores
        'https://discord.com/api/webhooks/1130285781676720299/2Y-P3LypjSdN9nBBUdNhdCppzBZrVgZR0zn4DlcVHNp-5XOvxfHE1iDAtcDaOuGI3s6u'
    },

    ['permission'] = { -- permissao para soltar o airdrop
        'support.autorizzazione'
    },

    ['delay'] = { -- delay pra soltar airdrop
        3
    },

    ['delayToRobbery'] = { -- tempo de roubo do air drop em milisegundos
        200
    }
};

return Index; -- nao mexa