-- StarterPlayer.PlayerModule.CameraModule.VRVehicleCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { 0, 30 }
local VRBaseCamera = require( script.Parent:WaitForChild( "VRBaseCamera" ) )
local CameraUtils = require( script.Parent:WaitForChild( "CameraUtils" ) )
local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local VRService = game:GetService( "VRService" )
local Lighting = game:GetService( "Lighting" )
local LocalPlayer = Players.LocalPlayer
local MapClamp = CameraUtils.mapClamp
local VehicleCameraConfig = require( script.Parent:WaitForChild( "VehicleCamera" ):FindFirstChild( "VehicleCameraConfig" ) )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.IgnoreWater = true

local function YawVelocity( Argument1, Argument2 )
    return ( math.abs( ( Argument2.YVector:Dot( Argument1 ) ) ) )
end

local function ComputeCameraCFrame( Argument1, Argument2, Argument3 )
    local X = Argument2.X
    local Atan2 = math.atan2( X, Argument2.Z )
    return CFrame.new( Argument1.Position + Argument2 * Argument3 ) * CFrame.Angles( 0, Atan2, 0 )
end

local function VrOccludeDisplace( Argument1, Argument2, CameraToSubjectDistance, Argument4 )
    local X = Argument2.X
    local Atan2 = math.atan2( X, Argument2.Z )
    local CFrame2 = CFrame.new( Argument1.Position + Argument2 * CameraToSubjectDistance ) * CFrame.Angles( 0, Atan2, 0 )
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return CFrame2
    end

    local Position = Argument1.Position
    local Position2 = ( CFrame2.Position - Position ) * Vector3.new( 1, 0, 1 )
    local Magnitude = Position2.Magnitude

    if Magnitude < 0.5 then
        return CFrame2
    end

    local FilterDescendantsInstances = { CurrentCamera }

    if Argument4 then
        table.insert( FilterDescendantsInstances, Argument4 )
    end
    if LocalPlayer and LocalPlayer.Character then
        table.insert( FilterDescendantsInstances, LocalPlayer and LocalPlayer.Character )
    end

    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Unit = Position2.Unit
    local Raycast = workspace:Raycast( Position, Position2, RaycastParams2 )

    if Raycast and Raycast.Normal:Dot( Unit ) < 0 then
        local Magnitude2 = ( Raycast.Position - Position ).Magnitude - 0.5

        if Magnitude2 < Magnitude then
            local Max = math.max( Magnitude2, 0.5 )
            return CFrame.new( Argument1.Position + Unit * Max ) * CFrame2.Rotation
        end
    end

    return CFrame2
end

local OverlapParams2 = OverlapParams.new( )
OverlapParams2.FilterType = Enum.RaycastFilterType.Exclude

local function FindObstructions( Argument1, Argument2, Argument3, Argument4 )
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return 0, { }
    end

    local Position = Argument2.Position
    local UserCFrame = VRService:GetUserCFrame( Enum.UserCFrame.Head )
    local HeadScale = CurrentCamera.HeadScale
    local CFrame2 = Argument1 * ( CFrame.new( UserCFrame.Position * HeadScale ) * UserCFrame.Rotation )
    local Position2 = CFrame2.Position - Position
    local Magnitude = Position2.Magnitude

    if Magnitude < 0.5 then
        return 0, { }
    end

    local FilterDescendantsInstances = { CurrentCamera }

    if Argument4 then
        table.insert( FilterDescendantsInstances, Argument4 )
    end
    if LocalPlayer and LocalPlayer.Character then
        table.insert( FilterDescendantsInstances, LocalPlayer and LocalPlayer.Character )
    end

    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Raycast = workspace:Raycast( Position, Position2, RaycastParams2 )

    if Raycast then
        local Magnitude2 = ( Raycast.Position - Position ).Magnitude

        if Magnitude2 < Magnitude then
            local LookVector = CFrame2.LookVector
            local Clamp = math.clamp( ( 1 - -Position2.Unit:Dot( LookVector ) ) / 0.1339745962155613, 0, 1 )
            local Max = math.max( Clamp, 1 - Magnitude2 / Argument3, 0.15 )
            local Position3 = Raycast.Position
            local Position4 = CFrame2.Position
            local Position5 = ( Position3 + Position4 ) / 2
            local Vector32 = Vector3.new( 2, 2, ( Position4 - Position3 ).Magnitude )
            local LookAt = CFrame.lookAt( Position5, Position4 )
            OverlapParams2.FilterDescendantsInstances = FilterDescendantsInstances
            return Max, ( workspace:GetPartBoundsInBox( LookAt, Vector32, OverlapParams2 ) )
        end
    end

    return 0, { }
