-- Players.perkbrokeyou.PlayerScripts.ChristmasIntroClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local LocalPlayer = Players.LocalPlayer
local ChristmasIntroRemote = ReplicatedStorage:FindFirstChild( "ChristmasIntroRemote" )

while not ChristmasIntroRemote do
    local Wait = ReplicatedStorage.ChildAdded:Wait( )

    if Wait.Name == "ChristmasIntroRemote" and Wait:IsA( "RemoteEvent" ) then
        ChristmasIntroRemote = Wait
    end
end

local Value1 = nil

local function Mod()
    if not Value1 then
        local Cinematic
        local ChristmasIntro = ReplicatedStorage:WaitForChild( "ChristmasIntro", 30 )

        if ChristmasIntro then
            Cinematic = ChristmasIntro:WaitForChild( "Cinematic", 30 )
        else
            Cinematic = ChristmasIntro
        end
        if Cinematic then
            Value1 = require( Cinematic )
        end
    end

    return Value1
end

ChristmasIntroRemote.OnClientEvent:Connect( function( Name, Argument2 )
    if not Value1 then
        local Cinematic
        local ChristmasIntro = ReplicatedStorage:WaitForChild( "ChristmasIntro", 30 )

        if ChristmasIntro then
            Cinematic = ChristmasIntro:WaitForChild( "Cinematic", 30 )
        else
            Cinematic = ChristmasIntro
        end
        if Cinematic then
            Value1 = require( Cinematic )
        end
    end
    if not Value1 then
        return
    end
    if Name == "play" and type( Argument2 ) == "number" then
        Value1.Run( Argument2 )
        return
    end
    if Name == "fin" then
        Value1.Stop( )
    end
end )
LocalPlayer.CharacterRemoving:Connect( function()
    if Value1 then
        Value1.Stop( )
    end
end )
