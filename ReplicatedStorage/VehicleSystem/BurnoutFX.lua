-- ReplicatedStorage.VehicleSystem.BurnoutFX
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local NumberSequence2 = NumberSequence.new( {
    NumberSequenceKeypoint.new( 0, 0.623 ),
    NumberSequenceKeypoint.new( 0.0465, 0.426 ),
    NumberSequenceKeypoint.new( 0.119, 0.372 ),
    NumberSequenceKeypoint.new( 0.247, 0.503 ),
    NumberSequenceKeypoint.new( 0.442, 0.76 ),
    NumberSequenceKeypoint.new( 0.698, 0.973 ),
    NumberSequenceKeypoint.new( 1, 1 )
} )
local Table2 = {
    { 0, 2.84, 0.59 },
    { 0.406, 3.55, 0.598 },
    { 0.718, 5.63, 0.608 },
    { 1, 10, 0 }
}
local ColorSequence2 = ColorSequence.new( {
    ColorSequenceKeypoint.new( 0, Color3.fromRGB( 32, 32, 35 ) ),
    ColorSequenceKeypoint.new( 0.55, Color3.fromRGB( 22, 22, 25 ) ),
    ColorSequenceKeypoint.new( 1, Color3.fromRGB( 42, 42, 44 ) )
} )
local NumberSequence3 = NumberSequence.new( {
    NumberSequenceKeypoint.new( 0, 1 ),
    NumberSequenceKeypoint.new( 0.12, 0.72 ),
    NumberSequenceKeypoint.new( 0.72, 0.78 ),
    NumberSequenceKeypoint.new( 1, 1 )
} )
local NumberSequence4 = NumberSequence.new( {
    NumberSequenceKeypoint.new( 0, 0.55 ),
    NumberSequenceKeypoint.new( 0.15, 1 ),
    NumberSequenceKeypoint.new( 0.78, 0.92 ),
    NumberSequenceKeypoint.new( 1, 0.35 )
} )
local Table3 = {
    {
        id = "rbxassetid://103758184398816",
        from = 0.15,
        to = 0.4,
        gain = 1.5
    },
    {
        id = "rbxassetid://122154921661743",
        from = 0.2,
        to = 0.4,
        gain = 0.77
    },
    {
        id = "rbxassetid://109904710521955",
        from = 0.15,
        to = 0.45,
        gain = 0.46
    }
}
local Random2 = Random.new( )
local Table = {
    State = function( Argument1 )
        local BurnFx3
        local BurnFx = Argument1.burnFx

        if BurnFx then
            BurnFx3 = BurnFx
        else
            local BurnFx2 = {
                charge = 0,
                slip = 0,
                hold = 0,
                held = false,
                intensity = 0,
                emitting = false,
                wheels = { }
            }
            Argument1.burnFx = BurnFx2
            BurnFx3 = BurnFx2
        end

        return BurnFx3
    end,
    Step = function( Argument1, Argument2, Amount, Argument4, Argument5, Argument6 )
        if Argument4 then
            Argument1.slip = 0
            Argument1.hold = 0

            if Argument5 then
                Argument1.charge = math.min( Argument1.charge + Amount / Argument2.BurnChargeTime, 1 )
            else
                Argument1.charge = math.max( Argument1.charge - Amount * 2, 0 )
            end

            Argument1.held = true
            return
        end
        if Argument1.held then
            Argument1.held = false

            if Argument5 then
                local Slip = Argument1.slip
                Argument1.slip = math.max( Slip, Argument1.charge )
                local Hold = Argument1.hold
                Argument1.hold = math.max( Hold, Argument2.BurnLaunchHold * Argument1.charge )
            end

            Argument1.charge = 0
        end
        if Argument1.hold > 0 and Argument5 then
            Argument1.hold = math.max( Argument1.hold - Amount, 0 )
            return
        end

        local Number
        Argument1.hold = 0
        local Slip2 = Argument1.slip
        Number = not Argument5 and 3 or 1
        Argument1.slip = math.max( Slip2 - Amount * Number / Argument2.BurnSlipTime, 0 )
        local Slip3 = Argument1.slip
        Argument1.slip = math.min( Slip3, 1 - math.clamp( Argument6 / Argument2.BurnSlipEndSpeed, 0, 1 ) )
        return
    end
}

