-- StarterPlayer.StarterPlayerScripts.MoneyClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local TextService = game:GetService( "TextService" )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local LocalPlayer = Players.LocalPlayer
local Table = { }

local function FindUi()
    if Table.label and Table.label.Parent then
        return Table
    end

    local GlobalGui
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )
    else
        GlobalGui = PlayerGui
    end

    local TopRight

    if GlobalGui then
        TopRight = GlobalGui:FindFirstChild( "TopRight" )
    else
        TopRight = GlobalGui
    end

    local Cash

    if TopRight then
        Cash = TopRight:FindFirstChild( "Cash" )
    else
        Cash = TopRight
    end

    local Label = if Cash then Cash:FindFirstChild( "Cash" ) else Cash
    local Roll
    Table.label = Label
    Roll = if Cash then Cash:FindFirstChild( "Roll" ) else Cash
    local Kaching
    Table.roll = Roll
    Kaching = if Cash then Cash:FindFirstChild( "Kaching" ) else Cash
    local Label3
    Table.kaching = Kaching
    local Label2 = Table.label
    Label3 = if Label2 then Table else Label2
    return Label3
end

local Table2 = { }
local Table3 = { }

local function FontKey( Argument1 )
    local Family = Argument1.Family
    local Name = Argument1.Weight.Name
    return Family .. "|" .. Name .. "|" .. Argument1.Style.Name
end

local function CharWidth( Text, Font, Argument3 )
    local Entry2
    local Family = Font.Family
    local Name = Font.Weight.Name
    local Text2 = Family .. "|" .. Name .. "|" .. Font.Style.Name
    local Text3 = Text2 .. "|" .. Text
    local Entry = Table2[ Text3 ]

    if Entry ~= nil or not Argument3 then
        Entry2 = Entry
    else
        local X
        local GetTextBoundsParams = Instance.new( "GetTextBoundsParams" )
        GetTextBoundsParams.Text = Text
        GetTextBoundsParams.Font = Font
        GetTextBoundsParams.Size = 100
        GetTextBoundsParams.Width = 100000
        local Success, Result = pcall( TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams )
        X = Success and Result.X or false
        Table2[ Text3 ] = X

        if not Success or not ( Result.Y > 0 ) then
            Entry2 = X
        else
            Table3[ Text2 ] = Result.Y
            Entry2 = X
        end
    end

    return Entry2 or nil
end

local Value1 = nil
local Value2 = nil
local Number = 0
local Number2 = 0
local Number3 = 0
local Value3 = nil
local Value4 = nil

local function SwapStyle( Object, Enabled )
    if not Object then
        return
    end

    local UIGradient = Object:FindFirstChild( "UIGradient" )
    local UIGradientDette = Object:FindFirstChild( "UIGradientDette" )

    if UIGradient and UIGradientDette then
        UIGradient.Enabled = not Enabled
        UIGradientDette.Enabled = Enabled
    end
    if Object:IsA( "TextLabel" ) then
        if Object:GetAttribute( "CouleurNormale" ) == nil then
            Object:SetAttribute( "CouleurNormale", Object.TextColor3 )
        end

        local Text = not Enabled and "CouleurNormale" or "CouleurDette"
        local TextColor3 = Object:GetAttribute( Text )

        if typeof( TextColor3 ) == "Color3" then
            Object.TextColor3 = TextColor3
        end
    end
end

local function DebtStyle( Argument1 )
    local FindUi2 = FindUi( )

    if not FindUi2 then
        return
    end

    local Flag = Argument1 == true and true or false

    if FindUi2.label:GetAttribute( "DetteAffichee" ) == Flag then
        return
    end

    local Reel
    FindUi2.label:SetAttribute( "DetteAffichee", Flag )
    SwapStyle( FindUi2.label.Parent, Flag )
    SwapStyle( FindUi2.label, Flag )
    local Roll = FindUi2.roll

    if Roll then
        Reel = FindUi2.roll:FindFirstChild( "Reel" )
    else
        Reel = Roll
    end

    local Strip

    if Reel then
        Strip = Reel:FindFirstChild( "Strip" )
    else
        Strip = Reel
    end

    local Roll2 = if Strip then Strip:FindFirstChild( "Digit" ) else Strip
    SwapStyle( Roll2, Flag )
