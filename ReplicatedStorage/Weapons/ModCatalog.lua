-- ReplicatedStorage.Weapons.ModCatalog
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local HttpService = game:GetService( "HttpService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Table = {
    Families = {
        {
            id = "Optic",
            name = "Sights",
            HidesByWeapon = {
                AWP = { "Iron", "lense" },
                DRAGON = { "PSO-1 Optic" },
                G36 = { "Sight" }
            }
        },
        {
            id = "Muzzle",
            name = "Muzzle",
            HidesByWeapon = { AWP = { "MuzzleBreak" } }
        },
        {
            id = "Underbarrel",
            name = "Underbarrel",
            HidesByWeapon = { M4A1 = { "Handle" } }
        },
        { id = "Rail", name = "Laser / Light" },
        {
            id = "Mag",
            name = "Magazine",
            Base = "Default Mag",
            Hides = {
                "Mag",
                "Magazine",
                "Magazine Cartridges",
                "RoundMag",
                "Bullets",
                "Ammunition"
            }
        },
        {
            id = "Stock",
            name = "Stock",
            HidesByWeapon = {
                M4 = { "Stock" },
                AK = { "Stock" },
                MP5 = { "Stock" },
                M60 = { "Stock", "Stock Catch" },
                Uzi = { "Stock" },
                MK14 = { "Stock" },
                G36 = { "Stock" }
            }
        }
    }
}
local FamilyById = { }
local Families = Table.Families
Value1 = nil

for Key, Value in Families, nil, nil do
    Value.order = Key
    FamilyById[ Value.id ] = Value
end

local Value2
Table.FamilyById = FamilyById
Table.Items = {
    reflex = { name = "Red Dot", family = "Optic" },
    HoloPoint = { name = "Holographic", family = "Optic" },
    DoubleSight = { name = "Dual Sight", family = "Optic", AltZoom = 0.6 },
    Acog = { name = "ACOG", family = "Optic", Zoom = 0.6 },
    Silencieux = {
        name = "Suppressor",
        family = "Muzzle",
        Effects = { Silenced = true }
    },
    Compensator = { name = "Compensator", family = "Muzzle" },
    HBarrel = { name = "Muzzle Brake", family = "Muzzle" },
    AFG = { name = "Angled Grip", family = "Underbarrel" },
    ForeGrip = { name = "Vertical Grip", family = "Underbarrel" },
    Bipod = { name = "Bipod", family = "Underbarrel", SpreadScale = 0.8 },
    LaserRed = { name = "Red Laser", family = "Rail" },
    LaserGreen = { name = "Green Laser", family = "Rail" },
    LaserBlue = { name = "Blue Laser", family = "Rail" },
    LaserPurple = { name = "Purple Laser", family = "Rail" },
    LaserWhite = {
        name = "White Laser",
        family = "Rail",
        HipFire = { Zoom = 0.15, Bloom = 0.25 }
    },
    LaserDouble = {
        name = "Double Laser",
        family = "Rail",
        HipFire = { Zoom = 0.15, Bloom = 0.25 }
    },
    Flashlight = { name = "Flashlight", family = "Rail" },
    FlashlightRed = { name = "Red Flashlight", family = "Rail" },
    FlashlightGreen = { name = "Green Flashlight", family = "Rail" },
    Drum = { name = "Drum Mag", family = "Mag", MagSize = 45, ReloadAdd = 1 },
    DoubleDrum = { name = "Double Drum", family = "Mag", MagSize = 60, ReloadAdd = 1.5 },
    rmr = { name = "Mini Red Dot", family = "Optic" },
    magnifier_3x = { name = "3x Magnifier", family = "Optic" },
    elcan_specter = { name = "ELCAN Specter", family = "Optic" },
    qr_vertical_grip = { name = "Tactical Grip", family = "Underbarrel" },
    folding_grip = { name = "Folding Grip", family = "Underbarrel" },
    skeleton_grip = { name = "Skeleton Grip", family = "Underbarrel" },
    collapsible_stock = {
        name = "Collapsible Stock",
        family = "Stock",
        Effects = { RollSpeed = 1.2 }
    },
    HeavySuppressor = {
        name = "Heavy Suppressor",
        family = "Muzzle",
        Effects = {
            Silenced = true,
            FalloffRange = 1.5,
            FalloffKeep = 0.6,
            SuppressorTone = "Heavy"
        }
    },
    DoubleMag = {
        name = "Double Mag",
        family = "Mag",
        MagScale = 0.8333333333333334,
        ReloadScale = 0.45,
        ReloadAdd = 0.2
    }
}
Table.NoBigMag = {
    RPG = true,
    DRAGON = true,
    AWP = true,
    SPAS12 = true,
    SawedOff = true
}
Table.Forbidden = {
    SPAS12 = { Underbarrel = true, Mag = true },
    G15 = { Underbarrel = true },
    AWP = { Mag = true },
    DRAGON = { Mag = true },
    Eagle = { Underbarrel = true, Mag = true },
    M9 = { Underbarrel = true },
    Uzi = { Underbarrel = true },
    SawedOff = { Underbarrel = true, Mag = true, Muzzle = true }
}

local function Forbidden( Key, Key2 )
    local Flag

    if ( Key and Table.Forbidden[ Key ] ) == nil then
        Flag = false
    elseif ( Key and Table.Forbidden[ Key ] )[ Key2 ] == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local IsStudio = game:GetService( "RunService" ):IsStudio( )

local function LiveHidden( Argument1 )
    local Flag = if Argument1.StudioOnly == true then not IsStudio else false
    return Flag
end

function Table.MagSize( SizeName, Argument2, Argument3 )
    if not ( Argument2 and Table.Items[ Argument2.Mag or "" ] ) or Table.NoBigMag[ SizeName ] then
        return Argument3
    end
    if ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).MagScale then
        return ( math.max( 1, ( math.floor( Argument3 * ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).MagScale + 0.5 ) ) ) )
    end
    if ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).MagSize then
        return ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).MagSize
    end
    return Argument3
end
function Table.ReloadTime( TimeName, Argument2, Argument3 )
    if not ( Argument2 and Table.Items[ Argument2.Mag or "" ] ) or Table.NoBigMag[ TimeName ] then
        return Argument3
    end
    if ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).ReloadScale then
        return Argument3 * ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).ReloadScale + ( ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).ReloadAdd or 0 )
    end

    local ReloadTime2
    local ReloadTime = ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).ReloadTime
    ReloadTime2 = if ReloadTime then ReloadTime else Argument3 + ( ( Argument2 and Table.Items[ Argument2.Mag or "" ] ).ReloadAdd or 0 )
    return ReloadTime2
end
function Table.SpreadScale( List )
    local Value1, Number
    Value1 = nil
    Number = 1

    for Key, Value in List or { }, nil, nil do
        local Entry2
        local Entry = FamilyById[ Key ]
        Entry2 = if Entry then Table.Items[ Value ] else Entry

        if Entry2 and Entry2.SpreadScale then
            Number = Number * Entry2.SpreadScale
        end
    end

    return Number
