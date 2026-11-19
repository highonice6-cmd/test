-- ReplicatedStorage.Weapons.HitAudio
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local ContentProvider = game:GetService( "ContentProvider" )
local Parent = game:GetService( "SoundService" )
local Table = { 133352425300219, 89522777820269, 135151452893270 }
local Table2 = { [ 3 ] = "Headshot2" }
local Number = 1
local Table3 = {
    [ 133352425300219 ] = 0.242,
    [ 89522777820269 ] = 0.334,
    [ 137614946252008 ] = 0.301,
    [ 96491908341370 ] = 0.217,
    [ 101692770559549 ] = 0.207,
    [ 107632158536003 ] = 0.204,
    [ 125122193693857 ] = 0.211,
    [ 93000238159604 ] = 0.185,
    [ 135151452893270 ] = 0.308,
    [ 109206817699575 ] = 0.08,
    [ 76348066013623 ] = 0.091,
    [ 124171541750960 ] = 0.053
}
local Table4 = {
    [ 109206817699575 ] = 0.198,
    [ 76348066013623 ] = 0.533,
    [ 124171541750960 ] = 0.72
}
local Table5 = {
    [ 124171541750960 ] = 0.35,
    [ 85809841444388 ] = 0.23,
    [ 114871343213734 ] = 0.19
}
local Table6 = { [ 135151452893270 ] = 1.5 }
local Table7 = {
    Flesh = {
        ids = {
            134531065386016,
            106495927763563,
            74917883697348,
            79894076019214,
            111108185993642,
            88804806838354
        },
        volume = 0.8,
        pitch = 0.08,
        cooldown = 0.045,
        voices = 3
    },
    Marker = { ids = Table, level = 0.25, pitch = 0.02, cooldown = 0.03, voices = 4 },
    Headshot2 = {
        ids = { 109206817699575 },
        level = 0.4,
        pitch = 0,
        cooldown = 0.04,
        voices = 4
    },
    WeaponSwitch = {
        ids = { 131754917437033 },
        volume = 0.5,
        pitches = { 0.9, 0.95, 1, 1.05, 1.1 },
        cooldown = 0.05,
        voices = 2
    },
    ItemSwitch = {
        ids = { 85809841444388 },
        volume = 0.18,
        pitches = { 0.9, 0.95, 1, 1.05, 1.1 },
        cooldown = 0.05,
        voices = 2
    },
    WeaponPickup = {
        ids = { 131754917437033 },
        volume = 1.25,
        pitches = { 0.9, 0.95, 1, 1.05, 1.1 },
        cooldown = 0.05,
        voices = 2
    },
    ItemPickup = {
        ids = { 85809841444388 },
        volume = 0.45,
        pitches = { 0.9, 0.95, 1, 1.05, 1.1 },
        cooldown = 0.05,
        voices = 2
    },
    InventoryDrop = {
        ids = { 114871343213734 },
        volume = 0.55,
        pitches = { 0.9, 0.95, 1, 1.05, 1.1 },
        cooldown = 0.08,
        voices = 2
    },
    SightZoom = {
        ids = { 124171541750960 },
        level = 0.15,
        pitch = 0.02,
        cooldown = 0.05,
        voices = 2
    },
    NoAmmo = {
        ids = { 76348066013623 },
        level = 0.15,
        pitch = 0.02,
        cooldown = 0.05,
        voices = 3
    },
    HeadMarker = {
        ids = { 137614946252008 },
        level = 0.25,
        pitch = 0.015,
        cooldown = 0.04,
        voices = 4
    },
    HeadshotKill = {
        ids = {
            96491908341370,
            101692770559549,
            107632158536003,
            125122193693857,
            93000238159604
        },
        level = 0.4,
        pitch = 0,
        cooldown = 0.2,
        voices = 2
    },
    Impact = {
        ids = { 79118167977532, 95100178892033, 119266053716985, 84691519701093 },
        volume = 1.1,
        pitch = 0.08,
        cooldown = 0.06,
        voices = 3
    }
}
local Parent2 = Instance.new( "Folder" )
Parent2.Name = "HitAudio"
Parent2.Parent = Parent
local Table8 = { }
local Table9 = { }
Value1 = nil

for Key, Value in Table7, nil, nil do
    local Value5
    local Table12 = { slots = { }, nextFree = 0, lastIdx = 0 }
    local Ids = Value.ids
    Value5 = nil

    for Key3, Value6 in Ids, nil, nil do
        local Table13 = { voices = { }, next = 1, start = Table5[ Value6 ] or 0 }
        local Voices = Value.voices
        local K = 1

        for K = 1, Voices do
            local Volume
            local Sound = Instance.new( "Sound" )
            Sound.Name = Key
            Sound.SoundId = "rbxassetid://" .. Value6
            local Entry = Table6[ Value6 ]

            if Entry then
                Volume = Entry
            else
                if Value.level then
                    local Entry3
                    local Level = Value.level / Table3[ Value6 ]

                    if Table4[ Value6 ] then
                        local Entry2 = 0.9 / Table4[ Value6 ]

                        if Entry2 then
                            Entry3 = Entry2
                        else
                            Entry3 = math.huge
                        end
                    else
                        Entry3 = math.huge
                    end

                    local Min = math.min( Level, Entry3 )

                    if Min then
                        Volume = Min
                        continue
                    end
                end

                Volume = Value.volume
            end

            Sound.Volume = Volume
            Sound.Parent = Parent2
            table.insert( Table13.voices, Sound )
            table.insert( Table9, Sound )
        end

        Table12.slots[ Key3 ] = Table13
    end

    Table8[ Key ] = Table12
