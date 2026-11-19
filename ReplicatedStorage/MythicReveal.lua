-- ReplicatedStorage.MythicReveal
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local LamboStudio3
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Parent = game:GetService( "SoundService" )
local TweenService = game:GetService( "TweenService" )
local Lighting = game:GetService( "Lighting" )
local ContentProvider = game:GetService( "ContentProvider" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local FX = ReplicatedStorage:WaitForChild( "FX" )
local LocalPlayer = Players.LocalPlayer
local ItemRender = require( Weapons:WaitForChild( "ItemRender" ) )
local SecretFX = require( ReplicatedStorage:WaitForChild( "SecretFX" ) )

local function StyleTitle( Self, Argument2 )
    local Tier = Self:FindFirstChild( "Tier" )
    local Line = Self:FindFirstChild( "Line" )

    if not Tier or not Line then
        return
    end
    if Tier:GetAttribute( "BaseText" ) == nil then
        Tier:SetAttribute( "BaseText", Tier.Text )
        Tier:SetAttribute( "BaseColor", Tier.TextColor3 )
        local UIStroke = Tier:FindFirstChildOfClass( "UIStroke" )

        if UIStroke then
            Tier:SetAttribute( "BaseStroke", UIStroke.Color )
        end

        Line:SetAttribute( "BaseColor", Line.BackgroundColor3 )
    end

    local Text
    local IsSecret = ItemRender.IsSecret( Argument2 )
    local UIStroke2 = Tier:FindFirstChildOfClass( "UIStroke" )

    if IsSecret then
        Text = "SECRET"
    else
        Text = Tier:GetAttribute( "BaseText" )
    end

    local TextColor3
    Tier.Text = Text

    if IsSecret then
        local BLACK = SecretFX.BLACK

        if BLACK then
            TextColor3 = BLACK
        else
            TextColor3 = Tier:GetAttribute( "BaseColor" )
        end
    else
        TextColor3 = Tier:GetAttribute( "BaseColor" )
    end

    Tier.TextColor3 = TextColor3

    if UIStroke2 then
        local Color

        if IsSecret then
            local FromRGB = Color3.fromRGB( 235, 235, 240 )

            if FromRGB then
                Color = FromRGB
            else
                local BaseStroke = Tier:GetAttribute( "BaseStroke" )

                if BaseStroke then
                    Color = BaseStroke
                else
                    Color = UIStroke2.Color
                end
            end
        else
            local BaseStroke = Tier:GetAttribute( "BaseStroke" )

            if BaseStroke then
                Color = BaseStroke
            else
                Color = UIStroke2.Color
            end
        end

        UIStroke2.Color = Color
    end

    local BackgroundColor3

    if IsSecret then
        local FromRGB2 = Color3.fromRGB( 235, 235, 240 )

        if FromRGB2 then
            BackgroundColor3 = FromRGB2
        else
            BackgroundColor3 = Line:GetAttribute( "BaseColor" )
        end
    else
        BackgroundColor3 = Line:GetAttribute( "BaseColor" )
    end

    Line.BackgroundColor3 = BackgroundColor3
end

local Table = {
    WEAPONS = {
        AWP = { shots = { 0 }, shells = true, bolt = 0.72, vol = 1.6 },
        DRAGON = { shots = { 0, 0.42 }, shells = true, vol = 2.2 },
        Eagle = { shots = { 0, 0.3 }, shells = true, vol = 1.5 },
        RPG = { rocket = true, vol = 1 },
        RiotShield = { scene = "Riot" }
    }
}
function Table.Supported( Key )
    local Flag

    if type( Key ) == "string" then
        if Table.WEAPONS[ Key ] == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    return Flag
end
local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "VehicleCrates" ) )

if not Success or not Result.SPECIAL_SOUND then
    LamboStudio3 = 89202009384278
else
    local LamboStudio = Result.SPECIAL_SOUND.LamboStudio

    if LamboStudio then
        LamboStudio3 = LamboStudio
    else
        LamboStudio3 = 89202009384278
    end
end

local LamboStudio4

if not Success or not Result.SPECIAL_START then
    LamboStudio4 = 0.18
else
    local LamboStudio2 = Result.SPECIAL_START.LamboStudio

    if LamboStudio2 then
        LamboStudio4 = LamboStudio2
    else
        LamboStudio4 = 0.18
    end
end

local function NewSound( Argument1, Amount, Amount2 )
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. tostring( Argument1 )
    Sound.Volume = Amount or 1
    Sound.PlaybackSpeed = Amount2 or 1
    Sound:SetAttribute( "CaseSound", true )
    Sound.Parent = Parent
    return Sound
end

local Sound = Instance.new( "Sound" )
Sound.SoundId = "rbxassetid://" .. tostring( LamboStudio3 )
Sound.Volume = 1.5
Sound.PlaybackSpeed = 1
Sound:SetAttribute( "CaseSound", true )
Sound.Parent = Parent
Sound.Name = "MythicWhoosh"
local Table2 = {
    rumble = 9126102694,
    clunk = 104157091834980,
    flicker = 166047422,
    rise = 95619349451044,
    sub = 1837830084,
    impact = 1843025542,
    aura = 138076087172612,
    boom = 109541594740226
}

local function WeaponSounds( SoundsName )
    local Sounds2
    local Entry = WeaponData[ SoundsName ]

    if Entry then
        local Sounds = Entry.Sounds

        if Sounds then
            Sounds2 = Sounds
        else
            local Table = { }

            if Table then
                Sounds2 = Table
            else
                Sounds2 = { }
            end
        end
    else
        Sounds2 = { }
    end

    local Single2
    local Single = Sounds2.Single
    Single2 = if type( Single ) == "table" then Single[ 1 ] else Single
    local SingleStart2
    local SingleStart = Sounds2.SingleStart
    SingleStart2 = if type( SingleStart ) == "table" then SingleStart[ 1 ] else SingleStart
    local Rocket
    local Table2 = { shot = Single2, start = SingleStart2 or 0, bolt = Sounds2.Bolt }
    Rocket = if Entry then Entry.RocketSounds else Entry
    Table2.rocket = Rocket
    return Table2
end

local Table3 = { }
function Table.Prepare( Key )
    if not Table.Supported( Key ) or Table3[ Key ] then
        return
    end

    Table3[ Key ] = true

    if Table.WEAPONS[ Key ].scene ~= "Riot" then
        task.spawn( function()
            local Rocket5
            local Table = { Sound }
            local WeaponSounds2 = WeaponSounds( Key )
            local Table2Inner = { }
            local Table3 = { }
            local Shot = WeaponSounds2.shot
            local Bolt = WeaponSounds2.bolt
            local Rocket = WeaponSounds2.rocket
            Rocket5 = if Rocket then WeaponSounds2.rocket.Launch else Rocket
            local Rocket6
            local Rocket2 = WeaponSounds2.rocket
            Rocket6 = if Rocket2 then WeaponSounds2.rocket.Explosion else Rocket2
            local Rocket7
            local Rocket3 = WeaponSounds2.rocket
            Rocket7 = if Rocket3 then WeaponSounds2.rocket.BackBlast else Rocket3
            local Rocket8
            local Rocket4 = WeaponSounds2.rocket
            Rocket8 = if Rocket4 then WeaponSounds2.rocket.Flight else Rocket4
            local Value2
            Table3[ 1 ] = Shot
            Table3[ 2 ] = Bolt
            Table3[ 3 ] = Rocket5
            Table3[ 4 ] = Rocket6
            Table3[ 5 ] = Rocket7
            Table3[ 6 ] = Rocket8
            Value2 = nil

            for KeyInner, Value in Table3, nil, nil do
                if Value then
                    local Sound2 = Instance.new( "Sound" )
                    Sound2.SoundId = "rbxassetid://" .. tostring( Value )
                    Sound2.Volume = 0
                    Sound2.PlaybackSpeed = 1
                    Sound2:SetAttribute( "CaseSound", true )
                    Sound2.Parent = Parent
                    table.insert( Table2Inner, Sound2 )
                    table.insert( Table, Sound2 )
                end
            end

            local Value3 = nil

            for Key2, Value4 in Table2, nil, nil do
                local SoundInner = Instance.new( "Sound" )
                SoundInner.SoundId = "rbxassetid://" .. tostring( Value4 )
                SoundInner.Volume = 0
                SoundInner.PlaybackSpeed = 1
                SoundInner:SetAttribute( "CaseSound", true )
                SoundInner.Parent = Parent
                table.insert( Table2Inner, SoundInner )
                table.insert( Table, SoundInner )
            end

            local WeaponStudio
            local Studios = ReplicatedStorage:FindFirstChild( "Studios" )

            if Studios then
                WeaponStudio = ReplicatedStorage.Studios:FindFirstChild( "WeaponStudio" )
            else
                WeaponStudio = Studios
            end
            if WeaponStudio then
                table.insert( Table, WeaponStudio )
            end

            local FoundChild = WeaponVisuals:FindFirstChild( Key )

            if FoundChild then
                table.insert( Table, FoundChild )
            end

            local Value5
            pcall( ContentProvider.PreloadAsync, ContentProvider, Table )
            Value5 = nil

            for Key3, Value6 in Table2Inner, nil, nil do
                Value6:Destroy( )
            end
        end )
        return
    end

    local Success, Result = pcall( require, script:WaitForChild( "RiotScene" ) )

    if Success then
        Result.Prepare( NewSound )
    end

    pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound } )
end
task.spawn( function()
    pcall( ContentProvider.PreloadAsync, ContentProvider, { Sound } )
end )

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function OutCubic( Argument1 )
    return 1 - ( 1 - math.clamp( Argument1, 0, 1 ) ) ^ 3
end

local function OutBack( Argument1, Amount )
    local Number = Amount or 1.7
    local Clamp = math.clamp( Argument1, 0, 1 ) - 1
    return 1 + ( Number + 1 ) * Clamp ^ 3 + Number * Clamp ^ 2
