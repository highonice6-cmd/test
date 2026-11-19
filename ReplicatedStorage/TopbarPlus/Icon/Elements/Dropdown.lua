-- ReplicatedStorage.TopbarPlus.Icon.Elements.Dropdown
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local TweenService = game:GetService( "TweenService" )
local RunService = game:GetService( "RunService" )
local Themes = require( script.Parent.Parent.Features.Themes )
return function( Argument1 )
    local Parent = Instance.new( "Frame" )
    Parent.Name = "Dropdown"
    Parent.AutomaticSize = Enum.AutomaticSize.X
    Parent.BackgroundTransparency = 1
    Parent.BorderSizePixel = 0
    Parent.AnchorPoint = Vector2.new( 0.5, 0 )
    Parent.Position = UDim2.new( 0.5, 0, 1, 10 )
    Parent.ZIndex = -2
    Parent.ClipsDescendants = true
    Parent.Parent = Argument1.widget
    local GuiService = game:GetService( "GuiService" )
    Argument1:setBehaviour( "Dropdown", "BackgroundTransparency", function( Amount )
        local PreferredTransparency = Amount * GuiService.PreferredTransparency

        if Amount == 1 then
            return Amount
        end
        return PreferredTransparency
    end )
    Argument1.janitor:add( GuiService:GetPropertyChangedSignal( "PreferredTransparency" ):Connect( function()
        Argument1:refreshAppearance( Parent, "BackgroundTransparency" )
    end ) )
    local UICorner = Instance.new( "UICorner" )
    UICorner.Name = "DropdownCorner"
    UICorner.CornerRadius = UDim.new( 0, 10 )
    UICorner.Parent = Parent
    local Parent2 = Instance.new( "ScrollingFrame" )
    Parent2.Name = "DropdownScroller"
    Parent2.AutomaticSize = Enum.AutomaticSize.X
    Parent2.BackgroundTransparency = 1
    Parent2.BorderSizePixel = 0
    Parent2.AnchorPoint = Vector2.new( 0, 0 )
    Parent2.Position = UDim2.new( 0, 0, 0, 0 )
    Parent2.ZIndex = -1
    Parent2.ClipsDescendants = true
    Parent2.Visible = true
    Parent2.VerticalScrollBarInset = Enum.ScrollBarInset.None
    Parent2.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    Parent2.Active = false
    Parent2.ScrollingEnabled = true
    Parent2.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Parent2.ScrollBarThickness = 5
    Parent2.ScrollBarImageColor3 = Color3.fromRGB( 255, 255, 255 )
    Parent2.ScrollBarImageTransparency = 0.8
    Parent2.CanvasSize = UDim2.new( 0, 0, 0, 0 )
    Parent2.Selectable = false
    Parent2.Active = true
    Parent2.Parent = Parent
    local NumberValue = Instance.new( "NumberValue" )
    NumberValue.Name = "DropdownSpeed"
    NumberValue.Value = 0.07
    NumberValue.Parent = Parent
    local UIPadding = Instance.new( "UIPadding" )
    UIPadding.Name = "DropdownPadding"
    UIPadding.PaddingTop = UDim.new( 0, 0 )
    UIPadding.PaddingBottom = UDim.new( 0, 0 )
    UIPadding.Parent = Parent2
    local UIListLayout = Instance.new( "UIListLayout" )
    UIListLayout.Name = "DropdownList"
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Parent = Parent2
    local DropdownJanitor = Argument1.dropdownJanitor
    local IconModule = require( Argument1.iconModule )
    Argument1.dropdownChildAdded:Connect( function( Argument1 )
        local _, ModifyTheme2 = Argument1:modifyTheme( {
            { "Widget", "BorderSize", 0 },
            { "IconCorners", "CornerRadius", UDim.new( 0, 10 ) },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 58 },
            { "IconLabel", "TextSize", 20 },
            { "IconOverlay", "Size", UDim2.new( 1, 0, 1, 0 ) },
            { "PaddingLeft", "Size", UDim2.fromOffset( 25, 0 ) },
            { "Notice", "Position", UDim2.new( 1, -24, 0, 5 ) },
            { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
            { "Selection", "Size", UDim2.new( 1, -0, 1, -0 ) },
            { "Selection", "Position", UDim2.new( 0, 0, 0, 0 ) }
        } )
        task.defer( function()
            Argument1.joinJanitor:add( function()
                Argument1:removeModification( ModifyTheme2 )
            end )
        end )
    end )
    Argument1.dropdownSet:Connect( function( List )
        for Key, Value in pairs( Argument1.dropdownIcons ) do
            IconModule.getIconByUID( Value ):destroy( )
        end
        if type( List ) == "table" then
            for Key2, Value3 in pairs( List ) do
                Value3:joinDropdown( Argument1 )
            end
        end
    end )

    local function UpdateMaxIcons()
        local MaxIcons = Parent:GetAttribute( "MaxIcons" )

        if not MaxIcons then
            return 0
        end

        local Table = { }

        for Key, Value in pairs( Parent2:GetChildren( ) ) do
            if Value:IsA( "GuiObject" ) and Value.Visible then
                table.insert( Table, Value )
            end
        end

        local Number
        table.sort( Table, function( Argument1, Argument2 )
            local Flag = Argument1.AbsolutePosition.Y < Argument2.AbsolutePosition.Y and true or false
            return Flag
        end )
        local Ceil = math.ceil( MaxIcons )
        local I = 1
        Number = 0

        for I = 1, Ceil do
            local Entry = Table[ I ]

            if not Entry then
                break
            end

            local Flag
            local Y = Entry.AbsoluteSize.Y

            if I == Ceil then
                if Ceil == MaxIcons then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end

            local Y2 = if Flag then Y * ( MaxIcons - Ceil + 1 ) else Y
            Number = Number + Y2
        end

        return Number + ( UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset )
    end

    local Value1 = nil
    local Value2 = nil
    local Value3 = nil
    local Value4 = nil

    local function GetTweenInfo()
        local InstanceValue = Themes.getInstanceValue( Parent, "MaxIcons" ) or 1

        if not Value3 or Value3 ~= InstanceValue or not Value4 then
            local TweenInfo2 = TweenInfo.new( NumberValue.Value * InstanceValue, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out )
            Value4 = TweenInfo2
            Value3 = InstanceValue
            return TweenInfo2
        end
        return Value4
    end

    local function UpdateVisibility()
        local Captured
        local InstanceValue = Themes.getInstanceValue( Parent, "MaxIcons" ) or 1

        if not Value3 or Value3 ~= InstanceValue or not Value4 then
            local TweenInfo2 = TweenInfo.new( NumberValue.Value * InstanceValue, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out )
            Value4 = TweenInfo2
            Value3 = InstanceValue
            Captured = TweenInfo2
        else
            Captured = Value4
        end
        if Value1 then
            Value1:Cancel( )
            Value1 = nil
        end
        if Value2 then
            Value2:Cancel( )
            Value2 = nil
        end
        if Argument1.isSelected then
            local MaxIcons = UpdateMaxIcons( )
            Parent.Visible = true
            Parent.BackgroundTransparency = 0
            Parent.Size = UDim2.new( 0, Parent.Size.X.Offset, 0, 0 )
            Value1 = TweenService:Create( Parent, Captured, { Size = UDim2.new( 0, Parent.Size.X.Offset, 0, MaxIcons ) } )
            Value1:Play( )
            Value1.Completed:Connect( function()
                Value1 = nil
            end )
            return
        end
        local TweenInfo3 = TweenInfo.new( 0 )
        Value2 = TweenService:Create( Parent, TweenInfo3, { Size = UDim2.new( 0, Parent.Size.X.Offset, 0, 0 ) } )
        Value2:Play( )
        Value2.Completed:Connect( function()
            Value2 = nil
        end )
        return
    end

    DropdownJanitor:add( Argument1.toggled:Connect( UpdateVisibility ) )
    UpdateVisibility( )

    local function UpdateChildSize()
        local Captured
        local InstanceValue = Themes.getInstanceValue( Parent, "MaxIcons" ) or 1

        if not Value3 or Value3 ~= InstanceValue or not Value4 then
            local TweenInfo2 = TweenInfo.new( NumberValue.Value * InstanceValue, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out )
            Value4 = TweenInfo2
            Value3 = InstanceValue
            Captured = TweenInfo2
        else
            Captured = Value4
        end
        if not Argument1.isSelected then
            return
        end
        if Value1 then
            Value1:Cancel( )
            Value1 = nil
        end
        if Value2 then
            Value2:Cancel( )
            Value2 = nil
        end

        RunService.Heartbeat:Wait( )
        local MaxIcons = UpdateMaxIcons( )
        Value1 = TweenService:Create( Parent, Captured, { Size = UDim2.new( 0, Parent.Size.X.Offset, 0, MaxIcons ) } )
        Value1:Play( )
        Value1.Completed:Connect( function()
            Value1 = nil
        end )
    end

    DropdownJanitor:add( Argument1.toggled:Connect( UpdateVisibility ) )
    local Number = 0
    local Flag = false

    local function UpdateMaxIconsListener()
        Number = Number + 1

        if Flag then
            return
        end

        Flag = true
        task.defer( function()
            Flag = false

            if Number ~= Number then
                UpdateMaxIconsListener( )
            end
        end )
        local MaxIcons = Parent:GetAttribute( "MaxIcons" )

        if not MaxIcons then
            return
        end

        local Table = { }

        for Key, Value in pairs( Parent2:GetChildren( ) ) do
            if Value:IsA( "GuiObject" ) and Value.Visible then
                table.insert( Table, { Value, Value.AbsolutePosition.Y } )
            end
        end

        local NumberInner, Flag2
        table.sort( Table, function( List, List2 )
            local Flag = List[ 2 ] < List2[ 2 ] and true or false
            return Flag
        end )
        local Ceil = math.ceil( MaxIcons )
        local I = 1
        NumberInner = 0
        Flag2 = false

        for I = 1, Ceil do
            local Entry = Table[ I ]

            if not Entry then
                break
            end

            local FlagInner
            local Item = Entry[ 1 ]
            local Y = Item.AbsoluteSize.Y

            if I == Ceil then
                if Ceil == MaxIcons then
                    FlagInner = false
                else
                    FlagInner = true
                end
            else
                FlagInner = false
            end

            local Y2 = if FlagInner then Y * ( MaxIcons - Ceil + 1 ) else Y
            NumberInner = NumberInner + Y2

            if not FlagInner then
                local IconByUID
                local WidgetUID = Item:GetAttribute( "WidgetUID" )

                if WidgetUID then
                    IconByUID = IconModule.getIconByUID( WidgetUID )
                else
                    IconByUID = WidgetUID
                end
                if IconByUID then
                    local NextSelectionUp

                    if Flag2 then
                        NextSelectionUp = nil
                    else
                        NextSelectionUp = Argument1:getInstance( "ClickRegion" )
                        Flag2 = true
                    end

                    IconByUID:getInstance( "ClickRegion" ).NextSelectionUp = NextSelectionUp
                end
            end
        end

        Parent2.Size = UDim2.fromOffset( 0, NumberInner + ( UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset ) )
    end

    DropdownJanitor:add( Parent2:GetPropertyChangedSignal( "AbsoluteCanvasSize" ):Connect( UpdateMaxIconsListener ) )
    DropdownJanitor:add( Parent2.ChildAdded:Connect( UpdateMaxIconsListener ) )
    DropdownJanitor:add( Parent2.ChildRemoved:Connect( UpdateChildSize ) )
    DropdownJanitor:add( Parent2.ChildRemoved:Connect( UpdateMaxIconsListener ) )
    DropdownJanitor:add( Parent:GetAttributeChangedSignal( "MaxIcons" ):Connect( UpdateMaxIconsListener ) )
    DropdownJanitor:add( Parent:GetAttributeChangedSignal( "MaxIcons" ):Connect( UpdateChildSize ) )
    DropdownJanitor:add( Argument1.childThemeModified:Connect( UpdateMaxIconsListener ) )
    UpdateMaxIconsListener( )

    local function ConnectVisibilityListeners( Self )
        if Self:IsA( "GuiObject" ) then
            Self:GetPropertyChangedSignal( "Visible" ):Connect( UpdateChildSize )
            Self:GetPropertyChangedSignal( "Size" ):Connect( UpdateChildSize )
        end
    end

    for Key, Value in pairs( Parent2:GetChildren( ) ) do
        if Value:IsA( "GuiObject" ) then
            Value:GetPropertyChangedSignal( "Visible" ):Connect( UpdateChildSize )
            Value:GetPropertyChangedSignal( "Size" ):Connect( UpdateChildSize )
        end
    end

    Parent2.ChildAdded:Connect( function( Self )
        RunService.Heartbeat:Wait( )

        if Self:IsA( "GuiObject" ) then
            Self:GetPropertyChangedSignal( "Visible" ):Connect( UpdateChildSize )
            Self:GetPropertyChangedSignal( "Size" ):Connect( UpdateChildSize )
        end

        UpdateChildSize( )
    end )
    Parent.Visible = false
    return Parent
end
