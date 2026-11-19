-- Players.perkbrokeyou.PlayerScripts.G36EventClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Storage = { }
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local G36EventQuest = ReplicatedStorage:WaitForChild( "G36EventQuest", math.huge )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Menu = PlayerGui:WaitForChild( "G36Event", math.huge ):WaitForChild( "Menu" )
Menu.Visible = false
local Window = Menu:WaitForChild( "Window" )
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
local Close = Window:WaitForChild( "Close" )
local Countdown = Window:WaitForChild( "Countdown" )
Countdown.Text = ""
local HUDButtons = PlayerGui:WaitForChild( "HUDButtons", math.huge )
local G36EventButton = HUDButtons:WaitForChild( "Frame" ):WaitForChild( "Btns" ):WaitForChild( "G36EventButton", 30 )
Storage.G36EventButton2 = if G36EventButton then G36EventButton:FindFirstChild( "Count" ) else G36EventButton
local Table = { }

for Key, Value in Window:WaitForChild( "Tiers" ):GetChildren( ) do
    local Number6 = tonumber( Value.Name:match( "^Tier(%d+)$" ) )

    if Number6 then
        local Table17
        local Stroke = Value:FindFirstChildOfClass( "UIStroke" )
        local Steps3 = Value:FindFirstChild( "Steps" )

        if Steps3 then
            local Table15 = { }

            for Key10, Value22 in Steps3:GetChildren( ) do
                local Number7 = tonumber( Value22.Name:match( "^Step(%d+)$" ) )

                if Number7 then
                    Table15[ Number7 ] = Value22
                end

                Table17 = Table15
            end

            Table17 = Table15
        else
            Table17 = nil
        end

        local Icon2
        local Reveal = Value:FindFirstChild( "Reveal" )

        if not Reveal or not Reveal:FindFirstChild( "Icon" ) then
            Icon2 = Value:WaitForChild( "Icon" )
        else
            Icon2 = Reveal:FindFirstChild( "Icon" )
        end

        local RevealSize
        local Table16 = {
            frame = Value,
            steps = Table17,
            lock = Value:WaitForChild( "Lock" ),
            icon = Icon2,
            claim = Value:WaitForChild( "Action" ):WaitForChild( "Claim" ),
            reveal = Reveal
        }
        RevealSize = if Reveal then Reveal.Size else Reveal
        local Edge
        Table16.revealSize = RevealSize
        Edge = if Reveal then Reveal:FindFirstChild( "Edge" ) else Reveal
        local Color2
        Table16.edge = Edge
        local Color = Value:GetAttribute( "Color" )
        Color2 = if Color then Color else Color3.fromRGB( 255, 205, 60 )
        local StrokeBase2
        Table16.color = Color2
        Table16.veil = Value:FindFirstChild( "Veil" )
        Table16.stroke = Stroke
        StrokeBase2 = if Stroke then { Stroke.Color, Stroke.Thickness, Stroke.Transparency } else Stroke
        local StepBase2
        Table16.strokeBase = StrokeBase2
        StepBase2 = Steps3 and Steps3:GetAttribute( "StepBase" ) or 0
        local GlowSize
        Table16.stepBase = tonumber( StepBase2 ) or 0
        Table16.tint = Value:FindFirstChild( "Tint" )
        Table16.nameLabel = Value:FindFirstChild( "RewardName" )
        Table[ Number6 ] = Table16
        local Entry2 = Table[ Number6 ]
        Entry2.glow = Value:FindFirstChild( "Glow" )
        local Glow = Entry2.glow
        GlowSize = if Glow then Entry2.glow.Size else Glow
        local GlowT
        Entry2.glowSize = GlowSize
        local Glow2 = Entry2.glow
        GlowT = if Glow2 then Entry2.glow.ImageTransparency else Glow2
        Entry2.glowT = GlowT
        local Shine = Value:FindFirstChild( "Shine" )
        Storage.Shine2 = if Shine then Shine:FindFirstChildOfClass( "UIGradient" ) else Shine
        Entry2.shine = Storage.Shine2
        Entry2.float = { }
        Storage.Table18 = { "Icon", "IconShadow", "Mystery", "Silhouette", "Reveal" }
        Storage.Value23 = nil

        for Key11, Value24 in Storage.Table18, nil, nil do
            Storage.FoundChild = Value:FindFirstChild( Value24 )

            if Storage.FoundChild then
                Storage.Float = Entry2.float
                table.insert( Storage.Float, { Storage.FoundChild, Storage.FoundChild.Position } )
            end
        end
    end
end

local Table2 = { }

for Key2, Value2 in Window:WaitForChild( "Quests" ):GetChildren( ) do
    local Match = Value2.Name:match( "^Quest_(.+)$" )

    if Match then
        local Bar = Value2:WaitForChild( "Progress" ):WaitForChild( "Bar" )
        local Clip = Bar:WaitForChild( "Clip" )
        local UIStroke = Value2:FindFirstChildOfClass( "UIStroke" )
        local Pointe = Bar:FindFirstChild( "Pointe" )

        if Pointe then
            Pointe.Visible = false
        end

        local StrokeBase
        local Table14 = {
            frame = Value2,
            value = Bar:WaitForChild( "Value" ),
            hint = Value2:WaitForChild( "Hint" ),
            hintText = Value2.Hint.Text,
            hintColor = Value2.Hint.TextColor3,
            accent = Value2:FindFirstChild( "Accent" ),
            bar = Bar,
            track = Bar:FindFirstChildOfClass( "UIGradient" ),
            clip = Clip,
            fill = Clip:WaitForChild( "Fill" ),
            stroke = UIStroke
        }
        StrokeBase = if UIStroke then { UIStroke.Color, UIStroke.Transparency } else UIStroke
        Table14.strokeBase = StrokeBase
        Table14.title = Value2.Title.Text
        Table14.icon = Value2.Icon.Image
        Table14.iconColor = Value2.Icon.ImageColor3
        Table2[ Match ] = Table14
        local Entry = Table2[ Match ]
        Entry.fillGrad = Table2[ Match ].fill:FindFirstChildOfClass( "UIGradient" )
    end
end

local Phase1
local QuestsTitle = Window:WaitForChild( "QuestsTitle" )
local RewardsTitle = Window:WaitForChild( "RewardsTitle" )
local PhaseTabs = Window:FindFirstChild( "PhaseTabs" )

if PhaseTabs then
    Phase1 = PhaseTabs:FindFirstChild( "Phase1" )
else
    Phase1 = PhaseTabs
end

local Phase2

if PhaseTabs then
    Phase2 = PhaseTabs:FindFirstChild( "Phase2" )
else
    Phase2 = PhaseTabs
end

local PhaseTabs2 = if Phase2 then Phase2:FindFirstChild( "Lock" ) else Phase2
local Value1, Number5
local Footer = Window.Quests:FindFirstChild( "Footer" )
Value1 = nil
Number5 = 0

for Value3 in Table2, nil, nil do
    Number5 = Number5 + 1
end

local UIAspectRatioConstraint2
local GuiService = game:GetService( "GuiService" )
local UserInputService = game:GetService( "UserInputService" )
local Size = Window.Size
local Position = Window.Position
local UIAspectRatioConstraint = Window:FindFirstChildOfClass( "UIAspectRatioConstraint" )
UIAspectRatioConstraint2 = if UIAspectRatioConstraint then UIAspectRatioConstraint.AspectRatio else UIAspectRatioConstraint
local Table3 = { pc = 1, tablet = 1, tv = 1.15 }
local Table4 = { }

for Key3, Value4 in Window:GetDescendants( ) do
    if Value4:IsA( "GuiObject" ) then
        if Value4:GetAttribute( "PhonePosition" ) or Value4:GetAttribute( "PhoneSize" ) then
            Table4[ Value4 ] = { Value4.Position, Value4.Size }
        end
    end
end

local Text = "pc"

local function ApplyType()
    local Y = Window.AbsoluteSize.Y

    if Y <= 0 then
        return
    end

    local Clamp2

    if Text == "phone" then
        local Clamp = math.clamp( 400 / Y, 1, 1.55 )

        if Clamp then
            Clamp2 = Clamp
        else
            local Entry = Table3[ Text ]

            if Entry then
                Clamp2 = Entry
            else
                Clamp2 = 1
            end
        end
    else
        local Entry = Table3[ Text ]

        if Entry then
            Clamp2 = Entry
        else
            Clamp2 = 1
        end
    end
    for Key, Value in Window:GetDescendants( ) do
        local TextH = Value:GetAttribute( "TextH" )

        if TextH then
            local TextH2 = if Text == "phone" then Value:GetAttribute( "PhoneTextH" ) or TextH else TextH
            local TypeSize2
            local TypeSize = Value:FindFirstChild( "TypeSize" )

            if TypeSize then
                TypeSize2 = TypeSize
            else
                Value:SetAttribute( "OffsetOK", true )
                local UITextSizeConstraint = Instance.new( "UITextSizeConstraint" )
                UITextSizeConstraint.Name = "TypeSize"
                UITextSizeConstraint.Parent = Value
                TypeSize2 = UITextSizeConstraint
            end

            TypeSize2.MaxTextSize = math.max( 1, ( math.floor( Y * TextH2 * Clamp2 + 0.5 ) ) )
        end
    end
end

local function Fit()
    local Vector22
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera or not CurrentCamera.ViewportSize then
        Vector22 = Vector2.new( 1920, 1080 )
    else
        Vector22 = CurrentCamera.ViewportSize
    end

    local TouchEnabled2
    local TouchEnabled = UserInputService.TouchEnabled
    TouchEnabled2 = if TouchEnabled then not UserInputService.MouseEnabled else TouchEnabled
    local TextInner

    if Vector22.Y < 600 then
        TextInner = "phone"
    elseif GuiService:IsTenFootInterface( ) then
        TextInner = "tv"
    elseif TouchEnabled2 then
        TextInner = "tablet"
    else
        TextInner = "pc"
    end

    Text = TextInner

    if Text == "pc" then
        Window.Size = Size
        Window.Position = Position
    else
        local Max
        local Clamp = math.clamp( GuiService.TopbarInset.Max.Y / math.max( Vector22.Y, 1 ), 0, 0.2 ) + 0.012

        if Text == "tv" then
            Max = math.max( Clamp, 0.17 )
        else
            Max = Clamp
        end

        local Number
        local Clamp2 = 1 - Max - 0.02

        if Text == "phone" then
            Number = 0.98
        elseif Text == "tv" then
            Number = 0.68
        else
            Number = 0.94
        end

        Window.Size = UDim2.fromScale( Number, Clamp2 )
        Window.Position = UDim2.fromScale( 0.5, Max + Clamp2 / 2 )

        if UIAspectRatioConstraint then
            local AspectRatio

            if Text == "phone" then
                local PhoneAspect2
                local Number2 = Number * Vector22.X / ( Clamp2 * Vector22.Y )
                local PhoneAspect = UIAspectRatioConstraint:GetAttribute( "PhoneAspect" )
                PhoneAspect2 = if PhoneAspect then PhoneAspect else UIAspectRatioConstraint2
                local Clamp3 = math.clamp( Number2, UIAspectRatioConstraint2, PhoneAspect2 )

                if Clamp3 then
                    AspectRatio = Clamp3
                else
                    AspectRatio = UIAspectRatioConstraint2
                end
            else
                AspectRatio = UIAspectRatioConstraint2
            end

            UIAspectRatioConstraint.AspectRatio = AspectRatio
        end
    end
    if Text == "pc" and UIAspectRatioConstraint then
        UIAspectRatioConstraint.AspectRatio = UIAspectRatioConstraint2
    end
    if Text ~= Text or Text == "pc" then
        local Flag = Text == "phone" and true or false
        local Value1 = nil

        for Key, Value in Table4, nil, nil do
            local PositionInner = Flag and Key:GetAttribute( "PhonePosition" ) or Value[ 1 ]
            local SizeInner
            Key.Position = PositionInner
            SizeInner = Flag and Key:GetAttribute( "PhoneSize" ) or Value[ 2 ]
            Key.Size = SizeInner
        end
    end

    task.defer( ApplyType )
