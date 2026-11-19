-- ReplicatedStorage.Trains.TrainConfig
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    SpeedMin = 80,
    SpeedMax = 150,
    CarsMin = 2,
    CarsMax = 5,
    IntervalMin = 40,
    IntervalMax = 120,
    TestInterval = nil,
    Gap = 1,
    RollSound = "rbxassetid://78050665817581",
    HornSound = "rbxassetid://133834319697501",
    RollVolume = 0.08,
    HornVolume = 0.35,
    HornChance = 0.3333333333333333,
    SoundPreRoll = 1.5,
    SoundFadeOut = 3,
    RollOffMin = 15,
    RollOffMax = 300,
    HornRollOffMin = 40,
    HornRollOffMax = 600,
    ReverbWet = -14,
    ReverbDecay = 2,
    DopplerSound = 1000,
    PortalEast = -684.8,
    PortalWest = 518.2,
    Lanes = {
        {
            Name = "Voie1",
            Template = "l_train",
            Z = 766.42,
            Y = 70.71,
            Dir = -1
        },
        { Name = "Voie2", Template = "l_train2", Z = 747.1, Y = 70.71, Dir = 1 }
    }
}
function Table.Duration( Amount, Argument2, Argument3 )
    return ( Table.PortalWest - Table.PortalEast + Amount * Argument2 + ( Amount - 1 ) * Table.Gap ) / Argument3
end
return Table
