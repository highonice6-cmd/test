-- ReplicatedStorage.TopbarPlus.Icon.Elements.Caption
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local FromRGB = Color3.fromRGB( 39, 41, 48 )
return function( Argument1 )
    local Parent = Argument1:getInstance( "ClickRegion" )
    local Parent2 = Instance.new( "CanvasGroup" )
    Parent2.Name = "Caption"
    Parent2.AnchorPoint = Vector2.new( 0.5, 0 )
    Parent2.BackgroundTransparency = 1
    Parent2.BorderSizePixel = 0
    Parent2.GroupTransparency = 1
    Parent2.Position = UDim2.fromOffset( 0, 0 )
    Parent2.Visible = true
    Parent2.ZIndex = 30
    Parent2.Parent = Parent
    local Parent3 = Instance.new( "Frame" )
    Parent3.Name = "Box"
    Parent3.AutomaticSize = Enum.AutomaticSize.XY
    Parent3.BackgroundColor3 = FromRGB
    Parent3.Position = UDim2.fromOffset( 4, 7 )
    Parent3.ZIndex = 12
    Parent3.Parent = Parent2
    local TextLabel = Instance.new( "TextLabel" )
    TextLabel.Name = "Header"
    TextLabel.FontFace = Font.new( "rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal )
    TextLabel.Text = "Caption"
    TextLabel.TextColor3 = Color3.fromRGB( 255, 255, 255 )
    TextLabel.TextSize = 15
    TextLabel.TextTruncate = Enum.TextTruncate.None
    TextLabel.TextWrapped = false
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundTransparency = 1
    TextLabel.LayoutOrder = 1
    TextLabel.Size = UDim2.fromOffset( 0, 16 )
    TextLabel.ZIndex = 18
    TextLabel.Parent = Parent3
    local UIListLayout = Instance.new( "UIListLayout" )
    UIListLayout.Name = "Layout"
    UIListLayout.Padding = UDim.new( 0, 8 )
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Parent3
    local UICorner = Instance.new( "UICorner" )
    UICorner.Name = "CaptionCorner"
    UICorner.Parent = Parent3
    local UIPadding = Instance.new( "UIPadding" )
    UIPadding.Name = "Padding"
    UIPadding.PaddingBottom = UDim.new( 0, 12 )
    UIPadding.PaddingLeft = UDim.new( 0, 12 )
    UIPadding.PaddingRight = UDim.new( 0, 12 )
    UIPadding.PaddingTop = UDim.new( 0, 12 )
    UIPadding.Parent = Parent3
    local Parent4 = Instance.new( "Frame" )
    Parent4.Name = "Hotkeys"
    Parent4.AutomaticSize = Enum.AutomaticSize.Y
    Parent4.BackgroundTransparency = 1
    Parent4.LayoutOrder = 3
    Parent4.Size = UDim2.fromScale( 1, 0 )
    Parent4.Visible = false
    Parent4.Parent = Parent3
    local UIListLayout2 = Instance.new( "UIListLayout" )
    UIListLayout2.Name = "Layout1"
    UIListLayout2.Padding = UDim.new( 0, 6 )
    UIListLayout2.FillDirection = Enum.FillDirection.Vertical
    UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout2.HorizontalFlex = Enum.UIFlexAlignment.None
    UIListLayout2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
    UIListLayout2.VerticalFlex = Enum.UIFlexAlignment.None
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout2.Parent = Parent4
    local Parent5 = Instance.new( "ImageLabel" )
    Parent5.Name = "Key1"
    Parent5.Image = "rbxasset://textures/ui/Controls/key_single.png"
    Parent5.ImageTransparency = 0.7
    Parent5.ScaleType = Enum.ScaleType.Slice
    Parent5.SliceCenter = Rect.new( 5, 5, 23, 24 )
    Parent5.AutomaticSize = Enum.AutomaticSize.X
    Parent5.BackgroundTransparency = 1
    Parent5.LayoutOrder = 1
    Parent5.Size = UDim2.fromOffset( 0, 30 )
    Parent5.ZIndex = 15
    Parent5.Parent = Parent4
    local UIPadding2 = Instance.new( "UIPadding" )
    UIPadding2.Name = "Inset"
    UIPadding2.PaddingLeft = UDim.new( 0, 8 )
    UIPadding2.PaddingRight = UDim.new( 0, 8 )
    UIPadding2.Parent = Parent5
    local TextLabel2 = Instance.new( "TextLabel" )
    TextLabel2.AutoLocalize = false
    TextLabel2.Name = "LabelContent"
    TextLabel2.FontFace = Font.new( "rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal )
    TextLabel2.Text = ""
    TextLabel2.TextColor3 = Color3.fromRGB( 189, 190, 190 )
    TextLabel2.TextSize = 15
    TextLabel2.AutomaticSize = Enum.AutomaticSize.X
    TextLabel2.BackgroundTransparency = 1
    TextLabel2.Position = UDim2.fromOffset( 0, -1 )
    TextLabel2.Size = UDim2.fromScale( 1, 1 )
    TextLabel2.ZIndex = 16
    TextLabel2.Parent = Parent5
    local ImageLabel = Instance.new( "ImageLabel" )
    ImageLabel.Name = "Caret"
    ImageLabel.Image = "rbxassetid://101906294438076"
    ImageLabel.ImageColor3 = FromRGB
    ImageLabel.AnchorPoint = Vector2.new( 0, 0.5 )
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new( 0, 0, 0, 4 )
    ImageLabel.Size = UDim2.fromOffset( 16, 8 )
    ImageLabel.ZIndex = 12
    ImageLabel.Parent = Parent2
    local ImageLabel2 = Instance.new( "ImageLabel" )
    ImageLabel2.Visible = true
    ImageLabel2.Name = "DropShadow"
    ImageLabel2.Image = "rbxassetid://124920646932671"
    ImageLabel2.ImageColor3 = Color3.fromRGB( 0, 0, 0 )
    ImageLabel2.ImageTransparency = 0.45
    ImageLabel2.ScaleType = Enum.ScaleType.Slice
    ImageLabel2.SliceCenter = Rect.new( 12, 12, 13, 13 )
    ImageLabel2.BackgroundTransparency = 1
    ImageLabel2.Position = UDim2.fromOffset( 0, 5 )
    ImageLabel2.Size = UDim2.new( 1, 0, 0, 48 )
    ImageLabel2.Parent = Parent2
    Parent3:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
        ImageLabel2.Size = UDim2.new( 1, 0, 0, Parent3.AbsoluteSize.Y + 8 )
    end )
    local CaptionJanitor = Argument1.captionJanitor
    local _, ClipOutside2 = Argument1:clipOutside( Parent2 )
    ClipOutside2.AutomaticSize = Enum.AutomaticSize.None

    local function MatchSize()
        local AbsoluteSize = Parent2.AbsoluteSize
        ClipOutside2.Size = UDim2.fromOffset( AbsoluteSize.X, AbsoluteSize.Y )
    end

    CaptionJanitor:add( Parent2:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( MatchSize ) )
    local AbsoluteSize = Parent2.AbsoluteSize
    ClipOutside2.Size = UDim2.fromOffset( AbsoluteSize.X, AbsoluteSize.Y )
    local Flag = false
    local Header = Parent2.Box.Header
    local UserInputService = game:GetService( "UserInputService" )

    local function UpdateHotkey( Hotkey )
        local Flag
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local Text = Parent2:GetAttribute( "CaptionText" ) or ""
        Flag = Text == "_hotkey_" and true or false

        if not KeyboardEnabled and Flag then
            Argument1:setCaption( )
            return
        end

        Header.Text = Text
        Header.Visible = not Flag

        if Hotkey then
            TextLabel2.Text = Hotkey.Name
            Parent4.Visible = true
        end
        if not KeyboardEnabled then
            Parent4.Visible = false
        end
    end

    Parent2:GetAttributeChangedSignal( "CaptionText" ):Connect( UpdateHotkey )
    local TweenInfo2 = TweenInfo.new( 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In )
    local TweenInfo3 = TweenInfo.new( 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
    local TweenService = game:GetService( "TweenService" )
    local RunService = game:GetService( "RunService" )

    local function GetCaptionPosition( Argument1 )
        local Captured = if Argument1 == nil then Flag else Argument1
        local Number = not Captured and 2 or 10
        return UDim2.new( 0.5, 0, 1, Number )
    end

    local function UpdatePosition( Position )
        if not Flag then
            return
        end

        local Captured = if Position == nil then Flag else Position
        local NotCaptured2
        local NotCaptured = not Captured
        NotCaptured2 = if NotCaptured == nil then Flag else NotCaptured
        local Number = not NotCaptured2 and 2 or 10
        local Captured2
        local Position2 = UDim2.new( 0.5, 0, 1, Number )
        Captured2 = if Captured == nil then Flag else Captured
        local Number2 = not Captured2 and 2 or 10
        local UDim22 = UDim2.new( 0.5, 0, 1, Number2 )

        if Captured then
            ImageLabel.Position = UDim2.fromOffset( 0, ImageLabel.Position.Y.Offset )
            Parent2.AutomaticSize = Enum.AutomaticSize.XY
            Parent2.Size = UDim2.fromOffset( 32, 53 )
        else
            local AbsoluteSize = Parent2.AbsoluteSize
            Parent2.AutomaticSize = Enum.AutomaticSize.Y
            Parent2.Size = UDim2.fromOffset( AbsoluteSize.X, AbsoluteSize.Y )
        end

        local Captured3
        local Value1 = nil

        local function UpdateCaret()
            local X = Parent.AbsolutePosition.X - Parent2.AbsolutePosition.X + Parent.AbsoluteSize.X / 2 - ImageLabel.AbsoluteSize.X / 2
            local Offset = ImageLabel.Position.Y.Offset
            local Position = UDim2.fromOffset( X, Offset )

            if Value1 ~= X then
                Value1 = X
                ImageLabel.Position = UDim2.fromOffset( 0, Offset )
                task.wait( )
            end

            ImageLabel.Position = Position
        end

        ClipOutside2.Position = Position2
        UpdateCaret( )
        Captured3 = Captured and TweenInfo2 or TweenInfo3
        local Create = TweenService:Create( ClipOutside2, Captured3, { Position = UDim22 } )
        local Connect = RunService.Heartbeat:Connect( UpdateCaret )
        Create:Play( )
        Create.Completed:Once( function()
            Connect:Disconnect( )
        end )
    end

    CaptionJanitor:add( Parent:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
        UpdatePosition( )
    end ) )
    UpdatePosition( false )
    CaptionJanitor:add( Argument1.toggleKeyAdded:Connect( UpdateHotkey ) )
    local Value1, Value2, Value3 = pairs( Argument1.bindedToggleKeys )
    local Value4 = Value1( Value2, Value3 )

    if Value4 ~= nil then
        local Flag2
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local Text = Parent2:GetAttribute( "CaptionText" ) or ""
        Flag2 = Text == "_hotkey_" and true or false

        if KeyboardEnabled or not Flag2 then
            Header.Text = Text
            Header.Visible = not Flag2

            if Value4 then
                TextLabel2.Text = Value4.Name
                Parent4.Visible = true
            end
            if not KeyboardEnabled then
                Parent4.Visible = false
            end
        else
            Argument1:setCaption( )
        end
    end

    CaptionJanitor:add( Argument1.fakeToggleKeyChanged:Connect( UpdateHotkey ) )
    local FakeToggleKey = Argument1.fakeToggleKey

    if FakeToggleKey then
        local Flag3
        local KeyboardEnabled2 = UserInputService.KeyboardEnabled
        local Text2 = Parent2:GetAttribute( "CaptionText" ) or ""
        Flag3 = Text2 == "_hotkey_" and true or false

        if KeyboardEnabled2 or not Flag3 then
            Header.Text = Text2
            Header.Visible = not Flag3

            if FakeToggleKey then
                TextLabel2.Text = FakeToggleKey.Name
                Parent4.Visible = true
            end
            if not KeyboardEnabled2 then
                Parent4.Visible = false
            end
        else
            Argument1:setCaption( )
        end
    end

    local function SetCaptionEnabled( Enabled )
        if Flag == Enabled then
            return
        end

        local FlagInner
        local JoinedFrame = Argument1.joinedFrame
        FlagInner = if not JoinedFrame or not string.match( JoinedFrame.Name, "Dropdown" ) then Enabled else false
        local Number
        Flag = FlagInner
        Number = not FlagInner and 1 or 0
        local Captured = FlagInner and TweenInfo2 or TweenInfo3
        TweenService:Create( Parent2, Captured, { GroupTransparency = Number } ):Play( )

        if FlagInner then
            ClipOutside2:SetAttribute( "ForceUpdate", true )
        end

        local Flag2
        UpdatePosition( )
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local Text = Parent2:GetAttribute( "CaptionText" ) or ""
        Flag2 = Text == "_hotkey_" and true or false

        if not KeyboardEnabled and Flag2 then
            Argument1:setCaption( )
            return
        end

        Header.Text = Text
        Header.Visible = not Flag2

        if not KeyboardEnabled then
            Parent4.Visible = false
        end
    end

    local IconModule = require( Argument1.iconModule )
    CaptionJanitor:add( Argument1.stateChanged:Connect( function( Name )
        if Name ~= "Viewing" then
            IconModule.captionLastClosedClock = os.clock( )
            SetCaptionEnabled( false )
            return
        end

        local Clock2
        local CaptionLastClosedClock = IconModule.captionLastClosedClock

        if CaptionLastClosedClock then
            local Clock = os.clock( ) - CaptionLastClosedClock

            if Clock then
                Clock2 = Clock
            else
                Clock2 = 999
            end
        else
            Clock2 = 999
        end

        local Number = not ( Clock2 < 0.3 ) and 0.5 or 0
        task.delay( Number, function()
            if Argument1.activeState == "Viewing" then
                SetCaptionEnabled( true )
            end
        end )
    end ) )
    return Parent2
end
