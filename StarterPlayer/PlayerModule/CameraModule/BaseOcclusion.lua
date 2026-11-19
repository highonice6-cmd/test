-- StarterPlayer.PlayerModule.CameraModule.BaseOcclusion
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local __index = { }
__index.__index = __index
setmetatable( __index, {
    __call = function( Argument1, ... )
        return __index.new( ... )
    end
} )
function __index.new()
    return ( setmetatable( { }, __index ) )
end
function __index.CharacterAdded( Argument1, Argument2, Argument3 )
end
function __index.CharacterRemoving( Argument1, Argument2, Argument3 )
end
function __index.OnCameraSubjectChanged( Argument1, Argument2 )
end
function __index.GetOcclusionMode( Argument1 )
    warn( "BaseOcclusion GetOcclusionMode must be overridden by derived classes" )
    return nil
end
function __index.Enable( Argument1, Argument2 )
    warn( "BaseOcclusion Enable must be overridden by derived classes" )
end
function __index.Update( Argument1, Argument2, Argument3, Argument4 )
    warn( "BaseOcclusion Update must be overridden by derived classes" )
    return Argument3, Argument4
end
return __index
