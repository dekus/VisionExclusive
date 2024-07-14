fx_version "cerulean"
game "gta5"

files {
	"dist/*",
	"dist/assets/*.css",
	"dist/assets/*.js",
}

ui_page "dist/index.html"


shared_script {
	"@vrp/lib/utils.lua"
}

client_scripts {
	"src/client.lua"
}

server_scripts {
	"src/server.lua"
}