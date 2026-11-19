-- ReplicatedStorage.Weapons.MetalImpactAudio
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local SoundService = game:GetService( "SoundService" )
local Debris = game:GetService( "Debris" )
local Table2 = { wood = 0.45, concrete = 0.63 }
local Config = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "VehicleSystem" ):WaitForChild( "Config" ) )

local function CarTone( Argument1 )
    local Parent
    local Find = WorldRefs.Find( "Cars" )
    Parent = Argument1

    while Parent do
        if Parent.Parent == Find then
            break
        end

        Parent = Parent.Parent
    end

    local Get2

    if Parent then
        local Get = Config.Get( Parent.Name )

        if Get then
            Get2 = Get
        else
            Get2 = Config.Default
        end
    else
        Get2 = Config.Default
    end

    return Get2.ImpactPitch or 1, Get2.ImpactThin or 0
end

local Table3 = {
    "glass",
    "phare",
    "feu",
    "emissive",
    "interior",
    "wheel",
    "armor_",
    "vehiclehitbox"
}
local Table = {
    IsMetal = function( Object )
        if typeof( Object ) ~= "Instance" or not Object:IsA( "BasePart" ) or Object.Transparency >= 0.9 then
            return false
        end

        local Find = WorldRefs.Find( "Cars" )

        if not Find or not Object:IsDescendantOf( Find ) then
            return false
        end

        local Lower = Object.Name:lower( )

        if Lower:find( "jente" ) then
            return true
        end

        local Value1 = nil

        for Key, Value in Table3, nil, nil do
            if Lower:find( Value, 1, true ) then
                return false
            end
        end

        return true
    end
}
local Table4 = {
    [ Enum.Material.Wood ] = "wood",
    [ Enum.Material.WoodPlanks ] = "wood",
    [ Enum.Material.Metal ] = "metal",
    [ Enum.Material.DiamondPlate ] = "metal",
    [ Enum.Material.CorrodedMetal ] = "metal",
    [ Enum.Material.Foil ] = "metal",
    [ Enum.Material.Concrete ] = "concrete",
    [ Enum.Material.Asphalt ] = "concrete",
    [ Enum.Material.Pavement ] = "concrete",
    [ Enum.Material.Brick ] = "concrete",
    [ Enum.Material.Cobblestone ] = "concrete",
    [ Enum.Material.Slate ] = "concrete",
    [ Enum.Material.Granite ] = "concrete",
    [ Enum.Material.Rock ] = "concrete",
    [ Enum.Material.Basalt ] = "concrete",
    [ Enum.Material.Limestone ] = "concrete",
    [ Enum.Material.Sandstone ] = "concrete",
    [ Enum.Material.Marble ] = "concrete",
    [ Enum.Material.Glass ] = "glass",
    [ Enum.Material.Grass ] = "grass",
    [ Enum.Material.LeafyGrass ] = "grass",
    [ Enum.Material.Water ] = false,
    [ Enum.Material.Fabric ] = false,
    [ Enum.Material.Sand ] = false,
    [ Enum.Material.Snow ] = false,
    [ Enum.Material.Mud ] = false,
    [ Enum.Material.Ground ] = false,
    [ Enum.Material.ForceField ] = false
}

local function Vocab( List, Argument2, List2 )
    local Value1 = nil

    for Key, Value in List2, nil, nil do
        table.insert( List, { Value, Argument2 } )
    end
end

