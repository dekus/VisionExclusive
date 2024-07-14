fx_version "bodacious"
game "gta5"

ui_page_preload "yes" 
ui_page "web-side/index.html"

files {
	'web-side/*',
	'web-side/**/*',
	'web-side/**/**/*'
}

client_script {
	"@vrp/lib/utils.lua",
	"client-side/*.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server-side/config.lua", 
	"server-side/server.lua"
}                            