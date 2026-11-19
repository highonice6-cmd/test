-- StarterPlayer.PlayerModule.ControlModule.AvatarAbilitiesInterface
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag6
local Players = game:GetService( "Players" )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationD" )
UserFlag6 = if UserFlag then UserFlag else Get.getUserFlag( "UserPlayerScriptsCCLIntegrationDGA" )
local UserFlag7
local UserFlag2 = Get.getUserFlag( "UserPlayerScriptsPlayerControlState2" )
UserFlag7 = if UserFlag2 then UserFlag2 else Get.getUserFlag( "UserPlayerScriptsPlayerControlState2GA" )
local Callback
local UserFlag3 = Get.getUserFlag( "UserPlayerScriptsTaskDeferSimulation" )
local UserFlag4 = Get.getUserFlag( "UserPlayerScriptsImportWaitForAbilitiesFolder" )
local UserFlag5 = Get.getUserFlag( "UserAbilitiesUserInterfaceD" )

if UserFlag4 then
    Callback = nil
else
    local function WaitForChildren( Self, List, Duration )
        if #List == 0 then
            return nil
        end

        local Value1 = nil

        for Key, Value in List, nil, nil do
            local FoundChild = Self:FindFirstChild( Value )

            if FoundChild then
                return FoundChild
            end
        end

        local Delay
        local Running = coroutine.running( )
        local Value2 = nil
        local Flag = false

        local function Settle( Argument1 )
            if Flag then
                return
            end
            Flag = true
            Value2 = Argument1
            task.spawn( Running )
            return
        end

        local Connect = Self.ChildAdded:Connect( function( Argument1 )
            if table.find( List, Argument1.Name ) then
                if Flag then
                    return
                end

                Flag = true
                Value2 = Argument1
                task.spawn( Running )
            end
        end )

        if Duration then
            Delay = task.delay( Duration, function()
                if Flag then
                    return
                end
                Flag = true
                Value2 = nil
                task.spawn( Running )
                return
            end )
        else
            Delay = nil
        end

        coroutine.yield( )
        Connect:Disconnect( )

        if Delay and coroutine.status( Delay ) == "suspended" then
            task.cancel( Delay )
        end

        return Value2
    end

    Callback = function( Self, Argument2 )
        if not Self then
            return nil
        end

        local Time

        if Argument2 then
            Time = time( ) + Argument2
        else
            Time = nil
        end

        local Max

        local function GetRemainingTime()
            if Time then
                return ( math.max( Time - time( ), 0 ) )
            end
            return nil
        end

        local Table = { "AbilityManagerActor", "Abilities" }

        if Time then
            Max = math.max( Time - time( ), 0 )
        else
            Max = nil
        end

        local WaitForChildren2 = WaitForChildren( Self, Table, Max )

        if not WaitForChildren2 then
            return nil
        end
        if WaitForChildren2.Name == "Abilities" then
            if WaitForChildren2:IsA( "Folder" ) then
                return WaitForChildren2
            end
            return nil
        else
            local Max2

            if Time then
                Max2 = math.max( Time - time( ), 0 )
            else
                Max2 = nil
            end

            local Abilities

            if Max2 then
                Abilities = WaitForChildren2:WaitForChild( "Abilities", Max2 )
            else
                Abilities = WaitForChildren2:WaitForChild( "Abilities" )
            end
            if not Abilities or not Abilities:IsA( "Folder" ) then
                return nil
            end
            return Abilities
        end
    end
