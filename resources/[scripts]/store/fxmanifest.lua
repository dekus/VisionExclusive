fx_version "cerulean"
game "gta5"

ui_page "src/dist/index.html"

files {
  "src/dist/index.html",
  "src/dist/assets/*.js",
  "src/dist/assets/*.css",
  "src/dist/img/*",
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