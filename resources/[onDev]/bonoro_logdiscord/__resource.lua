--Arcadia logger by Wezli

dependency "vrp"

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server.lua",
}

client_script 'client.lua'