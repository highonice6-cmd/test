-- StarterPlayer.PlayerModule.CameraModule.CameraUI
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local StarterGui = game:GetService( "StarterGui" )
local Flag = false
local Table = { }
function Table.setCameraModeToastEnabled( Enabled )
    if not Enabled and not Flag then
        return
    end
    if not Flag then
        Flag = true
    end
    if not Enabled then
        Table.setCameraModeToastOpen( false )
    end
end
function Table.setCameraModeToastOpen( Open )
    assert( Flag )

    if Open then
        StarterGui:SetCore( "SendNotification", {
            Title = "Camera Control Enabled",
            Text = "Right click to toggle",
            Duration = 3
        } )
    end
end
return Table
