-- ReplicatedStorage.AttachmentCases
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    TIER = {
        [ "Mod:reflex" ] = "common",
        [ "Mod:HoloPoint" ] = "uncommon",
        [ "Mod:Acog" ] = "epic",
        [ "Mod:DoubleSight" ] = "legendary",
        [ "Mod:Compensator" ] = "common",
        [ "Mod:HBarrel" ] = "uncommon",
        [ "Mod:Silencieux" ] = "legendary",
        [ "Mod:LaserRed" ] = "common",
        [ "Mod:LaserGreen" ] = "uncommon",
        [ "Mod:LaserBlue" ] = "uncommon",
        [ "Mod:LaserPurple" ] = "epic",
        [ "Mod:LaserWhite" ] = "mythical",
        [ "Mod:Flashlight" ] = "rare",
        [ "Mod:LaserDouble" ] = "legendary",
        [ "Mod:FlashlightRed" ] = "epic",
        [ "Mod:FlashlightGreen" ] = "epic",
        [ "Mod:ForeGrip" ] = "common",
        [ "Mod:AFG" ] = "uncommon",
        [ "Mod:Bipod" ] = "legendary",
        [ "Mod:Drum" ] = "epic",
        [ "Mod:DoubleDrum" ] = "legendary",
        [ "Mod:rmr" ] = "common",
        [ "Mod:magnifier_3x" ] = "uncommon",
        [ "Mod:elcan_specter" ] = "uncommon",
        [ "Mod:qr_vertical_grip" ] = "common",
        [ "Mod:folding_grip" ] = "uncommon",
        [ "Mod:skeleton_grip" ] = "rare",
        [ "Mod:collapsible_stock" ] = "mythical",
        [ "Mod:HeavySuppressor" ] = "mythical",
        [ "Mod:DoubleMag" ] = "mythical",
        [ "Skin:Blue" ] = "common",
        [ "Skin:Green" ] = "common",
        [ "Skin:Pink" ] = "common",
        [ "Skin:Yellow" ] = "common",
        [ "Skin:White" ] = "uncommon",
        [ "Skin:Black" ] = "rare",
        [ "Skin:GlossBlue" ] = "rare",
        [ "Skin:GlossGreen" ] = "rare",
        [ "Skin:GlossPurple" ] = "rare",
        [ "Skin:GlossBlack" ] = "epic",
        [ "Skin:GlossWhite" ] = "legendary",
        [ "Skin:Forest" ] = "uncommon",
        [ "Skin:Swamp" ] = "uncommon",
        [ "Skin:Urban" ] = "uncommon",
        [ "Skin:Tartan" ] = "uncommon",
        [ "Skin:Tags" ] = "uncommon",
        [ "Skin:Zebra" ] = "rare",
        [ "Skin:Leopard" ] = "rare",
        [ "Skin:Ember" ] = "rare",
        [ "Skin:Abyss" ] = "rare",
        [ "Skin:PureGold" ] = "epic",
        [ "Skin:Damascus" ] = "epic",
        [ "Skin:Toxic" ] = "legendary",
        [ "Skin:Ruby" ] = "legendary",
        [ "Skin:DarkMatter" ] = "mythical"
    },
    CASES = {
        AttSights = {
            [ "Mod:reflex" ] = 27,
            [ "Mod:rmr" ] = 27,
            [ "Mod:HoloPoint" ] = 15,
            [ "Mod:magnifier_3x" ] = 15,
            [ "Mod:elcan_specter" ] = 14.9,
            [ "Mod:Acog" ] = 1,
            [ "Mod:DoubleSight" ] = 0.1
        },
        AttMuzzle = {
            [ "Mod:Compensator" ] = 21.94,
            [ "Mod:LaserRed" ] = 21.94,
            [ "Mod:HBarrel" ] = 15.86,
            [ "Mod:LaserGreen" ] = 14.63,
            [ "Mod:LaserBlue" ] = 14.63,
            [ "Mod:Flashlight" ] = 7.32,
            [ "Mod:LaserPurple" ] = 1,
            [ "Mod:FlashlightRed" ] = 1,
            [ "Mod:FlashlightGreen" ] = 1,
            [ "Mod:Silencieux" ] = 0.55,
            [ "Mod:LaserDouble" ] = 0.1,
            [ "Mod:LaserWhite" ] = 0.02,
            [ "Mod:HeavySuppressor" ] = 0.01
        },
        AttUnder = {
            [ "Mod:ForeGrip" ] = 23.99,
            [ "Mod:qr_vertical_grip" ] = 23.99,
            [ "Mod:AFG" ] = 19,
            [ "Mod:folding_grip" ] = 19,
            [ "Mod:skeleton_grip" ] = 12.64,
            [ "Mod:Drum" ] = 1,
            [ "Mod:Bipod" ] = 0.3,
            [ "Mod:DoubleDrum" ] = 0.05,
            [ "Mod:collapsible_stock" ] = 0.02,
            [ "Mod:DoubleMag" ] = 0.01
        },
        AttCamoColor = {
            [ "Skin:Green" ] = 21,
            [ "Skin:Blue" ] = 21,
            [ "Skin:Yellow" ] = 21,
            [ "Skin:Pink" ] = 21,
            [ "Skin:White" ] = 10,
            [ "Skin:Black" ] = 6
        },
        AttCamoGloss = {
            [ "Skin:GlossGreen" ] = 32.97,
            [ "Skin:GlossPurple" ] = 32.97,
            [ "Skin:GlossBlue" ] = 32.96,
            [ "Skin:GlossBlack" ] = 1,
            [ "Skin:GlossWhite" ] = 0.1
        },
        AttCamoWrap = {
            [ "Skin:Forest" ] = 13.05,
            [ "Skin:Swamp" ] = 13.05,
            [ "Skin:Urban" ] = 13.05,
            [ "Skin:Tartan" ] = 13.05,
            [ "Skin:Tags" ] = 13.05,
            [ "Skin:Zebra" ] = 8.31,
            [ "Skin:Leopard" ] = 8.31,
            [ "Skin:Ember" ] = 8.31,
            [ "Skin:Abyss" ] = 7.73,
            [ "Skin:PureGold" ] = 1,
            [ "Skin:Damascus" ] = 0.6,
            [ "Skin:Toxic" ] = 0.3,
            [ "Skin:Ruby" ] = 0.1,
            [ "Skin:DarkMatter" ] = 0.09
        }
    },
    NAMES = {
        reflex = "Red Dot",
        HoloPoint = "Holographic",
        DoubleSight = "Dual Sight",
        Acog = "ACOG",
        Silencieux = "Suppressor",
        Compensator = "Compensator",
        HBarrel = "Muzzle Brake",
        HeavySuppressor = "Heavy Suppressor",
        DoubleMag = "Double Mag",
        AFG = "Angled Grip",
        ForeGrip = "Vertical Grip",
        Bipod = "Bipod",
        LaserRed = "Red Laser",
        LaserGreen = "Green Laser",
        LaserBlue = "Blue Laser",
        LaserPurple = "Purple Laser",
        LaserWhite = "White Laser",
        LaserDouble = "Double Laser",
        Flashlight = "Flashlight",
        FlashlightRed = "Red Flashlight",
        FlashlightGreen = "Green Flashlight",
        Drum = "Drum Mag",
        DoubleDrum = "Double Drum",
        rmr = "Mini Red Dot",
        magnifier_3x = "3x Magnifier",
        elcan_specter = "ELCAN Specter",
        qr_vertical_grip = "Tactical Grip",
        folding_grip = "Folding Grip",
        skeleton_grip = "Skeleton Grip",
        collapsible_stock = "Collapsible Stock"
    },
    INFO = {
        AttSights = {
            DisplayName = "Sight Case",
            Short = "Sights",
            Description = "A random sight",
            Cost = 20000,
            WaveColor = Color3.fromRGB( 70, 200, 255 )
        },
        AttMuzzle = {
            DisplayName = "Muzzle & Laser Case",
            Short = "Muzzle & Laser",
            Description = "A random muzzle or laser",
            Cost = 40000,
            WaveColor = Color3.fromRGB( 255, 96, 60 )
        },
        AttUnder = {
            DisplayName = "Grip & Mag Case",
            Short = "Grip & Mag",
            Description = "A random grip or magazine",
            Cost = 40000,
            WaveColor = Color3.fromRGB( 90, 225, 120 )
        },
        AttCamoColor = {
            DisplayName = "Color Camo Case",
            Short = "Colors",
            Description = "A random plain color",
            Cost = 5000,
            WaveColor = Color3.fromRGB( 215, 95, 255 )
        },
        AttCamoGloss = {
            DisplayName = "Gloss Camo Case",
            Short = "Gloss",
            Description = "A random gloss finish",
            Cost = 15000,
            WaveColor = Color3.fromRGB( 120, 200, 255 )
        },
        AttCamoWrap = {
            DisplayName = "Wrap Camo Case",
            Short = "Wraps",
            Description = "A random wrap",
            Cost = 50000,
            WaveColor = Color3.fromRGB( 255, 190, 60 )
        }
    },
    ORDER = {
        "AttSights",
        "AttMuzzle",
        "AttUnder",
        "AttCamoColor",
        "AttCamoGloss",
        "AttCamoWrap"
    }
}
function Table.IsCase( Key )
    local Flag = Table.CASES[ Key ] ~= nil and true or false
    return Flag
