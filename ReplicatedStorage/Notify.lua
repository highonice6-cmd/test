-- ReplicatedStorage.Notify
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local TweenService = game:GetService( "TweenService" )
local RunService = game:GetService( "RunService" )
local GuiService = game:GetService( "GuiService" )
local LocalPlayer = Players.LocalPlayer
local Screens = require( script.Parent:WaitForChild( "Screens" ) )

local function Root()
    local Find2
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        local Find = Screens.Find
        Find2 = Find( "Notifications", LocalPlayer.PlayerGui )
    else
        Find2 = PlayerGui
    end

    return Find2
end

local function HotbarTop( Y )
    local Hotbar
    local Inventory = LocalPlayer.PlayerGui:FindFirstChild( "Inventory" )

    if Inventory then
        local Enabled = Inventory.Enabled

        if Enabled then
            Hotbar = Inventory:FindFirstChild( "Hotbar" )
        else
            Hotbar = Enabled
        end
    else
        Hotbar = Inventory
    end
    if not Hotbar or not Hotbar.Visible or Y <= 0 then
        return nil
    end

    local Number = math.huge

    for Key, Value in Hotbar:GetChildren( ) do
        local Tile
        local IsA = Value:IsA( "GuiObject" )

        if IsA then
            local Visible = Value.Visible

            if Visible then
                Tile = Value:FindFirstChild( "Tile" )
            else
                Tile = Visible
            end
        else
            Tile = IsA
        end
        if Tile and Tile:IsA( "GuiObject" ) and Tile.AbsoluteSize.Y > 2 then
            Number = math.min( Number, Tile.AbsolutePosition.Y )
        end
    end
    if Number == math.huge then
        Number = Hotbar.AbsolutePosition.Y
    end
    if not Inventory.IgnoreGuiInset then
        Number = Number + GuiService:GetGuiInset( ).Y
    end

    return Number / Y
end

local Value1 = nil
local NumberValue = Instance.new( "NumberValue" )
local Number = 0
local Number2 = 0
local Number3 = 0
RunService.RenderStepped:Connect( function()
    if not Value1 or not Value1.Parent or not Value1.Visible then
        return
    end

    local Number2Inner
    local Y = Value1.Parent.AbsoluteSize.Y
    local NumberInner = HotbarTop( Y ) or 0.9
    local Clock = os.clock( )

    if Clock < Number then
        local Clock2 = ( Clock - Number2 ) / ( Number - Number2 )
        Number2Inner = math.sin( Clock2 * 3.141592653589793 * 6 ) * 0.008 * ( 1 - Clock2 )
    else
        Number2Inner = 0
    end

    local Flag
    local HealthBar = LocalPlayer.PlayerGui:FindFirstChild( "HealthBar" )

    if not HealthBar or not HealthBar.Enabled then
        Flag = false
    else
        Flag = false

        for Key, Value in HealthBar:GetChildren( ) do
            if Value:IsA( "Frame" ) and Value.Visible then
                local Y2 = Value.AbsolutePosition.Y

                if Y * 0.5 < Y2 then
                    Flag = true
                end
            end
        end
    end

    local Number4
    local Number3 = Number2Inner + 0.5
    Number4 = not Flag and 0.035 or 0.075
    Value1.Position = UDim2.fromScale( Number3, ( math.max( NumberInner - Number4 + NumberValue.Value, 0.2 ) ) )
end )

local function Error( Text )
    local Parent
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        local Find = Screens.Find
        Parent = Find( "Notifications", LocalPlayer.PlayerGui )
    else
        Parent = PlayerGui
    end

    local ErrorToast

    if Parent then
        ErrorToast = Parent:FindFirstChild( "ErrorToast" )
    else
        ErrorToast = Parent
    end
    if not ErrorToast or type( Text ) ~= "string" or Text == "" then
        return
    end

    local Captured
    Number3 = Number3 + 1

    if Value1 then
        local Parent2 = Value1.Parent

        if Parent2 then
            Captured = Value1.Visible
        else
            Captured = Parent2
        end
    else
        Captured = Value1
    end
    if not Value1 or not Value1.Parent then
        Value1 = ErrorToast:Clone( )
        Value1.Name = "ErrorToastLive"
        Value1.Parent = Parent
    end

    local Message = Value1:FindFirstChild( "Message", true )

    if Message then
        Message.Text = Text
    end

    Value1.Visible = true

    if Captured then
        local Clock = os.clock( )
        local Clock2 = os.clock( ) + 0.35
        Number2 = Clock
        Number = Clock2
        Value1.GroupTransparency = 0
        NumberValue.Value = 0
    else
        Value1.GroupTransparency = 1
        NumberValue.Value = 0.02
        TweenService:Create( Value1, TweenInfo.new( 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { GroupTransparency = 0 } ):Play( )
        TweenService:Create( NumberValue, TweenInfo.new( 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Value = 0 } ):Play( )
    end

    task.delay( 2.6, function()
        if Number3 ~= Number3 or not Value1 then
            return
        end

        TweenService:Create( Value1, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), { GroupTransparency = 1 } ):Play( )
        TweenService:Create( NumberValue, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), { Value = 0.015 } ):Play( )
        task.wait( 0.32 )

        if Number3 == Number3 and Value1.Parent then
            Value1.Visible = false
        end
    end )