end

local Children
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )

local function AddSet( Name, Text, Volume )
    if Table7[ Name ] then
        return Name
    end

    local Table = {
        ids = { Text },
        volume = Volume,
        pitch = 0.02,
        cooldown = 0.03,
        voices = 4
    }
    Table7[ Name ] = Table
    local Table2 = { voices = { }, next = 1, start = 0 }
    local Table3 = { }
    local Voices = Table.voices
    local I = 1

    for I = 1, Voices do
        local Sound = Instance.new( "Sound" )
        Sound.Name = Name
        Sound.SoundId = "rbxassetid://" .. Text
        Sound.Volume = Volume
        Sound.Parent = Parent2
        table.insert( Table2.voices, Sound )
        table.insert( Table9, Sound )
        table.insert( Table3, Sound )
    end

    Table8[ Name ] = { slots = { Table2 }, nextFree = 0, lastIdx = 0 }
    task.spawn( function()
        pcall( ContentProvider.PreloadAsync, ContentProvider, Table3 )
    end )
    return Name
end

local function SkinSets( Self )
    local Number = tonumber( Self:GetAttribute( "HitMarkerBody" ) )
    local Number2 = tonumber( Self:GetAttribute( "HitMarkerHead" ) )

    if not Number and not Number2 then
        return nil
    end

    local Body
    local Table = { }

    if Number then
        local Text = "SkinBody_" .. Number
        local Set = AddSet( Text, Number, tonumber( Self:GetAttribute( "HitMarkerBodyVolume" ) ) or 0.65 )

        if Set then
            Body = Set
        else
            Body = nil
        end
    else
        Body = nil
    end

    local Head
    Table.body = Body

    if Number2 then
        local Text2 = "SkinHead_" .. Number2
        local Set2 = AddSet( Text2, Number2, tonumber( Self:GetAttribute( "HitMarkerHeadVolume" ) ) or 0.78 )

        if Set2 then
            Head = Set2
        else
            Head = nil
        end
    else
        Head = nil
    end

    Table.head = Head
    return Table
end

local WeaponSkins = ReplicatedStorage:FindFirstChild( "WeaponSkins" )
Children = WeaponSkins and WeaponSkins:GetChildren( ) or { }
local Value2 = nil

for Key2, Value3 in Children, nil, nil do
    pcall( SkinSets, Value3 )
end

local Table10 = { }
local Value4 = nil

local function SkinMarkers()
    local LocalPlayer2
    local LocalPlayer = Players.LocalPlayer
    LocalPlayer2 = if LocalPlayer then LocalPlayer.Character else LocalPlayer
    local Tool

    if LocalPlayer2 then
        Tool = LocalPlayer2:FindFirstChildOfClass( "Tool" )
    else
        Tool = LocalPlayer2
    end
    if not Tool then
        return nil
    end

    local Mods = Tool:GetAttribute( "Mods" )

    if Table10.tool == Tool and Table10.mods == Mods then
        return Table10.res
    end

    Table10.tool = Tool
    Table10.mods = Mods
    Table10.res = nil

    if not Value4 then
        local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ModCatalog" ) )

        if not Success then
            return nil
        end

        Value4 = Result
    end

    local Success3
    local Success2, Result2 = pcall( Value4.Decode, Mods )

    if Success2 then
        if type( Result2 ) == "table" then
            Success3 = Value4.Skins[ Result2.Skin or "" ]
        else
            Success3 = false
        end
    else
        Success3 = Success2
    end

    local SkinFolder2

    if Success3 then
        local Model = Success3.Model

        if Model then
            local SkinFolder = Value4.SkinFolder

            if SkinFolder then
                SkinFolder2 = Value4.SkinFolder( Success3 )
            else
                SkinFolder2 = SkinFolder
            end
        else
            SkinFolder2 = Model
        end
    else
        SkinFolder2 = Success3
    end

    local Success4, Result3

    if SkinFolder2 then
        Success4, Result3 = pcall( SkinSets, SkinFolder2 )
    else
        Success4 = false
        Result3 = nil
    end

    local Res = if not Success4 or not Result3 then nil else Result3
    Table10.res = Res
    return Table10.res
end

task.spawn( function()
    pcall( ContentProvider.PreloadAsync, ContentProvider, Table9 )
end )
local Random2 = Random.new( )
local Number2 = -1
local Number3 = -1

