-- StarterPlayer.PlayerModule.ControlModule.ActionController
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    SERVER_AUTHORITY_CHANGED = "SERVER_AUTHORITY_CHANGED",
    ACTIONS_RELOADED = "ACTIONS_RELOADED"
}
local __index = { }
__index.__index = __index
function __index.new()
    local Self = setmetatable( { }, __index )
    Self.enabled = true
    return Self
end
function __index.initializeActions( Actions )
    local ConnectionUtil = Actions.connectionUtil
    ConnectionUtil:trackConnection( "SERVER_AUTHORITY_CHANGED", Actions.eventBus:subscribe( "SERVER_AUTHORITY_CHANGED" ):Connect( function()
        Actions.controlModule.actions = { }
    end ) )

    if Actions.controlModule.actions.MoveAction and Actions.controlModule.actions.JumpAction then
        return
    end
    if Actions.engineInterface.player then
        pcall( function()
            local InputContexts = script.Parent.Parent.InputContexts

            if Actions.isServerAuthority then
                InputContexts = Actions.engineInterface.player.InputContexts
            end

            local CharacterContext = InputContexts.CharacterContext
            local ControlModule = Actions.controlModule
            ControlModule.actions = {
                MoveAction = CharacterContext.MoveAction,
                JumpAction = CharacterContext.JumpAction
            }
            Actions.eventBus:publish( "ACTIONS_RELOADED" )
        end )
        return
    end
    return
end
function __index.update( Argument1 )
    if not Argument1.controlModule.actions.MoveAction or not Argument1.controlModule.actions.JumpAction then
        return
    end
    local ControlModule = Argument1.playerModule.ControlModule
    local MoveAction = Argument1.controlModule.actions.MoveAction
    MoveAction.Enabled = ControlModule.Enabled
    local JumpAction = Argument1.controlModule.actions.JumpAction
    JumpAction.Enabled = ControlModule.Enabled
    local ControlModule2 = Argument1.controlModule
    ControlModule2.moveVector = Argument1.controlModule.actions.MoveAction:GetState( )
    local ControlModule3 = Argument1.controlModule
    ControlModule3.isJumping = Argument1.controlModule.actions.JumpAction:GetState( )
    return
end
function __index.Enable( Argument1, Argument2 )
end
return __index
