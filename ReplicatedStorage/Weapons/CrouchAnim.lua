-- ReplicatedStorage.Weapons.CrouchAnim
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local Parent = script.Parent
local Clips = require( Parent:WaitForChild( "Clips" ) )
local ClientState = require( Parent:WaitForChild( "ClientState" ) )
local ArmIK = require( Parent:WaitForChild( "ArmIK" ) )
local Config = require( Parent:WaitForChild( "Config" ) )
local Holds = require( Parent:WaitForChild( "Holds" ) )
local OnScreen = require( Parent:WaitForChild( "OnScreen" ) )
local FrameCache = require( Parent:WaitForChild( "FrameCache" ) )
local AnimWorkers = require( Parent:WaitForChild( "AnimWorkers" ) )
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Table2 = {
    Root = "LowerTorso",
    Waist = "UpperTorso",
    Neck = "Head",
    RightShoulder = "RightUpperArm",
    RightElbow = "RightLowerArm",
    RightWrist = "RightHand",
    LeftShoulder = "LeftUpperArm",
    LeftElbow = "LeftLowerArm",
    LeftWrist = "LeftHand",
    RightHip = "RightUpperLeg",
    RightKnee = "RightLowerLeg",
    RightAnkle = "RightFoot",
    LeftHip = "LeftUpperLeg",
    LeftKnee = "LeftLowerLeg",
    LeftAnkle = "LeftFoot"
}
local Table3 = {
    "RightHip",
    "RightKnee",
    "RightAnkle",
    "LeftHip",
    "LeftKnee",
    "LeftAnkle"
}
local Table4 = { "Waist", "Neck" }
local Table5 = {
    "RightShoulder",
    "RightElbow",
    "RightWrist",
    "LeftShoulder",
    "LeftElbow",
    "LeftWrist"
}

local function R( Argument1, Argument2, Argument3 )
    return CFrame.Angles( math.rad( Argument1 ), math.rad( Argument2 ), ( math.rad( Argument3 ) ) )
end

local Table6 = {
    RightShoulder = CFrame.Angles( 0.5585053606381855, 0, -0.13962634015954636 ),
    LeftShoulder = CFrame.Angles( 0.5585053606381855, 0, 0.13962634015954636 ),
    RightElbow = CFrame.Angles( 0.6632251157578453, 0, 0 ),
    LeftElbow = CFrame.Angles( 0.6632251157578453, 0, 0 ),
    RightWrist = CFrame.Angles( 0.17453292519943295, 0, 0 ),
    LeftWrist = CFrame.Angles( 0.17453292519943295, 0, 0 )
}

local function StanceOf( Object )
    if Object == LocalPlayer.Character then
        return ClientState.Stance
    end
    return Config.StanceNames[ Object:GetAttribute( "GunStance" ) or 0 ]
end

local Table7 = { }

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function JointOf( Object, Name )
    local FoundChild2
    local FoundChild = Object:FindFirstChild( Table2[ Name ] or "" )
    FoundChild2 = if FoundChild then FoundChild:FindFirstChild( Name ) else FoundChild
    return FoundChild2
end

local function ClipPose( Argument1, Argument2, Argument3 )
    local CFrame3
    local Sample, Sample2, Sample3 = Clips.Sample( Argument1, Argument2 )
    local FaceForward, J = Clips.FaceForward( Sample2, Sample3 )
    local Y = Sample.Y - Clips.STAND_Y
    local Table = { }

    if Argument3 then
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

    Table.root = CFrame3 * FaceForward
    Table.j = J
    return Table
end

local function Mix( Argument1, Argument2, Amount )
    if Amount <= 0 then
        return Argument1
    end
    if Amount >= 1 then
        return Argument2
    end

    local Value1
    local Table = { }
    local J = Argument1.j
    Value1 = nil

    for Key, Value in J, nil, nil do
        Table[ Key ] = Value:Lerp( Argument2.j[ Key ] or Value, Amount )
    end

    local Table3

    if Argument1.arms or Argument2.arms then
        local Arms3
        local Table2 = { }
        local Arms = Argument1.arms
        Arms3 = if Arms then Arms else Argument1.j
        local Arms4
        local Arms2 = Argument2.arms
        Arms4 = if Arms2 then Arms2 else Argument2.j
        local Value2 = nil

        for Key2, Value3 in Table5, nil, nil do
            if Arms3[ Value3 ] and Arms4[ Value3 ] then
                local Entry = Arms3[ Value3 ]
                Table2[ Value3 ] = Entry:Lerp( Arms4[ Value3 ], Amount )
            end

            Table3 = Table2
        end

        Table3 = Table2
    else
        Table3 = nil
    end

    local Lerp

    if Argument1.baseRoot or Argument2.baseRoot then
        local BaseRoot3
        local BaseRoot = Argument1.baseRoot
        BaseRoot3 = if BaseRoot then BaseRoot else Argument1.root
        local BaseRoot4
        local BaseRoot2 = Argument2.baseRoot
        BaseRoot4 = if BaseRoot2 then BaseRoot2 else Argument2.root
        Lerp = BaseRoot3:Lerp( BaseRoot4, Amount )
    else
        Lerp = nil
    end

    local Root = Argument1.root
    return {
        root = Root:Lerp( Argument2.root, Amount ),
        j = Table,
        arms = Table3,
        baseRoot = Lerp
    }
