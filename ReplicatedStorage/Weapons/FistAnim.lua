-- ReplicatedStorage.Weapons.FistAnim
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Players = game:GetService( "Players" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ArmIK = require( Weapons:WaitForChild( "ArmIK" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local CrouchAnim = require( Weapons:WaitForChild( "CrouchAnim" ) )
local AnimWorkers = require( Weapons:WaitForChild( "AnimWorkers" ) )
local MeleeData = require( Weapons:WaitForChild( "MeleeData" ) )
local Table2 = { Right = 0.36, Left = 0.3 }
local Table3 = {
    Right = { yaw = 0.6981317007977318, lean = 0.12217304763960307, drop = 0.06 },
    Left = { yaw = -0.20943951023931956, lean = 0.05235987755982989, drop = 0.02 }
}
local Table4 = { "Right", "Left" }
local LocalPlayer = Players.LocalPlayer
local Class = setmetatable( { }, { __mode = "k" } )
local Frames = ArmIK.Frames

local function ChildWorld( Argument1, Argument2 )
    local Value1, Value2 = Frames( Argument2 )
    return Argument1 * Value1 * AnimWorkers.getT( Argument2 ) * Value2:Inverse( )
end

local function SetJoint( Argument1, Argument2, Argument3 )
    local Value1, Value2 = Frames( Argument1 )
    local SetT = AnimWorkers.setT
    SetT( Argument1, ( Argument2 * Value1 ):Inverse( ) * Argument3 * Value2 )
end

local function MapBasis( Argument1, Argument2, Argument3, Argument4 )
    local Unit = ( Argument2 - Argument1 * Argument2:Dot( Argument1 ) ).Unit
    local Unit2 = ( Argument4 - Argument3 * Argument4:Dot( Argument3 ) ).Unit
    local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit, Argument1, Unit:Cross( Argument1 ) )
    return CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit2, Argument3, Unit2:Cross( Argument3 ) ) * FromMatrix:Inverse( )
end

local function Solve2( Argument1, Argument2, Argument3, Argument4, Argument5, Argument6 )
    local Position7
    local Value1, Value2 = Frames( Argument2 )
    local Value3, Value4 = Frames( Argument3 )
    local Value5, Value6 = Frames( Argument4 )
    local Position = Value3.Position - Value2.Position
    local Position2 = Value5.Position - Value4.Position
    local Magnitude = Position.Magnitude
    local Magnitude2 = Position2.Magnitude
    local Position3 = ( Argument1 * Value1 ).Position
    local Position4 = ( Argument5 * Value6 ).Position - Position3
    local Magnitude3 = Position4.Magnitude
    local Clamp = math.clamp( Magnitude3, 0.05, Magnitude + Magnitude2 - 0.01 )
    local Unit = Position4.Unit
    local Clamp2 = math.clamp( ( Magnitude * Magnitude + Clamp * Clamp - Magnitude2 * Magnitude2 ) / ( 2 * Magnitude * Clamp ), -1, 1 )
    local Sqrt = math.sqrt( 1 - Clamp2 * Clamp2 )
    local Position5 = Argument6 - Position3
    local Position6 = Position5 - Unit * Position5:Dot( Unit )
    Position7 = if Position6.Magnitude < 0.001 then Argument1.LookVector else Position6
    local Cross2
    local Unit2 = Position7.Unit
    local Position8 = Position3 + Unit * ( Magnitude * Clamp2 ) + Unit2 * ( Magnitude * Sqrt )
    local Position9 = Position3 + Unit * Clamp
    local Cross = ( Position8 - Position3 ):Cross( Position9 - Position8 )
    Cross2 = if Cross.Magnitude < 0.0001 then Argument1.RightVector else Cross
    local Unit3 = Position.Unit
    local MapBasis2 = MapBasis( Unit3, Vector3.new( 1, 0, 0 ), ( Position8 - Position3 ).Unit, Cross2 )
    local CFrame2 = CFrame.new( Position3 - MapBasis2 * Value2.Position ) * MapBasis2
    local Unit4 = Position2.Unit
    local MapBasis3 = MapBasis( Unit4, Vector3.new( 1, 0, 0 ), ( Position9 - Position8 ).Unit, Cross2 )
    local CFrame3 = CFrame.new( Position8 - MapBasis3 * Value4.Position ) * MapBasis3
    local Value9, Value10 = Frames( Argument2 )
    local SetT = AnimWorkers.setT
    SetT( Argument2, ( Argument1 * Value9 ):Inverse( ) * CFrame2 * Value10 )
    local Value11, Value12 = Frames( Argument3 )
    local SetT2 = AnimWorkers.setT
    SetT2( Argument3, ( CFrame2 * Value11 ):Inverse( ) * CFrame3 * Value12 )
    local CFrame4 = CFrame.new( Position9 - Argument5.Rotation * Value6.Position ) * Argument5.Rotation
    local Value13, Value14 = Frames( Argument4 )
    local SetT3 = AnimWorkers.setT
    SetT3( Argument4, ( CFrame3 * Value13 ):Inverse( ) * CFrame4 * Value14 )
end

local function Same( Argument1, Argument2 )
    local Flag

    if ( Argument1.Position - Argument2.Position ).Magnitude < 0.0001 then
        if ( Argument1.LookVector - Argument2.LookVector ).Magnitude < 0.0001 then
            if ( Argument1.UpVector - Argument2.UpVector ).Magnitude < 0.0001 then
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
end

local function RestoreBase( Argument1, List )
    local Value1 = nil

    for Key, Value in List, nil, nil do
        local GetT2
        local Entry = Argument1.out[ Value ]
        local Entry2 = Argument1.base[ Value ]
        local GetT = AnimWorkers.getT( Value )

        if not Entry or not Entry2 then
            GetT2 = GetT
        else
            local Flag

            if ( GetT.Position - Entry.Position ).Magnitude < 0.0001 then
                if ( GetT.LookVector - Entry.LookVector ).Magnitude < 0.0001 then
                    if ( GetT.UpVector - Entry.UpVector ).Magnitude < 0.0001 then
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
            if Flag then
                GetT2 = Entry2
            else
                GetT2 = GetT
            end
        end

        AnimWorkers.setT( Value, GetT2 )
        Argument1.base[ Value ] = GetT2
    end
end

local function Release( Argument1 )
    if not Argument1.out then
        return
    end

    local Value1
    local Out = Argument1.out
    Value1 = nil

    for Key, Value in Out, nil, nil do
        local Entry = Argument1.base[ Key ]

        if Entry and Key.Parent then
            local Flag
            local GetT = AnimWorkers.getT( Key )

            if ( GetT.Position - Value.Position ).Magnitude < 0.0001 then
                if ( GetT.LookVector - Value.LookVector ).Magnitude < 0.0001 then
                    if ( GetT.UpVector - Value.UpVector ).Magnitude < 0.0001 then
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
            if Flag then
                AnimWorkers.setT( Key, Entry )
            end
        end
    end

    Argument1.out = nil
    Argument1.base = nil
end

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function Geometry( Object )
    local Root
    local Table = { joints = { } }

    local function J( Name, Name2 )
        local FoundChild2
        local FoundChild = Object:FindFirstChild( Name )

        if FoundChild then
            FoundChild2 = FoundChild:FindFirstChild( Name2 )
        else
            FoundChild2 = FoundChild
        end
        if FoundChild2 then
            table.insert( Table.joints, FoundChild2 )
        end

        return FoundChild2
    end

    local LowerTorso = Object:FindFirstChild( "LowerTorso" )

    if LowerTorso then
        Root = LowerTorso:FindFirstChild( "Root" )
    else
        Root = LowerTorso
    end
    if Root then
        table.insert( Table.joints, Root )
    end

    local Waist
    local UpperTorso = Object:FindFirstChild( "UpperTorso" )

    if UpperTorso then
        Waist = UpperTorso:FindFirstChild( "Waist" )
    else
        Waist = UpperTorso
    end
    if Waist then
        table.insert( Table.joints, Waist )
    end

    local Neck
    local Head = Object:FindFirstChild( "Head" )

    if Head then
        Neck = Head:FindFirstChild( "Neck" )
    else
        Neck = Head
    end
    if Neck then
        table.insert( Table.joints, Neck )
    end

    Table.root = Root
    Table.waist = Waist
    Table.neck = Neck

    if not Table.root or not Table.waist or not Table.neck then
        return nil
    end

    local Value1
    local Leg = { }
    Table.arm = { }
    Table.leg = Leg
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        local FoundChild2
        local Text = Value .. "UpperArm"
        local Text2 = Value .. "Shoulder"
        local FoundChild = Object:FindFirstChild( Text )

        if FoundChild then
            FoundChild2 = FoundChild:FindFirstChild( Text2 )
        else
            FoundChild2 = FoundChild
        end
        if FoundChild2 then
            table.insert( Table.joints, FoundChild2 )
        end

        local FoundChild4
        local Text3 = Value .. "LowerArm"
        local Text4 = Value .. "Elbow"
        local FoundChild3 = Object:FindFirstChild( Text3 )

        if FoundChild3 then
            FoundChild4 = FoundChild3:FindFirstChild( Text4 )
        else
            FoundChild4 = FoundChild3
        end
        if FoundChild4 then
            table.insert( Table.joints, FoundChild4 )
        end

        local FoundChild6
        local Text5 = Value .. "Hand"
        local Text6 = Value .. "Wrist"
        local FoundChild5 = Object:FindFirstChild( Text5 )

        if FoundChild5 then
            FoundChild6 = FoundChild5:FindFirstChild( Text6 )
        else
            FoundChild6 = FoundChild5
        end
        if FoundChild6 then
            table.insert( Table.joints, FoundChild6 )
        end

        local FoundChild8
        local Text7 = Value .. "UpperLeg"
        local Text8 = Value .. "Hip"
        local FoundChild7 = Object:FindFirstChild( Text7 )

        if FoundChild7 then
            FoundChild8 = FoundChild7:FindFirstChild( Text8 )
        else
            FoundChild8 = FoundChild7
        end
        if FoundChild8 then
            table.insert( Table.joints, FoundChild8 )
        end

        local FoundChild10
        local Text9 = Value .. "LowerLeg"
        local Text10 = Value .. "Knee"
        local FoundChild9 = Object:FindFirstChild( Text9 )

        if FoundChild9 then
            FoundChild10 = FoundChild9:FindFirstChild( Text10 )
        else
            FoundChild10 = FoundChild9
        end
        if FoundChild10 then
            table.insert( Table.joints, FoundChild10 )
        end

        local FoundChild12
        local Text11 = Value .. "Foot"
        local Text12 = Value .. "Ankle"
        local FoundChild11 = Object:FindFirstChild( Text11 )

        if FoundChild11 then
            FoundChild12 = FoundChild11:FindFirstChild( Text12 )
        else
            FoundChild12 = FoundChild11
        end
        if FoundChild12 then
            table.insert( Table.joints, FoundChild12 )
        end
        if not FoundChild2 or not FoundChild4 or not FoundChild6 or not FoundChild8 or not FoundChild10 or not FoundChild12 then
            return nil
        end

        local Value2, Value3 = Frames( FoundChild2 )
        local Value4, Value5 = Frames( FoundChild4 )
        local Value6, Value7 = Frames( FoundChild6 )
        local Arm = Table.arm
        Arm[ Value ] = {
            S = Value2.Position,
            len = ( Value4.Position - Value3.Position ).Magnitude + ( Value6.Position - Value5.Position ).Magnitude,
            rest = ( Value2 * Value3:Inverse( ) * Value4 * Value5:Inverse( ) * Value6 * Value7:Inverse( ) ).Rotation,
            w1 = Value7.Position
        }
        local _, Value8 = Frames( FoundChild8 )
        local Value9, Value10 = Frames( FoundChild10 )
        local Frames2 = Frames( FoundChild12 )
        local Leg2 = Table.leg
        Leg2[ Value ] = {
            hip = FoundChild8,
            knee = FoundChild10,
            ankle = FoundChild12,
            len = ( Value9.Position - Value8.Position ).Magnitude + ( Frames2.Position - Value10.Position ).Magnitude
        }
    end

    Table.k = ( Table.arm.Right.len + Table.arm.Left.len ) / 2 / 2.1
    return Table
end

local Table = {
    PUNCH_TIME = Table2,
    Tune = {
        Pitch = 152,
        Roll = 5,
        Twist = -27,
        Height = 0.21,
        Spread = 0.78,
        Forward = 0.84,
        Lead = 0.19
    }
}

local function GuardRot( RotName )
    local Number
    local Tune = Table.Tune
    Number = RotName ~= "Right" and -1 or 1
    return CFrame.Angles( math.rad( Tune.Pitch ), math.rad( Tune.Roll * Number ), ( math.rad( Tune.Twist * Number ) ) )
end

local Table5 = {
    Right = CFrame.Angles( 0, 0, 1.5707963267948966 ) * CFrame.Angles( 1.5707963267948966, 0, 0 ),
    Left = CFrame.Angles( 0, 0, -1.5707963267948966 ) * CFrame.Angles( 1.5707963267948966, 0, 0 )
}

local function PunchCurves( Argument1, Argument2 )
    local Result = Argument1 / Argument2

    if Result <= 0 or Result >= 1 then
        return 0, 0
    end

    local Clamp2

    if Result < 0.08 then
        local Clamp = math.clamp( Result / 0.08, 0, 1 )
        Clamp2 = -0.08 * ( Clamp * Clamp * ( 3 - 2 * Clamp ) )
    elseif Result < 0.32 then
        Clamp2 = -0.08 + 1.08 * ( 1 - ( 1 - ( Result - 0.08 ) / 0.24 ) ^ 3 )
    elseif Result < 0.44 then
        Clamp2 = 1
    else
        local Clamp3 = math.clamp( ( Result - 0.44 ) / 0.56, 0, 1 )
        Clamp2 = 1 - Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 )
    end
    if Result < 0.26 then
        local Clamp4 = math.clamp( Result / 0.26, 0, 1 )
        return Clamp2, Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 )
    end
    if Result < 0.5 then
        return Clamp2, 1
    end
    local Clamp5 = math.clamp( ( Result - 0.5 ) / 0.5, 0, 1 )
    return Clamp2, 1 - Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 )
