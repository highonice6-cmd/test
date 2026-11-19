-- ReplicatedStorage.VehicleSystem.ExitSpot
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local OverlapParams2 = OverlapParams.new( )
OverlapParams2.FilterType = Enum.RaycastFilterType.Exclude
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
local Table = {
    Find = function( Object, Object2, Argument3, Humanoid, Argument5 )
        local VehicleRoot = Object:FindFirstChild( "VehicleRoot" )

        if not VehicleRoot then
            return nil
        end

        local Z4
        local CFrame2 = VehicleRoot.CFrame
        local ExitOffset = Object2:GetAttribute( "ExitOffset" ) or Vector3.new( 6, 0.5, 0 )
        OverlapParams2.FilterDescendantsInstances = { Argument3, Object }
        OverlapParams2.CollisionGroup = Argument5.CollisionGroup
        RaycastParams2.FilterDescendantsInstances = { Argument3, Object }
        RaycastParams2.CollisionGroup = Argument5.CollisionGroup
        local HipHeight = Humanoid.HipHeight + Argument5.Size.Y / 2
        local VehicleHitbox = Object:FindFirstChild( "VehicleHitbox" )

        if VehicleHitbox then
            local Z = VehicleHitbox.Size.Z / 2

            if Z then
                Z4 = Z
            else
                Z4 = 7
            end
        else
            Z4 = 7
        end

        local Value1, At2

        local function At( Argument1 )
            local Position
            local PointToWorldSpace = CFrame2:PointToWorldSpace( Argument1 )
            local Raycast = workspace:Raycast( PointToWorldSpace + Vector3.new( 0, 3, 0 ), Vector3.new( 0, -8, 0 ), RaycastParams2 )
            Position = Raycast and Raycast.Position or PointToWorldSpace
            local Position2 = Position + Vector3.new( 0, HipHeight, 0 )

            if workspace:Raycast( Object2.Position, Position2 - Object2.Position, RaycastParams2 ) then
                return nil
            end

            local Flag = #workspace:GetPartBoundsInBox( CFrame.new( Position + Vector3.new( 0, 2.299999952316284, 0 ) ), Vector3.new( 2, 4, 2 ), OverlapParams2 ) == 0 and true or false
            return Position2, Flag
        end

        local Table = { 1, -1 }
        Value1 = nil
        At2 = nil

        for Key, Value in Table, nil, nil do
            local Value2
            local Table2 = { 0, 1.5 }
            Value2 = nil

            for Key2, Value3 in Table2, nil, nil do
                local Value4
                local Table3 = { 0, 2, -2, 4, -4 }
                Value4 = nil

                for Key3, Value5 in Table3, nil, nil do
                    local X = ExitOffset.X * Value
                    local X2 = X + math.sign( X ) * Value3
                    local Y3 = ExitOffset.Y
                    local Z2 = ExitOffset.Z + Value5
                    local Z3 = 1 - Z4
                    local At3, At22 = At( ( Vector3.new( X2, Y3, ( math.clamp( Z2, Z3, Z4 - 1 ) ) ) ) )

                    if At3 and At22 then
                        return At3
                    end

                    At2 = At2 or At3
                end
            end
        end
        if At2 then
            return At2
        end

        local Y2
        local Position = CFrame2.Position
        local UpVector = CFrame2.UpVector

        if VehicleHitbox then
            local Y = VehicleHitbox.Size.Y

            if Y then
                Y2 = Y
            else
                Y2 = 4
            end
        else
            Y2 = 4
        end

        return Position + UpVector * ( Y2 + 3 )
    end,
    Facing = function( Object, Argument2 )
        local LookVector2
        local VehicleRoot = Object:FindFirstChild( "VehicleRoot" )

        if VehicleRoot then
            local LookVector = VehicleRoot.CFrame.LookVector * Vector3.new( 1, 0, 1 )

            if LookVector then
                LookVector2 = LookVector
            else
                LookVector2 = Vector3.new( 0, 0, 0 )
            end
        else
            LookVector2 = Vector3.new( 0, 0, 0 )
        end

        local Unit = LookVector2.Magnitude > 0.1 and LookVector2.Unit or Vector3.new( 0, 0, -1 )
        return CFrame.lookAt( Argument2, Argument2 + Unit )
    end,
    IsOutside = function( Object, Argument2, Amount )
        local VehicleHitbox = Object:FindFirstChild( "VehicleHitbox" )

        if not VehicleHitbox then
            return true
        end

        local Flag
        local PointToObjectSpace = VehicleHitbox.CFrame:PointToObjectSpace( Argument2 )
        local Size = VehicleHitbox.Size / 2 + Vector3.new( 1, 1, 1 ) * ( Amount or 1 )
        local Abs = math.abs( PointToObjectSpace.X )

        if Size.X < Abs then
            Flag = true
        else
            local Abs2 = math.abs( PointToObjectSpace.Z )

            if Size.Z < Abs2 then
                Flag = true
            else
                local Y = PointToObjectSpace.Y

                if Size.Y < Y then
                    Flag = true
                else
                    Flag = false
                end
            end
        end

        return Flag
    end,
    EjectVelocity = function( Part, Argument2, Argument3, Argument4, Argument5, Argument6, Argument7 )
        local CFrame = Argument2.CFrame
        local Size = Argument2.Size / 2
        local PointToObjectSpace = CFrame:PointToObjectSpace( Argument4 )
        local Abs = math.abs( PointToObjectSpace.X )

        if Size.X < Abs then
            local Number = not ( PointToObjectSpace.X > 0 ) and -1 or 1
            Argument5 = Number
        end

        local Unit
        local RightVector = CFrame.RightVector * Argument5 * Vector3.new( 1, 0, 1 )
        Unit = RightVector.Magnitude > 0.1 and RightVector.Unit or Vector3.new( 1, 0, 0 )
        local Result2
        local Number2 = Argument5 * Size.X
        local Z = PointToObjectSpace.Z
        local Amount = -Size.Z
        local Max = math.max( Part:GetVelocityAtPosition( ( CFrame:PointToWorldSpace( ( Vector3.new( Number2, 0, ( math.clamp( Z, Amount, Size.Z ) ) ) ) ) ) ):Dot( Unit ), 0 )
        local Result = Argument6 * Argument7
        local Max2 = Max + Argument3.EjectSide * Argument7 - Result:Dot( Unit )
        Result2 = if Max2 > 0 then Result + Unit * Max2 else Result
        return Result2, Argument5, Max
    end
}
function Table.Launch( Self, Argument2, Argument3 )
    local AssemblyLinearVelocity2
    local VehicleRoot = Self:FindFirstChild( "VehicleRoot" )

    if VehicleRoot then
        local AssemblyLinearVelocity = VehicleRoot.AssemblyLinearVelocity * Vector3.new( 1, 0, 1 )

        if AssemblyLinearVelocity then
            AssemblyLinearVelocity2 = AssemblyLinearVelocity
        else
            AssemblyLinearVelocity2 = Vector3.new( 0, 0, 0 )
        end
    else
        AssemblyLinearVelocity2 = Vector3.new( 0, 0, 0 )
    end
    if not VehicleRoot or AssemblyLinearVelocity2.Magnitude < Argument2.EjectSpeed then
        return Vector3.new( 0, 0, 0 ), nil
    end

    local Number
    local VehicleHitbox = Self:FindFirstChild( "VehicleHitbox" ) or VehicleRoot
    Number = not ( VehicleHitbox.CFrame:PointToObjectSpace( Argument3 ).X >= 0 ) and -1 or 1
    local Flag
    local EjectVelocity = Table.EjectVelocity
    local EjectVelocity2, EjectVelocity22 = EjectVelocity( VehicleRoot, VehicleHitbox, Argument2, Argument3, Number, AssemblyLinearVelocity2 * Argument2.EjectCarry, 1 )
    Flag = VehicleRoot.AssemblyLinearVelocity:Dot( VehicleRoot.CFrame.LookVector ) < 0 and true or false
    local EjectUpReverse2

    if Flag then
        local EjectUpReverse = Argument2.EjectUpReverse

        if EjectUpReverse then
            EjectUpReverse2 = EjectUpReverse
        else
            EjectUpReverse2 = 0
        end
    else
        EjectUpReverse2 = Argument2.EjectUp
    end

    return EjectVelocity2 + Vector3.new( 0, EjectUpReverse2, 0 ), EjectVelocity22
end
return Table
