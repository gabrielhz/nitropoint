local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	-- ARMAS
	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 150000 },
	{ item = "wbody|WEAPON_ASSAULTRIFLE", quantidade = 1, compra = 400000 },
	{ item = "wbody|WEAPON_REVOLVER", quantidade = 1, compra = 350000 },
	{ item = "wbody|WEAPON_SNSPISTOL", quantidade = 1, compra = 60000 },
	{ item = "wbody|WEAPON_GUSENBERG", quantidade = 1, compra = 350000 },
	{ item = "wbody|WEAPON_MICROSMG", quantidade = 1, compra = 250000 },
	--MUNIÇÃO
	{ item = "wammo|WEAPON_PISTOL_MK2", quantidade = 50, compra = 4000 },
	{ item = "wammo|WEAPON_ASSAULTRIFLE", quantidade = 50, compra = 5000 },
	{ item = "wammo|WEAPON_REVOLVER", quantidade = 50, compra = 5000 },
	{ item = "wammo|WEAPON_SNSPISTOL", quantidade = 50, compra = 3000 },
	{ item = "wammo|WEAPON_GUSENBERG", quantidade = 50, compra = 3000 },
	{ item = "wammo|WEAPON_MICROSMG", quantidade = 50, compra = 3000 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-comprar")
AddEventHandler("armamentos-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.hasPermission(user_id,"cosanostra.permissao") then
		if item == "colete" then
			if vRP.tryPayment(user_id,20000) then
				vRPclient.setArmour(source,100)
				TriggerClientEvent("Notify",source,"sucesso","Comprou <b>1x Colete</b> por <b>$10.000 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		else
			for k,v in pairs(valores) do
				if item == v.item then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryPayment(user_id,parseInt(v.compra)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				end
			end
		end
	end
end)