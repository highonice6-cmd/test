-- StarterPlayer.StarterPlayerScripts.ConfirmFXClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Parent = game:GetService( "SoundService" )
local RunService = game:GetService( "RunService" )
local Config = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "Config" ) )
local ConfirmFX = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "ConfirmFX" )
local ConfirmFX2 = ReplicatedStorage:WaitForChild( "ConfirmFX" )
local LocalPlayer = Players.LocalPlayer
local Parent2 = Instance.new( "Sound" )
Parent2.Name = "ConfirmSound"
Parent2.SoundId = "rbxassetid://" .. Config.ConfirmSound
Parent2.Volume = Config.ConfirmVolume or 0.8
Parent2.Parent = Parent
local PitchShiftSoundEffect = Instance.new( "PitchShiftSoundEffect" )
PitchShiftSoundEffect.Enabled = false
PitchShiftSoundEffect.Parent = Parent2

local function SpeedOf( Key, Key2 )
    local ConfirmSpeed2
    local ConfirmSpeed = Config.ConfirmSpeed
    ConfirmSpeed2 = if ConfirmSpeed then Config.ConfirmSpeed[ Key ] else ConfirmSpeed
    local Entry = ConfirmSpeed2 and ConfirmSpeed2[ Key2 ] or 1
    return Entry
end

local function Burst( Name, Object )
    local HumanoidRootPart

    if Object then
        HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Object
    end

    local FoundChild = ConfirmFX2:FindFirstChild( Config.ConfirmFX[ Name ] or "" )

    if not HumanoidRootPart or not FoundChild or not FoundChild:IsA( "BasePart" ) then
        return
    end

    local Value1
    local Clone = FoundChild:Clone( )
    local Table = { Clone, table.unpack( Clone:GetDescendants( ) ) }
    Value1 = nil

    for Key2, Value in Table, nil, nil do
        if Value:IsA( "BasePart" ) then
            Value.Anchored = true
            Value.CanCollide = false
            Value.CanQuery = false
            Value.CanTouch = false
            Value.CastShadow = false
        end
    end

    local Parent
    Clone.CFrame = HumanoidRootPart.CFrame
    local FX = workspace:FindFirstChild( "FX" )
    Parent = if FX then FX else workspace
    local ConfirmSpeed2
    Clone.Parent = Parent
    local ConfirmSpeed = Config.ConfirmSpeed
    ConfirmSpeed2 = if ConfirmSpeed then Config.ConfirmSpeed[ Name ] else ConfirmSpeed
    local FX2 = ConfirmSpeed2 and ConfirmSpeed2.FX or 1
    local Number = 0

    for Key3, Value2 in Clone:GetDescendants( ) do
        if Value2:IsA( "ParticleEmitter" ) then
            local Enabled = Value2.Enabled
            Value2.Enabled = false

            if FX2 ~= 1 then
                Value2.Lifetime = NumberRange.new( Value2.Lifetime.Min / FX2, Value2.Lifetime.Max / FX2 )
                Value2.Speed = NumberRange.new( Value2.Speed.Min * FX2, Value2.Speed.Max * FX2 )
                Value2.RotSpeed = NumberRange.new( Value2.RotSpeed.Min * FX2, Value2.RotSpeed.Max * FX2 )
            end
            if Enabled then
                local EmitCount = Value2:GetAttribute( "EmitCount" ) or 10
                local EmitDelay = ( Value2:GetAttribute( "EmitDelay" ) or 0 ) / FX2

                if EmitDelay > 0 then
                    task.delay( EmitDelay, function()
                        if Value2.Parent then
                            Value2:Emit( EmitCount )
                        end
                    end )
                else
                    Value2:Emit( EmitCount )
                end

                Number = math.max( Number, EmitDelay + Value2.Lifetime.Max )
            end
        end
    end

    local Connect = RunService.RenderStepped:Connect( function()
        if HumanoidRootPart.Parent then
            Clone.CFrame = HumanoidRootPart.CFrame
        end
    end )
    task.delay( Number + 0.3, function()
        Connect:Disconnect( )
        Clone:Destroy( )
    end )
end

local Table = {
    MAX = 6,
    DIST = 100,
    G = 130,
    BOUNCE = 0.5,
    BOUNCES = 3,
    MIN_BOUNCE = 4,
    REST = 0.3,
    FADE = 0.2,
    RADIUS = 0.2,
    DOWN = 40
}
local Table2 = { }
local Table3 = { }
local Number = 0
local Table4 = { }
local Table5 = { }
local Value1 = nil
local Random2 = Random.new( )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
RaycastParams2.IgnoreWater = true

local function NewBottle( BouteilleEDrink )
    local Clone = BouteilleEDrink:Clone( )
    local PrimaryPart = Clone.PrimaryPart
    local Table = { model = Clone, parts = { } }

    for Key, Value in Clone:GetChildren( ) do
        if Value:IsA( "BasePart" ) then
            local Parts = Table.parts
            table.insert( Parts, {
                part = Value,
                off = PrimaryPart.CFrame:ToObjectSpace( Value.CFrame ),
                tr = Value.Transparency
            } )
        end
    end

    Number = Number + 1
    return Table
