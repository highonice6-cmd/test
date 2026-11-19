-- Players.perkbrokeyou.PlayerScripts.UpdateLogClient
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
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local UserInputService = game:GetService( "UserInputService" )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local UpdateLog = require( ReplicatedStorage:WaitForChild( "UpdateLog" ) )
local HudNotifSeen = ReplicatedStorage:WaitForChild( "HudNotifSeen" )
local LocalPlayer = Players.LocalPlayer

local function SwitchOn()
    local Flag = ReplicatedStorage:GetAttribute( "UpdateLogOn" ) == true and true or false
    return Flag
end

local Table = {
    LIMITED = Color3.fromRGB( 160, 80, 230 ),
    [ "NEW WEAPON" ] = Color3.fromRGB( 225, 160, 40 ),
    NEW = Color3.fromRGB( 225, 50, 55 ),
    [ "NEW CAR" ] = Color3.fromRGB( 225, 160, 40 ),
    [ "NOW IN CASES" ] = Color3.fromRGB( 225, 160, 40 ),
    [ "NEW RARITY" ] = Color3.fromRGB( 20, 20, 22 )
}
local Table2 = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
}
local Table3 = { { Enum.KeyCode.Thumbstick2, "Scroll" } }
local Table4 = { }
Value1 = nil

for Key, Value in UpdateLog, nil, nil do
    if type( Value ) == "table" and type( Value.Date ) == "string" and Value.Date:match( "^%d%d%d%d%-%d%d%-%d%d$" ) then
        table.insert( Table4, Value )
    end
end

table.sort( Table4, function( Argument1, Argument2 )
    local Flag
    local Date = Argument1.Date
    Flag = Argument2.Date < Date and true or false
    return Flag
end )
local Item = Table4[ 1 ]

local function DateText( Argument1 )
    local Match, Match2, Match3 = Argument1:match( "^(%d+)%-(%d+)%-(%d+)$" )
    local Entry = Table2[ tonumber( Match2 ) ] or "?"
    return Entry .. " " .. tonumber( Match3 ) .. ", " .. Match
end

local function KeyOf( Argument1 )
    return "Update_" .. Argument1.Date
end

local function LastSeenKey()
    local Value1 = nil

    for Value in string.gmatch( LocalPlayer:GetAttribute( "SeenNotifs" ) or "", "[^,]+" ) do
        if Value:sub( 1, 7 ) == "Update_" then
            if Value1 == nil or Value1 < Value then
                Value1 = Value
            end
        end
    end

    return Value1
end

local function IsSeen( Argument1 )
    local Flag
    local LastSeenKey2 = LastSeenKey( )

    if LastSeenKey2 == nil then
        Flag = false
    elseif "Update_" .. Argument1.Date <= LastSeenKey2 then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function MarkSeen( Item )
    if Item then
        local Flag
        local LastSeenKey2 = LastSeenKey( )

        if LastSeenKey2 == nil then
            Flag = false
        elseif "Update_" .. Item.Date <= LastSeenKey2 then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            HudNotifSeen:FireServer( "Update_" .. Item.Date )
            task.delay( 2, function()
                local Flag
                local LastSeenKey2 = LastSeenKey( )

                if LastSeenKey2 == nil then
                    Flag = false
                elseif "Update_" .. Item.Date <= LastSeenKey2 then
                    Flag = true
                else
                    Flag = false
                end
                if not Flag then
                    HudNotifSeen:FireServer( "Update_" .. Item.Date )
                end
            end )
            return
        end
    end
end

local Get = Screens.Get( "UpdateLog" )
local Menu = Get:WaitForChild( "Menu" )
local Window = Menu:WaitForChild( "Window" )
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
local Close = Window:WaitForChild( "Close" )
local Detail = Window:WaitForChild( "Detail" )
local History = Window:WaitForChild( "History" )
local Templates = Window:WaitForChild( "Templates" )
local Date = Detail:WaitForChild( "Date" )
local Headline = Detail:WaitForChild( "Headline" )
local Body = Detail:WaitForChild( "Body" )
local History2 = Detail:WaitForChild( "Buttons" ):WaitForChild( "History" )
local Ok = Detail.Buttons:WaitForChild( "Ok" )
local List = History:WaitForChild( "List" )
local Back = History:WaitForChild( "Buttons" ):WaitForChild( "Back" )
local RefHeight = Templates:GetAttribute( "RefHeight" ) or 776
Menu.Visible = false
Screens.SetShown( Get, true )

