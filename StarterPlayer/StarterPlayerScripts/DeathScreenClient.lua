-- StarterPlayer.StarterPlayerScripts.DeathScreenClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local Parent = game:GetService( "Lighting" )
local Parent2 = game:GetService( "SoundService" )
local KillMessages = require( ReplicatedStorage:WaitForChild( "KillMessages" ) )
local Killed = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Killed" )
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Table = { { id = 125502625456002, volume = 1 } }
local DeathScreen = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "DeathScreen", math.huge )
DeathScreen.Enabled = false
local Voile = DeathScreen:WaitForChild( "Voile" )
local Table2 = { }

for Key, Value in DeathScreen:WaitForChild( "Vignette" ):GetChildren( ) do
    if Value:IsA( "GuiObject" ) then
        table.insert( Table2, Value )
    end
end

local Bandeau = DeathScreen:WaitForChild( "Bandeau" )
local Table3 = { }

for Key2, Value2 in Bandeau:GetChildren( ) do
    if Value2:IsA( "GuiObject" ) and Value2.Name:sub( 1, 5 ) == "Liser" then
        table.insert( Table3, Value2 )
    end
end

local Value1
local Text = Bandeau:WaitForChild( "Text" )
local UIStroke = Text:FindFirstChildOfClass( "UIStroke" )
local UIScale = Text:FindFirstChildOfClass( "UIScale" )
local BackgroundTransparency = Voile.BackgroundTransparency
local Table4 = { }
Value1 = nil

for Key3, Value3 in Table2, nil, nil do
    Table4[ Value3 ] = Value3.BackgroundTransparency
end

local Transparency
local Scale = Bandeau.Size.Y.Scale
local TextTransparency = Text.TextTransparency
Transparency = UIStroke and UIStroke.Transparency or 0
local FromRGB

if Table3[ 1 ] then
    local BackgroundColor3 = Table3[ 1 ].BackgroundColor3

    if BackgroundColor3 then
        FromRGB = BackgroundColor3
    else
        FromRGB = Color3.fromRGB( 235, 45, 55 )
    end
else
    FromRGB = Color3.fromRGB( 235, 45, 55 )
end

local Value4
require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ScaleUI" ) ).Convert( DeathScreen )
local Themes = Bandeau:FindFirstChild( "Themes" )
local Table5 = { }
Value4 = nil

for Key4, Value5 in Table2, nil, nil do
    Table5[ Value5 ] = Value5.BackgroundColor3
end

local Value7
local Value6 = nil

