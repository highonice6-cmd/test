-- ReplicatedStorage.Weapons.VehicleSurface
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Result2
local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Success, Result = pcall( function()
    return require( ReplicatedStorage:WaitForChild( "SurfaceProjectionV3", 5 ).Modules.MeshCache )
end )

if Success then
    Result2 = Result
else
    warn( "[VehicleSurface] MeshCache indisponible :", Result )
    Result2 = nil
end

local Readu32 = buffer.readu32

local function IsBody( Self )
    if not Self:IsA( "MeshPart" ) or Self.Transparency >= 0.9 then
        return false
    end

    local Flag
    local Lower = Self.Name:lower( )
    local Sub = Lower:sub( 1, 5 )

    if Sub == "glass" then
        Flag = false
    elseif Sub == "wheel" then
        Flag = false
    elseif Sub == "jente" then
        Flag = false
    elseif Sub == "phare" then
        Flag = false
    elseif Lower:sub( 1, 3 ) == "feu" then
        Flag = false
    elseif Lower:sub( 1, 6 ) == "armor_" then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function Slab( PointToObjectSpace, VectorToObjectSpace, List3 )
    local Table, Value1, Value2, Number, Number2
    Table = { "X", "Y", "Z" }
    Value1 = nil
    Value2 = nil
    Number = -math.huge
    Number2 = math.huge
    PointToObjectSpace = PointToObjectSpace
    VectorToObjectSpace = VectorToObjectSpace
    List3 = List3

    for Key, Value in Table, Value1, Value2 do
        local Entry = PointToObjectSpace[ Value ]
        local Entry2 = VectorToObjectSpace[ Value ]
        local Entry3 = List3[ Value ]

        if math.abs( Entry2 ) < 1e-09 then
            if Entry < -Entry3 or Entry3 < Entry then
                return nil
            end
            Value2 = Key
        else
            local Amount2, Entry5
            local Amount = ( -Entry3 - Entry ) / Entry2
            local Entry4 = ( Entry3 - Entry ) / Entry2

            if Entry4 < Amount then
                Amount2 = Entry4
                Entry5 = Amount
            else
                Amount2 = Amount
                Entry5 = Entry4
            end
            if Number < Amount2 then
                Number = Amount2
            end
            if Entry5 < Number2 then
                Number2 = Entry5
            end
            if Number2 < Number then
                return nil
            end
            Value2 = Key
        end
    end

    return Number, Number2
end

local Table = { }

local function MeshRay( Get, PointToObjectSpace, VectorToObjectSpace, Size, Argument5, Argument6 )
    local Result6, Cross3
    local Result = PointToObjectSpace / Size
    local Result2Inner = VectorToObjectSpace / Size
    local Result3 = Result + Result2Inner * Argument5
    local Result4 = Result + Result2Inner * Argument6
    local Vertices = Get.Vertices
    local Index = Get.Index
    local Query = Result2.Query
    local Query2 = Query( Get, Result3:Min( Result4 ), Result3:Max( Result4 ), Table )
    local I = 1
    Result6 = nil
    Cross3 = nil

    for I = 1, Query2 do
        local Entry = Table[ I ] * 12
        local Entry2 = Vertices[ Readu32( Index, Entry ) ]
        local Entry3 = Vertices[ Readu32( Index, Entry + 4 ) ]
        local Entry4 = Vertices[ Readu32( Index, Entry + 8 ) ]
        local Entry5 = Entry3 - Entry2
        local Entry6 = Entry4 - Entry2
        local Cross = Result2Inner:Cross( Entry6 )
        local Dot = Entry5:Dot( Cross )

        if math.abs( Dot ) > 1e-12 then
            local Dot2 = 1 / Dot
            local Result5 = Result - Entry2
            local Dot3 = Result5:Dot( Cross ) * Dot2

            if Dot3 >= 0 and Dot3 <= 1 then
                local Cross2 = Result5:Cross( Entry5 )
                local Dot4 = Result2Inner:Dot( Cross2 ) * Dot2

                if Dot4 >= 0 and Dot3 + Dot4 <= 1 then
                    local Dot5 = Entry6:Dot( Cross2 ) * Dot2

                    if Argument5 <= Dot5 and Dot5 <= Argument6 then
                        if not Result6 or Dot5 < Result6 then
                            Cross3 = ( Entry5 * Size ):Cross( Entry6 * Size )
                            Result6 = Dot5
                        end
                    end
                end
            end
        end
    end
    if not Result6 or Cross3.Magnitude < 1e-09 then
        return nil
    end

    local Unit2
    local Unit = Cross3.Unit
    Unit2 = if Unit:Dot( VectorToObjectSpace ) > 0 then -Unit else Unit
    return Result6, Unit2
