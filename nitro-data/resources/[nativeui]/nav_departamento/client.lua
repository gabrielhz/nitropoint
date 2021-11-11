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
	if data == "utilidades-comprar-isca" then
		TriggerServerEvent("departamento-comprar","isca")
	elseif data == "utilidades-comprar-garrafa" then
		TriggerServerEvent("departamento-comprar","garrafavazia")
	elseif data == "utilidades-comprar-militec" then
		TriggerServerEvent("departamento-comprar","militec")
	elseif data == "utilidades-comprar-radio" then
		TriggerServerEvent("departamento-comprar","radio")
	elseif data == "utilidades-comprar-reparos" then
		TriggerServerEvent("departamento-comprar","repairkit")
	elseif data == "utilidades-comprar-rastreador" then
   		TriggerServerEvent("departamento-comprar","rastreador")
	elseif data == "utilidades-comprar-croquettes" then
		TriggerServerEvent("departamento-comprar","croquettes")
	elseif data == "utilidades-comprar-ferramentas" then
		TriggerServerEvent("departamento-comprar","ferramenta")
	elseif data == "utilidades-comprar-bandagem" then
		TriggerServerEvent("departamento-comprar","bandagem")
	elseif data == "utilidades-comprar-roupas" then
		TriggerServerEvent("departamento-comprar","roupas")	
	elseif data == "utilidades-comprar-mochila" then
		TriggerServerEvent("departamento-comprar","mochila")
	elseif data == "utilidades-vender-alianca" then
		TriggerServerEvent("depart-sell","alianca")	

	elseif data == "utilidades-vender-isca" then
		TriggerServerEvent("depart-sell","isca")
	elseif data == "utilidades-vender-garrafa" then
		TriggerServerEvent("depart-sell","garrafavazia")
	elseif data == "utilidades-vender-rastreador" then
   		TriggerServerEvent("depart-sell","rastreador")
	elseif data == "utilidades-vender-croquettes" then
		TriggerServerEvent("depart-sell","croquettes")
	elseif data == "utilidades-vender-militec" then
		TriggerServerEvent("depart-sell","militec")
	elseif data == "utilidades-vender-radio" then
		TriggerServerEvent("depart-sell","radio")
	elseif data == "utilidades-vender-reparos" then
		TriggerServerEvent("depart-sell","repairkit")
	elseif data == "utilidades-vender-ferramentas" then
		TriggerServerEvent("depart-sell","ferramenta")
	elseif data == "utilidades-vender-roupas" then
		TriggerServerEvent("depart-sell","roupas")
	elseif data == "utilidades-vender-mochila" then
		TriggerServerEvent("depart-sell","mochila")
	elseif data == "utilidades-vender-alianca" then
		TriggerServerEvent("depart-sell","alianca")

	elseif data == "bebidas-comprar-cerveja" then
		TriggerServerEvent("departamento-comprar","cerveja")
	elseif data == "bebidas-comprar-tequila" then
		TriggerServerEvent("departamento-comprar","tequila")
	elseif data == "bebidas-comprar-vodka" then
		TriggerServerEvent("departamento-comprar","vodka")
	elseif data == "bebidas-comprar-whisky" then
		TriggerServerEvent("departamento-comprar","whisky")
	elseif data == "bebidas-comprar-conhaque" then
		TriggerServerEvent("departamento-comprar","conhaque")
	elseif data == "bebidas-comprar-absinto" then
		TriggerServerEvent("departamento-comprar","absinto")
	elseif data == "bebidas-comprar-energetico" then
		TriggerServerEvent("departamento-comprar","energetico")
	elseif data == "bebidas-comprar-agua" then
		TriggerServerEvent("departamento-comprar","agua")
	elseif data == "bebidas-comprar-limonada" then
		TriggerServerEvent("departamento-comprar","limonada")
	elseif data == "bebidas-comprar-refrigerante" then
		TriggerServerEvent("departamento-comprar","refrigerante")
	elseif data == "bebidas-comprar-cafe" then
		TriggerServerEvent("departamento-comprar","cafe")

	elseif data == "bebidas-vender-cerveja" then
		TriggerServerEvent("depart-sell","cerveja")
	elseif data == "bebidas-vender-tequila" then
		TriggerServerEvent("depart-sell","tequila")
	elseif data == "bebidas-vender-vodka" then
		TriggerServerEvent("depart-sell","vodka")
	elseif data == "bebidas-vender-whisky" then
		TriggerServerEvent("depart-sell","whisky")
	elseif data == "bebidas-vender-conhaque" then
		TriggerServerEvent("depart-sell","conhaque")
	elseif data == "bebidas-vender-absinto" then
		TriggerServerEvent("depart-sell","absinto")
	elseif data == "bebidas-vender-energetico" then
		TriggerServerEvent("depart-sell","energetico")		
	elseif data == "bebidas-vender-agua" then
		TriggerServerEvent("depart-sell","agua")
	elseif data == "bebidas-vender-limonada" then
		TriggerServerEvent("depart-sell","limonada")
	elseif data == "bebidas-vender-refrigerante" then
		TriggerServerEvent("depart-sell","refrigerante")
	elseif data == "bebidas-vender-cafe" then
		TriggerServerEvent("depart-sell","cafe")

	elseif data == "comidas-comprar-chocolate" then
		TriggerServerEvent("departamento-comprar","chocolate")
	elseif data == "comidas-comprar-salgadinho" then
		TriggerServerEvent("departamento-comprar","salgadinho")
	elseif data == "comidas-comprar-rosquinha" then
		TriggerServerEvent("departamento-comprar","rosquinha")
	elseif data == "comidas-comprar-pizza" then
		TriggerServerEvent("departamento-comprar","pizza")
	elseif data == "comidas-comprar-pao" then
		TriggerServerEvent("departamento-comprar","pao")
	elseif data == "comidas-comprar-sanduiche" then
		TriggerServerEvent("departamento-comprar","sanduiche")

	elseif data == "comidas-vender-chocolate" then
		TriggerServerEvent("depart-sell","chocolate")
	elseif data == "comidas-vender-salgadinho" then
		TriggerServerEvent("depart-sell","salgadinho")
	elseif data == "comidas-vender-rosquinha" then
		TriggerServerEvent("depart-sell","rosquinha")
	elseif data == "comidas-vender-pizza" then
		TriggerServerEvent("depart-sell","pizza")
	elseif data == "comidas-vender-conhaque" then
		TriggerServerEvent("depart-sell","pao")
	elseif data == "comidas-vender-sanduiche" then
		TriggerServerEvent("depart-sell","sanduiche")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 25.65,-1346.58,29.49 },
	{ 2556.75,382.01,108.62 },
	{ 1163.54,-323.04,69.20 },
	{ -707.37,-913.68,19.21 },
	{ -47.73,-1757.25,29.42 },
	{ 373.90,326.91,103.56 },
	{ -3243.10,1001.23,12.83 },
	{ 1729.38,6415.54,35.03 },
	{ 547.90,2670.36,42.15 },
	{ 1960.75,3741.33,32.34 },
	{ 2677.90,3280.88,55.24 },
	{ 1698.45,4924.15,42.06 },
	{ -1820.93,793.18,138.11 },
	{ 1392.46,3604.95,34.98 },
	{ -2967.82,390.93,15.04 },
	{ -3040.10,585.44,7.90 },
	{ 1135.56,-982.20,46.41 },
	{ 1165.91,2709.41,38.15 },
	{ -1487.18,-379.02,40.16 },
	{ -816.12249755859,-194.64167785645,37.590026855469 },
	{ -1095.4796142578,-2594.6533203125,13.925128936768 },
	{ 313.22964477539,-588.01440429688,43.215240478516 },
	{ -1222.78,-907.22,12.32 },
	{ 886.89581298828,-2097.873046875,35.591915130615 },
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local t = 1000
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.2 then
				t = 5
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(t)
	end
end)