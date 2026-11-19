-- StarterPlayer.PlayerModule.ControlModule.ClassicThumbstick
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag2
local GuiService = game:GetService( "GuiService" )
local Players = game:GetService( "Players" )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationD" )

if UserFlag then
    UserFlag2 = UserFlag
else
    UserFlag2 = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationDGA" )
end

local Get2
local UserFlag3 = Get.getUserFlag( "UserPlayerScriptsClassicThumbstickRenameUI" )
local UserFlag4 = Get.getUserFlag( "UserAbilitiesUserInterfaceC" )
local UserFlag5 = Get.getUserFlag( "UserPlayerScriptsResetDTTouchOnCreate" )
local ThumbstickAction = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "TransformerContext" ):WaitForChild( "ThumbstickAction" )
local Vector22 = Vector2.new( -1, -1 )
local AvatarAbilitiesInterface = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) )

if UserFlag2 then
    Get2 = AvatarAbilitiesInterface.get( Players.LocalPlayer )
else
    Get2 = nil
end

local ActionController = require( script.Parent:WaitForChild( "ActionController" ) )
local Self = setmetatable( { }, ActionController )
Self.__index = Self
function Self.new( Data )
    local New = setmetatable( ActionController.new( ), Self )
    New.data = Data
    New.enabled = false
    New.isTouchActive = false
    New.isFollowStick = false
    New.thumbstickFrame = nil
    New.screenPos = nil
    New.stickImage = nil
    New.thumbstickSize = nil
    return New
end

local function SetupThumbstickInput( Input )
    for Key, Value in ThumbstickAction:GetChildren( ) do
        if Value.Name == "DynamicTouchBinding" or Value.Name == "ClassicTouchBinding" then
            Value:Destroy( )
        end
    end

    local InputBinding = Instance.new( "InputBinding" )
    InputBinding.Name = "ClassicTouchBinding"
    InputBinding.KeyCode = Enum.KeyCode.TouchPosition
    InputBinding.UIModifier = Input.thumbstickButton
    InputBinding.Parent = ThumbstickAction
end

local function EnableThumbstickInput( Input, Argument2 )
    if Argument2 then
        SetupThumbstickInput( Input )
        Input.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect( Input.onStateChanged )
        ThumbstickAction.Enabled = true
        return
    end

    ThumbstickAction.Enabled = false

    if Input.thumbstickStateChangedConn then
        Input.thumbstickStateChangedConn:Disconnect( )
        Input.thumbstickStateChangedConn = nil
    end
end

function Self.Enable( Input, Argument2, Argument3 )
    if Argument2 == nil then
        return false
    end

    local Enabled = if Argument2 then true else false

    if Input.enabled == Enabled then
        return true
    end

    ActionController.Enable( Input, Enabled )
    Input.isJumping = false

    if Enabled then
        if not Input.thumbstickFrame then
            Input:Create( Argument3 )
        end
        if UserFlag5 then
            SetupThumbstickInput( Input )
            Input.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect( Input.onStateChanged )
            ThumbstickAction.Enabled = true
        else
            Input.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect( Input.onStateChanged )
            ThumbstickAction.Enabled = true
        end

        Input.thumbstickFrame.Visible = true
    else
        if UserFlag5 then
            ThumbstickAction.Enabled = false

            if Input.thumbstickStateChangedConn then
                Input.thumbstickStateChangedConn:Disconnect( )
                Input.thumbstickStateChangedConn = nil
            end
        else
            ThumbstickAction.Enabled = false

            if Input.thumbstickStateChangedConn then
                Input.thumbstickStateChangedConn:Disconnect( )
                Input.thumbstickStateChangedConn = nil
            end
        end

        Input.thumbstickFrame.Visible = false
        Input:OnInputEnded( )
    end

    Input.enabled = Enabled
