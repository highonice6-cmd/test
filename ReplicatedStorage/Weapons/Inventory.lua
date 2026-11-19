-- ReplicatedStorage.Weapons.Inventory
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local LootShared = require( ReplicatedStorage:WaitForChild( "LootShared" ) )
local Table = { HOTBAR = 5, FISTS = 1, BAG = 14 }
Table.TOTAL = Table.HOTBAR + Table.BAG
Table.Changed = Instance.new( "BindableEvent" )
Table.PROTECT = LootShared.PROTECT_SLOTS
Table.PROTECT_FIRST = Table.TOTAL + 1
Table.ALL = Table.TOTAL + Table.PROTECT
function Table.IsProtectedCase( Argument1 )
    local Flag

    if type( Argument1 ) == "number" then
        if Table.PROTECT_FIRST <= Argument1 then
            if Argument1 <= Table.ALL then
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

    return Flag
end
Table.IsProtected = LootShared.IsProtected
function Table.ZoneLocked()
    local Flag
    local LocalPlayer = Players.LocalPlayer
    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )
    local Character = LocalPlayer.Character

    if type( CombatUntil ) ~= "number" or not ( workspace:GetServerTimeNow( ) < CombatUntil ) then
        if Character == nil then
            Flag = false
        elseif Character:GetAttribute( "Downed" ) == true then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = true
    end

    return Flag
end
local Table2 = { }
local Class = setmetatable( { }, { __mode = "k" } )

local function AssignKeys( Keys )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Keys, nil, nil do
        local Entry = Class[ Value ]

        if not Entry or Table[ Entry ] then
            Class[ Value ] = nil
        else
            Table[ Entry ] = true
        end
    end

    local Value2 = nil

    for Key2, Value3 in Keys, nil, nil do
        if not Class[ Value3 ] then
            local Text2
            local Attribute = Value3:GetAttribute( LootShared.COPY )

            if Attribute == nil then
                Text2 = Value3.Name
            else
                local Name = Value3.Name
                local Text = Name .. "#" .. tostring( Attribute )

                if Text then
                    Text2 = Text
                else
                    Text2 = Value3.Name
                end
            end

            local Text3, Number
            Text3 = Text2
            Number = 1

            while Table[ Text3 ] do
                local Number2 = Number + 1
                Text3 = Text2 .. "#" .. Number2
                Number = Number2
            end

            Class[ Value3 ] = Text3
            Table[ Text3 ] = true
        end
    end
end

local function KeyOf( Key )
    local Entry2
    local Entry = Class[ Key ]
    Entry2 = if Entry then Entry else Key.Name
    return Entry2
end

local HttpService = game:GetService( "HttpService" )
local Value1 = nil
local Value2 = nil
local Value3 = nil
local Table3 = { }

local function ByName( List )
    local Value1
    local TableInner = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        if not Table.IsFixed( Value ) and not Table.IsProtected( Value ) then
            local Entry2
            local Name = Value.Name
            local Entry = TableInner[ Value.Name ]
            Entry2 = if Entry then Entry else { }
            TableInner[ Name ] = Entry2
            table.insert( TableInner[ Value.Name ], Value )
        end
    end

    local Value2 = nil

    for Key2, Value3 in TableInner, nil, nil do
        table.sort( Value3, function( Key, Key2 )
            local Entry3
            local Entry = Class[ Key ]
            Entry3 = if Entry then Entry else Key.Name
            local Entry4
            local Entry2 = Class[ Key2 ]
            Entry4 = if Entry2 then Entry2 else Key2.Name
            local Flag = Entry3 < Entry4 and true or false
            return Flag
        end )
    end

    return TableInner
end

local function InMatch()
    local Flag
    Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false
    return Flag
end

local Class2 = setmetatable( { }, { __mode = "k" } )
workspace:GetAttributeChangedSignal( "RankedMatch" ):Connect( function()
    local Flag
    table.clear( Table2 )
    table.clear( Table3 )
    table.clear( Class2 )
    Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false

    if Flag then
        Value1 = { }
    else
        Value1 = nil
        Value2 = nil
        Value3 = nil
    end

    Table.Changed:Fire( )
end )

