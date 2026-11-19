-- ReplicatedStorage.Weapons.ItemRender
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ModCatalog = require( Weapons:WaitForChild( "ModCatalog" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local ExtraItems = require( ReplicatedStorage:WaitForChild( "ExtraItems" ) )

local function Grad2( Argument1, Argument2 )
    return ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Argument1 ),
        ColorSequenceKeypoint.new( 1, Argument2 )
    } )
end

local Grad22 = Grad2( Color3.fromRGB( 205, 45, 60 ), Color3.fromRGB( 105, 12, 30 ) )
local Grad23 = Grad2( Color3.fromRGB( 45, 125, 220 ), Color3.fromRGB( 14, 52, 125 ) )
local Grad24 = Grad2( Color3.fromRGB( 170, 70, 215 ), Color3.fromRGB( 85, 22, 130 ) )
local Grad25 = Grad2( Color3.fromRGB( 235, 180, 45 ), Color3.fromRGB( 135, 85, 8 ) )
local Grad26 = Grad2( Color3.fromRGB( 100, 100, 112 ), Color3.fromRGB( 42, 42, 50 ) )
local Grad27 = Grad2( Color3.fromRGB( 79, 208, 49 ), Color3.fromRGB( 34, 131, 24 ) )
local Grad28 = Grad2( Color3.fromRGB( 46, 46, 52 ), Color3.fromRGB( 4, 4, 6 ) )
local Table = {
    TILE_GRAD = {
        secret = Grad28,
        common = Grad26,
        uncommon = Grad27,
        mythical = Grad22,
        rare = Grad23,
        epic = Grad24,
        legendary = Grad25,
        super = Grad22,
        gun = Grad22,
        heal = Grad23,
        explosive = Grad24,
        fist = Grad2( Color3.fromRGB( 100, 100, 112 ), Color3.fromRGB( 42, 42, 50 ) )
    },
    RARITY = {
        Bandage = "rare",
        G15 = "rare",
        Medkit = "epic",
        Kevlar = "epic",
        EDrink = "epic",
        MP5 = "epic",
        AK = "epic",
        M4 = "legendary",
        M4A1 = "legendary",
        M60 = "legendary",
        SPAS12 = "legendary",
        MK14 = "legendary",
        G36 = "legendary",
        AWP = "super",
        RPG = "super",
        DRAGON = "super",
        Uzi = "rare",
        SawedOff = "rare",
        Eagle = "secret",
        RiotShield = "secret",
        Baton = "uncommon",
        MetalPipe = "uncommon",
        Lockpick = "uncommon",
        Shovel = "uncommon",
        BrassKnuckle = "uncommon",
        Crowbar = "uncommon",
        M9 = "rare",
        CashBag500K = "mythical",
        CashBag1M = "mythical",
        CashBag3M = "mythical",
        CashBag5M = "mythical",
        Batte = "uncommon",
        Bayonneta = "uncommon",
        BrokenBottle = "uncommon"
    },
    AMMO_GREEN = Color3.fromRGB( 20, 230, 40 )
}
function Table.TextColor( ColorName )
    if ColorName == "secret" then
        return Color3.fromRGB( 235, 235, 240 )
    end

    local Entry2
    local Entry = Table.TILE_GRAD[ ColorName ]

    if Entry then
        Entry2 = Entry
    elseif ColorName == "mythical" then
        local Super = Table.TILE_GRAD.super

        if Super then
            Entry2 = Super
        else
            Entry2 = Table.TILE_GRAD.common
        end
    else
        Entry2 = Table.TILE_GRAD.common
    end

    return Entry2.Keypoints[ 1 ].Value
end
function Table.IsSecret( Key )
    local Flag

    if type( Key ) == "string" then
        if Table.RARITY[ Key ] == "secret" then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end
