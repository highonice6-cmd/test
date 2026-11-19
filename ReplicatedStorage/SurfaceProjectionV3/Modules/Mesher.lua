-- ReplicatedStorage.SurfaceProjectionV3.Modules.Mesher
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local function Vertice_Normals( List, List2 )
    local Table = { }
    local Count = #List
    local I = 1

    for I = 1, Count do
        Table[ I ] = Vector3.new( 0, 0, 0 )
    end

    local Value1 = nil

    for Key, Value in List2, nil, nil do
        local Position = List[ Value[ 1 ] ].Position
        local Position2 = List[ Value[ 2 ] ].Position
        local Position3 = List[ Value[ 3 ] ].Position
        local Unit3 = ( Position2 - Position ):Cross( Position3 - Position ).Unit
        local Item = Value[ 1 ]
        Table[ Item ] = Table[ Item ] + Unit3
        local Item2 = Value[ 2 ]
        Table[ Item2 ] = Table[ Item2 ] + Unit3
        local Item3 = Value[ 3 ]
        Table[ Item3 ] = Table[ Item3 ] + Unit3
    end

    local Count2 = #Table
    local I2 = 1

    for I2 = 1, Count2 do
        local Unit2

        if Table[ I2 ].Magnitude > 0 then
            local Unit = Table[ I2 ].Unit

            if Unit then
                Unit2 = Unit
            else
                Unit2 = Vector3.new( 0, 1, 0 )
            end
        else
            Unit2 = Vector3.new( 0, 1, 0 )
        end

        Table[ I2 ] = Unit2
    end

    return Table
end

local function Project_UV_From_Projection( Argument1, Argument2, Argument3 )
    local PointToObjectSpace = Argument2:PointToObjectSpace( Argument1 )
    local X = PointToObjectSpace.X / Argument3.X + 0.5
    return Vector2.new( X, PointToObjectSpace.Y / Argument3.Y + 0.5 )
end

return function( Self, Argument2, Argument3, Argument4 )
    local Table = { }
    local Table2 = { }
    local Vertice_Normals2 = Vertice_Normals( Argument2.Vertices, Argument2.Faces )
    local Count = #Argument2.Vertices
    local I = 1

    for I = 1, Count do
        local Entry = Argument2.Vertices[ I ]
        Entry.Position = Entry.Position + Vertice_Normals2[ I ] * 0.001
    end

    local Count2 = #Argument2.Vertices
    local I2 = 1

    for I2 = 1, Count2 do
        local Vector22
        local Entry2 = Argument2.Vertices[ I2 ]
        local Position = Entry2.Position
        local UV = Entry2.UV

        if UV then
            Vector22 = UV
        else
            local PointToObjectSpace = Argument3:PointToObjectSpace( Position )
            local X = PointToObjectSpace.X / Argument4.X + 0.5
            Vector22 = Vector2.new( X, PointToObjectSpace.Y / Argument4.Y + 0.5 )
        end

        local AddVertex = Self:AddVertex( ( Argument3:PointToObjectSpace( Position ) ) )
        Table[ I2 ] = AddVertex

        if Vector22 then
            Table2[ AddVertex ] = Self:AddUV( Vector22 )
        end
    end

    local Value2
    local Faces = Argument2.Faces
    Value2 = nil

    for Key, Value in Faces, nil, nil do
        local Entry3 = Table[ Value[ 1 ] ]
        local Entry4 = Table[ Value[ 2 ] ]
        local Entry5 = Table[ Value[ 3 ] ]

        if Entry3 and Entry4 and Entry5 then
            local AddTriangle = Self:AddTriangle( Entry3, Entry4, Entry5 )
            local Entry6 = Table2[ Entry3 ]
            local Entry7 = Table2[ Entry4 ]
            local Entry8 = Table2[ Entry5 ]

            if Entry6 and Entry7 and Entry8 then
                Self:SetFaceUVs( AddTriangle, { Entry6, Entry7, Entry8 } )
            end
        end
    end
end
