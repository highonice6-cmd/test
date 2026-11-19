-- ReplicatedStorage.LimitedPacks
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local IsStudio = game:GetService( "RunService" ):IsStudio( )
local Table = {
    List = {
        {
            id = "Bubble",
            Event = "BubbleOn",
            Name = "Bubble Pack",
            ProductId = 3730917405,
            Tiers = {
                3730917634,
                3730917595,
                3730917568,
                3730917536,
                3730917506,
                3730917457
            },
            CCFree = true,
            EndsAt = 1795388400,
            Icon = "rbxassetid://101997125083564",
            Color = Color3.fromRGB( 90, 180, 255 ),
            Items = {
                { cat = "KillFX", item = "Bubbles", ProductId = 3730917107 },
                { cat = "Tracer", item = "Bubble", ProductId = 3730916859 },
                { cat = "KillMsg", item = "Blobbed", Shared = true },
                {
                    cat = "BodySkin",
                    item = "Diver",
                    ProductId = 3730917157,
                    Name = "Diver Suit"
                },
                {
                    cat = "Skin",
                    item = "Bubble",
                    ProductId = 3730917246,
                    Name = "M4 Bubble Skin"
                },
                {
                    cat = "ShotSound",
                    item = "Bubble",
                    ProductId = 3730917325,
                    Name = "Bubble Gun Sound"
                }
            }
        },
        {
            id = "Data",
            Event = "DataPack",
            Name = "Data Pack",
            ProductId = 3729469263,
            Tiers = { 3729469767, 3729483392, 3729469947, 3729469854 },
            CCFree = true,
            EndsAt = 1794805200,
            Icon = "rbxassetid://105998431045141",
            Color = Color3.fromRGB( 76, 193, 26 ),
            Items = {
                { cat = "KillFX", item = "Data", ProductId = 3729482720 },
                { cat = "Tracer", item = "Data", Shared = true },
                { cat = "KillMsg", item = "DataCorrupted", Shared = true },
                { cat = "Sky", item = "DataSky", Shared = true },
                { cat = "BodySkin", item = "Data", ProductId = 3729469447 },
                { cat = "Skin", item = "Data" }
            }
        },
        {
            id = "Void",
            Event = "VoidPack",
            Name = "Void Pack",
            ProductId = 3726850889,
            Tiers = { 3726853446, 3726856756, 3726857225 },
            CCFree = true,
            EndsAt = 1794200400,
            Icon = "rbxassetid://93963439522549",
            Color = Color3.fromRGB( 150, 90, 255 ),
            Items = {
                { cat = "KillFX", item = "DarkMatter", ProductId = 3726741475 },
                { cat = "Tracer", item = "Void", Shared = true },
                { cat = "KillMsg", item = "IntoTheVoid", Shared = true },
                { cat = "Sky", item = "VoidSky", Shared = true },
                { cat = "BodySkin", item = "Void", ProductId = 3726856008 },
                { cat = "Skin", item = "Void" }
            }
        },
        {
            id = "Halloween",
            Event = "HalloweenEvent",
            Name = "Halloween Pack",
            ProductId = 3721935633,
            EndsAt = 1793660400,
            Icon = "rbxassetid://84929620843289",
            Color = Color3.fromRGB( 255, 120, 20 ),
            Items = {
                { cat = "KillFX", item = "Halloween", ProductId = 3722337500 },
                { cat = "Tracer", item = "Halloween", Shared = true },
                { cat = "KillMsg", item = "SoulClaimed", Shared = true },
                { cat = "Sky", item = "HalloweenSky", Shared = true },
                { cat = "Skin", item = "Hellspawn" }
            }
        }
    },
    ById = { }
}
local List = Table.List
Value1 = nil

for Key, Value in List, nil, nil do
    local ById = Table.ById
    ById[ Value.id ] = Value
end

local function Get( Key )
    if type( Key ) == "string" then
        return Table.ById[ Key ]
    end
    return Key
end

function Table.Find( Key )
    return Table.ById[ Key ]
end
function Table.Now()
    return workspace:GetServerTimeNow( )
end
function Table.EndsAt( Key )
    local Entry

    if type( Key ) == "string" then
        Entry = Table.ById[ Key ]
    else
        Entry = Key
    end
    if not Entry then
        return 0
    end
    if IsStudio then
        local TestPackEndsAt = workspace:GetAttribute( "TestPackEndsAt" )

        if type( TestPackEndsAt ) == "number" then
            return TestPackEndsAt
        end
    end

    return Entry.EndsAt
end
function Table.IsOn( Key )
    local Entry

    if type( Key ) == "string" then
        Entry = Table.ById[ Key ]
    else
        Entry = Key
    end
    if not Entry then
        return false
    end
    if type( Entry.Event ) == "string" then
        local Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( Entry.Event ) == true and true or false
        return Flag
    end
    if workspace:GetAttribute( "TestPacksOn" ) == true then
        if IsStudio or game:GetService( "ReplicatedStorage" ):GetAttribute( "TeamTestOn" ) == true then
            return true
        end
    end

    local Flag2 = Entry.Enabled ~= false and true or false
    return Flag2
end
function Table.Active( Key )
    local Entry

    if type( Key ) == "string" then
        Entry = Table.ById[ Key ]
    else
        Entry = Key
    end

    local Flag

    if Entry == nil then
        Flag = false
    else
        local IsOn = Table.IsOn( Entry )

        if IsOn then
            if Table.Now( ) < Table.EndsAt( Entry ) then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = IsOn
        end
    end

    return Flag
end
function Table.TimeLeft( LeftName )
    local Entry

    if type( LeftName ) == "string" then
        Entry = Table.ById[ LeftName ]
    else
        Entry = LeftName
    end

    local Max2

    if Entry then
        local Max = math.max( 0, Table.EndsAt( Entry ) - Table.Now( ) )

        if Max then
            Max2 = Max
        else
            Max2 = 0
        end
    else
        Max2 = 0
    end

    return Max2
end
function Table.PackOf( Argument1, Argument2 )
    local Value1
    local List = Table.List
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Value2
        local Items = Value.Items
        Value2 = nil

        for Key2, Value3 in Items, nil, nil do
            if Value3.cat == Argument1 then
                if Value3.item == Argument2 then
                    return Value, Value3
                end
            end
        end
    end

    return nil
end
function Table.Format( Argument1 )
    local Max = math.max( 0, ( math.floor( Argument1 ) ) )
    local Max2 = Max // 86400
    local Max3 = Max // 3600 % 24
    local Max4 = Max // 60 % 60
    local Max5 = Max % 60

    if Max2 > 0 then
        return ( "%dd %02dh %02dm %02ds" ):format( Max2, Max3, Max4, Max5 )
    end
    if Max3 > 0 then
        return ( "%dh %02dm %02ds" ):format( Max3, Max4, Max5 )
    end
    return ( "%dm %02ds" ):format( Max4, Max5 )
end
return Table
