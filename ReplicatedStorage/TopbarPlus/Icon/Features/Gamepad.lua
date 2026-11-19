-- ReplicatedStorage.TopbarPlus.Icon.Features.Gamepad
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local GamepadService = game:GetService( "GamepadService" )
local UserInputService = game:GetService( "UserInputService" )
local GuiService = game:GetService( "GuiService" )
local DPadUp = Enum.KeyCode.DPadUp
local Gamepad = Enum.PreferredInput.Gamepad
local Table = { }
local Value1 = nil
function Table.start( Argument1 )
    local HighlightKey
    Value1 = Argument1

    if Value1.highlightKey == nil then
        HighlightKey = DPadUp
    else
        HighlightKey = Value1.highlightKey
    end

    Value1.highlightKey = HighlightKey
    Value1.highlightIcon = false
    task.delay( 1, function()
        local Flag2
        local IconsDictionary = Value1.iconsDictionary

        local function GetIconFromSelectedObject()
            local CorrespondingIconUID
            local SelectedObject = GuiService.SelectedObject

            if SelectedObject then
                CorrespondingIconUID = SelectedObject:GetAttribute( "CorrespondingIconUID" )
            else
                CorrespondingIconUID = SelectedObject
            end

            local SelectedObject2 = if CorrespondingIconUID then IconsDictionary[ CorrespondingIconUID ] else CorrespondingIconUID
            return SelectedObject2
        end

        local Value1Inner = nil

        if DPadUp == Value1.highlightKey then
            Flag2 = false
        else
            Flag2 = true
        end

        local Flag

        if DPadUp == Value1.highlightKey then
            Flag = false
        else
            Flag = true
        end

        local Flag3
        local Selection = require( script.Parent.Parent.Elements.Selection )

        local function UpdateSelectedObject()
            local CorrespondingIconUID
            local SelectedObject = GuiService.SelectedObject

            if SelectedObject then
                CorrespondingIconUID = SelectedObject:GetAttribute( "CorrespondingIconUID" )
            else
                CorrespondingIconUID = SelectedObject
            end

            local LastHighlightedIcon = if CorrespondingIconUID then IconsDictionary[ CorrespondingIconUID ] else CorrespondingIconUID
            local FlagInner = UserInputService.PreferredInput == Gamepad and true or false

            if LastHighlightedIcon then
                if FlagInner then
                    local Selection3
                    local GetInstance = LastHighlightedIcon:getInstance( "ClickRegion" )
                    local SelectionInner = LastHighlightedIcon.selection

                    if SelectionInner then
                        Selection3 = SelectionInner
                    else
                        local Selection2 = LastHighlightedIcon.janitor:add( Selection( Value1 ) )
                        Selection2:SetAttribute( "IgnoreVisibilityUpdater", true )
                        Selection2.Parent = LastHighlightedIcon.widget
                        LastHighlightedIcon.selection = Selection2
                        LastHighlightedIcon:refreshAppearance( Selection2 )
                        Selection3 = Selection2
                    end

                    GetInstance.SelectionImageObject = Selection3.Selection
                end
                if Value1Inner and Value1Inner ~= LastHighlightedIcon then
                    Value1Inner:setIndicator( )
                end

                local ButtonB = if not FlagInner or Flag or LastHighlightedIcon.parentIconUID then nil else Enum.KeyCode.ButtonB
                Value1Inner = LastHighlightedIcon
                Value1.lastHighlightedIcon = LastHighlightedIcon
                LastHighlightedIcon:setIndicator( ButtonB )
                return
            end
            local HighlightKey

            if not FlagInner or Flag2 then
                HighlightKey = nil
            else
                HighlightKey = Value1.highlightKey
            end
            if not Value1Inner then
                Value1Inner = Table.getIconToHighlight( )
            end
            if HighlightKey == Value1.highlightKey then
                Flag2 = true
            end
            if Value1Inner then
                Value1Inner:setIndicator( HighlightKey )
            end

            return
        end

        GuiService:GetPropertyChangedSignal( "SelectedObject" ):Connect( UpdateSelectedObject )

        local function PreferredInputChanged()
            local FlagInner = UserInputService.PreferredInput == Gamepad and true or false

            if not FlagInner then
                Flag2 = false
                Flag = false
            end

            UpdateSelectedObject( )
        end

        UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( PreferredInputChanged )
        Flag3 = UserInputService.PreferredInput == Gamepad and true or false

        if not Flag3 then
            Flag2 = false
            Flag = false
        end

        UpdateSelectedObject( )
        UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
            if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
                local CorrespondingIconUID
                local SelectedObject = GuiService.SelectedObject

                if SelectedObject then
                    CorrespondingIconUID = SelectedObject:GetAttribute( "CorrespondingIconUID" )
                else
                    CorrespondingIconUID = SelectedObject
                end

                local SelectedObject2 = if CorrespondingIconUID then IconsDictionary[ CorrespondingIconUID ] else CorrespondingIconUID

                if SelectedObject2 then
                    GuiService.SelectedObject = nil
                end

                return
            end
            if Argument1.KeyCode ~= Value1.highlightKey then
                return
            end

            local IconToHighlight = Table.getIconToHighlight( )

            if IconToHighlight then
                if GamepadService.GamepadCursorEnabled then
                    task.wait( 0.2 )
                    GamepadService:DisableGamepadCursor( )
                end

                GuiService.SelectedObject = IconToHighlight:getInstance( "ClickRegion" )
            end

            return
        end )
    end )
end
function Table.getIconToHighlight()
    local HighlightIcon2
    local IconsDictionary = Value1.iconsDictionary
    local HighlightIcon = Value1.highlightIcon

    if HighlightIcon then
        HighlightIcon2 = HighlightIcon
    else
        HighlightIcon2 = Value1.lastHighlightedIcon
    end
    if not HighlightIcon2 then
        local X2 = nil

        for Key, Value in pairs( IconsDictionary ) do
            if not Value.parentIconUID then
                local X = Value.widget.AbsolutePosition.X

                if not X2 or X < X2 then
                    X2 = Value.widget.AbsolutePosition.X
                    HighlightIcon2 = Value
                end
            end
        end
    end

    return HighlightIcon2
end
function Table.registerButton( Button )
    local Flag = false
    Button.InputBegan:Connect( function( Argument1 )
        Flag = true
        task.wait( )
        task.wait( )
        Flag = false
    end )
    local Connect = UserInputService.InputBegan:Connect( function( Argument1 )
        task.wait( )

        if Argument1.KeyCode == Enum.KeyCode.ButtonA and Flag and not game:GetService( "Players" ).LocalPlayer:GetAttribute( "NavCursor" ) then
            task.wait( 0.2 )
            GamepadService:DisableGamepadCursor( )
            GuiService.SelectedObject = Button
            return
        end

        local FlagInner = GuiService.SelectedObject == Button and true or false
        local Table = { "ButtonB", "ButtonSelect" }
        local Name = Argument1.KeyCode.Name

        if table.find( Table, Name ) and FlagInner then
            if Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled then
                GuiService.SelectedObject = nil
            end
        end
    end )
    Button.Destroying:Once( function()
        Connect:Disconnect( )
    end )
end
return Table
