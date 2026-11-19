-- ReplicatedStorage.KillEffects
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = {
    SCALE_START = 130,
    SCALE_MAX = 3,
    MEMORY = 10,
    SOUND_NEAR = 20,
    SOUND_FAR = 250,
    SOUND_FAR_VOLUME = 0.2,
    VIEW_DISTANCE = 500,
    Effects = {
        Fireworks = {
            Name = "Fireworks",
            Template = "Death.Death_Fireworks",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 190, 60 ),
            Sound = 81896082959124,
            Volume = 0.1,
            SoundStart = 0.08
        },
        LaunchedFirework = {
            Name = "Launched Firework",
            Template = "Death.Death_LaunchedFirework",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 120, 60 ),
            Launch = { Height = 25, Time = 0.8, Trail = "smoke2", Ease = 3 },
            Sound = 81896082959124,
            Volume = 0.1,
            SoundStart = 0.08
        },
        Explosion = {
            Name = "Explosion",
            Template = "Death.Death_Explosion",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 110, 30 )
        },
        Red = {
            Name = "Red",
            Template = "Death.Death_Red",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 220, 30, 40 )
        },
        Aura = {
            Name = "Aura",
            Template = "Death.Death_Aura",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 150, 110, 255 )
        },
        Water = {
            Name = "Water",
            Template = "Death.Death_Water",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 60, 160, 255 )
        },
        Hearts = {
            Name = "Hearts",
            Template = "Death.Death_Hearts",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 90, 160 )
        },
        Butterflies = {
            Name = "Butterflies",
            Template = "Death.Death_Butterflies",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 120, 220, 255 )
        },
        Rainbow = {
            Name = "Rainbow",
            Template = "Death.Death_Rainbow",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 220, 80 )
        },
        Cash = {
            Name = "Cash",
            Template = "Death.Death_Cash",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 80, 220, 110 )
        },
        Fire = {
            Name = "Fire",
            Template = "Death.Death_Fire",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 140, 30 )
        },
        Stars = {
            Name = "Stars",
            Template = "Death.Death_Stars",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 240, 150 )
        },
        Halloween = {
            Name = "Halloween",
            Template = "Death.Death_Halloween",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 255, 120, 20 ),
            Sound = 138922654038066,
            Volume = 2,
            SoundNear = 200,
            SoundFar = 600,
            SoundFarVolume = 0.7
        },
        DarkMatter = {
            Name = "Dark Matter",
            Template = "Death.Death_DarkMatter",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 120, 60, 200 ),
            Sound = 131794614393147,
            Volume = 1.2,
            SoundNear = 200,
            SoundFar = 600,
            SoundFarVolume = 0.7
        },
        Data = {
            Name = "Data",
            Template = "Death.Death_Data",
            Offset = Vector3.new( 0, 1, 0 ),
            PassId = 0,
            Color = Color3.fromRGB( 76, 193, 26 ),
            Sound = 76681986607556,
            Volume = 1,
            SoundNear = 200,
            SoundFar = 600,
            SoundFarVolume = 0.7,
            MinScale = 1.25,
            SizeMul = 1.4
        }
    },
    Order = {
        "Data",
        "DarkMatter",
        "Halloween",
        "Fireworks",
        "LaunchedFirework",
        "Explosion",
        "Red",
        "Aura",
        "Water",
        "Hearts",
        "Butterflies",
        "Rainbow",
        "Cash",
        "Fire",
        "Stars"
    }
}
local Effects = Table.Effects
Effects.Bubbles = {
    Name = "Bubbles",
    Template = "Death.Death_Bubbles",
    Offset = Vector3.new( 0, 1, 0 ),
    PassId = 0,
    Color = Color3.fromRGB( 90, 180, 255 ),
    Sound = 110775441546475,
    Volume = 2.5,
    SoundNear = 300,
    SoundFar = 900,
    SoundFarVolume = 1
}
table.insert( Table.Order, 1, "Bubbles" )
local Table2 = {
    Fireworks = 84773438202606,
    LaunchedFirework = 73591264541132,
    Explosion = 139836262119012,
    Red = 132015244619061,
    Aura = 139642601339239,
    Water = 101307491318526,
    Hearts = 129614121562037,
    Butterflies = 133013246339120,
    Rainbow = 107239478542185,
    Cash = 130466442298340,
    Fire = 75242263262964,
    Stars = 81335834899221,
    Halloween = 93099983715537,
    DarkMatter = 73797532167445,
    Data = 136946957816678,
    Bubbles = 113451289451494
}
Value1 = nil

