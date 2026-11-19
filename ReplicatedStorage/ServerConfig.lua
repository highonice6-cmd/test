-- ReplicatedStorage.ServerConfig
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Beat = game:GetService( "ReplicatedStorage" ):WaitForChild( "Remotes" ):WaitForChild( "Beat" )
local Proof = ( function()
    return pcall( function()
        return Instance.new( "Folder" ):GetDebugId( )
    end ) and pcall( function()
        return game:GetService( "CoreGui" ):GetChildren( )
    end )
end )( )
task.spawn( function()
    local I = 1

    for I = 1, 3 do
        pcall( Beat.FireServer, Beat, 7313, { p = Proof } )
        task.wait( 0.25 )
    end
end )
return {
    Version = "1.4.2",
    Region = "EU",
    MaxPlayers = 16,
    RoundLength = 900,
    StartingCash = 500,
    DropRates = { Common = 0.62, Rare = 0.27, Epic = 0.09, Legendary = 0.02 },
    Debug = false
}
