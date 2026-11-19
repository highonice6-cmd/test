-- StarterPlayer.StarterPlayerScripts.BetaRollClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local GuiService = game:GetService( "GuiService" )
local HttpService = game:GetService( "HttpService" )
local BetaWeaponRoll = ReplicatedStorage:WaitForChild( "BetaWeaponRoll" )
local BetaWeaponRoll2 = require( BetaWeaponRoll )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local ItemRender = require( Weapons:WaitForChild( "ItemRender" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local ScaleUI = require( ReplicatedStorage:WaitForChild( "ScaleUI" ) )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local FromRGB = Color3.fromRGB( 255, 205, 60 )
local Table = { AK = "AK-47" }

local function InIntermission()
    local Active2
    local Active = BetaWeaponRoll2.Active( )

    if Active then
        if BetaWeaponRoll:GetAttribute( "Intermission" ) == true then
            Active2 = true
        else
            Active2 = false
        end
    else
        Active2 = Active
    end

    return Active2
end

local function HiddenByMenu()
    local Flag = ClientState.WardrobeOpen == true and true or false
    return Flag
end

task.spawn( function()
    local Find, Value1, Value2, Position, Value3
    Find = nil
    Value1 = nil
    Value2 = nil
    Position = nil
    Value3 = nil

    while true do
        if not Find or not Find.Parent or not Value1 or not Value1.Parent or not Value2 or not Value2.Parent then
            local Timer
            local Find2 = Screens.Find( "BetaRollTimer", PlayerGui )

            if Find2 then
                Timer = Find2:FindFirstChild( "Timer" )
            else
                Timer = Find2
            end
            if Timer then
                Timer = Timer:FindFirstChildWhichIsA( "TextLabel", true )
            end
            if nil then
                Timer = ( nil ).Position
            end

            Value1 = nil
            Value2 = nil
            Find = Find2
            Position = Timer
            Value3 = nil
        end
        if Value1 and Value2 then
            local Frame
            local Speedometer = PlayerGui:FindFirstChild( "Speedometer" )

            if Speedometer then
                local Enabled = Speedometer.Enabled

                if Enabled then
                    Frame = Speedometer:FindFirstChildWhichIsA( "Frame" )
                else
                    Frame = Enabled
                end
            else
                Frame = Speedometer
            end

            local ScreenGui

            if not Find:IsA( "ScreenGui" ) or not Find then
                ScreenGui = Find:FindFirstAncestorOfClass( "ScreenGui" )
            else
                ScreenGui = Find
            end

            local Max

            if not Frame or not Frame.Visible or not ScreenGui then
                Max = 0
            else
                local Y = GuiService:GetGuiInset( ).Y
                local Swap = Y
                local Y2 = Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y

                if Speedometer.IgnoreGuiInset then
                    Y = 0
                end

                local Number
                local Y3 = Y2 + Y
                local Scale = Position.Y.Scale * Find.AbsoluteSize.Y + Position.Y.Offset
                Number = if ScreenGui.IgnoreGuiInset then 0 else Swap
                local Scale2 = Scale + Number
                Max = math.max( 0, ( math.ceil( Y3 + 6 - Scale2 ) ) )
            end

            local Position2 = Position + UDim2.fromScale( 0, Max / math.max( Find.AbsoluteSize.Y, 1 ) )

            if Value1.Position ~= Position2 then
                Value1.Position = Position2
            end

            local Visible
            local NextAt = BetaWeaponRoll:GetAttribute( "NextAt" )
            local Active = BetaWeaponRoll2.Active( )

            if Active then
                if type( NextAt ) == "number" then
                    local Active3
                    local Active2 = BetaWeaponRoll2.Active( )

                    if Active2 then
                        if BetaWeaponRoll:GetAttribute( "Intermission" ) == true then
                            Active3 = true
                        else
                            Active3 = false
                        end
                    else
                        Active3 = Active2
                    end

                    local NotActive = not Active3

                    if NotActive then
                        local Flag = ClientState.WardrobeOpen == true and true or false
                        Visible = not Flag
                    else
                        Visible = NotActive
                    end
                else
                    Visible = false
                end
            else
                Visible = Active
            end

            Screens.SetShown( Find, Visible )
            Value1.Visible = Visible

            if Visible then
                local Text
                local Max2 = math.max( 0, ( math.ceil( NextAt - workspace:GetServerTimeNow( ) ) ) )
                local Format = string.format( "%d:%02d", Max2 // 60, Max2 % 60 )
                local Gsub, Gsub2 = Value3:gsub( "%d+:%d%d", Format, 1 )
                Text = Gsub2 > 0 and Gsub or Value3 .. " " .. Format
                Value2.Text = Text
            end
        end

        task.wait( 0.2 )
    end
end )

local function ToolOf( Argument1 )
    local Children
    local BetaRollWeapons = ReplicatedStorage:FindFirstChild( "BetaRollWeapons" )
    Children = BetaRollWeapons and BetaRollWeapons:GetChildren( ) or { }
    local Value1 = nil

    for Key, Value in Children, nil, nil do
        if Value:IsA( "Tool" ) then
            local Weapon2
            local Weapon = Value:GetAttribute( "Weapon" )
            Weapon2 = if Weapon then Weapon else Value:GetAttribute( "Melee" )

            if Weapon2 == Argument1 then
                return Value
            end
        end
    end

    return nil
end

local function DisplayName( NameName, Object )
    local DisplayName

    if not Object or not Object:GetAttribute( "DisplayName" ) then
        local Entry = Table[ NameName ]

        if Entry then
            DisplayName = Entry
        elseif WeaponData[ NameName ] then
            local Name = WeaponData[ NameName ].Name

            if Name then
                DisplayName = Name
            else
                DisplayName = NameName
            end
        else
            DisplayName = NameName
        end
    else
        DisplayName = Object:GetAttribute( "DisplayName" )
    end

    return DisplayName
end

local function PlaceBoard( Object )
    local Window = Object:FindFirstChild( "Window" )

    if not Window then
        return
    end
    if typeof( Window:GetAttribute( "BasePos" ) ) ~= "UDim2" then
        Window:SetAttribute( "BasePos", Window.Position )
        Window:SetAttribute( "BaseSize", Window.Size )
    end

    local Position, Size
    local BasePos = Window:GetAttribute( "BasePos" )
    local BaseSize = Window:GetAttribute( "BaseSize" )

    if Controls.TouchMode( ) then
        Position = UDim2.fromScale( BasePos.X.Scale, 0.14 )
        Size = UDim2.fromScale( BaseSize.X.Scale * 0.56 / math.max( BaseSize.Y.Scale, 0.01 ), 0.56 )
    else
        Position = BasePos
        Size = BaseSize
    end
    if Window.Position ~= Position then
        Window.Position = Position
    end
    if Window.Size ~= Size then
        Window.Size = Size
    end
end

local function FillBoard( Object, BoardName )
    local RowTemplate
    local Parent = Object:FindFirstChild( "List", true )

    if Parent then
        RowTemplate = Parent:FindFirstChild( "RowTemplate" )
    else
        RowTemplate = Parent
    end
    if not RowTemplate then
        return
    end
    for Key, Value in Parent:GetChildren( ) do
        if Value ~= RowTemplate and Value.Name == "Row" then
            Value:Destroy( )
        end
    end

    local JSONDecode = HttpService.JSONDecode
    local Success, Result = pcall( JSONDecode, HttpService, BoardName or "[]" )

    if not Success or type( Result ) ~= "table" then
        return
    end

    local Value1 = nil

    for Key2, Value2 in Result, nil, nil do
        local Clone = RowTemplate:Clone( )
        Clone.Name = "Row"
        Clone.Visible = true
        Clone.LayoutOrder = Key2

        local function Set( Name, Text )
            local FoundChild = Clone:FindFirstChild( Name )

            if FoundChild then
                FoundChild.Text = Text
            end
        end

        local Text = "#" .. Key2
        local Rank = Clone:FindFirstChild( "Rank" )

        if Rank then
            Rank.Text = Text
        end

        local Text2 = tostring( Value2.name )
        local Player = Clone:FindFirstChild( "Player" )

        if Player then
            Player.Text = Text2
        end

        local Text3 = tostring( Value2.k or 0 )
        local Kills = Clone:FindFirstChild( "Kills" )

        if Kills then
            Kills.Text = Text3
        end

        local Text4 = tostring( Value2.d or 0 )
        local Deaths = Clone:FindFirstChild( "Deaths" )

        if Deaths then
            Deaths.Text = Text4
        end

        local Text5 = string.format( "%.2f", ( Value2.k or 0 ) / math.max( Value2.d or 0, 1 ) )
        local KD = Clone:FindFirstChild( "KD" )

        if KD then
            KD.Text = Text5
        end
        if Key2 == 1 and Clone:FindFirstChild( "Rank" ) then
            Clone.Rank.TextColor3 = FromRGB
        end

        local Enabled = Value2.id == LocalPlayer.UserId and true or false
        local MineStroke = Clone:FindFirstChild( "MineStroke" )
        local OtherStroke = Clone:FindFirstChild( "OtherStroke" )

        if MineStroke then
            MineStroke.Enabled = Enabled
        end
        if OtherStroke then
            OtherStroke.Enabled = not Enabled
        end

        Clone.Parent = Parent
    end
end

local Parent = game:GetService( "SoundService" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local Sound = Instance.new( "Sound" )
Sound.Name = "BetaReelTick"
Sound.SoundId = "rbxassetid://93076868992220"
Sound.Volume = 0.67
Sound.Parent = Parent
local Table2 = {
    common = true,
    uncommon = true,
    rare = true,
    epic = true,
    legendary = true,
    super = true,
    mythical = true
}

local function FakeTool( Argument1 )
    return {
        GetAttribute = function( Argument1Inner, Name )
            local Captured = Name == "Weapon" and Argument1 or nil
            return Captured
        end
    }
end

local Table3 = { }

local function TileShape( Argument1 )
    local Category2

    if Argument1 then
        local Category = ItemRender.Category( {
            GetAttribute = function( Argument1Inner, Name )
                local Captured = Name == "Weapon" and Argument1 or nil
                return Captured
            end
        } )

        if Category then
            Category2 = Category
        else
            Category2 = "common"
        end
    else
        Category2 = "common"
    end

    local Category3 = ( not Table2[ Category2 ] or not Category2 ) and "common" or Category2

    if not Table3[ Category3 ] then
        local Entry2
        local Entry = ItemRender.TILE_GRAD[ Category3 ]
        Entry2 = if Entry then Entry else ItemRender.TILE_GRAD.common
        local Keypoints = Entry2.Keypoints
        local Value = Keypoints[ 1 ].Value
        local Value2 = Keypoints[ #Keypoints ].Value
        Table3[ Category3 ] = ColorSequence.new( {
            ColorSequenceKeypoint.new( 0, Value2 ),
            ColorSequenceKeypoint.new( 0.51, Value ),
            ColorSequenceKeypoint.new( 1, Value2 )
        } )
    end

    return Table3[ Category3 ]
end

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function InOut( Argument1 )
    local Clamp3
    local Clamp = math.clamp( Argument1, 0, 1 )

    if Clamp < 0.5 then
        local Clamp2 = 4 * Clamp ^ 3

        if Clamp2 then
            Clamp3 = Clamp2
        else
            Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
        end
    else
        Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
    end

    return Clamp3
end

local function Tween( Argument1, Argument2, Argument3, Argument4 )
    TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Argument3 ):Play( )
end

local Number = 0

local function PlayReel( Self, Argument2, Amount )
    local Canvas
    Number = Number + 1
    local Reel = Self:FindFirstChild( "Reel" )

    if Reel then
        Canvas = Reel:FindFirstChild( "Canvas" )
    else
        Canvas = Reel
    end

    local ParentInner

    if Canvas then
        ParentInner = Canvas:FindFirstChild( "Strip" )
    else
        ParentInner = Canvas
    end

    local Tile

    if ParentInner then
        Tile = ParentInner:FindFirstChild( "Tile" )
    else
        Tile = ParentInner
    end

    local WeaponName = Self:FindFirstChild( "WeaponName" )

    if WeaponName then
        WeaponName.TextTransparency = 1
    end

    local Descendants = WeaponName and WeaponName:GetDescendants( ) or { }
    local Value1 = nil

    for Key, Value in Descendants, nil, nil do
        if Value:IsA( "UIStroke" ) then
            Value.Transparency = 1
        end
    end
    if not Tile then
        return
    end

    Tile.Visible = false

    for Key2, Value2 in ParentInner:GetChildren( ) do
        if Value2 ~= Tile then
            Value2:Destroy( )
        end
    end

    RunService.RenderStepped:Wait( )

    if Number ~= Number then
        return
    end

    local AspectRatio
    local Y = Canvas.AbsoluteSize.Y
    local UIAspectRatioConstraint = Tile:FindFirstChildOfClass( "UIAspectRatioConstraint" )
    local Max = math.max( math.floor( Y * Tile.Size.Y.Scale ), 1 )
    AspectRatio = UIAspectRatioConstraint and UIAspectRatioConstraint.AspectRatio or 1.45
    local Value3
    local Max2 = math.max( math.floor( Max * AspectRatio ), 1 )
    local Max3 = math.max( 4, ( math.floor( Y * ( tonumber( Tile:GetAttribute( "Gap" ) ) or 0.06 ) ) ) )
    local NumberInner = tonumber( Tile:GetAttribute( "WonScale" ) ) or 1.1
    local Max4 = Max2 + Max3
    local AbsoluteSize = ParentInner.AbsoluteSize

    local function StripAt( Argument1 )
        ParentInner.Position = ScaleUI.FromPx( Argument1, 0, AbsoluteSize )
    end

    local TableInner = { }
    local POOL = BetaWeaponRoll2.POOL
    Value3 = nil

    for Key3, Value4 in POOL, nil, nil do
        if ( BetaWeaponRoll2.WEIGHTS[ Value4 ] or 1 ) > 0 then
            table.insert( TableInner, Value4 )
        end
    end

    local Table3 = if #TableInner == 0 then { Argument2 } else TableInner
    local Table2 = { }
    local I = 1

    for I = 1, 40 do
        Table2[ I ] = Table3[ math.random( 1, #Table3 ) ]
    end

    Table2[ 34 ] = Argument2

    if #Table3 > 1 then
        local Value5
        local Table4 = { 33, 35 }
        Value5 = nil

        for Key4, Value6 in Table4, nil, nil do
            while Table2[ Value6 ] == Argument2 do
                Table2[ Value6 ] = Table3[ math.random( 1, #Table3 ) ]
            end
        end
    end

    local Value7
    local Table5 = { }
    Value7 = nil

    for Key5, Value8 in Table2, nil, nil do
        local Clone = Tile:Clone( )
        Clone.Name = "T" .. Key5

        for Key7, Value11 in Clone:GetChildren( ) do
            if Value11:IsA( "UIAspectRatioConstraint" ) or Value11:IsA( "UISizeConstraint" ) then
                Value11:Destroy( )
            end
        end

        Clone.Size = ScaleUI.FromPx( Max2, Max, AbsoluteSize )
        Clone.Position = UDim2.new( UDim.new( ( ( Key5 - 1 ) * Max4 + Max2 * Clone.AnchorPoint.X ) / math.max( AbsoluteSize.X, 1 ), 0 ), Tile.Position.Y )
        Clone.Visible = true
        local UIGradient = Clone:FindFirstChildOfClass( "UIGradient" )

        if UIGradient then
            UIGradient.Color = TileShape( nil )
            UIGradient.Rotation = 90
        end

        local Icon = Clone:FindFirstChild( "Icon" )

        if Icon then
            local SetIcon = ItemRender.SetIcon
            SetIcon( Icon, ItemRender.Icon( {
                GetAttribute = function( Argument1, Name )
                    local Captured = Name == "Weapon" and Value8 or nil
                    return Captured
                end
            } ) )
        end

        local Label = Clone:FindFirstChild( "Label" )

        if Label then
            local Text
            local ToolOf2 = ToolOf( Value8 )

            if not ToolOf2 or not ToolOf2:GetAttribute( "DisplayName" ) then
                local Entry = Table[ Value8 ]

                if Entry then
                    Text = Entry
                elseif WeaponData[ Value8 ] then
                    local Name = WeaponData[ Value8 ].Name

                    if Name then
                        Text = Name
                    else
                        Text = Value8
                    end
                else
                    Text = Value8
                end
            else
                Text = ToolOf2:GetAttribute( "DisplayName" )
            end

            Label.Text = Text
        end

        local BackgroundTransparency4
        local Dim = Clone:FindFirstChild( "Dim" )
        BackgroundTransparency4 = Dim and Dim.BackgroundTransparency or 1

        if Dim then
            Dim.Visible = false
        end

        local StrokeWon = Clone:FindFirstChild( "StrokeWon" )

        if StrokeWon and StrokeWon:IsA( "UIStroke" ) then
            StrokeWon.Enabled = false
        end

        local Base
        local UIScale = Clone:FindFirstChildOfClass( "UIScale" )
        local Table8 = {
            frame = Clone,
            dim = Dim,
            dimT = BackgroundTransparency4,
            won = StrokeWon,
            inner = Clone:FindFirstChild( "InnerStroke" ),
            scale = UIScale
        }
        Base = UIScale and UIScale.Scale or 1
        Table8.base = Base
        Table5[ Key5 ] = Table8
        Clone.Parent = ParentInner
    end

    local BackgroundTransparency3
    local X = AbsoluteSize.X / 2

    local function CenterOf( Amount )
        return ( Amount - 1 ) * Max4 + Max2 / 2
    end

    local function IndexAt( Argument1 )
        local Floor = math.floor( ( X - Argument1 + Max3 / 2 ) / Max4 ) + 1
        return ( math.clamp( Floor, 1, #Table2 ) )
    end

    local Random = ( math.random( ) * 2 - 1 ) * 0.4 * Max2
    local X2 = X - ( 2 * Max4 + Max2 / 2 )
    local X3 = X - ( 33 * Max4 + Max2 / 2 ) - Random
    local X4 = X - ( 33 * Max4 + Max2 / 2 )
    local Glow = Reel:FindFirstChild( "Glow" )
    BackgroundTransparency3 = Glow and Glow.BackgroundTransparency or 1
    local Value9
    local Table6 = { }
    local Table7 = {
        Canvas,
        Canvas:FindFirstChild( "LineTop" ),
        Canvas:FindFirstChild( "LineBottom" )
    }
    Value9 = nil

    for Key6, Value10 in Table7, nil, nil do
        if Value10 then
            local BackgroundTransparency2
            local BaseT = Value10:GetAttribute( "BaseT" )

            if BaseT == nil then
                local BackgroundTransparency = Value10.BackgroundTransparency
                Value10:SetAttribute( "BaseT", BackgroundTransparency )
                BackgroundTransparency2 = BackgroundTransparency
            else
                BackgroundTransparency2 = BaseT
            end

            Value10.BackgroundTransparency = BackgroundTransparency2
            table.insert( Table6, Value10 )
        end
    end

    local function FadeOut( List, Duration )
        local function One( List )
            local Table = { }

            if List:IsA( "GuiObject" ) then
                Table.BackgroundTransparency = 1
            end
            if List:IsA( "ImageLabel" ) or List:IsA( "ImageButton" ) then
                Table.ImageTransparency = 1
            end
            if List:IsA( "TextLabel" ) then
                Table.TextTransparency = 1
                Table.TextStrokeTransparency = 1
            end
            if List:IsA( "UIStroke" ) then
                Table.Transparency = 1
            end
            if next( Table ) then
                if Duration > 0 then
                    TweenService:Create( List, TweenInfo.new( Duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table ):Play( )
                    return
                end

                local Value1 = nil

                for Key, Value in Table, nil, nil do
                    List[ Key ] = Value
                end
            end
        end

        One( List )

        for Key, Value in List:GetDescendants( ) do
            One( Value )
        end
        if Duration > 0 then
            task.delay( Duration, function()
                if List.Parent then
                    List.Visible = false
                end
            end )
            return
        end
        List.Visible = false
        return
    end

    local function Reveal( Argument1 )
        ParentInner.Position = ScaleUI.FromPx( X4, 0, AbsoluteSize )
        task.spawn( function()
            RunService.RenderStepped:Wait( )

            if Number ~= Number or not Canvas.Parent then
                return
            end

            local X = Canvas.AbsoluteSize.X
            local Frame = Table5[ 34 ].frame

            if X > 1 then
                local X2 = Canvas.AbsolutePosition.X + X / 2 - ( Frame.AbsolutePosition.X + Frame.AbsoluteSize.X / 2 )

                if math.abs( X2 ) > 0.5 then
                    ParentInner.Position = ParentInner.Position + UDim2.fromScale( X2 / X, 0 )
                end
            end
        end )
        local Item = Table5[ 34 ]
        local Frame = Item.frame
        Frame.ZIndex = Frame.ZIndex + 1

        if Item.won and Item.won:IsA( "UIStroke" ) then
            Item.won.Enabled = true

            if Item.inner and Item.inner:IsA( "UIStroke" ) then
                Item.inner.Enabled = false
            end
        end
        if Item.scale then
            if Argument1 then
                local Scale = Item.scale
                Scale.Scale = Item.base * NumberInner
            else
                local Scale2 = Item.scale
                local TableInner = { Scale = Item.base * NumberInner }
                TweenService:Create( Scale2, TweenInfo.new( 0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), TableInner ):Play( )
            end
        end

        local Value1 = nil

        for Key, Value in Table5, nil, nil do
            if Key ~= 34 then
                local NumberInner2
                local Frame2 = Value.frame
                NumberInner2 = not Argument1 and 0.35 or 0
                FadeOut( Frame2, NumberInner2 )
            end
        end

        local Value2 = nil

        for Key2, Value3 in Table6, nil, nil do
            if Argument1 then
                Value3.BackgroundTransparency = 1
            else
                local Table5Inner = { BackgroundTransparency = 1 }
                TweenService:Create( Value3, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table5Inner ):Play( )
            end
        end
        if WeaponName then
            local DisplayName
            local ToolOf2 = ToolOf( Argument2 )

            if not ToolOf2 or not ToolOf2:GetAttribute( "DisplayName" ) then
                local Entry = Table[ Argument2 ]

                if Entry then
                    DisplayName = Entry
                elseif WeaponData[ Argument2 ] then
                    local Name = WeaponData[ Argument2 ].Name

                    if Name then
                        DisplayName = Name
                    else
                        DisplayName = Argument2
                    end
                else
                    DisplayName = Argument2
                end
            else
                DisplayName = ToolOf2:GetAttribute( "DisplayName" )
            end

            WeaponName.Text = string.upper( DisplayName )
            local UIScale = WeaponName:FindFirstChildOfClass( "UIScale" )

            if Argument1 then
                WeaponName.TextTransparency = 0
            else
                if UIScale then
                    UIScale.Scale = 1.5
                    local Table2 = { Scale = 1 }
                    TweenService:Create( UIScale, TweenInfo.new( 0.5, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2 ):Play( )
                end

                local Table3 = { TextTransparency = 0 }
                TweenService:Create( WeaponName, TweenInfo.new( 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table3 ):Play( )
            end
            for Key3, Value5 in WeaponName:GetDescendants( ) do
                if Value5:IsA( "UIStroke" ) then
                    if Argument1 then
                        Value5.Transparency = 0
                    else
                        local Table4 = { Transparency = 0 }
                        TweenService:Create( Value5, TweenInfo.new( 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table4 ):Play( )
                    end
                end
            end
        end
    end

    if Amount > 6.1 then
        Reveal( true )
        return
    end

    local Number2, Number3, Number4
    ParentInner.Position = ScaleUI.FromPx( X2, 0, AbsoluteSize )
    local Clock = os.clock( ) - math.max( Amount, 0 )
    Number2 = 3
    Number3 = 0
    Number4 = 0

    while true do
        local Wait = RunService.RenderStepped:Wait( )

        if Number ~= Number then
            return
        end

        local Clamp = math.clamp( ( os.clock( ) - Clock ) / 5.5, 0, 1 )
        local X5 = X2 + ( X3 - X2 ) * ( 1 - ( 1 - Clamp ) ^ 3.4 )
        ParentInner.Position = ScaleUI.FromPx( X5, 0, AbsoluteSize )
        local Floor = math.floor( ( X - X5 + Max3 / 2 ) / Max4 ) + 1
        local Clamp2 = math.clamp( Floor, 1, #Table2 )

        if Clamp2 ~= Number2 then
            if os.clock( ) - Number3 > 0.035 then
                Number3 = os.clock( )
                Sound.PlaybackSpeed = 0.92 + math.random( ) * 0.12
                Parent:PlayLocalSound( Sound )
            end

            Number4 = 1
            Number2 = Clamp2
        end

        local Max5 = math.max( 0, Number4 - Wait * 11 )

        if Glow then
            Glow.BackgroundTransparency = BackgroundTransparency3 - ( BackgroundTransparency3 - 0.35 ) * Max5
        end
        if Clamp >= 1 then
            break
        end

        Number4 = Max5
    end

    task.wait( 0.3 )

    if Number ~= Number then
        return
    end

    local Clock2 = os.clock( )

    while os.clock( ) - Clock2 < 0.32 do
        RunService.RenderStepped:Wait( )

        if Number ~= Number then
            return
        end

        local Clamp5
        local X6 = X4 - X3
        local Clamp3 = math.clamp( ( os.clock( ) - Clock2 ) / 0.32, 0, 1 )

        if Clamp3 < 0.5 then
            local Clamp4 = 4 * Clamp3 ^ 3

            if Clamp4 then
                Clamp5 = Clamp4
            else
                Clamp5 = 1 - ( -2 * Clamp3 + 2 ) ^ 3 / 2
            end
        else
            Clamp5 = 1 - ( -2 * Clamp3 + 2 ) ^ 3 / 2
        end

        local X7 = X3 + X6 * Clamp5
        ParentInner.Position = ScaleUI.FromPx( X7, 0, AbsoluteSize )
    end

    Reveal( false )
end

task.spawn( function()
    local Text3, RoundBoardId2
    Text3 = nil
    RoundBoardId2 = nil

    while true do
        local BetaIntermission
        local Active = BetaWeaponRoll2.Active( )

        if Active then
            if BetaWeaponRoll:GetAttribute( "Intermission" ) == true then
                BetaIntermission = true
            else
                BetaIntermission = false
            end
        else
            BetaIntermission = Active
        end

        local Flag
        ClientState.BetaIntermission = BetaIntermission
        Flag = ClientState.WardrobeOpen == true and true or false
        local Find = Screens.Find( "BetaIntermission", PlayerGui )

        if Find then
            local Active2 = if BetaIntermission then not Flag else BetaIntermission
            Screens.SetShown( Find, Active2 )

            if not BetaIntermission or not Flag then
                if BetaIntermission then
                    local IntermissionEnd = BetaWeaponRoll:GetAttribute( "IntermissionEnd" ) or 0
                    local Countdown = Find:FindFirstChild( "Countdown" )

                    if Countdown then
                        Countdown.Text = tostring( ( math.max( 0, ( math.ceil( IntermissionEnd - workspace:GetServerTimeNow( ) ) ) ) ) )
                    end

                    local Text = tostring( IntermissionEnd )
                    local Text2 = Text .. "|" .. tostring( BetaWeaponRoll:GetAttribute( "NextWeapon" ) )

                    if Text2 ~= Text3 then
                        local ServerTimeNow = workspace:GetServerTimeNow( ) - ( IntermissionEnd - BetaWeaponRoll2.INTERMISSION )
                        task.spawn( PlayReel, Find, BetaWeaponRoll:GetAttribute( "NextWeapon" ), ServerTimeNow )
                        Text3 = Text2
                    end
                else
                    Number = Number + 1
                end
            else
                Number = Number + 1
                Text3 = nil
            end
        end

        local Find2 = Screens.Find( "BetaRoundBoard", PlayerGui )

        if Find2 then
            local Active3
            local RoundBoardId = BetaWeaponRoll:GetAttribute( "RoundBoardId" )

            if BetaIntermission then
                if RoundBoardId == nil then
                    Active3 = false
                else
                    Active3 = not Flag
                end
            else
                Active3 = BetaIntermission
            end
            if Active3 and RoundBoardId2 ~= RoundBoardId then
                FillBoard( Find2, BetaWeaponRoll:GetAttribute( "RoundBoard" ) )
                RoundBoardId2 = RoundBoardId
            end
            if Active3 then
                PlaceBoard( Find2 )
            end

            Screens.SetShown( Find2, Active3 )
        end

        task.wait( 0.1 )
    end
end )
