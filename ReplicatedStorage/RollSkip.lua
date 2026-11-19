-- ReplicatedStorage.RollSkip
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local GamePasses = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "GamePasses" ) )
local LocalPlayer = Players.LocalPlayer
local Table = { ID = "SkipRolls" }
function Table.Owned()
    return GamePasses.Owned( LocalPlayer, Table.ID )
end
function Table.Request( Callback )
    if Table.Owned( ) then
        Callback( )
        return
    end
    local Offer = GamePasses.Offer
    Offer( Table.ID, Callback )
    return
end
function Table.Bind( Self, Argument2 )
    local Text
    local Flag = true
    local Price = Self:FindFirstChild( "Price" )

    if Price then
        if not Price:IsA( "TextLabel" ) or not Price then
            Text = Price:FindFirstChild( "Text" )
        else
            Text = Price
        end
    else
        Text = Price
    end

    local function Refresh()
        if not Flag then
            return
        end

        local Owned = Table.Owned( )

        if Price and Price:IsA( "GuiObject" ) then
            Price.Visible = not Owned
        end
        if Text and Text:IsA( "TextLabel" ) and not Owned then
            Text.Text = GamePasses.PriceText( Table.ID, Refresh )
        end
    end

    local TableInner = {
        Self.Activated:Connect( function()
            Table.Request( function()
                if Flag then
                    Argument2( )
                end
            end )
        end ),
        GamePasses.Changed:Connect( Refresh )
    }
    Refresh( )

    local function Callback()
        local Value1
        Flag = false
        Value1 = nil

        for Key, Value in TableInner, nil, nil do
            Value:Disconnect( )
        end
    end

    return Callback
end
return Table
