-- StarterPlayer.StarterPlayerScripts.RankedZoneClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #12

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { }
local Table2 = { ... }
local Count = #Table2
local I = 1

for I = 1, Count, 2 do
    table.insert( Table, NumberSequenceKeypoint.new( Table2[ I ], Table2[ I + 1 ] ) )
end

return NumberSequence.new( Table )
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp2

if Argument1.dur > 0 then
    local Clamp = math.clamp( ( Argument2 - Argument1.t0 ) / Argument1.dur, 0, 1 )

    if Clamp then
        Clamp2 = Clamp
    else
        Clamp2 = 1
    end
else
    Clamp2 = 1
end

return Argument1.r0 + ( Argument1.r1 - Argument1.r0 ) * Clamp2
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Attachment = Instance.new( "Attachment" )
Attachment.Parent = Upvalue1
return Attachment
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local FaceCamera
local Beam = Instance.new( "Beam" )
Beam.Attachment0 = Attachment0
Beam.Attachment1 = Attachment1
Beam.Segments = 1
FaceCamera = Argument3.face == true and true or false
local Color2
Beam.FaceCamera = FaceCamera
Beam.LightEmission = Argument3.emit or 1
Beam.LightInfluence = 0
local Color = Argument3.color
Color2 = if Color then Color else Upvalue1
local TextureMode
Beam.Color = ColorSequence.new( Color2 )
Beam.Transparency = Argument3.transp
Beam.Texture = Argument3.tex or ""
local Mode = Argument3.mode
TextureMode = if Mode then Mode else Enum.TextureMode.Stretch
Beam.TextureMode = TextureMode
Beam.TextureLength = Argument3.len or 1
Beam.TextureSpeed = Argument3.speed or 0
Beam.ZOffset = Argument3.z or 0
local Width0 = Argument3.w or 1
local Width1 = Argument3.w or 1
Beam.Width0 = Width0
Beam.Width1 = Width1
Beam.Brightness = Argument3.bright or 1
Beam.Parent = Upvalue2
return Beam
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Parent = Instance.new( "Folder" )
Parent.Name = "RankedZoneWall"
local Parent2 = Instance.new( "Part" )
Parent2.Name = "Anchor"
Parent2.Anchored = true
Parent2.CanCollide = false
Parent2.CanQuery = false
Parent2.CanTouch = false
Parent2.CastShadow = false
Parent2.Transparency = 1
Parent2.Size = Vector3.new( 1, 1, 1 )
Parent2.CFrame = CFrame.identity
Parent2.Parent = Parent
local Segs = { }
local Ring = { }
Argument1.folder = Parent
Argument1.segs = Segs
Argument1.ring = Ring

local function Att()
    local Attachment = Instance.new( "Attachment" )
    Attachment.Parent = Parent2
    return Attachment
end

local function Beam( Attachment0, Attachment1, Argument3 )
    local FaceCamera
    local Beam = Instance.new( "Beam" )
    Beam.Attachment0 = Attachment0
    Beam.Attachment1 = Attachment1
    Beam.Segments = 1
    FaceCamera = Argument3.face == true and true or false
    local Color2
    Beam.FaceCamera = FaceCamera
    Beam.LightEmission = Argument3.emit or 1
    Beam.LightInfluence = 0
    local Color = Argument3.color
    Color2 = if Color then Color else Upvalue1
    local TextureMode
    Beam.Color = ColorSequence.new( Color2 )
    Beam.Transparency = Argument3.transp
    Beam.Texture = Argument3.tex or ""
    local Mode = Argument3.mode
    TextureMode = if Mode then Mode else Enum.TextureMode.Stretch
    Beam.TextureMode = TextureMode
    Beam.TextureLength = Argument3.len or 1
    Beam.TextureSpeed = Argument3.speed or 0
    Beam.ZOffset = Argument3.z or 0
    local Width0 = Argument3.w or 1
    local Width1 = Argument3.w or 1
    Beam.Width0 = Width0
    Beam.Width1 = Width1
    Beam.Brightness = Argument3.bright or 1
    Beam.Parent = Parent2
    return Beam
end

local N = Argument1.n
local I = 1

