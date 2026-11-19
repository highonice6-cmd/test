-- StarterPlayer.StarterPlayerScripts.LevelUpClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local LocalPlayer = Players.LocalPlayer
local LevelUp = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "LevelUp" )
local Banner = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "LevelUp", math.huge ):WaitForChild( "Banner" )
local Level = Banner:WaitForChild( "Level" )
local UIScale = Banner:FindFirstChildOfClass( "UIScale" )
local Position = Banner.Position
local Position2 = Position - UDim2.fromScale( 0, 0.12 )
local Table = { }

local function Collect( Object )
    if Object:IsA( "TextLabel" ) or Object:IsA( "TextButton" ) or Object:IsA( "TextBox" ) then
        table.insert( Table, { Object, "TextTransparency", Object.TextTransparency } )
    end
    if Object:IsA( "ImageLabel" ) or Object:IsA( "ImageButton" ) then
        table.insert( Table, { Object, "ImageTransparency", Object.ImageTransparency } )
    end
    if Object:IsA( "GuiObject" ) and Object.BackgroundTransparency < 1 then
        table.insert( Table, { Object, "BackgroundTransparency", Object.BackgroundTransparency } )
    end
    if Object:IsA( "UIStroke" ) then
        table.insert( Table, { Object, "Transparency", Object.Transparency } )
    end
    for Key, Value in Object:GetChildren( ) do
        Collect( Value )
    end
end

Collect( Banner )
local NumberValue = Instance.new( "NumberValue" )

local function SetFade( Fade )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        Value[ 1 ][ Value[ 2 ] ] = Value[ 3 ] + ( 1 - Value[ 3 ] ) * Fade
    end
end

NumberValue.Changed:Connect( SetFade )
Banner.Visible = false
local Sound = Instance.new( "Sound" )
Sound.Name = "LevelUpSound"
Sound.SoundId = "rbxassetid://112485797063762"
Sound.Volume = 0.35
Sound.Parent = game:GetService( "SoundService" )
local Table2 = { }
local Flag = false

local function Tween( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Create = TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out ), Argument3 )
    Create:Play( )
    return Create
end

local function Play()
    if Flag then
        return
    end

    Flag = true

    while #Table2 > 0 do
        local Value1
        Level.Text = "LEVEL " .. tostring( ( table.remove( Table2, 1 ) ) )
        Banner.Position = Position2
        Banner.Visible = true
        NumberValue.Value = 1
        Value1 = nil

        for Key, Value in Table, nil, nil do
            Value[ 1 ][ Value[ 2 ] ] = Value[ 3 ] + ( 1 - Value[ 3 ] ) * 1
        end
        if UIScale then
            UIScale.Scale = 0.9
        end

        local TableInner = { Position = Position }
        TweenService:Create( Banner, TweenInfo.new( 0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), TableInner ):Play( )
        local Table2Inner = { Value = 0 }
        TweenService:Create( NumberValue, TweenInfo.new( 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table2Inner ):Play( )
        Sound.TimePosition = 0
        Sound:Play( )

        if UIScale then
            local Table3 = { Scale = 1 }
            TweenService:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), Table3 ):Play( )
        end

        task.wait( 2.85 )
        local Table4 = { Value = 1 }
        TweenService:Create( NumberValue, TweenInfo.new( 0.4, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out ), Table4 ):Play( )
        local Table5 = { Position = Position2 }
        local Create = TweenService:Create( Banner, TweenInfo.new( 0.4, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out ), Table5 )
        Create:Play( )
        Create.Completed:Wait( )
        Banner.Visible = false
    end

    Flag = false
end

LevelUp.OnClientEvent:Connect( function( Argument1 )
    if type( Argument1 ) == "number" then
        table.insert( Table2, Argument1 )
        task.spawn( Play )
        return
    end
    return
end )
