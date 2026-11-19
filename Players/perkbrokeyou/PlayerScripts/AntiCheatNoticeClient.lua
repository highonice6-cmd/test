-- Players.perkbrokeyou.PlayerScripts.AntiCheatNoticeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Transparency
local Players = game:GetService( "Players" )
local TweenService = game:GetService( "TweenService" )
local AntiCheatNotice = game:GetService( "ReplicatedStorage" ):WaitForChild( "Remotes" ):WaitForChild( "AntiCheatNotice" )
local LocalPlayer = Players.LocalPlayer
local Table = { sync = "Connection issue: your position was resynced" }
local Get = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) ).Get( "AntiCheatNotice" )
Get.Visible = false
local Panel = Get:WaitForChild( "Panel" )
local Text = Panel:WaitForChild( "Text" )
local UIStroke = Panel:FindFirstChildOfClass( "UIStroke" )
local UIStroke2 = Text:FindFirstChildOfClass( "UIStroke" )
local BackgroundTransparency = Panel.BackgroundTransparency
local TextTransparency = Text.TextTransparency
Transparency = UIStroke and UIStroke.Transparency or 0
local Transparency2 = UIStroke2 and UIStroke2.Transparency or 0

local function FadeAll( Argument1, Argument2 )
    local BackgroundTransparencyInner
    local Table = { }
    BackgroundTransparencyInner = Argument2 and BackgroundTransparency or 1
    local TextTransparencyInner
    Table.BackgroundTransparency = BackgroundTransparencyInner
    TweenService:Create( Panel, Argument1, Table ):Play( )
    local Table2 = { }
    TextTransparencyInner = Argument2 and TextTransparency or 1
    Table2.TextTransparency = TextTransparencyInner
    TweenService:Create( Text, Argument1, Table2 ):Play( )

    if UIStroke then
        local TransparencyInner
        local Table3 = { }
        TransparencyInner = Argument2 and Transparency or 1
        Table3.Transparency = TransparencyInner
        TweenService:Create( UIStroke, Argument1, Table3 ):Play( )
    end
    if UIStroke2 then
        local Transparency2Inner
        local Table4 = { }
        Transparency2Inner = Argument2 and Transparency2 or 1
        Table4.Transparency = Transparency2Inner
        TweenService:Create( UIStroke2, Argument1, Table4 ):Play( )
    end
end

local Number = 0
AntiCheatNotice.OnClientEvent:Connect( function( Key )
    local TextInner = Table[ Key ]

    if not TextInner then
        return
    end

    Number = Number + 1
    Text.Text = TextInner
    Get.Visible = true
    Panel.BackgroundTransparency = 1
    Text.TextTransparency = 1

    if UIStroke then
        UIStroke.Transparency = 1
    end
    if UIStroke2 then
        UIStroke2.Transparency = 1
    end

    FadeAll( TweenInfo.new( 0.2 ), true )
    task.wait( 2.6 )

    if Number ~= Number then
        return
    end

    FadeAll( TweenInfo.new( 0.4 ), false )
    task.wait( 0.45 )

    if Number == Number then
        Get.Visible = false
    end
end )
