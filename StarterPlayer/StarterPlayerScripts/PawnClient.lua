-- StarterPlayer.StarterPlayerScripts.PawnClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #42

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { PawnSub = "Sub", PawnNoItem = "NoItem", PawnHint = "Hint" }
Value1 = nil

for Key, Value in Table, nil, nil do
    local FoundChild = Upvalue1:FindFirstChild( Value )
    local Text = Upvalue2:GetAttribute( Key )

    if FoundChild and FoundChild:IsA( "TextLabel" ) and type( Text ) == "string" and Text ~= "" then
        FoundChild.Text = Text
    end
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Vector22

if Upvalue1 then
    local ViewportSize = Upvalue1.ViewportSize

    if ViewportSize then
        Vector22 = ViewportSize
    else
        Vector22 = Vector2.new( 1920, 1080 )
    end
else
    Vector22 = Vector2.new( 1920, 1080 )
end

local Flag = Vector22.Y < 600 and true or false
local Size = Flag and Upvalue3 or Upvalue4
Upvalue2.Size = Size

if Upvalue5 then
    local AspectRatio = if Flag then 1.6 else Upvalue6
    Upvalue5.AspectRatio = AspectRatio
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Disconnect( )
end

Upvalue2 = workspace.CurrentCamera

if Upvalue2 then
    Upvalue1 = Upvalue2:GetPropertyChangedSignal( "ViewportSize" ):Connect( Upvalue3 )
end

local Vector22

if Upvalue2 then
    local ViewportSize = Upvalue2.ViewportSize

    if ViewportSize then
        Vector22 = ViewportSize
    else
        Vector22 = Vector2.new( 1920, 1080 )
    end
else
    Vector22 = Vector2.new( 1920, 1080 )
end

local Flag = Vector22.Y < 600 and true or false
local Size = Flag and Upvalue5 or Upvalue6
Upvalue4.Size = Size

if Upvalue7 then
    local AspectRatio = if Flag then 1.6 else Upvalue8
    Upvalue7.AspectRatio = AspectRatio
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Text == Upvalue2 then
    Upvalue1.Text = ""
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local TextColor3 = Argument2 and Upvalue2 or Upvalue3
Upvalue1.TextColor3 = TextColor3
Upvalue1.Text = Text
task.delay( 2, function()
    if Upvalue1.Text == Text then
        Upvalue1.Text = ""
    end
end )
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]

if Entry == "" then
    return
end

local Text = Entry or "Something went wrong, try again"

if Upvalue2 and Upvalue2.Error then
    Upvalue2.Error( Text )
    return
end
if Upvalue3 then
    Upvalue3.TextColor3 = Upvalue4
    Upvalue3.Text = Text
    task.delay( 2, function()
        if Upvalue3.Text == Text then
            Upvalue3.Text = ""
        end
    end )
    return
end
return
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1[ ForName ] then
    local Entry2
    local Entry = Upvalue2.TILE_GRAD[ ForName ]
    Entry2 = if Entry then Entry else Upvalue2.TILE_GRAD.gun
    local Keypoints = Entry2.Keypoints
    local Value = Keypoints[ 1 ].Value
    local Value2 = Keypoints[ #Keypoints ].Value
    Upvalue1[ ForName ] = ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Value2 ),
        ColorSequenceKeypoint.new( 0.5, Value ),
        ColorSequenceKeypoint.new( 1, Value2 )
    } )
end

return Upvalue1[ ForName ]
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Name
local Entry = Upvalue1[ Self:GetAttribute( "Weapon" ) ]

if not Entry or not Entry.Name then
    local DisplayName = Self:GetAttribute( "DisplayName" )

    if DisplayName then
        Name = DisplayName
    else
        Name = Self.Name
    end
else
    Name = Entry.Name
end

return Name
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

return tonumber( Object:GetAttribute( "Count" ) ) or 1
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.confirmAt == Upvalue2 then
    Upvalue3( Upvalue1, false )
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local ConfirmAt

if Enabled then
    local Clock = os.clock( )

    if Clock then
        ConfirmAt = Clock
    else
        ConfirmAt = nil
    end
