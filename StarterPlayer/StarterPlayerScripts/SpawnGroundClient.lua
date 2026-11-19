-- StarterPlayer.StarterPlayerScripts.SpawnGroundClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local LocalPlayer = Players.LocalPlayer
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.IgnoreWater = true
RaycastParams2.RespectCanCollide = true

local function RefFloor( Object, HumanoidRootPart )
    local SpawnFloor = Object:GetAttribute( "SpawnFloor" )

    if typeof( SpawnFloor ) ~= "Vector3" then
        return nil
    end

    local Position = HumanoidRootPart.Position

    if Vector2.new( Position.X - SpawnFloor.X, Position.Z - SpawnFloor.Z ).Magnitude > 4 or Position.Y < SpawnFloor.Y or Position.Y - SpawnFloor.Y > 12 then
        return nil
    end
    return SpawnFloor.Y
end

local function ArrivalFloorY( Object, Argument2 )
    local SpawnFloor = Object:GetAttribute( "SpawnFloor" )

    if typeof( SpawnFloor ) ~= "Vector3" then
        return nil
    end

    local Position = Argument2.Position

    if Vector2.new( Position.X - SpawnFloor.X, Position.Z - SpawnFloor.Z ).Magnitude > 4 then
        return nil
    end
    return SpawnFloor.Y
end

local Table = { }
local Number = 0

local function NoteFloor( Humanoid, HumanoidRootPart, Clock )
    if Clock - Number < 0.2 or Humanoid.FloorMaterial == Enum.Material.Air then
        return
    end

    Number = Clock
    local Position = HumanoidRootPart.Position
    table.insert( Table, {
        y = Position.Y - ( Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2 ),
        x = Position.X,
        z = Position.Z,
        t = Clock
    } )

    while Table[ 1 ] do
        if not ( Clock - Table[ 1 ].t > 15 ) then
            break
        end

        table.remove( Table, 1 )
    end
end

local function StoodOn( Argument1, Position, Argument3 )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        if Argument3 - Value.t <= 15 and math.abs( Value.y - Argument1 ) <= 1 then
            if Vector2.new( Value.x - Position.X, Value.z - Position.Z ).Magnitude <= 16 then
                return true
            end
        end
    end

    return false
end

local function GroundUnder( Object, HumanoidRootPart )
    RaycastParams2.FilterDescendantsInstances = { Object, workspace.CurrentCamera, workspace:FindFirstChild( "FX" ) }
    RaycastParams2.CollisionGroup = HumanoidRootPart.CollisionGroup
    local Raycast = workspace:Raycast( HumanoidRootPart.Position, Vector3.new( 0, -12, 0 ), RaycastParams2 )

    if not Raycast then
        return false
    end

    local Flag
    local RefFloor2 = RefFloor( Object, HumanoidRootPart )

    if RefFloor2 == nil then
        Flag = true
    else
        local Y = Raycast.Position.Y

        if RefFloor2 - 0.5 <= Y then
            Flag = true
        else
            Flag = false
        end
    end

    return Flag
end

local Table2 = {
    [ Enum.HumanoidStateType.Climbing ] = true,
    [ Enum.HumanoidStateType.Swimming ] = true,
    [ Enum.HumanoidStateType.Seated ] = true,
    [ Enum.HumanoidStateType.Physics ] = true,
    [ Enum.HumanoidStateType.Ragdoll ] = true,
    [ Enum.HumanoidStateType.FallingDown ] = true,
    [ Enum.HumanoidStateType.GettingUp ] = true,
    [ Enum.HumanoidStateType.PlatformStanding ] = true,
    [ Enum.HumanoidStateType.Dead ] = true
}
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.FilterType = Enum.RaycastFilterType.Include
RaycastParams3.IgnoreWater = true
local Value1 = nil