Table.CARTOON = { cartoon = true, roll = -0.6108652381980153 }
Table.ICONS = {
    M4 = "rbxassetid://99230034321091",
    AK = "rbxassetid://88374083994003",
    MP5 = "rbxassetid://140584197844777",
    M60 = "rbxassetid://104919288730042",
    AWP = "rbxassetid://89754564093339",
    DRAGON = "rbxassetid://97967360537032",
    G15 = "rbxassetid://136966356782395",
    RPG = "rbxassetid://109522593682592",
    SPAS12 = "rbxassetid://121892310067592",
    Bandage = "rbxassetid://117244966359387",
    Medkit = "rbxassetid://89172443654483",
    EDrink = "rbxassetid://105091042625442",
    Kevlar = "rbxassetid://135892830255095",
    Batte = "rbxassetid://137307423034588",
    Bayonneta = "rbxassetid://106684487049093",
    BrokenBottle = "rbxassetid://78100922238638",
    Eagle = "rbxassetid://92279551134176",
    M9 = "rbxassetid://125607841667597",
    Uzi = "rbxassetid://99174387664305",
    SawedOff = "rbxassetid://110949306140610",
    Shovel = "rbxassetid://71776501655256",
    Baton = "rbxassetid://95862674796217",
    MetalPipe = "rbxassetid://138154683028157",
    Crowbar = "rbxassetid://121780567496410",
    BrassKnuckle = "rbxassetid://73254698789920",
    RiotShield = "rbxassetid://111379513821371",
    MK14 = "rbxassetid://84774100279900",
    G36 = "rbxassetid://129128863330487",
    CashBag500K = "rbxassetid://114885548100231",
    CashBag1M = "rbxassetid://74794688886928",
    CashBag3M = "rbxassetid://100891724223164",
    CashBag5M = "rbxassetid://79256367605631",
    CheapCar = "rbxassetid://135788410868238",
    Cayen = "rbxassetid://83285868336414",
    Challenger = "rbxassetid://72960444798051",
    ArmoredVehicle = "rbxassetid://91314933735069",
    Lambo = "rbxassetid://111246677525854",
    BM = "rbxassetid://136484764185898",
    [ "208" ] = "rbxassetid://78679380608915",
    ChallengerBlack = "rbxassetid://83723317163828",
    Lambo_ToitJaune = "rbxassetid://133180163689505",
    Scooter = "rbxassetid://139753316526960",
    Vette = "rbxassetid://100142431286471"
}
Table.ICON_SCALE = {
    G15 = 0.55,
    Bayonneta = 0.68,
    BrokenBottle = 0.62,
    Batte = 0.85,
    Eagle = 0.62,
    M9 = 0.55,
    Uzi = 0.64,
    SawedOff = 0.92,
    BrassKnuckle = 0.45,
    Baton = 0.8,
    MetalPipe = 0.78,
    Crowbar = 0.8,
    Shovel = 0.9
}
function Table.IconScale( Self )
    local Weapon2
    local Weapon = Self:GetAttribute( "Weapon" )

    if Weapon then
        Weapon2 = Weapon
    else
        local Melee = Self:GetAttribute( "Melee" )

        if Melee then
            Weapon2 = Melee
        else
            local Item = Self:GetAttribute( "Item" )

            if Item then
                Weapon2 = Item
            else
                local Vehicle = Self:GetAttribute( "Vehicle" )

                if Vehicle then
                    Weapon2 = Vehicle
                else
                    local Gear = Self:GetAttribute( "Gear" )

                    if Gear then
                        Weapon2 = Gear
                    else
                        Weapon2 = ""
                    end
                end
            end
        end
    end

    return Table.ICON_SCALE[ Weapon2 ] or 1
end
function Table.PlaceIcon( Argument1, Argument2, Argument3, Argument4, Amount )
    local Number = Amount or 1
    local UDim3 = UDim.new( Argument3.X.Scale + Argument4.X.Scale * ( 0.5 - Argument2.X ), Argument3.X.Offset + Argument4.X.Offset * ( 0.5 - Argument2.X ) )
    local UDim4 = UDim.new( Argument3.Y.Scale + Argument4.Y.Scale * ( 0.5 - Argument2.Y ), Argument3.Y.Offset + Argument4.Y.Offset * ( 0.5 - Argument2.Y ) )
    Argument1.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Argument1.Position = UDim2.new( UDim3, UDim4 )
    Argument1.Size = UDim2.new( Argument4.X.Scale * Number, Argument4.X.Offset * Number, Argument4.Y.Scale * Number, Argument4.Y.Offset * Number )
