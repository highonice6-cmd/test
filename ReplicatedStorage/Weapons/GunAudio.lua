-- ReplicatedStorage.Weapons.GunAudio
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Parent = game:GetService( "SoundService" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local ContentProvider = game:GetService( "ContentProvider" )
local WeaponData = require( script.Parent:WaitForChild( "WeaponData" ) )
local CurrentCamera = workspace.CurrentCamera
local Random2 = Random.new( )
local TweenInfo2 = TweenInfo.new( 0.035, Enum.EasingStyle.Sine )
local TweenInfo3 = TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
local Table2 = { Decay = 0.5, Wet = -30, Dry = 0 }
local Table3 = { Decay = 1, Wet = -27, Dry = 0 }
local Table4 = { }
local Folder = Instance.new( "Folder" )
Folder.Name = "GunAudioLocal"
Folder.Parent = Parent
local Folder2 = Instance.new( "Folder" )
Folder2.Name = "GunAudioPreload"
Folder2.Parent = Parent
local Table5 = { }

local function SoundFor( SoundId )
    if Table5[ SoundId ] then
        return nil
    end
    Table5[ SoundId ] = true
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = SoundId
    Sound.Volume = 0
    Sound.Parent = Folder2
    return Sound
end

local Table6 = { }
local Number = 0
local Table7 = { 20, 60, 180 }

local function OkId( Key )
    local Flag = if type( Key ) == "number" then not Table6[ Key ] else false
    return Flag
end

local function Retry( Argument1, Key )
    task.delay( Table7[ Key ], function()
        if not Table6[ Argument1 ] then
            return
        end

        local Sound = Instance.new( "Sound" )
        Sound.SoundId = "rbxassetid://" .. Argument1
        Sound.Volume = 0
        Sound.Parent = Folder2
        local Flag = false
        pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound }, function( Argument1, Argument2 )
            local FlagInner
            FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
            Flag = FlagInner
        end )

        if Flag and not Sound.IsLoaded then
            task.wait( 0.2 )
        end
        if not Flag or not Sound.IsLoaded then
            Sound:Destroy( )

            if Table7[ Key + 1 ] then
                Retry( Argument1, Key + 1 )
            end
        else
            Table6[ Argument1 ] = nil
            Number = Number + 1
        end
    end )
end

local function MarkFailed( FailedName )
    if type( FailedName ) ~= "number" or Table6[ FailedName ] then
        return
    end
    Table6[ FailedName ] = true
    Number = Number + 1
    local NumberInner = 1
    task.delay( Table7[ 1 ], function()
        if not Table6[ FailedName ] then
            return
        end

        local Sound = Instance.new( "Sound" )
        Sound.SoundId = "rbxassetid://" .. FailedName
        Sound.Volume = 0
        Sound.Parent = Folder2
        local Flag = false
        pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound }, function( Argument1, Argument2 )
            local FlagInner
            FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
            Flag = FlagInner
        end )

        if Flag and not Sound.IsLoaded then
            task.wait( 0.2 )
        end
        if not Flag or not Sound.IsLoaded then
            Sound:Destroy( )

            if Table7[ NumberInner + 1 ] then
                Retry( FailedName, NumberInner + 1 )
            end
        else
            Table6[ FailedName ] = nil
            Number = Number + 1
        end
    end )
    return
end

local function FetchCallback( Argument1 )
    return function( Key, Argument2 )
        if Argument2 == Enum.AssetFetchStatus.Failure or Argument2 == Enum.AssetFetchStatus.TimedOut then
            local Entry = Argument1[ Key ]

            if type( Entry ) == "number" then
                if Table6[ Entry ] then
                    return
                end

                Table6[ Entry ] = true
                Number = Number + 1
                local NumberInner = 1
                task.delay( Table7[ 1 ], function()
                    if not Table6[ Entry ] then
                        return
                    end

                    local Sound = Instance.new( "Sound" )
                    Sound.SoundId = "rbxassetid://" .. Entry
                    Sound.Volume = 0
                    Sound.Parent = Folder2
                    local Flag = false
                    pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound }, function( Argument1, Argument2 )
                        local FlagInner
                        FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
                        Flag = FlagInner
                    end )

                    if Flag and not Sound.IsLoaded then
                        task.wait( 0.2 )
                    end
                    if not Flag or not Sound.IsLoaded then
                        Sound:Destroy( )

                        if Table7[ NumberInner + 1 ] then
                            Retry( Entry, NumberInner + 1 )
                        end
                    else
                        Table6[ Entry ] = nil
                        Number = Number + 1
                    end
                end )
            end
        end
    end
end

task.spawn( function()
    local Value1
    local Table = { }
    local Table2 = { }
    Value1 = nil

    for Key, Value in WeaponData, nil, nil do
        if type( Value ) == "table" and Value.Sounds then
            local Suppressed2
            local Table3 = { }
            local Sounds = Value.Sounds
            local Suppressed = Value.Sounds.Suppressed
            Suppressed2 = if Suppressed then Suppressed else { }
            local Value2
            Table3[ 1 ] = Sounds
            Table3[ 2 ] = Suppressed2
            Value2 = nil

            for Key2, Value3 in Table3, nil, nil do
                local Value4
                local Table4 = { "Single", "Final", "FarSingle", "FarFinal", "Bolt", "Shell" }
                Value4 = nil

                for Key3, Value5 in Table4, nil, nil do
                    local Rawget4
                    local Rawget3 = rawget( Value3, Value5 )
                    Rawget4 = type( Rawget3 ) == "table" and Rawget3 or { Rawget3 }
                    local Value8 = nil

                    for Key5, Value9 in Rawget4, nil, nil do
                        local Id = if type( Value9 ) == "table" then Value9.Id else Value9
                        local Flag

                        if type( Id ) == "number" then
                            local SoundId3 = "rbxassetid://" .. Id

                            if Table5[ SoundId3 ] then
                                Flag = nil
                            else
                                Table5[ SoundId3 ] = true
                                local Sound5 = Instance.new( "Sound" )
                                Sound5.SoundId = SoundId3
                                Sound5.Volume = 0
                                Sound5.Parent = Folder2
                                Flag = Sound5
                            end
                        else
                            Flag = false
                        end
                        if Flag then
                            table.insert( Table, Flag )
                            Table2[ Flag.SoundId ] = Id
                        end
                    end
                end

                local Rawget2
                local Rawget = rawget( Value3, "Reload" )
                Rawget2 = if Rawget then Rawget else { }
                local Value6 = nil

                for Key4, Value7 in Rawget2, nil, nil do
                    local Sound4
                    local SoundId2 = "rbxassetid://" .. Value7.Id

                    if Table5[ SoundId2 ] then
                        Sound4 = nil
                    else
                        Table5[ SoundId2 ] = true
                        local Sound3 = Instance.new( "Sound" )
                        Sound3.SoundId = SoundId2
                        Sound3.Volume = 0
                        Sound3.Parent = Folder2
                        Sound4 = Sound3
                    end
                    if Sound4 then
                        table.insert( Table, Sound4 )
                        Table2[ Sound4.SoundId ] = Value7.Id
                    end
                end
            end
        end
    end

    local Sound2
    local SoundId = "rbxassetid://" .. 2743868563

    if Table5[ SoundId ] then
        Sound2 = nil
    else
        Table5[ SoundId ] = true
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = SoundId
        Sound.Volume = 0
        Sound.Parent = Folder2
        Sound2 = Sound
    end
    if Sound2 then
        table.insert( Table, Sound2 )
        Table2[ Sound2.SoundId ] = 2743868563
    end

    pcall( ContentProvider.PreloadAsync, ContentProvider, Table, function( Key, Argument2 )
        if Argument2 == Enum.AssetFetchStatus.Failure or Argument2 == Enum.AssetFetchStatus.TimedOut then
            local Entry = Table2[ Key ]

            if type( Entry ) == "number" then
                if Table6[ Entry ] then
                    return
                end

                Table6[ Entry ] = true
                Number = Number + 1
                local NumberInner = 1
                task.delay( Table7[ 1 ], function()
                    if not Table6[ Entry ] then
                        return
                    end

                    local Sound = Instance.new( "Sound" )
                    Sound.SoundId = "rbxassetid://" .. Entry
                    Sound.Volume = 0
                    Sound.Parent = Folder2
                    local Flag = false
                    pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound }, function( Argument1, Argument2 )
                        local FlagInner
                        FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
                        Flag = FlagInner
                    end )

                    if Flag and not Sound.IsLoaded then
                        task.wait( 0.2 )
                    end
                    if not Flag or not Sound.IsLoaded then
                        Sound:Destroy( )

                        if Table7[ NumberInner + 1 ] then
                            Retry( Entry, NumberInner + 1 )
                        end
                    else
                        Table6[ Entry ] = nil
                        Number = Number + 1
                    end
                end )
            end
        end
    end )
