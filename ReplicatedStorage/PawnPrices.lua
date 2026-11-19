-- ReplicatedStorage.PawnPrices
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ExtraItems = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ExtraItems" ) )
local Table = {
    WEAPONS = {
        G15 = 500,
        M9 = 500,
        SawedOff = 750,
        Uzi = 1500,
        MP5 = 7500,
        AK = 10000,
        M4 = 30000,
        SPAS12 = 50000,
        M60 = 80000,
        DRAGON = 500000,
        RPG = 750000,
        AWP = 1500000,
        Eagle = 2000000,
        RiotShield = 30000000
    },
    MELEE_PRICE = 200,
    MELEE = { RiotShield = 30000000 },
    ITEMS = { Medkit = 500, EDrink = 1000, Kevlar = 2500, Bandage = 250 },
    VEHICLES = {
        CheapCar = 15000,
        [ "208" ] = 20000,
        Cayen = 50000,
        Challenger = 120000,
        BM = 200000,
        ArmoredVehicle = 1500000,
        Lambo = 5000000,
        Vette = 7500000
    },
    WEAR_LOSS = 0.75,
    STEP = 10,
    MYTHIC_ONLY = true,
    MYTHIC = {
        DRAGON = 2500000,
        RPG = 5000000,
        AWP = 10000000,
        Eagle = 20000000,
        RiotShield = 100000000
    }
}
function Table.Price( Object )
    if not Object or not Object:IsA( "Tool" ) then
        return nil
    end
    if Object:GetAttribute( "Unbreakable" ) or Object:GetAttribute( "AdminTest" ) or Object:GetAttribute( "TestKit" ) then
        return nil
    end
    if Object:GetAttribute( "BetaLent" ) then
        return nil
    end

    local Get = ExtraItems.Get( Object:GetAttribute( "Item" ) )

    if Get and type( Get.Price ) == "number" and Get.Price > 0 then
        local Max3

        if Get.SellStack == true then
            local Max = math.max( 1, ( math.floor( tonumber( Object:GetAttribute( "Count" ) ) or 1 ) ) )

            if Max then
                Max3 = Max
            else
                Max3 = 1
            end
        else
            Max3 = 1
        end

        local Floor
        local Number = tonumber( Object:GetAttribute( "Kg" ) )
        local Number2 = tonumber( Get.KgRef )

        if not Number or not Number2 or not ( Number2 > 0 ) then
            Floor = math.floor( Get.Price )
        else
            local Max2 = math.max( 1, ( math.floor( Get.Price * Number / Number2 + 0.5 ) ) )

            if Max2 then
                Floor = Max2
            else
                Floor = math.floor( Get.Price )
            end
        end

        return Floor * Max3
    end
    if Table.MYTHIC_ONLY then
        if Object:GetAttribute( "Vehicle" ) or Object:GetAttribute( "Item" ) then
            return nil
        end

        local Melee
        local Weapon = Object:GetAttribute( "Weapon" )

        if Weapon then
            Melee = Weapon
        else
            Melee = Object:GetAttribute( "Melee" )
        end

        local Entry2

        if Melee then
            local Entry = Table.MYTHIC[ Melee ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = nil
            end
        else
            Entry2 = nil
        end

        return Entry2
    end
    local Vehicle = Object:GetAttribute( "Vehicle" )

    if Vehicle then
        if Object:GetAttribute( "CarId" ) then
            return Table.VEHICLES[ Vehicle ]
        end
        return nil
    else
        local Item = Object:GetAttribute( "Item" )

        if Item then
            return Table.ITEMS[ Item ]
        end

        local Melee2 = Object:GetAttribute( "Melee" )

        if Melee2 then
            local Entry4
            local Entry3 = Table.MELEE[ Melee2 ]
            Entry4 = if Entry3 then Entry3 else Table.MELEE_PRICE
            return Entry4
        end
        local Weapon3
        local Weapon2 = Object:GetAttribute( "Weapon" )
        Weapon3 = if Weapon2 then Table.WEAPONS[ Weapon2 ] else Weapon2

        if not Weapon3 then
            return nil
        end

        local Number4
        local Number3 = tonumber( Object:GetAttribute( "MaxDurability" ) )

        if Object:GetAttribute( "Broken" ) then
            Number4 = 1
        elseif not Number3 or not ( Number3 > 0 ) then
            Number4 = 0
        else
            Number4 = ( Number3 - math.clamp( tonumber( Object:GetAttribute( "Durability" ) ) or Number3, 0, Number3 ) ) / Number3
        end

        local STEP = Table.STEP
        return ( math.max( STEP, math.floor( Weapon3 * ( 1 - Table.WEAR_LOSS * Number4 ) / STEP + 0.5 ) * STEP ) )
    end
end
Table.CASE_FACTOR = {
    common = 0.03,
    uncommon = 0.06,
    rare = 0.15,
    epic = 0.4,
    legendary = 1,
    mythical = 3
}
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )

