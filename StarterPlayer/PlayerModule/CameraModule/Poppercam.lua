-- StarterPlayer.PlayerModule.CameraModule.Poppercam
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local ZoomController = require( script.Parent:WaitForChild( "ZoomController" ) )
local UserFlag = Get.getUserFlag( "UserFixCameraFPError" )
local __index = { }
__index.__index = __index
local CFrame2 = CFrame.new( )

local function CframeToAxis( Argument1 )
    local ToAxisAngle, ToAxisAngle2 = Argument1:ToAxisAngle( )
    return ToAxisAngle * ToAxisAngle2
end

local function AxisToCFrame( Argument1 )
    local Magnitude = Argument1.Magnitude

    if Magnitude > 1e-05 then
        return CFrame.fromAxisAngle( Argument1, Magnitude )
    end
    return CFrame2
end

local function ExtractRotation( Argument1 )
    local _, _, _, Components4, Components5, Components6, Components7, Components8, Components9, Components10, Components11, Components12 = Argument1:GetComponents( )
    return CFrame.new( 0, 0, 0, Components4, Components5, Components6, Components7, Components8, Components9, Components10, Components11, Components12 )
end

function __index.new()
    return ( setmetatable( { lastCFrame = nil }, __index ) )
end
function __index.Step( Argument1, Argument2, LastCFrame )
    local LastCFrame2 = Argument1.lastCFrame or LastCFrame
    Argument1.lastCFrame = LastCFrame
    local Position = LastCFrame.Position
    local _, _, _, Components4, Components5, Components6, Components7, Components8, Components9, Components10, Components11, Components12 = LastCFrame:GetComponents( )
    local CFrame2Inner = CFrame.new( 0, 0, 0, Components4, Components5, Components6, Components7, Components8, Components9, Components10, Components11, Components12 )
    local Position2 = LastCFrame2.Position
    local _, _, _, Components42, Components52, Components62, Components72, Components82, Components92, Components102, Components112, Components122 = LastCFrame2:GetComponents( )
    local CFrame3 = CFrame.new( 0, 0, 0, Components42, Components52, Components62, Components72, Components82, Components92, Components102, Components112, Components122 )
    local Position3 = ( Position - Position2 ) / Argument2
    local ToAxisAngle, ToAxisAngle2 = ( CFrame2Inner * CFrame3:inverse( ) ):ToAxisAngle( )
    local ToAxisAngle3 = ToAxisAngle * ToAxisAngle2 / Argument2
    return {
        extrapolate = function( Argument1 )
            local FromAxisAngle
            local Captured = Position3 * Argument1 + Position
            local Captured2 = ToAxisAngle3 * Argument1
            local Magnitude = Captured2.Magnitude

            if Magnitude > 1e-05 then
                FromAxisAngle = CFrame.fromAxisAngle( Captured2, Magnitude )
            else
                FromAxisAngle = CFrame2
            end

            return FromAxisAngle * CFrame2Inner + Captured
        end,
        posVelocity = Position3,
        rotVelocity = ToAxisAngle3
    }
end
function __index.Reset( Argument1 )
    Argument1.lastCFrame = nil
end
local BaseOcclusion = require( script.Parent:WaitForChild( "BaseOcclusion" ) )
local Self = setmetatable( { }, BaseOcclusion )
Self.__index = Self
function Self.new()
    local New = setmetatable( BaseOcclusion.new( ), Self )
    New.focusExtrapolator = __index.new( )
    return New
end
function Self.GetOcclusionMode( Argument1 )
    return Enum.DevCameraOcclusionMode.Zoom
end
function Self.Enable( Argument1, Argument2 )
    Argument1.focusExtrapolator:Reset( )
end
function Self.Update( Argument1, Argument2, Argument3, Argument4 )
    local LookAlong

    if UserFlag then
        LookAlong = CFrame.lookAlong( Argument4.Position, -Argument3.LookVector ) * CFrame.new( 0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1 )
    else
        LookAlong = CFrame.new( Argument4.Position, Argument3.Position ) * CFrame.new( 0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1 )
    end

    local Step = Argument1.focusExtrapolator:Step( Argument2, LookAlong )
    return LookAlong * CFrame.new( 0, 0, ( ZoomController.Update( Argument2, LookAlong, Step ) ) ), Argument4
end
function Self.CharacterAdded( Argument1, Argument2, Argument3 )
end
function Self.CharacterRemoving( Argument1, Argument2, Argument3 )
end
function Self.OnCameraSubjectChanged( Argument1, Argument2 )
end
return Self
