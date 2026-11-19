-- StarterGui.HUDButtons.Frame.RankedSide.RankedButton.RankedButtonClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Parent = script.Parent

if not Parent:IsDescendantOf( Players.LocalPlayer ) then
    return
end

local Ranked2
local LocalPlayer = Players.LocalPlayer
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
Parent.Visible = false
local Ranked = workspace:WaitForChild( "Ranked", 30 )
Ranked2 = if Ranked then Ranked:WaitForChild( "AllerRanked", 30 ) else Ranked

if Ranked then
    local Visible

    local function Sync()
        local Visible

        if Ranked:GetAttribute( "Enabled" ) == false then
            Visible = false
        elseif LocalPlayer:GetAttribute( "InTutorial" ) == nil then
            Visible = true
        else
            Visible = false
        end

        Parent.Visible = Visible
    end

    Ranked:GetAttributeChangedSignal( "Enabled" ):Connect( Sync )
    LocalPlayer:GetAttributeChangedSignal( "InTutorial" ):Connect( Sync )

    if Ranked:GetAttribute( "Enabled" ) == false then
        Visible = false
    elseif LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        Visible = true
    else
        Visible = false
    end

    Parent.Visible = Visible
end

local OpenButton
local Parent2 = Parent.Parent

if Parent2 then
    if Parent2.Name == "RankedSide" then
        local Parent3 = Parent2.Parent

        if Parent3 then
            OpenButton = Parent2.Parent:FindFirstChild( "OpenButton" )
        else
            OpenButton = Parent3
        end
    else
        OpenButton = false
    end
else
    OpenButton = Parent2
end
if OpenButton and OpenButton:IsA( "GuiObject" ) then
    local function Follow()
        Parent2.Visible = OpenButton.Visible
    end

    OpenButton:GetPropertyChangedSignal( "Visible" ):Connect( Follow )
    Parent2.Visible = OpenButton.Visible
end

local RetourGunshop

if Ranked then
    RetourGunshop = Ranked:WaitForChild( "RetourGunshop", 30 )
else
    RetourGunshop = Ranked
end

local Logo = Parent:FindFirstChild( "Logo" )
local Icone = Parent:FindFirstChild( "Icone" )

if Icone and Logo then
    Logo.Visible = false
end

local UIGradient2
task.spawn( function()
    local Value1
    local Table = { }
    local Table2 = { "rbxassetid://80097505443248", "rbxassetid://107780987239512" }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local ImageLabel = Instance.new( "ImageLabel" )
        ImageLabel.Image = Value
        table.insert( Table, ImageLabel )
    end

    pcall( function()
        game:GetService( "ContentProvider" ):PreloadAsync( Table )
    end )
end )
local Text = Parent:FindFirstChild( "Text" )
local UIGradient = Parent:FindFirstChildOfClass( "UIGradient" )

if Text then
    UIGradient2 = Text:FindFirstChildOfClass( "UIGradient" )
else
    UIGradient2 = Text
end

local Logo2
local Table = { icon = "rbxassetid://80097505443248" }
Logo2 = if Logo then Logo.Text else Logo
local Text2
Table.logo = Logo2
Text2 = if Text then Text.Text else Text
local Grad
Table.text = Text2
Grad = if UIGradient then UIGradient.Color else UIGradient
local LabelGrad
Table.grad = Grad
LabelGrad = if UIGradient2 then UIGradient2.Color else UIGradient2
Table.labelGrad = LabelGrad

local function Rgb( Argument1, Argument2, Argument3 )
    return Color3.fromRGB( Argument1, Argument2, Argument3 )
end

