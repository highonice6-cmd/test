-- ReplicatedStorage.VehicleCrates
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    Rarities = {
        common = { Name = "COMMON", Color = Color3.fromRGB( 150, 150, 165 ), Order = 1 },
        uncommon = { Name = "UNCOMMON", Color = Color3.fromRGB( 70, 200, 95 ), Order = 2 },
        rare = { Name = "RARE", Color = Color3.fromRGB( 45, 125, 220 ), Order = 3 },
        epic = { Name = "EPIC", Color = Color3.fromRGB( 165, 70, 225 ), Order = 4 },
        legendary = {
            Name = "LEGENDARY",
            Color = Color3.fromRGB( 240, 180, 45 ),
            Order = 5
        },
        mythical = { Name = "MYTHICAL", Color = Color3.fromRGB( 225, 45, 60 ), Order = 6 }
    },
    Cars = {
        CheapCar = { Name = "Compact", Rarity = "rare", Weight = 26.2 },
        [ "208" ] = { Name = "208", Rarity = "rare", Weight = 21.5 },
        Cayen = { Name = "Cayen", Rarity = "epic", Weight = 29.8 },
        Challenger = { Name = "Challenger", Rarity = "legendary", Weight = 11.8 },
        BM = { Name = "BM", Rarity = "legendary", Weight = 9.6 },
        ArmoredVehicle = {
            Name = "Armored",
            Rarity = "mythical",
            Weight = 1,
            Special = "ArmoredStudio"
        },
        Lambo = {
            Name = "Lambo",
            Rarity = "mythical",
            Weight = 0.1,
            Special = "LamboStudio"
        },
        Vette = {
            Name = "Vette",
            Rarity = "mythical",
            Weight = 0.08,
            Special = "VetteStudio",
            Release = "VetteOn",
            From = "CheapCar"
        }
    },
    SPECIAL_SOUND = {
        LamboStudio = 89202009384278,
        ArmoredStudio = 89202009384278,
        VetteStudio = 89202009384278
    },
    SPECIAL_START = { LamboStudio = 0.18, ArmoredStudio = 0.18, VetteStudio = 0.18 },
    FORCE = nil,
    REFUND = 0.5,
    CRATES = {
        Street = {
            Name = "Street Crate",
            Short = "Street",
            Cost = 50000,
            Weights = {
                CheapCar = 44.14,
                [ "208" ] = 36.12,
                Cayen = 17.96,
                Challenger = 1.5,
                BM = 0.167,
                ArmoredVehicle = 0.083,
                Lambo = 0.017,
                Vette = 0.013
            }
        },
        Elite = {
            Name = "Elite Crate",
            Short = "Elite",
            Cost = 100000,
            Weights = {
                CheapCar = 38.277,
                [ "208" ] = 31.263,
                Cayen = 26.9,
                Challenger = 3,
                BM = 0.333,
                ArmoredVehicle = 0.167,
                Lambo = 0.033,
                Vette = 0.027
            }
        },
        Mythic = {
            Name = "Mythic Crate​⁠​⁠​⁠​⁠​⁠​⁠​​⁠​​​​⁠​⁠​⁠",
            Short = "Mythic",
            Cost = 300000,
            Weights = {
                CheapCar = 31.82,
                [ "208" ] = 30.5,
                Cayen = 27,
                Challenger = 9,
                BM = 1,
                ArmoredVehicle = 0.5,
                Lambo = 0.1,
                Vette = 0.08
            }
        }
    },
    CRATE_ORDER = { "Street", "Elite", "Mythic" },
    DEFAULT_CRATE = "Mythic"
}
function Table.Crate( Key )
    local DEFAULT_CRATE = Table.CRATES[ Key ] and Key or Table.DEFAULT_CRATE
    local Entry2
    local Entry = Table.CRATES[ Key ]
    Entry2 = if Entry then Entry else Table.CRATES[ Table.DEFAULT_CRATE ]
    return DEFAULT_CRATE, Entry2
end

local function NoMythic()
    local Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) == true and true or false
    return Flag
end

function Table.Released( Key )
    local Entry = Table.Cars[ Key ]

    if not Entry then
        return false
    end

    local Flag

    if Entry.Release == nil then
        Flag = true
    elseif game:GetService( "ReplicatedStorage" ):GetAttribute( Entry.Release ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function BaseWeight( Argument1, WeightName )
    local Weights2
    local Weights = Argument1.Weights

    if Weights then
        Weights2 = Argument1.Weights[ WeightName ]
    else
        Weights2 = Weights
    end
    if Weights2 == nil then
        Weights2 = Table.Cars[ WeightName ].Weight
    end

    return Weights2
end

local function RawWeight( Argument1, WeightName )
    if not Table.Released( WeightName ) then
        return 0
    end

    local Weights2
    local _, Crate2 = Table.Crate( Argument1 )
    local Weights = Crate2.Weights

    if Weights then
        Weights2 = Crate2.Weights[ WeightName ]
    else
        Weights2 = Weights
    end
    if Weights2 == nil then
        Weights2 = Table.Cars[ WeightName ].Weight
    end

    local Value1
    local Cars = Table.Cars
    Value1 = nil

    for Key, Value in Cars, nil, nil do
        if Value.From == WeightName and not Table.Released( Key ) then
            local Weights4
            local Weights3 = Crate2.Weights

            if Weights3 then
                Weights4 = Crate2.Weights[ Key ]
            else
                Weights4 = Weights3
            end
            if Weights4 == nil then
                Weights4 = Table.Cars[ Key ].Weight
            end

            Weights2 = Weights2 + Weights4
        end
    end

    return Weights2
end

local function WeightOf( Argument1, WeightName )
    local Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) == true and true or false

    if not Flag or not Table.Cars[ WeightName ] or Table.Cars[ WeightName ].Rarity ~= "mythical" then
        return ( RawWeight( Argument1, WeightName ) )
    end
    return 0