end

GuiService:GetPropertyChangedSignal( "TopbarInset" ):Connect( Fit )
local Connect = nil

local function WatchCam()
    if Connect then
        Connect:Disconnect( )
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        Connect = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
    end

    Fit( )
end

workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( WatchCam )

if Connect then
    Connect:Disconnect( )
end

local CurrentCamera = workspace.CurrentCamera

if CurrentCamera then
    Connect = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
end

local Value5
Fit( )
Window:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( ApplyType )
task.defer( ApplyType )
local Table5 = { Window:WaitForChild( "RewardsTitle" ), QuestsTitle }
Value5 = nil

for Key4, Value6 in Table5, nil, nil do
    local Line = Value6:FindFirstChild( "Line" )

    if Line then
        local Scale = Line.Position.X.Scale + Line.Size.X.Scale

        local function PlaceLine()
            local X = Value6.AbsoluteSize.X

            if X <= 0 then
                return
            end
            local X2 = ( Value6.TextBounds.X + Value6.TextBounds.Y * 0.6 ) / X
            local Min = math.min( X2, Scale - 0.05 )
            Line.Position = UDim2.new( Min, 0, Line.Position.Y.Scale, 0 )
            local Captured = Scale - Min
            Line.Size = UDim2.new( Captured, 0, Line.Size.Y.Scale, 0 )
            return
        end

        Value6:GetPropertyChangedSignal( "TextBounds" ):Connect( PlaceLine )
        Value6:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( PlaceLine )
        task.defer( PlaceLine )
    end
end

local Value11
local Value7 = nil

local function Cfg()
    return Value7 and Value7.cfg
end

local function Values()
    local N2
    local Table = { }

    if not Value7 or type( Value7.n ) ~= "table" then
        N2 = { }
    else
        local N = Value7.n

        if N then
            N2 = N
        else
            N2 = { }
        end
    end

    local Value1 = nil

    for Key, Value in N2, nil, nil do
        Table[ Key ] = tonumber( Value ) or 0
    end

    return Table
end

local function TierCfg( CfgName )
    local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ CfgName ] else Value7 and Value7.cfg
    return Captured
end

local function Claimed( Argument1 )
    local Captured

    if Value7 then
        if type( Value7.c ) == "table" then
            if Value7.c[ tostring( Argument1 ) ] == true then
                Captured = true
            else
                Captured = false
            end
        else
            Captured = false
        end
    else
        Captured = Value7
    end

    return Captured
end

local function Prog( Argument1, Key, List )
    local Number2
    local Entry = List[ Key ] or 0

    if type( Argument1.base ) == "table" then
        local Number = tonumber( Argument1.base[ Key ] )

        if Number then
            Number2 = Number
        else
            Number2 = 0
        end
    else
        Number2 = 0
    end

    local Entry2 = Entry - Number2
    return ( math.clamp( Entry2, 0, Argument1.goals[ Key ] or 0 ) )
end

local function Reached( Key, List )
    local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key ] else Value7 and Value7.cfg

    if not Captured then
        return false
    end

    local Value1
    local Goals = Captured.goals
    Value1 = nil

    for Key2, Value in Goals, nil, nil do
        local Number2
        local Entry = List[ Key2 ] or 0

        if type( Captured.base ) == "table" then
            local Number = tonumber( Captured.base[ Key2 ] )

            if Number then
                Number2 = Number
            else
                Number2 = 0
            end
        else
            Number2 = 0
        end

        local Entry2 = Entry - Number2

        if math.clamp( Entry2, 0, Captured.goals[ Key2 ] or 0 ) < Value then
            return false
        end
    end

    return true
end

local function Done( Key2, List )
    local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key2 ] else Value7 and Value7.cfg

    if not Captured then
        return false
    end
    if Captured.step then
        return ( Reached( Key2, List or Values( ) ) )
    end
    local Captured2

    if Value7 then
        if type( Value7.c ) == "table" then
            if Value7.c[ tostring( Key2 ) ] == true then
                Captured2 = true
            else
                Captured2 = false
            end
        else
            Captured2 = false
        end
    else
        Captured2 = Value7
    end

    return Captured2
end

local function ActiveTier( List )
    local Tiers2

    if Value7 and Value7.cfg then
        local Tiers = ( Value7 and Value7.cfg ).tiers

        if Tiers then
            Tiers2 = Tiers
        else
            Tiers2 = { }
        end
    else
        Tiers2 = { }
    end

    local Count = #Tiers2
    local I = 1

    for I = 1, Count do
        if not Reached( I, List ) then
            if I > 1 then
                local Total = I - 1
                local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Total ] else Value7 and Value7.cfg
                local Flag

                if Captured then
                    if Captured.step then
                        Flag = Reached( Total, List or Values( ) )
                    elseif Value7 then
                        if type( Value7.c ) == "table" then
                            if Value7.c[ tostring( Total ) ] == true then
                                Flag = true
                            else
                                Flag = false
                            end
                        else
                            Flag = false
                        end
                    else
                        Flag = Value7
                    end
                else
                    Flag = false
                end
                if not Flag then
                    return nil, I - 1
                end
            end

            return I
        end
    end

    return nil
end

local function Claimable( Key2 )
    local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key2 ] else Value7 and Value7.cfg
    local Flag

    if Captured == nil then
        Flag = false
    elseif Captured.reward == nil then
        Flag = false
    else
        local Captured2

        if Value7 then
            if type( Value7.c ) == "table" then
                if Value7.c[ tostring( Key2 ) ] == true then
                    Captured2 = true
                else
                    Captured2 = false
                end
            else
                Captured2 = false
            end
        else
            Captured2 = Value7
        end

        local NotCaptured = not Captured2

        if NotCaptured then
            local Reached2 = Reached( Key2, ( Values( ) ) )

            if Reached2 then
                if Key2 == 1 then
                    Flag = true
                else
                    local Total = Key2 - 1
                    local Captured3 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Total ] else Value7 and Value7.cfg

                    if not Captured3 then
                        return false
                    end
                    if Captured3.step then
                        return ( Reached( Total, ( Values( ) ) ) )
                    end
                    if Value7 then
                        if type( Value7.c ) == "table" then
                            if Value7.c[ tostring( Total ) ] == true then
                                Flag = true
                            else
                                Flag = false
                            end
                        else
                            Flag = false
                        end
                    else
                        Flag = Value7
                    end
                end
            else
                Flag = Reached2
            end
        else
            Flag = NotCaptured
        end
    end

    return Flag
end

local function TierName( NameName )
    local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ NameName ] else Value7 and Value7.cfg
    local Name = Captured and Captured.name or "Tier " .. NameName
    return Name
end

local function BonusPhase()
    local Captured

    if Value7 then
        if type( Value7.c ) == "table" then
            if Value7.c[ tostring( 3 ) ] == true then
                Captured = true
            else
                Captured = false
            end
        else
            Captured = false
        end
    else
        Captured = Value7
    end

    return Captured
end

local FromRGB = Color3.fromRGB( 125, 230, 110 )
local FromRGB2 = Color3.fromRGB( 255, 205, 60 )

