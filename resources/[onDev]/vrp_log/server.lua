
--configs
local AvatarURL = 'https://cdn.discordapp.com/attachments/661387442984583188/676090231811866634/Ops.png'
local Webhook = 'https://discordapp.com/api/webhooks/730054635246714951/kbUQ4vKqY-7cIV-xHkmhCC8AKeI21nHmwqRKDGSUW-66QgcicrpXyLjJuG7dA2hFwrq5'

local WebHookChat = 'https://discordapp.com/api/webhooks/730054755572777050/a2O7U7i0NwX_CksHnN_x2Ju2ap1cZlCvoMmBXc8y3tDSc7wkellGC39g5OY3BTMT6BLN'

local WebHookEnterExit = 'https://discordapp.com/api/webhooks/730055094699294721/D6rVfMqtAFFcyu96X4H8Uc8gYGyu2HwN4p3sm4wwt52-O-IDsOg-ICICKouJswYClGHQ'

local WebHookAdmin = 'https://discordapp.com/api/webhooks/730055281878499329/3o2Kcr4OxPppfWCrX7JYPGNmFXSWMIXHxiUX2caO_Vy0U_3usldaouV5guKUzRVLJCdA'

local WebHookInventory = 'https://discordapp.com/api/webhooks/730055351914725407/GD2118l3X-uC45-9MET1SNtKGEYw-h4eIvJzlhBW3S-h-qLHdgZ1mR0xSkPWST5WgFC_'

local WebHookRoubos = 'https://discordapp.com/api/webhooks/730055442192924712/-UL9924SZjlFbDCVwVaMeXs3jc37DBhNOE2v9L8h4ixDI0GmyDdken-XCCDL7V4iMhg7'

local valor_ticket = 40000


RegisterServerEvent("log:hoppe")
AddEventHandler("log:hoppe", function(text)
	TriggerEvent('DiscordBot:ToDiscord', Webhook, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:chat")
AddEventHandler("log:hoppe:chat", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookChat, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:admin")
AddEventHandler("log:hoppe:admin", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookAdmin, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:enterexit")
AddEventHandler("log:hoppe:enterexit", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookEnterExit, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:inventory")
AddEventHandler("log:hoppe:inventory", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookInventory, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:roubos")
AddEventHandler("log:hoppe:roubos", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookRoubos, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterCommand("logtest", function(source,args)
	TriggerEvent("log:hoppe",args[1])
end)


RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, External, TTS)
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)

AddEventHandler("vRP:playerLeave", function(user_id, group, gtype)
	TriggerEvent("log:hoppe:enterexit","```ID "..user_id.." saiu do servidor Data: "..os.date("%H:%M:%S").."```")
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	TriggerEvent("log:hoppe:enterexit","```ID "..user_id.." entrou no servidor Data: "..os.date("%H:%M:%S").."```")
end)