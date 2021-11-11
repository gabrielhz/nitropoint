local minute = 20

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) 
		minute = minute - 1
		if minute == 0  then
			minute = 30
			TriggerServerEvent('onblue:salar')
		end
	end
end)