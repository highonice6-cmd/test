-- StarterPlayer.PlayerModule.CommonUtils.ConnectionUtil
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local __index = { }
__index.__index = __index
function __index.new()
    local Self = setmetatable( { }, __index )
    Self._connections = { }
    return Self
end
function __index.trackConnection( Argument1, ConnectionName, Argument3 )
    if Argument1._connections[ ConnectionName ] then
        Argument1._connections[ ConnectionName ]( )
    end

    Argument1._connections[ ConnectionName ] = function()
        Argument3:Disconnect( )
    end
end
function __index.trackBoundFunction( Argument1, BoundName, Argument3 )
    if Argument1._connections[ BoundName ] then
        Argument1._connections[ BoundName ]( )
    end

    Argument1._connections[ BoundName ] = Argument3
end
function __index.disconnect( Argument1, Key )
    if Argument1._connections[ Key ] then
        Argument1._connections[ Key ]( )
        Argument1._connections[ Key ] = nil
    end
end
function __index.disconnectAll( Argument1 )
    for Key, Value in pairs( Argument1._connections ) do
        Value( )
    end

    Argument1._connections = { }
end
return __index
