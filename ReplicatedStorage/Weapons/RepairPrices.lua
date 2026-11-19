-- ReplicatedStorage.Weapons.RepairPrices
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    PRICE = {
        M9 = 11000,
        SawedOff = 15000,
        Uzi = 20000,
        MP5 = 27000,
        AK = 37000,
        M4 = 50000,
        SPAS12 = 68000,
        M60 = 91000,
        MK14 = 123000,
        G36 = 123000,
        DRAGON = 165000,
        RPG = 250000,
        AWP = 433000,
        Eagle = 548000
    },
    STEP = 100
}
function Table.Cost( Self )
    local Entry = Table.PRICE[ Self:GetAttribute( "Weapon" ) ]
    local Number = tonumber( Self:GetAttribute( "MaxDurability" ) )

    if not Entry or not Number or Number <= 0 then
        return nil
    end
    if Self:GetAttribute( "Broken" ) then
        return Entry
    end

    local Clamp = math.clamp( tonumber( Self:GetAttribute( "Durability" ) ) or Number, 0, Number )

    if Number <= Clamp then
        return nil
    end
    if Clamp <= 0 then
        return Entry
    end
    local STEP = Table.STEP
    return ( math.max( STEP, math.ceil( Entry * ( Number - Clamp ) / Number / STEP - 1e-09 ) * STEP ) )
end
Table.VEHICLE = 2000
Table.VEHICLE_STEP = 10
Table.FREE_VEHICLE = { CheapCar = true }
function Table.VehicleCost( Text, Text2, CostName )
    local Number = tonumber( Text2 )

    if not Number or Number <= 0 then
        return nil
    end

    local Clamp = math.clamp( tonumber( Text ) or Number, 0, Number )

    if Number <= Clamp then
        return nil
    end
    if CostName and Table.FREE_VEHICLE[ CostName ] then
        return 0
    end
    if Clamp <= 0 then
        return Table.VEHICLE
    end
    local VEHICLE_STEP = Table.VEHICLE_STEP
    return ( math.max( VEHICLE_STEP, math.ceil( Table.VEHICLE * ( Number - Clamp ) / Number / VEHICLE_STEP - 1e-09 ) * VEHICLE_STEP ) )
end
return Table
