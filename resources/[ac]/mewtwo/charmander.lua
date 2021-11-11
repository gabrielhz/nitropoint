Proxy = module("vrp", "lib/Proxy")
Tunnel = module("vrp", "lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

local webhook = "https://discordapp.com/api/webhooks/739195548220784770/_jRb2E8X_6v1ocivUb4ycRLh7UcNHsnp4vYEd1X5MX8h9cbzIwtUBZSxFBQgOy1-tMmI"

local enviado = false

function sendToDiscord(name, message, text)
    local connect = {
          {
            ["color"] = 8663711,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = text,
            },
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) if text ~= nil then enviado = true end end, 'POST', json.encode({username = "CAÇADOR DE HACKERS", embeds = connect}), { ['Content-Type'] = 'application/json' })
end
-----------------------------------------------------------------------------------
----------------------------------[[BANIMENTO]]------------------------------------
-----------------------------------------------------------------------------------
local motivos = {}
motivos["OBJETOS"]=true
motivos["PEDS"]=true
motivos["EXPLOSOES"]=true
motivos["DINHEIRO"]=false -- NÃO ATIVE CASO NÃO TENHA CONCLUIDO A MUDANÇA DOS EVENTOS.
motivos["SPAWNER"]=true
motivos["SPECTADOR"]=true
motivos["INJECT"]=true
motivos["BLIPS"]=true
motivos["EXECUTOR"]=true
motivos["MONSTERMENU"]=true

RegisterServerEvent('DHAC:banir')
AddEventHandler('DHAC:banir', function(user_id, msg, arg)
    if not vRP.hasPermission(user_id, "ac.permissao") then
        if(motivos[msg]~=nil)then
            if(motivos[msg]==true)then
                local id = user_id
                local source = vRP.getUserSource(user_id)
                local x,y,z = vRPclient.getPosition(source)
                vRP.setBanned(user_id, true)
                local hora = os.date("%x %X")
                sendToDiscord(msg, '[ID]: '..id..' FOI BANIDO DO SERVIDOR', '[DATA]: '..hora..', [ARG]: '..arg..', [COORDENADAS]: '..x..', '..y..', '..z)
                local source = vRP.getUserSource(id)
                if source ~= nil then
                    if webhook ~= nil or webhook ~= "" then
                        if enviado then
                            enviado = false
                            vRP.kick(source, "You have been globally banned from FiveM for cheating. This ban will expire in 365 days + 23:59:58. Please do note that the FiveM staff can not assist you with this ban.")						
                        end
                    else
                        vRP.kick(source, "You have been globally banned from FiveM for cheating. This ban will expire in 365 days + 23:59:58. Please do note that the FiveM staff can not assist you with this ban.")						
                    end
                end
            else
                local hora = os.date("%x %X")
                sendToDiscord(msg, '[ID]: '..user_id..' FOI DETECTADO COMO SUSPEITO.', '[DATA]: '..hora..', [ARG]: '..arg)
            end
        else
            local hora = os.date("%x %X")
            sendToDiscord(msg, 'FUNÇÃO NÃO DETECTADA', '[ID]: '..user_id, '[DATA]: '..hora)
        end
    end
end)