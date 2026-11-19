-- Players.perkbrokeyou.PlayerScripts.PlayerGlowClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local TouchEnabled2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local WorldRefs = require( ReplicatedStorage:WaitForChild( "WorldRefs" ) )
local LocalPlayer = Players.LocalPlayer
local CrewShared = require( ReplicatedStorage:WaitForChild( "CrewShared" ) )
local CollectionService = game:GetService( "CollectionService" )
local OnScreen = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "OnScreen" ) )
local SpawnShield = require( ReplicatedStorage:WaitForChild( "SpawnShield" ) )
local UserInputService = game:GetService( "UserInputService" )
local TouchEnabled = UserInputService.TouchEnabled
TouchEnabled2 = if TouchEnabled then not UserInputService.KeyboardEnabled else TouchEnabled
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local FillColor = Color3.fromRGB( 235, 235, 240 )
local OutlineColor = Color3.fromRGB( 235, 235, 240 )
local Parent = Instance.new( "Folder" )
Parent.Name = "Lueurs"
local Table = { }
local I = 1

for I = 1, 16 do
    local Highlight = Instance.new( "Highlight" )
    Highlight.Name = "Lueur"
    Highlight.FillColor = FillColor
    Highlight.FillTransparency = 1
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0.78
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Enabled = false
    Highlight.Parent = Parent
    Table[ I ] = Highlight
end

local function ThermalOn( Object )
    local ThermalHighlights

    if Object then
        ThermalHighlights = Object:FindFirstChild( "ThermalHighlights" )
    else
        ThermalHighlights = Object
    end
    if not ThermalHighlights then
        return false
    end
    for Key, Value in ThermalHighlights:GetChildren( ) do
        if Value:IsA( "Highlight" ) then
            if Value.Enabled then
                return true
            end
        end
    end

    return false
end

local function Glowing( Object )
    local Humanoid = Object:FindFirstChildOfClass( "Humanoid" )

    if not Humanoid or Humanoid.Health <= 0 then
        return false
    end
    if Object:FindFirstChild( "SkinHighlight" ) then
        return false
    end
    if Object:GetAttribute( "InSafeZone" ) then
        return false
    end
    if Object:GetAttribute( "InFarmZone" ) and Object:GetAttribute( "PvPSafe" ) then
        return false
    end
    if CrewShared.Same( LocalPlayer, Object ) then
        return false
    end
    if SpawnShield.Active( Object ) then
        return false
    end
    if LocalPlayer:GetAttribute( "InTutorial" ) ~= nil then
        return false
    end

    local PlayerFromCharacter = Players:GetPlayerFromCharacter( Object )

    if PlayerFromCharacter and PlayerFromCharacter:GetAttribute( "InTutorial" ) ~= nil then
        return false
    end

    local Flag = Object:FindFirstChild( "HumanoidRootPart" ) ~= nil and true or false
    return Flag
end

local Table2 = { }
local Table3 = { }

local function OnScreen2( ScreenName, CurrentCamera, Argument3 )
    if Argument3 and not OnScreen.forceOff then
        local Entry = OnScreen.list[ ScreenName ]

        if Entry ~= nil then
            return Entry
        end
    end

    local HumanoidRootPart

    if CurrentCamera then
        HumanoidRootPart = ScreenName:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = CurrentCamera
    end
    if not HumanoidRootPart then
        return true
    end

    local Position = HumanoidRootPart.Position

    if ( Position - CurrentCamera.CFrame.Position ).Magnitude <= 30 then
        return true
    end

    local WorldToViewportPoint = CurrentCamera:WorldToViewportPoint( Position )

    if WorldToViewportPoint.Z <= 0 then
        return false
    end

    local Flag
    local ViewportSize = CurrentCamera.ViewportSize
    local Z = 7 / ( WorldToViewportPoint.Z * math.tan( math.rad( CurrentCamera.FieldOfView ) / 2 ) ) * ViewportSize.Y / 2
    local X = ViewportSize.X * 0.1 + Z
    local Y = ViewportSize.Y * 0.1 + Z
    local X2 = WorldToViewportPoint.X

    if -X <= X2 then
        if WorldToViewportPoint.X <= ViewportSize.X + X then
            local Y2 = WorldToViewportPoint.Y

            if -Y <= Y2 then
                if WorldToViewportPoint.Y <= ViewportSize.Y + Y then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local function ApplyOnScreen()
    local Value1
    local CurrentCamera = workspace.CurrentCamera
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Entry = Table2[ Key ]

        if Entry then
            local Enabled = OnScreen2( Entry, CurrentCamera, Table3[ Key ] )

            if Value.Enabled ~= Enabled then
                Value.Enabled = Enabled
            end
        end
    end
