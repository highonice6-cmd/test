-- ReplicatedStorage.ClanShared
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value2
local RunService = game:GetService( "RunService" )
local Table = { LIVE = true }
function Table.TeamTest()
    if Table.LIVE == true then
        return false
    end
    if RunService:IsStudio( ) or not RunService:IsServer( ) then
        return false
    end

    local Flag
    local TeamTestUntil = script:GetAttribute( "TeamTestUntil" )

    if typeof( TeamTestUntil ) == "number" then
        if os.time( ) < TeamTestUntil then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end
function Table.Enabled()
    if Table.LIVE == true then
        return true
    end
    if Table.TeamTest( ) then
        return true
    end
    if not RunService:IsStudio( ) then
        return false
    end

    local Flag = workspace:GetAttribute( "ClansOff" ) ~= true and true or false
    return Flag
end
Table.MAX_MEMBERS = 10
Table.TAG_LEN = 3
Table.NAME_MIN = 3
Table.NAME_MAX = 20
Table.INVITE_DAYS = 7
Table.MAX_INVITES = 10
Table.INVITE_COOLDOWN = 30
Table.REJOIN_HOURS = 24
Table.PASS_CLAN = 2054267054
Table.PASS_PACK = 2053769106
Table.PRICE_CLAN = 499
Table.PRICE_PACK = 799
Table.SEASON = "2"
Table.SEASON_NAMES = { [ "1" ] = "BETA", [ "2" ] = "1" }
function Table.SeasonName( Argument1 )
    local Entry2
    local Entry = Table.SEASON_NAMES[ tostring( Argument1 ) ]
    Entry2 = if Entry then Entry else tostring( Argument1 )
    return Entry2
end
Table.FINAL_RANKS = {
    [ "Launch-1" ] = {
        e3874681d60c = 1,
        [ "586a1723f688" ] = 2,
        e1370f70e3a4 = 3,
        [ "9663582377d6" ] = 4,
        [ "5e02a6ef3abd" ] = 5,
        [ "8f8e4adb6a91" ] = 6,
        ee13fe6eab01 = 7,
        [ "78d69cede17a" ] = 8,
        a74d7a859436 = 9,
        [ "73925104fb7a" ] = 10
    }
}
function Table.TierOf( Amount )
    if type( Amount ) ~= "number" then
        return nil
    end
    if Amount == 1 then
        return 5
    end
    if Amount == 2 then
        return 4
    end
    if Amount == 3 then
        return 3
    end
    if Amount <= 5 then
        return 2
    end
    if Amount <= 10 then
        return 1
    end
    return nil
end
Table.TIER_LABELS = { "Top 10", "Top 5", "Top 3", "Top 2", "Top 1" }
Table.TIER_LOGOS = {
    75824245504731,
    93074737211852,
    85883359643777,
    80171167247487,
    77524434296701
}
function Table.CleanTag( Argument1 )
    if type( Argument1 ) ~= "string" then
        return nil
    end

    local Gsub = Argument1:upper( ):gsub( "%s", "" )

    if #Gsub ~= Table.TAG_LEN or not Gsub:match( "^[A-Z0-9]+$" ) then
        return nil
    end
    return Gsub
