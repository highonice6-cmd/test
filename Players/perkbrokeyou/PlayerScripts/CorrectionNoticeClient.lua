-- Players.perkbrokeyou.PlayerScripts.CorrectionNoticeClient
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
local TweenService = game:GetService( "TweenService" )
local HttpService = game:GetService( "HttpService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local CorrectionNoticeSeen = ReplicatedStorage:WaitForChild( "CorrectionNoticeSeen" )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Get = Screens.Get( "CorrectionNotice" )
local Menu = Get:WaitForChild( "Menu" )
local Window = Menu:WaitForChild( "Window" )
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
local Close = Window:WaitForChild( "Close" )
local Detail = Window:WaitForChild( "Detail" )
local Date = Detail:WaitForChild( "Date" )
local Headline = Detail:WaitForChild( "Headline" )
local Body = Detail:WaitForChild( "Body" )
local Text = Body:WaitForChild( "Text" )
local Ok = Detail:WaitForChild( "Buttons" ):WaitForChild( "Ok" )
Menu.Visible = false
Screens.SetShown( Get, true )
local Table = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
}
local Table2 = {
    RiotShield = "Riot Shield",
    CashBag500K = "Cash Bag $200K",
    CashBag1M = "Cash Bag $500K",
    CashBag3M = "Cash Bag $800K",
    CashBag5M = "Cash Bag $1.2M"
}

local function DateText( Argument1 )
    local Date = os.date( "!*t", Argument1 )
    local Entry = Table[ Date.month ]
    local Day = Date.day
    return string.upper( Entry .. " " .. Day .. ", " .. Date.year )
end

local function AtText( TextName )
    local Match, Match2, Match3, Match4 = tostring( TextName or "" ):match( "^(%d+)/(%d+) (%d+):(%d+)" )

    if Match then
        local Entry = Table[ tonumber( Match2 ) ] or "?"
        return ( "%s %d, %s:%s UTC" ):format( Entry, tonumber( Match ), Match3, Match4 )
    end
    return nil
end

local function ItemsText( List )
    local Table2Inner
    local Table = { }
    Table2Inner = type( List ) == "table" and List or { }
    local Value1 = nil

    for Key, Value in Table2Inner, nil, nil do
        table.insert( Table, ( "%s x%d" ):format( Table2[ Key ] or Key, tonumber( Value ) or 1 ) )
    end

    table.sort( Table )
    return table.concat( Table, ", " )
end

local function Money( Argument1 )
    return MoneyFormat( ( math.abs( ( math.floor( Argument1 ) ) ) ) )
end