for I = 1, N do
    local Attachment = Instance.new( "Attachment" )
    Attachment.Parent = Parent2
    local Attachment2 = Instance.new( "Attachment" )
    Attachment2.Parent = Parent2
    local Table = {
        a0 = Attachment,
        a1 = Attachment2,
        phi = ( I - 0.5 ) / Argument1.n * 3.141592653589793 * 2
    }
    Table.glow = Beam( Attachment, Attachment2, {
        transp = Upvalue2,
        bright = 0.9,
        emit = 0.25,
        color = Color3.fromRGB( 185, 10, 26 )
    } )
    Table.bands = Beam( Attachment, Attachment2, {
        tex = "rbxassetid://75062171207616",
        mode = Enum.TextureMode.Wrap,
        len = 34,
        speed = 0.22,
        transp = Upvalue3,
        bright = 1.3,
        z = 0.1
    } )
    Table.hex = Beam( Attachment, Attachment2, {
        tex = "rbxassetid://124021671884556",
        mode = Enum.TextureMode.Wrap,
        speed = 0.05,
        transp = Upvalue4,
        bright = 1.25,
        z = 0.2,
        color = Color3.fromRGB( 255, 34, 48 )
    } )
    table.insert( Argument1.segs, Table )
    local Ring2 = Argument1.ring
    local Attachment3 = Instance.new( "Attachment" )
    Attachment3.Parent = Parent2
    table.insert( Ring2, {
        a = Attachment3,
        phi = ( I - 1 ) / Argument1.n * 3.141592653589793 * 2
    } )
end

local Value1
local Ring3 = Argument1.ring
Value1 = nil

for Key, Value in Ring3, nil, nil do
    local Entry = Argument1.ring[ Key % Argument1.n + 1 ]
    Beam( Value.a, Entry.a, {
        face = true,
        tex = "rbxassetid://99543846460258",
        transp = Upvalue5,
        color = Upvalue6,
        bright = 2.2,
        z = 0.3,
        w = 1.1
    } )
end

local HumAt = Instance.new( "Attachment" )
HumAt.Parent = Parent2
Argument1.humAt = HumAt
local Hum = Instance.new( "Sound" )
Hum.Name = "ZoneHum"
Hum.SoundId = "rbxassetid://70713584450978"
Hum.Looped = true
Hum.Volume = 0.45
Hum.RollOffMode = Enum.RollOffMode.LinearSquare
Hum.RollOffMinDistance = 4
Hum.RollOffMaxDistance = 40
Hum.SoundGroup = game:GetService( "SoundService" ):FindFirstChild( "Master_Effects" )
Hum.Parent = Argument1.humAt
Argument1.hum = Hum
Parent.Parent = workspace
Hum:Play( )
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local N = 3.141592653589793 / Argument1.n
local Cos = Amount * math.cos( N )
local Width0 = 2 * Amount * math.sin( N )
local C = Argument1.c
local Base = Argument1.base
local Top = Argument1.top
local Segs = Argument1.segs
Value1 = nil

for Key, Value in Segs, nil, nil do
    local Value4
    local Cos2 = math.cos( Value.phi )
    local Sin = math.sin( Value.phi )
    local Vector32 = Vector3.new( -Sin, 0, Cos2 )
    local X2 = C.X + Cos2 * Cos
    local Z = C.Z + Sin * Cos
    local A0 = Value.a0
    A0.CFrame = CFrame.fromMatrix( Vector3.new( X2, Base, Z ), Vector3.new( 0, 1, 0 ), Vector32 )
    local A1 = Value.a1
    A1.CFrame = CFrame.fromMatrix( Vector3.new( X2, Top, Z ), Vector3.new( 0, 1, 0 ), Vector32 )
    local Table = { Value.glow, Value.bands, Value.hex }
    Value4 = nil

    for Key3, Value5 in Table, nil, nil do
        Value5.Width0 = Width0
        Value5.Width1 = Width0
    end

    local Hex = Value.hex
    Hex.TextureLength = Width0 / 1.734375
end

local Value2
local Ground = Argument1.ground + 0.35
local Ring = Argument1.ring
Value2 = nil

for Key2, Value3 in Ring, nil, nil do
    local A = Value3.a
    local X = C.X + math.cos( Value3.phi ) * Amount
    A.Position = Vector3.new( X, Ground, C.Z + math.sin( Value3.phi ) * Amount )
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = Visible