else
    ConfirmAt = nil
end

Argument1.confirmAt = ConfirmAt

if Argument1.ready then
    local Ready = Argument1.ready
    Ready.Enabled = not Enabled
end
if Argument1.confirm then
    Argument1.confirm.Enabled = Enabled
end
if Argument1.text then
    local Text2
    local Text = Argument1.text
    Text2 = Enabled and Upvalue1 or Upvalue2
    Text.Text = Text2
end
if Enabled then
    local ConfirmAt2 = Argument1.confirmAt
    task.delay( 2.5, function()
        if Argument1.confirmAt == ConfirmAt2 then
            Upvalue3( Argument1, false )
        end
    end )
end
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Tool = Argument1.tool
local Price = Argument1.price

if not Upvalue1 and Upvalue2 then
    if Tool or Argument1.case then
        if Price then
            if not Argument1.confirmAt then
                local Value1 = nil

                for Key, Value in Upvalue3, nil, nil do
                    if Value ~= Argument1 and Value.confirmAt then
                        Value.confirmAt = nil

                        if Value.ready then
                            Value.ready.Enabled = true
                        end
                        if Value.confirm then
                            Value.confirm.Enabled = false
                        end
                        if Value.text then
                            Value.text.Text = Upvalue4
                        end
                    end
                end

                local ConfirmAt
                local Clock = os.clock( )
                ConfirmAt = if Clock then Clock else nil
                Argument1.confirmAt = ConfirmAt

                if Argument1.ready then
                    Argument1.ready.Enabled = false
                end
                if Argument1.confirm then
                    Argument1.confirm.Enabled = true
                end
                if Argument1.text then
                    local Text = Argument1.text
                    Text.Text = Upvalue5 or Upvalue4
                end

                local ConfirmAt2 = Argument1.confirmAt
                task.delay( 2.5, function()
                    if Argument1.confirmAt == ConfirmAt2 then
                        Upvalue6( Argument1, false )
                    end
                end )
                return
            end
            Argument1.confirmAt = nil

            if Argument1.ready then
                Argument1.ready.Enabled = true
            end
            if Argument1.confirm then
                Argument1.confirm.Enabled = false
            end
            if Argument1.text then
                Argument1.text.Text = Upvalue4
            end

            Upvalue1 = true
            Upvalue7 = Argument1.index

            if Argument1.case then
                local InvokeServer = Upvalue8.InvokeServer
                local T = Argument1.case.T
                local Success, Result = pcall( InvokeServer, Upvalue8, "SellCase", T, Argument1.case.K, Price )
                Upvalue1 = false

                if not Success or type( Result ) ~= "table" or not Result.ok then
                    local Err = Success and type( Result ) == "table" and Result.err or nil
                    local Entry = Upvalue13[ Err ]

                    if Entry ~= "" then
                        local Text4 = Entry or "Something went wrong, try again"

                        if not Upvalue14 or not Upvalue14.Error then
                            if Upvalue10 then
                                Upvalue10.TextColor3 = Upvalue12
                                Upvalue10.Text = Text4
                                task.delay( 2, function()
                                    if Upvalue10.Text == Text4 then
                                        Upvalue10.Text = ""
                                    end
                                end )
                            end
                        else
                            Upvalue14.Error( Text4 )
                        end
                    end
                else
                    local Text2 = tostring( Result.name )
                    local Text3 = "Sold " .. Text2 .. " for " .. Upvalue9( Result.price or Price )

                    if Upvalue10 then
                        Upvalue10.TextColor3 = Upvalue11 or Upvalue12
                        Upvalue10.Text = Text3
                        task.delay( 2, function()
                            if Upvalue10.Text == Text3 then
                                Upvalue10.Text = ""
                            end
                        end )
                    end
                end

                Upvalue15( )
                return
            end
            local Success2, Result2 = pcall( Upvalue8.InvokeServer, Upvalue8, "Sell", Tool, Price )
            Upvalue1 = false

            if not Success2 or type( Result2 ) ~= "table" or not Result2.ok then
                local Err2 = Success2 and type( Result2 ) == "table" and Result2.err or nil
                local Entry3 = Upvalue13[ Err2 ]

                if Entry3 ~= "" then
                    local Text7 = Entry3 or "Something went wrong, try again"

                    if not Upvalue14 or not Upvalue14.Error then
                        if Upvalue10 then
                            Upvalue10.TextColor3 = Upvalue12
                            Upvalue10.Text = Text7
                            task.delay( 2, function()
                                if Upvalue10.Text == Text7 then
                                    Upvalue10.Text = ""
                                end
                            end )
                        end
                    else
                        Upvalue14.Error( Text7 )
                    end
                end
            else
                local Name2
                local Name = Result2.name

                if Name then
                    Name2 = Name
                else
                    local Entry2 = Upvalue16[ Tool:GetAttribute( "Weapon" ) ]

                    if not Entry2 or not Entry2.Name then
                        local DisplayName = Tool:GetAttribute( "DisplayName" )

                        if DisplayName then
                            Name2 = DisplayName
                        else
                            Name2 = Tool.Name
                        end
                    else
                        Name2 = Entry2.Name
                    end
                end

                local Text5 = tostring( Name2 )
                local Text6 = "Sold " .. Text5 .. " for " .. Upvalue9( Result2.price or Price )

                if Upvalue10 then
                    Upvalue10.TextColor3 = Upvalue11 or Upvalue12
                    Upvalue10.Text = Text6
                    task.delay( 2, function()
                        if Upvalue10.Text == Text6 then
                            Upvalue10.Text = ""
                        end
                    end )
                end

                Upvalue17.Changed:Fire( )
            end

            Upvalue18( )
            return
        end
    end