end

local function StateOf( Character )
    local Entry2
    local Entry = Class[ Character ]

    if Entry then
        Entry2 = Entry
    else
        local Table = {
            w = 0,
            legsW = 0,
            punch = { },
            lastN = Character:GetAttribute( "PunchN" ),
            lastPunch = -math.huge,
            phase = math.random( ) * 10
        }
        Class[ Character ] = Table
        Entry2 = Table
    end

    return Entry2
end

function Table.Punch( Key )
    local Character = LocalPlayer.Character

    if Character then
        local StateOf2 = StateOf( Character )
        local Punch = StateOf2.punch
        Punch[ Key ] = os.clock( )
        StateOf2.lastPunch = os.clock( )
        return
    end
    return
end

local function CanShow( Character, Humanoid )
    if not Humanoid or Humanoid.Health <= 0 or Humanoid.SeatPart then
        return false
    end

    local Tool = Character:FindFirstChildOfClass( "Tool" )

    if Tool then
        local Entry = MeleeData[ Tool:GetAttribute( "Melee" ) or "" ]

        if not Entry or not Entry.Fists then
            return false
        end
    end
    if Character:GetAttribute( "Downed" ) or Character:GetAttribute( "CarriedBy" ) or Character:GetAttribute( "Carrying" ) or Character:GetAttribute( "DanceStart" ) or Character:GetAttribute( "CarRagdoll" ) then
        return false
    end
    if Character ~= LocalPlayer.Character or not ClientState.Rolling then
        return true
    end
    return false
