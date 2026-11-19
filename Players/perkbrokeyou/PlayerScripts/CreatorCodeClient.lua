-- Players.perkbrokeyou.PlayerScripts.CreatorCodeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local CreatorCode = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "CreatorCode" )
local Window = Screens.Get( "ShopMenu" ):WaitForChild( "Window" )
local Window2 = Players.LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "EffectsMenu", math.huge ):WaitForChild( "Window" )
local Table = {
    Window:WaitForChild( "Scroll" ):WaitForChild( "Main" ):WaitForChild( "CreatorCode" ),
    Window2:WaitForChild( "CreatorCode" )
}
local Table2 = { }
Value1 = nil

for Key, Value in Table, nil, nil do
    table.insert( Table2, Value:WaitForChild( "Box" ) )
end

local Value2
local Flag = false

local function SetAll( Text, Argument2 )
    local Value1
    Flag = true
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value ~= Argument2 and Value.Text ~= Text then
            Value.Text = Text
        end
    end

    Flag = false
end

Value2 = nil

for Key2, Value3 in Table2, nil, nil do
    Value3:GetPropertyChangedSignal( "Text" ):Connect( function()
        if not Flag then
            local Value1
            local Text = Value3.Text
            Flag = true
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                if Value ~= Value3 and Value.Text ~= Text then
                    Value.Text = Text
                end
            end

            Flag = false
        end
    end )
end

local Value4
local Flag2 = false

local function Send( Entry )
    if Flag2 or Entry.Text:gsub( "%s", "" ) == "" then
        return
    end

    Flag2 = true
    local InvokeServer = CreatorCode.InvokeServer
    local Success, Result = pcall( InvokeServer, CreatorCode, Entry.Text )
    Flag2 = false

    if not Success or type( Result ) ~= "table" or not Result.ok then
        local Msg
        local Error = Notify.Error
        Msg = Success and type( Result ) == "table" and Result.msg or "Something went wrong, try again"
        Error( Msg )
        return
    end
    local Text
    local Code = Result.code
    Text = if Code then Code else Entry.Text
    local Value1
    Flag = true
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value ~= nil and Value.Text ~= Text then
            Value.Text = Text
        end
    end

    Flag = false
    local Announce = Notify.Announce
    Announce( "CREATOR CODE", Result.msg, 4 )
    return
end

Value4 = nil

for Key3, Value5 in Table, nil, nil do
    local Entry = Table2[ Key3 ]
    Value5:WaitForChild( "Apply" ).Activated:Connect( function()
        Send( Entry )
    end )
    Entry.FocusLost:Connect( function( Argument1 )
        if Argument1 then
            Send( Entry )
        end
    end )
end

local Value6
local Table3 = {
    Window2:FindFirstChild( "GiftPicker" ),
    Window2:FindFirstChild( "Showcase" )
}
local Main = Window.Scroll.Main
local Table4 = {
    Main:FindFirstChild( "CreatorSection" ),
    Main:FindFirstChild( "CreatorHint" ),
    Table[ 1 ]
}

local function IsOff()
    local Flag = ReplicatedStorage:GetAttribute( "CreatorCodeOff" ) == true and true or false
    return Flag
end

local function UpdateEffectsRow()
    local Flag

    if ReplicatedStorage:GetAttribute( "CreatorCodeOff" ) == true then
        Flag = true
    else
        Flag = false
    end

    local Value1 = nil

    for Key, Value in Table3, nil, nil do
        if Value and Value.Visible then
            Flag = true
        end
    end

    local Item = Table[ 2 ]
    Item.Visible = not Flag
end

Value6 = nil

for Key4, Value7 in Table3, nil, nil do
    if Value7 then
        Value7:GetPropertyChangedSignal( "Visible" ):Connect( UpdateEffectsRow )
    end
end

local Value8

local function UpdateShop()
    local Value1 = nil

    for Key, Value in Table4, nil, nil do
        if Value then
            local Flag = ReplicatedStorage:GetAttribute( "CreatorCodeOff" ) == true and true or false
            Value.Visible = not Flag
        end
    end
end

ReplicatedStorage:GetAttributeChangedSignal( "CreatorCodeOff" ):Connect( function()
    local Value1 = nil

    for Key, Value in Table4, nil, nil do
        if Value then
            local Flag2 = ReplicatedStorage:GetAttribute( "CreatorCodeOff" ) == true and true or false
            Value.Visible = not Flag2
        end
    end

    local Flag

    if ReplicatedStorage:GetAttribute( "CreatorCodeOff" ) == true then
        Flag = true
    else
        Flag = false
    end

    local Value2 = nil

    for Key2, Value3 in Table3, nil, nil do
        if Value3 and Value3.Visible then
            Flag = true
        end
    end

    local Item = Table[ 2 ]
    Item.Visible = not Flag
end )
Value8 = nil

for Key5, Value9 in Table4, nil, nil do
    if Value9 then
        local Flag4 = ReplicatedStorage:GetAttribute( "CreatorCodeOff" ) == true and true or false
        Value9.Visible = not Flag4
    end
end

local Flag3

if ReplicatedStorage:GetAttribute( "CreatorCodeOff" ) == true then
    Flag3 = true
else
    Flag3 = false
end

local Value10 = nil

for Key6, Value11 in Table3, nil, nil do
    if Value11 and Value11.Visible then
        Flag3 = true
    end
end

local Item = Table[ 2 ]
Item.Visible = not Flag3
