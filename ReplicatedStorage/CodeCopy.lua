-- ReplicatedStorage.CodeCopy
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserInputService = game:GetService( "UserInputService" )
local GuiService = game:GetService( "GuiService" )
local KeyCode = Enum.KeyCode
local Table2 = {
    KeyCode.LeftControl,
    KeyCode.RightControl,
    KeyCode.LeftMeta,
    KeyCode.RightMeta,
    KeyCode.LeftSuper,
    KeyCode.RightSuper
}

local function Device()
    if GuiService:IsTenFootInterface( ) then
        return "console"
    end
    if not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled then
        return "keyboard"
    end
    return "touch"
end

local Value1 = nil
UserInputService.InputBegan:Connect( function( Argument1 )
    if not Value1 or Argument1.KeyCode ~= KeyCode.C then
        return
    end
    if not Value1.box:IsFocused( ) then
        Value1 = nil
        return
    end

    local Value1Inner = nil

    for Key, Value in Table2, nil, nil do
        if UserInputService:IsKeyDown( Value ) then
            Value1 = nil
            task.spawn( Value1.fn )
            return
        end
    end
end )
local Table = {
    Hint = function()
        local Text

        if GuiService:IsTenFootInterface( ) then
            Text = "console"
        elseif not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled then
            Text = "keyboard"
        else
            Text = "touch"
        end
        if Text == "console" then
            return "Write the code down to share it"
        end
        if Text == "touch" then
            return "COPY selects the code, then tap Copy"
        end
        return "COPY selects the code, then press Ctrl+C"
    end,
    Select = function( Argument1, Fn )
        local Text = Argument1.Text

        if Text == "" then
            return nil
        end

        local Text2

        if GuiService:IsTenFootInterface( ) then
            Text2 = "console"
        elseif not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled then
            Text2 = "keyboard"
        else
            Text2 = "touch"
        end
        if Text2 == "console" then
            return "Consoles can't copy: write the code down"
        end

        Argument1:CaptureFocus( )
        Argument1.SelectionStart = 1
        Argument1.CursorPosition = #Text + 1
        local Table = { box = Argument1 }
        Table.fn = Fn or function()
        end
        Value1 = Table

        if Text2 == "touch" then
            return "Selected: tap Copy"
        end
        return "Selected: press Ctrl+C"
    end
}
return Table
