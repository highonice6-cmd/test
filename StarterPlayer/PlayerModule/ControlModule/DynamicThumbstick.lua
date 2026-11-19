-- StarterPlayer.PlayerModule.ControlModule.DynamicThumbstick
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag2
local Table = { 0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75 }
local Table2 = { 0.55, 0.65, 0.7, 0.75, 0.8, 0.85, 0.875 }
local Count = #Table
local Vector22 = Vector2.new( -1, -1 )
local TweenInfo2 = TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationD" )

if UserFlag then
    UserFlag2 = UserFlag
else
    UserFlag2 = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationDGA" )
end

local Get2
local UserFlag3 = Get.getUserFlag( "UserAllowAbilityControlsBonus" )
local UserFlag4 = Get.getUserFlag( "UserDoubleJumpButtonFix" )
local UserFlag5 = Get.getUserFlag( "UserPlayerScriptsResetDTTouchOnCreate" )
local Players = game:GetService( "Players" )
local GuiService = game:GetService( "GuiService" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local ThumbstickAction = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "TransformerContext" ):WaitForChild( "ThumbstickAction" )
local AvatarAbilitiesInterface = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) )

if UserFlag2 then
    Get2 = AvatarAbilitiesInterface.get( Players.LocalPlayer )
else
    Get2 = nil
end

local LocalPlayer2
local LocalPlayer = Players.LocalPlayer

if LocalPlayer then
    LocalPlayer2 = LocalPlayer
else
    Players:GetPropertyChangedSignal( "LocalPlayer" ):Wait( )
    LocalPlayer2 = Players.LocalPlayer
end

local ActionController = require( script.Parent:WaitForChild( "ActionController" ) )
local Self = setmetatable( { }, ActionController )
Self.__index = Self
function Self.new( Data )
    local New = setmetatable( ActionController.new( ), Self )
    New.data = Data
    New.enabled = false
    New.isTouchActive = false
    New.moveTouchFirstChanged = false
    New.moveTouchStartPosition = nil
    New.startImage = nil
    New.endImage = nil
    New.endImageStroke = nil
    New.endImageCenter = nil
    New.middleImages = { }
    New.startImageFadeTween = nil
    New.endImageFadeTween = nil
    New.endImageCenterFadeTween = nil
    New.middleImageFadeTweens = { }
    New.isFirstTouch = true
    New.thumbstickFrame = nil
    New.onRenderSteppedConn = nil
    New.fadeInAndOutBalance = 0.5
    New.fadeInAndOutHalfDuration = 0.3
    New.hasFadedBackgroundInPortrait = false
    New.hasFadedBackgroundInLandscape = false
    New.tweenInAlphaStart = nil
    New.tweenOutAlphaStart = nil
    New.newStyle = false
    return New
end
function Self.GetIsJumping( Argument1 )
    local IsJumping = Argument1.isJumping
    Argument1.isJumping = false
    return IsJumping
end

local function SetupThumbstickInput( Input )
    for Key, Value in ThumbstickAction:GetChildren( ) do
        if Value.Name == "DynamicTouchBinding" or Value.Name == "ClassicTouchBinding" then
            Value:Destroy( )
        end
    end

    local InputBinding = Instance.new( "InputBinding" )
    InputBinding.Name = "DynamicTouchBinding"
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

    if Enabled then
        if not Input.thumbstickFrame then
            Input:Create( Argument3 )

            if UserFlag2 and not Input.avatarAbilitiesEnabledChangedConn then
                Input.avatarAbilitiesEnabledChangedConn = Get2:GetEnabledChangedSignal( ):Connect( function()
                    if Input.enabled then
                        Input:Create( Argument3 )

                        if UserFlag5 then
                            SetupThumbstickInput( Input )
                            Input.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect( Input.onStateChanged )
                            ThumbstickAction.Enabled = true
                        else
                            Input.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect( Input.onStateChanged )
                            ThumbstickAction.Enabled = true
                        end

                        Input.thumbstickFrame.Visible = true
                    end
                end )
            end
        end
        if UserFlag5 then
            SetupThumbstickInput( Input )
            Input.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect( Input.onStateChanged )
            ThumbstickAction.Enabled = true
        else
            Input.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect( Input.onStateChanged )
            ThumbstickAction.Enabled = true
        end
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

        Input:OnInputEnded( )
    end

    Input.enabled = Enabled
    Input.thumbstickFrame.Visible = Enabled
    return nil
