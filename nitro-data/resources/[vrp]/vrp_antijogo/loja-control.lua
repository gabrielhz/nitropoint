
local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		local pedcoords = GetEntityCoords(ped)

		-- DP NORMAL
		local LJ18 = vector3(1166.0953369141,2708.8598632813,38.157707214355) -- frente da dp normal

		-- ADICIONE NOVAS COORDENADAS SEGUINDO O MODELO
		--local novacoordenada = vector3(COORDENADA AQUI)

		-- HOSPITAL
		local hospital = vector3(305.92211914063,-589.21722412109,43.291854858398) -- entrada do hospital

		if GetDistanceBetweenCoords(pedcoords, LJ18.x, LJ18.y, LJ18.z, true) < 5.0 or 
		GetDistanceBetweenCoords(pedcoords, hospital.x, hospital.y, hospital.z, true) < 5.0 then
			SetBlackout(false)
			Citizen.Wait( 1 )
			if IsPlayerFreeAiming(PlayerId()) then
					if GetFollowPedCamViewMode() == 4 and check == false then
						check = false
				else
						SetFollowPedCamViewMode(4)
						check = true
				end
			else
					if check == true then
							SetFollowPedCamViewMode(1)
					check = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		local ped = GetPlayerPed(-1)
		local pedcoords = GetEntityCoords(ped)

		-- DP NORMAL
		local LJ18 = vector3(1166.0953369141,2708.8598632813,38.157707214355) -- frente da dp normal

		-- ADICIONE NOVAS COORDENADAS SEGUINDO O MODELO
		--local novacoordenada = vector3(COORDENADA AQUI)

		-- HOSPITAL
		local hospital = vector3(305.92211914063,-589.21722412109,43.291854858398) -- entrada do hospital

		if GetDistanceBetweenCoords(pedcoords, LJ18.x, LJ18.y, LJ18.z, true) < 5.0 or 
		GetDistanceBetweenCoords(pedcoords, hospital.x, hospital.y, hospital.z, true) < 5.0 then
			SetBlackout(false)
			Citizen.Wait( 1 )

		if IsPedShooting(GetPlayerPed(-1)) and shot == false and GetFollowPedCamViewMode() ~= 4 then
			check2 = true
			shot = true
			SetFollowPedCamViewMode(4)
		end
		
		if IsPedShooting(GetPlayerPed(-1)) and shot == true and GetFollowPedCamViewMode() == 4 then
			count = 0
		end
		
		if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
		    count = count + 1
		end

        if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
			if not IsPedShooting(GetPlayerPed(-1)) and shot == true and count > 20 then
		        if check2 == true then
				    check2 = false
					shot = false
					SetFollowPedCamViewMode(1)
					end
				end
			end
		end	    
	end
end )