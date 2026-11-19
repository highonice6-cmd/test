-- Players.perkbrokeyou.PlayerScripts.ItemShopClient
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
local RunService = game:GetService( "RunService" )
local LocalPlayer = Players.LocalPlayer
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "Notify", 10 ) )

if not Success then
    Result = nil
end

local Scale
local ItemShop = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "ItemShop" )
local ItemRender = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ItemRender" ) )
local ShopItems = require( ReplicatedStorage:WaitForChild( "ShopItems" ) )
local ItemShop2 = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "ItemShop", math.huge )
ItemShop2.Enabled = false
local Panel = ItemShop2:WaitForChild( "Panel" )
local Open = Panel:WaitForChild( "Open" )
local Close = Panel:WaitForChild( "Close" )
local Status = Panel:FindFirstChild( "Status" )
local Limit = Panel:FindFirstChild( "Limit" )
local Text = Open:FindFirstChild( "Text" )
local CanOpen = Open:FindFirstChild( "CanOpen" )
local NoMoney = Open:FindFirstChild( "NoMoney" )
local Icon = Panel:WaitForChild( "Tile" ):FindFirstChild( "Icon" )
local UIScale = Panel:FindFirstChildOfClass( "UIScale" )
Scale = UIScale and UIScale.Scale or 1
local Table = {
    money = "Not enough money",
    far = "Stand in the circle",
    wait = "",
    loading = "Loading your data, try again",
    limit = "Hourly limit reached",
    invfull = "Your inventory is full"
}
local Flag = false
local Flag2 = false
local Value1 = nil
local Value2 = nil
local Number = 0
local Number2 = 0
local Flag3 = false
local Number3 = 0
local Number4 = 0
local Number5 = 0

