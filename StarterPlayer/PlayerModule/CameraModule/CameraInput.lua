-- StarterPlayer.PlayerModule.CameraModule.CameraInput
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local MicroGamepadBinding
game:GetService( "ContextActionService" )
local UserInputService = game:GetService( "UserInputService" )
game:GetService( "Players" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
game:GetService( "VRService" )
local GuiService = game:GetService( "GuiService" )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserPSTextboxResetCameraInput" )
local UserFlag2 = Get.getUserFlag( "UserPlayerScriptsSupportTVRemoteKeycodes" )
local CameraContext = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "CameraContext" )
local CameraRotationAction = CameraContext:WaitForChild( "CameraRotationAction" )
local CameraZoomAction = CameraContext:WaitForChild( "CameraZoomAction" )
local GamepadBinding = CameraRotationAction:WaitForChild( "GamepadBinding" )

if UserFlag2 then
    MicroGamepadBinding = CameraRotationAction:WaitForChild( "MicroGamepadBinding" )
else
    MicroGamepadBinding = nil
end

local MouseBinding = CameraRotationAction:WaitForChild( "MouseBinding" )
local TrackpadBinding = CameraRotationAction:WaitForChild( "TrackpadBinding" )
local CameraToggleAction = CameraContext:WaitForChild( "CameraToggleAction" )
local CameraPanActiveAction = CameraContext:WaitForChild( "CameraPanActiveAction" )
local Number = 1

local function UpdateCameraYInvert()
    local CameraYInvertValue = UserGameSettings:GetCameraYInvertValue( )

    if CameraYInvertValue == Number then
        return
    end

    Number = CameraYInvertValue

    for Key, Value in CameraRotationAction:GetChildren( ) do
        if Value:IsA( "InputBinding" ) then
            local Vector2Scale = Value.Vector2Scale
            Value.Vector2Scale = Vector2.new( Vector2Scale.X, -Vector2Scale.Y )
        end
    end
end

local function UpdateGamepadCameraSensitivity()
    GamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity

    if UserFlag2 and MicroGamepadBinding then
        MicroGamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity
    end
end

local function UpdateMouseCameraSensitivity()
    local Scale = UserGameSettings.MouseSensitivity
    MouseBinding.Scale = Scale
    TrackpadBinding.Scale = Scale
end

UserGameSettings:GetPropertyChangedSignal( "GamepadCameraSensitivity" ):Connect( UpdateGamepadCameraSensitivity )
GamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity

if UserFlag2 and MicroGamepadBinding then
    MicroGamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity
end

UserGameSettings:GetPropertyChangedSignal( "MouseSensitivity" ):Connect( UpdateMouseCameraSensitivity )
local Scale = UserGameSettings.MouseSensitivity
MouseBinding.Scale = Scale
TrackpadBinding.Scale = Scale
UpdateCameraYInvert( )

local function AdjustTouchPitchSensitivity( Sensitivity )
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return Sensitivity
    end

    local ToEulerAnglesYXZ = CurrentCamera.CFrame:ToEulerAnglesYXZ( )

    if Sensitivity.Y * ToEulerAnglesYXZ >= 0 then
        return Sensitivity
    end
    return Vector2.new( 1, ( 1 - ( math.abs( ToEulerAnglesYXZ ) * 2 / 3.141592653589793 ) ^ 0.75 ) * 0.75 + 0.25 ) * Sensitivity
end

local Number2 = 0

local function IncPanInputCount()
    Number2 = math.max( 0, Number2 + 1 )
end

local function DecPanInputCount()
    Number2 = math.max( 0, Number2 - 1 )
end

local function ResetPanInputCount()
    Number2 = 0
end

local function GetRotationActivated()
    local Flag

    if Number2 > 0 then
        Flag = true
    elseif CameraRotationAction:GetState( ).Magnitude > 0 then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function GetPanActivated()
    local Flag = Number2 > 0 and true or false
    return Flag
end

local function GetRotation( Sensitivity )
    local State2
    UpdateCameraYInvert( )
    local State = CameraRotationAction:GetState( ) * Sensitivity

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        State2 = AdjustTouchPitchSensitivity( State )
    else
        State2 = State
    end

    return State2
end

local function GetZoomDelta( Argument1 )
    return CameraZoomAction:GetState( ) * Argument1
end

CameraPanActiveAction.Pressed:Connect( IncPanInputCount )
CameraPanActiveAction.Released:Connect( DecPanInputCount )
local Flag = false
local Table = {
    getRotationActivated = GetRotationActivated,
    getPanActivated = GetPanActivated,
    getRotation = GetRotation,
    getZoomDelta = GetZoomDelta,
    setInputEnabled = function( Enabled )
        if Flag == Enabled then
            return
        end

        Flag = Enabled
        Number2 = 0

        if Flag then
            CameraZoomAction.Enabled = true
            CameraRotationAction.Enabled = true
            CameraPanActiveAction.Enabled = true
            return
        end
        CameraZoomAction.Enabled = false
        CameraRotationAction.Enabled = false
        CameraPanActiveAction.Enabled = false
        return
    end,
    getInputEnabled = function()
        return Flag
    end
}
UserInputService.WindowFocused:Connect( ResetPanInputCount )
UserInputService.WindowFocusReleased:Connect( ResetPanInputCount )
GuiService.MenuOpened:Connect( ResetPanInputCount )

if UserFlag then
    UserInputService.TextBoxFocusReleased:Connect( ResetPanInputCount )
end

local Flag2 = false
local Flag3 = false
local Number3 = 0
function Table.getHoldPan()
    return Flag2
end
function Table.getTogglePan()
    return Flag3
end
function Table.getPanning()
    return Flag3 or Flag2
end
function Table.setTogglePan( Pan )
    Flag3 = Pan
end
local Flag4 = false
CameraToggleAction.Pressed:Connect( function()
    Flag2 = true
    Number3 = tick( )
end )
CameraToggleAction.Released:Connect( function()
    Flag2 = false

    if tick( ) - Number3 < 0.3 then
        if Flag3 or UserInputService:GetMouseDelta( ).Magnitude < 2 then
            Flag3 = not Flag3
        end
    end
end )
function Table.enableCameraToggleInput()
    if Flag4 then
        return
    end
    Flag4 = true
    Flag2 = false
    Flag3 = false
    CameraToggleAction.Enabled = true
    return
end
function Table.disableCameraToggleInput()
    if Flag4 then
        Flag4 = false
        CameraToggleAction.Enabled = false
        return
    end
    return
end
return Table
