local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hour = 0
local minute = 0
local segundos = 0
local month = ""
local dayOfMonth = 0
local voice = 1
local voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic.png'>Normal</span>"
local proximity = 2
local sBuffer = {}
local vBuffer = {}
local CintoSeguranca = false
local ExNoCarro = false
local gasolina = 0
local started = true
local displayValue = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATA E HORA
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "janeiro"
	elseif month == 1 then
		month = "fevereiro"
	elseif month == 2 then
		month = "marco"
	elseif month == 3 then
		month = "abril"
	elseif month == 4 then
		month = "maio"
	elseif month == 5 then
		month = "junho"
	elseif month == 6 then
		month = "julho"
	elseif month == 7 then
		month = "agosto"
	elseif month == 8 then
		month = "setembro"
	elseif month == 9 then
		month = "outubro"
	elseif month == 10 then
		month = "novembro"
	elseif month == 11 then
		month = "dezembro"
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)	
		CalculateTimeToDisplay()
		CalculateDateToDisplay()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VOICE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerSpawned",function()
	NetworkSetTalkerProximity(1.0)
	started = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		setVoice()
	end
end)

function setVoice()
	NetworkSetTalkerProximity(1.0)
	NetworkClearVoiceChannel()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
local menu_celular = false
RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	menu_celular = status
end)

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" } or "Não encontrado"

Citizen.CreateThread(function()
    local currSpeed = 0.0
    local cruiseSpeed = 999.0
    local cruiseIsOn = false
    local seatbeltIsOn = false
	while true do
		Citizen.Wait(10)
		ped = PlayerPedId()
		health = (GetEntityHealth(ped)-100)/300*100
		armor = GetPedArmour(ped)
		local x,y,z = table.unpack(GetEntityCoords(ped,false))
		if IsControlJustPressed(1,212) and GetEntityHealth(ped) > 100 then
			if proximity == 1 then
				voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic.png'>Normal</span>"
				proximity = 2
			elseif proximity == 2 then
				voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic3.png'>Gritando</span>"
				proximity = 3
			elseif proximity == 3 then
				voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic2.png'>Sussurro</span>"
				proximity = 1
			end
		end
		if IsPedInAnyVehicle(ped) then
			DisplayRadar(true)
			inCar  = true
			PedCar = GetVehiclePedIsIn(ped)
			speed = math.ceil(GetEntitySpeed(PedCar)*3.605936)
			rpm = GetVehicleCurrentRpm(PedCar)
			nsei,baixo,alto = GetVehicleLightsState(PedCar)
			if baixo == 1 and alto == 0 then
				farol = 1
			elseif  alto == 1 then
				farol = 2
			else
				farol = 0
			end
			if GetEntitySpeed(PedCar) == 0 and GetVehicleCurrentGear(PedCar) == 0  then
				marcha = "P"
			elseif GetEntitySpeed(PedCar) ~= 0 and GetVehicleCurrentGear(PedCar) == 0  then
				marcha = "R"
			else
				marcha = GetVehicleCurrentGear(PedCar)
			end
		 	gasolina = GetVehicleFuelLevel(PedCar)
			VehIndicatorLight = GetVehicleIndicatorLights(PedCar)
			if(VehIndicatorLight == 0) then
				piscaEsquerdo = false
				piscaDireito = false
			elseif(VehIndicatorLight == 1) then
				piscaEsquerdo = true
				piscaDireito = false
			elseif(VehIndicatorLight == 2) then
				piscaEsquerdo = false
				piscaDireito = true
			elseif(VehIndicatorLight == 3) then
				piscaEsquerdo = true
				piscaDireito = true
			end		
		else	
			DisplayRadar(false)
			inCar  = false
			PedCar = 0
			speed = 0
			rpm = 0
			marcha = 0
			cruiseIsOn = false
			VehIndicatorLight = 0
		end
		SendNUIMessage({
			show = show,
			incar = inCar,
			speed = speed,
			rpm = rpm,
			gear = marcha,
			heal = health,
			armor = armor,
			dia = dayOfMonth,
			mes = month,
			hora = hour,
			minuto = minute,
			voz = voiceDisplay,
			piscaEsquerdo = piscaEsquerdo,
			piscaDireito = piscaDireito,
			gas = gasolina,
			cinto = CintoSeguranca,
			farol = farol,
			cruise = cruiseIsOn,
		 	display = displayValue,
		 	rua = street,
		 	rua2 = street2
		});
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CINTO DE SEGURANÇA
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	
Fwv = function (entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then
		hr = 360.0 + hr
	end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end
local segundos = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if inCar then
			local ped = PlayerPedId()
			local car = GetVehiclePedIsIn(ped)
			if car ~= 0 and (ExNoCarro or IsCar(car)) then
				ExNoCarro = true
				if CintoSeguranca then
					DisableControlAction(0,75)
				end

				sBuffer[2] = sBuffer[1]
				sBuffer[1] = GetEntitySpeed(car)

				if sBuffer[2] ~= nil and not CintoSeguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
					local co = GetEntityCoords(ped)
					local fw = Fwv(ped)
					SetEntityHealth(ped,GetEntityHealth(ped)-150)
					SetEntityCoords(ped,co.x+fw.x,co.y+fw.y,co.z-0.47,true,true,true)
					SetEntityVelocity(ped,vBuffer[2].x,vBuffer[2].y,vBuffer[2].z)
					segundos = 20
				end
				vBuffer[2] = vBuffer[1]
				vBuffer[1] = GetEntityVelocity(car)
				if IsControlJustReleased(1,47) then
					TriggerEvent("cancelando",true)
					if CintoSeguranca then
						TriggerEvent("vrp_sound:source",'unbelt',0.5)
						SetTimeout(2000,function()
							CintoSeguranca = false
							TriggerEvent("cancelando",false)
						end)
					else
						TriggerEvent("vrp_sound:source",'belt',0.5)
						SetTimeout(3000,function()
							CintoSeguranca = true
							TriggerEvent("cancelando",false)
						end)
					end
				end
			elseif ExNoCarro then
				ExNoCarro = false
				CintoSeguranca = false
				sBuffer[1],sBuffer[2] = 0.0,0.0
			end
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SOM DAS SETAS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		if VehIndicatorLight == 1 or VehIndicatorLight == 2 or VehIndicatorLight == 3 then
			TriggerEvent('vrp_sound:source','setas1', 0.9)
			Citizen.Wait(300)
			TriggerEvent('vrp_sound:source','setas2', 0.9)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCULTA A HUD QUANDO PAUSA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(100)
      	if started then 
	        if IsPauseMenuActive() or menu_celular then
	            displayValue = false
	        else
	            displayValue = true
	        end
	  	end
    end
end)

Citizen.CreateThread(function()
  while true do
	local t = 1000
	if disabled then
		t = 5
		DisableControlAction(1,243,true)
		DisableControlAction(1,213,true)
		DisableControlAction(0,21,true) 
		DisableControlAction(0,24,true)
		DisableControlAction(0,25,true) 
		DisableControlAction(0,47,true) 
		DisableControlAction(0,49,true)
		DisableControlAction(0,44,true) 
		DisableControlAction(0,303,true) 
      DisableControlAction(0,246,true) 
      DisableControlAction(0,311,true) 
      DisableControlAction(0,58,true) 
      DisableControlAction(0,263,true) 
      DisableControlAction(0,264,true) 
      DisableControlAction(0,257,true) 
      DisableControlAction(0,140,true) 
      DisableControlAction(0,141,true) 
      DisableControlAction(0,142,true)
      DisableControlAction(0,143,true) 
      DisableControlAction(0,75,true) 
      DisableControlAction(27,75,true) 
    end
	Citizen.Wait(t)
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAGDOLL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		timing = 1000
		if segundos > 0 then
		timing = 5
		if GetEntityHealth(PlayerPedId()) > 100 then
			SetPedToRagdoll(PlayerPedId(),1000,1000,0,0,0,0)
		end
	end
	Citizen.Wait(timing)
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIDA BAIXA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local vida = GetEntityHealth(PlayerPedId())
		Citizen.Wait(1)
		if vida <= 251 and vida >= 201 and not agachar then
			RequestAnimSet("move_injured_generic")     
      		SetPedMovementClipset(ped,"move_injured_generic",true)			
		elseif vida <= 200 and vida >= 151 and not agachar then
			RequestAnimSet("move_heist_lester")  
      		SetPedMovementClipset(ped,"move_heist_lester",true)			
		elseif vida <= 150 and vida >= 101 and not agachar then
			RequestAnimSet("MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP") 
      		SetPedMovementClipset(ped,"MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP",true)			
		elseif vida <= 400  and vida >= 251 and not agachar and not movimento then
			ResetPedMovementClipset(ped,0.0)			
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("homem",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@confident")
end)

RegisterCommand("mulher",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@heels@c")
end)

RegisterCommand("depressivo",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@depressed@a")
end)

RegisterCommand("depressiva",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@depressed@a")
end)

RegisterCommand("empresario",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@business@a")
end)

RegisterCommand("determinado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@brave@a")
end)

RegisterCommand("descontraido",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@casual@a")
end)

RegisterCommand("farto",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@fat@a")
end)

RegisterCommand("estiloso",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@hipster@a")
end)

RegisterCommand("ferido",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@injured")
end)

RegisterCommand("nervoso",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@hurry@a")
end)

RegisterCommand("desleixado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@hobo@a")
end)