local function Num( Text )
    local Sub
    local Reverse = tostring( ( math.floor( tonumber( Text ) or 0 ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( )
    Sub = Reverse:sub( 1, 1 ) == "," and Reverse:sub( 2 ) or Reverse
    return Sub
end

local function Fmt( Name, Text )
    if Name == "time" then
        local Floor = math.floor( tonumber( Text ) or 0 )
        return ( "%dh%02d" ):format( Floor // 60, Floor % 60 )
    end
    return ( Num( Text ) )
end

local function SetClaim( Self, ClaimName, Text, Amount )
    for Key, Value in Self:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            local Enabled = Value.Name == ClaimName and true or false
            Value.Enabled = Enabled
        end
    end

    local AutoButtonColor = ClaimName == "Equip" and true or false
    Self.AutoButtonColor = AutoButtonColor
    Self.Text.Text = Text
    local Clip = Self:FindFirstChild( "Clip" )

    if Clip then
        local Visible
        local Clamp = math.clamp( Amount or 0, 0, 1 )

        if Amount == nil then
            Visible = false
        elseif Clamp > 0 then
            Visible = true
        else
            Visible = false
        end

        Clip.Visible = Visible

        if Clamp > 0 then
            Clip.Size = UDim2.fromScale( Clamp, 1 )
            local Fill = Clip.Fill
            Fill.Size = UDim2.fromScale( 1 / Clamp, 1 )
        end
    end
end

local Color32 = Color3.new( 0, 0, 0 )
local Color33 = Color3.new( 1, 1, 1 )
local FromRGB3 = Color3.fromRGB( 28, 26, 22 )
local FromRGB4 = Color3.fromRGB( 90, 200, 100 )
local Flag = false
local Table6 = { }

local function Pulse( Key, Argument2 )
    local Entry = Table6[ Key ]
    local Pulse = Key:FindFirstChild( "Pulse" )

    if not Argument2 or not Flag or not Pulse then
        if Entry then
            Entry:Cancel( )
            Table6[ Key ] = nil

            if Pulse then
                Pulse.Scale = 1
            end
        end

        return
    end
    if Entry then
        return
    end
    Pulse.Scale = 1
    local Create = TweenService:Create( Pulse, TweenInfo.new( 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true ), { Scale = 1.06 } )
    Table6[ Key ] = Create
    Create:Play( )
    return
end

local function PaintBar( Argument1, Argument2, Argument3 )
    if Argument1.track then
        local Track = Argument1.track
        Track.Color = ColorSequence.new( {
            ColorSequenceKeypoint.new( 0, Argument2:Lerp( Color32, 0.84 ) ),
            ColorSequenceKeypoint.new( 0.5, Argument2:Lerp( Color32, 0.95 ) ),
            ColorSequenceKeypoint.new( 1, Argument2:Lerp( Color32, 0.87 ) )
        } )
    end

    local Max2
    local Clamp = math.clamp( Argument3, 0, 1 )

    if Clamp > 0 then
        local Max = math.max( Clamp, 0.02 )

        if Max then
            Max2 = Max
        else
            Max2 = 0
        end
    else
        Max2 = 0
    end

    local Visible
    local Clip = Argument1.clip
    Visible = Clamp > 0 and true or false
    Clip.Visible = Visible

    if Clamp > 0 then
        local Clip2 = Argument1.clip
        Clip2.Size = UDim2.fromScale( Max2, 1 )
        local Fill = Argument1.fill
        Fill.Size = UDim2.fromScale( 1, 1 )
    end
    if Argument1.fillGrad then
        local FillGrad = Argument1.fillGrad
        FillGrad.Color = ColorSequence.new( Argument2:Lerp( Color32, 0.45 ), Argument2:Lerp( Color33, 0.3 ) )
    end
    if Argument1.tip then
        local X4
        local X = Argument1.bar.AbsoluteSize.X

        if X > 0 then
            local X2 = Argument1.tip.AbsoluteSize.X / X

            if X2 then
                X4 = X2
            else
                X4 = 0.05
            end
        else
            X4 = 0.05
        end

        local X5

        if X > 0 then
            local X3 = ( Argument1.value.TextBounds.X / 2 + 6 ) / X

            if X3 then
                X5 = X3
            else
                X5 = 0.15
            end
        else
            X5 = 0.15
        end

        local Visible2
        local Tip = Argument1.tip

        if Clamp >= 0.12 then
            if Clamp < 1 then
                if X5 < math.abs( Max2 - X4 / 2 - 0.5 ) then
                    Visible2 = true
                else
                    Visible2 = false
                end
            else
                Visible2 = false
            end
        else
            Visible2 = false
        end

        Tip.Visible = Visible2
        local Tip2 = Argument1.tip
        Tip2.Position = UDim2.fromScale( Max2, 0.5 )
    end
end

local function TierRatio( RatioName, List )
    local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ RatioName ] else Value7 and Value7.cfg
    local Value1, Number, Number2
    local Goals = Captured.goals
    Value1 = nil
    Number = 0
    Number2 = 0

    for Key, Value in Goals, nil, nil do
        local Number5
        local Entry = List[ Key ] or 0

        if type( Captured.base ) == "table" then
            local Number4 = tonumber( Captured.base[ Key ] )

            if Number4 then
                Number5 = Number4
            else
                Number5 = 0
            end
        else
            Number5 = 0
        end

        local Entry2 = Entry - Number5
        Number = Number + 1
        Number2 = Number2 + math.clamp( Entry2, 0, Captured.goals[ Key ] or 0 ) / math.max( Value, 1 )
    end

    local Number3 = Number > 0 and Number2 / Number or 0
    return Number3
end

local function SetReveal( Value, Argument2 )
    if not Value.reveal then
        return
    end

    local Visible
    local Clamp = math.clamp( Argument2, 0, 1 )
    local Reveal = Value.reveal
    Visible = Clamp > 0.001 and true or false
    Reveal.Visible = Visible

    if Clamp <= 0.001 then
        return
    end

    local Reveal2 = Value.reveal
    Reveal2.Size = UDim2.fromScale( Value.revealSize.X.Scale * Clamp, Value.revealSize.Y.Scale )
    local Icon = Value.icon
    Icon.Size = UDim2.fromScale( 1 / Clamp, 1 )

    if Value.edge then
        local Visible2
        local Edge = Value.edge
        Visible2 = Clamp < 0.999 and true or false
        Edge.Visible = Visible2
        local Edge2 = Value.edge
        Edge2.Size = UDim2.fromScale( 0.006 / Clamp, 1 )
    end
end

local Value8 = nil
local Value9 = nil
local Value10 = nil
local Number = 0
local Table7 = { }

local function MarkSel( SelName, Argument2 )
    local InnerStroke = SelName:FindFirstChild( "InnerStroke" )

    if not InnerStroke then
        return
    end
    if not Table7[ SelName ] then
        Table7[ SelName ] = { InnerStroke.Color, InnerStroke.Transparency }
    end

    local Color = Argument2 and Color33 or Table7[ SelName ][ 1 ]
    local Transparency
    InnerStroke.Color = Color
    Transparency = if Argument2 then 0 else Table7[ SelName ][ 2 ]
    InnerStroke.Transparency = Transparency
end

local function TierColor( ColorName )
    local Item = Table[ 4 ]

    if not ( ColorName > 3 ) or not Item or not ( Item.stepBase > 0 ) then
        local Color2

        if Table[ ColorName ] then
            local Color = Table[ ColorName ].color

            if Color then
                Color2 = Color
            else
                Color2 = FromRGB2
            end
        else
            Color2 = FromRGB2
        end

        return Color2
    end
    local Attribute2
    local Attribute = Item.frame:GetAttribute( "Col" .. ColorName - Item.stepBase )
    Attribute2 = if Attribute then Attribute else Item.color
    return Attribute2
end

local function CamoFocus( Value, Argument2 )
    local StepBase = Value.stepBase

    if Value9 and StepBase < Value9 and Value9 <= StepBase + 3 then
        return Value9 - StepBase
    end
    if Value10 then
        local Captured

        if Value7 then
            if type( Value7.c ) == "table" then
                if Value7.c[ tostring( 3 ) ] == true then
                    Captured = true
                else
                    Captured = false
                end
            else
                Captured = false
            end
        else
            Captured = Value7
        end
        if not Captured then
            return Value10
        end
    end
    if Claimable( StepBase + 1 ) then
        return 1
    end
    if Claimable( StepBase + 2 ) then
        return 2
    end
    if Claimable( StepBase + 3 ) then
        return 3
    end
    if Argument2 and StepBase < Argument2 and Argument2 <= StepBase + 3 then
        return Argument2 - StepBase
    end

    local Captured2
    local StepBase2 = StepBase + 1

    if Value7 then
        if type( Value7.c ) == "table" then
            if Value7.c[ tostring( StepBase2 ) ] == true then
                Captured2 = true
            else
                Captured2 = false
            end
        else
            Captured2 = false
        end
    else
        Captured2 = Value7
    end
    if not Captured2 then
        return 1
    end

    local Captured3
    local StepBase3 = StepBase + 2

    if Value7 then
        if type( Value7.c ) == "table" then
            if Value7.c[ tostring( StepBase3 ) ] == true then
                Captured3 = true
            else
                Captured3 = false
            end
        else
            Captured3 = false
        end
    else
        Captured3 = Value7
    end
    if not Captured3 then
        return 2
    end

    local Captured4
    local StepBase4 = StepBase + 3

    if Value7 then
        if type( Value7.c ) == "table" then
            if Value7.c[ tostring( StepBase4 ) ] == true then
                Captured4 = true
            else
                Captured4 = false
            end
        else
            Captured4 = false
        end
    else
        Captured4 = Value7
    end
    if Captured4 then
        return 3
    end
    return 3
end

local function TintOf( Self )
    return ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Self:Lerp( Color32, 0.25 ) ),
        ColorSequenceKeypoint.new( 0.45, Self:Lerp( Color32, 0.59 ) ),
        ColorSequenceKeypoint.new( 1, Self:Lerp( Color32, 0.85 ) )
    } )
end

