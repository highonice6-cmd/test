-- StarterPlayer.StarterPlayerScripts.WardrobeRoomFX
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Lighting = game:GetService( "Lighting" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Table = {
    Ambient = Color3.fromRGB( 18, 9, 3 ),
    OutdoorAmbient = Color3.fromRGB( 18, 9, 3 ),
    ExposureCompensation = -0.45,
    EnvironmentDiffuseScale = 0.35
}
local Value1 = nil
RunService.RenderStepped:Connect( function()
    local Flag

    if ClientState.WardrobeOpen == true then
        if ClientState.FixedCamera == nil then
            Flag = false
        else
            Flag = not ClientState.CaseRolling
        end
    else
        Flag = false
    end
    if not Flag or Value1 then
        if not Flag and Value1 then
            local Value2 = nil

            for Key2, Value3 in Value1, nil, nil do
                Lighting[ Key2 ] = Value3
            end

            Value1 = nil
        end

        return
    end
    local Value1Inner
    Value1 = { }
    Value1Inner = nil

    for Key, Value in Table, nil, nil do
        Value1[ Key ] = Lighting[ Key ]
        Lighting[ Key ] = Value
    end

    return
end )

local function Flicker( Object )
    local Brightness
    local Light = Object:FindFirstChildWhichIsA( "Light" )
    Brightness = Light and Light.Brightness or 1
    local Table = { }

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Material == Enum.Material.Neon then
            table.insert( Table, { part = Value, color = Value.Color } )
        end
    end

    local function Set( Argument1, Amount )
        if Light then
            local BrightnessInner

            if Argument1 then
                local Captured = Brightness * ( Amount or 1 )

                if Captured then
                    BrightnessInner = Captured
                else
                    BrightnessInner = 0
                end
            else
                BrightnessInner = 0
            end

            Light.Brightness = BrightnessInner
        end

        local Value1 = nil

        for Key, Value in Table, nil, nil do
            local Material
            local Part = Value.part
            Material = Argument1 and Enum.Material.Neon or Enum.Material.SmoothPlastic
            local Color2
            Part.Material = Material
            local Part2 = Value.part

            if not Argument1 or not Value.color then
                local Color = Value.color
                Color2 = Color:Lerp( Color3.new( 0, 0, 0 ), 0.6 )
            else
                Color2 = Value.color
            end

            Part2.Color = Color2
        end
    end

    task.spawn( function()
        local Random2 = Random.new( )

        while Object.Parent do
            task.wait( Random2:NextNumber( 1.5, 5 ) )
            local NextInteger = Random2:NextInteger( 2, 5 )
            local I = 1

            for I = 1, NextInteger do
                Set( false )
                task.wait( Random2:NextNumber( 0.04, 0.12 ) )
                Set( true, Random2:NextNumber( 0.5, 1 ) )
                task.wait( Random2:NextNumber( 0.05, 0.2 ) )
            end

            Set( true )

            if Random2:NextNumber( ) < 0.25 then
                Set( false )
                task.wait( Random2:NextNumber( 0.3, 0.9 ) )
                Set( true )
            end
        end
    end )
end

for Key, Value in workspace:WaitForChild( "SPAWN_CHARACTER", math.huge ):GetChildren( ) do
    if Value:GetAttribute( "Flicker" ) then
        Flicker( Value )
    end
end
