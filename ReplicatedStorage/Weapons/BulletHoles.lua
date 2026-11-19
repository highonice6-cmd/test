-- ReplicatedStorage.Weapons.BulletHoles
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Result2
local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local FX = workspace:WaitForChild( "FX" )
local CurrentCamera = workspace.CurrentCamera
local Random2 = Random.new( )
local SurfaceProjectionV3 = ReplicatedStorage:WaitForChild( "SurfaceProjectionV3", 5 )
local Success, Result, Success3 = pcall( function()
    return require( SurfaceProjectionV3 ), require( SurfaceProjectionV3.Modules.MeshCache )
end )

if Success then
    Result2 = Result
else
    warn( "[BulletHoles] SurfaceProjectionV3 indisponible, impacts plats seulement :", Result )
    Success3 = nil
    Result2 = nil
end

local Flag = workspace:GetAttribute( "ShowBulletHoles" ) == true and true or false
workspace:GetAttributeChangedSignal( "ShowBulletHoles" ):Connect( function()
    local FlagInner
    FlagInner = workspace:GetAttribute( "ShowBulletHoles" ) == true and true or false
    Flag = FlagInner
end )
local Table = { }
local Table2 = { }
local Number = 0

local function ReadSettings( Argument1 )
    local Value1
    local Template = Argument1.template
    local Sx = Template.Size.X
    local Sy = Template.Size.Y
    Argument1.sx = Sx
    Argument1.sy = Sy
    Argument1.jitter = Template:GetAttribute( "SizeJitter" ) or 0.15
    Argument1.lifetime = Template:GetAttribute( "Lifetime" ) or 10
    local FadeTime = Template:GetAttribute( "FadeTime" ) or 1.5
    Argument1.fadeTime = math.min( FadeTime, Argument1.lifetime )
    Number = 0
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Sx2 = Value.sx
        Number = math.max( Number, math.max( Sx2, Value.sy ) * ( 1 + Value.jitter ) )
    end
end

local function AddVariant( Template )
    if not Template:IsA( "BasePart" ) or Template.Name:sub( 1, 10 ) ~= "BulletHole" then
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

local FX2 = game:GetService( "ReplicatedStorage" ):WaitForChild( "FX" )

if FX2:FindFirstChild( "BulletHoles" ) then
    Watch( FX2.BulletHoles )
