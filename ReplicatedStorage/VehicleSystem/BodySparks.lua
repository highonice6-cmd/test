-- ReplicatedStorage.VehicleSystem.BodySparks
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local Debris = game:GetService( "Debris" )
local PhysicsService = game:GetService( "PhysicsService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Parent = script.Parent
local Eau = require( ReplicatedStorage:WaitForChild( "Eau" ) )
local MetalImpactAudio = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "MetalImpactAudio" ) )
local Table = { metal = true, concrete = true }
local Table2 = {
    Vector3.new( 1, 0, 0 ),
    Vector3.new( -1, -0, -0 ),
    Vector3.new( 0, 0, 1 ),
    Vector3.new( -0, -0, -1 ),
    Vector3.new( 0, 1, 0 ),
    Vector3.new( -0, -1, -0 )
}

local function DebugOn()
    local Flag
    Flag = workspace:GetAttribute( "DebugBodySparks" ) == true and true or false
    return Flag
end

local Class = setmetatable( { }, { __mode = "k" } )

local function Sparky( Key )
    local Flag
    local Entry = Class[ Key ]

    if Entry == nil then
        if Table[ MetalImpactAudio.SurfaceOf( Key ) or "" ] == true then
            Flag = true
        else
            Flag = false
        end

        Class[ Key ] = Flag
    else
        Flag = Entry
    end

    return Flag
end

local function CarOf( Argument1 )
    local Parent2
    local Parent = Argument1.Parent
    Parent2 = Parent and CollectionService:HasTag( Parent, "Vehicle" ) and Parent or nil
    return Parent2
end

local OverlapParams2 = OverlapParams.new( )
OverlapParams2.FilterType = Enum.RaycastFilterType.Exclude
OverlapParams2.RespectCanCollide = true
OverlapParams2.MaxParts = 24
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Include
RaycastParams2.RespectCanCollide = false
RaycastParams2.IgnoreWater = true
local Flag = false

local function UseCarGroup()
    if Flag then
        return
    end
    if PhysicsService:IsCollisionGroupRegistered( "VehicleHitbox" ) then
        OverlapParams2.CollisionGroup = "VehicleHitbox"
        RaycastParams2.CollisionGroup = "VehicleHitbox"
        Flag = true
    end
end

local function Finite( Amount )
    local Flag

    if Amount == Amount then
        if Amount > -10000000 then
            if Amount < 10000000 then
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

    return Flag
end

local function FiniteV( Argument1 )
    local Flag
    local X = Argument1.X

    if X == X then
        if X > -10000000 then
            if X < 10000000 then
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
    if Flag then
        local Y = Argument1.Y

        if Y == Y then
            if Y > -10000000 then
                if Y < 10000000 then
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
        if Flag then
            local Z = Argument1.Z

            if Z == Z then
                if Z > -10000000 then
                    if Z < 10000000 then
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
        end
    end

    return Flag
end

local function FiniteCF( Argument1 )
    local Flag
    local Position = Argument1.Position
    local X = Position.X

    if X == X then
        if X > -10000000 then
            if X < 10000000 then
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
    if Flag then
        local Y = Position.Y

        if Y == Y then
            if Y > -10000000 then
                if Y < 10000000 then
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
        if Flag then
            local Z = Position.Z

            if Z == Z then
                if Z > -10000000 then
                    if Z < 10000000 then
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
        end
    end
    if Flag then
        local LookVector = Argument1.LookVector
        local X2 = LookVector.X

        if X2 == X2 then
            if X2 > -10000000 then
                if X2 < 10000000 then
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
        if Flag then
            local Y2 = LookVector.Y

            if Y2 == Y2 then
                if Y2 > -10000000 then
                    if Y2 < 10000000 then
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
            if Flag then
                local Z2 = LookVector.Z

                if Z2 == Z2 then
                    if Z2 > -10000000 then
                        if Z2 < 10000000 then
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
            end
        end
        if Flag then
            local UpVector = Argument1.UpVector
            local X3 = UpVector.X

            if X3 == X3 then
                if X3 > -10000000 then
                    if X3 < 10000000 then
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
            if Flag then
                local Y3 = UpVector.Y

                if Y3 == Y3 then
                    if Y3 > -10000000 then
                        if Y3 < 10000000 then
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
                if Flag then
                    local Z3 = UpVector.Z

                    if Z3 == Z3 then
                        if Z3 > -10000000 then
                            if Z3 < 10000000 then
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
                end
            end
        end
    end

    return Flag
end

local function GoodSize( Argument1 )
    local Flag
    local X = Argument1.X

    if X == X then
        if X > -10000000 then
            if X < 10000000 then
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
    if Flag then
        local Y = Argument1.Y

        if Y == Y then
            if Y > -10000000 then
                if Y < 10000000 then
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
        if Flag then
            local Z = Argument1.Z

            if Z == Z then
                if Z > -10000000 then
                    if Z < 10000000 then
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
        end
    end
    if Flag then
        if Argument1.X > 0 then
            if Argument1.Y > 0 then
                if Argument1.Z > 0 then
                    if Argument1.Magnitude < 500 then
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
    end

    return Flag
end

local Class2 = setmetatable( { }, { __mode = "k" } )

local function WarnOnce( OnceName, Text )
    if Class2[ OnceName ] then
        return
    end
    Class2[ OnceName ] = true
    warn( "[BodySparks] " .. OnceName:GetFullName( ) .. " : " .. Text .. " -> étincelles de carrosserie coupées pour elle tant que c'est invalide" )
    return
end

local function ClampInto( Self, Amount, Argument3 )
    local Flag
    local PointToObjectSpace = Self:PointToObjectSpace( Argument3 )
    local Result = Amount / 2
    local X = PointToObjectSpace.X

    if X == X then
        if X > -10000000 then
            if X < 10000000 then
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
    if Flag then
        local Y = PointToObjectSpace.Y

        if Y == Y then
            if Y > -10000000 then
                if Y < 10000000 then
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
        if Flag then
            local Z = PointToObjectSpace.Z

            if Z == Z then
                if Z > -10000000 then
                    if Z < 10000000 then
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
        end
    end
    if Flag then
        local Flag2
        local X2 = Result.X

        if X2 == X2 then
            if X2 > -10000000 then
                if X2 < 10000000 then
                    Flag2 = true
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end
        if Flag2 then
            local Y2 = Result.Y

            if Y2 == Y2 then
                if Y2 > -10000000 then
                    if Y2 < 10000000 then
                        Flag2 = true
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end
            if Flag2 then
                local Z2 = Result.Z

                if Z2 == Z2 then
                    if Z2 > -10000000 then
                        if Z2 < 10000000 then
                            Flag2 = true
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            end
        end
        if Flag2 and not ( Result.X < 0 ) and not ( Result.Y < 0 ) and not ( Result.Z < 0 ) then
            local X3 = PointToObjectSpace.X
            local Amount2 = -Result.X
            local Clamp = math.clamp( X3, Amount2, Result.X )
            local Y3 = PointToObjectSpace.Y
            local Amount3 = -Result.Y
            local Clamp2 = math.clamp( Y3, Amount3, Result.Y )
            local Z3 = PointToObjectSpace.Z
            local Amount4 = -Result.Z
            return Self:PointToWorldSpace( ( Vector3.new( Clamp, Clamp2, ( math.clamp( Z3, Amount4, Result.Z ) ) ) ) )
        end
    end

    return Argument3
