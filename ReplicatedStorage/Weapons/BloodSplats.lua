-- ReplicatedStorage.Weapons.BloodSplats
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Flag
local CollectionService = game:GetService( "CollectionService" )
local TweenService = game:GetService( "TweenService" )
local FX = workspace:WaitForChild( "FX" )
local CurrentCamera = workspace.CurrentCamera
local Random2 = Random.new( )
Flag = workspace:GetAttribute( "ShowBloodSplats" ) == true and true or false
workspace:GetAttributeChangedSignal( "ShowBloodSplats" ):Connect( function()
    local FlagInner = workspace:GetAttribute( "ShowBloodSplats" ) == true and true or false
    Flag = FlagInner
end )
local Table = { }
local Table2 = { }

local function ReadSettings( Argument1 )
    local Template = Argument1.template
    local Sx = Template.Size.X
    local Sy = Template.Size.Y
    Argument1.sx = Sx
    Argument1.sy = Sy
    Argument1.jitter = Template:GetAttribute( "SizeJitter" ) or 0.15
    Argument1.lifetime = Template:GetAttribute( "Lifetime" ) or 10
    local FadeTime = Template:GetAttribute( "FadeTime" ) or 1.5
    Argument1.fadeTime = math.min( FadeTime, Argument1.lifetime )
end

local function AddVariant( Template )
    if not Template:IsA( "BasePart" ) or Template.Name:sub( 1, 10 ) ~= "BloodSplat" then
        return
    end

    local Entry2
    local Entry = Table[ Template.Name ]

    if Entry then
        Entry2 = Entry
    else
        local TableInner = { }
        Table[ Template.Name ] = TableInner
        table.insert( Table2, TableInner )
        Entry2 = TableInner
    end

    Entry2.template = Template
    Entry2.ready = false
    ReadSettings( Entry2 )
    Template.AttributeChanged:Connect( function()
        ReadSettings( Entry2 )
    end )
    Template:GetPropertyChangedSignal( "Size" ):Connect( function()
        ReadSettings( Entry2 )
    end )
end

local function Watch( Self )
    for Key, Value in Self:GetChildren( ) do
        AddVariant( Value )
    end

    Self.ChildAdded:Connect( AddVariant )

    local function Hide( Self )
        if Self:IsA( "Decal" ) then
            Self.LocalTransparencyModifier = 1
        end
    end

    for Key2, Value2 in Self:GetDescendants( ) do
        if Value2:IsA( "Decal" ) then
            Value2.LocalTransparencyModifier = 1
        end
    end

    Self.DescendantAdded:Connect( Hide )
end

if FX:FindFirstChild( "BloodSplats" ) then
    Watch( FX.BloodSplats )
else
    FX.ChildAdded:Connect( function( Self )
        if Self.Name == "BloodSplats" then
            Watch( Self )
        end
    end )
end

