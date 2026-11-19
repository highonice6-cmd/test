-- ReplicatedStorage.CrosshairCode
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { }
local Table2 = { }
local I = 1

for I = 1, 32 do
    Table2[ ( "0123456789ABCDEFGHJKMNPQRSTVWXYZ" ):sub( I, I ) ] = I - 1
end

local Value1
Table2.O = 0
Table2.I = 1
Table2.L = 1
local Table3 = { "Cross", "T", "Circle", "Square", "Dot" }

local function Int( Text, Argument2, Argument3, Argument4 )
    local Number = tonumber( Text )

    if not Number or Number ~= Number then
        return Argument4
    end
    return ( math.clamp( math.round( Number ), Argument2, Argument3 ) )
end

local function Bool( Argument1 )
    local Flag = Argument1 == true and true or false
    return Flag
end

local Table4 = {
    {
        "XhShape",
        3,
        function( Argument1 )
            return ( table.find( Table3, Argument1 ) or 1 ) - 1
        end,
        function( Amount )
            return Table3[ Amount + 1 ]
        end
    },
    {
        "XhColor",
        24,
        function( Argument1 )
            local Gsub = type( Argument1 ) == "string" and Argument1:gsub( "#", "" ) or ""
            return tonumber( Gsub, 16 ) or 16777215
        end,
        function( Argument1 )
            return string.format( "%06X", Argument1 )
        end
    },
    {
        "XhLength",
        5,
        function( Text )
            local Clamp
            local Number = tonumber( Text )

            if not Number or Number ~= Number then
                Clamp = 4
            else
                Clamp = math.clamp( math.round( Number ), 1, 30 )
            end

            return Clamp - 1
        end,
        function( Amount )
            local Total = Amount <= 29 and Amount + 1 or nil
            return Total
        end
    },
    {
        "XhThickness",
        3,
        function( Text )
            local Clamp
            local Number = tonumber( Text )

            if not Number or Number ~= Number then
                Clamp = 2
            else
                Clamp = math.clamp( math.round( Number ), 1, 8 )
            end

            return Clamp - 1
        end,
        function( Amount )
            return Amount + 1
        end
    },
    {
        "XhGap",
        5,
        function( Text )
            local Number = tonumber( Text )

            if not Number or Number ~= Number then
                return 3
            end
            return ( math.clamp( math.round( Number ), 0, 30 ) )
        end,
        function( Amount )
            local Value1 = Amount <= 30 and Amount or nil
            return Value1
        end
    },
    {
        "XhOpacity",
        5,
        function( Text )
            local Number = tonumber( ( ( tonumber( Text ) or 1 ) - 0.1 ) / 0.05 )

            if not Number or Number ~= Number then
                return 18
            end
            return ( math.clamp( math.round( Number ), 0, 18 ) )
        end,
        function( Amount )
            local Round2

            if Amount <= 18 then
                local Round = math.round( ( 0.1 + Amount * 0.05 ) * 100 ) / 100

                if Round then
                    Round2 = Round
                else
                    Round2 = nil
                end
            else
                Round2 = nil
            end

            return Round2
        end
    },
    {
        "XhDot",
        1,
        function( Argument1 )
            local Flag = Argument1 == true and true or false

            if Flag then
                return 1
            end
            return 0
        end,
        function( Amount )
            local Flag = Amount == 1 and true or false
            return Flag
        end
    },
    {
        "XhDotSize",
        4,
        function( Text )
            local Clamp
            local Number = tonumber( Text )

            if not Number or Number ~= Number then
                Clamp = 2
            else
                Clamp = math.clamp( math.round( Number ), 1, 10 )
            end

            return Clamp - 1
        end,
        function( Amount )
            local Total = Amount <= 9 and Amount + 1 or nil
            return Total
        end
    },
    {
        "XhOutline",
        1,
        function( Argument1 )
            local Flag = Argument1 == true and true or false

            if Flag then
                return 1
            end
            return 0
        end,
        function( Amount )
            local Flag = Amount == 1 and true or false
            return Flag
        end
    },
    {
        "XhDynamic",
        1,
        function( Argument1 )
            local Flag = Argument1 == true and true or false

            if Flag then
                return 1
            end
            return 0
        end,
        function( Amount )
            local Flag = Amount == 1 and true or false
            return Flag
        end
    },
    {
        "XhCombatOnly",
        1,
        function( Argument1 )
            local Flag = Argument1 == true and true or false

            if Flag then
                return 1
            end
            return 0
        end,
        function( Amount )
            local Flag = Amount == 1 and true or false
            return Flag
        end
    },
    {
        "XhRotation",
        6,
        function( Text )
            local Number = tonumber( Text )

            if not Number or Number ~= Number then
                return 0
            end
            return ( math.clamp( math.round( Number ), 0, 45 ) )
        end,
        function( Amount )
            local Value1 = Amount <= 45 and Amount or nil
            return Value1
        end
    }
}
Table.Keys = { }
Value1 = nil