end
Table.NoHipFire = { AWP = true, DRAGON = true }
function Table.HipFire( Argument1, Key )
    if ReplicatedStorage:GetAttribute( "LaserHipFireOn" ) ~= true then
        return nil
    end
    if Key ~= nil and Table.NoHipFire[ Key ] then
        return nil
    end

    local Entry2

    if type( Argument1 ) == "table" then
        local Entry = Table.Items[ Argument1.Rail or "" ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = nil
        end
    else
        Entry2 = nil
    end

    local HipFire = Entry2 and Entry2.HipFire or nil
    return HipFire
end
function Table.AimFOV( Argument1, Argument2, Argument3 )
    local Zoom2

    if Argument1 and Table.Items[ Argument1.Optic or "" ] then
        local Zoom = ( Argument1 and Table.Items[ Argument1.Optic or "" ] ).Zoom

        if Zoom then
            Zoom2 = Zoom
        elseif not Argument3 or not ( Argument1 and Table.Items[ Argument1.Optic or "" ] ).AltZoom then
            Zoom2 = 1
        else
            Zoom2 = ( Argument1 and Table.Items[ Argument1.Optic or "" ] ).AltZoom
        end
    else
        Zoom2 = 1
    end

    return Argument2 * math.min( Zoom2, 1 )
end
function Table.FitAmmo( Argument1, Argument2, Argument3, Argument4 )
    if not Argument4 or not ( Argument2 <= Argument1 ) then
        return ( math.min( Argument1, Argument3 ) )
    end
    return Argument3
end
Table.PackPasses = { Beta = 2036990661 }
Table.PackGiftProducts = { Beta = 3718989604 }
function Table.HasPack( Object, Text )
    local Flag

    if Text == nil then
        Flag = true
    elseif Object == nil then
        Flag = false
    elseif Object:GetAttribute( "Pack_" .. Text ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
function Table.OwnsSkin( Object, SkinName )
    local Flag = if type( SkinName ) == "string" then Table.Skins[ SkinName ] else false

    if not Flag then
        return false
    end

    local HasPack3
    local HasPack = Table.HasPack
    local HasPack2 = HasPack( Object, Flag.Pack )

    if HasPack2 then
        HasPack3 = HasPack2
    elseif Object == nil then
        HasPack3 = false
    elseif Object:GetAttribute( "WeaponSkin_" .. SkinName ) == true then
        HasPack3 = true
    else
        HasPack3 = false
    end

    return HasPack3
end
function Table.OwnsSound( Object, SoundName )
    local Flag = if type( SoundName ) == "string" then Table.ShotSounds[ SoundName ] else false

    if not Flag then
        return false
    end

    local Flag2

    if Object == nil then
        Flag2 = false
    elseif Object:GetAttribute( "ShotSound_" .. SoundName ) == true then
        Flag2 = true
    else
        Flag2 = false
    end
    if Flag.Paid then
        return Flag2
    end
    local HasPack = Table.HasPack
    return HasPack( Object, Flag.Pack ) or Flag2
end
Table.Skins = {
    DarkMatter = {
        name = "DarkMatter",
        Material = Enum.Material.Foil,
        Color = Color3.fromHex( "A600FF" ),
        Texture = "rbxassetid://139188901367504",
        SurfaceAppearance = "DarkMatterSA",
        Flow = "rbxassetid://139188901367504",
        Mask = "rbxassetid://97850330355121",
        Animated = true,
        Order = 1
    },
    Void = {
        name = "Void",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 26, 12, 52 ),
        Texture = "rbxassetid://92413754856434",
        SurfaceAppearance = "VoidSA",
        Mask = "rbxassetid://131298451908234",
        Swatch = "rbxassetid://98832893228841",
        Flow = {
            { Image = "rbxassetid://79921281637962", Transparency = 0, Tile = 2.6 },
            {
                Image = "rbxassetid://97801503743164",
                Transparency = 0.1,
                Tile = 3.4
            },
            { Image = "rbxassetid://83719888108186", Transparency = 0, Tile = 1.9 }
        },
        Animated = true,
        FX = "Void",
        Order = 0.4,
        Pack = "Void",
        Aura = "VoidAura",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    Data = {
        name = "Data",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 8, 34, 12 ),
        Texture = "rbxassetid://129965795020667",
        SurfaceAppearance = "DataSA",
        Mask = "rbxassetid://127990470966065",
        Swatch = "rbxassetid://97251453583878",
        Flow = {
            { Image = "rbxassetid://119784781918656", Transparency = 0.1, Tile = 2 },
            {
                Image = "rbxassetid://87756791281967",
                Transparency = 0.05,
                Tile = 2.4
            },
            { Image = "rbxassetid://96132876870539", Transparency = 0, Tile = 3 }
        },
        Animated = true,
        FX = "Data",
        Order = 0.3,
        Pack = "Data",
        Aura = "DataAura",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    Hellspawn = {
        name = "Hellspawn",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 230, 110, 25 ),
        Texture = "rbxassetid://128846066736612",
        SurfaceAppearance = "HellspawnSA",
        Mask = "rbxassetid://110317205043577",
        Swatch = "rbxassetid://89961402100436",
        Flow = {
            { Image = "rbxassetid://74649964877686", Transparency = 0, Tile = 3 },
            {
                Image = "rbxassetid://121236545745752",
                Transparency = 0.15,
                Tile = 1.8
            }
        },
        Animated = true,
        FX = "Hellspawn",
        Order = 0.5,
        Pack = "Halloween",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    SpectralWhite = {
        name = "Spectral White",
        Material = Enum.Material.ForceField,
        Color = Color3.fromRGB( 255, 255, 255 ),
        Swatch = "rbxassetid://83751629214547",
        Order = 0.6,
        Event = "MK14Event",
        PaintMags = true
    },
    SpectralViolet = {
        name = "Spectral Violet",
        Material = Enum.Material.ForceField,
        Color = Color3.fromRGB( 175, 70, 255 ),
        Texture = "rbxassetid://102614544503051",
        Swatch = "rbxassetid://114626101346386",
        Order = 0.61,
        Event = "MK14Event",
        PaintMags = true
    },
    SpectralRed = {
        name = "Spectral Red",
        Material = Enum.Material.ForceField,
        Color = Color3.fromRGB( 255, 35, 55 ),
        Texture = "rbxassetid://102614544503051",
        Swatch = "rbxassetid://93679546092747",
        Aura = "SpectralAura",
        Order = 0.62,
        Event = "MK14Event",
        PaintMags = true
    },
    Toxic = {
        name = "Emerald",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 4, 150, 72 ),
        Texture = "rbxassetid://102614544503051",
        SurfaceAppearance = "ToxicSA",
        Mask = "rbxassetid://74018695414809",
        Order = 2,
        Glint = true
    },
    PureGold = {
        name = "Pure Gold",
        Material = Enum.Material.Foil,
        Color = Color3.fromRGB( 255, 149, 0 ),
        Texture = "rbxassetid://119970423920070",
        SurfaceAppearance = "GoldSA",
        Mask = "rbxassetid://106910003796472",
        Order = 4,
        Glint = true,
        GlintColor = Color3.fromRGB( 255, 236, 170 )
    },
    Damascus = {
        name = "Damascus",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 226, 228, 232 ),
        Texture = "rbxassetid://135064172601255",
        SurfaceAppearance = "DamascusSA",
        Mask = "rbxassetid://121113182054413",
        Order = 4.5,
        Glint = true,
        GlintColor = Color3.fromRGB( 235, 242, 255 )
    },
    Midnight = {
        name = "Midnight",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 28, 40, 80 ),
        Texture = "rbxassetid://90856447923823",
        SurfaceAppearance = "MidnightSA",
        Order = 0,
        Pack = "Beta"
    },
    Forest = {
        name = "Forest",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 122, 130, 82 ),
        Texture = "rbxassetid://139852822593854",
        SurfaceAppearance = "ForestSA",
        Order = 5
    },
    Zebra = {
        name = "Zebra",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 14, 10, 14 ),
        Texture = "rbxassetid://73783955711379",
        SurfaceAppearance = "ZebraSA",
        Order = 6
    },
    Urban = {
        name = "Urban",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 72, 75, 79 ),
        Texture = "rbxassetid://104630049872500",
        SurfaceAppearance = "UrbanSA",
        Order = 7
    },
    Abyss = {
        name = "Stained Glass",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 40, 60, 175 ),
        Texture = "rbxassetid://136762647236808",
        SurfaceAppearance = "AbyssSA",
        Mask = "rbxassetid://89895583137526",
        Order = 8
    },
    Tartan = {
        name = "Tartan",
        Material = Enum.Material.Fabric,
        Color = Color3.fromRGB( 196, 164, 112 ),
        Texture = "rbxassetid://135953684594505",
        SurfaceAppearance = "TartanSA",
        Order = 9
    },
    Swamp = {
        name = "Swamp",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 66, 112, 58 ),
        Texture = "rbxassetid://78430441286396",
        SurfaceAppearance = "SwampSA",
        Order = 10
    },
    Ember = {
        name = "Ember",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 168, 96, 32 ),
        Texture = "rbxassetid://113512216307546",
        SurfaceAppearance = "EmberSA",
        Order = 11
    },
    Leopard = {
        name = "Leopard",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 213, 155, 92 ),
        Texture = "rbxassetid://77845630545750",
        SurfaceAppearance = "LeopardSA",
        Order = 12
    },
    Tags = {
        name = "Tags",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 118, 118, 116 ),
        Texture = "rbxassetid://77081538119442",
        SurfaceAppearance = "TagsSA",
        Order = 13
    },
    ClanTag = {
        name = "Clan TAG",
        Material = Enum.Material.Foil,
        Color = Color3.fromRGB( 16, 16, 18 ),
        SurfaceAppearance = "GlossBlackSA",
        Color2 = Color3.fromRGB( 235, 235, 240 ),
        SurfaceAppearance2 = "GlossWhiteSA",
        Plaque1 = Color3.fromRGB( 46, 46, 52 ),
        Plaque2 = Color3.fromRGB( 240, 240, 245 ),
        Order = 13.5,
        Hidden = true,
        Tag = "rbxassetid://106916582918444",
        TagDirect = "rbxassetid://126705754703088"
    },
    ClanTop1 = {
        Clan = "e3874681d60c",
        name = "FRP",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 150, 150, 156 ),
        SurfaceAppearance = "ClanTop1SA",
        Color2 = Color3.fromRGB( 14, 14, 16 ),
        SurfaceAppearance2 = "ClanTop1SA2",
        Plaque1 = Color3.fromRGB( 18, 16, 24 ),
        Plaque2 = Color3.fromRGB( 18, 16, 24 ),
        Mono = true,
        TagColor = Color3.fromRGB( 170, 170, 178 ),
        TagGui = true,
        NoPlaque = true,
        TagText = "FRP",
        Texture = "rbxassetid://82304021697070",
        Flow = {
            {
                Image = "rbxassetid://92566854130513",
                Transparency = 0,
                Tile = 2.4,
                Tint = Color3.fromRGB( 26, 38, 100 ),
                Tint2 = Color3.fromRGB( 26, 38, 100 )
            },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 16, 28, 82 ),
                Tint2 = Color3.fromRGB( 16, 28, 82 ),
                Speed = 3.6
            },
            {
                Image = "rbxassetid://81349311863783",
                Transparency = 0.2,
                Tile = 1.6,
                Tint = Color3.fromRGB( 30, 30, 34 ),
                Tint2 = Color3.fromRGB( 30, 30, 34 ),
                Big = 2
            },
            {
                Image = "rbxassetid://103735330407696",
                ImageFlip = "rbxassetid://129339587344053",
                ImageTall = "rbxassetid://90742413604944",
                ImageTallFlip = "rbxassetid://117041133907206",
                Transparency = 0.15,
                Tile = 1.05,
                TileV = 0.17,
                Tint = Color3.fromRGB( 185, 188, 198 ),
                Tint2 = Color3.fromRGB( 185, 188, 198 ),
                Glow = Color3.fromRGB( 235, 242, 255 ),
                Kind = "tag",
                MinHeight = 0.25,
                MinLen = 0.6
            }
        },
        Animated = true,
        FX = "Clan",
        Aura = "ClanTop1Aura",
        Order = 13.41,
        Hidden = true,
        Tag = "rbxassetid://106916582918444",
        TagDirect = "rbxassetid://126705754703088",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    ClanTop2 = {
        Clan = "586a1723f688",
        name = "OLT",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 238, 238, 244 ),
        SurfaceAppearance = "ClanTop2SA",
        Color2 = Color3.fromRGB( 16, 16, 18 ),
        SurfaceAppearance2 = "ClanTop2SA2",
        Plaque1 = Color3.fromRGB( 16, 16, 18 ),
        Plaque2 = Color3.fromRGB( 16, 16, 18 ),
        Mono = true,
        TagColor = Color3.fromRGB( 16, 16, 18 ),
        TagGui = true,
        NoPlaque = true,
        TagText = "OLT",
        Texture = "rbxassetid://90698442808056",
        Flow = {
            {
                Image = "rbxassetid://84327030318049",
                Transparency = 0,
                Tile = 2.6,
                Tint = Color3.fromRGB( 18, 18, 20 ),
                Tint2 = Color3.fromRGB( 18, 18, 20 )
            },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 155, 80, 255 ),
                Tint2 = Color3.fromRGB( 155, 80, 255 )
            },
            {
                Image = "rbxassetid://73603318273423",
                ImageFlip = "rbxassetid://119413591956419",
                ImageTall = "rbxassetid://117658366561300",
                ImageTallFlip = "rbxassetid://89846296010804",
                Transparency = 0.15,
                Tile = 1.05,
                TileV = 0.17,
                Tint = Color3.fromRGB( 20, 20, 22 ),
                Tint2 = Color3.fromRGB( 20, 20, 22 ),
                Glow = Color3.fromRGB( 175, 110, 255 ),
                Kind = "tag",
                MinHeight = 0.25,
                MinLen = 0.6
            }
        },
        Animated = true,
        FX = "Clan",
        Aura = "ClanTop2Aura",
        Order = 13.42,
        Hidden = true,
        Tag = "rbxassetid://106916582918444",
        TagDirect = "rbxassetid://126705754703088",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    ClanTop3 = {
        Clan = "e1370f70e3a4",
        name = "NTR",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 150, 95, 50 ),
        SurfaceAppearance = "ClanTop3SA",
        Color2 = Color3.fromRGB( 16, 16, 18 ),
        SurfaceAppearance2 = "ClanTop3SA2",
        Plaque1 = Color3.fromRGB( 16, 16, 18 ),
        Plaque2 = Color3.fromRGB( 16, 16, 18 ),
        Mono = true,
        TagColor = Color3.fromRGB( 16, 16, 18 ),
        TagGui = true,
        NoPlaque = true,
        TagText = "NTR",
        Texture = "rbxassetid://113441394202799",
        Flow = {
            {
                Image = "rbxassetid://131779560086723",
                Transparency = 0,
                Tile = 2.4,
                Tint = Color3.fromRGB( 18, 18, 20 ),
                Tint2 = Color3.fromRGB( 18, 18, 20 )
            },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 255, 215, 80 ),
                Tint2 = Color3.fromRGB( 255, 215, 80 )
            },
            {
                Image = "rbxassetid://81349311863783",
                Transparency = 0.15,
                Tile = 1.4,
                Tint = Color3.fromRGB( 255, 238, 150 ),
                Tint2 = Color3.fromRGB( 255, 238, 150 ),
                Big = 2
            },
            {
                Image = "rbxassetid://135381012339356",
                ImageFlip = "rbxassetid://117233832481439",
                ImageTall = "rbxassetid://99163533855381",
                ImageTallFlip = "rbxassetid://94292009217091",
                Transparency = 0.15,
                Tile = 1.05,
                TileV = 0.17,
                Tint = Color3.fromRGB( 20, 20, 22 ),
                Tint2 = Color3.fromRGB( 20, 20, 22 ),
                Glow = Color3.fromRGB( 240, 242, 250 ),
                Kind = "tag",
                MinHeight = 0.25,
                MinLen = 0.6
            }
        },
        Animated = true,
        FX = "Clan",
        Aura = "ClanTop3Aura",
        Order = 13.43,
        Hidden = true,
        Tag = "rbxassetid://106916582918444",
        TagDirect = "rbxassetid://126705754703088",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    RankTop1 = {
        name = "Ranked Top 1",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 10, 10, 12 ),
        SurfaceAppearance = "RankTop1SA",
        Texture = "rbxassetid://91827990359289",
        Flow = {
            { Image = "rbxassetid://73373281696066", Transparency = 0, Tile = 2.4 },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 255, 190, 80 ),
                Speed = 3.6
            },
            {
                Image = "rbxassetid://81349311863783",
                Transparency = 0.15,
                Tile = 1.4,
                Tint = Color3.fromRGB( 255, 220, 120 ),
                Big = 2
            }
        },
        Animated = true,
        FX = "Clan",
        Aura = "RankTop1Aura",
        Order = 13.31,
        Event = "Ranked",
        Rank = "Top1",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    RankTop100 = {
        name = "Ranked Top 100",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 255, 255, 255 ),
        SurfaceAppearance = "RankTop100SA",
        Texture = "rbxassetid://79521353609947",
        Flow = {
            {
                Image = "rbxassetid://99901560164967",
                Transparency = 0,
                Tile = 2.4,
                Tint = Color3.fromRGB( 255, 60, 35 )
            },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 255, 110, 70 )
            },
            {
                Image = "rbxassetid://81349311863783",
                Transparency = 0.15,
                Tile = 1.4,
                Tint = Color3.fromRGB( 255, 140, 90 ),
                Big = 2
            }
        },
        Animated = true,
        FX = "Clan",
        Order = 13.32,
        Event = "Ranked",
        Rank = "Top100",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    RankChampion = {
        name = "Ranked Champion",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 255, 255, 255 ),
        SurfaceAppearance = "RankChampionSA",
        Texture = "rbxassetid://77003517726656",
        Flow = {
            {
                Image = "rbxassetid://81349311863783",
                Transparency = 0.15,
                Tile = 1.4,
                Tint = Color3.fromRGB( 215, 230, 255 ),
                Big = 2
            },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 170, 210, 255 )
            }
        },
        Animated = true,
        FX = "Clan",
        Order = 13.33,
        Event = "Ranked",
        Rank = "Champion",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    RankRuby = {
        name = "Ranked Ruby",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 255, 255, 255 ),
        SurfaceAppearance = "RankRubySA",
        Texture = "rbxassetid://102794810999029",
        Flow = {
            {
                Image = "rbxassetid://99901560164967",
                Transparency = 0,
                Tile = 2.4,
                Tint = Color3.fromRGB( 255, 40, 70 )
            },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 255, 150, 170 )
            },
            {
                Image = "rbxassetid://81349311863783",
                Transparency = 0.15,
                Tile = 1.4,
                Tint = Color3.fromRGB( 255, 200, 215 ),
                Big = 2
            }
        },
        Animated = true,
        FX = "Clan",
        Order = 13.34,
        Event = "Ranked",
        Rank = "Ruby",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    RankDiamond = {
        name = "Ranked Diamond",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 255, 255, 255 ),
        SurfaceAppearance = "RankDiamondSA",
        Texture = "rbxassetid://85045085914516",
        Flow = {
            {
                Image = "rbxassetid://99901560164967",
                Transparency = 0,
                Tile = 2.4,
                Tint = Color3.fromRGB( 90, 200, 255 )
            },
            {
                Image = "rbxassetid://113471010897642",
                ImageTool = "rbxassetid://109836571846256",
                Transparency = 0,
                Tile = 7,
                Tint = Color3.fromRGB( 200, 240, 255 )
            },
            {
                Image = "rbxassetid://81349311863783",
                Transparency = 0.15,
                Tile = 1.4,
                Tint = Color3.fromRGB( 220, 245, 255 ),
                Big = 2
            }
        },
        Animated = true,
        FX = "Clan",
        Order = 13.35,
        Event = "Ranked",
        Rank = "Diamond",
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    RankGold = {
        name = "Ranked Gold",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 255, 255, 255 ),
        SurfaceAppearance = "RankGoldSA",
        Texture = "rbxassetid://82801807680108",
        Glint = true,
        GlintColor = Color3.fromRGB( 255, 232, 160 ),
        Order = 13.36,
        Event = "Ranked",
        Rank = "Gold",
        FlowMinSize = 0.26
    },
    RankSilver = {
        name = "Ranked Silver",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 255, 255, 255 ),
        SurfaceAppearance = "RankSilverSA",
        Texture = "rbxassetid://94394351118630",
        Order = 13.37,
        Event = "Ranked",
        Rank = "Silver",
        FlowMinSize = 0.26
    },
    RankBronze = {
        name = "Ranked Bronze",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 255, 255, 255 ),
        SurfaceAppearance = "RankBronzeSA",
        Texture = "rbxassetid://109840508502028",
        Order = 13.38,
        Event = "Ranked",
        Rank = "Bronze",
        FlowMinSize = 0.26
    },
    Green = {
        name = "Green",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 62, 92, 52 ),
        Order = 14
    },
    Blue = {
        name = "Blue",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 44, 66, 112 ),
        Order = 15
    },
    Yellow = {
        name = "Orange",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 170, 92, 38 ),
        Order = 16
    },
    Pink = {
        name = "Pink",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 160, 86, 118 ),
        Order = 17
    },
    White = {
        name = "Grey",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 150, 150, 152 ),
        Order = 18
    },
    Black = {
        name = "Black",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 22, 22, 24 ),
        Order = 19
    },
    GlossWhite = {
        name = "White Chrome",
        Material = Enum.Material.Foil,
        Color = Color3.fromRGB( 235, 235, 240 ),
        SurfaceAppearance = "GlossWhiteSA",
        Order = 20
    },
    GlossBlack = {
        name = "Black Gloss",
        Material = Enum.Material.Foil,
        Color = Color3.fromRGB( 16, 16, 18 ),
        SurfaceAppearance = "GlossBlackSA",
        Order = 21
    },
    GlossBlue = {
        name = "Blue Gloss",
        Material = Enum.Material.Foil,
        Color = Color3.fromRGB( 40, 95, 230 ),
        SurfaceAppearance = "GlossBlueSA",
        Order = 22
    },
    GlossPurple = {
        name = "Purple Gloss",
        Material = Enum.Material.Foil,
        Color = Color3.fromRGB( 130, 50, 225 ),
        SurfaceAppearance = "GlossPurpleSA",
        Order = 23
    },
    GlossGreen = {
        name = "Green Gloss",
        Material = Enum.Material.Foil,
        Color = Color3.fromRGB( 35, 185, 85 ),
        SurfaceAppearance = "GlossGreenSA",
        Order = 24
    },
    Ruby = {
        name = "Ruby",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 200, 8, 42 ),
        Texture = "rbxassetid://112557705338252",
        SurfaceAppearance = "RubySA",
        Mask = "rbxassetid://86364385611161",
        Order = 3,
        Glint = true,
        GlintColor = Color3.fromRGB( 255, 215, 230 )
    },
    Hyperstar = {
        name = "Hyperstar",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 205, 242, 255 ),
        Texture = "rbxassetid://117872921063910",
        SurfaceAppearance = "HyperstarSA",
        Swatch = "rbxassetid://96773264766991",
        Flow = {
            {
                Image = "rbxassetid://107092247564235",
                Transparency = 0,
                Tile = 1.25
            },
            {
                Image = "rbxassetid://133202172567935",
                Transparency = 0,
                Tile = 1.25
            }
        },
        Animated = true,
        FX = "Hyperstar",
        Order = 0.41,
        Aura = "HyperstarAura",
        Hidden = not IsStudio,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    HyperstarNight = {
        name = "Hyperstar Night",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 18, 28, 95 ),
        Texture = "rbxassetid://134693901907216",
        SurfaceAppearance = "HyperstarNightSA",
        Mask = "rbxassetid://136779693025954",
        Swatch = "rbxassetid://95790414824678",
        Flow = {
            {
                Image = "rbxassetid://139247867626669",
                Transparency = 0,
                Tile = 1.25,
                Bright = 1.8
            },
            { Image = "rbxassetid://77541291888958", Transparency = 0, Tile = 1.25 }
        },
        Animated = true,
        FX = "Hyperstar",
        Order = 0.42,
        Aura = "HyperstarNightAura",
        Hidden = not IsStudio,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    LiquidChrome = {
        name = "Liquid Chrome",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 196, 204, 216 ),
        Texture = "rbxassetid://117630283341882",
        SurfaceAppearance = "LiquidChromeSA",
        Swatch = "rbxassetid://105184035324249",
        Flow = {
            {
                Image = "rbxassetid://113603216357230",
                Transparency = 0,
                Tile = 2.43
            },
            {
                Image = "rbxassetid://131980474734971",
                Transparency = 0,
                Tile = 2.43,
                Bright = 1.6
            }
        },
        Animated = true,
        FX = "Chrome",
        Order = 0.43,
        Aura = "LiquidChromeAura",
        Hidden = not IsStudio,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    Ice = {
        name = "Ice",
        Material = Enum.Material.Ice,
        Color = Color3.fromRGB( 70, 118, 156 ),
        Swatch = "rbxassetid://98413069673122",
        Flow = {
            {
                Image = "rbxassetid://133916792786752",
                Transparency = 0,
                Tile = 1.8,
                Tint = Color3.fromRGB( 120, 105, 150 )
            },
            { Image = "rbxassetid://125725076238019", Transparency = 0, Tile = 1.3 },
            {
                Image = "rbxassetid://118298660289122",
                Transparency = 0,
                Tile = 1.5,
                Tint = Color3.fromRGB( 236, 224, 214 ),
                ThickImages = {
                    "rbxassetid://107782677175235",
                    "rbxassetid://81953413190033",
                    "rbxassetid://118298660289122",
                    "rbxassetid://114663208256425"
                }
            }
        },
        Animated = true,
        FX = "Ice",
        Order = 0.44,
        Hidden = not IsStudio,
        FlowBare = true,
        FlowOrder = true,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    Bubble = {
        name = "Bubble",
        Model = "Bubble",
        Weapons = { M4 = true },
        Color = Color3.fromRGB( 70, 150, 255 ),
        Order = 0.45,
        Pack = "Bubble"
    },
    EventChroma = {
        name = "Chroma",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 0, 200, 255 ),
        Swatch = "rbxassetid://70972888036249",
        Flow = {
            {
                Image = "rbxassetid://120093520676915",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1,
                Vel = Vector2.new( 0.072, 0.036 ),
                Hue = 100
            },
            {
                Image = "rbxassetid://93564101658439",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1,
                Vel = Vector2.new( -0.162, 0.09 ),
                Hue = 50
            }
        },
        Animated = true,
        FX = "EventChroma",
        Order = 0.65,
        Event = "G36Event",
        FlowOrder = true,
        FlowBare = true,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    EventNeon = {
        name = "Plasma",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 14, 15, 18 ),
        SurfaceAppearance = "GlossBlackSA",
        Texture = "rbxassetid://95892399310336",
        Swatch = "rbxassetid://95256631935488",
        Flow = {
            {
                Image = "rbxassetid://95892399310336",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1,
                Vel = Vector2.new( 0.05, -0.02 )
            },
            {
                Image = "rbxassetid://96507383710425",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1.2,
                Vel = Vector2.new( 0.075, -0.035 )
            }
        },
        Animated = true,
        FX = "EventNeon",
        Order = 0.63,
        Event = "G36Event",
        FlowOrder = true,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    EventMagma = {
        name = "Magma",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 14, 15, 18 ),
        SurfaceAppearance = "GlossBlackSA",
        Texture = "rbxassetid://76811103714427",
        Swatch = "rbxassetid://76102025762888",
        Flow = {
            {
                Image = "rbxassetid://76811103714427",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1.12,
                Vel = Vector2.new( 0.072, 0.036 )
            },
            {
                Image = "rbxassetid://92895519693600",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1.32,
                Vel = Vector2.new( -0.162, 0.09 )
            }
        },
        Animated = true,
        FX = "EventMagma",
        Order = 0.67,
        Event = "G36Event",
        Hidden = true,
        FlowOrder = true,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    },
    EventGamma = {
        name = "Gamma",
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB( 14, 15, 18 ),
        SurfaceAppearance = "GlossBlackSA",
        Texture = "rbxassetid://80601340716535",
        Swatch = "rbxassetid://81016062206928",
        Flow = {
            {
                Image = "rbxassetid://80601340716535",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1,
                Vel = Vector2.new( 0.072, 0.036 )
            },
            {
                Image = "rbxassetid://109967516206467",
                Transparency = 0,
                Tile = 1.6,
                Bright = 1.1,
                Vel = Vector2.new( -0.162, 0.09 )
            }
        },
        Animated = true,
        FX = "EventMagma",
        Order = 0.64,
        Event = "G36Event",
        FlowOrder = true,
        FlowFaces = "SidesTop",
        FlowMinSize = 0.26
    }
}
Table.ShotSoundProduct = 3730932895
Table.ShotSounds = {
    Bubble = {
        name = "Bubble",
        Sound = 83810778394486,
        Volume = 0.8,
        FarVolume = 0.6,
        PitchVar = 0.04,
        Color = Color3.fromRGB( 70, 150, 255 ),
        Order = 1,
        Pack = "Bubble"
    },
    Clicky1 = {
        name = "Clicky 1",
        Sound = 74056418801987,
        Volume = 1.75,
        FarVolume = 1.3,
        PitchVar = 0.04,
        Order = 2,
        Paid = true
    },
    Clicky2 = {
        name = "Clicky 2",
        Sound = 76630338692451,
        Volume = 0.8,
        FarVolume = 0.6,
        PitchVar = 0.04,
        Order = 3,
        Paid = true
    },
    Laser1 = {
        name = "Laser 1",
        Sound = 112536422495088,
        Volume = 2.3,
        FarVolume = 1.7,
        PitchVar = 0.04,
        Order = 4,
        Paid = true
    },
    Laser2 = {
        name = "Laser 2",
        Sound = 100106144206819,
        Volume = 1.8,
        FarVolume = 1.35,
        PitchVar = 0.04,
        Order = 5,
        Paid = true
    },
    Retro = {
        name = "Retro",
        Sound = 97900081601585,
        Volume = 2.6,
        FarVolume = 1.95,
        PitchVar = 0.04,
        Order = 6,
        Paid = true,
        Hidden = true
    },
    Muffled = {
        name = "Muffled",
        Sound = 122507842492248,
        Volume = 1.9,
        FarVolume = 1.4,
        PitchVar = 0.04,
        Order = 7,
        Paid = true
    }
}
local ShotSounds = Table.ShotSounds
Value2 = nil

