-- StarterPlayer.PlayerModule.CameraModule
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local __index = { }
__index.__index = __index
local Table = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock"
}
local Table2 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode"
}
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local UserInputService = game:GetService( "UserInputService" )
local VRService = game:GetService( "VRService" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local CommonUtils = require( script.Parent:WaitForChild( "CommonUtils" ) )
local Get = CommonUtils.get( "ConnectionUtil" )
local Get2 = CommonUtils.get( "FlagUtil" )
local CameraUtils = require( script:WaitForChild( "CameraUtils" ) )
require( script:WaitForChild( "CameraInput" ) )
local ClassicCamera = require( script:WaitForChild( "ClassicCamera" ) )
local OrbitalCamera = require( script:WaitForChild( "OrbitalCamera" ) )
local LegacyCamera = require( script:WaitForChild( "LegacyCamera" ) )
local VehicleCamera = require( script:WaitForChild( "VehicleCamera" ) )
local VRCamera = require( script:WaitForChild( "VRCamera" ) )
local VRVehicleCamera = require( script:WaitForChild( "VRVehicleCamera" ) )
local Invisicam = require( script:WaitForChild( "Invisicam" ) )
local Poppercam = require( script:WaitForChild( "Poppercam" ) )
local TransparencyController = require( script:WaitForChild( "TransparencyController" ) )
local MouseLockController = require( script:WaitForChild( "MouseLockController" ) )
local Table3 = { }
local Table4 = { }

if not Players.LocalPlayer then
    return { }
end

assert( Players.LocalPlayer, "Strict typing check" )
local PlayerScripts = Players.LocalPlayer:WaitForChild( "PlayerScripts" )
PlayerScripts:RegisterTouchCameraMovementMode( Enum.TouchCameraMovementMode.Default )
PlayerScripts:RegisterTouchCameraMovementMode( Enum.TouchCameraMovementMode.Follow )
PlayerScripts:RegisterTouchCameraMovementMode( Enum.TouchCameraMovementMode.Classic )
PlayerScripts:RegisterComputerCameraMovementMode( Enum.ComputerCameraMovementMode.Default )
PlayerScripts:RegisterComputerCameraMovementMode( Enum.ComputerCameraMovementMode.Follow )
PlayerScripts:RegisterComputerCameraMovementMode( Enum.ComputerCameraMovementMode.Classic )
PlayerScripts:RegisterComputerCameraMovementMode( Enum.ComputerCameraMovementMode.CameraToggle )
local UserFlag = Get2.getUserFlag( "UserPlayerConnectionMemoryLeak" )
local UserFlag2 = Get2.getUserFlag( "UserPSFixCameraControllerReset" )
local UserFlag3 = Get2.getUserFlag( "UserPlayerModuleEngineAPI" )
local UserFlag4 = Get2.getUserFlag( "UserVRFixCameraCloseArticulation" )
local Get3 = CommonUtils.get( "VRFirstPersonState" )
function __index.new()
    local ConnectionUtil
    local TableInner = { activeTransparencyController = TransparencyController.new( ) }

    if UserFlag then
        ConnectionUtil = Get.new( )
    else
        ConnectionUtil = nil
    end

    TableInner.connectionUtil = ConnectionUtil
    local Self = setmetatable( TableInner, __index )
    Self.activeCameraController = nil
    Self.activeOcclusionModule = nil
    Self.activeMouseLockController = nil
    Self.currentComputerCameraMovementMode = nil
    Self.cameraSubjectChangedConn = nil
    Self.cameraTypeChangedConn = nil

    if not UserFlag3 then
        for Key, Value in pairs( Players:GetPlayers( ) ) do
            Self:OnPlayerAdded( Value )
        end

        Players.PlayerAdded:Connect( function( Argument1 )
            Self:OnPlayerAdded( Argument1 )
        end )

        if UserFlag then
            Players.PlayerRemoving:Connect( function( Argument1 )
                Self:OnPlayerRemoving( Argument1 )
            end )
        end
    end

    Self.activeTransparencyController:Enable( true )
    Self.activeMouseLockController = MouseLockController.new( )
    assert( Self.activeMouseLockController, "Strict typing check" )
    local BindableToggleEvent = Self.activeMouseLockController:GetBindableToggleEvent( )

    if BindableToggleEvent then
        BindableToggleEvent:Connect( function()
            Self:OnMouseLockToggled( )
        end )
    end

    Self:ActivateCameraController( )
    Self:ActivateOcclusionModule( Players.LocalPlayer.DevCameraOcclusionMode )
    Self:OnCurrentCameraChanged( )

    for Key2, Value3 in pairs( Table ) do
        Players.LocalPlayer:GetPropertyChangedSignal( Value3 ):Connect( function()
            Self:OnLocalPlayerCameraPropertyChanged( Value3 )
        end )
    end
    for Key3, Value5 in pairs( Table2 ) do
        UserGameSettings:GetPropertyChangedSignal( Value5 ):Connect( function()
            Self:OnUserGameSettingsPropertyChanged( Value5 )
        end )
    end

    game.Workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( function()
        Self:OnCurrentCameraChanged( )
    end )
    UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( function()
        Self:OnPreferredInputChanged( )
    end )
    return Self
end
function __index.GetCameraMovementModeFromSettings( Argument1 )
    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard( Enum.ComputerCameraMovementMode.Classic )
    end

    local CameraModeEnumToStandard, CameraModeEnumToStandard2

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        CameraModeEnumToStandard = CameraUtils.ConvertCameraModeEnumToStandard( Players.LocalPlayer.DevTouchCameraMode )
        CameraModeEnumToStandard2 = CameraUtils.ConvertCameraModeEnumToStandard( UserGameSettings.TouchCameraMovementMode )
    else
        CameraModeEnumToStandard = CameraUtils.ConvertCameraModeEnumToStandard( Players.LocalPlayer.DevComputerCameraMode )
        CameraModeEnumToStandard2 = CameraUtils.ConvertCameraModeEnumToStandard( UserGameSettings.ComputerCameraMovementMode )
    end
    if CameraModeEnumToStandard == Enum.DevComputerCameraMovementMode.UserChoice then
        return CameraModeEnumToStandard2
    end
    return CameraModeEnumToStandard
end
function __index.ActivateOcclusionModule( p1, p2 )
    -- Could not structure function #9
end
function __index.ShouldUseVehicleCamera( Argument1 )
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return false
    end

    local Flag
    local CameraType = CurrentCamera.CameraType
    local CameraSubject = CurrentCamera.CameraSubject

    if CameraType == Enum.CameraType.Custom then
        Flag = true
    elseif CameraType == Enum.CameraType.Follow then
        Flag = true
    else
        Flag = false
    end

    local IsA = CameraSubject and CameraSubject:IsA( "VehicleSeat" ) or false
    local Flag2
    Flag2 = Argument1.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam and true or false
    local IsA2

    if IsA then
        if Flag then
            IsA2 = Flag2
        else
            IsA2 = Flag
        end
    else
        IsA2 = IsA
    end

    return IsA2
end
function __index.ActivateCameraController( Self )
    local CameraType = workspace.CurrentCamera.CameraType
    local CameraMovementModeFromSettings = Self:GetCameraMovementModeFromSettings( )

    if CameraType == Enum.CameraType.Scriptable then
        if Self.activeCameraController then
            Self.activeCameraController:Enable( false )
            Self.activeCameraController = nil
        end

        return
    end
    local Captured

    if CameraType == Enum.CameraType.Custom then
        CameraMovementModeFromSettings = Self:GetCameraMovementModeFromSettings( )
        Captured = nil
    elseif CameraType == Enum.CameraType.Track then
        Captured = nil
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Classic
    elseif CameraType == Enum.CameraType.Follow then
        Captured = nil
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Follow
    elseif CameraType == Enum.CameraType.Orbital then
        Captured = nil
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Orbital
    elseif CameraType == Enum.CameraType.Attach or CameraType == Enum.CameraType.Watch or CameraType == Enum.CameraType.Fixed then
        Captured = LegacyCamera
    else
        warn( "CameraScript encountered an unhandled Camera.CameraType value: ", CameraType )
        Captured = nil
    end
    if not Captured then
        if VRService.VREnabled then
            Captured = VRCamera
        elseif CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Classic or CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Follow or CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Default or CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.CameraToggle then
            Captured = ClassicCamera
        else
            if CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.Orbital then
                warn( "ActivateCameraController did not select a module." )
                return
            end

            Captured = OrbitalCamera
        end
    end
    if Self:ShouldUseVehicleCamera( ) then
        if VRService.VREnabled then
            Captured = VRVehicleCamera
        else
            Captured = VehicleCamera
        end
    end

    local ActiveCameraController

    if Table3[ Captured ] then
        local Entry = Table3[ Captured ]

        if UserFlag2 then
            if not Entry.Reset or Self.activeCameraController == Entry then
                ActiveCameraController = Entry
            else
                Entry:Reset( )
                ActiveCameraController = Entry
            end
        elseif Entry.Reset then
            Entry:Reset( )
            ActiveCameraController = Entry
        else
            ActiveCameraController = Entry
        end
    else
        local New = Captured.new( )
        Table3[ Captured ] = New
        ActiveCameraController = New
    end
    if Self.activeCameraController then
        if Self.activeCameraController == ActiveCameraController then
            if not Self.activeCameraController:GetEnabled( ) then
                Self.activeCameraController:Enable( true )
            end
        else
            if ActiveCameraController.HandleSubjectDistance then
                ActiveCameraController:HandleSubjectDistance( Self.activeCameraController )
            end

            Self.activeCameraController:Enable( false )
            Self.activeCameraController = ActiveCameraController
            Self.activeCameraController:Enable( true )
        end
    elseif ActiveCameraController ~= nil then
        Self.activeCameraController = ActiveCameraController
        assert( Self.activeCameraController, "Strict typing check" )
        Self.activeCameraController:Enable( true )
    end
    if Self.activeCameraController then
        Self.activeCameraController:SetCameraMovementMode( CameraMovementModeFromSettings )
        Self.activeCameraController:SetCameraType( CameraType )
    end

    return
end
function __index.OnCameraSubjectChanged( Self )
    local CameraSubject
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        CameraSubject = CurrentCamera.CameraSubject
    else
        CameraSubject = nil
    end
    if Self.activeTransparencyController then
        Self.activeTransparencyController:SetSubject( CameraSubject )
    end
    if Self.activeOcclusionModule then
        Self.activeOcclusionModule:OnCameraSubjectChanged( CameraSubject )
    end

    Self:ActivateCameraController( )
end
function __index.OnCameraTypeChanged( Argument1, Argument2 )
    if Argument2 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior( )
    end

    Argument1:ActivateCameraController( )
end
function __index.OnCurrentCameraChanged( Camera )
    local CurrentCamera = game.Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end
    if Camera.cameraSubjectChangedConn then
        Camera.cameraSubjectChangedConn:Disconnect( )
    end
    if Camera.cameraTypeChangedConn then
        Camera.cameraTypeChangedConn:Disconnect( )
    end

    Camera.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal( "CameraSubject" ):Connect( function()
        Camera:OnCameraSubjectChanged( )
    end )
    Camera.cameraTypeChangedConn = CurrentCamera:GetPropertyChangedSignal( "CameraType" ):Connect( function()
        Camera:OnCameraTypeChanged( CurrentCamera.CameraType )
    end )
    Camera:OnCameraSubjectChanged( )
    Camera:OnCameraTypeChanged( CurrentCamera.CameraType )
end
function __index.OnLocalPlayerCameraPropertyChanged( Self, PropertyName )
    if PropertyName == "CameraMode" then
        if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
            if not Self.activeCameraController or Self.activeCameraController:GetModuleName( ) ~= "ClassicCamera" then
                Self:ActivateCameraController( )
            end
            if Self.activeCameraController then
                Self.activeCameraController:UpdateForDistancePropertyChange( )
                return
            end
            return
        elseif Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
            Self:ActivateCameraController( )
            return
        else
            warn( "Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode )
            return
        end
    else
        if PropertyName == "DevComputerCameraMode" or PropertyName == "DevTouchCameraMode" then
            Self:ActivateCameraController( )
            return
        end
        if PropertyName == "DevCameraOcclusionMode" then
            Self:ActivateOcclusionModule( Players.LocalPlayer.DevCameraOcclusionMode )
            return
        end
        if PropertyName ~= "CameraMinZoomDistance" and PropertyName ~= "CameraMaxZoomDistance" then
            if PropertyName == "DevTouchMovementMode" then
                return
            end
            if PropertyName == "DevComputerMovementMode" then
                return
            end

            return
        end
        if Self.activeCameraController then
            Self.activeCameraController:UpdateForDistancePropertyChange( )
            return
        end
        return
    end
end
function __index.OnUserGameSettingsPropertyChanged( Argument1, PropertyName )
    if PropertyName == "ComputerCameraMovementMode" then
        Argument1:ActivateCameraController( )
    end
end
function __index.OnPreferredInputChanged( Input )
    Input:ActivateCameraController( )
end
function __index.Update( Argument1, Argument2, Argument3 )
    if Argument1.activeCameraController then
        Argument1.activeCameraController:UpdateMouseBehavior( )
        local Update, Update2 = Argument1.activeCameraController:Update( Argument3 )

        if UserFlag4 and VRService.VREnabled and Argument1.activeCameraController.IsInFirstPerson then
            Get3.inFirstPerson = Argument1.activeCameraController:IsInFirstPerson( )
        end

        local CFrame, Focus
        local CurrentCamera = game.Workspace.CurrentCamera

        if not Argument1.activeOcclusionModule or Argument1.activeCameraController.skipOcclusion then
            CFrame = Update
            Focus = Update2
        else
            CFrame, Focus = Argument1.activeOcclusionModule:Update( Argument3, Update, Update2, Argument2 )
        end

        CurrentCamera.CFrame = CFrame
        CurrentCamera.Focus = Focus

        if Argument1.activeTransparencyController then
            Argument1.activeTransparencyController:Update( Argument3 )
            return
        end
    elseif UserFlag4 and VRService.VREnabled then
        Get3.inFirstPerson = false
    end
end

if not UserFlag3 then
    function __index.OnCharacterAdded( Argument1, Argument2, Argument3 )
        if Argument1.activeOcclusionModule then
            Argument1.activeOcclusionModule:CharacterAdded( Argument2, Argument3 )
        end
    end
    function __index.OnCharacterRemoving( Argument1, Argument2, Argument3 )
        if Argument1.activeOcclusionModule then
            Argument1.activeOcclusionModule:CharacterRemoving( Argument2, Argument3 )
        end
    end
    function __index.OnPlayerAdded( Argument1, Player )
        if UserFlag then
            if Argument1.connectionUtil then
                Argument1.connectionUtil:trackConnection( ( "%*CharacterAdded" ):format( Player.UserId ), Player.CharacterAdded:Connect( function( Argument1Inner )
                    Argument1:OnCharacterAdded( Argument1Inner, Player )
                end ) )
                Argument1.connectionUtil:trackConnection( ( "%*CharacterRemoving" ):format( Player.UserId ), Player.CharacterRemoving:Connect( function( Argument1Inner )
                    Argument1:OnCharacterRemoving( Argument1Inner, Player )
                end ) )
                return
            end
        else
            Player.CharacterAdded:Connect( function( Argument1Inner )
                Argument1:OnCharacterAdded( Argument1Inner, Player )
            end )
            Player.CharacterRemoving:Connect( function( Argument1Inner )
                Argument1:OnCharacterRemoving( Argument1Inner, Player )
            end )
        end
    end
    function __index.OnPlayerRemoving( Argument1, Player )
        if Argument1.connectionUtil then
            Argument1.connectionUtil:disconnect( ( ( "%*CharacterAdded" ):format( Player.UserId ) ) )
            Argument1.connectionUtil:disconnect( ( ( "%*CharacterRemoving" ):format( Player.UserId ) ) )
        end
    end
end

function __index.OnMouseLockToggled( Argument1 )
    if Argument1.activeMouseLockController then
        local IsMouseLocked = Argument1.activeMouseLockController:GetIsMouseLocked( )
        local MouseLockOffset = Argument1.activeMouseLockController:GetMouseLockOffset( )

        if Argument1.activeCameraController then
            Argument1.activeCameraController:SetIsMouseLocked( IsMouseLocked )
            Argument1.activeCameraController:SetMouseLockOffset( MouseLockOffset )
        end
    end
end

if RunService:IsClient( ) then
    return __index.new( )
end
return __index
