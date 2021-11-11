local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_mafia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "armamentos-comprar-hkp7m10" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_PISTOL_MK2")
	elseif data == "armamentos-comprar-uzi" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-comprar-mtar21" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-comprar-ak103" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_ASSAULTRIFLE_MK2")
	elseif data == "armamentos-comprar-magnum44" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_PUMPSHOTGUN_MK2")
	elseif data == "armamentos-comprar-thompson" then
		 TriggerServerEvent("mafia-comprar","wbody|WEAPON_GUSENBERG")
    elseif data == "armamentos-comprar-pistol" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_PISTOL")

	elseif data == "armamentos-vender-hkp7m10" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_PISTOL_MK2")
	elseif data == "armamentos-vender-uzi" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-vender-mtar21" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-vender-ak103" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_ASSAULTRIFLE_MK2")
    elseif data == "armamentos-vender-magnum44" then
	    TriggerServerEvent("mafia-vender","wbody|WEAPON_PUMPSHOTGUN_MK2")
    elseif data == "armamentos-vender-thompson" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_GUSENBERG")
	elseif data == "armamentos-vender-pistol" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_PISTOL")



	elseif data == "municoes-comprar-hkp7m10" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-comprar-uzi" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-comprar-mtar21" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_ASSAULTSMG")
	elseif data == "municoes-comprar-ak103" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_ASSAULTRIFLE_MK2")
	elseif data == "municoes-comprar-magnum44" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_PUMPSHOTGUN_MK2")
	elseif data == "municoes-comprar-thompson" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_GUSENBERG")
	elseif data == "municoes-comprar-pistol" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_PISTOL")


	elseif data == "municoes-vender-hkp7m10" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-vender-uzi" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-vender-mtar21" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_ASSAULTSMG")
	elseif data == "municoes-vender-ak103" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_ASSAULTRIFLE_MK2")
	elseif data == "municoes-vender-magnum44" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_PUMPSHOTGUN_MK2")
	elseif data == "municoes-vender-thompson" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_GUSENBERG")
	elseif data == "municoes-vender-pistol" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_PISTOL")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local t = 1000
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2558.0375976563,4664.6689453125,34.046810150146,true)
		if distance <= 30 then
			DrawMarker(20,2558.0375976563,4664.6689453125,34.046810150146-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,50,0,0,0,0)
			if distance <= 1.1 then
				t = 5
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(t)
	end
end)