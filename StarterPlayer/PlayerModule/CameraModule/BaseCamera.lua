-- StarterPlayer.PlayerModule.CameraModule.BaseCamera
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local VRService = game:GetService( "VRService" )
local GuiService = game:GetService( "GuiService" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local CommonUtils = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) )
local Get = CommonUtils.get( "ConnectionUtil" )
CommonUtils.get( "FlagUtil" )
local CameraUtils = require( script.Parent:WaitForChild( "CameraUtils" ) )
local ZoomController = require( script.Parent:WaitForChild( "ZoomController" ) )
local CameraToggleStateController = require( script.Parent:WaitForChild( "CameraToggleStateController" ) )
local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local CameraUI = require( script.Parent:WaitForChild( "CameraUI" ) )
local CameraGamepadZoomAction = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "CameraContext" ):WaitForChild( "CameraGamepadZoomAction" )
local LocalPlayer = Players.LocalPlayer
local Table = {
    CHARACTER_ADDED = "CHARACTER_ADDED",
    CAMERA_MODE_CHANGED = "CAMERA_MODE_CHANGED",
    CAMERA_MIN_DISTANCE_CHANGED = "CAMERA_MIN_DISTANCE_CHANGED",
    CAMERA_MAX_DISTANCE_CHANGED = "CAMERA_MAX_DISTANCE_CHANGED",
    SELECTION_MODE_CHANGED = "SELECTION_MODE_CHANGED"
}
local __index = { }
__index.__index = __index
function __index.new()
    local Self = setmetatable( { }, __index )
    Self._connections = Get.new( )
    Self.gamepadZoomLevels = { 0, 10, 20 }
    Self.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    Self.cameraType = nil
    Self.cameraMovementMode = nil
    Self.lastCameraTransform = nil
    Self.lastUserPanCamera = tick( )
    Self.humanoidRootPart = nil
    Self.humanoidCache = { }
    Self.lastSubject = nil
    Self.lastSubjectPosition = Vector3.new( 0, 5, 0 )
    Self.lastSubjectCFrame = CFrame.new( Self.lastSubjectPosition )
    local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
    Self.currentSubjectDistance = math.clamp( 12.5, CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance )
    Self.inFirstPerson = false
    Self.inMouseLockedMode = false
    Self.resetCameraAngle = true
    Self.enabled = false
    Self.cameraChangedConn = nil
    Self.shouldUseVRRotation = false
    Self.VRRotationIntensityAvailable = false
    Self.lastVRRotationIntensityCheckTime = 0
    Self.lastVRRotationTime = 0
    Self.vrRotateKeyCooldown = { }
    Self.cameraTranslationConstraints = Vector3.new( 1, 1, 1 )
    Self.humanoidJumpOrigin = nil
    Self.trackingHumanoid = nil
    Self.cameraFrozen = false
    Self.subjectStateChangedConn = nil
    Self.gamepadZoomPressConnection = CameraGamepadZoomAction.Pressed:Connect( function()
        Self:GamepadZoomPress( )
    end )
    Self.mouseLockOffset = Vector3.new( 0, 0, 0 )
    UserGameSettings:SetCameraYInvertVisible( )
    UserGameSettings:SetGamepadCameraSensitivityVisible( )
    return Self
end
function __index.GetModuleName( Argument1 )
    return "BaseCamera"
end

local function OnSelectedObjectChanged()
    CameraGamepadZoomAction.Enabled = not GuiService.SelectedObject
end

