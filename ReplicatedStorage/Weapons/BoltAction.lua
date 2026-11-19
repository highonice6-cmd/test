-- ReplicatedStorage.Weapons.BoltAction
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local WeaponData = require( script.Parent:WaitForChild( "WeaponData" ) )
local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local Table2 = { Bolt = true, Slide = true }
local Angles = CFrame.Angles( 0, 0, 0.6108652381980153 )
local Table3 = { forend = true, bolt_carrier = true, Pump = true }

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function Seg( Argument1, Argument2, Argument3 )
    local Clamp = math.clamp( ( Argument1 - Argument2 ) / ( Argument3 - Argument2 ), 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function Snap( Argument1, Argument2, Argument3 )
    return 1 - ( 1 - math.clamp( ( Argument1 - Argument2 ) / ( Argument3 - Argument2 ), 0, 1 ) ) ^ 3
end

local function Bump( Argument1, Argument2, Argument3 )
    if Argument1 <= Argument2 or Argument3 <= Argument1 then
        return 0
    end
    return ( math.sin( ( Argument1 - Argument2 ) / ( Argument3 - Argument2 ) * 3.141592653589793 ) )
end

local Table4 = { }
local Table = {
    IsPump = function( Name )
        local Entry2
        local Entry = WeaponData[ Name or "" ]

        if Entry then
            if Entry.Fire.Pump == true then
                Entry2 = true
            else
                Entry2 = false
            end
        else
            Entry2 = Entry
        end

        return Entry2
    end,
    IsMovingPart = function( Name, Key )
        local Entry2
        local Entry = WeaponData[ Name or "" ]

        if Entry then
            if Entry.Fire.Pump == true then
                Entry2 = true
            else
                Entry2 = false
            end
        else
            Entry2 = Entry
        end
        if Entry2 then
            local Flag = Table3[ Key ] == true and true or false
            return Flag
        end
        local Flag2 = Table2[ Key ] == true and true or false
        return Flag2
    end,
    Geometry = function( Name )
        if Table4[ Name ] ~= nil then
            return Table4[ Name ] or nil
        end

        local FoundChild2
        local FoundChild = WeaponVisuals:FindFirstChild( Name or "" )
        FoundChild2 = if FoundChild then FoundChild.PrimaryPart else FoundChild

        if FoundChild2 then
            local Entry2
            local Entry = WeaponData[ Name or "" ]

            if Entry then
                if Entry.Fire.Pump == true then
                    Entry2 = true
                else
                    Entry2 = false
                end
            else
                Entry2 = Entry
            end
            if Entry2 then
                local Position
                local Barrel = FoundChild:FindFirstChild( "Barrel", true )

                if not Barrel or not Barrel:IsA( "BasePart" ) then
                    Position = Vector3.new( 0, 0, 1 )
                else
                    local RightVector
                    local ToObjectSpace = FoundChild2.CFrame:ToObjectSpace( Barrel.CFrame )
                    local Size = Barrel.Size
                    local X = Size.X

                    if not ( Size.Y <= X ) or not ( Size.Z <= Size.X ) or not ToObjectSpace.RightVector then
                        local Y = Size.Y

                        if not ( Size.Z <= Y ) or not ToObjectSpace.UpVector then
                            RightVector = ToObjectSpace.LookVector
                        else
                            RightVector = ToObjectSpace.UpVector
                        end
                    else
                        RightVector = ToObjectSpace.RightVector
                    end

                    local RightVector2 = if not ( RightVector.Z >= 0 ) or not RightVector then -RightVector else RightVector
                    Position = RightVector2
                end

                Table4[ Name ] = { pump = true, back = Position.Unit }
                return Table4[ Name ]
            end
        end

        local Bolt

        if FoundChild then
            Bolt = FoundChild:FindFirstChild( "Bolt", true )
        else
            Bolt = FoundChild
        end
        if not FoundChild2 or not Bolt or not Bolt:IsA( "BasePart" ) then
            Table4[ Name ] = false
            return nil
        end

        local X3
        local ToObjectSpace2 = FoundChild2.CFrame:ToObjectSpace( Bolt.CFrame )
        local X2 = Vector3.new( 1, 0, 0 ) * Bolt.Size.X
        local Y2 = Bolt.Size.Y

        if X2.Magnitude < Y2 then
            X3 = Vector3.new( 0, 1, 0 ) * Bolt.Size.Y
        else
            X3 = X2
        end

        local Z = Bolt.Size.Z

        if X3.Magnitude < Z then
            X3 = Vector3.new( 0, 0, 1 ) * Bolt.Size.Z
        end

        local Item
        local Table = { ToObjectSpace2 * ( X3 / 2 ), ToObjectSpace2 * ( -X3 / 2 ) }
        local Z2 = Table[ 1 ].Z
        Item = Table[ 2 ].Z < Z2 and Table[ 1 ] or Table[ 2 ]
        local Item2 = Item + Vector3.new( 0.14000000059604645, 0, 0 )
        local Y3 = ToObjectSpace2.Position.Y
        Table4[ Name ] = {
            knob = Item2,
            pivot = Vector3.new( 0, Y3, ToObjectSpace2.Position.Z )
        }
        return Table4[ Name ]
    end
}
function Table.BoltTransform( Argument1, Amount )
    local Geometry = Table.Geometry( Argument1 )

    if not Geometry or not Amount then
        return CFrame.identity
    end
    if Geometry.pump then
        local Clamp = ( 1 - ( 1 - math.clamp( ( Amount - 0.24 ) / 0.10999999999999999, 0, 1 ) ) ^ 3 ) * ( 1 - ( 1 - ( 1 - math.clamp( ( Amount - 0.69 ) / 0.1100000000000001, 0, 1 ) ) ^ 3 ) )
        return CFrame.new( Geometry.back * Clamp * 0.45 )
    end
    local Clamp2 = math.clamp( ( Amount - 0.32 ) / 0.12, 0, 1 )
    local Clamp3 = Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 )
    local Clamp4 = math.clamp( ( Amount - 0.74 ) / 0.09999999999999998, 0, 1 )
    local Clamp5 = Clamp3 * ( 1 - Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 ) )
    local Clamp6 = math.clamp( ( Amount - 0.44 ) / 0.15999999999999998, 0, 1 )
    local Clamp7 = Clamp6 * Clamp6 * ( 3 - 2 * Clamp6 )
    local Clamp8 = math.clamp( ( Amount - 0.6 ) / 0.14, 0, 1 )
    return CFrame.new( 0, 0, Clamp7 * ( 1 - Clamp8 * Clamp8 * ( 3 - 2 * Clamp8 ) ) * 0.32 ) * CFrame.new( Geometry.pivot ) * CFrame.Angles( 0, 0, Clamp5 * 1.1344640137963142 ) * CFrame.new( -Geometry.pivot )
