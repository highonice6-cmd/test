-- ReplicatedStorage.DayNightCycle
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Flag
local Table = {
    DAY_SECONDS = 900,
    NIGHT_SECONDS = 300,
    DAWN = 6.25,
    DUSK = 18.25,
    START = 10,
    RAMP = 1
}
local DUSK = Table.DUSK - Table.DAWN
local DUSK2 = 24 - DUSK
Table.CYCLE = Table.DAY_SECONDS + Table.NIGHT_SECONDS
Table.NIGHT = {
    ExposureCompensation = 0.8,
    Ambient = Color3.fromRGB( 120, 130, 150 ),
    OutdoorAmbient = Color3.fromRGB( 110, 125, 165 ),
    AtmosphereDensity = 0.2,
    AtmosphereColor = Color3.fromRGB( 70, 85, 120 ),
    AtmosphereDecay = Color3.fromRGB( 40, 50, 80 ),
    Contrast = 0,
    Tint = Color3.fromRGB( 225, 232, 255 )
}
Table.START_OFFSET = ( Table.START - Table.DAWN ) / DUSK * Table.DAY_SECONDS
function Table.ClockAt( Argument1 )
    local CYCLE = Argument1 % Table.CYCLE

    if CYCLE < Table.DAY_SECONDS then
        return Table.DAWN + CYCLE / Table.DAY_SECONDS * DUSK
    end
    return ( Table.DUSK + ( CYCLE - Table.DAY_SECONDS ) / Table.NIGHT_SECONDS * DUSK2 ) % 24
end
function Table.NightWeight( Argument1 )
    local DUSK = ( Argument1 - Table.DUSK ) % 24

    if DUSK2 <= DUSK then
        return 0
    end
    return ( math.clamp( math.min( DUSK, DUSK2 - DUSK ) / Table.RAMP, 0, 1 ) )
end
Table.RANKED_CLOCK = 13
function Table.Now()
    if workspace:GetAttribute( "RankedMatch" ) then
        return Table.RANKED_CLOCK
    end

    local CycleOrigin = game:GetService( "Lighting" ):GetAttribute( "CycleOrigin" )

    if type( CycleOrigin ) == "number" then
        return Table.ClockAt( workspace:GetServerTimeNow( ) - CycleOrigin )
    end
    return nil
end

if math.abs( Table.ClockAt( 0 ) - Table.DAWN ) < 1e-06 then
    if math.abs( Table.ClockAt( Table.DAY_SECONDS ) - Table.DUSK ) < 1e-06 then
        if math.abs( Table.ClockAt( Table.DAY_SECONDS + Table.NIGHT_SECONDS / 2 ) - 0.25 ) < 1e-06 then
            if math.abs( Table.ClockAt( Table.START_OFFSET ) - Table.START ) < 1e-06 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end
else
    Flag = false
end

local Flag2
assert( Flag, "DayNightCycle : calcul d'heure faux" )

if Table.NightWeight( 12 ) == 0 then
    if Table.NightWeight( 0.25 ) == 1 then
        if math.abs( Table.NightWeight( Table.DUSK + Table.RAMP / 2 ) - 0.5 ) < 1e-06 then
            if math.abs( Table.NightWeight( Table.DAWN - Table.RAMP / 2 ) - 0.5 ) < 1e-06 then
                Flag2 = true
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end
else
    Flag2 = false
end

assert( Flag2, "DayNightCycle : fondu de nuit faux" )
return Table
