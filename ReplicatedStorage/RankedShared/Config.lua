-- ReplicatedStorage.RankedShared.Config
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = {
    Modes = {
        [ "1v1" ] = {
            size = 1,
            label = "1V1",
            maps = {
                "MiniMap-Hangar-1v1-2v2",
                "MiniMap-TownHall-1v1-2v2",
                "MiniMap-Tunnel-1v1-2v2",
                "MiniMap-Port-1v1-2v2",
                "MiniMap-Station-5v5-2v2"
            }
        },
        [ "2v2" ] = {
            size = 2,
            label = "2V2",
            maps = {
                "MiniMap-Hangar-1v1-2v2",
                "MiniMap-TownHall-1v1-2v2",
                "MiniMap-Tunnel-1v1-2v2",
                "MiniMap-Port-1v1-2v2",
                "MiniMap-Station-5v5-2v2",
                "MiniMap-Alleyways-2v2"
            }
        },
        [ "5v5" ] = {
            size = 5,
            label = "5V5",
            clan = true,
            maps = {
                "MiniMap-Alleyways-5v5",
                "MiniMap-Station-5v5-2v2",
                "MiniMap-Roof-5v5"
            }
        }
    },
    ModeOrder = { "1v1", "2v2", "5v5" },
    MapLabel = function( Argument1 )
        return tostring( Argument1 ):gsub( "^MiniMap%-", "" ):gsub( "%-%d+v%d+.*$", "" ):gsub( "(%l)(%u)", "%1 %2" ):upper( )
    end,
    WinRounds = 5,
    BanChoices = 3,
    BanTime = 15,
    ArrivalTimeout = 60,
    ReadyTimeout = 45,
    RoundCountdown = 3,
    PickTime = 15,
    RoundEndPause = 4,
    RoundTime = 420,
    Zone = {
        Enabled = true,
        Start = { [ "1v1" ] = 0, [ "2v2" ] = 0, [ "5v5" ] = 0 },
        Warn = 0,
        Shrink = 90,
        FinalRadius = 15,
        DpsStart = 5,
        DpsEnd = 20,
        Tick = 0.5,
        Margin = 1.25,
        Pad = 12,
        WallHeight = 60
    },
    SpawnShield = 0.5,
    SwapSidesAfter = 4,
    AfkSeconds = 45,
    ResultsTime = 15,
    RejoinGrace = 60,
    DownedOut = false,
    MaxDowns = 3,
    Items = { Medkit = 2, EDrink = 5, Kevlar = 1 },
    ItemSlots = { Medkit = 3, EDrink = 4, Kevlar = 5 },
    Leech = true,
    BannedWeapons = { RPG = true },
    RankedWeapons = { "MP5", "AK", "M4", "G36", "M60", "SPAS12", "MK14" },
    RankedWeaponSet = { }
}
local RankedWeapons = Table.RankedWeapons
Value1 = nil

for Key, Value in RankedWeapons, nil, nil do
    Table.RankedWeaponSet[ Value ] = Key
end

Table.RankedWeaponClass = {
    MP5 = "SMG",
    AK = "ASSAULT RIFLE",
    M4 = "ASSAULT RIFLE",
    M60 = "LIGHT MACHINE GUN",
    SPAS12 = "SHOTGUN",
    MK14 = "MARKSMAN RIFLE",
    G36 = "ASSAULT RIFLE"
}
Table.RankedWeaponLength = {
    MP5 = 2.34,
    AK = 3.46,
    M4 = 2.94,
    M60 = 4.05,
    SPAS12 = 3.64,
    MK14 = 3.5,
    G36 = 2.81
}
Table.MapPhotos = {
    [ "MiniMap-Station-5v5-2v2" ] = "rbxassetid://106919495916866",
    [ "MiniMap-Alleyways-5v5" ] = "rbxassetid://133005178241729",
    [ "MiniMap-Alleyways-2v2" ] = "rbxassetid://99577640374072",
    [ "MiniMap-TownHall-1v1-2v2" ] = "rbxassetid://121015246681386",
    [ "MiniMap-Hangar-1v1-2v2" ] = "rbxassetid://114720827121577",
    [ "MiniMap-Roof-5v5" ] = "rbxassetid://137989462707045",
    [ "MiniMap-Tunnel-1v1-2v2" ] = "rbxassetid://96777438597425",
    [ "MiniMap-Port-1v1-2v2" ] = "rbxassetid://130762319452780"
}
Table.Access = { unrankedWins = 10, minKills = 150 }
Table.Access.maxPing = 0.25
Table.Queue = {
    window = 100,
    widen = 50,
    windowMax = 600,
    every = 2,
    ticketTTL = 120,
    crossAfter = 15
}
Table.Queue.geoMax = 1
Table.Unranked = { queue = { window = 300, widen = 200, windowMax = 5000 } }
Table.ClanQueue = { global = true, window = 300, widen = 400, windowMax = 5000 }
Table.ClanReward = { minGames = 5 }
Table.ClanK = 60
Table.ClanBoardMinGames = 10
Table.ClanJoinDelay = 86400
Table.XP = {
    ranked = { win = 30000, loss = 12000 },
    unranked = { win = 15000, loss = 6000 }
}
Table.PartyMax = 5
Table.InviteTime = 10
local Regions = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Regions" ) )
function Table.RegionOf( Argument1 )
    return Regions.Of( Argument1 )
