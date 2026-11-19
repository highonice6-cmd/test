-- Players.perkbrokeyou.PlayerScripts.ATMClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local ProximityPromptService = game:GetService( "ProximityPromptService" )
local TweenService = game:GetService( "TweenService" )
local LocalPlayer = Players.LocalPlayer
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "Notify", 10 ) )

if not Success then
    Result = nil
end

local Scale
local ATM = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "ATM" )
local ATM2 = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "ATM", math.huge )
ATM2.Enabled = false
local Window = ATM2:WaitForChild( "Window" )
local Value = Window:WaitForChild( "CashCard" ):WaitForChild( "Value" )
local Value2 = Window:WaitForChild( "BankCard" ):WaitForChild( "Value" )
local DepositTab = Window:WaitForChild( "DepositTab" )
local WithdrawTab = Window:WaitForChild( "WithdrawTab" )
local Amount = Window:WaitForChild( "AmountFrame" ):WaitForChild( "Amount" )
local Max = Window:WaitForChild( "Max" )
local Slider = Window:WaitForChild( "Slider" )
local Fill = Slider:WaitForChild( "Fill" )
local Knob = Slider:WaitForChild( "Knob" )
local MaxValue = Window:WaitForChild( "MaxValue" )
local Confirm = Window:WaitForChild( "Confirm" )
local Status = Window:WaitForChild( "Status" )
local Close = Window:WaitForChild( "Close" )
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
Scale = UIScale and UIScale.Scale or 1
local Table = {
    cash = "Not enough cash",
    bank = "Not enough money in the bank",
    far = "Get closer to the ATM",
    amount = "Enter an amount",
    loading = "Loading, try again",
    wait = ""
}
local Text = "Deposit"
local Number = 0
local Flag = false
local Flag2 = false
local Value1 = nil

local function Cash()
    return ( math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) ) ) )
end

local function Bank()
    return ( math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) ) )
end

local function MaxAmount()
    local Max2

    if Text == "Deposit" then
        local Max = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) ) )

        if Max then
            Max2 = Max
        else
            Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
        end
    else
        Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
    end

    return Max2
end

local function SetGrad( Self, Enabled )
    local CanOpen = Self:FindFirstChild( "CanOpen" )
    local NoMoney = Self:FindFirstChild( "NoMoney" )

    if CanOpen then
        CanOpen.Enabled = Enabled
    end
    if NoMoney then
        NoMoney.Enabled = not Enabled
    end
end

local function Refresh( Argument1 )
    local Max2

    if Text == "Deposit" then
        local Max = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) ) )

        if Max then
            Max2 = Max
        else
            Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
        end
    else
        Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
    end

    local Enabled
    Number = math.clamp( Number, 0, Max2 )
    Value.Text = MoneyFormat( ( math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) ) ) ) )
    Value2.Text = MoneyFormat( ( math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) ) ) )
    Enabled = Text == "Deposit" and true or false
    local CanOpen = DepositTab:FindFirstChild( "CanOpen" )
    local NoMoney = DepositTab:FindFirstChild( "NoMoney" )

    if CanOpen then
        CanOpen.Enabled = Enabled
    end
    if NoMoney then
        NoMoney.Enabled = not Enabled
    end

    local Enabled2 = Text == "Withdraw" and true or false
    local CanOpen2 = WithdrawTab:FindFirstChild( "CanOpen" )
    local NoMoney2 = WithdrawTab:FindFirstChild( "NoMoney" )

    if CanOpen2 then
        CanOpen2.Enabled = Enabled2
    end
    if NoMoney2 then
        NoMoney2.Enabled = not Enabled2
    end

    local Captured2

    if Max2 > 0 then
        local Captured = Number / Max2

        if Captured then
            Captured2 = Captured
        else
            Captured2 = 0
        end
    else
        Captured2 = 0
    end

    Fill.Size = UDim2.fromScale( Captured2, 1 )
    Knob.Position = UDim2.fromScale( Captured2, 0.5 )
    MaxValue.Text = MoneyFormat( Max2 )

    if not Argument1 then
        local TextInner

        if Number > 0 then
            local MoneyFormat2 = MoneyFormat( Number )

            if MoneyFormat2 then
                TextInner = MoneyFormat2
            else
                TextInner = ""
            end
        else
            TextInner = ""
        end

        Amount.Text = TextInner
    end

    local Text3
    local Text2 = Confirm.Text
    Text3 = Text ~= "Deposit" and "WITHDRAW " or "DEPOSIT "
    local Text4

    if Number > 0 then
        local MoneyFormat3 = MoneyFormat( Number )

        if MoneyFormat3 then
            Text4 = MoneyFormat3
        else
            Text4 = ""
        end
    else
        Text4 = ""
    end

    local Enabled3
    Text2.Text = Text3 .. Text4
    Enabled3 = Number > 0 and true or false
    local CanOpen3 = Confirm:FindFirstChild( "CanOpen" )
    local NoMoney3 = Confirm:FindFirstChild( "NoMoney" )

    if CanOpen3 then
        CanOpen3.Enabled = Enabled3
    end
    if NoMoney3 then
        NoMoney3.Enabled = not Enabled3
    end
