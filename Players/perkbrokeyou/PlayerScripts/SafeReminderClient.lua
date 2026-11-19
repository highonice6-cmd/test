-- Players.perkbrokeyou.PlayerScripts.SafeReminderClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local LootShared = require( ReplicatedStorage:WaitForChild( "LootShared" ) )
local LocalPlayer = Players.LocalPlayer
local Box = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "SafeReminder", math.huge ):WaitForChild( "Box" )
local Title = Box:WaitForChild( "Title" )
local Sub = Box:WaitForChild( "Sub" )
local Text = Sub.Text
local Class = setmetatable( { }, { __mode = "k" } )
local Number = 0
local Flag = false
local Flag2 = false
local Flag3 = false

local function Scan()
    local Value1, Flag, Flag2Inner, Flag3Inner
    local Table = {
        LocalPlayer:FindFirstChildOfClass( "Backpack" ),
        LocalPlayer.Character
    }
    Value1 = nil
    Flag = false
    Flag2Inner = false
    Flag3Inner = false

    for Key, Value in Table, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value2 = nil

        for Key2, Value3 in Children, nil, nil do
            if Value3:IsA( "Tool" ) and LootShared.Losable( Value3 ) then
                local Flag4 = Value3:GetAttribute( "Item" ) ~= nil and true or false

                if Flag4 then
                    Flag2Inner = true
                else
                    Flag = true
                end
                if not Class[ Value3 ] then
                    Class[ Value3 ] = true

                    if Flag4 then
                        Flag3 = true
                        Flag3Inner = true
                    else
                        Flag2 = true
                        Flag3Inner = true
                    end
                end
            end
        end
    end

    return Flag, Flag2Inner, Flag3Inner
end

local Number2 = 0
RunService.Heartbeat:Connect( function( Argument1 )
    Number2 = Number2 + Argument1

    if Box.Visible then
        Title.TextTransparency = ( math.sin( os.clock( ) * 4 ) * 0.5 + 0.5 ) * 0.15
    end
    if Number2 < 0.2 then
        return
    end

    local FlagInner
    Number2 = 0
    local Value1, Value2, Value3 = Scan( )
    FlagInner = LocalPlayer:GetAttribute( "InWardrobe" ) == true and true or false

    if Value3 then
        if FlagInner then
            Flag = true
        else
            Number = os.clock( ) + 5
        end
    end
    if Flag and not FlagInner then
        Flag = false
        Number = os.clock( ) + 5
    end

    local Visible

    if os.clock( ) < Number then
        if Value1 or Value2 then
            Visible = not FlagInner
        else
            Visible = Value2
        end
    else
        Visible = false
    end
    if Box.Visible ~= Visible then
        Box.Visible = Visible
    end
    if not Visible then
        Flag2 = false
        Flag3 = false
        return
    end

    local TextInner
    local Captured = Flag2 and Value1
    local Captured2 = Flag3 and Value2

    if not Captured or not Captured2 then
        if Captured then
            TextInner = "PUT YOUR WEAPON IN YOUR SAFE INVENTORY"
        elseif Captured2 then
            TextInner = "PUT YOUR CASH BAG IN YOUR SAFE INVENTORY"
        elseif Value1 then
            TextInner = "PUT YOUR WEAPON IN YOUR SAFE INVENTORY"
        else
            TextInner = "PUT YOUR CASH BAG IN YOUR SAFE INVENTORY"
        end
    else
        TextInner = "PUT YOUR ITEMS IN YOUR SAFE INVENTORY"
    end

    local Flag2Inner
    Title.Text = TextInner
    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if type( CombatUntil ) == "number" then
        if workspace:GetServerTimeNow( ) < CombatUntil then
            Flag2Inner = true
        else
            Flag2Inner = false
        end
    else
        Flag2Inner = false
    end

    local Text2 = if Flag2Inner then "You're in combat: you can't protect it until the fight is over" else Text
    local TextColor3
    Sub.Text = Text2

    if Flag2Inner then
        local FromRGB = Color3.fromRGB( 255, 120, 120 )

        if FromRGB then
            TextColor3 = FromRGB
        else
            TextColor3 = Color3.fromRGB( 255, 225, 225 )
        end
    else
        TextColor3 = Color3.fromRGB( 255, 225, 225 )
    end

    Sub.TextColor3 = TextColor3
end )
