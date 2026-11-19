-- StarterPlayer.PlayerModule.ControlModule.TouchJump
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag2
local CommonUtils = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) )
local Get = CommonUtils.get( "ConnectionUtil" )
local Get2 = CommonUtils.get( "CharacterUtil" )
local Get3 = CommonUtils.get( "FlagUtil" )
local UserFlag = Get3.getUserFlag( "UserPlayerScriptsCCLIntegrationD" )

if UserFlag then
    UserFlag2 = UserFlag
else
    UserFlag2 = Get3.getUserFlag( "UserPlayerScriptsCCLIntegrationDGA" )
end

local UserFlag3 = Get3.getUserFlag( "UserPlayerScriptsRefactor1" )
local UserFlag4 = Get3.getUserFlag( "UserPlayerScriptsFixTouchJumpVisibility" )
game:GetService( "Players" )
local AvatarAbilitiesInterface = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) )
local Table = {
    "rbxasset://textures/ui/Input/JumpButtonRegular.png",
    "rbxasset://textures/ui/Input/JumpButtonPressed.png"
}
local Table2 = {
    HUMANOID_STATE_ENABLED_CHANGED = "HUMANOID_STATE_ENABLED_CHANGED",
    HUMANOID_JUMP_POWER = "HUMANOID_JUMP_POWER",
    HUMANOID_JUMP_HEIGHT = "HUMANOID_JUMP_HEIGHT",
    HUMANOID = "HUMANOID",
    ACTIONS_RELOADED = "ACTIONS_RELOADED"
}
local ActionController = require( script.Parent:WaitForChild( "ActionController" ) )
local Self = setmetatable( { }, ActionController )
Self.__index = Self
function Self.new( Data )
    local New = setmetatable( ActionController.new( ), Self )
    New.data = Data
    New._actionsReloadedConn = Data.eventBus:subscribe( "ACTIONS_RELOADED" ):Connect( function()
        New:Create( )

        if UserFlag4 and New._active then
            New._active = false
            New:EnableButton( true )
        end
    end )
    New.parentUIFrame = nil
    New.jumpButton = nil
    New.externallyEnabled = false
    New._active = false
    New._connectionUtil = Get.new( )
    return New
end
function Self._reset( Argument1 )
    if Argument1.jumpButton then
        if not UserFlag2 and AvatarAbilitiesInterface.isEnabled( ) then
            local JumpButton = Argument1.jumpButton
            JumpButton.Image = Table[ 1 ]
            return
        end

        local JumpButton2 = Argument1.jumpButton
        JumpButton2.ImageRectOffset = Vector2.new( 1, 146 )
    end
end
function Self.EnableButton( Self, _active )
    if _active == Self._active then
        return
    end
    if _active then
        if not Self.jumpButton then
            Self:Create( )
        end

        Self.jumpButton.Visible = true
    elseif Self.jumpButton then
        Self.jumpButton.Visible = false
    end

    Self:_reset( )
    Self._active = _active
end
function Self.UpdateEnabled( Self )
    local Child = Get2.getChild( "Humanoid", "Humanoid" )

    if Child and Self.externallyEnabled then
        if not Child.UseJumpPower or not ( Child.JumpPower > 0 ) then
            if not Child.UseJumpPower and Child.JumpHeight > 0 then
                if Child:GetStateEnabled( Enum.HumanoidStateType.Jumping ) then
                    Self:EnableButton( true )
                    return
                end
            end
        elseif Child:GetStateEnabled( Enum.HumanoidStateType.Jumping ) then
            Self:EnableButton( true )
            return
        end
    end

    Self:EnableButton( false )
