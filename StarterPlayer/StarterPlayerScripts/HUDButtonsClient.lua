-- StarterPlayer.StarterPlayerScripts.HUDButtonsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local OpenButton2
local Players = game:GetService( "Players" )
local TweenService = game:GetService( "TweenService" )
local GamepadNav = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "GamepadNav" ) )
local TweenInfo2 = TweenInfo.new( 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out )
local PlayerGui = Players.LocalPlayer:WaitForChild( "PlayerGui" )
local Parent = PlayerGui:WaitForChild( "HUDButtons", math.huge )
Parent.Enabled = true
local Frame = Parent:WaitForChild( "Frame" )
local OpenButton = Frame:WaitForChild( "OpenButton" )

if OpenButton:IsA( "GuiButton" ) then
    OpenButton2 = OpenButton
else
    OpenButton2 = OpenButton:WaitForChild( "OpenButton" )
end

local BindableEvent
local Background = Frame:WaitForChild( "Background" )
local Flag = false
local Callback = nil

local function Place( Argument1 )
    if Callback then
        Callback( )
    end
    if not Flag and GamepadNav.IsOpen( "HudPanel" ) then
        GamepadNav.Close( "HudPanel" )
    end

    local OpenX2
    local Position = Frame.Position

    if Flag then
        local OpenX = Frame:GetAttribute( "OpenX" )

        if OpenX then
            OpenX2 = OpenX
        else
            OpenX2 = 1
        end
    else
        OpenX2 = Frame:GetAttribute( "ClosedX" ) or 1.116
    end

    local BackgroundTransparency
    local Position2 = UDim2.new( OpenX2, Position.X.Offset, Position.Y.Scale, Position.Y.Offset )

    if Flag then
        local OpenTransparency = Background:GetAttribute( "OpenTransparency" )

        if OpenTransparency then
            BackgroundTransparency = OpenTransparency
        else
            BackgroundTransparency = 0.25
        end
    else
        BackgroundTransparency = Background:GetAttribute( "ClosedTransparency" ) or 1
    end
    if Argument1 then
        TweenService:Create( Frame, TweenInfo2, { Position = Position2 } ):Play( )
        TweenService:Create( Background, TweenInfo2, { BackgroundTransparency = BackgroundTransparency } ):Play( )
        return
    end
    Frame.Position = Position2
    Background.BackgroundTransparency = BackgroundTransparency
    return
end

Place( false )
OpenButton2.Activated:Connect( function()
    Flag = not Flag
    Place( true )
end )
local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local Flag2 = false
RunService.Heartbeat:Connect( function()
    local FlagInner = ClientState.Equipped == true and true or false

    if FlagInner and not Flag2 and Flag and Controls.TouchMode( ) then
        Flag = false
        Place( true )
    end

    Flag2 = FlagInner
end )
local UserInputService = game:GetService( "UserInputService" )
Controls.OnInputBegan( function( Argument1, Argument2 )
    if Argument2 or ClientState.Spectating == true then
        return
    end
    if Controls.Is( "HudMenu", Argument1 ) then
        Flag = not Flag
        Place( true )
    end
end )
local ClosePanel = Parent:FindFirstChild( "ClosePanel" )

if ClosePanel then
    BindableEvent = ClosePanel
else
    BindableEvent = Instance.new( "BindableEvent" )
end

local Label
BindableEvent.Name = "ClosePanel"
BindableEvent.Parent = Parent
BindableEvent.Event:Connect( function()
    if Flag and not Controls.IsGamepad then
        Flag = false
        Place( true )
    end
end )
local ShopButton = Frame:FindFirstChild( "ShopButton", true )
local EffectsButton = Frame:FindFirstChild( "EffectsButton", true )
local Table = { }
local Table2 = { label = OpenButton2:FindFirstChild( "Key" ), action = "HudMenu" }
local Table3 = { action = "Shop" }
Label = if ShopButton then ShopButton:FindFirstChild( "Key" ) else ShopButton
local Label2
Table3.label = Label
local Table4 = { action = "Effects" }
Label2 = if EffectsButton then EffectsButton:FindFirstChild( "Key" ) else EffectsButton
Table4.label = Label2
Table[ 1 ] = Table2
Table[ 2 ] = Table3
Table[ 3 ] = Table4

