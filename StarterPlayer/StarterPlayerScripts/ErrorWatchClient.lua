-- StarterPlayer.StarterPlayerScripts.ErrorWatchClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local LogService = game:GetService( "LogService" )
local ScriptContext = game:GetService( "ScriptContext" )
local ClientLog = game:GetService( "ReplicatedStorage" ):WaitForChild( "Remotes" ):WaitForChild( "ClientLog", 120 )

if not ClientLog then
    return
end

local function Signature( Argument1 )
    local Sub = Argument1:sub( 1, 400 )
    pcall( function()
        for Key, Value in Players:GetPlayers( ) do
            local Name = Value.Name

            if #Name >= 3 and Sub:find( Name, 1, true ) then
                Sub = Sub:gsub( Name:gsub( "%W", "%%%0" ), "<P>" )
            end
        end
    end )
    local Table = { }
    Sub = Sub:gsub( "%x+%-%x+%-%x+%-%x+%-%x+", "<id>" ):gsub( "(rbxassetid://)(%d+)", function( Text, Text2 )
        table.insert( Table, Text .. Text2 )
        return "\001"
    end ):gsub( "([%?&]id=)(%d+)", function( Text, Text2 )
        table.insert( Table, Text .. Text2 )
        return "\001"
    end ):gsub( "%d+", "#" )
    local Number = 0
    local Sub2 = Sub:gsub( "\001", function()
        Number = Number + 1
        return Table[ Number ]
    end ):sub( 1, 220 )
    return Sub2
end

local Table = { }
local Number = 0

local function SigOf( Argument1 )
    local Sub = Argument1:sub( 1, 200 )
    local Entry = Table[ Sub ]

    if Entry then
        return Entry
    end
    if Number >= 300 then
        table.clear( Table )
        Number = 0
    end

    local Signature2 = Signature( Argument1 )
    Table[ Sub ] = Signature2
    Number = Number + 1
    return Signature2
end

local Table2 = { }
local Number2 = 0
local Number3 = 0
local Table3 = { }
local Send = nil
local Number4 = -math.huge
local Table4 = {
    "^CoreGui%.#%.Loadstring",
    "^RunService:%a+ unexpected error while invoking callback: CoreGui%.#%.Loadstring",
    "^loadstring:#:",
    "^%[Rift UR%]"
}
local Flag = false
local Table5 = { }
local Value1 = nil