end
function Self.OnInputEnded( Self )
    Self.isTouchActive = false
    local DynamicThumbstickScriptableBinding = Self.data.controlModule.actions.MoveAction:FindFirstChild( "DynamicThumbstickScriptableBinding" )

    if DynamicThumbstickScriptableBinding then
        DynamicThumbstickScriptableBinding:Fire( Vector2.zero )
    end

    Self:FadeThumbstick( false )
end
function Self.FadeThumbstick( Argument1, Argument2 )
    if not Argument2 and Argument1.isTouchActive then
        return
    end
    if Argument1.isFirstTouch then
        return
    end
    if Argument1.startImageFadeTween then
        Argument1.startImageFadeTween:Cancel( )
    end
    if Argument1.endImageFadeTween then
        Argument1.endImageFadeTween:Cancel( )
    end
    if UserFlag2 and Argument1.endImageCenterFadeTween then
        Argument1.endImageCenterFadeTween:Cancel( )
    end

    local Count = #Argument1.middleImages
    local I = 1

    for I = 1, Count do
        if Argument1.middleImageFadeTweens[ I ] then
            Argument1.middleImageFadeTweens[ I ]:Cancel( )
        end
    end
    if Argument2 then
        if not UserFlag2 or not Argument1.newStyle then
            Argument1.startImageFadeTween = TweenService:Create( Argument1.startImage, TweenInfo2, { ImageTransparency = 0 } )
            Argument1.startImageFadeTween:Play( )
            Argument1.endImageFadeTween = TweenService:Create( Argument1.endImage, TweenInfo2, { ImageTransparency = 0.2 } )
            Argument1.endImageFadeTween:Play( )
        else
            Argument1.startImageFadeTween = TweenService:Create( Argument1.startImage, TweenInfo2, { BackgroundTransparency = 0.4 } )
            Argument1.startImageFadeTween:Play( )
            Argument1.endImageFadeTween = TweenService:Create( Argument1.endImageStroke, TweenInfo2, { Transparency = 0 } )
            Argument1.endImageFadeTween:Play( )
            Argument1.endImageCenterFadeTween = TweenService:Create( Argument1.endImageCenter, TweenInfo2, { BackgroundTransparency = 0 } )
            Argument1.endImageCenterFadeTween:Play( )
        end

        local Count2 = #Argument1.middleImages
        local I2 = 1

        if Count2 >= 1 then
            for I2 = 1, Count2 do
                if not UserFlag2 or not Argument1.newStyle then
                    local MiddleImageFadeTweens2 = Argument1.middleImageFadeTweens
                    MiddleImageFadeTweens2[ I2 ] = TweenService:Create( Argument1.middleImages[ I2 ], TweenInfo2, { ImageTransparency = Table[ I2 ] } )
                else
                    local MiddleImageFadeTweens = Argument1.middleImageFadeTweens
                    MiddleImageFadeTweens[ I2 ] = TweenService:Create( Argument1.middleImages[ I2 ], TweenInfo2, { BackgroundTransparency = Table2[ I2 ] } )
                end

                Argument1.middleImageFadeTweens[ I2 ]:Play( )
            end

            return
        end
    else
        if not UserFlag2 or not Argument1.newStyle then
            Argument1.startImageFadeTween = TweenService:Create( Argument1.startImage, TweenInfo2, { ImageTransparency = 1 } )
            Argument1.startImageFadeTween:Play( )
            Argument1.endImageFadeTween = TweenService:Create( Argument1.endImage, TweenInfo2, { ImageTransparency = 1 } )
            Argument1.endImageFadeTween:Play( )
        else
            Argument1.startImageFadeTween = TweenService:Create( Argument1.startImage, TweenInfo2, { BackgroundTransparency = 1 } )
            Argument1.startImageFadeTween:Play( )
            Argument1.endImageFadeTween = TweenService:Create( Argument1.endImageStroke, TweenInfo2, { Transparency = 1 } )
            Argument1.endImageFadeTween:Play( )
            Argument1.endImageCenterFadeTween = TweenService:Create( Argument1.endImageCenter, TweenInfo2, { BackgroundTransparency = 1 } )
            Argument1.endImageCenterFadeTween:Play( )
        end

        local Count3 = #Argument1.middleImages
        local I3 = 1

        for I3 = 1, Count3 do
            if not UserFlag2 or not Argument1.newStyle then
                local MiddleImageFadeTweens4 = Argument1.middleImageFadeTweens
                MiddleImageFadeTweens4[ I3 ] = TweenService:Create( Argument1.middleImages[ I3 ], TweenInfo2, { ImageTransparency = 1 } )
            else
                local MiddleImageFadeTweens3 = Argument1.middleImageFadeTweens
                MiddleImageFadeTweens3[ I3 ] = TweenService:Create( Argument1.middleImages[ I3 ], TweenInfo2, { BackgroundTransparency = 1 } )
            end

            Argument1.middleImageFadeTweens[ I3 ]:Play( )
        end
    end
