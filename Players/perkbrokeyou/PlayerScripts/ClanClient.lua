-- Players.perkbrokeyou.PlayerScripts.ClanClient
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
local Parent = game:GetService( "SoundService" )
local MarketplaceService = game:GetService( "MarketplaceService" )
local TextChatService = game:GetService( "TextChatService" )
local HttpService = game:GetService( "HttpService" )
local ClanShared = require( ReplicatedStorage:WaitForChild( "ClanShared" ) )

if not ClanShared.Enabled( ) then
    return
end

local RankedShared2
local CrewShared = require( ReplicatedStorage:WaitForChild( "CrewShared" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local BadgeCatalog = require( ReplicatedStorage:WaitForChild( "BadgeCatalog" ) )
local Levels = require( ReplicatedStorage:WaitForChild( "Levels" ) )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local RobuxShopUI = require( ReplicatedStorage:WaitForChild( "RobuxShopUI" ) )
local GamePasses = require( ReplicatedStorage:WaitForChild( "GamePasses" ) )
local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )
RankedShared2 = if RankedShared then RankedShared:FindFirstChild( "Badges" ) else RankedShared
local Result2
local Success, Result = pcall( require, RankedShared2 )
Result2 = Success and type( Result ) == "table" and Result or nil
local RankedShared4

local function RankImage( ImageName, Text )
    if not Result2 or type( ImageName ) ~= "string" or ImageName == "" or ImageName == "Unranked" then
        return nil
    end
    local Image = Result2.Image
    return Image( ImageName, ( tonumber( Text ) ) )
end

local function BadgeKeyImage( Argument1 )
    if type( Argument1 ) == "string" then
        local Match, Match2 = Argument1:match( "^(%w+):(%d*)$" )
        return RankImage( Match, Match2 )
    end
    return nil
end

local function SetRankBadge( Object, Image )
    if not Object then
        return
    end

    local Image2 = Object:FindFirstChild( "Image" ) or Object

    if Image and Image2.Image ~= Image then
        Image2.Image = Image

        if Image2 ~= Object and Result2 and Result2.Place then
            Result2.Place( Image2 )
        end
    end

    local Visible = Image ~= nil and true or false
    Object.Visible = Visible
end

local RankedShared3 = ReplicatedStorage:FindFirstChild( "RankedShared" )
RankedShared4 = if RankedShared3 then RankedShared3:FindFirstChild( "Config" ) else RankedShared3
local Result4
local Success2, Result3 = pcall( require, RankedShared4 )
Result4 = Success2 and type( Result3 ) == "table" and Result3 or nil
local Value1

local function SeasonText( Argument1 )
    local Text

    if ClanShared.SeasonName then
        local SeasonName = ClanShared.SeasonName( Argument1 )

        if SeasonName then
            Text = SeasonName
        else
            Text = tostring( Argument1 )
        end
    else
        Text = tostring( Argument1 )
    end

    local Text2 = "SEASON " .. Text

    if not Result4 or not Result4.SeasonAt then
        return Text2
    end

    local Number2
    local SeasonAt = Result4.SeasonAt
    local Success, Result = pcall( SeasonAt, os.time( ) )

    if not Success or type( Result ) ~= "table" then
        Number2 = 0
    else
        local Number = ( tonumber( Result.endsAt ) or 0 ) - os.time( )

        if Number then
            Number2 = Number
        else
            Number2 = 0
        end
    end
    if Number2 <= 0 then
        return Text2
    end

    local Format
    local Number3 = Number2 // 86400
    local Number4 = Number2 % 86400 // 3600
    local Number5 = Number2 % 3600 // 60

    if not ( Number3 > 0 ) or not ( "%dD %dH" ):format( Number3, Number4 ) then
        Format = ( "%dH %02dM" ):format( Number4, Number5 )
    else
        Format = ( "%dD %dH" ):format( Number3, Number4 )
    end

    return Text2 .. "  ·  ENDS IN " .. Format
end

local function PaintRanked( Stats, Argument2 )
    if not Stats then
        return
    end

    local Parent = Stats.Parent
    local Ranked = Stats:FindFirstChild( "Ranked" )

    if Ranked then
        Ranked.Visible = false
    end

    local Table = { }

    for Value in tostring( Stats:GetAttribute( "Ordre" ) or "Rank,Kills,Members" ):gmatch( "[^,]+" ) do
        local FoundChild = Stats:FindFirstChild( Value )

        if FoundChild and FoundChild ~= Ranked then
            table.insert( Table, FoundChild )
        end
    end

    local Value1, Number4
    Value1 = nil
    Number4 = 0

    for Key, Value2 in Table, nil, nil do
        Number4 = Number4 + ( tonumber( Value2:GetAttribute( "Poids" ) ) or 1 )
    end

    local Value3, Number3
    Value3 = nil
    Number3 = 0

    for Key2, Value4 in Table, nil, nil do
        local Number2 = ( tonumber( Value4:GetAttribute( "Poids" ) ) or 1 ) / math.max( Number4, 1 )
        Value4.Position = UDim2.fromScale( Number3, Value4.Position.Y.Scale )
        Value4.Size = UDim2.fromScale( Number2, Value4.Size.Y.Scale )
        Number3 = Number3 + Number2
    end

    local Visible = type( Argument2 ) == "table" and true or false
    local RangClan

    if Parent then
        RangClan = Parent:FindFirstChild( "RangClan" )
    else
        RangClan = Parent
    end

    local RangClanNom

    if Parent then
        RangClanNom = Parent:FindFirstChild( "RangClanNom" )
    else
        RangClanNom = Parent
    end

    local Image2

    if not Visible or not Argument2.rk then
        Image2 = nil
    else
        local Rk = Argument2.rk
        local Dv = Argument2.dv

        if not Result2 or type( Rk ) ~= "string" or Rk == "" or Rk == "Unranked" then
            Image2 = nil
        else
            local Image = Result2.Image
            Image2 = Image( Rk, ( tonumber( Dv ) ) )
        end
        if not Image2 then
            Image2 = nil
        end
    end
    if RangClan then
        local Image3 = RangClan:FindFirstChild( "Image" ) or RangClan

        if Image2 and Image3.Image ~= Image2 then
            Image3.Image = Image2

            if Image3 ~= RangClan and Result2 and Result2.Place then
                Result2.Place( Image3 )
            end
        end

        local Visible2 = Image2 ~= nil and true or false
        RangClan.Visible = Visible2
    end
    if RangClan and Image2 and Parent then
        local Visible3, Visible22

        if not Result2 or not Result2.Visible then
            Visible22 = 0.5
            Visible3 = -0.5
        else
            Visible3, Visible22 = Result2.Visible( Image2 )
        end

        local Y2
        local Min = math.min( 0.9, 0.68 / math.max( Visible22 - Visible3, 0.1 ) )
        local AbsoluteSize = Parent.AbsoluteSize

        if not ( AbsoluteSize.X > 0 ) or not ( AbsoluteSize.Y > 0 ) then
            local Number = tonumber( Parent:GetAttribute( "RatioHL" ) )

            if Number then
                Y2 = Number
            else
                Y2 = 0.2
            end
        else
            local Y = AbsoluteSize.Y / AbsoluteSize.X

            if Y then
                Y2 = Y
            else
                local Number = tonumber( Parent:GetAttribute( "RatioHL" ) )

                if Number then
                    Y2 = Number
                else
                    Y2 = 0.2
                end
            end
        end

        local Min2 = 0.955 - Min * Y2 * 0.5
        RangClan.AnchorPoint = Vector2.new( 0.5, 0.5 )
        RangClan.Size = UDim2.fromScale( Min * Y2, Min )
        RangClan.Position = UDim2.fromScale( Min2, 0.08 - Visible3 * Min )

        if RangClanNom then
            RangClanNom.Position = UDim2.fromScale( Min2, RangClanNom.Position.Y.Scale )
        end
    end
    if RangClanNom then
        RangClanNom.Visible = Visible

        if Visible then
            local Text

            if Argument2.rk then
                local Label2
                local Label = Argument2.label
                Label2 = if Label then Label else Argument2.rk
                local Upper = tostring( Label2 ):upper( )

                if Upper then
                    Text = Upper
                else
                    Text = ( "UNRANKED  ·  %d/%d" ):format( tonumber( Argument2.placed ) or 0, tonumber( Argument2.n ) or 4 )
                end
            else
                Text = ( "UNRANKED  ·  %d/%d" ):format( tonumber( Argument2.placed ) or 0, tonumber( Argument2.n ) or 4 )
            end

            RangClanNom.Text = Text
        end
    end
end

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local ClanRemote = ReplicatedStorage:WaitForChild( "ClanRemote", math.huge )
local ClanQuery = ReplicatedStorage:WaitForChild( "ClanQuery", math.huge )
local ClanBoardData = ReplicatedStorage:WaitForChild( "ClanBoardData", math.huge )
local Get = Screens.Get( "ClanMenu" )
Get.Visible = false
local Window = Get:WaitForChild( "Window" )
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
local Close = Window:WaitForChild( "Close" )
local Tabs = Window:WaitForChild( "Tabs" )
local Table = {
    clan = Tabs:WaitForChild( "TabClan" ),
    invites = Tabs:WaitForChild( "TabInvites" ),
    board = Tabs:WaitForChild( "TabBoard" )
}
local Table2 = { "clan", "invites", "board" }
local Count = Table.invites:WaitForChild( "Count" )
local Pages = Window:WaitForChild( "Pages" )
local NoClan = Pages:WaitForChild( "NoClan" )
local InClan = Pages:WaitForChild( "InClan" )
local InvitePage = Pages:WaitForChild( "InvitePage" )
local InvitesPage = Pages:WaitForChild( "InvitesPage" )
local BoardPage = Pages:WaitForChild( "BoardPage" )
local Create = NoClan:WaitForChild( "Create" )
local Buy = NoClan:WaitForChild( "Buy" )
local NameBox = Create:WaitForChild( "NameBox" )
local TagBox = Create:WaitForChild( "TagBox" )
local Preview = Create:WaitForChild( "Preview" )
local Tag = Preview:WaitForChild( "Plate" ):WaitForChild( "Tag" )
local PreviewName = Preview:WaitForChild( "PreviewName" )
local PreviewPlayer = Preview:WaitForChild( "PreviewPlayer" )
local Create2 = Create:WaitForChild( "Create" )
local OfferClan = Buy:WaitForChild( "OfferClan" )
local OfferPack = Buy:WaitForChild( "OfferPack" )
local Buy2 = OfferClan:WaitForChild( "Price" ):WaitForChild( "Buy" )
local Buy3 = OfferPack:WaitForChild( "Price" ):WaitForChild( "Buy" )
local Cooldown = NoClan:WaitForChild( "Cooldown" )
local Loading = NoClan:WaitForChild( "Loading" )
local Perks = Buy:WaitForChild( "Perks" )
local Free = Buy:WaitForChild( "Free" )
local Scale = Perks.Position.Y.Scale
local Scale2 = Free.Position.Y.Scale
local NameCount = Create:WaitForChild( "NameCount" )
local TagCount = Create:WaitForChild( "TagCount" )
local Title = Window:WaitForChild( "SeasonCard" ):WaitForChild( "Title" )
local Hero = InClan:WaitForChild( "Hero" )
local Tag2 = Hero:WaitForChild( "Plate" ):WaitForChild( "Tag" )
local NameRow = Hero:WaitForChild( "NameRow" )
local ClanName = NameRow:WaitForChild( "ClanName" )
local Award = NameRow:WaitForChild( "Award" )
local Stats = Hero:WaitForChild( "Stats" )
local Value = Stats:WaitForChild( "Rank" ):WaitForChild( "Value" )
local Value2 = Stats:WaitForChild( "Kills" ):WaitForChild( "Value" )
local Value3 = Stats:WaitForChild( "Members" ):WaitForChild( "Value" )
local Season = InClan:WaitForChild( "Season" )
local Roster = InClan:WaitForChild( "Roster" )
local Online = InClan:WaitForChild( "Online" )
local Invite = InClan:WaitForChild( "Invite" )
local Dissolve = InClan:WaitForChild( "Dissolve" )
local Leave = InClan:WaitForChild( "Leave" )
local Back = InvitePage:WaitForChild( "Back" )
local SearchBox = InvitePage:WaitForChild( "SearchBox" )
local Search = InvitePage:WaitForChild( "Search" )
local List = InvitePage:WaitForChild( "List" )
local Empty = InvitePage:WaitForChild( "Empty" )
local List2 = InvitesPage:WaitForChild( "List" )
local Empty2 = InvitesPage:WaitForChild( "Empty" )
local Hint = InvitesPage:WaitForChild( "Hint" )
local Text = Hint.Text
local TextColor3 = Hint.TextColor3
local Text2 = Empty.Text
local List3 = BoardPage:WaitForChild( "List" )
local Empty3 = BoardPage:WaitForChild( "Empty" )
local Season2 = BoardPage:WaitForChild( "Season" )
local MyRow = BoardPage:WaitForChild( "MyRow" )
local Podium = BoardPage:WaitForChild( "Podium" )
local Table3 = {
    Podium:WaitForChild( "First" ),
    Podium:WaitForChild( "Second" ),
    Podium:WaitForChild( "Third" )
}
local Scale3 = List3.Size.Y.Scale
local Scale4 = MyRow.Position.Y.Scale - List3.Position.Y.Scale - 0.055
local Confirm = Window:WaitForChild( "Confirm" )
local Box = Confirm:WaitForChild( "Box" )
local Yes = Box:WaitForChild( "Yes" )
local No = Box:WaitForChild( "No" )
local Picker = RobuxShopUI.Picker
local Picker2 = Picker( Window:WaitForChild( "GiftPicker" ), "ClanGift" )
local Templates = Get:WaitForChild( "Templates" )
local Table4 = { }
local Table5 = {
    "MemberCard",
    "SlotCard",
    "PlayerRow",
    "InviteRow",
    "BoardRow",
    "ColorCell",
    "SpecialCard",
    "ThemeCell",
    "ScoutRow"
}
Value1 = nil

for Key, Value4 in Table5, nil, nil do
    Table4[ Value4 ] = Templates:WaitForChild( Value4 ):Clone( )
    Table4[ Value4 ].Visible = true
end

local Count2
local Card = Screens.Get( "ClanInvite" ):WaitForChild( "Card" )
local Tag3 = Card:WaitForChild( "Plate" ):WaitForChild( "Tag" )
local Message = Card:WaitForChild( "Message" )
local Accept = Card:WaitForChild( "Accept" )
local Decline = Card:WaitForChild( "Decline" )
local Fill = Card:WaitForChild( "Timer" ):WaitForChild( "Fill" )
local Get2 = Screens.Get( "ClanCard" )
Get2.Visible = false
local Box2 = Get2:WaitForChild( "Slot" ):WaitForChild( "Box" )
local Tag4 = Box2:WaitForChild( "Plate" ):WaitForChild( "Tag" )
local ClanName2 = Box2:WaitForChild( "ClanName" )
local Text3 = Box2:WaitForChild( "Text" )
local Note = Box2:WaitForChild( "Note" )
local Invite2 = Box2:WaitForChild( "Invite" )
local Back2 = Box2:WaitForChild( "Back" )
local PlayerProfile = PlayerGui:WaitForChild( "PlayerProfile", math.huge )
local ShowCard = PlayerProfile:WaitForChild( "ShowCard" )
local HideCard = PlayerProfile:WaitForChild( "HideCard" )
local CardClosed = PlayerProfile:WaitForChild( "CardClosed" )
local ClanButton = Screens.Get( "CrewHUD" ):FindFirstChild( "ClanButton", true )

if ClanButton then
    Count2 = ClanButton:FindFirstChild( "Count" )
else
    Count2 = ClanButton
end

local FromScale2
local StylePage = Pages:WaitForChild( "StylePage" )
local Customize = InClan:WaitForChild( "Customize" )
local Back3 = StylePage:WaitForChild( "Back" )
local Save = StylePage:WaitForChild( "Save" )
local Rename = StylePage:WaitForChild( "Rename" )
local Undo = StylePage:WaitForChild( "Undo" )
local Status = StylePage:WaitForChild( "Status" )
local Sections = StylePage:WaitForChild( "Sections" )
local Table6 = {
    page = StylePage,
    customize = Customize,
    back = Back3,
    save = Save,
    rename = Rename,
    undo = Undo,
    status = Status,
    tabs = {
        color = Sections:WaitForChild( "SecColor" ),
        banner = Sections:WaitForChild( "SecBanner" ),
        name = Sections:WaitForChild( "SecName" )
    },
    secs = {
        color = StylePage:WaitForChild( "ColorPage" ),
        banner = StylePage:WaitForChild( "BannerPage" ),
        name = StylePage:WaitForChild( "NamePage" )
    }
}
local Palette = Table6.secs.color:WaitForChild( "Palette" )
local Specials = Table6.secs.color:WaitForChild( "Specials" )
Table6.palette = Palette
Table6.specials = Specials
Table6.themes = Table6.secs.banner:WaitForChild( "Themes" )
Table6.banner = StylePage:WaitForChild( "Banner" )
local Nom = StylePage:WaitForChild( "NameTag" ):WaitForChild( "Nom" )
local Chat = StylePage:WaitForChild( "Chat" ):WaitForChild( "Line" )
Table6.nom = Nom
Table6.chat = Chat
Table6.nomPlate = StylePage.NameTag:WaitForChild( "Plate" )
local Name = Table6.secs.name
local Name2 = Name:WaitForChild( "NameBox" )
local Tag5 = Name:WaitForChild( "TagBox" )
Table6.name = Name2
Table6.tag = Tag5
local NameCount2 = Name:WaitForChild( "NameCount" )
local TagCount2 = Name:WaitForChild( "TagCount" )
Table6.nameCount = NameCount2
Table6.tagCount = TagCount2
local RuleCard = Name:WaitForChild( "RuleCard" )
local RuleText = RuleCard:WaitForChild( "RuleText" )
local RenameState = RuleCard:WaitForChild( "RenameState" )
Table6.ruleText = RuleText
Table6.renameState = RenameState
local Table7 = {
    on = false,
    draft = nil,
    sec = "color",
    built = false,
    tick = 0,
    tagShown = nil,
    swatches = { color = { }, special = { }, theme = { } }
}
Table7.view = { on = false, id = nil, data = nil, token = 0 }
local ClanView = Pages:WaitForChild( "ClanView" )
local Hero2 = ClanView:WaitForChild( "Hero" )
local NameRow2 = Hero2:WaitForChild( "NameRow" )
local Stats2 = Hero2:WaitForChild( "Stats" )
Table7.V = {
    page = ClanView,
    hero = Hero2,
    tag = Hero2:WaitForChild( "Plate" ):WaitForChild( "Tag" ),
    nameRow = NameRow2,
    name = NameRow2:WaitForChild( "ClanName" ),
    award = NameRow2:WaitForChild( "Award" ),
    rank = Stats2:WaitForChild( "Rank" ):WaitForChild( "Value" ),
    kills = Stats2:WaitForChild( "Kills" ):WaitForChild( "Value" ),
    count = Stats2:WaitForChild( "Members" ):WaitForChild( "Value" ),
    season = ClanView:WaitForChild( "Season" ),
    online = ClanView:WaitForChild( "Online" ),
    list = ClanView:WaitForChild( "List" ),
    back = ClanView:WaitForChild( "Back" )
}
ClanView.Visible = false

if Card.Position.Y.Scale < 0 then
    local FromScale = UDim2.fromScale( 0.5, 0.07 )

    if FromScale then
        FromScale2 = FromScale
    else
        FromScale2 = Card.Position
    end
else
    FromScale2 = Card.Position
end
local Position = UDim2.fromScale( FromScale2.X.Scale, -0.35 )
local FromScale3 = UDim2.fromScale( FromScale2.X.Scale, 0.14 )
Card.Visible = false
Card.Position = Position
Confirm.Visible = false
local Table8 = {
    {
        obj = Window,
        base = Window.Size,
        small = UDim2.fromScale( 0.94, 0.8 ),
        basePos = Window.Position,
        smallPos = UDim2.fromScale( 0.5, 0.57 )
    },
    { obj = Card, base = Card.Size, small = UDim2.fromScale( 0.52, 0.25 ) }
}
local Table9 = { List, List2, List3, Table7.V.list }
local Flag = false
local Callback = nil

local function Fit()
    local Vector22
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera or not CurrentCamera.ViewportSize then
        Vector22 = Vector2.new( 1920, 1080 )
    else
        Vector22 = CurrentCamera.ViewportSize
    end

    local FlagInner = Vector22.Y < 600 and true or false

    if FlagInner ~= Flag then
        Flag = FlagInner

        if Callback then
            Callback( )
        end
    end

    local Value1 = nil

    for Key, Value in Table8, nil, nil do
        local Size
        local Obj = Value.obj
        Size = FlagInner and Value.small or Value.base
        Obj.Size = Size

        if Value.basePos then
            local Position
            local Obj2 = Value.obj
            Position = FlagInner and Value.smallPos or Value.basePos
            Obj2.Position = Position
        end
    end

    local Value2 = nil

    for Key2, Value3 in Table9, nil, nil do
        Value3.ScrollBarThickness = math.max( 3, ( math.floor( Vector22.Y * 0.005 + 0.5 ) ) )
    end
end

Storage.Value5 = nil

Storage.WatchCam = function()
    if Storage.Value5 then
        Storage.Value5:Disconnect( )
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        Storage.Value5 = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
    end

    Fit( )
end

workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( Storage.WatchCam )
Storage.WatchCam( )

Storage.ApplyType = function( Argument1, Object )
    local Y = Argument1.AbsoluteSize.Y

    if Y <= 0 then
        return
    end

    local Number = not Flag and 1 or 1.3

    for Key, Value in Object:GetDescendants( ) do
        local TextH = Value:GetAttribute( "TextH" )

        if TextH then
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

            TypeSize2.MaxTextSize = math.max( 1, ( math.floor( Y * TextH * Number + 0.5 ) ) )
        end
    end
end

Window:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
    Storage.ApplyType( Window, Window )
end )
Card:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
    Storage.ApplyType( Card, Card )
