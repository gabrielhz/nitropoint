local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local started = true
local displayValue = false
local hudcmd = false
local sBuffer = {}
local vBuffer = {}
local gasolina = 0
local CintoSeguranca = false
local thirst, hunger = 0, 0
local proximity = 10.001
-----------------------------------------------------------------------------------------------------------------------------------------
--[ HUD ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local menu_celular = false
RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	menu_celular = status
end)

RegisterNetEvent("vrp_hud:update")
AddEventHandler("vrp_hud:update", function(rHunger, rThirst)
  hunger, thirst = rHunger, rThirst
end)

Citizen.CreateThread(function()
  local seatbeltIsOn = false

	while true do
    Citizen.Wait(10)
    
    local source = source
    local user_id = vRP.getUserId(source)
    
		ped = PlayerPedId()
		health = (GetEntityHealth(ped)-100)/300*100
    armor = GetPedArmour(ped)

    local x,y,z = table.unpack(GetEntityCoords(ped,false))

		if IsPedInAnyVehicle(ped) then
      PedCar = GetVehiclePedIsIn(ped)
      speed = math.ceil(GetEntitySpeed(PedCar)*3.605936)
      rpm = GetVehicleCurrentRpm(PedCar)

      if menu_celular then
			  DisplayRadar(false)
      else
        DisplayRadar(true)
      end

			inCar  = true
			PedCar = GetVehiclePedIsIn(ped)
      gasolina = GetVehicleFuelLevel(PedCar)
		else	
			DisplayRadar(false)
			inCar  = false
			PedCar = 0
      speed = 0
      rpm = 0
		end
		SendNUIMessage({
			show = show,
			incar = inCar,
      speed = speed,
      rpm = rpm,
			heal = health,
      armor = armor,
      thirst = thirst,
      hunger = hunger,
      gas = gasolina,
      cinto = CintoSeguranca,
		 	display = displayValue
		});
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CINTO DE SEGURANÇA ]-----------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
--[ OCULTA A HUD QUANDO PAUSA ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hud',function(source,args,rawCommand)
  if started then
    if not menu_celular then
      menu_celular = true
    else
      menu_celular = false
    end
  end
end)

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
    Citizen.Wait(0)
    if disabled then
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
  end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ VOIP ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(300)
    local playerID = PlayerId()

    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    for _,player in ipairs(GetActivePlayers()) do
        local boolTalking = NetworkIsPlayerTalking(player)

        if player ~= playerID then
            if boolTalking then
                PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
            elseif not boolTalking then
                PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
            end
        end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)

    local isTalking = false
	  local voiceDistance = nil

    if NetworkIsPlayerTalking(PlayerId()) and not isTalking then 
      isTalking = not isTalking
    elseif not NetworkIsPlayerTalking(PlayerId()) and isTalking then 
      isTalking = not isTalking
    end
    
    if IsControlJustPressed(1,213) and GetEntityHealth(ped) > 100 then
			if proximity == 3.001 then
				voice = 2
				proximity = 10.001
			elseif proximity == 10.001 then
				voice = 3
				proximity = 25.001
			elseif proximity == 25.001 then
				voice = 4
				proximity = 50.001
			elseif proximity == 50.001 then
				voice = 1
				proximity = 3.001
			end
			UpdateVoip()
		end

  end
end)

AddEventHandler('onClientMapStart', function()	
	NetworkSetTalkerProximity(proximity)
end)

AddEventHandler('playerSpawned', function()
	NetworkSetTalkerProximity(proximity)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		UpdateVoip()
	end
end)


function UpdateVoip()
	NetworkClearVoiceChannel()
	NetworkSetTalkerProximity(proximity)
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CONTAGEM ]---------------------------------------------------------------------------------------------------------------------------
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
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
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