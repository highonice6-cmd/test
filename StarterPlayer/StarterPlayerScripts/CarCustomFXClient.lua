-- StarterPlayer.StarterPlayerScripts.CarCustomFXClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local CollectionService = game:GetService( "CollectionService" )
local Table = { }

local function Sync( Key )
    local Flag = if Key:GetAttribute( "NeonRainbow" ) then true else nil
    Table[ Key ] = Flag
end

local function Add( Key )
    local Flag = if Key:GetAttribute( "NeonRainbow" ) then true else nil
    Table[ Key ] = Flag
    Key:GetAttributeChangedSignal( "NeonRainbow" ):Connect( function()
        local Flag = if Key:GetAttribute( "NeonRainbow" ) then true else nil
        Table[ Key ] = Flag
    end )
end

for Key, Value in CollectionService:GetTagged( "Vehicle" ) do
    local Flag = if Value:GetAttribute( "NeonRainbow" ) then true else nil
    Table[ Value ] = Flag
    Value:GetAttributeChangedSignal( "NeonRainbow" ):Connect( function()
        local Flag = if Value:GetAttribute( "NeonRainbow" ) then true else nil
        Table[ Value ] = Flag
    end )
end

CollectionService:GetInstanceAddedSignal( "Vehicle" ):Connect( Add )
CollectionService:GetInstanceRemovedSignal( "Vehicle" ):Connect( function( Key )
    Table[ Key ] = nil
end )
RunService.Heartbeat:Connect( function()
    if not next( Table ) then
        return
    end

    local Value1
    local Color = Color3.fromHSV( os.clock( ) * 0.18 % 1, 0.85, 1 )
    Value1 = nil

    for Value in Table, nil, nil do
        local CC_Underglow = Value:FindFirstChild( "CC_Underglow" )

        if CC_Underglow then
            CC_Underglow.Color = Color
            local SurfaceLight = CC_Underglow:FindFirstChildOfClass( "SurfaceLight" )

            if SurfaceLight then
                SurfaceLight.Color = Color
            end
        end
    end
end )
