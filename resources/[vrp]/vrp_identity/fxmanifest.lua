fx_version "bodacious"
game "gta5"

ui_page "dist/index.html"
ui_page_preload "yes"

shared_script {
	"@vrp/lib/utils.lua",
	"shared/*.lua"
}

client_scripts {
	"client/*.lua"
}

server_scripts {
	"server/*.lua"
}

files {
	"dist/index.html",
	"dist/assets/*"
}