end

local function Lerp( Argument1, Argument2, Argument3 )
    return Argument1 + ( Argument2 - Argument1 ) * Argument3
end

local function Rnd( Argument1, Argument2 )
    return Argument1 + math.random( ) * ( Argument2 - Argument1 )
end

local function Kp( Argument1, Argument2 )
    return NumberSequenceKeypoint.new( Argument1, Argument2 )
end

local Rad = math.rad

local function Tween( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Create = TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out ), Argument3 )
    Create:Play( )
    return Create
end

function Table.Play( p1 )
    -- Could not structure function #130
end
function Table.Preview( Argument1 )
    if not RunService:IsStudio( ) then
        return false
    end

    local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
    local TableInner = {
        cf = workspace.CurrentCamera.CFrame,
        fov = 70,
        shake = 0,
        kick = 0,
        punch = 0
    }
    local Connect = RunService.RenderStepped:Connect( function( Amount )
        TableInner.kick = TableInner.kick * math.exp( -5 * Amount )
        TableInner.punch = TableInner.punch * math.exp( -6 * Amount )
        local Clock = os.clock( ) * 11
        local Rad = math.rad( TableInner.shake + TableInner.kick )
        local Angles = CFrame.Angles( Rad * 2 * math.noise( Clock, 0.31 ), Rad * 2 * math.noise( 0.73, Clock ), Rad * 1.2 * math.noise( Clock, 4.17 ) )
        ClientState.FixedCamera = TableInner.cf * Angles
        ClientState.FixedFOV = TableInner.fov + TableInner.punch
    end )
    local Table2 = { }
    local Table3 = {
        weapon = Argument1,
        Cam = TableInner,
        during = function( Amount, Callback )
            local Clock = os.clock( )

            while true do
                local Min2
                local Clock2 = os.clock( ) - Clock

                if Amount > 0 then
                    local Min = math.min( Clock2 / Amount, 1 )

                    if Min then
                        Min2 = Min
                    else
                        Min2 = 1
                    end
                else
                    Min2 = 1
                end
                if Callback then
                    Callback( Min2, Clock2 )
                end
                if Min2 >= 1 then
                    break
                end

                RunService.RenderStepped:Wait( )
            end
        end,
        later = function( Argument1 )
            table.insert( Table2, Argument1 )
        end,
        aborted = function()
            return false
        end
    }
    Table.Prepare( Argument1 )
    local Success, Result = pcall( Table.Play, Table3 )

    if not Success then
        warn( "[MythicReveal] " .. tostring( Result ) )
    end

    local Count = #Table2
    local I = Count

    for I = Count, 1, -1 do
        pcall( Table2[ I ] )
    end

    Connect:Disconnect( )
    ClientState.FixedCamera = nil
    ClientState.FixedFOV = nil

    if Success and Result then
        Result( )
    end

    return Success
end
return Table

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted
return Aborted2
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Argument1 )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local TextTransparency = 1 - Title
local TextTransparency2 = 1 - Title
Upvalue1.TextTransparency = TextTransparency
Upvalue2.TextTransparency = TextTransparency2
local Table = {
    Upvalue1:FindFirstChildOfClass( "UIStroke" ),
    Upvalue2:FindFirstChildOfClass( "UIStroke" )
}
Value1 = nil

for Key, Value in Table, nil, nil do
    if Value then
        Value.Transparency = 1 - Title
    end
end

Upvalue3.BackgroundTransparency = 1 - Title
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Stop( )
Upvalue2.Enabled = false
Upvalue3.BackgroundTransparency = 1
Upvalue4( 0 )
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.hideUI( true )
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )
local Sin = math.sin( Clock * 1.6 ) * 0.06 * Upvalue1.bob
return CFrame.new( Upvalue2 + Vector3.new( 0, Upvalue1.lift + Sin, 0 ) ) * CFrame.Angles( 0, Upvalue1.yaw + Upvalue1.spin, 0 ) * Upvalue3 * CFrame.Angles( 0, 0, Upvalue1.roll + math.sin( Clock * 1.1 ) * 0.020943951023931952 * Upvalue1.bob )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1( ) * Vector3.new( Argument1, Argument2, Argument3 )
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

local WorldPosition2

if Upvalue1 then
    local WorldPosition = Upvalue1.WorldPosition

    if WorldPosition then
        WorldPosition2 = WorldPosition
    else
        local Amount = -Upvalue2
        WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
    end
else
    local Amount = -Upvalue2
    WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
end

return WorldPosition2
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { neons = { }, lights = { }, level = 0, mult = Amount or 1 }

if Object then
    local Descendants = Object:GetDescendants( )

    if Object:IsA( "BasePart" ) then
        table.insert( Descendants, Object )
    end

    local Value1 = nil

    for Key2, Value in Descendants, nil, nil do
        if not Value:IsA( "BasePart" ) or not Value:GetAttribute( "OnColor" ) then
            if Value:IsA( "Light" ) then
                local Lights = Table.lights
                table.insert( Lights, { l = Value, base = Upvalue1[ Value.ClassName ] or 2 } )
            end
        else
            local Neons = Table.neons
            table.insert( Neons, {
                p = Value,
                off = Value.Color,
                on = Value:GetAttribute( "OnColor" ),
                i = Value:GetAttribute( "Index" ) or 0
            } )
        end
    end
end

Upvalue2[ Key ] = Table
return Table
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue2[ Upvalue1 ] = nil
    Upvalue1:Destroy( )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if not Shot then
    return nil
end

local Sound = Instance.new( "Sound" )
Sound.SoundId = "rbxassetid://" .. tostring( Shot )
Sound.Volume = Vol or 1
Sound.PlaybackSpeed = Random or 1
Sound:SetAttribute( "CaseSound", true )
Sound.Parent = Upvalue1

if Argument4 then
    Sound.SoundGroup = Upvalue2
end
if TimePosition then
    Sound.TimePosition = TimePosition
end

Sound:Play( )
Upvalue3[ Sound ] = true
task.delay( 14, function()
    if Sound.Parent then
        Upvalue3[ Sound ] = nil
        Sound:Destroy( )
    end
end )
return Sound
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Value1
Upvalue2.Ambient = Color3.fromRGB( 4, 4, 6 )
Upvalue2.OutdoorAmbient = Color3.fromRGB( 4, 4, 6 )
Upvalue2.Brightness = 0
Upvalue3 = Upvalue3 + ( Upvalue4 - Upvalue3 ) * 0.12
Upvalue2.ExposureCompensation = Upvalue5.ExposureCompensation + Upvalue3
Upvalue2.EnvironmentDiffuseScale = Upvalue5.EnvironmentDiffuseScale * Upvalue6
Upvalue2.EnvironmentSpecularScale = Upvalue5.EnvironmentSpecularScale * Upvalue6
local Clock = os.clock( )
Value1 = nil

for Key, Value in Upvalue7, nil, nil do
    local Value4
    local Clamp = math.clamp( Value.level, 0, 1.6 )
    local Neons = Value.neons
    Value4 = nil

    for Key3, Value5 in Neons, nil, nil do
        local Clamp2 = if Key ~= "Fond" or Upvalue8 ~= "chase" then Clamp else Clamp * ( math.max( 0, ( math.sin( Clock * 6 - Value5.i * 0.9 ) ) ) * 0.75 + 0.25 )
        local P = Value5.p
        P.Color = Value5.off:Lerp( Value5.on, ( math.min( Clamp2, 1 ) ) )
    end

    local Value6
    local Lights = Value.lights
    Value6 = nil

    for Key4, Value7 in Lights, nil, nil do
        local L = Value7.l
        L.Brightness = Value7.base * Value.mult * Clamp
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue9, nil, nil do
    local Enabled
    local Level = Value3.g.level
    local B = Value3.b
    Enabled = Level > 0.02 and true or false
    B.Enabled = Enabled
    local B2 = Value3.b
    B2.Transparency = NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 1 ),
        NumberSequenceKeypoint.new( 0.22, 1 - math.min( Level, 1 ) * 0.36 ),
        Upvalue10( 1, 1 )
    } )
end

Upvalue11:PivotTo( Upvalue12( ) * Upvalue13 )
local X = Upvalue15.X + 1.7
local Y = Upvalue15.Y + 1.3
local Vector32 = Upvalue12( ) * Vector3.new( X, Y, Upvalue16 )
local X2 = Upvalue15.X
local Y2 = Upvalue15.Y
Upvalue14.CFrame = CFrame.lookAt( Vector32, Upvalue12( ) * Vector3.new( X2, Y2, Upvalue16 ) )
Upvalue17.Brightness = Upvalue18 * 3

if Upvalue19 then
    Upvalue20.FocusDistance = ( Upvalue21.CFrame.Position - Upvalue19 ).Magnitude
end
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value.level = 0
end
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < ( Upvalue1 or 0.4 ) do
    local Aborted2
    local Aborted = Upvalue2.aborted
    Aborted2 = if Aborted then Upvalue2.aborted( ) else Aborted

    if Aborted2 then
        break
    end

    local Level

    if math.random( ) < 0.5 then
        local Random = ( 0.3 + math.random( ) * 0.7 ) * Upvalue4

        if Random then
            Level = Random
        else
            Level = 0.04
        end
    else
        Level = 0.04
    end

    Upvalue3.level = Level
    task.wait( 0.03 + math.random( ) * 0.05 )
end

Upvalue3.level = Upvalue4
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < ( Argument3 or 0.4 ) do
        local Aborted2
        local Aborted = Upvalue1.aborted
        Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Level

        if math.random( ) < 0.5 then
            local Random = ( 0.3 + math.random( ) * 0.7 ) * Argument2

            if Random then
                Level = Random
            else
                Level = 0.04
            end
        else
            Level = 0.04
        end

        Argument1.level = Level
        task.wait( 0.03 + math.random( ) * 0.05 )
    end

    Argument1.level = Argument2
