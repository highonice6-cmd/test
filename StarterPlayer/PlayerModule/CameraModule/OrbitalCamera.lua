-- StarterPlayer.PlayerModule.CameraModule.OrbitalCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" ).getUserFlag( "UserFixOrbitalCameraAzimuth" )
require( script.Parent:WaitForChild( "CameraUtils" ) )
local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local Players = game:GetService( "Players" )
local BaseCamera = require( script.Parent:WaitForChild( "BaseCamera" ) )
local Self = setmetatable( { }, BaseCamera )
Self.__index = Self
function Self.new()
    local New = setmetatable( BaseCamera.new( ), Self )
    New.lastUpdate = tick( )
    New.changedSignalConnections = { }
    New.refAzimuthRad = nil
    New.curAzimuthRad = nil
    New.minAzimuthAbsoluteRad = nil
    New.maxAzimuthAbsoluteRad = nil
    New.useAzimuthLimits = nil
    New.curElevationRad = nil
    New.minElevationRad = nil
    New.maxElevationRad = nil
    New.curDistance = nil
    New.minDistance = nil
    New.maxDistance = nil
    New.gamepadDollySpeedMultiplier = 1
    New.lastUserPanCamera = tick( )
    New.externalProperties = { }
    New.externalProperties.InitialDistance = 25
    New.externalProperties.MinDistance = 10
    New.externalProperties.MaxDistance = 100
    New.externalProperties.InitialElevation = 35
    New.externalProperties.MinElevation = 35
    New.externalProperties.MaxElevation = 35
    New.externalProperties.ReferenceAzimuth = -45
    New.externalProperties.CWAzimuthTravel = 90
    New.externalProperties.CCWAzimuthTravel = 90
    New.externalProperties.UseAzimuthLimits = false
    New:LoadNumberValueParameters( )
    return New
end
function Self.LoadOrCreateNumberValueParameter( p1, p2, p3, p4 )
    -- Could not structure function #2
end
function Self.SetAndBoundsCheckAzimuthValues( Values )
    Values.minAzimuthAbsoluteRad = math.rad( Values.externalProperties.ReferenceAzimuth ) - math.abs( ( math.rad( Values.externalProperties.CWAzimuthTravel ) ) )
    Values.maxAzimuthAbsoluteRad = math.rad( Values.externalProperties.ReferenceAzimuth ) + math.abs( ( math.rad( Values.externalProperties.CCWAzimuthTravel ) ) )
    Values.useAzimuthLimits = Values.externalProperties.UseAzimuthLimits

    if Values.useAzimuthLimits then
        local CurAzimuthRad = Values.curAzimuthRad
        Values.curAzimuthRad = math.max( CurAzimuthRad, Values.minAzimuthAbsoluteRad )
        local CurAzimuthRad2 = Values.curAzimuthRad
        Values.curAzimuthRad = math.min( CurAzimuthRad2, Values.maxAzimuthAbsoluteRad )
    end
end
function Self.SetAndBoundsCheckElevationValues( Values )
    local Max = math.max( Values.externalProperties.MinElevation, -80 )
    local Min = math.min( Values.externalProperties.MaxElevation, 80 )
    Values.minElevationRad = math.rad( ( math.min( Max, Min ) ) )
    Values.maxElevationRad = math.rad( ( math.max( Max, Min ) ) )
    local CurElevationRad = Values.curElevationRad
    Values.curElevationRad = math.max( CurElevationRad, Values.minElevationRad )
    local CurElevationRad2 = Values.curElevationRad
    Values.curElevationRad = math.min( CurElevationRad2, Values.maxElevationRad )
end
function Self.SetAndBoundsCheckDistanceValues( Values )
    Values.minDistance = Values.externalProperties.MinDistance
    Values.maxDistance = Values.externalProperties.MaxDistance
    local CurDistance = Values.curDistance
    Values.curDistance = math.max( CurDistance, Values.minDistance )
    local CurDistance2 = Values.curDistance
    Values.curDistance = math.min( CurDistance2, Values.maxDistance )
end
function Self.LoadNumberValueParameters( Self )
    local SetAndBoundsCheckAzimuthValues
    Self:LoadOrCreateNumberValueParameter( "InitialElevation", "NumberValue", nil )
    Self:LoadOrCreateNumberValueParameter( "InitialDistance", "NumberValue", nil )

    if UserFlag then
        SetAndBoundsCheckAzimuthValues = Self.SetAndBoundsCheckAzimuthValues
    else
        SetAndBoundsCheckAzimuthValues = Self.SetAndBoundsCheckAzimuthValue
    end

    Self:LoadOrCreateNumberValueParameter( "ReferenceAzimuth", "NumberValue", SetAndBoundsCheckAzimuthValues )
    Self:LoadOrCreateNumberValueParameter( "CWAzimuthTravel", "NumberValue", Self.SetAndBoundsCheckAzimuthValues )
    Self:LoadOrCreateNumberValueParameter( "CCWAzimuthTravel", "NumberValue", Self.SetAndBoundsCheckAzimuthValues )
    Self:LoadOrCreateNumberValueParameter( "MinElevation", "NumberValue", Self.SetAndBoundsCheckElevationValues )
    Self:LoadOrCreateNumberValueParameter( "MaxElevation", "NumberValue", Self.SetAndBoundsCheckElevationValues )
    Self:LoadOrCreateNumberValueParameter( "MinDistance", "NumberValue", Self.SetAndBoundsCheckDistanceValues )
    Self:LoadOrCreateNumberValueParameter( "MaxDistance", "NumberValue", Self.SetAndBoundsCheckDistanceValues )
    Self:LoadOrCreateNumberValueParameter( "UseAzimuthLimits", "BoolValue", Self.SetAndBoundsCheckAzimuthValues )
    Self.curAzimuthRad = math.rad( Self.externalProperties.ReferenceAzimuth )
    Self.curElevationRad = math.rad( Self.externalProperties.InitialElevation )
    Self.curDistance = Self.externalProperties.InitialDistance
    Self:SetAndBoundsCheckAzimuthValues( )
    Self:SetAndBoundsCheckElevationValues( )
    Self:SetAndBoundsCheckDistanceValues( )
