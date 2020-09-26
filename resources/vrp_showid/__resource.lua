description "vRP Showid"

dependency "vrp"

server_script { 
	"@vrp/lib/utils.lua",
	"server.lua",
}
