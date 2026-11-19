-- ReplicatedStorage.HoodNPC.FarmNav
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local function InBox( Argument1, Argument2 )
    local Flag
    local X = Argument1.X

    if Argument2.min.X <= X then
        if Argument1.X <= Argument2.max.X then
            local Y = Argument1.Y

            if Argument2.min.Y <= Y then
                if Argument1.Y <= Argument2.max.Y then
                    local Z = Argument1.Z

                    if Argument2.min.Z <= Z then
                        if Argument1.Z <= Argument2.max.Z then
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

local Table = {
    Building = {
        min = Vector3.new( -1075, -12, 425 ),
        max = Vector3.new( -985, 60, 548 )
    },
    Catwalk = {
        min = Vector3.new( -1062, 8, 481 ),
        max = Vector3.new( -998, 21, 497 )
    },
    Ledge = {
        min = Vector3.new( -1047, 8, 426 ),
        max = Vector3.new( -1014, 19, 435.5 )
    },
    PackArea = {
        min = Vector3.new( -1048, -3.700000047683716, 402.29998779296875 ),
        max = Vector3.new( -1011, -1, 422.1000061035156 )
    },
    Pack = Vector3.new( -1029.5, -2.200000047683716, 412.20001220703125 )
}
function Table.RandomPackSpot( Self )
    local PackArea = Table.PackArea
    local X = PackArea.min.X + 1.5 + Self:NextNumber( ) * ( PackArea.max.X - PackArea.min.X - 3 )
    local Z = PackArea.min.Z + 1.5 + Self:NextNumber( ) * ( PackArea.max.Z - PackArea.min.Z - 3 )
    return ( Vector3.new( X, Table.Pack.Y, Z ) )
end
function Table.PackSpot( Text )
    local PackArea = Table.PackArea
    local Random2 = Random.new( tonumber( Text ) or 0 )
    local X = PackArea.min.X + 1.5 + Random2:NextNumber( ) * ( PackArea.max.X - PackArea.min.X - 3 )
    local Z = PackArea.min.Z + 1.5 + Random2:NextNumber( ) * ( PackArea.max.Z - PackArea.min.Z - 3 )
    return ( Vector3.new( X, Table.Pack.Y, Z ) )
end
Table.Ladders = {
    {
        name = "L1",
        foot = Vector3.new( -1030.5, -5.400000095367432, 484.20001220703125 ),
        top = 13.3,
        exit = Vector3.new( -1030.300048828125, 13.300000190734863, 487.29998779296875 ),
        face = Vector3.new( 0, 0, 1 ),
        low = "ground",
        high = "floor1"
    },
    {
        name = "L2",
        foot = Vector3.new( -1052.800048828125, 12.199999809265137, 489.20001220703125 ),
        top = 33.1,
        exit = Vector3.new( -1057.9000244140625, 32.099998474121094, 488.8999938964844 ),
        face = Vector3.new( -1, 0, 0 ),
        low = "floor1",
        high = "roof",
        hatch = "Porte_863530"
    },
    {
        name = "L3",
        foot = Vector3.new( -1007.5, 12.199999809265137, 489.20001220703125 ),
        top = 33.7,
        exit = Vector3.new( -1002.4000244140625, 31.899999618530273, 488.6000061035156 ),
        face = Vector3.new( 1, 0, 0 ),
        low = "floor1",
        high = "roof",
        hatch = "Porte_863533"
    }
}
Table.Hatches = {
    {
        name = "Porte_863530",
        min = Vector3.new( -1055.800048828125, 0, 477.3999938964844 ),
        max = Vector3.new( -1046.5999755859375, 0, 497 ),
        top = 36.3
    },
    {
        name = "Porte_863533",
        min = Vector3.new( -1014.0999755859375, 0, 477.3999938964844 ),
        max = Vector3.new( -1004.9000244140625, 0, 497 ),
        top = 36.3
    }
}
function Table.HatchAt( Argument1 )
    local Value1
    local Hatches = Table.Hatches
    Value1 = nil

    for Key, Value in Hatches, nil, nil do
        local X = Argument1.X

        if Value.min.X <= X and Argument1.X <= Value.max.X and Value.min.Z <= Argument1.Z then
            if Argument1.Z <= Value.max.Z then
                return Value
            end
        end
    end

    return nil
end
function Table.InBuilding( Argument1 )
    return ( InBox( Argument1, Table.Building ) )
end
function Table.OnLedge( Argument1 )
    return ( InBox( Argument1, Table.Ledge ) )
end
function Table.PlayerOnLedge( Argument1 )
    return ( InBox( Argument1 - Vector3.new( 0, 3, 0 ), Table.Ledge ) )
end
Table.LEDGE_LOOT_RANGE = 55
Table.LEDGE_LOOT_DY = 25
function Table.Level( Argument1 )
    if InBox( Argument1, Table.Ledge ) then
        return "ledge"
    end
    if not InBox( Argument1, Table.Building ) then
        return "ground"
    end
    if Argument1.Y > 26 then
        return "roof"
    end
    if InBox( Argument1, Table.Catwalk ) then
        return "floor1"
    end
    return "ground"
end
local Table2 = { ground = 0, floor1 = 1, roof = 2 }
function Table.Next( Name, Key, Argument3, Argument4 )
    local Entry = Table2[ Name ]
    local Entry2 = Table2[ Key ]

    if not Entry or not Entry2 or Entry == Entry2 then
        return nil
    end

    local Ladders = Table.Ladders

    if Entry < Entry2 then
        if Name == "ground" then
            return Ladders[ 1 ], 1
        end

        local Total, Entry3
        local I = 2
        Total = nil
        Entry3 = nil

        for I = 2, 3 do
            local Magnitude3
            local Magnitude = ( Ladders[ I ].foot - Argument3 ).Magnitude

            if Argument4 then
                local Magnitude2 = ( Ladders[ I ].exit - Argument4 ).Magnitude

                if Magnitude2 then
                    Magnitude3 = Magnitude2
                else
                    Magnitude3 = 0
                end
            else
                Magnitude3 = 0
            end

            local Magnitude4 = Magnitude + Magnitude3

            if not Total or Magnitude4 < Total then
                Total = Magnitude4
                Entry3 = Ladders[ I ]
            end
        end

        return Entry3, 1
    end
    if Name == "floor1" then
        return Ladders[ 1 ], -1
    end

    local Magnitude7, Item
    local Magnitude5 = ( Ladders[ 2 ].exit - Argument3 ).Magnitude

    if true or Magnitude5 < nil then
        Magnitude7 = Magnitude5
        Item = Ladders[ 2 ]
    else
        Magnitude7 = nil
        Item = nil
    end

    local Magnitude6 = ( Ladders[ 3 ].exit - Argument3 ).Magnitude

    if not Magnitude7 or Magnitude6 < Magnitude7 then
        Item = Ladders[ 3 ]
    end

    return Item, -1
end
return Table