end

local function Msg( Text, Argument2 )
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
    task.delay( 2.5, function()
        if Status.Text == Text then
            Status.Text = ""
        end
    end )
end

local function Parse( Text )
    local Sub, Number
    local Gsub = string.lower( Text ):gsub( "[%s%$]", "" )

    if Gsub:sub( -1 ) == "k" then
        Sub = Gsub:sub( 1, -2 )
        Number = 1000
    elseif Gsub:sub( -1 ) == "m" then
        Sub = Gsub:sub( 1, -2 )
        Number = 1000000
    else
        Number = 1
        Sub = Gsub
    end

    local Gsub3

    if Number > 1 then
        local Gsub2 = Sub:gsub( ",", "." )
        local _, Gsub22 = Gsub2:gsub( "%.", "" )

        if Gsub22 > 1 then
            Gsub3 = Gsub2:gsub( "%.", "" )
        else
            Gsub3 = Gsub2
        end
    else
        Gsub3 = Sub:gsub( "[%.,]", "" )
    end

    local Floor2
    local Number2 = tonumber( Gsub3 )

    if Number2 then
        local Floor = math.floor( Number2 * Number )

        if Floor then
            Floor2 = Floor
        else
            Floor2 = 0
        end
    else
        Floor2 = 0
    end

    return Floor2
end

Amount:GetPropertyChangedSignal( "Text" ):Connect( function()
    if Amount:IsFocused( ) then
        Number = Parse( Amount.Text )
        Refresh( true )
        return
    end
    return
end )
Amount.FocusLost:Connect( function()
    Number = Parse( Amount.Text )
    Refresh( false )
end )

local function SetMode( Mode )
    Text = Mode
    Refresh( false )
end

DepositTab.Activated:Connect( function()
    Text = "Deposit"
    Refresh( false )
end )
WithdrawTab.Activated:Connect( function()
    Text = "Withdraw"
    Refresh( false )
end )
Max.Activated:Connect( function()
    local Max2

    if Text == "Deposit" then
        local Max = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) ) )

        if Max then
            Max2 = Max
        else
            Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
        end
    else
        Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
    end

    Number = Max2
    Refresh( false )
end )
local Value3 = nil

local function FromX( Argument1 )
    local Clamp2
    local X = Slider.AbsolutePosition.X
    local X2 = Slider.AbsoluteSize.X

    if X2 > 0 then
        local Clamp = math.clamp( ( Argument1 - X ) / X2, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 0
        end
    else
        Clamp2 = 0
    end

    local Max2

    if Text == "Deposit" then
        local Max = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) ) )

        if Max then
            Max2 = Max
        else
            Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
        end
    else
        Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
    end

    Number = math.floor( Clamp2 * Max2 + 0.5 )
    Refresh( false )
end

local function BeginDrag( Argument1 )
    if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
        local Clamp2
        Value3 = Argument1
        local X = Argument1.Position.X
        local X2 = Slider.AbsolutePosition.X
        local X3 = Slider.AbsoluteSize.X

        if X3 > 0 then
            local Clamp = math.clamp( ( X - X2 ) / X3, 0, 1 )

            if Clamp then
                Clamp2 = Clamp
            else
                Clamp2 = 0
            end
        else
            Clamp2 = 0
        end

        local Max2

        if Text == "Deposit" then
            local Max = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) ) )

            if Max then
                Max2 = Max
            else
                Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
            end
        else
            Max2 = math.max( 0, ( math.floor( tonumber( LocalPlayer:GetAttribute( "Bank" ) ) or 0 ) ) )
        end

        Number = math.floor( Clamp2 * Max2 + 0.5 )
        Refresh( false )
    end
end

Slider.InputBegan:Connect( BeginDrag )
Knob.InputBegan:Connect( BeginDrag )
UserInputService.InputChanged:Connect( function( p1 )
    -- Could not structure function #16
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    if Value3 then
        if Argument1 == Value3 or Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
            Value3 = nil
        end
    end
end )