else
    FX2.ChildAdded:Connect( function( Self )
        if Self.Name == "BulletHoles" then
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
            local Surface
            local Texture = Decal.Texture
            local Color = Decal.Color3
            local Transparency = Decal.Transparency
            Entry.texture = Texture
            Entry.color = Color
            Entry.transparency = Transparency
            local SurfaceAppearance = Entry.template:FindFirstChildWhichIsA( "SurfaceAppearance", true )
            Surface = if SurfaceAppearance then SurfaceAppearance:Clone( ) else SurfaceAppearance
            Entry.surface = Surface
            Entry.ready = true
        end
    end

    local Entry2 = Entry.ready and Entry or nil
    return Entry2
end

local Find = WorldRefs.Find( "Cars" )

local function TakesHole( Self )
    if Self.CollisionGroup == "Hitbox" or Self.Transparency >= 0.9 then
        return false
    end
    if not Find or not Find.Parent then
        Find = WorldRefs.Find( "Cars" )
    end
    if Find and Self:IsDescendantOf( Find ) then
        local Sub = Self.Name:lower( ):sub( 1, 5 )

        if Sub == "glass" or Sub == "wheel" then
            return false
        end
    end

    return true
end

local function Frame( Argument1, Argument2, Argument3, Argument4 )
    local Position
    Position = not ( math.abs( Argument3.Y ) > 0.99 ) and Vector3.new( 0, 1, 0 ) or Vector3.new( 1, 0, 0 )
    return CFrame.lookAt( Argument1, Argument2, Position ) * CFrame.Angles( 0, 0, Argument4 )
end

local function PixelsPerStud( Argument1 )
    local Magnitude = ( Argument1 - CurrentCamera.CFrame.Position ).Magnitude
    return CurrentCamera.ViewportSize.Y / ( 2 * Magnitude * math.tan( ( math.rad( CurrentCamera.FieldOfView / 2 ) ) ) )
end

local Create = table.create( 60 )
local Number2 = 0
local Table3 = { }

local function Release( Key )
    if Key.tween then
        Key.tween:Cancel( )
        Key.tween = nil
    end
    if Key.gone then
        Key.gone:Disconnect( )
        Key.gone = nil
    end

    Table3[ Key ] = nil
end

local Class = setmetatable( { }, { __mode = "k" } )

local function ClearParked( ParkedName )
    local Value1
    local Entry = Class[ ParkedName ]
    Value1 = nil

    for Key, Value in Entry, nil, nil do
        if Key.use == Value then
            if Key.tween then
                Key.tween:Cancel( )
                Key.tween = nil
            end
            if Key.gone then
                Key.gone:Disconnect( )
                Key.gone = nil
            end

            Table3[ Key ] = nil
            Key.decal.Transparency = 1
        end
    end

    table.clear( Class[ ParkedName ] )
end

local function OnParked( ParkedName, ParkedName2 )
    local Entry2
    local Entry = Class[ ParkedName ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { }
        Class[ ParkedName ] = Table
        ParkedName:GetPropertyChangedSignal( "Anchored" ):Connect( function()
            if not ParkedName.Anchored then
                ClearParked( ParkedName )
            end
        end )
        ParkedName.AncestryChanged:Connect( function()
            if not ParkedName:IsDescendantOf( workspace ) then
                ClearParked( ParkedName )
            end
        end )
        Entry2 = Table
    end

    Entry2[ ParkedName2 ] = ParkedName2.use
end

local function ExpireFlat( Argument1 )
    local FadeAt = Argument1.fadeAt - os.clock( )

    if FadeAt > 0.03 then
        task.delay( FadeAt, ExpireFlat, Argument1 )
        return
    end
    Argument1.timer = false
    Argument1.tween = TweenService:Create( Argument1.decal, TweenInfo.new( Argument1.fadeTime, Enum.EasingStyle.Linear ), { Transparency = 1 } )
    Argument1.tween:Play( )
    return
end

local function FlatHole( Variant, Part, Argument3, Amount, Sx, Sy, Argument7, Argument8 )
    local Entry2
    Number2 = Number2 % 60 + 1
    local Entry = Create[ Number2 ]

    if not Entry or Entry.part.Parent ~= FX then
        local Parent = Instance.new( "Part" )
        Parent.Name = "BulletHole"
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
        local Table = { part = Parent, decal = Decal, use = 0 }
        Create[ Number2 ] = Table
        Entry2 = Table
    else
        if Entry.tween then
            Entry.tween:Cancel( )
            Entry.tween = nil
        end
        if Entry.gone then
            Entry.gone:Disconnect( )
            Entry.gone = nil
        end

        Table3[ Entry ] = nil
        Entry2 = Entry
    end

    Entry2.use = Entry2.use + 1
    local Part2 = Entry2.part
    local Decal2 = Entry2.decal
    local Use = Entry2.use

    if Entry2.variant ~= Variant then
        Entry2.variant = Variant
        local Texture = Variant.texture
        local Color32 = Variant.color
        Decal2.Texture = Texture
        Decal2.Color3 = Color32
    end
    if Decal2.Transparency ~= Variant.transparency then
        Decal2.Transparency = Variant.transparency
    end
    if Entry2.debug ~= Flag then
        local Transparency
        Entry2.debug = Flag
        local Color = Color3.fromRGB( 0, 170, 255 )
        Transparency = not Flag and 1 or 0.5
        Part2.Material = Enum.Material.Neon
        Part2.Color = Color
        Part2.Transparency = Transparency
    end

    local Position
    Part2.Size = Vector3.new( Sx, Sy, 0.05 )
    local Result = Argument3 + Amount * -0.015000000000000001
    local Result2 = Result + Amount
    Position = not ( math.abs( Amount.Y ) > 0.99 ) and Vector3.new( 0, 1, 0 ) or Vector3.new( 1, 0, 0 )
    local NotAnchored2
    Part2.CFrame = CFrame.lookAt( Result, Result2, Position ) * CFrame.Angles( 0, 0, Argument7 )
    local NotAnchored = not Part.Anchored
    NotAnchored2 = if NotAnchored then Part.AssemblyRootPart else NotAnchored

    if not NotAnchored2 or not NotAnchored2.Anchored then
        if NotAnchored2 then
            Table3[ Entry2 ] = { target = Part, rel = Part.CFrame:ToObjectSpace( Part2.CFrame ) }
            Entry2.gone = Part.AncestryChanged:Connect( function()
                if Entry2.use == Use and not Part:IsDescendantOf( workspace ) then
                    if Entry2.tween then
                        Entry2.tween:Cancel( )
                        Entry2.tween = nil
                    end
                    if Entry2.gone then
                        Entry2.gone:Disconnect( )
                        Entry2.gone = nil
                    end

                    Table3[ Entry2 ] = nil
                    Decal2.Transparency = 1
                end
            end )
        end
    else
        OnParked( NotAnchored2, Entry2 )
    end
    if Part2.Parent ~= FX then
        Part2.Parent = FX
    end

    local FadeAt = Argument8 + Variant.lifetime - Variant.fadeTime
    local FadeTime = Variant.fadeTime
    Entry2.fadeAt = FadeAt
    Entry2.fadeTime = FadeTime

    if not Entry2.timer then
        Entry2.timer = true
        task.delay( Variant.lifetime - Variant.fadeTime, ExpireFlat, Entry2 )
    end
end

local OverlapParams2 = OverlapParams.new( )
OverlapParams2.CollisionGroup = "Bullet"
local OverlapParams3 = OverlapParams.new( )
OverlapParams3.CollisionGroup = "Bullet"
OverlapParams3.FilterType = Enum.RaycastFilterType.Include
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.CollisionGroup = "Bullet"
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
local Flag2 = false
local Number3 = 2
local Number4 = 0

local function LiesFlat( LookAt, Sx, Sy, Amount3 )
    if not Flag2 then
        local Flag
        local ClientHitboxes = workspace:FindFirstChild( "ClientHitboxes" )
        RaycastParams2.FilterDescendantsInstances = { FX, ClientHitboxes }
        Flag = ClientHitboxes ~= nil and true or false
        Flag2 = Flag
    end

    local I = 1

    for I = 1, 4 do
        local Result = I % 2 == 0 and Sx / 2 or -Sx / 2
        local Result2 = I > 2 and Sy / 2 or -Sy / 2
        local Raycast = workspace:Raycast( LookAt * Vector3.new( Result, Result2, 0 ) + Amount3 * 0.05, Amount3 * -0.1, RaycastParams2 )

        if not Raycast or Raycast.Normal:Dot( Amount3 ) < 0.98 then
            return false
        end
    end

    return true
end

local Table4 = { }

local function RemoveProjected( Argument1 )
    if not Argument1.alive then
        return
    end

    Argument1.alive = false
    local Find = table.find( Table4, Argument1 )

    if Find then
        table.remove( Table4, Find )
    end

    Argument1.part:Destroy( )

    if Argument1.mesh then
        Argument1.mesh:Destroy( )
    end
end

local function FadeProjected( Argument1, Argument2 )
    if Argument1.alive then
        local Create = TweenService:Create( Argument1.part, TweenInfo.new( Argument2, Enum.EasingStyle.Linear ), { Transparency = 1 } )
        Create.Completed:Once( function()
            RemoveProjected( Argument1 )
        end )
        Create:Play( )
        return
    end
    return
end

local function Projectable( Part )
    local IsA3
    local Anchored = Part.Anchored

    if Anchored then
        local TakesHole2 = TakesHole( Part )

        if TakesHole2 then
            local IsA = Part:IsA( "Part" )

            if IsA then
                IsA3 = IsA
            else
                local IsA2 = Part:IsA( "TrussPart" )

                if IsA2 then
                    IsA3 = IsA2
                else
                    IsA3 = Part:IsA( "MeshPart" )
                end
            end
        else
            IsA3 = TakesHole2
        end
    else
        IsA3 = Anchored
    end

    return IsA3
end

local function ProjectedHole( Argument1, Part, Amount, LookAt, Sx, Sy, Argument7 )
    Number3 = math.min( 2, Number3 + ( Argument7 - Number4 ) * 10 )
    Number4 = Argument7

    if Number3 < 1 then
        return false
    end

    local FlagInner
    local Vector32 = Vector3.new( Sx, Sy, 0.3 )
    local FilterDescendantsInstances = { }
    FlagInner = false

    for Key, Value in workspace:GetPartBoundsInBox( LookAt, Vector32, OverlapParams2 ) do
        local IsA3
        local Anchored = Value.Anchored

        if Anchored then
            local TakesHole2 = TakesHole( Value )

            if TakesHole2 then
                local IsA = Value:IsA( "Part" )

                if IsA then
                    IsA3 = IsA
                else
                    local IsA2 = Value:IsA( "TrussPart" )

                    if IsA2 then
                        IsA3 = IsA2
                    else
                        IsA3 = Value:IsA( "MeshPart" )
                    end
                end
            else
                IsA3 = TakesHole2
            end
        else
            IsA3 = Anchored
        end
        if IsA3 then
            local State2

            if Value:IsA( "MeshPart" ) then
                local State = Success3.State( Value )

                if State then
                    State2 = State
                else
                    State2 = "ready"
                end
            else
                State2 = "ready"
            end
            if State2 == "ready" then
                local Flag2
                table.insert( FilterDescendantsInstances, Value )

                if FlagInner then
                    Flag2 = FlagInner
                elseif Value == Part then
                    Flag2 = true
                else
                    Flag2 = false
                end

                FlagInner = Flag2
            elseif State2 == "new" then
                Success3.Request( Value )
            end
        end
    end
    if not FlagInner then
        return false
    end

    Number3 = Number3 - 1
    OverlapParams3.FilterDescendantsInstances = FilterDescendantsInstances
    local Success, Parent, Success3Inner = pcall( Result2, LookAt, Vector32, OverlapParams3, 0.35 )

    if not Success or not Parent then
        return false
    end

    Parent.Name = "BulletHole"
    Parent.CanTouch = false
    Parent.CastShadow = false
    Parent.CFrame = Parent.CFrame + Amount * 0.01

    if Flag then
        local Color = Color3.fromRGB( 255, 0, 200 )
        Parent.Material = Enum.Material.Neon
        Parent.Color = Color
        Parent.Transparency = 0.35
    else
        Argument1.surface:Clone( ).Parent = Parent
    end

    Parent.Parent = FX
    local Table = { part = Parent, mesh = Success3Inner, alive = true }
    table.insert( Table4, Table )

    if #Table4 > 12 then
        RemoveProjected( Table4[ 1 ] )
    end

    local Lifetime = Argument1.lifetime - Argument1.fadeTime
    task.delay( Lifetime, FadeProjected, Table, Argument1.fadeTime )
    return true
end

local Number5 = 0
local Number6 = 0

local function SpawnHole( Part, Argument2, Amount3, Argument4, Argument5, Argument6, Amount )
    if typeof( Part ) ~= "Instance" or not Part:IsA( "BasePart" ) or not TakesHole( Part ) then
        return
    end

    local PickVariant2 = PickVariant( )

    if not PickVariant2 then
        return
    end

    local NextNumber = ( 1 + Random2:NextNumber( -1, 1 ) * PickVariant2.jitter ) * Amount
    local Sx = PickVariant2.sx * NextNumber
    local Sy = PickVariant2.sy * NextNumber
    local Max = math.max( Sx, Sy ) * Argument5

    if Max < 3 then
        return
    end
    if not Argument4 then
        Number6 = Number6 + 1
    end

    local NextNumber2 = Random2:NextNumber( 0, 6.283185307179586 )

    if Max >= 16 and Result2 and PickVariant2.surface and Part.Anchored then
        local Position
        local Total = Argument2 - Amount3
        Position = not ( math.abs( Amount3.Y ) > 0.99 ) and Vector3.new( 0, 1, 0 ) or Vector3.new( 1, 0, 0 )
        local LookAt = CFrame.lookAt( Argument2, Total, Position ) * CFrame.Angles( 0, 0, NextNumber2 )

        if not LiesFlat( LookAt, Sx, Sy, Amount3 ) and ProjectedHole( PickVariant2, Part, Amount3, LookAt, Sx, Sy, Argument6 ) then
            return
        end
    end

    FlatHole( PickVariant2, Part, Argument2, Amount3, Sx, Sy, NextNumber2, Argument6 )
end

local Table5 = {
    Spawn = function( Argument1, Argument2, Argument3, Argument4, Amount )
        local NumberInner = Amount or 1
        local Magnitude = ( Argument2 - CurrentCamera.CFrame.Position ).Magnitude
        local Y = CurrentCamera.ViewportSize.Y / ( 2 * Magnitude * math.tan( ( math.rad( CurrentCamera.FieldOfView / 2 ) ) ) )

        if Number * NumberInner * Y < 3 then
            return
        end

        local Clock = os.clock( )

        if not Argument4 then
            if Clock - Number5 > 0.016666666666666666 then
                Number5 = Clock
                Number6 = 0
            end
            if Number6 >= 2 then
                return
            end
        end

        task.spawn( SpawnHole, Argument1, Argument2, Argument3, Argument4, Y, Clock, NumberInner )
    end
}
game:GetService( "RunService" ).RenderStepped:Connect( function()
    if next( Table3 ) == nil then
        return
    end

    local Value1
    local Table = { }
    local Table2 = { }
    Value1 = nil

    for Key, Value in Table3, nil, nil do
        if Value.target.Parent then
            table.insert( Table, Key.part )
            table.insert( Table2, Value.target.CFrame * Value.rel )
        end
    end
    if #Table > 0 then
        workspace:BulkMoveTo( Table, Table2, Enum.BulkMoveMode.FireCFrameChanged )
    end
end )
return Table5