end
function Self.FadeThumbstickFrame( Argument1, Amount, FadeInAndOutBalance )
    Argument1.fadeInAndOutHalfDuration = Amount * 0.5
    Argument1.fadeInAndOutBalance = FadeInAndOutBalance
    Argument1.tweenInAlphaStart = tick( )
end
function Self.DoFadeInBackground( Argument1 )
    local HasFadedBackgroundInPortrait
    local PlayerGui = LocalPlayer2:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui then
        if PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            HasFadedBackgroundInPortrait = Argument1.hasFadedBackgroundInLandscape
            Argument1.hasFadedBackgroundInLandscape = true
        elseif PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            HasFadedBackgroundInPortrait = Argument1.hasFadedBackgroundInPortrait
            Argument1.hasFadedBackgroundInPortrait = true
        else
            HasFadedBackgroundInPortrait = false
        end
    else
        HasFadedBackgroundInPortrait = false
    end
    if not HasFadedBackgroundInPortrait then
        Argument1.fadeInAndOutHalfDuration = 0.3
        Argument1.fadeInAndOutBalance = 0.5
        Argument1.tweenInAlphaStart = tick( )
    end
end
function Self.DoMove( Argument1, Argument2 )
    local Vector22

    if Argument2.Magnitude < Argument1.radiusOfDeadZone then
        Vector22 = Vector2.new( )
    else
        Vector22 = Argument2.Unit * ( 1 - math.max( 0, ( Argument1.radiusOfMaxSpeed - Argument2.Magnitude ) / Argument1.radiusOfMaxSpeed ) )
    end

    local Vector23 = Vector2.new( Vector22.X, -Vector22.Y )
    local DynamicThumbstickScriptableBinding = Argument1.data.controlModule.actions.MoveAction:FindFirstChild( "DynamicThumbstickScriptableBinding" )

    if DynamicThumbstickScriptableBinding then
        DynamicThumbstickScriptableBinding:Fire( Vector23 )
    end
end
function Self.LayoutMiddleImages( Argument1, Argument2, Argument3 )
    local ThumbstickSize = Argument1.thumbstickSize / 2 + Argument1.middleSize
    local Total = Argument3 - Argument2
    local Magnitude = Total.Magnitude - Argument1.thumbstickRingSize / 2 - Argument1.middleSize
    local Unit = Total.Unit
    local MiddleSpacing = Argument1.middleSpacing * Count
    local MiddleSpacing2 = Argument1.middleSpacing

    if MiddleSpacing < Magnitude then
        MiddleSpacing2 = Magnitude / Count
    end

    local I = 1

    for I = 1, Count do
        local Entry = Argument1.middleImages[ I ]
        local ThumbstickSize2 = ThumbstickSize + MiddleSpacing2 * ( I - 2 )
        local ThumbstickSize3 = ThumbstickSize + MiddleSpacing2 * ( I - 1 )

        if ThumbstickSize2 < Magnitude then
            local Unit2 = Argument3 - Unit * ThumbstickSize3
            local Clamp = math.clamp( 1 - ( ThumbstickSize3 - Magnitude ) / MiddleSpacing2, 0, 1 )
            Entry.Visible = true
            local X = Unit2.X
            Entry.Position = UDim2.new( 0, X, 0, Unit2.Y )
            local MiddleSize = Argument1.middleSize * Clamp
            Entry.Size = UDim2.new( 0, MiddleSize, 0, Argument1.middleSize * Clamp )
        else
            Entry.Visible = false
        end
    end
end
function Self.MoveStick( Self, Argument2 )
    local Vector22 = Vector2.new( Self.moveTouchStartPosition.X, Self.moveTouchStartPosition.Y ) - Self.thumbstickFrame.AbsolutePosition
    local Vector23 = Vector2.new( Argument2.X, Argument2.Y ) - Self.thumbstickFrame.AbsolutePosition
    local EndImage = Self.endImage
    local X = Vector23.X
    EndImage.Position = UDim2.new( 0, X, 0, Vector23.Y )
    Self:LayoutMiddleImages( Vector22, Vector23 )
