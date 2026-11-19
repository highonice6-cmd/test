-- StarterPlayer.PlayerModule.CameraModule.VRBaseCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local VRService = game:GetService( "VRService" )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer
local Lighting = game:GetService( "Lighting" )
local RunService = game:GetService( "RunService" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local ZoomController = require( script.Parent:WaitForChild( "ZoomController" ) )
require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local CameraGamepadResetAction = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "CameraContext" ):WaitForChild( "CameraGamepadResetAction" )
local BaseCamera = require( script.Parent:WaitForChild( "BaseCamera" ) )
local Self = setmetatable( { }, BaseCamera )
Self.__index = Self
function Self.new()
    local New = setmetatable( BaseCamera.new( ), Self )
    New.gamepadZoomLevels = { 0, 7 }
    New.headScale = 1
    New:SetCameraToSubjectDistance( 7 )
    New.VRFadeResetTimer = 0
    New.VREdgeBlurTimer = 0
    New.needsReset = true
    New.recentered = false
    New.gamepadResetConnection = CameraGamepadResetAction.Pressed:Connect( function()
        New:GamepadReset( )
    end )
    New:Reset( )
    return New
end
function Self.Reset( Argument1 )
    Argument1.stepRotateTimeout = 0
end
function Self.GetModuleName( Argument1 )
    return "VRBaseCamera"
end
function Self.GamepadZoomPress( Argument1 )
    BaseCamera.GamepadZoomPress( Argument1 )
    Argument1:GamepadReset( )
    Argument1:ResetZoom( )
end
function Self.GamepadReset( Argument1 )
    Argument1.stepRotateTimeout = 0
    Argument1.needsReset = true
end
function Self.ResetZoom( Argument1 )
    local SetZoomParameters = ZoomController.SetZoomParameters
    SetZoomParameters( Argument1.currentSubjectDistance, 0 )
    ZoomController.ReleaseSpring( )
end
function Self.OnEnabledChanged( Enabled )
    BaseCamera.OnEnabledChanged( Enabled )

    if Enabled.enabled then
        CameraGamepadResetAction.Enabled = true
        Enabled.thirdPersonOptionChanged = VRService:GetPropertyChangedSignal( "ThirdPersonFollowCamEnabled" ):Connect( function()
            Enabled:Reset( )
        end )
        Enabled.vrRecentered = VRService.UserCFrameChanged:Connect( function( Argument1, Argument2 )
            if Argument1 == Enum.UserCFrame.Floor then
                Enabled.recentered = true
            end
        end )
        return
    end
    if Enabled.inFirstPerson then
        Enabled:GamepadZoomPress( )
    end
    if Enabled.thirdPersonOptionChanged then
        Enabled.thirdPersonOptionChanged:Disconnect( )
        Enabled.thirdPersonOptionChanged = nil
    end
    if Enabled.vrRecentered then
        Enabled.vrRecentered:Disconnect( )
        Enabled.vrRecentered = nil
    end
    if Enabled.cameraHeadScaleChangedConn then
        Enabled.cameraHeadScaleChangedConn:Disconnect( )
        Enabled.cameraHeadScaleChangedConn = nil
    end

    CameraGamepadResetAction.Enabled = false
    local VRFade = Lighting:FindFirstChild( "VRFade" )

    if VRFade then
        VRFade.Brightness = 0
    end
end
function Self.OnCurrentCameraChanged( Camera )
    BaseCamera.OnCurrentCameraChanged( Camera )

    if Camera.cameraHeadScaleChangedConn then
        Camera.cameraHeadScaleChangedConn:Disconnect( )
        Camera.cameraHeadScaleChangedConn = nil
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        Camera.cameraHeadScaleChangedConn = CurrentCamera:GetPropertyChangedSignal( "HeadScale" ):Connect( function()
            Camera:OnHeadScaleChanged( )
        end )
        Camera:OnHeadScaleChanged( )
    end
end
function Self.OnHeadScaleChanged( Self )
    local Value1
    local HeadScale = workspace.CurrentCamera.HeadScale
    local GamepadZoomLevels = Self.gamepadZoomLevels
    Value1 = nil

    for Key, Value in GamepadZoomLevels, nil, nil do
        local GamepadZoomLevels2 = Self.gamepadZoomLevels
        GamepadZoomLevels2[ Key ] = Value * HeadScale / Self.headScale
    end

    Self:SetCameraToSubjectDistance( Self:GetCameraToSubjectDistance( ) * HeadScale / Self.headScale )
    Self.headScale = HeadScale
