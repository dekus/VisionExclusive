fx_version "bodacious"
game "gta5"

ui_page "ui/index.html"

shared_script {
	"config.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"__vRP__.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"__vRP__.lua",
	"server/*"
}

files {
    "ui/*",
    "ui/**/*"
}