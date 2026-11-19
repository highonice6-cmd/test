-- StarterPlayer.PlayerModule.CameraModule.VRCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local VRService = game:GetService( "VRService" )
require( script.Parent:WaitForChild( "CameraInput" ) )
require( script.Parent:WaitForChild( "CameraUtils" ) )
local VRCameraTeleportDetector = require( script.Parent:WaitForChild( "VRCameraTeleportDetector" ) )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserVRRecenterOnExternalTeleport" )
local UserFlag2 = Get.getUserFlag( "UserVRSkipOcclusionInFirstPerson" )
local UserFlag3 = Get.getUserFlag( "UserFixVRImmersionAutoRotate" )
local VRBaseCamera = require( script.Parent:WaitForChild( "VRBaseCamera" ) )
local Self = setmetatable( { }, VRBaseCamera )
Self.__index = Self
function Self.new()
    local New = setmetatable( VRBaseCamera.new( ), Self )
    New.lastUpdate = tick( )
    New.focusOffset = CFrame.new( )
    New:Reset( )
    New.controlModule = require( script.Parent.Parent:WaitForChild( "ControlModule" ) )
    New.savedAutoRotate = true
    New.autoRotateOverridden = false
    return New
end
function Self.Reset( Argument1 )
    Argument1.needsReset = true
    Argument1.needsBlackout = true
    Argument1.motionDetTime = 0
    Argument1.blackOutTimer = 0
    Argument1.lastCameraResetPosition = nil
    VRBaseCamera.Reset( Argument1 )
end
function Self.Update( Self, Amount )
    local CurrentCamera = workspace.CurrentCamera
    local CFrame = CurrentCamera.CFrame
    local LastCameraFocus = CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer

    if Self.lastUpdate == nil or Amount > 1 then
        Self.lastCameraTransform = nil
    end

    Self:UpdateFadeFromBlack( Amount )
    local LastSubjectPosition = Self.lastSubjectPosition
    local SubjectPosition = Self:GetSubjectPosition( )

    if Self.needsBlackout then
        Self:StartFadeFromBlack( )
        local Clamp = math.clamp( Amount, 0.0001, 0.1 )
        Self.blackOutTimer = Self.blackOutTimer + Clamp

        if Self.blackOutTimer > 0.1 and game:IsLoaded( ) then
            Self.needsBlackout = false
            Self.needsReset = true
        end
    end

    local LastCameraTransform

    if not SubjectPosition or not LocalPlayer or not CurrentCamera then
        LastCameraTransform = CFrame
    else
        local VRFocus = Self:GetVRFocus( SubjectPosition, Amount )

        if UserFlag2 then
            local SkipOcclusion
            local IsInFirstPerson = Self:IsInFirstPerson( )

            if IsInFirstPerson then
                if LocalPlayer.DevCameraOcclusionMode == Enum.DevCameraOcclusionMode.Invisicam then
                    SkipOcclusion = false
                else
                    SkipOcclusion = true
                end
            else
                SkipOcclusion = IsInFirstPerson
            end

            Self.skipOcclusion = SkipOcclusion
        end
        if Self:IsInFirstPerson( ) then
            if VRService.AvatarGestures then
                LastCameraTransform, LastCameraFocus = Self:UpdateImmersionCamera( Amount, CFrame, VRFocus, LastSubjectPosition, SubjectPosition )
            else
                LastCameraTransform, LastCameraFocus = Self:UpdateFirstPersonTransform( Amount, CFrame, VRFocus, LastSubjectPosition, SubjectPosition )
            end
        elseif VRService.ThirdPersonFollowCamEnabled then
            LastCameraTransform, LastCameraFocus = Self:UpdateThirdPersonFollowTransform( Amount, CFrame, VRFocus, LastSubjectPosition, SubjectPosition )
        else
            LastCameraTransform, LastCameraFocus = Self:UpdateThirdPersonComfortTransform( Amount, CFrame, VRFocus, LastSubjectPosition, SubjectPosition )
        end

        Self.lastCameraTransform = LastCameraTransform
        Self.lastCameraFocus = LastCameraFocus
    end

    Self.lastUpdate = tick( )
    return LastCameraTransform, LastCameraFocus