end
function Self._setupConfigurations( Configurations )
    local function Update()
        Configurations:UpdateEnabled( )
    end

    local OnChild = Get2.onChild( "Humanoid", "Humanoid", function( Self )
        Configurations:UpdateEnabled( )
        Configurations:_reset( )
        local _connectionUtil = Configurations._connectionUtil
        _connectionUtil:trackConnection( "HUMANOID_JUMP_POWER", Self:GetPropertyChangedSignal( "JumpPower" ):Connect( Update ) )
        local _connectionUtil2 = Configurations._connectionUtil
        _connectionUtil2:trackConnection( "HUMANOID_JUMP_HEIGHT", Self:GetPropertyChangedSignal( "JumpHeight" ):Connect( Update ) )
        local _connectionUtil3 = Configurations._connectionUtil
        _connectionUtil3:trackConnection( "HUMANOID_STATE_ENABLED_CHANGED", Self.StateEnabledChanged:Connect( function( Argument1, Argument2 )
            if Argument1 == Enum.HumanoidStateType.Jumping and Argument2 ~= Configurations._active then
                Configurations:UpdateEnabled( )
            end
        end ) )
    end )
    Configurations._connectionUtil:trackConnection( "HUMANOID", OnChild )
end
function Self.Enable( Argument1, ExternallyEnabled, ParentUIFrame )
    if ParentUIFrame then
        Argument1.parentUIFrame = ParentUIFrame
    end
    if Argument1.externallyEnabled == ExternallyEnabled then
        return
    end

    Argument1.externallyEnabled = ExternallyEnabled
    ActionController.Enable( Argument1, ExternallyEnabled )
    Argument1:UpdateEnabled( )

    if ExternallyEnabled then
        Argument1:_setupConfigurations( )
        return
    end
    Argument1._connectionUtil:disconnectAll( )
    return
end
function Self.Destroy( Argument1 )
    if Argument1._actionsReloadedConn then
        Argument1._actionsReloadedConn:Disconnect( )
        Argument1._actionsReloadedConn = nil
    end
    if Argument1.jumpButton then
        Argument1.jumpButton:Destroy( )
        Argument1.jumpButton = nil
    end
    if Argument1.absoluteSizeChangedConn then
        Argument1.absoluteSizeChangedConn:Disconnect( )
        Argument1.absoluteSizeChangedConn = nil
    end
    if Argument1.avatarAbilitiesEnabledChangedConn then
        Argument1.avatarAbilitiesEnabledChangedConn:Disconnect( )
        Argument1.avatarAbilitiesEnabledChangedConn = nil
    end

    Argument1._connectionUtil:disconnectAll( )
    Argument1.externallyEnabled = false
    Argument1._active = false
    Argument1.parentUIFrame = nil
