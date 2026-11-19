-- StarterPlayer.PlayerModule.CameraModule.VRCameraTeleportDetector
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { JUMP_STUDS = 4, SETTLED_STUDS = 1, DEBOUNCE_SECONDS = 0.25 }
function Table.shouldRecenter( Argument1, Argument2, Argument3, Argument4 )
    if Argument2 <= Table.JUMP_STUDS then
        return false
    end
    if Argument1 ~= nil and Table.SETTLED_STUDS <= Argument1 then
        return false
    end
    if Argument3 == nil or not ( Argument4 - Argument3 < Table.DEBOUNCE_SECONDS ) then
        return true
    end
    return false
end
return Table