function __index._setUpConfigurations( Configurations )
    local _connections = Configurations._connections
    _connections:trackConnection( "CHARACTER_ADDED", LocalPlayer.CharacterAdded:Connect( function( Argument1 )
        Configurations:OnCharacterAdded( Argument1 )
    end ) )
    Configurations.humanoidRootPart = nil
    local _connections2 = Configurations._connections
    _connections2:trackConnection( "CAMERA_MODE_CHANGED", LocalPlayer:GetPropertyChangedSignal( "CameraMode" ):Connect( function()
        Configurations:OnPlayerCameraPropertyChange( )
    end ) )
    local _connections3 = Configurations._connections
    _connections3:trackConnection( "CAMERA_MIN_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal( "CameraMinZoomDistance" ):Connect( function()
        Configurations:OnPlayerCameraPropertyChange( )
    end ) )
    local _connections4 = Configurations._connections
    _connections4:trackConnection( "CAMERA_MAX_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal( "CameraMaxZoomDistance" ):Connect( function()
        Configurations:OnPlayerCameraPropertyChange( )
    end ) )
    local _connections5 = Configurations._connections
    _connections5:trackConnection( "SELECTION_MODE_CHANGED", GuiService:GetPropertyChangedSignal( "SelectedObject" ):Connect( function()
        CameraGamepadZoomAction.Enabled = not GuiService.SelectedObject
    end ) )
    Configurations:OnPlayerCameraPropertyChange( )
end
function __index.OnCharacterAdded( Self, Argument2 )
    local ResetCameraAngle2
    local ResetCameraAngle = Self.resetCameraAngle
    ResetCameraAngle2 = if ResetCameraAngle then ResetCameraAngle else Self:GetEnabled( )
    Self.resetCameraAngle = ResetCameraAngle2
    Self.humanoidRootPart = nil
end
function __index.GetHumanoidRootPart( Argument1 )
    if not Argument1.humanoidRootPart and LocalPlayer.Character then
        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )

        if Humanoid then
            Argument1.humanoidRootPart = Humanoid.RootPart
        end
    end

    return Argument1.humanoidRootPart
end
function __index.GetSubjectCFrame( Self )
    local CurrentCamera2
    local LastSubjectCFrame = Self.lastSubjectCFrame
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera

    if not CurrentCamera2 then
        return LastSubjectCFrame
    end

    local LastSubjectCFrame2

    if CurrentCamera2:IsA( "Humanoid" ) then
        local Flag = CurrentCamera2:GetState( ) == Enum.HumanoidStateType.Dead and true or false
        local CameraOffset = CurrentCamera2.CameraOffset

        if Self:GetIsMouseLocked( ) then
            CameraOffset = Vector3.new( )
        end

        local RootPart2
        local RootPart = CurrentCamera2.RootPart
        RootPart2 = if not Flag or not CurrentCamera2.Parent or not CurrentCamera2.Parent:IsA( "Model" ) then RootPart else CurrentCamera2.Parent:FindFirstChild( "Head" ) or RootPart

        if not RootPart2 or not RootPart2:IsA( "BasePart" ) then
            LastSubjectCFrame2 = LastSubjectCFrame
        else
            local Vector32

            if CurrentCamera2.RigType == Enum.HumanoidRigType.R15 then
                if CurrentCamera2.AutomaticScalingEnabled then
                    local RootPart3 = CurrentCamera2.RootPart

                    if RootPart2 == RootPart3 then
                        Vector32 = Vector3.new( 0, 1.5, 0 ) + Vector3.new( 0, ( RootPart3.Size.Y - 2 ) / 2, 0 )
                    else
                        Vector32 = Vector3.new( 0, 1.5, 0 )
                    end
                else
                    Vector32 = Vector3.new( 0, 2, 0 )
                end
            else
                Vector32 = Vector3.new( 0, 1.5, 0 )
            end
            if Flag then
                Vector32 = Vector3.new( 0, 0, 0 )
            end

            LastSubjectCFrame2 = RootPart2.CFrame * CFrame.new( Vector32 + CameraOffset )
        end
    elseif CurrentCamera2:IsA( "BasePart" ) then
        LastSubjectCFrame2 = CurrentCamera2.CFrame
    elseif CurrentCamera2:IsA( "Model" ) then
        if CurrentCamera2.PrimaryPart then
            LastSubjectCFrame2 = CurrentCamera2:GetPrimaryPartCFrame( )
        else
            LastSubjectCFrame2 = CFrame.new( )
        end
    else
        LastSubjectCFrame2 = LastSubjectCFrame
    end
    if LastSubjectCFrame2 then
        Self.lastSubjectCFrame = LastSubjectCFrame2
    end

    return LastSubjectCFrame2
