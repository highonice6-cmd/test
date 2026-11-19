-- Players.perkbrokeyou.PlayerScripts.ScopeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ContentProvider = game:GetService( "ContentProvider" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local VisualRegistry = require( Weapons:WaitForChild( "VisualRegistry" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local LocalPlayer = Players.LocalPlayer
LocalPlayer:WaitForChild( "PlayerGui" )
local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
local ScaleUI = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ScaleUI" ) )
local Get = Screens.Get( "ScopeOverlay" )
Get.Visible = false
local Scope = Get:WaitForChild( "Scope" )
local BandeGauche = Get:WaitForChild( "BandeGauche" )
local BandeDroite = Get:WaitForChild( "BandeDroite" )

local function Layout()
    local AbsoluteSize = Get.AbsoluteSize

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        return
    end

    local Visible
    local Y = AbsoluteSize.Y * 1.7777777777777777
    local FromPx = ScaleUI.FromPx
    local Ceil = math.ceil( Y ) + 2
    Scope.Size = FromPx( Ceil, AbsoluteSize.Y + 2, AbsoluteSize )
    local X = ( AbsoluteSize.X - Y ) / 2
    Visible = X > 0 and true or false
    local Visible2
    BandeGauche.Visible = Visible
    Visible2 = X > 0 and true or false
    BandeDroite.Visible = Visible2

    if X > 0 then
        local Ceil2 = math.ceil( X ) + 2
        local FromPx2 = ScaleUI.FromPx
        BandeGauche.Size = FromPx2( Ceil2, AbsoluteSize.Y, AbsoluteSize )
        local FromPx3 = ScaleUI.FromPx
        BandeDroite.Size = FromPx3( Ceil2, AbsoluteSize.Y, AbsoluteSize )
    end
end

Get:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Layout )
Layout( )
local Parent = Screens.Get( "ScopePreload" )
local Table = { }
local Table2 = { }

for Key, Value in Parent:GetChildren( ) do
    if Value:IsA( "ImageLabel" ) then
        table.insert( Table, Value )
        Table2[ Value.Image ] = true
    end
end

local Value1 = nil

for Key2, Value2 in WeaponData, nil, nil do
    local Flag2

    if type( Value2 ) == "table" then
        local Handling = Value2.Handling

        if Handling then
            Flag2 = Value2.Handling.Scope
        else
            Flag2 = Handling
        end
    else
        Flag2 = false
    end

    local Image

    if Flag2 then
        local Overlay = Flag2.Overlay

        if Overlay then
            Image = "rbxassetid://" .. Flag2.Overlay
        else
            Image = Overlay
        end
    else
        Image = Flag2
    end
    if Image and not Table2[ Image ] and Table[ 1 ] then
        local Clone = Table[ 1 ]:Clone( )
        Clone.Name = tostring( Key2 )
        Clone.Image = Image
        Clone.Parent = Parent
        table.insert( Table, Clone )
        Table2[ Image ] = true
    end
end

task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table )
local Flag = false

local function SetHidden( HiddenName, Visible )
    local LocalTransparencyModifier = not Visible and 0 or 1

    for Key, Value in HiddenName:GetDescendants( ) do
        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
            Value.LocalTransparencyModifier = LocalTransparencyModifier
        end
    end

    local Entry = VisualRegistry[ HiddenName ]

    if Entry then
        for Key2, Value2 in Entry:GetDescendants( ) do
            if Value2:IsA( "BasePart" ) or Value2:IsA( "Decal" ) then
                Value2.LocalTransparencyModifier = LocalTransparencyModifier
            end
        end
    end
end

RunService:BindToRenderStep( "ScopeOverlay", Enum.RenderPriority.Camera.Value + 2, function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Visible

    if ClientState.Scoped == true then
        if ClientState.ScopeOverlay == nil then
            Visible = false
        elseif Humanoid == nil then
            Visible = false
        elseif Humanoid.Health > 0 then
            Visible = true
        else
            Visible = false
        end
    else
        Visible = false
    end
    if Visible then
        local Image = "rbxassetid://" .. ClientState.ScopeOverlay

        if Scope.Image ~= Image then
            Scope.Image = Image
        end
    end
    if Get.Visible ~= Visible then
        Get.Visible = Visible
    end
    if Character then
        if Visible or Flag then
            SetHidden( Character, Visible )
            Flag = Visible
        end
    end
end )
LocalPlayer.CharacterAdded:Connect( function()
    Flag = false
    Get.Visible = false
end )
