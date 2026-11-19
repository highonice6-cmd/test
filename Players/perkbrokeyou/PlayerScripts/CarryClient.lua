-- Players.perkbrokeyou.PlayerScripts.CarryClient
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
local UserInputService = game:GetService( "UserInputService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Remotes = ReplicatedStorage:WaitForChild( "Remotes" )
local LocalPlayer = Players.LocalPlayer

local function DropCarried()
    local Character = LocalPlayer.Character

    if Character and Character:GetAttribute( "Carrying" ) then
        local CarryDrop = Remotes:FindFirstChild( "CarryDrop" )

        if CarryDrop then
            CarryDrop:FireServer( )
        end
    end
end

UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if Argument2 then
        return
    end
    if Argument1.KeyCode ~= Enum.KeyCode.F and Argument1.KeyCode ~= Enum.KeyCode.ButtonY then
        return
    end

    local Character = LocalPlayer.Character

    if Character and Character:GetAttribute( "Carrying" ) then
        local CarryDrop = Remotes:FindFirstChild( "CarryDrop" )

        if CarryDrop then
            CarryDrop:FireServer( )
        end
    end
end )
require( ReplicatedStorage:WaitForChild( "Controls" ) ).Pressed:Connect( function( Name, Argument2 )
    if Name == "DropPlayer" and Argument2 then
        local Character = LocalPlayer.Character

        if Character and Character:GetAttribute( "Carrying" ) then
            local CarryDrop = Remotes:FindFirstChild( "CarryDrop" )

            if CarryDrop then
                CarryDrop:FireServer( )
            end
        end
    end
end )
local Folder = Instance.new( "Folder" )
Folder.Name = "CarryVisuals"
Folder.Parent = workspace
local CarryVisuals = { }
ClientState.CarryVisuals = CarryVisuals
local Table = {
    "LuaSourceContainer",
    "ProximityPrompt",
    "BillboardGui",
    "Sound",
    "ForceField",
    "AlignPosition",
    "AlignOrientation",
    "Tool"
}
local Table2 = {
    WaistBallSocket = { 90, -90, 90 },
    NeckBallSocket = { 70, -70, 70 },
    LeftHipBallSocket = { 90, -90, 90 },
    RightHipBallSocket = { 90, -90, 90 },
    LeftShoulderBallSocket = { 120, -90, 90 },
    RightShoulderBallSocket = { 120, -90, 90 }
}

local function SetHidden( VisualName, Argument2 )
    local LocalTransparencyModifier = not Argument2 and 0 or 1

    for Key, Value in VisualName:GetDescendants( ) do
        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
            if Value.LocalTransparencyModifier ~= LocalTransparencyModifier then
                Value.LocalTransparencyModifier = LocalTransparencyModifier
            end
        end
    end
end

local function MakeVisual( Object )
    local CarryAlignPosition
    local LowerTorso = Object:FindFirstChild( "LowerTorso" )

    if LowerTorso then
        CarryAlignPosition = LowerTorso:FindFirstChild( "CarryAlignPosition" )
    else
        CarryAlignPosition = LowerTorso
    end

    local Attachment1 = if CarryAlignPosition then CarryAlignPosition.Attachment1 else CarryAlignPosition

    if not Attachment1 or not Attachment1.Parent then
        return nil
    end

    local Archivable = Object.Archivable
    Object.Archivable = true
    local Success, Result = pcall( Object.Clone, Object )
    Object.Archivable = Archivable

    if not Success or not Result then
        return nil
    end

    Result.Name = Object.Name .. "_Porte"

    for Value in Result:GetAttributes( ) do
        Result:SetAttribute( Value, nil )
    end
    for Key, Value2 in Result:GetDescendants( ) do
        local Flag
        local IsA = Value2:IsA( "Attachment" )

        if IsA then
            if Value2.Name:sub( 1, 5 ) == "Carry" then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = IsA
        end

        local Value1 = nil

        for Key2, Value3 in Table, nil, nil do
            if Value2:IsA( Value3 ) then
                Flag = true
                break
            end
        end
        if Flag then
            Value2:Destroy( )
        elseif Value2:IsA( "BasePart" ) then
            Value2.Anchored = false
            Value2.CanCollide = false
            Value2.CanQuery = false
            Value2.CanTouch = false
            Value2.LocalTransparencyModifier = 0
        elseif Value2:IsA( "Decal" ) then
            Value2.LocalTransparencyModifier = 0
        elseif Value2:IsA( "BallSocketConstraint" ) then
            Value2.Enabled = true
        elseif Value2:IsA( "AnimationConstraint" ) and Value2.Name ~= "Root" then
            Value2.Enabled = false
        end
    end

    local Humanoid = Result:FindFirstChildOfClass( "Humanoid" )

    if Humanoid then
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        Humanoid.PlatformStand = true
        pcall( function()
            Humanoid.EvaluateStateMachine = false
        end )
    end

    local Parent = Result:FindFirstChild( "LowerTorso" )

    if not Parent then
        Result:Destroy( )
        return nil
    end

    local Attachment0 = Instance.new( "Attachment" )
    Attachment0.Parent = Parent
    local AlignPosition = Instance.new( "AlignPosition" )
    AlignPosition.Attachment0 = Attachment0
    AlignPosition.Attachment1 = Attachment1
    AlignPosition.RigidityEnabled = true
    AlignPosition.ReactionForceEnabled = false
    AlignPosition.Parent = Parent
    local AlignOrientation = Instance.new( "AlignOrientation" )
    AlignOrientation.Attachment0 = Attachment0
    AlignOrientation.Attachment1 = Attachment1
    AlignOrientation.RigidityEnabled = true
    AlignOrientation.ReactionTorqueEnabled = false
    AlignOrientation.Parent = Parent
    Result.Parent = Folder

    if Humanoid then
        Humanoid:ChangeState( Enum.HumanoidStateType.Physics )
    end

    return {
        model = Result,
        root = Result:FindFirstChild( "HumanoidRootPart" ),
        hum = Humanoid
    }