end
function Self.OnInputEnded( Input )
    Input.isTouchActive = false
    local ThumbstickFrame = Input.thumbstickFrame
    ThumbstickFrame.Position = Input.screenPos
    local StickImage = Input.stickImage
    local Offset = Input.thumbstickFrame.Size.X.Offset / 2 - Input.thumbstickSize / 4
    StickImage.Position = UDim2.new( 0, Offset, 0, Input.thumbstickFrame.Size.Y.Offset / 2 - Input.thumbstickSize / 4 )
    local ClassicThumbstickScriptableBinding = Input.data.controlModule.actions.MoveAction:FindFirstChild( "ClassicThumbstickScriptableBinding" )

    if ClassicThumbstickScriptableBinding then
        ClassicThumbstickScriptableBinding:Fire( Vector2.zero )
    end

    Input.isJumping = false
    local ThumbstickFrame2 = Input.thumbstickFrame
    ThumbstickFrame2.Position = Input.screenPos
end
function Self.Create( Argument1, Parent )
    if Argument1.thumbstickFrame then
        ThumbstickAction.Enabled = false

        if Argument1.thumbstickStateChangedConn then
            Argument1.thumbstickStateChangedConn:Disconnect( )
            Argument1.thumbstickStateChangedConn = nil
        end

        Argument1.thumbstickFrame:Destroy( )
        Argument1.thumbstickFrame = nil

        if Argument1.absoluteSizeChangedConn then
            Argument1.absoluteSizeChangedConn:Disconnect( )
            Argument1.absoluteSizeChangedConn = nil
        end
        if Argument1.avatarAbilitiesEnabledChangedConn then
            Argument1.avatarAbilitiesEnabledChangedConn:Disconnect( )
            Argument1.avatarAbilitiesEnabledChangedConn = nil
        end
    end

    local Name
    Argument1.thumbstickFrame = Instance.new( "Frame" )
    local ThumbstickFrame = Argument1.thumbstickFrame
    Name = not UserFlag3 and "ThumbstickFrame" or "ClassicThumbstickFrame"
    ThumbstickFrame.Name = Name
    Argument1.thumbstickFrame.Active = true
    Argument1.thumbstickFrame.Visible = false
    Argument1.thumbstickFrame.BackgroundTransparency = 1
    local ImageLabel = Instance.new( "ImageLabel" )
    ImageLabel.Name = "OuterImage"
    ImageLabel.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    ImageLabel.ImageRectOffset = Vector2.new( )
    ImageLabel.ImageRectSize = Vector2.new( 220, 220 )
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new( 0, 0, 0, 0 )
    Argument1.stickImage = Instance.new( "ImageLabel" )
    Argument1.stickImage.Name = "StickImage"
    Argument1.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    local StickImage = Argument1.stickImage
    StickImage.ImageRectOffset = Vector2.new( 220, 0 )
    local StickImage2 = Argument1.stickImage
    StickImage2.ImageRectSize = Vector2.new( 111, 111 )
    Argument1.stickImage.BackgroundTransparency = 1
    Argument1.stickImage.ZIndex = 2

    local function ResizeThumbstick()
        local Flag
        local X = Parent.AbsoluteSize.X
        Flag = math.min( X, Parent.AbsoluteSize.Y ) <= 500 and true or false
        local IsEnabled

        if UserFlag2 then
            IsEnabled = Get2:isEnabled( )
        else
            IsEnabled = AvatarAbilitiesInterface.isEnabled( )
        end
        if IsEnabled then
            local Number = not Flag and 100 or 64
            local Number2 = not Flag and 112 or 64
            local ThumbstickSize = not Flag and 120 or 72
            Argument1.thumbstickSize = ThumbstickSize
            Argument1.screenPos = UDim2.new( 0, Number, 1, -Argument1.thumbstickSize - Number2 )
        else
            local ThumbstickSize2 = not Flag and 120 or 70
            local ScreenPos
            Argument1.thumbstickSize = ThumbstickSize2

            if Flag then
                local ThumbstickSize3 = Argument1.thumbstickSize / 2 - 10
                local UDim22 = UDim2.new( 0, ThumbstickSize3, 1, -Argument1.thumbstickSize - 20 )

                if UDim22 then
                    ScreenPos = UDim22
                else
                    local ThumbstickSize4 = Argument1.thumbstickSize / 2
                    ScreenPos = UDim2.new( 0, ThumbstickSize4, 1, -Argument1.thumbstickSize * 1.75 )
                end
            else
                local ThumbstickSize4 = Argument1.thumbstickSize / 2
                ScreenPos = UDim2.new( 0, ThumbstickSize4, 1, -Argument1.thumbstickSize * 1.75 )
            end

            Argument1.screenPos = ScreenPos
        end

        local ThumbstickFrame = Argument1.thumbstickFrame
        local ThumbstickSize5 = Argument1.thumbstickSize
        ThumbstickFrame.Size = UDim2.new( 0, ThumbstickSize5, 0, Argument1.thumbstickSize )
        local ThumbstickFrame2 = Argument1.thumbstickFrame
        ThumbstickFrame2.Position = Argument1.screenPos
        local ThumbstickSize6 = Argument1.thumbstickSize
        ImageLabel.Size = UDim2.new( 0, ThumbstickSize6, 0, Argument1.thumbstickSize )
        local StickImage = Argument1.stickImage
        local ThumbstickSize7 = Argument1.thumbstickSize / 2
        StickImage.Size = UDim2.new( 0, ThumbstickSize7, 0, Argument1.thumbstickSize / 2 )
        local StickImage2 = Argument1.stickImage
        local ThumbstickSize8 = Argument1.thumbstickSize / 2 - Argument1.thumbstickSize / 4
        StickImage2.Position = UDim2.new( 0, ThumbstickSize8, 0, Argument1.thumbstickSize / 2 - Argument1.thumbstickSize / 4 )
    end

    ResizeThumbstick( )
    Argument1.absoluteSizeChangedConn = Parent:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( ResizeThumbstick )

    if UserFlag2 then
        Argument1.avatarAbilitiesEnabledChangedConn = Get2:GetEnabledChangedSignal( ):Connect( ResizeThumbstick )
    else
        Argument1.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal( ):Connect( ResizeThumbstick )
    end

    ImageLabel.Parent = Argument1.thumbstickFrame
    local StickImage3 = Argument1.stickImage
    StickImage3.Parent = Argument1.thumbstickFrame
    Argument1.thumbstickButton = Instance.new( "ImageButton" )
    Argument1.thumbstickButton.Name = "ClassicThumbstickUIModifier"
    Argument1.thumbstickButton.BackgroundTransparency = 1
    Argument1.thumbstickButton.ImageTransparency = 1
    Argument1.thumbstickButton.AutoButtonColor = false
    local ThumbstickButton = Argument1.thumbstickButton
    ThumbstickButton.Size = UDim2.new( 1, 0, 1, 0 )
    local ThumbstickButton2 = Argument1.thumbstickButton
    ThumbstickButton2.ZIndex = Argument1.thumbstickFrame.ZIndex
    Argument1.thumbstickButton.Visible = true
    Argument1.thumbstickButton.Active = false
    local ThumbstickButton3 = Argument1.thumbstickButton
    ThumbstickButton3.Parent = Argument1.thumbstickFrame

    if not UserFlag5 then
        local InputBinding = Instance.new( "InputBinding" )
        InputBinding.Name = "ClassicTouchBinding"
        InputBinding.KeyCode = Enum.KeyCode.TouchPosition
        InputBinding.UIModifier = Argument1.thumbstickButton
        InputBinding.Parent = ThumbstickAction
    end

    local Value1 = nil

    local function DoMove( Argument1Inner )
        local Vector22
        local ThumbstickSize = Argument1Inner / ( Argument1.thumbstickSize / 2 )
        local Magnitude = ThumbstickSize.magnitude

        if Magnitude < 0.05 then
            Vector22 = Vector2.new( )
        else
            Vector22 = ThumbstickSize.unit * math.min( 1, ( Magnitude - 0.05 ) / 0.95 )
        end

        local Vector23 = Vector2.new( Vector22.X, -Vector22.Y )
        local ClassicThumbstickScriptableBinding = Argument1.data.controlModule.actions.MoveAction:FindFirstChild( "ClassicThumbstickScriptableBinding" )

        if ClassicThumbstickScriptableBinding then
            ClassicThumbstickScriptableBinding:Fire( Vector23 )
        end
    end

    local function MoveStick( Argument1Inner )
        local Vector23
        local Vector22 = Vector2.new( Argument1Inner.X - Value1.X, Argument1Inner.Y - Value1.Y )
        local Magnitude = Vector22.magnitude
        local X = Argument1.thumbstickFrame.AbsoluteSize.X / 2

        if not Argument1.isFollowStick or not ( X < Magnitude ) then
            local Min = math.min( Magnitude, X )
            Vector23 = Vector22.unit * Min
        else
            local Unit = Vector22.unit * X

            if UserFlag4 then
                local AbsolutePosition = Parent.AbsolutePosition
                local ThumbstickFrame = Argument1.thumbstickFrame
                local X2 = Argument1Inner.X - AbsolutePosition.X - Argument1.thumbstickFrame.AbsoluteSize.X / 2 - Unit.X
                ThumbstickFrame.Position = UDim2.new( 0, X2, 0, Argument1Inner.Y - AbsolutePosition.Y - Argument1.thumbstickFrame.AbsoluteSize.Y / 2 - Unit.Y )
                Vector23 = Vector22
            else
                local ThumbstickFrame2 = Argument1.thumbstickFrame
                local X3 = Argument1Inner.X - Argument1.thumbstickFrame.AbsoluteSize.X / 2 - Unit.X
                ThumbstickFrame2.Position = UDim2.new( 0, X3, 0, Argument1Inner.Y - Argument1.thumbstickFrame.AbsoluteSize.Y / 2 - Unit.Y )
                Vector23 = Vector22
            end
        end

        local StickImage = Argument1.stickImage
        local X4 = Vector23.X + Argument1.stickImage.AbsoluteSize.X / 2
        StickImage.Position = UDim2.new( 0, X4, 0, Vector23.Y + Argument1.stickImage.AbsoluteSize.Y / 2 )
    end

    function Argument1.onStateChanged( Argument1Inner )
        if Argument1Inner == Vector22 then
            if Argument1.isTouchActive then
                Argument1:OnInputEnded( )
            end

            return
        end
        local Min = GuiService:GetInsetArea( Enum.ScreenInsets.None ).Min
        local X = Argument1Inner.X + Min.X
        local Vector32 = Vector3.new( X, Argument1Inner.Y + Min.Y, 0 )

        if Argument1.isTouchActive then
            Value1 = Vector2.new( Argument1.thumbstickFrame.AbsolutePosition.X + Argument1.thumbstickFrame.AbsoluteSize.X / 2, Argument1.thumbstickFrame.AbsolutePosition.Y + Argument1.thumbstickFrame.AbsoluteSize.Y / 2 )
            DoMove( ( Vector2.new( Vector32.X - Value1.X, Vector32.Y - Value1.Y ) ) )
            MoveStick( Vector32 )
            return
        end

        Argument1.isTouchActive = true

        if UserFlag4 then
            local AbsolutePosition = Parent.AbsolutePosition
            local ThumbstickFrame = Argument1.thumbstickFrame
            local X2 = Vector32.X - AbsolutePosition.X - Argument1.thumbstickFrame.Size.X.Offset / 2
            ThumbstickFrame.Position = UDim2.new( 0, X2, 0, Vector32.Y - AbsolutePosition.Y - Argument1.thumbstickFrame.Size.Y.Offset / 2 )
        else
            local ThumbstickFrame2 = Argument1.thumbstickFrame
            local X3 = Vector32.X - Argument1.thumbstickFrame.Size.X.Offset / 2
            ThumbstickFrame2.Position = UDim2.new( 0, X3, 0, Vector32.Y - Argument1.thumbstickFrame.Size.Y.Offset / 2 )
        end

        Value1 = Vector2.new( Argument1.thumbstickFrame.AbsolutePosition.X + Argument1.thumbstickFrame.AbsoluteSize.X / 2, Argument1.thumbstickFrame.AbsolutePosition.Y + Argument1.thumbstickFrame.AbsoluteSize.Y / 2 )
        return
    end
    GuiService.MenuOpened:Connect( function()
        if Argument1.isTouchActive then
            Argument1:OnInputEnded( )
        end
    end )
    Argument1.thumbstickFrame.Parent = Parent
end
return Self
