-- Players.perkbrokeyou.PlayerScripts.EssaiBubbleClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #46

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute2 = Upvalue1:GetAttribute( Attribute )

if Attribute2 == nil then
    return Argument2
end
return Attribute2
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local PointToObjectSpace = Argument1.CFrame:PointToObjectSpace( Argument2 )
local Size = Argument1.Size / 2

if math.abs( PointToObjectSpace.X ) <= Size.X then
    if math.abs( PointToObjectSpace.Y ) <= Size.Y then
        if math.abs( PointToObjectSpace.Z ) <= Size.Z then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Cancel( )
    Upvalue1 = nil
end
if Upvalue2 and Upvalue3[ Upvalue2 ] then
    Upvalue2.StudsOffsetWorldSpace = Upvalue3[ Upvalue2 ]
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Cancel( )
    Upvalue1 = nil
end
if Upvalue2 and Upvalue3[ Upvalue2 ] then
    Upvalue2.StudsOffsetWorldSpace = Upvalue3[ Upvalue2 ]
end

local BillboardGui = M4_Bubble:FindFirstChildWhichIsA( "BillboardGui", true )

if not BillboardGui then
    return
end
if not Upvalue4 then
    Upvalue4 = Instance.new( "Attachment" )
    Upvalue4.Name = "EssaiFleche"
    Upvalue4.Parent = workspace.Terrain
end

local StudsOffsetWorldSpace
Upvalue4.WorldPosition = WorldPosition
BillboardGui.Adornee = Upvalue4
local Entry = Upvalue3[ BillboardGui ]
StudsOffsetWorldSpace = if Entry then Entry else BillboardGui.StudsOffsetWorldSpace
Upvalue3[ BillboardGui ] = StudsOffsetWorldSpace
Upvalue2 = BillboardGui
BillboardGui.StudsOffsetWorldSpace = StudsOffsetWorldSpace
Upvalue1 = Upvalue5:Create( BillboardGui, TweenInfo.new( 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true ), {
    StudsOffsetWorldSpace = StudsOffsetWorldSpace + Vector3.new( 0, 0.30000001192092896, 0 )
} )
Upvalue1:Play( )
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Disconnect( )
    Upvalue1 = nil
end
if Upvalue2 then
    Upvalue2:Cancel( )
    Upvalue2 = nil
end
if Upvalue3 and Upvalue4[ Upvalue3 ] then
    Upvalue3.StudsOffsetWorldSpace = Upvalue4[ Upvalue3 ]
end
if Upvalue5 and Upvalue5.Parent and Upvalue6 then
    Upvalue5:PivotTo( Upvalue6 )
end

Upvalue5 = nil
Upvalue6 = nil
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    local Clock = os.clock( )

    if Upvalue8 <= Clock then
        local Flag
        Upvalue8 = Clock + 0.5
        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera == nil then
            Flag = false
        elseif ( CurrentCamera.CFrame.Position - Upvalue10 ).Magnitude > 250 then
            Flag = true
        else
            Flag = false
        end

        Upvalue9 = Flag
    end
    if Upvalue9 then
        return
    end

    local Clock2 = Clock - Upvalue11
    Upvalue1:PivotTo( CFrame.new( Upvalue10 + Vector3.new( 0, math.sin( Clock2 * 2 * 3.141592653589793 / 2.6 ) * 0.06, 0 ) ) * CFrame.Angles( 0, Clock2 * 0.4886921905584123, 0 ) * CFrame.new( -Upvalue10 ) * Upvalue12 )

    if Upvalue13 <= Clock then
        local Value1
        Upvalue13 = Clock + 1.3
        Value1 = nil

        for Key, Value in Upvalue14, nil, nil do
            Value:Emit( 2 )
        end
    end

    return
end
if Upvalue2 then
    Upvalue2:Disconnect( )
    Upvalue2 = nil
end
if Upvalue3 then
    Upvalue3:Cancel( )
    Upvalue3 = nil
end
if Upvalue4 and Upvalue5[ Upvalue4 ] then
    Upvalue4.StudsOffsetWorldSpace = Upvalue5[ Upvalue4 ]
end
if Upvalue6 and Upvalue6.Parent and Upvalue7 then
    Upvalue6:PivotTo( Upvalue7 )
end

Upvalue6 = nil
Upvalue7 = nil
return
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end

local M4_Bubble = Upvalue3:FindFirstChild( "M4_Bubble" )

if not M4_Bubble or not M4_Bubble:FindFirstChildWhichIsA( "BasePart", true ) then
    return
end

local Pivot = M4_Bubble:GetPivot( )
local Position = M4_Bubble:GetBoundingBox( ).Position
local Table = { }

for Key, Value in M4_Bubble:GetDescendants( ) do
    if Value:IsA( "ParticleEmitter" ) and Value.Parent and Value.Parent.Name == "Bulles" then
        table.insert( Table, Value )
    end
end

Upvalue4 = M4_Bubble
Upvalue5 = Pivot
Upvalue6( M4_Bubble, Position )
local Clock = os.clock( )
local Clock2 = Clock + 0.6
local Flag = false
local Number = 0
Upvalue1 = Upvalue7.RenderStepped:Connect( function()
    if M4_Bubble.Parent then
        local ClockInner = os.clock( )

        if Number <= ClockInner then
            local FlagInner
            Number = ClockInner + 0.5
            local CurrentCamera = workspace.CurrentCamera

            if CurrentCamera == nil then
                FlagInner = false
            elseif ( CurrentCamera.CFrame.Position - Position ).Magnitude > 250 then
                FlagInner = true
            else
                FlagInner = false
            end

            Flag = FlagInner
        end
        if Flag then
            return
        end

        local Clock2Inner = ClockInner - Clock
        M4_Bubble:PivotTo( CFrame.new( Position + Vector3.new( 0, math.sin( Clock2Inner * 2 * 3.141592653589793 / 2.6 ) * 0.06, 0 ) ) * CFrame.Angles( 0, Clock2Inner * 0.4886921905584123, 0 ) * CFrame.new( -Position ) * Pivot )

        if Clock2 <= ClockInner then
            local Value1
            Clock2 = ClockInner + 1.3
            Value1 = nil

            for Key, Value in Table, nil, nil do
                Value:Emit( 2 )
            end
        end

        return
    end
    if Upvalue1 then
        Upvalue1:Disconnect( )
        Upvalue1 = nil
    end
    if Upvalue8 then
        Upvalue8:Cancel( )
        Upvalue8 = nil
    end
    if Upvalue9 and Upvalue10[ Upvalue9 ] then
        Upvalue9.StudsOffsetWorldSpace = Upvalue10[ Upvalue9 ]
    end
    if Upvalue4 and Upvalue4.Parent and Upvalue5 then
        Upvalue4:PivotTo( Upvalue5 )
    end

    Upvalue4 = nil
    Upvalue5 = nil
    return
end )
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Cf0 = Key.cf0
local Cf02 = Cf0 * Vector3.new( 0, -Key.part.Size.Y / 2, 0 )
local Cross = Cf0.UpVector:Cross( -Cf0.LookVector )
return CFrame.new( Cf02 ) * CFrame.fromAxisAngle( Cross, Argument2 ) * CFrame.new( -Cf02 ) * Cf0
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Clock = os.clock( )
local Table = { }
Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Clamp = math.clamp( ( Clock - Value.t0 ) / Value.dur, 0, 1 )
    local Value4 = Upvalue2:GetValue( Clamp, Value.style, Enum.EasingDirection.Out )
    Key.angle = Value.from + ( Value.to - Value.from ) * Value4

    if Key.part.Parent then
        local Part = Key.part
        Part.CFrame = Upvalue3( Key, Key.angle )
    end
    if Clamp >= 1 then
        table.insert( Table, Key )
    end
