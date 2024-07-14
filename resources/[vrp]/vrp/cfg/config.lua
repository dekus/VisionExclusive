
Config              		= {}
Config.DrawDistance         = 1.5
Config.RemoteDistance		= 15.0

Config.speed_up         	= 0.0060
Config.speed_down       	= 0.0060
Config.max              	= 30.75
Config.min              	= 28.84

Config.AreaToCheck 			= vector3(-8.59, -1675.81, 29.48)

Config.Oilchange 			= vector3(-6.91, -1675.14, 29.48)
Config.Oilchange2 			= vector3(-10.93, -1676.69, 29.48)

Config.LiftControlPanel 	= { x = -5.97, y = -1671.45, z = 29.48 }
Config.LiftControlPanel2 	= { x = -9.94, y = -1673.09, z = 29.48 }

Config.HiddenFountain		= { x= -1.03, y= -1664.53, z= 29.48 }




_G.Config = {};


Config.Main = {
    ["db_driver"] = {
        'oxmysql'
    },

    ["Bancadedados"] = {
        'vision'
    },

    ["webhookjoins"] = {
        'https://discord.com/api/webhooks/1130291127430430730/Lqd2M6KRDk4fTm2F2DWUDrkzfyZDlMd3bq3xu8kKIOdm2J5IDrPL4wG2ZzpGvNgTKQtR'
    },

    ['webhookexit'] = {
        'https://discord.com/api/webhooks/1130291371962540136/ejfGnCgeVpQ7D1slHRfsIJxH36NqZB3FkCo0zOP-olsnCsjxM54VJCgC1tat1XwFvu1o'
    },

    ['webhookmorto'] = {
        'https://discord.com/api/webhooks/1130292402087796826/DU5VwF4k3E5Ck0kQUlrcbmFGz-NHdGpQSRKZO3SQuNxKV4k8IDQvaFtLcTGUUB40nKa5'
    },
    ['discord'] = {
        'https://discord.gg/visionexclusive'
    }
};

return Config;
