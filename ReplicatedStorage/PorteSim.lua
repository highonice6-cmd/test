-- ReplicatedStorage.PorteSim
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    R = 1.3,
    MARGE = 0.3141592653589793,
    RETOUR = 2.4,
    RETOUR_MIN = 0.5235987755982988,
    CELL = 24
}

local function Wrap( Amount )
    return ( Amount + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793
end

function Table.Step( Argument1, List, Argument3 )
    local Value1
    local A = Argument1.A
    local U = Argument1.u
    local H = Argument1.H
    local L = Argument1.L
    local R = Table.R
    local Amount = -Argument1.maxA
    local MaxA = Argument1.maxA
    local Theta = Argument1.theta
    local Sides = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Y = Value.pos.Y

        if not ( Y < Argument1.yMin - 3 ) and not ( Argument1.yMax + 1 < Y ) then
            local Pos = Value.pos - H
            local Pos2 = Pos - A * Pos:Dot( A )
            local Magnitude = Pos2.Magnitude

            if not ( Magnitude < 0.3 ) and not ( L + R < Magnitude ) then
                local Asin
                local Dot = A:Dot( U:Cross( Pos2 ) )
                local Atan2 = ( math.atan2( Dot, ( U:Dot( Pos2 ) ) ) - Theta + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793

                if Magnitude <= L then
                    Asin = math.asin( ( math.min( 1, R / Magnitude ) ) )
                else
                    Asin = math.acos( ( math.clamp( ( Magnitude * Magnitude + L * L - R * R ) / ( 2 * Magnitude * L ), -1, 1 ) ) )
                end

                local Abs = math.abs( Atan2 )

                if not ( Asin + Table.MARGE < Abs ) then
                    local Entry2
                    local Entry = Argument1.sides[ Value.id ]

                    if Entry then
                        Entry2 = Entry
                    elseif Atan2 >= 0 then
                        Entry2 = 1
                    else
                        Entry2 = -1
                    end

                    Sides[ Value.id ] = Entry2

                    if Entry2 > 0 then
                        MaxA = math.min( MaxA, Theta + Atan2 - Asin )
                    else
                        Amount = math.max( Amount, Theta + Atan2 + Asin )
                    end
                end
            end
        end
    end

    local Theta3
    Argument1.sides = Sides
    local Theta2 = Theta * math.min( 1, Table.RETOUR * Argument3 )
    local RETOUR_MIN = Table.RETOUR_MIN * Argument3
    Theta3 = if math.abs( Theta2 ) < RETOUR_MIN then math.sign( Theta ) * math.min( math.abs( Theta ), RETOUR_MIN ) else Theta2
    local Clamp
    local Theta4 = Theta - Theta3

    if Amount <= MaxA then
        Clamp = math.clamp( Theta4, Amount, MaxA )
    else
        Clamp = Theta
    end

    local Amount2 = -Argument1.maxA
    return ( math.clamp( Clamp, Amount2, Argument1.maxA ) )
end
function Table.Pose( Argument1, Argument2 )
    return CFrame.new( Argument1.H ) * CFrame.fromAxisAngle( Argument1.A, Argument2 ) * CFrame.new( -Argument1.H ) * Argument1.PF
end
function Table.FromModel( Model )
    local PF = Model:GetAttribute( "PF" )
    local PCh = Model:GetAttribute( "PCh" )
    local PAx = Model:GetAttribute( "PAx" )
    local PrimaryPart = Model.PrimaryPart

    if not PF or not PCh or not PAx or not PrimaryPart then
        return nil
    end

    local Unit = PAx.Unit
    local PF2 = PF * Model:GetPivot( ):ToObjectSpace( PrimaryPart.CFrame )
    local Position = PF2.Position - PCh
    local Position2 = Position - Unit * Position:Dot( Unit )

    if Position2.Magnitude < 0.05 then
        return nil
    end

    local Value1, Number, Number2, Number3
    local Unit2 = Position2.Unit
    local Table = { -1, 1 }
    Value1 = nil
    Number = 0
    Number2 = math.huge
    Number3 = -math.huge

    for Key, Value in Table, nil, nil do
        local Value2
        local Table2 = { -1, 1 }
        Value2 = nil

        for Key2, Value3 in Table2, nil, nil do
            local Value4
            local Table3 = { -1, 1 }
            Value4 = nil

            for Key3, Value5 in Table3, nil, nil do
                local PointToWorldSpace = PF2:PointToWorldSpace( PrimaryPart.Size / 2 * Vector3.new( Value, Value3, Value5 ) )
                Number = math.max( Number, ( PointToWorldSpace - PCh ):Dot( Unit2 ) )
                Number2 = math.min( Number2, PointToWorldSpace.Y )
                Number3 = math.max( Number3, PointToWorldSpace.Y )
            end
        end
    end

    return {
        m = Model,
        PF = PF,
        H = PCh,
        A = Unit,
        u = Unit2,
        L = Number,
        yMin = Number2,
        yMax = Number3,
        maxA = math.rad( Model:GetAttribute( "Angle" ) or 90 ),
        theta = 0,
        sides = { }
    }
end

local function Key( Amount, Argument2 )
    return Amount * 100003 + Argument2
end

function Table.Grid()
    return { cells = { } }
end
function Table.Add( Argument1, Argument2 )
    local Entry2
    local CELL = Table.CELL
    local Floor = math.floor( Argument2.H.X / CELL )
    local Floor2 = math.floor( Argument2.H.Z / CELL )
    local Floor3 = Floor * 100003 + Floor2
    local Cells = Argument1.cells
    local Entry = Argument1.cells[ Floor3 ]
    Entry2 = if Entry then Entry else { }
    Cells[ Floor3 ] = Entry2
    table.insert( Argument1.cells[ Floor3 ], Argument2 )
end
function Table.Near( Argument1, List )
    local Value1
    local CELL = Table.CELL
    local TableInner = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Floor = math.floor( Value.pos.X / CELL )
        local Floor2 = math.floor( Value.pos.Z / CELL )
        local J = -1

        for J = -1, 1 do
            local K = -1

            for K = -1, 1 do
                local Cells = Argument1.cells
                local Floor3 = Floor + J
                local Floor4 = Floor2 + K
                local Entry = Cells[ Floor3 * 100003 + Floor4 ]

                if Entry then
                    local Value2 = nil

                    for Key2, Value3 in Entry, nil, nil do
                        if ( Value.pos - Value3.H ).Magnitude < Value3.L + 4 + ( Value3.yMax - Value3.yMin ) then
                            local Entry3
                            local Entry2 = TableInner[ Value3 ]
                            Entry3 = if Entry2 then Entry2 else { }
                            TableInner[ Value3 ] = Entry3
                            table.insert( TableInner[ Value3 ], Value )
                        end
                    end
                end
            end
        end
    end

    return TableInner
end
return Table