end

local Class3 = setmetatable( { }, { __mode = "k" } )

local function HullOf( Key, Argument2 )
    local Entry = Class3[ Key ]

    if Entry and Entry.box == Argument2 and Entry.size == Argument2.Size then
        return Entry
    end

    local Table = { }
    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

    for Key2, Value in Key:GetChildren( ) do
        if Value:IsA( "BasePart" ) and Value.Name:sub( 1, 17 ) == "VehicleCollision_" then
            local ToObjectSpace = Argument2.CFrame:ToObjectSpace( Value.CFrame )
            local Size = Value.Size
            local Abs = math.abs( ToObjectSpace.XVector.X ) * Size.X + math.abs( ToObjectSpace.YVector.X ) * Size.Y + math.abs( ToObjectSpace.ZVector.X ) * Size.Z
            local Abs2 = math.abs( ToObjectSpace.XVector.Y ) * Size.X + math.abs( ToObjectSpace.YVector.Y ) * Size.Y + math.abs( ToObjectSpace.ZVector.Y ) * Size.Z
            local Vector32 = Vector3.new( Abs, Abs2, math.abs( ToObjectSpace.XVector.Z ) * Size.X + math.abs( ToObjectSpace.YVector.Z ) * Size.Y + math.abs( ToObjectSpace.ZVector.Z ) * Size.Z ) / 2
            table.insert( Table, {
                lo = ToObjectSpace.Position - Vector32,
                hi = ToObjectSpace.Position + Vector32,
                wedge = Value:IsA( "WedgePart" )
            } )
            Result = Result:Min( ToObjectSpace.Position - Vector32 )
            Result2 = Result2:Max( ToObjectSpace.Position + Vector32 )
        end
    end
    if #Table == 0 then
        local Table2 = { lo = -Argument2.Size / 2, hi = Argument2.Size / 2 }
        return {
            list = { Table2 },
            off = CFrame.identity,
            dim = Argument2.Size,
            roof = Table2
        }
    end

    local Value1, Table4
    Value1 = nil
    Table4 = nil

    for Key3, Value2 in Table, nil, nil do
        if not Value2.wedge then
            local Y3 = Value2.hi.Y

            if Result2.Y - 0.6 <= Y3 then
                local Table7

                if Table4 then
                    local Table6 = { }
                    Table6.lo = Table4.lo:Min( Value2.lo )
                    Table6.hi = Table4.hi:Max( Value2.hi )

                    if Table6 then
                        Table7 = Table6
                    else
                        Table7 = { lo = Value2.lo, hi = Value2.hi }
                    end
                else
                    Table7 = { lo = Value2.lo, hi = Value2.hi }
                end

                Table4 = Table7
            end
        end
    end

    local Flag
    local Result3 = Result2 - Result
    local X = Result.X

    if X == X then
        if X > -10000000 then
            if X < 10000000 then
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
    if Flag then
        local Y = Result.Y

        if Y == Y then
            if Y > -10000000 then
                if Y < 10000000 then
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
        if Flag then
            local Z = Result.Z

            if Z == Z then
                if Z > -10000000 then
                    if Z < 10000000 then
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
        end
    end
    if Flag then
        local Flag2
        local X2 = Result2.X

        if X2 == X2 then
            if X2 > -10000000 then
                if X2 < 10000000 then
                    Flag2 = true
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end
        if Flag2 then
            local Y2 = Result2.Y

            if Y2 == Y2 then
                if Y2 > -10000000 then
                    if Y2 < 10000000 then
                        Flag2 = true
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end
            if Flag2 then
                local Z2 = Result2.Z

                if Z2 == Z2 then
                    if Z2 > -10000000 then
                        if Z2 < 10000000 then
                            Flag2 = true
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            end
        end
        if Flag2 and not ( Result3.X < 0 ) and not ( Result3.Y < 0 ) and not ( Result3.Z < 0 ) then
            local Table3 = {
                box = Argument2,
                size = Argument2.Size,
                list = Table,
                off = CFrame.new( ( Result + Result2 ) / 2 ),
                dim = Result3,
                roof = Table4
            }
            Class3[ Key ] = Table3
            return Table3
        end
    end

    local Text = "coque invalide (" .. tostring( Result3 ) .. ")"

    if not Class2[ Key ] then
        Class2[ Key ] = true
        warn( "[BodySparks] " .. Key:GetFullName( ) .. " : " .. Text .. " -> étincelles de carrosserie coupées pour elle tant que c'est invalide" )
    end

    local Table5 = { lo = -Argument2.Size / 2, hi = Argument2.Size / 2 }
    return {
        list = { Table5 },
        off = CFrame.identity,
        dim = Argument2.Size,
        roof = Table5
    }
end

local Table4 = { "X", "Y", "Z" }

