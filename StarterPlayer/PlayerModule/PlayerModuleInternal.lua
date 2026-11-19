-- StarterPlayer.PlayerModule.PlayerModuleInternal
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local CommonUtils = require( script.Parent:WaitForChild( "CommonUtils" ) )
require( script.Parent.Types )
local Get = CommonUtils.get( "CharacterUtil" )
local Get2 = CommonUtils.get( "ConnectionUtil" )
local Get3 = CommonUtils.get( "EventBus" )
local UserFlag = CommonUtils.get( "FlagUtil" ).getUserFlag( "UserPlayerModuleEngineAPI" )
local Parent = require( script.Parent )
local CameraModule = require( script.Parent:WaitForChild( "CameraModule" ) )
local ControlModule = require( script.Parent:WaitForChild( "ControlModule" ) )
local EngineInterface = require( script.Parent:WaitForChild( "EngineInterface" ) )
local InputSampler = require( script.Parent:WaitForChild( "InputSampler" ) )
local ServerAuthority = require( script.Parent:WaitForChild( "ServerAuthority" ) )
local Table = {
    BIND_TO_SIMULATION = "BIND_TO_SIMULATION",
    RENDERSTEPPED_INPUT = "PLAYERMODULE_RENDERSTEPPED_INPUT",
    RENDERSTEPPED_CAMERA = "PLAYERMODULE_RENDERSTEPPED_CAMERA",
    ONLOCALPLAYER = "ONLOCALPLAYER"
}
local __index = { }
__index.__index = __index
function __index.new()
    return ( setmetatable( {
        data = {
            playerModule = Parent,
            controlModule = {
                isJumping = false,
                moveVector = Vector2.new( ),
                worldMoveVector = Vector3.new( ),
                actions = { },
                enabled = true
            },
            engineInterface = {
                player = nil,
                character = nil,
                humanoid = nil,
                characterChanged = false
            },
            connectionUtil = Get2.new( ),
            eventBus = Get3.new( ),
            isServerAuthority = false
        },
        inputSampler = InputSampler.new( )
    }, __index ) )
end
function __index.start( Argument1 )
    local ConnectionUtil = Argument1.data.connectionUtil
    ConnectionUtil:trackConnection( "ONLOCALPLAYER", Get.onLocalPlayer( function( Player )
        if UserFlag then
            EngineInterface.update( Argument1.data )
            ServerAuthority.initialize( Argument1.data )
            ControlModule:initialize( Argument1.data )
            RunService:BindToRenderStep( "PLAYERMODULE_RENDERSTEPPED_INPUT", Enum.RenderPriority.Input.Value, function( Argument1Inner )
                EngineInterface.update( Argument1.data )
                ControlModule:Update( Argument1.data, Argument1Inner )
            end )
            RunService:BindToRenderStep( "PLAYERMODULE_RENDERSTEPPED_CAMERA", Enum.RenderPriority.Camera.Value, function( Argument1Inner )
                CameraModule:Update( Argument1.data, Argument1Inner )
                Argument1.inputSampler:Update( Argument1.data )
                EngineInterface.cleanDirty( Argument1.data )
            end )
            return
        end
        Argument1.data.engineInterface.player = Player
        ServerAuthority.initialize( Argument1.data )
        ControlModule:initialize( Argument1.data )
        RunService:BindToRenderStep( "PLAYERMODULE_RENDERSTEPPED_INPUT", Enum.RenderPriority.Input.Value, function( Argument1Inner )
            local EngineInterface = Argument1.data.engineInterface
            EngineInterface.character = Get.getCharacter( )

            if Argument1.data.engineInterface.character then
                ControlModule:Update( Argument1.data, Argument1Inner )
                return
            end
            return
        end )
        Argument1.data.connectionUtil:trackBoundFunction( "PLAYERMODULE_RENDERSTEPPED_INPUT", function()
            RunService:UnbindFromRenderStep( "PLAYERMODULE_RENDERSTEPPED_INPUT" )
        end )
        RunService:BindToRenderStep( "PLAYERMODULE_RENDERSTEPPED_CAMERA", Enum.RenderPriority.Camera.Value, function( Argument1Inner )
            CameraModule:Update( Argument1.data, Argument1Inner )
            Argument1.inputSampler:Update( Argument1.data )
        end )
        Argument1.data.connectionUtil:trackBoundFunction( "PLAYERMODULE_RENDERSTEPPED_CAMERA", function()
            RunService:UnbindFromRenderStep( "PLAYERMODULE_RENDERSTEPPED_CAMERA" )
        end )
        return
    end ) )
end

if not UserFlag then
    function __index.stop( Argument1 )
        Argument1.data.connectionUtil:disconnectAll( )
    end
end

return __index
