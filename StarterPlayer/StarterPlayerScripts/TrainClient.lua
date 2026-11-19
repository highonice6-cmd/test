-- StarterPlayer.StarterPlayerScripts.TrainClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Parent = game:GetService( "SoundService" )
local Trains = ReplicatedStorage:WaitForChild( "Trains" )
local TrainConfig = require( Trains:WaitForChild( "TrainConfig" ) )
local Templates = Trains:WaitForChild( "Templates" )
local Folder = Instance.new( "Folder" )
Folder.Name = "TrainsLocaux"
Folder.Parent = workspace
local Table = { }

for Index, Value in ipairs( TrainConfig.Lanes ) do
    local Rotation2
    local Child = Templates:WaitForChild( Value.Template )
    local Rotation = Child.CFrame.Rotation
    Rotation2 = if Value.Dir > 0 then CFrame.Angles( 0, 3.141592653589793, 0 ) * Rotation else Rotation
    table.insert( Table, {
        cfg = Value,
        template = Child,
        len = Child.Size.Z,
        rot = Rotation2,
        cars = { }
    } )
end

local CurrentCamera = workspace.CurrentCamera
local Random2 = Random.new( )
local Parent2 = Instance.new( "SoundGroup" )
Parent2.Name = "TrainSons"
local ReverbSoundEffect = Instance.new( "ReverbSoundEffect" )
ReverbSoundEffect.DecayTime = TrainConfig.ReverbDecay
ReverbSoundEffect.Density = 1
ReverbSoundEffect.Diffusion = 1
ReverbSoundEffect.WetLevel = TrainConfig.ReverbWet
ReverbSoundEffect.DryLevel = 0
ReverbSoundEffect.Parent = Parent2
Parent2.Parent = Parent

local function Emitter( Name, SoundId, Looped, RollOffMinDistance, RollOffMaxDistance )
    local Parent = Instance.new( "Part" )
    Parent.Name = Name
    Parent.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
    Parent.Transparency = 1
    Parent.Anchored = true
    Parent.CanCollide = false
    Parent.CanQuery = false
    Parent.CanTouch = false
    Parent.CastShadow = false
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = SoundId
    Sound.Looped = Looped
    Sound.Volume = 0
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.RollOffMinDistance = RollOffMinDistance
    Sound.RollOffMaxDistance = RollOffMaxDistance
    Sound.SoundGroup = Parent2
    Sound.Parent = Parent
    Parent.Parent = Folder
    return Parent, Sound
end

for Index2, Value3 in ipairs( Table ) do
    local Text = Value3.cfg.Name .. "_Roulement"
    local RollSound = TrainConfig.RollSound
    local RollPart, Roll = Emitter( Text, RollSound, true, TrainConfig.RollOffMin, TrainConfig.RollOffMax )
    Value3.rollPart = RollPart
    Value3.roll = Roll
    local Text2 = Value3.cfg.Name .. "_Klaxon"
    local HornSound = TrainConfig.HornSound
    local HornPart, Horn = Emitter( Text2, HornSound, false, TrainConfig.HornRollOffMin, TrainConfig.HornRollOffMax )
    Value3.hornPart = HornPart
    Value3.horn = Horn
end