end

local Value2 = nil

for Key2, Value3 in Table, nil, nil do
    Upvalue1[ Value3 ] = nil
end
if next( Upvalue1 ) == nil and Upvalue4 then
    Upvalue4:Disconnect( )
    Upvalue4 = nil
end
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1[ Key ] = {
    from = Key.angle,
    to = Argument2,
    t0 = os.clock( ),
    dur = Argument3,
    style = Argument4
}

if not Upvalue2 then
    Upvalue2 = Upvalue3.RenderStepped:Connect( Upvalue4 )
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.gen ~= Upvalue2 then
    return
end

local Hp
Upvalue1.down = false
local PvCible = Upvalue3:GetAttribute( "PvCible" )
Hp = if PvCible == nil then 150 else PvCible
Upvalue1.hp = Hp
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.gen == Upvalue2 then
    Upvalue3( Upvalue1, 0, 0.35, Enum.EasingStyle.Back )
    task.delay( 0.35, function()
        if Upvalue1.gen ~= Upvalue2 then
            return
        end

        local Hp
        Upvalue1.down = false
        local PvCible = Upvalue4:GetAttribute( "PvCible" )
        Hp = if PvCible == nil then 150 else PvCible
        Upvalue1.hp = Hp
    end )
    return
end
return
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
Key.down = true
Upvalue1( Key, 1.53588974175501, 0.45, Enum.EasingStyle.Bounce )
local Gen = Key.gen
local Remontee = Upvalue2:GetAttribute( "Remontee" )
Number = if Remontee == nil then 3 else Remontee
task.delay( Number, function()
    if Key.gen == Gen then
        Upvalue1( Key, 0, 0.35, Enum.EasingStyle.Back )
        task.delay( 0.35, function()
            if Key.gen ~= Gen then
                return
            end

            local Hp
            Key.down = false
            local PvCible = Upvalue2:GetAttribute( "PvCible" )
            Hp = if PvCible == nil then 150 else PvCible
            Key.hp = Hp
        end )
        return
    end
    return
end )
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Score
local Ecran = Upvalue1:FindFirstChild( "Ecran" )

if Ecran then
    Score = Ecran:FindFirstChild( "Score" )
else
    Score = Ecran
end

local Chiffres

if Score then
    Chiffres = Score:FindFirstChild( "Chiffres" )
else
    Chiffres = Score
end
if not Chiffres then
    return
end

