-- Players.perkbrokeyou.PlayerScripts.PainClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Parent = game:GetService( "SoundService" )
local ContentProvider = game:GetService( "ContentProvider" )
local PainSounds = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "PainSounds" ) )
local Pain = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Pain" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Parent2 = Instance.new( "Folder" )
Parent2.Name = "PainVoice"
Parent2.Parent = Parent
local Table = { }
local Table2 = { }
local Voices = PainSounds.Voices
Value1 = nil

for Key, Value in Voices, nil, nil do
    local Value2
    Table[ Key ] = { }
    local Ids = Value.ids
    Value2 = nil

    for Key2, Value3 in Ids, nil, nil do
        local Entry2
        local Sound = Instance.new( "Sound" )
        Sound.Name = Key .. Key2
        Sound.SoundId = "rbxassetid://" .. Value3
        local VOLUME = PainSounds.VOLUME

        if Value.gains then
            local Entry = Value.gains[ Key2 ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = 1
            end
        else
            Entry2 = 1
        end

        Sound.Volume = VOLUME * Entry2
        Sound.Parent = Parent2
        Table[ Key ][ Key2 ] = Sound
        table.insert( Table2, Sound )
    end
end

task.spawn( function()
    pcall( ContentProvider.PreloadAsync, ContentProvider, Table2 )
end )
Pain.OnClientEvent:Connect( function( Key, Key2, Argument3 )
    if ClientState.Spectating then
        return
    end

    local Entry2
    local Entry = Table[ Key ]
    Entry2 = if Entry then Table[ Key ][ Key2 ] else Entry

    if not Entry2 then
        return
    end
    for Key3, Value in Parent2:GetChildren( ) do
        if Value.IsPlaying then
            if not Argument3 then
                return
            end

            Value:Stop( )
        end
    end

    Entry2.PlaybackSpeed = 1 + ( math.random( ) - 0.5 ) * 0.06
    Entry2.TimePosition = 0
    Entry2:Play( )
end )