end )

local function PreloadIds( List )
    local Table = { }
    local Table2 = { }
    local Value1 = nil

    for Key, Value in List or { }, nil, nil do
        local Flag

        if type( Value ) == "number" then
            local SoundId = "rbxassetid://" .. Value

            if Table5[ SoundId ] then
                Flag = nil
            else
                Table5[ SoundId ] = true
                local Sound = Instance.new( "Sound" )
                Sound.SoundId = SoundId
                Sound.Volume = 0
                Sound.Parent = Folder2
                Flag = Sound
            end
        else
            Flag = false
        end
        if Flag then
            table.insert( Table, Flag )
            Table2[ Flag.SoundId ] = Value
        end
    end
    if #Table > 0 then
        task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table, function( Key, Argument2 )
            if Argument2 == Enum.AssetFetchStatus.Failure or Argument2 == Enum.AssetFetchStatus.TimedOut then
                local Entry = Table2[ Key ]

                if type( Entry ) == "number" then
                    if Table6[ Entry ] then
                        return
                    end

                    Table6[ Entry ] = true
                    Number = Number + 1
                    local NumberInner = 1
                    task.delay( Table7[ 1 ], function()
                        if not Table6[ Entry ] then
                            return
                        end

                        local Sound = Instance.new( "Sound" )
                        Sound.SoundId = "rbxassetid://" .. Entry
                        Sound.Volume = 0
                        Sound.Parent = Folder2
                        local Flag = false
                        pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound }, function( Argument1, Argument2 )
                            local FlagInner
                            FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
                            Flag = FlagInner
                        end )

                        if Flag and not Sound.IsLoaded then
                            task.wait( 0.2 )
                        end
                        if not Flag or not Sound.IsLoaded then
                            Sound:Destroy( )

                            if Table7[ NumberInner + 1 ] then
                                Retry( Entry, NumberInner + 1 )
                            end
                        else
                            Table6[ Entry ] = nil
                            Number = Number + 1
                        end
                    end )
                end
            end
        end )
    end
end

local Table8 = { }
local Table9 = {
    Heavy = { speed = 0.7727272727272726, eq = { 2, 3, -4 }, gain = 2.25 },
    Muffled = { speed = 1, eq = { 2, -10, -40 }, gain = 0.55 },
    Silenced = { speed = 1, eq = { 0, -4, -18 }, gain = 0.5 }
}

local function GroupFor( Text, Argument2, Argument3, ForName )
    local Text2 = not Argument2 and "" or "_Far"
    local Text3 = ForName and Table9[ ForName ] and "_" .. ForName or ""
    local Text4 = Text .. Text2 .. Text3
    local Entry = Table8[ Text4 ]

    if Entry and Entry.Parent then
        return Entry
    end

    local FarReverb, FarEcho

    if Argument2 then
        FarReverb = Argument3.FarReverb
        FarEcho = Argument3.FarEcho
    else
        FarReverb = Argument3.Reverb
        FarEcho = Argument3.Echo
    end
    if FarReverb == nil then
        local Captured = Argument2 and Table3 or Table2
        FarReverb = Captured
    end
    if not FarReverb and not FarEcho and not ( ForName and Table9[ ForName ] ) then
        return nil
    end

    local ParentInner = Instance.new( "SoundGroup" )
    ParentInner.Name = "GunFX_" .. Text4
    ParentInner.Volume = 1

    if ForName and Table9[ ForName ] then
        local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
        local LowGain = ( ForName and Table9[ ForName ] ).eq[ 1 ]
        local MidGain = ( ForName and Table9[ ForName ] ).eq[ 2 ]
        local HighGain = ( ForName and Table9[ ForName ] ).eq[ 3 ]
        EqualizerSoundEffect.LowGain = LowGain
        EqualizerSoundEffect.MidGain = MidGain
        EqualizerSoundEffect.HighGain = HighGain
        EqualizerSoundEffect.Priority = 3
        EqualizerSoundEffect.Parent = ParentInner
        ParentInner.Volume = ( ForName and Table9[ ForName ] ).gain
    end
    if FarEcho then
        local EchoSoundEffect = Instance.new( "EchoSoundEffect" )
        local Delay = FarEcho.Delay
        local Feedback = FarEcho.Feedback
        local WetLevel = FarEcho.Wet
        EchoSoundEffect.Delay = Delay
        EchoSoundEffect.Feedback = Feedback
        EchoSoundEffect.DryLevel = 0
        EchoSoundEffect.WetLevel = WetLevel
        EchoSoundEffect.Priority = 2
        EchoSoundEffect.Parent = ParentInner
    end
    if FarReverb then
        local ReverbSoundEffect = Instance.new( "ReverbSoundEffect" )
        local DecayTime = FarReverb.Decay
        local DryLevel = FarReverb.Dry or 0
        local WetLevel2 = FarReverb.Wet
        ReverbSoundEffect.DecayTime = DecayTime
        ReverbSoundEffect.Density = 1
        ReverbSoundEffect.Diffusion = 1
        ReverbSoundEffect.DryLevel = DryLevel
        ReverbSoundEffect.WetLevel = WetLevel2
        ReverbSoundEffect.Priority = 1
        ReverbSoundEffect.Parent = ParentInner
    end

    ParentInner.Parent = Parent
    Table8[ Text4 ] = ParentInner
    return ParentInner
end

local function FallbackGroup()
    return ( GroupFor( "_Fire", false, { } ) )
end

local Class = setmetatable( { }, { __mode = "k" } )
local Class2 = setmetatable( { }, { __mode = "k" } )

local function EqFor( ForName )
    local Entry2
    local Entry = Class[ ForName ]
    Entry2 = if Entry then Entry else ForName:FindFirstChild( "EQ" )
    return Entry2
end

local Table10 = { }
local Table11 = { }
local Class3 = setmetatable( { }, { __mode = "k" } )
local Class4 = setmetatable( { }, { __mode = "k" } )

local function Claim( Argument1, Key )
    if not Key or not Argument1.shared then
        return
    end

    Class3[ Key ] = Argument1
    local Entry = Class4[ Key ]

    if Entry then
        Entry.WorldPosition = Argument1.parent.WorldPosition
    end
end

local function Mine( Argument1, Key )
    local NotShared2
    local NotShared = not Argument1.shared

    if NotShared then
        NotShared2 = NotShared
    elseif Class3[ Key ] == Argument1 then
        NotShared2 = true
    else
        NotShared2 = false
    end

    return NotShared2
end

local function NewSound( Text, ParentInner, Argument3, Argument4, Argument5, SoundGroup )
    local Parent2 = Instance.new( "Sound" )
    Parent2.SoundId = "rbxassetid://" .. Text
    Parent2.Volume = 0
    Parent2.SoundGroup = SoundGroup
    local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
    EqualizerSoundEffect.Name = "EQ"
    EqualizerSoundEffect.LowGain = 0
    EqualizerSoundEffect.MidGain = 0
    EqualizerSoundEffect.HighGain = 0
    EqualizerSoundEffect.Parent = Parent2
    Class[ Parent2 ] = EqualizerSoundEffect

    if not Argument5 then
        local RollOffMinDistance
        Parent2.RollOffMode = Enum.RollOffMode.InverseTapered
        RollOffMinDistance = Argument4 and Argument3.FarRollMin or Argument3.RollMin
        local RollOffMaxDistance
        Parent2.RollOffMinDistance = RollOffMinDistance
        RollOffMaxDistance = Argument4 and Argument3.FarRollMax or Argument3.RollMax
        Parent2.RollOffMaxDistance = RollOffMaxDistance
    end
    if ParentInner ~= Table10 then
        Parent2.Parent = ParentInner
        return Parent2
    end

    local Parent3 = Instance.new( "Attachment" )
    Parent3.Name = "GunAudioVoice"
    Parent3.Parent = workspace.Terrain
    Class4[ Parent2 ] = Parent3

    if not SoundGroup then
        Parent2.SoundGroup = Parent:FindFirstChild( "Master_Weapons" )
    end

    Parent2.Parent = Parent3
    return Parent2
