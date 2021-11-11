local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emp = Tunnel.getInterface("entrega_maconha")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local quantidade = 0
local statuses = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregas = {
	[1] = {x=155.85,y=-43.10,z=67.71},
	[2] = {x=313.35,y=-245.31,z=53.89},
	[3] = {x=-52.17,y=-103.74,z=57.63},
	[4] = {x=-269.36,y=27.27,z=54.65},
	[5] = {x=-598.12,y=5.68,z=43.07},
	[6] = {x=-795.49,y=40.80,z=48.25},
	[7] = {x=-843.95,y=87.22,z=51.96},
	[8] = {x=-831.32,y=-227.58,z=37.09},
	[9] = {x=-682.37,y=-374.73,z=34.15},
	[10] = {x=-295.17,y=-617.44,z=33.31},
	[11] = {x=-553.23,y=-649.75,z=33.08},
	[12] = {x=-934.24,y=-456.49,z=37.15},
	[13] = {x=-1078.39,y=-267.97,z=37.61},
	[14] = {x=-1437.76,y=-412.62,z=35.79},
	[15] = {x=-1669.03,y=-541.66,z=34.98},
	[16] = {x=-1392.47,y=-580.91,z=30.05},
	[17] = {x=-1042.79,y=-387.18,z=37.57},
	[18] = {x=-255.13,y=-756.19,z=32.63},
	[19] = {x=13.42,y=-972.96,z=29.30},
	[20] = {x=257.70,y=-1062.13,z=29.10},
	[21] = {x=792.41,y=-944.58,z=25.55},
	[22] = {x=120.44,y=-926.42,z=29.73},
	[23] = {x=2.53,y=-1127.96,z=28.09},
	[24] = {x=-582.63,y=-867.52,z=25.63},
	[25] = {x=-1047.00,y=-779.63,z=18.93},
	[26] = {x=-1061.55,y=-495.26,z=36.24},
	[27] = {x=-1071.15,y=-433.65,z=36.45},
	[28] = {x=-1203.82,y=-131.74,z=40.70},
	[29] = {x=-932.33,y=326.64,z=71.25},
	[30] = {x=-587.70,y=250.66,z=82.26},
	[31] = {x=-478.28,y=223.87,z=83.02},
	[32] = {x=-310.77,y=226.85,z=87.78},
	[33] = {x=75.20,y=229.06,z=108.70},
	[34] = {x=296.00,y=147.55,z=103.77},
	[35] = {x=1187.01,y=-431.18,z=67.02},
	[36] = {x=1260.03,y=-582.09,z=68.88},
	[37] = {x=1360.39,y=-570.32,z=74.22},
	[38] = {x=376.23510742188,y=-335.77307128906,z=48.1614112854},
	[39] = {x=930.92407226563,y=-245.17872619629,z=69.002647399902},
	[40] = {x=840.16583251953,y=-181.67932128906,z=74.188079833984},
	[41] = {x=820.79992675781,y=-156.4988861084,z=80.752479553223},
	[42] = {x=457.34124755859,y=-2059.3364257813,z=23.99090385437},
	[43] = {x=853.90191650391,y=-2207.4284667969,z=30.667190551758},
	[44] = {x=783.06872558594,y=-2254.0375976563,z=29.461324691772},
	[45] = {x=844.48327636719,y=-2118.5251464844,z=30.521060943604},
	[46] = {x=660.19317626953,y=263.64691162109,z=102.6975402832},
	[47] = {x=1249.2352294922,y=-349.91790771484,z=69.209815979004},
	[48] = {x=1257.078125,y=-437.89916992188,z=69.567436218262},
	[49] = {x=1227.4747314453,y=-725.31365966797,z=60.644199371338},
	[50] = {x=1082.716796875,y=-788.09741210938,z=58.262756347656},
	[51] = {x=764.52825927734,y=-1358.4466552734,z=27.878269195557},
	[52] = {x=947.21783447266,y=-1250.0286865234,z=27.075843811035},
	[53] = {x=278.72943115234,y=-1118.3101806641,z=29.419687271118},
	[54] = {x=-287.44439697266,y=-1062.9680175781,z=27.205379486084},
	[55] = {x=-601.26959228516,y=-1106.2435302734,z=25.855100631714},
	[56] = {x=920.23663330078,y=-239.05854797363,z=70.131851196289},
	[57] = {x=951.99609375,y=-252.12083435059,z=67.759574890137}

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('entrega_maconha:permissao')
AddEventHandler('entrega_maconha:permissao',function()
	if not emservico then
		emservico = true
		destino = math.random(1,38)
		quantidade = math.random(1,4)
		CriandoBlip(entregas,destino)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local t = 1000
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1370.7060546875,-1694.291015625,61.482688903809,true) <= 1 then
			t = 5
			DrawText3Ds(1370.7060546875,-1694.291015625,61.482688903809+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	-- COMEÇAR MISSÃO
				TriggerEvent('entrega_maconha:permissao')
			end
		end
		if emservico then
			t = 5
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	-- VER MISSÃO
				statuses = not statuses
			end
			if statuses then
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.076,1.0,1.0,0.35,"PRESSIONE ~r~U ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.058,1.0,1.0,0.45,"ENTREGUE ~g~"..quantidade.."~w~ MACONHAS",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 50 then
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z+0.10,0,0,0,0,180.0,130.0,1.0,1.0,1.0,211,176,72,100,1,0,0,1)
				if distance < 3 then
					DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then -- ENTREGAR
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_maconha:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(t)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local t = 1000
		if emservico then
			t = 5
			if IsControlJustPressed(0,303) then --CANCELAR
				emservico = false
				RemoveBlip(blip)
			end
		end
		Citizen.Wait(t)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
-----------------------------------------------------------------------------------------------------------------------------------------

function drawTxt(x,y,width,height,scale,text,r,g,b,a)
    SetTextFont(4)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Maconhas")
	EndTextCommandSetBlipName(blip)
end