end
function Table.Split( Argument1 )
    local Match, Match2 = string.match( tostring( Argument1 ), "^(%a+):(.+)$" )
    return Match, Match2
end
function Table.Name( Argument1 )
    local Split, Split2 = Table.Split( Argument1 )

    if Split == "Skin" then
        local Text
        local Entry = require( game:GetService( "ReplicatedStorage" ).Weapons.ModCatalog ).Skins[ Split2 ]

        if not Entry or not Entry.name then
            if Split2 then
                Text = Split2
            else
                Text = tostring( Argument1 )
            end
        else
            Text = Entry.name
        end

        return Text
    end
    local Text2
    local Entry2 = Table.NAMES[ Split2 ]

    if Entry2 then
        Text2 = Entry2
    elseif Split2 then
        Text2 = Split2
    else
        Text2 = tostring( Argument1 )
    end

    return Text2
end
function Table.Tier( Key )
    return Table.TIER[ Key ] or "common"
end
function Table.Pool( Key )
    local Entry = Table.CASES[ Key ]

    if not Entry then
        return nil
    end

    local Flag
    local TableInner = { }
    Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) == true and true or false
    local Value1 = nil

    for Value in Entry, nil, nil do
        if not Flag or Table.TIER[ Value ] ~= "mythical" then
            table.insert( TableInner, Value )
        end
    end

    table.sort( TableInner, function( Key, Key2 )
        if Entry[ Key ] == Entry[ Key2 ] then
            local Flag2 = Key < Key2 and true or false
            return Flag2
        end
        local Flag
        local EntryInner = Entry[ Key ]
        Flag = Entry[ Key2 ] < EntryInner and true or false
        return Flag
    end )
    return TableInner
