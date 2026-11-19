-- ReplicatedStorage.Weapons.HitboxModel
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Parent = script.Parent
local Config = require( Parent:WaitForChild( "Config" ) )
local Clips = require( Parent:WaitForChild( "Clips" ) )
local RunGait = require( Parent:WaitForChild( "RunGait" ) )
local Holds = require( Parent:WaitForChild( "Holds" ) )
local SwimTilt = require( Parent:WaitForChild( "SwimTilt" ) )
local Table = {
    BOXES = {
        "Head",
        "UpperTorso",
        "LowerTorso",
        "LeftUpperLeg",
        "LeftLowerLeg",
        "LeftFoot",
        "RightUpperLeg",
        "RightLowerLeg",
        "RightFoot",
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftHand",
        "RightUpperArm",
        "RightLowerArm",
        "RightHand"
    }
}
local Table2 = { }
local BOXES = Table.BOXES
Value1 = nil

for Key, Value in BOXES, nil, nil do
    Table2[ Value ] = true
end

function Table.IsBox( Key )
    local Flag = Table2[ Key ] == true and true or false
    return Flag
end
Table.HEAD = { Head = true }
Table.LIMB = {
    LeftUpperLeg = true,
    LeftLowerLeg = true,
    LeftFoot = true,
    RightUpperLeg = true,
    RightLowerLeg = true,
    RightFoot = true,
    LeftUpperArm = true,
    LeftLowerArm = true,
    LeftHand = true,
    RightUpperArm = true,
    RightLowerArm = true,
    RightHand = true
}
local Table3 = {
    Head = Vector3.new( 1.2999999523162842, 1.100000023841858, 1.2999999523162842 ),
    UpperTorso = Vector3.new( 1.149999976158142, 0.8500000238418579, 1.5 ),
    LowerTorso = Vector3.new( 1.149999976158142, 1.149999976158142, 1.5 ),
    LeftUpperArm = Vector3.new( 1.100000023841858, 1.100000023841858, 1.2999999523162842 ),
    LeftLowerArm = Vector3.new( 1.100000023841858, 1.100000023841858, 1.2999999523162842 ),
    LeftHand = Vector3.new( 1.100000023841858, 1.100000023841858, 1.2999999523162842 ),
    RightUpperArm = Vector3.new( 1.100000023841858, 1.100000023841858, 1.2999999523162842 ),
    RightLowerArm = Vector3.new( 1.100000023841858, 1.100000023841858, 1.2999999523162842 ),
    RightHand = Vector3.new( 1.100000023841858, 1.100000023841858, 1.2999999523162842 ),
    LeftUpperLeg = Vector3.new( 1.100000023841858, 1, 1.5 ),
    LeftLowerLeg = Vector3.new( 1.100000023841858, 1, 1.5 ),
    RightUpperLeg = Vector3.new( 1.100000023841858, 1, 1.5 ),
    RightLowerLeg = Vector3.new( 1.100000023841858, 1, 1.5 )
}
local Table4 = {
    { "LowerTorso", "Root", "HumanoidRootPart" },
    { "UpperTorso", "Waist", "LowerTorso" },
    { "Head", "Neck", "UpperTorso" },
    { "LeftUpperLeg", "LeftHip", "LowerTorso" },
    { "LeftLowerLeg", "LeftKnee", "LeftUpperLeg" },
    { "LeftFoot", "LeftAnkle", "LeftLowerLeg" },
    { "RightUpperLeg", "RightHip", "LowerTorso" },
    { "RightLowerLeg", "RightKnee", "RightUpperLeg" },
    { "RightFoot", "RightAnkle", "RightLowerLeg" }
}
local Table5 = { UpperTorso = -0.1 }
local Table6 = {
    { "RightShoulder", "RightUpperArm", "RightLowerArm", "RightHand" },
    { "LeftShoulder", "LeftUpperArm", "LeftLowerArm", "LeftHand" }
}

