-- StarterPlayer.PlayerModule.CameraModule.ClassicCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Number = 0
local FromOrientation = CFrame.fromOrientation( -0.2617993877991494, 0, 0 )
local UserFlag = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" ).getUserFlag( "UserFixCameraFPError" )
local Players = game:GetService( "Players" )
local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local CameraUtils = require( script.Parent:WaitForChild( "CameraUtils" ) )
local BaseCamera = require( script.Parent:WaitForChild( "BaseCamera" ) )
local Self = setmetatable( { }, BaseCamera )
Self.__index = Self
function Self.new()
    local New = setmetatable( BaseCamera.new( ), Self )
    New.isFollowCamera = false
    New.isCameraToggle = false
    New.lastUpdate = tick( )
    New.cameraToggleSpring = CameraUtils.Spring.new( 5, 0 )
    return New
end
function Self.GetCameraToggleOffset( Argument1, Argument2 )
    if not Argument1.isCameraToggle then
        return ( Vector3.new( ) )
    end

    local CurrentSubjectDistance = Argument1.currentSubjectDistance

    if CameraInput.getTogglePan( ) then
        local CameraToggleSpring = Argument1.cameraToggleSpring
        local Map = CameraUtils.map
        CameraToggleSpring.goal = math.clamp( Map( CurrentSubjectDistance, 0.5, Argument1.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1 ), 0, 1 )
    else
        Argument1.cameraToggleSpring.goal = 0
    end

    local Clamp = math.clamp( CameraUtils.map( CurrentSubjectDistance, 0.5, 64, 0, 1 ), 0, 1 ) + 1
    return ( Vector3.new( 0, Argument1.cameraToggleSpring:step( Argument2 ) * Clamp, 0 ) )
end
function Self.SetCameraMovementMode( Argument1, Argument2 )
    local IsFollowCamera
    BaseCamera.SetCameraMovementMode( Argument1, Argument2 )
    IsFollowCamera = Argument2 == Enum.ComputerCameraMovementMode.Follow and true or false
    local IsCameraToggle
    Argument1.isFollowCamera = IsFollowCamera
    IsCameraToggle = Argument2 == Enum.ComputerCameraMovementMode.CameraToggle and true or false
    Argument1.isCameraToggle = IsCameraToggle
