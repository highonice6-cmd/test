-- Players.perkbrokeyou.PlayerScripts.VehicleLockClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local LockedColor2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ContextActionService = game:GetService( "ContextActionService" )
local ContentProvider = game:GetService( "ContentProvider" )
local TweenService = game:GetService( "TweenService" )
local TextService = game:GetService( "TextService" )
local LocalPlayer = Players.LocalPlayer
local VehicleAction = ReplicatedStorage:WaitForChild( "VehicleSystem" ):WaitForChild( "VehicleAction" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local VehicleLock = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "VehicleLock", math.huge )
VehicleLock.Enabled = false
local LockButton = VehicleLock:WaitForChild( "LockButton" )
local Logo = LockButton:WaitForChild( "Logo" )
local Text = LockButton:WaitForChild( "Text" )
local Key = LockButton:FindFirstChild( "Key" )
local Pop = LockButton:FindFirstChild( "Pop" )
local LockedText = LockButton:GetAttribute( "LockedText" ) or "Locked"
local UnlockedText = LockButton:GetAttribute( "UnlockedText" ) or "Unlocked"
local LockedIcon = LockButton:GetAttribute( "LockedIcon" ) or "rbxassetid://90830135254140"
local UnlockedIcon = LockButton:GetAttribute( "UnlockedIcon" ) or "rbxassetid://140031559257673"
local LockedColor = LockButton:GetAttribute( "LockedColor" )
LockedColor2 = if LockedColor then LockedColor else Text.TextColor3
local UnlockedColor2
local UnlockedColor = LockButton:GetAttribute( "UnlockedColor" )
UnlockedColor2 = if UnlockedColor then UnlockedColor else Color3.fromRGB( 205, 210, 220 )
local TweenInfo2 = TweenInfo.new( 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out )
local Value1 = nil

local function FitText()
    local AbsoluteSize = Text.AbsoluteSize

    if not Value1 or AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        return
    end
    Text.TextScaled = false
    local X = AbsoluteSize.X / Value1.X
    Text.TextSize = math.max( 1, ( math.floor( math.min( X, AbsoluteSize.Y / Value1.Y ) * 100 ) ) )
    return
end

task.spawn( function()
    local Value1Inner, Number, Number2
    local Table = { LockedText, UnlockedText }
    Value1Inner = nil
    Number = 0
    Number2 = 0

    for Key, Value in Table, nil, nil do
        local GetTextBoundsParams = Instance.new( "GetTextBoundsParams" )
        local Font = Text.FontFace
        GetTextBoundsParams.Text = Value
        GetTextBoundsParams.Font = Font
        GetTextBoundsParams.Size = 100
        GetTextBoundsParams.Width = 100000
        local Success, Result = pcall( TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams )

        if not Success then
            return
        end

        Number = math.max( Number, Result.X )
        Number2 = math.max( Number2, Result.Y )
    end

    Value1 = Vector2.new( Number, Number2 )
    local AbsoluteSize = Text.AbsoluteSize

    if Value1 and not ( AbsoluteSize.X <= 0 ) then
        if AbsoluteSize.Y <= 0 then
            return
        end

        Text.TextScaled = false
        local X = AbsoluteSize.X / Value1.X
        Text.TextSize = math.max( 1, ( math.floor( math.min( X, AbsoluteSize.Y / Value1.Y ) * 100 ) ) )
    end
end )
Text:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( FitText )

if Logo:IsA( "ImageLabel" ) then
    task.spawn( function()
        local Image
        local ImageLabel = Instance.new( "ImageLabel" )
        Image = Logo.Image == LockedIcon and UnlockedIcon or LockedIcon
        ImageLabel.Image = Image
        pcall( ContentProvider.PreloadAsync, ContentProvider, { ImageLabel } )
        ImageLabel:Destroy( )
    end )
end

local Value2 = nil

local function CarOf( Object )
    local Model

    if Object then
        Model = Object:FindFirstAncestorWhichIsA( "Model" )
    else
        Model = Object
    end
    while Model do
        if Model:GetAttribute( "OwnerId" ) ~= nil or Model:GetAttribute( "VehicleConfig" ) ~= nil then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end

    return Model
end

local function Render( Argument1 )
    local Flag

    if Value2 == nil then
        Flag = false
    elseif Value2:GetAttribute( "Locked" ) == true then
        Flag = true
    else
        Flag = false
    end

    local ImageColor3 = Flag and LockedColor2 or UnlockedColor2

    if Logo:IsA( "ImageLabel" ) then
        local Image = Flag and LockedIcon or UnlockedIcon
        Logo.Image = Image
        Logo.ImageColor3 = ImageColor3
    else
        local TextInner = Flag and LockedIcon or UnlockedIcon
        Logo.Text = TextInner
    end

    local Text2 = Flag and LockedText or UnlockedText
    Text.Text = Text2
    Text.TextColor3 = ImageColor3

    if Pop and Argument1 then
        Pop.Scale = 1.15
        TweenService:Create( Pop, TweenInfo2, { Scale = 1 } ):Play( )
    end
end

local Number = 0

local function Toggle()
    if not Value2 or os.clock( ) - Number < 0.4 then
        return
    end
    Number = os.clock( )
    VehicleAction:FireServer( "Lock" )
    return
end

LockButton.Activated:Connect( Toggle )
local Flag = false

