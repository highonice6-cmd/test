-- Players.perkbrokeyou.PlayerScripts.CarFloorNetClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local WorldRefs = require( ReplicatedStorage:WaitForChild( "WorldRefs" ) )
local CarFloorNet = require( ReplicatedStorage:WaitForChild( "VehicleSystem" ):WaitForChild( "CarFloorNet" ) )
local Wait = WorldRefs.Wait( "Cars" )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer

local function SimulatedHere( Object )
    local Flag
    local VehicleRoot = Object:FindFirstChild( "VehicleRoot" )

    if VehicleRoot == nil then
        Flag = false
    else
        local NotAnchored = not VehicleRoot.Anchored

        if NotAnchored then
            if VehicleRoot.ReceiveAge == 0 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = NotAnchored
        end
    end

    return Flag
end

local Table = { }
local Number = -math.huge
local Value1 = nil
RunService.PostSimulation:Connect( function()
    local Humanoid
    local Clock = os.clock( )
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2

    if Humanoid then
        Character2 = Humanoid.SeatPart
    else
        Character2 = Humanoid
    end
    while Character2 do
        if Character2.Parent == Wait then
            break
        end

        Character2 = Character2.Parent
    end
    if Clock - Number > 0.1 or Character2 ~= Value1 then
        Number = Clock
        Value1 = Character2
        table.clear( Table )

        for Key, Value in Wait:GetChildren( ) do
            local Flag2
            local VehicleRoot2 = Value:FindFirstChild( "VehicleRoot" )

            if VehicleRoot2 == nil then
                Flag2 = false
            else
                local NotAnchored2 = not VehicleRoot2.Anchored

                if NotAnchored2 then
                    if VehicleRoot2.ReceiveAge == 0 then
                        Flag2 = true
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = NotAnchored2
                end
            end
            if Flag2 then
                Table[ Value ] = true
            end
        end
    end

    local Value1Inner = nil

    for Value2 in Table, nil, nil do
        if Value2.Parent then
            local Flag
            local VehicleRoot = Value2:FindFirstChild( "VehicleRoot" )

            if VehicleRoot == nil then
                Flag = false
            else
                local NotAnchored = not VehicleRoot.Anchored

                if NotAnchored then
                    if VehicleRoot.ReceiveAge == 0 then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = NotAnchored
                end
            end
            if Flag then
                CarFloorNet.Step( Value2 )
            end
        end
    end
end )