end

local function PoseChar( Argument1, Argument2, Argument3, Part, Humanoid, Amount, LastPunch, Amount2 )
    local Out2
    local K = Argument3.k
    local Out = Argument2.out
    Out2 = if Out then Out else { }
    local Base2
    local Base = Argument2.base
    Base2 = if Base then Base else { }
    local Still2
    Argument2.out = Out2
    Argument2.base = Base2
    RestoreBase( Argument2, Argument3.joints )
    local Still = Argument2.still

    if Still == nil then
        local Flag
        local AssemblyLinearVelocity = Part.AssemblyLinearVelocity
        local X = AssemblyLinearVelocity.X
        local Magnitude = Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude

        if Humanoid.FloorMaterial == Enum.Material.Air then
            Flag = false
        elseif Magnitude < 3 then
            Flag = not CrouchAnim.IsCrouched( Argument1 )
        else
            Flag = false
        end

        Still2 = Flag
    else
        Still2 = Still
    end

    local Number
    local LegsW = Argument2.legsW
    Number = not Still2 and 0 or 1
    local Value1, Number10
    Argument2.legsW = LegsW + ( Number - Argument2.legsW ) * ( 1 - math.exp( -10 * Amount2 ) )
    local LegsW2 = Argument2.legsW * Amount
    local LegsW3 = Argument2.legsW
    local LegsW4 = -0.4188790204786391 * ( 0.5 + 0.5 * LegsW3 )
    local LegsW5 = 0.12217304763960307 * LegsW3
    local TableInner = { }
    Value1 = nil
    Number10 = 0

    for Key, Value in Table4, nil, nil do
        local Number8, Number9
        local Entry4 = Argument2.punch[ Value ]

        if Entry4 then
            Number8, Number9 = PunchCurves( LastPunch - Entry4, Table.PUNCH_TIME[ Value ] )
        else
            Number8 = 0
            Number9 = 0
        end

        TableInner[ Value ] = Number8
        local Entry5 = Table3[ Value ]
        LegsW4 = LegsW4 + Entry5.yaw * Number9 * ( 0.6 + 0.4 * LegsW3 )
        LegsW5 = LegsW5 + Entry5.lean * Number9 * ( 0.25 + 0.75 * LegsW3 )
        Number10 = Number10 + Entry5.drop * Number9
    end

    Argument2.phase = Argument2.phase + Amount2 * 1.7 * 3.141592653589793 * 2
    local Sin = ( math.sin( Argument2.phase ) * 0.5 + 0.5 ) * 0.045
    local Sin2 = math.sin( Argument2.phase * 0.5 ) * 0.04363323129985824
    local Root = Argument3.root
    local CFrame2 = Part.CFrame
    local Value2, Value3 = Frames( Root )
    local CFrame3 = CFrame2 * Value2 * AnimWorkers.getT( Root ) * Value3:Inverse( )
    local Table2 = { }
    local Base3 = Argument2.base
    local LegsW6 = LegsW4 + Sin2 - 0
    AnimWorkers.setT( Argument3.waist, CFrame.Angles( -LegsW5, LegsW6, 0 ) * AnimWorkers.getT( Argument3.waist ) )
    local SetT = AnimWorkers.setT
    local Neck = Argument3.neck
    local LegsW7 = -0.15707963267948966 + LegsW5 * 0.5
    SetT( Neck, CFrame.Angles( LegsW7, -( 0 + LegsW6 ) * 0.85, 0 ) * AnimWorkers.getT( Argument3.neck ) )
    local CFrame4 = Part.CFrame
    local Value4, Value5 = Frames( Root )
    local CFrame5 = CFrame4 * Value4 * AnimWorkers.getT( Root ) * Value5:Inverse( )
    local UpperTorsoWorld = ArmIK.UpperTorsoWorld( Argument1 )

    if UpperTorsoWorld then
        local Value6
        local CFrame6 = Part.CFrame
        Value6 = nil

        for Key2, Value7 in Table4, nil, nil do
            local Number3
            local Entry = Argument3.arm[ Value7 ]
            Number3 = Value7 ~= "Right" and -1 or 1
            local Number2 = Value7 ~= "Left" and 0 or 1
            local Number5
            local UpperTorsoWorld2 = UpperTorsoWorld * Entry.S
            local Tune = Table.Tune
            local Number4 = Number3 * ( Tune.Spread - 0.06 * Number2 ) * K
            local Y = Entry.S.Y + ( Tune.Height - 0.05 * Number2 ) * K
            local UpperTorsoWorld3 = UpperTorsoWorld * Vector3.new( Number4, Y, -( Tune.Forward + Tune.Lead * Number2 ) * K )
            local Rotation = UpperTorsoWorld.Rotation
            local Tune2 = Table.Tune
            Number5 = Value7 ~= "Right" and -1 or 1
            local Lerp, Lerp2
            local Rotation2 = Rotation * CFrame.Angles( math.rad( Tune2.Pitch ), math.rad( Tune2.Roll * Number5 ), ( math.rad( Tune2.Twist * Number5 ) ) ) * Entry.rest
            local Number6 = Number3 * 1.6 * K
            local Y2 = Entry.S.Y - 1.8 * K
            local UpperTorsoWorld4 = UpperTorsoWorld * Vector3.new( Number6, Y2, -0.1 * K )
            local CFrame7 = CFrame6 * Vector3.new( 0, 0, -12 * K )
            local X2 = CFrame7.X
            local Y3 = UpperTorsoWorld2.Y + 0.15 * K
            local UpperTorsoWorld5 = UpperTorsoWorld2 + ( Vector3.new( X2, Y3, CFrame7.Z ) - UpperTorsoWorld2 ).Unit * Entry.len * 0.97
            local Rotation3 = CFrame6.Rotation * Table5[ Value7 ] * Entry.rest
            local Rotation4 = CFrame6.Rotation
            local Number7 = Number3 * 1.4 * K
            local K2 = -1 * K
            local UpperTorsoWorld6 = UpperTorsoWorld2 + Rotation4 * Vector3.new( Number7, K2, 0.8 * K )
            local Entry2 = TableInner[ Value7 ]

            if Entry2 >= 0 then
                Lerp = UpperTorsoWorld3:Lerp( UpperTorsoWorld5, Entry2 )
                Lerp2 = Rotation2:Lerp( Rotation3, Entry2 )
            else
                Lerp = UpperTorsoWorld3:Lerp( UpperTorsoWorld2, -Entry2 * 1.5 )
                Lerp2 = Rotation2
            end

            local Lerp3 = UpperTorsoWorld4:Lerp( UpperTorsoWorld6, ( math.max( Entry2, 0 ) ) )
            local CFrame8 = CFrame.new( Lerp - Lerp2 * Entry.w1 ) * Lerp2
            ArmIK.Solve( Argument1, Value7, UpperTorsoWorld, CFrame8, Lerp3 )
        end
    end
    if Amount < 0.999 then
        local Value8
        local Joints = Argument3.joints
        Value8 = nil

        for Key3, Value9 in Joints, nil, nil do
            local SetT2 = AnimWorkers.setT
            local Entry3 = Base3[ Value9 ]
            SetT2( Value9, Entry3:Lerp( AnimWorkers.getT( Value9 ), Amount ) )
        end
    end

    local Value10
    local Joints2 = Argument3.joints
    Value10 = nil

    for Key4, Value11 in Joints2, nil, nil do
        local Out3 = Argument2.out
        Out3[ Value11 ] = AnimWorkers.getT( Value11 )
    end
