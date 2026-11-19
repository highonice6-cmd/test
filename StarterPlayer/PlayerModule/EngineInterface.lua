-- StarterPlayer.PlayerModule.EngineInterface
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
require( script.Parent:WaitForChild( "CommonUtils" ) )
require( script.Parent.Types )
local Table = { }
function Table.update( Argument1 )
    local Character
    local EngineInterface = Argument1.engineInterface
    local Player = Players.LocalPlayer

    if Player then
        Character = Player.Character
    else
        Character = nil
    end

    local Humanoid

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = nil
    end
    if Player ~= EngineInterface.player or Character ~= EngineInterface.character or Humanoid ~= EngineInterface.humanoid then
        EngineInterface.player = Player
        EngineInterface.character = Character
        EngineInterface.humanoid = Humanoid
        EngineInterface.characterChanged = true
    end
end
function Table.cleanDirty( Argument1 )
    Argument1.engineInterface.characterChanged = false
end
return Table