local function HullPoint( Key5, Argument2, Argument3, Argument4 )
    local Text
    local CFrame = Argument2.CFrame
    local PointToObjectSpace = CFrame:PointToObjectSpace( Argument3 )
    local VectorToObjectSpace = CFrame:VectorToObjectSpace( Argument4 )
    local Abs = math.abs( VectorToObjectSpace.X )

    if math.abs( VectorToObjectSpace.Y ) <= Abs then
        local Abs2 = math.abs( VectorToObjectSpace.X )

        if math.abs( VectorToObjectSpace.Z ) <= Abs2 then
            Text = "X"
        else
            local Abs3 = math.abs( VectorToObjectSpace.Y )

            if math.abs( VectorToObjectSpace.Z ) <= Abs3 then
                Text = "Y"
            else
                Text = "Z"
            end
        end
    else
        local Abs3 = math.abs( VectorToObjectSpace.Y )

        if math.abs( VectorToObjectSpace.Z ) <= Abs3 then
            Text = "Y"
        else
            Text = "Z"
        end
    end

    local Number4 = not ( VectorToObjectSpace[ Text ] >= 0 ) and -1 or 1
    local Value1, Number2
    local List = HullOf( Key5, Argument2 ).list
    Value1 = nil
    Number2 = -math.huge

    for Key, Value in List, nil, nil do
        local Entry9

        if Number4 > 0 then
            local Entry8 = Value.hi[ Text ]

            if Entry8 then
                Entry9 = Entry8
            else
                Entry9 = -Value.lo[ Text ]
            end
        else
            Entry9 = -Value.lo[ Text ]
        end

        Number2 = math.max( Number2, Entry9 )
    end

    local Value2, Value6, Number3, Total
    Value2 = nil
    Value6 = nil
    Number3 = nil
    Total = nil

    for Key2, Value3 in List, nil, nil do
        local Entry6

        if Number4 > 0 then
            local Entry5 = Value3.hi[ Text ]

            if Entry5 then
                Entry6 = Entry5
            else
                Entry6 = -Value3.lo[ Text ]
            end
        else
            Entry6 = -Value3.lo[ Text ]
        end
        if Number2 - 0.2 <= Entry6 then
            local Value7, Number
            Value7 = nil
            Number = 0

            for Key4, Value8 in Table4, nil, nil do
                if Value8 ~= Text and Value8 ~= "Y" then
                    local Entry7 = Value3.lo[ Value8 ] - PointToObjectSpace[ Value8 ]
                    Number = Number + math.max( Entry7, 0, PointToObjectSpace[ Value8 ] - Value3.hi[ Value8 ] )
                end
            end

            local Y2 = Value3.lo.Y + Value3.hi.Y

            if Value6 and not ( Number < Number3 - 0.05 ) then
                if not ( Number < Number3 + 0.05 ) or not ( Y2 < Total ) then
                    continue
                end
            end

            Value6 = Value3
            Number3 = Number
            Total = Y2
        end
    end

    local Value4
    local Table = { }
    Value4 = nil

    for Key3, Value5 in Table4, nil, nil do
        if Value5 == Text then
            local Entry2

            if Number4 > 0 then
                local Entry = Value6.hi[ Value5 ]

                if Entry then
                    Entry2 = Entry
                else
                    Entry2 = Value6.lo[ Value5 ]
                end
            else
                Entry2 = Value6.lo[ Value5 ]
            end

            Table[ Value5 ] = Entry2
        elseif Value5 == "Y" then
            Table[ Value5 ] = ( Value6.lo.Y + Value6.hi.Y ) / 2
        else
            local Min = math.min( 0.5, ( Value6.hi[ Value5 ] - Value6.lo[ Value5 ] ) / 4 )
            local Entry3 = PointToObjectSpace[ Value5 ]
            local Entry4 = Value6.lo[ Value5 ] + Min
            Table[ Value5 ] = math.clamp( Entry3, Entry4, Value6.hi[ Value5 ] - Min )
        end
    end

    local X = Table.X
    local Y = Table.Y
    return CFrame:PointToWorldSpace( ( Vector3.new( X, Y, Table.Z ) ) ), Value6
end

local function FacePoints( Argument1, Argument2, Argument3, VectorToObjectSpace )
    local CFrame = Argument1.CFrame
    local Position = Argument2.off.Position
    local Dim = Argument2.dim / 2
    local Position2 = Position - Dim
    local Position3 = Position + Dim
    local Table = { }
    local Abs = math.abs( VectorToObjectSpace.Y )

    if math.abs( VectorToObjectSpace.X ) <= Abs then
        local Abs2 = math.abs( VectorToObjectSpace.Y )

        if math.abs( VectorToObjectSpace.Z ) <= Abs2 then
            local Roof = VectorToObjectSpace.Y > 0 and Argument2.roof or { lo = Position2, hi = Position3 }
            local Y2

            if VectorToObjectSpace.Y > 0 then
                local Y = Roof.hi.Y - 0.45

                if Y then
                    Y2 = Y
                else
                    Y2 = Position2.Y + 0.45
                end
            else
                Y2 = Position2.Y + 0.45
            end

            local Value1
            local Table2 = { 0.1, 0.5, 0.9 }
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                local Value2
                local Table3 = { 0.05, 0.5, 0.95 }
                Value2 = nil

                for Key2, Value3 in Table3, nil, nil do
                    local X = Roof.lo.X + ( Roof.hi.X - Roof.lo.X ) * Value
                    table.insert( Table, CFrame:PointToWorldSpace( ( Vector3.new( X, Y2, Roof.lo.Z + ( Roof.hi.Z - Roof.lo.Z ) * Value3 ) ) ) )
                end
            end

            return Table, false
        end
    end

    local Text
    local PointToObjectSpace = CFrame:PointToObjectSpace( Argument3 )
    local Abs3 = math.abs( VectorToObjectSpace.X )
    Text = not ( math.abs( VectorToObjectSpace.Z ) <= Abs3 ) and "X" or "Z"
    local I = 0

    for I = 0, 4 do
        local Entry2
        local Entry = Position2[ Text ] + 0.3 + ( Position3[ Text ] - Position2[ Text ] - 0.6 ) * I / 4
        Entry2 = Text == "X" and Entry or PointToObjectSpace.X
        local Entry3
        local Y3 = PointToObjectSpace.Y
        Entry3 = Text == "Z" and Entry or PointToObjectSpace.Z
        table.insert( Table, CFrame:PointToWorldSpace( ( Vector3.new( Entry2, Y3, Entry3 ) ) ) )
    end

    return Table, true
end