local function ApplySaved( Saved )
    local Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false

    if Flag then
        Value1 = Value1 or { }
        return
    end
    if Value1 == nil then
        local InvLayout = Players.LocalPlayer:GetAttribute( "InvLayout" )

        if type( InvLayout ) ~= "string" then
            return
        end

        local Success, Result = pcall( HttpService.JSONDecode, HttpService, InvLayout )
        Value1 = { }
        Value2 = os.clock( )

        if Success and type( Result ) == "table" then
            local Value1Inner = nil

            for Key, Value in Result, nil, nil do
                local Number = tonumber( Key )

                if Number and type( Value ) == "string" then
                    Value1[ Number ] = Value
                end
            end
        end
    end
    if next( Value1 ) == nil then
        return
    end

    local Clock = os.clock( )

    if not Value3 and Players.LocalPlayer:GetAttribute( "CarriedBack" ) then
        Value3 = Clock
    end
    if Value3 and Clock - Value3 > 15 then
        table.clear( Value1 )
        return
    end
    if Value2 and Clock - Value2 > 60 then
        table.clear( Value1 )
        return
    end

    local Value3Inner
    local ByName2 = ByName( Saved )
    Value3Inner = nil

    for Key2, Value4 in Value1, nil, nil do
        local Match3
        local Match, Match2 = string.match( Value4, "^(.*)|(%d+)$" )
        Match3 = if Match then ByName2[ Match ] else Match
        local Match4 = if Match3 then Match3[ tonumber( Match2 ) ] else Match3

        if Match4 then
            local Value5 = nil

            for Key3, Value6 in Table2, nil, nil do
                if Value6 == Key2 and not Table3[ Key3 ] then
                    Table2[ Key3 ] = nil
                end
            end

            local Entry2
            local Entry = Class[ Match4 ]
            Entry2 = if Entry then Entry else Match4.Name
            local Entry4
            Table2[ Entry2 ] = Key2
            local Entry3 = Class[ Match4 ]
            Entry4 = if Entry3 then Entry3 else Match4.Name
            Table3[ Entry4 ] = true
            Value1[ Key2 ] = nil
        end
    end

    return
end

local Class3 = setmetatable( { }, { __mode = "k" } )
local Class4 = setmetatable( { }, { __mode = "k" } )

local function Watch( Key )
    if Class4[ Key ] then
        return
    end
    Class4[ Key ] = true
    Key:GetAttributeChangedSignal( "Slot" ):Connect( function()
        Class2[ Key ] = nil
    end )
    Key:GetAttributeChangedSignal( LootShared.PROTECTED ):Connect( function()
        local Entry = Class3[ Key ]
        Class3[ Key ] = nil

        if Entry and Table.IsProtectedCase( Entry ) == LootShared.IsProtected( Key ) then
            local Value1 = nil

            for KeyInner, Value in Table2, nil, nil do
                if Value == Entry then
                    Table2[ KeyInner ] = nil
                end
            end

            local Entry3
            local Entry2 = Class[ Key ]
            Entry3 = if Entry2 then Entry2 else Key.Name
            Table2[ Entry3 ] = Entry
        end

        Table.Changed:Fire( )
    end )
    return
end

