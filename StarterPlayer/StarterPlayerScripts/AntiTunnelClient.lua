-- StarterPlayer.StarterPlayerScripts.AntiTunnelClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local AntiTunnel = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "AntiTunnel" ) )
local LocalPlayer = Players.LocalPlayer
local Value1 = nil
local Table = { "Cars", "FX", "ClientHitboxes", "TrainsLocaux", "Dummies" }
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
RaycastParams2.CollisionGroup = "Default"
local Value2 = nil

local function IsFloor( Argument1 )
    local Anchored2

    if Argument1 then
        local Anchored = Argument1.Instance.Anchored

        if Anchored then
            if Argument1.Normal.Y > 0.5 then
                Anchored2 = true
            else
                Anchored2 = false
            end
        else
            Anchored2 = Anchored
        end
    else
        Anchored2 = Argument1
    end

    return Anchored2
end

local Value3 = nil
local Number = -math.huge

local function Rescue( Model, Humanoid, HumanoidRootPart, Argument4 )
    local Clock = os.clock( )

    if Value3 ~= Model or Clock - Number > 1 then
        local Value1
        Value3 = Model
        Number = Clock
        local FilterDescendantsInstances = { Model, workspace.CurrentCamera }
        Value1 = nil

        for Key, Value in Table, nil, nil do
            local FoundChild = workspace:FindFirstChild( Value )

            if FoundChild then
                table.insert( FilterDescendantsInstances, FoundChild )
            end
        end

        RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    end

    local Position = HumanoidRootPart.Position

    if Value2 and Value2.root == HumanoidRootPart and Clock - Value2.t <= 1 and Position.Y < Value2.y - 1 and Vector2.new( Position.X - Value2.x, Position.Z - Value2.z ).Magnitude <= 12 then
        local Raycast2
        local X = Position.X
        local Y = Value2.y + 3
        local Vector32 = Vector3.new( X, Y, Position.Z )
        local Raycast = workspace:Raycast( Vector32, Vector3.new( 0, Position.Y - Vector32.Y, 0 ), RaycastParams2 )

        if Raycast then
            local Anchored = Raycast.Instance.Anchored

            if Anchored then
                if Raycast.Normal.Y > 0.5 then
                    Raycast2 = true
                else
                    Raycast2 = false
                end
            else
                Raycast2 = Anchored
            end
        else
            Raycast2 = Raycast
        end
        if Raycast2 and math.abs( Raycast.Position.Y - Value2.y ) < 1.5 then
            local NumberInner = if Argument4 then 1 else Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2
            Model:PivotTo( Model:GetPivot( ) + Vector3.new( 0, Raycast.Position.Y + NumberInner - Position.Y, 0 ) )

            for Key2, Value2Inner in Model:GetDescendants( ) do
                if Value2Inner:IsA( "BasePart" ) and not Value2Inner.Anchored and Value2Inner.AssemblyLinearVelocity.Y < 0 then
                    local X2 = Value2Inner.AssemblyLinearVelocity.X
                    Value2Inner.AssemblyLinearVelocity = Vector3.new( X2, 0, Value2Inner.AssemblyLinearVelocity.Z )
                end
            end

            Value2 = {
                y = Raycast.Position.Y,
                t = Clock,
                x = Position.X,
                z = Position.Z,
                root = HumanoidRootPart
            }
            Model:SetAttribute( "FloorRescues", ( Model:GetAttribute( "FloorRescues" ) or 0 ) + 1 )
            return true
        end
    end

    local Raycast4
    local Raycast3 = workspace:Raycast( Position, Vector3.new( 0, -8, 0 ), RaycastParams2 )

    if Raycast3 then
        local Anchored2 = Raycast3.Instance.Anchored

        if Anchored2 then
            if Raycast3.Normal.Y > 0.5 then
                Raycast4 = true
            else
                Raycast4 = false
            end
        else
            Raycast4 = Anchored2
        end
    else
        Raycast4 = Raycast3
    end
    if Raycast4 then
        Value2 = {
            y = Raycast3.Position.Y,
            t = Clock,
            x = Position.X,
            z = Position.Z,
            root = HumanoidRootPart
        }
    end

    return false
end

RunService.PostSimulation:Connect( function( Argument1 )
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
    if not Humanoid or not HumanoidRootPart or HumanoidRootPart.Anchored or Humanoid.SeatPart or Humanoid.Health <= 0 or Character:GetAttribute( "CarriedBy" ) then
        Value1 = nil
        return
    end
    if not Value1 or Value1.root ~= HumanoidRootPart then
        Value1 = AntiTunnel.Track( Character, HumanoidRootPart )
        return
    end

    local PlatformStand2
    local PlatformStand = Humanoid.PlatformStand

    if PlatformStand then
        PlatformStand2 = PlatformStand
    elseif Humanoid:GetState( ) == Enum.HumanoidStateType.Physics then
        PlatformStand2 = true
    else
        PlatformStand2 = false
    end
    if AntiTunnel.Step( Value1, Argument1, PlatformStand2 ) then
        Character:SetAttribute( "TunnelPushes", ( Character:GetAttribute( "TunnelPushes" ) or 0 ) + 1 )
    end
    if Rescue( Character, Humanoid, HumanoidRootPart, PlatformStand2 ) then
        Value1 = AntiTunnel.Track( Character, HumanoidRootPart )
    end
end )
