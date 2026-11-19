-- StarterPlayer.PlayerModule.CameraModule.ZoomController
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Popper = require( script:WaitForChild( "Popper" ) )
local Clamp = math.clamp
local Exp = math.exp
local Min = math.min
local Max = math.max
local CameraMinZoomDistance = nil
local CameraMaxZoomDistance = nil
local LocalPlayer = game:GetService( "Players" ).LocalPlayer
assert( LocalPlayer )

local function UpdateBounds()
    CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
    CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
end

CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
LocalPlayer:GetPropertyChangedSignal( "CameraMinZoomDistance" ):Connect( UpdateBounds )
LocalPlayer:GetPropertyChangedSignal( "CameraMaxZoomDistance" ):Connect( UpdateBounds )
local __index = { }
__index.__index = __index
function __index.new( Argument1, Argument2, Argument3, Argument4 )
    local Clamp2 = Clamp( Argument2, Argument3, Argument4 )
    return ( setmetatable( {
        freq = Argument1,
        x = Clamp2,
        v = 0,
        minValue = Argument3,
        maxValue = Argument4,
        goal = Clamp2
    }, __index ) )
end
function __index.Step( Argument1, Argument2 )
    local X2
    local Freq = Argument1.freq * 2 * 3.141592653589793
    local X = Argument1.x
    local V = Argument1.v
    local MinValue = Argument1.minValue
    local MaxValue = Argument1.maxValue
    local Goal = Argument1.goal
    local Goal2 = Goal - X
    local Freq2 = Freq * Argument2
    local Exp2 = Exp( -Freq2 )
    local Goal3 = Goal + ( V * Argument2 - Goal2 * ( Freq2 + 1 ) ) * Exp2
    local V2 = ( ( Goal2 * Freq - V ) * Freq2 + V ) * Exp2

    if Goal3 < MinValue then
        X2 = MinValue
        V2 = 0
    elseif MaxValue < Goal3 then
        X2 = MaxValue
        V2 = 0
    else
        X2 = Goal3
    end

    Argument1.x = X2
    Argument1.v = V2
    return X2
end
local New = __index.new( 4.5, 12.5, 0.5, CameraMaxZoomDistance )

local function StepTargetZoom( Amount, Amount2, Argument3, Argument4 )
    local Number2
    local Clamp2 = Clamp( Amount + Amount2 * ( Amount * 0.0375 + 1 ), Argument3, Argument4 )

    if Clamp2 < 1 then
        local Number = Amount2 <= 0 and Argument3 or 1
        Number2 = Number
    else
        Number2 = Clamp2
    end

    return Number2
end

local Number = 0
local Table = {
    Update = function( Argument1, Argument2, Argument3 )
        local NumberInner

        if New.goal > 1 then
            local Captured2
            local X = New.x
            local Goal = New.goal
            local Clamp2 = Clamp( Goal + Number * ( Goal * 0.0375 + 1 ), CameraMinZoomDistance, CameraMaxZoomDistance )

            if Clamp2 < 1 then
                local Captured = Number <= 0 and CameraMinZoomDistance or 1
                Captured2 = Captured
            else
                Captured2 = Clamp2
            end

            local Max2 = Max( X, Captured2 )
            local CFrame2 = Argument2 * CFrame.new( 0, 0, 0.5 )
            NumberInner = Popper( CFrame2, Max2 - 0.5, Argument3 ) + 0.5
        else
            NumberInner = math.huge
        end

        New.minValue = 0.5
        New.maxValue = Min( CameraMaxZoomDistance, NumberInner )
        return New:Step( Argument1 )
    end,
    GetZoomRadius = function()
        return New.x
    end,
    SetZoomParameters = function( Goal, Argument2 )
        New.goal = Goal
        Number = Argument2
    end,
    ReleaseSpring = function()
        New.x = New.goal
        New.v = 0
    end
}
return Table