end

local function Pool( Text, List, Parent, Argument4, Argument5, Argument6, SoundGroup )
    if not Text then
        return nil
    end

    local Table = { }
    local I = 1

    for I = 1, List do
        Table[ I ] = NewSound( Text, Parent, Argument4, Argument5, Argument6, SoundGroup )
    end

    return Table
end

local function Variants( List, List2, List3, Parent, Argument5, Argument6, Argument7, SoundGroup )
    if not List then
        return nil
    end

    local Table2 = if type( List ) == "table" then List else { List }
    local Table3 = if type( List2 ) == "table" then List2 else { List2 }
    local Table4 = if type( List3 ) == "table" then List3 else { List3 }
    local Number
    local Table = { last = 0, prev = 0 }
    Number = #Table2 ~= 1 and 2 or 5
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        Table[ Key ] = {
            voices = Pool( Value, Number, Parent, Argument5, Argument6, Argument7, SoundGroup ),
            idx = 0,
            start = Table3[ Key ] or 0,
            gain = Table4[ Key ] or 1
        }
    end

    return Table
end

local function NextVoice( List )
    local Last
    local Count = #List

    if Count > 1 then
        Last = 1

        while true do
            local NextInteger = Random2:NextInteger( 1, Count )

            if NextInteger == List.last then
                continue
            end
            if Count <= 2 or NextInteger ~= List.prev then
                Last = NextInteger
                break
            end
        end
    else
        Last = 1
    end

    List.prev = List.last
    List.last = Last
    local Entry = List[ Last ]
    Entry.idx = Entry.idx % #Entry.voices + 1
    return Entry.voices[ Entry.idx ], Entry.start, Entry.gain
end

local function SuppressedSet( Argument1 )
    local Suppressed = Argument1.Suppressed

    if not Suppressed then
        return nil
    end
    if not getmetatable( Suppressed ) then
        setmetatable( Suppressed, { __index = Argument1 } )
    end

    return Suppressed
end

local Table = {
    MarkFailed = MarkFailed,
    PreloadIds = PreloadIds,
    Tones = Table9,
    SkinTone = nil,
    FallbackGroup = FallbackGroup,
    CustomShot = nil,
    HearOthersCustom = nil
}
local Table12 = {
    FarStart = 60,
    FarEnd = 180,
    RollMin = 12,
    RollMax = 250,
    FarRollMin = 45,
    FarRollMax = 900
}
local Table13 = { }

local function CustomSet( Argument1, Reverb, Argument3, Argument4 )
    local Text3
    local Text = tostring( Argument1 )
    local Text2 = tostring( Argument3.id )
    Text3 = not Argument4 and "" or "|S"
    local Text4 = Text .. "|" .. Text2 .. Text3
    local Entry = Table13[ Text4 ]

    if Entry then
        return Entry
    end

    local FarVolume

    local function Dist( Key )
        local Number2
        local Number = tonumber( Reverb and Reverb[ Key ] )
        Number2 = if Number then Number else Table12[ Key ]
        return Number2
    end

    local PitchVar = tonumber( Argument3.PitchVar ) or 0.03
    local Number = tonumber( Argument3.Start ) or 0
    local Table = {
        Single = Argument3.Sound,
        SingleStart = Number,
        SingleGain = 1,
        FarSingle = Argument3.Sound,
        FarSingleStart = Number,
        FarSingleGain = 1,
        Final = false,
        TailVolume = false,
        Volume = tonumber( Argument3.Volume ) or 1,
        VolVar = 0.04,
        EqVar = 0.5,
        FirstShotBoost = 1,
        ShotFade = 0.01
    }
    local Number2 = tonumber( Argument3.FarVolume )

    if Number2 then
        FarVolume = Number2
    else
        local Number3 = tonumber( Argument3.Volume )

        if Number3 then
            FarVolume = Number3
        else
            FarVolume = 1
        end
    end

    Table.FarVolume = FarVolume
    Table.Pitch = tonumber( Argument3.Pitch ) or 1
    Table.PitchVar = PitchVar
    Table.SoloPitchVar = PitchVar
    local FarStart
    local Number4 = tonumber( Reverb and Reverb.FarStart )
    FarStart = if Number4 then Number4 else Table12.FarStart
    Table.FarStart = FarStart
    local FarEnd
    local Number5 = tonumber( Reverb and Reverb.FarEnd )
    FarEnd = if Number5 then Number5 else Table12.FarEnd
    Table.FarEnd = FarEnd
    local RollMin
    local Number6 = tonumber( Reverb and Reverb.RollMin )
    RollMin = if Number6 then Number6 else Table12.RollMin
    Table.RollMin = RollMin
    local RollMax
    local Number7 = tonumber( Reverb and Reverb.RollMax )
    RollMax = if Number7 then Number7 else Table12.RollMax
    Table.RollMax = RollMax
    local FarRollMin
    local Number8 = tonumber( Reverb and Reverb.FarRollMin )
    FarRollMin = if Number8 then Number8 else Table12.FarRollMin
    Table.FarRollMin = FarRollMin
    local FarRollMax
    local Number9 = tonumber( Reverb and Reverb.FarRollMax )
    FarRollMax = if Number9 then Number9 else Table12.FarRollMax
    Table.FarRollMax = FarRollMax
    Table.Reverb = Reverb and Reverb.Reverb
    Table.FarReverb = Reverb and Reverb.FarReverb
    Table.Echo = Reverb and Reverb.Echo
    Table.FarEcho = Reverb and Reverb.FarEcho
    Table.Bolt = Reverb and Reverb.Bolt
    Table.BoltAt = Reverb and Reverb.BoltAt
    Table.BoltVolume = Reverb and Reverb.BoltVolume
    Table13[ Text4 ] = Table
    return Table
end

local Class5 = setmetatable( { }, { __mode = "k" } )

local function KeepOk( List, List2, List3 )
    if type( List ) == "table" then
        local Table2
        local Table = { }
        Table2 = type( List2 ) == "table" and { } or List2
        local Table3
        Table3 = type( List3 ) == "table" and { } or List3
        local Value1 = nil

        for Key, Value in List, nil, nil do
            local Flag2
            Flag2 = if type( Value ) == "number" then not Table6[ Value ] else false

            if Flag2 then
                table.insert( Table, Value )

                if type( List2 ) == "table" then
                    table.insert( Table2, List2[ Key ] or 0 )
                end
                if type( List3 ) == "table" then
                    table.insert( Table3, List3[ Key ] or 1 )
                end
            end
        end
        if #Table == 0 then
            return nil
        end
        return Table, Table2, Table3
    else
        local Flag
        Flag = if type( List ) == "number" then not Table6[ List ] else false

        if Flag then
            return List, List2, List3
        end
        return nil
    end
end

local function BoltOk( List )
    if type( List ) == "number" then
        local Flag = if type( List ) == "number" then not Table6[ List ] else false
        local Flag2 = Flag and List or false
        return Flag2
    end
    if type( List ) ~= "table" then
        return false
    end

    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        if type( Value ) == "table" then
            local Flag3
            local Id = Value.Id
            Flag3 = if type( Id ) == "number" then not Table6[ Id ] else false

            if Flag3 then
                table.insert( Table, Value )
            end
        end
    end

    local Table2 = #Table > 0 and Table or false
    return Table2
end

local function UsableSet( Key )
    if not Key then
        return nil
    end
    if next( Table6 ) == nil then
        return Key
    end

    local Entry = Class5[ Key ]

    if Entry and Entry.gen == Number then
        return Entry.set or nil
    end

    local Class
    local Value1, Value2, Value3 = KeepOk( Key.Single, Key.SingleStart, Key.SingleGain )

    if Value1 then
        local Flag
        local Value4, Value5, Value6 = KeepOk( Key.FarSingle, Key.FarSingleStart, Key.FarSingleGain )
        local Table = {
            Single = Value1,
            SingleStart = Value2,
            SingleGain = Value3,
            FarSingle = Value4 or false,
            FarSingleStart = Value5,
            FarSingleGain = Value6
        }
        local Final = Key.Final
        Flag = if type( Final ) == "number" then not Table6[ Final ] else false
        local Final2 = Flag and Key.Final or false
        local Flag2
        Table.Final = Final2
        local FarFinal = Key.FarFinal
        Flag2 = if type( FarFinal ) == "number" then not Table6[ FarFinal ] else false
        local FarFinal2 = Flag2 and Key.FarFinal or false
        Table.FarFinal = FarFinal2
        Table.Bolt = BoltOk( Key.Bolt )
        Class = setmetatable( Table, { __index = Key } )
    else
        Class = false
    end

    Class5[ Key ] = { gen = Number, set = Class }
    return Class or nil
