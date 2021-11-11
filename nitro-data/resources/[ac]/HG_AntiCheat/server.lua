--[[
    FiveM Scripts
	The Official HackerGeo Script 
	Credits - HackerGeo
	Website - www.HackerGeo.com
	GitHub - GITHUB.com/HackerGeo-sp1ne
	Steam - SteamCommunity.com/id/HackerGeo1
	Copyright 2019 ©HackerGeo. All rights served
]]

------------------------------------------------------WARNING-----------------------------------------------------
---------------------Do not reupload/re release any part of this script without my permission---------------------
------------------------------------------------------------------------------------------------------------------


local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

ExecuteCommand(('sets AntiCheat "Ativado"')) -- add: "add_ace resource.hg_anticheat command.sets allow" in server.cfg
---------------------------------
----------- WEBHOOK -------------
---------------------------------
-- mudar o link
--local webhookanticheat = "https://discordapp.com/api/webhooks/714982596765024310/lPjnXQriokKpJBve273TX8zoF1nQL1nFQzMUygprMQdou8UoKDCp3xdy0VQJ33frwoYl"
--function SendWebhookMessage(webhook,message)
--	if webhook ~= nil and webhook ~= "" then
--		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
--	end
--end

RegisterServerEvent("HG_AntiCheat:Cars")
AddEventHandler("HG_AntiCheat:Cars", function()
	local source = source
	local user_id = vRP.getUserId(source)
	local cfg = getConfig()
	if user_id then
	vRP.setBanned(user_id,true)
	DropPlayer(source, cfg.anticheat.name.." "..cfg.cars.kick.."! ("..cfg.cars.reason..")")
	vRP.setWhitelisted(user_id,false)
--	SendWebhookMessage(webhookanticheat,"```prolog\n[AVISO]\nUm player do ID: "..user_id.." foi kickado pelo anti-cheat por spawnar um veículo não permitido!"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	vRP.log("anticheat", "Anticheat Ban","ID: "..user_id.."\nBlacklist Vehicle Spawn")
	end
end)

--RegisterServerEvent("HG_AntiCheat:Weaponban")
--AddEventHandler("HG_AntiCheat:Weaponban", function()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	local cfg = getConfig()
--	if user_id then
--	vRP.setBanned(user_id,true)
--	DropPlayer(source, cfg.anticheat.name.."Banido da cidade, se acha que foi um erro contate nossa equipe no discord.")
--	vRP.setWhitelisted(user_id,false)
--	SendWebhookMessage(webhookanticheat,"```prolog\n[AVISO]\nUm player do ID: "..user_id.." foi kickado pelo anti-cheat por spawnar um veículo não permitido!"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--	vRP.log("anticheat", "Anticheat Ban","ID: "..user_id.."\nBlacklist Weapon Spawn")
--	end
--end)

--RegisterServerEvent("HG_AntiCheat:Jump")
--AddEventHandler("HG_AntiCheat:Jump", function()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	local cfg = getConfig()
--	if user_id then
--	DropPlayer(source, cfg.anticheat.name.." "..cfg.jump.kick.."! ("..cfg.jump.reason..")")
--	SendWebhookMessage(webhookanticheat,"```prolog\n[AVISO]\nUm player do ID: "..user_id.." foi kickado pelo anti-cheat por fazer um Super Pulo!"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--	end
--end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local resourceName = ""..GetCurrentResourceName()..""
	local cfg = getConfig()
	vRPclient.notifyPicture(source,{"CHAR_LESTER",1,cfg.anticheat.name,false,cfg.anticheat.protect})
end)

AddEventHandler('playerConnecting', function(playerName, kick)
	local mysource = source
	local identifiers = GetPlayerIdentifiers(mysource)
	local steamid = identifiers[1]
	local cfg = getConfig()
	if cfg.anticheat.steam_require then
		if steamid:sub(1,6) == "steam:" then
		else
			kick(cfg.anticheat.name..""..cfg.anticheat.steam)
			CancelEvent()
		end
	end
end)

RegisterCommand("ac", function(source)
	local user_id = vRP.getUserId({source})	
	local player = vRP.getUserSource({user_id})
	local name = GetPlayerName(source)
	local cfg = getConfig()
    if vRP.hasPermission({user_id, cfg.anticheat.perm}) then
	TriggerClientEvent("HG_AntiCheat:Toggle", -1, 1)
    else
	vRPclient.notifyPicture(source,{"CHAR_LESTER",1,cfg.anticheat.name,false,cfg.anticheat.no_perm})
    end
end)

PerformHttpRequest( "https://www.hackergeo.com/anticheat.txt", function( err, text, headers )
	Citizen.Wait( 1000 )
	local resourceName = "("..GetCurrentResourceName()..")"
	local cfg = getConfig()
	RconPrint( "\n"..cfg.version.current..": " ..cfg.version.version)
	
	if ( text ~= cfg.version.version ) then
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t|| ".. resourceName .." "..cfg.version.outdated.."! ||\n\t|| "..cfg.version.download.." ||\n\t||    "..cfg.version.from.."   ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	else
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t||                             ||\n\t||".. resourceName .." "..cfg.version.updated.."!||\n\t||                             ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	end
end, "GET", "", { what = 'this' } )
