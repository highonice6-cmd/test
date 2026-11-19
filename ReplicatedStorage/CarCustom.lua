-- ReplicatedStorage.CarCustom
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = {
    RARITIES = {
        common = {
            Name = "COMMON",
            Color = Color3.fromRGB( 150, 150, 165 ),
            Weight = 40,
            Order = 1
        },
        uncommon = {
            Name = "UNCOMMON",
            Color = Color3.fromRGB( 70, 200, 95 ),
            Weight = 25,
            Order = 2
        },
        rare = {
            Name = "RARE",
            Color = Color3.fromRGB( 45, 125, 220 ),
            Weight = 14,
            Order = 3
        },
        epic = {
            Name = "EPIC",
            Color = Color3.fromRGB( 165, 70, 225 ),
            Weight = 7,
            Order = 4
        },
        legendary = {
            Name = "LEGENDARY",
            Color = Color3.fromRGB( 240, 180, 45 ),
            Weight = 2.5,
            Order = 5
        },
        mythical = {
            Name = "MYTHICAL",
            Color = Color3.fromRGB( 225, 45, 60 ),
            Weight = 0.6,
            Order = 6
        }
    },
    CATEGORIES = {
        { Key = "Paint", Name = "Paint", Icon = "rbxassetid://100589062727989" },
        { Key = "Wrap", Name = "Wraps", Icon = "rbxassetid://132685207456152" },
        { Key = "Rims", Name = "Rims", Icon = "rbxassetid://75416168117213" },
        { Key = "Neon", Name = "Neons", Icon = "rbxassetid://122339108352019" },
        {
            Key = "Spoiler",
            Name = "Spoilers",
            Icon = "rbxassetid://95967346079474"
        },
        {
            Key = "Headlights",
            Name = "Headlights",
            Icon = "rbxassetid://115429094242649"
        },
        { Key = "Horn", Name = "Horns", Icon = "rbxassetid://103208262674786" },
        {
            Key = "Suspension",
            Name = "Suspension",
            Icon = "rbxassetid://80423067896413"
        },
        {
            Key = "Brakes",
            Name = "Brakes",
            Icon = "rbxassetid://100916635012189"
        },
        {
            Key = "BrakePerf",
            Name = "Brake Upgrade",
            Icon = "rbxassetid://100916635012189",
            Hidden = true,
            ShowIn = "Brakes"
        }
    },
    CATEGORY = { }
}
local CATEGORIES = Table.CATEGORIES
Value1 = nil

for Key, Value in CATEGORIES, nil, nil do
    Value.Order = Key
    local CATEGORY = Table.CATEGORY
    CATEGORY[ Value.Key ] = Value
end

