-- ReplicatedStorage.ExtraItems
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    Get = function( Name )
        if type( Name ) ~= "string" or Name == "" then
            return nil
        end

        local Attributes
        local FoundChild = script:FindFirstChild( Name )
        Attributes = FoundChild and FoundChild:IsA( "Configuration" ) and FoundChild:GetAttributes( ) or nil
        return Attributes
    end
}
function Table.Of( Object )
    if typeof( Object ) ~= "Instance" then
        return nil
    end

    local Get2
    local Get = Table.Get( Object:GetAttribute( "Item" ) )
    Get2 = if Get then Get else Table.Get( Object:GetAttribute( "Gear" ) )
    return Get2
end
function Table.Flag( Argument1, Key )
    local Flag
    local Get = Table.Get( Argument1 )

    if Get == nil then
        Flag = false
    elseif Get[ Key ] == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
return Table
