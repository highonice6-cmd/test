-- ReplicatedStorage.MythicReveal.RiotScene
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local SoundService = game:GetService( "SoundService" )
local TweenService = game:GetService( "TweenService" )
local Lighting = game:GetService( "Lighting" )
local ContentProvider = game:GetService( "ContentProvider" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Config = require( Weapons:WaitForChild( "Config" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local MeleeData = require( Weapons:WaitForChild( "MeleeData" ) )
local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local FX = ReplicatedStorage:WaitForChild( "FX" )
local RiotPoses = require( script:WaitForChild( "RiotPoses" ) )
local SecretFX = require( ReplicatedStorage:WaitForChild( "SecretFX" ) )
local LocalPlayer = Players.LocalPlayer
local Table = {
    SOUNDS = {
        siren = 9117810961,
        radio = 9113734204,
        swell = 9039691274,
        breath = 2942912507,
        gear = 9113103014,
        bang = 131756915295707,
        clang = { 9120387869, 9120388006, 9120388051, 9120389038 },
        shot = 78446965119386,
        ring = 9117375724,
        braamSquad = 140437543928805,
        braamFinal = 131557850414701,
        powerOut = 1843027392,
        thud = 1843025759
    }
}

local function FirstId( List )
    local Item

    if type( List ) == "table" then
        Item = List[ 1 ]
    else
        Item = List
    end
    if type( Item ) == "table" then
        Item = Item.Id
    end

    return Item
end

local function Wsound( Key, Key2 )
    local Entry2
    local Entry = WeaponData[ Key ]
    Entry2 = if Entry then Entry.Sounds else Entry
    local Entry4

    if Entry2 then
        local Entry3 = Entry2[ Key2 ]

        if type( Entry3 ) == "table" then
            Entry4 = Entry3[ 1 ]
        else
            Entry4 = Entry3
        end
        if type( Entry4 ) == "table" then
            Entry4 = Entry4.Id
        end
        if not Entry4 then
            Entry4 = nil
        end
    else
        Entry4 = nil
    end

    return Entry4
end

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function OutCubic( Argument1 )
    return 1 - ( 1 - math.clamp( Argument1, 0, 1 ) ) ^ 3
end

local function Lerp( Argument1, Argument2, Argument3 )
    return Argument1 + ( Argument2 - Argument1 ) * Argument3
end

local function Rnd( Argument1, Argument2 )
    return Argument1 + math.random( ) * ( Argument2 - Argument1 )
end

local function Kp( Argument1, Argument2 )
    return NumberSequenceKeypoint.new( Argument1, Argument2 )
end

local Rad = math.rad

local function Tween( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Create = TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out ), Argument3 )
    Create:Play( )
    return Create
end

local Table2 = {
    UpperTorso = "Waist",
    Head = "Neck",
    RightUpperArm = "RightShoulder",
    RightLowerArm = "RightElbow",
    RightHand = "RightWrist",
    LeftUpperArm = "LeftShoulder",
    LeftLowerArm = "LeftElbow",
    LeftHand = "LeftWrist"
}

local function LoadKS( Object )
    local Table = { }

    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "Keyframe" ) then
            local Table2Inner = { }

            for Key2, Value2 in Value:GetDescendants( ) do
                if Value2:IsA( "Pose" ) and Table2[ Value2.Name ] and Value2.Weight > 0 then
                    Table2Inner[ Table2[ Value2.Name ] ] = Value2.CFrame
                end
            end

            table.insert( Table, {
                t = Value.Time,
                poses = Table2Inner,
                grip = Value:GetAttribute( "Grip" )
            } )
        end
    end

    table.sort( Table, function( Argument1, Argument2 )
        local Flag = Argument1.t < Argument2.t and true or false
        return Flag
    end )
    return Table
end

local function SampleKS( List, Strike )
    if #List == 0 then
        return { }, nil
    end

    local Count = #List - 1
    local I = 1

    for I = 1, Count do
        local Entry = List[ I ]
        local Entry2 = List[ I + 1 ]

        if Strike <= Entry2.t then
            local Value1
            local Clamp = math.clamp( ( Strike - Entry.t ) / math.max( Entry2.t - Entry.t, 0.0001 ), 0, 1 )
            local Table = { }
            local Poses = Entry.poses
            Value1 = nil

            for Key, Value in Poses, nil, nil do
                Table[ Key ] = Value:Lerp( Entry2.poses[ Key ] or Value, Clamp )
            end

            local Lerp2

            if not Entry.grip or not Entry2.grip then
                local Grip2 = Entry.grip

                if Grip2 then
                    Lerp2 = Grip2
                else
                    Lerp2 = Entry2.grip
                end
            else
                local Grip = Entry.grip
                local Lerp = Grip:Lerp( Entry2.grip, Clamp )

                if Lerp then
                    Lerp2 = Lerp
                else
                    local Grip2 = Entry.grip

                    if Grip2 then
                        Lerp2 = Grip2
                    else
                        Lerp2 = Entry2.grip
                    end
                end
            end

            return Table, Lerp2
        end
    end

    return List[ #List ].poses, List[ #List ].grip
end

local Flag = false
function Table.Prepare( Argument1 )
    if Flag then
        return
    end
    Flag = true
    task.spawn( function()
        local RiotStudio
        local TableInner = { }
        local Studios = ReplicatedStorage:FindFirstChild( "Studios" )

        if Studios then
            RiotStudio = ReplicatedStorage.Studios:FindFirstChild( "RiotStudio" )
        else
            RiotStudio = Studios
        end
        if RiotStudio then
            table.insert( TableInner, RiotStudio )
        end

        local Value1
        local Table2 = { "RiotShield", "M4", "SPAS12", "AWP", "M60", "MP5", "M4A1" }
        Value1 = nil

        for Key, Value in Table2, nil, nil do
            local FoundChild = WeaponVisuals:FindFirstChild( Value )

            if FoundChild then
                table.insert( TableInner, FoundChild )
            end
        end

        local Value2
        local Table3 = { }
        local Table4 = { }
        local SOUNDS = Table.SOUNDS
        Value2 = nil

        for Key2, Value3 in SOUNDS, nil, nil do
            if type( Value3 ) == "table" then
                local Value11 = nil

                for Key6, Value12 in Value3, nil, nil do
                    table.insert( Table4, Value12 )
                end
            else
                table.insert( Table4, Value3 )
            end
        end

        local SPAS122
        local Table5 = { }
        local SPAS12 = WeaponData.SPAS12
        SPAS122 = if SPAS12 then SPAS12.Sounds else SPAS12
        local Bolt2

        if SPAS122 then
            local Bolt = SPAS122.Bolt

            if type( Bolt ) == "table" then
                Bolt2 = Bolt[ 1 ]
            else
                Bolt2 = Bolt
            end
            if type( Bolt2 ) == "table" then
                Bolt2 = Bolt2.Id
            end
            if not Bolt2 then
                Bolt2 = nil
            end
        else
            Bolt2 = nil
        end

        local AWP2
        local AWP = WeaponData.AWP
        AWP2 = if AWP then AWP.Sounds else AWP
        local Bolt4

        if AWP2 then
            local Bolt3 = AWP2.Bolt

            if type( Bolt3 ) == "table" then
                Bolt4 = Bolt3[ 1 ]
            else
                Bolt4 = Bolt3
            end
            if type( Bolt4 ) == "table" then
                Bolt4 = Bolt4.Id
            end
            if not Bolt4 then
                Bolt4 = nil
            end
        else
            Bolt4 = nil
        end

        local Value4
        Table5[ 1 ] = Bolt2
        Table5[ 2 ] = Bolt4
        Value4 = nil

        for Key3, Value5 in Table5, nil, nil do
            table.insert( Table4, Value5 )
        end

        local SPAS124
        local SPAS123 = WeaponData.SPAS12

        if SPAS123 then
            local Sounds = WeaponData.SPAS12.Sounds

            if Sounds then
                SPAS124 = WeaponData.SPAS12.Sounds.Bolt
            else
                SPAS124 = Sounds
            end
        else
            SPAS124 = SPAS123
        end
        if type( SPAS124 ) == "table" and type( SPAS124[ 2 ] ) == "table" then
            table.insert( Table4, SPAS124[ 2 ].Id )
        end

        local Value6 = nil

        for Key4, Value7 in Table4, nil, nil do
            local Value10 = Argument1( Value7, 0 )
            table.insert( Table3, Value10 )
            table.insert( TableInner, Value10 )
        end

        local Value8
        pcall( ContentProvider.PreloadAsync, ContentProvider, TableInner )
        Value8 = nil

        for Key5, Value9 in Table3, nil, nil do
            Value9:Destroy( )
        end
    end )
    return
end

local function CleanRig( Self )
    for Key, Value in Self:GetChildren( ) do
        if Value:IsA( "Model" ) or Value:IsA( "Folder" ) or Value:IsA( "Tool" ) then
            Value:Destroy( )
        end
    end
    for Key2, Value2 in Self:GetDescendants( ) do
        if Value2:IsA( "LuaSourceContainer" ) or Value2:IsA( "BillboardGui" ) or Value2:IsA( "Highlight" ) or Value2:IsA( "ForceField" ) or Value2:IsA( "Sound" ) or Value2:IsA( "Animator" ) or Value2:IsA( "BodyMover" ) or Value2:IsA( "AlignPosition" ) or Value2:IsA( "AlignOrientation" ) then
            Value2:Destroy( )
        elseif Value2:IsA( "BasePart" ) then
            Value2.Anchored = false
            Value2.CanCollide = false
            Value2.CanQuery = false
            Value2.CanTouch = false
            Value2.Massless = true
            Value2.LocalTransparencyModifier = 0
        end
    end

    local Humanoid = Self:FindFirstChildOfClass( "Humanoid" )

    if Humanoid then
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        pcall( function()
            Humanoid.EvaluateStateMachine = false
        end )
        pcall( function()
            Humanoid.RequiresNeck = false
        end )
    end

    local HumanoidRootPart = Self:FindFirstChild( "HumanoidRootPart" )

    if HumanoidRootPart then
        HumanoidRootPart.Anchored = true
        HumanoidRootPart.Transparency = 1
    end

    return Humanoid, HumanoidRootPart
end

local function MotorsOf( Object )
    local Table = { }

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "Motor6D" ) or Value:IsA( "AnimationConstraint" ) then
            if not Table[ Value.Name ] then
                Table[ Value.Name ] = Value
            end
        end
    end

    return Table
end

local function JointC( Self )
    if Self:IsA( "Motor6D" ) then
        return Self.C0, Self.C1
    end

    local CFrame4

    if Self.Attachment0 then
        local CFrame2 = Self.Attachment0.CFrame

        if CFrame2 then
            CFrame4 = CFrame2
        else
            CFrame4 = CFrame.identity
        end
    else
        CFrame4 = CFrame.identity
    end

    local CFrame5

    if Self.Attachment1 then
        local CFrame3 = Self.Attachment1.CFrame

        if CFrame3 then
            CFrame5 = CFrame3
        else
            CFrame5 = CFrame.identity
        end
    else
        CFrame5 = CFrame.identity
    end

    return CFrame4, CFrame5
end

local function WeldTo( Part0, Part1 )
    local Weld = Instance.new( "Weld" )
    Weld.Part0 = Part0
    Weld.Part1 = Part1
    Weld.C0 = Part0.CFrame:ToObjectSpace( Part1.CFrame )
    Weld.Parent = Part1
    return Weld
end

function Table.Play( p1, p2 )
    -- Could not structure function #157
end
return Table

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted
return Aborted2
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local TextTransparency = 1 - Title
local TextTransparency2 = 1 - Title
Upvalue1.TextTransparency = TextTransparency
Upvalue2.TextTransparency = TextTransparency2
local Table = {
    Upvalue1:FindFirstChildOfClass( "UIStroke" ),
    Upvalue2:FindFirstChildOfClass( "UIStroke" )
}
Value1 = nil

for Key, Value in Table, nil, nil do
    if Value then
        Value.Transparency = 1 - Title
    end
end

Upvalue3.BackgroundTransparency = 1 - Title
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Stop( )
Upvalue2.Enabled = false
Upvalue3.BackgroundTransparency = 1
Upvalue4( 0 )
Upvalue5.Position = Upvalue7
Upvalue6.Position = Upvalue8
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.hideUI( true )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( Argument1, Argument2, Argument3 )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

local Attachment = Instance.new( "Attachment" )
Attachment.WorldPosition = WorldPosition
Attachment.Parent = workspace.Terrain
table.insert( Upvalue1, Attachment )
return Attachment
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

local Part = Instance.new( "Part" )
Part.Name = Name
Part.Anchored = true
Part.CanCollide = false
Part.CanQuery = false
Part.CanTouch = false
Part.Transparency = 1
Part.Size = Argument3 or Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
Part.CFrame = CFrame
Part.Parent = Upvalue1
return Part
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue1 then
    local CFrame = Upvalue1.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

return CFrame2
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured, Lerp

if Upvalue3.strike then
    local Strike = Amount - Upvalue3.strike

    if Strike < Upvalue4 then
        local Captured2
        Captured, Value1 = Upvalue5( Upvalue6, Strike )
        Captured2 = if Value1 then Value1 else Upvalue2
        Lerp = Captured2
    elseif Strike < Upvalue4 + 0.5 then
        local Value4
        local Value2, Value3 = Upvalue5( Upvalue6, Upvalue4 )
        local Clamp = math.clamp( ( Strike - Upvalue4 ) / 0.5, 0, 1 )
        local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
        local Table = { }
        Value4 = nil

        for Key, Value in Value2, nil, nil do
            Table[ Key ] = Value:Lerp( Upvalue1[ Key ] or Value, Clamp2 )
        end

        local Captured3 = if Value3 then Value3 else Upvalue2
        Lerp = Captured3:Lerp( Upvalue2, Clamp2 )
        Captured = Table
    else
        Captured = Upvalue1
        Lerp = Upvalue2
    end
else
    Captured = Upvalue1
    Lerp = Upvalue2
end

local Value5 = nil

for Key2, Value6 in Captured, nil, nil do
    local Entry2 = Upvalue7[ Key2 ]

    if Entry2 then
        Entry2.Transform = Value6
    end
end

local Value7 = nil

for Key3, Value8 in Upvalue8, nil, nil do
    local Entry = Upvalue7[ Key3 ]

    if Entry then
        Entry.Transform = Value8
    end
end

local Sin = math.sin( Amount * 1.7 ) * 0.014 * Upvalue3.breathe

if Upvalue7.Waist then
    local Waist3
    local Waist = Upvalue7.Waist
    local Waist2 = Captured.Waist
    Waist3 = if Waist2 then Waist2 else CFrame.identity
    Waist.Transform = Waist3 * CFrame.Angles( Sin, 0, 0 )
end
if Upvalue7.Neck then
    local Neck3
    local Neck = Upvalue7.Neck
    local Neck2 = Captured.Neck
    Neck3 = if Neck2 then Neck2 else CFrame.identity
    local Nod = Upvalue3.nod
    Neck.Transform = Neck3 * CFrame.Angles( Nod, Upvalue3.look, 0 )
end

Upvalue9.C0 = Lerp * Upvalue3.jolt
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

return CFrame.Angles( Upvalue1( Argument1 ), Upvalue1( Amount or 0 ), ( Upvalue1( Amount2 or 0 ) ) )
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Amount = -Argument1.X
return ( math.atan2( Amount, -Argument1.Z ) )
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

local Root = Argument1.Root
local Waist = Argument1.Waist

if not Root or not Waist then
    return Argument2.Gun
end

local C0, C1

if Root:IsA( "Motor6D" ) then
    C0 = Root.C0
    C1 = Root.C1
else
    if Root.Attachment0 then
        local CFrame2 = Root.Attachment0.CFrame

        if CFrame2 then
            C0 = CFrame2
        else
            C0 = CFrame.identity
        end
    else
        C0 = CFrame.identity
    end
    if Root.Attachment1 then
        local CFrame3 = Root.Attachment1.CFrame

        if CFrame3 then
            C1 = CFrame3
        else
            C1 = CFrame.identity
        end
    else
        C1 = CFrame.identity
    end
end

local C02, C12

if Waist:IsA( "Motor6D" ) then
    C02 = Waist.C0
    C12 = Waist.C1
else
    if Waist.Attachment0 then
        local CFrame4 = Waist.Attachment0.CFrame

        if CFrame4 then
            C02 = CFrame4
        else
            C02 = CFrame.identity
        end
    else
        C02 = CFrame.identity
    end
    if Waist.Attachment1 then
        local CFrame5 = Waist.Attachment1.CFrame

        if CFrame5 then
            C12 = CFrame5
        else
            C12 = CFrame.identity
        end
    else
        C12 = CFrame.identity
    end
end

local Root3
local Root2 = Argument2.Root
Root3 = if Root2 then Root2 else CFrame.identity
local Waist3
local C03 = C0 * Root3 * C1:Inverse( ) * C02
local Waist2 = Argument2.Waist
Waist3 = if Waist2 then Waist2 else CFrame.identity
return C03 * Waist3 * C12:Inverse( ) * Argument2.Gun
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

local LightEmission
local Beam = Instance.new( "Beam" )
Beam.Attachment0 = Attachment0
Beam.Attachment1 = Attachment1
Beam.Width0 = Width0
Beam.Width1 = Width1
local IsRed = Upvalue1.IsRed( Argument5 )
LightEmission = not IsRed and 1 or 0
local Segments = Name ~= "laser" and 2 or 1
local BLACK2
Beam.FaceCamera = true
Beam.LightEmission = LightEmission
Beam.Segments = Segments

if IsRed then
    local BLACK = Upvalue1.BLACK

    if BLACK then
        BLACK2 = BLACK
    else
        BLACK2 = Argument5
    end
else
    BLACK2 = Argument5
end

Beam.Color = ColorSequence.new( BLACK2 )

if IsRed then
    Beam.LightInfluence = 0
end

Beam.Enabled = false
Beam.Parent = Upvalue2
table.insert( Upvalue3, { b = Beam, g = Argument7, a = Argument6, kind = Name } )
return Beam
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Value.weapon == Argument1 then
        return Value
    end
end

return Upvalue1[ 1 ]
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.kFrom = Argument1.k
Argument1.kTo = KTo
Argument1.kT0 = KT0
Argument1.kDur = KDur
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

if Amount - Argument1.kT0 < Argument1.kDur then
    local KFrom = Argument1.kFrom
    local KTo = Argument1.kTo
    local Clamp = math.clamp( ( Amount - Argument1.kT0 ) / Argument1.kDur, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    Argument1.k = KFrom + ( KTo - KFrom ) * Clamp2
else
    Argument1.k = Argument1.kTo
end
if Argument1.J then
    Upvalue1.Step( Argument1, Amount )
    return
end

local Value1
local K = Argument1.k
local Sin = math.sin( Amount * 1.5 + Argument1.phase ) * 0.016
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    local Entry2 = Argument1.mt[ Value ]

    if Entry2 then
        local Entry5
        local Entry3 = Upvalue3[ Value ]
        Entry5 = if Entry3 then Entry3 else CFrame.identity
        local Entry6
        local Entry4 = Upvalue4[ Value ]
        Entry6 = if Entry4 then Entry4 else CFrame.identity
        local Transform
        local Lerp = Entry5:Lerp( Entry6, K )

        if Value == "Waist" then
            Transform = Lerp * ( Argument1.leanT * CFrame.Angles( Sin, 0, 0 ) )
        elseif Value == "Neck" then
            Transform = Lerp * CFrame.Angles( 0, Argument1.look, 0 )
        else
            Transform = Lerp
        end

        Entry2.Transform = Transform
    end
end
if Argument1.mt.Root then
    local Root = Argument1.mt.Root
    Root.Transform = Argument1.rootT
end

local Value2 = nil

for Key2, Value3 in Upvalue5, nil, nil do
    local Entry = Argument1.mt[ Value3 ]

    if Entry and Argument1.stance[ Value3 ] then
        Entry.Transform = Argument1.stance[ Value3 ]
    end
end
if Argument1.joint then
    local Joint = Argument1.joint
    local Gun = Upvalue3.Gun
    Joint.C0 = Gun:Lerp( Upvalue4.Gun, K ) * Argument1.jolt
end

local Root2 = Argument1.root
local CFrame2 = CFrame.new( Argument1.pos )
local YawLow = Argument1.yawLow
Root2.CFrame = CFrame2 * CFrame.Angles( 0, YawLow + ( Argument1.yawAim - YawLow ) * K, 0 )
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { neons = { }, lights = { }, level = 0 }
Value1 = nil

for Key2, Value in List, nil, nil do
    if Value then
        local Descendants = Value:GetDescendants( )

        if Value:IsA( "BasePart" ) then
            table.insert( Descendants, Value )
        end

        local Value2 = nil

        for Key3, Value3 in Descendants, nil, nil do
            if not Callback or Callback( Value3 ) then
                if not Value3:IsA( "BasePart" ) or not Value3:GetAttribute( "OnColor" ) then
                    if Value3:IsA( "Light" ) then
                        Value3.Enabled = true
                        local Lights = Table.lights
                        table.insert( Lights, { l = Value3, base = List2[ Value3.ClassName ] or 2 } )
                    end
                else
                    local Neons = Table.neons
                    table.insert( Neons, {
                        p = Value3,
                        off = Value3.Color,
                        on = Value3:GetAttribute( "OnColor" )
                    } )
                end
            end
        end
    end
end

Upvalue1[ Key ] = Table
return Table
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 and Upvalue1:FindFirstChild( Name )
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Object:GetAttribute( "Side" ) == nil and true or false
return Flag
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Object:GetAttribute( "Side" ) == "R" and true or false
return Flag
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Object:GetAttribute( "Side" ) == "B" and true or false
return Flag
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

return 0.78 + 0.22 * math.noise( Amount * 9, 0.3 )
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local ParticleEmitter = Instance.new( "ParticleEmitter" )
Value1 = nil

for Key, Value in List, nil, nil do
    ParticleEmitter[ Key ] = Value
end

ParticleEmitter.Parent = Parent
table.insert( Upvalue1, ParticleEmitter )
return ParticleEmitter
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

local Children2

if Upvalue1 and Upvalue1:FindFirstChild( "Fusees" ) then
    local Children = ( Upvalue1 and Upvalue1:FindFirstChild( "Fusees" ) ):GetChildren( )

    if Children then
        Children2 = Children
    else
        Children2 = { }
    end
else
    Children2 = { }
end

local Value1 = nil

for Key, Value in Children2, nil, nil do
    for Key2, Value2 in Value:GetDescendants( ) do
        if Value2:IsA( "ParticleEmitter" ) then
            local Rate

            if Flares then
                if Value2.Name == "Etincelles" then
                    Rate = 40
                else
                    Rate = 3
                end
            else
                Rate = 0
            end

            Value2.Rate = Rate
        end
    end
end
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value.TimeScale = TimeScale
end
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue2[ Upvalue1 ] = nil
    Upvalue1:Destroy( )
end
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

if not Argument1 then
    return nil
end

local Value1 = Upvalue1( Argument1, Argument2, Argument3 )

if Argument4 then
    Value1.SoundGroup = Upvalue2
end
if TimePosition then
    Value1.TimePosition = TimePosition
end

Value1:Play( )
Upvalue3[ Value1 ] = true
task.delay( Amount or 16, function()
    if Value1.Parent then
        Upvalue3[ Value1 ] = nil
        Value1:Destroy( )
    end
end )
return Value1
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

if Parent then
    local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
    local HighGain = Amount or -24
    local MidGain = Amount2 or -6
    EqualizerSoundEffect.HighGain = HighGain
    EqualizerSoundEffect.MidGain = MidGain
    EqualizerSoundEffect.LowGain = 0
    EqualizerSoundEffect.Parent = Parent
    return
end
return
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

local Table, Value1, Value2, Number, PointToObjectSpace4, Number2
local PointToObjectSpace = Self:PointToObjectSpace( WorldPosition )
local PointToObjectSpace2 = Self:PointToObjectSpace( Argument4 )
local Result = Amount / 2
local PointToObjectSpace3 = PointToObjectSpace2 - PointToObjectSpace
Table = { "X", "Y", "Z" }
Value1 = nil
Value2 = nil
Number = 0
PointToObjectSpace4 = PointToObjectSpace
Number2 = 1

for Key, Value in Table, Value1, Value2 do
    local Entry = PointToObjectSpace4[ Value ]
    local Entry2 = PointToObjectSpace3[ Value ]
    local Entry3 = Result[ Value ]

    if math.abs( Entry2 ) < 1e-06 then
        if Entry < -Entry3 or Entry3 < Entry then
            return nil
        end
        Value2 = Key
    else
        local Amount3, Entry5
        local Amount2 = ( -Entry3 - Entry ) / Entry2
        local Entry4 = ( Entry3 - Entry ) / Entry2

        if Entry4 < Amount2 then
            Amount3 = Entry4
            Entry5 = Amount2
        else
            Amount3 = Amount2
            Entry5 = Entry4
        end

        local Max = math.max( Number, Amount3 )
        local Min = math.min( Number2, Entry5 )

        if Min < Max then
            return nil
        end
        Value2 = Key
        Number = Max
        Number2 = Min
    end
end

return Number
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

return os.clock( ) - Upvalue1
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Flag
local Clock = os.clock( ) - Upvalue2
local Clock2 = os.clock( )
Upvalue3.Ambient = Color3.fromRGB( 3, 3, 5 )
Upvalue3.OutdoorAmbient = Color3.fromRGB( 3, 3, 5 )
Upvalue3.Brightness = 0
Upvalue4 = Upvalue4 + ( Upvalue5 - Upvalue4 ) * 0.12
Upvalue3.ExposureCompensation = Upvalue6.ExposureCompensation + Upvalue4
Upvalue3.EnvironmentDiffuseScale = Upvalue6.EnvironmentDiffuseScale * Upvalue7
Upvalue3.EnvironmentSpecularScale = Upvalue6.EnvironmentSpecularScale * Upvalue7
local Clock3 = Clock2 % 0.62 / 0.62

if Clock3 < 0.09 then
    Flag = true
elseif Clock3 > 0.15 then
    if Clock3 < 0.24 then
        Flag = true
    else
        Flag = false
    end
else
    Flag = false
end

local Flag2

if not ( Clock3 > 0.5 ) or not ( Clock3 < 0.59 ) then
    if Clock3 > 0.65 then
        if Clock3 < 0.74 then
            Flag2 = true
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end
else
    Flag2 = true
end

local Number = not Flag and 0.05 or 1
local Number2
Upvalue8.level = Upvalue9 * Number
Number2 = not Flag2 and 0.05 or 1
local Value1
Upvalue10.level = Upvalue9 * Number2
Value1 = nil

for Key, Value in Upvalue11, nil, nil do
    local Mod2
    local Level = Value.level

    if Value.mod then
        local Mod = Value.mod( Clock2 )

        if Mod then
            Mod2 = Mod
        else
            Mod2 = 1
        end
    else
        Mod2 = 1
    end

    local Value12
    local Clamp = math.clamp( Level * Mod2, 0, 2 )
    local Neons = Value.neons
    Value12 = nil

    for Key6, Value13 in Neons, nil, nil do
        local P2 = Value13.p
        P2.Color = Value13.off:Lerp( Value13.on, ( math.min( Clamp, 1 ) ) )
    end

    local Value14
    local Lights = Value.lights
    Value14 = nil

    for Key7, Value15 in Lights, nil, nil do
        local L = Value15.l
        L.Brightness = Value15.base * Clamp
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue12, nil, nil do
    local Enabled
    local Min2 = math.min( Value3.g.level, 1.3 )
    local B = Value3.b
    Enabled = Min2 > 0.02 and true or false
    B.Enabled = Enabled

    if Value3.kind == "laser" then
        local B2 = Value3.b
        B2.Transparency = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 1 - Value3.a * Min2 ),
            NumberSequenceKeypoint.new( 0.6, 1 - Value3.a * 0.6 * Min2 ),
            Upvalue13( 1, 1 )
        } )
    else
        local B3 = Value3.b
        B3.Transparency = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 1 ),
            NumberSequenceKeypoint.new( 0.18, 1 - Value3.a * Min2 ),
            Upvalue13( 1, 1 )
        } )
    end
