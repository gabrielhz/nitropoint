
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

--[[AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-image: linear-gradient(to right, rgba(36, 211, 242,1) 3%, rgba(36, 211, 242,0) 95%); border-radius: 15px 50px 30px 5px;"><i class="fab fa-twitter"></i> @{0}:<br>{1}</div>',
        args = { fal, message }
        })

    end
 end)]]

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

   -- if not WasEventCanceled() then
      --  TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    --end

    CancelEvent()
    end)

-- player join messages


-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                    })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
    end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
    end)
    
    ---------------------------------------------------------
    RegisterCommand('190', function(source, args, rawCommand)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            local player = vRP.getUserSource(user_id)
            local identity = vRP.getUserIdentity(user_id)
            TriggerClientEvent('chatMessage', -1, "".. identity.name .. " " .. identity.firstname ..": ", {0, 0, 255}, rawCommand:sub(4))
            vRP.log("logchat", "190", "Nome: "..identity.name.." "..identity.firstname.."\nID: "..user_id..".\n"..rawCommand:sub(4))
        end
    end)

    RegisterCommand('ilegal', function(source, args, rawCommand)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            local player = vRP.getUserSource(user_id)
            local identity = vRP.getUserIdentity(user_id)
            if not vRP.hasPermission(k, "policia.permissao") then
            TriggerClientEvent('chatMessage', -1, "Anônimo:", {000, 000, 000}, rawCommand:sub(7))
            vRP.log("logchat", "Ilegal", "ID: "..user_id..".\n"..rawCommand:sub(7))
        end
        end
    end)

    RegisterCommand('tw', function(source, args, rawCommand)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            local player = vRP.getUserSource(user_id)
            local identity = vRP.getUserIdentity(user_id)
            TriggerClientEvent('chatMessage', -1, "@".. identity.name .. " " .. identity.firstname ..": ", {0, 255, 247}, rawCommand:sub(4))
            vRP.log("logchat", "Twitter", "Nome: "..identity.name.." "..identity.firstname.."\nID: "..user_id..".\n"..rawCommand:sub(4))
        end
    end)

    RegisterCommand('olx', function(source, args, rawCommand)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            local player = vRP.getUserSource(user_id)
            local identity = vRP.getUserIdentity(user_id)
            TriggerClientEvent('chatMessage', -1,"".. identity.name .. " " .. identity.firstname ..": ", {180, 0, 150}, rawCommand:sub(4))
            vRP.log("logchat", "OLX", "Nome: "..identity.name.." "..identity.firstname.."\nID: "..user_id..".\n"..rawCommand:sub(4))
            CancelEvent()
        end
    end)
    
    
    RegisterCommand('192', function(source, args, rawCommand)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            local player = vRP.getUserSource(user_id)
            local identity = vRP.getUserIdentity(user_id)
            TriggerClientEvent('chatMessage', -1, "".. identity.name .. " " .. identity.firstname ..": ", {255, 0, 0}, rawCommand:sub(4))
            vRP.log("logchat", "192", "Nome: "..identity.name.." "..identity.firstname.."\nID: "..user_id..".\n"..rawCommand:sub(4))
        end
    end)

    RegisterCommand('admin', function(source, args, rawCommand)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            local player = vRP.getUserSource(user_id)
            local identity = vRP.getUserIdentity(user_id)
            if vRP.hasPermission(user_id, "owner.permissao") or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "wl.permissao") then
            TriggerClientEvent('chatMessage', -1, "Prefeitura: ", {72, 9, 135}, rawCommand:sub(7))
            vRP.log("logchat", "admin", "Nome: "..identity.name.." "..identity.firstname.."\nID: "..user_id..".\n"..rawCommand:sub(7))
            end
        end
    end)

    RegisterCommand('limpachat', function(source)
        local user_id = vRP.getUserId(source);
        if user_id ~= nil then
            if vRP.hasPermission(user_id, "admin.permissao") then
                TriggerClientEvent("chat:clear", -1);
            --  TriggerClientEvent("chatMessage", source, " ");
            else
                TriggerClientEvent("chat:clear", source);
                --TriggerClientEvent("chatMessage", source, "Você não tem permissão");
            end
        end
    end)