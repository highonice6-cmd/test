-- StarterPlayer.StarterPlayerScripts.SettingsMenuClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #96

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local FoundChild = Self:FindFirstChild( Name )
local FoundChild2 = Self:FindFirstChild( Name2 )

if FoundChild then
    FoundChild.Enabled = Enabled
end
if FoundChild2 then
    FoundChild2.Enabled = not Enabled
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Selected = Self:FindFirstChild( "Selected" )
local Normal = Self:FindFirstChild( "Normal" )

if Selected then
    Selected.Enabled = Enabled
end
if Normal then
    Normal.Enabled = not Enabled
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

return Object:FindFirstChild( "Text" )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Text2

if Object then
    if Object:IsA( "TextLabel" ) or Object:IsA( "TextButton" ) or Object:IsA( "TextBox" ) then
        if Object then
            Text2 = Object
        elseif Object then
            Text2 = Object:FindFirstChild( "Text" )
        else
            Text2 = Object
        end
    elseif Object then
        Text2 = Object:FindFirstChild( "Text" )
    else
        Text2 = Object
    end
elseif Object then
    Text2 = Object:FindFirstChild( "Text" )
else
    Text2 = Object
end
if Text2 then
    Text2.Text = Text
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]

if Entry.kind ~= "bool" then
    if Entry.percent then
        return math.round( Amount * 100 ) .. "%"
    end

    local Format

    if Amount % 1 == 0 then
        local Text = tostring( Amount )

        if Text then
            Format = Text
        else
            Format = string.format( "%.1f", Amount )
        end
    else
        Format = string.format( "%.1f", Amount )
    end

    return Format .. ( Entry.unit or "" )
end
if Amount then
    return "ON"
end
return "OFF"
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Object:GetDescendants( ) do
    if Value:IsA( "GuiObject" ) then
        if Value.Name:sub( 1, 4 ) == "Row_" then
            return Value.Parent
        end
    end
end

local ScrollingFrame2

if not Object:IsA( "ScrollingFrame" ) or not Object then
    local ScrollingFrame = Object:FindFirstChildWhichIsA( "ScrollingFrame", true )

    if ScrollingFrame then
        ScrollingFrame2 = ScrollingFrame
    else
        ScrollingFrame2 = Object
    end
else
    ScrollingFrame2 = Object
end

return ScrollingFrame2
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Parent2
local Clone = Upvalue1[ Name ]:Clone( )
Clone.LayoutOrder = LayoutOrder
Clone.Visible = true

if Name ~= "Preview" or not Parent then
    Parent2 = Upvalue2( Parent )
else
    Parent2 = Parent
end

Clone.Parent = Parent2
return Clone
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 and not Upvalue1[ Upvalue2 ] then
    Upvalue1[ Upvalue2 ] = Argument1
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue3 )

if Upvalue2 == "HitSound" then
    Upvalue4.SetHitmarker( Upvalue3 )
    Upvalue4.Play( "Marker" )
end
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Enabled = Upvalue2.Settings[ Upvalue3 ] == Upvalue4.options[ Key ] and true or false
    local Selected = Value:FindFirstChild( "Selected" )
    local Normal = Value:FindFirstChild( "Normal" )

    if Selected then
        Selected.Enabled = Enabled
    end
    if Normal then
        Normal.Enabled = not Enabled
    end
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue3 )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2.Text
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Text ~= Upvalue2 then
    Upvalue3.Set( Upvalue4, Upvalue1.Text )
end

Upvalue2 = nil
Upvalue5[ Upvalue4 ]( )
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Entry = Upvalue1.Settings[ Upvalue2 ]
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    local Enabled = Key == Entry and true or false
    local Selected = Value:FindFirstChild( "Selected" )
    local Normal = Value:FindFirstChild( "Normal" )

    if Selected then
        Selected.Enabled = Enabled
    end
    if Normal then
        Normal.Enabled = not Enabled
    end

    local UIScale = Value:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        local Scale

        if Enabled then
            local PickedScale = Value:GetAttribute( "PickedScale" )

            if PickedScale then
                Scale = PickedScale
            else
                Scale = 1.15
            end
        else
            Scale = 1
        end

        UIScale.Scale = Scale
    end
end
if Upvalue4 and not Upvalue4:IsFocused( ) then
    Upvalue4.Text = "#" .. Entry
end
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, not Upvalue1.Settings[ Upvalue2 ] )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Enabled = Upvalue1.Settings[ Upvalue2 ]

if Upvalue3 then
    local Text2
    local Text = Upvalue4( Upvalue2, Enabled )

    if Upvalue3 then
        if Upvalue3:IsA( "TextLabel" ) or Upvalue3:IsA( "TextButton" ) or Upvalue3:IsA( "TextBox" ) then
            if Upvalue3 then
                Text2 = Upvalue3
            elseif Upvalue3 then
                Text2 = Upvalue3:FindFirstChild( "Text" )
            else
                Text2 = Upvalue3
            end
        elseif Upvalue3 then
            Text2 = Upvalue3:FindFirstChild( "Text" )
        else
            Text2 = Upvalue3
        end
    elseif Upvalue3 then
        Text2 = Upvalue3:FindFirstChild( "Text" )
    else
        Text2 = Upvalue3
    end
    if Text2 then
        Text2.Text = Text
    end

    local On = Upvalue3:FindFirstChild( "On" )
    local Off = Upvalue3:FindFirstChild( "Off" )

    if On then
        On.Enabled = Enabled
    end
    if Off then
        Off.Enabled = not Enabled
    end
end
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Upvalue1.AbsoluteSize.X

if X <= 0 then
    return
end
local Clamp = math.clamp( ( From - Upvalue1.AbsolutePosition.X ) / X, 0, 1 )
Upvalue2.Set( Upvalue3, Upvalue4.min + Clamp * ( Upvalue4.max - Upvalue4.min ) )
return
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local UserInputType = Argument1.UserInputType

if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch then
    local ScrollingFrame = Upvalue1:FindFirstAncestorWhichIsA( "ScrollingFrame" )
    Upvalue2 = {
        input = Argument1,
        track = Upvalue1,
        set = Upvalue3,
        scroller = ScrollingFrame
    }

    if ScrollingFrame then
        ScrollingFrame.ScrollingEnabled = false
    end

    local X = Argument1.Position.X
    local X2 = Upvalue1.AbsoluteSize.X

    if X2 <= 0 then
        return
    end

    local Clamp = math.clamp( ( X - Upvalue1.AbsolutePosition.X ) / X2, 0, 1 )
    Upvalue4.Set( Upvalue5, Upvalue6.min + Clamp * ( Upvalue6.max - Upvalue6.min ) )
end
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue1.Settings[ Upvalue2 ] - Upvalue3.step )
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue1.Settings[ Upvalue2 ] + Upvalue3.step )
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue1.Settings[ Upvalue2 ] + Argument1 * Upvalue3.step )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1.Settings[ Upvalue2 ]
local Clamp = math.clamp( ( Entry - Upvalue3.min ) / ( Upvalue3.max - Upvalue3.min ), 0, 1 )

if Upvalue4 then
    Upvalue4.Size = UDim2.new( Clamp, 0, Upvalue5.Scale, Upvalue5.Offset )
end
if Upvalue6 then
    Upvalue6.Position = UDim2.new( Clamp, 0, Upvalue7.Scale, Upvalue7.Offset )
end

local Text2
local Text = Upvalue9( Upvalue2, Entry )

if Upvalue8 then
    if Upvalue8:IsA( "TextLabel" ) or Upvalue8:IsA( "TextButton" ) or Upvalue8:IsA( "TextBox" ) then
        if Upvalue8 then
            Text2 = Upvalue8
        elseif Upvalue8 then
            Text2 = Upvalue8:FindFirstChild( "Text" )
        else
            Text2 = Upvalue8
        end
    elseif Upvalue8 then
        Text2 = Upvalue8:FindFirstChild( "Text" )
    else
        Text2 = Upvalue8
    end
elseif Upvalue8 then
    Text2 = Upvalue8:FindFirstChild( "Text" )
else
    Text2 = Upvalue8
end
if Text2 then
    Text2.Text = Text
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue1.Settings[ Upvalue2 ] - Upvalue3.step )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue1.Settings[ Upvalue2 ] + Upvalue3.step )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( Upvalue2, Upvalue1.Settings[ Upvalue2 ] + Argument1 * Upvalue3.step )
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

