-- StarterPlayer.StarterPlayerScripts.HealthBarClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #10

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local I = 1

for I = 1, 20 do
    if pcall( Upvalue1.SetCoreGuiEnabled, Upvalue1, Enum.CoreGuiType.Health, false ) then
        return
    end

    task.wait( 0.5 )
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

return Enum.CoreGuiType.SelfView
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( function()
    return Enum.CoreGuiType.SelfView
end )

if not Success then
    return
end

local I = 1

for I = 1, 20 do
    if pcall( Upvalue1.SetCoreGuiEnabled, Upvalue1, Result, false ) then
        return
    end

    task.wait( 0.5 )
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local GlobalGui2
local GlobalGui = Upvalue1:FindFirstChild( "GlobalGui" )
GlobalGui2 = if GlobalGui then GlobalGui:FindFirstChild( "TopRight" ) else GlobalGui
return GlobalGui2
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute3
local Attribute2 = Upvalue1:GetAttribute( Attribute )
Attribute3 = typeof( Attribute2 ) == "Color3" and Attribute2 or Argument2
return Attribute3
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Visible then
    return
end

local Hotbar
local Inventory = Upvalue2:FindFirstChild( "Inventory" )

if Inventory then
    Hotbar = Inventory:FindFirstChild( "Hotbar" )
else
    Hotbar = Inventory
end

local Y = Upvalue3.AbsoluteSize.Y

if not Hotbar or not Hotbar.Visible or not ( Y > 0 ) then
    Upvalue1.Position = UDim2.fromScale( 0.5, 0.86 )
    return
end

local Number = math.huge

for Key, Value in Hotbar:GetChildren( ) do
    local Tile
    local IsA = Value:IsA( "GuiObject" )

    if IsA then
        local Visible = Value.Visible

        if Visible then
            Tile = Value:FindFirstChild( "Tile" )
        else
            Tile = Visible
        end
    else
        Tile = IsA
    end
    if Tile and Tile:IsA( "GuiObject" ) and Tile.AbsoluteSize.Y > 2 then
        Number = math.min( Number, Tile.AbsolutePosition.Y )
    end
end
if Number == math.huge then
    Number = Hotbar.AbsolutePosition.Y
end

local Number2 = if Inventory.IgnoreGuiInset then 0 else -game:GetService( "GuiService" ):GetGuiInset( ).Y
Upvalue1.Position = UDim2.fromScale( 0.5, ( math.max( ( Number - Number2 ) / Y - 0.03, 0.3 ) ) )
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local ArmorBar = Self:FindFirstChild( "ArmorBar" )

if ArmorBar and ArmorBar:GetAttribute( "BarY" ) == nil then
    ArmorBar:SetAttribute( "BarY", Self.Bar.Position.Y.Scale )
    ArmorBar:SetAttribute( "BarBg", ArmorBar.BackgroundTransparency )
end

return ArmorBar
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "GuiObject" ) then
    local Items = Upvalue1.items
    table.insert( Items, { Object, "BackgroundTransparency", Object.BackgroundTransparency } )

    if Object:IsA( "TextLabel" ) or Object:IsA( "TextButton" ) or Object:IsA( "TextBox" ) then
        local Items3 = Upvalue1.items
        table.insert( Items3, { Object, "TextTransparency", Object.TextTransparency } )
        local Items4 = Upvalue1.items
        table.insert( Items4, { Object, "TextStrokeTransparency", Object.TextStrokeTransparency } )
        return
    end
    if Object:IsA( "ImageLabel" ) or Object:IsA( "ImageButton" ) then
        local Items2 = Upvalue1.items
        table.insert( Items2, { Object, "ImageTransparency", Object.ImageTransparency } )
        return
    end
elseif Object:IsA( "UIStroke" ) then
    local Items5 = Upvalue1.items
    table.insert( Items5, { Object, "Transparency", Object.Transparency } )
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1[ Object ]

if Entry then
    Entry2 = Entry