local Table5 = { }
Vocab( Table5, "glass", {
    "GLASS",
    "VITRE",
    "VERRE",
    "MIRROR",
    "MIROIR",
    "AQUARIUM",
    "BULB",
    "SUBURBSTOREFAC"
} )
Vocab( Table5, "wood", {
    "WOOD",
    "=BOIS",
    "PLANK",
    "PLANCHE",
    "TRUNK",
    "TRONC",
    "BARK$",
    "CORKBOARD",
    "CARDBOARD",
    "CONDAMNE",
    "MILWALL",
    "HOUSEWALL",
    "TOWNHOUSEEXTERIOR",
    "=BARWALL",
    "=BARCEILING",
    "GARAGEWALL",
    "BOATHOUSE",
    "BARGEFLOOR",
    "TELEPOLE"
} )
Vocab( Table5, "metal", {
    "METAL",
    "STEEL",
    "ACIER",
    "^IRON",
    "CHROME",
    "STAINLESS",
    "CORRUGATE",
    "ALUMIN",
    "=FER",
    "MTL$",
    "=MET",
    "TABLEMET",
    "HEATER",
    "=THREAD",
    "=LIFT",
    "DINEREXTERIOR",
    "DINERROOF",
    "GASCEILING",
    "=SHOPWALL",
    "=INDUSTRY",
    "=AISLE",
    "BACKALLEY",
    "DOORAL",
    "ELEVSTAIRS",
    "7TWELVESTRIPE",
    "ROOFPROPS"
} )
Vocab( Table5, "concrete", {
    "CONC",
    "BETON",
    "BRICK",
    "BRIQUE",
    "STONE",
    "PIERRE",
    "^ROCK",
    "ASPHALT",
    "PLASTER",
    "TILE",
    "CARRELAGE",
    "CEMENT",
    "MARBLE",
    "MARBRE",
    "GRANIT",
    "STUCCO",
    "WALLPAPER",
    "DONTOPENDEADINSIDE"
} )
Vocab( Table5, "grass", { "GRASS", "HERBE", "PELOUSE", "GAZON", "LAWN" } )
Vocab( Table5, false, {
    "LEAVES",
    "LEAF",
    "FEUILLE",
    "NEEDLES",
    "FOLIAGE",
    "BUSH",
    "BUISSON",
    "HEDGE",
    "=HAIE",
    "=HAIES",
    "CABLE",
    "=ROPE",
    "ROPES$",
    "=WATER",
    "^WATER",
    "=EAU",
    "=CLOTH",
    "CLOTHES",
    "FABRIC",
    "TISSU",
    "CURTAIN",
    "RIDEAU",
    "BLIND",
    "=TIRE",
    "=TIRES",
    "PIERTIRE",
    "PNEU",
    "TRASHBAG",
    "LITTER",
    "COUCH$",
    "SOFA",
    "CANAPE",
    "BEDCOVER",
    "=BED",
    "MATTRESS",
    "TOWEL",
    "=MAT",
    "DOORMAT",
    "RUBBERMAT",
    "TAPIS",
    "AWNING",
    "CANOPY",
    "UMBRELLA",
    "FLAGS$",
    "=FLAG",
    "=NET",
    "=PAPER",
    "LIFERING",
    "=HAY",
    "=SEAT",
    "=INTERIORPLANT",
    "INSULATION",
    "=DISTANT",
    "PILLOW",
    "CUSHION"
} )
local Table6 = { }
Vocab( Table6, "metal", {
    "FIRESTAIRS",
    "ESCAPE",
    "GARDOOR",
    "GARADOOR",
    "GARAGEDOOR",
    "GARD$",
    "ELEVATORDOOR",
    "ELEDOOR",
    "=ELDR",
    "FREEZERDOOR",
    "FRIDGEDOOR",
    "DOORGRIP",
    "DOORBELL",
    "HANDLE",
    "BELL$"
} )
Vocab( Table6, "concrete", { "SHAFT" } )
Vocab( Table6, "wood", { "PORCH", "TRAPPE" } )
Vocab( Table6, "metal", {
    "^BARGE",
    "HULL",
    "SHUT",
    "FENCE",
    "CLOTURE",
    "GRILL",
    "GRATE",
    "=BARS",
    "BARREAU",
    "RAIL",
    "RAMBARDE",
    "LADDER",
    "ECHELLE",
    "LAMP",
    "LMPPST",
    "LIGHT",
    "LANTERN",
    "FLUOR",
    "FIXTURE",
    "CHANDELIER",
    "SIGN",
    "BILLBOARD",
    "STANDINGBILL",
    "SPEEDLIMIT",
    "=EXIT",
    "TRAFFIC",
    "POLE",
    "POTEAU",
    "=POST",
    "ANTENNA",
    "ANTENNE",
    "SATELLITE",
    "=DISH",
    "PIPE",
    "TUYAU",
    "^VENT",
    "=DUCT",
    "^DUCT",
    "GUTTER",
    "DUMPSTER",
    "TRASHCAN",
    "TRASHBIN",
    "POUBELLE",
    "=BIN",
    "=TRASH",
    "MAILBOX",
    "NEWSBOX",
    "ICEBOX",
    "METERBOX",
    "ELECTRICALBOX",
    "CARGOBOX",
    "TOOLCHEST",
    "HYDRANT",
    "TRANSFORMER",
    "CONTAINER",
    "TRUCK",
    "=TRAIN",
    "TRACK",
    "=ELEVATED",
    "VIADUC",
    "CHAIN",
    "=WIRE",
    "=GATE",
    "PORTAIL",
    "ELEVATOR",
    "ASCENSEUR",
    "ELEPANEL",
    "FREEZER",
    "FRIDGE",
    "VENDING",
    "=ATM",
    "JUKEBOX",
    "MACHINE",
    "AIRCON",
    "ACUNIT",
    "RADIATOR",
    "ELECTRONICS",
    "=TV",
    "TVSTATIC",
    "=LCD",
    "SCREEN",
    "SPEAKER",
    "CAMERA",
    "PHONE",
    "FILING",
    "=RACK",
    "MAGAZINERACK",
    "BARSTOOL",
    "HOOP",
    "=GOAL",
    "PANIER",
    "EXTINGUISHER",
    "SPRAYCAN",
    "=SODA",
    "=CART",
    "PUMP",
    "BUOY",
    "SHOVEL",
    "MANHOLE",
    "=TRIM",
    "PLATE",
    "TRUSS",
    "GIRDER",
    "BEAM",
    "CRANE",
    "=TANK",
    "BARREL",
    "=DRUM",
    "CARLIFT",
    "BUTTON",
    "BTN$",
    "=KITCHEN",
    "~^VAC%d+AB$",
    "=CLOTHAB",
    "=GUNAB",
    "=DRUGAB",
    "=PAWNAB",
    "=GASAB",
    "=ELECAB",
    "=712AB",
    "STOVE",
    "=OVEN",
    "FRYER",
    "MALLETTE"
} )
Vocab( Table6, "wood", {
    "DOOR",
    "PORTE",
    "DR$",
    "CUPBOARD",
    "CABINET",
    "CLOSET",
    "PLACARD",
    "SHEL",
    "ETAGERE",
    "DESK",
    "TABLE",
    "CHAIR",
    "CHAISE",
    "BENCH",
    "=BANC",
    "BEDFRAME",
    "PATIO",
    "PONTON",
    "PIER",
    "TREE",
    "ARBRE",
    "CYPRESS",
    "CRATE",
    "PALLET",
    "BOX",
    "LATTICE",
    "COFFIN",
    "PIANO",
    "DRESSER",
    "WARDROBE"
} )
Vocab( Table6, "concrete", {
    "WALL",
    "^MUR",
    "FLOOR",
    "=SOL",
    "=SOLS",
    "CEIL",
    "PLAFOND",
    "ROOF",
    "=TOIT",
    "STAIR",
    "STEPS",
    "ESCALIER",
    "MARCHE",
    "SIDEWALK",
    "TROTTOIR",
    "CURB",
    "BORDURE",
    "ROAD",
    "CHAUSSEE",
    "ALLEYWAY",
    "DALLE",
    "FAC",
    "PILLAR",
    "PILIER",
    "COLUMN",
    "COLONNE",
    "SOCLE",
    "LEDGE",
    "RAMP",
    "PLANTER",
    "JARDINIERE",
    "FOUNTAIN",
    "FONTAINE",
    "BASSIN",
    "STATUE",
    "GRAVE",
    "TOMB",
    "SINK",
    "LAVABO",
    "TOILET",
    "URINAL",
    "BATH",
    "COUNTER",
    "COMPTOIR",
    "CARPET",
    "MOQUETTE",
    "FIREPLACE",
    "CHEMINEE",
    "CHIMNEY",
    "DIRT",
    "SOIL",
    "POT$",
    "PUITS",
    "CULEE",
    "BARRIER"
} )
local Table7 = { OUTDOOR = true, INDOOR = true, ENTREE = true, PROOF = true }