local function ApplyTheme( Theme )
    if Value6 then
        Value6:Disconnect( )
        Value6 = nil
    end

    local Children2

    if Themes then
        local Children = Themes:GetChildren( )

        if Children then
            Children2 = Children
        else
            Children2 = { }
        end
    else
        Children2 = { }
    end

    local Value1, Value2
    Value1 = nil
    Value2 = nil

    for Key, Value in Children2, nil, nil do
        if Value:IsA( "GuiObject" ) then
            local Visible

            if Theme == nil then
                Visible = false
            elseif Value.Name == Theme then
                Visible = true
            else
                Visible = false
            end

            Value.Visible = Visible

            if Value.Visible then
                Value2 = Value
            end
        end
    end

    local VignetteColor

    if Value2 then
        VignetteColor = Value2:GetAttribute( "VignetteColor" )
    else
        VignetteColor = Value2
    end

    local Value3 = nil

    for Key2, Value4 in Table2, nil, nil do
        local BackgroundColor3 = if typeof( VignetteColor ) ~= "Color3" or not VignetteColor then Table5[ Value4 ] else VignetteColor
        Value4.BackgroundColor3 = BackgroundColor3
    end
    if not Value2 then
        return
    end
    if not ClientState.Spectating then
        for Key3, Value5 in Value2:GetDescendants( ) do
            if Value5:IsA( "Sound" ) then
                Value5.SoundGroup = Parent2:FindFirstChild( "DeathSound", true )
                Value5.TimePosition = 0
                Value5:Play( )
            end
        end
    end

    local Table = { }
    local Table2Inner = { }
    local Table3 = { }
    local Table4 = { }
    local Table5Inner = { }
    local Captured = Scale * DeathScreen.AbsoluteSize.Y

    for Key4, Value6Inner in Value2:GetDescendants( ) do
        if not Value6Inner:IsA( "GuiObject" ) or Value6Inner.Name:sub( 1, 10 ) ~= "Citrouille" then
            if not Value6Inner:IsA( "GuiObject" ) or Value6Inner.Name:sub( 1, 6 ) ~= "Vortex" then
                if not Value6Inner:IsA( "UIGradient" ) or not Value6Inner.Parent or Value6Inner.Parent.Name ~= "Lueur" then
                    if not Value6Inner:IsA( "GuiObject" ) or Value6Inner.Name:sub( 1, 5 ) ~= "Bulle" then
                        if Value6Inner:IsA( "GuiObject" ) and Value6Inner.Name:sub( 1, 4 ) == "Code" then
                            local Table7 = { }

                            for Key5, Value7 in Value6Inner:GetChildren( ) do
                                if Value7:IsA( "ImageLabel" ) then
                                    table.insert( Table7, Value7 )
                                end
                            end
                            if #Table7 >= 2 then
                                local Value8
                                local ScaleInner = Table7[ 1 ].Size.Y.Scale
                                local Number = tonumber( Value6Inner:GetAttribute( "TileRatio" ) ) or 0.25
                                Value8 = nil

                                for Key6, Value9 in Table7, nil, nil do
                                    Value9.TileSize = UDim2.new( 0, math.max( 8, Captured * ScaleInner * Number ), 1, 0 )
                                end

                                table.insert( Table4, {
                                    a = Table7[ 1 ],
                                    b = Table7[ 2 ],
                                    h = ScaleInner,
                                    speed = tonumber( Value6Inner:GetAttribute( "Speed" ) ) or 0.15
                                } )
                            end
                        end
                    else
                        if Value6Inner:GetAttribute( "BasePos" ) == nil then
                            Value6Inner:SetAttribute( "BasePos", Value6Inner.Position )
                        end

                        table.insert( Table5Inner, {
                            o = Value6Inner,
                            base = Value6Inner:GetAttribute( "BasePos" ),
                            rise = tonumber( Value6Inner:GetAttribute( "Rise" ) ) or 0,
                            phase = #Table5Inner * 1.37
                        } )
                    end
                else
                    table.insert( Table2Inner, Value6Inner )
                end
            else
                if Value6Inner:GetAttribute( "RotationBase" ) == nil then
                    Value6Inner:SetAttribute( "RotationBase", Value6Inner.Rotation )
                end

                local Dir
                local Table6 = { o = Value6Inner, base = Value6Inner:GetAttribute( "RotationBase" ) }
                Dir = #Table3 % 2 ~= 0 and -1 or 1
                Table6.dir = Dir
                table.insert( Table3, Table6 )
            end
        else
            if Value6Inner:GetAttribute( "RotationBase" ) == nil then
                Value6Inner:SetAttribute( "RotationBase", Value6Inner.Rotation )
            end

            table.insert( Table, {
                o = Value6Inner,
                base = Value6Inner:GetAttribute( "RotationBase" ),
                phase = #Table * 1.7
            } )
        end
    end

    local Clock = os.clock( )
    Value6 = RunService.RenderStepped:Connect( function()
        local Value1
        local ClockInner = os.clock( ) - Clock
        Value1 = nil

        for Key, Value in Table, nil, nil do
            local O5 = Value.o
            O5.Rotation = Value.base + math.sin( ClockInner * 2.6 + Value.phase ) * 9
        end

        local Value2 = nil

        for Key2, Value3 in Table3, nil, nil do
            local O4 = Value3.o
            O4.Rotation = Value3.base + Value3.dir * math.sin( ClockInner * 1.5 ) * 14
        end

        local Value4 = nil

        for Key3, Value5 in Table2Inner, nil, nil do
            Value5.Offset = Vector2.new( math.sin( ClockInner * 1.3 ) * 0.12, 0 )
        end

        local Value6 = nil

        for Key4, Value7 in Table5Inner, nil, nil do
            if Value7.rise > 0 then
                local Clock3 = ( ClockInner * Value7.rise + Value7.phase * 0.29 ) % 1
                local O = Value7.o
                local Scale = Value7.base.X.Scale + math.sin( ClockInner * 2.3 + Value7.phase ) * 0.004
                local Offset = Value7.base.X.Offset
                O.Position = UDim2.new( Scale, Offset, 1.3 - Clock3 * 1.6, 0 )
            else
                local O2 = Value7.o
                O2.Position = UDim2.new( Value7.base.X.Scale, Value7.base.X.Offset, Value7.base.Y.Scale + math.sin( ClockInner * 1.7 + Value7.phase ) * 0.06, Value7.base.Y.Offset )
                local O3 = Value7.o
                O3.Rotation = math.sin( ClockInner * 1.1 + Value7.phase ) * 6
            end
        end

        local Value8 = nil

        for Key5, Value9 in Table4, nil, nil do
            local Clock2 = ClockInner * Value9.speed % 1 * Value9.h
            local A = Value9.a
            A.Position = UDim2.fromScale( Value9.a.Position.X.Scale, Clock2 )
            local B = Value9.b
            B.Position = UDim2.fromScale( Value9.b.Position.X.Scale, Clock2 - Value9.h )
        end
    end )