else
    local Value1 = nil

    for Value in Upvalue1, nil, nil do
        if not Value:IsDescendantOf( Upvalue2 ) then
            Upvalue1[ Value ] = nil
        end
    end

    local Alpha
    local Table = { pose = -1, montre = false }
    Alpha = ( not Upvalue3.Spectating or not Flag ) and 0 or 1
    Table.alpha = Alpha
    Table.items = { }

    local function Retenir( Object )
        if Object:IsA( "GuiObject" ) then
            local Items = Table.items
            table.insert( Items, { Object, "BackgroundTransparency", Object.BackgroundTransparency } )

            if Object:IsA( "TextLabel" ) or Object:IsA( "TextButton" ) or Object:IsA( "TextBox" ) then
                local Items3 = Table.items
                table.insert( Items3, { Object, "TextTransparency", Object.TextTransparency } )
                local Items4 = Table.items
                table.insert( Items4, { Object, "TextStrokeTransparency", Object.TextStrokeTransparency } )
                return
            end
            if Object:IsA( "ImageLabel" ) or Object:IsA( "ImageButton" ) then
                local Items2 = Table.items
                table.insert( Items2, { Object, "ImageTransparency", Object.ImageTransparency } )
                return
            end
        elseif Object:IsA( "UIStroke" ) then
            local Items5 = Table.items
            table.insert( Items5, { Object, "Transparency", Object.Transparency } )
        end
    end

    Retenir( Object )

    for Key2, Value2 in Object:GetDescendants( ) do
        Retenir( Value2 )
    end

    Upvalue1[ Object ] = Table
    Entry2 = Table
end
if Flag then
    Entry2.montre = true
    Entry2.depuis = nil
elseif Entry2.montre then
    Entry2.depuis = Entry2.depuis or Clock

    if Clock - Entry2.depuis >= 1.5 then
        Entry2.montre = false
    end
end

local Number = not Entry2.montre and 0 or 1

if Entry2.alpha < Number then
    Entry2.alpha = math.min( Entry2.alpha + Amount / 0.2, 1 )
elseif Number < Entry2.alpha then
    Entry2.alpha = math.max( Entry2.alpha - Amount / 0.4, 0 )
end
if Entry2.alpha ~= Entry2.pose then
    local Value3
    Entry2.pose = Entry2.alpha
    local Items = Entry2.items
    Value3 = nil

    for Key3, Value4 in Items, nil, nil do
        Value4[ 1 ][ Value4[ 2 ] ] = 1 - ( 1 - Value4[ 3 ] ) * Entry2.alpha
    end
end

local Visible = Entry2.alpha > 0 and true or false
Object.Visible = Visible
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local TopRight
local GlobalGui = Upvalue2:FindFirstChild( "GlobalGui" )

if GlobalGui then
    TopRight = GlobalGui:FindFirstChild( "TopRight" )
else
    TopRight = GlobalGui
end

local Health

if TopRight then
    Health = TopRight:FindFirstChild( "Health" )
else
    Health = TopRight
end

local Stamina

if TopRight then
    Stamina = TopRight:FindFirstChild( "Stamina" )
else
    Stamina = TopRight
end
if Health and not Humanoid then
    Health.Visible = false
end
if Stamina and not Humanoid then
    Stamina.Visible = false
end
if not Humanoid then
    return
end

local Health2 = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth

if Upvalue3.Spectating then
    if Upvalue4 then
        if Upvalue4[ 1 ] ~= Character and Upvalue4[ 2 ] <= 0 then
            Upvalue4 = {
                Character,
                Humanoid.Health,
                Humanoid.MaxHealth,
                ( math.max( Character:GetAttribute( "Armor" ) or 0, 0 ) )
            }
        end
    else
        Upvalue4 = {
            Character,
            Humanoid.Health,
            Humanoid.MaxHealth,
            ( math.max( Character:GetAttribute( "Armor" ) or 0, 0 ) )
        }
    end

    Health2 = Upvalue4[ 2 ]
    MaxHealth = Upvalue4[ 3 ]
else
    Upvalue4 = nil
end

local Clamp = math.clamp( Health2 / math.max( MaxHealth, 1 ), 0, 1 )
local Clock = os.clock( )

if Upvalue5 and Health2 < Upvalue5 - 0.01 then
    Upvalue6 = Clock
end

Upvalue5 = Health2
Upvalue7 = Upvalue7 + ( Clamp - Upvalue7 ) * ( 1 - math.exp( -18 * Amount2 ) )

if Upvalue8 < Clamp or Clock - Upvalue6 > 0.35 then
    local Number
    local Clamp2 = Clamp - Upvalue8
    Number = not ( Upvalue8 < Clamp ) and 5 or 30
    Upvalue8 = Upvalue8 + Clamp2 * ( 1 - math.exp( -Number * Amount2 ) )