end
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Grad
local Clone = Upvalue1:Clone( )
Clone.Name = "Row" .. LayoutOrder
local Card = Clone:FindFirstChild( "Card" ) or Clone
local Tile = Card:FindFirstChild( "Tile" )
local Sell = Card:FindFirstChild( "Sell" )
local Table = { index = LayoutOrder, frame = Clone, button = Sell }
Grad = if Tile then Tile:FindFirstChildOfClass( "UIGradient" ) else Tile
local Icon
Table.grad = Grad
Icon = if Tile then Tile:FindFirstChild( "Icon" ) else Tile
local Bar
Table.icon = Icon
Bar = if Tile then Tile:FindFirstChild( "AmmoBar" ) else Tile
local Broken
Table.bar = Bar
Broken = if Tile then Tile:FindFirstChild( "Broken" ) else Tile
local Ready
Table.broken = Broken
Table.name = Card:FindFirstChild( "ItemName" )
Table.state = Card:FindFirstChild( "State" )
Table.priceLabel = Card:FindFirstChild( "Price" )
Ready = if Sell then Sell:FindFirstChild( "Ready" ) else Sell
local Confirm
Table.ready = Ready
Confirm = if Sell then Sell:FindFirstChild( "Confirm" ) else Sell
local Text
Table.confirm = Confirm
Text = if Sell then Sell:FindFirstChild( "Text" ) else Sell
Table.text = Text

if Sell then
    Sell.Activated:Connect( function()
        Upvalue2( Table )
    end )
end

Clone.LayoutOrder = LayoutOrder
Clone.Parent = Upvalue3
Upvalue4[ LayoutOrder ] = Table
return Table
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.tool ~= Tool then
    Argument1.confirmAt = nil

    if Argument1.ready then
        Argument1.ready.Enabled = true
    end
    if Argument1.confirm then
        Argument1.confirm.Enabled = false
    end
    if Argument1.text then
        Argument1.text.Text = Upvalue1
    end
end

local Icon2
local Icon = Argument1.icon
Icon2 = if Icon then Argument1.icon.Parent else Icon

if Icon2 then
    local Swatch = Icon2:FindFirstChild( "Swatch" )
    local Preview = Icon2:FindFirstChild( "Preview" )

    if Swatch then
        Swatch.Visible = false
    end
    if Preview then
        Preview.Visible = false
    end
    if Argument1.icon then
        Argument1.icon.Visible = true
    end