local function BuildTrace( Argument1, Key )
    local Stack
    local Lines = { }
    pcall( function()
        local LogHistory = LogService:GetLogHistory( )
        local Max = math.max( 1, #LogHistory - 39 )
        local Count = #LogHistory
        local I = Max

        for I = Max, Count do
            local Entry = LogHistory[ I ]
            local Sub = Entry.messageType.Name:sub( 8, 8 )
            table.insert( Lines, Sub .. "|" .. tostring( Entry.message ):sub( 1, 200 ) )
        end
    end )
    local Table = { msg = Argument1:sub( 1, 400 ) }

    if Table5[ Key ] then
        local Sub = Table5[ Key ]:sub( 1, 600 )

        if Sub then
            Stack = Sub
        else
            Stack = nil
        end
    else
        Stack = nil
    end

    Table.stack = Stack
    Table.lines = Lines
    return Table
end

local function Urgent( Argument1, Argument2 )
    Flag = true
    task.spawn( function()
        task.wait( ( math.max( 16 - ( os.clock( ) - Number4 ), 0.3 ) ) )
        Value1 = BuildTrace( Argument1, Argument2 )
        Send( )
    end )
end

local function Add( Argument1, Name )
    local Entry2
    local Sub = Argument1:sub( 1, 200 )
    local Entry = Table[ Sub ]

    if Entry then
        Entry2 = Entry
    else
        if Number >= 300 then
            table.clear( Table )
            Number = 0
        end

        local Signature2 = Signature( Argument1 )
        Table[ Sub ] = Signature2
        Number = Number + 1
        Entry2 = Signature2
    end

    local Value2, FlagInner
    Value2 = nil

    for Key, Value in Table4, nil, nil do
        if Entry2:find( Value ) then
            FlagInner = true
            break
        end

        FlagInner = false
    end
    if FlagInner and not Flag then
        Flag = true
        task.spawn( function()
            task.wait( ( math.max( 16 - ( os.clock( ) - Number4 ), 0.3 ) ) )
            Value1 = BuildTrace( Argument1, Entry2 )
            Send( )
        end )
    end

    local Entry4
    local Entry3 = Table2[ Entry2 ]

    if Entry3 then
        Entry4 = Entry3
    else
        if Number2 >= 150 and not FlagInner then
            Number3 = Number3 + 1
            return
        end

        Number2 = Number2 + 1
        local TableInner = { 0, Name, Argument1:sub( 1, 300 ), Table3[ Entry2 ] }
        Table2[ Entry2 ] = TableInner
        Entry4 = TableInner
    end

    Entry4[ 1 ] = Entry4[ 1 ] + 1

    if Name == "E" then
        Entry4[ 2 ] = "E"
    end

    local Item2
    local Item = Entry4[ 4 ]
    Item2 = if Item then Item else Table3[ Entry2 ]
    Entry4[ 4 ] = Item2

    if FlagInner then
        Entry4.u = true
    end
end

LogService.MessageOut:Connect( function( Argument1, Argument2 )
    local Text

    if Argument2 == Enum.MessageType.MessageError then
        Text = "E"
    elseif Argument2 == Enum.MessageType.MessageWarning then
        Text = "W"
    else
        Text = nil
    end
    if Text then
        Add( Argument1, Text )
    end
end )
pcall( function()
    for Key, Value in LogService:GetLogHistory( ) do
        local Text
        local MessageType = Value.messageType

        if MessageType == Enum.MessageType.MessageError then
            Text = "E"
        elseif MessageType == Enum.MessageType.MessageWarning then
            Text = "W"
        else
            Text = nil
        end
        if Text and type( Value.message ) == "string" then
            Add( Value.message, Text )
        end
    end
end )
ScriptContext.Error:Connect( function( Argument1, Argument2, Argument3 )
    local Match = type( Argument2 ) == "string" and Argument2:match( "[^\n]+" ) or nil

    if not Match and Argument3 then
        pcall( function()
            Match = Argument3:GetFullName( )
        end )
    end
    if not Match then
        return
    end

    local Entry2
    local Sub = Argument1:sub( 1, 200 )
    local Entry = Table[ Sub ]

    if Entry then
        Entry2 = Entry
    else
        if Number >= 300 then
            table.clear( Table )
            Number = 0
        end

        local Signature2 = Signature( Argument1 )
        Table[ Sub ] = Signature2
        Number = Number + 1
        Entry2 = Signature2
    end

    local Entry3 = Table2[ Entry2 ]

    if Entry3 then
        local Item2
        local Item = Entry3[ 4 ]
        Item2 = if Item then Item else Match:sub( 1, 200 )
        Entry3[ 4 ] = Item2
    else
        Table3[ Entry2 ] = Match:sub( 1, 200 )
    end
    if type( Argument2 ) == "string" and not Table5[ Entry2 ] then
        Table5[ Entry2 ] = Argument2
    end
end )

Send = function()
    if Number2 == 0 and Number3 == 0 then
        return
    end
    if os.clock( ) - Number4 < 16 then
        return
    end

    local Value1Inner
    Number4 = os.clock( )
    local Table = { }
    Value1Inner = nil

    for Key, Value in Table2, nil, nil do
        table.insert( Table, { Key, Value } )
    end

    table.sort( Table, function( List, List2 )
        local Flag = List[ 2 ].u == true and true or false
        local Flag2 = List2[ 2 ].u == true and true or false

        if Flag == Flag2 then
            local Flag4
            local Item = List[ 2 ][ 1 ]
            Flag4 = List2[ 2 ][ 1 ] < Item and true or false
            return Flag4
        end
        local Flag3 = List[ 2 ].u == true and true or false
        return Flag3
    end )
    local Table2Inner = { }
    local Min = math.min( #Table, 40 )
    local I = 1

    for I = 1, Min do
        local Item = Table[ I ][ 1 ]
        local Item2 = Table[ I ][ 2 ]
        table.insert( Table2Inner, { Item, Item2[ 1 ], Item2[ 2 ], Item2[ 3 ], Item2[ 4 ] } )
        Table2[ Item ] = nil
        Number2 = Number2 - 1
    end
    if Number3 > 0 and #Table2Inner < 40 then
        table.insert( Table2Inner, {
            "(ErrorWatchClient : messages différents au-delà de " .. 150 .. ")",
            Number3,
            "W"
        } )
        Number3 = 0
    end

    Value1 = nil
    pcall( ClientLog.FireServer, ClientLog, Table2Inner, Value1 )
end

task.wait( 45 )

while true do
    Send( )
    task.wait( 60 )
end