local Value2
local Table2 = { Scooter = true }
local Table3 = {
    Paint = {
        { "White", "common", { Color = Color3.fromRGB( 235, 235, 238 ) } },
        { "Black", "common", { Color = Color3.fromRGB( 22, 22, 24 ) } },
        { "Silver", "common", { Color = Color3.fromRGB( 160, 165, 172 ) } },
        { "Red", "common", { Color = Color3.fromRGB( 185, 22, 30 ) } },
        { "Blue", "common", { Color = Color3.fromRGB( 28, 70, 185 ) } },
        { "Orange", "uncommon", { Color = Color3.fromRGB( 232, 112, 20 ) } },
        { "Yellow", "uncommon", { Color = Color3.fromRGB( 240, 198, 28 ) } },
        { "Green", "uncommon", { Color = Color3.fromRGB( 38, 145, 60 ) } },
        { "Purple", "uncommon", { Color = Color3.fromRGB( 108, 40, 168 ) } },
        { "Pink", "uncommon", { Color = Color3.fromRGB( 230, 90, 160 ) } },
        {
            "Matte Black",
            "rare",
            {
                Color = Color3.fromRGB( 32, 32, 34 ),
                Material = Enum.Material.Plastic
            }
        },
        { "Midnight Blue", "rare", { Color = Color3.fromRGB( 18, 28, 78 ) } },
        { "Lime", "rare", { Color = Color3.fromRGB( 140, 228, 40 ) } },
        { "Teal", "rare", { Color = Color3.fromRGB( 18, 158, 160 ) } },
        {
            "Pearl White",
            "epic",
            {
                Color = Color3.fromRGB( 242, 240, 248 ),
                Material = Enum.Material.Foil
            }
        },
        {
            "Candy Red",
            "epic",
            { Color = Color3.fromRGB( 200, 10, 32 ), Material = Enum.Material.Foil }
        },
        {
            "Metallic Blue",
            "epic",
            { Color = Color3.fromRGB( 40, 92, 222 ), Material = Enum.Material.Foil }
        },
        {
            "Chrome",
            "legendary",
            {
                Color = Color3.fromRGB( 222, 226, 236 ),
                Material = Enum.Material.Foil
            }
        },
        {
            "Gold",
            "legendary",
            {
                Color = Color3.fromRGB( 255, 178, 36 ),
                Material = Enum.Material.Foil
            }
        },
        {
            "Black Chrome",
            "mythical",
            { Color = Color3.fromRGB( 26, 26, 32 ), Material = Enum.Material.Foil }
        }
    },
    Wrap = {
        {
            "Forest",
            "uncommon",
            {
                Texture = "rbxassetid://139852822593854",
                Color = Color3.fromRGB( 122, 130, 82 )
            }
        },
        {
            "Swamp",
            "uncommon",
            {
                Texture = "rbxassetid://78430441286396",
                Color = Color3.fromRGB( 66, 112, 58 )
            }
        },
        {
            "Urban",
            "uncommon",
            {
                Texture = "rbxassetid://104630049872500",
                Color = Color3.fromRGB( 72, 75, 79 )
            }
        },
        {
            "Tartan",
            "uncommon",
            {
                Texture = "rbxassetid://135953684594505",
                Color = Color3.fromRGB( 196, 164, 112 ),
                Material = Enum.Material.Fabric
            }
        },
        {
            "Tags",
            "uncommon",
            {
                Texture = "rbxassetid://77081538119442",
                Color = Color3.fromRGB( 118, 118, 116 )
            }
        },
        {
            "Zebra",
            "rare",
            {
                Texture = "rbxassetid://73783955711379",
                Color = Color3.fromRGB( 14, 10, 14 )
            }
        },
        {
            "Leopard",
            "rare",
            {
                Texture = "rbxassetid://77845630545750",
                Color = Color3.fromRGB( 213, 155, 92 )
            }
        },
        {
            "Ember",
            "rare",
            {
                Texture = "rbxassetid://113512216307546",
                Color = Color3.fromRGB( 168, 96, 32 )
            }
        },
        {
            "Stained Glass",
            "rare",
            {
                Texture = "rbxassetid://136762647236808",
                Color = Color3.fromRGB( 40, 60, 175 )
            }
        },
        {
            "Pure Gold",
            "epic",
            {
                Texture = "rbxassetid://119970423920070",
                Color = Color3.fromRGB( 255, 149, 0 ),
                Material = Enum.Material.Foil
            }
        },
        {
            "Damascus",
            "epic",
            {
                Texture = "rbxassetid://135064172601255",
                Color = Color3.fromRGB( 226, 228, 232 )
            }
        },
        {
            "Emerald",
            "legendary",
            {
                Texture = "rbxassetid://102614544503051",
                Color = Color3.fromRGB( 4, 150, 72 )
            }
        },
        {
            "Ruby",
            "legendary",
            {
                Texture = "rbxassetid://112557705338252",
                Color = Color3.fromRGB( 200, 8, 42 )
            }
        },
        {
            "Dark Matter",
            "mythical",
            {
                Texture = "rbxassetid://139188901367504",
                Color = Color3.fromRGB( 166, 0, 255 ),
                Material = Enum.Material.Foil
            }
        }
    },
    Rims = {
        { "AMG", "uncommon", { Model = "Rim_AMG" } },
        { "Evo", "uncommon", { Model = "Rim_Evo" } },
        { "Melbourne", "rare", { Model = "Rim_Melb" } },
        { "MC", "rare", { Model = "Rim_Mc" } },
        { "Oni", "epic", { Model = "Rim_Oni" } },
        { "Forgiato", "legendary", { Model = "Rim_Forgiato" } },
        { "GMR", "mythical", { Model = "Rim_GMR" } }
    },
    Neon = {
        { "Blue", "uncommon", { Color = Color3.fromRGB( 40, 120, 255 ) } },
        { "Red", "uncommon", { Color = Color3.fromRGB( 255, 30, 40 ) } },
        { "Green", "uncommon", { Color = Color3.fromRGB( 40, 255, 90 ) } },
        { "Purple", "rare", { Color = Color3.fromRGB( 170, 60, 255 ) } },
        { "Pink", "rare", { Color = Color3.fromRGB( 255, 70, 190 ) } },
        { "Cyan", "rare", { Color = Color3.fromRGB( 40, 235, 255 ) } },
        { "White", "epic", { Color = Color3.fromRGB( 240, 245, 255 ) } },
        { "Gold", "legendary", { Color = Color3.fromRGB( 255, 190, 40 ) } },
        {
            "Rainbow",
            "mythical",
            { Color = Color3.fromRGB( 255, 60, 60 ), Rainbow = true }
        }
    },
    Spoiler = {
        { "Heck", "uncommon", { Model = "Spoiler_Heck", Exclude = Table2 } },
        { "Aero", "uncommon", { Model = "Spoiler_Aero", Exclude = Table2 } },
        { "ZZ", "rare", { Model = "Spoiler_ZZ", Exclude = Table2 } },
        { "OP", "epic", { Model = "Spoiler_OP", Exclude = Table2 } },
        { "Wide", "epic", { Model = "Spoiler_Wide", Exclude = Table2 } },
        { "R34", "legendary", { Model = "Spoiler_R34", Exclude = Table2 } },
        { "Labs", "legendary", { Model = "Spoiler_Labs", Exclude = Table2 } },
        {
            "Aggressive",
            "mythical",
            { Model = "Spoiler_Agressive", Exclude = Table2 }
        }
    },
    Headlights = {
        { "Ice Blue", "uncommon", { Color = Color3.fromRGB( 150, 205, 255 ) } },
        { "Yellow", "uncommon", { Color = Color3.fromRGB( 255, 214, 90 ) } },
        { "Xenon", "rare", { Color = Color3.fromRGB( 225, 235, 255 ) } },
        { "Green", "rare", { Color = Color3.fromRGB( 110, 255, 120 ) } },
        { "Purple", "epic", { Color = Color3.fromRGB( 190, 110, 255 ) } },
        { "Red", "epic", { Color = Color3.fromRGB( 255, 70, 70 ) } },
        { "Pink", "legendary", { Color = Color3.fromRGB( 255, 110, 210 ) } }
    },
    Horn = {
        { "Short Beep", "common", { Sound = 120237386792082 } },
        { "Classic", "common", { Sound = 127513531122725 } },
        { "Double Beep", "uncommon", { Sound = 124134291878251 } },
        { "Old Car", "rare", { Sound = 18917430152 } },
        { "70s", "rare", { Sound = 110523809903348 } },
        {
            "Truck",
            "legendary",
            { Sound = 114107876724534, Price = 20000000, PerCar = true }
        },
        {
            "Clown",
            "mythical",
            { Sound = 3722232094, Price = 50000000, PerCar = true }
        },
        { "Goofy", "legendary", { Sound = 137100035389921 } },
        {
            "Charger",
            "uncommon",
            { Sound = 9113019260, Price = 10000, PerCar = true }
        },
        {
            "Ferrari",
            "uncommon",
            { Sound = 9114402619, Price = 10000, PerCar = true }
        },
        {
            "Mercedes",
            "uncommon",
            { Sound = 9125658932, Price = 10000, PerCar = true }
        },
        {
            "SUV V8",
            "uncommon",
            { Sound = 9113014312, Price = 10000, PerCar = true }
        },
        {
            "European",
            "uncommon",
            { Sound = 9120383448, Price = 10000, PerCar = true }
        },
        {
            "Buzz",
            "uncommon",
            { Sound = 9120386023, Price = 10000, PerCar = true }
        },
        {
            "Bus",
            "uncommon",
            { Sound = 9114661198, Price = 10000, PerCar = true }
        },
        {
            "Train",
            "epic",
            { Sound = 123203327964846, Price = 100000, PerCar = true }
        },
        {
            "La Cucaracha",
            "legendary",
            { Sound = 161465839, Price = 1000000, PerCar = true }
        }
    },
    Suspension = {
        { "High", "legendary", { Drop = -0.45, Price = 500000, PerCar = true } },
        {
            "Low",
            "legendary",
            {
                Drop = 0.35,
                Price = 500000,
                PerCar = true,
                Exclude = { Lambo = true, Lambo_ToitJaune = true }
            }
        }
    },
    Brakes = {
        { "Red", "common", { Color = Color3.fromRGB( 200, 24, 30 ) } },
        { "Yellow", "common", { Color = Color3.fromRGB( 240, 200, 30 ) } },
        { "Blue", "uncommon", { Color = Color3.fromRGB( 30, 90, 220 ) } },
        { "Green", "uncommon", { Color = Color3.fromRGB( 40, 170, 70 ) } },
        { "Orange", "rare", { Color = Color3.fromRGB( 240, 110, 20 ) } },
        { "Purple", "rare", { Color = Color3.fromRGB( 130, 50, 200 ) } },
        {
            "Gold",
            "epic",
            {
                Color = Color3.fromRGB( 255, 180, 40 ),
                Material = Enum.Material.Foil
            }
        },
        {
            "Neon Pink",
            "legendary",
            {
                Color = Color3.fromRGB( 255, 70, 190 ),
                Material = Enum.Material.Neon
            }
        }
    }
}
local Table4 = {
    CheapCar = 30000,
    [ "208" ] = 70000,
    Cayen = 150000,
    Challenger = 300000,
    ChallengerBlack = 300000,
    BM = 1000000,
    ArmoredVehicle = 2000000,
    Lambo = 5000000,
    Lambo_ToitJaune = 5000000,
    Vette = 7500000
}
local Table5 = { }