end

local Class6 = setmetatable( { }, { __mode = "k" } )

local function FallbackSuppressed( SuppressedName )
    if not SuppressedName or not not Table6[ 2743868563 ] then
        return nil
    end

    local Entry2
    local Entry = Class6[ SuppressedName ]

    if Entry then
        Entry2 = Entry
    else
        local Class = setmetatable( {
            Single = 2743868563,
            SingleStart = 0,
            SingleGain = 1,
            FarSingle = 2743868563,
            FarSingleStart = 0,
            FarSingleGain = 1,
            Final = false,
            FarFinal = false,
            TailVolume = false,
            Pitch = 1,
            Repli = true
        }, { __index = SuppressedName } )
        Class6[ SuppressedName ] = Class
        Entry2 = Class
    end

    return ( UsableSet( Entry2 ) )
end

local function ResolveSet( Argument1, Reverb, Argument3, Argument4, Argument5 )
    if not Argument4 or not Reverb then
        if Reverb and Reverb.Sounds and Argument3 then
            local Suppressed4
            local Suppressed3 = ( Reverb and Reverb.Sounds ).Suppressed

            if Suppressed3 then
                if not getmetatable( Suppressed3 ) then
                    setmetatable( Suppressed3, { __index = Reverb and Reverb.Sounds } )
                end

                Suppressed4 = Suppressed3
            else
                Suppressed4 = nil
            end
            if Suppressed4 then
                local Value2
                local UsableSet2 = UsableSet( Suppressed4 )
                Value2 = if UsableSet2 then UsableSet2 else FallbackSuppressed( Suppressed4 )
                return Value2
            end
            if not Argument5 then
                return nil
            end
        end

        return ( UsableSet( Reverb and Reverb.Sounds ) )
    end
    local Suppressed2

    if not ( Reverb and Reverb.Sounds ) or not Argument3 then
        Suppressed2 = Reverb and Reverb.Sounds
    else
        local Suppressed = ( Reverb and Reverb.Sounds ).Suppressed

        if Suppressed then
            if not getmetatable( Suppressed ) then
                setmetatable( Suppressed, { __index = Reverb and Reverb.Sounds } )
            end

            Suppressed2 = Suppressed
        else
            Suppressed2 = nil
        end
        if not Suppressed2 then
            Suppressed2 = Reverb and Reverb.Sounds
        end
    end

    return ( UsableSet( ( CustomSet( Argument1, Suppressed2, Argument4, Argument3 ) ) ) )
end

local function BoltList( List, Parent, Argument3, Argument4, SoundGroup )
    local Value1
    local Table = { list = true }
    Value1 = nil

    for Key, Value in List, nil, nil do
        Table[ Key ] = {
            s = NewSound( Value.Id, Parent, Argument3, false, Argument4, SoundGroup ),
            at = Value.At or 0,
            vol = Value.Volume
        }
    end

    return Table
end

local Number2 = 0

local function EachSound( List, Callback, Amount )
    if Amount > 4 then
        return
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        if typeof( Value ) == "Instance" then
            if Value:IsA( "Sound" ) then
                Callback( Value )
            end
        elseif type( Value ) == "table" then
            EachSound( Value, Callback, Amount + 1 )
        end
    end
end

local function SharedPoolFor( Weapon, Argument2, Argument3, SoundGroup, SoundGroup2, Text, Text2 )
    if Number2 ~= Number then
        local Value1
        Number2 = Number
        Value1 = nil

        for Key, Value in Table11, nil, nil do
            EachSound( Value, function( Key )
                local Entry = Class4[ Key ]

                if Entry then
                    Entry:Destroy( )
                    return
                end
                Key:Destroy( )
                return
            end, 0 )
        end

        table.clear( Table11 )
    end

    local Text4
    local Text3 = tostring( Weapon )
    Text4 = not Argument3 and "" or "|S"
    local Text5 = Text and "|T" .. Text or ""
    local Text6 = Text2 and "|C" .. Text2 or ""
    local Text7 = Text3 .. Text4 .. Text5 .. Text6
    local Entry = Table11[ Text7 ]

    if Entry then
        return Entry
    end

    local Tail
    local Single = Argument2.Single
    local SingleStart = Argument2.SingleStart
    local Variants2 = Variants( Single, SingleStart, Argument2.SingleGain, Table10, Argument2, false, false, SoundGroup )
    local Pool2 = Pool( Argument2.Final, 4, Table10, Argument2, false, false, SoundGroup )
    local FarSingle = Argument2.FarSingle
    local FarSingleStart = Argument2.FarSingleStart
    local Table = {
        single = Variants2,
        final = Pool2,
        farSingle = Variants( FarSingle, FarSingleStart, Argument2.FarSingleGain, Table10, Argument2, true, false, SoundGroup2 ),
        farFinal = Pool( Argument2.FarFinal, 4, Table10, Argument2, true, false, SoundGroup2 )
    }

    if Argument2.TailVolume then
        local Pool3 = Pool( Argument2.Final, 12, Table10, Argument2, false, false, SoundGroup )

        if Pool3 then
            Tail = Pool3
        else
            Tail = nil
        end
    else
        Tail = nil
    end

    local FarTail
    Table.tail = Tail

    if Argument2.TailVolume then
        local Pool4 = Pool( Argument2.FarFinal, 12, Table10, Argument2, true, false, SoundGroup2 )

        if Pool4 then
            FarTail = Pool4
        else
            FarTail = nil
        end
    else
        FarTail = nil
    end

    local Value6
    Table.farTail = FarTail
    Table11[ Text7 ] = Table
    local Table2 = { }
    Value6 = nil

    for Value7 in Class4, nil, nil do
        if Value7.Parent and not Value7.IsLoaded then
            table.insert( Table2, Value7 )
        end
    end

    task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table2 )
    return Table
end