end )
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.BackgroundColor3 = BackgroundColor3
Upvalue1.BackgroundTransparency = BackgroundTransparency
local Table = { BackgroundTransparency = 1 }
Upvalue2:Create( Upvalue1, TweenInfo.new( Argument3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Value1
Upvalue1 = true
Upvalue2:Disconnect( )
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    Upvalue4[ Key ] = Value
end

local Value2
Upvalue5:Destroy( )
Upvalue6:Destroy( )
Upvalue7:Destroy( )
Value2 = nil

for Key2, Value3 in Upvalue8, nil, nil do
    if Value3.Parent then
        Value3.Enabled = true
    end
end
if Upvalue9 and Upvalue9.Parent then
    Upvalue9.Enabled = Upvalue10
end

local Value4 = nil

for Value5 in Upvalue11, nil, nil do
    if Value5.Parent then
        Value5:Stop( )
        Value5:Destroy( )
    end
end

Upvalue12:Destroy( )
Upvalue13:Destroy( )
Upvalue14:Destroy( )
Upvalue15:Destroy( )
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = Argument1 - ( os.clock( ) - Upvalue1 )

if Clock > 0 then
    Upvalue2( Clock )
end
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

task.delay( math.max( 0, Argument1 - ( os.clock( ) - Upvalue1 ) ), Argument2, ... )
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

return ( 0.8 * Amount + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Amount ) ) ) / 1.0546479089470326
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local X2
local LookAt = CFrame.lookAt( Argument1, Argument2 )
local ViewportSize = Upvalue1.ViewportSize

if ViewportSize.Y > 0 then
    local X = ViewportSize.X / ViewportSize.Y

    if X then
        X2 = X
    else
        X2 = 1.7777777777777777
    end
else
    X2 = 1.7777777777777777
end

local Tan = math.tan( math.rad( Argument3 ) / 2 )
local Result = 2 * Amount * Tan * X2
return LookAt * CFrame.lookAt( Vector3.new( 0, 0, 0 ), Vector3.new( Result, 2 * Amount2 * Tan, -1 ).Unit ):Inverse( )
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

local Cf

if Argument1.subject then
    local Screen2

    if Argument1.screen then
        local Screen = Argument1.screen( Argument2 )

        if Screen then
            Screen2 = Screen
        else
            Screen2 = Vector2.zero
        end
    else
        Screen2 = Vector2.zero
    end

    Cf = Upvalue1( Argument1.pos( Argument2 ), Argument1.subject( Argument2 ), Argument1.fov( Argument2 ), Screen2.X, Screen2.Y )
else
    Cf = CFrame.lookAt( Argument1.pos( Argument2 ), Argument1.look( Argument2 ) )
end
if Argument1.roll then
    Cf = Cf * CFrame.Angles( 0, 0, Argument1.roll( Argument2 ) )
end

local Focus2
local Fov = Argument1.fov( Argument2 )
Upvalue2.cf = Cf
Upvalue2.fov = Fov

if Argument1.focus then
    local Focus = Argument1.focus( Argument2 )

    if Focus then
        Focus2 = Focus
    else
        Focus2 = nil
    end
else
    Focus2 = nil
end