end
function Self.Create( Argument1 )
    if not Argument1.parentUIFrame then
        return
    end
    if Argument1.jumpButton then
        Argument1.jumpButton:Destroy( )
        Argument1.jumpButton = nil
    end
    if Argument1.absoluteSizeChangedConn then
        Argument1.absoluteSizeChangedConn:Disconnect( )
        Argument1.absoluteSizeChangedConn = nil
    end
    if not UserFlag2 and Argument1.avatarAbilitiesEnabledChangedConn then
        Argument1.avatarAbilitiesEnabledChangedConn:Disconnect( )
        Argument1.avatarAbilitiesEnabledChangedConn = nil
    end

    Argument1.jumpButton = Instance.new( "ImageButton" )
    Argument1.jumpButton.Name = "JumpButton"
    Argument1.jumpButton.Visible = false
    Argument1.jumpButton.BackgroundTransparency = 1

    if UserFlag3 then
        Argument1.jumpButton.ZIndex = 10
    end
    if UserFlag2 or not AvatarAbilitiesInterface.isEnabled( ) then
        Argument1.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        local JumpButton2 = Argument1.jumpButton
        JumpButton2.ImageRectOffset = Vector2.new( 1, 146 )
        local JumpButton3 = Argument1.jumpButton
        JumpButton3.ImageRectSize = Vector2.new( 144, 144 )
    else
        local JumpButton = Argument1.jumpButton
        JumpButton.Image = Table[ 1 ]
    end

    local function ResizeJumpButton()
        local Flag
        local X = Argument1.parentUIFrame.AbsoluteSize.x
        Flag = math.min( X, Argument1.parentUIFrame.AbsoluteSize.y ) <= 500 and true or false

        if UserFlag2 or not AvatarAbilitiesInterface.isEnabled( ) then
            local Number4 = not Flag and 120 or 70
            local Position
            Argument1.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
            local JumpButton6 = Argument1.jumpButton
            JumpButton6.ImageRectOffset = Vector2.new( 1, 146 )
            local JumpButton7 = Argument1.jumpButton
            JumpButton7.ImageRectSize = Vector2.new( 144, 144 )
            local JumpButton8 = Argument1.jumpButton
            JumpButton8.Size = UDim2.new( 0, Number4, 0, Number4 )
            local JumpButton9 = Argument1.jumpButton

            if Flag then
                local Amount3 = -( Number4 * 1.5 - 10 )
                local UDim22 = UDim2.new( 1, Amount3, 1, -Number4 - 20 )

                if UDim22 then
                    Position = UDim22
                else
                    local Amount4 = -( Number4 * 1.5 - 10 )
                    Position = UDim2.new( 1, Amount4, 1, -Number4 * 1.75 )
                end
            else
                local Amount4 = -( Number4 * 1.5 - 10 )
                Position = UDim2.new( 1, Amount4, 1, -Number4 * 1.75 )
            end

            JumpButton9.Position = Position
            return
        end
        local Number = not Flag and 120 or 72
        local Number2 = not Flag and 100 or 64
        local Number3 = not Flag and 112 or 64
        local Amount = -Number - Number2
        local Amount2 = -Number - Number3
        local JumpButton = Argument1.jumpButton
        JumpButton.Image = Table[ 1 ]
        local JumpButton2 = Argument1.jumpButton
        JumpButton2.ImageRectOffset = Vector2.new( 0, 0 )
        local JumpButton3 = Argument1.jumpButton
        JumpButton3.ImageRectSize = Vector2.new( 0, 0 )
        local JumpButton4 = Argument1.jumpButton
        JumpButton4.Size = UDim2.new( 0, Number, 0, Number )
        local JumpButton5 = Argument1.jumpButton
        JumpButton5.Position = UDim2.new( 1, Amount, 1, Amount2 )
        return
    end

    ResizeJumpButton( )
    Argument1.absoluteSizeChangedConn = Argument1.parentUIFrame:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( ResizeJumpButton )

    if not UserFlag2 then
        Argument1.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal( ):Connect( ResizeJumpButton )
    end

    local JumpButton4 = Argument1.jumpButton
    JumpButton4.Parent = Argument1.parentUIFrame

    if Argument1.data.controlModule.actions.JumpAction then
        local TouchBinding = Argument1.data.controlModule.actions.JumpAction:WaitForChild( "TouchBinding" )
        TouchBinding.UIButton = Argument1.jumpButton
        Argument1.data.controlModule.actions.JumpAction.Pressed:Connect( function()
            if not Argument1.jumpButton then
                return
            end
            if UserFlag2 or not AvatarAbilitiesInterface.isEnabled( ) then
                local JumpButton2 = Argument1.jumpButton
                JumpButton2.ImageRectOffset = Vector2.new( 146, 146 )
                return
            end
            local JumpButton = Argument1.jumpButton
            JumpButton.Image = Table[ 2 ]
            return
        end )
        Argument1.data.controlModule.actions.JumpAction.Released:Connect( function()
            if not Argument1.jumpButton then
                return
            end
            if UserFlag2 or not AvatarAbilitiesInterface.isEnabled( ) then
                local JumpButton2 = Argument1.jumpButton
                JumpButton2.ImageRectOffset = Vector2.new( 1, 146 )
                return
            end
            local JumpButton = Argument1.jumpButton
            JumpButton.Image = Table[ 1 ]
            return
        end )
        return
    end
    return
end
return Self
