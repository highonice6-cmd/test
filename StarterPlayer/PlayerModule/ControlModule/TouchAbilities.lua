-- StarterPlayer.PlayerModule.ControlModule.TouchAbilities
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local CommonUtils = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) )
local Get = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) ).get( Players.LocalPlayer )
local InputSlots = require( script.Parent:WaitForChild( "InputSlots" ) )
local AbilityButton = require( script.Parent:WaitForChild( "AbilityButton" ) )
local UserFlag = CommonUtils.get( "FlagUtil" ).getUserFlag( "UserAbilitiesUserInterfaceA" )
local Table = {
    { small = { 72, 60, 60 }, large = { 92, 112, 112 } },
    { small = { 44, 132, 132 }, large = { 56, 200, 200 } },
    { small = { 44, 132, 16 }, large = { 56, 200, 60 } },
    { small = { 44, 16, 132 }, large = { 56, 60, 200 } },
    { small = { 44, 156, 74 }, large = { 56, 228, 130 } },
    { small = { 44, 74, 156 }, large = { 56, 130, 228 } },
    { small = { 44, 16, 16 }, large = { 56, 60, 60 } }
}
local __index = { }
__index.__index = __index
function __index.new( ParentUIFrame )
    local Self = setmetatable( { }, __index )
    Self.parentUIFrame = ParentUIFrame
    Self.managedButtons = { }
    Self.connections = { }
    Self.created = false
    Self.enabled = false
    Self.enabledChangedEvent = Instance.new( "BindableEvent" )
    return Self
end
function __index.Enable( Self, Enabled )
    if Self.enabled == Enabled then
        return
    end

    Self.enabled = Enabled

    if Enabled and not Self.created then
        Self:Create( )
        Self.created = true
    end

    Self.enabledChangedEvent:Fire( )
end
function __index.Create( Argument1 )
    if Argument1.parentUIFrame then
        local function CreateButtons()
            local Value1
            local ManagedButtons = Argument1.managedButtons
            Value1 = nil

            for Key, Value in ManagedButtons, nil, nil do
                Value:Destroy( )
            end

            Argument1.managedButtons = { }

            if Get:isEnabled( ) then
                local Value2
                local SlotMap = InputSlots.GetSlotMap( )
                Value2 = nil

                for Key2, Value3 in SlotMap, nil, nil do
                    local ActionInSlot = InputSlots.GetActionInSlot( Key2 )

                    if Value3 and ActionInSlot and Key2 <= #Table then
                        if UserFlag or Key2 == 1 then
                            local AbilityConfig = Get:GetAbilityConfig( Value3 )
                            local ManagedButtons2 = Argument1.managedButtons
                            local Create = AbilityButton.create
                            table.insert( ManagedButtons2, Create( Argument1, Value3, AbilityConfig, ActionInSlot, Table[ Key2 ], false ) )
                        end
                    end
                end
            end
        end

        CreateButtons( )
        local Connections = Argument1.connections
        table.insert( Connections, InputSlots.GetSlotMapChangedSignal( ):Connect( CreateButtons ) )
        local Connections2 = Argument1.connections
        table.insert( Connections2, Get:GetEnabledChangedSignal( ):Connect( CreateButtons ) )
        return
    end
    return
end
function __index.Destroy( Argument1 )
    local Value1
    local Connections = Argument1.connections
    Value1 = nil

    for Key, Value in Connections, nil, nil do
        Value:Disconnect( )
    end

    local Value2
    Argument1.connections = { }
    local ManagedButtons = Argument1.managedButtons
    Value2 = nil

    for Key2, Value3 in ManagedButtons, nil, nil do
        Value3:Destroy( )
    end

    Argument1.managedButtons = { }
    Argument1.enabledChangedEvent:Destroy( )
    Argument1.created = false
    Argument1.enabled = false
end
return __index