local function BindKeys()
    ContextActionService:UnbindAction( "VehicleLockToggle" )
    local VehicleLock = Controls.Actions.VehicleLock
    local Table = { }

    if Value2 and VehicleLock then
        local Keys2
        local Keys = VehicleLock.keys
        Keys2 = if Keys then Keys else { }
        local Value1 = nil

        for KeyInner, Value in Keys2, nil, nil do
            table.insert( Table, Value )
        end
        if VehicleLock.mouse then
            table.insert( Table, VehicleLock.mouse )
        end

        local Mice2
        local Mice = VehicleLock.mice
        Mice2 = if Mice then Mice else { }
        local Value2Inner = nil

        for Key2, Value3 in Mice2, nil, nil do
            table.insert( Table, Value3 )
        end
        if Flag then
            local Pad2
            local Pad = VehicleLock.pad
            Pad2 = if Pad then Pad else { }
            local Value4 = nil

            for Key3, Value5 in Pad2, nil, nil do
                table.insert( Table, Value5 )
            end
        end
    end
    if #Table > 0 then
        local function Callback( Argument1, Argument2 )
            if Argument2 == Enum.UserInputState.Begin and Value2 then
                if not ( os.clock( ) - Number < 0.4 ) then
                    Number = os.clock( )
                    VehicleAction:FireServer( "Lock" )
                end
            end

            return Enum.ContextActionResult.Sink
        end

        ContextActionService:BindAction( "VehicleLockToggle", Callback, false, table.unpack( Table ) )
    end
    if Key then
        local Item5

        if Controls.IsGamepad then
            local Item2

            if not Flag or not VehicleLock or not VehicleLock.pad then
                Item2 = nil
            else
                local Item = VehicleLock.pad[ 1 ]

                if Item then
                    Item2 = Item
                else
                    Item2 = nil
                end
            end

            Item5 = Item2
        else
            local Item4

            if not VehicleLock or not VehicleLock.keys then
                Item4 = nil
            else
                local Item3 = VehicleLock.keys[ 1 ]

                if Item3 then
                    Item4 = Item3
                else
                    Item4 = nil
                end
            end

            Item5 = Item4
        end

        local Text

        if Item5 then
            if Controls.IsGamepad then
                local Gsub = Item5.Name:gsub( "^Button", "" )

                if Gsub then
                    Text = Gsub
                else
                    local KeyName = Controls.KeyName
                    local KeyName2 = KeyName( Item5.Name, true )

                    if KeyName2 then
                        Text = KeyName2
                    else
                        Text = ""
                    end
                end
            else
                local KeyName = Controls.KeyName
                local KeyName2 = KeyName( Item5.Name, true )

                if KeyName2 then
                    Text = KeyName2
                else
                    Text = ""
                end
            end
        else
            Text = ""
        end

        local Visible
        Key.Text = Text
        Visible = Item5 ~= nil and true or false
        Key.Visible = Visible
    end
end

Controls.BindsChanged:Connect( BindKeys )
Controls.Changed:Connect( BindKeys )
local Value3 = nil

local function SetCar( Car )
    if Car == Value2 then
        return
    end
    if Value3 then
        Value3:Disconnect( )
        Value3 = nil
    end

    local Enabled
    Value2 = Car
    Enabled = Value2 ~= nil and true or false
    VehicleLock.Enabled = Enabled

    if Value2 then
        Value3 = Value2:GetAttributeChangedSignal( "Locked" ):Connect( function()
            Render( true )
        end )
        Render( false )
    end

    BindKeys( )
end

local function Refresh()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
    local Character3

    if Humanoid then
        if Humanoid.Health > 0 then
            Character3 = CarOf( Character2 )
        else
            Character3 = false
        end
    else
        Character3 = Humanoid
    end

    local FlagInner = LocalPlayer:GetAttribute( "InCarGarage" ) == true and true or false
    local Character4 = if FlagInner or not Character3 or Character3:GetAttribute( "OwnerId" ) ~= LocalPlayer.UserId or not Character3 then nil else Character3
    local Flag2

    if Character4 == nil then
        Flag2 = false
    elseif Character2 == nil then
        Flag2 = false
    else
        local IsA = Character2:IsA( "VehicleSeat" )

        if IsA then
            Flag2 = IsA
        elseif Character2:GetAttribute( "Role" ) == "Driver" then
            Flag2 = true
        else
            Flag2 = false
        end
    end
    if Character4 ~= Value2 then
        Flag = Flag2
        SetCar( Character4 )
        return
    end
    if Flag2 ~= Flag then
        Flag = Flag2
        BindKeys( )
    end
end

local Table = { }

local function Watch( Object )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        Value:Disconnect( )
    end

    local Humanoid
    table.clear( Table )

    if Object then
        Humanoid = Object:WaitForChild( "Humanoid", 10 )
    else
        Humanoid = Object
    end
    if Humanoid and Object == LocalPlayer.Character then
        table.insert( Table, Humanoid:GetPropertyChangedSignal( "SeatPart" ):Connect( Refresh ) )
        table.insert( Table, Humanoid.Died:Connect( Refresh ) )
    end

    Refresh( )
end

LocalPlayer.CharacterAdded:Connect( Watch )
LocalPlayer.CharacterRemoving:Connect( function()
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        Value:Disconnect( )
    end

    table.clear( Table )
    SetCar( nil )
end )
LocalPlayer:GetAttributeChangedSignal( "InCarGarage" ):Connect( Refresh )

if LocalPlayer.Character then
    task.spawn( Watch, LocalPlayer.Character )
end
