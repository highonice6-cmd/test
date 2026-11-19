-- StarterPlayer.StarterPlayerScripts.HideOthersClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local Weapons = game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local VisualRegistry = require( Weapons:WaitForChild( "VisualRegistry" ) )
local LocalPlayer = Players.LocalPlayer
local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
local Table = { "Wardrobe", "Armory", "CaseMenu", "VehicleCrateMenu" }

local function SceneOpen()
    if ClientState.PerfHideOthers then
        return true
    end
    if ClientState.Spectating then
        return false
    end
    if ClientState.FixedCamera or ClientState.WardrobeOpen then
        return true
    end
    if LocalPlayer:GetAttribute( "InWardrobe" ) == true or LocalPlayer:GetAttribute( "Onboarding" ) == true then
        return true
    end

    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if not PlayerGui then
        return false
    end

    local Value1 = nil

    for Key, Value in Table, nil, nil do
        if Screens.IsShown( Screens.Find( Value, PlayerGui ) ) then
            return true
        end
    end

    return false
end

local Table2 = { }
local Table3 = { }

local function Switchable( Self )
    local IsA5
    local IsA = Self:IsA( "BillboardGui" )

    if IsA then
        IsA5 = IsA
    else
        local IsA2 = Self:IsA( "Highlight" )

        if IsA2 then
            IsA5 = IsA2
        else
            local IsA3 = Self:IsA( "ParticleEmitter" )

            if IsA3 then
                IsA5 = IsA3
            else
                local IsA4 = Self:IsA( "Trail" )

                if IsA4 then
                    IsA5 = IsA4
                else
                    IsA5 = Self:IsA( "Beam" )
                end
            end
        end
    end

    return IsA5
end

local function IsOther( Argument1 )
    local PlayerFromCharacter

    if Argument1 then
        PlayerFromCharacter = Players:GetPlayerFromCharacter( Argument1 )
    else
        PlayerFromCharacter = Argument1
    end

    local Flag

    if PlayerFromCharacter == nil then
        Flag = false
    elseif PlayerFromCharacter == LocalPlayer then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function HideIn( List )
    local Value1 = nil

    for Key, Value in List, nil, nil do
        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
            Table2[ Value ] = true
        elseif Switchable( Value ) and Table3[ Value ] == nil then
            Table3[ Value ] = Value.Enabled
        end
    end
end

local Table4 = { }

local function HideNow( NowName )
    if NowName:IsA( "BasePart" ) or NowName:IsA( "Decal" ) then
        Table2[ NowName ] = true
        NowName.LocalTransparencyModifier = 1
        return
    end
    if Switchable( NowName ) and Table3[ NowName ] == nil then
        Table3[ NowName ] = NowName.Enabled
        NowName.Enabled = false
    end
end

local function Watch( Key )
    if not Table4[ Key ] then
        Table4[ Key ] = Key.DescendantAdded:Connect( HideNow )
    end
end

local function Scan()
    for Key, Value in Players:GetPlayers( ) do
        local Flag2 = if Value == LocalPlayer then false else Value.Character

        if Flag2 then
            if not Table4[ Flag2 ] then
                Table4[ Flag2 ] = Flag2.DescendantAdded:Connect( HideNow )
            end

            HideIn( Flag2:GetDescendants( ) )
            local Entry = VisualRegistry[ Flag2 ]

            if Entry and Entry.Parent then
                HideIn( Entry:GetDescendants( ) )
            end
        end
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        for Key2, Value2 in CurrentCamera:GetDescendants( ) do
            if Value2:IsA( "Highlight" ) and Table3[ Value2 ] == nil and Value2.Adornee then
                local Model

                if not Value2.Adornee:IsA( "Model" ) or not Value2.Adornee then
                    Model = Value2.Adornee:FindFirstAncestorOfClass( "Model" )
                else
                    Model = Value2.Adornee
                end

                local PlayerFromCharacter

                if Model then
                    PlayerFromCharacter = Players:GetPlayerFromCharacter( Model )
                else
                    PlayerFromCharacter = Model
                end

                local Flag

                if PlayerFromCharacter == nil then
                    Flag = false
                elseif PlayerFromCharacter == LocalPlayer then
                    Flag = false
                else
                    Flag = true
                end
                if Flag then
                    Table3[ Value2 ] = Value2.Enabled
                end
            end
        end
    end
end

local function Restore()
    local Value1 = nil

    for Key, Value in Table4, nil, nil do
        Value:Disconnect( )
    end

    local Value2
    table.clear( Table4 )
    Value2 = nil

    for Value3 in Table2, nil, nil do
        if Value3.Parent then
            Value3.LocalTransparencyModifier = 0
        end
    end

    local Value4 = nil

    for Key2, Value5 in Table3, nil, nil do
        if Key2.Parent then
            Key2.Enabled = Value5
        end
    end

    table.clear( Table2 )
    table.clear( Table3 )
end

local Flag = false
local Number = 0

local function OnOtherCharacter( CharacterName )
    if not Flag then
        return
    end
    for Key, Value in CharacterName:GetDescendants( ) do
        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
            Table2[ Value ] = true
            Value.LocalTransparencyModifier = 1
        elseif Switchable( Value ) and Table3[ Value ] == nil then
            Table3[ Value ] = Value.Enabled
            Value.Enabled = false
        end
    end
    if not Table4[ CharacterName ] then
        Table4[ CharacterName ] = CharacterName.DescendantAdded:Connect( HideNow )
    end
end

local function HookPlayer( Argument1 )
    if Argument1 ~= LocalPlayer then
        Argument1.CharacterAdded:Connect( OnOtherCharacter )
    end
end

Players.PlayerAdded:Connect( HookPlayer )

for Key, Value in Players:GetPlayers( ) do
    if Value ~= LocalPlayer then
        Value.CharacterAdded:Connect( OnOtherCharacter )
    end
end

RunService.RenderStepped:Connect( function( Argument1 )
    if SceneOpen( ) then
        Flag = true
        Number = Number - Argument1

        if Number <= 0 then
            Number = 0.15
            Scan( )
        end

        local Value1 = nil

        for Value in Table2, nil, nil do
            if Value.Parent then
                if Value.LocalTransparencyModifier ~= 1 then
                    Value.LocalTransparencyModifier = 1
                end
            else
                Table2[ Value ] = nil
            end
        end

        local Value2 = nil

        for Value3 in Table3, nil, nil do
            local Success, Result = pcall( function()
                if not Value3.Parent then
                    return false
                end
                if Value3.Enabled then
                    Value3.Enabled = false
                end

                return true
            end )

            if not Success then
                LocalPlayer:SetAttribute( "BBLocked", ( LocalPlayer:GetAttribute( "BBLocked" ) or 0 ) + 1 )
                LocalPlayer:SetAttribute( "BBLockedOn", ( LocalPlayer:GetAttribute( "BBLockedOn" ) or 0 ) + 1 )
            end
            if not Success or not Result then
                Table3[ Value3 ] = nil
            end
        end

        return
    end
    if Flag then
        Flag = false
        Restore( )
    end

    return
end )
