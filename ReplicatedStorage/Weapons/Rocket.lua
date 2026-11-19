-- ReplicatedStorage.Weapons.Rocket
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Debris = game:GetService( "Debris" )
local TweenService = game:GetService( "TweenService" )
local VisualRegistry = require( script.Parent:WaitForChild( "VisualRegistry" ) )
local Eau = require( ReplicatedStorage:WaitForChild( "Eau" ) )
local FarmZone = require( ReplicatedStorage:WaitForChild( "FarmZone" ) )
local RPGRocket = ReplicatedStorage:WaitForChild( "WeaponFX" ):WaitForChild( "RPGRocket" )
local FX = workspace:WaitForChild( "FX" )
local RPG_Explosion = ReplicatedStorage:WaitForChild( "FX" ):WaitForChild( "Explosions" ):WaitForChild( "RPG_Explosion" )
local Angles = CFrame.Angles( 0, -1.5707963267948966, 0 )

local function Scaled( Argument1, Argument2 )
    local Value1
    local Table = { }
    local Keypoints = Argument1.Keypoints
    Value1 = nil

    for Key, Value in Keypoints, nil, nil do
        table.insert( Table, NumberSequenceKeypoint.new( Value.Time, Value.Value * Argument2, Value.Envelope * Argument2 ) )
    end

    return NumberSequence.new( Table )
end

local Table2 = { }
local Table3 = { }
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.CollisionGroup = "Bullet"

local function Sound( Parent, Text, Amount, Amount2, Amount3, Amount4 )
    if not Text or ( Amount or 1 ) <= 0.01 then
        return nil
    end

    local WorldPosition

    if not Parent:IsA( "Attachment" ) or not Parent.WorldPosition then
        if not Parent:IsA( "BasePart" ) or not Parent.Position then
            WorldPosition = nil
        else
            WorldPosition = Parent.Position
        end
    else
        WorldPosition = Parent.WorldPosition
    end
    if not WorldPosition or FarmZone.SameSide( WorldPosition ) then
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = "rbxassetid://" .. Text
        Sound.Volume = Amount or 1
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound.RollOffMinDistance = Amount2 or 20
        Sound.RollOffMaxDistance = Amount3 or 1500
        Sound.Parent = Parent
        Sound:Play( )
        Debris:AddItem( Sound, Amount4 or 8 )
        return Sound
    end
    return nil
end

local function PointAt( WorldPosition, Amount )
    local Attachment = Instance.new( "Attachment" )
    Attachment.WorldPosition = WorldPosition
    Attachment.Parent = workspace.Terrain
    Debris:AddItem( Attachment, Amount or 6 )
    return Attachment
end

local function Stop( Argument1 )
    if Argument1.done then
        return
    end

    Argument1.done = true

    if Argument1.sound then
        TweenService:Create( Argument1.sound, TweenInfo.new( 0.15 ), { Volume = 0 } ):Play( )
    end
    for Key, Value in Argument1.model:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            Value.Enabled = false
        end
        if Value:IsA( "BasePart" ) then
            Value.Transparency = 1
        end
    end

    Debris:AddItem( Argument1.model, 3.5 )
end