local function Render()
    if not ( Value7 and Value7.cfg ) then
        return
    end

    local Captured
    local Values2 = Values( )
    local Value2, Value3 = ActiveTier( Values2 )

    if Value7 then
        if type( Value7.c ) == "table" then
            if Value7.c[ tostring( 3 ) ] == true then
                Captured = true
            else
                Captured = false
            end
        else
            Captured = false
        end
    else
        Captured = Value7
    end

    local Captured2

    if Value8 then
        Captured2 = Value8
    elseif Captured then
        Captured2 = 2
    else
        Captured2 = 1
    end

    local Flag = Captured2 == 2 and true or false
    local Text = not Flag and "UNLOCK THE G36" or "PHASE 2: THE CAMOS"
    RewardsTitle.Text = Text

    if Phase1 and Phase2 then
        local Text2 = not Flag and "Equip" or "Owned"
        local Text3
        SetClaim( Phase1, Text2, "PHASE 1" )
        Text3 = not Flag and "Owned" or "Equip"
        SetClaim( Phase2, Text3, "PHASE 2" )

        if PhaseTabs2 then
            PhaseTabs2.Visible = not Captured
            local Text4 = Phase2:FindFirstChild( "Text" )

            if Text4 then
                local Number = not Captured and 0.74 or 0.96
                Text4.Size = UDim2.fromScale( Number, Text4.Size.Y.Scale )
            end
        end
    end

    local Number2
    local Count = #( Value7 and Value7.cfg ).tiers
    local I = 1
    Number2 = 0

    for I = 1, Count do
        if Claimable( I ) then
            Number2 = Number2 + 1
        end
    end

    local Count2

    if Value2 then
        Count2 = Value2
    elseif Value3 then
        Count2 = Value3
    else
        Count2 = #( Value7 and Value7.cfg ).tiers
    end

    local Captured19

    if Value9 then
        Captured19 = Value9
    else
        local Flag2 = Count2 > 3 and true or false

        if Flag2 ~= Flag or not Count2 then
            if Flag then
                Captured19 = 4
            else
                Captured19 = 3
            end
        else
            Captured19 = Count2
        end
    end

    local Value4 = nil

    for Key, Value in Table, nil, nil do
        local Captured8
        Captured8 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key ] else Value7 and Value7.cfg
        local Visible4

        if Captured8 == nil then
            Visible4 = false
        elseif not Flag or Key ~= 4 then
            local NotFlag = not Flag

            if NotFlag then
                if Key == 3 then
                    Visible4 = true
                else
                    Visible4 = false
                end
            else
                Visible4 = NotFlag
            end
        else
            Visible4 = true
        end

        Value.frame.Visible = Visible4

        if Visible4 then
            if Value.stepBase > 0 then
                local StepBase = Value.stepBase
                local CamoFocus2 = CamoFocus( Value, Value2 )
                local StepBase2 = StepBase + CamoFocus2
                local Captured9 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ StepBase2 ] else Value7 and Value7.cfg
                local Color5
                local StepBase3 = StepBase + CamoFocus2
                local Item2 = Table[ 4 ]

                if not ( StepBase3 > 3 ) or not Item2 or not ( Item2.stepBase > 0 ) then
                    if Table[ StepBase3 ] then
                        local Color6 = Table[ StepBase3 ].color

                        if Color6 then
                            Color5 = Color6
                        else
                            Color5 = FromRGB2
                        end
                    else
                        Color5 = FromRGB2
                    end
                else
                    local Attribute2 = Item2.frame:GetAttribute( "Col" .. StepBase3 - Item2.stepBase )

                    if Attribute2 then
                        Color5 = Attribute2
                    else
                        Color5 = Item2.color
                    end
                end

                local Image
                local Icon = Value.icon
                local Attribute3 = Value.frame:GetAttribute( "Img" .. CamoFocus2 )
                Image = if Attribute3 then Attribute3 else Value.icon.Image
                Icon.Image = Image
                Value.icon.ImageColor3 = Color33

                if Value.tint then
                    local Tint = Value.tint
                    Tint.Color = TintOf( Color5 )
                end
                if Value.glow then
                    local Glow = Value.glow
                    Glow.ImageColor3 = Color5:Lerp( Color33, 0.4 )
                end
                if Value.nameLabel and Captured9 then
                    local Label4
                    local NameLabel = Value.nameLabel
                    local Label3 = Captured9.label
                    Label4 = if Label3 then Label3 else Captured9.name
                    NameLabel.Text = Label4:upper( ) .. " CAMO"
                end

                local Captured10
                local Lock = Value.lock
                local StepBase4 = StepBase + CamoFocus2

                if Value7 then
                    if type( Value7.c ) == "table" then
                        if Value7.c[ tostring( StepBase4 ) ] == true then
                            Captured10 = true
                        else
                            Captured10 = false
                        end
                    else
                        Captured10 = false
                    end
                else
                    Captured10 = Value7
                end

                Lock.Visible = not Captured10

                if Value.veil then
                    Value.veil.Visible = false
                end
                if Captured then
                    local Value15, Total, Number6
                    local Steps4 = Value.steps
                    Value15 = nil
                    Total = nil
                    Number6 = 0

                    for Key5, Value16 in Steps4, nil, nil do
                        local Flag6
                        local StepBase6 = StepBase + Key5
                        local Claimable2 = Claimable( StepBase6 )
                        Pulse( Value16, Claimable2 )
                        Flag6 = StepBase6 == Captured19 and true or false
                        MarkSel( Value16, Flag6 )

                        if Claimable2 then
                            Number6 = Number6 + 1
                            Total = Total or StepBase6
                            SetClaim( Value16, "Equip", "CLAIM CAMO" )
                        else
                            local Captured12

                            if Value7 then
                                if type( Value7.c ) == "table" then
                                    if Value7.c[ tostring( StepBase6 ) ] == true then
                                        Captured12 = true
                                    else
                                        Captured12 = false
                                    end
                                else
                                    Captured12 = false
                                end
                            else
                                Captured12 = Value7
                            end
                            if Captured12 then
                                Number6 = Number6 + 1
                                SetClaim( Value16, "Normal", "UNLOCKED" )
                            elseif StepBase6 == Value2 then
                                local TierRatio3 = TierRatio( StepBase6, Values2 )
                                SetClaim( Value16, "Track", ( "TIER %d  %d%%" ):format( Key5, ( math.floor( TierRatio3 * 100 ) ) ), TierRatio3 )
                            else
                                SetClaim( Value16, "Owned", ( "TIER %d" ):format( Key5 ) )
                            end
                        end
                    end
                    if Total then
                        SetClaim( Value.claim, "Equip", "CLAIM CAMO" )
                    else
                        local Captured11
                        local StepBase5 = StepBase + 3

                        if Value7 then
                            if type( Value7.c ) == "table" then
                                if Value7.c[ tostring( StepBase5 ) ] == true then
                                    Captured11 = true
                                else
                                    Captured11 = false
                                end
                            else
                                Captured11 = false
                            end
                        else
                            Captured11 = Value7
                        end
                        if Captured11 then
                            SetClaim( Value.claim, "Normal", "ALL CAMOS UNLOCKED" )
                        else
                            local Number7

                            if not Value2 or not ( StepBase < Value2 ) then
                                Number7 = 0
                            else
                                local TierRatio2 = TierRatio( Value2, Values2 )

                                if TierRatio2 then
                                    Number7 = TierRatio2
                                else
                                    Number7 = 0
                                end
                            end

                            local Number8 = ( Number6 + Number7 ) / 3
                            local Claim3 = Value.claim
                            SetClaim( Claim3, "Track", ( "IN PROGRESS %d%%" ):format( ( math.floor( Number8 * 100 ) ) ), Number8 )
                        end
                    end

                    local Flag5
                    local Claim4 = Value.claim
                    Flag5 = Total ~= nil and true or false
                    Pulse( Claim4, Flag5 )
                else
                    local Value13
                    local Steps3 = Value.steps
                    Value13 = nil

                    for Key4, Value14 in Steps3, nil, nil do
                        local Entry7 = Table6[ Value14 ]
                        local Pulse4 = Value14:FindFirstChild( "Pulse" )

                        if Entry7 then
                            Entry7:Cancel( )
                            Table6[ Value14 ] = nil

                            if Pulse4 then
                                Pulse4.Scale = 1
                            end
                        end

                        local Flag4 = StepBase + Key4 == Captured19 and true or false
                        local Text6
                        MarkSel( Value14, Flag4 )
                        Text6 = Key4 ~= CamoFocus2 and "Owned" or "Progress"
                        SetClaim( Value14, Text6, ( "TIER %d" ):format( Key4 ) )
                    end

                    Value.lock.Visible = true
                    SetClaim( Value.claim, "Owned", "UNLOCK THE G36 FIRST" )
                    local Claim2 = Value.claim
                    local Entry6 = Table6[ Claim2 ]
                    local Pulse3 = Claim2:FindFirstChild( "Pulse" )

                    if Entry6 then
                        Entry6:Cancel( )
                        Table6[ Claim2 ] = nil

                        if Pulse3 then
                            Pulse3.Scale = 1
                        end
                    end
                end
            else
                local Reached2 = Reached( Key, Values2 )
                local Captured13 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key ] else Value7 and Value7.cfg
                local Flag7

                if Captured13 then
                    if Captured13.step then
                        local Value21 = if Values2 then Values2 else Values( )
                        Flag7 = Reached( Key, Value21 )
                    elseif Value7 then
                        if type( Value7.c ) == "table" then
                            if Value7.c[ tostring( Key ) ] == true then
                                Flag7 = true
                            else
                                Flag7 = false
                            end
                        else
                            Flag7 = false
                        end
                    else
                        Flag7 = Value7
                    end
                else
                    Flag7 = false
                end

                local Visible5
                local Claimable3 = Claimable( Key )
                local IsMissing = not Reached2

                if IsMissing then
                    if Key == Value2 then
                        Visible5 = false
                    else
                        Visible5 = not Value.steps
                    end
                else
                    Visible5 = IsMissing
                end

                local Lock2 = Value.lock
                Lock2.Visible = not Flag7

                if Captured8.step then
                    Value.icon.ImageColor3 = FromRGB3
                else
                    local ImageColor3
                    local Icon2 = Value.icon

                    if Visible5 then
                        local FromRGBInner = Color3.fromRGB( 150, 150, 158 )

                        if FromRGBInner then
                            ImageColor3 = FromRGBInner
                        else
                            ImageColor3 = Color33
                        end
                    else
                        ImageColor3 = Color33
                    end

                    Icon2.ImageColor3 = ImageColor3
                end
                if Value.veil then
                    Value.veil.Visible = Visible5
                end
                if Value.stroke then
                    local Stroke3 = Value.stroke
                    Stroke3.Color = Value.strokeBase[ 1 ]
                    local Stroke4 = Value.stroke
                    Stroke4.Thickness = Value.strokeBase[ 2 ]
                    local Stroke5 = Value.stroke
                    Stroke5.Transparency = Value.strokeBase[ 3 ]
                end
                if Value.steps then
                    local Value23, Number9
                    local Steps5 = Value.steps
                    Value23 = nil
                    Number9 = 0

                    for Key6, Value24 in Steps5, nil, nil do
                        local Captured16 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key6 ] else Value7 and Value7.cfg
                        local Flag8

                        if Key6 == Key then
                            Flag8 = false
                        elseif Captured16 == nil then
                            Flag8 = false
                        elseif Captured16.skin == nil then
                            Flag8 = false
                        else
                            Flag8 = Claimable( Key6 )
                        end

                        local Flag9
                        Pulse( Value24, Flag8 )
                        Flag9 = Key6 == Captured19 and true or false
                        MarkSel( Value24, Flag9 )

                        if Flag8 then
                            Number9 = Number9 + 1
                            SetClaim( Value24, "Equip", "CLAIM CAMO" )
                        else
                            local Captured17 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key6 ] else Value7 and Value7.cfg
                            local Flag10

                            if Captured17 then
                                if Captured17.step then
                                    local Value26 = if Values2 then Values2 else Values( )
                                    Flag10 = Reached( Key6, Value26 )
                                elseif Value7 then
                                    if type( Value7.c ) == "table" then
                                        if Value7.c[ tostring( Key6 ) ] == true then
                                            Flag10 = true
                                        else
                                            Flag10 = false
                                        end
                                    else
                                        Flag10 = false
                                    end
                                else
                                    Flag10 = Value7
                                end
                            else
                                Flag10 = false
                            end
                            if not Flag10 then
                                if Key6 ~= Key or not Reached2 then
                                    if Key6 == Value2 then
                                        local TierRatio5 = TierRatio( Key6, Values2 )
                                        SetClaim( Value24, "Track", ( "TIER %d  %d%%" ):format( Key6, ( math.floor( TierRatio5 * 100 ) ) ), TierRatio5 )
                                        continue
                                    end
                                    SetClaim( Value24, "Owned", ( "TIER %d" ):format( Key6 ) )
                                    continue
                                end
                            end

                            Number9 = Number9 + 1
                            SetClaim( Value24, "Normal", ( "TIER %d DONE" ):format( Key6 ) )
                        end
                    end

                    local Captured14

                    if Value7 then
                        if type( Value7.c ) == "table" then
                            if Value7.c[ tostring( Key ) ] == true then
                                Captured14 = true
                            else
                                Captured14 = false
                            end
                        else
                            Captured14 = false
                        end
                    else
                        Captured14 = Value7
                    end

                    local Number11

                    if Captured14 or Reached2 then
                        Number11 = 1
                    else
                        local Number10

                        if not Value2 or not ( Value2 <= Key ) then
                            Number10 = 0
                        else
                            local TierRatio4 = TierRatio( Value2, Values2 )

                            if TierRatio4 then
                                Number10 = TierRatio4
                            else
                                Number10 = 0
                            end
                        end

                        Number11 = ( Number9 + Number10 ) / #Value.steps
                    end

                    local Captured15
                    SetReveal( Value, Number11 )

                    if Value7 then
                        if type( Value7.c ) == "table" then
                            if Value7.c[ tostring( Key ) ] == true then
                                Captured15 = true
                            else
                                Captured15 = false
                            end
                        else
                            Captured15 = false
                        end
                    else
                        Captured15 = Value7
                    end
                    if Captured15 then
                        SetClaim( Value.claim, "Normal", "CLAIMED" )
                    elseif Claimable3 then
                        SetClaim( Value.claim, "Equip", "CLAIM THE G36" )
                    else
                        local Claim5 = Value.claim
                        SetClaim( Claim5, "Track", ( "IN PROGRESS %d%%" ):format( ( math.floor( Number11 * 100 ) ) ), Number11 )
                    end
                elseif Captured8.step then
                    if Reached2 then
                        SetClaim( Value.claim, "Normal", "COMPLETED" )
                    elseif Visible5 then
                        SetClaim( Value.claim, "Owned", "LOCKED" )
                    else
                        local TierRatio6 = TierRatio( Key, Values2 )
                        local Claim6 = Value.claim
                        SetClaim( Claim6, "Track", ( "IN PROGRESS %d%%" ):format( ( math.floor( TierRatio6 * 100 ) ) ), TierRatio6 )
                    end
                else
                    local Captured18

                    if Value7 then
                        if type( Value7.c ) == "table" then
                            if Value7.c[ tostring( Key ) ] == true then
                                Captured18 = true
                            else
                                Captured18 = false
                            end
                        else
                            Captured18 = false
                        end
                    else
                        Captured18 = Value7
                    end
                    if Captured18 then
                        SetClaim( Value.claim, "Normal", "CLAIMED" )
                    elseif Claimable3 then
                        local Text7
                        local Claim7 = Value.claim
                        Text7 = not Captured8.skin and "CLAIM" or "CLAIM CAMO"
                        SetClaim( Claim7, "Equip", Text7 )
                    elseif not Reached2 or Captured8.reward ~= nil then
                        if Reached2 then
                            SetClaim( Value.claim, "Progress", "COMPLETED" )
                        elseif Visible5 then
                            SetClaim( Value.claim, "Owned", "LOCKED" )
                        else
                            local TierRatio7 = TierRatio( Key, Values2 )
                            local Claim8 = Value.claim
                            SetClaim( Claim8, "Track", ( "IN PROGRESS %d%%" ):format( ( math.floor( TierRatio7 * 100 ) ) ), TierRatio7 )
                        end
                    else
                        SetClaim( Value.claim, "Progress", "COMING SOON" )
                    end
                end

                Pulse( Value.claim, Claimable3 )
            end
        else
            local Claim = Value.claim
            local Entry4 = Table6[ Claim ]
            local PulseInner = Claim:FindFirstChild( "Pulse" )

            if Entry4 then
                Entry4:Cancel( )
                Table6[ Claim ] = nil

                if PulseInner then
                    PulseInner.Scale = 1
                end
            end

            local Steps2
            local Steps = Value.steps
            Steps2 = if Steps then Steps else { }
            local Value10 = nil

            for Key3, Value11 in Steps2, nil, nil do
                local Entry5 = Table6[ Value11 ]
                local Pulse2 = Value11:FindFirstChild( "Pulse" )

                if Entry5 then
                    Entry5:Cancel( )
                    Table6[ Value11 ] = nil

                    if Pulse2 then
                        Pulse2.Scale = 1
                    end
                end
            end
        end
    end

    local Captured3 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Captured19 ] else Value7 and Value7.cfg
    local Goals = Captured3 and Captured3.goals or { }
    local Color
    local Item = Table[ 4 ]

    if not ( Captured19 > 3 ) or not Item or not ( Item.stepBase > 0 ) then
        if Table[ Captured19 ] then
            local Color2 = Table[ Captured19 ].color

            if Color2 then
                Color = Color2
            else
                Color = FromRGB2
            end
        else
            Color = FromRGB2
        end
    else
        local Attribute = Item.frame:GetAttribute( "Col" .. Captured19 - Item.stepBase )

        if Attribute then
            Color = Attribute
        else
            Color = Item.color
        end
    end
    if Footer then
        local Value5, Number3
        Value5 = nil
        Number3 = 0

        for Value6 in Goals, nil, nil do
            if Table2[ Value6 ] then
                Number3 = Number3 + 1
            end
        end

        local Visible = Number3 <= 5 and true or false
        Footer.Visible = Visible
        local ToHex = Color:Lerp( Color33, 0.3 ):ToHex( )

        if Captured19 == Count2 then
            if Value3 then
                local ToHex2 = FromRGB:ToHex( )
                local Captured4 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Value3 ] else Value7 and Value7.cfg
                local Name = Captured4 and Captured4.name or "Tier " .. Value3
                Footer.Text = ( "<font color=\"#%s\">Claim the %s to unlock phase 2</font>" ):format( ToHex2, Name )
            elseif not Value2 or not Captured3.skin then
                if not Value2 or not Captured3.step then
                    if not Value2 or not Captured3.reward then
                        if Value2 then
                            Footer.Text = ( "Complete these challenges to unlock<br/><font color=\"#%s\">the bonus reward</font>" ):format( ToHex )
                        else
                            Footer.Text = ( "<font color=\"#%s\">All challenges completed!</font>" ):format( FromRGB:ToHex( ) )
                        end
                    else
                        local Captured6 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Captured19 ] else Value7 and Value7.cfg
                        local Name2 = Captured6 and Captured6.name or "Tier " .. Captured19
                        Footer.Text = ( "Complete these challenges to unlock<br/><font color=\"#%s\">the %s</font>" ):format( ToHex, Name2 )
                    end
                else
                    Footer.Text = ( "Complete these challenges to unlock<br/><font color=\"#%s\">Tier %d of 3</font>" ):format( ToHex, Captured19 + 1 )
                end
            else
                local Label2
                local Label = Captured3.label

                if Label then
                    Label2 = Label
                else
                    local Captured5 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Captured19 ] else Value7 and Value7.cfg

                    if not Captured5 or not Captured5.name then
                        Label2 = "Tier " .. Captured19
                    else
                        Label2 = Captured5.name
                    end
                end

                Footer.Text = ( "Complete these challenges to unlock<br/><font color=\"#%s\">the %s camo</font>" ):format( ToHex, Label2 )
            end
        elseif Reached( Captured19, Values2 ) then
            Footer.Text = ( "<font color=\"#%s\">Tier completed!</font>" ):format( FromRGB:ToHex( ) )
        elseif not ( Captured19 > 3 ) or Captured then
            Footer.Text = ( "<font color=\"#%s\">Complete the previous tiers first</font>" ):format( ToHex )
        else
            Footer.Text = ( "<font color=\"#%s\">Unlock the G36 first</font>" ):format( ToHex )
        end
    end

    local Format2

    if Captured19 > 3 then
        local Format = ( "CAMO TIER %d / 3" ):format( Captured19 - 3 )

        if Format then
            Format2 = Format
        else
            Format2 = ( "TIER %d / 3" ):format( Captured19 )
        end
    else
        Format2 = ( "TIER %d / 3" ):format( Captured19 )
    end

    local Value7Inner
    QuestsTitle.Text = ( "<font color=\"#%s\">%s</font> CHALLENGES" ):format( Color:Lerp( Color33, 0.3 ):ToHex( ), Format2 )
    Value7Inner = nil

    for Key2, Value8Inner in Table2, nil, nil do
        local Visible3
        local Entry = Goals[ Key2 ]
        local Frame = Value8Inner.frame
        Visible3 = Entry ~= nil and true or false
        Frame.Visible = Visible3

        if Entry then
            local Number5
            local Entry2 = Values2[ Key2 ] or 0

            if type( Captured3.base ) == "table" then
                local Number4 = tonumber( Captured3.base[ Key2 ] )

                if Number4 then
                    Number5 = Number4
                else
                    Number5 = 0
                end
            else
                Number5 = 0
            end

            local Flag3
            local Entry3 = Entry2 - Number5
            local Clamp = math.clamp( Entry3, 0, Captured3.goals[ Key2 ] or 0 )
            Flag3 = Entry <= Clamp and true or false
            local Captured7 = Flag3 and FromRGB4 or Color
            local Format3
            local Value9Inner = Value8Inner.value

            if Key2 == "time" then
                local Floor = math.floor( tonumber( Clamp ) or 0 )
                Format3 = ( "%dh%02d" ):format( Floor // 60, Floor % 60 )
            else
                Format3 = Num( Clamp )
            end

            Value9Inner.Text = ( "%s / %s" ):format( Format3, Fmt( Key2, Entry ) )
            PaintBar( Value8Inner, Captured7, Clamp / math.max( Entry, 1 ) )

            if Value8Inner.accent then
                local Accent = Value8Inner.accent
                Accent.BackgroundColor3 = Captured7:Lerp( Color33, 0.2 )
            end
            if Value8Inner.stroke then
                local Color4
                local Stroke = Value8Inner.stroke
                Color4 = Flag3 and FromRGB4 or Value8Inner.strokeBase[ 1 ]
                local Transparency
                Stroke.Color = Color4
                local Stroke2 = Value8Inner.stroke
                Transparency = if Flag3 then 0.25 else Value8Inner.strokeBase[ 2 ]
                Stroke2.Transparency = Transparency
            end
            if Flag3 then
                local Hint = Value8Inner.hint
                local Hint2 = Value8Inner.hint
                Hint.Text = "Completed"
                Hint2.TextColor3 = FromRGB
            else
                local Hint3 = Value8Inner.hint
                local Hint4 = Value8Inner.hint
                local Text5 = Value8Inner.hintText
                local TextColor3 = Value8Inner.hintColor
                Hint3.Text = Text5
                Hint4.TextColor3 = TextColor3
            end
        end
    end
    if Storage.G36EventButton2 then
        local Visible2 = Number2 > 0 and true or false
        Storage.G36EventButton2.Visible = Visible2
        local TextLabel = Storage.G36EventButton2:FindFirstChildWhichIsA( "TextLabel" )

        if TextLabel then
            TextLabel.Text = tostring( Number2 )
        end
    end
end

local function UpdateCountdown()
    if not ( Value7 and Value7.cfg ) then
        Countdown.Text = ""
        return
    end

    local Ends = ( ( Value7 and Value7.cfg ).ends or 0 ) - workspace:GetServerTimeNow( )

    if Ends <= 0 then
        Countdown.Text = "EVENT ENDED"
        return
    end

    local Text
    local Floor = math.floor( Ends / 86400 )
    local Floor2 = math.floor( Ends % 86400 / 3600 )
    local Floor3 = math.floor( Ends % 3600 / 60 )

    if not ( Floor > 0 ) or not ( "ENDS IN %dd %dh" ):format( Floor, Floor2 ) then
        Text = ( "ENDS IN %dh %dm" ):format( Floor2, Floor3 )
    else
        Text = ( "ENDS IN %dd %dh" ):format( Floor, Floor2 )
    end

    Countdown.Text = Text
end

local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ModCatalog = require( Weapons:WaitForChild( "ModCatalog" ) )
local CamoFlow = require( Weapons:WaitForChild( "CamoFlow" ) )
local Table8 = { }
local Table9 = { }
local Table10 = { -1, 1 }
Value11 = nil

for Key5, Value12 in Table10, nil, nil do
    local Value18
    local Table12 = { -1, 1 }
    Value18 = nil

    for Key8, Value19 in Table12, nil, nil do
        local Value20
        local Table13 = { -1, 1 }
        Value20 = nil

        for Key9, Value21 in Table13, nil, nil do
            table.insert( Table9, ( Vector3.new( Value12, Value19, Value21 ) ) )
        end
    end
end

local function Model3D( Object, Argument2 )
    local Clone = Object:Clone( )

    if Argument2 then
        pcall( ModCatalog.Apply, Clone, "G36", { Skin = Argument2 } )
    end
    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "LuaSourceContainer" ) or Value:IsA( "Sound" ) or Value:IsA( "ParticleEmitter" ) or Value:IsA( "Light" ) or Value:IsA( "Beam" ) or Value:IsA( "Trail" ) then
            Value:Destroy( )
        elseif Value:IsA( "BasePart" ) then
            Value.Anchored = true

            if Value:HasTag( "SkinFX" ) then
                Value:RemoveTag( "SkinFX" )
            end
        end
    end

    local CFrame2
    local Origin = Clone:FindFirstChild( "Origin", true )

    if Origin then
        local ToObjectSpace = Origin.CFrame:ToObjectSpace( Clone:GetPivot( ) )

        if ToObjectSpace then
            CFrame2 = ToObjectSpace
        else
            CFrame2 = CFrame.new( )
        end
    else
        CFrame2 = CFrame.new( )
    end

    Clone:PivotTo( CFrame.lookAt( Vector3.new( 0, 0, 0 ), Vector3.new( -1, -0, -0 ), Vector3.new( 0, 1, 0 ) ) * CFrame2 )
    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

    for Key2, Value2 in Clone:GetDescendants( ) do
        if Value2:IsA( "BasePart" ) and Value2.Transparency < 1 then
            local Value1 = nil

            for Key4, Value4 in Table9, nil, nil do
                local CFrame3 = Value2.CFrame * ( Value2.Size / 2 * Value4 )
                local X = Result.X
                local Min = math.min( X, CFrame3.X )
                local Y = Result.Y
                local Min2 = math.min( Y, CFrame3.Y )
                local Z = Result.Z
                Result = Vector3.new( Min, Min2, ( math.min( Z, CFrame3.Z ) ) )
                local X2 = Result2.X
                local Max = math.max( X2, CFrame3.X )
                local Y2 = Result2.Y
                local Max2 = math.max( Y2, CFrame3.Y )
                local Z2 = Result2.Z
                Result2 = Vector3.new( Max, Max2, ( math.max( Z2, CFrame3.Z ) ) )
            end
        end
    end

    Clone:PivotTo( Clone:GetPivot( ) - ( Result + Result2 ) / 2 )
    local Pivot = Clone:GetPivot( )
    local Table = { }

    for Key3, Value3 in Clone:GetDescendants( ) do
        if Value3:IsA( "BasePart" ) and CamoFlow.STYLES[ Value3:GetAttribute( "SkinFX" ) or "" ] then
            table.insert( Table, { CamoFlow.Rec( Value3, Pivot ), Value3 } )
        end
    end

    return { m = Clone, recs = Table, size = Result2 - Result }