end

local Effets = DeathScreen:WaitForChild( "Effets" )
local Clone = Effets:WaitForChild( "DeathScreenCC" ):Clone( )
local Clone2 = Effets:WaitForChild( "DeathScreenBlur" ):Clone( )
local Table6 = {
    Saturation = Clone.Saturation,
    Contrast = Clone.Contrast,
    Brightness = Clone.Brightness
}
local Size = Clone2.Size
Clone.Enabled = false
Clone2.Enabled = false
Clone.Saturation = 0
Clone.Contrast = 0
Clone.Brightness = 0
Clone2.Size = 0
Clone.Parent = Parent
Clone2.Parent = Parent
local Table7 = { }
local Parent3 = Instance.new( "SoundGroup" )
Parent3.Name = "DeathSound"
Parent3.Volume = 1
Parent3.Parent = Parent2
local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
EqualizerSoundEffect.LowGain = 0
EqualizerSoundEffect.MidGain = 0
EqualizerSoundEffect.HighGain = 0
EqualizerSoundEffect.Parent = Parent3
Value7 = nil

for Key5, Value8 in Table, nil, nil do
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. Value8.id
    Sound.Volume = Value8.volume
    Sound.SoundGroup = Parent3
    Sound.Parent = Parent3
    table.insert( Table7, Sound )
end

local Descendants2
local Clone3 = table.clone( Table7 )

if Bandeau:FindFirstChild( "Themes" ) then
    local Descendants = Bandeau.Themes:GetDescendants( )

    if Descendants then
        Descendants2 = Descendants
    else
        Descendants2 = { }
    end
else
    Descendants2 = { }
end

local Value9 = nil

for Key6, Value10 in Descendants2, nil, nil do
    if Value10:IsA( "Sound" ) then
        table.insert( Clone3, Value10 )
    end
end

local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
task.spawn( pcall, PreloadAsync, game:GetService( "ContentProvider" ), Clone3 )
local Number = 0
local Flag = false
local Flag2 = false
local Table8 = { }

local function Tween( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Create = TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out ), Argument3 )
    table.insert( Table8, Create )
    Create:Play( )
    return Create
end

local function StopTweens()
    local Value1 = nil

    for Key, Value in Table8, nil, nil do
        Value:Cancel( )
    end

    table.clear( Table8 )
end

local function ResetLook()
    local Value1
    Voile.BackgroundTransparency = 1
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        Value.BackgroundTransparency = 1
    end

    Bandeau.Size = UDim2.fromScale( 1, 0 )
    Text.TextTransparency = 1

    if UIStroke then
        UIStroke.Transparency = 1
    end
end

local function HideForSpec()
    local Value1
    DeathScreen.Enabled = false
    Clone.Enabled = false
    Clone2.Enabled = false
    Value1 = nil

    for Key, Value in Table7, nil, nil do
        Value:Stop( )
    end

    local Descendants2

    if Themes then
        local Descendants = Themes:GetDescendants( )

        if Descendants then
            Descendants2 = Descendants
        else
            Descendants2 = { }
        end
    else
        Descendants2 = { }
    end

    local Value2 = nil

    for Key2, Value3 in Descendants2, nil, nil do
        if Value3:IsA( "Sound" ) then
            Value3:Stop( )
        end
    end
end

