local MeeleWeapons = {
    ["WEAPON_NIGHTSTICK"] = 0.0, 
    ["WEAPON_GOLFCLUB"] = 0.0,  
    ["WEAPON_FLASHLIGHT"] = 0.0,    	
    ["WEAPON_DAGGER"] = 0.0,    
    ["WEAPON_BAT"] = 0.0,    
    ["WEAPON_BOTTLE"] = 0.0,    
    ["WEAPON_CROWBAR"] = 0.0,    
    ["WEAPON_HAMMER"] = 0.0,    
    ["WEAPON_HATCHET"] = 0.0,    
    ["WEAPON_KNUCKLE"] = 0.0,    
    ["WEAPON_KNIFE"] = 0.0,    
    ["WEAPON_MACHETE"] = 0.0,    
    ["WEAPON_SWITCHBLADE"] = 0.0,    
    ["WEAPON_WRENCH"] = 0.0,    
    ["WEAPON_BATTLEAXE"] = 0.0,    
    ["WEAPON_POOLCUE"] = 0.0,    
    ["WEAPON_STONE_HATCHET"] = 0.0,    
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

		for weapon, modifier in pairs(MeeleWeapons) do
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(weapon) then
				SetPlayerMeleeWeaponDamageModifier(PlayerId(), v)
			end
		end
    end
end)
-- ARMAS DE FOGO
Citizen.CreateThread(function()
    while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 2.0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.1) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"), 1.5) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 1.8) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"), 0.1)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL"), 0.1) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VINTAGEPISTOL"), 0.1) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER"), 0.1) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MUSKET"), 2.1)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"), 0.1) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG"), 4.5) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSMG"), 0.1) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPDW"), 2.9)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), 9.3) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUSENBERG"), 0.1) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 3.5)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 3.8	) 
	Wait(0)
    end
end)