Upvalue3 = Focus2
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( ( Upvalue3 + Argument2 - Upvalue4 ) / ( Upvalue5 - Upvalue4 ), 0, 1 )
Upvalue1( Upvalue2, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1

if Upvalue2:IsStudio( ) and Upvalue3:GetAttribute( "DebugMythicShot" ) == Upvalue1 then
    local Clock = os.clock( )
    Upvalue3:SetAttribute( "DebugMythicHolding", Upvalue1 )

    while Upvalue3:GetAttribute( "DebugMythicShot" ) == Upvalue1 do
        local Aborted2
        local Aborted = Upvalue4.aborted
        Aborted2 = if Aborted then Upvalue4.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Clamp = math.clamp( tonumber( Upvalue3:GetAttribute( "DebugMythicShotK" ) ) or 0, 0, 1 )
        Upvalue5( Argument3, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
        Upvalue2.RenderStepped:Wait( )
    end

    Upvalue3:SetAttribute( "DebugMythicHolding", nil )
    Upvalue6 = Upvalue6 + ( os.clock( ) - Clock )
end

local Clock2 = os.clock( ) - Upvalue6
Upvalue7( math.max( Argument2 - Clock2, 0.01 ), function( Argument1Inner, Argument2Inner )
    local Clamp = math.clamp( ( Clock2 + Argument2Inner - Argument1 ) / ( Argument2 - Argument1 ), 0, 1 )
    Upvalue5( Argument3, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
end )
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Emit( Value:GetAttribute( "EmitCount" ) or 4 )
end

Upvalue2.Brightness = 11
local Table = { Brightness = 0 }
Upvalue3:Create( Upvalue2, TweenInfo.new( 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag, Captured
local Clock = os.clock( )
Flag = false
Captured = Upvalue1

while Upvalue2.Parent do
    if not ( os.clock( ) - Clock < 4 ) then
        break
    end

    local Wait = Upvalue3.RenderStepped:Wait( )

    if not Flag then
        Upvalue4 = Upvalue4 + Vector3.new( 0, -55 * Wait, 0 )
        local Captured2 = Captured + Upvalue4 * Wait

        if Captured2.Y <= Upvalue5 + 0.06 then
            local X = Captured2.X
            local Captured3 = Upvalue5 + 0.06
            Captured = Vector3.new( X, Captured3, Captured2.Z )

            if Upvalue4.Magnitude > 6 then
                local X2 = Upvalue4.X * 0.4
                local Amount = -Upvalue4.Y * 0.35
                Upvalue4 = Vector3.new( X2, Amount, Upvalue4.Z * 0.4 )
            else
                Flag = true
            end
        else
            Captured = Captured2
        end

        local Clock2 = os.clock( ) - Clock
        Upvalue2.CFrame = CFrame.new( Captured ) * CFrame.Angles( Upvalue6.X * Clock2, Upvalue6.Y * Clock2, Upvalue6.Z * Clock2 )
    end
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.shells then
    local Part = Instance.new( "Part" )
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new( 0.3400000035762787, 0.10999999940395355, 0.10999999940395355 ) * math.max( 1, Upvalue2 * 0.6 )
    Part.Color = Color3.fromRGB( 214, 168, 72 )
    Part.Material = Enum.Material.Metal
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = true
    local Captured = Upvalue3 * 0.12
    local Vector32 = Upvalue4( ) * Vector3.new( 0.15, 0.22, Captured )
    local Value1 = Upvalue4( )
    local Random = 5 + math.random( ) * 2
    local Random2 = 6 + math.random( ) * 2
    local VectorToWorldSpace = Value1:VectorToWorldSpace( ( Vector3.new( Random, Random2, -1 + math.random( ) * 2 ) ) )
    local Random3 = -20 + math.random( ) * 40
    local Random4 = -20 + math.random( ) * 40
    local Vector33 = Vector3.new( Random3, Random4, -20 + math.random( ) * 40 )
    Part.CFrame = CFrame.new( Vector32 )
    Part.Parent = Upvalue5
    task.spawn( function()
        local Flag, Captured
        local Clock = os.clock( )
        Flag = false
        Captured = Vector32

        while Part.Parent do
            if not ( os.clock( ) - Clock < 4 ) then
                break
            end

            local Wait = Upvalue6.RenderStepped:Wait( )

            if not Flag then
                VectorToWorldSpace = VectorToWorldSpace + Vector3.new( 0, -55 * Wait, 0 )
                local Captured2 = Captured + VectorToWorldSpace * Wait

                if Captured2.Y <= Upvalue7 + 0.06 then
                    local X = Captured2.X
                    local Captured3 = Upvalue7 + 0.06
                    Captured = Vector3.new( X, Captured3, Captured2.Z )

                    if VectorToWorldSpace.Magnitude > 6 then
                        local X2 = VectorToWorldSpace.X * 0.4
                        local Amount = -VectorToWorldSpace.Y * 0.35
                        VectorToWorldSpace = Vector3.new( X2, Amount, VectorToWorldSpace.Z * 0.4 )
                    else
                        Flag = true
                    end
                else
                    Captured = Captured2
                end

                local Clock2 = os.clock( ) - Clock
                Part.CFrame = CFrame.new( Captured ) * CFrame.Angles( Vector33.X * Clock2, Vector33.Y * Clock2, Vector33.Z * Clock2 )
            end
        end
    end )
    return
end
return
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.level = 0.6
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

local Hit_Sparks
local Parent = Instance.new( "Attachment" )
Parent.WorldPosition = WorldPosition
Parent.Parent = workspace.Terrain
task.delay( 4, function()
    Parent:Destroy( )
end )
local Hits = Upvalue1:FindFirstChild( "Hits" )

if Hits then
    Hit_Sparks = Hits:FindFirstChild( "Hit_Sparks" )
else
    Hit_Sparks = Hits
end
if Hit_Sparks then
    for Key, Value in Hit_Sparks:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            local Clone = Value:Clone( )
            Clone.Enabled = false
            Clone.EmissionDirection = Enum.NormalId.Left
            Clone.Parent = Parent
            Clone:Emit( ( Value:GetAttribute( "EmitCount" ) or 6 ) * 3 )
        end
    end
end

local PointLight = Instance.new( "PointLight" )
local Color = Color3.fromRGB( 255, 190, 120 )
PointLight.Range = 14
PointLight.Brightness = 9
PointLight.Color = Color
PointLight.Parent = Parent
local Table = { Brightness = 0 }
Upvalue2:Create( PointLight, TweenInfo.new( 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
Upvalue3.level = 1.4
task.delay( 0.12, function()
    Upvalue3.level = 0.6
end )
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
Upvalue2:Destroy( )
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Attachment1 = Instance.new( "Attachment" )
    Attachment1.WorldPosition = Upvalue2
    Attachment1.Parent = workspace.Terrain
    local Beam = Instance.new( "Beam" )
    Beam.Attachment0 = Upvalue1
    Beam.Attachment1 = Attachment1
    Beam.Width0 = 0.07
    Beam.Width1 = 0.03
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.Segments = 1
    Beam.Color = ColorSequence.new( Color3.fromRGB( 255, 226, 170 ) )
    Beam.Transparency = NumberSequence.new( { NumberSequenceKeypoint.new( 0, 0.1 ), Upvalue3( 1, 0.5 ) } )
    Beam.Parent = Upvalue4
    task.delay( 0.06, function()
        Beam:Destroy( )
        Attachment1:Destroy( )
    end )
    return
end
return
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = false
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Value1
local SlowSmoke = Upvalue2:FindFirstChild( "SlowSmoke" )
local SmokeBurst = Upvalue2:FindFirstChild( "SmokeBurst" )
local Table = { SlowSmoke, SmokeBurst }
Value1 = nil

for Key, Value in Table, nil, nil do
    if Value then
        for Key2, Value2 in Value:GetDescendants( ) do
            if Value2:IsA( "ParticleEmitter" ) then
                local Clone = Value2:Clone( )
                Clone.Parent = Upvalue1

                if Value == SmokeBurst then
                    Clone.Enabled = false
                    Clone:Emit( Value2:GetAttribute( "EmitCount" ) or 4 )
                else
                    Clone.Enabled = true
                    task.delay( Amount or 2, function()
                        Clone.Enabled = false
                    end )
                end
            end
        end
    end
end
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.45 do
    local Aborted2
    local Aborted = Upvalue1.aborted
    Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

    if Aborted2 then
        break
    end

    local Number
    local Clock2 = ( os.clock( ) - Clock ) / 0.45
    local Exp = math.exp( -Clock2 * 5 ) * 0.22
    Number = not Upvalue3 and 0.7 or 1
    local Number2
    Upvalue2.lift = Exp * Number
    Number2 = not Upvalue3 and 4 or 6
    Upvalue2.roll = Upvalue4( Number2 ) * math.exp( -Clock2 * 5 )
    Upvalue5.RenderStepped:Wait( )
end

Upvalue2.lift = 0
Upvalue2.roll = 0
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
Upvalue2( )
Upvalue3( Upvalue4 )
Upvalue5( )
local Shot = Upvalue7.shot
local Vol = Upvalue8.vol or 1.2
local Random = 0.97 + math.random( ) * 0.06000000000000005
Upvalue6( Shot, Vol, Random, true, Upvalue7.start )

if Argument1 then
    local Sub = Upvalue9.sub

    if Sub then
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = "rbxassetid://" .. tostring( Sub )
        Sound.Volume = 0.6
        Sound.PlaybackSpeed = 1
        Sound:SetAttribute( "CaseSound", true )
        Sound.Parent = Upvalue10
        Sound:Play( )
        Upvalue11[ Sound ] = true
        task.delay( 14, function()
            if Sound.Parent then
                Upvalue11[ Sound ] = nil
                Sound:Destroy( )
            end
        end )
    end
end

local Number
local Kick = Upvalue12.kick
Number = not Argument1 and 3 or 4.5
local Punch
Upvalue12.kick = math.max( Kick, Number )
Punch = not Argument1 and -4 or -7
local Number2
Upvalue12.punch = Punch
Number2 = not Argument1 and 0.25 or 0.45
local BackgroundTransparency
Upvalue13 = Upvalue14 + Number2
local BackgroundColor3 = Color3.fromRGB( 255, 236, 210 )
BackgroundTransparency = not Argument1 and 0.85 or 0.72
local Number3 = not Argument1 and 0.14 or 0.22
local Number4
Upvalue15.BackgroundColor3 = BackgroundColor3
Upvalue15.BackgroundTransparency = BackgroundTransparency
local Table = { BackgroundTransparency = 1 }
Upvalue16:Create( Upvalue15, TweenInfo.new( Number3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
Number4 = not Argument1 and 4 or 6
Upvalue17.roll = Upvalue18( Number4 )
task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < 0.45 do
        local Aborted2
        local Aborted = Upvalue19.aborted
        Aborted2 = if Aborted then Upvalue19.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Number
        local Clock2 = ( os.clock( ) - Clock ) / 0.45
        local Exp = math.exp( -Clock2 * 5 ) * 0.22
        Number = not Argument1 and 0.7 or 1
        local Number2
        Upvalue17.lift = Exp * Number
        Number2 = not Argument1 and 4 or 6
        Upvalue17.roll = Upvalue18( Number2 ) * math.exp( -Clock2 * 5 )
        Upvalue20.RenderStepped:Wait( )
    end

    Upvalue17.lift = 0
    Upvalue17.roll = 0
end )
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { }
Value1 = nil

for Key, Value in List, nil, nil do
    table.insert( Table, ColorSequenceKeypoint.new( Value[ 1 ], Value[ 2 ] ) )
end

return ColorSequence.new( Table )
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local ParticleEmitter = Instance.new( "ParticleEmitter" )
ParticleEmitter.Enabled = false
Value1 = nil

for Key, Value in List, nil, nil do
    ParticleEmitter[ Key ] = Value
end

ParticleEmitter.Parent = Upvalue1
return ParticleEmitter
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = false
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue2:Emit( 12 )
    Upvalue3:Emit( 25 )
end
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag, Position
local Clock = os.clock( )
local Y = Upvalue1.Size.Y / 2
Flag = false
Position = Upvalue1.Position

while Upvalue1.Parent do
    if not ( os.clock( ) - Clock < 3.5 ) then
        break
    end

    local Wait = Upvalue2.RenderStepped:Wait( )

    if not Flag then
        Upvalue3 = Upvalue3 + Vector3.new( 0, -55 * Wait, 0 )
        local Position2 = Position + Upvalue3 * Wait

        if Position2.Y <= Upvalue4 + Y then
            local X = Position2.X
            local Captured = Upvalue4 + Y
            Position = Vector3.new( X, Captured, Position2.Z )

            if Upvalue3.Magnitude > 5 then
                local X2 = Upvalue3.X * 0.45
                local Amount = -Upvalue3.Y * 0.3
                Upvalue3 = Vector3.new( X2, Amount, Upvalue3.Z * 0.45 )
            else
                Flag = true
            end
        else
            Position = Position2
        end

        local Clock2 = os.clock( ) - Clock
        Upvalue1.CFrame = CFrame.new( Position ) * CFrame.Angles( Upvalue5.X * Clock2, Upvalue5.Y * Clock2, Upvalue5.Z * Clock2 )
    end
    if Upvalue6 then
        Upvalue1.Color = Color3.fromRGB( 255, 105, 30 ):Lerp( Color3.fromRGB( 50, 28, 20 ), ( math.min( ( os.clock( ) - Clock ) / 1.4, 1 ) ) )
    end
end
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Parent = Instance.new( "Part" )
Parent.Anchored = true
Parent.CanCollide = false
Parent.CanQuery = false
Parent.CanTouch = false
Parent.Transparency = 1
Parent.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
Parent.CFrame = CFrame.lookAt( Argument1, Argument1 + Amount )
Parent.Parent = Upvalue1

local function Cs( List )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        table.insert( Table, ColorSequenceKeypoint.new( Value[ 1 ], Value[ 2 ] ) )
    end

    return ColorSequence.new( Table )
end

local function Em( List )
    local Value1
    local ParticleEmitter = Instance.new( "ParticleEmitter" )
    ParticleEmitter.Enabled = false
    Value1 = nil

    for Key, Value in List, nil, nil do
        ParticleEmitter[ Key ] = Value
    end

    ParticleEmitter.Parent = Parent
    return ParticleEmitter
end

local Table = {
    Texture = "rbxasset://textures/particles/smoke_main.dds",
    LightEmission = 0.4,
    LightInfluence = 0,
    EmissionDirection = Enum.NormalId.Front,
    Color = Cs( {
        { 0, Color3.fromRGB( 255, 222, 160 ) },
        { 0.2, Color3.fromRGB( 255, 150, 50 ) },
        { 0.55, Color3.fromRGB( 200, 60, 22 ) },
        { 1, Color3.fromRGB( 40, 26, 22 ) }
    } ),
    Size = NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 1.6 ),
        NumberSequenceKeypoint.new( 0.35, 5.5 ),
        Upvalue2( 1, 7.5 )
    } ),
    Transparency = NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 0.2 ),
        NumberSequenceKeypoint.new( 0.55, 0.35 ),
        Upvalue2( 1, 1 )
    } ),
    Lifetime = NumberRange.new( 0.55, 1.05 ),
    Speed = NumberRange.new( 5, 15 ),
    Drag = 3.5,
    SpreadAngle = Vector2.new( 75, 75 ),
    Rotation = NumberRange.new( 0, 360 ),
    RotSpeed = NumberRange.new( -70, 70 ),
    Acceleration = Vector3.new( 0, 3, 0 )
}
local ParticleEmitter = Instance.new( "ParticleEmitter" )
ParticleEmitter.Enabled = false
Value1 = nil

for Key, Value in Table, nil, nil do
    ParticleEmitter[ Key ] = Value
end

local Value2
ParticleEmitter.Parent = Parent
local Table2 = {
    Texture = "rbxasset://textures/particles/smoke_main.dds",
    LightEmission = 0.15,
    LightInfluence = 0.9,
    Color = ColorSequence.new( Color3.fromRGB( 160, 140, 125 ) ),
    Size = NumberSequence.new( { NumberSequenceKeypoint.new( 0, 1.5 ), Upvalue2( 1, 5 ) } ),
    Transparency = NumberSequence.new( { NumberSequenceKeypoint.new( 0, 0.35 ), Upvalue2( 1, 1 ) } ),
    Lifetime = NumberRange.new( 0.5, 0.85 ),
    Speed = NumberRange.new( 30, 42 ),
    Drag = 9,
    SpreadAngle = Vector2.new( 180, 180 ),
    Rotation = NumberRange.new( 0, 360 )
}
local ParticleEmitter2 = Instance.new( "ParticleEmitter" )
ParticleEmitter2.Enabled = false
Value2 = nil

for Key2, Value3 in Table2, nil, nil do
    ParticleEmitter2[ Key2 ] = Value3
end

local Value4
ParticleEmitter2.Parent = Parent
local Table3 = {
    Texture = "rbxasset://textures/particles/sparkles_main.dds",
    LightEmission = 1,
    LightInfluence = 0,
    EmissionDirection = Enum.NormalId.Front,
    Color = Cs( {
        { 0, Color3.fromRGB( 255, 230, 150 ) },
        { 1, Color3.fromRGB( 255, 90, 30 ) }
    } ),
    Size = NumberSequence.new( { NumberSequenceKeypoint.new( 0, 0.22 ), Upvalue2( 1, 0 ) } ),
    Lifetime = NumberRange.new( 0.8, 1.7 ),
    Speed = NumberRange.new( 14, 32 ),
    Drag = 1.2,
    SpreadAngle = Vector2.new( 70, 70 ),
    Acceleration = Vector3.new( 0, -32, 0 )
}
local ParticleEmitter3 = Instance.new( "ParticleEmitter" )
ParticleEmitter3.Enabled = false
Value4 = nil

for Key3, Value5 in Table3, nil, nil do
    ParticleEmitter3[ Key3 ] = Value5
end

local Value6
ParticleEmitter3.Parent = Parent
local Table4 = {
    Texture = "rbxasset://textures/particles/smoke_main.dds",
    LightEmission = 0,
    LightInfluence = 0.35,
    EmissionDirection = Enum.NormalId.Front,
    Color = Cs( {
        { 0, Color3.fromRGB( 150, 95, 60 ) },
        { 0.25, Color3.fromRGB( 105, 98, 92 ) },
        { 1, Color3.fromRGB( 70, 68, 66 ) }
    } ),
    Size = NumberSequence.new( { NumberSequenceKeypoint.new( 0, 3 ), Upvalue2( 1, 9 ) } ),
    Transparency = NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 1 ),
        NumberSequenceKeypoint.new( 0.12, 0.5 ),
        NumberSequenceKeypoint.new( 0.7, 0.72 ),
        Upvalue2( 1, 1 )
    } ),
    Lifetime = NumberRange.new( 2, 3 ),
    Speed = NumberRange.new( 1, 3 ),
    Drag = 0.6,
    SpreadAngle = Vector2.new( 50, 50 ),
    Acceleration = Vector3.new( 0, 2.200000047683716, 0 ),
    Rotation = NumberRange.new( 0, 360 ),
    RotSpeed = NumberRange.new( -15, 15 )
}
local ParticleEmitter4 = Instance.new( "ParticleEmitter" )
ParticleEmitter4.Enabled = false
Value6 = nil

