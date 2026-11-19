-- Players.perkbrokeyou.PlayerScripts.BetaRevealClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local GiftFrom2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local Parent = game:GetService( "SoundService" )
local ContentProvider = game:GetService( "ContentProvider" )
local ProximityPromptService = game:GetService( "ProximityPromptService" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local LocalPlayer = Players.LocalPlayer
local BetaRevealRemote = ReplicatedStorage:WaitForChild( "BetaRevealRemote" )
local Get = require( ReplicatedStorage:WaitForChild( "Screens" ) ).Get( "BetaReveal" )
Get.Visible = false
local Tint = Get:WaitForChild( "Tint" )
local BarTop = Get:WaitForChild( "BarTop" )
local BarBottom = Get:WaitForChild( "BarBottom" )
local Flash = Get:WaitForChild( "Flash" )
local Stage = Get:WaitForChild( "Stage" )
local Rays = Stage:WaitForChild( "Rays" )
local Glow = Stage:WaitForChild( "Glow" )
local Medal = Stage:WaitForChild( "Medal" )
local Camo = Stage:WaitForChild( "Camo" )
local Title = Stage:WaitForChild( "Title" )
local Forever = Stage:WaitForChild( "Forever" )
local GiftFrom = Stage:FindFirstChild( "GiftFrom" )

if GiftFrom then
    local Format = GiftFrom:GetAttribute( "Format" )

    if Format then
        GiftFrom2 = Format
    else
        GiftFrom2 = GiftFrom.Text
    end
else
    GiftFrom2 = GiftFrom
end

local Table = { }

for Key, Value in Stage:WaitForChild( "Sparkles" ):GetChildren( ) do
    if Value:IsA( "ImageLabel" ) then
        table.insert( Table, Value )
    end
end

local Table2 = {
    tint = Tint.BackgroundTransparency,
    glow = Glow.BackgroundTransparency,
    glowSize = Glow.Size,
    raysSize = Rays.Size,
    medalPos = Medal.Position,
    camoPos = Camo.Position,
    barTop = BarTop.Position,
    barBottom = BarBottom.Position
}
local FromScale = UDim2.fromScale
local Parent2 = Get:WaitForChild( "Starfield" )
local Star = Parent2:WaitForChild( "Star" )
Star.Visible = false
local Table3 = { }
local I = 1

for I = 1, 45 do
    local Clone = Star:Clone( )
    Clone.Name = "Star" .. I
    Clone.Visible = true
    Clone.ImageTransparency = 1
    Clone.Parent = Parent2
    table.insert( Table3, { img = Clone, phase = 0, speed = 1, base = 0.01 } )
end

local NumberValue = Instance.new( "NumberValue" )

local function PlaceStars()
    local Value1 = nil

    for Key, Value in Table3, nil, nil do
        Value.phase = math.random( ) * 3.141592653589793 * 2
        Value.speed = 0.8 + math.random( ) * 1.4
        Value.base = 0.006 + math.random( ) ^ 3 * 0.014
        local Img = Value.img
        Img.Position = FromScale( math.random( ), 0.1 + math.random( ) * 0.8 )
        Value.img.Rotation = 0
    end
end

local function Twinkle( Argument1 )
    local Value1
    local Clock = os.clock( )
    local Value = NumberValue.Value
    Value1 = nil

    for Key, Value2 in Table3, nil, nil do
        local Sin = math.sin( Clock * Value2.speed + Value2.phase ) * 0.5 + 0.5
        local Sin2 = Sin * Sin
        local Base = Value2.base * ( Sin2 * 0.35 + 0.75 )
        local Img = Value2.img
        Img.Size = FromScale( Base, Base )
        local Img2 = Value2.img
        Img2.ImageTransparency = 1 - math.min( 1, Value * ( Sin2 * 0.55 + 0.15 ) )
    end
end

local Parent3 = Instance.new( "Folder" )
Parent3.Name = "BetaRevealSounds"
Parent3.Parent = Parent

local function Sound( Text, Volume )
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. Text
    Sound.Volume = Volume
    Sound:SetAttribute( "BaseVolume", Volume )
    Sound.Parent = Parent3
    return Sound
end

local Sound2 = Instance.new( "Sound" )
Sound2.SoundId = "rbxassetid://" .. 9043343896
Sound2.Volume = 0.6
Sound2:SetAttribute( "BaseVolume", 0.6 )
Sound2.Parent = Parent3
local Sound3 = Instance.new( "Sound" )
Sound3.SoundId = "rbxassetid://" .. 109541594740226
Sound3.Volume = 0.42
Sound3:SetAttribute( "BaseVolume", 0.42 )
Sound3.Parent = Parent3
local Sound4 = Instance.new( "Sound" )
Sound4.SoundId = "rbxassetid://" .. 85953550219863
Sound4.Volume = 0.6
Sound4:SetAttribute( "BaseVolume", 0.6 )
Sound4.Parent = Parent3
local Sound5 = Instance.new( "Sound" )
Sound5.SoundId = "rbxassetid://" .. 85953550219863
Sound5.Volume = 0.9
Sound5:SetAttribute( "BaseVolume", 0.9 )
Sound5.Parent = Parent3
local Sound6 = Instance.new( "Sound" )
Sound6.SoundId = "rbxassetid://" .. 9126228631
Sound6.Volume = 0.45
Sound6:SetAttribute( "BaseVolume", 0.45 )
Sound6.Parent = Parent3
local Sound7 = Instance.new( "Sound" )
Sound7.SoundId = "rbxassetid://" .. 9126228631
Sound7.Volume = 0.6
Sound7:SetAttribute( "BaseVolume", 0.6 )
Sound7.Parent = Parent3
local Sound8 = Instance.new( "Sound" )
Sound8.SoundId = "rbxassetid://" .. 140736832198483
Sound8.Volume = 0.6
Sound8:SetAttribute( "BaseVolume", 0.6 )
Sound8.Parent = Parent3
local Sound9 = Instance.new( "Sound" )
Sound9.SoundId = "rbxassetid://" .. 9126009571
Sound9.Volume = 1.2
Sound9:SetAttribute( "BaseVolume", 1.2 )
Sound9.Parent = Parent3
local Table4 = {
    build = Sound2,
    boom = Sound3,
    sparkle = Sound4,
    sparkleSoft = Sound5,
    whoosh = Sound6,
    whooshTitle = Sound7,
    aura = Sound8,
    burst = Sound9
}
task.spawn( function()
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        table.insert( Table, Value )
    end

    pcall( ContentProvider.PreloadAsync, ContentProvider, Table )
end )

local function Play( Track )
    local Volume
    local BaseVolume = Track:GetAttribute( "BaseVolume" )
    Volume = if BaseVolume then BaseVolume else Track.Volume
    Track.Volume = Volume
    Track.TimePosition = 0
    Track:Play( )
end

local function Tween( Argument1, Argument2, Argument3, Argument4, Argument5, Amount )
    local Create = TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out, 0, false, Amount or 0 ), Argument3 )
    Create:Play( )
    return Create