local Text2
local Text = Upvalue2( Upvalue3, Upvalue4.Settings[ Upvalue3 ] )

if Upvalue1 then
    if Upvalue1:IsA( "TextLabel" ) or Upvalue1:IsA( "TextButton" ) or Upvalue1:IsA( "TextBox" ) then
        if Upvalue1 then
            Text2 = Upvalue1
        elseif Upvalue1 then
            Text2 = Upvalue1:FindFirstChild( "Text" )
        else
            Text2 = Upvalue1
        end
    elseif Upvalue1 then
        Text2 = Upvalue1:FindFirstChild( "Text" )
    else
        Text2 = Upvalue1
    end
elseif Upvalue1 then
    Text2 = Upvalue1:FindFirstChild( "Text" )
else
    Text2 = Upvalue1
end
if Text2 then
    Text2.Text = Text
end
]]

-- Could not structure function #26

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ KeyName ] then
    return Upvalue1[ KeyName ]
end

local Entry2
local Entry = Upvalue2.Actions[ KeyName ]

if Entry then
    local Pad = Entry.pad

    if Pad then
        Entry2 = Entry.pad[ 1 ]
    else
        Entry2 = Pad
    end
else
    Entry2 = Entry
end

return Entry2
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

if not Object2:FindFirstChild( "BindingsTitle", true ) then
    local Text2
    local Clone = Upvalue1.Section:Clone( )
    Clone.LayoutOrder = 100
    Clone.Visible = true
    Clone.Parent = Upvalue2( Object2 )
    Clone.Name = "BindingsTitle"
    local Text = Clone:FindFirstChild( "Text" )

    if Text then
        if Text:IsA( "TextLabel" ) or Text:IsA( "TextButton" ) or Text:IsA( "TextBox" ) then
            if Text then
                Text2 = Text
            elseif Text then
                Text2 = Text:FindFirstChild( "Text" )
            else
                Text2 = Text
            end
        elseif Text then
            Text2 = Text:FindFirstChild( "Text" )
        else
            Text2 = Text
        end
    elseif Text then
        Text2 = Text:FindFirstChild( "Text" )
    else
        Text2 = Text
    end
    if Text2 then
        Text2.Text = "Controller Buttons"
    end
end

local Value1
local Table = { "Move", "Camera" }
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    local Entry = Upvalue4.Actions[ Value ]

    if Entry and Entry.pad then
        table.insert( Table, Value )
    end
end

local Value2 = nil

for Key2, Value3 in Table, nil, nil do
    if not Object2:FindFirstChild( "Binding_" .. Value3, true ) then
        local Text5
        local LayoutOrder = 100 + Key2
        local Clone2 = Upvalue1.Binding:Clone( )
        Clone2.LayoutOrder = LayoutOrder
        Clone2.Visible = true
        Clone2.Parent = Upvalue2( Object2 )
        Clone2.Name = "Binding_" .. Value3
        Clone2:SetAttribute( "Action", Value3 )
        local Text3 = Clone2:FindFirstChild( "Text" )
        Text5 = Upvalue5[ Value3 ] and Value3 or Upvalue4.Actions[ Value3 ].label
        local Text4

        if Text3 then
            if Text3:IsA( "TextLabel" ) or Text3:IsA( "TextButton" ) or Text3:IsA( "TextBox" ) then
                if Text3 then
                    Text4 = Text3
                elseif Text3 then
                    Text4 = Text3:FindFirstChild( "Text" )
                else
                    Text4 = Text3
                end
            elseif Text3 then
                Text4 = Text3:FindFirstChild( "Text" )
            else
                Text4 = Text3
            end
        elseif Text3 then
            Text4 = Text3:FindFirstChild( "Text" )
        else
            Text4 = Text3
        end
        if Text4 then
            Text4.Text = Text5
        end
    end
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in SetupName:GetDescendants( ) do
    local Entry
    local Action = Value:GetAttribute( "Action" )

    if Action then
        if Upvalue1[ Action ] then
            Entry = Upvalue1[ Action ]
        else
            local Entry2 = Upvalue2.Actions[ Action ]

            if Entry2 then
                local Pad = Entry2.pad

                if Pad then
                    Entry = Entry2.pad[ 1 ]
                else
                    Entry = Pad
                end
            else
                Entry = Entry2
            end
        end
    else
        Entry = Action
    end
    if Entry then
        local Glyph, Glyph2 = Upvalue2.Glyph( Entry )
        local Glyph3 = Value:FindFirstChild( "Glyph" )
        local GlyphText = Value:FindFirstChild( "GlyphText" )

        if Glyph3 then
            local Visible
            Glyph3.Image = Glyph or ""
            Visible = Glyph ~= nil and true or false
            Glyph3.Visible = Visible
        end
        if GlyphText then
            local Visible2
            GlyphText.Text = Glyph2 or ""
            Visible2 = Glyph == nil and true or false
            GlyphText.Visible = Visible2
        end
    elseif Action and not Upvalue1[ Action ] then
        local Glyph4 = Value:FindFirstChild( "Glyph" )
        local GlyphText2 = Value:FindFirstChild( "GlyphText" )

        if Glyph4 then
            Glyph4.Visible = false
        end
        if GlyphText2 then
            GlyphText2.Text = "-"
            GlyphText2.Visible = true
        end
    end
end
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value( )
end
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.token == Upvalue2 then
    local Label = Upvalue1.label
    Label.Text = Upvalue1.base
end
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]

if not Entry or not Entry.label or not Text then
    return
end
Entry.token = ( Entry.token or 0 ) + 1
local Token = Entry.token
Entry.label.Text = Text
task.delay( 3, function()
    if Entry.token == Token then
        local Label = Entry.label
        Label.Text = Entry.base
    end
end )
return
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

Upvalue1 = nil
Upvalue2.Capturing = false
Upvalue2.CaptureEndedAt = os.clock( )
Upvalue3:UnbindAction( "SettingsKeyCapture" )

if Upvalue4 then
    Upvalue4.Visible = false
end

local Value1 = nil

for Key, Value in Upvalue5, nil, nil do
    Value( )
end
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local SetBind = Upvalue2.SetBind
local Dev = Upvalue1.dev
local Action = Upvalue1.action
local SetBind2, SetBind22 = SetBind( Dev, Action, Upvalue1.slot, Argument1 )

if not SetBind2 then
    Upvalue3( Upvalue1.dev, SetBind22 or "This key can't be used for that" )
    return
end
if Upvalue1 then
    Upvalue1 = nil
    Upvalue2.Capturing = false
    Upvalue2.CaptureEndedAt = os.clock( )
    Upvalue4:UnbindAction( "SettingsKeyCapture" )

    if Upvalue5 then
        Upvalue5.Visible = false
    end

    local Value1 = nil

    for Key, Value in Upvalue6, nil, nil do
        Value( )
    end
