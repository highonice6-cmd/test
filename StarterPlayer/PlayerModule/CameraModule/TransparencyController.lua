-- StarterPlayer.PlayerModule.CameraModule.TransparencyController
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local VRService = game:GetService( "VRService" )
local Table = {
    "BasePart",
    "Decal",
    "Beam",
    "ParticleEmitter",
    "Trail",
    "Fire",
    "Smoke",
    "Sparkles",
    "Explosion"
}
local CameraUtils = require( script.Parent:WaitForChild( "CameraUtils" ) )
local __index = { }
__index.__index = __index
function __index.new()
    local Self = setmetatable( { }, __index )
    Self.transparencyDirty = false
    Self.enabled = false
    Self.lastTransparency = nil
    Self.descendantAddedConn = nil
    Self.descendantRemovingConn = nil
    Self.toolDescendantAddedConns = { }
    Self.toolDescendantRemovingConns = { }
    Self.cachedParts = { }
    return Self
end
function __index.HasToolAncestor( Argument1, Argument2 )
    if Argument2.Parent == nil then
        return false
    end

    local IsA2
    assert( Argument2.Parent, "" )
    local IsA = Argument2.Parent:IsA( "Tool" )
    IsA2 = if IsA then IsA else Argument1:HasToolAncestor( Argument2.Parent )
    return IsA2
end
function __index.IsValidPartToModify( Argument1, Object )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        if Object:IsA( Value ) then
            return not Argument1:HasToolAncestor( Object )
        end
    end

    return false
end
function __index.CachePartsRecursive( Self, RecursiveName )
    if RecursiveName then
        if Self:IsValidPartToModify( RecursiveName ) then
            Self.cachedParts[ RecursiveName ] = true
            Self.transparencyDirty = true
        end
        for Key, Value in pairs( RecursiveName:GetChildren( ) ) do
            Self:CachePartsRecursive( Value )
        end
    end
end
function __index.TeardownTransparency( Argument1 )
    for Value in pairs( Argument1.cachedParts ) do
        Value.LocalTransparencyModifier = 0
    end

    Argument1.cachedParts = { }
    Argument1.transparencyDirty = true
    Argument1.lastTransparency = nil

    if Argument1.descendantAddedConn then
        Argument1.descendantAddedConn:disconnect( )
        Argument1.descendantAddedConn = nil
    end
    if Argument1.descendantRemovingConn then
        Argument1.descendantRemovingConn:disconnect( )
        Argument1.descendantRemovingConn = nil
    end
    for Key, Value3 in pairs( Argument1.toolDescendantAddedConns ) do
        Value3:Disconnect( )
        Argument1.toolDescendantAddedConns[ Key ] = nil
    end
    for Key2, Value5 in pairs( Argument1.toolDescendantRemovingConns ) do
        Value5:Disconnect( )
        Argument1.toolDescendantRemovingConns[ Key2 ] = nil
    end
end
function __index.SetupTransparency( Argument1, Argument2 )
    Argument1:TeardownTransparency( )

    if Argument1.descendantAddedConn then
        Argument1.descendantAddedConn:disconnect( )
    end

    Argument1.descendantAddedConn = Argument2.DescendantAdded:Connect( function( Key )
        if Argument1:IsValidPartToModify( Key ) then
            Argument1.cachedParts[ Key ] = true
            Argument1.transparencyDirty = true
            return
        end
        if Key:IsA( "Tool" ) then
            if Argument1.toolDescendantAddedConns[ Key ] then
                Argument1.toolDescendantAddedConns[ Key ]:Disconnect( )
            end

            local ToolDescendantAddedConns = Argument1.toolDescendantAddedConns
            ToolDescendantAddedConns[ Key ] = Key.DescendantAdded:Connect( function( Key )
                Argument1.cachedParts[ Key ] = nil

                if Key:IsA( "BasePart" ) or Key:IsA( "Decal" ) then
                    Key.LocalTransparencyModifier = 0
                end
            end )

            if Argument1.toolDescendantRemovingConns[ Key ] then
                Argument1.toolDescendantRemovingConns[ Key ]:disconnect( )
            end

            local ToolDescendantRemovingConns = Argument1.toolDescendantRemovingConns
            ToolDescendantRemovingConns[ Key ] = Key.DescendantRemoving:Connect( function( Key )
                wait( )

                if Argument2 and Key and Key:IsDescendantOf( Argument2 ) and Argument1:IsValidPartToModify( Key ) then
                    Argument1.cachedParts[ Key ] = true
                    Argument1.transparencyDirty = true
                end
            end )
        end
    end )

    if Argument1.descendantRemovingConn then
        Argument1.descendantRemovingConn:disconnect( )
    end

    Argument1.descendantRemovingConn = Argument2.DescendantRemoving:connect( function( Key )
        if Argument1.cachedParts[ Key ] then
            Argument1.cachedParts[ Key ] = nil
            Key.LocalTransparencyModifier = 0
        end
    end )
    Argument1:CachePartsRecursive( Argument2 )