local function ShowKeys()
    local IsGamepad2
    local IsGamepad = Controls.IsGamepad
    IsGamepad2 = if IsGamepad then IsGamepad else Controls.TouchMode( )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        local Label = Value.label

        if Label then
            if Label:IsA( "TextLabel" ) or Label:IsA( "TextButton" ) then
                if Label:GetAttribute( "BaseText" ) == nil then
                    Label:SetAttribute( "BaseText", Label.Text )
                end

                local Text
                local Binds = Controls.Binds
                local Binds2 = Binds( "kbm", Value.action )
                local IsDefaultBind = Controls.IsDefaultBind

                if not IsDefaultBind( "kbm", Value.action ) or not ( #Binds2 > 0 ) or not Label:GetAttribute( "BaseText" ) then
                    local KeyName = Controls.KeyName
                    Text = KeyName( Binds2[ 1 ], true )
                else
                    Text = Label:GetAttribute( "BaseText" )
                end

                local Visible
                Label.Text = Text
                local NotIsGamepad = not IsGamepad2

                if NotIsGamepad then
                    if #Binds2 > 0 then
                        Visible = true
                    else
                        Visible = false
                    end
                else
                    Visible = NotIsGamepad
                end

                Label.Visible = Visible
            end
        end
    end
end

Controls.BindsChanged:Connect( ShowKeys )
Controls.Changed:Connect( ShowKeys )
UserInputService.LastInputTypeChanged:Connect( ShowKeys )
ShowKeys( )
local Get = require( ReplicatedStorage:WaitForChild( "Screens" ) ).Get( "ShopMenu", 30 )
local FromRGB = Color3.fromRGB( 235, 235, 240 )

Callback = function()
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        local Label = Value.label

        if Label then
            if Label:IsA( "TextLabel" ) or Label:IsA( "TextButton" ) then
                if Label:GetAttribute( "IdleColor" ) == nil then
                    Label:SetAttribute( "IdleColor", Label.TextColor3 )
                end

                local Captured

                if Value.action == "HudMenu" then
                    Captured = Flag
                elseif Value.action == "Effects" then
                    if ClientState.EffectsOpen == true then
                        Captured = true
                    else
                        Captured = false
                    end
                else
                    local FlagInner = if Get == nil then false else Get.Visible
                    Captured = FlagInner
                end

                local TextColor3

                if not Captured or not Label:GetAttribute( "ActiveColor" ) then
                    TextColor3 = Label:GetAttribute( "IdleColor" )
                else
                    TextColor3 = Label:GetAttribute( "ActiveColor" )
                end
                if Captured and typeof( TextColor3 ) ~= "Color3" then
                    TextColor3 = FromRGB
                end
                if typeof( TextColor3 ) == "Color3" and Label.TextColor3 ~= TextColor3 then
                    Label.TextColor3 = TextColor3
                end
            end
        end
    end
end

if Get then
    Get:GetPropertyChangedSignal( "Visible" ):Connect( Callback )
end

local New = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) ).new( )
New:setName( "HudMenu" )
New:setLabel( " " )
New:setCaption( "Menu" )
New:setOrder( 4 )
local Frame2 = OpenButton2:FindFirstChild( "Frame" )
local Parent2 = New:getInstance( "IconSpot" )

if Frame2 and Parent2 then
    local Parent3 = Frame2:Clone( )
    Parent3.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Parent3.Position = UDim2.fromScale( 0.5, 0.5 )
    Parent3.Size = UDim2.fromScale( 0.7, 0.7 )
    local UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = Parent3
    Parent3.Parent = Parent2
end

New.selected:Connect( function()
    task.defer( function()
        if New.isSelected then
            New:deselect( )
        end
    end )
    Flag = true
    Place( true )
    GamepadNav.Open( "HudPanel", {
        root = Frame,
        first = function()
            return ShopButton or OpenButton2
        end,
        backLabel = "Close",
        onBack = function()
            Flag = false
            Place( true )
        end
    } )
end )
local LocalPlayer = Players.LocalPlayer
local Value1 = nil
RunService.Heartbeat:Connect( function()
    local Flag

    if Controls.IsGamepad == true then
        if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end
    if Flag ~= Value1 then
        Value1 = Flag
        pcall( function()
            New:setEnabled( Flag )
        end )
    end
end )
task.spawn( function()
    local EffectsMenu = PlayerGui:WaitForChild( "EffectsMenu", 60 )

    if EffectsMenu then
        EffectsMenu:GetPropertyChangedSignal( "Enabled" ):Connect( Callback )
    end
end )
Callback( )
local LocalPlayer2 = Players.LocalPlayer
local HudNotifSeen = ReplicatedStorage:WaitForChild( "HudNotifSeen", 30 )
local Notificiation = OpenButton2:FindFirstChild( "Notificiation" )
local Btns = Frame:WaitForChild( "Btns" )
local Class = setmetatable( { }, { __mode = "k" } )
local Class2 = setmetatable( { }, { __mode = "k" } )
local Table5 = { }

