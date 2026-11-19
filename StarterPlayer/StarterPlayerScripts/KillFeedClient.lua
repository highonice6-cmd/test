-- StarterPlayer.StarterPlayerScripts.KillFeedClient
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
local CrewShared = require( ReplicatedStorage:WaitForChild( "CrewShared" ) )
local KillFeed = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "KillFeed" )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local TweenInfo2 = TweenInfo.new( 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
local TweenInfo3 = TweenInfo.new( 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In )

local function Parts()
    local Frame
    local KillFeed = PlayerGui:FindFirstChild( "KillFeed" )

    if KillFeed then
        Frame = KillFeed:FindFirstChild( "Frame" )
    else
        Frame = KillFeed
    end

    local Frame1

    if Frame then
        Frame1 = Frame:FindFirstChild( "Frame1" )
    else
        Frame1 = Frame
    end
    if not Frame1 or not Frame1:FindFirstChild( "Text" ) or not Frame1:FindFirstChild( "Background" ) then
        return nil
    end
    Frame1.Visible = false
    return Frame, Frame1
end

task.defer( Parts )
task.spawn( function()
    local KillFeed = PlayerGui:WaitForChild( "KillFeed", 60 )

    if KillFeed and KillFeed:IsA( "ScreenGui" ) and not KillFeed.Enabled then
        KillFeed.Enabled = true
        Parts( )
    end
end )

local function Esc( Argument1 )
    return ( tostring( Argument1 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ):gsub( "\"", "&quot;" ) )
end

local function ColorFor( Object, Argument2 )
    local Text

    if not Argument2 or Argument2 ~= LocalPlayer.UserId then
        if Argument2 then
            local PlayerByUserId = Players:GetPlayerByUserId( Argument2 )
            local IdOf = CrewShared.IdOf( LocalPlayer )

            if not PlayerByUserId or not IdOf or CrewShared.IdOf( PlayerByUserId ) ~= IdOf then
                Text = "EnemyColor"
            else
                Text = "CrewColor"
            end
        else
            Text = "EnemyColor"
        end
    else
        Text = "SelfColor"
    end

    local Color32
    local Attribute = Object:GetAttribute( Text )

    if typeof( Attribute ) ~= "Color3" or not Attribute then
        Color32 = Color3.new( 1, 1, 1 )
    else
        Color32 = Attribute
    end

    return Color32
end

local ClanShared = require( ReplicatedStorage:WaitForChild( "ClanShared" ) )

local function NameText( Object, Argument2, Argument3 )
    local PlayerByUserId

    if Argument2 then
        PlayerByUserId = Players:GetPlayerByUserId( Argument2 )
    else
        PlayerByUserId = Argument2
    end

    local PrefixRich2

    if PlayerByUserId then
        local PrefixRich = ClanShared.PrefixRich( PlayerByUserId )

        if PrefixRich then
            PrefixRich2 = PrefixRich
        else
            PrefixRich2 = ""
        end
    else
        PrefixRich2 = ""
    end

    return ( "<b>%s<font color=\"#%s\">%s</font></b>" ):format( PrefixRich2, ColorFor( Object, Argument2 ):ToHex( ), ( tostring( Argument3 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ):gsub( "\"", "&quot;" ) ) )
end

local Table = { }
local Number = 0

local function FadersOf( Clone, Argument2, Argument3 )
    local Table = {
        { Argument2, "TextTransparency", Argument2.TextTransparency },
        {
            Argument3,
            "BackgroundTransparency",
            Argument3.BackgroundTransparency
        }
    }

    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "UIStroke" ) then
            table.insert( Table, { Value, "Transparency", Value.Transparency } )
        end
    end

    return Table
end

local function Fade( Argument1, Argument2, Argument3 )
    local Value1
    local Faders = Argument1.faders
    Value1 = nil

    for Key, Value in Faders, nil, nil do
        if Value[ 1 ].Parent then
            local Item3
            local Item = Value[ 1 ]
            local Table = { }
            local Item2 = Value[ 2 ]
            Item3 = Argument3 and Value[ 3 ] or 1
            Table[ Item2 ] = Item3
            TweenService:Create( Item, Argument2, Table ):Play( )
        end
    end
