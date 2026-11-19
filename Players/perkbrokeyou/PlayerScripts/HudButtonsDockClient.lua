-- Players.perkbrokeyou.PlayerScripts.HudButtonsDockClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local UserInputService = game:GetService( "UserInputService" )
local Controls = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Controls" ) )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Frame = PlayerGui:WaitForChild( "HUDButtons", math.huge ):WaitForChild( "Frame" )
local OpenButton = Frame:WaitForChild( "OpenButton" )
local TopDock = Frame:WaitForChild( "TopDock" )
TopDock.Visible = false
local Table = { }
local Table2 = { "OpenButton", "ShopButton", "EffectsButton" }
Value1 = nil

for Key, Value in Table2, nil, nil do
    local Child = OpenButton:WaitForChild( Value, 10 )

    if Child then
        table.insert( Table, { b = Child, home = OpenButton } )
    end
end

local Flag = false

local function Wanted()
    local TouchMode

    if Controls.Settings.HudButtonsTop == true then
        local TouchEnabled = UserInputService.TouchEnabled

        if TouchEnabled then
            TouchMode = TouchEnabled
        else
            TouchMode = Controls.TouchMode( )
        end
    else
        TouchMode = false
    end

    return TouchMode
end

local function SlotOf()
    local TopRight
    local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

    if GlobalGui then
        TopRight = GlobalGui:FindFirstChild( "TopRight" )
    else
        TopRight = GlobalGui
    end

    local GlobalGui2 = if TopRight then TopRight:FindFirstChild( "HudButtonsSlot" ) else TopRight
    return GlobalGui2, GlobalGui
end

local function Apply()
    local TouchMode

    if Controls.Settings.HudButtonsTop == true then
        local TouchEnabled = UserInputService.TouchEnabled

        if TouchEnabled then
            TouchMode = TouchEnabled
        else
            TouchMode = Controls.TouchMode( )
        end
    else
        TouchMode = false
    end
    if TouchMode == Flag then
        return
    end

    local Value1
    Flag = TouchMode
    Value1 = nil

    for Key, Value in Table, nil, nil do
        if Value.b.Parent == Value.home or Value.b.Parent == TopDock then
            local Parent
            local B = Value.b
            Parent = TouchMode and TopDock or Value.home
            B.Parent = Parent
        end
    end

    OpenButton.Visible = not TouchMode

    if not TouchMode then
        local TopRight
        TopDock.Visible = false
        local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

        if GlobalGui then
            TopRight = GlobalGui:FindFirstChild( "TopRight" )
        else
            TopRight = GlobalGui
        end

        local HudButtonsSlot

        if TopRight then
            HudButtonsSlot = TopRight:FindFirstChild( "HudButtonsSlot" )
        else
            HudButtonsSlot = TopRight
        end
        if HudButtonsSlot then
            HudButtonsSlot.Visible = false
        end
    end
end

local function ScaleAbove()
    local Captured, Number
    Captured = Frame
    Number = 1

    while Captured do
        if Captured == PlayerGui then
            break
        end

        local UIScale = Captured:FindFirstChildOfClass( "UIScale" )

        if UIScale then
            Number = Number * UIScale.Scale
        end

        Captured = Captured.Parent
    end

    return Number
end

local function ShownIn( GlobalGui, HudButtonsSlot )
    if not GlobalGui.Enabled then
        return false
    end

    local Parent = HudButtonsSlot.Parent

    while Parent do
        if Parent == GlobalGui then
            break
        end
        if Parent:IsA( "GuiObject" ) and not Parent.Visible then
            return false
        end

        Parent = Parent.Parent
    end

    return true
end

local Value2 = nil
local Value3 = nil
RunService:BindToRenderStep( "HudButtonsDock", Enum.RenderPriority.Last.Value, function()
    if not Flag then
        return
    end

    local TopRight
    local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

    if GlobalGui then
        TopRight = GlobalGui:FindFirstChild( "TopRight" )
    else
        TopRight = GlobalGui
    end

    local HudButtonsSlot

    if TopRight then
        HudButtonsSlot = TopRight:FindFirstChild( "HudButtonsSlot" )
    else
        HudButtonsSlot = TopRight
    end
    if HudButtonsSlot then
        if not HudButtonsSlot.Visible then
            HudButtonsSlot.Visible = true
        end

        local Visible = ShownIn( GlobalGui, HudButtonsSlot )

        if TopDock.Visible ~= Visible then
            TopDock.Visible = Visible
        end
        if not Visible then
            return
        end

        local ScaleAbove2 = ScaleAbove( )

        if ScaleAbove2 <= 0 then
            return
        end

        local AbsolutePosition = ( HudButtonsSlot.AbsolutePosition - Frame.AbsolutePosition ) / ScaleAbove2
        local AbsoluteSize = HudButtonsSlot.AbsoluteSize / ScaleAbove2

        if AbsolutePosition ~= Value2 then
            Value2 = AbsolutePosition
            TopDock.Position = UDim2.fromOffset( AbsolutePosition.X, AbsolutePosition.Y )
        end
        if AbsoluteSize ~= Value3 then
            Value3 = AbsoluteSize
            TopDock.Size = UDim2.fromOffset( AbsoluteSize.X, AbsoluteSize.Y )
        end

        return
    end
    if TopDock.Visible then
        TopDock.Visible = false
    end

    return
end )
Controls.SettingsChanged:Connect( function( Name )
    if Name == nil or Name == "HudButtonsTop" then
        Apply( )
    end
end )
Controls.Changed:Connect( Apply )
UserInputService.LastInputTypeChanged:Connect( Apply )
LocalPlayer:GetAttributeChangedSignal( "ForceTouch" ):Connect( Apply )
task.spawn( function()
    local RankedButton
    local RankedSide = Frame:WaitForChild( "RankedSide", 30 )

    if RankedSide then
        RankedButton = RankedSide:WaitForChild( "RankedButton", 30 )
    else
        RankedButton = RankedSide
    end
    if not RankedButton then
        return
    end

    table.insert( Table, { b = RankedButton, home = RankedSide } )

    if Flag then
        RankedButton.Parent = TopDock
    end
end )
Apply( )