end
if SetBind22 then
    Upvalue3( Upvalue1.dev, SetBind22 )
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 == Enum.UserInputState.Begin and Upvalue1 == Upvalue2 and os.clock( ) - Upvalue2.t0 > 0.15 then
    local KeyCode = Argument3.KeyCode

    if Upvalue3 ~= "kbm" or Argument3.UserInputType ~= Enum.UserInputType.Keyboard then
        if Upvalue3 == "pad" and Upvalue4.IsPadKey( KeyCode ) and KeyCode.Name:sub( 1, 10 ) ~= "Thumbstick" then
            local Name2 = KeyCode.Name

            if Upvalue1 then
                local SetBind3 = Upvalue4.SetBind
                local Dev2 = Upvalue1.dev
                local Action2 = Upvalue1.action
                local SetBind4, SetBind23 = SetBind3( Dev2, Action2, Upvalue1.slot, Name2 )

                if SetBind4 then
                    if Upvalue1 then
                        Upvalue1 = nil
                        Upvalue4.Capturing = false
                        Upvalue4.CaptureEndedAt = os.clock( )
                        Upvalue5:UnbindAction( "SettingsKeyCapture" )

                        if Upvalue6 then
                            Upvalue6.Visible = false
                        end

                        local Value4 = nil

                        for Key3, Value5 in Upvalue7, nil, nil do
                            Value5( )
                        end
                    end
                    if SetBind23 then
                        Upvalue8( Upvalue1.dev, SetBind23 )
                    end
                else
                    Upvalue8( Upvalue1.dev, SetBind23 or "This key can't be used for that" )
                end
            end
        end
    elseif KeyCode == Enum.KeyCode.Escape then
        if Upvalue1 then
            Upvalue1 = nil
            Upvalue4.Capturing = false
            Upvalue4.CaptureEndedAt = os.clock( )
            Upvalue5:UnbindAction( "SettingsKeyCapture" )

            if Upvalue6 then
                Upvalue6.Visible = false
            end

            local Value1 = nil

            for Key, Value in Upvalue7, nil, nil do
                Value( )
            end
        end
    elseif KeyCode == Enum.KeyCode.Unknown or KeyCode == Enum.KeyCode.None then
        Upvalue8( Upvalue3, "Roblox can't read that button: set it to a key in your mouse software" )
    else
        local Name = KeyCode.Name

        if Upvalue1 then
            local SetBind = Upvalue4.SetBind
            local Dev = Upvalue1.dev
            local Action = Upvalue1.action
            local SetBind2, SetBind22 = SetBind( Dev, Action, Upvalue1.slot, Name )

            if SetBind2 then
                if Upvalue1 then
                    Upvalue1 = nil
                    Upvalue4.Capturing = false
                    Upvalue4.CaptureEndedAt = os.clock( )
                    Upvalue5:UnbindAction( "SettingsKeyCapture" )

                    if Upvalue6 then
                        Upvalue6.Visible = false
                    end

                    local Value2 = nil

                    for Key2, Value3 in Upvalue7, nil, nil do
                        Value3( )
                    end
                end
                if SetBind22 then
                    Upvalue8( Upvalue1.dev, SetBind22 )
                end
            else
                Upvalue8( Upvalue1.dev, SetBind22 or "This key can't be used for that" )
            end
        end
    end
end

return Enum.ContextActionResult.Sink
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    if not Upvalue1 then
        return
    end

    Upvalue1 = nil
    Upvalue3.Capturing = false
    Upvalue3.CaptureEndedAt = os.clock( )
    Upvalue4:UnbindAction( "SettingsKeyCapture" )

    if Upvalue5 then
        Upvalue5.Visible = false
    end

    local Value1 = nil

    for Key, Value in Upvalue6, nil, nil do
        Value( )
    end
end
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil
    Upvalue2.Capturing = false
    Upvalue2.CaptureEndedAt = os.clock( )
    Upvalue3:UnbindAction( "SettingsKeyCapture" )

    if Upvalue4 then
        Upvalue4.Visible = false
    end

    local Value1 = nil

    for Key, Value in Upvalue5, nil, nil do
        Value( )
    end
end

local Value2
local Table = {
    dev = CaptureName,
    action = CaptureName2,
    slot = Argument3,
    t0 = os.clock( )
}
Upvalue1 = Table
Upvalue2.Capturing = true
Value2 = nil

for Key2, Value3 in Upvalue5, nil, nil do
    Value3( )
end
if Upvalue4 then
    local Label2
    Upvalue4.Visible = true

    if Upvalue2.Actions[ CaptureName2 ] then
        local Label = Upvalue2.Actions[ CaptureName2 ].label

        if Label then
            Label2 = Label
        else
            Label2 = CaptureName2
        end
    else
        Label2 = CaptureName2
    end

    local Text

    if CaptureName ~= "kbm" or not ( "Press a key or a mouse button for\n%s\n(Esc to cancel)" ):format( Label2 ) then
        Text = ( "Press a controller button for\n%s" ):format( Label2 )
    else
        Text = ( "Press a key or a mouse button for\n%s\n(Esc to cancel)" ):format( Label2 )
    end

    local Text2

    if Upvalue6 then
        if Upvalue6:IsA( "TextLabel" ) or Upvalue6:IsA( "TextButton" ) or Upvalue6:IsA( "TextBox" ) then
            if Upvalue6 then
                Text2 = Upvalue6
            elseif Upvalue6 then
                Text2 = Upvalue6:FindFirstChild( "Text" )
            else
                Text2 = Upvalue6
            end
        elseif Upvalue6 then
            Text2 = Upvalue6:FindFirstChild( "Text" )
        else
            Text2 = Upvalue6
        end
    elseif Upvalue6 then
        Text2 = Upvalue6:FindFirstChild( "Text" )
    else
        Text2 = Upvalue6
    end
    if Text2 then
        Text2.Text = Text
    end
    if Upvalue7 then
        local Visible = CaptureName == "kbm" and true or false
        Upvalue7.Visible = Visible
    end
end

local Keyboard

local function Callback( Argument1, Argument2, Argument3 )
    if Argument2 == Enum.UserInputState.Begin and Upvalue1 == Table and os.clock( ) - Table.t0 > 0.15 then
        local KeyCode = Argument3.KeyCode

        if CaptureName ~= "kbm" or Argument3.UserInputType ~= Enum.UserInputType.Keyboard then
            if CaptureName == "pad" and Upvalue2.IsPadKey( KeyCode ) and KeyCode.Name:sub( 1, 10 ) ~= "Thumbstick" then
                local Name2 = KeyCode.Name

                if Upvalue1 then
                    local SetBind3 = Upvalue2.SetBind
                    local Dev2 = Upvalue1.dev
                    local Action2 = Upvalue1.action
                    local SetBind4, SetBind23 = SetBind3( Dev2, Action2, Upvalue1.slot, Name2 )

                    if SetBind4 then
                        if Upvalue1 then
                            Upvalue1 = nil
                            Upvalue2.Capturing = false
                            Upvalue2.CaptureEndedAt = os.clock( )
                            Upvalue3:UnbindAction( "SettingsKeyCapture" )

                            if Upvalue4 then
                                Upvalue4.Visible = false
                            end

                            local Value4 = nil

                            for Key3, Value5 in Upvalue5, nil, nil do
                                Value5( )
                            end
                        end
                        if SetBind23 then
                            Upvalue8( Upvalue1.dev, SetBind23 )
                        end
                    else
                        Upvalue8( Upvalue1.dev, SetBind23 or "This key can't be used for that" )
                    end
                end
            end
        elseif KeyCode == Enum.KeyCode.Escape then
            if Upvalue1 then
                Upvalue1 = nil
                Upvalue2.Capturing = false
                Upvalue2.CaptureEndedAt = os.clock( )
                Upvalue3:UnbindAction( "SettingsKeyCapture" )

                if Upvalue4 then
                    Upvalue4.Visible = false
                end

                local Value1 = nil

                for Key, Value in Upvalue5, nil, nil do
                    Value( )
                end
            end
        elseif KeyCode == Enum.KeyCode.Unknown or KeyCode == Enum.KeyCode.None then
            Upvalue8( CaptureName, "Roblox can't read that button: set it to a key in your mouse software" )
        else
            local Name = KeyCode.Name

            if Upvalue1 then
                local SetBind = Upvalue2.SetBind
                local Dev = Upvalue1.dev
                local Action = Upvalue1.action
                local SetBind2, SetBind22 = SetBind( Dev, Action, Upvalue1.slot, Name )

                if SetBind2 then
                    if Upvalue1 then
                        Upvalue1 = nil
                        Upvalue2.Capturing = false
                        Upvalue2.CaptureEndedAt = os.clock( )
                        Upvalue3:UnbindAction( "SettingsKeyCapture" )

                        if Upvalue4 then
                            Upvalue4.Visible = false
                        end

                        local Value2 = nil

                        for Key2, Value3 in Upvalue5, nil, nil do
                            Value3( )
                        end
                    end
                    if SetBind22 then
                        Upvalue8( Upvalue1.dev, SetBind22 )
                    end
                else
                    Upvalue8( Upvalue1.dev, SetBind22 or "This key can't be used for that" )
                end
            end
        end
    end

    return Enum.ContextActionResult.Sink
end

Keyboard = CaptureName == "kbm" and Enum.UserInputType.Keyboard or Enum.UserInputType.Gamepad1
Upvalue3:BindActionAtPriority( "SettingsKeyCapture", Callback, false, 5000, Keyboard )
task.delay( 8, function()
    if Upvalue1 == Table then
        if not Upvalue1 then
            return
        end

        Upvalue1 = nil
        Upvalue2.Capturing = false
        Upvalue2.CaptureEndedAt = os.clock( )
        Upvalue3:UnbindAction( "SettingsKeyCapture" )

        if Upvalue4 then
            Upvalue4.Visible = false
        end

        local Value1 = nil

        for Key, Value in Upvalue5, nil, nil do
            Value( )
        end
    end
end )
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

