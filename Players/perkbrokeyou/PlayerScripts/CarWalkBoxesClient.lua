-- Players.perkbrokeyou.PlayerScripts.CarWalkBoxesClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local Wait = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) ).Wait( "Cars" )
local LocalPlayer = Players.LocalPlayer

local function WantOn( Object, Object2 )
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

    local IsDescendantOf

    if Flag then
        if Object2 == nil then
            IsDescendantOf = false
        else
            IsDescendantOf = Object2:IsDescendantOf( Object )
        end
    else
        IsDescendantOf = Flag
    end

    return not IsDescendantOf
end

local function SetBoxes( Object, Object2 )
    local WalkBoxes = Object:FindFirstChild( "WalkBoxes" )

    if not WalkBoxes then
        return
    end

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

    local IsDescendantOf

    if Flag then
        if Object2 == nil then
            IsDescendantOf = false
        else
            IsDescendantOf = Object2:IsDescendantOf( Object )
        end
    else
        IsDescendantOf = Flag
    end

    local CanCollide = not IsDescendantOf

    for Key, Value in WalkBoxes:GetChildren( ) do
        if Value:IsA( "BasePart" ) and Value.CanCollide ~= CanCollide then
            Value.CanCollide = CanCollide
        end
    end
end

local function MySeatNow()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
    return Character2
end

Wait.DescendantAdded:Connect( function( Part )
    if Part:IsA( "BasePart" ) and Part.Parent and Part.Parent.Name == "WalkBoxes" and Part.Parent.Parent then
        local Humanoid
        local Parent = Part.Parent.Parent
        local Character = LocalPlayer.Character

        if Character then
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end

        local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
        local Flag
        local VehicleRoot = Parent:FindFirstChild( "VehicleRoot" )

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

        local IsDescendantOf

        if Flag then
            if Character2 == nil then
                IsDescendantOf = false
            else
                IsDescendantOf = Character2:IsDescendantOf( Parent )
            end
        else
            IsDescendantOf = Flag
        end

        local CanCollide = not IsDescendantOf

        if Part.CanCollide ~= CanCollide then
            Part.CanCollide = CanCollide
        end
    end
end )
local Value1 = nil
local Number = -math.huge
RunService.PreSimulation:Connect( function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
    local Character3 = Character2

    while Character3 do
        if Character3.Parent == Wait then
            break
        end

        Character3 = Character3.Parent
    end
    if Character3 then
        SetBoxes( Character3, Character2 )
    end
    if Value1 and Value1 ~= Character3 and Value1.Parent then
        SetBoxes( Value1, Character2 )
    end

    Value1 = Character3
    local Clock = os.clock( )

    if Clock - Number > 1 then
        Number = Clock

        for Key, Value in Wait:GetChildren( ) do
            SetBoxes( Value, Character2 )
        end
    end
end )
