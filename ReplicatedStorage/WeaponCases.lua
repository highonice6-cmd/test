-- ReplicatedStorage.WeaponCases
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    INFO = {
        Basic = {
            DisplayName = "Basic Case",
            Short = "Basic",
            Cost = 5000,
            AnimStyle = "Classic",
            WaveColor = Color3.fromRGB( 100, 100, 112 )
        },
        Normal = {
            DisplayName = "Normal Case",
            Short = "Normal",
            Cost = 15000,
            AnimStyle = "Cinema",
            WaveColor = Color3.fromRGB( 170, 70, 215 )
        },
        Legendary = {
            DisplayName = "Legendary Case",
            Short = "Legendary",
            Cost = 30000,
            AnimStyle = "Legendary",
            WaveColor = Color3.fromRGB( 235, 180, 45 )
        }
    },
    ODDS = {
        Legendary = {
            BrassKnuckle = 18.817,
            M9 = 16.652,
            SawedOff = 16.01,
            Uzi = 14.729,
            MP5 = 10.079,
            AK = 9.072,
            M4 = 6.048,
            SPAS12 = 4.535,
            M60 = 4.032,
            DRAGON = 0.01,
            RPG = 0.007,
            AWP = 0.005,
            Eagle = 0.003,
            RiotShield = 0.001
        },
        Normal = {
            Batte = 8.129,
            Bayonneta = 8.112,
            BrokenBottle = 8.128,
            Baton = 8.128,
            MetalPipe = 8.128,
            Shovel = 8.128,
            BrassKnuckle = 8.128,
            Crowbar = 8.128,
            M9 = 6.63,
            SawedOff = 6.356,
            Uzi = 6.139,
            MP5 = 5.519,
            AK = 5.017,
            M4 = 2.709,
            SPAS12 = 1.605,
            M60 = 1.003,
            DRAGON = 0.005,
            RPG = 0.0035,
            AWP = 0.0025,
            Eagle = 0.0015,
            RiotShield = 0.0005
        },
        Basic = {
            Batte = 10.426,
            Bayonneta = 10.4245,
            BrokenBottle = 10.425,
            Baton = 10.425,
            MetalPipe = 10.425,
            Shovel = 10.425,
            BrassKnuckle = 10.425,
            Crowbar = 10.425,
            M9 = 4.411,
            SawedOff = 4.097,
            Uzi = 3.782,
            MP5 = 1.601,
            AK = 1.401,
            M4 = 0.651,
            SPAS12 = 0.4,
            M60 = 0.25,
            DRAGON = 0.0025,
            RPG = 0.00175,
            AWP = 0.00125,
            Eagle = 0.00075,
            RiotShield = 0.00025
        }
    },
    UPCOMING = { },
    ODDS_WITH = {
        MK14 = {
            Legendary = {
                BrassKnuckle = 18.266,
                M9 = 16.164,
                SawedOff = 15.541,
                Uzi = 14.298,
                MP5 = 9.784,
                AK = 8.806,
                M4 = 6.048,
                SPAS12 = 4.535,
                M60 = 4.032,
                MK14 = 2.5,
                DRAGON = 0.01,
                RPG = 0.007,
                AWP = 0.005,
                Eagle = 0.003,
                RiotShield = 0.001
            },
            Normal = {
                Batte = 8.078,
                Bayonneta = 8.057,
                BrokenBottle = 8.077,
                Baton = 8.077,
                MetalPipe = 8.077,
                Shovel = 8.077,
                BrassKnuckle = 8.077,
                Crowbar = 8.077,
                M9 = 6.588,
                SawedOff = 6.316,
                Uzi = 6.1,
                MP5 = 5.484,
                AK = 4.985,
                M4 = 2.709,
                SPAS12 = 1.605,
                M60 = 1.003,
                MK14 = 0.6,
                DRAGON = 0.005,
                RPG = 0.0035,
                AWP = 0.0025,
                Eagle = 0.0015,
                RiotShield = 0.0005
            },
            Basic = {
                Batte = 10.41,
                Bayonneta = 10.4095,
                BrokenBottle = 10.409,
                Baton = 10.409,
                MetalPipe = 10.409,
                Shovel = 10.409,
                BrassKnuckle = 10.409,
                Crowbar = 10.409,
                M9 = 4.404,
                SawedOff = 4.091,
                Uzi = 3.776,
                MP5 = 1.599,
                AK = 1.399,
                M4 = 0.651,
                SPAS12 = 0.4,
                M60 = 0.25,
                MK14 = 0.15,
                DRAGON = 0.0025,
                RPG = 0.00175,
                AWP = 0.00125,
                Eagle = 0.00075,
                RiotShield = 0.00025
            }
        },
        G36 = {
            Legendary = {
                BrassKnuckle = 17.715,
                M9 = 15.676,
                SawedOff = 15.072,
                Uzi = 13.867,
                MP5 = 9.489,
                AK = 8.54,
                M4 = 6.048,
                SPAS12 = 4.535,
                M60 = 4.032,
                MK14 = 2.5,
                G36 = 2.5,
                DRAGON = 0.01,
                RPG = 0.007,
                AWP = 0.005,
                Eagle = 0.003,
                RiotShield = 0.001
            },
            Normal = {
                Batte = 8.026,
                Bayonneta = 8.009,
                BrokenBottle = 8.025,
                Baton = 8.025,
                MetalPipe = 8.025,
                Shovel = 8.025,
                BrassKnuckle = 8.025,
                Crowbar = 8.025,
                M9 = 6.546,
                SawedOff = 6.276,
                Uzi = 6.061,
                MP5 = 5.449,
                AK = 4.953,
                M4 = 2.709,
                SPAS12 = 1.605,
                M60 = 1.003,
                MK14 = 0.6,
                G36 = 0.6,
                DRAGON = 0.005,
                RPG = 0.0035,
                AWP = 0.0025,
                Eagle = 0.0015,
                RiotShield = 0.0005
            },
            Basic = {
                Batte = 10.394,
                Bayonneta = 10.3945,
                BrokenBottle = 10.393,
                Baton = 10.393,
                MetalPipe = 10.393,
                Shovel = 10.393,
                BrassKnuckle = 10.393,
                Crowbar = 10.393,
                M9 = 4.397,
                SawedOff = 4.085,
                Uzi = 3.77,
                MP5 = 1.597,
                AK = 1.397,
                M4 = 0.651,
                SPAS12 = 0.4,
                M60 = 0.25,
                MK14 = 0.15,
                G36 = 0.15,
                DRAGON = 0.0025,
                RPG = 0.00175,
                AWP = 0.00125,
                Eagle = 0.00075,
                RiotShield = 0.00025
            }
        }
    },
    ODDS_WITH_ORDER = { "G36", "MK14" }
}

