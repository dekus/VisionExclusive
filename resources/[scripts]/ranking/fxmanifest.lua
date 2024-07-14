fx_version "cerulean"
game "gta5"

name "Ranking OneSource"
author "OneSource | Xisto#0999 & Marquez#3443"

files {
    "dist/**",
}

ui_page "dist/index.html"


shared_scripts  {
    "@vrp/lib/utils.lua",
    "config.lua"
}

client_scripts {
    "src/client.lua"
}

server_scripts {
    "src/server.lua"
}