local function BrakePrices( Argument1 )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        Table[ Key ] = math.floor( Value * Argument1 + 0.5 )
        Table5[ Key ] = true
    end

    return Table
end

Table3.BrakePerf = {
    {
        "Stage 1",
        "common",
        {
            Name = "Basic Brakes",
            Price = 30000,
            Prices = BrakePrices( 1 ),
            Brake = 1.2,
            Grip = 1.06,
            Models = Table5,
            PerCar = true,
            Look = {
                Color = Color3.fromRGB( 200, 24, 30 ),
                Material = Enum.Material.SmoothPlastic
            }
        }
    },
    {
        "Stage 2",
        "legendary",
        {
            Name = "Legendary Brakes",
            Price = 45000,
            Prices = BrakePrices( 1.5 ),
            Brake = 1.4,
            Grip = 1.12,
            Models = Table5,
            PerCar = true,
            Look = {
                Color = Color3.fromRGB( 255, 180, 40 ),
                Material = Enum.Material.Foil,
                Disc = Color3.fromRGB( 46, 46, 50 )
            }
        }
    },
    {
        "Stage 3",
        "mythical",
        {
            Name = "Mythic Brakes",
            Price = 75000,
            Prices = BrakePrices( 2.5 ),
            Brake = 1.65,
            Grip = 1.2,
            Models = Table5,
            PerCar = true,
            Look = {
                Color = Color3.fromRGB( 225, 45, 60 ),
                Material = Enum.Material.Neon,
                Disc = Color3.fromRGB( 36, 36, 40 )
            }
        }
    }
}
Table.ITEMS = { }
Table.BY_CATEGORY = { }
Value2 = nil