end

local function Place3D( Argument1, Clock )
    local AbsoluteSize = Argument1.vp.AbsoluteSize

    if not Argument1.cur or AbsoluteSize.X < 2 or AbsoluteSize.Y < 2 then
        return false
    end
    local Size = Argument1.cur.size
    local X = Size.X / 2 * 1.06 / ( 0.17632698070846498 * AbsoluteSize.X / AbsoluteSize.Y )
    local Max = math.max( X, Size.Y / 2 * 1.12 / 0.17632698070846498 ) + Size.Z / 2
    local Sin = math.sin( Clock * 1.3 ) * 0.035
    local Cam = Argument1.cam
    Cam.CFrame = CFrame.lookAt( CFrame.Angles( 0, math.sin( Clock * 2 * 3.141592653589793 / 8 ) * 0.3141592653589793, 0 ) * Vector3.new( 0, Sin, Max ), ( Vector3.new( 0, Sin, 0 ) ) )
    return true
end

local function NewView( Parent, Argument2 )
    local Parent2 = Instance.new( "ViewportFrame" )
    Parent2.Name = "Vue3D"
    Parent2.BackgroundTransparency = 1
    Parent2.Size = UDim2.fromScale( 1, 1 )
    Parent2.ZIndex = Parent.ZIndex
    Parent2.Ambient = Color3.fromRGB( 150, 150, 158 )
    Parent2.LightColor = Color3.new( 1, 1, 1 )
    Parent2.LightDirection = Vector3.new( -0.4000000059604645, -0.800000011920929, -0.6000000238418579 )
    Parent2.ImageColor3 = Parent.ImageColor3
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 20
    CurrentCamera.Parent = Parent2
    Parent2.CurrentCamera = CurrentCamera
    Parent2.Parent = Parent
    Parent.ImageTransparency = 1
    Parent:GetPropertyChangedSignal( "ImageColor3" ):Connect( function()
        Parent2.ImageColor3 = Parent.ImageColor3
    end )
    local Table = { vp = Parent2, cam = CurrentCamera, card = Argument2 }
    Parent2:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
        Place3D( Table, os.clock( ) )
    end )
    table.insert( Table8, Table )
    return Table
