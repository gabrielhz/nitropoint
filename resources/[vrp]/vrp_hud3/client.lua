local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")
HUDserver = Tunnel.getInterface("vrp_client", "vrp_client")
vRPhud = {}

Tunnel.bindInterface("vrp_client",vRPhud)
Proxy.addInterface("vrp_client",vRPhud)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vprox = "normal"
local prox = 10.0
local hidespeed = false
local CintoSeguranca = false
local ExNoCarro = false
local sBuffer = {}
local vBuffer = {}

-------------------------------------------------------------------------------------------------------------------------------
-- ABRIR IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerSpawned",function()
	NetworkSetTalkerProximity(prox)
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		setVoice()
	end
end)
function setVoice()
	NetworkSetTalkerProximity(prox)
	NetworkClearVoiceChannel()
end
Citizen.CreateThread(function()
	while true do
		HideHudComponentThisFrame( 1 ) -- Wanted Stars
		HideHudComponentThisFrame( 2 ) -- Weapon Icon
		HideHudComponentThisFrame( 3 ) -- Cash
		HideHudComponentThisFrame( 4 ) -- MP Cash
		HideHudComponentThisFrame( 6 ) -- Vehicle Name
		HideHudComponentThisFrame( 7 ) -- Area Name
		HideHudComponentThisFrame( 8 ) -- Vehicle Class      
		HideHudComponentThisFrame( 9 ) -- Street Name
		HideHudComponentThisFrame( 13 ) -- Cash Change
		HideHudComponentThisFrame( 17 ) -- Save Game  
		HideHudComponentThisFrame( 20 ) -- Weapon Stats 
        Citizen.Wait(1)
		local ped = PlayerPedId()
		local vida = GetEntityHealth(ped)
		local coords = GetEntityCoords(ped)
		local rua = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
		if IsControlJustPressed(1, 213) then
			if prox <= 2.5 then
				prox = 10.0
				vprox = "normal"
			elseif prox == 10.0 then
				prox = 26.0
				vprox = "shout"
			elseif prox >= 26.0 then
				prox = 2.5
				vprox = "whisper"
			end
			setVoice()
		end
		if IsControlPressed(1, 212) then
			local posPlayer = GetEntityCoords(GetPlayerPed(-1))
			DrawMarker(1, posPlayer.x, posPlayer.y, posPlayer.z - 1, 0, 0, 0, 0, 0, 0, prox * 2, prox * 2, 0.8001, 219, 77, 191, 70, false,0, 0,0)
		end
		if IsPedInAnyVehicle(ped, false) then
			inCar  = true
			local veh = GetVehiclePedIsUsing(ped)
			local fuel = GetVehicleFuelLevel(veh)
			local speed = GetEntitySpeed(veh)
			local kmh = (speed * 3.6)
			local gear = GetVehicleCurrentGear(veh)
			local marcha
			if speed ~= 0 and gear == 0 then
				marcha = "R"
			elseif speed == 0 and gear == 0 then
				marcha = "N"
			else
				marcha = gear
			end
			local seta = GetVehicleIndicatorLights(veh)
			local setaatual
			if seta == 1 then
				setaatual = "esquerda"
			elseif seta == 2 then
				setaatual = "direita"
			elseif seta == 3 then
				setaatual = "ambas"
			else
				setaatual = "none"
			end
			local desl,baixo,alto = GetVehicleLightsState(veh)
			local farol
			if desl == 1 and baixo == 0 and alto == 0 then
				farol = "desligado"
			elseif desl == 1 and baixo == 1 and alto == 0 or desl == 1 and baixo == 0 and alto == 1 then
				farol = "baixo"
			elseif desl == 1 and baixo == 1 and alto == 1 then
				farol = "alto"
			end
			local vehdata = {
				fuel = fuel,
				speed = kmh,
				gear = marcha,
				seta = setaatual,
				farol = farol,
			}
			DisplayRadar(true)
			if not hidespeed then
			SendNUIMessage({ action = "showSpeedometer", values = vehdata })
			end
		else
			inCar  = false
			DisplayRadar(false)
			SendNUIMessage({ action = "hideSpeedometer" })
		end
		local data = {
			vida = vida,
			armor = GetPedArmour(ped),
			rua = GetStreetNameFromHashKey(rua),
			voz = vprox,
		}
		SendNUIMessage({ action = "updateData", values = data })
    end
end)

RegisterNetEvent('HideMainHUD')
AddEventHandler('HideMainHUD',function()
	hidespeed = true
	SendNUIMessage({ action = "hideHud"})
end)
RegisterNetEvent('ShowMainHUD')
AddEventHandler('ShowMainHUD',function()
	hidespeed = false
	SendNUIMessage({ action = "showHud"})
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
					segundos = 5
				end
				vBuffer[2] = vBuffer[1]
				vBuffer[1] = GetEntityVelocity(car)
				if IsControlJustReleased(1,47) then
					TriggerEvent("cancelando",true)
					if CintoSeguranca then
						TriggerEvent("vrp_sound:source",'unbuckle',0.5)
						TriggerEvent("Notify","negado","Voce tirou o Cinto.")
						SetTimeout(580,function()
							CintoSeguranca = false
							TriggerEvent("cancelando",false)
						end)
					else
						TriggerEvent("vrp_sound:source",'buckle',0.5)
						TriggerEvent("Notify","sucesso","Voce colocou o cinto.")
						SetTimeout(580,function()
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
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        DisableControlAction(0,36,true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
        end
    end
end)