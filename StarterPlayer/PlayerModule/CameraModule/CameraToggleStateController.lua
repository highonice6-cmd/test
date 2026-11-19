-- StarterPlayer.PlayerModule.CameraModule.CameraToggleStateController
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CameraInput = require( script.Parent:WaitForChild( "CameraInput" ) )
local CameraUI = require( script.Parent:WaitForChild( "CameraUI" ) )
local CameraUtils = require( script.Parent:WaitForChild( "CameraUtils" ) )
local Flag = false
local Tick = tick( )
local Flag2 = false
local Flag3 = false
local Flag4 = false
CameraUI.setCameraModeToastEnabled( false )

local function Callback( Argument1 )
    local TogglePan = CameraInput.getTogglePan( )

    if Argument1 and TogglePan ~= Flag then
        Flag2 = true
    end
    if Flag ~= TogglePan or tick( ) - Tick > 3 then
        local TogglePan2

        if TogglePan then
            if tick( ) - Tick < 3 then
                TogglePan2 = true
            else
                TogglePan2 = false
            end
        else
            TogglePan2 = TogglePan
        end

        CameraUI.setCameraModeToastOpen( TogglePan2 )

        if TogglePan then
            Flag2 = false
        end

        Tick = tick( )
        Flag = TogglePan
    end
    if Argument1 ~= Flag4 then
        if Argument1 then
            Flag3 = CameraInput.getTogglePan( )
            CameraInput.setTogglePan( true )
        elseif not Flag2 then
            CameraInput.setTogglePan( Flag3 )
        end
    end
    if Argument1 then
        if CameraInput.getTogglePan( ) then
            CameraUtils.setMouseIconOverride( "rbxasset://textures/Cursors/CrossMouseIcon.png" )
            CameraUtils.setMouseBehaviorOverride( Enum.MouseBehavior.LockCenter )
            CameraUtils.setRotationTypeOverride( Enum.RotationType.CameraRelative )
        else
            CameraUtils.restoreMouseIcon( )
            CameraUtils.restoreMouseBehavior( )
            CameraUtils.setRotationTypeOverride( Enum.RotationType.CameraRelative )
        end
    elseif CameraInput.getTogglePan( ) then
        CameraUtils.setMouseIconOverride( "rbxasset://textures/Cursors/CrossMouseIcon.png" )
        CameraUtils.setMouseBehaviorOverride( Enum.MouseBehavior.LockCenter )
        CameraUtils.setRotationTypeOverride( Enum.RotationType.MovementRelative )
    elseif CameraInput.getHoldPan( ) then
        CameraUtils.restoreMouseIcon( )
        CameraUtils.setMouseBehaviorOverride( Enum.MouseBehavior.LockCurrentPosition )
        CameraUtils.setRotationTypeOverride( Enum.RotationType.MovementRelative )
    else
        CameraUtils.restoreMouseIcon( )
        CameraUtils.restoreMouseBehavior( )
        CameraUtils.restoreRotationType( )
    end

    Flag4 = Argument1
end

return Callback
