-- StarterPlayer.StarterPlayerScripts.PromptTapHoldClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ProximityPromptService = game:GetService( "ProximityPromptService" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local Table = { }
local Table2 = { }
local Table3 = { }

local function Is( Argument1, Argument2 )
    local Flag = math.abs( Argument1 - Argument2 ) < 0.0001 and true or false
    return Flag
end

local function Seated()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Flag

    if Humanoid == nil then
        Flag = false
    elseif Humanoid.SeatPart == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function CanReload()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Flag

    if Humanoid == nil then
        Flag = false
    elseif Humanoid.SeatPart == nil then
        Flag = false
    else
        Flag = true
    end

    local NotFlag2
    local NotFlag = not Flag

    if NotFlag then
        if ClientState.CanReload == nil then
            NotFlag2 = false
        elseif ClientState.CanReload( ) == true then
            NotFlag2 = true
        else
            NotFlag2 = false
        end
    else
        NotFlag2 = NotFlag
    end

    return NotFlag2
end

local function Shares( Argument1, Entry )
    local Reload = Controls.Actions.Reload

    if not Reload then
        return false
    end
    if Entry == Enum.ProximityPromptInputType.Gamepad then
        local Flag

        if Reload.pad == nil then
            Flag = false
        elseif table.find( Reload.pad, Argument1.GamepadKeyCode ) == nil then
            Flag = false
        else
            Flag = true
        end

        return Flag
    end
    if Entry ~= Enum.ProximityPromptInputType.Keyboard then
        return false
    end

    local Flag2

    if Reload.keys == nil then
        Flag2 = false
    elseif table.find( Reload.keys, Argument1.KeyboardKeyCode ) == nil then
        Flag2 = false
    else
        Flag2 = true
    end

    return Flag2
end

local function Fire( Key )
    if not Key.Parent or not Key.Enabled then
        return
    end

    local HoldDuration = Key.HoldDuration
    Key.HoldDuration = 0
    Key:InputHoldBegin( )
    Key:InputHoldEnd( )

    if Table2[ Key ] then
        Key.HoldDuration = HoldDuration
    end
end

local function Unpark( Key )
    local Entry = Table2[ Key ]

    if not Entry then
        return
    end

    local Value1
    Table2[ Key ] = nil
    Table3[ Key ] = nil
    local Conns = Entry.conns
    Value1 = nil

    for Key2, Value in Conns, nil, nil do
        Value:Disconnect( )
    end

    local Flag = math.abs( Key.HoldDuration - 1000 ) < 0.0001 and true or false

    if Flag then
        Key.HoldDuration = Entry.hold
    else
        local Flag2 = math.abs( Key.HoldDuration - 0.01 ) < 0.0001 and true or false

        if Flag2 then
            Key.HoldDuration = Entry.hold
        end
    end
end

local function Park( Key )
    if Table2[ Key ] or Key.HoldDuration > 0 then
        return
    end
    if Key:HasTag( "HoldGauge" ) then
        return
    end
    local Table = { hold = Key.HoldDuration, conns = { } }
    Table2[ Key ] = Table
    Key.HoldDuration = 1000
    local Conns = Table.conns
    table.insert( Conns, Key.PromptButtonHoldBegan:Connect( function()
        local Humanoid
        local Character = LocalPlayer.Character

        if Character then
            Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end

        local Flag

        if Humanoid == nil then
            Flag = false
        elseif Humanoid.SeatPart == nil then
            Flag = false
        else
            Flag = true
        end

        local NotFlag2
        local NotFlag = not Flag

        if NotFlag then
            if ClientState.CanReload == nil then
                NotFlag2 = false
            elseif ClientState.CanReload( ) == true then
                NotFlag2 = true
            else
                NotFlag2 = false
            end
        else
            NotFlag2 = NotFlag
        end
        if NotFlag2 then
            Key.HoldDuration = 1000
            local Table = { reloaded = false }
            Table3[ Key ] = Table
            task.delay( 0.3, function()
                if Table3[ Key ] == Table and Table2[ Key ] then
                    Table.reloaded = true
                    Controls.Press( "Reload", true )
                    Controls.Press( "Reload", false )
                end
            end )
            return
        end
        Table3[ Key ] = nil
        Key.HoldDuration = 0.01
        return
    end ) )
    local Conns2 = Table.conns
    table.insert( Conns2, Key.PromptButtonHoldEnded:Connect( function()
        local Entry = Table3[ Key ]
        Table3[ Key ] = nil

        if Table2[ Key ] then
            local Flag = math.abs( Key.HoldDuration - 0.01 ) < 0.0001 and true or false

            if Flag then
                Key.HoldDuration = 1000
            end
        end
        if Entry and not Entry.reloaded and Key.Parent then
            if not Key.Enabled then
                return
            end

            local HoldDuration = Key.HoldDuration
            Key.HoldDuration = 0
            Key:InputHoldBegin( )
            Key:InputHoldEnd( )

            if Table2[ Key ] then
                Key.HoldDuration = HoldDuration
            end
        end
    end ) )
    local Conns3 = Table.conns
    table.insert( Conns3, Key.Triggered:Connect( function()
        if Table2[ Key ] then
            local Flag = math.abs( Key.HoldDuration - 0.01 ) < 0.0001 and true or false

            if Flag then
                Key.HoldDuration = 1000
            end
        end
    end ) )
    return
end

local function Check( Key2 )
    local Entry = Table[ Key2 ]

    if not Entry or not Shares( Key2, Entry ) then
        Unpark( Key2 )
        return
    end
    task.defer( function()
        if Table[ Key2 ] == Entry and Key2.Parent then
            Park( Key2 )
        end
    end )
    return
end

ProximityPromptService.PromptShown:Connect( function( Key2, Argument2 )
    Table[ Key2 ] = Argument2
    Check( Key2 )
end )
ProximityPromptService.PromptHidden:Connect( function( Key2 )
    Table[ Key2 ] = nil
    Unpark( Key2 )
end )
Controls.BindsChanged:Connect( function()
    local Value1 = nil

    for Value in Table, nil, nil do
        Check( Value )
    end
end )
