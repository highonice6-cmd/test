-- StarterPlayer.StarterPlayerScripts.AudioSettingsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Parent = game:GetService( "SoundService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local Table = {
    Weapons = "VolWeapons",
    Vehicles = "VolVehicles",
    Effects = "VolEffects",
    Music = "VolMusic",
    Cases = "VolEffects"
}
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Table2 = { }
Value1 = nil

for Value in Table, nil, nil do
    local SoundGroup = Instance.new( "SoundGroup" )
    SoundGroup.Name = "Master_" .. Value
    SoundGroup.Volume = Controls.Settings[ Table[ Value ] ] or 1
    SoundGroup.Parent = Parent
    Table2[ Value ] = SoundGroup
end

local Value2

local function IsMaster( Argument1 )
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value == Argument1 then
            return true
        end
    end

    return false
end

local function GroupCategory( Self )
    if Self:GetAttribute( "CaseSound" ) then
        return "Cases"
    end

    local Name = Self.Name

    if Name:sub( 1, 6 ) == "GunFX_" then
        return "Weapons"
    end
    if Name:find( "Engine" ) or Name:find( "Train" ) or Name:find( "Tire" ) or Name:find( "Burnout" ) or Name:find( "Vehicle" ) or Name:find( "Skid" ) then
        return "Vehicles"
    end
    if Name:find( "Music" ) then
        return "Music"
    end
    return "Effects"
end

local function SoundCategory( Self )
    if Self:GetAttribute( "CaseSound" ) then
        return "Cases"
    end
    if Self.Name:find( "Music" ) then
        return "Music"
    end

    local Find = WorldRefs.Find( "Cars" )

    if Find and Self:IsDescendantOf( Find ) then
        return "Vehicles"
    end
    if Self:FindFirstAncestorWhichIsA( "Tool" ) then
        return "Weapons"
    end

    local Parent = Self.Parent

    while Parent do
        if Parent == game then
            break
        end

        local Name = Parent.Name

        if Name == "GunAudioLocal" or Name == "HitAudio" or Name == "MetalImpactSound" then
            return "Weapons"
        end

        Parent = Parent.Parent
    end

    return "Effects"
end

local function AdoptGroup( Self )
    if Self then
        local Value1, Flag
        Value1 = nil

        for Key, Value in Table2, nil, nil do
            if Value == Self then
                Flag = true

                if Flag or Self.Parent == nil then
                    return
                end
                if not Self.Parent or not Self.Parent:IsA( "SoundGroup" ) then
                    Self.Parent = Table2[ GroupCategory( Self ) ]
                    return
                end
                return
            end
        end

        Flag = false

        if not Flag and Self.Parent ~= nil then
            if not Self.Parent or not Self.Parent:IsA( "SoundGroup" ) then
                Self.Parent = Table2[ GroupCategory( Self ) ]
                return
            end
            return
        end
    end
end

local function AdoptSound( Self )
    if Self.SoundGroup then
        local SoundGroup = Self.SoundGroup

        if SoundGroup then
            local Value1, Flag
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                if Value == SoundGroup then
                    Flag = true

                    if Flag then
                        return
                    end
                    if SoundGroup.Parent == nil then
                        return
                    end
                    if not SoundGroup.Parent or not SoundGroup.Parent:IsA( "SoundGroup" ) then
                        SoundGroup.Parent = Table2[ GroupCategory( SoundGroup ) ]
                        return
                    end
                    return
                end
            end

            Flag = false

            if not Flag then
                if SoundGroup.Parent == nil then
                    return
                end
                if not SoundGroup.Parent or not SoundGroup.Parent:IsA( "SoundGroup" ) then
                    SoundGroup.Parent = Table2[ GroupCategory( SoundGroup ) ]
                    return
                end
                return
            end
        end
    else
        Self.SoundGroup = Table2[ SoundCategory( Self ) ]
    end
end

local function OnAdded( p1 )
    -- Could not structure function #6
end

local Table3 = {
    workspace,
    Parent,
    game:GetService( "Players" ).LocalPlayer,
    ReplicatedStorage
}
Value2 = nil

for Key, Value3 in Table3, nil, nil do
    for Key2, Value4 in Value3:GetDescendants( ) do
        OnAdded( Value4 )
    end

    Value3.DescendantAdded:Connect( OnAdded )
end

local Number = 0

local function Apply()
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Volume
        local Entry = Controls.Settings[ Table[ Key ] ] or 1
        Volume = if Key ~= "Cases" or not Entry then Entry * ( 1 - Number ) else Entry
        Value.Volume = Volume
    end
end

Controls.SettingsChanged:Connect( function()
    Apply( )
end )
game:GetService( "RunService" ).Heartbeat:Connect( function( Argument1 )
    local NumberInner = not ClientState.CaseRolling and 0 or 1

    if Number == NumberInner then
        return
    end

    local Number2 = not ( Number < NumberInner ) and 1 or 2.857142857142857
    local Max

    if Number < NumberInner then
        local Min = math.min( NumberInner, Number + Number2 * Argument1 )

        if Min then
            Max = Min
        else
            Max = math.max( NumberInner, Number - Number2 * Argument1 )
        end
    else
        Max = math.max( NumberInner, Number - Number2 * Argument1 )
    end

    Number = Max
    Apply( )
end )

-- Could not structure function #5