end
function Self.GetVRFocus( Self, Argument2, Argument3 )
    local LastCameraFocus = Self.lastCameraFocus or Argument2
    local X = Self.cameraTranslationConstraints.x
    local Min = math.min( 1, Self.cameraTranslationConstraints.y + Argument3 )
    Self.cameraTranslationConstraints = Vector3.new( X, Min, Self.cameraTranslationConstraints.z )
    local Vector32 = Vector3.new( 0, Self:GetCameraHeight( ), 0 )
    local X2 = Argument2.x
    local Y = LastCameraFocus.y
    return ( CFrame.new( Vector3.new( X2, Y, Argument2.z ):Lerp( Argument2 + Vector32, Self.cameraTranslationConstraints.y ) ) )
end
function Self.StartFadeFromBlack( Argument1 )
    if UserGameSettings.VignetteEnabled == false then
        return
    end

    local VRFade2
    local VRFade = Lighting:FindFirstChild( "VRFade" )

    if VRFade then
        VRFade2 = VRFade
    else
        local ColorCorrectionEffect = Instance.new( "ColorCorrectionEffect" )
        ColorCorrectionEffect.Name = "VRFade"
        ColorCorrectionEffect.Parent = Lighting
        VRFade2 = ColorCorrectionEffect
    end

    VRFade2.Brightness = -1
    Argument1.VRFadeResetTimer = 0.1
end
function Self.UpdateFadeFromBlack( Argument1, Amount )
    local VRFade = Lighting:FindFirstChild( "VRFade" )

    if Argument1.VRFadeResetTimer > 0 then
        Argument1.VRFadeResetTimer = math.max( Argument1.VRFadeResetTimer - Amount, 0 )
        local VRFade2 = Lighting:FindFirstChild( "VRFade" )

        if VRFade2 and VRFade2.Brightness < 0 then
            VRFade2.Brightness = math.min( VRFade2.Brightness + Amount * 10, 0 )
            return
        end
    elseif VRFade then
        VRFade.Brightness = 0
    end
end
function Self.StartVREdgeBlur( Argument1, Player, Argument3 )
    if not Argument3 and UserGameSettings.VignetteEnabled == false then
        return
    end

    local Adornee
    local VRBlurPart = workspace.CurrentCamera:FindFirstChild( "VRBlurPart" )

    if VRBlurPart then
        Adornee = VRBlurPart
    else
        local Part = Instance.new( "Part" )
        Part.Name = "VRBlurPart"
        Part.Parent = workspace.CurrentCamera
        Part.CanTouch = false
        Part.CanCollide = false
        Part.CanQuery = false
        Part.Anchored = true
        Part.Size = Vector3.new( 0.4399999976158142, 0.4699999988079071, 1 )
        Part.Transparency = 1
        Part.CastShadow = false
        RunService.RenderStepped:Connect( function( Argument1 )
            local UserCFrame = VRService:GetUserCFrame( Enum.UserCFrame.Head )
            local CFrame2 = workspace.CurrentCamera.CFrame * ( CFrame.new( UserCFrame.Position * workspace.CurrentCamera.HeadScale ) * ( UserCFrame - UserCFrame.Position ) )
            Part.CFrame = CFrame2 * CFrame.Angles( 0, 3.141592653589793, 0 ) + CFrame2.LookVector * ( 1.05 * workspace.CurrentCamera.HeadScale )
            Part.Size = Vector3.new( 0.4399999976158142, 0.4699999988079071, 1 ) * workspace.CurrentCamera.HeadScale
        end )
        Adornee = Part
    end

    local VRBlur
    local VRBlurScreen = Player.PlayerGui:FindFirstChild( "VRBlurScreen" )

    if VRBlurScreen then
        VRBlur = VRBlurScreen:FindFirstChild( "VRBlur" )
    else
        VRBlur = nil
    end
    if not VRBlur then
        local Parent

        if VRBlurScreen then
            Parent = VRBlurScreen
        else
            Parent = Instance.new( "SurfaceGui" )
        end

        Parent.Name = "VRBlurScreen"
        Parent.Parent = Player.PlayerGui
        Parent.Adornee = Adornee
        local ImageLabel = Instance.new( "ImageLabel" )
        ImageLabel.Name = "VRBlur"
        ImageLabel.Parent = Parent
        ImageLabel.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
        ImageLabel.AnchorPoint = Vector2.new( 0.5, 0.5 )
        ImageLabel.Position = UDim2.new( 0.5, 0, 0.5, 0 )
        local X = workspace.CurrentCamera.ViewportSize.X * 2.3 / 512
        ImageLabel.Size = UDim2.fromScale( X, workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512 )
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Active = true
        ImageLabel.ScaleType = Enum.ScaleType.Stretch
        VRBlur = ImageLabel
    end

    VRBlur.Visible = true
    VRBlur.ImageTransparency = 0
    Argument1.VREdgeBlurTimer = 0.14
