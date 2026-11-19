-- StarterPlayer.PlayerModule.CameraModule.LegacyCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

require( script.Parent:WaitForChild( "CameraUtils" ) )
local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local Players = game:GetService( "Players" )
local BaseCamera = require( script.Parent:WaitForChild( "BaseCamera" ) )
local Self = setmetatable( { }, BaseCamera )
Self.__index = Self
function Self.new()
    local New = setmetatable( BaseCamera.new( ), Self )
    New.cameraType = Enum.CameraType.Fixed
    New.lastUpdate = tick( )
    New.lastDistanceToSubject = nil
    return New
end
function Self.GetModuleName( Argument1 )
    return "LegacyCamera"
end
function Self.Update( Self, Argument2 )
    if not Self.cameraType then
        return nil, nil
    end

    local LastUpdate = tick( )
    local Tick = LastUpdate - Self.lastUpdate
    local CurrentCamera = workspace.CurrentCamera
    local CFrame2 = CurrentCamera.CFrame
    local Focus = CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer
    local Rotation = CameraInput.getRotation( Argument2 )

    if Self.lastUpdate == nil or Tick > 1 then
        Self.lastDistanceToSubject = nil
    end

    local SubjectPosition = Self:GetSubjectPosition( )

    if Self.cameraType == Enum.CameraType.Fixed then
        if not SubjectPosition or not LocalPlayer or not CurrentCamera then
            Self.lastUpdate = LastUpdate
            return CFrame2, Focus
        end

        local CameraToSubjectDistance = Self:GetCameraToSubjectDistance( )
        local CalculateNewLookVectorFromArg = Self:CalculateNewLookVectorFromArg( nil, Rotation )
        Focus = CurrentCamera.Focus
        CFrame2 = CFrame.new( CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + CameraToSubjectDistance * CalculateNewLookVectorFromArg )
        Self.lastUpdate = LastUpdate
        return CFrame2, Focus
    end
    if Self.cameraType == Enum.CameraType.Attach then
        local SubjectCFrame = Self:GetSubjectCFrame( )
        local ToEulerAnglesYXZ = CurrentCamera.CFrame:ToEulerAnglesYXZ( )
        local _, ToEulerAnglesYXZ2 = SubjectCFrame:ToEulerAnglesYXZ( )
        local Clamp = math.clamp( ToEulerAnglesYXZ - Rotation.Y, -1.3962634015954636, 1.3962634015954636 )
        local CFrame3 = CFrame.new( SubjectCFrame.Position ) * CFrame.fromEulerAnglesYXZ( Clamp, ToEulerAnglesYXZ2, 0 )
        CFrame2 = CFrame3 * CFrame.new( 0, 0, Self:StepZoom( Argument2 ) )
        Focus = CFrame3
        Self.lastUpdate = LastUpdate
        return CFrame2, Focus
    end
    if Self.cameraType ~= Enum.CameraType.Watch then
        return CurrentCamera.CFrame, CurrentCamera.Focus
    end
    if not SubjectPosition or not LocalPlayer or not CurrentCamera then
        Self.lastUpdate = LastUpdate
        return CFrame2, Focus
    end
    if SubjectPosition == CurrentCamera.CFrame.Position then
        warn( "Camera cannot watch subject in same position as itself" )
        return CurrentCamera.CFrame, CurrentCamera.Focus
    end

    local Unit
    local Humanoid = Self:GetHumanoid( )

    if not Humanoid or not Humanoid.RootPart then
        Unit = nil
    else
        local SubjectPosition2 = SubjectPosition - CurrentCamera.CFrame.Position
        Unit = SubjectPosition2.unit

        if Self.lastDistanceToSubject and Self.lastDistanceToSubject == Self:GetCameraToSubjectDistance( ) then
            Self:SetCameraToSubjectDistance( SubjectPosition2.magnitude )
        end
    end

    local LastDistanceToSubject = Self:GetCameraToSubjectDistance( )
    local CalculateNewLookVectorFromArg2 = Self:CalculateNewLookVectorFromArg( Unit, Rotation )
    Focus = CFrame.new( SubjectPosition )
    CFrame2 = CFrame.new( SubjectPosition - LastDistanceToSubject * CalculateNewLookVectorFromArg2, SubjectPosition )
    Self.lastDistanceToSubject = LastDistanceToSubject
    Self.lastUpdate = LastUpdate
    return CFrame2, Focus
end
return Self