for Key2, Value3 in Table3, nil, nil do
    local Value14
    Table.BY_CATEGORY[ Key2 ] = { }
    Value14 = nil

    for Key7, Value15 in Value3, nil, nil do
        local Value16
        local Text3 = "Car:" .. Key2 .. ":" .. Value15[ 1 ]:gsub( " ", "" )
        local Table9 = {
            Id = Text3,
            Category = Key2,
            Name = Value15[ 1 ],
            Rarity = Value15[ 2 ],
            Order = Key7
        }
        local Item = Value15[ 3 ]
        Value16 = nil

        for Key8, Value17 in Item, nil, nil do
            Table9[ Key8 ] = Value17
        end

        Table.ITEMS[ Text3 ] = Table9
        table.insert( Table.BY_CATEGORY[ Key2 ], Text3 )
    end
end

Table.SKIN_ITEM = { }
local Success, Result = pcall( require, script.Parent:WaitForChild( "AttachmentCases" ) )
local Success2, Result2 = pcall( require, script.Parent:WaitForChild( "Weapons" ):WaitForChild( "ModCatalog" ) )

if Success and Success2 then
    local Value4
    local Table6 = { }
    local Table7 = { "AttCamoColor", "AttCamoGloss", "AttCamoWrap" }
    Value4 = nil

    for Key3, Value5 in Table7, nil, nil do
        local Entry5
        local Entry4 = Result.CASES[ Value5 ]
        Entry5 = if Entry4 then Entry4 else { }
        local Value10 = nil

        for Value11 in Entry5, nil, nil do
            table.insert( Table6, Value11 )
        end
    end

    local Value6
    table.sort( Table6 )
    Value6 = nil

    for Key4, Value7 in Table6, nil, nil do
        local Match2
        local Match = Value7:match( "^Skin:(.+)$" )
        Match2 = if Match then Result2.Skins[ Match ] else Match

        if Match2 then
            local Text = not Match2.Texture and "Paint" or "Wrap"
            local Value8, Entry3
            local Entry = Table.BY_CATEGORY[ Text ]
            Value8 = nil

            for Key5, Value9 in Entry, nil, nil do
                local Entry2 = Table.ITEMS[ Value9 ]

                if not Match2.Texture or Entry2.Texture ~= Match2.Texture then
                    if Match2.Texture or Entry2.Color ~= Match2.Color then
                        continue
                    end
                    if Entry2.NoCrate then
                        continue
                    end
                end

                Entry3 = Entry2
                break
            end
            if not Entry3 and not Match2.Texture then
                local Material
                local Text2 = "Car:Paint:Skin_" .. Match
                local Table8 = {
                    Id = Text2,
                    Category = "Paint",
                    Name = Match2.name,
                    Rarity = Result.Tier( Value7 ),
                    Order = 100 + #Table.BY_CATEGORY.Paint,
                    Color = Match2.Color,
                    NoCrate = true
                }
                Material = Match2.Material == Enum.Material.Foil and Enum.Material.Foil or nil
                Table8.Material = Material
                Table.ITEMS[ Text2 ] = Table8
                table.insert( Table.BY_CATEGORY.Paint, Text2 )
                Entry3 = Table8
            end
            if Entry3 then
                local Skins2
                local Skins = Entry3.Skins
                Skins2 = if Skins then Skins else { }
                Entry3.Skins = Skins2
                table.insert( Entry3.Skins, Value7 )
                Entry3.Rarity = Result.Tier( Value7 )
                local SKIN_ITEM = Table.SKIN_ITEM
                SKIN_ITEM[ Value7 ] = Entry3.Id
            end
        end
    end