for Key4, Value7 in Table4, nil, nil do
    ParticleEmitter4[ Key4 ] = Value7
end

local Unit
ParticleEmitter4.Parent = Parent
ParticleEmitter:Emit( 24 )
ParticleEmitter2:Emit( 34 )
ParticleEmitter3:Emit( 70 )
ParticleEmitter4.Rate = 16
ParticleEmitter4.Enabled = true
task.delay( 1.5, function()
    ParticleEmitter4.Enabled = false
end )
task.delay( 0.14, function()
    if Parent.Parent then
        ParticleEmitter:Emit( 12 )
        ParticleEmitter3:Emit( 25 )
    end
end )
local Part = Instance.new( "Part" )
Part.Shape = Enum.PartType.Ball
Part.Material = Enum.Material.Neon
Part.Color = Color3.fromRGB( 255, 214, 150 )
Part.Anchored = true
Part.CanCollide = false
Part.CanQuery = false
Part.CanTouch = false
Part.CastShadow = false
Part.Size = Vector3.new( 1, 1, 1 )
Part.Transparency = 0.3
Part.CFrame = CFrame.new( Argument1 + Amount * 0.6 )
Part.Parent = Upvalue1
local Table5 = { Size = Vector3.new( 6, 6, 6 ), Transparency = 1 }
Upvalue3:Create( Part, TweenInfo.new( 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table5 ):Play( )
local Cross = Amount:Cross( Vector3.new( 0, 1, 0 ) )
Unit = Cross.Magnitude > 0.01 and Cross.Unit or Vector3.new( 1, 0, 0 )
local I = 1

for I = 1, 18 do
    local Flag
    local Part2 = Instance.new( "Part" )
    Flag = I % 6 == 0 and true or false
    local Material
    local Random = 0.08 + math.random( ) * 0.21999999999999997
    local Random2 = 0.03 + math.random( ) * 0.04000000000000001
    Part2.Size = Vector3.new( Random, Random2, 0.07 + math.random( ) * 0.16999999999999998 )
    Material = Flag and Enum.Material.Neon or Enum.Material.DiamondPlate
    local Color
    Part2.Material = Material

    if Flag then
        local FromRGB = Color3.fromRGB( 255, 105, 30 )

        if FromRGB then
            Color = FromRGB
        else
            Color = Color3.fromRGB( 46, 43, 41 )
        end
    else
        Color = Color3.fromRGB( 46, 43, 41 )
    end

    Part2.Color = Color
    Part2.Anchored = true
    Part2.CanCollide = false
    Part2.CanQuery = false
    Part2.CanTouch = false
    Part2.CastShadow = true
    Part2.CFrame = CFrame.new( Argument1 + Amount * 0.4 )
    Part2.Parent = Upvalue1
    local Random3 = Amount * ( 6 + math.random( ) * 11 ) + Unit * ( -9 + math.random( ) * 18 ) + Vector3.new( 0, 1, 0 ) * ( 1 + math.random( ) * 11 )
    local Random4 = -14 + math.random( ) * 28
    local Random5 = -14 + math.random( ) * 28
    local Vector32 = Vector3.new( Random4, Random5, -14 + math.random( ) * 28 )
    task.spawn( function()
        local FlagInner, Position
        local Clock = os.clock( )
        local Y = Part2.Size.Y / 2
        FlagInner = false
        Position = Part2.Position

        while Part2.Parent do
            if not ( os.clock( ) - Clock < 3.5 ) then
                break
            end

            local Wait = Upvalue4.RenderStepped:Wait( )

            if not FlagInner then
                Random3 = Random3 + Vector3.new( 0, -55 * Wait, 0 )
                local Position2 = Position + Random3 * Wait

                if Position2.Y <= Upvalue5 + Y then
                    local X = Position2.X
                    local Captured = Upvalue5 + Y
                    Position = Vector3.new( X, Captured, Position2.Z )

                    if Random3.Magnitude > 5 then
                        local X2 = Random3.X * 0.45
                        local Amount = -Random3.Y * 0.3
                        Random3 = Vector3.new( X2, Amount, Random3.Z * 0.45 )
                    else
                        FlagInner = true
                    end
                else
                    Position = Position2
                end

                local Clock2 = os.clock( ) - Clock
                Part2.CFrame = CFrame.new( Position ) * CFrame.Angles( Vector32.X * Clock2, Vector32.Y * Clock2, Vector32.Z * Clock2 )
            end
            if Flag then
                Part2.Color = Color3.fromRGB( 255, 105, 30 ):Lerp( Color3.fromRGB( 50, 28, 20 ), ( math.min( ( os.clock( ) - Clock ) / 1.4, 1 ) ) )
            end
        end
    end )
end
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = false
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

local Rocket2
local Rocket = Upvalue1.rocket
Rocket2 = if Rocket then Rocket else { }
Upvalue2( )

if Upvalue3 then
    Upvalue3.Transparency = 1
end

local Launch = Rocket2.Launch

if Launch then
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. tostring( Launch )
    Sound.Volume = 0.9
    Sound.PlaybackSpeed = 1
    Sound:SetAttribute( "CaseSound", true )
    Sound.Parent = Upvalue4
    Sound.SoundGroup = Upvalue5
    Sound:Play( )
    Upvalue6[ Sound ] = true
    task.delay( 14, function()
        if Sound.Parent then
            Upvalue6[ Sound ] = nil
            Sound:Destroy( )
        end
    end )
end

local BackBlast = Rocket2.BackBlast

if BackBlast then
    local Sound2 = Instance.new( "Sound" )
    Sound2.SoundId = "rbxassetid://" .. tostring( BackBlast )
    Sound2.Volume = 0.8
    Sound2.PlaybackSpeed = 1
    Sound2:SetAttribute( "CaseSound", true )
    Sound2.Parent = Upvalue4
    Sound2.SoundGroup = Upvalue5
    Sound2:Play( )
    Upvalue6[ Sound2 ] = true
    task.delay( 14, function()
        if Sound2.Parent then
            Upvalue6[ Sound2 ] = nil
            Sound2:Destroy( )
        end
    end )
end

local Sub = Upvalue7.sub

if Sub then
    local Sound3 = Instance.new( "Sound" )
    Sound3.SoundId = "rbxassetid://" .. tostring( Sub )
    Sound3.Volume = 0.6
    Sound3.PlaybackSpeed = 1
    Sound3:SetAttribute( "CaseSound", true )
    Sound3.Parent = Upvalue4
    Sound3:Play( )
    Upvalue6[ Sound3 ] = true
    task.delay( 14, function()
        if Sound3.Parent then
            Upvalue6[ Sound3 ] = nil
            Sound3:Destroy( )
        end
    end )
end

local Parent = Instance.new( "Attachment" )
local Captured = Upvalue8 + 0.4
Parent.WorldPosition = Upvalue9( ) * Vector3.new( 0, 0, Captured )
Parent.Parent = workspace.Terrain
task.delay( 5, function()
    Parent:Destroy( )
end )
local SmokeBurst = Upvalue10:FindFirstChild( "SmokeBurst" )

if SmokeBurst then
    for Key, Value in SmokeBurst:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            local Clone = Value:Clone( )
            Clone.Enabled = false
            Clone.Parent = Parent
            Clone:Emit( 10 )
        end
    end
end

local RPGRocket
Upvalue11.kick = 4
Upvalue11.punch = -6
Upvalue12.BackgroundColor3 = Color3.fromRGB( 255, 220, 180 )
Upvalue12.BackgroundTransparency = 0.55
local Table = { BackgroundTransparency = 1 }
Upvalue13:Create( Upvalue12, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
Upvalue14 = Upvalue15 + 1
local WeaponFX = Upvalue16:FindFirstChild( "WeaponFX" )

if WeaponFX then
    RPGRocket = Upvalue16.WeaponFX:FindFirstChild( "RPGRocket" )
else
    RPGRocket = WeaponFX
end

local WorldPosition2

if Upvalue17 then
    local WorldPosition = Upvalue17.WorldPosition

    if WorldPosition then
        WorldPosition2 = WorldPosition
    else
        local Amount = -Upvalue8
        WorldPosition2 = Upvalue9( ) * Vector3.new( 0, 0, Amount )
    end
else
    local Amount = -Upvalue8
    WorldPosition2 = Upvalue9( ) * Vector3.new( 0, 0, Amount )
end

local Clone2
local Unit = ( Upvalue18 - WorldPosition2 ).Unit

if RPGRocket then
    Clone2 = RPGRocket:Clone( )
else
    Clone2 = RPGRocket
end

local Angles = CFrame.Angles( 0, -1.5707963267948966, 0 )

if Clone2 then
    for Key2, Value2 in Clone2:GetDescendants( ) do
        if Value2:IsA( "BasePart" ) then
            Value2.Anchored = true
            Value2.CanCollide = false
            Value2.CanQuery = false
            Value2.CanTouch = false
        end
        if Value2:IsA( "ParticleEmitter" ) then
            Value2.Enabled = true
        end
    end

    Clone2:PivotTo( CFrame.lookAt( WorldPosition2, WorldPosition2 + Unit ) * Angles )
    Clone2.Parent = Upvalue19
end

local WeaponFX2

if Clone2 then
    local Flight = Rocket2.Flight

    if Flight then
        local Sound4 = Instance.new( "Sound" )
        Sound4.SoundId = "rbxassetid://" .. tostring( Flight )
        Sound4.Volume = 0.7
        Sound4.PlaybackSpeed = 1
        Sound4:SetAttribute( "CaseSound", true )
        Sound4.Parent = Upvalue4
        Sound4.SoundGroup = Upvalue5
        Sound4:Play( )
        Upvalue6[ Sound4 ] = true
        task.delay( 14, function()
            if Sound4.Parent then
                Upvalue6[ Sound4 ] = nil
                Sound4:Destroy( )
            end
        end )
        WeaponFX2 = Sound4
    else
        WeaponFX2 = nil
    end
else
    WeaponFX2 = Clone2
end

local Magnitude = ( Upvalue18 - WorldPosition2 ).Magnitude - 0.4
Upvalue20 = { pos = WorldPosition2 }
local Clock = os.clock( )

while true do
    local Aborted2
    local Aborted = Upvalue21.aborted
    Aborted2 = if Aborted then Upvalue21.aborted( ) else Aborted

    if Aborted2 then
        break
    end

    local Min = math.min( ( os.clock( ) - Clock ) * 24, Magnitude )
    local Pos = WorldPosition2 + Unit * Min
    Upvalue20.pos = Pos

    if Clone2 then
        Clone2:PivotTo( CFrame.lookAt( Pos, Pos + Unit ) * Angles )
    end
    if Magnitude <= Min then
        break
    end

    Upvalue22.RenderStepped:Wait( )
end
if WeaponFX2 then
    WeaponFX2:Stop( )
end
if Clone2 then
    for Key3, Value3 in Clone2:GetDescendants( ) do
        if Value3:IsA( "ParticleEmitter" ) then
            Value3.Enabled = false
        end
        if Value3:IsA( "BasePart" ) then
            Value3.Transparency = 1
        end
    end
end

local RPG_Explosion
local Parent2 = Instance.new( "Attachment" )
Parent2.WorldPosition = Upvalue18 - Unit * 0.6
Parent2.Parent = workspace.Terrain
task.delay( 6, function()
    Parent2:Destroy( )
end )
local Explosions = Upvalue10:FindFirstChild( "Explosions" )

if Explosions then
    RPG_Explosion = Upvalue10.Explosions:FindFirstChild( "RPG_Explosion" )
else
    RPG_Explosion = Explosions
end
if RPG_Explosion then
    for Key4, Value4 in RPG_Explosion:GetDescendants( ) do
        if Value4:IsA( "ParticleEmitter" ) then
            local Value1
            local Clone3 = Value4:Clone( )
            Clone3.Enabled = false
            local Table2 = { }
            local Keypoints = Clone3.Size.Keypoints
            Value1 = nil

            for Key5, Value5 in Keypoints, nil, nil do
                table.insert( Table2, Upvalue23( Value5.Time, Value5.Value * 2.2 ) )
            end

            Clone3.Size = NumberSequence.new( Table2 )
            Clone3.Speed = NumberRange.new( Clone3.Speed.Min * 1.5, Clone3.Speed.Max * 1.5 )
            Clone3.Parent = Parent2
            Clone3:Emit( ( math.ceil( ( Value4:GetAttribute( "EmitCount" ) or 10 ) * 1.5 ) ) )
        end
    end
end

local FX_Flames = Upvalue10:FindFirstChild( "FX_Flames" )

if FX_Flames then
    for Key6, Value6 in FX_Flames:GetChildren( ) do
        local Clone4 = Value6:Clone( )

        if Clone4:IsA( "ParticleEmitter" ) then
            local Value7
            local Table3 = { }
            local Keypoints2 = Clone4.Size.Keypoints
            Value7 = nil

            for Key7, Value8 in Keypoints2, nil, nil do
                table.insert( Table3, Upvalue23( Value8.Time, Value8.Value * 1.6 ) )
            end

            Clone4.Size = NumberSequence.new( Table3 )
            Clone4.Enabled = true
            task.delay( 2.4, function()
                Clone4.Enabled = false
            end )
        end

        Clone4.Parent = Parent2
    end
end

local PointLight = Instance.new( "PointLight" )
local Color = Color3.fromRGB( 255, 150, 70 )
PointLight.Range = 40
PointLight.Brightness = 16
PointLight.Color = Color
PointLight.Shadows = true
PointLight.Parent = Parent2
local Table4 = { Brightness = 0 }
Upvalue13:Create( PointLight, TweenInfo.new( 1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table4 ):Play( )
local Explosion = Rocket2.Explosion
local ExplosionVolume = Rocket2.ExplosionVolume or 1.4

if Explosion then
    local Sound5 = Instance.new( "Sound" )
    Sound5.SoundId = "rbxassetid://" .. tostring( Explosion )
    Sound5.Volume = ExplosionVolume or 1
    Sound5.PlaybackSpeed = 1
    Sound5:SetAttribute( "CaseSound", true )
    Sound5.Parent = Upvalue4
    Sound5.SoundGroup = Upvalue5
    Sound5:Play( )
    Upvalue6[ Sound5 ] = true
    task.delay( 14, function()
        if Sound5.Parent then
            Upvalue6[ Sound5 ] = nil
            Sound5:Destroy( )
        end
    end )
end

local Boom = Upvalue7.boom

if Boom then
    local Sound6 = Instance.new( "Sound" )
    Sound6.SoundId = "rbxassetid://" .. tostring( Boom )
    Sound6.Volume = 0.7
    Sound6.PlaybackSpeed = 1
    Sound6:SetAttribute( "CaseSound", true )
    Sound6.Parent = Upvalue4
    Sound6:Play( )
    Upvalue6[ Sound6 ] = true
    task.delay( 14, function()
        if Sound6.Parent then
            Upvalue6[ Sound6 ] = nil
            Sound6:Destroy( )
        end
    end )
end

Upvalue24( Upvalue18 - Unit * 0.5, -Unit )
Upvalue11.kick = 8
Upvalue11.punch = -10
Upvalue12.BackgroundColor3 = Color3.fromRGB( 255, 200, 150 )
Upvalue12.BackgroundTransparency = 0.25
local Table5 = { BackgroundTransparency = 1 }
Upvalue13:Create( Upvalue12, TweenInfo.new( 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table5 ):Play( )
Upvalue14 = Upvalue15 + 1.3
Upvalue25.level = 1.5
Upvalue20 = nil
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

local Amount = -Upvalue1 - 0.3
return Upvalue2( ) * Vector3.new( 1.1, -0.15, Amount )
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

local Amount = -Upvalue1 + 0.2
return Upvalue2( ) * Vector3.new( 0, 0.05, Amount )
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

return 34
]]

--[[
Function #64 has no emitted closure site
It is reproduced here so that nothing is lost

local Rise = Upvalue1.rise

if Rise then
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. tostring( Rise )
    Sound.Volume = 0.75
    Sound.PlaybackSpeed = 1
    Sound:SetAttribute( "CaseSound", true )
    Sound.Parent = Upvalue2
    Sound:Play( )
    Upvalue3[ Sound ] = true
    task.delay( 14, function()
        if Sound.Parent then
            Upvalue3[ Sound ] = nil
            Sound:Destroy( )
        end
    end )
    return
end
return
]]

--[[
Function #65 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Upvalue1.X + ( 1.35 + 0.19999999999999996 * Amount ) * Upvalue2
local Y = Upvalue1.Y + ( 0.22 + 0.1 * Amount ) * Upvalue2
local Amount2 = -Upvalue3 - Upvalue4 * 0.7
local Amount3 = Amount2 + ( -Upvalue3 * 0.35 - Amount2 ) * Amount
return Upvalue5( ) * Vector3.new( X, Y, Amount3 )
]]

--[[
Function #66 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Upvalue1.X
local Y = Upvalue1.Y + 0.02
local Amount = -Upvalue2 + 0.3
local Amount2 = Amount + ( -Upvalue2 * 0.05 - Amount ) * Argument1
return Upvalue3( ) * Vector3.new( X, Y, Amount2 )
]]

--[[
Function #67 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0.1, -0.04 )
]]

--[[
Function #68 has no emitted closure site
It is reproduced here so that nothing is lost

return 24 + -3 * Amount
]]

--[[
Function #69 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 6 + -4 * Amount ) )
]]

--[[
Function #70 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Upvalue1.X
local Y = Upvalue1.Y
local Amount = -Upvalue2 + 0.3
local Amount2 = Amount + ( -Upvalue2 * 0.05 - Amount ) * Argument1
return Upvalue3( ) * Vector3.new( X, Y, Amount2 )
]]

--[[
Function #71 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = "chase"
local Number = 0.5
local Number2 = 0.45
task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < ( Number or 0.4 ) do
        local Aborted2
        local Aborted = Upvalue3.aborted
        Aborted2 = if Aborted then Upvalue3.aborted( ) else Aborted

        if Aborted2 then
            break
        end

        local Level

        if math.random( ) < 0.5 then
            local Random = ( 0.3 + math.random( ) * 0.7 ) * Number2

            if Random then
                Level = Random
            else
                Level = 0.04
            end
        else
            Level = 0.04
        end

        Upvalue2.level = Level
        task.wait( 0.03 + math.random( ) * 0.05 )
    end

    Upvalue2.level = Number2
end )
]]

--[[
Function #72 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 0.6283185307179586 + 0.45378560551852565 * Amount
local Result2 = ( 7.1 + -0.39999999999999947 * Amount ) * Upvalue1
local Sin = math.sin( Result ) * Result2
local Result3 = -1.25 + 0.25 * Amount
local Cos = math.cos( Result ) * Result2
return Upvalue2( ) * Vector3.new( Sin, Result3, Cos )
]]

--[[
Function #73 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1( ) * Vector3.new( 0, 0, 0.10000000149011612 )
]]

--[[
Function #74 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0, 0.05 )
]]

--[[
Function #75 has no emitted closure site
It is reproduced here so that nothing is lost

return 31 + -2 * Amount
]]

--[[
Function #76 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -4 + 4 * Amount ) )
]]

--[[
Function #77 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1( ) * Vector3.new( 0, 0, 0 )
]]

--[[
Function #78 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )
local Shot = Upvalue1.shot - Upvalue1.s3

while true do
    local Aborted2
    local Aborted = Upvalue2.aborted
    Aborted2 = if Aborted then Upvalue2.aborted( ) else Aborted

    if Aborted2 or Upvalue3 or not ( os.clock( ) - Clock < Shot ) then
        break
    end

    local Clock2 = ( os.clock( ) - Clock ) / Shot
    local Level = 0.22 + 0.48 * ( Clock2 * Clock2 )
    local Level2 = 0.22 + 0.48 * ( Clock2 * Clock2 )
    Upvalue4.level = Level
    Upvalue5.level = Level2
    Upvalue6.level = ( 0.05 + 0.3 * Clock2 ) * math.max( 0.3, 1 - Upvalue7 * 1.6 )
    Upvalue8.RenderStepped:Wait( )
end
]]

--[[
Function #79 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( math.min( Amount * 1.25, 1 ), 0, 1 )
local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
Upvalue1.yaw = Upvalue2 + ( 0 - Upvalue2 ) * Clamp2
local Amount2 = -Upvalue4 * 0.05
local Amount3 = -Upvalue4 * 0.95
local Clamp3 = math.clamp( Amount, 0, 1 )
local Clamp4 = Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 )
Upvalue3 = Amount2 + ( Amount3 - Amount2 ) * Clamp4
Upvalue5 = ( 0.35 + 0.7000000000000001 * Amount ) / Upvalue6
local Clamp5 = math.clamp( Amount, 0, 1 )
local Clamp6 = ( 4.2 + -2.7 * ( Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 ) ) ) * Upvalue6
local X = Upvalue8.X + Upvalue6 * 0.5
local Y = Upvalue8.Y - Upvalue6 * 0.2
return Upvalue7 * Vector3.new( X, Y, Upvalue9 - Clamp6 )
]]