for Key, Value in Table2, nil, nil do
    if Table.Effects[ Key ] then
        local Entry2 = Table.Effects[ Key ]
        Entry2.Icon = "rbxassetid://" .. Value
    end
end

local Value2
local Table3 = {
    Halloween = { 77347116210737, 16 },
    Fireworks = { 100053306228995, 13 },
    LaunchedFirework = { 124855560055476, 16 },
    Explosion = { 127053292897780, 13 },
    Red = { 105791752743168, 12 },
    Aura = { 81243593117388, 10 },
    Water = { 87978654288140, 12 },
    Hearts = { 121373557705932, 16 },
    Butterflies = { 78334918699822, 12 },
    Rainbow = { 77781862266360, 12 },
    Cash = { 123324310478608, 12 },
    Fire = { 129946269310891, 12 },
    Stars = { 86386953362637, 12 },
    DarkMatter = { 133295327959876, 13 },
    Data = { 136324070438386, 16 },
    Bubbles = { 125008596871426, 12 }
}
Value2 = nil

for Key2, Value3 in Table3, nil, nil do
    if Table.Effects[ Key2 ] then
        local Entry = Table.Effects[ Key2 ]
        Entry.Anim = {
            Id = "rbxassetid://" .. Value3[ 1 ],
            Cols = 4,
            Rows = 4,
            Size = 1024,
            Frames = Value3[ 2 ],
            Fps = 12
        }
    end
end

function Table.ScaleFor( Argument1, Argument2 )
    local MinScale = Argument2 and Argument2.MinScale or 1
    local SizeMul = Argument2 and Argument2.SizeMul or 1

    if Argument1 <= Table.SCALE_START then
        return MinScale * SizeMul
    end
    local SCALE_START = Argument1 / Table.SCALE_START
    return SizeMul * math.max( MinScale, ( math.min( SCALE_START, Table.SCALE_MAX ) ) )
end
function Table.SoundVolumeFor( Argument1, Argument2, Argument3 )
    local SoundNear = Argument3 and Argument3.SoundNear or Table.SOUND_NEAR
    local SoundFar = Argument3 and Argument3.SoundFar or Table.SOUND_FAR
    local Max = math.max( SoundFar, SoundNear + 1 )

    if Argument1 <= SoundNear then
        return 1
    end

    local Number
    local Min = math.min( ( Argument1 - SoundNear ) / ( Max - SoundNear ), 1 )

    if Argument2 then
        Number = 0
    elseif not Argument3 or not Argument3.SoundFarVolume then
        Number = Table.SOUND_FAR_VOLUME
    else
        Number = Argument3.SoundFarVolume
    end

    return 1 - Min * ( 1 - Number )
end
function Table.Scale( Object, Amount )
    if math.abs( Amount - 1 ) < 0.001 then
        return
    end

    local Value1
    local CFrame = Object.CFrame

    local function ScaleSeq( Argument1 )
        local Value1
        local Table = { }
        local Keypoints = Argument1.Keypoints
        Value1 = nil

        for Key, Value in Keypoints, nil, nil do
            Table[ Key ] = NumberSequenceKeypoint.new( Value.Time, Value.Value * Amount, Value.Envelope * Amount )
        end

        return NumberSequence.new( Table )
    end

    local Table = { Object, table.unpack( Object:GetDescendants( ) ) }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        if Value:IsA( "BasePart" ) then
            local ToObjectSpace = CFrame:ToObjectSpace( Value.CFrame )
            Value.Size = Value.Size * Amount
            Value.CFrame = CFrame * ( ToObjectSpace - ToObjectSpace.Position + ToObjectSpace.Position * Amount )
        elseif Value:IsA( "Attachment" ) then
            Value.Position = Value.Position * Amount
        elseif Value:IsA( "ParticleEmitter" ) then
            Value.Size = ScaleSeq( Value.Size )
            Value.Speed = NumberRange.new( Value.Speed.Min * Amount, Value.Speed.Max * Amount )
            Value.Acceleration = Value.Acceleration * Amount
        elseif Value:IsA( "Light" ) then
            Value.Range = math.min( Value.Range * Amount, 60 )
        elseif Value:IsA( "Beam" ) then
            Value.Width0 = Value.Width0 * Amount
            Value.Width1 = Value.Width1 * Amount
        end
    end
end
return Table
