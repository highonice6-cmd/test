-- StarterPlayer.PlayerModule.CameraModule.VehicleCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { 0, 15, 30 }
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local BaseCamera = require( script.Parent:WaitForChild( "BaseCamera" ) )
local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local CameraUtils = require( script.Parent:WaitForChild( "CameraUtils" ) )
require( script.Parent:WaitForChild( "ZoomController" ) )
local VehicleCameraCore = require( script:WaitForChild( "VehicleCameraCore" ) )
local VehicleCameraConfig = require( script:WaitForChild( "VehicleCameraConfig" ) )
local LocalPlayer = Players.LocalPlayer
local Map = CameraUtils.map
local Spring = CameraUtils.Spring
local MapClamp = CameraUtils.mapClamp
local SanitizeAngle = CameraUtils.sanitizeAngle

local function PitchVelocity( Argument1, Argument2 )
    return ( math.abs( ( Argument2.XVector:Dot( Argument1 ) ) ) )
end

local function YawVelocity( Argument1, Argument2 )
    return ( math.abs( ( Argument2.YVector:Dot( Argument1 ) ) ) )
end

local Number = 0.016666666666666666
RunService.Stepped:Connect( function( Argument1, Argument2 )
    Number = Argument2
end )
local Self = setmetatable( { }, BaseCamera )
Self.__index = Self
function Self.new()
    local New = setmetatable( BaseCamera.new( ), Self )
    New:Reset( )
    return New
end
function Self.Reset( Self )
    local CurrentCamera2
    Self.vehicleCameraCore = VehicleCameraCore.new( Self:GetSubjectCFrame( ) )
    local New = Spring.new
    Self.pitchSpring = New( 0, -math.rad( VehicleCameraConfig.pitchBaseAngle ) )
    Self.yawSpring = Spring.new( 0, 0 )
    Self.lastPanTick = 0
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera
    local Value1
    assert( CurrentCamera )
    assert( CurrentCamera2 )
    assert( CurrentCamera2:IsA( "VehicleSeat" ) )
    local ConnectedParts = CurrentCamera2:GetConnectedParts( true )
    local LooseBoundingSphere, LooseBoundingSphere2 = CameraUtils.getLooseBoundingSphere( ConnectedParts )
    Self.assemblyRadius = math.max( LooseBoundingSphere2, 5 )
    Self.assemblyOffset = CurrentCamera2.CFrame:Inverse( ) * LooseBoundingSphere
    Self.gamepadZoomLevels = { }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local GamepadZoomLevels = Self.gamepadZoomLevels
        table.insert( GamepadZoomLevels, Value * Self.assemblyRadius / 10 )
    end

    Self:SetCameraToSubjectDistance( Self.gamepadZoomLevels[ #Self.gamepadZoomLevels ] )
end
function Self._StepRotation( Argument1, Argument2, Argument3 )
    local YawSpring = Argument1.yawSpring
    local PitchSpring = Argument1.pitchSpring
    local Rotation = CameraInput.getRotation( Argument2 )
    local Amount = -Rotation.X
    local Amount2 = -Rotation.Y
    YawSpring.pos = SanitizeAngle( YawSpring.pos + Amount )
    PitchSpring.pos = SanitizeAngle( ( math.clamp( PitchSpring.pos + Amount2, -1.3962634015954636, 1.3962634015954636 ) ) )

    if CameraInput.getRotationActivated( ) then
        Argument1.lastPanTick = os.clock( )
    end

    local Goal = -math.rad( VehicleCameraConfig.pitchBaseAngle )
    local Rad = math.rad( VehicleCameraConfig.pitchDeadzoneAngle )
    local Clock = os.clock( ) - Argument1.lastPanTick

    if VehicleCameraConfig.autocorrectDelay < Clock then
        local AutocorrectMinCarSpeed = VehicleCameraConfig.autocorrectMinCarSpeed
        local AutocorrectMaxCarSpeed = VehicleCameraConfig.autocorrectMaxCarSpeed
        local Freq = MapClamp( Argument3, AutocorrectMinCarSpeed, AutocorrectMaxCarSpeed, 0, VehicleCameraConfig.autocorrectResponse )
        YawSpring.freq = Freq
        PitchSpring.freq = Freq

        if YawSpring.freq < 0.001 then
            YawSpring.vel = 0
        end
        if PitchSpring.freq < 0.001 then
            PitchSpring.vel = 0
        end
        if math.abs( ( SanitizeAngle( Goal - PitchSpring.pos ) ) ) <= Rad then
            PitchSpring.goal = PitchSpring.pos
        else
            PitchSpring.goal = Goal
        end
    else
        YawSpring.freq = 0
        YawSpring.vel = 0
        PitchSpring.freq = 0
        PitchSpring.vel = 0
        PitchSpring.goal = Goal
    end

    local Step = PitchSpring:step( Argument2 )
    return CFrame.fromEulerAnglesYXZ( Step, YawSpring:step( Argument2 ), 0 )
end
function Self._GetThirdPersonLocalOffset( Argument1 )
    return Argument1.assemblyOffset + Vector3.new( 0, Argument1.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0 )
end
function Self._GetFirstPersonLocalOffset( Argument1, Argument2 )
    local Character = LocalPlayer.Character

    if not Character or not Character.Parent or not Character:FindFirstChild( "Head" ) or not Character:FindFirstChild( "Head" ):IsA( "BasePart" ) then
        return Argument1:_GetThirdPersonLocalOffset( )
    end
    return Argument2:Inverse( ) * Character:FindFirstChild( "Head" ).Position
end
function Self.Update( Self )
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera
    local VehicleCameraCore = Self.vehicleCameraCore
    assert( CurrentCamera )
    assert( CurrentCamera2 )
    assert( CurrentCamera2:IsA( "VehicleSeat" ) )
    Number = 0
    local SubjectCFrame = Self:GetSubjectCFrame( )
    local SubjectVelocity = Self:GetSubjectVelocity( )
    local SubjectRotVelocity = Self:GetSubjectRotVelocity( )
    local Abs = math.abs( ( SubjectVelocity:Dot( SubjectCFrame.ZVector ) ) )
    local Abs2 = math.abs( ( SubjectCFrame.YVector:Dot( SubjectRotVelocity ) ) )
    local Abs3 = math.abs( ( SubjectCFrame.XVector:Dot( SubjectRotVelocity ) ) )
    local StepZoom = Self:StepZoom( Number )
    local _StepRotation = Self:_StepRotation( Number, Abs )
    local MapClamp2 = MapClamp( StepZoom, 0.5, Self.assemblyRadius, 1, 0 )
    local _GetThirdPersonLocalOffset = Self:_GetThirdPersonLocalOffset( )
    local Lerp = _GetThirdPersonLocalOffset:Lerp( Self:_GetFirstPersonLocalOffset( SubjectCFrame ), MapClamp2 )
    VehicleCameraCore:setTransform( SubjectCFrame )
    local Step = VehicleCameraCore:step( Number, Abs3, Abs2, MapClamp2 )
    local CFrame2 = CFrame.new( SubjectCFrame * Lerp ) * Step * _StepRotation
    return CFrame2 * CFrame.new( 0, 0, StepZoom ), CFrame2
end
return Self