local function Begin()
    if Flag then
        return
    end

    local Value1
    Flag = true
    Flag2 = false
    Number = Number + 1
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        Value:Cancel( )
    end

    local Value2
    table.clear( Table8 )
    DeathScreen.Enabled = true
    Voile.BackgroundTransparency = 1
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        Value3.BackgroundTransparency = 1
    end

    Bandeau.Size = UDim2.fromScale( 1, 0 )
    Text.TextTransparency = 1

    if UIStroke then
        UIStroke.Transparency = 1
    end

    local Value4
    Text.Text = ""
    ApplyTheme( nil )
    local Table = { BackgroundTransparency = BackgroundTransparency }
    local Create = TweenService:Create( Voile, TweenInfo.new( 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table )
    table.insert( Table8, Create )
    Create:Play( )
    Value4 = nil

    for Key3, Value5 in Table2, nil, nil do
        local Table3 = { BackgroundTransparency = Table4[ Value5 ] }
        local Create4 = TweenService:Create( Value5, TweenInfo.new( 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table3 )
        table.insert( Table8, Create4 )
        Create4:Play( )
    end

    Clone.Enabled = true
    Clone2.Enabled = true
    Clone.Saturation = 0
    Clone.Contrast = 0
    Clone.Brightness = 0
    Clone2.Size = 0
    local Create2 = TweenService:Create( Clone, TweenInfo.new( 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table6 )
    table.insert( Table8, Create2 )
    Create2:Play( )
    local Table2Inner = { Size = Size }
    local Create3 = TweenService:Create( Clone2, TweenInfo.new( 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2Inner )
    table.insert( Table8, Create3 )
    Create3:Play( )

    if ClientState.Spectating then
        HideForSpec( )
        return
    end

    local Value6 = nil

    for Key4, Value7 in Table7, nil, nil do
        Value7.TimePosition = 0
        Value7:Play( )
    end
end

local function ShowMessage( Message )
    local BackgroundColor3 = if not ( Message and KillMessages.ById[ Message.Msg or "" ] ) or ( Message and KillMessages.ById[ Message.Msg or "" ] ).id == KillMessages.DEFAULT then FromRGB else ( Message and KillMessages.ById[ Message.Msg or "" ] ).color
    local Value1 = nil

    for Key, Value in Table3, nil, nil do
        Value.BackgroundColor3 = BackgroundColor3
    end

    local Theme = Message and KillMessages.ById[ Message.Msg or "" ] and ( Message and KillMessages.ById[ Message.Msg or "" ] ).theme or nil
    ApplyTheme( Theme )
    local Format = KillMessages.Format
    Text.Text = Format( Message and Message.Msg, Message and Message.Name, KillMessages.LocalLang( ), function( Argument1 )
        return ( "<font color=\"#%s\">%s</font>" ):format( BackgroundColor3:ToHex( ), KillMessages.Escape( Argument1 ) )
    end )
    task.delay( 0.25, function()
        if Number ~= Number then
            return
        end

        local Table = { Size = UDim2.fromScale( 1, Scale ) }
        local Create = TweenService:Create( Bandeau, TweenInfo.new( 0.35, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table )
        table.insert( Table8, Create )
        Create:Play( )

        if UIScale then
            UIScale.Scale = 1.3
            local Table2 = { Scale = 1 }
            local Create2 = TweenService:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 )
            table.insert( Table8, Create2 )
            Create2:Play( )
        end

        local Table3 = { TextTransparency = TextTransparency }
        local Create3 = TweenService:Create( Text, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table3 )
        table.insert( Table8, Create3 )
        Create3:Play( )

        if UIStroke then
            local Table4 = { Transparency = Transparency }
            local Create4 = TweenService:Create( UIStroke, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table4 )
            table.insert( Table8, Create4 )
            Create4:Play( )
        end
    end )
end

local function Finish()
    Flag = false
    Number = Number + 1

    if DeathScreen.Enabled then
        local Value4 = nil

        for Key3, Value5 in Table8, nil, nil do
            Value5:Cancel( )
        end

        local Value6
        table.clear( Table8 )
        Flag2 = true
        local Table = { BackgroundTransparency = 1 }
        local Create = TweenService:Create( Voile, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table )
        table.insert( Table8, Create )
        Create:Play( )
        Value6 = nil

        for Key4, Value7 in Table2, nil, nil do
            local Table6 = { BackgroundTransparency = 1 }
            local Create6 = TweenService:Create( Value7, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table6 )
            table.insert( Table8, Create6 )
            Create6:Play( )
        end

        local Table2Inner = { Size = UDim2.fromScale( 1, 0 ) }
        local Create2 = TweenService:Create( Bandeau, TweenInfo.new( 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2Inner )
        table.insert( Table8, Create2 )
        Create2:Play( )
        local Table3 = { TextTransparency = 1 }
        local Create3 = TweenService:Create( Text, TweenInfo.new( 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table3 )
        table.insert( Table8, Create3 )
        Create3:Play( )
        local Table4 = { Saturation = 0, Contrast = 0, Brightness = 0 }
        local Create4 = TweenService:Create( Clone, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table4 )
        table.insert( Table8, Create4 )
        Create4:Play( )
        local Table5 = { Size = 0 }
        local Create5 = TweenService:Create( Clone2, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table5 )
        table.insert( Table8, Create5 )
        Create5:Play( )
        task.delay( 0.32, function()
            if Number == Number then
                DeathScreen.Enabled = false
                Flag2 = false
                ApplyTheme( nil )
                Clone.Enabled = false
                Clone2.Enabled = false
                return
            end
            return
        end )
        return
    end
    local Value1 = nil

    for Key, Value in Table8, nil, nil do
        Value:Cancel( )
    end

    local Value2
    table.clear( Table8 )
    Voile.BackgroundTransparency = 1
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        Value3.BackgroundTransparency = 1
    end

    Bandeau.Size = UDim2.fromScale( 1, 0 )
    Text.TextTransparency = 1

    if UIStroke then
        UIStroke.Transparency = 1
    end

    ApplyTheme( nil )
    Flag2 = false
    Clone.Enabled = false
    Clone2.Enabled = false
    Clone.Saturation = 0
    Clone.Contrast = 0
    Clone.Brightness = 0
    Clone2.Size = 0
    return
end

Killed.OnClientEvent:Connect( function( Argument1, Argument2, Message )
    Begin( )
    ShowMessage( Message )
end )

local function OnCharacter( Object )
    Finish( )
    local Humanoid = Object:WaitForChild( "Humanoid", 10 )

    if Humanoid then
        Humanoid.Died:Connect( function()
            if LocalPlayer.Character == Object then
                Begin( )
            end
        end )
    end
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end

local Flag3 = false
RunService.RenderStepped:Connect( function()
    if DeathScreen.Enabled and not Flag and not Flag2 and not ClientState.Spectating then
        local Value1 = nil

        for Key, Value in Table8, nil, nil do
            Value:Cancel( )
        end

        local Value2
        table.clear( Table8 )
        Voile.BackgroundTransparency = 1
        Value2 = nil

        for Key2, Value3 in Table2, nil, nil do
            Value3.BackgroundTransparency = 1
        end

        Bandeau.Size = UDim2.fromScale( 1, 0 )
        Text.TextTransparency = 1

        if UIStroke then
            UIStroke.Transparency = 1
        end

        DeathScreen.Enabled = false
        Clone.Enabled = false
        Clone2.Enabled = false
        Clone.Saturation = 0
        Clone.Contrast = 0
        Clone.Brightness = 0
        Clone2.Size = 0
    end
    if not Flag and not DeathScreen.Enabled then
        if Clone.Enabled or Clone2.Enabled then
            local Humanoid
            local Character = LocalPlayer.Character

            if Character then
                Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if Humanoid and Humanoid.Health > 0 then
                local Value4 = nil

                for Key3, Value5 in Table8, nil, nil do
                    Value5:Cancel( )
                end

                table.clear( Table8 )
                Clone.Enabled = false
                Clone2.Enabled = false
                Clone.Saturation = 0
                Clone.Contrast = 0
                Clone.Brightness = 0
                Clone2.Size = 0
            end
        end
    end
    if ClientState.Spectating then
        Flag3 = true

        if DeathScreen.Enabled or Clone.Enabled or Clone2.Enabled then
            HideForSpec( )
            return
        end
    elseif Flag3 then
        Flag3 = false

        if Flag then
            DeathScreen.Enabled = true
            Clone.Enabled = true
            Clone2.Enabled = true
        end
    end
end )