end
Table.TAG_BANNED = {
    "PTN",
    "SLP",
    "TMR",
    "VTF",
    "PDS",
    "PDF",
    "DIK",
    "DIC",
    "COK",
    "TIT",
    "JIZ",
    "XXX",
    "PRN",
    "SXY",
    "FAP",
    "HOE",
    "SLT",
    "CNT",
    "FUC",
    "FKU",
    "FCU",
    "NIG",
    "NGA",
    "NGR",
    "NAZ",
    "KKK",
    "KMS",
    "THC",
    "PTA",
    "PTO",
    "CRL",
    "KRL"
}
local Table2 = {
    [ "0" ] = { "O" },
    [ "1" ] = { "I", "L" },
    [ "3" ] = { "E" },
    [ "4" ] = { "A" },
    [ "5" ] = { "S" },
    [ "7" ] = { "T" },
    [ "8" ] = { "B" },
    [ "9" ] = { "G" }
}
local Value1 = nil
function Table.TagBanned( List )
    if type( List ) ~= "string" then
        return false
    end
    if not Value1 then
        local Value1Inner
        Value1 = { }
        local TAG_BANNED = Table.TAG_BANNED
        Value1Inner = nil

        for Key, Value in TAG_BANNED, nil, nil do
            Value1[ Value:upper( ) ] = true
        end
    end

    local Table2Inner
    local Count = #List
    local I = 1
    Table2Inner = { "" }

    for I = 1, Count do
        local Value2
        local Upper = List:sub( I, I ):upper( )
        local TableInner = { }
        Value2 = nil

        for Key2, Value3 in Table2Inner, nil, nil do
            local Entry2
            table.insert( TableInner, Value3 .. Upper )
            local Entry = Table2[ Upper ]
            Entry2 = if Entry then Entry else { }
            local Value4 = nil

            for Key3, Value5 in Entry2, nil, nil do
                table.insert( TableInner, Value3 .. Value5 )
            end
        end

        Table2Inner = TableInner
    end

    local Value6 = nil

    for Key4, Value7 in Table2Inner, nil, nil do
        if Value1[ Value7 ] then
            return true
        end
    end

    return false
end
local Players = game:GetService( "Players" )

local function PlayerOf( Object )
    if typeof( Object ) ~= "Instance" then
        return nil
    end
    if Object:IsA( "Player" ) then
        return Object
    end
    if Object:IsA( "Model" ) then
        return Players:GetPlayerFromCharacter( Object )
    end
    return nil
end

function Table.IdOf( Name )
    local PlayerFromCharacter

    if typeof( Name ) == "Instance" then
        if Name:IsA( "Player" ) then
            PlayerFromCharacter = Name
        elseif Name:IsA( "Model" ) then
            PlayerFromCharacter = Players:GetPlayerFromCharacter( Name )
        else
            PlayerFromCharacter = nil
        end
    else
        PlayerFromCharacter = nil
    end

    local ClanId

    if PlayerFromCharacter then
        ClanId = PlayerFromCharacter:GetAttribute( "ClanId" )
    else
        ClanId = PlayerFromCharacter
    end

    local PlayerFromCharacter2 = if type( ClanId ) ~= "string" or ClanId == "" or not ClanId then nil else ClanId
    return PlayerFromCharacter2
end
function Table.Same( Object, Object2 )
    local PlayerFromCharacter

    if typeof( Object ) == "Instance" then
        if Object:IsA( "Player" ) then
            PlayerFromCharacter = Object
        elseif Object:IsA( "Model" ) then
            PlayerFromCharacter = Players:GetPlayerFromCharacter( Object )
        else
            PlayerFromCharacter = nil
        end
    else
        PlayerFromCharacter = nil
    end

    local PlayerFromCharacter2

    if typeof( Object2 ) == "Instance" then
        if Object2:IsA( "Player" ) then
            PlayerFromCharacter2 = Object2
        elseif Object2:IsA( "Model" ) then
            PlayerFromCharacter2 = Players:GetPlayerFromCharacter( Object2 )
        else
            PlayerFromCharacter2 = nil
        end
    else
        PlayerFromCharacter2 = nil
    end
    if not PlayerFromCharacter or not PlayerFromCharacter2 or PlayerFromCharacter == PlayerFromCharacter2 then
        return false
    end

    local Flag
    local IdOf = Table.IdOf( PlayerFromCharacter )

    if IdOf == nil then
        Flag = false
    elseif IdOf == Table.IdOf( PlayerFromCharacter2 ) then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
function Table.Prefix( Object )
    if not Table.Enabled( ) then
        return ""
    end

    local ClanTag

    if typeof( Object ) == "Instance" then
        ClanTag = Object:GetAttribute( "ClanTag" )
    else
        ClanTag = false
    end

    local Text = type( ClanTag ) == "string" and ClanTag ~= "" and "[" .. ClanTag .. "] " or ""
    return Text