end
function Table.Icon( Self )
    local Entry5
    local Entry = Table.ICONS[ Self:GetAttribute( "Weapon" ) or "" ]

    if Entry then
        Entry5 = Entry
    else
        local Entry2 = Table.ICONS[ Self:GetAttribute( "Item" ) or "" ]

        if Entry2 then
            Entry5 = Entry2
        else
            local Entry3 = Table.ICONS[ Self:GetAttribute( "Melee" ) or "" ]

            if Entry3 then
                Entry5 = Entry3
            else
                local Entry4 = Table.ICONS[ Self:GetAttribute( "Vehicle" ) or "" ]

                if Entry4 then
                    Entry5 = Entry4
                else
                    Entry5 = Table.ICONS[ Self:GetAttribute( "Gear" ) or "" ]
                end
            end
        end
    end

    return Entry5
end
function Table.SetIcon( Object, IconName )
    local Image = IconName or ""

    if Object:GetAttribute( "IconBase" ) == Image then
        return
    end

    Object:SetAttribute( "IconBase", Image )
    Object.Image = Image

    if Image == "" or not Image:find( "^rbxthumb" ) then
        return
    end
    task.spawn( function()
        local I = 1

        for I = 1, 6 do
            task.wait( 4 )

            if Object:GetAttribute( "IconBase" ) ~= Image or Object.IsLoaded then
                return
            end

            Object.Image = Image .. "&v=" .. I
        end
    end )
    return
end
function Table.Category( Self )
    local Vehicle = Self:GetAttribute( "Vehicle" )

    if Vehicle then
        local Info
        local Success, Result = pcall( require, ReplicatedStorage:FindFirstChild( "VehicleCrates" ) )

        if Success then
            if Result then
                Info = Result.Info( Vehicle )
            else
                Info = Result
            end
        else
            Info = Success
        end

        local Rarity = Info and Info.Rarity or "rare"
        return Rarity
    end
    local Weapon2
    local RARITY = Table.RARITY
    local Weapon = Self:GetAttribute( "Weapon" )

    if Weapon then
        Weapon2 = Weapon
    else
        local Item = Self:GetAttribute( "Item" )

        if Item then
            Weapon2 = Item
        else
            local Melee = Self:GetAttribute( "Melee" )

            if Melee then
                Weapon2 = Melee
            else
                local Gear = Self:GetAttribute( "Gear" )

                if Gear then
                    Weapon2 = Gear
                else
                    Weapon2 = ""
                end
            end
        end
    end

    local Entry = RARITY[ Weapon2 ]

    if Entry then
        return Entry
    end
    if Self:GetAttribute( "Item" ) then
        return "heal"
    end

    local Entry2 = WeaponData[ Self:GetAttribute( "Weapon" ) ]

    if not Entry2 or not Entry2.Fire or Entry2.Fire.Mode ~= "Rocket" then
        return "gun"
    end
    return "explosive"
end
function Table.AmmoFrac( Self )
    local Ammo = Self:GetAttribute( "Ammo" )
    local MagSize = Self:GetAttribute( "MagSize" )

    if not Self:GetAttribute( "Weapon" ) or type( Ammo ) ~= "number" or type( MagSize ) ~= "number" or MagSize <= 0 then
        return nil
    end
    return ( math.clamp( Ammo / MagSize, 0, 1 ) )