--[[
Function #80 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue2( ) * Upvalue3
local Clamp = math.clamp( math.min( Amount * 1.4, 1 ), 0, 1 )
return Upvalue1:Lerp( Captured, Clamp * Clamp * ( 3 - 2 * Clamp ) )
]]

--[[
Function #81 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0, 0.03 )
]]

--[[
Function #82 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( Argument1, 0, 1 )
return 40 + -6 * ( Clamp * Clamp * ( 3 - 2 * Clamp ) )
]]

--[[
Function #83 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -4 + 3 * Amount ) )
]]

--[[
Function #84 has no emitted closure site
It is reproduced here so that nothing is lost

local WorldPosition2

if Upvalue1 then
    local WorldPosition = Upvalue1.WorldPosition

    if WorldPosition then
        WorldPosition2 = WorldPosition
    else
        local Amount = -Upvalue2
        WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
    end
else
    local Amount = -Upvalue2
    WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
end

return WorldPosition2
]]

--[[
Function #85 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Upvalue2 * math.min( math.max( Argument1, 0 ) * 24, Upvalue3 )
]]

--[[
Function #86 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if not Aborted2 then
    Upvalue2( 2.2 )
end
]]

--[[
Function #87 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = ( 5.4 + 0.39999999999999947 * Amount ) * Upvalue1
local Y = Upvalue2.Y - ( 0.35 + -0.09999999999999998 * Amount )
local Result2 = 0.4 + -0.2 * Amount
return Upvalue3( ) * Vector3.new( Result, Y, Result2 )
]]