end

local function Turned( Argument1, Argument2 )
    if math.abs( Argument2 ) < 0.01 then
        return Argument1
    end

    local BaseRoot2
    local Table = {
        root = CFrame.Angles( 0, math.rad( Argument2 ), 0 ) * Argument1.root,
        j = Argument1.j
    }
    local BaseRoot = Argument1.baseRoot
    BaseRoot2 = if BaseRoot then BaseRoot else Argument1.root
    Table.baseRoot = BaseRoot2
    return Table
end

local Table = {
    IsCrouched = function( Object )
        if Object:GetAttribute( "RankedPose" ) then
            return false
        end
        if Object == LocalPlayer.Character then
            local Flag = ClientState.Crouching == true and true or false
            return Flag
        end
        local Flag2 = Object:GetAttribute( "Crouch" ) == true and true or false
        return Flag2
    end,
    Turned = Turned
}

local function LoopPose( Argument1, Part, Amount )
    local Number
    local AssemblyLinearVelocity = Part.AssemblyLinearVelocity
    local X = AssemblyLinearVelocity.X
    local Vector32 = Vector3.new( X, 0, AssemblyLinearVelocity.Z )
    local Magnitude = Vector32.Magnitude
    local MoveW = Argument1.moveW
    Number = not ( Magnitude > 1 ) and 0 or 1
    local MoveDir2
    Argument1.moveW = MoveW + ( Number - Argument1.moveW ) * ( 1 - math.exp( -7 * Amount ) )
    local CrouchIdle = Clips.CrouchIdle
    local ClipPose2 = ClipPose( CrouchIdle, os.clock( ) % CrouchIdle.length )
    local MoveDir = Argument1.moveDir
    MoveDir2 = if MoveDir then MoveDir else Vector2.new( 0, 1 )
    Argument1.moveDir = MoveDir2

    if Magnitude > 0.5 then
        local MoveDir4
        local VectorToObjectSpace = Part.CFrame:VectorToObjectSpace( Vector32 ) / Magnitude
        local Vector22 = Vector2.new( VectorToObjectSpace.X, -VectorToObjectSpace.Z )
        local MoveDir3 = Argument1.moveDir
        local Lerp = MoveDir3:Lerp( Vector22, 1 - math.exp( -9 * Amount ) )
        MoveDir4 = Lerp.Magnitude > 0.001 and Lerp.Unit or Vector22
        Argument1.moveDir = MoveDir4
    end
    if Argument1.moveW < 0.01 then
        return ClipPose2
    end

    local X2 = Argument1.moveDir.X
    local Deg = math.deg( ( math.atan2( X2, Argument1.moveDir.Y ) ) )

    if math.abs( Deg ) > 100 then
        Argument1.back = true
    elseif math.abs( Deg ) < 80 then
        Argument1.back = false
    end

    local Turned2
    Argument1.phase = ( Argument1.phase + Magnitude * Amount / 4.65 ) % 1
    local CrouchWalk = Clips.CrouchWalk

    if Argument1.back then
        local Deg2 = Deg > 0 and Deg - 180 or Deg + 180
        Turned2 = Turned( ClipPose( CrouchWalk, ( 1 - Argument1.phase ) * CrouchWalk.length ), -math.clamp( Deg2, -90, 90 ) )
    else
        Turned3 = Turned( ClipPose( CrouchWalk, Argument1.phase * CrouchWalk.length ), -math.clamp( Deg, -90, 90 ) )
    end

    return ( Mix( ClipPose2, Value2, Argument1.moveW ) )
end

local function Apply( Character, HumanoidRootPart, p3, p4, p5 )
    -- Could not structure function #9
