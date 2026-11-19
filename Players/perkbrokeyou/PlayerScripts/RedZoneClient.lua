-- Players.perkbrokeyou.PlayerScripts.RedZoneClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UIStroke
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local RedZoneConfig = require( ReplicatedStorage:WaitForChild( "RedZoneConfig" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local RedZone = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "RedZone" )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local RedZoneHUD = PlayerGui:WaitForChild( "RedZoneHUD", math.huge )
local Alert = RedZoneHUD:WaitForChild( "Alert" )
local Board = RedZoneHUD:WaitForChild( "Board" )
local Vignette = RedZoneHUD:WaitForChild( "Vignette" )

local function Now()
    return workspace:GetServerTimeNow( )
end

local function Fmt( Argument1 )
    local Max = math.max( 0, ( math.ceil( Argument1 ) ) )
    return ( "%d:%02d" ):format( Max // 60, Max % 60 )
end

local function Short( Amount )
    local Text

    if Amount >= 1000000 then
        local Format = ( "%gM" ):format( Amount / 1000000 )

        if Format then
            Text = Format
        elseif Amount >= 1000 then
            local Format2 = ( "%gK" ):format( Amount / 1000 )

            if Format2 then
                Text = Format2
            else
                Text = tostring( Amount )
            end
        else
            Text = tostring( Amount )
        end
    elseif Amount >= 1000 then
        local Format2 = ( "%gK" ):format( Amount / 1000 )

        if Format2 then
            Text = Format2
        else
            Text = tostring( Amount )
        end
    else
        Text = tostring( Amount )
    end

    return Text
end

local function Sound( Name, Volume, PlaybackSpeed )
    local Notices

    if Name == "RollTick" then
        local Cases = PlayerGui:FindFirstChild( "Cases" )

        if Cases then
            Notices = Cases
        else
            Notices = PlayerGui:FindFirstChild( "Notices" )
        end
    else
        Notices = PlayerGui:FindFirstChild( "Notices" )
    end

    local FoundChild

    if Notices then
        FoundChild = Notices:FindFirstChild( Name, true )
    else
        FoundChild = Notices
    end
    if not FoundChild or not FoundChild:IsA( "Sound" ) then
        return
    end

    local Clone = FoundChild:Clone( )

    if Volume then
        Clone.Volume = Volume
    end
    if PlaybackSpeed then
        Clone.PlaybackSpeed = PlaybackSpeed
    end

    local Parent
    local Notices2 = PlayerGui:FindFirstChild( "Notices" )
    Parent = if Notices2 then Notices2 else PlayerGui
    Clone.Parent = Parent
    Clone.Ended:Once( function()
        Clone:Destroy( )
    end )
    Clone:Play( )
end

local function Siren()
    local AirdropSiren
    local Notices = PlayerGui:FindFirstChild( "Notices" )

    if Notices then
        AirdropSiren = Notices:FindFirstChild( "AirdropSiren" )
    else
        AirdropSiren = Notices
    end
    if not AirdropSiren or not AirdropSiren:IsA( "Sound" ) then
        return
    end
    AirdropSiren.Volume = 0.6
    AirdropSiren.TimePosition = 0
    AirdropSiren:Play( )
    task.delay( 7, function()
        local Create = TweenService:Create( AirdropSiren, TweenInfo.new( 1.2 ), { Volume = 0 } )
        Create:Play( )
        Create.Completed:Wait( )
        AirdropSiren:Stop( )
        AirdropSiren.Volume = 0.6
    end )
    return
end

local Title = Alert:WaitForChild( "Title" )
local Sub = Alert:WaitForChild( "Sub" )
local UIScale = Alert:FindFirstChildOfClass( "UIScale" )
local Panel = Alert:FindFirstChild( "Panel" )

if Panel then
    UIStroke = Alert.Panel:FindFirstChildOfClass( "UIStroke" )
else
    UIStroke = Panel
end

local Panel2 = if UIStroke then UIStroke.Thickness else UIStroke
local Number = 0

local function Pop( Scale )
    if UIScale then
        UIScale.Scale = Scale
        TweenService:Create( UIScale, TweenInfo.new( 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        return
    end
    return
end

local function HideAlert( Argument1 )
    if Argument1 ~= Number then
        return
    end
    if UIStroke and Panel2 then
        UIStroke.Thickness = Panel2
    end

    local Create = TweenService:Create( Alert, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
    Create:Play( )
    Create.Completed:Wait( )

    if Argument1 == Number then
        Alert.Visible = false
    end
end

local function ShowAlert( Text, Text2, NumberInner )
    Number = Number + 1
    Title.Text = Text
    Sub.Text = Text2

    if not Alert.Visible then
        Alert.Visible = true
        Alert.GroupTransparency = 1
        TweenService:Create( Alert, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { GroupTransparency = 0 } ):Play( )
    end

    Pop( NumberInner or 1.3 )
    return Number
end

local function Label()
    return ( tostring( ReplicatedStorage:GetAttribute( "RedZoneLabel" ) or "RED ZONE" ) )
end

local RunService = game:GetService( "RunService" )
local HttpService = game:GetService( "HttpService" )
local Lighting = game:GetService( "Lighting" )
local Value1 = nil
local Table = { }
local Table2 = { }
local Table3 = { }
local Number2 = 0.35
local Value2 = nil

local function Nseq( ... )
    local Table = { }
    local Table2 = { ... }
    local Count = #Table2
    local I = 1

    for I = 1, Count, 2 do
        table.insert( Table, NumberSequenceKeypoint.new( Table2[ I ], Table2[ I + 1 ] ) )
    end

    return NumberSequence.new( Table )
end

local Nseq2 = Nseq( 0, 0.3, 0.3, 0.62, 0.7, 0.9, 1, 1 )
local Nseq3 = Nseq( 0, 0.2, 0.35, 0.5, 0.75, 0.88, 1, 1 )
local Nseq4 = Nseq( 0, 0.3, 0.55, 0.75, 1, 1 )
local Nseq5 = Nseq( 0, 0, 1, 0 )
local Nseq6 = Nseq( 0, 0, 0.35, 0.45, 1, 1 )
local Nseq7 = Nseq( 0, 0.65, 0.4, 0.88, 1, 1 )

local function WallCF( Argument1, Argument2 )
    return CFrame.fromMatrix( Argument1, Vector3.new( 0, 1, 0 ), Argument2 )
end

local function SetPower( Power )
    local Value1
    Number2 = Power
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Item = Value[ 1 ]
        Item.Brightness = Value[ 2 ] * Power
    end
end

local function ClearWalls()
    if Value2 then
        Value2:Disconnect( )
        Value2 = nil
    end
    if Value1 then
        Value1:Destroy( )
        Value1 = nil
    end

    table.clear( Table2 )
    table.clear( Table3 )
end

local function Surge( Argument1, Argument2, Argument3, Argument4, Argument5 )
    if Value2 then
        Value2:Disconnect( )
    end

    local Clock = os.clock( )
    Value2 = RunService.Heartbeat:Connect( function()
        local Captured2
        local Min = math.min( 1, ( os.clock( ) - Clock ) / Argument4 )

        if Min < 0.45 then
            local Captured = Argument1 + ( Argument2 - Argument1 ) * math.sin( Min / 0.45 * 3.141592653589793 / 2 )

            if Captured then
                Captured2 = Captured
            else
                Captured2 = Argument2 + ( Argument3 - Argument2 ) * ( ( Min - 0.45 ) / 0.55 )
            end
        else
            Captured2 = Argument2 + ( Argument3 - Argument2 ) * ( ( Min - 0.45 ) / 0.55 )
        end

        local Value1
        Number2 = Captured2
        Value1 = nil

        for Key, Value in Table2, nil, nil do
            local Item = Value[ 1 ]
            Item.Brightness = Value[ 2 ] * Captured2
        end
        if Min >= 1 then
            Value2:Disconnect( )
            Value2 = nil

            if Argument5 then
                Argument5( )
            end
        end
    end )
end

local function BuildWalls()
    if Value2 then
        Value2:Disconnect( )
        Value2 = nil
    end
    if Value1 then
        Value1:Destroy( )
        Value1 = nil
    end

    table.clear( Table2 )
    table.clear( Table3 )
    local RedZoneActive = ReplicatedStorage:FindFirstChild( "RedZoneActive" )
    Table = RedZoneConfig.Boxes( RedZoneActive )

    if #Table == 0 then
        return
    end

    local Result2
    local Profile = RedZoneActive:GetAttribute( "Profile" )

    if type( Profile ) == "string" then
        local Success, Result = pcall( HttpService.JSONDecode, HttpService, Profile )

        if not Success or type( Result ) ~= "table" or type( Result.runs ) ~= "table" then
            Result2 = nil
        else
            Result2 = Result
        end
    else
        Result2 = nil
    end
    if not Result2 then
        local TableInner = { base = 0, runs = { } }

        for Key, Value in RedZoneConfig.Outline( Table ) do
            local Runs = TableInner.runs
            table.insert( Runs, { Value.a.X, Value.a.Z, Value.b.X, Value.b.Z, { 0, 0 } } )
            Result2 = TableInner
        end

        Result2 = TableInner
    end

    local Value1Inner
    Value1 = Instance.new( "Folder" )
    Value1.Name = "RedZoneWalls"
    local Parent = Instance.new( "Part" )
    Parent.Name = "Anchor"
    Parent.Anchored = true
    Parent.CanCollide = false
    Parent.CanQuery = false
    Parent.CanTouch = false
    Parent.CastShadow = false
    Parent.Transparency = 1
    Parent.Size = Vector3.new( 1, 1, 1 )
    Parent.CFrame = CFrame.identity
    Parent.Parent = Value1

    local function Att( CFrame )
        local Attachment = Instance.new( "Attachment" )
        Attachment.CFrame = CFrame
        Attachment.Parent = Parent
        return Attachment
    end

    local function Beam( Attachment0, Attachment1, Width0, Width1, Argument5 )
        local FaceCamera
        local Beam = Instance.new( "Beam" )
        Beam.Attachment0 = Attachment0
        Beam.Attachment1 = Attachment1
        Beam.Width0 = Width0
        Beam.Width1 = Width1
        Beam.Segments = 1
        FaceCamera = Argument5.face == true and true or false
        local Color2
        Beam.FaceCamera = FaceCamera
        Beam.LightEmission = Argument5.emit or 1
        Beam.LightInfluence = 0
        local Color = Argument5.color
        Color2 = if Color then Color else RedZoneConfig.COLOR
        local TextureMode
        Beam.Color = ColorSequence.new( Color2 )
        Beam.Transparency = Argument5.transp
        Beam.Texture = Argument5.tex or ""
        local Mode = Argument5.mode
        TextureMode = if Mode then Mode else Enum.TextureMode.Stretch
        Beam.TextureMode = TextureMode
        Beam.TextureLength = Argument5.len or 1
        Beam.TextureSpeed = Argument5.speed or 0
        Beam.ZOffset = Argument5.z or 0
        Beam.Brightness = ( Argument5.bright or 1 ) * Number2
        Beam.Parent = Parent
        table.insert( Table2, { Beam, Argument5.bright or 1 } )
        return Beam
    end

    local Number = ( tonumber( Result2.base ) or 0 ) - 1
    local Number2Inner = Number + RedZoneConfig.WALL_HEIGHT
    local Table2Inner = { }
    local Runs2 = Result2.runs
    Value1Inner = nil

    for Key2, Value2Inner in Runs2, nil, nil do
        local Item3
        local Item = Value2Inner[ 1 ]
        local Vector32 = Vector3.new( Item, 0, Value2Inner[ 2 ] )
        local Item2 = Value2Inner[ 3 ]
        local Vector33 = Vector3.new( Item2, 0, Value2Inner[ 4 ] )
        Item3 = type( Value2Inner[ 5 ] ) == "table" and #Value2Inner[ 5 ] > 0 and Value2Inner[ 5 ] or { Number + 1 }
        local Magnitude = ( Vector33 - Vector32 ).Magnitude

        if Magnitude >= 1 then
            local Unit = ( Vector33 - Vector32 ).Unit

            local function Curtain( Argument1, Width0, Argument3 )
                local X = Argument1.X
                local CFrame2 = CFrame.fromMatrix( Vector3.new( X, Number, Argument1.Z ), Vector3.new( 0, 1, 0 ), Unit )
                local Attachment = Instance.new( "Attachment" )
                Attachment.CFrame = CFrame2
                Attachment.Parent = Parent
                local X2 = Argument1.X
                local CFrame3 = CFrame.fromMatrix( Vector3.new( X2, Number2Inner, Argument1.Z ), Vector3.new( 0, 1, 0 ), Unit )
                local Attachment2 = Instance.new( "Attachment" )
                Attachment2.CFrame = CFrame3
                Attachment2.Parent = Parent
                return ( Beam( Attachment, Attachment2, Width0, Width0, Argument3 ) )
            end

            local Vector34 = ( Vector32 + Vector33 ) / 2
            Curtain( Vector34, Magnitude, {
                transp = Nseq2,
                bright = 0.9,
                emit = 0.25,
                color = Color3.fromRGB( 185, 10, 26 )
            } )
            Curtain( Vector34, Magnitude, {
                tex = RedZoneConfig.TEX_BANDS,
                mode = Enum.TextureMode.Wrap,
                len = 34,
                speed = 0.22,
                transp = Nseq4,
                bright = 1.3,
                z = 0.1
            } )
            local Max = math.max( 1, ( math.round( Magnitude / RedZoneConfig.HEX_CELL ) ) )
            local Magnitude2 = Magnitude / Max
            local J = 1

            for J = 1, Max do
                local Vector35 = Vector32 + Unit * ( Magnitude2 * ( J - 0.5 ) )
                Curtain( Vector35, Magnitude2, {
                    tex = RedZoneConfig.TEX_HEX,
                    mode = Enum.TextureMode.Wrap,
                    len = Magnitude2 / 1.734375,
                    speed = 0.05,
                    transp = Nseq3,
                    bright = 1.25,
                    z = 0.2,
                    color = Color3.fromRGB( 255, 34, 48 )
                } )
            end

            local Table3Inner = { }
            local Count = #Item3
            local J2 = 1

            for J2 = 1, Count do
                local Lerp2

                if #Item3 > 1 then
                    local Lerp = Vector32:Lerp( Vector33, ( J2 - 1 ) / ( #Item3 - 1 ) )

                    if Lerp then
                        Lerp2 = Lerp
                    else
                        Lerp2 = Vector32
                    end
                else
                    Lerp2 = Vector32
                end

                local X = Lerp2.X
                local Entry = Item3[ J2 ] + 0.35
                table.insert( Table3Inner, ( Vector3.new( X, Entry, Lerp2.Z ) ) )
            end
            if #Table3Inner == 1 then
                local X2 = Vector33.X
                local Y = Table3Inner[ 1 ].Y
                table.insert( Table3Inner, ( Vector3.new( X2, Y, Vector33.Z ) ) )
            end

            local Table4 = { Table3Inner[ 1 ] }
            local Count2 = #Table3Inner - 1
            local J3 = 2

            for J3 = 2, Count2 do
                local Entry2 = Table4[ #Table4 ]
                local Entry3 = Table3Inner[ J3 ]
                local Entry4 = Table3Inner[ J3 + 1 ]
                local Magnitude3 = ( Entry3 - Entry2 ).Magnitude / math.max( ( Entry4 - Entry2 ).Magnitude, 0.001 )

                if math.abs( Entry2.Y + ( Entry4.Y - Entry2.Y ) * Magnitude3 - Entry3.Y ) > 0.25 then
                    table.insert( Table4, Entry3 )
                end
            end

            local Attachment5
            table.insert( Table4, Table3Inner[ #Table3Inner ] )
            local CFrame4 = CFrame.new( Table4[ 1 ] )
            local Attachment3 = Instance.new( "Attachment" )
            Attachment3.CFrame = CFrame4
            Attachment3.Parent = Parent
            local Count3 = #Table4
            local J4 = 2
            Attachment5 = Attachment3

            for J4 = 2, Count3 do
                local CFrame5 = CFrame.new( Table4[ J4 ] )
                local Attachment4 = Instance.new( "Attachment" )
                Attachment4.CFrame = CFrame5
                Attachment4.Parent = Parent
                Beam( Attachment5, Attachment4, 1.1, 1.1, {
                    face = true,
                    tex = RedZoneConfig.TEX_LINE,
                    transp = Nseq5,
                    color = RedZoneConfig.COLOR_HOT,
                    bright = 2.2,
                    z = 0.3
                } )
                Attachment5 = Attachment4
            end

            local Value5, Number3
            Value5 = nil
            Number3 = 0

            for Key4, Value6 in Item3, nil, nil do
                Number3 = Number3 + Value6
            end

            local Value7
            local Number4 = Number3 / #Item3
            local Parent2 = Instance.new( "Part" )
            Parent2.Name = "Embers"
            Parent2.Anchored = true
            Parent2.CanCollide = false
            Parent2.CanQuery = false
            Parent2.CanTouch = false
            Parent2.CastShadow = false
            Parent2.Transparency = 1
            Parent2.Size = Vector3.new( Magnitude, 0.2, 0.2 )
            local X3 = Vector34.X
            local Number5 = Number4 + 0.5
            Parent2.CFrame = CFrame.fromMatrix( Vector3.new( X3, Number5, Vector34.Z ), Unit, Vector3.new( 0, 1, 0 ) )
            local ParticleEmitter = Instance.new( "ParticleEmitter" )
            ParticleEmitter.Texture = RedZoneConfig.TEX_EMBER
            ParticleEmitter.Color = ColorSequence.new( RedZoneConfig.COLOR_HOT, Color3.fromRGB( 255, 150, 70 ) )
            ParticleEmitter.LightEmission = 1
            ParticleEmitter.LightInfluence = 0
            ParticleEmitter.Size = Nseq( 0, 0.45, 0.6, 0.3, 1, 0 )
            ParticleEmitter.Transparency = Nseq( 0, 0.1, 0.7, 0.4, 1, 1 )
            ParticleEmitter.Lifetime = NumberRange.new( 2.5, 4.5 )
            ParticleEmitter.Speed = NumberRange.new( 3, 7 )
            ParticleEmitter.Acceleration = Vector3.new( 0, 1.5, 0 )
            ParticleEmitter.Drag = 0.4
            ParticleEmitter.SpreadAngle = Vector2.new( 12, 12 )
            ParticleEmitter.EmissionDirection = Enum.NormalId.Top
            ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box
            ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
            ParticleEmitter.Rate = math.clamp( Magnitude * 0.035, 1, 14 )
            ParticleEmitter.Enabled = false
            ParticleEmitter.Parent = Parent2
            Parent2.Parent = Value1
            table.insert( Table3, ParticleEmitter )
            local Table5 = { { Vector32, Item3[ 1 ] }, { Vector33, Item3[ #Item3 ] } }
            Value7 = nil

            for Key5, Value8 in Table5, nil, nil do
                local Vector36
                local Format = ( "%d,%d" ):format( math.round( Value8[ 1 ].X ), ( math.round( Value8[ 1 ].Z ) ) )
                local Entry5 = Table2Inner[ Format ]

                if Entry5 then
                    Vector36 = Entry5
                else
                    local X4 = Value8[ 1 ].X
                    local Item4 = Value8[ 2 ]
                    Vector36 = Vector3.new( X4, Item4, Value8[ 1 ].Z )
                end

                Table2Inner[ Format ] = Vector36
            end
        end
    end

    local Value3 = nil

    for Key3, Value4 in Table2Inner, nil, nil do
        local CFrame2 = CFrame.new( Value4 )
        local Attachment = Instance.new( "Attachment" )
        Attachment.CFrame = CFrame2
        Attachment.Parent = Parent
        local CFrame3 = CFrame.new( Value4 + Vector3.new( 0, RedZoneConfig.PILLAR_HEIGHT, 0 ) )
        local Attachment2 = Instance.new( "Attachment" )
        Attachment2.CFrame = CFrame3
        Attachment2.Parent = Parent
        Beam( Attachment, Attachment2, 2.6, 0.8, {
            face = true,
            tex = RedZoneConfig.TEX_LINE,
            transp = Nseq6,
            color = RedZoneConfig.COLOR_HOT,
            bright = 2.5,
            z = 0.4
        } )
        Beam( Attachment, Attachment2, 14, 4, {
            face = true,
            tex = RedZoneConfig.TEX_LINE,
            transp = Nseq7,
            bright = 1,
            z = 0.35
        } )
    end

    Value1.Parent = workspace
end

local function ZoneLive( Enabled, Argument2 )
    local Value1 = nil

    for Key, Value in Table3, nil, nil do
        Value.Enabled = Enabled
    end
    if not Enabled or not Argument2 then
        local Number4 = not Enabled and 0.35 or 1
        local Value3
        Number2 = Number4
        Value3 = nil

        for Key2, Value4 in Table2, nil, nil do
            local Item = Value4[ 1 ]
            Item.Brightness = Value4[ 2 ] * Number4
        end

        return
    end
    if Value2 then
        Value2:Disconnect( )
    end

    local Clock = os.clock( )
    local Number = 1.4
    local Number2Inner = 2
    local Number3 = 1
    local Value2Inner = nil
    Value2 = RunService.Heartbeat:Connect( function()
        local Captured2
        local Min = math.min( 1, ( os.clock( ) - Clock ) / Number )

        if Min < 0.45 then
            local Captured = Number2 + ( Number2Inner - Number2 ) * math.sin( Min / 0.45 * 3.141592653589793 / 2 )

            if Captured then
                Captured2 = Captured
            else
                Captured2 = Number2Inner + ( Number3 - Number2Inner ) * ( ( Min - 0.45 ) / 0.55 )
            end
        else
            Captured2 = Number2Inner + ( Number3 - Number2Inner ) * ( ( Min - 0.45 ) / 0.55 )
        end

        local Value1
        Number2 = Captured2
        Value1 = nil

        for Key, Value in Table2, nil, nil do
            local Item = Value[ 1 ]
            Item.Brightness = Value[ 2 ] * Captured2
        end
        if Min >= 1 then
            Value2:Disconnect( )
            Value2 = nil

            if Value2Inner then
                Value2Inner( )
            end
        end
    end )
    return
end

local function FadeOut()
    local Value1Inner = nil

    for Key, Value in Table3, nil, nil do
        Value.Enabled = false
    end
    if Value1 then
        local Captured = Number2 * 1.4

        if Value2 then
            Value2:Disconnect( )
        end

        local Clock = os.clock( )
        local Number = 0.9
        local Number2Inner = 0
        Value2 = RunService.Heartbeat:Connect( function()
            local Captured2
            local Min = math.min( 1, ( os.clock( ) - Clock ) / Number )

            if Min < 0.45 then
                local CapturedInner = Number2 + ( Captured - Number2 ) * math.sin( Min / 0.45 * 3.141592653589793 / 2 )

                if CapturedInner then
                    Captured2 = CapturedInner
                else
                    Captured2 = Captured + ( Number2Inner - Captured ) * ( ( Min - 0.45 ) / 0.55 )
                end
            else
                Captured2 = Captured + ( Number2Inner - Captured ) * ( ( Min - 0.45 ) / 0.55 )
            end

            local Value1
            Number2 = Captured2
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                local Item = Value[ 1 ]
                Item.Brightness = Value[ 2 ] * Captured2
            end
            if Min >= 1 then
                Value2:Disconnect( )
                Value2 = nil

                if ClearWalls then
                    ClearWalls( )
                end
            end
        end )
    end
end

local Value3 = nil

local function SetInside( Visible )
    Vignette.Visible = Visible

    if Visible and not Value3 then
        Value3 = Instance.new( "ColorCorrectionEffect" )
        Value3.Name = "RedZoneTint"
        Value3.Parent = Lighting
    end
    if Value3 then
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

        TweenService:Create( Value3, TweenInfo2, Table2 ):Play( )
    end
end

local Table4 = { }
local I = 1

for I = 1, 3 do
    local Child = Board:WaitForChild( "Row" .. I )
    Table4[ I ] = {
        name = Child:WaitForChild( "PlayerName" ),
        value = Child:WaitForChild( "Value" )
    }
end

local CurrentCamera2
local Title2 = Board:WaitForChild( "Title" )
local Timer = Board:WaitForChild( "Timer" )
local TextColor3 = Timer.TextColor3
local FromHex = Color3.fromHex( "ffca56" )
local Left = Board:WaitForChild( "Me" ):WaitForChild( "Left" )
local Right = Board.Me:WaitForChild( "Right" )
local Rank = Board.Me:WaitForChild( "Rank" )
local FromRGB = Color3.fromRGB( 130, 220, 114 )
local UIScale2 = Board:FindFirstChildOfClass( "UIScale" )
local Size = Board.Size

local function Fit()
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        if CurrentCamera.ViewportSize.Y < 600 then
            CurrentCamera2 = true
        else
            CurrentCamera2 = false
        end
    else
        CurrentCamera2 = CurrentCamera
    end

    local SizeInner

    if CurrentCamera2 then
        local PhoneSize = Board:GetAttribute( "PhoneSize" )

        if PhoneSize then
            SizeInner = PhoneSize
        elseif Size then
            SizeInner = Size
        else
            SizeInner = Size
        end
    else
        SizeInner = Size
    end

    Board.Size = SizeInner
end

local CurrentCamera = workspace.CurrentCamera

if CurrentCamera then
    if CurrentCamera.ViewportSize.Y < 600 then
        CurrentCamera2 = true
    else
        CurrentCamera2 = false
    end
else
    CurrentCamera2 = CurrentCamera
end

local Size2

if CurrentCamera2 then
    local PhoneSize = Board:GetAttribute( "PhoneSize" )

    if PhoneSize then
        Size2 = PhoneSize
    elseif Size then
        Size2 = Size
    else
        Size2 = Size
    end
else
    Size2 = Size
end

Board.Size = Size2
workspace.CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
local Table5 = { }

for Key, Value in Board:GetDescendants( ) do
    if Value:IsA( "TextLabel" ) and Value:GetAttribute( "TextH" ) then
        local UITextSizeConstraint
        local TypeSize = Value:FindFirstChild( "TypeSize" )

        if TypeSize then
            UITextSizeConstraint = TypeSize
        else
            UITextSizeConstraint = Instance.new( "UITextSizeConstraint" )
        end

        UITextSizeConstraint.Name = "TypeSize"
        Value:SetAttribute( "OffsetOK", true )
        UITextSizeConstraint.Parent = Value
        table.insert( Table5, { Value, UITextSizeConstraint } )
    end
end

local function ApplyType()
    local Y = Board.AbsoluteSize.Y

    if Y <= 0 then
        return
    end

    local Value1 = nil

    for Key, Value in Table5, nil, nil do
        local Item = Value[ 2 ]
        Item.MaxTextSize = math.max( 1, ( math.floor( Y * Value[ 1 ]:GetAttribute( "TextH" ) + 0.5 ) ) )
    end
end

Board:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( ApplyType )
task.defer( ApplyType )

local function SetRow( RowName, RowName2, RowName3, TextColor3 )
    local TextTransparency
    local Entry = Table4[ RowName ]
    local Name = Entry.name
    Name.Text = RowName2 or "—"
    local Name2 = Entry.name
    TextTransparency = not RowName2 and 0.5 or 0
    Name2.TextTransparency = TextTransparency
    local Value = Entry.value
    Value.Text = RowName3 or ""
    local Value2 = Entry.value
    Value2.TextColor3 = TextColor3 or Color3.new( 1, 1, 1 )
end

local function ShowBoard( Visible )
    if Visible == Board.Visible then
        return
    end

    Board.Visible = Visible

    if Visible then
        Board.GroupTransparency = 1
        TweenService:Create( Board, TweenInfo.new( 0.35 ), { GroupTransparency = 0 } ):Play( )

        if UIScale2 then
            UIScale2.Scale = 0.9
            TweenService:Create( UIScale2, TweenInfo.new( 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end
    end
end

local function RenderBoard( List )
    Title2.Text = "RED ZONE"
    Timer.Visible = true
    local I = 1

    for I = 1, 3 do
        local Entry3
        local Entry = List[ I ]
        Entry3 = if Entry then Entry.name else Entry
        local Entry4 = if Entry then tostring( Entry.n ) else Entry
        local TextTransparency
        local Entry2 = Table4[ I ]
        local Name = Entry2.name
        Name.Text = Entry3 or "—"
        local Name2 = Entry2.name
        TextTransparency = not Entry3 and 0.5 or 0
        Name2.TextTransparency = TextTransparency
        local Value = Entry2.value
        Value.Text = Entry4 or ""
        local Value2 = Entry2.value
        Value2.TextColor3 = Color3.new( 1, 1, 1 )
    end

    local Value1, N, Value4
    Value1 = nil

    for Key, Value3 in List, nil, nil do
        if Value3.id == LocalPlayer.UserId then
            N = Value3.n
            Value4 = Key
            break
        end

        Value4 = nil
        N = 0
    end

    local Text = Value4 and ( "#%d" ):format( Value4 ) or "—"
    local Text3
    Rank.Text = Text
    Left.Text = "YOU"

    if RedZoneConfig.MIN_KILLS <= N then
        local Text2 = tostring( N )

        if Text2 then
            Text3 = Text2
        else
            Text3 = ( "%d/%d" ):format( N, RedZoneConfig.MIN_KILLS )
        end
    else
        Text3 = ( "%d/%d" ):format( N, RedZoneConfig.MIN_KILLS )
    end

    Right.Text = Text3
end

local Flag = false
local Number3 = -1
local Value4 = nil
local Flag2 = false

local function Step()
    local RedZoneStartAt = ReplicatedStorage:GetAttribute( "RedZoneStartAt" )
    local RedZoneEndsAt = ReplicatedStorage:GetAttribute( "RedZoneEndsAt" )

    if type( RedZoneStartAt ) ~= "number" or type( RedZoneEndsAt ) ~= "number" then
        return false
    end

    local Flag = ReplicatedStorage:GetAttribute( "RedZoneLive" ) == true and true or false
    local RedZoneEndsAt2 = Flag and RedZoneEndsAt or RedZoneStartAt
    local Ceil = math.ceil( RedZoneEndsAt2 - workspace:GetServerTimeNow( ) )

    if Ceil ~= Number3 then
        local TextColor3Inner
        Number3 = Ceil
        local Max = math.max( 0, ( math.ceil( Ceil ) ) )
        Timer.Text = ( "%d:%02d" ):format( Max // 60, Max % 60 )

        if Flag or not FromHex then
            if Ceil <= 60 then
                local FromRGB = Color3.fromRGB( 255, 96, 96 )

                if FromRGB then
                    TextColor3Inner = FromRGB
                else
                    TextColor3Inner = TextColor3
                end
            else
                TextColor3Inner = TextColor3
            end
        else
            TextColor3Inner = FromHex
        end

        Timer.TextColor3 = TextColor3Inner
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Inside2

    if HumanoidRootPart == nil then
        Inside2 = false
    else
        local Inside = RedZoneConfig.Inside
        Inside2 = Inside( Table, HumanoidRootPart.Position, 0 )
    end
    if Inside2 ~= Value4 then
        Value4 = Inside2
        Flag2 = Inside2
        SetInside( Inside2 and Flag )
        ShowBoard( Inside2 )
    end

    return true
end

local function StartLoop()
    if Flag then
        return
    end
    Flag = true
    task.spawn( function()
        while Flag do
            if not Step( ) then
                break
            end

            task.wait( 0.25 )
        end

        Flag = false
        Value4 = nil
        Vignette.Visible = false

        if Value3 then
            TweenService:Create( Value3, TweenInfo.new( 0.6 ), { TintColor = Color3.new( 1, 1, 1 ), Saturation = 0, Contrast = 0 } ):Play( )
        end
        if Value3 then
            Value3 = nil
            task.delay( 0.7, function()
                Value3:Destroy( )
            end )
        end
    end )
    return
end

local Number4 = 0

local function OnStart()
    local RedZoneStartAt = ReplicatedStorage:GetAttribute( "RedZoneStartAt" )
    Number4 = Number4 + 1

    if type( RedZoneStartAt ) == "number" then
        local Number3Inner = ReplicatedStorage:GetAttribute( "RedZoneLive" ) ~= true and 0.35 or 1
        local Enabled
        Number2 = Number3Inner
        BuildWalls( )
        Enabled = Number2 == 1 and true or false
        local Value2Inner = nil

        for Key2, Value3Inner in Table3, nil, nil do
            Value3Inner.Enabled = Enabled
        end

        local Number4Inner = not Enabled and 0.35 or 1
        local Value4Inner
        Number2 = Number4Inner
        Value4Inner = nil

        for Key3, Value5 in Table2, nil, nil do
            local Item = Value5[ 1 ]
            Item.Brightness = Value5[ 2 ] * Number4Inner
        end

        RenderBoard( { } )
        Number3 = -1
        Value4 = nil
        Flag2 = false

        if not Flag then
            Flag = true
            task.spawn( function()
                while Flag do
                    if not Step( ) then
                        break
                    end

                    task.wait( 0.25 )
                end

                Flag = false
                Value4 = nil
                Vignette.Visible = false

                if Value3 then
                    TweenService:Create( Value3, TweenInfo.new( 0.6 ), { TintColor = Color3.new( 1, 1, 1 ), Saturation = 0, Contrast = 0 } ):Play( )
                end
                if Value3 then
                    Value3 = nil
                    task.delay( 0.7, function()
                        Value3:Destroy( )
                    end )
                end
            end )
        end
        if RedZoneStartAt - workspace:GetServerTimeNow( ) > 1.5 then
            Siren( )
            local ShowAlert2 = ShowAlert( "RED ZONE INCOMING", ( "%s · starting soon · follow the red mark on your compass" ):format( ( tostring( ReplicatedStorage:GetAttribute( "RedZoneLabel" ) or "RED ZONE" ) ) ) )
            task.spawn( function()
                local Clock = os.clock( )

                while Number4 == Number4 do
                    if ShowAlert2 ~= Number or not ( os.clock( ) - Clock < 9 ) then
                        break
                    end

                    local Captured = RedZoneStartAt - workspace:GetServerTimeNow( )

                    if not ( RedZoneConfig.FINAL_COUNT < Captured ) then
                        break
                    end
                    if UIStroke and Panel2 then
                        UIStroke.Thickness = Panel2 * ( ( math.sin( ( os.clock( ) - Clock ) * 8 ) * 0.5 + 0.5 ) * 0.8 + 1 )
                    end

                    task.wait( 0.05 )
                end
                if Number4 == Number4 and ShowAlert2 == Number then
                    local Captured2 = RedZoneStartAt - workspace:GetServerTimeNow( )

                    if RedZoneConfig.FINAL_COUNT < Captured2 then
                        HideAlert( ShowAlert2 )
                    end
                end
            end )
        end

        task.spawn( function()
            local Captured = RedZoneStartAt - RedZoneConfig.FINAL_COUNT - workspace:GetServerTimeNow( )

            if Captured > 0 then
                task.wait( Captured )
            end
            if Number4 ~= Number4 then
                return
            end

            local Ceil2 = nil

            while Number4 == Number4 do
                local Ceil = math.ceil( RedZoneStartAt - workspace:GetServerTimeNow( ) )

                if Ceil <= 0 then
                    break
                end
                if Ceil ~= Ceil2 then
                    local Number
                    local Format = ( "RED ZONE IN %d" ):format( Ceil )
                    local Text = tostring( ReplicatedStorage:GetAttribute( "RedZoneLabel" ) or "RED ZONE" )
                    local Text2 = Text .. " · kills count ×" .. tostring( RedZoneConfig.CASH_MULT ) .. " cash"
                    Number = not ( Ceil <= 3 ) and 1.08 or 1.18
                    local Number2
                    ShowAlert( Format, Text2, Number )
                    Number2 = not ( Ceil <= 3 ) and 0.7 or 1.3
                    local Number3 = not ( Ceil <= 3 ) and 1 or 0.75
                    Sound( "RollTick", Number2, Number3 )
                    Ceil2 = Ceil
                end

                task.wait( 0.03 )
            end
            if Number4 ~= Number4 then
                return
            end

            local RedZoneEndsAt3
            Sound( "AlertSound" )
            local RedZoneEndsAt = ReplicatedStorage:GetAttribute( "RedZoneEndsAt" )

            if type( RedZoneEndsAt ) == "number" then
                local RedZoneEndsAt2 = RedZoneEndsAt - RedZoneStartAt

                if RedZoneEndsAt2 then
                    RedZoneEndsAt3 = RedZoneEndsAt2
                else
                    RedZoneEndsAt3 = RedZoneConfig.DURATION
                end
            else
                RedZoneEndsAt3 = RedZoneConfig.DURATION
            end

            local Text3 = tostring( ReplicatedStorage:GetAttribute( "RedZoneLabel" ) or "RED ZONE" )
            local Max = math.max( 0, ( math.ceil( RedZoneEndsAt3 ) ) )
            local ShowAlert2 = ShowAlert( "RED ZONE ACTIVE", ( "%s · %s · most kills wins %s" ):format( Text3, ( "%d:%02d" ):format( Max // 60, Max % 60 ), MoneyFormat( RedZoneConfig.PRIZES[ 1 ] ) ), 1.25 )
            task.delay( 3.5, function()
                HideAlert( ShowAlert2 )
            end )
        end )
        return
    end
    local Value1Inner
    Flag = false
    Value1Inner = nil

    for Key, Value in Table3, nil, nil do
        Value.Enabled = false
    end
    if Value1 then
        local Captured = Number2 * 1.4

        if Value2 then
            Value2:Disconnect( )
        end

        local Clock = os.clock( )
        local NumberInner = 0.9
        local Number2Inner = 0
        Value2 = RunService.Heartbeat:Connect( function()
            local Captured2
            local Min = math.min( 1, ( os.clock( ) - Clock ) / NumberInner )

            if Min < 0.45 then
                local CapturedInner = Number2 + ( Captured - Number2 ) * math.sin( Min / 0.45 * 3.141592653589793 / 2 )

                if CapturedInner then
                    Captured2 = CapturedInner
                else
                    Captured2 = Captured + ( Number2Inner - Captured ) * ( ( Min - 0.45 ) / 0.55 )
                end
            else
                Captured2 = Captured + ( Number2Inner - Captured ) * ( ( Min - 0.45 ) / 0.55 )
            end

            local Value1
            Number2 = Captured2
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                local Item = Value[ 1 ]
                Item.Brightness = Value[ 2 ] * Captured2
            end
            if Min >= 1 then
                Value2:Disconnect( )
                Value2 = nil

                if ClearWalls then
                    ClearWalls( )
                end
            end
        end )
    end

    return
end

ReplicatedStorage:GetAttributeChangedSignal( "RedZoneStartAt" ):Connect( OnStart )
ReplicatedStorage:GetAttributeChangedSignal( "RedZoneLive" ):Connect( function()
    if ReplicatedStorage:GetAttribute( "RedZoneLive" ) == true then
        local Value1 = nil

        for Key, Value in Table3, nil, nil do
            Value.Enabled = true
        end
        if Value2 then
            Value2:Disconnect( )
        end

        local Clock = os.clock( )
        local Number = 1.4
        local Number2Inner = 2
        local Number3Inner = 1
        local Value2Inner = nil
        Value2 = RunService.Heartbeat:Connect( function()
            local Captured2
            local Min = math.min( 1, ( os.clock( ) - Clock ) / Number )

            if Min < 0.45 then
                local Captured = Number2 + ( Number2Inner - Number2 ) * math.sin( Min / 0.45 * 3.141592653589793 / 2 )

                if Captured then
                    Captured2 = Captured
                else
                    Captured2 = Number2Inner + ( Number3Inner - Number2Inner ) * ( ( Min - 0.45 ) / 0.55 )
                end
            else
                Captured2 = Number2Inner + ( Number3Inner - Number2Inner ) * ( ( Min - 0.45 ) / 0.55 )
            end

            local Value1
            Number2 = Captured2
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                local Item = Value[ 1 ]
                Item.Brightness = Value[ 2 ] * Captured2
            end
            if Min >= 1 then
                Value2:Disconnect( )
                Value2 = nil

                if Value2Inner then
                    Value2Inner( )
                end
            end
        end )
        RenderBoard( { } )
        Number3 = -1
        Value4 = nil
    end
end )
local Number5 = 0
RedZone.OnClientEvent:Connect( function( Name, List, Argument3 )
    if Name == "board" and type( List ) == "table" then
        RenderBoard( List )
        return
    end
    if Name == "results" then
        Number5 = Number5 + 1

        if type( List ) == "table" then
            local Table
            Title2.Text = "RED ZONE OVER"
            Timer.Visible = false
            local I = 1
            Table = nil

            for I = 1, 3 do
                local Entry3
                local Entry = List[ I ]
                Entry3 = if Entry then Entry.name else Entry
                local Format3

                if Entry then
                    local Text
                    local Prize = Entry.prize

                    if Prize >= 1000000 then
                        local Format = ( "%gM" ):format( Prize / 1000000 )

                        if Format then
                            Text = Format
                        elseif Prize >= 1000 then
                            local Format2 = ( "%gK" ):format( Prize / 1000 )

                            if Format2 then
                                Text = Format2
                            else
                                Text = tostring( Prize )
                            end
                        else
                            Text = tostring( Prize )
                        end
                    elseif Prize >= 1000 then
                        local Format2 = ( "%gK" ):format( Prize / 1000 )

                        if Format2 then
                            Text = Format2
                        else
                            Text = tostring( Prize )
                        end
                    else
                        Text = tostring( Prize )
                    end

                    Format3 = ( "+$%s" ):format( Text )
                else
                    Format3 = Entry
                end

                local TextTransparency
                local Entry2 = Table4[ I ]
                local Name2 = Entry2.name
                Name2.Text = Entry3 or "—"
                local Name3 = Entry2.name
                TextTransparency = not Entry3 and 0.5 or 0
                Name3.TextTransparency = TextTransparency
                local Value = Entry2.value
                Value.Text = Format3 or ""
                local Value2 = Entry2.value
                Value2.TextColor3 = FromRGB or Color3.new( 1, 1, 1 )

                if Entry and Entry.id == LocalPlayer.UserId then
                    Table = { rank = I, prize = Entry.prize }
                end
            end

            local Text2

            if Table then
                local Format4 = ( "#%d" ):format( Table.rank )

                if Format4 then
                    Text2 = Format4
                else
                    Text2 = ""
                end
            else
                Text2 = ""
            end

            local Text3
            Rank.Text = Text2

            if #List == 0 then
                local Format5 = ( "NO WINNER · %d KILLS MIN." ):format( RedZoneConfig.MIN_KILLS )

                if Format5 then
                    Text3 = Format5
                elseif Table then
                    local Format6 = ( "YOU WIN %s!" ):format( MoneyFormat( Table.prize ) )

                    if Format6 then
                        Text3 = Format6
                    else
                        Text3 = "YOU"
                    end
                else
                    Text3 = "YOU"
                end
            elseif Table then
                local Format6 = ( "YOU WIN %s!" ):format( MoneyFormat( Table.prize ) )

                if Format6 then
                    Text3 = Format6
                else
                    Text3 = "YOU"
                end
            else
                Text3 = "YOU"
            end

            Left.Text = Text3
            Right.Text = ""
            ShowBoard( Flag2 )

            if Table then
                local Kaching
                local Entry4 = ( { "1ST", "2ND", "3RD" } )[ Table.rank ]
                local Announce = Notify.Announce
                local Text4 = "RED ZONE · " .. Entry4
                Announce( Text4, "+" .. MoneyFormat( Table.prize ), 5 )
                local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

                if GlobalGui then
                    Kaching = GlobalGui:FindFirstChild( "Kaching", true )
                else
                    Kaching = GlobalGui
                end
                if Kaching and Kaching:IsA( "Sound" ) then
                    Kaching:Play( )
                end
            end

            task.delay( RedZoneConfig.RESULTS_TIME, function()
                if Number5 ~= Number5 or ReplicatedStorage:GetAttribute( "RedZoneLive" ) == true then
                    return
                end

                local Create = TweenService:Create( Board, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
                Create:Play( )
                Create.Completed:Wait( )

                if Number5 == Number5 and ReplicatedStorage:GetAttribute( "RedZoneLive" ) ~= true then
                    if Board.Visible == false then
                        return
                    end

                    Board.Visible = false
                end
            end )
        elseif Board.Visible == false then
            return
        else
            Board.Visible = false
            return
        end
    end
end )
task.defer( function()
    if type( ReplicatedStorage:GetAttribute( "RedZoneStartAt" ) ) == "number" then
        OnStart( )
    end
end )