end

local function ReleaseBottle( Argument1 )
    local Value1
    Argument1.model.Parent = nil
    local Parts = Argument1.parts
    Value1 = nil

    for Key, Value in Parts, nil, nil do
        local Part = Value.part
        Part.Transparency = Value.tr
    end

    table.insert( Table2, Argument1 )
end

local function StepBottles( Argument1 )
    local Number
    local Min = math.min( Argument1, 0.05 )
    table.clear( Table4 )
    table.clear( Table5 )
    local Count = #Table3
    local I = Count
    Number = 0

    for I = Count, 1, -1 do
        local Flag
        local Entry = Table3[ I ]

        if Entry.restT then
            Entry.restT = Entry.restT + Min
            Entry.rot = Entry.rot:Lerp( Entry.flat, ( math.min( 1, Min * 20 ) ) )
            local RestT = ( Entry.restT - 0.3 ) / 0.2

            if RestT >= 1 then
                Flag = true
            elseif RestT > 0 then
                local Value1Inner
                local Parts = Entry.parts
                Value1Inner = nil

                for Key, Value in Parts, nil, nil do
                    local Part = Value.part
                    Part.Transparency = Value.tr + ( 1 - Value.tr ) * RestT
                end

                Flag = false
            else
                Flag = false
            end
        else
            Entry.vel = Entry.vel - Vector3.new( 0, 1, 0 ) * ( 130 * Min )
            Entry.pos = Entry.pos + Entry.vel * Min
            Entry.rot = Entry.rot * CFrame.fromAxisAngle( Entry.axis, Entry.spin * Min )

            if not ( Entry.pos.Y <= Entry.floor ) or not ( Entry.vel.Y < 0 ) then
                Flag = false
            else
                local Vel = Entry.vel
                local X = Entry.pos.X
                local Floor = Entry.floor
                Entry.pos = Vector3.new( X, Floor, Entry.pos.Z )
                Entry.hits = Entry.hits + 1

                if Entry.hits > 3 or -Vel.Y * 0.5 < 4 then
                    Entry.restT = 0
                    Flag = false
                else
                    local X2 = Vel.X * 0.55
                    local Amount = -Vel.Y * 0.5
                    Entry.vel = Vector3.new( X2, Amount, Vel.Z * 0.55 )
                    Entry.spin = Entry.spin * 0.7
                    Flag = false
                end
            end
        end
        if Flag then
            local Value2
            table.remove( Table3, I )
            Entry.model.Parent = nil
            local Parts2 = Entry.parts
            Value2 = nil

            for Key2, Value3 in Parts2, nil, nil do
                local Part2 = Value3.part
                Part2.Transparency = Value3.tr
            end

            table.insert( Table2, Entry )
        else
            local Value4
            local CFrame2 = CFrame.new( Entry.pos ) * Entry.rot
            local Parts3 = Entry.parts
            Value4 = nil

            for Key3, Value5 in Parts3, nil, nil do
                local Number2 = Number + 1
                local Part3 = Value5.part
                local CFrame3 = CFrame2 * Value5.off
                Table4[ Number2 ] = Part3
                Table5[ Number2 ] = CFrame3
                Number = Number2
            end
        end
    end
    if Number > 0 then
        workspace:BulkMoveTo( Table4, Table5, Enum.BulkMoveMode.FireCFrameChanged )
    end
    if #Table3 == 0 and Value1 then
        Value1:Disconnect( )
        Value1 = nil
    end
end

