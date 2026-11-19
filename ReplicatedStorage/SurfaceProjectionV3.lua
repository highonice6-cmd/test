-- ReplicatedStorage.SurfaceProjectionV3
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local AssetService = game:GetService( "AssetService" )
local Text = require( "@self/Modules/Mesher" )
local Text2 = require( "@self/Modules/Slicer" )
local Text3 = require( "@self/Modules/Builder" )
local CFrame2 = CFrame.new( 0, 10, 0 )
local Table = {
    CollisionFidelity = Enum.CollisionFidelity.Box,
    FluidFidelity = Enum.FluidFidelity.UseCollisionGeometry
}
local Table2 = { FixedSize = true }
local Cylinder = Enum.PartType.Cylinder
local Ball = Enum.PartType.Ball

local function Append_Mesh_Data( Argument1, List, List2 )
    if not List or not List2 then
        return
    end
    if #List > 0 then
        local Count = #Argument1.Vertices
        local Count2 = #List
        local I = 1

        for I = 1, Count2 do
            local Vertices = Argument1.Vertices
            table.insert( Vertices, List[ I ] )
        end

        local Value1 = nil

        for Key, Value in List2, nil, nil do
            local Faces = Argument1.Faces
            table.insert( Faces, { Value[ 1 ] + Count, Value[ 2 ] + Count, Value[ 3 ] + Count } )
        end

        return
    end
    local Value2
    local Table = { }
    Value2 = nil

    for Key2, Value3 in List, nil, nil do
        Table[ Key2 ] = #Argument1.Vertices + 1
        table.insert( Argument1.Vertices, Value3 )
    end

    local Value4 = nil

    for Key3, Value5 in List2, nil, nil do
        local Entry = Table[ Value5[ 1 ] ]
        local Entry2 = Table[ Value5[ 2 ] ]
        local Entry3 = Table[ Value5[ 3 ] ]

        if Entry and Entry2 and Entry3 then
            table.insert( Argument1.Faces, { Entry, Entry2, Entry3 } )
        end
    end

    return
end