end

local function Show3D( Argument1, Cur )
    if Argument1.cur == Cur then
        return
    end
    if Argument1.cur then
        Argument1.cur.m.Parent = nil
    end

    Argument1.cur = Cur
    local M = Cur.m
    M.Parent = Argument1.vp
    Place3D( Argument1, os.clock( ) )
end

local Number2 = 0

local function Tick3D( Argument1 )
    Number2 = Number2 + Argument1

    if Number2 < 0.03333333333333333 then
        return
    end

    local Value1
    Number2 = 0
    local Clock = os.clock( )
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        if Value.card.frame.Visible and Place3D( Value, Clock ) then
            local Value2
            local Recs = Value.cur.recs
            Value2 = nil

            for Key2, Value3 in Recs, nil, nil do
                local Step = CamoFlow.Step
                local Item = Value3[ 1 ]
                Step( Item, Value3[ 2 ], Clock, 0, 1 )
            end
        end
    end
end

task.spawn( function()
    local G36
    local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals", 30 )

    if WeaponVisuals then
        G36 = WeaponVisuals:WaitForChild( "G36", 30 )
    else
        G36 = WeaponVisuals
    end
    if not G36 then
        return
    end

    local Item = Table[ 3 ]

    if Item then
        local IconShadow = Item.frame:FindFirstChild( "IconShadow" )

        if IconShadow and IconShadow:IsA( "ImageLabel" ) then
            IconShadow.ImageTransparency = 1
        end

        local Silhouette = Item.frame:FindFirstChild( "Silhouette" )

        if Silhouette and Silhouette:IsA( "ImageLabel" ) then
            local View = NewView( Silhouette, Item )
            local Cur = Model3D( G36 )

            if View.cur ~= Cur then
                if View.cur then
                    View.cur.m.Parent = nil
                end

                View.cur = Cur
                local M = Cur.m
                M.Parent = View.vp
                Place3D( View, os.clock( ) )
            end
        end
        if Item.icon:IsA( "ImageLabel" ) then
            local View2 = NewView( Item.icon, Item )
            local Cur2 = Model3D( G36 )

            if View2.cur ~= Cur2 then
                if View2.cur then
                    View2.cur.m.Parent = nil
                end

                View2.cur = Cur2
                local M2 = Cur2.m
                M2.Parent = View2.vp
                Place3D( View2, os.clock( ) )
            end
        end
    end

    local Item2 = Table[ 4 ]

    if Item2 and Item2.stepBase > 0 and Item2.icon:IsA( "ImageLabel" ) then
        local View3 = NewView( Item2.icon, Item2 )
        local TableInner = { }

        local function Pick()
            local I = 1

            for I = 1, 3 do
                if Item2.frame:GetAttribute( "Img" .. I ) == Item2.icon.Image then
                    local Entry2
                    local Entry = TableInner[ I ]
                    Entry2 = if Entry then Entry else Model3D( G36, Item2.frame:GetAttribute( "Skin" .. I ) )
                    TableInner[ I ] = Entry2
                    local Cur = TableInner[ I ]

                    if View3.cur == Cur then
                        return
                    end
                    if View3.cur then
                        View3.cur.m.Parent = nil
                    end

                    View3.cur = Cur
                    local M = Cur.m
                    M.Parent = View3.vp
                    Place3D( View3, os.clock( ) )
                    return
                end
            end
        end

        Item2.icon:GetPropertyChangedSignal( "Image" ):Connect( Pick )
        Pick( )
    end
end )
local Value13 = nil

local function Blocked()
    local Flag

    if ClientState.WardrobeOpen == true then
        Flag = true
    elseif ClientState.BetaReveal == true then
        Flag = true
    elseif ClientState.Downed == true then
        Flag = true
    elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function FirstButton()
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        if Value.frame.Visible and Claimable( Key ) then
            return Value.claim
        end

        local Steps = Value.frame.Visible and Value.steps or { }
        local Value2 = nil

        for Key2, Value3 in Steps, nil, nil do
            local StepBase = Value.stepBase + Key2

            if StepBase ~= Key then
                if Claimable( StepBase ) then
                    return Value3
                end
            end
        end
    end

    local Count = #Table
    local I = 1

    for I = 1, Count do
        if Table[ I ] and Table[ I ].frame.Visible then
            return Table[ I ].claim
        end
    end

    return Table[ 1 ].claim
end

local Callback = nil
local Number3 = 0

local function AnimateCards( Amount )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        if Value.frame.Visible then
            local Value2
            local FromScale = UDim2.fromScale( 0, math.sin( Amount * 1.6 ) * 0.012 )
            local Float = Value.float
            Value2 = nil

            for Key2, Value3 in Float, nil, nil do
                local Item = Value3[ 1 ]
                Item.Position = Value3[ 2 ] + FromScale
            end
            if Value.glow then
                local Sin = math.sin( Amount * 2.4 ) * 0.5 + 0.5
                local Sin2 = Sin * 0.1 + 0.94
                local Glow = Value.glow
                Glow.Size = UDim2.fromScale( Value.glowSize.X.Scale * Sin2, Value.glowSize.Y.Scale * Sin2 )
                local Glow2 = Value.glow
                Glow2.ImageTransparency = math.min( Value.glowT + ( 1 - Sin ) * 0.12, 1 )
            end
            if Value.shine then
                local Result = Amount % 3.4 / 1.1
                local Shine = Value.shine
                Shine.Offset = Vector2.new( math.min( Result, 1 ) * 2 + -1, 0 )
            end
        end
    end
end

local function Step( Argument1 )
    local Flag

    if ClientState.WardrobeOpen == true then
        Flag = true
    elseif ClientState.BetaReveal == true then
        Flag = true
    elseif ClientState.Downed == true then
        Flag = true
    elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    else
        Flag = false
    end
    if Flag or ClientState.ActiveMenu ~= "G36Event" then
        Callback( false )
        return
    end

    local Value1
    local TableInner = { "Shop", "Settings", "Customization" }
    Value1 = nil

    for Key, Value in TableInner, nil, nil do
        local IconInner
        local GetIcon = Icon.getIcon

        if GetIcon then
            IconInner = Icon.getIcon( Value )
        else
            IconInner = GetIcon
        end
        if IconInner then
            if IconInner.isSelected then
                Callback( false )
                return
            end
        end
    end
    if not ClientState.CursorFree then
        ClientState.CursorFree = true
    end

    AnimateCards( os.clock( ) )
    Tick3D( Argument1 )
    local Item = Table[ 4 ]

    if Item and Item.frame.Visible and Value9 == nil then
        local Captured

        if Value7 then
            if type( Value7.c ) == "table" then
                if Value7.c[ tostring( 3 ) ] == true then
                    Captured = true
                else
                    Captured = false
                end
            else
                Captured = false
            end
        else
            Captured = Value7
        end
        if not Captured then
            Number = Number + Argument1

            if Number >= 2.5 then
                Number = 0
                Value10 = ( Value10 or 1 ) % 3 + 1
                Render( )
            end
        end
    end

    Number3 = Number3 + Argument1

    if Number3 >= 1 then
        Number3 = 0
        UpdateCountdown( )
    end
end

