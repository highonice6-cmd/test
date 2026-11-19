-- ReplicatedStorage.TopbarPlus.Icon.Utility
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local LocalPlayer = game:GetService( "Players" ).LocalPlayer
local Table = {
    createStagger = function( Amount, Argument2, Argument3 )
        local Number
        local Flag = false
        local Flag2 = false
        Number = ( not Amount or Amount == 0 ) and 0.01 or Amount

        local function StaggeredCallback( ... )
            if Flag then
                Flag2 = true
                return
            end
            local Pack = table.pack( ... )
            Flag = true
            Flag2 = false
            task.spawn( function()
                if Argument3 then
                    task.wait( Number )
                end

                Argument2( table.unpack( Pack ) )
            end )
            task.delay( Number, function()
                Flag = false

                if Flag2 then
                    StaggeredCallback( table.unpack( Pack ) )
                end
            end )
            return
        end

        return StaggeredCallback
    end,
    round = function( Amount )
        return ( math.floor( Amount + 0.5 ) )
    end,
    reverseTable = function( List )
        local Floor = math.floor( #List / 2 )
        local I = 1

        for I = 1, Floor do
            local Count = #List - I + 1
            local Entry = List[ Count ]
            local Entry2 = List[ I ]
            List[ I ] = Entry
            List[ Count ] = Entry2
        end
    end
}
function Table.copyTable( List )
    local Flag = type( List ) == "table" and true or false
    assert( Flag, "First argument must be a table" )
    local Create = table.create( #List )

    for Key, Value in pairs( List ) do
        if type( Value ) == "table" then
            Create[ Key ] = Table.copyTable( Value )
        else
            Create[ Key ] = Value
        end
    end

    return Create
end
local Table2 = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "<",
    ">",
    "?",
    "@",
    "{",
    "}",
    "[",
    "]",
    "!",
    "(",
    ")",
    "=",
    "+",
    "~",
    "#"
}
function Table.generateUID( Amount )
    local Text
    local Number = Amount or 8
    local Count = #Table2
    local I = 1
    Text = ""

    for I = 1, Number do
        Text = Text .. Table2[ math.random( 1, Count ) ]
    end

    return Text
end
local Table3 = { }
function Table.setVisible( VisibleName, Visible, VisibleName2 )
    local Entry2
    local Entry = Table3[ VisibleName ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { }
        Table3[ VisibleName ] = Table
        VisibleName.Destroying:Once( function()
            Table3[ VisibleName ] = nil
        end )
        Entry2 = Table
    end
    if Visible then
        Entry2[ VisibleName2 ] = nil
    else
        Entry2[ VisibleName2 ] = true
    end

    local Visible2

    if Visible then
        local Value1, Value2, Value3 = pairs( Entry2 )
        local Value4 = Value1( Value2, Value3 )

        if Value4 == nil then
            Visible2 = Visible
        else
            Visible2 = false
        end
    else
        Visible2 = Visible
    end

    VisibleName.Visible = Visible2
end
function Table.formatStateName( Text )
    return string.upper( ( string.sub( Text, 1, 1 ) ) ) .. string.lower( ( string.sub( Text, 2 ) ) )
end
function Table.localPlayerRespawned( Argument1 )
    LocalPlayer.CharacterRemoving:Connect( Argument1 )
end
function Table.getClippedContainer( Parent )
    local ClippedContainer2
    local ClippedContainer = Parent:FindFirstChild( "ClippedContainer" )

    if ClippedContainer then
        ClippedContainer2 = ClippedContainer
    else
        local Folder = Instance.new( "Folder" )
        Folder.Name = "ClippedContainer"
        Folder.Parent = Parent
        ClippedContainer2 = Folder
    end

    return ClippedContainer2
end
local Janitor = require( script.Parent.Packages.Janitor )
local GuiService = game:GetService( "GuiService" )
function Table.clipOutside( Argument1, Value )
    local Add = Argument1.janitor:add( Janitor.new( ) )
    Value.Destroying:Once( function()
        Add:Destroy( )
    end )
    Argument1.janitor:add( Value )
    local Parent = Value.Parent
    local Parent2 = Add:add( Instance.new( "Frame" ) )
    Parent2:SetAttribute( "IsAClippedClone", true )
    Parent2.Name = Value.Name
    Parent2.AnchorPoint = Value.AnchorPoint
    Parent2.Size = Value.Size
    Parent2.Position = Value.Position
    Parent2.BackgroundTransparency = 1
    Parent2.LayoutOrder = Value.LayoutOrder
    Parent2.Parent = Parent
    local ObjectValue = Instance.new( "ObjectValue" )
    ObjectValue.Name = "OriginalInstance"
    ObjectValue.Value = Value
    ObjectValue.Parent = Parent2
    local Clone = ObjectValue:Clone( )
    Value:SetAttribute( "HasAClippedClone", true )
    Clone.Name = "ClippedClone"
    Clone.Value = Parent2
    Clone.Parent = Value
    local Value1 = nil
    local IconModule = require( Argument1.iconModule )
    local Container = IconModule.container

    local function UpdateScreenGui()
        local ScreenGui2
        local ScreenGui = Parent:FindFirstAncestorWhichIsA( "ScreenGui" )
        ScreenGui2 = if string.match( ScreenGui.Name, "Clipped" ) then ScreenGui else Container[ ScreenGui.Name .. "Clipped" ]
        Value1 = ScreenGui2
        Value.AnchorPoint = Vector2.new( 0, 0 )
        Value.Parent = Table.getClippedContainer( Value1 )
    end

    Add:add( Argument1.alignmentChanged:Connect( UpdateScreenGui ) )
    UpdateScreenGui( )

    for Key, Value3 in pairs( Value:GetChildren( ) ) do
        if Value3:IsA( "UIAspectRatioConstraint" ) then
            Value3:Clone( ).Parent = Parent2
        end
    end

    local Widget = Argument1.widget
    local Flag = false
    local IgnoreVisibilityUpdater = Value:GetAttribute( "IgnoreVisibilityUpdater" )

    local function UpdateVisibility()
        if IgnoreVisibilityUpdater then
            return
        end

        local Visible = Widget.Visible

        if Flag then
            Visible = false
        end

        Table.setVisible( Value, Visible, "ClipHandler" )
    end

    Add:add( Widget:GetPropertyChangedSignal( "Visible" ):Connect( UpdateVisibility ) )
    local Value4 = nil

    local function CheckIfOutsideParentXBounds()
        task.defer( function()
            local JoinedFrame2
            local UID = Argument1.UID

            if Value:GetAttribute( "ClipToJoinedParent" ) then
                local UID2
                local I = 1
                UID2 = UID
                JoinedFrame2 = nil
                JoinedFrame2 = nil

                for I = 1, 10 do
                    local IconByUID = IconModule.getIconByUID( UID2 )

                    if not IconByUID then
                        break
                    end

                    local JoinedFrame = IconByUID.joinedFrame
                    UID2 = IconByUID.parentIconUID

                    if not JoinedFrame then
                        break
                    end
                    if JoinedFrame and JoinedFrame.Name == "DropdownScroller" then
                        JoinedFrame2 = JoinedFrame
                        break
                    end

                    JoinedFrame2 = JoinedFrame
                    JoinedFrame2 = JoinedFrame
                end
            else
                JoinedFrame2 = nil
            end
            if JoinedFrame2 then
                local FlagInner
                local AbsolutePosition = Value.AbsolutePosition
                local AbsoluteSize = Value.AbsoluteSize / 2
                local AbsolutePosition2 = JoinedFrame2.AbsolutePosition
                local AbsoluteSize2 = JoinedFrame2.AbsoluteSize
                local AbsolutePosition3 = AbsolutePosition + AbsoluteSize
                FlagInner = AbsolutePosition3.X < AbsolutePosition2.X and true or false
                local Flag2
                local X = AbsolutePosition3.X
                Flag2 = AbsolutePosition2.X + AbsoluteSize2.X < X and true or false
                local Flag3 = AbsolutePosition3.Y < AbsolutePosition2.Y and true or false
                local Flag4
                local Y = AbsolutePosition3.Y
                Flag4 = AbsolutePosition2.Y + AbsoluteSize2.Y < Y and true or false
                local Flag5

                if FlagInner then
                    Flag5 = FlagInner
                elseif Flag2 then
                    Flag5 = Flag2
                elseif Flag3 then
                    Flag5 = Flag3
                else
                    Flag5 = Flag4
                end
                if Flag5 ~= Flag then
                    Flag = Flag5

                    if not IgnoreVisibilityUpdater then
                        local Visible2 = Widget.Visible

                        if Flag then
                            Visible2 = false
                        end

                        Table.setVisible( Value, Visible2, "ClipHandler" )
                    end
                end
                if JoinedFrame2:IsA( "ScrollingFrame" ) and Value4 ~= JoinedFrame2 then
                    Value4 = JoinedFrame2
                    local Connect = JoinedFrame2:GetPropertyChangedSignal( "AbsoluteWindowSize" ):Connect( function()
                        CheckIfOutsideParentXBounds( )
                    end )
                    Add:add( Connect, "Disconnect", "TrackUtilityScroller-" .. UID )
                end

                return
            end
            Flag = false

            if IgnoreVisibilityUpdater then
                return
            end

            local Visible = Widget.Visible

            if Flag then
                Visible = false
            end

            Table.setVisible( Value, Visible, "ClipHandler" )
            return
        end )
    end

    local CurrentCamera = workspace.CurrentCamera
    local AdditionalOffsetX = Value:GetAttribute( "AdditionalOffsetX" ) or 0

    local function TrackProperty( PropertyName )
        local Text = "Absolute" .. PropertyName

        local function UpdateProperty()
            local FromOffset3
            local Entry = Parent2[ Text ]
            local FromOffset = UDim2.fromOffset( Entry.X, Entry.Y )

            if PropertyName == "Position" then
                local Number
                local X = CurrentCamera.ViewportSize.X - Value.AbsoluteSize.X - 4
                local Offset = FromOffset.X.Offset

                if Offset < 4 then
                    Number = 4
                elseif X < Offset then
                    Number = X
                else
                    Number = Offset
                end

                local FromOffset2 = UDim2.fromOffset( Number, FromOffset.Y.Offset )
                local TopbarInset = GuiService.TopbarInset
                local X2 = workspace.CurrentCamera.ViewportSize.X
                local X3 = Value1.AbsoluteSize.X
                local X4 = Value1.AbsolutePosition.X

                if not IconModule.isOldTopbar then
                    X4 = X2 - X3 - 0
                end

                FromOffset3 = FromOffset2 + UDim2.fromOffset( -( X4 - AdditionalOffsetX ), TopbarInset.Height )
                task.defer( function()
                    local JoinedFrame2
                    local UID = Argument1.UID

                    if Value:GetAttribute( "ClipToJoinedParent" ) then
                        local UID2
                        local I = 1
                        UID2 = UID
                        JoinedFrame2 = nil
                        JoinedFrame2 = nil

                        for I = 1, 10 do
                            local IconByUID = IconModule.getIconByUID( UID2 )

                            if not IconByUID then
                                break
                            end

                            local JoinedFrame = IconByUID.joinedFrame
                            UID2 = IconByUID.parentIconUID

                            if not JoinedFrame then
                                break
                            end
                            if JoinedFrame and JoinedFrame.Name == "DropdownScroller" then
                                JoinedFrame2 = JoinedFrame
                                break
                            end

                            JoinedFrame2 = JoinedFrame
                            JoinedFrame2 = JoinedFrame
                        end
                    else
                        JoinedFrame2 = nil
                    end
                    if JoinedFrame2 then
                        local FlagInner
                        local AbsolutePosition = Value.AbsolutePosition
                        local AbsoluteSize = Value.AbsoluteSize / 2
                        local AbsolutePosition2 = JoinedFrame2.AbsolutePosition
                        local AbsoluteSize2 = JoinedFrame2.AbsoluteSize
                        local AbsolutePosition3 = AbsolutePosition + AbsoluteSize
                        FlagInner = AbsolutePosition3.X < AbsolutePosition2.X and true or false
                        local Flag2
                        local X = AbsolutePosition3.X
                        Flag2 = AbsolutePosition2.X + AbsoluteSize2.X < X and true or false
                        local Flag3 = AbsolutePosition3.Y < AbsolutePosition2.Y and true or false
                        local Flag4
                        local Y = AbsolutePosition3.Y
                        Flag4 = AbsolutePosition2.Y + AbsoluteSize2.Y < Y and true or false
                        local Flag5

                        if FlagInner then
                            Flag5 = FlagInner
                        elseif Flag2 then
                            Flag5 = Flag2
                        elseif Flag3 then
                            Flag5 = Flag3
                        else
                            Flag5 = Flag4
                        end
                        if Flag5 ~= Flag then
                            Flag = Flag5

                            if not IgnoreVisibilityUpdater then
                                local Visible2 = Widget.Visible

                                if Flag then
                                    Visible2 = false
                                end

                                Table.setVisible( Value, Visible2, "ClipHandler" )
                            end
                        end
                        if JoinedFrame2:IsA( "ScrollingFrame" ) and Value4 ~= JoinedFrame2 then
                            Value4 = JoinedFrame2
                            local Connect = JoinedFrame2:GetPropertyChangedSignal( "AbsoluteWindowSize" ):Connect( function()
                                CheckIfOutsideParentXBounds( )
                            end )
                            Add:add( Connect, "Disconnect", "TrackUtilityScroller-" .. UID )
                        end

                        return
                    end
                    Flag = false

                    if IgnoreVisibilityUpdater then
                        return
                    end

                    local Visible = Widget.Visible

                    if Flag then
                        Visible = false
                    end

                    Table.setVisible( Value, Visible, "ClipHandler" )
                    return
                end )
            else
                FromOffset3 = FromOffset
            end

            Value[ PropertyName ] = FromOffset3
        end

        local Stagger = Table.createStagger( 0.01, UpdateProperty )
        Add:add( Parent2:GetPropertyChangedSignal( Text ):Connect( Stagger ) )
        Add:add( Parent2:GetAttributeChangedSignal( "ForceUpdate" ):Connect( function()
            Stagger( )
        end ) )
        local Stagger2 = Table.createStagger( 0.5, UpdateProperty, true )
        Add:add( Parent2:GetPropertyChangedSignal( Text ):Connect( Stagger2 ) )

        if PropertyName == "Position" then
            Add:add( Value1:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
                Stagger( )
            end ) )
        end
    end

    task.delay( 0.1, CheckIfOutsideParentXBounds )
    task.defer( function()
        local JoinedFrame2
        local UID = Argument1.UID

        if Value:GetAttribute( "ClipToJoinedParent" ) then
            local UID2
            local I = 1
            UID2 = UID
            JoinedFrame2 = nil
            JoinedFrame2 = nil

            for I = 1, 10 do
                local IconByUID = IconModule.getIconByUID( UID2 )

                if not IconByUID then
                    break
                end

                local JoinedFrame = IconByUID.joinedFrame
                UID2 = IconByUID.parentIconUID

                if not JoinedFrame then
                    break
                end
                if JoinedFrame and JoinedFrame.Name == "DropdownScroller" then
                    JoinedFrame2 = JoinedFrame
                    break
                end

                JoinedFrame2 = JoinedFrame
                JoinedFrame2 = JoinedFrame
            end
        else
            JoinedFrame2 = nil
        end
        if JoinedFrame2 then
            local FlagInner
            local AbsolutePosition = Value.AbsolutePosition
            local AbsoluteSize = Value.AbsoluteSize / 2
            local AbsolutePosition2 = JoinedFrame2.AbsolutePosition
            local AbsoluteSize2 = JoinedFrame2.AbsoluteSize
            local AbsolutePosition3 = AbsolutePosition + AbsoluteSize
            FlagInner = AbsolutePosition3.X < AbsolutePosition2.X and true or false
            local Flag2
            local X = AbsolutePosition3.X
            Flag2 = AbsolutePosition2.X + AbsoluteSize2.X < X and true or false
            local Flag3 = AbsolutePosition3.Y < AbsolutePosition2.Y and true or false
            local Flag4
            local Y = AbsolutePosition3.Y
            Flag4 = AbsolutePosition2.Y + AbsoluteSize2.Y < Y and true or false
            local Flag5

            if FlagInner then
                Flag5 = FlagInner
            elseif Flag2 then
                Flag5 = Flag2
            elseif Flag3 then
                Flag5 = Flag3
            else
                Flag5 = Flag4
            end
            if Flag5 ~= Flag then
                Flag = Flag5

                if not IgnoreVisibilityUpdater then
                    local Visible2 = Widget.Visible

                    if Flag then
                        Visible2 = false
                    end

                    Table.setVisible( Value, Visible2, "ClipHandler" )
                end
            end
            if JoinedFrame2:IsA( "ScrollingFrame" ) and Value4 ~= JoinedFrame2 then
                Value4 = JoinedFrame2
                local Connect = JoinedFrame2:GetPropertyChangedSignal( "AbsoluteWindowSize" ):Connect( function()
                    CheckIfOutsideParentXBounds( )
                end )
                Add:add( Connect, "Disconnect", "TrackUtilityScroller-" .. UID )
            end

            return
        end
        Flag = false

        if IgnoreVisibilityUpdater then
            return
        end

        local Visible = Widget.Visible

        if Flag then
            Visible = false
        end

        Table.setVisible( Value, Visible, "ClipHandler" )
        return
    end )

    if not IgnoreVisibilityUpdater then
        local Visible = Widget.Visible

        if Flag then
            Visible = false
        end

        Table.setVisible( Value, Visible, "ClipHandler" )
    end

    TrackProperty( "Position" )
    Add:add( Value:GetPropertyChangedSignal( "Visible" ):Connect( function()
    end ) )

    if Value:GetAttribute( "TrackCloneSize" ) then
        TrackProperty( "Size" )
    else
        Add:add( Value:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
            local AbsoluteSize = Value.AbsoluteSize
            Parent2.Size = UDim2.fromOffset( AbsoluteSize.X, AbsoluteSize.Y )
        end ) )
    end

    return Parent2
