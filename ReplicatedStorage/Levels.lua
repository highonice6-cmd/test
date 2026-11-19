-- ReplicatedStorage.Levels
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { MAX = 100, BASE = 1000, GROWTH = 1.1218, XP_PER_SECOND = 100 }
function Table.Need( Amount )
    if Table.MAX <= Amount then
        return nil
    end
    return ( math.floor( Table.BASE * Table.GROWTH ^ ( Amount - 1 ) + 0.5 ) )
end
return Table
