-- StarterPlayer.PlayerModule.CameraModule.CameraUtils
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local UserInputService = game:GetService( "UserInputService" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )

local function Round( Amount )
    return ( math.floor( Amount + 0.5 ) )
end

local __index = { }
__index.__index = __index
function __index.new( Argument1, Argument2 )
    return ( setmetatable( { freq = Argument1, goal = Argument2, pos = Argument2, vel = 0 }, __index ) )
end
function __index.step( Argument1, Argument2 )
    local Freq = Argument1.freq * 2 * 3.141592653589793
    local Goal = Argument1.goal
    local Pos = Argument1.pos
    local Vel = Argument1.vel
    local Pos2 = Pos - Goal
    local Exp = math.exp( -Freq * Argument2 )
    local Pos3 = ( Pos2 * ( Freq * Argument2 + 1 ) + Vel * Argument2 ) * Exp + Goal
    local Vel2 = ( Vel * ( 1 - Freq * Argument2 ) - Pos2 * ( Freq * Freq * Argument2 ) ) * Exp
    Argument1.pos = Pos3
    Argument1.vel = Vel2
    return Pos3
end
local Table = {
    Spring = __index,
    map = function( Argument1, Argument2, Argument3, Argument4, Argument5 )
        return ( Argument1 - Argument2 ) * ( Argument5 - Argument4 ) / ( Argument3 - Argument2 ) + Argument4
    end,
    mapClamp = function( Argument1, Argument2, Argument3, Argument4, Argument5 )
        local Total = ( Argument1 - Argument2 ) * ( Argument5 - Argument4 ) / ( Argument3 - Argument2 ) + Argument4
        local Min = math.min( Argument4, Argument5 )
        return ( math.clamp( Total, Min, ( math.max( Argument4, Argument5 ) ) ) )
    end,
    getLooseBoundingSphere = function( List )
        local Create = table.create( #List )

        for Key, Value in pairs( List ) do
            Create[ Key ] = Value.Position
        end

        local Item2, Number2
        local Item = Create[ 1 ]
        Item2 = Item
        Number2 = 0

        for Index, Value3 in ipairs( Create ) do
            local Magnitude4 = ( Value3 - Item ).Magnitude

            if Number2 < Magnitude4 then
                Item2 = Value3
                Number2 = Magnitude4
            end
        end

        local Item3, Number
        Item3 = Item2
        Number = 0

        for Index2, Value5 in ipairs( Create ) do
            local Magnitude3 = ( Value5 - Item2 ).Magnitude

            if Number < Magnitude3 then
                Item3 = Value5
                Number = Magnitude3
            end
        end

        local Item4 = ( Item2 + Item3 ) * 0.5
        local Magnitude = ( Item2 - Item3 ).Magnitude * 0.5

        for Index3, Value7 in ipairs( Create ) do
            local Magnitude2 = ( Value7 - Item4 ).Magnitude

            if Magnitude < Magnitude2 then
                Item4 = Item4 + ( Magnitude2 - Magnitude ) * 0.5 * ( Value7 - Item4 ).Unit
                Magnitude = ( Magnitude2 + Magnitude ) * 0.5
            end
        end

        return Item4, Magnitude
    end,
    sanitizeAngle = function( Amount )
        return ( Amount + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793
    end,
    Round = function( Argument1, Amount )
        local Result = 10 ^ Amount
        return math.floor( Argument1 * Result + 0.5 ) / Result
    end,
    IsFinite = function( Amount )
        local Flag

        if Amount == Amount then
            if Amount == math.huge then
                Flag = false
            elseif Amount == -math.huge then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end

        return Flag
    end
}
function Table.IsFiniteVector3( Argument1 )
    local IsFinite3
    local IsFinite = Table.IsFinite( Argument1.X )

    if IsFinite then
        local IsFinite2 = Table.IsFinite( Argument1.Y )

        if IsFinite2 then
            IsFinite3 = Table.IsFinite( Argument1.Z )
        else
            IsFinite3 = IsFinite2
        end
    else
        IsFinite3 = IsFinite
    end

    return IsFinite3
end
function Table.GetAngleBetweenXZVectors( Argument1, Argument2 )
    local X = Argument2.X * Argument1.Z - Argument2.Z * Argument1.X
    return ( math.atan2( X, Argument2.X * Argument1.X + Argument2.Z * Argument1.Z ) )
end
function Table.RotateVectorByAngleAndRound( Argument1, Argument2, Argument3 )
    if Argument1.Magnitude > 0 then
        local Unit = Argument1.Unit
        local Z = Unit.Z
        local Atan2 = math.atan2( Z, Unit.X )
        local Z2 = Unit.Z
        return math.floor( ( math.atan2( Z2, Unit.X ) + Argument2 ) / Argument3 + 0.5 ) * Argument3 - Atan2
    end
    return 0
end

local function SCurveTranform( Argument1 )
    local Clamp = math.clamp( Argument1, -1, 1 )

    if Clamp >= 0 then
        return Clamp * 0.35 / ( 0.35 - Clamp + 1 )
    end
    return -( -Clamp * 0.8 / ( Clamp + 0.8 + 1 ) )
end

local function ToSCurveSpace( Argument1 )
    return ( math.abs( Argument1 ) * 2 - 1 ) * 1.1 - 0.1
end

local function FromSCurveSpace( Amount )
    return Amount / 2 + 0.5
end

function Table.GamepadLinearToCurve( Argument1 )
    local Number

    local function OnAxis( Amount )
        local Number = if Amount < 0 then -1 else 1
        local Clamp2
        local Clamp = math.clamp( ( math.abs( ( math.abs( Amount ) ) ) * 2 - 1 ) * 1.1 - 0.1, -1, 1 )

        if Clamp >= 0 then
            Clamp2 = Clamp * 0.35 / ( 0.35 - Clamp + 1 )
        else
            Clamp2 = -( -Clamp * 0.8 / ( Clamp + 0.8 + 1 ) )
        end

        return ( math.clamp( ( Clamp2 / 2 + 0.5 ) * Number, -1, 1 ) )
    end

    local X = Argument1.X
    Number = if X < 0 then -1 else 1
    local Clamp2
    local Clamp = math.clamp( ( math.abs( ( math.abs( X ) ) ) * 2 - 1 ) * 1.1 - 0.1, -1, 1 )

    if Clamp >= 0 then
        Clamp2 = Clamp * 0.35 / ( 0.35 - Clamp + 1 )
    else
        Clamp2 = -( -Clamp * 0.8 / ( Clamp + 0.8 + 1 ) )
    end

    local Number2
    local Clamp3 = math.clamp( ( Clamp2 / 2 + 0.5 ) * Number, -1, 1 )
    local Y = Argument1.Y
    Number2 = if Y < 0 then -1 else 1
    local Clamp5
    local Clamp4 = math.clamp( ( math.abs( ( math.abs( Y ) ) ) * 2 - 1 ) * 1.1 - 0.1, -1, 1 )

    if Clamp4 >= 0 then
        Clamp5 = Clamp4 * 0.35 / ( 0.35 - Clamp4 + 1 )
    else
        Clamp5 = -( -Clamp4 * 0.8 / ( Clamp4 + 0.8 + 1 ) )
    end

    return Vector2.new( Clamp3, ( math.clamp( ( Clamp5 / 2 + 0.5 ) * Number2, -1, 1 ) ) )
end
function Table.ConvertCameraModeEnumToStandard( Argument1 )
    if Argument1 == Enum.TouchCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Follow
    end
    if Argument1 == Enum.ComputerCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Classic
    end
    if Argument1 == Enum.TouchCameraMovementMode.Classic or Argument1 == Enum.DevTouchCameraMovementMode.Classic or Argument1 == Enum.DevComputerCameraMovementMode.Classic or Argument1 == Enum.ComputerCameraMovementMode.Classic then
        return Enum.ComputerCameraMovementMode.Classic
    end
    if Argument1 == Enum.TouchCameraMovementMode.Follow or Argument1 == Enum.DevTouchCameraMovementMode.Follow or Argument1 == Enum.DevComputerCameraMovementMode.Follow or Argument1 == Enum.ComputerCameraMovementMode.Follow then
        return Enum.ComputerCameraMovementMode.Follow
    end
    if Argument1 == Enum.TouchCameraMovementMode.Orbital or Argument1 == Enum.DevTouchCameraMovementMode.Orbital or Argument1 == Enum.DevComputerCameraMovementMode.Orbital or Argument1 == Enum.ComputerCameraMovementMode.Orbital then
        return Enum.ComputerCameraMovementMode.Orbital
    end
    if Argument1 == Enum.ComputerCameraMovementMode.CameraToggle or Argument1 == Enum.DevComputerCameraMovementMode.CameraToggle then
        return Enum.ComputerCameraMovementMode.CameraToggle
    end
    if Argument1 == Enum.DevTouchCameraMovementMode.UserChoice or Argument1 == Enum.DevComputerCameraMovementMode.UserChoice then
        return Enum.DevComputerCameraMovementMode.UserChoice
    end
    return Enum.ComputerCameraMovementMode.Classic
end

local function GetMouse()
    local LocalPlayer2
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer then
        LocalPlayer2 = LocalPlayer
    else
        Players:GetPropertyChangedSignal( "LocalPlayer" ):Wait( )
        LocalPlayer2 = Players.LocalPlayer
    end

    assert( LocalPlayer2 )
    return LocalPlayer2:GetMouse( )
end

local Text = ""
local Value1 = nil
function Table.setMouseIconOverride( Icon )
    local LocalPlayer2
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer then
        LocalPlayer2 = LocalPlayer
    else
        Players:GetPropertyChangedSignal( "LocalPlayer" ):Wait( )
        LocalPlayer2 = Players.LocalPlayer
    end

    assert( LocalPlayer2 )
    local Mouse = LocalPlayer2:GetMouse( )

    if Mouse.Icon ~= Value1 then
        Text = Mouse.Icon
    end

    Mouse.Icon = Icon
    Value1 = Icon
end
function Table.restoreMouseIcon()
    local LocalPlayer2
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer then
        LocalPlayer2 = LocalPlayer
    else
        Players:GetPropertyChangedSignal( "LocalPlayer" ):Wait( )
        LocalPlayer2 = Players.LocalPlayer
    end

    assert( LocalPlayer2 )
    local Mouse = LocalPlayer2:GetMouse( )

    if Mouse.Icon == Value1 then
        Mouse.Icon = Text
    end

    Value1 = nil
end
local Default = Enum.MouseBehavior.Default
local Value2 = nil
function Table.setMouseBehaviorOverride( MouseBehavior )
    if UserInputService.MouseBehavior ~= Value2 then
        Default = UserInputService.MouseBehavior
    end

    UserInputService.MouseBehavior = MouseBehavior
    Value2 = MouseBehavior
end
function Table.restoreMouseBehavior()
    if UserInputService.MouseBehavior == Value2 then
        UserInputService.MouseBehavior = Default
    end

    Value2 = nil
end
local MovementRelative = Enum.RotationType.MovementRelative
local Value3 = nil
function Table.setRotationTypeOverride( RotationType )
    if UserGameSettings.RotationType ~= Value3 then
        MovementRelative = UserGameSettings.RotationType
    end

    UserGameSettings.RotationType = RotationType
    Value3 = RotationType
end
function Table.restoreRotationType()
    if UserGameSettings.RotationType == Value3 then
        UserGameSettings.RotationType = MovementRelative
    end

    Value3 = nil
end
return Table
