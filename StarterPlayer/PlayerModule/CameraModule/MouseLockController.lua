-- StarterPlayer.PlayerModule.CameraModule.MouseLockController
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local MouseLockSwitchAction = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "CameraContext" ):WaitForChild( "MouseLockSwitchAction" )
local Players = game:GetService( "Players" )
local UserInputService = game:GetService( "UserInputService" )
local GameSettings = UserSettings( ).GameSettings
local CameraUtils = require( script.Parent:WaitForChild( "CameraUtils" ) )
local UserFlag = Get.getUserFlag( "UserFixStuckShiftLock" )
local __index = { }
__index.__index = __index
function __index.new()
    local Self = setmetatable( { }, __index )
    Self.isMouseLocked = false
    Self.savedMouseCursor = nil
    Self.enabled = false
    Self.mouseLockToggledEvent = Instance.new( "BindableEvent" )
    GameSettings.Changed:Connect( function( Name )
        if Name == "ControlMode" or Name == "ComputerMovementMode" then
            Self:UpdateMouseLockAvailability( )
        end
    end )
    Players.LocalPlayer:GetPropertyChangedSignal( "DevEnableMouseLock" ):Connect( function()
        Self:UpdateMouseLockAvailability( )
    end )
    Players.LocalPlayer:GetPropertyChangedSignal( "DevComputerMovementMode" ):Connect( function()
        Self:UpdateMouseLockAvailability( )
    end )
    UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( function()
        Self:UpdateMouseLockAvailability( )
    end )
    Self:UpdateMouseLockAvailability( )
    MouseLockSwitchAction.Pressed:Connect( function()
        Self:OnMouseLockToggled( )
    end )
    return Self
end
function __index.GetIsMouseLocked( Argument1 )
    return Argument1.isMouseLocked
end
function __index.GetBindableToggleEvent( Argument1 )
    return Argument1.mouseLockToggledEvent.Event
end
function __index.GetMouseLockOffset( Argument1 )
    return Vector3.new( 1.75, 0, 0 )
end
function __index.UpdateMouseLockAvailability( Self )
    local Flag4
    local DevEnableMouseLock = Players.LocalPlayer.DevEnableMouseLock
    Flag4 = Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable and true or false
    local Flag2
    Flag2 = GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and true or false
    local Flag3
    Flag3 = GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and true or false
    local Flag
    Flag = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and true or false
    local Flag5

    if Flag then
        if DevEnableMouseLock then
            if Flag2 then
                local NotFlag = not Flag3

                if NotFlag then
                    Flag5 = not Flag4
                else
                    Flag5 = NotFlag
                end
            else
                Flag5 = Flag2
            end
        else
            Flag5 = DevEnableMouseLock
        end
    else
        Flag5 = Flag
    end
    if Flag5 ~= Self.enabled then
        Self:EnableMouseLock( Flag5 )
    end
end
function __index.OnMouseLockToggled( Argument1 )
    Argument1.isMouseLocked = not Argument1.isMouseLocked

    if Argument1.isMouseLocked then
        local CursorImage = script:FindFirstChild( "CursorImage" )

        if not CursorImage or not CursorImage:IsA( "StringValue" ) or not CursorImage.Value then
            if CursorImage then
                CursorImage:Destroy( )
            end

            local StringValue = Instance.new( "StringValue" )
            assert( StringValue, "" )
            StringValue.Name = "CursorImage"
            StringValue.Value = "rbxasset://textures/MouseLockedCursor.png"
            StringValue.Parent = script
            CameraUtils.setMouseIconOverride( "rbxasset://textures/MouseLockedCursor.png" )
        else
            CameraUtils.setMouseIconOverride( CursorImage.Value )
        end
    else
        CameraUtils.restoreMouseIcon( )
    end

    Argument1.mouseLockToggledEvent:Fire( )
end
function __index.IsMouseLocked( Argument1 )
    local Enabled2
    local Enabled = Argument1.enabled
    Enabled2 = if Enabled then Argument1.isMouseLocked else Enabled
    return Enabled2
end
function __index.EnableMouseLock( Argument1, Enabled )
    if Enabled == Argument1.enabled then
        return
    end

    Argument1.enabled = Enabled

    if Argument1.enabled then
        MouseLockSwitchAction.Enabled = true
        return
    end

    CameraUtils.restoreMouseIcon( )
    MouseLockSwitchAction.Enabled = false

    if UserFlag then
        if Argument1.isMouseLocked then
            Argument1.isMouseLocked = false
            Argument1.mouseLockToggledEvent:Fire( )
            return
        end
    else
        if Argument1.isMouseLocked then
            Argument1.mouseLockToggledEvent:Fire( )
        end

        Argument1.isMouseLocked = false
    end
end
return __index
