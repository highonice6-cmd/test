-- ReplicatedStorage.Weapons.FrameCache
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local Number = 0
RunService.PostSimulation:Connect( function()
    Number = Number + 1
end )
local Class = setmetatable( { }, { __mode = "k" } )
local Table = {
    Floor = function( Humanoid )
        local Entry = Class[ Humanoid ]

        if Entry and Entry[ 1 ] == Number then
            return Entry[ 2 ]
        end

        local FloorMaterial = Humanoid.FloorMaterial

        if Entry then
            Entry[ 1 ] = Number
            Entry[ 2 ] = FloorMaterial
            return FloorMaterial
        end
        Class[ Humanoid ] = { Number, FloorMaterial }
        return FloorMaterial
    end
}
return Table