local Table2 = {
    logo = "🚪",
    text = "Exit",
    icon = "rbxassetid://107780987239512",
    grad = ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Rgb( 130, 24, 32 ) ),
        ColorSequenceKeypoint.new( 0.22, Rgb( 48, 10, 14 ) ),
        ColorSequenceKeypoint.new( 0.5, Rgb( 8, 8, 8 ) ),
        ColorSequenceKeypoint.new( 0.78, Rgb( 48, 10, 14 ) ),
        ColorSequenceKeypoint.new( 1, Rgb( 130, 24, 32 ) )
    } ),
    labelGrad = ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Rgb( 255, 150, 150 ) ),
        ColorSequenceKeypoint.new( 0.5, Rgb( 255, 255, 255 ) ),
        ColorSequenceKeypoint.new( 1, Rgb( 255, 110, 110 ) )
    } )
}

local function OnBarge()
    if not Ranked then
        return false
    end

    local ZoneCF = Ranked:GetAttribute( "ZoneCF" )
    local ZoneSize = Ranked:GetAttribute( "ZoneSize" )

    if typeof( ZoneCF ) ~= "CFrame" or typeof( ZoneSize ) ~= "Vector3" then
        return false
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not HumanoidRootPart then
        return false
    end

    local Flag
    local PointToObjectSpace = ZoneCF:PointToObjectSpace( HumanoidRootPart.Position )
    local ZoneSize2 = ZoneSize / 2

    if math.abs( PointToObjectSpace.X ) <= ZoneSize2.X then
        if math.abs( PointToObjectSpace.Y ) <= ZoneSize2.Y then
            if math.abs( PointToObjectSpace.Z ) <= ZoneSize2.Z then
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

    return Flag
end

local Flag = false

local function Apply( Argument1 )
    if Logo and Argument1.logo then
        Logo.Text = Argument1.logo
    end
    if Icone and Argument1.icon then
        Icone.Image = Argument1.icon
    end
    if Text and Argument1.text then
        Text.Text = Argument1.text
    end
    if UIGradient and Argument1.grad then
        UIGradient.Color = Argument1.grad
    end
    if UIGradient2 and Argument1.labelGrad then
        UIGradient2.Color = Argument1.labelGrad
    end
end

task.spawn( function()
    while Parent.Parent do
        local FlagInner
        local OnBarge2 = OnBarge( )

        if OnBarge2 then
            if RetourGunshop == nil then
                FlagInner = false
            else
                FlagInner = true
            end
        else
            FlagInner = OnBarge2
        end
        if FlagInner ~= Flag then
            local Captured
            Flag = FlagInner
            Captured = FlagInner and Table2 or Table

            if Logo and Captured.logo then
                Logo.Text = Captured.logo
            end
            if Icone and Captured.icon then
                Icone.Image = Captured.icon
            end
            if Text and Captured.text then
                Text.Text = Captured.text
            end
            if UIGradient and Captured.grad then
                UIGradient.Color = Captured.grad
            end
            if UIGradient2 and Captured.labelGrad then
                UIGradient2.Color = Captured.labelGrad
            end
        end

        task.wait( 0.25 )
    end
end )
local Flag2 = false
Parent.Activated:Connect( function()
    local Captured = Flag and RetourGunshop or Ranked2

    if Flag2 or not Captured then
        return
    end

    local Text = not Flag and "Ranked" or "the Gun Shop"
    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if CombatUntil and workspace:GetServerTimeNow( ) < CombatUntil then
        Notify.Error( "You can't go to " .. Text .. " during a fight" )
        return
    end

    local Character = LocalPlayer.Character

    if not Character or Character:GetAttribute( "InSafeZone" ) ~= true then
        Notify.Error( "You can only go to " .. Text .. " from a safe zone" )
        return
    end

    Flag2 = true
    local Success, Result = pcall( Captured.InvokeServer, Captured )
    Flag2 = false

    if not Success or Result ~= true then
        if Success and type( Result ) == "string" then
            Notify.Error( Result )
        end
    else
        local ClosePanel
        local ScreenGui = Parent:FindFirstAncestorOfClass( "ScreenGui" )

        if ScreenGui then
            ClosePanel = ScreenGui:FindFirstChild( "ClosePanel" )
        else
            ClosePanel = ScreenGui
        end
        if ClosePanel and ClosePanel:IsA( "BindableEvent" ) then
            ClosePanel:Fire( )
            return
        end
    end
end )