end
Table.Regions = Regions.List
Table.StartElo = 1000
Table.Placement = { matches = 4, maxElo = 1800, k = 150 }
Table.Placement.floorByWins = { [ 2 ] = 600, [ 3 ] = 800, [ 4 ] = 1200 }
local Placement = Table.Placement
local CeilByWins = { [ 0 ] = 799 }
CeilByWins[ 1 ] = 1199
Placement.ceilByWins = CeilByWins
Table.Perf = { placement = 0.5, normal = 0 }
Table.PartyMaxSpread = 600
Table.CasualMMR = { k = 40, kNew = 80, newGames = 10 }
Table.K = 40
Table.MinChange = 4
Table.RankPoints = {
    k = 40,
    kNew = 80,
    newGames = 10,
    mu = 1160,
    sigma = 200,
    sigmaMin = 120,
    distMinPlayers = 200,
    dist = {
        [ "1v1" ] = { mu = 1167, sigma = 212 },
        [ "2v2" ] = { mu = 1154, sigma = 188 }
    },
    anchors = {
        { -2.89, 0 },
        { 0, 1300 },
        { 0.67, 1800 },
        { 1.4, 2400 },
        { 1.96, 3000 },
        { 2.33, 3400 }
    },
    gapDiv = 8,
    winBase = 22,
    winMin = 10,
    winMax = 27,
    lossBase = 18,
    lossMin = 5,
    lossMax = 30,
    lossRatio = 0.6,
    targetMax = 3400,
    placementJumpMax = 150,
    upsetFrom = 0.5,
    upsetFull = 0.75,
    upsetLoss = 27,
    underdogFrom = 0.5,
    underdogCut = 0.6,
    placementBelow = 100,
    distSeason = "2026-11"
}
Table.Compensation = {
    enabled = true,
    delay = 86400,
    window = 604800,
    late = 600,
    keep = 300,
    every = 180,
    budget = 120,
    gap = 1.5,
    tries = 20,
    seenTtl = 21600,
    noteDelay = 15
}
Table.DivisionSize = 200
Table.Ranks = {
    { id = "Bronze", name = "Bronze", min = 0 },
    { id = "Silver", name = "Silver", min = 600 },
    { id = "Gold", name = "Gold", min = 1200 },
    { id = "Diamond", name = "Diamond", min = 1800 },
    { id = "Ruby", name = "Ruby", min = 2400 },
    { id = "Champion", name = "Champion", min = 3000 }
}
Table.Top = {
    { id = "Top1", name = "Top 1", places = 1 },
    { id = "Top100", name = "Top 100", places = 100 }
}
Table.TopMinGames = 10
Table.TopMinElo = 3400
Table.RewardSeasons = 3
Table.FirstSeason = "2026-11"
Table.SafeAfterPromotion = true
Table.Abandon = { locks = { 0, 300, 900 }, window = 43200 }
Table.DodgeLock = 0
Table.LockAmnestyBefore = 1794340800
Table.SeasonDay = 25
Table.SeasonHourUTC = 23
Table.SeasonOneEnd = os.time( { year = 2026, month = 12, day = 25, hour = 23, min = 0, sec = 0 } )
function Table.SeasonAt( Argument1 )
    local Time

    if Argument1 then
        Time = Argument1
    else
        Time = os.time( )
    end

    local Time2 = os.time( { year = 2026, month = 11, day = 1, hour = 0, min = 0, sec = 0 } )

    if Time < Time2 then
        local Year2, Month2
        local Date = os.date( "!*t", Time )
        local Year = Date.year
        local Month = Date.month + 1

        if Month > 12 then
            Year2 = Year + 1
            Month2 = 1
        else
            Year2 = Year
            Month2 = Month
        end

        return {
            id = string.format( "%04d-%02d", Date.year, Date.month ),
            startsAt = os.time( {
                year = Date.year,
                month = Date.month,
                day = 1,
                hour = 0,
                min = 0,
                sec = 0
            } ),
            endsAt = os.time( { year = Year2, month = Month2, day = 1, hour = 0, min = 0, sec = 0 } )
        }
    end
    if Time < Table.SeasonOneEnd then
        return { id = "2026-11", startsAt = Time2, endsAt = Table.SeasonOneEnd }
    end

    local Year4, Month5
    local Date2 = os.date( "!*t", Time )
    local Year3 = Date2.year
    local Month3 = Date2.month

    local function Edge( Argument1, Argument2 )
        return os.time( {
            year = Argument1,
            month = Argument2,
            day = Table.SeasonDay,
            hour = Table.SeasonHourUTC,
            min = 0,
            sec = 0
        } )
    end

    if Time < os.time( {
        year = Year3,
        month = Month3,
        day = Table.SeasonDay,
        hour = Table.SeasonHourUTC,
        min = 0,
        sec = 0
    } ) then
        local Month4 = Month3 - 1

        if Month4 < 1 then
            Year4 = Year3 - 1
            Month5 = 12
        else
            Year4 = Year3
            Month5 = Month4
        end
    else
        Year4 = Year3
        Month5 = Month3
    end

    local Year5, Month7
    local Month6 = Month5 + 1

    if Month6 > 12 then
        Year5 = Year4 + 1
        Month7 = 1
    else
        Year5 = Year4
        Month7 = Month6
    end

    return {
        id = string.format( "%04d-%02d", Year4, Month5 ),
        startsAt = os.time( {
            year = Year4,
            month = Month5,
            day = Table.SeasonDay,
            hour = Table.SeasonHourUTC,
            min = 0,
            sec = 0
        } ),
        endsAt = os.time( {
            year = Year5,
            month = Month7,
            day = Table.SeasonDay,
            hour = Table.SeasonHourUTC,
            min = 0,
            sec = 0
        } )
    }
end
function Table.StoreName( Name )
    return "RankedData_" .. Name
end
function Table.BoardName( Text, Text2 )
    return "RankedElo_" .. Text .. "_" .. Text2
end
return Table
