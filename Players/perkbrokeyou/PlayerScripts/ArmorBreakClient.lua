-- Players.perkbrokeyou.PlayerScripts.ArmorBreakClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ArmorBreakSounds2
local Players = game:GetService( "Players" )
local CollectionService = game:GetService( "CollectionService" )
local Parent = game:GetService( "SoundService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Debris = game:GetService( "Debris" )
local Config = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "Config" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local FarmZone = require( ReplicatedStorage:WaitForChild( "FarmZone" ) )
local ArmorBreakSounds = Config.ArmorBreakSounds
ArmorBreakSounds2 = if ArmorBreakSounds then ArmorBreakSounds else { }
local LocalPlayer = Players.LocalPlayer
local Random2 = Random.new( )
local Folder = Instance.new( "Folder" )
Folder.Name = "ArmorBreakSounds"
Folder.Parent = Parent

local function Play( Parent, Amount )
    local Value1
    local PlaybackSpeed = 1 + Random2:NextNumber( -0.03, 0.03 )
    Value1 = nil

    for Key, Value in ArmorBreakSounds2, nil, nil do
        local Sound = Instance.new( "Sound" )
        Sound.Name = "ArmorBreak"
        Sound.SoundId = "rbxassetid://" .. Value.Id
        Sound.Volume = ( Value.Volume or 1 ) * ( Amount or 1 )
        Sound.PlaybackSpeed = PlaybackSpeed

        if Parent:IsA( "BasePart" ) then
            Sound.RollOffMode = Enum.RollOffMode.InverseTapered
            Sound.RollOffMinDistance = 8
            Sound.RollOffMaxDistance = 70
        end

        Sound.Parent = Parent
        task.delay( Value.Delay or 0, function()
            if Sound.Parent then
                Sound:Play( )
            end
        end )
        Debris:AddItem( Sound, ( Value.Delay or 0 ) + 3 )
    end
end

local function OnBroken( Object )
    local Character = LocalPlayer.Character

    if Object ~= Character then
        local LastAttackerChar
        local Humanoid = Object:FindFirstChildOfClass( "Humanoid" )

        if Humanoid then
            LastAttackerChar = Humanoid:FindFirstChild( "LastAttackerChar" )
        else
            LastAttackerChar = Humanoid
        end
        if Character and LastAttackerChar and LastAttackerChar:IsA( "ObjectValue" ) and LastAttackerChar.Value == Character then
            Play( Folder )
            return
        end

        local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )

        if HumanoidRootPart and FarmZone.SameSide( HumanoidRootPart.Position ) then
            Play( HumanoidRootPart )
        end

        return
    end
    if ClientState.Spectating then
        return
    end
    Play( Folder, 1.8 )
    return
end

local function Watch( Object )
    local Armor = Object:GetAttribute( "Armor" ) or 0
    Object:GetAttributeChangedSignal( "Armor" ):Connect( function()
        local ArmorInner = Object:GetAttribute( "Armor" ) or 0

        if Armor > 0 and ArmorInner <= 0 and not Object:GetAttribute( "ArmorSilent" ) then
            OnBroken( Object )
        end

        Armor = ArmorInner
    end )
end

local function OnPlayer( Argument1 )
    Argument1.CharacterAdded:Connect( Watch )

    if Argument1.Character then
        local Character = Argument1.Character
        local Armor = Character:GetAttribute( "Armor" ) or 0
        Character:GetAttributeChangedSignal( "Armor" ):Connect( function()
            local ArmorInner = Character:GetAttribute( "Armor" ) or 0

            if Armor > 0 and ArmorInner <= 0 and not Character:GetAttribute( "ArmorSilent" ) then
                OnBroken( Character )
            end

            Armor = ArmorInner
        end )
    end
end

Players.PlayerAdded:Connect( OnPlayer )

for Key, Value in Players:GetPlayers( ) do
    Value.CharacterAdded:Connect( Watch )

    if Value.Character then
        local Character = Value.Character
        local Armor2 = Character:GetAttribute( "Armor" ) or 0
        Character:GetAttributeChangedSignal( "Armor" ):Connect( function()
            local Armor = Character:GetAttribute( "Armor" ) or 0

            if Armor2 > 0 and Armor <= 0 and not Character:GetAttribute( "ArmorSilent" ) then
                OnBroken( Character )
            end

            Armor2 = Armor
        end )
    end
end

CollectionService:GetInstanceAddedSignal( "ArmorWearer" ):Connect( Watch )

for Key2, Value2 in CollectionService:GetTagged( "ArmorWearer" ) do
    local Armor = Value2:GetAttribute( "Armor" ) or 0
    Value2:GetAttributeChangedSignal( "Armor" ):Connect( function()
        local ArmorInner = Value2:GetAttribute( "Armor" ) or 0

        if Armor > 0 and ArmorInner <= 0 and not Value2:GetAttribute( "ArmorSilent" ) then
            OnBroken( Value2 )
        end

        Armor = ArmorInner
    end )
end
