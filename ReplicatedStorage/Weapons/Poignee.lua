-- ReplicatedStorage.Weapons.Poignee
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local AnimWorkers = require( script.Parent:WaitForChild( "AnimWorkers" ) )
local Table = { ATTR = "PoigneeFixe", REF = "PoigneeArme", FOLDER = "PoigneesArmes" }
local IsClient = RunService:IsClient( )
function Table.On()
    local Flag = ReplicatedStorage:GetAttribute( Table.ATTR ) == true and true or false
    return Flag
end
function Table.OfChar( Object )
    local FoundChild

    if Object then
        FoundChild = Object:FindFirstChild( Table.REF )
    else
        FoundChild = Object
    end

    local Value = FoundChild and FoundChild:IsA( "ObjectValue" ) and FoundChild.Value or nil

    if not Value or not Value:IsA( "BasePart" ) or not Value.Parent then
        return nil
    end
    return Value
end
function Table.Template( Name )
    local FoundChild2
    local FoundChild = ReplicatedStorage:FindFirstChild( Table.FOLDER )

    if FoundChild then
        FoundChild2 = FoundChild:FindFirstChild( Name )
    else
        FoundChild2 = FoundChild
    end

    local FoundChild3 = if not FoundChild2 or not FoundChild2:IsA( "BasePart" ) or not FoundChild2 then nil else FoundChild2
    return FoundChild3
end
function Table.Ready( Object, Argument2 )
    local Flag = Object:GetAttribute( "PoigneeArmeActive" ) == Argument2 and true or false
    return Flag
end
function Table.Apply( Parent, Argument2 )
    if Parent:GetAttribute( "PoigneeArmeActive" ) == Argument2 then
        return true
    end

    local Template = Table.Template( Argument2 )

    if not Template then
        return false
    end

    AnimWorkers.Sync( )

    if Parent:GetAttribute( "PoigneeArmeActive" ) == Argument2 then
        return true
    end
    for Key, Value in Parent:GetChildren( ) do
        if Value:GetAttribute( "PoigneeRepere" ) then
            Value:Destroy( )
        end
    end
    for Key2, Value2 in Template:GetChildren( ) do
        if Value2:IsA( "Attachment" ) or Value2:IsA( "Sound" ) then
            local Clone = Value2:Clone( )
            Clone:SetAttribute( "PoigneeRepere", true )
            Clone.Parent = Parent
        end
    end

    Parent:SetAttribute( "PoigneeArmeActive", Argument2 )
    return true
end
function Table.Of( Object )
    if not Object then
        return nil
    end

    local Handle = Object:FindFirstChild( "Handle" )

    if Handle then
        return Handle
    end

    local Weapon = Object:GetAttribute( "Weapon" )

    if Weapon == nil then
        return nil
    end

    local Parent = Object.Parent

    if not Parent or not Parent:IsA( "Model" ) then
        return nil
    end

    local OfChar = Table.OfChar( Parent )

    if OfChar and IsClient and OfChar:GetAttribute( "PoigneeArmeActive" ) ~= Weapon then
        Table.Apply( OfChar, Weapon )
    end

    return OfChar
end
return Table