local function Contacts( Key11, VehicleHitbox, List, Amount )
    if not Flag then
        if PhysicsService:IsCollisionGroupRegistered( "VehicleHitbox" ) then
            OverlapParams2.CollisionGroup = "VehicleHitbox"
            RaycastParams2.CollisionGroup = "VehicleHitbox"
            Flag = true
        end
    end

    local FlagInner
    local TableInner = { }
    local HullOf2 = HullOf( Key11, VehicleHitbox )
    local CFrame = VehicleHitbox.CFrame * HullOf2.off
    local Dim = HullOf2.dim
    local Position = CFrame.Position
    local X = Position.X

    if X == X then
        if X > -10000000 then
            if X < 10000000 then
                FlagInner = true
            else
                FlagInner = false
            end
        else
            FlagInner = false
        end
    else
        FlagInner = false
    end
    if FlagInner then
        local Y = Position.Y

        if Y == Y then
            if Y > -10000000 then
                if Y < 10000000 then
                    FlagInner = true
                else
                    FlagInner = false
                end
            else
                FlagInner = false
            end
        else
            FlagInner = false
        end
        if FlagInner then
            local Z = Position.Z

            if Z == Z then
                if Z > -10000000 then
                    if Z < 10000000 then
                        FlagInner = true
                    else
                        FlagInner = false
                    end
                else
                    FlagInner = false
                end
            else
                FlagInner = false
            end
        end
    end
    if FlagInner then
        local LookVector = CFrame.LookVector
        local X2 = LookVector.X

        if X2 == X2 then
            if X2 > -10000000 then
                if X2 < 10000000 then
                    FlagInner = true
                else
                    FlagInner = false
                end
            else
                FlagInner = false
            end
        else
            FlagInner = false
        end
        if FlagInner then
            local Y2 = LookVector.Y

            if Y2 == Y2 then
                if Y2 > -10000000 then
                    if Y2 < 10000000 then
                        FlagInner = true
                    else
                        FlagInner = false
                    end
                else
                    FlagInner = false
                end
            else
                FlagInner = false
            end
            if FlagInner then
                local Z2 = LookVector.Z

                if Z2 == Z2 then
                    if Z2 > -10000000 then
                        if Z2 < 10000000 then
                            FlagInner = true
                        else
                            FlagInner = false
                        end
                    else
                        FlagInner = false
                    end
                else
                    FlagInner = false
                end
            end
        end
        if FlagInner then
            local UpVector = CFrame.UpVector
            local X3 = UpVector.X

            if X3 == X3 then
                if X3 > -10000000 then
                    if X3 < 10000000 then
                        FlagInner = true
                    else
                        FlagInner = false
                    end
                else
                    FlagInner = false
                end
            else
                FlagInner = false
            end
            if FlagInner then
                local Y3 = UpVector.Y

                if Y3 == Y3 then
                    if Y3 > -10000000 then
                        if Y3 < 10000000 then
                            FlagInner = true
                        else
                            FlagInner = false
                        end
                    else
                        FlagInner = false
                    end
                else
                    FlagInner = false
                end
                if FlagInner then
                    local Z3 = UpVector.Z

                    if Z3 == Z3 then
                        if Z3 > -10000000 then
                            if Z3 < 10000000 then
                                FlagInner = true
                            else
                                FlagInner = false
                            end
                        else
                            FlagInner = false
                        end
                    else
                        FlagInner = false
                    end
                end
            end
        end
    end
    if FlagInner then
        local Flag2
        local X4 = Dim.X

        if X4 == X4 then
            if X4 > -10000000 then
                if X4 < 10000000 then
                    Flag2 = true
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end
        if Flag2 then
            local Y4 = Dim.Y

            if Y4 == Y4 then
                if Y4 > -10000000 then
                    if Y4 < 10000000 then
                        Flag2 = true
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end
            if Flag2 then
                local Z4 = Dim.Z

                if Z4 == Z4 then
                    if Z4 > -10000000 then
                        if Z4 < 10000000 then
                            Flag2 = true
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            end
        end
        if Flag2 then
            if Dim.X > 0 then
                if Dim.Y > 0 then
                    if Dim.Z > 0 then
                        if Dim.Magnitude < 500 then
                            Flag2 = true
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end
        end
        if Flag2 then
            local UpVector2 = VehicleHitbox.CFrame.UpVector
            OverlapParams2.FilterDescendantsInstances = { Key11, workspace.Terrain }
            local FilterDescendantsInstances = { }

            for Key2, Value in workspace:GetPartBoundsInBox( CFrame, Dim + Vector3.new( 1, 1, 1 ) * ( 2 * Amount + 0.1 ), OverlapParams2 ) do
                local Parent2
                local Parent = Value.Parent
                Parent2 = Parent and CollectionService:HasTag( Parent, "Vehicle" ) and Parent or nil

                if not Parent2 then
                    local Flag6
                    local Entry3 = Class[ Value ]

                    if Entry3 == nil then
                        if Table[ MetalImpactAudio.SurfaceOf( Value ) or "" ] == true then
                            Flag6 = true
                        else
                            Flag6 = false
                        end

                        Class[ Value ] = Flag6
                    else
                        Flag6 = Entry3
                    end
                    if Flag6 then
                        table.insert( FilterDescendantsInstances, Value )
                    end
                end
            end
            if #FilterDescendantsInstances > 0 then
                local Value2
                RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
                local Max = math.max( Dim.X - 0.9, 0.2 )
                local Max2 = math.max( Dim.Y - 0.9, 0.2 )
                local Vector32 = Vector3.new( Max, Max2, ( math.max( Dim.Z - 0.9, 0.2 ) ) )
                Value2 = nil

                for Key3, Value3 in List, nil, nil do
                    local Flag3
                    local VectorToObjectSpace = VehicleHitbox.CFrame:VectorToObjectSpace( Value3 )

                    if VectorToObjectSpace.Y > 0.7 then
                        if UpVector2.Y < 0 then
                            Flag3 = true
                        else
                            Flag3 = false
                        end
                    else
                        Flag3 = false
                    end

                    local Blockcast2

                    if Flag3 then
                        Blockcast2 = nil
                    else
                        local Blockcast = workspace:Blockcast( CFrame, Vector32, Value3 * ( 0.45 + Amount ), RaycastParams2 )

                        if Blockcast then
                            Blockcast2 = Blockcast
                        else
                            Blockcast2 = nil
                        end
                    end
                    if Blockcast2 or Flag3 then
                        local Position2 = Blockcast2 and Blockcast2.Position or CFrame.Position
                        local Value6, Number, Position3, Position5, Raycast
                        local Value4, Value5 = FacePoints( VehicleHitbox, HullOf2, Position2, VectorToObjectSpace )
                        local Table2 = { }
                        Value6 = nil
                        Number = 0
                        Position3 = Vector3.new( 0, 0, 0 )
                        Position5 = Vector3.new( 0, 0, 0 )
                        Raycast = nil

                        for Key4, Value7 in Value4, nil, nil do
                            local Value9, Result

                            if Value5 then
                                Value8, Value9 = HullPoint( Key11, VehicleHitbox, Value7, Value3 )
                                Result = Value8 - Value3 * 0.45
                            else
                                Result = Value7
                                Value9 = nil
                            end

                            local Raycast2 = workspace:Raycast( Result, Value3 * ( 0.45 + Amount + 0.3 ), RaycastParams2 )

                            if Raycast2 then
                                Number = Number + 1
                                Raycast = Raycast or Raycast2
                                Position3 = Position3 + Raycast2.Position
                                Position5 = Position5 + Raycast2.Normal

                                if Value9 then
                                    local Clamp = math.clamp( ( Value9.hi.Y - Value9.lo.Y ) / 2, 0.15, 0.6 )
                                    table.insert( Table2, Raycast2.Position + UpVector2 * Clamp )
                                    table.insert( Table2, Raycast2.Position - UpVector2 * Clamp )
                                else
                                    table.insert( Table2, Raycast2.Position )
                                end
                            end
                        end

                        local Zone

                        if Number ~= 0 or not Blockcast2 then
                            Zone = Table2
                        else
                            Number = 1
                            Position3 = Blockcast2.Position
                            Position5 = Blockcast2.Normal
                            Raycast = Blockcast2
                            Zone = { Blockcast2.Position }
                        end
                        if Number > 0 then
                            local Normal
                            local Position4 = Position3 / Number
                            local Table3 = { pos = Position4 }
                            Normal = Position5.Magnitude > 0.01 and Position5.Unit or Raycast.Normal
                            Table3.normal = Normal
                            Table3.zone = Zone
                            Table3.vel = Raycast.Instance:GetVelocityAtPosition( Position4 )
                            table.insert( TableInner, Table3 )
                        end
                    end
                end
            end
            for Key5, Value10 in CollectionService:GetTagged( "Vehicle" ) do
                if Value10 ~= Key11 and not Value10:GetAttribute( "Destroyed" ) and Value10:FindFirstChild( "VehicleHitbox" ) then
                    local Flag4
                    local HullOf3 = HullOf( Value10, Value10:FindFirstChild( "VehicleHitbox" ) )
                    local CFrame2 = Value10:FindFirstChild( "VehicleHitbox" ).CFrame * HullOf3.off
                    local Dim2 = HullOf3.dim
                    local Position6 = CFrame2.Position
                    local X5 = Position6.X

                    if X5 == X5 then
                        if X5 > -10000000 then
                            if X5 < 10000000 then
                                Flag4 = true
                            else
                                Flag4 = false
                            end
                        else
                            Flag4 = false
                        end
                    else
                        Flag4 = false
                    end
                    if Flag4 then
                        local Y5 = Position6.Y

                        if Y5 == Y5 then
                            if Y5 > -10000000 then
                                if Y5 < 10000000 then
                                    Flag4 = true
                                else
                                    Flag4 = false
                                end
                            else
                                Flag4 = false
                            end
                        else
                            Flag4 = false
                        end
                        if Flag4 then
                            local Z5 = Position6.Z

                            if Z5 == Z5 then
                                if Z5 > -10000000 then
                                    if Z5 < 10000000 then
                                        Flag4 = true
                                    else
                                        Flag4 = false
                                    end
                                else
                                    Flag4 = false
                                end
                            else
                                Flag4 = false
                            end
                        end
                    end
                    if Flag4 then
                        local LookVector2 = CFrame2.LookVector
                        local X6 = LookVector2.X

                        if X6 == X6 then
                            if X6 > -10000000 then
                                if X6 < 10000000 then
                                    Flag4 = true
                                else
                                    Flag4 = false
                                end
                            else
                                Flag4 = false
                            end
                        else
                            Flag4 = false
                        end
                        if Flag4 then
                            local Y6 = LookVector2.Y

                            if Y6 == Y6 then
                                if Y6 > -10000000 then
                                    if Y6 < 10000000 then
                                        Flag4 = true
                                    else
                                        Flag4 = false
                                    end
                                else
                                    Flag4 = false
                                end
                            else
                                Flag4 = false
                            end
                            if Flag4 then
                                local Z6 = LookVector2.Z

                                if Z6 == Z6 then
                                    if Z6 > -10000000 then
                                        if Z6 < 10000000 then
                                            Flag4 = true
                                        else
                                            Flag4 = false
                                        end
                                    else
                                        Flag4 = false
                                    end
                                else
                                    Flag4 = false
                                end
                            end
                        end
                        if Flag4 then
                            local UpVector3 = CFrame2.UpVector
                            local X7 = UpVector3.X

                            if X7 == X7 then
                                if X7 > -10000000 then
                                    if X7 < 10000000 then
                                        Flag4 = true
                                    else
                                        Flag4 = false
                                    end
                                else
                                    Flag4 = false
                                end
                            else
                                Flag4 = false
                            end
                            if Flag4 then
                                local Y7 = UpVector3.Y

                                if Y7 == Y7 then
                                    if Y7 > -10000000 then
                                        if Y7 < 10000000 then
                                            Flag4 = true
                                        else
                                            Flag4 = false
                                        end
                                    else
                                        Flag4 = false
                                    end
                                else
                                    Flag4 = false
                                end
                                if Flag4 then
                                    local Z7 = UpVector3.Z

                                    if Z7 == Z7 then
                                        if Z7 > -10000000 then
                                            if Z7 < 10000000 then
                                                Flag4 = true
                                            else
                                                Flag4 = false
                                            end
                                        else
                                            Flag4 = false
                                        end
                                    else
                                        Flag4 = false
                                    end
                                end
                            end
                        end
                    end
                    if Flag4 then
                        local Flag5
                        local X8 = Dim2.X

                        if X8 == X8 then
                            if X8 > -10000000 then
                                if X8 < 10000000 then
                                    Flag5 = true
                                else
                                    Flag5 = false
                                end
                            else
                                Flag5 = false
                            end
                        else
                            Flag5 = false
                        end
                        if Flag5 then
                            local Y8 = Dim2.Y

                            if Y8 == Y8 then
                                if Y8 > -10000000 then
                                    if Y8 < 10000000 then
                                        Flag5 = true
                                    else
                                        Flag5 = false
                                    end
                                else
                                    Flag5 = false
                                end
                            else
                                Flag5 = false
                            end
                            if Flag5 then
                                local Z8 = Dim2.Z

                                if Z8 == Z8 then
                                    if Z8 > -10000000 then
                                        if Z8 < 10000000 then
                                            Flag5 = true
                                        else
                                            Flag5 = false
                                        end
                                    else
                                        Flag5 = false
                                    end
                                else
                                    Flag5 = false
                                end
                            end
                        end
                        if Flag5 then
                            if Dim2.X > 0 then
                                if Dim2.Y > 0 then
                                    if Dim2.Z > 0 then
                                        if Dim2.Magnitude < 500 then
                                            Flag5 = true
                                        else
                                            Flag5 = false
                                        end
                                    else
                                        Flag5 = false
                                    end
                                else
                                    Flag5 = false
                                end
                            else
                                Flag5 = false
                            end
                        end
                        if Flag5 then
                            local Magnitude = ( CFrame2.Position - CFrame.Position ).Magnitude

                            if not ( ( Dim.Magnitude + Dim2.Magnitude ) / 2 + Amount < Magnitude ) then
                                local ClampInto2 = ClampInto( CFrame2, Dim2, CFrame.Position )
                                local ClampInto3 = ClampInto( CFrame, Dim, ClampInto2 )

                                if not ( Amount < ( ClampInto2 - ClampInto3 ).Magnitude ) then
                                    local Vector35
                                    local PointToObjectSpace = CFrame2:PointToObjectSpace( ClampInto2 )
                                    local Dim3 = Dim2 / 2
                                    local Abs = math.abs( PointToObjectSpace.X ) / Dim3.X
                                    local Abs2 = math.abs( PointToObjectSpace.Y ) / Dim3.Y
                                    local Abs3 = math.abs( PointToObjectSpace.Z ) / Dim3.Z

                                    if not ( Abs2 <= Abs ) or not ( Abs3 <= Abs ) then
                                        if Abs3 <= Abs2 then
                                            local Vector34 = Vector3.new( 0, math.sign( PointToObjectSpace.Y ), 0 )

                                            if Vector34 then
                                                Vector35 = Vector34
                                            else
                                                Vector35 = Vector3.new( 0, 0, ( math.sign( PointToObjectSpace.Z ) ) )
                                            end
                                        else
                                            Vector35 = Vector3.new( 0, 0, ( math.sign( PointToObjectSpace.Z ) ) )
                                        end
                                    else
                                        local Vector33 = Vector3.new( math.sign( PointToObjectSpace.X ), 0, 0 )

                                        if Vector33 then
                                            Vector35 = Vector33
                                        elseif Abs3 <= Abs2 then
                                            local Vector34 = Vector3.new( 0, math.sign( PointToObjectSpace.Y ), 0 )

                                            if Vector34 then
                                                Vector35 = Vector34
                                            else
                                                Vector35 = Vector3.new( 0, 0, ( math.sign( PointToObjectSpace.Z ) ) )
                                            end
                                        else
                                            Vector35 = Vector3.new( 0, 0, ( math.sign( PointToObjectSpace.Z ) ) )
                                        end
                                    end

                                    local VectorToWorldSpace2
                                    local VectorToWorldSpace = CFrame2:VectorToWorldSpace( Vector35 )
                                    VectorToWorldSpace2 = if VectorToWorldSpace.Magnitude < 0.5 then ( CFrame.Position - CFrame2.Position ).Unit else VectorToWorldSpace
                                    local Value14, Value15 = HullPoint( Key11, VehicleHitbox, ( ClampInto2 + ClampInto3 ) / 2, -VectorToWorldSpace2 )
                                    local Table4 = { Value14 }
                                    local VectorToObjectSpace2 = VehicleHitbox.CFrame:VectorToObjectSpace( -VectorToWorldSpace2 )

                                    if math.abs( VectorToObjectSpace2.Y ) < 0.7 then
                                        local Text
                                        local Abs4 = math.abs( VectorToObjectSpace2.X )
                                        Text = not ( math.abs( VectorToObjectSpace2.Z ) <= Abs4 ) and "X" or "Z"
                                        local Value16, Number2, Number3
                                        local Table5 = { -1, 1 }
                                        Value16 = nil
                                        Number2 = math.huge
                                        Number3 = -math.huge

                                        for Key6, Value17 in Table5, nil, nil do
                                            local Value22
                                            local Table9 = { -1, 1 }
                                            Value22 = nil

                                            for Key9, Value23 in Table9, nil, nil do
                                                local Value24
                                                local Table10 = { -1, 1 }
                                                Value24 = nil

                                                for Key10, Value25 in Table10, nil, nil do
                                                    local CFrame4 = VehicleHitbox.CFrame
                                                    local X10 = Value17 * Dim3.X
                                                    local Y10 = Value23 * Dim3.Y
                                                    local PointToObjectSpace3 = CFrame4:PointToObjectSpace( CFrame2:PointToWorldSpace( ( Vector3.new( X10, Y10, Value25 * Dim3.Z ) ) ) )
                                                    Number2 = math.min( Number2, PointToObjectSpace3[ Text ] )
                                                    Number3 = math.max( Number3, PointToObjectSpace3[ Text ] )
                                                end
                                            end
                                        end

                                        local Entry = HullOf2.off.Position[ Text ]
                                        local Entry2 = HullOf2.dim[ Text ] / 2
                                        local Max3 = math.max( Number2, Entry - Entry2 + 0.3 )
                                        local Min = math.min( Number3, Entry + Entry2 - 0.3 )

                                        if Max3 < Min then
                                            local Clamp3
                                            local PointToObjectSpace2 = VehicleHitbox.CFrame:PointToObjectSpace( Value14 )

                                            if Value15 then
                                                local Clamp2 = math.clamp( ( Value15.hi.Y - Value15.lo.Y ) / 2, 0.15, 0.6 )

                                                if Clamp2 then
                                                    Clamp3 = Clamp2
                                                else
                                                    Clamp3 = 0.3
                                                end
                                            else
                                                Clamp3 = 0.3
                                            end

                                            local Value18
                                            local Table6 = { }
                                            local Table7 = { Max3, Min }
                                            Value18 = nil

                                            for Key7, Value19 in Table7, nil, nil do
                                                local Value20
                                                local Table8 = { -Clamp3, Clamp3 }
                                                Value20 = nil

                                                for Key8, Value21 in Table8, nil, nil do
                                                    local X9
                                                    local CFrame3 = VehicleHitbox.CFrame
                                                    X9 = Text == "X" and Value19 or PointToObjectSpace2.X
                                                    local Z9
                                                    local Y9 = PointToObjectSpace2.Y + Value21
                                                    Z9 = Text == "Z" and Value19 or PointToObjectSpace2.Z
                                                    table.insert( Table6, CFrame3:PointToWorldSpace( ( Vector3.new( X9, Y9, Z9 ) ) ) )
                                                end

                                                Table4 = Table6
                                            end

                                            Table4 = Table6
                                        end
                                    end

                                    local VehicleRoot = Value10:FindFirstChild( "VehicleRoot" ) or Value10:FindFirstChild( "VehicleHitbox" )
                                    table.insert( TableInner, {
                                        pos = Value14,
                                        normal = VectorToWorldSpace2,
                                        zone = Table4,
                                        vel = VehicleRoot:GetVelocityAtPosition( Value14 ),
                                        carSpeed = VehicleRoot.AssemblyLinearVelocity.Magnitude
                                    } )
                                end
                            end
                        end
                    end
                end
            end

            return TableInner
        end
    end

    local Text2 = tostring( CFrame.Position )
    local Text3 = "position ou taille invalide (" .. Text2 .. ", " .. tostring( Dim ) .. ")"

    if not Class2[ Key11 ] then
        Class2[ Key11 ] = true
        warn( "[BodySparks] " .. Key11:GetFullName( ) .. " : " .. Text3 .. " -> étincelles de carrosserie coupées pour elle tant que c'est invalide" )
    end

    Class3[ Key11 ] = nil
    return TableInner
