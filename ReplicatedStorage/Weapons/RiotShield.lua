-- ReplicatedStorage.Weapons.RiotShield
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Table = { KEY = "RiotShield", ARC = 0.17364817766693041 }
function Table.Held( Object )
    if typeof( Object ) ~= "Instance" or Object:GetAttribute( "Downed" ) then
        return nil
    end

    local Tool = Object:FindFirstChildOfClass( "Tool" )

    if not Tool or Tool:GetAttribute( "Melee" ) ~= Table.KEY then
        return nil
    end

    local Handle = Tool:FindFirstChild( "Handle" )

    if not Handle or not Handle:IsA( "BasePart" ) or not Handle:IsDescendantOf( workspace ) then
        return nil
    end
    return Handle
end
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Include
function Table.Blocks( Object, Argument2, Argument3 )
    local Held = Table.Held( Object )

    if not Held or typeof( Argument2 ) ~= "Vector3" then
        return false
    end

    local Position

    if typeof( Argument3 ) == "Vector3" then
        Position = Argument3
    else
        local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )

        if not HumanoidRootPart then
            return false
        end

        Position = HumanoidRootPart.Position
    end

    local Position2 = Position - Argument2

    if Position2.Magnitude < 0.05 then
        return false
    end

    RaycastParams2.FilterDescendantsInstances = { Held }
    local Unit = Argument2 - Position2.Unit * 0.75
    local Raycast = workspace:Raycast( Unit, Position - Unit, RaycastParams2 )

    if Raycast then
        return true, Raycast.Position, Held
    end
    return false
end
function Table.BlocksMelee( Object, Argument2 )
    local HumanoidRootPart
    local Held = Table.Held( Object )

    if Held then
        HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Held
    end
    if not HumanoidRootPart or typeof( Argument2 ) ~= "Vector3" then
        return false
    end

    local Position = Argument2 - HumanoidRootPart.Position
    local X = Position.X
    local Vector32 = Vector3.new( X, 0, Position.Z )
    local LookVector = HumanoidRootPart.CFrame.LookVector
    local X2 = LookVector.X
    local Vector33 = Vector3.new( X2, 0, LookVector.Z )

    if not ( Vector32.Magnitude < 0.3 ) and not ( Vector33.Magnitude < 0.1 ) then
        local Dot = Vector32.Unit:Dot( Vector33.Unit )

        if not ( Table.ARC <= Dot ) then
            return false
        end
    end

    return true, Held.Position, Held
end
function Table.Clang( Parent, Amount )
    if typeof( Parent ) ~= "Instance" or not Parent:IsA( "BasePart" ) then
        return
    end

    local MeleeSounds
    local Weapons = ReplicatedStorage:FindFirstChild( "Weapons" )

    if Weapons then
        MeleeSounds = ReplicatedStorage.Weapons:FindFirstChild( "MeleeSounds" )
    else
        MeleeSounds = Weapons
    end
    if not MeleeSounds then
        return
    end

    local Table = { }

    for Key, Value in MeleeSounds:GetChildren( ) do
        if Value:IsA( "Sound" ) and Value.Name:sub( 1, 6 ) == "HitCar" then
            table.insert( Table, Value )
        end
    end
    if #Table == 0 then
        return
    end
    local Clone = Table[ math.random( #Table ) ]:Clone( )
    Clone.Volume = Amount or 1.4
    Clone.PlaybackSpeed = 1.05 + math.random( ) * 0.15
    Clone.Parent = Parent
    Clone:Play( )
    Clone.Ended:Once( function()
        Clone:Destroy( )
    end )
    task.delay( 4, function()
        if Clone.Parent then
            Clone:Destroy( )
        end
    end )
    return
end
return Table
