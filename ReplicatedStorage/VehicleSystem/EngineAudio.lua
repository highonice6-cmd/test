-- ReplicatedStorage.VehicleSystem.EngineAudio
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local __index = { }
__index.__index = __index

local function Id( Text )
    local Text2 = type( Text ) == "number" and "rbxassetid://" .. Text or Text
    return Text2
end

local function Smooth01( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function EvalCurve( List, Argument2 )
    local Count = #List

    if Argument2 <= List[ 1 ][ 1 ] then
        return List[ 1 ][ 2 ]
    end
    if List[ Count ][ 1 ] <= Argument2 then
        return List[ Count ][ 2 ]
    end

    local Count2 = Count - 1
    local I = 1

    for I = 1, Count2 do
        local Entry = List[ I ]
        local Entry2 = List[ I + 1 ]

        if Argument2 <= Entry2[ 1 ] then
            local Item = Entry2[ 1 ] - Entry[ 1 ]

            if Item <= 0 then
                return Entry2[ 2 ]
            end
            if math.abs( Entry[ 4 ] ) == math.huge or math.abs( Entry2[ 3 ] ) == math.huge then
                return Entry[ 2 ]
            end
            local Item2 = ( Argument2 - Entry[ 1 ] ) / Item
            local Item3 = Item2 * Item2
            local Item4 = Item2 * Item2 * Item2
            return ( 2 * Item4 - 3 * Item3 + 1 ) * Entry[ 2 ] + ( Item4 - 2 * Item3 + Item2 ) * Entry[ 4 ] * Item + ( -2 * Item4 + 3 * Item3 ) * Entry2[ 2 ] + ( Item4 - Item3 ) * Entry2[ 3 ] * Item
        end
    end

    return List[ Count ][ 2 ]
end

function __index._sound( Argument1, Name, SoundId, Looped )
    local SoundId2
    local Sound = Instance.new( "Sound" )
    Sound.Name = Name
    SoundId2 = type( SoundId ) == "number" and "rbxassetid://" .. SoundId or SoundId
    Sound.SoundId = SoundId2
    Sound.Looped = Looped
    Sound.Volume = 0
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.RollOffMinDistance = Argument1.cfg.RollMin or 12
    Sound.RollOffMaxDistance = Argument1.cfg.RollMax or 200
    Sound.Parent = Argument1.parent
    return Sound
end
function __index.new( Argument1, Argument2 )
    local Value1
    local Self = setmetatable( {
        parent = Argument1,
        cfg = Argument2,
        loops = { },
        master = 0,
        running = false,
        playing = false
    }, __index )
    local Table = {
        sound = Self:_sound( "Engine_idle", Argument2.Idle.Id, true ),
        file = Argument2.Idle
    }
    table.insert( Self.loops, Table )
    Self.points = { { layer = nil, on = Table, off = Table } }
    local Layers = Argument2.Layers
    Value1 = nil

    for Key, Value in Layers, nil, nil do
        local Text = "Engine_" .. Value.Name .. "_on"
        local Table2 = { sound = Self:_sound( Text, Value.On.Id, true ), file = Value.On }
        local Text2 = "Engine_" .. Value.Name .. "_off"
        local Table3 = { sound = Self:_sound( Text2, Value.Off.Id, true ), file = Value.Off }
        table.insert( Self.loops, Table2 )
        table.insert( Self.loops, Table3 )
        table.insert( Self.points, { layer = Value, on = Table2, off = Table3 } )
    end
    if Argument2.Limiter then
        Self.limiter = {
            sound = Self:_sound( "Engine_limiter", Argument2.Limiter.Id, true ),
            file = Argument2.Limiter
        }
        local Loops = Self.loops
        table.insert( Loops, Self.limiter )
    end
    if Argument2.Whine then
        Self.whineOn = {
            sound = Self:_sound( "Engine_whine_on", Argument2.Whine.On.Id, true ),
            file = Argument2.Whine.On
        }
        Self.whineOff = {
            sound = Self:_sound( "Engine_whine_off", Argument2.Whine.Off.Id, true ),
            file = Argument2.Whine.Off
        }
        local Loops2 = Self.loops
        table.insert( Loops2, Self.whineOn )
        local Loops3 = Self.loops
        table.insert( Loops3, Self.whineOff )
    end
    if Argument2.Startup then
        Self.startup = Self:_sound( "Engine_startup", Argument2.Startup.Id, false )
    end

    local Interior = Argument2.Interior

    if Interior and Interior.Idle and Interior.Layers then
        local Value2
        local Class = setmetatable( {
            Idle = Interior.Idle,
            Layers = Interior.Layers,
            Limiter = Interior.Limiter,
            Startup = Interior.Startup,
            Curves = Interior.Curves,
            Interior = false
        }, { __index = Argument2 } )
        Self.inner = __index.new( Argument1, Class )
        local Loops4 = Self.inner.loops
        Value2 = nil

        for Key2, Value3 in Loops4, nil, nil do
            local Sound = Value3.sound
            Sound.Name = Value3.sound.Name:gsub( "^Engine_", "EngineInt_" )
        end
        if Self.inner.startup then
            Self.inner.startup.Name = "EngineInt_startup"
        end

        Self.interiorMix = 0
        Self.interiorWant = 0
    end

    return Self
end
function __index._play( Argument1, Playing )
    if Argument1.playing == Playing then
        return
    end

    local Value1
    Argument1.playing = Playing
    local Loops = Argument1.loops
    Value1 = nil

    for Key, Value in Loops, nil, nil do
        if Playing then
            Value.sound.Volume = 0
            Value.vol = 0
            Value.sound:Play( )
        else
            Value.sound:Stop( )
        end
    end
end
function __index.Start( Self, Argument2 )
    if Self.inner then
        Self.inner:Start( Argument2 )

        if Self.inner.startup then
            local Startup = Self.inner.startup
            Startup.Volume = Startup.Volume * ( Self.interiorWant or 0 )
        end
    end

    Self.running = true
    Self:_play( true )
    local Cfg = Self.cfg

    if Argument2 or not Self.startup then
        Self.fadeInAt = os.clock( )
        return
    end
    local Startup2 = Self.startup
    Startup2.Volume = ( Cfg.Volume or 1 ) * ( Cfg.Startup.Gain or 1 )
    Self.startup.TimePosition = 0
    Self.startup:Play( )
    Self.master = 0
    Self.fadeInAt = os.clock( ) + ( Cfg.StartDelay or 0.4 )
    return
end
function __index.Stop( Argument1 )
    if Argument1.inner then
        Argument1.inner:Stop( )
    end

    Argument1.running = false
end
function __index.Silence( Self )
    if Self.inner then
        Self.inner:Silence( )
    end

    Self.running = false
    Self.master = 0
    Self:_play( false )

    if Self.startup then
        Self.startup:Stop( )
    end
end
function __index.Destroy( Self )
    if Self.inner then
        Self.inner:Destroy( )
    end

    local Value1
    Self:Silence( )
    local Loops = Self.loops
    Value1 = nil

    for Key, Value in Loops, nil, nil do
        Value.sound:Destroy( )
    end
    if Self.startup then
        Self.startup:Destroy( )
    end
end
function __index.Update( Self, Argument2, Argument3, Amount )
    local Cfg = Self.cfg

    if Self.inner then
        local Interior = Cfg.Interior
        local InteriorWant = ( Self.interiorWant or 0 ) * ( Interior.Level or 1 )
        Self.interiorMix = Self.interiorMix + ( InteriorWant - Self.interiorMix ) * math.clamp( Amount * 4, 0, 1 )
        local Inner = Self.inner
        Inner.boost = ( Self.boost or 1 ) * Self.interiorMix
        Self.inner:Update( Argument2, Argument3, Amount )
    end
    if Self.running then
        local Clock = os.clock( )

        if ( Self.fadeInAt or 0 ) <= Clock then
            Self.master = math.min( 1, Self.master + Amount / ( Cfg.StartFade or 0.35 ) )
        end
    else
        Self.master = math.max( 0, Self.master - Amount / 0.45 )

        if Self.master <= 0 then
            Self:_play( false )
            return
        end
    end
    if not Self.playing then
        return
    end

    local Number
    local Clamp = math.clamp( Argument2, 0, 1 )
    local Clamp2 = math.clamp( Argument3, 0, 1 )
    local IdleRPM = Cfg.IdleRPM + Clamp * ( Cfg.RedlineRPM - Cfg.IdleRPM )
    local Volume = ( Cfg.Volume or 1 ) * Self.master * ( 1 - ( Cfg.RpmVolume or 0.2 ) * ( 1 - Clamp ) ) * ( Self.boost or 1 )
    local Sin = math.sin( Clamp2 * 1.5707963267948966 )
    local Cos = math.cos( Clamp2 * 1.5707963267948966 ) * ( Cfg.OffLevel or 0.6 )

    if Self.limiter then
        local LimiterRPM2
        local LimiterRPM = Cfg.LimiterRPM
        LimiterRPM2 = if LimiterRPM then LimiterRPM else Cfg.RedlineRPM * 0.94
        local Clamp3 = math.clamp( ( IdleRPM - LimiterRPM2 ) / math.max( Cfg.RedlineRPM - LimiterRPM2, 1 ), 0, 1 )
        Number = Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) * Clamp2
    else
        Number = 0
    end

    local Curves = Cfg.Curves

    if Curves then
        local MaxRPM2
        local MaxRPM = Curves.MaxRPM
        MaxRPM2 = if MaxRPM then MaxRPM else Cfg.RedlineRPM
        local Max5
        local IdleRPM2 = IdleRPM / MaxRPM2
        local Table = { }

        local function PitchOf( Argument1, Argument2 )
            return ( math.clamp( EvalCurve( Curves[ ( Argument1.PitchFrom or Argument2 ) .. "Pitch" ], IdleRPM2 ), 0.1, 3 ) )
        end

        local Item = Self.points[ 1 ]
        Table[ Item.on ] = math.max( EvalCurve( Curves.idleVol, IdleRPM2 ), 0 )
        local On = Item.on
        On.speed = math.clamp( EvalCurve( Curves[ ( Item.on.file.PitchFrom or "idle" ) .. "Pitch" ], IdleRPM2 ), 0.1, 3 )

        if not Self.limiter or not Curves.maxRPMVol then
            Max5 = 0
        else
            local Max = math.max( EvalCurve( Curves.maxRPMVol, IdleRPM2 ), 0 )

            if Max then
                Max5 = Max
            else
                Max5 = 0
            end
        end

        local Count = #Self.points
        local I = 2

        for I = 2, Count do
            local Max4
            local Entry = Self.points[ I ]
            local Name = Entry.layer.Name
            local Max2 = math.max( EvalCurve( Curves[ Name .. "Vol" ], IdleRPM2 ), 0 )
            local Max3 = Max2 * Clamp2
            Max4 = if Name ~= "high" or not ( Max5 >= 0.95 ) then Max3 else Max3 / 3.3
            Table[ Entry.on ] = Max4
            Table[ Entry.off ] = Max2 * ( 1 - Clamp2 )
            local On2 = Entry.on
            local Off = Entry.off
            local Speed = math.clamp( EvalCurve( Curves[ ( Entry.on.file.PitchFrom or Name ) .. "Pitch" ], IdleRPM2 ), 0.1, 3 )
            local Speed2 = math.clamp( EvalCurve( Curves[ ( Entry.off.file.PitchFrom or Name ) .. "Pitch" ], IdleRPM2 ), 0.1, 3 )
            On2.speed = Speed
            Off.speed = Speed2
        end
        if Self.limiter then
            Table[ Self.limiter ] = Max5
            local Limiter = Self.limiter
            Limiter.speed = math.clamp( EvalCurve( Curves.highPitch, IdleRPM2 ), 0.1, 3 )
        end

        local Value1
        local Volume2 = ( Cfg.Volume or 1 ) * Self.master * ( Self.boost or 1 )
        local Clamp4 = math.clamp( Amount * ( Cfg.VolumeSmoothing or 12 ), 0, 1 )
        local Loops = Self.loops
        Value1 = nil

        for Key, Value in Loops, nil, nil do
            local Volume3
            local Entry2 = ( Table[ Value ] or 0 ) * ( Value.file.Gain or 1 ) * Volume2
            Value.vol = ( Value.vol or 0 ) + ( Entry2 - ( Value.vol or 0 ) ) * Clamp4
            Volume3 = if Value.vol < 0.001 then 0 else Value.vol

            if math.abs( Value.sound.Volume - Volume3 ) > 0.002 then
                Value.sound.Volume = Volume3
            elseif Volume3 == 0 and Value.sound.Volume ~= 0 then
                Value.sound.Volume = Volume3
            end
            if Value.speed and math.abs( Value.sound.PlaybackSpeed - Value.speed ) > 0.002 then
                local Sound = Value.sound
                Sound.PlaybackSpeed = Value.speed
            end
        end

        return
    end
    local Value2
    local Points = Self.points
    Value2 = nil

    for Key2, Value3 in Points, nil, nil do
        local Rpm8

        if Value3.layer then
            local Rpm7 = Value3.layer.Rpm

            if Rpm7 then
                Rpm8 = Rpm7
            else
                Rpm8 = Cfg.IdleRPM
            end
        else
            Rpm8 = Cfg.IdleRPM
        end

        Value3.rpm = Rpm8
    end

    local Clamp5 = math.clamp( Cfg.Crossfade or 0.7, 0.05, 1 )
    local Table2 = { }

    if IdleRPM <= Points[ 1 ].rpm then
        Table2[ 1 ] = 1
    elseif Points[ #Points ].rpm <= IdleRPM then
        Table2[ #Points ] = 1
    else
        local Count2 = #Points - 1
        local I2 = 1

        for I2 = 1, Count2 do
            local Entry3 = Points[ I2 ]
            local Entry4 = Points[ I2 + 1 ]

            if IdleRPM <= Entry4.rpm then
                local IdleFadeCenter2
                local Log = math.log( IdleRPM / Entry3.rpm ) / math.log( Entry4.rpm / Entry3.rpm )

                if I2 == 1 then
                    local IdleFadeCenter = Cfg.IdleFadeCenter

                    if IdleFadeCenter then
                        IdleFadeCenter2 = IdleFadeCenter
                    else
                        IdleFadeCenter2 = 0.3
                    end
                elseif Entry4.layer then
                    local FadeCenter = Entry4.layer.FadeCenter

                    if FadeCenter then
                        IdleFadeCenter2 = FadeCenter
                    else
                        IdleFadeCenter2 = 0.5
                    end
                else
                    IdleFadeCenter2 = 0.5
                end

                local IdleFadeCenter3 = 2 * IdleFadeCenter2
                local Min = math.min( Clamp5, IdleFadeCenter3, 2 * ( 1 - IdleFadeCenter2 ) )
                local Clamp6 = math.clamp( ( Log - ( IdleFadeCenter2 - Min / 2 ) ) / Min, 0, 1 )
                local Total = I2 + 1
                local Cos2 = math.cos( Clamp6 * 1.5707963267948966 )
                local Sin2 = math.sin( Clamp6 * 1.5707963267948966 )
                Table2[ I2 ] = Cos2
                Table2[ Total ] = Sin2
                break
            end
        end
    end

    local Value4
    local Table3 = { }
    Value4 = nil

    for Key3, Value5 in Points, nil, nil do
        local Entry6 = ( Table2[ Key3 ] or 0 ) * ( 1 - Number )

        if Value5.on == Value5.off then
            Table3[ Value5.on ] = ( Table3[ Value5.on ] or 0 ) + Entry6
        else
            Table3[ Value5.on ] = ( Table3[ Value5.on ] or 0 ) + Entry6 * Sin
            Table3[ Value5.off ] = ( Table3[ Value5.off ] or 0 ) + Entry6 * Cos
        end

        local Rpm4
        local On3 = Value5.on
        local Rpm3 = Value5.on.file.Rpm
        Rpm4 = if Rpm3 then Rpm3 else Value5.rpm
        local Rpm6
        On3.speed = math.clamp( IdleRPM / Rpm4, 0.4, 2.5 )
        local Off2 = Value5.off
        local Rpm5 = Value5.off.file.Rpm
        Rpm6 = if Rpm5 then Rpm5 else Value5.rpm
        Off2.speed = math.clamp( IdleRPM / Rpm6, 0.4, 2.5 )
    end
    if Self.limiter then
        local Rpm2
        Table3[ Self.limiter ] = Number
        local Limiter2 = Self.limiter
        local Rpm = Cfg.Limiter.Rpm
        Rpm2 = if Rpm then Rpm else Cfg.RedlineRPM
        Limiter2.speed = math.clamp( IdleRPM / Rpm2, 0.4, 2.5 )
    end
    if Self.whineOn and Cfg.Whine then
        local RefRPM2
        local Whine = Cfg.Whine
        local IdleLevel = ( Whine.IdleLevel or 0.15 ) + ( 1 - ( Whine.IdleLevel or 0.15 ) ) * Clamp ^ ( Whine.Curve or 1.5 )
        Table3[ Self.whineOn ] = ( Whine.Volume or 0.4 ) * IdleLevel * Sin
        Table3[ Self.whineOff ] = ( Whine.OffVolume or 0.3 ) * Clamp * Clamp * math.cos( Clamp2 * 1.5707963267948966 )
        local Pitch = ( Whine.Pitch or 1 ) * IdleRPM
        local RefRPM = Whine.RefRPM
        RefRPM2 = if RefRPM then RefRPM else Cfg.RedlineRPM * 0.6
        local Speed3 = math.clamp( Pitch / RefRPM2, 0.3, 2.5 )
        local WhineOn = Self.whineOn
        local WhineOff = Self.whineOff
        WhineOn.speed = Speed3
        WhineOff.speed = Speed3
    end

    local Value6
    local Clamp7 = math.clamp( Amount * ( Cfg.VolumeSmoothing or 12 ), 0, 1 )
    local Loops2 = Self.loops
    Value6 = nil

    for Key4, Value7 in Loops2, nil, nil do
        local Volume4
        local Entry5 = ( Table3[ Value7 ] or 0 ) * ( Value7.file.Gain or 1 ) * Volume
        Value7.vol = ( Value7.vol or 0 ) + ( Entry5 - ( Value7.vol or 0 ) ) * Clamp7
        Volume4 = if Value7.vol < 0.001 then 0 else Value7.vol

        if math.abs( Value7.sound.Volume - Volume4 ) > 0.002 then
            Value7.sound.Volume = Volume4
        elseif Volume4 == 0 and Value7.sound.Volume ~= 0 then
            Value7.sound.Volume = Volume4
        end
        if Value7.speed and math.abs( Value7.sound.PlaybackSpeed - Value7.speed ) > 0.002 then
            local Sound2 = Value7.sound
            Sound2.PlaybackSpeed = Value7.speed
        end
    end

    return
end
local __index2 = { }
__index2.__index = __index2
function __index.Gearbox( Argument1 )
    return ( setmetatable( {
        veh = Argument1,
        eng = Argument1.Engine,
        gear = 1,
        rpm = 0,
        load = 0,
        prevThrottle = 0,
        lastShift = -math.huge,
        cutUntil = 0,
        blipUntil = 0
    }, __index2 ) )
end
function __index2._top( Argument1, Key )
    local Eng = Argument1.eng
    local Gearbox = Argument1.eng.Gearbox

    if Gearbox and Gearbox.GearSpread then
        local GearTopSpeed2
        local GearTopSpeed = Gearbox.GearTopSpeed
        GearTopSpeed2 = if GearTopSpeed then GearTopSpeed else Argument1.veh.TopSpeed
        local TopGearRPM2
        local GearTopSpeed3 = GearTopSpeed2 * Eng.RedlineRPM
        local TopGearRPM = Gearbox.TopGearRPM
        TopGearRPM2 = if TopGearRPM then TopGearRPM else Eng.RedlineRPM * 0.92
        local ReverseSpread2
        local GearTopSpeed4 = GearTopSpeed3 / TopGearRPM2

        if Key == 0 then
            local ReverseSpread = Gearbox.ReverseSpread

            if ReverseSpread then
                ReverseSpread2 = ReverseSpread
            else
                ReverseSpread2 = 0.3
            end
        else
            ReverseSpread2 = Gearbox.GearSpread[ Key ]
        end

        return GearTopSpeed4 * ReverseSpread2
    end
    if Gearbox and Gearbox.TopSpeedsKmh then
        local ReverseKmh2

        if Key == 0 then
            local ReverseKmh = Gearbox.ReverseKmh

            if ReverseKmh then
                ReverseKmh2 = ReverseKmh
            else
                ReverseKmh2 = 45
            end
        else
            ReverseKmh2 = Gearbox.TopSpeedsKmh[ Key ]
        end

        return ReverseKmh2 / ( Gearbox.SpeedScale or 1 ) / 3.6 * ( Gearbox.StudsPerMeter or 3.9 )
    end
    if Gearbox then
        local Reverse2

        if Key == 0 then
            local Reverse = Gearbox.Reverse

            if Reverse then
                Reverse2 = Reverse
            else
                local Item = Gearbox.Ratios[ 1 ]

                if Item then
                    Reverse2 = Item
                else
                    Reverse2 = Gearbox.Ratios[ Key ]
                end
            end
        else
            Reverse2 = Gearbox.Ratios[ Key ]
        end

        return Eng.RedlineRPM / ( Reverse2 * Gearbox.FinalDrive ) * 2 * 3.141592653589793 * Gearbox.TireRadius / 60 * ( Gearbox.StudsPerMeter or 3.9 )
    end
    if Key == 0 then
        return Argument1.veh.ReverseSpeed / 0.75
    end

    local GearFractions2
    local GearFractions = Eng.GearFractions
    GearFractions2 = if GearFractions then GearFractions else Argument1.veh.GearFractions
    return GearFractions2[ Key ] * Argument1.veh.TopSpeed
end
function __index2._count( Argument1 )
    local Gearbox = Argument1.eng.Gearbox

    if Gearbox and Gearbox.GearSpread then
        return #Gearbox.GearSpread
    end
    if Gearbox and Gearbox.TopSpeedsKmh then
        return #Gearbox.TopSpeedsKmh
    end

    local Count2

    if Gearbox then
        local Count = #Gearbox.Ratios

        if Count then
            Count2 = Count
        else
            local GearFractions = Argument1.eng.GearFractions

            if GearFractions then
                GearFractions2 = GearFractions
            else
                GearFractions2 = Argument1.veh.GearFractions
            end

            Count2 = #GearFractions2
        end
    else
        local GearFractions2
        local GearFractions = Argument1.eng.GearFractions

        if GearFractions then
            GearFractions2 = GearFractions
        else
            GearFractions2 = Argument1.veh.GearFractions
        end

        Count2 = #GearFractions2
    end

    return Count2
end
function __index2._wheelRpm( Self, Argument2, Argument3 )
    return Self.eng.RedlineRPM * Argument2 / Self:_top( Argument3 )
end

local function TorqueAt( Argument1, Argument2 )
    local TorqueLow = Argument1.TorqueLow or 0.8
    return TorqueLow + ( 1 - TorqueLow ) * math.sin( 3.141592653589793 * math.clamp( math.clamp( Argument2, 0, 1 ) * 0.85 + 0.1, 0, 1 ) )
end

function __index2.DriveAccel( Self, Argument2 )
    local Gearbox = Self.eng.Gearbox

    if Gearbox then
        if Gearbox.LaunchAccel or Gearbox.GearSpread then
            if Gearbox.DrivePhysics == false then
                return nil
            end

            local LaunchAccel
            local Eng = Self.eng
            local _count = Self:_count( )
            local GearAccelExp = Gearbox.GearAccelExp or 1

            if Gearbox.LaunchAccel then
                LaunchAccel = Gearbox.LaunchAccel * ( Self:_top( 1 ) / Self:_top( Self.gear ) ) ^ GearAccelExp
            else
                local TopGearRPM2
                local TopSpeed = Self.veh.TopSpeed
                local TopGearRPM = Gearbox.TopGearRPM
                TopGearRPM2 = if TopGearRPM then TopGearRPM else Eng.RedlineRPM * 0.92
                local TopGearRPM3 = ( TopGearRPM2 - Eng.IdleRPM ) / ( Eng.RedlineRPM - Eng.IdleRPM )
                local Drag = ( Self.veh.Drag or 0.0004 ) * TopSpeed * TopSpeed
                local TorqueLow = Gearbox.TorqueLow or 0.8
                LaunchAccel = Drag / ( TorqueLow + ( 1 - TorqueLow ) * math.sin( 3.141592653589793 * math.clamp( math.clamp( TopGearRPM3, 0, 1 ) * 0.85 + 0.1, 0, 1 ) ) ) * ( Self:_top( _count ) / Self:_top( Self.gear ) ) ^ GearAccelExp
            end

            local LaunchAccel3
            local Rpm = Self.rpm
            local TorqueLow2 = Gearbox.TorqueLow or 0.8
            local LaunchAccel2 = LaunchAccel * ( TorqueLow2 + ( 1 - TorqueLow2 ) * math.sin( 3.141592653589793 * math.clamp( math.clamp( Rpm, 0, 1 ) * 0.85 + 0.1, 0, 1 ) ) )

            if ( Self.launchSlip or 0 ) > 0 then
                LaunchAccel3 = LaunchAccel2 * ( Self.veh.BurnSlipTorque or 0.7 )
            elseif Self.rpm > 0.985 then
                LaunchAccel3 = LaunchAccel2 * ( Gearbox.LimiterPush or 0.25 )
            else
                LaunchAccel3 = LaunchAccel2
            end

            return LaunchAccel3 * ( 1 - ( 1 - ( Gearbox.ShiftTorque or 0.45 ) ) * Self:_shiftDip( Argument2 or os.clock( ) ) )
        end
    end

    return nil
end
function __index2._shiftDip( Argument1, Argument2 )
    local Shift = Argument1.shift

    if not Shift or Shift.down then
        return 0
    end

    local Start = ( Argument2 - Shift.start ) / Shift.dur

    if Start >= 1 or Start < 0 then
        return 0
    end
    return ( math.sin( 3.141592653589793 * Start ) )
end
function __index2.Step( p1, p2, p3, p4, p5, p6 )
    -- Could not structure function #19
end
return __index
