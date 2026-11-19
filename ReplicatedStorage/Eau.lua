-- ReplicatedStorage.Eau
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Include
RaycastParams2.FilterDescendantsInstances = { workspace.Terrain }

local function EauIci( Argument1 )
    local Flag
    local Floor = math.floor( Argument1.X / 4 ) * 4
    local Floor2 = math.floor( Argument1.Y / 4 ) * 4
    local Vector32 = Vector3.new( Floor, Floor2, math.floor( Argument1.Z / 4 ) * 4 )
    local Terrain = workspace.Terrain
    Flag = Terrain:ReadVoxels( Region3.new( Vector32, Vector32 + Vector3.new( 4, 4, 4 ) ), 4 )[ 1 ][ 1 ][ 1 ] == Enum.Material.Water and true or false
    return Flag
end

return {
    Profondeur = function( Argument1 )
        local Raycast = workspace:Raycast( Argument1 + Vector3.new( 0, 300, 0 ), Vector3.new( 0, -300, 0 ), RaycastParams2 )

        if not Raycast or Raycast.Material ~= Enum.Material.Water or not EauIci( Argument1 ) then
            return nil
        end
        return Raycast.Position.Y - Argument1.Y
    end,
    Entree = function( Argument1, Argument2 )
        local Raycast = workspace:Raycast( Argument1, Argument2, RaycastParams2 )

        if not Raycast or Raycast.Material ~= Enum.Material.Water then
            return nil
        end
        return Raycast.Position
    end
}
