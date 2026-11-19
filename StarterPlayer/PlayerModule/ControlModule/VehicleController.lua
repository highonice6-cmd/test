-- StarterPlayer.PlayerModule.ControlModule.VehicleController
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local VehicleContext = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "VehicleContext" )
local ThrottleAction = VehicleContext:WaitForChild( "ThrottleAction" )
local SteerAction = VehicleContext:WaitForChild( "SteerAction" )
require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local __index = { }
__index.__index = __index
function __index.new()
    local Self = setmetatable( { }, __index )
    Self.enabled = false
    Self.vehicleSeat = nil
    return Self
end
function __index.Enable( Argument1, Enabled, VehicleSeat )
    if Enabled == Argument1.enabled and VehicleSeat == Argument1.vehicleSeat then
        return
    end

    Argument1.enabled = Enabled

    if not Enabled then
        VehicleContext.Enabled = false
        Argument1.vehicleSeat = nil
        return
    end
    if VehicleSeat then
        Argument1.vehicleSeat = VehicleSeat
        VehicleContext.Enabled = true
        return
    end
    return
end
function __index.Update( Self, Argument2, Argument3 )
    if not Self.vehicleSeat then
        return Argument2, false
    end
    if Argument3 then
        local State = ThrottleAction:GetState( )
        local State2 = SteerAction:GetState( )
        local Vector32 = Argument2 + Vector3.new( State2, 0, -State )
        local VehicleSeat = Self.vehicleSeat
        VehicleSeat.ThrottleFloat = -Vector32.Z
        local VehicleSeat2 = Self.vehicleSeat
        VehicleSeat2.SteerFloat = Vector32.X
        return Vector32, true
    end
    local VectorToObjectSpace = Self.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace( Argument2 )
    local VehicleSeat3 = Self.vehicleSeat
    VehicleSeat3.ThrottleFloat = Self:ComputeThrottle( VectorToObjectSpace )
    local VehicleSeat4 = Self.vehicleSeat
    VehicleSeat4.SteerFloat = Self:ComputeSteer( VectorToObjectSpace )
    return Vector3.new( 0, 0, 0 ), true
end
function __index.ComputeThrottle( Argument1, Argument2 )
    if Argument2 == Vector3.new( 0, 0, 0 ) then
        return 0
    end
    return -Argument2.Z
end
function __index.ComputeSteer( Argument1, Argument2 )
    if Argument2 == Vector3.new( 0, 0, 0 ) then
        return 0
    end
    local Amount = -Argument2.x
    return -math.atan2( Amount, -Argument2.z ) * 57.29577951308232
end
return __index