end

local function FinishRoll()
    Value3 = nil

    if not Value3 then
        return
    end

    local Value1Inner
    local Wins = Value3.wins
    Value1Inner = nil

    for Key, Value in Wins, nil, nil do
        Value:Destroy( )
    end
    if Value3.label.Parent then
        local Flag = Value3.target < 0 and true or false
        DebtStyle( Flag )
        local Label = Value3.label
        Label.Text = MoneyFormat( Value3.target )
        Value3.label.Visible = true
        Value2 = Value3.label
    end

    local Target = Value3.target
    local Target2 = Value3.target
    local Target3 = Value3.target
    Value1 = Target
    Number = Target2
    Number2 = Target3
end

local function StartRoll( Amount )
    local Flag = Amount < 0 and true or false
    local Label
    DebtStyle( Flag )
    local FindUi2 = FindUi( )
    Label = if FindUi2 then FindUi2.label else FindUi2
    local Reel

    if FindUi2 then
        local Roll = FindUi2.roll

        if Roll then
            Reel = FindUi2.roll:FindFirstChild( "Reel" )
        else
            Reel = Roll
        end
    else
        Reel = FindUi2
    end

    local Strip

    if Reel then
        Strip = Reel:FindFirstChild( "Strip" )
    else
        Strip = Reel
    end

    local Roll2 = if Strip then Strip:FindFirstChild( "Digit" ) else Strip
    local Label2
    local MoneyFormat2 = MoneyFormat( Value1 )
    local Text = MoneyFormat( Amount )
    Label2 = if Label then Label.FontFace else Label
    local NumberInner
    local Count = #MoneyFormat2
    local I = 1
    NumberInner = 0

    for I = 1, Count do
        local Number2Inner

        if Label2 then
            local CharWidth2 = CharWidth( MoneyFormat2:sub( I, I ), Label2 )

            if CharWidth2 then
                Number2Inner = CharWidth2
            else
                Number2Inner = 0
            end
        else
            Number2Inner = 0
        end

        NumberInner = NumberInner + Number2Inner
    end

    local Number3, Number4
    local Count2 = #Text
    local I2 = 1
    Number3 = 0
    Number4 = 0

    for I2 = 1, Count2 do
        local Label3

        if Label2 then
            Label3 = CharWidth( Text:sub( I2, I2 ), Label2 )
        else
            Label3 = Label2
        end
        if not Label3 then
            Number4 = nil
            break
        end

        Number3 = Number3 + Label3
        Number4 = Number3
    end

    local Label4

    if Label2 then
        local Family = Label2.Family
        local Name = Label2.Weight.Name
        Label4 = Table3[ Family .. "|" .. Name .. "|" .. Label2.Style.Name ]
    else
        Label4 = Label2
    end
    if not Label or not Roll2 or not Number4 or not ( NumberInner > 0 ) or not Label4 or not Label.Visible or not ( Label.TextBounds.Y > 0 ) or not ( Label.AbsoluteSize.Y > 0 ) then
        Value1 = Amount
        Number = Amount
        Number2 = Amount

        if Label then
            Label.Text = Text
            Value2 = Label
        end

        return
    end
    local Min = math.min( Label.AbsoluteSize.Y * 100 / Label4, 100 ) / 100

    if Label.TextScaled then
        local X = Label.TextBounds.X

        if Label.AbsoluteSize.X * 0.97 <= X then
            Min = Label.TextBounds.X / NumberInner
        end
    else
        Min = Label.TextSize / 100
    end

    local Number6
    local TextSize = Min * 100
    local X2 = Label.AbsoluteSize.X
    local Y = Label.AbsoluteSize.Y
    local Number5 = Number4 * Min
    local TextXAlignment = Label.TextXAlignment

    if TextXAlignment == Enum.TextXAlignment.Left then
        Number6 = 0
    elseif TextXAlignment == Enum.TextXAlignment.Center then
        local X3 = ( X2 - Number5 ) / 2

        if X3 then
            Number6 = X3
        else
            Number6 = X2 - Number5
        end
    else
        Number6 = X2 - Number5
    end

    local TextScaled2
    local Parent = FindUi2.roll
    local AnchorPoint = Label.AnchorPoint
    local Position = Label.Position
    local Size = Label.Size
    Parent.AnchorPoint = AnchorPoint
    Parent.Position = Position
    Parent.Size = Size
    local Ceil = math.ceil( TextSize * 0.25 )
    local TextScaled = Label.TextScaled

    if TextScaled then
        if Label.TextBounds.X < X2 * 0.97 then
            TextScaled2 = true
        else
            TextScaled2 = false
        end
    else
        TextScaled2 = TextScaled
    end

    local Number11
    local Clock = os.clock( )
    local Table = { label = Label, target = Amount, reels = { }, wins = { } }
    local Count3 = #Text
    local I3 = 1
    Number11 = 0

    for I3 = 1, Count3 do
        local Sub = Text:sub( I3, I3 )
        local TextSize2 = CharWidth( Sub, Label2 ) * Min
        local Clone = Reel:Clone( )
        Clone.Name = "Reel_" .. I3
        Clone.Visible = true
        local Ceil2 = math.ceil( TextSize2 ) + Ceil * 2
        Clone.Position = UDim2.fromScale( ( Number6 - Ceil ) / X2, 0 )
        Clone.Size = UDim2.fromScale( Ceil2 / X2, 1 )
        local Strip2 = Clone:FindFirstChild( "Strip" )
        Strip2.Size = UDim2.fromScale( 1, 1 )
        local Digit = Strip2:FindFirstChild( "Digit" )
        Digit.Parent = nil

        local function Cell( Text, Argument2 )
            local Clone = Digit:Clone( )
            Clone.Text = Text
            Clone.FontFace = Label2
            Clone.TextXAlignment = Enum.TextXAlignment.Left
            Clone.TextYAlignment = Label.TextYAlignment

            if TextScaled2 then
                Clone.TextScaled = true
                Clone.Size = UDim2.fromScale( X2 / Ceil2, 1 )
            else
                local TextSizeInner
                Clone.TextScaled = false

                if Label.TextScaled then
                    local Round = math.round( TextSize )

                    if Round then
                        TextSizeInner = Round
                    else
                        TextSizeInner = Label.TextSize
                    end
                else
                    TextSizeInner = Label.TextSize
                end

                Clone.TextSize = TextSizeInner
                Clone.Size = UDim2.fromScale( ( Ceil2 - Ceil ) / Ceil2, 1 )
            end

            Clone.Position = UDim2.fromScale( Ceil / Ceil2, Argument2 )
            Clone.Parent = Strip2
        end

        if Sub:match( "%d" ) then
            local Count4 = #Text - I3
            local Sub2 = MoneyFormat2:sub( #MoneyFormat2 - Count4, #MoneyFormat2 - Count4 )
            local Number7 = tonumber( Sub )
            local Number8 = tonumber( Sub2 )
            local Number9 = 10 + ( Number7 - ( Number8 or Number7 ) ) % 10
            Cell( tostring( ( Number7 + 1 ) % 10 ), -1 )
            local Number10 = Number9 - 1
            local J = 0

            for J = 0, Number10 do
                Cell( tostring( ( Number7 - J ) % 10 ), J )
            end

            local Sub3 = Number8 and Sub2 or ""
            Cell( Sub3, Number9 )
            Strip2.Position = UDim2.fromScale( 0, -Number9 )
            local Reels = Table.reels
            table.insert( Reels, {
                strip = Strip2,
                steps = Number9,
                start = Clock + Number11 * 0.05,
                dur = Number11 * 0.06 + 0.7
            } )
            Number11 = Number11 + 1
        else
            Cell( Sub, 0 )
            Strip2.Position = UDim2.fromScale( 0, 0 )
        end

        Digit:Destroy( )
        Clone.Parent = Parent
        table.insert( Table.wins, Clone )
        Number6 = Number6 + TextSize2
    end

    Label.Text = Text
    Label.Visible = false
    Value3 = Table
    return
end

local function PlayKaching()
    local Kaching
    local FindUi2 = FindUi( )
    Kaching = if FindUi2 then FindUi2.kaching else FindUi2

    if Kaching then
        local Clone = Kaching:Clone( )
        Clone.Parent = Kaching.Parent
        Clone.Ended:Once( function()
            Clone:Destroy( )
        end )
        Clone:Play( )
        return
    end
    return
end

local function OnMoney()
    local NumberInner = tonumber( LocalPlayer:GetAttribute( "Money" ) )

    if not NumberInner then
        return
    end
    if Value1 == nil then
        Value1 = NumberInner
        Number = NumberInner
        Number2 = NumberInner
        return
    end

    local Max2

    if Value3 then
        local Target = Value3.target
        local Max = math.max( Target, Value4 or 0 )

        if Max then
            Max2 = Max
        else
            Max2 = Number2
        end
    else
        Max2 = Number2
    end
    if not ( Max2 < NumberInner ) then
        if NumberInner < Max2 then
            if Value3 then
                FinishRoll( )
                Value4 = nil
            end

            local Clock = os.clock( )
            Number = Value1
            Number2 = NumberInner
            Number3 = Clock
        end

        return
    end
    if ( tonumber( LocalPlayer:GetAttribute( "KachingMuteUntil" ) ) or 0 ) < os.clock( ) then
        PlayKaching( )
    end
    if Value3 then
        Value4 = NumberInner
        return
    end
    StartRoll( NumberInner )
    return
end

LocalPlayer:GetAttributeChangedSignal( "Money" ):Connect( OnMoney )
OnMoney( )
task.spawn( function()
    local FindUi2 = FindUi( )

    while not Value1 do
        task.wait( 0.2 )
        FindUi3 = FindUi( )
    end
    for Key, Value in ( "0123456789$.-" ):split( "" ) do
        CharWidth( Value, Value1.label.FontFace, true )
    end
    if Value1.kaching then
        local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
        local ContentProvider = game:GetService( "ContentProvider" )
        pcall( PreloadAsync, ContentProvider, { Value1.kaching } )
    end
end )
RunService.RenderStepped:Connect( function()
    if Value3 then
        if not Value3.label.Parent then
            FinishRoll( )
            return
        end

        local Value1Inner, Flag
        local Clock = os.clock( )
        local Reels = Value3.reels
        Value1Inner = nil
        Flag = true

        for Key, Value in Reels, nil, nil do
            local Clamp = math.clamp( ( Clock - Value.start ) / Value.dur, 0, 1 )

            if Clamp < 1 then
                Flag = false
            end

            local Amount = -Value.steps * ( 1 - Clamp ) ^ 3 + math.sin( 3.141592653589793 * math.clamp( ( Clamp - 0.8 ) / 0.2, 0, 1 ) ) * 0.18
            local Strip = Value.strip
            Strip.Position = UDim2.fromScale( 0, Amount )
        end
        if Flag then
            FinishRoll( )
            Value4 = nil

            if Value4 and Value1 < Value4 then
                StartRoll( Value4 )
            end
        end

        return
    end
    if Value1 == nil then
        return
    end

    local Label
    local FindUi2 = FindUi( )
    Label = if FindUi2 then FindUi2.label else FindUi2
    local Clamp2 = math.clamp( ( os.clock( ) - Number3 ) / 0.6, 0, 1 )
    local Captured = Number + ( Number2 - Number ) * ( 1 - ( 1 - Clamp2 ) ^ 3 )

    if Clamp2 >= 1 then
        Captured = Number2
    end
    if Captured == Value1 and Label == Value2 then
        return
    end

    Value1 = Captured

    if Label then
        local Flag2 = Captured < 0 and true or false
        DebtStyle( Flag2 )
        Label.Text = MoneyFormat( Captured )
        Value2 = Label
    end

    return
end )