end

function Table.Pool()
    local Value1
    local TableInner = { }
    local Cars = Table.Cars
    Value1 = nil

    for Value in Cars, nil, nil do
        if Table.Released( Value ) then
            table.insert( TableInner, Value )
        end
    end

    table.sort( TableInner )
    return TableInner
end
Table.DEFAULT_COST = 300000
Table.Extra = {
    ChallengerBlack = { Name = "Challenger Black", Rarity = "legendary" },
    Scooter = { Name = "Scooter", Rarity = "common" }
}
function Table.Info( Key )
    local Entry2
    local Entry = Table.Cars[ Key ]
    Entry2 = if Entry then Entry else Table.Extra[ Key ]

    if not Entry2 then
        return nil
    end

    local Entry4
    local Entry3 = Table.Rarities[ Entry2.Rarity ]
    Entry4 = if Entry3 then Entry3 else Table.Rarities.common
    return Entry2, Entry4
end
function Table.List( Argument1 )
    local Value1, Number2
    local Cars = Table.Cars
    Value1 = nil
    Number2 = 0

    for Value in Cars, nil, nil do
        Number2 = Number2 + RawWeight( Argument1, Value )
    end

    local FORCE2
    local TableInner = { }
    local FORCE = Table.FORCE

    if FORCE then
        local Entry = Table.Cars[ Table.FORCE ]

        if Entry then
            FORCE2 = Table.FORCE
        else
            FORCE2 = Entry
        end
    else
        FORCE2 = FORCE
    end

    local Value2
    local Cars2 = Table.Cars
    Value2 = nil

    for Key, Value3 in Cars2, nil, nil do
        if not Table.Released( Key ) then
            if not FORCE2 or Key ~= FORCE2 then
                continue
            end
        end

        local Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) == true and true or false

        if Flag and Value3.Rarity == "mythical" then
            if not FORCE2 or Key ~= FORCE2 then
                continue
            end
        end

        local Entry3
        local Entry2 = Table.Rarities[ Value3.Rarity ]
        Entry3 = if Entry2 then Entry2 else Table.Rarities.common
        local Number

        if FORCE2 then
            if Key == FORCE2 then
                Number = 100
            else
                Number = 0
            end
        else
            Number = RawWeight( Argument1, Key ) / Number2 * 100
        end

        table.insert( TableInner, {
            Key = Key,
            Name = Value3.Name,
            Rarity = Value3.Rarity,
            Color = Entry3.Color,
            Order = Entry3.Order,
            Chance = Number
        } )
    end

    table.sort( TableInner, function( Argument1, Argument2 )
        if math.abs( Argument1.Chance - Argument2.Chance ) > 1e-09 then
            local Flag = Argument1.Chance < Argument2.Chance and true or false
            return Flag
        end
        if Argument1.Order == Argument2.Order then
            local Flag3 = Argument1.Name < Argument2.Name and true or false
            return Flag3
        end
        local Flag2
        local Order = Argument1.Order
        Flag2 = Argument2.Order < Order and true or false
        return Flag2
    end )
    return TableInner
end
function Table.Roll( Argument1, Argument2 )
    if Table.FORCE and Table.Cars[ Table.FORCE ] then
        return Table.FORCE
    end

    local Value1, Number
    local Cars = Table.Cars
    Value1 = nil
    Number = 0

    for Value in Cars, nil, nil do
        local Flag2 = game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) == true and true or false
        local Number3

        if not Flag2 or not Table.Cars[ Value ] or Table.Cars[ Value ].Rarity ~= "mythical" then
            Number3 = RawWeight( Argument2, Value )
        else
            Number3 = 0
        end

        Number = Number + Number3
    end

    local Random

    if not Argument1 or not Argument1:NextNumber( ) then
        Random = math.random( )
    else
        Random = Argument1:NextNumber( )
    end

    local Value2
    local NextNumber = Random * Number
    local TableInner = { }
    local Cars2 = Table.Cars
    Value2 = nil

    for Value3 in Cars2, nil, nil do
        table.insert( TableInner, Value3 )
    end

    local Value4, Value6
    table.sort( TableInner )
    Value4 = nil
    Value6 = nil

    for Key, Value5 in TableInner, nil, nil do
        local Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) == true and true or false
        local Number2

        if not Flag or not Table.Cars[ Value5 ] or Table.Cars[ Value5 ].Rarity ~= "mythical" then
            Number2 = RawWeight( Argument2, Value5 )
        else
            Number2 = 0
        end
        if Number2 > 0 then
            local NextNumber2 = NextNumber - Number2

            if NextNumber2 <= 0 then
                return Value5
            end
            Value6 = Value5
            NextNumber = NextNumber2
        end
    end

    local Entry = if Value6 then Value6 else TableInner[ #TableInner ]
    return Entry
end
return Table
