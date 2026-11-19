-- StarterPlayer.PlayerModule.CommonUtils.CameraWrapper
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ConnectionUtil = require( script.Parent.ConnectionUtil )
local __index = { }
__index.__index = __index
function __index.new()
    return ( setmetatable( {
        _camera = game.Workspace.CurrentCamera,
        _callbacks = { },
        _connectionUtil = ConnectionUtil.new( ),
        _enabled = false
    }, __index ) )
end
function __index._connectCallbacks( Argument1 )
    Argument1._camera = game.Workspace.CurrentCamera

    if not Argument1._camera then
        return
    end

    local Value1
    local _callbacks = Argument1._callbacks
    Value1 = nil

    for Key, Value in _callbacks, nil, nil do
        local _connectionUtil = Argument1._connectionUtil
        _connectionUtil:trackConnection( Key, Argument1._camera:GetPropertyChangedSignal( Key ):Connect( Value ) )
        Value( )
    end
end
function __index.Enable( Argument1 )
    if Argument1._enabled then
        return
    end
    Argument1._enabled = true
    Argument1._cameraChangedConnection = game.Workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( function()
        Argument1:_connectCallbacks( )
    end )
    Argument1:_connectCallbacks( )
    return
end
function __index.Disable( Argument1 )
    if not Argument1._enabled then
        return
    end

    Argument1._enabled = false

    if Argument1._cameraChangedConnection then
        Argument1._cameraChangedConnection:Disconnect( )
        Argument1._cameraChangedConnection = nil
    end

    Argument1._connectionUtil:disconnectAll( )
end
function __index.Connect( Argument1, Property, Argument3 )
    Argument1._callbacks[ Property ] = Argument3

    if Argument1._camera then
        local _connectionUtil = Argument1._connectionUtil
        _connectionUtil:trackConnection( Property, Argument1._camera:GetPropertyChangedSignal( Property ):Connect( Argument3 ) )
        return
    end
    return
end
function __index.Disconnect( Argument1, Key )
    Argument1._connectionUtil:disconnect( Key )
    Argument1._callbacks[ Key ] = nil
end
function __index.getCamera( Argument1 )
    return Argument1._camera
end
return __index