local function Build( List )
    local Value1, Number2
    local TableInner = { }
    local Table2 = { }
    Value1 = nil
    Number2 = 0

    for Key, Value in List, nil, nil do
        Number2 = math.max( Number2, tonumber( Value.t ) or 0 )
        Table2[ Value.kind ] = true
        local ItemsText2 = ItemsText( Value.items )
        local Number3 = tonumber( Value.money ) or 0

        if Value.kind == "rollback" then
            local Format
            local Match, Match2, Match3, Match4 = tostring( Value.at or "" ):match( "^(%d+)/(%d+) (%d+):(%d+)" )

            if Match then
                local Entry2 = Table[ tonumber( Match2 ) ] or "?"
                Format = ( "%s %d, %s:%s UTC" ):format( Entry2, tonumber( Match ), Match3, Match4 )
            else
                Format = nil
            end
            if Format then
                table.insert( TableInner, ( "Your account took part in the duplication exploit. Your money, bank, safe, carried items, unlocks and cars were reset to how they were on <b>%s</b>, before your first duplication. Everything you bought with Robux since then has been given back." ):format( Format ) )
            else
                table.insert( TableInner, "Your account took part in the duplication exploit and was created during it, so it was reset to a <b>fresh start</b>. Everything you bought with Robux has been given back." )
            end
        elseif Value.kind == "remove" then
            local Text2

            if ItemsText2 == "" then
                Text2 = "Your account received items created by the duplication exploit."
            else
                Text2 = "Your account received items created by the duplication exploit." .. ( " Removed: <b>%s</b>." ):format( ItemsText2 )
            end
            if Number3 > 0 then
                Text2 = Text2 .. ( " Money taken back (resale of duplicated items): <b>%s</b>." ):format( Money( Number3 ) )
            end

            table.insert( TableInner, Text2 )
        elseif Value.kind == "auto" then
            local Text3

            if ItemsText2 == "" then
                Text3 = "A copy created by the duplication bug was removed from your account"
            else
                Text3 = "A copy created by the duplication bug was removed from your account" .. ( ": <b>%s</b>" ):format( ItemsText2 )
            end
            if Number3 > 0 then
                Text3 = Text3 .. ( " (and <b>%s</b> taken back for the copy you had cashed or sold)" ):format( Money( Number3 ) )
            end

            table.insert( TableInner, Text3 .. "." )
        elseif Value.kind == "restore" then
            table.insert( TableInner, "Our team reviewed your account: an earlier correction was cancelled and your previous state was restored." )
        elseif Value.kind == "money" then
            table.insert( TableInner, ( "Our team reviewed your correction and gave back <b>%s</b>." ):format( Money( Number3 ) ) )
        end
    end

    local Rollback2
    local Rollback = Table2.rollback

    if Rollback then
        Rollback2 = Rollback
    else
        local Remove = Table2.remove

        if Remove then
            Rollback2 = Remove
        else
            Rollback2 = Table2.auto
        end
    end

    local Number = tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0

    if Rollback2 and Number < 0 then
        table.insert( TableInner, ( "Your balance is negative (<b>-%s</b>): you can't buy anything until it is back above $0. Every dollar you earn pays it back." ):format( Money( Number ) ) )
    end
    if Rollback2 then
        table.insert( TableInner, "This is not a ban: the duplication bug was fixed on November 8. If you think this is a mistake, contact an admin with your Roblox username." )
    end

    local TextInner

    if Table2.rollback then
        TextInner = "Your account was reset to an earlier state"
    elseif Rollback2 then
        TextInner = "Duplicated items were removed from your account"
    else
        TextInner = "Your correction was reviewed"
    end

    local Time
    Headline.Text = TextInner

    if not ( Number2 > 0 ) or not Number2 then
        Time = os.time( )
    else
        Time = Number2
    end

    local DateInner = os.date( "!*t", Time )
    local Entry = Table[ DateInner.month ]
    local Day = DateInner.day
    Date.Text = string.upper( Entry .. " " .. Day .. ", " .. DateInner.year )
    Text.Text = table.concat( TableInner, "\n\n" )
    Body.CanvasPosition = Vector2.zero
end

local function FitText()
    local Y = Window.AbsoluteSize.Y

    if Y > 0 then
        Text.TextSize = math.max( 12, ( math.floor( Y * ( tonumber( Text:GetAttribute( "TextScale" ) ) or 0.032 ) ) ) )
    end
end

Window:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( FitText )
local Flag = false
local Value1 = nil
local Value2 = nil
local Callback = nil

local function SetOpen( Open )
    if Open == Flag then
        return
    end

    Flag = Open

    if Open then
        local Y = Window.AbsoluteSize.Y

        if Y > 0 then
            Text.TextSize = math.max( 12, ( math.floor( Y * ( tonumber( Text:GetAttribute( "TextScale" ) ) or 0.032 ) ) ) )
        end

        Menu.Visible = true

        if Value1 then
            Value1:Cancel( )
        end
        if UIScale then
            UIScale.Scale = 0.92
            Value1 = TweenService:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
            Value1:Play( )
        end

        ClientState.ActiveMenu = "CorrectionNotice"
        ClientState.CursorFree = true
        GamepadNav.Open( "CorrectionNotice", {
            root = Window,
            first = Ok,
            backLabel = "Close",
            onBack = function()
                Callback( )
            end,
            hints = { { Enum.KeyCode.Thumbstick2, "Scroll" } }
        } )
        return
    end
    if Value1 then
        Value1:Cancel( )
        Value1 = nil
    end
    if UIScale then
        UIScale.Scale = 1
    end

    Menu.Visible = false
    ClientState.CursorFree = false
    GamepadNav.Close( "CorrectionNotice" )
    return
