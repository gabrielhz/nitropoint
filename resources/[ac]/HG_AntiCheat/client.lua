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


AntiCheat = true
AntiCheatStatus = "~g~Ativado!"
PedStatus = 0

CarsBL = {

}

Citizen.CreateThread(function()
	while true do
        Wait(500)
      if (AntiCheat == true)then
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		v = GetVehiclePedIsIn(playerPed, false)
		end
		playerPed = GetPlayerPed(-1)
		if playerPed and v then
		if GetPedInVehicleSeat(v, -1) == playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))
            end
        end
	   end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)
		if isCarBlacklisted(carModel) then
            _DeleteEntity(car)
			TriggerServerEvent("HG_AntiCheat:Cars", blacklistedCar )
        end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(CarsBL) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(500)
	for _,theWeapon in ipairs(WeaponBL) do
        Wait(1)
        if (AntiCheat == true)then
		    if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
                RemoveAllPedWeapons(PlayerPedId(),false)
                TriggerServerEvent("HG_AntiCheat:Weaponban", WeaponBL )
            end
        end
	end
	end
end)

function DeleteObjects(object, detach)
    if DoesEntityExist(object) then
	NetworkRequestControlOfEntity(object)
	while not NetworkHasControlOfEntity(object) do
		Citizen.Wait(1)
	end
	if detach then
        DetachEntity(object, 0, false)
	end
	
	SetEntityCollision(object, false, false)
	SetEntityAlpha(object, 0.0, true)
	SetEntityAsMissionEntity(object, true, true)
	SetEntityAsNoLongerNeeded(object)
    DeleteEntity(object)

	end
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(500)
	local ped = PlayerPedId()
	local handle, object = FindFirstObject()
	local finished = false
	repeat
        Wait(1)
        if (AntiCheat == true)then
        if IsEntityAttached(object) and DoesEntityExist(object) then

        if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
            DeleteObjects(object, true)
		end
		end
		for i=1,#ObjectsBL do
		if GetEntityModel(object) == GetHashKey(ObjectsBL[i]) then
            DeleteObjects(object, false)
            
		end
        end
    end
        finished, object = FindNextObject(handle)
	until not finished
	EndFindObject(handle)
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        if (AntiCheat == true)then
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(0)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
                TriggerServerEvent("HG_AntiCheat:Jump", jumplength )
			end
        end
    end
	end
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieFunctionParameterString(anticheatm)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        --SetTextDropShadow()
        --SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end
Citizen.CreateThread(function()
while true do
	Citizen.Wait(1)
    if anticheatm then
		scaleform = Initialize("mp_big_message_freemode")
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
    end
end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (AntiCheat == true) then
			SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
		else
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		end
	end
end)

RegisterNetEvent("HG_AntiCheat:Toggle")
AddEventHandler("HG_AntiCheat:Toggle", function()
    if (AntiCheat == false) then
        AntiCheat = true
        AntiCheatStatus = "~g~Ativado"
        anticheatm = "~y~AntiCheat ~g~Pornit"
        Citizen.Wait(5000)
        anticheatm = false
    else
		AntiCheat = false
        AntiCheatStatus = "~r~Inativo"
        anticheatm = "~y~AntiCheat ~r~Oprit"
        PedStatus = "OFF"
        Citizen.Wait(5000)
        anticheatm = false
	end
end)

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(3000)
        if (AntiCheat == true)then
            DeleteEntity(ped)
        end
    end
end) 

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
      
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
      
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
      
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
  
local function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / 1000

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

function ACstatus(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function KillAllPeds()
    local pedweapon
    local pedid
    for ped in EnumeratePeds() do 
        if DoesEntityExist(ped) then
            pedid = GetEntityModel(ped)
            pedweapon = GetSelectedPedWeapon(ped)
            if pedweapon == -1312131151 or not IsPedHuman(ped) then 
                ApplyDamageToPed(ped, 1000, false)
                DeleteEntity(ped)
            else
                switch = function (choice)
                    choice = choice and tonumber(choice) or choice
                  
                    case =
                    {
                        [451459928] = function ( )
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                  
                        [1684083350] = function ( )
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,

                        [451459928] = function ( )
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
              
                        [1096929346] = function ( )
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,

                        [880829941] = function ( )
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
          
                        [-1404353274] = function ( )
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,

                        [2109968527] = function ( )
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,

                       default = function ( )
                       end,
                    }

                    if case[choice] then
                       case[choice]()
                    else
                       case["default"]()
                    end
                  
                  end
                  switch(pedid) 
            end
        end
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0,288) then
			TriggerServerEvent("treak:press",288)
		end
		if IsControlJustPressed(0,172) then
			TriggerServerEvent("treak:press",172)
        end
        if IsControlJustPressed(0,173) then
			TriggerServerEvent("treak:press",173)
        end
        if IsControlJustPressed(0,344) then
			TriggerServerEvent("treak:press",344)
        end
        if IsControlJustPressed(0,121) then
			TriggerServerEvent("treak:press",121)
		end
		if IsControlJustPressed(0,108) then
			TriggerServerEvent("treak:press",108)
		end
		if IsControlJustPressed(0,112) then
			TriggerServerEvent("treak:press",112)
		end
		if IsControlJustPressed(0,111) then
			TriggerServerEvent("treak:press",111)
        end
        if IsControlJustPressed(0,121) then
			TriggerServerEvent("treak:press",121)
        end
        
	end
end)
