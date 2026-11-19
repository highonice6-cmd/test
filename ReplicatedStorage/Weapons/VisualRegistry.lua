-- ReplicatedStorage.Weapons.VisualRegistry
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local AnimWorkers = require( script.Parent:WaitForChild( "AnimWorkers" ) )
local Class = setmetatable( { }, { __mode = "k" } )
return ( setmetatable( { }, {
    __index = function( Argument1, Key )
        local Entry = Class[ Key ]

        if Entry ~= nil then
            return Entry
        end
        if AnimWorkers.IsWorker or typeof( Key ) ~= "Instance" or not Key:FindFirstChild( "GA_Visual" ) or not Key:FindFirstChild( "GA_Visual" ):IsA( "ObjectValue" ) then
            return nil
        end
        return Key:FindFirstChild( "GA_Visual" ).Value
    end,
    __newindex = function( Argument1, Parent, Value )
        Class[ Parent ] = Value

        if AnimWorkers.IsWorker and typeof( Parent ) == "Instance" then
            local GA_Visual = Parent:FindFirstChild( "GA_Visual" )

            if Value then
                if not GA_Visual then
                    local ObjectValue = Instance.new( "ObjectValue" )
                    ObjectValue.Name = "GA_Visual"
                    ObjectValue.Value = Value
                    ObjectValue.Parent = Parent
                    return
                end
                if GA_Visual.Value ~= Value then
                    GA_Visual.Value = Value
                    return
                end
            elseif GA_Visual and GA_Visual.Value ~= nil then
                GA_Visual.Value = nil
            end
        end
    end
} ) )