end
if Health then
    local Max
    local Value1 = Upvalue9( Health )
    Upvalue10( Health, true, Clock, Amount2 )

    if Upvalue4 then
        local Item = Upvalue4[ 4 ]

        if Item then
            Max = Item
        else
            Max = math.max( Character:GetAttribute( "Armor" ) or 0, 0 )
        end
    else
        Max = math.max( Character:GetAttribute( "Armor" ) or 0, 0 )
    end

    local Number2
    Upvalue11 = Upvalue11 + ( Max - Upvalue11 ) * ( 1 - math.exp( -14 * Amount2 ) )
    Number2 = not ( Max > 0 ) and 0 or 1
    Upvalue12 = Upvalue12 + ( Number2 - Upvalue12 ) * ( 1 - math.exp( -10 * Amount2 ) )

    if Value1 then
        local Visible
        local BarY = ( Value1:GetAttribute( "BarY" ) or 0.5 ) - Upvalue12 * 0.07
        local Bar = Health.Bar
        local Scale = Health.Bar.Position.X.Scale
        Bar.Position = UDim2.new( Scale, Health.Bar.Position.X.Offset, BarY, 0 )
        local Scale2 = Health.Bar.Position.X.Scale
        local Offset = Health.Bar.Position.X.Offset
        Value1.Position = UDim2.new( Scale2, Offset, BarY + Health.Bar.Size.Y.Scale * ( 1 - Health.Bar.AnchorPoint.Y ) + 0.045, 0 )
        Visible = Upvalue12 > 0.02 and true or false
        Value1.Visible = Visible
        Value1.BackgroundTransparency = 1 - ( 1 - ( Value1:GetAttribute( "BarBg" ) or 0 ) ) * Upvalue12
        local Fill = Value1.Fill
        Fill.BackgroundTransparency = 1 - Upvalue12
        local Fill2 = Value1.Fill
        Fill2.Size = UDim2.fromScale( math.clamp( Upvalue11 / Upvalue13, 0, 1 ), 1 )
    end

    local Fill3 = Health.Bar.Fill
    Fill3.Size = UDim2.fromScale( Upvalue7, 1 )
    local Lag = Health.Bar.Lag
    Lag.Size = UDim2.fromScale( math.max( Upvalue8, Upvalue7 ), 1 )
    local Armor = Health.Bar:FindFirstChild( "Armor" )

    if Armor then
        Armor:Destroy( )
    end

    Health.Value.RichText = true
    local Value = Health.Value
    Value.Text = tostring( ( math.ceil( Health2 + Max ) ) )

    if not Upvalue14 or Upvalue14.box ~= Health then
        Upvalue14 = { box = Health, text = Health.Value.TextColor3, armor = false }
    end

    local Armor2 = Max > 0 and true or false

    if Upvalue14.armor ~= Armor2 then
        local ArmorColor2
        Upvalue14.armor = Armor2
        local ArmorColor = Health.Value:GetAttribute( "ArmorColor" )

        if typeof( ArmorColor ) == "Color3" then
            ArmorColor2 = ArmorColor
        else
            local Fill4

            if Value1 then
                Fill4 = Value1:FindFirstChild( "Fill" )
            else
                Fill4 = Value1
            end

            local BackgroundColor3 = Fill4 and Fill4.BackgroundColor3 or Upvalue15
            ArmorColor2 = BackgroundColor3
        end

        local TextColor3
        local Value2 = Health.Value
        TextColor3 = if not Armor2 or not ArmorColor2 then Upvalue14.text else ArmorColor2
        Value2.TextColor3 = TextColor3
    end
end

local Visible2
local StaminaMax = Upvalue3.StaminaMax or 150
Upvalue16 = Upvalue16 + ( math.clamp( ( Upvalue3.Stamina or StaminaMax ) / StaminaMax, 0, 1 ) - Upvalue16 ) * ( 1 - math.exp( -20 * Amount2 ) )
Visible2 = Upvalue3.Exhausted == true and true or false
local EDrinkUntil3
local EDrinkUntil = Character:GetAttribute( "EDrinkUntil" )

if EDrinkUntil then
    local EDrinkUntil2 = EDrinkUntil - workspace:GetServerTimeNow( )

    if EDrinkUntil2 then
        EDrinkUntil3 = EDrinkUntil2
    else
        EDrinkUntil3 = 0
    end
else
    EDrinkUntil3 = 0
