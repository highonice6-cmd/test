-- ReplicatedStorage.GamePasses
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local MarketplaceService = game:GetService( "MarketplaceService" )
local Table = {
    List = {
        {
            id = "SkipRolls",
            PassId = 2040634923,
            Attr = "SkipRolls",
            GiftProduct = 3720365490,
            Name = "Skip Animations"
        },
        {
            id = "Crew",
            PassId = 2037803497,
            Attr = "CrewPass",
            GiftProduct = 3720489944,
            Name = "Crew Create"
        },
        {
            id = "CrewClan",
            PassId = 2053769106,
            Attr = "CrewClanPass",
            Grants = { "CrewPass", "ClanPass" },
            GiftProduct = 3721731560,
            Name = "Crew + Clan",
            Clans = true,
            Alt = "Clan"
        },
        {
            id = "Clan",
            PassId = 2054267054,
            Attr = "ClanPass",
            GiftProduct = 3721731376,
            Name = "Clan",
            Clans = true,
            Card = false
        },
        {
            id = "StarterPack",
            PassId = 2041604814,
            Attr = "StarterPackOwned",
            GiftProduct = 0,
            Name = "Starter Pack",
            Card = false
        },
        {
            id = "StashPlus",
            PassId = 2060765103,
            Attr = "StashPlus",
            GiftProduct = 0,
            Name = "Safe +10 slots",
            Card = false,
            Product = 3723975699,
            Base = 50,
            Step = 10,
            MaxSlots = 100
        }
    },
    ById = { },
    ByProduct = { },
    ByPassId = { }
}
local List = Table.List
Value1 = nil

for Key, Value in List, nil, nil do
    local ById = Table.ById
    ById[ Value.id ] = Value
    local ByPassId = Table.ByPassId
    ByPassId[ Value.PassId ] = Value

    if ( Value.GiftProduct or 0 ) > 0 then
        local ByProduct = Table.ByProduct
        ByProduct[ Value.GiftProduct ] = Value
    end
end

function Table.Find( Key )
    return Table.ById[ Key ]
end
function Table.SafeSize( Object )
    local Flag
    local StashPlus = Table.ById.StashPlus
    Flag = typeof( Object ) == "Instance" and true or false
    local Number2 = ( not Flag or Object:GetAttribute( "StashPlus" ) ~= true ) and 0 or 1
    local Number3

    if Flag then
        local Number = tonumber( Object:GetAttribute( "StashPacks" ) )

        if Number then
            Number3 = Number
        else
            Number3 = 0
        end
    else
        Number3 = 0
    end

    local Number4 = Number2 + Number3
    local MaxSlots = StashPlus.MaxSlots
    return ( math.min( MaxSlots, StashPlus.Base + StashPlus.Step * math.max( 0, ( math.floor( Number4 ) ) ) ) )
