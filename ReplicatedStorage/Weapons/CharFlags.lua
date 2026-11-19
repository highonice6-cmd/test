-- ReplicatedStorage.Weapons.CharFlags
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Table2 = { }
local Table3 = { }

local function Sync( Key, Attribute )
    local Flag
    local Attribute2 = Key:GetAttribute( Attribute )
    local Entry = Table2[ Attribute ]
    Flag = if Attribute2 == nil or Attribute2 == false then nil else true
    Entry[ Key ] = Flag
end

local function Untrack( Key )
    local Entry = Table3[ Key ]

    if not Entry then
        return
    end

    local Value1 = nil

    for Key2, Value in Entry, nil, nil do
        Value:Disconnect( )
    end

    local Value2
    Table3[ Key ] = nil
    Value2 = nil

    for Key3, Value3 in Table2, nil, nil do
        Value3[ Key ] = nil
    end
end

local function Resync( Key )
    if Key:IsDescendantOf( workspace ) then
        local Value1 = nil

        for Value in Table2, nil, nil do
            local Flag
            local Attribute = Key:GetAttribute( Value )
            local Entry = Table2[ Value ]
            Flag = if Attribute == nil or Attribute == false then nil else true
            Entry[ Key ] = Flag
        end

        return
    end
    local Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        Value3[ Key ] = nil
    end

    return
end

local function Track( Key2 )
    if Table3[ Key2 ] or not Key2:IsA( "Model" ) then
        return
    end
    local Table = { }
    Table3[ Key2 ] = Table
    Table[ 1 ] = Key2.AttributeChanged:Connect( function( Attribute )
        if Table2[ Attribute ] and Key2:IsDescendantOf( workspace ) then
            local Flag
            local Attribute2 = Key2:GetAttribute( Attribute )
            local Entry = Table2[ Attribute ]
            Flag = if Attribute2 == nil or Attribute2 == false then nil else true
            Entry[ Key2 ] = Flag
        end
    end )
    Table[ 2 ] = Key2.AncestryChanged:Connect( function()
        if Key2.Parent ~= nil then
            Resync( Key2 )
            return
        end

        local Entry = Table3[ Key2 ]

        if not Entry then
            return
        end

        local Value1 = nil

        for Key, Value in Entry, nil, nil do
            Value:Disconnect( )
        end

        local Value2
        Table3[ Key2 ] = nil
        Value2 = nil

        for Key2Inner, Value3 in Table2, nil, nil do
            Value3[ Key2 ] = nil
        end
    end )
    Resync( Key2 )
    return
end

local Table = {
    Set = function( Attribute )
        local Entry3
        local Entry = Table2[ Attribute ]

        if Entry then
            Entry3 = Entry
        else
            local Value1
            local Table = { }
            Table2[ Attribute ] = Table
            Value1 = nil

            for Value in Table3, nil, nil do
                if Value:IsDescendantOf( workspace ) then
                    local Flag
                    local Attribute2 = Value:GetAttribute( Attribute )
                    local Entry2 = Table2[ Attribute ]
                    Flag = if Attribute2 == nil or Attribute2 == false then nil else true
                    Entry2[ Value ] = Flag
                end

                Entry3 = Table
            end

            Entry3 = Table
        end

        return Entry3
    end
}

local function OnPlayer( Argument1 )
    if Argument1.Character then
        Track( Argument1.Character )
    end

    Argument1.CharacterAdded:Connect( Track )
end

Players.PlayerAdded:Connect( OnPlayer )

for Key, Value in Players:GetPlayers( ) do
    if Value.Character then
        Track( Value.Character )
    end

    Value.CharacterAdded:Connect( Track )
end

task.spawn( function()
    local Find

    while true do
        Find = WorldRefs.Find( "Dummies" )

        if not Find then
            task.wait( 1 )
        end
        if Find then
            break
        end
    end

    Find.ChildAdded:Connect( Track )

    for Key, Value in Find:GetChildren( ) do
        Track( Value )
    end
end )
task.spawn( function()
    while true do
        task.wait( 1 )

        for Key, Value in Players:GetPlayers( ) do
            local Character = Value.Character

            if Character and not Table3[ Character ] and Character:IsDescendantOf( workspace ) then
                Track( Character )
            end
        end

        local Find = WorldRefs.Find( "Dummies" )

        if Find then
            for Key2, Value2 in Find:GetChildren( ) do
                if not Table3[ Value2 ] then
                    Track( Value2 )
                end
            end
        end
    end
end )
return Table