local function Seen( Key )
    if Table5[ Key ] then
        return true
    end

    local SeenNotifs = LocalPlayer2:GetAttribute( "SeenNotifs" )

    if type( SeenNotifs ) ~= "string" then
        return true
    end

    local Flag = table.find( SeenNotifs:split( "," ), Key ) ~= nil and true or false
    return Flag
end

local function Paint( Self )
    local Notificiation = Self:FindFirstChild( "Notificiation" )

    if not Notificiation or not Notificiation:IsA( "GuiObject" ) then
        return
    end

    local Visible
    local NotifKey = Self:GetAttribute( "NotifKey" )

    if type( NotifKey ) == "string" then
        if NotifKey == "" then
            Visible = false
        else
            Visible = true
        end
    else
        Visible = false
    end
    if Notificiation.Visible ~= Visible then
        Notificiation.Visible = Visible
    end
end

local function RefreshOpen()
    if not Notificiation then
        return
    end

    local Visible = false

    for Key, Value in Btns:GetChildren( ) do
        if Value:IsA( "GuiObject" ) and Value.Visible then
            local Value1
            local Table = { "Notificiation", "Count" }
            Value1 = nil

            for Key2, Value2 in Table, nil, nil do
                local FoundChild = Value:FindFirstChild( Value2 )

                if FoundChild and FoundChild:IsA( "GuiObject" ) and FoundChild.Visible then
                    Visible = true
                end
            end
        end
    end
    if Notificiation.Visible ~= Visible then
        Notificiation.Visible = Visible
    end
end

local function MarkSeen( Self )
    local NotifKey = Self:GetAttribute( "NotifKey" )

    if type( NotifKey ) == "string" and NotifKey ~= "" then
        local Flag

        if Table5[ NotifKey ] then
            Flag = true
        else
            local SeenNotifs = LocalPlayer2:GetAttribute( "SeenNotifs" )

            if type( SeenNotifs ) == "string" then
                if table.find( SeenNotifs:split( "," ), NotifKey ) == nil then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = true
            end
        end
        if not Flag then
            Table5[ NotifKey ] = true
            Paint( Self )
            RefreshOpen( )

            if HudNotifSeen then
                HudNotifSeen:FireServer( NotifKey )
            end

            return
        end
    end
end

local function Track( Self )
    if Class[ Self ] or not Self:IsA( "GuiButton" ) or Self == OpenButton2 then
        return
    end
    Class[ Self ] = true
    Self.Activated:Connect( function()
        MarkSeen( Self )
    end )
    Self:GetAttributeChangedSignal( "NotifKey" ):Connect( function()
        Paint( Self )
        RefreshOpen( )
    end )
    Self:GetPropertyChangedSignal( "Visible" ):Connect( RefreshOpen )
    Paint( Self )
    return
end

local function Watch( Key )
    if not Class2[ Key ] and Key:IsA( "GuiObject" ) then
        if Key.Name == "Notificiation" or Key.Name == "Count" then
            if Key:IsDescendantOf( Btns ) then
                Class2[ Key ] = true
                Key:GetPropertyChangedSignal( "Visible" ):Connect( RefreshOpen )
                return
            end
            return
        end
    end
end

local function Added( Self )
    Track( Self )
    Watch( Self )

    if Self.Name == "Notificiation" and Self.Parent and Class[ Self.Parent ] then
        Paint( Self.Parent )
    end
end

for Key, Value in Frame:GetDescendants( ) do
    Track( Value )
    Watch( Value )

    if Value.Name == "Notificiation" and Value.Parent and Class[ Value.Parent ] then
        Paint( Value.Parent )
    end
end

local BindableEvent2
Frame.DescendantAdded:Connect( function( Self )
    Track( Self )
    Watch( Self )

    if Self.Name == "Notificiation" and Self.Parent and Class[ Self.Parent ] then
        Paint( Self.Parent )
    end

    RefreshOpen( )
end )
Frame.DescendantRemoving:Connect( function()
    task.defer( RefreshOpen )
end )
LocalPlayer2:GetAttributeChangedSignal( "SeenNotifs" ):Connect( function()
    local Value1 = nil

    for Value in Class, nil, nil do
        Paint( Value )
    end

    RefreshOpen( )
end )
RefreshOpen( )
local NotifSeen = Parent:FindFirstChild( "NotifSeen" )

if NotifSeen then
    BindableEvent2 = NotifSeen
else
    BindableEvent2 = Instance.new( "BindableEvent" )
end

BindableEvent2.Name = "NotifSeen"
BindableEvent2.Parent = Parent
BindableEvent2.Event:Connect( function( Self )
    if typeof( Self ) == "Instance" and Self:IsA( "GuiButton" ) then
        MarkSeen( Self )
    end
end )
