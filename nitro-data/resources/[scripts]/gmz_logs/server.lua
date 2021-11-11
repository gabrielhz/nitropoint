local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local logs = {
	{ key = "admin", url = "https://discordapp.com/api/webhooks/739193634892808212/gDNmWocNFLvsNyy5qlif7QVa67Vtqq2aUZopz-6InDoX0FZ0MzliChIEE2KekXJ1RKLX"},
	{ key = "logchat", url = "https://discordapp.com/api/webhooks/739194059725340692/XFJxQwBEIOFjCufUW7rGHhBiFBmhe1SlFZDfvuiEjFSuuUQSwq718V5AJ428a5kMIlR8"},
	{ key = "webhook", url = "https://discordapp.com/api/webhooks/739196214842622052/V_gxfmOU_dePtGieXoe7xQIBaMpkBY_JSKBAG6an9Q-B3pHmF2FiF0vXoojGbEDXCFo-"},
	{ key = "kickban", url = "https://discordapp.com/api/webhooks/739193634892808212/gDNmWocNFLvsNyy5qlif7QVa67Vtqq2aUZopz-6InDoX0FZ0MzliChIEE2KekXJ1RKLX"},
	{ key = "dinheiro", url = "https://discordapp.com/api/webhooks/739194214423986186/N12zRSaTa_AIu8uGkh7LRhoVQmacZayV8Wz6xK1jGwB59dz0PJtmL-9ckXBIrAnTSyx7"},
	{ key = "roubos", url = "https://discordapp.com/api/webhooks/739196214842622052/V_gxfmOU_dePtGieXoe7xQIBaMpkBY_JSKBAG6an9Q-B3pHmF2FiF0vXoojGbEDXCFo-"},
	{ key = "itemrecebido", url = "https://discordapp.com/api/webhooks/739196214842622052/V_gxfmOU_dePtGieXoe7xQIBaMpkBY_JSKBAG6an9Q-B3pHmF2FiF0vXoojGbEDXCFo-"},
	{ key = "bau", url = "https://discordapp.com/api/webhooks/739194490304331787/vLew2wC9s1UmOiTirNmEwwWyxwMZaXGRZYnW_7LbZQPM6g5SHIgrXoe6wDV6W2Eg1W0s"},
	{ key = "log", url = "https://discordapp.com/api/webhooks/739555719610761247/W9QQlTAhJGldKMHO3U0v6M8RMCp3S0qaEEVf14cztsjFGKZVYWYGWulLWfqev1si6XgS"},
	{ key = "killog", url = "https://discordapp.com/api/webhooks/739196536373903392/q_yDZ0uKjaKNE4Umd3a-resPlHOr0o1yuUAGMpm_n3Gi9t5qK2I91SkpbMoRXqJHF7jW"},
	{ key = "antijogo", url = "https://discordapp.com/api/webhooks/739196214842622052/V_gxfmOU_dePtGieXoe7xQIBaMpkBY_JSKBAG6an9Q-B3pHmF2FiF0vXoojGbEDXCFo-"},
	{ key = "anticheat", url = "https://discordapp.com/api/webhooks/739195548220784770/_jRb2E8X_6v1ocivUb4ycRLh7UcNHsnp4vYEd1X5MX8h9cbzIwtUBZSxFBQgOy1-tMmI"},
	{ key = "blkey", url = "https://discordapp.com/api/webhooks/739196006914326599/8ApFPOBimThSHX22uTk2pw4OCdz4BiglJdAGLRpLW6ogc-5vsMAZF3L00l8MdnIjOKWV"}
}

AddEventHandler("gmz:loadLogs", function(cb)
    cb(json.encode(logs))
end)

RegisterCommand('logtest',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local message = vRP.prompt(source,"Mensagem para teste:","")
		if message == "" then
			return
		end
		vRP.log("admin", "Teste de Log", message)
	end
end)