local function Px( Argument1, Argument2 )
    return ( math.floor( Argument1 * Argument2 + 0.5 ) )
end

local function SU( Argument1, Argument2 )
    return UDim.new( Argument1.Scale, ( math.floor( Argument1.Offset * Argument2 + 0.5 ) ) )
end

local function SU2( Argument1, Argument2 )
    return UDim2.new( Argument1.X.Scale, math.floor( Argument1.X.Offset * Argument2 + 0.5 ), Argument1.Y.Scale, ( math.floor( Argument1.Y.Offset * Argument2 + 0.5 ) ) )
end

local function RescaleOne( Self, Argument2 )
    if Self:IsA( "GuiObject" ) then
        local Position = Self.Position
        Self.Position = UDim2.new( Position.X.Scale, math.floor( Position.X.Offset * Argument2 + 0.5 ), Position.Y.Scale, ( math.floor( Position.Y.Offset * Argument2 + 0.5 ) ) )
        local Size = Self.Size
        Self.Size = UDim2.new( Size.X.Scale, math.floor( Size.X.Offset * Argument2 + 0.5 ), Size.Y.Scale, ( math.floor( Size.Y.Offset * Argument2 + 0.5 ) ) )

        if Self:IsA( "TextLabel" ) or Self:IsA( "TextButton" ) then
            if not Self.TextScaled then
                Self.TextSize = math.max( 12, ( math.floor( Self.TextSize * Argument2 + 0.5 ) ) )
                return
            end
        end
    else
        if Self:IsA( "UIPadding" ) then
            local PaddingTop = Self.PaddingTop
            local PaddingTop2 = UDim.new( PaddingTop.Scale, ( math.floor( PaddingTop.Offset * Argument2 + 0.5 ) ) )
            local PaddingBottom = Self.PaddingBottom
            local PaddingBottom2 = UDim.new( PaddingBottom.Scale, ( math.floor( PaddingBottom.Offset * Argument2 + 0.5 ) ) )
            Self.PaddingTop = PaddingTop2
            Self.PaddingBottom = PaddingBottom2
            local PaddingLeft = Self.PaddingLeft
            local PaddingLeft2 = UDim.new( PaddingLeft.Scale, ( math.floor( PaddingLeft.Offset * Argument2 + 0.5 ) ) )
            local PaddingRight = Self.PaddingRight
            local PaddingRight2 = UDim.new( PaddingRight.Scale, ( math.floor( PaddingRight.Offset * Argument2 + 0.5 ) ) )
            Self.PaddingLeft = PaddingLeft2
            Self.PaddingRight = PaddingRight2
            return
        end
        if Self:IsA( "UIListLayout" ) then
            local Padding = Self.Padding
            Self.Padding = UDim.new( Padding.Scale, ( math.floor( Padding.Offset * Argument2 + 0.5 ) ) )
            return
        end
        if Self:IsA( "UICorner" ) then
            local CornerRadius = Self.CornerRadius
            Self.CornerRadius = UDim.new( CornerRadius.Scale, ( math.floor( CornerRadius.Offset * Argument2 + 0.5 ) ) )
            return
        end
        if Self:IsA( "UIStroke" ) and Self.StrokeSizingMode == Enum.StrokeSizingMode.FixedSize then
            Self.Thickness = Self.Thickness * Argument2
        end
    end
end

local function Rescale( Self, Argument2 )
    RescaleOne( Self, Argument2 )

    for Key, Value in Self:GetDescendants( ) do
        RescaleOne( Value, Argument2 )
    end
end

local function Snapshot( Self )
    local T
    local UIPadding = Self:FindFirstChildOfClass( "UIPadding" )
    local UIListLayout = Self:FindFirstChildOfClass( "UIListLayout" )
    local Table = { pad = UIPadding, lay = UIListLayout, bar = Self.ScrollBarThickness }
    T = if UIPadding then UIPadding.PaddingTop else UIPadding
    local B
    Table.t = T
    B = if UIPadding then UIPadding.PaddingBottom else UIPadding
    local L
    Table.b = B
    L = if UIPadding then UIPadding.PaddingLeft else UIPadding
    local R
    Table.l = L
    R = if UIPadding then UIPadding.PaddingRight else UIPadding
    local Gap
    Table.r = R
    Gap = if UIListLayout then UIListLayout.Padding else UIListLayout
    Table.gap = Gap
    return Table
end

