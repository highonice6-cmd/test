-- StarterPlayer.StarterPlayerScripts.CarHitClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local AntiTunnel = require( ReplicatedStorage:WaitForChild( "AntiTunnel" ) )
local SpawnShield = require( ReplicatedStorage:WaitForChild( "SpawnShield" ) )
local CarHit = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "CarHit" )
local LocalPlayer = Players.LocalPlayer
local HitAudio = require( ReplicatedStorage.Weapons:WaitForChild( "HitAudio" ) )
ReplicatedStorage.Remotes:WaitForChild( "CarHitMarker" ).OnClientEvent:Connect( function()
    HitAudio.Play( "Marker" )
end )
local Part = Instance.new( "Part" )
Part.Shape = Enum.PartType.Ball
Part.Size = Vector3.new( 0.4000000059604645, 0.4000000059604645, 0.4000000059604645 )
Part.Anchored = true
Part.CanCollide = false
Part.CanQuery = false
Part.CanTouch = false
local OverlapParams2 = OverlapParams.new( )
OverlapParams2.FilterType = Enum.RaycastFilterType.Exclude
OverlapParams2.RespectCanCollide = true
OverlapParams2.CollisionGroup = "Default"

local function SolidAt( Argument1, FilterDescendantsInstances )
    local Success2
    Part.CFrame = CFrame.new( Argument1 )
    OverlapParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Success, Result = pcall( workspace.GetPartsInPart, workspace, Part, OverlapParams2 )

    if Success then
        if #Result > 0 then
            Success2 = true
        else
            Success2 = false
        end
    else
        Success2 = Success
    end

    return Success2
end

local function JointFrames( Self )
    if Self:IsA( "Motor6D" ) then
        return Self.Part0, Self.Part1, Self.C0, Self.C1
    end

    local Attachment0 = Self.Attachment0
    local Attachment1 = Self.Attachment1

    if not Attachment0 or not Attachment1 then
        return
    end
    return Attachment0.Parent, Attachment1.Parent, Attachment0.CFrame, Attachment1.CFrame
end

