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
	if data == "mouro" then
		TriggerServerEvent("minerador-vender","mouro")
	elseif data == "mferro" then
		TriggerServerEvent("minerador-vender","mferro")
	elseif data == "mbronze" then
		TriggerServerEvent("minerador-vender","mbronze")
	elseif data == "mrubi" then
		TriggerServerEvent("minerador-vender","mrubi")
	elseif data == "mesmeralda" then
		TriggerServerEvent("minerador-vender","mesmeralda")
	elseif data == "diamante" then
		TriggerServerEvent("minerador-vender","diamante")

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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),795.75,-1725.38,30.52,true)
		if distance <= 30 then
			t = 5
			DrawMarker(23,795.75,-1725.38,30.52-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(t)
	end
end)