local function Fmt( Argument1 )
    local Max = math.max( 0, ( math.ceil( Argument1 ) ) )
    return string.format( "%d:%02d", Max // 60, Max % 60 )
end

local function Money( Argument1 )
    return "$" .. tostring( Argument1 ):reverse( ):gsub( "(%d%d%d)", "%1." ):reverse( ):gsub( "^%.", "" )
end

local function Fill( Key )
    local Entry = ShopItems[ Key ]

    if not Entry then
        return
    end

    local CaseName = Panel.CaseName
    CaseName.Text = Entry.Name
    local Description = Panel.Description
    Description.Text = Entry.Desc or ""
    local Price = Panel.Price
    Price.Text = "$" .. tostring( Entry.Price ):reverse( ):gsub( "(%d%d%d)", "%1." ):reverse( ):gsub( "^%.", "" )

    if Icon then
        Icon.Image = ItemRender.ICONS[ Key ] or ""
    end
end

local function LeftNow()
    local Max2

    if Value2 then
        local Max = math.max( 0, Value2.Left - Number2 )

        if Max then
            Max2 = Max
        else
            Max2 = nil
        end
    else
        Max2 = nil
    end

    return Max2
end

local function Refresh()
    if not ( Value1 and ShopItems[ Value1 ] ) then
        return
    end

    local Max2
    local Captured = Number - os.clock( )

    if Value2 then
        local Max = math.max( 0, Value2.Left - Number2 )

        if Max then
            Max2 = Max
        else
            Max2 = nil
        end
    else
        Max2 = nil
    end

    local Enabled

    if Max2 == nil then
        Enabled = false
    elseif Max2 <= 0 then
        if Captured > 0 then
            Enabled = true
        else
            Enabled = false
        end
    else
        Enabled = false
    end
    if CanOpen then
        CanOpen.Enabled = not Enabled
    end
    if NoMoney then
        NoMoney.Enabled = Enabled
    end
    if Text then
        local Text2

        if Enabled then
            local Max3 = math.max( 0, ( math.ceil( Captured ) ) )
            local TextInner = "WAIT " .. string.format( "%d:%02d", Max3 // 60, Max3 % 60 )

            if TextInner then
                Text2 = TextInner
            else
                Text2 = "BUY"
            end
        else
            Text2 = "BUY"
        end

        Text.Text = Text2
    end
    if Limit then
        local Text3

        if ( Value1 and ShopItems[ Value1 ] ).PerHour then
            if Enabled then
                Text3 = "Hourly limit reached"
            elseif Max2 then
                local Format = string.format( "%d/%d left this hour", Max2, Value2.Limit )

                if Format then
                    Text3 = Format
                else
                    Text3 = string.format( "Max %d per hour", ( Value1 and ShopItems[ Value1 ] ).PerHour )
                end
            else
                Text3 = string.format( "Max %d per hour", ( Value1 and ShopItems[ Value1 ] ).PerHour )
            end
        else
            Text3 = ""
        end

        Limit.Text = Text3
    end
end

local function Apply( Result )
    if type( Result ) ~= "table" or not Result.Item or Result.Item ~= Value1 or not Result.Limit then
        return
    end
    Value2 = { Left = Result.Left, Limit = Result.Limit }
    Number = os.clock( ) + ( Result.Wait or 0 )
    Refresh( )
    return
end

local function Msg( Text, Argument2 )
    if not Status then
        return
    end

    local TextColor3

    if Argument2 then
        local FromRGB = Color3.fromRGB( 130, 220, 114 )

        if FromRGB then
            TextColor3 = FromRGB
        else
            TextColor3 = Color3.fromRGB( 240, 110, 110 )
        end
    else
        TextColor3 = Color3.fromRGB( 240, 110, 110 )
    end

    Status.TextColor3 = TextColor3
    Status.Text = Text
    task.delay( 1.5, function()
        if Status.Text == Text then
            Status.Text = ""
        end
    end )
end

local function Pop()
    local UIScale2
    local UIScale = Open:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        UIScale2 = UIScale
    else
        UIScale2 = Instance.new( "UIScale", Open )
    end

    UIScale2.Scale = 0.92
    TweenService:Create( UIScale2, TweenInfo.new( 0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
end

local function Fail( Text )
    if Status then
        Status.TextColor3 = Color3.fromRGB( 240, 110, 110 )
        Status.Text = Text
        task.delay( 1.5, function()
            if Status.Text == Text then
                Status.Text = ""
            end
        end )
    end
    if Result and Result.Error then
        Result.Error( Text )
    end
end

local function Buy()
    local Captured = if Value1 then ShopItems[ Value1 ] else Value1

    if not Captured or not Flag then
        return
    end

    local Clock = os.clock( )

    if Clock - Number3 < 0.08 then
        return
    end

    local Max2
    Number3 = Clock

    if Value2 then
        local Max = math.max( 0, Value2.Left - Number2 )

        if Max then
            Max2 = Max
        else
            Max2 = nil
        end
    else
        Max2 = nil
    end
    if not Max2 or not ( Max2 <= 0 ) then
        if not ( ( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) < Captured.Price * ( Number2 + 1 ) ) then
            Number2 = Number2 + 1
            Pop( )
            Refresh( )
            task.spawn( function()
                local Success, ResultInner = pcall( ItemShop.InvokeServer, ItemShop, "Buy" )
                Number2 = math.max( 0, Number2 - 1 )

                if Value1 ~= Value1 then
                    return
                end
                if not Success or type( ResultInner ) ~= "table" or not ResultInner.ok then
                    local Success2
                    Refresh( )

                    if Success then
                        if type( ResultInner ) == "table" then
                            Success2 = Table[ ResultInner.err ]
                        else
                            Success2 = false
                        end
                    else
                        Success2 = Success
                    end
                    if Success2 == "" then
                        return
                    end
                    if Success and type( ResultInner ) == "table" and ResultInner.err == "limit" then
                        Apply( ResultInner )
                    end

                    local Text2 = Success2 or "Something went wrong, try again"

                    if Status then
                        Status.TextColor3 = Color3.fromRGB( 240, 110, 110 )
                        Status.Text = Text2
                        task.delay( 1.5, function()
                            if Status.Text == Text2 then
                                Status.Text = ""
                            end
                        end )
                    end
                    if Result and Result.Error then
                        Result.Error( Text2 )
                    end

                    return
                end
                local Captured2
                Apply( ResultInner )

                if os.clock( ) - Number5 < 1.5 then
                    local CapturedInner = Number4 + 1

                    if CapturedInner then
                        Captured2 = CapturedInner
                    else
                        Captured2 = 1
                    end
                else
                    Captured2 = 1
                end

                Number4 = Captured2
                Number5 = os.clock( )
                local Text = "+" .. Number4 .. " " .. Captured.Name

                if not Status then
                    return
                end

                local TextColor3
                local FromRGB = Color3.fromRGB( 130, 220, 114 )
                TextColor3 = if FromRGB then FromRGB else Color3.fromRGB( 240, 110, 110 )
                Status.TextColor3 = TextColor3
                Status.Text = Text
                task.delay( 1.5, function()
                    if Status.Text == Text then
                        Status.Text = ""
                    end
                end )
                return
            end )
            return
        end
        if Status then
            Status.TextColor3 = Color3.fromRGB( 240, 110, 110 )
            Status.Text = "Not enough money"
            local Text2 = "Not enough money"
            task.delay( 1.5, function()
                if Status.Text == Text2 then
                    Status.Text = ""
                end
            end )
        end
        if Result and Result.Error then
            Result.Error( "Not enough money" )
        end

        return
    end
    if Clock < Number then
        if Status then
            Status.TextColor3 = Color3.fromRGB( 240, 110, 110 )
            Status.Text = "Hourly limit reached"
            local Text = "Hourly limit reached"
            task.delay( 1.5, function()
                if Status.Text == Text then
                    Status.Text = ""
                end
            end )
        end
        if Result and Result.Error then
            Result.Error( "Hourly limit reached" )
        end
    end

    return
end

Open.Activated:Connect( Buy )

local function SetOpen( Enabled )
    if Flag == Enabled then
        return
    end

    Flag = Enabled
    ItemShop2.Enabled = Enabled

    if not Enabled then
        GamepadNav.Close( "ItemShop" )
        return
    end
    if Status then
        Status.Text = ""
    end

    Number4 = 0
    local Entry = ShopItems[ Value1 ]

    if Entry then
        local CaseName = Panel.CaseName
        CaseName.Text = Entry.Name
        local Description = Panel.Description
        Description.Text = Entry.Desc or ""
        local Price = Panel.Price
        Price.Text = "$" .. tostring( Entry.Price ):reverse( ):gsub( "(%d%d%d)", "%1." ):reverse( ):gsub( "^%.", "" )

        if Icon then
            Icon.Image = ItemRender.ICONS[ Value1 ] or ""
        end
    end

    Refresh( )

    if UIScale then
        UIScale.Scale = 0.9 * Scale
        TweenService:Create( UIScale, TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Scale } ):Play( )
    end

    GamepadNav.Open( "ItemShop", {
        root = ItemShop2,
        first = Open,
        freeze = false,
        virtual = true,
        onSelect = Buy,
        virtualActions = {
            [ Open ] = Buy,
            [ Close ] = function()
                Flag2 = true
                SetOpen( false )
            end
        },
        holdButtons = { [ Open ] = 0.5 },
        selectLabel = "Buy (hold)",
        backLabel = "Close",
        onBack = function()
            Flag2 = true
            SetOpen( false )
        end
    } )
end

Close.Activated:Connect( function()
    Flag2 = true

    if Flag == false then
        return
    end
    Flag = false
    ItemShop2.Enabled = false
    GamepadNav.Close( "ItemShop" )
    return
end )

local function InCircle()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not HumanoidRootPart or Character:GetAttribute( "Downed" ) then
        return nil
    end

    local Interactions2
    local Interactions = workspace:FindFirstChild( "Interactions" )
    Interactions2 = if Interactions then Interactions else workspace

    for Key, Value in Interactions2:GetChildren( ) do
        local Shop = Value:GetAttribute( "Shop" )

        if Shop then
            local BoundingBox

            if not Value:IsA( "Model" ) or not Value:GetBoundingBox( ) then
                local IsA = Value:IsA( "BasePart" )

                if IsA then
                    BoundingBox = Value.CFrame
                else
                    BoundingBox = IsA
                end
            else
                BoundingBox = Value:GetBoundingBox( )
            end
            if BoundingBox then
                local Position = HumanoidRootPart.Position - BoundingBox.Position
                local X = Position.X

                if Vector3.new( X, 0, Position.Z ).Magnitude <= 3.6 then
                    if math.abs( Position.Y ) < 6 then
                        return Shop
                    end
                end
            end
        end
    end

    return nil
end

local Number6 = 0
RunService.Heartbeat:Connect( function( Argument1 )
    Number6 = Number6 + Argument1

    if Number6 < 0.1 then
        return
    end

    Number6 = 0
    local InCircle2 = InCircle( )

    if InCircle2 ~= Value1 then
        Value1 = InCircle2
        Value2 = nil
        Number = 0
        Number2 = 0
        Number4 = 0
        Flag2 = false

        if Flag and InCircle2 then
            local Entry = ShopItems[ InCircle2 ]

            if Entry then
                local CaseName = Panel.CaseName
                CaseName.Text = Entry.Name
                local Description = Panel.Description
                Description.Text = Entry.Desc or ""
                local Price = Panel.Price
                Price.Text = "$" .. tostring( Entry.Price ):reverse( ):gsub( "(%d%d%d)", "%1." ):reverse( ):gsub( "^%.", "" )

                if Icon then
                    Icon.Image = ItemRender.ICONS[ InCircle2 ] or ""
                end
            end
            if Status then
                Status.Text = ""
            end
        end
    end

    local FlagInner = if InCircle2 == nil then false else not Flag2
    SetOpen( FlagInner )

    if Flag then
        Refresh( )
    end
    if Flag and Value1 and ShopItems[ Value1 ] and ShopItems[ Value1 ].PerHour and not Flag3 and Number2 == 0 then
        if Value2 then
            if Value2.Left <= 0 and Number <= os.clock( ) then
                Flag3 = true
                task.spawn( function()
                    local Success, Result = pcall( ItemShop.InvokeServer, ItemShop, "State" )

                    if Success and Flag and Number2 == 0 then
                        Apply( Result )
                    end

                    task.wait( 0.3 )
                    Flag3 = false
                end )
            end
        else
            Flag3 = true
            task.spawn( function()
                local Success, Result = pcall( ItemShop.InvokeServer, ItemShop, "State" )

                if Success and Flag and Number2 == 0 then
                    Apply( Result )
                end

                task.wait( 0.3 )
                Flag3 = false
            end )
        end
    end
end )
