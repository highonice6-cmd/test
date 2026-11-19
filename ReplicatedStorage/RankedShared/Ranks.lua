-- ReplicatedStorage.RankedShared.Ranks
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Config = require( script.Parent:WaitForChild( "Config" ) )
local Table2 = { "I", "II", "III" }
local Table = {
    Of = function( Text )
        local Value1, Number2
        local Number = tonumber( Text ) or 0
        local Ranks = Config.Ranks
        Value1 = nil
        Number2 = 1

        for Key, Value in Ranks, nil, nil do
            if Value.min <= Number then
                Number2 = Key
            end
        end

        local Entry = Config.Ranks[ Number2 ]
        local Entry2 = Config.Ranks[ Number2 + 1 ]

        if Entry.single then
            return {
                rank = Entry,
                index = Number2,
                division = nil,
                label = Entry.name,
                floor = Entry.min,
                ceil = nil
            }
        end

        local Min3
        local Clamp = math.clamp( math.floor( ( Number - Entry.min ) / Config.DivisionSize ) + 1, 1, 3 )
        local Min = Entry.min + ( Clamp - 1 ) * Config.DivisionSize

        if Clamp < 3 then
            local Min2 = Min + Config.DivisionSize

            if Min2 then
                Min3 = Min2
            elseif not Entry2 or not Entry2.min then
                Min3 = nil
            else
                Min3 = Entry2.min
            end
        elseif not Entry2 or not Entry2.min then
            Min3 = nil
        else
            Min3 = Entry2.min
        end

        local Text2, Text3

        if Min3 or Clamp ~= 3 or not Config.TopMinElo or not ( Number < Config.TopMinElo ) then
            Text2 = nil
            Text3 = nil
        else
            Min3 = Config.TopMinElo
            Text2 = "Top100"
            Text3 = "Top 100"
        end

        local Name = Entry.name
        return {
            rank = Entry,
            index = Number2,
            division = Clamp,
            label = Name .. " " .. Table2[ Clamp ],
            floor = Min,
            ceil = Min3,
            nextId = Text2,
            nextLabel = Text3
        }
    end
}
function Table.NextOf( Argument1 )
    if type( Argument1 ) ~= "table" or not Argument1.ceil then
        return nil
    end
    if Argument1.nextId then
        return { id = Argument1.nextId, division = nil, label = Argument1.nextLabel }
    end
    local Of = Table.Of( Argument1.ceil )
    return { id = Of.rank.id, division = Of.division, label = Of.label }
end
function Table.TopEligible( Text )
    local Flag
    local Number = tonumber( Text ) or 0
    Flag = ( Config.TopMinElo or 0 ) <= Number and true or false
    return Flag
end
function Table.RankId( Argument1 )
    return Table.Of( Argument1 ).rank.id
end
function Table.Label( Argument1 )
    if type( Argument1 ) ~= "table" then
        return "Unranked"
    end
    if Config.Placement.matches - ( tonumber( Argument1.placed ) or 0 ) > 0 then
        return "Unranked"
    end
    if Argument1.top then
        local Value1
        local Top = Config.Top
        Value1 = nil

        for Key, Value in Top, nil, nil do
            if Value.id == Argument1.top then
                return Value.name
            end
        end
    end

    return Table.Of( Argument1.elo ).label
end
function Table.PlacementsLeft( Argument1 )
    local Number2
    local Matches = Config.Placement.matches

    if type( Argument1 ) == "table" then
        local Number = tonumber( Argument1.placed )

        if Number then
            Number2 = Number
        else
            Number2 = 0
        end
    else
        Number2 = 0
    end

    return ( math.max( 0, Matches - Number2 ) )
end
return Table