local Table = {
    Launch = function( Key, Parent, WorldPosition, Argument4, Argument5, Argument6 )
        if Table3[ Key ] or Table2[ Key ] then
            return
        end

        local GunFX

        if Parent then
            local Entry = VisualRegistry[ Parent ]

            if Entry then
                GunFX = Entry
            else
                GunFX = Parent:FindFirstChild( "GunFX" )
            end
        else
            GunFX = Parent
        end
        if GunFX then
            for Key3, Value in GunFX:GetDescendants( ) do
                if Value:IsA( "ParticleEmitter" ) then
                    local BurstTime = Value:GetAttribute( "BurstTime" )

                    if not BurstTime or not ( Value.Rate > 0 ) then
                        Value:Emit( Value:GetAttribute( "EmitCount" ) or 3 )
                    else
                        local BurstTok = ( Value:GetAttribute( "BurstTok" ) or 0 ) + 1
                        Value:SetAttribute( "BurstTok", BurstTok )
                        Value.Enabled = true
                        task.delay( BurstTime, function()
                            if Value:GetAttribute( "BurstTok" ) == BurstTok then
                                Value.Enabled = false
                            end
                        end )
                    end
                end
            end
        end

        local RearFX

        if GunFX then
            RearFX = GunFX:FindFirstChild( "RearFX", true )
        else
            RearFX = GunFX
        end

        local Entry2

        if not RearFX or not RearFX:IsA( "BasePart" ) or not RearFX then
            local WorldPosition2 = WorldPosition - Argument4.Unit * 4.4
            local Attachment = Instance.new( "Attachment" )
            Attachment.WorldPosition = WorldPosition2
            Attachment.Parent = workspace.Terrain
            Debris:AddItem( Attachment, 6 )
            Entry2 = Attachment
        else
            Entry2 = RearFX
        end

        local Flag
        Sound( Entry2, ( Argument6 or { } ).BackBlast, ( Argument6 or { } ).BackBlastVolume, ( Argument6 or { } ).BackBlastRollMin, ( Argument6 or { } ).BackBlastRollMax )

        if Parent == nil then
            Flag = false
        elseif Parent == Players.LocalPlayer.Character then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            local Attachment2 = Instance.new( "Attachment" )
            Attachment2.WorldPosition = WorldPosition
            Attachment2.Parent = workspace.Terrain
            Debris:AddItem( Attachment2, 6 )
            Sound( Attachment2, ( Argument6 or { } ).Launch, ( Argument6 or { } ).LaunchVolume, ( Argument6 or { } ).LaunchRollMin, ( Argument6 or { } ).LaunchRollMax )
        end

        local Clone = RPGRocket:Clone( )
        Clone:PivotTo( CFrame.lookAt( WorldPosition, WorldPosition + Argument4 ) * Angles )
        Clone.Parent = FX

        for Key4, Value2 in Clone:GetDescendants( ) do
            if Value2:IsA( "ParticleEmitter" ) then
                Value2.Enabled = true
            end
        end

        local PrimaryPart2
        local PrimaryPart = Clone.PrimaryPart
        PrimaryPart2 = if PrimaryPart then PrimaryPart else Clone:FindFirstChildWhichIsA( "BasePart" )
        local Flight = ( Argument6 or { } ).Flight
        local FlightVolume = ( Argument6 or { } ).FlightVolume
        local FlightRollMin = ( Argument6 or { } ).FlightRollMin
        local Sound2 = Sound( PrimaryPart2, Flight, FlightVolume, FlightRollMin, ( Argument6 or { } ).FlightRollMax, 12 )
        local Unit = Argument4.Unit * Argument5.Speed
        local Gravity = Argument5.Gravity or 0
        Table2[ Key ] = {
            model = Clone,
            pos = WorldPosition,
            vel = Unit,
            gravity = Gravity,
            left = Argument5.Range or 400,
            shooter = Parent,
            sound = Sound2
        }
    end,
    Explode = function( Key, WorldPosition, Argument3 )
        Table3[ Key ] = true
        task.delay( 10, function()
            Table3[ Key ] = nil
        end )
        local Entry = Table2[ Key ]

        if Entry then
            Entry.model:PivotTo( CFrame.new( WorldPosition ) * Entry.model:GetPivot( ).Rotation )
            Stop( Entry )
            Table2[ Key ] = nil
        end

        local Parent = Instance.new( "Attachment" )
        Parent.WorldPosition = WorldPosition
        Parent.Parent = workspace.Terrain
        Debris:AddItem( Parent, 8 )

        for Key2, Value in RPG_Explosion:GetDescendants( ) do
            if Value:IsA( "ParticleEmitter" ) then
                local Clone = Value:Clone( )
                Clone.Enabled = false
                Clone.Size = Scaled( Clone.Size, 1.4 )
                Clone.Speed = NumberRange.new( Clone.Speed.Min * 1.4, Clone.Speed.Max * 1.4 )
                Clone.Parent = Parent
                Clone:Emit( Value:GetAttribute( "EmitCount" ) or 10 )
            end
        end

        local Clamp = math.clamp( ( ( workspace.CurrentCamera.CFrame.Position - WorldPosition ).Magnitude - ( ( Argument3 or { } ).FarStart or 60 ) ) / ( ( ( Argument3 or { } ).FarEnd or 220 ) - ( ( Argument3 or { } ).FarStart or 60 ) ), 0, 1 )
        local Cos = math.cos( Clamp * 3.141592653589793 / 2 )
        local Sin = math.sin( Clamp * 3.141592653589793 / 2 )
        local Explosion = ( Argument3 or { } ).Explosion
        local ExplosionVolume = ( ( Argument3 or { } ).ExplosionVolume or 1 ) * Cos
        local RollMin = ( Argument3 or { } ).RollMin
        Sound( Parent, Explosion, ExplosionVolume, RollMin, ( Argument3 or { } ).RollMax, 8 )
        local ExplosionFar = ( Argument3 or { } ).ExplosionFar
        local ExplosionFarVolume = ( ( Argument3 or { } ).ExplosionFarVolume or 1 ) * Sin
        local FarRollMin = ( Argument3 or { } ).FarRollMin
        Sound( Parent, ExplosionFar, ExplosionFarVolume, FarRollMin, ( Argument3 or { } ).FarRollMax, 10 )
    end
}
RunService.RenderStepped:Connect( function( Argument1 )
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value.done or not Value.model.Parent then
            Table2[ Key ] = nil
        else
            local Raycast2
            local Vel = Value.vel * Argument1
            RaycastParams2.FilterDescendantsInstances = { FX, Value.shooter }
            local Raycast = workspace:Raycast( Value.pos, Vel, RaycastParams2 )

            if Raycast then
                Raycast2 = Raycast.Position
            else
                Raycast2 = Raycast
            end

            local Raycast4
            local Entree = Eau.Entree
            local Pos = Value.pos

            if Raycast2 then
                local Raycast3 = Raycast2 - Value.pos

                if Raycast3 then
                    Raycast4 = Raycast3
                else
                    Raycast4 = Vel
                end
            else
                Raycast4 = Vel
            end

            local Entree2 = Entree( Pos, Raycast4 )

            if Entree2 then
                Raycast2 = Entree2
            end
            if Raycast2 then
                Value.model:PivotTo( CFrame.lookAt( Raycast2, Raycast2 + Value.vel ) * Angles )
                Stop( Value )
                Table2[ Key ] = nil
            else
                Value.pos = Value.pos + Vel
                Value.vel = Value.vel + Vector3.new( 0, -Value.gravity * Argument1, 0 )
                Value.left = Value.left - Vel.Magnitude
                Value.model:PivotTo( CFrame.lookAt( Value.pos, Value.pos + Value.vel ) * Angles )

                if Value.left <= 0 then
                    Stop( Value )
                    Table2[ Key ] = nil
                end
            end
        end
    end
end )
return Table