end
function Self.GetAvatarFeetWorldYValue( Argument1 )
    local CameraSubject = workspace.CurrentCamera.CameraSubject

    if not CameraSubject then
        return nil
    end
    if not CameraSubject:IsA( "Humanoid" ) or not CameraSubject.RootPart then
        return nil
    end
    local RootPart = CameraSubject.RootPart
    return RootPart.Position.Y - RootPart.Size.Y / 2 - CameraSubject.HipHeight
end
function Self.UpdateFirstPersonTransform( Self, Argument2, Argument3, Argument4, Argument5, Argument6 )
    if Self.needsReset then
        Self:StartFadeFromBlack( )
        Self.needsReset = false
    end

    local Position = Argument4.Position
    local CameraLookVector = Self:GetCameraLookVector( )
    local X = CameraLookVector.X
    return CFrame.new( Position - 0.5 * Self:CalculateNewLookVectorFromArg( Vector3.new( X, 0, CameraLookVector.Z ).Unit, Vector2.new( Self:getRotation( Argument2 ), 0 ) ), Position ), Argument4
end
function Self.UpdateImmersionCamera( Self, Argument2, Argument3, Argument4, Argument5, Argument6 )
    local SubjectCFrame = Self:GetSubjectCFrame( )
    local CurrentCamera = workspace.CurrentCamera
    local Character = Players.LocalPlayer.Character
    local Humanoid = Self:GetHumanoid( )

    if not Humanoid then
        return CurrentCamera.CFrame, CurrentCamera.Focus
    end

    local Parent = Character:FindFirstChild( "HumanoidRootPart" )

    if not Parent then
        return CurrentCamera.CFrame, CurrentCamera.Focus
    end

    local PrevSubjStep

    if UserFlag then
        if Argument5 then
            local X = Argument6.X - Argument5.X
            PrevSubjStep = Vector3.new( X, 0, Argument6.Z - Argument5.Z ).Magnitude
        else
            PrevSubjStep = 0
        end
    else
        PrevSubjStep = nil
    end

    Self.characterOrientation = Parent:FindFirstChild( "CharacterAlignOrientation" )

    if not Self.characterOrientation then
        local Attachment0 = Parent:FindFirstChild( "RootAttachment" )

        if not Attachment0 then
            return
        end

        Self.characterOrientation = Instance.new( "AlignOrientation" )
        Self.characterOrientation.Name = "CharacterAlignOrientation"
        Self.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        Self.characterOrientation.Attachment0 = Attachment0
        Self.characterOrientation.RigidityEnabled = true
        Self.characterOrientation.Parent = Parent
    end
    if Self.characterOrientation.Enabled == false then
        Self.characterOrientation.Enabled = true
    end
    if Self.needsReset then
        Self.needsReset = false

        if UserFlag3 then
            Self:updateImmersionAutoRotate( )
        else
            Self.savedAutoRotate = Humanoid.AutoRotate
            Humanoid.AutoRotate = false
        end
        if UserFlag then
            VRService:RecenterUserHeadCFrame( )
            Self.lastTeleportRecenter = tick( )
        end

        Self:StartFadeFromBlack( )
    elseif not Humanoid.Sit then
        local EstimatedVRTorsoFrame = Self.controlModule:GetEstimatedVRTorsoFrame( )
        local CharacterOrientation = Self.characterOrientation
        CharacterOrientation.CFrame = CurrentCamera.CFrame * EstimatedVRTorsoFrame

        if Self.controlModule.inputMoveVector.Magnitude > 0 then
            Self.motionDetTime = 0.1
        end
        if Self.controlModule.inputMoveVector.Magnitude > 0 or Self.motionDetTime > 0 then
            Self.motionDetTime = Self.motionDetTime - Argument2
            local UserCFrame2 = VRService:GetUserCFrame( Enum.UserCFrame.Head )
            local Rotation3 = UserCFrame2.Rotation + UserCFrame2.Position * CurrentCamera.HeadScale
            local HumanoidRootPart2 = Character.HumanoidRootPart
            local Y4 = -0.7 * HumanoidRootPart2.Size.Y / 2
            local CFrame3 = CurrentCamera.CFrame * Rotation3 * CFrame.new( 0, Y4, 0 )
            local LookVector2 = HumanoidRootPart2.CFrame.LookVector
            local X5 = LookVector2.X
            local Position2 = Argument6 - ( CFrame3 - Vector3.new( X5, 0, LookVector2.Z ).Unit * HumanoidRootPart2.Size.Y * 0.125 ).Position + CurrentCamera.CFrame.Position
            local X6 = Position2.X
            local Y5 = Argument6.Y
            local Vector33 = Vector3.new( X6, Y5, Position2.Z )
            SubjectCFrame = CurrentCamera.CFrame.Rotation + Vector33
        elseif UserFlag then
            local ShouldRecenter = VRCameraTeleportDetector.shouldRecenter
            local PrevSubjStep2 = Self.prevSubjStep

            if ShouldRecenter( PrevSubjStep2, PrevSubjStep, Self.lastTeleportRecenter, tick( ) ) then
                local UserCFrame = VRService:GetUserCFrame( Enum.UserCFrame.Head )
                local Rotation = UserCFrame.Rotation + UserCFrame.Position * CurrentCamera.HeadScale
                local HumanoidRootPart = Character.HumanoidRootPart
                local Y = -0.7 * HumanoidRootPart.Size.Y / 2
                local CFrame2 = CurrentCamera.CFrame * Rotation * CFrame.new( 0, Y, 0 )
                local LookVector = HumanoidRootPart.CFrame.LookVector
                local X2 = LookVector.X
                local Position = Argument6 - ( CFrame2 - Vector3.new( X2, 0, LookVector.Z ).Unit * HumanoidRootPart.Size.Y * 0.125 ).Position + CurrentCamera.CFrame.Position
                local X3 = Position.X
                local Y2 = Argument6.Y
                local Vector32 = Vector3.new( X3, Y2, Position.Z )
                SubjectCFrame = CurrentCamera.CFrame.Rotation + Vector32
                VRService:RecenterUserHeadCFrame( )
                Self:StartFadeFromBlack( )
                Self.lastTeleportRecenter = tick( )
            else
                local Rotation2 = CurrentCamera.CFrame.Rotation
                local X4 = CurrentCamera.CFrame.Position.X
                local Y3 = Argument6.Y
                SubjectCFrame = Rotation2 + Vector3.new( X4, Y3, CurrentCamera.CFrame.Position.Z )
            end
        else
            local Rotation2 = CurrentCamera.CFrame.Rotation
            local X4 = CurrentCamera.CFrame.Position.X
            local Y3 = Argument6.Y
            SubjectCFrame = Rotation2 + Vector3.new( X4, Y3, CurrentCamera.CFrame.Position.Z )
        end

        local GetRotation = Self:getRotation( Argument2 )

        if math.abs( GetRotation ) > 0 then
            local UserCFrame3 = VRService:GetUserCFrame( Enum.UserCFrame.Head )
            local Rotation4 = UserCFrame3.Rotation + UserCFrame3.Position * CurrentCamera.HeadScale
            local Rotation5 = SubjectCFrame * Rotation4
            SubjectCFrame = CFrame.new( Rotation5.Position ) * CFrame.Angles( 0, -math.rad( GetRotation * 90 ), 0 ) * Rotation5.Rotation * Rotation4:Inverse( )
        end
    end
    if UserFlag then
        Self.prevSubjStep = PrevSubjStep
    end

    return SubjectCFrame, SubjectCFrame * CFrame.new( 0, 0, -0.5 )
