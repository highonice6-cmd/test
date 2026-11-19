-- ReplicatedStorage.VehicleSystem.VehicleImpact
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local function ClosestOnBox( Self, Amount, Argument3 )
    local PointToObjectSpace = Self:PointToObjectSpace( Argument3 )
    local Result = Amount / 2
    local X = PointToObjectSpace.X
    local Amount2 = -Result.X
    local Clamp = math.clamp( X, Amount2, Result.X )
    local Y = PointToObjectSpace.Y
    local Amount3 = -Result.Y
    local Clamp2 = math.clamp( Y, Amount3, Result.Y )
    local Z = PointToObjectSpace.Z
    local Amount4 = -Result.Z
    return Self:PointToWorldSpace( ( Vector3.new( Clamp, Clamp2, ( math.clamp( Z, Amount4, Result.Z ) ) ) ) )
end

local Table = {
    Contact = function( Argument1, Argument2 )
        local Position2
        local ClosestOnBox2 = ClosestOnBox( Argument2.CFrame, Argument2.Size, Argument1.Position )
        local ClosestOnBox3 = ClosestOnBox( Argument1.CFrame, Argument1.Size, Argument2.Position )
        local Position = ( Argument1.Position - ClosestOnBox2 ) * Vector3.new( 1, 0, 1 )
        Position2 = if Position.Magnitude < 0.05 then ( Argument1.Position - Argument2.Position ) * Vector3.new( 1, 0, 1 ) else Position

        if Position2.Magnitude < 0.05 then
            return nil
        end
        return Position2.Unit, ( ClosestOnBox2 + ClosestOnBox3 ) / 2
    end
}

local function ShareOf( Argument1, Argument2, Argument3, Amount, Argument5 )
    local Total4
    local Total = ( 1 + Amount ) * Argument3 * Argument2
    local Total2 = Argument1 + Total

    if Total2 < 0 then
        local Total3 = Total * Argument5
        Total4 = Total2 + math.min( Total3, -Total2 )
    else
        Total4 = Total2
    end

    return Total4 - Argument1
end

function Table.Resolve( Part, Part2, Argument3, Argument4, Part3, Argument6, Argument7 )
    local Contact, Contact2 = Table.Contact( Part2, Part3 )

    if not Contact then
        return nil
    end

    local Dot = ( Argument6 - Argument3 ):Dot( Contact )

    if Dot < ( Argument7.ImpactMinSpeed or 4 ) then
        return nil
    end

    local Dot4
    local CarRestitution = Argument7.CarRestitution or 0.15
    local ImpactSlowdown = Argument7.ImpactSlowdown or 0
    local Mass = Part2:GetMass( )
    local Mass2 = Part3:GetMass( )
    local Dot2 = Argument3:Dot( Contact )
    local Mass3 = Mass2 / ( Mass + Mass2 )
    local CarRestitution2 = ( 1 + CarRestitution ) * Mass3 * Dot
    local Dot3 = Dot2 + CarRestitution2

    if Dot3 < 0 then
        local CarRestitution3 = CarRestitution2 * ImpactSlowdown
        Dot4 = Dot3 + math.min( CarRestitution3, -Dot3 )
    else
        Dot4 = Dot3
    end

    local Dot8
    local Dot5 = Dot4 - Dot2
    local AssemblyCenterOfMass = Part.AssemblyCenterOfMass
    local X = Contact2.X
    local Y = AssemblyCenterOfMass.Y
    local Vector32 = Vector3.new( X, Y, Contact2.Z )
    Part:ApplyImpulseAtPosition( Contact * ( Part.AssemblyMass * ( Argument3:Dot( Contact ) + Dot5 - Part.AssemblyLinearVelocity:Dot( Contact ) ) ), Vector32 )
    local Dot6 = Argument6:Dot( -Contact )
    local Mass4 = Mass / ( Mass + Mass2 )
    local CarRestitution4 = ( 1 + CarRestitution ) * Mass4 * Dot
    local Dot7 = Dot6 + CarRestitution4

    if Dot7 < 0 then
        local CarRestitution5 = CarRestitution4 * ImpactSlowdown
        Dot8 = Dot7 + math.min( CarRestitution5, -Dot7 )
    else
        Dot8 = Dot7
    end

    local Dot9 = Dot8 - Dot6
    local Amount = -Contact * Dot9
    local AssemblyCenterOfMass2 = Argument4.AssemblyCenterOfMass
    local X2 = Contact2.X
    local Y2 = AssemblyCenterOfMass2.Y
    local Cross = ( Vector3.new( X2, Y2, Contact2.Z ) - AssemblyCenterOfMass2 ):Cross( Amount * Mass2 )
    local Size = Part3.Size
    local Y3 = Size.Y * Size.Y + Size.Z * Size.Z
    local X3 = Size.X * Size.X + Size.Z * Size.Z
    local Vector33 = Vector3.new( Y3, X3, Size.X * Size.X + Size.Y * Size.Y ) * ( Mass2 / 12 )
    return Amount, Part3.CFrame:VectorToWorldSpace( Part3.CFrame:VectorToObjectSpace( Cross ) / Vector33 ) * 0.45, Dot
end
return Table