end

local Value4 = nil

for Key3, Value5 in Upvalue14, nil, nil do
    local P = Value5.p
    P.CFrame = CFrame.new( Value5.pos ) * CFrame.Angles( 0, Clock2 * 7.5 * Value5.s, 0 ) * CFrame.Angles( -0.24434609527920614, 0, 0 )
end

local Value6
Upvalue15( Clock )
Value6 = nil

for Key4, Value7 in Upvalue16, nil, nil do
    Upvalue17( Value7, Clock )
end

Upvalue18.CFrame = CFrame.lookAt( Upvalue19.from, Upvalue19.to )
Upvalue20.Brightness = 3 * Upvalue19.level

if Upvalue21.level > 0.02 then
    local Value8 = nil

    for Key5, Value9 in Upvalue22, nil, nil do
        local Number3
        local WorldPosition = Value9.a0.WorldPosition
        local CFrame2 = Value9.a0.Parent.CFrame * Value9.base

        if Upvalue23 then
            local CFrame3 = Upvalue23.CFrame
            local Value10 = Upvalue24( CFrame3, Upvalue23.Size + Vector3.new( 0.6000000238418579, 0.6000000238418579, 0.6000000238418579 ), WorldPosition, CFrame2 )

            if Value10 then
                Number3 = Value10
            else
                Number3 = 1
            end
        else
            Number3 = 1
        end

        local Number4

        if Upvalue25 then
            local Value11 = Upvalue24( Upvalue25.CFrame * CFrame.new( 0, 0.6, 0 ), Vector3.new( 2.799999952316284, 6.199999809265137, 2 ), WorldPosition, CFrame2 )

            if Value11 then
                Number4 = Value11
            else
                Number4 = 1
            end
        else
            Number4 = 1
        end

        local Min = math.min( Number3, Number4 )
        local A1 = Value9.a1
        A1.Position = Value9.a0.Position + ( Value9.base - Value9.a0.Position ) * math.max( Min - 0.03, 0.08 )
    end