end

local function Remove( TableInner, Argument2 )
    if TableInner.gone then
        return
    end

    TableInner.gone = true
    local Find = table.find( Table, TableInner )

    if Find then
        table.remove( Table, Find )
    end

    local TweenInfo3Inner

    if Argument2 then
        local TweenInfo2 = TweenInfo.new( 0.12 )

        if TweenInfo2 then
            TweenInfo3Inner = TweenInfo2
        else
            TweenInfo3Inner = TweenInfo3
        end
    else
        TweenInfo3Inner = TweenInfo3
    end

    Fade( TableInner, TweenInfo3Inner, false )
    task.delay( TweenInfo3Inner.Time, function()
        TableInner.row:Destroy( )
    end )
end

KillFeed.OnClientEvent:Connect( function( Argument1 )
    if type( Argument1 ) ~= "table" or type( Argument1.kn ) ~= "string" or type( Argument1.vn ) ~= "string" then
        return
    end

    local Parent, Value1 = Parts( )

    if not Parent then
        return
    end

    local Value4
    local Text = Value1:FindFirstChild( "Text" )
    local Background = Value1:FindFirstChild( "Background" )
    local NameText2 = NameText( Value1, tonumber( Argument1.k ), Argument1.kn )
    local NameText3 = NameText( Value1, tonumber( Argument1.v ), Argument1.vn )
    local Text2 = ( Value1:GetAttribute( "Format" ) or "{killer} killed {victim}" ):gsub( "{killer}", function()
        return NameText2
    end ):gsub( "{victim}", function()
        return NameText3
    end )
    local Clone = Value1:Clone( )
    Clone.Name = "KillLine"
    local Text3 = Clone:FindFirstChild( "Text" )
    local Background2 = Clone:FindFirstChild( "Background" )
    Text3.RichText = true
    Text3.AutoLocalize = false
    Text3.Text = Text2
    Text3.TextScaled = false
    Text3.TextWrapped = false
    Text3.AutomaticSize = Enum.AutomaticSize.X
    Text3.Size = UDim2.new( 0, 0, Text3.Size.Y.Scale, Text3.Size.Y.Offset )
    local Scale = Text.Position.X.Scale - Background.Position.X.Scale

    local function Fit()
        local Y = Text3.AbsoluteSize.Y

        if Y > 0 then
            local TextSize = math.clamp( math.floor( Y + 0.5 ), 1, 100 )

            if Text3.TextSize ~= TextSize then
                Text3.TextSize = TextSize
            end
        end

        local X = Clone.AbsoluteSize.X

        if X > 0 then
            local X2 = Text3.AbsoluteSize.X / X + Scale * 2.5
            Background2.Size = UDim2.new( X2, 0, Background2.Size.Y.Scale, Background2.Size.Y.Offset )
        end
    end

    Text3:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Fit )
    Clone:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Fit )
    Number = Number - 1
    Clone.LayoutOrder = Number
    local TableInner = { row = Clone, faders = FadersOf( Clone, Text3, Background2 ) }
    local Faders = TableInner.faders
    Value4 = nil

    for Key, Value in Faders, nil, nil do
        local Item = Value[ 1 ]
        Item[ Value[ 2 ] ] = 1
    end

    Clone.Visible = true
    Clone.Parent = Parent
    Fit( )
    table.insert( Table, 1, TableInner )
    local NumberInner = tonumber( Value1:GetAttribute( "MaxLines" ) ) or 5

    while NumberInner < #Table do
        Remove( Table[ #Table ], true )
    end

    Fade( TableInner, TweenInfo2, true )
    task.delay( tonumber( Value1:GetAttribute( "Hold" ) ) or 6, function()
        Remove( TableInner )
    end )
end )