local UserInputType = Argument1.UserInputType

if Upvalue1 and Upvalue1.dev == "kbm" and os.clock( ) - Upvalue1.t0 > 0.15 then
    if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.MouseButton2 or UserInputType == Enum.UserInputType.MouseButton3 then
        local Name = UserInputType.Name

        if not Upvalue1 then
            return
        end

        local SetBind = Upvalue2.SetBind
        local Dev = Upvalue1.dev
        local Action = Upvalue1.action
        local SetBind2, SetBind22 = SetBind( Dev, Action, Upvalue1.slot, Name )

        if not SetBind2 then
            Upvalue3( Upvalue1.dev, SetBind22 or "This key can't be used for that" )
            return
        end
        if Upvalue1 then
            Upvalue1 = nil
            Upvalue2.Capturing = false
            Upvalue2.CaptureEndedAt = os.clock( )
            Upvalue4:UnbindAction( "SettingsKeyCapture" )

            if Upvalue5 then
                Upvalue5.Visible = false
            end

            local Value1 = nil

            for Key, Value in Upvalue6, nil, nil do
                Value( )
            end
        end
        if SetBind22 then
            Upvalue3( Upvalue1.dev, SetBind22 )
        end
    end
end
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Argument1.KeyCode == Enum.KeyCode.Escape then
    if not Upvalue1 then
        return
    end

    Upvalue1 = nil
    Upvalue2.Capturing = false
    Upvalue2.CaptureEndedAt = os.clock( )
    Upvalue3:UnbindAction( "SettingsKeyCapture" )

    if Upvalue4 then
        Upvalue4.Visible = false
    end

    local Value1 = nil

    for Key, Value in Upvalue5, nil, nil do
        Value( )
    end
end
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( "kbm", Upvalue2, Upvalue3 )
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue2.SetBind( "kbm", Upvalue3, Upvalue4, nil )
return
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Binds = Upvalue1.Binds( "kbm", Upvalue2 )
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    local Enabled

    if Upvalue4 == nil then
        Enabled = false
    elseif Upvalue4.dev == "kbm" then
        if Upvalue4.action == Upvalue2 then
            if Upvalue4.slot == Key then
                Enabled = true
            else
                Enabled = false
            end
        else
            Enabled = false
        end
    else
        Enabled = false
    end

    local Text

    if Enabled then
        Text = "..."
    else
        Text = Upvalue1.KeyName( Binds[ Key ] )
    end

    local Text2

    if Value then
        if Value:IsA( "TextLabel" ) or Value:IsA( "TextButton" ) or Value:IsA( "TextBox" ) then
            if Value then
                Text2 = Value
            elseif Value then
                Text2 = Value:FindFirstChild( "Text" )
            else
                Text2 = Value
            end
        elseif Value then
            Text2 = Value:FindFirstChild( "Text" )
        else
            Text2 = Value
        end
    elseif Value then
        Text2 = Value:FindFirstChild( "Text" )
    else
        Text2 = Value
    end
    if Text2 then
        Text2.Text = Text
    end

    local On = Value:FindFirstChild( "On" )
    local Off = Value:FindFirstChild( "Off" )

    if On then
        On.Enabled = Enabled
    end
    if Off then
        Off.Enabled = not Enabled
    end
end
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

local Selected = Upvalue1:FindFirstChild( "Selected" )
local Normal = Upvalue1:FindFirstChild( "Normal" )

if Selected then
    Selected.Enabled = Enabled
end
if Normal then
    Normal.Enabled = not Enabled
end
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( "pad", Upvalue2, 1 )
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

local Selected = Upvalue1:FindFirstChild( "Selected" )
local Normal = Upvalue1:FindFirstChild( "Normal" )

if Selected then
    Selected.Enabled = true
end
if Normal then
    Normal.Enabled = false
end
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

local Selected = Upvalue1:FindFirstChild( "Selected" )
local Normal = Upvalue1:FindFirstChild( "Normal" )

if Selected then
    Selected.Enabled = false
end
if Normal then
    Normal.Enabled = true
end
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

local Selected = Upvalue1:FindFirstChild( "Selected" )
local Normal = Upvalue1:FindFirstChild( "Normal" )

if Selected then
    Selected.Enabled = true
end
if Normal then
    Normal.Enabled = false
end
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

local Selected = Upvalue1:FindFirstChild( "Selected" )
local Normal = Upvalue1:FindFirstChild( "Normal" )

if Selected then
    Selected.Enabled = false
end
if Normal then
    Normal.Enabled = true
end
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

local FoundChild
Upvalue1( Upvalue2 )

if Upvalue3 == nil then
    FoundChild = false
elseif Upvalue3.dev == "pad" then
    FoundChild = Upvalue2:FindFirstChild( "Binding_" .. Upvalue3.action, true )
else
    FoundChild = false
end
if FoundChild then
    local Glyph = FoundChild:FindFirstChild( "Glyph" )
    local GlyphText = FoundChild:FindFirstChild( "GlyphText" )

    if Glyph then
        Glyph.Visible = false
    end
    if GlyphText then
        GlyphText.Text = "..."
        GlyphText.Visible = true
    end
end
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil
    Upvalue2.Capturing = false
    Upvalue2.CaptureEndedAt = os.clock( )
    Upvalue3:UnbindAction( "SettingsKeyCapture" )

    if Upvalue4 then
        Upvalue4.Visible = false
    end

    local Value1 = nil

    for Key, Value in Upvalue5, nil, nil do
        Value( )
    end
end

local Text
Upvalue2.ResetBinds( Upvalue6 )
Text = Upvalue6 ~= "kbm" and "Default buttons restored" or "Default keys restored"
Upvalue7( Upvalue6, Text )
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1.Rebind[ SetupName2 ]

if not Entry then
    return
end

local Text = SetupName2 ~= "kbm" and "BindingsTitle" or "KeysTitle"
local FoundChild2
local FoundChild = SetupName:FindFirstChild( Text, true )

if FoundChild or SetupName2 ~= "kbm" then
    FoundChild2 = FoundChild
else
    local Text3
    local Clone = Upvalue2.Section:Clone( )
    Clone.LayoutOrder = 0
    Clone.Visible = true
    Clone.Parent = Upvalue3( SetupName )
    Clone.Name = "KeysTitle"
    local Text2 = Clone:FindFirstChild( "Text" )

    if Text2 then
        if Text2:IsA( "TextLabel" ) or Text2:IsA( "TextButton" ) or Text2:IsA( "TextBox" ) then
            if Text2 then
                Text3 = Text2
            elseif Text2 then
                Text3 = Text2:FindFirstChild( "Text" )
            else
                Text3 = Text2
            end
        elseif Text2 then
            Text3 = Text2:FindFirstChild( "Text" )
        else
            Text3 = Text2
        end
    elseif Text2 then
        Text3 = Text2:FindFirstChild( "Text" )
    else
        Text3 = Text2
    end
    if Text3 then
        Text3.Text = "Keyboard & Mouse"
        FoundChild2 = Clone
    else
        FoundChild2 = Clone
    end
end

local Text4

if FoundChild2 then
    Text4 = FoundChild2:FindFirstChild( "Text" )
else
    Text4 = FoundChild2
end

local Base
local Table = { label = Text4 }
Base = if Text4 then Text4.Text else Text4
Table.base = Base
Upvalue4[ SetupName2 ] = Table

