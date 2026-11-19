-- ReplicatedStorage.TopbarPlus.Icon.Packages.GoodSignal
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1 = nil

local function AcquireRunnerThreadAndCallEventHandler( Callback, ... )
    Value1 = nil
    Callback( ... )
    Value1 = Value1
end

local function RunEventHandlerInFreeThread()
    while true do
        AcquireRunnerThreadAndCallEventHandler( coroutine.yield( ) )
    end
end

local __index = { }
__index.__index = __index
function __index.new( Argument1, Argument2 )
    return ( setmetatable( {
        _connected = true,
        _signal = Argument1,
        _fn = Argument2,
        _next = false
    }, __index ) )
end
function __index.Disconnect( Argument1 )
    Argument1._connected = false

    if Argument1._signal._handlerListHead == Argument1 then
        local _signal = Argument1._signal
        _signal._handlerListHead = Argument1._next
        return
    end

    local _handlerListHead = Argument1._signal._handlerListHead

    while _handlerListHead do
        if _handlerListHead._next == Argument1 then
            break
        end

        _handlerListHead = _handlerListHead._next
    end
    if _handlerListHead then
        _handlerListHead._next = Argument1._next
    end
end
__index.Destroy = __index.Disconnect
setmetatable( __index, {
    __index = function( Argument1, Argument2 )
        error( ( "Attempt to get Connection::%s (not a valid member)" ):format( ( tostring( Argument2 ) ) ), 2 )
    end,
    __newindex = function( Argument1, Argument2, Argument3 )
        error( ( "Attempt to set Connection::%s (not a valid member)" ):format( ( tostring( Argument2 ) ) ), 2 )
    end
} )
local __index2 = { }
__index2.__index = __index2
function __index2.new()
    return ( setmetatable( { _handlerListHead = false }, __index2 ) )
end
function __index2.Connect( Argument1, Argument2 )
    local _handlerListHead = __index.new( Argument1, Argument2 )

    if Argument1._handlerListHead then
        _handlerListHead._next = Argument1._handlerListHead
        Argument1._handlerListHead = _handlerListHead
        return _handlerListHead
    end
    Argument1._handlerListHead = _handlerListHead
    return _handlerListHead
end
function __index2.DisconnectAll( Argument1 )
    Argument1._handlerListHead = false
end
__index2.Destroy = __index2.DisconnectAll
function __index2.Fire( Argument1, ... )
    local _handlerListHead = Argument1._handlerListHead

    while _handlerListHead do
        if _handlerListHead._connected then
            if not Value1 then
                Value1 = coroutine.create( RunEventHandlerInFreeThread )
                coroutine.resume( Value1 )
            end

            task.spawn( Value1, _handlerListHead._fn, ... )
        end

        _handlerListHead = _handlerListHead._next
    end
end
function __index2.Wait( Argument1 )
    local Running = coroutine.running( )
    local Connect = nil
    Connect = Argument1:Connect( function( ... )
        Connect:Disconnect( )
        task.spawn( Running, ... )
    end )
    local Yield = coroutine.yield( )
    return Yield
end
function __index2.Once( Argument1, Argument2 )
    local Connect = nil
    Connect = Argument1:Connect( function( ... )
        if Connect._connected then
            Connect:Disconnect( )
        end

        Argument2( ... )
    end )
    return Connect
end
setmetatable( __index2, {
    __index = function( Argument1, Argument2 )
        error( ( "Attempt to get Signal::%s (not a valid member)" ):format( ( tostring( Argument2 ) ) ), 2 )
    end,
    __newindex = function( Argument1, Argument2, Argument3 )
        error( ( "Attempt to set Signal::%s (not a valid member)" ):format( ( tostring( Argument2 ) ) ), 2 )
    end
} )
return __index2