end
function Self.UpdateThirdPersonComfortTransform( Self, Argument2, Argument3, Argument4, Argument5, LastCameraResetPosition )
    local CameraToSubjectDistance2
    local CameraToSubjectDistance = Self:GetCameraToSubjectDistance( )
    CameraToSubjectDistance2 = if CameraToSubjectDistance < 0.5 then 0.5 else CameraToSubjectDistance
    local CFrame2

    if Argument5 == nil or Self.lastCameraFocus == nil then
        CFrame2 = Argument3
    else
        local Flag
        local Total = Argument5 - LastCameraResetPosition
        local InputMoveVector = Self.controlModule.inputMoveVector

        if Total.magnitude > 0.01 then
            Flag = true
        elseif InputMoveVector.magnitude > 0.01 then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            Self.motionDetTime = 0.1
        end

        Self.motionDetTime = Self.motionDetTime - Argument2

        if Self.motionDetTime > 0 then
            Flag = true
        end
        if Flag and not Self.needsReset then
            local LastCameraFocus = Self.lastCameraFocus
            Self.VRCameraFocusFrozen = true
            return Argument3, LastCameraFocus
        end

        local Flag2

        if Self.lastCameraResetPosition == nil then
            Flag2 = true
        elseif ( LastCameraResetPosition - Self.lastCameraResetPosition ).Magnitude > 1 then
            Flag2 = true
        else
            Flag2 = false
        end

        local GetRotation = Self:getRotation( Argument2 )

        if math.abs( GetRotation ) > 0 then
            local ToObjectSpace = Argument4:ToObjectSpace( Argument3 )
            CFrame2 = Argument4 * CFrame.Angles( 0, -GetRotation, 0 ) * ToObjectSpace
        else
            CFrame2 = Argument3
        end
        if not Self.VRCameraFocusFrozen or not Flag2 then
            if Self.needsReset then
                local LookVector2
                VRService:RecenterUserHeadCFrame( )
                Self.VRCameraFocusFrozen = false
                Self.needsReset = false
                Self.lastCameraResetPosition = LastCameraResetPosition
                Self:ResetZoom( )
                Self:StartFadeFromBlack( )
                local Humanoid = Self:GetHumanoid( )

                if Humanoid.Torso then
                    local LookVector = Humanoid.Torso.CFrame.lookVector

                    if LookVector then
                        LookVector2 = LookVector
                    else
                        LookVector2 = Vector3.new( 1, 0, 0 )
                    end
                else
                    LookVector2 = Vector3.new( 1, 0, 0 )
                end

                local X = LookVector2.X
                local Vector32 = Vector3.new( X, 0, LookVector2.Z )
                local Position = Argument4.Position - Vector32 * CameraToSubjectDistance2
                local X2 = Argument4.Position.X
                local Y = Position.Y
                CFrame2 = CFrame.new( Position, ( Vector3.new( X2, Y, Argument4.Position.Z ) ) )
            end
        else
            VRService:RecenterUserHeadCFrame( )
            Self.VRCameraFocusFrozen = false
            Self.needsReset = false
            Self.lastCameraResetPosition = LastCameraResetPosition
            Self:ResetZoom( )
            Self:StartFadeFromBlack( )
            local Humanoid = Self:GetHumanoid( )

            if Humanoid.Torso then
                local LookVector = Humanoid.Torso.CFrame.lookVector

                if LookVector then
                    LookVector2 = LookVector
                else
                    LookVector2 = Vector3.new( 1, 0, 0 )
                end
            else
                LookVector2 = Vector3.new( 1, 0, 0 )
            end

            local X = LookVector2.X
            local Vector32 = Vector3.new( X, 0, LookVector2.Z )
            local Position = Argument4.Position - Vector32 * CameraToSubjectDistance2
            local X2 = Argument4.Position.X
            local Y = Position.Y
            CFrame2 = CFrame.new( Position, ( Vector3.new( X2, Y, Argument4.Position.Z ) ) )
        end
    end

    return CFrame2, Argument4
