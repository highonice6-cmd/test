-- StarterPlayer.StarterPlayerScripts.GiveUpClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #8

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if os.clock( ) - Upvalue1 < 2 then
    return false
end

local Humanoid
local Character = Upvalue2.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end
if not Humanoid or not ( Humanoid.Health > 0 ) or Character:GetAttribute( "Downed" ) ~= true then
    return false
end

local Flag
local DownedAt = Character:GetAttribute( "DownedAt" )

if type( DownedAt ) == "number" then
    if workspace:GetServerTimeNow( ) - DownedAt >= 1 then
        Flag = true
    else
        Flag = false
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or os.clock( ) - Upvalue2 < 2 then
    return
end
Upvalue2 = os.clock( )
Upvalue3 = nil
Upvalue4 = nil
Upvalue5:FireServer( )
return
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsGamepad then
    return "pad"
end
if Upvalue2:GetLastInputType( ) ~= Enum.UserInputType.Touch then
    if not Upvalue2.TouchEnabled or Upvalue2.KeyboardEnabled then
        return "kbm"
    end
end

return "touch"
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Argument1.KeyCode ]

if not Entry or not Upvalue2 then
    return
end
if Entry == "kbm" then
    if Argument2 or Upvalue3:GetFocusedTextBox( ) then
        return
    end
end
if Entry ~= "pad" or Upvalue4:GetAttribute( "NavTop" ) == nil then
    local Clock = os.clock( )
    local KeyCode = Argument1.KeyCode
    Upvalue5 = Clock
    Upvalue6 = KeyCode
    return
end
return
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.KeyCode == Upvalue1 then
    Upvalue2 = nil
    Upvalue1 = nil
end
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Visible = Upvalue2( )

if Visible ~= Upvalue3 then
    Upvalue3 = Visible
    Upvalue1.Visible = Visible
    Upvalue4 = nil
    Upvalue5 = nil
    Upvalue6.Size = UDim2.fromScale( 0, 1 )
    Upvalue7 = nil
end
if not Upvalue3 then
    return
end

local Text

if Upvalue8.IsGamepad then
    Text = "pad"
elseif Upvalue9:GetLastInputType( ) == Enum.UserInputType.Touch then
    Text = "touch"
elseif not Upvalue9.TouchEnabled or Upvalue9.KeyboardEnabled then
    Text = "kbm"
else
    Text = "touch"
end
if Text ~= Upvalue7 then
    local Visible2
    Upvalue7 = Text
    Visible2 = Text ~= "touch" and true or false
    Upvalue10.Visible = Visible2

    if Text == "pad" then
        local Visible3
        local Glyph, Glyph2 = Upvalue8.Glyph( Enum.KeyCode.ButtonX )
        Upvalue11.Image = Glyph or ""
        Visible3 = Glyph ~= nil and true or false
        local Visible4
        Upvalue11.Visible = Visible3
        Upvalue12.Text = Glyph2 or "X"
        Visible4 = Glyph == nil and true or false
        Upvalue12.Visible = Visible4
    else
        Upvalue11.Visible = false
        Upvalue12.Visible = true
        Upvalue12.Text = "X"
    end

    local Text2 = Text ~= "touch" and "Hold to respawn" or "Tap to respawn"
    Upvalue13.Text = Text2
end
if Upvalue4 then
    local IsGamepadButtonDown

    if Upvalue5 then
        local IsKeyDown = Upvalue9:IsKeyDown( Upvalue5 )

        if IsKeyDown then
            IsGamepadButtonDown = IsKeyDown
        else
            IsGamepadButtonDown = Upvalue9:IsGamepadButtonDown( Enum.UserInputType.Gamepad1, Upvalue5 )
        end
    else
        IsGamepadButtonDown = Upvalue5
    end
    if not IsGamepadButtonDown then
        Upvalue4 = nil
        Upvalue5 = nil
        Upvalue6.Size = UDim2.fromScale( 0, 1 )
        return
    end

    local Clock = ( os.clock( ) - Upvalue4 ) / 1
    Upvalue6.Size = UDim2.fromScale( math.clamp( Clock, 0, 1 ), 1 )

    if Clock >= 1 and Upvalue3 then
        if os.clock( ) - Upvalue14 < 2 then
            return
        end
        Upvalue14 = os.clock( )
        Upvalue4 = nil
        Upvalue5 = nil
        Upvalue15:FireServer( )
        return
    end
elseif Upvalue6.Size.X.Scale ~= 0 then
    Upvalue6.Size = UDim2.fromScale( 0, 1 )
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Upvalue1 then
    if os.clock( ) - Upvalue2 < 2 then
        return
    end

    Upvalue2 = os.clock( )
    Upvalue3 = nil
    Upvalue4 = nil
    Upvalue5:FireServer( )
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Holder = Upvalue1:WaitForChild( "PlayerGui" ):WaitForChild( "GiveUp", math.huge ):WaitForChild( "Holder" )
Upvalue2 = Holder:WaitForChild( "Button" )
Upvalue3 = Upvalue2:WaitForChild( "Fill" )
Upvalue4 = Upvalue2:WaitForChild( "Key" )
Upvalue5 = Upvalue4:WaitForChild( "Letter" )
Upvalue6 = Upvalue4:WaitForChild( "Glyph" )
Upvalue7 = Upvalue2:WaitForChild( "Sub" )
Holder.Visible = false
Upvalue2.Activated:Connect( function()
    if Upvalue8 and Upvalue8 then
        if os.clock( ) - Upvalue9 < 2 then
            return
        end

        Upvalue9 = os.clock( )
        Upvalue10 = nil
        Upvalue11 = nil
        Upvalue12:FireServer( )
    end
end )
Upvalue13 = Holder
]]