local function StateFor( ForName, Parent, Argument3, Argument4 )
    local Flag2 = Argument4 == true and true or false
    local Result2

    if Table.CustomShot then
        local Success, Result = pcall( Table.CustomShot, ForName )

        if not Success or type( Result ) ~= "table" then
            Result2 = nil
        else
            local Flag
            local Sound = Result.Sound
            Flag = if type( Sound ) == "number" then not Table6[ Sound ] else false

            if Flag then
                Result2 = Result
            else
                Result2 = nil
            end
        end
    else
        Result2 = nil
    end
    if Result2 and not Argument3 and Table.HearOthersCustom then
        local Success2, Result3 = pcall( Table.HearOthersCustom )

        if Success2 and Result3 == false then
            Result2 = nil
        end
    end

    local Text4

    if Result2 then
        local Text = tostring( Result2.id )

        if Text then
            Text4 = Text
        else
            Text4 = nil
        end
    else
        Text4 = nil
    end

    local SuppressorTone

    if not Flag2 or not ForName:GetAttribute( "SuppressorTone" ) then
        SuppressorTone = nil
    else
        SuppressorTone = ForName:GetAttribute( "SuppressorTone" )
    end
    if Result2 then
        local Text2 = if Flag2 then "Silenced" else nil
        SuppressorTone = Text2
    elseif not Table9[ SuppressorTone ] and Table.SkinTone then
        Success3, SuppressorTone = pcall( Table.SkinTone, ForName )
    end

    local Text3

    if not Table9[ SuppressorTone ] or not SuppressorTone then
        Text3 = nil
    else
        Text3 = SuppressorTone
    end

    local Entry = Table4[ ForName ]

    if Entry and Entry.parent.Parent and Entry.silenced == Flag2 and Entry.toneIn == Text3 and Entry.custom == Text4 and Entry.gen == Number then
        return Entry
    end
    if Entry then
        Table4[ ForName ] = nil
        Entry.parent:Destroy( )
    end

    local Weapon = ForName:GetAttribute( "Weapon" )
    local Entry2 = WeaponData[ Weapon or "" ]
    local Set = ResolveSet( Weapon, Entry2, Flag2, Result2 )

    if not Set or not Set.Single then
        return nil
    end
    if Set.Repli then
        Text3 = nil
    end

    local Folder2

    if Argument3 then
        local FolderInner = Instance.new( "Folder" )
        FolderInner.Name = ForName.Name
        FolderInner.Parent = Folder
        Folder2 = FolderInner
    else
        local Attachment = Instance.new( "Attachment" )
        Attachment.Name = "GunAudio"
        Attachment.Parent = Parent
        Folder2 = Attachment
    end

    local Value7
    local GroupFor2 = GroupFor( Weapon, false, Set, Text3 )
    local GroupFor3 = GroupFor( Weapon, true, Set, Text3 )

    if Text3 then
        local GroupFor4 = GroupFor( Weapon, false, Set )

        if GroupFor4 then
            Value7 = GroupFor4
        else
            Value7 = GroupFor2
        end
    else
        Value7 = GroupFor2
    end

    local Value6

    if Argument3 then
        Value6 = nil
    else
        local SharedPoolFor2 = SharedPoolFor( Weapon, Set, Flag2, GroupFor2, GroupFor3, Text3, Text4 )

        if SharedPoolFor2 then
            Value6 = SharedPoolFor2
        else
            Value6 = nil
        end
    end

    local Table4Inner

    if Value6 then
        Table4Inner = {
            S = Set,
            isLocal = false,
            parent = Folder2,
            silenced = Flag2,
            tone = Text3,
            toneIn = nil,
            custom = Text4,
            gen = Number,
            shared = true,
            preloaded = true,
            interval = 60 / Entry2.Fire.RPM,
            single = Value6.single,
            final = Value6.final,
            farSingle = Value6.farSingle,
            farFinal = Value6.farFinal,
            tail = Value6.tail,
            farTail = Value6.farTail,
            idx = 0,
            fidx = 0,
            tidx = 0,
            burst = 0,
            drift = 0
        }
    else
        local Bolt
        local TableInner = {
            S = Set,
            isLocal = Argument3,
            parent = Folder2,
            silenced = Flag2,
            tone = Text3,
            toneIn = nil,
            custom = Text4,
            gen = Number,
            idx = 0,
            fidx = 0,
            tidx = 0,
            burst = 0,
            drift = 0
        }

        if Set.Bolt then
            if type( Set.Bolt ) == "table" then
                local BoltList2 = BoltList( Set.Bolt, Folder2, Set, Argument3, Value7 )

                if BoltList2 then
                    Bolt = BoltList2
                else
                    local Sound2 = NewSound( Set.Bolt, Folder2, Set, false, Argument3, Value7 )

                    if Sound2 then
                        Bolt = Sound2
                    else
                        Bolt = nil
                    end
                end
            else
                local Sound2 = NewSound( Set.Bolt, Folder2, Set, false, Argument3, Value7 )

                if Sound2 then
                    Bolt = Sound2
                else
                    Bolt = nil
                end
            end
        else
            Bolt = nil
        end

        local Final2
        TableInner.bolt = Bolt
        TableInner.interval = 60 / Entry2.Fire.RPM
        local Single = Set.Single
        local SingleStart = Set.SingleStart
        TableInner.single = Variants( Single, SingleStart, Set.SingleGain, Folder2, Set, false, Argument3, GroupFor2 )
        local Final = Set.Final

        if Final then
            local Table2 = { }
            Table2[ 1 ] = NewSound( Final, Folder2, Set, false, Argument3, GroupFor2 )
            Table2[ 2 ] = NewSound( Final, Folder2, Set, false, Argument3, GroupFor2 )
            Final2 = Table2
        else
            Final2 = nil
        end

        local FarSingle2
        TableInner.final = Final2

        if Argument3 then
            FarSingle2 = nil
        else
            local FarSingle = Set.FarSingle
            local FarSingleStart = Set.FarSingleStart
            local Variants2 = Variants( FarSingle, FarSingleStart, Set.FarSingleGain, Folder2, Set, true, false, GroupFor3 )

            if Variants2 then
                FarSingle2 = Variants2
            else
                FarSingle2 = nil
            end
        end

        local FarFinal2
        TableInner.farSingle = FarSingle2

        if Argument3 then
            FarFinal2 = nil
        else
            local FarFinal = Set.FarFinal

            if FarFinal then
                local Table3 = { }
                Table3[ 1 ] = NewSound( FarFinal, Folder2, Set, true, false, GroupFor3 )
                Table3[ 2 ] = NewSound( FarFinal, Folder2, Set, true, false, GroupFor3 )
                FarFinal2 = Table3
            else
                FarFinal2 = nil
            end
            if not FarFinal2 then
                FarFinal2 = nil
            end
        end

        local Tail
        TableInner.farFinal = FarFinal2

        if Set.TailVolume then
            local Pool2 = Pool( Set.Final, 8, Folder2, Set, false, Argument3, GroupFor2 )

            if Pool2 then
                Tail = Pool2
            else
                Tail = nil
            end
        else
            Tail = nil
        end

        local FarTail
        TableInner.tail = Tail

        if not Set.TailVolume or Argument3 then
            FarTail = nil
        else
            local Pool3 = Pool( Set.FarFinal, 8, Folder2, Set, true, false, GroupFor3 )

            if Pool3 then
                FarTail = Pool3
            else
                FarTail = nil
            end
        end

        TableInner.farTail = FarTail
        Table4Inner = TableInner
    end

    Table4[ ForName ] = Table4Inner
    local Connect = nil
    Connect = ForName.AncestryChanged:Connect( function()
        if ForName:IsDescendantOf( game ) then
            return
        end

        Connect:Disconnect( )

        if Table4[ ForName ] == Table4Inner then
            Table4[ ForName ] = nil
        end

        Folder2:Destroy( )
    end )
    return Table4Inner
end

local function Weights( Argument1 )
    if Argument1.isLocal or not Argument1.farSingle then
        return 1, 0
    end
    local WorldPosition = Argument1.parent.WorldPosition
    local Clamp = math.clamp( ( ( CurrentCamera.CFrame.Position - WorldPosition ).Magnitude - Argument1.S.FarStart ) / ( Argument1.S.FarEnd - Argument1.S.FarStart ), 0, 1 )
    return math.cos( Clamp * 3.141592653589793 / 2 ), ( math.sin( Clamp * 3.141592653589793 / 2 ) )
end

local function Play( Track, PlaybackSpeed, Amount, EqVar )
    local EQ
    Track.PlaybackSpeed = PlaybackSpeed
    Track.TimePosition = Amount or 0
    local Entry = Class[ Track ]

    if Entry then
        EQ = Entry
    else
        EQ = Track:FindFirstChild( "EQ" )
    end
    if EQ then
        local Number = EqVar or 0
        EQ.LowGain = Random2:NextNumber( -Number, Number )
        EQ.MidGain = Random2:NextNumber( -Number, Number ) * 0.7
        EQ.HighGain = Random2:NextNumber( -Number * 1.3, Number * 0.6 )
    end

    Track:Play( )
end

local Class7 = setmetatable( { }, { __mode = "k" } )

local function TweenVolume( VolumeName, Argument2, Argument3 )
    local Create = TweenService:Create( VolumeName, Argument2, { Volume = Argument3 } )
    Class7[ VolumeName ] = Create
    Create:Play( )
end

local function Envelope( Key, Volume, Amount, Argument4, Argument5 )
    local Entry = ( Class2[ Key ] or 0 ) + 1
    Class2[ Key ] = Entry

    if Amount > 0 then
        Key.Volume = 0
        local Create = TweenService:Create( Key, TweenInfo.new( Amount, Enum.EasingStyle.Sine, Enum.EasingDirection.Out ), { Volume = Volume } )
        Class7[ Key ] = Create
        Create:Play( )
    else
        local Entry2 = Class7[ Key ]

        if Entry2 then
            Class7[ Key ] = nil
            Entry2:Cancel( )
        end

        Key.Volume = Volume
    end
    if Argument4 then
        task.delay( math.max( 0, Argument4 ), function()
            if Class2[ Key ] == Entry and Key.IsPlaying then
                local Create = TweenService:Create( Key, TweenInfo.new( Argument5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut ), { Volume = 0 } )
                Class7[ Key ] = Create
                Create:Play( )
            end
        end )
    end