end
if not UserFlag6 then
    local Players2 = game:GetService( "Players" )
    local Value2 = nil
    local Value3 = nil
    local BindableEvent = Instance.new( "BindableEvent" )
    local Value4 = nil
    local Flag = false

    local function CharacterAdded( Object )
        Value2 = nil
        Value3 = nil

        if Value4 then
            Value4:Disconnect( )
            Value4 = nil
        end
        if Object then
            Value2 = Object:FindFirstChild( "AbilityManagerActor" )
            Value3 = Object:FindFirstChildOfClass( "Humanoid" )

            while not Value3 do
                Object.ChildAdded:wait( )
                Value3 = Object:FindFirstChildOfClass( "Humanoid" )
            end

            BindableEvent:Fire( )
            Value4 = Value3:GetPropertyChangedSignal( "EvaluateStateMachine" ):Connect( function()
                BindableEvent:Fire( )
            end )
        end
    end

    local function LazyInit()
        if Flag then
            return
        end

        Flag = true
        local LocalPlayer = Players2.LocalPlayer

        if LocalPlayer then
            LocalPlayer.characterAdded:Connect( CharacterAdded )

            if LocalPlayer.Character then
                CharacterAdded( LocalPlayer.Character )
            end
        end
    end

    local Table2 = {
        isEnabled = function()
            if not Flag then
                Flag = true
                local LocalPlayer = Players2.LocalPlayer

                if LocalPlayer then
                    LocalPlayer.characterAdded:Connect( CharacterAdded )

                    if LocalPlayer.Character then
                        CharacterAdded( LocalPlayer.Character )
                    end
                end
            end

            local FlagInner

            if Value2 == nil then
                FlagInner = false
            elseif Value3 then
                FlagInner = not Value3.EvaluateStateMachine
            else
                FlagInner = Value3
            end

            return FlagInner
        end,
        GetEnabledChangedSignal = function()
            if not Flag then
                Flag = true
                local LocalPlayer = Players2.LocalPlayer

                if LocalPlayer then
                    LocalPlayer.characterAdded:Connect( CharacterAdded )

                    if LocalPlayer.Character then
                        CharacterAdded( LocalPlayer.Character )
                    end
                end
            end

            return BindableEvent.Event
        end
    }
    return Table2
end

local __index = { }
__index.__index = __index
local Table = { }
Players.PlayerRemoving:Connect( function( Player )
    wait( 1 )
    local Entry = Table[ Player.UserId ]

    if Entry then
        Entry:destroy( )
        Table[ Player.UserId ] = nil
    end
end )

local function CreateAbilitiesByInputNameTable( WaitForAbilitiesFolder )
    local Table = { }

    for Key, Value in WaitForAbilitiesFolder:GetChildren( ) do
        if Value:IsA( "Configuration" ) and Value:GetAttribute( "InputName" ) then
            Table[ Value:GetAttribute( "InputName" ) ] = Value
        end
    end

    return Table
end

local function NotifyAbilitiesChanged( WaitForAbilitiesFolder, Argument2 )
    local Connect = WaitForAbilitiesFolder.ChildAdded:Connect( function( Object )
        if Object:IsA( "Configuration" ) then
            Argument2( Object, "added" )
        end
    end )
    local Connect2 = WaitForAbilitiesFolder.ChildRemoved:Connect( function( Object )
        if Object:IsA( "Configuration" ) then
            Argument2( Object, "removed" )
        end
    end )
    return function()
        Connect:Disconnect( )
        Connect2:Disconnect( )
    end
end

function __index._new( _player )
    local Self = setmetatable( { }, __index )
    Self._player = _player
    Self._data = { }
    Self._character = nil
    Self._humanoid = nil
    Self._enabledChangedEvent = Instance.new( "BindableEvent" )
    Self._abilitiesChangedEvent = Instance.new( "BindableEvent" )
    Self._evaluateStateMachineChangedConnection = nil
    Self._abilityChangedEvents = { }
    Self._abilityChangedConnections = { }
    Self._abilitiesByInputName = { }
    Self._disconnectAbilitiesChanged = nil

    if not UserFlag7 or UserFlag3 then
        Self._characterAddedConnection = _player.CharacterAdded:Connect( function( Argument1 )
            Self:_onCharacterAdded( Argument1 )
        end )
    else
        task.spawn( function()
            Self._characterAddedConnection = _player.CharacterAdded:Connect( function( Argument1 )
                Self:_onCharacterAdded( Argument1 )
            end )
        end )
    end
    if _player.Character then
        Self:_onCharacterAdded( _player.Character )
    end

    return Self