end

Callback = function()
    if Value2 then
        local Value1Inner
        local Table = { }
        Value1Inner = nil

        for Key, Value in Value2, nil, nil do
            if type( Value.id ) == "string" then
                table.insert( Table, Value.id )
            end
        end

        CorrectionNoticeSeen:FireServer( Table )
        Value2 = nil
    end
    if Flag == false then
        return
    end

    Flag = false

    if Value1 then
        Value1:Cancel( )
        Value1 = nil
    end
    if UIScale then
        UIScale.Scale = 1
    end

    Menu.Visible = false
    ClientState.CursorFree = false
    GamepadNav.Close( "CorrectionNotice" )
end

Ok.Activated:Connect( function()
    Callback( )
end )
Close.Activated:Connect( function()
    Callback( )
end )
RunService.Heartbeat:Connect( function( Argument1 )
    if not Flag then
        return
    end
    if ClientState.ActiveMenu == "CorrectionNotice" then
        if not ClientState.CursorFree then
            ClientState.CursorFree = true
        end

        return
    end
    if Flag == false then
        return
    end

    Flag = false

    if Value1 then
        Value1:Cancel( )
        Value1 = nil
    end
    if UIScale then
        UIScale.Scale = 1
    end

    Menu.Visible = false
    ClientState.CursorFree = false
    GamepadNav.Close( "CorrectionNotice" )
    return
end )

local function Free()
    if LocalPlayer:GetAttribute( "InTutorial" ) or LocalPlayer:GetAttribute( "Onboarding" ) ~= false or LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        return false
    end
    if ClientState.WardrobeOpen or ClientState.CaseRolling or ClientState.BetaReveal or ClientState.IntroCinematic then
        return false
    end
    if ClientState.CursorFree then
        return false
    end
    if LocalPlayer:GetAttribute( "StarterOffer" ) then
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

local function Pending()
    local CorrectionNotice = PlayerGui:GetAttribute( "CorrectionNotice" )

    if type( CorrectionNotice ) ~= "string" or CorrectionNotice == "" then
        return nil
    end

    local Result2
    local Success, Result = pcall( HttpService.JSONDecode, HttpService, CorrectionNotice )
    Result2 = Success and type( Result ) == "table" and #Result > 0 and Result or nil
    return Result2
end

task.spawn( function()
    local Clock = nil

    while true do
        local Result2

        if Flag then
            Result2 = nil
        else
            local CorrectionNotice = PlayerGui:GetAttribute( "CorrectionNotice" )

            if type( CorrectionNotice ) ~= "string" or CorrectionNotice == "" then
                Result2 = nil
            else
                local Success, Result = pcall( HttpService.JSONDecode, HttpService, CorrectionNotice )

                if not Success or type( Result ) ~= "table" or not ( #Result > 0 ) or not Result then
                    Result2 = nil
                else
                    Result2 = Result
                end
            end
            if not Result2 then
                Result2 = nil
            end
        end
        if not Result2 or not Free( ) then
            Clock = nil
        else
            local Clock2

            if Clock then
                Clock2 = Clock
            else
                Clock2 = os.clock( )
            end
            if os.clock( ) - Clock2 >= 1.5 then
                Value2 = Result2
                Build( Result2 )
                SetOpen( true )
                Clock = nil
            else
                Clock = Clock2
            end
        end

        task.wait( 0.25 )
    end
end )