end
function Table.Roll( Key, Argument2 )
    local Pool = Table.Pool( Key )

    if not Pool or #Pool == 0 then
        return nil
    end

    local Entry = Table.CASES[ Key ]
    local Value1, Number
    Value1 = nil
    Number = 0

    for Key2, Value in Pool, nil, nil do
        Number = Number + Entry[ Value ]
    end

    local Value2
    local NextNumber = ( Argument2 or Random.new( ) ):NextNumber( ) * Number
    Value2 = nil

    for Key3, Value3 in Pool, nil, nil do
        local NextNumber2 = NextNumber - Entry[ Value3 ]

        if NextNumber2 < 0 then
            return Value3
        end
        NextNumber = NextNumber2
    end

    return Pool[ #Pool ]
end
local Value1 = nil
local Table2 = { }
function Table.Unlocked( Object, Key )
    local Unlocks

    if Object then
        Unlocks = Object:GetAttribute( "Unlocks" )
    else
        Unlocks = Object
    end
    if Unlocks ~= Value1 then
        local Table = { }
        Value1 = Unlocks
        Table2 = Table
        local Success, Result = pcall( function()
            return game:GetService( "HttpService" ):JSONDecode( Unlocks )
        end )

        if Success and type( Result ) == "table" then
            local Value1Inner = nil

            for Key2, Value in Result, nil, nil do
                Table2[ Value ] = true
            end
        end
    end

    local Flag = Table2[ Key ] == true and true or false
    return Flag
end
function Table.Lockable( Key )
    local Flag = Table.TIER[ Key ] ~= nil and true or false
    return Flag
end
return Table
