-- Players.perkbrokeyou.PlayerScripts.AntiAfkClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local AfkRejoin = game:GetService( "ReplicatedStorage" ):WaitForChild( "Remotes" ):WaitForChild( "AfkRejoin" )
Players.LocalPlayer.Idled:Connect( function( Amount )
    if Amount >= 900 then
        AfkRejoin:FireServer( Amount )
    end
end )