end

local function Loosen( Argument1 )
    if not Argument1.sockets then
        Argument1.sockets = { }

        for Key, Value in Argument1.model:GetDescendants( ) do
            if Value:IsA( "BallSocketConstraint" ) and Table2[ Value.Name ] then
                local Sockets = Argument1.sockets
                Sockets[ Value ] = Table2[ Value.Name ]
            end
        end
    end

    local Value1
    local Sockets2 = Argument1.sockets
    Value1 = nil

    for Key2, Value2 in Sockets2, nil, nil do
        if Key2.UpperAngle ~= Value2[ 1 ] then
            Key2.UpperAngle = Value2[ 1 ]
        end
        if Key2.TwistLowerAngle ~= Value2[ 2 ] then
            Key2.TwistLowerAngle = Value2[ 2 ]
        end
        if Key2.TwistUpperAngle ~= Value2[ 3 ] then
            Key2.TwistUpperAngle = Value2[ 3 ]
        end
        if not Key2.Enabled then
            Key2.Enabled = true
        end
    end
end

local function DropVisual( VisualName )
    local Entry = CarryVisuals[ VisualName ]

    if Entry then
        CarryVisuals[ VisualName ] = nil
        Entry.model:Destroy( )
        SetHidden( VisualName, false )
        return
    end
    return
end

local CharFlags = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "CharFlags" ) )
local Set = CharFlags.Set( "CarriedBy" )
local Set2 = CharFlags.Set( "Downed" )
local Table3 = { }
RunService.RenderStepped:Connect( function()
    local Character = LocalPlayer.Character

    if Character then
        Character:FindFirstChildOfClass( "Humanoid" )
    end

    local Flag

    if Character == nil then
        Flag = false
    elseif Character:GetAttribute( "Carrying" ) == true then
        Flag = true
    else
        Flag = false
    end

    local Carrying

    if Flag then
        local Value1 = nil

        for Value in Set, nil, nil do
            if Value:GetAttribute( "CarriedBy" ) == LocalPlayer.UserId then
                Carrying = Value
                break
            end

            Carrying = nil
        end
    else
        Carrying = nil
    end

    ClientState.Carrying = Carrying

    if Carrying then
        local Humanoid = Carrying:FindFirstChildOfClass( "Humanoid" )

        if Humanoid and Humanoid.Health > 0 and Humanoid:GetState( ) ~= Enum.HumanoidStateType.Physics then
            Humanoid:ChangeState( Enum.HumanoidStateType.Physics )
        end
        for Key, Value2 in Carrying:GetDescendants( ) do
            if Value2:IsA( "BasePart" ) and Value2.CanCollide then
                Value2.CanCollide = false
            end
        end
    end

    local Value3
    table.clear( Table3 )
    Value3 = nil

    for Value4 in Set, nil, nil do
        local CarriedBy = Value4:GetAttribute( "CarriedBy" )

        if CarriedBy ~= nil and CarriedBy ~= LocalPlayer.UserId then
            Table3[ Value4 ] = true

            if not CarryVisuals[ Value4 ] then
                CarryVisuals[ Value4 ] = MakeVisual( Value4 )
            end
            if CarryVisuals[ Value4 ] then
                SetHidden( Value4, true )
                local Hum = CarryVisuals[ Value4 ].hum

                if Hum and Hum:GetState( ) ~= Enum.HumanoidStateType.Physics then
                    Hum:ChangeState( Enum.HumanoidStateType.Physics )
                end

                Loosen( CarryVisuals[ Value4 ] )
            end
        end
    end

    local Value5 = nil

    for Value6 in CarryVisuals, nil, nil do
        if not Table3[ Value6 ] then
            local Entry = CarryVisuals[ Value6 ]

            if Entry then
                CarryVisuals[ Value6 ] = nil
                Entry.model:Destroy( )
                SetHidden( Value6, false )
            end
        end
    end

    local Character2 = if Character then CarryVisuals[ Character ] else Character
    local CarryVisualRoot = Character2 and Character2.root or nil
    local Value7
    ClientState.CarryVisualRoot = CarryVisualRoot
    Value7 = nil

    for Value8 in Set2, nil, nil do
        local HumanoidRootPart
        local UpperTorso = Value8:FindFirstChild( "UpperTorso" )

        if UpperTorso then
            HumanoidRootPart = UpperTorso
        else
            HumanoidRootPart = Value8:FindFirstChild( "HumanoidRootPart" )
        end

        local CarryPrompt

        if HumanoidRootPart then
            CarryPrompt = HumanoidRootPart:FindFirstChild( "CarryPrompt" )
        else
            CarryPrompt = HumanoidRootPart
        end
        if CarryPrompt then
            local Enabled

            if Value8 == Character then
                Enabled = false
            else
                local NotFlag = not Flag

                if NotFlag then
                    if Value8:GetAttribute( "Downed" ) == true then
                        if Value8:GetAttribute( "CarriedBy" ) == nil then
                            if Character == nil then
                                Enabled = false
                            elseif Character:GetAttribute( "Downed" ) == true then
                                Enabled = false
                            else
                                Enabled = true
                            end
                        else
                            Enabled = false
                        end
                    else
                        Enabled = false
                    end
                else
                    Enabled = NotFlag
                end
            end
            if CarryPrompt.Enabled ~= Enabled then
                CarryPrompt.Enabled = Enabled
            end
        end
    end
end )