Callback = function( Visible )
    if Visible == Flag then
        return
    end
    if Visible then
        local FlagInner

        if ClientState.WardrobeOpen == true then
            FlagInner = true
        elseif ClientState.BetaReveal == true then
            FlagInner = true
        elseif ClientState.Downed == true then
            FlagInner = true
        elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            FlagInner = true
        else
            FlagInner = false
        end
        if FlagInner then
            return
        end
    end

    Flag = Visible
    Menu.Visible = Visible

    if Visible then
        Value8 = nil
        Value9 = nil
        Value10 = nil
        Number = 0
        ClientState.ActiveMenu = "G36Event"
        ClientState.CursorFree = true
        local ClosePanel = HUDButtons:FindFirstChild( "ClosePanel" )

        if ClosePanel then
            ClosePanel:Fire( )
        end

        local Value1
        local Table = { "Shop", "Settings", "Customization" }
        Value1 = nil

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
        if UIScale then
            UIScale.Scale = 0.92
            TweenService:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end

        task.delay( 0.2, function()
            if Flag then
                ApplyType( )
                Render( )
            end
        end )
        UpdateCountdown( )
        Render( )
        G36EventQuest:FireServer( "get" )
        Value13 = RunService.Heartbeat:Connect( Step )
        GamepadNav.Open( "G36Event", {
            root = Window,
            first = FirstButton,
            onBack = function()
                Callback( false )
            end
        } )
        return
    end
    if Value13 then
        Value13:Disconnect( )
        Value13 = nil
    end

    local Value2 = nil

    for Value3 in Table6, nil, nil do
        local Entry = Table6[ Value3 ]
        local Pulse = Value3:FindFirstChild( "Pulse" )

        if Entry then
            Entry:Cancel( )
            Table6[ Value3 ] = nil

            if Pulse then
                Pulse.Scale = 1
            end
        end
    end
    if ClientState.ActiveMenu == "G36Event" then
        ClientState.CursorFree = false
    end

    GamepadNav.Close( "G36Event" )
    return
end

Close.Activated:Connect( function()
    Callback( false )
end )

if G36EventButton then
    G36EventButton.Activated:Connect( function()
        Callback( not Flag )
    end )
end

local Value14 = nil

for Key6, Value15 in Table, nil, nil do
    local Steps2
    Value15.claim.Activated:Connect( function()
        if not ( Value7 and Value7.cfg ) then
            return
        end
        if Value15.stepBase > 0 then
            local Captured

            if Value7 then
                if type( Value7.c ) == "table" then
                    if Value7.c[ tostring( 3 ) ] == true then
                        Captured = true
                    else
                        Captured = false
                    end
                else
                    Captured = false
                end
            else
                Captured = Value7
            end
            if not Captured then
                Notify.Error( "Unlock the G36 first" )
                return
            end

            local I = 1

            for I = 1, 3 do
                if Claimable( Value15.stepBase + I ) then
                    G36EventQuest:FireServer( "claim", Value15.stepBase + I )
                    return
                end
            end

            local Captured2
            local Error = Notify.Error
            local StepBase = Value15.stepBase + 3

            if Value7 then
                if type( Value7.c ) == "table" then
                    if Value7.c[ tostring( StepBase ) ] == true then
                        Captured2 = true
                    else
                        Captured2 = false
                    end
                else
                    Captured2 = false
                end
            else
                Captured2 = Value7
            end

            local Text = not Captured2 and "Complete the challenges of this tier first" or "All camos unlocked: equip them in the Armory"
            Error( Text )
            return
        end
        local Captured3 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key6 ] else Value7 and Value7.cfg

        if not Captured3 then
            return
        end
        if Claimable( Key6 ) then
            G36EventQuest:FireServer( "claim", Key6 )
            return
        end
        if Captured3.step and Reached( Key6, ( Values( ) ) ) then
            Notify.Error( ( "Tier %d is completed" ):format( Key6 ) )
            return
        end

        local Captured4

        if Value7 then
            if type( Value7.c ) == "table" then
                if Value7.c[ tostring( Key6 ) ] == true then
                    Captured4 = true
                else
                    Captured4 = false
                end
            else
                Captured4 = false
            end
        else
            Captured4 = Value7
        end
        if Captured4 then
            local Error2 = Notify.Error
            local Captured5 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key6 ] else Value7 and Value7.cfg
            local Name = Captured5 and Captured5.name or "Tier " .. Key6
            Error2( ( "%s is already unlocked" ):format( Name ) )
            return
        end
        if Reached( Key6, ( Values( ) ) ) and Captured3.reward == nil then
            Notify.Error( "Bonus reward coming soon" )
            return
        end
        if Key6 > 1 and not Reached( Key6 - 1, ( Values( ) ) ) then
            Notify.Error( ( "Complete Tier %d first" ):format( Key6 - 1 ) )
            return
        end
        if Key6 > 1 then
            local Captured6 = Key6 - 1
            local Captured7 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Captured6 ] else Value7 and Value7.cfg
            local Flag

            if Captured7 then
                if Captured7.step then
                    Flag = Reached( Captured6, ( Values( ) ) )
                elseif Value7 then
                    if type( Value7.c ) == "table" then
                        if Value7.c[ tostring( Captured6 ) ] == true then
                            Flag = true
                        else
                            Flag = false
                        end
                    else
                        Flag = false
                    end
                else
                    Flag = Value7
                end
            else
                Flag = false
            end
            if not Flag then
                local Error3 = Notify.Error
                local Captured8 = Key6 - 1
                local Captured9 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Captured8 ] else Value7 and Value7.cfg
                local Name2 = Captured9 and Captured9.name or "Tier " .. Captured8
                Error3( ( "Claim the %s first" ):format( Name2 ) )
                return
            end
        end

        Notify.Error( "Complete the quests of this tier first" )
        return
    end )
    local Steps = Value15.steps
    Steps2 = if Steps then Steps else { }
    local Value16 = nil

    for Key7, Value17 in Steps2, nil, nil do
        local StepBase = Value15.stepBase + Key7
        Value17.Activated:Connect( function()
            if not ( Value7 and Value7.cfg ) then
                return
            end

            Value9 = StepBase
            local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ StepBase ] else Value7 and Value7.cfg

            if not Captured or not Captured.skin then
                Render( )
                return
            end

            local Captured2

            if Value7 then
                if type( Value7.c ) == "table" then
                    if Value7.c[ tostring( 3 ) ] == true then
                        Captured2 = true
                    else
                        Captured2 = false
                    end
                else
                    Captured2 = false
                end
            else
                Captured2 = Value7
            end
            if Captured2 then
                if Claimable( StepBase ) then
                    G36EventQuest:FireServer( "claim", StepBase )
                else
                    local Captured3

                    if Value7 then
                        if type( Value7.c ) == "table" then
                            if Value7.c[ tostring( StepBase ) ] == true then
                                Captured3 = true
                            else
                                Captured3 = false
                            end
                        else
                            Captured3 = false
                        end
                    else
                        Captured3 = Value7
                    end
                    if Captured3 then
                        local Label4
                        local Error2 = Notify.Error
                        local Label3 = Captured.label
                        Label4 = if Label3 then Label3 else Captured.skin
                        Error2( ( "%s camo already unlocked: equip it in the Armory" ):format( Label4 ) )
                    end
                end

                Render( )
                return
            end
            local Label2
            Render( )
            local Error = Notify.Error
            local Label = Captured.label
            Label2 = if Label then Label else Captured.skin
            Error( ( "%s camo: unlock the G36 first" ):format( Label2 ) )
            return
        end )
    end
end
if Phase1 then
    Phase1.Activated:Connect( function()
        Value8 = 1
        Value9 = nil
        Render( )
    end )
end
if Phase2 then
    Phase2.Activated:Connect( function()
        Value8 = 2
        Value9 = nil
        Value10 = nil
        Number = 0
        Render( )
    end )
end

local Tracker
local G36Tracker = PlayerGui:WaitForChild( "G36Tracker", 10 )

if G36Tracker then
    Tracker = G36Tracker:FindFirstChild( "Tracker" )
else
    Tracker = G36Tracker
end

local Panel

if Tracker then
    Panel = Tracker:FindFirstChild( "Panel" )
else
    Panel = Tracker
end

local G36Tracker2 = if Tracker then Tracker.Position else Tracker
local G36Tracker3 = if Tracker then Tracker.Size else Tracker
local FromScale = UDim2.fromScale( 0.02, 0 )

local function TrackPos()
    local Board
    local RedZoneHUD = PlayerGui:FindFirstChild( "RedZoneHUD" )

    if RedZoneHUD then
        Board = RedZoneHUD:FindFirstChild( "Board" )
    else
        Board = RedZoneHUD
    end

    local Y = G36Tracker.AbsoluteSize.Y

    if not Board or not Board.Visible or not ( Y > 0 ) then
        return G36Tracker2
    end

    local UDim23
    local Y2 = ( Board.AbsolutePosition.Y + Board.AbsoluteSize.Y - G36Tracker.AbsolutePosition.Y ) / Y + Tracker.Size.Y.Scale * Tracker.AnchorPoint.Y + 0.012

    if G36Tracker2.Y.Scale < Y2 then
        local UDim22 = UDim2.new( G36Tracker2.X, UDim.new( Y2, 0 ) )

        if UDim22 then
            UDim23 = UDim22
        else
            UDim23 = G36Tracker2
        end
    else
        UDim23 = G36Tracker2
    end

    return UDim23
end

task.spawn( function()
    local Value1
    local TableInner = { }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        table.insert( TableInner, Value.frame:FindFirstChild( "Icon" ) )
    end

    local Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        local J = 1

        for J = 1, 3 do
            local Attribute = Value3.frame:GetAttribute( "Img" .. J )

            if type( Attribute ) == "string" and Attribute ~= "" then
                table.insert( TableInner, Attribute )
            end
        end

        local Steps2
        local Steps = Value3.steps
        Steps2 = if Steps then Steps else { }
        local Value4 = nil

        for Key3, Value5 in Steps2, nil, nil do
            local Reward = Value5:FindFirstChild( "Reward" )

            if Reward then
                table.insert( TableInner, Reward )
            end
        end
    end

    pcall( function()
        game:GetService( "ContentProvider" ):PreloadAsync( TableInner )
    end )
end )
local Number4 = 0

local function Seq( ... )
    local Table = { }
    local Select = select( "#", ... )
    local I = 1

    for I = 1, Select do
        table.insert( Table, ColorSequenceKeypoint.new( ( I - 1 ) / ( Select - 1 ), ( select( I, ... ) ) ) )
    end

    return ColorSequence.new( Table )
end

local function TintTracker( Self )
    local UIGradient = Panel:FindFirstChildOfClass( "UIGradient" )

    if UIGradient then
        UIGradient.Color = Seq( Self:Lerp( Color32, 0.74 ), Self:Lerp( Color32, 0.91 ), Color3.fromRGB( 8, 8, 8 ), Self:Lerp( Color32, 0.91 ), Self:Lerp( Color32, 0.75 ) )
    end

    local UIGradient2 = Panel.Title:FindFirstChildOfClass( "UIGradient" )

    if UIGradient2 then
        UIGradient2.Color = Seq( Self:Lerp( Color32, 0.4 ), Self:Lerp( Color33, 0.15 ), Self:Lerp( Color33, 0.45 ), Self:Lerp( Color33, 0.15 ), Self:Lerp( Color32, 0.4 ) )
    end

    local UIGradient3 = Panel.Badge:FindFirstChildOfClass( "UIGradient" )

    if UIGradient3 then
        UIGradient3.Color = Seq( Self:Lerp( Color32, 0.45 ), Self:Lerp( Color32, 0.75 ) )
    end

    local UIGradient4 = Panel.Bar.Fill:FindFirstChildOfClass( "UIGradient" )

    if UIGradient4 then
        UIGradient4.Color = Seq( Self:Lerp( Color32, 0.45 ), Self:Lerp( Color33, 0.3 ) )
    end