if SetupName2 == "kbm" then
    local Value1
    local Actions = Entry.actions
    Value1 = nil

    for Key, Value in Actions, nil, nil do
        local FoundChild4
        local FoundChild3 = SetupName:FindFirstChild( "Key_" .. Value, true )

        if FoundChild3 or not Upvalue2.Row_Key then
            FoundChild4 = FoundChild3
        else
            local Text6
            local Clone2 = Upvalue2.Row_Key:Clone( )
            Clone2.LayoutOrder = Key
            Clone2.Visible = true
            Clone2.Parent = Upvalue3( SetupName )
            Clone2.Name = "Key_" .. Value
            local Entry2 = Upvalue5.Actions[ Value ]
            local Label = ( Clone2:FindFirstChild( "Card" ) or Clone2 ):FindFirstChild( "Label" )
            Text6 = Entry2 and Entry2.label or Value
            local Text5

            if Label then
                if Label:IsA( "TextLabel" ) or Label:IsA( "TextButton" ) or Label:IsA( "TextBox" ) then
                    if Label then
                        Text5 = Label
                    elseif Label then
                        Text5 = Label:FindFirstChild( "Text" )
                    else
                        Text5 = Label
                    end
                elseif Label then
                    Text5 = Label:FindFirstChild( "Text" )
                else
                    Text5 = Label
                end
            elseif Label then
                Text5 = Label:FindFirstChild( "Text" )
            else
                Text5 = Label
            end
            if Text5 then
                Text5.Text = Text6
                FoundChild4 = Clone2
            else
                FoundChild4 = Clone2
            end
        end

        local FoundChild7 = if FoundChild4 then FoundChild4:FindFirstChild( "Card" ) or FoundChild4 else FoundChild4
        local Table2 = { }
        local Max = Entry.max
        local J = 1

        for J = 1, Max do
            local FoundChild6

            if FoundChild7 then
                local FoundChild5 = FoundChild7:FindFirstChild( "Key" .. J )

                if FoundChild5 then
                    FoundChild6 = FoundChild5
                else
                    FoundChild6 = nil
                end
            else
                FoundChild6 = nil
            end

            Table2[ J ] = FoundChild6
        end

        local Value2 = nil

        for Key2, Value3 in Table2, nil, nil do
            Value3.Activated:Connect( function()
                Upvalue6( "kbm", Value, Key2 )
            end )
            Value3.MouseButton2Click:Connect( function()
                if Upvalue7 then
                    return
                end
                Upvalue5.SetBind( "kbm", Value, Key2, nil )
                return
            end )

            if not Upvalue8[ SetupName ] then
                Upvalue8[ SetupName ] = Value3
            end
        end

        table.insert( Upvalue9, function()
            local Value1
            local Binds = Upvalue5.Binds( "kbm", Value )
            Value1 = nil

            for Key, ValueInner in Table2, nil, nil do
                local Enabled

                if Upvalue7 == nil then
                    Enabled = false
                elseif Upvalue7.dev == "kbm" then
                    if Upvalue7.action == Value then
                        if Upvalue7.slot == Key then
                            Enabled = true
                        else
                            Enabled = false
                        end
                    else
                        Enabled = false
                    end
                else
                    Enabled = false
                end

                local Text

                if Enabled then
                    Text = "..."
                else
                    Text = Upvalue5.KeyName( Binds[ Key ] )
                end

                local Text2

                if ValueInner then
                    if ValueInner:IsA( "TextLabel" ) or ValueInner:IsA( "TextButton" ) or ValueInner:IsA( "TextBox" ) then
                        if ValueInner then
                            Text2 = ValueInner
                        elseif ValueInner then
                            Text2 = ValueInner:FindFirstChild( "Text" )
                        else
                            Text2 = ValueInner
                        end
                    elseif ValueInner then
                        Text2 = ValueInner:FindFirstChild( "Text" )
                    else
                        Text2 = ValueInner
                    end
                elseif ValueInner then
                    Text2 = ValueInner:FindFirstChild( "Text" )
                else
                    Text2 = ValueInner
                end
                if Text2 then
                    Text2.Text = Text
                end

                local On = ValueInner:FindFirstChild( "On" )
                local Off = ValueInner:FindFirstChild( "Off" )

                if On then
                    On.Enabled = Enabled
                end
                if Off then
                    Off.Enabled = not Enabled
                end
            end
        end )
    end
else
    local Value4
    local Actions2 = Entry.actions
    Value4 = nil

    for Key3, Value5 in Actions2, nil, nil do
        local Parent = SetupName:FindFirstChild( "Binding_" .. Value5, true )

        if Parent then
            local Rebind2
            local Rebind = Parent:FindFirstChild( "Rebind" )

            if Rebind then
                Rebind2 = Rebind
            else
                local TextButton = Instance.new( "TextButton" )
                TextButton.Name = "Rebind"
                TextButton.Size = UDim2.fromScale( 1, 1 )
                TextButton.BackgroundTransparency = 1
                TextButton.Text = ""
                TextButton.ZIndex = Parent.ZIndex + 5
                TextButton.Parent = Parent
                Rebind2 = TextButton
            end

            local function Hl( Enabled )
                local Selected = Rebind2:FindFirstChild( "Selected" )
                local Normal = Rebind2:FindFirstChild( "Normal" )

                if Selected then
                    Selected.Enabled = Enabled
                end
                if Normal then
                    Normal.Enabled = not Enabled
                end
            end

            Rebind2.Activated:Connect( function()
                Upvalue6( "pad", Value5, 1 )
            end )
            Rebind2.MouseEnter:Connect( function()
                local Selected = Rebind2:FindFirstChild( "Selected" )
                local Normal = Rebind2:FindFirstChild( "Normal" )

                if Selected then
                    Selected.Enabled = true
                end
                if Normal then
                    Normal.Enabled = false
                end
            end )
            Rebind2.MouseLeave:Connect( function()
                local Selected = Rebind2:FindFirstChild( "Selected" )
                local Normal = Rebind2:FindFirstChild( "Normal" )

                if Selected then
                    Selected.Enabled = false
                end
                if Normal then
                    Normal.Enabled = true
                end
            end )
            Rebind2.SelectionGained:Connect( function()
                local Selected = Rebind2:FindFirstChild( "Selected" )
                local Normal = Rebind2:FindFirstChild( "Normal" )

                if Selected then
                    Selected.Enabled = true
                end
                if Normal then
                    Normal.Enabled = false
                end
            end )
            Rebind2.SelectionLost:Connect( function()
                local Selected = Rebind2:FindFirstChild( "Selected" )
                local Normal = Rebind2:FindFirstChild( "Normal" )

                if Selected then
                    Selected.Enabled = false
                end
                if Normal then
                    Normal.Enabled = true
                end
            end )

            if not Upvalue8[ SetupName ] then
                Upvalue8[ SetupName ] = Rebind2
            end
        end
    end

    table.insert( Upvalue9, function()
        local FoundChild
        Upvalue10( SetupName )

        if Upvalue7 == nil then
            FoundChild = false
        elseif Upvalue7.dev == "pad" then
            FoundChild = SetupName:FindFirstChild( "Binding_" .. Upvalue7.action, true )
        else
            FoundChild = false
        end
        if FoundChild then
            local Glyph = FoundChild:FindFirstChild( "Glyph" )
            local GlyphText = FoundChild:FindFirstChild( "GlyphText" )

            if Glyph then
                Glyph.Visible = false
            end
            if GlyphText then
                GlyphText.Text = "..."
                GlyphText.Visible = true
            end
        end
    end )
end

local Text7 = SetupName2 ~= "kbm" and "Pad_Reset" or "Key_Reset"
local Reset
local FoundChild8 = SetupName:FindFirstChild( Text7, true )

if FoundChild8 then
    Reset = ( FoundChild8:FindFirstChild( "Card" ) or FoundChild8 ):FindFirstChild( "Reset" )
else
    Reset = FoundChild8
end
if Reset then
    Reset.Activated:Connect( function()
        if Upvalue7 then
            Upvalue7 = nil
            Upvalue5.Capturing = false
            Upvalue5.CaptureEndedAt = os.clock( )
            Upvalue11:UnbindAction( "SettingsKeyCapture" )

            if Upvalue12 then
                Upvalue12.Visible = false
            end

            local Value1 = nil

            for Key, Value in Upvalue9, nil, nil do
                Value( )
            end
        end

        local Text
        Upvalue5.ResetBinds( SetupName2 )
        Text = SetupName2 ~= "kbm" and "Default buttons restored" or "Default keys restored"
        Upvalue13( SetupName2, Text )
    end )
end

local Value6 = nil

for Key4, Value7 in Upvalue9, nil, nil do
    Value7( )
end
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.TouchEnabled or Upvalue2.TouchMode( ) then
    return true
end

local Captured
local MobileGui = Upvalue3.PlayerGui:FindFirstChild( "MobileGui" )

if Upvalue4 then
    if MobileGui == nil then
        Captured = false
    elseif MobileGui:GetAttribute( "ShowOnPC" ) == true then
        Captured = true
    else
        Captured = false
    end
else
    Captured = Upvalue4
end

return Captured
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

local NotTouch2
local NotTouch = not Argument1.touch

if NotTouch then
    NotTouch2 = NotTouch
