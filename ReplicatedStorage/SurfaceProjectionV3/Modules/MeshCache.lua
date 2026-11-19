-- ReplicatedStorage.SurfaceProjectionV3.Modules.MeshCache
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local AssetService = game:GetService( "AssetService" )
local Table = { FixedSize = true }
local Floor = math.floor
local Clamp = math.clamp
local Readf32 = buffer.readf32
local Readu32 = buffer.readu32
local Writef32 = buffer.writef32
local Writeu32 = buffer.writeu32
local Table2 = { }
local Table3 = { }

for Value in string.gmatch( "100717994269080,103108519208163,104232436494336,104844720900803,105278445362523,105625815155021,105794757031379,105856708445067,106083462413913,107070314592142,107240141467700,107979300769756,108603988228979,109830387909566,110675696658884,111065730808325,111251526384420,111376274230864,111627050625073,112857905756598,113287734482404,113297594895882,113354370548589,114571007961407,116491017026097,116582579316598,119278655060105,120057604347543,120791650022584,120869984732567,121597466995207,121642878939603,121971828004075,125305377016148,125860023434269,126798375510599,126840896559468,127140202057807,127382564766546,130122807280044,130217289311251,132005388914148,132382559605695,132507761052665,134283991415492,135514783345958,135902379608572,136159635770393,136398313259102,136802147013865,136883356618526,137497675575562,140256620588935,70564198294708,71106307552084,71701422383117,74688458203088,76252524529332,76903060243867,78441429436118,78581934096577,79936686849844,80092895669639,80417844703389,80792020352719,80815472428320,80830313377957,82687512882922,83421930209116,84257203133000,84773191780924,86164735335462,86292915136562,86396696323760,87141084858280,88106660359327,88142027930343,88602269465230,88783779111282,92401018580379,92655623521691,92784440144937,94081709317886,94518173886385,96188865582770,96500920932685,96525979108939,97155284444921,97366383789650,97633517189850,97933314316502,99583862233375", "%d+" ) do
    Table3[ Value ] = true
end

local Table4 = { }
local Number = 0
local Number2 = 0

local function Build_Grid( Argument1, Amount, Amount2, Argument4, Callback )
    local Number
    local Result = Amount2 * Amount2 * Amount2
    local Create = buffer.create( ( Result + 1 ) * 4 )
    Number = not Argument4 and 2 or 1
    local Number2, Create2, Create3
    local I = 1
    Number2 = 0
    Create3 = nil
    Create2 = nil

    for I = 1, Number do
        if I == 2 then
            local J = 1

            for J = 1, Result do
                local Result2 = J * 4
                Writeu32( Create, Result2, Readu32( Create, J * 4 ) + Readu32( Create, J * 4 - 4 ) )
            end

            Create2 = buffer.create( math.max( Number2, 1 ) * 4 )
            Create3 = buffer.create( Result * 4 )
        end

        local Total = Amount - 1
        local J2 = 0

        for J2 = 0, Total do
            local Result3 = J2 * 24
            local Floor2 = Floor( ( Readf32( Argument1, Result3 ) + 0.5 ) * Amount2 )
            local Clamp2 = Clamp( Floor2, 0, Amount2 - 1 )
            local Floor3 = Floor( ( Readf32( Argument1, Result3 + 4 ) + 0.5 ) * Amount2 )
            local Clamp3 = Clamp( Floor3, 0, Amount2 - 1 )
            local Floor4 = Floor( ( Readf32( Argument1, Result3 + 8 ) + 0.5 ) * Amount2 )
            local Clamp4 = Clamp( Floor4, 0, Amount2 - 1 )
            local Floor5 = Floor( ( Readf32( Argument1, Result3 + 12 ) + 0.5 ) * Amount2 )
            local Clamp5 = Clamp( Floor5, 0, Amount2 - 1 )
            local Floor6 = Floor( ( Readf32( Argument1, Result3 + 16 ) + 0.5 ) * Amount2 )
            local Clamp6 = Clamp( Floor6, 0, Amount2 - 1 )
            local Floor7 = Floor( ( Readf32( Argument1, Result3 + 20 ) + 0.5 ) * Amount2 )
            local Clamp7 = Clamp( Floor7, 0, Amount2 - 1 )
            local K = Clamp2

            for K = Clamp2, Clamp5 do
                local Index3 = Clamp3

                for Index3 = Clamp3, Clamp6 do
                    local Index4 = Clamp4

                    for Index4 = Clamp4, Clamp7 do
                        local Result4 = ( ( K * Amount2 + Index3 ) * Amount2 + Index4 ) * 4

                        if I == 1 then
                            local Result5 = Result4 + 4
                            Writeu32( Create, Result5, Readu32( Create, Result4 + 4 ) + 1 )
                            Number2 = Number2 + 1
                        else
                            local Readu322 = Readu32( Create3, Result4 )
                            Writeu32( Create2, ( Readu32( Create, Result4 ) + Readu322 ) * 4, J2 )
                            Writeu32( Create3, Result4, Readu322 + 1 )
                        end
                    end
                end
            end
            if J2 % 256 == 255 then
                Callback( )
            end
        end
    end

    return Number2, Create, Create2
