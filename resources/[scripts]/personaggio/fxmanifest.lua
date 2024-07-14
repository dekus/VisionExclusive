fx_version 'bodacious'
game 'gta5'

dependency "vrp"

ui_page_preload "yes"
ui_page "character-nui/index.html"

files {
    "character-nui/index.html",
    "character-nui/style.css",
    "character-nui/vue.js",
    "character-nui/*.js",
}

server_scripts {
  '@vrp/lib/utils.lua',
  'server.lua'
}

client_scripts {
  '@vrp/lib/utils.lua',
  'client.lua'
}