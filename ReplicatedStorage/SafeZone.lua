-- ReplicatedStorage.SafeZone
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local SafeZones = workspace:WaitForChild( "SafeZones" )
local Table2 = { }

local function Refresh()
    table.clear( Table2 )

    for Key, Value in SafeZones:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value:GetAttribute( "SafeZone" ) then
            table.insert( Table2, Value )
        end
    end
end

Refresh( )
SafeZones.DescendantAdded:Connect( Refresh )
SafeZones.DescendantRemoving:Connect( function()
    task.defer( Refresh )
end )
local Table = {
    COOLDOWN = 3,
    Contains = function( Argument1 )
        local Value1 = nil

        for Key, Value in Table2, nil, nil do
            local PointToObjectSpace = Value.CFrame:PointToObjectSpace( Argument1 )
            local Size = Value.Size / 2

            if math.abs( PointToObjectSpace.X ) <= Size.X and math.abs( PointToObjectSpace.Y ) <= Size.Y then
                if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                    return true
                end
            end
        end

        return false
    end
}
function Table.IsIn( Object )
    local HumanoidRootPart

    if Object then
        HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Object
    end

    local Contains

    if HumanoidRootPart == nil then
        Contains = false
    else
        Contains = Table.Contains( HumanoidRootPart.Position )
    end

    return Contains
end
return Table
