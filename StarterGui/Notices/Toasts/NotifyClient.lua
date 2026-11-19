-- StarterGui.Notices.Toasts.NotifyClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Notify" ).OnClientEvent:Connect( function( Name, Argument2, Argument3, Argument4, Argument5, Argument6 )
    if Name == "error" then
        Notify.Error( Argument2 )
        return
    end
    if Name == "announce" then
        Notify.Announce( Argument2, Argument3, Argument4, Argument5, Argument6 )
    end
end )
