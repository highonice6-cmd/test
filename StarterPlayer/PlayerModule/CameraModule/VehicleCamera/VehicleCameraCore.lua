-- StarterPlayer.PlayerModule.CameraModule.VehicleCamera.VehicleCameraCore
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CameraUtils = require( script.Parent.Parent.CameraUtils )
local VehicleCameraConfig = require( script.Parent.VehicleCameraConfig )
local Map = CameraUtils.map
local MapClamp = CameraUtils.mapClamp
local SanitizeAngle = CameraUtils.sanitizeAngle

local function GetYaw( Argument1 )
    local _, ToEulerAnglesYXZ2 = Argument1:toEulerAnglesYXZ( )
    return SanitizeAngle( ToEulerAnglesYXZ2 )
end

local function GetPitch( Argument1 )
    return SanitizeAngle( ( Argument1:toEulerAnglesYXZ( ) ) )
end

local function StepSpringAxis( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local SanitizeAngle2 = SanitizeAngle( Argument4 - Argument3 )
    local Exp = math.exp( -Argument2 * Argument1 )
    return SanitizeAngle( ( SanitizeAngle2 * ( 1 + Argument2 * Argument1 ) + Argument5 * Argument1 ) * Exp + Argument3 ), ( Argument5 * ( 1 - Argument2 * Argument1 ) - SanitizeAngle2 * ( Argument2 * Argument2 * Argument1 ) ) * Exp
end

local __index = { }
__index.__index = __index
function __index.new( Argument1, Argument2, Amount )
    return ( setmetatable( {
        fRising = Argument1,
        fFalling = Argument2,
        g = Amount,
        p = Amount,
        v = Amount * 0
    }, __index ) )
end
function __index.step( Argument1, Argument2 )
    local FRising = Argument1.fRising
    local FFalling = Argument1.fFalling
    local G = Argument1.g
    local P = Argument1.p
    local V = Argument1.v

    if not ( V > 0 ) or not FRising then
    else
        FFalling = FRising
    end

    local FRising2 = 6.283185307179586 * FFalling
    local P2 = P - G
    local Exp = math.exp( -FRising2 * Argument2 )
    local P3 = ( P2 * ( 1 + FRising2 * Argument2 ) + V * Argument2 ) * Exp + G
    local V2 = ( V * ( 1 - FRising2 * Argument2 ) - P2 * ( FRising2 * FRising2 * Argument2 ) ) * Exp
    Argument1.p = P3
    Argument1.v = V2
    return P3
end
local __index2 = { }
__index2.__index = __index2
function __index2.new( Argument1 )
    local Flag
    Flag = typeof( Argument1 ) == "CFrame" and true or false
    assert( Flag )
    local _, ToEulerAnglesYXZ2 = Argument1:toEulerAnglesYXZ( )
    local SanitizeAngle2 = SanitizeAngle( ToEulerAnglesYXZ2 )
    local _, ToEulerAnglesYXZ22 = Argument1:toEulerAnglesYXZ( )
    local SanitizeAngle3 = SanitizeAngle( ToEulerAnglesYXZ22 )
    local SanitizeAngle4 = SanitizeAngle( ( Argument1:toEulerAnglesYXZ( ) ) )
    local SanitizeAngle5 = SanitizeAngle( ( Argument1:toEulerAnglesYXZ( ) ) )
    local New = __index.new
    local YawReponseDampingRising = VehicleCameraConfig.yawReponseDampingRising
    local New2 = New( YawReponseDampingRising, VehicleCameraConfig.yawResponseDampingFalling, 0 )
    local New3 = __index.new
    local PitchReponseDampingRising = VehicleCameraConfig.pitchReponseDampingRising
    return ( setmetatable( {
        yawG = SanitizeAngle2,
        yawP = SanitizeAngle3,
        yawV = 0,
        pitchG = SanitizeAngle4,
        pitchP = SanitizeAngle5,
        pitchV = 0,
        fSpringYaw = New2,
        fSpringPitch = New3( PitchReponseDampingRising, VehicleCameraConfig.pitchResponseDampingFalling, 0 )
    }, __index2 ) )
end
function __index2.setGoal( Argument1, Argument2 )
    local Flag = typeof( Argument2 ) == "CFrame" and true or false
    assert( Flag )
    local _, ToEulerAnglesYXZ2 = Argument2:toEulerAnglesYXZ( )
    Argument1.yawG = SanitizeAngle( ToEulerAnglesYXZ2 )
    Argument1.pitchG = SanitizeAngle( ( Argument2:toEulerAnglesYXZ( ) ) )
end
function __index2.getCFrame( Argument1 )
    local PitchP = Argument1.pitchP
    return CFrame.fromEulerAnglesYXZ( PitchP, Argument1.yawP, 0 )
end
function __index2.step( Self, Argument2, Argument3, Argument4, Argument5 )
    local Flag = typeof( Argument2 ) == "number" and true or false
    local Flag2
    assert( Flag )
    Flag2 = typeof( Argument4 ) == "number" and true or false
    local Flag3
    assert( Flag2 )
    Flag3 = typeof( Argument3 ) == "number" and true or false
    local Flag4
    assert( Flag3 )
    Flag4 = typeof( Argument5 ) == "number" and true or false
    assert( Flag4 )
    local FSpringYaw = Self.fSpringYaw
    local FSpringPitch = Self.fSpringPitch
    local Map2 = Map( Argument5, 0, 1, Argument4, 0 )
    local Rad = math.rad( VehicleCameraConfig.cutoffMinAngularVelYaw )
    FSpringYaw.g = MapClamp( Map2, Rad, math.rad( VehicleCameraConfig.cutoffMaxAngularVelYaw ), 1, 0 )
    local Map3 = Map( Argument5, 0, 1, Argument3, 0 )
    local Rad2 = math.rad( VehicleCameraConfig.cutoffMinAngularVelPitch )
    FSpringPitch.g = MapClamp( Map3, Rad2, math.rad( VehicleCameraConfig.cutoffMaxAngularVelPitch ), 1, 0 )
    local YawStiffness = 6.283185307179586 * VehicleCameraConfig.yawStiffness * FSpringYaw:step( Argument2 )
    local PitchStiffness = 6.283185307179586 * VehicleCameraConfig.pitchStiffness * FSpringPitch:step( Argument2 ) * Map( Argument5, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul )
    local YawStiffness2 = YawStiffness * Map( Argument5, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul )
    local YawG = Self.yawG
    local YawP = Self.yawP
    local YawV = Self.yawV
    local SanitizeAngle2 = SanitizeAngle( YawP - YawG )
    local Exp = math.exp( -YawStiffness2 * Argument2 )
    local YawP2 = SanitizeAngle( ( SanitizeAngle2 * ( 1 + YawStiffness2 * Argument2 ) + YawV * Argument2 ) * Exp + YawG )
    local YawV2 = ( YawV * ( 1 - YawStiffness2 * Argument2 ) - SanitizeAngle2 * ( YawStiffness2 * YawStiffness2 * Argument2 ) ) * Exp
    Self.yawP = YawP2
    Self.yawV = YawV2
    local PitchG = Self.pitchG
    local PitchP = Self.pitchP
    local PitchV = Self.pitchV
    local SanitizeAngle3 = SanitizeAngle( PitchP - PitchG )
    local Exp2 = math.exp( -PitchStiffness * Argument2 )
    local PitchP2 = SanitizeAngle( ( SanitizeAngle3 * ( 1 + PitchStiffness * Argument2 ) + PitchV * Argument2 ) * Exp2 + PitchG )
    local PitchV2 = ( PitchV * ( 1 - PitchStiffness * Argument2 ) - SanitizeAngle3 * ( PitchStiffness * PitchStiffness * Argument2 ) ) * Exp2
    Self.pitchP = PitchP2
    Self.pitchV = PitchV2
    return Self:getCFrame( )
end
local __index3 = { }
__index3.__index = __index3
function __index3.new( Argument1 )
    return ( setmetatable( { vrs = __index2.new( Argument1 ) }, __index3 ) )
end
function __index3.step( Argument1, Argument2, Argument3, Argument4, Argument5 )
    return Argument1.vrs:step( Argument2, Argument3, Argument4, Argument5 )
end
function __index3.setTransform( Argument1, Argument2 )
    Argument1.vrs:setGoal( Argument2 )
end
return __index3