end
if Stamina then
    local Flag

    if ( Upvalue3.Stamina or StaminaMax ) < StaminaMax - 0.01 then
        Flag = true
    elseif EDrinkUntil3 > 0 then
        Flag = true
    else
        Flag = false
    end

    local Icon2
    Upvalue10( Stamina, Flag, Clock, Amount2 )
    local Fill5 = Stamina.Bar.Fill
    Fill5.Size = UDim2.fromScale( Upvalue16, 1 )
    local Icon = Stamina:FindFirstChild( "Icon" )
    Icon2 = if not Icon or Icon:IsA( "ImageLabel" ) or Icon:IsA( "ImageButton" ) then Icon else nil

    if not Upvalue17 or Upvalue17.box ~= Stamina then
        local Icon3
        local Table = {
            box = Stamina,
            fill = Stamina.Bar.Fill.BackgroundColor3,
            text = Stamina.Value.TextColor3,
            boost = false
        }
        Icon3 = if Icon2 then Icon2.ImageColor3 else Icon2
        Table.icon = Icon3
        Upvalue17 = Table
    end

    local Boost = EDrinkUntil3 > 0 and true or false

    if Upvalue17.boost ~= Boost then
        local EDrinkColor2
        Upvalue17.boost = Boost
        local EDrinkColor = Stamina.Bar.Fill:GetAttribute( "EDrinkColor" )
        EDrinkColor2 = if typeof( EDrinkColor ) == "Color3" then EDrinkColor else Upvalue18
        local BackgroundColor32
        local Fill6 = Stamina.Bar.Fill
        BackgroundColor32 = if not Boost or not EDrinkColor2 then Upvalue17.fill else EDrinkColor2
        local TextColor32
        Fill6.BackgroundColor3 = BackgroundColor32
        local Value3 = Stamina.Value
        TextColor32 = if not Boost or not EDrinkColor2 then Upvalue17.text else EDrinkColor2
        Value3.TextColor3 = TextColor32

        if Icon2 and Upvalue17.icon then
            local EDrinkColor4
            local EDrinkColor3 = Icon2:GetAttribute( "EDrinkColor" )
            EDrinkColor4 = if typeof( EDrinkColor3 ) == "Color3" then EDrinkColor3 else EDrinkColor2
            local ImageColor3 = if not Boost or not EDrinkColor4 then Upvalue17.icon else EDrinkColor4
            Icon2.ImageColor3 = ImageColor3
        end
    end

    local Text
    Stamina.Bar.Mark.Visible = Visible2
    local Mark = Stamina.Bar.Mark
    Mark.Position = UDim2.fromScale( ( Upvalue3.StaminaResprint or 20 ) / StaminaMax, 0 )
    local Value4 = Stamina.Value

    if EDrinkUntil3 > 0 then
        local Format = ( "%ds" ):format( ( math.ceil( EDrinkUntil3 ) ) )

        if Format then
            Text = Format
        else
            Text = tostring( ( math.floor( Upvalue3.Stamina or StaminaMax ) ) )
        end
    else
        Text = tostring( ( math.floor( Upvalue3.Stamina or StaminaMax ) ) )
    end

    Value4.Text = Text
end

local HealItem2
local HealItem = Upvalue3.HealItem
HealItem2 = if HealItem then Upvalue19.Items[ HealItem ] else HealItem
local HealDenied2
local HealDenied = Upvalue3.HealDenied

if HealDenied then
    if Clock - Upvalue3.HealDenied < 1.2 then
        HealDenied2 = true
    else
        HealDenied2 = false
    end
else
    HealDenied2 = HealDenied
end

local Visible3

if HealItem2 == nil then
    if HealDenied2 == true then
        Visible3 = true
    else
        Visible3 = false
    end
else
    Visible3 = true
end

local Visible4
Upvalue20.Visible = Visible3
Visible4 = HealItem2 ~= nil and true or false
Upvalue21.Visible = Visible4

if HealItem2 then
    local Armor4
    local Clamp3 = math.clamp( ( Clock - Upvalue3.HealStart ) / HealItem2.Time, 0, 1 )
    local Upper = string.upper( HealItem2.DisplayName )
    local Armor3 = HealItem2.Armor
    Armor4 = if Armor3 then Armor3 else HealItem2.Amount
    local BackgroundColor33
    Upvalue22.Text = Upper .. "  +" .. Armor4
    BackgroundColor33 = HealItem2.Armor and Upvalue15 or Upvalue24
    Upvalue23.BackgroundColor3 = BackgroundColor33
    Upvalue23.Size = UDim2.fromScale( Clamp3, 1 )
    return
end
if HealDenied2 then
    Upvalue22.Text = Upvalue3.HealDeniedText or "HEALTH FULL"
end

return
]]