end )
Box2:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
    Storage.ApplyType( Box2, Box2 )
end )
task.defer( function()
    Storage.ApplyType( Window, Window )
    Storage.ApplyType( Card, Card )
    Storage.ApplyType( Box2, Box2 )
end )

Storage.Esc = function( Argument1 )
    return ( tostring( Argument1 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) )
end

Storage.Num = function( Text )
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

Storage.TagText = function( Argument1, Argument2, Argument3 )
    local TagRich = ClanShared.TagRich( Argument1, Argument3 )
    return TagRich .. " " .. tostring( Argument2 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
end

Storage.SetBtn = function( Self, Enabled, Text )
    local Normal = Self:FindFirstChild( "Normal" )
    local Off = Self:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = Enabled
    end
    if Off then
        Off.Enabled = not Enabled
    end

    Self.AutoButtonColor = Enabled
    Self:SetAttribute( "On", Enabled )

    if Text then
        Self.Text.Text = Text
    end
end

Storage.IsOn = function( Object )
    local Flag = Object:GetAttribute( "On" ) ~= false and true or false
    return Flag
end

Storage.SetTab = function( Self, Enabled )
    local Normal = Self:FindFirstChild( "Normal" )
    local Selected = Self:FindFirstChild( "Selected" )

    if Normal and Normal:IsA( "UIGradient" ) then
        Normal.Enabled = not Enabled
    end
    if Selected and Selected:IsA( "UIGradient" ) then
        Selected.Enabled = Enabled
    end
end

Storage.Table10 = { }

Storage.PaintPlate = function( Self, Argument2 )
    local UIGradient
    local ColorDef = ClanShared.ColorDef( Argument2 )
    local Tag = Self:FindFirstChild( "Tag" )

    if Tag then
        UIGradient = Tag:FindFirstChildOfClass( "UIGradient" )
    else
        UIGradient = Tag
    end
    if UIGradient then
        local Rotation
        UIGradient.Color = ClanShared.GradientOf( Argument2 )
        Rotation = not ColorDef.keys and 90 or 15
        local Value1
        UIGradient.Rotation = Rotation
        UIGradient.Offset = Vector2.zero
        Value1 = ColorDef.keys and Argument2 or nil
        Storage.Table10[ UIGradient ] = Value1
    end

    local UIStroke = Self:FindFirstChildOfClass( "UIStroke" )

    if UIStroke then
        local Color

        if ColorDef.keys then
            local Item = ColorDef.keys[ 1 ]

            if Item then
                Color = Item
            else
                Color = ColorDef.c
            end
        else
            Color = ColorDef.c
        end

        UIStroke.Color = Color
    end
end

Storage.ThemeColor = function( Argument1 )
    return ClanShared.ThemeDef( Argument1 ).c
end

Storage.AwardImage = function( Text )
    local Clan2
    local Clan = BadgeCatalog.ById.Clan

    if Clan then
        local Tiers = Clan.tiers

        if Tiers then
            Clan2 = Clan.tiers[ tonumber( Text ) or 0 ]
        else
            Clan2 = Tiers
        end
    else
        Clan2 = Clan
    end

    local LogoImage2

    if Clan2 then
        local LogoImage = BadgeCatalog.LogoImage( Clan, Clan2 )

        if LogoImage then
            LogoImage2 = LogoImage
        else
            LogoImage2 = nil
        end
    else
        LogoImage2 = nil
    end

    return LogoImage2
end

Storage.TimeLeft = function( Text )
    local Max = math.max( 0, ( math.floor( tonumber( Text ) or 0 ) ) )

    if Max >= 172800 then
        return math.ceil( Max / 86400 ) .. " days"
    end
    if Max >= 3600 then
        return math.ceil( Max / 3600 ) .. " h"
    end
    return math.max( 1, ( math.ceil( Max / 60 ) ) ) .. " min"
end

Storage.Flag2 = false
Storage.Text4 = "clan"
Storage.Flag3 = false
Storage.Value6 = nil
Storage.Number = 0
Storage.Table11 = { }
Storage.Value7 = nil
Storage.Value8 = nil
Storage.Flag4 = false
Storage.Callback2 = nil
Storage.Callback3 = nil
Storage.Callback4 = nil

Storage.Fetch = function()
    Storage.Number = Storage.Number + 1
    task.spawn( function()
        local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

        if Storage.Number ~= Storage.Number then
            return
        end
        if Success and type( Result ) == "table" then
            Storage.Value6 = Result
            Result.at = os.clock( )

            if Result.loading then
                task.delay( 1.5, function()
                    if Storage.Flag2 then
                        Storage.Fetch( )
                    end
                end )
            end
        end
        if Storage.Flag2 then
            Storage.Callback2( )
        end
    end )
end

Storage.Table12 = { }

Storage.ClearRows = function()
    local Value1 = nil

    for Key, Value in Storage.Table12, nil, nil do
        Value:Destroy( )
    end

    table.clear( Storage.Table12 )
end

Storage.AddRow = function( Parent, RowName, LayoutOrder, Argument4, Argument5 )
    local Clone = Table4[ RowName ]:Clone( )
    Clone.LayoutOrder = LayoutOrder
    Clone.Size = UDim2.fromScale( 1, 1 / math.max( Argument5, Argument4 ) )
    Clone.Parent = Parent
    table.insert( Storage.Table12, Clone )
    Storage.ApplyType( Window, Clone )
    local Card = Clone:WaitForChild( "Card" )
    Card.MouseEnter:Connect( function()
        Card:SetAttribute( "Rest", Card.BackgroundTransparency )
        Card.BackgroundTransparency = Card.BackgroundTransparency - 0.05
    end )
    Card.MouseLeave:Connect( function()
        local BackgroundTransparency = Card:GetAttribute( "Rest" )

        if BackgroundTransparency then
            Card.BackgroundTransparency = BackgroundTransparency
        end
    end )
    return Clone, Card
end

Storage.AddCard = function( CardName, LayoutOrder )
    local Clone = Table4[ CardName ]:Clone( )
    Clone.LayoutOrder = LayoutOrder
    Clone.Parent = Roster
    table.insert( Storage.Table12, Clone )
    Storage.ApplyType( Window, Clone )
    local Edge = Clone:FindFirstChild( "Edge" )

    if Clone:IsA( "GuiButton" ) and Edge then
        Clone.MouseEnter:Connect( function()
            if Clone.Selectable then
                Edge.Transparency = 0.4
            end
        end )
        Clone.MouseLeave:Connect( function()
            Edge.Transparency = 0.8
        end )
    end

    return Clone
end

ColorSequence.new( Color3.fromRGB( 150, 44, 52 ), Color3.fromRGB( 46, 14, 18 ) )
Storage.ColorSequence2 = ColorSequence.new( Color3.fromRGB( 72, 64, 68 ), Color3.fromRGB( 30, 26, 28 ) )

Storage.V = function( Amount )
    local Total = Flag and Amount - 1 or Amount
    return Total
end

Storage.SizeList = function( Argument1, Argument2, Argument3 )
    Argument1.CanvasSize = UDim2.fromScale( 0, math.max( 1, Argument2 / Argument3 ) * Argument1.Size.Y.Scale )
end

Storage.FitLine = function( Argument1, ClanName, Award, Amount )
    local Y = Argument1.AbsoluteSize.Y
    local X = Argument1.AbsoluteSize.X

    if Y <= 0 or X <= 0 then
        return
    end

    local X3

    if Award.Visible then
        local X2 = Award.AbsoluteSize.X + X * 0.02

        if X2 then
            X3 = X2
        else
            X3 = 0
        end
    else
        X3 = 0
    end

    local Max
    local X4 = X - X3
    local TextSize = math.max( 8, ( math.floor( Y * ( Amount or 0.82 ) ) ) )
    ClanName.TextSize = TextSize
    Max = TextSize

    while Max > 8 do
        if not ( X4 < ClanName.TextBounds.X ) then
            break
        end

        local TextSize2 = Max - 1
        ClanName.TextSize = TextSize2
        Max = TextSize2
    end
end

Storage.FitName = function()
    Storage.FitLine( NameRow, ClanName, Award )
end

Storage.AfterPlate = function( Object, Argument2, Argument3, Argument4 )
    local function Place()
        local X = Object.AbsoluteSize.X

        if X <= 0 then
            return
        end

        local Value1
        local X2 = ( Argument2.AbsolutePosition.X + Argument2.AbsoluteSize.X - Object.AbsolutePosition.X ) / X + 0.02
        Value1 = nil

        for Key, Value in Argument3, nil, nil do
            Value.Position = UDim2.fromScale( X2, Value.Position.Y.Scale )
            Value.Size = UDim2.fromScale( math.max( 0.05, Argument4 - X2 ), Value.Size.Y.Scale )
        end
    end

    Object:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Place )
    task.defer( Place )
end

NameRow:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Storage.FitName )

Storage.HideConfirm = function()
    Confirm.Visible = false
    Storage.Value7 = nil
    GamepadNav.Close( "ClanConfirm" )
end

Storage.Ask = function( Text, Text2, Text3, Go )
    local Text5
    Box.Title.Text = Text
    Box.Text.Text = Text2
    local Text4 = Yes.Text
    Text5 = Controls.IsGamepad and Text3 .. " · HOLD" or Text3
    Text4.Text = Text5
    Storage.Value7 = Go
    Confirm.Visible = true
    GamepadNav.Open( "ClanConfirm", {
        root = Box,
        virtual = true,
        first = No,
        freeze = true,
        virtualActions = {
            [ Yes ] = function()
                Confirm.Visible = false
                Storage.Value7 = nil
                GamepadNav.Close( "ClanConfirm" )

                if Storage.Value7 then
                    Storage.Value7( )
                end
            end,
            [ No ] = Storage.HideConfirm
        },
        holdButtons = { [ Yes ] = 1 },
        onBack = Storage.HideConfirm,
        backLabel = "Cancel"
    } )
end

Yes.Activated:Connect( function()
    Confirm.Visible = false
    Storage.Value7 = nil
    GamepadNav.Close( "ClanConfirm" )

    if Storage.Value7 then
        Storage.Value7( )
    end
end )
No.Activated:Connect( Storage.HideConfirm )