Table.VEHICLE_CASES = { 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
local Table4 = {
    CheapCar = 1,
    [ "208" ] = 2,
    Cayen = 3,
    Challenger = 4,
    BM = 5,
    ArmoredVehicle = 6,
    Lambo = 7,
    Vette = 8
}
function Table.IsFixed( Object )
    local Flag

    if Object == nil then
        Flag = false
    elseif Object:GetAttribute( "Vehicle" ) == nil then
        Flag = false
    elseif ReplicatedStorage:GetAttribute( "CarsMovable" ) == true then
        Flag = false
    else
        Flag = true
    end

    return Flag
end
function Table.IsBroken( Object )
    local Flag

    if Object == nil then
        Flag = false
    elseif Object:GetAttribute( "Broken" ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
function Table.IsWeapon( Object )
    local Flag

    if Object == nil then
        Flag = false
    elseif Object:GetAttribute( "Weapon" ) == nil then
        if Object:GetAttribute( "Melee" ) == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = true
    end

    return Flag
end
function Table.WeaponRequired()
    local Flag = ReplicatedStorage:GetAttribute( "BarWeaponRequired" ) == true and true or false
    return Flag
end
function Table.Tools()
    local LocalPlayer = Players.LocalPlayer
    local Table = { }

    local function Add( Object )
        if not Object then
            return
        end
        for Key, Value in Object:GetChildren( ) do
            if Value:IsA( "Tool" ) then
                if Value:GetAttribute( "Weapon" ) or Value:GetAttribute( "Item" ) or Value:GetAttribute( "Melee" ) or Value:GetAttribute( "Vehicle" ) or Value:GetAttribute( "Gear" ) then
                    table.insert( Table, Value )
                end
            end
        end
    end

    Add( LocalPlayer:FindFirstChildOfClass( "Backpack" ) )
    Add( LocalPlayer.Character )
    return Table
end

local function InTuto()
    local Flag
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer == nil then
        Flag = false
    elseif LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function TutoLayout( List, Argument2 )
    table.sort( List, function( Key, Key2 )
        local Entry3
        local Entry = Class[ Key ]
        Entry3 = if Entry then Entry else Key.Name
        local Entry4
        local Entry2 = Class[ Key2 ]
        Entry4 = if Entry2 then Entry2 else Key2.Name
        local Flag = Entry3 < Entry4 and true or false
        return Flag
    end )
    local TableInner = { }
    local Table2 = { }

    local function Pick( Key, Callback )
        if TableInner[ Key ] then
            return
        end

        local Value1 = nil

        for Key2, Value in List, nil, nil do
            if not Table2[ Value ] and not Table.IsProtected( Value ) then
                if Callback( Value ) then
                    TableInner[ Key ] = Value
                    Table2[ Value ] = true
                    return
                end
            end
        end
    end

    local function Gun( Argument1 )
        local IsWeapon2
        local IsWeapon = Table.IsWeapon( Argument1 )
        IsWeapon2 = if IsWeapon then not Table.IsBroken( Argument1 ) else IsWeapon
        return IsWeapon2
    end

    local function Edrink( Object )
        local Flag = Object:GetAttribute( "Item" ) == "EDrink" and true or false
        return Flag
    end

    local function Medkit( Object )
        local Flag = Object:GetAttribute( "Item" ) == "Medkit" and true or false
        return Flag
    end

    local function Car( Self )
        local Flag

        if Self:GetAttribute( "Vehicle" ) == "CheapCar" then
            local NotCarId = not Self:GetAttribute( "CarId" )

            if NotCarId then
                Flag = not Self:GetAttribute( "TestKit" )
            else
                Flag = NotCarId
            end
        else
            Flag = false
        end

        return Flag
    end

    Pick( 2, function( Object )
        local IsWeapon2
        local IsWeapon = Table.IsWeapon( Object )

        if IsWeapon then
            IsWeapon2 = not Table.IsBroken( Object )
        else
            IsWeapon2 = IsWeapon
        end
        if IsWeapon2 then
            if Object:GetAttribute( "Weapon" ) == "AK" then
                IsWeapon2 = true
            else
                IsWeapon2 = false
            end
        end

        return IsWeapon2
    end )
    Pick( 2, Gun )

    if Argument2 then
        Pick( 3, Edrink )
        Pick( 4, Medkit )
        Pick( 5, Car )
    else
        Pick( 3, Medkit )
        Pick( 4, Car )
    end

    local Value1
    local HOTBAR = Table.HOTBAR + 1
    local PROTECT_FIRST = Table.PROTECT_FIRST
    Value1 = nil

    for Key, Value in List, nil, nil do
        if not Table2[ Value ] then
            if Table.IsProtected( Value ) then
                if PROTECT_FIRST <= Table.ALL then
                    TableInner[ PROTECT_FIRST ] = Value
                    PROTECT_FIRST = PROTECT_FIRST + 1
                end
            elseif HOTBAR <= Table.TOTAL then
                TableInner[ HOTBAR ] = Value
                HOTBAR = HOTBAR + 1
            end
        end
    end

    return TableInner
end

local Callback = nil

if Players.LocalPlayer then
    local Flag
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer == nil then
        Flag = false
    elseif LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        Flag = false
    else
        Flag = true
    end

    Players.LocalPlayer:GetAttributeChangedSignal( "InTutorial" ):Connect( function()
        local FlagInner
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer == nil then
            FlagInner = false
        elseif LocalPlayer:GetAttribute( "InTutorial" ) == nil then
            FlagInner = false
        else
            FlagInner = true
        end
        if Flag and not FlagInner and Callback then
            Callback( )
        end

        Flag = FlagInner
        Table.Changed:Fire( )
    end )
end

function Table.Layout()
    local Flag
    local Tools = Table.Tools( )
    AssignKeys( Tools )
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer == nil then
        Flag = false
    elseif LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        Flag = false
    else
        Flag = true
    end
    if Flag then
        return ( TutoLayout( Tools ) )
    end

    local Flag19
    ApplySaved( Tools )

    local function Order( Key, Key2 )
        local Slot = Key:GetAttribute( "Slot" ) or 99
        local Slot2 = Key2:GetAttribute( "Slot" ) or 99

        if Slot ~= Slot2 then
            local Flag = Slot < Slot2 and true or false
            return Flag
        end
        if Key.Name == Key2.Name then
            local Entry3
            local Entry = Class[ Key ]
            Entry3 = if Entry then Entry else Key.Name
            local Entry4
            local Entry2 = Class[ Key2 ]
            Entry4 = if Entry2 then Entry2 else Key2.Name
            local Flag3 = Entry3 < Entry4 and true or false
            return Flag3
        end
        local Flag2 = Key.Name < Key2.Name and true or false
        return Flag2
    end

    table.sort( Tools, Order )
    Flag19 = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false
    local Value1
    local TableInner = { }
    local Table2Inner = { }

    local function Free( Key )
        local Flag = if Key == Table.FISTS then false else not TableInner[ Key ]
        return Flag
    end

    local function BarCase( Argument1 )
        local Flag = Argument1 <= Table.HOTBAR and true or false
        return Flag
    end

    local Flag2 = false

    local function BarBlocked( Argument1 )
        local IsWeapon
        local IsBroken = Table.IsBroken( Argument1 )

        if IsBroken then
            IsWeapon = IsBroken
        elseif Flag2 then
            IsWeapon = Table.IsWeapon( Argument1 )
        else
            IsWeapon = Flag2
        end

        return IsWeapon
    end

    local function Place( Key, Argument2 )
        local Flag
        TableInner[ Key ] = Argument2
        Flag = Key <= Table.HOTBAR and true or false

        if Flag and Table.IsWeapon( Argument2 ) then
            Flag2 = true
        end
    end

    local Table3 = { }
    Value1 = nil

    for Key, Value in Tools, nil, nil do
        if Table.IsFixed( Value ) then
            table.insert( Table3, Value )
        end
    end

    local Value2
    table.sort( Table3, function( Self, Object )
        local Entry = Table4[ Self:GetAttribute( "Vehicle" ) ] or 99
        local Entry2 = Table4[ Object:GetAttribute( "Vehicle" ) ] or 99

        if Entry ~= Entry2 then
            local Flag = Entry < Entry2 and true or false
            return Flag
        end
        if Self.Name == Object.Name then
            local Flag3 = ( tonumber( tostring( Self:GetAttribute( "CarId" ) or "" ):match( "%d+" ) ) or 0 ) < ( tonumber( tostring( Object:GetAttribute( "CarId" ) or "" ):match( "%d+" ) ) or 0 ) and true or false
            return Flag3
        end
        local Flag2 = Self.Name < Object.Name and true or false
        return Flag2
    end )
    Value2 = nil

    for Key2, Value3 in Table3, nil, nil do
        local Entry17 = Table.VEHICLE_CASES[ Key2 ]

        if Entry17 then
            TableInner[ Entry17 ] = Value3
        end
    end

    local Value4
    local Table4Inner = { }
    Value4 = nil

    for Key3, Value5 in Tools, nil, nil do
        Watch( Value5 )

        if not Table.IsFixed( Value5 ) and Table.IsProtected( Value5 ) then
            local Entry12
            local Entry11 = Class[ Value5 ]
            Entry12 = if Entry11 then Entry11 else Value5.Name
            local Entry14
            local Entry13 = Table2[ Entry12 ]

            if not Table.IsProtectedCase( Entry13 ) or TableInner[ Entry13 ] then
                local PROTECT_FIRST = Table.PROTECT_FIRST
                local ALL = Table.ALL
                local J6 = PROTECT_FIRST
                Entry14 = nil

                for J6 = PROTECT_FIRST, ALL do
                    if not TableInner[ J6 ] then
                        Entry14 = J6
                        break
                    end

                    Entry14 = nil
                end
            else
                Entry14 = Entry13
            end
            if Entry14 then
                local Entry16
                TableInner[ Entry14 ] = Value5
                local Entry15 = Class[ Value5 ]
                Entry16 = if Entry15 then Entry15 else Value5.Name
                Table2[ Entry16 ] = Entry14
                Table4Inner[ Value5 ] = true
            end
        end
    end

    local Value6
    local Table5 = { }
    Value6 = nil

    for Key4, Value7 in Tools, nil, nil do
        if not Table.IsFixed( Value7 ) and not Table4Inner[ Value7 ] then
            local Entry9
            local Entry8 = Class[ Value7 ]
            Entry9 = if Entry8 then Entry8 else Value7.Name
            local Entry10 = Table2[ Entry9 ]

            if Entry10 or not Flag19 then
                if Entry10 and Entry10 <= Table.TOTAL then
                    local Flag16 = if Entry10 == Table.FISTS then false else not TableInner[ Entry10 ]

                    if Flag16 then
                        local IsWeapon4
                        local IsBroken4 = Table.IsBroken( Value7 )

                        if IsBroken4 then
                            IsWeapon4 = IsBroken4
                        elseif Flag2 then
                            IsWeapon4 = Table.IsWeapon( Value7 )
                        else
                            IsWeapon4 = Flag2
                        end
                        if not IsWeapon4 then
                            local Flag18
                            TableInner[ Entry10 ] = Value7

                            if Entry10 <= Table.HOTBAR then
                                Flag18 = true
                            else
                                Flag18 = false
                            end
                            if not Flag18 or not Table.IsWeapon( Value7 ) then
                                continue
                            end

                            Flag2 = true
                            continue
                        end
                        local Flag17 = Entry10 <= Table.HOTBAR and true or false

                        if not Flag17 then
                            TableInner[ Entry10 ] = Value7

                            if Entry10 <= Table.HOTBAR then
                                Flag18 = true
                            else
                                Flag18 = false
                            end
                            if not Flag18 or not Table.IsWeapon( Value7 ) then
                                continue
                            end

                            Flag2 = true
                            continue
                        end
                    end
                end

                table.insert( Table2Inner, Value7 )
            else
                table.insert( Table5, Value7 )
            end
        end
    end

    local Value8 = nil

    for Key5, Value9 in Table5, nil, nil do
        local Entry7 = Class2[ Value9 ]

        if Entry7 and Entry7 <= Table.TOTAL then
            local Flag13 = if Entry7 == Table.FISTS then false else not TableInner[ Entry7 ]

            if Flag13 then
                local IsWeapon3
                local IsBroken3 = Table.IsBroken( Value9 )

                if IsBroken3 then
                    IsWeapon3 = IsBroken3
                elseif Flag2 then
                    IsWeapon3 = Table.IsWeapon( Value9 )
                else
                    IsWeapon3 = Flag2
                end
                if not IsWeapon3 then
                    local Flag15
                    TableInner[ Entry7 ] = Value9

                    if Entry7 <= Table.HOTBAR then
                        Flag15 = true
                    else
                        Flag15 = false
                    end
                    if not Flag15 or not Table.IsWeapon( Value9 ) then
                        continue
                    end

                    Flag2 = true
                    continue
                end
                local Flag14 = Entry7 <= Table.HOTBAR and true or false

                if not Flag14 then
                    TableInner[ Entry7 ] = Value9

                    if Entry7 <= Table.HOTBAR then
                        Flag15 = true
                    else
                        Flag15 = false
                    end
                    if not Flag15 or not Table.IsWeapon( Value9 ) then
                        continue
                    end

                    Flag2 = true
                    continue
                end
            end
        end

        table.insert( Table2Inner, Value9 )
    end
    if #Table5 > 0 then
        table.sort( Table2Inner, Order )
    end

    local Value10 = nil

    for Key6, Value11 in Table2Inner, nil, nil do
        local IsWeapon
        local IsBroken = Table.IsBroken( Value11 )

        if IsBroken then
            IsWeapon = IsBroken
        elseif Flag2 then
            IsWeapon = Table.IsWeapon( Value11 )
        else
            IsWeapon = Flag2
        end

        local Slot2
        local Slot = Value11:GetAttribute( "Slot" )

        if type( Slot ) ~= "number" or not ( Slot >= 1 ) or not ( Slot <= Table.TOTAL ) then
            Slot2 = nil
        else
            local Flag5 = if Slot == Table.FISTS then false else not TableInner[ Slot ]

            if Flag5 then
                if IsWeapon then
                    local Flag6 = Slot <= Table.HOTBAR and true or false

                    if Flag6 then
                        Slot2 = nil
                    elseif Slot then
                        Slot2 = Slot
                    else
                        Slot2 = nil
                    end
                elseif Slot then
                    Slot2 = Slot
                else
                    Slot2 = nil
                end
            else
                Slot2 = nil
            end
        end

        local Flag7 = Value11:GetAttribute( "Vehicle" ) ~= nil and true or false

        if not Slot2 then
            local HOTBAR4

            if IsWeapon or Flag7 then
                local HOTBAR3 = Table.HOTBAR + 1

                if HOTBAR3 then
                    HOTBAR4 = HOTBAR3
                else
                    HOTBAR4 = 1
                end
            else
                HOTBAR4 = 1
            end

            local TOTAL2 = Table.TOTAL
            local J2 = HOTBAR4

            for J2 = HOTBAR4, TOTAL2 do
                local Flag8 = if J2 == Table.FISTS then false else not TableInner[ J2 ]

                if Flag8 then
                    Slot2 = J2
                    break
                end
            end
        end
        if not Slot2 and Flag7 and not IsWeapon then
            local HOTBAR5 = Table.HOTBAR
            local J3 = 1

            for J3 = 1, HOTBAR5 do
                local Flag9 = if J3 == Table.FISTS then false else not TableInner[ J3 ]

                if Flag9 then
                    Slot2 = J3
                    break
                end
            end
        end
        if not Slot2 and IsWeapon then
            local Value13
            local HOTBAR6 = Table.HOTBAR
            local J4 = 1
            Value13 = nil

            for J4 = 1, HOTBAR6 do
                local Flag10 = if J4 == Table.FISTS then false else not TableInner[ J4 ]

                if Flag10 then
                    Value13 = J4
                    break
                end

                Value13 = nil
            end
            if Value13 then
                local HOTBAR7 = Table.HOTBAR + 1
                local TOTAL3 = Table.TOTAL
                local J5 = HOTBAR7

                for J5 = HOTBAR7, TOTAL3 do
                    local Entry2 = TableInner[ J5 ]

                    if Entry2 and not Table.IsFixed( Entry2 ) then
                        local IsWeapon2
                        local IsBroken2 = Table.IsBroken( Entry2 )

                        if IsBroken2 then
                            IsWeapon2 = IsBroken2
                        elseif Flag2 then
                            IsWeapon2 = Table.IsWeapon( Entry2 )
                        else
                            IsWeapon2 = Flag2
                        end
                        if not IsWeapon2 then
                            local Flag11
                            TableInner[ J5 ] = nil
                            TableInner[ Value13 ] = Entry2
                            Flag11 = Value13 <= Table.HOTBAR and true or false

                            if Flag11 and Table.IsWeapon( Entry2 ) then
                                Flag2 = true
                            end

                            local Entry4
                            local Entry3 = Class[ Entry2 ]
                            Entry4 = if Entry3 then Entry3 else Entry2.Name
                            Table2[ Entry4 ] = Value13
                            Slot2 = J5
                            break
                        end
                    end
                end
            end

            Slot2 = Slot2 or Value13
        end
        if Slot2 then
            local Flag12
            TableInner[ Slot2 ] = Value11
            Flag12 = Slot2 <= Table.HOTBAR and true or false

            if Flag12 and Table.IsWeapon( Value11 ) then
                Flag2 = true
            end
            if Flag19 then
                Class2[ Value11 ] = Slot2
            else
                local Entry6
                local Entry5 = Class[ Value11 ]
                Entry6 = if Entry5 then Entry5 else Value11.Name
                Table2[ Entry6 ] = Slot2
            end
        end
    end
    if Table.WeaponRequired( ) and not Flag2 then
        local HOTBAR = Table.HOTBAR + 1
        local TOTAL = Table.TOTAL
        local I = HOTBAR

        for I = HOTBAR, TOTAL do
            local Entry = TableInner[ I ]

            if Table.IsWeapon( Entry ) and not Table.IsBroken( Entry ) then
                local Value12
                local HOTBAR2 = Table.HOTBAR
                local J = 2
                Value12 = nil

                for J = 2, HOTBAR2 do
                    local Flag3 = if J == Table.FISTS then false else not TableInner[ J ]

                    if Flag3 then
                        Value12 = J
                        break
                    end

                    Value12 = nil
                end

                local Item = not Value12 and TableInner[ 2 ] or nil
                local Flag4
                local Number = Value12 or 2
                TableInner[ I ] = Item
                TableInner[ Number ] = nil
                TableInner[ Number ] = Entry
                Flag4 = Number <= Table.HOTBAR and true or false

                if not Flag4 or not Table.IsWeapon( Entry ) then
                    break
                end

                Flag2 = true
                break
            end
        end
    end

    return TableInner
end
function Table.Move( Key, Key2 )
    if Key == Key2 or Key2 < 1 or Table.ALL < Key2 then
        return
    end
    if Key == Table.FISTS or Key2 == Table.FISTS then
        return
    end

    local Layout = Table.Layout( )
    local Entry = Layout[ Key ]
    local Entry2 = Layout[ Key2 ]

    if not Entry then
        return
    end
    if Table.IsFixed( Entry ) or Table.IsFixed( Entry2 ) then
        return
    end
    if Table.IsBroken( Entry ) and Key2 <= Table.HOTBAR then
        return false, "broken"
    end
    if Table.IsBroken( Entry2 ) and Key <= Table.HOTBAR then
        return false, "broken"
    end

    local Number
    local HOTBAR = Table.HOTBAR
    local I = 1
    Number = 0

    for I = 1, HOTBAR do
        local Entry3 = Layout[ I ]

        if Entry3 and Entry3 ~= Entry and Entry3 ~= Entry2 and Table.IsWeapon( Entry3 ) then
            Number = Number + 1
        end
    end
    if Table.IsWeapon( Entry ) and Key2 <= Table.HOTBAR then
        Number = Number + 1
    end
    if Entry2 and Table.IsWeapon( Entry2 ) and Key <= Table.HOTBAR then
        Number = Number + 1
    end
    if Number > 1 then
        return false, "oneweapon"
    end
    if Number == 0 and Table.WeaponRequired( ) then
        local HOTBAR2 = Table.HOTBAR
        local I2 = 1

        for I2 = 1, HOTBAR2 do
            if Table.IsWeapon( Layout[ I2 ] ) then
                return false, "needweapon"
            end
        end
    end
    if Table.IsProtectedCase( Key ) == Table.IsProtectedCase( Key2 ) then
        local Value1Inner = nil

        for Key3, Value in Table2, nil, nil do
            if Value == Key2 then
                Table2[ Key3 ] = nil
            end
        end

        local Entry7
        local Entry6 = Class[ Entry ]
        Entry7 = if Entry6 then Entry6 else Entry.Name
        Table2[ Entry7 ] = Key2

        if Entry2 then
            local Entry9
            local Entry8 = Class[ Entry2 ]
            Entry9 = if Entry8 then Entry8 else Entry2.Name
            Table2[ Entry9 ] = Key
        end
        if Value1 then
            Value1[ Key2 ] = nil

            if Entry2 then
                Value1[ Key ] = nil
            end
        end

        Table.Changed:Fire( )
        Table.SaveLayout( )
        return true
    end
    local Entry4, Entry5

    if Table.IsProtectedCase( Key ) then
        Entry4 = Entry2
        Entry5 = Entry
    else
        Entry4 = Entry
        Entry5 = Entry2
    end
    if Entry4 and not LootShared.Droppable( Entry4 ) then
        if not Entry4:GetAttribute( "Unbreakable" ) or not Table.IsWeapon( Entry4 ) then
            return false, "never"
        end
    end
    if Entry4 and Table.ZoneLocked( ) then
        return false, "combat"
    end

    local Loot
    local Remotes = ReplicatedStorage:FindFirstChild( "Remotes" )

    if Remotes then
        Loot = Remotes:FindFirstChild( "Loot" )
    else
        Loot = Remotes
    end
    if not Loot then
        return
    end

    Class3[ Entry ] = Key2

    if Entry2 then
        Class3[ Entry2 ] = Key
    end

    Loot:FireServer( "protect", Entry4, Entry5 )
    return true
end
local Flag2 = false
function Table.SaveLayout()
    if Flag2 or Value1 == nil then
        return
    end

    local Flag
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer == nil then
        Flag = false
    elseif LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        Flag = false
    else
        Flag = true
    end
    if Flag then
        return
    end

    local Flag2Inner = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false

    if Flag2Inner then
        return
    end
    Flag2 = true
    task.delay( 1, function()
        Flag2 = false
        local Layout = Table.Layout( )
        local TableInner = { }

        for Key, Value in ByName( Table.Tools( ) ) do
            local Value6 = nil

            for Key4, Value7 in Value, nil, nil do
                TableInner[ Value7 ] = Key4
            end
        end

        local Value2
        local Table2 = { }
        Value2 = nil

        for Key2, Value3 in Layout, nil, nil do
            if Key2 ~= Table.FISTS and Key2 <= Table.TOTAL and TableInner[ Value3 ] then
                local Text = tostring( Key2 )
                local Name = Value3.Name
                Table2[ Text ] = Name .. "|" .. TableInner[ Value3 ]
            end
        end

        local Value4 = nil

        for Key3, Value5 in Value1, nil, nil do
            if not Table2[ tostring( Key3 ) ] then
                Table2[ tostring( Key3 ) ] = Value5
            end
        end

        local InventoryLayout
        local Remotes = ReplicatedStorage:FindFirstChild( "Remotes" )

        if Remotes then
            InventoryLayout = Remotes:FindFirstChild( "InventoryLayout" )
        else
            InventoryLayout = Remotes
        end
        if InventoryLayout then
            InventoryLayout:FireServer( Table2 )
        end
    end )
    return
end

Callback = function()
    local Tools = Table.Tools( )
    AssignKeys( Tools )
    ApplySaved( Tools )

    if Value1 then
        table.clear( Value1 )
    end

    table.clear( Table2 )
    table.clear( Table3 )

    for Key, Value in TutoLayout( Tools, true ) do
        local Entry2
        local Entry = Class[ Value ]
        Entry2 = if Entry then Entry else Value.Name
        Table2[ Entry2 ] = Key
    end

    Table.SaveLayout( )
end

function Table.LayoutReady()
    local Flag = Value1 ~= nil and true or false
    return Flag
end
return Table
