--  CONFIGURAÇÃO --

local timezone = -4

-------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","damn_logger")

local hour
local minute
local webhooklinkserver = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"
local webhooklinkchat = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"
local webhooklinkdeath = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"
local webhooklinkmoney = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"
local webhooklinkinout = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"
local webhooklinkcriminal = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"
local webhooklinkchest = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"
local webhooklinkthief = "https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5"

--[[function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end]]

function log(file,info)
  file = io.open(file, "a")
  if file then
    file:write(""..info.."\n")
  end
  file:close()
end

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        attHora()
    end
end)]]

AddEventHandler("vRP:playerJoin",function(user_id,source,name)
	vRP.log("log", "Conectou","ID: "..user_id)
end)

AddEventHandler("vRP:playerRejoin",function(user_id,source,name)
	vRP.log("log", "Reconectou","ID: "..user_id)
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	vRP.log("log", "Desconectou","ID: "..user_id)
end)


RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason)
	local user_id = vRP.getUserId(source)

    if killer == "**Invalid**" then --Can't figure out what's generating invalid, it's late. If you figure it out, let me know. I just handle it as a string for now.
        reason = 2
    end
	if reason == 0 then
		vRP.log("killog", "Suicídio","ID: "..user_id.." era depressivo e se matou.")
 --       TriggerClientEvent('showNotification', -1,"~o~"..user_id.."~w~ committed suicide.")
	elseif reason == 1 then
		vRP.log("killog", "Assasinato","ID: "..killer.."\nMatou: "..user_id)
 --       TriggerClientEvent('showNotification', -1,"~o~"..killer.. "~w~ killed ~o~"..user_id.."~w~.")
	else
		vRP.log("killog", "Morreu","ID: "..user_id)
 --       TriggerClientEvent('showNotification', -1,"~o~"..user_id.."~w~ died.")
    end
end)

--[[RegisterServerEvent('DMN:regLogChest')
AddEventHandler('DMN:regLogChest',function(msg)
	local content12 = "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```"
	PerformHttpRequest(webhooklinkchest, function(err, text, headers) end, 'POST', json.encode({username = "Log's", content = content12}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('DMN:regLog')
AddEventHandler('DMN:regLog',function(msg)
	local content13 = "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```"
	PerformHttpRequest(webhooklinkserver, function(err, text, headers) end, 'POST', json.encode({username = "Log's", content = content13}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent('DMN:regLogThief')
AddEventHandler('DMN:regLogThief',function(msg)
	local content14 = "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```"
	PerformHttpRequest(webhooklinkthief, function(err, text, headers) end, 'POST', json.encode({username = "Log's", content = content14}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent('DMN:regLogCriminal')
AddEventHandler('DMN:regLogCriminal',function(msg)
	local content15 = "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```"
	PerformHttpRequest(webhooklinkcriminal, function(err, text, headers) end, 'POST', json.encode({username = "Log's", content = content15}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('DMN:moneyLog')
AddEventHandler('DMN:moneyLog',function()
	local user_id = vRP.getUserId(source)
	local money = vRP.getMoney(user_id)
	local bmoney = vRP.getBankMoney(user_id)
	local content16 = "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source).." [user_id ".. user_id .." | CARTEIRA: $ ".. money .." | BANCO: $ ".. bmoney .."```"
	PerformHttpRequest(webhooklinkmoney, function(err, text, headers) end, 'POST', json.encode({username = "Log's", content = content16}), { ['Content-Type'] = 'application/json' })

end)
]]--