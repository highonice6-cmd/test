-- StarterPlayer.StarterPlayerScripts.RankGlowClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local RunService = game:GetService( "RunService" )
local Color32 = Color3.new( 1, 1, 1 )
local CurrentCamera = workspace.CurrentCamera
local Table = { }
local Class = setmetatable( { }, { __mode = "k" } )

local function Add( Value )
    if not Value:IsA( "SurfaceAppearance" ) then
        return
    end

    local Model = Value:FindFirstAncestorWhichIsA( "Model" )

    while Model do
        if not Model.Parent or not Model.Parent:IsA( "Model" ) or Model.Parent:IsA( "WorldRoot" ) then
            break
        end

        Model = Model.Parent
    end
    if Model and Model:FindFirstChildOfClass( "Humanoid" ) then
        return
    end

    local Base
    local TableInner = { }
    local GlowBase = Value:GetAttribute( "GlowBase" )
    Base = if GlowBase then GlowBase else Value.EmissiveStrength
    local Tint
    TableInner.base = Base
    local GlowTint = Value:GetAttribute( "GlowTint" )
    Tint = if GlowTint then GlowTint else Value.EmissiveTint
    TableInner.tint = Tint
    TableInner.model = Model
    Table[ Value ] = TableInner
end

for Key, Value in CollectionService:GetTagged( "RankGlow" ) do
    Add( Value )
end

CollectionService:GetInstanceAddedSignal( "RankGlow" ):Connect( Add )
CollectionService:GetInstanceRemovedSignal( "RankGlow" ):Connect( function( Key )
    Table[ Key ] = nil
end )
local Number = 0
RunService.RenderStepped:Connect( function()
    local Clock = os.clock( )

    if Clock - Number < 0.03333333333333333 then
        return
    end

    local Value1
    Number = Clock
    local Position = CurrentCamera.CFrame.Position
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Parent = Key.Parent

        if Parent then
            if not Value.model or not Value.model.Parent or Value.model:FindFirstChildOfClass( "Humanoid" ) then
                local Model = Parent:FindFirstAncestorWhichIsA( "Model" )

                while Model do
                    if not Model.Parent or not Model.Parent:IsA( "Model" ) or Model.Parent:IsA( "WorldRoot" ) then
                        break
                    end

                    Model = Model.Parent
                end
                if Model and Model:FindFirstChildOfClass( "Humanoid" ) then
                    if Key.EmissiveStrength ~= Value.base then
                        Key.EmissiveStrength = Value.base
                    end
                    if Key.EmissiveTint ~= Value.tint then
                        Key.EmissiveTint = Value.tint
                    end

                    Table[ Key ] = nil
                    continue
                end
                Value.model = Model
            end
            if not Parent:IsA( "BasePart" ) or not ( ( Parent.Position - Position ).Magnitude > 90 ) then
                local Entry2
                local Model2 = Value.model or Parent
                local Entry = Class[ Model2 ]

                if Entry then
                    Entry2 = Entry
                else
                    local Random = math.random( ) * 2 * 3.141592653589793
                    Class[ Model2 ] = Random
                    Entry2 = Random
                end

                local Sin = math.sin( Clock * 2.1 + Entry2 ) * 0.5 + 0.5
                local Sin2 = math.sin( Clock * 3.7 + Entry2 * 1.7 ) * 0.5 + 0.5
                local Sin3 = ( Sin * 0.8 + Sin2 * 0.2 ) * 0.44999999999999996 + 0.7
                Key.EmissiveStrength = Value.base * Sin3
                Key.EmissiveTint = Value.tint:Lerp( Color32, Sin * 0.18 * Sin )
            end
        else
            Table[ Key ] = nil
        end
    end
end )