local function CheckEmbedded( Character, Humanoid, Part, Clock, Argument5 )
    if Humanoid.PlatformStand or Table2[ Humanoid:GetState( ) ] or math.abs( Part.AssemblyLinearVelocity.Y ) > 2 then
        Value1 = nil
        return
    end

    local Y5
    local HipHeight = Humanoid.HipHeight + Part.Size.Y / 2
    local Position = Part.Position
    local Y = Position.Y - HipHeight
    local Head = Character:FindFirstChild( "Head" )

    if not Head or not Head:IsA( "BasePart" ) then
        Y5 = Position.Y + 1.5
    else
        local Y2 = Head.Position.Y + Head.Size.Y / 2 - 0.1

        if Y2 then
            Y5 = Y2
        else
            Y5 = Position.Y + 1.5
        end
    end

    local Y3
    RaycastParams2.FilterDescendantsInstances = { Character, workspace.CurrentCamera, workspace:FindFirstChild( "FX" ) }
    RaycastParams2.CollisionGroup = Part.CollisionGroup
    local SpawnFloor = Character:GetAttribute( "SpawnFloor" )

    if typeof( SpawnFloor ) == "Vector3" then
        local Position2 = Part.Position

        if Vector2.new( Position2.X - SpawnFloor.X, Position2.Z - SpawnFloor.Z ).Magnitude > 4 then
            Y3 = nil
        else
            Y3 = SpawnFloor.Y
        end
    else
        Y3 = nil
    end

    local Torso

    local function IsFloor( Argument1 )
        local Flag

        if Y3 == nil or not ( math.abs( Argument1 - Y3 ) <= 1 ) then
            Flag = StoodOn( Argument1, Position, Clock )
        else
            Flag = true
        end

        return Flag
    end

    local UpperTorso = Character:FindFirstChild( "UpperTorso" )

    if UpperTorso then
        Torso = UpperTorso
    else
        Torso = Character:FindFirstChild( "Torso" )
    end

    local Y8

    if not Torso or not Torso:IsA( "BasePart" ) then
        Y8 = Position.Y + 0.6
    else
        local Y4 = Torso.Position.Y + Torso.Size.Y / 2 - 0.1

        if Y4 then
            Y8 = Y4
        else
            Y8 = Position.Y + 0.6
        end
    end

    local Raycast
    local IsMissing = not Argument5

    if IsMissing then
        Raycast = workspace:Raycast( Position, Vector3.new( 0, -( HipHeight + 2 ), 0 ), RaycastParams2 )
    else
        Raycast = IsMissing
    end

    local Y7

    if not Raycast or not ( HipHeight - ( Position.Y - Raycast.Position.Y ) >= 0.75 ) then
        Y7 = nil
    else
        local Raycast2 = workspace:Raycast( Position, Vector3.new( 0, math.max( Y5 - Position.Y, 0 ) + 1, 0 ), RaycastParams2 )

        if not Raycast2 or not Raycast2.Instance.Anchored or not ( Raycast2.Normal.Y < -0.7 ) then
            Y7 = nil
        else
            RaycastParams3.FilterDescendantsInstances = { Raycast2.Instance }
            local Raycast3 = workspace:Raycast( Raycast2.Position + Vector3.new( 0, 6, 0 ), Vector3.new( 0, -6, 0 ), RaycastParams3 )

            if not Raycast3 or not ( Raycast3.Normal.Y > 0.7 ) then
                Y7 = nil
            else
                local Flag
                local Y6 = Raycast3.Position.Y

                if Y3 == nil or not ( math.abs( Y6 - Y3 ) <= 1 ) then
                    Flag = StoodOn( Y6, Position, Clock )
                else
                    Flag = true
                end
                if Flag then
                    Y7 = Raycast3.Position.Y
                else
                    Y7 = nil
                end
            end
        end
    end
    if not Y7 and Y + 0.6 + 0.5 < Y5 then
        local X = Position.X
        local Raycast4 = workspace:Raycast( Vector3.new( X, Y5, Position.Z ), Vector3.new( 0, Y + 0.6 - Y5, 0 ), RaycastParams2 )

        if Raycast4 and Raycast4.Normal.Y > 0.7 and Raycast4.Instance.Anchored then
            if Raycast4.Position.Y <= Y8 then
                Y7 = Raycast4.Position.Y
            else
                local Flag2
                local Y9 = Raycast4.Position.Y

                if Y3 == nil or not ( math.abs( Y9 - Y3 ) <= 1 ) then
                    Flag2 = StoodOn( Y9, Position, Clock )
                else
                    Flag2 = true
                end
                if Flag2 then
                    Y7 = Raycast4.Position.Y
                end
            end
        end
    end
    if not Y7 then
        Value1 = nil
        return
    end

    local Number
    Value1 = Value1 or Clock
    local Captured = Clock - Value1
    Number = not ( Position.Y - 0.25 <= Y7 ) and 0.6 or 0.2

    if Captured < Number then
        return
    end

    Value1 = nil
    local X2 = Position.X
    local Y10 = Y7 + 0.1

    if workspace:Raycast( Vector3.new( X2, Y10, Position.Z ), Vector3.new( 0, HipHeight + 0.5, 0 ), RaycastParams2 ) then
        return
    end
    local AssemblyLinearVelocity = Part.AssemblyLinearVelocity
    Part.CFrame = Part.CFrame + Vector3.new( 0, Y7 + HipHeight + 0.05 - Position.Y, 0 )
    local X3 = AssemblyLinearVelocity.X
    local Max = math.max( AssemblyLinearVelocity.Y, 0 )
    Part.AssemblyLinearVelocity = Vector3.new( X3, Max, AssemblyLinearVelocity.Z )
    Character:SetAttribute( "EmbedRescues", ( Character:GetAttribute( "EmbedRescues" ) or 0 ) + 1 )
    return
end