end

local Visible2
Argument1.tool = Tool
Argument1.price = Price
Visible2 = Tool:GetAttribute( "Broken" ) == true and true or false
local DurabilityFrac = Upvalue2.DurabilityFrac( Tool )

if Argument1.grad then
    local Grad = Argument1.grad
    Grad.Color = Upvalue3( Upvalue2.Category( Tool ) )
end
if Argument1.icon then
    Upvalue2.SetIcon( Argument1.icon, Upvalue2.Icon( Tool ) )
end
if Argument1.bar then
    local Visible
    local Bar = Argument1.bar

    if DurabilityFrac == nil then
        Visible = false
    elseif DurabilityFrac > 0 then
        Visible = true
    else
        Visible = false
    end

    Bar.Visible = Visible

    if DurabilityFrac then
        local Bar2 = Argument1.bar
        Bar2.Size = UDim2.fromScale( Upvalue4 * DurabilityFrac, Upvalue5 )
    end
end
if Argument1.broken then
    Argument1.broken.Visible = Visible2
end
if Argument1.name then
    local Text
    local Name = Argument1.name
    local Entry = Upvalue6[ Tool:GetAttribute( "Weapon" ) ]

    if not Entry or not Entry.Name then
        local DisplayName = Tool:GetAttribute( "DisplayName" )

        if DisplayName then
            Text = DisplayName
        else
            Text = Tool.Name
        end
    else
        Text = Entry.Name
    end

    Name.Text = Text
end
if Argument1.state then
    local Text3
    local Get = Upvalue7.Get( Tool:GetAttribute( "Item" ) )

    if not Get or Get.SellStack ~= true then
        if Upvalue8.MYTHIC_ONLY then
            local Weapon2
            local IsSecret = Upvalue2.IsSecret
            local Weapon = Tool:GetAttribute( "Weapon" )
            Weapon2 = if Weapon then Weapon else Tool:GetAttribute( "Melee" )
            local Text2 = not IsSecret( Weapon2 ) and "Mythic weapon" or "Secret weapon"
            Text3 = Text2
        elseif Tool:GetAttribute( "Vehicle" ) then
            Text3 = ( "Vehicle · Health %d%%" ):format( ( math.floor( ( DurabilityFrac or 1 ) * 100 + 0.5 ) ) )
        elseif Tool:GetAttribute( "Item" ) then
            local Format2
            local Number2 = tonumber( Tool:GetAttribute( "Count" ) ) or 1
            Format2 = Number2 > 1 and ( "x%d · sells one at a time" ):format( Number2 ) or "x1"
            Text3 = Format2
        elseif Tool:GetAttribute( "Melee" ) then
            Text3 = "Melee weapon"
        elseif Visible2 then
            Text3 = "BROKEN"
        elseif DurabilityFrac then
            local Floor2
            local Floor = math.floor( DurabilityFrac * 100 )
            Floor2 = if not ( Floor < 1 ) or not ( DurabilityFrac > 0 ) then Floor else 1
            Text3 = "Condition " .. Floor2 .. "%"
        else
            Text3 = "No wear"
        end
    else
        local Format
        local Number = tonumber( Tool:GetAttribute( "Count" ) ) or 1
        Format = Number > 1 and ( "x%d · whole stack" ):format( Number ) or "x1"
        Text3 = Format
    end

    local TextColor3
    Argument1.state.Text = Text3
    local State = Argument1.state
    TextColor3 = Visible2 and Upvalue9 or Upvalue10
    State.TextColor3 = TextColor3
end
if Argument1.priceLabel then
    local PriceLabel = Argument1.priceLabel
    PriceLabel.Text = Upvalue11( Price )
end

Argument1.frame.Visible = true
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetChildren( ) do
    local FoundChild = Value:FindFirstChild( Name )

    if FoundChild then
        return FoundChild
    end
end

return nil
]]

-- Could not structure function #16

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Tool = Argument1.tool