end

function Table.Update( Amount2 )
    local LastPunch = os.clock( )

    for Key, Value in Players:GetPlayers( ) do
        local Character = Value.Character

        if Character and Character.Parent and AnimWorkers.Owns( Character ) then
            local Flag = Value == LocalPlayer and true or false
            local StateOf2 = StateOf( Character )

            if not Flag and Character:GetAttribute( "PunchN" ) ~= StateOf2.lastN then
                if type( Character:GetAttribute( "PunchN" ) ) == "number" and StateOf2.lastN ~= nil then
                    local Text
                    local Punch = StateOf2.punch
                    Text = Character:GetAttribute( "PunchN" ) % 2 ~= 1 and "Left" or "Right"
                    Punch[ Text ] = LastPunch
                    StateOf2.lastPunch = LastPunch
                end

                StateOf2.lastN = Character:GetAttribute( "PunchN" )
            end

            local Flag2
            local Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            local HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )

            if HumanoidRootPart == nil then
                Flag2 = false
            else
                Flag2 = CanShow( Character, Humanoid )
            end

            local Flag3

            if Flag2 then
                if not Flag or ClientState.FistGuard ~= true then
                    if Flag or Character:GetAttribute( "FistGuard" ) ~= true then
                        if LastPunch - StateOf2.lastPunch < 0.6 then
                            Flag3 = true
                        else
                            Flag3 = false
                        end
                    else
                        Flag3 = true
                    end
                else
                    Flag3 = true
                end
            else
                Flag3 = Flag2
            end

            local Number = not Flag3 and 0 or 1

            if StateOf2.w < Number then
                StateOf2.w = math.min( Number, StateOf2.w + Amount2 / 0.16 )
            elseif Number < StateOf2.w then
                StateOf2.w = math.max( Number, StateOf2.w - Amount2 / 0.22 )
            end
            if not Flag2 then
                StateOf2.w = 0
                StateOf2.legsW = 0
            end
            if StateOf2.w <= 0.001 then
                Release( StateOf2 )
            else
                local Geo2
                local Geo = StateOf2.geo
                Geo2 = if Geo then Geo else Geometry( Character )
                StateOf2.geo = Geo2

                if not StateOf2.geo or not StateOf2.geo.root.Parent then
                    StateOf2.geo = nil
                else
                    local Geo3 = StateOf2.geo
                    local Clamp = math.clamp( StateOf2.w, 0, 1 )
                    PoseChar( Character, StateOf2, Geo3, HumanoidRootPart, Humanoid, Clamp * Clamp * ( 3 - 2 * Clamp ), LastPunch, Amount2 )
                end
            end
        end
    end

    local Value1 = nil

    for Value2 in Class, nil, nil do
        if not Value2.Parent then
            Class[ Value2 ] = nil
        end
    end
