-- ReplicatedStorage.FarmZone
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Zones2
local Table = { COOLDOWN = 3 }
local Table2 = { }
local Table3 = { }
local Table4 = { }
local Value1 = nil

local function Refresh()
    table.clear( Table2 )
    table.clear( Table3 )
    table.clear( Table4 )

    if not Value1 then
        return
    end
    for Key, Value in Value1:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            if Value:GetAttribute( "FarmZone" ) then
                table.insert( Table2, Value )
            elseif Value:GetAttribute( "FarmSound" ) then
                table.insert( Table3, Value )
            elseif Value:GetAttribute( "SoundNeutral" ) then
                table.insert( Table4, Value )
            end
        end
    end
end

local function Inside( List, Argument2 )
    local Value1 = nil

    for Key, Value in List, nil, nil do
        local PointToObjectSpace = Value.CFrame:PointToObjectSpace( Argument2 )
        local Size = Value.Size / 2

        if math.abs( PointToObjectSpace.X ) <= Size.X and math.abs( PointToObjectSpace.Y ) <= Size.Y then
            if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                return true
            end
        end
    end

    return false
end

local function Bind( FarmZones )
    Value1 = FarmZones
    Refresh( )
    FarmZones.DescendantAdded:Connect( function( Self )
        if Self:IsA( "BasePart" ) then
            if Self:GetAttribute( "FarmZone" ) or Self:GetAttribute( "FarmSound" ) or Self:GetAttribute( "SoundNeutral" ) then
                Refresh( )
            end
        end
    end )
    FarmZones.DescendantRemoving:Connect( function()
        task.defer( Refresh )
    end )
end

local Zones = workspace:FindFirstChild( "Zones" )
Zones2 = if Zones then Zones else workspace
local FarmZones = Zones2:FindFirstChild( "FarmZones" )

if FarmZones then
    Bind( FarmZones )
else
    task.spawn( function()
        local FarmZones
        local Zones = workspace:WaitForChild( "Zones", 120 )

        if Zones then
            FarmZones = Zones:WaitForChild( "FarmZones", 120 )
        else
            FarmZones = Zones
        end
        if FarmZones then
            Bind( FarmZones )
        end
    end )
end

function Table.Contains( Argument1 )
    return ( Inside( Table2, Argument1 ) )
end

local function FarmSide( Argument1 )
    local Value2
    local Inside2 = Inside( Table2, Argument1 )
    Value2 = if Inside2 then Inside2 else Inside( Table3, Argument1 )
    return Value2
end

function Table.IsIn( Object )
    local HumanoidRootPart

    if Object then
        HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Object
    end

    local Contains

    if HumanoidRootPart == nil then
        Contains = false
    else
        Contains = Table.Contains( HumanoidRootPart.Position )
    end

    return Contains
end

local function Listener()
    local CurrentCamera2
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return nil
    end

    local CameraSubject = CurrentCamera.CameraSubject

    if CameraSubject then
        if CameraSubject:IsA( "Humanoid" ) then
            if not ( CameraSubject.Health > 0 ) or not CameraSubject.Parent then
                CurrentCamera2 = CurrentCamera
            else
                local HumanoidRootPart2
                local HumanoidRootPart = CameraSubject.Parent:FindFirstChild( "HumanoidRootPart" )
                HumanoidRootPart2 = if HumanoidRootPart then HumanoidRootPart else CameraSubject.RootPart

                if HumanoidRootPart2 then
                    return HumanoidRootPart2.Position
                end
                CurrentCamera2 = CurrentCamera
            end
        elseif CameraSubject:IsA( "BasePart" ) then
            return CameraSubject.Position
        else
            CurrentCamera2 = CurrentCamera
        end
    else
        CurrentCamera2 = CurrentCamera
    end

    local HumanoidRootPart3
    local LocalPlayer = game:GetService( "Players" ).LocalPlayer

    if LocalPlayer then
        local Character = LocalPlayer.Character

        if Character then
            HumanoidRootPart3 = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart3 = Character
        end
    else
        HumanoidRootPart3 = LocalPlayer
    end
    if HumanoidRootPart3 then
        return HumanoidRootPart3.Position
    end
    return CurrentCamera2.CFrame.Position
end

function Table.SameSide( Argument1 )
    if typeof( Argument1 ) ~= "Vector3" or #Table2 == 0 then
        return true
    end

    local Listener2 = Listener( )

    if not Listener2 then
        return true
    end
    if Inside( Table4, Argument1 ) or Inside( Table4, Listener2 ) then
        return true
    end

    local Value4
    local Inside2 = Inside( Table2, Argument1 )
    Value4 = if Inside2 then Inside2 else Inside( Table3, Argument1 )
    local Value5
    local Inside3 = Inside( Table2, Listener2 )
    Value5 = if Inside3 then Inside3 else Inside( Table3, Listener2 )
    local Flag = Value4 == Value5 and true or false
    return Flag
end
return Table