local function ApplySnap( Argument1, Argument2, Argument3 )
    if Argument2.pad then
        local Pad = Argument2.pad
        local Pad2 = Argument2.pad
        local T = Argument2.t
        local PaddingTop = UDim.new( T.Scale, ( math.floor( T.Offset * Argument3 + 0.5 ) ) )
        local B = Argument2.b
        local PaddingBottom = UDim.new( B.Scale, ( math.floor( B.Offset * Argument3 + 0.5 ) ) )
        Pad.PaddingTop = PaddingTop
        Pad2.PaddingBottom = PaddingBottom
        local Pad3 = Argument2.pad
        local Pad4 = Argument2.pad
        local L = Argument2.l
        local PaddingLeft = UDim.new( L.Scale, ( math.floor( L.Offset * Argument3 + 0.5 ) ) )
        local R = Argument2.r
        local PaddingRight = UDim.new( R.Scale, ( math.floor( R.Offset * Argument3 + 0.5 ) ) )
        Pad3.PaddingLeft = PaddingLeft
        Pad4.PaddingRight = PaddingRight
    end
    if Argument2.lay then
        local Lay = Argument2.lay
        local Gap = Argument2.gap
        Lay.Padding = UDim.new( Gap.Scale, ( math.floor( Gap.Offset * Argument3 + 0.5 ) ) )
    end

    Argument1.ScrollBarThickness = math.max( 3, ( math.floor( Argument2.bar * Argument3 + 0.5 ) ) )
end

local Snapshot2 = Snapshot( Body )
local Snapshot3 = Snapshot( List )

local function FitCanvas( Object )
    local UIListLayout = Object:FindFirstChildOfClass( "UIListLayout" )
    local UIPadding = Object:FindFirstChildOfClass( "UIPadding" )

    if not UIListLayout then
        return
    end

    local Y2
    Object.AutomaticCanvasSize = Enum.AutomaticSize.None

    local function Update()
        local Y2
        local Y = UIListLayout.AbsoluteContentSize.Y
        Y2 = if UIPadding then Y + ( UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset + ( UIPadding.PaddingTop.Scale + UIPadding.PaddingBottom.Scale ) * Object.AbsoluteSize.Y ) else Y
        Object.CanvasSize = UDim2.fromOffset( 0, ( math.ceil( Y2 ) ) )
    end

    UIListLayout:GetPropertyChangedSignal( "AbsoluteContentSize" ):Connect( Update )
    Object:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Update )
    local Y = UIListLayout.AbsoluteContentSize.Y
    Y2 = if UIPadding then Y + ( UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset + ( UIPadding.PaddingTop.Scale + UIPadding.PaddingBottom.Scale ) * Object.AbsoluteSize.Y ) else Y
    Object.CanvasSize = UDim2.fromOffset( 0, ( math.ceil( Y2 ) ) )
end

FitCanvas( Body )
FitCanvas( List )
local Size = Window.Size
local FromScale = UDim2.fromScale( 0.94, 0.9 )
local CurrentCamera = workspace.CurrentCamera

local function Fit()
    local Vector22

    if CurrentCamera then
        local ViewportSize = CurrentCamera.ViewportSize

        if ViewportSize then
            Vector22 = ViewportSize
        else
            Vector22 = Vector2.new( 1920, 1080 )
        end
    else
        Vector22 = Vector2.new( 1920, 1080 )
    end

    local SizeInner = Vector22.Y < 600 and FromScale or Size
    Window.Size = SizeInner
end

local Connect = nil

local function WatchCamera()
    if Connect then
        Connect:Disconnect( )
    end

    CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        Connect = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
    end

    local Vector22

    if CurrentCamera then
        local ViewportSize = CurrentCamera.ViewportSize

        if ViewportSize then
            Vector22 = ViewportSize
        else
            Vector22 = Vector2.new( 1920, 1080 )
        end
    else
        Vector22 = Vector2.new( 1920, 1080 )
    end

    local SizeInner = Vector22.Y < 600 and FromScale or Size
    Window.Size = SizeInner
end

workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( WatchCamera )

if Connect then
    Connect:Disconnect( )
end

CurrentCamera = workspace.CurrentCamera

if CurrentCamera then
    Connect = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
end

local Vector22

if not CurrentCamera or not CurrentCamera.ViewportSize then
    Vector22 = Vector2.new( 1920, 1080 )
else
    Vector22 = CurrentCamera.ViewportSize
end

local Size2 = Vector22.Y < 600 and FromScale or Size
Window.Size = Size2