RegisterCommand("infeliz",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@sad@a")
end)

RegisterCommand("musculoso",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@muscle@a")
end)

RegisterCommand("desligado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@shadyped@a")
end)

RegisterCommand("fadiga",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@buzzed")
end)

RegisterCommand("apressado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@hurry_butch@a")
end)

RegisterCommand("descolado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@money")
end)

RegisterCommand("corridinha",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@quick")
end)

RegisterCommand("piriguete",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@maneater")
end)

RegisterCommand("petulante",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@sassy")
end)

RegisterCommand("arrogante",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@arrogant@a")
end)

RegisterCommand("bebado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@drunk@slightlydrunk")
end)

RegisterCommand("bebado2",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@drunk@verydrunk")
end)

RegisterCommand("bebado3",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@drunk@moderatedrunk")
end)

RegisterCommand("irritado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@fire")
end)

RegisterCommand("intimidado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_m@intimidation@cop@unarmed")
end)

RegisterCommand("poderosa",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@handbag")
end)

RegisterCommand("chateado",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@injured")
end)

RegisterCommand("estilosa",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@posh@")
end)

RegisterCommand("sensual",function(source,args)
	movimento = true
	vRP.loadAnimSet("move_f@sexy@a")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x+width/2,y+height/2,width,height,r,g,b,a)
end

function drawTxt(x,y,scale,text,r,g,b,a)
	SetTextFont(4)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextDropShadow(0, 0, 0, 0, 200)
    SetTextDropShadow()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function drawLevel(text,r, g, b, a, incar, x, y )
  SetTextFont(4)
  SetTextProportional(1)
  SetTextScale(0.41, 0.41)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 200)
  SetTextDropShadow()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  local playerPed = GetPlayerPed(PlayerId())
  local playerVeh = GetVehiclePedIsIn(playerPed, false)
  DrawText(x, y)
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