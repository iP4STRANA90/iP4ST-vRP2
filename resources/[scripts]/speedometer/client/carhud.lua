local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- Vehicle Info
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local speedBuffer  	  = {}
local velBuffer  	  = {}
local isBlackedOut = false
local MinSpeedBelt = 45
local lastVehCache
local PedVehIsHeli = false
local PedVehIsPlane = false
local PedVehIsBoat = false 
local PedVehIsBike = false 
local PedVehIsCar = false
local PedVehIsMotorcycle = false


WichVehicleItIs = function(veh)
	if(lastVehCache == nil or lastVehCache ~= veh) then
		lastVehCache = veh
		PedVehIsHeli = false
		PedVehIsPlane = false
		PedVehIsBoat = false 
		PedVehIsBike = false 
		PedVehIsCar = false
		PedVehIsMotorcycle = false
		local vc = GetVehicleClass(veh)
		if( (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)) then
			PedVehIsCar = true
		elseif(vc == 8) then
			PedVehIsMotorcycle = true
		elseif(vc == 13) then
			PedVehIsBike = true
		elseif(vc == 14) then
			PedVehIsBoat = true
		elseif(vc == 15) then
			PedVehIsHeli = true
		elseif(vc == 16) then
			PedVehIsPlane = true
		end
	end
end
Fwv = function (entity)
		    local hr = GetEntityHeading(entity) + 90.0
		    if hr < 0.0 then hr = 360.0 + hr end
		    hr = hr * 0.0174533
		    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end

local function roundToNthDecimal(num, n)
    local mult = 10^(n or 0)
    return math.floor(num * mult + 0.5) / mult
  end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local position = GetEntityCoords(player)

		if IsPedInAnyVehicle(player, false) then
			-- Vehicle Speed
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local vehicleSpeed
			vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
			-- Vehicle Nail Speed
			local vehicleNailSpeed

			vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
			-- Vehicle Fuel and Gear
			local vehicleFuel = GetVehicleFuelLevel(vehicle)
			local vehicleGear = GetVehicleCurrentGear(vehicle)

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = 'N'
			elseif vehicleSpeed > 0 and vehicleGear == 0 then
				vehicleGear = 'R'
			end
			-- Vehicle Lights
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn
			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
            end
            
            -- Vehicle Indicators
			local indicatorLights  = GetVehicleIndicatorLights(vehicle)
			if indicatorLights == 1 then
                vehicleSignalIndicator = 'left'
			elseif (indicatorLights == 2) then
                vehicleSignalIndicator = 'right'
            elseif (indicatorLights == 3) then
                vehicleSignalIndicator = 'both'   
            else
                vehicleSignalIndicator = 'off'
			end
			            
            rpm = GetVehicleCurrentRpm(vehicle)
            rpm = math.ceil(rpm * 10000, 2)
            vehicleNailRpm = 280 - math.ceil( math.ceil((rpm-2000) * 140) / 10000)
            cardamage = GetVehicleEngineHealth(vehicle) / 10 
            vehicleInfo = {
				updateVehicle = true,
                status = true,
                speed = vehicleSpeed,
                nail = vehicleNailSpeed,
                gear = vehicleGear,
                fuel = vehicleFuel,
                lights = vehicleIsLightsOn,
                signals = vehicleSignalIndicator,
                cruiser = vehicleCruiser,
               -- currentKM = roundToNthDecimal(DecorGetFloat(vehicle,'TOTALKM')*100,1),
				seatbelt = Config.vehicle.seatbelt,
				haveBelt = PedVehIsCar,
                damage = cardamage,
                rpmnail = vehicleNailRpm,
                rpm = rpm,
                config = {
                    speedUnit = Config.vehicle.speedUnit,
                    maxSpeed = Config.vehicle.maxSpeed
                }
			}
			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
		else

			vehicleCruiser = 'off'
			vehicleNailSpeed = 0
            vehicleSignalIndicator = 'off'
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
			if(beltWarningSet)then
				TriggerServerEvent('esx_mole_misiones:StopSoundOnSource')
			end
            seatbeltIsOn = false
            beltWarningSet = false

			vehicleInfo = {
				updateVehicle = true,
                status = false,
                nail = 0,
                rpmnail = 0,
                seatbelt = { status = seatbeltIsOn },
                cruiser = vehicleCruiser,
                signals = vehicleSignalIndicator
			}
		end
		SendNUIMessage(vehicleInfo)
	end