local function CurrentK()
    local Scale2

    if UIScale then
        local Scale = UIScale.Scale

        if Scale then
            Scale2 = Scale
        else
            Scale2 = 1
        end
    else
        Scale2 = 1
    end
    if Scale2 <= 0 then
        Scale2 = 1
    end

    local Y2
    local Y = Window.AbsoluteSize.Y / Scale2

    if Y < 10 then
        local Vector22

        if CurrentCamera then
            local ViewportSize = CurrentCamera.ViewportSize

            if ViewportSize then
                Vector22 = ViewportSize
            else
                Vector22 = Vector2.new( 1920, 1080 )
            end
        else
            Vector22 = Vector2.new( 1920, 1080 )
        end

        Y2 = Vector22.Y * Window.Size.Y.Scale
    else
        Y2 = Y
    end

    return Y2 / RefHeight
end

local function Clear( Object )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "GuiObject" ) then
            Value:Destroy( )
        end
    end
end

local function LineOf( Argument1 )
    local Clone = Templates.Line:Clone( )
    local Text = Clone.Text
    Text.Text = tostring( Argument1 )
    return Clone
end

local function FeatureCard( Argument1 )
    local Visible
    local Clone = Templates.Feature:Clone( )
    local Media = Clone:FindFirstChild( "Media" )
    local Content = Clone:FindFirstChild( "Content" )

    if type( Argument1.Image ) == "string" then
        if Argument1.Image == "" then
            Visible = false
        else
            Visible = true
        end
    else
        Visible = false
    end
    if Media then
        Media.Visible = Visible
        local Image = Media:FindFirstChild( "Image" )

        if Image and Visible then
            Image.Image = Argument1.Image
        end
    end
    if not Content then
        return Clone
    end
    if not Visible then
        Content.Position = UDim2.new( 0, 0, Content.Position.Y.Scale, Content.Position.Y.Offset )
        Content.Size = UDim2.new( 1, 0, Content.Size.Y.Scale, Content.Size.Y.Offset )
    end

    local Title
    local Header = Content:FindFirstChild( "Header" )

    if Header then
        Title = Header:FindFirstChild( "Title" )
    else
        Title = Header
    end

    local Tag

    if Header then
        Tag = Header:FindFirstChild( "Tag" )
    else
        Tag = Header
    end
    if Title then
        Title.Text = tostring( Argument1.Title or "" )
    end
    if Tag then
        local Visible2

        if type( Argument1.Tag ) == "string" then
            if Argument1.Tag == "" then
                Visible2 = false
            else
                Visible2 = true
            end
        else
            Visible2 = false
        end

        Tag.Visible = Visible2
        local Text = Tag:FindFirstChild( "Text" )

        if Visible2 and Text then
            Text.Text = string.upper( Argument1.Tag )
        end

        local BackgroundColor3 = if Visible2 then Table[ string.upper( Argument1.Tag ) ] else Visible2

        if BackgroundColor3 then
            Tag.BackgroundColor3 = BackgroundColor3
            Tag.BackgroundTransparency = 0.15
            local UIStroke = Tag:FindFirstChildWhichIsA( "UIStroke" )

            if UIStroke then
                UIStroke.Color = BackgroundColor3
                UIStroke.Transparency = 0.3
            end
            if Text then
                Text.TextColor3 = Color3.new( 1, 1, 1 )
            end
        end
    end

    local Text2 = Content:FindFirstChild( "Text" )

    if Text2 then
        local Visible3
        Text2.Text = tostring( Argument1.Text or "" )
        Visible3 = Text2.Text ~= "" and true or false
        Text2.Visible = Visible3
    end

    local Parent = Content:FindFirstChild( "Points" )

    if Parent then
        local Points = type( Argument1.Points ) == "table" and Argument1.Points or { }
        local Value1, Number
        Value1 = nil
        Number = 0

        for Key, Value in Points, nil, nil do
            local LayoutOrder = Number + 1
            local Clone2 = Templates.Line:Clone( )
            local Text3 = Clone2.Text
            Text3.Text = tostring( Value )
            Clone2.LayoutOrder = LayoutOrder
            Clone2.Parent = Parent
            Number = LayoutOrder
        end

        local Visible4 = Number > 0 and true or false
        Parent.Visible = Visible4
    end

    return Clone
end

