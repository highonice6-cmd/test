-- StarterPlayer.StarterPlayerScripts.PlayerProfileClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
local GuiService = game:GetService( "GuiService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local BadgeCatalog = require( ReplicatedStorage:WaitForChild( "BadgeCatalog" ) )
local Stretch = require( ReplicatedStorage:WaitForChild( "Stretch" ) )
local ScaleUI = require( ReplicatedStorage:WaitForChild( "ScaleUI" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local ClanShared = require( ReplicatedStorage:WaitForChild( "ClanShared" ) )
local LocalPlayer = Players.LocalPlayer
local Parent = workspace.CurrentCamera
local OutlineColor = Color3.new( 0, 0, 0 )
local Parent2 = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "PlayerProfile", math.huge )
Parent2.Enabled = false
local Panel = Parent2:WaitForChild( "Panel" )
local Badges = Panel:WaitForChild( "Badges" )
local BadgeTooltip = Parent2:WaitForChild( "BadgeTooltip" )
BadgeTooltip.Visible = false
local Value1 = nil

local function ShowTip( Parent, Argument2 )
    local Titre = BadgeTooltip:FindFirstChild( "Titre" )
    local Description = BadgeTooltip:FindFirstChild( "Description" )

    if Titre then
        local FromRGB2
        Titre.Text = Argument2.label

        if Argument2.color == "rainbow" then
            local FromRGB = Color3.fromRGB( 255, 225, 120 )

            if FromRGB then
                FromRGB2 = FromRGB
            else
                FromRGB2 = Argument2.color
            end
        else
            FromRGB2 = Argument2.color
        end

        local TextColor3
        local _, _, ToHSV3 = FromRGB2:ToHSV( )

        if ToHSV3 < 0.35 then
            local FromRGB3 = Color3.fromRGB( 220, 220, 225 )

            if FromRGB3 then
                TextColor3 = FromRGB3
            else
                TextColor3 = FromRGB2
            end
        else
            TextColor3 = FromRGB2
        end

        Titre.TextColor3 = TextColor3
    end
    if Description then
        Description.Text = Argument2.badge.desc or ""
    end

    local AbsolutePosition = Parent.AbsolutePosition
    local AbsoluteSize = Parent.AbsoluteSize
    local AbsolutePosition2 = BadgeTooltip.Parent.AbsolutePosition
    BadgeTooltip.Position = ScaleUI.FromAbs( BadgeTooltip, AbsolutePosition.X + AbsoluteSize.X / 2 - AbsolutePosition2.X, AbsolutePosition.Y - AbsoluteSize.Y * 0.12 - AbsolutePosition2.Y )
    BadgeTooltip.Visible = true
    Value1 = Parent
end

local Stats = Panel:WaitForChild( "Stats" )
local Modeles = Badges:WaitForChild( "Modeles" )
local Clone = Modeles:WaitForChild( "Tuile" ):Clone( )
local Clone2 = Modeles:WaitForChild( "Badge" ):Clone( )
local Clone3 = Modeles:WaitForChild( "Embleme" ):Clone( )
local Table = { Clone, Clone2, Clone3 }
Value2 = nil

for Key, Value in Table, nil, nil do
    Value.Visible = true
end

local Niveau = Panel:WaitForChild( "Niveau" )
local TousBadges = Panel:WaitForChild( "TousBadges" )
local Grille = TousBadges:WaitForChild( "Grille" )
local ToutVoir = Panel:WaitForChild( "ToutVoir" )
local Table2 = {
    Niveau,
    Panel:WaitForChild( "Trait2" ),
    Panel:WaitForChild( "TitreBadges" ),
    Panel:WaitForChild( "NombreBadges" ),
    Badges
}
local Onglets = Panel:FindFirstChild( "Onglets" )
local Ranked = Panel:FindFirstChild( "Ranked" )
local Table3 = {
    Panel:FindFirstChild( "Separation" ),
    Panel:FindFirstChild( "TitreStats" ),
    Stats
}
local Text = "profile"

local function ChipAfter( Object, Argument2 )
    if not Object or not Argument2 then
        return
    end
    local function Lay()
        local Parent = Argument2.Parent

        if not Parent or not Parent:IsA( "GuiObject" ) or Parent.AbsoluteSize.X < 1 or Object.TextBounds.X < 1 then
            return
        end
        local Y = Object.TextBounds.Y * 0.4
        Argument2.Position = UDim2.fromScale( ( Object.AbsolutePosition.X - Parent.AbsolutePosition.X + Object.TextBounds.X + Y ) / Parent.AbsoluteSize.X, Argument2.Position.Y.Scale )
        return
    end

    Object:GetPropertyChangedSignal( "TextBounds" ):Connect( Lay )
    Lay( )
    return
end

local TitreBadges = Panel:FindFirstChild( "TitreBadges" )
local NombreBadges = Panel:FindFirstChild( "NombreBadges" )

if TitreBadges then
    if NombreBadges then
        local function Lay()
            local Parent = NombreBadges.Parent

            if not Parent or not Parent:IsA( "GuiObject" ) or Parent.AbsoluteSize.X < 1 or TitreBadges.TextBounds.X < 1 then
                return
            end
            local Y = TitreBadges.TextBounds.Y * 0.4
            NombreBadges.Position = UDim2.fromScale( ( TitreBadges.AbsolutePosition.X - Parent.AbsolutePosition.X + TitreBadges.TextBounds.X + Y ) / Parent.AbsoluteSize.X, NombreBadges.Position.Y.Scale )
            return
        end

        TitreBadges:GetPropertyChangedSignal( "TextBounds" ):Connect( Lay )
        Lay( )
    end
end

local Titre = TousBadges:FindFirstChild( "Titre" )
local Nombre = TousBadges:FindFirstChild( "Nombre" )

if Titre then
    if Nombre then
        local function Lay2()
            local Parent = Nombre.Parent

            if not Parent or not Parent:IsA( "GuiObject" ) or Parent.AbsoluteSize.X < 1 or Titre.TextBounds.X < 1 then
                return
            end
            local Y = Titre.TextBounds.Y * 0.4
            Nombre.Position = UDim2.fromScale( ( Titre.AbsolutePosition.X - Parent.AbsolutePosition.X + Titre.TextBounds.X + Y ) / Parent.AbsoluteSize.X, Nombre.Position.Y.Scale )
            return
        end

        Titre:GetPropertyChangedSignal( "TextBounds" ):Connect( Lay2 )
        Lay2( )
    end
end

local function ClearTiles( Object )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "GuiObject" ) then
            Value:Destroy( )
        end
    end
end

ClearTiles( Badges )
ClearTiles( Grille )

local function SetValue( Name, Text )
    local Valeur
    local FoundChild = Stats:FindFirstChild( Name )

    if FoundChild then
        Valeur = FoundChild:FindFirstChild( "Valeur" )
    else
        Valeur = FoundChild
    end
    if Valeur then
        Valeur.Text = Text
    end
end

local function Num( Text )
    local Sub
    local Floor = math.floor( tonumber( Text ) or 0 )
    local Reverse = tostring( ( math.abs( Floor ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( )

    if Reverse:sub( 1, 1 ) == "," then
        Sub = Reverse:sub( 2 )
    else
        Sub = Reverse
    end

    local Text2 = not ( Floor < 0 ) and "" or "-"
    return Text2 .. Sub
end

local function Short( Text )
    if Text >= 1000000 then
        return ( ( "%.1fM" ):format( Text / 1000000 ):gsub( "%.0M", "M" ) )
    end
    return ( Num( Text ) )
end

local Table4 = { }
RunService.RenderStepped:Connect( function( Amount )
    if not Parent2.Enabled then
        return
    end

    local Value1 = nil

    for Key, Value in Table4, nil, nil do
        if Value.Parent then
            Value.Rotation = ( Value.Rotation + Amount * 90 ) % 360
        end
    end
end )
local Value3 = nil
local Table5 = { }

local function BadgeTile( Value, LayoutOrder )
    local Emblem2
    local Badge = Value.badge
    local Image = Value.image
    local Emblem = Value.emblem

    if Emblem then
        if Image == nil then
            Emblem2 = false
        else
            Emblem2 = true
        end
    else
        Emblem2 = Emblem
    end

    local Captured = Emblem2 and Clone3 or Clone2
    local CloneInner = Captured:Clone( )
    CloneInner.Name = Badge.id
    local UIGradient = CloneInner:FindFirstChildOfClass( "UIGradient" )

    if Emblem2 then
        local Logo = CloneInner:FindFirstChild( "Logo" )
        local Fit = Value.fit

        if Logo and Fit then
            local Scale = Logo.Size.X.Scale * 0.474 / Fit.r
            local Min = math.min( Scale, 1.15 / Fit.span )
            Logo.Size = UDim2.fromScale( Min, Min )
            Logo.Position = UDim2.fromScale( Logo.Position.X.Scale, Logo.Position.Y.Scale - Fit.dy * Min )
        end
    elseif Value.color == "rainbow" then
        CloneInner.BackgroundColor3 = Color3.new( 1, 1, 1 )

        if UIGradient then
            UIGradient.Color = BadgeCatalog.RAINBOW
            table.insert( Table4, UIGradient )
        end
    else
        CloneInner.BackgroundColor3 = Value.color
        local _, _, ToHSV3 = Value.color:ToHSV( )
        local UIStroke = CloneInner:FindFirstChildOfClass( "UIStroke" )

        if ToHSV3 < 0.2 and UIStroke then
            UIStroke.Color = Color3.fromRGB( 200, 200, 205 )
        end
    end

    local Logo2 = CloneInner:FindFirstChild( "Logo" )
    local Icon = CloneInner:FindFirstChild( "Icon" )

    if Logo2 then
        local Visible
        Logo2.Image = Image or ""
        Visible = Image ~= nil and true or false
        Logo2.Visible = Visible
    end
    if Icon then
        Icon.Text = Badge.icon or ""
        Icon.Visible = not ( Image and Logo2 )
    end

    local BadgeName = CloneInner:FindFirstChild( "BadgeName" )

    if BadgeName then
        BadgeName.Text = Value.label
    end

    local Tint2
    local Parent = Clone:Clone( )
    Parent.Name = Badge.id
    Parent.LayoutOrder = LayoutOrder
    local Tint = Value.tint

    if Tint then
        Tint2 = Tint
    elseif typeof( Value.color ) ~= "Color3" or not Value.color then
        Tint2 = nil
    else
        Tint2 = Value.color
    end
    if Tint2 then
        Parent.BackgroundColor3 = Tint2:Lerp( Color3.new( 0, 0, 0 ), 0.5 )
        Parent.BackgroundTransparency = 0.3
    end

    CloneInner.Parent = Parent
    GamepadNav.Hover( Parent, function()
        ShowTip( Parent, Value )
    end, function()
        if Value1 == Parent then
            Value1 = nil
            BadgeTooltip.Visible = false
        end
    end )
    return Parent
end

local Flag = false
local Number = 0

local function ApplyView()
    if Text == "ranked" then
        return
    end

    local Visible = Number > 8 and true or false

    if not Visible then
        Flag = false
    end

    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        Value.Visible = not Flag
    end

    local TextInner
    TousBadges.Visible = Flag
    ToutVoir.Visible = Visible
    local Texte = ToutVoir.Texte

    if Flag then
        TextInner = "Show less"
    else
        TextInner = ( "View all %d badges" ):format( Number )
    end

    local Text2
    Texte.Text = TextInner
    local Fleche = ToutVoir.Fleche
    Text2 = not Flag and ">" or "<"
    Fleche.Text = Text2
end

local function FillBadges()
    local Captured
    local SelectedObject = GuiService.SelectedObject

    if SelectedObject then
        if SelectedObject.Parent ~= Badges or not Badges then
            if SelectedObject.Parent ~= Grille or not Grille then
                Captured = nil
            else
                Captured = Grille
            end
        else
            Captured = Badges
        end
    else
        Captured = nil
    end

    local Captured2 = if Captured then SelectedObject.Name else Captured
    local Value1
    ClearTiles( Badges )
    ClearTiles( Grille )
    BadgeTooltip.Visible = false
    table.clear( Table4 )
    local Parse = BadgeCatalog.Parse( Value3:GetAttribute( "Badges" ) )
    Value1 = nil

    for Key, Value in Parse, nil, nil do
        if Key <= 8 then
            BadgeTile( Value, Key ).Parent = Badges
        end

        BadgeTile( Value, Key ).Parent = Grille
    end

    Number = #Parse
    local Texte = Panel.NombreBadges.Texte
    Texte.Text = tostring( Number )
    local Texte2 = TousBadges.Nombre.Texte
    Texte2.Text = tostring( Number )
    ApplyView( )

    if Captured2 then
        task.delay( 0.05, function()
            local FoundChild = Captured:FindFirstChild( Captured2 )

            if FoundChild then
                GamepadNav.Select( FoundChild )
            end
        end )
    end
end

local function FillLevel()
    local Clamp2
    local Floor = math.floor( tonumber( Value3:GetAttribute( "Level" ) ) or 1 )
    local Max = math.max( 0, tonumber( Value3:GetAttribute( "XP" ) ) or 0 )
    local Number = tonumber( Value3:GetAttribute( "XPNext" ) )

    if not Number or not ( Number > 0 ) then
        Clamp2 = 1
    else
        local Clamp = math.clamp( Max / Number, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 1
        end
    end

    local Visible
    local Texte = Niveau.Pastille.Texte
    Texte.Text = "LVL " .. Floor
    local Remplissage = Niveau.Barre.Remplissage
    Remplissage.Size = UDim2.fromScale( Clamp2, 1 )
    Visible = Clamp2 > 0 and true or false
    Remplissage.Visible = Visible

    if not Number then
        Niveau.Pourcent.Text = "MAX"
        Niveau.XP.Text = "MAX LEVEL"
        Niveau.Reste.Text = ""
        return
    end

    local Gsub
    local Pourcent = Niveau.Pourcent
    Pourcent.Text = math.floor( Clamp2 * 100 ) .. "%"
    local XP = Niveau.XP

    if Max >= 1000000 then
        Gsub = ( "%.1fM" ):format( Max / 1000000 ):gsub( "%.0M", "M" )
    else
        Gsub = Num( Max )
    end

    local Gsub2

    if Number >= 1000000 then
        Gsub2 = ( "%.1fM" ):format( Number / 1000000 ):gsub( "%.0M", "M" )
    else
        Gsub2 = Num( Number )
    end

    local Gsub3
    XP.Text = ( "%s / %s XP" ):format( Gsub, Gsub2 )
    local Reste = Niveau.Reste
    local Max2 = math.max( 0, Number - Max )

    if Max2 >= 1000000 then
        Gsub3 = ( "%.1fM" ):format( Max2 / 1000000 ):gsub( "%.0M", "M" )
    else
        Gsub3 = Num( Max2 )
    end

    Reste.Text = ( "%s XP to level %d" ):format( Gsub3, Floor + 1 )
end

local HttpService = game:GetService( "HttpService" )
local Value4 = nil

local function Ranked2()
    if Value4 then
        return Value4
    end

    local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

    if not RankedShared then
        return nil
    end

    local Success, Result, Success3, Success4 = pcall( function()
        return require( RankedShared.Ranks ), require( RankedShared.Badges ), require( RankedShared.Config )
    end )

    if Success then
        Value4 = { Ranks = Result, Badges = Success3, Config = Success4 }
    end

    return Value4
end

local Table6 = { "I", "II", "III" }

local function ParseKey( Argument1 )
    if type( Argument1 ) ~= "string" then
        return nil
    end

    local Match, Match2 = Argument1:match( "^(%w+):(%d*)$" )

    if Match == "Unranked" then
        return nil
    end
    return Match, ( tonumber( Match2 ) )
end

local function RankName( Argument1, Argument2, NameName )
    local Top2
    local Top = Argument1.Config.Top
    Top2 = if Top then Top else { }
    local Value1 = nil

    for Key, Value in Top2, nil, nil do
        if Value.id == Argument2 then
            return string.upper( Value.name )
        end
    end

    local Ranks2
    local Ranks = Argument1.Config.Ranks
    Ranks2 = if Ranks then Ranks else { }
    local Value2 = nil

    for Key2, Value3 in Ranks2, nil, nil do
        if Value3.id == Argument2 then
            local Text2
            local Name = Value3.name

            if not NameName or not Table6[ NameName ] then
                Text2 = ""
            else
                local Text = " " .. Table6[ NameName ]

                if Text then
                    Text2 = Text
                else
                    Text2 = ""
                end
            end

            return string.upper( Name .. Text2 )
        end
    end

    return string.upper( ( tostring( Argument2 ) ) )
end

local function PaintRank( Object, RankName )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            local Enabled = Value.Name == ( RankName or "Unranked" ) and true or false
            Value.Enabled = Enabled
        end
    end
end

local function SetBadge( Argument1, Argument2, Argument3, Argument4 )
    local Image

    if Argument3 then
        Image = Argument2.Badges.Image( Argument3, Argument4 )
    else
        Image = Argument3
    end

    local Visible = Image ~= nil and true or false
    Argument1.Visible = Visible

    if Image then
        Argument2.Badges.Place( Argument1, Image )
    end

    local Flag = Image ~= nil and true or false
    return Flag
end

local function FitBadge( Object, Argument2, Argument3, Argument4, Argument5, Argument6, Argument7 )
    local Image

    if Argument3 then
        Image = Argument2.Badges.Image( Argument3, Argument4 )
    else
        Image = Argument3
    end

    local Visible = Image ~= nil and true or false
    Object.Visible = Visible

    if not Image then
        return false
    end

    local Visible2, Visible22

    if Argument2.Badges.Visible then
        Visible2, Visible22 = Argument2.Badges.Visible( Image )
    else
        Visible22 = 0.5
        Visible2 = -0.5
    end

    local Max = Argument6 / math.max( Visible22 - Visible2, 0.2 )
    Object:SetAttribute( "BadgeCenter", UDim2.fromScale( Argument5, 0.5 - ( Visible2 + Visible22 ) / 2 * Max ) )
    Object:SetAttribute( "BadgeSize", UDim2.fromScale( Max * Argument7, Max ) )
    Argument2.Badges.Place( Object, Image )
    return true
end

local function Place( Self, Argument2, Argument3, Argument4 )
    local PosAvecBadge = Self:GetAttribute( "PosAvecBadge" )
    local TailleAvecBadge = Self:GetAttribute( "TailleAvecBadge" )

    if typeof( PosAvecBadge ) ~= "UDim2" or typeof( TailleAvecBadge ) ~= "UDim2" then
        return
    end

    local Position

    if not Argument2 or not PosAvecBadge then
        Position = UDim2.fromScale( Argument3, PosAvecBadge.Y.Scale )
    else
        Position = PosAvecBadge
    end

    local Size
    Self.Position = Position

    if not Argument2 or not TailleAvecBadge then
        Size = UDim2.fromScale( Argument4, TailleAvecBadge.Y.Scale )
    else
        Size = TailleAvecBadge
    end

    Self.Size = Size
end

local function FillRanked()
    if not Ranked or not Value3 then
        return
    end

    local Ranked22 = Ranked2( )

    if not Ranked22 then
        return
    end

    local Result2
    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, ( tostring( Value3:GetAttribute( "RankedCard" ) or "" ) ) )
    Result2 = ( not Success or type( Result ) ~= "table" ) and { } or Result
    local M = type( Result2.m ) == "table" and Result2.m or { }
    local Number15
    local Number = tonumber( Result2.pn )

    if Number then
        Number15 = Number
    elseif Ranked22.Config.Placement then
        local Matches = Ranked22.Config.Placement.matches

        if Matches then
            Number15 = Matches
        else
            Number15 = 4
        end
    else
        Number15 = 4
    end

    local ModeOrder2
    local ModeOrder = Ranked22.Config.ModeOrder
    ModeOrder2 = if ModeOrder then ModeOrder else { "1v1", "2v2", "5v5" }
    local Number2, Match3
    local Meilleur = Ranked.Meilleur
    local B = Result2.b

    if type( B ) == "string" then
        local Match, Match2 = B:match( "^(%w+):(%d*)$" )

        if Match == "Unranked" then
            Match3 = nil
            Number2 = nil
        else
            Number2 = tonumber( Match2 )
            Match3 = Match
        end
    else
        Match3 = nil
        Number2 = nil
    end

    local Flag3

    if Match3 then
        local Image
        local Badge = Meilleur.Badge

        if Match3 then
            Image = Ranked22.Badges.Image( Match3, Number2 )
        else
            Image = Match3
        end

        local Visible = Image ~= nil and true or false
        Badge.Visible = Visible

        if Image then
            Ranked22.Badges.Place( Badge, Image )
        end
        if Image == nil then
            Flag3 = false
        else
            Flag3 = true
        end
    else
        Meilleur.Badge.Visible = false
        Flag3 = false
    end

    local Value2
    local Table = { "Titre", "Rang", "Detail", "Barre", "Reste" }
    Value2 = nil

    for Key, Value in Table, nil, nil do
        Place( Meilleur[ Value ], Flag3, 0.05, 0.9 )
    end

    Meilleur.Titre.Text = "BEST RANK"

    if Match3 then
        local Flag
        local Number3 = tonumber( Result2.be ) or 0

        if Match3 == "Top1" then
            Flag = true
        elseif Match3 == "Top100" then
            Flag = true
        else
            Flag = false
        end

        local NextOf2
        local Rang = Meilleur.Rang
        Rang.Text = RankName( Ranked22, Match3, Number2 )
        PaintRank( Meilleur.Rang, Match3 )
        local Detail = Meilleur.Detail
        Detail.Text = ( "%s  ·  %s ELO" ):format( string.upper( ( tostring( Result2.bm or "" ) ) ), ( Num( Number3 ) ) )
        local Of = Ranked22.Ranks.Of( Number3 )

        if Flag then
            NextOf2 = nil
        else
            local NextOf = Ranked22.Ranks.NextOf( Of )

            if NextOf then
                NextOf2 = NextOf
            else
                NextOf2 = nil
            end
        end

        local Clamp

        if not NextOf2 or not Of.ceil or not ( Of.floor < Of.ceil ) then
            Clamp = 1
        else
            Clamp = math.clamp( ( Number3 - Of.floor ) / ( Of.ceil - Of.floor ), 0, 1 )
        end

        local Visible2
        Meilleur.Barre.Visible = true
        local Remplissage = Meilleur.Barre.Remplissage
        Remplissage.Size = UDim2.fromScale( Clamp, 1 )
        local Remplissage2 = Meilleur.Barre.Remplissage
        Visible2 = Clamp > 0 and true or false
        local Text2
        Remplissage2.Visible = Visible2
        PaintRank( Meilleur.Barre.Remplissage, Match3 )
        Meilleur.Reste.Visible = true
        local Reste = Meilleur.Reste

        if NextOf2 then
            local Format = ( "%s ELO TO %s" ):format( Num( ( math.max( 0, ( Of.ceil or Number3 ) - Number3 ) ) ), string.upper( NextOf2.label ) )

            if Format then
                Text2 = Format
            elseif Flag then
                local Text = RankName( Ranked22, Match3 ) .. " OF THE SEASON"

                if Text then
                    Text2 = Text
                else
                    Text2 = "CLIMB THE LEADERBOARD"
                end
            else
                Text2 = "CLIMB THE LEADERBOARD"
            end
        elseif Flag then
            local Text = RankName( Ranked22, Match3 ) .. " OF THE SEASON"

            if Text then
                Text2 = Text
            else
                Text2 = "CLIMB THE LEADERBOARD"
            end
        else
            Text2 = "CLIMB THE LEADERBOARD"
        end

        Reste.Text = Text2
    else
        local Value3Inner, Value5, Number4
        Meilleur.Rang.Text = "NOT RANKED YET"
        PaintRank( Meilleur.Rang, nil )
        Value3Inner = nil
        Value5 = nil
        Number4 = 0

        for Key2, Value4 in ModeOrder2, nil, nil do
            local Entry3 = M[ Value4 ]

            if type( Entry3 ) == "table" and Number4 < ( tonumber( Entry3.p ) or 0 ) then
                Number4 = tonumber( Entry3.p )
                Value5 = Value4
            end
        end

        local Text3
        local Detail2 = Meilleur.Detail

        if Value5 then
            local Format2 = ( "PLACEMENTS %d / %d IN %s" ):format( Number4, Number15, string.upper( Value5 ) )

            if Format2 then
                Text3 = Format2
            else
                Text3 = ( "PLAY %d PLACEMENT MATCHES TO GET A RANK" ):format( Number15 )
            end
        else
            Text3 = ( "PLAY %d PLACEMENT MATCHES TO GET A RANK" ):format( Number15 )
        end

        local Value6
        Detail2.Text = Text3
        Meilleur.Barre.Visible = false
        Meilleur.Reste.Visible = false
        local Table2 = { "Titre", "Rang", "Detail" }
        Value6 = nil

        for Key3, Value7 in Table2, nil, nil do
            local Entry2 = Meilleur[ Value7 ]
            Entry2.Position = Entry2.Position + UDim2.fromScale( 0, 0.11 )
        end
    end

    local Value8 = nil

    for Key4, Value9 in ModeOrder2, nil, nil do
        local FoundChild = Ranked.Modes:FindFirstChild( "Mode_" .. Value9 )

        if FoundChild then
            local Flag2
            local Entry = M[ Value9 ]
            Flag2 = type( Entry ) == "table" and true or false
            local R = Flag2 and Entry.r or nil
            local Number10, Match5

            if type( R ) == "string" then
                local Match4, Match22 = R:match( "^(%w+):(%d*)$" )

                if Match4 == "Unranked" then
                    Match5 = nil
                    Number10 = nil
                else
                    Number10 = tonumber( Match22 )
                    Match5 = Match4
                end
            else
                Match5 = nil
                Number10 = nil
            end

            local Number13

            if Flag2 then
                local Number11 = tonumber( Entry.w )

                if Number11 then
                    Number13 = Number11
                else
                    Number13 = 0
                end
            else
                Number13 = 0
            end

            local Number14

            if Flag2 then
                local Number12 = tonumber( Entry.l )

                if Number12 then
                    Number14 = Number12
                else
                    Number14 = 0
                end
            else
                Number14 = 0
            end

            local Mode = FoundChild.Mode
            Mode.Text = string.upper( Value9 )

            if Match5 then
                FitBadge( FoundChild.Badge, Ranked22, Match5, Number10, 0.085, 0.8, 0.15 )
                local Rang2 = FoundChild.Rang
                Rang2.Text = RankName( Ranked22, Match5, Number10 )
                PaintRank( FoundChild.Rang, Match5 )
                local Elo = FoundChild.Elo
                Elo.Text = Num( Entry.e ) .. " ELO"
            else
                local Text8
                FoundChild.Badge.Visible = false
                local Rang3 = FoundChild.Rang

                if Flag2 then
                    local Format4 = ( "PLACEMENTS %d / %d" ):format( tonumber( Entry.p ) or 0, Number15 )

                    if Format4 then
                        Text8 = Format4
                    else
                        Text8 = "NOT PLAYED"
                    end
                else
                    Text8 = "NOT PLAYED"
                end

                Rang3.Text = Text8
                PaintRank( FoundChild.Rang, nil )
                FoundChild.Elo.Text = "–"
            end

            local Text9
            local Bilan = FoundChild.Bilan
            Text9 = Number13 + Number14 > 0 and ( "%d W  ·  %d L" ):format( Number13, Number14 ) or "No matches yet"
            Bilan.Text = Text9
        end
    end

    local RankedShared2
    local Stats = Ranked.Stats
    local RankedShared = game:GetService( "ReplicatedStorage" ):FindFirstChild( "RankedShared" )
    RankedShared2 = if RankedShared then RankedShared:FindFirstChild( "Config" ) else RankedShared
    local Number5
    local Success2, Result3 = pcall( require, RankedShared2 )

    if not Success2 or type( Result3 ) ~= "table" or not Result3.SeasonAt then
        Number5 = 0
    else
        local SeasonAt = Result3.SeasonAt
        local Success3, Result4 = pcall( SeasonAt, os.time( ) )

        if not Success3 or type( Result4 ) ~= "table" then
            Number5 = 0
        else
            Number5 = ( tonumber( Result4.endsAt ) or 0 ) - os.time( )
        end
    end

    local Text5
    local Number6 = Number5 // 86400
    local Number7 = Number5 % 86400 // 3600

    if Number5 > 0 then
        local Format3

        if not ( Number6 > 0 ) or not ( "%dD %dH LEFT" ):format( Number6, Number7 ) then
            Format3 = ( "%dH LEFT" ):format( ( math.max( 1, Number7 ) ) )
        else
            Format3 = ( "%dD %dH LEFT" ):format( Number6, Number7 )
        end

        local Text4 = "  ·  " .. Format3

        if Text4 then
            Text5 = Text4
        else
            Text5 = ""
        end
    else
        Text5 = ""
    end

    local Text7
    local Texte = Ranked.Saison.Texte
    Texte.Text = tostring( Result2.sn or "SEASON" ) .. Text5
    local Valeur = Stats.Kills.Valeur
    Valeur.Text = Num( tonumber( Result2.k ) or 0 )
    local Number8 = tonumber( Result2.w ) or 0
    local Number9 = tonumber( Result2.l ) or 0
    local Valeur2 = Stats.TauxVictoire.Valeur

    if Number8 + Number9 > 0 then
        local Text6 = math.floor( Number8 / ( Number8 + Number9 ) * 100 + 0.5 ) .. "%"

        if Text6 then
            Text7 = Text6
        else
            Text7 = "–"
        end
    else
        Text7 = "–"
    end

    Valeur2.Text = Text7
    local Valeur3 = Stats.Victoires.Valeur
    Valeur3.Text = Num( Number8 )
end

local function PaintTabs()
    if not Onglets then
        return
    end
    for Key, Value in Onglets:GetChildren( ) do
        if Value:IsA( "GuiButton" ) then
            local Flag = Value.Name == "Ranked" and true or false
            local Flag2 = Text == "ranked" and true or false
            local Flag3 = Flag == Flag2 and true or false
            local BackgroundTransparency = not Flag3 and 1 or 0
            Value.BackgroundTransparency = BackgroundTransparency
            local Texte = Value:FindFirstChild( "Texte" )

            if Texte then
                local TextInner = not Flag3 and "CouleurInactif" or "CouleurActif"
                local TextColor3 = Texte:GetAttribute( TextInner )

                if typeof( TextColor3 ) == "Color3" then
                    Texte.TextColor3 = TextColor3
                end

                local UIStroke = Texte:FindFirstChildOfClass( "UIStroke" )

                if UIStroke then
                    UIStroke.Enabled = not Flag3
                end
            end
        end
    end
end

local function SetTab( TabName )
    if not Ranked or not Onglets or not Onglets.Visible then
        TabName = "profile"
    end

    local Visible
    Text = TabName
    Visible = TabName == "ranked" and true or false
    BadgeTooltip.Visible = false

    if Ranked then
        Ranked.Visible = Visible
    end

    local Value1 = nil

    for Key, Value in Table3, nil, nil do
        if Value then
            Value.Visible = not Visible
        end
    end
    if Visible then
        local Value2 = nil

        for Key2, Value3 in Table2, nil, nil do
            Value3.Visible = false
        end

        TousBadges.Visible = false
        ToutVoir.Visible = false
        FillRanked( )
    else
        ApplyView( )
    end

    PaintTabs( )
end

local function Fill( Name )
    if not Value3 or not Value3.Parent then
        return
    end

    local DisplayName4
    local IsA = Value3:IsA( "Player" )

    if IsA then
        local DisplayName = Value3.DisplayName

        if DisplayName then
            DisplayName4 = DisplayName
        else
            local DisplayName2 = Value3:GetAttribute( "DisplayName" )

            if DisplayName2 then
                DisplayName4 = DisplayName2
            else
                DisplayName4 = Value3.Name
            end
        end
    else
        local DisplayName2 = Value3:GetAttribute( "DisplayName" )

        if DisplayName2 then
            DisplayName4 = DisplayName2
        else
            DisplayName4 = Value3.Name
        end
    end

    local Name3

    if IsA then
        local Name2 = Value3.Name

        if Name2 then
            Name3 = Name2
        else
            local UserName = Value3:GetAttribute( "UserName" )

            if UserName then
                Name3 = UserName
            else
                Name3 = Value3.Name
            end
        end
    else
        local UserName = Value3:GetAttribute( "UserName" )

        if UserName then
            Name3 = UserName
        else
            Name3 = Value3.Name
        end
    end

    local UserId3

    if IsA then
        local UserId = Value3.UserId

        if UserId then
            UserId3 = UserId
        else
            local UserId2 = Value3:GetAttribute( "UserId" )

            if UserId2 then
                UserId3 = UserId2
            else
                UserId3 = 1
            end
        end
    else
        local UserId2 = Value3:GetAttribute( "UserId" )

        if UserId2 then
            UserId3 = UserId2
        else
            UserId3 = 1
        end
    end

    local Text
    Panel.DisplayName.RichText = true
    local DisplayName3 = Panel.DisplayName
    DisplayName3.Text = ClanShared.PrefixRich( Value3 ) .. tostring( DisplayName4 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    local UserName2 = Panel.UserName
    UserName2.Text = "@" .. Name3
    local Avatar = Panel.Avatar
    Avatar.Image = ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( UserId3 )
    local Stat_Shots = Value3:GetAttribute( "Stat_Shots" ) or 0
    local Min = math.min( Value3:GetAttribute( "Stat_Hits" ) or 0, Stat_Shots )
    local Stat_Kills = Value3:GetAttribute( "Stat_Kills" ) or 0
    local Stat_Deaths = Value3:GetAttribute( "Stat_Deaths" ) or 0

    if Stat_Shots > 0 then
        local Format = ( "%.1f%%" ):format( Min / Stat_Shots * 100 )

        if Format then
            Text = Format
        else
            Text = "—"
        end
    else
        Text = "—"
    end

    local Valeur
    local Precision = Stats:FindFirstChild( "Precision" )

    if Precision then
        Valeur = Precision:FindFirstChild( "Valeur" )
    else
        Valeur = Precision
    end
    if Valeur then
        Valeur.Text = Text
    end

    local Valeur2
    local Text2 = Num( Min )
    local Touches = Stats:FindFirstChild( "Touches" )

    if Touches then
        Valeur2 = Touches:FindFirstChild( "Valeur" )
    else
        Valeur2 = Touches
    end
    if Valeur2 then
        Valeur2.Text = Text2
    end

    local Valeur3
    local Text3 = Num( Stat_Shots - Min )
    local Rates = Stats:FindFirstChild( "Rates" )

    if Rates then
        Valeur3 = Rates:FindFirstChild( "Valeur" )
    else
        Valeur3 = Rates
    end
    if Valeur3 then
        Valeur3.Text = Text3
    end

    local Valeur4
    local Text4 = ( "%.2f" ):format( Stat_Kills / math.max( Stat_Deaths, 1 ) )
    local KD = Stats:FindFirstChild( "KD" )

    if KD then
        Valeur4 = KD:FindFirstChild( "Valeur" )
    else
        Valeur4 = KD
    end
    if Valeur4 then
        Valeur4.Text = Text4
    end

    local Valeur5
    local Text5 = Num( Stat_Kills )
    local Kills = Stats:FindFirstChild( "Kills" )

    if Kills then
        Valeur5 = Kills:FindFirstChild( "Valeur" )
    else
        Valeur5 = Kills
    end
    if Valeur5 then
        Valeur5.Text = Text5
    end

    local Valeur6
    local Text6 = Num( Stat_Deaths )
    local Morts = Stats:FindFirstChild( "Morts" )

    if Morts then
        Valeur6 = Morts:FindFirstChild( "Valeur" )
    else
        Valeur6 = Morts
    end
    if Valeur6 then
        Valeur6.Text = Text6
    end

    FillLevel( )

    if Name == nil or Name == "Badges" then
        FillBadges( )
    end
    if Name == nil or Name == "RankedCard" then
        FillRanked( )
    end
end

local Flag2 = false
local Flag3 = false
local Value5 = nil

local function TouchBlocked()
    local Flag
    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if type( CombatUntil ) ~= "number" or not ( workspace:GetServerTimeNow( ) < CombatUntil ) then
        if ClientState.Downed == true then
            Flag = true
        elseif ClientState.WardrobeOpen == true then
            Flag = true
        elseif ClientState.BetaReveal == true then
            Flag = true
        elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = true
    end

    return Flag
end

local function Close()
    local Value1
    Parent2.Enabled = false
    BadgeTooltip.Visible = false
    Value3 = nil
    Value1 = nil

    for Key, Value in Table5, nil, nil do
        Value:Disconnect( )
    end

    table.clear( Table5 )
    pcall( function()
        require( ReplicatedStorage:WaitForChild( "GamepadNav" ) ).Close( "Profile" )
    end )

    if Flag2 then
        Flag2 = false

        if ClientState.ActiveMenu == "Profile" then
            ClientState.CursorFree = false
        end
    end
    if Flag3 then
        Flag3 = false

        if Value5 then
            Value5:Fire( )
        end
    end
end

local function Open( Argument1, Argument2 )
    Close( )
    Value3 = Argument1
    Flag = false
    SetTab( "profile" )
    Fill( )
    table.insert( Table5, Argument1.AttributeChanged:Connect( Fill ) )
    Parent2.Enabled = true

    if Argument2 then
        Flag2 = true
        ClientState.ActiveMenu = "Profile"
        ClientState.CursorFree = true
    end
end

Panel:WaitForChild( "Close" ).Activated:Connect( Close )

if Onglets then
    Onglets.Visible = false

    local function HeaderWithoutTabs( Argument1 )
        local Value1
        local Table = { "DisplayName", "UserName" }
        Value1 = nil

        for Key, Value in Table, nil, nil do
            local FoundChild = Panel:FindFirstChild( Value )

            if FoundChild then
                if FoundChild:GetAttribute( "PosAvecOnglets" ) == nil then
                    FoundChild:SetAttribute( "PosAvecOnglets", FoundChild.Position )
                end

                local Text = not Argument1 and "PosAvecOnglets" or "PosSansOnglets"
                local Position = FoundChild:GetAttribute( Text )

                if typeof( Position ) == "UDim2" then
                    FoundChild.Position = Position
                end
            end
        end
    end

    HeaderWithoutTabs( true )
    task.spawn( function()
        if ReplicatedStorage:WaitForChild( "RankedShared", 20 ) and Ranked2( ) and Ranked then
            Onglets.Visible = true
            HeaderWithoutTabs( false )

            if Value3 then
                FillRanked( )
            end
        end
    end )

    for Key2, Value6 in Onglets:GetChildren( ) do
        if Value6:IsA( "GuiButton" ) then
            Value6.Activated:Connect( function()
                local Text = Value6.Name ~= "Ranked" and "profile" or "ranked"
                SetTab( Text )
                GamepadNav.Refresh( "Profile", Value6 )
            end )
        end
    end
end

ToutVoir.Activated:Connect( function()
    Flag = not Flag
    BadgeTooltip.Visible = false
    ApplyView( )
    GamepadNav.Refresh( "Profile", ToutVoir )
end )
RunService.RenderStepped:Connect( function()
    if not Parent2.Enabled then
        return
    end
    if not Value3 or not Value3.Parent then
        Close( )
        return
    end
    if Flag3 then
        return
    end
    if Flag2 then
        if ClientState.ActiveMenu ~= "Profile" or TouchBlocked( ) then
            Close( )
            return
        end
        if not ClientState.CursorFree then
            ClientState.CursorFree = true
            return
        end
    elseif not ClientState.CursorFree then
        Close( )
    end
end )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude

local function ProfileAt( Argument1, Argument2 )
    local Raycast2
    local ViewportPointToRay = Parent:ViewportPointToRay( Stretch.ToClean( Argument1, Argument2 ) )
    RaycastParams2.FilterDescendantsInstances = {
        workspace:FindFirstChild( "ClientHitboxes" ),
        workspace:FindFirstChild( "FX" ),
        Parent
    }
    local Raycast = workspace:Raycast( ViewportPointToRay.Origin, ViewportPointToRay.Direction * 500, RaycastParams2 )

    if Raycast then
        Raycast2 = Raycast.Instance
    else
        Raycast2 = Raycast
    end
    while Raycast2 do
        if Raycast2 == workspace then
            break
        end
        if not Raycast2:IsA( "Model" ) or not Raycast2:FindFirstChildOfClass( "Humanoid" ) then
            Raycast2 = Raycast2.Parent
        else
            local PlayerFromCharacter = Players:GetPlayerFromCharacter( Raycast2 )

            if PlayerFromCharacter then
                return PlayerFromCharacter
            end
            if Raycast2:GetAttribute( "ProfileBot" ) then
                return Raycast2
            end
            return nil
        end
    end

    return nil
end

local function ProfileUnderMouse()
    local MouseLocation = UserInputService:GetMouseLocation( )
    return ( ProfileAt( MouseLocation.X, MouseLocation.Y ) )
end

local function ClickableScreen( Argument1 )
    local Flag
    local LayerCollector = Argument1:FindFirstAncestorWhichIsA( "LayerCollector" )

    if LayerCollector == nil then
        Flag = false
    elseif LayerCollector:FindFirstChildWhichIsA( "GuiButton", true ) == nil then
        if LayerCollector:FindFirstChildWhichIsA( "TextBox", true ) == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = true
    end

    return Flag
end

local function OverInterface()
    local MouseLocation = UserInputService:GetMouseLocation( )
    local GuiInset = GuiService:GetGuiInset( )

    for Key, Value in LocalPlayer.PlayerGui:GetGuiObjectsAtPosition( MouseLocation.X - GuiInset.X, MouseLocation.Y - GuiInset.Y ) do
        local Flag

        if Value.BackgroundTransparency < 0.95 then
            Flag = true
        elseif Value:IsA( "ImageLabel" ) or Value:IsA( "ImageButton" ) then
            if Value.Image == "" then
                Flag = false
            elseif Value.ImageTransparency < 0.95 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = Value:IsA( "ImageButton" )
        end
        if Flag then
            local Flag2
            local LayerCollector = Value:FindFirstAncestorWhichIsA( "LayerCollector" )

            if LayerCollector == nil then
                Flag2 = false
            elseif LayerCollector:FindFirstChildWhichIsA( "GuiButton", true ) == nil then
                if LayerCollector:FindFirstChildWhichIsA( "TextBox", true ) == nil then
                    Flag2 = false
                else
                    Flag2 = true
                end
            else
                Flag2 = true
            end
            if Flag2 then
                return true
            end
        end
    end

    return false
end

local Highlight = Instance.new( "Highlight" )
Highlight.Name = "ProfileHover"
Highlight.FillTransparency = 1
Highlight.OutlineColor = OutlineColor
Highlight.OutlineTransparency = 0.45
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
Highlight.Enabled = false
Highlight.Parent = Parent
RunService.RenderStepped:Connect( function()
    local Value2

    if ClientState.CursorFree then
        local MouseLocation = UserInputService:GetMouseLocation( )
        local ProfileAt2 = ProfileAt( MouseLocation.X, MouseLocation.Y )

        if ProfileAt2 then
            Value2 = ProfileAt2
        else
            Value2 = nil
        end
    else
        Value2 = nil
    end
    if Value2 and OverInterface( ) then
        Value2 = nil
    end

    local Adornee

    if Value2 then
        if not Value2:IsA( "Player" ) or not Value2.Character then
            if Value2 then
                Adornee = Value2
            else
                Adornee = nil
            end
        else
            Adornee = Value2.Character
        end
    else
        Adornee = nil
    end
    if Highlight.Adornee ~= Adornee then
        Highlight.Adornee = Adornee
    end

    local Enabled = Adornee ~= nil and true or false
    Highlight.Enabled = Enabled
end )
local Value7 = nil
local Number2 = 0
UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if Argument1.UserInputType ~= Enum.UserInputType.MouseButton1 or Argument2 or not ClientState.CursorFree then
        return
    end
    if OverInterface( ) then
        Value7 = nil
        return
    end

    local MouseLocation = UserInputService:GetMouseLocation( )
    local ProfileAt2 = ProfileAt( MouseLocation.X, MouseLocation.Y )
    local Clock = os.clock( )

    if not ProfileAt2 or ProfileAt2 ~= Value7 or not ( Clock - Number2 <= 0.4 ) then
        Value7 = ProfileAt2
        Number2 = Clock
        return
    end
    Value7 = nil
    Close( )
    Value3 = ProfileAt2
    Flag = false
    SetTab( "profile" )
    Fill( )
    table.insert( Table5, ProfileAt2.AttributeChanged:Connect( Fill ) )
    Parent2.Enabled = true
    return
end )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local New = Icon.new( )
New:setName( "Profile" )
New:setLabel( "👤" )
New:setCaption( "My Profile" )
New:setOrder( 3 )
New.selected:Connect( function()
    task.defer( function()
        if New.isSelected then
            New:deselect( )
        end
    end )

    if TouchBlocked( ) then
        return
    end
    Close( )
    Value3 = LocalPlayer
    Flag = false
    SetTab( "profile" )
    Fill( )
    table.insert( Table5, LocalPlayer.AttributeChanged:Connect( Fill ) )
    Parent2.Enabled = true
    Flag2 = true
    ClientState.ActiveMenu = "Profile"
    ClientState.CursorFree = true
    GamepadNav.Open( "Profile", {
        root = Panel,
        first = function()
            for Key, Value in Badges:GetChildren( ) do
                if Value:IsA( "GuiObject" ) then
                    if Value.LayoutOrder == 1 then
                        return Value
                    end
                end
            end

            return Panel:FindFirstChild( "Close" )
        end,
        onBack = Close,
        freeze = false,
        backLabel = "Close"
    } )
    return
end )
local Value8 = nil
RunService.Heartbeat:Connect( function()
    local Flag = if Controls.IsGamepad == true then not TouchBlocked( ) else false

    if Flag ~= Value8 then
        Value8 = Flag
        pcall( function()
            New:setEnabled( Flag )
        end )
    end
end )
local Duel = Panel:FindFirstChild( "Duel" )
local DuelNote = Panel:FindFirstChild( "DuelNote" )
local TraitDuel = Panel:FindFirstChild( "TraitDuel" )

if Duel and DuelNote then
    local Normal2
    local Normal = Duel:FindFirstChild( "Normal" )
    Normal2 = if Normal then Normal.Color else Normal
    local ColorSequence2 = ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Color3.fromRGB( 135, 135, 135 ) ),
        ColorSequenceKeypoint.new( 0.25, Color3.fromRGB( 63, 63, 63 ) ),
        ColorSequenceKeypoint.new( 0.5, Color3.fromRGB( 8, 8, 8 ) ),
        ColorSequenceKeypoint.new( 0.75, Color3.fromRGB( 63, 63, 63 ) ),
        ColorSequenceKeypoint.new( 1, Color3.fromRGB( 135, 135, 135 ) )
    } )
    local Text2 = DuelNote.Text
    local Value9 = nil
    local Number3 = 0
    local Flag4 = false
    local Value10 = nil
    local Number4 = 0

    local function LobbyFn()
        local Remotes
        local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

        if RankedShared then
            Remotes = RankedShared:FindFirstChild( "Remotes" )
        else
            Remotes = RankedShared
        end

        local RankedShared2 = if Remotes then Remotes:FindFirstChild( "LobbyFn" ) else Remotes
        return RankedShared2
    end

    local function Target()
        if not Value3 or not Value3.Parent or workspace:GetAttribute( "RankedMatch" ) then
            return nil
        end
        if Value3:IsA( "Player" ) then
            local UserId2

            if Value3 == LocalPlayer then
                UserId2 = nil
            else
                local UserId = Value3.UserId

                if UserId then
                    UserId2 = UserId
                else
                    UserId2 = nil
                end
            end

            return UserId2
        end
        if not RunService:IsStudio( ) or not Value3:GetAttribute( "ProfileBot" ) then
            return nil
        end
        return "bot"
    end

    local function NameOf()
        if not Value3 then
            return "this player"
        end

        local Text

        if Value3:IsA( "Player" ) then
            local DisplayName = Value3.DisplayName

            if DisplayName then
                Text = DisplayName
            else
                local DisplayName2 = Value3:GetAttribute( "DisplayName" )

                if DisplayName2 then
                    DisplayName3 = DisplayName2
                else
                    DisplayName3 = Value3.Name
                end

                Text = tostring( DisplayName3 )
            end
        else
            local DisplayName3
            local DisplayName2 = Value3:GetAttribute( "DisplayName" )

            if DisplayName2 then
                DisplayName3 = DisplayName2
            else
                DisplayName3 = Value3.Name
            end

            Text = tostring( DisplayName3 )
        end

        return Text
    end

    local Text3 = ""

    local function Paint()
        local Visible
        local Target2 = Target( )

        if Target2 == nil then
            Visible = false
        else
            local NotCaptured = not Flag3

            if NotCaptured then
                local Remotes
                local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

                if RankedShared then
                    Remotes = RankedShared:FindFirstChild( "Remotes" )
                else
                    Remotes = RankedShared
                end

                local RankedShared2 = if Remotes then Remotes:FindFirstChild( "LobbyFn" ) else Remotes

                if RankedShared2 == nil then
                    Visible = false
                else
                    Visible = true
                end
            else
                Visible = NotCaptured
            end
        end
        if Duel.Visible ~= Visible then
            Duel.Visible = Visible
            DuelNote.Visible = Visible

            if TraitDuel then
                TraitDuel.Visible = Visible
            end
        end
        if not Visible then
            return
        end

        local Ceil2

        if Value9 == Target2 then
            local Ceil = math.ceil( Number3 - os.clock( ) )

            if Ceil then
                Ceil2 = Ceil
            else
                Ceil2 = 0
            end
        else
            Ceil2 = 0
        end

        local Text2Inner = Ceil2 > 0 and ( "DUEL SENT · %d s" ):format( Ceil2 ) or "DUEL 1V1"
        local Text3Inner

        if not ( os.clock( ) < Number4 ) or not Value10 then
            if Ceil2 > 0 then
                local Text

                if Value3 then
                    if Value3:IsA( "Player" ) then
                        local DisplayName = Value3.DisplayName

                        if DisplayName then
                            Text = DisplayName
                        else
                            local DisplayName2 = Value3:GetAttribute( "DisplayName" )

                            if DisplayName2 then
                                DisplayName3 = DisplayName2
                            else
                                DisplayName3 = Value3.Name
                            end

                            Text = tostring( DisplayName3 )
                        end
                    else
                        local DisplayName3
                        local DisplayName2 = Value3:GetAttribute( "DisplayName" )

                        if DisplayName2 then
                            DisplayName3 = DisplayName2
                        else
                            DisplayName3 = Value3.Name
                        end

                        Text = tostring( DisplayName3 )
                    end
                else
                    Text = "this player"
                end

                local Format = ( "Waiting for %s to accept" ):format( Text )

                if Format then
                    Text3Inner = Format
                else
                    Text3Inner = Text2
                end
            else
                Text3Inner = Text2
            end
        else
            Text3Inner = Value10
        end

        local Text4 = Text2Inner .. "|" .. Text3Inner

        if Text4 == Text3 then
            return
        end

        Text3 = Text4
        Duel.Texte.Text = Text2Inner

        if Normal and Normal2 then
            local Color = Ceil2 > 0 and ColorSequence2 or Normal2
            Normal.Color = Color
        end

        local Viseur = Duel:FindFirstChild( "Viseur" )

        if Viseur then
            local Visible2 = Ceil2 <= 0 and true or false
            Viseur.Visible = Visible2
        end

        local Number
        local Texte = Duel.Texte
        Number = not ( Ceil2 > 0 ) and 0.535 or 0.5
        Texte.Position = UDim2.fromScale( Number, 0.5 )
        DuelNote.Text = Text3Inner
    end

    Duel.Activated:Connect( function()
        local Remotes
        local Target2 = Target( )
        local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

        if RankedShared then
            Remotes = RankedShared:FindFirstChild( "Remotes" )
        else
            Remotes = RankedShared
        end

        local LobbyFn

        if Remotes then
            LobbyFn = Remotes:FindFirstChild( "LobbyFn" )
        else
            LobbyFn = Remotes
        end
        if Target2 and LobbyFn and not Flag4 then
            if Value9 ~= Target2 or not ( os.clock( ) < Number3 ) then
                Flag4 = true
                task.spawn( function()
                    local Success, Result = pcall( LobbyFn.InvokeServer, LobbyFn, "duel", Target2 )
                    Flag4 = false

                    if not Success or type( Result ) ~= "table" or not Result.ok then
                        local Msg = Success and type( Result ) == "table" and type( Result.msg ) == "string" and Result.msg or "Could not send the duel request"
                        Value10 = Msg
                        Number4 = os.clock( ) + 4
                    else
                        local Clock = os.clock( ) + 10
                        Value9 = Target2
                        Number3 = Clock
                        Value10 = nil
                        Number4 = 0
                    end

                    Text3 = ""
                end )
                return
            end
        end
    end )
    RunService.RenderStepped:Connect( function()
        if Parent2.Enabled then
            Paint( )
        end
    end )
end

local BindableEvent

local function Bindable( Name )
    local BindableEvent
    local FoundChild = Parent2:FindFirstChild( Name )

    if FoundChild then
        BindableEvent = FoundChild
    else
        BindableEvent = Instance.new( "BindableEvent" )
    end

    BindableEvent.Name = Name
    BindableEvent.Parent = Parent2
    return BindableEvent
end

local CardClosed = Parent2:FindFirstChild( "CardClosed" )

if CardClosed then
    BindableEvent = CardClosed
else
    BindableEvent = Instance.new( "BindableEvent" )
end

local BindableEvent2
BindableEvent.Name = "CardClosed"
BindableEvent.Parent = Parent2
local ShowCard = Parent2:FindFirstChild( "ShowCard" )

if ShowCard then
    BindableEvent2 = ShowCard
else
    BindableEvent2 = Instance.new( "BindableEvent" )
end

local BindableEvent3
BindableEvent2.Name = "ShowCard"
BindableEvent2.Parent = Parent2
BindableEvent2.Event:Connect( function( Argument1 )
    if typeof( Argument1 ) == "Instance" then
        Flag3 = false
        Close( )
        Value3 = Argument1
        Flag = false
        SetTab( "profile" )
        Fill( )
        table.insert( Table5, Argument1.AttributeChanged:Connect( Fill ) )
        Parent2.Enabled = true
        Flag3 = true
        return
    end
    return
end )
local HideCard = Parent2:FindFirstChild( "HideCard" )

if HideCard then
    BindableEvent3 = HideCard
else
    BindableEvent3 = Instance.new( "BindableEvent" )
end

BindableEvent3.Name = "HideCard"
BindableEvent3.Parent = Parent2
BindableEvent3.Event:Connect( function()
    if Flag3 then
        Close( )
    end
end )
local Value11 = nil
local Number5 = 0
UserInputService.TouchTapInWorld:Connect( function( Argument1, Argument2 )
    if Argument2 or TouchBlocked( ) then
        return
    end

    local ProfileAt2 = ProfileAt( Argument1.X, Argument1.Y )
    local Clock = os.clock( )

    if not ProfileAt2 or ProfileAt2 ~= Value11 or not ( Clock - Number5 <= 0.4 ) then
        Value11 = ProfileAt2
        Number5 = Clock
        return
    end
    Value11 = nil
    Close( )
    Value3 = ProfileAt2
    Flag = false
    SetTab( "profile" )
    Fill( )
    table.insert( Table5, ProfileAt2.AttributeChanged:Connect( Fill ) )
    Parent2.Enabled = true
    Flag2 = true
    ClientState.ActiveMenu = "Profile"
    ClientState.CursorFree = true
    return
end )
