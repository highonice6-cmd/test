-- StarterPlayer.StarterPlayerScripts.HealSoundClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local Weapons = game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" )
local Config = require( Weapons:WaitForChild( "Config" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local Heal = Config.Heal
local LocalPlayer = Players.LocalPlayer
local Table = { }
local Items = Heal.Items
Value1 = nil

for Key, Value in Items, nil, nil do
    local Table2 = { }

    if Value.Sound then
        table.insert( Table2, { id = Value.Sound, volume = Value.SoundVolume or 0.5, delay = 0 } )
    end

    local SoundLayers2
    local SoundLayers = Value.SoundLayers
    SoundLayers2 = if SoundLayers then SoundLayers else { }
    local Value2 = nil

    for Key2, Value3 in SoundLayers2, nil, nil do
        if Value3.Id then
            table.insert( Table2, {
                id = Value3.Id,
                volume = Value3.Volume or 0.5,
                delay = Value3.Delay or 0
            } )
        end
    end
    if #Table2 > 0 then
        Table[ Key ] = Table2
    end
end

local Class = setmetatable( { }, { __mode = "k" } )

local function HealOf( Character )
    if Character == LocalPlayer.Character then
        if not ClientState.HealItem or not ClientState.HealStart then
            return nil
        end
        return ClientState.HealItem, os.clock( ) - ClientState.HealStart, ClientState.HealStart
    else
        local HealItem = Character:GetAttribute( "HealItem" )
        local HealStart = Character:GetAttribute( "HealStart" )

        if not HealItem or not HealStart then
            return nil
        end
        return HealItem, workspace:GetServerTimeNow( ) - HealStart, HealStart
    end
end

local function TrackOf( Character, Argument2, Key )
    local Entry2
    local Entry = Argument2.tracks[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { started = false, volume = 0 }
        Argument2.tracks[ Key ] = Table
        Entry2 = Table
    end
    if not Entry2.sound or not Entry2.sound.Parent then
        local Parent = Character:FindFirstChild( "HumanoidRootPart" )

        if not Parent then
            return nil
        end

        local Sound = Instance.new( "Sound" )
        Sound.Name = "HealSound" .. Key
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound.RollOffMinDistance = 6
        Sound.RollOffMaxDistance = 45
        Sound.Parent = Parent
        Entry2.sound = Sound
    end

    return Entry2
end

RunService.Heartbeat:Connect( function( Argument1 )
    for Key, Value in Players:GetPlayers( ) do
        local Character = Value.Character

        if Character then
            local Value1, Value2, Key2
            local Humanoid = Character:FindFirstChildOfClass( "Humanoid" )

            if not Humanoid or not ( Humanoid.Health > 0 ) then
                Value1 = nil
                Value2 = nil
                Key2 = nil
            else
                Value1, Value2, Key2 = HealOf( Character )
            end

            local Entry2 = if Value1 then Heal.Items[ Value1 ] else Value1
            local Entry3 = if Value1 then Table[ Value1 ] else Value1
            local Entry = Class[ Character ]

            if not Entry2 or not Entry3 or not ( Value2 >= 0 ) or not ( Value2 < Entry2.Time ) then
                if Entry and Entry.key then
                    local Value8, Flag
                    local Tracks2 = Entry.tracks
                    Value8 = nil
                    Flag = false

                    for Key5, Value9 in Tracks2, nil, nil do
                        local Sound2 = Value9.sound

                        if Sound2 and Sound2.Parent and Sound2.IsPlaying and Sound2.Volume > 0 then
                            Sound2.Volume = math.max( 0, Sound2.Volume - Value9.volume * Argument1 / 0.15 )
                            Flag = true
                        end
                    end
                    if not Flag then
                        local Value10
                        local Tracks3 = Entry.tracks
                        Value10 = nil

                        for Key6, Value11 in Tracks3, nil, nil do
                            Value11.started = false

                            if Value11.sound and Value11.sound.Parent then
                                Value11.sound:Stop( )
                            end
                        end

                        Entry.key = nil
                    end
                end
            else
                local Entry4

                if Entry then
                    Entry4 = Entry
                else
                    local TableInner = { tracks = { } }
                    Class[ Character ] = TableInner
                    Entry4 = TableInner
                end
                if Entry4.key ~= Key2 then
                    local Value3
                    Entry4.key = Key2
                    local Tracks = Entry4.tracks
                    Value3 = nil

                    for Key3, Value4 in Tracks, nil, nil do
                        Value4.started = false

                        if Value4.sound and Value4.sound.Parent then
                            Value4.sound:Stop( )
                        end
                    end
                end

                local Value5 = nil

                for Key4, Value6 in Entry3, nil, nil do
                    local Entry5 = Entry4.tracks[ Key4 ]

                    if not Entry5 or not Entry5.started then
                        if Value6.delay <= Value2 then
                            local TrackOf2 = TrackOf( Character, Entry4, Key4 )

                            if TrackOf2 then
                                local Sound = TrackOf2.sound
                                local Volume = Value6.volume
                                TrackOf2.started = true
                                TrackOf2.volume = Volume
                                Sound.SoundId = "rbxassetid://" .. Value6.id
                                Sound.Volume = Value6.volume
                                Sound.TimePosition = Value2 - Value6.delay
                                Sound:Play( )
                            end
                        end
                    end
                end
            end
        end
    end
end )