end
function Table.DurabilityFrac( Self )
    if Self:GetAttribute( "Vehicle" ) then
        local Health = Self:GetAttribute( "Health" )
        local MaxHealth = Self:GetAttribute( "MaxHealth" )

        if type( Health ) ~= "number" or type( MaxHealth ) ~= "number" or MaxHealth <= 0 then
            return 1
        end
        return ( math.clamp( Health / MaxHealth, 0, 1 ) )
    else
        if not Self:GetAttribute( "Weapon" ) and not Self:GetAttribute( "Melee" ) then
            return nil
        end

        local Durability = Self:GetAttribute( "Durability" )
        local MaxDurability = Self:GetAttribute( "MaxDurability" )

        if type( Durability ) ~= "number" or type( MaxDurability ) ~= "number" or MaxDurability <= 0 then
            return 1
        end
        return ( math.clamp( Durability / MaxDurability, 0, 1 ) )
    end
end
function Table.SetFade( Self, ImageTransparency )
    if Self:IsA( "ViewportFrame" ) then
        Self.ImageTransparency = ImageTransparency
    end
    for Key, Value in Self:GetDescendants( ) do
        if Value:IsA( "ViewportFrame" ) then
            Value.ImageTransparency = ImageTransparency
        end
    end
end
Table.FIST_ICON = "rbxassetid://75566043745695"
Table.FIST_RATIO = 1.18

local function Templates()
    return game:GetService( "StarterGui" ):WaitForChild( "ItemRender" )
end

function Table.Fist( Parent, Position, Size )
    local Clone = game:GetService( "StarterGui" ):WaitForChild( "ItemRender" ):WaitForChild( "Fist" ):Clone( )
    Clone.Position = Position
    Clone.Size = Size
    Clone.Parent = Parent
    return Clone
end

local function ModelOf( Self, Argument2 )
    local Melee
    local Weapon = Self:GetAttribute( "Weapon" )

    if Weapon then
        Melee = Weapon
    else
        Melee = Self:GetAttribute( "Melee" )
    end

    local FoundChild

    if Melee then
        FoundChild = WeaponVisuals:FindFirstChild( Melee )
    else
        FoundChild = Melee
    end

    local Clone2

    if FoundChild then
        local Clone = FoundChild:Clone( )

        if Argument2 then
            Clone2 = Clone
        else
            local Apply = ModCatalog.Apply
            pcall( Apply, Clone, Melee, ModCatalog.Decode( Self:GetAttribute( "Mods" ) or "" ) )
            Clone2 = Clone
        end
    else
        local Parent = Instance.new( "Model" )

        for Key, Value in Self:GetChildren( ) do
            if Value:IsA( "BasePart" ) and Value.Transparency < 1 then
                Value:Clone( ).Parent = Parent
            end

            Clone2 = Parent
        end

        Clone2 = Parent
    end
    for Key2, Value2 in Clone2:GetDescendants( ) do
        if Value2:IsA( "LuaSourceContainer" ) or Value2:IsA( "Sound" ) or Value2:IsA( "ParticleEmitter" ) or Value2:IsA( "Light" ) or Value2:IsA( "Beam" ) then
            Value2:Destroy( )
        elseif Value2:IsA( "BasePart" ) then
            Value2.Anchored = true

            if Value2.Transparency >= 0.99 then
                Value2.LocalTransparencyModifier = 1
            end
        end
    end

    local Flag = FoundChild ~= nil and true or false
    return Clone2, Flag
end

local function VisibleBounds( Object, Argument2 )
    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Transparency < 0.9 and Value.LocalTransparencyModifier < 1 then
            local Value1
            local Size = Value.Size / 2
            local Table = { -1, 1 }
            Value1 = nil

            for Key2, Value2 in Table, nil, nil do
                local Value3
                local Table2 = { -1, 1 }
                Value3 = nil

                for Key3, Value4 in Table2, nil, nil do
                    local Value5
                    local Table3 = { -1, 1 }
                    Value5 = nil

                    for Key4, Value6 in Table3, nil, nil do
                        local PointToObjectSpace = Argument2:PointToObjectSpace( Value.CFrame:PointToWorldSpace( Size * Vector3.new( Value2, Value4, Value6 ) ) )
                        Result = Result:Min( PointToObjectSpace )
                        Result2 = Result2:Max( PointToObjectSpace )
                    end
                end
            end
        end
    end
    if Result.X == math.huge then
        return nil
    end
    return Argument2:PointToWorldSpace( ( Result + Result2 ) / 2 ), Result2 - Result
