-- ReplicatedStorage.BetaWeaponRoll
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Script = script
local Table = {
    POOL = {
        "M4",
        "AK",
        "MP5",
        "M60",
        "G15",
        "SPAS12",
        "RPG",
        "Batte",
        "Bayonneta",
        "BrokenBottle"
    },
    MELEE = { Batte = true, Bayonneta = true, BrokenBottle = true },
    WEIGHTS = { G15 = 0.5, Batte = 0, Bayonneta = 0, BrokenBottle = 0 },
    ROUND = 600,
    MELEE_ROUND = 120,
    ROUND_BY = { G15 = 420 },
    NO_KEVLAR = { G15 = true },
    EPOCH = DateTime.fromUniversalTime( 2026, 10, 14 ).UnixTimestamp,
    SLOT = 4,
    ROLL_TIME = 17,
    SWAP_AT = 15.5,
    BUSY_WAIT = 3,
    GROUND_WAIT = 3
}
Table.SHIELD_TIME = Table.BUSY_WAIT + Table.GROUND_WAIT + Table.ROLL_TIME + 2
Table.BLOCK_BEFORE = 45
Table.RESPAWN_WINDOW = 15
Table.INTERMISSION = 15
local ROUND = Script:GetAttribute( "TestRoundSeconds" )

if type( ROUND ) == "number" and ROUND > 0 and game:GetService( "RunService" ):IsStudio( ) then
    Table.ROUND = ROUND
    Table.MELEE_ROUND = ROUND
    Table.ROUND_BY = { }
    local BLOCK_BEFORE = Table.BLOCK_BEFORE
    Table.BLOCK_BEFORE = math.min( BLOCK_BEFORE, ROUND / 2 )
end

function Table.Enabled()
    local Flag = Script:GetAttribute( "Enabled" ) ~= false and true or false
    return Flag
end
function Table.InStudio()
    local Flag = Script:GetAttribute( "InStudio" ) == true and true or false
    return Flag
end
function Table.Title()
    return Script:GetAttribute( "Title" ) or "Weapon Roll"
end
function Table.Active()
    local Flag = Script:GetAttribute( "Active" ) == true and true or false
    return Flag
end
function Table.DurationOf( Key )
    local Entry2
    local INTERMISSION = Table.INTERMISSION
    local Entry = Table.ROUND_BY[ Key ]

    if Entry then
        Entry2 = Entry
    elseif Table.MELEE[ Key ] then
        local MELEE_ROUND = Table.MELEE_ROUND

        if MELEE_ROUND then
            Entry2 = MELEE_ROUND
        else
            Entry2 = Table.ROUND
        end
    else
        Entry2 = Table.ROUND
    end

    return INTERMISSION + Entry2
end

local function Pick( Amount, Argument2 )
    local Value1, Number
    local POOL = Table.POOL
    Value1 = nil
    Number = 0

    for Key, Value in POOL, nil, nil do
        if Value ~= Argument2 then
            Number = Number + ( Table.WEIGHTS[ Value ] or 1 )
        end
    end

    local Value2
    local NextNumber = Random.new( Amount * 7919 + 104729 ):NextNumber( ) * Number
    local POOL2 = Table.POOL
    Value2 = nil

    for Key2, Value3 in POOL2, nil, nil do
        if Value3 ~= Argument2 then
            local NextNumber2 = NextNumber - ( Table.WEIGHTS[ Value3 ] or 1 )

            if NextNumber2 < 0 then
                return Value3
            end
            NextNumber = NextNumber2
        end
    end

    local Count = #Table.POOL
    local I = Count

    for I = Count, 1, -1 do
        if Table.POOL[ I ] ~= Argument2 and ( Table.WEIGHTS[ Table.POOL[ I ] ] or 1 ) > 0 then
            return Table.POOL[ I ]
        end
    end

    return Table.POOL[ 1 ]
end

local Table2 = { Table.EPOCH }
local Table3 = { ( Pick( 1, nil ) ) }

local function ExtendTo( Max )
    while true do
        local Entry4
        local Entry = Table2[ #Table2 ]
        local Entry2 = Table3[ #Table3 ]
        local INTERMISSION = Table.INTERMISSION
        local Entry3 = Table.ROUND_BY[ Entry2 ]

        if Entry3 then
            Entry4 = Entry3
        elseif Table.MELEE[ Entry2 ] then
            local MELEE_ROUND = Table.MELEE_ROUND

            if MELEE_ROUND then
                Entry4 = MELEE_ROUND
            else
                Entry4 = Table.ROUND
            end
        else
            Entry4 = Table.ROUND
        end
        if not ( Entry + ( INTERMISSION + Entry4 ) <= Max ) then
            break
        end

        local Entry8
        local Count = #Table2
        local Entry5 = Table2[ Count ]
        local Entry6 = Table3[ Count ]
        local INTERMISSION2 = Table.INTERMISSION
        local Entry7 = Table.ROUND_BY[ Entry6 ]

        if Entry7 then
            Entry8 = Entry7
        elseif Table.MELEE[ Entry6 ] then
            local MELEE_ROUND2 = Table.MELEE_ROUND

            if MELEE_ROUND2 then
                Entry8 = MELEE_ROUND2
            else
                Entry8 = Table.ROUND
            end
        else
            Entry8 = Table.ROUND
        end

        table.insert( Table2, Entry5 + ( INTERMISSION2 + Entry8 ) )
        table.insert( Table3, ( Pick( Count + 1, Table3[ Count ] ) ) )
    end
end

function Table.At( Argument1 )
    local Number, Count
    local Max = math.max( Argument1, Table.EPOCH )
    ExtendTo( Max )
    Number = 1
    Count = #Table2

    while Number < Count do
        local Number2 = ( Number + Count + 1 ) // 2

        if Table2[ Number2 ] <= Max then
            Number = Number2
        else
            Count = Number2 - 1
        end
    end

    local Entry5
    local Entry = Table3[ Number ]
    local Entry2 = Table2[ Number ]
    local Entry3 = Table2[ Number ]
    local INTERMISSION = Table.INTERMISSION
    local Entry4 = Table.ROUND_BY[ Entry ]

    if Entry4 then
        Entry5 = Entry4
    elseif Table.MELEE[ Entry ] then
        local MELEE_ROUND = Table.MELEE_ROUND

        if MELEE_ROUND then
            Entry5 = MELEE_ROUND
        else
            Entry5 = Table.ROUND
        end
    else
        Entry5 = Table.ROUND
    end

    return Entry, Entry2, Entry3 + ( INTERMISSION + Entry5 )
end
function Table.BlocksOpenings( Argument1 )
    if not Table.Active( ) then
        return false
    end

    local ServerTimeNow = workspace:GetServerTimeNow( )
    local NextAt = ( Script:GetAttribute( "NextAt" ) or math.huge ) - ServerTimeNow
    local Flag

    if NextAt < ( Argument1 or Table.BLOCK_BEFORE ) then
        Flag = true
    elseif Script:GetAttribute( "Intermission" ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
function Table.ReopenIn()
    local ServerTimeNow = workspace:GetServerTimeNow( )

    if Script:GetAttribute( "Intermission" ) == true then
        return ( math.max( 1, ( Script:GetAttribute( "IntermissionEnd" ) or ServerTimeNow ) - ServerTimeNow ) )
    end

    local Max2
    local NextAt = Script:GetAttribute( "NextAt" )

    if NextAt then
        local Max = math.max( 1, NextAt - ServerTimeNow + Table.INTERMISSION )

        if Max then
            Max2 = Max
        else
            Max2 = 1
        end
    else
        Max2 = 1
    end

    return Max2
end
return Table