end

local function TextAlpha( Object, Argument2, Argument3 )
    local Table = { TextTransparency = Argument2 }
    TweenService:Create( Object, TweenInfo.new( Argument3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
    local UIStroke = Object:FindFirstChildOfClass( "UIStroke" )

    if UIStroke then
        local Table2 = { Transparency = Argument2 }
        TweenService:Create( UIStroke, TweenInfo.new( Argument3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table2 ):Play( )
    end
end

local function CardShow( Argument1, Argument2 )
    local Disc = Argument1.Disc
    local Table = { GroupTransparency = 0 }
    TweenService:Create( Disc, TweenInfo.new( Argument2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
    local UIStroke = Argument1.Ring.UIStroke
    local Table2 = { Transparency = 0 }
    TweenService:Create( UIStroke, TweenInfo.new( Argument2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table2 ):Play( )
end

local function Pop( Object, Argument2, Amount )
    local Pop = Object:FindFirstChild( "Pop" )
    local Result = Amount * 0.65
    local Table = { Scale = Argument2 }
    TweenService:Create( Pop, TweenInfo.new( Result, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
    task.delay( Amount * 0.65, function()
        local Captured = Amount * 0.35
        local Table = { Scale = 1 }
        TweenService:Create( Pop, TweenInfo.new( Captured, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
    end )
end

local function Shine( Argument1 )
    local Shine = Argument1.Disc:FindFirstChild( "Shine" )

    if not Shine then
        return
    end

    Shine.Position = FromScale( -0.4, 0.5 )
    local Table = { Position = FromScale( 1.4, 0.5 ) }
    TweenService:Create( Shine, TweenInfo.new( 0.7, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.InOut or Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
end

local Number = 0

local function Burst( Position, List, Argument3 )
    local I = 1

    for I = 1, List do
        Number = Number % #Table + 1
        local Entry = Table[ Number ]
        local Random = math.random( ) * 3.141592653589793 * 2
        local Random2 = Argument3 * ( 0.6 + math.random( ) * 0.6 )
        local Random3 = 0.012 + math.random( ) * 0.016
        Entry.Position = Position
        Entry.Size = FromScale( Random3, Random3 )
        Entry.Rotation = 0
        Entry.ImageTransparency = 0.15
        local Total = Position + FromScale( math.cos( Random ) * Random2, math.sin( Random ) * Random2 * 16 / 9 )
        local Random4 = 0.7 + math.random( ) * 0.3
        local TableInner = { Position = Total, Size = FromScale( Random3 * 0.4, Random3 * 0.4 ) }
        TweenService:Create( Entry, TweenInfo.new( Random4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), TableInner ):Play( )
        local Table2 = { ImageTransparency = 1 }
        TweenService:Create( Entry, TweenInfo.new( 0.6, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out, 0, false, 0.15 ), Table2 ):Play( )
    end
end

local function FlashOnce( Argument1 )
    Flash.BackgroundTransparency = 1
    local Table = { BackgroundTransparency = Argument1 }
    TweenService:Create( Flash, TweenInfo.new( 0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
    task.delay( 0.08, function()
        local Table = { BackgroundTransparency = 1 }
        TweenService:Create( Flash, TweenInfo.new( 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
    end )
end

local function ResetUI()
    local Value1
    Tint.BackgroundTransparency = 1
    BarTop.Position = Table2.barTop - FromScale( 0, BarTop.Size.Y.Scale )
    BarBottom.Position = Table2.barBottom + FromScale( 0, BarBottom.Size.Y.Scale )
    Flash.BackgroundTransparency = 1
    Stage.GroupTransparency = 0
    local Size = FromScale( Table2.raysSize.X.Scale * 0.4, Table2.raysSize.Y.Scale * 0.4 )
    Rays.GroupTransparency = 1
    Rays.Size = Size
    Rays.Rotation = 0
    local Size2 = FromScale( Table2.glowSize.X.Scale * 0.4, Table2.glowSize.Y.Scale * 0.4 )
    Glow.BackgroundTransparency = 1
    Glow.Size = Size2
    local TableInner = { Medal, Camo }
    Value1 = nil

    for Key, Value in TableInner, nil, nil do
        Value.Pop.Scale = 0
        Value.Disc.GroupTransparency = 1
        Value.Ring.UIStroke.Transparency = 1
        Value.Label.TextTransparency = 1
        local UIStroke2 = Value.Label:FindFirstChildOfClass( "UIStroke" )

        if UIStroke2 then
            UIStroke2.Transparency = 1
        end

        Value.Rotation = 0
    end

    local Value2
    Medal.Position = FromScale( 0.5, Table2.medalPos.Y.Scale )
    Camo.Position = FromScale( 1.2, Table2.camoPos.Y.Scale )
    Camo.Rotation = 35
    Title.Pop.Scale = 0
    local Table2Inner = { Title, Forever, GiftFrom }
    Value2 = nil

    for Key2, Value3 in Table2Inner, nil, nil do
        Value3.TextTransparency = 1
        local UIStroke = Value3:FindFirstChildOfClass( "UIStroke" )

        if UIStroke then
            UIStroke.Transparency = 1
        end
    end

    local Value4 = nil

    for Key3, Value5 in Table, nil, nil do
        Value5.ImageTransparency = 1
    end

    local Value6
    NumberValue.Value = 0
    Value6 = nil

    for Key4, Value7 in Table3, nil, nil do
        Value7.img.ImageTransparency = 1
    end
end

ResetUI( )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
local Table5 = {
    root = nil,
    back = nil,
    t0 = 0,
    from = 0.35,
    to = 2.3415926535897933,
    side = 1
}

local function Clearance( Argument1, Argument2, Value )
    local Distance
    local Position = Argument1.Position + Vector3.new( 0, 1.2999999523162842, 0 )
    local VectorToWorldSpace = CFrame.Angles( 0, Value, 0 ):VectorToWorldSpace( Argument2 ) * 9 + Vector3.new( 0, 1.5, 0 )
    RaycastParams2.FilterDescendantsInstances = { LocalPlayer.Character, workspace:FindFirstChild( "FX" ) }
    local Spherecast = workspace:Spherecast( Position, 0.5, VectorToWorldSpace, RaycastParams2 )
    Distance = Spherecast and Spherecast.Distance or 9.5
    return Distance
end

local function PickSide( Root, Argument2 )
    local Value1, Value2, Value4
    local Table = { 2.3415926535897933, -2.3415926535897933, 1.9, -1.9, 0.7, -0.7 }
    Value1 = nil
    Value2 = nil
    Value4 = nil

    for Key, Value in Table, nil, nil do
        local Clearance2 = Clearance( Root, Argument2, Value )

        if Clearance2 >= 7 then
            return Value
        end
        if not Value4 or Value4 < Clearance2 then
            Value2 = Value
            Value4 = Clearance2
        end
    end

    return Value2
end

local function CamStep( Amount )
    local Root = Table5.root

    if not Root or not Root.Parent then
        return
    end

    local Max2
    local Clock = os.clock( ) - Table5.t0
    local Clamp = 1 - ( 1 - math.clamp( Clock / 3, 0, 1 ) ) ^ 3
    local From = Table5.from + ( Table5.to - Table5.from ) * Clamp + Table5.side * 0.08726646259971647 * Clock
    local Clamp2 = 11 - Clamp * 3.5
    local Position = Root.Position + Vector3.new( 0, 1.2999999523162842, 0 )
    local VectorToWorldSpace = CFrame.Angles( 0, From, 0 ):VectorToWorldSpace( Table5.back ) * Clamp2 + Vector3.new( 0, 2.6 - Clamp * 1.4, 0 )
    RaycastParams2.FilterDescendantsInstances = { LocalPlayer.Character, workspace:FindFirstChild( "FX" ) }
    local Spherecast = workspace:Spherecast( Position, 0.5, VectorToWorldSpace, RaycastParams2 )

    if Spherecast then
        local Max = math.max( Spherecast.Distance - 0.3, 1.5 )

        if Max then
            Max2 = Max
        else
            Max2 = VectorToWorldSpace.Magnitude
        end
    else
        Max2 = VectorToWorldSpace.Magnitude
    end

    ClientState.FixedCamera = CFrame.lookAt( Position + VectorToWorldSpace.Unit * Max2, Position + Vector3.new( 0, 2.5999999046325684, 0 ) )
    ClientState.FixedFOV = 62

    if not ClientState.CursorFree then
        ClientState.CursorFree = true
    end
    if not Controls.Locked then
        Controls.Locked = true
    end
    if not ClientState.AdminUIHidden then
        ClientState.AdminUIHidden = true
    end

    pcall( function()
        ProximityPromptService.Enabled = false
    end )
    Twinkle( Amount or 0.016666666666666666 )
end

local Number2 = 0
local Flag = false
local Flag2 = false
local Value1 = nil
local Table6 = { aura = true, burst = true, whooshTitle = true }

local function Finish( Argument1 )
    local FlagInner = Argument1 == true and true or false

    if not Flag then
        return
    end

    local Value1Inner
    Flag = false
    Number2 = Number2 + 1
    RunService:UnbindFromRenderStep( "BetaRevealCam" )
    ClientState.FixedCamera = nil
    ClientState.FixedFOV = nil
    ClientState.BetaReveal = nil
    ClientState.CursorFree = false
    Controls.Locked = Flag2
    ClientState.AdminUIHidden = Value1
    local Character = LocalPlayer.Character
    pcall( function()
        ProximityPromptService.Enabled = not ( Character and Character:GetAttribute( "Downed" ) )
    end )
    Value1Inner = nil

    for Key, Value in Table4, nil, nil do
        if not FlagInner or not Table6[ Key ] then
            Value:Stop( )
        end
    end

    Get.Visible = false
    ResetUI( )
end

local function Run( Text )
    if Flag then
        return
    end

    local Root
    local Character = LocalPlayer.Character

    if Character then
        Root = Character:FindFirstChild( "HumanoidRootPart" )
    else
        Root = Character
    end
    if not Root then
        return
    end

    local Value1Inner
    Flag = true
    Number2 = Number2 + 1

    local function At( Duration, Argument2 )
        task.delay( Duration, function()
            if Number2 == Number2 and Flag then
                Argument2( )
            end
        end )
    end

    local Table = { "Shop", "Settings", "Customization" }
    Value1Inner = nil

    for Key, Value in Table, nil, nil do
        local IconInner
        local GetIcon = Icon.getIcon

        if GetIcon then
            IconInner = Icon.getIcon( Value )
        else
            IconInner = GetIcon
        end
        if IconInner and IconInner.isSelected then
            IconInner:deselect( )
        end
    end

    local Back
    Flag2 = Controls.Locked
    Value1 = ClientState.AdminUIHidden
    Controls.Locked = true
    Controls.ReleaseAll( )
    ClientState.BetaReveal = true
    ClientState.CursorFree = true
    local LookVector = Root.CFrame.LookVector
    local X = LookVector.X
    local Vector32 = Vector3.new( X, 0, LookVector.Z )

    if Vector32.Magnitude > 0.01 then
        local Amount = -Vector32.Unit

        if Amount then
            Back = Amount
        else
            Back = Vector3.new( 0, 0, 1 )
        end
    else
        Back = Vector3.new( 0, 0, 1 )
    end

    local Side
    local T0 = os.clock( )
    Table5.root = Root
    Table5.back = Back
    Table5.t0 = T0
    Table5.to = PickSide( Root, Table5.back )
    Side = not ( Table5.to >= 0 ) and -1 or 1
    Table5.side = Side
    Table5.from = 0.35 * Table5.side
    RunService:BindToRenderStep( "BetaRevealCam", Enum.RenderPriority.Camera.Value - 1, CamStep )
    ResetUI( )
    PlaceStars( )
    Get.Visible = true
    local Table2Inner = { Value = 1 }
    TweenService:Create( NumberValue, TweenInfo.new( 1.4, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out or Enum.EasingDirection.Out, 0, false, 0.2 ), Table2Inner ):Play( )
    local Table3 = { BackgroundTransparency = Table2.tint }
    TweenService:Create( Tint, TweenInfo.new( 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table3 ):Play( )
    local Table4Inner = { Position = Table2.barTop }
    TweenService:Create( BarTop, TweenInfo.new( 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table4Inner ):Play( )
    local Table5Inner = { Position = Table2.barBottom }
    TweenService:Create( BarBottom, TweenInfo.new( 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table5Inner ):Play( )
    local Build = Table4.build
    Build.Volume = Table4.build:GetAttribute( "BaseVolume" )
    Table4.build.TimePosition = 0.87
    Table4.build:Play( )

    if type( Text ) == "string" and GiftFrom then
        GiftFrom.Text = string.gsub( GiftFrom2, "{name}", ( string.gsub( Text, "%%", "%%%%" ) ) )

        local function Callback()
            TextAlpha( GiftFrom, 0, 0.5 )
        end

        task.delay( 0.5, function()
            if Number2 == Number2 and Flag then
                Callback( )
            end
        end )
    end

    local function Callback2()
        local Volume
        FlashOnce( 0.25 )
        local Boom = Table4.boom
        local BaseVolume = Boom:GetAttribute( "BaseVolume" )
        Volume = if BaseVolume then BaseVolume else Boom.Volume
        local Volume2
        Boom.Volume = Volume
        Boom.TimePosition = 0
        Boom:Play( )
        local Sparkle = Table4.sparkle
        local BaseVolume2 = Sparkle:GetAttribute( "BaseVolume" )
        Volume2 = if BaseVolume2 then BaseVolume2 else Sparkle.Volume
        Sparkle.Volume = Volume2
        Sparkle.TimePosition = 0
        Sparkle:Play( )
        local Table = { BackgroundTransparency = Table2.glow, Size = Table2.glowSize }
        TweenService:Create( Glow, TweenInfo.new( 0.7, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
        CardShow( Medal, 0.3 )
        Pop( Medal, 1.18, 0.55 )
        Burst( Medal.Position, 10, 0.2 )
    end

    task.delay( 1.2, function()
        if Number2 == Number2 and Flag then
            Callback2( )
        end
    end )

    local function Callback3()
        TextAlpha( Medal.Label, 0, 0.35 )
    end

    task.delay( 1.6, function()
        if Number2 == Number2 and Flag then
            Callback3( )
        end
    end )

    local function Callback4()
        Shine( Medal )
    end

    task.delay( 2, function()
        if Number2 == Number2 and Flag then
            Callback4( )
        end
    end )

    local function Callback5()
        local Volume
        local Whoosh = Table4.whoosh
        local BaseVolume = Whoosh:GetAttribute( "BaseVolume" )
        Volume = if BaseVolume then BaseVolume else Whoosh.Volume
        Whoosh.Volume = Volume
        Whoosh.TimePosition = 0
        Whoosh:Play( )
        local Table = { Position = Table2.medalPos }
        TweenService:Create( Medal, TweenInfo.new( 0.6, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.InOut or Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
        local Table2Inner = {
            Size = FromScale( Table2.glowSize.X.Scale * 1.5, Table2.glowSize.Y.Scale * 1.5 )
        }
        TweenService:Create( Glow, TweenInfo.new( 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table2Inner ):Play( )
        Camo.Pop.Scale = 1
        CardShow( Camo, 0.35 )
        local Table3 = { Position = Table2.camoPos, Rotation = 0 }
        TweenService:Create( Camo, TweenInfo.new( 0.6, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table3 ):Play( )
    end

    task.delay( 3, function()
        if Number2 == Number2 and Flag then
            Callback5( )
        end
    end )

    local function Callback6()
        local Volume
        local SparkleSoft = Table4.sparkleSoft
        local BaseVolume = SparkleSoft:GetAttribute( "BaseVolume" )
        Volume = if BaseVolume then BaseVolume else SparkleSoft.Volume
        SparkleSoft.Volume = Volume
        SparkleSoft.TimePosition = 0
        SparkleSoft:Play( )
        Pop( Camo, 1.12, 0.4 )
        Burst( Table2.camoPos, 10, 0.2 )
        TextAlpha( Camo.Label, 0, 0.35 )
    end

    task.delay( 3.55, function()
        if Number2 == Number2 and Flag then
            Callback6( )
        end
    end )

    local function Callback7()
        Shine( Camo )
    end

    task.delay( 3.95, function()
        if Number2 == Number2 and Flag then
            Callback7( )
        end
    end )

    local function Callback8()
        local Volume
        local WhooshTitle = Table4.whooshTitle
        local BaseVolume = WhooshTitle:GetAttribute( "BaseVolume" )
        Volume = if BaseVolume then BaseVolume else WhooshTitle.Volume
        WhooshTitle.Volume = Volume
        WhooshTitle.TimePosition = 0
        WhooshTitle:Play( )
    end

    task.delay( 4.1, function()
        if Number2 == Number2 and Flag then
            Callback8( )
        end
    end )

    local function Callback9()
        local Volume
        FlashOnce( 0.7 )
        local BurstInner = Table4.burst
        local BaseVolume = BurstInner:GetAttribute( "BaseVolume" )
        Volume = if BaseVolume then BaseVolume else BurstInner.Volume
        local Volume2
        BurstInner.Volume = Volume
        BurstInner.TimePosition = 0
        BurstInner:Play( )
        local Aura = Table4.aura
        local BaseVolume2 = Aura:GetAttribute( "BaseVolume" )
        Volume2 = if BaseVolume2 then BaseVolume2 else Aura.Volume
        Aura.Volume = Volume2
        Aura.TimePosition = 0
        Aura:Play( )
        TextAlpha( Title, 0, 0.25 )
        Pop( Title, 1.15, 0.6 )
        Pop( Medal, 1.08, 0.4 )
        Pop( Camo, 1.08, 0.4 )
        Burst( Title.Position, 14, 0.35 )
    end

    task.delay( 4.7, function()
        if Number2 == Number2 and Flag then
            Callback9( )
        end
    end )

    local function Callback10()
        TextAlpha( Forever, 0, 0.4 )
    end

    task.delay( 5.3, function()
        if Number2 == Number2 and Flag then
            Callback10( )
        end
    end )

    local function Callback11()
        Shine( Medal )
        Shine( Camo )
    end

    task.delay( 5.8, function()
        if Number2 == Number2 and Flag then
            Callback11( )
        end
    end )

    local function Callback12()
        local Table = { GroupTransparency = 1 }
        TweenService:Create( Stage, TweenInfo.new( 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table ):Play( )
        local Table2Inner = { Value = 0 }
        TweenService:Create( NumberValue, TweenInfo.new( 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table2Inner ):Play( )
        local Table3 = { BackgroundTransparency = 1 }
        TweenService:Create( Tint, TweenInfo.new( 0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 ), Table3 ):Play( )
        local Table4 = { Position = Table2.barTop - FromScale( 0, BarTop.Size.Y.Scale ) }
        TweenService:Create( BarTop, TweenInfo.new( 0.7, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out, 0, false, 0 ), Table4 ):Play( )
        local Table5 = { Position = Table2.barBottom + FromScale( 0, BarBottom.Size.Y.Scale ) }
        TweenService:Create( BarBottom, TweenInfo.new( 0.7, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out, 0, false, 0 ), Table5 ):Play( )
    end

    task.delay( 7.6, function()
        if Number2 == Number2 and Flag then
            Callback12( )
        end
    end )

    local function Callback13()
        Finish( true )
    end

    task.delay( 8.6, function()
        if Number2 == Number2 and Flag then
            Callback13( )
        end
    end )
end

BetaRevealRemote.OnClientEvent:Connect( function( Name, Argument2, Text )
    if Name == "play" then
        Run( Text )
        return
    end
    if Name == "stop" then
        Finish( )
    end
end )
LocalPlayer.CharacterRemoving:Connect( Finish )