local Value1
local Clamp = math.clamp( Upvalue2, 0, 99 )
local Table = { Clamp // 10, Clamp % 10 }
Value1 = nil

for Key, Value in Table, nil, nil do
    local FoundChild = Chiffres:FindFirstChild( "D" .. Key )
    local Entry = Upvalue3[ Value + 1 ]

    if FoundChild and Entry then
        local J = 1

        for J = 1, 7 do
            local K = 1

            for K = 1, 5 do
                local FoundChild2 = FoundChild:FindFirstChild( "B" .. J .. K )

                if FoundChild2 then
                    local Visible = Entry[ J ]:sub( K, K ) == "1" and true or false
                    FoundChild2.Visible = Visible
                end
            end
        end
    end
end
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Score then
    return
end
Upvalue1 = Score
Upvalue2( )
return
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 <= List[ 1 ][ 1 ] then
    return List[ 1 ][ 2 ]
end

local Count = #List
local I = 2

for I = 2, Count do
    local Entry = List[ I - 1 ]
    local Entry2 = List[ I ]

    if Argument2 <= Entry2[ 1 ] then
        return Entry[ 2 ] + ( Entry2[ 2 ] - Entry[ 2 ] ) * ( Argument2 - Entry[ 1 ] ) / ( Entry2[ 1 ] - Entry[ 1 ] )
    end
end

return List[ #List ][ 2 ]
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1[ ForName ]
Entry2 = if Entry then Entry.Damage else Entry

if not Entry2 then
    return 0
end

local Number

if Entry2.Curve then
    Number = Upvalue2( Entry2.Curve, Argument3 )
elseif not Entry2.FalloffStart or not ( Entry2.FalloffStart < Argument3 ) then
    Number = 1
else
    Number = Upvalue3.Global.FarDamageScale or 0.9
end

local Headshot = Flag and Entry2.Headshot or 1
return ( math.floor( Entry2.Base * Number * Headshot + 0.5 ) )
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

if not ( ShotName and Upvalue1[ ShotName ] ) or ( ShotName and Upvalue1[ ShotName ] ).down or not Upvalue2 or typeof( Argument2 ) ~= "Vector3" then
    return
end

local Number
local CentreCible = Upvalue3:GetAttribute( "CentreCible" )
Number = if CentreCible == nil then 1.47 else CentreCible
local Number2
local PointToObjectSpace = ShotName.CFrame:PointToObjectSpace( Argument2 )
local Sqrt = math.sqrt( PointToObjectSpace.X * PointToObjectSpace.X + ( PointToObjectSpace.Y - Number ) ^ 2 )
local RayonCible = Upvalue3:GetAttribute( "RayonCible" )
Number2 = if RayonCible == nil then 0.7 else RayonCible

if Number2 < Sqrt then
    return
end

local Number3
local RayonTete = Upvalue3:GetAttribute( "RayonTete" )
Number3 = if RayonTete == nil then 0.15 else RayonTete
local Flag = Sqrt <= Number3 and true or false
local Magnitude2

if typeof( Argument3 ) == "Vector3" then
    local Magnitude = ( Argument2 - Argument3 ).Magnitude

    if Magnitude then
        Magnitude2 = Magnitude
    else
        Magnitude2 = 0
    end
else
    Magnitude2 = 0
end

local Value1 = Upvalue4( Upvalue2:GetAttribute( "Weapon" ) or "M4", Flag, Magnitude2 )

if Value1 <= 0 then
    return
end

local Flag2
;( ShotName and Upvalue1[ ShotName ] ).hp = ( ShotName and Upvalue1[ ShotName ] ).hp - Value1
Flag2 = ( ShotName and Upvalue1[ ShotName ] ).hp <= 0 and true or false

if Upvalue5.ShowDamageNumber then
    Upvalue5.ShowDamageNumber( {
        HitPos = Argument2,
        Damage = Value1,
        Headshot = Flag,
        Target = ( ShotName and Upvalue1[ ShotName ] ).marker
    } )
end

local Table = {
    HitPos = Argument2,
    Damage = Value1,
    Headshot = Flag,
    Killed = Flag2,
    Downable = false
}

if Upvalue5.ConfirmHit then
    Upvalue5.ConfirmHit( Table )
elseif Upvalue5.ShowHitmarker then
    Upvalue5.ShowHitmarker( Table )
end
if Flag2 then
    local EssaiKill = Upvalue3:FindFirstChild( "EssaiKill" )

    if EssaiKill then
        EssaiKill:FireServer( ( ShotName and Upvalue1[ ShotName ] ).cf0 * Vector3.new( 0, Number, 0 ) )
    end

    Upvalue6( ShotName and Upvalue1[ ShotName ] )
    local Captured = Upvalue7 + 1

    if Upvalue7 == Captured then
        return
    end

    Upvalue7 = Captured
    Upvalue8( )
end
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Buildings
local Map = workspace:FindFirstChild( "Map" )

if Map then
    Buildings = Map:FindFirstChild( "Buildings" )
else
    Buildings = Map
end

local GunStore

if Buildings then
    GunStore = Buildings:FindFirstChild( "GunStore" )
else
    GunStore = Buildings
end

local Structure

if GunStore then
    Structure = GunStore:FindFirstChild( "Structure" )
else
    Structure = GunStore
end

local Map2 = if Structure then Structure:FindFirstChild( "Walls" ) else Structure
return Map2
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
Upvalue1 = Instance.new( "Folder" )
Upvalue1.Name = "EssaiCibles"
Upvalue1.Parent = workspace.CurrentCamera
local CentreCible = Upvalue2:GetAttribute( "CentreCible" )
Number = if CentreCible == nil then 1.47 else CentreCible
local Children
local Value1 = Upvalue3( )
Children = Value1 and Value1:GetChildren( ) or { }
local Value2 = nil

for Key, Value in Children, nil, nil do
    if Value:IsA( "BasePart" ) and Value.Name:find( "RANGETARGET", 1, true ) then
        local Hp
        local Parent = Instance.new( "Model" )
        Parent.Name = "Cible"
        local Part = Instance.new( "Part" )
        Part.Name = "Head"
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CastShadow = false
        Part.Transparency = 1
        Part.Size = Vector3.new( 0.10000000149011612, 0.10000000149011612, 0.10000000149011612 )
        Part.CFrame = Value.CFrame * CFrame.new( 0, Number, 0 )
        Part.Parent = Parent
        Parent.Parent = Upvalue1
        local Table = { part = Value, cf0 = Value.CFrame, down = false, angle = 0, gen = 0 }
        local PvCible = Upvalue2:GetAttribute( "PvCible" )
        Hp = if PvCible == nil then 150 else PvCible
        Table.hp = Hp
        Table.marker = Parent
        Upvalue4[ Value ] = Table
    end
end

Upvalue5.RangeShot = Upvalue6
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.RangeShot == Upvalue2 then
    Upvalue1.RangeShot = nil
end

local Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    Value.gen = Value.gen + 1
    Upvalue4[ Value ] = nil

    if Key.Parent then
        Key.CFrame = Value.cf0
    end
end

table.clear( Upvalue3 )

if Upvalue5 then
    Upvalue5:Destroy( )
    Upvalue5 = nil
end
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local EssaiPrompt
local Bouton = Upvalue1:FindFirstChild( "Bouton" )

if Bouton then
    EssaiPrompt = Bouton:FindFirstChild( "EssaiPrompt" )
else
    EssaiPrompt = Bouton
end
if EssaiPrompt then
    EssaiPrompt.Enabled = Enabled
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

for Value in tostring( Upvalue1:GetAttribute( "CacherPendantEssai" ) or "M4_Bubble" ):gmatch( "[^,%s]+" ) do
    if Value == Argument1 then
        return true
    end
end

return false
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local LocalTransparencyModifier = not Upvalue2 and 0 or 1
Upvalue1.LocalTransparencyModifier = LocalTransparencyModifier
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { Object, table.unpack( Object:GetDescendants( ) ) }
Value1 = nil

for Key, Value in Table, nil, nil do
    if Value:IsA( "BasePart" ) then
        local LocalTransparencyModifier = not Argument2 and 0 or 1
        Value.LocalTransparencyModifier = LocalTransparencyModifier
    elseif Value:IsA( "Decal" ) then
        pcall( function()
            local LocalTransparencyModifier = not Argument2 and 0 or 1
            Value.LocalTransparencyModifier = LocalTransparencyModifier
        end )
    elseif Argument2 then
        if Value:IsA( "ParticleEmitter" ) or Value:IsA( "Beam" ) or Value:IsA( "Trail" ) or Value:IsA( "Light" ) or Value:IsA( "LayerCollector" ) or Value:IsA( "Highlight" ) then
            if Value.Enabled then
                Value.Enabled = false
                table.insert( Upvalue1, Value )
            end
            if Value:IsA( "ParticleEmitter" ) then
                Value:Clear( )
            end
        end
    end
end
]]

-- Could not structure function #25

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if workspace:GetAttribute( "BeginnerServer" ) == true then
    if Upvalue1:GetAttribute( "EssaiBubbleOk" ) == true then
        Flag = false
    else
        Flag = true
    end
else
    Flag = false
end
if Flag == Upvalue2 then
    return
end

Upvalue2 = Flag

if not Flag then
    for Key2, Value2 in Upvalue9:GetChildren( ) do
        Upvalue10( Value2, false )
    end

    local Value1 = nil

    for Key3, Value3 in Upvalue11, nil, nil do
        if Value3.Parent then
            Value3.Enabled = true
        end
    end

    local EssaiPrompt2
    table.clear( Upvalue11 )
    local Bouton2 = Upvalue9:FindFirstChild( "Bouton" )

    if Bouton2 then
        EssaiPrompt2 = Bouton2:FindFirstChild( "EssaiPrompt" )
    else
        EssaiPrompt2 = Bouton2
    end
    if EssaiPrompt2 then
        EssaiPrompt2.Enabled = true
    end

    local Character = Upvalue12.Character

    if not Character or Character:GetAttribute( "InSafeZone" ) ~= true then
        return
    end

    Upvalue13( )
    return
