-- ReplicatedStorage.TopbarPlus.Icon.Elements.Indicator
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return function( Argument1, Argument2 )
    local Widget = Argument1.widget
    local Parent = Argument1:getInstance( "Contents" )
    local Parent2 = Instance.new( "Frame" )
    Parent2.Name = "Indicator"
    Parent2.LayoutOrder = 9999999
    Parent2.ZIndex = 6
    Parent2.Size = UDim2.new( 0, 42, 0, 42 )
    Parent2.BorderColor3 = Color3.fromRGB( 0, 0, 0 )
    Parent2.BackgroundTransparency = 1
    Parent2.Position = UDim2.new( 1, 0, 0.5, 0 )
    Parent2.BorderSizePixel = 0
    Parent2.BackgroundColor3 = Color3.fromRGB( 0, 0, 0 )
    Parent2.Parent = Parent
    local Parent3 = Instance.new( "Frame" )
    Parent3.Name = "IndicatorButton"
    Parent3.BorderColor3 = Color3.fromRGB( 0, 0, 0 )
    Parent3.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Parent3.BorderSizePixel = 0
    Parent3.BackgroundColor3 = Color3.fromRGB( 0, 0, 0 )
    Parent3.Parent = Parent2
    local GuiService = game:GetService( "GuiService" )
    local GamepadService = game:GetService( "GamepadService" )
    local GetInstance = Argument1:getInstance( "ClickRegion" )

    local function SelectionChanged()
        if GuiService.SelectedObject == GetInstance then
            Parent3.BackgroundTransparency = 1
            Parent3.Position = UDim2.new( 0.5, -2, 0.5, 0 )
            Parent3.Size = UDim2.fromScale( 1.2, 1.2 )
            return
        end
        Parent3.BackgroundTransparency = 0.75
        Parent3.Position = UDim2.new( 0.5, 2, 0.5, 0 )
        Parent3.Size = UDim2.fromScale( 1, 1 )
        return
    end

    Argument1.janitor:add( GuiService:GetPropertyChangedSignal( "SelectedObject" ):Connect( SelectionChanged ) )
    SelectionChanged( )
    local ImageLabel = Instance.new( "ImageLabel" )
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new( 0.5, 0.5 )
    ImageLabel.Size = UDim2.new( 0.5, 0, 0.5, 0 )
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new( 0.5, 0, 0.5, 0 )
    ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
    ImageLabel.Parent = Parent3
    local UICorner = Instance.new( "UICorner" )
    UICorner.CornerRadius = UDim.new( 1, 0 )
    UICorner.Parent = Parent3
    local UserInputService = game:GetService( "UserInputService" )

    local function SetIndicatorVisible( Visible )
        local Visible2

        if Visible == nil then
            Visible2 = Parent2.Visible
        else
            Visible2 = Visible
        end
        if GamepadService.GamepadCursorEnabled then
            Visible2 = false
        end
        if Visible2 then
            Argument1:modifyTheme( { "PaddingRight", "Size", UDim2.new( 0, 0, 1, 0 ) }, "IndicatorPadding" )
        elseif Parent2.Visible then
            Argument1:removeModification( "IndicatorPadding" )
        end

        Argument1:modifyTheme( { "Indicator", "Visible", Visible2 } )
        Argument1.updateSize:Fire( )
    end

    Argument1.janitor:add( GamepadService:GetPropertyChangedSignal( "GamepadCursorEnabled" ):Connect( SetIndicatorVisible ) )
    Argument1.indicatorSet:Connect( function( Argument1 )
        local Flag

        if Argument1 then
            ImageLabel.Image = UserInputService:GetImageForKeyCode( Argument1 )
            Flag = true
        else
            Flag = false
        end

        SetIndicatorVisible( Flag )
    end )

    local function UpdateSize()
        local Y = Widget.AbsoluteSize.Y * 0.96
        Parent2.Size = UDim2.new( 0, Y, 0, Y )
    end

    Widget:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( UpdateSize )
    local Y = Widget.AbsoluteSize.Y * 0.96
    Parent2.Size = UDim2.new( 0, Y, 0, Y )
    return Parent2
end
