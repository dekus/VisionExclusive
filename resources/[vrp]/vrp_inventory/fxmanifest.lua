fx_version 'bodacious'
game 'gta5'

ui_page "nui/index.html"
ui_page_preload 'yes'

client_scripts {
	"@vrp/lib/utils.lua",
	"target.lua",
	"client.lua",
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"nui/*.html",
	"nui/*.css",
	"nui/*.js",
}                                                                                                                                                                                                                                                            