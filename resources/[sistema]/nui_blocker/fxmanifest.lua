 
fx_version 'bodacious'
game 'gta5'


client_script {
			"@vrp/lib/utils.lua",
			"client/main.lua"
}
server_script {
	"@vrp/lib/utils.lua",
	"server/server.lua",
	"permissions.lua"
}

ui_page 'client/index.html'

files {
	'client/index.html'
}

              