-- StarterPlayer.StarterPlayerScripts.WorldLeaderboardClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local CollectionService = game:GetService( "CollectionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local HttpService = game:GetService( "HttpService" )
local UserInputService = game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
local GamepadService = game:GetService( "GamepadService" )
local GuiService = game:GetService( "GuiService" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local ClanShared = require( ReplicatedStorage:WaitForChild( "ClanShared" ) )
local Enabled = ClanShared.Enabled( )
local LocalPlayer = Players.LocalPlayer
local WorldLeaderboardData = ReplicatedStorage:WaitForChild( "WorldLeaderboardData" )
local FromRGB = Color3.fromRGB( 255, 205, 60 )
local Table = { }
local Table2 = { }
local Table3 = { }
local Table4 = { }
local Table5 = { }
local Table6 = { }

local function Sweep()
    local Value1
    local TableInner = { Table, Table2, Table3, Table4, Table6, Table5 }
    Value1 = nil

    for Key, Value in TableInner, nil, nil do
        local Value2 = nil

        for Value3 in Value, nil, nil do
            if not Value3:IsDescendantOf( workspace ) then
                Value[ Value3 ] = nil
            end
        end
    end
end

local function Kd( Amount, Amount2 )
    return string.format( "%.2f", ( Amount or 0 ) / math.max( Amount2 or 0, 1 ) )
end

local Table7 = {
    kills = { player = "PLAYER", cols = { KD = "KILLS" }, empty = "NO KILLS YET" },
    kd = {
        player = "PLAYER",
        cols = { Deaths = "KILLS", KD = "K/D" },
        empty = "NO K/D YET (%d KILLS MIN.)"
    },
    money = { player = "PLAYER", cols = { KD = "MONEY" }, empty = "NO MONEY YET" },
    crews = {
        player = "CREW",
        cols = { Deaths = "MEMBERS", KD = "KILLS" },
        empty = "NO CREWS YET"
    },
    clans = { player = "CLAN", cols = { KD = "KILLS" }, empty = "NO CLANS YET" }
}

local function Esc( Argument1 )
    return ( tostring( Argument1 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) )
end

local Flag = false

local function ClanBoard()
    local Value
    local ClanBoardData = ReplicatedStorage:FindFirstChild( "ClanBoardData" )
    local JSONDecode = HttpService.JSONDecode
    Value = ClanBoardData and ClanBoardData.Value ~= "" and ClanBoardData.Value or "{}"
    local Top
    local Success, Result = pcall( JSONDecode, HttpService, Value )
    local Table = { }
    local Table2 = { }
    Top = Success and type( Result ) == "table" and type( Result.top ) == "table" and Result.top or { }
    local Value1 = nil

    for Key, Value2 in Top, nil, nil do
        if type( Value2 ) == "table" then
            local Id = Value2.id
            local TagRich = ClanShared.TagRich( tostring( Value2.t ), Value2.c )
            local Text = TagRich .. " " .. tostring( Value2.n ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
            table.insert( Table, { id = Id, n = Text, k = Value2.k, raw = Value2 } )
            table.insert( Table2, Value2.id )
        end
    end

    return { top = Table, ids = Table2 }
end

local Table8 = { "Kills", "Deaths", "KD" }

local function Fill( Object, Text, Text2, List, Enabled )
    local function Set( Name, Text )
        local FoundChild = Object:FindFirstChild( Name )

        if FoundChild then
            FoundChild.Text = Text
        end
    end

    local Rank = Object:FindFirstChild( "Rank" )

    if Rank then
        Rank.Text = Text
    end

    local Player = Object:FindFirstChild( "Player" )

    if Player and Player.RichText ~= Flag then
        Player.RichText = Flag
    end

    local Player2 = Object:FindFirstChild( "Player" )

    if Player2 then
        Player2.Text = Text2
    end

    local Value1 = nil

    for Key, Value in Table8, nil, nil do
        local FoundChild = Object:FindFirstChild( Value )

        if FoundChild then
            local FlagInner
            local Text3 = List[ Value ]
            local Visible = FoundChild.Visible
            FlagInner = Text3 ~= nil and true or false

            if Visible ~= FlagInner then
                local Visible2 = Text3 ~= nil and true or false
                FoundChild.Visible = Visible2
            end
            if Text3 ~= nil then
                FoundChild.Text = Text3
            end
        end
    end

    local MineStroke = Object:FindFirstChild( "MineStroke" )
    local OtherStroke = Object:FindFirstChild( "OtherStroke" )

    if MineStroke then
        MineStroke.Enabled = Enabled
    end
    if OtherStroke then
        OtherStroke.Enabled = not Enabled
    end
end

local function RowValues( ValuesName, Argument2 )
    if ValuesName == "kills" then
        return { KD = tostring( Argument2.k or 0 ) }
    end
    if ValuesName == "kd" then
        return {
            Deaths = tostring( Argument2.k or 0 ),
            KD = string.format( "%.2f", ( Argument2.r or 0 ) / 100 )
        }
    end
    if ValuesName == "money" then
        return { KD = MoneyFormat( Argument2.m or 0 ) }
    end
    if ValuesName == "clans" then
        return { KD = tostring( Argument2.k or 0 ) }
    end
    return {
        Deaths = tostring( Argument2.mem or 0 ),
        KD = tostring( Argument2.k or 0 )
    }
end

local function SizeRows( RowsName )
    local Offset2
    local Max = math.max( RowsName:GetAttribute( "VisibleRows" ) or 7, 1 )
    local UIPadding = RowsName:FindFirstChildOfClass( "UIPadding" )

    if UIPadding then
        local Offset = UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset

        if Offset then
            Offset2 = Offset
        else
            Offset2 = 0
        end
    else
        Offset2 = 0
    end

    local Floor
    local Y = RowsName.AbsoluteSize.Y - Offset2
    local Max2 = math.max( math.floor( Y / ( Max + ( Max - 1 ) * 0.1 ) ), 8 )

    if Max > 1 then
        local Max3 = math.max( math.floor( ( Y - Max * Max2 ) / ( Max - 1 ) ), 0 )

        if Max3 then
            Floor = Max3
        else
            Floor = math.floor( Max2 * 0.1 )
        end
    else
        Floor = math.floor( Max2 * 0.1 )
    end

    Table2[ RowsName ] = Max2 + Floor
    local UIListLayout = RowsName:FindFirstChildOfClass( "UIListLayout" )

    if UIListLayout and UIListLayout.Padding ~= UDim.new( 0, Floor ) then
        UIListLayout.Padding = UDim.new( 0, Floor )
    end

    local Number = 0

    for Key, Value in RowsName:GetChildren( ) do
        if Value.Name == "Row" then
            Number = Number + 1

            if Value.Size ~= UDim2.new( 1, 0, 0, Max2 ) then
                Value.Size = UDim2.new( 1, 0, 0, Max2 )
            end
        end
    end

    local CanvasSize = UDim2.fromOffset( 0, Number * Max2 + math.max( Number - 1, 0 ) * Floor + Offset2 )

    if RowsName.CanvasSize ~= CanvasSize then
        RowsName.CanvasSize = CanvasSize
    end
end

local function Render( Window )
    local Result2
    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, WorldLeaderboardData.Value )
    Result2 = ( not Success or type( Result ) ~= "table" ) and { } or Result
    local Entry2
    local Entry = Table4[ Window ] or "kills"
    Entry2 = if Entry ~= "clans" or Enabled then Entry else "kills"
    local Entry4
    local Entry3 = Table7[ Entry2 ]

    if Entry2 == "clans" then
        local ClanBoard2 = ClanBoard( )

        if ClanBoard2 then
            Entry4 = ClanBoard2
        elseif type( Result2[ Entry2 ] ) ~= "table" or not Result2[ Entry2 ] then
            Entry4 = { }
        else
            Entry4 = Result2[ Entry2 ]
        end
    elseif type( Result2[ Entry2 ] ) ~= "table" or not Result2[ Entry2 ] then
        Entry4 = { }
    else
        Entry4 = Result2[ Entry2 ]
    end

    local Top2
    local Top = Entry4.top
    Top2 = if Top then Top else { }
    local Ids2
    local Ids = Entry4.ids
    Ids2 = if Ids then Ids else { }
    local FlagInner = Entry2 == "clans" and true or false
    local RowTemplate
    Flag = FlagInner
    local Number = tonumber( Result2.kdMin ) or 20
    local Parent = Window:FindFirstChild( "List" )

    if Parent then
        RowTemplate = Parent:FindFirstChild( "RowTemplate" )
    else
        RowTemplate = Parent
    end
    if not RowTemplate then
        return
    end

    local Header = Window:FindFirstChild( "Header" )

    if Header then
        local Player = Header:FindFirstChild( "Player" )

        if Player then
            Player.Text = Entry3.player
        end

        local Value2 = nil

        for Key2, Value in Table8, nil, nil do
            local FoundChild = Header:FindFirstChild( Value )

            if FoundChild then
                local Visible = Entry3.cols[ Value ] ~= nil and true or false
                FoundChild.Visible = Visible

                if Entry3.cols[ Value ] then
                    FoundChild.Text = Entry3.cols[ Value ]
                end
            end
        end
    end

    local You2
    local You = Window:FindFirstChild( "You" )

    if You then
        local Player2 = You:FindFirstChild( "Player" )

        if Player2 then
            You2 = You.Player.TextColor3
        else
            You2 = Player2
        end
    else
        You2 = You
    end

    local Header2

    if Header then
        local Rank = Header:FindFirstChild( "Rank" )

        if Rank then
            Header2 = Header.Rank.TextColor3
        else
            Header2 = Rank
        end
    else
        Header2 = Header
    end

    local Children
    local Tabs = Window:FindFirstChild( "Tabs" )
    Children = Tabs and Tabs:GetChildren( ) or { }
    local Value3 = nil

    for Key3, Value4 in Children, nil, nil do
        if Value4:GetAttribute( "Board" ) == "clans" and Value4.Visible ~= Enabled then
            Value4.Visible = Enabled
        end
        if Value4:GetAttribute( "Board" ) then
            local EnabledInner = Value4:GetAttribute( "Board" ) == Entry2 and true or false
            local MineStroke = Value4:FindFirstChild( "MineStroke" )
            local OtherStroke = Value4:FindFirstChild( "OtherStroke" )
            local Label = Value4:FindFirstChild( "Label" )

            if MineStroke then
                MineStroke.Enabled = EnabledInner
            end
            if OtherStroke then
                OtherStroke.Enabled = not EnabledInner
            end
            if Label and You2 and Header2 then
                local TextColor32 = if not EnabledInner or not You2 then Header2 else You2
                Label.TextColor3 = TextColor32
            end
        end
    end

    local Season = Window:FindFirstChild( "Season" )

    if Season then
        local Entry6
        local Entry5 = Table6[ Window ]
        Entry6 = if Entry5 then Entry5 else Season.Text
        local Text
        Table6[ Window ] = Entry6
        local Season2 = Entry3.season
        Text = if Season2 then Season2 else Table6[ Window ]
        Season.Text = Text
    end

    local CrewKey = LocalPlayer:GetAttribute( "CrewKey" )
    local Table = { }

    for Key4, Value5 in Parent:GetChildren( ) do
        if Value5.Name == "Row" then
            Table[ Value5.LayoutOrder ] = Value5
        end
    end

    local Rank4
    local Rank2 = RowTemplate:FindFirstChild( "Rank" )
    Rank4 = if Rank2 then RowTemplate.Rank.TextColor3 else Rank2
    local Value6 = nil

    for Key5, Value7 in Top2, nil, nil do
        local Entry8
        local Entry7 = Table[ Key5 ]
        Table[ Key5 ] = nil

        if Entry7 then
            Entry8 = Entry7
        else
            local Clone = RowTemplate:Clone( )
            Clone.Name = "Row"
            Clone.Visible = true
            Clone.LayoutOrder = Key5
            Clone.Parent = Parent
            Entry8 = Clone
        end

        local Flag2

        if Entry2 == "crews" then
            if CrewKey == nil then
                Flag2 = false
            elseif Value7.id == CrewKey then
                Flag2 = true
            else
                Flag2 = false
            end
        elseif Entry2 == "clans" then
            if Value7.id == nil then
                Flag2 = false
            elseif Value7.id == LocalPlayer:GetAttribute( "ClanId" ) then
                Flag2 = true
            else
                Flag2 = false
            end
        elseif Value7.id == LocalPlayer.UserId then
            Flag2 = true
        else
            Flag2 = false
        end

        local Text10 = "#" .. Key5
        local Text11 = tostring( Value7.n )
        Fill( Entry8, Text10, Text11, RowValues( Entry2, Value7 ), Flag2 )

        if Entry2 ~= "clans" or type( Value7.raw ) ~= "table" then
            Table5[ Entry8 ] = nil
        else
            local Raw = Value7.raw
            Table5[ Entry8 ] = {
                id = Raw.id,
                t = Raw.t,
                n = Raw.n,
                k = Raw.k,
                c = Raw.c,
                h = Raw.h,
                a = Raw.a,
                rank = Key5
            }
        end

        local Rank3 = Entry8:FindFirstChild( "Rank" )

        if Rank3 and Rank4 then
            local TextColor3 = Key5 == 1 and FromRGB or Rank4
            Rank3.TextColor3 = TextColor3
        end
    end

    local Value8 = nil

    for Key6, Value9 in Table, nil, nil do
        Table5[ Value9 ] = nil
        Value9:Destroy( )
    end

    SizeRows( Parent )
    local Empty = Window:FindFirstChild( "Empty" )

    if Empty then
        local Visible2 = #Top2 == 0 and true or false
        Empty.Visible = Visible2
        Empty.Text = Entry3.empty:format( Number )
    end
    if You then
        local Text3, Text9, Table5Inner

        if Entry2 == "clans" then
            local ClanId = LocalPlayer:GetAttribute( "ClanId" )
            local ClanTag = LocalPlayer:GetAttribute( "ClanTag" )

            if not ClanId or not ClanTag then
                Text9 = "-"
                Text3 = "NO CLAN"
                Table5Inner = { KD = "-" }
            else
                local Text2
                local Find = table.find( Ids2, ClanId )
                Text2 = Find and "#" .. Find or "-"
                local KD
                local TagRich = ClanShared.TagRich( tostring( ClanTag ), LocalPlayer:GetAttribute( "ClanColor" ) )
                Text3 = TagRich .. " " .. tostring( LocalPlayer:GetAttribute( "ClanName" ) or "" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
                local Table2 = { }

                if not Find or not Top2[ Find ] then
                    KD = "-"
                else
                    local Text4 = tostring( Top2[ Find ].k or 0 )

                    if Text4 then
                        KD = Text4
                    else
                        KD = "-"
                    end
                end

                Table2.KD = KD
                Text9 = Text2
                Table5Inner = Table2
            end
        elseif Entry2 == "crews" then
            local Find3

            if CrewKey == nil then
                Find3 = nil
            else
                local Find2 = table.find( Ids2, CrewKey )

                if Find2 then
                    Find3 = Find2
                else
                    Find3 = nil
                end
            end

            local CrewName = LocalPlayer:GetAttribute( "CrewName" )

            if not CrewName or CrewKey == nil then
                Text9 = "-"
                Text3 = "NO CREW"
                Table5Inner = { Deaths = "-", KD = "-" }
            else
                local Number3
                local Number2 = tonumber( LocalPlayer:GetAttribute( "CrewKills" ) ) or 0
                Number3 = 0

                for Key7, Value10 in Players:GetPlayers( ) do
                    if Value10:GetAttribute( "CrewKey" ) == CrewKey then
                        Number3 = Number3 + 1
                    end
                end

                local Text5

                if not Find3 or not ( "#" .. Find3 ) then
                    if Number2 > 0 then
                        Text5 = "100+"
                    else
                        Text5 = "-"
                    end
                else
                    Text5 = "#" .. Find3
                end

                local Mem2
                Text3 = tostring( CrewName )
                local Table3 = { }

                if not Find3 or not Top2[ Find3 ] then
                    Mem2 = Number3
                else
                    local Mem = Top2[ Find3 ].mem

                    if Mem then
                        Mem2 = Mem
                    else
                        Mem2 = Number3
                    end
                end

                Table3.Deaths = tostring( Mem2 )
                Table3.KD = tostring( Number2 )
                Text9 = Text5
                Table5Inner = Table3
            end
        else
            local Board_Kills = LocalPlayer:GetAttribute( "Board_Kills" ) or 0
            local Board_Deaths = LocalPlayer:GetAttribute( "Board_Deaths" ) or 0
            local Find4 = table.find( Ids2, LocalPlayer.UserId )
            Text3 = LocalPlayer.DisplayName

            if Entry2 == "kills" then
                local Text6

                if not Find4 or not ( "#" .. Find4 ) then
                    if Board_Kills > 0 then
                        Text6 = "100+"
                    else
                        Text6 = "-"
                    end
                else
                    Text6 = "#" .. Find4
                end

                Text9 = Text6
                Table5Inner = { KD = tostring( Board_Kills ) }
            elseif Entry2 == "kd" then
                local Text7

                if not Find4 or not ( "#" .. Find4 ) then
                    if Number <= Board_Kills then
                        Text7 = "100+"
                    else
                        Text7 = "-"
                    end
                else
                    Text7 = "#" .. Find4
                end

                local KD2
                local Table4Inner = { Deaths = tostring( Board_Kills ) }

                if Number <= Board_Kills then
                    local Format = string.format( "%.2f", ( Board_Kills or 0 ) / math.max( Board_Deaths or 0, 1 ) )

                    if Format then
                        KD2 = Format
                    else
                        KD2 = "-"
                    end
                else
                    KD2 = "-"
                end

                Table4Inner.KD = KD2
                Text9 = Text7
                Table5Inner = Table4Inner
            else
                local Text8
                local Number4 = tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0

                if not Find4 or not ( "#" .. Find4 ) then
                    if Number4 > 0 then
                        Text8 = "100+"
                    else
                        Text8 = "-"
                    end
                else
                    Text8 = "#" .. Find4
                end

                Text9 = Text8
                Table5Inner = { KD = MoneyFormat( Number4 ) }
            end
        end

        Fill( You, Text9, Text3, Table5Inner, true )
        You.Visible = true
    end
end

local function Refresh( Argument1 )
    for Key, Value in CollectionService:GetTagged( "WorldLeaderboard" ) do
        local Window
        local IsDescendantOf = Value:IsDescendantOf( workspace )

        if IsDescendantOf then
            Window = Value:FindFirstChild( "Window" )
        else
            Window = IsDescendantOf
        end
        if Window then
            if Argument1 or not Table[ Window ] then
                if not Table[ Window ] then
                    Table[ Window ] = true
                    local List = Window:FindFirstChild( "List" )

                    if List then
                        List:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
                            SizeRows( List )
                        end )
                    end
                end

                Render( Window )
            end
        end
    end
end

local function Aimed( Argument1 )
    local FilterDescendantsInstances = { }
    local Table = { }

    for Key, Value in CollectionService:GetTagged( "WorldLeaderboard" ) do
        local Parent = Value.Parent

        if Parent and Parent:IsA( "BasePart" ) and Value:IsDescendantOf( workspace ) then
            table.insert( FilterDescendantsInstances, Parent )
            Table[ Parent ] = Value
        end
    end
    if #FilterDescendantsInstances == 0 then
        return nil
    end

    local RaycastParams2 = RaycastParams.new( )
    RaycastParams2.FilterType = Enum.RaycastFilterType.Include
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Origin = Argument1.Origin
    local Raycast = workspace:Raycast( Origin, Argument1.Direction * 300, RaycastParams2 )

    if not Raycast then
        return nil
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not HumanoidRootPart or ( Raycast.Position - HumanoidRootPart.Position ).Magnitude > 30 then
        return nil
    end

    local VectorToWorldSpace
    local Entry = Table[ Raycast.Instance ]

    if Entry then
        VectorToWorldSpace = Raycast.Instance.CFrame:VectorToWorldSpace( Vector3.FromNormalId( Entry.Face ) )
    else
        VectorToWorldSpace = Entry
    end
    if not VectorToWorldSpace or VectorToWorldSpace:Dot( Raycast.Normal ) < 0.9 then
        return nil
    end

    local List
    local Window = Entry:FindFirstChild( "Window" )

    if Window then
        List = Window:FindFirstChild( "List" )
    else
        List = Window
    end
    if not List or not List:IsA( "ScrollingFrame" ) then
        return nil
    end
    return List, Entry, Raycast.Position
end

local function MaxY( Argument1 )
    return ( math.max( Argument1.AbsoluteCanvasSize.Y - Argument1.AbsoluteWindowSize.Y, 0 ) )
end

local function GuiPoint( Argument1, Argument2 )
    local X, Y, X2, Y2
    local Parent = Argument1.Parent
    local PointToObjectSpace = Parent.CFrame:PointToObjectSpace( Argument2 )
    local Size = Parent.Size
    local Face = Argument1.Face

    if Face == Enum.NormalId.Front then
        X = Size.X / 2 - PointToObjectSpace.X
        Y = Size.Y / 2 - PointToObjectSpace.Y
        X2 = Size.X
        Y2 = Size.Y

        if Argument1.SizingMode == Enum.SurfaceGuiSizingMode.PixelsPerStud then
            return Vector2.new( X, Y ) * Argument1.PixelsPerStud
        end
        return Vector2.new( X / X2 * Argument1.CanvasSize.X, Y / Y2 * Argument1.CanvasSize.Y )
    elseif Face == Enum.NormalId.Back then
        X = PointToObjectSpace.X + Size.X / 2
        Y = Size.Y / 2 - PointToObjectSpace.Y
        X2 = Size.X
        Y2 = Size.Y

        if Argument1.SizingMode == Enum.SurfaceGuiSizingMode.PixelsPerStud then
            return Vector2.new( X, Y ) * Argument1.PixelsPerStud
        end
        return Vector2.new( X / X2 * Argument1.CanvasSize.X, Y / Y2 * Argument1.CanvasSize.Y )
    elseif Face == Enum.NormalId.Right then
        X = Size.Z / 2 - PointToObjectSpace.Z
        Y = Size.Y / 2 - PointToObjectSpace.Y
        X2 = Size.Z
        Y2 = Size.Y

        if Argument1.SizingMode == Enum.SurfaceGuiSizingMode.PixelsPerStud then
            return Vector2.new( X, Y ) * Argument1.PixelsPerStud
        end
        return Vector2.new( X / X2 * Argument1.CanvasSize.X, Y / Y2 * Argument1.CanvasSize.Y )
    else
        if Face ~= Enum.NormalId.Left then
            return nil
        end

        X = PointToObjectSpace.Z + Size.Z / 2
        Y = Size.Y / 2 - PointToObjectSpace.Y
        X2 = Size.Z
        Y2 = Size.Y

        if Argument1.SizingMode == Enum.SurfaceGuiSizingMode.PixelsPerStud then
            return Vector2.new( X, Y ) * Argument1.PixelsPerStud
        end
        return Vector2.new( X / X2 * Argument1.CanvasSize.X, Y / Y2 * Argument1.CanvasSize.Y )
    end
end

local function PickTab( Argument1 )
    local Window
    local _, Value1, Value2 = Aimed( Argument1 )

    if Value1 then
        Window = Value1:FindFirstChild( "Window" )
    else
        Window = Value1
    end

    local Tabs

    if Window then
        Tabs = Window:FindFirstChild( "Tabs" )
    else
        Tabs = Window
    end

    local Window2

    if Tabs then
        Window2 = GuiPoint( Value1, Value2 )
    else
        Window2 = Tabs
    end
    if not Window2 then
        return false
    end
    for Key, Value in Tabs:GetChildren( ) do
        local Board
        local IsA = Value:IsA( "GuiObject" )

        if IsA then
            local Visible = Value.Visible

            if Visible then
                Board = Value:GetAttribute( "Board" )
            else
                Board = Visible
            end
        else
            Board = IsA
        end
        if Board and Table7[ Board ] then
            local AbsolutePosition = Value.AbsolutePosition
            local AbsoluteSize = Value.AbsoluteSize
            local X = Window2.X

            if AbsolutePosition.X <= X and Window2.X <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y <= Window2.Y then
                if Window2.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                    if Table4[ Window ] ~= Board then
                        Table4[ Window ] = Board
                        local List = Window:FindFirstChild( "List" )

                        if List then
                            Table3[ List ] = nil
                            List.CanvasPosition = Vector2.zero
                        end

                        Render( Window )
                    end

                    return true
                end
            end
        end
    end

    return false
end

local function PickClan( Argument1 )
    local Window
    local _, Value1, Value2 = Aimed( Argument1 )

    if Value1 then
        Window = Value1:FindFirstChild( "Window" )
    else
        Window = Value1
    end
    if not Window or Table4[ Window ] ~= "clans" or not Enabled then
        return false
    end

    local GuiPoint2 = GuiPoint( Value1, Value2 )

    if not GuiPoint2 then
        return false
    end

    local Entry

    local function Inside( Argument1 )
        local Flag
        local AbsolutePosition = Argument1.AbsolutePosition
        local AbsoluteSize = Argument1.AbsoluteSize
        local X = GuiPoint2.X

        if AbsolutePosition.X <= X then
            if GuiPoint2.X <= AbsolutePosition.X + AbsoluteSize.X then
                local Y = GuiPoint2.Y

                if AbsolutePosition.Y <= Y then
                    if GuiPoint2.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end

        return Flag
    end

    local List = Window:FindFirstChild( "List" )
    local You = Window:FindFirstChild( "You" )

    if List then
        local Flag
        local AbsolutePosition = List.AbsolutePosition
        local AbsoluteSize = List.AbsoluteSize
        local X = GuiPoint2.X

        if AbsolutePosition.X <= X then
            if GuiPoint2.X <= AbsolutePosition.X + AbsoluteSize.X then
                local Y = GuiPoint2.Y

                if AbsolutePosition.Y <= Y then
                    if GuiPoint2.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end
        if Flag then
            for Key, Value in List:GetChildren( ) do
                if Table5[ Value ] then
                    local Flag2
                    local AbsolutePosition2 = Value.AbsolutePosition
                    local AbsoluteSize2 = Value.AbsoluteSize
                    local X2 = GuiPoint2.X

                    if AbsolutePosition2.X <= X2 then
                        if GuiPoint2.X <= AbsolutePosition2.X + AbsoluteSize2.X then
                            local Y2 = GuiPoint2.Y

                            if AbsolutePosition2.Y <= Y2 then
                                if GuiPoint2.Y <= AbsolutePosition2.Y + AbsoluteSize2.Y then
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
                    else
                        Flag2 = false
                    end
                    if Flag2 then
                        Entry = Table5[ Value ]

                        if not Entry then
                            return false
                        end

                        local Clan
                        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                        if PlayerGui then
                            Clan = PlayerGui:FindFirstChild( "Clan" )
                        else
                            Clan = PlayerGui
                        end

                        local OpenClanView

                        if Clan then
                            OpenClanView = Clan:FindFirstChild( "OpenClanView" )
                        else
                            OpenClanView = Clan
                        end
                        if OpenClanView and OpenClanView:IsA( "BindableEvent" ) then
                            OpenClanView:Fire( Entry )
                        end

                        return true
                    end
                end
            end

            Entry = nil
        elseif not You or not You.Visible then
            Entry = nil
        else
            local AbsolutePosition3 = You.AbsolutePosition
            local AbsoluteSize3 = You.AbsoluteSize
            local X3 = GuiPoint2.X

            if AbsolutePosition3.X <= X3 then
                if GuiPoint2.X <= AbsolutePosition3.X + AbsoluteSize3.X then
                    local Y3 = GuiPoint2.Y

                    if AbsolutePosition3.Y <= Y3 then
                        if GuiPoint2.Y <= AbsolutePosition3.Y + AbsoluteSize3.Y then
                            Flag3 = true
                        else
                            Flag3 = false
                        end
                    else
                        Flag3 = false
                    end
                else
                    Flag3 = false
                end
            else
                Flag3 = false
            end
            if not Flag3 or not LocalPlayer:GetAttribute( "ClanId" ) then
                Entry = nil
            else
                Entry = { id = LocalPlayer:GetAttribute( "ClanId" ) }
            end
        end
    elseif not You or not You.Visible then
        Entry = nil
    else
        local Flag3
        local AbsolutePosition3 = You.AbsolutePosition
        local AbsoluteSize3 = You.AbsoluteSize
        local X3 = GuiPoint2.X

        if AbsolutePosition3.X <= X3 then
            if GuiPoint2.X <= AbsolutePosition3.X + AbsoluteSize3.X then
                local Y3 = GuiPoint2.Y

                if AbsolutePosition3.Y <= Y3 then
                    if GuiPoint2.Y <= AbsolutePosition3.Y + AbsoluteSize3.Y then
                        Flag3 = true
                    else
                        Flag3 = false
                    end
                else
                    Flag3 = false
                end
            else
                Flag3 = false
            end
        else
            Flag3 = false
        end
        if not Flag3 or not LocalPlayer:GetAttribute( "ClanId" ) then
            Entry = nil
        else
            Entry = { id = LocalPlayer:GetAttribute( "ClanId" ) }
        end
    end
    if not Entry then
        return false
    end

    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui then
        Clan = PlayerGui:FindFirstChild( "Clan" )
    else
        Clan = PlayerGui
    end
    if Clan then
        OpenClanView = Clan:FindFirstChild( "OpenClanView" )
    else
        OpenClanView = Clan
    end
    if OpenClanView and OpenClanView:IsA( "BindableEvent" ) then
        OpenClanView:Fire( Entry )
    end

    return true
end

UserInputService.InputBegan:Connect( function( Argument1 )
    local Flag = if Argument1.KeyCode == Enum.KeyCode.ButtonA then GamepadService.GamepadCursorEnabled else false

    if Argument1.UserInputType ~= Enum.UserInputType.MouseButton1 and not Flag then
        return
    end

    local GuiObjectsAtPosition2
    local MouseLocation = UserInputService:GetMouseLocation( )
    local GuiInset = GuiService:GetGuiInset( )
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui then
        local GuiObjectsAtPosition = PlayerGui:GetGuiObjectsAtPosition( MouseLocation.X - GuiInset.X, MouseLocation.Y - GuiInset.Y )

        if GuiObjectsAtPosition then
            GuiObjectsAtPosition2 = GuiObjectsAtPosition
        else
            GuiObjectsAtPosition2 = { }
        end
    else
        GuiObjectsAtPosition2 = { }
    end

    local Value1 = nil

    for Key, Value in GuiObjectsAtPosition2, nil, nil do
        if Value.Visible then
            if not Value:IsA( "GuiButton" ) then
                if not Value:IsA( "TextBox" ) then
                    continue
                end
            end

            return
        end
    end

    local ViewportPointToRay = workspace.CurrentCamera:ViewportPointToRay( MouseLocation.X, MouseLocation.Y )

    if not PickTab( ViewportPointToRay ) then
        PickClan( ViewportPointToRay )
    end
end )
UserInputService.InputChanged:Connect( function( Argument1, Argument2 )
    if Argument2 or Argument1.UserInputType ~= Enum.UserInputType.MouseWheel then
        return
    end

    local MouseLocation = UserInputService:GetMouseLocation( )
    local Aimed2 = Aimed( workspace.CurrentCamera:ViewportPointToRay( MouseLocation.X, MouseLocation.Y ) )

    if not Aimed2 then
        return
    end

    local Entry2
    local Entry = Table3[ Aimed2 ]
    Entry2 = if Entry then Entry else Aimed2.CanvasPosition.Y
    local Entry3 = Entry2 - Argument1.Position.Z * ( Table2[ Aimed2 ] or 80 )
    Table3[ Aimed2 ] = math.clamp( Entry3, 0, ( math.max( Aimed2.AbsoluteCanvasSize.Y - Aimed2.AbsoluteWindowSize.Y, 0 ) ) )
end )
RunService.RenderStepped:Connect( function( Amount )
    local Value1 = nil

    for Key, Value in Table3, nil, nil do
        if Key.Parent then
            local Y2
            local Y = Key.CanvasPosition.Y
            Y2 = math.abs( Value - Y ) < 0.5 and Value or Y + ( Value - Y ) * math.min( 1, Amount * 16 )
            Key.CanvasPosition = Vector2.new( 0, Y2 )

            if Y2 == Value then
                Table3[ Key ] = nil
            end
        else
            Table3[ Key ] = nil
        end
    end
end )
local Table9 = { }

local function CanvasPerPixel( Argument1, Argument2 )
    local PixelsPerStud
    local Parent = Argument1.Parent
    local CurrentCamera = workspace.CurrentCamera
    local WorldToScreenPoint = CurrentCamera:WorldToScreenPoint( Argument2 )
    local WorldToScreenPoint2 = CurrentCamera:WorldToScreenPoint( Argument2 + Parent.CFrame.UpVector )
    local Max = math.max( ( Vector2.new( WorldToScreenPoint.X, WorldToScreenPoint.Y ) - Vector2.new( WorldToScreenPoint2.X, WorldToScreenPoint2.Y ) ).Magnitude, 1 )
    PixelsPerStud = Argument1.SizingMode == Enum.SurfaceGuiSizingMode.PixelsPerStud and Argument1.PixelsPerStud or Argument1.CanvasSize.Y / Parent.Size.Y
    return PixelsPerStud / Max
end

UserInputService.TouchStarted:Connect( function( Key, Argument2 )
    if Argument2 then
        return
    end

    local Position = Key.Position
    local Value1, Value2, Value3 = Aimed( workspace.CurrentCamera:ScreenPointToRay( Position.X, Position.Y ) )

    if Value1 then
        Controls.ReleaseTouch( Key )
        Table9[ Key ] = {
            list = Value1,
            start = Vector2.new( Position.X, Position.Y ),
            k = CanvasPerPixel( Value2, Value3 ),
            decided = false
        }
        return
    end
    return
end )
UserInputService.TouchMoved:Connect( function( Key )
    local Entry = Table9[ Key ]

    if not Entry then
        return
    end

    local Last = Vector2.new( Key.Position.X, Key.Position.Y )

    if not Entry.decided then
        local Vector22 = Last - Entry.start

        if Vector22.Magnitude < 8 then
            return
        end

        Entry.decided = true
        local Abs = math.abs( Vector22.X )

        if math.abs( Vector22.Y ) < Abs then
            Table9[ Key ] = nil
            Controls.LookTouch( Key )
            return
        end

        Entry.last = Entry.start
    end

    local Y = Entry.list.CanvasPosition.Y - ( Last.Y - Entry.last.Y ) * Entry.k
    local List = Entry.list
    local Clamp = math.clamp( Y, 0, ( math.max( List.AbsoluteCanvasSize.Y - List.AbsoluteWindowSize.Y, 0 ) ) )
    Entry.last = Last
    Table3[ Entry.list ] = nil
    local List2 = Entry.list
    List2.CanvasPosition = Vector2.new( 0, Clamp )
end )
UserInputService.TouchEnded:Connect( function( Key )
    local Entry = Table9[ Key ]
    Table9[ Key ] = nil

    if Entry and not Entry.decided then
        local ScreenPointToRay = workspace.CurrentCamera:ScreenPointToRay( Entry.start.X, Entry.start.Y )

        if not PickTab( ScreenPointToRay ) then
            PickClan( ScreenPointToRay )
        end
    end
end )
WorldLeaderboardData:GetPropertyChangedSignal( "Value" ):Connect( function()
    Refresh( true )
end )
LocalPlayer:GetAttributeChangedSignal( "Stat_Kills" ):Connect( function()
    Refresh( true )
end )
LocalPlayer:GetAttributeChangedSignal( "Stat_Deaths" ):Connect( function()
    Refresh( true )
end )
LocalPlayer:GetAttributeChangedSignal( "Board_Kills" ):Connect( function()
    Refresh( true )
end )
LocalPlayer:GetAttributeChangedSignal( "Board_Deaths" ):Connect( function()
    Refresh( true )
end )
local Table10 = { "Money", "CrewKey", "CrewName", "CrewKills" }
Value1 = nil

for Key, Value in Table10, nil, nil do
    LocalPlayer:GetAttributeChangedSignal( Value ):Connect( function()
        Refresh( true )
    end )
end
if Enabled then
    local function Hook( Object )
        Object:GetPropertyChangedSignal( "Value" ):Connect( function()
            Refresh( true )
        end )
    end

    local ClanBoardData = ReplicatedStorage:FindFirstChild( "ClanBoardData" )

    if ClanBoardData then
        ClanBoardData:GetPropertyChangedSignal( "Value" ):Connect( function()
            Refresh( true )
        end )
    end

    local Value2
    ReplicatedStorage.ChildAdded:Connect( function( Self )
        if Self.Name == "ClanBoardData" and Self:IsA( "StringValue" ) then
            Self:GetPropertyChangedSignal( "Value" ):Connect( function()
                Refresh( true )
            end )
            Refresh( true )
        end
    end )
    local Table11 = { "ClanId", "ClanTag", "ClanName", "ClanColor" }
    Value2 = nil

    for Key2, Value3 in Table11, nil, nil do
        LocalPlayer:GetAttributeChangedSignal( Value3 ):Connect( function()
            Refresh( true )
        end )
    end
end

CollectionService:GetInstanceAddedSignal( "WorldLeaderboard" ):Connect( function( Object )
    Object:WaitForChild( "Window", 10 )
    Refresh( false )
end )
CollectionService:GetInstanceRemovedSignal( "WorldLeaderboard" ):Connect( function()
    task.defer( Sweep )
end )
Refresh( true )