end

local function Silhouette( Object )
    local Clone = Object:Clone( )

    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "SurfaceAppearance" ) or Value:IsA( "Decal" ) or Value:IsA( "Texture" ) then
            Value:Destroy( )
        elseif Value:IsA( "BasePart" ) then
            Value.Color = Color3.new( 0, 0, 0 )
            Value.Material = Enum.Material.SmoothPlastic
            Value.Reflectance = 0

            if Value:IsA( "MeshPart" ) then
                pcall( function()
                    Value.TextureID = ""
                end )
            end
        elseif Value:IsA( "SpecialMesh" ) then
            Value.TextureId = ""
        end
    end

    return Clone
end

local function Viewport( Name )
    local Clone = game:GetService( "StarterGui" ):WaitForChild( "ItemRender" ):WaitForChild( Name ):Clone( )
    Clone.Size = UDim2.fromScale( 1, 1 )
    Clone.Position = UDim2.new( )
    return Clone
end

function Table.Build( Self, Amount, Argument3, Argument4 )
    local Number = Amount or 1.45
    local Parent = game:GetService( "StarterGui" ):WaitForChild( "ItemRender" ):WaitForChild( "Render" ):Clone( )
    Parent.Size = UDim2.fromScale( 1, 1 )
    Parent.Position = UDim2.new( )
    local Value1, Value2 = ModelOf( Self, Argument3 )

    if #Value1:GetDescendants( ) == 0 then
        Value1:Destroy( )
        return Parent
    end

    local Rotation2
    local BoundingBox = Value1:GetBoundingBox( )

    if not Value2 or not Value1.PrimaryPart then
        Rotation2 = BoundingBox.Rotation
    else
        local Rotation = Value1.PrimaryPart.CFrame.Rotation

        if Rotation then
            Rotation2 = Rotation
        else
            Rotation2 = BoundingBox.Rotation
        end
    end

    local Value3, Value4 = VisibleBounds( Value1, Rotation2 )

    if not Value3 then
        Value1:Destroy( )
        return Parent
    end

    local LookVector2
    local Rotation3 = Rotation2 + Value3
    Value1.Parent = Parent
    local RightVector = Rotation3.RightVector
    local UpVector = Rotation3.UpVector
    local LookVector = Rotation3.LookVector
    local X = Value4.X
    local Z = Value4.Z

    if Value2 or not ( Value4.Z < Value4.X ) then
        LookVector2 = LookVector
        LookVector = RightVector
    else
        LookVector2 = -RightVector
        Z = Value4.X
        X = Value4.Z
    end

    local Unit2

    if ( Argument4 or { } ).cartoon then
        local Unit = ( LookVector + UpVector * 0.12 ).Unit

        if Unit then
            Unit2 = Unit
        else
            Unit2 = ( LookVector + LookVector2 * 0.25 + UpVector * 0.28 ).Unit
        end
    else
        Unit2 = ( LookVector + LookVector2 * 0.25 + UpVector * 0.28 ).Unit
    end

    local Roll
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 26
    local Tan = math.tan( ( math.rad( CurrentCamera.FieldOfView / 2 ) ) )
    Roll = Value2 and ( Argument4 or { } ).roll or 0
    local Z2
    local Y = Value4.Y

    if Roll == 0 then
        Z2 = Z
    else
        local Abs = math.abs( ( math.cos( Roll ) ) )
        local Abs2 = math.abs( ( math.sin( Roll ) ) )
        Z2 = Z * Abs + Value4.Y * Abs2
        Y = Z * Abs2 + Value4.Y * Abs
    end

    local Number2 = not ( Argument4 or { } ).cartoon and 1.02 or 1.1
    local Z3 = Z2 / 2 / ( Tan * Number )
    local Max = math.max( Z3, Y / 2 / Tan ) * Number2 + X / 2
    local Position = Rotation3.Position + Unit2 * Max
    CurrentCamera.CFrame = CFrame.lookAt( Position, Rotation3.Position, UpVector ) * CFrame.Angles( 0, 0, Roll )

    if not ( Argument4 or { } ).cartoon then
        CurrentCamera.Parent = Parent
        Parent.CurrentCamera = CurrentCamera
        return Parent
    end

    local Cartoon = game:GetService( "StarterGui" ):WaitForChild( "ItemRender" ):WaitForChild( "Cartoon" )
    local Main = Cartoon:WaitForChild( "Main" )
    local Ambient = Main.Ambient
    local LightColor = Main.LightColor
    local LightDirection = Main.LightDirection
    local ZIndex = Main.ZIndex
    Parent.Ambient = Ambient
    Parent.LightColor = LightColor
    Parent.LightDirection = LightDirection
    Parent.ZIndex = ZIndex
    CurrentCamera.Parent = Parent
    Parent.CurrentCamera = CurrentCamera
    local Parent2 = Cartoon:Clone( )
    Parent2.Name = "Render"
    local Size = UDim2.fromScale( 1, 1 )
    local Position2 = UDim2.new( )
    Parent2.Size = Size
    Parent2.Position = Position2
    local Contour = Parent2:FindFirstChild( "Contour" )

    if Contour then
        Contour.Parent = nil
    end
    if Parent2:FindFirstChild( "Main" ) then
        Parent2.Main:Destroy( )
    end

    local Value6
    local Outline = ( Argument4 or { } ).outline or 3
    local Silhouette2 = Silhouette( Value1 )
    local Table = {
        { 1, 0 },
        { -1, 0 },
        { 0, 1 },
        { 0, -1 },
        { 0.7071, 0.7071 },
        { -0.7071, 0.7071 },
        { 0.7071, -0.7071 },
        { -0.7071, -0.7071 }
    }
    Value6 = nil

    for Key, Value in Table, nil, nil do
        local Parent3 = Contour:Clone( )
        Parent3.Size = UDim2.fromScale( 1, 1 )
        Parent3.Position = UDim2.fromOffset( Value[ 1 ] * Outline, Value[ 2 ] * Outline )
        Silhouette2:Clone( ).Parent = Parent3
        local CurrentCamera2 = CurrentCamera:Clone( )
        CurrentCamera2.Parent = Parent3
        Parent3.CurrentCamera = CurrentCamera2
        Parent3.Parent = Parent2
    end

    Silhouette2:Destroy( )
    Parent.Parent = Parent2
    return Parent2