end

local function ZoneFrame( List, Argument2, Amount )
    local Y2
    local Y = Vector3.new( 0, 1, 0 ) - Argument2 * Argument2.Y

    if Y.Magnitude < 0.2 then
        Y2 = Amount - Argument2 * Amount:Dot( Argument2 )
    else
        Y2 = Y
    end
    if Y2.Magnitude < 0.05 then
        local Position = not ( math.abs( Argument2.X ) < 0.9 ) and Vector3.new( 0, 0, 1 ) or Vector3.new( 1, 0, 0 )
        Y2 = Argument2:Cross( Position )
    end

    local Value1, Position2, Position3
    local Unit = Y2.Unit
    local Cross = Argument2:Cross( Unit )
    local Item = List[ 1 ]
    Value1 = nil
    Position2 = Vector3.new( 0, 0, 0 )
    Position3 = Vector3.new( 0, 0, 0 )

    for Key, Value in List, nil, nil do
        local Item2 = Value - Item
        local Dot = Item2:Dot( Cross )
        local Dot2 = Item2:Dot( Argument2 )
        local Vector32 = Vector3.new( Dot, Dot2, Item2:Dot( Unit ) )
        Position2 = Position2:Min( Vector32 )
        Position3 = Position3:Max( Vector32 )
    end

    local Position4 = ( Position2 + Position3 ) / 2
    return CFrame.fromMatrix( Item + Cross * Position4.X + Argument2 * Position4.Y + Unit * Position4.Z + Amount * 0.15, Cross, Argument2, Unit ), ( Position3 - Position2 ):Max( Vector3.new( 0.30000001192092896, 0.30000001192092896, 0.30000001192092896 ) )
