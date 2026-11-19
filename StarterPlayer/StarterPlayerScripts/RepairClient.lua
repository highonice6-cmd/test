-- StarterPlayer.StarterPlayerScripts.RepairClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #32

--[[
Function #0 has no emitted closure site
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
Function #1 has no emitted closure site
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
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Text == Upvalue2 then
    Upvalue1.Text = ""
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local TextColor3 = Argument2 and Upvalue2 or Upvalue3
Upvalue1.TextColor3 = TextColor3
Upvalue1.Text = Text
task.delay( 1.5, function()
    if Upvalue1.Text == Text then
        Upvalue1.Text = ""
    end
end )
]]

--[[
Function #4 has no emitted closure site
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
    task.delay( 1.5, function()
        if Upvalue3.Text == Text then
            Upvalue3.Text = ""
        end
    end )
    return
end
return
]]

--[[
Function #5 has no emitted closure site
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
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Name
local Entry = Upvalue1[ Self:GetAttribute( "Weapon" ) ]
Name = Entry and Entry.Name or Self.Name
return Name
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Tool = Argument1.tool
local Cost = Argument1.cost

if Upvalue1 or not Upvalue2 or not Tool or not Cost then
    return
end
if not ( ( tonumber( Upvalue3:GetAttribute( "Money" ) ) or 0 ) < Cost ) then
    Upvalue1 = true
    Upvalue8 = Argument1.index
    local Success, Result = pcall( Upvalue9.InvokeServer, Upvalue9, "Repair", Tool, Cost )
    Upvalue1 = false

    if not Success or type( Result ) ~= "table" or not Result.ok then
        local Err = Success and type( Result ) == "table" and Result.err or nil
        local Entry2 = Upvalue4[ Err ]

        if Entry2 ~= "" then
            local Text3 = Entry2 or "Something went wrong, try again"

            if not Upvalue5 or not Upvalue5.Error then
                if Upvalue6 then
                    Upvalue6.TextColor3 = Upvalue7
                    Upvalue6.Text = Text3
                    task.delay( 1.5, function()
                        if Upvalue6.Text == Text3 then
                            Upvalue6.Text = ""
                        end
                    end )
                end
            else
                Upvalue5.Error( Text3 )
            end
        end
    else
        local Name
        local Entry = Upvalue10[ Tool:GetAttribute( "Weapon" ) ]
        Name = Entry and Entry.Name or Tool.Name
        local Text2 = Name .. " repaired"

        if Upvalue6 then
            Upvalue6.TextColor3 = Upvalue11 or Upvalue7
            Upvalue6.Text = Text2
            task.delay( 1.5, function()
                if Upvalue6.Text == Text2 then
                    Upvalue6.Text = ""
                end
            end )
        end

        Upvalue12.Changed:Fire( )
    end

    Upvalue13( )
    return
end
local Money = Upvalue4.money

if Money == "" then
    return
end

local Text = Money or "Something went wrong, try again"

if Upvalue5 and Upvalue5.Error then
    Upvalue5.Error( Text )
    return
end
if Upvalue6 then
    Upvalue6.TextColor3 = Upvalue7
    Upvalue6.Text = Text
    task.delay( 1.5, function()
        if Upvalue6.Text == Text then
            Upvalue6.Text = ""
        end
    end )
    return
end
return
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Grad
local Clone = Upvalue1:Clone( )
Clone.Name = "Row" .. LayoutOrder
local Card = Clone:FindFirstChild( "Card" ) or Clone
local Tile = Card:FindFirstChild( "Tile" )
local Repair = Card:FindFirstChild( "Repair" )
local Table = { index = LayoutOrder, frame = Clone, button = Repair }
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
local CanPay
Table.broken = Broken
Table.name = Card:FindFirstChild( "WeaponName" )
Table.state = Card:FindFirstChild( "State" )
Table.price = Card:FindFirstChild( "Price" )
CanPay = if Repair then Repair:FindFirstChild( "CanPay" ) else Repair
local NoMoney
Table.canPay = CanPay
NoMoney = if Repair then Repair:FindFirstChild( "NoMoney" ) else Repair
Table.noMoney = NoMoney

if Repair then
    Repair.Activated:Connect( function()
        Upvalue2( Table )
    end )
end

Clone.LayoutOrder = LayoutOrder
Clone.Parent = Upvalue3
Upvalue4[ LayoutOrder ] = Table
return Table
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local Visible2
Argument1.tool = Tool
Argument1.cost = Cost
Visible2 = Tool:GetAttribute( "Broken" ) == true and true or false
local DurabilityFrac = Upvalue1.DurabilityFrac( Tool ) or 0

if Argument1.grad then
    local Grad = Argument1.grad
    Grad.Color = Upvalue2( Upvalue1.Category( Tool ) )
end
if Argument1.icon then
    Upvalue1.SetIcon( Argument1.icon, Upvalue1.Icon( Tool ) )
end
if Argument1.bar then
    local Visible
    local Bar = Argument1.bar
    Visible = DurabilityFrac > 0 and true or false
    Bar.Visible = Visible
    local Bar2 = Argument1.bar
    Bar2.Size = UDim2.fromScale( Upvalue3 * DurabilityFrac, Upvalue4 )
end
if Argument1.broken then
    Argument1.broken.Visible = Visible2
end
if Argument1.name then
    local Text
    local Name = Argument1.name
    local Entry = Upvalue5[ Tool:GetAttribute( "Weapon" ) ]
    Text = Entry and Entry.Name or Tool.Name
    Name.Text = Text
end
if Argument1.state then
    local Floor2
    local Floor = math.floor( DurabilityFrac * 100 )
    Floor2 = if not ( Floor < 1 ) or not ( DurabilityFrac > 0 ) then Floor else 1
    local Text2
    local State = Argument1.state
    Text2 = not Visible2 and "Condition " .. Floor2 .. "%" or "BROKEN"
    local TextColor3
    State.Text = Text2
    local State2 = Argument1.state
    TextColor3 = Visible2 and Upvalue6 or Upvalue7
    State2.TextColor3 = TextColor3
end
if Argument1.price then
    local Price = Argument1.price
    Price.Text = Upvalue8( Cost )
end

local Enabled = Cost <= Argument4 and true or false

if Argument1.canPay then
    Argument1.canPay.Enabled = Enabled
end
if Argument1.noMoney then
    local NoMoney = Argument1.noMoney
    NoMoney.Enabled = not Enabled
end

Argument1.frame.Visible = true
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.broken ~= Argument2.broken then
    return Argument1.broken
end
if Argument1.frac == Argument2.frac then
    local Flag2 = Argument1.tool.Name < Argument2.tool.Name and true or false
    return Flag2
end
local Flag = Argument1.frac < Argument2.frac and true or false
return Flag
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { }
local Table2 = { Upvalue1.Character, Upvalue1:FindFirstChildOfClass( "Backpack" ) }
Value1 = nil

for Key, Value in Table2, nil, nil do
    local Children = Value and Value:GetChildren( ) or { }
    local Value2 = nil

    for Key2, Value3 in Children, nil, nil do
        local Cost
        local IsA = Value3:IsA( "Tool" )

        if IsA then
            Cost = Upvalue2.Cost( Value3 )
        else
            Cost = IsA
        end
        if Cost then
            local Broken
            local Table3 = { tool = Value3, cost = Cost }
            Broken = Value3:GetAttribute( "Broken" ) == true and true or false
            Table3.broken = Broken
            Table3.frac = Upvalue3.DurabilityFrac( Value3 ) or 0
            table.insert( Table, Table3 )
        end
    end
end

table.sort( Table, function( Argument1, Argument2 )
    if Argument1.broken ~= Argument2.broken then
        return Argument1.broken
    end
    if Argument1.frac == Argument2.frac then
        local Flag2 = Argument1.tool.Name < Argument2.tool.Name and true or false
        return Flag2
    end
    local Flag = Argument1.frac < Argument2.frac and true or false
    return Flag
end )
return Table
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Button
local Item = Upvalue1[ 1 ]
Button = Item and Item.frame.Visible and Item.button or Upvalue2
return Button
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Number = tonumber( Upvalue1:GetAttribute( "Money" ) ) or 0
Upvalue2.Text = Upvalue3:gsub( "%$[%d%.]+", Upvalue4( Number ), 1 )
local Value1 = Upvalue5( )

if #Value1 == #Upvalue6 then
    Flag = false
else
    Flag = true
end

local Value2 = nil

for Key, Value in Value1, nil, nil do
    local Entry5
    local Entry4 = Upvalue8[ Key ]
    Entry5 = if Entry4 then Entry4 else Upvalue9( Key )
    local Tool = Value.tool
    Upvalue7( Entry5, Tool, Value.cost, Number )

    if Upvalue6[ Key ] ~= Value.tool then
        Flag = true
    end

    Upvalue6[ Key ] = Value.tool
end

local Count = #Value1 + 1
local Count2 = #Upvalue8
local I = Count

for I = Count, Count2 do
    Upvalue8[ I ].frame.Visible = false
    local Entry = Upvalue8[ I ]
    local Entry2 = Upvalue8[ I ]
    Entry.tool = nil
    Entry2.cost = nil
    Upvalue6[ I ] = nil
end

local Visible = #Value1 == 0 and true or false
Upvalue10.Visible = Visible

if Flag and Upvalue11 then
    local Button
    local Entry3 = Upvalue8[ math.min( Upvalue12, #Value1 ) ]
    local Refresh = Upvalue13.Refresh
    Button = Entry3 and Entry3.button or Upvalue14
    Refresh( "Repair", Button )
end
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false

if Upvalue2 then
    Upvalue3( )
end
]]

--[[
Function #16 has no emitted closure site
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
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ Key ] then
    Upvalue2( )
end
]]

--[[
Function #18 has no emitted closure site
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
Function #19 has no emitted closure site
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
Function #20 has no emitted closure site
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
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Argument1 )
Upvalue2( )
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Backpack" ) then
    Upvalue1( Object )
    Upvalue2( )
end
]]