end
function Table.CarRender( Name, Amount )
    local Number = Amount or 1.7
    local Parent = game:GetService( "StarterGui" ):WaitForChild( "ItemRender" ):WaitForChild( "CarRender" ):Clone( )
    local Size = UDim2.fromScale( 1, 1 )
    local Position = UDim2.new( )
    Parent.Size = Size
    Parent.Position = Position
    local Contour = Parent:FindFirstChild( "Contour" )
    local Parent2 = Parent:FindFirstChild( "Main" )

    if Contour then
        Contour.Parent = nil
    end

    local FoundChild
    local VehicleModels = ReplicatedStorage:FindFirstChild( "VehicleModels" )

    if VehicleModels then
        FoundChild = VehicleModels:FindFirstChild( Name )
    else
        FoundChild = VehicleModels
    end
    if not FoundChild then
        return Parent
    end

    local Clone = FoundChild:Clone( )

    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "LuaSourceContainer" ) or Value:IsA( "Sound" ) or Value:IsA( "ParticleEmitter" ) or Value:IsA( "Light" ) or Value:IsA( "Beam" ) or Value:IsA( "Trail" ) or Value:IsA( "BillboardGui" ) or Value:IsA( "SurfaceGui" ) or Value:IsA( "ProximityPrompt" ) then
            Value:Destroy( )
        elseif Value:IsA( "BasePart" ) then
            Value.Anchored = true

            if Value.Transparency >= 0.99 then
                Value:Destroy( )
            end
        end
    end

    Clone:PivotTo( CFrame.new( ) )
    local Unit = ( CFrame.Angles( 0, 0.9599310885968813, 0 ):VectorToWorldSpace( Vector3.new( 0, 0, 1 ) ) + Vector3.new( 0, 0.3199999928474426, 0 ) ).Unit
    local LookAt = CFrame.lookAt( Vector3.new( 0, 0, 0 ), -Unit )
    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

    for Key2, Value2 in Clone:GetDescendants( ) do
        if Value2:IsA( "BasePart" ) and Value2.Transparency < 0.9 and Value2.Size.Magnitude < 60 then
            local Value5
            local Size2 = Value2.Size / 2
            local Table2 = { -1, 1 }
            Value5 = nil

            for Key4, Value6 in Table2, nil, nil do
                local Value7
                local Table3 = { -1, 1 }
                Value7 = nil

                for Key5, Value8 in Table3, nil, nil do
                    local Value9
                    local Table4 = { -1, 1 }
                    Value9 = nil

                    for Key6, Value10 in Table4, nil, nil do
                        local PointToObjectSpace = LookAt:PointToObjectSpace( Value2.CFrame:PointToWorldSpace( Size2 * Vector3.new( Value6, Value8, Value10 ) ) )
                        Result = Result:Min( PointToObjectSpace )
                        Result2 = Result2:Max( PointToObjectSpace )
                    end
                end
            end
        end
    end
    if Result.X == math.huge then
        Clone:Destroy( )
        return Parent
    end

    local Value3
    local X = Result2.X - Result.X
    local Y = Result2.Y - Result.Y
    local Z = Result2.Z - Result.Z
    local X2 = X / 2 / ( 0.14054083470239145 * Number )
    local Max = math.max( X2, Y / 2 / 0.14054083470239145 ) * 1.06 + Z / 2
    local PointToWorldSpace = LookAt:PointToWorldSpace( ( Result + Result2 ) / 2 )
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 16
    CurrentCamera.CFrame = CFrame.lookAt( PointToWorldSpace + Unit * Max, PointToWorldSpace )
    local Silhouette2 = Silhouette( Clone )
    local Table = {
        { 1, 0 },
        { -1, 0 },
        { 0, 1 },
        { 0, -1 },
        { 0.7071, 0.7071 },
        { -0.7071, 0.7071 },
        { 0.7071, -0.7071 },
        { -0.7071, -0.7071 }
    }
    Value3 = nil

    for Key3, Value4 in Table, nil, nil do
        local Parent3 = Contour:Clone( )
        local OutlineScale = Contour:GetAttribute( "OutlineScale" ) or 0.025
        Parent3.Size = UDim2.fromScale( 1, 1 )
        Parent3.Position = UDim2.fromScale( Value4[ 1 ] * OutlineScale / Number, Value4[ 2 ] * OutlineScale )
        Silhouette2:Clone( ).Parent = Parent3
        local CurrentCamera2 = CurrentCamera:Clone( )
        CurrentCamera2.Parent = Parent3
        Parent3.CurrentCamera = CurrentCamera2
        Parent3.Parent = Parent
    end

    Silhouette2:Destroy( )
    Clone.Parent = Parent2
    CurrentCamera.Parent = Parent2
    Parent2.CurrentCamera = CurrentCamera
    Parent2.Parent = Parent
    return Parent
