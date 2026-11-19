-- Players.perkbrokeyou.PlayerScripts.KillStreakClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Flag
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local LocalPlayer = Players.LocalPlayer
local KillStreak = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "KillStreak" )
local KillStreak2 = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "KillStreak", math.huge )
local Logo = KillStreak2:WaitForChild( "Logo" )
local Pop = Logo:WaitForChild( "Pop" )
local Number = tonumber( Logo:GetAttribute( "Hold" ) ) or 2
local Position = Logo.Position
local Size = Logo.Size

local function InMatch()
    local Flag
    Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false
    return Flag
end

local function Place()
    local Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false
    local MatchPosition2

    if Flag then
        local MatchPosition = Logo:GetAttribute( "MatchPosition" )

        if MatchPosition then
            MatchPosition2 = MatchPosition
        else
            MatchPosition2 = Position
        end
    else
        MatchPosition2 = Position
    end

    local SizeInner
    Position = MatchPosition2

    if Flag then
        local MatchSize = Logo:GetAttribute( "MatchSize" )

        if MatchSize then
            SizeInner = MatchSize
        else
            SizeInner = Size
        end
    else
        SizeInner = Size
    end

    Logo.Size = SizeInner
    Logo.Position = Position
end

Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false
local Position2 = Flag and Logo:GetAttribute( "MatchPosition" ) or Position
local Size2 = Flag and Logo:GetAttribute( "MatchSize" ) or Size
local Number2
Logo.Size = Size2
Logo.Position = Position2
workspace:GetAttributeChangedSignal( "RankedMatch" ):Connect( Place )

local function MatchHome()
    local MatchPosition2
    local MatchPosition = Logo:GetAttribute( "MatchPosition" )
    MatchPosition2 = if MatchPosition then MatchPosition else Position
    local Score
    local RankedMatch = LocalPlayer.PlayerGui:FindFirstChild( "RankedMatch" )

    if RankedMatch then
        Score = RankedMatch:FindFirstChild( "Score" )
    else
        Score = RankedMatch
    end

    local Y = KillStreak2.AbsoluteSize.Y

    if not Score or not Score.Visible or not ( Score.AbsoluteSize.Y > 0 ) or not ( Y > 0 ) then
        return MatchPosition2
    end
    local Y2 = ( Score.AbsolutePosition.Y + Score.AbsoluteSize.Y - KillStreak2.AbsolutePosition.Y ) / Y
    local Scale = MatchPosition2.X.Scale
    local Offset = MatchPosition2.X.Offset
    return UDim2.new( Scale, Offset, Y2 + 0.006, 0 )
end

local Value1 = nil
local TweenInfo2 = TweenInfo.new( 0.1 )
local TweenInfo3 = TweenInfo.new( 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out )
local TweenInfo4 = TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
local TweenInfo5 = TweenInfo.new( 0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out )
local TweenInfo6 = TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In )
local TweenInfo7 = TweenInfo.new( 0.12 )
local TweenInfo8 = TweenInfo.new( 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In )
local Table = { }
local Table2 = { }
Number2 = 0

for Key, Value in Logo:GetChildren( ) do
    local Number4 = tonumber( Value.Name )

    if Number4 and Value:IsA( "ImageLabel" ) then
        Value.Visible = true
        Value.ImageTransparency = 0.999
        Table2[ Number4 ] = Value
        Number2 = math.max( Number2, Number4 )

        for Key2, Value2 in Value:GetChildren( ) do
            if Value2:IsA( "Sound" ) then
                Table[ Value2 ] = Value2.Volume
            end
        end
    end
end

Logo.Visible = true
KillStreak2.Enabled = true

local function ImageFor( Argument1 )
    local Min = math.min( Argument1, Number2 )
    local I = Min

    for I = Min, 2, -1 do
        if Table2[ I ] then
            return Table2[ I ]
        end
    end

    return nil
end

local Table3 = { }
local Table4 = { }

local function CutSounds( Argument1 )
    local Value1 = nil

    for Value in Table3, nil, nil do
        local Create = TweenService:Create( Value, Argument1, { Volume = 0 } )
        Table4[ Value ] = Create
        Create.Completed:Connect( function( Argument1 )
            if Argument1 == Enum.PlaybackState.Completed and Table4[ Value ] == Create then
                Table4[ Value ] = nil
                Value:Stop( )
            end
        end )
        Create:Play( )
    end

    table.clear( Table3 )
end

local function PlaySounds( Object )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "Sound" ) and Value.SoundId ~= "" then
            local Entry = Table4[ Value ]

            if Entry then
                Table4[ Value ] = nil
                Entry:Cancel( )
            end

            local Volume
            local Entry2 = Table[ Value ]
            Volume = if Entry2 then Entry2 else Value.Volume
            Value.Volume = Volume
            Value.TimePosition = 0
            Value:Play( )
            Table3[ Value ] = true
        end
    end
end

local Number3 = 0
local Table5 = { }

local function Play( Argument1, Argument2, Argument3 )
    local Create = TweenService:Create( Argument1, Argument2, Argument3 )
    table.insert( Table5, Create )
    Create:Play( )
end

local function StopTweens()
    local Value1 = nil

    for Key, Value in Table5, nil, nil do
        Value:Cancel( )
    end

    table.clear( Table5 )
end

KillStreak.OnClientEvent:Connect( function( p1 )
    -- Could not structure function #10
end )
task.spawn( function()
    Value1 = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "RankedMatch", math.huge ):WaitForChild( "Annonce", 60 )

    if Value1 then
        Value1:GetPropertyChangedSignal( "Visible" ):Connect( function()
            if Value1.Visible then
                local Flag = workspace:GetAttribute( "RankedMatch" ) ~= nil and true or false

                if Flag then
                    local Value1Inner = nil

                    for Key, Value in Table5, nil, nil do
                        Value:Cancel( )
                    end

                    local Value2
                    table.clear( Table5 )
                    Value2 = nil

                    for Key2, Value3 in Table2, nil, nil do
                        Value3.ImageTransparency = 0.999
                    end
                end
            end
        end )
        return
    end
    return
end )
Controls.SettingsChanged:Connect( function( Name, Argument2 )
    if Argument2 ~= false then
        return
    end
    if Name == "KillStreakLogo" then
        local Value1 = nil

        for Key, Value in Table5, nil, nil do
            Value:Cancel( )
        end

        local Value2
        table.clear( Table5 )
        Value2 = nil

        for Key2, Value3 in Table2, nil, nil do
            Value3.ImageTransparency = 0.999
        end

        return
    end
    if Name == "KillStreakSound" then
        CutSounds( TweenInfo7 )
    end

    return
end )

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    local Create = Upvalue5:Create( Upvalue3, Upvalue4, { Scale = 0.85 } )
    table.insert( Upvalue6, Create )
    Create:Play( )
    local Create2 = Upvalue5:Create( Upvalue7, Upvalue4, { ImageTransparency = 0.999 } )
    table.insert( Upvalue6, Create2 )
    Create2:Play( )
    Upvalue8( Upvalue9 )
    return
end
return
]]