end

game:GetService( "RunService" ).Heartbeat:Connect( ApplyOnScreen )

local function DropOldPools( Object )
    for Key, Value in Object:GetChildren( ) do
        if Value ~= Parent and Value.Name == "Lueurs" and Value:IsA( "Folder" ) then
            Value:Destroy( )
        end
    end
end

local function OtherHighlights( Object )
    local Number = 0

    for Key, Value in Players:GetPlayers( ) do
        local Character = Value.Character

        if Character then
            for Key4, Value4 in Character:GetChildren( ) do
                if Value4:IsA( "Highlight" ) and Value4.Enabled then
                    Number = Number + 1
                end
            end
        end
    end
    if Object then
        for Key2, Value2 in Object:GetChildren( ) do
            if Value2 ~= Parent then
                if Value2:IsA( "Highlight" ) then
                    if Value2.Enabled then
                        Number = Number + 1
                    end
                else
                    for Key3, Value3 in Value2:GetChildren( ) do
                        if Value3:IsA( "Highlight" ) and Value3.Enabled then
                            Number = Number + 1
                        end
                    end
                end
            end
        end
    end

    return Number
end

while true do
    local Parent2 = workspace.CurrentCamera

    if Parent2 and Parent.Parent ~= Parent2 then
        DropOldPools( Parent2 )
        Parent.Parent = Parent2
    end

    local Flag
    local Table4 = { }
    Flag = if ClientState.LightPlayers == true then true else TouchEnabled2
    local Number = not Flag and 16 or 6
    local Number2 = not Flag and 600 or 250
    local Min = math.min( Number, ( math.max( 0, 29 - OtherHighlights( Parent2 ) ) ) )

    if Parent2 and not ThermalOn( Parent2 ) then
        local Position = Parent2.CFrame.Position

        local function Consider( Object )
            if Object ~= LocalPlayer.Character and Glowing( Object ) then
                local Magnitude = ( Object.HumanoidRootPart.Position - Position ).Magnitude

                if Magnitude <= Number2 then
                    table.insert( Table4, { m = Object, d = Magnitude } )
                end
            end
        end

        for Key, Value in Players:GetPlayers( ) do
            if Value ~= LocalPlayer and Value.Character then
                Consider( Value.Character )
            end
        end

        local Find = WorldRefs.Find( "Dummies" )

        if Find then
            for Key2, Value2 in Find:GetChildren( ) do
                if Value2:IsA( "Model" ) then
                    Consider( Value2 )
                end
            end
        end

        table.sort( Table4, function( Argument1, Argument2 )
            local Flag = Argument1.d < Argument2.d and true or false
            return Flag
        end )
    end

    local Value1 = nil

    for Key3, Value3 in Table, nil, nil do
        local Entry = Key3 <= Min and Table4[ Key3 ] or nil

        if Entry then
            if Value3.Adornee ~= Entry.m then
                Value3.Adornee = Entry.m
            end

            local HasTag
            Table2[ Key3 ] = Entry.m

            if Players:GetPlayerFromCharacter( Entry.m ) == nil then
                HasTag = CollectionService:HasTag( Entry.m, "GunBot" )
            else
                HasTag = true
            end

            Table3[ Key3 ] = HasTag
        else
            Table2[ Key3 ] = nil
            Table3[ Key3 ] = nil
            Value3.Enabled = false
            Value3.Adornee = nil
        end
    end

    ApplyOnScreen( )
    task.wait( 0.2 )
end