end
function Table.joinFeature( Argument1, Argument2, List, JoinedFrame )
    local JoinJanitor = Argument1.joinJanitor
    JoinJanitor:clean( )

    if not JoinedFrame then
        Argument1:leave( )
        return
    end

    local Alignment2
    Argument1.parentIconUID = Argument2.UID
    Argument1.joinedFrame = JoinedFrame

    local function UpdateAlignent()
        local Alignment2
        local Alignment = Argument2.alignment
        Alignment2 = if Alignment == "Center" then "Left" else Alignment
        Argument1:setAlignment( Alignment2, true )
    end

    JoinJanitor:add( Argument2.alignmentChanged:Connect( UpdateAlignent ) )
    local Alignment = Argument2.alignment
    Alignment2 = if Alignment == "Center" then "Left" else Alignment
    Argument1:setAlignment( Alignment2, true )
    Argument1:modifyTheme( { "IconButton", "BackgroundTransparency", 1 }, "JoinModification" )
    Argument1:modifyTheme( { "ClickRegion", "Active", false }, "JoinModification" )

    if Argument2.childModifications then
        task.defer( function()
            Argument1:modifyTheme( Argument2.childModifications, Argument2.childModificationsUID )
        end )
    end

    local GetInstance = Argument1:getInstance( "ClickRegion" )

    local function MakeSelectable()
        GetInstance.Selectable = Argument2.isSelected
    end

    JoinJanitor:add( Argument2.toggled:Connect( MakeSelectable ) )
    task.defer( MakeSelectable )
    JoinJanitor:add( function()
        GetInstance.Selectable = true
    end )
    local UID = Argument1.UID
    table.insert( List, UID )
    Argument2:autoDeselect( false )
    Argument2.childIconsDict[ UID ] = true

    if not Argument2.isEnabled then
        Argument2:setEnabled( true )
    end

    Argument1.joinedParent:Fire( Argument2 )
    JoinJanitor:add( function()
        if not Argument1.joinedFrame then
            return
        end
        for Key, Value in pairs( List ) do
            if Value == UID then
                table.remove( List, Key )
                break
            end
        end

        local IconByUID = require( Argument1.iconModule ).getIconByUID( Argument1.parentIconUID )

        if not IconByUID then
            return
        end

        Argument1:setAlignment( Argument1.originalAlignment )
        Argument1.parentIconUID = false
        Argument1.joinedFrame = false
        Argument1:removeModification( "JoinModification" )
        local ChildIconsDict = IconByUID.childIconsDict
        ChildIconsDict[ UID ] = nil
        local Value2, Value3, Value4 = pairs( ChildIconsDict )
        local Flag
        local Value5 = Value2( Value3, Value4 )
        Flag = if Value5 == nil then true else false

        if Flag and not IconByUID.isAnOverflow then
            IconByUID:setEnabled( false )
        end

        local Alignment2
        local Alignment = Argument2.alignment
        Alignment2 = if Alignment == "Center" then "Left" else Alignment
        Argument1:setAlignment( Alignment2, true )
    end )
end
return Table