local function Installed( Name, Argument2 )
    if type( Argument2 ) == "table" then
        local Flag = table.find( Argument2, Name ) ~= nil and true or false
        return Flag
    end
    local FoundChild
    local BetaRollWeapons = game:GetService( "ReplicatedStorage" ):FindFirstChild( "BetaRollWeapons" )

    if BetaRollWeapons then
        FoundChild = BetaRollWeapons:FindFirstChild( Name )
    else
        FoundChild = BetaRollWeapons
    end
    if FoundChild == nil or not FoundChild:IsA( "Tool" ) or FoundChild:GetAttribute( "Weapon" ) ~= Name then
        return false
    end

    local Number2
    local Number = tonumber( FoundChild:GetAttribute( "CaseLockedUntil" ) )

    if Number then
        if workspace:GetServerTimeNow( ) < Number then
            Number2 = true
        else
            Number2 = false
        end
    else
        Number2 = Number
    end

    return not Number2
end

function Table.Table( Key, Argument2 )
    local Value1
    local ODDS_WITH_ORDER = Table.ODDS_WITH_ORDER
    Value1 = nil

    for Key2, Value in ODDS_WITH_ORDER, nil, nil do
        local Entry = Table.ODDS_WITH[ Value ]

        if Entry and Entry[ Key ] then
            if Installed( Value, Argument2 ) then
                return Entry[ Key ]
            end
        end
    end

    local Value2
    local ODDS_WITH = Table.ODDS_WITH
    Value2 = nil

    for Key3, Value3 in ODDS_WITH, nil, nil do
        if not table.find( Table.ODDS_WITH_ORDER, Key3 ) and Value3[ Key ] then
            if Installed( Key3, Argument2 ) then
                return Value3[ Key ]
            end
        end
    end

    return Table.ODDS[ Key ]
end
function Table.Odds( Argument1, List )
    local Value1 = Table.Table( Argument1, List )

    if not Value1 then
        return nil
    end

    local Value2
    local TableInner = { }
    Value2 = nil

    for Key, Value in List, nil, nil do
        if ( Value1[ Value ] or 0 ) > 0 then
            TableInner[ Value ] = Value1[ Value ]
        end
    end

    return TableInner
end
function Table.Pick( List, Callback, Argument3 )
    local Random2

    if Argument3 then
        Random2 = Argument3
    else
        Random2 = Random.new( )
    end

    local Value1, Number
    Value1 = nil
    Number = 0

    for Key, Value in List, nil, nil do
        Number = Number + math.max( 0, Callback( Value ) or 0 )
    end
    if Number <= 0 then
        return List[ Random2:NextInteger( 1, #List ) ]
    end

    local Value2, Value4
    local NextNumber = Random2:NextNumber( ) * Number
    Value2 = nil
    Value4 = nil

    for Key2, Value3 in List, nil, nil do
        local Max = math.max( 0, Callback( Value3 ) or 0 )

        if Max > 0 then
            local NextNumber2 = NextNumber - Max

            if NextNumber2 < 0 then
                return Value3
            end
            Value4 = Value3
            NextNumber = NextNumber2
        end
    end

    return Value4
end
function Table.Roll( Argument1, Argument2, Argument3 )
    local Odds2
    local Odds = Table.Odds( Argument1, Argument2 )
    Odds2 = if Odds then Odds else { }
    return Table.Pick( Argument2, function( Key )
        return Odds2[ Key ]
    end, Argument3 )
end
return Table