--[[
Function #23 has no emitted closure site
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
Function #24 has no emitted closure site
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
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = true
Upvalue2( false )
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Enabled then
    return
end

Upvalue1 = Enabled
Upvalue2.Enabled = Enabled

if not Enabled then
    Upvalue15( )
    Upvalue11.Close( "Repair" )
    return
end
if Upvalue3 then
    Upvalue3.Text = ""
end

Upvalue4 = 1
Upvalue5( )
Upvalue6( )
Upvalue7.CanvasPosition = Vector2.zero

if Upvalue8 then
    Upvalue8.Scale = 0.92 * Upvalue9
    Upvalue10:Create( Upvalue8, TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Upvalue9 } ):Play( )
end

Upvalue11.Open( "Repair", {
    root = Upvalue2,
    first = Upvalue12,
    freeze = false,
    backLabel = "Close",
    onBack = function()
        Upvalue13 = true
        Upvalue14( false )
    end
} )
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = true

if Upvalue2 == false then
    return
end
Upvalue2 = false
Upvalue3.Enabled = false
Upvalue4( )
Upvalue5.Close( "Repair" )
return
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

if Circle:GetAttribute( "Repair" ) and Circle:IsA( "PVInstance" ) and not table.find( Upvalue1, Circle ) then
    table.insert( Upvalue1, Circle )
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Find = table.find( Upvalue1, Argument1 )

if Find then
    table.remove( Upvalue1, Find )
end
]]

--[[
Function #30 has no emitted closure site
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

    if Vector3.new( X, 0, Position.Z ).Magnitude <= 3.6 then
        if math.abs( Position.Y ) < 6 then
            return true
        end
    end
end

return false
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    task.wait( 0.2 )
    local Value1 = Upvalue1( )

    if not Value1 then
        Upvalue2 = false
    end

    local NotCaptured = if Value1 then not Upvalue2 else Value1
    Upvalue3( NotCaptured )
end
]]
