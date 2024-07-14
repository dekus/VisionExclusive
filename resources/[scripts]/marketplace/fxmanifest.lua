fx_version 'bodacious'
game 'gta5'

ui_page 'src/dist/index.html'
ui_page_preload 'yes'


client_scripts {
	"src/client/*"
}
shared_scripts {
	"@vrp/lib/utils.lua",
	"config.lua"
}

server_scripts {
	"src/server/*"
}

files {
	'src/dist/assets/*',
	'src/dist/*',
}