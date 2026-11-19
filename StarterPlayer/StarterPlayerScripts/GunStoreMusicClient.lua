-- StarterPlayer.StarterPlayerScripts.GunStoreMusicClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local function Attach( Parent )
    if not Parent:IsA( "BasePart" ) or Parent:FindFirstChild( "GunStoreMusic" ) then
        return
    end
    local Parent2 = Instance.new( "Sound" )
    Parent2.Name = "GunStoreMusic"
    Parent2.SoundId = "rbxassetid://139236359783378"
    Parent2.Looped = true
    Parent2.Volume = 0.2
    Parent2.RollOffMode = Enum.RollOffMode.InverseTapered
    Parent2.RollOffMinDistance = 18
    Parent2.RollOffMaxDistance = 70
    local ReverbSoundEffect = Instance.new( "ReverbSoundEffect" )
    ReverbSoundEffect.DecayTime = 1.3
    ReverbSoundEffect.Density = 0.8
    ReverbSoundEffect.Diffusion = 0.85
    ReverbSoundEffect.DryLevel = 0
    ReverbSoundEffect.WetLevel = -18
    ReverbSoundEffect.Parent = Parent2
    Parent2.Parent = Parent
    Parent2.Loaded:Once( function()
        if Parent2.TimeLength > 0 then
            Parent2.TimePosition = math.random( ) * Parent2.TimeLength
        end
    end )
    Parent2:Play( )
    return
end

while true do
    local Buildings
    local Map = workspace:FindFirstChild( "Map" )

    if Map then
        Buildings = Map:FindFirstChild( "Buildings" )
    else
        Buildings = Map
    end

    local GunStore

    if Buildings then
        GunStore = Buildings:FindFirstChild( "GunStore" )
    else
        GunStore = Buildings
    end

    local MusicPart

    if GunStore then
        MusicPart = GunStore:FindFirstChild( "MusicPart" )
    else
        MusicPart = GunStore
    end
    if MusicPart then
        Attach( MusicPart )
    end

    task.wait( 2 )
end
