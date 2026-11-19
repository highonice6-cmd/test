-- StarterPlayer.PlayerModule.CommonUtils
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { }
Table._mocks = { }
function Table.mock( Key, Argument2 )
    Table._mocks[ Key ] = Argument2
end
function Table.get( Name )
    if Table._mocks[ Name ] then
        return require( Table._mocks[ Name ] )
    end
    if script:FindFirstChild( Name ) then
        return require( script:FindFirstChild( Name ) )
    end
    assert( false, "Util does not exist: " .. Name )
    return
end
return Table
