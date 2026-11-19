-- StarterPlayer.StarterPlayerScripts.EasterEggNamesClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local Table = { }

local function Track( Key )
    if Key:IsA( "UIGradient" ) and Key.Name == "Rainbow" and Key:FindFirstAncestorOfClass( "BillboardGui" ) and Key:FindFirstAncestorOfClass( "BillboardGui" ).Name == "EasterEggName" then
        Table[ Key ] = true
    end
end

workspace.DescendantAdded:Connect( Track )

for Key, Value in workspace:GetDescendants( ) do
    if Value:IsA( "UIGradient" ) and Value.Name == "Rainbow" and Value:FindFirstAncestorOfClass( "BillboardGui" ) and Value:FindFirstAncestorOfClass( "BillboardGui" ).Name == "EasterEggName" then
        Table[ Value ] = true
    end
end

workspace.DescendantRemoving:Connect( function( Key )
    Table[ Key ] = nil
end )
local Number = 0
RunService.RenderStepped:Connect( function( Argument1 )
    if not next( Table ) then
        return
    end

    Number = Number + Argument1

    if Number < 0.03333333333333333 then
        return
    end

    Number = 0
    local Clock = os.clock( ) * 0.25 % 1
    local Create = table.create( 7 )
    local I = 0

    for I = 0, 6 do
        Create[ I + 1 ] = ColorSequenceKeypoint.new( I / 6, Color3.fromHSV( ( I / 6 + Clock ) % 1, 0.85, 1 ) )
    end

    local Value1
    local Color = ColorSequence.new( Create )
    Value1 = nil

    for Value in Table, nil, nil do
        Value.Color = Color
    end
end )
