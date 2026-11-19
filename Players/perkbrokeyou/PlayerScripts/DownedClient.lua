-- Players.perkbrokeyou.PlayerScripts.DownedClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local AntiTunnel = require( ReplicatedStorage:WaitForChild( "AntiTunnel" ) )
local LocalPlayer = Players.LocalPlayer
local DownedCross = game:GetService( "StarterGui" ):WaitForChild( "WorldUI" ):WaitForChild( "DownedCross" )
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Table = { }

local function MakeCross()
    local Adornee = Instance.new( "Part" )
    Adornee.Name = "DownedCrossAnchor"
    Adornee.Anchored = true
    Adornee.CanCollide = false
    Adornee.CanQuery = false
    Adornee.CanTouch = false
    Adornee.Transparency = 1
    Adornee.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
    Adornee.Parent = workspace.CurrentCamera
    local Clone = DownedCross:Clone( )
    Clone.Adornee = Adornee
    Clone.Enabled = true
    Clone.Parent = PlayerGui
    return { anchor = Adornee, gui = Clone }
end

local function BodyCenter( CenterName )
    local CarryVisuals2
    local CarryVisuals = ClientState.CarryVisuals
    CarryVisuals2 = if CarryVisuals then ClientState.CarryVisuals[ CenterName ] else CarryVisuals
    local Model = if not CarryVisuals2 or not CarryVisuals2.model.Parent then CenterName else CarryVisuals2.model
    local UpperTorso = Model:FindFirstChild( "UpperTorso" )
    local LowerTorso = Model:FindFirstChild( "LowerTorso" )

    if UpperTorso and LowerTorso then
        return ( UpperTorso.Position + LowerTorso.Position ) / 2
    end

    local HumanoidRootPart2
    local HumanoidRootPart = Model:FindFirstChild( "HumanoidRootPart" )
    HumanoidRootPart2 = if HumanoidRootPart then HumanoidRootPart.Position else HumanoidRootPart
    return HumanoidRootPart2
end

local Set = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "CharFlags" ) ).Set( "Downed" )
local Table2 = { }
RunService.RenderStepped:Connect( function()
    local Value1
    table.clear( Table2 )
    Value1 = nil

    for Value in Set, nil, nil do
        local Humanoid2
        local Humanoid = Value:FindFirstChildOfClass( "Humanoid" )

        if Humanoid then
            if Humanoid.Health > 0 then
                if Value:GetAttribute( "Downed" ) == true then
                    Humanoid2 = BodyCenter( Value )
                else
                    Humanoid2 = false
                end
            else
                Humanoid2 = false
            end
        else
            Humanoid2 = Humanoid
        end
        if Humanoid2 then
            local Entry2
            Table2[ Value ] = true
            local Entry = Table[ Value ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = MakeCross( )
            end

            Table[ Value ] = Entry2
            local Anchor = Entry2.anchor
            Anchor.CFrame = CFrame.new( Humanoid2 + Vector3.new( 0, 3, 0 ) )
        end
    end

    local Value2 = nil

    for Key, Value3 in Table, nil, nil do
        if not Table2[ Key ] then
            Value3.gui:Destroy( )
            Value3.anchor:Destroy( )
            Table[ Key ] = nil
        end
    end
end )

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

local function StandUp( Character, Humanoid )
    local HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )

    if not HumanoidRootPart then
        return
    end

    local Vector33
    local UpperTorso = Character:FindFirstChild( "UpperTorso" ) or HumanoidRootPart
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

    local Raycast3
    local RaycastParams2 = RaycastParams.new( )
    RaycastParams2.IgnoreWater = true
    RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
    RaycastParams2.FilterDescendantsInstances = { Character, workspace:FindFirstChild( "FX" ), workspace.CurrentCamera }
    RaycastParams2.CollisionGroup = HumanoidRootPart.CollisionGroup
    local Raycast = workspace:Raycast( HumanoidRootPart.Position + Vector3.new( 0, 3, 0 ), Vector3.new( 0, -12, 0 ), RaycastParams2 )

    if Raycast then
        Raycast3 = Raycast
    else
        local Raycast2 = workspace:Raycast( HumanoidRootPart.Position, Vector3.new( 0, 18, 0 ), RaycastParams2 )

        if not Raycast2 or not ( Raycast2.Normal.Y < -0.5 ) then
            Raycast3 = Raycast
        else
            Raycast3 = workspace:Raycast( Raycast2.Position + Vector3.new( 0, 3, 0 ), Vector3.new( 0, -3.5, 0 ), RaycastParams2 ) or Raycast2
        end
    end

    local Y2

    if Raycast3 then
        local Y = Raycast3.Position.Y

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
    local Table = { }

    for Key, Value in Character:GetDescendants( ) do
        if Value:IsA( "Motor6D" ) or Value:IsA( "AnimationConstraint" ) then
            local Part0, Part1, C0, C1

            if Value:IsA( "Motor6D" ) then
                Part0 = Value.Part0
                Part1 = Value.Part1
                C0 = Value.C0
                C1 = Value.C1
            else
                local Attachment0 = Value.Attachment0
                local Attachment1 = Value.Attachment1

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
            if Part0 and Part1 and Part1.Parent == Character then
                table.insert( Table, { Part0, Part1, C0, C1 } )
            end
        end
    end

    local Flag
    local Table2 = { [ HumanoidRootPart ] = true }
    Flag = true

    while Flag do
        local Value1 = nil
        Flag = false

        for Key2, Value2 in Table, nil, nil do
            local Item = Value2[ 1 ]
            local Item2 = Value2[ 2 ]
            local Item3 = Value2[ 3 ]
            local Item4 = Value2[ 4 ]

            if Table2[ Item ] and not Table2[ Item2 ] then
                Item2.CFrame = Item.CFrame * Item3 * Item4:Inverse( )
                Table2[ Item2 ] = true
                Flag = true
            end
        end
    end
    for Key3, Value3 in Character:GetDescendants( ) do
        if Value3:IsA( "BasePart" ) then
            Value3.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
            Value3.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
        end
    end