end
function Table.RigState()
    return {
        w = 0,
        legsW = 0,
        punch = { },
        lastPunch = -math.huge,
        phase = math.random( ) * 10
    }
end
function Table.RigPunch( Argument1, PunchName, LastPunch )
    Argument1.punch[ PunchName ] = LastPunch
    Argument1.lastPunch = LastPunch
end
function Table.PoseRig( Object2, Argument2, Argument3, Argument4, Argument5, Amount2 )
    local Flag
    local HumanoidRootPart = Object2:FindFirstChild( "HumanoidRootPart" )
    local Humanoid = Object2:FindFirstChildOfClass( "Humanoid" )

    if HumanoidRootPart == nil then
        Flag = false
    elseif Humanoid == nil then
        Flag = false
    elseif Argument3 then
        Flag = Argument3
    elseif Argument5 - Argument2.lastPunch < 0.6 then
        Flag = true
    else
        Flag = false
    end

    local Number = not Flag and 0 or 1

    if Argument2.w < Number then
        Argument2.w = math.min( Number, Argument2.w + Amount2 / 0.16 )
    elseif Number < Argument2.w then
        Argument2.w = math.max( Number, Argument2.w - Amount2 / 0.22 )
    end
    if Argument2.w <= 0.001 then
        Release( Argument2 )
        return false
    end

    local Geo2
    local Geo = Argument2.geo
    Geo2 = if Geo then Geo else Geometry( Object2 )
    Argument2.geo = Geo2

    if not Argument2.geo or not Argument2.geo.root.Parent then
        Argument2.geo = nil
        return false
    end

    local Still = Argument4 == true and true or false
    Argument2.still = Still
    local Geo3 = Argument2.geo
    local Clamp = math.clamp( Argument2.w, 0, 1 )
    PoseChar( Object2, Argument2, Geo3, HumanoidRootPart, Humanoid, Clamp * Clamp * ( 3 - 2 * Clamp ), Argument5, Amount2 )
    return true
end
return Table
