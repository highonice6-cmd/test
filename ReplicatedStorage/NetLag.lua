-- ReplicatedStorage.NetLag
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )

local function OneWay()
    local PlayerGui
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer then
        PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )
    else
        PlayerGui = LocalPlayer
    end

    local SimPing

    if PlayerGui then
        SimPing = PlayerGui:GetAttribute( "SimPing" )
    else
        SimPing = PlayerGui
    end

    local LocalPlayer2 = type( SimPing ) == "number" and SimPing > 0 and SimPing / 2 or 0
    return LocalPlayer2
end

local Table = {
    Out = function( Callback, ... )
        local PlayerGui
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer then
            PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )
        else
            PlayerGui = LocalPlayer
        end

        local SimPing

        if PlayerGui then
            SimPing = PlayerGui:GetAttribute( "SimPing" )
        else
            SimPing = PlayerGui
        end

        local LocalPlayer2 = type( SimPing ) == "number" and SimPing > 0 and SimPing / 2 or 0

        if LocalPlayer2 > 0 then
            task.delay( LocalPlayer2, Callback, ... )
            return
        end
        Callback( ... )
        return
    end
}
Table.In = Table.Out
function Table.Wrap( Argument1 )
    return function( ... )
        Table.In( Argument1, ... )
    end
end
return Table