if Visible and not Upvalue2 then
    Upvalue2 = Instance.new( "ColorCorrectionEffect" )
    Upvalue2.Name = "RankedZoneTint"
    Upvalue2.Parent = Upvalue3
end
if Upvalue2 then
    local Table2
    local TweenInfo2 = TweenInfo.new( 0.6 )

    if Visible then
        local Table = {
            TintColor = Color3.fromRGB( 255, 226, 226 ),
            Saturation = 0.08,
            Contrast = 0.05
        }

        if Table then
            Table2 = Table
        else
            Table2 = { TintColor = Color3.new( 1, 1, 1 ), Saturation = 0, Contrast = 0 }
        end
    else
        Table2 = { TintColor = Color3.new( 1, 1, 1 ), Saturation = 0, Contrast = 0 }
    end

    Upvalue4:Create( Upvalue2, TweenInfo2, Table2 ):Play( )
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if not Upvalue1 then
    return
end
if Upvalue1.conn then
    Upvalue1.conn:Disconnect( )
end
if Upvalue1.folder then
    Upvalue1.folder:Destroy( )
end

Upvalue2.Visible = false

if Upvalue3 then
    Upvalue4:Create( Upvalue3, TweenInfo.new( 0.6 ), { TintColor = Color3.new( 1, 1, 1 ), Saturation = 0, Contrast = 0 } ):Play( )
end

Upvalue5.Enabled = false
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local ServerTimeNow = workspace:GetServerTimeNow( ) - os.clock( )

if not Upvalue1 or math.abs( ServerTimeNow - Upvalue1 ) > 0.5 then
    Upvalue1 = ServerTimeNow
else
    local Max = math.max( Amount or 0, 0 ) * 0.02
    local ServerTimeNow2 = ServerTimeNow - Upvalue1
    Upvalue1 = Upvalue1 + math.clamp( ServerTimeNow2, -Max, Max )
end

return os.clock( ) + Upvalue1
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp2
local Value1 = Upvalue1( Argument1 )

if Upvalue2.dur > 0 then
    local Clamp = math.clamp( ( Value1 - Upvalue2.t0 ) / Upvalue2.dur, 0, 1 )

    if Clamp then
        Clamp2 = Clamp
    else
        Clamp2 = 1
    end
else
    Clamp2 = 1
end

local R0 = Upvalue2.r0 + ( Upvalue2.r1 - Upvalue2.r0 ) * Clamp2
local Max2

if Upvalue3 and Upvalue3.CFrame.Position then
    local Sqrt = math.sqrt( ( ( Upvalue3 and Upvalue3.CFrame.Position ).X - Upvalue2.c.X ) ^ 2 + ( ( Upvalue3 and Upvalue3.CFrame.Position ).Z - Upvalue2.c.Z ) ^ 2 )
    local Y = ( Upvalue3 and Upvalue3.CFrame.Position ).Y - Upvalue2.top
    local Max = math.max( 0, Y, Upvalue2.base - ( Upvalue3 and Upvalue3.CFrame.Position ).Y )
    Max2 = math.max( 0.002, math.sqrt( ( Sqrt - Upvalue4 ) ^ 2 + Max * Max ) * 0.001 )
else
    Max2 = 0.002
end
if os.clock( ) - Upvalue5 >= 0.03333333333333333 then
    if Max2 < math.abs( R0 - Upvalue4 ) then
        local Clock = os.clock( )
        Upvalue4 = R0
        Upvalue5 = Clock
        Upvalue6( Upvalue2, R0 )
    elseif R0 == Upvalue2.r1 and Upvalue4 ~= R0 then
        local Clock = os.clock( )
        Upvalue4 = R0
        Upvalue5 = Clock
        Upvalue6( Upvalue2, R0 )
    end