end
if Upvalue3 then
    Upvalue3:Disconnect( )
    Upvalue3 = nil
end
if Upvalue4 then
    Upvalue4:Cancel( )
    Upvalue4 = nil
end
if Upvalue5 and Upvalue6[ Upvalue5 ] then
    Upvalue5.StudsOffsetWorldSpace = Upvalue6[ Upvalue5 ]
end
if Upvalue7 and Upvalue7.Parent and Upvalue8 then
    Upvalue7:PivotTo( Upvalue8 )
end

Upvalue7 = nil
Upvalue8 = nil

for Key, Value in Upvalue9:GetChildren( ) do
    Upvalue10( Value, true )
end

local EssaiPrompt
local Bouton = Upvalue9:FindFirstChild( "Bouton" )

if Bouton then
    EssaiPrompt = Bouton:FindFirstChild( "EssaiPrompt" )
else
    EssaiPrompt = Bouton
end
if EssaiPrompt then
    EssaiPrompt.Enabled = false
    return
end
return
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    task.defer( Upvalue2, Argument1, true )
end
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Part = Instance.new( "Part" )
Part.Name = Name
Part.Shape = Enum.PartType.Ball
Part.Material = Material
Part.Color = Color
Part.Transparency = Transparency
Part.Anchored = true
Part.CanCollide = false
Part.CanQuery = false
Part.CanTouch = false
Part.CastShadow = false
Part.Parent = Upvalue1
return Part
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = tonumber( Self:GetAttribute( "TankBubbles" ) ) or 0
local TankPart = Self:GetAttribute( "TankPart" )

if Number <= 0 or type( TankPart ) ~= "string" then
    return nil
end

local FoundChild = Parent

for Value in TankPart:gmatch( "[^/]+" ) do
    local FoundChild2 = if FoundChild then FoundChild:FindFirstChild( Value ) else FoundChild
    FoundChild = FoundChild2
end
if not FoundChild or not FoundChild:IsA( "BasePart" ) then
    return nil
end

local NumberRange2
local BubbleSize = Self:GetAttribute( "BubbleSize" )
local BubbleSpeed = Self:GetAttribute( "BubbleSpeed" )

if typeof( BubbleSize ) ~= "NumberRange" or not BubbleSize then
    NumberRange2 = NumberRange.new( 0.05, 0.09 )
else
    NumberRange2 = BubbleSize
end

local NumberRange3

if typeof( BubbleSpeed ) ~= "NumberRange" or not BubbleSpeed then
    NumberRange3 = NumberRange.new( 0.08, 0.15 )
else
    NumberRange3 = BubbleSpeed
end

local Color
local BubbleColor = Self:GetAttribute( "BubbleColor" )

if typeof( BubbleColor ) ~= "Color3" or not BubbleColor then
    Color = Color3.fromRGB( 225, 247, 255 )
else
    Color = BubbleColor
end

local function Ball( Name, Material, Color, Transparency )
    local Part = Instance.new( "Part" )
    Part.Name = Name
    Part.Shape = Enum.PartType.Ball
    Part.Material = Material
    Part.Color = Color
    Part.Transparency = Transparency
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Parent = Parent
    return Part
end

local Random2 = Random.new( )
local Table = {
    box = FoundChild,
    list = { },
    rise = tonumber( Self:GetAttribute( "BubbleRise" ) ) or 0.2,
    bottom = -FoundChild.Size.Y / 2
}
local I = 1

for I = 1, Number do
    local NextNumber = Random2:NextNumber( NumberRange2.Min, NumberRange2.Max )
    local List = Table.list
    local Part = Instance.new( "Part" )
    Part.Name = "Bulle"
    Part.Shape = Enum.PartType.Ball
    Part.Material = Enum.Material.ForceField
    Part.Color = Color
    Part.Transparency = 0
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Parent = Parent
    local Color2 = Color3.new( 1, 1, 1 )
    local Part2 = Instance.new( "Part" )
    Part2.Name = "Reflet"
    Part2.Shape = Enum.PartType.Ball
    Part2.Material = Enum.Material.Neon
    Part2.Color = Color2
    Part2.Transparency = 0.2
    Part2.Anchored = true
    Part2.CanCollide = false
    Part2.CanQuery = false
    Part2.CanTouch = false
    Part2.CastShadow = false
    Part2.Parent = Parent
    table.insert( List, {
        b = Part,
        h = Part2,
        d = NextNumber,
        x = Random2:NextNumber( -0.5, 0.5 ) * math.max( FoundChild.Size.X - NextNumber, 0 ),
        z = Random2:NextNumber( -0.5, 0.5 ) * math.max( FoundChild.Size.Z - NextNumber, 0 ),
        v = Random2:NextNumber( NumberRange3.Min, NumberRange3.Max ),
        ph = Random2:NextNumber( ),
        w = Random2:NextNumber( 0, 6.28 )
    } )
end

return Table
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local CFrame2 = Argument1.box.CFrame
local RightVector = Argument3.RightVector
local UpVector = Argument3.UpVector
local LookVector = Argument3.LookVector
local List = Argument1.list
Value1 = nil

for Key, Value in List, nil, nil do
    local V = ( Amount * Value.v / Argument1.rise + Value.ph ) % 1
    local D = Value.d * ( math.clamp( math.min( V, 1 - V ) * 7, 0, 1 ) * 0.65 + 0.35 )
    local X = Value.x + math.sin( Amount * 2.6 + Value.w ) * 0.01
    local Bottom = Argument1.bottom + V * Argument1.rise
    local CFrame3 = CFrame2 * Vector3.new( X, Bottom, Value.z )
    local B = Value.b
    B.Size = Vector3.new( 1, 1, 1 ) * D
    local B2 = Value.b
    B2.CFrame = CFrame.new( CFrame3 )
    local H = Value.h
    H.Size = Vector3.new( 1, 1, 1 ) * ( D * 0.22 )
    local H2 = Value.h
    H2.CFrame = CFrame.new( CFrame3 + ( UpVector * 0.24 - RightVector * 0.26 - LookVector * 0.3 ) * D )
end
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if not ( Upvalue1 and Upvalue1.key ) or not ( Upvalue1 and Upvalue1.key ):IsA( "TextLabel" ) then
    return
