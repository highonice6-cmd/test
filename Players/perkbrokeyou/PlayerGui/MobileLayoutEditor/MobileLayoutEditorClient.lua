-- Players.perkbrokeyou.PlayerGui.MobileLayoutEditor.MobileLayoutEditorClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local T
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local UserInputService = game:GetService( "UserInputService" )
local Controls = ReplicatedStorage:WaitForChild( "Controls" )
local Controls2 = require( Controls )
local Spec = require( Controls:WaitForChild( "Spec" ) )
local MobileLayout = require( Controls:WaitForChild( "MobileLayout" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Parent = script.Parent
Parent.Enabled = false
local Catcher = Parent:WaitForChild( "Catcher" )
local Outlines = Parent:WaitForChild( "Outlines" )
local Templates = Parent:WaitForChild( "Templates" )
Templates.Visible = false
local Outline = Templates:WaitForChild( "Outline" )
local Bar = Parent:WaitForChild( "Bar" )
Bar.Active = true

local function Part( Name )
    return Bar:FindFirstChild( Name, true )
end

local Table = {
    Foot = Bar:FindFirstChild( "Page_Foot", true ),
    Car = Bar:FindFirstChild( "Page_Car", true )
}
local Hint = Bar:FindFirstChild( "Hint", true )
local Selected = Bar:FindFirstChild( "Selected", true )
local TouchLayout = Spec.TouchLayout
local Table2 = {
    {
        key = "s",
        row = Bar:FindFirstChild( "SizeRow", true ),
        min = TouchLayout.size[ 1 ],
        max = TouchLayout.size[ 2 ]
    },
    {
        key = "o",
        row = Bar:FindFirstChild( "OpacityRow", true ),
        min = TouchLayout.opacity[ 1 ],
        max = TouchLayout.opacity[ 2 ]
    }
}
local ModeRow = Bar:FindFirstChild( "ModeRow", true )
local Table3 = { }
T = if ModeRow then ModeRow:FindFirstChild( "Tap" ) else ModeRow
local H
Table3.t = T
H = if ModeRow then ModeRow:FindFirstChild( "Hold" ) else ModeRow
local Value5
Table3.h = H
local Touch = Enum.UserInputType.Touch
local MouseButton1 = Enum.UserInputType.MouseButton1
local MouseMovement = Enum.UserInputType.MouseMovement
local Table4 = { Bar.AnchorPoint, Bar.Position }
local Table5 = {
    Vector2.new( Bar.AnchorPoint.X, 1 - Bar.AnchorPoint.Y ),
    UDim2.new( Bar.Position.X.Scale, Bar.Position.X.Offset, 1 - Bar.Position.Y.Scale, -Bar.Position.Y.Offset )
}
local Flag = false
local Table6 = { }
local Text = "Foot"
local Value1 = nil
local Value2 = nil
local Value3 = nil
local Table7 = { }
local Value4 = nil

local function SetState( Object, Enabled, Name, Name2 )
    if not Object then
        return
    end

    local FoundChild = Object:FindFirstChild( Name )
    local FoundChild2 = Object:FindFirstChild( Name2 )

    if FoundChild then
        FoundChild.Enabled = Enabled
    end
    if FoundChild2 then
        FoundChild2.Enabled = not Enabled
    end
end

local function SetText( Object, Text )
    if not Object then
        return
    end

    local Text2

    if Object:IsA( "TextLabel" ) or Object:IsA( "TextButton" ) then
        if Object then
            Text2 = Object
        else
            Text2 = Object:FindFirstChild( "Text" )
        end
    else
        Text2 = Object:FindFirstChild( "Text" )
    end
    if Text2 then
        Text2.Text = Text
    end
end

local function Value( List, Key )
    local Entry = List and Table6[ List.key ] and ( List and Table6[ List.key ] )[ Key ] or 1
    return Entry
end

local function Pos( Argument1 )
    return Vector2.new( Argument1.Position.X, Argument1.Position.Y )
end

local function Ended( Argument1 )
    local Flag
    local UserInputState = Argument1.UserInputState

    if UserInputState == Enum.UserInputState.End then
        Flag = true
    elseif UserInputState == Enum.UserInputState.Cancel then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function OverBar( Argument1 )
    if not Bar.Visible then
        return false
    end

    local Flag
    local AbsolutePosition = Bar.AbsolutePosition
    local AbsoluteSize = Bar.AbsoluteSize
    local X = Argument1.X

    if AbsolutePosition.X <= X then
        local Y = Argument1.Y

        if AbsolutePosition.Y <= Y then
            if Argument1.X <= AbsolutePosition.X + AbsoluteSize.X then
                if Argument1.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
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

local function RefreshBar()
    local Value1Inner = nil

    for Key, Value in Table, nil, nil do
        local Enabled2 = Key == Text and true or false

        if Value then
            local Selected2 = Value:FindFirstChild( "Selected" )
            local Normal2 = Value:FindFirstChild( "Normal" )

            if Selected2 then
                Selected2.Enabled = Enabled2
            end
            if Normal2 then
                Normal2.Enabled = not Enabled2
            end
        end
    end
    if Hint then
        local Visible = Value1 == nil and true or false
        Hint.Visible = Visible
    end
    if Selected then
        local Visible2 = Value1 ~= nil and true or false
        local Text2
        Selected.Visible = Visible2

        if Value1 then
            local Upper = Value1.button.Name:upper( )

            if Upper then
                Text2 = Upper
            else
                Text2 = ""
            end
        else
            Text2 = ""
        end
        if Selected then
            local TextInner

            if Selected:IsA( "TextLabel" ) or Selected:IsA( "TextButton" ) then
                if Selected then
                    TextInner = Selected
                else
                    TextInner = Selected:FindFirstChild( "Text" )
                end
            else
                TextInner = Selected:FindFirstChild( "Text" )
            end
            if TextInner then
                TextInner.Text = Text2
            end
        end
    end

    local Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        local Row = Value3.row

        if Row then
            local Visible4 = Value1 ~= nil and true or false
            Row.Visible = Visible4

            if Value1 then
                local Key4 = Value3.key
                local Entry = Value1 and Table6[ Value1.key ] and ( Value1 and Table6[ Value1.key ] )[ Key4 ] or 1
                local Fill
                local Clamp = math.clamp( ( Entry - Value3.min ) / ( Value3.max - Value3.min ), 0, 1 )
                local Track = Value3.track

                if Track then
                    Fill = Track:FindFirstChild( "Fill" )
                else
                    Fill = Track
                end

                local Knob

                if Track then
                    Knob = Track:FindFirstChild( "Knob" )
                else
                    Knob = Track
                end
                if Fill then
                    Fill.Size = UDim2.new( Clamp, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset )
                end
                if Knob then
                    Knob.Position = UDim2.new( Clamp, 0, Knob.Position.Y.Scale, Knob.Position.Y.Offset )
                end

                local Value6 = Row:FindFirstChild( "Value", true )
                local Text3 = math.round( Entry * 100 ) .. "%"

                if Value6 then
                    local Text4

                    if Value6:IsA( "TextLabel" ) or Value6:IsA( "TextButton" ) then
                        if Value6 then
                            Text4 = Value6
                        else
                            Text4 = Value6:FindFirstChild( "Text" )
                        end
                    else
                        Text4 = Value6:FindFirstChild( "Text" )
                    end
                    if Text4 then
                        Text4.Text = Text3
                    end
                end
            end
        end
    end

    local Mode

    if Value1 then
        Mode = MobileLayout.Mode( Value1.button, Table6 )
    else
        Mode = Value1
    end
    if ModeRow then
        local Visible3 = Mode ~= nil and true or false
        ModeRow.Visible = Visible3
    end

    local Value4 = nil

    for Key3, Value5 in Table3, nil, nil do
        local Enabled = Key3 == Mode and true or false

        if Value5 then
            local SelectedInner = Value5:FindFirstChild( "Selected" )
            local Normal = Value5:FindFirstChild( "Normal" )

            if SelectedInner then
                SelectedInner.Enabled = Enabled
            end
            if Normal then
                Normal.Enabled = not Enabled
            end
        end
    end
end

local function PlaceBar()
    local Flag

    if Value1 then
        local Y = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

        if Parent.AbsoluteSize.Y / 2 < Y then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = true
    end

    local Captured = Flag and Table4 or Table5
    local AnchorPoint = Captured[ 1 ]
    local Position = Captured[ 2 ]
    Bar.AnchorPoint = AnchorPoint
    Bar.Position = Position
    Bar.Visible = not ( Value2 and Value2.moved )
end

local function Select( Argument1 )
    local Flag
    Value1 = Argument1
    RefreshBar( )

    if Value1 then
        local Y = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

        if Parent.AbsoluteSize.Y / 2 < Y then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = true
    end

    local Captured = Flag and Table4 or Table5
    local AnchorPoint = Captured[ 1 ]
    local Position = Captured[ 2 ]
    Bar.AnchorPoint = AnchorPoint
    Bar.Position = Position
    Bar.Visible = not ( Value2 and Value2.moved )
end

local function SetPage( Editing )
    local Flag
    Text = Editing
    MobileLayout.Editing = Editing
    Value1 = nil
    RefreshBar( )

    if Value1 then
        local Y = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

        if Parent.AbsoluteSize.Y / 2 < Y then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = true
    end

    local Captured = Flag and Table4 or Table5
    local AnchorPoint = Captured[ 1 ]
    local Position = Captured[ 2 ]
    Bar.AnchorPoint = AnchorPoint
    Bar.Position = Position
    Bar.Visible = not ( Value2 and Value2.moved )
end

local function SyncOutlines()
    ClientState.CursorFree = true
    local AbsolutePosition = Outlines.AbsolutePosition
    local AbsoluteSize = Outlines.AbsoluteSize

    if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
        return
    end
    for Key, Value in MobileLayout.Entries( ) do
        local Entry2
        local Entry = Table7[ Value ]

        if Entry then
            Entry2 = Entry
        else
            local Clone = Outline:Clone( )
            Clone.AnchorPoint = Vector2.zero
            local UIAspectRatioConstraint = Clone:FindFirstChildOfClass( "UIAspectRatioConstraint" )

            if UIAspectRatioConstraint then
                UIAspectRatioConstraint:Destroy( )
            end

            local UICorner = Value.button:FindFirstChildOfClass( "UICorner" )
            local UICorner2 = Clone:FindFirstChildOfClass( "UICorner" )

            if UICorner2 then
                if UICorner then
                    UICorner2.CornerRadius = UICorner.CornerRadius
                else
                    UICorner2:Destroy( )
                end
            end

            Clone.Parent = Outlines
            Table7[ Value ] = Clone
            Entry2 = Clone
        end

        local Visible
        local Button = Value.button
        local OnPage = MobileLayout.OnPage( Value.group, Text )

        if OnPage then
            Visible = MobileLayout.Usable( Button )
        else
            Visible = OnPage
        end

        Entry2.Visible = Visible

        if Visible then
            local Enabled
            Entry2.Position = UDim2.fromScale( ( Button.AbsolutePosition.X - AbsolutePosition.X ) / AbsoluteSize.X, ( Button.AbsolutePosition.Y - AbsolutePosition.Y ) / AbsoluteSize.Y )
            Entry2.Size = UDim2.fromScale( Button.AbsoluteSize.X / AbsoluteSize.X, Button.AbsoluteSize.Y / AbsoluteSize.Y )
            Enabled = Value == Value1 and true or false

            if Entry2 then
                local Selected = Entry2:FindFirstChild( "Selected" )
                local Normal = Entry2:FindFirstChild( "Normal" )

                if Selected then
                    Selected.Enabled = Enabled
                end
                if Normal then
                    Normal.Enabled = not Enabled
                end
            end
        end
    end
end

local function HitTest( Argument1 )
    local Value1, Number
    Value1 = nil
    Number = math.huge

    for Key, Value in MobileLayout.Entries( ) do
        if MobileLayout.OnPage( Value.group, Text ) and MobileLayout.Usable( Value.button ) then
            local AbsolutePosition = Value.button.AbsolutePosition
            local AbsoluteSize = Value.button.AbsoluteSize
            local X = Argument1.X

            if AbsolutePosition.X <= X and AbsolutePosition.Y <= Argument1.Y and Argument1.X <= AbsolutePosition.X + AbsoluteSize.X and Argument1.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                local Magnitude = ( Argument1 - ( AbsolutePosition + AbsoluteSize / 2 ) ).Magnitude

                if Magnitude < Number then
                    Value1 = Value
                    Number = Magnitude
                end
            end
        end
    end

    return Value1
end

local function SetSlider( Argument1, Argument2 )
    if not Value1 then
        return
    end

    local Entry2
    local Entry = Table6[ Value1.key ]
    Entry2 = if Entry then Entry else { }
    local Flag
    local Key = Argument1.key
    local Round = math.round( Argument2 / TouchLayout.step ) * TouchLayout.step
    local Min = Argument1.min
    Entry2[ Key ] = math.clamp( Round, Min, Argument1.max )
    Table6[ Value1.key ] = Entry2
    MobileLayout.Apply( Table6 )
    RefreshBar( )

    if Value1 then
        local Y = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

        if Parent.AbsoluteSize.Y / 2 < Y then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = true
    end

    local Captured = Flag and Table4 or Table5
    local AnchorPoint = Captured[ 1 ]
    local Position = Captured[ 2 ]
    Bar.AnchorPoint = AnchorPoint
    Bar.Position = Position
    Bar.Visible = not ( Value2 and Value2.moved )
end

local function SlideTo( Argument1, Argument2 )
    local X2
    local Track = Argument1.track

    if Track then
        local X = Track.AbsoluteSize.X

        if X then
            X2 = X
        else
            X2 = 0
        end
    else
        X2 = 0
    end
    if X2 <= 0 then
        return
    end
    SetSlider( Argument1, Argument1.min + math.clamp( ( Argument2 - Track.AbsolutePosition.X ) / X2, 0, 1 ) * ( Argument1.max - Argument1.min ) )
    return
end

Value5 = nil

for Key, Value6 in Table2, nil, nil do
    local Row = Value6.row

    if Row then
        Value6.track = Row:FindFirstChild( "Track", true )

        if Value6.track then
            Value6.track.InputBegan:Connect( function( Argument1 )
                local UserInputType = Argument1.UserInputType

                if Flag and Value1 then
                    if UserInputType == Touch or UserInputType == MouseButton1 then
                        local X3
                        Value3 = { input = Argument1, slider = Value6 }
                        local X = Argument1.Position.X
                        local Track = Value6.track

                        if Track then
                            local X2 = Track.AbsoluteSize.X

                            if X2 then
                                X3 = X2
                            else
                                X3 = 0
                            end
                        else
                            X3 = 0
                        end
                        if X3 <= 0 then
                            return
                        end

                        SetSlider( Value6, Value6.min + math.clamp( ( X - Track.AbsolutePosition.X ) / X3, 0, 1 ) * ( Value6.max - Value6.min ) )
                    end
                end
            end )
        end

        local Minus = Row:FindFirstChild( "Minus", true )
        local Plus = Row:FindFirstChild( "Plus", true )

        if Minus then
            Minus.Activated:Connect( function()
                local Key = Value6.key
                local Entry = Value1 and Table6[ Value1.key ] and ( Value1 and Table6[ Value1.key ] )[ Key ] or 1
                SetSlider( Value6, Entry - TouchLayout.step )
            end )
        end
        if Plus then
            Plus.Activated:Connect( function()
                local Key = Value6.key
                local Entry = Value1 and Table6[ Value1.key ] and ( Value1 and Table6[ Value1.key ] )[ Key ] or 1
                SetSlider( Value6, Entry + TouchLayout.step )
            end )
        end
    end
end

local Value7 = nil

for Key2, Value8 in Table3, nil, nil do
    Value8.Activated:Connect( function()
        if not Flag or not Value1 or not MobileLayout.DefaultMode( Value1.button ) then
            return
        end

        local Entry2
        local Entry = Table6[ Value1.key ]
        Entry2 = if Entry then Entry else { }
        local M = Key2 ~= MobileLayout.DefaultMode( Value1.button ) and Key2 or nil
        Entry2.m = M
        Table6[ Value1.key ] = Entry2
        RefreshBar( )
    end )
end

local Value9
Catcher.InputBegan:Connect( function( Argument1 )
    local UserInputType = Argument1.UserInputType

    if Flag then
        if UserInputType == Touch or UserInputType == MouseButton1 then
            if Value2 then
                local FlagInner
                local UserInputState = Value2.input.UserInputState

                if UserInputState == Enum.UserInputState.End then
                    FlagInner = true
                elseif UserInputState == Enum.UserInputState.Cancel then
                    FlagInner = true
                else
                    FlagInner = false
                end
                if not FlagInner then
                    return
                end
            end

            local Flag2
            local Vector22 = Vector2.new( Argument1.Position.X, Argument1.Position.Y )

            if Bar.Visible then
                local AbsolutePosition = Bar.AbsolutePosition
                local AbsoluteSize = Bar.AbsoluteSize
                local X = Vector22.X

                if AbsolutePosition.X <= X then
                    local Y = Vector22.Y

                    if AbsolutePosition.Y <= Y then
                        if Vector22.X <= AbsolutePosition.X + AbsoluteSize.X then
                            if Vector22.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
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
            else
                Flag2 = false
            end
            if Flag2 then
                return
            end

            local Table2
            local HitTest2 = HitTest( Vector22 )

            if HitTest2 then
                local Table = {
                    input = Argument1,
                    entry = HitTest2,
                    start = Vector22,
                    grab = Vector22 - MobileLayout.Center( HitTest2 ),
                    moved = false
                }

                if Table then
                    Table2 = Table
                else
                    Table2 = nil
                end
            else
                Table2 = nil
            end

            local Flag3
            Value2 = Table2
            Value1 = HitTest2
            RefreshBar( )

            if Value1 then
                local Y2 = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

                if Parent.AbsoluteSize.Y / 2 < Y2 then
                    Flag3 = true
                else
                    Flag3 = false
                end
            else
                Flag3 = true
            end

            local Captured = Flag3 and Table4 or Table5
            local AnchorPoint = Captured[ 1 ]
            local Position = Captured[ 2 ]
            Bar.AnchorPoint = AnchorPoint
            Bar.Position = Position
            Bar.Visible = not ( Value2 and Value2.moved )
            return
        end
    end
end )
UserInputService.InputChanged:Connect( function( p1 )
    -- Could not structure function #20
end )
UserInputService.InputEnded:Connect( function( p1 )
    -- Could not structure function #21
end )

local function Close( Argument1 )
    if not Flag then
        return
    end

    Flag = false
    Value2 = nil
    Value3 = nil

    if Value4 then
        Value4:Disconnect( )
        Value4 = nil
    end

    Parent.Enabled = false
    MobileLayout.Editing = nil
    ClientState.CursorFree = false

    if Argument1 then
        MobileLayout.TakeAimMode( Table6 )
        Controls2.Set( "MobileLayout", Table6 )
    end

    MobileLayout.Apply( Controls2.Settings.MobileLayout )
    MobileLayout.EditorDone( )
end

local function Open()
    if Flag or not MobileLayout.Ready( ) then
        return
    end

    local MobileLayout2
    Flag = true
    Table6 = { }
    local MobileLayoutInner = Controls2.Settings.MobileLayout
    MobileLayout2 = if MobileLayoutInner then MobileLayoutInner else { }
    local Value1Inner = nil

    for Key, Value in MobileLayout2, nil, nil do
        Table6[ Key ] = table.clone( Value )
    end

    local Editing
    Value2 = nil
    Value3 = nil
    Editing = not ClientState.Vehicle and "Foot" or "Car"
    local FlagInner
    Text = Editing
    MobileLayout.Editing = Editing
    Value1 = nil
    RefreshBar( )

    if Value1 then
        local Y = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

        if Parent.AbsoluteSize.Y / 2 < Y then
            FlagInner = true
        else
            FlagInner = false
        end
    else
        FlagInner = true
    end

    local Captured = FlagInner and Table4 or Table5
    local AnchorPoint = Captured[ 1 ]
    local Position = Captured[ 2 ]
    Bar.AnchorPoint = AnchorPoint
    Bar.Position = Position
    Bar.Visible = not ( Value2 and Value2.moved )
    MobileLayout.Apply( Table6 )
    Parent.Enabled = true
    SyncOutlines( )
    Value4 = RunService.RenderStepped:Connect( SyncOutlines )
end

MobileLayout.OpenRequested:Connect( Open )
Value9 = nil

for Key3, Value10 in Table, nil, nil do
    Value10.Activated:Connect( function()
        if Flag then
            local FlagInner
            Text = Key3
            MobileLayout.Editing = Key3
            Value1 = nil
            RefreshBar( )

            if Value1 then
                local Y = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

                if Parent.AbsoluteSize.Y / 2 < Y then
                    FlagInner = true
                else
                    FlagInner = false
                end
            else
                FlagInner = true
            end

            local Captured = FlagInner and Table4 or Table5
            local AnchorPoint = Captured[ 1 ]
            local Position = Captured[ 2 ]
            Bar.AnchorPoint = AnchorPoint
            Bar.Position = Position
            Bar.Visible = not ( Value2 and Value2.moved )
        end
    end )
end

local Reset = Bar:FindFirstChild( "Reset", true )
local Cancel = Bar:FindFirstChild( "Cancel", true )
local Save = Bar:FindFirstChild( "Save", true )

if Reset then
    Reset.Activated:Connect( function()
        if not Flag then
            return
        end

        local FlagInner
        Table6 = { }
        MobileLayout.Apply( Table6 )
        Value1 = nil
        RefreshBar( )

        if Value1 then
            local Y = MobileLayout.Center( Value1 ).Y - Parent.AbsolutePosition.Y

            if Parent.AbsoluteSize.Y / 2 < Y then
                FlagInner = true
            else
                FlagInner = false
            end
        else
            FlagInner = true
        end

        local Captured = FlagInner and Table4 or Table5
        local AnchorPoint = Captured[ 1 ]
        local Position = Captured[ 2 ]
        Bar.AnchorPoint = AnchorPoint
        Bar.Position = Position
        Bar.Visible = not ( Value2 and Value2.moved )
    end )
end
if Cancel then
    Cancel.Activated:Connect( function()
        if not Flag then
            return
        end

        Flag = false
        Value2 = nil
        Value3 = nil

        if Value4 then
            Value4:Disconnect( )
            Value4 = nil
        end

        Parent.Enabled = false
        MobileLayout.Editing = nil
        ClientState.CursorFree = false
        MobileLayout.Apply( Controls2.Settings.MobileLayout )
        MobileLayout.EditorDone( )
    end )
end
if Save then
    Save.Activated:Connect( function()
        Close( true )
    end )
end