for Key2, Value3 in ShotSounds, nil, nil do
    Value3.id = Key2
end

local Value4

local function FaceTextures( Parent, Name, Texture, Transparency, Amount2, Callback, StudsPerTileV )
    local Table = { }

    for Key, Value in Enum.NormalId:GetEnumItems( ) do
        if not Callback or Callback( Value ) then
            local Texture2 = Instance.new( "Texture" )
            Texture2.Name = Name
            Texture2.Texture = Texture
            Texture2.Face = Value
            local StudsPerTileU = Amount2 or 2.2
            Texture2.StudsPerTileU = StudsPerTileU
            Texture2.StudsPerTileV = StudsPerTileV or Amount2 or 2.2
            Texture2.Transparency = Transparency or 0
            Texture2.Parent = Parent
            table.insert( Table, Texture2 )
        end
    end

    return Table
end

local function FlowTextures( TexturesName, Argument2, Argument3, List )
    if Argument2.FlowMinSize then
        local X = TexturesName.Size.X
        local Y = TexturesName.Size.Y

        if math.max( X, Y, TexturesName.Size.Z ) < Argument2.FlowMinSize then
            return
        end
    end

    local Callback

    if Argument2.FlowFaces ~= "SidesTop" or not Argument3 then
        Callback = nil
    else
        Callback = function( Argument1 )
            local Flag
            local VectorToObjectSpace = Argument3:VectorToObjectSpace( TexturesName.CFrame:VectorToWorldSpace( Vector3.FromNormalId( Argument1 ) ) )

            if math.abs( VectorToObjectSpace.X ) > 0.7 then
                Flag = true
            elseif VectorToObjectSpace.Y > 0.7 then
                Flag = true
            else
                Flag = false
            end

            return Flag
        end
    end
    if not Argument3 and not Callback and Argument2.FX == "Clan" then
        local Text
        local Size = TexturesName.Size

        if not ( Size.X <= Size.Y ) or not ( Size.X <= Size.Z ) then
            if Size.Z <= Size.Y then
                Text = "Z"
            else
                Text = "Y"
            end
        else
            Text = "X"
        end

        local X2 = Size.X + Size.Y + Size.Z
        local X3 = Size.X
        local Y2 = Size.Y
        local X4 = X2 - math.max( X3, Y2, Size.Z ) - Size[ Text ]

        if Size[ Text ] < X4 * 0.5 then
            Callback = function( Argument1 )
                local Flag
                Flag = math.abs( Vector3.FromNormalId( Argument1 )[ Text ] ) > 0.7 and true or false
                return Flag
            end
        end
    end
    if type( Argument2.Flow ) == "string" then
        FaceTextures( TexturesName, "SkinFlow", Argument2.Flow, 0.45, nil, Callback )
        return
    end

    local Flow2
    local Flow = Argument2.Flow
    Flow2 = if Flow then Flow else { }
    local Value1 = nil

    for Key, Value in Flow2, nil, nil do
        if Value.Big then
            if not List or not ( ( List[ TexturesName ] or math.huge ) <= Value.Big ) then
                continue
            end
        end
        if Argument3 then
            if Value.MinHeight or Value.MinLen then
                local ToObjectSpace = Argument3:ToObjectSpace( TexturesName.CFrame )

                local function Ext( Argument1 )
                    local VectorToObjectSpace = ToObjectSpace:VectorToObjectSpace( Argument1 )
                    return math.abs( VectorToObjectSpace.X ) * TexturesName.Size.X + math.abs( VectorToObjectSpace.Y ) * TexturesName.Size.Y + math.abs( VectorToObjectSpace.Z ) * TexturesName.Size.Z
                end

                local VectorToObjectSpace = ToObjectSpace:VectorToObjectSpace( Vector3.new( 0, 1, 0 ) )

                if math.abs( VectorToObjectSpace.X ) * TexturesName.Size.X + math.abs( VectorToObjectSpace.Y ) * TexturesName.Size.Y + math.abs( VectorToObjectSpace.Z ) * TexturesName.Size.Z < ( Value.MinHeight or 0 ) or math.abs( ToObjectSpace:VectorToObjectSpace( Vector3.new( 0, 0, 1 ) ).X ) * TexturesName.Size.X + math.abs( ToObjectSpace:VectorToObjectSpace( Vector3.new( 0, 0, 1 ) ).Y ) * TexturesName.Size.Y + math.abs( ToObjectSpace:VectorToObjectSpace( Vector3.new( 0, 0, 1 ) ).Z ) * TexturesName.Size.Z < ( Value.MinLen or 0 ) then
                    continue
                end
            end
        end
        if Value.Kind == "tag" then
            local Clamp, Text3

            if Argument3 then
                Clamp = 1
                Text3 = "X"
            else
                local Text2
                local Size2 = TexturesName.Size

                if not ( Size2.X <= Size2.Y ) or not ( Size2.X <= Size2.Z ) then
                    if Size2.Z <= Size2.Y then
                        Text2 = "Z"
                    else
                        Text2 = "Y"
                    end
                else
                    Text2 = "X"
                end

                Clamp = math.clamp( Size2.Y / 1.5, 1, 4 )
                Text3 = Text2
            end

            local IsMissing2
            local IsMissing = not Argument3

            if IsMissing then
                if Value.ImageTall == nil then
                    IsMissing2 = false
                else
                    IsMissing2 = true
                end
            else
                IsMissing2 = IsMissing
            end

            local TileV2
            local Tile = Value.Tile * Clamp
            local TileV = Value.TileV
            TileV2 = if TileV then TileV else Value.Tile
            local Number
            local TileV3 = TileV2 * Clamp
            Number = not IsMissing2 and 1 or 3
            local TileV4 = TileV3 * Number

            for Key2, Value2 in Enum.NormalId:GetEnumItems( ) do
                if not ( math.abs( ( Argument3 or TexturesName.CFrame ):VectorToObjectSpace( TexturesName.CFrame:VectorToWorldSpace( Vector3.FromNormalId( Value2 ) ) )[ Text3 ] ) < 0.7 ) then
                    local Position = ( Value2 == Enum.NormalId.Top or Value2 == Enum.NormalId.Bottom ) and Vector3.new( 0, 0, 1 ) or Vector3.new( 0, 1, 0 )
                    local ImageTall
                    local Y3 = ( Argument3 or TexturesName.CFrame ):VectorToObjectSpace( TexturesName.CFrame:VectorToWorldSpace( Position ) ).Y

                    if Y3 > 0.7 then
                        if not IsMissing2 or not Value.ImageTall then
                            local Image = Value.Image

                            if Image then
                                ImageTall = Image
                            elseif Y3 < -0.7 then
                                if not IsMissing2 or not Value.ImageTallFlip then
                                    local ImageFlip = Value.ImageFlip

                                    if ImageFlip then
                                        ImageTall = ImageFlip
                                    else
                                        ImageTall = nil
                                    end
                                else
                                    ImageTall = Value.ImageTallFlip
                                end
                            else
                                ImageTall = nil
                            end
                        else
                            ImageTall = Value.ImageTall
                        end
                    elseif Y3 < -0.7 then
                        if not IsMissing2 or not Value.ImageTallFlip then
                            local ImageFlip = Value.ImageFlip

                            if ImageFlip then
                                ImageTall = ImageFlip
                            else
                                ImageTall = nil
                            end
                        else
                            ImageTall = Value.ImageTallFlip
                        end
                    else
                        ImageTall = nil
                    end
                    if ImageTall then
                        for Key3, Value4 in FaceTextures( TexturesName, "SkinFlow", ImageTall, Value.Transparency, Tile, function( Argument1 )
                            local Flag = Argument1 == Value2 and true or false
                            return Flag
                        end, TileV4 ) do
                            Value4:SetAttribute( "FlowLayer", Key )
                            Value4:SetAttribute( "FlowKind", "tag" )

                            if Y3 < 0 then
                                Value4:SetAttribute( "FlowFlip", true )
                            end

                            local OffsetStudsV = TexturesName:IsA( "MeshPart" ) and TileV4 / 2 or ( TileV4 / 2 - TexturesName.Size.Y / 2 ) % TileV4
                            Value4.OffsetStudsV = OffsetStudsV
                            Value4:SetAttribute( "TagV", Value4.OffsetStudsV )

                            if Value.Glow then
                                local Tint2
                                local Tint = Value.Tint
                                Tint2 = if Tint then Tint else Color3.new( 1, 1, 1 )
                                Value4:SetAttribute( "TagTint", Tint2 )
                                Value4:SetAttribute( "TagGlow", Value.Glow )
                            end
                            if Value.Tint then
                                Value4.Color3 = Value.Tint
                            end
                        end
                    end
                end
            end
        else
            local ImageTool = not Argument3 and Value.ImageTool or Value.Image
            local Transparency = Value.Transparency
            local Tile2 = Value.Tile

            for Key4, Value6 in FaceTextures( TexturesName, "SkinFlow", ImageTool, Transparency, Tile2, Callback, Value.TileV ) do
                Value6:SetAttribute( "FlowLayer", Key )

                if Value.Kind then
                    Value6:SetAttribute( "FlowKind", Value.Kind )
                end
                if Value.Speed then
                    Value6:SetAttribute( "FlowSpeed", Value.Speed )
                end
                if Value.Vel then
                    Value6:SetAttribute( "FlowVel", Value.Vel )
                end
                if Value.Hue then
                    Value6:SetAttribute( "FlowHue", Value.Hue )
                end
                if Value.Bright then
                    Value6:SetAttribute( "FlowBright", Value.Bright )
                end
                if Argument2.FlowOrder then
                    Value6.ZIndex = Key
                end
                if Value.Tint then
                    Value6.Color3 = Value.Tint
                end
                if Value.Bright then
                    local Color32
                    local Tint3 = Value.Tint

                    if Tint3 then
                        Color32 = Tint3
                    else
                        Color32 = Color3.new( 1, 1, 1 )
                    end

                    Value6.Color3 = Color3.new( Color32.R * Value.Bright, Color32.G * Value.Bright, Color32.B * Value.Bright )
                end
                if Value.Thick then
                    local Item2
                    local Size3 = TexturesName.Size
                    local X5 = Size3.X + Size3.Y + Size3.Z
                    local X6 = Size3.X
                    local Y4 = Size3.Y
                    local X7 = X5 - math.max( X6, Y4, Size3.Z )
                    local X8 = Size3.X
                    local Y5 = Size3.Y
                    local X9 = X7 - math.min( X8, Y5, Size3.Z )
                    local Item = Value.Thick[ 1 ] + ( Value.Thick[ 2 ] - Value.Thick[ 1 ] ) * math.clamp( ( X9 - 0.15 ) / 0.35, 0, 1 )
                    Item2 = if not Argument3 or not ( Argument3:VectorToObjectSpace( TexturesName.CFrame:VectorToWorldSpace( Vector3.FromNormalId( Value6.Face ) ) ).Y > 0.7 ) then Item else Item - 0.15
                    Value6.Transparency = math.clamp( Item2, 0, 1 )
                end
                if Value.ThickImages then
                    local Floor2
                    local Size4 = TexturesName.Size
                    local X10 = Size4.X + Size4.Y + Size4.Z
                    local X11 = Size4.X
                    local Y6 = Size4.Y
                    local X12 = X10 - math.max( X11, Y6, Size4.Z )
                    local X13 = Size4.X
                    local Y7 = Size4.Y
                    local X14 = X12 - math.min( X13, Y7, Size4.Z )
                    local Count = #Value.ThickImages
                    local Floor = math.floor( math.clamp( ( X14 - 0.15 ) / 0.35, 0, 1 ) * ( Count - 1 ) + 0.5 ) + 1
                    Floor2 = if not Argument3 or not ( Argument3:VectorToObjectSpace( TexturesName.CFrame:VectorToWorldSpace( Vector3.FromNormalId( Value6.Face ) ) ).Y > 0.7 ) then Floor else Floor - 1
                    Value6.Texture = Value.ThickImages[ math.clamp( Floor2, 1, Count ) ]
                    Value6.Transparency = 0
                end
            end
        end
    end