end
local Value1 = nil
function __index._avatarAbilities()
    if not Value1 then
        local AvatarAbilities
        local Packages = game:GetService( "ReplicatedStorage" ):FindFirstChild( "Packages" )

        if Packages then
            AvatarAbilities = Packages:FindFirstChild( "AvatarAbilities" )
        else
            AvatarAbilities = nil
        end

        local AvatarAbilities2

        if AvatarAbilities then
            AvatarAbilities2 = require( AvatarAbilities )
        else
            AvatarAbilities2 = nil
        end

        Value1 = AvatarAbilities2

        if not Value1 then
            Value1 = require( "@rbx/AvatarAbilities" )
        end
    end

    return Value1
end
function __index.get( Player )
    if not Player or Player.UserId == 0 then
        return nil
    end

    local Entry2
    local Entry = Table[ Player.UserId ]

    if Entry then
        Entry2 = Entry
    else
        local _new = __index._new( Player )
        Table[ Player.UserId ] = _new
        Entry2 = _new
    end

    return Entry2
end
function __index._hookUpAbilityChangedEvent( Argument1, EventName, EventName2 )
    local Entry = Argument1._abilitiesByInputName[ EventName ]

    if not Entry then
        return
    end

    local SyncedState = Entry:FindFirstChild( "SyncedState" )

    if not SyncedState then
        return
    end
    if not Argument1._abilityChangedConnections[ EventName2 ] then
        Argument1._abilityChangedConnections[ EventName2 ] = { }
    end
    if Argument1._abilityChangedConnections[ EventName2 ][ EventName ] then
        Argument1._abilityChangedConnections[ EventName2 ][ EventName ]:Disconnect( )
        Argument1._abilityChangedConnections[ EventName2 ][ EventName ] = nil
    end

    local Entry2 = Argument1._abilityChangedConnections[ EventName2 ]
    Entry2[ EventName ] = SyncedState:GetAttributeChangedSignal( EventName2 ):Connect( function()
        Argument1._abilityChangedEvents[ EventName2 ][ EventName ]:Fire( )
    end )