--[[
Function #88 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Upvalue1.X
local Y = Upvalue1.Y
return Upvalue2( ) * Vector3.new( X, Y, 0 )
]]

--[[
Function #89 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( -0.06, 0.03 )
]]

--[[
Function #90 has no emitted closure site
It is reproduced here so that nothing is lost

return 50 + -3 * Amount
]]

--[[
Function #91 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -2 + 1 * Amount ) )
]]

--[[
Function #92 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Upvalue1.X
local Y = Upvalue1.Y
return Upvalue2( ) * Vector3.new( X, Y, 0 )
]]

--[[
Function #93 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue2 + Upvalue3 * math.min( math.max( 0.42 + ( Upvalue1 - 0.42 ) * Argument1, 0 ) * 24, Upvalue4 ) + Upvalue5 * 3.4 + Vector3.new( 0, 0.699999988079071, 0 ) - Upvalue3 * 1.6
]]

--[[
Function #94 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue2 + Upvalue3 * math.min( math.max( 0.42 + ( Upvalue1 - 0.42 ) * Argument1, 0 ) * 24, Upvalue4 )
]]

--[[
Function #95 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( -0.12, 0 )
]]

--[[
Function #96 has no emitted closure site
It is reproduced here so that nothing is lost

return 56
]]

--[[
Function #97 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -3 + -2 * Amount ) )
]]

--[[
Function #98 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue2 + Upvalue3 * math.min( math.max( 0.42 + ( Upvalue1 - 0.42 ) * Argument1, 0 ) * 24, Upvalue4 )
]]

--[[
Function #99 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = 1 - ( 1 - math.clamp( Amount, 0, 1 ) ) ^ 3
return Upvalue1 - Upvalue2 * ( 13 + 2.5 * Clamp ) + Upvalue3 * ( 6.5 + 1.5 * Clamp ) + Vector3.new( 0, 1 + 0.8 * Amount, 0 )
]]

--[[
Function #100 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 - Upvalue2 * 4 + Vector3.new( 0, 0.800000011920929, 0 )
]]

--[[
Function #101 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0, 0.03 )
]]

--[[
Function #102 has no emitted closure site
It is reproduced here so that nothing is lost

return 30 + 6 * Amount
]]

--[[
Function #103 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 2.5 + -2 * Amount ) )
]]

--[[
Function #104 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 - Upvalue2 * 4
]]

--[[
Function #105 has no emitted closure site
It is reproduced here so that nothing is lost

local Aborted2
local Aborted = Upvalue1.aborted
Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

if not Aborted2 then
    Upvalue2( false )
end
]]

--[[
Function #106 has no emitted closure site
It is reproduced here so that nothing is lost

local Bolt = Upvalue1.bolt

if Bolt then
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. tostring( Bolt )
    Sound.Volume = 1.2
    Sound.PlaybackSpeed = 1
    Sound:SetAttribute( "CaseSound", true )
    Sound.Parent = Upvalue2
    Sound.SoundGroup = Upvalue3
    Sound:Play( )
    Upvalue4[ Sound ] = true
    task.delay( 14, function()
        if Sound.Parent then
            Upvalue4[ Sound ] = nil
            Sound:Destroy( )
        end
    end )
    return
end
return
]]

--[[
Function #107 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = ( 5 + 0.5 * Amount ) * Upvalue1
local Y = Upvalue2.Y + ( 0.1 + 0.12 * Amount )
local Amount2 = -Upvalue3 * 0.12
local Amount3 = Amount2 + ( 0 - Amount2 ) * Amount
return Upvalue4( ) * Vector3.new( Result, Y, Amount3 )
]]

--[[
Function #108 has no emitted closure site
It is reproduced here so that nothing is lost

local WorldPosition2

if Upvalue1 then
    local WorldPosition = Upvalue1.WorldPosition

    if WorldPosition then
        WorldPosition2 = WorldPosition
    else
        local Amount = -Upvalue2
        WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
    end
else
    local Amount = -Upvalue2
    WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
end

return WorldPosition2
]]

--[[
Function #109 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0.14, 0.02 )
]]

--[[
Function #110 has no emitted closure site
It is reproduced here so that nothing is lost

return 41 + -2 * Amount
]]

--[[
Function #111 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -3 + 2 * Amount ) )
]]

