-- Players.perkbrokeyou.PlayerScripts.GamepadClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #2

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if not workspace:GetAttribute( "RankedMatch" ) then
    return false
end
if not Upvalue1 then
    local RankedShared2
    local RankedShared = Upvalue2:FindFirstChild( "RankedShared" )
    RankedShared2 = if RankedShared then RankedShared:FindFirstChild( "MatchState" ) else RankedShared
    Upvalue1 = RankedShared2
end
if ( Upvalue1 and Upvalue1:GetAttribute( "Phase" ) ) ~= "fight" then
    return false
end

local Humanoid
local Character = Upvalue3.LocalPlayer.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local Flag

if Humanoid == nil then
    Flag = false
elseif Humanoid.Health > 0 then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local CursorFree2
local CursorFree = Upvalue1.CursorFree

if CursorFree then
    local IsGamepad = Upvalue2.IsGamepad

    if IsGamepad then
        local NotGamepadNav = not Upvalue1.GamepadNav

        if NotGamepadNav then
            CursorFree2 = not Upvalue3( )
        else
            CursorFree2 = NotGamepadNav
        end
    else
        CursorFree2 = IsGamepad
    end
else
    CursorFree2 = CursorFree
end
if Upvalue4 and CursorFree2 and not Upvalue5.GamepadCursorEnabled then
    Upvalue4 = false
end
if CursorFree2 ~= Upvalue4 then
    Upvalue4 = CursorFree2

    if CursorFree2 then
        pcall( Upvalue5.EnableGamepadCursor, Upvalue5, nil )
        return
    end

    pcall( Upvalue5.DisableGamepadCursor, Upvalue5 )
end
]]
