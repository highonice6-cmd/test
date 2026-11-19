-- StarterPlayer.StarterPlayerScripts.AltHintClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Hint2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local GuiService = game:GetService( "GuiService" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local AltHint = Players.LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "AltHint", math.huge )

local function KeyboardMouseDevice()
    local KeyboardEnabled2
    local KeyboardEnabled = UserInputService.KeyboardEnabled

    if KeyboardEnabled then
        local MouseEnabled = UserInputService.MouseEnabled

        if MouseEnabled then
            KeyboardEnabled2 = not GuiService:IsTenFootInterface( )
        else
            KeyboardEnabled2 = MouseEnabled
        end
    else
        KeyboardEnabled2 = KeyboardEnabled
    end

    return KeyboardEnabled2
end

local Hint = AltHint:FindFirstChild( "Hint", true )
Hint2 = if Hint then Hint.Text else Hint
local Flag = false

local function ShowKey()
    local FlagInner
    local Binds = Controls.Binds( "kbm", "CursorMode" )
    FlagInner = Binds[ 1 ] == nil and true or false
    Flag = FlagInner

    if not Hint or not Hint2 then
        return
    end
    if Controls.IsDefaultBind( "kbm", "CursorMode" ) or Flag then
        Hint.Text = Hint2
        return
    end
    Hint.Text = Hint2:gsub( "ALT", Controls.KeyName( Binds[ 1 ] ):upper( ):gsub( "%%", "%%%%" ), 1 )
    return
end

Controls.BindsChanged:Connect( ShowKey )
ShowKey( )

while true do
    local Enabled
    local KeyboardEnabled = UserInputService.KeyboardEnabled

    if KeyboardEnabled then
        local MouseEnabled = UserInputService.MouseEnabled

        if MouseEnabled then
            Enabled = not GuiService:IsTenFootInterface( )
        else
            Enabled = MouseEnabled
        end
    else
        Enabled = KeyboardEnabled
    end
    if Enabled then
        local NotIsGamepad = not Controls.IsGamepad

        if NotIsGamepad then
            local NotTouchMode = not Controls.TouchMode( )

            if NotTouchMode then
                if ClientState.WardrobeOpen == true then
                    Enabled = false
                else
                    Enabled = not Flag
                end
            else
                Enabled = NotTouchMode
            end
        else
            Enabled = NotIsGamepad
        end
    end
    if AltHint.Enabled ~= Enabled then
        AltHint.Enabled = Enabled
    end

    task.wait( 0.5 )
end