local function StandUp( Char, Humanoid )
    local HumanoidRootPart = Char:FindFirstChild( "HumanoidRootPart" )

    if not HumanoidRootPart then
        return
    end

    local Vector33
    local UpperTorso = Char:FindFirstChild( "UpperTorso" ) or HumanoidRootPart
    local X = UpperTorso.CFrame.UpVector.X
    local Vector32 = Vector3.new( X, 0, UpperTorso.CFrame.UpVector.Z )

    if Vector32.Magnitude < 0.1 then
        local X2 = HumanoidRootPart.CFrame.LookVector.X
        Vector33 = Vector3.new( X2, 0, HumanoidRootPart.CFrame.LookVector.Z )
    else
        Vector33 = Vector32
    end
    if Vector33.Magnitude < 0.1 then
        Vector33 = Vector3.new( 0, 0, 1 )
    end

    local Value1, Raycast
    local RaycastParams2 = RaycastParams.new( )
    RaycastParams2.IgnoreWater = true
    RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
    RaycastParams2.FilterDescendantsInstances = { Char, workspace:FindFirstChild( "FX" ), workspace.CurrentCamera }
    RaycastParams2.CollisionGroup = "Default"
    local Table = { 3, 6, 10 }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Position = HumanoidRootPart.Position + Vector3.new( 0, Value, 0 )

        if Value ~= 10 then
            local Success2
            local FilterDescendantsInstances = RaycastParams2.FilterDescendantsInstances
            Part.CFrame = CFrame.new( Position )
            OverlapParams2.FilterDescendantsInstances = FilterDescendantsInstances
            local Success, Result = pcall( workspace.GetPartsInPart, workspace, Part, OverlapParams2 )

            if Success then
                if #Result > 0 then
                    Success2 = true
                else
                    Success2 = false
                end
            else
                Success2 = Success
            end
            if Success2 then
                continue
            end
        end

        Raycast = workspace:Raycast( Position, Vector3.new( 0, -( Value + 9 ), 0 ), RaycastParams2 )
        break
    end
    if not Raycast then
        local Raycast2 = workspace:Raycast( HumanoidRootPart.Position, Vector3.new( 0, 18, 0 ), RaycastParams2 )

        if Raycast2 and Raycast2.Normal.Y < -0.5 then
            Raycast = workspace:Raycast( Raycast2.Position + Vector3.new( 0, 3, 0 ), Vector3.new( 0, -3.5, 0 ), RaycastParams2 ) or Raycast2
        end
    end

    local Y2

    if Raycast then
        local Y = Raycast.Position.Y

        if Y then
            Y2 = Y
        else
            Y2 = HumanoidRootPart.Position.Y - 1
        end
    else
        Y2 = HumanoidRootPart.Position.Y - 1
    end

    local Y3 = Y2 + Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2
    local X3 = HumanoidRootPart.Position.X
    local Vector34 = Vector3.new( X3, Y3, HumanoidRootPart.Position.Z )
    HumanoidRootPart.CFrame = CFrame.lookAt( Vector34, Vector34 + Vector33.Unit )
    local Table2 = { }

    for Key2, Value2 in Char:GetDescendants( ) do
        if Value2:IsA( "Motor6D" ) or Value2:IsA( "AnimationConstraint" ) then
            local Part0, Part1, C0, C1

            if Value2:IsA( "Motor6D" ) then
                Part0 = Value2.Part0
                Part1 = Value2.Part1
                C0 = Value2.C0
                C1 = Value2.C1
            else
                local Attachment0 = Value2.Attachment0
                local Attachment1 = Value2.Attachment1

                if not Attachment0 or not Attachment1 then
                    Part0 = nil
                    Part1 = nil
                    C0 = nil
                    C1 = nil
                else
                    Part0 = Attachment0.Parent
                    Part1 = Attachment1.Parent
                    C0 = Attachment0.CFrame
                    C1 = Attachment1.CFrame
                end
            end
            if Part0 and Part1 and Part1.Parent == Char then
                table.insert( Table2, { Part0, Part1, C0, C1 } )
            end
        end
    end

    local Flag
    local Table3 = { [ HumanoidRootPart ] = true }
    Flag = true

    while Flag do
        local Value3 = nil
        Flag = false

        for Key3, Value4 in Table2, nil, nil do
            if Table3[ Value4[ 1 ] ] and not Table3[ Value4[ 2 ] ] then
                local Item = Value4[ 2 ]
                Item.CFrame = Value4[ 1 ].CFrame * Value4[ 3 ] * Value4[ 4 ]:Inverse( )
                Table3[ Value4[ 2 ] ] = true
                Flag = true
            end
        end
    end
    for Key4, Value5 in Char:GetDescendants( ) do
        if Value5:IsA( "BasePart" ) then
            Value5.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
            Value5.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
        end
    end
end

local Value1 = nil
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true