local function PlayNow( Attribute, Argument2, Argument3 )
    local LastIdx
    local NextInteger = Random2:NextInteger( 1, #Argument2.ids )

    if not ( #Argument2.ids > 1 ) or NextInteger ~= Argument3.lastIdx then
        LastIdx = NextInteger
    else
        LastIdx = NextInteger % #Argument2.ids + 1
    end
    if Attribute == "Marker" then
        local Round = math.round( Number )
        LastIdx = math.clamp( Round, 1, #Argument2.ids )
    end

    Argument3.lastIdx = LastIdx
    local Entry = Argument3.slots[ LastIdx ]
    local Entry2 = Entry.voices[ Entry.next ]
    Entry.next = Entry.next % #Entry.voices + 1

    if Attribute == "Flesh" then
        local NumberInner
        local Volume = Argument2.volume
        NumberInner = not Table2[ math.round( Number ) ] and 1 or 0.3
        Entry2.Volume = Volume * NumberInner
    end
    if Argument2.pitches then
        local LastPitch
        local NextInteger2 = Random2:NextInteger( 1, #Argument2.pitches )
        LastPitch = if not ( #Argument2.pitches > 1 ) or NextInteger2 ~= Argument3.lastPitch then NextInteger2 else NextInteger2 % #Argument2.pitches + 1
        Argument3.lastPitch = LastPitch
        Entry2.PlaybackSpeed = Argument2.pitches[ LastPitch ]
    else
        Entry2.PlaybackSpeed = 1 + Random2:NextNumber( -Argument2.pitch, Argument2.pitch )
    end

    Entry2.TimePosition = Entry.start
    Entry2:Play( )
    Parent2:SetAttribute( Attribute, ( Parent2:GetAttribute( Attribute ) or 0 ) + 1 )
end

local Table11 = {
    SetHitmarker = function( Hitmarker )
        Number = tonumber( Hitmarker ) or 1
    end,
    Play = function( Name )
        local Entry2
        local Entry = Table2[ math.round( Number ) ]

        if Entry then
            if Name == "HeadshotKill" or Name == "HeadMarker" then
                Entry2 = Entry
            else
                Entry2 = Name
            end
        else
            Entry2 = Name
        end

        local Entry3 = Table7[ Entry2 ]
        local Entry4 = Table8[ Entry2 ]

        if not Entry3 then
            return
        end

        local LastAsk = os.clock( )

        if LastAsk - ( Entry4.lastAsk or -1 ) < 0.02 then
            return
        end

        Entry4.lastAsk = LastAsk

        if Entry2 == "HeadshotKill" or Entry2 == "Headshot2" then
            Number3 = LastAsk
        end

        local Max = math.max( LastAsk, Entry4.nextFree )

        if Max - LastAsk > 0.12 then
            return
        end

        Entry4.nextFree = Max + Entry3.cooldown

        if Max <= LastAsk then
            PlayNow( Entry2, Entry3, Entry4 )
            return
        end
        task.delay( Max - LastAsk, PlayNow, Entry2, Entry3, Entry4 )
        return
    end
}
function Table11.OnHit( Argument1, Argument2 )
    if Argument2 then
        Number2 = os.clock( )
    end

    Table11.Play( "Flesh" )
    local SkinMarkers2 = SkinMarkers( )

    if SkinMarkers2 then
        local Head2

        if Argument1.Headshot then
            local Head = SkinMarkers2.head

            if Head then
                Head2 = Head
            else
                local Body = SkinMarkers2.body

                if Body then
                    Head2 = Body
                else
                    local Body2 = SkinMarkers2.body

                    if Body2 then
                        Head2 = Body2
                    else
                        Head2 = SkinMarkers2.head
                    end
                end
            end
        else
            local Body2 = SkinMarkers2.body

            if Body2 then
                Head2 = Body2
            else
                Head2 = SkinMarkers2.head
            end
        end
        if Argument1.Headshot then
            Number3 = os.clock( )
        end
        if Head2 then
            Table11.Play( Head2 )
        end

        return
    end
    if not Argument1.Headshot or not Table2[ math.round( Number ) ] then
        Table11.Play( "Marker" )
    end
    if Argument1.Killed or Argument1.Downed then
        if Argument1.Headshot then
            Table11.Play( "HeadshotKill" )
            return
        end
    end
    if Argument1.Headshot then
        Table11.Play( "HeadMarker" )
    end

    return
end
function Table11.OnConfirm( Argument1 )
    local Clock = os.clock( )

    if Clock - Number2 > 0.35 then
        Table11.OnHit( Argument1 )
        return
    end
    if Argument1.Killed or Argument1.Downed then
        if Argument1.Headshot and Clock - Number3 > 0.5 then
            local SkinMarkers2 = SkinMarkers( )

            if SkinMarkers2 then
                Number3 = Clock

                if SkinMarkers2.head then
                    Table11.Play( SkinMarkers2.head )
                    return
                end
            else
                Table11.Play( "HeadshotKill" )
            end
        end
    end
end
function Table11.OnHurt()
    Table11.Play( "Impact" )
end
return Table11
