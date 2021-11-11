--SCRIPT POR MAER COSTA

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("instaladorInternet",emP)
Proxy.addInterface("instaladorInternet",emP)

local cfg = module("vrp","cfg/groups")
local groups = cfg.groups

valorMin = 700
valorMax = 1200


-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------



function emP.pagar()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local pagamento = math.random(valorMin,valorMax)
		vRP.giveMoney(user_id,pagamento)
		return pagamento
	end
end