else
    if Upvalue1.TouchEnabled or Upvalue2.TouchMode( ) then
        return true
    end

    local MobileGui = Upvalue3.PlayerGui:FindFirstChild( "MobileGui" )

    if Upvalue4 then
        if MobileGui == nil then
            NotTouch2 = false
        elseif MobileGui:GetAttribute( "ShowOnPC" ) == true then
            NotTouch2 = true
        else
            NotTouch2 = false
        end
    else
        NotTouch2 = Upvalue4
    end
end

return NotTouch2
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.OpenEditor( )
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Set( "MobileLayout", { } )
Upvalue2( "touch", "Default layout restored" )
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
local TouchTitle = SetupName:FindFirstChild( "TouchTitle", true )

if TouchTitle then
    Text = TouchTitle:FindFirstChild( "Text" )
else
    Text = TouchTitle
end

local Base
local Touch = { label = Text }
Base = if Text then Text.Text else Text
local Edit
Touch.base = Base
Upvalue1.touch = Touch
local Touch_Edit = SetupName:FindFirstChild( "Touch_Edit", true )

if Touch_Edit then
    Edit = ( Touch_Edit:FindFirstChild( "Card" ) or Touch_Edit ):FindFirstChild( "Edit" )
else
    Edit = Touch_Edit
end
if Edit then
    Edit.Activated:Connect( function()
        Upvalue2.OpenEditor( )
    end )

    if not Upvalue3[ SetupName ] then
        Upvalue3[ SetupName ] = Edit
    end
end

local Reset
local Touch_Reset = SetupName:FindFirstChild( "Touch_Reset", true )

if Touch_Reset then
    Reset = ( Touch_Reset:FindFirstChild( "Card" ) or Touch_Reset ):FindFirstChild( "Reset" )
else
    Reset = Touch_Reset
end
if Reset then
    Reset.Activated:Connect( function()
        Upvalue4.Set( "MobileLayout", { } )
        Upvalue5( "touch", "Default layout restored" )
    end )
end
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

local Visible2 = Upvalue1.Settings.XhMode == "Custom" and true or false
local Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    for Key2, Value2 in Value:GetDescendants( ) do
        local Match
        local IsA = Value2:IsA( "GuiObject" )

        if IsA then
            Match = Value2.Name:match( "^Row_(Xh%w+)$" )
        else
            Match = IsA
        end
        if Match and not Upvalue3[ Match ] then
            Value2.Visible = Visible2
        end
        if Match == "XhHitmarker" then
            local Visible = Upvalue1.Settings.XhHitmarkerOn ~= false and true or false
            Value2.Visible = Visible
        end
    end
end
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Text
Upvalue1.RichText = true
Text = not Argument2 and "e23a42" or "46c86e"
Upvalue1.Text = ( "<font color=\"#%s\">%s</font>" ):format( Text, Argument1 )
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Upvalue2 then
    return
end

local Gsub = Upvalue3.Text:gsub( "^%s+", "" ):gsub( "%s+$", "" )

if Gsub == "" then
    if Upvalue4 then
        Upvalue4.RichText = true
        Upvalue4.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", "Type a code first" )
        return
    end
    return
else
    Upvalue1 = true

    if Upvalue4 then
        Upvalue4.Text = "..."
    end

    local Success, Result = pcall( Upvalue2.InvokeServer, Upvalue2, Gsub )
    Upvalue1 = false

    if Success and type( Result ) == "table" then
        local Msg2
        local Msg = Result.msg

        if Msg then
            Msg2 = Msg
        elseif Result.ok then
            Msg2 = "Code redeemed!"
        else
            Msg2 = "Invalid code"
        end

        local Flag
        local Text = tostring( Msg2 )
        Flag = Result.ok == true and true or false

        if Upvalue4 then
            local Text2
            Upvalue4.RichText = true
            Text2 = not Flag and "e23a42" or "46c86e"
            Upvalue4.Text = ( "<font color=\"#%s\">%s</font>" ):format( Text2, Text )
        end
        if Result.ok then
            Upvalue3.Text = ""
        end

        return
    end
    if Upvalue4 then
        Upvalue4.RichText = true
        Upvalue4.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", "Something went wrong, try again" )
        return
    end
    return
end
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 then
    Upvalue1( )
end
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

local Box = Self:FindFirstChild( "Box", true )
local Redeem = Self:FindFirstChild( "Redeem", true )
local Status = Self:FindFirstChild( "Status", true )

if not Box or not Redeem then
    return
end
local RedeemCode = Upvalue1:WaitForChild( "Remotes" ):WaitForChild( "RedeemCode", 30 )
local Flag = false

local function Say( Argument1, Argument2 )
    if not Status then
        return
    end

    local Text
    Status.RichText = true
    Text = not Argument2 and "e23a42" or "46c86e"
    Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( Text, Argument1 )
end

local function Redeem2()
    if Flag or not RedeemCode then
        return
    end

    local Gsub = Box.Text:gsub( "^%s+", "" ):gsub( "%s+$", "" )

    if Gsub == "" then
        if Status then
            Status.RichText = true
            Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", "Type a code first" )
            return
        end
        return
    else
        Flag = true

        if Status then
            Status.Text = "..."
        end

        local Success, Result = pcall( RedeemCode.InvokeServer, RedeemCode, Gsub )
        Flag = false

        if Success and type( Result ) == "table" then
            local Msg2
            local Msg = Result.msg

            if Msg then
                Msg2 = Msg
            elseif Result.ok then
                Msg2 = "Code redeemed!"
            else
                Msg2 = "Invalid code"
            end

            local FlagInner
            local Text = tostring( Msg2 )
            FlagInner = Result.ok == true and true or false

            if Status then
                local Text2
                Status.RichText = true
                Text2 = not FlagInner and "e23a42" or "46c86e"
                Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( Text2, Text )
            end
            if Result.ok then
                Box.Text = ""
            end

            return
        end
        if Status then
            Status.RichText = true
            Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", "Something went wrong, try again" )
            return
        end
        return
    end
end

Redeem.Activated:Connect( Redeem2 )
Box.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        Redeem2( )
    end
end )
return
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

-- empty function
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    Upvalue3.Text = Upvalue4
end
]]

--[[
Function #64 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Text
Upvalue2 = Upvalue2 + 1
Upvalue1.RichText = true
Text = not Argument2 and "e23a42" or "46c86e"
Upvalue1.Text = ( "<font color=\"#%s\">%s</font>" ):format( Text, Argument1 )
task.delay( Amount or 2, function()
    if Upvalue2 == Upvalue2 then
        Upvalue1.Text = Upvalue3
    end
end )
]]

--[[
Function #65 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1:IsFocused( ) then
    return
end
Upvalue2 = Upvalue3.Encode( Upvalue4.Settings )
Upvalue1.Text = Upvalue2
return
]]

--[[
Function #66 has no emitted closure site
It is reproduced here so that nothing is lost

local Text = Upvalue1.Text

if Text == Upvalue2 then
    return
end

local Decode = Upvalue3.Decode( Text )

if Decode then
    local Value1 = nil

    for Key, Value in Decode, nil, nil do
        Upvalue8.Set( Key, Value )
    end

    Upvalue8.Set( "XhMode", "Custom" )

    if Upvalue4 then
        Upvalue5 = Upvalue5 + 1
        Upvalue4.RichText = true
        Upvalue4.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Crosshair applied" )
        task.delay( 2, function()
            if Upvalue5 == Upvalue5 then
                Upvalue4.Text = Upvalue6
            end
        end )
    end

    Upvalue7( )
    return
end
local Text2 = Text:gsub( "%s", "" ) ~= "" and "Invalid code" or "Paste a code first"

if Upvalue4 then
    Upvalue5 = Upvalue5 + 1
    Upvalue4.RichText = true
    Upvalue4.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", Text2 )
    task.delay( 2, function()
        if Upvalue5 == Upvalue5 then
            Upvalue4.Text = Upvalue6
        end
    end )
end

Upvalue7( )
return
]]

--[[
Function #67 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2 = Upvalue2 + 1
    Upvalue1.RichText = true
    Upvalue1.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Copied!" )
    task.delay( 2, function()
        if Upvalue2 == Upvalue2 then
            Upvalue1.Text = Upvalue3
        end
    end )
    return
end
return
]]