local function DropBottle( Self )
    local BouteilleEDrink
    local RightHand = Self:FindFirstChild( "RightHand" )
    local HumanoidRootPart = Self:FindFirstChild( "HumanoidRootPart" )
    local CurrentCamera = workspace.CurrentCamera
    local FX = ReplicatedStorage:FindFirstChild( "FX" )

    if FX then
        BouteilleEDrink = FX:FindFirstChild( "BouteilleEDrink" )
    else
        BouteilleEDrink = FX
    end
    if not RightHand or not HumanoidRootPart or not CurrentCamera or not BouteilleEDrink or ( CurrentCamera.CFrame.Position - RightHand.Position ).Magnitude > 100 then
        return
    end

    local Remove2
    local Remove = table.remove( Table2 )

    if Remove then
        Remove2 = Remove
    else
        if Number >= 6 then
            return
        end

        Remove2 = NewBottle( BouteilleEDrink )
    end

    local FilterDescendantsInstances = { workspace:FindFirstChild( "FX" ) }

    for Key, Value in Players:GetPlayers( ) do
        if Value.Character then
            table.insert( FilterDescendantsInstances, Value.Character )
        end
    end

    local Vel, Vector33
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local CFrame2 = HumanoidRootPart.CFrame
    local Pos = RightHand.Position
    local RightVector = CFrame2.RightVector * Random2:NextNumber( 3, 6 ) + CFrame2.LookVector * Random2:NextNumber( -1, 3 ) + HumanoidRootPart.AssemblyLinearVelocity * Vector3.new( 0.4000000059604645, 0, 0.4000000059604645 ) + Vector3.new( 0, Random2:NextNumber( 5, 9 ), 0 )
    local X = RightVector.X
    local Vector32 = Vector3.new( X, 0, RightVector.Z ) * 0.45

    if not ( Vector32.Magnitude > 0.1 ) or not workspace:Raycast( Pos, Vector32, RaycastParams2 ) then
        Vector33 = Vector32
        Vel = RightVector
    else
        Vel = Vector3.new( 0, RightVector.Y, 0 )
        Vector33 = Vector3.new( 0, 0, 0 )
    end

    local Raycast = workspace:Raycast( Pos + Vector33, Vector3.new( 0, -40, 0 ), RaycastParams2 )

    if not Raycast then
        table.insert( Table2, Remove2 )
        return
    end

    local Value1Inner
    local Rot = RightHand.CFrame.Rotation
    Remove2.pos = Pos
    Remove2.vel = Vel
    Remove2.rot = Rot
    Remove2.floor = Raycast.Position.Y + 0.2
    Remove2.hits = 0
    Remove2.restT = nil
    local Axis = Random2:NextUnitVector( )
    local Spin = Random2:NextNumber( 10, 18 )
    Remove2.axis = Axis
    Remove2.spin = Spin
    Remove2.flat = CFrame.Angles( 0, Random2:NextNumber( 0, 6.283185307179586 ), 0 ) * CFrame.Angles( 1.5707963267948966, 0, 0 )
    local CFrame3 = CFrame.new( Remove2.pos ) * Remove2.rot
    local Parts = Remove2.parts
    Value1Inner = nil

    for Key2, Value2 in Parts, nil, nil do
        local Part = Value2.part
        Part.CFrame = CFrame3 * Value2.off
    end

    local Parent
    local Model = Remove2.model
    local FX2 = workspace:FindFirstChild( "FX" )
    Parent = if FX2 then FX2 else workspace
    Model.Parent = Parent
    table.insert( Table3, Remove2 )

    if not Value1 then
        Value1 = RunService.Heartbeat:Connect( StepBottles )
    end
end

ConfirmFX.OnClientEvent:Connect( function( Name, Object2 )
    if not ( Object2 or LocalPlayer.Character ) then
        return
    end

    local ConfirmSpeed2
    local ConfirmSpeed = Config.ConfirmSpeed
    ConfirmSpeed2 = if ConfirmSpeed then Config.ConfirmSpeed[ Name ] else ConfirmSpeed
    local PlaybackSpeed = ConfirmSpeed2 and ConfirmSpeed2.Sound or 1
    local ConfirmSpeed4
    local ConfirmSpeed3 = Config.ConfirmSpeed
    ConfirmSpeed4 = if ConfirmSpeed3 then Config.ConfirmSpeed[ Name ] else ConfirmSpeed3
    local Pitch = ConfirmSpeed4 and ConfirmSpeed4.Pitch or 1
    local Octave = math.clamp( Pitch / PlaybackSpeed, 0.5, 2 )

    if ( Object2 or LocalPlayer.Character ) == LocalPlayer.Character then
        local Enabled
        Parent2.PlaybackSpeed = PlaybackSpeed
        PitchShiftSoundEffect.Octave = Octave
        Enabled = math.abs( Octave - 1 ) > 0.001 and true or false
        PitchShiftSoundEffect.Enabled = Enabled
        Parent2.TimePosition = 0
        Parent2:Play( )
    else
        local Parent = ( Object2 or LocalPlayer.Character ):FindFirstChild( "HumanoidRootPart" )

        if Parent then
            local Enabled2
            local Clone = Parent2:Clone( )
            Clone.RollOffMode = Enum.RollOffMode.InverseTapered
            Clone.RollOffMinDistance = 8
            Clone.RollOffMaxDistance = 50
            Clone.PlaybackSpeed = PlaybackSpeed
            local PitchShiftSoundEffectInner = Clone:FindFirstChildOfClass( "PitchShiftSoundEffect" )
            PitchShiftSoundEffectInner.Octave = Octave
            Enabled2 = math.abs( Octave - 1 ) > 0.001 and true or false
            PitchShiftSoundEffectInner.Enabled = Enabled2
            Clone.Parent = Parent
            Clone:Play( )
            Clone.Ended:Once( function()
                Clone:Destroy( )
            end )
            task.delay( 5, function()
                if Clone.Parent then
                    Clone:Destroy( )
                end
            end )
        end
    end

    Burst( Name, Object2 or LocalPlayer.Character )

    if Name == "EDrink" then
        DropBottle( Object2 or LocalPlayer.Character )
    end
end )
