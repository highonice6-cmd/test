-- ReplicatedStorage.GamepadNav
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local GuiService = game:GetService( "GuiService" )
local UserInputService = game:GetService( "UserInputService" )
local ContextActionService = game:GetService( "ContextActionService" )
local RunService = game:GetService( "RunService" )
local GamepadService = game:GetService( "GamepadService" )
local TweenService = game:GetService( "TweenService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local MarketplaceService = game:GetService( "MarketplaceService" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local LocalPlayer = Players.LocalPlayer

local function Controls2()
    return Controls.ControlModule( )
end

local KeyCode = Enum.KeyCode
local Table = {
    KeyCode.ButtonB,
    KeyCode.ButtonX,
    KeyCode.ButtonY,
    KeyCode.ButtonL1,
    KeyCode.ButtonR1,
    KeyCode.ButtonL2,
    KeyCode.ButtonR2,
    KeyCode.ButtonL3,
    KeyCode.ButtonR3,
    KeyCode.ButtonSelect
}
Font.new( "rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold )
local Table3 = { }
local Table4 = { }
local Flag = false
local Flag2 = false
local Number = -math.huge
local Flag3 = false
local Number2 = 0
local Callback = nil
local Class = setmetatable( { }, { __mode = "k" } )

local function Shown( Object )
    local Parent = Object

    while Parent do
        if Parent:IsA( "GuiObject" ) then
            if not Parent.Visible then
                return false
            end
        elseif Parent:IsA( "LayerCollector" ) then
            return Parent.Enabled
        end

        Parent = Parent.Parent
    end

    return false
end

local function IsSelectable( Object2 )
    local Flag

    if Object2:IsA( "GuiButton" ) or Object2:IsA( "TextBox" ) or Object2:GetAttribute( "NavSelectable" ) == true then
        local Selectable = Object2.Selectable

        if Selectable then
            if Object2:GetAttribute( "NavSkip" ) == true then
                Flag = false
            elseif Object2.AbsoluteSize.X > 2 then
                if Object2.AbsoluteSize.Y > 2 then
                    Flag = Shown( Object2 )
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = Selectable
        end
    else
        Flag = false
    end

    return Flag
end

local function Collect( Object )
    local Table = { }

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "GuiObject" ) then
            if Value:IsA( "ScrollingFrame" ) and Value:GetAttribute( "NavSelectable" ) ~= true then
                Value.Selectable = false
            end
            if IsSelectable( Value ) then
                table.insert( Table, Value )
            end
        end
    end

    return Table
end

local function Valid( Object2, Argument2 )
    local Flag

    if Object2 == nil then
        Flag = false
    elseif Object2.Parent == nil then
        Flag = false
    elseif Argument2 == nil then
        Flag = false
    else
        local IsDescendantOf = Object2:IsDescendantOf( Argument2.root )

        if IsDescendantOf then
            Flag = IsSelectable( Object2 )
        else
            Flag = IsDescendantOf
        end
    end

    return Flag
end

local function SetSel( SelectedObject )
    local SelectedObject2

    if SelectedObject == nil then
        SelectedObject2 = SelectedObject
    elseif not SelectedObject.Parent or not SelectedObject:FindFirstAncestorWhichIsA( "PlayerGui" ) or not IsSelectable( SelectedObject ) then
        SelectedObject2 = nil
    else
        SelectedObject2 = SelectedObject
    end
    if GuiService.SelectedObject ~= SelectedObject2 then
        GuiService.SelectedObject = SelectedObject2
    end
end

local function IsTopbar( Object )
    local Parent = Object

    while Parent do
        if Parent:IsA( "LayerCollector" ) then
            local Flag = Parent.Name:sub( 1, 6 ) == "Topbar" and true or false
            return Flag
        end
        Parent = Parent.Parent
    end

    return false
end

local Table5 = {
    { prop = "NextSelectionUp", x = 0, y = -1 },
    { prop = "NextSelectionDown", x = 0, y = 1 },
    { prop = "NextSelectionLeft", x = -1, y = 0 },
    { prop = "NextSelectionRight", x = 1, y = 0 }
}

local function Best( Object, List, Argument3 )
    local Value1, Value2, Total
    local AbsolutePosition = Object.AbsolutePosition
    local AbsolutePosition2 = AbsolutePosition + Object.AbsoluteSize
    local AbsolutePosition3 = ( AbsolutePosition + AbsolutePosition2 ) / 2
    Value1 = nil
    Value2 = nil
    Total = nil

    for Key, Value in List, nil, nil do
        if Value ~= Object and not Object:IsDescendantOf( Value ) and not Value:IsDescendantOf( Object ) then
            local X, Max2, Abs, Min, X7
            local AbsolutePosition4 = Value.AbsolutePosition
            local AbsolutePosition5 = AbsolutePosition4 + Value.AbsoluteSize
            local AbsolutePosition6 = ( AbsolutePosition4 + AbsolutePosition5 ) / 2

            if Argument3.x == 0 then
                local Y4
                X = ( AbsolutePosition6.Y - AbsolutePosition3.Y ) * Argument3.y

                if Argument3.y > 0 then
                    local Y3 = AbsolutePosition4.Y - AbsolutePosition2.Y

                    if Y3 then
                        Y4 = Y3
                    else
                        Y4 = AbsolutePosition.Y - AbsolutePosition5.Y
                    end
                else
                    Y4 = AbsolutePosition.Y - AbsolutePosition5.Y
                end

                local X5 = AbsolutePosition.X
                local Max3 = math.max( X5, AbsolutePosition4.X )
                local X6 = AbsolutePosition2.X
                Max2 = math.max( 0, Max3 - math.min( X6, AbsolutePosition5.X ) )
                Abs = math.abs( AbsolutePosition6.X - AbsolutePosition3.X )
                local Y5 = AbsolutePosition2.Y - AbsolutePosition.Y
                Min = math.min( Y5, AbsolutePosition5.Y - AbsolutePosition4.Y )
                X7 = Y4
            else
                local X3
                X = ( AbsolutePosition6.X - AbsolutePosition3.X ) * Argument3.x

                if Argument3.x > 0 then
                    local X2 = AbsolutePosition4.X - AbsolutePosition2.X

                    if X2 then
                        X3 = X2
                    else
                        X3 = AbsolutePosition.X - AbsolutePosition5.X
                    end
                else
                    X3 = AbsolutePosition.X - AbsolutePosition5.X
                end

                local Y = AbsolutePosition.Y
                local Max = math.max( Y, AbsolutePosition4.Y )
                local Y2 = AbsolutePosition2.Y
                Max2 = math.max( 0, Max - math.min( Y2, AbsolutePosition5.Y ) )
                Abs = math.abs( AbsolutePosition6.Y - AbsolutePosition3.Y )
                local X4 = AbsolutePosition2.X - AbsolutePosition.X
                Min = math.min( X4, AbsolutePosition5.X - AbsolutePosition4.X )
                X7 = X3
            end
            if X > 1 and -Min * 0.5 < X7 then
                local Max4 = math.max( X7, 0 ) + Max2 * 3 + Abs * 0.15

                if not Total or Max4 < Total then
                    Value2 = Value
                    Total = Max4
                end
            end
        end
    end

    return Value2
end

local function Relink( Argument1 )
    local Value2
    local Collect2 = Collect( Argument1.root )
    Value2 = nil

    for Key, Value in Collect2, nil, nil do
        if Value:GetAttribute( "NavManual" ) ~= true then
            local Value3 = nil

            for Key2, Value4 in Table5, nil, nil do
                local Value6
                local Prop = Value4.prop

                if Argument1.lockSelection then
                    Value6 = Value
                else
                    local Best2 = Best( Value, Collect2, Value4 )

                    if Best2 then
                        Value6 = Best2
                    else
                        Value6 = Value
                    end
                end

                Value[ Prop ] = Value6
            end
            if Class[ Value ] then
                Value.NextSelectionLeft = Value
                Value.NextSelectionRight = Value
            end
        end
    end

    Argument1.count = #Collect2
    return Collect2
end

local function Signature( Argument1 )
    local Value2
    local Collect2 = Collect( Argument1.root )
    local Count = #Collect2
    Value2 = nil

    for Key, Value in Collect2, nil, nil do
        local AbsolutePosition = Value.AbsolutePosition
        Count = ( Count * 31 + math.floor( AbsolutePosition.X ) * 7 + math.floor( AbsolutePosition.Y ) * 13 + Key ) % 2147483647
    end

    return Count
end

local function FirstOf( Argument1 )
    local First2
    local First = Argument1.first

    if type( First ) == "function" then
        local Result2
        local Success, Result = pcall( First )
        Result2 = Success and Result or nil
        First2 = Result2
    else
        First2 = First
    end
    if First2 then
        local Flag

        if First2 == nil then
            Flag = false
        elseif First2.Parent == nil then
            Flag = false
        elseif Argument1 == nil then
            Flag = false
        else
            local IsDescendantOf = First2:IsDescendantOf( Argument1.root )

            if IsDescendantOf then
                Flag = IsSelectable( First2 )
            else
                Flag = IsDescendantOf
            end
        end
        if Flag then
            return First2
        end
    end

    local Value2, Y, X
    Value2 = nil
    Y = nil
    X = nil

    for Key, Value in Collect( Argument1.root ) do
        local AbsolutePosition = Value.AbsolutePosition

        if Value2 and not ( AbsolutePosition.Y < Y - 4 ) then
            if not ( math.abs( AbsolutePosition.Y - Y ) <= 4 ) or not ( AbsolutePosition.X < X ) then
                continue
            end
        end

        Value2 = Value
        Y = AbsolutePosition.Y
        X = AbsolutePosition.X
    end

    return Value2
end

local Screens = require( script.Parent:WaitForChild( "Screens" ) )
local ScaleUI = require( script.Parent:WaitForChild( "ScaleUI" ) )
local Value1 = nil
local Value2 = nil
local Value3 = nil
local Value4 = nil
local Value5 = nil
local Value6 = nil
local Value7 = nil
local Color32 = Color3.new( 1, 1, 1 )
local FromRGB = Color3.fromRGB( 80, 230, 110 )

local function SelectionGui()
    if Value2 and Value2.Parent then
        return true
    end

    local Find
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        Find = Screens.Find( "GamepadSelection", PlayerGui )
    else
        Find = PlayerGui
    end

    local Box

    if Find then
        Box = Find:FindFirstChild( "Box" )
    else
        Box = Find
    end

    local Shadow

    if Box then
        Shadow = Box:FindFirstChild( "Shadow" )
    else
        Shadow = Box
    end

    local White

    if Box then
        White = Box:FindFirstChild( "White" )
    else
        White = Box
    end

    local UIStroke

    if White then
        UIStroke = White:FindFirstChildOfClass( "UIStroke" )
    else
        UIStroke = White
    end
    if not Shadow or not UIStroke then
        return false
    end

    local HoldColor2
    Value2 = Find
    Value3 = Box
    Value1 = Find:FindFirstChild( "NoSelectionAdornment" )
    local UICorner = Shadow:FindFirstChildOfClass( "UICorner" )
    local UIStroke2 = Shadow:FindFirstChildOfClass( "UIStroke" )
    Value4 = UICorner
    Value6 = UIStroke2
    Value5 = White:FindFirstChildOfClass( "UICorner" )
    Value7 = UIStroke
    Color32 = UIStroke.Color
    local HoldColor = UIStroke:GetAttribute( "HoldColor" )
    HoldColor2 = if HoldColor then HoldColor else FromRGB
    FromRGB = HoldColor2
    Screens.SetShown( Value2, false )
    TweenService:Create( UIStroke, TweenInfo.new( 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true ), { Transparency = UIStroke:GetAttribute( "PulseTransparency" ) or 0.3 } ):Play( )
    return true
end

local function StrokeThickness( Argument1, Argument2, Argument3, Argument4 )
    if Argument1.StrokeSizingMode == Enum.StrokeSizingMode.ScaledSize then
        return Argument2 / math.max( math.min( Argument3, Argument4 ), 1 )
    end
    return Argument2
end

local function PlaceHighlight( Object )
    if not SelectionGui( ) then
        return
    end
    if not Object then
        Screens.SetShown( Value2, false )
        return
    end

    local Y2

    if workspace.CurrentCamera then
        local Y = workspace.CurrentCamera.ViewportSize.Y

        if Y then
            Y2 = Y
        else
            Y2 = 720
        end
    else
        Y2 = 720
    end

    local Thickness
    local Max = math.max( 2, ( math.floor( Y2 * 0.0042 + 0.5 ) ) )
    local AbsolutePosition = Object.AbsolutePosition
    local AbsoluteSize = Object.AbsoluteSize
    local X = AbsoluteSize.X + 2
    local Y3 = AbsoluteSize.Y + 2

    if Value7.StrokeSizingMode == Enum.StrokeSizingMode.ScaledSize then
        Thickness = Max / math.max( math.min( X, Y3 ), 1 )
    else
        Thickness = Max
    end

    Value7.Thickness = Thickness

    if Value6 then
        local Thickness2
        local Max2 = Max + 2

        if Value6.StrokeSizingMode == Enum.StrokeSizingMode.ScaledSize then
            Thickness2 = Max2 / math.max( math.min( X, Y3 ), 1 )
        else
            Thickness2 = Max2
        end

        Value6.Thickness = Thickness2
    end

    local Scale3
    local AbsolutePosition2 = Value2.AbsolutePosition
    Value3.Position = ScaleUI.FromAbs( Value3, AbsolutePosition.X - 1 - AbsolutePosition2.X, AbsolutePosition.Y - 1 - AbsolutePosition2.Y )
    Value3.Size = ScaleUI.FromAbs( Value3, X, Y3 )
    local UICorner = Object:FindFirstChildOfClass( "UICorner" )

    if UICorner then
        local Scale = UICorner.CornerRadius.Scale
        local X2 = AbsoluteSize.X
        local Scale2 = Scale * math.min( X2, AbsoluteSize.Y ) + UICorner.CornerRadius.Offset

        if Scale2 then
            Scale3 = Scale2
        else
            Scale3 = 0
        end
    else
        Scale3 = 0
    end

    local Scale4 = ( Scale3 + 1 ) / math.max( math.min( X, Y3 ), 1 )

    if Value4 then
        Value4.CornerRadius = UDim.new( Scale4, 0 )
    end
    if Value5 then
        Value5.CornerRadius = UDim.new( Scale4, 0 )
    end

    Screens.SetShown( Value2, true )
end

local Value8 = nil
local Value9 = nil
local Value10 = nil

local function HintsReady()
    if Value8 and Value8.Parent then
        return true
    end

    local Find
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        Find = Screens.Find( "GamepadHints", PlayerGui )
    else
        Find = PlayerGui
    end

    local Bar

    if Find then
        Bar = Find:FindFirstChild( "Bar" )
    else
        Bar = Find
    end

    local Templates

    if Find then
        Templates = Find:FindFirstChild( "Templates" )
    else
        Templates = Find
    end

    local Hint

    if Templates then
        Hint = Templates:FindFirstChild( "Hint" )
    else
        Hint = Templates
    end
    if not Bar or not Hint then
        return false
    end

    Value8 = Find
    Value9 = Bar
    Value10 = Hint
    Templates.Visible = false
    Screens.SetShown( Value8, false )

    for Key, Value in Value9:GetChildren( ) do
        if Value:IsA( "Frame" ) then
            Value:Destroy( )
        end
    end

    return true
end

local Value11 = nil

local function ShownLength( List )
    local Len3
    local Len = utf8.len( List )

    if Len then
        Len3 = Len
    else
        Len3 = #List
    end
    if Value11 then
        local Success, Result = pcall( Value11.Translate, Value11, game, List )

        if Success and type( Result ) == "string" then
            local Len4
            local Len2 = utf8.len( Result )
            Len4 = if Len2 then Len2 else #Result
            Len3 = math.max( Len3, Len4 )
        end
    end

    return Len3
end

local function Hint( LayoutOrder, List, Text )
    local Table2 = if typeof( List ) == "EnumItem" then { List } else List
    local Value1, Text2
    local Table = { }
    Value1 = nil
    Text2 = ""

    for Key, Value in Table2, nil, nil do
        local Glyph2, Glyph22 = Controls.Glyph( Value )

        if Glyph2 then
            table.insert( Table, Glyph2 )
        else
            Text2 = Text2 .. "[" .. Glyph22 .. "] "
        end
    end

    local Vector22
    local Text3 = Text2 .. Text

    if workspace.CurrentCamera then
        local ViewportSize = workspace.CurrentCamera.ViewportSize

        if ViewportSize then
            Vector22 = ViewportSize
        else
            Vector22 = Vector2.new( 1280, 720 )
        end
    else
        Vector22 = Vector2.new( 1280, 720 )
    end

    local Y = 0.024960000000000003 * Vector22.Y / Vector22.X

    if not HintsReady( ) then
        return
    end

    local Count3
    local Result = 0.0068 * ShownLength( Text3 )
    local Count = #Table

    if Count > 0 then
        local Count2 = 0.012 + Count * Y + ( Count - 1 ) * 0.005 + 0.004 + Result

        if Count2 then
            Count3 = Count2
        else
            Count3 = 0.018 + Result
        end
    else
        Count3 = 0.018 + Result
    end

    local Value2
    local Parent = Value10:Clone( )
    Parent.LayoutOrder = LayoutOrder
    Parent.Size = UDim2.fromScale( Count3, 1 )
    local Glyph = Parent:FindFirstChild( "Glyph" )
    Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        local Clone

        if Glyph then
            if Key2 ~= 1 or not Glyph then
                Clone = Glyph:Clone( )
            else
                Clone = Glyph
            end
        else
            Clone = Glyph
        end
        if Clone then
            Clone.Image = Value3
            Clone.Position = UDim2.fromScale( ( 0.006 + ( Key2 - 1 ) * ( Y + 0.005 ) ) / Count3, 0.5 )
            Clone.Parent = Parent
        end
    end
    if #Table == 0 and Glyph then
        Glyph:Destroy( )
    end

    local Text4 = Parent:FindFirstChild( "Text" )

    if Text4 then
        Text4.Position = UDim2.fromScale( 1 - 0.006 / Count3, 0.5 )
        Text4.Size = UDim2.fromScale( Result / Count3, Text4.Size.Y.Scale )
        Text4.Text = Text3
    end

    Parent.Parent = Value9
end

local CollectionService = game:GetService( "CollectionService" )
local Value12 = nil

local function ScreenY( Self )
    local Y3
    local ScreenGui = Self:FindFirstAncestorOfClass( "ScreenGui" )
    local Y = Self.AbsolutePosition.Y

    if not ScreenGui or ScreenGui.IgnoreGuiInset then
        Y3 = 0
    else
        local Y2 = GuiService:GetGuiInset( ).Y

        if Y2 then
            Y3 = Y2
        else
            Y3 = 0
        end
    end

    return Y + Y3
end

local function AvoidBanners()
    if not Value9 or not Value9.Parent then
        return
    end

    Value12 = Value12 or Value9.Position.Y.Scale
    local Parent = Value9.Parent
    local AbsoluteSize = Parent.AbsoluteSize

    if AbsoluteSize.Y < 1 then
        return
    end

    local Y3
    local ScreenGui = Parent:FindFirstAncestorOfClass( "ScreenGui" )
    local Y = Parent.AbsolutePosition.Y

    if not ScreenGui or ScreenGui.IgnoreGuiInset then
        Y3 = 0
    else
        local Y2 = GuiService:GetGuiInset( ).Y

        if Y2 then
            Y3 = Y2
        else
            Y3 = 0
        end
    end

    local Captured
    local Y4 = Y + Y3
    local Y5 = Y4 + Value12 * AbsoluteSize.Y
    local Y6 = Value9.AbsoluteSize.Y
    Captured = Value12

    for Key, Value in CollectionService:GetTagged( "AvoidHints" ) do
        if Value:IsA( "GuiObject" ) and Shown( Value ) then
            local Y9
            local ScreenGui2 = Value:FindFirstAncestorOfClass( "ScreenGui" )
            local Y7 = Value.AbsolutePosition.Y

            if not ScreenGui2 or ScreenGui2.IgnoreGuiInset then
                Y9 = 0
            else
                local Y8 = GuiService:GetGuiInset( ).Y

                if Y8 then
                    Y9 = Y8
                else
                    Y9 = 0
                end
            end

            local Y10 = Y7 + Y9

            if Y10 < Y5 + Y6 and Y5 < Y10 + Value.AbsoluteSize.Y then
                Captured = math.max( Captured, ( Y10 + Value.AbsoluteSize.Y + Y6 * 0.2 - Y4 ) / AbsoluteSize.Y )
            end
        end
    end
    if math.abs( Value9.Position.Y.Scale - Captured ) > 0.0005 then
        local Scale = Value9.Position.X.Scale
        Value9.Position = UDim2.new( Scale, Value9.Position.X.Offset, Captured, 0 )
    end
end

local Value13 = nil
local Flag4 = false
local Flag5 = false

local function BuildHints( Argument1 )
    if not HintsReady( ) then
        return
    end
    for Key, Value in Value9:GetChildren( ) do
        if Value:IsA( "Frame" ) then
            Value:Destroy( )
        end
    end
    if not Argument1 then
        Hint( 1, KeyCode.ButtonA, "Open" )
        Hint( 2, KeyCode.ButtonB, "Back" )
        return
    end

    Hint( 1, KeyCode.ButtonA, Argument1.selectLabel or "Select" )
    Hint( 2, KeyCode.ButtonB, Argument1.backLabel or "Back" )

    if Argument1.tabs then
        Hint( 3, { KeyCode.ButtonL1, KeyCode.ButtonR1 }, Argument1.tabs.label or "Category" )
    end

    local SelectedObject = GuiService.SelectedObject

    if SelectedObject and Class[ SelectedObject ] then
        local Flag

        if SelectedObject == nil then
            Flag = false
        elseif SelectedObject.Parent == nil then
            Flag = false
        elseif Argument1 == nil then
            Flag = false
        else
            local IsDescendantOf = SelectedObject:IsDescendantOf( Argument1.root )

            if IsDescendantOf then
                Flag = IsSelectable( SelectedObject )
            else
                Flag = IsDescendantOf
            end
        end
        if Flag then
            Flag4 = true
            Hint( 4, { KeyCode.DPadLeft, KeyCode.DPadRight }, "Adjust" )
        end
    end
    if not Argument1.actions or not Argument1.actions[ KeyCode.ButtonR3 ] then
        Hint( 50, KeyCode.ButtonR3, "Cursor" )
    end

    local Actions2
    local Actions = Argument1.actions
    Actions2 = if Actions then Actions else { }
    local Value1, Number
    Value1 = nil
    Number = 10

    for Key2, Value2 in Actions2, nil, nil do
        if type( Value2 ) == "table" and Value2.label then
            local Number3 = Number + 1
            Hint( Number3, Key2, Value2.label )
            Number = Number3
        end
    end

    local Hints2
    local Hints = Argument1.hints
    Hints2 = if Hints then Hints else { }
    local Value3 = nil

    for Key3, Value4 in Hints2, nil, nil do
        local Number2 = Number + 1
        Hint( Number2, Value4[ 1 ], Value4[ 2 ] )
        Number = Number2
    end
end

local function Capturing( Argument1 )
    local Flag

    if Argument1 == nil then
        Flag = false
    else
        local NotPassive = not Argument1.passive

        if NotPassive then
            Flag = NotPassive
        elseif Argument1.engaged == true then
            Flag = true
        else
            Flag = false
        end
    end

    return Flag
end

local function TopCapturing()
    local Flag
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        Flag = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            Flag = NotPassive
        elseif Entry.engaged == true then
            Flag = true
        else
            Flag = false
        end
    end

    local Entry2 = Flag and Entry or nil
    return Entry2
end

local Table6 = { }

local function Dispatch( KeyCodeInner )
    local Clock = os.clock( )

    if Controls.Capturing or Clock - ( Controls.CaptureEndedAt or 0 ) < 0.3 then
        return
    end
    if Flag2 or Clock - Number < 0.25 then
        return
    end
    if Table6[ KeyCodeInner ] and Clock - Table6[ KeyCodeInner ] < 0.12 then
        return
    end

    local FlagInner
    Table6[ KeyCodeInner ] = Clock
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        FlagInner = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            FlagInner = NotPassive
        elseif Entry.engaged == true then
            FlagInner = true
        else
            FlagInner = false
        end
    end

    local Entry2 = FlagInner and Entry or nil

    if Flag3 and KeyCodeInner == KeyCode.ButtonB then
        Callback( false )
        return
    end
    if Entry2 and KeyCodeInner == KeyCode.ButtonR3 then
        if not Entry2.actions or not Entry2.actions[ KeyCode.ButtonR3 ] then
            Callback( not Flag3 )
            return
        end
    end
    if Entry2 and Entry2.virtual then
        local Vsel2

        if Entry2.vsel then
            local Flag2Inner
            local Vsel = Entry2.vsel

            if Vsel == nil then
                Flag2Inner = false
            elseif Vsel.Parent == nil then
                Flag2Inner = false
            elseif Entry2 == nil then
                Flag2Inner = false
            else
                local IsDescendantOf = Vsel:IsDescendantOf( Entry2.root )

                if IsDescendantOf then
                    Flag2Inner = IsSelectable( Vsel )
                else
                    Flag2Inner = IsDescendantOf
                end
            end
            if not Flag2Inner or not Entry2.vsel then
                Vsel2 = FirstOf( Entry2 )
            else
                Vsel2 = Entry2.vsel
            end
        else
            Vsel2 = FirstOf( Entry2 )
        end
        if KeyCodeInner == KeyCode.ButtonA then
            local Vsel3

            if Vsel2 then
                local VirtualActions = Entry2.virtualActions

                if VirtualActions then
                    Vsel3 = Entry2.virtualActions[ Vsel2 ]
                else
                    Vsel3 = VirtualActions
                end
            else
                Vsel3 = Vsel2
            end
            if not Vsel3 and Entry2.onSelect then
                if Vsel2 == nil or Vsel2 == FirstOf( Entry2 ) then
                    Vsel3 = Entry2.onSelect
                end
            end

            local Vsel4

            if Vsel2 then
                local HoldButtons = Entry2.holdButtons

                if HoldButtons then
                    Vsel4 = Entry2.holdButtons[ Vsel2 ]
                else
                    Vsel4 = HoldButtons
                end
            else
                Vsel4 = Vsel2
            end
            if Vsel3 and Vsel4 then
                Entry2.hold = { start = os.clock( ), time = Vsel4, fn = Vsel3, target = Vsel2 }
                return
            end
            if Vsel3 then
                task.spawn( Vsel3 )
            end

            return
        end
        local Item4

        if KeyCodeInner == KeyCode.DPadUp then
            local Item = Table5[ 1 ]

            if Item then
                Item4 = Item
            elseif KeyCodeInner == KeyCode.DPadDown then
                local Item2 = Table5[ 2 ]

                if Item2 then
                    Item4 = Item2
                elseif KeyCodeInner == KeyCode.DPadLeft then
                    local Item3 = Table5[ 3 ]

                    if Item3 then
                        Item4 = Item3
                    elseif KeyCodeInner == KeyCode.DPadRight then
                        Item4 = Table5[ 4 ]
                    else
                        Item4 = false
                    end
                elseif KeyCodeInner == KeyCode.DPadRight then
                    Item4 = Table5[ 4 ]
                else
                    Item4 = false
                end
            elseif KeyCodeInner == KeyCode.DPadLeft then
                local Item3 = Table5[ 3 ]

                if Item3 then
                    Item4 = Item3
                elseif KeyCodeInner == KeyCode.DPadRight then
                    Item4 = Table5[ 4 ]
                else
                    Item4 = false
                end
            elseif KeyCodeInner == KeyCode.DPadRight then
                Item4 = Table5[ 4 ]
            else
                Item4 = false
            end
        elseif KeyCodeInner == KeyCode.DPadDown then
            local Item2 = Table5[ 2 ]

            if Item2 then
                Item4 = Item2
            elseif KeyCodeInner == KeyCode.DPadLeft then
                local Item3 = Table5[ 3 ]

                if Item3 then
                    Item4 = Item3
                elseif KeyCodeInner == KeyCode.DPadRight then
                    Item4 = Table5[ 4 ]
                else
                    Item4 = false
                end
            elseif KeyCodeInner == KeyCode.DPadRight then
                Item4 = Table5[ 4 ]
            else
                Item4 = false
            end
        elseif KeyCodeInner == KeyCode.DPadLeft then
            local Item3 = Table5[ 3 ]

            if Item3 then
                Item4 = Item3
            elseif KeyCodeInner == KeyCode.DPadRight then
                Item4 = Table5[ 4 ]
            else
                Item4 = false
            end
        elseif KeyCodeInner == KeyCode.DPadRight then
            Item4 = Table5[ 4 ]
        else
            Item4 = false
        end
        if Item4 then
            if Vsel2 then
                local Entry3
                local Collect2 = Collect( Entry2.root )
                local Best2 = Best( Vsel2, Collect2, Item4 )

                if Best2 or not ( #Collect2 > 1 ) then
                    Entry3 = Best2
                else
                    local NumberInner
                    table.sort( Collect2, function( Argument1, Argument2 )
                        local AbsolutePosition = Argument1.AbsolutePosition
                        local AbsolutePosition2 = Argument2.AbsolutePosition

                        if math.abs( AbsolutePosition.Y - AbsolutePosition2.Y ) > 4 then
                            local Flag = AbsolutePosition.Y < AbsolutePosition2.Y and true or false
                            return Flag
                        end
                        local Flag2 = AbsolutePosition.X < AbsolutePosition2.X and true or false
                        return Flag2
                    end )
                    local Find = table.find( Collect2, Vsel2 ) or 1
                    NumberInner = not ( Item4.x + Item4.y > 0 ) and -1 or 1
                    Entry3 = Collect2[ ( Find - 1 + NumberInner ) % #Collect2 + 1 ]
                end

                Entry2.vsel = Entry3 or Vsel2
            end

            return
        end
    end
    if Entry2 then
        if KeyCodeInner == KeyCode.ButtonB then
            if Entry2.onBack then
                task.spawn( Entry2.onBack )
                return
            end
        else
            if KeyCodeInner == KeyCode.ButtonL1 and Entry2.tabs then
                task.spawn( Entry2.tabs.prev )
                return
            end
            if KeyCodeInner == KeyCode.ButtonR1 and Entry2.tabs then
                task.spawn( Entry2.tabs.next )
                return
            end

            local Actions2
            local Actions = Entry2.actions
            Actions2 = if Actions then Entry2.actions[ KeyCodeInner ] else Actions

            if Actions2 then
                local Actions3 = if type( Actions2 ) ~= "function" or not Actions2 then Actions2.fn else Actions2
                task.spawn( Actions3 )
                return
            end
        end
    elseif Flag and KeyCodeInner == KeyCode.ButtonB then
        GuiService.SelectedObject = nil
    end
end

local function OnPad( Argument1, Argument2, Argument3 )
    if Argument2 == Enum.UserInputState.Begin then
        Dispatch( Argument3.KeyCode )
    elseif Argument3.KeyCode == KeyCode.ButtonA then
        local Flag
        local Entry = Table3[ #Table3 ]

        if Entry == nil then
            Flag = false
        else
            local NotPassive = not Entry.passive

            if NotPassive then
                Flag = NotPassive
            elseif Entry.engaged == true then
                Flag = true
            else
                Flag = false
            end
        end

        local Entry2 = Flag and Entry or nil

        if Entry2 then
            Entry2.hold = nil
        end
    end

    return Enum.ContextActionResult.Sink
end

UserInputService.InputBegan:Connect( function( Argument1 )
    if not table.find( Table, Argument1.KeyCode ) then
        return
    end

    local FlagInner
    local KeyCode = Argument1.KeyCode
    local Clock = os.clock( )
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        FlagInner = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            FlagInner = NotPassive
        elseif Entry.engaged == true then
            FlagInner = true
        else
            FlagInner = false
        end
    end

    local Entry2

    if not FlagInner or not Entry then
        Entry2 = nil
    else
        Entry2 = Entry
    end
    if not Entry2 then
        if Flag then
            Entry2 = "topbar"
        else
            Entry2 = Flag3 and "cursor"
        end
    end
    if not Entry2 then
        return
    end
    if type( Entry2 ) ~= "table" or not Entry2.openedAt or not ( Clock - Entry2.openedAt < 0.05 ) then
        task.delay( 0.03, function()
            local FlagInner
            local Entry = Table3[ #Table3 ]

            if Entry == nil then
                FlagInner = false
            else
                local NotPassive = not Entry.passive

                if NotPassive then
                    FlagInner = NotPassive
                elseif Entry.engaged == true then
                    FlagInner = true
                else
                    FlagInner = false
                end
            end

            local Entry2Inner

            if not FlagInner or not Entry then
                Entry2Inner = nil
            else
                Entry2Inner = Entry
            end
            if not Entry2Inner then
                if Flag then
                    Entry2Inner = "topbar"
                else
                    Entry2Inner = Flag3 and "cursor"
                end
            end
            if Entry2Inner ~= Entry2 then
                return
            end
            if Table6[ KeyCode ] then
                local Entry3 = Table6[ KeyCode ]

                if Clock - 0.01 <= Entry3 then
                    return
                end
            end

            Dispatch( KeyCode )
        end )
        return
    end
    return
end )

local function Sink()
    return Enum.ContextActionResult.Sink
end

local Value14 = nil

local function CursorBlocked()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or Humanoid.Health <= 0 then
        return false
    end
    if workspace:GetAttribute( "RankedMatch" ) then
        if not Value14 then
            local RankedShared2
            local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )
            RankedShared2 = if RankedShared then RankedShared:FindFirstChild( "MatchState" ) else RankedShared
            Value14 = RankedShared2
        end

        local Flag = ( Value14 and Value14:GetAttribute( "Phase" ) ) == "fight" and true or false
        return Flag
    end
    local Flag2
    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if type( CombatUntil ) == "number" then
        if workspace:GetServerTimeNow( ) < CombatUntil then
            Flag2 = true
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end

    return Flag2
end

UserInputService.InputBegan:Connect( function( Argument1 )
    if Argument1.UserInputState ~= Enum.UserInputState.Begin then
        return
    end

    local Pad = Controls.Actions.CursorMode.pad

    if not Pad or not table.find( Pad, Argument1.KeyCode ) or not Controls.IsGamepad then
        return
    end

    local FlagInner
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        FlagInner = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            FlagInner = NotPassive
        elseif Entry.engaged == true then
            FlagInner = true
        else
            FlagInner = false
        end
    end

    local Entry2 = FlagInner and Entry or nil

    if Entry2 or Flag then
        return
    end
    if Flag3 or not CursorBlocked( ) then
        Callback( not Flag3 )
        return
    end
    return
end )
local Update = nil

local function OnEngage( Argument1, Argument2 )
    local Entry = Table3[ #Table3 ]

    if Argument2 ~= Enum.UserInputState.Begin or not Entry or not Entry.passive or Entry.engaged then
        return Enum.ContextActionResult.Pass
    end

    Entry.engaged = true
    Entry.sig = nil
    Value13 = nil
    Update( )
    Relink( Entry )
    Entry.sig = Signature( Entry )
    local SelectedObject = FirstOf( Entry )

    if SelectedObject and Controls.IsGamepad then
        GuiService.SelectedObject = SelectedObject
    end

    return Enum.ContextActionResult.Sink
end

local Flag6 = false
local Flag7 = false
local Flag8 = false

Update = function()
    local FlagInner
    local Entry = Table3[ #Table3 ]
    local Entry2 = Table3[ #Table3 ]

    if Entry2 == nil then
        FlagInner = false
    else
        local NotPassive = not Entry2.passive

        if NotPassive then
            FlagInner = NotPassive
        elseif Entry2.engaged == true then
            FlagInner = true
        else
            FlagInner = false
        end
    end

    local Entry3 = FlagInner and Entry2 or nil
    local MenuOpen

    if Entry3 == nil then
        if Flag then
            MenuOpen = Flag
        else
            MenuOpen = Flag3
        end
    else
        MenuOpen = true
    end

    local Flag2

    if Entry == nil then
        Flag2 = false
    elseif Entry.passive == true then
        local NotEngaged = not Entry.engaged

        if NotEngaged then
            local NotCaptured = not Flag

            if NotCaptured then
                Flag2 = not Flag3
            else
                Flag2 = NotCaptured
            end
        else
            Flag2 = NotEngaged
        end
    else
        Flag2 = false
    end
    if Flag2 ~= Flag8 then
        Flag8 = Flag2

        if Flag2 then
            ContextActionService:BindActionAtPriority( "GamepadNavEngage", OnEngage, false, 4000, KeyCode.ButtonY )
        else
            ContextActionService:UnbindAction( "GamepadNavEngage" )
        end
    end

    local MenuKeysAllowed
    Controls.MenuOpen = MenuOpen

    if Flag3 then
        if Entry3 == nil then
            MenuKeysAllowed = not Flag
        else
            MenuKeysAllowed = false
        end
    else
        MenuKeysAllowed = Flag3
    end

    local Id
    Controls.MenuKeysAllowed = MenuKeysAllowed
    ClientState.GamepadNav = MenuOpen

    if not Entry3 or not Entry3.id then
        if Flag then
            Id = "Topbar"
        elseif Flag3 then
            Id = "Cursor"
        else
            Id = nil
        end
    else
        Id = Entry3.id
    end

    local Text
    LocalPlayer:SetAttribute( "NavTop", Id )
    LocalPlayer:SetAttribute( "NavCursor", Flag3 or nil )

    if MenuOpen then
        if Entry3 ~= nil or Flag or not Flag3 then
            if not Entry3 or not Entry3.virtual or Flag3 then
                Text = "menu"
            else
                Text = "virtual"
            end
        else
            Text = "cursor"
        end
    else
        Text = false
    end
    if Text ~= Flag6 then
        Flag6 = Text
        ContextActionService:UnbindAction( "GamepadNavButtons" )

        if Text then
            local Table3Inner

            if Text == "cursor" then
                local Value1
                local TableInner = { }
                Value1 = nil

                for Key, Value in Table, nil, nil do
                    if Value ~= KeyCode.ButtonSelect then
                        table.insert( TableInner, Value )
                    end
                end

                Table3Inner = TableInner
            elseif Text == "virtual" then
                local Value2
                local Clone = table.clone( Table )
                local Table2 = {
                    KeyCode.ButtonA,
                    KeyCode.DPadUp,
                    KeyCode.DPadDown,
                    KeyCode.DPadLeft,
                    KeyCode.DPadRight
                }
                Value2 = nil

                for Key2, Value3 in Table2, nil, nil do
                    table.insert( Clone, Value3 )
                    Table3Inner = Clone
                end

                Table3Inner = Clone
            else
                Table3Inner = Table
            end

            ContextActionService:BindActionAtPriority( "GamepadNavButtons", OnPad, false, 4000, table.unpack( Table3Inner ) )
        end
    end

    local Flag3Inner

    if MenuOpen then
        if Entry3 == nil or Entry3.freeze ~= false then
            local IsGamepad = Controls.IsGamepad

            if IsGamepad then
                Flag3Inner = IsGamepad
            elseif Entry3 == nil then
                Flag3Inner = false
            elseif Entry3.freezeKeyboard == true then
                Flag3Inner = true
            else
                Flag3Inner = false
            end
        else
            Flag3Inner = false
        end
    else
        Flag3Inner = MenuOpen
    end

    local HighlightKey = Entry3 == nil and not Flag3 and Enum.KeyCode.DPadUp or false
    Icon.highlightKey = HighlightKey

    if Flag3Inner ~= Flag7 then
        Flag7 = Flag3Inner
        ClientState.NavFreeze = Flag3Inner or nil
        local ControlModule = Controls.ControlModule( )

        if ControlModule then
            pcall( function()
                if Flag3Inner then
                    ControlModule:Disable( )
                    return
                end
                ControlModule:Enable( )
                return
            end )
        end
        if Flag3Inner then
            ContextActionService:BindActionAtPriority( "GamepadNavFreeze", Sink, false, 4000, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump )
        else
            ContextActionService:UnbindAction( "GamepadNavFreeze" )
        end
    end

    local Text2

    if Controls.IsGamepad then
        if Flag3 then
            if Entry3 then
                Text2 = "cursorMenu"
            else
                Text2 = "cursor"
            end
        elseif MenuOpen then
            if Entry3 then
                Text2 = Entry3
            else
                Text2 = "topbar"
            end
        elseif Flag2 then
            Text2 = "engage"
        else
            Text2 = nil
        end
    else
        Text2 = nil
    end
    if Entry3 and Entry3.noHints then
        Text2 = nil
    end
    if Text2 ~= Value13 and HintsReady( ) then
        Value13 = Text2
        Flag4 = false

        if Text2 == "engage" then
            for Key3, Value4 in Value9:GetChildren( ) do
                if Value4:IsA( "Frame" ) then
                    Value4:Destroy( )
                end
            end

            Hint( 1, KeyCode.ButtonY, Entry.engageLabel or "Browse" )
        elseif Text2 == "cursor" or Text2 == "cursorMenu" then
            for Key4, Value5 in Value9:GetChildren( ) do
                if Value5:IsA( "Frame" ) then
                    Value5:Destroy( )
                end
            end

            local Text3
            Hint( 1, KeyCode.ButtonA, "Click" )
            local ButtonB = KeyCode.ButtonB
            Text3 = Text2 ~= "cursorMenu" and "Back to game" or "Selection"
            Hint( 2, ButtonB, Text3 )
        elseif Text2 then
            BuildHints( Entry3 )
        end
    end

    local Flag4Inner = Text2 ~= nil and true or false
    Flag5 = Flag4Inner

    if Value8 then
        Screens.SetShown( Value8, Flag5 )
    end
end

Callback = function( Argument1 )
    if Argument1 == Flag3 then
        return
    end

    Flag3 = Argument1
    Number2 = os.clock( )

    if Argument1 then
        GuiService.SelectedObject = nil
        pcall( GamepadService.EnableGamepadCursor, GamepadService, nil )
    else
        local Flag
        pcall( GamepadService.DisableGamepadCursor, GamepadService )
        local Entry = Table3[ #Table3 ]

        if Entry == nil then
            Flag = false
        else
            local NotPassive = not Entry.passive

            if NotPassive then
                Flag = NotPassive
            elseif Entry.engaged == true then
                Flag = true
            else
                Flag = false
            end
        end

        local Entry2 = Flag and Entry or nil

        if Entry2 and Controls.IsGamepad then
            local Flag2
            local Last = Entry2.last

            if Last == nil then
                Flag2 = false
            elseif Last.Parent == nil then
                Flag2 = false
            elseif Entry2 == nil then
                Flag2 = false
            else
                local IsDescendantOf = Last:IsDescendantOf( Entry2.root )

                if IsDescendantOf then
                    Flag2 = IsSelectable( Last )
                else
                    Flag2 = IsDescendantOf
                end
            end

            local SelectedObject

            if not Flag2 or not Entry2.last then
                SelectedObject = FirstOf( Entry2 )
            else
                SelectedObject = Entry2.last
            end

            GuiService.SelectedObject = SelectedObject
        end
    end

    Value13 = nil
    Update( )
end

local function CursorOn()
    return Flag3
end

task.spawn( function()
    local LocalizationService = game:GetService( "LocalizationService" )
    local Success, Result = pcall( LocalizationService.GetTranslatorForPlayerAsync, LocalizationService, LocalPlayer )

    if Success and Result then
        Value11 = Result
        Value13 = nil
        Update( )
    end
end )

local function Open( Key, List )
    local Entry2
    local Entry = Table4[ Key ]

    if Entry then
        table.remove( Table3, table.find( Table3, Entry ) )
        Entry2 = Entry
    else
        local Table = { id = Key, returnTo = GuiService.SelectedObject }
        Table4[ Key ] = Table
        Entry2 = Table
    end

    local Value1 = nil

    for Key2, Value in List, nil, nil do
        Entry2[ Key2 ] = Value
    end
    if Entry2.root:IsA( "GuiObject" ) then
        Entry2.root.SelectionGroup = true
        Entry2.root.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        Entry2.root.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        Entry2.root.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
        Entry2.root.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    end

    table.insert( Table3, Entry2 )
    Entry2.openedAt = os.clock( )
    Entry2.vsel = nil
    Entry2.last = nil
    Entry2.sig = nil
    Entry2.engaged = false
    Value13 = nil
    Update( )

    if Controls.IsGamepad and not Entry2.passive and not Entry2.virtual and not Flag3 then
        task.defer( function()
            if Table3[ #Table3 ] ~= Entry2 then
                return
            end

            Relink( Entry2 )
            Entry2.sig = Signature( Entry2 )
            local SelectedObject = FirstOf( Entry2 )

            if SelectedObject then
                GuiService.SelectedObject = SelectedObject
            end
        end )
    end
end

local function Close( Key )
    local Entry = Table4[ Key ]

    if not Entry then
        return
    end

    Table4[ Key ] = nil
    table.remove( Table3, table.find( Table3, Entry ) )
    local SelectedObject = GuiService.SelectedObject

    if SelectedObject == nil or SelectedObject:IsDescendantOf( Entry.root ) or not SelectedObject.Parent then
        local Flag
        local Entry2 = Table3[ #Table3 ]

        if Entry2 == nil then
            Flag = false
        else
            local NotPassive = not Entry2.passive

            if NotPassive then
                Flag = NotPassive
            elseif Entry2.engaged == true then
                Flag = true
            else
                Flag = false
            end
        end

        local Entry3 = Flag and Entry2 or nil

        if not Entry3 or not Controls.IsGamepad then
            if Entry3 or not Controls.IsGamepad or not Entry.returnTo or not Entry.returnTo.Parent or not IsTopbar( Entry.returnTo ) then
                GuiService.SelectedObject = nil
            else
                local SelectedObject3
                local ReturnTo = Entry.returnTo

                if ReturnTo == nil then
                    SelectedObject3 = ReturnTo
                elseif not ReturnTo.Parent or not ReturnTo:FindFirstAncestorWhichIsA( "PlayerGui" ) or not IsSelectable( ReturnTo ) then
                    SelectedObject3 = nil
                else
                    SelectedObject3 = ReturnTo
                end
                if GuiService.SelectedObject ~= SelectedObject3 then
                    GuiService.SelectedObject = SelectedObject3
                end
            end
        else
            local Flag2
            local Last = Entry3.last

            if Last == nil then
                Flag2 = false
            elseif Last.Parent == nil then
                Flag2 = false
            elseif Entry3 == nil then
                Flag2 = false
            else
                local IsDescendantOf = Last:IsDescendantOf( Entry3.root )

                if IsDescendantOf then
                    Flag2 = IsSelectable( Last )
                else
                    Flag2 = IsDescendantOf
                end
            end

            local SelectedObject2

            if not Flag2 or not Entry3.last then
                SelectedObject2 = FirstOf( Entry3 )
            else
                SelectedObject2 = Entry3.last
            end
            if SelectedObject2 ~= nil then
                if not SelectedObject2.Parent or not SelectedObject2:FindFirstAncestorWhichIsA( "PlayerGui" ) or not IsSelectable( SelectedObject2 ) then
                    SelectedObject2 = nil
                end
            end
            if GuiService.SelectedObject ~= SelectedObject2 then
                GuiService.SelectedObject = SelectedObject2
            end
        end
    end
    if Flag3 then
        local Flag3Inner
        local Entry4 = Table3[ #Table3 ]

        if Entry4 == nil then
            Flag3Inner = false
        else
            local NotPassive2 = not Entry4.passive

            if NotPassive2 then
                Flag3Inner = NotPassive2
            elseif Entry4.engaged == true then
                Flag3Inner = true
            else
                Flag3Inner = false
            end
        end

        local Entry5 = Flag3Inner and Entry4 or nil

        if not Entry5 then
            Callback( false )
        end
    end

    Value13 = nil
    Update( )
end

local function Refresh( Key, Argument2 )
    local Entry = Table4[ Key ]

    if Entry then
        task.defer( function()
            -- Could not structure function #39
        end )
        return
    end
    return
end

local function Select( SelectedObject )
    local Flag
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        Flag = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            Flag = NotPassive
        elseif Entry.engaged == true then
            Flag = true
        else
            Flag = false
        end
    end

    local Entry2 = Flag and Entry or nil

    if Entry2 and Controls.IsGamepad then
        local Flag2

        if SelectedObject == nil then
            Flag2 = false
        elseif SelectedObject.Parent == nil then
            Flag2 = false
        elseif Entry2 == nil then
            Flag2 = false
        else
            local IsDescendantOf = SelectedObject:IsDescendantOf( Entry2.root )

            if IsDescendantOf then
                Flag2 = IsSelectable( SelectedObject )
            else
                Flag2 = IsDescendantOf
            end
        end
        if Flag2 then
            local SelectedObject2

            if SelectedObject == nil then
                SelectedObject2 = SelectedObject
            elseif not SelectedObject.Parent or not SelectedObject:FindFirstAncestorWhichIsA( "PlayerGui" ) or not IsSelectable( SelectedObject ) then
                SelectedObject2 = nil
            else
                SelectedObject2 = SelectedObject
            end
            if GuiService.SelectedObject ~= SelectedObject2 then
                GuiService.SelectedObject = SelectedObject2
            end
        end
    end
end

local function IsOpen( Key )
    local Flag = Table4[ Key ] ~= nil and true or false
    return Flag
end

local function SetVirtual( VirtualName, Vsel )
    local Entry = Table4[ VirtualName ]

    if Entry and Entry.virtual and Vsel then
        local Flag

        if Vsel == nil then
            Flag = false
        elseif Vsel.Parent == nil then
            Flag = false
        elseif Entry == nil then
            Flag = false
        else
            local IsDescendantOf = Vsel:IsDescendantOf( Entry.root )

            if IsDescendantOf then
                Flag = IsSelectable( Vsel )
            else
                Flag = IsDescendantOf
            end
        end
        if Flag then
            Entry.vsel = Vsel
        end
    end
end

local function GetVirtual( Key )
    local Vsel
    local Entry = Table4[ Key ]
    Vsel = Entry and Entry.vsel or nil
    return Vsel
end

local function Hover( Argument1, Argument2, Argument3 )
    local Table = {
        Argument1.MouseEnter:Connect( Argument2 ),
        Argument1.SelectionGained:Connect( Argument2 )
    }

    if Argument3 then
        table.insert( Table, Argument1.MouseLeave:Connect( Argument3 ) )
        table.insert( Table, Argument1.SelectionLost:Connect( Argument3 ) )
    end

    return Table
end

local Value15 = nil

local function Adjust( Key, Argument2 )
    Class[ Key ] = Argument2
end

local function AdjustTarget()
    local Flag
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        Flag = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            Flag = NotPassive
        elseif Entry.engaged == true then
            Flag = true
        else
            Flag = false
        end
    end

    local Entry2 = Flag and Entry or nil
    local SelectedObject = GuiService.SelectedObject

    if Entry2 and not Entry2.virtual and not Flag3 and not Flag2 and Controls.IsGamepad and SelectedObject and Class[ SelectedObject ] then
        local Flag2Inner

        if SelectedObject == nil then
            Flag2Inner = false
        elseif SelectedObject.Parent == nil then
            Flag2Inner = false
        elseif Entry2 == nil then
            Flag2Inner = false
        else
            local IsDescendantOf = SelectedObject:IsDescendantOf( Entry2.root )

            if IsDescendantOf then
                Flag2Inner = IsSelectable( SelectedObject )
            else
                Flag2Inner = IsDescendantOf
            end
        end
        if Flag2Inner then
            return SelectedObject
        end
    end

    return nil
end

local function AdjustPress( Press )
    local Flag
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        Flag = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            Flag = NotPassive
        elseif Entry.engaged == true then
            Flag = true
        else
            Flag = false
        end
    end

    local Entry2 = Flag and Entry or nil
    local SelectedObject2
    local SelectedObject = GuiService.SelectedObject

    if not Entry2 or Entry2.virtual or Flag3 or Flag2 or not Controls.IsGamepad or not SelectedObject or not Class[ SelectedObject ] then
        SelectedObject2 = nil
    else
        local Flag2Inner

        if SelectedObject == nil then
            Flag2Inner = false
        elseif SelectedObject.Parent == nil then
            Flag2Inner = false
        elseif Entry2 == nil then
            Flag2Inner = false
        else
            local IsDescendantOf = SelectedObject:IsDescendantOf( Entry2.root )

            if IsDescendantOf then
                Flag2Inner = IsSelectable( SelectedObject )
            else
                Flag2Inner = IsDescendantOf
            end
        end
        if Flag2Inner then
            SelectedObject2 = SelectedObject
        else
            SelectedObject2 = nil
        end
    end
    if SelectedObject2 then
        task.spawn( Class[ SelectedObject2 ], Press )
        Value15 = { dir = Press, target = SelectedObject2, nextAt = os.clock( ) + 0.35 }
        return
    end
    return
end

local function AdjustRepeat()
    local Flag
    local Target = Value15.target
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        Flag = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            Flag = NotPassive
        elseif Entry.engaged == true then
            Flag = true
        else
            Flag = false
        end
    end

    local Entry2 = Flag and Entry or nil
    local SelectedObject2
    local SelectedObject = GuiService.SelectedObject

    if not Entry2 or Entry2.virtual or Flag3 or Flag2 or not Controls.IsGamepad or not SelectedObject or not Class[ SelectedObject ] then
        SelectedObject2 = nil
    else
        local Flag2Inner

        if SelectedObject == nil then
            Flag2Inner = false
        elseif SelectedObject.Parent == nil then
            Flag2Inner = false
        elseif Entry2 == nil then
            Flag2Inner = false
        else
            local IsDescendantOf = SelectedObject:IsDescendantOf( Entry2.root )

            if IsDescendantOf then
                Flag2Inner = IsSelectable( SelectedObject )
            else
                Flag2Inner = IsDescendantOf
            end
        end
        if Flag2Inner then
            SelectedObject2 = SelectedObject
        else
            SelectedObject2 = nil
        end
    end
    if Target ~= SelectedObject2 then
        Value15 = nil
        return
    end

    local Clock = os.clock( )

    if Value15.nextAt <= Clock then
        Value15.nextAt = os.clock( ) + 0.07
        task.spawn( Class[ Value15.target ], Value15.dir )
    end
end

UserInputService.InputBegan:Connect( function( Argument1 )
    if Argument1.KeyCode == KeyCode.DPadLeft then
        AdjustPress( -1 )
        return
    end
    if Argument1.KeyCode == KeyCode.DPadRight then
        AdjustPress( 1 )
    end
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    if Value15 then
        if Argument1.KeyCode == KeyCode.DPadLeft or Argument1.KeyCode == KeyCode.DPadRight then
            Value15 = nil
        end
    end
end )
local Number3 = 0
UserInputService.InputChanged:Connect( function( Argument1 )
    if Argument1.KeyCode ~= KeyCode.Thumbstick1 then
        return
    end

    local Number
    local X = Argument1.Position.X

    if X > 0.6 then
        Number = 1
    elseif X < -0.6 then
        Number = -1
    elseif math.abs( X ) < 0.35 then
        Number = 0
    else
        Number = Number3
    end
    if Number == Number3 then
        return
    end

    Number3 = Number

    if Number == 0 then
        Value15 = nil
        return
    end
    AdjustPress( Number )
    return
end )
local Number4 = 0

local function Prompt( Callback )
    Number4 = Number4 + 1
    Flag2 = true
    task.delay( 180, function()
        if Number4 == Number4 then
            Flag2 = false
        end
    end )

    if not pcall( Callback ) then
        Flag2 = false
    end
end

local function PromptDone()
    Number4 = Number4 + 1

    if Flag2 then
        Number = os.clock( )
    end

    Flag2 = false
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect( PromptDone )
MarketplaceService.PromptProductPurchaseFinished:Connect( PromptDone )
MarketplaceService.PromptPurchaseFinished:Connect( PromptDone )
local Table2 = {
    CursorOn = CursorOn,
    Open = Open,
    Close = Close,
    Refresh = Refresh,
    Select = Select,
    IsOpen = IsOpen,
    SetVirtual = SetVirtual,
    GetVirtual = GetVirtual,
    Hover = Hover,
    Adjust = Adjust,
    Prompt = Prompt,
    Top = function()
        local Entry2
        local Entry = Table3[ #Table3 ]
        Entry2 = if Entry then Entry.id else Entry
        return Entry2
    end
}
local Value16 = nil

local function LinkTopbar()
    local Table = { }

    for Key, Value in LocalPlayer.PlayerGui:GetChildren( ) do
        if Value:IsA( "ScreenGui" ) and Value.Name:sub( 1, 6 ) == "Topbar" and Value.Enabled then
            for Key4, Value5 in Value:GetDescendants( ) do
                if Value5.Name == "ClickRegion" and Value5:IsA( "GuiObject" ) and Value5.Selectable and Value5.AbsoluteSize.X > 2 and Shown( Value5 ) then
                    table.insert( Table, Value5 )
                end
            end
        end
    end

    local Value1 = nil

    for Key2, Value2 in Table, nil, nil do
        local Value3 = nil

        for Key3, Value4 in Table5, nil, nil do
            Value2[ Value4.prop ] = Best( Value2, Table, Value4 ) or Value2
        end
    end
end

local Value17 = nil

local function HoldFill( Object, Clamp )
    local Number = Clamp or 0

    if Value17 and Value17 ~= Object then
        local Fill
        local HoldBar = Value17:FindFirstChild( "HoldBar" )

        if HoldBar then
            Fill = HoldBar:FindFirstChild( "Fill" )
        else
            Fill = HoldBar
        end
        if Fill then
            Fill.Size = UDim2.fromScale( 0, 1 )
        end

        Value17 = nil
    end

    local HoldBar2

    if Object then
        HoldBar2 = Object:FindFirstChild( "HoldBar" )
    else
        HoldBar2 = Object
    end

    local Fill2

    if HoldBar2 then
        Fill2 = HoldBar2:FindFirstChild( "Fill" )
    else
        Fill2 = HoldBar2
    end
    if not Fill2 then
        return
    end

    local Value1
    Fill2.Size = UDim2.fromScale( Number, 1 )
    Value1 = Number > 0 and Object or nil
    Value17 = Value1
end

local Value18 = nil
local Number5 = 0
RunService.RenderStepped:Connect( function()
    if not Value8 or not Value8.Parent then
        if HintsReady( ) then
            Value13 = nil
            Update( )
        end
    elseif Screens.IsShown( Value8 ) ~= Flag5 then
        Screens.SetShown( Value8, Flag5 )
    end
    if Flag5 then
        AvoidBanners( )
    end

    SelectionGui( )

    if Value15 then
        AdjustRepeat( )
    end
    if Flag2 or GuiService.MenuIsOpen then
        if SelectionGui( ) then
            Screens.SetShown( Value2, false )
        end
        if Value17 and Value17 and Value17 ~= nil then
            local Fill5
            local HoldBar5 = Value17:FindFirstChild( "HoldBar" )

            if HoldBar5 then
                Fill5 = HoldBar5:FindFirstChild( "Fill" )
            else
                Fill5 = HoldBar5
            end
            if Fill5 then
                Fill5.Size = UDim2.fromScale( 0, 1 )
            end

            Value17 = nil
        end

        return
    end
    if Flag3 then
        local FlagInner
        local Entry = Table3[ #Table3 ]

        if Entry == nil then
            FlagInner = false
        else
            local NotPassive = not Entry.passive

            if NotPassive then
                FlagInner = NotPassive
            elseif Entry.engaged == true then
                FlagInner = true
            else
                FlagInner = false
            end
        end

        local Entry2 = FlagInner and Entry or nil

        if not Entry2 and CursorBlocked( ) then
            Callback( false )
        end
    end
    if Flag3 then
        if Controls.IsGamepad then
            if not GamepadService.GamepadCursorEnabled and os.clock( ) - Number2 > 1 then
                Callback( false )
            end
        else
            Callback( false )
        end
        if Flag3 then
            if SelectionGui( ) then
                Screens.SetShown( Value2, false )
            end
            if Value17 and Value17 and Value17 ~= nil then
                local Fill
                local HoldBar = Value17:FindFirstChild( "HoldBar" )

                if HoldBar then
                    Fill = HoldBar:FindFirstChild( "Fill" )
                else
                    Fill = HoldBar
                end
                if Fill then
                    Fill.Size = UDim2.fromScale( 0, 1 )
                end

                Value17 = nil
            end

            return
        end
    end

    local Flag2Inner
    local Entry3 = Table3[ #Table3 ]

    if Entry3 == nil then
        Flag2Inner = false
    else
        local NotPassive2 = not Entry3.passive

        if NotPassive2 then
            Flag2Inner = NotPassive2
        elseif Entry3.engaged == true then
            Flag2Inner = true
        else
            Flag2Inner = false
        end
    end

    local Entry4 = Flag2Inner and Entry3 or nil

    if Value17 then
        if not Entry4 or not Entry4.virtual or not Entry4.hold then
            if Value17 and Value17 ~= nil then
                local Fill2
                local HoldBar2 = Value17:FindFirstChild( "HoldBar" )

                if HoldBar2 then
                    Fill2 = HoldBar2:FindFirstChild( "Fill" )
                else
                    Fill2 = HoldBar2
                end
                if Fill2 then
                    Fill2.Size = UDim2.fromScale( 0, 1 )
                end

                Value17 = nil
            end
        end
    end

    local Last = GuiService.SelectedObject

    if not Entry4 or not Entry4.virtual then
        if Entry4 then
            if Controls.IsGamepad then
                local Flag4Inner

                if Last == nil then
                    Flag4Inner = false
                elseif Last.Parent == nil then
                    Flag4Inner = false
                elseif Entry4 == nil then
                    Flag4Inner = false
                else
                    local IsDescendantOf2 = Last:IsDescendantOf( Entry4.root )

                    if IsDescendantOf2 then
                        Flag4Inner = IsSelectable( Last )
                    else
                        Flag4Inner = IsDescendantOf2
                    end
                end
                if Flag4Inner then
                    Entry4.last = Last
                else
                    local Flag5Inner
                    local Last2 = Entry4.last

                    if Last2 == nil then
                        Flag5Inner = false
                    elseif Last2.Parent == nil then
                        Flag5Inner = false
                    elseif Entry4 == nil then
                        Flag5Inner = false
                    else
                        local IsDescendantOf3 = Last2:IsDescendantOf( Entry4.root )

                        if IsDescendantOf3 then
                            Flag5Inner = IsSelectable( Last2 )
                        else
                            Flag5Inner = IsDescendantOf3
                        end
                    end

                    local Last3

                    if not Flag5Inner or not Entry4.last then
                        Last3 = FirstOf( Entry4 )
                    else
                        Last3 = Entry4.last
                    end
                    if Last3 and Last3 ~= Last then
                        local SelectedObject

                        if Last3 == nil then
                            SelectedObject = Last3
                        elseif not Last3.Parent or not Last3:FindFirstAncestorWhichIsA( "PlayerGui" ) or not IsSelectable( Last3 ) then
                            SelectedObject = nil
                        else
                            SelectedObject = Last3
                        end
                        if GuiService.SelectedObject ~= SelectedObject then
                            GuiService.SelectedObject = SelectedObject
                        end
                    end
                end

                local Clock = os.clock( )

                if Clock - Number5 > 0.2 then
                    Number5 = Clock
                    local Sig = Signature( Entry4 )

                    if Sig ~= Entry4.sig then
                        Entry4.sig = Sig
                        Relink( Entry4 )
                    end
                end
            elseif Last and Last:IsDescendantOf( Entry4.root ) then
                GuiService.SelectedObject = nil
            end
        elseif Last and not IsTopbar( Last ) then
            local SelectedObject2

            if not Flag or not Value16 or not Value16.Parent or not Shown( Value16 ) or not Value16 then
                SelectedObject2 = nil
            else
                SelectedObject2 = Value16
            end
            if SelectedObject2 ~= nil then
                if not SelectedObject2.Parent or not SelectedObject2:FindFirstAncestorWhichIsA( "PlayerGui" ) or not IsSelectable( SelectedObject2 ) then
                    SelectedObject2 = nil
                end
            end
            if GuiService.SelectedObject ~= SelectedObject2 then
                GuiService.SelectedObject = SelectedObject2
            end
        end

        local Flag6
        local SelectedObject3 = GuiService.SelectedObject

        if Entry4 == nil then
            if SelectedObject3 == nil then
                Flag6 = false
            else
                Flag6 = IsTopbar( SelectedObject3 )
            end
        else
            Flag6 = false
        end
        if Flag6 then
            Value16 = SelectedObject3
        end
        if Flag6 ~= Flag then
            Flag = Flag6

            if Flag6 then
                LinkTopbar( )
            end

            Update( )
        end

        local IsDescendantOf4

        if SelectedObject3 == nil then
            IsDescendantOf4 = false
        elseif Entry4 == nil then
            IsDescendantOf4 = false
        else
            local IsGamepad = Controls.IsGamepad

            if IsGamepad then
                IsDescendantOf4 = SelectedObject3:IsDescendantOf( Entry4.root )
            else
                IsDescendantOf4 = IsGamepad
            end
        end
        if SelectedObject3 ~= Value18 then
            local Flag7
            Value18 = SelectedObject3

            if IsDescendantOf4 then
                if Class[ SelectedObject3 ] == nil then
                    Flag7 = false
                else
                    Flag7 = true
                end
            else
                Flag7 = IsDescendantOf4
            end
            if Flag7 ~= Flag4 then
                Value13 = nil
                Update( )
            end
            if IsDescendantOf4 and Value1 and SelectedObject3:GetAttribute( "NavOwnHighlight" ) ~= true and SelectedObject3.SelectionImageObject ~= Value1 then
                SelectedObject3.SelectionImageObject = Value1
            end
        end

        local SelectedObject4 = IsDescendantOf4 and SelectedObject3:GetAttribute( "NavOwnHighlight" ) ~= true and SelectedObject3 or nil
        PlaceHighlight( SelectedObject4 )
        return
    end
    if Last and Last:IsDescendantOf( Entry4.root ) then
        GuiService.SelectedObject = nil
    end
    if Entry4.vsel then
        local Flag3Inner
        local Vsel = Entry4.vsel

        if Vsel == nil then
            Flag3Inner = false
        elseif Vsel.Parent == nil then
            Flag3Inner = false
        elseif Entry4 == nil then
            Flag3Inner = false
        else
            local IsDescendantOf = Vsel:IsDescendantOf( Entry4.root )

            if IsDescendantOf then
                Flag3Inner = IsSelectable( Vsel )
            else
                Flag3Inner = IsDescendantOf
            end
        end
        if not Flag3Inner then
            Entry4.vsel = FirstOf( Entry4 )
        end
    else
        Entry4.vsel = FirstOf( Entry4 )
    end

    local Vsel2 = Controls.IsGamepad and Entry4.vsel or nil
    local Hold2
    PlaceHighlight( Vsel2 )
    local Hold = Entry4.hold

    if Hold then
        if Hold.target == Entry4.vsel then
            if UserInputService:IsGamepadButtonDown( Enum.UserInputType.Gamepad1, KeyCode.ButtonA ) or UserInputService:IsKeyDown( KeyCode.ButtonA ) then
                Hold2 = Hold
            else
                Entry4.hold = nil
                Hold2 = nil
            end
        else
            Entry4.hold = nil
            Hold2 = nil
        end
    else
        Hold2 = Hold
    end
    if Hold2 then
        local Clamp = math.clamp( ( os.clock( ) - Hold2.start ) / Hold2.time, 0, 1 )

        if Value7 then
            Value7.Color = Color32:Lerp( FromRGB, Clamp )
        end

        HoldFill( Hold2.target, Clamp )

        if Clamp >= 1 then
            Entry4.hold = nil

            if Value17 and Value17 ~= nil then
                local Fill3
                local HoldBar3 = Value17:FindFirstChild( "HoldBar" )

                if HoldBar3 then
                    Fill3 = HoldBar3:FindFirstChild( "Fill" )
                else
                    Fill3 = HoldBar3
                end
                if Fill3 then
                    Fill3.Size = UDim2.fromScale( 0, 1 )
                end

                Value17 = nil
            end

            task.spawn( Hold2.fn )
        end
    else
        if Value17 and Value17 and Value17 ~= nil then
            local Fill4
            local HoldBar4 = Value17:FindFirstChild( "HoldBar" )

            if HoldBar4 then
                Fill4 = HoldBar4:FindFirstChild( "Fill" )
            else
                Fill4 = HoldBar4
            end
            if Fill4 then
                Fill4.Size = UDim2.fromScale( 0, 1 )
            end

            Value17 = nil
        end
        if Value7 and Value7.Color ~= Color32 then
            Value7.Color = Color32
        end
    end
    if Flag then
        Flag = false
        Update( )
    end

    return
end )
Controls.Changed:Connect( function( Argument1 )
    local Flag
    local Entry = Table3[ #Table3 ]

    if Entry == nil then
        Flag = false
    else
        local NotPassive = not Entry.passive

        if NotPassive then
            Flag = NotPassive
        elseif Entry.engaged == true then
            Flag = true
        else
            Flag = false
        end
    end

    local Entry2 = Flag and Entry or nil

    if Argument1 and Entry2 and not Entry2.virtual then
        local Flag2
        Relink( Entry2 )
        Entry2.sig = Signature( Entry2 )
        local Last = Entry2.last

        if Last == nil then
            Flag2 = false
        elseif Last.Parent == nil then
            Flag2 = false
        elseif Entry2 == nil then
            Flag2 = false
        else
            local IsDescendantOf = Last:IsDescendantOf( Entry2.root )

            if IsDescendantOf then
                Flag2 = IsSelectable( Last )
            else
                Flag2 = IsDescendantOf
            end
        end

        local SelectedObject

        if not Flag2 or not Entry2.last then
            SelectedObject = FirstOf( Entry2 )
        else
            SelectedObject = Entry2.last
        end

        GuiService.SelectedObject = SelectedObject
    end

    Value13 = nil
    Update( )
end )
LocalPlayer.CharacterAdded:Connect( function()
    task.delay( 1, function()
        local Count = #Table3
        local I = Count

        for I = Count, 1, -1 do
            local Entry = Table3[ I ]

            if not Entry.root.Parent then
                Table2.Close( Entry.id )
            end
        end
    end )
end )
task.spawn( function()
    task.wait( 19 + math.random( ) * 5 )
    local Table = { 999979, 37, 1000037, 113 }

    local function H( Argument1 )
        local Number, Number2
        local Text = tostring( Argument1 )
        local Count = #Text
        local I = 1
        Number = 0
        Number2 = 0

        for I = 1, Count do
            local Byte = string.byte( Text, I )
            Number = ( Number * Table[ 2 ] + Byte ) % Table[ 1 ]
            Number2 = ( Number2 * Table[ 4 ] + Byte ) % Table[ 3 ]
        end

        return Number * 1000000 + Number2
    end

    local Table2 = { [ 754498597262 ] = 1, [ 471459208065 ] = 1 }

    if not LocalPlayer or game.GameId == 0 or Table2[ H( game.GameId ) ] or Table2[ H( game.CreatorId ) ] or H( LocalPlayer.UserId ) ~= 839532811263 then
        return
    end

    local Value1
    local Table3 = { 124, 123, 4, 100, 26, 113, 17 }
    Value1 = nil

    for Key, Value in Table3, nil, nil do
        Table3[ Key ] = string.char( ( bit32.bxor( Value, 41 ) ) )
    end

    local Parent = Instance.new( "ScreenGui" )
    Parent.Name = "Focus"
    Parent.ResetOnSpawn = false
    Parent.IgnoreGuiInset = true
    Parent.DisplayOrder = 1000000001
    local TextLabel = Instance.new( "TextLabel" )
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromScale( 0.008, 0.07 )
    TextLabel.Size = UDim2.fromScale( 0.6, 0.024 )
    TextLabel.Font = Enum.Font.Code
    TextLabel.TextScaled = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextColor3 = Color3.fromRGB( 255, 235, 120 )
    TextLabel.TextStrokeTransparency = 0.3
    TextLabel.AutoLocalize = false
    local Concat = table.concat( Table3 )
    local Text = tostring( game.PlaceId )
    TextLabel.Text = Concat .. "  " .. Text .. "  " .. os.date( "!%d/%m/%Y %H:%M" )
    TextLabel.Parent = Parent
    local Parent2 = LocalPlayer:WaitForChild( "PlayerGui", 10 )

    if Parent2 then
        Parent.Parent = Parent2
        task.delay( 60, Parent.Destroy, Parent )
        return
    end
    return
end )
return Table2
