-- Players.perkbrokeyou.PlayerScripts.KillEffectsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Parent = game:GetService( "SoundService" )
local ContentProvider = game:GetService( "ContentProvider" )
local RunService = game:GetService( "RunService" )
local KillEffects = require( ReplicatedStorage:WaitForChild( "KillEffects" ) )
local KillFX = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "KillFX" )
local KillFX2 = ReplicatedStorage:WaitForChild( "KillFX" )
local CurrentCamera = workspace.CurrentCamera
local Table = { }
local Effects = KillEffects.Effects
Value1 = nil

for Key, Value in Effects, nil, nil do
    if Value.Sound then
        local Sound = Instance.new( "Sound" )
        Sound.Name = "KillFX_" .. Key
        Sound.SoundId = "rbxassetid://" .. Value.Sound
        Sound.Volume = Value.Volume or 1
        Sound.Parent = Parent
        Table[ Key ] = Sound
    end
end

task.spawn( function()
    local Value1
    local TableInner = { }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        table.insert( TableInner, Value )
    end

    pcall( ContentProvider.PreloadAsync, ContentProvider, TableInner )
end )

local function PlaySound( SoundName, Argument2, Argument3, Argument4 )
    local Entry = Table[ SoundName ]

    if Entry then
        local Volume = Argument2.Volume or 1
        local SoundVolumeFor = KillEffects.SoundVolumeFor
        Entry.Volume = Volume * SoundVolumeFor( ( CurrentCamera.CFrame.Position - Argument3 ).Magnitude, Argument4, Argument2 )
        Entry.TimePosition = Argument2.SoundStart or 0
        Entry:Play( )
        return
    end
    return
end

local function Burst( Object, Argument2 )
    local Number = 0

    for Key, Value in Object:GetDescendants( ) do
        if not Value:IsA( "ParticleEmitter" ) or Value == Argument2 or not Value:GetAttribute( "FXOn" ) then
            if Value:IsA( "Sound" ) and not Argument2 then
                Value:Play( )
                Number = math.max( Number, Value.TimeLength )
            end
        else
            local EmitCount = Value:GetAttribute( "EmitCount" ) or 10
            local EmitDelay = Value:GetAttribute( "EmitDelay" ) or 0

            if EmitDelay > 0 then
                task.delay( EmitDelay, function()
                    if Value.Parent then
                        Value:Emit( EmitCount )
                    end
                end )
            else
                Value:Emit( EmitCount )
            end

            Number = math.max( Number, EmitDelay + Value.Lifetime.Max )
        end
    end

    return Number
end

local Table2 = {
    [ Enum.NormalId.Top ] = Vector3.new( 0, 1, 0 ),
    [ Enum.NormalId.Bottom ] = Vector3.new( -0, -1, -0 ),
    [ Enum.NormalId.Right ] = Vector3.new( 1, 0, 0 ),
    [ Enum.NormalId.Left ] = Vector3.new( -1, -0, -0 ),
    [ Enum.NormalId.Front ] = Vector3.new( -0, -0, -1 ),
    [ Enum.NormalId.Back ] = Vector3.new( 0, 0, 1 )
}

local function LaunchTurn( Object, Argument2 )
    local Value1

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            if Value.Name == Argument2 then
                Value1 = Value
                break
            end
        end

        Value1 = nil
    end

    local Parent = if Value1 then Value1.Parent else Value1
    local WorldCFrame

    if Parent then
        if not Parent:IsA( "Attachment" ) or not Parent.WorldCFrame then
            if not Parent:IsA( "BasePart" ) or not Parent.CFrame then
                WorldCFrame = nil
            else
                WorldCFrame = Parent.CFrame
            end
        else
            WorldCFrame = Parent.WorldCFrame
        end
    else
        WorldCFrame = nil
    end

    local Min2

    if Value1 then
        local Min = ( Value1.Speed.Min + Value1.Speed.Max ) / 2

        if Min then
            Min2 = Min
        else
            Min2 = 0
        end
    else
        Min2 = 0
    end
    if not WorldCFrame or math.abs( Min2 ) < 0.001 then
        return CFrame.identity
    end

    local VectorToWorldSpace = WorldCFrame:VectorToWorldSpace( Table2[ Value1.EmissionDirection ] or Vector3.new( 0, 1, 0 ) ) * math.sign( Min2 )
    local Clamp = math.clamp( VectorToWorldSpace:Dot( Vector3.new( -0, -1, -0 ) ), -1, 1 )

    if Clamp > 0.9999 then
        return CFrame.identity
    end
    if Clamp < -0.9999 then
        return CFrame.fromAxisAngle( Vector3.new( 1, 0, 0 ), 3.141592653589793 )
    end
    return CFrame.fromAxisAngle( VectorToWorldSpace:Cross( Vector3.new( -0, -1, -0 ) ).Unit, ( math.acos( Clamp ) ) )
end

local function Play( p1, p2, Flag, p4 )
    -- Could not structure function #8
end

KillFX.OnClientEvent:Connect( function( Argument1, Argument2, Argument3, Argument4 )
    if typeof( Argument2 ) ~= "Vector3" then
        return
    end

    local Flag

    if Argument3 == nil then
        Flag = false
    elseif Argument3 == Players.LocalPlayer.UserId then
        Flag = false
    else
        Flag = true
    end

    local CurrentCamera = workspace.CurrentCamera

    if Flag and CurrentCamera then
        local Magnitude = ( CurrentCamera.CFrame.Position - Argument2 ).Magnitude

        if KillEffects.VIEW_DISTANCE < Magnitude then
            return
        end
    end

    local Flag2 = Argument4 == true and true or false
    Play( Argument1, Argument2, Flag, Flag2 )
end )

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Min3
local Min = math.min( ( os.clock( ) - Upvalue1 ) / Upvalue2.Time, 1 )

if Upvalue2.Ease then
    local Min2 = 1 - ( 1 - Min ) ^ Upvalue2.Ease

    if Min2 then
        Min3 = Min2
    else
        Min3 = Min
    end
else
    Min3 = Min
end

local Value1
local Captured = Upvalue3 + Vector3.new( 0, Upvalue4 * Min3, 0 )
local Create = table.create( #Upvalue5 )
Value1 = nil

for Value in Upvalue5, nil, nil do
    Create[ Value ] = Captured * Upvalue6[ Value ]
end

workspace:BulkMoveTo( Upvalue5, Create, Enum.BulkMoveMode.FireCFrameChanged )

if Min < 1 then
    return
end

Upvalue7:Disconnect( )

if Upvalue8 then
    Upvalue8.Enabled = false
end

local Position = Upvalue3.Position + Vector3.new( 0, Upvalue4, 0 )
local Entry = Upvalue12[ Upvalue9 ]

if Entry then
    local Volume = Upvalue10.Volume or 1
    local SoundVolumeFor = Upvalue13.SoundVolumeFor
    Entry.Volume = Volume * SoundVolumeFor( ( Upvalue14.CFrame.Position - Position ).Magnitude, Upvalue11, Upvalue10 )
    Entry.TimePosition = Upvalue10.SoundStart or 0
    Entry:Play( )
end

local Max2
local Value2 = Upvalue15( Upvalue16, Upvalue8 )

if Upvalue8 then
    local Max = Upvalue8.Lifetime.Max

    if Max then
        Max2 = Max
    else
        Max2 = 0
    end
else
    Max2 = 0
end

task.delay( math.max( Value2, Max2 ) + 0.3, function()
    Upvalue16:Destroy( )
end )
]]