end

local function Read_Mesh( Argument1 )
    local Success, Result = pcall( function()
        return AssetService:CreateEditableMeshAsync( Argument1, Table )
    end )

    if not Success or not Result then
        return false
    end

    local Vertices = Result:GetVertices( )
    local Faces = Result:GetFaces( )
    local Count = #Vertices
    local Count2 = #Faces

    if Count2 == 0 or Count2 > 20000 then
        Result:Destroy( )
        return false
    end

    local Position2
    local Clock = os.clock( )

    local function Breathe()
        if os.clock( ) - Clock < 0.001 then
            return
        end
        task.wait( )
        Clock = os.clock( )
        return
    end

    local Create = table.create( Count )
    local TableInner = { }
    local Amount = -Vector3.new( math.huge, math.huge, math.huge )
    local I = 1
    Position2 = Vector3.new( math.huge, math.huge, math.huge )

    for I = 1, Count do
        local Entry = Vertices[ I ]
        local Position = Result:GetPosition( Entry )
        Create[ I ] = Position
        TableInner[ Entry ] = I
        Position2 = Position2:Min( Position )
        Amount = Amount:Max( Position )

        if I % 256 == 0 then
            if not ( os.clock( ) - Clock < 0.001 ) then
                task.wait( )
                Clock = os.clock( )
            end
        end
    end

    local Number
    local Position3 = ( Position2 + Amount ) / 2
    local Amount2 = Amount - Position2
    Number = if Amount2.X == 0 then 1 else Amount2.X
    local Number2 = if Amount2.Y == 0 then 1 else Amount2.Y
    local Number3 = if Amount2.Z == 0 then 1 else Amount2.Z
    local Vector32 = Vector3.new( Number, Number2, Number3 )
    local I2 = 1

    for I2 = 1, Count do
        Create[ I2 ] = ( Create[ I2 ] - Position3 ) / Vector32
    end

    local Number4
    local Create2 = buffer.create( Count2 * 12 )
    local Create3 = buffer.create( Count2 * 24 )
    local I3 = 1
    Number4 = 0

    for I3 = 1, Count2 do
        local FaceVertices = Result:GetFaceVertices( Faces[ I3 ] )
        local Entry2 = TableInner[ FaceVertices[ 1 ] ]
        local Entry3 = TableInner[ FaceVertices[ 2 ] ]
        local Entry4 = TableInner[ FaceVertices[ 3 ] ]

        if Entry2 and Entry3 and Entry4 then
            local Entry5 = Create[ Entry2 ]
            local Entry6 = Create[ Entry3 ]
            local Entry7 = Create[ Entry4 ]
            local Min = Entry5:Min( Entry6, Entry7 )
            local Max = Entry5:Max( Entry6, Entry7 )
            local Number5 = Number4 * 12
            Writeu32( Create2, Number5, Entry2 )
            Writeu32( Create2, Number5 + 4, Entry3 )
            Writeu32( Create2, Number5 + 8, Entry4 )
            local Number6 = Number4 * 24
            Writef32( Create3, Number6, Min.X )
            local Number7 = Number6 + 4
            Writef32( Create3, Number7, Min.Y )
            local Number8 = Number6 + 8
            Writef32( Create3, Number8, Min.Z )
            local Number9 = Number6 + 12
            Writef32( Create3, Number9, Max.X )
            local Number10 = Number6 + 16
            Writef32( Create3, Number10, Max.Y )
            local Number11 = Number6 + 20
            Writef32( Create3, Number11, Max.Z )
            Number4 = Number4 + 1
        end
        if I3 % 256 == 0 then
            if not ( os.clock( ) - Clock < 0.001 ) then
                task.wait( )
                Clock = os.clock( )
            end
        end
    end

    Result:Destroy( )

    if Number4 == 0 then
        return false
    end

    local Clamp2 = Clamp( Floor( ( Number4 / 2 ) ^ 0.3333333333333333 ), 1, 16 )

    while Value1 > 1 do
        local Build_Grid2 = Build_Grid( Create3, Number4, Value1, true, Breathe )

        if not ( Number4 * 8 < Build_Grid2 ) then
            break
        end

        Floor2 = Floor( Value1 / 2 )
    end

    local _, Value3, Value4 = Build_Grid( Create3, Number4, Value1, false, Breathe )
    local Table2 = {
        Vertices = Create,
        Count = Number4,
        Index = Create2,
        Bounds = Create3,
        Grid = Value1,
        Cell_Start = Value3,
        Cell_Faces = Value4,
        Stamp = buffer.create( Number4 * 4 ),
        Query = 0,
        Used = os.clock( )
    }
    return Table2
end