end
function __index.GetSubjectVelocity( Argument1 )
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera

    if not CurrentCamera2 then
        return Vector3.new( 0, 0, 0 )
    end
    if CurrentCamera2:IsA( "BasePart" ) then
        return CurrentCamera2.Velocity
    end
    if CurrentCamera2:IsA( "Humanoid" ) then
        local RootPart = CurrentCamera2.RootPart

        if RootPart then
            return RootPart.Velocity
        end
    elseif CurrentCamera2:IsA( "Model" ) and CurrentCamera2.PrimaryPart then
        return CurrentCamera2.PrimaryPart.Velocity
    end

    return Vector3.new( 0, 0, 0 )
end
function __index.GetSubjectRotVelocity( Argument1 )
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera

    if not CurrentCamera2 then
        return Vector3.new( 0, 0, 0 )
    end
    if CurrentCamera2:IsA( "BasePart" ) then
        return CurrentCamera2.RotVelocity
    end
    if CurrentCamera2:IsA( "Humanoid" ) then
        local RootPart = CurrentCamera2.RootPart

        if RootPart then
            return RootPart.RotVelocity
        end
    elseif CurrentCamera2:IsA( "Model" ) and CurrentCamera2.PrimaryPart then
        return CurrentCamera2.PrimaryPart.RotVelocity
    end

    return Vector3.new( 0, 0, 0 )
end
function __index.StepZoom( Self, Argument2 )
    local CurrentSubjectDistance = Self.currentSubjectDistance
    local ZoomDelta = CameraInput.getZoomDelta( Argument2 )

    if math.abs( ZoomDelta ) > 0 then
        local Max

        if ZoomDelta > 0 then
            local CurrentSubjectDistance2 = CurrentSubjectDistance + ZoomDelta * ( CurrentSubjectDistance * 0.5 + 1 )
            Max = math.max( CurrentSubjectDistance2, Self.FIRST_PERSON_DISTANCE_THRESHOLD )
        else
            Max = math.max( ( CurrentSubjectDistance + ZoomDelta ) / ( 1 - ZoomDelta * 0.5 ), 0.5 )
        end
        if Max < Self.FIRST_PERSON_DISTANCE_THRESHOLD then
            Max = 0.5
        end

        Self:SetCameraToSubjectDistance( Max )
    end

    return ZoomController.GetZoomRadius( )
end
function __index.GetSubjectPosition( Self )
    local LastSubject
    local LastSubjectPosition = Self.lastSubjectPosition
    local CurrentCamera = game.Workspace.CurrentCamera
    LastSubject = if CurrentCamera then CurrentCamera.CameraSubject else CurrentCamera

    if not LastSubject then
        return nil
    end
    if LastSubject:IsA( "Humanoid" ) then
        local Flag = LastSubject:GetState( ) == Enum.HumanoidStateType.Dead and true or false
        local CameraOffset = LastSubject.CameraOffset

        if Self:GetIsMouseLocked( ) then
            CameraOffset = Vector3.new( )
        end

        local RootPart2
        local RootPart = LastSubject.RootPart
        RootPart2 = if not Flag or not LastSubject.Parent or not LastSubject.Parent:IsA( "Model" ) then RootPart else LastSubject.Parent:FindFirstChild( "Head" ) or RootPart

        if RootPart2 and RootPart2:IsA( "BasePart" ) then
            local Vector32

            if LastSubject.RigType == Enum.HumanoidRigType.R15 then
                if LastSubject.AutomaticScalingEnabled then
                    if RootPart2 == LastSubject.RootPart then
                        Vector32 = Vector3.new( 0, 1.5, 0 ) + Vector3.new( 0, LastSubject.RootPart.Size.Y / 2 - 1, 0 )
                    else
                        Vector32 = Vector3.new( 0, 1.5, 0 )
                    end
                else
                    Vector32 = Vector3.new( 0, 2, 0 )
                end
            else
                Vector32 = Vector3.new( 0, 1.5, 0 )
            end
            if Flag then
                Vector32 = Vector3.new( 0, 0, 0 )
            end

            LastSubjectPosition = RootPart2.CFrame.Position + RootPart2.CFrame:vectorToWorldSpace( Vector32 + CameraOffset )
        end
    elseif LastSubject:IsA( "VehicleSeat" ) then
        LastSubjectPosition = LastSubject.CFrame.Position + LastSubject.CFrame:vectorToWorldSpace( Vector3.new( 0, 5, 0 ) )
    elseif LastSubject:IsA( "SkateboardPlatform" ) then
        LastSubjectPosition = LastSubject.CFrame.Position + Vector3.new( 0, 5, 0 )
    elseif LastSubject:IsA( "BasePart" ) then
        LastSubjectPosition = LastSubject.CFrame.Position
    elseif LastSubject:IsA( "Model" ) then
        if LastSubject.PrimaryPart then
            LastSubjectPosition = LastSubject:GetPrimaryPartCFrame( ).Position
        else
            LastSubjectPosition = LastSubject:GetModelCFrame( ).Position
        end
    end

    Self.lastSubject = LastSubject
    Self.lastSubjectPosition = LastSubjectPosition
    return LastSubjectPosition