local function PickVariant()
    if #Table2 == 0 then
        return nil
    end

    local Entry = Table2[ Random2:NextInteger( 1, #Table2 ) ]

    if not Entry.ready then
        local Decal = Entry.template:FindFirstChildWhichIsA( "Decal" )

        if Decal then
            local Texture = Decal.Texture
            local Color = Decal.Color3
            local Transparency = Decal.Transparency
            local Zindex = Decal.ZIndex
            Entry.texture = Texture
            Entry.color = Color
            Entry.transparency = Transparency
            Entry.zindex = Zindex
            Entry.ready = true
        end
    end

    local Entry2 = Entry.ready and Entry or nil
    return Entry2
end

local function Surface( Part )
    if Part.CollisionGroup == "Hitbox" or Part.Transparency >= 0.9 then
        return "pass", Part
    end

    local Model = Part:FindFirstAncestorOfClass( "Model" )

    if Model and Model:FindFirstChildOfClass( "Humanoid" ) then
        return "pass", Model
    end
    if not Part.Anchored then
        return "stop"
    end

    local Model2
    local I = 1
    Model2 = Model

    for I = 1, 3 do
        if not Model2 or Model2 == workspace then
            break
        end
        if CollectionService:HasTag( Model2, "Porte" ) then
            return "stop"
        end

        Model2 = Model2:FindFirstAncestorOfClass( "Model" )
    end

    return "take"
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.CollisionGroup = "Bullet"
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude

local function Cast( Argument1, Argument2, FilterDescendantsInstances )
    local I = 1

    for I = 1, 4 do
        RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
        local Raycast = workspace:Raycast( Argument1, Argument2, RaycastParams2 )

        if not Raycast then
            return nil
        end

        local Value1, Value2 = Surface( Raycast.Instance )

        if Value1 == "take" then
            return Raycast
        end
        if Value1 ~= "pass" then
            return nil
        end

        table.insert( FilterDescendantsInstances, Value2 )
    end

    return nil
end

local function Fits( LookAt, Argument2, Argument3, Amount, FilterDescendantsInstances )
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local I = 1

    for I = 1, 4 do
        local Number = I % 2 ~= 0 and -0.5 or 0.5
        local Number3
        local Number2 = Number * Argument2 * 0.65
        Number3 = not ( I > 2 ) and -0.5 or 0.5
        local Raycast = workspace:Raycast( LookAt * Vector3.new( Number2, Number3 * Argument3 * 0.65, 0 ) + Amount * 0.15, Amount * -0.3, RaycastParams2 )

        if not Raycast or Raycast.Normal:Dot( Amount ) < 0.97 or Surface( Raycast.Instance ) ~= "take" then
            return false
        end
    end

    return true
end

local function Frame( Argument1, Argument2, Argument3, Argument4 )
    local Position = not ( math.abs( Argument3.Y ) > 0.99 ) and Vector3.new( 0, 1, 0 ) or Vector3.new( 1, 0, 0 )
    return CFrame.lookAt( Argument1, Argument2, Position ) * CFrame.Angles( 0, 0, Argument4 )
end

local Create = table.create( 40 )
local Number = 0

local function Expire( Argument1 )
    local FadeAt = Argument1.fadeAt - os.clock( )

    if FadeAt > 0.03 then
        task.delay( FadeAt, Expire, Argument1 )
        return
    end
    Argument1.timer = false
    Argument1.tween = TweenService:Create( Argument1.decal, TweenInfo.new( Argument1.fadeTime, Enum.EasingStyle.Linear ), { Transparency = 1 } )
    Argument1.tween:Play( )
    return
end

local function Put( Variant, Argument2, Amount, Argument4, Argument5, Argument6, Argument7 )
    local Entry2
    Number = Number % 40 + 1
    local Entry = Create[ Number ]

    if not Entry or Entry.part.Parent ~= FX then
        local Parent = Instance.new( "Part" )
        Parent.Name = "BloodSplat"
        Parent.Anchored = true
        Parent.Massless = true
        Parent.CanCollide = false
        Parent.CanQuery = false
        Parent.CanTouch = false
        Parent.CastShadow = false
        Parent.Transparency = 1
        local Decal = Instance.new( "Decal" )
        Decal.Face = Enum.NormalId.Front
        Decal.Parent = Parent
        local Table = { part = Parent, decal = Decal }
        Create[ Number ] = Table
        Entry2 = Table
    elseif Entry.tween then
        Entry.tween:Cancel( )
        Entry.tween = nil
        Entry2 = Entry
    else
        Entry2 = Entry
    end

    local Part = Entry2.part
    local Decal2 = Entry2.decal

    if Entry2.variant ~= Variant then
        Entry2.variant = Variant
        local Texture = Variant.texture
        local Color32 = Variant.color
        local ZIndex = Variant.zindex
        Decal2.Texture = Texture
        Decal2.Color3 = Color32
        Decal2.ZIndex = ZIndex
    end
    if Decal2.Transparency ~= Variant.transparency then
        Decal2.Transparency = Variant.transparency
    end
    if Entry2.debug ~= Flag then
        local Transparency
        Entry2.debug = Flag
        local Color = Color3.fromRGB( 255, 40, 40 )
        Transparency = not Flag and 1 or 0.6
        Part.Material = Enum.Material.Neon
        Part.Color = Color
        Part.Transparency = Transparency
    end

    local Position
    Part.Size = Vector3.new( Argument4, Argument5, 0.05 )
    local Captured = Argument2 + Amount * ( Number % 8 * 0.0005 + 0.004 - 0.025 )
    local Captured2 = Captured + Amount
    Position = not ( math.abs( Amount.Y ) > 0.99 ) and Vector3.new( 0, 1, 0 ) or Vector3.new( 1, 0, 0 )
    Part.CFrame = CFrame.lookAt( Captured, Captured2, Position ) * CFrame.Angles( 0, 0, Argument6 )

    if Part.Parent ~= FX then
        Part.Parent = FX
    end

    local FadeAt = Argument7 + Variant.lifetime - Variant.fadeTime
    local FadeTime = Variant.fadeTime
    Entry2.fadeAt = FadeAt
    Entry2.fadeTime = FadeTime

    if not Entry2.timer then
        Entry2.timer = true
        task.delay( Variant.lifetime - Variant.fadeTime, Expire, Entry2 )
    end
end

local Number2 = 0
local Number3 = 0

local function Place( Argument1, Amount, FilterDescendantsInstances, Wall )
    local PickVariant2 = PickVariant( )

    if not PickVariant2 then
        return
    end

    local Position
    local NextNumber = 1 + Random2:NextNumber( -1, 1 ) * PickVariant2.jitter
    local Sx = PickVariant2.sx * NextNumber
    local Sy = PickVariant2.sy * NextNumber
    local NextNumber2 = Random2:NextNumber( 0, 6.283185307179586 )
    local Total = Argument1 + Amount
    Position = not ( math.abs( Amount.Y ) > 0.99 ) and Vector3.new( 0, 1, 0 ) or Vector3.new( 1, 0, 0 )
    local Number
    local LookAt = CFrame.lookAt( Argument1, Total, Position ) * CFrame.Angles( 0, 0, NextNumber2 )
    Number = 1

    while true do
        local Sx2 = Sx * Number

        if Fits( LookAt, Sx2, Sy * Number, Amount, FilterDescendantsInstances ) then
            break
        end

        local Number2 = Number * 0.7

        if Number2 < 0.3 then
            return
        end

        Number = Number2
    end

    Number3 = Number3 + 1
    local Sx3 = Sx * Number
    Put( PickVariant2, Argument1, Amount, Sx3, Sy * Number, NextNumber2, Wall )
end

local Class = setmetatable( { }, { __mode = "k" } )

local function Splat( Argument1, Argument2, Argument3, Wall, Argument5, Argument6, Argument7 )
    local Table = { Argument1, FX }
    local ClientHitboxes = workspace:FindFirstChild( "ClientHitboxes" )

    if ClientHitboxes then
        table.insert( Table, ClientHitboxes )
    end

    local Unit = typeof( Argument3 ) == "Vector3" and Argument3.Magnitude > 0.01 and Argument3.Unit or nil

    if Argument5 and Unit then
        Argument7.wall = Wall
        local Cast2 = Cast( Argument2, ( Unit + Random2:NextUnitVector( ) * 0.2 ).Unit * 10, Table )

        if Cast2 then
            local Position = Cast2.Position
            Place( Position, Cast2.Normal, Table, Wall )

            if Cast2.Normal.Y > 0.7 then
                Argument6 = false
            end

            Argument6 = Argument6
        end

        Argument6 = Argument6
    end
    if Argument6 and Number3 < 3 then
        local Vector33
        Argument7.floor = Wall

        if Unit then
            local X = Unit.X
            local Vector32 = Vector3.new( X, 0, Unit.Z )

            if Vector32 then
                Vector33 = Vector32
            else
                Vector33 = Vector3.new( 0, 0, 0 )
            end
        else
            Vector33 = Vector3.new( 0, 0, 0 )
        end

        local Position4

        if Vector33.Magnitude > 0.05 then
            local Position3
            local Unit2 = Vector33.Unit
            local Unit3 = Unit2 * Random2:NextNumber( 0.3, 2 ) + Unit2:Cross( Vector3.new( 0, 1, 0 ) ) * Random2:NextNumber( -1.2, 1.2 )
            local Cast3 = Cast( Argument2, Unit3, Table )

            if Cast3 then
                local Position2 = Cast3.Position - Unit3.Unit * 0.3

                if Position2 then
                    Position3 = Position2
                else
                    Position3 = Argument2 + Unit3
                end
            else
                Position3 = Argument2 + Unit3
            end

            Position4 = Position3
        else
            Position4 = Argument2
        end

        local Cast4 = Cast( Position4, Vector3.new( 0, -10, 0 ), Table )

        if Cast4 and Cast4.Normal.Y > 0.5 then
            local Position5 = Cast4.Position
            Place( Position5, Cast4.Normal, Table, Wall )
        end
    end
end

local Table3 = {
    Hit = function( Key, Argument2, Argument3 )
        if #Table2 == 0 or typeof( Key ) ~= "Instance" or typeof( Argument2 ) ~= "Vector3" then
            return
        end
        if ( Argument2 - CurrentCamera.CFrame.Position ).Magnitude > 140 then
            return
        end

        local Entry2
        local Clock = os.clock( )
        local Entry = Class[ Key ]

        if Entry then
            Entry2 = Entry
        else
            local Table = { wall = 0, floor = 0 }
            Class[ Key ] = Table
            Entry2 = Table
        end

        local Flag = Clock - Entry2.wall >= 0.25 and true or false
        local Flag2 = Clock - Entry2.floor >= 0.4 and true or false

        if not Flag and not Flag2 then
            return
        end
        if Clock - Number2 > 0.008 then
            Number2 = Clock
            Number3 = 0
        end
        if Number3 >= 3 then
            return
        end
        task.spawn( Splat, Key, Argument2, Argument3, Clock, Flag, Flag2, Entry2 )
        return
    end
}
return Table3