end

local Table2 = { }
local Table3 = { 0, 0.3, 0.6, 0.85 }
local Value2 = nil

local function PlacePickups( Amount )
    if #Table2 == 0 then
        if Value2 then
            Value2:Disconnect( )
            Value2 = nil
        end

        return
    end
    local Parent = Table2[ 1 ].c.Parent

    if not Parent then
        return
    end

    local Y = Parent.AbsoluteSize.Y
    local Number = ( HotbarTop( Y ) or 0.9 ) - 0.085
    local Y2 = Table2[ 1 ].c.AbsoluteSize.Y / math.max( Y, 1 ) + 0.006
    local Dead = os.clock( )
    local Exp = 1 - math.exp( -( Amount or 0.016666666666666666 ) * 14 )
    local Count = #Table2
    local I = Count

    for I = Count, 1, -1 do
        local Entry = Table2[ I ]

        if not Entry.dead then
            if Dead - Entry.born >= 2.2 or I > 4 then
                Entry.dead = Dead
            end
        end

        local Clamp3
        local Clamp = math.clamp( ( Dead - Entry.born ) / 0.18, 0, 1 )

        if Entry.dead then
            local Clamp2 = math.clamp( 1 - ( Dead - Entry.dead ) / 0.35, 0, 1 )

            if Clamp2 then
                Clamp3 = Clamp2
            else
                Clamp3 = 1
            end
        else
            Clamp3 = 1
        end
        if Clamp3 <= 0 then
            Entry.c:Destroy( )
            table.remove( Table2, I )
        else
            local Y4
            local Number2 = Number - ( I - 1 ) * Y2

            if Entry.y then
                local Y3 = Entry.y + ( Number2 - Entry.y ) * Exp

                if Y3 then
                    Y4 = Y3
                else
                    Y4 = Number2 + 0.02
                end
            else
                Y4 = Number2 + 0.02
            end

            local Fade2
            Entry.y = Y4
            local Entry2 = Table3[ I ] or 1

            if Entry.fade then
                local Fade = Entry.fade + ( Entry2 - Entry.fade ) * Exp

                if Fade then
                    Fade2 = Fade
                else
                    Fade2 = Entry2
                end
            else
                Fade2 = Entry2
            end

            Entry.fade = Fade2
            local C = Entry.c
            C.Position = UDim2.fromScale( 0.5, ( math.max( Entry.y, 0.2 ) ) )
            local C2 = Entry.c
            C2.GroupTransparency = 1 - ( 1 - Entry.fade ) * Clamp * Clamp3
        end
    end

    return
end

local function Pickup( Text, BackgroundColor3, Callback )
    local Parent
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        local Find = Screens.Find
        Parent = Find( "Notifications", LocalPlayer.PlayerGui )
    else
        Parent = PlayerGui
    end

    local PickupToast

    if Parent then
        PickupToast = Parent:FindFirstChild( "PickupToast" )
    else
        PickupToast = Parent
    end
    if not PickupToast or type( Text ) ~= "string" or Text == "" then
        return
    end

    local Clone = PickupToast:Clone( )
    Clone.Name = "PickupToastLive"
    local Message = Clone:FindFirstChild( "Message", true )

    if Message then
        Message.Text = Text
        local Match, Match2 = Text:match( "^(%+%d+)%s+(.+)$" )

        if Match and Message.RichText and typeof( BackgroundColor3 ) == "Color3" then
            local ToHex = BackgroundColor3:ToHex( )
            Message.Text = ( "<font color=\"#%s\">%s</font> %s" ):format( ToHex, Match, ( Match2:gsub( "[<>&]", "" ) ) )
        end
    end

    local Accent = Clone:FindFirstChild( "Accent", true )

    if Accent and typeof( BackgroundColor3 ) == "Color3" then
        Accent.BackgroundColor3 = BackgroundColor3
    end

    local Item = Clone:FindFirstChild( "Item", true )

    if Item and Callback then
        pcall( Callback, Item )
    end

    Clone.GroupTransparency = 1
    Clone.Visible = true
    Clone.Parent = Parent
    table.insert( Table2, 1, { c = Clone, born = os.clock( ) } )

    if not Value2 then
        Value2 = RunService.RenderStepped:Connect( PlacePickups )
    end

    PlacePickups( 0 )