end
local Table2 = { }
function Table.Owned( Object, Key )
    local Entry = Table.ById[ Key ]

    if not Entry or not Object then
        return false
    end
    if Object:GetAttribute( Entry.Attr ) == true or Table2[ Key ] == true then
        return true
    end
    if not Entry.Grants or not ( #Entry.Grants > 0 ) then
        return false
    end

    local Value1
    local Grants = Entry.Grants
    Value1 = nil

    for Key2, Value in Grants, nil, nil do
        if Object:GetAttribute( Value ) ~= true then
            return false
        end
    end

    return true
end
local BindableEvent = Instance.new( "BindableEvent" )
Table.Changed = BindableEvent.Event

if RunService:IsClient( ) then
    local Value2
    local LocalPlayer = Players.LocalPlayer
    local List2 = Table.List
    Value2 = nil

    for Key2, Value3 in List2, nil, nil do
        local Grants2
        LocalPlayer:GetAttributeChangedSignal( Value3.Attr ):Connect( function()
            BindableEvent:Fire( Value3.id )
        end )
        local Grants = Value3.Grants
        Grants2 = if Grants then Grants else { }
        local Value5 = nil

        for Key3, Value6 in Grants2, nil, nil do
            LocalPlayer:GetAttributeChangedSignal( Value6 ):Connect( function()
                BindableEvent:Fire( Value3.id )
            end )
        end
    end

    local Char = utf8.char( 57346 )
    local Table3 = { }
    local Table4 = { }

    local function Commas( Argument1 )
        local Sub
        local Reverse = tostring( ( math.floor( Argument1 ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( )
        Sub = Reverse:sub( 1, 1 ) == "," and Reverse:sub( 2 ) or Reverse
        return Sub
    end

    function Table.PriceText( TextName, TextName2 )
        local Entry = Table.ById[ TextName ]

        if not Entry or ( Entry.PassId or 0 ) <= 0 then
            return ""
        end

        local Entry2 = Table3[ TextName ]

        if type( Entry2 ) == "number" then
            return Char .. " " .. Commas( Entry2 )
        end
        if TextName2 then
            local Entry4
            local Entry3 = Table4[ TextName ]
            Entry4 = if Entry3 then Entry3 else { }
            Table4[ TextName ] = Entry4
            Table4[ TextName ][ TextName2 ] = true
        end
        if Entry2 == nil then
            Table3[ TextName ] = false
            task.spawn( function()
                local Result, Success2
                local I = 1
                Success2 = nil
                Result = nil

                for I = 1, 3 do
                    local GetProductInfo = MarketplaceService.GetProductInfo
                    Success, Result = pcall( GetProductInfo, MarketplaceService, Entry.PassId, Enum.InfoType.GamePass )

                    if Success then
                        Success2 = Success
                        break
                    end

                    task.wait( I * 2 )
                    Success2 = Success
                end

                local Number2

                if not Success2 or not Result then
                    Number2 = nil
                else
                    local Number = tonumber( Result.PriceInRobux )

                    if Number then
                        Number2 = Number
                    else
                        Number2 = nil
                    end
                end

                local Entry2
                Table3[ TextName ] = Number2
                local EntryInner = Table4[ TextName ]
                Table4[ TextName ] = nil
                Entry2 = if EntryInner then EntryInner else { }
                local Value1 = nil

                for Value in Entry2, nil, nil do
                    task.spawn( Value )
                end
            end )
        end

        return "..."
    end
    local Value4 = nil
    local Table5 = { }
    function Table.Offer( Key, Callback )
        local Entry = Table.ById[ Key ]

        if not Entry then
            return
        end
        if Table.Owned( LocalPlayer, Key ) then
            if Callback then
                task.spawn( Callback )
            end

            return
        end
        if ( Entry.PassId or 0 ) <= 0 then
            return false
        end

        local Entry3
        local Entry2 = Table5[ Entry.PassId ]

        if Entry2 then
            Entry3 = Entry2
        else
            local TableInner = { }
            Table5[ Entry.PassId ] = TableInner
            Entry3 = TableInner
        end
        if Callback then
            table.insert( Entry3, Callback )
        end

        Value4 = Value4 or require( game:GetService( "ReplicatedStorage" ):WaitForChild( "GamepadNav" ) )
        Value4.Prompt( function()
            MarketplaceService:PromptGamePassPurchase( LocalPlayer, Entry.PassId )
        end )
        return
    end
    MarketplaceService.PromptGamePassPurchaseFinished:Connect( function( Argument1, Key, Argument3 )
        if Argument1 ~= LocalPlayer then
            return
        end

        local Entry = Table5[ Key ]
        Table5[ Key ] = nil
        local Entry2 = Table.ByPassId[ Key ]

        if not Argument3 or not Entry2 then
            return
        end

        local Entry3
        Table2[ Entry2.id ] = true
        BindableEvent:Fire( Entry2.id )
        Entry3 = if Entry then Entry else { }
        local Value1 = nil

        for Key2, Value in Entry3, nil, nil do
            task.spawn( Value )
        end
    end )
end

return Table
