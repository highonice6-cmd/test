-- Players.perkbrokeyou.PlayerScripts.HoldGaugeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local CollectionService = game:GetService( "CollectionService" )
local ProximityPromptService = game:GetService( "ProximityPromptService" )
local TweenService = game:GetService( "TweenService" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local LocalPlayer = Players.LocalPlayer

local function RealOf( Object )
    return Object:GetAttribute( "GaugeHoldTime" )
end

local Table = { }

local function Adopt( Key )
    if not Key:IsA( "ProximityPrompt" ) or Key:GetAttribute( "GaugeHoldTime" ) then
        return
    end

    local HoldDuration = Key.HoldDuration

    if HoldDuration <= 0 then
        return
    end

    Key:SetAttribute( "GaugeHoldTime", HoldDuration )

    if not Table[ Key ] then
        Key.HoldDuration = 0
    end
end

CollectionService:GetInstanceAddedSignal( "HoldGauge" ):Connect( Adopt )

for Key, Value in CollectionService:GetTagged( "HoldGauge" ) do
    if Value:IsA( "ProximityPrompt" ) then
        if not Value:GetAttribute( "GaugeHoldTime" ) then
            local HoldDuration = Value.HoldDuration

            if not ( HoldDuration <= 0 ) then
                Value:SetAttribute( "GaugeHoldTime", HoldDuration )

                if not Table[ Value ] then
                    Value.HoldDuration = 0
                end
            end
        end
    end
end

local Value1 = nil

local function GetParts()
    if Value1 and Value1.gui.Parent then
        return Value1
    end

    local HoldGauge
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        HoldGauge = PlayerGui:FindFirstChild( "HoldGauge" )
    else
        HoldGauge = PlayerGui
    end

    local Gauge

    if HoldGauge then
        Gauge = HoldGauge:FindFirstChild( "Gauge" )
    else
        Gauge = HoldGauge
    end
    if not Gauge then
        return nil
    end

    local TextPos
    local Key = Gauge:FindFirstChild( "Key" )
    local Text = Gauge:FindFirstChild( "Text" )
    local Table = { gui = HoldGauge, text = Text }
    TextPos = if Text then Text.Position else Text
    local KeyLabel
    Table.textPos = TextPos
    Table.value = Gauge:FindFirstChild( "Value" )
    Table.key = Key
    KeyLabel = if Key then Key:FindFirstChild( "Label" ) else Key
    local KeyIcon
    Table.keyLabel = KeyLabel
    KeyIcon = if Key then Key:FindFirstChild( "Icon" ) else Key
    Table.keyIcon = KeyIcon
    Table.fill = Gauge:FindFirstChild( "Fill", true )
    Table.scale = Gauge:FindFirstChildOfClass( "UIScale" )
    Value1 = Table
    return Value1
end

local function Pop( Argument1, Argument2, Argument3, Back )
    if Argument1.scale then
        local Scale = Argument1.scale
        TweenService:Create( Scale, TweenInfo.new( Argument3, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Argument2 } ):Play( )
    end
end

local function SetKey( Argument1, Object )
    if not Argument1.key or not Argument1.keyLabel or not Argument1.keyIcon then
        return
    end

    local TouchMode = Controls.TouchMode( )
    local Key = Argument1.key
    Key.Visible = not TouchMode

    if Argument1.text and Argument1.textPos then
        local Number
        local Text = Argument1.text
        Number = if TouchMode then 0.05 else Argument1.textPos.X.Scale
        Text.Position = UDim2.fromScale( Number, Argument1.textPos.Y.Scale )
    end
    if TouchMode then
        return
    end
    if not Controls.IsGamepad then
        Argument1.keyIcon.Visible = false
        Argument1.keyLabel.Visible = true
        local KeyLabel3 = Argument1.keyLabel
        local KeyName = Controls.KeyName
        KeyLabel3.Text = KeyName( Object.KeyboardKeyCode.Name, true )
        return
    end

    local Visible
    local Glyph, Glyph2 = Controls.Glyph( Object.GamepadKeyCode )
    local KeyIcon = Argument1.keyIcon
    KeyIcon.Image = Glyph or ""
    local KeyIcon2 = Argument1.keyIcon
    Visible = Glyph ~= nil and true or false
    local Visible2
    KeyIcon2.Visible = Visible
    local KeyLabel = Argument1.keyLabel
    Visible2 = Glyph == nil and true or false
    KeyLabel.Visible = Visible2
    local KeyLabel2 = Argument1.keyLabel
    KeyLabel2.Text = string.gsub( Glyph2 or "?", "^Button", "" )
end

local Value2 = nil

local function Stop( Flag )
    if not Value2 then
        return
    end

    Value2 = nil

    if Value2.tween then
        Value2.tween:Cancel( )
    end

    local Parts = GetParts( )

    if not Parts then
        return
    end
    if Flag then
        if Parts.fill then
            local Fill = Parts.fill
            Fill.Size = UDim2.fromScale( 1, 1 )
        end

        Pop( Parts, 1.05, 0.08 )
        task.delay( 0.16, function()
            if Value2 then
                return
            end

            Parts.gui.Enabled = false

            if Parts.fill then
                local Fill = Parts.fill
                Fill.Size = UDim2.fromScale( 0, 1 )
            end
        end )
        return
    end
    Parts.gui.Enabled = false

    if Parts.fill then
        local Fill2 = Parts.fill
        Fill2.Size = UDim2.fromScale( 0, 1 )
    end

    return
end

local function Start( Object )
    if Object:HasTag( "NoHoldGauge" ) then
        return
    end

    local GaugeHoldTime = Object:GetAttribute( "GaugeHoldTime" )

    if not GaugeHoldTime or GaugeHoldTime < 0.05 then
        return
    end

    local Parts = GetParts( )

    if not Parts then
        return
    end
    if Value2 then
        Value2 = nil

        if Value2.tween then
            Value2.tween:Cancel( )
        end

        local Parts2 = GetParts( )

        if Parts2 then
            Parts2.gui.Enabled = false

            if Parts2.fill then
                local Fill = Parts2.fill
                Fill.Size = UDim2.fromScale( 0, 1 )
            end
        end
    end

    local Table = { prompt = Object, t0 = os.clock( ), d = GaugeHoldTime }
    Value2 = Table
    SetKey( Parts, Object )

    if Parts.value then
        local ActionText
        local Value = Parts.value
        ActionText = Object.ActionText ~= "" and Object.ActionText or "Interact"
        Value.Text = string.upper( ActionText )
    end
    if Parts.fill then
        local Fill2 = Parts.fill
        Fill2.Size = UDim2.fromScale( 0, 1 )
        Table.tween = TweenService:Create( Parts.fill, TweenInfo.new( GaugeHoldTime, Enum.EasingStyle.Linear ), { Size = UDim2.fromScale( 1, 1 ) } )
        Table.tween:Play( )
    end

    Parts.gui.Enabled = true

    if Parts.scale then
        Parts.scale.Scale = 0.86
    end

    Pop( Parts, 1, 0.2, Enum.EasingStyle.Back )
    task.delay( GaugeHoldTime + 0.6, function()
        if Value2 == Table then
            if not Value2 then
                return
            end

            Value2 = nil

            if Value2.tween then
                Value2.tween:Cancel( )
            end

            local Parts = GetParts( )

            if not Parts then
                return
            end

            Parts.gui.Enabled = false

            if Parts.fill then
                local Fill = Parts.fill
                Fill.Size = UDim2.fromScale( 0, 1 )
            end
        end
    end )
end

ProximityPromptService.PromptShown:Connect( function( Key )
    Table[ Key ] = true
    local GaugeHoldTime = Key:GetAttribute( "GaugeHoldTime" )

    if GaugeHoldTime then
        task.defer( function()
            if Table[ Key ] and Key.Parent then
                Key.HoldDuration = GaugeHoldTime
            end
        end )
        return
    end
    return
end )
ProximityPromptService.PromptHidden:Connect( function( Key )
    Table[ Key ] = nil

    if Key:GetAttribute( "GaugeHoldTime" ) then
        Key.HoldDuration = 0
    end
    if Value2 and Value2.prompt == Key then
        if not Value2 then
            return
        end

        Value2 = nil

        if Value2.tween then
            Value2.tween:Cancel( )
        end

        local Parts = GetParts( )

        if not Parts then
            return
        end

        Parts.gui.Enabled = false

        if Parts.fill then
            local Fill = Parts.fill
            Fill.Size = UDim2.fromScale( 0, 1 )
        end
    end
end )
ProximityPromptService.PromptButtonHoldBegan:Connect( function( Object, Argument2 )
    if Argument2 == LocalPlayer then
        Start( Object )
    end
end )
ProximityPromptService.PromptButtonHoldEnded:Connect( function( Argument1, Argument2 )
    if Argument2 == LocalPlayer and Value2 and Value2.prompt == Argument1 then
        local Flag
        local Clock = os.clock( ) - Value2.t0
        Flag = Value2.d - 0.05 <= Clock and true or false
        Stop( Flag )
    end
end )
ProximityPromptService.PromptTriggered:Connect( function( Argument1, Argument2 )
    if Argument2 == LocalPlayer and Value2 and Value2.prompt == Argument1 then
        Stop( true )
    end
end )
