function tvRP.varyHealth(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped)+variation)
	SetEntityHealth(ped,n)
end

function tvRP.getHealth()
	return GetEntityHealth(PlayerPedId())
end

function tvRP.setHealth(health)
	local n = math.floor(health)
	SetEntityHealth(PlayerPedId(),n)
end

function tvRP.setFriendlyFire(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end

local nocauteado = false
local timedeath = 600

Citizen.CreateThread(function()
	while true do
		local t = 1000
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)
		if health <= 100 and timedeath > 0 then
			t = 5
			if not nocauteado then
				if IsEntityDead(ped) then
					local x,y,z = tvRP.getPosition()
					NetworkResurrectLocalPlayer(x,y,z,true,true,false)
					Citizen.Wait(1)
				end
				nocauteado = true
				vRPserver._updateHealth(100)
				SetEntityHealth(ped,100)
				SetEntityInvincible(ped,true)
				if IsPedInAnyVehicle(ped) then
					tvRP.ejectVehicle()
				end
				NetworkSetVoiceActive(false)
			else
				if health < 100 then
					SetEntityHealth(ped,100)
				end
			end
		end
		Citizen.Wait(t)
	end
end)

function tvRP.isInComa()
	return nocauteado
end

function tvRP.killComa()
	if nocauteado then
		timedeath = 60
	end
end

function tvRP.killGod()
	nocauteado = false
	NetworkSetVoiceActive(true)
	SetEntityInvincible(PlayerPedId(),false)
	SetEntityHealth(PlayerPedId(),120)
	vRPserver._updateHealth(120)
	SetTimeout(5000,function()
		timedeath = 900
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if nocauteado then
			timedeath = timedeath - 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local t = 1000
		if nocauteado and timedeath <= 0 then
			t = 5
			if IsControlJustPressed(0,38) then
				nocauteado = false
				SetEntityInvincible(PlayerPedId(),false)
				SetEntityHealth(PlayerPedId(),0)
				SetTimeout(5000,function()
					timedeath = 900
				end)
			end
		end
		Citizen.Wait(t)
	end
end)

Citizen.CreateThread(function()
	while true do
		local t = 1000
		if nocauteado then
			t = 5
			if timedeath > 0 then
				drawTxt("VOCE TEM ~r~"..timedeath.." ~w~SEGUNDOS DE VIDA, CHAME OS PARAMEDICOS",4,0.5,0.93,0.50,255,255,255,255)
			else
				drawTxt("PRESSIONE ~g~E ~w~PARA VOLTAR AO HOSPITAL OU AGUARDE UM PARAMÉDICO",4,0.5,0.93,0.50,255,255,255,255)
			end
			SetPedToRagdoll(PlayerPedId(),1000,1000,0,0,0,0)
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,168,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,311,true)
		end
		Citizen.Wait(t)
	end
end)

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