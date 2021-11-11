--[[
    FiveM Scripts
	The Official HackerGeo Script 
	Credits - HackerGeo
	Website - www.HackerGeo.com
	GitHub - GITHUB.com/HackerGeo-sp1ne
	Steam - SteamCommunity.com/id/HackerGeo1
	Copyright 2019 ©HackerGeo. All rights served
]]

------------------------------------------------------WARNING-----------------------------------------------------
---------------------Do not reupload/re release any part of this script without my permission---------------------
------------------------------------------------------------------------------------------------------------------


local cfg = {}
local resourceName = ""..GetCurrentResourceName()..""

cfg.anticheat = {
    steam_require = false,
    name = "[AntiCheat]",
    author = "HackerGeo",
    perm = "anticheat.settings",
    no_perm = "~r~Nu ai acces la setarile ~g~AntiCheat-ului!",
    protect = "~y~Server protejat de ~g~".. resourceName .."!",
    database = "Baza de date verificata",
    reason = "reason",
    steam = "Trebuie sa ai STEAM-ul pornit"
}

cfg.jump = {
    reason = "Super Pulo",
    desc = "Kick",
    kick = "Foi detectado um possível hack, o Anti-Hack do servidor determinou fazer isso. Se foi um erro, contate-nos no discord!",
}

cfg.cars = {
    reason = "Veículo não permitido",
    desc = "Banimento",
    kick = "Foi detectado um possível hack, o Anti-Hack do servidor determinou fazer isso. Se foi um erro, contate-nos no discord!",
}

cfg.version = {
    version = "1.7.7",
    new = "New AntiCheat Version",
    current = "Your AntiCheat Version",
    updated = "is up to date",
    outdated = "is Outdated",
    download = "Download the latest version",
    from = "From the HackerGeo.com",
}


function getConfig()
	return cfg
end
