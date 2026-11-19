-- ReplicatedStorage.AirdropConfig
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    ENABLED = true,
    MIN_PLAYERS = 14,
    SPAWN_BLOCK_RADIUS = 150,
    INTERVAL = 3600,
    OFFSET = 1200,
    COOLDOWN_MIN = 2400,
    COOLDOWN_MAX = 4800,
    FALL_TIME = 420,
    FINAL_COUNT = 10,
    CLAIM_SOUNDS = {
        { Id = "rbxassetid://140635119444127", Volume = 1.6 },
        { Id = "rbxassetid://133743196377753", Volume = 1.2 }
    },
    CLAIM_SOUND_RANGE = 350,
    CLAIM_TIME = 5,
    HEIGHT = 450,
    ALERT_TIME = 9,
    ALERT_BANNER = true,
    SIREN = "rbxassetid://9081625499",
    SIREN_TIME = 7,
    ICON = "rbxassetid://89144961641241",
    COLOR = Color3.fromRGB( 225, 45, 60 ),
    PLANE_SPEED = 150,
    PLANE_RUN = 1800,
    PLANE_MIN_APPROACH = 4,
    LOOT = {
        { Key = "CashBag500K", T = "I", Chance = 44.92 },
        { Key = "CashBag1M", T = "I", Chance = 29.24 },
        { Key = "CashBag3M", T = "I", Chance = 15.75 },
        { Key = "CashBag5M", T = "I", Chance = 8.99 },
        { Key = "DRAGON", T = "W", Chance = 0.5 },
        { Key = "RPG", T = "W", Chance = 0.4 },
        { Key = "AWP", T = "W", Chance = 0.2 }
    }
}
function Table.Roll( Argument1 )
    local Value1, Number
    local LOOT = Table.LOOT
    Value1 = nil
    Number = 0

    for Key, Value in LOOT, nil, nil do
        Number = Number + Value.Chance
    end

    local Random

    if not Argument1 or not Argument1:NextNumber( ) then
        Random = math.random( )
    else
        Random = Argument1:NextNumber( )
    end

    local Value2
    local NextNumber = Random * Number
    local LOOT2 = Table.LOOT
    Value2 = nil

    for Key2, Value3 in LOOT2, nil, nil do
        local NextNumber2 = NextNumber - Value3.Chance

        if NextNumber2 <= 0 then
            return Value3
        end
        NextNumber = NextNumber2
    end

    return Table.LOOT[ 1 ]
end
return Table