end

local Value12
function Table.Item( Key )
    return Table.ITEMS[ Key ]
end
Table.LEGACY = {
    [ "Car:Spoiler:Lip" ] = "Car:Spoiler:Aero",
    [ "Car:Spoiler:Ducktail" ] = "Car:Spoiler:ZZ",
    [ "Car:Spoiler:GTWing" ] = "Car:Spoiler:R34",
    [ "Car:Spoiler:DriftWing" ] = "Car:Spoiler:Labs",
    [ "Car:Suspension:Lifted" ] = "Car:Suspension:High",
    [ "Car:Suspension:Sport" ] = "Car:Suspension:Low",
    [ "Car:Suspension:Lowered" ] = "Car:Suspension:Low",
    [ "Car:Suspension:Slammed" ] = "Car:Suspension:Low"
}
function Table.Rarity( Key )
    local Entry2
    local Entry = Table.RARITIES[ Key ]
    Entry2 = if Entry then Entry else Table.RARITIES.common
    return Entry2
end
function Table.PriceFor( Argument1, ForName )
    if not Argument1 then
        return nil
    end

    local Entry2

    if not Argument1.Prices or not ForName then
        Entry2 = Argument1.Price
    else
        local Entry = Argument1.Prices[ ForName ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = Argument1.Price
        end
    end

    return Entry2
end
function Table.Allowed( Argument1, Key )
    local Flag

    if Argument1 == nil then
        Flag = false
    elseif Argument1.Models == nil or Argument1.Models[ Key ] == true then
        local Exclude2
        local Exclude = Argument1.Exclude
        Exclude2 = if Exclude then Argument1.Exclude[ Key ] else Exclude
        Flag = not Exclude2
    else
        Flag = false
    end

    return Flag
end
function Table.Owns( List, Key, Argument3, Callback )
    if ( List[ Table.OwnKey( Key, Argument3 ) ] or 0 ) > 0 then
        return true
    end

    local Entry = Table.ITEMS[ Key ]

    if Entry and Entry.Skins and Callback then
        local Value1
        local Skins = Entry.Skins
        Value1 = nil

        for Key2, Value in Skins, nil, nil do
            if Callback( Value ) then
                return true
            end
        end
    end

    return false
end
function Table.OwnKey( KeyName, Text )
    local Entry = Table.ITEMS[ KeyName ]

    if not Entry or not Entry.PerCar or not Text then
        return KeyName
    end
    return KeyName .. "@" .. Text
end
Table.CRATES = {
    Neon = {
        Name = "Neon Crate",
        Short = "Neons",
        Cost = 150000,
        Categories = { "Neon" },
        Group = "Light"
    },
    Headlights = {
        Name = "Headlights Crate",
        Short = "Headlights",
        Cost = 100000,
        Categories = { "Headlights" },
        Group = "Light"
    },
    Paint = {
        Name = "Uni Color Crate",
        Short = "Uni Color",
        Cost = 5000,
        Categories = { "Paint" },
        Group = "Color",
        FromCase = "AttCamoColor"
    },
    Gloss = {
        Name = "Gloss Crate",
        Short = "Gloss",
        Cost = 15000,
        Categories = { "Paint" },
        Group = "Color",
        FromCase = "AttCamoGloss"
    },
    Wrap = {
        Name = "Car Wrap Crate",
        Short = "Car Wrap",
        Cost = 50000,
        Categories = { "Wrap" },
        Group = "Color",
        FromCase = "AttCamoWrap"
    },
    Spoiler = {
        Name = "Spoiler Crate",
        Short = "Spoilers",
        Cost = 250000,
        Categories = { "Spoiler" },
        Group = "Part"
    },
    Rims = {
        Name = "Rims Crate",
        Short = "Rims",
        Cost = 350000,
        Categories = { "Rims" },
        Group = "Part"
    }
}
Table.CRATE_GROUPS = {
    { Key = "Light", Name = "Lights", Crates = { "Neon", "Headlights" } },
    { Key = "Color", Name = "Color", Crates = { "Paint", "Gloss", "Wrap" } },
    { Key = "Part", Name = "Parts", Crates = { "Spoiler", "Rims" } }
}
Table.CRATE_GROUP = { }
local CRATE_GROUPS = Table.CRATE_GROUPS
Value12 = nil

for Key6, Value13 in CRATE_GROUPS, nil, nil do
    local CRATE_GROUP = Table.CRATE_GROUP
    CRATE_GROUP[ Value13.Key ] = Value13
end

Table.CRATE_ORDER = { "Neon", "Headlights", "Paint", "Gloss", "Wrap", "Spoiler", "Rims" }
function Table.Odds( Key )
    local Entry = Table.CRATES[ Key ]

    if not Entry then
        return { }
    end

    local TableInner = { }

    if Entry.FromCase then
        local Entry3
        local Success, Result = pcall( require, game:GetService( "ReplicatedStorage" ):WaitForChild( "AttachmentCases" ) )

        if Success then
            local Entry2 = Result.CASES[ Entry.FromCase ]

            if Entry2 then
                Entry3 = Entry2
            else
                Entry3 = { }
            end
        else
            Entry3 = { }
        end

        local Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) == true and true or false
        local Value1, Number
        local Table2 = { }
        Value1 = nil
        Number = 0

        for Key2, Value in Entry3, nil, nil do
            Number = Number + Value
            local Entry4 = Table.SKIN_ITEM[ Key2 ]

            if Entry4 then
                if not Flag or Result.Tier( Key2 ) ~= "mythical" then
                    Table2[ Entry4 ] = ( Table2[ Entry4 ] or 0 ) + Value
                end
            end
        end

        local Value2 = nil

        for Key3, Value3 in Table2, nil, nil do
            table.insert( TableInner, {
                Id = Key3,
                W = Value3,
                Chance = Value3 / math.max( Number, 1e-09 ) * 100
            } )
        end

        table.sort( TableInner, function( Argument1, Argument2 )
            if math.abs( Argument1.Chance - Argument2.Chance ) > 1e-09 then
                local Flag = Argument1.Chance < Argument2.Chance and true or false
                return Flag
            end
            local Flag2 = Argument1.Id < Argument2.Id and true or false
            return Flag2
        end )
        return TableInner
    end
    local Value4, Number2
    local Categories = Entry.Categories
    Value4 = nil
    Number2 = 0

    for Key4, Value5 in Categories, nil, nil do
        local Entry6
        local Entry5 = Table.BY_CATEGORY[ Value5 ]
        Entry6 = if Entry5 then Entry5 else { }
        local Value8 = nil

        for Key6, Value9 in Entry6, nil, nil do
            if not Table.ITEMS[ Value9 ].NoCrate then
                local Weight = Table.Rarity( Table.ITEMS[ Value9 ].Rarity ).Weight
                Number2 = Number2 + Weight

                if Table.ITEMS[ Value9 ].Rarity ~= "mythical" or game:GetService( "ReplicatedStorage" ):GetAttribute( "NoMythicRolls" ) ~= true then
                    table.insert( TableInner, { Id = Value9, W = Weight } )
                end
            end
        end
    end

    local Value6 = nil

    for Key5, Value7 in TableInner, nil, nil do
        Value7.Chance = Value7.W / Number2 * 100
    end

    table.sort( TableInner, function( Argument1, Argument2 )
        if math.abs( Argument1.Chance - Argument2.Chance ) > 1e-09 then
            local Flag = Argument1.Chance < Argument2.Chance and true or false
            return Flag
        end
        local Flag2 = Argument1.Id < Argument2.Id and true or false
        return Flag2
    end )
    return TableInner
