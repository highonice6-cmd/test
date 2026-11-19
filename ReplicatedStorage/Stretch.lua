-- ReplicatedStorage.Stretch
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { Factor = 1 }
function Table.ToClean( Argument1, Argument2 )
    local Factor = Table.Factor

    if Factor == 1 then
        return Argument1, Argument2
    end
    local X = workspace.CurrentCamera.ViewportSize.X / 2
    return X + ( Argument1 - X ) / Factor, Argument2
end
return Table