local function Smooth01( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function PlanarSpeed( Part )
    local AssemblyLinearVelocity = Part.AssemblyLinearVelocity
    local UpVector = Part.CFrame.UpVector
    return ( AssemblyLinearVelocity - UpVector * AssemblyLinearVelocity:Dot( UpVector ) ).Magnitude
end

local function TireWidth( Argument1 )
    if not Argument1.tireWidth then
        local Value2, Number
        Value2 = nil
        Number = 0

        for Index, Value in ipairs( Argument1.model:GetDescendants( ) ) do
            if Value:IsA( "BasePart" ) and Number < Value.Size.X * Value.Size.Y * Value.Size.Z then
                Value2 = Value
                Number = Value.Size.X * Value.Size.Y * Value.Size.Z
            end
        end

        local Size = Value2 and Value2.Size or Vector3.new( 1, 1, 1 )
        local X = Size.X
        local Y = Size.Y
        Argument1.tireWidth = math.clamp( math.min( X, Y, Size.Z ) * 0.85, 0.65, 1.65 )
    end

    return Argument1.tireWidth
end

local function MakeSmoke( Parent, Key, Argument3 )
    local Radius = Key.radius * 2 / 2.92
    local Parent2 = Instance.new( "Attachment" )
    Parent2.Name = "BurnoutSmoke"
    Parent2.CFrame = CFrame.new( Key.center ) * CFrame.Angles( -1.5707963267948966, 0, 0 )
    local ParticleEmitter = Instance.new( "ParticleEmitter" )
    ParticleEmitter.Name = "Smoke"
    ParticleEmitter.Texture = "rbxassetid://14006773822"
    ParticleEmitter.Color = ColorSequence.new( Color3.new( 1, 1, 1 ) )
    ParticleEmitter.Transparency = NumberSequence2
    local Table = { }

    for Index, Value in ipairs( Table2 ) do
        table.insert( Table, NumberSequenceKeypoint.new( Value[ 1 ], Value[ 2 ] * Radius, Value[ 3 ] * Radius ) )
    end

    ParticleEmitter.Size = NumberSequence.new( Table )
    ParticleEmitter.Lifetime = NumberRange.new( 0.5, 1.5 )
    ParticleEmitter.Speed = NumberRange.new( 10 * Radius, 15 * Radius )
    ParticleEmitter.SpreadAngle = Vector2.new( 20, 20 )
    ParticleEmitter.Rotation = NumberRange.new( -360, 360 )
    ParticleEmitter.RotSpeed = NumberRange.new( 0, 0 )
    ParticleEmitter.Acceleration = Vector3.new( 0, 5 * Radius, 0 )
    ParticleEmitter.Drag = 0
    ParticleEmitter.LightEmission = 0.45
    ParticleEmitter.LightInfluence = 1
    ParticleEmitter.Brightness = 1
    ParticleEmitter.ZOffset = 2
    ParticleEmitter.EmissionDirection = Enum.NormalId.Bottom
    ParticleEmitter.VelocityInheritance = 0
    ParticleEmitter.LockedToPart = false
    ParticleEmitter.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
    ParticleEmitter.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ParticleEmitter.FlipbookFramerate = NumberRange.new( 1, 1 )
    ParticleEmitter.FlipbookStartRandom = true
    ParticleEmitter.Rate = 0
    ParticleEmitter.Enabled = false
    ParticleEmitter.Parent = Parent2
    local Clone = ParticleEmitter:Clone( )
    Clone.Name = "SlipSmoke"
    local Table2Inner = { }

    for Index2, Value3 in ipairs( NumberSequence2.Keypoints ) do
        table.insert( Table2Inner, NumberSequenceKeypoint.new( Value3.Time, 1 - ( 1 - Value3.Value ) * Argument3 ) )
    end

    Clone.Transparency = NumberSequence.new( Table2Inner )
    Clone.Parent = Parent2
    Parent2.Parent = Parent
    return ParticleEmitter, Clone
end

local function MakeMarks( Parent, Argument2 )
    local Attachment0 = Instance.new( "Attachment" )
    local Attachment1 = Instance.new( "Attachment" )
    Attachment0.Name = "SkidMark0"
    Attachment1.Name = "SkidMark1"
    Attachment0.Parent = Parent
    Attachment1.Parent = Parent
    local Table = { }
    local I = 1

    for I = 1, 2 do
        local Trail = Instance.new( "Trail" )
        Trail.Name = "TireSkid" .. I
        Trail.Attachment0 = Attachment0
        Trail.Attachment1 = Attachment1
        Trail.FaceCamera = false
        Trail.Color = ColorSequence2
        Trail.Transparency = NumberSequence3
        Trail.WidthScale = NumberSequence4
        Trail.Lifetime = Argument2.SkidMarkLife
        Trail.MaxLength = 320
        Trail.MinLength = 0.2
        Trail.LightEmission = 0
        Trail.LightInfluence = 0.9
        Trail.Enabled = false
        Trail.Parent = Parent
        Table[ I ] = Trail
    end

    return {
        a0 = Attachment0,
        a1 = Attachment1,
        trails = Table,
        index = 1,
        marking = false
    }
end

local function WheelFx( State, Argument2, Value )
    local Entry2
    local Entry = State.wheels[ Value ]

    if Entry then
        Entry2 = Entry
    else
        local Root = Argument2.root
        local Value1, Value2 = MakeSmoke( Root, Value, Argument2.cfg.SlipSmokeOpacity or 0.7 )
        local Table = {
            smoke = Value1,
            slipSmoke = Value2,
            marks = MakeMarks( Argument2.root, Argument2.cfg )
        }
        State.wheels[ Value ] = Table
        Entry2 = Table
    end

    return Entry2
end

local function LoopSounds( Argument1, Argument2, SoundGroup )
    if not Argument1.sounds then
        local TireSkid2
        Argument1.sounds = { }
        local TireSkid = Argument2.cfg.TireSkid
        TireSkid2 = if TireSkid then TireSkid else { }

        for Index, Value in ipairs( Table3 ) do
            local Sound = Instance.new( "Sound" )
            Sound.Name = "BurnoutLoop" .. Index
            Sound.SoundId = Value.id
            Sound.Volume = 0
            Sound.RollOffMode = Enum.RollOffMode.InverseTapered
            local RollOffMinDistance = TireSkid2.RollMin or 10
            local RollOffMaxDistance = TireSkid2.RollMax or 160
            Sound.RollOffMinDistance = RollOffMinDistance
            Sound.RollOffMaxDistance = RollOffMaxDistance
            Sound.Parent = Argument2.root
            Argument1.sounds[ Index ] = Sound
        end
    end
    for Index2, Value3 in ipairs( Argument1.sounds ) do
        if Value3.SoundGroup ~= SoundGroup then
            Value3.SoundGroup = SoundGroup
        end
    end

    return Argument1.sounds
end

local function StopGroup( Argument1 )
    if Argument1 then
        Argument1.sound:Stop( )
        Argument1.sound.Volume = 0
    end
end

local function StartGroup( Argument1, Argument2, FadeAt )
    local Table = { }
    local Table2 = { }

    for Index, Value in ipairs( Argument1.sounds ) do
        if Value.IsLoaded and Value.TimeLength > 0.15 then
            if not Argument1.mix.current or Argument1.mix.current.index ~= Index then
                if not Argument1.mix.outgoing or Argument1.mix.outgoing.index ~= Index then
                    table.insert( Table2, Index )

                    if Index ~= Argument1.mix.last then
                        table.insert( Table, Index )
                    end
                end
            end
        end
    end

    local Table3Inner = if #Table == 0 then Table2 else Table

    if #Table3Inner == 0 then
        return nil
    end
    local Last = Table3Inner[ Random2:NextInteger( 1, #Table3Inner ) ]
    local Entry = Table3[ Last ]
    local Entry2 = Argument1.sounds[ Last ]
    local To = Entry.to
    local Min = math.min( To, Entry2.TimeLength - 0.01 )
    local From = Entry.from
    local TimePosition = math.clamp( From, 0, ( math.max( Min - 0.08, 0 ) ) )
    local Max = math.max( Min - TimePosition, 0.08 )
    Entry2:Stop( )
    Entry2.TimePosition = TimePosition
    Entry2.Volume = 0
    Entry2:Play( )
    Argument1.mix.last = Last
    return {
        index = Last,
        sound = Entry2,
        volume = ( Argument2.cfg.BurnTireVolume or 0.6 ) * Entry.gain,
        endAt = FadeAt + Max,
        crossfade = math.min( 0.28, Max * 0.48 )
    }
end

local function StopSound( Argument1 )
    if Argument1.mix then
        local Current = Argument1.mix.current

        if Current then
            Current.sound:Stop( )
            Current.sound.Volume = 0
        end

        local Outgoing = Argument1.mix.outgoing

        if Outgoing then
            Outgoing.sound:Stop( )
            Outgoing.sound.Volume = 0
        end

        Argument1.mix = nil
    end
    if Argument1.fallback and Argument1.fallback.IsPlaying then
        Argument1.fallback:Stop( )
    end
end

local function FallbackSound( Argument1, Argument2, SoundGroup )
    local TireSkid = Argument2.cfg.TireSkid

    if not TireSkid or not TireSkid.Sounds or not TireSkid.Sounds[ 1 ] then
        return nil
    end

    local Fallback3
    local Fallback = Argument1.fallback

    if Fallback then
        Fallback3 = Fallback
    else
        local Fallback2 = Instance.new( "Sound" )
        Fallback2.Name = "BurnoutLoopFallback"
        Fallback2.SoundId = "rbxassetid://" .. TireSkid.Sounds[ 1 ]
        Fallback2.Looped = true
        Fallback2.Volume = 0
        Fallback2.PlaybackSpeed = 1.09
        Fallback2.RollOffMode = Enum.RollOffMode.InverseTapered
        local RollOffMinDistance = TireSkid.RollMin or 10
        local RollOffMaxDistance = TireSkid.RollMax or 160
        Fallback2.RollOffMinDistance = RollOffMinDistance
        Fallback2.RollOffMaxDistance = RollOffMaxDistance
        Fallback2.Parent = Argument2.root
        Argument1.fallback = Fallback2
        Fallback3 = Fallback2
    end
    if Fallback3.SoundGroup ~= SoundGroup then
        Fallback3.SoundGroup = SoundGroup
    end

    return Fallback3
end

local function UpdateSound( State, Argument2, Argument3, Amount, SoundGroup )
    if not State.mix then
        if Amount <= 0 then
            return
        end

        State.mix = { gain = 0, last = 0 }
    end

    local Number
    local Mix = State.mix
    LoopSounds( State, Argument2, SoundGroup )
    Number = not ( Mix.gain < Amount ) and 0.3 or 0.18
    Mix.gain = Mix.gain + ( Amount - Mix.gain ) * ( 1 - math.exp( -Argument3 / Number ) )

    if Mix.gain < 0.002 and Amount == 0 then
        if State.mix then
            local Current = State.mix.current

            if Current then
                Current.sound:Stop( )
                Current.sound.Volume = 0
            end

            local Outgoing = State.mix.outgoing

            if Outgoing then
                Outgoing.sound:Stop( )
                Outgoing.sound.Volume = 0
            end

            State.mix = nil
        end
        if State.fallback and State.fallback.IsPlaying then
            State.fallback:Stop( )
        end

        return
    end
    local FadeAt = os.clock( )

    if not Mix.current then
        Mix.current = StartGroup( State, Argument2, FadeAt )
    end

    local NotCurrent2
    local NotCurrent = not Mix.current

    if NotCurrent then
        NotCurrent2 = FallbackSound( State, Argument2, SoundGroup )
    else
        NotCurrent2 = NotCurrent
    end
    if NotCurrent2 then
        if not NotCurrent2.IsPlaying then
            NotCurrent2:Play( )
        end

        local Volume2

        if Argument2.cfg.TireSkid then
            local Volume = Argument2.cfg.TireSkid.Volume

            if Volume then
                Volume2 = Volume
            else
                Volume2 = 0.4
            end
        else
            Volume2 = 0.4
        end

        NotCurrent2.Volume = Volume2 * 1.2 * Mix.gain
        return
    end
    if State.fallback and State.fallback.IsPlaying then
        State.fallback:Stop( )
    end

    local Outgoing2 = Mix.current

    if Outgoing2 and not Mix.outgoing and Outgoing2.endAt - Outgoing2.crossfade <= FadeAt then
        local Current2 = StartGroup( State, Argument2, FadeAt )

        if Current2 then
            Mix.outgoing = Outgoing2
            Mix.current = Current2
            Mix.fadeAt = FadeAt
            local Crossfade = Outgoing2.crossfade
            local EndAt = Outgoing2.endAt - FadeAt
            Mix.fadeTime = math.max( 0.01, ( math.min( Crossfade, EndAt, Current2.crossfade ) ) )
        end
    end
    if Mix.outgoing then
        local Clamp = math.clamp( ( FadeAt - Mix.fadeAt ) / Mix.fadeTime, 0, 1 )
        local Clamp2 = Clamp * Clamp * ( 3 - Clamp * 2 )
        local Sound = Mix.outgoing.sound
        Sound.Volume = Mix.outgoing.volume * math.cos( Clamp2 * 3.141592653589793 / 2 ) * Mix.gain
        local Sound2 = Mix.current.sound
        Sound2.Volume = Mix.current.volume * math.sin( Clamp2 * 3.141592653589793 / 2 ) * Mix.gain

        if Clamp2 >= 1 then
            local Outgoing3 = Mix.outgoing

            if Outgoing3 then
                Outgoing3.sound:Stop( )
                Outgoing3.sound.Volume = 0
            end

            Mix.outgoing = nil
        end
    elseif Mix.current then
        local Sound3 = Mix.current.sound
        Sound3.Volume = Mix.current.volume * Mix.gain
    end
    if Mix.current and Mix.current.endAt <= FadeAt then
        local Current3 = Mix.current

        if Current3 then
            Current3.sound:Stop( )
            Current3.sound.Volume = 0
        end

        Mix.current = nil
    end

    return
end

local TweenService = game:GetService( "TweenService" )
local ColorSequence3 = ColorSequence.new( {
    ColorSequenceKeypoint.new( 0, Color3.fromRGB( 120, 170, 255 ) ),
    ColorSequenceKeypoint.new( 0.3, Color3.fromRGB( 255, 200, 90 ) ),
    ColorSequenceKeypoint.new( 1, Color3.fromRGB( 255, 80, 20 ) )
} )
local Table4 = { 14, 24 }
local FromRGB = Color3.fromRGB( 255, 140, 50 )
local TweenInfo2 = TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )

local function Rnd( List )
    return Random2:NextNumber( List[ 1 ], List[ 2 ] )
end

local function AxleFrame( Argument1 )
    local Number, Number2, Position, Number3, Position3
    Number = 0
    Number2 = 1
    Position = Vector3.new( 0, 0, 0 )
    Number3 = 0
    Position3 = Vector3.new( 0, 0, 0 )

    for Index, Value in ipairs( Argument1.wheels ) do
        if Value.front then
            Position3 = Position3 + Value.center
            Number3 = Number3 + 1
        else
            Number = Number + 1
            Number2 = Value.radius or Number2
            Position = Position + Value.center
        end
    end
    if Number == 0 then
        return Vector3.new( 0, 0, 0 ), Vector3.new( 0, 0, -1 ), Vector3.new( 1, 0, 0 ), Number2
    end

    local Position5
    local Position2 = Position / Number

    if Number3 > 0 then
        local Position4 = Position3 / Number3 - Position2

        if Position4 then
            Position5 = Position4
        else
            Position5 = Vector3.new( 0, 0, -1 )
        end
    else
        Position5 = Vector3.new( 0, 0, -1 )
    end

    local Unit
    local X = Position5.X
    local Vector32 = Vector3.new( X, 0, Position5.Z )
    Unit = Vector32.Magnitude > 0.001 and Vector32.Unit or Vector3.new( 0, 0, -1 )
    return Position2, Unit, Unit:Cross( Vector3.new( 0, 1, 0 ) ), Number2
end

local function ExhaustPipes( Argument1, Argument2 )
    local Pipes2
    local Value1, Value2, Value3, Value4 = AxleFrame( Argument1 )
    local Table = { }
    local Pipes = Argument2.Pipes
    Pipes2 = if Pipes then Pipes else { }

    for Index, Value in ipairs( Pipes2 ) do
        table.insert( Table, Value1 + Value3 * Value.X + Vector3.new( 0, 1, 0 ) * Value.Y + Value2 * Value.Z )
    end
    if #Table == 0 then
        Table[ 1 ] = Value1 - Vector3.new( 0, 1, 0 ) * Value4 * 0.35 - Value2 * Value4 * 1.9
    end

    return Table, Value2
end

local function BackfireState( Argument1, Argument2, Backfire, SoundGroup )
    local Bf3
    local Bf = Argument1.bf

    if Bf then
        Bf3 = Bf
    else
        local Position
        local Value1, Value2 = ExhaustPipes( Argument2, Backfire )
        local FlameScale = Backfire.FlameScale or 1
        local Table = { }
        Position = Vector3.new( 0, 0, 0 )

        for Index, Value in ipairs( Value1 ) do
            Position = Position + Value
            local Parent2 = Instance.new( "Attachment" )
            Parent2.Name = "BackfirePipe" .. Index
            Parent2.CFrame = CFrame.lookAt( Value, Value - Value2 )
            local ParticleEmitter = Instance.new( "ParticleEmitter" )
            ParticleEmitter.Name = "BackfireFlame"
            ParticleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
            ParticleEmitter.Color = ColorSequence3
            ParticleEmitter.Size = NumberSequence.new( {
                NumberSequenceKeypoint.new( 0, 0.5 * FlameScale ),
                NumberSequenceKeypoint.new( 0.5, 1.1 * FlameScale ),
                NumberSequenceKeypoint.new( 1, 0.3 * FlameScale )
            } )
            ParticleEmitter.Lifetime = NumberRange.new( 0.08, 0.16 )
            ParticleEmitter.Speed = NumberRange.new( 20 * FlameScale, 28 * FlameScale )
            ParticleEmitter.SpreadAngle = Vector2.new( 9, 9 )
            ParticleEmitter.EmissionDirection = Enum.NormalId.Front
            ParticleEmitter.LightEmission = 1
            ParticleEmitter.Rate = 0
            ParticleEmitter.Enabled = false
            ParticleEmitter.Parent = Parent2
            local PointLight = Instance.new( "PointLight" )
            PointLight.Name = "BackfireFlash"
            local Range = 8 * FlameScale
            PointLight.Color = FromRGB
            PointLight.Range = Range
            PointLight.Brightness = 0
            PointLight.Shadows = false
            PointLight.Parent = Parent2
            Parent2.Parent = Argument2.root
            Table[ Index ] = { e = ParticleEmitter, l = PointLight }
        end

        local Parent = Instance.new( "Attachment" )
        Parent.Name = "BackfireExhaust"
        Parent.Position = Position / #Value1
        Parent.Parent = Argument2.root
        local Table2 = { }
        local I = 1

        for I = 1, 3 do
            local Sound = Instance.new( "Sound" )
            Sound.Name = "Backfire" .. I
            Sound.SoundId = "rbxassetid://" .. Backfire.Id
            Sound.RollOffMode = Enum.RollOffMode.InverseTapered
            local RollOffMinDistance = Backfire.RollMin or 14
            local RollOffMaxDistance = Backfire.RollMax or 260
            Sound.RollOffMinDistance = RollOffMinDistance
            Sound.RollOffMaxDistance = RollOffMaxDistance
            Sound.Parent = Parent
            Table2[ I ] = Sound
        end

        local Bf2 = {
            pool = Table2,
            flames = Table,
            n = 0,
            nextAt = 0,
            queue = 0,
            hot = false
        }
        Argument1.bf = Bf2
        Bf3 = Bf2
    end
    for Index2, Value5 in ipairs( Bf3.pool ) do
        if Value5.SoundGroup ~= SoundGroup then
            Value5.SoundGroup = SoundGroup
        end
    end

    return Bf3
end

local function BackfirePop( Argument1, Backfire )
    Argument1.n = Argument1.n % #Argument1.pool + 1
    local Entry = Argument1.pool[ Argument1.n ]
    local Pitch = Backfire.Pitch
    Entry.PlaybackSpeed = Random2:NextNumber( Pitch[ 1 ], Pitch[ 2 ] )
    local NextNumber = Random2:NextNumber( 0.75, 1 )
    Entry.Volume = ( Backfire.Volume or 0.8 ) * NextNumber
    Entry.TimePosition = 0
    Entry:Play( )

    for Index, Value in ipairs( Argument1.flames ) do
        Value.e:Emit( ( math.floor( Random2:NextNumber( Table4[ 1 ], Table4[ 2 ] ) * NextNumber + 0.5 ) ) )
        local L = Value.l
        L.Brightness = 4 * NextNumber
        TweenService:Create( Value.l, TweenInfo2, { Brightness = 0 } ):Play( )
    end
end

local function UpdateBackfire( State, Argument2, NotDestroyed, Magnitude, SoundGroup )
    local Backfire = Argument2.cfg.Backfire

    if not Backfire then
        return
    end

    local Flag

    if NotDestroyed then
        if not State.held or not ( State.charge >= 0.6 ) then
            if State.hold > 0 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = true
        end
    else
        Flag = NotDestroyed
    end

    local Bf = State.bf

    if not Flag then
        if not Bf then
            return
        end
        if not Bf.hot and not ( Bf.queue > 0 ) then
            return
        end
    end

    local BackfireState2 = BackfireState( State, Argument2, Backfire, SoundGroup )
    local Clock = os.clock( )

    if not Flag or BackfireState2.hot then
        if not Flag and BackfireState2.hot then
            BackfireState2.hot = false

            if NotDestroyed and Magnitude < 8 and Backfire.Lift then
                local Queue = BackfireState2.queue
                BackfireState2.queue = math.max( Queue, Random2:NextInteger( Backfire.Lift[ 1 ], Backfire.Lift[ 2 ] ) )
                local NextAt = BackfireState2.nextAt
                local Gap = Backfire.Gap
                BackfireState2.nextAt = math.max( NextAt, Clock + Random2:NextNumber( Gap[ 1 ], Gap[ 2 ] ) )
            end
        end
    else
        local First2
        BackfireState2.hot = true
        local First = Backfire.First
        First2 = if First then First else { 0.12, 0.3 }
        BackfireState2.nextAt = Clock + Random2:NextNumber( First2[ 1 ], First2[ 2 ] )
    end
    if Clock < BackfireState2.nextAt then
        return
    end
    if BackfireState2.queue <= 0 then
        if not BackfireState2.hot then
            return
        end

        BackfireState2.queue = Random2:NextInteger( Backfire.Burst[ 1 ], Backfire.Burst[ 2 ] )
    end

    local NextNumber
    BackfirePop( BackfireState2, Backfire )
    BackfireState2.queue = BackfireState2.queue - 1

    if BackfireState2.queue > 0 then
        local Gap2 = Backfire.Gap
        NextNumber = Random2:NextNumber( Gap2[ 1 ], Gap2[ 2 ] )
    else
        local Every = Backfire.Every
        NextNumber = Random2:NextNumber( Every[ 1 ], Every[ 2 ] )
    end

    BackfireState2.nextAt = Clock + NextNumber
end

function Table.Update( Argument1, Argument2, Argument3, Argument4 )
    local Cfg = Argument2.cfg
    local Root = Argument2.root
    local State = Table.State( Argument2 )
    local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
    local UpVector = Root.CFrame.UpVector
    local Magnitude = ( AssemblyLinearVelocity - UpVector * AssemblyLinearVelocity:Dot( UpVector ) ).Magnitude

    if not Argument4.mine then
        local Gas2
        local Step = Table.Step
        local Held = Argument4.held
        local Gas = Argument4.gas
        Gas2 = if Gas then Gas else Argument4.held
        Step( State, Cfg, Argument3, Held, Gas2, Magnitude )
    end

    local BurnSpin
    local NotDestroyed = not Argument4.destroyed
    BurnSpin = if NotDestroyed then State.held else NotDestroyed
    local LaunchSlip
    Argument2.burnSpin = BurnSpin
    LaunchSlip = NotDestroyed and State.slip or 0
    Argument2.launchSlip = LaunchSlip

    if Argument2.gearbox then
        local LaunchHold
        local Gearbox = Argument2.gearbox
        local Gearbox2 = Argument2.gearbox
        local LaunchSlip2 = Argument2.launchSlip
        LaunchHold = NotDestroyed and State.hold or 0
        Gearbox.launchSlip = LaunchSlip2
        Gearbox2.launchHold = LaunchHold
    end

    local Max

    if NotDestroyed then
        local Charge2

        if State.held then
            local Charge = State.charge ^ Cfg.BurnSmokeHeldExp

            if Charge then
                Charge2 = Charge
            else
                Charge2 = 0
            end
        else
            Charge2 = 0
        end

        Max = math.max( Charge2, State.slip ^ Cfg.BurnSmokeSlipExp )
    else
        Max = 0
    end

    local BurnSmokeAttack = State.intensity < Max and Cfg.BurnSmokeAttack or Cfg.BurnSmokeRelease
    State.intensity = math.clamp( State.intensity + ( Max - State.intensity ) * ( 1 - math.exp( -BurnSmokeAttack * Argument3 ) ), 0, 1 )

    if State.emitting then
        if State.intensity <= 0.004 then
            State.emitting = false
        end
    elseif State.intensity >= 0.012 then
        State.emitting = true
    end

    local BurnSmokeRate2

    if State.emitting then
        local BurnSmokeRate = Cfg.BurnSmokeRate * State.intensity ^ Cfg.BurnSmokeRateExp

        if BurnSmokeRate then
            BurnSmokeRate2 = BurnSmokeRate
        else
            BurnSmokeRate2 = 0
        end
    else
        BurnSmokeRate2 = 0
    end

    local Number
    local CFrame = Root.CFrame
    local UpVector2 = CFrame.UpVector
    local LookVector = CFrame.LookVector
    local RightVector = CFrame.RightVector
    Number = 0

    for Index, Value in ipairs( Argument2.wheels ) do
        local Grounded2
        local Grounded = Value.grounded

        if Grounded then
            local NotFlat = not Value.flat

            if NotFlat then
                if Value.contact == nil then
                    Grounded2 = false
                else
                    Grounded2 = true
                end
            else
                Grounded2 = NotFlat
            end
        else
            Grounded2 = Grounded
        end
        if not Grounded2 or not Value.normal then
        else
            UpVector2 = Value.normal
        end

        local VelocityAtPosition2

        if Grounded2 then
            local VelocityAtPosition = Root:GetVelocityAtPosition( Value.contact )

            if VelocityAtPosition then
                VelocityAtPosition2 = VelocityAtPosition
            else
                VelocityAtPosition2 = Vector3.new( 0, 0, 0 )
            end
        else
            VelocityAtPosition2 = Vector3.new( 0, 0, 0 )
        end

        local Number3
        local VelocityAtPosition3 = VelocityAtPosition2 - UpVector2 * VelocityAtPosition2:Dot( UpVector2 )
        local Magnitude2 = VelocityAtPosition3.Magnitude

        if not NotDestroyed or not Grounded2 or not ( Magnitude2 > 0.5 ) then
            Number3 = 0
        else
            local Deg, Magnitude3

            if not Argument4.slide or Value.front then
                local Unit = ( LookVector - UpVector2 * LookVector:Dot( UpVector2 ) ).Unit
                local Abs = math.abs( ( VelocityAtPosition3:Dot( Unit:Cross( UpVector2 ) ) ) )
                Deg = math.deg( ( math.atan2( Abs, ( math.abs( ( VelocityAtPosition3:Dot( Unit ) ) ) ) ) ) )
                Magnitude3 = Abs
            else
                Deg = 90
                Magnitude3 = Magnitude2
            end

            local Clamp3 = math.clamp( ( Deg - Cfg.SlipSmokeAngle0 ) / ( Cfg.SlipSmokeAngle1 - Cfg.SlipSmokeAngle0 ), 0, 1 )
            local Clamp4 = Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 )
            local Clamp5 = math.clamp( ( Magnitude3 - Cfg.SlipSmokeSpeed0 ) / ( Cfg.SlipSmokeSpeed1 - Cfg.SlipSmokeSpeed0 ), 0, 1 )
            Number3 = Clamp4 * ( Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 ) )
        end

        local Slip
        local Entry = State.wheels[ Value ]
        Slip = Entry and Entry.slip or 0
        local SlipSmokeAttack = Slip < Number3 and Cfg.SlipSmokeAttack or Cfg.SlipSmokeRelease
        local Slip3
        local Slip2 = Slip + ( Number3 - Slip ) * ( 1 - math.exp( -SlipSmokeAttack * Argument3 ) )
        Slip3 = if not ( Slip2 < 0.005 ) or Number3 ~= 0 then Slip2 else 0
        local SlipSmokeRate2

        if Slip3 > 0.01 then
            local SlipSmokeRate = Cfg.SlipSmokeRate * Slip3 ^ Cfg.BurnSmokeRateExp

            if SlipSmokeRate then
                SlipSmokeRate2 = SlipSmokeRate
            else
                SlipSmokeRate2 = 0
            end
        else
            SlipSmokeRate2 = 0
        end

        local Number4 = if Value.front then 0 else BurnSmokeRate2
        local Rate

        if not Grounded2 or not ( Number4 > 0 ) or not ( SlipSmokeRate2 <= Number4 ) then
            Rate = 0
        else
            local Floor = math.floor( Number4 * 2 + 0.5 ) / 2

            if Floor then
                Rate = Floor
            else
                Rate = 0
            end
        end

        local Rate2

        if not Grounded2 or not ( Number4 < SlipSmokeRate2 ) then
            Rate2 = 0
        else
            local Floor2 = math.floor( SlipSmokeRate2 * 2 + 0.5 ) / 2

            if Floor2 then
                Rate2 = Floor2
            else
                Rate2 = 0
            end
        end

        local Marking

        if Grounded2 then
            if Magnitude2 > 2.8 then
                if Slip3 > 0.08 then
                    Marking = true
                else
                    local NotFront = not Value.front

                    if NotFront then
                        if State.intensity > 0.08 then
                            Marking = true
                        else
                            Marking = false
                        end
                    else
                        Marking = NotFront
                    end
                end
            else
                Marking = false
            end
        else
            Marking = Grounded2
        end

        local Entry2

        if Entry then
            Entry2 = Entry
        elseif Rate > 0 or Rate2 > 0 or Marking then
            Entry2 = WheelFx( State, Argument2, Value )
        else
            Entry2 = Entry
        end
        if Entry2 then
            Entry2.slip = Slip3

            if Entry2.smoke.Rate ~= Rate then
                Entry2.smoke.Rate = Rate
            end

            local Flag
            local Enabled = Entry2.smoke.Enabled
            Flag = Rate > 0 and true or false

            if Enabled ~= Flag then
                local Enabled2
                local Smoke = Entry2.smoke
                Enabled2 = Rate > 0 and true or false
                Smoke.Enabled = Enabled2
            end
            if Entry2.slipSmoke.Rate ~= Rate2 then
                Entry2.slipSmoke.Rate = Rate2
            end

            local Flag2
            local Enabled3 = Entry2.slipSmoke.Enabled
            Flag2 = Rate2 > 0 and true or false

            if Enabled3 ~= Flag2 then
                local Enabled4
                local SlipSmoke = Entry2.slipSmoke
                Enabled4 = Rate2 > 0 and true or false
                SlipSmoke.Enabled = Enabled4
            end

            local Marks = Entry2.marks

            if Marking then
                if not Marks.marking then
                    Marks.index = Marks.index % 2 + 1
                    Marks.trails[ Marks.index ]:Clear( )
                end

                local Result = TireWidth( Value ) / 2
                local Unit2 = ( RightVector - Value.normal * RightVector:Dot( Value.normal ) ).Unit
                local Contact = Value.contact + Value.normal * 0.04
                local A0 = Marks.a0
                A0.WorldPosition = Contact - Unit2 * Result
                local A1 = Marks.a1
                A1.WorldPosition = Contact + Unit2 * Result
            end
            for Index2, Value3 in ipairs( Marks.trails ) do
                local Enabled5

                if Marking then
                    if Index2 == Marks.index then
                        Enabled5 = true
                    else
                        Enabled5 = false
                    end
                else
                    Enabled5 = Marking
                end
                if Value3.Enabled ~= Enabled5 then
                    Value3.Enabled = Enabled5
                end
            end

            Marks.marking = Marking
        end
        if Grounded2 and not Value.front then
            Number = Number + 0.5
        end
    end

    local Number2

    if NotDestroyed then
        if State.held or State.slip > 0 then
            local Clamp2
            local Clamp = math.clamp( Argument2.rpm or 1, 0, 1 )

            if State.held then
                Clamp2 = Clamp * 0.6 + 0.4
            else
                Clamp2 = State.slip ^ 0.7
            end

            Number2 = Number * Clamp2
        else
            Number2 = 0
        end
    else
        Number2 = 0
    end

    UpdateSound( State, Argument2, Argument3, Number2, Argument4.group )
    UpdateBackfire( State, Argument2, NotDestroyed, Magnitude, Argument4.group )
end
function Table.Stop( Argument1 )
    local BurnFx = Argument1.burnFx

    if not BurnFx then
        return
    end
    for Key, Value in pairs( BurnFx.wheels ) do
        Value.smoke.Enabled = false
        Value.slipSmoke.Enabled = false
        Value.slip = 0

        for Index, Value3 in ipairs( Value.marks.trails ) do
            Value3.Enabled = false
        end

        Value.marks.marking = false
    end

    BurnFx.intensity = 0
    BurnFx.emitting = false

    if BurnFx.mix then
        local Current = BurnFx.mix.current

        if Current then
            Current.sound:Stop( )
            Current.sound.Volume = 0
        end

        local Outgoing = BurnFx.mix.outgoing

        if Outgoing then
            Outgoing.sound:Stop( )
            Outgoing.sound.Volume = 0
        end

        BurnFx.mix = nil
    end
    if BurnFx.fallback and BurnFx.fallback.IsPlaying then
        BurnFx.fallback:Stop( )
    end
    if BurnFx.bf then
        local Bf = BurnFx.bf
        local Bf2 = BurnFx.bf
        Bf.hot = false
        Bf2.queue = 0
    end
end
return Table