local function Motif( List, Argument2 )
    local Sub = Argument2:sub( 1, 1 )

    if Sub == "~" then
        local Flag = List:find( Argument2:sub( 2 ) ) ~= nil and true or false
        return Flag
    end
    if Sub == "=" then
        local Flag2 = List == Argument2:sub( 2 ) and true or false
        return Flag2
    end
    if Sub == "^" then
        local Flag3
        local Sub2 = Argument2:sub( 2 )
        Flag3 = List:sub( 1, #Sub2 ) == Sub2 and true or false
        return Flag3
    end
    if Argument2:sub( -1 ) == "$" then
        local Flag4
        local Sub3 = Argument2:sub( 1, -2 )
        local Count = #List

        if #Sub3 <= Count then
            if List:sub( -#Sub3 ) == Sub3 then
                Flag4 = true
            else
                Flag4 = false
            end
        else
            Flag4 = false
        end

        return Flag4
    end
    local Flag5 = List:find( Argument2, 1, true ) ~= nil and true or false
    return Flag5
end

local Table8 = { }

local function DuMot( MotName )
    local Table
    local Entry = Table8[ MotName ]

    if Entry then
        Table = Entry
    else
        Table = { false, nil, 0, nil }

        if not Table7[ MotName ] then
            local Value1 = nil

            for Key, Value in Table5, nil, nil do
                if Motif( MotName, Value[ 1 ] ) then
                    Table = { true, Value[ 2 ], 3, Value[ 1 ] }
                    break
                end
            end
            if not Table[ 1 ] then
                local Value2 = nil

                for Key2, Value3 in Table6, nil, nil do
                    if Motif( MotName, Value3[ 1 ] ) then
                        Table = { true, Value3[ 2 ], 2, Value3[ 1 ] }
                        break
                    end
                end
            end
        end

        Table8[ MotName ] = Table
    end

    return Table[ 1 ], Table[ 2 ], Table[ 3 ], Table[ 4 ]
end

local function DuNom( Argument1 )
    local Gsub2
    local Gsub = Argument1:gsub( "_?[Bb]asket_[Pp]elouses", "" ):gsub( "TOWNHOUSE_EXTERIOR", "TOWNHOUSEEXTERIOR" ):gsub( "BAR_WALL", "BARWALL" )
    Gsub2 = if Gsub:find( "%a" ) then Gsub else Argument1
    local Number, Value1, Gsub3
    Number = -1
    Value1 = nil
    Gsub3 = nil

    for Value in Gsub2:gmatch( "[%a%d]+" ) do
        local NotFind2
        local NotFind = not Value:find( "%l" )

        if NotFind then
            if select( 2, Value:gsub( "%u", "" ) ) >= 2 then
                NotFind2 = true
            else
                NotFind2 = false
            end
        else
            NotFind2 = NotFind
        end

        local Gsub4 = Value:upper( ):gsub( "%d+%a?$", "" ):gsub( "STREET", "" )
        Value2, Value1, Value3 = DuMot( Gsub4 )

        if Value2 then
            local Number2 = not NotFind2 and 0 or 10
            local Number3 = Number2 + Value3

            if Number <= Number3 then
                Number = Number3
                Gsub3 = Gsub4
            end
        end
    end
    if Number < 0 then
        return false
    end
    return true, Value1, Gsub3
end

local Table9 = {
    "BARS",
    "FRAME",
    "TRIM",
    "WOOD",
    "BLIND",
    "SHUTTER",
    "BRICK",
    "ALLEYWINS",
    "INDUSTRY"
}

local function IsGlassName( Argument1 )
    if not Argument1:find( "GLASS", 1, true ) and not Argument1:find( "VITRE", 1, true ) and not Argument1:find( "WINDOW", 1, true ) and not Argument1:find( "WINS?%f[%A]" ) then
        return false
    end

    local Value1
    local Match = Argument1:match( "_(.*)$" ) or Argument1
    Value1 = nil

    for Key, Value in Table9, nil, nil do
        if Match:find( Value, 1, true ) then
            return false
        end
    end

    return true
end

local Class = setmetatable( { }, { __mode = "k" } )
local Class2 = setmetatable( { }, { __mode = "k" } )
function Table.SurfaceOf( Key )
    if typeof( Key ) ~= "Instance" or not Key:IsA( "BasePart" ) then
        return nil
    end
    if Key == workspace.Terrain then
        return "concrete"
    end

    local Entry3
    local Entry = Class[ Key ]

    if Entry == nil then
        local Text2, Lower2
        local Surface = Key:GetAttribute( "Surface" )

        if type( Surface ) == "string" then
            local Lower = Surface ~= "" and Surface:lower( ) or false
            Lower2 = Lower
            Text2 = "attribut Surface"
        elseif Key.Transparency >= 0.9 then
            Lower2 = false
            Text2 = "pièce invisible"
        else
            local Find = WorldRefs.Find( "Cars" )
            local Model = Key:FindFirstAncestorOfClass( "Model" )

            if not Find or not Key:IsDescendantOf( Find ) then
                if not Model or not Model:FindFirstChildOfClass( "Humanoid" ) then
                    local Entry2 = Table4[ Key.Material ]

                    if Entry2 == nil then
                        if IsGlassName( Key.Name:upper( ) ) then
                            Lower2 = "glass"
                            Text2 = "nom (vitre)"
                        else
                            local Flag
                            local Value1, Value2, Value3 = DuNom( Key.Name )

                            if Value1 then
                                Text2 = "nom : " .. Value3
                                Flag = Value1
                            else
                                local Parent = Key.Parent
                                local I = 1
                                Flag = Value1
                                Text2 = nil

                                for I = 1, 2 do
                                    if not Parent or Parent == workspace then
                                        Flag = Value1
                                        Text2 = nil
                                        break
                                    end

                                    local Value4, Value5, Value6 = DuNom( Parent.Name )

                                    if Value4 and Value5 ~= "glass" then
                                        Text2 = ( "dossier %s : %s" ):format( Parent.Name, Value6 )
                                        Flag = true
                                        Value2 = Value5
                                        break
                                    end

                                    Parent = Parent.Parent
                                    Flag = Value1
                                    Text2 = nil
                                end
                            end
                            if Flag then
                                Lower2 = Value2
                            else
                                Lower2 = "concrete"
                                Text2 = "rien dans le nom : béton par défaut"
                            end
                        end
                    else
                        Text2 = "matériau " .. Key.Material.Name
                        Lower2 = Entry2
                    end
                else
                    Lower2 = false
                    Text2 = "perso"
                end
            else
                local Text = if Table.IsMetal( Key ) then "metal" else false
                Lower2 = Text
                Text2 = "voiture"
            end
        end

        Class[ Key ] = Lower2
        Class2[ Key ] = Text2
        Entry3 = Lower2
    else
        Entry3 = Entry
    end
    if workspace:GetAttribute( "DebugSurface" ) then
        print( ( "[SURFACE] %s -> %s (%s)" ):format( Key:GetFullName( ), tostring( Entry3 or "rien" ), ( tostring( Class2[ Key ] ) ) ) )
    end

    return Entry3 or nil
end
local Table10 = {
    metal = "bulletonmetal",
    wood = "bulletonwood",
    concrete = "bulletonconcrete"
}
local Table11 = { }

local function Collect( Name )
    local Text = Name or "metal"

    if Table11[ Text ] then
        return Table11[ Text ]
    end

    local Entry2
    local Table = { }
    local Entry = Table10[ Text ]
    Entry2 = if Entry then Entry else Table10.metal

    for Key, Value in SoundService:GetDescendants( ) do
        if Value:IsA( "Sound" ) and Value.SoundId ~= "" and Value.Name:lower( ):find( Entry2, 1, true ) then
            table.insert( Table, Value )
        end
    end

    Table11[ Text ] = Table
    return Table
end

local function Dirty( Object )
    if Object:IsA( "Sound" ) then
        table.clear( Table11 )
    end
end

SoundService.DescendantAdded:Connect( Dirty )
SoundService.DescendantRemoving:Connect( Dirty )

if game:GetService( "RunService" ):IsClient( ) then
    task.spawn( function()
        local Value1
        task.wait( 2 )
        local Table = { }
        Value1 = nil

        for Value in Table10, nil, nil do
            for Key, Value3 in Collect( Value ) do
                table.insert( Table, Value3 )
            end
        end
        if #Table > 0 then
            local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
            pcall( PreloadAsync, game:GetService( "ContentProvider" ), Table )
        end
    end )
end

local Table12 = { }
local Table13 = { }

local function NextSound( List, SoundName )
    local Entry2
    local Entry = Table12[ SoundName ]
    Entry2 = if Entry then Entry else { }
    Table12[ SoundName ] = Entry2
    local Entry3 = Table13[ SoundName ]

    if #Entry2 == 0 then
        local Value1 = nil

        for Key, Value in List, nil, nil do
            Entry2[ Key ] = Value
        end

        local Count = #Entry2
        local I = Count

        for I = Count, 2, -1 do
            local Random = math.random( I )
            local Entry4 = Entry2[ Random ]
            local Entry5 = Entry2[ I ]
            Entry2[ I ] = Entry4
            Entry2[ Random ] = Entry5
        end
        if #Entry2 > 1 and Entry2[ #Entry2 ] == Entry3 then
            local Count2 = #Entry2
            local Entry6 = Entry2[ #Entry2 ]
            local Item = Entry2[ 1 ]
            Entry2[ 1 ] = Entry6
            Entry2[ Count2 ] = Item
        end
    end

    local Remove = table.remove( Entry2 )
    Table13[ SoundName ] = Remove
    return Remove
end

local Number = 0
function Table.Play( Parent, WorldPosition, Name )
    local Text = Name or "metal"

    if not Table10[ Text ] or Number >= 12 or typeof( WorldPosition ) ~= "Vector3" then
        return
    end

    local Collect2 = Collect( Text )

    if #Collect2 == 0 then
        return
    end
    if Table12[ Text ] then
        local Count = #Table12[ Text ]

        if #Collect2 < Count then
            table.clear( Table12[ Text ] )
        end
    end

    local NextSound2 = NextSound( Collect2, Text )

    if not NextSound2 or not NextSound2.Parent then
        if Table12[ Text ] then
            table.clear( Table12[ Text ] )
        end

        return
    end
    local Parent3
    local Parent2 = Instance.new( "Attachment" )
    Parent2.Name = "ImpactSound"
    Parent3 = typeof( Parent ) == "Instance" and Parent:IsA( "BasePart" ) and Parent or workspace.Terrain
    local NumberInner, Number2
    Parent2.Parent = Parent3
    Parent2.WorldPosition = WorldPosition
    local Parent4 = NextSound2:Clone( )
    Parent4.Looped = false
    Parent4.Volume = Table2[ Text ] or 2
    Parent4.RollOffMode = Enum.RollOffMode.InverseTapered
    Parent4.RollOffMinDistance = 10
    Parent4.RollOffMaxDistance = 100
    local Find = WorldRefs.Find( "Cars" )

    if Text ~= "metal" or not Find or typeof( Parent ) ~= "Instance" or not Parent:IsDescendantOf( Find ) then
        NumberInner = 1
        Number2 = 0
    else
        NumberInner, Number2 = CarTone( Parent )
    end

    Parent4.PlaybackSpeed = NumberInner * ( 1 + ( math.random( ) - 0.5 ) * 0.06 )

    if Number2 > 0 then
        local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
        EqualizerSoundEffect.LowGain = Number2 * -14
        EqualizerSoundEffect.MidGain = 0
        EqualizerSoundEffect.HighGain = Number2 * 4
        EqualizerSoundEffect.Parent = Parent4
    end

    local TimeLength
    Parent4.Parent = Parent2
    Parent4:Play( )
    Number = Number + 1
    TimeLength = NextSound2.TimeLength > 0 and NextSound2.TimeLength or 2
    local TimeLength2 = TimeLength / Parent4.PlaybackSpeed + 0.2
    task.delay( TimeLength2, function()
        Number = Number - 1
    end )
    Debris:AddItem( Parent2, TimeLength2 )
    return
end
return Table