end

local function HideTracker( Argument1 )
    if Argument1 == Number4 then
        local Create = TweenService:Create( Tracker, TweenInfo.new( 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), { GroupTransparency = 1, Position = Tracker.Position - FromScale } )
        Create.Completed:Connect( function()
            if Argument1 == Number4 then
                Tracker.Visible = false
            end
        end )
        Create:Play( )
        return
    end
    return
end

local function ShowTracker( TextInner, Text2, Amount, Amount2, Self, Argument6, Duration )
    local Size
    Number4 = Number4 + 1

    if Text == "phone" then
        local FromScaleInner = UDim2.fromScale( G36Tracker3.X.Scale * 1.36, G36Tracker3.Y.Scale * 1.36 )

        if FromScaleInner then
            Size = FromScaleInner
        else
            Size = G36Tracker3
        end
    else
        Size = G36Tracker3
    end

    local ImageColor3
    Tracker.Size = Size
    local TrackPos2 = TrackPos( )
    Panel.Title.Text = TextInner
    Panel.Bar.Amount.Text = Text2
    local Icon = Panel.Badge.Icon
    Icon.Image = Argument6.icon or ""
    local Icon2 = Panel.Badge.Icon
    local IconColor = Argument6.iconColor
    ImageColor3 = if IconColor then IconColor else Color33
    Icon2.ImageColor3 = ImageColor3
    TintTracker( Self )
    local Fill = Panel.Bar.Fill

    if not Tracker.Visible then
        local Max2
        Tracker.Visible = true
        Tracker.GroupTransparency = 1
        Tracker.Position = TrackPos2 - FromScale

        if Amount > 0 then
            local Max = math.max( Amount, 0.02 )

            if Max then
                Max2 = Max
            else
                Max2 = 0
            end
        else
            Max2 = 0
        end

        Fill.Size = UDim2.fromScale( Max2, 1 )
    end

    local Max4
    TweenService:Create( Tracker, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { GroupTransparency = 0, Position = TrackPos2 } ):Play( )
    local TweenInfo2 = TweenInfo.new( 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
    local Table = { }

    if Amount2 > 0 then
        local Max3 = math.max( Amount2, 0.02 )

        if Max3 then
            Max4 = Max3
        else
            Max4 = 0
        end
    else
        Max4 = 0
    end

    Table.Size = UDim2.fromScale( Max4, 1 )
    TweenService:Create( Fill, TweenInfo2, Table ):Play( )
    task.delay( Duration, HideTracker, Number4 )
end

local function TrackProgress( List, ProgressName )
    if Tracker and Panel and ProgressName and not Flag then
        local FlagInner

        if ClientState.WardrobeOpen == true then
            FlagInner = true
        elseif ClientState.BetaReveal == true then
            FlagInner = true
        elseif ClientState.Downed == true then
            FlagInner = true
        elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            FlagInner = true
        else
            FlagInner = false
        end
        if not FlagInner and LocalPlayer:GetAttribute( "InTutorial" ) ~= true then
            local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ ProgressName ] else Value7 and Value7.cfg

            if not Captured then
                return
            end

            local Value2, Value3
            local Values2 = Values( )
            local Goals = Captured.goals
            Value2 = nil
            Value3 = nil

            for Key, Value in Goals, nil, nil do
                local Entry7 = Values2[ Key ] or 0

                if ( List[ Key ] or 0 ) < Entry7 then
                    local Number6
                    local Entry8 = List[ Key ] or 0

                    if type( Captured.base ) == "table" then
                        local Number5 = tonumber( Captured.base[ Key ] )

                        if Number5 then
                            Number6 = Number5
                        else
                            Number6 = 0
                        end
                    else
                        Number6 = 0
                    end

                    local Entry9 = Entry8 - Number6

                    if math.clamp( Entry9, 0, Captured.goals[ Key ] or 0 ) < Value and Table2[ Key ] then
                        local Number8
                        local Entry10 = Values2[ Key ] or 0

                        if type( Captured.base ) == "table" then
                            local Number7 = tonumber( Captured.base[ Key ] )

                            if Number7 then
                                Number8 = Number7
                            else
                                Number8 = 0
                            end
                        else
                            Number8 = 0
                        end

                        local Entry11 = Entry10 - Number8
                        local Clamp4 = math.clamp( Entry11, 0, Captured.goals[ Key ] or 0 )

                        if Key ~= "time" or Value <= Clamp4 or Clamp4 % 15 == 0 then
                            Value3 = Key
                        end
                    end
                end
            end
            if not Value3 then
                return
            end

            local Number2
            local Entry = Captured.goals[ Value3 ]
            local Entry2 = Table2[ Value3 ]
            local Entry3 = Values2[ Value3 ] or 0

            if type( Captured.base ) == "table" then
                local Number = tonumber( Captured.base[ Value3 ] )

                if Number then
                    Number2 = Number
                else
                    Number2 = 0
                end
            else
                Number2 = 0
            end

            local Number4
            local Entry4 = Entry3 - Number2
            local Clamp = math.clamp( Entry4, 0, Captured.goals[ Value3 ] or 0 )
            local Entry5 = List[ Value3 ] or 0

            if type( Captured.base ) == "table" then
                local Number3 = tonumber( Captured.base[ Value3 ] )

                if Number3 then
                    Number4 = Number3
                else
                    Number4 = 0
                end
            else
                Number4 = 0
            end

            local Entry6 = Entry5 - Number4
            local Clamp2 = math.clamp( Entry6, 0, Captured.goals[ Value3 ] or 0 ) / math.max( Entry, 1 )

            if Reached( ProgressName, Values2 ) then
                local Text

                if Captured.step then
                    if Captured.skin then
                        Text = "Claim your camo in Event"
                    else
                        local Format = ( "Tier %d unlocked" ):format( ProgressName + 1 )

                        if Format then
                            Text = Format
                        elseif Captured.reward then
                            Text = "Claim it in Event"
                        else
                            Text = "Bonus reward coming soon"
                        end
                    end
                elseif Captured.reward then
                    Text = "Claim it in Event"
                else
                    Text = "Bonus reward coming soon"
                end

                local Format4

                if Captured.skin then
                    local Label2
                    local Label = Captured.label
                    Label2 = if Label then Label else Captured.name
                    local Format2 = ( "%s UNLOCKED!" ):format( Label2:upper( ) )

                    if Format2 then
                        Format4 = Format2
                    elseif not Captured.step or not ( "TIER %d COMPLETE!" ):format( ProgressName ) then
                        if Captured.reward then
                            local Format3 = ( "%s UNLOCKED!" ):format( Captured.name:upper( ) )

                            if Format3 then
                                Format4 = Format3
                            else
                                Format4 = "BONUS COMPLETE!"
                            end
                        else
                            Format4 = "BONUS COMPLETE!"
                        end
                    else
                        Format4 = ( "TIER %d COMPLETE!" ):format( ProgressName )
                    end
                elseif not Captured.step or not ( "TIER %d COMPLETE!" ):format( ProgressName ) then
                    if Captured.reward then
                        local Format3 = ( "%s UNLOCKED!" ):format( Captured.name:upper( ) )

                        if Format3 then
                            Format4 = Format3
                        else
                            Format4 = "BONUS COMPLETE!"
                        end
                    else
                        Format4 = "BONUS COMPLETE!"
                    end
                else
                    Format4 = ( "TIER %d COMPLETE!" ):format( ProgressName )
                end

                ShowTracker( Format4, Text, Clamp2, 1, FromRGB4, Entry2, 5 )
                return
            end
            if Entry <= Clamp then
                ShowTracker( Entry2.title:upper( ), "Completed!", Clamp2, 1, FromRGB4, Entry2, 3.5 )
                return
            end

            local Format5
            local Upper = Entry2.title:upper( )

            if Value3 == "time" then
                local Floor = math.floor( tonumber( Clamp ) or 0 )
                Format5 = ( "%dh%02d" ):format( Floor // 60, Floor % 60 )
            else
                Format5 = Num( Clamp )
            end

            local Color
            local Format6 = ( "%s / %s" ):format( Format5, Fmt( Value3, Entry ) )
            local Clamp3 = Clamp / math.max( Entry, 1 )
            local Item = Table[ 4 ]

            if not ( ProgressName > 3 ) or not Item or not ( Item.stepBase > 0 ) then
                if Table[ ProgressName ] then
                    local Color2 = Table[ ProgressName ].color

                    if Color2 then
                        Color = Color2
                    else
                        Color = FromRGB2
                    end
                else
                    Color = FromRGB2
                end
            else
                local Attribute = Item.frame:GetAttribute( "Col" .. ProgressName - Item.stepBase )

                if Attribute then
                    Color = Attribute
                else
                    Color = Item.color
                end
            end

            ShowTracker( Upper, Format6, Clamp2, Clamp3, Color, Entry2, 3.5 )
            return
        end
    end
end

local Table11 = {
    full = "Inventory full: free a slot, then claim again",
    loading = "Your inventory is still loading, try again in a moment",
    soon = "Bonus reward coming soon",
    error = "Could not claim right now, try again"
}
G36EventQuest.OnClientEvent:Connect( function( Name, Key )
    if Name ~= "state" or type( Key ) ~= "table" then
        if Name ~= "claimed" or type( Key ) ~= "number" then
            if Name == "msg" and type( Key ) == "string" then
                Notify.Error( Table11[ Key ] or "Could not claim right now, try again" )
            end
        else
            local Captured = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key ] else Value7 and Value7.cfg

            if not Captured or not Captured.skin then
                local Announce2 = Notify.Announce
                local Captured2 = if Value7 and Value7.cfg then ( Value7 and Value7.cfg ).tiers[ Key ] else Value7 and Value7.cfg
                local Name2 = Captured2 and Captured2.name or "Tier " .. Key
                Announce2( Name2:upper( ), "Unlocked! Added to your inventory", 5 )
                return
            end
            local Label2
            local Announce = Notify.Announce
            local Label = Captured.label
            Label2 = if Label then Label else Captured.skin
            Announce( Label2:upper( ), "Camo unlocked! Equip it in the Armory", 5 )
            return
        end
    else
        local FlagInner = Value7 == nil and true or false
        local Value2

        if FlagInner then
            Value2 = nil
        else
            local Values2 = Values( )

            if Values2 then
                Value2 = Values2
            else
                Value2 = nil
            end
        end

        local Value3 = if Value2 then ActiveTier( Value2 ) else Value2
        Value7 = Key
        Render( )

        if Flag then
            UpdateCountdown( )
        end
        if Value2 then
            TrackProgress( Value2, Value3 )
            return
        end
    end
end )
G36EventQuest:FireServer( "get" )
