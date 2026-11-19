-- Players.perkbrokeyou.PlayerScripts.NightLightsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Lighting = game:GetService( "Lighting" )
local RunService = game:GetService( "RunService" )
local ClientState = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )

if not workspace:FindFirstChild( "Map" ) and workspace:GetAttribute( "RankedMatch" ) then
    return
end

local Flag
local Map = workspace:WaitForChild( "Map" )
local CurrentCamera = workspace.CurrentCamera
local Table = { }

local function IsNight()
    if ClientState.SkyNoNight then
        return false
    end

    local HeureReelle2
    local HeureReelle = Lighting:GetAttribute( "HeureReelle" )
    HeureReelle2 = type( HeureReelle ) == "number" and HeureReelle or Lighting.ClockTime
    local Flag

    if HeureReelle2 >= 18.25 then
        Flag = true
    elseif HeureReelle2 < 6.25 then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

if ClientState.SkyNoNight then
    Flag = false
else
    local HeureReelle2
    local HeureReelle = Lighting:GetAttribute( "HeureReelle" )
    HeureReelle2 = type( HeureReelle ) == "number" and HeureReelle or Lighting.ClockTime

    if HeureReelle2 >= 18.25 then
        Flag = true
    elseif HeureReelle2 < 6.25 then
        Flag = true
    else
        Flag = false
    end
end

local Class = setmetatable( { }, { __mode = "k" } )

local function PosOf( Argument1 )
    local Parent = Argument1.Parent

    if not Parent then
        return nil
    end

    local Entry2
    local Entry = Class[ Parent ]

    if Entry == nil then
        local Text

        if Parent:IsA( "BasePart" ) then
            Text = "part"
        elseif Parent:IsA( "Attachment" ) then
            Text = "att"
        else
            Text = false
        end

        Class[ Parent ] = Text
        Entry2 = Text
    else
        Entry2 = Entry
    end
    if Entry2 == "part" then
        return Parent.Position
    end
    if Entry2 == "att" then
        return Parent.WorldPosition
    end
    return nil
end

local Table2 = { }
local Class2 = setmetatable( { }, { __mode = "k" } )
local Table3 = { }

local function RefreshNear()
    if ClientState.PerfNoLights then
        local Value1 = nil

        for Value in Table3, nil, nil do
            if Value.Parent then
                Value.Enabled = false
            end
        end

        Table3 = { }
        return
    end
    local Number, Number2
    local Position = CurrentCamera.CFrame.Position
    local TableInner = { }

    if ClientState.PotatoGraphics then
        Number = 16
        Number2 = 120
    else
        Number = 90
        Number2 = 260
    end

    local Value2 = nil

    for Key, Value3 in Table, nil, nil do
        local FlagInner = Table2[ Key ] == true and true or false

        if not FlagInner then
            if not Flag or not Value3 then
                continue
            end
        end

        local Position2
        local Parent = Key.Parent

        if Parent then
            local Entry2
            local Entry = Class[ Parent ]

            if Entry == nil then
                local Text

                if Parent:IsA( "BasePart" ) then
                    Text = "part"
                elseif Parent:IsA( "Attachment" ) then
                    Text = "att"
                else
                    Text = false
                end

                Class[ Parent ] = Text
                Entry2 = Text
            else
                Entry2 = Entry
            end
            if Entry2 == "part" then
                Position2 = Parent.Position
            elseif Entry2 == "att" then
                Position2 = Parent.WorldPosition
            else
                Position2 = nil
            end
        else
            Position2 = nil
        end
        if Position2 then
            local Magnitude = ( Position2 - Position ).Magnitude

            if Magnitude <= Number2 + ( Key.Range or 0 ) then
                table.insert( TableInner, { Key, Magnitude } )
            end
        elseif FlagInner then
            table.insert( TableInner, { Key, 0 } )
        end
    end

    table.sort( TableInner, function( List, List2 )
        local Flag = List[ 2 ] < List2[ 2 ] and true or false
        return Flag
    end )
    local Table2Inner = { }
    local Min = math.min( #TableInner, Number )
    local I = 1

    for I = 1, Min do
        Table2Inner[ TableInner[ I ][ 1 ] ] = true
    end

    local Value4 = nil

    for Value5 in Table2Inner, nil, nil do
        if not Table3[ Value5 ] then
            Value5.Enabled = true
        end
    end

    local Value6 = nil

    for Value7 in Table3, nil, nil do
        if not Table2Inner[ Value7 ] and Value7.Parent then
            Value7.Enabled = false
        end
    end

    Table3 = Table2Inner
    return
end

local function Add( Value )
    if Value:IsA( "Light" ) and Table[ Value ] == nil then
        local Flag = Value:GetAttribute( "AlwaysOn" ) == true and true or false
        Table2[ Value ] = Flag

        if not Class2[ Value ] then
            Class2[ Value ] = true
            Value:GetAttributeChangedSignal( "AlwaysOn" ):Connect( function()
                if Table[ Value ] ~= nil then
                    local Flag = Value:GetAttribute( "AlwaysOn" ) == true and true or false
                    Table2[ Value ] = Flag
                end
            end )
        end

        local Flag2

        if Value:GetAttribute( "NightLight" ) == true then
            Flag2 = true
        elseif Value:GetAttribute( "AlwaysOn" ) == true then
            Flag2 = true
        else
            Flag2 = false
        end

        Table[ Value ] = Flag2

        if not Table[ Value ] then
            return
        end

        Value.Enabled = false
    end
end

for Key, Value in Map:GetDescendants( ) do
    Add( Value )
end

Map.DescendantAdded:Connect( Add )
Map.DescendantRemoving:Connect( function( Key )
    Table[ Key ] = nil
    Table3[ Key ] = nil
    Table2[ Key ] = nil
end )

local function OnClock()
    local FlagInner

    if ClientState.SkyNoNight then
        FlagInner = false
    else
        local HeureReelle2
        local HeureReelle = Lighting:GetAttribute( "HeureReelle" )
        HeureReelle2 = type( HeureReelle ) == "number" and HeureReelle or Lighting.ClockTime

        if HeureReelle2 >= 18.25 then
            FlagInner = true
        elseif HeureReelle2 < 6.25 then
            FlagInner = true
        else
            FlagInner = false
        end
    end
    if FlagInner == Flag then
        return
    end
    Flag = FlagInner
    task.delay( math.random( ) * 1.5, RefreshNear )
    return
end

Lighting:GetPropertyChangedSignal( "ClockTime" ):Connect( OnClock )
Lighting:GetAttributeChangedSignal( "HeureReelle" ):Connect( OnClock )
workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( function()
    local CurrentCamera2
    local CurrentCameraInner = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCameraInner then CurrentCameraInner else CurrentCamera
    CurrentCamera = CurrentCamera2
end )
local Number = 0.5
RunService.Heartbeat:Connect( function( Argument1 )
    Number = Number + Argument1

    if Number < 0.5 then
        return
    end
    Number = 0
    RefreshNear( )
    return
end )
