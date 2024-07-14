fx_version 'bodacious'
game 'gta5'

ui_page "src/dist/index.html"
ui_page_preload 'yes'

client_scripts {
	"src/client.lua"
}

server_scripts {
	"src/server.lua"
}

shared_scripts { -- :)
	"@vrp/lib/utils.lua"
}

files {
	'src/dist/*',
	'src/dist/**/*',
	'src/dist/**/**/*'
}

                            