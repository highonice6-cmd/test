-- ReplicatedStorage.BadgeCatalog
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local BETA_GAMEPASS
local FromRGB = Color3.fromRGB( 70, 200, 90 )
local FromRGB2 = Color3.fromRGB( 70, 150, 255 )
local FromRGB3 = Color3.fromRGB( 230, 50, 50 )
local FromRGB4 = Color3.fromRGB( 25, 25, 28 )
local FromRGB5 = Color3.fromRGB( 255, 195, 50 )
Color3.fromRGB( 120, 230, 255 )
local FromRGB6 = Color3.fromRGB( 176, 77, 255 )
local FromRGB7 = Color3.fromRGB( 255, 138, 26 )
local FromRGB8 = Color3.fromRGB( 205, 127, 50 )
local FromRGB9 = Color3.fromRGB( 200, 205, 215 )
local Table = {
    MODO_USERS = { },
    CC_USERS = {
        3643605179,
        2964180234,
        220308993,
        1049549371,
        5765019,
        2436187208,
        1683248207,
        9547065055,
        6155427581,
        8304311584,
        10390113127
    },
    VIP_GAMEPASS = nil,
    PVPPLUS_GAMEPASS = nil
}
local Success, Result = pcall( function()
    return require( script.Parent:WaitForChild( "Weapons" ):WaitForChild( "ModCatalog" ) )
end )

if not Success or not Result or not Result.PackPasses then
    BETA_GAMEPASS = nil
else
    local Beta = Result.PackPasses.Beta

    if Beta then
        BETA_GAMEPASS = Beta
    else
        BETA_GAMEPASS = nil
    end
end

local Value1
Table.BETA_GAMEPASS = BETA_GAMEPASS
Table.KD_MIN_KILLS = 10
Table.MONEY_MIN = 1000000
Table.MONEY_TIERS = { Table.MONEY_MIN, 10000000, 100000000 }
Table.LEVEL_LOGOS = {
    119987364504260,
    111511747530360,
    100890614658522,
    132275746352488,
    128593576193023,
    93759974904248,
    126619194717698,
    89745039989285,
    111217056043688,
    126033985402889,
    83907010775996,
    93326622441900,
    127766708808831,
    106777761254099,
    139107177025183,
    75836885670310,
    106099892899769,
    92168230236235,
    88100241238234,
    125719960258612,
    80020315524952,
    90119982195047,
    120803573607228,
    108838015022887,
    77060524809210,
    101686850251681,
    82470792607469,
    84215163580453,
    132140811151242,
    114655679972445,
    131691265429228,
    134702663712630,
    109302111700390,
    87920008228345,
    103935635185604,
    128249268735233,
    112931007893416,
    88516110362773,
    123711669294947,
    113680186338358,
    98730022143665,
    84465560137424,
    104073109076723,
    111003391229241,
    128467880257710,
    138887180314051,
    133940957881647,
    94820586180829,
    109342877328914,
    74015604672335,
    138867287119543,
    120697752664634,
    82397892046156,
    128677009693774,
    119058937270847,
    137104899662242,
    96786447147246,
    96994096786308,
    102913502139268,
    139029014187187,
    88791923711554,
    138045575474365,
    70938059692263,
    127617609848892,
    112554033509421,
    79580403007586,
    100561995541791,
    78712176168740,
    92524218346599,
    75737063722323,
    111985488616567,
    71798750686290,
    83353512946097,
    84726782523373,
    132961456503595,
    119826183648221,
    109164977123106,
    94267048784500,
    130751172162565,
    75871883361426,
    139989686851200,
    117280893007063,
    94760451413497,
    139456708111289,
    134819464700329,
    111348107175159,
    123769638822667,
    94355933855884,
    95222068206660,
    82575740316625,
    91697230326543,
    119942707078550,
    116069716334115,
    95811113457361,
    137711035615348,
    106703148982872,
    75077124506216,
    121473533864127,
    119637605652810,
    91772487790693
}
local Table2 = {
    [ 0 ] = Color3.fromRGB( 192, 202, 214 ),
    Color3.fromRGB( 54, 224, 122 ),
    Color3.fromRGB( 47, 224, 208 ),
    Color3.fromRGB( 61, 132, 255 ),
    Color3.fromRGB( 122, 120, 255 ),
    Color3.fromRGB( 176, 77, 255 ),
    Color3.fromRGB( 255, 79, 192 ),
    Color3.fromRGB( 255, 48, 48 ),
    Color3.fromRGB( 255, 138, 26 ),
    Color3.fromRGB( 207, 234, 255 ),
    Color3.fromRGB( 255, 178, 46 )
}
local Table3 = {
    [ 0 ] = { r = 0.207, span = 0.461, dy = 0.004 },
    { r = 0.207, span = 0.461, dy = 0.004 },
    { r = 0.207, span = 0.461, dy = 0.004 },
    { r = 0.22, span = 0.496, dy = 0.004 },
    { r = 0.22, span = 0.496, dy = 0.005 },
    { r = 0.228, span = 0.514, dy = -0.019 },
    { r = 0.233, span = 0.52, dy = -0.016 },
    { r = 0.27, span = 0.584, dy = -0.048 },
    { r = 0.273, span = 0.586, dy = -0.047 },
    { r = 0.31, span = 0.664, dy = -0.058 },
    { r = 0.335, span = 0.936, dy = -0.111 }
}
local Table4 = {
    [ 0 ] = Color3.fromRGB( 83, 79, 75 ),
    Color3.fromRGB( 34, 125, 60 ),
    Color3.fromRGB( 33, 131, 122 ),
    Color3.fromRGB( 40, 89, 151 ),
    Color3.fromRGB( 67, 62, 161 ),
    Color3.fromRGB( 121, 52, 170 ),
    Color3.fromRGB( 194, 58, 147 ),
    Color3.fromRGB( 192, 39, 43 ),
    Color3.fromRGB( 198, 115, 35 ),
    Color3.fromRGB( 137, 151, 160 ),
    Color3.fromRGB( 199, 146, 53 )
}
local Table5 = { }
local LEVEL_LOGOS = Table.LEVEL_LOGOS
Value1 = nil

