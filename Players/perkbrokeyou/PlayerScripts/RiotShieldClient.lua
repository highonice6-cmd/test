-- Players.perkbrokeyou.PlayerScripts.RiotShieldClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Inventory = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "Inventory" ) )
local ShieldBack = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "ShieldBack" )
local LocalPlayer = Players.LocalPlayer
local Value1 = nil

local function Check()
    local Flag
    local Success, Result = pcall( Inventory.Layout )

    if not Success or type( Result ) ~= "table" then
        Flag = false
    else
        local HOTBAR = Inventory.HOTBAR
        local I = 1
        Flag = false

        for I = 1, HOTBAR do
            local Entry = Result[ I ]

            if Entry and Entry:GetAttribute( "Melee" ) == "RiotShield" then
                Flag = true
                break
            end

            Flag = false
        end
    end
    if Flag ~= Value1 then
        Value1 = Flag
        ShieldBack:FireServer( Flag )
    end
end

local function Later()
    task.defer( Check )
end

Inventory.Changed.Event:Connect( Later )

local function Watch( Argument1 )
    Argument1.ChildAdded:Connect( function( Object )
        if Object:IsA( "Tool" ) then
            task.defer( Check )
        end
    end )
    Argument1.ChildRemoved:Connect( function( Object )
        if Object:IsA( "Tool" ) then
            task.defer( Check )
        end
    end )
end

LocalPlayer.ChildAdded:Connect( function( Object )
    if Object:IsA( "Backpack" ) then
        Watch( Object )
        task.defer( Check )
    end
end )
local Backpack = LocalPlayer:FindFirstChildOfClass( "Backpack" )

if Backpack then
    Watch( Backpack )
end

LocalPlayer.CharacterAdded:Connect( function( Argument1 )
    Watch( Argument1 )
    Value1 = nil
    task.defer( Check )
end )

if LocalPlayer.Character then
    Watch( LocalPlayer.Character )
end

task.spawn( function()
    while true do
        task.wait( 2 )
        Check( )
    end
end )
task.defer( Check )