end
function Self.Update( Self, Amount )
    local LookVector
    local LastUpdate = tick( )
    local CurrentCamera = workspace.CurrentCamera
    local CFrame2 = CurrentCamera.CFrame
    local Focus = CurrentCamera.Focus

    if Self.resetCameraAngle then
        local HumanoidRootPart = Self:GetHumanoidRootPart( )

        if HumanoidRootPart then
            LookVector = ( HumanoidRootPart.CFrame * FromOrientation ).lookVector
        else
            LookVector = FromOrientation.lookVector
        end

        Self.resetCameraAngle = false
    else
        LookVector = nil
    end

    local IsA
    local LocalPlayer = Players.LocalPlayer
    local Humanoid = Self:GetHumanoid( )
    local CameraSubject = CurrentCamera.CameraSubject

    if CameraSubject then
        IsA = CameraSubject:IsA( "VehicleSeat" )
    else
        IsA = CameraSubject
    end

    local IsA2

    if CameraSubject then
        IsA2 = CameraSubject:IsA( "SkateboardPlatform" )
    else
        IsA2 = CameraSubject
    end

    local Humanoid2

    if Humanoid then
        if Humanoid:GetState( ) == Enum.HumanoidStateType.Climbing then
            Humanoid2 = true
        else
            Humanoid2 = false
        end
    else
        Humanoid2 = Humanoid
    end
    if Self.lastUpdate == nil or Amount > 1 then
        Self.lastCameraTransform = nil
    end

    local Rotation = CameraInput.getRotation( Amount )
    Self:StepZoom( Amount )
    local CameraHeight = Self:GetCameraHeight( )

    if Rotation ~= Vector2.new( ) then
        Number = 0
        Self.lastUserPanCamera = tick( )
    end

    local Flag2 = LastUpdate - Self.lastUserPanCamera < 2 and true or false
    local SubjectPosition = Self:GetSubjectPosition( )

    if SubjectPosition and LocalPlayer and CurrentCamera then
        local CameraToSubjectDistance2
        local CameraToSubjectDistance = Self:GetCameraToSubjectDistance( )
        CameraToSubjectDistance2 = if CameraToSubjectDistance < 0.5 then 0.5 else CameraToSubjectDistance
        local SubjectPosition2, Rotation2

        if not Self:GetIsMouseLocked( ) or Self:IsInFirstPerson( ) then
            local Flag = Rotation ~= Vector2.new( ) and true or false

            if Flag or not Self.lastCameraTransform then
                SubjectPosition2 = SubjectPosition
                Rotation2 = Rotation
            else
                local IsInFirstPerson = Self:IsInFirstPerson( )

                if IsA or IsA2 then
                    if not Self.lastUpdate or not Humanoid or not Humanoid.Torso then
                        if not Self.isFollowCamera or IsInFirstPerson or Flag2 then
                            SubjectPosition2 = SubjectPosition
                            Rotation2 = Rotation
                        else
                            local Amount3 = -( Self.lastCameraTransform.Position - SubjectPosition )
                            local GetAngleBetweenXZVectors2 = CameraUtils.GetAngleBetweenXZVectors
                            local AngleBetweenXZVectors2 = GetAngleBetweenXZVectors2( Amount3, Self:GetCameraLookVector( ) )

                            if not CameraUtils.IsFinite( AngleBetweenXZVectors2 ) or not ( math.abs( AngleBetweenXZVectors2 ) > 0.0001 ) then
                                SubjectPosition2 = SubjectPosition
                                Rotation2 = Rotation
                            else
                                local Abs = math.abs( AngleBetweenXZVectors2 )

                                if 0.4 * Amount < Abs then
                                    SubjectPosition2 = SubjectPosition
                                    Rotation2 = Rotation + Vector2.new( AngleBetweenXZVectors2, 0 )
                                else
                                    SubjectPosition2 = SubjectPosition
                                    Rotation2 = Rotation
                                end
                            end
                        end
                    elseif IsInFirstPerson then
                        if Self.lastSubjectCFrame then
                            if IsA or IsA2 then
                                if CameraSubject:IsA( "BasePart" ) then
                                    local Amount2 = -CameraUtils.GetAngleBetweenXZVectors( Self.lastSubjectCFrame.lookVector, CameraSubject.CFrame.lookVector )

                                    if CameraUtils.IsFinite( Amount2 ) then
                                        Rotation2 = Rotation + Vector2.new( Amount2, 0 )
                                    else
                                        Rotation2 = Rotation
                                    end

                                    Number = 0
                                    SubjectPosition2 = SubjectPosition
                                else
                                    SubjectPosition2 = SubjectPosition
                                    Rotation2 = Rotation
                                end
                            else
                                SubjectPosition2 = SubjectPosition
                                Rotation2 = Rotation
                            end
                        else
                            SubjectPosition2 = SubjectPosition
                            Rotation2 = Rotation
                        end
                    elseif Flag2 then
                        SubjectPosition2 = SubjectPosition
                        Rotation2 = Rotation
                    else
                        local LookVector2 = Humanoid.Torso.CFrame.lookVector
                        Number = math.clamp( Number + 3.839724354387525 * Amount, 0, 4.363323129985824 )
                        local Clamp = math.clamp( Number * Amount, 0, 1 )

                        if Self:IsInFirstPerson( ) then
                            if not Self.isFollowCamera or not Self.isClimbing then
                                Clamp = 1
                            end
                        end

                        local GetAngleBetweenXZVectors = CameraUtils.GetAngleBetweenXZVectors
                        local AngleBetweenXZVectors = GetAngleBetweenXZVectors( LookVector2, Self:GetCameraLookVector( ) )

                        if not CameraUtils.IsFinite( AngleBetweenXZVectors ) or not ( math.abs( AngleBetweenXZVectors ) > 0.0001 ) then
                            SubjectPosition2 = SubjectPosition
                            Rotation2 = Rotation
                        else
                            Rotation2 = Rotation + Vector2.new( AngleBetweenXZVectors * Clamp, 0 )
                            SubjectPosition2 = SubjectPosition
                        end
                    end
                elseif not Self.isFollowCamera or not Humanoid2 then
                    if not Self.isFollowCamera or IsInFirstPerson or Flag2 then
                        SubjectPosition2 = SubjectPosition
                        Rotation2 = Rotation
                    else
                        local Amount3 = -( Self.lastCameraTransform.Position - SubjectPosition )
                        local GetAngleBetweenXZVectors2 = CameraUtils.GetAngleBetweenXZVectors
                        local AngleBetweenXZVectors2 = GetAngleBetweenXZVectors2( Amount3, Self:GetCameraLookVector( ) )

                        if not CameraUtils.IsFinite( AngleBetweenXZVectors2 ) or not ( math.abs( AngleBetweenXZVectors2 ) > 0.0001 ) then
                            SubjectPosition2 = SubjectPosition
                            Rotation2 = Rotation
                        else
                            local Abs = math.abs( AngleBetweenXZVectors2 )

                            if 0.4 * Amount < Abs then
                                SubjectPosition2 = SubjectPosition
                                Rotation2 = Rotation + Vector2.new( AngleBetweenXZVectors2, 0 )
                            else
                                SubjectPosition2 = SubjectPosition
                                Rotation2 = Rotation
                            end
                        end
                    end
                elseif not Self.lastUpdate or not Humanoid or not Humanoid.Torso then
                    if not Self.isFollowCamera or IsInFirstPerson or Flag2 then
                        SubjectPosition2 = SubjectPosition
                        Rotation2 = Rotation
                    else
                        local Amount3 = -( Self.lastCameraTransform.Position - SubjectPosition )
                        local GetAngleBetweenXZVectors2 = CameraUtils.GetAngleBetweenXZVectors
                        local AngleBetweenXZVectors2 = GetAngleBetweenXZVectors2( Amount3, Self:GetCameraLookVector( ) )

                        if not CameraUtils.IsFinite( AngleBetweenXZVectors2 ) or not ( math.abs( AngleBetweenXZVectors2 ) > 0.0001 ) then
                            SubjectPosition2 = SubjectPosition
                            Rotation2 = Rotation
                        else
                            local Abs = math.abs( AngleBetweenXZVectors2 )

                            if 0.4 * Amount < Abs then
                                SubjectPosition2 = SubjectPosition
                                Rotation2 = Rotation + Vector2.new( AngleBetweenXZVectors2, 0 )
                            else
                                SubjectPosition2 = SubjectPosition
                                Rotation2 = Rotation
                            end
                        end
                    end
                elseif IsInFirstPerson then
                    if Self.lastSubjectCFrame then
                        if IsA or IsA2 then
                            if CameraSubject:IsA( "BasePart" ) then
                                local Amount2 = -CameraUtils.GetAngleBetweenXZVectors( Self.lastSubjectCFrame.lookVector, CameraSubject.CFrame.lookVector )

                                if CameraUtils.IsFinite( Amount2 ) then
                                    Rotation2 = Rotation + Vector2.new( Amount2, 0 )
                                else
                                    Rotation2 = Rotation
                                end

                                Number = 0
                                SubjectPosition2 = SubjectPosition
                            else
                                SubjectPosition2 = SubjectPosition
                                Rotation2 = Rotation
                            end
                        else
                            SubjectPosition2 = SubjectPosition
                            Rotation2 = Rotation
                        end
                    else
                        SubjectPosition2 = SubjectPosition
                        Rotation2 = Rotation
                    end
                elseif Flag2 then
                    SubjectPosition2 = SubjectPosition
                    Rotation2 = Rotation
                else
                    local LookVector2 = Humanoid.Torso.CFrame.lookVector
                    Number = math.clamp( Number + 3.839724354387525 * Amount, 0, 4.363323129985824 )
                    local Clamp = math.clamp( Number * Amount, 0, 1 )

                    if Self:IsInFirstPerson( ) then
                        if not Self.isFollowCamera or not Self.isClimbing then
                            Clamp = 1
                        end
                    end

                    local GetAngleBetweenXZVectors = CameraUtils.GetAngleBetweenXZVectors
                    local AngleBetweenXZVectors = GetAngleBetweenXZVectors( LookVector2, Self:GetCameraLookVector( ) )

                    if not CameraUtils.IsFinite( AngleBetweenXZVectors ) or not ( math.abs( AngleBetweenXZVectors ) > 0.0001 ) then
                        SubjectPosition2 = SubjectPosition
                        Rotation2 = Rotation
                    else
                        Rotation2 = Rotation + Vector2.new( AngleBetweenXZVectors * Clamp, 0 )
                        SubjectPosition2 = SubjectPosition
                    end
                end
            end
        else
            local MouseLockOffset2
            local CalculateNewLookCFrameFromArg = Self:CalculateNewLookCFrameFromArg( LookVector, Rotation )
            local MouseLockOffset = Self:GetMouseLockOffset( )
            MouseLockOffset2 = if Humanoid then MouseLockOffset + Humanoid.CameraOffset else MouseLockOffset
            local X = MouseLockOffset2.X * CalculateNewLookCFrameFromArg.RightVector + MouseLockOffset2.Y * CalculateNewLookCFrameFromArg.UpVector + MouseLockOffset2.Z * CalculateNewLookCFrameFromArg.LookVector

            if CameraUtils.IsFiniteVector3( X ) then
                SubjectPosition2 = SubjectPosition + X
                Rotation2 = Rotation
            else
                SubjectPosition2 = SubjectPosition
                Rotation2 = Rotation
            end
        end

        local LookAlong, CFrame5

        if Self.isFollowCamera then
            local CalculateNewLookVectorFromArg2 = Self:CalculateNewLookVectorFromArg( LookVector, Rotation2 )
            local CFrame4 = CFrame.new( SubjectPosition2 )

            if UserFlag then
                LookAlong = CFrame.lookAlong( CFrame4.Position - CameraToSubjectDistance2 * CalculateNewLookVectorFromArg2, CalculateNewLookVectorFromArg2 )
                CFrame5 = CFrame4
            else
                CFrame5 = CFrame4
                LookAlong = CFrame.new( CFrame4.Position - CameraToSubjectDistance2 * CalculateNewLookVectorFromArg2, CFrame4.Position ) + Vector3.new( 0, CameraHeight, 0 )
            end
        else
            local CFrame3 = CFrame.new( SubjectPosition2 )
            local Position = CFrame3.Position
            local CalculateNewLookVectorFromArg = Self:CalculateNewLookVectorFromArg( LookVector, Rotation2 )

            if UserFlag then
                LookAlong = CFrame.lookAlong( Position - CameraToSubjectDistance2 * CalculateNewLookVectorFromArg, CalculateNewLookVectorFromArg )
                CFrame5 = CFrame3
            else
                LookAlong = CFrame.new( Position - CameraToSubjectDistance2 * CalculateNewLookVectorFromArg, Position )
                CFrame5 = CFrame3
            end
        end

        local CameraToggleOffset = Self:GetCameraToggleOffset( Amount )
        local LastCameraFocus = CFrame5 + CameraToggleOffset
        local LastCameraTransform = LookAlong + CameraToggleOffset
        Self.lastCameraTransform = LastCameraTransform
        Self.lastCameraFocus = LastCameraFocus

        if IsA or IsA2 then
            if CameraSubject:IsA( "BasePart" ) then
                Self.lastSubjectCFrame = CameraSubject.CFrame
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