end
function Self.GetModuleName( Argument1 )
    return "OrbitalCamera"
end
function Self.GetCameraToSubjectDistance( Argument1 )
    return Argument1.curDistance
end
function Self.SetCameraToSubjectDistance( Self, Argument2 )
    if Players.LocalPlayer then
        local MinDistance = Self.minDistance
        Self.currentSubjectDistance = math.clamp( Argument2, MinDistance, Self.maxDistance )
        local CurrentSubjectDistance = Self.currentSubjectDistance
        Self.currentSubjectDistance = math.max( CurrentSubjectDistance, Self.FIRST_PERSON_DISTANCE_THRESHOLD )
    end

    Self.inFirstPerson = false
    Self:UpdateMouseBehavior( )
    return Self.currentSubjectDistance
end
function Self.CalculateNewLookVector( Argument1, Argument2, Argument3 )
    local CameraLookVector

    if Argument2 then
        CameraLookVector = Argument2
    else
        CameraLookVector = Argument1:GetCameraLookVector( )
    end

    local Asin = math.asin( CameraLookVector.Y )
    local Y = Argument3.Y
    local Asin2 = Asin - 1.3962634015954636
    local Clamp = math.clamp( Y, Asin2, Asin - -1.3962634015954636 )
    local Vector22 = Vector2.new( Argument3.X, Clamp )
    local CFrame2 = CFrame.new( Vector3.new( 0, 0, 0 ), CameraLookVector )
    return ( CFrame.Angles( 0, -Vector22.X, 0 ) * CFrame2 * CFrame.Angles( -Vector22.Y, 0, 0 ) ).LookVector
end
function Self.Update( Self, Argument2 )
    local Flag
    local LastUpdate = tick( )
    local Tick = LastUpdate - Self.lastUpdate
    Flag = CameraInput.getRotation( Argument2 ) ~= Vector2.new( ) and true or false
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera
    local CFrame2 = CurrentCamera.CFrame
    local Focus = CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera
    local CurrentCamera3 = if CurrentCamera2 then CurrentCamera2:IsA( "VehicleSeat" ) else CurrentCamera2
    local CurrentCamera4 = if CurrentCamera2 then CurrentCamera2:IsA( "SkateboardPlatform" ) else CurrentCamera2

    if Self.lastUpdate == nil or Tick > 1 then
        Self.lastCameraTransform = nil
    end
    if Flag then
        Self.lastUserPanCamera = tick( )
    end

    local SubjectPosition = Self:GetSubjectPosition( )

    if SubjectPosition and LocalPlayer and CurrentCamera then
        if Self.gamepadDollySpeedMultiplier ~= 1 then
            Self:SetCameraToSubjectDistance( Self.currentSubjectDistance * Self.gamepadDollySpeedMultiplier )
        end

        local LastCameraFocus = CFrame.new( SubjectPosition )
        local Rotation = CameraInput.getRotation( Argument2 )
        Self.curAzimuthRad = Self.curAzimuthRad - Rotation.X

        if Self.useAzimuthLimits then
            local CurAzimuthRad = Self.curAzimuthRad
            local MinAzimuthAbsoluteRad = Self.minAzimuthAbsoluteRad
            Self.curAzimuthRad = math.clamp( CurAzimuthRad, MinAzimuthAbsoluteRad, Self.maxAzimuthAbsoluteRad )
        else
            local CurAzimuthRad2

            if Self.curAzimuthRad == 0 then
                CurAzimuthRad2 = 0
            else
                local Sign = math.sign( Self.curAzimuthRad ) * ( math.abs( Self.curAzimuthRad ) % 6.283185307179586 )

                if Sign then
                    CurAzimuthRad2 = Sign
                else
                    CurAzimuthRad2 = 0
                end
            end

            Self.curAzimuthRad = CurAzimuthRad2
        end

        local CurElevationRad = Self.curElevationRad + Rotation.Y
        local MinElevationRad = Self.minElevationRad
        Self.curElevationRad = math.clamp( CurElevationRad, MinElevationRad, Self.maxElevationRad )
        local CurrentSubjectDistance = Self.currentSubjectDistance
        local Amount = -Self.curElevationRad
        local LastCameraTransform = CFrame.new( SubjectPosition + CurrentSubjectDistance * ( CFrame.fromEulerAnglesYXZ( Amount, Self.curAzimuthRad, 0 ) * Vector3.new( 0, 0, 1 ) ), SubjectPosition )
        Self.lastCameraTransform = LastCameraTransform
        Self.lastCameraFocus = LastCameraFocus

        if CurrentCamera3 or CurrentCamera4 then
            if CurrentCamera2:IsA( "BasePart" ) then
                Self.lastSubjectCFrame = CurrentCamera2.CFrame
                CFrame2 = LastCameraTransform
                Focus = LastCameraFocus
            else
                Self.lastSubjectCFrame = nil
                CFrame2 = LastCameraTransform
                Focus = LastCameraFocus
            end
        else
            Self.lastSubjectCFrame = nil
            CFrame2 = LastCameraTransform
            Focus = LastCameraFocus
        end
    end

    Self.lastUpdate = LastUpdate
    return CFrame2, Focus
end
return Self

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.externalProperties[ Upvalue2 ] = Argument1
Upvalue3( Upvalue1 )
]]