end

local Table4 = { }
local Flag = false

local function Play( Argument1 )
    local Parent
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        local Find = Screens.Find
        Parent = Find( "Notifications", LocalPlayer.PlayerGui )
    else
        Parent = PlayerGui
    end

    local Announcement

    if Parent then
        if Argument1.style then
            local FoundChild = Parent:FindFirstChild( Argument1.style )

            if FoundChild then
                Announcement = FoundChild
            else
                Announcement = Parent:FindFirstChild( "Announcement" )
            end
        else
            Announcement = Parent:FindFirstChild( "Announcement" )
        end
    else
        Announcement = Parent
    end
    if not Announcement then
        return
    end

    local Parent2 = Announcement:Clone( )
    Parent2.Name = "AnnouncementLive"
    local Title = Parent2:FindFirstChild( "Title" )
    local Sub = Parent2:FindFirstChild( "Sub" )
    local Shine = Parent2:FindFirstChild( "Shine", true )

    if Title then
        Title.Text = Argument1.title
    end

    local FoundChild2
    local Sound = Argument1.sound

    if Sound then
        local ScreenGui = Parent:FindFirstAncestorOfClass( "ScreenGui" )

        if ScreenGui then
            FoundChild2 = Parent:FindFirstAncestorOfClass( "ScreenGui" ):FindFirstChild( Argument1.sound )
        else
            FoundChild2 = ScreenGui
        end
    else
        FoundChild2 = Sound
    end
    if FoundChild2 and FoundChild2:IsA( "Sound" ) then
        FoundChild2.TimePosition = 0
        FoundChild2:Play( )
    end
    if Sub then
        local Visible
        Sub.Text = Argument1.sub or ""
        Visible = ( Argument1.sub or "" ) ~= "" and true or false
        Sub.Visible = Visible
    end

    local UIScale2
    local UIScale = Parent2:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        UIScale2 = UIScale
    else
        UIScale2 = Instance.new( "UIScale" )
    end

    local UIGradient
    UIScale2.Parent = Parent2
    local Position = Parent2.Position
    Parent2.GroupTransparency = 1
    UIScale2.Scale = 0.75
    Parent2.Visible = true
    Parent2.Parent = Parent
    TweenService:Create( Parent2, TweenInfo.new( 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { GroupTransparency = 0 } ):Play( )
    TweenService:Create( UIScale2, TweenInfo.new( 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )

    if Shine then
        UIGradient = Shine:FindFirstChildOfClass( "UIGradient" )
    else
        UIGradient = Shine
    end
    if UIGradient then
        UIGradient.Offset = Vector2.new( -1, 0 )
        task.delay( 0.3, function()
            local I = 1

            for I = 1, 2 do
                if not UIGradient.Parent then
                    return
                end

                UIGradient.Offset = Vector2.new( -1, 0 )
                TweenService:Create( UIGradient, TweenInfo.new( 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut ), { Offset = Vector2.new( 1, 0 ) } ):Play( )
                task.wait( 2.2 )
            end
        end )
    end

    task.wait( Argument1.duration )
    TweenService:Create( Parent2, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), {
        GroupTransparency = 1,
        Position = Position - UDim2.fromScale( 0, 0.03 )
    } ):Play( )
    task.wait( 0.4 )
    Parent2:Destroy( )
end

local Table = {
    Error = Error,
    Pickup = Pickup,
    Announce = function( Name, Sub, Text, Sound, Style )
        if type( Name ) ~= "string" or Name == "" then
            return
        end

        local Sub2
        local Table = { title = Name }
        Sub2 = type( Sub ) == "string" and Sub or nil
        local Sound2
        Table.sub = Sub2
        Table.duration = math.clamp( tonumber( Text ) or 5, 1.5, 20 )
        Sound2 = type( Sound ) == "string" and Sound or nil
        local Style2
        Table.sound = Sound2
        Style2 = type( Style ) == "string" and Style or nil
        local Value1, FlagInner
        Table.style = Style2
        Value1 = nil

        for Key, Value in Table4, nil, nil do
            if Value.title == Table.title then
                if Value.style == Table.style then
                    Table4[ Key ] = Table
                    FlagInner = true
                    break
                end
            end

            FlagInner = false
        end
        if not FlagInner then
            table.insert( Table4, Table )
        end
        while #Table4 > 6 do
            table.remove( Table4, 1 )
        end
        if Flag then
            return
        end
        Flag = true
        task.spawn( function()
            while #Table4 > 0 do
                local Success, Result = pcall( Play, ( table.remove( Table4, 1 ) ) )

                if not Success then
                    warn( "[Notify] " .. tostring( Result ) )
                end
            end

            Flag = false
        end )
        return
    end
}
return Table
