-- ReplicatedStorage.TopbarPlus.Icon.Elements.Widget
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return function( Argument1, Argument2 )
    local Parent = Instance.new( "Frame" )
    Parent:SetAttribute( "WidgetUID", Argument1.UID )
    Parent.Name = "Widget"
    Parent.BackgroundTransparency = 1
    Parent.Visible = true
    Parent.ZIndex = 20
    Parent.Active = false
    Parent.ClipsDescendants = true
    local Parent2 = Instance.new( "Frame" )
    Parent2.Name = "IconButton"
    Parent2.Visible = true
    Parent2.ZIndex = 2
    Parent2.BorderSizePixel = 0
    Parent2.Parent = Parent
    Parent2.ClipsDescendants = true
    Parent2.Active = false
    Argument1.deselected:Connect( function()
        Parent2.ClipsDescendants = true
        task.delay( 0.2, function()
            if Argument1.isSelected then
                Parent2.ClipsDescendants = false
            end
        end )
    end )
    local GuiService = game:GetService( "GuiService" )
    Argument1:setBehaviour( "IconButton", "BackgroundTransparency", function( Amount )
        local PreferredTransparency = Amount * GuiService.PreferredTransparency

        if Amount == 1 then
            return Amount
        end
        return PreferredTransparency
    end )
    Argument1.janitor:add( GuiService:GetPropertyChangedSignal( "PreferredTransparency" ):Connect( function()
        Argument1:refreshAppearance( Parent2, "BackgroundTransparency" )
    end ) )
    local UICorner = Instance.new( "UICorner" )
    UICorner:SetAttribute( "Collective", "IconCorners" )
    UICorner.Name = "UICorner"
    UICorner.Parent = Parent2
    local Parent3 = require( script.Parent.Menu )( Argument1 )
    local MenuUIListLayout = Parent3.MenuUIListLayout
    local MenuGap = Parent3.MenuGap
    Parent3.Parent = Parent2
    local Parent4 = Instance.new( "Frame" )
    Parent4.Name = "IconSpot"
    Parent4.BackgroundColor3 = Color3.fromRGB( 225, 225, 225 )
    Parent4.BackgroundTransparency = 0.9
    Parent4.Visible = true
    Parent4.AnchorPoint = Vector2.new( 0, 0.5 )
    Parent4.ZIndex = 5
    Parent4.Parent = Parent3
    UICorner:Clone( ).Parent = Parent4
    local Clone = Parent4:Clone( )
    Clone.UICorner.Name = "OverlayUICorner"
    Clone.Name = "IconOverlay"
    Clone.BackgroundColor3 = Color3.fromRGB( 255, 255, 255 )
    Clone.ZIndex = Parent4.ZIndex + 1
    Clone.Size = UDim2.new( 1, 0, 1, 0 )
    Clone.Position = UDim2.new( 0, 0, 0, 0 )
    Clone.AnchorPoint = Vector2.new( 0, 0 )
    Clone.Visible = false
    Clone.Parent = Parent4
    local Parent5 = Instance.new( "TextButton" )
    Parent5:SetAttribute( "CorrespondingIconUID", Argument1.UID )
    Parent5.Name = "ClickRegion"
    Parent5.BackgroundTransparency = 1
    Parent5.Visible = true
    Parent5.Text = ""
    Parent5.ZIndex = 20
    Parent5.Selectable = true
    Parent5.SelectionGroup = true
    Parent5.Parent = Parent4
    require( script.Parent.Parent.Features.Gamepad ).registerButton( Parent5 )
    UICorner:Clone( ).Parent = Parent5
    local Parent6 = Instance.new( "Frame" )
    Parent6.Name = "Contents"
    Parent6.BackgroundTransparency = 1
    Parent6.Size = UDim2.fromScale( 1, 1 )
    Parent6.Parent = Parent4
    local UIListLayout = Instance.new( "UIListLayout" )
    UIListLayout.Name = "ContentsList"
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Padding = UDim.new( 0, 3 )
    UIListLayout.Parent = Parent6
    local Frame = Instance.new( "Frame" )
    Frame.Name = "PaddingLeft"
    Frame.LayoutOrder = 1
    Frame.ZIndex = 5
    Frame.BorderColor3 = Color3.fromRGB( 0, 0, 0 )
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.fromRGB( 255, 255, 255 )
    Frame.Parent = Parent6
    local Frame2 = Instance.new( "Frame" )
    Frame2.Name = "PaddingCenter"
    Frame2.LayoutOrder = 3
    Frame2.ZIndex = 5
    Frame2.Size = UDim2.new( 0, 0, 1, 0 )
    Frame2.BorderColor3 = Color3.fromRGB( 0, 0, 0 )
    Frame2.BackgroundTransparency = 1
    Frame2.BorderSizePixel = 0
    Frame2.BackgroundColor3 = Color3.fromRGB( 255, 255, 255 )
    Frame2.Parent = Parent6
    local Frame3 = Instance.new( "Frame" )
    Frame3.Name = "PaddingRight"
    Frame3.LayoutOrder = 5
    Frame3.ZIndex = 5
    Frame3.BorderColor3 = Color3.fromRGB( 0, 0, 0 )
    Frame3.BackgroundTransparency = 1
    Frame3.BorderSizePixel = 0
    Frame3.BackgroundColor3 = Color3.fromRGB( 255, 255, 255 )
    Frame3.Parent = Parent6
    local Parent7 = Instance.new( "Frame" )
    Parent7.Name = "IconLabelContainer"
    Parent7.LayoutOrder = 4
    Parent7.ZIndex = 3
    Parent7.AnchorPoint = Vector2.new( 0, 0.5 )
    Parent7.Size = UDim2.new( 0, 0, 0.5, 0 )
    Parent7.BackgroundTransparency = 1
    Parent7.Position = UDim2.new( 0.5, 0, 0.5, 0 )
    Parent7.Parent = Parent6
    local TextLabel = Instance.new( "TextLabel" )
    local X = workspace.CurrentCamera.ViewportSize.X + 200
    TextLabel.Name = "IconLabel"
    TextLabel.LayoutOrder = 4
    TextLabel.ZIndex = 15
    TextLabel.AnchorPoint = Vector2.new( 0, 0 )
    TextLabel.Size = UDim2.new( 0, X, 1, 0 )
    TextLabel.ClipsDescendants = false
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromScale( 0, 0 )
    TextLabel.RichText = true
    TextLabel.TextColor3 = Color3.fromRGB( 255, 255, 255 )
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ""
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.TextScaled = false
    TextLabel.Active = false
    TextLabel.AutoLocalize = true
    TextLabel.Parent = Parent7
    local Parent8 = Instance.new( "ImageLabel" )
    Parent8.Name = "IconImage"
    Parent8.LayoutOrder = 2
    Parent8.ZIndex = 15
    Parent8.AnchorPoint = Vector2.new( 0, 0.5 )
    Parent8.Size = UDim2.new( 0, 0, 0.5, 0 )
    Parent8.BackgroundTransparency = 1
    Parent8.Position = UDim2.new( 0, 11, 0.5, 0 )
    Parent8.ScaleType = Enum.ScaleType.Stretch
    Parent8.Active = false
    Parent8.Parent = Parent6
    local Clone2 = UICorner:Clone( )
    Clone2:SetAttribute( "Collective", nil )
    Clone2.CornerRadius = UDim.new( 0, 0 )
    Clone2.Name = "IconImageCorner"
    Clone2.Parent = Parent8
    local TweenService = game:GetService( "TweenService" )
    local Number = 0

    local function HandleLabelAndImageChangesUnstaggered( Argument1Inner )
        task.defer( function()
            local Indicator2
            local Indicator = Argument1.indicator
            Indicator2 = if Indicator then Indicator.Visible else Indicator
            local Indicator3

            if Indicator2 then
                Indicator3 = Indicator2
            elseif TextLabel.Text == "" then
                Indicator3 = false
            else
                Indicator3 = true
            end

            local Flag

            if Parent8.Image == "" then
                Flag = false
            elseif Parent8.Image == nil then
                Flag = false
            else
                Flag = true
            end

            local Size = UDim2.fromScale( 1, 1 )

            if not Flag or Indicator3 then
                if Flag or not Indicator3 then
                    if Flag and Indicator3 then
                        Parent7.Visible = true
                        Parent8.Visible = true
                        Frame.Visible = true
                        Frame2.Visible = not Indicator2
                        Frame3.Visible = not Indicator2
                    end
                else
                    Parent7.Visible = true
                    Parent8.Visible = false
                    Frame.Visible = true
                    Frame2.Visible = false
                    Frame3.Visible = true
                end
            else
                Parent7.Visible = false
                Parent8.Visible = true
                Frame.Visible = false
                Frame2.Visible = false
                Frame3.Visible = false
            end

            local Offset2
            Parent2.Size = Size

            local function GetItemWidth( Self )
                local TargetWidth2
                local TargetWidth = Self:GetAttribute( "TargetWidth" )
                TargetWidth2 = if TargetWidth then TargetWidth else Self.AbsoluteSize.X
                return TargetWidth2
            end

            local Offset = UIListLayout.Padding.Offset
            local XInner = TextLabel.TextBounds.X
            Parent7.Size = UDim2.new( 0, XInner, TextLabel.Size.Y.Scale, 0 )
            Offset2 = Offset

            for Key, Value in pairs( Parent6:GetChildren( ) ) do
                if Value:IsA( "GuiObject" ) and Value.Visible == true then
                    local TargetWidth10
                    local TargetWidth9 = Value:GetAttribute( "TargetWidth" )
                    TargetWidth10 = if TargetWidth9 then TargetWidth9 else Value.AbsoluteSize.X
                    Offset2 = Offset2 + ( TargetWidth10 + Offset )
                end
            end

            local Flag2
            local MinimumWidth = Parent:GetAttribute( "MinimumWidth" )
            local MinimumHeight = Parent:GetAttribute( "MinimumHeight" )
            local BorderSize = Parent:GetAttribute( "BorderSize" )
            local Clamp = math.clamp( Offset2, MinimumWidth, X )
            Flag2 = #Argument1.menuIcons > 0 and true or false
            local Flag3 = if Flag2 then Argument1.isSelected else Flag2
            local Clamp3, Number3

            if Flag3 then
                local NumberInner = 0

                for Key2, Value3 in pairs( Parent3:GetChildren( ) ) do
                    if Value3 ~= Parent4 and Value3:IsA( "GuiObject" ) and Value3.Visible then
                        local TargetWidth4
                        local TargetWidth3 = Value3:GetAttribute( "TargetWidth" )
                        TargetWidth4 = if TargetWidth3 then TargetWidth3 else Value3.AbsoluteSize.X
                        NumberInner = NumberInner + ( TargetWidth4 + MenuUIListLayout.Padding.Offset )
                    end
                end

                local Clamp2

                if Parent4.Visible then
                    Clamp2 = Clamp
                else
                    local TargetWidth2
                    local TargetWidth = Parent4:GetAttribute( "TargetWidth" )
                    TargetWidth2 = if TargetWidth then TargetWidth else Parent4.AbsoluteSize.X
                    Clamp2 = Clamp - ( TargetWidth2 + MenuUIListLayout.Padding.Offset * 2 + BorderSize )
                end

                local Number2 = NumberInner - BorderSize * 0.5
                Clamp3 = Clamp2 + ( Number2 - BorderSize * 0.75 )
                Number3 = Number2
            else
                Clamp3 = Clamp
                Number3 = 0
            end

            local Visible = if Flag3 then Parent4.Visible else Flag3
            MenuGap.Visible = Visible
            local DesiredWidth = Parent:GetAttribute( "DesiredWidth" )

            if DesiredWidth and Clamp3 < DesiredWidth then
                Clamp3 = DesiredWidth
            end

            local MenuWidth2
            Argument1.updateMenu:Fire( )
            local Max = math.max( Clamp3 - Number3, MinimumWidth ) - BorderSize * 2
            local MenuWidth = Parent3:GetAttribute( "MenuWidth" )

            if MenuWidth then
                MenuWidth2 = MenuWidth + Max + MenuUIListLayout.Padding.Offset + 10
            else
                MenuWidth2 = MenuWidth
            end
            if MenuWidth2 then
                local MaxWidth = Parent3:GetAttribute( "MaxWidth" )

                if MaxWidth then
                    MenuWidth2 = math.max( MaxWidth, MinimumWidth )
                end

                Parent3:SetAttribute( "MenuCanvasWidth", Clamp3 )

                if MenuWidth2 < Clamp3 then
                    Clamp3 = MenuWidth2
                end
            end

            local TargetWidth6
            local TargetWidth5 = Parent4:GetAttribute( "TargetWidth" )
            TargetWidth6 = if TargetWidth5 then TargetWidth5 else Parent4.AbsoluteSize.X
            local TargetWidth8
            local Max2 = math.max( Max, TargetWidth6, Parent4.AbsoluteSize.X )
            local TargetWidth7 = Parent:GetAttribute( "TargetWidth" )
            TargetWidth8 = if TargetWidth7 then TargetWidth7 else Parent.AbsoluteSize.X
            local Flag4
            local Max3 = math.max( Clamp3, TargetWidth8, Parent.AbsoluteSize.X )
            local TweenInfo2 = TweenInfo.new( Max2 / 750, Enum.EasingStyle.Quint, Enum.EasingDirection.Out )
            local TweenInfo3 = TweenInfo.new( Max3 / 750, Enum.EasingStyle.Quint, Enum.EasingDirection.Out )
            TweenService:Create( Parent4, TweenInfo2, {
                Position = UDim2.new( 0, BorderSize, 0.5, 0 ),
                Size = UDim2.new( 0, Max, 1, -BorderSize * 2 )
            } ):Play( )
            TweenService:Create( Parent5, TweenInfo2, { Size = UDim2.new( 0, Max, 1, 0 ) } ):Play( )
            local Size2 = UDim2.fromOffset( Clamp3, MinimumHeight )
            Flag4 = Parent.Size.Y.Offset ~= MinimumHeight and true or false

            if Flag4 then
                Parent.Size = Size2
            end

            Parent:SetAttribute( "TargetWidth", Size2.X.Offset )
            TweenService:Create( Parent, TweenInfo3, { Size = Size2 } ):Play( )
            Number = Number + 1
            local Time = TweenInfo3.Time * 100
            local I = 1

            for I = 1, Time do
                task.delay( I / 100, function()
                    Argument2.iconChanged:Fire( Argument1 )
                end )
            end

            task.delay( TweenInfo3.Time - 0.2, function()
                Number = Number - 1
                task.defer( function()
                    if Number == 0 then
                        Argument1.resizingComplete:Fire( )
                    end
                end )
            end )
            Argument1:updateParent( )
        end )
    end

    local Stagger = require( script.Parent.Parent.Utility ).createStagger( 0.01, HandleLabelAndImageChangesUnstaggered )
    local Flag = true
    Argument1:setBehaviour( "IconLabel", "Text", Stagger )
    Argument1:setBehaviour( "IconLabel", "FontFace", function( Argument1 )
        if TextLabel.FontFace == Argument1 then
            return
        end
        task.spawn( function()
            Stagger( )

            if Flag then
                Flag = false
                local I = 1

                for I = 1, 10 do
                    task.wait( 1 )
                    Stagger( )
                end
            end
        end )
        return
    end )

    local function UpdateBorderSize()
        task.defer( function()
            local Number
            local BorderSize = Parent:GetAttribute( "BorderSize" )
            local Alignment = Argument1.alignment

            if Parent4.Visible == false then
                Number = 0
            elseif Alignment ~= "Right" or not -BorderSize then
                Number = BorderSize
            else
                Number = -BorderSize
            end

            Parent3.Position = UDim2.new( 0, Number, 0, 0 )
            MenuGap.Size = UDim2.fromOffset( BorderSize, 0 )
            MenuUIListLayout.Padding = UDim.new( 0, 0 )
            Stagger( )
        end )
    end

    Argument1:setBehaviour( "Widget", "BorderSize", UpdateBorderSize )
    Argument1:setBehaviour( "IconSpot", "Visible", UpdateBorderSize )
    Argument1.startMenuUpdate:Connect( Stagger )
    Argument1.updateSize:Connect( Stagger )
    Argument1:setBehaviour( "ContentsList", "HorizontalAlignment", Stagger )
    Argument1:setBehaviour( "Widget", "Visible", Stagger )
    Argument1:setBehaviour( "Widget", "DesiredWidth", Stagger )
    Argument1:setBehaviour( "Widget", "MinimumWidth", Stagger )
    Argument1:setBehaviour( "Widget", "MinimumHeight", Stagger )
    Argument1:setBehaviour( "Indicator", "Visible", Stagger )
    Argument1:setBehaviour( "IconImageRatio", "AspectRatio", Stagger )
    Argument1:setBehaviour( "IconImage", "Image", function( Text )
        local Text2

        if not tonumber( Text ) or not ( "http://www.roblox.com/asset/?id=" .. Text ) then
            if Text then
                Text2 = Text
            else
                Text2 = ""
            end
        else
            Text2 = "http://www.roblox.com/asset/?id=" .. Text
        end
        if Parent8.Image ~= Text2 then
            Stagger( )
        end

        return Text2
    end )
    Argument1.alignmentChanged:Connect( function( HorizontalAlignmentName )
        local Text = if HorizontalAlignmentName == "Center" then "Left" else HorizontalAlignmentName
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[ Text ]
        task.defer( function()
            local Number
            local BorderSize = Parent:GetAttribute( "BorderSize" )
            local Alignment = Argument1.alignment

            if Parent4.Visible == false then
                Number = 0
            elseif Alignment ~= "Right" or not -BorderSize then
                Number = BorderSize
            else
                Number = -BorderSize
            end

            Parent3.Position = UDim2.new( 0, Number, 0, 0 )
            MenuGap.Size = UDim2.fromOffset( BorderSize, 0 )
            MenuUIListLayout.Padding = UDim.new( 0, 0 )
            Stagger( )
        end )
    end )
    local LocalPlayer = game:GetService( "Players" ).LocalPlayer
    local LocaleId = LocalPlayer.LocaleId
    Argument1.janitor:add( LocalPlayer:GetPropertyChangedSignal( "LocaleId" ):Connect( function()
        task.delay( 0.2, function()
            local LocaleIdInner = LocalPlayer.LocaleId

            if LocaleIdInner ~= LocaleId then
                LocaleId = LocaleIdInner
                Argument1:refresh( )
                task.wait( 0.5 )
                Argument1:refresh( )
            end
        end )
    end ) )
    local NumberValue = Instance.new( "NumberValue" )
    NumberValue.Name = "IconImageScale"
    NumberValue.Parent = Parent8
    NumberValue:GetPropertyChangedSignal( "Value" ):Connect( function()
        local Value = NumberValue.Value
        Parent8.Size = UDim2.new( Value, 0, NumberValue.Value, 0 )
    end )
    local UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
    UIAspectRatioConstraint.Name = "IconImageRatio"
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = Parent8
    local UIGradient = Instance.new( "UIGradient" )
    UIGradient.Name = "IconGradient"
    UIGradient.Enabled = true
    UIGradient.Parent = Parent2
    local UIGradient2 = Instance.new( "UIGradient" )
    UIGradient2.Name = "IconSpotGradient"
    UIGradient2.Enabled = true
    UIGradient2.Parent = Parent4
    return Parent
end