end
function Self.UpdateEdgeBlur( Argument1, Player, Argument3 )
    local VRBlur
    local VRBlurScreen = Player.PlayerGui:FindFirstChild( "VRBlurScreen" )

    if VRBlurScreen then
        VRBlur = VRBlurScreen:FindFirstChild( "VRBlur" )
    else
        VRBlur = nil
    end
    if VRBlur then
        if Argument1.VREdgeBlurTimer > 0 then
            Argument1.VREdgeBlurTimer = Argument1.VREdgeBlurTimer - Argument3
            local VRBlurScreen2 = Player.PlayerGui:FindFirstChild( "VRBlurScreen" )

            if VRBlurScreen2 and VRBlurScreen2:FindFirstChild( "VRBlur" ) then
                VRBlurScreen2:FindFirstChild( "VRBlur" ).ImageTransparency = 1 - math.clamp( Argument1.VREdgeBlurTimer, 0.01, 0.14 ) * 7.142857142857142
                return
            end
        else
            VRBlur.Visible = false
        end
    end
end
function Self.GetCameraHeight( Argument1 )
    if Argument1.inFirstPerson then
        return 0
    end
    return 0.25881904510252074 * Argument1.currentSubjectDistance
end
function Self.GetSubjectCFrame( Argument1 )
    local CurrentCamera2
    local SubjectCFrame = BaseCamera.GetSubjectCFrame( Argument1 )
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera

    if not CurrentCamera2 then
        return SubjectCFrame
    end

    local LastSubjectCFrame

    if CurrentCamera2:IsA( "Humanoid" ) then
        local Flag = CurrentCamera2:GetState( ) == Enum.HumanoidStateType.Dead and true or false

        if not Flag or CurrentCamera2 ~= Argument1.lastSubject then
            LastSubjectCFrame = SubjectCFrame
        else
            LastSubjectCFrame = Argument1.lastSubjectCFrame
        end
    else
        LastSubjectCFrame = SubjectCFrame
    end
    if LastSubjectCFrame then
        Argument1.lastSubjectCFrame = LastSubjectCFrame
    end

    return LastSubjectCFrame
end
function Self.GetSubjectPosition( Argument1 )
    local CurrentCamera2
    local LastSubjectPosition = BaseCamera.GetSubjectPosition( Argument1 )
    local CurrentCamera = game.Workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera

    if not CurrentCamera2 then
        return nil
    end
    if CurrentCamera2:IsA( "Humanoid" ) then
        local Flag = CurrentCamera2:GetState( ) == Enum.HumanoidStateType.Dead and true or false

        if Flag and CurrentCamera2 == Argument1.lastSubject then
            LastSubjectPosition = Argument1.lastSubjectPosition
        end
    elseif CurrentCamera2:IsA( "VehicleSeat" ) then
        LastSubjectPosition = CurrentCamera2.CFrame.Position + CurrentCamera2.CFrame:vectorToWorldSpace( Vector3.new( 0, 4, 0 ) )
    end

    Argument1.lastSubjectPosition = LastSubjectPosition
    return LastSubjectPosition
end
function Self.getRotation( Self, Argument2 )
    local Rotation = CameraInput.getRotation( Argument2 )

    if UserGameSettings.VRSmoothRotationEnabled then
        return Rotation.X
    end
    if math.abs( Rotation.X ) > 0.03 then
        if Self.stepRotateTimeout > 0 then
            Self.stepRotateTimeout = Self.stepRotateTimeout - Argument2
        end
        if Self.stepRotateTimeout <= 0 then
            local Number = if Rotation.X < 0 then -1 else 1
            local Number2 = Number * 0.5235987755982988
            Self:StartFadeFromBlack( )
            Self.stepRotateTimeout = 0.25
            return Number2
        end
    elseif math.abs( Rotation.X ) < 0.02 then
        Self.stepRotateTimeout = 0
    end

    return 0
end
function Self.HandleSubjectDistance( Argument1, Argument2 )
    if Argument2 and Argument2.IsInFirstPerson and Argument2:IsInFirstPerson( ) then
        Argument1:SetCameraToSubjectDistance( 0 )
    end
end
return Self