local function ChangesCard( List, Flag )
    local Parent = Templates.Changes:Clone( )
    local LayoutOrder = 0

    local function Put( Argument1 )
        LayoutOrder = LayoutOrder + 1
        Argument1.LayoutOrder = LayoutOrder
        Argument1.Parent = Parent
    end

    local Title = Parent:FindFirstChild( "Title", true )

    if Flag and Title and Title:IsA( "TextLabel" ) then
        local Text
        local AloneTitle = Parent:GetAttribute( "AloneTitle" )
        Text = if AloneTitle then AloneTitle else Title.Text
        Title.Text = Text
    end

    local Value1, Number
    Value1 = nil
    Number = LayoutOrder

    for Key, Value in List, nil, nil do
        local Item = Value[ 1 ]
        local Item2 = Value[ 2 ]

        if type( Item ) == "string" and Item ~= "" then
            local Section
            local FoundChild = Templates:FindFirstChild( "Section_" .. Item )

            if FoundChild then
                Section = FoundChild
            else
                Section = Templates:FindFirstChild( "Section" )
            end
            if Section then
                local Clone = Section:Clone( )

                if Section.Name == "Section" and Clone:FindFirstChild( "Text", true ) and Clone:FindFirstChild( "Text", true ):IsA( "TextLabel" ) then
                    Clone:FindFirstChild( "Text", true ).Text = string.upper( Item )
                end

                LayoutOrder = Number + 1
                Clone.LayoutOrder = LayoutOrder
                Clone.Parent = Parent
                Number = LayoutOrder
            end
        end

        local Item3 = type( Item2 ) == "table" and Item2 or { }
        local Value2 = nil

        for Key2, Value3 in Item3, nil, nil do
            local Clone2 = Templates.Line:Clone( )
            local Text2 = Clone2.Text
            Text2.Text = tostring( Value3 )
            LayoutOrder = Number + 1
            Clone2.LayoutOrder = LayoutOrder
            Clone2.Parent = Parent
            Number = LayoutOrder
        end
    end

    return Parent, Number
end

local function BuildBody( Argument1, Argument2 )
    local Features
    Clear( Body )
    local LayoutOrder = 0

    local function Add( Self )
        LayoutOrder = LayoutOrder + 1
        Self.LayoutOrder = LayoutOrder
        RescaleOne( Self, Argument2 )

        for Key, Value in Self:GetDescendants( ) do
            RescaleOne( Value, Argument2 )
        end

        Self.Parent = Body
    end

    Features = type( Argument1.Features ) == "table" and Argument1.Features or { }
    local Value1, Number
    Value1 = nil
    Number = LayoutOrder

    for Key, Value in Features, nil, nil do
        if type( Value ) == "table" then
            local FeatureCard2 = FeatureCard( Value )
            LayoutOrder = Number + 1
            FeatureCard2.LayoutOrder = LayoutOrder
            RescaleOne( FeatureCard2, Argument2 )

            for Key3, Value6 in FeatureCard2:GetDescendants( ) do
                RescaleOne( Value6, Argument2 )
            end

            FeatureCard2.Parent = Body
            Number = LayoutOrder
        end
    end

    local Changes

    if type( Argument1.Changes ) ~= "table" or not Argument1.Changes then
        if type( Argument1.Sections ) ~= "table" or not Argument1.Sections then
            Changes = nil
        else
            Changes = Argument1.Sections
        end
    else
        Changes = Argument1.Changes
    end
    if Changes then
        local Flag = Number == 0 and true or false
        local Value2, Value3 = ChangesCard( Changes, Flag )

        if Value3 > 0 then
            Value2.LayoutOrder = Number + 1
            RescaleOne( Value2, Argument2 )

            for Key2, Value4 in Value2:GetDescendants( ) do
                RescaleOne( Value4, Argument2 )
            end

            Value2.Parent = Body
        else
            Value2:Destroy( )
        end
    end
end

local function BuildList( Argument1 )
    local Value1, Clone
    Clear( List )
    Value1 = nil
    Clone = nil

    for Key, Value in Table4, nil, nil do
        local Clone2 = Templates.Row:Clone( )
        Clone2.LayoutOrder = Key
        Clone2.Selectable = true
        local Date = Clone2:FindFirstChild( "Date" )
        local Title = Clone2:FindFirstChild( "Title" )
        local Latest = Clone2:FindFirstChild( "Latest" )

        if Date then
            local Match, Match2, Match3 = Value.Date:match( "^(%d+)%-(%d+)%-(%d+)$" )
            local Entry = Table2[ tonumber( Match2 ) ] or "?"
            Date.Text = string.upper( Entry .. " " .. tonumber( Match3 ) .. ", " .. Match )
        end
        if Title then
            Title.Text = Value.Title or ""
        end
        if Latest then
            local Visible = Key == 1 and true or false
            Latest.Visible = Visible
        end

        RescaleOne( Clone2, Argument1 )

        for Key2, Value2 in Clone2:GetDescendants( ) do
            RescaleOne( Value2, Argument1 )
        end

        Clone2.Parent = List
        Clone2.Activated:Connect( function()
            ClientState.UpdateLogShow( Value )
        end )
        Clone = Clone or Clone2
    end

    return Clone
