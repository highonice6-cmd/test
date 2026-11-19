-- StarterPlayer.StarterPlayerScripts.MechanicMusicClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ContentProvider = game:GetService( "ContentProvider" )
local Table = {
    { "rbxassetid://73215369876611", 1 },
    { "rbxassetid://125555850131756", 0.8 }
}

local function Attach( Parent )
    if not Parent:IsA( "BasePart" ) or Parent:FindFirstChild( "MechanicMusic" ) then
        return
    end

    local Value1
    local Parent2 = Instance.new( "Sound" )
    Parent2.Name = "MechanicMusic"
    local Random = math.random( #Table )
    Parent2.SoundId = Table[ Random ][ 1 ]
    Parent2.Looped = false
    Parent2.Volume = 0.6 * Table[ Random ][ 2 ]
    Parent2.RollOffMode = Enum.RollOffMode.InverseTapered
    Parent2.RollOffMinDistance = 20
    Parent2.RollOffMaxDistance = 90
    local ReverbSoundEffect = Instance.new( "ReverbSoundEffect" )
    ReverbSoundEffect.DecayTime = 1.3
    ReverbSoundEffect.Density = 0.8
    ReverbSoundEffect.Diffusion = 0.85
    ReverbSoundEffect.DryLevel = 0
    ReverbSoundEffect.WetLevel = -18
    ReverbSoundEffect.Parent = Parent2
    Parent2.Parent = Parent
    Parent2.Ended:Connect( function()
        Random = Random % #Table + 1
        Parent2.SoundId = Table[ Random ][ 1 ]
        Parent2.Volume = 0.6 * Table[ Random ][ 2 ]
        Parent2.TimePosition = 0

        if Parent2.Parent then
            Parent2:Play( )
        end
    end )
    local TableInner = { }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = Value[ 1 ]
        table.insert( TableInner, Sound )
    end

    pcall( ContentProvider.PreloadAsync, ContentProvider, TableInner )

    if Parent2.Parent then
        Parent2:Play( )
    end
end

while true do
    local Buildings
    local Map = workspace:FindFirstChild( "Map" )

    if Map then
        Buildings = Map:FindFirstChild( "Buildings" )
    else
        Buildings = Map
    end

    local Mechanic

    if Buildings then
        Mechanic = Buildings:FindFirstChild( "Mechanic" )
    else
        Mechanic = Buildings
    end

    local MusicPart

    if Mechanic then
        MusicPart = Mechanic:FindFirstChild( "MusicPart" )
    else
        MusicPart = Mechanic
    end
    if MusicPart then
        Attach( MusicPart )
    end

    task.wait( 2 )
end