end

local Table2 = {
    [ Enum.Material.Glass ] = true,
    [ Enum.Material.Neon ] = true,
    [ Enum.Material.ForceField ] = true
}
local Table3 = {
    RocketPart = true,
    Mag = true,
    RoundMag = true,
    Magazine = true,
    [ "Magazine Cartridges" ] = true,
    Bullets = true,
    Iron = true,
    lense = true
}
local Table4 = { [ "PSO-1 Optic" ] = true, Ammunition = true }
local Table5 = {
    Mag = true,
    RoundMag = true,
    Magazine = true,
    [ "Magazine Cartridges" ] = true,
    Bullets = true
}
local Table6 = { Ammunition = true }

local function KeptAccessory( Argument1, Argument2, Argument3 )
    local Flag

    if Argument3 == nil then
        Flag = false
    elseif Argument3.PaintMags == true then
        Flag = true
    else
        Flag = false
    end
    if Table3[ Argument1.Name ] then
        if not Flag or not Table5[ Argument1.Name ] then
            return true
        end
    end

    local Parent = Argument1.Parent

    while Parent do
        if Parent == Argument2 then
            break
        end
        if Table4[ Parent.Name ] then
            if not Flag or not Table6[ Parent.Name ] then
                return true
            end
        end

        Parent = Parent.Parent
    end

    return false
end

