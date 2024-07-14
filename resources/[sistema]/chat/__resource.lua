fx_version "bodacious"
game "gta5"
ui_page "html/index.html"

client_scripts {
    "@vrp/lib/utils.lua",
    "cl_chat.lua"
}
server_scripts {
    "@vrp/lib/utils.lua",
    "sv_chat.lua",
    "ban.lua",
    "kitiniziale.lua"
}
files {
    "html/*",
    "html/**/*",
    
}