-- StarterPlayer.PlayerModule.ControlModule.InputSlots
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag4
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local StarterPlayer = game:GetService( "StarterPlayer" )
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
UserSettings( ):GetService( "UserGameSettings" )
local UserInputService = game:GetService( "UserInputService" )
local InputReplication = require( script.Parent:WaitForChild( "InputReplication" ) )
local Get2 = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) ).get( Players.LocalPlayer )
local UserFlag = Get.getUserFlag( "UserPlayerScriptsPlayerControlState2" )
UserFlag4 = if UserFlag then UserFlag else Get.getUserFlag( "UserPlayerScriptsPlayerControlState2GA" )
local Text
local UserFlag2 = Get.getUserFlag( "UserAbilitiesUserInterfaceB" )
local UserFlag3 = Get.getUserFlag( "UserPSUseBindToAnimation" )
Text = not UserFlag2 and "PlayerControlState" or "ControlState"
local __index = { }
__index.__index = __index
local Table = { }
local Table2 = { }
local Table3 = { }
local Number = 0
local Table4 = { }
local Table5 = { }
local Table6 = { }
local BindableEvent = Instance.new( "BindableEvent" )
local Number2 = 0
local BindableEvent2 = Instance.new( "BindableEvent" )

local function Shallow_equal( List, List2 )
    if List == List2 then
        return true
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        if List2[ Key ] ~= Value then
            return false
        end
    end

    local Value2 = nil

    for Value3 in List2, nil, nil do
        if List[ Value3 ] == nil then
            return false
        end
    end

    return true
end

local function FindInSparseTable( List, Argument2 )
    local Value1 = nil

    for Key, Value in List, nil, nil do
        if Value == Argument2 then
            return Key
        end
    end

    return nil
end

local Table7 = { "ButtonAssetId", "ButtonPressedAssetId", "ButtonInvalidAssetId" }

local function UpdateAbilityActionMetadata()
    local I = 1

    for I = 1, 11 do
        local Entry = Table4[ I ]

        if Entry then
            local Flag
            local Entry2 = Table[ I ]

            if Entry2 == nil then
                Flag = false
            elseif Entry2 == "" then
                Flag = false
            else
                Flag = true
            end

            local Entry3 = not Flag and "" or Entry2
            local AbilityConfig

            if Flag then
                AbilityConfig = Get2:GetAbilityConfig( Entry2 )
            else
                AbilityConfig = nil
            end

            local function UpdateAction( Player )
                local Value1
                Player.Enabled = Flag
                Player.DisplayName = Entry3
                Value1 = nil

                for Key, Value in Table7, nil, nil do
                    local Entry

                    if AbilityConfig then
                        Entry = AbilityConfig[ Value ]
                    else
                        Entry = nil
                    end

                    local Entry2 = type( Entry ) ~= "string" and "" or Entry
                    Player:SetAttribute( Value, Entry2 )
                end
            end

            UpdateAction( Entry )
            local Entry4 = Table5[ I ]

            if Entry4 and Entry4 ~= Entry then
                UpdateAction( Entry4 )
            end
        end
    end
end

function __index.GetNumAbilitySlots()
    return 11
end
function __index.GetNumOverflowSlots()
    return 3
end
function __index.getOverflowScrollIndex()
    return Number2
