--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
inMenu                      = true
local showblips = true
local atbank = false
local bankMenu = true
local banks = {
  
}

local atms = {

	{name="Caixa Eletrônico", id=277, x=89.577018737793, y=2.16031360626221, z=68.322021484375},
	{name="Caixa Eletrônico", id=277, x=-526.497131347656, y=-1222.79455566406, z=18.4549674987793},
	{name="Caixa Eletrônico", id=277, x=-2072.48413085938, y=-317.190521240234, z=13.315972328186},
	{name="Caixa Eletrônico", id=277, x=-821.565551757813, y=-1081.90270996094, z=11.1324348449707},
	{name="Caixa Eletrônico", id=277, x=1686.74694824219, y=4815.8828125, z=42.0085678100586},
	{name="Caixa Eletrônico", id=277, x=-386.899444580078,y=6045.78466796875,z=31.5001239776611},
	{name="Caixa Eletrônico", id=277, x=1171.52319335938, y=2702.44897460938, z=38.1754684448242},
	{name="Caixa Eletrônico", id=277, x=1968.11157226563, y=3743.56860351563, z=32.3437271118164},
	{name="Caixa Eletrônico", id=277, x=2558.85815429688, y=351.045166015625, z=108.621520996094},
	{name="Caixa Eletrônico", id=277, x=1153.75634765625, y=-326.805023193359, z=69.2050704956055},
	{name="Caixa Eletrônico", id=277, x=-56.9172439575195, y=-1752.17590332031, z=29.4210166931152},
	{name="Caixa Eletrônico", id=277, x=-3241.02856445313, y=997.587158203125, z=12.5503988265991},
	{name="Caixa Eletrônico", id=277, x=-1827.1884765625, y=784.907104492188, z=138.302581787109},
	{name="Caixa Eletrônico", id=277, x=-1091.54748535156, y=2708.55786132813, z=18.9437484741211},
	{name="Caixa Eletrônico", id=277, x=112.45637512207, y=-819.25048828125, z=31.3392715454102},
	{name="Caixa Eletrônico", id=277, x=-256.173187255859, y=-716.031921386719, z=33.5202751159668},
	{name="Caixa Eletrônico", id=277, x=174.227737426758, y=6637.88623046875, z=31.5730476379395},
	{name="Caixa Eletrônico", id=277, x=-660.727661132813, y=-853.970336914063, z=24.484073638916},
	{name="Caixa Eletrônico", id=277, x=147.64224243164, y=-1035.6629638672, z=29.343101501465},
	{name="Caixa Eletrônico", id=277, x=-31.43729019165, y=-1121.4758300781, z=26.55263710022},
	{name="Caixa Eletrônico", id=277, x=-203.84164428711, y=-861.38800048828, z=30.267627716064},
	{name="Caixa Eletrônico", id=277, x=-303.41741943359, y=-829.80480957031, z=32.417224884033},
	{name="Caixa Eletrônico", id=277, x=-301.85656738281, y=-829.99176025391, z=32.417274475098},
	{name="Caixa Eletrônico", id=277, x=145.97698974609, y=-1035.0933837891, z=29.344882965088},
	{name="Caixa Eletrônico", id=277, x=-3044.0075683594, y=594.65246582031, z=7.7366213798523},
	{name="Caixa Eletrônico", id=277, x=-283.06121826172, y=6226.0395507813, z=31.493324279785},
	{name="Caixa Eletrônico", id=277, x=-97.30541229248, y=6455.3315429688, z=31.465923309326},
	{name="Caixa Eletrônico", id=277, x=-95.504890441895, y=6457.2060546875, z=31.460845947266},
	{name="Caixa Eletrônico", id=277, x=155.91654968262, y=6642.8696289063, z=31.601049423218},
	{name="Caixa Eletrônico", id=277, x=1822.5245361328, y=3683.1403808594, z=34.276779174805},
	{name="Caixa Eletrônico", id=277, x=1701.2943115234, y=6426.513671875, z=32.764026641846},
	{name="Caixa Eletrônico", id=277, x=1735.2858886719, y=6410.5893554688, z=35.037231445313},
	{name="Caixa Eletrônico", id=277, x=1702.9456787109, y=4933.5712890625, z=42.063632965088},
	{name="Caixa Eletrônico", id=277, x=540.31530761719, y=2671.1452636719, z=42.156494140625},
	{name="Caixa Eletrônico", id=277, x=1172.5842285156, y=2702.59375, z=38.174686431885},
	{name="Caixa Eletrônico", id=277, x=-2956.775390625, y=487.62973022461, z=15.463917732239},
	{name="Caixa Eletrônico", id=277, x=-2958.970703125, y=487.81292724609, z=15.463917732239},
	{name="Caixa Eletrônico", id=277, x=-3240.5920410156, y=1008.5797119141, z=12.830706596375},
	{name="Caixa Eletrônico", id=277, x=-3040.7219238281, y=593.09497070313, z=7.9089288711548},
	{name="Caixa Eletrônico", id=277, x=-3144.3825683594, y=1127.5979003906, z=20.855199813843},
	{name="Caixa Eletrônico", id=277, x=2683.0073242188, y=3286.5783691406, z=55.24112701416},
	{name="Caixa Eletrônico", id=277, x=380.78570556641, y=323.39031982422, z=103.56637573242},
	{name="Caixa Eletrônico", id=277, x=2558.5021972656, y=389.44189453125, z=108.62294006348},
	{name="Caixa Eletrônico", id=277, x=-1204.9379882813, y=-326.28726196289, z=37.834991455078},
	{name="Caixa Eletrônico", id=277, x=-1205.7120361328, y=-324.75863647461, z=37.859413146973},
	{name="Caixa Eletrônico", id=277, x=418.98785400391, y=-986.27374267578, z=29.390954971313},
	{name="Caixa Eletrônico", id=277, x=-2037.9190673828, y=-469.14538574219, z=12.240758895874},
	{name="Caixa Eletrônico", id=277, x=296.36978149414, y=-894.19561767578, z=29.229251861572},
	{name="Caixa Eletrônico", id=277, x=295.65008544922, y=-896.155273437529, z=213779449463},
	{name="Caixa Eletrônico", id=277, x=-821.59747314453, y=-1081.9825439453, z=11.132431983948},
	{name="Caixa Eletrônico", id=277, x=5.2607088088989, y=-919.87005615234, z=29.558801651001},
	{name="Caixa Eletrônico", id=277, x=289.08346557617, y=-1256.8043212891, z=29.440755844116},
	{name="Caixa Eletrônico", id=277, x=5.2607088088989, y=-919.87005615234, z=29.558801651001},
	{name="Caixa Eletrônico", id=277, x=33.162055969238, y=-1348.2528076172, z=29.497022628784},
}



