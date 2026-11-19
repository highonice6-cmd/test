-- ReplicatedStorage.TopbarPlus.Icon.Features.Overflow
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { }
local Table2 = { }
local Table3 = { }
local Value1 = nil
local CurrentCamera = workspace.CurrentCamera
local Table4 = { }
local Table5 = { }
local Utility = require( script.Parent.Parent.Utility )
local Flag = false
local Flag2 = false
local Value2 = nil
function Table.start( Argument1 )
    local Value2Inner
    Value2 = Argument1
    Value1 = Value2.iconsDictionary
    Value2Inner = nil

    for Key, Value in pairs( Value2.container ) do
        if Value2Inner == nil and Value.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
            Value2Inner = Value
        end
        for Key2, Value4 in pairs( Value.Holders:GetChildren( ) ) do
            if Value4:GetAttribute( "IsAHolder" ) then
                Table2[ Value4.Name ] = Value4
            end
        end
    end

    local FlagInner = false
    local Stagger = Utility.createStagger( 0.1, function( Argument1 )
        if not FlagInner then
            return
        end
        if not Argument1 then
            Table.updateAvailableIcons( "Center" )
        end

        Table.updateBoundary( "Left" )
        Table.updateBoundary( "Right" )
    end )
    task.delay( 0.5, function()
        FlagInner = true
        Stagger( )
    end )
    task.delay( 2, function()
        Flag = true
        Stagger( )
    end )
    Value2.iconAdded:Connect( Stagger )
    Value2.iconRemoved:Connect( Stagger )
    Value2.iconChanged:Connect( Stagger )
    CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( function()
        Stagger( true )
    end )
    Value2Inner:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
        Stagger( true )
    end )
end
function Table.getWidth( Argument1, Argument2 )
    local TargetWidth2
    local Widget = Argument1.widget
    local TargetWidth = Widget:GetAttribute( "TargetWidth" )
    TargetWidth2 = if TargetWidth then TargetWidth else Widget.AbsoluteSize.X
    return TargetWidth2
end
function Table.getAvailableIcons( Key )
    local Entry2
    local Entry = Table3[ Key ]
    Entry2 = if Entry then Entry else Table.updateAvailableIcons( Key )
    return Entry2
end
function Table.updateAvailableIcons( IconsName )
    local Number
    local Table = { }
    Number = 0

    for Key, Value in pairs( Value1 ) do
        local NotParentIconUID2
        local ParentIconUID = Value.parentIconUID
        local NotParentIconUID = not ParentIconUID
        NotParentIconUID2 = if NotParentIconUID then NotParentIconUID else Table5[ ParentIconUID ]
        local Entry = Table5[ Value.UID ]

        if NotParentIconUID2 and Value.alignment == IconsName and not Entry and Value.isEnabled then
            table.insert( Table, Value )
            Number = Number + 1
        end
    end
    if Number <= 0 then
        return { }
    end
    table.sort( Table, function( Argument1, Argument2 )
        local LayoutOrder = Argument1.widget.LayoutOrder
        local LayoutOrder2 = Argument2.widget.LayoutOrder
        local ParentIconUID = Argument1.parentIconUID
        local ParentIconUID2 = Argument2.parentIconUID

        if ParentIconUID == ParentIconUID2 then
            if LayoutOrder < LayoutOrder2 then
                return true
            end
            if LayoutOrder2 < LayoutOrder then
                return false
            end

            local Flag = Argument1.widget.AbsolutePosition.X < Argument2.widget.AbsolutePosition.X and true or false
            return Flag
        end
        if ParentIconUID2 then
            return false
        end
        if ParentIconUID then
            return true
        end
        return nil
    end )
    Table3[ IconsName ] = Table
    return Table
