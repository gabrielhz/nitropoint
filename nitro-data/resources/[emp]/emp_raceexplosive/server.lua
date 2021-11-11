local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_raceexplosive",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookcorrida = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local pay = {
	[1] = { ['min'] = 10000, ['max'] = 15000 },
	[2] = { ['min'] = 10000, ['max'] = 15000 },
	[3] = { ['min'] = 10000, ['max'] = 15000 },
	[4] = { ['min'] = 10000, ['max'] = 15000 },
	[5] = { ['min'] = 8500, ['max'] = 12500 },
	[6] = { ['min'] = 10000, ['max'] = 15000 },
	[7] = { ['min'] = 12000, ['max'] = 17000 },
	[8] = { ['min'] = 8500, ['max'] = 12500 },
	[9] = { ['min'] = 12000, ['max'] = 17000 },
	[10] = { ['min'] = 12000, ['max'] = 17000 }
}

function emP.paymentCheck(check,status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local random = math.random(pay[check].min,pay[check].max)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if parseInt(#policia) >= 3 then
			vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(random*status))
		else
			vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt((random*#policia)*status)*0.25)
		end
	end
end

local racepoint = 1
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(180000)
		racepoint = math.random(#pay)
	end
end)

function emP.getRacepoint()
	return parseInt(racepoint)
end

function emP.startBombRace()
	local source = source
	local policia = vRP.getUsersByPermission("policia.permissao")
	TriggerEvent('eblips:add',{ name = "Corredor", src = source, color = 83 })
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Encontramos um corredor ilegal na cidade, intercepte-o.")
			end)
			
		end
	end
end

function emP.setSearchTimer()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,parseInt(600))
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	SendWebhookMessage(webhookcorrida,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.searchReturn(source,user_id))
end

RegisterCommand('unbomb',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,5)
		if nplayer then
			TriggerClientEvent('emp_race:unbomb',nplayer)
			TriggerClientEvent("Notify",source,"sucesso","Você desarmou a <b>Bomba</b> com sucesso.")
		end
	end
end)

function emP.removeBombRace()
	local source = source
	TriggerEvent('eblips:remove',source)
end