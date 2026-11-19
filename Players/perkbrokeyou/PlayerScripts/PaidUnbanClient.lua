-- Players.perkbrokeyou.PlayerScripts.PaidUnbanClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local PlayerGui = Players.LocalPlayer:WaitForChild( "PlayerGui" )
local Font2 = Font.new( "rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.ExtraBold )

local function Seq( List )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        table.insert( Table, ColorSequenceKeypoint.new( Value[ 1 ], Color3.fromRGB( Value[ 2 ], Value[ 3 ], Value[ 4 ] ) ) )
    end

    return ColorSequence.new( Table )
end

local Seq2 = Seq( {
    { 0, 68, 60, 34 },
    { 0.218, 24, 22, 15 },
    { 0.509, 8, 8, 8 },
    { 0.785, 22, 20, 14 },
    { 1, 66, 58, 33 }
} )
local Seq3 = Seq( {
    { 0, 68, 60, 34 },
    { 0.275, 177, 157, 88 },
    { 0.543, 255, 226, 126 },
    { 0.784, 182, 162, 90 },
    { 1, 66, 58, 33 }
} )
local Seq4 = Seq( {
    { 0, 22, 66, 34 },
    { 0.3, 90, 190, 110 },
    { 0.543, 150, 255, 170 },
    { 0.75, 90, 190, 110 },
    { 1, 22, 66, 34 }
} )
local Value1 = nil
local Value2 = nil
local Value3 = nil
local Value4 = nil
local Flag = false
local Value5 = nil
local Apply = nil

local function Stroke( Parent, Color, Thickness, Amount )
    local UIStroke = Instance.new( "UIStroke" )
    local Transparency = Amount or 0
    UIStroke.Color = Color
    UIStroke.Thickness = Thickness
    UIStroke.Transparency = Transparency
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round
    pcall( function()
        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    end )
    UIStroke.Parent = Parent
end

local function Build()
    Value1 = Instance.new( "ScreenGui" )
    Value1.Name = "PaidUnbanBanner"
    Value1.ResetOnSpawn = false
    Value1.DisplayOrder = -5
    Value1.IgnoreGuiInset = false
    Value1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Value2 = Instance.new( "TextButton" )
    Value2.Name = "Buy"
    Value2.Text = ""
    Value2.AutoButtonColor = true
    Value2.AnchorPoint = Vector2.new( 0.5, 0 )
    Value2.Position = UDim2.fromScale( 0.5, 0.025 )
    Value2.Size = UDim2.fromScale( 0.14, 0.05 )
    Value2.BackgroundColor3 = Color3.new( 1, 1, 1 )
    Value2.BackgroundTransparency = 0.15
    Value2.Parent = Value1
    Instance.new( "UIAspectRatioConstraint", Value2 ).AspectRatio = 5
    local UISizeConstraint = Instance.new( "UISizeConstraint", Value2 )
    UISizeConstraint.MinSize = Vector2.new( 170, 34 )
    local UICorner = Instance.new( "UICorner", Value2 )
    UICorner.CornerRadius = UDim.new( 0.104, 0 )
    local UIGradient = Instance.new( "UIGradient", Value2 )
    UIGradient.Color = Seq2
    UIGradient.Rotation = 90
    Stroke( Value2, Color3.new( 1, 1, 1 ), 0.0523, 0.9 )
    Stroke( Value2, Color3.new( 0, 0, 0 ), 0.0471, 0 )
    Value3 = Instance.new( "TextLabel" )
    Value3.Name = "Label"
    Value3.BackgroundTransparency = 1
    Value3.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Value3.Position = UDim2.fromScale( 0.5, 0.5 )
    Value3.Size = UDim2.fromScale( 0.86, 0.56 )
    Value3.FontFace = Font2
    Value3.TextScaled = true
    Value3.TextColor3 = Color3.new( 1, 1, 1 )
    Value3.Parent = Value2
    Value4 = Instance.new( "UIGradient", Value3 )
    Value4.Color = Seq3
    Value4.Rotation = 90
    Stroke( Value3, Color3.new( 0, 0, 0 ), 0.0653, 0 )
    Value2.Activated:Connect( function()
        if Flag or PlayerGui:GetAttribute( "PaidUnban" ) ~= "buy" then
            return
        end

        local PaidUnban
        Flag = true
        local Remotes = ReplicatedStorage:FindFirstChild( "Remotes" )

        if Remotes then
            PaidUnban = ReplicatedStorage.Remotes:FindFirstChild( "PaidUnban" )
        else
            PaidUnban = Remotes
        end

        local Success, Result

        if PaidUnban then
            Success, Result = pcall( PaidUnban.InvokeServer, PaidUnban, "buy" )
        else
            Success = false
            Result = nil
        end
        if not Success or type( Result ) ~= "table" or not Result.ok then
            Value5 = "TRY AGAIN"
            Apply( )
            task.delay( 2.5, function()
                Value5 = nil
                Apply( )
            end )
        end

        task.wait( 1 )
        Flag = false
    end )
end

Apply = function()
    local PaidUnban = PlayerGui:GetAttribute( "PaidUnban" )

    if PaidUnban == "buy" or PaidUnban == "done" then
        if not Value1 then
            Build( )
        end
        if Value1.Parent ~= PlayerGui then
            Value1.Parent = PlayerGui
        end

        Value1.Enabled = true

        if PaidUnban == "done" then
            Value3.Text = "UNBANNED!"
            Value4.Color = Seq4
            Value2.Active = false
            Value2.AutoButtonColor = false
            return
        end

        local Number = tonumber( PlayerGui:GetAttribute( "PaidUnbanPrice" ) ) or 2999
        Value3.Text = Value5 or ( "🔓 UNBAN · R$ %d" ):format( Number )
        Value4.Color = Seq3
        Value2.Active = true
        Value2.AutoButtonColor = true
        return
    end
    if Value1 then
        Value1.Enabled = false
    end

    return
end

PlayerGui:GetAttributeChangedSignal( "PaidUnban" ):Connect( Apply )
PlayerGui:GetAttributeChangedSignal( "PaidUnbanPrice" ):Connect( Apply )
Apply( )