end
if Upvalue3 and Upvalue3.CFrame.Position and Upvalue2.humAt then
    local Number, Number2
    local X = ( Upvalue3 and Upvalue3.CFrame.Position ).X - Upvalue2.c.X
    local Z = ( Upvalue3 and Upvalue3.CFrame.Position ).Z - Upvalue2.c.Z
    local Sqrt2 = math.sqrt( X * X + Z * Z )

    if Sqrt2 > 0.01 then
        Number = X / Sqrt2
        Number2 = Z / Sqrt2
    else
        Number = 1
        Number2 = 0
    end

    local HumAt = Upvalue2.humAt
    local X2 = Upvalue2.c.X + Number * Upvalue4
    local Y2 = ( Upvalue3 and Upvalue3.CFrame.Position ).Y
    local Base = Upvalue2.base
    local Clamp3 = math.clamp( Y2, Base, Upvalue2.top )
    HumAt.WorldPosition = Vector3.new( X2, Clamp3, Upvalue2.c.Z + Number2 * Upvalue4 )
end

local HumanoidRootPart
local Character = Upvalue7.Character

if Character then
    HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
else
    HumanoidRootPart = Character
end

local Humanoid

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local Flag

if not ( Upvalue2.t0 <= Value1 ) or not HumanoidRootPart or not Humanoid or not ( Humanoid.Health > 0 ) then
    Flag = false
else
    local Position = HumanoidRootPart.Position
    local X3 = ( Position.X - Upvalue2.c.X ) ^ 2 + ( Position.Z - Upvalue2.c.Z ) ^ 2

    if R0 * R0 < X3 then
        Flag = true
    else
        Flag = false
    end
end
if Flag ~= Upvalue8 then
    Upvalue8 = Flag
    Upvalue9( Flag )
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Argument1 )
local CurrentCamera = workspace.CurrentCamera
local ServerTimeNow = workspace:GetServerTimeNow( ) - os.clock( )

if not Upvalue2 or math.abs( ServerTimeNow - Upvalue2 ) > 0.5 then
    Upvalue2 = ServerTimeNow
else
    Upvalue2 = Upvalue2 + math.clamp( ServerTimeNow - Upvalue2, -0, 0 )
end

local Clamp2
local Clock = os.clock( ) + Upvalue2

if Argument1.dur > 0 then
    local Clamp = math.clamp( ( Clock - Argument1.t0 ) / Argument1.dur, 0, 1 )

    if Clamp then
        Clamp2 = Clamp
    else
        Clamp2 = 1
    end
else
    Clamp2 = 1
end

