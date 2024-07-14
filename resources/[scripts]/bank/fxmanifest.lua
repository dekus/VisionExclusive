fx_version "cerulean"
game "gta5"

files {
    "src/nui/**",
}

ui_page "src/nui/index.html"

shared_scripts {
    "src/config.lua"
}

client_scripts {
    "@vrp/lib/utils.lua",
    "src/client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "src/server.lua"
}