--[[
Function #68 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
local Select = Upvalue2.Select( Upvalue3, function()
    if Upvalue4 then
        Upvalue5 = Upvalue5 + 1
        Upvalue4.RichText = true
        Upvalue4.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Copied!" )
        task.delay( 2, function()
            if Upvalue5 == Upvalue5 then
                Upvalue4.Text = Upvalue6
            end
        end )
        return
    end
    return
end )

if Select then
    if not Upvalue4 then
        return
    end

    Upvalue5 = Upvalue5 + 1
    Upvalue4.RichText = true
    Upvalue4.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", Select )
    task.delay( 4, function()
        if Upvalue5 == Upvalue5 then
            Upvalue4.Text = Upvalue6
        end
    end )
end
]]

--[[
Function #69 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1:IsFocused( ) and Upvalue1.Text ~= Upvalue2 then
    Upvalue3( )
end
]]

--[[
Function #70 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 then
    Upvalue1( )
    return
end
task.delay( 0.4, function()
    if not Upvalue2:IsFocused( ) and Upvalue2.Text ~= Upvalue3 then
        Upvalue4( )
    end
end )
return
]]

--[[
Function #71 has no emitted closure site
It is reproduced here so that nothing is lost

local Row_XhCode2
local Row_XhCode = Object:FindFirstChild( "Row_XhCode", true )
Row_XhCode2 = if Row_XhCode then Row_XhCode:FindFirstChild( "Card" ) or Row_XhCode else Row_XhCode
local Box

if Row_XhCode2 then
    Box = Row_XhCode2:FindFirstChild( "Box" )
else
    Box = Row_XhCode2
end

local Apply

if Row_XhCode2 then
    Apply = Row_XhCode2:FindFirstChild( "Apply" )
else
    Apply = Row_XhCode2
end

local Label

if Row_XhCode2 then
    Label = Row_XhCode2:FindFirstChild( "Label" )
else
    Label = Row_XhCode2
end
if not Box or not Apply then
    return
end

local Row_XhCode3 = if Label then Label.Text else Label
local Number = 0

local function Say( Argument1, Argument2, Amount )
    if not Label then
        return
    end

    local Text
    Number = Number + 1
    Label.RichText = true
    Text = not Argument2 and "e23a42" or "46c86e"
    Label.Text = ( "<font color=\"#%s\">%s</font>" ):format( Text, Argument1 )
    task.delay( Amount or 2, function()
        if Number == Number then
            Label.Text = Row_XhCode3
        end
    end )
end

local Text = ""
Upvalue1 = function()
    if Box:IsFocused( ) then
        return
    end
    Text = Upvalue2.Encode( Upvalue3.Settings )
    Box.Text = Text
    return
end

local function Apply2()
    local TextInner = Box.Text

    if TextInner == Text then
        return
    end

    local Decode = Upvalue2.Decode( TextInner )

    if Decode then
        local Value1 = nil

        for Key, Value in Decode, nil, nil do
            Upvalue3.Set( Key, Value )
        end

        Upvalue3.Set( "XhMode", "Custom" )

        if Label then
            Number = Number + 1
            Label.RichText = true
            Label.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Crosshair applied" )
            task.delay( 2, function()
                if Number == Number then
                    Label.Text = Row_XhCode3
                end
            end )
        end

        Upvalue1( )
        return
    end
    local Text2 = TextInner:gsub( "%s", "" ) ~= "" and "Invalid code" or "Paste a code first"

    if Label then
        Number = Number + 1
        Label.RichText = true
        Label.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", Text2 )
        task.delay( 2, function()
            if Number == Number then
                Label.Text = Row_XhCode3
            end
        end )
    end

    Upvalue1( )
    return
end

Apply.Activated:Connect( Apply2 )
local Copy = Row_XhCode2:FindFirstChild( "Copy" )

if Copy then
    Copy.Activated:Connect( function()
        Upvalue1( )
        local Select = Upvalue4.Select( Box, function()
            if Label then
                Number = Number + 1
                Label.RichText = true
                Label.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Copied!" )
                task.delay( 2, function()
                    if Number == Number then
                        Label.Text = Row_XhCode3
                    end
                end )
                return
            end
            return
        end )

        if Select then
            if not Label then
                return
            end

            Number = Number + 1
            Label.RichText = true
            Label.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", Select )
            task.delay( 4, function()
                if Number == Number then
                    Label.Text = Row_XhCode3
                end
            end )
        end
    end )
end

Box.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        Apply2( )
        return
    end
    task.delay( 0.4, function()
        if not Box:IsFocused( ) and Box.Text ~= Text then
            Upvalue1( )
        end
    end )
    return
end )
Upvalue1( )
]]

--[[
Function #72 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil
    Upvalue2.Capturing = false
    Upvalue2.CaptureEndedAt = os.clock( )
    Upvalue3:UnbindAction( "SettingsKeyCapture" )

    if Upvalue4 then
        Upvalue4.Visible = false
    end

    local Value1 = nil

    for Key, Value in Upvalue5, nil, nil do
        Value( )
    end
end

local Value2
Upvalue6 = TabName
Value2 = nil

for Key2, Value3 in Upvalue7, nil, nil do
    local Visible = Key2 == TabName and true or false
    Value3.Visible = Visible
end

Upvalue8 = Upvalue7[ TabName ]

if Upvalue8:IsA( "ScrollingFrame" ) then
    Upvalue8.CanvasPosition = Vector2.zero
end
for Key3, Value4 in Upvalue8:GetDescendants( ) do
    if Value4:IsA( "ScrollingFrame" ) then
        Value4.CanvasPosition = Vector2.zero
    end
end

local CrosshairPreview

if Upvalue10 then
    local Entry = Upvalue11[ TabName ]

    if Entry then
        CrosshairPreview = Entry
    else
        CrosshairPreview = nil
    end
else
    CrosshairPreview = nil
end

Upvalue9.CrosshairPreview = CrosshairPreview

if TabName.bindings then
    Upvalue12( Upvalue8 )
end
if TabName.keybinds then
    local Value5 = nil

    for Key4, Value6 in Upvalue5, nil, nil do
        Value6( )
    end
end

local Value7 = nil

for Key5, Value8 in Upvalue13, nil, nil do
    local Enabled = Key5 == TabName and true or false
    local Selected = Value8:FindFirstChild( "Selected" )
    local Normal = Value8:FindFirstChild( "Normal" )

    if Selected then
        Selected.Enabled = Enabled
    end
    if Normal then
        Normal.Enabled = not Enabled
    end
end

local Entry4
local Refresh = Upvalue14.Refresh

if Argument2 then
    local Entry2 = Upvalue15[ Upvalue8 ]

    if Entry2 then
        Entry4 = Entry2
    else
        local Entry3 = Upvalue13[ TabName ]

        if Entry3 then
            Entry4 = Entry3
        else
            Entry4 = Upvalue13[ TabName ]
        end
    end
else
    Entry4 = Upvalue13[ TabName ]
end

Refresh( "Settings", Entry4 )
]]

--[[
Function #73 has no emitted closure site
It is reproduced here so that nothing is lost

local Find3
local Count = #Upvalue1.Tabs
local Find = table.find( Upvalue1.Tabs, Upvalue2 ) or 1
local I = 1
Find3 = Find

for I = 1, Count do
    local NotTouch2
    local Find2 = ( Find - 1 + Argument1 ) % Count + 1
    local NotTouch = not Upvalue1.Tabs[ Find2 ].touch

    if NotTouch then
        NotTouch2 = NotTouch
    elseif Upvalue3.TouchEnabled or Upvalue4.TouchMode( ) then
        NotTouch2 = true
    else
        local MobileGui = Upvalue5.PlayerGui:FindFirstChild( "MobileGui" )

        if Upvalue6 then
            if MobileGui == nil then
                NotTouch2 = false
            elseif MobileGui:GetAttribute( "ShowOnPC" ) == true then
                NotTouch2 = true
            else
                NotTouch2 = false
            end
        else
            NotTouch2 = Upvalue6
        end
    end
    if NotTouch2 then
        Find3 = Find2
        break
    end

    Find3 = Find2
    Find = Find2
end

Upvalue7( Upvalue1.Tabs[ Find3 ], true )
]]