end
function Self.UpdateThirdPersonFollowTransform( Self, Argument2, Argument3, Argument4, Argument5, Argument6 )
    local CurrentCamera = workspace.CurrentCamera
    local CameraToSubjectDistance = Self:GetCameraToSubjectDistance( )
    local VRFocus = Self:GetVRFocus( Argument6, Argument2 )

    if Self.needsReset then
        Self.needsReset = false
        VRService:RecenterUserHeadCFrame( )
        Self:ResetZoom( )
        Self:StartFadeFromBlack( )
    end
    if not Self.recentered then
        local Lerp
        local ToWorldSpace = VRFocus:ToWorldSpace( Self.focusOffset )
        local Total = Argument5 - Argument6
        local ControlModule = Self.controlModule
        local InputMoveVector = ControlModule.inputMoveVector

        if Total.magnitude > 0.01 or InputMoveVector.magnitude > 0 then
            local EstimatedVRTorsoFrame = ControlModule:GetEstimatedVRTorsoFrame( )
            local Rotation = EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * CurrentCamera.HeadScale
            local CFrame2 = CurrentCamera.CFrame * Rotation
            local LookVector = CFrame2.LookVector
            local X = LookVector.X
            local Unit = Vector3.new( X, 0, LookVector.Z ).Unit * CameraToSubjectDistance
            local Position = VRFocus.Position - Unit
            Lerp = ToWorldSpace:Lerp( CFrame.new( CurrentCamera.CFrame.Position + Position - CFrame2.Position ) * ToWorldSpace.Rotation, 0.01 )
        else
            Lerp = ToWorldSpace
        end

        local GetRotation = Self:getRotation( Argument2 )

        if math.abs( GetRotation ) > 0 then
            local ToObjectSpace = VRFocus:ToObjectSpace( Lerp )
            Lerp = VRFocus * CFrame.Angles( 0, -GetRotation, 0 ) * ToObjectSpace
        end

        Self.focusOffset = VRFocus:ToObjectSpace( Lerp )
        return Lerp, Lerp * CFrame.new( 0, 0, -CameraToSubjectDistance )
    end
    local SubjectCFrame = Self:GetSubjectCFrame( )

    if SubjectCFrame then
        local VRFocus2 = VRFocus * SubjectCFrame.Rotation * CFrame.new( 0, 0, CameraToSubjectDistance )
        Self.focusOffset = VRFocus:ToObjectSpace( VRFocus2 )
        Self.recentered = false
        return VRFocus2, VRFocus
    end
    return CurrentCamera.CFrame, CurrentCamera.Focus
