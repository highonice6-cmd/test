-- Players.perkbrokeyou.PlayerScripts.BreathingClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #1

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Stamina = Upvalue1.Stamina or 150
local Character = Upvalue2.Character

if Character then
    Humanoid = Upvalue2.Character:FindFirstChildOfClass( "Humanoid" )
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
if Flag then
    if Stamina < 40 then
        Upvalue3 = true
    elseif Stamina > 44 then
        Upvalue3 = false
    end
else
    Upvalue3 = false
end
if Upvalue3 then
    if not Upvalue4.IsPlaying then
        Upvalue4.TimePosition = 0
        Upvalue4:Play( )
    end

    Upvalue4.Volume = math.min( Upvalue4.Volume + 0.05333333333333334 * Amount, 0.08 )
    return
end
if Upvalue4.IsPlaying then
    Upvalue4.Volume = math.max( Upvalue4.Volume - 0.04 * Amount, 0 )

    if Upvalue4.Volume <= 0 then
        Upvalue4:Stop( )
    end
end

return
]]