Storage.RenderNoClan = function()
    local Visible
    local NotCaptured = not Storage.Value6

    if NotCaptured then
        Visible = NotCaptured
    elseif Storage.Value6.loading == true then
        Visible = true
    else
        Visible = false
    end

    Loading.Visible = Visible

    if not Storage.Value6 or Storage.Value6.loading then
        Create.Visible = false
        Buy.Visible = false
        Cooldown.Visible = false
        return
    end

    local Visible2 = Storage.Value6.pass == true and true or false
    local Visible3
    Create.Visible = Visible2
    Visible3 = Storage.Value6.pass ~= true and true or false
    local Visible4
    Buy.Visible = Visible3
    Visible4 = Storage.Value6.crewPass ~= true and true or false
    local Number
    OfferPack.Visible = Visible4
    local Value = Perks.Tag.Value
    local DisplayName = LocalPlayer.DisplayName
    local TagRich = ClanShared.TagRich( "ABC", nil )
    Value.Text = TagRich .. " " .. tostring( DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    Number = if OfferPack.Visible then 0 else OfferPack.Position.Y.Scale - OfferClan.Position.Y.Scale
    local Visible5
    Perks.Position = UDim2.fromScale( Perks.Position.X.Scale, Scale - Number )
    Free.Position = UDim2.fromScale( Free.Position.X.Scale, Scale2 - Number )
    local Number2 = tonumber( Storage.Value6.cooldown ) or 0
    Visible5 = Number2 > 0 and true or false
    Cooldown.Visible = Visible5

    if Number2 > 0 then
        local Text
        local Max = math.max( 0, ( math.floor( tonumber( Number2 ) or 0 ) ) )

        if Max >= 172800 then
            Text = math.ceil( Max / 86400 ) .. " days"
        elseif Max >= 3600 then
            Text = math.ceil( Max / 3600 ) .. " h"
        else
            Text = math.max( 1, ( math.ceil( Max / 60 ) ) ) .. " min"
        end

        Cooldown.Text = ( "You left a clan: you can join another one in %s" ):format( Text )
    end
end

Storage.Flag5 = false

Storage.UpdatePreview = function()
    local Text2

    if TagBox.Text == "" then
        Text2 = "ABC"
    else
        local Text = TagBox.Text

        if Text then
            Text2 = Text
        else
            Text2 = "ABC"
        end
    end

    local Text3
    local Match = NameBox.Text:match( "^%s*(.-)%s*$" )
    Tag.Text = Text2
    Text3 = Match ~= "" and Match or "Clan Name"
    local Flag
    PreviewName.Text = Text3
    local DisplayName = LocalPlayer.DisplayName
    local TagRich = ClanShared.TagRich( Text2, nil )
    PreviewPlayer.Text = TagRich .. " " .. tostring( DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    local Len = utf8.len( Match ) or 0

    if ClanShared.NAME_MIN <= Len then
        if Len <= ClanShared.NAME_MAX then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    local Flag2 = #TagBox.Text == ClanShared.TAG_LEN and true or false
    local TextColor3
    NameCount.Text = ( "%d/%d" ):format( Len, ClanShared.NAME_MAX )
    TagCount.Text = ( "%d/%d" ):format( #TagBox.Text, ClanShared.TAG_LEN )

    if Flag then
        local FromRGB = Color3.fromRGB( 120, 225, 140 )

        if FromRGB then
            TextColor3 = FromRGB
        else
            TextColor3 = Color3.fromRGB( 196, 176, 182 )
        end
    else
        TextColor3 = Color3.fromRGB( 196, 176, 182 )
    end

    local TextColor32
    NameCount.TextColor3 = TextColor3

    if Flag2 then
        local FromRGB2 = Color3.fromRGB( 120, 225, 140 )

        if FromRGB2 then
            TextColor32 = FromRGB2
        else
            TextColor32 = Color3.fromRGB( 196, 176, 182 )
        end
    else
        TextColor32 = Color3.fromRGB( 196, 176, 182 )
    end

    TagCount.TextColor3 = TextColor32

    if not Storage.Flag5 then
        local Enabled = Flag and Flag2
        local Normal = Create2:FindFirstChild( "Normal" )
        local Off = Create2:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = Enabled
        end
        if Off then
            Off.Enabled = not Enabled
        end

        Create2.AutoButtonColor = Enabled
        Create2:SetAttribute( "On", Enabled )
        Create2.Text.Text = "CREATE CLAN"
    end
end

function Table7.paintMember( Object, Argument2, Color )
    local Flag
    Object.Name = "Member_" .. Argument2.uid
    Flag = Argument2.uid == LocalPlayer.UserId and true or false
    local Flag2

    if Flag then
        Flag2 = Flag
    elseif Argument2.on == "here" then
        Flag2 = true
    else
        Flag2 = false
    end

    local Flag3

    if Flag2 then
        Flag3 = Flag2
    elseif Argument2.on == "on" then
        Flag3 = true
    else
        Flag3 = false
    end

    local ImageTransparency
    local Backdrop = Object.Backdrop
    local Avatar = Backdrop.Avatar
    Avatar.Image = ( "rbxthumb://type=AvatarBust&id=%d&w=150&h=150" ):format( Argument2.uid )
    local Avatar2 = Backdrop.Avatar
    ImageTransparency = not Flag3 and 0.4 or 0
    local Color2
    Avatar2.ImageTransparency = ImageTransparency
    local Glow = Backdrop.Glow
    Color2 = Flag3 and Color or Storage.ColorSequence2
    local TextColor3
    Glow.Color = Color2
    local PlayerName = Object.PlayerName
    PlayerName.Text = tostring( Argument2.n ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    local PlayerName2 = Object.PlayerName

    if Flag then
        local FromRGB = Color3.fromRGB( 255, 214, 120 )

        if FromRGB then
            TextColor3 = FromRGB
        else
            TextColor3 = Color3.fromRGB( 240, 238, 244 )
        end
    else
        TextColor3 = Color3.fromRGB( 240, 238, 244 )
    end

    local Visible
    PlayerName2.TextColor3 = TextColor3
    local Crown = Object.Crown
    Visible = Argument2.chef == true and true or false
    Crown.Visible = Visible

    if Argument2.chef then
        local Edge = Object.Edge
        local Edge2 = Object.Edge
        Edge.Color = Color3.fromRGB( 255, 202, 86 )
        Edge2.Transparency = 0.2
    end

    local BackgroundColor3
    local Status = Object.Status

    if Flag3 then
        local FromRGB2 = Color3.fromRGB( 90, 220, 110 )

        if FromRGB2 then
            BackgroundColor3 = FromRGB2
        else
            BackgroundColor3 = Color3.fromRGB( 110, 112, 125 )
        end
    else
        BackgroundColor3 = Color3.fromRGB( 110, 112, 125 )
    end

    local Text
    Status.BackgroundColor3 = BackgroundColor3
    local Info = Object.Info

    if Flag2 then
        Text = "IN SERVER"
    elseif Flag3 then
        Text = "ONLINE"
    else
        Text = "OFFLINE"
    end

    local TextColor32
    Info.Text = Text
    local Info2 = Object.Info

    if Flag3 then
        local FromRGB3 = Color3.fromRGB( 120, 225, 140 )

        if FromRGB3 then
            TextColor32 = FromRGB3
        else
            TextColor32 = Color3.fromRGB( 178, 170, 178 )
        end
    else
        TextColor32 = Color3.fromRGB( 178, 170, 178 )
    end

    local Image2
    Info2.TextColor3 = TextColor32
    local Kills = Object.Kills
    Kills.Text = Storage.Num( Argument2.k )
    local RangBadge = Object:FindFirstChild( "RangBadge" )
    local Rb = Argument2.rb

    if type( Rb ) == "string" then
        local Match, Match2 = Rb:match( "^(%w+):(%d*)$" )

        if not Result2 or type( Match ) ~= "string" or Match == "" or Match == "Unranked" then
            Image2 = nil
        else
            local Image = Result2.Image
            Image2 = Image( Match, ( tonumber( Match2 ) ) )
        end
    else
        Image2 = nil
    end
    if RangBadge then
        local Image3 = RangBadge:FindFirstChild( "Image" ) or RangBadge

        if Image2 and Image3.Image ~= Image2 then
            Image3.Image = Image2

            if Image3 ~= RangBadge and Result2 and Result2.Place then
                Result2.Place( Image3 )
            end
        end

        local Visible2 = Image2 ~= nil and true or false
        RangBadge.Visible = Visible2
    end

    local Hit = Object:FindFirstChild( "Hit" )

    if Hit then
        Hit.MouseEnter:Connect( function()
            local Edge = Object.Edge
            Edge:SetAttribute( "Rest", Object.Edge.Transparency )
            local Edge2 = Object.Edge
            Edge2.Transparency = math.max( 0, Object.Edge.Transparency - 0.35 )
        end )
        Hit.MouseLeave:Connect( function()
            local Transparency = Object.Edge:GetAttribute( "Rest" )

            if Transparency then
                Object.Edge.Transparency = Transparency
            end
        end )
    end

    return Flag3
end

Storage.RenderInClan = function()
    local Max2
    local Clan = Storage.Value6.clan
    local Max = Clan.max
    Max2 = if Max then Max else ClanShared.MAX_MEMBERS
    local Award3
    Tag2.Text = Clan.tag
    ClanName.Text = Clan.name
    Storage.PaintPlate( Tag2.Parent, Clan.shown )
    local Theme = Clan.theme
    local ImageColor3 = ClanShared.ThemeDef( Theme ).c
    Hero.ImageColor3 = ImageColor3
    local ColorSequence2 = ColorSequence.new( ImageColor3:Lerp( Color3.new( 0, 0, 0 ), 0.35 ), ImageColor3:Lerp( Color3.new( 0, 0, 0 ), 0.8 ) )
    local AwardInner = Clan.award

    if AwardInner then
        local Clan3
        local Award2 = Clan.award
        local Clan2 = BadgeCatalog.ById.Clan

        if Clan2 then
            local Tiers = Clan2.tiers

            if Tiers then
                Clan3 = Clan2.tiers[ tonumber( Award2 ) or 0 ]
            else
                Clan3 = Tiers
            end
        else
            Clan3 = Clan2
        end
        if Clan3 then
            local LogoImage = BadgeCatalog.LogoImage( Clan2, Clan3 )

            if LogoImage then
                Award3 = LogoImage
            else
                Award3 = nil
            end
        else
            Award3 = nil
        end
    else
        Award3 = AwardInner
    end

    local Visible
    Award.Image = Award3 or ""
    Visible = Award3 ~= nil and true or false
    local Text2
    Award.Visible = Visible
    task.defer( Storage.FitName )

    if Clan.rank then
        local Text = "#" .. Clan.rank

        if Text then
            Text2 = Text
        else
            Text2 = "-"
        end
    else
        Text2 = "-"
    end

    local Season2
    Value.Text = Text2
    Value2.Text = Storage.Num( Clan.kills )
    local Count = #Clan.members
    Value3.Text = ( "%d/%d" ):format( Count, Max2 )
    PaintRanked( Stats, Clan.ranked )
    local SeasonInner = Storage.Value6.season
    Season2 = if SeasonInner then SeasonInner else ClanShared.SEASON
    local Value1, Number
    Season.Text = SeasonText( Season2 )

    local function Order( Argument1 )
        if Argument1.chef then
            return 0
        end
        if Argument1.uid == LocalPlayer.UserId or Argument1.on == "here" then
            return 1
        end
        if Argument1.on == "on" then
            return 2
        end
        return 3
    end

    local Clone = table.clone( Clan.members )
    table.sort( Clone, function( Argument1, Argument2 )
        local Number

        if Argument1.chef then
            Number = 0
        elseif Argument1.uid == LocalPlayer.UserId or Argument1.on == "here" then
            Number = 1
        elseif Argument1.on == "on" then
            Number = 2
        else
            Number = 3
        end

        local Number2

        if Argument2.chef then
            Number2 = 0
        elseif Argument2.uid == LocalPlayer.UserId or Argument2.on == "here" then
            Number2 = 1
        elseif Argument2.on == "on" then
            Number2 = 2
        else
            Number2 = 3
        end
        if Number == Number2 then
            local Flag2
            local Number3 = tonumber( Argument1.k ) or 0
            Flag2 = ( tonumber( Argument2.k ) or 0 ) < Number3 and true or false
            return Flag2
        end
        local Flag = Number < Number2 and true or false
        return Flag
    end )
    Value1 = nil
    Number = 0

    for Key, ValueInner in Clone, nil, nil do
        local Value3Inner = Storage.AddCard( "MemberCard", Key )

        if Table7.paintMember( Value3Inner, ValueInner, ColorSequence2 ) then
            Number = Number + 1
        end

        local Hit = Value3Inner:FindFirstChild( "Hit" )

        if Hit then
            Hit.Activated:Connect( function()
                Table7.showMember( ValueInner )
            end )
        end

        local Visible4
        local Chef = Clan.chef
        Visible4 = if Chef then not ValueInner.chef else Chef
        Value3Inner.Kick.Visible = Visible4

        if Visible4 then
            local Uid = ValueInner.uid
            local N = ValueInner.n
            Value3Inner.Kick.Activated:Connect( function()
                local Text = "REMOVE " .. N:upper( ) .. "?"
                Storage.Ask( Text, ( "<b>%s</b> leaves the clan. <b>Their kills are removed from the clan score.</b>" ):format( ( tostring( N ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) ) ), "REMOVE", function()
                    ClanRemote:FireServer( "kick", Uid )
                end )
            end )
        end
    end

    Online.Text = ( "%d ONLINE" ):format( Number )
    local Count2 = Count + 1
    local I = Count2

    for I = Count2, Max2 do
        local Text4
        local Value2Inner = Storage.AddCard( "SlotCard", I )
        Value2Inner.Name = "Slot_" .. I
        local Text3 = Value2Inner.Text
        Text4 = not Clan.chef and "OPEN" or "INVITE"
        Text3.Text = Text4
        Value2Inner.Selectable = Clan.chef

        if Clan.chef then
            Value2Inner.Activated:Connect( function()
                Storage.Callback4( )
            end )
        end
    end

    local Visible2 = Clan.chef
    local Visible3 = not Clan.chef
    Invite.Visible = false
    Dissolve.Visible = Visible2
    Leave.Visible = Visible3
    local Customize = Table6.customize
    Customize.Visible = Clan.chef

    if Clan.chef then
        local Enabled = Count < Max2 and true or false
        local Normal = Invite:FindFirstChild( "Normal" )
        local Off = Invite:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = Enabled
        end
        if Off then
            Off.Enabled = not Enabled
        end

        Invite.AutoButtonColor = Enabled
        Invite:SetAttribute( "On", Enabled )
        Invite.Text.Text = "INVITE PLAYERS"
    end
end

Storage.Callback5 = nil
Storage.Callback6 = nil

Storage.RenderInvitePage = function()
    local Table = { }
    local Lower = ( SearchBox.Text:match( "^%s*@?(.-)%s*$" ) or "" ):lower( )

    for Key, Value in Players:GetPlayers( ) do
        if Value ~= LocalPlayer then
            if Lower == "" or Value.DisplayName:lower( ):find( Lower, 1, true ) or Value.Name:lower( ):find( Lower, 1, true ) then
                table.insert( Table, Value )
            end
        end
    end

    local Number
    table.sort( Table, function( Player, Player2 )
        local Flag = Player.DisplayName:lower( ) < Player2.DisplayName:lower( ) and true or false
        return Flag
    end )
    local Count = #Table
    Number = not Flag and 5 or 4
    local Value1
    List.CanvasSize = UDim2.fromScale( 0, math.max( 1, Count / Number ) * List.Size.Y.Scale )
    local IdOf = ClanShared.IdOf( LocalPlayer )
    Value1 = nil

    for Key2, Value2 in Table, nil, nil do
        local Number2 = not Flag and 5 or 4
        local Text2Inner
        local Value3, Value4 = Storage.AddRow( List, "PlayerRow", Key2, Count, Number2 )
        Value3.Name = "Player_" .. Value2.UserId
        local Avatar = Value4.Avatar
        Avatar.Image = ( "rbxthumb://type=AvatarHeadShot&id=%d&w=60&h=60" ):format( Value2.UserId )
        local PlayerName = Value4.PlayerName
        local Gsub = tostring( Value2.DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
        PlayerName.Text = Gsub .. " <font color=\"#c4b0b6\">@" .. tostring( Value2.Name ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) .. "</font>"
        local IdOf2 = ClanShared.IdOf( Value2 )
        local Info = Value4.Info

        if IdOf2 == nil then
            Text2Inner = ""
        elseif IdOf2 == IdOf then
            Text2Inner = "In your clan"
        else
            Text2Inner = "In a clan " .. ClanShared.TagRich( Value2:GetAttribute( "ClanTag" ) or "?", Value2:GetAttribute( "ClanColor" ) )
        end

        Info.Text = Text2Inner

        if IdOf2 == nil then
            local PlayerName2 = Value4.PlayerName
            PlayerName2.Position = UDim2.fromScale( Value4.PlayerName.Position.X.Scale, 0.26 )
        end

        local FlagInner

        if IdOf2 == nil then
            local Entry = Storage.Table11[ Value2.UserId ] or 0

            if os.clock( ) < Entry then
                FlagInner = true
            else
                FlagInner = false
            end
        else
            FlagInner = false
        end

        local Enabled
        local View = Value4.View
        Enabled = if IdOf2 == nil then not FlagInner else false
        local Text3

        if FlagInner then
            Text3 = "SENT"
        elseif IdOf2 == nil then
            Text3 = "INVITE"
        else
            Text3 = "VIEW"
        end

        local Normal = View:FindFirstChild( "Normal" )
        local Off = View:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = Enabled
        end
        if Off then
            Off.Enabled = not Enabled
        end

        View.AutoButtonColor = Enabled
        View:SetAttribute( "On", Enabled )

        if Text3 then
            View.Text.Text = Text3
        end

        Value4.View.Activated:Connect( function()
            Storage.Callback6( Value2 )
        end )
    end

    local Visible = Count == 0 and true or false
    local Text
    Empty.Visible = Visible

    if Lower ~= "" or not Text2 then
        Text = ( "Nobody named \"%s\" in this server: press SEARCH to look everywhere" ):format( Lower )
    else
        Text = Text2
    end

    Empty.Text = Text
end

Storage.RenderInvites = function()
    local Invites2

    if Storage.Value6 then
        local Invites = Storage.Value6.invites

        if Invites then
            Invites2 = Invites
        else
            Invites2 = { }
        end
    else
        Invites2 = { }
    end

    local Number
    local Count = #Invites2
    Number = not Flag and 4 or 3
    local Value1
    List2.CanvasSize = UDim2.fromScale( 0, math.max( 1, Count / Number ) * List2.Size.Y.Scale )
    Value1 = nil

    for Key, Value in Invites2, nil, nil do
        local Number4 = not Flag and 4 or 3
        local Text3
        local Value2, Value3 = Storage.AddRow( List2, "InviteRow", Key, Count, Number4 )
        Value2.Name = "Invite_" .. Value.id
        local Tag = Value3.Plate.Tag
        Tag.Text = Value.ct or "?"
        Storage.PaintPlate( Value3.Plate, Value.cc )
        local Th = Value.th
        Value3.BackgroundColor3 = ClanShared.ThemeDef( Th ).c
        local Plate = Value3.Plate
        local Table = { Value3.ClanName, Value3.From }
        local Number5 = 0.585

        local function Place()
            local X = Value3.AbsoluteSize.X

            if X <= 0 then
                return
            end

            local Value1
            local X2 = ( Plate.AbsolutePosition.X + Plate.AbsoluteSize.X - Value3.AbsolutePosition.X ) / X + 0.02
            Value1 = nil

            for Key, Value in Table, nil, nil do
                Value.Position = UDim2.fromScale( X2, Value.Position.Y.Scale )
                Value.Size = UDim2.fromScale( math.max( 0.05, Number5 - X2 ), Value.Size.Y.Scale )
            end
        end

        Value3:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Place )
        task.defer( Place )
        local ClanName = Value3.ClanName
        ClanName.Text = Value.cn or "Clan"
        local From = Value3.From
        local Gsub = tostring( Value.fn or "?" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
        local Max2 = math.max( 0, ( math.floor( tonumber( Value.left ) or 0 ) ) )

        if Max2 >= 172800 then
            Text3 = math.ceil( Max2 / 86400 ) .. " days"
        elseif Max2 >= 3600 then
            Text3 = math.ceil( Max2 / 3600 ) .. " h"
        else
            Text3 = math.max( 1, ( math.ceil( Max2 / 60 ) ) ) .. " min"
        end

        From.Text = ( "from <b>%s</b> · %s left" ):format( Gsub, Text3 )
        local Id = Value.id
        local Accept = Value3.Accept
        Accept.Activated:Connect( function()
            local Flag = Accept:GetAttribute( "On" ) ~= false and true or false

            if Flag then
                ClanRemote:FireServer( "respond", Id, true )
            end
        end )
        Value3.Decline.Activated:Connect( function()
            ClanRemote:FireServer( "respond", Id, false )
        end )

        if not Storage.Value6.clan then
            if not ( ( tonumber( Storage.Value6.cooldown ) or 0 ) > 0 ) or Value.same then
                continue
            end
        end

        local Normal = Accept:FindFirstChild( "Normal" )
        local Off = Accept:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = false
        end
        if Off then
            Off.Enabled = true
        end

        Accept.AutoButtonColor = false
        Accept:SetAttribute( "On", false )
        Accept.Text.Text = "ACCEPT"
    end

    local Visible = Count == 0 and true or false
    local Captured
    Empty2.Visible = Visible

    if Storage.Value6 then
        if Storage.Value6.clan == nil then
            Captured = false
        elseif Count > 0 then
            Captured = true
        else
            Captured = false
        end
    else
        Captured = Storage.Value6
    end

    local Number3

    if Storage.Value6 then
        local Number2 = tonumber( Storage.Value6.cooldown )

        if Number2 then
            Number3 = Number2
        else
            Number3 = 0
        end
    else
        Number3 = 0
    end

    local NotCaptured2
    local NotCaptured = not Captured

    if NotCaptured then
        if Number3 > 0 then
            if Count > 0 then
                NotCaptured2 = true
            else
                NotCaptured2 = false
            end
        else
            NotCaptured2 = false
        end
    else
        NotCaptured2 = NotCaptured
    end

    local Text2

    if Captured then
        Text2 = "Leave your clan to accept one"
    elseif NotCaptured2 then
        local TextInner
        local Max = math.max( 0, ( math.floor( tonumber( Number3 ) or 0 ) ) )

        if Max >= 172800 then
            TextInner = math.ceil( Max / 86400 ) .. " days"
        elseif Max >= 3600 then
            TextInner = math.ceil( Max / 3600 ) .. " h"
        else
            TextInner = math.max( 1, ( math.ceil( Max / 60 ) ) ) .. " min"
        end

        local Format = ( "You can join another clan in %s" ):format( TextInner )

        if Format then
            Text2 = Format
        else
            Text2 = Text
        end
    else
        Text2 = Text
    end

    local TextColor3Inner
    Hint.Text = Text2

    if Captured or NotCaptured2 then
        local FromRGB = Color3.fromRGB( 255, 176, 80 )

        if FromRGB then
            TextColor3Inner = FromRGB
        else
            TextColor3Inner = TextColor3
        end
    else
        TextColor3Inner = TextColor3
    end

    Hint.TextColor3 = TextColor3Inner
end

Storage.Card2 = MyRow.Card
Storage.Plate = MyRow.Card.Plate
Storage.AfterPlate( Storage.Card2, Storage.Plate, { MyRow.Card.NameRow }, 0.75 )
Storage.NameRow3 = MyRow.Card.NameRow
Storage.NameRow3:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
    local ClanName = Storage.NameRow3.ClanName
    Storage.FitLine( Storage.NameRow3, ClanName, Storage.NameRow3.Award, 0.7 )
end )

Storage.RenderBoard = function()
    local Value2
    local JSONDecode = HttpService.JSONDecode

    if ClanBoardData.Value == "" then
        Value2 = "{}"
    else
        local Value = ClanBoardData.Value

        if Value then
            Value2 = Value
        else
            Value2 = "{}"
        end
    end

    local BoardTop
    local Success, Result = pcall( JSONDecode, HttpService, Value2 )
    BoardTop = Success and type( Result ) == "table" and type( Result.top ) == "table" and Result.top or { }
    local S
    Table7.boardTop = BoardTop
    S = Success and Result.s or ClanShared.SEASON
    local Value1, Value7
    Season2.Text = SeasonText( S )
    local IdOf = ClanShared.IdOf( LocalPlayer )
    local Count = #BoardTop
    Value1 = nil

    for Key, Value3 in BoardTop, nil, nil do
        if Value3.id == IdOf then
            Value7 = Key
            break
        end

        Value7 = nil
    end

    local Visible = Count > 0 and true or false
    local Value4
    Podium.Visible = Visible
    Value4 = nil

    for Key2, Value5 in Table3, nil, nil do
        local Text2
        local Entry2 = BoardTop[ Key2 ]
        local ClanName4 = Value5.ClanName

        if Entry2 then
            local N = Entry2.n

            if N then
                Text2 = N
            else
                Text2 = "Clan"
            end
        else
            Text2 = "—"
        end

        local Visible6
        ClanName4.Text = Text2
        local Plate2 = Value5.Plate
        Visible6 = Entry2 ~= nil and true or false
        Plate2.Visible = Visible6

        if Entry2 then
            local Tag3 = Value5.Plate.Tag
            Tag3.Text = Entry2.t or "?"
            Storage.PaintPlate( Value5.Plate, Entry2.c )
        end

        local Text4
        local Kills3 = Value5.Kills

        if Entry2 then
            local Text3 = Storage.Num( Entry2.k ) .. " KILLS"

            if Text3 then
                Text4 = Text3
            else
                Text4 = ""
            end
        else
            Text4 = ""
        end

        local Visible7
        Kills3.Text = Text4
        local Hit = Value5.Hit
        Visible7 = Entry2 ~= nil and true or false
        local ImageTransparency
        Hit.Visible = Visible7
        local Emblem = Value5.Emblem
        ImageTransparency = not Entry2 and 0.75 or 0
        local FlagInner
        Emblem.ImageTransparency = ImageTransparency

        if Entry2 == nil then
            FlagInner = false
        elseif Entry2.id == IdOf then
            FlagInner = true
        else
            FlagInner = false
        end

        local Color
        local Mine2 = Value5.Pedestal.Mine

        if FlagInner then
            local FromRGB = Color3.fromRGB( 255, 202, 86 )

            if FromRGB then
                Color = FromRGB
            else
                Color = Color3.new( 1, 1, 1 )
            end
        else
            Color = Color3.new( 1, 1, 1 )
        end

        local Transparency
        Mine2.Color = Color
        local Mine3 = Value5.Pedestal.Mine
        Transparency = not FlagInner and 0.5 or 0
        Mine3.Transparency = Transparency
    end

    local Visible2

    if IdOf == nil then
        Visible2 = false
    elseif Storage.Value6 == nil then
        Visible2 = false
    elseif Storage.Value6.clan == nil then
        Visible2 = false
    elseif Value7 == nil then
        Visible2 = true
    elseif Value7 > 7 then
        Visible2 = true
    else
        Visible2 = false
    end

    local Captured
    MyRow.Visible = Visible2
    local Scale = List3.Size.X.Scale
    Captured = Visible2 and Scale4 or Scale3
    List3.Size = UDim2.fromScale( Scale, Captured )

    if Visible2 then
        local Rank2
        local Clan = Storage.Value6.clan
        local Card = MyRow.Card
        Rank2 = if Value7 then Value7 else Clan.rank
        local Text
        local Rank = Card.Rank
        Text = Rank2 and "#" .. Rank2 or "-"
        local K2
        Rank.Text = Text
        local Tag = Card.Plate.Tag
        Tag.Text = Clan.tag
        Storage.PaintPlate( Card.Plate, Clan.shown )
        local ClanName = Card.NameRow.ClanName
        ClanName.Text = Clan.name
        local Kills = Card.Kills

        if Value7 then
            local K = BoardTop[ Value7 ].k

            if K then
                K2 = K
            else
                K2 = Clan.kills
            end
        else
            K2 = Clan.kills
        end

        local Award4
        Kills.Text = Storage.Num( K2 )
        local Award = Clan.award

        if Award then
            local Clan3
            local Award2 = Clan.award
            local Clan2 = BadgeCatalog.ById.Clan

            if Clan2 then
                local Tiers = Clan2.tiers

                if Tiers then
                    Clan3 = Clan2.tiers[ tonumber( Award2 ) or 0 ]
                else
                    Clan3 = Tiers
                end
            else
                Clan3 = Clan2
            end
            if Clan3 then
                local LogoImage = BadgeCatalog.LogoImage( Clan2, Clan3 )

                if LogoImage then
                    Award4 = LogoImage
                else
                    Award4 = nil
                end
            else
                Award4 = nil
            end
        else
            Award4 = Award
        end

        local Visible3
        local Award3 = Card.NameRow.Award
        Award3.Image = Award4 or ""
        local Award5 = Card.NameRow.Award
        Visible3 = Award4 ~= nil and true or false
        Award5.Visible = Visible3
        local NameRow = Card.NameRow
        local ClanName2 = Card.NameRow.ClanName
        task.defer( Storage.FitLine, NameRow, ClanName2, Card.NameRow.Award, 0.7 )
    end

    local Number
    local Max = math.max( 0, Count - 3 )

    if Visible2 then
        Number = 2
    elseif Flag then
        Number = 3
    else
        Number = 4
    end

    List3.CanvasSize = UDim2.fromScale( 0, math.max( 1, Max / Number ) * List3.Size.Y.Scale )

    if Table7.boardBar == nil then
        Table7.boardBar = List3.ScrollBarImageTransparency
    end

    local ScrollingEnabled = Number < Max and true or false
    local ScrollBarImageTransparency
    List3.ScrollingEnabled = ScrollingEnabled

    if Number < Max then
        local BoardBar = Table7.boardBar

        if BoardBar then
            ScrollBarImageTransparency = BoardBar
        else
            ScrollBarImageTransparency = 1
        end
    else
        ScrollBarImageTransparency = 1
    end

    List3.ScrollBarImageTransparency = ScrollBarImageTransparency
    local I = 4

    for I = 4, Count do
        local A3
        local Entry = BoardTop[ I ]
        local _, Value6 = Storage.AddRow( List3, "BoardRow", I - 3, Max, Number )
        local Rank3 = Value6.Rank
        Rank3.Text = "#" .. I
        local Tag2 = Value6.Plate.Tag
        Tag2.Text = Entry.t or "?"
        Storage.PaintPlate( Value6.Plate, Entry.c )
        local H = Entry.h
        Value6.BackgroundColor3 = ClanShared.ThemeDef( H ).c
        local NameRow2 = Value6.NameRow
        local Plate = Value6.Plate
        local Table = { NameRow2 }
        local Number2 = 0.75

        local function Place()
            local X = Value6.AbsoluteSize.X

            if X <= 0 then
                return
            end

            local Value1
            local X2 = ( Plate.AbsolutePosition.X + Plate.AbsoluteSize.X - Value6.AbsolutePosition.X ) / X + 0.02
            Value1 = nil

            for Key, Value in Table, nil, nil do
                Value.Position = UDim2.fromScale( X2, Value.Position.Y.Scale )
                Value.Size = UDim2.fromScale( math.max( 0.05, Number2 - X2 ), Value.Size.Y.Scale )
            end
        end

        Value6:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Place )
        task.defer( Place )
        local ClanName3 = NameRow2.ClanName
        ClanName3.Text = Entry.n or "Clan"
        local Kills2 = Value6.Kills
        Kills2.Text = Storage.Num( Entry.k )
        local A = Entry.a

        if A then
            local Clan5
            local A2 = Entry.a
            local Clan4 = BadgeCatalog.ById.Clan

            if Clan4 then
                local Tiers2 = Clan4.tiers

                if Tiers2 then
                    Clan5 = Clan4.tiers[ tonumber( A2 ) or 0 ]
                else
                    Clan5 = Tiers2
                end
            else
                Clan5 = Clan4
            end
            if Clan5 then
                local LogoImage2 = BadgeCatalog.LogoImage( Clan4, Clan5 )

                if LogoImage2 then
                    A3 = LogoImage2
                else
                    A3 = nil
                end
            else
                A3 = nil
            end
        else
            A3 = A
        end

        local Visible4
        local Award6 = NameRow2.Award
        Award6.Image = A3 or ""
        local Award7 = NameRow2.Award
        Visible4 = A3 ~= nil and true or false
        local Enabled
        Award7.Visible = Visible4
        local Mine = Value6.Mine
        Enabled = Entry.id == IdOf and true or false
        Mine.Enabled = Enabled
        Value6.Hit.Activated:Connect( function()
            Table7.openRank( I )
        end )

        local function Fit()
            local ClanName = NameRow2:FindFirstChild( "ClanName" )
            local Award = NameRow2:FindFirstChild( "Award" )

            if ClanName and Award then
                Storage.FitLine( NameRow2, ClanName, Award, 0.7 )
            end
        end

        NameRow2:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Fit )
        task.defer( Fit )
    end

    local Visible5 = Count == 0 and true or false
    Empty3.Visible = Visible5
end

Storage.Swatches = Table7.swatches
Storage.Table13 = {
    grey = Color3.fromRGB( 184, 174, 182 ),
    white = Color3.new( 1, 1, 1 ),
    amber = Color3.fromRGB( 255, 190, 90 ),
    green = Color3.fromRGB( 110, 224, 140 ),
    red = Color3.fromRGB( 255, 120, 120 )
}

Storage.BaseOf = function( Argument1 )
    local Special = Argument1.special and Argument1.unlocked and Argument1.unlocked[ Argument1.special ] and Argument1.special or nil
    return { color = Argument1.color, special = Special, theme = Argument1.theme }
end

Storage.Typed = function( Argument1 )
    local Flag
    local Match = Table6.name.Text:match( "^%s*(.-)%s*$" )
    local Text = Table6.tag.Text
    local Len = utf8.len( Match ) or 0

    if Match == Argument1.name then
        if Text == Argument1.tag then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = true
    end

    local Flag2

    if ClanShared.NAME_MIN <= Len then
        if Len <= ClanShared.NAME_MAX then
            if #Text == ClanShared.TAG_LEN then
                Flag2 = true
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end

    return Flag, Flag2, Match, Text, Len
end

Storage.SecondsLeft = function( Text )
    local Clock2
    local Number = tonumber( Text ) or 0
    local Clock = os.clock( )

    if Storage.Value6 then
        local At = Storage.Value6.at

        if At then
            Clock2 = At
        else
            Clock2 = os.clock( )
        end
    else
        Clock2 = os.clock( )
    end

    return Number - ( Clock - Clock2 )
end

function Table7.changed()
    local Draft = Table7.draft

    if not ( Storage.Value6 and Storage.Value6.clan ) or not Draft then
        return false, false
    end

    local Special = ( Storage.Value6 and Storage.Value6.clan ).special and ( Storage.Value6 and Storage.Value6.clan ).unlocked and ( Storage.Value6 and Storage.Value6.clan ).unlocked[ ( Storage.Value6 and Storage.Value6.clan ).special ] and ( Storage.Value6 and Storage.Value6.clan ).special or nil
    local Flag
    local Table = {
        color = ( Storage.Value6 and Storage.Value6.clan ).color,
        special = Special,
        theme = ( Storage.Value6 and Storage.Value6.clan ).theme
    }

    if Draft.color == Table.color then
        if Draft.special == Table.special then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = true
    end

    local Flag2 = Draft.theme ~= Table.theme and true or false
    return Flag, Flag2
end
function Table7.first()
    local Draft2
    local Draft = Table7.draft
    Draft2 = if Draft then Draft else { }

    if Table7.sec == "name" then
        return Table6.name
    end
    if Table7.sec == "banner" then
        local Btn
        local Entry = Storage.Swatches.theme[ Draft2.theme or "" ]
        Btn = Entry and Entry.btn or Table6.tabs.banner
        return Btn
    end
    local Entry3
    local Entry2 = Storage.Swatches.special[ Draft2.special or "" ]
    Entry3 = if Entry2 then Entry2 else Storage.Swatches.color[ Draft2.color or "" ]
    local Btn2 = Entry3 and Entry3.btn or Table6.tabs.color
    return Btn2
end
function Table7.build()
    if Table7.built then
        return
    end

    local Value1
    Table7.built = true
    local COLORS = ClanShared.COLORS
    Value1 = nil

    for Key, Value in COLORS, nil, nil do
        local Clone3 = Table4.ColorCell:Clone( )
        Clone3.Name = Value.id
        Clone3.LayoutOrder = Key
        local Swatch = Clone3.Swatch
        Swatch.BackgroundColor3 = Value.c
        local ColorName2 = Clone3.ColorName
        ColorName2.Text = Value.name
        Clone3.Parent = Table6.palette
        Storage.Swatches.color[ Value.id ] = {
            btn = Clone3,
            sel = Clone3.Swatch.Sel,
            pop = Clone3.Swatch.Pop,
            lbl = Clone3.ColorName
        }
        Clone3.Activated:Connect( function()
            if Table7.draft then
                local Draft = Table7.draft
                local Draft2 = Table7.draft
                Draft.color = Value.id
                Draft2.special = nil
                Table7.paint( )
                return
            end
            return
        end )
    end

    local Value2
    local SPECIALS = ClanShared.SPECIALS
    Value2 = nil

    for Key2, Value3 in SPECIALS, nil, nil do
        local Clone2 = Table4.SpecialCard:Clone( )
        Clone2.Name = Value3.id
        Clone2.LayoutOrder = Key2
        local Fill = Clone2.Band.Fill
        Fill.Color = ClanShared.GradientOf( Value3.id )
        Storage.Table10[ Clone2.Band.Fill ] = Value3.id
        local ColorName = Clone2.ColorName
        ColorName.Text = Value3.name
        Clone2.Parent = Table6.specials
        Storage.Swatches.special[ Value3.id ] = {
            btn = Clone2,
            sel = Clone2.Sel,
            shade = Clone2.Band.Shade,
            req = Clone2.Req,
            rank = Value3.rank
        }
        Clone2.Activated:Connect( function()
            if not ( Storage.Value6 and Storage.Value6.clan ) or not Table7.draft then
                return
            end
            if not ( Storage.Value6 and Storage.Value6.clan ).unlocked or not ( Storage.Value6 and Storage.Value6.clan ).unlocked[ Value3.id ] then
                Notify.Error( ( "Reach the top %d of the clan leaderboard to unlock %s" ):format( Value3.rank, Value3.name ) )
                return
            end
            local Draft = Table7.draft
            Draft.special = Value3.id
            Table7.paint( )
            return
        end )
    end

    local Value4
    local THEMES = ClanShared.THEMES
    Value4 = nil

    for Key3, Value5 in THEMES, nil, nil do
        local Clone = Table4.ThemeCell:Clone( )
        Clone.Name = Value5.id
        Clone.LayoutOrder = Key3
        local Mini = Clone.Mini
        Mini.ImageColor3 = Value5.c
        local ThemeName = Clone.ThemeName
        ThemeName.Text = Value5.name
        Clone.Parent = Table6.themes
        Storage.Swatches.theme[ Value5.id ] = { btn = Clone, sel = Clone.Mini.Sel, lbl = Clone.ThemeName }
        Clone.Activated:Connect( function()
            if Table7.draft then
                local Draft = Table7.draft
                Draft.theme = Value5.id
                Table7.paint( )
                return
            end
            return
        end )
    end

    Storage.ApplyType( Window, Table6.page )
end
function Table7.paint()
    local Draft = Table7.draft

    if not ( Storage.Value6 and Storage.Value6.clan ) or not Draft then
        return
    end

    local Value1
    local Sec = Table7.sec
    local Tabs = Table6.tabs
    Value1 = nil

    for Key, Value in Tabs, nil, nil do
        local Enabled5 = Key == Sec and true or false
        local Normal5 = Value:FindFirstChild( "Normal" )
        local Selected = Value:FindFirstChild( "Selected" )

        if Normal5 and Normal5:IsA( "UIGradient" ) then
            Normal5.Enabled = not Enabled5
        end
        if Selected and Selected:IsA( "UIGradient" ) then
            Selected.Enabled = Enabled5
        end

        local Visible6
        local Entry = Table6.secs[ Key ]
        Visible6 = Key == Sec and true or false
        Entry.Visible = Visible6
    end

    local Value2
    local Color = Storage.Swatches.color
    Value2 = nil

    for Key2, Value3 in Color, nil, nil do
        local Enabled4

        if Draft.special == nil then
            if Draft.color == Key2 then
                Enabled4 = true
            else
                Enabled4 = false
            end
        else
            Enabled4 = false
        end

        local Scale
        Value3.sel.Enabled = Enabled4
        local Pop = Value3.pop
        Scale = not Enabled4 and 1 or 1.12
        local TextColor35
        Pop.Scale = Scale
        local Lbl2 = Value3.lbl

        if Enabled4 then
            local White2 = Storage.Table13.white

            if White2 then
                TextColor35 = White2
            else
                TextColor35 = Storage.Table13.grey
            end
        else
            TextColor35 = Storage.Table13.grey
        end

        Lbl2.TextColor3 = TextColor35
    end

    local Value4
    local Special = Storage.Swatches.special
    Value4 = nil

    for Key3, Value5 in Special, nil, nil do
        local Flag

        if ( Storage.Value6 and Storage.Value6.clan ).unlocked == nil then
            Flag = false
        elseif ( Storage.Value6 and Storage.Value6.clan ).unlocked[ Key3 ] == true then
            Flag = true
        else
            Flag = false
        end

        local Enabled3
        local Sel = Value5.sel
        Enabled3 = Draft.special == Key3 and true or false
        local Text7
        Sel.Enabled = Enabled3
        local Shade = Value5.shade
        Shade.Visible = not Flag
        local Req = Value5.req

        if Flag then
            Text7 = "UNLOCKED"
        else
            Text7 = ( "Reach top %d" ):format( Value5.rank )
        end

        local TextColor34
        Req.Text = Text7
        local Req2 = Value5.req

        if Flag then
            local Green = Storage.Table13.green

            if Green then
                TextColor34 = Green
            else
                TextColor34 = Storage.Table13.grey
            end
        else
            TextColor34 = Storage.Table13.grey
        end

        Req2.TextColor3 = TextColor34
    end

    local Value6
    local Theme = Storage.Swatches.theme
    Value6 = nil

    for Key4, Value7 in Theme, nil, nil do
        local Enabled2 = Draft.theme == Key4 and true or false
        local TextColor33
        Value7.sel.Enabled = Enabled2
        local Lbl = Value7.lbl

        if Enabled2 then
            local White = Storage.Table13.white

            if White then
                TextColor33 = White
            else
                TextColor33 = Storage.Table13.grey
            end
        else
            TextColor33 = Storage.Table13.grey
        end

        Lbl.TextColor3 = TextColor33
    end

    local TagShown
    local Visible, Value8, Value9, Value10, Value11 = Storage.Typed( Storage.Value6 and Storage.Value6.clan )
    TagShown = #Value10 == ClanShared.TAG_LEN and Value10 or ( Storage.Value6 and Storage.Value6.clan ).tag
    local Special3
    Table7.tagShown = TagShown
    local Special2 = Draft.special
    Special3 = if Special2 then Special2 else Draft.color
    local Text
    local Banner = Table6.banner
    local Theme2 = Draft.theme
    Banner.ImageColor3 = ClanShared.ThemeDef( Theme2 ).c
    Table6.banner.Plate.Tag.Text = TagShown
    local ClanName = Table6.banner.ClanName
    Text = ClanShared.NAME_MIN <= Value11 and Value9 or ( Storage.Value6 and Storage.Value6.clan ).name
    local Clock2
    ClanName.Text = Text
    Storage.PaintPlate( Table6.banner.Plate, Special3 )
    local Tag = Table6.nomPlate.Tag
    Tag.Text = "[" .. TagShown .. "]"
    Storage.PaintPlate( Table6.nomPlate, Special3 )
    local Nom = Table6.nom
    Nom.Text = tostring( LocalPlayer.DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    local Chat = Table6.chat
    local TagRich = ClanShared.TagRich( TagShown, Special3 )
    Chat.Text = TagRich .. " <font color=\"#ffffff\">" .. tostring( LocalPlayer.DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) .. ":</font> gg"
    local Visible2, Visible3 = Table7.changed( )
    Table6.tabs.color.Dot.Visible = Visible2
    Table6.tabs.banner.Dot.Visible = Visible3
    Table6.tabs.name.Dot.Visible = Visible
    local Number = tonumber( ( Storage.Value6 and Storage.Value6.clan ).renameIn ) or 0
    local Clock = os.clock( )

    if Storage.Value6 then
        local At = Storage.Value6.at

        if At then
            Clock2 = At
        else
            Clock2 = os.clock( )
        end
    else
        Clock2 = os.clock( )
    end

    local Text3
    local Number2 = Number - ( Clock - Clock2 )
    local NameCount = Table6.nameCount
    NameCount.Text = ( "%d/%d" ):format( Value11, ClanShared.NAME_MAX )
    local TagCount = Table6.tagCount
    TagCount.Text = ( "%d/%d" ):format( #Value10, ClanShared.TAG_LEN )
    local RuleText = Table6.ruleText
    RuleText.Text = ( "You can rename your clan once every %d days." ):format( ClanShared.RENAME_DAYS )
    local RenameState = Table6.renameState

    if Number2 > 0 then
        local Text2
        local Max = math.max( 0, ( math.floor( tonumber( Number2 ) or 0 ) ) )

        if Max >= 172800 then
            Text2 = math.ceil( Max / 86400 ) .. " days"
        elseif Max >= 3600 then
            Text2 = math.ceil( Max / 3600 ) .. " h"
        else
            Text2 = math.max( 1, ( math.ceil( Max / 60 ) ) ) .. " min"
        end

        local Format = ( "Next rename in %s" ):format( Text2 )

        if Format then
            Text3 = Format
        else
            Text3 = "Available now"
        end
    else
        Text3 = "Available now"
    end

    local TextColor3
    RenameState.Text = Text3
    local RenameState2 = Table6.renameState

    if Number2 > 0 then
        local Amber = Storage.Table13.amber

        if Amber then
            TextColor3 = Amber
        else
            TextColor3 = Storage.Table13.green
        end
    else
        TextColor3 = Storage.Table13.green
    end

    local Visible4
    RenameState2.TextColor3 = TextColor3
    Visible4 = Sec == "name" and true or false
    local Text5, TextColor32
    local Save = Table6.save
    local Rename = Table6.rename
    Save.Visible = not Visible4
    Rename.Visible = Visible4

    if Visible4 then
        local Enabled
        local Rename2 = Table6.rename

        if Number2 <= 0 then
            if Visible then
                Enabled = Value8
            else
                Enabled = Visible
            end
        else
            Enabled = false
        end

        local Normal = Rename2:FindFirstChild( "Normal" )
        local Off = Rename2:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = Enabled
        end
        if Off then
            Off.Enabled = not Enabled
        end

        Rename2.AutoButtonColor = Enabled
        Rename2:SetAttribute( "On", Enabled )
        Rename2.Text.Text = "RENAME"
        Table6.undo.Visible = Visible

        if Number2 > 0 then
            local Text4
            local Max2 = math.max( 0, ( math.floor( tonumber( Number2 ) or 0 ) ) )

            if Max2 >= 172800 then
                Text4 = math.ceil( Max2 / 86400 ) .. " days"
            elseif Max2 >= 3600 then
                Text4 = math.ceil( Max2 / 3600 ) .. " h"
            else
                Text4 = math.max( 1, ( math.ceil( Max2 / 60 ) ) ) .. " min"
            end

            Text5 = ( "Next rename in %s" ):format( Text4 )
            TextColor32 = Storage.Table13.amber
        elseif Visible then
            if Value8 then
                TextColor32 = Storage.Table13.green
                Text5 = "Ready to rename"
            else
                Text5 = ( "Name: %d to %d characters. Tag: %d." ):format( ClanShared.NAME_MIN, ClanShared.NAME_MAX, ClanShared.TAG_LEN )
                TextColor32 = Storage.Table13.red
            end
        else
            TextColor32 = Storage.Table13.grey
            Text5 = "Type a new name or tag"
        end
    else
        local Clock4
        local Visible5 = Visible2 or Visible3
        local Number3 = tonumber( ( Storage.Value6 and Storage.Value6.clan ).styleIn ) or 0
        local Clock3 = os.clock( )

        if Storage.Value6 then
            local At2 = Storage.Value6.at

            if At2 then
                Clock4 = At2
            else
                Clock4 = os.clock( )
            end
        else
            Clock4 = os.clock( )
        end

        local Ceil = math.ceil( Number3 - ( Clock3 - Clock4 ) )
        Table6.undo.Visible = Visible5

        if Visible5 then
            if Ceil > 0 then
                local Save3 = Table6.save
                local Text6 = ( "WAIT %ds" ):format( Ceil )
                local Normal3 = Save3:FindFirstChild( "Normal" )
                local Off3 = Save3:FindFirstChild( "Off" )

                if Normal3 then
                    Normal3.Enabled = false
                end
                if Off3 then
                    Off3.Enabled = true
                end

                Save3.AutoButtonColor = false
                Save3:SetAttribute( "On", false )

                if Text6 then
                    Save3.Text.Text = Text6
                end

                Text5 = ( "You can save again in %d s" ):format( Ceil )
                TextColor32 = Storage.Table13.amber
                Table7.tick = Table7.tick + 1
                local Tick = Table7.tick
                task.delay( 1, function()
                    if Tick == Table7.tick and Table7.on and Storage.Flag2 then
                        Table7.paint( )
                    end
                end )
            else
                local Save4 = Table6.save
                local Normal4 = Save4:FindFirstChild( "Normal" )
                local Off4 = Save4:FindFirstChild( "Off" )

                if Normal4 then
                    Normal4.Enabled = true
                end
                if Off4 then
                    Off4.Enabled = false
                end

                Save4.AutoButtonColor = true
                Save4:SetAttribute( "On", true )
                Save4.Text.Text = "SAVE"
                Text5 = "Not saved yet"
                TextColor32 = Storage.Table13.amber
            end
        else
            local Save2 = Table6.save
            local Normal2 = Save2:FindFirstChild( "Normal" )
            local Off2 = Save2:FindFirstChild( "Off" )

            if Normal2 then
                Normal2.Enabled = false
            end
            if Off2 then
                Off2.Enabled = true
            end

            Save2.AutoButtonColor = false
            Save2:SetAttribute( "On", false )
            Save2.Text.Text = "SAVED"
            TextColor32 = Storage.Table13.grey
            Text5 = "All changes saved"
        end
    end

    local Status = Table6.status
    local Status2 = Table6.status
    Status.Text = Text5
    Status2.TextColor3 = TextColor32
end
function Table7.render()
    local Clan = Storage.Value6.clan
    Table7.build( )

    if not Table7.draft then
        local Special = Clan.special and Clan.unlocked and Clan.unlocked[ Clan.special ] and Clan.special or nil
        Table7.draft = { color = Clan.color, special = Special, theme = Clan.theme }
        local Name = Table6.name
        local Tag = Table6.tag
        local Text = Clan.name
        local Text2 = Clan.tag
        Name.Text = Text
        Tag.Text = Text2
    end

    Table7.paint( )
end
function Table7.undo()
    if not ( Storage.Value6 and Storage.Value6.clan ) or not Table7.draft then
        return
    end
    if Table7.sec == "name" then
        local Name = Table6.name
        local Tag = Table6.tag
        local Text = ( Storage.Value6 and Storage.Value6.clan ).name
        local Text2 = ( Storage.Value6 and Storage.Value6.clan ).tag
        Name.Text = Text
        Tag.Text = Text2
    else
        local Special = ( Storage.Value6 and Storage.Value6.clan ).special and ( Storage.Value6 and Storage.Value6.clan ).unlocked and ( Storage.Value6 and Storage.Value6.clan ).unlocked[ ( Storage.Value6 and Storage.Value6.clan ).special ] and ( Storage.Value6 and Storage.Value6.clan ).special or nil
        Table7.draft = {
            color = ( Storage.Value6 and Storage.Value6.clan ).color,
            special = Special,
            theme = ( Storage.Value6 and Storage.Value6.clan ).theme
        }
    end

    Table7.paint( )
end
function Table7.leave()
    local function Go()
        Table7.on = false
        Table7.draft = nil
        Storage.Callback2( )
        local Refresh = GamepadNav.Refresh
        Refresh( "Clan", Storage.Callback3( ) )
    end

    local Changed, Changed2 = Table7.changed( )

    if not Changed and not Changed2 then
        if ( Storage.Value6 and Storage.Value6.clan ) == nil or not Storage.Typed( Storage.Value6 and Storage.Value6.clan ) then
            Table7.on = false
            Table7.draft = nil
            Storage.Callback2( )
            local Refresh = GamepadNav.Refresh
            Refresh( "Clan", Storage.Callback3( ) )
            return
        end
    end

    Storage.Ask( "DISCARD CHANGES?", "Your changes are not saved yet.", "DISCARD", Go )
end

Storage.Callback2 = function()
    if not Storage.Flag2 then
        return
    end

    local Name
    local SelectedObject = game:GetService( "GuiService" ).SelectedObject
    Name = SelectedObject and SelectedObject:IsDescendantOf( Table6.page ) and SelectedObject.Name or nil
    local Value1 = nil

    for Key, Value in Storage.Table12, nil, nil do
        Value:Destroy( )
    end

    local Count2
    table.clear( Storage.Table12 )

    if not Storage.Value6 or not Storage.Value6.invites then
        Count2 = 0
    else
        local CountInner = #Storage.Value6.invites

        if CountInner then
            Count2 = CountInner
        else
            Count2 = 0
        end
    end

    local Visible = Count2 > 0 and true or false
    local Value2
    Count.Visible = Visible
    local Texte = Count.Texte
    Texte.Text = tostring( Count2 )
    Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        local Enabled = Key2 == Storage.Text4 and true or false
        local Normal = Value3:FindFirstChild( "Normal" )
        local Selected = Value3:FindFirstChild( "Selected" )

        if Normal and Normal:IsA( "UIGradient" ) then
            Normal.Enabled = not Enabled
        end
        if Selected and Selected:IsA( "UIGradient" ) then
            Selected.Enabled = Enabled
        end
    end

    local Season2

    if Storage.Value6 then
        local Season = Storage.Value6.season

        if Season then
            Season2 = Season
        else
            Season2 = ClanShared.SEASON
        end
    else
        Season2 = ClanShared.SEASON
    end

    local Captured
    Title.Text = SeasonText( Season2 )

    if Storage.Value6 then
        if Storage.Value6.clan == nil then
            Captured = false
        else
            Captured = true
        end
    else
        Captured = Storage.Value6
    end
    if not Captured then
        Storage.Flag3 = false
    end
    if not Captured or not Storage.Value6.clan.chef then
        Table7.on = false
        Table7.draft = nil
    end

    local Visible2 = if Storage.Text4 == "clan" then not Captured else false
    local Visible3
    NoClan.Visible = Visible2

    if Storage.Text4 == "clan" then
        if Captured then
            local NotCaptured = not Storage.Flag3

            if NotCaptured then
                Visible3 = not Table7.on
            else
                Visible3 = NotCaptured
            end
        else
            Visible3 = Captured
        end
    else
        Visible3 = false
    end

    local Visible4
    InClan.Visible = Visible3

    if Storage.Text4 == "clan" then
        if Captured then
            Visible4 = Storage.Flag3
        else
            Visible4 = Captured
        end
    else
        Visible4 = false
    end

    local Visible5
    InvitePage.Visible = Visible4
    Visible5 = Storage.Text4 == "invites" and true or false
    local Visible6
    InvitesPage.Visible = Visible5
    Visible6 = if Storage.Text4 == "board" then not Table7.view.on else false
    local Visible7
    BoardPage.Visible = Visible6
    local Page = Table7.V.page
    Visible7 = if Storage.Text4 == "board" then Table7.view.on else false
    local Visible8
    Page.Visible = Visible7
    local Page2 = Table6.page

    if Storage.Text4 == "clan" then
        if Captured then
            Visible8 = Table7.on
        else
            Visible8 = Captured
        end
    else
        Visible8 = false
    end

    Page2.Visible = Visible8

    if NoClan.Visible then
        Storage.RenderNoClan( )
    end
    if InClan.Visible then
        Storage.RenderInClan( )
    end
    if InvitePage.Visible then
        Storage.RenderInvitePage( )
    end
    if InvitesPage.Visible then
        Storage.RenderInvites( )
    end
    if BoardPage.Visible then
        Storage.RenderBoard( )
    end
    if Table7.V.page.Visible then
        Table7.renderView( )
    end
    if Table6.page.Visible then
        Table7.render( )
    end
    if Storage.Flag4 and Storage.Value6 and not Storage.Value6.loading then
        Storage.Flag4 = false
        local Refresh = GamepadNav.Refresh
        Refresh( "Clan", Storage.Callback3( ) )
        return
    end
    if not Name or not Table6.page.Visible then
        GamepadNav.Refresh( "Clan" )
        return
    end
    local Refresh2 = GamepadNav.Refresh
    Refresh2( "Clan", Table6.page:FindFirstChild( Name, true ) )
    return
end

Storage.Flag6 = false

Callback = function()
    if Storage.Flag6 or not Storage.Flag2 then
        return
    end
    Storage.Flag6 = true
    task.defer( function()
        Storage.Flag6 = false
        Storage.Callback2( )
    end )
    return
end

Storage.Value9 = nil
function Table7.cardSourceOf( Argument1 )
    local Name2
    local Number = tonumber( Argument1.uid ) or 0
    local Name = Argument1.name

    if Name then
        Name2 = Name
    else
        local User = Argument1.user

        if User then
            Name2 = User
        else
            Name2 = "Player"
        end
    end

    local Stats2
    local User2 = Argument1.user or "player"
    local Configuration = Instance.new( "Configuration" )
    Configuration.Name = "ClanCardSource"
    local Stats = Argument1.stats
    Stats2 = if Stats then Stats else { }
    local Value1
    local Number2 = tonumber( Argument1.level ) or 1
    local Table = {
        DisplayName = Name2,
        UserName = User2,
        UserId = Number,
        Stat_Shots = Stats2.Shots or 0,
        Stat_Hits = Stats2.Hits or 0,
        Stat_Kills = Stats2.Kills or 0,
        Stat_Deaths = Stats2.Deaths or 0,
        Badges = Argument1.badges or "",
        Level = Number2,
        XP = tonumber( Argument1.xp ) or 0,
        XPNext = Levels.Need( Number2 ),
        ClanTag = Argument1.clanTag,
        ClanColor = Argument1.clanColor
    }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Configuration:SetAttribute( Key, Value )
    end

    Configuration.Parent = Get2

    if Storage.Value9 then
        Storage.Value9:Destroy( )
    end

    Storage.Value9 = Configuration
    return Configuration, Number, Name2, User2
end

Storage.HideCardView = function( Argument1 )
    if not Storage.Value8 then
        return
    end

    Storage.Value8 = nil
    Get2.Visible = false
    Invite2.Visible = true
    HideCard:Fire( )
    GamepadNav.Close( "ClanCard" )

    if Storage.Value9 then
        Storage.Value9:Destroy( )
        Storage.Value9 = nil
    end
    if Argument1 and Storage.Flag2 then
        Get.Visible = true
        Storage.Callback2( )
    end
end

Storage.Callback6 = function( Player, Result )
    if not Storage.Flag2 or not Storage.Value6 or not Storage.Value6.clan then
        return
    end

    local UserId, DisplayName, Name, CardSourceOf, Table

    if typeof( Player ) ~= "Instance" or not Player:IsA( "Player" ) then
        CardSourceOf, UserId, DisplayName, Name = Table7.cardSourceOf( Result or { } )
        Table = Result or { }
    else
        UserId = Player.UserId
        DisplayName = Player.DisplayName
        Name = Player.Name
        CardSourceOf = Player
        Table = Result
    end

    local IdOf2
    Storage.Value8 = { uid = UserId, name = DisplayName }
    Table7.cardTitle( false )
    Get.Visible = false
    Get2.Visible = true
    task.defer( Storage.ApplyType, Box2, Box2 )
    ShowCard:Fire( CardSourceOf )
    local Text = Storage.Value6.clan.tag
    local Text2 = Storage.Value6.clan.name
    Tag4.Text = Text
    ClanName2.Text = Text2
    Storage.PaintPlate( Tag4.Parent, Storage.Value6.clan.shown )
    Text3.Text = ( "Invite <b>%s</b> <font color=\"#c4b0b6\">@%s</font>?" ):format( tostring( DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ), ( tostring( Name ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) ) )

    if typeof( Player ) == "Instance" then
        local IdOf = ClanShared.IdOf( Player )

        if IdOf then
            IdOf2 = IdOf
        elseif Table then
            IdOf2 = Table.clanId
        else
            IdOf2 = Table
        end
    elseif Table then
        IdOf2 = Table.clanId
    else
        IdOf2 = Table
    end

    local Text3Inner, Flag

    if not IdOf2 or IdOf2 ~= Storage.Value6.clan.id then
        if IdOf2 then
            Text3Inner = "Already in another clan: they must leave it first"
            Flag = false
        elseif not Table or Table.played ~= false then
            local Max2
            local Count = #Storage.Value6.clan.members
            local Max = Storage.Value6.clan.max
            Max2 = if Max then Max else ClanShared.MAX_MEMBERS

            if Max2 <= Count then
                Text3Inner = "Your clan is full"
                Flag = false
            else
                Text3Inner = "Check the card: is it the right player?"
                Flag = true
            end
        else
            Text3Inner = "This player has never played the game"
            Flag = false
        end
    else
        Text3Inner = "Already in your clan"
        Flag = false
    end
    if Table and Table.studio then
        Text3Inner = Text3Inner .. " (Studio: test profile)"
    end

    local First
    Note.Text = Text3Inner
    Storage.Callback5( UserId, Flag )
    local Open = GamepadNav.Open
    local Table2 = { root = Box2, backLabel = "Back", freeze = true }
    First = Flag and Invite2 or Back2
    Table2.first = First
    function Table2.onBack()
        if not Storage.Value8 then
            return
        end

        Storage.Value8 = nil
        Get2.Visible = false
        Invite2.Visible = true
        HideCard:Fire( )
        GamepadNav.Close( "ClanCard" )

        if Storage.Value9 then
            Storage.Value9:Destroy( )
            Storage.Value9 = nil
        end
        if Storage.Flag2 then
            Get.Visible = true
            Storage.Callback2( )
        end
    end
    Open( "ClanCard", Table2 )
end

Storage.Callback5 = function( Key, Argument2 )
    if not Storage.Value8 or Storage.Value8.uid ~= Key or Storage.Value8.member then
        return
    end

    local Flag

    if Argument2 == nil then
        if Invite2:GetAttribute( "Can" ) == false then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = Argument2
    end

    Invite2:SetAttribute( "Can", Flag )
    local Entry = ( Storage.Table11[ Key ] or 0 ) - os.clock( )

    if Flag then
        if Entry > 0 then
            local Text = ( "SENT · %ds" ):format( ( math.ceil( Entry ) ) )
            local Normal2 = Invite2:FindFirstChild( "Normal" )
            local Off2 = Invite2:FindFirstChild( "Off" )

            if Normal2 then
                Normal2.Enabled = false
            end
            if Off2 then
                Off2.Enabled = true
            end

            Invite2.AutoButtonColor = false
            Invite2:SetAttribute( "On", false )

            if Text then
                Invite2.Text.Text = Text
                return
            end
        else
            local Normal3 = Invite2:FindFirstChild( "Normal" )
            local Off3 = Invite2:FindFirstChild( "Off" )

            if Normal3 then
                Normal3.Enabled = true
            end
            if Off3 then
                Off3.Enabled = false
            end

            Invite2.AutoButtonColor = true
            Invite2:SetAttribute( "On", true )
            Invite2.Text.Text = "INVITE"
        end

        return
    end
    local Normal = Invite2:FindFirstChild( "Normal" )
    local Off = Invite2:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = false
    end
    if Off then
        Off.Enabled = true
    end

    Invite2.AutoButtonColor = false
    Invite2:SetAttribute( "On", false )
    Invite2.Text.Text = "INVITE"
    return
end

Invite2.Activated:Connect( function()
    if Storage.Value8 then
        local Flag = Invite2:GetAttribute( "On" ) ~= false and true or false

        if Flag and not Storage.Value8.view then
            if Storage.Value8.member then
                Table7.join( Storage.Value8.uid )
                return
            end
            local Uid = Storage.Value8.uid
            Storage.Table11[ Uid ] = os.clock( ) + 2
            Storage.Callback5( Uid )
            ClanRemote:FireServer( "invite", Uid )
            return
        end
    end
end )
Back2.Activated:Connect( function()
    if not Storage.Value8 then
        return
    end

    Storage.Value8 = nil
    Get2.Visible = false
    Invite2.Visible = true
    HideCard:Fire( )
    GamepadNav.Close( "ClanCard" )

    if Storage.Value9 then
        Storage.Value9:Destroy( )
        Storage.Value9 = nil
    end
    if Storage.Flag2 then
        Get.Visible = true
        Storage.Callback2( )
    end
end )
CardClosed.Event:Connect( function()
    if Storage.Value8 then
        Storage.Value8 = nil
        Get2.Visible = false
        Invite2.Visible = true
        GamepadNav.Close( "ClanCard" )

        if Storage.Value9 then
            Storage.Value9:Destroy( )
            Storage.Value9 = nil
        end
        if Storage.Flag2 then
            Get.Visible = true
            Storage.Callback2( )
        end
    end
end )
Table7.MEMBER_NOTE = {
    me = "That's you",
    here = "In your server",
    off = "Offline",
    closed = "Online in a private server: can't join",
    err = "Couldn't check, try again",
    none = "Not in your clan anymore"
}
function Table7.cardTitle( Argument1 )
    local Title = Box2:FindFirstChild( "Title" )

    if not Title then
        return
    end
    if Title:GetAttribute( "BaseText" ) == nil then
        Title:SetAttribute( "BaseText", Title.Text )
    end

    local Text

    if Argument1 then
        Text = "CLAN MEMBER"
    else
        Text = Title:GetAttribute( "BaseText" )
    end

    Title.Text = Text
end
function Table7.memberNote( Argument1 )
    if Argument1.st == "join" then
        return ( "Online · %d/%d players · you can join" ):format( Argument1.n or 0, Argument1.max or 0 )
    end
    if Argument1.st == "full" then
        return ( "Online · session full (%d/%d)" ):format( Argument1.n or 0, Argument1.max or 0 )
    end

    local Entry2
    local Entry = Table7.MEMBER_NOTE[ Argument1.st ]
    Entry2 = if Entry then Entry else Table7.MEMBER_NOTE.err
    return Entry2
end
function Table7.memberCheck( Argument1 )
    task.spawn( function()
        local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "member", Argument1 )

        if not Storage.Value8 or not Storage.Value8.member or Storage.Value8.uid ~= Argument1 then
            return
        end

        local Result2 = ( not Success or type( Result ) ~= "table" ) and { st = "err" } or Result

        if type( Result2.card ) == "table" and not Storage.Value8.shown then
            Storage.Value8.shown = true
            ShowCard:Fire( ( Table7.cardSourceOf( Result2.card ) ) )
        end

        local Enabled
        Note.Text = Table7.memberNote( Result2 )
        Enabled = Result2.st == "join" and true or false
        local Normal = Invite2:FindFirstChild( "Normal" )
        local Off = Invite2:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = Enabled
        end
        if Off then
            Off.Enabled = not Enabled
        end

        local Captured
        Invite2.AutoButtonColor = Enabled
        Invite2:SetAttribute( "On", Enabled )
        Invite2.Text.Text = "JOIN"
        local Refresh = GamepadNav.Refresh
        Captured = Result2.st == "join" and Invite2 or Back2
        Refresh( "ClanCard", Captured )
    end )
end
function Table7.showMember( Member )
    if not Storage.Flag2 or not Storage.Value6 or not Storage.Value6.clan or Storage.Value8 then
        return
    end

    local Shown
    local Number = tonumber( Member.uid ) or 0
    local PlayerByUserId = Players:GetPlayerByUserId( Number )
    local Table = { uid = Number, name = Member.n, member = true }
    Shown = PlayerByUserId ~= nil and true or false
    local Text3Inner
    Table.shown = Shown
    Storage.Value8 = Table
    Table7.joinArm = 0
    Table7.cardTitle( true )
    Get.Visible = false
    Get2.Visible = true
    task.defer( Storage.ApplyType, Box2, Box2 )
    local Text = Storage.Value6.clan.tag
    local Text2 = Storage.Value6.clan.name
    Tag4.Text = Text
    ClanName2.Text = Text2
    Storage.PaintPlate( Tag4.Parent, Storage.Value6.clan.shown )
    local Gsub = tostring( Member.n ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    Text3Inner = not Member.chef and "" or "  ·  Leader"
    Text3.Text = ( "<b>%s</b>%s" ):format( Gsub, Text3Inner )
    local Normal = Invite2:FindFirstChild( "Normal" )
    local Off = Invite2:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = false
    end
    if Off then
        Off.Enabled = true
    end

    Invite2.AutoButtonColor = false
    Invite2:SetAttribute( "On", false )
    Invite2.Text.Text = "JOIN"

    if PlayerByUserId then
        local Text4
        ShowCard:Fire( PlayerByUserId )
        local MEMBER_NOTE = Table7.MEMBER_NOTE
        Text4 = Number ~= LocalPlayer.UserId and "here" or "me"
        Note.Text = MEMBER_NOTE[ Text4 ]
    else
        Note.Text = "Checking..."
        Table7.memberCheck( Number )
    end

    GamepadNav.Open( "ClanCard", {
        root = Box2,
        first = Back2,
        onBack = function()
            if not Storage.Value8 then
                return
            end

            Storage.Value8 = nil
            Get2.Visible = false
            Invite2.Visible = true
            HideCard:Fire( )
            GamepadNav.Close( "ClanCard" )

            if Storage.Value9 then
                Storage.Value9:Destroy( )
                Storage.Value9 = nil
            end
            if Storage.Flag2 then
                Get.Visible = true
                Storage.Callback2( )
            end
        end,
        backLabel = "Back",
        freeze = true
    } )
end
function Table7.join( Argument1 )
    local Clock = os.clock( )

    if ( Table7.joinArm or 0 ) < Clock then
        Table7.joinArm = Clock + 3
        local JoinArm = Table7.joinArm
        local Normal = Invite2:FindFirstChild( "Normal" )
        local Off = Invite2:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = true
        end
        if Off then
            Off.Enabled = false
        end

        Invite2.AutoButtonColor = true
        Invite2:SetAttribute( "On", true )
        Invite2.Text.Text = "CONFIRM?"
        Note.Text = "You will leave this server"
        task.delay( 3, function()
            if Table7.joinArm == JoinArm and Storage.Value8 and Storage.Value8.member and Storage.Value8.uid == Argument1 then
                Table7.joinArm = 0
                Table7.memberCheck( Argument1 )
            end
        end )
        return
    end
    Table7.joinArm = 0
    local Normal2 = Invite2:FindFirstChild( "Normal" )
    local Off2 = Invite2:FindFirstChild( "Off" )

    if Normal2 then
        Normal2.Enabled = false
    end
    if Off2 then
        Off2.Enabled = true
    end

    Invite2.AutoButtonColor = false
    Invite2:SetAttribute( "On", false )
    Invite2.Text.Text = "JOINING..."
    Note.Text = "Joining..."
    ClanRemote:FireServer( "join", Argument1 )
    return
end
Storage.Flag7 = false

Storage.Search2 = function()
    if Storage.Flag7 then
        return
    end

    local Match = SearchBox.Text:match( "^%s*@?(.-)%s*$" )

    if #Match < 3 then
        Notify.Error( "Type a Roblox username" )
        return
    end

    Storage.Flag7 = true
    local Normal = Search:FindFirstChild( "Normal" )
    local Off = Search:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = false
    end
    if Off then
        Off.Enabled = true
    end

    Search.AutoButtonColor = false
    Search:SetAttribute( "On", false )
    Search.Text.Text = "..."
    task.spawn( function()
        local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "lookup", Match )
        Storage.Flag7 = false
        local Normal = Search:FindFirstChild( "Normal" )
        local Off = Search:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = true
        end
        if Off then
            Off.Enabled = false
        end

        Search.AutoButtonColor = true
        Search:SetAttribute( "On", true )
        Search.Text.Text = "SEARCH"

        if not Success or type( Result ) ~= "table" then
            Notify.Error( "Search failed, try again" )
            return
        end
        if Result.err then
            Notify.Error( Result.err )
            return
        end

        local PlayerByUserId
        local Here = Result.here

        if Here then
            PlayerByUserId = Players:GetPlayerByUserId( Result.uid )
        else
            PlayerByUserId = Here
        end
        if PlayerByUserId == LocalPlayer then
            Notify.Error( "That's you!" )
            return
        end
        if PlayerByUserId then
            Storage.Callback6( PlayerByUserId )
            return
        end

        local User2
        local User = Result.user
        User2 = if User then User else Match
        local Name2
        Result.user = User2
        local Name = Result.name
        Name2 = if Name then Name else Result.user
        Result.name = Name2
        Storage.Callback6( nil, Result )
    end )
end

Search.Activated:Connect( Storage.Search2 )
SearchBox.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        Storage.Search2( )
    end
end )
SearchBox:GetPropertyChangedSignal( "Text" ):Connect( function()
    if Storage.Flag2 and Storage.Flag3 then
        Callback( )
    end
end )

Storage.Blocked = function()
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

Storage.Callback3 = function()
    if Storage.Text4 == "board" and Table7.view.on then
        return Table7.viewFirst( )
    end
    if Storage.Text4 ~= "clan" then
        return Table[ Storage.Text4 ]
    end
    if Storage.Value6 and Storage.Value6.clan then
        if Storage.Flag3 then
            return Search
        end
        if Table7.on then
            return Table7.first( )
        end
        if not Storage.Value6.clan.chef then
            return Leave
        end

        local ImageButton2
        local ImageButton = Roster:FindFirstChildWhichIsA( "ImageButton" )
        ImageButton2 = if ImageButton then ImageButton else Dissolve
        return ImageButton2
    end
    if not Storage.Value6 or not Storage.Value6.pass then
        return Buy2
    end
    return Create2
end

Storage.CycleTab = function( Argument1 )
    Picker2:Close( )
    Storage.Text4 = Table2[ ( ( table.find( Table2, Storage.Text4 ) or 1 ) - 1 + Argument1 ) % #Table2 + 1 ]
    Storage.Flag3 = false
    Table7.on = false
    Table7.draft = nil
    Table7.view.on = false
    Storage.Callback2( )
    local Refresh = GamepadNav.Refresh
    Refresh( "Clan", Storage.Callback3( ) )
end

Storage.Callback7 = function( Visible )
    if Visible == Storage.Flag2 then
        return
    end
    if Visible then
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
        if Flag then
            return
        end
    end

    Storage.Flag2 = Visible
    Get.Visible = Visible
    Storage.Flag3 = false
    Table7.on = false
    Table7.draft = nil
    Table7.view.on = false
    Confirm.Visible = false
    Storage.Value7 = nil
    GamepadNav.Close( "ClanConfirm" )

    if Visible then
        local ClosePanel
        ClientState.ActiveMenu = "Clan"
        ClientState.CursorFree = true
        local HUDButtons = PlayerGui:FindFirstChild( "HUDButtons" )

        if HUDButtons then
            ClosePanel = HUDButtons:FindFirstChild( "ClosePanel" )
        else
            ClosePanel = HUDButtons
        end
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

        Storage.UpdatePreview( )

        if UIScale then
            UIScale.Scale = 0.92
            TweenService:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end

        task.delay( 0.2, function()
            if Storage.Flag2 then
                Storage.ApplyType( Window, Window )
            end
        end )
        Storage.Flag4 = true
        Storage.Callback2( )
        Storage.Number = Storage.Number + 1
        task.spawn( function()
            local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

            if Storage.Number ~= Storage.Number then
                return
            end
            if Success and type( Result ) == "table" then
                Storage.Value6 = Result
                Result.at = os.clock( )

                if Result.loading then
                    task.delay( 1.5, function()
                        if Storage.Flag2 then
                            Storage.Fetch( )
                        end
                    end )
                end
            end
            if Storage.Flag2 then
                Storage.Callback2( )
            end
        end )
        GamepadNav.Open( "Clan", {
            root = Window,
            first = Storage.Callback3,
            onBack = function()
                if Storage.Flag3 then
                    Storage.Flag3 = false
                    Storage.Callback2( )
                    local Refresh = GamepadNav.Refresh
                    Refresh( "Clan", Storage.Callback3( ) )
                    return
                end
                if Table7.view.on then
                    Table7.closeView( )
                    return
                end
                if Table7.on then
                    Table7.leave( )
                    return
                end
                Storage.Callback7( false )
                return
            end,
            tabs = {
                prev = function()
                    Storage.CycleTab( -1 )
                end,
                next = function()
                    Storage.CycleTab( 1 )
                end,
                label = "Tab"
            }
        } )
        return
    end
    Picker2:Close( )

    if Storage.Value8 then
        Storage.Value8 = nil
        Get2.Visible = false
        Invite2.Visible = true
        HideCard:Fire( )
        GamepadNav.Close( "ClanCard" )

        if Storage.Value9 then
            Storage.Value9:Destroy( )
            Storage.Value9 = nil
        end
    end

    local Value2 = nil

    for Key2, Value3 in Storage.Table12, nil, nil do
        Value3:Destroy( )
    end

    table.clear( Storage.Table12 )

    if ClientState.ActiveMenu == "Clan" then
        ClientState.CursorFree = false
    end

    GamepadNav.Close( "Clan" )
    return
end

Close.Activated:Connect( function()
    Storage.Callback7( false )
end )
Storage.Value10 = nil

for Key2, Value11 in Table, nil, nil do
    Value11.Activated:Connect( function()
        Picker2:Close( )
        Storage.Text4 = Key2
        Storage.Flag3 = false
        Table7.on = false
        Table7.draft = nil
        Table7.view.on = false
        Storage.Callback2( )

        if Key2 ~= "board" then
            Storage.Number = Storage.Number + 1
            task.spawn( function()
                local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

                if Storage.Number ~= Storage.Number then
                    return
                end
                if Success and type( Result ) == "table" then
                    Storage.Value6 = Result
                    Result.at = os.clock( )

                    if Result.loading then
                        task.delay( 1.5, function()
                            if Storage.Flag2 then
                                Storage.Fetch( )
                            end
                        end )
                    end
                end
                if Storage.Flag2 then
                    Storage.Callback2( )
                end
            end )
        end
    end )
end
if ClanButton then
    ClanButton.Visible = true
    ClanButton.Activated:Connect( function()
        Storage.Callback7( not Storage.Flag2 )
    end )
end
Controls.OnInputBegan( function( Argument1, Argument2 )
    if Argument2 then
        return
    end
    if Controls.Is( "Clan", Argument1 ) then
        Storage.Callback7( not Storage.Flag2 )
    end
end )
function Table7.openView( Argument1 )
    if type( Argument1 ) ~= "table" or type( Argument1.id ) ~= "string" then
        return
    end
    if not Storage.Flag2 then
        Storage.Callback7( true )
    end
    if not Storage.Flag2 then
        return
    end

    Picker2:Close( )

    if Argument1.id == ClanShared.IdOf( LocalPlayer ) then
        Storage.Text4 = "clan"
        Storage.Flag3 = false
        Table7.view.on = false
        Storage.Callback2( )
        Storage.Number = Storage.Number + 1
        task.spawn( function()
            local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

            if Storage.Number ~= Storage.Number then
                return
            end
            if Success and type( Result ) == "table" then
                Storage.Value6 = Result
                Result.at = os.clock( )

                if Result.loading then
                    task.delay( 1.5, function()
                        if Storage.Flag2 then
                            Storage.Fetch( )
                        end
                    end )
                end
            end
            if Storage.Flag2 then
                Storage.Callback2( )
            end
        end )
        local Refresh = GamepadNav.Refresh
        Refresh( "Clan", Storage.Callback3( ) )
        return
    end
    local View = Table7.view
    View.token = View.token + 1
    local Token = View.token
    local Id = Argument1.id
    local FromRank = Argument1.rank
    View.on = true
    View.id = Id
    View.fromRank = FromRank
    View.data = {
        id = Argument1.id,
        tag = Argument1.t,
        name = Argument1.n,
        kills = Argument1.k,
        shown = Argument1.c,
        theme = Argument1.h,
        award = Argument1.a,
        rank = Argument1.rank
    }
    Storage.Text4 = "board"
    Storage.Flag3 = false
    Table7.on = false
    Table7.draft = nil
    Storage.Callback2( )
    local Refresh2 = GamepadNav.Refresh
    Refresh2( "Clan", Table7.V.back )
    task.spawn( function()
        local InvokeServer = ClanQuery.InvokeServer
        local Success, Result = pcall( InvokeServer, ClanQuery, "clan", Argument1.id )

        if View.token ~= Token or not View.on then
            return
        end

        local Data = ( not Success or type( Result ) ~= "table" ) and { err = "Couldn't load this clan, try again" } or Result

        if Data.err then
            Notify.Error( Data.err )
            Table7.closeView( )
            return
        end

        local Rank2
        local Rank = Data.rank

        if Rank then
            Rank2 = Rank
        else
            local Data2 = View.data

            if Data2 then
                Rank2 = View.data.rank
            else
                Rank2 = Data2
            end
        end

        Data.rank = Rank2
        View.data = Data

        if Storage.Flag2 then
            Storage.Callback2( )
            local Refresh = GamepadNav.Refresh
            Refresh( "Clan", Table7.viewFirst( ) )
        end
    end )
    return
end
function Table7.openRank( RankName )
    local BoardTop2
    local BoardTop = Table7.boardTop
    BoardTop2 = if BoardTop then Table7.boardTop[ RankName ] else BoardTop

    if BoardTop2 then
        local OpenView = Table7.openView
        OpenView( {
            id = BoardTop2.id,
            t = BoardTop2.t,
            n = BoardTop2.n,
            k = BoardTop2.k,
            c = BoardTop2.c,
            h = BoardTop2.h,
            a = BoardTop2.a,
            rank = RankName
        } )
    end
end
function Table7.closeView()
    Table7.view.on = false
    local View = Table7.view
    View.token = View.token + 1

    if Storage.Flag2 then
        local BoardHit2
        Storage.Callback2( )
        local Refresh = GamepadNav.Refresh
        local BoardHit = Table7.boardHit( Table7.view.fromRank )
        BoardHit2 = if BoardHit then BoardHit else Storage.Callback3( )
        Refresh( "Clan", BoardHit2 )
    end
end
function Table7.boardHit( HitName )
    if not HitName or Storage.Text4 ~= "board" then
        return nil
    end
    if HitName <= 3 then
        local Hit2

        if not Table3[ HitName ] or not Table3[ HitName ].Hit.Visible then
            Hit2 = nil
        else
            local Hit = Table3[ HitName ].Hit

            if Hit then
                Hit2 = Hit
            else
                Hit2 = nil
            end
        end

        return Hit2
    end
    for Key, Value in List3:GetChildren( ) do
        if Value:IsA( "GuiObject" ) then
            if Value.LayoutOrder == HitName - 3 then
                return Value:FindFirstChild( "Hit", true )
            end
        end
    end

    return nil
end
function Table7.viewFirst()
    local Value1 = nil

    for Key, Value in Table7.V.list:GetChildren( ) do
        if Value:IsA( "GuiObject" ) and Value.Name:find( "^Member_" ) then
            if not Value1 or Value.LayoutOrder < Value1.LayoutOrder then
                Value1 = Value
            end
        end
    end

    local View = Value1 and Value1:FindFirstChild( "View", true ) or Table7.V.back
    return View
end
function Table7.renderView()
    local Data2
    local V = Table7.V
    local Data = Table7.view.data
    Data2 = if Data then Data else { }
    local Award4
    local Tag = V.tag
    Tag.Text = Data2.tag or "?"
    Storage.PaintPlate( V.tag.Parent, Data2.shown )
    local Name = V.name
    Name.Text = Data2.name or "Clan"
    local Theme = Data2.theme
    local ImageColor3 = ClanShared.ThemeDef( Theme ).c
    V.hero.ImageColor3 = ImageColor3
    local Award = Data2.award

    if Award then
        local Clan2
        local Award2 = Data2.award
        local Clan = BadgeCatalog.ById.Clan

        if Clan then
            local Tiers = Clan.tiers

            if Tiers then
                Clan2 = Clan.tiers[ tonumber( Award2 ) or 0 ]
            else
                Clan2 = Tiers
            end
        else
            Clan2 = Clan
        end
        if Clan2 then
            local LogoImage = BadgeCatalog.LogoImage( Clan, Clan2 )

            if LogoImage then
                Award4 = LogoImage
            else
                Award4 = nil
            end
        else
            Award4 = nil
        end
    else
        Award4 = Award
    end

    local Visible
    local Award3 = V.award
    Award3.Image = Award4 or ""
    local Award5 = V.award
    Visible = Award4 ~= nil and true or false
    local Text2
    Award5.Visible = Visible
    task.defer( Storage.FitLine, V.nameRow, V.name, V.award )
    local Rank = V.rank

    if Data2.rank then
        local Text = "#" .. Data2.rank

        if Text then
            Text2 = Text
        else
            Text2 = "-"
        end
    else
        Text2 = "-"
    end

    local Season3
    Rank.Text = Text2
    local Kills = V.kills
    Kills.Text = Storage.Num( Data2.kills )
    local Season = V.season

    if Storage.Value6 then
        local Season2 = Storage.Value6.season

        if Season2 then
            Season3 = Season2
        else
            Season3 = ClanShared.SEASON
        end
    else
        Season3 = ClanShared.SEASON
    end

    local Max2
    Season.Text = SeasonText( Season3 )
    PaintRanked( V.hero:FindFirstChild( "Stats" ), Data2.ranked )
    local Max = Data2.max
    Max2 = if Max then Max else ClanShared.MAX_MEMBERS

    if type( Data2.members ) ~= "table" then
        V.count.Text = "-"
        V.online.Text = "LOADING..."
        return
    end

    local BackgroundColor3
    local Count = V.count
    Count.Text = ( "%d/%d" ):format( #Data2.members, Max2 )
    local Clone = table.clone( Data2.members )
    table.sort( Clone, function( Argument1, Argument2 )
        local Number = tonumber( Argument1.k ) or 0
        local Number2 = tonumber( Argument2.k ) or 0

        if Number ~= Number2 then
            local Flag = Number2 < Number and true or false
            return Flag
        end
        if Argument1.chef == Argument2.chef then
            local Flag3 = tostring( Argument1.n ):lower( ) < tostring( Argument2.n ):lower( ) and true or false
            return Flag3
        end
        local Flag2 = Argument1.chef == true and true or false
        return Flag2
    end )
    local ColorDef = ClanShared.ColorDef( Data2.shown )

    if ColorDef.keys then
        local Item = ColorDef.keys[ 1 ]

        if Item then
            BackgroundColor3 = Item
        else
            BackgroundColor3 = ColorDef.c
        end
    else
        BackgroundColor3 = ColorDef.c
    end

    local Number
    local Max3 = math.max( tonumber( Data2.kills ) or 0, 1 )
    local Count2 = #Clone
    local List = V.list
    Number = not Flag and 4 or 3
    local Value1, Number2
    List.CanvasSize = UDim2.fromScale( 0, math.max( 1, Count2 / Number ) * List.Size.Y.Scale )
    Value1 = nil
    Number2 = 0

    for Key, Value in Clone, nil, nil do
        local Number3
        local List2 = V.list
        Number3 = not Flag and 4 or 3
        local FlagInner
        local Value2, Value3 = Storage.AddRow( List2, "ScoutRow", Key, Count2, Number3 )
        Value2.Name = "Member_" .. Value.uid

        if Value.uid == LocalPlayer.UserId then
            FlagInner = true
        elseif Value.on == "here" then
            FlagInner = true
        elseif Players:GetPlayerByUserId( Value.uid ) == nil then
            FlagInner = false
        else
            FlagInner = true
        end

        local Flag2

        if FlagInner then
            Flag2 = FlagInner
        elseif Value.on == "on" then
            Flag2 = true
        else
            Flag2 = false
        end
        if Flag2 then
            Number2 = Number2 + 1
        end

        local Rank2 = Value3.Rank
        Rank2.Text = "#" .. Key

        if Key == 1 then
            local Rank3 = Value3.Rank
            Rank3.TextColor3 = Color3.fromRGB( 255, 202, 86 )
        end

        local ImageTransparency
        local Avatar = Value3.Avatar
        Avatar.Image = ( "rbxthumb://type=AvatarHeadShot&id=%d&w=60&h=60" ):format( Value.uid )
        local Avatar2 = Value3.Avatar
        ImageTransparency = not Flag2 and 0.35 or 0
        local Image2
        Avatar2.ImageTransparency = ImageTransparency
        local RangBadge = Value3:FindFirstChild( "RangBadge" )
        local Rb = Value.rb

        if type( Rb ) == "string" then
            local Match, Match2 = Rb:match( "^(%w+):(%d*)$" )

            if not Result2 or type( Match ) ~= "string" or Match == "" or Match == "Unranked" then
                Image2 = nil
            else
                local Image = Result2.Image
                Image2 = Image( Match, ( tonumber( Match2 ) ) )
            end
        else
            Image2 = nil
        end
        if RangBadge then
            local Image3 = RangBadge:FindFirstChild( "Image" ) or RangBadge

            if Image2 and Image3.Image ~= Image2 then
                Image3.Image = Image2

                if Image3 ~= RangBadge and Result2 and Result2.Place then
                    Result2.Place( Image3 )
                end
            end

            local Visible2 = Image2 ~= nil and true or false
            RangBadge.Visible = Visible2
        end
        if RangBadge then
            local PlayerName = Value3.PlayerName

            local function PlaceBadge()
                local X = Value3.AbsoluteSize.X

                if X <= 0 or not RangBadge.Parent then
                    return
                end
                local X2 = PlayerName.AbsolutePosition.X - Value3.AbsolutePosition.X
                local X3 = PlayerName.TextBounds.X
                local X4 = ( X2 + math.min( X3, PlayerName.AbsoluteSize.X ) ) / X + 0.012
                RangBadge.Position = UDim2.fromScale( X4, RangBadge.Position.Y.Scale )
                return
            end

            task.defer( PlaceBadge )
            PlayerName:GetPropertyChangedSignal( "TextBounds" ):Connect( PlaceBadge )
            Value3:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( PlaceBadge )
        end

        local Text3
        local PlayerName2 = Value3.PlayerName
        local Gsub = tostring( Value.n ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
        Text3 = not Value.chef and "" or "  <font color=\"#FFCA56\"><b>LEADER</b></font>"
        local Text4
        PlayerName2.Text = Gsub .. Text3

        if FlagInner then
            Text4 = "<font color=\"#78E18C\">In your server</font>"
        elseif Flag2 then
            Text4 = "<font color=\"#78E18C\">Online</font>"
        else
            Text4 = "Offline"
        end

        local Floor
        local Number4 = tonumber( Value.j )

        if Number4 then
            Floor = math.floor( ( os.time( ) - Value.j ) / 86400 )
        else
            Floor = Number4
        end

        local Number5

        if Floor then
            if Floor < 1 then
                Number5 = "joined today"
            elseif Floor == 1 then
                Number5 = "1 day in clan"
            else
                Number5 = Floor .. " days in clan"
            end
        else
            Number5 = Floor
        end

        local Text5
        local Info = Value3.Info
        Text5 = Number5 and ( "%s  ·  %s" ):format( Text4, Number5 ) or Text4
        local Visible3
        Info.Text = Text5
        local Number6 = tonumber( Value.k ) or 0
        local Kills2 = Value3.Kills
        Kills2.Text = ( "<b>%s</b> KILLS  ·  %d%%" ):format( Storage.Num( Number6 ), ( math.floor( Number6 / Max3 * 100 + 0.5 ) ) )
        local Fill = Value3.Share.Fill
        Fill.Size = UDim2.fromScale( math.clamp( Number6 / Max3, 0, 1 ), 1 )
        Value3.Share.Fill.BackgroundColor3 = BackgroundColor3
        local Fill2 = Value3.Share.Fill
        Visible3 = Number6 > 0 and true or false
        Fill2.Visible = Visible3
        Value3.View.Activated:Connect( function()
            Table7.viewMember( Value )
        end )
    end

    local Online = V.online
    Online.Text = ( "%d ONLINE" ):format( Number2 )
end
function Table7.viewMember( Argument1 )
    if not Storage.Flag2 or Storage.Value8 then
        return
    end

    local Data2
    local Data = Table7.view.data
    Data2 = if Data then Data else { }
    local Text3Inner
    local Number = tonumber( Argument1.uid ) or 0
    local PlayerByUserId = Players:GetPlayerByUserId( Number )
    Storage.Value8 = { uid = Number, name = Argument1.n, member = true, view = true }
    Table7.cardTitle( true )
    Get.Visible = false
    Get2.Visible = true
    Invite2.Visible = false
    task.defer( Storage.ApplyType, Box2, Box2 )
    local Text = Data2.tag or "?"
    local Text2 = Data2.name or "Clan"
    Tag4.Text = Text
    ClanName2.Text = Text2
    Storage.PaintPlate( Tag4.Parent, Data2.shown )
    local Gsub = tostring( Argument1.n ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    Text3Inner = not Argument1.chef and "" or "  ·  Leader"
    local Text4
    Text3.Text = ( "<b>%s</b>%s" ):format( Gsub, Text3Inner )

    if PlayerByUserId then
        if Number == LocalPlayer.UserId then
            local Me = Table7.MEMBER_NOTE.me

            if Me then
                Text4 = Me
            else
                local Here = Table7.MEMBER_NOTE.here

                if Here then
                    Text4 = Here
                elseif Argument1.on == "on" then
                    Text4 = "Online"
                else
                    Text4 = Table7.MEMBER_NOTE.off
                end
            end
        else
            local Here = Table7.MEMBER_NOTE.here

            if Here then
                Text4 = Here
            elseif Argument1.on == "on" then
                Text4 = "Online"
            else
                Text4 = Table7.MEMBER_NOTE.off
            end
        end
    elseif Argument1.on == "on" then
        Text4 = "Online"
    else
        Text4 = Table7.MEMBER_NOTE.off
    end

    Note.Text = Text4

    if PlayerByUserId then
        ShowCard:Fire( PlayerByUserId )
    else
        task.spawn( function()
            local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "card", Number )

            if not Storage.Value8 or not Storage.Value8.view or Storage.Value8.uid ~= Number then
                return
            end
            if not Success or type( Result ) ~= "table" or Result.err then
                Note.Text = "Couldn't load this player, try again"
                return
            end
            ShowCard:Fire( ( Table7.cardSourceOf( Result ) ) )
            return
        end )
    end

    GamepadNav.Open( "ClanCard", {
        root = Box2,
        first = Back2,
        onBack = function()
            if not Storage.Value8 then
                return
            end

            Storage.Value8 = nil
            Get2.Visible = false
            Invite2.Visible = true
            HideCard:Fire( )
            GamepadNav.Close( "ClanCard" )

            if Storage.Value9 then
                Storage.Value9:Destroy( )
                Storage.Value9 = nil
            end
            if Storage.Flag2 then
                Get.Visible = true
                Storage.Callback2( )
            end
        end,
        backLabel = "Back",
        freeze = true
    } )
end
Table7.V.back.Activated:Connect( function()
    Table7.closeView( )
end )
Storage.Value12 = nil

for Key3, Value13 in Table3, nil, nil do
    Value13.Hit.Activated:Connect( function()
        Table7.openRank( Key3 )
    end )
    Value13.Hit.MouseEnter:Connect( function()
        if Value13.ClanName:GetAttribute( "Rest" ) == nil then
            local ClanName = Value13.ClanName
            ClanName:SetAttribute( "Rest", Value13.ClanName.TextColor3 )
        end

        local ClanName2 = Value13.ClanName
        ClanName2.TextColor3 = Color3.fromRGB( 255, 214, 120 )
    end )
    Value13.Hit.MouseLeave:Connect( function()
        local TextColor3 = Value13.ClanName:GetAttribute( "Rest" )

        if TextColor3 then
            Value13.ClanName.TextColor3 = TextColor3
        end
    end )
end
MyRow.Card.Hit.Activated:Connect( function()
    Storage.Text4 = "clan"
    Storage.Flag3 = false
    Storage.Callback2( )
    Storage.Number = Storage.Number + 1
    task.spawn( function()
        local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

        if Storage.Number ~= Storage.Number then
            return
        end
        if Success and type( Result ) == "table" then
            Storage.Value6 = Result
            Result.at = os.clock( )

            if Result.loading then
                task.delay( 1.5, function()
                    if Storage.Flag2 then
                        Storage.Fetch( )
                    end
                end )
            end
        end
        if Storage.Flag2 then
            Storage.Callback2( )
        end
    end )
    local Refresh = GamepadNav.Refresh
    Refresh( "Clan", Storage.Callback3( ) )
end )
Storage.ScreenGui = Get:FindFirstAncestorOfClass( "ScreenGui" )

if not Storage.ScreenGui or not Storage.ScreenGui:FindFirstChild( "OpenClanView" ) then
    Storage.BindableEvent = Instance.new( "BindableEvent" )
else
    Storage.BindableEvent = Storage.ScreenGui:FindFirstChild( "OpenClanView" )
end
Storage.BindableEvent.Name = "OpenClanView"
Storage.BindableEvent.Event:Connect( function( Argument1 )
    Table7.openView( Argument1 )
end )
Storage.BindableEvent.Parent = Storage.ScreenGui or PlayerGui
NameBox:GetPropertyChangedSignal( "Text" ):Connect( function()
    local Len = utf8.len( NameBox.Text )

    if not Len or not ( ClanShared.NAME_MAX < Len ) then
        Storage.UpdatePreview( )
        return
    end
    local Text = NameBox.Text
    NameBox.Text = Text:sub( 1, utf8.offset( NameBox.Text, ClanShared.NAME_MAX + 1 ) - 1 )
    return
end )
TagBox:GetPropertyChangedSignal( "Text" ):Connect( function()
    local Gsub = TagBox.Text:upper( ):gsub( "[^A-Z0-9]", "" )
    local Text = Gsub:sub( 1, ClanShared.TAG_LEN )

    if Text ~= TagBox.Text then
        TagBox.Text = Text
    end

    Storage.UpdatePreview( )
end )
Storage.Number2 = 0

Storage.TryCreate = function()
    if os.clock( ) - Storage.Number2 < 1.5 then
        return
    end

    local Match = NameBox.Text:match( "^%s*(.-)%s*$" )
    local Len = utf8.len( Match ) or 0

    if Len < ClanShared.NAME_MIN or ClanShared.NAME_MAX < Len then
        Notify.Error( ( "The name must be %d to %d characters" ):format( ClanShared.NAME_MIN, ClanShared.NAME_MAX ) )
        return
    end

    local CleanTag = ClanShared.CleanTag( TagBox.Text )

    if not CleanTag then
        Notify.Error( "The tag must be exactly 3 letters or digits" )
        return
    end

    local MaskBanned, MaskBanned2 = CrewShared.MaskBanned( Match )

    if MaskBanned2 then
        Notify.Error( ( "Inappropriate name: \"%s\". Choose another name" ):format( MaskBanned ) )
        return
    end

    local MaskBanned3, MaskBanned22 = CrewShared.MaskBanned( CleanTag )

    if MaskBanned22 then
        Notify.Error( ( "Inappropriate tag: \"%s\". Choose another tag" ):format( MaskBanned3 ) )
        return
    end
    if ClanShared.TagBanned( CleanTag ) then
        Notify.Error( ( "Inappropriate tag: \"%s\". Choose another tag" ):format( ( "#" ):rep( #CleanTag ) ) )
        return
    end

    Storage.Number2 = os.clock( )
    Storage.Flag5 = true
    local Normal = Create2:FindFirstChild( "Normal" )
    local Off = Create2:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = false
    end
    if Off then
        Off.Enabled = true
    end

    Create2.AutoButtonColor = false
    Create2:SetAttribute( "On", false )
    Create2.Text.Text = "CREATING..."
    ClanRemote:FireServer( "create", Match, CleanTag )
end

Create2.Activated:Connect( Storage.TryCreate )
NameBox.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        TagBox:CaptureFocus( )
    end
end )
TagBox.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        local Flag = Create2:GetAttribute( "On" ) ~= false and true or false

        if Flag then
            Storage.TryCreate( )
        end
    end
end )

Storage.Buy4 = function( Argument1 )
    local PASS_PACK2

    if Argument1 then
        local PASS_PACK = ClanShared.PASS_PACK

        if PASS_PACK then
            PASS_PACK2 = PASS_PACK
        else
            PASS_PACK2 = ClanShared.PASS_CLAN
        end
    else
        PASS_PACK2 = ClanShared.PASS_CLAN
    end
    if PASS_PACK2 then
        GamepadNav.Prompt( function()
            MarketplaceService:PromptGamePassPurchase( LocalPlayer, PASS_PACK2 )
        end )
        return
    end
    if not Storage.Value6 or not Storage.Value6.simulated then
        Notify.Error( "Clans are coming soon" )
        return
    end

    local Flag = Argument1 == true and true or false
    ClanRemote:FireServer( "studiobuy", Flag )
end

Buy2.Activated:Connect( function()
    Storage.Buy4( false )
end )
Buy3.Activated:Connect( function()
    Storage.Buy4( true )
end )

Storage.GiftButton = function( Object, Argument2 )
    local Price = Object:WaitForChild( "Price" )
    local Gift = Price:FindFirstChild( "Gift" )
    local Buy = Price:WaitForChild( "Buy" )

    if not Gift then
        return
    end

    local Find = GamePasses.Find( Argument2 )

    if Find and not ( ( Find.GiftProduct or 0 ) <= 0 ) then
        Gift.Visible = true
        Gift.Activated:Connect( function()
            Picker2:Open( {
                title = "GIFT " .. string.upper( Find.Name ),
                onSend = function( Argument1, Argument2 )
                    local Gift = RobuxShopUI.Gift
                    Gift( "Pass", Find.id, Argument1, Argument2 )
                end
            } )
        end )
        return
    end

    Gift.Visible = false

    if typeof( Buy:GetAttribute( "FullSize" ) ) == "UDim2" then
        Buy.Size = Buy:GetAttribute( "FullSize" )
    end
end

Storage.GiftButton( OfferClan, "Clan" )
Storage.GiftButton( OfferPack, "CrewClan" )
Picker2.list.ChildAdded:Connect( function( Argument1 )
    task.defer( function()
        if Argument1.Parent then
            Storage.ApplyType( Window, Argument1 )
        end
    end )
end )

Storage.Callback4 = function()
    if Storage.Value6 and Storage.Value6.clan and Storage.Value6.clan.chef then
        local Flag = Invite:GetAttribute( "On" ) ~= false and true or false

        if Flag then
            Storage.Flag3 = true
            Storage.Callback2( )
            GamepadNav.Refresh( "Clan", Search )
            return
        end
    end
end

Invite.Activated:Connect( Storage.Callback4 )
Back.Activated:Connect( function()
    Storage.Flag3 = false
    Storage.Callback2( )
    local Refresh = GamepadNav.Refresh
    Refresh( "Clan", Storage.Callback3( ) )
end )
Table6.customize.Activated:Connect( function()
    if not Storage.Value6 or not Storage.Value6.clan or not Storage.Value6.clan.chef then
        return
    end
    Table7.on = true
    Table7.draft = nil
    Table7.sec = "color"
    Storage.Callback2( )
    local Refresh = GamepadNav.Refresh
    Refresh( "Clan", Storage.Callback3( ) )
    return
end )
Table6.back.Activated:Connect( function()
    Table7.leave( )
end )
Table6.undo.Activated:Connect( function()
    Table7.undo( )
end )
Storage.Tabs2 = Table6.tabs
Storage.Value14 = nil

for Key4, Value15 in Storage.Tabs2, nil, nil do
    Value15.Activated:Connect( function()
        if Table7.on then
            Table7.sec = Key4
            Table7.paint( )
            local Refresh = GamepadNav.Refresh
            Refresh( "Clan", Table7.first( ) )
            return
        end
        return
    end )
end
Table6.save.Activated:Connect( function()
    local Draft = Table7.draft

    if Draft then
        local Flag = Table6.save:GetAttribute( "On" ) ~= false and true or false

        if Flag then
            local Save = Table6.save
            local Normal = Save:FindFirstChild( "Normal" )
            local Off = Save:FindFirstChild( "Off" )

            if Normal then
                Normal.Enabled = false
            end
            if Off then
                Off.Enabled = true
            end

            Save.AutoButtonColor = false
            Save:SetAttribute( "On", false )
            Save.Text.Text = "SAVING..."
            ClanRemote:FireServer( "style", { color = Draft.color, special = Draft.special, theme = Draft.theme } )
            return
        end
    end
end )
Table6.tag:GetPropertyChangedSignal( "Text" ):Connect( function()
    local Gsub = Table6.tag.Text:upper( ):gsub( "[^A-Z0-9]", "" )
    local Text = Gsub:sub( 1, ClanShared.TAG_LEN )

    if Text ~= Table6.tag.Text then
        Table6.tag.Text = Text
        return
    end
    if Table7.on then
        Table7.paint( )
    end
end )
Table6.name:GetPropertyChangedSignal( "Text" ):Connect( function()
    local Len = utf8.len( Table6.name.Text )

    if Len and ClanShared.NAME_MAX < Len then
        local Name = Table6.name
        local Text = Table6.name.Text
        Name.Text = Text:sub( 1, utf8.offset( Table6.name.Text, ClanShared.NAME_MAX + 1 ) - 1 )
        return
    end
    if Table7.on then
        Table7.paint( )
    end
end )
function Table7.askRename()
    if Storage.Value6 and Storage.Value6.clan then
        local Flag = Table6.rename:GetAttribute( "On" ) ~= false and true or false

        if Flag then
            local Match = Table6.name.Text:match( "^%s*(.-)%s*$" )
            local Text = Table6.tag.Text
            local Shown = ( Storage.Value6 and Storage.Value6.clan ).shown
            local TagRich = ClanShared.TagRich( Text, Shown )
            Storage.Ask( "RENAME THE CLAN?", ( "Your clan becomes %s. You can't rename it again for %d days." ):format( TagRich .. " " .. tostring( Match ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ), ClanShared.RENAME_DAYS ), "RENAME", function()
                ClanRemote:FireServer( "rename", Match, Text )
            end )
            return
        end
    end
end
Table6.rename.Activated:Connect( Table7.askRename )
Table6.name.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        Table6.tag:CaptureFocus( )
    end
end )
Table6.tag.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        Table7.askRename( )
    end
end )
Dissolve.Activated:Connect( function()
    if not Storage.Value6 or not Storage.Value6.clan or not Storage.Value6.clan.chef then
        return
    end
    Storage.Ask( "DISSOLVE THE CLAN?", "Every member leaves, the name and the tag become free and the clan's kills are lost. <b>This can't be undone.</b>", "DISSOLVE", function()
        ClanRemote:FireServer( "dissolve" )
    end )
    return
end )
Leave.Activated:Connect( function()
    if not Storage.Value6 or not Storage.Value6.clan or Storage.Value6.clan.chef then
        return
    end
    Storage.Ask( "LEAVE THE CLAN?", ( "<b>Your kills are removed from the clan score.</b> You'll have to wait %d h to join another clan." ):format( ClanShared.REJOIN_HOURS ), "LEAVE", function()
        ClanRemote:FireServer( "leave" )
    end )
    return
end )
Storage.Sound = Instance.new( "Sound" )
Storage.Sound.Name = "ClanInviteDing"
Storage.Sound.SoundId = "rbxassetid://133743196377753"
Storage.Sound.Volume = 0.55
Storage.Sound.Parent = Parent
Storage.Table14 = { }
Storage.Value16 = nil
Storage.Value17 = nil
Storage.Callback8 = nil

Storage.ShowNext = function()
    if Storage.Value16 or #Storage.Table14 == 0 then
        return
    end

    local Enabled
    local Remove = table.remove( Storage.Table14, 1 )
    Storage.Value16 = Remove
    Tag3.Text = Remove.ct or "?"
    Storage.PaintPlate( Tag3.Parent, Remove.cc )
    Message.Text = ( "<b>%s</b> invites you to join <b>%s</b>" ):format( tostring( Remove.fn or "?" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ), ( tostring( Remove.cn or "Clan" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) ) )
    Enabled = ( tonumber( Remove.wait ) or 0 ) <= 0 and true or false
    local Normal = Accept:FindFirstChild( "Normal" )
    local Off = Accept:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = Enabled
    end
    if Off then
        Off.Enabled = not Enabled
    end

    Accept.AutoButtonColor = Enabled
    Accept:SetAttribute( "On", Enabled )
    Card.Position = Position
    Card.Visible = true
    task.defer( Storage.ApplyType, Card, Card )

    if Storage.Value17 then
        Storage.Value17:Cancel( )
    end

    local PositionInner
    local TweenInfo2 = TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out )
    local Table = { }
    PositionInner = Flag and FromScale3 or FromScale2
    Table.Position = PositionInner
    Storage.Value17 = TweenService:Create( Card, TweenInfo2, Table )
    Storage.Value17:Play( )
    Storage.Sound.TimePosition = 0
    Storage.Sound:Play( )
    Fill.Size = UDim2.fromScale( 1, 1 )
    TweenService:Create( Fill, TweenInfo.new( 12, Enum.EasingStyle.Linear ), { Size = UDim2.fromScale( 0, 1 ) } ):Play( )
    task.delay( 12, function()
        if Storage.Value16 == Remove then
            Storage.Value16 = nil
            Storage.Callback8( )
        end
    end )
end

Storage.Callback8 = function()
    if Storage.Value17 then
        Storage.Value17:Cancel( )
    end

    Storage.Value17 = TweenService:Create( Card, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), { Position = Position } )
    Storage.Value17:Play( )
    Storage.Value17.Completed:Connect( function( Argument1 )
        if Argument1 == Enum.PlaybackState.Completed and not Storage.Value16 then
            Card.Visible = false
        end

        task.delay( 0.15, Storage.ShowNext )
    end )
end

Storage.Answer = function( Argument1 )
    if not Storage.Value16 then
        return
    end
    if not Argument1 or not ( ( tonumber( Storage.Value16.wait ) or 0 ) > 0 ) then
        Storage.Value16 = nil
        ClanRemote:FireServer( "respond", Storage.Value16.id, Argument1 )
        Storage.Callback8( )
        return
    end

    local Text
    local Error = Notify.Error
    local Max = math.max( 0, ( math.floor( tonumber( Storage.Value16.wait ) or 0 ) ) )

    if Max >= 172800 then
        Text = math.ceil( Max / 86400 ) .. " days"
    elseif Max >= 3600 then
        Text = math.ceil( Max / 3600 ) .. " h"
    else
        Text = math.max( 1, ( math.ceil( Max / 60 ) ) ) .. " min"
    end

    Error( ( "You can join another clan in %s" ):format( Text ) )
end

Accept.Activated:Connect( function()
    Storage.Answer( true )
end )
Decline.Activated:Connect( function()
    if Storage.Value16 then
        Storage.Value16 = nil
        ClanRemote:FireServer( "respond", Storage.Value16.id, false )
        Storage.Callback8( )
        return
    end
    return
end )
ClanRemote.OnClientEvent:Connect( function( Name, Name2, Argument3 )
    if Name == "invite" then
        if type( Name2 ) ~= "table" or type( Name2.id ) ~= "string" then
            return
        end
        if ClanShared.IdOf( LocalPlayer ) then
            return
        end

        local Value1 = nil

        for Key, Value in Storage.Table14, nil, nil do
            if Value.id == Name2.id then
                return
            end
        end

        table.insert( Storage.Table14, Name2 )

        while #Storage.Table14 > 3 do
            table.remove( Storage.Table14, 1 )
        end

        Storage.ShowNext( )

        if Storage.Flag2 then
            Storage.Number = Storage.Number + 1
            task.spawn( function()
                local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

                if Storage.Number ~= Storage.Number then
                    return
                end
                if Success and type( Result ) == "table" then
                    Storage.Value6 = Result
                    Result.at = os.clock( )

                    if Result.loading then
                        task.delay( 1.5, function()
                            if Storage.Flag2 then
                                Storage.Fetch( )
                            end
                        end )
                    end
                end
                if Storage.Flag2 then
                    Storage.Callback2( )
                end
            end )
            return
        end
    elseif Name == "sent" then
        if type( Name2 ) == "number" and type( Argument3 ) == "number" then
            Storage.Table11[ Name2 ] = os.clock( ) + Argument3
            Storage.Callback5( Name2 )
            return
        end
    elseif Name == "error" then
        if type( Name2 ) == "string" then
            Notify.Error( Name2 )
        end

        local Value2 = nil

        for Key2, Value3 in Storage.Table11, nil, nil do
            if Value3 - os.clock( ) <= 2 then
                Storage.Table11[ Key2 ] = nil
            end
        end
        if Storage.Value8 then
            Storage.Callback5( Storage.Value8.uid )
            return
        end
    elseif Name == "info" then
        if type( Name2 ) == "string" then
            Notify.Announce( "CLAN", Name2, 3 )
            return
        end
    elseif Name == "refresh" or Name == "done" then
        if Name == "done" and Name2 == "create" then
            Storage.Flag5 = false
            Storage.UpdatePreview( )
        end
        if Name == "done" and Name2 == "join" and Storage.Value8 and Storage.Value8.member then
            local Uid = Storage.Value8.uid
            task.delay( 4, function()
                if Storage.Value8 and Storage.Value8.member and Storage.Value8.uid == Uid then
                    Table7.memberCheck( Uid )
                end
            end )
        end
        if Name == "done" and Name2 == "invite" and Storage.Value8 then
            local Flag = ( Storage.Table11[ Storage.Value8.uid ] or 0 ) - os.clock( ) > 2 and true or false

            if Flag then
                if Storage.Value8 then
                    Storage.Value8 = nil
                    Get2.Visible = false
                    Invite2.Visible = true
                    HideCard:Fire( )
                    GamepadNav.Close( "ClanCard" )

                    if Storage.Value9 then
                        Storage.Value9:Destroy( )
                        Storage.Value9 = nil
                    end
                    if Storage.Flag2 then
                        Get.Visible = true
                        Storage.Callback2( )
                    end
                end
            end
        end
        if Storage.Flag2 then
            Storage.Number = Storage.Number + 1
            task.spawn( function()
                local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

                if Storage.Number ~= Storage.Number then
                    return
                end
                if Success and type( Result ) == "table" then
                    Storage.Value6 = Result
                    Result.at = os.clock( )

                    if Result.loading then
                        task.delay( 1.5, function()
                            if Storage.Flag2 then
                                Storage.Fetch( )
                            end
                        end )
                    end
                end
                if Storage.Flag2 then
                    Storage.Callback2( )
                end
            end )
        end
    end
end )

Storage.InvitesCount = function()
    local Number = tonumber( LocalPlayer:GetAttribute( "ClanInvites" ) ) or 0

    if Count2 then
        local Visible = Number > 0 and true or false
        Count2.Visible = Visible
        local Texte = Count2:FindFirstChild( "Texte" )

        if Texte then
            Texte.Text = tostring( Number )
        end
    end
end

LocalPlayer:GetAttributeChangedSignal( "ClanInvites" ):Connect( function()
    local Number = tonumber( LocalPlayer:GetAttribute( "ClanInvites" ) ) or 0

    if Count2 then
        local Visible = Number > 0 and true or false
        Count2.Visible = Visible
        local Texte = Count2:FindFirstChild( "Texte" )

        if Texte then
            Texte.Text = tostring( Number )
        end
    end
    if Storage.Flag2 then
        Storage.Number = Storage.Number + 1
        task.spawn( function()
            local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

            if Storage.Number ~= Storage.Number then
                return
            end
            if Success and type( Result ) == "table" then
                Storage.Value6 = Result
                Result.at = os.clock( )

                if Result.loading then
                    task.delay( 1.5, function()
                        if Storage.Flag2 then
                            Storage.Fetch( )
                        end
                    end )
                end
            end
            if Storage.Flag2 then
                Storage.Callback2( )
            end
        end )
    end
end )
Storage.InvitesCount( )
Storage.Table15 = { "ClanId", "ClanChef", "ClanTag", "ClanPass", "CrewPass" }
Storage.Value18 = nil

for Key5, Value19 in Storage.Table15, nil, nil do
    LocalPlayer:GetAttributeChangedSignal( Value19 ):Connect( function()
        if Storage.Flag2 then
            Storage.Number = Storage.Number + 1
            task.spawn( function()
                local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

                if Storage.Number ~= Storage.Number then
                    return
                end
                if Success and type( Result ) == "table" then
                    Storage.Value6 = Result
                    Result.at = os.clock( )

                    if Result.loading then
                        task.delay( 1.5, function()
                            if Storage.Flag2 then
                                Storage.Fetch( )
                            end
                        end )
                    end
                end
                if Storage.Flag2 then
                    Storage.Callback2( )
                end
            end )
        end
    end )
end

ClanBoardData.Changed:Connect( function()
    if Storage.Flag2 and Storage.Text4 == "board" then
        Callback( )
    end
end )
Players.PlayerAdded:Connect( function()
    if Storage.Flag2 and Storage.Flag3 then
        Callback( )
    end
end )
Players.PlayerRemoving:Connect( function()
    if Storage.Flag2 and Storage.Flag3 then
        Callback( )
    end
end )
Storage.Number3 = 0
Storage.Number4 = 0
RunService.Heartbeat:Connect( function( Argument1 )
    if not Storage.Flag2 then
        return
    end

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
    if Flag or ClientState.ActiveMenu ~= "Clan" then
        Storage.Callback7( false )
        return
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
        if IconInner then
            if IconInner.isSelected then
                Storage.Callback7( false )
                return
            end
        end
    end
    if not ClientState.CursorFree then
        ClientState.CursorFree = true
    end

    Storage.Number3 = Storage.Number3 + Argument1
    Storage.Number4 = Storage.Number4 + Argument1

    if Storage.Number3 >= 0.25 then
        Storage.Number3 = 0

        if Storage.Value8 then
            Storage.Callback5( Storage.Value8.uid )
        end
    end
    if Storage.Number4 >= 20 then
        Storage.Number4 = 0

        if not Storage.Value8 and not Confirm.Visible and not Table7.on then
            Storage.Number = Storage.Number + 1
            task.spawn( function()
                local Success, Result = pcall( ClanQuery.InvokeServer, ClanQuery, "state" )

                if Storage.Number ~= Storage.Number then
                    return
                end
                if Success and type( Result ) == "table" then
                    Storage.Value6 = Result
                    Result.at = os.clock( )

                    if Result.loading then
                        task.delay( 1.5, function()
                            if Storage.Flag2 then
                                Storage.Fetch( )
                            end
                        end )
                    end
                end
                if Storage.Flag2 then
                    Storage.Callback2( )
                end
            end )
        end
    end
end )
function TextChatService.OnIncomingMessage( Argument1 )
    local PlayerByUserId
    local TextChatMessageProperties = Instance.new( "TextChatMessageProperties" )
    local TextSource = Argument1.TextSource

    if TextSource then
        PlayerByUserId = Players:GetPlayerByUserId( TextSource.UserId )
    else
        PlayerByUserId = TextSource
    end

    local ClanTag

    if PlayerByUserId then
        ClanTag = PlayerByUserId:GetAttribute( "ClanTag" )
    else
        ClanTag = PlayerByUserId
    end
    if type( ClanTag ) == "string" and ClanTag ~= "" then
        local TagRich = ClanShared.TagRich
        local TagRich2 = TagRich( ClanTag, PlayerByUserId:GetAttribute( "ClanColor" ) )
        TextChatMessageProperties.PrefixText = TagRich2 .. " " .. Argument1.PrefixText
    end

    return TextChatMessageProperties
end
Table7.animAcc = 0
RunService.Heartbeat:Connect( function( Argument1 )
    if not Storage.Flag2 and not Card.Visible and not Get2.Visible then
        return
    end

    Table7.animAcc = Table7.animAcc + Argument1

    if Table7.animAcc < 0.03333333333333333 then
        return
    end

    local Value1
    Table7.animAcc = 0
    local Clock = os.clock( ) * ClanShared.SCROLL_SPEED % 1
    Value1 = nil

    for Key, Value in Storage.Table10, nil, nil do
        if Key.Parent then
            Key.Color = ClanShared.ScrollSequence( Value, Clock )
        else
            Storage.Table10[ Key ] = nil
        end
    end
end )
Get:GetPropertyChangedSignal( "Visible" ):Connect( function()
    if Get.Visible then
        if not Storage.Flag2 or Storage.Value8 then
            Get.Visible = false
        end
    end
end )
Get2:GetPropertyChangedSignal( "Visible" ):Connect( function()
    if Get2.Visible and not Storage.Value8 then
        Get2.Visible = false
    end
end )
Card:GetPropertyChangedSignal( "Visible" ):Connect( function()
    if Card.Visible and not Storage.Value16 then
        Card.Visible = false
    end
end )
