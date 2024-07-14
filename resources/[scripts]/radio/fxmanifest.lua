fx_version "cerulean"
game "gta5"

ui_page "src/dist/index.html"

files {
  "src/dist/index.html",
  "src/dist/**/*"
}


shared_scripts {
  "@vrp/lib/utils.lua",
  "config.lua"
}

client_scripts {
  "src/client/*"
}

server_scripts {
  "src/server/*",
}