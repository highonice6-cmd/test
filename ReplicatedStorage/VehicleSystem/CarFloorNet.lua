-- ReplicatedStorage.VehicleSystem.CarFloorNet
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Table2 = {
    "Cars",
    "FX",
    "ClientHitboxes",
    "TrainsLocaux",
    "Dummies",
    "LocalStepBlockers"
}
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.IgnoreWater = true
RaycastParams2.RespectCanCollide = true
RaycastParams2.CollisionGroup = "VehicleHitbox"
local Number = -math.huge

local function RefreshExclude()
    if os.clock( ) - Number < 0.5 then
        return
    end

    Number = os.clock( )
    local FilterDescendantsInstances = { }

    if workspace.CurrentCamera then
        table.insert( FilterDescendantsInstances, workspace.CurrentCamera )
    end

    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Find = WorldRefs.Find( Value )

        if Find then
            table.insert( FilterDescendantsInstances, Find )
        end
    end
    for Key2, Value2 in Players:GetPlayers( ) do
        if Value2.Character then
            table.insert( FilterDescendantsInstances, Value2.Character )
        end
    end

    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
end

local function IsFloor( Argument1 )
    local Anchored2

    if Argument1 then
        local Anchored = Argument1.Instance.Anchored

        if Anchored then
            if Argument1.Normal.Y > 0.6 then
                Anchored2 = true
            else
                Anchored2 = false
            end
        else
            Anchored2 = Anchored
        end
    else
        Anchored2 = Argument1
    end

    return Anchored2
end

local Table3 = { "RightVector", "UpVector", "LookVector" }

local function BottomOf( VehicleHitbox )
    local Value1, Number
    local CFrame = VehicleHitbox.CFrame
    local Size = VehicleHitbox.Size / 2
    local Table = { Size.X, Size.Y, Size.Z }
    Value1 = nil
    Number = math.huge

    for Key, Value in Table3, nil, nil do
        local Abs = math.abs( CFrame[ Value ].Y )

        if Abs > 0.001 then
            Number = math.min( Number, Table[ Key ] / Abs )
        end
    end

    return CFrame.Position.Y - Number
end

local Class = setmetatable( { }, { __mode = "k" } )
local Table = {
    Step = function( Model )
        local VehicleHitbox = Model:FindFirstChild( "VehicleHitbox" )
        local VehicleRoot = Model:FindFirstChild( "VehicleRoot" )

        if not VehicleHitbox or not VehicleHitbox:IsA( "BasePart" ) or not VehicleRoot or VehicleRoot.Anchored then
            return false
        end

        local Number
        RefreshExclude( )
        local Clock = os.clock( )
        local Position = VehicleHitbox.Position
        local BottomOf2 = BottomOf( VehicleHitbox )
        local Entry = Class[ Model ]
        Number = not ( VehicleHitbox.CFrame.UpVector.Y > 0.7 ) and 1.6 or 0.75

        if Entry and Clock - Entry.t <= 1.5 and BottomOf2 < Entry.y - Number and Vector2.new( Position.X - Entry.x, Position.Z - Entry.z ).Magnitude <= 25 then
            local Raycast2
            local X = Position.X
            local Y = Entry.y + 3
            local Vector32 = Vector3.new( X, Y, Position.Z )
            local Raycast = workspace:Raycast( Vector32, Vector3.new( 0, BottomOf2 - 0.1 - Vector32.Y, 0 ), RaycastParams2 )

            if Raycast then
                local Anchored = Raycast.Instance.Anchored

                if Anchored then
                    if Raycast.Normal.Y > 0.6 then
                        Raycast2 = true
                    else
                        Raycast2 = false
                    end
                else
                    Raycast2 = Anchored
                end
            else
                Raycast2 = Raycast
            end
            if Raycast2 then
                if Raycast.Instance == Entry.part or math.abs( Raycast.Position.Y - Entry.y ) < 1 then
                    local Y2 = Raycast.Position.Y

                    if BottomOf2 + Number / 2 < Y2 then
                        Model:PivotTo( Model:GetPivot( ) + Vector3.new( 0, Raycast.Position.Y + 0.3 - BottomOf2, 0 ) )
                        local AssemblyLinearVelocity = VehicleRoot.AssemblyLinearVelocity

                        if AssemblyLinearVelocity.Y < 0 then
                            local X2 = AssemblyLinearVelocity.X
                            VehicleRoot.AssemblyLinearVelocity = Vector3.new( X2, 0, AssemblyLinearVelocity.Z )
                        end

                        Class[ Model ] = {
                            y = Raycast.Position.Y,
                            part = Raycast.Instance,
                            t = Clock,
                            x = Position.X,
                            z = Position.Z
                        }
                        Model:SetAttribute( "FloorRescues", ( Model:GetAttribute( "FloorRescues" ) or 0 ) + 1 )
                        return true
                    end
                end
            end
        end

        local Raycast4
        local X3 = Position.X
        local Y3 = Position.Y
        local Max = math.max( Y3, BottomOf2 + 1 )
        local Vector33 = Vector3.new( X3, Max, Position.Z )
        local Raycast3 = workspace:Raycast( Vector33, Vector3.new( 0, -( Vector33.Y - BottomOf2 ) - 6, 0 ), RaycastParams2 )

        if Raycast3 then
            local Anchored2 = Raycast3.Instance.Anchored

            if Anchored2 then
                if Raycast3.Normal.Y > 0.6 then
                    Raycast4 = true
                else
                    Raycast4 = false
                end
            else
                Raycast4 = Anchored2
            end
        else
            Raycast4 = Raycast3
        end
        if Raycast4 and Raycast3.Position.Y <= BottomOf2 + 1 then
            Class[ Model ] = {
                y = Raycast3.Position.Y,
                part = Raycast3.Instance,
                t = Clock,
                x = Position.X,
                z = Position.Z
            }
        end

        return false
    end
}
return Table
