-- ReplicatedStorage.TopbarPlus.Icon.Elements.Menu
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return function( Argument1 )
    local Parent = Instance.new( "ScrollingFrame" )
    Parent.Name = "Menu"
    Parent.BackgroundTransparency = 1
    Parent.Visible = true
    Parent.ZIndex = 1
    Parent.Size = UDim2.fromScale( 1, 1 )
    Parent.ClipsDescendants = true
    Parent.TopImage = ""
    Parent.BottomImage = ""
    Parent.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
    Parent.CanvasSize = UDim2.new( 0, 0, 1, -1 )
    Parent.ScrollingEnabled = true
    Parent.ScrollingDirection = Enum.ScrollingDirection.X
    Parent.ZIndex = 20
    Parent.ScrollBarThickness = 3
    Parent.ScrollBarImageColor3 = Color3.fromRGB( 255, 255, 255 )
    Parent.ScrollBarImageTransparency = 0.8
    Parent.BorderSizePixel = 0
    Parent.Selectable = false
    local IconModule = require( Argument1.iconModule )
    local Clone = IconModule.container.TopbarStandard:FindFirstChild( "UIListLayout", true ):Clone( )
    Clone.Name = "MenuUIListLayout"
    Clone.VerticalAlignment = Enum.VerticalAlignment.Center
    Clone.Parent = Parent
    local Frame = Instance.new( "Frame" )
    Frame.Name = "MenuGap"
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    Frame.AnchorPoint = Vector2.new( 0, 0.5 )
    Frame.ZIndex = 5
    Frame.Parent = Parent
    local Flag = false
    local Themes = require( script.Parent.Parent.Features.Themes )

    local function TotalChildrenChanged()
        local MenuJanitor = Argument1.menuJanitor
        local Count = #Argument1.menuIcons

        if Flag then
            if Count <= 0 then
                MenuJanitor:clean( )
                Flag = false
            end

            return
        end
        Flag = true
        MenuJanitor:add( Argument1.toggled:Connect( function()
            if #Argument1.menuIcons > 0 then
                Argument1.updateSize:Fire( )
            end
        end ) )
        local _, ModifyTheme2 = Argument1:modifyTheme( { { "Menu", "Active", true } } )
        task.defer( function()
            MenuJanitor:add( function()
                Argument1:removeModification( ModifyTheme2 )
            end )
        end )
        local X = Parent.AbsoluteCanvasSize.X

        local function RightAlignCanvas()
            if Argument1.alignment == "Right" then
                local XInner = Parent.AbsoluteCanvasSize.X
                local Captured = X - XInner
                X = XInner
                Parent.CanvasPosition = Vector2.new( Parent.CanvasPosition.X - Captured, 0 )
            end
        end

        MenuJanitor:add( Argument1.selected:Connect( RightAlignCanvas ) )
        MenuJanitor:add( Parent:GetPropertyChangedSignal( "AbsoluteCanvasSize" ):Connect( RightAlignCanvas ) )
        local GetStateGroup = Argument1:getStateGroup( )

        if Themes.getThemeValue( GetStateGroup, "IconImage", "Image", "Deselected" ) == Themes.getThemeValue( GetStateGroup, "IconImage", "Image", "Selected" ) then
            local Font2 = Font.new( "rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal )
            Argument1:removeModificationWith( "IconLabel", "Text", "Viewing" )
            Argument1:removeModificationWith( "IconLabel", "Image", "Viewing" )
            Argument1:modifyTheme( {
                { "IconLabel", "FontFace", Font2, "Selected" },
                { "IconLabel", "Text", "X", "Selected" },
                { "IconLabel", "TextSize", 20, "Selected" },
                { "IconLabel", "TextStrokeTransparency", 0.8, "Selected" },
                { "IconImage", "Image", "", "Selected" }
            } )
        end

        local Number, LayoutOrder
        local GetInstance = Argument1:getInstance( "MenuGap" )

        local function UpdateAlignent()
            local Number, LayoutOrder

            if Argument1.alignment == "Right" then
                Number = 99999
                LayoutOrder = 99998
            else
                Number = -99999
                LayoutOrder = -99998
            end

            Argument1:modifyTheme( { "IconSpot", "LayoutOrder", Number } )
            GetInstance.LayoutOrder = LayoutOrder
        end

        MenuJanitor:add( Argument1.alignmentChanged:Connect( UpdateAlignent ) )

        if Argument1.alignment == "Right" then
            Number = 99999
            LayoutOrder = 99998
        else
            Number = -99999
            LayoutOrder = -99998
        end

        Argument1:modifyTheme( { "IconSpot", "LayoutOrder", Number } )
        GetInstance.LayoutOrder = LayoutOrder
        Parent:GetAttributeChangedSignal( "MenuCanvasWidth" ):Connect( function()
            local MenuCanvasWidth = Parent:GetAttribute( "MenuCanvasWidth" )
            local Y = Parent.CanvasSize.Y
            Parent.CanvasSize = UDim2.new( 0, MenuCanvasWidth, Y.Scale, Y.Offset )
        end )
        MenuJanitor:add( Argument1.updateMenu:Connect( function()
            local MaxIcons = Parent:GetAttribute( "MaxIcons" )

            if not MaxIcons then
                return
            end

            local Table = { }

            for Key, Value in pairs( Parent:GetChildren( ) ) do
                if Value:GetAttribute( "WidgetUID" ) and Value.Visible then
                    table.insert( Table, { Value, Value.AbsolutePosition.X } )
                end
            end

            local Number
            table.sort( Table, function( List, List2 )
                local Flag = List[ 2 ] < List2[ 2 ] and true or false
                return Flag
            end )
            local I = 1
            Number = 0

            for I = 1, MaxIcons do
                local Entry = Table[ I ]

                if not Entry then
                    break
                end

                Number = Number + ( Entry[ 1 ].AbsoluteSize.X + Clone.Padding.Offset )
            end

            Parent:SetAttribute( "MenuWidth", Number )
        end ) )

        local function StartMenuUpdate()
            task.delay( 0.1, function()
                Argument1.startMenuUpdate:Fire( )
            end )
        end

        MenuJanitor:add( Parent.ChildAdded:Connect( StartMenuUpdate ) )
        MenuJanitor:add( Parent.ChildRemoved:Connect( StartMenuUpdate ) )
        MenuJanitor:add( Parent:GetAttributeChangedSignal( "MaxIcons" ):Connect( StartMenuUpdate ) )
        MenuJanitor:add( Parent:GetAttributeChangedSignal( "MaxWidth" ):Connect( StartMenuUpdate ) )
        task.delay( 0.1, function()
            Argument1.startMenuUpdate:Fire( )
        end )
        return
    end

    Argument1.menuChildAdded:Connect( TotalChildrenChanged )
    Argument1.menuSet:Connect( function( List )
        for Key, Value in pairs( Argument1.menuIcons ) do
            IconModule.getIconByUID( Value ):destroy( )
        end
        if type( List ) == "table" then
            for Key2, Value3 in pairs( List ) do
                Value3:joinMenu( Argument1 )
            end
        end
    end )
    return Parent
end
