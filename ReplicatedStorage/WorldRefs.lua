-- ReplicatedStorage.WorldRefs
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    Find = function( Name )
        local FoundChild = workspace:FindFirstChild( Name )

        if FoundChild then
            return FoundChild
        end

        local FoundChild2
        local TestZone = workspace:FindFirstChild( "TestZone" )
        FoundChild2 = TestZone and TestZone:FindFirstChild( Name ) or nil
        return FoundChild2
    end
}
function Table.Wait( Argument1, Argument2 )
    local Find = Table.Find( Argument1 )

    if Find then
        return Find
    end

    local Clock = os.clock( )

    while true do
        task.wait( 0.1 )
        local Find2 = Table.Find( Argument1 )

        if Find2 then
            return Find2
        end
        if Argument2 and Argument2 <= os.clock( ) - Clock then
            break
        end
    end

    return nil
end
return Table