--[[
Function #112 has no emitted closure site
It is reproduced here so that nothing is lost

local WorldPosition2

if Upvalue1 then
    local WorldPosition = Upvalue1.WorldPosition

    if WorldPosition then
        WorldPosition2 = WorldPosition
    else
        local Amount = -Upvalue2
        WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
    end
else
    local Amount = -Upvalue2
    WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
end

return WorldPosition2
]]

--[[
Function #113 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 1.2217304763960306 + -0.4886921905584122 * Amount
local Result2 = ( 3.8 + -0.5999999999999996 * Amount ) * Upvalue1 * ( Upvalue2 * 0.9 + 1 )
local X = Upvalue3.X + math.sin( Result ) * Result2
local Y = Upvalue3.Y + ( -0.05 + -0.27 * Amount )
local Z = Upvalue3.Z - math.cos( Result ) * Result2 * 0.8 - 0.3
return Upvalue4( ) * Vector3.new( X, Y, Z )
]]

--[[
Function #114 has no emitted closure site
It is reproduced here so that nothing is lost

local WorldPosition2

if Upvalue1 then
    local WorldPosition = Upvalue1.WorldPosition

    if WorldPosition then
        WorldPosition2 = WorldPosition
    else
        local Amount = -Upvalue2
        WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
    end
else
    local Amount = -Upvalue2
    WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
end

return WorldPosition2 + Vector3.new( 0, 0.11999999731779099, 0 )
]]

--[[
Function #115 has no emitted closure site
It is reproduced here so that nothing is lost

return Vector2.new( 0.16666666666666666, Upvalue1 * 0.25 + 0.02 )
]]

--[[
Function #116 has no emitted closure site
It is reproduced here so that nothing is lost

return 37 + -4 * Amount
]]

--[[
Function #117 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 2 + -2 * Amount ) )
]]

--[[
Function #118 has no emitted closure site
It is reproduced here so that nothing is lost

local WorldPosition2

if Upvalue1 then
    local WorldPosition = Upvalue1.WorldPosition

    if WorldPosition then
        WorldPosition2 = WorldPosition
    else
        local Amount = -Upvalue2
        WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
    end
else
    local Amount = -Upvalue2
    WorldPosition2 = Upvalue3( ) * Vector3.new( 0, 0, Amount )
end

return WorldPosition2
]]

--[[
Function #119 has no emitted closure site
It is reproduced here so that nothing is lost

local Clone = Object:Clone( )
Clone.Anchored = true
Clone.CanCollide = false
Clone.CanQuery = false
Clone.CanTouch = false
Clone.Transparency = 1
Clone.CFrame = CFrame.new( Argument2 )
Clone.Parent = Upvalue1
return Clone
]]

--[[
Function #120 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetDescendants( ) do
    if Value:IsA( "ParticleEmitter" ) then
        Value.Enabled = false
    end
end
]]

--[[
Function #121 has no emitted closure site
It is reproduced here so that nothing is lost

local Min = 1 - ( 1 - math.min( Amount / 4.2, 1 ) ) ^ 2
local Value1 = Upvalue1( -24 + 12 * Min + 2.2 * Amount )
local Min2 = ( 5 + 1.5999999999999996 * Min + 0.1 * Amount ) * Upvalue2 * Upvalue3 / ( math.max( 0, Upvalue4.Y / Upvalue4.Z - 0.22 ) + 1 )
local Sin = math.sin( Value1 ) * Min2
local Min3 = -0.45 + 0.2 * Min
return Upvalue5 + Vector3.new( Sin, Min3, math.cos( Value1 ) * Min2 ), Min
]]

--[[
Function #122 has no emitted closure site
It is reproduced here so that nothing is lost

local X3
local Captured = Upvalue1 + Vector3.new( 0, Upvalue2.lift, 0 )
local ViewportSize = Upvalue3.ViewportSize

if ViewportSize.Y > 0 then
    local X = ViewportSize.X / ViewportSize.Y

    if X then
        X3 = X
    else
        X3 = 1.7777777777777777
    end
else
    X3 = 1.7777777777777777
end

local Number6, Total2
local Tan = math.tan( math.rad( Argument2 ) / 2 )
local Value1 = Upvalue4( )
local Value2 = Upvalue5( Argument1, Captured, Argument2, 0, Argument3 )
local I = 1
Number6 = 0
Total2 = Argument3

for I = 1, 2 do
    local Value3, Number, Number2, Number4, Number5
    Value3 = nil
    Number = math.huge
    Number2 = -math.huge
    Number4 = -math.huge
    Number5 = math.huge

    for Key, Value in Upvalue6, nil, nil do
        local PointToObjectSpace = Value2:PointToObjectSpace( Value1 * Value )

        if PointToObjectSpace.Z < -0.05 then
            local X2 = PointToObjectSpace.X / -PointToObjectSpace.Z / ( Tan * 2 * X3 )
            local Y = PointToObjectSpace.Y / -PointToObjectSpace.Z / ( Tan * 2 )

            if X2 < Number then
                Number = X2
            end
            if Number2 < X2 then
                Number2 = X2
            end
            if Y < Number5 then
                Number5 = Y
            end
            if Number4 < Y then
                Number4 = Y
            end
        end
    end
    if Number == math.huge then
        break
    end

    local Number3 = Number6 - ( Number + Number2 ) / 2
    local Max = math.max( 0.03, -0.1 + ( Number4 - Number5 ) / 2 )
    local Total = Total2 - ( ( Number5 + Number4 ) / 2 - Max )
    Value2 = Upvalue5( Argument1, Captured, Argument2, Number3, Total )
    Number6 = Number3
    Total2 = Total
end

return Value2
]]

--[[
Function #123 has no emitted closure site
It is reproduced here so that nothing is lost

while Upvalue1:IsStudio( ) do
    if not tonumber( Upvalue2:GetAttribute( "DebugMythicFinalT" ) ) then
        break
    end

    local Aborted2
    local Aborted = Upvalue3.aborted
    Aborted2 = if Aborted then Upvalue3.aborted( ) else Aborted

    if Aborted2 then
        break
    end

    Upvalue4( nil, ( tonumber( Upvalue2:GetAttribute( "DebugMythicFinalT" ) ) ) )
    Upvalue2:SetAttribute( "DebugMythicHolding", "final" )
    Upvalue1.RenderStepped:Wait( )
end

Upvalue2:SetAttribute( "DebugMythicHolding", nil )
]]

--[[
Function #124 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.55 do
    local Aborted2
    local Aborted = Upvalue1.aborted
    Aborted2 = if Aborted then Upvalue1.aborted( ) else Aborted

    if Aborted2 then
        break
    end

    local Floor = math.floor( #Upvalue2 * ( os.clock( ) - Clock ) / 0.55 )
    local Text = Upvalue2:sub( 1, Floor )
    local Floor2 = Floor + 1
    local Count = #Upvalue2
    local I = Floor2

    for I = Floor2, Count do
        local Random = math.random( 40 )
        Text = Text .. ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&" ):sub( Random, Random )
    end

    Upvalue3.Text = Text
    Upvalue4.RenderStepped:Wait( )
end

Upvalue3.Text = Upvalue2
]]

--[[
Function #125 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 0.3 do
    Upvalue1( ( os.clock( ) - Clock ) / 0.3 )
    Upvalue2.RenderStepped:Wait( )
end

Upvalue1( 1 )
]]

--[[
Function #126 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.spin = ( 1 - ( 1 - math.min( Amount / 4.2, 1 ) ) ^ 2 ) * -3.490658503988659
local Clamp = math.clamp( Amount / 0.8, 0, 1 )
Upvalue1.lift = 0.15 * ( Clamp * Clamp * ( 3 - 2 * Clamp ) )
local Value1, Value2 = Upvalue2( Amount )
local Fov = 40 + 3 * Value2
Upvalue3.cf = Upvalue4( Value1, Fov, Upvalue5 )
Upvalue3.fov = Fov
Upvalue6 = Upvalue7

if not Upvalue8 and Amount > 0.35 then
    Upvalue8 = true
    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < 0.55 do
            local Aborted2
            local Aborted = Upvalue9.aborted
            Aborted2 = if Aborted then Upvalue9.aborted( ) else Aborted

            if Aborted2 then
                break
            end

            local Floor = math.floor( #Upvalue10 * ( os.clock( ) - Clock ) / 0.55 )
            local Text = Upvalue10:sub( 1, Floor )
            local Floor2 = Floor + 1
            local Count = #Upvalue10
            local I = Floor2

            for I = Floor2, Count do
                local Random = math.random( 40 )
                Text = Text .. ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&" ):sub( Random, Random )
            end

            Upvalue11.Text = Text
            Upvalue12.RenderStepped:Wait( )
        end

        Upvalue11.Text = Upvalue10
    end )

    if Upvalue13 then
        Upvalue13.Scale = 1.8
        local Table = { Scale = 1 }
        Upvalue14:Create( Upvalue13, TweenInfo.new( 0.55, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
    end

    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < 0.3 do
            Upvalue15( ( os.clock( ) - Clock ) / 0.3 )
            Upvalue12.RenderStepped:Wait( )
        end

        Upvalue15( 1 )
    end )
end
]]

--[[
Function #127 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1( 1 - Amount )
Upvalue2.cf = Upvalue3( Upvalue4( 4.2 + 0.5 * Amount ), Upvalue2.fov, Upvalue5 )
Value1 = nil

for Value in Upvalue6, nil, nil do
    if Value.Parent then
        Value.Volume = Value.Volume * 0.9
    end
end

Upvalue7.spin = -3.490658503988659
]]

--[[
Function #128 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.BackgroundTransparency >= 0.99 then
    Upvalue2.Enabled = false
end
]]

--[[
Function #129 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { BackgroundTransparency = 1 }
Upvalue2:Create( Upvalue1, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
task.delay( 0.4, function()
    if Upvalue1.BackgroundTransparency >= 0.99 then
        Upvalue3.Enabled = false
    end
end )
]]