end

local Number = 0.016666666666666666
local Self = setmetatable( { }, VRBaseCamera )
Self.__index = Self
function Self.new()
    local New = setmetatable( VRBaseCamera.new( ), Self )
    New.skipOcclusion = true
    New:Reset( )

    if New.thirdPersonOptionChanged then
        New.thirdPersonOptionChanged:Disconnect( )
        New.thirdPersonOptionChanged = nil
    end

    RunService.Stepped:Connect( function( Argument1, Argument2 )
        Number = Argument2
    end )
    return New
end
function Self.Reset( Self )
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera
    local VehicleModel
    assert( CurrentCamera, "VRVehicleCamera initialization error" )
    assert( CurrentCamera2 )
    assert( CurrentCamera2:IsA( "VehicleSeat" ) )
    Self.lastOrbitalDir = nil
    Self.wasInFirstPerson = nil
    local ConnectedParts = CurrentCamera2:GetConnectedParts( true )
    table.insert( ConnectedParts, CurrentCamera2 )
    local LooseBoundingSphere, LooseBoundingSphere2 = CameraUtils.getLooseBoundingSphere( ConnectedParts )
    local Model = CurrentCamera2:FindFirstAncestorOfClass( "Model" )
    VehicleModel = if Model then Model else CurrentCamera2.Parent
    local Value1
    Self.vehicleModel = VehicleModel
    Self.assemblyRadius = math.max( LooseBoundingSphere2, 5 )
    Self.assemblyOffset = CurrentCamera2.CFrame:Inverse( ) * LooseBoundingSphere
    Self.gamepadZoomLevels = { }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local GamepadZoomLevels = Self.gamepadZoomLevels
        table.insert( GamepadZoomLevels, Value * Self.headScale * Self.assemblyRadius / 10 )
    end

    Self.lastCameraFocus = nil

    if not Self:IsInFirstPerson( ) then
        Self:SetCameraToSubjectDistance( Self.gamepadZoomLevels[ #Self.gamepadZoomLevels ] )
    end

    Self.needsReset = false
end
function Self._getThirdPersonLocalOffset( Argument1 )
    return Argument1.assemblyOffset + Vector3.new( 0, Argument1.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0 )
end
function Self._getFirstPersonLocalOffset( Argument1, Argument2 )
    local Character = LocalPlayer.Character

    if not Character or not Character.Parent or not Character:FindFirstChild( "Head" ) or not Character:FindFirstChild( "Head" ):IsA( "BasePart" ) then
        return Argument1:_getThirdPersonLocalOffset( )
    end
    return Argument2:Inverse( ) * Character:FindFirstChild( "Head" ).Position
end
function Self._vrOccludeVignette( Self, Argument2, Argument3, Argument4 )
    local VRFade2
    local X = Argument3.X
    local Atan2 = math.atan2( X, Argument3.Z )
    local CFrame2 = CFrame.new( Argument2.Position + Argument3 * Argument4 ) * CFrame.Angles( 0, Atan2, 0 )
    local Value1, LastOccludedParts = FindObstructions( CFrame2, Argument2, Argument4, Self.vehicleModel )
    local VRFade = Lighting:FindFirstChild( "VRFade" )

    if VRFade then
        VRFade2 = VRFade
    else
        local ColorCorrectionEffect = Instance.new( "ColorCorrectionEffect" )
        ColorCorrectionEffect.Name = "VRFade"
        ColorCorrectionEffect.Parent = Lighting
        VRFade2 = ColorCorrectionEffect
    end

    VRFade2.Brightness = -Value1

    if Self.lastOccludedParts then
        local Value2
        local LastOccludedParts2 = Self.lastOccludedParts
        Value2 = nil

        for Key, Value in LastOccludedParts2, nil, nil do
            Value.LocalTransparencyModifier = 0
        end
    end
    if #LastOccludedParts > 0 then
        local Value3 = nil

        for Key2, Value4 in LastOccludedParts, nil, nil do
            Value4.LocalTransparencyModifier = 1
        end

        Self:StartVREdgeBlur( LocalPlayer, true )
    end

    Self.lastOccludedParts = LastOccludedParts
    return CFrame2
end
function Self.Update( Self )
    Number = 0
    Self:UpdateFadeFromBlack( Number )
    Self:UpdateEdgeBlur( LocalPlayer, Number )
    local _updateStepRotation, _updateStepRotation2 = Self:_updateStepRotation( Number )
    return _updateStepRotation, _updateStepRotation2
end
function Self._updateStepRotation( Self, Argument2 )
    local SubjectCFrame = Self:GetSubjectCFrame( )
    local CameraToSubjectDistance = Self:GetCameraToSubjectDistance( )
    local MapClamp2 = MapClamp( CameraToSubjectDistance, 0.5, Self.assemblyRadius, 1, 0 )
    local _getThirdPersonLocalOffset = Self:_getThirdPersonLocalOffset( )
    local CFrame2 = CFrame.new( SubjectCFrame * _getThirdPersonLocalOffset:Lerp( Self:_getFirstPersonLocalOffset( SubjectCFrame ), MapClamp2 ) + Vector3.new( 0, Self:GetCameraHeight( ), 0 ) )

    if Self.needsReset or Self.recentered then
        Self.lastOrbitalDir = nil
        Self.needsReset = false
        Self.recentered = false
    end

    local LastOrbitalDir2
    local LastOrbitalDir = Self.lastOrbitalDir

    if LastOrbitalDir then
        LastOrbitalDir2 = LastOrbitalDir
    else
        LastOrbitalDir2 = ( SubjectCFrame.LookVector * Vector3.new( -1, 0, -1 ) ).Unit
        Self:StartFadeFromBlack( )
    end

    local Flag = ( Self:GetSubjectVelocity( ) * Vector3.new( 1, 0, 1 ) ).Magnitude > 2 and true or false

    if Flag then
        CameraInput.getRotation( Argument2 )
    else
        local GetRotation = Self:getRotation( Argument2 )

        if math.abs( GetRotation ) > 0 then
            LastOrbitalDir2 = ( CFrame.Angles( 0, -GetRotation, 0 ) * CFrame.new( LastOrbitalDir2 ) ).Position.Unit
            Self.lastRotateTime = os.clock( )
        end
    end

    local CFrame3

    if Self:IsInFirstPerson( ) then
        if not Self.wasInFirstPerson or Flag then
            LastOrbitalDir2 = ( SubjectCFrame.LookVector * Vector3.new( -1, 0, -1 ) ).Unit
            Self.wasInFirstPerson = true
        end

        local Amount = -SubjectCFrame.LookVector.X
        local LastVehicleYaw = math.atan2( Amount, -SubjectCFrame.LookVector.Z )

        if Self.lastVehicleYaw then
            local Atan2 = ( LastVehicleYaw - Self.lastVehicleYaw + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793

            if math.abs( Atan2 ) > 0.001 then
                LastOrbitalDir2 = ( CFrame.Angles( 0, Atan2, 0 ) * CFrame.new( LastOrbitalDir2 ) ).Position.Unit
            end
        end

        Self.lastVehicleYaw = LastVehicleYaw
        local X = LastOrbitalDir2.X
        local Atan22 = math.atan2( X, LastOrbitalDir2.Z )
        CFrame3 = CFrame.new( CFrame2.Position + LastOrbitalDir2 * CameraToSubjectDistance ) * CFrame.Angles( 0, Atan22, 0 )
    else
        local LastRotateTime2
        Self.wasInFirstPerson = false
        Self.lastVehicleYaw = nil
        local LastRotateTime = Self.lastRotateTime

        if LastRotateTime then
            if os.clock( ) - Self.lastRotateTime < VehicleCameraConfig.autocorrectDelay then
                LastRotateTime2 = true
            else
                LastRotateTime2 = false
            end
        else
            LastRotateTime2 = LastRotateTime
        end
        if Flag and not LastRotateTime2 then
            local Unit = ( SubjectCFrame.LookVector * Vector3.new( -1, 0, -1 ) ).Unit
            local Acos = math.acos( ( math.clamp( LastOrbitalDir2:Dot( Unit ), -1, 1 ) ) )
            local SubjectRotVelocity = Self:GetSubjectRotVelocity( )
            local Abs = math.abs( ( SubjectCFrame.YVector:Dot( SubjectRotVelocity ) ) )
            LastOrbitalDir2 = LastOrbitalDir2:Lerp( Unit, ( math.min( 0.01 + Acos / 3.141592653589793 * 0.05 + Abs * 0.02, 0.15 ) ) )
        end

        CFrame3 = VrOccludeDisplace( CFrame2, LastOrbitalDir2, CameraToSubjectDistance, Self.vehicleModel )
    end

    Self.lastOrbitalDir = LastOrbitalDir2
    return CFrame3, CFrame3 * CFrame.new( 0, 0, -CameraToSubjectDistance )
end
return Self