local function Frames( Self )
    if Self:IsA( "Motor6D" ) then
        return Self.C0, Self.C1
    end
    return Self.Attachment0.CFrame, Self.Attachment1.CFrame
end

local Global = Config.Global
local RollTimeScale = Global.RollTimeScale or 1.35
local RollEnd = Global.RollEnd or 1.6
local RollBackStart = Global.RollBackStart or 1.2
local Table7 = {
    Aim = true,
    Reload = true,
    Low = true,
    Sprint = true,
    ReloadAim = true
}

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function IsBack( Name )
    local Flag
    Flag = string.sub( Name or "", 1, 1 ) == "B" and true or false
    return Flag
end

local function RollDuration( DurationName )
    local Flag = string.sub( DurationName or "", 1, 1 ) == "B" and true or false
    local Captured = Flag and RollBackStart or RollEnd
    return Captured / RollTimeScale
end

function Table.State( Object )
    local AssemblyLinearVelocity
    local Tool = Object:FindFirstChildOfClass( "Tool" )
    local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )
    local Humanoid = Object:FindFirstChildOfClass( "Humanoid" )
    AssemblyLinearVelocity = HumanoidRootPart and HumanoidRootPart.AssemblyLinearVelocity or Vector3.new( 0, 0, 0 )
    local Swim, SwimVis

    if not HumanoidRootPart or not Humanoid then
        Swim = nil
        SwimVis = nil
    else
        local Flag
        local Entry = Config.StanceNames[ Object:GetAttribute( "GunStance" ) or 0 ] or "Low"

        if Tool == nil then
            Flag = false
        elseif Tool:GetAttribute( "Weapon" ) == nil then
            Flag = false
        else
            Flag = true
        end

        local Flag2
        local Update = SwimTilt.Update

        if Flag then
            if Entry == "Aim" then
                Flag2 = true
            elseif Entry == "ReloadAim" then
                Flag2 = true
            else
                Flag2 = false
            end
        else
            Flag2 = Flag
        end

        Swim, SwimVis = Update( Object, HumanoidRootPart, Humanoid, Flag2, nil )
    end

    local Crouch
    local Table = { }
    Crouch = Object:GetAttribute( "Crouch" ) == true and true or false
    local MinSpeed2
    Table.crouch = Crouch
    local X = AssemblyLinearVelocity.X
    local Magnitude = Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude

    if Config.RunCycle then
        local MinSpeed = Config.RunCycle.MinSpeed

        if MinSpeed then
            MinSpeed2 = MinSpeed
        else
            MinSpeed2 = 1
        end
    else
        MinSpeed2 = 1
    end

    local Moving = MinSpeed2 < Magnitude and true or false
    local Air
    Table.moving = Moving

    if Humanoid == nil then
        Air = false
    elseif Humanoid.FloorMaterial == Enum.Material.Air then
        Air = true
    else
        Air = false
    end

    local Armed
    Table.air = Air

    if Tool == nil then
        Armed = false
    elseif Tool:GetAttribute( "Weapon" ) == nil then
        Armed = false
    else
        Armed = true
    end

    local Weapon
    Table.armed = Armed
    Weapon = if Tool then Tool:GetAttribute( "Weapon" ) else Tool
    Table.weapon = Weapon
    Table.stance = Config.StanceNames[ Object:GetAttribute( "GunStance" ) or 0 ] or "Low"
    Table.pitch = math.rad( Object:GetAttribute( "GunPitch" ) or 0 )
    Table.rollMode = Object:GetAttribute( "RollMode" )
    Table.rollStart = Object:GetAttribute( "RollStart" )
    Table.rollSpeed = Object:GetAttribute( "RollSpeed" )
    Table.rollCancel = Object:GetAttribute( "RollCancel" )
    Table.swim = Swim
    Table.swimVis = SwimVis
    return Table
end

