-- ReplicatedStorage.TopbarPlus.Icon.Reference
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Table = { objectName = "TopbarPlusReference" }
function Table.addToReplicatedStorage()
    if ReplicatedStorage:FindFirstChild( Table.objectName ) then
        return false
    end
    local ObjectValue = Instance.new( "ObjectValue" )
    ObjectValue.Name = Table.objectName
    ObjectValue.Value = script.Parent
    ObjectValue.Parent = ReplicatedStorage
    return ObjectValue
end
function Table.getObject()
    local FoundChild = ReplicatedStorage:FindFirstChild( Table.objectName )

    if FoundChild then
        return FoundChild
    end
    return false
end
return Table