if Tool then
    if Tool:GetAttribute( "Weapon" ) or Tool:GetAttribute( "Melee" ) then
        return 1
    end
end
if not Tool or not Tool:GetAttribute( "Vehicle" ) then
    return 3
end
return 2
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local Tool = Argument1.tool

if Tool then
    if Tool:GetAttribute( "Weapon" ) or Tool:GetAttribute( "Melee" ) then
        Number = 1
    elseif not Tool or not Tool:GetAttribute( "Vehicle" ) then
        Number = 3
    else
        Number = 2
    end
elseif not Tool or not Tool:GetAttribute( "Vehicle" ) then
    Number = 3
else
    Number = 2
end

local Number2
local Tool2 = Argument2.tool

if Tool2 then
    if Tool2:GetAttribute( "Weapon" ) or Tool2:GetAttribute( "Melee" ) then
        Number2 = 1
    elseif not Tool2 or not Tool2:GetAttribute( "Vehicle" ) then
        Number2 = 3
    else
        Number2 = 2
    end
elseif not Tool2 or not Tool2:GetAttribute( "Vehicle" ) then
    Number2 = 3
else
    Number2 = 2
end
if Number ~= Number2 then
    local Flag = Number < Number2 and true or false
    return Flag
end
if Argument1.price == Argument2.price then
    local Name

    if Argument1.tool then
        local Tool3 = Argument1.tool
        local Entry = Upvalue1[ Tool3:GetAttribute( "Weapon" ) ]

        if not Entry or not Entry.Name then
            local DisplayName = Tool3:GetAttribute( "DisplayName" )

            if DisplayName then
                Name = DisplayName
            else
                Name = Tool3.Name
            end
        else
            Name = Entry.Name
        end
        if not Name then
            Name = Argument1.case.N
        end
    else
        Name = Argument1.case.N
    end

    local Name2

    if Argument2.tool then
        local Tool4 = Argument2.tool
        local Entry2 = Upvalue1[ Tool4:GetAttribute( "Weapon" ) ]

        if not Entry2 or not Entry2.Name then
            local DisplayName2 = Tool4:GetAttribute( "DisplayName" )

            if DisplayName2 then
                Name2 = DisplayName2
            else
                Name2 = Tool4.Name
            end
        else
            Name2 = Entry2.Name
        end
        if not Name2 then
            Name2 = Argument2.case.N
        end
    else
        Name2 = Argument2.case.N
    end

    local Flag3 = Name < Name2 and true or false
    return Flag3
end
local Flag2
local Price = Argument1.price
Flag2 = Argument2.price < Price and true or false
return Flag2
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { }
local Table2 = { Upvalue1.Character, Upvalue1:FindFirstChildOfClass( "Backpack" ) }
Value1 = nil

for Key, Value in Table2, nil, nil do
    local Children = Value and Value:GetChildren( ) or { }
    local Value4 = nil

    for Key3, Value5 in Children, nil, nil do
        local Price
        local IsA = Value5:IsA( "Tool" )

        if IsA then
            Price = Upvalue2.Price( Value5 )
        else
            Price = IsA
        end
        if Price then
            table.insert( Table, { tool = Value5, price = Price } )
        end
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue3, nil, nil do
    table.insert( Table, { case = Value3, price = Value3.P } )
end

local function Group( Argument1 )
    local Tool = Argument1.tool

    if Tool then
        if Tool:GetAttribute( "Weapon" ) or Tool:GetAttribute( "Melee" ) then
            return 1
        end
    end
    if not Tool or not Tool:GetAttribute( "Vehicle" ) then
        return 3
    end
    return 2
end