end
if ( Upvalue1 and Upvalue1.key ):GetAttribute( "BaseText" ) == nil then
    ( Upvalue1 and Upvalue1.key ):SetAttribute( "BaseText", ( Upvalue1 and Upvalue1.key ).Text )
end

local Text
local Binds = Upvalue2.Binds( "kbm", "Shop" )

if not Upvalue2.IsDefaultBind( "kbm", "Shop" ) or not ( #Binds > 0 ) or not ( Upvalue1 and Upvalue1.key ):GetAttribute( "BaseText" ) then
    if Binds[ 1 ] then
        local KeyName = Upvalue2.KeyName
        local KeyName2 = KeyName( Binds[ 1 ], true )

        if KeyName2 then
            Text = KeyName2
        else
            Text = ""
        end
    else
        Text = ""
    end
else
    Text = ( Upvalue1 and Upvalue1.key ):GetAttribute( "BaseText" )
end

local IsGamepad2
;( Upvalue1 and Upvalue1.key ).Text = Text
local IsGamepad = Upvalue2.IsGamepad
IsGamepad2 = if IsGamepad then IsGamepad else Upvalue2.TouchMode( )
local Visible
local NotIsGamepad = not IsGamepad2

if NotIsGamepad then
    if #Binds > 0 then
        Visible = true
    else
        Visible = false
    end
else
    Visible = NotIsGamepad
end

;( Upvalue1 and Upvalue1.key ).Visible = Visible
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.OpenShop then
    Upvalue1.OpenShop( )
end
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Captured = Upvalue1.frame.Parent and Upvalue1 or nil
    return Captured
end
local Fenetre
local Find = Upvalue2.Find( "EssaiBubbleHUD" )

if Find then
    Fenetre = Find:FindFirstChild( "Fenetre" )
else
    Fenetre = Find
end
if not Fenetre then
    return nil
end

local Parent
local Table = {
    gui = Find,
    frame = Fenetre,
    scale = Fenetre:FindFirstChildOfClass( "UIScale" ),
    embers = { },
    caustics = { }
}
local Showcase = Fenetre:FindFirstChild( "Showcase" )

if Showcase then
    Parent = Showcase:FindFirstChild( "View" )
else
    Parent = Showcase
end
if Parent and Parent:IsA( "ViewportFrame" ) then
    local Model2
    local Model = Parent:FindFirstChildWhichIsA( "Model" )
    local Name = Parent:GetAttribute( "Weapon" ) or "M4"
    local Table2 = { Skin = Parent:GetAttribute( "Skin" ) or "Bubble" }
    local SkinVisual = Upvalue3.SkinVisual( Name, Table2 )

    if SkinVisual then
        Model2 = SkinVisual:Clone( )
    else
        Model2 = SkinVisual
    end
    if Model2 then
        pcall( Upvalue3.Apply, Model2, Name, Table2 )

        if Model then
            Model2:PivotTo( Model:GetPivot( ) )
            Model:Destroy( )
        end
    else
        Model2 = Model
    end
    if Model2 then
        for Key, Value in Model2:GetDescendants( ) do
            if Value:IsA( "LuaSourceContainer" ) or Value:IsA( "Sound" ) or Value:IsA( "ParticleEmitter" ) or Value:IsA( "Light" ) or Value:IsA( "Beam" ) then
                Value:Destroy( )
            elseif Value:IsA( "BasePart" ) then
                Value.Anchored = true

                if Value:HasTag( "SkinFX" ) then
                    Value:RemoveTag( "SkinFX" )
                end
            end
        end

        local CFrame2
        local CameraCFrame = Parent:GetAttribute( "CameraCFrame" )

        if typeof( CameraCFrame ) == "CFrame" then
            CFrame2 = CameraCFrame
        else
            CFrame2 = CFrame.new( )
        end

        local CurrentCamera = Instance.new( "Camera" )
        CurrentCamera.Name = "Vitrine"
        local FieldOfView = tonumber( Parent:GetAttribute( "CameraFOV" ) ) or 24
        CurrentCamera.CFrame = CFrame2
        CurrentCamera.FieldOfView = FieldOfView
        CurrentCamera.Parent = Parent
        Parent.CurrentCamera = CurrentCamera
        Model2.Name = Name
        Table.view = Parent
        Table.model = Model2
        Table.cam = CurrentCamera
        Table.base = CFrame2
        Table.center = Model2:GetBoundingBox( ).Position
        Table.orbit = math.rad( tonumber( Parent:GetAttribute( "OrbitDeg" ) ) or 16 )
        Table.period = math.max( tonumber( Parent:GetAttribute( "OrbitPeriod" ) ) or 7, 1 )
        Table.bob = tonumber( Parent:GetAttribute( "Bob" ) ) or 0.05
        Table.tank = Upvalue4( Parent, Model2 )

        if Table.tank then
            Upvalue5( Table.tank, 0, CFrame2 )
        end

        Model2.Parent = nil
    end

    local Glow = Showcase:FindFirstChild( "Glow" )

    if Glow and Glow:IsA( "ImageLabel" ) then
        local GlowT = Glow.ImageTransparency
        local GlowSize = Glow.Size
        Table.glow = Glow
        Table.glowT = GlowT
        Table.glowSize = GlowSize
    end
end

local Shine2
local Shine = Fenetre:FindFirstChild( "Shine" )
Shine2 = if Shine then Shine:FindFirstChildOfClass( "UIGradient" ) else Shine
local Children2
Table.shine = Shine2
local Random2 = Random.new( )
local Embers = Fenetre:FindFirstChild( "Embers" )
Children2 = Embers and Embers:GetChildren( ) or { }
local Value1 = nil

for Key2, Value2 in Children2, nil, nil do
    if Value2:IsA( "GuiObject" ) then
        local Base
        local Img = Value2:IsA( "ImageLabel" )
        local Embers2 = Table.embers
        local Table3 = {
            o = Value2,
            x = Value2.Position.X.Scale,
            speed = Random2:NextNumber( 0.12, 0.32 ),
            phase = Random2:NextNumber( ),
            sway = Random2:NextNumber( 0.004, 0.014 )
        }
        Base = Img and Value2.ImageTransparency or Value2.BackgroundTransparency
        Table3.base = Base
        Table3.img = Img
        table.insert( Embers2, Table3 )
    end
end

local Children
local Caustics = Fenetre:FindFirstChild( "Caustics" )
Children = Caustics and Caustics:GetChildren( ) or { }
local Value3 = nil

for Key3, Value4 in Children, nil, nil do
    if Value4:IsA( "ImageLabel" ) then
        local Caustics2 = Table.caustics
        table.insert( Caustics2, {
            o = Value4,
            box = Caustics,
            ratio = tonumber( Value4:GetAttribute( "TileRatio" ) ) or 0.8,
            speed = tonumber( Value4:GetAttribute( "Speed" ) ) or 0.02,
            phase = Random2:NextNumber( )
        } )
    end
end

local OpenShop = Fenetre:FindFirstChild( "OpenShop" )

if OpenShop and OpenShop:IsA( "GuiButton" ) then
    OpenShop.Activated:Connect( function()
        if Upvalue6.OpenShop then
            Upvalue6.OpenShop( )
        end
    end )
    Table.key = OpenShop:FindFirstChild( "Key" )
end

Upvalue1 = Table
Upvalue7.BindsChanged:Connect( Upvalue8 )
Upvalue7.Changed:Connect( Upvalue8 )
Upvalue9.LastInputTypeChanged:Connect( Upvalue8 )
return Table
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( ) - Upvalue1

if Upvalue2.cam and Clock - Upvalue3 >= 0.03333333333333333 then
    Upvalue3 = Clock
    local Orbit = Upvalue2.orbit * math.sin( Clock * 2 * 3.141592653589793 / Upvalue2.period )
    local CFrame2 = CFrame.new( Upvalue2.center )
    local CFrame3 = CFrame2 * CFrame.Angles( 0, Orbit, 0 ) * CFrame2:Inverse( ) * Upvalue2.base + Vector3.new( 0, Upvalue2.bob * math.sin( Clock * 1.3 ), 0 )
    Upvalue2.cam.CFrame = CFrame3

    if Upvalue2.tank then
        Upvalue4( Upvalue2.tank, Clock, CFrame3 )
    end
end
if Upvalue2.glow then
    local Sin = math.sin( Clock * 2.1 ) * 0.5 + 0.5
    local Glow = Upvalue2.glow
    Glow.ImageTransparency = math.min( Upvalue2.glowT + ( 1 - Sin ) * 0.18, 1 )
    local Sin2 = Sin * 0.08 + 0.95
    local Glow2 = Upvalue2.glow
    local Scale = Upvalue2.glowSize.X.Scale * Sin2
    Glow2.Size = UDim2.new( Scale, 0, Upvalue2.glowSize.Y.Scale * Sin2, 0 )
end
if Upvalue2.shine then
    local Shine = Upvalue2.shine
    Shine.Offset = Vector2.new( math.min( Clock % 3.4 / 1.1, 1 ) * 2 + -1, 0 )
end

local Value1
local Embers = Upvalue2.embers
Value1 = nil

for Key, Value in Embers, nil, nil do
    local Clock4 = ( Clock * Value.speed + Value.phase ) % 1
    local O4 = Value.o
    O4.Position = UDim2.fromScale( Value.x + math.sin( Clock * 2 + Value.phase * 6.28 ) * Value.sway, 1.05 - Clock4 * 1.1 )
    local BackgroundTransparency = 1 - ( 1 - Value.base ) * math.sin( 3.141592653589793 * Clock4 )

    if Value.img then
        Value.o.ImageTransparency = BackgroundTransparency
    else
        Value.o.BackgroundTransparency = BackgroundTransparency
    end
end

local Value2
local Caustics = Upvalue2.caustics
Value2 = nil

for Key2, Value3 in Caustics, nil, nil do
    local Clock3
    local AbsoluteSize = Value3.box.AbsoluteSize
    local Max = math.max( 8, ( math.floor( AbsoluteSize.Y * Value3.ratio + 0.5 ) ) )
    local Clock2 = ( Clock * math.abs( Value3.speed ) + Value3.phase ) * Max % Max
    local Max2 = math.max( AbsoluteSize.X, 1 )
    local O = Value3.o
    O.TileSize = UDim2.fromOffset( Max, Max )
    local O2 = Value3.o
    O2.Size = UDim2.fromScale( Max / Max2 + 1, 1 )
    local O3 = Value3.o
    Clock3 = Value3.speed >= 0 and Clock2 - Max or -Clock2
    O3.Position = UDim2.fromScale( Clock3 / Max2, 0 )
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Disconnect( )
end

local Clock = os.clock( )
local Number = -1
Upvalue1 = Upvalue2.RenderStepped:Connect( function()
    local ClockInner = os.clock( ) - Clock

    if Argument1.cam and ClockInner - Number >= 0.03333333333333333 then
        Number = ClockInner
        local Orbit = Argument1.orbit * math.sin( ClockInner * 2 * 3.141592653589793 / Argument1.period )
        local CFrame2 = CFrame.new( Argument1.center )
        local CFrame3 = CFrame2 * CFrame.Angles( 0, Orbit, 0 ) * CFrame2:Inverse( ) * Argument1.base + Vector3.new( 0, Argument1.bob * math.sin( ClockInner * 1.3 ), 0 )
        Argument1.cam.CFrame = CFrame3

        if Argument1.tank then
            Upvalue3( Argument1.tank, ClockInner, CFrame3 )
        end
    end
    if Argument1.glow then
        local Sin = math.sin( ClockInner * 2.1 ) * 0.5 + 0.5
        local Glow = Argument1.glow
        Glow.ImageTransparency = math.min( Argument1.glowT + ( 1 - Sin ) * 0.18, 1 )
        local Sin2 = Sin * 0.08 + 0.95
        local Glow2 = Argument1.glow
        local Scale = Argument1.glowSize.X.Scale * Sin2
        Glow2.Size = UDim2.new( Scale, 0, Argument1.glowSize.Y.Scale * Sin2, 0 )
    end
    if Argument1.shine then
        local Shine = Argument1.shine
        Shine.Offset = Vector2.new( math.min( ClockInner % 3.4 / 1.1, 1 ) * 2 + -1, 0 )
    end

    local Value1
    local Embers = Argument1.embers
    Value1 = nil

    for Key, Value in Embers, nil, nil do
        local Clock4 = ( ClockInner * Value.speed + Value.phase ) % 1
        local O4 = Value.o
        O4.Position = UDim2.fromScale( Value.x + math.sin( ClockInner * 2 + Value.phase * 6.28 ) * Value.sway, 1.05 - Clock4 * 1.1 )
        local BackgroundTransparency = 1 - ( 1 - Value.base ) * math.sin( 3.141592653589793 * Clock4 )

        if Value.img then
            Value.o.ImageTransparency = BackgroundTransparency
        else
            Value.o.BackgroundTransparency = BackgroundTransparency
        end
    end

    local Value2
    local Caustics = Argument1.caustics
    Value2 = nil

    for Key2, Value3 in Caustics, nil, nil do
        local Clock3
        local AbsoluteSize = Value3.box.AbsoluteSize
        local Max = math.max( 8, ( math.floor( AbsoluteSize.Y * Value3.ratio + 0.5 ) ) )
        local Clock2 = ( ClockInner * math.abs( Value3.speed ) + Value3.phase ) * Max % Max
        local Max2 = math.max( AbsoluteSize.X, 1 )
        local O = Value3.o
        O.TileSize = UDim2.fromOffset( Max, Max )
        local O2 = Value3.o
        O2.Size = UDim2.fromScale( Max / Max2 + 1, 1 )
        local O3 = Value3.o
        Clock3 = Value3.speed >= 0 and Clock2 - Max or -Clock2
        O3.Position = UDim2.fromScale( Clock3 / Max2, 0 )
    end
end )
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = Upvalue1( )

if not Value1 then
    return
end
if not Upvalue2 then
    Upvalue2 = Upvalue3.Find( "ShopMenu" )

    if Upvalue2 then
        Upvalue3.ShownChanged( Upvalue2 ):Connect( Upvalue4 )
    end
end

local Flag = if Upvalue5 == nil then false else not ( Upvalue2 and Upvalue3.IsShown( Upvalue2 ) )

if Flag == Upvalue6 then
    return
end

Upvalue6 = Flag

if Upvalue7 then
    Upvalue7:Cancel( )
    Upvalue7 = nil
end
if Flag then
    Upvalue8( )

    if Value1.model then
        local Model = Value1.model
        Model.Parent = Value1.view
    end

    Value1.frame.Visible = true
    Value1.gui.Enabled = true

    if Value1.scale then
        Value1.scale.Scale = 0.92
        Upvalue7 = Upvalue9:Create( Value1.scale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
        Upvalue7:Play( )
    end
    if Upvalue10 then
        Upvalue10:Disconnect( )
    end

    local Clock = os.clock( )
    local Number = -1
    Upvalue10 = Upvalue11.RenderStepped:Connect( function()
        local ClockInner = os.clock( ) - Clock

        if Value1.cam and ClockInner - Number >= 0.03333333333333333 then
            Number = ClockInner
            local Orbit = Value1.orbit * math.sin( ClockInner * 2 * 3.141592653589793 / Value1.period )
            local CFrame2 = CFrame.new( Value1.center )
            local CFrame3 = CFrame2 * CFrame.Angles( 0, Orbit, 0 ) * CFrame2:Inverse( ) * Value1.base + Vector3.new( 0, Value1.bob * math.sin( ClockInner * 1.3 ), 0 )
            Value1.cam.CFrame = CFrame3

            if Value1.tank then
                Upvalue12( Value1.tank, ClockInner, CFrame3 )
            end
        end
        if Value1.glow then
            local Sin = math.sin( ClockInner * 2.1 ) * 0.5 + 0.5
            local Glow = Value1.glow
            Glow.ImageTransparency = math.min( Value1.glowT + ( 1 - Sin ) * 0.18, 1 )
            local Sin2 = Sin * 0.08 + 0.95
            local Glow2 = Value1.glow
            local Scale = Value1.glowSize.X.Scale * Sin2
            Glow2.Size = UDim2.new( Scale, 0, Value1.glowSize.Y.Scale * Sin2, 0 )
        end
        if Value1.shine then
            local Shine = Value1.shine
            Shine.Offset = Vector2.new( math.min( ClockInner % 3.4 / 1.1, 1 ) * 2 + -1, 0 )
        end

        local Value1Inner
        local Embers = Value1.embers
        Value1Inner = nil

        for Key, Value in Embers, nil, nil do
            local Clock4 = ( ClockInner * Value.speed + Value.phase ) % 1
            local O4 = Value.o
            O4.Position = UDim2.fromScale( Value.x + math.sin( ClockInner * 2 + Value.phase * 6.28 ) * Value.sway, 1.05 - Clock4 * 1.1 )
            local BackgroundTransparency = 1 - ( 1 - Value.base ) * math.sin( 3.141592653589793 * Clock4 )

            if Value.img then
                Value.o.ImageTransparency = BackgroundTransparency
            else
                Value.o.BackgroundTransparency = BackgroundTransparency
            end
        end

        local Value2
        local Caustics = Value1.caustics
        Value2 = nil

        for Key2, Value3 in Caustics, nil, nil do
            local Clock3
            local AbsoluteSize = Value3.box.AbsoluteSize
            local Max = math.max( 8, ( math.floor( AbsoluteSize.Y * Value3.ratio + 0.5 ) ) )
            local Clock2 = ( ClockInner * math.abs( Value3.speed ) + Value3.phase ) * Max % Max
            local Max2 = math.max( AbsoluteSize.X, 1 )
            local O = Value3.o
            O.TileSize = UDim2.fromOffset( Max, Max )
            local O2 = Value3.o
            O2.Size = UDim2.fromScale( Max / Max2 + 1, 1 )
            local O3 = Value3.o
            Clock3 = Value3.speed >= 0 and Clock2 - Max or -Clock2
            O3.Position = UDim2.fromScale( Clock3 / Max2, 0 )
        end
    end )
    return
end
if Upvalue10 then
    Upvalue10:Disconnect( )
    Upvalue10 = nil
end

Value1.gui.Enabled = false

if Value1.model then
    Value1.model.Parent = nil
end

return
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

Upvalue1 = nil

if Upvalue2 ~= 0 then
    Upvalue2 = 0
    Upvalue3( )
end
if Upvalue4 then
    Upvalue4:Disconnect( )
    Upvalue4 = nil
end

local EssaiPrompt
Upvalue5( )
local Bouton = Upvalue6:FindFirstChild( "Bouton" )

if Bouton then
    EssaiPrompt = Bouton:FindFirstChild( "EssaiPrompt" )
else
    EssaiPrompt = Bouton
end
if EssaiPrompt then
    EssaiPrompt.Enabled = true
end

Upvalue7( false )
Upvalue8( )
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 == Upvalue1 and Upvalue2 then
    local Flag
    local Position = Upvalue1.Position
    local PointToObjectSpace = Upvalue3.CFrame:PointToObjectSpace( Position )
    local Size = Upvalue3.Size / 2

    if math.abs( PointToObjectSpace.X ) <= Size.X then
        if math.abs( PointToObjectSpace.Y ) <= Size.Y then
            if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end
    if not Flag then
        local Humanoid = Upvalue4:FindFirstChildOfClass( "Humanoid" )

        if Humanoid then
            Humanoid:UnequipTools( )
        end

        return
    end
end
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

Upvalue1 = Argument1

if Upvalue2 ~= 0 then
    Upvalue2 = 0
    Upvalue3( )
end

local EssaiPrompt
Upvalue4( )
local Bouton = Upvalue5:FindFirstChild( "Bouton" )

if Bouton then
    EssaiPrompt = Bouton:FindFirstChild( "EssaiPrompt" )
else
    EssaiPrompt = Bouton
end
if EssaiPrompt then
    EssaiPrompt.Enabled = false
end

Upvalue6( true )
Upvalue7( )
local Zone = Upvalue5:FindFirstChild( "Zone" )
local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )

if Zone and HumanoidRootPart then
    Upvalue8 = Zone.TouchEnded:Connect( function( Argument1 )
        if Argument1 == HumanoidRootPart and Upvalue1 then
            local Flag
            local Position = HumanoidRootPart.Position
            local PointToObjectSpace = Zone.CFrame:PointToObjectSpace( Position )
            local Size = Zone.Size / 2

            if math.abs( PointToObjectSpace.X ) <= Size.X then
                if math.abs( PointToObjectSpace.Y ) <= Size.Y then
                    if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end
            else
                Flag = false
            end
            if not Flag then
                local Humanoid = Object:FindFirstChildOfClass( "Humanoid" )

                if Humanoid then
                    Humanoid:UnequipTools( )
                end

                return
            end
        end
    end )
end
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Tool" ) and Object:GetAttribute( "Essai" ) then
    Upvalue1( Object, Upvalue2 )
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 == Upvalue1 then
    if not Upvalue1 then
        return
    end

    Upvalue1 = nil

    if Upvalue2 ~= 0 then
        Upvalue2 = 0
        Upvalue3( )
    end
    if Upvalue4 then
        Upvalue4:Disconnect( )
        Upvalue4 = nil
    end

    local EssaiPrompt
    Upvalue5( )
    local Bouton = Upvalue6:FindFirstChild( "Bouton" )

    if Bouton then
        EssaiPrompt = Bouton:FindFirstChild( "EssaiPrompt" )
    else
        EssaiPrompt = Bouton
    end
    if EssaiPrompt then
        EssaiPrompt.Enabled = true
    end

    Upvalue7( false )
    Upvalue8( )
end
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1:GetAttribute( "InSafeZone" ) == true and not Upvalue2 then
    Upvalue3( )
    return
end
if Upvalue4 then
    Upvalue4:Disconnect( )
    Upvalue4 = nil
end
if Upvalue5 then
    Upvalue5:Cancel( )
    Upvalue5 = nil
end
if Upvalue6 and Upvalue7[ Upvalue6 ] then
    Upvalue6.StudsOffsetWorldSpace = Upvalue7[ Upvalue6 ]
end
if Upvalue8 and Upvalue8.Parent and Upvalue9 then
    Upvalue8:PivotTo( Upvalue9 )
end

Upvalue8 = nil
Upvalue9 = nil
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

Char.ChildAdded:Connect( function( Object )
    if Object:IsA( "Tool" ) and Object:GetAttribute( "Essai" ) then
        Upvalue1( Object, Char )
    end
end )
Char.ChildRemoved:Connect( function( Argument1 )
    if Argument1 == Upvalue2 then
        if not Upvalue2 then
            return
        end

        Upvalue2 = nil

        if Upvalue3 ~= 0 then
            Upvalue3 = 0
            Upvalue4( )
        end
        if Upvalue5 then
            Upvalue5:Disconnect( )
            Upvalue5 = nil
        end

        local EssaiPrompt
        Upvalue6( )
        local Bouton = Upvalue7:FindFirstChild( "Bouton" )

        if Bouton then
            EssaiPrompt = Bouton:FindFirstChild( "EssaiPrompt" )
        else
            EssaiPrompt = Bouton
        end
        if EssaiPrompt then
            EssaiPrompt.Enabled = true
        end

        Upvalue8( false )
        Upvalue9( )
    end
end )

for Key, Value in Char:GetChildren( ) do
    if Value:IsA( "Tool" ) and Value:GetAttribute( "Essai" ) then
        Upvalue1( Value, Char )
    end
end

local function SafeChanged()
    if Char:GetAttribute( "InSafeZone" ) == true and not Upvalue2 then
        Upvalue10( )
        return
    end
    if Upvalue11 then
        Upvalue11:Disconnect( )
        Upvalue11 = nil
    end
    if Upvalue12 then
        Upvalue12:Cancel( )
        Upvalue12 = nil
    end
    if Upvalue13 and Upvalue14[ Upvalue13 ] then
        Upvalue13.StudsOffsetWorldSpace = Upvalue14[ Upvalue13 ]
    end
    if Upvalue15 and Upvalue15.Parent and Upvalue16 then
        Upvalue15:PivotTo( Upvalue16 )
    end

    Upvalue15 = nil
    Upvalue16 = nil
end

Char:GetAttributeChangedSignal( "InSafeZone" ):Connect( SafeChanged )

if Char:GetAttribute( "InSafeZone" ) == true and not Upvalue2 then
    Upvalue10( )
    return
end
if Upvalue11 then
    Upvalue11:Disconnect( )
    Upvalue11 = nil
end
if Upvalue12 then
    Upvalue12:Cancel( )
    Upvalue12 = nil
end
if Upvalue13 and Upvalue14[ Upvalue13 ] then
    Upvalue13.StudsOffsetWorldSpace = Upvalue14[ Upvalue13 ]
end
if Upvalue15 and Upvalue15.Parent and Upvalue16 then
    Upvalue15:PivotTo( Upvalue16 )
end

Upvalue15 = nil
Upvalue16 = nil
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil

    if Upvalue2 ~= 0 then
        Upvalue2 = 0
        Upvalue3( )
    end
    if Upvalue4 then
        Upvalue4:Disconnect( )
        Upvalue4 = nil
    end

    local EssaiPrompt
    Upvalue5( )
    local Bouton = Upvalue6:FindFirstChild( "Bouton" )

    if Bouton then
        EssaiPrompt = Bouton:FindFirstChild( "EssaiPrompt" )
    else
        EssaiPrompt = Bouton
    end
    if EssaiPrompt then
        EssaiPrompt.Enabled = true
    end

    Upvalue7( false )
    Upvalue8( )
end
if Upvalue9 then
    Upvalue9:Disconnect( )
    Upvalue9 = nil
end
if Upvalue10 then
    Upvalue10:Cancel( )
    Upvalue10 = nil
end
if Upvalue11 and Upvalue12[ Upvalue11 ] then
    Upvalue11.StudsOffsetWorldSpace = Upvalue12[ Upvalue11 ]
end
if Upvalue13 and Upvalue13.Parent and Upvalue14 then
    Upvalue13:PivotTo( Upvalue14 )
end

Upvalue13 = nil
Upvalue14 = nil
Upvalue15( Argument1 )
]]

-- Could not structure function #45