local function Round( Argument1 )
    local STEP = Table.STEP
    return ( math.max( STEP, math.floor( Argument1 / STEP + 0.5 ) * STEP ) )
end

function Table.UnlockPrice( PriceName )
    if Table.MYTHIC_ONLY then
        return nil
    end

    local Value1
    local AttachmentCases = require( ReplicatedStorage:WaitForChild( "AttachmentCases" ) )
    local CASES = AttachmentCases.CASES
    Value1 = nil

    for Key, Value in CASES, nil, nil do
        if Value[ PriceName ] then
            local Max2
            local Entry = AttachmentCases.INFO[ Key ]
            local Entry2 = Table.CASE_FACTOR[ AttachmentCases.Tier( PriceName ) ]

            if not Entry or not Entry.Cost or not Entry2 then
                Max2 = nil
            else
                local Cost = Entry.Cost * Entry2
                local STEP = Table.STEP
                local Max = math.max( STEP, math.floor( Cost / STEP + 0.5 ) * STEP )

                if Max then
                    Max2 = Max
                else
                    Max2 = nil
                end
            end

            return Max2
        end
    end

    return nil
end
function Table.CarItemPrice( PriceName )
    if Table.MYTHIC_ONLY then
        return nil
    end

    local CarCustom = require( ReplicatedStorage:WaitForChild( "CarCustom" ) )
    local Entry = CarCustom.ITEMS[ PriceName ]

    if not Entry or Entry.Price or Entry.PerCar then
        return nil
    end

    local Entry2 = Table.CASE_FACTOR[ Entry.Rarity ]

    if not Entry2 then
        return nil
    end
    if Entry.Skins then
        local Value1
        local AttachmentCases = require( ReplicatedStorage:WaitForChild( "AttachmentCases" ) )
        local CRATES = CarCustom.CRATES
        Value1 = nil

        for Key, Value in CRATES, nil, nil do
            local FromCase2
            local FromCase = Value.FromCase
            FromCase2 = if FromCase then AttachmentCases.CASES[ Value.FromCase ] else FromCase
            local Skins = FromCase2 and Entry.Skins or { }
            local Value2 = nil

            for Key2, Value3 in Skins, nil, nil do
                if FromCase2[ Value3 ] then
                    local Cost = Value.Cost * Entry2
                    local STEP = Table.STEP
                    return ( math.max( STEP, math.floor( Cost / STEP + 0.5 ) * STEP ) )
                end
            end
        end
    end
    if Entry.NoCrate then
        return nil
    end

    local Value4
    local CRATES2 = CarCustom.CRATES
    Value4 = nil

    for Key3, Value5 in CRATES2, nil, nil do
        if table.find( Value5.Categories, Entry.Category ) then
            local Cost2 = Value5.Cost * Entry2
            local STEP2 = Table.STEP
            return ( math.max( STEP2, math.floor( Cost2 / STEP2 + 0.5 ) * STEP2 ) )
        end
    end

    return nil
end
return Table