end

function Table.Update( Amount2 )
    local Position = CurrentCamera.CFrame.Position
    local CrouchStand = Clips.CrouchStand

    for Key, Value in Players:GetPlayers( ) do
        local Character = Value.Character

        if not Character or AnimWorkers.Owns( Character ) then
            local HumanoidRootPart

            if Character then
                HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
            else
                HumanoidRootPart = Character
            end

            local Humanoid

            if Character then
                Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 or ( HumanoidRootPart.Position - Position ).Magnitude > math.huge then
                if Character then
                    Table7[ Character ] = nil
                end
            else
                local Entry2
                local IsCrouched = Table.IsCrouched( Character )
                local Entry = Table7[ Character ]

                if Entry then
                    Entry2 = Entry
                else
                    local C
                    local TableInner = { phase = 0, moveW = 0, fast = 0 }
                    C = not IsCrouched and 0 or 1
                    TableInner.c = C
                    Table7[ Character ] = TableInner
                    Entry2 = TableInner
                end

                local Flag
                local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
                local X = AssemblyLinearVelocity.X

                if Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude > 1 then
                    Flag = true
                elseif FrameCache.Floor( Humanoid ) == Enum.Material.Air then
                    Flag = true
                elseif Character == LocalPlayer.Character then
                    Flag = ClientState.Rolling
                else
                    Flag = false
                end

                local Number
                local Fast = Entry2.fast
                Number = not Flag and 0 or 1
                local Number4
                Entry2.fast = Fast + ( Number - Entry2.fast ) * ( 1 - math.exp( -12 * Amount2 ) )
                Number4 = not IsCrouched and 0 or 1
                local Number2
                local Length = CrouchStand.length
                Number2 = not IsCrouched and 1.6 or 1.5
                local Number3
                local Length2 = Length / Number2
                Number3 = not IsCrouched and 0.16 or 0.22
                local C2
                local Length3 = Length2 + ( Number3 - Length2 ) * Entry2.fast

                if Entry2.c < Number4 then
                    local Min = math.min( Number4, Entry2.c + Amount2 / Length3 )

                    if Min then
                        C2 = Min
                    else
                        C2 = math.max( Number4, Entry2.c - Amount2 / Length3 )
                    end
                else
                    C2 = math.max( Number4, Entry2.c - Amount2 / Length3 )
                end

                local Mix3, Clamp7
                Entry2.c = C2

                if Entry2.c > 0 then
                    local LoopPose2 = LoopPose( Entry2, HumanoidRootPart, Amount2 )
                    local ClipPose2 = ClipPose( CrouchStand, CrouchStand.length * ( 1 - Entry2.c ), true )
                    local Clamp = math.clamp( ( Entry2.c - 0.7 ) / 0.3, 0, 1 )
                    local Mix2 = Mix( ClipPose2, LoopPose2, Clamp * Clamp * ( 3 - 2 * Clamp ) )
                    Mix3 = Mix( Mix2, LoopPose2, Entry2.fast )
                    local Clamp2 = math.clamp( Entry2.c / 0.25, 0, 1 )
                    local Clamp3 = Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 )
                    local Clamp4 = math.clamp( Entry2.c, 0, 1 )
                    local Clamp5 = Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 )
                    local Clamp6 = math.clamp( Entry2.c / 0.25, 0, 1 )
                    Clamp7 = Clamp3 + ( Clamp5 - Clamp6 * Clamp6 * ( 3 - 2 * Clamp6 ) ) * Entry2.fast
                else
                    Entry2.moveW = 0
                    Entry2.phase = 0
                    Value6 = nil
                    Clamp7 = 0
                end
                if Value6 and Clamp7 > 0.001 and OnScreen.Is( Character ) then
                    Apply( Character, HumanoidRootPart, Value6, Clamp7, Entry2 )
                end
                if Character == LocalPlayer.Character then
                    local CrouchDrop

                    if not Value6 or not ( Clamp7 > 0.001 ) then
                        CrouchDrop = 0
                    else
                        local Max = math.max( 0, -Value6.root.Position.Y ) * Clamp7

                        if Max then
                            CrouchDrop = Max
                        else
                            CrouchDrop = 0
                        end
                    end

                    ClientState.CrouchDrop = CrouchDrop
                end
            end
        end
    end

    local Value1 = nil

    for Value2 in Table7, nil, nil do
        if not Value2.Parent then
            Table7[ Value2 ] = nil
        end
    end
end
return Table