local function RollAt( Argument1, Argument2 )
    if not Argument1.rollStart or not Argument1.rollMode then
        return 0
    end
    if Argument1.rollCancel and Argument1.rollStart <= Argument1.rollCancel and Argument1.rollCancel <= Argument2 then
        return 0
    end

    local Flag
    local RollStart = ( Argument2 - Argument1.rollStart ) * ( Argument1.rollSpeed or 1 )
    Flag = string.sub( Argument1.rollMode or "", 1, 1 ) == "B" and true or false
    local Captured = Flag and RollBackStart or RollEnd
    local Captured2 = Captured / RollTimeScale

    if RollStart < 0 or Captured2 <= RollStart then
        return 0
    end

    local Flag2 = string.sub( Argument1.rollMode or "", 1, 1 ) == "B" and true or false
    local Captured3
    local RollStart2 = RollStart * RollTimeScale
    Captured3 = Flag2 and RollBackStart or RollEnd
    local Captured5
    local Min = math.min( RollStart2, Captured3 )
    local Sample = Clips.Sample
    local Roll = Clips.Roll

    if Flag2 then
        local Captured4 = RollBackStart - Min

        if Captured4 then
            Captured5 = Captured4
        else
            Captured5 = Min
        end
    else
        Captured5 = Min
    end

    local Sample2, Sample22, Sample3 = Sample( Roll, Captured5 )
    local Clamp = math.clamp( RollStart / 0.08, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    local Clamp3 = math.clamp( ( RollStart - ( Captured2 - 0.2 ) ) / 0.2, 0, 1 )
    local Clamp4 = Clamp2 * ( 1 - Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
    return Clamp4, CFrame.new( 0, Sample2.Y - Clips.Roll.baseY, 0 ) * Sample22, Sample3
end

local Value2 = nil

local function BuildVariants()
    if Value2 then
        return Value2
    end

    local Value1
    Value2 = {
        run = { },
        jump = { },
        crouch = { idle = { { }, { } }, move = { { }, { } }, trans = { { }, { } } }
    }

    local function CrouchPose( PoseName, Argument2, Argument3, Argument4, Amount, Amount2 )
        local CFrame3
        local Sample, Sample2, Sample3 = Clips.Sample( Argument2, Argument3 )
        local FaceForward, FaceForward2 = Clips.FaceForward( Sample2, Sample3 )
        local Angles = CFrame.Angles( 0, math.rad( Amount or 0 ), 0 )
        local Y = Sample.Y - Clips.STAND_Y
        local Table = { }

        if Argument4 then
            local CFrame2 = CFrame.new( 0, Y, 0 )

            if CFrame2 then
                CFrame3 = CFrame2
            else
                local X = Sample.X
                CFrame3 = CFrame.new( X, Y, Sample.Z )
            end
        else
            local X = Sample.X
            CFrame3 = CFrame.new( X, Y, Sample.Z )
        end

        local Value1
        Table.Root = Angles * CFrame3 * FaceForward
        local Table2 = { Root = Table.Root }
        Value1 = nil

        for Key, Value in FaceForward2, nil, nil do
            if not Clips.ARMS[ Key ] then
                Table[ Key ] = Value
            end
            if Key:find( "Hip" ) or Key:find( "Knee" ) or Key:find( "Ankle" ) then
                Table2[ Key ] = Value
            end
        end

        local CFrame7

        if not Amount or Amount == 0 then
            CFrame7 = nil
        else
            local CFrame5

            if Argument4 then
                local CFrame4 = CFrame.new( 0, Y, 0 )

                if CFrame4 then
                    CFrame5 = CFrame4
                else
                    local X2 = Sample.X
                    CFrame5 = CFrame.new( X2, Y, Sample.Z )
                end
            else
                local X2 = Sample.X
                CFrame5 = CFrame.new( X2, Y, Sample.Z )
            end

            local CFrame6 = CFrame5 * FaceForward

            if CFrame6 then
                CFrame7 = CFrame6
            else
                CFrame7 = nil
            end
        end

        local Item = Value2.crouch[ PoseName ][ 1 ]
        table.insert( Item, { T = Table, w = Amount2 or 1, baseRoot = CFrame7 } )
        local Item2 = Value2.crouch[ PoseName ][ 2 ]
        table.insert( Item2, { T = Table2, w = Amount2 or 1, keepUpper = true } )
    end

    local Table = {
        { "idle", Clips.CrouchIdle, 8 },
        { "trans", Clips.CrouchStand, 8, true }
    }
    local Table2 = { 0, 30, -30, 60, -60, 90, -90 }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        table.insert( Table, { "move", Clips.CrouchWalk, 8, false, Value } )
    end

    local Value2Inner
    local Table3 = { 1, 0.8, 0.6, 0.4, 0.2 }
    Value2Inner = nil

    for Key2, Value3 in Table3, nil, nil do
        table.insert( Table, { "trans", Clips.CrouchIdle, 4, false, 0, Value3 } )
        table.insert( Table, { "trans", Clips.CrouchWalk, 8, false, 0, Value3 } )
    end

    local Value4 = nil

    for Key3, Value5 in Table, nil, nil do
        local Item = Value5[ 1 ]
        local Item2 = Value5[ 2 ]
        local Item3 = Value5[ 3 ]

        if Item2 then
            local Item4 = Item3 - 1
            local J = 0

            for J = 0, Item4 do
                CrouchPose( Item, Item2, Item2.length * J / Item3, Value5[ 4 ], Value5[ 5 ], Value5[ 6 ] )
            end
        end
    end
    if RunGait.HasFastRun( ) then
        local I = 0

        for I = 0, 11 do
            local SampleFastRun = RunGait.SampleFastRun( I / 12 )
            table.insert( Value2.run, { T = SampleFastRun, w = 1 } )
            table.insert( Value2.run, { T = SampleFastRun, w = 0.5 } )
        end
    end

    local Jump = Clips.Jump

    if Jump then
        local Number = 0.07

        while Number < Jump.length do
            local Value6
            local Sample, Sample2, Sample3 = Clips.Sample( Jump, Number )
            local Table4 = {
                Root = CFrame.new( 0, math.min( Sample.Y - Jump.baseY, 0 ), 0 ) * Sample2
            }
            Value6 = nil

            for Key4, Value7 in Sample3, nil, nil do
                if not Clips.ARMS[ Key4 ] then
                    Table4[ Key4 ] = Value7
                end
            end

            table.insert( Value2.jump, { T = Table4, w = 1 } )
            Number = Number + 0.07
        end
    end

    return Value2
end

function Table.Variants( Argument1 )
    local Variants = BuildVariants( )
    local Table = { }

    if Argument1.moving and not Argument1.crouch then
        local Run = Variants.run
        table.move( Run, 1, #Variants.run, 1, Table )
    end
    if Argument1.airRecent or Argument1.air then
        local Jump = Variants.jump
        local Count = #Variants.jump
        table.move( Jump, 1, Count, #Table + 1, Table )
    end

    local Number

    if Argument1.armed then
        if Argument1.stance == "Aim" or Argument1.stance == "ReloadAim" then
            Number = 2
        else
            Number = 1
        end
    else
        Number = 1
    end

    local function AddSet( List )
        local Entry = List[ Number ]
        table.move( Entry, 1, #Entry, #Table + 1, Table )
    end

    if Argument1.crouch then
        local Entry = Variants.crouch.idle[ Number ]
        local Count2 = #Entry
        table.move( Entry, 1, Count2, #Table + 1, Table )

        if Argument1.moving then
            local Entry2 = Variants.crouch.move[ Number ]
            local Count3 = #Entry2
            table.move( Entry2, 1, Count3, #Table + 1, Table )
        end
    end
    if Argument1.crouchTrans then
        local Entry3 = Variants.crouch.trans[ Number ]
        local Count4 = #Entry3
        table.move( Entry3, 1, Count4, #Table + 1, Table )
    end

    return Table
end

local function VisibleSkull( Object )
    local RankSkull

    if Object then
        RankSkull = Object:FindFirstChild( "RankSkull" )
    else
        RankSkull = Object
    end

    local Crane

    if RankSkull then
        Crane = RankSkull:FindFirstChild( "Crane" )
    else
        Crane = RankSkull
    end

    local SurLaTete

    if Crane then
        SurLaTete = Crane:FindFirstChild( "SurLaTete" )
    else
        SurLaTete = Crane
    end
    if not Crane or not Crane:IsA( "BasePart" ) or not SurLaTete or not SurLaTete:IsA( "JointInstance" ) then
        return nil, nil
    end
    return Crane, SurLaTete
end

function Table.SizeOf( Name, Object )
    local Max
    local Size = Object.Size * ( Table3[ Name ] or Vector3.new( 1, 1, 1 ) ) * 1.1

    if Name == "Head" then
        local VisibleSkull2 = VisibleSkull( Object )

        if VisibleSkull2 then
            Max = Size:Max( VisibleSkull2.Size * Vector3.new( 1.2999999523162842, 1.100000023841858, 1.2999999523162842 ) * 1.1 )
        else
            Max = Size
        end
    else
        Max = Size
    end

    return Max
end
function Table.BoxCF( Name, Argument2, Object )
    if Name == "Head" then
        local _, Value1 = VisibleSkull( Object )

        if Value1 then
            return Argument2 * Value1.C0 * Value1.C1:Inverse( )
        end
    end

    local CFrame3
    local Entry = Table5[ Name ]

    if Entry then
        local CFrame2 = Argument2 * CFrame.new( 0, Entry * Object.Size.Y, 0 )

        if CFrame2 then
            CFrame3 = CFrame2
        else
            CFrame3 = Argument2
        end
    else
        CFrame3 = Argument2
    end

    return CFrame3
end
function Table.Compute( Self, Argument2, Argument3, Argument4, Argument5 )
    local Pose2
    local Value1, Value2, Value3 = RollAt( Argument3, Argument4 )

    if not Argument3.armed or not Table7[ Argument3.stance ] then
        Pose2 = nil
    else
        local Pose = Holds.Pose( Argument3.weapon, Argument3.stance )

        if Pose then
            Pose2 = Pose
        else
            Pose2 = nil
        end
    end

    local Value4, C03, C13
    local TableInner = { HumanoidRootPart = Argument2 }
    local Table2Inner = { }
    Value4 = nil
    C03 = nil
    C13 = nil

    for Key, Value in Table4, nil, nil do
        local FoundChild5
        local Item = Value[ 1 ]
        local Item2 = Value[ 2 ]
        local Item3 = Value[ 3 ]
        local FoundChild4 = Self:FindFirstChild( Item )

        if FoundChild4 then
            FoundChild5 = FoundChild4:FindFirstChild( Item2 )
        else
            FoundChild5 = FoundChild4
        end

        local Entry = TableInner[ Item3 ]

        if FoundChild5 and Entry then
            local C02, C12

            if FoundChild5:IsA( "Motor6D" ) then
                C02 = FoundChild5.C0
                C12 = FoundChild5.C1
            else
                C02 = FoundChild5.Attachment0.CFrame
                C12 = FoundChild5.Attachment1.CFrame
            end
            if Item2 == "Root" then
                C03 = C02
                C13 = C12
            end

            local Inverse

            if Item2 ~= "Waist" or not Pose2 then
                if Item2 ~= "Neck" or not Pose2 then
                    Inverse = CFrame.identity
                else
                    local Neck2
                    local Neck = Pose2.Neck
                    Neck2 = if Neck then Neck else CFrame.identity
                    Inverse = Neck2
                end
            else
                local Pitch2
                local Rad = math.rad( Pose2.Twist or 0 )

                if Argument3.stance == "Aim" or Argument3.stance == "ReloadAim" then
                    local Pitch = Argument3.pitch

                    if Pitch then
                        Pitch2 = Pitch
                    else
                        Pitch2 = 0
                    end
                else
                    Pitch2 = 0
                end

                local SwimVis2
                local Angles = CFrame.Angles( 0, -Rad, 0 ) * CFrame.Angles( Pitch2, 0, 0 ) * CFrame.Angles( 0, Rad, 0 )
                local Rotation = Argument2.Rotation
                local SwimVis = Argument3.swimVis
                SwimVis2 = if SwimVis then SwimVis else CFrame.identity
                local Waist2
                local Rotation2 = Rotation * SwimVis2 * Angles
                local Waist = Pose2.Waist
                Waist2 = if Waist then Waist else CFrame.identity
                local Rotation3 = Rotation2 * Waist2
                Inverse = ( Entry * C02 ).Rotation:Inverse( ) * Rotation3 * C12.Rotation
            end
            if Value1 > 0 then
                local Entry2

                if Item2 ~= "Root" or not Value2 then
                    if Value3 then
                        Entry2 = Value3[ Item2 ]
                    else
                        Entry2 = Value3
                    end
                else
                    Entry2 = Value2
                end
                if Entry2 then
                    Inverse = Inverse:Lerp( Entry2, Value1 )
                end
            elseif Argument5 then
                local Entry3 = Argument5.T[ Item2 ]

                if Entry3 then
                    Inverse = Inverse:Lerp( Entry3, Argument5.w )
                end
                if Argument5.baseRoot and Item2 == "Waist" and not Pose2 and C03 then
                    local Waist4
                    local C04 = Argument2 * C03 * Argument5.baseRoot * C13:Inverse( ) * C02
                    local Waist3 = Argument5.T.Waist
                    Waist4 = if Waist3 then Waist3 else CFrame.identity
                    local C05 = C04 * Waist4 * C12:Inverse( )
                    Inverse = ( Entry * C02 ).Rotation:Inverse( ) * C05.Rotation * C12.Rotation
                end
                if Argument5.keepUpper and Item2 == "Waist" and not Pose2 and C03 then
                    local C06 = Argument2 * C03 * C13:Inverse( ) * C02 * C12:Inverse( )
                    Inverse = ( Entry * C02 ).Rotation:Inverse( ) * C06.Rotation * C12.Rotation
                end
            end
            if Argument3.swimVis then
                if Item2 == "Root" then
                    local Root = SwimTilt.Root
                    Inverse = Root( Argument3.swimVis, C02 ) * Inverse
                elseif Item2 == "Neck" then
                    local Swim2
                    local Neck3 = SwimTilt.Neck
                    local Swim = Argument3.swim
                    Swim2 = if Swim then Swim else Argument3.swimVis
                    Inverse = Inverse * Neck3( Swim2 )
                end
            end

            local Entry4 = Entry * C02 * Inverse * C12:Inverse( )
            TableInner[ Item ] = Entry4

            if Table2[ Item ] then
                Table2Inner[ Item ] = {
                    cf = Table.BoxCF( Item, Entry4, FoundChild4 ),
                    size = Table.SizeOf( Item, FoundChild4 )
                }
            end
        end
    end

    local UpperTorso = TableInner.UpperTorso

    if UpperTorso then
        local Value5 = nil

        for Key2, Value6 in Table6, nil, nil do
            local FoundChild2
            local FoundChild = Self:FindFirstChild( Value6[ 2 ] )

            if FoundChild then
                FoundChild2 = Self[ Value6[ 2 ] ]:FindFirstChild( Value6[ 1 ] )
            else
                FoundChild2 = FoundChild
            end
            if FoundChild2 then
                local C0

                if FoundChild2:IsA( "Motor6D" ) then
                    C0 = FoundChild2.C0
                    local C1 = FoundChild2.C1
                else
                    C0 = FoundChild2.Attachment0.CFrame
                    local CFrame2 = FoundChild2.Attachment1.CFrame
                end

                local Number
                local UpperTorso2 = UpperTorso * C0
                local J = 2
                Number = 0.66

                for J = 2, 4 do
                    local FoundChild3 = Self:FindFirstChild( Value6[ J ] )

                    if not FoundChild3 then
                        break
                    end

                    local Number2 = Number + FoundChild3.Size.Y
                    Table2Inner[ Value6[ J ] ] = { cf = UpperTorso2, reach = Number2 }
                    Number = Number2
                end
            end
        end
    end

    return Table2Inner
end
function Table.DistanceToBox( Argument1, Argument2, Amount )
    local Number = Amount or 1

    if not Argument1.reach then
        local PointToObjectSpace = Argument1.cf:PointToObjectSpace( Argument2 )
        local Size = Argument1.size * Number / 2
        local X2 = PointToObjectSpace.X
        local Amount2 = -Size.X
        local Clamp = math.clamp( X2, Amount2, Size.X )
        local Y2 = PointToObjectSpace.Y
        local Amount3 = -Size.Y
        local Clamp2 = math.clamp( Y2, Amount3, Size.Y )
        local Z = PointToObjectSpace.Z
        local Amount4 = -Size.Z
        return ( PointToObjectSpace - Vector3.new( Clamp, Clamp2, ( math.clamp( Z, Amount4, Size.Z ) ) ) ).Magnitude
    end

    local Max2

    if typeof( Number ) == "Vector3" then
        local X = Number.X
        local Y = Number.Y
        local Max = math.max( X, Y, Number.Z )

        if Max then
            Max2 = Max
        else
            Max2 = Number
        end
    else
        Max2 = Number
    end

    return ( math.max( 0, ( Argument2 - Argument1.cf.Position ).Magnitude - Argument1.reach * Max2 ) )
end
function Table.Raycast( List, Argument2, Argument3 )
    local Value1, Value2, Value3, Max, Value4, PointToObjectSpace, VectorToObjectSpace, Size, Table, Value5, Value6, Number, Number2, Flag, Value8
    Value1 = List
    Value2 = nil
    Value3 = nil
    Max = nil
    Argument3 = Argument3
    Value4 = nil
    Argument2 = Argument2

    for Key, Value in Value1, Value2, nil do
        if not Value.reach then
            PointToObjectSpace = Value.cf:PointToObjectSpace( Argument2 )
            VectorToObjectSpace = Value.cf:VectorToObjectSpace( Argument3 )
            Size = Value.size / 2
            Table = { "X", "Y", "Z" }
            Value5 = nil
            Value6 = nil
            Number = 0
            Number2 = 1
            Flag = true
            Value8 = Key
            Value3 = Key

            for Key2, Value7 in Table, Value5, Value6 do
                local Entry = PointToObjectSpace[ Value7 ]
                local Entry2 = VectorToObjectSpace[ Value7 ]
                local Entry3 = Size[ Value7 ]

                if math.abs( Entry2 ) < 1e-08 then
                    if Entry3 < math.abs( Entry ) then
                        Flag = false
                        break
                    end
                    Value6 = Key2
                else
                    local Amount2, Entry5
                    local Amount = ( -Entry3 - Entry ) / Entry2
                    local Entry4 = ( Entry3 - Entry ) / Entry2

                    if Entry4 < Amount then
                        Amount2 = Entry4
                        Entry5 = Amount
                    else
                        Amount2 = Amount
                        Entry5 = Entry4
                    end

                    local Max4 = math.max( Number, Amount2 )
                    local Min = math.min( Number2, Entry5 )

                    if Min < Max4 then
                        Flag = false
                        Number = Max4
                        break
                    end
                    Value6 = Key2
                    Number = Max4
                    Number2 = Min
                end
            end
            if Flag then
                if not Max or Number < Max then
                    Max = Number
                    Value4 = Value8
                end
            end
        end
    end

    local Max3

    if Max then
        local Max2 = Max * Argument3.Magnitude

        if Max2 then
            Max3 = Max2
        else
            Max3 = nil
        end
    else
        Max3 = nil
    end

    return Max3, Value4
end
return Table
