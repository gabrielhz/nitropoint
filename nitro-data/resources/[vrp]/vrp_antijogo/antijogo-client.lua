--[[ 
	AVISO!
	SCRIPT PRODUZIDO POR LEOZIN. QUALQUER
	PESSOA QUE ESTIVER VENDENDO, SOFRERÁ
	AS CONSEQUENCIAS.
	QUALQUER DÚVIDA, ME CHAME NO PRIVADO.

	PROIBIDA A VENDA DESSE SCRIPT. GRATIS

	DISCORD: ! LΣӨZIП ツ#0013

	--------------------------------

	PARA IMPEDIR QUE O JOGADOR SEJA
	TRANSFERIDO PARA A PRISAO,
	COMENTE A LINHA 73 COM --
--]]



Citizen.CreateThread(function()
	while true do
		local t = 1000
		local ped = GetPlayerPed(-1)
		local pedcoords = GetEntityCoords(ped)
		local carro = GetVehiclePedIsIn(ped)

		-- DP NORMAL
		local dpN1 = vector3(441.84368896484,-983.06384277344,30.68967628479) -- frente da dp normal
		local dpN2 = vector3(463.89227294922,-1009.0505981445,25.562063217163) -- atras da dp normal

		-- DP CIDADE ALTA (VESPUCCI BEACH)
		local dpCDA1 = vector3(-1070.7937011719,-823.82299804688,19.030916213989) -- entrada da direita (cima)
		local dpCDA2 = vector3(-1059.0968017578,-837.57366943359,5.1105079650879) -- porta de fora da garagem (baixo)
		local dpCDA3 = vector3(-1090.1166992188,-813.82202148438,19.03581237793) -- entrada principal (cima)
		local dpCDA4 = vector3(-1095.7130126953,-844.81390380859,4.8840646743774) -- porta dentro da garagem(baixo)
		local preso = vector3(1642.9715576172,2568.8208007813,45.56485748291) -- cela quadrada q n tem como bugar
		-- ADICIONE NOVAS COORDENADAS SEGUINDO O MODELO
		--local novacoordenada = vector3(COORDENADA AQUI)

		-- HOSPITAL
		local hospital = vector3(305.92211914063,-589.21722412109,43.291854858398) -- entrada do hospital

		if GetDistanceBetweenCoords(pedcoords, dpN1.x, dpN1.y, dpN1.z, true) < 5.0 or 
		GetDistanceBetweenCoords(pedcoords, dpN2.x, dpN2.y, dpN2.z, true) < 5.0 or
		GetDistanceBetweenCoords(pedcoords, dpCDA1.x, dpCDA1.y, dpCDA1.z, true) < 5.0 or 
		GetDistanceBetweenCoords(pedcoords, dpCDA2.x, dpCDA2.y, dpCDA2.z, true) < 5.0 or 
		GetDistanceBetweenCoords(pedcoords, dpCDA3.x, dpCDA3.y, dpCDA3.z, true) < 5.0 or 
		GetDistanceBetweenCoords(pedcoords, dpCDA4.x, dpCDA4.y, dpCDA4.z, true) < 5.0 or 
		-- COM O EXEMPLO ABAIXO, VOCE PODE ADICIONAR AS NOVAS COORDENADAS AO SCRIPT
		--GetDistanceBetweenCoords(pedcoords, novacoordenada.x, novacoordenada.y, novacoordenada.z, true) < 5.0 or 
		GetDistanceBetweenCoords(pedcoords, hospital.x, hospital.y, hospital.z, true) < 5.0 then
			t = 5
			if IsPedInAnyVehicle(ped) then
				FreezeEntityPosition(carro, true)
				SetVehicleEngineOn(carro, false, true, true)
				TaskLeaveVehicle(ped, carro, 16)
				SetPedToRagdoll(ped, 5000, 1, 2)
				Citizen.Wait(500)
				FreezeEntityPosition(ped, true)
				mensagem("~r~tentando fazer powergaming? se fudeu")
				Citizen.Wait(500)
				mensagem("~o~tentando fazer powergaming? se fudeu")
				Citizen.Wait(500)
				mensagem("~y~tentando fazer powergaming? se fudeu")
				Citizen.Wait(500)
				mensagem("~g~tentando fazer powergaming? se fudeu")
				Citizen.Wait(500)
				mensagem("~b~tentando fazer powergaming? se fudeu")
				Citizen.Wait(500)
				mensagem("~p~tentando fazer powergaming? se fudeu")
				Citizen.Wait(5000)
				DeleteVehicle(carro)
				SetPedCoordsKeepVehicle(ped, preso.x, preso.y, preso.z)
				FreezeEntityPosition(ped, false)
				--[[ TECLAS BLOQUEADAS (SOMENTE EM THREAD)
				DisableControlAction(0, 1, true) -- MOUSE RIGHT (MIRA)
				DisableControlAction(0, 11, true) -- RT DO CONTROLE (ATAQUE)
				DisableControlAction(0, 10, true) -- LT DO CONTROLE (MIRA)
				DisableControlAction(0, 22, true) -- BARRA DE ESPACO (PULA)
				DisableControlAction(0, 21, true) -- SHIFT (CORRE)
				DisableControlAction(0, 36, true) -- CRTL (AGAIXAR)
				DisableControlAction(0, 44, true) -- Q (DA COVER AO JOGADOR)
				DisableControlAction(0, 45, true) -- R (RELOAD + ATAQUE) 
				DisableControlAction(0, 306, true) -- N (PUSH TO TALK VOIP IN GAME)
				DisableControlAction(0, 349, true) -- TAB (MENU DE ARMAS)
				DisableControlAction(0, 311, true) -- K (MENU K) 
				DisableControlAction(0, 24, true) -- MOUSE LEFT (ATAQUE)
				--]]
				Citizen.Wait(2000)
				mensagem("~y~Parabéns mano. você fez bosta e agora está preso para sempre")
				Citizen.Wait(3500)
				mensagem("~y~Se você realmente deseja continuar jogando nesse servidor, chame um admin")
				Citizen.Wait(3500)
				mensagem("~y~Prove para o admin que você merece ficar no server ou saia do servidor e não volte mais")
				Citizen.Wait(3500)
				mensagem("~y~Beijinhos da equipe administrativa do ~g~NitroPoint® Roleplay")
				--TriggerServerEvent('leozin:log') -- log no discord sem banir e sem kickar
			end
		end
		Wait(t)
	end
end)

--[[ FUNCAO DE MENSAGEM (NOTIFY NO CLIENT) ]]--
function mensagem(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end