local function Busy( Self, Humanoid )
    local Flag

    if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    elseif LocalPlayer:GetAttribute( "Onboarding" ) == true then
        Flag = true
    elseif Humanoid.SeatPart == nil then
        if Self:GetAttribute( "CarriedBy" ) == nil then
            if Self:GetAttribute( "Downed" ) == true then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = true
        end
    else
        Flag = true
    end

    return Flag
end

local Value2 = nil

local function Release()
    Value2 = nil

    if Value2 and Value2.root.Parent and Value2.root:GetAttribute( "WaitGround" ) then
        Value2.root:SetAttribute( "WaitGround", nil )

        if Value2.root.Anchored then
            Value2.root.Anchored = false
        end
    end
end

local Value3 = nil
local Value4 = nil
local Number2 = 0
local Number3 = 0
local Number4 = 0
RunService.PreSimulation:Connect( function()
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
    if Value2 and Value2.root ~= HumanoidRootPart then
        Value2 = nil

        if Value2 and Value2.root.Parent and Value2.root:GetAttribute( "WaitGround" ) then
            Value2.root:SetAttribute( "WaitGround", nil )

            if Value2.root.Anchored then
                Value2.root.Anchored = false
            end
        end
    end
    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 then
        Value2 = nil

        if Value2 and Value2.root.Parent and Value2.root:GetAttribute( "WaitGround" ) then
            Value2.root:SetAttribute( "WaitGround", nil )

            if Value2.root.Anchored then
                Value2.root.Anchored = false
            end
        end

        Value3 = nil
        return
    end
    local Clock = os.clock( )

    if HumanoidRootPart == Value3 then
        if not Humanoid.SeatPart and ( HumanoidRootPart.Position - Value4 ).Magnitude > 40 then
            local Clock4 = Clock + 1.5
            local Clock5 = Clock + 15
            Number2 = Clock4
            Number3 = Clock5
        end
    else
        local Clock2 = Clock + 1.5
        local Clock3 = Clock + 15
        Value3 = HumanoidRootPart
        Number2 = Clock2
        Number3 = Clock3
        Value1 = nil
        table.clear( Table )
    end

    Value4 = HumanoidRootPart.Position
    NoteFloor( Humanoid, HumanoidRootPart, Clock )

    if Value2 then
        local Flag

        if Value2.streamedAt == nil then
            Flag = false
        elseif Clock - Value2.streamedAt > 3 then
            Flag = true
        else
            Flag = false
        end
        if Busy( Character, Humanoid ) or GroundUnder( Character, HumanoidRootPart ) or Flag or Clock - Value2.t0 > 30 then
            if Flag then
                Number2 = 0
            end

            Value2 = nil

            if Value2 and Value2.root.Parent and Value2.root:GetAttribute( "WaitGround" ) then
                Value2.root:SetAttribute( "WaitGround", nil )

                if Value2.root.Anchored then
                    Value2.root.Anchored = false
                end
            end

            Number3 = Clock + 15
            Value1 = nil
        end

        return
    end
    if Clock < Number2 and not HumanoidRootPart.Anchored and not Busy( Character, Humanoid ) then
        if GroundUnder( Character, HumanoidRootPart ) then
            Number2 = 0
        elseif HumanoidRootPart.AssemblyLinearVelocity.Y <= 1 then
            local Ref
            local TableInner = { root = HumanoidRootPart, t0 = Clock }
            Ref = RefFloor( Character, HumanoidRootPart ) ~= nil and true or false
            TableInner.ref = Ref
            Value2 = TableInner
            HumanoidRootPart:SetAttribute( "WaitGround", true )
            HumanoidRootPart.Anchored = true
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
            task.spawn( function()
                local RequestStreamAroundAsync = LocalPlayer.RequestStreamAroundAsync
                pcall( RequestStreamAroundAsync, LocalPlayer, HumanoidRootPart.Position, 30 )

                if Value2 == TableInner then
                    if TableInner.ref then
                        TableInner.streamedAt = os.clock( )
                        return
                    end

                    Number2 = 0
                    Value2 = nil

                    if Value2 and Value2.root.Parent and Value2.root:GetAttribute( "WaitGround" ) then
                        Value2.root:SetAttribute( "WaitGround", nil )

                        if Value2.root.Anchored then
                            Value2.root.Anchored = false
                        end
                    end

                    Number3 = os.clock( ) + 15
                    Value1 = nil
                end
            end )
        end
    end
    if Clock < Number3 and not HumanoidRootPart.Anchored and not Busy( Character, Humanoid ) then
        CheckEmbedded( Character, Humanoid, HumanoidRootPart, Clock )
        return
    end
    if Number4 <= Clock and not HumanoidRootPart.Anchored and not Busy( Character, Humanoid ) then
        Number4 = Clock + 0.1
        CheckEmbedded( Character, Humanoid, HumanoidRootPart, Clock, true )
    end

    return
end )
