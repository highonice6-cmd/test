-- ReplicatedStorage.SurfaceProjectionV3.Modules.Builder
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Text = require( "./MeshCache" )
local Floor = math.floor
local Readu32 = buffer.readu32
local Table = { }

local function Normalize_Mesh_Vertices( List )
    local Count = #List

    if Count == 0 then
        return { }
    end

    local Number, Number2, Number3, Number4, Number5, Number6
    local I = 1
    Number = math.huge
    Number2 = math.huge
    Number3 = math.huge
    Number4 = -math.huge
    Number5 = -math.huge
    Number6 = -math.huge

    for I = 1, Count do
        local Entry = List[ I ]
        local X = Entry.X
        local Y = Entry.Y
        local Z = Entry.Z

        if X < Number then
            Number = X
        end
        if Y < Number2 then
            Number2 = Y
        end
        if Z < Number3 then
            Number3 = Z
        end
        if Number4 < X then
            Number4 = X
        end
        if Number5 < Y then
            Number5 = Y
        end
        if Number6 < Z then
            Number6 = Z
        end
    end

    local Number13
    local Number7 = ( Number + Number4 ) * 0.5
    local Number8 = ( Number2 + Number5 ) * 0.5
    local Number9 = ( Number3 + Number6 ) * 0.5
    local Number10 = Number4 - Number
    local Number11 = Number5 - Number2
    local Number12 = Number6 - Number3
    Number13 = if Number10 == 0 then 1 else Number10
    local Number14 = if Number11 == 0 then 1 else Number11
    local Number15 = if Number12 == 0 then 1 else Number12
    local Create = table.create( Count )
    local I2 = 1

    for I2 = 1, Count do
        local Entry2 = List[ I2 ]
        local X2 = ( Entry2.X - Number7 ) / Number13
        local Y2 = ( Entry2.Y - Number8 ) / Number14
        Create[ I2 ] = Vector3.new( X2, Y2, ( Entry2.Z - Number9 ) / Number15 )
    end

    return Create
end

local function Cached_Mesh_Faces( Get, Argument2, Argument3, Argument4, Amount )
    local Position3, Position4

    if not Argument4 or not Amount then
        Position3 = Vector3.new( -math.huge, -math.huge, -math.huge )
        Position4 = Vector3.new( math.huge, math.huge, math.huge )
    else
        local Position, Position2
        local Result = Amount / 2
        local I = -1
        Position = Vector3.new( math.huge, math.huge, math.huge )
        Position2 = Vector3.new( -math.huge, -math.huge, -math.huge )

        for I = -1, 1, 2 do
            local J = -1

            for J = -1, 1, 2 do
                local K = -1

                for K = -1, 1, 2 do
                    local X = Result.X * I
                    local Y = Result.Y * J
                    local PointToObjectSpace = Argument2:PointToObjectSpace( ( Argument4:PointToWorldSpace( ( Vector3.new( X, Y, Result.Z * K ) ) ) ) ) / Argument3
                    Position = Position:Min( PointToObjectSpace )
                    Position2 = Position2:Max( PointToObjectSpace )
                end
            end
        end

        Position3 = Position - Vector3.new( 9.999999747378752e-05, 9.999999747378752e-05, 9.999999747378752e-05 )
        Position4 = Position2 + Vector3.new( 9.999999747378752e-05, 9.999999747378752e-05, 9.999999747378752e-05 )
    end

    local Number
    local Vertices = Get.Vertices
    local Index = Get.Index
    local TableInner = { }
    local Table2 = { }
    local Query = Text.Query( Get, Position3, Position4, Table )
    local I2 = 1
    Number = 0

    for I2 = 1, Query do
        local Entry = Table[ I2 ] * 12
        local J2 = 0

        for J2 = 0, 2 do
            local Entry2 = Vertices[ Readu32( Index, Entry + J2 * 4 ) ]
            local Number2 = Number + 1
            TableInner[ Number2 ] = { Position = Argument2:PointToWorldSpace( Entry2 * Argument3 ) }
            Number = Number2
        end

        table.insert( Table2, { Number - 2, Number - 1, Number } )
    end

    return TableInner, Table2
end

return function( Argument1, Argument2, Module, Argument4, Amount )
    if Module:IsA( "ModuleScript" ) then
        local Module2 = require( Module )
        local Vertices = Module2.Vertices
        local Faces = Module2.Faces
        local Normalize_Mesh_Vertices2 = Normalize_Mesh_Vertices( Vertices )
        local Count = #Normalize_Mesh_Vertices2
        local Count2 = #Faces
        local Create = table.create( Count )
        local Create2 = table.create( Count2 )
        local I = 1

        for I = 1, Count2 do
            local Entry = Faces[ I ]
            Create2[ I ] = { Floor( Entry.X ), Floor( Entry.Y ), ( Floor( Entry.Z ) ) }
        end

        local X = Argument2.X
        local Y = Argument2.Y
        local Z = Argument2.Z
        local I2 = 1

        for I2 = 1, Count do
            local Entry2 = Normalize_Mesh_Vertices2[ I2 ]
            local X2 = Entry2.X * X
            local Y2 = Entry2.Y * Y
            Create[ I2 ] = {
                Position = Argument1:PointToWorldSpace( ( Vector3.new( X2, Y2, Entry2.Z * Z ) ) )
            }
        end

        return Create, Create2
    end
    if not Module:IsA( "MeshPart" ) then
        return { }, { }
    end

    local Get = Text.Get( Module )

    if Get then
        return Cached_Mesh_Faces( Get, Argument1, Argument2, Argument4, Amount )
    end
    Text.Request( Module )
    return { }, { }
end