Table.Defaults = { }
local WeaponMods = ReplicatedStorage:WaitForChild( "WeaponMods" )
function Table.Mount( Name, Name2 )
    local FoundChild

    if Name then
        FoundChild = WeaponMods:FindFirstChild( Name )
    else
        FoundChild = Name
    end

    local Entry = Table.Items[ Name2 ]

    if Entry then
        local Family = Entry.family
        local Flag

        if ( Name and Table.Forbidden[ Name ] ) == nil then
            Flag = false
        elseif ( Name and Table.Forbidden[ Name ] )[ Family ] == true then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            local Flag2 = if Entry.StudioOnly == true then not IsStudio else false

            if not Flag2 then
                local FoundChild2 = FoundChild and FoundChild:FindFirstChild( Name2 ) or nil
                return FoundChild2
            end
        end
    end

    return nil
end
function Table.SkinFolder( Argument1 )
    if not Argument1 or not Argument1.Model then
        return nil
    end

    local FoundChild2
    local WeaponSkins = ReplicatedStorage:FindFirstChild( "WeaponSkins" )

    if WeaponSkins then
        local FoundChild = WeaponSkins:FindFirstChild( Argument1.Model )

        if FoundChild then
            FoundChild2 = FoundChild
        else
            FoundChild2 = nil
        end
    else
        FoundChild2 = nil
    end

    return FoundChild2
end
function Table.SkinVisual( VisualName, Argument2 )
    local Flag = if type( Argument2 ) == "table" then Table.Skins[ Argument2.Skin or "" ] else false

    if not Flag or not Flag.Model or type( VisualName ) ~= "string" or not Flag.Weapons or not Flag.Weapons[ VisualName ] then
        return nil
    end

    local FoundChild2

    if not Flag or not Flag.Model then
        FoundChild2 = nil
    else
        local WeaponSkins = ReplicatedStorage:FindFirstChild( "WeaponSkins" )

        if WeaponSkins then
            local FoundChild = WeaponSkins:FindFirstChild( Flag.Model )

            if FoundChild then
                FoundChild2 = FoundChild
            else
                FoundChild2 = nil
            end
        else
            FoundChild2 = nil
        end
    end

    local FoundChild3

    if FoundChild2 then
        FoundChild3 = FoundChild2:FindFirstChild( VisualName .. "_" .. Flag.Model )
    else
        FoundChild3 = FoundChild2
    end

    local FoundChild4 = if not FoundChild3 or not FoundChild3:IsA( "Model" ) or not FoundChild3.PrimaryPart or not FoundChild3 then nil else FoundChild3
    return FoundChild4
end
function Table.Available( Name )
    local FoundChild
    local TableInner = { }

    if Name then
        FoundChild = WeaponMods:FindFirstChild( Name )
    else
        FoundChild = Name
    end
    if not FoundChild then
        return TableInner
    end
    for Key, Value in FoundChild:GetChildren( ) do
        local Entry = Table.Items[ Value.Name ]

        if Entry then
            local Family = Entry.family
            local Flag

            if ( Name and Table.Forbidden[ Name ] ) == nil then
                Flag = false
            elseif ( Name and Table.Forbidden[ Name ] )[ Family ] == true then
                Flag = true
            else
                Flag = false
            end
            if not Flag then
                local Flag2 = if Entry.StudioOnly == true then not IsStudio else false

                if not Flag2 then
                    local Entry3
                    local Family2 = Entry.family
                    local Entry2 = TableInner[ Entry.family ]
                    Entry3 = if Entry2 then Entry2 else { }
                    TableInner[ Family2 ] = Entry3
                    local Entry4 = TableInner[ Entry.family ]
                    table.insert( Entry4, Value.Name )
                end
            end
        end
    end

    local Value1 = nil

    for Key2, Value2 in TableInner, nil, nil do
        table.sort( Value2, function( Key, Key2 )
            local Flag = Table.Items[ Key ].name < Table.Items[ Key2 ].name and true or false
            return Flag
        end )
    end

    return TableInner
end
function Table.ClanSkinAllowed( Object, AllowedName )
    local Flag = if type( AllowedName ) == "string" then Table.Skins[ AllowedName ] else false

    if not Flag or not Flag.Clan then
        return false
    end
    if game:GetService( "ReplicatedStorage" ):GetAttribute( "ClanSkinsOn" ) ~= true then
        return false
    end

    local Flag2

    if typeof( Object ) == "Instance" then
        if Object:GetAttribute( "ClanId" ) == Flag.Clan then
            Flag2 = true
        elseif Object:GetAttribute( "DevSkins" ) == true then
            Flag2 = true
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end

    return Flag2
end
function Table.Sanitize( Name, List )
    local TableInner = { }

    if type( List ) ~= "table" then
        return TableInner
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        local Flag = if type( Value ) == "string" then Table.Items[ Value ] else false

        if not FamilyById[ Key ] or not Flag or Flag.family ~= Key or not Table.Mount( Name, Value ) then
            if Key == "Skin" and type( Value ) == "string" and Table.Skins[ Value ] then
                if not Table.Skins[ Value ].Hidden or Table.Skins[ Value ].Clan ~= nil then
                    if not Table.Skins[ Value ].Weapons or Table.Skins[ Value ].Weapons[ Name ] == true then
                        if Name and WeaponMods:FindFirstChild( Name ) then
                            TableInner.Skin = Value
                            continue
                        end
                    end
                end
            end
            if Key == "Sound" and type( Value ) == "string" and Table.ShotSounds[ Value ] and not Table.ShotSounds[ Value ].Hidden and Name and WeaponMods:FindFirstChild( Name ) then
                TableInner.Sound = Value
            end
        else
            TableInner[ Key ] = Value
        end
    end

    return TableInner
end
function Table.Encode( Argument1 )
    return HttpService:JSONEncode( Argument1 or { } )
end
function Table.Decode( Name )
    if type( Name ) ~= "string" or Name == "" then
        return { }
    end

    local Result2
    local Success, Result = pcall( HttpService.JSONDecode, HttpService, Name )
    Result2 = Success and type( Result ) == "table" and Result or { }
    return Result2
end
function Table.BaseModel( Name, ModelName )
    local FoundChild
    local Entry = FamilyById[ ModelName ]

    if Name then
        if Entry then
            local Base = Entry.Base

            if Base then
                FoundChild = ReplicatedStorage.WeaponVisuals:FindFirstChild( Name )
            else
                FoundChild = Base
            end
        else
            FoundChild = Entry
        end
    else
        FoundChild = Name
    end
    if not FoundChild then
        return nil
    end

    local Hides2
    local Table = { }
    local Hides = Entry.Hides
    Hides2 = if Hides then Hides else { }
    local Value1 = nil

    for Key, Value in Hides2, nil, nil do
        Table[ Value ] = true
    end

    local Parent = Instance.new( "Model" )
    Parent.Name = "Base_" .. ModelName

    for Key2, Value2 in FoundChild:GetDescendants( ) do
        if Table[ Value2.Name ] then
            if Value2:IsA( "BasePart" ) or Value2:IsA( "Model" ) then
                local Parent2, Flag
                Parent2 = Value2.Parent

                while Parent2 do
                    if Parent2 == FoundChild then
                        Flag = false
                        break
                    end
                    if Table[ Parent2.Name ] then
                        Flag = true
                        break
                    end
                    Parent2 = Parent2.Parent
                end
                if not Flag then
                    Value2:Clone( ).Parent = Parent
                end
            end
        end
    end
    if Parent:FindFirstChildWhichIsA( "BasePart", true ) then
        return Parent
    end
    Parent:Destroy( )
    return nil
end
function Table.Effects( List )
    local TableInner = { }
    local Value1 = nil

    for Key, Value in List or { }, nil, nil do
        local Effects
        local Entry = Table.Items[ Value ]
        Effects = Entry and Entry.Effects or { }
        local Value2 = nil

        for Key2, Value3 in Effects, nil, nil do
            TableInner[ Key2 ] = Value3
        end
    end

    return TableInner
end
local Table7 = { }
local Table8 = { -1, 1 }
Value4 = nil

for Key3, Value5 in Table8, nil, nil do
    local Value6
    local Table9 = { -1, 1 }
    Value6 = nil

    for Key4, Value7 in Table9, nil, nil do
        local Value8
        local Table10 = { -1, 1 }
        Value8 = nil

        for Key5, Value9 in Table10, nil, nil do
            table.insert( Table7, ( Vector3.new( Value5, Value7, Value9 ) ) )
        end
    end
end

