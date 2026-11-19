-- StarterPlayer.StarterPlayerScripts.ServerMoveClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ReplicatedFirst = game:GetService( "ReplicatedFirst" )
local TweenService = game:GetService( "TweenService" )
local ContextActionService = game:GetService( "ContextActionService" )
local PlayerGui = Players.LocalPlayer:WaitForChild( "PlayerGui" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local ServerMove = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "ServerMove" )
local Value1 = nil
local Number = 0

local function Hide()
    Number = Number + 1
    ClientState.ServerMove = nil
    ContextActionService:UnbindAction( "ServerMoveBlock" )

    if Value1 then
        Value1:Destroy( )
        Value1 = nil
    end
end

local function FadeIn( Object )
    local TweenInfo2 = TweenInfo.new( 0.5 )

    for Key, Value in Object:GetDescendants( ) do
        local Table = { }

        local function Take( Key )
            Table[ Key ] = Value[ Key ]
            Value[ Key ] = 1
        end

        if Value:IsA( "GuiObject" ) then
            Table.BackgroundTransparency = Value.BackgroundTransparency
            Value.BackgroundTransparency = 1
        end
        if Value:IsA( "TextLabel" ) or Value:IsA( "TextButton" ) or Value:IsA( "TextBox" ) then
            Table.TextTransparency = Value.TextTransparency
            Value.TextTransparency = 1
        end
        if Value:IsA( "ImageLabel" ) or Value:IsA( "ImageButton" ) then
            Table.ImageTransparency = Value.ImageTransparency
            Value.ImageTransparency = 1
        end
        if Value:IsA( "UIStroke" ) then
            Table.Transparency = Value.Transparency
            Value.Transparency = 1
        end
        if next( Table ) then
            TweenService:Create( Value, TweenInfo2, Table ):Play( )
        end
    end
end

local function Show()
    if Value1 then
        return
    end

    local LoadingScreen
    local EcranTeleport = ReplicatedFirst:FindFirstChild( "EcranTeleport" )

    if EcranTeleport then
        LoadingScreen = EcranTeleport
    else
        LoadingScreen = ReplicatedFirst:FindFirstChild( "LoadingScreen" )
    end
    if LoadingScreen then
        Number = Number + 1
        ClientState.ServerMove = true
        Value1 = LoadingScreen:Clone( )
        Value1.Name = "EcranDepart"
        Value1.Enabled = true
        Value1.ResetOnSpawn = false
        FadeIn( Value1 )
        Value1.Parent = PlayerGui
        ContextActionService:BindActionAtPriority( "ServerMoveBlock", function()
            return Enum.ContextActionResult.Sink
        end, false, 3000, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Z, Enum.KeyCode.Q, Enum.KeyCode.Space, Enum.KeyCode.ButtonA, Enum.KeyCode.Thumbstick1 )
        task.delay( 25, function()
            if Number == Number then
                Number = Number + 1
                ClientState.ServerMove = nil
                ContextActionService:UnbindAction( "ServerMoveBlock" )

                if Value1 then
                    Value1:Destroy( )
                    Value1 = nil
                end
            end
        end )
        return
    end
    return
end

ServerMove.OnClientEvent:Connect( function( Name )
    if Name == "go" then
        Show( )
        return
    end
    if Name == "cancel" then
        Number = Number + 1
        ClientState.ServerMove = nil
        ContextActionService:UnbindAction( "ServerMoveBlock" )

        if Value1 then
            Value1:Destroy( )
            Value1 = nil
        end
    end
end )
