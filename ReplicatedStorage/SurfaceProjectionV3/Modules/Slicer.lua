-- ReplicatedStorage.SurfaceProjectionV3.Modules.Slicer
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local function Slice_Face( List, Argument2, UpVector )
    local Table = { }
    local Table2 = { }
    local Table3 = { }
    local I = 1

    for I = 1, 3 do
        local Flag
        Table[ I ] = ( List[ I ].Position - Argument2 ):Dot( UpVector )
        Flag = Table[ I ] > 0 and true or false
        Table3[ I ] = Flag
    end

    local I2 = 1

    for I2 = 1, 3 do
        local Result = I2 % 3 + 1
        local Position = List[ I2 ].Position
        local Position2 = List[ Result ].Position
        local Entry = Table[ I2 ]
        local Entry2 = Table[ Result ]
        local Entry3 = Table3[ I2 ]
        local Entry4 = Table3[ Result ]

        if Entry3 then
            table.insert( Table2, Position )
        end
        if Entry3 ~= Entry4 then
            table.insert( Table2, Position:Lerp( Position2, Entry / ( Entry - Entry2 ) ) )
        end
    end
    if #Table2 == 3 then
        return { { Table2[ 1 ], Table2[ 2 ], Table2[ 3 ] } }
    end
    if #Table2 == 4 then
        return {
            { Table2[ 1 ], Table2[ 2 ], Table2[ 3 ] },
            { Table2[ 1 ], Table2[ 3 ], Table2[ 4 ] }
        }
    end
    return { }
end

return function( Argument1, Argument2, Argument3 )
    local Value1
    local ToObjectSpace = Argument2:ToObjectSpace( Argument3 )
    local Position = ToObjectSpace.Position
    local UpVector = ToObjectSpace.UpVector
    local Table = { }
    local Table2 = { }
    local Faces = Argument1.Faces
    Value1 = nil

    for Key, Value in Faces, nil, nil do
        local Value3
        local Slice_Face2 = Slice_Face( {
            Argument1.Vertices[ Value[ 1 ] ],
            Argument1.Vertices[ Value[ 2 ] ],
            Argument1.Vertices[ Value[ 3 ] ]
        }, Position, UpVector )
        Value3 = nil

        for Key2, Value4 in Slice_Face2, nil, nil do
            local Count = #Table
            table.insert( Table, { Position = Value4[ 1 ] } )
            table.insert( Table, { Position = Value4[ 2 ] } )
            table.insert( Table, { Position = Value4[ 3 ] } )
            table.insert( Table2, { Count + 1, Count + 2, Count + 3 } )
        end
    end

    return Table, Table2
end