end

local function ScrapeDir( List, Argument2, Argument3 )
    local Value1, Number, Number2
    local Amount = -Argument2.Unit
    Value1 = nil
    Number = -math.huge
    Number2 = math.huge

    for Key, Value in List, nil, nil do
        local Dot = Value:Dot( Amount )
        Number2 = math.min( Number2, Dot )
        Number = math.max( Number, Dot )
    end

    local Total = Vector3.new( 0, 1, 0 ) + Argument3 - Amount * ( Vector3.new( 0, 1, 0 ) + Argument3 ):Dot( Amount )

    if Total.Magnitude < 0.05 then
        return Amount
    end
    local Min = math.min( 0.6457718232379019, ( math.asin( ( math.min( 1, 1 / math.max( Number - Number2, 0.01 ) ) ) ) ) )
    return ( Amount * math.cos( Min ) + Total.Unit * math.sin( Min ) ).Unit
end

local function Template()
    local ClientFX2
    local ClientFX = Parent:FindFirstChild( "ClientFX" )
    ClientFX2 = if ClientFX then ClientFX:FindFirstChild( "RimSparks" ) else ClientFX
    return ClientFX2
end

local function NewSource( Name )
    local RimSparks
    local ClientFX = Parent:FindFirstChild( "ClientFX" )

    if ClientFX then
        RimSparks = ClientFX:FindFirstChild( "RimSparks" )
    else
        RimSparks = ClientFX
    end
    if not RimSparks then
        return nil
    end

    local ParentInner = Instance.new( "Part" )
    ParentInner.Name = Name
    ParentInner.Anchored = true
    ParentInner.CanCollide = false
    ParentInner.CanQuery = false
    ParentInner.CanTouch = false
    ParentInner.CastShadow = false
    ParentInner.Transparency = 1
    local Table = { }

    for Key, Value in RimSparks:GetChildren( ) do
        if Value:IsA( "ParticleEmitter" ) then
            local Clone = Value:Clone( )
            Clone.Enabled = false
            Clone.Parent = ParentInner
            table.insert( Table, { e = Clone, rate = Value.Rate, life = Value.Lifetime.Max } )
        end
    end

    local Parent2
    local FX = workspace:FindFirstChild( "FX" )
    Parent2 = if FX then FX else workspace
    ParentInner.Parent = Parent2
    return { part = ParentInner, list = Table, on = false, rel = CFrame.identity }