table.sort( Table, function( Argument1, Argument2 )
    local Number
    local Tool = Argument1.tool

    if Tool then
        if Tool:GetAttribute( "Weapon" ) or Tool:GetAttribute( "Melee" ) then
            Number = 1
        elseif not Tool or not Tool:GetAttribute( "Vehicle" ) then
            Number = 3
        else
            Number = 2
        end
    elseif not Tool or not Tool:GetAttribute( "Vehicle" ) then
        Number = 3
    else
        Number = 2
    end

    local Number2
    local Tool2 = Argument2.tool

    if Tool2 then
        if Tool2:GetAttribute( "Weapon" ) or Tool2:GetAttribute( "Melee" ) then
            Number2 = 1
        elseif not Tool2 or not Tool2:GetAttribute( "Vehicle" ) then
            Number2 = 3
        else
            Number2 = 2
        end
    elseif not Tool2 or not Tool2:GetAttribute( "Vehicle" ) then
        Number2 = 3
    else
        Number2 = 2
    end
    if Number ~= Number2 then
        local Flag = Number < Number2 and true or false
        return Flag
    end
    if Argument1.price == Argument2.price then
        local Name

        if Argument1.tool then
            local Tool3 = Argument1.tool
            local Entry = Upvalue4[ Tool3:GetAttribute( "Weapon" ) ]

            if not Entry or not Entry.Name then
                local DisplayName = Tool3:GetAttribute( "DisplayName" )

                if DisplayName then
                    Name = DisplayName
                else
                    Name = Tool3.Name
                end
            else
                Name = Entry.Name
            end
            if not Name then
                Name = Argument1.case.N
            end
        else
            Name = Argument1.case.N
        end

        local Name2

        if Argument2.tool then
            local Tool4 = Argument2.tool
            local Entry2 = Upvalue4[ Tool4:GetAttribute( "Weapon" ) ]

            if not Entry2 or not Entry2.Name then
                local DisplayName2 = Tool4:GetAttribute( "DisplayName" )

                if DisplayName2 then
                    Name2 = DisplayName2
                else
                    Name2 = Tool4.Name
                end
            else
                Name2 = Entry2.Name
            end
            if not Name2 then
                Name2 = Argument2.case.N
            end
        else
            Name2 = Argument2.case.N
        end

        local Flag3 = Name < Name2 and true or false
        return Flag3
    end
    local Flag2
    local Price = Argument1.price
    Flag2 = Argument2.price < Price and true or false
    return Flag2
end )
return Table
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local Button
local Item = Upvalue1[ 1 ]
Button = Item and Item.frame.Visible and Item.button or Upvalue2
return Button
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
Upvalue2.Text = Upvalue3:gsub( "%$[%d%.]+", Upvalue4( tonumber( Upvalue1:GetAttribute( "Money" ) ) or 0 ), 1 )
local Value1 = Upvalue5( )

if #Value1 == #Upvalue6 then
    Flag = false
else
    Flag = true
end

local Value2 = nil

for Key, Value in Value1, nil, nil do
    local Entry7
    local Entry6 = Upvalue7[ Key ]

    if Entry6 then
        Entry7 = Entry6
    else
        Entry7 = Upvalue8( Key )
    end
    if Value.case then
        Upvalue9( Entry7, Value.case )
    else
        Entry7.case = nil
        Upvalue10( Entry7, Value.tool, Value.price )
    end

    local Tool2
    local Tool = Value.tool
    Tool2 = if Tool then Tool else Value.case.T .. Value.case.K

    if Upvalue6[ Key ] ~= Tool2 then
        Flag = true
    end

    Upvalue6[ Key ] = Tool2
end

local Count = #Value1 + 1
local Count2 = #Upvalue7
local I = Count

for I = Count, Count2 do
    Upvalue7[ I ].frame.Visible = false
    local Entry = Upvalue7[ I ]
    Entry.confirmAt = nil

    if Entry.ready then
        Entry.ready.Enabled = true
    end
    if Entry.confirm then
        Entry.confirm.Enabled = false
    end
    if Entry.text then
        Entry.text.Text = Upvalue11
    end

    local Entry2 = Upvalue7[ I ]
    local Entry3 = Upvalue7[ I ]
    local Entry4 = Upvalue7[ I ]
    Entry2.tool = nil
    Entry3.price = nil
    Entry4.case = nil
    Upvalue6[ I ] = nil
end

local Visible = #Value1 == 0 and true or false
Upvalue12.Visible = Visible

