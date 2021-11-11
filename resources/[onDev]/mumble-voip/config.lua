mumbleConfig = {
    voiceModes = {
        {5, "Sussurrando"}, -- Whisper speech distance in gta distance units
        {10, "Normal"}, -- Normal speech distance in gta distance units
        {15, "Gritando"}, -- Shout speech distance in gta distance units
    },
    speakerRange = 1.5, -- Speaker distance in gta distance units (how close you need to be to another player to hear other players on the radio or phone)
    callSpeakerEnabled = true, -- Allow players to hear all talking participants of a phone call if standing next to someone that is on the phone
    radioSpeakerEnabled = true, -- Allow players to hear all talking participants in a radio if standing next to someone that has a radio
    radioEnabled = true, -- Enable or disable using the radio
    micClicks = true, -- Are clicks enabled or not
    micClickOn = true, -- Is click sound on active
    micClickOff = true, -- Is click sound off active
    micClickVolume = 0.09, -- How loud a mic click is
    radioClickMaxChannel = 100, -- Set the max amount of radio channels that will have local radio clicks enabled
    controls = { -- Change default key binds
        proximity = {
            key = 212, -- home
        }, -- Switch proximity mode
        radio = {
            pressed = false, -- don't touch
            key = 137, -- capital
        }, -- Use radio
        speaker = {
            key = 212, -- home
            secondary = 20, -- z
        } -- Toggle speaker mode (phone calls)
    },
    radioChannelNames = { -- Add named radio channels (Defaults to [channel number] MHz)
        [1000] = "Suporte",
        [1001] = "Equipe Staff",
        [1002] = "Hospital",
        [1003] = "VTR01",
        [1004] = "VTR02",
        [1005] = "COPOM",
        [1006] = "Bope",
        [1007] = "PF Geral",
        [1008] = "Investigação PF",
        [1009] = "Lotus",
        [1010] = "Bennys",
        [1011] = "Milicia",
        [1012] = "M.C",
        [1013] = "Mafia",
        [1014] = "Yakuza",
        [1015] = "C.V",
        [1016] = "PCC",
        [1017] = "T.C.P",
        [1018] = "Cosa Nostra",
        [1019] = "A.D.A",
        [1020] = "Vanilla",
    }
}

-- Update config properties from another script
function SetMumbleProperty(key, value)
	if mumbleConfig[key] ~= nil and mumbleConfig[key] ~= "controls" and mumbleConfig[key] ~= "radioChannelNames" then
		mumbleConfig[key] = value
	end
end

function AddRadioChannelName(channel, name)
    local channel = tonumber(channel)

    if channel ~= nil and name ~= nil and name ~= "" then
        if not mumbleConfig.radioChannelNames[channel] then
            mumbleConfig.radioChannelNames[channel] = tostring(name)
        end
    end
end

-- Make exports available on first tick
exports("SetMumbleProperty", SetMumbleProperty)
exports("SetTokoProperty", SetMumbleProperty)
exports("AddRadioChannelName", AddRadioChannelName)