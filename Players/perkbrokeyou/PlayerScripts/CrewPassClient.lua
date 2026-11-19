-- Players.perkbrokeyou.PlayerScripts.CrewPassClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local CrewShared = require( ReplicatedStorage:WaitForChild( "CrewShared" ) )
local WorldRefs = require( ReplicatedStorage:WaitForChild( "WorldRefs" ) )
local LocalPlayer = Players.LocalPlayer
local Table = { CharBody = "CrewChar" }
local Table2 = { Default = "CrewCar", VehicleWalk = "CrewWalk" }
local Table3 = { }

local function DriverOf( Object )
    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "VehicleSeat" ) or Value:IsA( "Seat" ) then
            if Value:GetAttribute( "Role" ) == "Driver" then
                if Value.Occupant then
                    return Players:GetPlayerFromCharacter( Value.Occupant.Parent )
                end
            end
        end
    end

    return nil
end

local function Apply( Object, List, Table )
    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            local CollisionGroup = List[ Value.CollisionGroup ]

            if CollisionGroup then
                Table3[ Value ] = { from = Value.CollisionGroup, to = CollisionGroup }
                Value.CollisionGroup = CollisionGroup
            end

            Table[ Value ] = true
        end
    end
end

local function Step()
    local IdOf = CrewShared.IdOf( LocalPlayer )
    local TableInner = { }

    if IdOf then
        for Key, Value in Players:GetPlayers( ) do
            if CrewShared.IdOf( Value ) == IdOf and Value.Character then
                Apply( Value.Character, Table, TableInner )
            end
        end

        local Children
        local Find = WorldRefs.Find( "Cars" )
        Children = Find and Find:GetChildren( ) or { }
        local Value1 = nil

        for Key2, Value2 in Children, nil, nil do
            if Value2:IsA( "Model" ) then
                local DriverOf2 = DriverOf( Value2 )

                if DriverOf2 and CrewShared.IdOf( DriverOf2 ) == IdOf then
                    Apply( Value2, Table2, TableInner )
                end
            end
        end
    end

    local Value4 = nil

    for Key3, Value5 in Table3, nil, nil do
        if not TableInner[ Key3 ] or not Key3.Parent then
            if Key3.Parent and Key3.CollisionGroup == Value5.to then
                Key3.CollisionGroup = Value5.from
            end

            Table3[ Key3 ] = nil
        end
    end
end

while true do
    pcall( Step )
    task.wait( 0.25 )
end