local function WallBehind( Argument1, Argument2, Result )
    local X = Result.X
    local Vector32 = Vector3.new( X, 0, Result.Z )
    local Magnitude = Vector32.Magnitude

    if Magnitude < 1 then
        return nil
    end

    local Value1
    local FilterDescendantsInstances = { Argument1, workspace.CurrentCamera }
    local Table = { "FX", "ClientHitboxes", "TrainsLocaux", "Dummies" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local FoundChild = workspace:FindFirstChild( Value )

        if FoundChild then
            table.insert( FilterDescendantsInstances, FoundChild )
        end
    end

    local Find = WorldRefs.Find( "Cars" )

    if Find then
        table.insert( FilterDescendantsInstances, Find )
    end

    local CollisionGroup
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    CollisionGroup = not game:GetService( "PhysicsService" ):IsCollisionGroupRegistered( "CarRagdoll" ) and "Default" or "CarRagdoll"
    local Value2, Raycast
    RaycastParams2.CollisionGroup = CollisionGroup
    local Unit = Vector32.Unit * math.clamp( Magnitude * 0.15, 3, 25 )
    local Table2 = { 0, 1.2, -1.2 }
    Value2 = nil
    Raycast = nil

    for Key2, Value3 in Table2, nil, nil do
        local Raycast2 = workspace:Raycast( Argument2.Position + Vector3.new( 0, Value3, 0 ), Unit, RaycastParams2 )

        if Raycast2 and math.abs( Raycast2.Normal.Y ) < 0.5 then
            if not Raycast or Raycast2.Distance < Raycast.Distance then
                Raycast = Raycast2
            end
        end
    end

    return Raycast
end

local function LaunchVelocity( Object, HumanoidRootPart, Amount )
    local Result = Amount * 1.1 + Vector3.new( 0, 14 + Amount.Magnitude * 0.2, 0 )
    local WallBehind2 = WallBehind( Object, HumanoidRootPart, Result )

    if not WallBehind2 then
        return Result
    end

    local X = WallBehind2.Normal.X
    local Vector32 = Vector3.new( X, 0, WallBehind2.Normal.Z )

    if Vector32.Magnitude < 0.1 then
        return Result
    end

    local Unit = Vector32.Unit
    local Amount2 = -Result:Dot( Unit )

    if Amount2 <= 0 then
        return Result
    end
    if WallBehind2.Distance <= 3 then
        local Result2 = Result + Unit * ( Amount2 + math.min( Amount2 * 0.1, 10 ) )
        local X2 = Result2.X
        return Vector3.new( X2, 14, Result2.Z ), WallBehind2, Unit
    end

    local Result3 = if Amount2 > 70 then Result + Unit * ( Amount2 - 70 ) else Result
    return Result3, WallBehind2, Unit
end

local Value2 = nil
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.IgnoreWater = true
RaycastParams3.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams3.RespectCanCollide = true
RaycastParams3.CollisionGroup = "Default"
local Value3 = nil

local function GuardStep()
    if Value2 then
        local Clock = os.clock( )

        if not ( Value2.untilT < Clock ) and LocalPlayer.Character == Value2.char and Value2.char.Parent then
            local Value1, Number
            Value1 = nil
            Number = -0.05

            for Key, Value in Value2.char:GetChildren( ) do
                if Value:IsA( "BasePart" ) then
                    local Position2 = Value.Position - Value2.point
                    local Dot3 = Position2:Dot( Value2.n )

                    if Dot3 < Number and ( Position2 - Value2.n * Dot3 ).Magnitude <= 10 then
                        Value1 = Value
                        Number = Dot3
                    end
                end
            end
            if not Value1 then
                return
            end

            local Position = Value1.Position + Value2.n * ( 1 - Number )
            local Raycast = workspace:Raycast( Position, Value1.Position - Position, RaycastParams3 )

            if not Raycast or not Raycast.Instance.Anchored or not ( Raycast.Normal:Dot( Value2.n ) > 0.9 ) then
                return
            end

            local Dot = 0.6 - ( Value1.Position - Raycast.Position ):Dot( Raycast.Normal )
            Value2.char:PivotTo( Value2.char:GetPivot( ) + Raycast.Normal * Dot )

            for Key2, Value2Inner in Value2.char:GetDescendants( ) do
                if Value2Inner:IsA( "BasePart" ) and not Value2Inner.Anchored then
                    local AssemblyLinearVelocity = Value2Inner.AssemblyLinearVelocity
                    local Dot2 = AssemblyLinearVelocity:Dot( Raycast.Normal )

                    if Dot2 < 0 then
                        Value2Inner.AssemblyLinearVelocity = AssemblyLinearVelocity - Raycast.Normal * Dot2
                    end
                end
            end

            AntiTunnel.Moved( Value2.char )
            local Char = Value2.char
            Char:SetAttribute( "WallGuards", ( Value2.char:GetAttribute( "WallGuards" ) or 0 ) + 1 )
            return
        end
    end

    Value2 = nil

    if Value3 then
        Value3:Disconnect( )
        Value3 = nil
    end
end

local function StartGuard( Object, Argument2, Argument3 )
    local Value1
    local FilterDescendantsInstances = { Object, workspace.CurrentCamera }
    local Table = { "FX", "ClientHitboxes", "TrainsLocaux", "Dummies" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local FoundChild = workspace:FindFirstChild( Value )

        if FoundChild then
            table.insert( FilterDescendantsInstances, FoundChild )
        end
    end

    local Find = WorldRefs.Find( "Cars" )

    if Find then
        table.insert( FilterDescendantsInstances, Find )
    end

    RaycastParams3.FilterDescendantsInstances = FilterDescendantsInstances
    Value2 = {
        char = Object,
        n = Argument3,
        point = Argument2.Position,
        untilT = os.clock( ) + 1.5 + 0.75
    }

    if not Value3 then
        Value3 = RunService.PostSimulation:Connect( GuardStep )
    end
end

local function StartRagdoll( Character, Humanoid, Argument3, Amount )
    local HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    local Table = {
        char = Character,
        hum = Humanoid,
        joints = { },
        parts = { },
        t0 = os.clock( )
    }
    local Tool = Character:FindFirstChildOfClass( "Tool" )

    if Tool then
        Table.tool = Tool
        Humanoid:UnequipTools( )
    end

    ClientState.Aiming = false
    Table.frozenWas = ClientState.Frozen
    ClientState.Frozen = true
    Character:SetAttribute( "CarRagdoll", true )

    for Key, Value in Character:GetDescendants( ) do
        if Value.Name == "Root" or not Value:IsA( "AnimationConstraint" ) then
            if Value:IsA( "BallSocketConstraint" ) then
                local Joints2 = Table.joints
                Joints2[ Value ] = Value.Enabled

                if not Value.Enabled then
                    Value.Enabled = true
                end
            end
        else
            local Joints = Table.joints
            Joints[ Value ] = { kin = Value.IsKinematic, torque = Value.MaxTorque }

            if Value.IsKinematic then
                Value.IsKinematic = false
            end
            if Value.MaxTorque ~= 0 then
                Value.MaxTorque = 0
            end
        end
    end
    for Key2, Value2 in Character:GetChildren( ) do
        if Value2:IsA( "BasePart" ) then
            local CanCollide
            local Parts = Table.parts
            Parts[ Value2 ] = { Value2.CanCollide, Value2.CollisionGroup }
            CanCollide = Value2 ~= HumanoidRootPart and true or false
            Value2.CanCollide = CanCollide
            Value2.CollisionGroup = "CarRagdoll"
        end
    end

    Humanoid:SetStateEnabled( Enum.HumanoidStateType.Seated, false )
    Humanoid:ChangeState( Enum.HumanoidStateType.Physics )
    AntiTunnel.Unclip( Character )
    local AssemblyLinearVelocity, Value1Inner, Value3 = LaunchVelocity( Character, HumanoidRootPart, Amount )

    if Value1Inner then
        StartGuard( Character, Value1Inner, Value3 )
    end
    for Key3, Value4 in Character:GetDescendants( ) do
        if Value4:IsA( "BasePart" ) and not Value4.Anchored then
            Value4.AssemblyLinearVelocity = AssemblyLinearVelocity
            local Random = math.random( ) - 0.5
            local Random2 = math.random( ) - 0.5
            Value4.AssemblyAngularVelocity = Vector3.new( Random, Random2, math.random( ) - 0.5 ) * 6
        end
    end

    Value1 = Table
    CarHit:FireServer( Argument3 )
end

local function EndRagdoll( Argument1 )
    Value1 = nil

    if not Value1 then
        return
    end

    local Char = Value1.char
    local Hum = Value1.hum

    if Argument1 then
        local Value1Inner
        local Joints = Value1.joints
        Value1Inner = nil

        for Key, Value in Joints, nil, nil do
            if Key.Parent then
                if type( Value ) == "table" then
                    if Key.IsKinematic ~= Value.kin then
                        Key.IsKinematic = Value.kin
                    end
                    if Key.MaxTorque ~= Value.torque then
                        Key.MaxTorque = Value.torque
                    end
                elseif Key.Enabled ~= Value then
                    Key.Enabled = Value
                end
            end
        end

        local Value2
        local Parts = Value1.parts
        Value2 = nil

        for Key2, Value3 in Parts, nil, nil do
            if Key2.Parent then
                local CanCollide = Value3[ 1 ]
                local CollisionGroup = Value3[ 2 ]
                Key2.CanCollide = CanCollide
                Key2.CollisionGroup = CollisionGroup
            end
        end

        Hum:SetStateEnabled( Enum.HumanoidStateType.Seated, true )
        Hum.PlatformStand = false
        StandUp( Char, Hum )
        Hum:ChangeState( Enum.HumanoidStateType.Running )
        Char:SetAttribute( "CarRagdoll", nil )

        if Value1.tool and Value1.tool.Parent == LocalPlayer:FindFirstChildOfClass( "Backpack" ) then
            Hum:EquipTool( Value1.tool )
        end
    end
    if ClientState.Frozen == true and not Char:GetAttribute( "Downed" ) then
        ClientState.Frozen = Value1.frozenWas
    end
end

local function GapToBox( Argument1, Amount, Argument3 )
    local PointToObjectSpace = Argument1:PointToObjectSpace( Argument3 )
    return ( PointToObjectSpace - PointToObjectSpace:Max( -Amount / 2 ):Min( Amount / 2 ) ).Magnitude
end

local CrewShared = require( ReplicatedStorage:WaitForChild( "CrewShared" ) )

local function CrewCar( Object )
    if not CrewShared.IdOf( LocalPlayer ) then
        return false
    end
    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "VehicleSeat" ) or Value:IsA( "Seat" ) then
            if Value:GetAttribute( "Role" ) == "Driver" then
                if Value.Occupant then
                    return CrewShared.Same( LocalPlayer, Value.Occupant.Parent )
                end
            end
        end
    end

    return false
end

local Class = setmetatable( { }, { __mode = "k" } )

local function RefsOf( Value )
    local Entry2
    local Entry = Class[ Value ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { model = Value:IsA( "Model" ) }
        Class[ Value ] = Table
        Entry2 = Table
    end

    local Vroot3
    local Vroot = Entry2.vroot

    if not Vroot or Vroot.Parent ~= Value then
        local Vroot2 = Entry2.model and Value:FindFirstChild( "VehicleRoot" ) or nil
        Entry2.vroot = Vroot2
        Vroot3 = Vroot2
    else
        Vroot3 = Vroot
    end

    local Box3
    local Box = Entry2.box

    if not Box or Box.Parent ~= Value then
        local BoxPart
        local Box2 = Value:FindFirstChild( "VehicleHitbox" )

        if Box2 == nil then
            BoxPart = false
        else
            BoxPart = Box2:IsA( "BasePart" )
        end

        Entry2.box = Box2
        Entry2.boxPart = BoxPart
        Box3 = Box2
    else
        Box3 = Box
    end

    return Vroot3, Box3, Entry2.boxPart
end

local Number = 0
RunService.Heartbeat:Connect( function( Argument1 )
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local HumanoidRootPart

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if Value1 then
        if Value1.char ~= Character or not Humanoid or Humanoid.Health <= 0 or Character:GetAttribute( "Downed" ) then
            Value1 = nil

            if not Value1 then
                return
            end

            local Char = Value1.char
            local Hum = Value1.hum

            if ClientState.Frozen == true and not Char:GetAttribute( "Downed" ) then
                ClientState.Frozen = Value1.frozenWas
                return
            end
        else
            if os.clock( ) - Value1.t0 >= 1.5 then
                EndRagdoll( true )
                Number = os.clock( ) + 0.4
                return
            end
            if Humanoid:GetState( ) ~= Enum.HumanoidStateType.Physics then
                Humanoid:ChangeState( Enum.HumanoidStateType.Physics )
            end
        end

        return
    end
    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 or Humanoid.SeatPart or Character:GetAttribute( "Downed" ) or os.clock( ) < Number or SpawnShield.Active( Character ) then
        return
    end

    local Find = WorldRefs.Find( "Cars" )

    if not Find then
        return
    end

    local Position = HumanoidRootPart.Position

    for Key, Value in Find:GetChildren( ) do
        local Value1Inner, Value2, Value3 = RefsOf( Value )

        if Value1Inner and Value3 and Value1Inner.AssemblyLinearVelocity.Magnitude >= 12 then
            local Position2 = Position - Value1Inner.Position

            if Position2.Magnitude > 0.01 and Position2:Dot( Value1Inner.AssemblyLinearVelocity ) > 0 then
                local Min = math.min( math.max( Value1Inner.AssemblyLinearVelocity:Dot( Position2.Unit ), 0 ) * Argument1, 6 )
                local CFrame = Value2.CFrame
                local Size = Value2.Size
                local PointToObjectSpace = CFrame:PointToObjectSpace( Position )

                if ( PointToObjectSpace - PointToObjectSpace:Max( -Size / 2 ):Min( Size / 2 ) ).Magnitude <= Min + 1.6 then
                    if not CrewCar( Value ) then
                        StartRagdoll( Character, Humanoid, Value, Value1Inner.AssemblyLinearVelocity )
                        return
                    end
                end
            end
        end
    end

    return
end )