end
function __index._onCharacterAdded( Argument1, _character )
    Argument1._humanoid = nil
    Argument1._character = _character
    Argument1._abilitiesByInputName = { }
    Argument1._data = { }

    if Argument1._disconnectAbilitiesChanged then
        Argument1._disconnectAbilitiesChanged( )
        Argument1._disconnectAbilitiesChanged = nil
    end

    local Value1
    local _abilityChangedConnections = Argument1._abilityChangedConnections
    Value1 = nil

    for Key, Value in _abilityChangedConnections, nil, nil do
        local Value2 = nil

        for Key2, Value3 in Value, nil, nil do
            Value3:Disconnect( )
        end
    end

    Argument1._abilityChangedConnections = { }

    if Argument1._evaluateStateMachineChangedConnection then
        Argument1._evaluateStateMachineChangedConnection:Disconnect( )
        Argument1._evaluateStateMachineChangedConnection = nil
    end
    if Argument1._character then
        local function IsStale()
            local Flag = Argument1._character ~= _character and true or false
            return Flag
        end

        task.spawn( function()
            local WaitForAbilitiesFolder

            if UserFlag4 then
                WaitForAbilitiesFolder = Argument1._avatarAbilities( ).waitForAbilitiesFolder( _character )
            else
                WaitForAbilitiesFolder = Callback( _character )
            end
            if WaitForAbilitiesFolder then
                local Flag = Argument1._character ~= _character and true or false

                if not Flag then
                    Argument1._humanoid = _character:FindFirstChildOfClass( "Humanoid" )

                    while not Argument1._humanoid do
                        local Flag2
                        _character.ChildAdded:Wait( )
                        Flag2 = Argument1._character ~= _character and true or false

                        if Flag2 then
                            return
                        end

                        Argument1._humanoid = _character:FindFirstChildOfClass( "Humanoid" )
                    end
                    if Argument1._evaluateStateMachineChangedConnection then
                        Argument1._evaluateStateMachineChangedConnection:Disconnect( )
                        Argument1._evaluateStateMachineChangedConnection = nil
                    end

                    local function EnabledChanged()
                        if Argument1._disconnectAbilitiesChanged then
                            Argument1._disconnectAbilitiesChanged( )
                            Argument1._disconnectAbilitiesChanged = nil
                        end
                        if Argument1:isEnabled( ) then
                            local Value1
                            Argument1._disconnectAbilitiesChanged = NotifyAbilitiesChanged( WaitForAbilitiesFolder, function( Object, Name )
                                local InputName = Object:GetAttribute( "InputName" )

                                if not InputName then
                                    return
                                end
                                if Name == "added" then
                                    local Value1
                                    Argument1._abilitiesByInputName[ InputName ] = Object
                                    local _abilityChangedEvents = Argument1._abilityChangedEvents
                                    Value1 = nil

                                    for Key, Value in _abilityChangedEvents, nil, nil do
                                        if Value[ InputName ] then
                                            Argument1:_hookUpAbilityChangedEvent( InputName, Key )
                                        end
                                    end
                                elseif Argument1._abilitiesByInputName[ InputName ] == Object then
                                    local Value2
                                    Argument1._abilitiesByInputName[ InputName ] = nil
                                    local _abilityChangedConnections = Argument1._abilityChangedConnections
                                    Value2 = nil

                                    for Key2, Value3 in _abilityChangedConnections, nil, nil do
                                        local Entry = Value3[ InputName ]

                                        if Entry then
                                            Entry:Disconnect( )
                                            Value3[ InputName ] = nil
                                        end
                                    end
                                end

                                Argument1._abilitiesChangedEvent:Fire( )
                            end )
                            Argument1._abilitiesByInputName = CreateAbilitiesByInputNameTable( WaitForAbilitiesFolder )
                            Argument1._abilitiesChangedEvent:Fire( )
                            local _abilityChangedEvents = Argument1._abilityChangedEvents
                            Value1 = nil

                            for Key, Value in _abilityChangedEvents, nil, nil do
                                local Value2 = nil

                                for Key2, Value3 in Value, nil, nil do
                                    Value3:Fire( )
                                    Argument1:_hookUpAbilityChangedEvent( Key2, Key )
                                end
                            end
                        end

                        Argument1._enabledChangedEvent:Fire( )
                    end

                    Argument1._evaluateStateMachineChangedConnection = Argument1._humanoid:GetPropertyChangedSignal( "EvaluateStateMachine" ):Connect( function()
                        EnabledChanged( )
                    end )
                    EnabledChanged( )
                    return
                end
            end
        end )
        return
    end
    return
end
function __index.isEnabled( Argument1 )
    local Flag = if Argument1._humanoid == nil then false else not Argument1._humanoid.EvaluateStateMachine
    return Flag
end
function __index.GetEnabledChangedSignal( Argument1 )
    return Argument1._enabledChangedEvent.Event
end
function __index.SendInput( Self, InputName, Argument3 )
    if not Self:isEnabled( ) then
        return
    end
    if Argument3 ~= Self._data[ InputName ] then
        Self._data[ InputName ] = Argument3
        local SetAbilityManagerCommand = Self._avatarAbilities( ).setAbilityManagerCommand
        SetAbilityManagerCommand( Self._character, InputName, Argument3 )
    end