for Key, Value in LEVEL_LOGOS, nil, nil do
    local Floor = math.floor( Key / 10 )
    Table5[ Key ] = {
        color = Table2[ Floor ],
        label = "Level " .. Key,
        logo = Value,
        fit = Table3[ Floor ],
        tint = Table4[ Floor ]
    }
end

local Value2
Table.Badges = {
    {
        id = "Level",
        name = "Level",
        icon = "🎖️",
        color = Table2[ 0 ],
        emblem = true,
        desc = "Player level (the emblem evolves every 10 levels)",
        tiers = Table5,
        rule = function( Argument1 )
            local Clamp2
            local Number = tonumber( Argument1.attr( "Level" ) )

            if Number then
                local Floor = math.floor( Number )
                local Clamp = math.clamp( Floor, 1, #Table5 )

                if Clamp then
                    Clamp2 = Clamp
                else
                    Clamp2 = nil
                end
            else
                Clamp2 = nil
            end

            return Clamp2
        end
    },
    {
        id = "Beta",
        logo = 96526580147762,
        name = "Beta",
        icon = "🧪",
        color = Color3.fromRGB( 80, 170, 255 ),
        emblem = true,
        fit = { r = 0.425, span = 0.922, dy = 0.012 },
        tint = Color3.fromRGB( 56, 90, 168 ),
        desc = "Beta Pack supporter",
        rule = function( Argument1 )
            local Pass2

            if Table.BETA_GAMEPASS then
                local Pass = Argument1.pass( Table.BETA_GAMEPASS )

                if Pass then
                    Pass2 = Pass
                else
                    Pass2 = nil
                end
            else
                Pass2 = nil
            end

            return Pass2
        end
    },
    {
        id = "VIP",
        logo = 120278049047343,
        name = "VIP",
        icon = "💎",
        color = FromRGB5,
        emblem = true,
        fit = { r = 0.334, span = 0.855, dy = -0.053 },
        tint = Color3.fromRGB( 170, 128, 36 ),
        desc = "VIP member",
        rule = function( Argument1 )
            local Flag

            if Argument1.attr( "VIP" ) == true then
                Flag = true
            elseif Table.VIP_GAMEPASS then
                local Pass = Argument1.pass( Table.VIP_GAMEPASS )

                if Pass then
                    Flag = Pass
                else
                    Flag = nil
                end
            else
                Flag = nil
            end

            return Flag
        end
    },
    {
        id = "KD",
        name = "K/D",
        icon = "⚔️",
        color = FromRGB,
        emblem = true,
        desc = "High K/D (the emblem rises with the K/D)",
        tiers = {
            {
                color = FromRGB,
                label = "K/D 0.5+",
                logo = 92135819877102,
                fit = { r = 0.215, span = 0.463, dy = -0.013 },
                tint = Color3.fromRGB( 44, 150, 82 )
            },
            {
                color = FromRGB2,
                label = "K/D 1.0+",
                logo = 80732605501955,
                fit = { r = 0.223, span = 0.555, dy = -0.057 },
                tint = Color3.fromRGB( 49, 93, 166 )
            },
            {
                color = FromRGB3,
                label = "K/D 1.5+",
                logo = 122882347486652,
                fit = { r = 0.235, span = 0.551, dy = -0.045 },
                tint = Color3.fromRGB( 176, 40, 48 )
            },
            {
                color = FromRGB4,
                label = "K/D 2.0+",
                logo = 100313605198369,
                fit = { r = 0.275, span = 0.604, dy = -0.03 },
                tint = Color3.fromRGB( 121, 124, 129 )
            },
            {
                color = FromRGB6,
                label = "K/D 2.5+",
                logo = 73848338964392,
                fit = { r = 0.318, span = 0.703, dy = -0.016 },
                tint = Color3.fromRGB( 136, 68, 190 )
            },
            {
                color = FromRGB5,
                label = "K/D 3.0+",
                logo = 130692089004402,
                fit = { r = 0.347, span = 0.877, dy = -0.011 },
                tint = Color3.fromRGB( 200, 147, 56 )
            }
        },
        rule = function( Argument1 )
            local Kills = Argument1.stats.Kills or 0
            local Deaths = Argument1.stats.Deaths or 0

            if Kills < Table.KD_MIN_KILLS then
                return nil
            end

            local Kills2 = Kills / math.max( Deaths, 1 )

            if Kills2 >= 3 then
                return 6
            end
            if Kills2 >= 2.5 then
                return 5
            end
            if Kills2 >= 2 then
                return 4
            end
            if Kills2 >= 1.5 then
                return 3
            end
            if Kills2 >= 1 then
                return 2
            end
            if Kills2 >= 0.5 then
                return 1
            end
            return nil
        end
    },
    {
        id = "Money",
        name = "Millionaire",
        icon = "💰",
        color = FromRGB8,
        emblem = true,
        desc = "Money in the bank (1M, 10M, 100M)",
        tiers = {
            {
                color = FromRGB8,
                label = "$1M+",
                logo = 95358305940903,
                fit = { r = 0.255, span = 0.57, dy = 0.008 },
                tint = Color3.fromRGB( 185, 127, 78 )
            },
            {
                color = FromRGB9,
                label = "$10M+",
                logo = 106593331945523,
                fit = { r = 0.268, span = 0.641, dy = -0.008 },
                tint = Color3.fromRGB( 170, 176, 184 )
            },
            {
                color = FromRGB5,
                label = "$100M+",
                logo = 100561664142732,
                fit = { r = 0.285, span = 0.701, dy = -0.019 },
                tint = Color3.fromRGB( 207, 167, 71 )
            }
        },
        rule = function( Argument1 )
            local Number = tonumber( Argument1.attr( "Money" ) ) or 0
            local Count = #Table.MONEY_TIERS
            local I = Count

            for I = Count, 1, -1 do
                if Table.MONEY_TIERS[ I ] <= Number then
                    return I
                end
            end

            return nil
        end
    },
    {
        id = "Villa",
        logo = 279461710,
        name = "Villa",
        icon = "🏰",
        color = Color3.fromRGB( 200, 160, 255 ),
        desc = "Bought the villa",
        rule = function( Argument1 )
            local Flag = if Argument1.attr( "OwnsMansion" ) == true then true else nil
            return Flag
        end
    },
    {
        id = "Leader",
        name = "Leader",
        icon = "🏆",
        color = FromRGB,
        emblem = true,
        desc = "Top 100 for kills (all servers)",
        tiers = {
            {
                color = FromRGB,
                label = "Kills Top 100",
                logo = 93687621842932,
                fit = { r = 0.223, span = 0.51, dy = 0.005 },
                tint = Color3.fromRGB( 52, 167, 96 )
            },
            {
                color = FromRGB2,
                label = "Kills Top 50",
                logo = 107071817132583,
                fit = { r = 0.215, span = 0.514, dy = 0.005 },
                tint = Color3.fromRGB( 59, 135, 194 )
            },
            {
                color = FromRGB3,
                label = "Kills Top 10",
                logo = 107590712618700,
                fit = { r = 0.22, span = 0.527, dy = 0.006 },
                tint = Color3.fromRGB( 207, 44, 48 )
            },
            {
                color = FromRGB4,
                label = "Kills Top 3",
                logo = 95414832097490,
                fit = { r = 0.3, span = 0.613, dy = -0.027 },
                tint = Color3.fromRGB( 88, 90, 96 )
            },
            {
                color = FromRGB6,
                label = "Kills Top 2",
                logo = 115076435718192,
                fit = { r = 0.32, span = 0.664, dy = -0.034 },
                tint = Color3.fromRGB( 147, 75, 202 )
            },
            {
                color = FromRGB5,
                label = "Kills Top 1",
                logo = 118163488702773,
                fit = { r = 0.343, span = 0.936, dy = -0.072 },
                tint = Color3.fromRGB( 207, 151, 59 )
            }
        },
        rule = function( Argument1 )
            local Rank = Argument1.rank

            if not Rank then
                return nil
            end
            if Rank == 1 then
                return 6
            end
            if Rank == 2 then
                return 5
            end
            if Rank == 3 then
                return 4
            end
            if Rank <= 10 then
                return 3
            end
            if Rank <= 50 then
                return 2
            end
            if Rank <= 100 then
                return 1
            end
            return nil
        end
    },
    {
        id = "Crew",
        name = "Crew",
        icon = "👥",
        color = FromRGB3,
        emblem = true,
        desc = "Member of a top 10 crew (kills made in the crew, all servers)",
        tiers = {
            {
                color = FromRGB3,
                label = "Crew Top 10",
                logo = 92105260208546,
                fit = { r = 0.253, span = 0.707, dy = 0 },
                tint = Color3.fromRGB( 175, 42, 46 )
            },
            {
                color = FromRGB7,
                label = "Crew Top 5",
                logo = 95997356111725,
                fit = { r = 0.32, span = 0.746, dy = -0.03 },
                tint = Color3.fromRGB( 184, 105, 30 )
            },
            {
                color = FromRGB4,
                label = "Crew Top 3",
                logo = 133083641866187,
                fit = { r = 0.323, span = 0.781, dy = -0.023 },
                tint = Color3.fromRGB( 103, 106, 111 )
            },
            {
                color = FromRGB6,
                label = "Crew Top 2",
                logo = 114820576166171,
                fit = { r = 0.335, span = 0.816, dy = -0.022 },
                tint = Color3.fromRGB( 141, 68, 198 )
            },
            {
                color = FromRGB5,
                label = "Crew Top 1",
                logo = 114353199034574,
                fit = { r = 0.347, span = 0.934, dy = -0.072 },
                tint = Color3.fromRGB( 203, 145, 48 )
            }
        },
        rule = function( Argument1 )
            local CrewRank = Argument1.crewRank

            if not CrewRank then
                return nil
            end
            if CrewRank == 1 then
                return 5
            end
            if CrewRank == 2 then
                return 4
            end
            if CrewRank == 3 then
                return 3
            end
            if CrewRank <= 5 then
                return 2
            end
            if CrewRank <= 10 then
                return 1
            end
            return nil
        end
    },
    {
        id = "Clan",
        name = "Clan",
        icon = "🏰",
        color = FromRGB3,
        emblem = true,
        desc = "Member of a top 10 clan at the end of last season",
        tiers = {
            {
                color = FromRGB3,
                label = "Clans Top 10",
                logo = 75824245504731,
                fit = { r = 0.253, span = 0.707, dy = 0 },
                tint = Color3.fromRGB( 175, 42, 46 )
            },
            {
                color = FromRGB7,
                label = "Clans Top 5",
                logo = 93074737211852,
                fit = { r = 0.32, span = 0.746, dy = -0.03 },
                tint = Color3.fromRGB( 184, 105, 30 )
            },
            {
                color = FromRGB4,
                label = "Clans Top 3",
                logo = 85883359643777,
                fit = { r = 0.323, span = 0.781, dy = -0.023 },
                tint = Color3.fromRGB( 103, 106, 111 )
            },
            {
                color = FromRGB6,
                label = "Clans Top 2",
                logo = 80171167247487,
                fit = { r = 0.335, span = 0.816, dy = -0.022 },
                tint = Color3.fromRGB( 141, 68, 198 )
            },
            {
                color = FromRGB5,
                label = "Clans Top 1",
                logo = 77524434296701,
                fit = { r = 0.347, span = 0.934, dy = -0.072 },
                tint = Color3.fromRGB( 203, 145, 48 )
            }
        },
        rule = function( Argument1 )
            local Floor2
            local Number = tonumber( Argument1.attr( "ClanAward" ) )

            if not Number or not ( Number >= 1 ) or not ( Number <= 5 ) then
                Floor2 = nil
            else
                local Floor = math.floor( Number )

                if Floor then
                    Floor2 = Floor
                else
                    Floor2 = nil
                end
            end

            return Floor2
        end
    },
    {
        id = "Modo",
        logo = 7461510428,
        name = "Mod",
        icon = "🛡️",
        color = FromRGB,
        desc = "Moderator / game staff",
        rule = function( Argument1 )
            if Argument1.undercover then
                return nil
            end

            local Admin2
            local Admin = Argument1.admin

            if Admin then
                Admin2 = Admin
            elseif table.find( Table.MODO_USERS, Argument1.userId ) == nil then
                Admin2 = nil
            else
                Admin2 = true
            end

            return Admin2
        end
    },
    {
        id = "PvpPlus",
        logo = 3057073083,
        name = "PVP Plus",
        icon = "⭐",
        color = Color3.fromRGB( 255, 120, 40 ),
        desc = "Has Plus servers",
        rule = function( Argument1 )
            local Flag

            if Argument1.attr( "PvpPlus" ) == true then
                Flag = true
            elseif Table.PVPPLUS_GAMEPASS then
                local Pass = Argument1.pass( Table.PVPPLUS_GAMEPASS )

                if Pass then
                    Flag = Pass
                else
                    Flag = nil
                end
            else
                Flag = nil
            end

            return Flag
        end
    },
    {
        id = "CC",
        logo = 80710951675156,
        name = "Creator",
        icon = "CC",
        color = Color3.fromRGB( 255, 0, 0 ),
        emblem = true,
        fit = { r = 0.335, span = 0.832, dy = -0.009 },
        tint = Color3.fromRGB( 192, 52, 57 ),
        desc = "Content creator for the game",
        rule = function( Argument1 )
            local Flag = if table.find( Table.CC_USERS, Argument1.userId ) == nil then nil else true
            return Flag
        end
    }
}
Table.ORDER = {
    "Level",
    "Leader",
    "KD",
    "Clan",
    "Crew",
    "Money",
    "Villa",
    "Beta",
    "VIP",
    "PvpPlus",
    "CC",
    "Modo"
}
Table.ById = { }
local Badges = Table.Badges
Value2 = nil

for Key2, Value3 in Badges, nil, nil do
    local Order
    local Find = table.find( Table.ORDER, Value3.id )
    Order = if Find then Find else #Table.ORDER + Key2
    Value3.order = Order
    local ById = Table.ById
    ById[ Value3.id ] = Value3
end

function Table.LogoImage( Argument1, Argument2 )
    local Logo = Argument2 and Argument2.logo or Argument1.logo
    local Format = Logo and ( "rbxassetid://%d" ):format( Logo ) or nil
    return Format
end
Table.RAINBOW = ColorSequence.new( {
    ColorSequenceKeypoint.new( 0, Color3.fromRGB( 255, 70, 70 ) ),
    ColorSequenceKeypoint.new( 0.2, Color3.fromRGB( 255, 190, 60 ) ),
    ColorSequenceKeypoint.new( 0.4, Color3.fromRGB( 110, 230, 90 ) ),
    ColorSequenceKeypoint.new( 0.6, Color3.fromRGB( 70, 200, 255 ) ),
    ColorSequenceKeypoint.new( 0.8, Color3.fromRGB( 150, 90, 255 ) ),
    ColorSequenceKeypoint.new( 1, Color3.fromRGB( 255, 80, 200 ) )
} )
function Table.Parse( Name )
    local TableInner = { }

    for Value in string.gmatch( Name or "", "[^,]+" ) do
        local Match3
        local Match, Match2 = Value:match( "^([^:]+):?(%d*)$" )
        Match3 = if Match then Table.ById[ Match ] else Match

        if Match3 then
            local Tiers2
            local Tiers = Match3.tiers
            Tiers2 = if Tiers then Match3.tiers[ tonumber( Match2 ) or 1 ] else Tiers
            local Color
            local Table2 = { badge = Match3, tier = Tiers2 }
            Color = Tiers2 and Tiers2.color or Match3.color
            local Label
            Table2.color = Color
            Label = Tiers2 and Tiers2.label or Match3.name
            local Emblem
            Table2.label = Label
            Table2.image = Table.LogoImage( Match3, Tiers2 )
            Emblem = Match3.emblem == true and true or false
            local Fit
            Table2.emblem = Emblem
            Fit = Tiers2 and Tiers2.fit or Match3.fit
            local Tint
            Table2.fit = Fit
            Tint = Tiers2 and Tiers2.tint or Match3.tint
            Table2.tint = Tint
            table.insert( TableInner, Table2 )
        end
    end

    table.sort( TableInner, function( Argument1, Argument2 )
        local Flag = Argument1.badge.order < Argument2.badge.order and true or false
        return Flag
    end )
    return TableInner
end
return Table