end
function Self.Create( Argument1, Parent )
    if Argument1.thumbstickFrame then
        if UserFlag5 then
            ThumbstickAction.Enabled = false

            if Argument1.thumbstickStateChangedConn then
                Argument1.thumbstickStateChangedConn:Disconnect( )
                Argument1.thumbstickStateChangedConn = nil
            end
        else
            ThumbstickAction.Enabled = false

            if Argument1.thumbstickStateChangedConn then
                Argument1.thumbstickStateChangedConn:Disconnect( )
                Argument1.thumbstickStateChangedConn = nil
            end
        end

        Argument1.thumbstickFrame:Destroy( )
        Argument1.thumbstickFrame = nil

        if Argument1.onRenderSteppedConn then
            Argument1.onRenderSteppedConn:Disconnect( )
            Argument1.onRenderSteppedConn = nil
        end
        if Argument1.absoluteSizeChangedConn then
            Argument1.absoluteSizeChangedConn:Disconnect( )
            Argument1.absoluteSizeChangedConn = nil
        end
        if not UserFlag2 and Argument1.avatarAbilitiesEnabledChangedConn then
            Argument1.avatarAbilitiesEnabledChangedConn:Disconnect( )
            Argument1.avatarAbilitiesEnabledChangedConn = nil
        end
        if UserFlag2 then
            if Argument1.cameraChangedConn then
                Argument1.cameraChangedConn:Disconnect( )
                Argument1.cameraChangedConn = nil
            end
            if Argument1.currentCameraChangedConn then
                Argument1.currentCameraChangedConn:Disconnect( )
                Argument1.currentCameraChangedConn = nil
            end
            if Argument1.menuOpenedConnection then
                Argument1.menuOpenedConnection:Disconnect( )
                Argument1.menuOpenedConnection = nil
            end
            if Argument1.playerGuiChangedConn then
                Argument1.playerGuiChangedConn:Disconnect( )
                Argument1.playerGuiChangedConn = nil
            end
        end
    end

    local function LayoutThumbstickFrame( Flag )
        if Flag then
            local ThumbstickFrame = Argument1.thumbstickFrame
            ThumbstickFrame.Size = UDim2.new( 1, 100, 0.4, 100 )
            local ThumbstickFrame2 = Argument1.thumbstickFrame
            ThumbstickFrame2.Position = UDim2.new( 0, -100, 0.6, 0 )
            return
        end
        local ThumbstickFrame3 = Argument1.thumbstickFrame
        ThumbstickFrame3.Size = UDim2.new( 0.4, 100, 0.6666666666666666, 100 )
        local ThumbstickFrame4 = Argument1.thumbstickFrame
        ThumbstickFrame4.Position = UDim2.new( 0, -100, 0.3333333333333333, 0 )
        return
    end

    Argument1.newStyle = UserFlag2 and Get2:isEnabled( )
    Argument1.thumbstickFrame = Instance.new( "Frame" )
    Argument1.thumbstickFrame.BorderSizePixel = 0
    Argument1.thumbstickFrame.Name = "DynamicThumbstickFrame"
    Argument1.thumbstickFrame.Visible = false
    Argument1.thumbstickFrame.BackgroundTransparency = 1
    local ThumbstickFrame = Argument1.thumbstickFrame
    ThumbstickFrame.BackgroundColor3 = Color3.fromRGB( 0, 0, 0 )
    Argument1.thumbstickFrame.Active = false
    local ThumbstickFrame2 = Argument1.thumbstickFrame
    ThumbstickFrame2.Size = UDim2.new( 0.4, 100, 0.6666666666666666, 100 )
    local ThumbstickFrame3 = Argument1.thumbstickFrame
    ThumbstickFrame3.Position = UDim2.new( 0, -100, 0.3333333333333333, 0 )
    Argument1.thumbstickButton = Instance.new( "ImageButton" )
    Argument1.thumbstickButton.Name = "DynamicThumbstickUIModifier"
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
        local DynamicTouchBinding

        if UserFlag4 then
            DynamicTouchBinding = ThumbstickAction:FindFirstChild( "DynamicTouchBinding" )
        else
            DynamicTouchBinding = nil
        end
        if not DynamicTouchBinding then
            local InputBinding = Instance.new( "InputBinding" )
            InputBinding.Name = "DynamicTouchBinding"
            InputBinding.KeyCode = Enum.KeyCode.TouchPosition
            InputBinding.Parent = ThumbstickAction
            DynamicTouchBinding = InputBinding
        end

        DynamicTouchBinding.UIModifier = Argument1.thumbstickButton
    end
    if not UserFlag2 or not Argument1.newStyle then
        Argument1.startImage = Instance.new( "ImageLabel" )
        Argument1.startImage.Name = "ThumbstickStart"
        Argument1.startImage.Visible = true
        Argument1.startImage.BackgroundTransparency = 1
        Argument1.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        local StartImage4 = Argument1.startImage
        StartImage4.ImageRectOffset = Vector2.new( 1, 1 )
        local StartImage5 = Argument1.startImage
        StartImage5.ImageRectSize = Vector2.new( 144, 144 )
        local StartImage6 = Argument1.startImage
        StartImage6.ImageColor3 = Color3.new( 0, 0, 0 )
        local StartImage7 = Argument1.startImage
        StartImage7.AnchorPoint = Vector2.new( 0.5, 0.5 )
        Argument1.startImage.ZIndex = 10
        local StartImage8 = Argument1.startImage
        StartImage8.Parent = Argument1.thumbstickFrame
        Argument1.endImage = Instance.new( "ImageLabel" )
        Argument1.endImage.Name = "ThumbstickEnd"
        Argument1.endImage.Visible = true
        Argument1.endImage.BackgroundTransparency = 1
        Argument1.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        local EndImage3 = Argument1.endImage
        EndImage3.ImageRectOffset = Vector2.new( 1, 1 )
        local EndImage4 = Argument1.endImage
        EndImage4.ImageRectSize = Vector2.new( 144, 144 )
        local EndImage5 = Argument1.endImage
        EndImage5.AnchorPoint = Vector2.new( 0.5, 0.5 )
        Argument1.endImage.ZIndex = 10
        local EndImage6 = Argument1.endImage
        EndImage6.Parent = Argument1.thumbstickFrame
        local I2 = 1

        for I2 = 1, Count do
            local MiddleImages2 = Argument1.middleImages
            MiddleImages2[ I2 ] = Instance.new( "ImageLabel" )
            Argument1.middleImages[ I2 ].Name = "ThumbstickMiddle"
            Argument1.middleImages[ I2 ].Visible = false
            Argument1.middleImages[ I2 ].BackgroundTransparency = 1
            Argument1.middleImages[ I2 ].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
            local Entry5 = Argument1.middleImages[ I2 ]
            Entry5.ImageRectOffset = Vector2.new( 1, 1 )
            local Entry6 = Argument1.middleImages[ I2 ]
            Entry6.ImageRectSize = Vector2.new( 144, 144 )
            local Entry7 = Argument1.middleImages[ I2 ]
            Entry7.ImageTransparency = Table[ I2 ]
            local Entry8 = Argument1.middleImages[ I2 ]
            Entry8.AnchorPoint = Vector2.new( 0.5, 0.5 )
            Argument1.middleImages[ I2 ].ZIndex = 9
            local Entry9 = Argument1.middleImages[ I2 ]
            Entry9.Parent = Argument1.thumbstickFrame
        end
    else
        local Thickness
        Argument1.startImage = Instance.new( "Frame" )
        Argument1.startImage.Name = "ThumbstickStart"
        local StartImage = Argument1.startImage
        StartImage.BackgroundColor3 = Color3.fromRGB( 18, 18, 21 )
        Argument1.startImage.BackgroundTransparency = 0.4
        local StartImage2 = Argument1.startImage
        StartImage2.AnchorPoint = Vector2.new( 0.5, 0.5 )
        Argument1.startImage.ZIndex = 10
        local StartImage3 = Argument1.startImage
        StartImage3.Parent = Argument1.thumbstickFrame
        local UICorner = Instance.new( "UICorner" )
        UICorner.CornerRadius = UDim.new( 0.5, 0 )
        UICorner.Parent = Argument1.startImage
        Argument1.endImage = Instance.new( "Frame" )
        Argument1.endImage.Name = "ThumbstickEnd"
        Argument1.endImage.BackgroundTransparency = 1
        local EndImage = Argument1.endImage
        EndImage.AnchorPoint = Vector2.new( 0.5, 0.5 )
        Argument1.endImage.ZIndex = 10
        local EndImage2 = Argument1.endImage
        EndImage2.Parent = Argument1.thumbstickFrame
        local UICorner2 = Instance.new( "UICorner" )
        UICorner2.CornerRadius = UDim.new( 0.5, 0 )
        UICorner2.Parent = Argument1.endImage
        Argument1.endImageStroke = Instance.new( "UIStroke" )
        local EndImageStroke = Argument1.endImageStroke
        Thickness = not UserFlag4 and 2 or 1.5
        EndImageStroke.Thickness = Thickness
        local EndImageStroke2 = Argument1.endImageStroke
        EndImageStroke2.Color = Color3.fromRGB( 213, 215, 221 )
        local EndImageStroke3 = Argument1.endImageStroke
        EndImageStroke3.Parent = Argument1.endImage
        Argument1.endImageCenter = Instance.new( "Frame" )
        Argument1.endImageCenter.Name = "ThumbstickEndCenter"
        Argument1.endImageCenter.BackgroundTransparency = 0
        local EndImageCenter = Argument1.endImageCenter
        EndImageCenter.BackgroundColor3 = Color3.fromRGB( 213, 215, 221 )
        local EndImageCenter2 = Argument1.endImageCenter
        EndImageCenter2.AnchorPoint = Vector2.new( 0.5, 0.5 )
        local EndImageCenter3 = Argument1.endImageCenter
        EndImageCenter3.Size = UDim2.new( 0.74, 0, 0.74, 0 )
        local EndImageCenter4 = Argument1.endImageCenter
        EndImageCenter4.Position = UDim2.new( 0.5, 0, 0.5, 0 )
        Argument1.endImageCenter.ZIndex = 10
        local EndImageCenter5 = Argument1.endImageCenter
        EndImageCenter5.Parent = Argument1.endImage
        local UICorner3 = Instance.new( "UICorner" )
        UICorner3.CornerRadius = UDim.new( 0.5, 0 )
        UICorner3.Parent = Argument1.endImageCenter
        local I = 1

        if Count >= 1 then
            for I = 1, Count do
                local MiddleImages = Argument1.middleImages
                MiddleImages[ I ] = Instance.new( "Frame" )
                Argument1.middleImages[ I ].Name = "ThumbstickMiddle"
                Argument1.middleImages[ I ].Visible = false
                local Entry = Argument1.middleImages[ I ]
                Entry.BackgroundTransparency = Table2[ I ]
                local Entry2 = Argument1.middleImages[ I ]
                Entry2.BackgroundColor3 = Color3.fromRGB( 255, 255, 255 )
                local Entry3 = Argument1.middleImages[ I ]
                Entry3.AnchorPoint = Vector2.new( 0.5, 0.5 )
                Argument1.middleImages[ I ].ZIndex = 9
                local Entry4 = Argument1.middleImages[ I ]
                Entry4.Parent = Argument1.thumbstickFrame
                local UICorner4 = Instance.new( "UICorner" )
                UICorner4.CornerRadius = UDim.new( 0.5, 0 )
                UICorner4.Parent = Argument1.middleImages[ I ]
            end
        end
    end

    local function ResizeThumbstick()
        local Flag
        local AbsoluteSize = Parent.AbsoluteSize
        local X = AbsoluteSize.X
        Flag = math.min( X, AbsoluteSize.Y ) > 500 and true or false
        local Number

        if Flag then
            Number = 2
        else
            Number = 1
        end

        local NewStyle

        if UserFlag2 then
            NewStyle = Argument1.newStyle
        else
            NewStyle = AvatarAbilitiesInterface.isEnabled( )
        end
        if UserFlag3 and NewStyle and Flag then
            Number = 1.6216216216216217
        end

        Argument1.thumbstickSize = 45 * Number
        Argument1.thumbstickRingSize = 20 * Number
        Argument1.middleSize = 10 * Number
        Argument1.middleSpacing = 14 * Number
        Argument1.radiusOfDeadZone = 2 * Number
        Argument1.radiusOfMaxSpeed = 20 * Number
        local Number2 = 74 * Number

        if not UserFlag2 or Argument1.isFirstTouch then
            if NewStyle then
                local Number3 = not Flag and 64 or 100
                local Number5 = not Flag and 64 or 112
                local StartImage = Argument1.startImage
                local Number4 = Number2 * 0.5 + 100 + Number3
                StartImage.Position = UDim2.new( 0, Number4, 1, -Number2 * 0.5 - 100 - Number5 )
                local StartImage2 = Argument1.startImage
                StartImage2.Size = UDim2.new( 0, Number2, 0, Number2 )
            else
                local StartImage3 = Argument1.startImage
                local ThumbstickRingSize = Argument1.thumbstickRingSize * 3.3 + 100
                StartImage3.Position = UDim2.new( 0, ThumbstickRingSize, 1, -Argument1.thumbstickRingSize * 2.8 - 100 )
                local StartImage4 = Argument1.startImage
                StartImage4.Size = UDim2.new( 0, Number2, 0, Number2 )
            end
        end

        local EndImage = Argument1.endImage
        EndImage.Position = Argument1.startImage.Position

        if not UserFlag2 or not Argument1.newStyle then
            local EndImage3 = Argument1.endImage
            local ThumbstickSize2 = Argument1.thumbstickSize * 0.8
            EndImage3.Size = UDim2.new( 0, ThumbstickSize2, 0, Argument1.thumbstickSize * 0.8 )
            return
        end
        local EndImage2 = Argument1.endImage
        local ThumbstickSize = Argument1.thumbstickSize * 0.6
        EndImage2.Size = UDim2.new( 0, ThumbstickSize, 0, Argument1.thumbstickSize * 0.6 )
        return
    end

    ResizeThumbstick( )
    Argument1.absoluteSizeChangedConn = Parent:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( ResizeThumbstick )

    if not UserFlag2 then
        Argument1.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal( ):Connect( ResizeThumbstick )
    end

    local function OnCurrentCameraChanged()
        if Argument1.cameraChangedConn then
            Argument1.cameraChangedConn:Disconnect( )
            Argument1.cameraChangedConn = nil
        end

        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera then
            local Flag

            local function OnViewportSizeChanged()
                local Flag
                local ViewportSize = CurrentCamera.ViewportSize
                Flag = ViewportSize.X < ViewportSize.Y and true or false
                LayoutThumbstickFrame( Flag )
            end

            Argument1.cameraChangedConn = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( OnViewportSizeChanged )
            local ViewportSize = CurrentCamera.ViewportSize
            Flag = ViewportSize.X < ViewportSize.Y and true or false
            LayoutThumbstickFrame( Flag )
        end
    end

    Argument1.currentCameraChangedConn = workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( OnCurrentCameraChanged )

    if workspace.CurrentCamera or UserFlag2 then
        OnCurrentCameraChanged( )
    end

    Argument1.startImageFadeTween = nil
    Argument1.endImageFadeTween = nil
    Argument1.endImageCenterFadeTween = nil
    Argument1.middleImageFadeTweens = { }

    if UserFlag5 and Argument1.isTouchActive then
        Argument1:OnInputEnded( )
    end

    Argument1.moveTouchStartPosition = nil
    Argument1.onRenderSteppedConn = RunService.RenderStepped:Connect( function()
        if Argument1.tweenInAlphaStart == nil then
            if Argument1.tweenOutAlphaStart ~= nil then
                local Tick2 = tick( ) - Argument1.tweenOutAlphaStart
                local FadeInAndOutHalfDuration2 = Argument1.fadeInAndOutHalfDuration * 2 - Argument1.fadeInAndOutHalfDuration * 2 * Argument1.fadeInAndOutBalance
                local ThumbstickFrame2 = Argument1.thumbstickFrame
                ThumbstickFrame2.BackgroundTransparency = math.min( Tick2 / FadeInAndOutHalfDuration2, 1 ) * 0.35 + 0.65

                if FadeInAndOutHalfDuration2 < Tick2 then
                    Argument1.tweenOutAlphaStart = nil
                end
            end
        else
            local Tick = tick( ) - Argument1.tweenInAlphaStart
            local FadeInAndOutHalfDuration = Argument1.fadeInAndOutHalfDuration * 2 * Argument1.fadeInAndOutBalance
            local ThumbstickFrame = Argument1.thumbstickFrame
            ThumbstickFrame.BackgroundTransparency = 1 - math.min( Tick / FadeInAndOutHalfDuration, 1 ) * 0.35

            if FadeInAndOutHalfDuration < Tick then
                Argument1.tweenOutAlphaStart = tick( )
                Argument1.tweenInAlphaStart = nil
                return
            end
        end
    end )
    function Argument1.onStateChanged( Argument1Inner )
        if Argument1Inner == Vector22 then
            if Argument1.isTouchActive then
                Argument1:OnInputEnded( )
            end
        else
            local Min = GuiService:GetInsetArea( Enum.ScreenInsets.None ).Min
            local X = Argument1Inner.X + Min.X
            local MoveTouchStartPosition = Vector3.new( X, Argument1Inner.Y + Min.Y, 0 )

            if not Argument1.isTouchActive then
                Argument1.isTouchActive = true

                if Argument1.isFirstTouch then
                    Argument1.isFirstTouch = false
                    local TweenInfo2 = TweenInfo.new( 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 )
                    local StartImage = Argument1.startImage
                    TweenService:Create( StartImage, TweenInfo2, { Size = UDim2.new( 0, 0, 0, 0 ) } ):Play( )

                    if not UserFlag2 or not Argument1.newStyle then
                        local EndImage = Argument1.endImage
                        local ThumbstickSize = Argument1.thumbstickSize
                        TweenService:Create( EndImage, TweenInfo2, {
                            Size = UDim2.new( 0, ThumbstickSize, 0, Argument1.thumbstickSize ),
                            ImageColor3 = Color3.new( 0, 0, 0 )
                        } ):Play( )
                    end
                end

                Argument1.moveTouchStartPosition = MoveTouchStartPosition
                Argument1.moveTouchFirstChanged = true
                Argument1:DoFadeInBackground( )
                return
            end
            if Argument1.moveTouchFirstChanged then
                Argument1.moveTouchFirstChanged = false
                local Vector22Inner = Vector2.new( Argument1.moveTouchStartPosition.X - Argument1.thumbstickFrame.AbsolutePosition.X, Argument1.moveTouchStartPosition.Y - Argument1.thumbstickFrame.AbsolutePosition.Y )
                Argument1.startImage.Visible = true
                local StartImage2 = Argument1.startImage
                local X2 = Vector22Inner.X
                StartImage2.Position = UDim2.new( 0, X2, 0, Vector22Inner.Y )
                Argument1.endImage.Visible = true
                local EndImage2 = Argument1.endImage
                EndImage2.Position = Argument1.startImage.Position
                Argument1:FadeThumbstick( true )
                Argument1:MoveStick( Argument1.moveTouchStartPosition )
            end

            local Vector23 = Vector2.new( MoveTouchStartPosition.X - Argument1.moveTouchStartPosition.X, MoveTouchStartPosition.Y - Argument1.moveTouchStartPosition.Y )

            if Vector23.Magnitude > 0 then
                Argument1:DoMove( Vector23 )
                Argument1:MoveStick( MoveTouchStartPosition )
                return
            end
        end
    end
    Argument1.menuOpenedConnection = GuiService.MenuOpened:Connect( function()
        if Argument1.isTouchActive then
            Argument1:OnInputEnded( )
        end
    end )
    local PlayerGui = LocalPlayer2:FindFirstChildOfClass( "PlayerGui" )

    while not PlayerGui do
        LocalPlayer2.ChildAdded:wait( )
        PlayerGui = LocalPlayer2:FindFirstChildOfClass( "PlayerGui" )
    end

    local Flag

    if PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft then
        Flag = true
    elseif PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
        Flag = true
    else
        Flag = false
    end

    local function LongShowBackground()
        Argument1.fadeInAndOutHalfDuration = 2.5
        Argument1.fadeInAndOutBalance = 0.05
        Argument1.tweenInAlphaStart = tick( )
    end

    Argument1.playerGuiChangedConn = PlayerGui:GetPropertyChangedSignal( "CurrentScreenOrientation" ):Connect( function()
        if not Flag or PlayerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            if not Flag and PlayerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
                Argument1.playerGuiChangedConn:Disconnect( )
                Argument1.fadeInAndOutHalfDuration = 2.5
                Argument1.fadeInAndOutBalance = 0.05
                Argument1.tweenInAlphaStart = tick( )

                if Flag then
                    Argument1.hasFadedBackgroundInPortrait = true
                    return
                end

                Argument1.hasFadedBackgroundInLandscape = true
            end
        else
            Argument1.playerGuiChangedConn:Disconnect( )
            Argument1.fadeInAndOutHalfDuration = 2.5
            Argument1.fadeInAndOutBalance = 0.05
            Argument1.tweenInAlphaStart = tick( )

            if Flag then
                Argument1.hasFadedBackgroundInPortrait = true
                return
            end

            Argument1.hasFadedBackgroundInLandscape = true
        end
    end )
    Argument1.thumbstickFrame.Parent = Parent

    if game:IsLoaded( ) then
        Argument1.fadeInAndOutHalfDuration = 2.5
        Argument1.fadeInAndOutBalance = 0.05
        Argument1.tweenInAlphaStart = tick( )
    else
        coroutine.wrap( function()
            game.Loaded:Wait( )
            Argument1.fadeInAndOutHalfDuration = 2.5
            Argument1.fadeInAndOutBalance = 0.05
            Argument1.tweenInAlphaStart = tick( )
        end )( )
    end
end
return Self