local function Remember( ID, Argument2 )
    Table2[ ID ] = Argument2

    if not Argument2 then
        return
    end

    Number2 = Number2 + Argument2.Count

    while Number2 > 200000 do
        local Value1, Value2, Value3
        Value1 = nil
        Value2 = nil
        Value3 = nil

        for Key2, Value in Table2, nil, nil do
            if type( Value ) == "table" and Value ~= Argument2 then
                if not Value2 or Value.Used < Value2.Used then
                    Value2 = Value
                    Value3 = Key2
                end
            end
        end
        if not Value2 then
            break
        end

        Table2[ Value3 ] = nil
        Number2 = Number2 - Value2.Count
    end
end

local function Next_Load()
    while Number < 2 do
        if not ( #Table4 > 0 ) then
            break
        end

        local Remove = table.remove( Table4, 1 )
        Number = Number + 1
        task.spawn( function()
            local Result2
            local Success, Result = pcall( Read_Mesh, Remove.Content )
            local ID = Remove.ID
            Result2 = Success and Result or false
            Remember( ID, Result2 )
            Number = Number - 1
            Next_Load( )
        end )
    end
end

local Table5 = {
    State = function( Argument1 )
        local Entry = Table2[ Argument1.MeshId ]

        if Argument1.MeshId == "" or Entry == false then
            return "unsupported"
        end
        if Entry == nil then
            return "new"
        end
        if Entry == "loading" then
            return "loading"
        end
        return "ready"
    end,
    Request = function( Argument1 )
        local MeshId = Argument1.MeshId

        if MeshId == "" or Table2[ MeshId ] ~= nil then
            return
        end

        local Match = string.match( MeshId, "(%d+)" )

        if not Match or not Table3[ Match ] then
            Table2[ MeshId ] = "loading"
            table.insert( Table4, { ID = MeshId, Content = Argument1.MeshContent } )
            Next_Load( )
            return
        end
        Table2[ MeshId ] = false
        return
    end,
    Get = function( Argument1 )
        local Entry = Table2[ Argument1.MeshId ]

        if type( Entry ) == "table" then
            Entry.Used = os.clock( )
            return Entry
        end
        return nil
    end,
    Query = function( Argument1, Argument2, Argument3, List )
        local X = Argument2.X
        local Y = Argument2.Y
        local Z = Argument2.Z
        local X2 = Argument3.X
        local Y2 = Argument3.Y
        local Z2 = Argument3.Z

        if X > 0.5 or Y > 0.5 or Z > 0.5 or X2 < -0.5 or Y2 < -0.5 or Z2 < -0.5 then
            return 0
        end

        local Number
        local Grid = Argument1.Grid
        local Floor2 = Floor( ( X + 0.5 ) * Grid )
        local Clamp2 = Clamp( Floor2, 0, Grid - 1 )
        local Floor3 = Floor( ( Y + 0.5 ) * Grid )
        local Clamp3 = Clamp( Floor3, 0, Grid - 1 )
        local Floor4 = Floor( ( Z + 0.5 ) * Grid )
        local Clamp4 = Clamp( Floor4, 0, Grid - 1 )
        local Floor5 = Floor( ( X2 + 0.5 ) * Grid )
        local Clamp5 = Clamp( Floor5, 0, Grid - 1 )
        local Floor6 = Floor( ( Y2 + 0.5 ) * Grid )
        local Clamp6 = Clamp( Floor6, 0, Grid - 1 )
        local Floor7 = Floor( ( Z2 + 0.5 ) * Grid )
        local Clamp7 = Clamp( Floor7, 0, Grid - 1 )
        local Bounds = Argument1.Bounds
        local Cell_Start = Argument1.Cell_Start
        local Cell_Faces = Argument1.Cell_Faces
        local Stamp = Argument1.Stamp
        local Query = Argument1.Query + 1
        Argument1.Query = Query
        local I = Clamp2
        Number = 0

        for I = Clamp2, Clamp5 do
            local J = Clamp3

            for J = Clamp3, Clamp6 do
                local K = Clamp4

                for K = Clamp4, Clamp7 do
                    local Grid2 = ( ( I * Grid + J ) * Grid + K ) * 4
                    local Readu322 = Readu32( Cell_Start, Grid2 )
                    local Total = Readu32( Cell_Start, Grid2 + 4 ) - 1
                    local Index3 = Readu322

                    for Index3 = Readu322, Total do
                        local Readu323 = Readu32( Cell_Faces, Index3 * 4 )

                        if Readu32( Stamp, Readu323 * 4 ) ~= Query then
                            Writeu32( Stamp, Readu323 * 4, Query )
                            local Result = Readu323 * 24

                            if not ( X2 < Readf32( Bounds, Result ) ) and not ( Readf32( Bounds, Result + 12 ) < X ) and not ( Y2 < Readf32( Bounds, Result + 4 ) ) and not ( Readf32( Bounds, Result + 16 ) < Y ) and not ( Z2 < Readf32( Bounds, Result + 8 ) ) and not ( Readf32( Bounds, Result + 20 ) < Z ) then
                                local Number2 = Number + 1
                                List[ Number2 ] = Readu323
                                Number = Number2
                            end
                        end
                    end
                end
            end
        end

        return Number
    end
}
return Table5