end
Table.TAG_COLOR = Color3.fromRGB( 255, 196, 70 )
Table.COLORS = {
    { id = "gold", name = "Gold", c = Color3.fromRGB( 255, 196, 70 ) },
    { id = "red", name = "Red", c = Color3.fromRGB( 255, 84, 84 ) },
    { id = "orange", name = "Orange", c = Color3.fromRGB( 255, 145, 55 ) },
    { id = "yellow", name = "Yellow", c = Color3.fromRGB( 255, 232, 85 ) },
    { id = "lime", name = "Lime", c = Color3.fromRGB( 175, 240, 75 ) },
    { id = "green", name = "Green", c = Color3.fromRGB( 75, 215, 115 ) },
    { id = "teal", name = "Teal", c = Color3.fromRGB( 65, 220, 205 ) },
    { id = "blue", name = "Blue", c = Color3.fromRGB( 85, 165, 255 ) },
    { id = "purple", name = "Purple", c = Color3.fromRGB( 180, 115, 255 ) },
    { id = "pink", name = "Pink", c = Color3.fromRGB( 255, 115, 205 ) },
    { id = "white", name = "White", c = Color3.fromRGB( 245, 245, 250 ) },
    { id = "silver", name = "Silver", c = Color3.fromRGB( 175, 188, 205 ) }
}
Table.SPECIALS = {
    {
        id = "goldblack",
        name = "Gold & Black",
        rank = 1,
        keys = {
            Color3.fromRGB( 255, 214, 90 ),
            Color3.fromRGB( 255, 176, 30 ),
            Color3.fromRGB( 46, 34, 12 ),
            Color3.fromRGB( 255, 196, 60 )
        }
    },
    {
        id = "chrome",
        name = "Chrome",
        rank = 2,
        keys = {
            Color3.fromRGB( 255, 255, 255 ),
            Color3.fromRGB( 150, 160, 178 ),
            Color3.fromRGB( 232, 238, 248 ),
            Color3.fromRGB( 105, 116, 134 )
        }
    },
    {
        id = "bronze",
        name = "Shiny Bronze",
        rank = 3,
        keys = {
            Color3.fromRGB( 255, 205, 150 ),
            Color3.fromRGB( 205, 122, 58 ),
            Color3.fromRGB( 255, 172, 110 ),
            Color3.fromRGB( 140, 72, 30 )
        }
    }
}
Table.THEMES = {
    { id = "crimson", name = "Crimson", c = Color3.fromRGB( 215, 58, 72 ) },
    {
        id = "midnight",
        name = "Midnight",
        c = Color3.fromRGB( 70, 115, 235 )
    },
    { id = "emerald", name = "Emerald", c = Color3.fromRGB( 45, 190, 115 ) },
    { id = "royal", name = "Royal", c = Color3.fromRGB( 150, 85, 235 ) },
    { id = "amber", name = "Amber", c = Color3.fromRGB( 235, 160, 45 ) },
    { id = "rose", name = "Rose", c = Color3.fromRGB( 235, 95, 165 ) },
    { id = "steel", name = "Steel", c = Color3.fromRGB( 135, 155, 180 ) },
    { id = "onyx", name = "Onyx", c = Color3.fromRGB( 85, 85, 95 ) }
}
Table.BANNER_NEUTRAL = "rbxassetid://102542022791578"
Table.STYLE_COOLDOWN = 30
Table.RENAME_DAYS = 7
local Table3 = { }
local Table4 = { }
local COLORS = Table.COLORS
Value2 = nil

for Key, Value in COLORS, nil, nil do
    Table3[ Value.id ] = Value
end

local Value3
local SPECIALS = Table.SPECIALS
Value3 = nil

for Key2, Value4 in SPECIALS, nil, nil do
    Table3[ Value4.id ] = Value4
end

local Value5
local THEMES = Table.THEMES
Value5 = nil

for Key3, Value6 in THEMES, nil, nil do
    Table4[ Value6.id ] = Value6
end

function Table.ColorDef( DefName )
    local Entry2
    local Entry = Table3[ DefName ]
    Entry2 = if Entry then Entry else Table3.gold
    return Entry2
end
function Table.ThemeDef( DefName )
    local Entry2
    local Entry = Table4[ DefName ]
    Entry2 = if Entry then Entry else Table.THEMES[ 1 ]
    return Entry2
end
function Table.IsColor( Key )
    local Flag

    if Table3[ Key ] == nil then
        Flag = false
    elseif Table3[ Key ].keys == nil then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