end
function __index.GetAbilityAttribute( Argument1, Key, Attribute, Argument4 )
    local Entry = Argument1._abilitiesByInputName[ Key ]

    if not Entry then
        return Argument4
    end

    local SyncedState = Entry:FindFirstChild( "SyncedState" )

    if not SyncedState then
        return Argument4
    end

    local Attribute2 = SyncedState:GetAttribute( Attribute )

    if Attribute2 == nil then
        return Argument4
    end
    return Attribute2
end
function __index.GetAbilityAttributeChangedSignal( Self, Key, Key2 )
    if not Self._abilityChangedEvents[ Key2 ] then
        Self._abilityChangedEvents[ Key2 ] = { }
    end
    if Self._abilityChangedEvents[ Key2 ][ Key ] then
        return Self._abilityChangedEvents[ Key2 ][ Key ].Event
    end
    local BindableEvent = Instance.new( "BindableEvent" )
    Self._abilityChangedEvents[ Key2 ][ Key ] = BindableEvent
    Self:_hookUpAbilityChangedEvent( Key, Key2 )
    return BindableEvent.Event
end
function __index.GetAbilityUIState( Argument1, Argument2 )
    return Argument1:GetAbilityAttribute( Argument2, "UIState", nil )
end
function __index.GetAbilityUIStateChangedSignal( Argument1, Argument2 )
    return Argument1:GetAbilityAttributeChangedSignal( Argument2, "UIState" )
end

if not UserFlag5 then
    function __index.GetAbilityActive( Argument1, Argument2 )
        return Argument1:GetAbilityAttribute( Argument2, "Active", false )
    end
    function __index.GetAbilityActiveChangedSignal( Argument1, Argument2 )
        return Argument1:GetAbilityAttributeChangedSignal( Argument2, "Active" )
    end
    function __index.GetAbilityValid( Argument1, Argument2 )
        return Argument1:GetAbilityAttribute( Argument2, "IsValid", true )
    end
    function __index.GetAbilityValidChangedSignal( Argument1, Argument2 )
        return Argument1:GetAbilityAttributeChangedSignal( Argument2, "IsValid" )
    end
end

function __index.GetAbilities( Argument1 )
    local Value1
    local Table = { }
    local _abilitiesByInputName = Argument1._abilitiesByInputName
    Value1 = nil

    for Value in _abilitiesByInputName, nil, nil do
        table.insert( Table, Value )
    end

    return Table
end
function __index.GetAbilitiesChangedSignal( Argument1 )
    return Argument1._abilitiesChangedEvent.Event
end
function __index.GetAbilityConfig( Argument1, Key )
    local Table = { Slot = -1 }
    local Entry = Argument1._abilitiesByInputName[ Key ]

    if not Entry then
        return Table
    end

    local ActionSlot = Entry:GetAttribute( "ActionSlot" )

    if ActionSlot then
        return {
            Slot = tonumber( ActionSlot ),
            ButtonAssetId = Entry:GetAttribute( "CustomIcon" ),
            ButtonPressedAssetId = Entry:GetAttribute( "CustomIconActive" ),
            ButtonInvalidAssetId = Entry:GetAttribute( "CustomIconInvalid" )
        }
    end
    return Table
end
function __index.destroy( Argument1 )
    if Argument1._characterAddedConnection then
        Argument1._characterAddedConnection:Disconnect( )
        Argument1._characterAddedConnection = nil
    end
    if Argument1._evaluateStateMachineChangedConnection then
        Argument1._evaluateStateMachineChangedConnection:Disconnect( )
        Argument1._evaluateStateMachineChangedConnection = nil
    end
    if Argument1._disconnectAbilitiesChanged then
        Argument1._disconnectAbilitiesChanged( )
        Argument1._disconnectAbilitiesChanged = nil
    end

    local Value1
    local _abilityChangedConnections = Argument1._abilityChangedConnections
    Value1 = nil

    for Key, Value in _abilityChangedConnections, nil, nil do
        local Value2 = nil

        for Key2, Value3 in Value, nil, nil do
            Value3:Disconnect( )
        end
    end

    Argument1._abilityChangedConnections = { }
end
return __index
