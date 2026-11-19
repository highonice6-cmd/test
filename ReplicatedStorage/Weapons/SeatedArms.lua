-- ReplicatedStorage.Weapons.SeatedArms
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Inverse
local CollectionService = game:GetService( "CollectionService" )
local Players = game:GetService( "Players" )
local Parent = script.Parent
local Config = require( Parent:WaitForChild( "Config" ) )
local ClientState = require( Parent:WaitForChild( "ClientState" ) )
local ArmIK = require( Parent:WaitForChild( "ArmIK" ) )
local Holds = require( Parent:WaitForChild( "Holds" ) )
local AnimWorkers = require( Parent:WaitForChild( "AnimWorkers" ) )
local Table = { }
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Angles = CFrame.Angles( 0, 0.20943951023931956, 0 ) * CFrame.Angles( -0.2617993877991494, 0, 0 )

if Config.Poses.PistolReload then
    local GunInHand = Config.Poses.PistolReload.GunInHand

    if GunInHand then
        Inverse = GunInHand
    else
        local PistolAim = Config.Poses.PistolAim

        if PistolAim then
            PistolAim2 = PistolAim
        else
            PistolAim2 = Config.Poses.Aim
        end

        Inverse = PistolAim2.RightHand:Inverse( )
    end
else
    local PistolAim2
    local PistolAim = Config.Poses.PistolAim

    if PistolAim then
        PistolAim2 = PistolAim
    else
        PistolAim2 = Config.Poses.Aim
    end

    Inverse = PistolAim2.RightHand:Inverse( )
end

local Table2 = {
    Right = {
        "RightUpperArm",
        "RightShoulder",
        "RightLowerArm",
        "RightElbow",
        "RightHand",
        "RightWrist"
    },
    Left = {
        "LeftUpperArm",
        "LeftShoulder",
        "LeftLowerArm",
        "LeftElbow",
        "LeftHand",
        "LeftWrist"
    }
}
local Table3 = { }
local Table4 = { }
local Class = setmetatable( { }, { __mode = "k" } )
local Class2 = setmetatable( { }, { __mode = "k" } )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
local OnScreen = require( Parent:WaitForChild( "OnScreen" ) )
local Table5 = { }

local function WatchSeat( SeatName, Object )
    if not SeatName:IsA( "Seat" ) and not SeatName:IsA( "VehicleSeat" ) then
        return
    end

    local Value1

    local function Upd()
        local Captured = SeatName.Occupant ~= nil and SeatName.Parent ~= nil and Object or nil
        Table5[ SeatName ] = Captured
    end

    SeatName:GetPropertyChangedSignal( "Occupant" ):Connect( Upd )
    SeatName.AncestryChanged:Connect( Upd )
    Value1 = SeatName.Occupant ~= nil and SeatName.Parent ~= nil and Object or nil
    Table5[ SeatName ] = Value1
end

local function WatchCar( Object )
    local VehicleSeats2
    local VehicleSeats = Object:FindFirstChild( "VehicleSeats" )

    if VehicleSeats then
        VehicleSeats2 = VehicleSeats
    else
        VehicleSeats2 = Object:WaitForChild( "VehicleSeats", 10 )
    end
    if not VehicleSeats2 then
        return
    end
    for Key, Value in VehicleSeats2:GetChildren( ) do
        WatchSeat( Value, Object )
    end

    VehicleSeats2.ChildAdded:Connect( function( SeatName )
        WatchSeat( SeatName, Object )
    end )
end

for Key, Value in CollectionService:GetTagged( "Vehicle" ) do
    task.spawn( WatchCar, Value )
end

CollectionService:GetInstanceAddedSignal( "Vehicle" ):Connect( function( Argument1 )
    task.spawn( WatchCar, Argument1 )
end )

local function Approach( Argument1, Argument2, Amount )
    return Argument1 + ( Argument2 - Argument1 ) * ( 1 - math.exp( -10 * Amount ) )
end

local function JointOf( Object, Name, Name2 )
    local FoundChild2
    local FoundChild = Object:FindFirstChild( Name )
    FoundChild2 = if FoundChild then FoundChild:FindFirstChild( Name2 ) else FoundChild
    return FoundChild2