local function Car( Argument1, Key )
    local Entry2
    local Entry = Argument1.cars[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local Clone = Argument1.template:Clone( )
        Clone.Name = Argument1.cfg.Name .. "_Wagon" .. Key
        Clone.Anchored = true
        Clone.CanCollide = false
        Clone.CanQuery = false
        Clone.CanTouch = false
        Argument1.cars[ Key ] = Clone
        Entry2 = Clone
    end

    return Entry2
end

local Table2 = { }
local Table3 = { }

local function Doppler( Argument1, Argument2 )
    if not TrainConfig.DopplerSound then
        return 1
    end

    local Position = CurrentCamera.CFrame.Position - Argument1
    local Magnitude = Position.Magnitude

    if Magnitude < 1 then
        return 1
    end
    local Dot = Argument2:Dot( Position / Magnitude )
    return TrainConfig.DopplerSound / math.max( TrainConfig.DopplerSound - Dot, 1 )
end

local function SmoothPitch( Argument1, Argument2, Argument3 )
    return ( Argument1 or Argument2 ) + ( Argument2 - ( Argument1 or Argument2 ) ) * ( 1 - math.exp( -Argument3 * 10 ) )
end

local function UpdateSound( Value, ServerTimeNow, HornFor, Amount, Argument5, Argument6 )
    local PortalEast2
    local Dir = Value.cfg.Dir
    local Vector32 = Vector3.new( Dir * Argument5, 0, 0 )

    if HornFor then
        local PortalEast

        if Dir > 0 then
            PortalEast = TrainConfig.PortalEast
        else
            PortalEast = TrainConfig.PortalWest
        end

        PortalEast2 = PortalEast + Dir * ( ServerTimeNow - HornFor ) * Argument5
    else
        PortalEast2 = HornFor
    end

    local Duration2
    local Roll = Value.roll

    if HornFor then
        local Duration = TrainConfig.Duration
        Duration2 = HornFor + Duration( Amount, Value.len, Argument5 )
    else
        Duration2 = HornFor
    end
    if not HornFor or not ( Amount > 0 ) or not ( HornFor - TrainConfig.SoundPreRoll <= ServerTimeNow ) or not ( ServerTimeNow <= Duration2 + TrainConfig.SoundFadeOut ) then
        if Roll.IsPlaying then
            Roll:Stop( )
        end
    else
        local Number
        local PortalEast3 = PortalEast2 - Dir * ( Amount * Value.len + ( Amount - 1 ) * TrainConfig.Gap )
        local X = CurrentCamera.CFrame.Position.X
        local Min = math.min( PortalEast2, PortalEast3 )
        local Clamp = math.clamp( X, Min, ( math.max( PortalEast2, PortalEast3 ) ) )
        table.insert( Table2, Value.rollPart )
        table.insert( Table3, CFrame.new( Clamp, Value.cfg.Y, Value.cfg.Z ) )
        local RollPitch = Value.rollPitch
        local Y = Value.cfg.Y
        local Vector33 = Vector3.new( Clamp, Y, Value.cfg.Z )

        if TrainConfig.DopplerSound then
            local Position = CurrentCamera.CFrame.Position - Vector33
            local Magnitude = Position.Magnitude

            if Magnitude < 1 then
                Number = 1
            else
                local Dot = Vector32:Dot( Position / Magnitude )
                Number = TrainConfig.DopplerSound / math.max( TrainConfig.DopplerSound - Dot, 1 )
            end
        else
            Number = 1
        end

        Value.rollPitch = ( RollPitch or Number ) + ( Number - ( RollPitch or Number ) ) * ( 1 - math.exp( -Argument6 * 10 ) )
        Roll.PlaybackSpeed = Value.rollPitch
        local Total = ( ServerTimeNow - HornFor + TrainConfig.SoundPreRoll ) / TrainConfig.SoundPreRoll
        local Min2 = math.min( Total, ( Duration2 + TrainConfig.SoundFadeOut - ServerTimeNow ) / TrainConfig.SoundFadeOut )
        Roll.Volume = TrainConfig.RollVolume * math.clamp( Min2, 0, 1 )

        if not Roll.IsPlaying then
            Roll.TimePosition = Random2:NextNumber( 0, ( math.max( Roll.TimeLength - 0.5, 0 ) ) )
            Roll:Play( )
        end
    end

    local Attribute = Trains:GetAttribute( Value.cfg.Name .. "_Horn" )

    if HornFor and Attribute and Value.hornFor ~= HornFor and HornFor + Attribute <= ServerTimeNow then
        Value.hornFor = HornFor

        if ServerTimeNow - ( HornFor + Attribute ) < 0.3 then
            local Horn = Value.horn
            Horn.Volume = TrainConfig.HornVolume
            Value.horn.TimePosition = 0
            Value.hornPitch = nil
            Value.horn:Play( )
        end
    end
    if HornFor and Value.horn.IsPlaying then
        local Number2
        table.insert( Table2, Value.hornPart )
        table.insert( Table3, CFrame.new( PortalEast2, Value.cfg.Y, Value.cfg.Z ) )
        local HornPitch = Value.hornPitch
        local Y2 = Value.cfg.Y
        local Vector34 = Vector3.new( PortalEast2, Y2, Value.cfg.Z )

        if TrainConfig.DopplerSound then
            local Position2 = CurrentCamera.CFrame.Position - Vector34
            local Magnitude2 = Position2.Magnitude

            if Magnitude2 < 1 then
                Number2 = 1
            else
                local Dot2 = Vector32:Dot( Position2 / Magnitude2 )
                Number2 = TrainConfig.DopplerSound / math.max( TrainConfig.DopplerSound - Dot2, 1 )
            end
        else
            Number2 = 1
        end

        Value.hornPitch = ( HornPitch or Number2 ) + ( Number2 - ( HornPitch or Number2 ) ) * ( 1 - math.exp( -Argument6 * 10 ) )
        local Horn2 = Value.horn
        Horn2.PlaybackSpeed = Value.hornPitch
    end
end

RunService.PreRender:Connect( function( Argument1 )
    local ServerTimeNow = workspace:GetServerTimeNow( )
    table.clear( Table2 )
    table.clear( Table3 )

    for Index, Value in ipairs( Table ) do
        local Attribute4
        local Name = Value.cfg.Name
        local Dir = Value.cfg.Dir
        local Attribute = Trains:GetAttribute( Name .. "_Start" )
        local Attribute2 = Trains:GetAttribute( Name .. "_Cars" ) or 0
        local Attribute3 = Trains:GetAttribute( Name .. "_Speed" )
        Attribute4 = if Attribute3 then Attribute3 else TrainConfig.SpeedMin
        local Attribute5 = if Attribute then ( ServerTimeNow - Attribute ) * Attribute4 else Attribute
        local Flag

        if Attribute5 == nil then
            Flag = false
        elseif Attribute5 >= 0 then
            local Duration = TrainConfig.Duration

            if Attribute5 <= Duration( Attribute2, Value.len, Attribute4 ) * Attribute4 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end

        local Flag5

        if Flag then
            local PortalEast

            if Dir > 0 then
                PortalEast = TrainConfig.PortalEast
            else
                PortalEast = TrainConfig.PortalWest
            end

            Flag5 = PortalEast + Dir * Attribute5
        else
            Flag5 = Flag
        end

        local Max = math.max( Attribute2, #Value.cars )
        local J = 1

        for J = 1, Max do
            local Flag4

            if not Flag or not ( J <= Attribute2 ) then
                Flag4 = nil
            else
                local Flag2 = Flag5 - Dir * ( Value.len / 2 + ( J - 1 ) * ( Value.len + TrainConfig.Gap ) )

                if Flag2 + Value.len / 2 <= TrainConfig.PortalEast then
                    Flag4 = nil
                else
                    local Flag3 = Flag2 - Value.len / 2

                    if TrainConfig.PortalWest <= Flag3 then
                        Flag4 = nil
                    else
                        Flag4 = Flag2
                    end
                end
            end
            if Flag4 then
                local Entry2
                local Entry = Value.cars[ J ]

                if Entry then
                    Entry2 = Entry
                else
                    local Clone = Value.template:Clone( )
                    Clone.Name = Value.cfg.Name .. "_Wagon" .. J
                    Clone.Anchored = true
                    Clone.CanCollide = false
                    Clone.CanQuery = false
                    Clone.CanTouch = false
                    Value.cars[ J ] = Clone
                    Entry2 = Clone
                end
                if Entry2.Parent ~= Folder then
                    Entry2.Parent = Folder
                end

                table.insert( Table2, Entry2 )
                table.insert( Table3, CFrame.new( Flag4, Value.cfg.Y, Value.cfg.Z ) * Value.rot )
            elseif Value.cars[ J ] and Value.cars[ J ].Parent then
                Value.cars[ J ].Parent = nil
            end
        end

        UpdateSound( Value, ServerTimeNow, Attribute, Attribute2, Attribute4, Argument1 )
    end
    if #Table2 > 0 then
        workspace:BulkMoveTo( Table2, Table3, Enum.BulkMoveMode.FireCFrameChanged )
    end
end )