end

Upvalue26.CFrame = CFrame.lookAt( Upvalue27.from, Upvalue27.to )
Upvalue28.Brightness = 2.2 * Upvalue27.level

if not ( Upvalue29.level > 0 ) or not Upvalue23 then
    Upvalue31.Brightness = 0
else
    local Color
    local Clock4 = ( Clock2 - Upvalue29.t0 ) * 0.9
    local Clock5 = Clock4 % 1
    local CFrame4 = Upvalue23.CFrame
    Upvalue30.CFrame = CFrame.lookAt( CFrame4 * Vector3.new( -5 + 10 * Clock5, 0.8, -4.5 ), CFrame4 * Vector3.new( -1.2 + 2.4 * Clock5, 0, -0.25 ) )

    if math.floor( Clock4 ) % 2 == 0 then
        local LIGHT = Upvalue32.LIGHT

        if LIGHT then
            Color = LIGHT
        else
            Color = Color3.fromRGB( 50, 110, 255 )
        end
    else
        Color = Color3.fromRGB( 50, 110, 255 )
    end

    Upvalue31.Color = Color
    Upvalue31.Brightness = Upvalue29.level * 5 * math.sin( 3.141592653589793 * Clock5 ) ^ 2
end
if Upvalue33 then
    Upvalue34.FocusDistance = ( Upvalue35.CFrame.Position - Upvalue33 ).Magnitude
end
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value.level = 0
end