end
function Table.Hand( Argument1, Argument2, Amount )
    local Geometry = Table.Geometry( Argument1 )

    if not Geometry or not Amount then
        return Argument2
    end
    if Geometry.pump then
        return Table.BoltTransform( Argument1, Amount ) * Argument2
    end
    local CFrame2 = CFrame.new( Table.BoltTransform( Argument1, Amount ) * ( Geometry.knob + Vector3.new( 0.019999999552965164, 0.11999999731779099, 0.019999999552965164 ) ) ) * Argument2.Rotation * Angles
    local Clamp = math.clamp( ( Amount - 0.15 ) / 0.17, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    local Clamp3 = math.clamp( ( Amount - 0.84 ) / 0.16000000000000003, 0, 1 )
    return Argument2:Lerp( CFrame2, Clamp2 * ( 1 - Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) ) )
end
function Table.Progress( Object )
    local BoltStart

    if Object then
        BoltStart = Object:GetAttribute( "BoltStart" )
    else
        BoltStart = Object
    end
    if not BoltStart then
        return nil
    end

    local Entry2
    local Entry = WeaponData[ Object:GetAttribute( "Weapon" ) or "" ]
    Entry2 = if Entry then Entry.Fire.BoltTime else Entry

    if not Entry2 then
        return nil
    end

    local Clock = ( os.clock( ) - BoltStart ) / Entry2

    if Clock >= 1 or Clock < 0 then
        return nil
    end
    return Clock