local function AddAura( Parent, Argument2, Part )
    local FoundChild = ReplicatedStorage:WaitForChild( "Weapons" ):FindFirstChild( Argument2.Aura )

    if not FoundChild or not FoundChild:IsA( "BasePart" ) then
        return
    end

    local Part0
    local IsA = Parent:IsA( "Tool" )

    if Part then
        Part0 = Part
    elseif not IsA or not Parent:FindFirstChild( "Handle" ) then
        Part0 = nil
    else
        Part0 = Parent:FindFirstChild( "Handle" )
    end
    if not Part0 or not Part0:IsA( "BasePart" ) then
        return
    end

    local CFrame2 = Part0.CFrame
    local Table = { }
    local Table2 = { }

    for Key, Value in Parent:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            if Value ~= Part0 or IsA then
                if Value.Transparency < 0.99 and Value.Name ~= "SkinAura" then
                    table.insert( Table2, Value )
                    local _, ToOrientation2 = CFrame2:ToObjectSpace( Value.CFrame ):ToOrientation( )
                    local Floor = math.floor( math.deg( ToOrientation2 ) + 0.5 )
                    Table[ Floor ] = ( Table[ Floor ] or 0 ) + Value.Size.Magnitude
                end
            end
        end
    end
    if #Table2 == 0 then
        return
    end

    local Value1, Number, Number4
    Value1 = nil
    Number = 0
    Number4 = -1

    for Key2, Value2 in Table, nil, nil do
        if Number4 < Value2 then
            Number = Key2
            Number4 = Value2
        end
    end

    local Value3
    local CFrame3 = CFrame2 * CFrame.Angles( 0, math.rad( ( Number + 45 ) % 90 - 45 ), 0 )
    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge
    Value3 = nil

    for Key3, Value4 in Table2, nil, nil do
        local Value11
        local ToObjectSpace = CFrame3:ToObjectSpace( Value4.CFrame )
        local Size3 = Value4.Size / 2
        Value11 = nil

        for Key8, Value12 in Table7, nil, nil do
            local ToObjectSpace2 = ToObjectSpace * ( Size3 * Value12 )
            Result = Result:Min( ToObjectSpace2 )
            Result2 = Result2:Max( ToObjectSpace2 )
        end
    end

    local Result3 = Result2 - Result
    local AuraPerPart = FoundChild:GetAttribute( "AuraPerPart" )

    if type( AuraPerPart ) ~= "number" or not ( AuraPerPart >= 1 ) then
        local Vector32, Result4

        if FoundChild:GetAttribute( "AuraFull" ) == true then
            local X4 = Result3.X
            local Max = math.max( X4, Result3.Y )
            local Y2 = Result3.Y
            Vector32 = Vector3.new( Max, Y2, Result3.Z ) * 0.9
            Result4 = ( Result + Result2 ) / 2
        elseif Parent:FindFirstChild( "Muzzle", true ) then
            local X5 = Result3.X * 0.98
            local Y3 = Result3.Y * 0.38
            Vector32 = Vector3.new( X5, Y3, Result3.Z * 0.85 )
            local X6 = ( Result.X + Result2.X ) / 2
            local Y4 = Result.Y + Result3.Y * 0.77
            Result4 = Vector3.new( X6, Y4, ( Result.Z + Result2.Z ) / 2 )
        else
            Vector32 = Result3 * 0.9
            Result4 = ( Result + Result2 ) / 2
        end

        local AuraScale = FoundChild:GetAttribute( "AuraScale" )

        if typeof( AuraScale ) == "Vector3" then
            Vector32 = Vector32 * AuraScale
        end

        local AuraLift = FoundChild:GetAttribute( "AuraLift" )

        if type( AuraLift ) == "number" then
            Result4 = Result4 + Vector3.new( 0, Result3.Y * AuraLift, 0 )
        end

        local Part12 = FoundChild:Clone( )
        Part12.Name = "SkinAura"
        Part12:SetAttribute( "EventFrom", nil )
        Part12:SetAttribute( "Info", nil )
        Part12.Size = Vector32:Max( Vector3.new( 0.05000000074505806, 0.05000000074505806, 0.05000000074505806 ) )
        Part12.CFrame = CFrame3 * CFrame.new( Result4 )
        Part12.Transparency = 1
        Part12.CanCollide = false
        Part12.CanQuery = false
        Part12.CanTouch = false
        Part12.Massless = true
        Part12.CastShadow = false
        local X7 = Vector32.X
        local Y5 = Vector32.Y
        local Clamp2 = math.clamp( math.max( X7, Y5, Vector32.Z ) / 2.946, 0.35, 2.2 )

        for Key7, Value10 in Part12:GetDescendants( ) do
            if Value10:IsA( "ParticleEmitter" ) then
                Value10.Rate = Value10.Rate * Clamp2
            end
        end
        if IsA then
            Part12.Anchored = false
            local WeldConstraint2 = Instance.new( "WeldConstraint" )
            WeldConstraint2.Part0 = Part0
            WeldConstraint2.Part1 = Part12
            WeldConstraint2.Parent = Part12
        else
            Part12.Anchored = Part0.Anchored
        end

        Part12.Parent = Parent
        return
    end
    local Value5
    local Number2 = tonumber( FoundChild:GetAttribute( "AuraPad" ) ) or 0.04

    local function Area( Argument1 )
        return Argument1.X * Argument1.Y + Argument1.Y * Argument1.Z + Argument1.X * Argument1.Z
    end

    local Table3 = { }
    Value5 = nil

    for Key4, Value6 in Table2, nil, nil do
        local Size2 = Value6.Size
        table.insert( Table3, { Value6, Size2.X * Size2.Y + Size2.Y * Size2.Z + Size2.X * Size2.Z } )
    end

    local Number3
    table.sort( Table3, function( List, List2 )
        local Flag
        local Item = List[ 2 ]
        Flag = List2[ 2 ] < Item and true or false
        return Flag
    end )
    local Table4 = { }
    local Min = math.min( AuraPerPart, #Table3 )
    local I = 1
    Number3 = 0

    for I = 1, Min do
        table.insert( Table4, Table3[ I ][ 1 ] )
        Number3 = Number3 + Table3[ I ][ 2 ]
    end

    local Value7, Clone
    local X = Result3.X
    local Y = Result3.Y
    local Clamp = math.clamp( math.max( X, Y, Result3.Z ) * 0.9 / 2.946, 0.35, 2.2 )
    Value7 = nil
    Clone = nil

    for Key5, Value8 in Table4, nil, nil do
        local Name
        local Part1 = FoundChild:Clone( )
        Name = not Clone and "SkinAura" or "SkinAuraBox"
        local X3
        Part1.Name = Name
        Part1:SetAttribute( "EventFrom", nil )
        Part1:SetAttribute( "Info", nil )
        Part1.Size = ( Value8.Size + Vector3.new( 1, 1, 1 ) * Number2 * 2 ):Max( Vector3.new( 0.05000000074505806, 0.05000000074505806, 0.05000000074505806 ) )
        Part1.CFrame = Value8.CFrame
        Part1.Transparency = 1
        Part1.CanCollide = false
        Part1.CanQuery = false
        Part1.CanTouch = false
        Part1.Massless = true
        Part1.CastShadow = false

        if Number3 > 0 then
            local Size = Value8.Size
            local X2 = ( Size.X * Size.Y + Size.Y * Size.Z + Size.X * Size.Z ) / Number3

            if X2 then
                X3 = X2
            else
                X3 = 1 / #Table4
            end
        else
            X3 = 1 / #Table4
        end
        for Key6, Value9 in Part1:GetDescendants( ) do
            if Value9:IsA( "ParticleEmitter" ) then
                Value9.Rate = Value9.Rate * ( Clamp * X3 )
            end
        end
        if IsA then
            Part1.Anchored = false
            local WeldConstraint = Instance.new( "WeldConstraint" )
            WeldConstraint.Part0 = Part0
            WeldConstraint.Part1 = Part1
            WeldConstraint.Parent = Part1
        else
            Part1.Anchored = Part0.Anchored
        end

        Part1.Parent = Clone or Parent
        Clone = Clone or Part1
    end

    return
end

Table.TagSpots = {
    AK = {
        Parts = { "Base" },
        Noire = true,
        Plaques = {
            {
                0.07,
                CFrame.new( 0.1531, 0.2675, -1.2691, 0.9945, -0, -0.1045, 0, 1, 0, 0.1045, -0, 0.9945 )
            },
            {
                0.07,
                CFrame.new( 0.0665, 0.2675, -1.2782, -0.9945, -0, 0.1045, -0, 1, -0, -0.1045, -0, -0.9945 )
            }
        }
    },
    AWP = {
        Parts = {
            { "Union", Vector3.new( 3.2699999809265137, 0.5, 0.1899999976158142 ) }
        },
        Plaques = {
            {
                0.059,
                CFrame.new( 0.0496, 0.1164, -0.5682, 0.9945, 0, -0.1045, 0, 1, 0, 0.1045, -0, 0.9945 )
            },
            {
                0.059,
                CFrame.new( -0.0111, 0.1164, -0.5745, -0.9945, 0, 0.1045, -0, 1, -0, -0.1045, -0, -0.9945 )
            }
        }
    },
    DRAGON = {
        Parts = { "Receiver" },
        Plaques = {
            {
                0.07,
                CFrame.new( 0.1801, 0.2914, -1.3572, 0.9945, -0, -0.1045, 0, 1, 0, 0.1045, -0, 0.9945 )
            },
            {
                0.07,
                CFrame.new( 0.0547, 0.2914, -1.3704, -0.9945, -0, 0.1045, -0, 1, -0, -0.1045, -0, -0.9945 )
            }
        }
    },
    Eagle = {
        Parts = { "Slide", "Barrel" },
        Glisse = true,
        Plaques = {
            { 0.07, CFrame.new( 0.047, 0.27, -0.0547, 1, 0, 0, 0, 1, 0, -0, 0, 1 ) },
            {
                0.07,
                CFrame.new( -0.0461, 0.27, -0.0547, -1, 0, -0, -0, 1, 0, 0, 0, -1 )
            }
        }
    },
    G15 = {
        Parts = { "Slide" },
        Glisse = true,
        Plaques = {
            {
                0.067,
                CFrame.new( 0.0349, 0.2515, -0.2928, 1, -0, -0, 0, 1, 0, 0, -0, 1 )
            },
            {
                0.067,
                CFrame.new( -0.0344, 0.2515, -0.2928, -1, -0, 0, -0, 1, -0, -0, -0, -1 )
            }
        }
    },
    M4 = {
        Parts = { "Reciever", "Top Base", "Dust Cover" },
        Plaques = {
            {
                0.07,
                CFrame.new( 0.0494, 0.2693, -0.4809, 0.9958, -0, -0.0916, 0, 1, 0, 0.0916, -0, 0.9958 )
            },
            {
                0.07,
                CFrame.new( -0.0551, 0.2693, -0.4905, -0.9958, -0, 0.0916, -0, 1, -0, -0.0916, -0, -0.9958 )
            }
        }
    },
    M4A1 = {
        Parts = { "Reciever" },
        Plaques = {
            {
                0.07,
                CFrame.new( 0.1823, 0.318, -0.1528, 0.9945, 0, -0.1045, 0, 1, 0, 0.1045, 0, 0.9945 )
            },
            {
                0.07,
                CFrame.new( -0.0994, 0.318, -0.1824, -0.9945, 0, 0.1045, -0, 1, 0, -0.1045, 0, -0.9945 )
            }
        }
    },
    M60 = {
        Parts = {
            {
                "Receiver",
                Vector3.new( 0.2199999988079071, 0.4099999964237213, 2.200000047683716 )
            }
        },
        Noirs = { "50-Round Ammunition Container" },
        Plaques = {
            {
                0.07,
                CFrame.new( 0.0674, 0.2825, -0.2776, 0.9946, -0, -0.1036, 0, 1, 0, 0.1036, -0, 0.9946 )
            },
            {
                0.07,
                CFrame.new( -0.0845, 0.2825, -0.2934, -0.9946, -0, 0.1036, -0, 1, -0, -0.1036, -0, -0.9946 )
            }
        }
    },
    M9 = {
        Parts = {
            {
                "Slide",
                Vector3.new( 0.11999999731779099, 0.18000000715255737, 0.8500000238418579 )
            },
            {
                "Slide",
                Vector3.new( 0.15000000596046448, 0.07999999821186066, 0.28999999165534973 )
            },
            "Barrel"
        },
        Glisse = true,
        Plaques = {
            {
                0.068,
                CFrame.new( 0.0347, 0.2578, 0.0071, 1, 0, 0, 0, 1, 0, -0, 0, 1 )
            },
            {
                0.068,
                CFrame.new( -0.0355, 0.2578, 0.0071, -1, 0, -0, -0, 1, 0, 0, 0, -1 )
            }
        }
    },
    MK14 = {
        Parts = { "Chassis", "Receiver" },
        Noire = true,
        Plaques = {
            {
                0.07,
                CFrame.new( 0.1769, 0.1647, -1.1976, 0.9945, -0, -0.1045, 0, 1, 0, 0.1045, -0, 0.9945 )
            },
            {
                0.07,
                CFrame.new( 0.0523, 0.1647, -1.2107, -0.9945, -0, 0.1045, -0, 1, -0, -0.1045, -0, -0.9945 )
            }
        }
    },
    MP5 = {
        Parts = { "Receiver" },
        Plaques = {
            {
                0.07,
                CFrame.new( 0.0724, 0.27, -0.1783, 0.9945, -0, -0.1045, 0, 1, 0, 0.1045, -0, 0.9945 )
            },
            {
                0.07,
                CFrame.new( -0.056, 0.27, -0.1919, -0.9945, -0, 0.1045, -0, 1, -0, -0.1045, -0, -0.9945 )
            }
        }
    },
    RPG = {
        Parts = { "Handle" },
        Plaques = {
            {
                0.07,
                CFrame.new( 0.1712, 0.5795, 1.267, 1, 0, 0, 0, 1, 0, -0, 0, 1 )
            },
            {
                0.07,
                CFrame.new( -0.1063, 0.5795, 1.267, -1, 0, -0, -0, 1, 0, 0, 0, -1 )
            }
        }
    },
    SPAS12 = {
        Parts = { "gun.026" },
        Plaques = {
            {
                0.07,
                CFrame.new( 0.0317, 0.179, -0.4335, 0.9945, -0, -0.1045, 0, 1, 0, 0.1045, -0, 0.9945 )
            },
            {
                0.07,
                CFrame.new( -0.0576, 0.179, -0.4429, -0.9945, -0, 0.1045, -0, 1, -0, -0.1045, -0, -0.9945 )
            }
        }
    },
    SawedOff = {
        Parts = { "Receiver" },
        Plaques = {
            {
                0.064,
                CFrame.new( 0.0584, 0.0982, -0.5018, 0.9945, 0, -0.1045, 0, 1, 0, 0.1045, 0, 0.9945 )
            },
            {
                0.064,
                CFrame.new( -0.007, 0.0982, -0.5087, -0.9945, 0, 0.1045, -0, 1, 0, -0.1045, 0, -0.9945 )
            }
        }
    },
    Uzi = {
        Parts = { "Body" },
        Noire = true,
        Plaques = {
            {
                0.07,
                CFrame.new( 0.065, 0.2683, -0.2397, 1, 0, -0, 0, 1, 0, 0, 0, 1 )
            },
            {
                0.07,
                CFrame.new( -0.0648, 0.2683, -0.2397, -1, 0, 0, -0, 1, 0, -0, 0, -1 )
            }
        }
    },
    Bayonneta = {
        Parts = { "Lame" },
        Sur = "Lame",
        Plaques = {
            {
                0.013,
                CFrame.new( 0.0073, -0.012, -0.1584, 1, 0, 0, 0, 1, -0, 0, -0, 1 )
            },
            {
                0.013,
                CFrame.new( -0.0072, -0.012, -0.1584, -1, 0, 0, -0, 1, 0, -0, -0, -1 )
            }
        }
    },
    RiotShield = {
        Parts = { "Handle" },
        Direct = {
            Face = Enum.NormalId.Front,
            P = Vector3.new( -0.03200000151991844, 0.4000000059604645, 0.019999999552965164 ),
            Tuile = 7.446
        }
    },
    Baton = { Parts = { "Baton" } },
    Batte = { Parts = { "Corps" } },
    BrassKnuckle = { Parts = { "Knuckle" } },
    Crowbar = { Parts = { "Crowbar" } },
    MetalPipe = { Parts = { "Pipe" } },
    Shovel = { Parts = { "Blade" } }
}

local function TagCouleur( Parent, Color, Name )
    local FoundChild
    Parent.Color = Color

    if Name then
        local IsA = Parent:IsA( "MeshPart" )

        if IsA then
            FoundChild = ReplicatedStorage:WaitForChild( "Weapons" ):FindFirstChild( Name )
        else
            FoundChild = IsA
        end
    else
        FoundChild = Name
    end
    if FoundChild then
        for Key, Value in Parent:GetChildren( ) do
            if Value:IsA( "SurfaceAppearance" ) then
                Value:Destroy( )
            end
        end

        Parent.Material = Enum.Material.SmoothPlastic
        Parent.Color = Color3.new( 1, 1, 1 )
        Parent.TextureID = ""
        FoundChild:Clone( ).Parent = Parent
    end
end

local function TagTrouve( Object, List )
    local Item = type( List ) == "table" and List[ 1 ] or List
    local Item2 = type( List ) == "table" and List[ 2 ] or nil
    local Value1, Number
    Value1 = nil
    Number = math.huge

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Name == Item then
            local Magnitude2

            if Item2 then
                local Magnitude = ( Value.Size - Item2 ).Magnitude

                if Magnitude then
                    Magnitude2 = Magnitude
                else
                    Magnitude2 = 0
                end
            else
                Magnitude2 = 0
            end
            if Magnitude2 < Number then
                Value1 = Value
                Number = Magnitude2
            end
        end
    end

    return Value1
end

local function TagCouleurs( Object, Argument2, Argument3 )
    local Parts = not Argument3.Mono and Argument2.Parts or { }
    local Value1 = nil

    for Key, Value in Parts, nil, nil do
        local TagTrouve3 = TagTrouve( Object, Value )

        if TagTrouve3 then
            TagCouleur( TagTrouve3, Argument3.Color2, Argument3.SurfaceAppearance2 )

            for Key3, Value6 in TagTrouve3:GetChildren( ) do
                if not Value6:IsA( "Texture" ) or Value6.Name ~= "SkinFlow" then
                    if not Value6:IsA( "Texture" ) or Value6.Name ~= "SkinBase" or not Argument3.Color2 then
                        if Value6:IsA( "SpecialMesh" ) and Argument3.FX == "Clan" and Argument3.Color2 then
                            local R = Argument3.Color2.R
                            local G = Argument3.Color2.G
                            Value6.VertexColor = Vector3.new( R, G, Argument3.Color2.B )
                        end
                    else
                        Value6.Color3 = Argument3.Color2
                    end
                else
                    local Flag = if type( Argument3.Flow ) == "table" then Argument3.Flow[ Value6:GetAttribute( "FlowLayer" ) or 0 ] else false

                    if Flag and Flag.Tint2 then
                        Value6.Color3 = Flag.Tint2
                    end
                end
            end
        end
    end

    local Noirs2
    local Noirs = Argument2.Noirs
    Noirs2 = if Noirs then Noirs else { }
    local Value2 = nil

    for Key2, Value3 in Noirs2, nil, nil do
        local TagTrouve2 = TagTrouve( Object, Value3 )

        if TagTrouve2 then
            TagCouleur( TagTrouve2, Argument3.Color, Argument3.SurfaceAppearance )
        end
    end
end

local function TagPlaques( Parent, Part, Argument3, Argument4 )
    local Plaques2
    local Plaques = Argument3.Plaques
    Plaques2 = if Plaques then Plaques else { }
    local Value1 = nil

    for Key, Value in Plaques2, nil, nil do
        local Color
        local Parent2 = Instance.new( "Part" )
        Parent2.Name = "TagPlaque"
        Parent2.Size = Vector3.new( Value[ 1 ], 0.1327, 0.3 )
        Parent2.Material = Enum.Material.SmoothPlastic
        Parent2.MaterialVariant = "GlossPlaque"
        Color = Argument3.Noire and Argument4.Plaque1 or Argument4.Plaque2
        local Text
        Parent2.Color = Color
        Parent2.CanCollide = false
        Parent2.CanTouch = false
        Parent2.CanQuery = false
        Parent2.CastShadow = false
        Parent2.Massless = true
        Parent2.Anchored = Part.Anchored
        Parent2.CFrame = Part.CFrame * Value[ 2 ]
        Text = not Argument3.Glisse and "Tag" or "TagSlide"
        Parent2:SetAttribute( "ModFamily", Text )

        if Argument4.TagGui then
            local TagColor2
            local Parent3 = Instance.new( "SurfaceGui" )
            Parent3.Name = "Tag"
            Parent3.Face = Enum.NormalId.Right
            Parent3.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
            Parent3.PixelsPerStud = 500
            Parent3.LightInfluence = 0
            Parent3.Brightness = 1.6
            Parent3.MaxDistance = 120
            local Parent4 = Instance.new( "TextLabel" )
            Parent4.Name = "Texte"
            Parent4.BackgroundTransparency = 1
            Parent4.Size = UDim2.fromScale( 0.98, 1 )
            Parent4.AnchorPoint = Vector2.new( 0.5, 0.5 )
            Parent4.Position = UDim2.fromScale( 0.5, 0.5 )
            Parent4.Text = "[" .. ( Argument4.TagText or "TAG" ) .. "]"
            Parent4.TextScaled = true
            Parent4.FontFace = Font.new( "rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold )
            Parent4.TextColor3 = Color3.new( 1, 1, 1 )
            local TagColor = Argument4.TagColor

            if TagColor then
                TagColor2 = TagColor
            else
                local Color2 = Argument4.Color2

                if Color2 then
                    TagColor2 = Color2
                else
                    TagColor2 = Argument4.Color
                end
            end

            local Lerp = TagColor2:Lerp( Color3.new( 1, 1, 1 ), 0.75 )
            local UIGradient = Instance.new( "UIGradient" )
            UIGradient.Color = ColorSequence.new( {
                ColorSequenceKeypoint.new( 0, TagColor2 ),
                ColorSequenceKeypoint.new( 0.38, TagColor2 ),
                ColorSequenceKeypoint.new( 0.5, Lerp ),
                ColorSequenceKeypoint.new( 0.62, TagColor2 ),
                ColorSequenceKeypoint.new( 1, TagColor2 )
            } )
            UIGradient.Rotation = 20
            UIGradient.Offset = Vector2.new( -1, 0 )
            UIGradient:AddTag( "ClanTagSweep" )
            UIGradient.Parent = Parent4
            Parent4.Parent = Parent3
            Parent3.Parent = Parent2
        else
            local Color32
            local Decal = Instance.new( "Decal" )
            Decal.Name = "Tag"
            Decal.Face = Enum.NormalId.Right
            Decal.Texture = Argument4.Tag
            local TagColor3 = Argument4.TagColor

            if TagColor3 then
                Color32 = TagColor3
            elseif not Argument3.Noire or not Argument4.Color2 then
                Color32 = Argument4.Color
            else
                Color32 = Argument4.Color2
            end

            Decal.Color3 = Color32
            Decal.Parent = Parent2
        end
        if not Part.Anchored then
            local Weld = Instance.new( "Weld" )
            local C0 = Value[ 2 ]
            Weld.Part0 = Part
            Weld.Part1 = Parent2
            Weld.C0 = C0
            Weld.Parent = Parent2
        end

        Parent2.Parent = Parent
    end
end

local function AddTag( Model, TagName, Argument3 )
    local Tag2
    local Tag = Argument3.Tag
    Tag2 = if Tag then Table.TagSpots[ TagName ] else Tag

    if not Tag2 or not Model.PrimaryPart then
        return
    end

    TagCouleurs( Model, Tag2, Argument3 )

    if Argument3.NoPlaque then
        return
    end
    TagPlaques( Model, Model.PrimaryPart, Tag2, Argument3 )
    return
end

local function AddToolTag( Object2, Argument2 )
    local Tag2
    local Tag = Argument2.Tag
    Tag2 = if Tag then Table.TagSpots[ Object2.Name ] else Tag

    if not Tag2 then
        return
    end

    TagCouleurs( Object2, Tag2, Argument2 )

    if Argument2.NoPlaque then
        return
    end

    local FoundChild
    local Sur = Tag2.Sur

    if Sur then
        FoundChild = Object2:FindFirstChild( Tag2.Sur, true )
    else
        FoundChild = Sur
    end
    if FoundChild then
        TagPlaques( Object2, FoundChild, Tag2, Argument2 )
    end

    local Parent
    local Direct = Tag2.Direct

    if Direct then
        Parent = TagTrouve( Object2, Tag2.Parts[ 1 ] )
    else
        Parent = Direct
    end
    if Parent then
        local Color3
        local Texture = Instance.new( "Texture" )
        Texture.Name = "SkinTag"
        Texture.Face = Direct.Face
        Texture.Texture = Argument2.TagDirect
        local TagColor = Argument2.TagColor
        Color3 = if TagColor then TagColor else Argument2.Color
        Texture.Color3 = Color3
        local StudsPerTileU = Direct.Tuile
        local StudsPerTileV = Direct.Tuile
        Texture.StudsPerTileU = StudsPerTileU
        Texture.StudsPerTileV = StudsPerTileV
        local OffsetStudsU = ( Direct.Tuile / 2 + Direct.P.X ) % Direct.Tuile
        local OffsetStudsV = ( Direct.Tuile / 2 + Direct.P.Y ) % Direct.Tuile
        Texture.OffsetStudsU = OffsetStudsU
        Texture.OffsetStudsV = OffsetStudsV
        Texture.Parent = Parent
    end
end

local function PaintSkin( Parent, Argument2, Part )
    local Table3

    if type( Argument2.Flow ) == "table" then
        local Value1, Flag
        local Flow = Argument2.Flow
        Value1 = nil
        Flag = false

        for Key, Value in Flow, nil, nil do
            if Value.Big then
                Flag = true
            end
        end
        if Flag then
            local Table = { }

            for Key2, Value2 in Parent:GetDescendants( ) do
                if Value2:IsA( "BasePart" ) and Value2 ~= Part and Value2.Transparency < 0.99 and not Table2[ Value2.Material ] and not KeptAccessory( Value2, Parent, Argument2 ) then
                    if Argument2.FlowMinSize then
                        local X = Value2.Size.X
                        local Y = Value2.Size.Y

                        if math.max( X, Y, Value2.Size.Z ) < Argument2.FlowMinSize then
                            continue
                        end
                    end

                    local Abs2

                    if Part and Part.CFrame then
                        local ToObjectSpace = ( Part and Part.CFrame ):ToObjectSpace( Value2.CFrame )

                        local function Ext( Argument1 )
                            local VectorToObjectSpace = ToObjectSpace:VectorToObjectSpace( Argument1 )
                            return math.abs( VectorToObjectSpace.X ) * Value2.Size.X + math.abs( VectorToObjectSpace.Y ) * Value2.Size.Y + math.abs( VectorToObjectSpace.Z ) * Value2.Size.Z
                        end

                        local VectorToObjectSpace = ToObjectSpace:VectorToObjectSpace( Vector3.new( 0, 1, 0 ) )
                        local Abs = math.abs( VectorToObjectSpace.X ) * Value2.Size.X + math.abs( VectorToObjectSpace.Y ) * Value2.Size.Y + math.abs( VectorToObjectSpace.Z ) * Value2.Size.Z
                        local VectorToObjectSpace2 = ToObjectSpace:VectorToObjectSpace( Vector3.new( 0, 0, 1 ) )
                        Abs2 = Abs * ( math.abs( VectorToObjectSpace2.X ) * Value2.Size.X + math.abs( VectorToObjectSpace2.Y ) * Value2.Size.Y + math.abs( VectorToObjectSpace2.Z ) * Value2.Size.Z )
                    else
                        local Size = Value2.Size
                        local X2 = Size.X * Size.Y
                        local Y2 = Size.Y * Size.Z
                        Abs2 = math.max( X2, Y2, Size.X * Size.Z )
                    end

                    table.insert( Table, { Value2, Abs2 } )
                end
            end

            local Value3
            table.sort( Table, function( List, List2 )
                local Flag
                local Item = List[ 2 ]
                Flag = List2[ 2 ] < Item and true or false
                return Flag
            end )
            local Table2Inner = { }
            Value3 = nil

            for Key3, Value4 in Table, nil, nil do
                Table2Inner[ Value4[ 1 ] ] = Key3
                Table3 = Table2Inner
            end

            Table3 = Table2Inner
        else
            Table3 = nil
        end
    else
        Table3 = nil
    end
    for Key4, Value5 in Parent:GetDescendants( ) do
        if Value5:IsA( "BasePart" ) and Value5 ~= Part and Value5.Transparency < 0.99 and not Table2[ Value5.Material ] and not KeptAccessory( Value5, Parent, Argument2 ) then
            local Material = Argument2.Material
            local Color = Argument2.Color
            Value5.Material = Material
            Value5.Color = Color
            Value5.MaterialVariant = ""

            if Value5:IsA( "MeshPart" ) then
                Value5.TextureID = Argument2.Texture or ""
            end

            local FoundChild
            local SurfaceAppearance = Argument2.SurfaceAppearance

            if SurfaceAppearance then
                local IsA = Value5:IsA( "MeshPart" )

                if IsA then
                    FoundChild = ReplicatedStorage:WaitForChild( "Weapons" ):FindFirstChild( Argument2.SurfaceAppearance )
                else
                    FoundChild = IsA
                end
            else
                FoundChild = SurfaceAppearance
            end
            if FoundChild then
                local Color2 = Color3.new( 1, 1, 1 )
                Value5.Material = Enum.Material.SmoothPlastic
                Value5.Color = Color2
                Value5.TextureID = ""

                for Key5, Value6 in Value5:GetChildren( ) do
                    if Value6:IsA( "SurfaceAppearance" ) then
                        Value6:Destroy( )
                    end
                end

                FoundChild:Clone( ).Parent = Value5

                if Argument2.Flow then
                    FlowTextures( Value5, Argument2, Part and Part.CFrame, Table3 )
                end
                if Argument2.Animated then
                    Value5:SetAttribute( "SkinFX", Argument2.FX )
                    Value5:AddTag( "SkinFX" )
                end
            elseif not Argument2.FlowBare or not Value5:IsA( "MeshPart" ) then
                if Argument2.Texture and not Value5:IsA( "MeshPart" ) and Argument2.Material ~= Enum.Material.ForceField then
                    for Key6, Value7 in Value5:GetChildren( ) do
                        if Value7:IsA( "Texture" ) then
                            if Value7.Name == "SkinBase" or Value7.Name == "SkinFlow" then
                                Value7:Destroy( )
                            end
                        end
                    end

                    local FaceTextures2 = FaceTextures( Value5, "SkinBase", Argument2.Texture, 0 )

                    if Argument2.FX == "Clan" then
                        local Value9 = nil

                        for Key7, Value10 in FaceTextures2, nil, nil do
                            Value10.Color3 = Argument2.Color
                        end
                    end
                    if Argument2.Flow then
                        FlowTextures( Value5, Argument2, Part and Part.CFrame, Table3 )
                    end
                    if Argument2.Animated then
                        Value5:SetAttribute( "SkinFX", Argument2.FX )
                        Value5:AddTag( "SkinFX" )
                    end
                end
            else
                if Argument2.Flow then
                    FlowTextures( Value5, Argument2, Part and Part.CFrame, Table3 )
                end
                if Argument2.Animated then
                    Value5:SetAttribute( "SkinFX", Argument2.FX )
                    Value5:AddTag( "SkinFX" )
                end
            end
            if Value5:IsA( "UnionOperation" ) then
                Value5.UsePartColor = true
            end
            if Argument2.Glint then
                Value5:SetAttribute( "GlintColor", Argument2.GlintColor )
                Value5:AddTag( "SkinGlint" )
            end
            for Key8, Value11 in Value5:GetChildren( ) do
                if Value11:IsA( "SurfaceAppearance" ) and Value11.Name ~= Argument2.SurfaceAppearance then
                    Value11:Destroy( )
                end
                if Value11:IsA( "SpecialMesh" ) then
                    Value11.TextureId = Argument2.Texture or ""

                    if Value11:GetAttribute( "SkinOrigVertex" ) == nil then
                        Value11:SetAttribute( "SkinOrigVertex", Value11.VertexColor )
                    end
                    if Argument2.FX == "Clan" then
                        local R = Argument2.Color.R
                        local G = Argument2.Color.G
                        Value11.VertexColor = Vector3.new( R, G, Argument2.Color.B )
                    else
                        Value11.VertexColor = Value11:GetAttribute( "SkinOrigVertex" )
                    end
                end
            end
        end
    end
    if Argument2.Aura then
        AddAura( Parent, Argument2, Part )
    end
end

function Table.Apply( Model, Key, List )
    local Entry

    if List and Table.Skins[ List.Skin or "" ] then
        local Model2 = ( List and Table.Skins[ List.Skin or "" ] ).Model

        if Model2 then
            if Model:GetAttribute( "SkinShot" ) == nil then
                Entry = false
            elseif not ( List and Table.Skins[ List.Skin or "" ] ) or not ( List and Table.Skins[ List.Skin or "" ] ).Model then
                Entry = nil
            else
                local WeaponSkins = ReplicatedStorage:FindFirstChild( "WeaponSkins" )

                if WeaponSkins then
                    local FoundChild = WeaponSkins:FindFirstChild( ( List and Table.Skins[ List.Skin or "" ] ).Model )

                    if FoundChild then
                        Entry = FoundChild
                    else
                        Entry = nil
                    end
                else
                    Entry = nil
                end
            end
        else
            Entry = Model2
        end
    else
        Entry = List and Table.Skins[ List.Skin or "" ]
    end

    local Mods = Entry and Entry:FindFirstChild( "Mods" ) or nil

    if List and Table.Skins[ List.Skin or "" ] and not ( List and Table.Skins[ List.Skin or "" ] ).Model then
        local Tag2
        PaintSkin( Model, List and Table.Skins[ List.Skin or "" ], Model.PrimaryPart )
        local Tag = ( List and Table.Skins[ List.Skin or "" ] ).Tag
        Tag2 = if Tag then Table.TagSpots[ Key ] else Tag

        if Tag2 then
            if Model.PrimaryPart then
                TagCouleurs( Model, Tag2, List and Table.Skins[ List.Skin or "" ] )

                if not ( List and Table.Skins[ List.Skin or "" ] ).NoPlaque then
                    TagPlaques( Model, Model.PrimaryPart, Tag2, List and Table.Skins[ List.Skin or "" ] )
                end
            end
        end
    end

    local TableInner = { }
    local Value1 = nil

    for Key2, Value in List or { }, nil, nil do
        local Entry4
        local Entry3 = FamilyById[ Key2 ]
        Entry4 = if Entry3 then Table.Mount( Key, Value ) else Entry3

        if Entry4 then
            local Hides2
            local Hides = FamilyById[ Key2 ].Hides
            Hides2 = if Hides then Hides else { }
            local Value15 = nil

            for Key12, Value16 in Hides2, nil, nil do
                TableInner[ Value16 ] = true
            end

            local HidesByWeapon2
            local HidesByWeapon = FamilyById[ Key2 ].HidesByWeapon
            HidesByWeapon2 = if HidesByWeapon then HidesByWeapon else { }
            local Entry6
            local Entry5 = HidesByWeapon2[ Key ]
            Entry6 = if Entry5 then Entry5 else { }
            local Value17 = nil

            for Key13, Value18 in Entry6, nil, nil do
                TableInner[ Value18 ] = true
            end
        end
    end
    if next( TableInner ) then
        for Key3, Value2 in Model:GetDescendants( ) do
            if Value2.Parent then
                if Value2:IsA( "BasePart" ) or Value2:IsA( "Model" ) then
                    if TableInner[ Value2.Name ] and Value2 ~= Model.PrimaryPart then
                        Value2:Destroy( )
                    end
                end
            end
        end
    end
    if Mods then
        for Key4, Value3 in Model:GetDescendants( ) do
            local HiddenBy
            local Parent = Value3.Parent

            if Parent then
                local IsA = Value3:IsA( "BasePart" )

                if IsA then
                    if Value3 == Model.PrimaryPart then
                        HiddenBy = false
                    else
                        HiddenBy = Value3:GetAttribute( "HiddenBy" )
                    end
                else
                    HiddenBy = IsA
                end
            else
                HiddenBy = Parent
            end
            if HiddenBy and List[ HiddenBy ] then
                local Mount = Table.Mount

                if Mount( Key, List[ HiddenBy ] ) then
                    Value3:Destroy( )
                end
            end
        end
    end

    local Value4 = nil

    for Key5, Value5 in List or { }, nil, nil do
        local Mount2
        local Entry2 = FamilyById[ Key5 ]

        if Entry2 then
            Mount2 = Table.Mount( Key, Value5 )
        else
            Mount2 = Entry2
        end
        if Mount2 and Mods then
            Mount2 = Mods:FindFirstChild( Value5 ) or Mount2
        end
        if Mount2 then
            local Clone = Mount2:Clone( )
            Clone.Name = "Mod_" .. Value5

            for Key11, Value14 in Clone:GetDescendants( ) do
                if Value14:IsA( "BasePart" ) then
                    Value14:SetAttribute( "ModFamily", Key5 )
                end
            end

            Clone.Parent = Model
        end
    end
    if Mods and List and List.Muzzle then
        local FoundChild2 = Model:FindFirstChild( "Mod_" .. tostring( List.Muzzle ) )

        if FoundChild2 then
            for Key6, Value6 in Model:GetDescendants( ) do
                if Value6:IsA( "Attachment" ) then
                    if Value6.Name == "Bulles" or Value6.Name:sub( 1, 11 ) == "MuzzleFlash" then
                        if not Value6:IsDescendantOf( FoundChild2 ) then
                            local Number
                            local UpVector = Value6.WorldCFrame.UpVector
                            local WorldPosition = Value6.WorldPosition
                            Number = -math.huge

                            for Key7, Value7 in FoundChild2:GetDescendants( ) do
                                if Value7:IsA( "BasePart" ) and Value7.Transparency < 0.95 then
                                    local Value8
                                    local Size = Value7.Size / 2
                                    local Table2 = { -1, 1 }
                                    Value8 = nil

                                    for Key8, Value9 in Table2, nil, nil do
                                        local Value10
                                        local Table3 = { -1, 1 }
                                        Value10 = nil

                                        for Key9, Value11 in Table3, nil, nil do
                                            local Value12
                                            local Table4 = { -1, 1 }
                                            Value12 = nil

                                            for Key10, Value13 in Table4, nil, nil do
                                                local CFrame = Value7.CFrame
                                                local X = Value9 * Size.X
                                                local Y = Value11 * Size.Y
                                                Number = math.max( Number, ( CFrame * Vector3.new( X, Y, Value13 * Size.Z ) - WorldPosition ):Dot( UpVector ) )
                                            end
                                        end
                                    end
                                end
                            end
                            if Number > -math.huge then
                                Value6.WorldPosition = WorldPosition + UpVector * Number
                            end
                        end
                    end
                end
            end
        end
    end

    return Model
end

local function SaveOrigin( Parent )
    Parent:SetAttribute( "SkinOrigMaterial", Parent.Material.Name )
    Parent:SetAttribute( "SkinOrigColor", Parent.Color )
    Parent:SetAttribute( "SkinOrigVariant", Parent.MaterialVariant )

    if Parent:IsA( "MeshPart" ) then
        Parent:SetAttribute( "SkinOrigTexture", Parent.TextureID )
    end

    local Parent2 = Instance.new( "Folder" )
    Parent2.Name = "SkinOrigine"

    for Key, Value in Parent:GetChildren( ) do
        if Value:IsA( "SurfaceAppearance" ) then
            Value:Clone( ).Parent = Parent2
        end
    end

    Parent2.Parent = Parent
end

local function RestoreOrigin( Parent )
    for Key, Value in Parent:GetChildren( ) do
        if not Value:IsA( "SurfaceAppearance" ) then
            if not Value:IsA( "Texture" ) then
                continue
            end
            if Value.Name ~= "SkinBase" and Value.Name ~= "SkinFlow" and Value.Name ~= "SkinTag" then
                continue
            end
        end

        Value:Destroy( )
    end

    local Material
    local Entry = Enum.Material[ Parent:GetAttribute( "SkinOrigMaterial" ) ]
    Material = if Entry then Entry else Parent.Material
    local Color
    Parent.Material = Material
    local SkinOrigColor = Parent:GetAttribute( "SkinOrigColor" )
    Color = if SkinOrigColor then SkinOrigColor else Parent.Color
    Parent.Color = Color
    Parent.MaterialVariant = Parent:GetAttribute( "SkinOrigVariant" ) or ""

    if Parent:IsA( "MeshPart" ) and Parent:GetAttribute( "SkinOrigTexture" ) ~= nil then
        Parent.TextureID = Parent:GetAttribute( "SkinOrigTexture" )
    end

    local Children
    local SkinOrigine = Parent:FindFirstChild( "SkinOrigine" )
    Children = SkinOrigine and SkinOrigine:GetChildren( ) or { }
    local Value1 = nil

    for Key2, Value2 in Children, nil, nil do
        Value2:Clone( ).Parent = Parent
    end
    for Key3, Value3 in Parent:GetChildren( ) do
        if Value3:IsA( "SpecialMesh" ) and typeof( Value3:GetAttribute( "SkinOrigVertex" ) ) == "Vector3" then
            Value3.VertexColor = Value3:GetAttribute( "SkinOrigVertex" )
        end
    end

    Parent:RemoveTag( "SkinFX" )
    Parent:SetAttribute( "SkinFX", nil )
    Parent:RemoveTag( "SkinGlint" )
    Parent:SetAttribute( "GlintColor", nil )
end

function Table.SkinTool( Parent, Argument2 )
    for Key, Value in Parent:GetDescendants( ) do
        if Value.Name == "SkinAura" or Value.Name == "TagPlaque" then
            if Value:IsA( "BasePart" ) then
                Value:Destroy( )
            end
        end
    end
    for Key2, Value2 in Parent:GetDescendants( ) do
        if Value2:IsA( "BasePart" ) then
            if Value2:GetAttribute( "SkinOrigMaterial" ) == nil then
                SaveOrigin( Value2 )
            else
                RestoreOrigin( Value2 )
            end
        end
    end
    if Argument2 and Table.Skins[ Argument2.Skin or "" ] then
        PaintSkin( Parent, Argument2 and Table.Skins[ Argument2.Skin or "" ], nil )
        AddToolTag( Parent, Argument2 and Table.Skins[ Argument2.Skin or "" ] )
    end
end
return Table