end

local Flag = false
local Number = 0
local ProximityPromptService = game:GetService( "ProximityPromptService" )
RunService.RenderStepped:Connect( function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Downed

    if Humanoid == nil then
        Downed = false
    elseif Humanoid.Health > 0 then
        if Character:GetAttribute( "Downed" ) == true then
            Downed = true
        else
            Downed = false
        end
    else
        Downed = false
    end
    if Downed ~= Flag then
        Flag = Downed
        ClientState.Downed = Downed
        ClientState.Frozen = Downed
        pcall( function()
            local Enabled
            local NotCaptured = not Downed

            if NotCaptured then
                if ClientState.BetaRollLock == true then
                    Enabled = false
                else
                    Enabled = true
                end
            else
                Enabled = NotCaptured
            end

            ProximityPromptService.Enabled = Enabled
        end )

        if Downed then
            ClientState.Aiming = false
            Humanoid:SetStateEnabled( Enum.HumanoidStateType.Seated, false )
            Humanoid:ChangeState( Enum.HumanoidStateType.Physics )
            Number = 3
            local LastHitDir = Humanoid:GetAttribute( "LastHitDir" )

            if typeof( LastHitDir ) == "Vector3" and LastHitDir.Magnitude > 0 then
                local Value1
                local Table = { "UpperTorso", "LowerTorso", "Head" }
                Value1 = nil

                for Key, Value in Table, nil, nil do
                    local FoundChild = Character:FindFirstChild( Value )

                    if FoundChild then
                        FoundChild:ApplyImpulse( LastHitDir.Unit * FoundChild:GetMass( ) * 12 )
                    end
                end
            end
        elseif Humanoid and Humanoid.Health > 0 then
            Humanoid:SetStateEnabled( Enum.HumanoidStateType.Seated, true )
            Humanoid.PlatformStand = false
            StandUp( Character, Humanoid )
            Humanoid:ChangeState( Enum.HumanoidStateType.Running )
        end
    end
    if not Downed then
        return
    end
    if Number > 0 then
        Number = Number - 1
        AntiTunnel.Unclip( Character )
    end
    if ProximityPromptService.Enabled then
        pcall( function()
            ProximityPromptService.Enabled = false
        end )
    end
    if Character:FindFirstChildOfClass( "Tool" ) then
        Humanoid:UnequipTools( )
    end

    local State = Humanoid:GetState( )

    if State ~= Enum.HumanoidStateType.Physics and State ~= Enum.HumanoidStateType.Dead then
        Humanoid:ChangeState( Enum.HumanoidStateType.Physics )
    end
end )
