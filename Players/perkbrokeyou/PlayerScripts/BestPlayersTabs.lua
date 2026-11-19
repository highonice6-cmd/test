-- Players.perkbrokeyou.PlayerScripts.BestPlayersTabs
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #6

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Board
local Screen = Object:FindFirstChild( "Screen" )

if Screen then
    Board = Screen:FindFirstChild( "Board" )
else
    Board = Screen
end

local Screen2 = if Board then Board:FindFirstChild( "Window" ) else Board
return Screen2
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Board
local Screen = Self:FindFirstChild( "Screen" )

if Screen then
    Board = Screen:FindFirstChild( "Board" )
else
    Board = Screen
end

local Window

if Board then
    Window = Board:FindFirstChild( "Window" )
else
    Window = Board
end
if not Window then
    return
end
for Key, Value in Window:GetChildren( ) do
    if Value:IsA( "Frame" ) and Value.Name:sub( 1, 5 ) == "Page_" then
        local Visible = Value.Name == "Page_" .. Upvalue1 and true or false
        Value.Visible = Visible
    end
end

local Children
local Tabs = Window:FindFirstChild( "Tabs" )
Children = Tabs and Tabs:GetChildren( ) or { }
local Value1 = nil

for Key2, Value2 in Children, nil, nil do
    if Value2:IsA( "GuiButton" ) then
        local Flag = Value2:GetAttribute( "Page" ) == Upvalue1 and true or false
        local BackgroundColor32

        if Flag then
            local Color = Value2:GetAttribute( "Color" )

            if Color then
                BackgroundColor32 = Color
            elseif Upvalue2 then
                BackgroundColor32 = Upvalue2
            else
                BackgroundColor32 = Upvalue2
            end
        else
            BackgroundColor32 = Upvalue2
        end

        Value2.BackgroundColor3 = BackgroundColor32

        if Value2:IsA( "TextButton" ) then
            local TextTransparency = not Flag and 0.35 or 0
            Value2.TextTransparency = TextTransparency
        end

        local Bord = Value2:FindFirstChild( "Bord" )

        if Bord then
            local Transparency = not Flag and 0.85 or 0.4
            Bord.Transparency = Transparency
        end
    end
end

local Title = Window:FindFirstChild( "Title" )

if Title and Title:IsA( "TextLabel" ) then
    Title.Text = Upvalue1:upper( ) .. " RANKED"
    local Couleur = Title:FindFirstChild( "Couleur" )
    local Entry = Upvalue3[ Upvalue1 ]

    if Couleur and Couleur:IsA( "UIGradient" ) and Entry then
        Couleur.Color = ColorSequence.new( {
            ColorSequenceKeypoint.new( 0, Entry[ 1 ] ),
            ColorSequenceKeypoint.new( 0.5, Entry[ 2 ] ),
            ColorSequenceKeypoint.new( 1, Entry[ 3 ] )
        } )
    end
end

local BackgroundColor3 = Window:GetAttribute( "Accent_" .. Upvalue1 )

if typeof( BackgroundColor3 ) == "Color3" then
    local TitleLine = Window:FindFirstChild( "TitleLine" )

    if TitleLine and TitleLine:IsA( "GuiObject" ) then
        TitleLine.BackgroundColor3 = BackgroundColor3
    end

    local Accent = Self:FindFirstChild( "Accent" )

    if Accent and Accent:IsA( "BasePart" ) then
        Accent.Color = BackgroundColor3
    end
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if type( Argument1 ) ~= "string" or Upvalue1 == Argument1 then
    return
end

Upvalue1 = Argument1

if Upvalue2 and Upvalue2.Parent then
    Upvalue3( Upvalue2 )
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if type( Upvalue1 ) == "string" then
    if Upvalue2 == Upvalue1 then
        return
    end

    Upvalue2 = Upvalue1

    if Upvalue3 and Upvalue3.Parent then
        Upvalue4( Upvalue3 )
    end
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Destroy( )
    Upvalue1 = nil
end

local Board
local Adornee = Self:FindFirstChild( "Screen" )

if Adornee then
    Board = Adornee:FindFirstChild( "Board" )
else
    Board = Adornee
end

local Board2
local Screen = Self:FindFirstChild( "Screen" )

if Screen then
    Board2 = Screen:FindFirstChild( "Board" )
else
    Board2 = Screen
end

local Window

if Board2 then
    Window = Board2:FindFirstChild( "Window" )
else
    Window = Board2
end

local Tabs

if Window then
    Tabs = Window:FindFirstChild( "Tabs" )
else
    Tabs = Window
end
if not Board or not Tabs then
    return false
end

local Parent = Instance.new( "SurfaceGui" )
Parent.Name = "BestPlayersTabsInput"
Parent.ResetOnSpawn = false
Parent.Adornee = Adornee
Parent.Face = Board.Face
Parent.SizingMode = Board.SizingMode
Parent.CanvasSize = Board.CanvasSize
Parent.PixelsPerStud = Board.PixelsPerStud
Parent.ZOffset = ( Board.ZOffset or 0 ) + 1
Parent.LightInfluence = 0
Parent.MaxDistance = 80
local Parent2 = Instance.new( "Frame" )
Parent2.BackgroundTransparency = 1
local Position = Window.Position
local Size = Window.Size
local AnchorPoint = Window.AnchorPoint
Parent2.Position = Position
Parent2.Size = Size
Parent2.AnchorPoint = AnchorPoint
Parent2.Parent = Parent
local Parent3 = Instance.new( "Frame" )
Parent3.BackgroundTransparency = 1
local Position2 = Tabs.Position
local Size2 = Tabs.Size
local AnchorPoint2 = Tabs.AnchorPoint
Parent3.Position = Position2
Parent3.Size = Size2
Parent3.AnchorPoint = AnchorPoint2
Parent3.Parent = Parent2

for Key, Value in Tabs:GetChildren( ) do
    local Page
    local IsA = Value:IsA( "GuiButton" )

    if IsA then
        Page = Value:GetAttribute( "Page" )
    else
        Page = IsA
    end
    if type( Page ) == "string" then
        local TextButton = Instance.new( "TextButton" )
        TextButton.Name = Value.Name
        TextButton.Text = ""
        TextButton.BackgroundTransparency = 1
        TextButton.AutoButtonColor = false
        local Position3 = Value.Position
        local Size3 = Value.Size
        local AnchorPoint3 = Value.AnchorPoint
        TextButton.Position = Position3
        TextButton.Size = Size3
        TextButton.AnchorPoint = AnchorPoint3
        TextButton.Activated:Connect( function()
            if type( Page ) == "string" then
                if Upvalue2 == Page then
                    return
                end

                Upvalue2 = Page

                if Upvalue3 and Upvalue3.Parent then
                    Upvalue4( Upvalue3 )
                end
            end
        end )
        TextButton.Parent = Parent3
    end
end

Parent.Parent = Upvalue5:WaitForChild( "PlayerGui" )
Upvalue1 = Parent
return true
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local TestTab = Upvalue1:GetAttribute( "TestTab" )

if type( TestTab ) == "string" then
    if Upvalue2 == TestTab then
        return
    end

    Upvalue2 = TestTab

    if Upvalue3 and Upvalue3.Parent then
        Upvalue4( Upvalue3 )
    end
end
]]
