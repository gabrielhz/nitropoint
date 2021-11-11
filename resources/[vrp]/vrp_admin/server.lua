local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"dv.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"diretor.permissao") or vRP.hasPermission(user_id,"chefe.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source,7)
        if vehicle then
            TriggerClientEvent('deletarveiculo',source,vehicle)
        end
    end
end)
RegisterNetEvent('deletarveiculo')
AddEventHandler('deletarveiculo',function(vehicle)
    TriggerServerEvent("vrp_garages:admDelete",VehToNet(vehicle))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh")
AddEventHandler("trydeleteveh",function(index)
	TriggerClientEvent("syncdeleteveh",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped",function(index)
	TriggerClientEvent("syncdeleteped",-1,index)
end)
-- LIMPAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpainv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"god.permissao") then
        vRP.clearInventory(user_id)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVER TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
RegisterCommand('reviveall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            vRPclient.setHealth(rsource, 400)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUXAR TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            if rsource ~= source then
                vRPclient.teleport(rsource,x,y,z)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
	TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"fix.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('reparar',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent("syncarea",-1,x,y,z)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"god.permissao") then
		local mensagemgod = vRP.prompt(source,"Motivo:","")
		if mensagemgod == "" then
			return
		end
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,400)
				vRP.log("kickban", "God", "Administrador: "..user_id.."\nTarget: "..nplayer.."\nMotivo: "..mensagemgod)
				end
		else
			vRPclient.killGod(source)
			vRPclient.setHealth(source,400)
			vRPclient.setArmour(source,100)
			vRP.log("kickban", "God", "Administrador: "..user_id.."\nMotivo: "..mensagemgod)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS ON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('players',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
    TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Jogadores online: "..onlinePlayers)
end)  
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehash',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if uplayer then
			local mensagem = "O administrador: "..user_id.." tentou abusar de seus comandos."
			vRPclient.setDiv(uplayer,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: Administrador")
			SetTimeout(60000,function()
				vRPclient.removeDiv(uplayer,"anuncio")
				vRP.log("kickban", "ADMIN", "Administrador: "..user_id.."\nTentou utilizar o /tuning.")
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"wl.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),true)
			vRP.log("kickban", "Whitelist", "Administrador: "..user_id.."\nWhitelisted: "..parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"wl.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
			vRP.log("kickban", "Tirar Whitelist", "Administrador: "..user_id.."\nUnwhitelisted: "..parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"kick.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
				vRP.log("kickban", "Kick", "Administrador: "..user_id.."\nKick: "..parseInt(args[1]))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ban.permissao") then
        if args[1] then
            local id = vRP.getUserSource(parseInt(args[1]))
            vRP.setBanned(parseInt(args[1]),true)
            vRP.kick(id,"Você foi expulso da cidade.")
			vRP.setWhitelisted(parseInt(args[1]),false)
			vRP.log("kickban", "Banido", "Administrador: "..user_id.."\nBaniu: "..parseInt(args[1]))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"unban.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
			vRP.log("kickban", "Desbanido", "Administrador: "..user_id.."\nDesbaniu: "..parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"money.permissao") then
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
			vRP.log("kickban", "Money", "Administrador: "..user_id.."\nQuantidade: "..parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"noclip.permissao") then
		vRPclient.toggleNoclip(source)
		vRP.log("kickban", "NC", "Administrador: "..user_id.."\nNoclip ")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:",x..","..y..","..z)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('group',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]),args[2])
		end
		vRP.log("kickban", "Grupo", "Administrador: "..user_id.."\nID: "..parseInt(args[1]).."\nGrupo: "..args[2])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ungroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]),args[2])
		end
		vRP.log("kickban", "Remover Grupo", "Administrador: "..user_id.."\nID: "..parseInt(args[1]).."\nGrupo: "..args[2])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	  vRP.log("kickban", "TPTOME", "Administrador: "..user_id.."\nID: "..parseInt(args[1]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
		vRP.log("kickban", "TPTO", "Administrador: "..user_id.."\nID: "..parseInt(args[1]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		TriggerClientEvent('tptoway',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"spawncar.permissao") then
	local mensagemcar = vRP.prompt(source,"Motivo:","")
	if mensagemcar == "" then
		return
	end
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
		end
		vRP.log("kickban", "Veículo", "Administrador: "..user_id.."\nVeículo: "..args[1].."\nMotivo: "..mensagemcar)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	if vRP.hasPermission(user_id,"msg.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: Administrador")
		vRPclient.playSound(-1,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		SetTimeout(60000,function()
			vRPclient.removeDiv(-1,"anuncio")
			vRP.log("logchat", "Anúncio ADMIN", "Administrador: "..user_id.."\nMensagem: "..mensagem)
		end)
	end
end)

RegisterServerEvent("treak:press")
AddEventHandler("treak:press", function(key)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local keyAscii = "" .. key
		if key == 288 then keyAscii = "F1" end
		if key == 172 then keyAscii = "Arrow Up" end
		if key == 173 then keyAscii = "Arrow Down" end
		if key == 344 then keyAscii = "F11" end
		if key == 108 then keyAscii = "N4" end
		if key == 111 then keyAscii = "N8" end
		if key == 112 then keyAscii = "N5" end
		if key == 121 then keyAscii = "Insert" end
--		SendWebhookMessage(ac_webhook_keys, "**ADMIN Press Monitor Key** \n```\nUser ID: "..user_id.." Key: "..keyAscii.." ```")
		vRP.log("blkey", "Blacklisted Keys","ID: "..user_id.."\nKey: "..keyAscii)
	end
end)