end

local Class = setmetatable( { }, { __mode = "k" } )

local function BodyParts( PartsName )
    local Entry = Class[ PartsName ]

    if Entry then
        return Entry
    end
    if Entry == nil then
        local function Changed()
            Class[ PartsName ] = false
        end

        PartsName.DescendantAdded:Connect( Changed )
        PartsName.DescendantRemoving:Connect( Changed )
    end

    local Table = { }

    for Key, Value in PartsName:GetDescendants( ) do
        if IsBody( Value ) then
            table.insert( Table, Value )
        end
    end

    Class[ PartsName ] = Table
    return Table
end

local function SearchLen( Argument1, Argument2, Argument3, Amount )
    local Min2
    local CFrame = Argument1.CFrame
    local _, Value1 = Slab( CFrame:PointToObjectSpace( Argument2 ), CFrame:VectorToObjectSpace( Argument3 ), Argument1.Size / 2 )
    local Max = math.max( 6, ( Value1 or 0 ) + 0.2 )

    if Amount then
        local Min = math.min( Max, 3 + Amount )

        if Min then
            Min2 = Min
        else
            Min2 = Max
        end
    else
        Min2 = Max
    end

    return Min2
end

local Table2 = {
    IsBody = IsBody,
    Find = function( Argument1, Argument2, Argument3, Amount )
        if not Result2 or Argument3.Magnitude < 1e-06 then
            return nil
        end

        local Parent = Argument1.Parent

        if not Parent then
            return nil
        end

        local Min2
        local Unit = Argument3.Unit
        local Unit2 = Argument2 - Unit * 3
        local CFrame = Argument1.CFrame
        local _, Value1 = Slab( CFrame:PointToObjectSpace( Unit2 ), CFrame:VectorToObjectSpace( Unit ), Argument1.Size / 2 )
        local Max = math.max( 6, ( Value1 or 0 ) + 0.2 )

        if Amount then
            local Min = math.min( Max, 3 + Amount )

            if Min then
                Min2 = Min
            else
                Min2 = Max
            end
        else
            Min2 = Max
        end

        local Value3, Value4, Value5, CFrame2
        Value3 = nil
        Value4 = nil
        Value5 = nil
        CFrame2 = nil

        for Key, Value in BodyParts( Parent ) do
            if Value.Transparency < 0.9 then
                local CFrame3 = Value.CFrame
                local Size = Value.Size
                local PointToObjectSpace = CFrame3:PointToObjectSpace( Unit2 )
                local VectorToObjectSpace = CFrame3:VectorToObjectSpace( Unit )
                local Value6, Value7 = Slab( PointToObjectSpace, VectorToObjectSpace, Size / 2 )

                if Value6 and Value7 >= 0 and Value6 <= Min2 then
                    if not Value3 or Value6 < Value3 then
                        local State = Result2.State( Value )

                        if State == "ready" then
                            local Get = Result2.Get( Value )
                            Value8, Value5 = MeshRay( Get, PointToObjectSpace, VectorToObjectSpace, Size, math.max( Value6, 0 ), ( math.min( Value7, Min2 ) ) )

                            if Value8 then
                                if not Value3 or Value8 < Value3 then
                                    Value3 = Value8
                                    Value4 = Value
                                    CFrame2 = CFrame3
                                end
                            end
                        elseif State == "new" then
                            Result2.Request( Value )
                        end
                    end
                end
            end
        end
        if Value3 then
            return Value4, Unit2 + Unit * Value3, CFrame2:VectorToWorldSpace( Value5 )
        end
        return nil
    end,
    Covers = function( Argument1, Argument2, Argument3, Amount )
        local Descendants, Descendants2, Descendants3, Flag, Unit3, Unit4, Min2

        if not Result2 or Argument3.Magnitude < 1e-06 then
            return nil
        end

        local Parent = Argument1.Parent

        if not Parent then
            return nil
        end

        local Unit = Argument3.Unit
        local Unit2 = Argument2 - Unit * 3
        local CFrame = Argument1.CFrame
        local _, Value1 = Slab( CFrame:PointToObjectSpace( Unit2 ), CFrame:VectorToObjectSpace( Unit ), Argument1.Size / 2 )
        local Max = math.max( 6, ( Value1 or 0 ) + 0.2 )

        if Amount then
            local Min = math.min( Max, 3 + Amount )

            if Min then
                Min2 = Min
            else
                Min2 = Max
            end
        else
            Min2 = Max
        end

        Descendants, Descendants2, Descendants3 = Parent:GetDescendants( )
        Flag = false
        Unit3 = Unit2
        Unit4 = Unit

        for Key, Value in Descendants, Descendants2, Descendants3 do
            if IsBody( Value ) then
                local CFrame2 = Value.CFrame
                local Size = Value.Size
                local PointToObjectSpace = CFrame2:PointToObjectSpace( Unit3 )
                local VectorToObjectSpace = CFrame2:VectorToObjectSpace( Unit4 )
                local Value2, Value3 = Slab( PointToObjectSpace, VectorToObjectSpace, Size / 2 )

                if not Value2 or not ( Value3 >= 0 ) or not ( Value2 <= Min2 ) then
                    Descendants3 = Key
                else
                    local State = Result2.State( Value )

                    if State == "ready" then
                        local Get = Result2.Get( Value )

                        if MeshRay( Get, PointToObjectSpace, VectorToObjectSpace, Size, math.max( Value2, 0 ), ( math.min( Value3, Min2 ) ) ) then
                            return true
                        end
                        Descendants3 = Key
                    elseif State == "new" then
                        Result2.Request( Value )
                        Descendants3 = Key
                        Flag = true
                    else
                        Descendants3 = Key
                        Flag = true
                    end
                end
            else
                Descendants3 = Key
            end
        end
        if Flag then
            return nil
        end
        return false
    end,
    Raycast = function( Argument1, Argument2, Argument3, Argument4 )
        if not Result2 or Argument2.Magnitude < 1e-06 then
            return nil
        end

        local Find = WorldRefs.Find( "Cars" )

        if not Find then
            return nil
        end

        local Value1, Value2, Value3, CFrame
        local Unit = Argument2.Unit
        Value1 = nil
        Value2 = nil
        Value3 = nil
        CFrame = nil

        for Key, Value in Find:GetChildren( ) do
            if Value ~= Argument4 then
                for Key2, Value5 in BodyParts( Value ) do
                    if Value5.Transparency < 0.9 then
                        local CFrame2 = Value5.CFrame
                        local Size = Value5.Size
                        local PointToObjectSpace = CFrame2:PointToObjectSpace( Argument1 )
                        local VectorToObjectSpace = CFrame2:VectorToObjectSpace( Unit )
                        local Value6, Value7 = Slab( PointToObjectSpace, VectorToObjectSpace, Size / 2 )

                        if Value6 and Value7 >= 0 and Value6 <= Argument3 then
                            if not Value1 or Value6 < Value1 then
                                local State = Result2.State( Value5 )

                                if State == "ready" then
                                    local Get = Result2.Get( Value5 )
                                    Value8, Value3 = MeshRay( Get, PointToObjectSpace, VectorToObjectSpace, Size, math.max( Value6, 0 ), ( math.min( Value7, Argument3 ) ) )

                                    if Value8 then
                                        if not Value1 or Value8 < Value1 then
                                            Value1 = Value8
                                            Value2 = Value5
                                            CFrame = CFrame2
                                        end
                                    end
                                elseif State == "new" then
                                    Result2.Request( Value5 )
                                end
                            end
                        end
                    end
                end
            end
        end
        if Value1 then
            local Unit2 = Argument1 + Unit * Value1
            return Unit2, Value2, Value1, CFrame:VectorToWorldSpace( Value3 )
        end
        return nil
    end
}
task.spawn( function()
    if not Result2 then
        return
    end

    local Wait = WorldRefs.Wait( "Cars", 30 )

    if not Wait then
        return
    end
    for Key, Value in Wait:GetDescendants( ) do
        if IsBody( Value ) then
            Result2.Request( Value )
        end
    end

    Wait.DescendantAdded:Connect( function( Self )
        if IsBody( Self ) then
            Result2.Request( Self )
        end
    end )
end )
return Table2
