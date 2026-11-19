-- Players.perkbrokeyou.PlayerScripts.KillRewardClient
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
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local KillReward = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "KillReward" )
local LocalPlayer = Players.LocalPlayer

local function Find()
    local GlobalGui
    local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

    if PlayerGui then
        GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )
    else
        GlobalGui = PlayerGui
    end

    local BotCenter

    if GlobalGui then
        BotCenter = GlobalGui:FindFirstChild( "BotCenter" )
    else
        BotCenter = GlobalGui
    end

    local Cash

    if BotCenter then
        Cash = BotCenter:FindFirstChild( "Cash" )
    else
        Cash = BotCenter
    end

    local PlayerGui2 = if Cash then Cash:FindFirstChild( "Cash" ) else Cash
    return Cash, PlayerGui2
end

local Table = {
    TextLabel = "TextTransparency",
    Frame = "BackgroundTransparency",
    UIStroke = "Transparency",
    ImageLabel = "ImageTransparency"
}
local Value1 = nil
local Value2 = nil

local function Base( Object )
    if Object == Value1 then
        return Value2
    end

    local TableInner = {
        pos = Object.Position,
        fade = { [ Object ] = Object.TextTransparency }
    }

    for Key, Value in Object:GetDescendants( ) do
        local Entry = Table[ Value.ClassName ]

        if Entry then
            local Fade = TableInner.fade
            Fade[ Value ] = Value[ Entry ]
        end
    end

    local Mult = Object:FindFirstChild( "Mult" )

    if Mult and Mult:IsA( "GuiObject" ) then
        local Value1Inner
        local MultText = Mult:FindFirstChild( "Text" )
        local Tinted = { }
        TableInner.mult = Mult
        TableInner.multText = MultText
        TableInner.tinted = Tinted
        local Table2 = { Mult, table.unpack( Mult:GetDescendants( ) ) }
        Value1Inner = nil

        for Key2, Value2Inner in Table2, nil, nil do
            local Tier = Value2Inner:GetAttribute( "Tier" )

            if type( Tier ) == "string" then
                table.insert( TableInner.tinted, { Value2Inner, Tier } )
            end
        end

        function TableInner.place()
            local X3
            local X = Object.AbsoluteSize.X

            if X > 0 then
                local X2 = Object.TextBounds.X / X / 2

                if X2 then
                    X3 = X2
                else
                    X3 = 0.25
                end
            else
                X3 = 0.25
            end

            local Position = Mult.Position
            local X4 = 0.5 + X3 + ( tonumber( Mult:GetAttribute( "Gap" ) ) or 0.04 )
            Mult.Position = UDim2.new( X4, 0, Position.Y.Scale, Position.Y.Offset )
        end
        Object:GetPropertyChangedSignal( "TextBounds" ):Connect( TableInner.place )
    end

    Value1 = Object
    Value2 = TableInner
    return TableInner
end

local Number = 0
local Number2 = 0
local Table2 = { }

local function Play( Argument1, Argument2, Argument3 )
    local Create = TweenService:Create( Argument1, Argument2, Argument3 )
    table.insert( Table2, Create )
    Create:Play( )
end

local function StopTweens()
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        Value:Cancel( )
    end

    table.clear( Table2 )
end

local function Restore( Argument1, Argument2 )
    local Value1
    Argument1.Position = Argument2.pos
    local Fade = Argument2.fade
    Value1 = nil

    for Key, Value in Fade, nil, nil do
        Key[ Table[ Key.ClassName ] ] = Value
    end
end

local function ShowMult( Argument1, Amount, Amount2 )
    local Mult = Argument1.mult

    if not Mult then
        return
    end

    local Visible

    if Amount == nil then
        Visible = false
    elseif Amount > 1 then
        Visible = true
    else
        Visible = false
    end

    Mult.Visible = Visible

    if not Mult.Visible then
        return
    end
    if Argument1.multText then
        local MultText = Argument1.multText
        MultText.Text = "×" .. ( "%.2f" ):format( Amount ):gsub( "0+$", "" ):gsub( "%.$", "" )
    end

    local Attribute = Mult:GetAttribute( "Color" .. math.clamp( math.floor( Amount2 or 2 ), 2, 6 ) )

    if typeof( Attribute ) == "Color3" then
        local Value1
        local Tinted = Argument1.tinted
        Value1 = nil

        for Key, Value in Tinted, nil, nil do
            local Item = Value[ 1 ]
            Item[ Value[ 2 ] ] = Attribute
        end
    end

    Argument1.place( )
