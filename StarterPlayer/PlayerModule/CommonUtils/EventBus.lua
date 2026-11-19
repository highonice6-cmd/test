-- StarterPlayer.PlayerModule.CommonUtils.EventBus
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
    Self._events = { }
    return Self
end
function __index._getOrCreate( Argument1, Name )
    if not Argument1._events[ Name ] then
        local BindableEvent = Instance.new( "BindableEvent" )
        BindableEvent.Name = Name
        Argument1._events[ Name ] = BindableEvent
    end

    return Argument1._events[ Name ]
end
function __index.publish( Argument1, Argument2, ... )
    Argument1:_getOrCreate( Argument2 ):Fire( ... )
end
function __index.subscribe( Argument1, Argument2 )
    return Argument1:_getOrCreate( Argument2 ).Event
end
return __index