end
function __index.Enable( Argument1, Enabled )
    if Argument1.enabled ~= Enabled then
        Argument1.enabled = Enabled
    end
end
function __index.SetSubject( Self, Object )
    local Parent

    if not Object or not Object:IsA( "Humanoid" ) then
        Parent = nil
    else
        Parent = Object.Parent
    end
    if Object and Object:IsA( "VehicleSeat" ) and Object.Occupant then
        Parent = Object.Occupant.Parent
    end
    if Parent then
        Self:SetupTransparency( Parent )
        return
    end
    Self:TeardownTransparency( )
    return
end
function __index.Update( Argument1, Amount )
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera and Argument1.enabled then
        local Magnitude3
        local Magnitude = ( CurrentCamera.Focus.Position - CurrentCamera.CoordinateFrame.Position ).magnitude

        if Magnitude < 2 then
            local Magnitude2 = 1 - ( Magnitude - 0.5 ) / 1.5

            if Magnitude2 then
                Magnitude3 = Magnitude2
            else
                Magnitude3 = 0
            end
        else
            Magnitude3 = 0
        end
        if Magnitude3 < 0.5 then
            Magnitude3 = 0
        end
        if not Argument1.lastTransparency or not ( Magnitude3 < 1 ) or not ( Argument1.lastTransparency < 0.95 ) then
            Argument1.transparencyDirty = true
        else
            local Magnitude4 = Magnitude3 - Argument1.lastTransparency
            local Result = 2.8 * Amount
            local Clamp = math.clamp( Magnitude4, -Result, Result )
            Magnitude3 = Argument1.lastTransparency + Clamp
        end

        local LocalTransparencyModifier = math.clamp( CameraUtils.Round( Magnitude3, 2 ), 0, 1 )

        if Argument1.transparencyDirty or Argument1.lastTransparency ~= LocalTransparencyModifier then
            for Value in pairs( Argument1.cachedParts ) do
                if not VRService.VREnabled or not VRService.AvatarGestures then
                    Value.LocalTransparencyModifier = LocalTransparencyModifier
                else
                    local Table = {
                        [ Enum.AccessoryType.Hat ] = true,
                        [ Enum.AccessoryType.Hair ] = true,
                        [ Enum.AccessoryType.Face ] = true,
                        [ Enum.AccessoryType.Eyebrow ] = true,
                        [ Enum.AccessoryType.Eyelash ] = true
                    }

                    if not Value.Parent:IsA( "Accessory" ) or not Table[ Value.Parent.AccessoryType ] then
                        if Value.Name == "Head" then
                            Value.LocalTransparencyModifier = LocalTransparencyModifier
                        else
                            Value.LocalTransparencyModifier = 0
                        end
                    else
                        Value.LocalTransparencyModifier = LocalTransparencyModifier
                    end
                end
            end

            Argument1.transparencyDirty = false
            Argument1.lastTransparency = LocalTransparencyModifier
        end
    end
end
return __index
