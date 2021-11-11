------------------------------------
------------------------------------
---- DONT TOUCH ANY OF THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
---- THESE ARE **NOT** CONFIG VALUES, USE THE CONVARS IF YOU WANT TO CHANGE SOMETHING
------------------------------------
------------------------------------

players = {}
banlist = {}

RegisterNetEvent("FacilAdmin:adminresponse")
RegisterNetEvent("FacilAdmin:amiadmin")
RegisterNetEvent("FacilAdmin:fillBanlist")
RegisterNetEvent("FacilAdmin:requestSpectate")

RegisterNetEvent("FacilAdmin:SetSetting")
RegisterNetEvent("FacilAdmin:SetLanguage")

RegisterNetEvent("FacilAdmin:TeleportRequest")
RegisterNetEvent("FacilAdmin:SlapPlayer")
RegisterNetEvent("FacilAdmin:FreezePlayer")
RegisterNetEvent("FacilAdmin:CaptureScreenshot")


AddEventHandler('FacilAdmin:adminresponse', function(response,permission)
	permissions[response] = permission
	if permission == true then
		isAdmin = true
	end
end)

AddEventHandler('FacilAdmin:SetSetting', function(setting,state)
	settings[setting] = state
end)

AddEventHandler('FacilAdmin:SetLanguage', function(newstrings)
	strings = newstrings
end)


AddEventHandler("FacilAdmin:fillBanlist", function(thebanlist)
	banlist = thebanlist
end)

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)
		if frozen then
			FreezeEntityPosition(PlayerPedId(), frozen)
			if IsPedInAnyVehicle(PlayerPedId(), true) then
				FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
			end 
		end
    players = {}
    local localplayers = {}
    for i = 0, 255 do -- infinite sluts!!!
      if NetworkIsPlayerActive( i ) then
        table.insert( localplayers, GetPlayerServerId(i) )
      end
    end
    table.sort(localplayers)
    for i,thePlayer in ipairs(localplayers) do
      table.insert(players,GetPlayerFromServerId(thePlayer))
    end
  end
end)

AddEventHandler('FacilAdmin:requestSpectate', function(playerId)
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
end)

AddEventHandler('FacilAdmin:TeleportRequest', function(px,py,pz)
	SetEntityCoords(PlayerPedId(), px,py,pz,0,0,0, false)
end)

AddEventHandler('FacilAdmin:SlapPlayer', function(slapAmount)
	if slapAmount > GetEntityHealth(PlayerPedId()) then
		SetEntityHealth(PlayerPedId(), 0)
	else
		SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())-slapAmount)
	end
end)


RegisterCommand("kick", function(source, args, rawCommand)
	local source=source
	local reason = ""
	for i,theArg in pairs(args) do
		if i ~= 1 then -- make sure we are not adding the kicked player as a reason
			reason = reason.." "..theArg
		end
	end
	if args[1] and tonumber(args[1]) then
		TriggerServerEvent("FacilAdmin:kickPlayer", tonumber(args[1]), reason)
	end
end, false)

RegisterCommand("ban", function(source, args, rawCommand)
	if args[1] and tonumber(args[1]) then
		local reason = ""
		for i,theArg in pairs(args) do
			if i ~= 1 then
				reason = reason.." "..theArg
			end
		end
		if args[1] and tonumber(args[1]) then
			TriggerServerEvent("FacilAdmin:banPlayer", tonumber(args[1]), reason, false, GetPlayerName(args[1]))
		end
	end
end, false)

AddEventHandler('FacilAdmin:FreezePlayer', function(toggle)
	frozen = toggle
	FreezeEntityPosition(PlayerPedId(), frozen)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
	end 
end)


AddEventHandler('FacilAdmin:CaptureScreenshot', function(toggle, url, field)
	exports['screenshot-basic']:requestScreenshotUpload(GetConvar("ea_screenshoturl", 'https://wew.wtf/upload.php'), GetConvar("ea_screenshotfield", 'files[]'), function(data)
			local resp = json.decode(data)
			TriggerServerEvent("FacilAdmin:TookScreenshot", resp.files[1].url)
	end)
end)

function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if targetPed == playerPed then enable = false end

	if(enable)then

			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(true, targetPed)

			DrawPlayerInfo(target)
			ShowNotification(string.format(GetLocalisedText("spectatingUser"), name))
	else

			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(false, targetPed)

			StopDrawPlayerInfo()
			ShowNotification(GetLocalisedText(stoppedSpectating))
	end
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end
