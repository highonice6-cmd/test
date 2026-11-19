-- StarterPlayer.StarterPlayerScripts.StarterPackClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Text
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local LocalPlayer = Players.LocalPlayer
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local RobuxShopUI = require( ReplicatedStorage:WaitForChild( "RobuxShopUI" ) )
local StarterPack = require( ReplicatedStorage:WaitForChild( "StarterPack" ) )
local GamePasses = require( ReplicatedStorage:WaitForChild( "GamePasses" ) )
local StarterOffer = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "StarterOffer" )
local Offer = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "StarterOffer", math.huge ):WaitForChild( "Offer" )
Offer.Visible = false
local Window = Offer:WaitForChild( "Window" )
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
local Price = Window:FindFirstChild( "Price" )
local Yes = Window:WaitForChild( "Buttons" ):WaitForChild( "Yes" )
local No = Window.Buttons:WaitForChild( "No" )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local Tag = Window:FindFirstChild( "Tag" )

if Tag then
    Text = Window.Tag:FindFirstChild( "Text" )
else
    Text = Tag
end

local Tag2
local Sub = Window:FindFirstChild( "Sub" )
Tag2 = if Text then Text.Text else Text
local Sub2 = if Sub then Sub.Text else Sub

local function Hms( Argument1 )
    local Max = math.max( 0, ( math.floor( Argument1 ) ) )
    return string.format( "%02d:%02d:%02d", Max // 3600, Max % 3600 // 60, Max % 60 )
end

local function BonusLeft()
    local StarterBonusUntil = LocalPlayer:GetAttribute( "StarterBonusUntil" )

    if type( StarterBonusUntil ) ~= "number" or LocalPlayer:GetAttribute( "StarterPackOwned" ) then
        return 0
    end
    return ( math.max( 0, StarterBonusUntil - workspace:GetServerTimeNow( ) ) )
end

local Text2 = "+" .. MoneyFormat( StarterPack.BonusCash or 25000 )

local function SetPrice()
    if not Price then
        return
    end

    local PriceText2
    local PriceText = GamePasses.PriceText( "StarterPack", SetPrice )

    if not PriceText or PriceText == "..." or PriceText == "" then
        local ROBUX = RobuxShopUI.ROBUX
        PriceText2 = ROBUX .. " " .. StarterPack.Price
    else
        PriceText2 = PriceText
    end

    Price.Text = "ONLY  " .. PriceText2
end

local Flag = false
local Value1 = nil

local function Close( Argument1 )
    if not Flag then
        return
    end

    local Text
    Flag = false
    Offer.Visible = false
    ClientState.CursorFree = false
    GamepadNav.Close( "StarterOffer" )
    Text = Value1 ~= "second" and "seen" or "seen2"
    local Text2 = not Argument1 and "no" or "yes"
    StarterOffer:FireServer( Text, Text2 )

    if Argument1 and ClientState.OpenShop then
        ClientState.OpenShop( )
    end
end

Yes.Activated:Connect( function()
    if not Flag then
        return
    end

    local Text
    Flag = false
    Offer.Visible = false
    ClientState.CursorFree = false
    GamepadNav.Close( "StarterOffer" )
    Text = Value1 ~= "second" and "seen" or "seen2"
    StarterOffer:FireServer( Text, "yes" )

    if ClientState.OpenShop then
        ClientState.OpenShop( )
    end
end )
No.Activated:Connect( function()
    if not Flag then
        return
    end

    local Text
    Flag = false
    Offer.Visible = false
    ClientState.CursorFree = false
    GamepadNav.Close( "StarterOffer" )
    Text = Value1 ~= "second" and "seen" or "seen2"
    StarterOffer:FireServer( Text, "no" )
end )

local function Free()
    if LocalPlayer:GetAttribute( "InTutorial" ) or LocalPlayer:GetAttribute( "Onboarding" ) == true or LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        return false
    end
    if LocalPlayer:GetAttribute( "AskPrompt" ) then
        return false
    end
    if ClientState.WardrobeOpen or ClientState.CaseRolling or ClientState.BetaReveal or ClientState.ServerMove then
        return false
    end

    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if type( CombatUntil ) == "number" and workspace:GetServerTimeNow( ) < CombatUntil then
        return false
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or Humanoid.Health <= 0 or Character:GetAttribute( "Downed" ) then
        return false
    end
    return true
end

local Value2 = nil
LocalPlayer:GetAttributeChangedSignal( "InTutorial" ):Connect( function()
    if not LocalPlayer:GetAttribute( "InTutorial" ) then
        Value2 = os.clock( )
    end
end )
local Flag2 = false

local function MaybeShow()
    if Flag2 or Flag or not LocalPlayer:GetAttribute( "StarterOffer" ) then
        return
    end
    Flag2 = true
    task.spawn( function()
        local Number2

        if Value2 then
            local Number = not LocalPlayer:GetAttribute( "StashGuide" ) and 0 or 10
            Number2 = 7 + Number
        else
            Number2 = 3
        end

        local Value1Inner = nil

        while LocalPlayer:GetAttribute( "StarterOffer" ) do
            if Flag then
                break
            end
            if Free( ) then
                if not Value2 or not ClientState.CaseRolling then
                    local Clock

                    if Value1Inner then
                        Clock = Value1Inner
                    else
                        Clock = os.clock( )
                    end
                    if Value2 then
                        local Max = math.max( Clock, Value2 )

                        if Max then
                            Clock = Max
                        end
                    end
                    if Number2 <= os.clock( ) - Clock then
                        break
                    end

                    Value1Inner = nil
                else
                    Value1Inner = nil
                end
            else
                Value1Inner = nil
            end

            task.wait( 0.25 )
        end

        Flag2 = false

        if not LocalPlayer:GetAttribute( "StarterOffer" ) or Flag then
            return
        end

        Flag = true

        if Price then
            local PriceText2
            local PriceText = GamePasses.PriceText( "StarterPack", SetPrice )

            if not PriceText or PriceText == "..." or PriceText == "" then
                local ROBUX = RobuxShopUI.ROBUX
                PriceText2 = ROBUX .. " " .. StarterPack.Price
            else
                PriceText2 = PriceText
            end

            Price.Text = "ONLY  " .. PriceText2
        end

        local TextInner = LocalPlayer:GetAttribute( "StarterOffer" ) ~= "second" and "first" or "second"
        Value1 = TextInner

        if Value1 == "second" then
            if Sub then
                Sub.Text = "Buy it now: " .. Text2 .. " bonus cash!"
            end

            task.spawn( function()
                while Flag do
                    if Value1 ~= "second" then
                        break
                    end
                    if Text then
                        local Max
                        local StarterBonusUntil = LocalPlayer:GetAttribute( "StarterBonusUntil" )

                        if type( StarterBonusUntil ) ~= "number" or LocalPlayer:GetAttribute( "StarterPackOwned" ) then
                            Max = 0
                        else
                            Max = math.max( 0, StarterBonusUntil - workspace:GetServerTimeNow( ) )
                        end

                        local Max2 = math.max( 0, ( math.floor( Max ) ) )
                        Text.Text = "ENDS IN " .. string.format( "%02d:%02d:%02d", Max2 // 3600, Max2 % 3600 // 60, Max2 % 60 )
                    end

                    task.wait( 0.5 )
                end
            end )
        else
            if Text and Tag2 then
                Text.Text = Tag2
            end
            if Sub and Sub2 then
                Sub.Text = Sub2
            end
        end

        ClientState.ActiveMenu = "StarterOffer"
        ClientState.CursorFree = true
        Offer.Visible = true

        if UIScale then
            UIScale.Scale = 0.85
            TweenService:Create( UIScale, TweenInfo.new( 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end

        GamepadNav.Open( "StarterOffer", {
            root = Window,
            first = Yes,
            backLabel = "No",
            onBack = function()
                if not Flag then
                    return
                end

                local Text
                Flag = false
                Offer.Visible = false
                ClientState.CursorFree = false
                GamepadNav.Close( "StarterOffer" )
                Text = Value1 ~= "second" and "seen" or "seen2"
                StarterOffer:FireServer( Text, "no" )
            end
        } )
    end )
    return
end

LocalPlayer:GetAttributeChangedSignal( "StarterOffer" ):Connect( MaybeShow )

if not Flag2 and not Flag then
    if LocalPlayer:GetAttribute( "StarterOffer" ) then
        Flag2 = true
        task.spawn( function()
            local Number2

            if Value2 then
                local Number = not LocalPlayer:GetAttribute( "StashGuide" ) and 0 or 10
                Number2 = 7 + Number
            else
                Number2 = 3
            end

            local Value1Inner = nil

            while LocalPlayer:GetAttribute( "StarterOffer" ) do
                if Flag then
                    break
                end
                if Free( ) then
                    if not Value2 or not ClientState.CaseRolling then
                        local Clock

                        if Value1Inner then
                            Clock = Value1Inner
                        else
                            Clock = os.clock( )
                        end
                        if Value2 then
                            local Max = math.max( Clock, Value2 )

                            if Max then
                                Clock = Max
                            end
                        end
                        if Number2 <= os.clock( ) - Clock then
                            break
                        end

                        Value1Inner = nil
                    else
                        Value1Inner = nil
                    end
                else
                    Value1Inner = nil
                end

                task.wait( 0.25 )
            end

            Flag2 = false

            if not LocalPlayer:GetAttribute( "StarterOffer" ) or Flag then
                return
            end

            Flag = true

            if Price then
                local PriceText2
                local PriceText = GamePasses.PriceText( "StarterPack", SetPrice )

                if not PriceText or PriceText == "..." or PriceText == "" then
                    local ROBUX = RobuxShopUI.ROBUX
                    PriceText2 = ROBUX .. " " .. StarterPack.Price
                else
                    PriceText2 = PriceText
                end

                Price.Text = "ONLY  " .. PriceText2
            end

            local TextInner = LocalPlayer:GetAttribute( "StarterOffer" ) ~= "second" and "first" or "second"
            Value1 = TextInner

            if Value1 == "second" then
                if Sub then
                    Sub.Text = "Buy it now: " .. Text2 .. " bonus cash!"
                end

                task.spawn( function()
                    while Flag do
                        if Value1 ~= "second" then
                            break
                        end
                        if Text then
                            local Max
                            local StarterBonusUntil = LocalPlayer:GetAttribute( "StarterBonusUntil" )

                            if type( StarterBonusUntil ) ~= "number" or LocalPlayer:GetAttribute( "StarterPackOwned" ) then
                                Max = 0
                            else
                                Max = math.max( 0, StarterBonusUntil - workspace:GetServerTimeNow( ) )
                            end

                            local Max2 = math.max( 0, ( math.floor( Max ) ) )
                            Text.Text = "ENDS IN " .. string.format( "%02d:%02d:%02d", Max2 // 3600, Max2 % 3600 // 60, Max2 % 60 )
                        end

                        task.wait( 0.5 )
                    end
                end )
            else
                if Text and Tag2 then
                    Text.Text = Tag2
                end
                if Sub and Sub2 then
                    Sub.Text = Sub2
                end
            end

            ClientState.ActiveMenu = "StarterOffer"
            ClientState.CursorFree = true
            Offer.Visible = true

            if UIScale then
                UIScale.Scale = 0.85
                TweenService:Create( UIScale, TweenInfo.new( 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
            end

            GamepadNav.Open( "StarterOffer", {
                root = Window,
                first = Yes,
                backLabel = "No",
                onBack = function()
                    if not Flag then
                        return
                    end

                    local Text
                    Flag = false
                    Offer.Visible = false
                    ClientState.CursorFree = false
                    GamepadNav.Close( "StarterOffer" )
                    Text = Value1 ~= "second" and "seen" or "seen2"
                    StarterOffer:FireServer( Text, "no" )
                end
            } )
        end )
    end
end

task.spawn( function()
    local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "Screens" ) )

    if not Success then
        return
    end

    local Value1, Text2Inner
    Value1 = nil
    Text2Inner = nil

    while true do
        local Max
        local StarterBonusUntil = LocalPlayer:GetAttribute( "StarterBonusUntil" )

        if type( StarterBonusUntil ) ~= "number" or LocalPlayer:GetAttribute( "StarterPackOwned" ) then
            Max = 0
        else
            Max = math.max( 0, StarterBonusUntil - workspace:GetServerTimeNow( ) )
        end
        if not Value1 then
            local Starter
            local Success2, Result2 = pcall( Result.Get, "ShopMenu" )

            if Success2 then
                if Result2 then
                    Starter = Result2:FindFirstChild( "Starter", true )
                else
                    Starter = Result2
                end
            else
                Starter = Success2
            end

            local Sub

            if Starter then
                Sub = Starter:FindFirstChild( "Sub" )
            else
                Sub = Starter
            end
            if Sub then
                Sub = Sub.Text
            end

            Value1 = nil
            Text2Inner = Sub
        end
        if Value1 then
            local Text3

            if Max > 0 then
                local Max2 = math.max( 0, ( math.floor( Max ) ) )
                local Text = Text2 .. " BONUS · " .. string.format( "%02d:%02d:%02d", Max2 // 3600, Max2 % 3600 // 60, Max2 % 60 ) .. " LEFT"

                if Text then
                    Text3 = Text
                else
                    Text3 = Text2Inner
                end
            else
                Text3 = Text2Inner
            end
            if Text3 and Value1.Text ~= Text3 then
                Value1.Text = Text3
            end
        end

        local Number = not ( Max > 0 ) and 5 or 1
        task.wait( Number )
    end
end )