end
function Self.updateImmersionAutoRotate( Self )
    local Humanoid = Self:GetHumanoid( )

    if not Humanoid then
        return
    end
    if not Self:IsInFirstPerson( ) or not VRService.AvatarGestures then
        if Self.autoRotateOverridden then
            Humanoid.AutoRotate = Self.savedAutoRotate
            Self.autoRotateOverridden = false
        end

        return
    end
    if not Self.autoRotateOverridden then
        Self.savedAutoRotate = Humanoid.AutoRotate
        Self.autoRotateOverridden = true
    end

    Humanoid.AutoRotate = false
    return
end
function Self.OnEnabledChanged( Enabled )
    VRBaseCamera.OnEnabledChanged( Enabled )

    if not UserFlag3 then
        return
    end
    if Enabled.enabled then
        if not Enabled.avatarGesturesChangedConn then
            Enabled.avatarGesturesChangedConn = VRService:GetPropertyChangedSignal( "AvatarGestures" ):Connect( function()
                Enabled:updateImmersionAutoRotate( )
            end )
            return
        end
    elseif Enabled.avatarGesturesChangedConn then
        Enabled.avatarGesturesChangedConn:Disconnect( )
        Enabled.avatarGesturesChangedConn = nil
    end
end
function Self.LeaveFirstPerson( Argument1 )
    VRBaseCamera.LeaveFirstPerson( Argument1 )
    Argument1.needsReset = true

    if Argument1.VRBlur then
        Argument1.VRBlur.Visible = false
    end
    if Argument1.characterOrientation then
        Argument1.characterOrientation.Enabled = false
    end
    if UserFlag3 then
        Argument1:updateImmersionAutoRotate( )
        return
    end

    local Humanoid = Argument1:GetHumanoid( )

    if Humanoid then
        Humanoid.AutoRotate = Argument1.savedAutoRotate
    end
end
return Self