local function PlaySound( Name )
    local FoundChild = ATM2:FindFirstChild( Name )

    if not FoundChild or not FoundChild:IsA( "Sound" ) then
        return
    end
    local Clone = FoundChild:Clone( )
    Clone.Parent = FoundChild.Parent
    Clone.Ended:Once( function()
        Clone:Destroy( )
    end )
    Clone:Play( )
    return
end

local function DoConfirm()
    if Flag2 or Number < 1 then
        return
    end

    Flag2 = true

    if Text == "Withdraw" then
        LocalPlayer:SetAttribute( "KachingMuteUntil", os.clock( ) + 3 )
    end

    local Success, ResultInner = pcall( ATM.InvokeServer, ATM, Text, Number )
    Flag2 = false

    if not Success or type( ResultInner ) ~= "table" or not ResultInner.ok then
        local Success2

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

        local Text3 = Success2 or "Something went wrong, try again"
        Status.TextColor3 = Color3.fromRGB( 240, 110, 110 )
        Status.Text = Text3
        task.delay( 2.5, function()
            if Status.Text == Text3 then
                Status.Text = ""
            end
        end )

        if Result and Result.Error then
            Result.Error( Text3 )
        end

        return
    end
    local TextInner = Text ~= "Deposit" and "WithdrawSound" or "DepositSound"
    local Text2
    PlaySound( TextInner )
    Text2 = Text ~= "Deposit" and "Withdrew " or "Deposited "
    local UIScale2
    Msg( Text2 .. MoneyFormat( Number ), true )
    Number = 0
    local UIScale = Confirm:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        UIScale2 = UIScale
    else
        UIScale2 = Instance.new( "UIScale", Confirm )
    end

    UIScale2.Scale = 0.94
    TweenService:Create( UIScale2, TweenInfo.new( 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
    task.defer( Refresh, false )
    return
end

Confirm.Activated:Connect( DoConfirm )

local function SetOpen( Enabled, Argument2 )
    if Flag == Enabled then
        return
    end

    Flag = Enabled
    ATM2.Enabled = Enabled

    if not Enabled then
        Value3 = nil
        Amount:ReleaseFocus( )
        GamepadNav.Close( "ATM" )
        return
    end

    Value1 = Argument2
    Text = "Deposit"
    Number = 0
    Status.Text = ""
    Refresh( false )

    if UIScale then
        UIScale.Scale = 0.9 * Scale
        TweenService:Create( UIScale, TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Scale } ):Play( )
    end

    GamepadNav.Open( "ATM", {
        root = ATM2,
        first = DepositTab,
        freeze = false,
        backLabel = "Close",
        onBack = function()
            SetOpen( false )
        end
    } )
end

Close.Activated:Connect( function()
    if Flag == false then
        return
    end
    Flag = false
    ATM2.Enabled = false
    Value3 = nil
    Amount:ReleaseFocus( )
    GamepadNav.Close( "ATM" )
    return
end )
ProximityPromptService.PromptTriggered:Connect( function( Self )
    if not Self:GetAttribute( "ATM" ) then
        return
    end

    local Model
    local Parent = Self.Parent

    if Parent then
        Model = Parent:FindFirstAncestorOfClass( "Model" )
    else
        Model = Parent
    end

    local Position2

    if Model then
        local Position = Model:GetPivot( ).Position

        if Position then
            Position2 = Position
        elseif Parent then
            Position2 = Parent.Position
        else
            Position2 = Parent
        end
    elseif Parent then
        Position2 = Parent.Position
    else
        Position2 = Parent
    end

    SetOpen( true, Position2 )
end )
LocalPlayer:GetAttributeChangedSignal( "Money" ):Connect( function()
    if Flag then
        Refresh( Amount:IsFocused( ) )
    end
end )
LocalPlayer:GetAttributeChangedSignal( "Bank" ):Connect( function()
    if Flag then
        Refresh( Amount:IsFocused( ) )
    end
end )
task.spawn( function()
    while true do
        task.wait( 0.25 )

        if Flag then
            local HumanoidRootPart
            local Character = LocalPlayer.Character

            if Character then
                HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
            else
                HumanoidRootPart = Character
            end

            local Humanoid

            if Character then
                Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 or Character:GetAttribute( "Downed" ) then
                if Flag ~= false then
                    Flag = false
                    ATM2.Enabled = false
                    Value3 = nil
                    Amount:ReleaseFocus( )
                    GamepadNav.Close( "ATM" )
                end
            elseif Value1 and ( HumanoidRootPart.Position - Value1 ).Magnitude > 12 then
                if Flag ~= false then
                    Flag = false
                    ATM2.Enabled = false
                    Value3 = nil
                    Amount:ReleaseFocus( )
                    GamepadNav.Close( "ATM" )
                end
            end
        end
    end
end )
