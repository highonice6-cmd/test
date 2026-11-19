-- StarterPlayer.StarterPlayerScripts.PackClaimClient
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
game:GetService( "TweenService" )
local Table = {
    Halloween = { "rbxassetid://9044897121", 0.45 },
    Void = { "rbxassetid://131794614393147", 0.8 },
    Data = { "rbxassetid://76681986607556", 0.8 }
}
local Table2 = { }
Value1 = nil

for Key, Value in Table, nil, nil do
    local Sound = Instance.new( "Sound" )
    Sound.Name = "PackClaimMusic_" .. Key
    Sound.SoundId = Value[ 1 ]
    Sound.Volume = Value[ 2 ]
    Sound.Parent = Parent
    Table2[ Key ] = Sound
end

task.spawn( function()
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        table.insert( Table, Value )
    end

    pcall( ContentProvider.PreloadAsync, ContentProvider, Table )
end )
local PackClaimFX = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "PackClaimFX", 60 )

if PackClaimFX then
    PackClaimFX.OnClientEvent:Connect( function( Key )
        local Flag
        Flag = if type( Key ) == "string" then Table2[ Key ] else false

        if Flag then
            Flag:Stop( )
            Flag.Volume = Table[ Key ][ 2 ]
            Flag.TimePosition = 0
            Flag:Play( )
            return
        end
        return
    end )
    return
end
return
