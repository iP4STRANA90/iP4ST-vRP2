description "vRP paycheck"
--ui_page "ui/index.html"

dependency "vrp"

server_script "@vrp/lib/utils.lua"
server_script "server.lua"