end
function Table.Roll( Argument1, Argument2 )
    local Value1, Number
    local Odds = Table.Odds( Argument1 )
    Value1 = nil
    Number = 0

    for Key, Value in Odds, nil, nil do
        Number = Number + Value.Chance
    end

    local Random

    if not Argument2 or not Argument2:NextNumber( ) then
        Random = math.random( )
    else
        Random = Argument2:NextNumber( )
    end

    local Value2
    local NextNumber = Random * Number
    Value2 = nil

    for Key2, Value3 in Odds, nil, nil do
        local NextNumber2 = NextNumber - Value3.Chance

        if NextNumber2 <= 0 then
            return Value3.Id
        end
        NextNumber = NextNumber2
    end

    local Entry2
    local Entry = Odds[ #Odds ]
    Entry2 = if Entry then Odds[ #Odds ].Id else Entry
    return Entry2
end
Table.PAINT_PARTS = {
    Lambo = { "Body2" },
    Lambo_ToitJaune = { "Body2" },
    Challenger = { "Body.001" },
    ChallengerBlack = { "Body.001" },
    Cayen = { "Body.002" },
    CheapCar = { "Body.005" },
    ArmoredVehicle = { "Body.004", "Door.001" },
    [ "208" ] = { "Body2.004" },
    BM = { "Body2.005" },
    Vette = { "Body1.005" }
}
Table.MAX_LOW = {
    Challenger = 0.25,
    ChallengerBlack = 0.25,
    Cayen = 0.3,
    BM = 0.25,
    Vette = 0.25
}
Table.RIM_PREFIX = "Jente"
Table.BRAKE_PREFIX = "Plaquette"
Table.HEADLIGHT_PREFIX = "FrontLights"
return Table
