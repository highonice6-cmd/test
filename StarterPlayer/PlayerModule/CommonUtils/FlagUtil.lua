-- StarterPlayer.PlayerModule.CommonUtils.FlagUtil
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { }
function Table.getUserFlag( Argument1 )
    local Success, Result = pcall( function()
        return UserSettings( ):IsUserFeatureEnabled( Argument1 )
    end )
    return Success and Result
end
return Table
