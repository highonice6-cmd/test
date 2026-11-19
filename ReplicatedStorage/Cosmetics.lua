-- ReplicatedStorage.Cosmetics
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local KillEffects = require( ReplicatedStorage:WaitForChild( "KillEffects" ) )
local KillMessages = require( ReplicatedStorage:WaitForChild( "KillMessages" ) )
local Table = {
    AdminsOwnAll = true,
    AllFree = false,
    Categories = {
        { id = "KillFX", name = "Kill Effects", Attribute = "KillFX" },
        { id = "Tracer", name = "Tracers", Attribute = "TracerFX" },
        { id = "Sky", name = "Sky", Attribute = "SkyFX" },
        { id = "KillMsg", name = "Kill Screen", Attribute = "KillMsg" }
    },
    ById = { }
}
local Categories = Table.Categories
Value1 = nil

for Key, Value in Categories, nil, nil do
    local ById = Table.ById
    ById[ Value.id ] = Value
end

local Value2
Table.Items = { KillFX = { }, Tracer = { }, Sky = { }, KillMsg = { } }
local Order = KillEffects.Order
Value2 = nil

for Key2, Value3 in Order, nil, nil do
    local Entry = KillEffects.Effects[ Value3 ]
    local KillFX = Table.Items.KillFX
    table.insert( KillFX, {
        id = Value3,
        name = Entry.Name or Value3,
        PassId = Entry.PassId or 0,
        Free = Entry.Free,
        Color = Entry.Color,
        Icon = Entry.Icon,
        Anim = Entry.Anim
    } )
end

local Value4
local Items = Table.Items
Items.Tracer = {
    {
        id = "Data",
        name = "Data",
        PassId = 0,
        Color = Color3.fromRGB( 76, 193, 26 ),
        Template = "Tracers.Data",
        StreakColor = Color3.fromRGB( 120, 255, 90 ),
        StreakOutline = Color3.fromRGB( 0, 0, 0 )
    },
    {
        id = "Void",
        name = "Void",
        PassId = 0,
        Color = Color3.fromRGB( 150, 90, 255 ),
        Template = "Tracers.Void",
        StreakColor = Color3.fromRGB( 255, 255, 255 ),
        StreakOutline = Color3.fromRGB( 0, 0, 0 )
    },
    {
        id = "Halloween",
        name = "Halloween",
        PassId = 0,
        Color = Color3.fromRGB( 255, 120, 20 ),
        Template = "Tracers.Halloween"
    },
    {
        id = "Blue",
        name = "Blue",
        PassId = 0,
        Color = Color3.fromRGB( 40, 130, 255 )
    },
    {
        id = "Purple",
        name = "Purple",
        PassId = 0,
        Color = Color3.fromRGB( 160, 70, 255 )
    },
    {
        id = "Red",
        name = "Red",
        PassId = 0,
        Color = Color3.fromRGB( 255, 45, 45 )
    },
    {
        id = "Green",
        name = "Green",
        PassId = 0,
        Color = Color3.fromRGB( 40, 230, 80 )
    },
    {
        id = "Pink",
        name = "Pink",
        PassId = 0,
        Color = Color3.fromRGB( 255, 80, 190 )
    },
    {
        id = "Yellow",
        name = "Yellow",
        PassId = 0,
        Color = Color3.fromRGB( 255, 225, 40 )
    }
}
local Tracer = Table.Items.Tracer
table.insert( Tracer, 1, {
    id = "Bubble",
    name = "Bubble",
    PassId = 0,
    Color = Color3.fromRGB( 90, 180, 255 ),
    Template = "Tracers.Bubble",
    StreakColor = Color3.fromRGB( 150, 215, 255 ),
    StreakOutline = Color3.fromRGB( 20, 70, 160 )
} )
local Children = ReplicatedStorage:WaitForChild( "Skies" ):GetChildren( )
table.sort( Children, function( Self, Object )
    local Order = Self:GetAttribute( "Order" ) or 99
    local Order2 = Object:GetAttribute( "Order" ) or 99

    if Order == Order2 then
        local Flag2 = Self.Name < Object.Name and true or false
        return Flag2
    end
    local Flag = Order < Order2 and true or false
    return Flag
end )
Value4 = nil

for Key3, Value5 in Children, nil, nil do
    if Value5:IsA( "Configuration" ) or Value5:IsA( "Sky" ) then
        local Name
        local Sky = Table.Items.Sky
        local Table2 = { id = Value5.Name }
        local DisplayName = Value5:GetAttribute( "DisplayName" )
        Name = if DisplayName then DisplayName else Value5.Name
        Table2.name = Name
        Table2.PassId = Value5:GetAttribute( "PassId" ) or 0
        Table2.Free = Value5:GetAttribute( "Free" )
        Table2.Color = Value5:GetAttribute( "Color" )
        Table2.Icon = Value5:GetAttribute( "Icon" )
        table.insert( Sky, Table2 )
    end
end

local Value6
local LIST = KillMessages.LIST
Value6 = nil

for Key4, Value7 in LIST, nil, nil do
    if Value7.id ~= KillMessages.DEFAULT then
        local KillMsg = Table.Items.KillMsg
        table.insert( KillMsg, {
            id = Value7.id,
            name = Value7.en,
            PassId = Value7.PassId or 0,
            Free = Value7.Free,
            Color = Value7.color,
            Message = true
        } )
    end
end

local Value8
Table.KillFXProducts = {
    Stars = 3720342855,
    Fire = 3720342836,
    Cash = 3720342803,
    Rainbow = 3720342769,
    Butterflies = 3720342748,
    Hearts = 3720342686,
    Water = 3720342642,
    Aura = 3720342593,
    Red = 3720342551,
    Explosion = 3720342520,
    LaunchedFirework = 3720342467,
    Fireworks = 3720342410
}
Table.CategoryProducts = { Tracer = 3720343329, Sky = 3720343493, KillMsg = 3720343606 }
local Items2 = Table.Items
Value8 = nil

for Key5, Value9 in Items2, nil, nil do
    local Value14 = nil

    for Key8, Value15 in Value9, nil, nil do
        if Key5 == "KillFX" then
            Value15.ProductId = Table.KillFXProducts[ Value15.id ]
        else
            local Shared2
            Value15.ProductId = Table.CategoryProducts[ Key5 ]
            Shared2 = Value15.ProductId ~= nil and true or false
            Value15.Shared = Shared2
        end
    end
end

local Value10
function Table.Find( Key, Argument2 )
    local Entry2
    local Entry = Table.Items[ Key ]
    Entry2 = if Entry then Entry else { }
    local Value1 = nil

    for Key2, Value in Entry2, nil, nil do
        if Value.id == Argument2 then
            return Value
        end
    end

    return nil
end
local List = require( ReplicatedStorage:WaitForChild( "LimitedPacks" ) ).List
Value10 = nil

for Key6, Value11 in List, nil, nil do
    local Value12
    local Items3 = Value11.Items
    Value12 = nil

    for Key7, Value13 in Items3, nil, nil do
        local Find = Table.Find( Value13.cat, Value13.item )

        if Find then
            Find.Pack = Value11.id

            if Value13.Shared then
                local Shared
                Find.ProductId = Table.CategoryProducts[ Value13.cat ]
                Shared = if Find.ProductId == nil then nil else true
                Find.Shared = Shared
            else
                Find.ProductId = Value13.ProductId
                Find.Shared = nil
            end
        end
    end
end

return Table
