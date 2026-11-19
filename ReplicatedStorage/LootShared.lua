-- ReplicatedStorage.LootShared
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ItemRender = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ItemRender" ) )
local ExtraItems = require( ReplicatedStorage:WaitForChild( "ExtraItems" ) )
local Table = {
    TAG = "GroundLoot",
    LIFETIME = 180,
    MAX_ITEMS = 150,
    FLOAT = 0.9,
    GROUND_SCALE = {
        Shovel = 0.7,
        Bandage = 1.9,
        Bayonneta = 1.4,
        BrassKnuckle = 3,
        CashBag500K = 1.6,
        CashBag1M = 1.6,
        CashBag3M = 1.6,
        CashBag5M = 1.6
    },
    PICK_RADIUS = 3,
    PICK_RANGE = 8,
    SLOTS = 18,
    Aura = script:WaitForChild( "Aura" ),
    PROTECT_SLOTS = 3,
    PROTECTED = "Protected"
}
function Table.IsProtected( Object )
    local Flag

    if Object == nil then
        Flag = false
    elseif Object:GetAttribute( Table.PROTECTED ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
Table.COLORS = {
    common = Color3.fromRGB( 150, 150, 165 ),
    uncommon = Color3.fromRGB( 70, 200, 95 ),
    rare = Color3.fromRGB( 45, 125, 220 ),
    epic = Color3.fromRGB( 165, 70, 225 ),
    legendary = Color3.fromRGB( 240, 180, 45 ),
    mythical = Color3.fromRGB( 225, 45, 60 ),
    secret = Color3.fromRGB( 215, 218, 230 )
}
function Table.Rarity( Key )
    local Entry2
    local Entry = ItemRender.RARITY[ Key ]
    Entry2 = ( Entry == "super" or Entry == "secret" ) and "mythical" or Entry
    local Entry3 = ( not Table.COLORS[ Entry2 ] or not Entry2 ) and "common" or Entry2
    return Entry3
end
function Table.Tier( Key )
    if ItemRender.RARITY[ Key ] == "secret" then
        return "secret"
    end
    return Table.Rarity( Key )
end
function Table.Color( Argument1 )
    return Table.COLORS[ Table.Tier( Argument1 ) ]
end
function Table.KindKey( Self )
    if not Self:IsA( "Tool" ) then
        return nil
    end

    local Weapon = Self:GetAttribute( "Weapon" )

    if Weapon then
        return "W", Weapon
    end

    local Melee = Self:GetAttribute( "Melee" )

    if Melee then
        return "M", Melee
    end

    local Item = Self:GetAttribute( "Item" )

    if Item then
        return "I", Item
    end
    return nil
end
function Table.Droppable( Object )
    local Flag

    if Table.KindKey( Object ) == nil then
        Flag = false
    else
        local NotUnbreakable = not Object:GetAttribute( "Unbreakable" )

        if NotUnbreakable then
            local NotAdminTest = not Object:GetAttribute( "AdminTest" )

            if NotAdminTest then
                local NotBetaLent = not Object:GetAttribute( "BetaLent" )

                if NotBetaLent then
                    if Object:GetAttribute( "Vehicle" ) == nil then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = NotBetaLent
                end
            else
                Flag = NotAdminTest
            end
        else
            Flag = NotUnbreakable
        end
    end

    return Flag
end
Table.STACK = {
    Bandage = 10,
    Medkit = 5,
    EDrink = 10,
    Kevlar = 3,
    CashBag500K = 1,
    CashBag1M = 1,
    CashBag3M = 1,
    CashBag5M = 1
}
Table.CASH_BAGS = {
    CashBag500K = 200000,
    CashBag1M = 500000,
    CashBag3M = 800000,
    CashBag5M = 1200000
}
function Table.LosableEntry( EntryName, EntryName2 )
    if EntryName == "I" then
        local Flag = Table.CASH_BAGS[ EntryName2 ] ~= nil and true or false
        return Flag
    end
    local Flag2

    if EntryName == "W" or EntryName == "M" then
        if Table.Rarity( EntryName2 ) == "mythical" then
            Flag2 = true
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end

    return Flag2
end
function Table.Losable( Argument1 )
    if not Table.Droppable( Argument1 ) or Table.IsProtected( Argument1 ) then
        return false
    end
    return Table.LosableEntry( Table.KindKey( Argument1 ) )
end
function Table.StackMax( MaxName )
    local Get = ExtraItems.Get( MaxName )

    if not Get or type( Get.Stack ) ~= "number" then
        return Table.STACK[ MaxName ] or 10
    end
    return ( math.max( 1, ( math.floor( Get.Stack ) ) ) )
end
function Table.DropOnDeathEntry( EntryName, Argument2 )
    local Flag

    if EntryName == "I" then
        Flag = ExtraItems.Flag( Argument2, "DropOnDeath" )
    else
        Flag = false
    end

    return Flag
end
function Table.GroundDropEntry( EntryName, Argument2 )
    local Flag

    if EntryName == "I" then
        Flag = ExtraItems.Flag( Argument2, "GroundDrop" )
    else
        Flag = false
    end

    return Flag
end
function Table.NoProtect( Argument1 )
    local Flag
    local KindKey, KindKey2 = Table.KindKey( Argument1 )

    if KindKey == "I" then
        Flag = ExtraItems.Flag( KindKey2, "NoProtect" )
    else
        Flag = false
    end

    return Flag
end
function Table.UsedSlots( Self )
    local Value1, Number
    local TableInner = { Self:FindFirstChildOfClass( "Backpack" ), Self.Character }
    Value1 = nil
    Number = 0

    for Key, Value in TableInner, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value2 = nil

        for Key2, Value3 in Children, nil, nil do
            if Value3:IsA( "Tool" ) then
                if Table.KindKey( Value3 ) or Value3:GetAttribute( "Vehicle" ) or Value3:GetAttribute( "Gear" ) then
                    if not Table.IsProtected( Value3 ) then
                        Number = Number + 1
                    end
                end
            end
        end
    end

    return Number
end

local function ItemStacks( Self, Argument2 )
    local Value1
    local TableInner = { }
    local Table2 = { Self:FindFirstChildOfClass( "Backpack" ), Self.Character }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value2 = nil

        for Key2, Value3 in Children, nil, nil do
            if Value3:IsA( "Tool" ) and Value3:GetAttribute( "Item" ) == Argument2 and not Table.IsProtected( Value3 ) then
                table.insert( TableInner, Value3 )
            end
        end
    end

    return TableInner
end

function Table.ItemRoom( Self, Argument2, Amount )
    local Number
    local StackMax = Table.StackMax( Argument2 )
    Number = 0

    for Key, Value in ItemStacks( Self, Argument2 ) do
        Number = Number + math.max( 0, StackMax - ( tonumber( Value:GetAttribute( "Count" ) ) or 1 ) )
    end

    return Number + math.max( 0, Table.SLOTS - Table.UsedSlots( Self ) + ( Amount or 0 ) ) * StackMax
end
function Table.ApplyData( Tool, Argument2 )
    local Number2

    if type( Argument2 ) == "table" then
        local Number = tonumber( Argument2.Kg )

        if Number then
            Number2 = Number
        else
            Number2 = nil
        end
    else
        Number2 = nil
    end
    if not Number2 or Number2 <= 0 or Number2 ~= Number2 then
        return
    end

    Tool:SetAttribute( "Kg", Number2 )
    local Number3 = tonumber( Tool:GetAttribute( "KgRef" ) )
    local Handle = Tool:FindFirstChild( "Handle" )

    if Number3 and Number3 > 0 and Handle and Handle:IsA( "BasePart" ) then
        local Clamp = math.clamp( ( Number2 / Number3 ) ^ 0.3333333333333333, 0.2, 5 )
        Handle.Size = Handle.Size * Clamp
        Tool.Grip = CFrame.new( Tool.Grip.Position * Clamp ) * Tool.Grip.Rotation
    end
end
function Table.Unique( Argument1 )
    return ExtraItems.Flag( Argument1, "Unique" )
end
function Table.WeightText( Text )
    local Number = tonumber( Text )

    if not Number then
        return ""
    end
    if Number < 10 then
        return string.format( "%.2f kg", Number )
    end
    if Number < 100 then
        return string.format( "%.1f kg", Number )
    end

    local Sub
    local Reverse = tostring( ( math.floor( Number + 0.5 ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( )

    if Reverse:sub( 1, 1 ) == "," then
        Sub = Reverse:sub( 2 )
    else
        Sub = Reverse
    end

    return Sub .. " kg"
end
function Table.AddItems( Self, Argument2, Text, Argument4 )
    local Unique
    local Max = math.max( 0, ( math.floor( tonumber( Text ) or 0 ) ) )
    local StackMax = Table.StackMax( Argument2 )

    if type( Argument4 ) ~= "table" or Argument4.Kg == nil then
        Unique = Table.Unique( Argument2 )
    else
        Unique = true
    end

    local TableInner

    if not Unique or not { } then
        TableInner = ItemStacks( Self, Argument2 )
    else
        TableInner = { }
    end

    local Value1 = nil

    for Key, Value in TableInner, nil, nil do
        if Max <= 0 then
            break
        end

        local Number = tonumber( Value:GetAttribute( "Count" ) ) or 1
        local Min = math.min( Max, StackMax - Number )

        if Min > 0 then
            Value:SetAttribute( "Count", Number + Min )
            Max = Max - Min
        end
    end

    local Template = Table.Template( "I", Argument2 )
    local Parent = Self:FindFirstChildOfClass( "Backpack" )

    while Max > 0 do
        if not Template or not Parent or not ( Table.UsedSlots( Self ) < Table.SLOTS ) then
            break
        end

        local Min2

        if Unique then
            Min2 = 1
        else
            Min2 = math.min( Max, StackMax )
        end

        local Clone = Template:Clone( )
        Clone:SetAttribute( "Slot", nil )
        Clone:SetAttribute( "Count", Min2 )
        Table.ApplyData( Clone, Argument4 )
        Clone.Parent = Parent
        Max = Max - Min2
    end

    return Max
end
local Table2 = { W = "Weapon", M = "Melee", I = "Item" }
function Table.Template( Key, Argument2 )
    local Entry = Table2[ Key ]

    if not Entry then
        return nil
    end

    local Value1
    local Table = {
        ReplicatedStorage:FindFirstChild( "BetaRollWeapons" ),
        game:GetService( "StarterPack" )
    }
    Value1 = nil

    for Key2, Value in Table, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value2 = nil

        for Key3, Value3 in Children, nil, nil do
            if Value3:IsA( "Tool" ) then
                if Value3:GetAttribute( Entry ) == Argument2 then
                    return Value3
                end
            end
        end
    end

    return nil
end
Table.COPY = "CopyId"
function Table.NewCopyId()
    return game:GetService( "HttpService" ):GenerateGUID( false )
end
function Table.Twin( Object, Object2 )
    local StarterGear

    if Object then
        StarterGear = Object:FindFirstChild( "StarterGear" )
    else
        StarterGear = Object
    end
    if not StarterGear or not Object2 or Object2.Parent == StarterGear then
        return nil
    end

    local KindKey, KindKey2 = Table.KindKey( Object2 )

    if not KindKey or KindKey == "I" then
        return nil
    end

    local Attribute = Object2:GetAttribute( Table.COPY )

    for Key, Value in StarterGear:GetChildren( ) do
        local KindKey3, KindKey22 = Table.KindKey( Value )

        if Value ~= Object2 and KindKey3 == KindKey and KindKey22 == KindKey2 then
            if Value:GetAttribute( Table.COPY ) == Attribute then
                return Value
            end
        end
    end

    return nil
end
function Table.GearOnly( Object )
    local StarterGear

    if Object then
        StarterGear = Object:FindFirstChild( "StarterGear" )
    else
        StarterGear = Object
    end
    if not StarterGear then
        return { }
    end

    local Value1
    local TableInner = { }
    local Table2 = { Object.Character, Object:FindFirstChildOfClass( "Backpack" ) }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value3 = nil

        for Key3, Value4 in Children, nil, nil do
            local Twin
            local IsA = Value4:IsA( "Tool" )

            if IsA then
                Twin = Table.Twin( Object, Value4 )
            else
                Twin = IsA
            end
            if Twin then
                TableInner[ Twin ] = true
            end
        end
    end

    local Table3 = { }

    for Key2, Value2 in StarterGear:GetChildren( ) do
        if Value2:IsA( "Tool" ) and not TableInner[ Value2 ] and Table.KindKey( Value2 ) then
            table.insert( Table3, Value2 )
        end
    end

    return Table3
end
function Table.GiveCopy( Self, Object )
    local Parent = Self:FindFirstChildOfClass( "Backpack" )

    if not Parent then
        return nil
    end

    Object:SetAttribute( Table.COPY, Table.NewCopyId( ) )
    local Parent2 = Self:FindFirstChild( "StarterGear" )

    if Parent2 then
        Object:Clone( ).Parent = Parent2
    end

    Object.Parent = Parent
    return Object
end
return Table