end
function __index.setOverflowScrollIndex( Index )
    Number2 = math.max( 0, ( math.min( #Table2 - 3, Index ) ) )

    if Number2 ~= Number2 then
        BindableEvent2:Fire( )
    end
end
function __index.getScrollIndexChangedEvent()
    return BindableEvent2.Event
end
function __index.setupSlotActions( Argument1, Argument2, Argument3 )
    local function GetAbilityAction( Text )
        if not Text then
            return nil
        end

        local InputContexts

        if not UserFlag4 or Argument2 then
            InputContexts = Argument1:FindFirstChild( "InputContexts" )
        else
            InputContexts = script.Parent.Parent:FindFirstChild( "InputContexts" )
        end
        if not InputContexts then
            return nil
        end

        local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

        if CharacterContext then
            return ( CharacterContext:FindFirstChild( Text .. "Action" ) )
        end
        return nil
    end

    if not UserFlag4 then
        if UserFlag3 then
            RunService:BindToAnimation( function( Argument1Inner )
                if Get2:isEnabled( ) then
                    InputReplication.FireCustomInputs( Argument1 )
                    InputReplication.SendInputToCCLCharacter( Argument1 )
                end
            end, Enum.StepFrequency.Hz60 )
        else
            RunService:BindToSimulation( function( Argument1Inner )
                if Get2:isEnabled( ) then
                    InputReplication.FireCustomInputs( Argument1 )
                    InputReplication.SendInputToCCLCharacter( Argument1 )
                end
            end, Enum.StepFrequency.Hz60 )
        end
    end

    local TableInner = { }

    local function UpdateSlotMap()
        -- Could not structure function #13
    end

    Get2:GetAbilitiesChangedSignal( ):Connect( UpdateSlotMap )
    UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( UpdateSlotMap )
    UpdateSlotMap( )

    local function UpdateAbilityInPCS( Argument1, Argument2, Argument3 )
        local Character = Argument1.Character

        if not Character then
            return
        end

        local FoundChildOfClass

        if UserFlag2 then
            FoundChildOfClass = Character:FindFirstChildOfClass( Text )
        else
            FoundChildOfClass = Character:FindFirstChild( Text )
        end
        if FoundChildOfClass then
            FoundChildOfClass:UpdateFields( { [ Argument2 ] = Argument3 } )
            return
        end
        return
    end

    local Table2Inner = { }
    local Table3Inner = { }

    local function ResolveHeldAbility( List, AbilityName, Argument3, Argument4 )
        if Argument4 then
            List[ AbilityName ] = Argument3
            return Argument3
        end

        local Entry = List[ AbilityName ]
        List[ AbilityName ] = nil

        if Entry == nil then
            return Argument3
        end
        return Entry
    end

    local Table4Inner = { }
    local NumberInner = 0

    local function ResolveAndWireActions()
        local Value1
        NumberInner = NumberInner + 1
        Value1 = nil

        for Key, Value in Table4Inner, nil, nil do
            Value:Disconnect( )
        end

        local InputContexts
        table.clear( Table4Inner )

        if not UserFlag4 or Argument2 then
            InputContexts = Argument1:WaitForChild( "InputContexts", math.huge )
        else
            InputContexts = script.Parent.Parent:WaitForChild( "InputContexts", math.huge )
        end

        local CharacterContext = InputContexts:WaitForChild( "CharacterContext" )

        if NumberInner ~= NumberInner then
            return
        end

        local CharacterContext2
        local InputContexts2 = script.Parent.Parent:FindFirstChild( "InputContexts" )

        if InputContexts2 then
            CharacterContext2 = InputContexts2:FindFirstChild( "CharacterContext" )
        else
            CharacterContext2 = InputContexts2
        end

        local I = 1

        for I = 1, 11 do
            local Child = CharacterContext:WaitForChild( "AbilityAction" .. tostring( I ) )

            if NumberInner ~= NumberInner then
                return
            end

            local FoundChild
            Table4[ I ] = Child

            if CharacterContext2 then
                FoundChild = CharacterContext2:FindFirstChild( "AbilityAction" .. tostring( I ) )
            else
                FoundChild = nil
            end

            Table5[ I ] = FoundChild
            table.insert( Table4Inner, Child.StateChanged:Connect( function( Argument1Inner )
                local Entry3
                local Entry = Table[ I ]

                if Argument1Inner then
                    Table2Inner[ I ] = Entry
                    Entry3 = Entry
                else
                    local Entry2 = Table2Inner[ I ]
                    Table2Inner[ I ] = nil

                    if Entry2 == nil then
                        Entry3 = Entry
                    else
                        Entry3 = Entry2
                    end
                end
                if UserFlag4 then
                    if Entry3 ~= nil and Entry3 ~= "" then
                        UpdateAbilityInPCS( Argument1, Entry3, Argument1Inner )
                        return
                    end
                else
                    local AbilityAction = GetAbilityAction( Entry3 )

                    if AbilityAction and AbilityAction:FindFirstChild( "ScriptableBinding" ) then
                        AbilityAction:FindFirstChild( "ScriptableBinding" ):Fire( Argument1Inner )
                    end
                end
            end ) )
        end

        UpdateAbilityActionMetadata( )

        if UserFlag4 then
            local I2 = 1

            for I2 = 1, 3 do
                local Child2 = CharacterContext:WaitForChild( "OverflowAction" .. tostring( I2 ) )

                if NumberInner ~= NumberInner then
                    return
                end

                Table6[ I2 ] = Child2
                table.insert( Table4Inner, Child2.StateChanged:Connect( function( Argument1Inner )
                    local Entry3
                    local Entry = Table2[ I2 + Number2 ]

                    if Argument1Inner then
                        Table3Inner[ I2 ] = Entry
                        Entry3 = Entry
                    else
                        local Entry2 = Table3Inner[ I2 ]
                        Table3Inner[ I2 ] = nil

                        if Entry2 == nil then
                            Entry3 = Entry
                        else
                            Entry3 = Entry2
                        end
                    end
                    if Entry3 ~= nil and Entry3 ~= "" then
                        UpdateAbilityInPCS( Argument1, Entry3, Argument1Inner )
                    end
                end ) )
            end
        end

        BindableEvent:Fire( )
    end

    task.spawn( ResolveAndWireActions )

    if Argument3 then
        Argument3:subscribe( "SERVER_AUTHORITY_CHANGED" ):Connect( function( Argument1 )
            if Argument1 == Argument2 then
                return
            end
            Argument2 = Argument1
            task.spawn( ResolveAndWireActions )
            return
        end )
    end
end
function __index.GetSlotMapChangedSignal()
    return BindableEvent.Event
end
function __index.GetSlotMap()
    return Table
end
function __index.GetAbilitiesInOverflow()
    return Table2
end
function __index.GetActionInSlot( Key )
    return Table4[ Key ]
end
function __index.GetOverflowAction( Key )
    return Table6[ Key ]
end
return __index

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1[ Key ] < Upvalue1[ Key2 ] and true or false
return Flag
]]
