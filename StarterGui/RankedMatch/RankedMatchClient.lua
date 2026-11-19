-- StarterGui.RankedMatch.RankedMatchClient
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
local UserInputService = game:GetService( "UserInputService" )
local HttpService = game:GetService( "HttpService" )
local Parent = script.Parent
local LocalPlayer = Players.LocalPlayer

if not Parent:IsDescendantOf( LocalPlayer ) then
    return
end
if not workspace:GetAttribute( "RankedMatch" ) then
    Parent.Enabled = false

    if not RunService:IsStudio( ) then
        return
    end
    while not workspace:GetAttribute( "RankedMatch" ) do
        workspace:GetAttributeChangedSignal( "RankedMatch" ):Wait( )
    end
end

local Parent2 = Parent.Parent

if Parent2 and Parent2:GetAttribute( "RankedSpectator" ) then
    Parent.Enabled = false
    return
end
if Parent2 then
    Parent2:GetAttributeChangedSignal( "RankedSpectator" ):Connect( function()
        if Parent2:GetAttribute( "RankedSpectator" ) then
            Parent.Enabled = false
            script.Disabled = true
        end
    end )
end

local Value1
local RankedShared = ReplicatedStorage:WaitForChild( "RankedShared" )
local Config = require( RankedShared:WaitForChild( "Config" ) )
local MatchState = RankedShared:WaitForChild( "MatchState" )
local Remotes = RankedShared:WaitForChild( "Remotes" )
local MatchEvent = Remotes:WaitForChild( "MatchEvent" )
local MatchFn = Remotes:WaitForChild( "MatchFn" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Score = Parent.Score
local Statut = Parent.Statut
local Annonce = Parent.Annonce
local Ban = Parent.Ban
local Resultats = Parent.Resultats
local Spectateur = Parent.Spectateur
local Templates = Parent.Templates
local Sfx = require( RankedShared:WaitForChild( "Sfx" ) )
Sfx.Preload( )
local Table = {
    base = setmetatable( { }, { __mode = "k" } ),
    home = setmetatable( { }, { __mode = "k" } ),
    shk = setmetatable( { }, { __mode = "k" } ),
    annSize = Annonce.Size
}
function Table.punch( Key, Argument2, Amount, Argument4 )
    if not Key then
        return
    end

    local Entry2
    local Entry = Table.base[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local Scale = Key.Scale
        Table.base[ Key ] = Scale
        Entry2 = Scale
    end

    Key.Scale = Entry2 * Argument2
    local Number = Amount or 0.35
    TweenService:Create( Key, TweenInfo.new( Number, Argument4 or Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = Entry2 } ):Play( )
end
function Table.shake( Key, Argument2, Dur )
    if not Key or not Key.Parent then
        return
    end

    local Entry = Table.shk[ Key ]

    if Entry then
        local T0 = os.clock( )
        local Amp = math.max( Argument2, Entry.amp )
        Entry.t0 = T0
        Entry.amp = Amp
        Entry.dur = Dur
        return
    end
    local TableInner = { base = Key.Position, t0 = os.clock( ), amp = Argument2, dur = Dur }
    Table.shk[ Key ] = TableInner
    task.spawn( function()
        while Key.Parent do
            local Clock = ( os.clock( ) - TableInner.t0 ) / TableInner.dur

            if Clock >= 1 then
                break
            end

            local X2
            local Parent = Key.Parent

            if not Parent:IsA( "GuiBase2d" ) or not ( Parent.AbsoluteSize.Y > 0 ) then
                X2 = 1
            else
                local X = Parent.AbsoluteSize.X / Parent.AbsoluteSize.Y

                if X then
                    X2 = X
                else
                    X2 = 1
                end
            end

            local Amp = TableInner.amp * ( 1 - Clock ) ^ 2
            local Base = TableInner.base
            Key.Position = UDim2.new( Base.X.Scale + ( math.random( ) * 2 - 1 ) * Amp, Base.X.Offset, Base.Y.Scale + ( math.random( ) * 2 - 1 ) * Amp * X2, Base.Y.Offset )
            RunService.RenderStepped:Wait( )
        end

        Key.Position = TableInner.base
        Table.shk[ Key ] = nil
    end )
    return
end
function Table.slide( Key, Argument2, Argument3, Amount, Argument5 )
    if not Key then
        return
    end

    local Position2
    local Position = Key.Position

    if Argument5 then
        local Entry = Table.home[ Key ] or Position
        Table.home[ Key ] = Entry
        Position2 = Entry
    else
        Position2 = Position
    end

    Key.Position = UDim2.new( Position2.X.Scale + Argument2, Position2.X.Offset, Position2.Y.Scale + Argument3, Position2.Y.Offset )
    TweenService:Create( Key, TweenInfo.new( Amount or 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out ), { Position = Position2 } ):Play( )
end
function Table.grad( Object, Argument2 )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            local Enabled = Value.Name == Argument2 and true or false
            Value.Enabled = Enabled
        end
    end
end
function Table.flash( Argument1, Argument2, BackgroundTransparency, Amount )
    if Argument1 then
        Table.grad( Argument1, Argument2 )
        Argument1.Visible = true
        Argument1.BackgroundTransparency = BackgroundTransparency
        TweenService:Create( Argument1, TweenInfo.new( Amount or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { BackgroundTransparency = 1 } ):Play( )
        return
    end
    return
end
function Table.ring( Object, Argument2, Amount, Amount2 )
    local UIStroke

    if Object then
        UIStroke = Object:FindFirstChildOfClass( "UIStroke" )
    else
        UIStroke = Object
    end

    local Pop

    if Object then
        Pop = Object:FindFirstChild( "Pop" )
    else
        Pop = Object
    end
    if not UIStroke or not Pop then
        return
    end
    Table.grad( UIStroke, Argument2 )
    Object.Visible = true
    Pop.Scale = 0.9
    UIStroke.Transparency = 0
    TweenService:Create( Pop, TweenInfo.new( Amount2 or 0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out ), { Scale = Amount or 1.5 } ):Play( )
    TweenService:Create( UIStroke, TweenInfo.new( Amount2 or 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), { Transparency = 1 } ):Play( )
    return
end
local Table2 = { Moi = Parent.ListeMoi, Adv = Parent.ListeAdv }
local Flag = true

local function ShowBoard( Visible )
    local Value1
    Flag = Visible
    Score.Visible = Visible
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        Value.Visible = Visible
    end
end

local Table3 = { Ban.Cartes, Score.PipsMoi, Score.PipsAdv, Table2.Moi, Table2.Adv }
Value1 = nil

for Key, Value in Table3, nil, nil do
    for Key16, Value43 in Value:GetChildren( ) do
        if Value43:IsA( "GuiObject" ) and Value43.Name ~= "Entete" and Value43.Name ~= "EnteteClan" then
            Value43:Destroy( )
        end
    end
end

local function HideOwnTag( Object )
    local NameTag = Object:WaitForChild( "NameTag", 15 )

    if NameTag and NameTag:IsA( "BillboardGui" ) then
        NameTag.Enabled = false
    end
end

LocalPlayer.CharacterAdded:Connect( HideOwnTag )

if LocalPlayer.Character then
    task.spawn( HideOwnTag, LocalPlayer.Character )
end

local Value2
local Table4 = { Annonce, Ban, Resultats, Spectateur }
Value2 = nil

for Key2, Value3 in Table4, nil, nil do
    Value3.Visible = false
end

local Value4
Parent.Enabled = true
task.spawn( function()
    local Clock = os.clock( )

    while LocalPlayer:GetAttribute( "LoadingReady" ) ~= true do
        if not ( os.clock( ) - Clock < 60 ) then
            break
        end

        task.wait( 0.2 )
    end

    MatchEvent:FireServer( "ready" )
end )
local Flag2 = false
UserInputService.InputBegan:Connect( function()
    Flag2 = true
end )
UserInputService.InputChanged:Connect( function( Argument1 )
    local UserInputType = Argument1.UserInputType

    if UserInputType == Enum.UserInputType.MouseMovement or UserInputType == Enum.UserInputType.Touch or UserInputType.Name:sub( 1, 7 ) == "Gamepad" then
        Flag2 = true
    end
end )
task.spawn( function()
    while Parent.Parent do
        task.wait( 2 )

        if Flag2 then
            Flag2 = false
            MatchEvent:FireServer( "active" )
        end
    end
end )
local Table5 = {
    "HUDButtons",
    "Shop",
    "Cases",
    "CasesFX",
    "Armory",
    "BetaRoll",
    "Beta",
    "Clan",
    "Crew",
    "StarterOffer",
    "SafeReminder",
    "UpdateLog",
    "MK14Event",
    "MK14Tracker",
    "G36Event",
    "G36Tracker",
    "RedZoneHUD",
    "RankedHub",
    "RankedModes",
    "Fishing",
    "ItemShop",
    "Stash",
    "Pawn",
    "ATM",
    "Repair",
    "CommunityPack",
    "VehicleLock",
    "VehicleRepair",
    "CashBagUse",
    "TutorialGui",
    "DeathScreen",
    "LootGui",
    "LevelUp",
    "MythicReveal"
}
local Table6 = { }
Value4 = nil

for Key3, Value5 in Table5, nil, nil do
    Table6[ Value5 ] = true
end

local Table7 = { }

local function Hold( Key )
    if not Key:IsA( "ScreenGui" ) or not Table6[ Key.Name ] or Key:GetAttribute( "RankedHidden" ) then
        return
    end
    Key:SetAttribute( "RankedHidden", true )
    local Enabled = Key.Enabled
    Key.Enabled = false
    Table7[ Key ] = {
        was = Enabled,
        conn = Key:GetPropertyChangedSignal( "Enabled" ):Connect( function()
            if Key.Enabled then
                Key.Enabled = false
            end
        end )
    }
    return
end

local function ReleaseHeld()
    local Value1 = nil

    for Key, Value in Table7, nil, nil do
        Value.conn:Disconnect( )

        if Key.Parent then
            Key:SetAttribute( "RankedHidden", nil )
            Key.Enabled = Value.was
        end
    end

    table.clear( Table7 )
end

local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )

for Key4, Value6 in PlayerGui:GetChildren( ) do
    Hold( Value6 )
end

PlayerGui.ChildAdded:Connect( Hold )
local Value7 = nil

local function HideOthers( Argument1 )
    if not Argument1 then
        if Value7 then
            Value7:Disconnect( )
            Value7 = nil
        end
        for Key2, Value2 in PlayerGui:GetChildren( ) do
            local RankedResultsHide = Value2:FindFirstChild( "RankedResultsHide" )

            if RankedResultsHide then
                RankedResultsHide:Destroy( )
            end
        end

        return
    end
    local function One( ParentInner )
        if ParentInner:IsA( "ScreenGui" ) and ParentInner ~= Parent and ParentInner.Name ~= "RankedVictoryScene" and ParentInner.Name ~= "RankedVictoryTuning" and ParentInner.Name ~= "Gamepad" and ParentInner.Name ~= "GamepadSelection" and ParentInner.Name ~= "GamepadHints" and not ParentInner:FindFirstChild( "RankedResultsHide" ) then
            local UIScale = Instance.new( "UIScale" )
            UIScale.Name = "RankedResultsHide"
            UIScale.Scale = 0
            UIScale.Parent = ParentInner
        end
    end

    for Key, Value in PlayerGui:GetChildren( ) do
        One( Value )
    end
    if Value7 then
        return
    end
    Value7 = PlayerGui.ChildAdded:Connect( One )
    return
end

local function A( Attribute )
    return MatchState:GetAttribute( Attribute )
end

local function MyTeam()
    return LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
end

local function OtherTeam( TeamName )
    if TeamName == "A" then
        return "B"
    end
    return "A"
end

local function TimeLeft()
    local PhaseEnd = MatchState:GetAttribute( "PhaseEnd" )

    if type( PhaseEnd ) ~= "number" or PhaseEnd <= 0 then
        return nil
    end
    return ( math.max( 0, PhaseEnd - workspace:GetServerTimeNow( ) ) )
end

local function WaitLeft()
    local WaitUntil = MatchState:GetAttribute( "WaitUntil" )

    if type( WaitUntil ) == "number" then
        return ( math.max( 0, WaitUntil - workspace:GetServerTimeNow( ) ) )
    end
    return nil
end

local function Decode( Name )
    local Result2
    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, Name or "[]" )
    Result2 = Success and type( Result ) == "table" and Result or { }
    return Result2
end

local function SetGrad( Object, Argument2 )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            local Enabled = Value.Name == Argument2 and true or false
            Value.Enabled = Enabled
        end
    end
end

local function Lift( Self, Argument2 )
    local ZBase2
    local ZBase = Self:GetAttribute( "ZBase" )

    if ZBase == nil then
        local ZIndex = Self.ZIndex
        Self:SetAttribute( "ZBase", ZIndex )
        ZBase2 = ZIndex
    else
        ZBase2 = ZBase
    end

    local ZIndex2 = ZBase2 + Argument2

    if Self.ZIndex ~= ZIndex2 then
        Self.ZIndex = ZIndex2
    end
end

local Table8 = { }

local function Open( Key )
    if Key.Visible then
        return
    end

    Key.Visible = true
    local UIScale = Key:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        if Table8[ Key ] then
            Table8[ Key ]:Cancel( )
        end

        UIScale.Scale = 0.92
        Table8[ Key ] = TweenService:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
        Table8[ Key ]:Play( )
    end
end

local function Fmt( Text )
    return ( tostring( ( math.floor( ( tonumber( Text ) or 0 ) + 0.5 ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( ):gsub( "^,", "" ) )
end

local function NameOf( Amount )
    local Value1
    local Table = { "A", "B" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Result2
        local Attribute = MatchState:GetAttribute( "Team" .. Value )
        local JSONDecode = HttpService.JSONDecode
        local Success, Result = pcall( JSONDecode, HttpService, Attribute or "[]" )
        Result2 = Success and type( Result ) == "table" and Result or { }
        local Value2 = nil

        for Key2, Value3 in Result2, nil, nil do
            if Value3.id == Amount then
                return Value3.name
            end
        end
    end

    local DisplayName
    local PlayerByUserId = Players:GetPlayerByUserId( Amount or 0 )
    DisplayName = PlayerByUserId and PlayerByUserId.DisplayName or "-"
    return DisplayName
end

local Flag3 = false

local function WantCursor( Argument1 )
    if Argument1 then
        ClientState.ActiveMenu = "RankedMatch"

        if not ClientState.CursorFree then
            ClientState.CursorFree = true
        end

        Flag3 = true
        return
    end
    if Flag3 then
        Flag3 = false

        if ClientState.ActiveMenu == "RankedMatch" then
            ClientState.ActiveMenu = nil
            ClientState.CursorFree = false
        end
    end

    return
end

local Position = Score.Position

local function PlaceScore()
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        if CurrentCamera.ViewportSize.X > 0 then
            if CurrentCamera.ViewportSize.X < 1000 then
                CurrentCamera2 = true
            else
                CurrentCamera2 = false
            end
        else
            CurrentCamera2 = false
        end
    else
        CurrentCamera2 = CurrentCamera
    end

    local PositionInner

    if CurrentCamera2 then
        local FromScale = UDim2.fromScale( Position.X.Scale, 0.135 )

        if FromScale then
            PositionInner = FromScale
        else
            PositionInner = Position
        end
    else
        PositionInner = Position
    end

    Score.Position = PositionInner
end

local Connect = nil

local function WatchScoreCam()
    if Connect then
        Connect:Disconnect( )
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        Connect = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( PlaceScore )
    end

    local CurrentCamera3
    local CurrentCamera2 = workspace.CurrentCamera

    if CurrentCamera2 then
        if CurrentCamera2.ViewportSize.X > 0 then
            if CurrentCamera2.ViewportSize.X < 1000 then
                CurrentCamera3 = true
            else
                CurrentCamera3 = false
            end
        else
            CurrentCamera3 = false
        end
    else
        CurrentCamera3 = CurrentCamera2
    end

    local PositionInner

    if CurrentCamera3 then
        local FromScale = UDim2.fromScale( Position.X.Scale, 0.135 )

        if FromScale then
            PositionInner = FromScale
        else
            PositionInner = Position
        end
    else
        PositionInner = Position
    end

    Score.Position = PositionInner
end

workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( WatchScoreCam )

if Connect then
    Connect:Disconnect( )
end

local CurrentCamera = workspace.CurrentCamera

if CurrentCamera then
    Connect = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( PlaceScore )
end

local CurrentCamera3
local CurrentCamera2 = workspace.CurrentCamera

if CurrentCamera2 then
    if CurrentCamera2.ViewportSize.X > 0 then
        if CurrentCamera2.ViewportSize.X < 1000 then
            CurrentCamera3 = true
        else
            CurrentCamera3 = false
        end
    else
        CurrentCamera3 = false
    end
else
    CurrentCamera3 = CurrentCamera2
end

local Position2

if CurrentCamera3 then
    local FromScale = UDim2.fromScale( Position.X.Scale, 0.135 )

    if FromScale then
        Position2 = FromScale
    else
        Position2 = Position
    end
else
    Position2 = Position
end

local Value16
Score.Position = Position2
local Table9 = { Moi = { }, Adv = { } }

local function BuildPips()
    local Number2
    local Number = tonumber( A( "WinRounds" ) )
    Number2 = if Number then Number else Config.WinRounds
    local Value1 = nil

    for Key, Value in Table9, nil, nil do
        local Value2 = nil

        for Key2, Value3 in Value, nil, nil do
            Value3:Destroy( )
        end

        table.clear( Value )
        local J = 1

        for J = 1, Number2 do
            local Clone = Templates.Pip:Clone( )
            Clone.Name = "Pip" .. J
            Clone.LayoutOrder = J
            Clone.Parent = Score[ "Pips" .. Key ]
            Value[ J ] = Clone
        end
    end

    local Objectif = Score.Centre.Objectif
    Objectif.Text = "FIRST TO " .. Number2
end

local function RenderScore()
    local Text
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
    local Sm = tonumber( A( "Score" .. RankedTeam ) ) or 0
    Text = RankedTeam ~= "A" and "A" or "B"
    local Value1
    local St = tonumber( A( "Score" .. Text ) ) or 0
    local Points = Score.MonEquipe.Points
    Points.Text = tostring( Sm )
    local Points2 = Score.Adverse.Points
    Points2.Text = tostring( St )
    local Manche = Score.Centre.Manche
    Manche.Text = "ROUND " .. math.max( 1, tonumber( A( "Round" ) ) or 1 )
    local Moi = Table9.Moi
    Value1 = nil

    for Key, Value in Moi, nil, nil do
        local Text3 = not ( Key <= Sm ) and "Vide" or "PleinMoi"
        SetGrad( Value, Text3 )
    end

    local Value2
    local Adv = Table9.Adv
    Value2 = nil

    for Key2, Value3 in Adv, nil, nil do
        local Text2 = not ( Key2 <= St ) and "Vide" or "PleinAdv"
        SetGrad( Value3, Text2 )
    end
    if Table.sm and Table.sm < Sm then
        local Punch = Table.punch
        Punch( Score.MonEquipe.Points:FindFirstChild( "Pop" ), 1.8, 0.45 )
    end
    if Table.st and Table.st < St then
        local Punch2 = Table.punch
        Punch2( Score.Adverse.Points:FindFirstChild( "Pop" ), 1.8, 0.45 )
    end

    Table.sm = Sm
    Table.st = St
end

local Value8 = nil

local function RenderClock()
    local Centre = Score.Centre
    local Chrono = Centre:FindFirstChild( "Chrono" )

    if not Chrono then
        return
    end

    local Max
    local WaitUntil = MatchState:GetAttribute( "WaitUntil" )

    if type( WaitUntil ) == "number" then
        Max = math.max( 0, WaitUntil - workspace:GetServerTimeNow( ) )
    else
        Max = nil
    end

    local Max2

    if Max then
        Max2 = Max
    elseif MatchState:GetAttribute( "Phase" ) ~= "fight" or not ( ( tonumber( Config.RoundTime ) or 0 ) > 0 ) then
        Max2 = nil
    else
        local PhaseEnd = MatchState:GetAttribute( "PhaseEnd" )

        if type( PhaseEnd ) ~= "number" or PhaseEnd <= 0 then
            Max2 = nil
        else
            Max2 = math.max( 0, PhaseEnd - workspace:GetServerTimeNow( ) )
        end
        if not Max2 then
            Max2 = nil
        end
    end

    local Ceil

    if Max2 then
        Ceil = math.ceil( Max2 )
    else
        Ceil = Max2
    end

    local Text3

    if Ceil then
        local Text = not Max and "" or "w"
        local Text2 = Text .. tostring( Ceil )

        if Text2 then
            Text3 = Text2
        else
            Text3 = "off"
        end
    else
        Text3 = "off"
    end
    if Text3 == Value8 then
        return
    end

    local Visible
    Value8 = Text3
    Visible = Ceil ~= nil and true or false
    local Visible2
    Chrono.Visible = Visible
    local Manche = Centre.Manche
    Visible2 = Ceil == nil and true or false
    local Text5
    Manche.Visible = Visible2

    if Ceil then
        if Max then
            Text5 = "WAITING"
        else
            local Text4 = "ROUND " .. math.max( 1, tonumber( A( "Round" ) ) or 1 )

            if Text4 then
                Text5 = Text4
            else
                local Number = tonumber( A( "WinRounds" ) )

                if Number then
                    Number2 = Number
                else
                    Number2 = Config.WinRounds
                end

                Text5 = "FIRST TO " .. Number2
            end
        end
    else
        local Number2
        local Number = tonumber( A( "WinRounds" ) )

        if Number then
            Number2 = Number
        else
            Number2 = Config.WinRounds
        end

        Text5 = "FIRST TO " .. Number2
    end
    if Centre.Objectif.Text ~= Text5 then
        Centre.Objectif.Text = Text5
    end
    if Ceil then
        local Text6
        Chrono.Text = ( "%d:%02d" ):format( Ceil // 60, Ceil % 60 )
        Text6 = not ( Ceil <= 30 ) and "Normal" or "Urgent"
        SetGrad( Chrono, Text6 )
    end
end

local function Headshot( Argument1 )
    return ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Argument1 )
end

local ClanShared = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ClanShared" ) )
local CollectionService = game:GetService( "CollectionService" )
local Badges = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "RankedShared" ):WaitForChild( "Badges" ) )
local Class = setmetatable( { }, { __mode = "k" } )

local function Shine( Object, Visible, TextColor3 )
    if not Object then
        return
    end

    Object.Visible = Visible

    if TextColor3 then
        Object.TextColor3 = TextColor3
    end

    local Brillance = Object:FindFirstChild( "Brillance" )

    if Brillance then
        if Visible then
            CollectionService:AddTag( Brillance, "VipName" )
            return
        end

        CollectionService:RemoveTag( Brillance, "VipName" )
    end
end

local Table10 = {
    place = function( Self )
        local Nom = Self:FindFirstChild( "Nom" )
        local Tag = Self:FindFirstChild( "Tag" )

        if not Nom then
            return
        end

        local NomX2
        local NomX = Self:GetAttribute( "NomX" )
        local NomW = Self:GetAttribute( "NomW" )

        if NomX then
            NomX2 = NomX
        else
            local Scale = Nom.Position.X.Scale
            local Scale2 = Nom.Size.X.Scale
            Self:SetAttribute( "NomX", Scale )
            Self:SetAttribute( "NomW", Scale2 )
            NomW = Scale2
            NomX2 = Scale
        end

        local Number = if not Tag or not Tag.Visible or not ( Self.AbsoluteSize.X > 0 ) or not ( Tag.TextBounds.X > 0 ) then 0 else ( Tag.TextBounds.X + Tag.AbsoluteSize.Y * 0.28 ) / Self.AbsoluteSize.X
        local X3
        local Badge = Self:FindFirstChild( "Badge" )
        local X = Self.AbsoluteSize.X

        if not Badge or not Badge.Visible or not ( X > 0 ) then
            X3 = 0
        else
            local X2 = ( Badge.AbsoluteSize.X + Self.AbsoluteSize.Y * 0.12 ) / X

            if X2 then
                X3 = X2
            else
                X3 = 0
            end
        end

        local Max = math.max( 0.05, NomW - Number - X3 )
        Nom.Position = UDim2.fromScale( NomX2 + Number, Nom.Position.Y.Scale )
        Nom.Size = UDim2.fromScale( Max, Nom.Size.Y.Scale )

        if Badge and Badge.Visible and X > 0 then
            local Min = math.min( Nom.TextBounds.X / X, Max )
            Badge.Position = UDim2.fromScale( NomX2 + Number + Min + Self.AbsoluteSize.Y * 0.12 / X, Badge.Position.Y.Scale )
        end
    end
}
function Table10.paint( Object, Argument2 )
    local Enabled
    local Nom = Object.Nom
    local Tag = Object:FindFirstChild( "Tag" )
    local Text = tostring( Argument2.name or "?" )
    Nom.Text = Text
    Enabled = Argument2.dev == true and true or false
    local Flag = Argument2.vip == true and true or false
    local Vip = Nom:FindFirstChild( "Vip" )
    local Dev = Nom:FindFirstChild( "Dev" )

    if Vip then
        local Enabled2 = if Flag then not Enabled else Flag
        Vip.Enabled = Enabled2
    end
    if Dev then
        Dev.Enabled = Enabled
    end

    local VipStroke = Nom:FindFirstChild( "VipStroke" )

    if VipStroke then
        VipStroke.Enabled = Enabled or Flag
    end

    local Reflet = Nom:FindFirstChild( "Reflet" )

    if Reflet then
        local Dev2
        Reflet.Text = Text
        Dev2 = Enabled and Dev or Vip
        local RefletColor

        if Dev2 then
            RefletColor = Dev2:GetAttribute( "RefletColor" )
        else
            RefletColor = Dev2
        end

        local TextColor3
        local Visible = Enabled or Flag

        if typeof( RefletColor ) ~= "Color3" or not RefletColor then
            TextColor3 = Color3.new( 1, 1, 1 )
        else
            TextColor3 = RefletColor
        end
        if Reflet then
            Reflet.Visible = Visible

            if TextColor3 then
                Reflet.TextColor3 = TextColor3
            end

            local Brillance = Reflet:FindFirstChild( "Brillance" )

            if Brillance then
                if Visible then
                    CollectionService:AddTag( Brillance, "VipName" )
                else
                    CollectionService:RemoveTag( Brillance, "VipName" )
                end
            end
        end
    end
    if Tag then
        local Visible2
        local Tag2 = Argument2.tag

        if type( Tag2 ) == "string" then
            if Tag2 == "" then
                Visible2 = false
            else
                Visible2 = true
            end
        else
            Visible2 = false
        end

        local Enabled3
        Tag.Visible = Visible2

        if Visible2 then
            if Argument2.cid == "4bf51d50fbf6" then
                Enabled3 = true
            else
                Enabled3 = false
            end
        else
            Enabled3 = Visible2
        end
        if Visible2 then
            Tag.Text = "[" .. Tag2 .. "]"
            local ColorDef = ClanShared.ColorDef( Argument2.cc )
            local UIGradient = Tag:FindFirstChild( "UIGradient" )
            local Dev3 = Tag:FindFirstChild( "Dev" )

            if UIGradient then
                local Rotation
                UIGradient.Enabled = not Enabled3
                UIGradient.Color = ClanShared.GradientOf( Argument2.cc )
                Rotation = not ColorDef.keys and 90 or 15
                UIGradient.Rotation = Rotation
            end
            if Dev3 then
                Dev3.Enabled = Enabled3
            end
        end

        local Reflet2 = Tag:FindFirstChild( "Reflet" )

        if Reflet2 then
            Reflet2.Text = Tag.Text

            if Reflet2 then
                Reflet2.Visible = Enabled3
                local Brillance2 = Reflet2:FindFirstChild( "Brillance" )

                if Brillance2 then
                    if Enabled3 then
                        CollectionService:AddTag( Brillance2, "VipName" )
                    else
                        CollectionService:RemoveTag( Brillance2, "VipName" )
                    end
                end
            end
        end
        if not Class[ Tag ] then
            Class[ Tag ] = true
            Tag:GetPropertyChangedSignal( "TextBounds" ):Connect( function()
                Table10.place( Object )
            end )
        end
    end

    local Badge = Object:FindFirstChild( "Badge" )

    if Badge then
        local Image
        local Rk = Argument2.rk

        if Rk then
            Image = Badges.Image( Argument2.rk, Argument2.dv )
        else
            Image = Rk
        end

        local Visible3
        Badge.Image = Image or ""
        Visible3 = Image ~= nil and true or false
        Badge.Visible = Visible3

        if not Class[ Nom ] then
            Class[ Nom ] = true
            Nom:GetPropertyChangedSignal( "TextBounds" ):Connect( function()
                Table10.place( Object )
            end )
            Object:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
                Table10.place( Object )
            end )
        end
    end

    Table10.place( Object )
end
function Table10.badge( Argument1 )
    local Image2

    if Argument1.rk then
        local Image = Badges.Image( Argument1.rk, Argument1.dv )

        if Image then
            Image2 = Image
        else
            Image2 = nil
        end
    else
        Image2 = nil
    end

    return Image2
end
function Table10.fade( Self, TextTransparency )
    local Tag = Self:FindFirstChild( "Tag" )

    if Tag then
        Tag.TextTransparency = TextTransparency
    end

    local Reflet = Self.Nom:FindFirstChild( "Reflet" )

    if Reflet then
        local TextTransparency2 = not ( TextTransparency > 0 ) and 0 or 1
        Reflet.TextTransparency = TextTransparency2
    end

    local Reflet2

    if Tag then
        Reflet2 = Tag:FindFirstChild( "Reflet" )
    else
        Reflet2 = Tag
    end
    if Reflet2 then
        local TextTransparency3 = not ( TextTransparency > 0 ) and 0 or 1
        Reflet2.TextTransparency = TextTransparency3
    end
end
local Table11 = { }
local Table12 = { }

local function RenderElims()
    local Result2
    local Stats = MatchState:GetAttribute( "Stats" )
    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, Stats or "[]" )
    Result2 = Success and type( Result ) == "table" and Result or { }
    local Value1 = nil

    for Key, Value in Table12, nil, nil do
        local Elims = Value:FindFirstChild( "Elims" )

        if Elims then
            local K
            local Entry = Result2[ tostring( Value:GetAttribute( "UserId" ) ) ]
            K = type( Entry ) == "table" and Entry.k or 0
            local Text = tostring( K )

            if Elims.Text ~= Text then
                Elims.Text = Text
            end
        end
    end
end

MatchState:GetAttributeChangedSignal( "Stats" ):Connect( RenderElims )
local ClanShared2 = require( ReplicatedStorage:WaitForChild( "ClanShared" ) )
local Badges2 = require( RankedShared:WaitForChild( "Badges" ) )
local Table13 = { "I", "II", "III" }

local function EscC( Name )
    return ( tostring( Name or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) )
end

local function ClanText( TextName, TextName2, Argument3 )
    local TagRich2

    if type( TextName ) ~= "string" or TextName == "" then
        TagRich2 = nil
    else
        local TagRich = ClanShared2.TagRich( TextName, Argument3 )

        if TagRich then
            TagRich2 = TagRich
        else
            TagRich2 = nil
        end
    end

    local Gsub

    if TagRich2 then
        local Text = TagRich2 .. " " .. tostring( TextName2 or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )

        if Text then
            Gsub = Text
        else
            Gsub = tostring( TextName2 or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
        end
    else
        Gsub = tostring( TextName2 or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    end

    return Gsub
end

local function RenderClans()
    local Value1
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
    local Table = { "A", "B" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Text = Value ~= RankedTeam and "Adv" or "Moi"
        local EnteteClan
        local Entry = Table2[ Text ]

        if Entry then
            EnteteClan = Table2[ Text ]:FindFirstChild( "EnteteClan" )
        else
            EnteteClan = Entry
        end
        if EnteteClan then
            local Result2
            local Attribute = MatchState:GetAttribute( "Clan" .. Value )
            local JSONDecode = HttpService.JSONDecode
            local Success, Result = pcall( JSONDecode, HttpService, Attribute or "[]" )
            Result2 = Success and type( Result ) == "table" and Result or { }
            local Visible

            if type( Result2 ) == "table" then
                if Result2.cid == nil then
                    Visible = false
                else
                    Visible = true
                end
            else
                Visible = false
            end
            if EnteteClan.Visible ~= Visible then
                EnteteClan.Visible = Visible
            end
            if Visible then
                local TagRich2
                local Nom = EnteteClan.Nom
                local Tag = Result2.tag
                local Name = Result2.name
                local Cc = Result2.cc

                if type( Tag ) ~= "string" or Tag == "" then
                    TagRich2 = nil
                else
                    local TagRich = ClanShared2.TagRich( Tag, Cc )

                    if TagRich then
                        TagRich2 = TagRich
                    else
                        TagRich2 = nil
                    end
                end

                local Text3

                if TagRich2 then
                    local Text2 = TagRich2 .. " " .. tostring( Name or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )

                    if Text2 then
                        Text3 = Text2
                    else
                        Text3 = tostring( Name or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
                    end
                else
                    Text3 = tostring( Name or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
                end

                local Image2
                Nom.Text = Text3

                if Result2.rk then
                    local Image = Badges2.Image( Result2.rk, Result2.dv )

                    if Image then
                        Image2 = Image
                    else
                        Image2 = nil
                    end
                else
                    Image2 = nil
                end
                if EnteteClan.Badge.Image ~= ( Image2 or "" ) then
                    local Badge = EnteteClan.Badge
                    Badge.Image = Image2 or ""

                    if Image2 and Badges2.Place then
                        Badges2.Place( EnteteClan.Badge )
                    end
                end

                local Visible2
                local Badge2 = EnteteClan.Badge
                Visible2 = Image2 ~= nil and true or false
                local XSansBadge
                Badge2.Visible = Visible2

                if Image2 then
                    local XAvecBadge = EnteteClan.Nom:GetAttribute( "XAvecBadge" )

                    if XAvecBadge then
                        XSansBadge = XAvecBadge
                    else
                        XSansBadge = EnteteClan.Nom:GetAttribute( "XSansBadge" )
                    end
                else
                    XSansBadge = EnteteClan.Nom:GetAttribute( "XSansBadge" )
                end

                local Number = tonumber( XSansBadge )

                if Number then
                    local Nom2 = EnteteClan.Nom
                    Nom2.Position = UDim2.fromScale( Number, EnteteClan.Nom.Position.Y.Scale )
                end
                if Result2.rk then
                    local Text6
                    local Number2 = tonumber( Result2.dv )
                    local Rang = EnteteClan.Rang
                    local Text4 = tostring( Result2.rk )

                    if not Number2 or not Table13[ Number2 ] then
                        Text6 = ""
                    else
                        local Text5 = " " .. Table13[ Number2 ]

                        if Text5 then
                            Text6 = Text5
                        else
                            Text6 = ""
                        end
                    end

                    Rang.Text = ( Text4 .. Text6 ):upper( )
                else
                    local Number5
                    local Rang2 = EnteteClan.Rang
                    local Number3 = tonumber( Result2.placed ) or 0
                    local Number4 = tonumber( Result2.n )
                    Number5 = if Number4 then Number4 else Config.Placement.matches
                    Rang2.Text = ( "PLACEMENT %d/%d" ):format( Number3, Number5 )
                end
            end
        end
    end
end

MatchState:GetAttributeChangedSignal( "ClanA" ):Connect( RenderClans )
MatchState:GetAttributeChangedSignal( "ClanB" ):Connect( RenderClans )
LocalPlayer:GetAttributeChangedSignal( "RankedTeam" ):Connect( RenderClans )
RenderClans( )

local function RenderTeams()
    local Value1
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
    local Table = { }
    local Table2Inner = { "A", "B" }
    Value1 = nil

    for Key, Value in Table2Inner, nil, nil do
        local Text3 = Value ~= RankedTeam and "Adv" or "Moi"
        local Result2
        local Attribute = MatchState:GetAttribute( "Team" .. Value )
        local JSONDecode = HttpService.JSONDecode
        local Success, Result = pcall( JSONDecode, HttpService, Attribute or "[]" )
        Result2 = Success and type( Result ) == "table" and Result or { }
        local Value4 = nil

        for Key3, Value5 in Result2, nil, nil do
            local Entry2
            local Text = Value .. ":" .. tostring( Value5.id )
            Table[ Text ] = true
            local Entry = Table12[ Text ]

            if Entry then
                Entry2 = Entry
            else
                local Text2
                local Clone = Templates.Ligne:Clone( )
                Text2 = Text3 ~= "Moi" and "FondAdv" or "FondMoi"
                SetGrad( Clone, Text2 )
                local Accent = Clone:FindFirstChild( "Accent" )

                if Accent then
                    SetGrad( Accent, Text3 )

                    if Text3 == "Adv" then
                        Accent.Position = UDim2.fromScale( 1 - Accent.Position.X.Scale - Accent.Size.X.Scale, Accent.Position.Y.Scale )
                    end
                end

                Clone.Parent = Table2[ Text3 ]
                Table12[ Text ] = Clone
                Entry2 = Clone
            end

            Entry2.Name = "Joueur_" .. tostring( Value5.id )
            local Avatar = Entry2:FindFirstChild( "Avatar" )

            if Avatar then
                local Image
                local Number = tonumber( Value5.id ) or 0
                Image = Number > 0 and ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Number ) or ""

                if Avatar.Image ~= Image then
                    Avatar.Image = Image
                end
            end

            Entry2.LayoutOrder = Key3
            Table10.paint( Entry2, Value5 )
            local Rang = Entry2.Rang
            Rang.Text = tostring( Value5.label or "" ):upper( )
            local RangBadge = Entry2:FindFirstChild( "RangBadge" )

            if RangBadge then
                local Badge = Table10.badge( Value5 )

                if RangBadge.Image ~= ( Badge or "" ) then
                    RangBadge.Image = Badge or ""
                end

                local Flag = Badge ~= nil and true or false
                local RangX2
                Entry2:SetAttribute( "HasBadge", Flag )
                local RangX = Entry2:GetAttribute( "RangX" )
                RangX2 = if RangX then RangX else Entry2.Rang.Position.X.Scale
                local RangX3
                Entry2:SetAttribute( "RangX", RangX2 )
                RangX3 = if not Badge or not RangX2 then Entry2.Rang:GetAttribute( "SansBadgeX" ) or RangX2 else RangX2
                local Rang2 = Entry2.Rang
                Rang2.Position = UDim2.fromScale( RangX3, Entry2.Rang.Position.Y.Scale )
            end

            local Flag2
            Entry2:SetAttribute( "UserId", tonumber( Value5.id ) or 0 )
            Flag2 = Value5.here ~= false and true or false
            Entry2:SetAttribute( "Here", Flag2 )
        end
    end

    local Value2 = nil

    for Key2, Value3 in Table12, nil, nil do
        if not Table[ Key2 ] then
            Value3:Destroy( )
            Table12[ Key2 ] = nil
        end
    end

    RenderElims( )

    if Table11.render then
        Table11.render( )
    end
end

local function BotModel( Argument1 )
    local Children
    local Dummies = workspace:FindFirstChild( "Dummies" )
    Children = Dummies and Dummies:GetChildren( ) or { }
    local Value1 = nil

    for Key, Value in Children, nil, nil do
        if Value:GetAttribute( "RankedUid" ) == Argument1 then
            return Value
        end
    end

    return nil
end

local function CharOf( Amount )
    if type( Amount ) == "number" and Amount < 0 then
        return ( BotModel( Amount ) )
    end

    local PlayerByUserId2
    local PlayerByUserId = Players:GetPlayerByUserId( Amount or 0 )
    PlayerByUserId2 = if PlayerByUserId then PlayerByUserId.Character else PlayerByUserId
    return PlayerByUserId2
end

local function AliveOf( UserId )
    if UserId == 0 then
        local RankedTestDummy
        local Dummies = workspace:FindFirstChild( "Dummies" )

        if Dummies then
            RankedTestDummy = workspace.Dummies:FindFirstChild( "RankedTestDummy" )
        else
            RankedTestDummy = Dummies
        end

        local Humanoid

        if RankedTestDummy then
            Humanoid = RankedTestDummy:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = RankedTestDummy
        end

        local Flag

        if Humanoid == nil then
            Flag = false
        elseif Humanoid.Health > 0 then
            Flag = true
        else
            Flag = false
        end

        return Flag
    end
    local PlayerByUserId

    if type( UserId ) ~= "number" or not ( UserId < 0 ) then
        local PlayerByUserId2 = Players:GetPlayerByUserId( UserId or 0 )

        if PlayerByUserId2 then
            PlayerByUserId = PlayerByUserId2.Character
        else
            PlayerByUserId = PlayerByUserId2
        end
    else
        PlayerByUserId = BotModel( UserId )
    end

    local Humanoid2

    if PlayerByUserId then
        Humanoid2 = PlayerByUserId:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid2 = PlayerByUserId
    end

    local Flag2

    if Humanoid2 == nil then
        Flag2 = false
    elseif Humanoid2.Health > 0 then
        local DownedOut2
        local DownedOut = Config.DownedOut
        DownedOut2 = if DownedOut then PlayerByUserId:GetAttribute( "Downed" ) else DownedOut
        Flag2 = not DownedOut2
    else
        Flag2 = false
    end

    return Flag2
end

local function DownedOf( Amount )
    local PlayerByUserId

    if type( Amount ) ~= "number" or not ( Amount < 0 ) then
        local PlayerByUserId2 = Players:GetPlayerByUserId( Amount or 0 )

        if PlayerByUserId2 then
            PlayerByUserId = PlayerByUserId2.Character
        else
            PlayerByUserId = PlayerByUserId2
        end
    else
        PlayerByUserId = BotModel( Amount )
    end

    local Humanoid

    if PlayerByUserId then
        Humanoid = PlayerByUserId:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = PlayerByUserId
    end

    local Flag

    if Humanoid == nil then
        Flag = false
    elseif Humanoid.Health > 0 then
        if PlayerByUserId:GetAttribute( "Downed" ) == true then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local Table14 = { }
local Value9 = nil
local Value10 = nil

local function Layout( Argument1 )
    local Max = math.max( 1, Argument1 )

    if Max == Value9 then
        return Value10
    end

    local Max2 = 20 + Max * 36 + ( Max - 1 ) * 10
    local Max3 = 116 + 2 * ( 80 + Max2 )
    Value9 = Max
    Value10 = Max2
    local UIAspectRatioConstraint = Score.UIAspectRatioConstraint
    UIAspectRatioConstraint.AspectRatio = Max3 / 72
    Score.Size = UDim2.fromScale( math.min( Max3 * 0.0007, 0.46 ), Score.Size.Y.Scale )

    local function At( Argument1, Argument2, Amount, Argument4, Amount2 )
        Argument1.Position = UDim2.fromScale( Argument2 / Max3, Amount / 72 )
        Argument1.Size = UDim2.fromScale( Argument4 / Max3, Amount2 / 72 )
    end

    local Max4 = Max2 + 10
    local Max5 = Max4 + 60 + 10
    local Max6 = Max5 + 116 + 10
    local BandeMoi = Score.BandeMoi
    BandeMoi.Position = UDim2.fromScale( 0 / Max3, 0 )
    BandeMoi.Size = UDim2.fromScale( Max2 / Max3, 0.8333333333333334 )
    local MonEquipe = Score.MonEquipe
    MonEquipe.Position = UDim2.fromScale( Max4 / Max3, 0 )
    MonEquipe.Size = UDim2.fromScale( 60 / Max3, 0.8333333333333334 )
    local Centre = Score.Centre
    Centre.Position = UDim2.fromScale( Max5 / Max3, 0 )
    Centre.Size = UDim2.fromScale( 116 / Max3, 0.8333333333333334 )
    local Adverse = Score.Adverse
    Adverse.Position = UDim2.fromScale( Max6 / Max3, 0 )
    Adverse.Size = UDim2.fromScale( 60 / Max3, 0.8333333333333334 )
    local BandeAdv = Score.BandeAdv
    BandeAdv.Position = UDim2.fromScale( ( Max6 + 60 + 10 ) / Max3, 0 )
    BandeAdv.Size = UDim2.fromScale( Max2 / Max3, 0.8333333333333334 )
    local PipsMoi = Score.PipsMoi
    PipsMoi.Position = UDim2.fromScale( Max4 / Max3, 0.9027777777777778 )
    PipsMoi.Size = UDim2.fromScale( 60 / Max3, 0.05555555555555555 )
    local PipsAdv = Score.PipsAdv
    PipsAdv.Position = UDim2.fromScale( Max6 / Max3, 0.9027777777777778 )
    PipsAdv.Size = UDim2.fromScale( 60 / Max3, 0.05555555555555555 )
    local Lisere = Score.BandeAdv:FindFirstChild( "Lisere" )

    if Lisere then
        Lisere.Size = UDim2.fromScale( ( Max2 - 20 ) / Max2, Lisere.Size.Y.Scale )
    end

    return Max2
end

function Table11.render()
    local A
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
    local Table = { }
    local Table2 = { }
    local TeamA = MatchState:GetAttribute( "TeamA" )
    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, TeamA or "[]" )
    A = Success and type( Result ) == "table" and Result or { }
    local B
    Table2.A = A
    local TeamB = MatchState:GetAttribute( "TeamB" )
    local JSONDecode2 = HttpService.JSONDecode
    local Success2, Result2 = pcall( JSONDecode2, HttpService, TeamB or "[]" )
    B = Success2 and type( Result2 ) == "table" and Result2 or { }
    local Value2
    Table2.B = B
    local Count = #Table2.A
    local Layout2 = Layout( ( math.max( Count, #Table2.B, 1 ) ) )
    local Table3 = { "A", "B" }
    Value2 = nil

    for Key, Value in Table3, nil, nil do
        local Text = Value ~= RankedTeam and "Adv" or "Moi"
        local Parent

        if Text == "Moi" then
            local BandeMoi = Score.BandeMoi

            if BandeMoi then
                Parent = BandeMoi
            else
                Parent = Score.BandeAdv
            end
        else
            Parent = Score.BandeAdv
        end

        local Clone = table.clone( Table2[ Value ] )

        if Text == "Moi" then
            table.sort( Clone, function( Argument1, Argument2 )
                local Number = Argument1.id ~= LocalPlayer.UserId and 1 or 0
                local Number2 = Argument2.id ~= LocalPlayer.UserId and 1 or 0
                local Flag = Number < Number2 and true or false
                return Flag
            end )
        end

        local Value5 = nil

        for Key3, Value6 in Clone, nil, nil do
            local Entry2
            local Text2 = Value .. ":" .. tostring( Value6.id )
            Table[ Text2 ] = true
            local Entry = Table14[ Text2 ]

            if Entry then
                Entry2 = Entry
            else
                local Clone2 = Templates.Case:Clone( )
                Clone2.Visible = true
                Table14[ Text2 ] = Clone2
                Entry2 = Clone2
            end

            local Total2
            local Number = tonumber( Value6.id ) or 0
            Entry2.Name = "Case_" .. tostring( Value6.id )

            if Text == "Moi" then
                local Total = Layout2 - 10 - 36 - ( Key3 - 1 ) * 46

                if Total then
                    Total2 = Total
                else
                    Total2 = 10 + ( Key3 - 1 ) * 46
                end
            else
                Total2 = 10 + ( Key3 - 1 ) * 46
            end

            local Image
            Entry2.Position = UDim2.fromScale( Total2 / Layout2, 0.11666666666666667 )
            Entry2.Size = UDim2.fromScale( 36 / Layout2, 0.6 )
            Image = Number > 0 and ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Number ) or ""

            if Entry2.Avatar.Image ~= Image then
                Entry2.Avatar.Image = Image
            end

            local Flag
            local Initiale = Entry2.Initiale
            Initiale.Text = tostring( Value6.name or "?" ):sub( 1, 1 ):upper( )
            Entry2:SetAttribute( "UserId", Number )
            Flag = Value6.here ~= false and true or false
            local Flag2
            Entry2:SetAttribute( "Here", Flag )
            Flag2 = Number <= 0 and true or false
            local Flag3
            Entry2:SetAttribute( "Bot", Flag2 )
            Flag3 = Text == "Moi" and true or false
            local Enabled
            Entry2:SetAttribute( "Allie", Flag3 )
            local Toi = Entry2.Toi
            Enabled = Number == LocalPlayer.UserId and true or false
            Toi.Enabled = Enabled
            Entry2.Parent = Parent
        end
    end

    local Value3 = nil

    for Key2, Value4 in Table14, nil, nil do
        if not Table[ Key2 ] then
            Value4:Destroy( )
            Table14[ Key2 ] = nil
        end
    end
end
local Class2 = setmetatable( { }, { __mode = "k" } )
local Class3 = setmetatable( { }, { __mode = "k" } )
function Table11.alive( Visible )
    local Value1 = nil

    for Key, Value in Table14, nil, nil do
        local Visible2
        local UserId = Value:GetAttribute( "UserId" )

        if Value:GetAttribute( "Here" ) == false then
            Visible2 = true
        elseif Visible then
            Visible2 = not AliveOf( UserId )
        else
            Visible2 = Visible
        end

        local Visible3

        if Visible then
            local NotFlag = not Visible2

            if NotFlag then
                local PlayerByUserId

                if type( UserId ) ~= "number" or not ( UserId < 0 ) then
                    local PlayerByUserId2 = Players:GetPlayerByUserId( UserId or 0 )

                    if PlayerByUserId2 then
                        PlayerByUserId = PlayerByUserId2.Character
                    else
                        PlayerByUserId = PlayerByUserId2
                    end
                else
                    PlayerByUserId = BotModel( UserId )
                end

                local Humanoid

                if PlayerByUserId then
                    Humanoid = PlayerByUserId:FindFirstChildOfClass( "Humanoid" )
                else
                    Humanoid = PlayerByUserId
                end
                if Humanoid == nil then
                    Visible3 = false
                elseif Humanoid.Health > 0 then
                    if PlayerByUserId:GetAttribute( "Downed" ) == true then
                        Visible3 = true
                    else
                        Visible3 = false
                    end
                else
                    Visible3 = false
                end
            else
                Visible3 = NotFlag
            end
        else
            Visible3 = Visible
        end

        local Text

        if Visible2 then
            Text = "out"
        elseif Visible3 then
            Text = "down"
        else
            Text = "up"
        end
        if Class2[ Value ] ~= Text then
            local Visible4
            Class2[ Value ] = Text
            Visible4 = Value:GetAttribute( "Bot" ) == true and true or false
            local Enabled
            Value.Voile.Visible = Visible2
            local Contour = Value.Contour
            Contour.Enabled = not Visible2
            local Toi = Value.Toi
            local NotFlag2 = not Visible2

            if NotFlag2 then
                if UserId == LocalPlayer.UserId then
                    Enabled = true
                else
                    Enabled = false
                end
            else
                Enabled = NotFlag2
            end

            local ImageTransparency
            Toi.Enabled = Enabled
            local Avatar = Value.Avatar
            Avatar.Visible = not Visible4
            local Avatar2 = Value.Avatar

            if Visible2 then
                ImageTransparency = 0.75
            elseif Visible3 then
                ImageTransparency = 0.35
            else
                ImageTransparency = 0
            end

            local TextTransparency
            Avatar2.ImageTransparency = ImageTransparency
            Value.Initiale.Visible = Visible4
            local Initiale = Value.Initiale
            TextTransparency = not Visible2 and 0 or 0.7
            local Visible5
            Initiale.TextTransparency = TextTransparency
            Value.ATerre.Visible = Visible3
            local Vie = Value.Vie
            Visible5 = if Value:GetAttribute( "Allie" ) == true then not Visible2 else false
            Vie.Visible = Visible5
        end
        if Value.Vie.Visible then
            local PlayerByUserId3

            if type( UserId ) ~= "number" or not ( UserId < 0 ) then
                local PlayerByUserId4 = Players:GetPlayerByUserId( UserId or 0 )

                if PlayerByUserId4 then
                    PlayerByUserId3 = PlayerByUserId4.Character
                else
                    PlayerByUserId3 = PlayerByUserId4
                end
            else
                PlayerByUserId3 = BotModel( UserId )
            end

            local Humanoid2

            if PlayerByUserId3 then
                Humanoid2 = PlayerByUserId3:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid2 = PlayerByUserId3
            end

            local Clamp2

            if not Humanoid2 or not ( Humanoid2.MaxHealth > 0 ) then
                Clamp2 = 1
            else
                local Clamp = math.clamp( Humanoid2.Health / Humanoid2.MaxHealth, 0, 1 )

                if Clamp then
                    Clamp2 = Clamp
                else
                    Clamp2 = 1
                end
            end
            if not Class3[ Value ] or math.abs( Class3[ Value ] - Clamp2 ) > 0.005 then
                Class3[ Value ] = Clamp2
                local Barre = Value.Vie.Barre
                Barre.Size = UDim2.fromScale( Clamp2, 1 )
            end
        end
    end
end
local Table15 = { Moi = 0, Adv = 0 }
local Class4 = setmetatable( { }, { __mode = "k" } )

local function RenderAlive()
    local Flag2
    local Phase = MatchState:GetAttribute( "Phase" )

    if Phase == "fight" then
        Flag2 = true
    elseif Phase == "roundend" then
        Flag2 = true
    else
        Flag2 = false
    end

    local Value1
    Table15.Moi = 0
    Table15.Adv = 0
    Value1 = nil

    for Key, Value in Table12, nil, nil do
        local FlagInner = Value:GetAttribute( "Here" ) ~= false and true or false
        local Visible2
        local NotFlag = not FlagInner

        if NotFlag then
            Visible2 = NotFlag
        elseif Flag2 then
            Visible2 = not AliveOf( Value:GetAttribute( "UserId" ) )
        else
            Visible2 = Flag2
        end

        local Visible3

        if Flag2 then
            local NotNotFlag = not Visible2

            if NotNotFlag then
                local PlayerByUserId
                local UserId = Value:GetAttribute( "UserId" )

                if type( UserId ) ~= "number" or not ( UserId < 0 ) then
                    local PlayerByUserId2 = Players:GetPlayerByUserId( UserId or 0 )

                    if PlayerByUserId2 then
                        PlayerByUserId = PlayerByUserId2.Character
                    else
                        PlayerByUserId = PlayerByUserId2
                    end
                else
                    PlayerByUserId = BotModel( UserId )
                end

                local Humanoid

                if PlayerByUserId then
                    Humanoid = PlayerByUserId:FindFirstChildOfClass( "Humanoid" )
                else
                    Humanoid = PlayerByUserId
                end
                if Humanoid == nil then
                    Visible3 = false
                elseif Humanoid.Health > 0 then
                    if PlayerByUserId:GetAttribute( "Downed" ) == true then
                        Visible3 = true
                    else
                        Visible3 = false
                    end
                else
                    Visible3 = false
                end
            else
                Visible3 = NotNotFlag
            end
        else
            Visible3 = Flag2
        end

        local Text2 = Value.Parent ~= Table2.Moi and "Adv" or "Moi"
        local Number
        local Entry = Table15[ Text2 ]
        Number = not Visible2 and 1 or 0
        local Text3
        Table15[ Text2 ] = Entry + Number
        Text3 = not FlagInner and "x" or "h"
        local Text4 = not Visible2 and "-" or "o"
        local Text5 = not Visible3 and "-" or "d"
        local Text6 = not Value:GetAttribute( "HasBadge" ) and "-" or "b"
        local Text7 = Text3 .. Text4 .. Text5 .. Text6

        if Class4[ Value ] ~= Text7 then
            Class4[ Value ] = Text7
            local ATerre = Value:FindFirstChild( "ATerre" )

            if ATerre then
                ATerre.Visible = Visible3
            end

            local TextTransparency
            local Rang = Value.Rang
            Rang.Visible = not ( Visible3 and ATerre )
            Value.Barre.Visible = Visible2
            local Nom = Value.Nom
            TextTransparency = not Visible2 and 0 or 0.5
            local Number2
            Nom.TextTransparency = TextTransparency
            local Fade = Table10.fade
            Number2 = not Visible2 and 0 or 0.5
            local TextTransparency2
            Fade( Value, Number2 )
            local Rang2 = Value.Rang
            TextTransparency2 = not Visible2 and 0 or 0.5
            Rang2.TextTransparency = TextTransparency2
            local Avatar = Value:FindFirstChild( "Avatar" )

            if Avatar then
                local ImageTransparency = not Visible2 and 0 or 0.6
                Avatar.ImageTransparency = ImageTransparency
                local Mort = Avatar:FindFirstChild( "Mort" )

                if Mort then
                    Mort.Visible = Visible2 and FlagInner
                end
            end

            local RangBadge = Value:FindFirstChild( "RangBadge" )

            if RangBadge then
                local Visible4 = if Value:GetAttribute( "HasBadge" ) == true then not ( Visible3 and ATerre ) else false
                local ImageTransparency2
                RangBadge.Visible = Visible4
                ImageTransparency2 = not Visible2 and 0 or 0.5
                RangBadge.ImageTransparency = ImageTransparency2
            end

            local Elims = Value:FindFirstChild( "Elims" )

            if Elims then
                local TextTransparency3 = not Visible2 and 0 or 0.5
                Elims.TextTransparency = TextTransparency3
            end

            local BackgroundTransparency = not FlagInner and 0.6 or 0.15
            Value.BackgroundTransparency = BackgroundTransparency
        end
    end
    if Table11.alive then
        Table11.alive( Flag2 )
    end

    local Visible

    if Flag then
        if Phase == "fight" then
            Visible = false
        else
            Visible = true
        end
    else
        Visible = Flag
    end

    local Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        if Value3.Visible ~= Visible then
            Value3.Visible = Visible
        end
    end

    local Value4 = nil

    for Key3, Value5 in Table2, nil, nil do
        local Vivants
        local Entete = Value5:FindFirstChild( "Entete" )

        if Entete then
            Vivants = Entete:FindFirstChild( "Vivants" )
        else
            Vivants = Entete
        end
        if Vivants then
            local Text = Table15[ Key3 ] .. " ALIVE"

            if Vivants.Text ~= Text then
                Vivants.Text = Text
            end
        end
    end
end

local function RenderStatut()
    local Max
    local Phase = MatchState:GetAttribute( "Phase" )
    local WaitUntil = MatchState:GetAttribute( "WaitUntil" )

    if type( WaitUntil ) == "number" then
        Max = math.max( 0, WaitUntil - workspace:GetServerTimeNow( ) )
    else
        Max = nil
    end

    local Text3

    if Max then
        local Text2
        local Text = tostring( MatchState:GetAttribute( "WaitNames" ) or "" )
        Text2 = if Text == "" then "A PLAYER" else Text

        if MatchState:GetAttribute( "WaitKind" ) == "load" then
            Text3 = ( "%s IS LOADING THE MATCH  ·  %d s" ):format( Text2, ( math.ceil( Max ) ) )
        else
            local Text5
            local WaitTeam = MatchState:GetAttribute( "WaitTeam" )

            if WaitTeam == "A" or WaitTeam == "B" then
                local Text4 = WaitTeam == ( LocalPlayer:GetAttribute( "RankedTeam" ) or "A" ) and "  ·  OR IT'S A FORFEIT" or "  ·  OR YOU WIN"
                Text5 = Text4
            else
                Text5 = ""
            end

            Text3 = ( "WAITING FOR %s TO RECONNECT  ·  %d s%s" ):format( Text2, math.ceil( Max ), Text5 )
        end
    elseif Phase == "arrival" then
        local Value1, Number, Number2
        local Table = { "A", "B" }
        Value1 = nil
        Number = 0
        Number2 = 0

        for Key, Value in Table, nil, nil do
            local Result2
            local Attribute = MatchState:GetAttribute( "Team" .. Value )
            local JSONDecode = HttpService.JSONDecode
            local Success, Result = pcall( JSONDecode, HttpService, Attribute or "[]" )
            Result2 = Success and type( Result ) == "table" and Result or { }
            local Value2 = nil

            for Key2, Value3 in Result2, nil, nil do
                Number2 = Number2 + 1

                if Value3.here then
                    Number = Number + 1
                end
            end
        end

        local Max2
        local Format = ( "WAITING FOR PLAYERS  %d/%d" ):format( Number, Number2 )
        local PhaseEnd = MatchState:GetAttribute( "PhaseEnd" )

        if type( PhaseEnd ) ~= "number" or PhaseEnd <= 0 then
            Max2 = nil
        else
            Max2 = math.max( 0, PhaseEnd - workspace:GetServerTimeNow( ) )
        end
        if not Max2 or not ( Max2 > 0 ) or not ( Number < Number2 ) then
            Text3 = Format
        else
            Text3 = Format .. ( "  ·  %d s" ):format( ( math.ceil( Max2 ) ) )
        end
    elseif Phase == "cancelled" then
        Text3 = "MATCH CANCELLED: A PLAYER DID NOT JOIN · BACK TO THE BOAT..."
    else
        Text3 = nil
    end

    local Visible = Text3 ~= nil and true or false
    Statut.Visible = Visible

    if Text3 then
        Statut.Text = Text3
    end
end

local Number = 0

local function Announce( Text, Name, Name2, Duration, Amount )
    local NotVisible2
    Number = Number + 1
    local NotVisible = not Annonce.Visible

    if NotVisible then
        NotVisible2 = NotVisible
    elseif Annonce.Size == Table.annSize then
        NotVisible2 = false
    else
        NotVisible2 = true
    end

    local Visible
    Annonce.Titre.Text = Text
    local Sous = Annonce.Sous
    Sous.Text = Name or ""
    local Sous2 = Annonce.Sous

    if Name == nil then
        Visible = false
    elseif Name == "" then
        Visible = false
    else
        Visible = true
    end

    Sous2.Visible = Visible
    SetGrad( Annonce.Titre, Name2 or "Neutre" )
    Annonce.Visible = true

    if NotVisible2 then
        local AnnSize = Table.annSize
        Annonce.Size = UDim2.new( AnnSize.X.Scale, AnnSize.X.Offset, AnnSize.Y.Scale * 0.1, AnnSize.Y.Offset )
        TweenService:Create( Annonce, TweenInfo.new( 0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out ), { Size = AnnSize } ):Play( )
    end

    local Punch = Table.punch
    local UIScale = Annonce.Titre:FindFirstChildOfClass( "UIScale" )
    Punch( UIScale, Amount or 1.25, 0.26 )

    if Duration then
        task.delay( Duration, function()
            if Number == Number then
                local AnnSize = Table.annSize
                local TweenInfo2 = TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In )
                local Scale = AnnSize.X.Scale
                local Create = TweenService:Create( Annonce, TweenInfo2, { Size = UDim2.new( Scale, AnnSize.X.Offset, 0, 0 ) } )
                Create.Completed:Once( function()
                    if Number == Number then
                        Annonce.Visible = false
                        Annonce.Size = AnnSize
                        return
                    end
                    return
                end )
                Create:Play( )
                return
            end
            return
        end )
    end
end

local function HideAnnounce()
    Number = Number + 1
    Annonce.Visible = false
    Annonce.Size = Table.annSize
end

local Table16 = { }
local Value11 = nil

local function ModesOf( Argument1 )
    local Value1
    local Table = { }
    local ModeOrder = Config.ModeOrder
    Value1 = nil

    for Key, Value in ModeOrder, nil, nil do
        local Entry = Config.Modes[ Value ]

        if Entry and table.find( Entry.maps, Argument1 ) then
            local Label2
            local Label = Entry.label
            Label2 = if Label then Label else Value:upper( )
            table.insert( Table, Label2 )
        end
    end

    return table.concat( Table, " · " )
end

local Flag4 = false

local function TryBan( Argument1 )
    if Flag4 or MatchState:GetAttribute( "Phase" ) ~= "ban" then
        return
    end

    local Attribute = MatchState:GetAttribute( "Ban" .. ( LocalPlayer:GetAttribute( "RankedTeam" ) or "A" ) )

    if not Attribute or Attribute == "" then
        Flag4 = true
        task.spawn( function()
            pcall( MatchFn.InvokeServer, MatchFn, "ban", Argument1 )
            Flag4 = false
        end )
        return
    end
    return
end

task.spawn( function()
    local MapPhotos2
    local Table = { }
    local MapPhotos = Config.MapPhotos
    MapPhotos2 = if MapPhotos then MapPhotos else { }
    local Value1 = nil

    for Key, Value in MapPhotos2, nil, nil do
        local ImageLabel = Instance.new( "ImageLabel" )
        ImageLabel.Image = Value
        table.insert( Table, ImageLabel )
    end

    local Value2
    pcall( function()
        game:GetService( "ContentProvider" ):PreloadAsync( Table )
    end )
    Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        Value3:Destroy( )
    end
end )

local function AttachPreview( Clone, PreviewName )
    local Image
    local MapPhotos = Config.MapPhotos
    Image = if MapPhotos then Config.MapPhotos[ PreviewName ] else MapPhotos
    local Photo = Clone:FindFirstChild( "Photo" )

    if Image and Photo then
        Photo.Image = Image
        Photo.Visible = true
        local Apercu = Clone:FindFirstChild( "Apercu" )

        if Apercu then
            Apercu.Visible = false
        end
        if Clone:FindFirstChild( "Icone" ) then
            Clone.Icone.Visible = false
        end

        return
    end
    local Apercu2 = Clone:FindFirstChild( "Apercu" )

    if Apercu2 then
        task.defer( function()
            local Child
            local Apercus = RankedShared:WaitForChild( "Apercus", 6 )

            if Apercus then
                Child = Apercus:WaitForChild( PreviewName, 6 )
            else
                Child = Apercus
            end
            if not Child or not Clone.Parent then
                return
            end

            Child:Clone( ).Parent = Apercu2
            local CurrentCamera = Instance.new( "Camera" )
            CurrentCamera.FieldOfView = 40
            local CFrame = Child:GetAttribute( "CamCF" )

            if typeof( CFrame ) == "CFrame" then
                CurrentCamera.CFrame = CFrame
            end

            CurrentCamera.Parent = Apercu2
            Apercu2.CurrentCamera = CurrentCamera

            if Clone:FindFirstChild( "Icone" ) then
                Clone.Icone.Visible = false
            end
        end )
        return
    end
    return
end

local function RenderBan()
    local Flag = MatchState:GetAttribute( "Phase" ) == "ban" and true or false

    if Flag then
        local Result2
        local Candidates = MatchState:GetAttribute( "Candidates" )
        local JSONDecode = HttpService.JSONDecode
        local Success, Result = pcall( JSONDecode, HttpService, Candidates or "[]" )
        Result2 = Success and type( Result ) == "table" and Result or { }
        local Concat = table.concat( Result2, "," )

        if Ban:GetAttribute( "Cles" ) ~= Concat then
            local Value2 = nil

            for Key2, Value3 in Table16, nil, nil do
                Value3:Destroy( )
            end

            local Value4
            table.clear( Table16 )
            Value4 = nil

            for Key3, Value5 in Result2, nil, nil do
                local Clone = Templates.Carte:Clone( )
                Clone.Name = "Carte_" .. Key3
                Clone.LayoutOrder = Key3
                local Nom = Clone.Nom
                Nom.Text = Config.MapLabel( Value5 )
                local Modes = Clone.Modes
                Modes.Text = ModesOf( Value5 )
                Clone.Activated:Connect( function()
                    TryBan( Value5 )
                end )
                AttachPreview( Clone, Value5 )
                Clone.MouseEnter:Connect( function()
                    Value11 = Value5
                end )
                Clone.MouseLeave:Connect( function()
                    if Value11 == Value5 then
                        Value11 = nil
                    end
                end )
                Clone.Parent = Ban.Cartes
                Table16[ Value5 ] = Clone
            end

            Ban:SetAttribute( "Cles", Concat )
        end

        local Text
        local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
        local Attribute = MatchState:GetAttribute( "Ban" .. RankedTeam )
        Text = RankedTeam ~= "A" and "A" or "B"
        local Flag5
        local Attribute2 = MatchState:GetAttribute( "Ban" .. Text )

        if Attribute == nil then
            Flag5 = false
        elseif Attribute == "" then
            Flag5 = false
        else
            Flag5 = true
        end

        local Value6 = nil

        for Key4, Value7 in Table16, nil, nil do
            local Flag2 = Attribute == Key4 and true or false
            local Flag3 = Attribute2 == Key4 and true or false
            local Text5
            local Voile = Value7.Voile
            Voile.Visible = Flag2 or Flag3
            local Etat2 = Value7.Etat

            if Flag2 then
                Text5 = "BANNED BY YOU"
            elseif Flag3 then
                Text5 = "BANNED BY ENEMY"
            elseif Flag5 then
                Text5 = ""
            else
                Text5 = "CLICK TO BAN"
            end

            local Text6
            Etat2.Text = Text5
            local Etat3 = Value7.Etat
            Text6 = ( Flag2 or Flag3 ) and "Banni" or "Normal"
            local Flag4
            SetGrad( Etat3, Text6 )

            if Value11 == Key4 then
                local NotFlag = not Flag5

                if NotFlag then
                    Flag4 = not Flag3
                else
                    Flag4 = NotFlag
                end
            else
                Flag4 = false
            end

            local Text7 = not Flag4 and "Normal" or "Survol"
            local Number
            SetGrad( Value7, Text7 )
            Number = not Flag4 and 0 or 1
            local ZBase2
            local ZBase = Value7:GetAttribute( "ZBase" )

            if ZBase == nil then
                local ZIndex = Value7.ZIndex
                Value7:SetAttribute( "ZBase", ZIndex )
                ZBase2 = ZIndex
            else
                ZBase2 = ZBase
            end

            local ZIndex2 = ZBase2 + Number

            if Value7.ZIndex ~= ZIndex2 then
                Value7.ZIndex = ZIndex2
            end
        end

        local Max
        local PhaseEnd = MatchState:GetAttribute( "PhaseEnd" )

        if type( PhaseEnd ) ~= "number" or PhaseEnd <= 0 then
            Max = nil
        else
            Max = math.max( 0, PhaseEnd - workspace:GetServerTimeNow( ) )
        end

        local Text3
        local Temps = Ban.Temps

        if Max then
            local Text2 = tostring( ( math.ceil( Max ) ) )

            if Text2 then
                Text3 = Text2
            else
                Text3 = ""
            end
        else
            Text3 = ""
        end

        local Text4
        Temps.Text = Text3
        local Etat = Ban.Etat
        Text4 = not Flag5 and "Click a map to ban it" or "Waiting for the enemy team..."
        local Value8
        Etat.Text = Text4
        Value8 = nil

        for Key5, Value9 in Table16, nil, nil do
            if Key5 == Attribute or Key5 == Attribute2 then
                if not Value9:GetAttribute( "Tampon" ) then
                    Value9:SetAttribute( "Tampon", true )
                    local Punch = Table.punch
                    Punch( Value9.Etat:FindFirstChild( "Pop" ), 1.7, 0.28, Enum.EasingStyle.Quart )
                    Sfx.Play( "BanTampon" )
                end
            end
        end

        Open( Ban )
        return
    end
    if Ban.Visible then
        local Value1
        Ban.Visible = false
        Value1 = nil

        for Key, Value in Table16, nil, nil do
            Value:Destroy( )
        end

        table.clear( Table16 )
        Ban:SetAttribute( "Cles", nil )
    end

    return
end

local Value12 = nil
local Value13 = nil

local function MyAlive()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Flag

    if Humanoid == nil then
        Flag = false
    elseif Humanoid.Health > 0 then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function SpecChar( Object )
    if not Object then
        return nil
    end
    if Object:IsA( "Player" ) then
        return Object.Character
    end
    return Object
end

local function LivingMates( Text )
    local Table = { }

    for Key, Value in Players:GetPlayers( ) do
        if Value ~= LocalPlayer and Value:GetAttribute( "RankedTeam" ) == ( Text or LocalPlayer:GetAttribute( "RankedTeam" ) or "A" ) then
            local Humanoid
            local Character = Value.Character

            if Character then
                Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if Humanoid and Humanoid.Health > 0 and Character:FindFirstChild( "HumanoidRootPart" ) then
                table.insert( Table, Value )
            end
        end
    end

    local Children
    local Dummies = workspace:FindFirstChild( "Dummies" )
    Children = Dummies and Dummies:GetChildren( ) or { }
    local Value1 = nil

    for Key2, Value2 in Children, nil, nil do
        if Value2:GetAttribute( "RankedUid" ) and Value2:GetAttribute( "RankedTeam" ) == ( Text or LocalPlayer:GetAttribute( "RankedTeam" ) or "A" ) and Value2:FindFirstChildOfClass( "Humanoid" ) and Value2:FindFirstChildOfClass( "Humanoid" ).Health > 0 and Value2:FindFirstChild( "HumanoidRootPart" ) then
            table.insert( Table, Value2 )
        end
    end

    return Table
end

local ProximityPromptService = game:GetService( "ProximityPromptService" )
local Flag5 = false

local function SpecPrompts( Argument1 )
    if Argument1 == Flag5 then
        return
    end

    Flag5 = Argument1

    if Argument1 then
        pcall( function()
            ProximityPromptService.Enabled = false
        end )
        return
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Flag

    if Humanoid == nil then
        Flag = false
    elseif Humanoid.Health > 0 then
        if Character:GetAttribute( "Downed" ) == true then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    pcall( function()
        local Enabled
        local NotCaptured = not Flag

        if NotCaptured then
            if ClientState.BetaRollLock == true then
                Enabled = false
            else
                Enabled = true
            end
        else
            Enabled = NotCaptured
        end

        ProximityPromptService.Enabled = Enabled
    end )
end

local Value14 = nil

local function SpecZoom( Argument1 )
    if Argument1 then
        if Value14 == nil then
            Value14 = LocalPlayer.CameraMaxZoomDistance
        end
        if LocalPlayer.CameraMaxZoomDistance ~= 20 then
            LocalPlayer.CameraMaxZoomDistance = 20
            return
        end
    elseif Value14 ~= nil then
        LocalPlayer.CameraMaxZoomDistance = Value14
        Value14 = nil
    end
end

local function SetSpectate( Player )
    local Character
    Value12 = Player

    if Player then
        if Player:IsA( "Player" ) then
            Character = Player.Character
        else
            Character = Player
        end
    else
        Character = nil
    end

    local RobloxCamera

    if Character then
        RobloxCamera = Character:FindFirstChild( "HumanoidRootPart" )
    else
        RobloxCamera = Character
    end

    local Flag = RobloxCamera ~= nil and true or false
    local Flag2
    SpecPrompts( Flag )
    Flag2 = RobloxCamera ~= nil and true or false

    if Flag2 then
        if Value14 == nil then
            Value14 = LocalPlayer.CameraMaxZoomDistance
        end
        if LocalPlayer.CameraMaxZoomDistance ~= 20 then
            LocalPlayer.CameraMaxZoomDistance = 20
        end
    elseif Value14 ~= nil then
        LocalPlayer.CameraMaxZoomDistance = Value14
        Value14 = nil
    end
    if RobloxCamera then
        local Text
        Value13 = RobloxCamera
        ClientState.RobloxCamera = RobloxCamera
        local Nom = Spectateur.Nom

        if not Player:IsA( "Player" ) or not Player.DisplayName then
            local NameTag = Player:GetAttribute( "NameTag" )

            if NameTag then
                Text = NameTag
            else
                Text = Player.Name
            end
        else
            Text = Player.DisplayName
        end

        Nom.Text = Text
        Spectateur.Visible = true
        return
    end
    if Value13 and ClientState.RobloxCamera == Value13 then
        ClientState.RobloxCamera = nil
    end

    Value13 = nil
    Value12 = nil
    Spectateur.Visible = false
    return
end

local function NextMate()
    local LivingMates3
    local LivingMates2 = LivingMates( )

    if #LivingMates2 == 0 then
        local Text = ( LocalPlayer:GetAttribute( "RankedTeam" ) or "A" ) ~= "A" and "A" or "B"
        LivingMates3 = LivingMates( Text )
    else
        Value2 = LivingMates2
    end
    if #Value2 == 0 then
        return SetSpectate( nil )
    end
    SetSpectate( Value2[ ( table.find( Value2, Value12 ) or 0 ) % #Value2 + 1 ] )
    return
end

UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if Argument2 or not Value12 then
        return
    end

    local UserInputType = Argument1.UserInputType

    if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch or Argument1.KeyCode == Enum.KeyCode.ButtonR2 then
        NextMate( )
    end
end )

local function RenderSpectate()
    local Phase = MatchState:GetAttribute( "Phase" )

    if Phase == "fight" or Phase == "roundend" then
        local Humanoid
        local Character = LocalPlayer.Character

        if Character then
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end

        local Flag

        if Humanoid == nil then
            Flag = false
        elseif Humanoid.Health > 0 then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            if Value12 or Value13 then
                SetSpectate( nil )
            end
        else
            local Character2

            if Value12 then
                if Value12:IsA( "Player" ) then
                    Character2 = Value12.Character
                else
                    Character2 = Value12
                end
            else
                Character2 = nil
            end

            local Humanoid2

            if Character2 then
                Humanoid2 = Character2:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid2 = Character2
            end
            if not Humanoid2 or not ( Humanoid2.Health > 0 ) or not Value12.Parent then
                NextMate( )
            end
            if Value13 and ProximityPromptService.Enabled then
                pcall( function()
                    ProximityPromptService.Enabled = false
                end )
            end
            if Value13 and LocalPlayer.CameraMaxZoomDistance ~= 20 then
                if Value14 == nil then
                    Value14 = LocalPlayer.CameraMaxZoomDistance
                end
                if LocalPlayer.CameraMaxZoomDistance ~= 20 then
                    LocalPlayer.CameraMaxZoomDistance = 20
                    return
                end
            end
        end
    elseif Value12 or Value13 then
        SetSpectate( nil )
    end
end

local Ranks = require( RankedShared:WaitForChild( "Ranks" ) )
local Badges3 = require( RankedShared:WaitForChild( "Badges" ) )
local Table17 = { "I", "II", "III" }
local Ecran = Resultats:WaitForChild( "Ecran" )
local Decor = Ecran.Decor
local Progression = Ecran.Progression
local Bas = Ecran.Bas
local Barre = Progression.Barre
local Piste = Barre.Piste
local Flag6 = false
local Number2 = 0
local Value15 = nil
local Table18 = { }

local function Keep( Key, ... )
    if not Key then
        return
    end

    local Entry2
    local Entry = Table18[ Key ]
    Entry2 = if Entry then Entry else { }
    local Value1
    Table18[ Key ] = Entry2
    local Table = { ... }
    Value1 = nil

    for Key2, Value in Table, nil, nil do
        local Entry3 = Table18[ Key ]
        Entry3[ Value ] = Key[ Value ]
    end
end

local function Dv( Key, Key2 )
    local Entry2
    local Entry = Table18[ Key ]
    Entry2 = if Entry then Table18[ Key ][ Key2 ] else Entry
    return Entry2
end

local Table19 = { "Halo", "Embleme", "Trait" }
Value16 = nil

for Key5, Value17 in Table19, nil, nil do
    Storage.FoundChild3 = Decor:FindFirstChild( Value17 )
    Keep( Storage.FoundChild3, "GroupTransparency", "Size" )
    Storage.FoundChild4 = if Storage.FoundChild3 then Storage.FoundChild3:FindFirstChild( "Pop" ) else Storage.FoundChild3
    Keep( Storage.FoundChild4, "Scale" )
end

local Value18
Keep( Resultats.Voile, "BackgroundTransparency" )
Keep( Resultats.Eclair, "BackgroundTransparency" )
local Table20 = { Ecran.Titre, Ecran.Score, Ecran.Raison, Progression.Statut }
Value18 = nil

for Key6, Value19 in Table20, nil, nil do
    Keep( Value19, "TextTransparency" )
    Keep( Value19:FindFirstChild( "Contour" ), "Transparency" )
end
Keep( Ecran.Titre.Pop, "Scale" )
Keep( Progression, "GroupTransparency" )
Keep( Bas, "GroupTransparency" )

local function Tween( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Create = TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out ), Argument3 )
    Create:Play( )
    return Create
end

local function Pause( Argument1, Duration )
    local Flag
    task.wait( Duration )
    Flag = Argument1 == Number2 and true or false
    return Flag
end

local function Over( Argument1, Argument2, Callback )
    local Clock = os.clock( )

    while true do
        if Argument1 ~= Number2 then
            return false
        end

        local Min = math.min( 1, ( os.clock( ) - Clock ) / Argument2 )
        Callback( 1 - ( 1 - Min ) ^ 3 )

        if Min >= 1 then
            return true
        end

        RunService.Heartbeat:Wait( )
    end
end

task.spawn( function()
    local Value1
    local Table = { }
    local List = Badges3.List
    Value1 = nil

    for Key, Value in List, nil, nil do
        if type( Value ) == "table" then
            local Value4 = nil

            for Key3, Value5 in Value, nil, nil do
                if Value5 ~= "" then
                    table.insert( Table, Value5 )
                end
            end
        elseif Value ~= "" then
            table.insert( Table, Value )
        end
    end

    local Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        local ImageLabel = Instance.new( "ImageLabel" )
        ImageLabel.Image = Value3
        Table[ Key2 ] = ImageLabel
    end

    pcall( function()
        game:GetService( "ContentProvider" ):PreloadAsync( Table )
    end )
end )

local function ShowBadge( Argument1, BadgeName, BadgeName2 )
    local Visible
    local Image = Badges3.Image( BadgeName, BadgeName2 )
    local Image2 = Argument1.Image
    Image2.Image = Image or ""
    local Image3 = Argument1.Image
    Visible = Image ~= nil and true or false
    local Visible2
    Image3.Visible = Visible
    local Repere = Argument1.Repere
    Visible2 = Image == nil and true or false
    local Text
    Repere.Visible = Visible2
    SetGrad( Argument1.Repere.Forme, BadgeName )
    local Division = Argument1.Repere.Division

    if BadgeName == "Unranked" then
        Text = "?"
    elseif BadgeName == "Top100" then
        Text = "100"
    elseif BadgeName == "Top1" then
        Text = "1"
    elseif BadgeName2 then
        local Entry = Table17[ BadgeName2 ]

        if Entry then
            Text = Entry
        else
            Text = ""
        end
    else
        Text = ""
    end

    Division.Text = Text
end

local function Frac( Argument1 )
    local Of = Ranks.Of( Argument1 )

    if Of.ceil then
        return ( math.clamp( ( Argument1 - Of.floor ) / ( Of.ceil - Of.floor ), 0, 1 ) )
    end
    return 1
end

local function SetRank( Rank )
    local Of = Ranks.Of( Rank )
    ShowBadge( Progression.Badge, Of.rank.id, Of.division )
    SetGrad( Progression.Lueur, Of.rank.id )
    SetGrad( Piste.Masque.Rempli.Forme, Of.rank.id )
    SetGrad( Progression.Carte, Of.rank.id )
    local Palier = Progression.Palier
    Palier.Text = Of.label:upper( )

    if not ( Of.floor > 0 ) or not Ranks.Of( Of.floor - 1 ) then
    end

    local Visible
    local NextOf = Ranks.NextOf( Of )
    local Avant = Barre.Avant
    local NomAvant = Barre.NomAvant
    Avant.Visible = false
    NomAvant.Visible = false
    local Apres = Barre.Apres
    local NomApres = Barre.NomApres
    Visible = NextOf ~= nil and true or false
    local Visible2 = NextOf ~= nil and true or false
    local Visible3
    Apres.Visible = Visible
    NomApres.Visible = Visible2
    local Suivant = Barre.Suivant
    local Separation = Barre.Separation
    Visible3 = NextOf ~= nil and true or false
    local Visible4 = NextOf ~= nil and true or false
    local Text
    Suivant.Visible = Visible3
    Separation.Visible = Visible4
    local Min = Barre.Min
    Min.Text = Fmt( Of.floor )
    local Max = Barre.Max

    if Of.ceil then
        local Fmt2 = Fmt( Of.ceil )

        if Fmt2 then
            Text = Fmt2
        else
            Text = ""
        end
    else
        Text = ""
    end

    Max.Text = Text

    if NextOf then
        ShowBadge( Barre.Apres, NextOf.id, NextOf.division )
        local NomApres2 = Barre.NomApres
        NomApres2.Text = NextOf.label:upper( )
    end

    return Of
end

Storage.DrawBar = function( Amount, Captured, Argument3, Amount3, Amount4 )
    local Y2
    local Masque = Piste.Masque
    local X = Piste.AbsoluteSize.X

    if X > 0 then
        local Y = Piste.AbsoluteSize.Y / X

        if Y then
            Y2 = Y
        else
            Y2 = 0.035
        end
    else
        Y2 = 0.035
    end

    local Number3
    local Number = Amount3 or 0
    local Number2 = Amount4 or 0

    if not ( Captured + 0.002 < Argument3 ) or not ( Captured < Y2 ) then
        Amount = Amount
        Number3 = Captured
    else
        Amount = 0
        Number3 = 0
    end

    local Visible
    local Rempli = Masque.Rempli
    Visible = Amount > 0.002 and true or false
    local Visible2
    Rempli.Visible = Visible
    local Rempli2 = Masque.Rempli
    Rempli2.Size = UDim2.fromScale( Amount, 1 )
    local Number4 = Argument3 - Number3
    Visible2 = math.max( 0.002, Y2 ) <= Number4 and true or false
    Masque.Perte.Visible = Visible2

    if Visible2 then
        local Max = math.max( 0, Number3 - Y2 )
        local Perte = Masque.Perte
        Perte.Position = UDim2.fromScale( Max, 0.5 )
        local Perte2 = Masque.Perte
        Perte2.Size = UDim2.fromScale( Argument3 - Max, 1 )
    end

    local Number5 = if not ( Number + 0.002 < Number2 ) or not ( Number < Y2 ) then Number else 0
    local Visible3
    local Number6 = Number2 - Number5
    Visible3 = math.max( 0.002, Y2 ) <= Number6 and true or false
    Masque.Gain.Visible = Visible3

    if Visible3 then
        local Gain = Masque.Gain
        Gain.Position = UDim2.fromScale( Number5, 0.5 )
        local Gain2 = Masque.Gain
        Gain2.Size = UDim2.fromScale( Number2 - Number5, 1 )
    end
end

Storage.SetPuce = function( Argument1, Amount )
    local Text
    local Puce = Piste.Puce
    Puce.Position = UDim2.fromScale( math.clamp( Argument1, 0.04, 0.96 ), 0.5 )
    local Texte = Piste.Puce.Texte
    Text = not ( Amount > 0 ) and "" or "+"
    local Text2
    Texte.Text = Text .. tostring( Amount )
    local Puce2 = Piste.Puce

    if Amount > 0 then
        Text2 = "Plus"
    elseif Amount < 0 then
        Text2 = "Moins"
    else
        Text2 = "Zero"
    end

    SetGrad( Puce2, Text2 )
end

Storage.SetProgress = function( Progress )
    local Libelle = Barre.Libelle
    Libelle.Text = ( "RANK PROGRESS  %d%%" ):format( ( math.floor( Progress * 100 + 0.5 ) ) )
end

Storage.SetElo = function( Elo )
    local Elo2 = Progression.Elo
    Elo2.Text = Fmt( Elo ) .. " ELO"
end

Storage.Table21 = {
    Progression.Elo.AnchorPoint,
    Progression.Elo.Position,
    Progression.Elo.TextXAlignment
}

Storage.EloCentered = function( Argument1 )
    local AnchorPoint
    local Elo = Progression.Elo

    if true then
        AnchorPoint = Storage.Table21[ 1 ]
    else
        local Vector22 = Vector2.new( 0.5, 0.5 )

        if Vector22 then
            AnchorPoint = Vector22
        else
            AnchorPoint = Storage.Table21[ 1 ]
        end
    end

    local Position
    Elo.AnchorPoint = AnchorPoint
    local Elo2 = Progression.Elo

    if true then
        Position = Storage.Table21[ 2 ]
    else
        local UDim22 = UDim2.new( 0.5, 0, Storage.Table21[ 2 ].Y.Scale, Storage.Table21[ 2 ].Y.Offset )

        if UDim22 then
            Position = UDim22
        else
            Position = Storage.Table21[ 2 ]
        end
    end

    local TextXAlignment
    Elo2.Position = Position
    local Elo3 = Progression.Elo
    TextXAlignment = not true and Enum.TextXAlignment.Center or Storage.Table21[ 3 ]
    Elo3.TextXAlignment = TextXAlignment
end

Storage.Bump = function( Object, Scale )
    local Pop = Object:FindFirstChild( "Pop" )

    if Pop then
        Pop.Scale = Scale
        local Table = { Scale = 1 }
        TweenService:Create( Pop, TweenInfo.new( 0.38, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
    end
end

Storage.Banner = function( Text, Argument2 )
    local Annonce = Progression.Annonce
    Annonce.Text = Text
    SetGrad( Annonce, Argument2 )
    Annonce.Visible = true
    local Pop = Annonce:FindFirstChild( "Pop" )

    if Pop then
        Pop.Scale = 1.7
        local Table = { Scale = 1 }
        TweenService:Create( Pop, TweenInfo.new( 0.32, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
    end
end

Storage.SetStatus = function( Text, Argument2 )
    local TextTransparency
    Progression.Statut.Text = Text
    SetGrad( Progression.Statut, Argument2 )
    Progression.Statut.TextTransparency = 1
    Progression.Statut.Contour.Transparency = 1
    local Statut = Progression.Statut
    local Table = { }
    local Statut2 = Progression.Statut
    local Entry = Table18[ Statut2 ]
    TextTransparency = if Entry then Table18[ Statut2 ].TextTransparency else Entry
    local Transparency
    Table.TextTransparency = TextTransparency
    TweenService:Create( Statut, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
    local Contour = Progression.Statut.Contour
    local Table2 = { }
    local Contour2 = Progression.Statut.Contour
    local Entry2 = Table18[ Contour2 ]
    Transparency = if Entry2 then Table18[ Contour2 ].Transparency else Entry2
    Table2.Transparency = Transparency
    TweenService:Create( Contour, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
end

Storage.StatusFor = function( Argument1, Argument2 )
    local After = Argument1.after
    local After2 = Argument1.after - Argument1.before
    local Of = Ranks.Of( After )

    if Argument1.placement then
        return "PLACEMENTS DONE: WELCOME TO " .. Of.label:upper( ), "Or"
    end
    if Argument1.safe and After2 > 0 then
        return "PROMOTED! YOUR NEXT MATCH CAN'T DROP YOU", "Or"
    end
    if After2 == 0 and not Argument2 then
        return "RANK PROTECTED: NO ELO LOST", "Bon"
    end
    if Argument1.safe then
        return "PROTECTED: YOUR NEXT MATCH CAN'T DROP YOU", "Bon"
    end
    if not Of.ceil then
        return "TOP RANK: CLIMB THE LEADERBOARD", "Or"
    end

    local Clamp
    local Of2 = Ranks.Of( After )

    if Of2.ceil then
        Clamp = math.clamp( ( After - Of2.floor ) / ( Of2.ceil - Of2.floor ), 0, 1 )
    else
        Clamp = 1
    end

    local Upper = Ranks.NextOf( Of ).label:upper( )

    if After2 < 0 and Ranks.Of( Argument1.before ).label ~= Of.label then
        return ( "%d ELO TO GET BACK TO %s" ):format( Of.ceil - After, Upper ), "Normal"
    end
    if Clamp >= 0.8 then
        return ( "ALMOST THERE: %d ELO TO %s" ):format( Of.ceil - After, Upper ), "Or"
    end
    if not ( Of.floor > 0 ) or not ( Clamp <= 0.2 ) or not ( After2 < 0 ) then
        return ( "%d ELO TO %s" ):format( Of.ceil - After, Upper ), "Normal"
    end
    return ( "DEMOTION RISK: %d ELO LEFT IN %s" ):format( After - Of.floor, Of.label:upper( ) ), "Danger"
end

Storage.BuildPlacement = function( Number, Argument2 )
    local Matches = Config.Placement.matches
    local Parent = Progression.Placement

    for Key, Value in Parent:GetChildren( ) do
        if Value:IsA( "GuiObject" ) then
            Value:Destroy( )
        end
    end

    local Clone2
    local I = 1
    Clone2 = nil

    for I = 1, Matches do
        local Text
        local Clone = Templates.Pip:Clone( )
        Clone.Name = "Case" .. I
        Clone.LayoutOrder = I

        if I < Number then
            Text = "PleinMoi"
        elseif I ~= Number or Argument2 then
            Text = "Vide"
        else
            Text = "PleinMoi"
        end

        SetGrad( Clone, Text )
        Clone.Parent = Parent

        if I == Number then
            Clone2 = Clone
        end
    end

    return Clone2
end

Storage.Table22 = { }
Storage.Table23 = { }
Storage.Table24 = { }

Storage.Spark = function()
    local Etincelle = Templates.Etincelle

    if #Storage.Table23 == 0 then
        local I = 1

        for I = 1, 28 do
            local Clone = Etincelle:Clone( )
            Clone.Name = "Etincelle" .. I
            Clone.Visible = false
            Clone.Parent = Decor.Etincelles
            table.insert( Storage.Table23, Clone )
            table.insert( Storage.Table22, Clone )
            Storage.Table24[ Clone ] = 0
        end
    end

    local Remove = table.remove( Storage.Table22 )

    if not Remove then
        return
    end

    local Number
    Storage.Table24[ Remove ] = Storage.Table24[ Remove ] + 1
    local Entry = Storage.Table24[ Remove ]
    Number = not ( math.random( ) < 0.5 ) and 1 or -1
    local Random = 0.5 + ( math.random( ) - 0.5 ) * 0.1
    local Number2 = 0.5 + Number * ( 0.14 + math.random( ) * 0.34 )
    local Random2 = Random + ( math.random( ) - 0.5 ) * 0.16
    local Random3 = 0.6 + math.random( ) * 0.8
    local Size = Etincelle.Size
    local UIStroke = Remove:FindFirstChildOfClass( "UIStroke" )
    local UIStroke2 = Etincelle:FindFirstChildOfClass( "UIStroke" )
    Remove.Size = UDim2.new( Size.X.Scale * Random3, Size.X.Offset * Random3, Size.Y.Scale * Random3, Size.Y.Offset * Random3 )
    Remove.Position = UDim2.fromScale( 0.5, Random )
    Remove.Rotation = Etincelle.Rotation
    Remove.BackgroundTransparency = 1

    if UIStroke then
        UIStroke.Transparency = 1
    end

    Remove.Visible = true
    local Random4 = 1.2 + math.random( ) * 1.1
    local TweenInfo2 = TweenInfo.new( Random4 * 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
    TweenService:Create( Remove, TweenInfo2, { BackgroundTransparency = Etincelle.BackgroundTransparency } ):Play( )

    if UIStroke and UIStroke2 then
        TweenService:Create( UIStroke, TweenInfo2, { Transparency = UIStroke2.Transparency } ):Play( )
    end

    task.delay( Random4 * 0.45, function()
        if Storage.Table24[ Remove ] ~= Entry then
            return
        end

        local TweenInfo2 = TweenInfo.new( Random4 * 0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In )
        TweenService:Create( Remove, TweenInfo2, { BackgroundTransparency = 1 } ):Play( )

        if UIStroke then
            TweenService:Create( UIStroke, TweenInfo2, { Transparency = 1 } ):Play( )
        end
    end )
    local Create = TweenService:Create( Remove, TweenInfo.new( Random4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Position = UDim2.fromScale( Number2, Random2 ) } )
    Create.Completed:Once( function()
        if Storage.Table24[ Remove ] == Entry then
            Remove.Visible = false
            table.insert( Storage.Table22, Remove )
            return
        end
        return
    end )
    Create:Play( )
end

Storage.ResetSparks = function()
    local Value1
    table.clear( Storage.Table22 )
    Value1 = nil

    for Key, Value in Storage.Table23, nil, nil do
        Storage.Table24[ Value ] = Storage.Table24[ Value ] + 1
        Value.Visible = false
        table.insert( Storage.Table22, Value )
    end
end

Storage.Table25 = { }
Storage.Table26 = { "Bandeau", "LigneHaut", "LigneBas" }
Storage.Value20 = nil

for Key7, Value21 in Storage.Table26, nil, nil do
    Storage.FoundChild2 = Ecran:FindFirstChild( Value21 )

    if Storage.FoundChild2 then
        Storage.Table25[ Value21 ] = Storage.FoundChild2.Size
    end
end

Storage.PlayIntro = function( Argument1, IntroName )
    local Flag = IntroName == "Victoire" and true or false
    local Value1
    local TableInner = { "Halo", "Embleme", "Trait" }
    Value1 = nil

    for Key, Value in TableInner, nil, nil do
        local FoundChild2 = Decor:FindFirstChild( Value )

        if FoundChild2 then
            SetGrad( FoundChild2, IntroName )
        end
    end

    local BackgroundTransparency
    Resultats.Voile.BackgroundTransparency = 1
    local Voile = Resultats.Voile
    local Table2 = { }
    local Voile2 = Resultats.Voile
    local Entry = Table18[ Voile2 ]
    BackgroundTransparency = if Entry then Table18[ Voile2 ].BackgroundTransparency else Entry
    local Value2
    Table2.BackgroundTransparency = BackgroundTransparency
    TweenService:Create( Voile, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
    local Table3 = { "Bandeau", "LigneHaut", "LigneBas" }
    Value2 = nil

    for Key2, Value3 in Table3, nil, nil do
        local FoundChild = Ecran:FindFirstChild( Value3 )

        if FoundChild then
            local Entry16 = Storage.Table25[ Value3 ]
            FoundChild.Size = UDim2.fromScale( 0, Entry16.Y.Scale )
            local Table13 = { Size = Entry16 }
            TweenService:Create( FoundChild, TweenInfo.new( 0.4, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table13 ):Play( )
        end
    end

    local Reflet = Ecran.Bandeau:FindFirstChild( "Reflet" )

    if Reflet then
        Reflet.BackgroundTransparency = 1
        Reflet.Position = UDim2.fromScale( 0.22, Reflet.Position.Y.Scale )
        task.delay( 0.3, function()
            if Argument1 ~= Number2 then
                return
            end

            local Table = { Position = UDim2.fromScale( 0.78, Reflet.Position.Y.Scale ) }
            TweenService:Create( Reflet, TweenInfo.new( 0.9, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.InOut or Enum.EasingDirection.Out ), Table ):Play( )
            local Table2 = { BackgroundTransparency = 0 }
            TweenService:Create( Reflet, TweenInfo.new( 0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
            task.delay( 0.62, function()
                if Argument1 == Number2 then
                    local Table = { BackgroundTransparency = 1 }
                    TweenService:Create( Reflet, TweenInfo.new( 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
                end
            end )
        end )
    end

    local Entry3
    local Titre = Ecran.Titre
    local Pop = Titre.Pop
    local Entry2 = Table18[ Pop ]
    Entry3 = if Entry2 then Table18[ Pop ].Scale else Entry2
    local Pop2 = Titre.Pop
    Pop2.Scale = Entry3 * 1.5
    local Contour = Titre.Contour
    Titre.TextTransparency = 1
    Contour.Transparency = 1
    local Pop3 = Titre.Pop
    local Table4 = { Scale = Entry3 * 0.97 }
    local TextTransparency
    local Create = TweenService:Create( Pop3, TweenInfo.new( 0.12, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out ), Table4 )
    Create:Play( )
    Create.Completed:Once( function( Argument1Inner )
        if Argument1 ~= Number2 or Argument1Inner ~= Enum.PlaybackState.Completed then
            return
        end

        local Pop = Titre.Pop
        local TableInner = { Scale = Entry3 }
        local Number
        TweenService:Create( Pop, TweenInfo.new( 0.3, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), TableInner ):Play( )
        local Shake = Table.shake
        Number = not Flag and 0.0025 or 0.004
        Shake( Ecran, Number, 0.3 )
    end )
    local Table5 = { }
    local Entry4 = Table18[ Titre ]
    TextTransparency = if Entry4 then Table18[ Titre ].TextTransparency else Entry4
    local Transparency
    Table5.TextTransparency = TextTransparency
    TweenService:Create( Titre, TweenInfo.new( 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table5 ):Play( )
    local Contour2 = Titre.Contour
    local Table6 = { }
    local Contour3 = Titre.Contour
    local Entry5 = Table18[ Contour3 ]
    Transparency = if Entry5 then Table18[ Contour3 ].Transparency else Entry5
    local Brillance
    Table6.Transparency = Transparency
    TweenService:Create( Contour2, TweenInfo.new( 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table6 ):Play( )
    local Reflet2 = Titre:FindFirstChild( "Reflet" )

    if Reflet2 then
        Brillance = Reflet2:FindFirstChild( "Brillance" )
    else
        Brillance = Reflet2
    end
    if Reflet2 then
        Reflet2.Text = Titre.Text
        Reflet2.Visible = false

        if Brillance then
            game:GetService( "CollectionService" ):RemoveTag( Brillance, "VipName" )
        end
        if Flag then
            task.delay( 0.7, function()
                if Argument1 ~= Number2 then
                    return
                end

                Reflet2.Visible = true

                if Brillance then
                    game:GetService( "CollectionService" ):AddTag( Brillance, "VipName" )
                end
            end )
        end
    end

    local Value4
    local Table7 = { Ecran.Score, Ecran.Raison }
    Value4 = nil

    for Key3, Value5 in Table7, nil, nil do
        local Contour4 = Value5.Contour
        Value5.TextTransparency = 1
        Contour4.Transparency = 1
        task.delay( 0.22 + Key3 * 0.08, function()
            if Argument1 ~= Number2 then
                return
            end

            local TextTransparency
            local TableInner = { }
            local Entry = Table18[ Value5 ]
            TextTransparency = if Entry then Table18[ Value5 ].TextTransparency else Entry
            local Transparency
            TableInner.TextTransparency = TextTransparency
            TweenService:Create( Value5, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), TableInner ):Play( )
            local Contour = Value5.Contour
            local Table2 = { }
            local Contour2 = Value5.Contour
            local Entry2 = Table18[ Contour2 ]
            Transparency = if Entry2 then Table18[ Contour2 ].Transparency else Entry2
            Table2.Transparency = Transparency
            TweenService:Create( Contour, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
            Table.slide( Value5, 0, 0.015, 0.4, true )
        end )
    end

    local Equipes = Ecran:FindFirstChild( "Equipes" )

    if Equipes then
        local Slide = Table.slide
        Slide( Equipes.Moi, -0.03, 0, 0.45, true )
        local Slide2 = Table.slide
        Slide2( Equipes.Adv, 0.03, 0, 0.45, true )
    end
    if Decor.Visible then
        local Halo = Decor:FindFirstChild( "Halo" )

        if Halo then
            local GroupTransparency
            Halo.GroupTransparency = 1
            local Table8 = { }
            local Entry6 = Table18[ Halo ]
            GroupTransparency = if Entry6 then Table18[ Halo ].GroupTransparency else Entry6
            Table8.GroupTransparency = GroupTransparency
            TweenService:Create( Halo, TweenInfo.new( 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table8 ):Play( )
            local Pop4 = Halo:FindFirstChild( "Pop" )

            if Pop4 then
                local Entry8
                local Entry7 = Table18[ Pop4 ]
                Entry8 = if Entry7 then Table18[ Pop4 ].Scale else Entry7
                local Scale
                Pop4.Scale = Entry8 * 0.35
                local Table9 = { }
                local Entry9 = Table18[ Pop4 ]
                Scale = if Entry9 then Table18[ Pop4 ].Scale else Entry9
                Table9.Scale = Scale
                TweenService:Create( Pop4, TweenInfo.new( 0.7, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table9 ):Play( )
            end
        end

        local Embleme = Decor:FindFirstChild( "Embleme" )

        if Embleme then
            local GroupTransparency2
            Embleme.GroupTransparency = 1
            local Table10 = { }
            local Entry10 = Table18[ Embleme ]
            GroupTransparency2 = if Entry10 then Table18[ Embleme ].GroupTransparency else Entry10
            Table10.GroupTransparency = GroupTransparency2
            TweenService:Create( Embleme, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table10 ):Play( )
            local Pop5 = Embleme:FindFirstChild( "Pop" )

            if Pop5 then
                local Entry12
                local Entry11 = Table18[ Pop5 ]
                Entry12 = if Entry11 then Table18[ Pop5 ].Scale else Entry11
                local Number = not Flag and 1.25 or 1.7
                local Scale2
                Pop5.Scale = Entry12 * Number
                local Table11 = { }
                local Entry13 = Table18[ Pop5 ]
                Scale2 = if Entry13 then Table18[ Pop5 ].Scale else Entry13
                Table11.Scale = Scale2
                TweenService:Create( Pop5, TweenInfo.new( 0.5, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table11 ):Play( )
            end
        end

        local Trait = Decor:FindFirstChild( "Trait" )

        if Trait then
            local Entry15
            local Entry14 = Table18[ Trait ]
            Entry15 = if Entry14 then Table18[ Trait ].Size else Entry14
            Trait.Size = UDim2.new( 0, 0, Entry15.Y.Scale, Entry15.Y.Offset )
            local Table12 = { Size = Entry15 }
            TweenService:Create( Trait, TweenInfo.new( 0.55, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table12 ):Play( )
        end
    end

    local Value6
    table.clear( Storage.Table22 )
    Value6 = nil

    for Key4, Value7 in Storage.Table23, nil, nil do
        Storage.Table24[ Value7 ] = Storage.Table24[ Value7 ] + 1
        Value7.Visible = false
        table.insert( Storage.Table22, Value7 )
    end
    if Flag and Decor.Visible then
        local I = 1

        for I = 1, 14 do
            Storage.Spark( )
        end
    end
end

Storage.Number3 = 0
RunService.Heartbeat:Connect( function( Argument1 )
    if not Resultats.Visible then
        return
    end
    if Value15 == "Victoire" and Decor.Visible then
        Storage.Number3 = Storage.Number3 + Argument1

        if Storage.Number3 > 0.09 then
            Storage.Number3 = 0
            Storage.Spark( )
        end
    end
end )

Storage.PlayRank = function( Argument1, Argument2, Argument3, Argument4 )
    local Matches = Config.Placement.matches
    local Clan = Progression:FindFirstChild( "Clan" )

    if Clan then
        local Visible

        if type( Argument2 ) == "table" then
            if Argument2.clan == true then
                Visible = not Argument4
            else
                Visible = false
            end
        else
            Visible = false
        end

        Clan.Visible = Visible

        if Visible then
            local TagRich2
            local ClanTag = Argument2.clanTag
            local ClanName = Argument2.clanName
            local ClanCc = Argument2.clanCc

            if type( ClanTag ) ~= "string" or ClanTag == "" then
                TagRich2 = nil
            else
                local TagRich = ClanShared2.TagRich( ClanTag, ClanCc )

                if TagRich then
                    TagRich2 = TagRich
                else
                    TagRich2 = nil
                end
            end

            local Gsub

            if TagRich2 then
                local Text = TagRich2 .. " " .. tostring( ClanName or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )

                if Text then
                    Gsub = Text
                else
                    Gsub = tostring( ClanName or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
                end
            else
                Gsub = tostring( ClanName or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
            end

            Clan.Text = "CLAN  " .. Gsub
        end
    end

    local Flag
    Progression.Annonce.Visible = false
    Progression.Statut.Text = ""
    Progression.GroupTransparency = 1
    Bas.GroupTransparency = 1
    Piste.Puce.Visible = false
    task.wait( 0.5 )
    Flag = Argument1 == Number2 and true or false

    if not Flag then
        return
    end
    if Argument4 then
        local GroupTransparency
        local TableInner = { }
        local Entry = Table18[ Bas ]
        GroupTransparency = if Entry then Table18[ Bas ].GroupTransparency else Entry
        TableInner.GroupTransparency = GroupTransparency
        TweenService:Create( Bas, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), TableInner ):Play( )
        Table.slide( Bas, 0, 0.025, 0.4 )
        return
    end
    local GroupTransparency2
    local Table2 = { }
    local Entry2 = Table18[ Progression ]
    GroupTransparency2 = if Entry2 then Table18[ Progression ].GroupTransparency else Entry2
    Table2.GroupTransparency = GroupTransparency2
    TweenService:Create( Progression, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
    Table.slide( Progression, 0, 0.03, 0.45 )
    task.delay( 0.45, function()
        if Argument1 ~= Number2 then
            return
        end

        local GroupTransparency
        local TableInner = { }
        local Entry = Table18[ Bas ]
        GroupTransparency = if Entry then Table18[ Bas ].GroupTransparency else Entry
        TableInner.GroupTransparency = GroupTransparency
        TweenService:Create( Bas, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), TableInner ):Play( )
        Table.slide( Bas, 0, 0.025, 0.4 )
    end )

    if not Argument2 or not Argument2.after then
        local Visible6
        local Badge4 = Progression.Badge
        local Image7 = Badges3.Image( "Unranked", nil )
        local Image8 = Badge4.Image
        Image8.Image = Image7 or ""
        local Image9 = Badge4.Image
        Visible6 = Image7 ~= nil and true or false
        local Visible7
        Image9.Visible = Visible6
        local Repere3 = Badge4.Repere
        Visible7 = Image7 == nil and true or false
        Repere3.Visible = Visible7
        SetGrad( Badge4.Repere.Forme, "Unranked" )
        Badge4.Repere.Division.Text = "?"
        SetGrad( Progression.Lueur, "Unranked" )
        SetGrad( Progression.Carte, "Unranked" )
        Progression.Palier.Text = "RESULT"
        Progression.Elo.Text = "Not saved"
        Progression.Delta.Visible = false
        Storage.EloCentered( true )
        local Placement4 = Progression.Placement
        Barre.Visible = false
        Placement4.Visible = false
        Storage.SetStatus( "YOUR ELO WILL UPDATE ON YOUR NEXT MATCH", "Normal" )
        return
    end
    local Placement2
    local Floor = math.floor( Argument2.before + 0.5 )
    local Floor2 = math.floor( Argument2.after + 0.5 )
    local Floor3 = Floor2 - Floor
    local Number = tonumber( Argument2.placed ) or 0
    local Placement = Argument2.placement

    if Placement then
        if Number < Matches then
            Placement2 = true
        else
            Placement2 = false
        end
    else
        Placement2 = Placement
    end

    local Text2
    local Delta = Progression.Delta
    Text2 = not ( Floor3 > 0 ) and "" or "+"
    local Text3
    Delta.Text = Text2 .. tostring( Floor3 ) .. " ELO"
    local Delta2 = Progression.Delta

    if Floor3 > 0 then
        Text3 = "Plus"
    elseif Floor3 < 0 then
        Text3 = "Moins"
    else
        Text3 = "Zero"
    end

    SetGrad( Delta2, Text3 )

    if Placement2 then
        local Visible2
        local Badge = Progression.Badge
        local Image = Badges3.Image( "Unranked", nil )
        local Image2 = Badge.Image
        Image2.Image = Image or ""
        local Image3 = Badge.Image
        Visible2 = Image ~= nil and true or false
        local Visible3
        Image3.Visible = Visible2
        local Repere = Badge.Repere
        Visible3 = Image == nil and true or false
        local Flag2
        Repere.Visible = Visible3
        SetGrad( Badge.Repere.Forme, "Unranked" )
        Badge.Repere.Division.Text = "?"
        SetGrad( Progression.Lueur, "Unranked" )
        SetGrad( Progression.Carte, "Unranked" )
        Progression.Palier.Text = "UNRANKED"
        local Elo = Progression.Elo
        Elo.Text = ( "PLACEMENT %d / %d" ):format( Number, Matches )
        Progression.Delta.Visible = false
        Storage.EloCentered( true )
        local Placement3 = Progression.Placement
        Barre.Visible = false
        Placement3.Visible = true
        local Value1 = Storage.BuildPlacement( Number, true )
        task.wait( 0.5 )
        Flag2 = Argument1 == Number2 and true or false

        if not Flag2 then
            return
        end
        if Value1 then
            SetGrad( Value1, "PleinMoi" )
            local Pop = Value1:FindFirstChild( "Pop" )

            if Pop then
                Pop.Scale = 1.5
                local Table3 = { Scale = 1 }
                TweenService:Create( Pop, TweenInfo.new( 0.38, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table3 ):Play( )
            end

            Sfx.Play( "CaseRemplie" )
        end

        local Text4
        local Matches2 = Matches - Number
        Text4 = not ( Matches2 > 1 ) and "" or "ES"
        Storage.SetStatus( ( "%d PLACEMENT MATCH%s LEFT" ):format( Matches2, Text4 ), "Normal" )
        return
    end
    local Flag3
    Progression.Placement.Visible = false
    local Delta3 = Progression.Delta
    Delta3.Visible = not Argument2.placement
    Flag3 = Argument2.placement == true and true or false
    Storage.EloCentered( Flag3 )

    if not Argument2.placement then
        local Clamp2
        Barre.Visible = true
        SetRank( Floor )
        local Elo4 = Progression.Elo
        Elo4.Text = Fmt( Floor ) .. " ELO"
        local Of2 = Ranks.Of( Floor )

        if Of2.ceil then
            Clamp2 = math.clamp( ( Floor - Of2.floor ) / ( Of2.ceil - Of2.floor ), 0, 1 )
        else
            Clamp2 = 1
        end

        Storage.DrawBar( Clamp2, 0, 0 )
        local Libelle = Barre.Libelle
        Libelle.Text = ( "RANK PROGRESS  %d%%" ):format( ( math.floor( Clamp2 * 100 + 0.5 ) ) )
        Piste.Puce.Visible = false
        Storage.SetPuce( Clamp2, Floor3 )
        local Pop3 = Progression.Delta:FindFirstChild( "Pop" )

        if Pop3 then
            Pop3.Scale = 1.6
            local Table5 = { Scale = 1 }
            TweenService:Create( Pop3, TweenInfo.new( 0.38, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table5 ):Play( )
        end

        local Flag5
        task.wait( 0.55 )
        Flag5 = Argument1 == Number2 and true or false

        if not Flag5 then
            return
        end

        local Number8 = not ( Floor3 >= 0 ) and -1 or 1
        local Number2Inner, Floor4
        Number2Inner = 0
        Floor4 = Floor

        while Floor3 ~= 0 do
            if not ( Number2Inner < 12 ) then
                break
            end

            local Flag6, Floor5
            Number2Inner = Number2Inner + 1
            local Of3 = Ranks.Of( Floor4 )

            if not ( Number8 > 0 ) or not Of3.ceil or not ( Of3.ceil <= Floor2 ) then
                Flag6 = false
                Floor5 = Floor2
            else
                Flag6 = true
                Floor5 = Of3.ceil
            end
            if Number8 < 0 and Floor2 < Of3.floor then
                Flag6 = true
                Floor5 = Of3.floor
            end

            local Clamp3
            local Of4 = Ranks.Of( Floor4 )

            if Of4.ceil then
                Clamp3 = math.clamp( ( Floor4 - Of4.floor ) / ( Of4.ceil - Of4.floor ), 0, 1 )
            else
                Clamp3 = 1
            end

            local Clamp4

            if Flag6 then
                if Number8 > 0 then
                    Clamp4 = 1
                else
                    Clamp4 = 0
                end
            else
                local Of5 = Ranks.Of( Floor5 )

                if Of5.ceil then
                    Clamp4 = math.clamp( ( Floor5 - Of5.floor ) / ( Of5.ceil - Of5.floor ), 0, 1 )
                else
                    Clamp4 = 1
                end
            end

            local Tete = Piste:FindFirstChild( "Tete" )

            if Tete then
                Tete.BackgroundTransparency = 0
                Tete.Visible = true
            end

            local Swap = Floor4
            local Over2 = Over( Argument1, math.clamp( math.abs( Clamp4 - Clamp3 ) * 1.5, 0.35, 1.5 ), function( Amount )
                local Captured = Clamp3 + ( Clamp4 - Clamp3 ) * Amount

                if Number8 > 0 then
                    Storage.DrawBar( Captured, 0, 0, Clamp3, Captured )
                else
                    Storage.DrawBar( Captured, Captured, Clamp3 )
                end

                Storage.SetPuce( Captured, Floor3 )
                local Libelle = Barre.Libelle
                Libelle.Text = ( "RANK PROGRESS  %d%%" ):format( ( math.floor( Captured * 100 + 0.5 ) ) )
                local Captured2 = Swap + ( Floor5 - Swap ) * Amount
                local Elo = Progression.Elo
                Elo.Text = Fmt( Captured2 ) .. " ELO"

                if Tete then
                    Tete.Position = UDim2.fromScale( Captured, 0.5 )
                end
            end )

            if Tete then
                local Table6 = { BackgroundTransparency = 1 }
                TweenService:Create( Tete, TweenInfo.new( 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table6 ):Play( )
            end
            if not Over2 then
                return
            end
            if not Flag6 then
                break
            end
            local Ceil = Number8 > 0 and Of3.ceil or Of3.floor - 1
            local Flag8 = Ranks.Of( Ceil ).rank.id ~= Of3.rank.id and true or false
            local Flag9

            if Number8 > 0 then
                if Of3.nextId == nil then
                    Flag9 = false
                else
                    Flag9 = true
                end
            else
                Flag9 = false
            end

            local Flag7
            task.wait( 0.12 )
            Flag7 = Argument1 == Number2 and true or false

            if not Flag7 then
                return
            end

            SetRank( Ceil )
            local Flash2 = Progression:FindFirstChild( "Flash" )
            local Onde = Progression.Badge:FindFirstChild( "Onde" )

            if Number8 > 0 then
                local Scale
                local Badge3 = Progression.Badge
                Scale = ( Flag8 or Flag9 ) and 0.6 or 0.75
                local Pop4 = Badge3:FindFirstChild( "Pop" )

                if Pop4 then
                    Pop4.Scale = Scale
                    local Table7 = { Scale = 1 }
                    TweenService:Create( Pop4, TweenInfo.new( 0.38, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table7 ):Play( )
                end

                local Text5

                if Flag9 then
                    Text5 = "TOP 100 UNLOCKED"
                elseif Flag8 then
                    Text5 = "RANK UP!"
                else
                    Text5 = "DIVISION UP"
                end

                local Text6
                Storage.Banner( Text5, "Haut" )
                Sfx.StopAll( 0.25 )
                local Play = Sfx.Play
                Text6 = ( Flag8 or Flag9 ) and "RangUp" or "DivisionUp"
                local Number3
                Play( Text6 )
                local Flash3 = Table.flash
                Number3 = not Flag8 and 0.65 or 0.4
                local Number4 = not Flag8 and 0.45 or 0.6
                local Number5
                Flash3( Flash2, "Haut", Number3, Number4 )
                local Ring2 = Table.ring
                Number5 = not Flag8 and 1.25 or 1.4
                local Number6 = not Flag8 and 0.55 or 0.7
                Ring2( Onde, "Haut", Number5, Number6 )

                if Flag8 then
                    Resultats.Eclair.BackgroundTransparency = 0.55
                    local Eclair = Resultats.Eclair
                    local Table8 = { BackgroundTransparency = 1 }
                    TweenService:Create( Eclair, TweenInfo.new( 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table8 ):Play( )
                    Table.shake( Progression, 0.003, 0.3 )
                end
            else
                local Pop5 = Progression.Badge:FindFirstChild( "Pop" )

                if Pop5 then
                    Pop5.Scale = 0.8
                    local Table9 = { Scale = 1 }
                    TweenService:Create( Pop5, TweenInfo.new( 0.38, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table9 ):Play( )
                end

                local Text7 = not Flag8 and "DIVISION DOWN" or "RANK DOWN"
                local Volume
                Storage.Banner( Text7, "Bas" )
                Sfx.StopAll( 0.25 )
                local Play2 = Sfx.Play
                local Table10 = { }
                Volume = not Flag8 and 1 or 1.2
                Table10.volume = Volume
                Play2( "Descente", Table10 )
                Table.flash( Flash2, "Bas", 0.6, 0.5 )
                local Shake = Table.shake
                Shake( Progression.Badge, 0.006, 0.3 )
            end

            local Number7 = ( not ( Number8 > 0 ) or Flag9 ) and 1 or 0
            local Flag10
            Storage.DrawBar( Number7, 0, 0 )
            Storage.SetPuce( Number7, Floor3 )
            task.wait( 0.6 )
            Flag10 = Argument1 == Number2 and true or false

            if not Flag10 then
                return
            end

            Floor4 = Ceil
        end

        local Elo5 = Progression.Elo
        Elo5.Text = Fmt( Floor2 ) .. " ELO"
        Storage.SetStatus( Storage.StatusFor( Argument2, Argument3 ) )
        return
    end
    local Visible4
    local Badge2 = Progression.Badge
    local Image4 = Badges3.Image( "Unranked", nil )
    local Image5 = Badge2.Image
    Image5.Image = Image4 or ""
    local Image6 = Badge2.Image
    Visible4 = Image4 ~= nil and true or false
    local Visible5
    Image6.Visible = Visible4
    local Repere2 = Badge2.Repere
    Visible5 = Image4 == nil and true or false
    local Flag4
    Repere2.Visible = Visible5
    SetGrad( Badge2.Repere.Forme, "Unranked" )
    Badge2.Repere.Division.Text = "?"
    SetGrad( Progression.Lueur, "Unranked" )
    SetGrad( Progression.Carte, "Unranked" )
    Progression.Palier.Text = "UNRANKED"
    local Elo2 = Progression.Elo
    Elo2.Text = ( "PLACEMENT %d / %d" ):format( Matches, Matches )
    Barre.Visible = false
    task.wait( 0.7 )
    Flag4 = Argument1 == Number2 and true or false

    if not Flag4 then
        return
    end

    SetRank( Floor2 )
    local Pop2 = Progression.Badge:FindFirstChild( "Pop" )

    if Pop2 then
        Pop2.Scale = 0.6
        local Table4 = { Scale = 1 }
        TweenService:Create( Pop2, TweenInfo.new( 0.38, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table4 ):Play( )
    end

    local Clamp
    Storage.Banner( "PLACED", "Place" )
    Sfx.StopAll( 0.25 )
    Sfx.Play( "RangUp" )
    local Flash = Table.flash
    Flash( Progression:FindFirstChild( "Flash" ), "Haut", 0.45, 0.6 )
    local Ring = Table.ring
    Ring( Progression.Badge:FindFirstChild( "Onde" ), "Haut", 1.4, 0.7 )
    Table.shake( Progression, 0.003, 0.3 )
    local Elo3 = Progression.Elo
    Elo3.Text = Fmt( Floor2 ) .. " ELO"
    Barre.Visible = true
    local Of = Ranks.Of( Floor2 )

    if Of.ceil then
        Clamp = math.clamp( ( Floor2 - Of.floor ) / ( Of.ceil - Of.floor ), 0, 1 )
    else
        Clamp = 1
    end

    Storage.DrawBar( 0, 0, 0 )

    if Over( Argument1, 0.9, function( Amount )
        Storage.DrawBar( Clamp * Amount, 0, 0 )
        local Captured = Clamp * Amount
        local Libelle = Barre.Libelle
        Libelle.Text = ( "RANK PROGRESS  %d%%" ):format( ( math.floor( Captured * 100 + 0.5 ) ) )
    end ) then
        Storage.SetStatus( Storage.StatusFor( Argument2, Argument3 ) )
        return
    end
    return
end

Storage.ReasonText = function( Table, Argument2 )
    local EndReason
    local Reason = Table.reason

    if Reason then
        EndReason = Reason
    else
        EndReason = MatchState:GetAttribute( "EndReason" )
    end

    local Mode3
    local Mode = Table.mode

    if Mode then
        Mode3 = Mode
    else
        local Mode2 = MatchState:GetAttribute( "Mode" )

        if Mode2 then
            Mode3 = Mode2
        else
            Mode3 = ""
        end
    end

    local Upper = tostring( Mode3 ):upper( )

    if Table.abandon then
        if EndReason == "afk" then
            return "You were AFK: counted as a loss"
        end
        return "You left the match: counted as a loss"
    elseif EndReason == "left" then
        if Argument2 then
            return "The enemy team left the match"
        end
        return "Your team left the match"
    elseif EndReason ~= "afk" then
        local Text = ( Table.unranked or MatchState:GetAttribute( "Unranked" ) ) and "CASUAL " or "RANKED "
        return Text .. Upper
    elseif Argument2 then
        return "The enemy team was AFK"
    else
        return "Both teams were AFK"
    end
end

Storage.Table27 = { }

Storage.LayoutTables = function( Amount )
    local Equipes = Ecran:FindFirstChild( "Equipes" )

    if not Equipes then
        return
    end

    local Flag = Amount <= 2 and true or false
    local Number = not Flag and 43 or 54
    local Number2 = not Flag and 5 or 6
    local Number5 = not Flag and 16 or 20
    local Number6 = not Flag and 18 or 26
    local Value1
    local Number3 = Amount * ( Number + Number2 )
    local Number4 = 50 + Number3 + 4
    local Max = math.max( 0, ( 636 - ( 210 + Number5 + Number4 + Number6 + 90 ) ) / 2 ) + 256
    Progression.Position = UDim2.fromScale( Progression.Position.X.Scale, Max / 900 )
    Equipes.Position = UDim2.fromScale( Equipes.Position.X.Scale, ( Max + 210 + Number5 ) / 900 )
    Equipes.Size = UDim2.fromScale( Equipes.Size.X.Scale, Number4 / 900 )
    local Table = { Equipes.Moi, Equipes.Adv }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local function At( Argument1, Amount, Argument3, Amount2, Argument5 )
            Argument1.Position = UDim2.fromScale( Amount / 490, Argument3 / Number4 )
            Argument1.Size = UDim2.fromScale( Amount2 / 490, Argument5 / Number4 )
        end

        local Liser = Value[ "Liseré" ]
        Liser.Position = UDim2.fromScale( 0, 0 / Number4 )
        Liser.Size = UDim2.fromScale( 1, 4 / Number4 )
        local Titre = Value.Titre
        Titre.Position = UDim2.fromScale( 0.036734693877551024, 14 / Number4 )
        Titre.Size = UDim2.fromScale( 0.5306122448979592, 24 / Number4 )
        local ColElims = Value.ColElims
        ColElims.Position = UDim2.fromScale( 0.7183673469387755, 19 / Number4 )
        ColElims.Size = UDim2.fromScale( 0.12653061224489795, 15 / Number4 )
        local ColMorts = Value.ColMorts
        ColMorts.Position = UDim2.fromScale( 0.8489795918367347, 19 / Number4 )
        ColMorts.Size = UDim2.fromScale( 0.12653061224489795, 15 / Number4 )
        local Lignes = Value.Lignes
        Lignes.Position = UDim2.fromScale( 0.0163265306122449, 50 / Number4 )
        Lignes.Size = UDim2.fromScale( 0.9673469387755103, Number3 / Number4 )
        local UIListLayout = Value.Lignes.UIListLayout
        UIListLayout.Padding = UDim.new( Number2 / Number3, 0 )
        local UICorner = Value.UICorner
        UICorner.CornerRadius = UDim.new( 4.2 / Number4, 0 )

        for Key2, Value2 in Value:GetChildren( ) do
            if Value2:IsA( "UIStroke" ) and Value2.ApplyStrokeMode == Enum.ApplyStrokeMode.Border then
                Value2.Thickness = 1.92 / Number4
            end
        end
    end

    Bas.Position = UDim2.fromScale( Bas.Position.X.Scale, ( Max + 210 + Number5 + Number4 + Number6 ) / 900 )
    return Number3, Number
end

Storage.RenderEndTables = function()
    local Value1 = nil

    for Key, Value in Storage.Table27, nil, nil do
        Value:Destroy( )
    end

    table.clear( Storage.Table27 )
    local Equipes = Ecran:FindFirstChild( "Equipes" )

    if not Equipes then
        return
    end

    local Result8
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
    local Stats = MatchState:GetAttribute( "Stats" )
    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, Stats or "[]" )
    Result8 = Success and type( Result ) == "table" and Result or { }
    local Result4
    local Number = tonumber( A( "MVP" ) ) or 0
    local TeamA = MatchState:GetAttribute( "TeamA" )
    local JSONDecode2 = HttpService.JSONDecode
    local Success2, Result2 = pcall( JSONDecode2, HttpService, TeamA or "[]" )
    Result4 = Success2 and type( Result2 ) == "table" and Result2 or { }
    local Result5
    local TeamB = MatchState:GetAttribute( "TeamB" )
    local JSONDecode3 = HttpService.JSONDecode
    local Success3, Result3 = pcall( JSONDecode3, HttpService, TeamB or "[]" )
    Result5 = Success3 and type( Result3 ) == "table" and Result3 or { }
    local Value4
    local Count = #Result4
    local Value2, Value3 = Storage.LayoutTables( ( math.max( Count, #Result5, 1 ) ) )
    local Table = { "A", "B" }
    Value4 = nil

    for Key2, Value5 in Table, nil, nil do
        local Text2 = Value5 ~= RankedTeam and "Adv" or "Moi"
        local Result7
        local Attribute = MatchState:GetAttribute( "Team" .. Value5 )
        local JSONDecode4 = HttpService.JSONDecode
        local Success4, Result6 = pcall( JSONDecode4, HttpService, Attribute or "[]" )
        Result7 = Success4 and type( Result6 ) == "table" and Result6 or { }
        local Value6 = nil

        for Key3, Value7 in Result7, nil, nil do
            local Clone = Templates.LigneFin:Clone( )
            local Number2 = tonumber( Value7.id ) or 0
            Clone.Name = "Joueur_" .. tostring( Value7.id )
            Clone.LayoutOrder = Key3
            Clone.Visible = true
            Clone.Size = UDim2.fromScale( 1, Value3 / Value2 )
            local UICorner = Clone:FindFirstChildOfClass( "UICorner" )

            if UICorner then
                UICorner.CornerRadius = UDim.new( 4.2 / Value3, 0 )
            end

            local Flag = Number2 == LocalPlayer.UserId and true or false
            local Text = if Flag then "Perso" else Text2
            local Image
            SetGrad( Clone, Text )
            local Avatar = Clone.Avatar
            Image = Number2 > 0 and ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Number2 ) or ""
            local Entry2
            Avatar.Image = Image
            Table10.paint( Clone, Value7 )
            local Entry = Result8[ tostring( Value7.id ) ]
            Entry2 = if Entry then Entry else { }
            local Visible
            local Elims = Clone.Elims
            Elims.Text = tostring( Entry2.k or 0 )
            local Morts = Clone.Morts
            Morts.Text = tostring( Entry2.d or 0 )
            local Mvp = Clone.Mvp

            if Number2 == 0 then
                Visible = false
            elseif Number2 == Number then
                Visible = true
            else
                Visible = false
            end

            local Transparency
            Mvp.Visible = Visible
            local Toi = Clone.Toi
            Transparency = not Flag and 1 or 0.1
            Toi.Transparency = Transparency
            Clone.Parent = Equipes[ Text2 ].Lignes
            table.insert( Storage.Table27, Clone )
        end
    end
end

MatchState:GetAttributeChangedSignal( "Stats" ):Connect( function()
    if Resultats.Visible then
        Storage.RenderEndTables( )
    end
end )
Storage.Table28 = { pending = nil }

Storage.ShowResults = function( Results )
    local TableInner
    Flag6 = true
    Number2 = Number2 + 1
    TableInner = type( Results ) == "table" and Results or { }
    local Winner2
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
    local Winner = TableInner.winner

    if Winner then
        Winner2 = Winner
    else
        Winner2 = MatchState:GetAttribute( "Winner" )
    end

    local FlagInner

    if Winner2 == nil then
        FlagInner = true
    elseif Winner2 == "" then
        FlagInner = true
    else
        FlagInner = false
    end

    local Flag2

    if TableInner.won == true then
        Flag2 = true
    elseif TableInner.won == nil then
        if Winner2 == RankedTeam then
            Flag2 = true
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end

    local Text

    if TableInner.abandon then
        Text = "Defaite"
    elseif FlagInner then
        Text = "Nul"
    elseif Flag2 then
        Text = "Victoire"
    else
        Text = "Defaite"
    end

    local Value1
    Value15 = Text
    Number = Number + 1
    Annonce.Visible = false
    Annonce.Size = Table.annSize
    Ban.Visible = false
    Flag = false
    Score.Visible = false
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        Value.Visible = false
    end

    local function One( ParentInner )
        if ParentInner:IsA( "ScreenGui" ) and ParentInner ~= Parent and ParentInner.Name ~= "RankedVictoryScene" and ParentInner.Name ~= "RankedVictoryTuning" and ParentInner.Name ~= "Gamepad" and ParentInner.Name ~= "GamepadSelection" and ParentInner.Name ~= "GamepadHints" and not ParentInner:FindFirstChild( "RankedResultsHide" ) then
            local UIScale = Instance.new( "UIScale" )
            UIScale.Name = "RankedResultsHide"
            UIScale.Scale = 0
            UIScale.Parent = ParentInner
        end
    end

    for Key2, Value2 in PlayerGui:GetChildren( ) do
        One( Value2 )
    end
    if not Value7 then
        Value7 = PlayerGui.ChildAdded:Connect( One )
    end

    local Text2
    local Titre = Ecran.Titre

    if Value15 == "Victoire" then
        Text2 = "VICTORY"
    elseif Value15 == "Nul" then
        Text2 = "DRAW"
    else
        Text2 = "DEFEAT"
    end

    local Value3
    Titre.Text = Text2
    SetGrad( Ecran.Titre, Value15 )
    SetGrad( Resultats.Voile, Value15 )
    local Table2Inner = { "Bandeau", "LigneHaut", "LigneBas" }
    Value3 = nil

    for Key3, Value4 in Table2Inner, nil, nil do
        local FoundChild = Ecran:FindFirstChild( Value4 )

        if FoundChild then
            SetGrad( FoundChild, Value15 )
        end
    end

    local Value5
    Storage.RenderEndTables( )
    Value5 = nil

    for Key4, Value6 in Storage.Table27, nil, nil do
        Value6.Visible = false
        task.delay( 0.5 + Value6.LayoutOrder * 0.07, function()
            if Number2 == Number2 and Value6.Parent then
                Value6.Visible = true
            end
        end )
    end

    local Text3
    local ScoreInner = Ecran.Score
    local NumberInner = tonumber( A( "Score" .. RankedTeam ) ) or 0
    Text3 = RankedTeam ~= "A" and "A" or "B"
    local Text4
    ScoreInner.Text = ( "%d - %d" ):format( NumberInner, tonumber( A( "Score" .. Text3 ) ) or 0 )
    local Raison = Ecran.Raison
    Raison.Text = Storage.ReasonText( TableInner, Flag2 )
    local Valeur = Bas.Stats.Kills.Valeur
    Valeur.Text = tostring( TableInner.kills or 0 )
    local Valeur2 = Bas.Stats.Morts.Valeur
    Valeur2.Text = tostring( TableInner.deaths or 0 )
    local Number2Inner = tonumber( A( "MVP" ) )
    local Valeur3 = Bas.Stats.Mvp.Valeur

    if not Number2Inner or Number2Inner == 0 then
        Text4 = "-"
    else
        local NameOf2 = NameOf( Number2Inner )

        if NameOf2 then
            Text4 = NameOf2
        else
            Text4 = "-"
        end
    end

    Valeur3.Text = Text4
    local Number3 = tonumber( TableInner.xp ) or 0

    if Number3 > 0 then
        local Raison2 = Ecran.Raison
        local Text5 = Ecran.Raison.Text
        Raison2.Text = Text5 .. "  ·  +" .. Fmt( Number3 ) .. " XP"
    end

    local GainXP = Ecran:FindFirstChild( "GainXP" )

    if GainXP then
        local Visible
        GainXP.Text = "+" .. Fmt( Number3 ) .. " XP"

        if TableInner.unranked == true then
            if Number3 > 0 then
                Visible = true
            else
                Visible = false
            end
        else
            Visible = false
        end

        GainXP.Visible = Visible
    end

    local Captured
    Bas.Rejouer.Texte.Text = "PLAY AGAIN"
    Bas.Quitter.Texte.Text = "BACK TO CITY"
    Open( Resultats )
    Sfx.StopAll( 0.15 )
    Sfx.Play( "Impact", { delay = 0.11, volume = 1.6 } )

    if Storage.Table28 then
        local EndedAt = Storage.Table28.endedAt

        if EndedAt then
            if os.clock( ) - Storage.Table28.endedAt < 4 then
                Captured = true
            else
                Captured = false
            end
        else
            Captured = EndedAt
        end
    else
        Captured = Storage.Table28
    end
    if not Captured then
        local Text6
        local Play = Sfx.Play

        if Value15 == "Victoire" then
            Text6 = "Victoire"
        elseif Value15 == "Nul" then
            Text6 = "Nul"
        else
            Text6 = "Defaite"
        end

        local Volume
        local Table3 = { delay = 0.11 }
        Volume = Value15 ~= "Nul" and 1 or 2
        Table3.volume = Volume
        Play( Text6, Table3 )
    end

    local Res
    task.spawn( Storage.PlayIntro, Number2, Value15 )
    Res = type( TableInner.res ) == "table" and TableInner.res or nil
    local Flag3 = if Flag2 then not TableInner.abandon else Flag2
    local Flag4 = TableInner.unranked == true and true or false
    task.spawn( Storage.PlayRank, Number2, Res, Flag3, Flag4 )
end

function Storage.Table28.busy()
    local Flag = LocalPlayer:GetAttribute( "RankedVictoryPlaying" ) == true and true or false
    return Flag
end
LocalPlayer:GetAttributeChangedSignal( "RankedVictoryPlaying" ):Connect( function()
    if Storage.Table28.busy( ) then
        return
    end

    Storage.Table28.endedAt = os.clock( )
    local Pending = Storage.Table28.pending
    Storage.Table28.pending = nil

    if Pending ~= nil then
        Storage.ShowResults( Pending )
    end
end )
MatchEvent.OnClientEvent:Connect( function( Name, Pending )
    if Name == "results" then
        if Storage.Table28.busy( ) then
            Storage.Table28.pending = Pending
            return
        end

        Storage.ShowResults( Pending )
    end
end )
Storage.Flag7 = false
Storage.Number4 = 0

Storage.ResetButtons = function()
    Storage.Flag7 = false
    Bas.Rejouer.Texte.Text = "PLAY AGAIN"
    Bas.Quitter.Texte.Text = "BACK TO CITY"
end

Storage.Choose = function( Name )
    if Storage.Flag7 then
        return
    end

    local Text
    Storage.Flag7 = true
    local Texte = Bas.Rejouer.Texte
    Text = Name ~= "again" and "PLAY AGAIN" or "JOINING QUEUE..."
    local Text2
    Texte.Text = Text
    local Texte2 = Bas.Quitter.Texte
    Text2 = Name ~= "leave" and "BACK TO CITY" or "LEAVING..."
    Texte2.Text = Text2
    task.spawn( function()
        local Flag
        local InvokeServer = MatchFn.InvokeServer
        Flag = if Name == "again" then true else nil
        local Success, Result = pcall( InvokeServer, MatchFn, Name, Flag )

        if not Success or Result == false then
            Storage.Flag7 = false
            Bas.Rejouer.Texte.Text = "PLAY AGAIN"
            Bas.Quitter.Texte.Text = "BACK TO CITY"
        end
    end )
end

MatchEvent.OnClientEvent:Connect( function( Name )
    if Name == "returnFailed" then
        Storage.Flag7 = false
        Bas.Rejouer.Texte.Text = "PLAY AGAIN"
        Bas.Quitter.Texte.Text = "BACK TO CITY"
        Storage.Number4 = os.clock( ) + 6
        return
    end
    return
end )

Storage.CloseResults = function()
    Number2 = Number2 + 1
    Flag6 = false
    Storage.Table28.pending = nil
    Storage.Flag7 = false
    Bas.Rejouer.Texte.Text = "PLAY AGAIN"
    Bas.Quitter.Texte.Text = "BACK TO CITY"
    Storage.Number4 = 0
    Resultats.Visible = false
    Sfx.StopAll( 0.3 )
    local Reflet = Ecran.Titre:FindFirstChild( "Reflet" )

    if Reflet then
        Reflet.Visible = false
        local Brillance = Reflet:FindFirstChild( "Brillance" )

        if Brillance then
            game:GetService( "CollectionService" ):RemoveTag( Brillance, "VipName" )
        end
    end
    if Value7 then
        Value7:Disconnect( )
        Value7 = nil
    end
    for Key, Value in PlayerGui:GetChildren( ) do
        local RankedResultsHide = Value:FindFirstChild( "RankedResultsHide" )

        if RankedResultsHide then
            RankedResultsHide:Destroy( )
        end
    end

    local Value1
    Flag = true
    Score.Visible = true
    Value1 = nil

    for Key2, Value2 in Table2, nil, nil do
        Value2.Visible = true
    end

    local Value3
    table.clear( Storage.Table22 )
    Value3 = nil

    for Key3, Value4 in Storage.Table23, nil, nil do
        Storage.Table24[ Value4 ] = Storage.Table24[ Value4 ] + 1
        Value4.Visible = false
        table.insert( Storage.Table22, Value4 )
    end

    Bas.Retour.Text = ""
    BuildPips( )
    RenderTeams( )
    RenderScore( )
end

Bas.Rejouer.Activated:Connect( function()
    if Storage.Flag7 then
        return
    end
    Storage.Flag7 = true
    Bas.Rejouer.Texte.Text = "JOINING QUEUE..."
    Bas.Quitter.Texte.Text = "BACK TO CITY"
    local Text = "again"
    task.spawn( function()
        local Flag
        local InvokeServer = MatchFn.InvokeServer
        Flag = if Text == "again" then true else nil
        local Success, Result = pcall( InvokeServer, MatchFn, Text, Flag )

        if not Success or Result == false then
            Storage.Flag7 = false
            Bas.Rejouer.Texte.Text = "PLAY AGAIN"
            Bas.Quitter.Texte.Text = "BACK TO CITY"
        end
    end )
    return
end )
Bas.Quitter.Activated:Connect( function()
    if Storage.Flag7 then
        return
    end
    Storage.Flag7 = true
    Bas.Rejouer.Texte.Text = "PLAY AGAIN"
    Bas.Quitter.Texte.Text = "LEAVING..."
    local Text = "leave"
    task.spawn( function()
        local Flag
        local InvokeServer = MatchFn.InvokeServer
        Flag = if Text == "again" then true else nil
        local Success, Result = pcall( InvokeServer, MatchFn, Text, Flag )

        if not Success or Result == false then
            Storage.Flag7 = false
            Bas.Rejouer.Texte.Text = "PLAY AGAIN"
            Bas.Quitter.Texte.Text = "BACK TO CITY"
        end
    end )
    return
end )
Storage.Table29 = { Bas.Rejouer, Bas.Quitter }
Storage.Value22 = nil

for Key8, Value23 in Storage.Table29, nil, nil do
    Storage.UIScale = Value23:FindFirstChildOfClass( "UIScale" )

    if Storage.UIScale then
        Value23.MouseEnter:Connect( function()
            TweenService:Create( Storage.UIScale, TweenInfo.new( 0.1 ), { Scale = 1.03 } ):Play( )
        end )
        Value23.MouseLeave:Connect( function()
            TweenService:Create( Storage.UIScale, TweenInfo.new( 0.1 ), { Scale = 1 } ):Play( )
        end )
    end
end
Storage.Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
Storage.ItemRender = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ItemRender" ) )
Storage.WeaponData = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "WeaponData" ) )
Storage.ChoixArme = Parent:WaitForChild( "ChoixArme" )
Storage.BoutonArme = Parent:WaitForChild( "BoutonArme" )
Storage.ChoixArme.Visible = false
Storage.BoutonArme.Visible = false
Storage.RankedWeaponClass = Config.RankedWeaponClass
Storage.RankedWeaponClass2 = if Storage.RankedWeaponClass then Storage.RankedWeaponClass else { }
Storage.Number5 = 0
Storage.Flag8 = false
Storage.Flag9 = false
Storage.Value24 = nil
Storage.Table30 = { }

Storage.WeaponName = function( NameName )
    local Name
    local Entry = Storage.WeaponData[ NameName ]
    Name = type( Entry ) == "table" and Entry.Name or NameName
    return tostring( Name ):upper( )
end

Storage.Table31 = { }
Storage.Table32 = { Degats = 1, Cadence = 1, Portee = 1 }
Storage.RankedWeapons = Config.RankedWeapons
Storage.Value25 = nil

for Key9, Value26 in Storage.RankedWeapons, nil, nil do
    Storage.Entry6 = Storage.WeaponData[ Value26 ]

    if type( Storage.Entry6 ) == "table" then

        if not Storage.Entry6.Fire or type( Storage.Entry6.Fire.Pellets ) ~= "table" or type( Storage.Entry6.Fire.Pellets.Pattern ) ~= "table" then
            Storage.Count2 = 1
        else
            Storage.Count = #Storage.Entry6.Fire.Pellets.Pattern

            if Storage.Count then
                Storage.Count2 = Storage.Count
            else
                Storage.Count2 = 1
            end
        end
        Storage.Table41 = { }

        if Storage.Entry6.Damage then
            Storage.Base = Storage.Entry6.Damage.Base

            if Storage.Base then
                Storage.Base2 = Storage.Base
            else
                Storage.Base2 = 0
            end
        else
            Storage.Base2 = 0
        end
        Storage.Table41.Degats = Storage.Base2 * Storage.Count2

        if Storage.Entry6.Fire then
            Storage.RPM = Storage.Entry6.Fire.RPM

            if Storage.RPM then
                Storage.Cadence = Storage.RPM
            else
                Storage.Cadence = 0
            end
        else
            Storage.Cadence = 0
        end
        Storage.Table41.Cadence = Storage.Cadence

        if Storage.Entry6.Damage then
            Storage.FalloffEnd = Storage.Entry6.Damage.FalloffEnd

            if Storage.FalloffEnd then
                Storage.Portee = Storage.FalloffEnd
            else
                Storage.Range = Storage.Entry6.Damage.Range

                if Storage.Range then
                    Storage.Portee = Storage.Range
                else
                    Storage.Portee = 0
                end
            end
        else
            Storage.Portee = 0
        end
        Storage.Table41.Portee = Storage.Portee

        if Storage.Entry6.Fire then
            if Storage.Entry6.Fire.Pump then
                Storage.Mode3 = "PUMP"
            else
                Storage.Mode = Storage.Entry6.Fire.Mode
                Storage.Mode2 = if Storage.Mode then Storage.Mode else ""
                Storage.Upper = tostring( Storage.Mode2 ):upper( )

                if Storage.Upper then
                    Storage.Mode3 = Storage.Upper
                else
                    Storage.Mode3 = ""
                end
            end
        else
            Storage.Mode3 = ""
        end
        Storage.Table41.mode = Storage.Mode3

        if Storage.Entry6.Ammo then
            Storage.Mag = Storage.Entry6.Ammo.Mag

            if Storage.Mag then
                Storage.Mag2 = Storage.Mag
            else
                Storage.Mag2 = 0
            end
        else
            Storage.Mag2 = 0
        end
        Storage.Table41.mag = Storage.Mag2

        if Storage.Entry6.Ammo then
            Storage.ReloadTime = Storage.Entry6.Ammo.ReloadTime

            if Storage.ReloadTime then
                Storage.Reload = Storage.ReloadTime
            else
                Storage.Reload = 0
            end
        else
            Storage.Reload = 0
        end
        Storage.Table41.reload = Storage.Reload
        Storage.Table31[ Value26 ] = Storage.Table41
        Storage.Value41 = nil

        for Value42 in Storage.Table32, nil, nil do
            Storage.Entry7 = Storage.Table32[ Value42 ]
            Storage.Table32[ Value42 ] = math.max( Storage.Entry7, Storage.Table41[ Value42 ] )
        end
    end
end
Storage.RankedWeaponLength = Config.RankedWeaponLength
Storage.RankedWeaponLength2 = if Storage.RankedWeaponLength then Storage.RankedWeaponLength else { }
Storage.RankedWeapons2 = Config.RankedWeapons
Storage.Value27 = nil
Storage.Number6 = 0

for Key10, Value28 in Storage.RankedWeapons2, nil, nil do
    Storage.Number6 = math.max( Storage.Number6, Storage.RankedWeaponLength2[ Value28 ] or 0 )
end

Storage.LengthOf = function( Key )
    local Entry2

    if not ( Storage.Number6 > 0 ) or not Storage.RankedWeaponLength2[ Key ] then
        Entry2 = 1
    else
        local Entry = Storage.RankedWeaponLength2[ Key ] / Storage.Number6

        if Entry then
            Entry2 = Entry
        else
            Entry2 = 1
        end
    end

    return Entry2
end

Storage.FitWeapon = function( Self, WeaponName )
    local CadreX2
    local CadreX = Self:GetAttribute( "CadreX" )
    local CadreW = Self:GetAttribute( "CadreW" )

    if CadreX then
        CadreX2 = CadreX
    else
        local Scale = Self.Position.X.Scale
        local Scale2 = Self.Size.X.Scale
        Self:SetAttribute( "CadreX", Scale )
        Self:SetAttribute( "CadreW", Scale2 )
        CadreW = Scale2
        CadreX2 = Scale
    end

    local Entry2

    if not ( Storage.Number6 > 0 ) or not Storage.RankedWeaponLength2[ WeaponName ] then
        Entry2 = 1
    else
        local Entry = Storage.RankedWeaponLength2[ WeaponName ] / Storage.Number6

        if Entry then
            Entry2 = Entry
        else
            Entry2 = 1
        end
    end

    Self.Position = UDim2.fromScale( CadreX2 + CadreW * ( 1 - Entry2 ) / 2, Self.Position.Y.Scale )
    Self.Size = UDim2.fromScale( CadreW * Entry2, Self.Size.Y.Scale )
end

Storage.Table33 = { super = "MYTHICAL", mythical = "MYTHICAL" }

Storage.TierOf = function( Key )
    return Storage.ItemRender.RARITY[ Key ] or "common"
end

Storage.TierGrad = function( GradName )
    local Entry2
    local Entry = Storage.ItemRender.TILE_GRAD[ GradName ]
    Entry2 = if Entry then Entry else Storage.ItemRender.TILE_GRAD.common
    return Entry2
end

Storage.TierTop = function( TopName )
    local Entry2
    local Entry = Storage.ItemRender.TILE_GRAD[ TopName ]
    Entry2 = if Entry then Entry else Storage.ItemRender.TILE_GRAD.common
    return Entry2.Keypoints[ 1 ].Value
end

Storage.TierBottom = function( BottomName )
    local Entry2
    local Entry = Storage.ItemRender.TILE_GRAD[ BottomName ]
    Entry2 = if Entry then Entry else Storage.ItemRender.TILE_GRAD.common
    local Keypoints = Entry2.Keypoints
    return Keypoints[ #Keypoints ].Value
end

Storage.Color32 = Color3.new( 0, 0, 0 )

Storage.TierTube = function( TubeName, Amount, Amount2 )
    local Entry2
    local Entry = Storage.ItemRender.TILE_GRAD[ TubeName ]
    Entry2 = if Entry then Entry else Storage.ItemRender.TILE_GRAD.common
    local Value = Entry2.Keypoints[ 1 ].Value
    local Lerp = Value:Lerp( Storage.Color32, Amount or 0.72 )
    local Lerp2 = Value:Lerp( Storage.Color32, Amount2 or 0.9 )
    return ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Lerp ),
        ColorSequenceKeypoint.new( 0.22, Lerp2 ),
        ColorSequenceKeypoint.new( 0.51, Color3.fromRGB( 8, 8, 8 ) ),
        ColorSequenceKeypoint.new( 0.79, Lerp2 ),
        ColorSequenceKeypoint.new( 1, Lerp )
    } )
end

Storage.TierMetal = function( p1 )
    -- Could not structure function #150
end

Storage.Table34 = { }
Storage.Table35 = { }
Storage.Number7 = 0
Storage.Text = Storage.ChoixArme.Aide.Text

Storage.FlashAide = function( Text )
    Storage.Number7 = Storage.Number7 + 1
    Storage.ChoixArme.Aide.Text = Text
    task.delay( 3, function()
        if Storage.Number7 == Storage.Number7 then
            Storage.ChoixArme.Aide.Text = Storage.Text
        end
    end )
end

Storage.HintAide = function( Text )
    Storage.Number7 = Storage.Number7 + 1
    local Aide = Storage.ChoixArme.Aide
    Aide.Text = Text or Storage.Text
end

Storage.Callback = nil

Storage.ChooseWeapon = function( WeaponName )
    if not Storage.Table30[ WeaponName ] then
        local Name
        local Entry = Storage.WeaponData[ WeaponName ]
        Name = type( Entry ) == "table" and Entry.Name or WeaponName
        local Text = tostring( Name ):upper( ) .. " is locked: get it in the city to use it in Ranked"
        Storage.Number7 = Storage.Number7 + 1
        Storage.ChoixArme.Aide.Text = Text
        task.delay( 3, function()
            if Storage.Number7 == Storage.Number7 then
                Storage.ChoixArme.Aide.Text = Storage.Text
            end
        end )
        return
    end
    if Storage.Flag9 or LocalPlayer:GetAttribute( "RankedWeapon" ) == WeaponName then
        return
    end
    Storage.Flag9 = true
    task.spawn( function()
        local Success, Result = pcall( MatchFn.InvokeServer, MatchFn, "weapon", WeaponName )
        Storage.Flag9 = false

        if Success and Result then
            Sfx.Play( "ArmeEquipee" )
        end

        Storage.Callback( )

        if Success and Result and not MatchState:GetAttribute( "Picking" ) then
            Storage.ChoixArme.Visible = false
        end
    end )
    return
end

Storage.RenderShowcase = function()
    local Captured2
    local RankedWeapon = LocalPlayer:GetAttribute( "RankedWeapon" )
    local Captured = Storage.Value24 or RankedWeapon
    local Vitrine = Storage.ChoixArme.Vitrine
    Captured2 = if Captured then Storage.Table31[ Captured ] else Captured
    local Visible = Captured2 ~= nil and true or false
    Vitrine.Visible = Visible

    if not Captured2 then
        return
    end

    local Name
    local Nom = Vitrine.Nom
    local Entry = Storage.WeaponData[ Captured ]
    Name = type( Entry ) == "table" and Entry.Name or Captured
    local Text
    Nom.Text = tostring( Name ):upper( )
    local Classe = Vitrine.Classe
    Classe.Text = Storage.RankedWeaponClass2[ Captured ] or ""
    local Entry2 = Storage.ItemRender.RARITY[ Captured ] or "common"
    local RareteTexte = Vitrine.RareteTexte
    local Entry3 = Storage.Table33[ Entry2 ]
    Text = if Entry3 then Entry3 else Entry2:upper( )
    local Entry5
    RareteTexte.Text = Text
    local RareteTexte2 = Vitrine.RareteTexte
    RareteTexte2.TextColor3 = Storage.ItemRender.TextColor( Entry2 )
    local Fond = Vitrine.Fond
    Fond.Color = Storage.TierTube( Entry2 )
    local Couleur = Vitrine.Lueur.Halo.Couleur
    local Entry4 = Storage.ItemRender.TILE_GRAD[ Entry2 ]
    Entry5 = if Entry4 then Entry4 else Storage.ItemRender.TILE_GRAD.common
    local GroupTransparency
    Couleur.Color = ColorSequence.new( Entry5.Keypoints[ 1 ].Value )
    local Lueur = Vitrine.Lueur
    GroupTransparency = not Storage.Table30[ Captured ] and 0.5 or 0
    local Text2
    Lueur.GroupTransparency = GroupTransparency

    if Captured == RankedWeapon then
        Text2 = "EQUIPPED"
    elseif Storage.Table30[ Captured ] then
        Text2 = "PREVIEW"
    else
        Text2 = "LOCKED"
    end

    local Text3
    Vitrine.Etat.Text = Text2
    local Etat = Vitrine.Etat

    if Text2 == "EQUIPPED" then
        Text3 = "Or"
    elseif Text2 == "LOCKED" then
        Text3 = "Rouge"
    else
        Text3 = "Blanc"
    end

    local ImageTransparency
    SetGrad( Etat, Text3 )
    Storage.ItemRender.SetIcon( Vitrine.Image, Storage.ItemRender.ICONS[ Captured ] or "" )
    Storage.FitWeapon( Vitrine.Image, Captured )
    local Image = Vitrine.Image
    ImageTransparency = not Storage.Table30[ Captured ] and 0.55 or 0
    local Value1
    Image.ImageTransparency = ImageTransparency
    local Table = {
        Degats = Captured2.Degats,
        Cadence = Captured2.Cadence,
        Portee = Captured2.Portee
    }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Entry6 = Vitrine[ "Stat_" .. Key ]
        local Rempli = Entry6.Piste.Rempli
        Rempli.Size = UDim2.fromScale( math.clamp( Value / Storage.Table32[ Key ], 0.06, 1 ), 1 )
        local Or = Entry6.Piste.Rempli.Or
        Or.Color = Storage.TierMetal( Entry2 )
        local Valeur = Entry6.Valeur
        Valeur.Text = tostring( ( math.floor( Value + 0.5 ) ) )
    end

    local Infos = Vitrine.Infos
    Infos.Text = ( "%s  ·  %d RDS  ·  RELOAD %s S" ):format( Captured2.mode, Captured2.mag, ( tostring( Captured2.reload ) ) )
end

Storage.Table36 = { }
Storage.WeaponVisuals = game:GetService( "ReplicatedStorage" ):FindFirstChild( "WeaponVisuals" )
Storage.RankedWeapons3 = Config.RankedWeapons
Storage.Value29 = nil

for Key11, Value30 in Storage.RankedWeapons3, nil, nil do
    if Storage.WeaponVisuals and Storage.WeaponVisuals:FindFirstChild( Value30 ) then
        table.insert( Storage.Table36, Value30 )
    end
end

Storage.Number8 = 0

while Storage.ChoixArme.Cartes:FindFirstChild( "Emplacement" .. Storage.Number8 + 1 ) do
    Storage.Number8 = Storage.Number8 + 1
end

local I = 1

for I = 1, Storage.Number8 do
    Storage.FoundChild = Storage.ChoixArme.Cartes:FindFirstChild( "Emplacement" .. I )
    Storage.Entry = Storage.Table36[ I ]

    if Storage.FoundChild and #Storage.Table36 <= 6 and typeof( Storage.FoundChild:GetAttribute( "Pos6" ) ) == "UDim2" then
        Storage.Position3 = Storage.FoundChild:GetAttribute( "Pos6" )
        Storage.Size = Storage.FoundChild:GetAttribute( "Size6" )
        Storage.FoundChild.Position = Storage.Position3
        Storage.FoundChild.Size = Storage.Size
    end
    if Storage.FoundChild then
        Storage.Table34[ I ] = Storage.FoundChild
        Storage.Visible = Storage.Entry ~= nil and true or false
        Storage.FoundChild.Visible = Storage.Visible

        if Storage.Entry then
            Storage.Table35[ Storage.FoundChild ] = Storage.Entry
            Storage.Nom = Storage.FoundChild.Nom
            Storage.Nom.Text = Storage.WeaponName( Storage.Entry )
            Storage.Classe = Storage.FoundChild.Classe
            Storage.Entry2 = Storage.RankedWeaponClass2[ Storage.Entry ]
            Storage.Text2 = if Storage.Entry2 then Storage.Entry2 else ""
            Storage.Classe.Text = Storage.Text2
            Storage.TierOf2 = Storage.TierOf( Storage.Entry )
            Storage.Rarete = Storage.FoundChild.Rarete
            Storage.Rarete.Color = Storage.TierTube( Storage.TierOf2, 0.62, 0.86 )
            Storage.Couleur = Storage.FoundChild.Lisere.Couleur
            Storage.Couleur.Color = ColorSequence.new( ( Storage.TierTop( Storage.TierOf2 ) ) )
            Storage.RareteTexte = Storage.FoundChild.RareteTexte
            Storage.Entry3 = Storage.Table33[ Storage.TierOf2 ]
            Storage.Text3 = if Storage.Entry3 then Storage.Entry3 else Storage.TierOf2:upper( )
            Storage.RareteTexte.Text = Storage.Text3
            Storage.RareteTexte2 = Storage.FoundChild.RareteTexte
            Storage.RareteTexte2.TextColor3 = Storage.ItemRender.TextColor( Storage.TierOf2 )
            Storage.SetIcon = Storage.ItemRender.SetIcon
            Storage.Icone = Storage.FoundChild.Icone
            Storage.Entry4 = Storage.ItemRender.ICONS[ Storage.Entry ]
            Storage.Entry5 = if Storage.Entry4 then Storage.Entry4 else ""
            Storage.SetIcon( Storage.Icone, Storage.Entry5 )
            Storage.FitWeapon( Storage.FoundChild.Icone, Storage.Entry )
            Storage.FoundChild.Activated:Connect( function()
                Storage.ChooseWeapon( Storage.Entry )
            end )

            Storage.Hover = function( Visible )
                local Captured

                if not Visible or not Storage.Entry then
                    if Storage.Value24 == Storage.Entry or not Storage.Value24 then
                        Captured = nil
                    else
                        Captured = Storage.Value24
                    end
                else
                    Captured = Storage.Entry
                end

                local Enabled
                Storage.Value24 = Captured
                Storage.FoundChild.Eclat.Visible = Visible
                local SurvolContour = Storage.FoundChild.SurvolContour

                if Visible then
                    if LocalPlayer:GetAttribute( "RankedWeapon" ) == Storage.Entry then
                        Enabled = false
                    else
                        Enabled = true
                    end
                else
                    Enabled = Visible
                end

                local Number
                SurvolContour.Enabled = Enabled

                if LocalPlayer:GetAttribute( "RankedWeapon" ) == Storage.Entry then
                    Number = 2
                elseif Visible then
                    Number = 1
                else
                    Number = 0
                end

                local ZBase2
                local ZBase = Storage.FoundChild:GetAttribute( "ZBase" )

                if ZBase == nil then
                    local ZIndex = Storage.FoundChild.ZIndex
                    Storage.FoundChild:SetAttribute( "ZBase", ZIndex )
                    ZBase2 = ZIndex
                else
                    ZBase2 = ZBase
                end

                local ZIndex2 = ZBase2 + Number

                if Storage.FoundChild.ZIndex ~= ZIndex2 then
                    Storage.FoundChild.ZIndex = ZIndex2
                end
                if Visible then
                    local Text3

                    if Storage.Entry == LocalPlayer:GetAttribute( "RankedWeapon" ) then
                        local Name
                        local Entry = Storage.WeaponData[ Storage.Entry ]
                        Name = type( Entry ) == "table" and Entry.Name or Storage.Entry
                        local Text = tostring( Name ):upper( ) .. " is equipped"

                        if Text then
                            Text3 = Text
                        elseif Storage.Table30[ Storage.Entry ] then
                            local Entry2 = Storage.WeaponData[ Storage.Entry ]

                            if type( Entry2 ) ~= "table" or not Entry2.Name then
                                Name2 = Storage.Entry
                            else
                                Name2 = Entry2.Name
                            end

                            local Text2 = "Click to equip the " .. tostring( Name2 ):upper( )

                            if Text2 then
                                Text3 = Text2
                            else
                                local Entry3 = Storage.WeaponData[ Storage.Entry ]

                                if type( Entry3 ) ~= "table" or not Entry3.Name then
                                    Name3 = Storage.Entry
                                else
                                    Name3 = Entry3.Name
                                end

                                Text3 = tostring( Name3 ):upper( ) .. " is locked: get it in the city to use it in Ranked"
                            end
                        else
                            local Entry3 = Storage.WeaponData[ Storage.Entry ]

                            if type( Entry3 ) ~= "table" or not Entry3.Name then
                                Name3 = Storage.Entry
                            else
                                Name3 = Entry3.Name
                            end

                            Text3 = tostring( Name3 ):upper( ) .. " is locked: get it in the city to use it in Ranked"
                        end
                    elseif Storage.Table30[ Storage.Entry ] then
                        local Name2
                        local Entry2 = Storage.WeaponData[ Storage.Entry ]

                        if type( Entry2 ) ~= "table" or not Entry2.Name then
                            Name2 = Storage.Entry
                        else
                            Name2 = Entry2.Name
                        end

                        local Text2 = "Click to equip the " .. tostring( Name2 ):upper( )

                        if Text2 then
                            Text3 = Text2
                        else
                            local Entry3 = Storage.WeaponData[ Storage.Entry ]

                            if type( Entry3 ) ~= "table" or not Entry3.Name then
                                Name3 = Storage.Entry
                            else
                                Name3 = Entry3.Name
                            end

                            Text3 = tostring( Name3 ):upper( ) .. " is locked: get it in the city to use it in Ranked"
                        end
                    else
                        local Name3
                        local Entry3 = Storage.WeaponData[ Storage.Entry ]

                        if type( Entry3 ) ~= "table" or not Entry3.Name then
                            Name3 = Storage.Entry
                        else
                            Name3 = Entry3.Name
                        end

                        Text3 = tostring( Name3 ):upper( ) .. " is locked: get it in the city to use it in Ranked"
                    end

                    local Text4
                    Storage.Number7 = Storage.Number7 + 1
                    local Aide = Storage.ChoixArme.Aide
                    Text4 = if Text3 then Text3 else Storage.Text
                    Aide.Text = Text4
                else
                    Storage.Number7 = Storage.Number7 + 1
                    Storage.ChoixArme.Aide.Text = Storage.Text
                end

                Storage.RenderShowcase( )
            end

            Storage.FoundChild.MouseEnter:Connect( function()
                Storage.Hover( true )
            end )
            Storage.FoundChild.MouseLeave:Connect( function()
                local Captured = Storage.Value24 ~= Storage.Entry and Storage.Value24 or nil
                local Number
                Storage.Value24 = Captured
                Storage.FoundChild.Eclat.Visible = false
                Storage.FoundChild.SurvolContour.Enabled = false
                Number = LocalPlayer:GetAttribute( "RankedWeapon" ) ~= Storage.Entry and 0 or 2
                local ZBase2
                local ZBase = Storage.FoundChild:GetAttribute( "ZBase" )

                if ZBase == nil then
                    local ZIndex = Storage.FoundChild.ZIndex
                    Storage.FoundChild:SetAttribute( "ZBase", ZIndex )
                    ZBase2 = ZIndex
                else
                    ZBase2 = ZBase
                end

                local ZIndex2 = ZBase2 + Number

                if Storage.FoundChild.ZIndex ~= ZIndex2 then
                    Storage.FoundChild.ZIndex = ZIndex2
                end

                Storage.Number7 = Storage.Number7 + 1
                Storage.ChoixArme.Aide.Text = Storage.Text
                Storage.RenderShowcase( )
            end )
            Storage.FoundChild.SelectionGained:Connect( function()
                Storage.Hover( true )
            end )
            Storage.FoundChild.SelectionLost:Connect( function()
                local Captured = Storage.Value24 ~= Storage.Entry and Storage.Value24 or nil
                local Number
                Storage.Value24 = Captured
                Storage.FoundChild.Eclat.Visible = false
                Storage.FoundChild.SurvolContour.Enabled = false
                Number = LocalPlayer:GetAttribute( "RankedWeapon" ) ~= Storage.Entry and 0 or 2
                local ZBase2
                local ZBase = Storage.FoundChild:GetAttribute( "ZBase" )

                if ZBase == nil then
                    local ZIndex = Storage.FoundChild.ZIndex
                    Storage.FoundChild:SetAttribute( "ZBase", ZIndex )
                    ZBase2 = ZIndex
                else
                    ZBase2 = ZBase
                end

                local ZIndex2 = ZBase2 + Number

                if Storage.FoundChild.ZIndex ~= ZIndex2 then
                    Storage.FoundChild.ZIndex = ZIndex2
                end

                Storage.Number7 = Storage.Number7 + 1
                Storage.ChoixArme.Aide.Text = Storage.Text
                Storage.RenderShowcase( )
            end )
        end
    end
end

Storage.Callback = function()
    local Result2
    local RankedWeapon = LocalPlayer:GetAttribute( "RankedWeapon" )
    table.clear( Storage.Table30 )
    local RankedWeapons = LocalPlayer:GetAttribute( "RankedWeapons" )
    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, RankedWeapons or "[]" )
    Result2 = Success and type( Result ) == "table" and Result or { }
    local Value1 = nil

    for Key, Value in Result2, nil, nil do
        Storage.Table30[ Value ] = true
    end

    local Value2
    Storage.Number5 = #Result2
    Value2 = nil

    for Key2, Value3 in Storage.Table35, nil, nil do
        local Flag = Storage.Table30[ Value3 ] == true and true or false
        local Enabled = Value3 == RankedWeapon and true or false
        local Number
        Key2.Selection.Enabled = Enabled

        if Enabled then
            Number = 2
        elseif Storage.Value24 == Value3 then
            Number = 1
        else
            Number = 0
        end

        local ZBase2
        local ZBase = Key2:GetAttribute( "ZBase" )

        if ZBase == nil then
            local ZIndex = Key2.ZIndex
            Key2:SetAttribute( "ZBase", ZIndex )
            ZBase2 = ZIndex
        else
            ZBase2 = ZBase
        end

        local ZIndex2 = ZBase2 + Number

        if Key2.ZIndex ~= ZIndex2 then
            Key2.ZIndex = ZIndex2
        end

        Key2.Equipe.Visible = Enabled

        if Enabled then
            Key2.SurvolContour.Enabled = false
        end

        local ImageTransparency
        local Verrou = Key2.Verrou
        Verrou.Visible = not Flag
        local Icone2 = Key2.Icone
        ImageTransparency = not Flag and 0.6 or 0
        local TextTransparency
        Icone2.ImageTransparency = ImageTransparency
        local Nom = Key2.Nom
        TextTransparency = not Flag and 0.45 or 0
        local TextTransparency2
        Nom.TextTransparency = TextTransparency
        local Classe = Key2.Classe
        TextTransparency2 = not Flag and 0.45 or 0
        Classe.TextTransparency = TextTransparency2
    end

    local Text
    Storage.RenderShowcase( )
    local Arme = Storage.BoutonArme.Arme

    if RankedWeapon then
        local Name
        local Entry = Storage.WeaponData[ RankedWeapon ]
        Name = type( Entry ) == "table" and Entry.Name or RankedWeapon
        local Upper = tostring( Name ):upper( )

        if Upper then
            Text = Upper
        else
            Text = ""
        end
    else
        Text = ""
    end

    local Entry3
    Arme.Text = Text
    local SetIcon = Storage.ItemRender.SetIcon
    local Icone = Storage.BoutonArme.Icone

    if RankedWeapon then
        local Entry2 = Storage.ItemRender.ICONS[ RankedWeapon ]

        if Entry2 then
            Entry3 = Entry2
        else
            Entry3 = ""
        end
    else
        Entry3 = ""
    end

    SetIcon( Icone, Entry3 )
end

LocalPlayer:GetAttributeChangedSignal( "RankedWeapon" ):Connect( Storage.Callback )
LocalPlayer:GetAttributeChangedSignal( "RankedWeapons" ):Connect( Storage.Callback )
Storage.Callback( )

Storage.RenderKey = function()
    local Item
    local Success, Result = pcall( Storage.Controls.Binds, "kbm", "RankedWeapon" )
    Item = Success and type( Result ) == "table" and Result[ 1 ] or "B"
    local TouchMode
    local Texte = Storage.BoutonArme.Touche.Texte
    Texte.Text = Storage.Controls.KeyName( Item, true )
    local Success2 = pcall( Storage.Controls.TouchMode )

    if Success2 then
        TouchMode = Storage.Controls.TouchMode( )
    else
        TouchMode = Success2
    end

    local Success3
    local Touche = Storage.BoutonArme.Touche

    if TouchMode then
        Success3 = TouchMode
    else
        local GamepadEnabled = UserInputService.GamepadEnabled

        if GamepadEnabled then
            if UserInputService:GetLastInputType( ).Name:sub( 1, 7 ) == "Gamepad" then
                Success3 = true
            else
                Success3 = false
            end
        else
            Success3 = GamepadEnabled
        end
    end

    Touche.Visible = not Success3
end

if Storage.Controls.BindsChanged then
    Storage.Controls.BindsChanged:Connect( Storage.RenderKey )
end
if Storage.Controls.Changed then
    Storage.Controls.Changed:Connect( Storage.RenderKey )
end
Storage.RenderKey( )

Storage.CanChange = function( Name )
    local Flag

    if Name == "roundend" then
        Flag = true
    elseif Name == "countdown" then
        Flag = not MatchState:GetAttribute( "Picking" )
    else
        Flag = false
    end

    return Flag
end

Storage.SendReady = function()
    if Storage.Flag8 or not MatchState:GetAttribute( "Picking" ) then
        return
    end
    Storage.Flag8 = true
    task.spawn( pcall, MatchFn.InvokeServer, MatchFn, "pickReady" )
    return
end

Storage.OpenPick = function()
    Storage.Callback( )
    SetGrad( Storage.ChoixArme.Pret, "Fond_" .. tostring( MatchState:GetAttribute( "Mode" ) or "1v1" ) )
    Open( Storage.ChoixArme )
end

Storage.ChoixArme.Pret.Activated:Connect( function()
    if not Storage.Flag8 then
        if MatchState:GetAttribute( "Picking" ) then
            Storage.Flag8 = true
            task.spawn( pcall, MatchFn.InvokeServer, MatchFn, "pickReady" )
        end
    end

    Storage.ChoixArme.Visible = false
end )
Storage.ChoixArme.Close.Activated:Connect( function()
    if not Storage.Flag8 then
        if MatchState:GetAttribute( "Picking" ) then
            Storage.Flag8 = true
            task.spawn( pcall, MatchFn.InvokeServer, MatchFn, "pickReady" )
        end
    end

    Storage.ChoixArme.Visible = false
end )
Storage.BoutonArme.Activated:Connect( function()
    local Flag
    local Phase = MatchState:GetAttribute( "Phase" )

    if Phase == "roundend" then
        Flag = true
    elseif Phase == "countdown" then
        Flag = not MatchState:GetAttribute( "Picking" )
    else
        Flag = false
    end
    if Flag then
        Storage.Callback( )
        SetGrad( Storage.ChoixArme.Pret, "Fond_" .. tostring( MatchState:GetAttribute( "Mode" ) or "1v1" ) )
        Open( Storage.ChoixArme )
    end
end )
UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if Argument2 or not Storage.Controls.Is( "RankedWeapon", Argument1 ) then
        return
    end

    local Phase = MatchState:GetAttribute( "Phase" )

    if Storage.ChoixArme.Visible then
        Storage.ChoixArme.Visible = false

        if not Storage.Flag8 then
            if MatchState:GetAttribute( "Picking" ) then
                Storage.Flag8 = true
                task.spawn( pcall, MatchFn.InvokeServer, MatchFn, "pickReady" )
                return
            end
            return
        end
    elseif MatchState:GetAttribute( "Picking" ) then
        Storage.Callback( )
        SetGrad( Storage.ChoixArme.Pret, "Fond_" .. tostring( MatchState:GetAttribute( "Mode" ) or "1v1" ) )
        Open( Storage.ChoixArme )
    else
        local Flag

        if Phase == "roundend" then
            Flag = true
        elseif Phase == "countdown" then
            Flag = not MatchState:GetAttribute( "Picking" )
        else
            Flag = false
        end
        if Flag then
            Storage.Callback( )
            SetGrad( Storage.ChoixArme.Pret, "Fond_" .. tostring( MatchState:GetAttribute( "Mode" ) or "1v1" ) )
            Open( Storage.ChoixArme )
        end
    end
end )
MatchState:GetAttributeChangedSignal( "Picking" ):Connect( function()
    if MatchState:GetAttribute( "Picking" ) then
        Storage.Flag8 = false
        Number = Number + 1
        Annonce.Visible = false
        Annonce.Size = Table.annSize
        Storage.Callback( )
        SetGrad( Storage.ChoixArme.Pret, "Fond_" .. tostring( MatchState:GetAttribute( "Mode" ) or "1v1" ) )
        Open( Storage.ChoixArme )
        return
    end
    Storage.ChoixArme.Visible = false
    return
end )
Storage.Value31 = nil
Storage.Number9 = 0

Storage.OnPhase = function()
    local Phase = MatchState:GetAttribute( "Phase" )

    if Phase == Storage.Value31 then
        return
    end

    Storage.Value31 = Phase

    if Phase == "fight" then
        Announce( "FIGHT!", nil, "Gagne", 0.9, 1.5 )
        Sfx.Play( "Fight" )
        Sfx.Play( "Impact", { volume = 0.55 } )
        Table.shake( Annonce, 0.003, 0.25 )
    elseif Phase == "roundend" then
        local Text
        local RoundWinner = MatchState:GetAttribute( "RoundWinner" )
        local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
        local NumberInner = tonumber( A( "Score" .. RankedTeam ) ) or 0
        Text = RankedTeam ~= "A" and "A" or "B"
        local Format = ( "%d - %d" ):format( NumberInner, tonumber( A( "Score" .. Text ) ) or 0 )

        if RoundWinner == "draw" then
            if MatchState:GetAttribute( "RoundReason" ) == "time" then
                local Text2 = "DRAW  ·  " .. Format
                Announce( "TIME'S UP", Text2, "Neutre", Config.RoundEndPause )
            else
                Announce( "DRAW", Format, "Neutre", Config.RoundEndPause )
            end

            Sfx.Play( "Nul", { volume = 0.8 } )
        elseif RoundWinner == RankedTeam then
            Announce( "ROUND WON", Format, "Gagne", Config.RoundEndPause, 1.4 )
            Sfx.Play( "MancheGagnee" )
        else
            Announce( "ROUND LOST", Format, "Perdu", Config.RoundEndPause, 1.2 )
            Sfx.Play( "ManchePerdue" )
        end
    elseif Phase == "results" then
        Storage.Number9 = os.clock( )
    elseif Phase == "cancelled" then
        Number = Number + 1
        Annonce.Visible = false
        Annonce.Size = Table.annSize
    end
    if Storage.Value31 == "results" and Phase ~= "results" then
        Storage.CloseResults( )
    end
    if Storage.Value31 == "ban" or Phase ~= "ban" then
        local Visible = if Phase == "ban" then Ban.Visible else false
        Ban.Visible = Visible
    end
end

MatchState:GetAttributeChangedSignal( "Phase" ):Connect( Storage.OnPhase )
MatchState:GetAttributeChangedSignal( "Map" ):Connect( function()
    local Map = MatchState:GetAttribute( "Map" )

    if type( Map ) == "string" and Map ~= "" then
        local Result2
        local Candidates = MatchState:GetAttribute( "Candidates" )
        local JSONDecode = HttpService.JSONDecode
        local Success, Result = pcall( JSONDecode, HttpService, Candidates or "[]" )
        Result2 = Success and type( Result ) == "table" and Result or { }

        if #Result2 > 1 then
            Announce( Config.MapLabel( Map ), "MAP SELECTED", "Neutre", 2.5, 1.3 )
            Sfx.Play( "MapChoisie" )
        end
    end
end )
Storage.Table37 = { "TeamA", "TeamB" }
Storage.Value32 = nil

for Key12, Value33 in Storage.Table37, nil, nil do
    MatchState:GetAttributeChangedSignal( Value33 ):Connect( RenderTeams )
end
Storage.Table38 = { "TeamA", "TeamB" }
Storage.Value34 = nil

for Key13, Value35 in Storage.Table38, nil, nil do
    MatchState:GetAttributeChangedSignal( Value35 ):Connect( function()
        if Resultats.Visible then
            Storage.RenderEndTables( )
        end
    end )
end
Storage.Table39 = { "ScoreA", "ScoreB", "Round" }
Storage.Value36 = nil

for Key14, Value37 in Storage.Table39, nil, nil do
    MatchState:GetAttributeChangedSignal( Value37 ):Connect( RenderScore )
end

MatchState:GetAttributeChangedSignal( "WinRounds" ):Connect( function()
    BuildPips( )
    RenderScore( )
end )
LocalPlayer:GetAttributeChangedSignal( "RankedTeam" ):Connect( function()
    local Value1 = nil

    for Key, Value in Table12, nil, nil do
        Value:Destroy( )
        Table12[ Key ] = nil
    end

    RenderTeams( )
    RenderScore( )
end )
BuildPips( )
RenderTeams( )
RenderScore( )
Storage.OnPhase( )
Storage.Number10 = 0
Storage.Value38 = nil
RunService.Heartbeat:Connect( function( Argument1 )
    Storage.Number10 = Storage.Number10 + Argument1

    if Storage.Number10 < 0.1 then
        if Ban.Visible or Resultats.Visible or Storage.ChoixArme.Visible then
            if not ClientState.CursorFree then
                ClientState.CursorFree = true
            end
        end

        return
    end
    local Max
    Storage.Number10 = 0
    local Phase = MatchState:GetAttribute( "Phase" )
    RenderStatut( )
    RenderAlive( )
    RenderBan( )
    RenderSpectate( )
    RenderClock( )
    local WaitUntil = MatchState:GetAttribute( "WaitUntil" )

    if type( WaitUntil ) == "number" then
        Max = math.max( 0, WaitUntil - workspace:GetServerTimeNow( ) )
    else
        Max = nil
    end
    if Max then
        if Storage.Value38 ~= nil then
            Storage.Value38 = nil
            Number = Number + 1
            Annonce.Visible = false
            Annonce.Size = Table.annSize
        end
    elseif Phase ~= "countdown" or MatchState:GetAttribute( "Picking" ) then
        Storage.Value38 = nil
    else
        local Max2
        local PhaseEnd = MatchState:GetAttribute( "PhaseEnd" )

        if type( PhaseEnd ) ~= "number" or PhaseEnd <= 0 then
            Max2 = nil
        else
            Max2 = math.max( 0, PhaseEnd - workspace:GetServerTimeNow( ) )
        end

        local Text
        local Max3 = Max2 or 0
        local Ceil = math.ceil( Max3 )

        if Config.RoundCountdown + 0.05 < Max3 then
            Text = "round"
        else
            Text = tostring( Ceil )
        end
        if Text ~= Storage.Value38 then
            Storage.Value38 = Text

            if Text == "round" then
                local Text2
                local Max4 = math.max( 1, tonumber( A( "Round" ) ) or 1 )

                if Max4 == tonumber( A( "SwapRound" ) ) then
                    Text2 = "SWITCHING SIDES"
                else
                    local Number2
                    local NumberInner = tonumber( A( "WinRounds" ) )
                    Number2 = if NumberInner then NumberInner else Config.WinRounds
                    Text2 = "FIRST TO " .. Number2 .. " ROUNDS"
                end

                Announce( "ROUND " .. Max4, Text2, "Neutre", nil, 1.3 )

                if Max4 == 1 then
                    Sfx.Play( "Impact", { volume = 0.75 } )
                end
            elseif Ceil >= 1 then
                local Flag = ( tonumber( A( "Round" ) ) or 0 ) == tonumber( A( "SwapRound" ) ) and true or false
                local Text4
                local Text3 = tostring( Ceil )
                Text4 = if Flag then "SWITCHING SIDES" else nil
                Announce( Text3, Text4, "Neutre", nil, 1.4 )
                Sfx.Play( "Compte" )
            end
        end
    end
    if Phase == "results" then
        if not Flag6 and not Storage.Table28.busy( ) and Storage.Table28.pending == nil and os.clock( ) - Storage.Number9 > 6 then
            Storage.ShowResults( { } )
        end

        local Max5
        local PhaseEnd2 = MatchState:GetAttribute( "PhaseEnd" )

        if type( PhaseEnd2 ) ~= "number" or PhaseEnd2 <= 0 then
            Max5 = nil
        else
            Max5 = math.max( 0, PhaseEnd2 - workspace:GetServerTimeNow( ) )
        end
        if os.clock( ) < Storage.Number4 then
            Bas.Retour.Text = "Couldn't reach the city. Try again."
        elseif not Max5 or not ( Max5 > 0 ) then
            local Text5
            local Retour2 = Bas.Retour
            Text5 = not Max5 and "" or "Returning to the city..."
            Retour2.Text = Text5
        else
            local Retour = Bas.Retour
            Retour.Text = ( "Back to the city in %d s" ):format( ( math.ceil( Max5 ) ) )
        end
    end

    local Visible = MatchState:GetAttribute( "Picking" ) == true and true or false

    if Storage.ChoixArme.Visible then
        if Visible then
            local Max6
            local Sous = Storage.ChoixArme.Sous
            local PhaseEnd3 = MatchState:GetAttribute( "PhaseEnd" )

            if type( PhaseEnd3 ) ~= "number" or PhaseEnd3 <= 0 then
                Max6 = nil
            else
                Max6 = math.max( 0, PhaseEnd3 - workspace:GetServerTimeNow( ) )
            end

            Sous.Text = ( "Round 1 starts in %d s" ):format( ( math.ceil( ( math.max( 0, ( Max6 or 0 ) - Config.RoundCountdown ) ) ) ) )
        else
            local Text6
            local Sous2 = Storage.ChoixArme.Sous
            Text6 = Phase ~= "countdown" and "Your choice is used next round" or "Your new weapon is given right away"
            Sous2.Text = Text6
        end
        if Storage.ChoixArme.Pret.Visible ~= Visible then
            Storage.ChoixArme.Pret.Visible = Visible
        end
        if not Visible then
            local Flag2

            if Phase == "roundend" then
                Flag2 = true
            elseif Phase == "countdown" then
                Flag2 = not MatchState:GetAttribute( "Picking" )
            else
                Flag2 = false
            end
            if not Flag2 then
                Storage.ChoixArme.Visible = false
            end
        end
    end

    local Visible2

    if Phase == "roundend" then
        Visible2 = true
    elseif Phase == "countdown" then
        Visible2 = not MatchState:GetAttribute( "Picking" )
    else
        Visible2 = false
    end
    if Visible2 then
        local NotVisible = not Storage.ChoixArme.Visible

        if NotVisible then
            if Storage.Number5 > 1 then
                Visible2 = not Resultats.Visible
            else
                Visible2 = false
            end
        else
            Visible2 = NotVisible
        end
    end
    if Storage.BoutonArme.Visible ~= Visible2 then
        Storage.BoutonArme.Visible = Visible2
    end

    local Visible5
    local Visible3 = Ban.Visible

    if Visible3 then
        Visible5 = Visible3
    else
        local Visible4 = Resultats.Visible

        if Visible4 then
            Visible5 = Visible4
        else
            Visible5 = Storage.ChoixArme.Visible
        end
    end
    if Visible5 then
        ClientState.ActiveMenu = "RankedMatch"

        if not ClientState.CursorFree then
            ClientState.CursorFree = true
        end

        Flag3 = true
        return
    end
    if Flag3 then
        Flag3 = false

        if ClientState.ActiveMenu == "RankedMatch" then
            ClientState.ActiveMenu = nil
            ClientState.CursorFree = false
        end
    end

    return
end )

if RunService:IsStudio( ) then
    workspace:GetAttributeChangedSignal( "RankedMatch" ):Connect( function()
        if workspace:GetAttribute( "RankedMatch" ) then
            return
        end

        Number2 = Number2 + 1
        Resultats.Visible = false
        Ban.Visible = false

        if Value7 then
            Value7:Disconnect( )
            Value7 = nil
        end
        for Key, Value in PlayerGui:GetChildren( ) do
            local RankedResultsHide = Value:FindFirstChild( "RankedResultsHide" )

            if RankedResultsHide then
                RankedResultsHide:Destroy( )
            end
        end

        SetSpectate( nil )

        if Flag3 then
            Flag3 = false

            if ClientState.ActiveMenu == "RankedMatch" then
                ClientState.ActiveMenu = nil
                ClientState.CursorFree = false
            end
        end

        ReleaseHeld( )
        Parent.Enabled = false
        local FoundChild = game:GetService( "StarterGui" ):FindFirstChild( Parent.Name )

        if FoundChild then
            local Archivable = FoundChild.Archivable
            FoundChild.Archivable = true
            local Clone = FoundChild:Clone( )
            FoundChild.Archivable = Archivable

            if Clone then
                Clone.Parent = PlayerGui
            end
        end

        Parent:Destroy( )
    end )
end

Storage.Success, Storage.Result = pcall( function()
    return require( ReplicatedStorage:WaitForChild( "GamepadNav", 10 ) )
end )

if Storage.Success and type( Storage.Result ) == "table" then

    Storage.TopLeft = function( Object )
        local Value1 = nil

        for Key, Value in Object:GetDescendants( ) do
            if Value:IsA( "GuiButton" ) and Value.Visible and Value.AbsoluteSize.Y > 2 then
                local Value2
                local AbsolutePosition = Value.AbsolutePosition
                Value2 = if Value1 then Value1.AbsolutePosition else Value1

                if Value1 and not ( AbsolutePosition.Y < Value2.Y - 4 ) then
                    if not ( math.abs( AbsolutePosition.Y - Value2.Y ) <= 4 ) or not ( AbsolutePosition.X < Value2.X ) then
                        continue
                    end
                end

                Value1 = Value
            end
        end

        return Value1
    end

    Storage.NavFor = function( Object, Argument2, Argument3 )
        local function Sync()
            if Object.Visible then
                if not Storage.Result.IsOpen( Argument2 ) then
                    local Clone = table.clone( Argument3 )
                    Clone.root = Object
                    Storage.Result.Open( Argument2, Clone )
                    return
                end
            else
                local Visible3
                local Visible = Ban.Visible

                if Visible then
                    Visible3 = Visible
                else
                    local Visible2 = Resultats.Visible

                    if Visible2 then
                        Visible3 = Visible2
                    else
                        Visible3 = Storage.ChoixArme.Visible
                    end
                end
                if Visible3 then
                    ClientState.ActiveMenu = "RankedMatch"

                    if not ClientState.CursorFree then
                        ClientState.CursorFree = true
                    end

                    Flag3 = true
                elseif Flag3 then
                    Flag3 = false

                    if ClientState.ActiveMenu == "RankedMatch" then
                        ClientState.ActiveMenu = nil
                        ClientState.CursorFree = false
                    end
                end

                Storage.Result.Close( Argument2 )
            end
        end

        Object:GetPropertyChangedSignal( "Visible" ):Connect( Sync )
        local Flag = false
        Object.DescendantAdded:Connect( function( Object )
            if Flag or not Object:IsA( "GuiButton" ) then
                return
            end
            Flag = true
            task.delay( 0.1, function()
                Flag = false

                if Storage.Result.IsOpen( Argument2 ) then
                    Storage.Result.Refresh( Argument2 )
                end
            end )
            return
        end )
        Sync( )
    end

    Storage.NavFor( Ban, "RankedBan", {
        first = function()
            local Cartes2
            local Cartes = Ban:FindFirstChild( "Cartes" )
            Cartes2 = if Cartes then Cartes else Ban
            return ( Storage.TopLeft( Cartes2 ) )
        end
    } )
    Storage.NavFor( Storage.ChoixArme, "RankedPick", {
        first = function()
            local Descendants
            local Cartes = Storage.ChoixArme:FindFirstChild( "Cartes" )
            Descendants = Cartes and Cartes:GetDescendants( ) or { }
            local Value1 = nil

            for Key, Value in Descendants, nil, nil do
                local Selection
                local IsA = Value:IsA( "GuiButton" )

                if IsA then
                    Selection = Value:FindFirstChild( "Selection" )
                else
                    Selection = IsA
                end
                if Selection then
                    if not Selection:IsA( "UIStroke" ) or not Selection.Enabled or not ( Selection.Transparency < 0.5 ) then
                        if not Selection:IsA( "GuiObject" ) then
                            continue
                        end
                        if not Selection.Visible then
                            continue
                        end
                    end

                    return Value
                end
            end

            return Storage.ChoixArme:FindFirstChild( "Pret" )
        end,
        onBack = function()
            if not Storage.Flag8 then
                if MatchState:GetAttribute( "Picking" ) then
                    Storage.Flag8 = true
                    task.spawn( pcall, MatchFn.InvokeServer, MatchFn, "pickReady" )
                end
            end

            Storage.ChoixArme.Visible = false
        end
    } )
    Storage.NavFor( Resultats, "RankedResults", {
        first = function()
            local Rejouer2

            if Bas.Rejouer.Visible then
                local Rejouer = Bas.Rejouer

                if Rejouer then
                    Rejouer2 = Rejouer
                else
                    Rejouer2 = Bas.Quitter
                end
            else
                Rejouer2 = Bas.Quitter
            end

            return Rejouer2
        end,
        noHints = true
    } )
    Storage.Table40 = { Bas, Bas.Rejouer, Bas.Quitter }
    Storage.Value39 = nil

    for Key15, Value40 in Storage.Table40, nil, nil do
        Value40:GetPropertyChangedSignal( "Visible" ):Connect( function()
            if Storage.Result.IsOpen( "RankedResults" ) then
                local Rejouer2
                local Refresh = Storage.Result.Refresh

                if Bas.Rejouer.Visible then
                    local Rejouer = Bas.Rejouer

                    if Rejouer then
                        Rejouer2 = Rejouer
                    else
                        Rejouer2 = Bas.Quitter
                    end
                else
                    Rejouer2 = Bas.Quitter
                end

                Refresh( "RankedResults", Rejouer2 )
            end
        end )
    end
end
