-- ReplicatedStorage.RedZoneConfig
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    WARNING = 60,
    DURATION = 600,
    CASH_MULT = 1.2,
    PRIZES = { 500000, 250000, 100000 },
    MIN_KILLS = 5,
    SPAWN_MARGIN = 40,
    FINAL_COUNT = 10,
    RESULTS_TIME = 10,
    COLOR = Color3.fromRGB( 235, 40, 50 ),
    COLOR_HOT = Color3.fromRGB( 255, 70, 80 ),
    WALL_HEIGHT = 55,
    PILLAR_HEIGHT = 320,
    HEX_CELL = 18,
    GROUND_STEP = 6,
    TEX_HEX = "rbxassetid://124021671884556",
    TEX_BANDS = "rbxassetid://75062171207616",
    TEX_LINE = "rbxassetid://99543846460258",
    TEX_EMBER = "rbxassetid://9841273544",
    Inside = function( List, Argument2, Amount )
        local Number = Amount or 0
        local Value1 = nil

        for Key, Value in List or { }, nil, nil do
            local PointToObjectSpace = Value.cf:PointToObjectSpace( Argument2 )

            if math.abs( PointToObjectSpace.X ) <= Value.size.X / 2 + Number and math.abs( PointToObjectSpace.Z ) <= Value.size.Z / 2 + Number then
                if math.abs( PointToObjectSpace.Y ) <= Value.size.Y / 2 then
                    return true
                end
            end
        end

        return false
    end,
    Boxes = function( Object )
        local Descendants
        local Table = { }
        Descendants = Object and Object:GetDescendants( ) or { }
        local Value1 = nil

        for Key, Value in Descendants, nil, nil do
            if Value:IsA( "BasePart" ) then
                table.insert( Table, { cf = Value.CFrame, size = Value.Size } )
            end
        end

        return Table
    end
}
function Table.Outline( List )
    local Value1
    local TableInner = { }

    local function InsideOther( Argument1, Argument2 )
        local Value1 = nil

        for Key, Value in List, nil, nil do
            if Value ~= Argument2 then
                if Table.Inside( { Value }, Argument1, 0 ) then
                    return true
                end
            end
        end

        return false
    end

    local function Add( Argument1, Argument2 )
        if ( Argument2 - Argument1 ).Magnitude >= 1 then
            local X = Argument1.X
            local Vector32 = Vector3.new( X, 0, Argument1.Z )
            local X2 = Argument2.X
            table.insert( TableInner, { a = Vector32, b = Vector3.new( X2, 0, Argument2.Z ) } )
        end
    end

    Value1 = nil

    for Key, Value in List, nil, nil do
        local X = Value.size.X / 2
        local Z = Value.size.Z / 2
        local Amount = -X
        local Table2 = {
            Vector3.new( Amount, 0, -Z ),
            Vector3.new( X, 0, -Z ),
            Vector3.new( X, 0, Z ),
            ( Vector3.new( -X, 0, Z ) )
        }
        local J = 1

        for J = 1, 4 do
            local Min2
            local PointToWorldSpace = Value.cf:PointToWorldSpace( Table2[ J ] )
            local PointToWorldSpace2 = Value.cf:PointToWorldSpace( Table2[ J % 4 + 1 ] )
            local PointToWorldSpace3 = PointToWorldSpace2 - PointToWorldSpace
            local Magnitude = PointToWorldSpace3.Magnitude
            local PointToWorldSpace4 = ( PointToWorldSpace + PointToWorldSpace2 ) / 2 - Value.cf.Position
            local X2 = PointToWorldSpace4.X
            local Unit = Vector3.new( X2, 0, PointToWorldSpace4.Z ).Unit
            local Max = math.max( 1, ( math.ceil( Magnitude / 2 ) ) )
            local K = 0
            Min2 = nil

            for K = 0, Max do
                local Flag
                local Min = math.min( K * 2, Magnitude )
                local PointToWorldSpace5 = PointToWorldSpace + PointToWorldSpace3.Unit * Min

                if K < Max then
                    local NotInsideOther = not InsideOther( PointToWorldSpace5 + Unit * 0.5, Value )

                    if NotInsideOther then
                        Flag = not InsideOther( PointToWorldSpace5 - Unit * 0.5, Value )
                    else
                        Flag = NotInsideOther
                    end
                else
                    Flag = false
                end
                if Flag and not Min2 then
                    Min2 = Min
                end
                if not Flag or K == Max then
                    if Min2 then
                        local Magnitude2
                        local PointToWorldSpace6 = PointToWorldSpace + PointToWorldSpace3.Unit * Min2
                        local Unit2 = PointToWorldSpace3.Unit
                        Magnitude2 = Flag and Magnitude or Min
                        local PointToWorldSpace7 = PointToWorldSpace + Unit2 * Magnitude2

                        if ( PointToWorldSpace7 - PointToWorldSpace6 ).Magnitude >= 1 then
                            local X3 = PointToWorldSpace6.X
                            local Vector32 = Vector3.new( X3, 0, PointToWorldSpace6.Z )
                            local X4 = PointToWorldSpace7.X
                            table.insert( TableInner, { a = Vector32, b = Vector3.new( X4, 0, PointToWorldSpace7.Z ) } )
                        end

                        Min2 = nil
                    end
                end
            end
        end
    end

    return TableInner
end
return Table
