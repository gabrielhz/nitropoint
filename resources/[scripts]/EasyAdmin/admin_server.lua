------------------------------------
------------------------------------
---- DONT TOUCH ANY OF THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
---- THESE ARE **NOT** CONFIG VALUES, USE THE CONVARS IF YOU WANT TO CHANGE SOMETHING
------------------------------------
------------------------------------
-- THIS IS OBSOLETE NOW, PLEASE USE THE WIKI TO ADD ADMINS
admins = {}
-- THIS IS OBSOLETE NOW, PLEASE USE THE WIKI TO ADD ADMINS
permissions = {
	ban = false,
	kick = false,
	spectate = false,
	unban = false,
	teleport = false,
	manageserver = false,
	slap = false,
	freeze = false,
	screenshot = false,
	immune = false,
	anon = false,
	mute = false,
}
-- Muted Players Table
MutedPlayers = {} 


AnonymousAdmins = {}
Citizen.CreateThread(function()
	local strfile = LoadResourceFile(GetCurrentResourceName(), "language/"..GetConvar("ea_LanguageName", "pt")..".json")
	if strfile then
		strings = json.decode(strfile)[1]
	else
		strings = {language=GetConvar("ea_LanguageName", "pt")}
	end
	
	
	moderationNotification = GetConvar("ea_moderationNotification", "false")
	if GetConvar("ea_enableDebugging", "false") == "true" then
		enableDebugging = true
		PrintDebugMessage("^1Debug Messages Enabled, Anonymous Admins may not be anonymous!")
	else
		enableDebugging = false
	end
	minimumMatchingIdentifiers = GetConvarInt("ea_minIdentifierMatches", 1)
	
	RegisterServerEvent('FacilAdmin:amiadmin')
	AddEventHandler('FacilAdmin:amiadmin', function()
		
		local identifiers = GetPlayerIdentifiers(source)
		for perm,val in pairs(permissions) do
			local thisPerm = DoesPlayerHavePermission(source,"Faciladmin."..perm)
			if perm == "screenshot" and not screenshots then
				thisPerm = false
			end
			TriggerClientEvent("FacilAdmin:adminresponse", source, perm,thisPerm)
			PrintDebugMessage("Processed Perm "..perm.." for "..getName(source)..", result: "..tostring(thisPerm))
		end
		
		if DoesPlayerHavePermission(source,"Faciladmin.ban") then
			TriggerClientEvent('chat:addSuggestion', source, '/ban', GetLocalisedText("chatsuggestionban"), { {name='player id', help="the player's server id"}, {name='reason', help="your reason."} } )
		end
		if DoesPlayerHavePermission(source,"Faciladmin.kick") then
			TriggerClientEvent('chat:addSuggestion', source, '/kick', GetLocalisedText("chatsuggestionkick"), { {name='player id', help="the player's server id"}, {name='reason', help="your reason."}} )
		end
		if DoesPlayerHavePermission(source,"Faciladmin.spectate") then
			TriggerClientEvent('chat:addSuggestion', source, '/spectate', GetLocalisedText("chatsuggestionspectate"), { {name='player id', help="the player's server id"} })
		end
		if DoesPlayerHavePermission(source,"Faciladmin.unban") then
			TriggerClientEvent('chat:addSuggestion', source, '/unban', GetLocalisedText("chatsuggestionunban"), { {name='identifier', help="the identifier ( such as steamid, ip or license )"} })
		end
		if DoesPlayerHavePermission(source,"Faciladmin.teleport") then
			TriggerClientEvent('chat:addSuggestion', source, '/teleport', GetLocalisedText("chatsuggestionteleport"), { {name='player id', help="the player's server id"} })
		end
		if DoesPlayerHavePermission(source,"Faciladmin.manageserver") then
			TriggerClientEvent('chat:addSuggestion', source, '/setgametype', GetLocalisedText("chatsuggestiongametype"), { {name='game type', help="the game type"} })
			TriggerClientEvent('chat:addSuggestion', source, '/setmapname', GetLocalisedText("chatsuggestionmapname"), { {name='map name', help="the map name"} })
		end
		
		if DoesPlayerHavePermission(source,"Faciladmin.slap") then
			TriggerClientEvent('chat:addSuggestion', source, '/slap', GetLocalisedText("chatsuggestionslap"), { {name='player id', help="the player's server id"},{name='hp', help="the hp to take"} })
		end
		
		if DoesPlayerHavePermission(source,"Faciladmin.freeze") then
			TriggerClientEvent('chat:addSuggestion', source, '/freeze', GetLocalisedText("chatsuggestionfreeze"), { {name='player id', help="the player's server id"},{name='toggle', help="either true or false"} })
		end
		
		-- give player the right settings to work with
		TriggerClientEvent("FacilAdmin:SetSetting", source, "button",GetConvarInt("ea_MenuButton", 289) )
		if GetConvar("ea_alwaysShowButtons", "false") == "true" then
			TriggerClientEvent("FacilAdmin:SetSetting", source, "forceShowGUIButtons", true)
		else
			TriggerClientEvent("FacilAdmin:SetSetting", source, "forceShowGUIButtons", false)
		end
		
		TriggerClientEvent("FacilAdmin:SetLanguage", source, strings)
		
	end)
	
	RegisterServerEvent("FacilAdmin:kickPlayer")
	AddEventHandler('FacilAdmin:kickPlayer', function(playerId,reason)
		if DoesPlayerHavePermission(source,"Faciladmin.kick") and not DoesPlayerHavePermission(playerId,"Faciladmin.immune") then
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminkickedplayer"), getName(source), getName(playerId), reason))
			PrintDebugMessage("Kicking Player "..getName(source).." for "..reason)
			DropPlayer(playerId, string.format(GetLocalisedText("kicked"), getName(source), reason) )
		end
	end)
	
	RegisterServerEvent("FacilAdmin:requestSpectate")
	AddEventHandler('FacilAdmin:requestSpectate', function(playerId)
		if DoesPlayerHavePermission(source,"Faciladmin.spectate") then
			PrintDebugMessage("Player "..getName(source,true).." Requested Spectate to "..getName(playerId,true))
			TriggerClientEvent("FacilAdmin:requestSpectate", source, playerId)
		end
	end)
	
	RegisterServerEvent("FacilAdmin:SetGameType")
	AddEventHandler('FacilAdmin:SetGameType', function(text)
		if DoesPlayerHavePermission(source,"Faciladmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Gametype to "..text)
			SetGameType(text)
		end
	end)
	
	RegisterServerEvent("FacilAdmin:SetMapName")
	AddEventHandler('FacilAdmin:SetMapName', function(text)
		if DoesPlayerHavePermission(source,"Faciladmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Map Name to "..text)
			SetMapName(text)
		end
	end)
	
	RegisterServerEvent("FacilAdmin:StartResource")
	AddEventHandler('FacilAdmin:StartResource', function(text)
		if DoesPlayerHavePermission(source,"Faciladmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." started Resource "..text)
			StartResource(text)
		end
	end)
	
	RegisterServerEvent("FacilAdmin:StopResource")
	AddEventHandler('FacilAdmin:StopResource', function(text)
		if DoesPlayerHavePermission(source,"Faciladmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." stopped Resource "..text)
			StopResource(text)
		end
	end)
	
	
	RegisterServerEvent("FacilAdmin:banPlayer")
	AddEventHandler('FacilAdmin:banPlayer', function(playerId,reason,expires,username)
		if playerId ~= nil then
			if DoesPlayerHavePermission(source,"Faciladmin.ban") and getName(playerId) == username and not DoesPlayerHavePermission(playerId,"Faciladmin.immune") then
				local playerLicense = ""
				local playerSteamid = ""
				local playerDiscordid = ""
				local bannedIdentifiers = GetPlayerIdentifiers(playerId)
				if expires < os.time() then
					expires = os.time()+expires 
				end
				reason = reason.. string.format(GetLocalisedText("reasonadd"), getName(playerId), getName(source) )
				local ban = {identifiers = bannedIdentifiers, banner = getName(source, true), reason = reason, expire = expires or 10444633200 }
				updateBlacklist( ban )
				PrintDebugMessage("Player "..getName(source,true).." banned player "..getName(playerId,true).." for "..reason)
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminbannedplayer"), getName(source), getName(playerId), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ))
				DropPlayer(playerId, string.format(GetLocalisedText("banned"), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ) )
			end
		end
	end)
	
	AddEventHandler('banCheater', function(playerId,reason)
		if not reason then reason = "Cheating" end
		if getName(source) ~= "Console" then return end
		local bannedIdentifiers = GetPlayerIdentifiers(playerId)
		reason = reason.. string.format(GetLocalisedText("bancheatingadd"), getName(playerId), getName(source) )
		local ban = {identifiers = bannedIdentifiers, banner = "Anticheat", reason = reason, expire = expires or 10444633200 }
		
		updateBlacklist( ban )
		PrintDebugMessage("Console banned player "..getName(playerId,true).." for "..reason)
		SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminbannedplayer"), 'Console', getName(playerId), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires or 10444633200 ) ))
		DropPlayer(playerId, GetLocalisedText("bancheating"))
	end)
	
	AddEventHandler("FacilAdmin:addBan", function(playerId,reason,expires)
		local playerLicense = ""
		local playerSteamid = ""
		local playerDiscordid = ""
		local bannedIdentifiers = GetPlayerIdentifiers(playerId)
		if expires < os.time() then
			expires = os.time()+expires 
		end
		reason = reason.. string.format(GetLocalisedText("reasonadd"), getName(playerId), "Console" )
		local ban = {identifiers = bannedIdentifiers,  banner = "Unknown", reason = reason, expire = expires or 10444633200 }
		updateBlacklist( ban )
		
		
		PrintDebugMessage("Player "..getName(source,true).." added ban "..reason)
		SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminbannedplayer"), "Console", getName(playerId), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ))
		DropPlayer(playerId, string.format(GetLocalisedText("banned"), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ) )
	end)
	
	RegisterServerEvent("FacilAdmin:updateBanlist")
	AddEventHandler('FacilAdmin:updateBanlist', function(playerId)
		local src = source
		if DoesPlayerHavePermission(source,"Faciladmin.kick") then
			updateBlacklist(false,true)
			Citizen.Wait(300)
			TriggerClientEvent("FacilAdmin:fillBanlist", src, blacklist)
			PrintDebugMessage("Banlist Refreshed by "..getName(src,true))
		end
	end)
	
	RegisterServerEvent("FacilAdmin:requestBanlist")
	AddEventHandler('FacilAdmin:requestBanlist', function(playerId)
		local src = source
		if DoesPlayerHavePermission(source,"Faciladmin.kick") then
			TriggerClientEvent("FacilAdmin:fillBanlist", src, blacklist)
			PrintDebugMessage("Banlist Requested by "..getName(src,true))
		end
	end)
	
	
	------------------------------ COMMANDS
	
	RegisterCommand("addadmin", function(source, args, rawCommand)
		if args[1] and tonumber(args[1]) then
			local numIds = GetPlayerIdentifiers(args[1])
			for i,theId in ipairs(numIds) do
				if string.find(theId, "license:") then
					updateAdmins(theId)
					TriggerClientEvent("FacilAdmin:adminresponse", args[1], true)
					TriggerClientEvent("chat:addMessage", args[1], { args = { "FacilAdmin", GetLocalisedText("newadmin") } })
					PrintDebugMessage("Player "..getName(source,true).." added "..getName(args[1],true).." as legacy admin.")
					Citizen.Trace("FacilAdmin: player has been added as an admin!")
				end
			end
		elseif args[1] and string.find(args[1], "steam:") or string.find(args[1], "license:") or string.find(args[1], "ip:") then
			updateAdmins(args[1])
			Citizen.Trace("FacilAdmin: identifier has been added as an admin!")
		else
			Citizen.Trace("FacilAdmin: Unable to Add Admin ( player id invalid / invalid identifier? )\n")
		end
	end, true)
	
	
	RegisterCommand("spectate", function(source, args, rawCommand)
		if(source == 0) then
			Citizen.Trace(GetLocalisedText("badidea")) -- Maybe should be it's own string saying something like "only players can do this" or something
		end
		
		PrintDebugMessage("Player "..getName(source,true).." Requested Spectate on "..getName(args[1],true))
		
		if args[1] and tonumber(args[1]) and DoesPlayerHavePermission(source,"Faciladmin.spectate") then
			if getName(args[1]) then
				TriggerClientEvent("FacilAdmin:requestSpectate", source, args[1])
			else
				TriggerClientEvent("chat:addMessage", source, { args = { "FacilAdmin", GetLocalisedText("playernotfound") } })
			end
		end
	end, false)
	
	RegisterCommand("unban", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"Faciladmin.unban") then
			PrintDebugMessage("Player "..getName(source,true).." Unbanned "..args[1])
			UnbanIdentifier(args[1])
			if (source ~= 0) then
				TriggerClientEvent("chat:addMessage", source, { args = { "FacilAdmin", GetLocalisedText("done") } })
			else
				Citizen.Trace(GetLocalisedText("done"))
			end
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunbannedplayer"), getName(source), args[1])) -- Use the "safe" getName function instead.
		end
	end, false)
	
	RegisterCommand("teleport", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"Faciladmin.teleport") then
			PrintDebugMessage("Player Requested Teleport something")
			-- not yet
		end
	end, false)
	
	RegisterCommand("setgametype", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"Faciladmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Gametype to "..args[1])
			SetGameType(args[1])
		end
	end, false)
	
	RegisterCommand("setmapname", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"Faciladmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Map Name to "..args[1])
			SetMapName(args[1])
		end
	end, false)

	RegisterCommand("slap", function(source, args, rawCommand)
		if args[1] and args[2] and DoesPlayerHavePermission(source,"Faciladmin.slap") then
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminslappedplayer"), getName(source), getName(args[1]), args[2]))
			PrintDebugMessage("Player "..getName(source,true).." slapped "..getName(args[1],true).." for "..args[2].." HP")
			TriggerClientEvent("FacilAdmin:SlapPlayer", args[1], args[2])
		end
	end, false)	
	
	RegisterServerEvent("FacilAdmin:TeleportPlayerToCoords")
	AddEventHandler('FacilAdmin:TeleportPlayerToCoords', function(playerId,px,py,pz)
		if DoesPlayerHavePermission(source,"Faciladmin.teleport") then
			PrintDebugMessage("Player "..getName(source,true).." requsted teleport to "..px..", "..py..", "..pz)
			TriggerClientEvent("FacilAdmin:TeleportRequest", playerId, px,py,pz)
		end
	end)
	
	RegisterServerEvent("FacilAdmin:SlapPlayer")
	AddEventHandler('FacilAdmin:SlapPlayer', function(playerId,slapAmount)
		if DoesPlayerHavePermission(source,"Faciladmin.slap") then
			PrintDebugMessage("Player "..getName(source,true).." slapped "..getName(playerId,true).." for "..slapAmount.." HP")
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminslappedplayer"), getName(source), getName(playerId), slapAmount))
			TriggerClientEvent("FacilAdmin:SlapPlayer", playerId, slapAmount)
		end
	end)
	
	RegisterServerEvent("FacilAdmin:FreezePlayer")
	AddEventHandler('FacilAdmin:FreezePlayer', function(playerId,toggle)
		if DoesPlayerHavePermission(source,"Faciladmin.freeze") then
			if toggle then
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminfrozeplayer"), getName(source), getName(playerId)))
				PrintDebugMessage("Player "..getName(source,true).." froze "..getName(playerId,true))
			else
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunfrozeplayer"), getName(source), getName(playerId)))
				PrintDebugMessage("Player "..getName(source,true).." unfroze "..getName(playerId,true))
			end
			TriggerClientEvent("FacilAdmin:FreezePlayer", playerId, toggle)
		end
	end)
	
	RegisterServerEvent("FacilAdmin:TookScreenshot")
	
	RegisterServerEvent("FacilAdmin:TakeScreenshot")
	AddEventHandler('FacilAdmin:TakeScreenshot', function(playerId)
		if scrinprogress then
			TriggerClientEvent("chat:addMessage", source, { args = { "FacilAdmin", GetLocalisedText("screenshotinprogress") } })
			return
		end
		scrinprogress = true
		local src=source
		local playerId = playerId

		if DoesPlayerHavePermission(source,"Faciladmin.screenshot") then
			thistemporaryevent = AddEventHandler("FacilAdmin:TookScreenshot", function(resultURL)
				TriggerClientEvent('chat:addMessage', src, { template = '<img src="{0}" style="max-width: 400px;" />', args = { resultURL } })
				TriggerClientEvent("chat:addMessage", src, { args = { "FacilAdmin", string.format(GetLocalisedText("screenshotlink"), resultURL) } })
				PrintDebugMessage("Screenshot for Player "..getName(playerId,true).." done, "..resultURL.." requsted by"..getName(src,true))
				SendWebhookMessage(moderationNotification, string.format(GetLocalisedText("admintookscreenshot"), getName(src), getName(playerId), resultURL))
				scrinprogress = false
				RemoveEventHandler(thistemporaryevent)
			end)
			
			TriggerClientEvent("FacilAdmin:CaptureScreenshot", playerId)
			local timeoutwait = 0
			repeat
				timeoutwait=timeoutwait+1
				Wait(5000)
				if timeoutwait == 5 then
					RemoveEventHandler(thistemporaryevent)
					scrinprogress = false -- cancel screenshot, seems like it failed
					TriggerClientEvent("chat:addMessage", src, { args = { "FacilAdmin", "Screenshot Failed!" } })
				end
			until not scrinprogress
		end
	end)
	
	RegisterServerEvent("FacilAdmin:unbanPlayer")
	AddEventHandler('FacilAdmin:unbanPlayer', function(playerId)
		if DoesPlayerHavePermission(source,"Faciladmin.unban") then
			UnbanIdentifier(playerId)
			PrintDebugMessage("Player "..getName(source,true).." unbanned "..playerId)
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunbannedplayer"), getName(source), playerId))
		end
	end)

	RegisterServerEvent("FacilAdmin:mutePlayer")
	AddEventHandler('FacilAdmin:mutePlayer', function(playerId)
		local src = source
		if DoesPlayerHavePermission(src,"Faciladmin.mute") then
			if not MutedPlayers[playerId] then 
				MutedPlayers[playerId] = true
				TriggerClientEvent("chat:addMessage", src, { args = { "FacilAdmin", getName(playerId) .. " " .. GetLocalisedText("playermuted") } })
				PrintDebugMessage("Player "..getName(source,true).." muted "..getName(playerId,true))
			else 
				MutedPlayers[playerId] = nil
				TriggerClientEvent("chat:addMessage", src, { args = { "FacilAdmin", getName(playerId) .. " " .. GetLocalisedText("playerunmuted") } })
				PrintDebugMessage("Player "..getName(source,true).." unmuted "..getName(playerId,true))
			end
		end
	end)

	RegisterServerEvent("FacilAdmin:SetAnonymous")
	AddEventHandler('FacilAdmin:SetAnonymous', function(playerId)
		if DoesPlayerHavePermission(source,"Faciladmin.anon") then
			if AnonymousAdmins[source] then
				AnonymousAdmins[source] = nil
				PrintDebugMessage("Player "..getName(source,true).." un-anoned himself")
			else
				AnonymousAdmins[source] = true
				PrintDebugMessage("Player "..getName(source,true).." anoned himself")
			end
		end
	end)
	
	function DoesPlayerHavePermission(player, object)
		local haspermission = false
		
		if (player == 0) then
			return true
		end-- Console. It's assumed this will be an admin with access. If not, why the fuck are they giving random people access?
		
		if IsPlayerAceAllowed(player,object) then -- check if the player has access to this permission
			haspermission = true
		else
			haspermission = false
		end
		
		if not haspermission then -- if not, check if they are admin using the legacy method.
			local numIds = GetPlayerIdentifiers(player)
			for i,admin in pairs(admins) do
				for i,theId in pairs(numIds) do
					if admin == theId then
						haspermission = true
					end
				end
			end
		end
		return haspermission
	end
	
	blacklist = {}
	
	function updateAdmins(addItem)
		admins = {}
		local content = LoadResourceFile(GetCurrentResourceName(), "admins.txt")
		if not content then
			return -- instead of re-creating the file, just quit, we dont need to continue anyway.
		end
		if not addItem then
			for index,value in ipairs(mysplit(content, "\n")) do
				admins[index] = value -- update admin list
			end
		else
			if string.len(content) > 1 then
				content = content.."\n"..addItem
			else
				content = content..""..addItem
			end
			for index,value in ipairs(mysplit(content, "\n")) do
				admins[index] = value -- update admin list
			end
		end
		
		for i,theKey in ipairs(GetPlayers()) do
			local numIds = GetPlayerIdentifiers(theKey)
			for i,admin in ipairs(admins) do
				for i,theId in ipairs(numIds) do
					if admin == theId .. '\r' or admin == theId then -- is the player an admin?
						TriggerClientEvent("FacilAdmin:adminresponse", theKey, true)
					end
				end
			end
		end
		
		SaveResourceFile(GetCurrentResourceName(), "admins.txt", content, -1)
	end

	RegisterCommand("convertbanlist", function(source, args, rawCommand)
		if GetConvar("ea_custombanlist", "false") == "true" then
			local content = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
			local ob = json.decode(content)
			for i,theBan in ipairs(ob) do
				TriggerEvent("ea_data:addBan", theBan)
				print("processed ban: "..i.."\n")
			end
			content=nil
		else
			print("Custom Banlist is not enabled, converting back to json.")
			TriggerEvent('ea_data:retrieveBanlist', function(banlist)
				blacklist = banlist
				for i,theBan in ipairs(blacklist) do
					if not theBan.identifiers then theBan.identifiers = {} end
					theBan.banid = nil
					if theBan.steam then
						table.insert(theBan.identifiers, theBan.steam)
						theBan.steam=nil
					end
					if theBan.identifier then
						table.insert(theBan.identifiers, theBan.identifier)
						theBan.identifier=nil
					end
					if theBan.discord then
						table.insert(theBan.identifiers, theBan.discord)
						theBan.discord=nil
					end
				end
				SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
			end)
		end
	end, true)
	
	--[[
		Very basic function that turns "source" into a useable player name.
	]]
	function getName(src,anonymousdisabled)
		if (src == 0 or src == "") then
			return "Console"
		else
			if AnonymousAdmins[src] and not anonymousdisabled then
				return GetLocalisedText("anonymous")
			elseif (GetPlayerName(src)) then
				return GetPlayerName(src)
			else
				return "Unknown - " .. src
			end
		end
	end
	
	
	function updateBlacklist(data,remove)
		-- life is pain, if you think this code sucks, SUCK MY DICK and make it better
		if GetConvar("ea_custombanlist", "false") == "true" then 
			
			if data and not remove then
				table.insert(blacklist, data)
				TriggerEvent("ea_data:addBan", data)
				
			elseif data and remove then
					for i,theBan in ipairs(blacklist) do
						for index,identifier in ipairs(theBan.identifiers) do
							if data.identifier == identifier then
								table.remove(blacklist,i)
								PrintDebugMessage("removed ban as per custombanlist remove")
								TriggerEvent("ea_data:removeBan", theBan)
								break
							end
						end
					end
					
			elseif not data then
				TriggerEvent('ea_data:retrieveBanlist', function(banlist)
					blacklist = banlist
					PrintDebugMessage("updated banlist custom banlist")
					for i,theBan in ipairs(blacklist) do
						if theBan.expire < os.time() then
							table.remove(blacklist,i)
							PrintDebugMessage("removing old ban custom banlist")
							TriggerEvent("ea_data:removeBan", theBan)
						end
					end
				end)
			end
			return
		end
		
		local content = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
		if not content then
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode({}), -1)
			content = json.encode({})
		end
		blacklist = json.decode(content)
		
				
		local txtcontent = LoadResourceFile(GetCurrentResourceName(), "banlist.txt") -- compat
		if not txtcontent then txtcontent = "" end
		if string.len(txtcontent) > 5 then
			for index,value in ipairs(mysplit(txtcontent, "\n")) do
				curstring = "" -- make a new string
				for i = 1, #value do -- loop trough every character of "value" to determine if it's part of the identifier or reason
					if string.sub(value,i,i) == ";" then break end -- end the loop if we reached the "reason" part
					curstring = curstring..string.sub(value,i,i) -- add our current letter to our string
				end
				local reason = string.match(value, "^.*%;(.*)" ) or GetLocalisedText("nongiven") -- get the reason from the string or use "none given" if it's nil
				local reason = string.gsub(reason,"\r","")
				table.insert(blacklist, {identifier = curstring, reason = reason, expire = 10444633200 }) -- we need an expire time here, anything will do, lets make it christmas!
			end
			SaveResourceFile(GetCurrentResourceName(), "banlist.txt", "", 0) -- overwrite banlist with emptyness, we dont even need this file, but sadly we cant delete it :(
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
		end
		

		PrintDebugMessage("updated banlist")
		if not blacklist then
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
			print("FacilAdmin: ^1Failed^7 to load Banlist!\n")
			print("FacilAdmin: Please check this error soon, ^1Bans *will not* work!^7\n")
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
		end
		
		if blacklist[1] and (blacklist[1].identifier or blacklist[1].steam or blacklist[1].discord) then -- more compat
			Citizen.Trace("Upgrading Banlist...\n")
			for i,ban in ipairs(blacklist) do
				if not ban.identifiers then
					ban.identifiers = {}
				end
				if ban.identifier then
					table.insert(ban.identifiers, ban.identifier)
					ban.identifier = nil
				end
				if ban.steam then
					table.insert(ban.identifiers, ban.steam)
					ban.steam = nil
				end
				if ban.discord and ban.discord ~= "" then
					table.insert(ban.identifiers, ban.discord)
					ban.discord = nil
				end
			end
			Citizen.Trace("Banlist Upgraded! No Further Action is necesarry.\n")
		end

		
		if data and not remove then
			table.insert(blacklist, data)
		elseif not data then
			for i,theBan in ipairs(blacklist) do
				if theBan.expire < os.time() then
					table.remove(blacklist,i)
					PrintDebugMessage("removing old ban no custom banlist")
				elseif theBan.expire == 1924300800 then
					blacklist[i].expire = 10444633200
				end
			end
		end
		if data and remove then
			for i,theBan in ipairs(blacklist) do
				for index,identifier in ipairs(theBan.identifiers) do
					if data.identifier == identifier then
						table.remove(blacklist,i)
						PrintDebugMessage("removing ban as ordered by remove param")
						break
					end
				end
			end
		end
		SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
	end



	
	function IsIdentifierBanned(theIndentifier)
		local identifierfound = false
		for index,value in ipairs(blacklist) do
			for i,identifier in ipairs(value.identifiers) do
				if theIndentifier == identifier then
					identifierfound = true
				end
			end
		end
		return identifierfound
	end
	
	function BanIdentifier(identifier,reason)
		updateBlacklist( {identifiers = {identifier} , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function BanIdentifiers(identifier,reason)
		updateBlacklist( {identifiers = identifier , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function UnbanIdentifier(identifier)
		for i,ban in ipairs(blacklist) do
			for index,id in ipairs(ban.identifiers) do
				if identifier == id then
					table.remove(blacklist,i)
					PrintDebugMessage("removed ban as per unbanidentifier func")
					return
				end 
			end
		end
	end
	
	AddEventHandler('playerConnecting', function(playerName, setKickReason)
		local numIds = GetPlayerIdentifiers(source)
		local matchingIdentifiers = 0
		for bi,blacklisted in ipairs(blacklist) do
			for i,theId in ipairs(numIds) do
				for ci,identifier in ipairs(blacklisted.identifiers) do
					if identifier == theId then
						matchingIdentifiers = matchingIdentifiers+1
						PrintDebugMessage("IDENTIFIER MATCH! "..identifier.." Required: "..matchingIdentifiers.."/"..minimumMatchingIdentifiers)
						if matchingIdentifiers >= minimumMatchingIdentifiers then
							setKickReason(string.format( GetLocalisedText("bannedjoin"), blacklist[bi].reason, os.date('%d/%m/%Y 	%H:%M:%S', blacklist[bi].expire )))
							PrintDebugMessage("FacilAdmin: Connection of "..GetPlayerName(source).." Declined, Banned for "..blacklist[bi].reason.." \n")
							CancelEvent()
							return
						end
					end
				end
			end
		end
	end)


	AddEventHandler('chatMessage', function(Source, Name, Msg)
		if MutedPlayers[Source] then
			CancelEvent()
			TriggerClientEvent("chat:addMessage", Source, { args = { "FacilAdmin", GetLocalisedText("playermute") } })
		end
	end)
	
	
	---------------------------------- USEFUL
	
	function SendWebhookMessage(webhook,message)
		if webhook ~= "false" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
	
	function mysplit(inputstr, sep)
		if sep == nil then
			sep = "%s"
		end
		local t={} ; i=1
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			t[i] = str
			i = i + 1
		end
		return t
	end
	
	
	local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
	local curVersion = json.decode(verFile).version
	local updatePath = "/Bluethefurry/FacilAdmin"
	local resourceName = "FacilAdmin ("..GetCurrentResourceName()..")"
	function checkVersion(err,response, headers)
		if err == 200 then
			local data = json.decode(response)
			if curVersion ~= data.version and tonumber(curVersion) < tonumber(data.version) then
				print("\n--------------------------------------------------------------------------")
				print("\n"..resourceName.." is outdated.\nCurrent Version: "..data.version.."\nYour Version: "..curVersion.."\nPlease update it from https://github.com"..updatePath.."")
				print("\nUpdate Changelog:\n"..data.changelog)
				print("\n--------------------------------------------------------------------------")
			elseif tonumber(curVersion) > tonumber(data.version) then
				print("Your version of "..resourceName.." seems to be higher than the current version.")
			else
				print(resourceName.." is up to date!")
			end
		else
			print("FacilAdmin Version Check failed!")
		end
		local screenshottest = LoadResourceFile("screenshot-basic", "__resource.lua")
		if not screenshottest then
			print("\n--------------------------------------------------------------------------")
			print("\nscreenshot-basic is not installed on this Server, this means that the screenshot feature will not be available, please download and install it from:")
			print("\nhttps://github.com/citizenfx/screenshot-basic")
			print("\n--------------------------------------------------------------------------")
		else
			StartResource("screenshot-basic")
			screenshots = true
		end
		
		SetTimeout(3600000, checkVersionHTTPRequest)
	end
	
	function checkVersionHTTPRequest()
		PerformHttpRequest("https://raw.githubusercontent.com/Bluethefurry/FacilAdmin/master/version.json", checkVersion, "GET")
	end
	
	function loopUpdateBlacklist()
		updateBlacklist()
		SetTimeout(300000, loopUpdateBlacklist)
	end
	
	function loopUpdateAdmins()
		updateAdmins()
		SetTimeout(300000, loopUpdateAdmins)
	end
	
	---------------------------------- END USEFUL
	loopUpdateBlacklist()
	loopUpdateAdmins()
	checkVersionHTTPRequest()
end)