end

local Flag = false
local Text = "detail"
local Value2 = nil
local Value3 = nil
local Value4 = nil
local Callback = nil
local Callback2 = nil

local function Back2()
    if Text == "history" then
        Callback2( Item )
        return
    end
    Callback( false )
    return
end

local function NavOpen()
    if not Flag then
        return
    end
    if Text ~= "history" then
        GamepadNav.Open( "UpdateLog", {
            root = Window,
            first = Ok,
            backLabel = "Close",
            onBack = Back2,
            hints = Table3
        } )
        return
    end

    local Open = GamepadNav.Open
    local Table = { root = Window, backLabel = "Back" }
    Table.first = Value3 or Back
    Table.onBack = Back2
    Table.hints = Table3
    Open( "UpdateLog", Table )
end

Callback2 = function( ItemInner )
    if not ItemInner then
        return
    end

    local Scale2
    Text = "detail"
    Item = ItemInner

    if UIScale then
        local Scale = UIScale.Scale

        if Scale then
            Scale2 = Scale
        else
            Scale2 = 1
        end
    else
        Scale2 = 1
    end
    if Scale2 <= 0 then
        Scale2 = 1
    end

    local Y2
    local Y = Window.AbsoluteSize.Y / Scale2

    if Y < 10 then
        local Vector22

        if CurrentCamera then
            local ViewportSize = CurrentCamera.ViewportSize

            if ViewportSize then
                Vector22 = ViewportSize
            else
                Vector22 = Vector2.new( 1920, 1080 )
            end
        else
            Vector22 = Vector2.new( 1920, 1080 )
        end

        Y2 = Vector22.Y * Window.Size.Y.Scale
    else
        Y2 = Y
    end

    local Y3 = Y2 / RefHeight
    Value2 = Y3
    local Match, Match2, Match3 = ItemInner.Date:match( "^(%d+)%-(%d+)%-(%d+)$" )
    local Entry = Table2[ tonumber( Match2 ) ] or "?"
    Date.Text = string.upper( Entry .. " " .. tonumber( Match3 ) .. ", " .. Match )
    Headline.Text = ItemInner.Title or ""
    ApplySnap( Body, Snapshot2, Y3 )
    BuildBody( ItemInner, Y3 )
    Body.CanvasPosition = Vector2.zero
    Detail.Visible = true
    History.Visible = false
    NavOpen( )
end

function ClientState.UpdateLogShow( Argument1 )
    Callback2( Argument1 )
end

local function Callback3()
    local Scale2
    Text = "history"

    if UIScale then
        local Scale = UIScale.Scale

        if Scale then
            Scale2 = Scale
        else
            Scale2 = 1
        end
    else
        Scale2 = 1
    end
    if Scale2 <= 0 then
        Scale2 = 1
    end

    local Y2
    local Y = Window.AbsoluteSize.Y / Scale2

    if Y < 10 then
        local Vector22

        if CurrentCamera then
            local ViewportSize = CurrentCamera.ViewportSize

            if ViewportSize then
                Vector22 = ViewportSize
            else
                Vector22 = Vector2.new( 1920, 1080 )
            end
        else
            Vector22 = Vector2.new( 1920, 1080 )
        end

        Y2 = Vector22.Y * Window.Size.Y.Scale
    else
        Y2 = Y
    end

    local Y3 = Y2 / RefHeight
    Value2 = Y3
    ApplySnap( List, Snapshot3, Y3 )
    Value3 = BuildList( Y3 )
    List.CanvasPosition = Vector2.zero
    Detail.Visible = false
    History.Visible = true
    NavOpen( )
end

local function Blocked()
    local Flag

    if ClientState.WardrobeOpen == true then
        Flag = true
    elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    elseif ClientState.BetaReveal == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function SettingsOpen()
    local IconInner
    local GetIcon = Icon.getIcon

    if GetIcon then
        IconInner = Icon.getIcon( "Settings" )
    else
        IconInner = GetIcon
    end

    local Flag = if IconInner == nil then false else IconInner.isSelected
    return Flag
end

