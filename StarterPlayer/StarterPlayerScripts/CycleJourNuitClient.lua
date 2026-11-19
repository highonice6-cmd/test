-- StarterPlayer.StarterPlayerScripts.CycleJourNuitClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Lighting = game:GetService( "Lighting" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local DayNightCycle = require( ReplicatedStorage:WaitForChild( "DayNightCycle" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Atmosphere = Lighting:FindFirstChildOfClass( "Atmosphere" )
local ColorCorrectionEffect = Lighting:FindFirstChildOfClass( "ColorCorrectionEffect" )

local function Day( Attribute, Argument2 )
    local Attribute2 = Lighting:GetAttribute( Attribute )

    if Attribute2 == nil then
        return Argument2
    end
    return Attribute2
end

local Table = { }
local ExposureCompensation = Lighting.ExposureCompensation
local JourExposure = Lighting:GetAttribute( "JourExposure" )

if JourExposure ~= nil then
    ExposureCompensation = JourExposure
end

Table.ExposureCompensation = ExposureCompensation
local Ambient = Lighting.Ambient
local JourAmbient = Lighting:GetAttribute( "JourAmbient" )

if JourAmbient ~= nil then
    Ambient = JourAmbient
end

Table.Ambient = Ambient
local OutdoorAmbient = Lighting.OutdoorAmbient
local JourOutdoorAmbient = Lighting:GetAttribute( "JourOutdoorAmbient" )

if JourOutdoorAmbient ~= nil then
    OutdoorAmbient = JourOutdoorAmbient
end

local AtmosphereDensity
Table.OutdoorAmbient = OutdoorAmbient

if Atmosphere then
    AtmosphereDensity = Atmosphere.Density
    local JourAtmDensity = Lighting:GetAttribute( "JourAtmDensity" )

    if JourAtmDensity ~= nil then
        AtmosphereDensity = JourAtmDensity
    end
else
    AtmosphereDensity = Atmosphere
end

local AtmosphereColor
Table.AtmosphereDensity = AtmosphereDensity

if Atmosphere then
    AtmosphereColor = Atmosphere.Color
    local JourAtmColor = Lighting:GetAttribute( "JourAtmColor" )

    if JourAtmColor ~= nil then
        AtmosphereColor = JourAtmColor
    end
else
    AtmosphereColor = Atmosphere
end

local AtmosphereDecay
Table.AtmosphereColor = AtmosphereColor

if Atmosphere then
    AtmosphereDecay = Atmosphere.Decay
    local JourAtmDecay = Lighting:GetAttribute( "JourAtmDecay" )

    if JourAtmDecay ~= nil then
        AtmosphereDecay = JourAtmDecay
    end
else
    AtmosphereDecay = Atmosphere
end

local Contrast
Table.AtmosphereDecay = AtmosphereDecay

if ColorCorrectionEffect then
    Contrast = ColorCorrectionEffect.Contrast
    local JourContrast = Lighting:GetAttribute( "JourContrast" )

    if JourContrast ~= nil then
        Contrast = JourContrast
    end
else
    Contrast = ColorCorrectionEffect
end

local Tint
Table.Contrast = Contrast

if ColorCorrectionEffect then
    Tint = ColorCorrectionEffect.TintColor
    local JourTint = Lighting:GetAttribute( "JourTint" )

    if JourTint ~= nil then
        Tint = JourTint
    end
else
    Tint = ColorCorrectionEffect
end

local Now, Number2
Table.Tint = Tint
local NIGHT = DayNightCycle.NIGHT

local function Mix( Argument1, Argument2, Argument3 )
    if Argument1 == nil or Argument2 == nil then
        return Argument1
    end
    if typeof( Argument1 ) == "Color3" then
        return Argument1:Lerp( Argument2, Argument3 )
    end
    return Argument1 + ( Argument2 - Argument1 ) * Argument3
end

local Number = -1

local function ApplyNight( Night )
    local Floor = math.floor( Night * 50 + 0.5 ) / 50

    if Floor == Number then
        return
    end

    local ExposureCompensation3
    Number = Floor
    local ExposureCompensation = Table.ExposureCompensation
    local ExposureCompensation2 = NIGHT.ExposureCompensation

    if ExposureCompensation == nil or ExposureCompensation2 == nil then
        ExposureCompensation3 = ExposureCompensation
    elseif typeof( ExposureCompensation ) == "Color3" then
        ExposureCompensation3 = ExposureCompensation:Lerp( ExposureCompensation2, Floor )
    else
        ExposureCompensation3 = ExposureCompensation + ( ExposureCompensation2 - ExposureCompensation ) * Floor
    end

    local Ambient3
    Lighting.ExposureCompensation = ExposureCompensation3
    local Ambient = Table.Ambient
    local Ambient2 = NIGHT.Ambient

    if Ambient == nil or Ambient2 == nil then
        Ambient3 = Ambient
    elseif typeof( Ambient ) == "Color3" then
        Ambient3 = Ambient:Lerp( Ambient2, Floor )
    else
        Ambient3 = Ambient + ( Ambient2 - Ambient ) * Floor
    end

    local OutdoorAmbient3
    Lighting.Ambient = Ambient3
    local OutdoorAmbient = Table.OutdoorAmbient
    local OutdoorAmbient2 = NIGHT.OutdoorAmbient

    if OutdoorAmbient == nil or OutdoorAmbient2 == nil then
        OutdoorAmbient3 = OutdoorAmbient
    elseif typeof( OutdoorAmbient ) == "Color3" then
        OutdoorAmbient3 = OutdoorAmbient:Lerp( OutdoorAmbient2, Floor )
    else
        OutdoorAmbient3 = OutdoorAmbient + ( OutdoorAmbient2 - OutdoorAmbient ) * Floor
    end

    Lighting.OutdoorAmbient = OutdoorAmbient3

    if Atmosphere then
        local Density
        local AtmosphereDensity = Table.AtmosphereDensity
        local AtmosphereDensity2 = NIGHT.AtmosphereDensity

        if AtmosphereDensity == nil or AtmosphereDensity2 == nil then
            Density = AtmosphereDensity
        elseif typeof( AtmosphereDensity ) == "Color3" then
            Density = AtmosphereDensity:Lerp( AtmosphereDensity2, Floor )
        else
            Density = AtmosphereDensity + ( AtmosphereDensity2 - AtmosphereDensity ) * Floor
        end

        local Color
        Atmosphere.Density = Density
        local AtmosphereColor = Table.AtmosphereColor
        local AtmosphereColor2 = NIGHT.AtmosphereColor

        if AtmosphereColor == nil or AtmosphereColor2 == nil then
            Color = AtmosphereColor
        elseif typeof( AtmosphereColor ) == "Color3" then
            Color = AtmosphereColor:Lerp( AtmosphereColor2, Floor )
        else
            Color = AtmosphereColor + ( AtmosphereColor2 - AtmosphereColor ) * Floor
        end

        local Decay
        Atmosphere.Color = Color
        local AtmosphereDecay = Table.AtmosphereDecay
        local AtmosphereDecay2 = NIGHT.AtmosphereDecay

        if AtmosphereDecay == nil or AtmosphereDecay2 == nil then
            Decay = AtmosphereDecay
        elseif typeof( AtmosphereDecay ) == "Color3" then
            Decay = AtmosphereDecay:Lerp( AtmosphereDecay2, Floor )
        else
            Decay = AtmosphereDecay + ( AtmosphereDecay2 - AtmosphereDecay ) * Floor
        end

        Atmosphere.Decay = Decay
    end
    if ColorCorrectionEffect then
        local Contrast3
        local Contrast = Table.Contrast
        local Contrast2 = NIGHT.Contrast

        if Contrast == nil or Contrast2 == nil then
            Contrast3 = Contrast
        elseif typeof( Contrast ) == "Color3" then
            Contrast3 = Contrast:Lerp( Contrast2, Floor )
        else
            Contrast3 = Contrast + ( Contrast2 - Contrast ) * Floor
        end

        local TintColor
        ColorCorrectionEffect.Contrast = Contrast3
        local Tint = Table.Tint
        local Tint2 = NIGHT.Tint

        if Tint == nil or Tint2 == nil then
            TintColor = Tint
        elseif typeof( Tint ) == "Color3" then
            TintColor = Tint:Lerp( Tint2, Floor )
        else
            TintColor = Tint + ( Tint2 - Tint ) * Floor
        end

        ColorCorrectionEffect.TintColor = TintColor
    end
end

Now = nil
Number2 = -math.huge

while true do
    local NightWeight2
    local ClockTime = DayNightCycle.Now( )

    if ClockTime then
        local NightWeight = DayNightCycle.NightWeight( ClockTime )

        if NightWeight then
            NightWeight2 = NightWeight
        else
            NightWeight2 = 0
        end
    else
        NightWeight2 = 0
    end
    if ClockTime then
        if not ClientState.SkyNoNight or workspace:GetAttribute( "RankedMatch" ) then
            if ClientState.CaseRolling then
                Number = -1
                Now = nil
            else
                local Flag

                if Now == nil then
                    Flag = true
                elseif math.abs( ( ClockTime - Now + 12 ) % 24 - 12 ) > 0.25 then
                    Flag = true
                else
                    Flag = false
                end
                if Flag or os.clock( ) - Number2 >= 10 then
                    Lighting.ClockTime = ClockTime
                    Number2 = os.clock( )
                    Now = ClockTime
                end

                ApplyNight( NightWeight2 )
            end
        else
            Number = -1
            Now = nil
        end
    else
        Number = -1
        Now = nil
    end

    local Number3 = ( not ( NightWeight2 > 0 ) or not ( NightWeight2 < 1 ) ) and 1 or 0.5
    task.wait( Number3 )
end