end
function Table.CarArt( Object, Argument2, ArtName )
    local CarArtToken = ( Object:GetAttribute( "CarArtToken" ) or 0 ) + 1
    Object:SetAttribute( "CarArtToken", CarArtToken )
    local CarRender = Object:FindFirstChild( "CarRender" )

    if CarRender and CarRender:GetAttribute( "Car" ) ~= Argument2 then
        CarRender:Destroy( )
    end
    if not Argument2 then
        return
    end

    local Flag

    if type( ArtName ) == "string" then
        if ArtName == "" then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    local Flag2

    local function Shown()
        local Captured

        if Flag then
            if Object.Image == ArtName then
                Captured = Object.IsLoaded
            else
                Captured = false
            end
        else
            Captured = Flag
        end

        return Captured
    end

    if Flag then
        if Object.Image == ArtName then
            Flag2 = Object.IsLoaded
        else
            Flag2 = false
        end
    else
        Flag2 = Flag
    end
    if not Flag2 then
        task.spawn( function()
            local Clock = os.clock( )

            while Object.Parent do
                if Object:GetAttribute( "CarArtToken" ) ~= CarArtToken then
                    break
                end

                local Captured

                if Flag then
                    if Object.Image == ArtName then
                        Captured = Object.IsLoaded
                    else
                        Captured = false
                    end
                else
                    Captured = Flag
                end
                if Captured then
                    local CarRender = Object:FindFirstChild( "CarRender" )

                    if CarRender then
                        CarRender:Destroy( )
                    end

                    return
                end
                if not Flag or os.clock( ) - Clock >= 1.5 then
                    if not Object:FindFirstChild( "CarRender" ) then
                        local X2
                        local AbsoluteSize = Object.AbsoluteSize
                        local CarRender2 = Table.CarRender

                        if AbsoluteSize.Y > 1 then
                            local X = AbsoluteSize.X / AbsoluteSize.Y

                            if X then
                                X2 = X
                            else
                                X2 = 1.7
                            end
                        else
                            X2 = 1.7
                        end

                        local CarRender3 = CarRender2( Argument2, X2 )
                        CarRender3:SetAttribute( "Car", Argument2 )
                        CarRender3.Parent = Object

                        if not Flag then
                            return
                        end
                    end
                end
                if os.clock( ) - Clock > 30 then
                    return
                end

                task.wait( 0.1 )
            end
        end )
        return
    end

    local CarRender2 = Object:FindFirstChild( "CarRender" )

    if CarRender2 then
        CarRender2:Destroy( )
    end