for Key, Value in Table4, nil, nil do
    local Keys = Table.Keys
    table.insert( Keys, Value[ 1 ] )
end

local function Check( List )
    local Number
    local I = 1
    Number = 0

    for I = 1, 12 do
        Number = Number + I * List[ I ]
    end

    return Number % 31
end

local Value2 = nil

local function Default( Key )
    if not Value2 then
        local Result2
        local Success, Result = pcall( require, script.Parent:WaitForChild( "Controls" ):WaitForChild( "Spec" ) )
        Result2 = Success and Result or { }
        Value2 = Result2
    end

    local Default
    local Entry = Value2[ Key ]
    Default = type( Entry ) == "table" and Entry.default or nil
    return Default
end

function Table.Encode( List )
    local Table = type( List ) == "table" and List or { }
    local Value1
    local Table2 = { }
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        local Entry2
        local Entry = Table[ Value[ 1 ] ]

        if Entry == nil then
            Entry2 = Default( Value[ 1 ] )
        else
            Entry2 = Entry
        end

        local Value3 = Value[ 3 ]( Entry2 )
        local Item = Value[ 2 ] - 1
        local J2 = Item

        for J2 = Item, 0, -1 do
            table.insert( Table2, ( bit32.extract( Value3, J2 ) ) )
        end
    end

    table.insert( Table2, 0 )
    local Table3 = { }
    local Table4Inner = { }
    local I = 1

    for I = 1, 12 do
        local Number
        local J = 1
        Number = 0

        for J = 1, 5 do
            Number = Number * 2 + Table2[ ( I - 1 ) * 5 + J ]
        end

        Table3[ I ] = Number
        Table4Inner[ I ] = ( "0123456789ABCDEFGHJKMNPQRSTVWXYZ" ):sub( Number + 1, Number + 1 )
    end

    local Check2 = Check( Table3 )
    Table4Inner[ 13 ] = ( "0123456789ABCDEFGHJKMNPQRSTVWXYZ" ):sub( Check2 + 1, Check2 + 1 )
    local Concat = table.concat( Table4Inner )
    local Sub = Concat:sub( 1, 5 )
    local Sub2 = Concat:sub( 6, 9 )
    return "XH-" .. Sub .. "-" .. Sub2 .. "-" .. Concat:sub( 10, 13 )
end
function Table.Decode( List )
    if type( List ) ~= "string" or #List > 64 then
        return nil
    end

    local Sub
    local Gsub = List:upper( ):gsub( "[^%w]", "" )

    if #Gsub ~= 15 or Gsub:sub( 1, 2 ) ~= "XH" then
        Sub = Gsub
    else
        Sub = Gsub:sub( 3 )
    end
    if #Sub ~= 13 then
        return nil
    end

    local Table = { }
    local I = 1

    for I = 1, 13 do
        local Entry = Table2[ Sub:sub( I, I ) ]

        if Entry == nil then
            return nil
        end

        Table[ I ] = Entry
    end
    if Check( Table ) ~= Table[ 13 ] then
        return nil
    end

    local Table2Inner = { }
    local I2 = 1

    for I2 = 1, 12 do
        table.insert( Table2Inner, ( bit32.extract( Table[ I2 ], 4 ) ) )
        table.insert( Table2Inner, ( bit32.extract( Table[ I2 ], 3 ) ) )
        table.insert( Table2Inner, ( bit32.extract( Table[ I2 ], 2 ) ) )
        table.insert( Table2Inner, ( bit32.extract( Table[ I2 ], 1 ) ) )
        table.insert( Table2Inner, ( bit32.extract( Table[ I2 ], 0 ) ) )
    end
    if Table2Inner[ 60 ] ~= 0 then
        return nil
    end

    local Value1, Number2
    local Table3 = { }
    Value1 = nil
    Number2 = 1

    for Key, Value in Table4, nil, nil do
        local Number
        local Item = Value[ 2 ]
        local J = 1
        Number = 0

        for J = 1, Item do
            Number = Number * 2 + Table2Inner[ Number2 ]
            Number2 = Number2 + 1
        end

        local Value2 = Value[ 4 ]( Number )

        if Value2 == nil then
            return nil
        end

        Table3[ Value[ 1 ] ] = Value2
    end

    return Table3
end
return Table