--[[
Function #74 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #75 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Visible2
    local NotTouch3 = not Key.touch

    if NotTouch3 then
        Visible2 = NotTouch3
    elseif Upvalue2.TouchEnabled or Upvalue3.TouchMode( ) then
        Visible2 = true
    else
        local MobileGui3 = Upvalue4.PlayerGui:FindFirstChild( "MobileGui" )

        if Upvalue5 then
            if MobileGui3 == nil then
                Visible2 = false
            elseif MobileGui3:GetAttribute( "ShowOnPC" ) == true then
                Visible2 = true
            else
                Visible2 = false
            end
        else
            Visible2 = Upvalue5
        end
    end

    Value.Visible = Visible2
end

local Value2 = nil

for Key2, Value3 in Upvalue6, nil, nil do
    local Keys2
    local Keys = Key2.keys
    Keys2 = if Keys then Keys else { }
    local Value4 = nil

    for Key3, Value5 in Keys2, nil, nil do
        local Entry = Upvalue7[ Value5 ]

        if type( Entry ) == "table" and Entry.touch then
            local FoundChild = Value3:FindFirstChild( "Row_" .. Value5, true )

            if FoundChild then
                local Visible

                if Upvalue2.TouchEnabled or Upvalue3.TouchMode( ) then
                    Visible = true
                else
                    local MobileGui2 = Upvalue4.PlayerGui:FindFirstChild( "MobileGui" )

                    if Upvalue5 then
                        if MobileGui2 == nil then
                            Visible = false
                        elseif MobileGui2:GetAttribute( "ShowOnPC" ) == true then
                            Visible = true
                        else
                            Visible = false
                        end
                    else
                        Visible = Upvalue5
                    end
                end

                FoundChild.Visible = Visible
            end
        end
    end
end
if Upvalue8 then
    local NotTouch2
    local NotTouch = not Upvalue8.touch

    if NotTouch then
        NotTouch2 = NotTouch
    elseif Upvalue2.TouchEnabled or Upvalue3.TouchMode( ) then
        NotTouch2 = true
    else
        local MobileGui = Upvalue4.PlayerGui:FindFirstChild( "MobileGui" )

        if Upvalue5 then
            if MobileGui == nil then
                NotTouch2 = false
            elseif MobileGui:GetAttribute( "ShowOnPC" ) == true then
                NotTouch2 = true
            else
                NotTouch2 = false
            end
        else
            NotTouch2 = Upvalue5
        end
    end
    if not NotTouch2 then
        Upvalue9( Upvalue7.Tabs[ 1 ] )
    end
end
]]

--[[
Function #76 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ Name ] then
    Upvalue1[ Name ]( )
end
if Name == "Binds" then
    local Value1 = nil

    for Key, Value in Upvalue2, nil, nil do
        Value( )
    end
end
if Name == "XhMode" or Name == "XhHitmarkerOn" then
    Upvalue3( )
end
if type( Name ) == "string" and Name:sub( 1, 2 ) == "Xh" then
    Upvalue4( )
end
]]

--[[
Function #77 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if Upvalue1 and Upvalue1.scroller then
    Upvalue1.scroller.ScrollingEnabled = true
end
]]

--[[
Function #78 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Upvalue1.track.Parent then
    if Argument1.UserInputType == Enum.UserInputType.MouseMovement or Argument1 == Upvalue1.input then
        Upvalue1.set( Argument1.Position.X )
    end

    return
end
Upvalue1 = nil

if Upvalue1 and Upvalue1.scroller then
    Upvalue1.scroller.ScrollingEnabled = true
end

return
]]

--[[
Function #79 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if Argument1 == Upvalue1.input or Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
        Upvalue1 = nil

        if Upvalue1 and Upvalue1.scroller then
            Upvalue1.scroller.ScrollingEnabled = true
        end
    end
end
]]

--[[
Function #80 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1:GetAttribute( "InWardrobe" ) == true then
    Flag = true
elseif Upvalue2.WardrobeOpen == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #81 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.isSelected then
    Upvalue1:deselect( )
end
]]

--[[
Function #82 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1[ Upvalue2 ]
]]

--[[
Function #83 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:deselect( )
]]

--[[
Function #84 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( -1 )
]]

--[[
Function #85 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( 1 )
]]

--[[
Function #86 has no emitted closure site
It is reproduced here so that nothing is lost

if Enabled then
    local Flag

    if Upvalue1:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    elseif Upvalue2.WardrobeOpen == true then
        Flag = true
    else
        Flag = false
    end
    if Flag then
        task.defer( function()
            if Upvalue3.isSelected then
                Upvalue3:deselect( )
            end
        end )
        return
    end
end
if Enabled == Upvalue4 then
    return
end

Upvalue4 = Enabled
Upvalue5.Enabled = Enabled

if not Enabled and Upvalue6 then
    Upvalue6 = nil

    if Upvalue6 and Upvalue6.scroller then
        Upvalue6.scroller.ScrollingEnabled = true
    end
end
if not Enabled then
    if Upvalue7 then
        Upvalue7 = nil
        Upvalue8.Capturing = false
        Upvalue8.CaptureEndedAt = os.clock( )
        Upvalue9:UnbindAction( "SettingsKeyCapture" )

        if Upvalue10 then
            Upvalue10.Visible = false
        end

        local Value1 = nil

        for Key, Value in Upvalue11, nil, nil do
            Value( )
        end
    end
end

local CrosshairPreview

if not Enabled or not Upvalue12 then
    CrosshairPreview = nil
else
    local Entry = Upvalue13[ Upvalue12 ]

    if Entry then
        CrosshairPreview = Entry
    else
        CrosshairPreview = nil
    end
end

Upvalue2.CrosshairPreview = CrosshairPreview
Upvalue2.CursorFree = Enabled

if Enabled then
    Upvalue14( )
end
if Enabled then
    local Value2
    local Table = { "Customization", "Shop" }
    Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        local Icon
        local GetIcon = Upvalue15.getIcon

        if GetIcon then
            Icon = Upvalue15.getIcon( Value3 )
        else
            Icon = GetIcon
        end
        if Icon and Icon.isSelected then
            Icon:deselect( )
        end
    end
end
if Enabled then
    Upvalue16.Open( "Settings", {
        root = Upvalue17,
        first = function()
            return Upvalue18[ Upvalue12 ]
        end,
        onBack = function()
            Upvalue3:deselect( )
        end,
        tabs = {
            prev = function()
                Upvalue19( -1 )
            end,
            next = function()
                Upvalue19( 1 )
            end,
            label = "Tab"
        }
    } )
    return
end
Upvalue16.Close( "Settings" )
return
]]

--[[
Function #87 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( true )
]]

--[[
Function #88 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == false then
    return
end

Upvalue1 = false
Upvalue2.Enabled = false

if Upvalue3 then
    Upvalue3 = nil

    if Upvalue3 and Upvalue3.scroller then
        Upvalue3.scroller.ScrollingEnabled = true
    end
end
if Upvalue4 then
    Upvalue4 = nil
    Upvalue5.Capturing = false
    Upvalue5.CaptureEndedAt = os.clock( )
    Upvalue6:UnbindAction( "SettingsKeyCapture" )

    if Upvalue7 then
        Upvalue7.Visible = false
    end

    local Value1 = nil

    for Key, Value in Upvalue8, nil, nil do
        Value( )
    end
end

Upvalue9.CrosshairPreview = nil
Upvalue9.CursorFree = false
Upvalue10.Close( "Settings" )
]]

--[[
Function #89 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:setEnabled( Upvalue2 )
]]

--[[
Function #90 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1:GetAttribute( "InWardrobe" ) == true then
    Flag = true
elseif Upvalue2.WardrobeOpen == true then
    Flag = true
else
    Flag = false
end
if Flag and Upvalue3.isSelected then
    Upvalue3:deselect( )
end
if Upvalue4 ~= not Flag then
    Upvalue4 = not Flag
    pcall( function()
        Upvalue3:setEnabled( Upvalue4 )
    end )
end
]]

--[[
Function #91 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1 == false and true or false
local Flag2

if Upvalue2:GetAttribute( "InWardrobe" ) == true then
    Flag2 = true
elseif Upvalue3.WardrobeOpen == true then
    Flag2 = true
else
    Flag2 = false
end
if Flag ~= Flag2 then
    Upvalue4( )
end
]]

--[[
Function #92 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:deselect( )
]]

--[[
Function #93 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:select( )
]]

--[[
Function #94 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:deselect( )
]]

--[[
Function #95 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 and not Upvalue2.Editing and Upvalue3.Is( "PadMenu", Argument1 ) then
    Upvalue4:select( )
end
]]
