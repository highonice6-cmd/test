-- StarterPlayer.StarterPlayerScripts.RocketClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Rocket = require( Weapons:WaitForChild( "Rocket" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local Remotes = ReplicatedStorage:WaitForChild( "Remotes" )
local LocalPlayer = Players.LocalPlayer
Remotes:WaitForChild( "Rocket" ).OnClientEvent:Connect( function( Name, Argument2, Object, Argument4, Argument5, Name2 )
    local Entry = WeaponData[ Name2 or "RPG" ]

    if not Entry or not Entry.Fire.Rocket then
        return
    end
    if Name == "Launch" then
        if Object == LocalPlayer then
            return
        end

        local Character

        if typeof( Object ) == "Instance" then
            if not Object:IsA( "Player" ) or not Object.Character then
                if not Object:IsA( "Model" ) or not Object then
                    Character = nil
                else
                    Character = Object
                end
            else
                Character = Object.Character
            end
        else
            Character = nil
        end

        local Launch = Rocket.Launch
        Launch( Argument2, Character, Argument4, Argument5, Entry.Fire.Rocket, Entry.RocketSounds )
        return
    end
    if Name == "Explode" then
        local Explode = Rocket.Explode
        Explode( Argument2, Object, Entry.RocketSounds )
    end

    return
end )