end
function __index.OnCurrentCameraChanged( Camera )
    if Camera.cameraSubjectChangedConn then
        Camera.cameraSubjectChangedConn:Disconnect( )
        Camera.cameraSubjectChangedConn = nil
    end

    local CurrentCamera = game.Workspace.CurrentCamera

    if CurrentCamera then
        Camera.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal( "CameraSubject" ):Connect( function()
            Camera:OnNewCameraSubject( )
        end )
        Camera:OnNewCameraSubject( )
    end
end
function __index.OnPlayerCameraPropertyChange( Self )
    Self:SetCameraToSubjectDistance( Self.currentSubjectDistance )
end
function __index.InputTranslationToCameraAngleChange( Argument1, Argument2, Argument3 )
    return Argument2 * Argument3
end
function __index.GamepadZoomPress( Self )
    local CameraToSubjectDistance = Self:GetCameraToSubjectDistance( )
    local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
    local Count = #Self.gamepadZoomLevels
    local I = Count

    for I = Count, 1, -1 do
        local Entry = Self.gamepadZoomLevels[ I ]

        if not ( CameraMaxZoomDistance < Entry ) then
            local Entry2

            if Entry < LocalPlayer.CameraMinZoomDistance then
                local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance

                if CameraMaxZoomDistance == CameraMinZoomDistance then
                    break
                end
                Entry2 = CameraMinZoomDistance
            else
                Entry2 = Entry
            end
            if Entry2 + ( CameraMaxZoomDistance - Entry2 ) / 2 < CameraToSubjectDistance then
                Self:SetCameraToSubjectDistance( Entry2 )
                return
            end

            CameraMaxZoomDistance = Entry2
        end
    end

    Self:SetCameraToSubjectDistance( Self.gamepadZoomLevels[ #Self.gamepadZoomLevels ] )
end
function __index.Enable( Self, Enabled )
    if Self.enabled ~= Enabled then
        Self.enabled = Enabled
        Self:OnEnabledChanged( )
    end
end
function __index.OnEnabledChanged( Enabled )
    if not Enabled.enabled then
        Enabled._connections:disconnectAll( )
        CameraInput.setInputEnabled( false )
        CameraGamepadZoomAction.Enabled = false
        Enabled:Cleanup( )
        return
    end

    Enabled:_setUpConfigurations( )
    CameraInput.setInputEnabled( true )
    CameraGamepadZoomAction.Enabled = true

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        Enabled.currentSubjectDistance = 0.5

        if not Enabled.inFirstPerson then
            Enabled:EnterFirstPerson( )
        end
    end
    if Enabled.cameraChangedConn then
        Enabled.cameraChangedConn:Disconnect( )
        Enabled.cameraChangedConn = nil
    end

    Enabled.cameraChangedConn = workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( function()
        Enabled:OnCurrentCameraChanged( )
    end )
    Enabled:OnCurrentCameraChanged( )
end
function __index.GetEnabled( Argument1 )
    return Argument1.enabled
end
function __index.Cleanup( Argument1 )
    if Argument1.subjectStateChangedConn then
        Argument1.subjectStateChangedConn:Disconnect( )
        Argument1.subjectStateChangedConn = nil
    end
    if Argument1.cameraChangedConn then
        Argument1.cameraChangedConn:Disconnect( )
        Argument1.cameraChangedConn = nil
    end

    Argument1.lastCameraTransform = nil
    Argument1.lastSubjectCFrame = nil
    CameraUtils.restoreMouseBehavior( )
end
function __index.UpdateMouseBehavior( Behavior )
    local Flag = UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and true or false

    if Behavior.isCameraToggle and Flag == false then
        CameraUI.setCameraModeToastEnabled( true )
        CameraInput.enableCameraToggleInput( )
        CameraToggleStateController( Behavior.inFirstPerson )
        return
    end

    CameraUI.setCameraModeToastEnabled( false )
    CameraInput.disableCameraToggleInput( )

    if Behavior.inFirstPerson or Behavior.inMouseLockedMode then
        CameraUtils.setRotationTypeOverride( Enum.RotationType.CameraRelative )
        CameraUtils.setMouseBehaviorOverride( Enum.MouseBehavior.LockCenter )
        return
    end

    CameraUtils.restoreRotationType( )

    if CameraInput.getPanActivated( ) then
        CameraUtils.setMouseBehaviorOverride( Enum.MouseBehavior.LockCurrentPosition )
        return
    end
    CameraUtils.restoreMouseBehavior( )
    return
end
function __index.UpdateForDistancePropertyChange( Self )
    Self:SetCameraToSubjectDistance( Self.currentSubjectDistance )
end
function __index.SetCameraToSubjectDistance( Self, Argument2 )
    local CurrentSubjectDistance = Self.currentSubjectDistance

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        Self.currentSubjectDistance = 0.5

        if not Self.inFirstPerson then
            Self:EnterFirstPerson( )
        end
    else
        local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
        local CurrentSubjectDistance2 = math.clamp( Argument2, CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance )

        if CurrentSubjectDistance2 < 1 then
            Self.currentSubjectDistance = 0.5

            if not Self.inFirstPerson then
                Self:EnterFirstPerson( )
            end
        else
            Self.currentSubjectDistance = CurrentSubjectDistance2

            if Self.inFirstPerson then
                Self:LeaveFirstPerson( )
            end
        end
    end

    ZoomController.SetZoomParameters( Self.currentSubjectDistance, ( math.sign( Argument2 - CurrentSubjectDistance ) ) )
    return Self.currentSubjectDistance
end
function __index.SetCameraType( Argument1, CameraType )
    Argument1.cameraType = CameraType
end
function __index.GetCameraType( Argument1 )
    return Argument1.cameraType
end
function __index.SetCameraMovementMode( Argument1, CameraMovementMode )
    Argument1.cameraMovementMode = CameraMovementMode
end
function __index.GetCameraMovementMode( Argument1 )
    return Argument1.cameraMovementMode
end
function __index.SetIsMouseLocked( Argument1, InMouseLockedMode )
    Argument1.inMouseLockedMode = InMouseLockedMode
end
function __index.GetIsMouseLocked( Argument1 )
    return Argument1.inMouseLockedMode
end
function __index.SetMouseLockOffset( Argument1, MouseLockOffset )
    Argument1.mouseLockOffset = MouseLockOffset
end
function __index.GetMouseLockOffset( Argument1 )
    return Argument1.mouseLockOffset
end
function __index.InFirstPerson( Argument1 )
    return Argument1.inFirstPerson
end
function __index.EnterFirstPerson( Self )
    Self.inFirstPerson = true
    Self:UpdateMouseBehavior( )
end
function __index.LeaveFirstPerson( Self )
    Self.inFirstPerson = false
    Self:UpdateMouseBehavior( )
end
function __index.GetCameraToSubjectDistance( Argument1 )
    return Argument1.currentSubjectDistance
end
function __index.GetMeasuredDistanceToFocus( Argument1 )
    local CurrentCamera = game.Workspace.CurrentCamera

    if CurrentCamera then
        return ( CurrentCamera.CoordinateFrame.Position - CurrentCamera.Focus.Position ).magnitude
    end
    return nil
end
function __index.GetCameraLookVector( Argument1 )
    local LookVector2

    if game.Workspace.CurrentCamera then
        local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector

        if LookVector then
            LookVector2 = LookVector
        else
            LookVector2 = Vector3.new( 0, 0, 1 )
        end
    else
        LookVector2 = Vector3.new( 0, 0, 1 )
    end

    return LookVector2
end
function __index.CalculateNewLookCFrameFromArg( Argument1, Argument2, Argument3 )
    local CameraLookVector

    if Argument2 then
        CameraLookVector = Argument2
    else
        CameraLookVector = Argument1:GetCameraLookVector( )
    end

    local Asin = math.asin( CameraLookVector.Y )
    local Y = Argument3.Y
    local Asin2 = Asin + -1.3962634015954636
    local Clamp = math.clamp( Y, Asin2, Asin + 1.3962634015954636 )
    local Vector22 = Vector2.new( Argument3.X, Clamp )
    local CFrame2 = CFrame.new( Vector3.new( 0, 0, 0 ), CameraLookVector )
    return CFrame.Angles( 0, -Vector22.X, 0 ) * CFrame2 * CFrame.Angles( -Vector22.Y, 0, 0 )
end
function __index.CalculateNewLookVectorFromArg( Argument1, Argument2, Argument3 )
    return Argument1:CalculateNewLookCFrameFromArg( Argument2, Argument3 ).LookVector
end
function __index.CalculateNewLookVectorVRFromArg( Argument1, Argument2 )
    local Unit = ( ( Argument1:GetSubjectPosition( ) - game.Workspace.CurrentCamera.CFrame.Position ) * Vector3.new( 1, 0, 1 ) ).unit
    local Vector22 = Vector2.new( Argument2.X, 0 )
    local CFrame2 = CFrame.new( Vector3.new( 0, 0, 0 ), Unit )
    return ( ( CFrame.Angles( 0, -Vector22.X, 0 ) * CFrame2 * CFrame.Angles( -Vector22.Y, 0, 0 ) ).LookVector * Vector3.new( 1, 0, 1 ) ).unit
end
function __index.GetHumanoid( Argument1 )
    if not ( LocalPlayer and LocalPlayer.Character ) then
        return nil
    end

    local Entry = Argument1.humanoidCache[ LocalPlayer ]

    if Entry and Entry.Parent == ( LocalPlayer and LocalPlayer.Character ) then
        return Entry
    end

    Argument1.humanoidCache[ LocalPlayer ] = nil
    local Humanoid = ( LocalPlayer and LocalPlayer.Character ):FindFirstChildOfClass( "Humanoid" )

    if Humanoid then
        Argument1.humanoidCache[ LocalPlayer ] = Humanoid
    end

    return Humanoid
end
function __index.OnNewCameraSubject( Argument1 )
    if Argument1.subjectStateChangedConn then
        Argument1.subjectStateChangedConn:Disconnect( )
        Argument1.subjectStateChangedConn = nil
    end
end
function __index.IsInFirstPerson( Argument1 )
    return Argument1.inFirstPerson
end
function __index.Update( Argument1, Argument2 )
    error( "BaseCamera:Update() This is a virtual function that should never be getting called.", 2 )
end
function __index.GetCameraHeight( Argument1 )
    if not VRService.VREnabled or Argument1.inFirstPerson then
        return 0
    end
    return 0.25881904510252074 * Argument1.currentSubjectDistance
end
return __index