end

local function FadeOutNow( Track, Argument2 )
    Class2[ Track ] = ( Class2[ Track ] or 0 ) + 1

    if Track.IsPlaying then
        local Create = TweenService:Create( Track, Argument2, { Volume = 0 } )
        Class7[ Track ] = Create
        Create:Play( )
    end
end

function Table.Shot( ForName, Parent, Argument3, Argument4 )
    local StateFor2

    if ForName then
        if Parent then
            StateFor2 = StateFor( ForName, Parent, Argument3, Argument4 )
        else
            Value1 = Parent
        end
    else
        Value1 = ForName
    end
    if not Value1 then
        return false
    end

    local S = Value1.S

    if not Value1.pending then
        Value1.burst = 0
        Value1.drift = 0
    end

    local LastSpeed
    Value1.burst = Value1.burst + 1
    local Drift = Value1.drift * 0.6 + Random2:NextNumber( -S.PitchVar, S.PitchVar ) * 0.6
    local Amount = -S.PitchVar
    Value1.drift = math.clamp( Drift, Amount, S.PitchVar )
    local Drift2 = 1 + Value1.drift + Random2:NextNumber( -S.PitchVar, S.PitchVar ) * 0.4

    if not Value1.lastSpeed or not ( math.abs( Drift2 - Value1.lastSpeed ) < S.PitchVar * 0.25 ) then
        LastSpeed = Drift2
    else
        local Number = not ( Value1.lastSpeed <= Drift2 ) and -1 or 1
        LastSpeed = Drift2 + Number * S.PitchVar * 0.3
    end

    local FirstShotBoost2
    Value1.lastSpeed = LastSpeed
    local NextNumber = 1 + Random2:NextNumber( -S.VolVar, S.VolVar )

    if Value1.burst == 1 then
        local FirstShotBoost = S.FirstShotBoost

        if FirstShotBoost then
            FirstShotBoost2 = FirstShotBoost
        else
            FirstShotBoost2 = 1
        end
    else
        FirstShotBoost2 = 1
    end

    local Value7, Value8, Value9
    local NextNumber2 = NextNumber * FirstShotBoost2
    local EqVar = S.EqVar or 0
    local Value2, Value3 = Weights( Value1 )
    local Value4, Value5, Value6 = NextVoice( Value1.single )

    if Value1.farSingle then
        Value7, Value8, Value9 = NextVoice( Value1.farSingle )
    else
        Value7 = nil
        Value9 = nil
        Value8 = nil
    end
    if #Value1.single == 1 then
        local SoloLast
        local SoloPitchVar = S.SoloPitchVar or 0.03

        while true do
            SoloLast = 1 + Random2:NextNumber( -SoloPitchVar, SoloPitchVar )

            if not Value1.soloLast then
                break
            end

            local Abs = math.abs( SoloLast - Value1.soloLast )

            if SoloPitchVar * 0.5 <= Abs then
                break
            end
        end

        Value1.soloLast = SoloLast
        Value1.lastSpeed = SoloLast
        LastSpeed = SoloLast
    end

    local Speed2
    local Pitch = S.Pitch or 1

    if Value1.tone then
        local Speed = Table9[ Value1.tone ].speed

        if Speed then
            Speed2 = Speed
        else
            Speed2 = 1
        end
    else
        Speed2 = 1
    end

    local LocalGain2
    local Drift3 = LastSpeed * ( Pitch * Speed2 )
    local ShotFade = S.ShotFade or 0.03

    local function Shot( Track, Volume, Amount )
        if Track then
            if Value1.shared then
                Class3[ Track ] = Value1
                local Entry = Class4[ Track ]

                if Entry then
                    Entry.WorldPosition = Value1.parent.WorldPosition
                end
            end
        end

        Play( Track, Drift3, Amount, EqVar )

        if Track.TimeLength > 0 then
            local TimeLength = ( Track.TimeLength - Amount - ShotFade ) / Drift3
            local Captured = ShotFade / Drift3
            local Entry2 = ( Class2[ Track ] or 0 ) + 1
            Class2[ Track ] = Entry2
            local Entry3 = Class7[ Track ]

            if Entry3 then
                Class7[ Track ] = nil
                Entry3:Cancel( )
            end

            Track.Volume = Volume

            if TimeLength then
                task.delay( math.max( 0, TimeLength ), function()
                    if Class2[ Track ] == Entry2 and Track.IsPlaying then
                        local Create = TweenService:Create( Track, TweenInfo.new( Captured, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut ), { Volume = 0 } )
                        Class7[ Track ] = Create
                        Create:Play( )
                    end
                end )
                return
            end
        else
            Class2[ Track ] = ( Class2[ Track ] or 0 ) + 1
            local Entry4 = Class7[ Track ]

            if Entry4 then
                Class7[ Track ] = nil
                Entry4:Cancel( )
            end

            Track.Volume = Volume
        end
    end

    if Value1.isLocal then
        local LocalGain = S.LocalGain

        if LocalGain then
            LocalGain2 = LocalGain
        else
            LocalGain2 = 1
        end
    else
        LocalGain2 = 1
    end
    if Value2 > 0.01 then
        Shot( Value4, S.Volume * NextNumber2 * Value6 * Value2 * LocalGain2, Value5 )
    end
    if Value7 and Value3 > 0.01 then
        Shot( Value7, S.FarVolume * NextNumber2 * Value9 * Value3, Value8 )
    end

    local Table2

    if Value1.tail then
        if Value1.shared then
            local Tail = Value1.tail
            Tail.rot = ( Value1.tail.rot or 0 ) % #Value1.tail + 1
            Value1.tidx = Value1.tail.rot
        else
            Value1.tidx = Value1.tidx % 8 + 1
        end

        local Table = { }

        local function Tail2( Track, Argument2, Amount )
            if Track then
                if Value1.shared then
                    Class3[ Track ] = Value1
                    local Entry = Class4[ Track ]

                    if Entry then
                        Entry.WorldPosition = Value1.parent.WorldPosition
                    end
                end
            end

            Play( Track, Drift3, Amount or 0, EqVar )
            Track.Volume = 0
            local Entry2 = ( Class2[ Track ] or 0 ) + 1
            Class2[ Track ] = Entry2
            task.delay( ( S.TailDelay or 0.07 ) / Drift3, function()
                if Class2[ Track ] == Entry2 then
                    local Create = TweenService:Create( Track, TweenInfo.new( S.TailFadeIn or 0.03, Enum.EasingStyle.Sine ), { Volume = Argument2 } )
                    Class7[ Track ] = Create
                    Create:Play( )
                    task.delay( S.TailHold or 0.25, function()
                        if Class2[ Track ] == Entry2 then
                            local Create = TweenService:Create( Track, TweenInfo.new( S.TailFadeOut or 0.4, Enum.EasingStyle.Sine ), { Volume = 0 } )
                            Class7[ Track ] = Create
                            Create:Play( )
                            return
                        end
                        return
                    end )
                    return
                end
                return
            end )
            table.insert( Table, { s = Track, peak = Argument2 } )
        end

        local TailVolume = ( S.TailVolume or 1 ) * NextNumber2

        if Value2 > 0.01 then
            Tail2( Value1.tail[ Value1.tidx ], TailVolume * S.Volume * Value2 * LocalGain2, S.FinalStart )
        end
        if not Value1.farTail or not ( Value3 > 0.01 ) then
            Table2 = Table
        else
            Tail2( Value1.farTail[ Value1.tidx ], TailVolume * S.FarVolume * Value3, S.FarFinalStart )
            Table2 = Table
        end
    else
        Table2 = nil
    end

    Value1.last = {
        near = Value4,
        far = Value7,
        t = os.clock( ),
        speed = Drift3,
        vol = NextNumber2,
        tails = Table2
    }
    Value1.pending = true
    return true
end