Callback = function( Argument1, ItemInner )
    if Argument1 then
        local FlagInner

        if ClientState.WardrobeOpen == true then
            FlagInner = true
        elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            FlagInner = true
        elseif ClientState.BetaReveal == true then
            FlagInner = true
        else
            FlagInner = false
        end
        if FlagInner then
            return
        end

        local Flag2 = ReplicatedStorage:GetAttribute( "UpdateLogOn" ) == true and true or false

        if not Flag2 then
            return
        end
    end
    if Argument1 == Flag then
        if Argument1 and ItemInner then
            Callback2( ItemInner )
        end

        return
    end
    Flag = Argument1

    if Argument1 then
        Callback2( ItemInner or Item )
        Menu.Visible = true

        if Value4 then
            Value4:Cancel( )
        end
        if UIScale then
            UIScale.Scale = 0.92
            Value4 = TweenService:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
            Value4:Play( )
        end

        local IconInner
        ClientState.ActiveMenu = "UpdateLog"
        ClientState.CursorFree = true
        local GetIcon = Icon.getIcon

        if GetIcon then
            IconInner = Icon.getIcon( "Settings" )
        else
            IconInner = GetIcon
        end

        local Flag3 = if IconInner == nil then false else IconInner.isSelected

        if Flag3 then
            Icon.getIcon( "Settings" ):deselect( )
        end

        MarkSeen( Item )
        return
    end
    if Value4 then
        Value4:Cancel( )
        Value4 = nil
    end
    if UIScale then
        UIScale.Scale = 1
    end

    Menu.Visible = false
    ClientState.CursorFree = false
    GamepadNav.Close( "UpdateLog" )
    return
end

function ClientState.OpenUpdateLog()
    Callback( true, Item )
    return Flag
end
Close.Activated:Connect( function()
    Callback( false )
end )
Ok.Activated:Connect( function()
    Callback( false )
end )
History2.Activated:Connect( function()
    Callback3( )
end )
Back.Activated:Connect( function()
    Callback2( Item )
end )
Window:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
    if not Flag or not Value2 then
        return
    end
    if Value4 and Value4.PlaybackState == Enum.PlaybackState.Playing then
        return
    end

    local Scale2

    if UIScale then
        local Scale = UIScale.Scale

        if Scale then
            Scale2 = Scale
        else
            Scale2 = 1
        end
    else
        Scale2 = 1
    end
    if Scale2 <= 0 then
        Scale2 = 1
    end

    local Y2
    local Y = Window.AbsoluteSize.Y / Scale2

    if Y < 10 then
        local Vector22

        if CurrentCamera then
            local ViewportSize = CurrentCamera.ViewportSize

            if ViewportSize then
                Vector22 = ViewportSize
            else
                Vector22 = Vector2.new( 1920, 1080 )
            end
        else
            Vector22 = Vector2.new( 1920, 1080 )
        end

        Y2 = Vector22.Y * Window.Size.Y.Scale
    else
        Y2 = Y
    end
    if math.abs( Y2 / RefHeight - Value2 ) / Value2 > 0.03 then
        if Text == "history" then
            Callback3( )
            return
        end

        Callback2( Item )
    end