end
function Table.Start( Object, Amount )
    if Object and WeaponData[ Object:GetAttribute( "Weapon" ) or "" ] and ( Object and WeaponData[ Object:GetAttribute( "Weapon" ) or "" ] ).Fire.BoltTime then
        Object:SetAttribute( "BoltStart", os.clock( ) + ( Amount or 0 ) )
    end
end
function Table.Cancel( Object )
    if Object then
        Object:SetAttribute( "BoltStart", nil )
    end
end
function Table.GunJolt( Argument1, Amount )
    local Geometry

    if Amount then
        Geometry = Table.Geometry( Argument1 )
    else
        Geometry = Amount
    end
    if not Geometry or not Geometry.pump then
        return CFrame.identity
    end

    local Sin

    if Amount <= 0.32999999999999996 or Amount >= 0.44999999999999996 then
        Sin = 0
    else
        Sin = math.sin( ( Amount - 0.32999999999999996 ) / 0.12 * 3.141592653589793 )
    end

    local Sin2

    if Amount <= 0.78 or Amount >= 0.9 then
        Sin2 = 0
    else
        Sin2 = math.sin( ( Amount - 0.78 ) / 0.12 * 3.141592653589793 )
    end

    return CFrame.new( Geometry.back * ( Sin * 0.07 - Sin2 * 0.05 ) ) * CFrame.Angles( 0.04363323129985824 * ( Sin2 - Sin ), 0, 0 )
end
function Table.ScopeShake( Amount )
    if not Amount then
        return CFrame.identity
    end

    local Sin

    if Amount <= 0.44 or Amount >= 0.6 then
        Sin = 0
    else
        Sin = math.sin( ( Amount - 0.44 ) / 0.15999999999999998 * 3.141592653589793 )
    end

    local Sin2
    local Number = 0.35 * Sin

    if Amount <= 0.6 or Amount >= 0.74 then
        Sin2 = 0
    else
        Sin2 = math.sin( ( Amount - 0.6 ) / 0.14 * 3.141592653589793 )
    end

    local Sin3
    local Number2 = Number - 0.45 * Sin2

    if Amount <= 0.4 or Amount >= 0.6 then
        Sin3 = 0
    else
        Sin3 = math.sin( ( Amount - 0.4 ) / 0.19999999999999996 * 3.141592653589793 )
    end

    local Sin4
    local Number3 = 0.25 * Sin3

    if Amount <= 0.6 or Amount >= 0.78 then
        Sin4 = 0
    else
        Sin4 = math.sin( ( Amount - 0.6 ) / 0.18000000000000005 * 3.141592653589793 )
    end

    local Sin5
    local Number4 = Number3 - 0.2 * Sin4

    if Amount <= 0.32 or Amount >= 0.5 then
        Sin5 = 0
    else
        Sin5 = math.sin( ( Amount - 0.32 ) / 0.18 * 3.141592653589793 )
    end

    local Sin6
    local Number5 = 0.8 * Sin5

    if Amount <= 0.7 or Amount >= 0.88 then
        Sin6 = 0
    else
        Sin6 = math.sin( ( Amount - 0.7 ) / 0.18000000000000005 * 3.141592653589793 )
    end

    local Number6 = Number5 + 0.6 * Sin6
    return CFrame.Angles( math.rad( Number2 ), math.rad( Number4 ), ( math.rad( Number6 ) ) )
end
return Table
