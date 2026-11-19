-- Players.perkbrokeyou.PlayerScripts.GenderChoiceClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local ChooseGender = ReplicatedStorage:WaitForChild( "Wardrobe" ):WaitForChild( "ChooseGender" )

while LocalPlayer:GetAttribute( "NeedsGender" ) == nil do
    LocalPlayer:GetAttributeChangedSignal( "NeedsGender" ):Wait( )
end
if not LocalPlayer:GetAttribute( "NeedsGender" ) then
    return
end
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait( )
end

local function Loading()
    local Flag = PlayerGui:FindFirstChild( "EcranChargement" ) ~= nil and true or false
    return Flag
end

local Get = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) ).Get( "GenderChoice" )
local Window = Get:WaitForChild( "Window" )
local MaleButton = Window:WaitForChild( "MaleButton" )
local FemaleButton = Window:WaitForChild( "FemaleButton" )
local Flag = false

local function Choose( Argument1 )
    if not Flag then
        local FlagInner = PlayerGui:FindFirstChild( "EcranChargement" ) ~= nil and true or false

        if not FlagInner then
            Flag = true
            local Success, Result = pcall( ChooseGender.InvokeServer, ChooseGender, Argument1 )

            if not Success or not Result then
                Flag = false
                return
            end
            Get.Visible = false
            GamepadNav.Close( "GenderChoice" )
            return
        end
    end
end

MaleButton.Activated:Connect( function()
    if not Flag then
        local FlagInner = PlayerGui:FindFirstChild( "EcranChargement" ) ~= nil and true or false

        if FlagInner then
            return
        end

        Flag = true
        local Success, Result = pcall( ChooseGender.InvokeServer, ChooseGender, "Male" )

        if Success and Result then
            Get.Visible = false
            GamepadNav.Close( "GenderChoice" )
            return
        end

        Flag = false
    end
end )
FemaleButton.Activated:Connect( function()
    if not Flag then
        local FlagInner = PlayerGui:FindFirstChild( "EcranChargement" ) ~= nil and true or false

        if FlagInner then
            return
        end

        Flag = true
        local Success, Result = pcall( ChooseGender.InvokeServer, ChooseGender, "Female" )

        if Success and Result then
            Get.Visible = false
            GamepadNav.Close( "GenderChoice" )
            return
        end

        Flag = false
    end
end )
Get.Visible = true

while true do
    local Flag2 = PlayerGui:FindFirstChild( "EcranChargement" ) ~= nil and true or false

    if not Flag2 then
        break
    end

    PlayerGui.ChildRemoved:Wait( )
end
if LocalPlayer:GetAttribute( "NeedsGender" ) then
    GamepadNav.Open( "GenderChoice", {
        root = Window,
        first = MaleButton,
        onBack = function()
        end,
        freezeKeyboard = true,
        selectLabel = "Choose"
    } )
    return
end
Get.Visible = false
return