end)


-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(function ()

	while true do
		Citizen.Wait(0)

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local vehicleClass = GetVehicleClass(vehicle)

        if IsControlJustPressed(1, Config.vehicle.keys.signalLeft) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'left'
			else
				vehicleSignalIndicator = 'off'
			end
			TriggerEvent('esx_mole_status:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Config.vehicle.keys.signalRight) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'right'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('esx_mole_status:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Config.vehicle.keys.signalBoth) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'both'
			else
				vehicleSignalIndicator = 'off'
			end
			TriggerEvent('esx_mole_status:setCarSignalLights', vehicleSignalIndicator)
        end
	end
end)

function blackout()
	-- Only blackout once to prevent an extended blackout if both speed and damage thresholds were met
	if not isBlackedOut then
		isBlackedOut = true
		-- This thread will black out the user's screen for the specified time
		Citizen.CreateThread(function()
			DoScreenFadeOut(100)
			while not IsScreenFadedOut() do
				Citizen.Wait(0)
			end
			Citizen.Wait(Config.BlackoutTime)
			DoScreenFadeIn(250)
			isBlackedOut = false
			doTheEffect()
		end)
	end
end

function doTheEffect()
	SetTimecycleModifier('BarryFadeOut')
	SetTimecycleModifierStrength(math.min(0.1 / 10, 0.6))
	local myPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsUsing(myPed,false)
	SetVehicleEngineOn(vehicle, false, false, true)
	SetVehicleUndriveable(vehicle, true)
	
	SetTimecycleModifier("REDMIST_blend")
	ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
	Wait(5000)
			
	SetTimecycleModifier("hud_def_desat_Trevor")
	
	Wait(3000)
	
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
	StopGameplayCamShaking()
	SetVehicleUndriveable(vehicle, false)
	SetVehicleEngineOn(vehicle, true, false, true)

end


AddEventHandler('esx_mole_status:setCarSignalLights', function (status)
	local driver = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local hasTrailer,vehicleTrailer = GetVehicleTrailerVehicle(driver,vehicleTrailer)
	local leftLight
	local rightLight

	if status == 'left' then
		leftLight = false
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'right' then
		leftLight = true
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'both' then
		leftLight = true
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	else
		leftLight = false
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	end

	TriggerServerEvent('esx_mole_status:syncCarLights', status)

	SetVehicleIndicatorLights(driver, 0, leftLight)
	SetVehicleIndicatorLights(driver, 1, rightLight)
end)



RegisterNetEvent('esx_mole_status:syncCarLights')
AddEventHandler('esx_mole_status:syncCarLights', function (driver, status)
	local target = GetPlayerFromServerId(driver)
	if target == nil or target == -1 then
		return
	  end
	if target ~= PlayerId() then
		local driver = GetVehiclePedIsIn(GetPlayerPed(target), false)

		if status == 'left' then
			leftLight = false
			rightLight = true

		elseif status == 'right' then
			leftLight = true
			rightLight = false

		elseif status == 'both' then
			leftLight = true
			rightLight = true

		else
			leftLight = false
			rightLight = false
		end

		SetVehicleIndicatorLights(driver, 0, leftLight)
		SetVehicleIndicatorLights(driver, 1, rightLight)

	end
end)

function GetVehicleHandlingMaxSpeed(vehicle)
	local handlingMaxSpeed =  GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
	return handlingMaxSpeed
end