end

local function GripOf( Key )
    local Entry2
    local Entry = Table3[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local InverseInner

        if not Holds.IsPistol( Key ) or not Inverse then
            local Pose2
            local Pose = Holds.Pose( Key, "Aim" )
            Pose2 = if Pose then Pose else Config.Poses.Aim
            InverseInner = Pose2.RightHand:Inverse( )
        else
            InverseInner = Inverse
        end

        Table3[ Key ] = InverseInner
        Entry2 = InverseInner
    end

    return Entry2
end

local function FixOf( Key, Callback )
    local Entry2
    local Entry = Table4[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local FromAxisAngle2
        local Value1 = Callback( Key )
        local Cross = Value1:Cross( Vector3.new( 0, 0, -1 ) )
        local Acos = math.acos( ( math.clamp( -Value1.Z, -1, 1 ) ) )

        if not ( Cross.Magnitude > 1e-06 ) or not ( Acos > 0.0001 ) then
            FromAxisAngle2 = CFrame.identity
        else
            local FromAxisAngle = CFrame.fromAxisAngle( Cross.Unit, Acos )

            if FromAxisAngle then
                FromAxisAngle2 = FromAxisAngle
            else
                FromAxisAngle2 = CFrame.identity
            end
        end

        Table4[ Key ] = FromAxisAngle2
        Entry2 = FromAxisAngle2
    end

    return Entry2
end

local function WheelOf( Key )
    local Entry = Class[ Key ]

    if not Entry or not Entry.att then
        if Entry and os.clock( ) < Entry.retry then
            return nil
        end

        local Table
        local Volant = Key:FindFirstChild( "Volant", true )
        local PoigneeG = Key:FindFirstChild( "PoigneeG", true )
        local PoigneeD = Key:FindFirstChild( "PoigneeD", true )

        if not Volant or not Volant:IsA( "Attachment" ) then
            if not PoigneeG or not PoigneeD or not PoigneeG:IsA( "Attachment" ) or not PoigneeD:IsA( "Attachment" ) then
                Table = { retry = os.clock( ) + 2 }
            else
                Table = { att = PoigneeG, grips = { Left = PoigneeG, Right = PoigneeD } }
            end
        else
            Table = { att = Volant, radius = Volant:GetAttribute( "Rayon" ) or 0.6 }
        end

        local Table2
        Class[ Key ] = Table
        Table2 = if not Table.att or not Table then nil else Table
        return Table2
    end
    local Entry2 = Entry.att.Parent and Entry or nil
    return Entry2
end

local function WheelHand( Argument1, HandName, Amount )
    local Number
    local WorldCFrame = Argument1.att.WorldCFrame
    Number = HandName ~= "Left" and 1.2217304763960306 or -1.2217304763960306
    local Unit2
    local Number2 = Number - Amount * 0.5235987755982988
    local Amount2 = -WorldCFrame.LookVector
    local Position = WorldCFrame.Position + ( WorldCFrame.RightVector * math.sin( Number2 ) + WorldCFrame.UpVector * math.cos( Number2 ) ) * Argument1.radius + Amount2 * 0.05
    local Unit = ( WorldCFrame.Position - Position ).Unit
    Unit2 = HandName == "Left" and Unit or -Unit
    return CFrame.fromMatrix( Position, ( Unit2 - Amount2 * Unit2:Dot( Amount2 ) ).Unit, Amount2 )
end

local function GripHand( Argument1, HandName )
    local WorldCFrame3
    local WorldCFrame = Argument1.grips.Left.WorldCFrame
    local WorldCFrame2 = Argument1.grips.Right.WorldCFrame
    local Unit = ( WorldCFrame.Position - WorldCFrame2.Position ).Unit
    local Unit2 = Unit:Cross( WorldCFrame.UpVector ).Unit
    local Unit3 = Unit2:Cross( Unit ).Unit
    WorldCFrame3 = HandName == "Left" and WorldCFrame or WorldCFrame2
    local Amount
    local Position = WorldCFrame3.Position + Unit3 * 0.12
    Amount = HandName == "Left" and -Unit3 or Unit3
    return CFrame.fromMatrix( Position, Amount, -Unit2 )
end

local function ThighHand( Object, HandName, UpVector )
    local FoundChild = Object:FindFirstChild( HandName .. "UpperLeg" )

    if not FoundChild then
        return nil
    end

    local Amount4
    local CFrame2 = FoundChild.CFrame
    local Amount2 = -CFrame2.UpVector
    local Unit = ( Amount2 - UpVector * Amount2:Dot( UpVector ) ).Unit
    local Position = CFrame2.Position + UpVector * 0.45 + Unit * 0.25
    local Amount3 = -Unit
    Amount4 = HandName == "Left" and -UpVector or UpVector
    return CFrame.fromMatrix( Position, ( Amount4 - Amount3 * Amount4:Dot( Amount3 ) ).Unit, Amount3 )
end

local function GunHand( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local LookAt = CFrame.lookAt( Vector3.new( 0, 0, 0 ), Argument2, Argument3 ) * Argument4
    return CFrame.new( Argument1 ) * ( LookAt * Argument5.Rotation:Inverse( ) )
end

local function AimDir( Object, HumanoidRootPart, Argument3 )
    if Object ~= LocalPlayer.Character then
        local Rad = math.rad( Object:GetAttribute( "GunYaw" ) or 0 )
        local Rad2 = math.rad( Object:GetAttribute( "GunPitch" ) or 0 )
        local CFrame2 = HumanoidRootPart.CFrame
        local Amount = -math.sin( Rad )
        local VectorToWorldSpace = CFrame2:VectorToWorldSpace( ( Vector3.new( Amount, 0, -math.cos( Rad ) ) ) )
        local X = VectorToWorldSpace.X
        return Vector3.new( X, 0, VectorToWorldSpace.Z ).Unit * math.cos( Rad2 ) + Vector3.new( 0, 1, 0 ) * math.sin( Rad2 )
    end

    local TestSeatAim = LocalPlayer:GetAttribute( "TestSeatAim" )

    if typeof( TestSeatAim ) == "Vector3" and TestSeatAim.Magnitude > 0 then
        return HumanoidRootPart.CFrame:VectorToWorldSpace( TestSeatAim.Unit )
    end

    local Model
    local CFrame = CurrentCamera.CFrame
    local LookVector = CFrame.LookVector
    local Vehicle = ClientState.Vehicle
    local FilterDescendantsInstances = { }
    local FX = workspace:FindFirstChild( "FX" ) or Object
    Model = Vehicle and Vehicle.Model or Object
    local Distance
    FilterDescendantsInstances[ 1 ] = Object
    FilterDescendantsInstances[ 2 ] = FX
    FilterDescendantsInstances[ 3 ] = Model
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Max = math.max( 0, ( Argument3 - CFrame.Position ):Dot( LookVector ) )
    local Raycast = workspace:Raycast( CFrame.Position + LookVector * Max, LookVector * 1000, RaycastParams2 )
    local Position = CFrame.Position
    Distance = Raycast and Raycast.Distance or 1000
    return ( Position + LookVector * ( Max + math.max( Distance, 15 ) ) - Argument3 ).Unit
end

local function SolveArm( Object, ArmName, Argument3, Argument4, Amount )
    if Amount <= 0.001 or not Argument4 then
        return
    end

    local FoundChild2
    local Entry = Table2[ ArmName ]
    local Item = Entry[ 1 ]
    local Item2 = Entry[ 2 ]
    local FoundChild = Object:FindFirstChild( Item )

    if FoundChild then
        FoundChild2 = FoundChild:FindFirstChild( Item2 )
    else
        FoundChild2 = FoundChild
    end

    local FoundChild4
    local Item3 = Entry[ 3 ]
    local Item4 = Entry[ 4 ]
    local FoundChild3 = Object:FindFirstChild( Item3 )

    if FoundChild3 then
        FoundChild4 = FoundChild3:FindFirstChild( Item4 )
    else
        FoundChild4 = FoundChild3
    end

    local FoundChild6
    local Item5 = Entry[ 5 ]
    local Item6 = Entry[ 6 ]
    local FoundChild5 = Object:FindFirstChild( Item5 )

    if FoundChild5 then
        FoundChild6 = FoundChild5:FindFirstChild( Item6 )
    else
        FoundChild6 = FoundChild5
    end
    if not FoundChild2 or not FoundChild4 or not FoundChild6 then
        return
    end

    local RightVector
    local GetT = AnimWorkers.getT( FoundChild2 )
    local GetT2 = AnimWorkers.getT( FoundChild4 )
    local GetT3 = AnimWorkers.getT( FoundChild6 )
    local Position = ( Argument3 * ArmIK.Frames( FoundChild2 ) ).Position
    RightVector = ArmName == "Right" and Argument3.RightVector or -Argument3.RightVector
    local Solve = ArmIK.Solve
    Solve( Object, ArmName, Argument3, Argument4, Position - Argument3.UpVector * 2 + RightVector * 0.8 )

    if Amount < 0.999 then
        local Lerp = GetT:Lerp( AnimWorkers.getT( FoundChild2 ), Amount )
        local Lerp2 = GetT2:Lerp( AnimWorkers.getT( FoundChild4 ), Amount )
        local Lerp3 = GetT3:Lerp( AnimWorkers.getT( FoundChild6 ), Amount )
        AnimWorkers.setT( FoundChild2, Lerp )
        AnimWorkers.setT( FoundChild4, Lerp2 )
        AnimWorkers.setT( FoundChild6, Lerp3 )
    end
end

local function Update( Object, Argument2, Key5, Key6, Amount, Callback )
    local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )

    if not HumanoidRootPart then
        return
    end

    local Entry2
    local Entry = Class2[ Object ]

    if not Entry or Entry.seat ~= Argument2 then
        local Table = { seat = Argument2, armW = 0, aimW = 0, freeW = 0, onW = 0 }
        Class2[ Object ] = Table
        Entry2 = Table
    else
        Entry2 = Entry
    end

    local Flag
    Entry2.used = true
    Flag = Argument2.Name == "Driver" and true or false
    local Value5

    if Flag then
        local WheelOf2 = WheelOf( Key5 )

        if WheelOf2 then
            Value5 = WheelOf2
        else
            Value5 = nil
        end
    else
        Value5 = nil
    end

    local Flag3

    if Key6 == nil then
        Flag3 = false
    elseif Key6.reloadT == nil then
        Flag3 = false
    elseif Key6.reloadDur == nil then
        Flag3 = false
    elseif Key6.reloadT >= 0 then
        if Key6.reloadT < Key6.reloadDur then
            Flag3 = true
        else
            Flag3 = false
        end
    else
        Flag3 = false
    end

    local Flag2

    if Key6 == nil then
        Flag2 = false
    elseif Key6.stance == "Aim" then
        Flag2 = true
    elseif Key6.stance == "ReloadAim" then
        Flag2 = true
    else
        Flag2 = false
    end

    local Tool = not Key6 and Object:FindFirstChildOfClass( "Tool" ) or nil
    local Number
    local OnW = Entry2.onW
    Entry2.onW = OnW + ( 1 - OnW ) * ( 1 - math.exp( -10 * Amount ) )
    local ArmW = Entry2.armW
    Number = not Key6 and 0 or 1
    local Number2
    Entry2.armW = ArmW + ( Number - ArmW ) * ( 1 - math.exp( -10 * Amount ) )
    local AimW = Entry2.aimW
    Number2 = not Flag2 and 0 or 1
    local Number3
    Entry2.aimW = AimW + ( Number2 - AimW ) * ( 1 - math.exp( -10 * Amount ) )
    local FreeW = Entry2.freeW
    Number3 = not Flag3 and 1 or 0
    local Entry6
    Entry2.freeW = FreeW + ( Number3 - FreeW ) * ( 1 - math.exp( -10 * Amount ) )
    local UpVector = HumanoidRootPart.CFrame.UpVector

    if not Flag or not ClientState.CarSteer then
        Entry6 = 0
    else
        local Entry3 = ClientState.CarSteer[ Key5 ]

        if Entry3 then
            Entry6 = Entry3
        else
            Entry6 = 0
        end
    end

    local UpperTorsoWorld = ArmIK.UpperTorsoWorld( Object )

    if not UpperTorsoWorld then
        return
    end

    local RightShoulder
    local RightUpperArm = Object:FindFirstChild( "RightUpperArm" )

    if RightUpperArm then
        RightShoulder = RightUpperArm:FindFirstChild( "RightShoulder" )
    else
        RightShoulder = RightUpperArm
    end

    local VectorToWorldSpace, UpperTorsoWorld2

    if not Key6 or not RightShoulder then
        UpperTorsoWorld2 = UpperTorsoWorld
        VectorToWorldSpace = nil
    else
        local Waist
        local AimDir2 = AimDir( Object, HumanoidRootPart, ( UpperTorsoWorld * ArmIK.Frames( RightShoulder ) ).Position )
        local VectorToObjectSpace = HumanoidRootPart.CFrame:VectorToObjectSpace( AimDir2 )
        local Amount2 = -VectorToObjectSpace.X
        local Clamp = math.clamp( math.atan2( Amount2, -VectorToObjectSpace.Z ), -2.6179938779914944, 2.6179938779914944 )
        local Clamp2 = math.clamp( math.asin( ( math.clamp( VectorToObjectSpace.Y, -1, 1 ) ) ), -1.2217304763960306, 1.2217304763960306 )
        VectorToWorldSpace = HumanoidRootPart.CFrame:VectorToWorldSpace( ( CFrame.Angles( 0, Clamp, 0 ) * CFrame.Angles( Clamp2, 0, 0 ) ).LookVector )
        local ArmW2 = Entry2.armW * Entry2.freeW
        local Clamp3 = math.clamp( Clamp * 0.45, -0.8726646259971648, 0.8726646259971648 ) * Entry2.aimW
        local UpperTorso = Object:FindFirstChild( "UpperTorso" )

        if UpperTorso then
            Waist = UpperTorso:FindFirstChild( "Waist" )
        else
            Waist = UpperTorso
        end
        if Waist then
            local SetT = AnimWorkers.setT
            local GetT = AnimWorkers.getT( Waist )
            SetT( Waist, GetT:Lerp( CFrame.Angles( 0, Clamp3, 0 ), ArmW2 ) )
        end

        local Neck
        local Head = Object:FindFirstChild( "Head" )

        if Head then
            Neck = Head:FindFirstChild( "Neck" )
        else
            Neck = Head
        end
        if Neck then
            local AnglesInner = CFrame.Angles( 0, math.clamp( Clamp - Clamp3, -1.2217304763960306, 1.2217304763960306 ), 0 ) * CFrame.Angles( math.clamp( Clamp2 * 0.6, -0.6108652381980153, 0.6108652381980153 ), 0, 0 )
            local SetT2 = AnimWorkers.setT
            local GetT2 = AnimWorkers.getT( Neck )
            SetT2( Neck, GetT2:Lerp( AnglesInner, ArmW2 * Entry2.aimW ) )
        end

        UpperTorsoWorld2 = ArmIK.UpperTorsoWorld( Object )
    end
    if Key6 and RightShoulder then
        local Entry5
        local FixOf2 = FixOf( Key6 and Key6.weapon, Callback )
        local Entry4 = Table3[ Key6 and Key6.weapon ]

        if Entry4 then
            Entry5 = Entry4
        else
            local InverseInner

            if not Holds.IsPistol( Key6 and Key6.weapon ) or not Inverse then
                local Pose2
                local Pose = Holds.Pose( Key6 and Key6.weapon, "Aim" )
                Pose2 = if Pose then Pose else Config.Poses.Aim
                InverseInner = Pose2.RightHand:Inverse( )
            else
                InverseInner = Inverse
            end

            Table3[ Key6 and Key6.weapon ] = InverseInner
            Entry5 = InverseInner
        end

        local RightElbow
        local RightLowerArm = Object:FindFirstChild( "RightLowerArm" )

        if RightLowerArm then
            RightElbow = RightLowerArm:FindFirstChild( "RightElbow" )
        else
            RightElbow = RightLowerArm
        end

        local RightWrist
        local RightHand = Object:FindFirstChild( "RightHand" )

        if RightHand then
            RightWrist = RightHand:FindFirstChild( "RightWrist" )
        else
            RightWrist = RightHand
        end

        local CFrame2
        local ThighHand2 = ThighHand( Object, "Right", UpVector )

        if ThighHand2 then
            local Position = ThighHand2.Position
            local LookAt = CFrame.lookAt( Vector3.new( 0, 0, 0 ), ( HumanoidRootPart.CFrame.Rotation * Angles ).LookVector, UpVector ) * FixOf2
            CFrame2 = CFrame.new( Position ) * ( LookAt * Entry5.Rotation:Inverse( ) )
        else
            CFrame2 = ThighHand2
        end

        local CFrame4

        if not ( Entry2.aimW > 0.001 ) or not RightElbow or not RightWrist then
            CFrame4 = CFrame2
        else
            local Lerp2
            local Frames, Frames2 = ArmIK.Frames( RightShoulder )
            local Frames3, Frames22 = ArmIK.Frames( RightElbow )
            local Magnitude = ( ( Frames3.Position - Frames2.Position ).Magnitude + ( ArmIK.Frames( RightWrist ).Position - Frames22.Position ).Magnitude ) * 0.9
            local Position2 = ( UpperTorsoWorld2 * Frames ).Position + VectorToWorldSpace * Magnitude
            local LookAt2 = CFrame.lookAt( Vector3.new( 0, 0, 0 ), VectorToWorldSpace, Vector3.new( 0, 1, 0 ) ) * FixOf2
            local CFrame3 = CFrame.new( Position2 ) * ( LookAt2 * Entry5.Rotation:Inverse( ) )

            if CFrame2 then
                local Lerp = CFrame2:Lerp( CFrame3, Entry2.aimW )

                if Lerp then
                    Lerp2 = Lerp
                else
                    Lerp2 = CFrame3
                end
            else
                Lerp2 = CFrame3
            end

            CFrame4 = Lerp2
        end
        if CFrame4 then
            Entry2.gunRel = HumanoidRootPart.CFrame:ToObjectSpace( CFrame4 )
        end
    end

    local GunRel2
    local GunRel = Entry2.gunRel
    GunRel2 = if GunRel then HumanoidRootPart.CFrame * Entry2.gunRel else GunRel
    local Number5, Lerp5

    if Value5 then
        local WheelHand2

        if Value5.grips then
            local GripHand2 = GripHand( Value5, "Right" )

            if GripHand2 then
                Value7 = GripHand2
            else
                WheelHand2 = WheelHand( Value5, "Right", Entry6 )
            end
        else
            WheelHand2 = WheelHand( Value5, "Right", Entry6 )
        end

        local Lerp4

        if GunRel2 then
            local Lerp3 = Value7:Lerp( GunRel2, Entry2.armW )

            if Lerp3 then
                Lerp4 = Lerp3
            else
                Lerp4 = Value7
            end
        else
            Lerp4 = Value7
        end

        local Number4 = not Tool and 1 or 0
        Number5 = Number4
        Lerp5 = Lerp4
    else
        Number5 = Entry2.armW
        Lerp5 = GunRel2
    end

    local FreeW2
    local OnW2 = Entry2.onW
    FreeW2 = Key6 and Entry2.freeW or 1
    local ThighHand3, Number7
    local Number6 = Number5 * ( OnW2 * FreeW2 )

    if Value5 then
        local WheelHand3

        if Value5.grips then
            local GripHand3 = GripHand( Value5, "Left" )

            if GripHand3 then
                Value9 = GripHand3
            else
                WheelHand3 = WheelHand( Value5, "Left", Entry6 )
            end
        else
            WheelHand3 = WheelHand( Value5, "Left", Entry6 )
        end

        Number7 = 1
        Value10 = Value9
    else
        ThighHand3 = ThighHand( Object, "Left", UpVector )
        Number7 = Entry2.armW
    end

    local FreeW3
    local OnW3 = Entry2.onW
    FreeW3 = Key6 and Entry2.freeW or 1
    local Number8 = Number7 * ( OnW3 * FreeW3 )
    SolveArm( Object, "Right", UpperTorsoWorld2, Lerp5, Number6 )
    SolveArm( Object, "Left", UpperTorsoWorld2, Value10, Number8 )

    if Key6 and Key6.joint and Key6.joint.Parent then
        local _, _, ArmWorld3 = ArmIK.ArmWorld( Object, "Right", UpperTorsoWorld2 )

        if ArmWorld3 then
            local Entry8
            local ArmW3 = Entry2.armW * Entry2.freeW
            local SetC0 = AnimWorkers.setC0
            local Joint = Key6.joint
            local C0 = AnimWorkers.getC0( Key6.joint )
            local Entry7 = Table3[ Key6 and Key6.weapon ]

            if Entry7 then
                Entry8 = Entry7
            else
                local Inverse2

                if not Holds.IsPistol( Key6 and Key6.weapon ) or not Inverse then
                    local Pose4
                    local Pose3 = Holds.Pose( Key6 and Key6.weapon, "Aim" )
                    Pose4 = if Pose3 then Pose3 else Config.Poses.Aim
                    Inverse2 = Pose4.RightHand:Inverse( )
                else
                    Inverse2 = Inverse
                end

                Table3[ Key6 and Key6.weapon ] = Inverse2
                Entry8 = Inverse2
            end

            SetC0( Joint, C0:Lerp( UpperTorsoWorld2:ToObjectSpace( ArmWorld3 * Entry8 ), ArmW3 ) )
            Key6.lastC0 = AnimWorkers.getC0( Key6.joint )

            if Key6.lastPose then
                local Value11 = nil

                for Key4, Value in Table2, nil, nil do
                    local J = 1

                    for J = 1, 5, 2 do
                        local FoundChild2
                        local Entry9 = Value[ J ]
                        local Entry10 = Value[ J + 1 ]
                        local FoundChild = Object:FindFirstChild( Entry9 )

                        if FoundChild then
                            FoundChild2 = FoundChild:FindFirstChild( Entry10 )
                        else
                            FoundChild2 = FoundChild
                        end
                        if FoundChild2 then
                            local LastPose = Key6.lastPose
                            LastPose[ FoundChild2 ] = AnimWorkers.getT( FoundChild2 )
                        end
                    end
                end
            end
        end
    end
end

function Table.Update( Amount, List, Callback )
    local Value1
    local Position = CurrentCamera.CFrame.Position
    Value1 = nil

    for Key, Value in Class2, nil, nil do
        Value.used = false
    end

    local Value2 = nil

    for Key2, Value3 in Table5, nil, nil do
        local Parent = Key2.Parent

        if not Parent or not Value3.Parent then
            Table5[ Key2 ] = nil
        else
            local Driver = Parent:FindFirstChild( "Driver" )

            if Driver and not ( ( Driver.Position - Position ).Magnitude > 150 ) then
                local Occupant2
                local Occupant = Key2.Occupant

                if Occupant then
                    if Occupant.Health > 0 then
                        Occupant2 = Occupant.Parent
                    else
                        Occupant2 = false
                    end
                else
                    Occupant2 = Occupant
                end
                if Occupant2 and AnimWorkers.PlayerOf( Occupant2 ) and AnimWorkers.Owns( Occupant2 ) then
                    if OnScreen.Is( Occupant2 ) then
                        local Entry2
                        local Entry = List[ Occupant2 ]
                        Entry2 = Entry and Entry.joint and Entry.weapon and Entry or nil
                        Update( Occupant2, Key2, Value3, Entry2, Amount, Callback )
                    elseif Class2[ Occupant2 ] then
                        Class2[ Occupant2 ].used = true
                    end
                end
            end
        end
    end

    local Value4 = nil

    for Key3, Value5 in Class2, nil, nil do
        if not Value5.used then
            Class2[ Key3 ] = nil
        end
    end
end
return Table
