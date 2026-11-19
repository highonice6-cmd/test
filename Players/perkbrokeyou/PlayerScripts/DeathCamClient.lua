-- Players.perkbrokeyou.PlayerScripts.DeathCamClient
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
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Killed = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Killed" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude

local function Stop()
    RunService:UnbindFromRenderStep( "DeathCam" )
end

local function SafeEye( Argument1, Argument2, FilterDescendantsInstances )
    local Unit2
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Raycast = workspace:Raycast( Argument1, Argument2, RaycastParams2 )

    if Raycast then
        local Unit = Argument1 + Argument2.Unit * math.max( 1.5, Raycast.Distance - 0.5 )

        if Unit then
            Unit2 = Unit
        else
            Unit2 = Argument1 + Argument2
        end
    else
        Unit2 = Argument1 + Argument2
    end

    return Unit2
end

local function IgnoreList( ... )
    local Value1
    local Table = {
        workspace:FindFirstChild( "FX" ),
        workspace:FindFirstChild( "ClientHitboxes" )
    }
    local Table2 = { ... }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value then
            table.insert( Table, Value )
        end
    end

    return Table
end

local function CorpseView( Object, Unit, Argument3, Argument4 )
    local HumanoidRootPart

    if Object then
        local UpperTorso = Object:FindFirstChild( "UpperTorso" )

        if UpperTorso then
            HumanoidRootPart = UpperTorso
        else
            HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )
        end
    else
        HumanoidRootPart = Object
    end
    if not HumanoidRootPart then
        return nil
    end

    local Position3
    local Position = HumanoidRootPart.Position
    local Lerp = Vector3.new( 0, 5, 6 ):Lerp( Vector3.new( 0, 9, 10 ), Argument3 )
    local Z = Unit * Lerp.Z + Vector3.new( 0, Lerp.Y, 0 )
    RaycastParams2.FilterDescendantsInstances = IgnoreList( Object, Argument4 )
    local Raycast = workspace:Raycast( Position, Z, RaycastParams2 )

    if Raycast then
        local Position2 = Position + Z.Unit * math.max( 1.5, Raycast.Distance - 0.5 )

        if Position2 then
            Position3 = Position2
        else
            Position3 = Position + Z
        end
    else
        Position3 = Position + Z
    end

    return CFrame.lookAt( Position3, Position )
end

local function KillerView( Object, Argument2 )
    local Head

    if Object then
        local Parent = Object.Parent

        if Parent then
            Head = Object:FindFirstChild( "Head" )
        else
            Head = Parent
        end
    else
        Head = Object
    end

    local HumanoidRootPart

    if Object then
        HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Object
    end
    if not Head or not HumanoidRootPart then
        return nil
    end

    local Unit
    local LookVector = HumanoidRootPart.CFrame.LookVector * Vector3.new( 1, 0, 1 )
    Unit = LookVector.Magnitude > 0.01 and LookVector.Unit or Vector3.new( 0, 0, 1 )
    local Position3
    local Position = Head.Position - Vector3.new( 0, 0.15000000596046448, 0 )
    local Unit2 = Unit * 6 + Vector3.new( 0, 0.4000000059604645, 0 )
    RaycastParams2.FilterDescendantsInstances = IgnoreList( Object, Argument2 )
    local Raycast = workspace:Raycast( Position, Unit2, RaycastParams2 )

    if Raycast then
        local Position2 = Position + Unit2.Unit * math.max( 1.5, Raycast.Distance - 0.5 )

        if Position2 then
            Position3 = Position2
        else
            Position3 = Position + Unit2
        end
    else
        Position3 = Position + Unit2
    end

    return CFrame.lookAt( Position3, Position )
end

Killed.OnClientEvent:Connect( function( Argument1, Argument2 )
    local Flag
    RunService:UnbindFromRenderStep( "DeathCam" )
    Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false

    if Flag and not Argument1 then
        return
    end

    local Unit
    local Clock = os.clock( )
    local Character = LocalPlayer.Character
    local LookVector = CurrentCamera.CFrame.LookVector * Vector3.new( -1, 0, -1 )
    Unit = LookVector.Magnitude > 0.01 and LookVector.Unit or Vector3.new( 0, 0, 1 )
    RunService:BindToRenderStep( "DeathCam", Enum.RenderPriority.Camera.Value + 5, function()
        local Humanoid
        local ClockInner = os.clock( ) - Clock
        local CharacterInner = LocalPlayer.Character

        if CharacterInner then
            Humanoid = CharacterInner:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = CharacterInner
        end
        if not ( ClockInner > 15 ) then
            if not Flag or not ( ClockInner > 2.5 ) then
                if not CharacterInner or CharacterInner == Character or CharacterInner == Argument2 or not Humanoid or not ( Humanoid.Health > 0 ) then
                    if ClientState.Spectating then
                        return
                    end

                    local CFrame

                    if ClockInner >= 1.5 or Flag then
                        CFrame = KillerView( Argument1, Argument2 )
                    else
                        CFrame = nil
                    end
                    if not CFrame and Flag then
                        RunService:UnbindFromRenderStep( "DeathCam" )
                        return
                    end
                    if not CFrame then
                        CFrame = CorpseView( Argument2, Unit, 1 - ( 1 - math.clamp( ClockInner / 1.5, 0, 1 ) ) ^ 2, Argument1 )
                    end
                    if CFrame then
                        CurrentCamera.CameraType = Enum.CameraType.Scriptable
                        CurrentCamera.CFrame = CFrame
                        return
                    end
                    return
                end
            end
        end

        RunService:UnbindFromRenderStep( "DeathCam" )
    end )
end )
LocalPlayer.CharacterAdded:Connect( Stop )
