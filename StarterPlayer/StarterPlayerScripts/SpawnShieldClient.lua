-- StarterPlayer.StarterPlayerScripts.SpawnShieldClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #6

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Character = Upvalue1.Character

if Character == nil then
    Flag = false
elseif Character:GetAttribute( Upvalue2.ATTR ) == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Flag
    local Character = Upvalue2.Character

    if Character == nil then
        Flag = false
    elseif Character:GetAttribute( Upvalue3.ATTR ) == true then
        Flag = true
    else
        Flag = false
    end
    if Flag then
        local Clock = os.clock( )

        if Clock - Upvalue4 < 0.5 then
            return
        end
        Upvalue4 = Clock
        Upvalue1:FireServer( )
        return
    end
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local UserInputType = Argument1.UserInputType

if Upvalue1[ UserInputType ] then
    return
end
if UserInputType == Upvalue2.Touch then
    if Argument2 and Upvalue3 then
        local Flag
        local Character = Upvalue4.Character

        if Character == nil then
            Flag = false
        elseif Character:GetAttribute( Upvalue5.ATTR ) == true then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            return
        end

        local Clock = os.clock( )

        if Clock - Upvalue6 < 0.5 then
            return
        end

        Upvalue6 = Clock
        Upvalue3:FireServer( )
    end

    return
end
if Argument1.KeyCode == Upvalue7.Thumbstick2 then
    return
end
if Argument1.KeyCode == Upvalue7.Thumbstick1 and Argument1.Position.Magnitude <= 0.25 then
    return
end
if Upvalue3 then
    local Flag2
    local Character2 = Upvalue4.Character

    if Character2 == nil then
        Flag2 = false
    elseif Character2:GetAttribute( Upvalue5.ATTR ) == true then
        Flag2 = true
    else
        Flag2 = false
    end
    if not Flag2 then
        return
    end

    local Clock2 = os.clock( )

    if Clock2 - Upvalue6 < 0.5 then
        return
    end

    Upvalue6 = Clock2
    Upvalue3:FireServer( )
end

return
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Upvalue1.MouseWheel then
    if Upvalue2 then
        local Flag
        local Character = Upvalue3.Character

        if Character == nil then
            Flag = false
        elseif Character:GetAttribute( Upvalue4.ATTR ) == true then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            return
        end

        local Clock = os.clock( )

        if Clock - Upvalue5 < 0.5 then
            return
        end

        Upvalue5 = Clock
        Upvalue2:FireServer( )
    end

    return
end
if Argument1.KeyCode == Upvalue6.Thumbstick1 and Argument1.Position.Magnitude > 0.25 and Upvalue2 then
    local Flag2
    local Character2 = Upvalue3.Character

    if Character2 == nil then
        Flag2 = false
    elseif Character2:GetAttribute( Upvalue4.ATTR ) == true then
        Flag2 = true
    else
        Flag2 = false
    end
    if not Flag2 then
        return
    end

    local Clock2 = os.clock( )

    if Clock2 - Upvalue5 < 0.5 then
        return
    end

    Upvalue5 = Clock2
    Upvalue2:FireServer( )
end

return
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 and Upvalue1 then
    local Flag
    local Character = Upvalue2.Character

    if Character == nil then
        Flag = false
    elseif Character:GetAttribute( Upvalue3.ATTR ) == true then
        Flag = true
    else
        Flag = false
    end
    if not Flag then
        return
    end

    local Clock = os.clock( )

    if Clock - Upvalue4 < 0.5 then
        return
    end

    Upvalue4 = Clock
    Upvalue1:FireServer( )
end
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Character = Upvalue1.Character

if Character == nil then
    Flag = false
elseif Character:GetAttribute( Upvalue2.ATTR ) == true then
    Flag = true
else
    Flag = false
end
if not Flag then
    return
end

local Humanoid = Upvalue1.Character:FindFirstChildOfClass( "Humanoid" )

if Humanoid and Humanoid.MoveDirection.Magnitude > 0.05 and Upvalue3 then
    local Flag2
    local Character2 = Upvalue1.Character

    if Character2 == nil then
        Flag2 = false
    elseif Character2:GetAttribute( Upvalue2.ATTR ) == true then
        Flag2 = true
    else
        Flag2 = false
    end
    if not Flag2 then
        return
    end

    local Clock = os.clock( )

    if Clock - Upvalue4 < 0.5 then
        return
    end

    Upvalue4 = Clock
    Upvalue3:FireServer( )
end
]]