end
function Table.NewCache( Argument1, Argument2, Argument3 )
    local Class = setmetatable( { }, { __mode = "k" } )
    return function( Key )
        local Text

        if Argument2 then
            Text = ""
        else
            Text = tostring( Key:GetAttribute( "Mods" ) or "" )
        end

        local Entry = Class[ Key ]

        if Entry and Entry.key == Text then
            return Entry.frame
        end
        if Entry then
            Entry.frame:Destroy( )
        end

        local Build = Table.Build( Key, Argument1, Argument2, Argument3 )
        Class[ Key ] = { key = Text, frame = Build }
        return Build
    end
end

local function Extra( Argument1 )
    return {
        __index = function( Argument1Inner, Argument2 )
            local Get2
            local Get = ExtraItems.Get( Argument2 )
            Get2 = if Get then Get[ Argument1 ] else Get

            if Get2 == "" then
                return nil
            end
            return Get2
        end
    }
end

local Text = "Rarity"
setmetatable( Table.RARITY, {
    __index = function( Argument1, Argument2 )
        local Get2
        local Get = ExtraItems.Get( Argument2 )
        Get2 = if Get then Get[ Text ] else Get

        if Get2 == "" then
            return nil
        end
        return Get2
    end
} )
local Text2 = "Icon"
setmetatable( Table.ICONS, {
    __index = function( Argument1, Argument2 )
        local Get2
        local Get = ExtraItems.Get( Argument2 )
        Get2 = if Get then Get[ Text2 ] else Get

        if Get2 == "" then
            return nil
        end
        return Get2
    end
} )
local Text3 = "IconScale"
setmetatable( Table.ICON_SCALE, {
    __index = function( Argument1, Argument2 )
        local Get2
        local Get = ExtraItems.Get( Argument2 )
        Get2 = if Get then Get[ Text3 ] else Get

        if Get2 == "" then
            return nil
        end
        return Get2
    end
} )
return Table
