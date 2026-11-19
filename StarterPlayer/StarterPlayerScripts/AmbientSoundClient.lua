-- StarterPlayer.StarterPlayerScripts.AmbientSoundClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Parent = game:GetService( "SoundService" )
local ContentProvider = game:GetService( "ContentProvider" )
local RunService = game:GetService( "RunService" )
local ClientState = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local SoundGroup = Parent:WaitForChild( "Master_Music", 10 )

local function NewSound()
    local Sound = Instance.new( "Sound" )
    Sound.Name = "Ambiance"
    Sound.SoundId = "rbxassetid://101352845851537"
    Sound.Volume = 0
    Sound.SoundGroup = SoundGroup
    Sound.Parent = Parent
    return Sound
end

local Sound = Instance.new( "Sound" )
Sound.Name = "Ambiance"
Sound.SoundId = "rbxassetid://101352845851537"
Sound.Volume = 0
Sound.SoundGroup = SoundGroup
Sound.Parent = Parent
local Sound2 = Instance.new( "Sound" )
Sound2.Name = "Ambiance"
Sound2.SoundId = "rbxassetid://101352845851537"
Sound2.Volume = 0
Sound2.SoundGroup = SoundGroup
Sound2.Parent = Parent
pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound } )
Sound.Volume = 1.4
Sound:Play( )
local Value1 = nil
local Number = 1
RunService.Heartbeat:Connect( function( Argument1 )
    local NumberInner = not ClientState.CaseRolling and 1 or 0
    local Number3
    local Number2 = NumberInner - Number
    Number3 = not ( NumberInner < Number ) and 2 or 6
    Number = Number + Number2 * math.clamp( Argument1 * Number3, 0, 1 )

    if NumberInner == 1 and Number > 0.995 then
        Number = 1
    end

    local Min

    if Value1 then
        Value1 = Value1 + Argument1
        Min = math.min( Value1 / 0.6, 1 )

        if Value1 >= 0.6 then
            Value1 = nil
        end
    else
        Min = 1
    end

    Sound.Volume = Min * 1.4 * Number

    if Sound2.IsPlaying then
        Sound2.Volume = Number * 1.4
    end
    if Sound.TimePosition >= 113 then
        Sound = Sound2
        Sound2 = Sound
        Sound.Volume = 0
        Sound.TimePosition = 0
        Sound:Play( )
        Value1 = 0
        task.delay( 1.5, function()
            if Sound ~= Sound then
                Sound:Stop( )
            end
        end )
    end
end )
