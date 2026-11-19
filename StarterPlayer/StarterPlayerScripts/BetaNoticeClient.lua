-- StarterPlayer.StarterPlayerScripts.BetaNoticeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
Upvalue2.Visible = false
Upvalue3.Close( "BetaNotice" )
Upvalue4:FireServer( )
Upvalue5.BetaNoticeClosed = true
return
]]