return function( CFrame, Argument2, Argument3, Argument4 )
    local Vector33
    local Position = Argument2 or Vector3.new( 5, 5, 5 )

    if typeof( Position ) == "number" then
        local Vector32 = Vector3.new( Position, Position, Position )

        if Vector32 then
            Vector33 = Vector32
        else
            Vector33 = Position
        end
    else
        Vector33 = Position
    end

    local TableInner = { }
    local Table2Inner = { Vertices = { }, Faces = { } }
    local PartBoundsInBox = workspace:GetPartBoundsInBox( CFrame or CFrame2, Vector33, Argument3 )

    if not PartBoundsInBox or #PartBoundsInBox < 1 then
        return
    end

    local Value1 = nil

    for Key, Value in PartBoundsInBox, nil, nil do
        if Value:IsA( "BasePart" ) then
            local Size = Value.Size

            if Value:IsA( "MeshPart" ) then
                local Value16, Value17 = Text3( Value.CFrame, Size, Value, CFrame or CFrame2, Vector33 )
                Append_Mesh_Data( Table2Inner, Value16, Value17 )
            elseif Value:IsA( "TrussPart" ) then
                local CFrame3 = Value.CFrame
                local Value18, Value19 = Text3( CFrame3, Size, script.Meshes.Block )
                Append_Mesh_Data( Table2Inner, Value18, Value19 )
            else
                local Vector34
                local Shape = Value.Shape

                if Shape == Ball then
                    local X = Size.X
                    local Y = Size.Y
                    local Min = math.min( X, Y, Size.Z )
                    Vector34 = Vector3.new( Min, Min, Min )
                else
                    Vector34 = Size
                end
                if Shape == Cylinder then
                    local X2 = Vector34.X
                    local Y2 = Vector34.Y
                    local Min2 = math.min( X2, Y2, Vector34.Z )
                    Vector34 = Vector3.new( Vector34.X, Min2, Min2 )
                end

                local CFrame4 = Value.CFrame
                local Value20, Value21 = Text3( CFrame4, Vector34, script.Meshes:FindFirstChild( Shape.Name ) )
                Append_Mesh_Data( Table2Inner, Value20, Value21 )
            end
        end
    end
    if Argument4 then
        local Value2
        local ZVector = ( CFrame or CFrame2 ).ZVector
        local Faces = { }
        local Faces2 = Table2Inner.Faces
        Value2 = nil

        for Key2, Value3 in Faces2, nil, nil do
            local Position2 = Table2Inner.Vertices[ Value3[ 1 ] ].Position
            local Position3 = Table2Inner.Vertices[ Value3[ 2 ] ].Position
            local Position4 = Table2Inner.Vertices[ Value3[ 3 ] ].Position
            local Cross = ( Position3 - Position2 ):Cross( Position4 - Position2 )
            local Magnitude = Cross.Magnitude

            if Magnitude > 0 and Argument4 * Magnitude <= Cross:Dot( ZVector ) then
                table.insert( Faces, Value3 )
            end
        end

        Table2Inner.Faces = Faces
    end

    local CFrame2Inner = CFrame.new( )
    local Value4, Value5 = Text2( Table2Inner, CFrame2Inner, ( CFrame or CFrame2 ) * CFrame.new( 0, Vector33.Y / 2, 0 ) * CFrame.Angles( 0, 0, 3.141592653589793 ) )
    local Table3 = { Vertices = { }, Faces = { } }
    Append_Mesh_Data( Table3, Value4, Value5 )
    local Value6, Value7 = Text2( Table3, CFrame2Inner, ( CFrame or CFrame2 ) * CFrame.new( 0, -Vector33.Y / 2, 0 ) )
    local Table4 = { Vertices = { }, Faces = { } }
    Append_Mesh_Data( Table4, Value6, Value7 )
    local Value8, Value9 = Text2( Table4, CFrame2Inner, ( CFrame or CFrame2 ) * CFrame.new( Vector33.X / 2, 0, 0 ) * CFrame.Angles( 0, 0, 1.5707963267948966 ) )
    local Table5 = { Vertices = { }, Faces = { } }
    Append_Mesh_Data( Table5, Value8, Value9 )
    local Value10, Value11 = Text2( Table5, CFrame2Inner, ( CFrame or CFrame2 ) * CFrame.new( -Vector33.X / 2, 0, 0 ) * CFrame.Angles( 0, 0, -1.5707963267948966 ) )
    local Table6 = { Vertices = { }, Faces = { } }
    Append_Mesh_Data( Table6, Value10, Value11 )
    local Value12, Value13 = Text2( Table6, CFrame2Inner, ( CFrame or CFrame2 ) * CFrame.new( 0, 0, -Vector33.Z / 2 ) * CFrame.Angles( 1.5707963267948966, 0, 0 ) )
    local Table7 = { Vertices = { }, Faces = { } }
    Append_Mesh_Data( Table7, Value12, Value13 )
    local Value14, Value15 = Text2( Table7, CFrame2Inner, ( CFrame or CFrame2 ) * CFrame.new( 0, 0, Vector33.Z / 2 ) * CFrame.Angles( -1.5707963267948966, 0, 0 ) )
    local Table8 = { Vertices = { }, Faces = { } }
    Append_Mesh_Data( Table8, Value14, Value15 )

    if #Table8.Vertices < 3 then
        return
    end
    local CreateEditableMesh = AssetService:CreateEditableMesh( )
    Text( CreateEditableMesh, Table8, CFrame or CFrame2, Vector33 )
    CreateEditableMesh:RemoveUnused( )
    local CreateEditableMesh2 = AssetService:CreateEditableMeshAsync( Content.fromObject( CreateEditableMesh ), Table2 )
    local CreateMeshPart = AssetService:CreateMeshPartAsync( Content.fromObject( CreateEditableMesh2 ), Table )
    CreateMeshPart:ApplyMesh( CreateMeshPart )
    CreateMeshPart.CFrame = CFrame or CFrame2
    CreateMeshPart.Name = "Surface Projection"
    CreateMeshPart.CanCollide = false
    CreateMeshPart.CanQuery = false
    CreateMeshPart.Anchored = true
    CreateEditableMesh:Destroy( )
    return CreateMeshPart, CreateEditableMesh2
end