function Table.IsSpecial( Key )
    local Flag

    if Table3[ Key ] == nil then
        Flag = false
    elseif Table3[ Key ].keys == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end
function Table.IsTheme( Key )
    local Flag = Table4[ Key ] ~= nil and true or false
    return Flag
end
function Table.SpecialUnlocked( UnlockedName, Argument2, Text )
    local Entry = Table3[ UnlockedName ]

    if not Entry or not Entry.rank then
        return false
    end
    if type( Argument2 ) == "number" and Argument2 <= Entry.rank then
        return true
    end

    local Flag
    local Number = tonumber( Text )

    if Number == nil then
        Flag = false
    elseif Number >= 3 then
        if 6 - Number <= Entry.rank then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end
function Table.Sample( Argument1, Amount )
    if Argument1.keys then
        local Keys = Argument1.keys
        local Result = Amount % 1 * #Keys
        local Floor = math.floor( Result )
        return Keys[ Floor % #Keys + 1 ]:Lerp( Keys[ ( Floor + 1 ) % #Keys + 1 ], Result - Floor )
    end
    return Argument1.c
end

local function Esc( Argument1 )
    return ( tostring( Argument1 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) )
end

function Table.TagRich( Argument1, Argument2, Amount )
    local ColorDef = Table.ColorDef( Argument2 )
    local Text = "[" .. tostring( Argument1 ) .. "]"

    if not ColorDef.keys then
        return ( "<font color=\"#%s\">%s</font>" ):format( ColorDef.c:ToHex( ), ( tostring( Text ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) ) )
    end

    local TableInner = { }
    local Count = #Text
    local I = 1

    for I = 1, Count do
        local Sample = Table.Sample
        table.insert( TableInner, ( "<font color=\"#%s\">%s</font>" ):format( Sample( ColorDef, ( I - 1 ) / #Text * 0.75 + ( Amount or 0 ) ):ToHex( ), ( tostring( ( Text:sub( I, I ) ) ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) ) ) )
    end

    return table.concat( TableInner )
end
function Table.PrefixRich( Object, Argument2 )
    if not Table.Enabled( ) or typeof( Object ) ~= "Instance" then
        return ""
    end

    local ClanTag = Object:GetAttribute( "ClanTag" )

    if type( ClanTag ) ~= "string" or ClanTag == "" then
        return ""
    end
    local TagRich = Table.TagRich
    return TagRich( ClanTag, Object:GetAttribute( "ClanColor" ), Argument2 ) .. " "
end
function Table.GradientOf( Argument1 )
    local ColorDef = Table.ColorDef( Argument1 )

    if not ColorDef.keys then
        local C = ColorDef.c
        return ColorSequence.new( {
            ColorSequenceKeypoint.new( 0, C:Lerp( Color3.new( 1, 1, 1 ), 0.55 ) ),
            ColorSequenceKeypoint.new( 0.55, C ),
            ColorSequenceKeypoint.new( 1, C:Lerp( Color3.new( 0, 0, 0 ), 0.3 ) )
        } )
    end

    local Value1
    local TableInner = { }
    local Keys = ColorDef.keys
    Value1 = nil

    for Key, Value in Keys, nil, nil do
        table.insert( TableInner, ColorSequenceKeypoint.new( ( Key - 1 ) / #ColorDef.keys, Value ) )
    end

    table.insert( TableInner, ColorSequenceKeypoint.new( 1, ColorDef.keys[ 1 ] ) )
    return ColorSequence.new( TableInner )
end
Table.SCROLL_SPEED = 0.35
function Table.ScrollSequence( Argument1, Argument2 )
    local ColorDef = Table.ColorDef( Argument1 )

    if not ColorDef.keys then
        return Table.GradientOf( Argument1 )
    end

    local Create = table.create( 13 )
    local I = 0

    for I = 0, 12 do
        local Result = I / 12
        local Total = I + 1
        local Sample = Table.Sample
        Create[ Total ] = ColorSequenceKeypoint.new( Result, Sample( ColorDef, Result - Argument2 ) )
    end

    return ColorSequence.new( Create )
end
return Table