end )
RunService.Heartbeat:Connect( function( Argument1 )
    if not Flag then
        return
    end

    local FlagInner

    if ClientState.WardrobeOpen == true then
        FlagInner = true
    elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        FlagInner = true
    elseif ClientState.BetaReveal == true then
        FlagInner = true
    else
        FlagInner = false
    end
    if not FlagInner and ClientState.ActiveMenu == "UpdateLog" then
        local IconInner
        local GetIcon = Icon.getIcon

        if GetIcon then
            IconInner = Icon.getIcon( "Settings" )
        else
            IconInner = GetIcon
        end

        local Flag2 = if IconInner == nil then false else IconInner.isSelected

        if not Flag2 then
            local Flag3 = ReplicatedStorage:GetAttribute( "UpdateLogOn" ) == true and true or false

            if Flag3 then
                if not ClientState.CursorFree then
                    ClientState.CursorFree = true
                end
                if UserInputService.GamepadEnabled then
                    local Success, Result = pcall( UserInputService.GetGamepadState, UserInputService, Enum.UserInputType.Gamepad1 )

                    if Success then
                        local Value1 = nil

                        for Key, Value in Result, nil, nil do
                            if Value.KeyCode == Enum.KeyCode.Thumbstick2 and math.abs( Value.Position.Y ) > 0.2 then
                                local Captured = Text == "history" and List or Body
                                local Max = math.max( 0, Captured.AbsoluteCanvasSize.Y - Captured.AbsoluteWindowSize.Y )
                                Captured.CanvasPosition = Vector2.new( 0, ( math.clamp( Captured.CanvasPosition.Y - Value.Position.Y * 1100 * ( Value2 or 1 ) * Argument1, 0, Max ) ) )
                            end
                        end
                    end
                end

                return
            end
        end
    end

    Callback( false )
end )
task.spawn( function()
    local Get = Screens.Get( "CrewHUD" )
    local UpdatesButton = Get:FindFirstChild( "UpdatesButton", true )

    while not UpdatesButton do
        Get.DescendantAdded:Wait( )
        UpdatesButton = Get:FindFirstChild( "UpdatesButton", true )
    end

    local Visible

    local function ShowBtn()
        local Visible

        if Item == nil then
            Visible = false
        elseif ReplicatedStorage:GetAttribute( "UpdateLogOn" ) == true then
            Visible = true
        else
            Visible = false
        end

        UpdatesButton.Visible = Visible
    end

    if Item == nil then
        Visible = false
    elseif ReplicatedStorage:GetAttribute( "UpdateLogOn" ) == true then
        Visible = true
    else
        Visible = false
    end

    UpdatesButton.Visible = Visible
    ReplicatedStorage:GetAttributeChangedSignal( "UpdateLogOn" ):Connect( ShowBtn )
    UpdatesButton.Activated:Connect( function()
        if Flag then
            Callback( false )
            return
        end
        Callback( true, Item )
        return
    end )
end )

local function Free()
    if LocalPlayer:GetAttribute( "InTutorial" ) or LocalPlayer:GetAttribute( "Onboarding" ) ~= false or LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        return false
    end
    if ClientState.WardrobeOpen or ClientState.CaseRolling or ClientState.BetaReveal or ClientState.IntroCinematic then
        return false
    end
    if not ClientState.CursorFree then
        local IconInner
        local GetIcon = Icon.getIcon

        if GetIcon then
            IconInner = Icon.getIcon( "Settings" )
        else
            IconInner = GetIcon
        end

        local Flag = if IconInner == nil then false else IconInner.isSelected

        if not Flag then
            if LocalPlayer:GetAttribute( "StarterOffer" ) then
                return false
            end

            local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

            if type( CombatUntil ) == "number" and workspace:GetServerTimeNow( ) < CombatUntil then
                return false
            end

            local Humanoid
            local Character = LocalPlayer.Character

            if Character then
                Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if not Humanoid or Humanoid.Health <= 0 or Character:GetAttribute( "Downed" ) then
                return false
            end
            return true
        end
    end

    return false
end

task.spawn( function()
    if not Item then
        return
    end
    while true do
        local FlagInner = ReplicatedStorage:GetAttribute( "UpdateLogOn" ) == true and true or false

        if FlagInner then
            break
        end

        ReplicatedStorage:GetAttributeChangedSignal( "UpdateLogOn" ):Wait( )
    end
    while true do
        if not LocalPlayer:GetAttribute( "DataLoaded" ) or LocalPlayer:GetAttribute( "SeenNotifs" ) == nil then
            task.wait( 0.5 )
            continue
        end
        break
    end

    local Flag2
    local LastSeenKey2 = LastSeenKey( )

    if LastSeenKey2 == nil then
        Flag2 = false
    elseif "Update_" .. Item.Date <= LastSeenKey2 then
        Flag2 = true
    else
        Flag2 = false
    end
    if Flag2 then
        return
    end
    if LocalPlayer:GetAttribute( "Returning" ) ~= true then
        MarkSeen( Item )
        return
    end

    local Clock = nil

    while not Flag do
        local Flag3
        local LastSeenKey3 = LastSeenKey( )

        if LastSeenKey3 == nil then
            Flag3 = false
        elseif "Update_" .. Item.Date <= LastSeenKey3 then
            Flag3 = true
        else
            Flag3 = false
        end
        if Flag3 then
            break
        end
        if Free( ) then
            local Flag4 = ReplicatedStorage:GetAttribute( "UpdateLogOn" ) == true and true or false

            if Flag4 then
                local Clock2

                if Clock then
                    Clock2 = Clock
                else
                    Clock2 = os.clock( )
                end
                if os.clock( ) - Clock2 >= 2.5 then
                    Callback( true, Item )

                    if Flag then
                        break
                    end

                    Clock = nil
                else
                    Clock = Clock2
                end
            else
                Clock = nil
            end
        else
            Clock = nil
        end

        task.wait( 0.25 )
    end
end )