end
function Table.getRealXPositions( Name, List )
    local Flag = Name == "Left" and true or false
    local X3
    local Entry = Table2[ Name ]
    local X = Entry.AbsolutePosition.X
    local X2 = Entry.AbsoluteSize.X
    local Offset = Entry.UIListLayout.Padding.Offset

    if not Flag or not X then
        X3 = X + X2
    else
        X3 = X
    end

    local TableInner = { }

    if Flag then
        Utility.reverseTable( List )
    end

    local Count = #List
    local I = Count

    for I = Count, 1, -1 do
        local Entry2 = List[ I ]
        local Width = Table.getWidth( Entry2 )

        if not Flag then
            X3 = X3 - Width
        end

        TableInner[ Entry2.UID ] = X3

        if Flag then
            X3 = X3 + Width
        end

        local Offset2 = Flag and Offset or -Offset
        X3 = X3 + Offset2
    end

    return TableInner
end
function Table.updateBoundary( BoundaryName )
    local Number, Number4
    local Entry = Table2[ BoundaryName ]
    local UIListLayout = Entry.UIListLayout
    local X = Entry.AbsolutePosition.X
    local X2 = Entry.AbsoluteSize.X
    local Offset = UIListLayout.Padding.Offset
    local Offset2 = UIListLayout.Padding.Offset
    local AvailableIcons = Table.updateAvailableIcons( BoundaryName )
    Number = 0
    Number4 = 0

    for Key, Value in pairs( AvailableIcons ) do
        Number = Number + 1
        Number4 = Number4 + ( Table.getWidth( Value ) + Offset2 )
    end
    if Number <= 0 then
        return
    end

    local Flag2Inner = BoundaryName == "Center" and true or false
    local FlagInner = BoundaryName == "Left" and true or false
    local Entry6
    local NotFlag = not FlagInner
    local Entry2 = Table4[ BoundaryName ]

    if Entry2 or Flag2Inner or not ( #AvailableIcons > 0 ) then
        Entry6 = Entry2
    else
        local Number2 = not FlagInner and 9999999 or -9999999
        local New = Value2.new( )
        New:setImage( 6069276526, "Deselected" )
        New:setName( "Overflow" .. BoundaryName )
        New:setOrder( Number2 )
        New:setAlignment( BoundaryName )
        New:autoDeselect( false )
        New.isAnOverflow = true
        New:select( "OverflowStart", New )
        New:setEnabled( false )
        Table4[ BoundaryName ] = New
        Table5[ New.UID ] = true

        if Value2.closeableOverflowMenus then
            Entry6 = New
        else
            New:getInstance( "IconSpot" ).Visible = false
            Entry6 = New
        end
    end

    local Text = BoundaryName ~= "Left" and "Left" or "Right"
    local Item
    local AvailableIcons2 = Table.updateAvailableIcons( Text )

    if not FlagInner or not AvailableIcons2[ 1 ] then
        if NotFlag then
            Item = AvailableIcons2[ #AvailableIcons2 ]
        else
            Item = NotFlag
        end
    else
        Item = AvailableIcons2[ 1 ]
    end

    local X3
    local Entry3 = Table4[ Text ]

    if not FlagInner or not ( X + X2 ) then
        X3 = X
    else
        X3 = X + X2
    end
    if Item then
        local Entry5
        local Entry4 = Table.getRealXPositions( Text, AvailableIcons2 )[ Item.UID ]
        local Width = Table.getWidth( Item )
        Entry5 = FlagInner and Entry4 - Offset or Entry4 + Width + Offset
        X3 = Entry5
    end

    local Number3 = 0

    local function CheckToShiftCentralIcon()
        local Number
        local AvailableIconsInner = Table.getAvailableIcons( "Center" )
        Number = if FlagInner then 1 else #AvailableIconsInner
        local Entry = AvailableIconsInner[ Number ]

        local function SecondaryCheck()
            if not Flag2 then
                Flag2 = true
                task.delay( 3, Table.updateBoundary, BoundaryName )
            end
        end

        if Entry and not Entry.hasRelocatedInOverflow then
            local Entry3

            if FlagInner then
                local Entry2 = AvailableIcons[ #AvailableIcons ]

                if Entry2 then
                    Entry3 = Entry2
                elseif NotFlag then
                    Entry3 = AvailableIcons[ 1 ]
                else
                    Entry3 = NotFlag
                end
            elseif NotFlag then
                Entry3 = AvailableIcons[ 1 ]
            else
                Entry3 = NotFlag
            end

            local X4
            local X = Entry.widget.AbsolutePosition.X
            local X2 = Entry3.widget.AbsolutePosition.X
            local Width = Table.getWidth( Entry3 )

            if FlagInner then
                local X3 = X - Offset

                if X3 then
                    X4 = X3
                else
                    X4 = X + Table.getWidth( Entry ) + Offset
                end
            else
                X4 = X + Table.getWidth( Entry ) + Offset
            end

            local X5 = FlagInner and X2 + Width or X2
            local FlagInner2

            if FlagInner then
                if X4 < X5 then
                    if not Flag then
                        if not Flag2 then
                            Flag2 = true
                            task.delay( 3, Table.updateBoundary, BoundaryName )
                        end

                        return
                    end
                    Entry:align( "Left" )
                    Entry.hasRelocatedInOverflow = true
                    FlagInner2 = true
                else
                    FlagInner2 = false
                end
            elseif not NotFlag or not ( X5 < X4 ) then
                FlagInner2 = false
            elseif not Flag or X5 < 0 then
                if not Flag2 then
                    Flag2 = true
                    task.delay( 3, Table.updateBoundary, BoundaryName )
                end

                return
            else
                Entry:align( "Right" )
                Entry.hasRelocatedInOverflow = true
                FlagInner2 = true
            end
            if FlagInner2 then
                Number3 = Number3 + 1

                if Number3 <= 4 then
                    Table.updateAvailableIcons( "Center" )
                    CheckToShiftCentralIcon( )
                end
            end
        end
    end

    CheckToShiftCentralIcon( )

    if Entry6 then
        local X13
        local GetInstance = Entry6:getInstance( "Menu" )
        local X4 = X + X2

        if not GetInstance or not Entry3 then
            X13 = X2
        else
            local X10
            local X5 = Entry3.widget.AbsolutePosition.X
            local Width2 = Table.getWidth( Entry3 )
            X10 = FlagInner and X5 - Offset or X5 + Width2 + Offset
            local Flag3
            local GetInstance2 = Entry3:getInstance( "Menu" )
            local X6 = GetInstance.AbsoluteCanvasSize.X
            Flag3 = GetInstance2.AbsoluteCanvasSize.X <= X6 and true or false
            local X9
            local X7 = X + X2 / 2

            if FlagInner then
                local X8 = X7 - Offset / 2

                if X8 then
                    X9 = X8
                else
                    X9 = X7 + Offset / 2
                end
            else
                X9 = X7 + Offset / 2
            end

            local X11 = if Flag3 then X10 else X9
            local X12 = FlagInner and X11 - X or X4 - X11
            X13 = X12
        end

        local GetInstance3 = if GetInstance then GetInstance:GetAttribute( "MaxWidth" ) else GetInstance
        local Round = Utility.round( X13 )

        if GetInstance and GetInstance3 ~= Round then
            GetInstance:SetAttribute( "MaxWidth", Round )
        end
    end

    local Flag4
    local RealXPositions = Table.getRealXPositions( BoundaryName, AvailableIcons )
    local Count = #AvailableIcons
    local I = Count
    Flag4 = false

    for I = Count, 1, -1 do
        local Entry7 = AvailableIcons[ I ]
        local Width3 = Table.getWidth( Entry7 )
        local Entry8 = RealXPositions[ Entry7.UID ]

        if not FlagInner or not ( X3 <= Entry8 + Width3 ) then
            if NotFlag and Entry8 <= X3 then
                Flag4 = true
            end
        else
            Flag4 = true
        end
    end

    local Count2 = #AvailableIcons
    local I2 = Count2

    for I2 = Count2, 1, -1 do
        local Entry9 = AvailableIcons[ I2 ]

        if not Table5[ Entry9.UID ] then
            if not Flag4 or Entry9.parentIconUID then
                if not Flag4 and Entry9.parentIconUID then
                    Entry9:leave( )
                end
            else
                Entry9:joinMenu( Entry6 )
            end
        end
    end
    if Entry6.isEnabled ~= Flag4 then
        Entry6:setEnabled( Flag4 )
    end
    if Entry6.isEnabled and not Entry6.overflowAlreadyOpened then
        Entry6.overflowAlreadyOpened = true
        Entry6:select( )
    end
end
return Table
