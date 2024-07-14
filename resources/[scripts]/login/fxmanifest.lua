fx_version "bodacious"
game "gta5"

ui_page "dist/index.html"

shared_script {
    "@vrp/lib/utils.lua"
}

client_script {
    "client.lua",
    "config/config_client.lua",
}

server_script {
    "server.lua",
    "config/config_server.lua",
}

files {
    "dist/*",
    "dist/**/**/*"
}