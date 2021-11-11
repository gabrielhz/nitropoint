---CREATED BY GADZA!   Gadza#5750 - Discord
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_banking")

vRPlogs = Proxy.getInterface("vRP_logs")

vRPbanking = {}
Tunnel.bindInterface("vRP_banking",vRPbanking)
Proxy.addInterface("vRP_banking",vRPbanking)

RegisterServerEvent('treak:deposit2')
AddEventHandler('treak:deposit2', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId(thePlayer)
	local walletMoney = vRP.getMoney(user_id)
	local bankMoney = vRP.getBankMoney(user_id)
	if(tonumber(amount))then
		if(vRP.tryPayment(user_id, amount))then
			vRP.setBankMoney(user_id, bankMoney+amount)
			vRP.setMoney(user_id, walletMoney-amount)
			vRPclient.notify(thePlayer, "~w~Você depositou ~g~$"..amount.." ~w~no Banco!")
		else
			vRPclient.notify(thePlayer, "~r~Você não tem dinheiro Suficiente!")
		end
	else
		vRPclient.notify(thePlayer, "~r~Numero inválido!")
	end
end)


RegisterServerEvent('treak:withdraw2')
AddEventHandler('treak:withdraw2', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId(thePlayer)
	local walletMoney = vRP.getMoney(user_id)
	local bankMoney = vRP.getBankMoney(user_id)
	if(tonumber(amount))then	
		amount = tonumber(amount)
		if(amount > 0 and amount <= bankMoney)then
			vRP.setBankMoney(user_id, bankMoney-amount)
			vRP.setMoney(user_id, walletMoney+amount)
			vRPclient.notify(thePlayer, "~w~Você retirou ~g~$"..amount.." ~w~no Banco!")
		else
			vRPclient.notify(thePlayer, "~r~Você não tem dinheiro Suficiente!")
		end
	else
		vRPclient.notify(thePlayer, "~r~Numero Inválido!")
	end
end)

RegisterServerEvent('treak:balance')
AddEventHandler('treak:balance', function()
	local thePlayer = source
	
	local user_id = vRP.getUserId(thePlayer)
	local bankMoney = vRP.getBankMoney(user_id)
	TriggerClientEvent('currentbalance1', thePlayer, bankMoney)
end)

RegisterServerEvent('treak:transfer2')
AddEventHandler('treak:transfer2', function(to, amount)
	local thePlayer = source
	local user_id = vRP.getUserId(thePlayer)
	if(tonumber(to)  and to ~= "" and to ~= nil)then
		to = tonumber(to)
		theTarget = vRP.getUserSource(to)
		if(theTarget)then
			if(thePlayer == theTarget)then
				vRPclient.notify(thePlayer, "~r~Transferência Inválida!")
			else
				if(tonumber(amount) and tonumber(amount) > 0 and amount ~= "" and amount ~= nil)then
					amount = tonumber(amount)
					bankMoney = vRP.getBankMoney(user_id)
					if(bankMoney >= amount)then
						newBankMoney = tonumber(bankMoney - amount)
						vRP.setBankMoney(user_id, newBankMoney)
						vRP.giveBankMoney(to, amount)
						vRPclient.notify(thePlayer, "~w~Você transferiu ~g~$"..amount.." ~w~para ~b~"..GetPlayerName(theTarget))
            vRPclient.notify(theTarget, "~w~"..GetPlayerName(thePlayer).." ~g~Transferencia Efetuada ~b~$"..amount)
						vRP.log("dinheiro", "Banco Transferir","ID: "..user_id.."\nPara: "..vRP.getUserId(theTarget).."\nTransferiu: R$"..amount)
					else
						vRPclient.notify(thePlayer, "~r~Você não tem dinheiro Suficiente!")
					end
				else
					vRPclient.notify(thePlayer, "~r~Numero Inválido!")
				end
			end
		else
			vRPclient.notify(thePlayer, "~r~Destinatário não Encontrado.")
		end
	end
end)