local R0 = Argument1.r0 + ( Argument1.r1 - Argument1.r0 ) * Clamp2
Upvalue3( Argument1, R0 )
local Clock2 = os.clock( )
Upvalue4.Enabled = true
local Flag = false
Argument1.conn = Upvalue5.PreRender:Connect( function( Argument1Inner )
    local Clamp2
    local Value1 = Upvalue6( Argument1Inner )

    if Argument1.dur > 0 then
        local Clamp = math.clamp( ( Value1 - Argument1.t0 ) / Argument1.dur, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 1
        end
    else
        Clamp2 = 1
    end

    local R0Inner = Argument1.r0 + ( Argument1.r1 - Argument1.r0 ) * Clamp2
    local Max2

    if CurrentCamera and CurrentCamera.CFrame.Position then
        local Sqrt = math.sqrt( ( ( CurrentCamera and CurrentCamera.CFrame.Position ).X - Argument1.c.X ) ^ 2 + ( ( CurrentCamera and CurrentCamera.CFrame.Position ).Z - Argument1.c.Z ) ^ 2 )
        local Y = ( CurrentCamera and CurrentCamera.CFrame.Position ).Y - Argument1.top
        local Max = math.max( 0, Y, Argument1.base - ( CurrentCamera and CurrentCamera.CFrame.Position ).Y )
        Max2 = math.max( 0.002, math.sqrt( ( Sqrt - R0 ) ^ 2 + Max * Max ) * 0.001 )
    else
        Max2 = 0.002
    end
    if os.clock( ) - Clock2 >= 0.03333333333333333 then
        if Max2 < math.abs( R0Inner - R0 ) then
            local Clock = os.clock( )
            R0 = R0Inner
            Clock2 = Clock
            Upvalue3( Argument1, R0Inner )
        elseif R0Inner == Argument1.r1 and R0 ~= R0Inner then
            local Clock = os.clock( )
            R0 = R0Inner
            Clock2 = Clock
            Upvalue3( Argument1, R0Inner )
        end
    end
    if CurrentCamera and CurrentCamera.CFrame.Position and Argument1.humAt then
        local Number, Number2
        local X = ( CurrentCamera and CurrentCamera.CFrame.Position ).X - Argument1.c.X
        local Z = ( CurrentCamera and CurrentCamera.CFrame.Position ).Z - Argument1.c.Z
        local Sqrt2 = math.sqrt( X * X + Z * Z )

        if Sqrt2 > 0.01 then
            Number = X / Sqrt2
            Number2 = Z / Sqrt2
        else
            Number = 1
            Number2 = 0
        end

        local HumAt = Argument1.humAt
        local X2 = Argument1.c.X + Number * R0
        local Y2 = ( CurrentCamera and CurrentCamera.CFrame.Position ).Y
        local Base = Argument1.base
        local Clamp3 = math.clamp( Y2, Base, Argument1.top )
        HumAt.WorldPosition = Vector3.new( X2, Clamp3, Argument1.c.Z + Number2 * R0 )
    end

    local HumanoidRootPart
    local Character = Upvalue7.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Humanoid

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local FlagInner

    if not ( Argument1.t0 <= Value1 ) or not HumanoidRootPart or not Humanoid or not ( Humanoid.Health > 0 ) then
        FlagInner = false
    else
        local Position = HumanoidRootPart.Position
        local X3 = ( Position.X - Argument1.c.X ) ^ 2 + ( Position.Z - Argument1.c.Z ) ^ 2

        if R0Inner * R0Inner < X3 then
            FlagInner = true
        else
            FlagInner = false
        end
    end
    if FlagInner ~= Flag then
        Flag = FlagInner
        Upvalue8( FlagInner )
    end
end )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil
local ZoneT0 = Upvalue2:GetAttribute( "ZoneT0" )

if type( ZoneT0 ) ~= "number" then
    Upvalue3 = nil

    if not Upvalue3 then
        return
    end
    if Upvalue3.conn then
        Upvalue3.conn:Disconnect( )
    end
    if Upvalue3.folder then
        Upvalue3.folder:Destroy( )
    end

    Upvalue4.Visible = false

    if Upvalue5 then
        Upvalue6:Create( Upvalue5, TweenInfo.new( 0.6 ), { TintColor = Color3.new( 1, 1, 1 ), Saturation = 0, Contrast = 0 } ):Play( )
    end

    Upvalue7.Enabled = false
    return
end
if Upvalue3 and Upvalue3.t0 == ZoneT0 then
    return
end

Upvalue3 = nil

if Upvalue3 then
    if Upvalue3.conn then
        Upvalue3.conn:Disconnect( )
    end
    if Upvalue3.folder then
        Upvalue3.folder:Destroy( )
    end

    Upvalue4.Visible = false

    if Upvalue5 then
        Upvalue6:Create( Upvalue5, TweenInfo.new( 0.6 ), { TintColor = Color3.new( 1, 1, 1 ), Saturation = 0, Contrast = 0 } ):Play( )
    end

    Upvalue7.Enabled = false
end

local Number = tonumber( Upvalue2:GetAttribute( "ZoneR0" ) )
local Number2 = tonumber( Upvalue2:GetAttribute( "ZoneR1" ) )
local ZoneX = Upvalue2:GetAttribute( "ZoneX" )
local ZoneY = Upvalue2:GetAttribute( "ZoneY" )
local ZoneZ = Upvalue2:GetAttribute( "ZoneZ" )

if not Number or not Number2 or type( ZoneX ) ~= "number" or type( ZoneY ) ~= "number" or type( ZoneZ ) ~= "number" then
    return
end
local Table = {
    c = Vector3.new( ZoneX, ZoneY, ZoneZ ),
    r0 = Number,
    r1 = Number2,
    t0 = ZoneT0,
    dur = tonumber( Upvalue2:GetAttribute( "ZoneDur" ) ) or 60,
    ground = ZoneY,
    base = ZoneY - 6,
    top = ZoneY + ( tonumber( Upvalue2:GetAttribute( "ZoneTop" ) ) or 60 ),
    n = math.clamp( math.round( 6.283185307179586 * Number / 14 ), 24, 64 )
}
Upvalue3 = Table
Upvalue8( Table )
return
]]