--===============================================
--==             Core Threading                ==
--===============================================
if bankMenu then
	Citizen.CreateThread(function()
		while true do
			local timing = 1000
			if nearBank() or nearATM() then
				timing = 5
				DisplayHelpText("Aperte ~INPUT_PICKUP~ para acessar o Caixa Eletrônico")

				if IsControlJustPressed(1, 38) then
					inMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openGeneral'})
					TriggerServerEvent('treak:balance')
					local ped = GetPlayerPed(-1)
				end
				if IsControlJustPressed(1, 322) then
					inMenu = false
					SetNuiFocus(false, false)
					SendNUIMessage({type = 'close'})
				end
			end
			Wait(timing)
		end
	end)
end


--===============================================
--==             Map Blips	                   ==
--===============================================
Citizen.CreateThread(function()
	if showblips then
	  for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

Citizen.CreateThread(function()
	if showblips then
	  for k,v in ipairs(atms)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)


--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)

	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('treak:deposit2', tonumber(data.amount))
	TriggerServerEvent('treak:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('treak:withdraw2', tonumber(data.amountw))
	TriggerServerEvent('treak:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('treak:balance')
end)

RegisterNetEvent('grana:back')
AddEventHandler('grana:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('treak:transfer2', data.to, data.amountt)
	TriggerServerEvent('treak:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('treak:result')
AddEventHandler('treak:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 1 then
			return true
		end
	end
end

function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(atms) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 1 then
			return true
		end
	end
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