end

local Table3 = {
    soon = "ZONE NOT STARTED YET",
    out = "TARGET OUTSIDE · NOT COUNTED",
    clan = "SAME CLAN · NOT COUNTED",
    crew = "SAME CREW · NOT COUNTED"
}
local FromRGB = Color3.fromRGB( 190, 190, 196 )
KillReward.OnClientEvent:Connect( function( Text, Text2, Text3, Key )
    local NumberInner = tonumber( Text )

    if not NumberInner or NumberInner <= 0 then
        return
    end

    local Value1, Value2 = Find( )

    if not Value1 or not Value2 then
        return
    end

    local Value4
    local Base2 = Base( Value2 )
    Value4 = nil

    for Key2, Value in Table2, nil, nil do
        Value:Cancel( )
    end

    table.clear( Table2 )
    Number2 = Number2 + 1

    if not Value1.Visible then
        Number = 0
    end

    local Value5
    Number = Number + NumberInner
    Value2.Text = "+" .. MoneyFormat( Number )
    Value2.Position = Base2.pos
    local Fade = Base2.fade
    Value5 = nil

    for Key3, Value6 in Fade, nil, nil do
        Key3[ Table[ Key3.ClassName ] ] = Value6
    end

    local Text4
    ShowMult( Base2, tonumber( Text2 ), ( tonumber( Text3 ) ) )
    local Zone = Value2:FindFirstChild( "Zone" )

    if Zone then
        Text4 = Zone:FindFirstChild( "Text" )
    else
        Text4 = Zone
    end
    if Zone then
        local Entry2

        if type( Key ) == "string" then
            local Entry = Table3[ Key ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = nil
            end
        else
            Entry2 = nil
        end

        local Visible

        if Key == true then
            Visible = true
        elseif Entry2 == nil then
            Visible = false
        else
            Visible = true
        end

        Zone.Visible = Visible

        if Text4 and Text4:IsA( "TextLabel" ) then
            if not Text4:GetAttribute( "BaseText" ) then
                Text4:SetAttribute( "BaseText", Text4.Text )
                Text4:SetAttribute( "BaseColor", Text4.TextColor3 )
            end

            local Text5 = if Entry2 then Entry2 else Text4:GetAttribute( "BaseText" )
            local TextColor3
            Text4.Text = Text5

            if not Entry2 or not FromRGB then
                TextColor3 = Text4:GetAttribute( "BaseColor" )
            else
                TextColor3 = FromRGB
            end

            Text4.TextColor3 = TextColor3
        end
    end

    Value1.Visible = true
    local Pop = Value2:FindFirstChild( "Pop" )

    if Pop then
        Pop.Scale = 0.5
        local Create = TweenService:Create( Pop, TweenInfo.new( 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } )
        table.insert( Table2, Create )
        Create:Play( )
    end

    task.delay( 1.6, function()
        if Number2 ~= Number2 or not Value2.Parent then
            return
        end

        local Value1Inner
        local TweenInfo2 = TweenInfo.new( 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In )
        local Create = TweenService:Create( Value2, TweenInfo2, { Position = Base2.pos - UDim2.fromScale( 0, 0.6 ) } )
        table.insert( Table2, Create )
        Create:Play( )
        local Fade = Base2.fade
        Value1Inner = nil

        for Value in Fade, nil, nil do
            local Create2 = TweenService:Create( Value, TweenInfo2, { [ Table[ Value.ClassName ] ] = 1 } )
            table.insert( Table2, Create2 )
            Create2:Play( )
        end

        task.delay( 0.45, function()
            if Number2 ~= Number2 or not Value2.Parent then
                return
            end

            local Value1Inner
            Value1.Visible = false
            Number = 0
            Value1Inner = nil

            for Key, Value in Table2, nil, nil do
                Value:Cancel( )
            end

            local Value2Inner
            table.clear( Table2 )
            Value2.Position = Base2.pos
            local Fade = Base2.fade
            Value2Inner = nil

            for Key2, Value3 in Fade, nil, nil do
                Key2[ Table[ Key2.ClassName ] ] = Value3
            end
        end )
    end )
end )
