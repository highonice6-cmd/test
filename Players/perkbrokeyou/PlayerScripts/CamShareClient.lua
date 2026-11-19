-- Players.perkbrokeyou.PlayerScripts.CamShareClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local LocalPlayer = Players.LocalPlayer
local CamShare = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "CamShare" )
local Number = 0
local Number2 = 0
local Number3 = -math.huge
local Value1 = nil
local Number4 = 0
local CollectionService = game:GetService( "CollectionService" )
local IsStudio = RunService:IsStudio( )
local Value2 = nil
local Value3 = nil

local function Consider( Object, Argument2, LookVector, Argument4 )
    local Head = Object:FindFirstChild( "Head" )

    if not Head then
        return Argument4
    end

    local Position = Head.Position - Argument2
    local Magnitude = Position.Magnitude

    if Magnitude < 2 or Magnitude > 1000 then
        return Argument4
    end

    local Dot = LookVector:Dot( Position ) / Magnitude

    if Dot >= 0.9902680687415704 then
        if not Argument4 or Argument4.dot < Dot then
            return { c = Object, dot = Dot, p = Head.Position }
        end
    end

    return Argument4
end

RunService:BindToRenderStep( "CamShareView", Enum.RenderPriority.Last.Value, function()
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        Value2 = nil
        Value3 = nil
        return
    end

    local Value1
    local CFrame = CurrentCamera.CFrame
    local Position = CFrame.Position
    local LookVector = CFrame.LookVector
    Value1 = nil

    for Key, Value in Players:GetPlayers( ) do
        if Value ~= LocalPlayer and Value.Character then
            Consider3 = Consider( Value.Character, Position, LookVector, Value1 )
        end
    end
    if IsStudio then
        for Key2, Value2Inner in CollectionService:GetTagged( "GunBot" ) do
            Consider2 = Consider( Value2Inner, Position, LookVector, Value1 )
        end
    end

    local Value3Inner = if Value1 then Value1.c else Value1
    local Value4 = if Value1 then Value1.p else Value1
    Value2 = Value3Inner
    Value3 = Value4
end )

local function FlagsNow()
    local Number

    if Controls.IsGamepad then
        Number = 1
    elseif Controls.TouchMode( ) then
        Number = 2
    else
        Number = 0
    end
    if ClientState.FixedCamera or ClientState.WardrobeOpen or ClientState.WardrobeFocusX then
        Number = Number + 4
    end
    if ClientState.Spectating then
        Number = Number + 64
    end
    if ClientState.Scoped then
        Number = Number + 8
    end
    if ClientState.Aiming then
        Number = Number + 16
    end

    return Number
end

RunService.Heartbeat:Connect( function( Argument1 )
    if Number4 < Argument1 then
        Number4 = Argument1
    end

    local Clock = os.clock( )
    local ShotCount = ClientState.ShotCount or 0

    if ShotCount ~= Number2 then
        Number2 = ShotCount
        Number3 = Clock
    end

    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Flag
    local CFrame = CurrentCamera.CFrame

    if Value1 == nil then
        Flag = false
    elseif math.acos( ( math.clamp( Value1:Dot( CFrame.LookVector ), -1, 1 ) ) ) > 0.006108652381980153 then
        Flag = true
    else
        Flag = false
    end

    local Flag2

    if Flag then
        Flag2 = Flag
    elseif Clock - Number3 < 0.6 then
        Flag2 = true
    else
        Flag2 = false
    end

    local NumberInner
    local Clock2 = Clock - Number
    NumberInner = not Flag2 and 0.05 or 0.016666666666666666

    if Clock2 < NumberInner then
        return
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not HumanoidRootPart then
        return
    end

    local Number2Inner
    local LookVector = CFrame.LookVector
    Number = Clock
    Value1 = LookVector

    if Controls.IsGamepad then
        Number2Inner = 1
    elseif Controls.TouchMode( ) then
        Number2Inner = 2
    else
        Number2Inner = 0
    end
    if ClientState.FixedCamera or ClientState.WardrobeOpen or ClientState.WardrobeFocusX then
        Number2Inner = Number2Inner + 4
    end
    if ClientState.Spectating then
        Number2Inner = Number2Inner + 64
    end
    if ClientState.Scoped then
        Number2Inner = Number2Inner + 8
    end
    if ClientState.Aiming then
        Number2Inner = Number2Inner + 16
    end
    if Number4 > 0.05 then
        Number2Inner = Number2Inner + 32
    end

    Number4 = 0
    local Position = CFrame.Position - HumanoidRootPart.Position
    local Rotation = CFrame.Rotation
    local FieldOfView = CurrentCamera.FieldOfView
    local ServerTimeNow = workspace:GetServerTimeNow( )
    local Position2 = HumanoidRootPart.Position
    CamShare:FireServer( Position, Rotation, FieldOfView, ServerTimeNow, Position2, ClientState.RecoilSum or 0, ShotCount, Number2Inner, Value2, Value3 )
end )