local function Finish( Argument1 )
    Argument1.pending = false
    local Last = Argument1.last

    if not Last then
        return
    end
    if Last.tails then
        local Value1
        local TailDelay = ( Argument1.S.TailDelay or 0.07 ) / Last.speed
        local Table = { }
        local Tails = Last.tails
        Value1 = nil

        for Key, Value in Tails, nil, nil do
            local NotShared4
            Table[ Value.s ] = true
            local S = Value.s
            local NotShared3 = not Argument1.shared

            if NotShared3 then
                NotShared4 = NotShared3
            elseif Class3[ S ] == Argument1 then
                NotShared4 = true
            else
                NotShared4 = false
            end
            if NotShared4 then
                local Entry = ( Class2[ Value.s ] or 0 ) + 1
                Class2[ Value.s ] = Entry
                task.delay( math.max( 0, Last.t + TailDelay - os.clock( ) ), function()
                    if Class2[ Value.s ] == Entry then
                        local S = Value.s
                        local TweenInfo2 = TweenInfo.new( Argument1.S.TailFadeIn or 0.03, Enum.EasingStyle.Sine )
                        local Create = TweenService:Create( S, TweenInfo2, { Volume = Value.peak } )
                        Class7[ S ] = Create
                        Create:Play( )
                    end
                end )
            end
        end

        local Value2
        local Table2 = { Argument1.tail, Argument1.farTail }
        Value2 = nil

        for Key2, Value3 in Table2, nil, nil do
            local Value4 = nil

            for Key3, Value5 in Value3, nil, nil do
                if not Table[ Value5 ] then
                    local NotShared2
                    local NotShared = not Argument1.shared

                    if NotShared then
                        NotShared2 = NotShared
                    elseif Class3[ Value5 ] == Argument1 then
                        NotShared2 = true
                    else
                        NotShared2 = false
                    end
                    if NotShared2 then
                        Class2[ Value5 ] = ( Class2[ Value5 ] or 0 ) + 1

                        if Value5.IsPlaying then
                            local Create = TweenService:Create( Value5, TweenInfo3, { Volume = 0 } )
                            Class7[ Value5 ] = Create
                            Create:Play( )
                        end
                    end
                end
            end
        end

        Argument1.last = nil
        return
    end
    if not Argument1.final then
        return
    end

    local Clock = ( os.clock( ) - Last.t ) * Last.speed
    local Value6, Value7 = Weights( Argument1 )

    if Argument1.shared then
        local Final = Argument1.final
        Final.rot = ( Argument1.final.rot or 0 ) % #Argument1.final + 1
        Argument1.fidx = Argument1.final.rot
    else
        Argument1.fidx = Argument1.fidx % 2 + 1
    end

    local FarFinal2

    local function Swap( Track, Track2, Volume, Amount )
        local Number = ( Amount or 0 ) + Clock

        if not Track2 or Volume <= 0.01 then
            return
        end

        local TimeLength = Track2.TimeLength > 0 and Track2.TimeLength or 2

        if TimeLength - 0.05 <= Number then
            return
        end
        if Track2 then
            if Argument1.shared then
                Class3[ Track2 ] = Argument1
                local Entry = Class4[ Track2 ]

                if Entry then
                    Entry.WorldPosition = Argument1.parent.WorldPosition
                end
            end
        end

        Play( Track2, Last.speed, Number )
        local Time = TweenInfo2.Time
        Class2[ Track2 ] = ( Class2[ Track2 ] or 0 ) + 1

        if Time > 0 then
            Track2.Volume = 0
            local Create = TweenService:Create( Track2, TweenInfo.new( Time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out ), { Volume = Volume } )
            Class7[ Track2 ] = Create
            Create:Play( )
        else
            local Entry2 = Class7[ Track2 ]

            if Entry2 then
                Class7[ Track2 ] = nil
                Entry2:Cancel( )
            end

            Track2.Volume = Volume
        end
        if Track then
            local NotShared2
            local NotShared = not Argument1.shared

            if NotShared then
                NotShared2 = NotShared
            elseif Class3[ Track ] == Argument1 then
                NotShared2 = true
            else
                NotShared2 = false
            end
            if NotShared2 then
                Class2[ Track ] = ( Class2[ Track ] or 0 ) + 1

                if Track.IsPlaying then
                    local Create2 = TweenService:Create( Track, TweenInfo2, { Volume = 0 } )
                    Class7[ Track ] = Create2
                    Create2:Play( )
                end
            end
        end
    end

    Swap( Last.near, Argument1.final[ Argument1.fidx ], Argument1.S.Volume * Last.vol * Value6, Argument1.S.FinalStart )
    local Far = Last.far
    local FarFinal = Argument1.farFinal
    FarFinal2 = if FarFinal then Argument1.farFinal[ Argument1.fidx ] else FarFinal
    Swap( Far, FarFinal2, Argument1.S.FarVolume * Last.vol * Value7, Argument1.S.FarFinalStart )
    Argument1.last = nil
    return
end

local Table14 = { }

local function ReloadSet( List )
    local Entry

    if List and WeaponData[ List:GetAttribute( "Weapon" ) or "" ] then
        local Sounds = ( List and WeaponData[ List:GetAttribute( "Weapon" ) or "" ] ).Sounds

        if Sounds then
            Entry = ( List and WeaponData[ List:GetAttribute( "Weapon" ) or "" ] ).Sounds.Reload
        else
            Entry = Sounds
        end
    else
        Entry = List and WeaponData[ List:GetAttribute( "Weapon" ) or "" ]
    end
    if not Entry then
        return nil
    end

    local Entry2 = Table14[ List ]

    if Entry2 and Entry2.folder.Parent then
        return Entry2, Entry
    end

    local Value1
    local Table = { folder = Instance.new( "Folder" ), sounds = { }, tok = 0 }
    local FolderInner = Table.folder
    FolderInner.Name = List.Name .. "_Reload"
    Table.folder.Parent = Folder
    local Weapon = List:GetAttribute( "Weapon" )
    local SoundGroup = GroupFor( Weapon, false, ( List and WeaponData[ List:GetAttribute( "Weapon" ) or "" ] ).Sounds )
    Value1 = nil

    for Key, Value in Entry, nil, nil do
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = "rbxassetid://" .. Value.Id
        Sound.Volume = Value.Volume or 1
        Sound.SoundGroup = SoundGroup
        Sound.Parent = Table.folder
        Table.sounds[ Key ] = Sound
    end

    Table14[ List ] = Table
    local Connect = nil
    Connect = List.AncestryChanged:Connect( function()
        if List:IsDescendantOf( game ) then
            return
        end

        Connect:Disconnect( )

        if Table14[ List ] == Table then
            Table14[ List ] = nil
        end

        Table.folder:Destroy( )
    end )
    task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table.sounds )
    return Table, Entry
end

function Table.Reload( List, Argument2 )
    local Value1, Value2 = ReloadSet( List )

    if not Value1 then
        return false
    end

    local ReloadTime2
    Value1.tok = Value1.tok + 1
    local Tok = Value1.tok
    local ReloadTime = WeaponData[ List:GetAttribute( "Weapon" ) ].Ammo.ReloadTime / Argument2
    ReloadTime2 = if ReloadTime > 1 then 1 else ReloadTime
    local Value3 = nil

    for Key, Value in Value2, nil, nil do
        task.delay( ( Value.At or 0 ) * Argument2, function()
            if Value1.tok == Tok then
                local Entry = Value1.sounds[ Key ]
                Entry.PlaybackSpeed = ( 1 + Random2:NextNumber( -0.02, 0.02 ) ) * ReloadTime2 * ( Value.Pitch or 1 )
                Entry.TimePosition = 0
                Entry:Play( )
                return
            end
            return
        end )
    end

    return true
end
function Table.StopReload( ReloadName )
    if not ( ReloadName and Table14[ ReloadName ] ) then
        return
    end

    local Value1
    ;( ReloadName and Table14[ ReloadName ] ).tok = ( ReloadName and Table14[ ReloadName ] ).tok + 1
    local Sounds = ( ReloadName and Table14[ ReloadName ] ).sounds
    Value1 = nil

    for Key, Value in Sounds, nil, nil do
        Value:Stop( )
    end