if Flag and Upvalue13 then
    local Button
    local Entry5 = Upvalue7[ math.min( Upvalue14, #Value1 ) ]
    local Refresh = Upvalue15.Refresh
    Button = Entry5 and Entry5.button or Upvalue16
    Refresh( "Pawn", Button )
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false

if Upvalue2 then
    Upvalue3( )
end
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
task.defer( function()
    Upvalue1 = false

    if Upvalue2 then
        Upvalue3( )
    end
end )
return
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ Key ] then
    Upvalue2( )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ ToolName ] or not ToolName:IsA( "Tool" ) then
    return
end
Upvalue1[ ToolName ] = ToolName.AttributeChanged:Connect( function( Key )
    if Upvalue2[ Key ] then
        Upvalue3( )
    end
end )
return
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1[ Key ] then
    if Key:IsA( "Tool" ) then
        Upvalue1[ Key ] = Key.AttributeChanged:Connect( function( Key )
            if Upvalue2[ Key ] then
                Upvalue3( )
            end
        end )
    end
end

Upvalue3( )
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if not Object then
    return
end

table.insert( Upvalue1, Object.ChildAdded:Connect( function( Key )
    if not Upvalue2[ Key ] then
        if Key:IsA( "Tool" ) then
            Upvalue2[ Key ] = Key.AttributeChanged:Connect( function( Key )
                if Upvalue3[ Key ] then
                    Upvalue4( )
                end
            end )
        end
    end

    Upvalue4( )
end ) )
table.insert( Upvalue1, Object.ChildRemoved:Connect( Upvalue4 ) )

for Key, Value in Object:GetChildren( ) do
    if not Upvalue2[ Value ] then
        if Value:IsA( "Tool" ) then
            Upvalue2[ Value ] = Value.AttributeChanged:Connect( function( Key )
                if Upvalue3[ Key ] then
                    Upvalue4( )
                end
            end )
        end
    end
end
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Argument1 )
Upvalue2( )
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Backpack" ) then
    Upvalue1( Object )
    Upvalue2( )
end
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2.Character )
Upvalue1( Upvalue2:FindFirstChildOfClass( "Backpack" ) )
table.insert( Upvalue3, Upvalue2.CharacterAdded:Connect( function( Argument1 )
    Upvalue1( Argument1 )
    Upvalue4( )
end ) )
table.insert( Upvalue3, Upvalue2.ChildAdded:Connect( function( Object )
    if Object:IsA( "Backpack" ) then
        Upvalue1( Object )
        Upvalue4( )
    end
end ) )
table.insert( Upvalue3, Upvalue2:GetAttributeChangedSignal( "Money" ):Connect( Upvalue4 ) )
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Disconnect( )
end

local Value2
table.clear( Upvalue1 )
Value2 = nil

for Key2, Value3 in Upvalue2, nil, nil do
    Value3:Disconnect( )
end

table.clear( Upvalue2 )
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "List" )

if Success and type( Result ) == "table" and type( Result.items ) == "table" then
    Upvalue2 = Result.items
end
if Upvalue3 then
    Upvalue4( )
end
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( function()
    local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "List" )

    if Success and type( Result ) == "table" and type( Result.items ) == "table" then
        Upvalue2 = Result.items
    end
    if Upvalue3 then
        Upvalue4( )
    end
end )
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = true
Upvalue2( false )
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Enabled then
    return
end

Upvalue1 = Enabled
Upvalue2.Enabled = Enabled

if Enabled then
    Upvalue3( )

    if Upvalue4 then
        Upvalue4.Text = ""
    end

    Upvalue5 = 1
    Upvalue6( )
    Upvalue7( )
    Upvalue8.CanvasPosition = Vector2.zero

    if Upvalue9 then
        Upvalue9.Scale = 0.92 * Upvalue10
        Upvalue11:Create( Upvalue9, TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Upvalue10 } ):Play( )
    end

    Upvalue12.Open( "Pawn", {
        root = Upvalue2,
        first = Upvalue13,
        freeze = false,
        backLabel = "Close",
        onBack = function()
            Upvalue14 = true
            Upvalue15( false )
        end
    } )
    return
