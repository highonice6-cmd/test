-- StarterPlayer.StarterPlayerScripts.AnimTrackGuardClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )

while true do
    task.wait( 2 )

    for Key, Value in Players:GetPlayers( ) do
        local Humanoid
        local Character = Value.Character

        if Character then
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end

        local Animator

        if Humanoid then
            Animator = Humanoid:FindFirstChildOfClass( "Animator" )
        else
            Animator = Humanoid
        end
        if Animator and #Animator:GetPlayingAnimationTracks( ) > 24 then
            table.sort( Animator:GetPlayingAnimationTracks( ), function( Track, Track2 )
                local Flag = Track.WeightCurrent < Track2.WeightCurrent and true or false
                return Flag
            end )
            local Count = #Animator:GetPlayingAnimationTracks( ) - 12
            local J = 1

            for J = 1, Count do
                pcall( function()
                    Upvalue1[ J ]:Stop( 0 )
                end )
            end
        end
    end
end
