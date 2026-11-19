-- ReplicatedStorage.Weapons.OnScreen
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { list = setmetatable( { }, { __mode = "k" } ) }
function Table.Is( Key )
    local Flag = Table.list[ Key ] ~= false and true or false
    return Flag
end
return Table