end

local function LengthRate( Argument1 )
    local X = Argument1.X
    local Y = Argument1.Y
    return ( math.clamp( math.max( X, Y, Argument1.Z ) / 2, 1, 3 ) )
end

local Class4 = setmetatable( { }, { __mode = "k" } )
local Table5 = { }
local Table3 = {
    Active = function( Key )
        local Flag
        local Entry = Class4[ Key ]

        if Entry == nil then
            Flag = false
        elseif Entry.on == true then
            Flag = true
        else
            Flag = false
        end

        return Flag
    end,
    Update = function( Key11, Part, Argument3 )
        local Entry2
        local Entry = Class4[ Key11 ]

        if Entry then
            Entry2 = Entry
        else
            local Table = { t = math.random( ) * 0.05, on = false, sources = { } }
            Class4[ Key11 ] = Table
            Key11.AncestryChanged:Connect( function( Argument1, Argument2 )
                if Argument2 then
                    return
                end

                local Value1
                local Sources = Table.sources
                Value1 = nil

                for Key, Value in Sources, nil, nil do
                    Value.part:Destroy( )
                end

                table.clear( Table.sources )
                Table.on = false
            end )
            Entry2 = Table
        end
        if Entry2.on then
            local Value1
            local CFrame = Part.CFrame
            local Sources = Entry2.sources
            Value1 = nil

            for Key2, Value in Sources, nil, nil do
                if Value.on then
                    local Part2 = Value.part
                    Part2.CFrame = CFrame * Value.rel
                end
            end
        end

        Entry2.t = Entry2.t + Argument3

        if Entry2.t < 0.05 then
            return
        end

        Entry2.t = 0
        local Table2Inner = { }
        local VehicleHitbox = Key11:FindFirstChild( "VehicleHitbox" )
        local CurrentCamera = workspace.CurrentCamera
        local AssemblyLinearVelocity = Part.AssemblyLinearVelocity

        if VehicleHitbox and CurrentCamera and Part.Parent == Key11 and not Part.Anchored and not Key11:GetAttribute( "Destroyed" ) and not Key11:GetAttribute( "Noyee" ) then
            if AssemblyLinearVelocity.Magnitude >= 6 or Entry2.on then
                if ( Part.Position - CurrentCamera.CFrame.Position ).Magnitude < 220 and not Eau.Profondeur( Part.Position ) then
                    local Value2
                    local Table3 = { }
                    Value2 = nil

                    for Key3, Value3 in Table2, nil, nil do
                        Table3[ Key3 ] = VehicleHitbox.CFrame:VectorToWorldSpace( Value3 )
                    end
                    for Key4, Value5 in Contacts( Key11, VehicleHitbox, Table3, 0.3 ) do
                        if not Value5.carSpeed or not ( AssemblyLinearVelocity.Magnitude < Value5.carSpeed ) then
                            local VelocityAtPosition = Part:GetVelocityAtPosition( Value5.pos ) - Value5.vel
                            local Slide = VelocityAtPosition - Value5.normal * VelocityAtPosition:Dot( Value5.normal )
                            local Speed = Slide.Magnitude

                            if Speed >= 6 then
                                Value5.slide = Slide
                                Value5.speed = Speed
                                table.insert( Table2Inner, Value5 )
                            end
                        end
                    end

                    table.sort( Table2Inner, function( Argument1, Argument2 )
                        local Flag
                        local Speed = Argument1.speed
                        Flag = Argument2.speed < Speed and true or false
                        return Flag
                    end )
                end
            end
        end

        local CFrame2 = Part.CFrame
        local I = 1

        for I = 1, 2 do
            local Entry3 = Table2Inner[ I ]
            local Entry4 = Entry2.sources[ I ]

            if Entry3 then
                local Entry5

                if not Entry4 or not Entry4.part.Parent then
                    local Source = NewSource( "BodySparks" )
                    Entry2.sources[ I ] = Source
                    Entry5 = Source
                else
                    Entry5 = Entry4
                end
                if Entry5 then
                    local Value7
                    local CFrame3, Size = ZoneFrame( Entry3.zone, ScrapeDir( Entry3.zone, Entry3.slide, Entry3.normal ), Entry3.normal )
                    Entry5.part.Size = Size
                    Entry5.part.CFrame = CFrame3
                    Entry5.rel = CFrame2:ToObjectSpace( CFrame3 )
                    local Clamp = math.clamp( ( Entry3.speed - 6 ) / 54, 0, 1 ) * 1.15 + 0.35
                    local X = Size.X
                    local Y = Size.Y
                    local Clamp2 = Clamp * math.clamp( math.max( X, Y, Size.Z ) / 2, 1, 3 )
                    local List = Entry5.list
                    Value7 = nil

                    for Key5, Value8 in List, nil, nil do
                        local E = Value8.e
                        E.Rate = Value8.rate * Clamp2
                    end
                    if not Entry5.on then
                        local Value9
                        Entry5.on = true
                        local List2 = Entry5.list
                        Value9 = nil

                        for Key6, Value10 in List2, nil, nil do
                            Value10.e.Enabled = true
                        end

                        local Flag = workspace:GetAttribute( "DebugBodySparks" ) == true and true or false

                        if Flag then
                            local Name = Key11.Name
                            local Speed2 = Entry3.speed
                            local X2 = Size.X
                            local Y2 = Size.Y
                            print( ( "[ETINCELLES] %s frotte à %.0f studs/s (gerbe %d : pièce %.1f x %.1f x %.1f, débit x%.2f)" ):format( Name, Speed2, I, X2, Y2, Size.Z, Clamp2 ) )
                        end
                    end
                end
            elseif Entry4 and Entry4.on then
                local Value11
                Entry4.on = false
                local List3 = Entry4.list
                Value11 = nil

                for Key7, Value12 in List3, nil, nil do
                    Value12.e.Enabled = false
                end
            end
        end

        local On = #Table2Inner > 0 and true or false
        Entry2.on = On
    end,
    Impact = function( Key11, Part, Argument3, Amount, Argument5 )
        if Amount < 18 or Argument3.Magnitude < 0.1 then
            return
        end

        local VehicleHitbox = Key11:FindFirstChild( "VehicleHitbox" )
        local CurrentCamera = workspace.CurrentCamera

        if VehicleHitbox and CurrentCamera and not ( ( Part.Position - CurrentCamera.CFrame.Position ).Magnitude > 220 ) then
            local ClientFX2
            local ClientFX = Parent:FindFirstChild( "ClientFX" )
            ClientFX2 = if ClientFX then ClientFX:FindFirstChild( "RimSparks" ) else ClientFX

            if ClientFX2 then
                local Contacts2 = Contacts( Key11, VehicleHitbox, { Argument3.Unit }, 1.5 )

                if #Contacts2 == 0 then
                    return
                end

                table.sort( Contacts2, function( Argument1, Argument2 )
                    local Flag = ( Argument1.pos - Part.Position ).Magnitude < ( Argument2.pos - Part.Position ).Magnitude and true or false
                    return Flag
                end )
                local Clock = os.clock( )
                local Count = #Table5
                local I = Count

                for I = Count, 1, -1 do
                    if Clock - Table5[ I ].t > 0.25 then
                        table.remove( Table5, I )
                    end
                end

                local Value2, Number, Text
                local Clamp = math.clamp( ( Amount - 18 ) / 102, 0, 1 )
                Value2 = nil
                Number = 0
                Text = ""

                for Key, Value in Contacts2, nil, nil do
                    if Number >= 2 then
                        break
                    end

                    local Value3, Flag
                    Value3 = nil

                    for Key2, Value4 in Table5, nil, nil do
                        if ( Value4.pos - Value.pos ).Magnitude < 4 then
                            Flag = true
                            break
                        end

                        Flag = false
                    end

                    local NotFlag2
                    local NotFlag = not Flag

                    if NotFlag then
                        NotFlag2 = NewSource( "BodySparksImpact" )
                    else
                        NotFlag2 = NotFlag
                    end
                    if NotFlag2 then
                        table.insert( Table5, { t = Clock, pos = Value.pos } )
                        Number = Number + 1
                        local Unit
                        local AssemblyLinearVelocity = ( Argument5 or Part.AssemblyLinearVelocity ) - Value.vel
                        local AssemblyLinearVelocity2 = AssemblyLinearVelocity - Value.normal * AssemblyLinearVelocity:Dot( Value.normal )

                        if AssemblyLinearVelocity2.Magnitude > 8 then
                            local Zone = Value.zone
                            local ScrapeDir2 = ScrapeDir( Zone, AssemblyLinearVelocity2, Value.normal )

                            if ScrapeDir2 then
                                Unit = ScrapeDir2
                            else
                                Unit = ( Value.normal * 0.8 + Vector3.new( 0, 0.44999998807907104, 0 ) ).Unit
                            end
                        else
                            Unit = ( Value.normal * 0.8 + Vector3.new( 0, 0.44999998807907104, 0 ) ).Unit
                        end

                        local Value6, Number2
                        local Zone2 = Value.zone
                        local CFrame, Size = ZoneFrame( Zone2, Unit, Value.normal )
                        NotFlag2.part.Size = Size
                        NotFlag2.part.CFrame = CFrame
                        local Clamp2 = Clamp * 0.9 + 0.3
                        local X = Size.X
                        local Y = Size.Y
                        local Clamp3 = Clamp2 * math.clamp( math.max( X, Y, Size.Z ) / 2, 1, 3 )
                        local List = NotFlag2.list
                        Value6 = nil
                        Number2 = 0

                        for Key3, Value7 in List, nil, nil do
                            Value7.e:Emit( ( math.max( 3, ( math.floor( Value7.rate * Clamp3 ) ) ) ) )
                            Number2 = math.max( Number2, Value7.life )
                        end

                        Debris:AddItem( NotFlag2.part, Number2 + 0.5 )
                        local X2 = Size.X
                        local Y2 = Size.Y
                        Text = Text .. ( " [pièce %.1f x %.1f x %.1f, débit x%.2f]" ):format( X2, Y2, Size.Z, Clamp3 )
                    end
                end
                if Number > 0 then
                    local Flag2 = workspace:GetAttribute( "DebugBodySparks" ) == true and true or false

                    if Flag2 then
                        print( ( "[ETINCELLES] choc de %s à %.0f studs/s : %d gerbe(s)%s" ):format( Key11.Name, Amount, Number, Text ) )
                    end
                end

                return
            end
        end
    end
}
return Table3
