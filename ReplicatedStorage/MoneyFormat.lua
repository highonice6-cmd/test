-- ReplicatedStorage.MoneyFormat
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return function( Text )
    local Flag
    local Floor = math.floor( tonumber( Text ) or 0 )
    Flag = Floor < 0 and true or false
    local Sub
    local Reverse = tostring( ( math.abs( Floor ) ) ):reverse( ):gsub( "(%d%d%d)", "%1." ):reverse( )

    if Reverse:sub( 1, 1 ) == "." then
        Sub = Reverse:sub( 2 )
    else
        Sub = Reverse
    end

    local Text2 = not Flag and "$" or "-$"
    return Text2 .. Sub
end
