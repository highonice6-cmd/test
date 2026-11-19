-- StarterPlayer.StarterPlayerScripts.RegionNoticeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local LocalPlayer = game:GetService( "Players" ).LocalPlayer
local RegionNotice = game:GetService( "ReplicatedStorage" ):WaitForChild( "Remotes" ):WaitForChild( "RegionNotice" )
local ScaleUI = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ScaleUI" ) )
local Flag = false
local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
local Number = 0
RegionNotice.OnClientEvent:Connect( function( Text )
    local Get = Screens.Get( "RegionNotice", 30 )

    if not Get then
        return
    end
    if not Flag then
        Flag = true
        ScaleUI.Convert( Get )
    end

    Get.Text.Text = Text
    Get.Visible = true
    Number = Number + 1
    task.delay( 15, function()
        if Number == Number and Get.Parent then
            Get.Visible = false
        end
    end )
end )