end
local Table15 = { }
function Table.Shell( Key )
    if Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] then
    end
    if not ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] and ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] ).Sounds ) or not ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] and ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] ).Sounds ).Shell then
        return
    end

    local Entry2
    local Entry = Table15[ Key ]

    if not Entry or not Entry[ 1 ].Parent then
        local Table = { idx = 0 }
        local SoundGroup = GroupFor( Key:GetAttribute( "Weapon" ), false, Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] and ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] ).Sounds )
        local I = 1

        for I = 1, 2 do
            local Sound = Instance.new( "Sound" )
            Sound.Name = Key.Name .. "_Shell"
            Sound.SoundId = "rbxassetid://" .. ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] and ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] ).Sounds ).Shell
            Sound.Volume = ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] and ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] ).Sounds ).ShellVolume or 1
            Sound.SoundGroup = SoundGroup
            Sound.Parent = Folder
            Table[ I ] = Sound
        end

        Table15[ Key ] = Table
        local Connect = nil
        Connect = Key.AncestryChanged:Connect( function()
            if Key:IsDescendantOf( game ) then
                return
            end

            Connect:Disconnect( )

            if Table15[ Key ] == Table then
                Table15[ Key ] = nil
            end

            Table[ 1 ]:Destroy( )
            Table[ 2 ]:Destroy( )
        end )
        Entry2 = Table
    else
        Entry2 = Entry
    end

    Entry2.idx = Entry2.idx % 2 + 1
    local Entry3 = Entry2[ Entry2.idx ]
    Entry3.PlaybackSpeed = 1 + Random2:NextNumber( -0.04, 0.04 )
    Entry3.TimePosition = ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] and ( Key and WeaponData[ Key:GetAttribute( "Weapon" ) or "" ] ).Sounds ).ShellStart or 0
    Entry3:Play( )
end
function Table.Prepare( List, Parent, Argument3, Argument4 )
    if Argument3 and List then
        ReloadSet( List )
    end

    local StateFor2

    if List then
        if Parent then
            StateFor2 = StateFor( List, Parent, Argument3, Argument4 )
        else
            Value1 = Parent
        end
    else
        Value1 = List
    end
    if not Value1 or Value1.preloaded then
        return
    end

    Value1.preloaded = true
    local Table = { }

    for Key, Value in Value1.parent:GetDescendants( ) do
        if Value:IsA( "Sound" ) then
            table.insert( Table, Value )
        end
    end

    task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table )
end
function Table.Bolt( ForName, Parent, Argument3, Argument4, Argument5 )
    local StateFor2

    if ForName then
        if Parent then
            StateFor2 = StateFor( ForName, Parent, Argument3, Argument4 )
        else
            Value1 = Parent
        end
    else
        Value1 = ForName
    end
    if not Value1 or not Value1.bolt then
        return
    end
    if Value1.S.BoltInShot and not Argument5 then
        return
    end

    local BoltTok = ( Value1.boltTok or 0 ) + 1
    Value1.boltTok = BoltTok

    if type( Value1.bolt ) ~= "table" or not Value1.bolt.list then
        task.delay( Value1.S.BoltAt or 0, function()
            if Value1.boltTok ~= BoltTok or not Value1.parent.Parent then
                return
            end

            local EQ
            local Bolt = Value1.bolt
            local Entry = Class[ Bolt ]

            if Entry then
                EQ = Entry
            else
                EQ = Bolt:FindFirstChild( "EQ" )
            end
            if EQ then
                EQ.LowGain = 0
                EQ.MidGain = 0
                EQ.HighGain = 0
            end

            Bolt.PlaybackSpeed = 1
            Bolt.TimePosition = 0
            Bolt.Volume = Value1.S.BoltVolume or 1
            Bolt:Play( )
        end )
        return
    end

    local Value2
    local Bolt = Value1.bolt
    Value2 = nil

    for Key, Value in Bolt, nil, nil do
        if type( Value ) == "table" then
            task.delay( Value.at, function()
                if Value1.boltTok ~= BoltTok or not Value1.parent.Parent then
                    return
                end

                local EQ
                local S = Value.s
                local Entry = Class[ S ]

                if Entry then
                    EQ = Entry
                else
                    EQ = S:FindFirstChild( "EQ" )
                end
                if EQ then
                    EQ.LowGain = 0
                    EQ.MidGain = 0
                    EQ.HighGain = 0
                end

                local Volume
                S.PlaybackSpeed = 1 + Random2:NextNumber( -0.02, 0.02 )
                S.TimePosition = 0
                local Vol = Value.vol

                if Vol then
                    Volume = Vol
                else
                    local BoltVolume = Value1.S.BoltVolume

                    if BoltVolume then
                        Volume = BoltVolume
                    else
                        Volume = 1
                    end
                end

                S.Volume = Volume
                S:Play( )
            end )
        end
    end
end
function Table.StopBolt( BoltName )
    if BoltName and Table4[ BoltName ] and ( BoltName and Table4[ BoltName ] ).bolt then
        ( BoltName and Table4[ BoltName ] ).boltTok = ( ( BoltName and Table4[ BoltName ] ).boltTok or 0 ) + 1

        if type( ( BoltName and Table4[ BoltName ] ).bolt ) == "table" and ( BoltName and Table4[ BoltName ] ).bolt.list then
            local Value1
            local Bolt = ( BoltName and Table4[ BoltName ] ).bolt
            Value1 = nil

            for Key, Value in Bolt, nil, nil do
                if type( Value ) == "table" then
                    Value.s:Stop( )
                end
            end

            return
        end
        ;( BoltName and Table4[ BoltName ] ).bolt:Stop( )
    end
end
function Table.Release( Key )
    if Key and Table4[ Key ] and ( Key and Table4[ Key ] ).pending then
        Finish( Key and Table4[ Key ] )
    end
end
RunService.Heartbeat:Connect( function()
    local Value1
    local Clock = os.clock( )
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        if Value.pending then
            local Clock2 = Clock - Value.last.t

            if Value.interval * 1.5 < Clock2 then
                Finish( Value )
            end
        end
    end
end )
local Table16 = { }
function Table.PreviewShot( ShotName, Argument2, Argument3, Argument4 )
    local Entry = WeaponData[ ShotName or "" ]

    if not Entry then
        return false
    end

    local Flag2 = Argument3 == true and true or false
    local Value1

    if type( Argument2 ) == "table" then
        local Flag
        local Sound = Argument2.Sound
        Flag = if type( Sound ) == "number" then not Table6[ Sound ] else false

        if not Flag or not Argument2 then
            Value1 = nil
        else
            Value1 = Argument2
        end
    else
        Value1 = nil
    end

    local Set = ResolveSet( ShotName, Entry, Flag2, Value1, true )

    if not Set or not Set.Single then
        return false
    end

    local Final2, Number
    local Final = Set.Final
    local TimePosition = Set.FinalStart or 0

    if Final then
        Final2 = Final
        Number = 1
    else
        local Item
        local Single = Set.Single
        local SingleStart = Set.SingleStart
        local SingleGain = Set.SingleGain
        Item = type( Single ) == "table" and Single[ 1 ] or Single
        local Item2

        if type( SingleStart ) ~= "table" or not SingleStart[ 1 ] then
            if SingleStart then
                Item2 = SingleStart
            else
                Item2 = 0
            end
        else
            Item2 = SingleStart[ 1 ]
        end

        local Item3

        if type( SingleGain ) ~= "table" or not SingleGain[ 1 ] then
            if SingleGain then
                Item3 = SingleGain
            else
                Item3 = 1
            end
        else
            Item3 = SingleGain[ 1 ]
        end

        Final2 = Item
        Number = Item3
        TimePosition = Item2
    end
    if type( Final2 ) ~= "number" then
        return false
    end

    local Entry3
    local Entry2 = Table16[ Final2 ]

    if not Entry2 or not Entry2.Parent then
        local Sound2 = Instance.new( "Sound" )
        Sound2.Name = "ShotPreview"
        Sound2.SoundId = "rbxassetid://" .. Final2
        Sound2.Parent = Folder
        Table16[ Final2 ] = Sound2
        task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, { Sound2 } )
        Entry3 = Sound2
    else
        Entry3 = Entry2
    end
    if Argument4 then
        return true
    end

    local Value3 = nil

    for Key, Value in Table16, nil, nil do
        if Value ~= Entry3 and Value.Parent then
            Value:Stop( )
        end
    end

    local Text = if not Value1 or not Flag2 then nil else "Silenced"
    Entry3.SoundGroup = GroupFor( ShotName, false, Set, Text )
    Entry3.Volume = Set.Volume * Number * ( Set.LocalGain or 1 )
    Entry3.PlaybackSpeed = Set.Pitch or 1
    Entry3.TimePosition = TimePosition
    Entry3:Play( )
    return true
end
return Table