Upvalue2 = 0
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < ( Upvalue1 or 0.4 ) do
    local Aborted2
    local Aborted = Upvalue2.aborted
    Aborted2 = if Aborted then Upvalue2.aborted( ) else Aborted

    if Aborted2 then
        break
    end

    local Level

    if math.random( ) < 0.5 then
        local Random = ( 0.3 + math.random( ) * 0.7 ) * Upvalue4

        if Random then
            Level = Random
        else
            Level = 0.04
        end
    else
        Level = 0.04
    end

    Upvalue3.level = Level
    task.wait( 0.03 + math.random( ) * 0.05 )
end

Upvalue3.level = Upvalue4
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < ( Argument3 or 0.4 ) do
        local Aborted2
        local Aborted = Upvalue1.aborted
        Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Level

        if math.random( ) < 0.5 then
            local Random = ( 0.3 + math.random( ) * 0.7 ) * Argument2

            if Random then
                Level = Random
            else
                Level = 0.04
            end
        else
            Level = 0.04
        end

        Argument1.level = Level
        task.wait( 0.03 + math.random( ) * 0.05 )
    end

    Argument1.level = Argument2
end )
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.BackgroundColor3 = BackgroundColor3
Upvalue1.BackgroundTransparency = BackgroundTransparency
local Table = { BackgroundTransparency = 1 }
Upvalue2:Create( Upvalue1, TweenInfo.new( Argument3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Value1
Upvalue1 = true
Upvalue2:Disconnect( )
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    Upvalue4[ Key ] = Value
end

local Value2
Upvalue5:Destroy( )
Upvalue6:Destroy( )
Upvalue7:Destroy( )
Value2 = nil

for Key2, Value3 in Upvalue8, nil, nil do
    if Value3.Parent then
        Value3.Enabled = true
    end
end
if Upvalue9 and Upvalue9.Parent then
    Upvalue9.Enabled = Upvalue10
end

local Value4 = nil

for Value5 in Upvalue11, nil, nil do
    if Value5.Parent then
        Value5:Stop( )
        Value5:Destroy( )
    end
end

local Value6
Upvalue12:Destroy( )
Value6 = nil

for Key3, Value7 in Upvalue13, nil, nil do
    Value7:Destroy( )
end

Upvalue14:Destroy( )
Upvalue15:Destroy( )
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = Argument1 - ( os.clock( ) - Upvalue1 )

if Clock > 0 then
    Upvalue2( Clock )
end
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

task.delay( math.max( 0, Argument1 - ( os.clock( ) - Upvalue1 ) ), Argument2, ... )
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

return ( 0.8 * Amount + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Amount ) ) ) / 1.0546479089470326
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

local X2
local LookAt = CFrame.lookAt( Argument1, Argument2 )
local ViewportSize = Upvalue1.ViewportSize

if ViewportSize.Y > 0 then
    local X = ViewportSize.X / ViewportSize.Y

    if X then
        X2 = X
    else
        X2 = 1.7777777777777777
    end
else
    X2 = 1.7777777777777777
end

local Tan = math.tan( math.rad( Argument3 ) / 2 )
local Result = 2 * Amount * Tan * X2
return LookAt * CFrame.lookAt( Vector3.new( 0, 0, 0 ), Vector3.new( Result, 2 * Amount2 * Tan, -1 ).Unit ):Inverse( )
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

local DebugRiotCam
local IsStudio = Upvalue1:IsStudio( )

if IsStudio then
    DebugRiotCam = Upvalue2:GetAttribute( "DebugRiotCam" )
else
    DebugRiotCam = IsStudio
end
if typeof( DebugRiotCam ) == "CFrame" then
    return CFrame.new( Upvalue3 ) * DebugRiotCam, tonumber( Upvalue2:GetAttribute( "DebugRiotFov" ) ) or 40
end
return LookAt, Argument2
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

local LookAt

if Argument1.subject then
    local Screen2

    if Argument1.screen then
        local Screen = Argument1.screen( Argument2 )

        if Screen then
            Screen2 = Screen
        else
            Screen2 = Vector2.zero
        end
    else
        Screen2 = Vector2.zero
    end

    LookAt = Upvalue1( Argument1.pos( Argument2 ), Argument1.subject( Argument2 ), Argument1.fov( Argument2 ), Screen2.X, Screen2.Y )
else
    LookAt = CFrame.lookAt( Argument1.pos( Argument2 ), Argument1.look( Argument2 ) )
end
if Argument1.roll then
    LookAt = LookAt * CFrame.Angles( 0, 0, Argument1.roll( Argument2 ) )
end

local Focus2
local Cf, Fov = Upvalue3( LookAt, Argument1.fov( Argument2 ) )
Upvalue2.cf = Cf
Upvalue2.fov = Fov

if Argument1.focus then
    local Focus = Argument1.focus( Argument2 )

    if Focus then
        Focus2 = Focus
    else
        Focus2 = nil
    end
else
    Focus2 = nil
end

Upvalue4 = Focus2

if Argument1.kick then
    Argument1.kick( Argument2 )
