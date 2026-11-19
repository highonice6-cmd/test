-- Players.perkbrokeyou.PlayerScripts.SpawnMusicClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ContentProvider = game:GetService( "ContentProvider" )
local Players = game:GetService( "Players" )
local SoundService = game:GetService( "SoundService" )
local TweenService = game:GetService( "TweenService" )

local function IntroOver()
    if Players.LocalPlayer:GetAttribute( "LoadingReady" ) ~= true then
        return false
    end

    local NotTitleMusic2
    local TitleMusic = SoundService:FindFirstChild( "TitleMusic" )
    local NotTitleMusic = not TitleMusic
    NotTitleMusic2 = if NotTitleMusic then NotTitleMusic else not TitleMusic.IsPlaying
    return NotTitleMusic2
end

local Clock = os.clock( )

local function WaitIntro()
    while true do
        local Flag

        if Players.LocalPlayer:GetAttribute( "LoadingReady" ) == true then
            local TitleMusic = SoundService:FindFirstChild( "TitleMusic" )
            local NotTitleMusic = not TitleMusic

            if NotTitleMusic then
                Flag = NotTitleMusic
            else
                Flag = not TitleMusic.IsPlaying
            end
        else
            Flag = false
        end
        if Flag or not ( os.clock( ) - Clock < 300 ) then
            break
        end

        task.wait( 0.1 )
    end
end

local function Attach( Parent )
    if not Parent:IsA( "BasePart" ) or Parent:FindFirstChild( "SpawnMusic" ) then
        return
    end

    local Flag
    local Parent2 = Instance.new( "Sound" )
    Parent2.Name = "SpawnMusic"
    Parent2.SoundId = "rbxassetid://96858685053289"
    Parent2.Looped = true
    Parent2.Volume = 0.5
    Parent2.RollOffMode = Enum.RollOffMode.InverseTapered
    Parent2.RollOffMinDistance = 18
    Parent2.RollOffMaxDistance = 75
    local ReverbSoundEffect = Instance.new( "ReverbSoundEffect" )
    ReverbSoundEffect.DecayTime = 1.2
    ReverbSoundEffect.Density = 1
    ReverbSoundEffect.Diffusion = 1
    ReverbSoundEffect.DryLevel = -1
    ReverbSoundEffect.WetLevel = -16
    ReverbSoundEffect.Parent = Parent2
    Parent2.Parent = Parent
    pcall( ContentProvider.PreloadAsync, ContentProvider, { Parent2 } )

    if Players.LocalPlayer:GetAttribute( "LoadingReady" ) == true then
        local TitleMusic = SoundService:FindFirstChild( "TitleMusic" )
        local NotTitleMusic = not TitleMusic

        if NotTitleMusic then
            Flag = NotTitleMusic
        else
            Flag = not TitleMusic.IsPlaying
        end
    else
        Flag = false
    end
    if Flag then
        if Parent2.Parent then
            Parent2:Play( )
        end

        return
    end
    WaitIntro( )

    if not Parent2.Parent then
        return
    end

    local TitleMusic2 = SoundService:FindFirstChild( "TitleMusic" )

    if TitleMusic2 and TitleMusic2.SoundId == Parent2.SoundId then
        Parent2.TimePosition = TitleMusic2.TimePosition
    end

    Parent2.Volume = 0
    Parent2:Play( )
    TweenService:Create( Parent2, TweenInfo.new( 0.8 ), { Volume = 0.5 } ):Play( )
    return
end

local SPAWN_CHARACTER = workspace:WaitForChild( "SPAWN_CHARACTER", math.huge )
SPAWN_CHARACTER.ChildAdded:Connect( function( Argument1 )
    if Argument1.Name == "MusicPart" then
        task.spawn( Attach, Argument1 )
    end
end )
local MusicPart = SPAWN_CHARACTER:FindFirstChild( "MusicPart" )

if MusicPart then
    Attach( MusicPart )
end
