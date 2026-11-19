-- StarterPlayer.StarterPlayerScripts.CharacterSoundsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )

local function Fix( Value )
    if not Value:IsA( "Sound" ) then
        return
    end
    if Value.Name == "Running" then
        Value.Volume = 0
        Value:GetPropertyChangedSignal( "Volume" ):Connect( function()
            if Value.Volume ~= 0 then
                Value.Volume = 0
            end
        end )
        return
    end
    if Value.RollOffMaxDistance > 90 then
        Value.RollOffMaxDistance = 90
    end
end

local function Watch( Object )
    local HumanoidRootPart = Object:WaitForChild( "HumanoidRootPart", 10 )

    if not HumanoidRootPart then
        return
    end
    for Key, Value in HumanoidRootPart:GetChildren( ) do
        Fix( Value )
    end

    HumanoidRootPart.ChildAdded:Connect( Fix )
end

local function OnPlayer( Argument1 )
    Argument1.CharacterAdded:Connect( Watch )

    if Argument1.Character then
        task.spawn( Watch, Argument1.Character )
    end
end

Players.PlayerAdded:Connect( OnPlayer )

for Key, Value in Players:GetPlayers( ) do
    Value.CharacterAdded:Connect( Watch )

    if Value.Character then
        task.spawn( Watch, Value.Character )
    end
end