end
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( ( Upvalue3 + Argument2 - Upvalue4 ) / ( Upvalue5 - Upvalue4 ), 0, 1 )
Upvalue1( Upvalue2, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1

if Upvalue2:IsStudio( ) and Upvalue3:GetAttribute( "DebugMythicShot" ) == Upvalue1 then
    local Clock = os.clock( )
    Upvalue3:SetAttribute( "DebugMythicHolding", Upvalue1 )

    while Upvalue3:GetAttribute( "DebugMythicShot" ) == Upvalue1 do
        local Aborted2
        local Aborted = Upvalue4.aborted
        Aborted2 = if Aborted then Upvalue4.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Clamp = math.clamp( tonumber( Upvalue3:GetAttribute( "DebugMythicShotK" ) ) or 0, 0, 1 )
        Upvalue5( Argument3, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
        Upvalue2.RenderStepped:Wait( )
    end

    Upvalue3:SetAttribute( "DebugMythicHolding", nil )
    Upvalue6 = Upvalue6 + ( os.clock( ) - Clock )
end

local Clock2 = os.clock( ) - Upvalue6
Upvalue7( math.max( Argument2 - Clock2, 0.01 ), function( Argument1Inner, Argument2Inner )
    local Clamp = math.clamp( ( Clock2 + Argument2Inner - Argument1 ) / ( Argument2 - Argument1 ), 0, 1 )
    Upvalue5( Argument3, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
end )
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( 1.2000000476837158, 2.5, -2 )
]]

--[[
Function #64 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( 0, 2.5, 0 )
]]

--[[
Function #65 has no emitted closure site
It is reproduced here so that nothing is lost

return 26
]]

--[[
Function #66 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame3

if Upvalue1 then
    local CFrame2 = Upvalue1.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

return CFrame3
]]

--[[
Function #67 has no emitted closure site
It is reproduced here so that nothing is lost

local Parent
local Radio = Upvalue1.SOUNDS.radio

if Radio then
    local Value1 = Upvalue2( Radio, 0.5, 1 )
    Value1:Play( )
    Upvalue3[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue3[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
    Parent = Value1
else
    Parent = nil
end
if Parent then
    local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
    EqualizerSoundEffect.HighGain = -3
    EqualizerSoundEffect.MidGain = 0
    EqualizerSoundEffect.LowGain = 0
    EqualizerSoundEffect.Parent = Parent
    return
end
return
]]

--[[
Function #68 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame3

if Upvalue1 then
    local CFrame2 = Upvalue1.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

return CFrame3 * Vector3.new( 0.2, 0.9 + 1.15 * Amount, -0.27 )
]]

--[[
Function #69 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame3

if Upvalue1 then
    local CFrame2 = Upvalue1.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local Result = 0.8 + -0.48000000000000004 * Amount
local Result2 = 0.3 + 1.82 * Amount
return CFrame3 * Vector3.new( Result, Result2, -( 2.4 + -0.1499999999999999 * Amount ) )
]]

--[[
Function #70 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame3

if Upvalue1 then
    local CFrame2 = Upvalue1.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local CFrame6
local CFrame4 = CFrame3 * Vector3.new( 0.2, 0.9 + 1.15 * Amount, -0.27 )

if Upvalue3 then
    local CFrame5 = Upvalue3.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame5 then
        CFrame6 = CFrame5
    else
        CFrame6 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame6 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local Clamp = math.clamp( ( Amount - 0.62 ) / 0.38, 0, 1 )
return CFrame4:Lerp( CFrame6, Clamp * Clamp * ( 3 - 2 * Clamp ) )
]]

--[[
Function #71 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0.08 + -0.08 * Amount, -0.02 + 0.06 * Amount )
]]

--[[
Function #72 has no emitted closure site
It is reproduced here so that nothing is lost

return 27 + -4 * Amount
]]

--[[
Function #73 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 4 + -3 * Amount ) )
]]

--[[
Function #74 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame3

if Upvalue1 then
    local CFrame2 = Upvalue1.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue2 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local CFrame6
local CFrame4 = CFrame3 * Vector3.new( 0.2, 0.9 + 1.15 * Amount, -0.27 )

if Upvalue3 then
    local CFrame5 = Upvalue3.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame5 then
        CFrame6 = CFrame5
    else
        CFrame6 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame6 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local Clamp = math.clamp( ( Amount - 0.62 ) / 0.38, 0, 1 )
return CFrame4:Lerp( CFrame6, Clamp * Clamp * ( 3 - 2 * Clamp ) )
]]

--[[
Function #75 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame3

if Upvalue2 then
    local CFrame2 = Upvalue2.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue3 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue3 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local CFrame5
Upvalue1.from = CFrame3 * Vector3.new( 2.8, 1.1 + 2.1 * Amount, -1.6 )

if Upvalue2 then
    local CFrame4 = Upvalue2.CFrame

    if CFrame4 then
        CFrame5 = CFrame4
    else
        CFrame5 = CFrame.new( Upvalue3 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame5 = CFrame.new( Upvalue3 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local CFrame8
local CFrame6 = CFrame5 * Vector3.new( 0.2, 0.9 + 1.15 * Amount, -0.27 )

if Upvalue4 then
    local CFrame7 = Upvalue4.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame7 then
        CFrame8 = CFrame7
    else
        CFrame8 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame8 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local Clamp = math.clamp( ( Amount - 0.62 ) / 0.38, 0, 1 )
Upvalue1.to = CFrame6:Lerp( CFrame8, Clamp * Clamp * ( 3 - 2 * Clamp ) )
]]

--[[
Function #76 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if Aborted2 then
    return
end

local Clunk = Upvalue2.clunk

if Clunk then
    local Value1 = Upvalue3( Clunk, 0.7, 0.85 )
    Value1.SoundGroup = Upvalue4
    Value1:Play( )
    Upvalue5[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue5[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end

local Number = 0.3
local Number2 = 1
task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < ( Number or 0.4 ) do
        local Aborted2
        local Aborted = Upvalue1.aborted
        Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Level

        if math.random( ) < 0.5 then
            local Random = ( 0.3 + math.random( ) * 0.7 ) * Number2

            if Random then
                Level = Random
            else
                Level = 0.04
            end
        else
            Level = 0.04
        end

        Upvalue6.level = Level
        task.wait( 0.03 + math.random( ) * 0.05 )
    end

    Upvalue6.level = Number2
end )
Upvalue7 = 0.85
Upvalue8.level = 0.35
Upvalue9.level = 0.35
]]

--[[
Function #77 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if Aborted2 then
    return
end

local Clunk = Upvalue2.clunk

if Clunk then
    local Value1 = Upvalue3( Clunk, 1, 1 )
    Value1.SoundGroup = Upvalue4
    Value1:Play( )
    Upvalue5[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue5[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end

local Flicker = Upvalue2.flicker

if Flicker then
    local Value2 = Upvalue3( Flicker, 0.7, 1 )
    Value2:Play( )
    Upvalue5[ Value2 ] = true
    task.delay( 16, function()
        if Value2.Parent then
            Upvalue5[ Value2 ] = nil
            Value2:Destroy( )
        end
    end )
end

local BraamSquad = Upvalue6.SOUNDS.braamSquad

if BraamSquad then
    local Value3 = Upvalue3( BraamSquad, 0.8, 1 )
    Value3:Play( )
    Upvalue5[ Value3 ] = true
    task.delay( 16, function()
        if Value3.Parent then
            Upvalue5[ Value3 ] = nil
            Value3:Destroy( )
        end
    end )
end

local Number = 0.5
local Number2 = 1
task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < ( Number or 0.4 ) do
        local Aborted2
        local Aborted = Upvalue1.aborted
        Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Level

        if math.random( ) < 0.5 then
            local Random = ( 0.3 + math.random( ) * 0.7 ) * Number2

            if Random then
                Level = Random
            else
                Level = 0.04
            end
        else
            Level = 0.04
        end

        Upvalue7.level = Level
        task.wait( 0.03 + math.random( ) * 0.05 )
    end

    Upvalue7.level = Number2
end )
task.delay( 0.2, Upvalue8, Upvalue9, 0.9, 0.4 )
task.delay( 0.55, function()
    local Aborted2
    local Aborted = Upvalue1.aborted
    Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

    if Aborted2 then
        return
    end

    local Clunk = Upvalue2.clunk

    if Clunk then
        local Value1 = Upvalue3( Clunk, 0.7, 0.85 )
        Value1.SoundGroup = Upvalue4
        Value1:Play( )
        Upvalue5[ Value1 ] = true
        task.delay( 16, function()
            if Value1.Parent then
                Upvalue5[ Value1 ] = nil
                Value1:Destroy( )
            end
        end )
    end

    local Number = 0.3
    local Number2 = 1
    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < ( Number or 0.4 ) do
            local Aborted2
            local Aborted = Upvalue1.aborted
            Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

            if Aborted2 then
                break
            end

            local Level

            if math.random( ) < 0.5 then
                local Random = ( 0.3 + math.random( ) * 0.7 ) * Number2

                if Random then
                    Level = Random
                else
                    Level = 0.04
                end
            else
                Level = 0.04
            end

            Upvalue10.level = Level
            task.wait( 0.03 + math.random( ) * 0.05 )
        end

        Upvalue10.level = Number2
    end )
    Upvalue11 = 0.85
    Upvalue12.level = 0.35
    Upvalue13.level = 0.35
end )
]]

--[[
Function #78 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = -8.5 + 4.5 * Amount
local Result2 = 0.75 + 0.30000000000000004 * Amount
return Upvalue1 + Vector3.new( Result, Result2, -16.5 + 1.5 * Amount )
]]

--[[
Function #79 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( 0.30000001192092896, 3.299999952316284, 3.4000000953674316 )
]]

--[[
Function #80 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0, 0.05 )
]]

--[[
Function #81 has no emitted closure site
It is reproduced here so that nothing is lost

return 45 + -4 * Amount
]]

--[[
Function #82 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -3.5 + 2.5 * Amount ) )
]]

--[[
Function #83 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( 0, 3, 1 )
]]

--[[
Function #84 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( -3, 1.399999976158142, -13 )
]]

--[[
Function #85 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( 0, 3.4000000953674316, 3 )
]]

--[[
Function #86 has no emitted closure site
It is reproduced here so that nothing is lost

return 40
]]

--[[
Function #87 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    local Id = Upvalue2[ 2 ].Id

    if not Id then
        return
    end

    local Value1 = Upvalue3( Id, 1.2, 1 )
    Value1.SoundGroup = Upvalue4
    Value1:Play( )
    Upvalue5[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue5[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end
]]

--[[
Function #88 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.35 do
    if Upvalue1 then
        break
    end

    local Clock2 = ( os.clock( ) - Clock ) / 0.35
    Upvalue2.jolt = CFrame.new( 0, 0, math.sin( 3.141592653589793 * Clock2 ) * 0.16 ) * CFrame.Angles( Upvalue3( math.sin( 3.141592653589793 * Clock2 ) * 2.5 ), 0, 0 )
    Upvalue4.RenderStepped:Wait( )
end

Upvalue2.jolt = CFrame.identity
]]

--[[
Function #89 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if Aborted2 or not Upvalue2 then
    return
end

local SPAS122
local SPAS12 = Upvalue3.SPAS12

if SPAS12 then
    local Sounds = Upvalue3.SPAS12.Sounds

    if Sounds then
        SPAS122 = Upvalue3.SPAS12.Sounds.Bolt
    else
        SPAS122 = Sounds
    end
else
    SPAS122 = SPAS12
end
if type( SPAS122 ) ~= "table" or type( SPAS122[ 1 ] ) ~= "table" then
    local SPAS124
    local SPAS123 = Upvalue3.SPAS12
    SPAS124 = if SPAS123 then SPAS123.Sounds else SPAS123
    local Bolt2

    if SPAS124 then
        local Bolt = SPAS124.Bolt

        if type( Bolt ) == "table" then
            Bolt2 = Bolt[ 1 ]
        else
            Bolt2 = Bolt
        end
        if type( Bolt2 ) == "table" then
            Bolt2 = Bolt2.Id
        end
        if not Bolt2 then
            Bolt2 = nil
        end
    else
        Bolt2 = nil
    end
    if Bolt2 then
        local Value2 = Upvalue4( Bolt2, 1.2, 1 )
        Value2.SoundGroup = Upvalue5
        Value2:Play( )
        Upvalue6[ Value2 ] = true
        task.delay( 16, function()
            if Value2.Parent then
                Upvalue6[ Value2 ] = nil
                Value2:Destroy( )
            end
        end )
    end
else
    local Id = SPAS122[ 1 ].Id

    if Id then
        local Value1 = Upvalue4( Id, 1.2, 1 )
        Value1.SoundGroup = Upvalue5
        Value1:Play( )
        Upvalue6[ Value1 ] = true
        task.delay( 16, function()
            if Value1.Parent then
                Upvalue6[ Value1 ] = nil
                Value1:Destroy( )
            end
        end )
    end
    if SPAS122[ 2 ] then
        task.delay( math.max( 0.2, ( SPAS122[ 2 ].At or 0.65 ) - ( SPAS122[ 1 ].At or 0.27 ) ), function()
            if not Upvalue7 then
                local Id = SPAS122[ 2 ].Id

                if not Id then
                    return
                end

                local Value1 = Upvalue4( Id, 1.2, 1 )
                Value1.SoundGroup = Upvalue5
                Value1:Play( )
                Upvalue6[ Value1 ] = true
                task.delay( 16, function()
                    if Value1.Parent then
                        Upvalue6[ Value1 ] = nil
                        Value1:Destroy( )
                    end
                end )
            end
        end )
    end
end

task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < 0.35 do
        if Upvalue7 then
            break
        end

        local Clock2 = ( os.clock( ) - Clock ) / 0.35
        Upvalue2.jolt = CFrame.new( 0, 0, math.sin( 3.141592653589793 * Clock2 ) * 0.16 ) * CFrame.Angles( Upvalue8( math.sin( 3.141592653589793 * Clock2 ) * 2.5 ), 0, 0 )
        Upvalue9.RenderStepped:Wait( )
    end

    Upvalue2.jolt = CFrame.identity
end )
Upvalue10.kick = 1.5
]]

--[[
Function #90 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame = Upvalue1.origin.CFrame
local Result = 1.75 + -0.44999999999999996 * Amount
local Result2 = 0.5 + -0.12 * Amount
return CFrame * Vector3.new( Result, Result2, -0.5 + -0.44999999999999996 * Amount )
]]

--[[
Function #91 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.origin.CFrame * Vector3.new( 0.10000000149011612, 0.10000000149011612, -1.25 )
]]

--[[
Function #92 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( -0.04, 0 )
]]

--[[
Function #93 has no emitted closure site
It is reproduced here so that nothing is lost

return 31 + -3 * Amount
]]

--[[
Function #94 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 6 + -4 * Amount ) )
]]

--[[
Function #95 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.origin.CFrame * Vector3.new( 0.10000000149011612, 0.10000000149011612, -1.25 )
]]

--[[
Function #96 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.level = 1.1
Upvalue1.from = Upvalue2.origin.CFrame * Vector3.new( 0.800000011920929, 1.7999999523162842, -0.6000000238418579 )
Upvalue1.to = Upvalue2.origin.CFrame * Vector3.new( 0, 0, -1.2000000476837158 )
]]

--[[
Function #97 has no emitted closure site
It is reproduced here so that nothing is lost

local Position2

if Upvalue1 then
    local Position = Upvalue1.Position

    if Position then
        Position2 = Position
    elseif not Upvalue2 or not Upvalue2.origin then
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    else
        local CFrame = Upvalue2.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

        if CFrame then
            Position2 = CFrame
        else
            Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
        end
    end
elseif not Upvalue2 or not Upvalue2.origin then
    Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
else
    local CFrame = Upvalue2.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

    if CFrame then
        Position2 = CFrame
    else
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    end
end

return Position2
]]

--[[
Function #98 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    local Table = { Size = UDim2.fromScale( 0, 0 ) }
    Upvalue2:Create( Upvalue1, TweenInfo.new( 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
    local Table2 = { Brightness = 0 }
    Upvalue2:Create( Upvalue3, TweenInfo.new( 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
end
]]

--[[
Function #99 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if Aborted2 then
    return
end

local WorldPosition

if Upvalue2 then
    local Position = Upvalue2.Position

    if Position then
        WorldPosition = Position
    elseif not Upvalue3 or not Upvalue3.origin then
        WorldPosition = Upvalue4 + Vector3.new( -6, 4.5, 5 )
    else
        local CFrame = Upvalue3.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

        if CFrame then
            WorldPosition = CFrame
        else
            WorldPosition = Upvalue4 + Vector3.new( -6, 4.5, 5 )
        end
    end
elseif not Upvalue3 or not Upvalue3.origin then
    WorldPosition = Upvalue4 + Vector3.new( -6, 4.5, 5 )
else
    local CFrame = Upvalue3.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

    if CFrame then
        WorldPosition = CFrame
    else
        WorldPosition = Upvalue4 + Vector3.new( -6, 4.5, 5 )
    end
end

local Adornee = Instance.new( "Attachment" )
Adornee.WorldPosition = WorldPosition
Adornee.Parent = workspace.Terrain
table.insert( Upvalue5, Adornee )
local Parent = Instance.new( "BillboardGui" )
Parent.Size = UDim2.fromScale( 0, 0 )
Parent.LightInfluence = 0
Parent.AlwaysOnTop = false
Parent.Adornee = Adornee
Parent.Parent = Upvalue6
local ImageLabel = Instance.new( "ImageLabel" )
ImageLabel.BackgroundTransparency = 1
ImageLabel.Image = "rbxasset://textures/particles/sparkles_main.dds"
ImageLabel.ImageColor3 = Color3.fromRGB( 255, 252, 240 )
ImageLabel.Size = UDim2.fromScale( 1, 1 )
ImageLabel.Parent = Parent
local PointLight = Instance.new( "PointLight" )
local Color = Color3.fromRGB( 255, 250, 235 )
PointLight.Range = 5
PointLight.Brightness = 3
PointLight.Color = Color
PointLight.Parent = Adornee
local Table = { Size = UDim2.fromScale( 3.2, 3.2 ) }
Upvalue7:Create( Parent, TweenInfo.new( 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
task.delay( 0.4, function()
    if Parent.Parent then
        local Table = { Size = UDim2.fromScale( 0, 0 ) }
        Upvalue7:Create( Parent, TweenInfo.new( 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
        local Table2 = { Brightness = 0 }
        Upvalue7:Create( PointLight, TweenInfo.new( 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
    end
end )
local Flicker = Upvalue8.flicker

if Flicker then
    local Value1 = Upvalue9( Flicker, 0.25, 2.2 )
    Value1:Play( )
    Upvalue10[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue10[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
    return
end
return
]]

--[[
Function #100 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if not Aborted2 then
    local AWP2
    local AWP = Upvalue2.AWP
    AWP2 = if AWP then AWP.Sounds else AWP
    local Bolt2

    if AWP2 then
        local Bolt = AWP2.Bolt

        if type( Bolt ) == "table" then
            Bolt2 = Bolt[ 1 ]
        else
            Bolt2 = Bolt
        end
        if type( Bolt2 ) == "table" then
            Bolt2 = Bolt2.Id
        end
        if not Bolt2 then
            Bolt2 = nil
        end
    else
        Bolt2 = nil
    end
    if not Bolt2 then
        return
    end

    local Value1 = Upvalue3( Bolt2, 1.3, 1 )
    Value1.SoundGroup = Upvalue4
    Value1:Play( )
    Upvalue5[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue5[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end
]]

--[[
Function #101 has no emitted closure site
It is reproduced here so that nothing is lost

local Position2
local CFrame = Upvalue1.origin.CFrame

if Upvalue2 then
    local Position = Upvalue2.Position

    if Position then
        Position2 = Position
    elseif not Upvalue1 or not Upvalue1.origin then
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    else
        local CFrame2 = Upvalue1.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

        if CFrame2 then
            Position2 = CFrame2
        else
            Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
        end
    end
elseif not Upvalue1 or not Upvalue1.origin then
    Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
else
    local CFrame2 = Upvalue1.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

    if CFrame2 then
        Position2 = CFrame2
    else
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    end
end

return Position2 + CFrame.LookVector * ( 2.6 + -0.6000000000000001 * Amount ) - CFrame.RightVector * ( 0.75 + -0.19999999999999996 * Amount ) + Vector3.new( 0, 0.2 + -0.08000000000000002 * Amount, 0 )
]]

--[[
Function #102 has no emitted closure site
It is reproduced here so that nothing is lost

local Position2

if Upvalue1 then
    local Position = Upvalue1.Position

    if Position then
        Position2 = Position
    elseif not Upvalue2 or not Upvalue2.origin then
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    else
        local CFrame = Upvalue2.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

        if CFrame then
            Position2 = CFrame
        else
            Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
        end
    end
elseif not Upvalue2 or not Upvalue2.origin then
    Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
else
    local CFrame = Upvalue2.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

    if CFrame then
        Position2 = CFrame
    else
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    end
end

return Position2
]]

--[[
Function #103 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0.06, 0 )
]]

--[[
Function #104 has no emitted closure site
It is reproduced here so that nothing is lost

return 25 + -3 * Amount
]]

--[[
Function #105 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -5 + 3 * Amount ) )
]]

--[[
Function #106 has no emitted closure site
It is reproduced here so that nothing is lost

local Position2

if Upvalue1 then
    local Position = Upvalue1.Position

    if Position then
        Position2 = Position
    elseif not Upvalue2 or not Upvalue2.origin then
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    else
        local CFrame = Upvalue2.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

        if CFrame then
            Position2 = CFrame
        else
            Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
        end
    end
elseif not Upvalue2 or not Upvalue2.origin then
    Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
else
    local CFrame = Upvalue2.origin.CFrame * Vector3.new( 0, 0.550000011920929, -1 )

    if CFrame then
        Position2 = CFrame
    else
        Position2 = Upvalue3 + Vector3.new( -6, 4.5, 5 )
    end
end

return Position2
]]

-- Could not structure function #107

--[[
Function #108 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.9 do
    if Upvalue1 then
        break
    end

    local Clamp = math.clamp( ( os.clock( ) - Clock ) / 0.9, 0, 1 )
    Upvalue2.look = -0.18 + 0.4 * ( Clamp * Clamp * ( 3 - 2 * Clamp ) )
    Upvalue3.RenderStepped:Wait( )
end
]]

--[[
Function #109 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 or Upvalue2.CFrame.Rotation * CFrame.Angles( 0, 0.2, 0 )
return CFrame.new( Upvalue2.Position ) * Upvalue1
]]

--[[
Function #110 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 or Upvalue2.CFrame.Rotation * CFrame.Angles( 0, 0.2, 0 )
local CFrame2 = CFrame.new( Upvalue2.Position ) * Upvalue1
local Result = 0.95 + -0.29999999999999993 * Amount
local Result2 = -0.2 + 0.08000000000000002 * Amount
return CFrame2 * Vector3.new( Result, Result2, -2.5 + 0.6000000000000001 * Amount )
]]

--[[
Function #111 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.Position + Vector3.new( 0, 0.019999999552965164, 0 )
]]

--[[
Function #112 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0.08, 0.02 )
]]

--[[
Function #113 has no emitted closure site
It is reproduced here so that nothing is lost

return 31 + -3 * Amount
]]

--[[
Function #114 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 4 + -3 * Amount ) )
]]

--[[
Function #115 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.Position
]]

--[[
Function #116 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.level = 1.4
Upvalue2 = Upvalue2 or Upvalue3.CFrame.Rotation * CFrame.Angles( 0, 0.2, 0 )
Upvalue1.from = CFrame.new( Upvalue3.Position ) * Upvalue2 * Vector3.new( 0.8999999761581421, -0.10000000149011612, -1.7000000476837158 )
Upvalue2 = Upvalue2 or Upvalue3.CFrame.Rotation * CFrame.Angles( 0, 0.2, 0 )
Upvalue1.to = CFrame.new( Upvalue3.Position ) * Upvalue2 * Vector3.new( 0, -0.15000000596046448, -0.30000001192092896 )
]]

--[[
Function #117 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if not Aborted2 then
    local Rise = Upvalue2.rise

    if not Rise then
        return
    end

    local Value1 = Upvalue3( Rise, 0.8, 1 )
    Value1:Play( )
    Upvalue4[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue4[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end
]]

--[[
Function #118 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.7 do
    if Upvalue1 then
        break
    end

    local Clamp = math.clamp( ( os.clock( ) - Clock ) / 0.7, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    local Look = 0 + 0.2 * Clamp2
    local Nod = 0 + -0.05 * Clamp2
    Upvalue2.look = Look
    Upvalue2.nod = Nod
    Upvalue3.RenderStepped:Wait( )
end
]]

--[[
Function #119 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue1 then
    local CFrame = Upvalue1.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local Result = 3.9 + -1.5499999999999998 * Amount
local Result2 = -0.75 + 0.4 * Amount
return CFrame2 + Vector3.new( Result, Result2, -2 + 0.8500000000000001 * Amount )
]]

--[[
Function #120 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue1 then
    local CFrame = Upvalue1.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

return CFrame2 + Vector3.new( 0, -0.15000000596046448, 0.10000000149011612 )
]]

--[[
Function #121 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0.1, 0.02 )
]]

--[[
Function #122 has no emitted closure site
It is reproduced here so that nothing is lost

return 34 + -7 * Amount
]]

--[[
Function #123 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 3 + -2.5 * Amount ) )
]]

--[[
Function #124 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue1 then
    local CFrame = Upvalue1.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

return CFrame2
]]

--[[
Function #125 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2
Upvalue1.level = 0.95

if Upvalue2 then
    local CFrame = Upvalue2.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local To
Upvalue1.from = CFrame2 + Vector3.new( -1.5, 1.2999999523162842, 2 )

if Upvalue2 then
    local CFrame3 = Upvalue2.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame3 then
        To = CFrame3
    else
        To = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    To = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local CFrame5
Upvalue1.to = To

if Upvalue2 then
    local CFrame4 = Upvalue2.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame4 then
        CFrame5 = CFrame4
    else
        CFrame5 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame5 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local CFrame7
Upvalue4.from = CFrame5 + Vector3.new( 2.5999999046325684, 1.899999976158142, -2.4000000953674316 )

if Upvalue2 then
    local CFrame6 = Upvalue2.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame6 then
        CFrame7 = CFrame6
    else
        CFrame7 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame7 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

Upvalue4.to = CFrame7 + Vector3.new( 0, -0.30000001192092896, 0 )
]]

--[[
Function #126 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue1:Stop( )
end
]]

--[[
Function #127 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue1 then
    local CFrame = Upvalue1.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local Result = 0.3 + -0.06 * Amount
return CFrame2 + Vector3.new( Result, -0.04, -2.35 + 0.20000000000000018 * Amount )
]]

--[[
Function #128 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue1 then
    local CFrame = Upvalue1.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

return CFrame2
]]

--[[
Function #129 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0, 0.02 )
]]

--[[
Function #130 has no emitted closure site
It is reproduced here so that nothing is lost

return 17
]]

--[[
Function #131 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue1 then
    local CFrame = Upvalue1.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue2 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

return CFrame2
]]

--[[
Function #132 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame2

if Upvalue2 then
    local CFrame = Upvalue2.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame then
        CFrame2 = CFrame
    else
        CFrame2 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    CFrame2 = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

local To
Upvalue1.from = CFrame2 + Vector3.new( 1.2000000476837158, 0.5, -1.2000000476837158 )

if Upvalue2 then
    local CFrame3 = Upvalue2.CFrame * Vector3.new( 0, 0.11999999731779099, -0.44999998807907104 )

    if CFrame3 then
        To = CFrame3
    else
        To = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
    end
else
    To = Upvalue3 + Vector3.new( 0, 5.400000095367432, -0.4000000059604645 )
end

Upvalue1.to = To
]]

--[[
Function #133 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if not Aborted2 then
    local Clunk = Upvalue2.clunk
    local Captured = Upvalue3 * 0.08 + 0.9

    if not Clunk then
        return
    end

    local Value1 = Upvalue4( Clunk, 0.55, Captured )
    Value1.SoundGroup = Upvalue5
    Value1:Play( )
    Upvalue6[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue6[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end
]]

--[[
Function #134 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.level = 1
]]

--[[
Function #135 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value.TimeScale = 0.25
end
]]

--[[
Function #136 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.7 do
    if Upvalue1 then
        break
    end

    local Value1
    local TimeScale = 0.25 + 0.75 * ( ( os.clock( ) - Clock ) / 0.7 )
    Value1 = nil

    for Key, Value in Upvalue2, nil, nil do
        Value.TimeScale = TimeScale
    end

    Upvalue3.RenderStepped:Wait( )
end

local Value2 = nil

for Key2, Value3 in Upvalue2, nil, nil do
    Value3.TimeScale = 1
end
]]

--[[
Function #137 has no emitted closure site
It is reproduced here so that nothing is lost

return ( 1 - ( 1 - math.clamp( Amount, 0, 1 ) ) ^ 3 ) * 0.9 + Amount * 0.1
]]

--[[
Function #138 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = ( 1 - ( 1 - math.clamp( Amount, 0, 1 ) ) ^ 3 ) * 0.9 + Amount * 0.1
local Clamp2 = 0.5 + -3.9 * Clamp
local Clamp3 = 2.8 + -1.3499999999999999 * Clamp
return Upvalue1 + Vector3.new( Clamp2, Clamp3, -3.6 + -11.4 * Clamp )
]]

--[[
Function #139 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = ( 1 - ( 1 - math.clamp( Amount, 0, 1 ) ) ^ 3 ) * 0.9 + Amount * 0.1
local Clamp2 = 3.1 + 0.2999999999999998 * Clamp
return Upvalue1 + Vector3.new( 0, Clamp2, -0.4 + 3.1999999999999997 * Clamp )
]]

--[[
Function #140 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0, 0.04 )
]]

--[[
Function #141 has no emitted closure site
It is reproduced here so that nothing is lost

return 33 + 13 * ( ( 1 - ( 1 - math.clamp( Amount, 0, 1 ) ) ^ 3 ) * 0.9 + Amount * 0.1 )
]]

--[[
Function #142 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 5 + -6 * ( ( 1 - ( 1 - math.clamp( Amount, 0, 1 ) ) ^ 3 ) * 0.9 + Amount * 0.1 ) ) )
]]

--[[
Function #143 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( 0, 3.200000047683716, 0 )
]]

--[[
Function #144 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while Upvalue1.Parent do
    if Upvalue2 then
        break
    end

    local Clock2 = os.clock( ) - Clock
    local Clamp = math.clamp( Clock2 / 0.5, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    Upvalue1.OutlineTransparency = 1 - Clamp2 * ( math.sin( Clock2 * 4 ) * 0.3 + 0.65 )
    Upvalue1.FillTransparency = 1 - Clamp2 * ( math.sin( Clock2 * 4 ) * 0.05 + 0.06 )
    Upvalue3.RenderStepped:Wait( )
end
]]

--[[
Function #145 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #146 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.3 do
    if Upvalue1 then
        break
    end

    local Clock2 = ( os.clock( ) - Clock ) / 0.3
    Upvalue2.jolt = CFrame.new( 0, 0, math.exp( -Clock2 * 4 ) * 0.14 * math.sin( 3.141592653589793 * math.min( Clock2 * 3, 1 ) ) ) * CFrame.Angles( Upvalue3( math.exp( -Clock2 * 4 ) * 1.5 ), 0, 0 )
    Upvalue4.RenderStepped:Wait( )
end

Upvalue2.jolt = CFrame.identity
]]

--[[
Function #147 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Hit_Sparks
local Captured = Upvalue2 + Upvalue3 * 30
local Random = -4 + math.random( ) * 8
local WorldPosition = Captured + Vector3.new( Random, -0.5 + math.random( ) * 2.5, 0 )
local Attachment0 = Instance.new( "Attachment" )
Attachment0.WorldPosition = WorldPosition
Attachment0.Parent = workspace.Terrain
table.insert( Upvalue4, Attachment0 )
local Attachment1 = Instance.new( "Attachment" )
Attachment1.WorldPosition = Upvalue2
Attachment1.Parent = workspace.Terrain
table.insert( Upvalue4, Attachment1 )
local Beam = Instance.new( "Beam" )
Beam.Attachment0 = Attachment0
Beam.Attachment1 = Attachment1
Beam.Width0 = 0.08
Beam.Width1 = 0.04
Beam.FaceCamera = true
Beam.LightEmission = 1
Beam.Segments = 1
Beam.Color = ColorSequence.new( Color3.fromRGB( 255, 226, 170 ) )
Beam.Transparency = NumberSequence.new( { NumberSequenceKeypoint.new( 0, 0.6 ), Upvalue5( 1, 0.05 ) } )
Beam.Parent = Upvalue6
task.delay( 0.06, function()
    Beam:Destroy( )
end )
local Parent = Instance.new( "Attachment" )
Parent.Parent = workspace.Terrain
Parent.WorldCFrame = CFrame.lookAt( Upvalue2, Upvalue2 + Upvalue3 )
table.insert( Upvalue4, Parent )
local Hits = Upvalue7:FindFirstChild( "Hits" )

if Hits then
    Hit_Sparks = Hits:FindFirstChild( "Hit_Sparks" )
else
    Hit_Sparks = Hits
end
if Hit_Sparks then
    for Key, Value in Hit_Sparks:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            local Clone = Value:Clone( )
            Clone.Enabled = false
            Clone.EmissionDirection = Enum.NormalId.Front
            Clone.Parent = Parent
            Clone:Emit( ( Value:GetAttribute( "EmitCount" ) or 6 ) * 3 )
        end
    end
end

local PointLight = Instance.new( "PointLight" )
local Color = Color3.fromRGB( 255, 200, 140 )
PointLight.Range = 10
PointLight.Brightness = 8
PointLight.Color = Color
PointLight.Parent = Parent
local Table = { Brightness = 0 }
Upvalue8:Create( PointLight, TweenInfo.new( 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
local Clang = Upvalue9.SOUNDS.clang
local Entry = Clang[ math.random( #Clang ) ]
local Random2 = 1.05 + math.random( ) * 0.19999999999999996

if Entry then
    local Value1 = Upvalue10( Entry, 1.6, Random2 )
    Value1.SoundGroup = Upvalue11
    Value1:Play( )
    Upvalue12[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue12[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end

Upvalue13.kick = math.max( Upvalue13.kick, 1.6 )
task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < 0.3 do
        if Upvalue1 then
            break
        end

        local Clock2 = ( os.clock( ) - Clock ) / 0.3
        Upvalue14.jolt = CFrame.new( 0, 0, math.exp( -Clock2 * 4 ) * 0.14 * math.sin( 3.141592653589793 * math.min( Clock2 * 3, 1 ) ) ) * CFrame.Angles( Upvalue15( math.exp( -Clock2 * 4 ) * 1.5 ), 0, 0 )
        Upvalue16.RenderStepped:Wait( )
    end

    Upvalue14.jolt = CFrame.identity
end )
]]

--[[
Function #148 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if Aborted2 or Upvalue2 or not Upvalue3 then
    return
end

local CFrame3

if Upvalue3 then
    local CFrame2 = Upvalue3.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue4 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue4 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local Random = -1.1 + math.random( ) * 2.2
local CFrame4 = CFrame3 * Vector3.new( Random, -1.6 + math.random( ) * 3.9, -0.3 )
local LookVector = CFrame3.LookVector
local Shot = Upvalue5.SOUNDS.shot
local Random2 = 0.95 + math.random( ) * 0.10000000000000009

if Shot then
    local Value1 = Upvalue6( Shot, 0.35, Random2 )
    Value1.SoundGroup = Upvalue7
    Value1:Play( )
    Upvalue8[ Value1 ] = true
    task.delay( 16, function()
        if Value1.Parent then
            Upvalue8[ Value1 ] = nil
            Value1:Destroy( )
        end
    end )
end

task.delay( 0.04, function()
    if Upvalue2 then
        return
    end

    local Hit_Sparks
    local Captured = CFrame4 + LookVector * 30
    local Random = -4 + math.random( ) * 8
    local WorldPosition = Captured + Vector3.new( Random, -0.5 + math.random( ) * 2.5, 0 )
    local Attachment0 = Instance.new( "Attachment" )
    Attachment0.WorldPosition = WorldPosition
    Attachment0.Parent = workspace.Terrain
    table.insert( Upvalue9, Attachment0 )
    local Attachment1 = Instance.new( "Attachment" )
    Attachment1.WorldPosition = CFrame4
    Attachment1.Parent = workspace.Terrain
    table.insert( Upvalue9, Attachment1 )
    local Beam = Instance.new( "Beam" )
    Beam.Attachment0 = Attachment0
    Beam.Attachment1 = Attachment1
    Beam.Width0 = 0.08
    Beam.Width1 = 0.04
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.Segments = 1
    Beam.Color = ColorSequence.new( Color3.fromRGB( 255, 226, 170 ) )
    Beam.Transparency = NumberSequence.new( { NumberSequenceKeypoint.new( 0, 0.6 ), Upvalue10( 1, 0.05 ) } )
    Beam.Parent = Upvalue11
    task.delay( 0.06, function()
        Beam:Destroy( )
    end )
    local Parent = Instance.new( "Attachment" )
    Parent.Parent = workspace.Terrain
    Parent.WorldCFrame = CFrame.lookAt( CFrame4, CFrame4 + LookVector )
    table.insert( Upvalue9, Parent )
    local Hits = Upvalue12:FindFirstChild( "Hits" )

    if Hits then
        Hit_Sparks = Hits:FindFirstChild( "Hit_Sparks" )
    else
        Hit_Sparks = Hits
    end
    if Hit_Sparks then
        for Key, Value in Hit_Sparks:GetDescendants( ) do
            if Value:IsA( "ParticleEmitter" ) then
                local Clone = Value:Clone( )
                Clone.Enabled = false
                Clone.EmissionDirection = Enum.NormalId.Front
                Clone.Parent = Parent
                Clone:Emit( ( Value:GetAttribute( "EmitCount" ) or 6 ) * 3 )
            end
        end
    end

    local PointLight = Instance.new( "PointLight" )
    local Color = Color3.fromRGB( 255, 200, 140 )
    PointLight.Range = 10
    PointLight.Brightness = 8
    PointLight.Color = Color
    PointLight.Parent = Parent
    local Table = { Brightness = 0 }
    Upvalue13:Create( PointLight, TweenInfo.new( 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
    local Clang = Upvalue5.SOUNDS.clang
    local Entry = Clang[ math.random( #Clang ) ]
    local Random2 = 1.05 + math.random( ) * 0.19999999999999996

    if Entry then
        local Value1 = Upvalue6( Entry, 1.6, Random2 )
        Value1.SoundGroup = Upvalue7
        Value1:Play( )
        Upvalue8[ Value1 ] = true
        task.delay( 16, function()
            if Value1.Parent then
                Upvalue8[ Value1 ] = nil
                Value1:Destroy( )
            end
        end )
    end

    Upvalue14.kick = math.max( Upvalue14.kick, 1.6 )
    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < 0.3 do
            if Upvalue2 then
                break
            end

            local Clock2 = ( os.clock( ) - Clock ) / 0.3
            Upvalue15.jolt = CFrame.new( 0, 0, math.exp( -Clock2 * 4 ) * 0.14 * math.sin( 3.141592653589793 * math.min( Clock2 * 3, 1 ) ) ) * CFrame.Angles( Upvalue16( math.exp( -Clock2 * 4 ) * 1.5 ), 0, 0 )
            Upvalue17.RenderStepped:Wait( )
        end

        Upvalue15.jolt = CFrame.identity
    end )
end )
]]

--[[
Function #149 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Number, Number2, Number3, Number4
local Position = Upvalue1.Position
local LookAt = CFrame.lookAt( Argument1, Position )
Value1 = nil
Number = math.huge
Number2 = -math.huge
Number3 = -math.huge
Number4 = math.huge

for Key, Value in Upvalue2, nil, nil do
    local PointToObjectSpace = LookAt:PointToObjectSpace( Upvalue1 * Value )
    local Max = math.max( -PointToObjectSpace.Z, 0.1 )
    Number = math.min( Number, PointToObjectSpace.Y / Max )
    Number2 = math.max( Number2, PointToObjectSpace.Y / Max )
    Number4 = math.min( Number4, PointToObjectSpace.X / Max )
    Number3 = math.max( Number3, PointToObjectSpace.X / Max )
end
if Number == math.huge then
    local X2
    local LookAt2 = CFrame.lookAt( Argument1, Position )
    local ViewportSize = Upvalue3.ViewportSize

    if ViewportSize.Y > 0 then
        local X = ViewportSize.X / ViewportSize.Y

        if X then
            X2 = X
        else
            X2 = 1.7777777777777777
        end
    else
        X2 = 1.7777777777777777
    end

    return LookAt2 * CFrame.lookAt( Vector3.new( 0, 0, 0 ), Vector3.new( 0 * X2, 0.08498845740736752, -1 ).Unit ):Inverse( ), 39
end
local X4
local Deg = math.deg( math.atan( ( Number2 - Number ) / 0.96 ) * 2 )
local Number5 = ( Number3 + Number4 ) / 2 * 10
local LookAt3 = CFrame.lookAt( Argument1, LookAt * Vector3.new( Number5, ( Number2 + Number ) / 2 * 10, -10 ) )
local ViewportSize2 = Upvalue3.ViewportSize

if ViewportSize2.Y > 0 then
    local X3 = ViewportSize2.X / ViewportSize2.Y

    if X3 then
        X4 = X3
    else
        X4 = 1.7777777777777777
    end
else
    X4 = 1.7777777777777777
end

local Tan = math.tan( math.rad( Deg ) / 2 )
local Tan2 = 0 * Tan * X4
return LookAt3 * CFrame.lookAt( Vector3.new( 0, 0, 0 ), Vector3.new( Tan2, 0.24 * Tan, -1 ).Unit ):Inverse( ), Deg
]]

--[[
Function #150 has no emitted closure site
It is reproduced here so that nothing is lost

local Min = 1 - ( 1 - math.min( Amount / 4.6, 1 ) ) ^ 2
local Value1 = Upvalue1( -22 + 12 * Min + 1.8 * Amount )
local Min2 = 15.5 + 1.5 * Min + 0.12 * Amount
local Sin = math.sin( Value1 ) * Min2
local Min3 = 1.7 + 0.40000000000000013 * Min
return Upvalue2 + Vector3.new( Sin, Min3, -math.cos( Value1 ) * Min2 ), Min
]]

--[[
Function #151 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.6 do
    local Aborted2
    local Aborted = Upvalue1.aborted
    Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

    if Aborted2 then
        break
    end

    local Floor = math.floor( #Upvalue2 * ( os.clock( ) - Clock ) / 0.6 )
    local Text = Upvalue2:sub( 1, Floor )
    local Floor2 = Floor + 1
    local Count = #Upvalue2
    local I = Floor2

    for I = Floor2, Count do
        if Upvalue2:sub( I, I ) == " " then
            Text = Text .. " "
        else
            local Random = math.random( 40 )
            Text = Text .. ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&" ):sub( Random, Random )
        end
    end

    Upvalue3.Text = Text
    Upvalue4.RenderStepped:Wait( )
end

Upvalue3.Text = Upvalue2
]]

--[[
Function #152 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.3 do
    Upvalue1( ( os.clock( ) - Clock ) / 0.3 )
    Upvalue2.RenderStepped:Wait( )
end

Upvalue1( 1 )
]]

--[[
Function #153 has no emitted closure site
It is reproduced here so that nothing is lost

local CFrame3
local Cf, Fov = Upvalue2( Upvalue3( ( Upvalue4( Amount ) ) ) )
Upvalue1.cf = Cf
Upvalue1.fov = Fov
Upvalue5 = Upvalue6.Position
local Clamp = math.clamp( math.min( Amount / 2.2, 1 ), 0, 1 )
local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )

if Upvalue8 then
    local CFrame2 = Upvalue8.CFrame

    if CFrame2 then
        CFrame3 = CFrame2
    else
        CFrame3 = CFrame.new( Upvalue9 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame3 = CFrame.new( Upvalue9 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local CFrame5
Upvalue7.from = CFrame3 * Vector3.new( -3.2 + 6.4 * Clamp2, 2.6, -3.4 )

if Upvalue8 then
    local CFrame4 = Upvalue8.CFrame

    if CFrame4 then
        CFrame5 = CFrame4
    else
        CFrame5 = CFrame.new( Upvalue9 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end
else
    CFrame5 = CFrame.new( Upvalue9 + Vector3.new( 0, 3, -1.7000000476837158 ) )
end

local Value1
Upvalue7.to = CFrame5 * Vector3.new( -1.1 + 2.2 * Clamp2, 0.6, -0.3 )
Value1 = nil

for Key, Value in Upvalue10, nil, nil do
    local CFrame7

    if Upvalue8 then
        local CFrame6 = Upvalue8.CFrame

        if CFrame6 then
            CFrame7 = CFrame6
        else
            CFrame7 = CFrame.new( Upvalue9 + Vector3.new( 0, 3, -1.7000000476837158 ) )
        end
    else
        CFrame7 = CFrame.new( Upvalue9 + Vector3.new( 0, 3, -1.7000000476837158 ) )
    end

    Value.CFrame = CFrame7 * CFrame.new( 0, 0, -0.4 )
end
if Upvalue11[ Upvalue12 ] and Upvalue11[ Upvalue12 ] <= Amount then
    Upvalue12 = Upvalue12 + 1
    Upvalue13( )
end
if not Upvalue14 and Amount > 0.4 then
    Upvalue14 = true
    local Aura = Upvalue15.aura

    if Aura then
        local Value2 = Upvalue16( Aura, 0.9, 1 )
        Value2:Play( )
        Upvalue17[ Value2 ] = true
        task.delay( 16, function()
            if Value2.Parent then
                Upvalue17[ Value2 ] = nil
                Value2:Destroy( )
            end
        end )
    end

    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < 0.6 do
            local Aborted2
            local Aborted = Upvalue18.aborted
            Aborted2 = if Aborted then Upvalue18.aborted( ) else Aborted

            if Aborted2 then
                break
            end

            local Floor = math.floor( #Upvalue19 * ( os.clock( ) - Clock ) / 0.6 )
            local Text = Upvalue19:sub( 1, Floor )
            local Floor2 = Floor + 1
            local Count = #Upvalue19
            local I = Floor2

            for I = Floor2, Count do
                if Upvalue19:sub( I, I ) == " " then
                    Text = Text .. " "
                else
                    local Random = math.random( 40 )
                    Text = Text .. ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&" ):sub( Random, Random )
                end
            end

            Upvalue20.Text = Text
            Upvalue21.RenderStepped:Wait( )
        end

        Upvalue20.Text = Upvalue19
    end )

    if Upvalue22 then
        Upvalue22.Scale = 1.8
        local Table = { Scale = 1 }
        Upvalue23:Create( Upvalue22, TweenInfo.new( 0.55, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
    end

    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < 0.3 do
            Upvalue24( ( os.clock( ) - Clock ) / 0.3 )
            Upvalue21.RenderStepped:Wait( )
        end

        Upvalue24( 1 )
    end )
end
]]

--[[
Function #154 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1( 1 - Amount )
local Cf, Fov = Upvalue3( ( Upvalue4( 4.6 + 0.5 * Amount ) ) )
Upvalue2.cf = Cf
Upvalue2.fov = Fov
Value1 = nil

for Value in Upvalue5, nil, nil do
    if Value.Parent then
        Value.Volume = Value.Volume * 0.9
    end
end
]]

--[[
Function #155 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.BackgroundTransparency >= 0.99 then
    Upvalue2.Enabled = false
end
]]

--[[
Function #156 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { BackgroundTransparency = 1 }
Upvalue2:Create( Upvalue1, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
task.delay( 0.4, function()
    if Upvalue1.BackgroundTransparency >= 0.99 then
        Upvalue3.Enabled = false
    end
end )
]]