end
local Value1 = nil

for Key, Value in Upvalue16, nil, nil do
    Value.confirmAt = nil

    if Value.ready then
        Value.ready.Enabled = true
    end
    if Value.confirm then
        Value.confirm.Enabled = false
    end
    if Value.text then
        Value.text.Text = Upvalue17
    end
end

Upvalue18( )
Upvalue12.Close( "Pawn" )
return
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = true

if Upvalue2 == false then
    return
end

local Value1
Upvalue2 = false
Upvalue3.Enabled = false
Value1 = nil

for Key, Value in Upvalue4, nil, nil do
    Value.confirmAt = nil

    if Value.ready then
        Value.ready.Enabled = true
    end
    if Value.confirm then
        Value.confirm.Enabled = false
    end
    if Value.text then
        Value.text.Text = Upvalue5
    end
end

Upvalue6( )
Upvalue7.Close( "Pawn" )
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

if Circle:GetAttribute( "Pawn" ) and Circle:IsA( "PVInstance" ) and not table.find( Upvalue1, Circle ) then
    table.insert( Upvalue1, Circle )
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

local Find = table.find( Upvalue1, Argument1 )

if Find then
    table.remove( Upvalue1, Find )
end
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if #Upvalue1 == 0 then
    return false
end

local HumanoidRootPart
local Character = Upvalue2.Character

if Character then
    HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
else
    HumanoidRootPart = Character
end
if not HumanoidRootPart or Character:GetAttribute( "Downed" ) then
    return false
end

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Position = HumanoidRootPart.Position - Value:GetPivot( ).Position
    local X = Position.X

    if Vector3.new( X, 0, Position.Z ).Magnitude <= 3.8 then
        if math.abs( Position.Y ) < 6 then
            return true
        end
    end
end

return false
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

local CombatUntil3
local CombatUntil = Upvalue1:GetAttribute( "CombatUntil" )

if type( CombatUntil ) == "number" then
    local CombatUntil2 = CombatUntil - workspace:GetServerTimeNow( )

    if CombatUntil2 then
        CombatUntil3 = CombatUntil2
    else
        CombatUntil3 = 0
    end
else
    CombatUntil3 = 0
end

return CombatUntil3
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    task.wait( 0.2 )
    local Value1 = Upvalue1( )

    if not Value1 then
        Upvalue2 = false
    end

    local CombatUntil3

    if Value1 then
        local CombatUntil = Upvalue3:GetAttribute( "CombatUntil" )

        if type( CombatUntil ) == "number" then
            local CombatUntil2 = CombatUntil - workspace:GetServerTimeNow( )

            if CombatUntil2 then
                CombatUntil3 = CombatUntil2
            else
                CombatUntil3 = 0
            end
        else
            CombatUntil3 = 0
        end
        if not CombatUntil3 then
            CombatUntil3 = 0
        end
    else
        CombatUntil3 = 0
    end
    if CombatUntil3 > 0 then
        if not Upvalue4 then
            Upvalue4 = true
            local Text = ( "%s (%ds)" ):format( "You can't use the Pawn during combat", ( math.ceil( CombatUntil3 ) ) )

            if not Upvalue5 or not Upvalue5.Error then
                if Upvalue6 then
                    Upvalue6.TextColor3 = Upvalue7
                    Upvalue6.Text = Text
                    task.delay( 2, function()
                        if Upvalue6.Text == Text then
                            Upvalue6.Text = ""
                        end
                    end )
                end
            else
                Upvalue5.Error( Text )
            end
        end
    else
        Upvalue4 = false
    end

    local NotCaptured2

    if Value1 then
        local NotCaptured = not Upvalue2

        if NotCaptured then
            if CombatUntil3 <= 0 then
                NotCaptured2 = true
            else
                NotCaptured2 = false
            end
        else
            NotCaptured2 = NotCaptured
        end
    else
        NotCaptured2 = Value1
    end

    Upvalue8( NotCaptured2 )
end
]]
