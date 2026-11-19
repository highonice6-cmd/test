-- StarterPlayer.StarterPlayerScripts.TextCapsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )

local function UnderOffsetOK( Argument1 )
    local Parent = Argument1.Parent

    while Parent do
        if Parent:IsA( "PlayerGui" ) then
            break
        end
        if Parent:GetAttribute( "OffsetOK" ) then
            return true
        end

        Parent = Parent.Parent
    end

    return false
end

local WatchCaps = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ScaleUI" ) ).WatchCaps
WatchCaps( Players.LocalPlayer:WaitForChild( "PlayerGui" ), UnderOffsetOK )
