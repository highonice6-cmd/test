-- ReplicatedStorage.Weapons.ObjetTenu
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local IsServer = game:GetService( "RunService" ):IsServer( )
local Class = setmetatable( { }, { __mode = "k" } )
local Table = {
    FOLDER = "ObjetsTenus",
    STORE = "ObjetsTenusRanges",
    Of = function( Key )
        if not Key then
            return nil
        end

        local Item = Key:FindFirstChild( "Item" )

        if Item then
            return Item
        end

        local ObjetTenu2
        local ObjetTenu = Key:FindFirstChild( "ObjetTenu" )

        if ObjetTenu then
            local IsA = ObjetTenu:IsA( "ObjectValue" )

            if IsA then
                ObjetTenu2 = ObjetTenu.Value
            else
                ObjetTenu2 = IsA
            end
        else
            ObjetTenu2 = ObjetTenu
        end
        if ObjetTenu2 and ObjetTenu2.Parent then
            return ObjetTenu2
        end

        local Entry = Class[ Key ]

        if not Entry or not Entry.Parent then
            return nil
        end
        return Entry
    end
}
function Table.Folder()
    local Parent = workspace:FindFirstChild( "FX" )

    if not Parent then
        return nil
    end

    local FoundChild2
    local FoundChild = Parent:FindFirstChild( Table.FOLDER )

    if FoundChild or not IsServer then
        FoundChild2 = FoundChild
    else
        local Folder = Instance.new( "Folder" )
        Folder.Name = Table.FOLDER
        Folder.Parent = Parent
        FoundChild2 = Folder
    end

    return FoundChild2 or Parent
end

local function Store()
    local FoundChild2
    local Parent = game:GetService( "ServerStorage" )
    local FoundChild = Parent:FindFirstChild( Table.STORE )

    if FoundChild then
        FoundChild2 = FoundChild
    else
        local Folder = Instance.new( "Folder" )
        Folder.Name = Table.STORE
        Folder.Parent = Parent
        FoundChild2 = Folder
    end

    return FoundChild2
end

local Class2 = setmetatable( { }, { __mode = "k" } )

local function Link( Parent, Value )
    local ObjetTenu2
    local ObjetTenu = Parent:FindFirstChild( "ObjetTenu" )

    if not ObjetTenu or not ObjetTenu:IsA( "ObjectValue" ) then
        local ObjectValue = Instance.new( "ObjectValue" )
        ObjectValue.Name = "ObjetTenu"
        ObjectValue.Parent = Parent
        ObjetTenu2 = ObjectValue
    else
        ObjetTenu2 = ObjetTenu
    end
    if ObjetTenu2.Value ~= Value then
        ObjetTenu2.Value = Value
    end
    if not Class2[ Parent ] then
        Class2[ Parent ] = true
        Parent.AncestryChanged:Connect( function()
            if Parent:IsDescendantOf( game ) then
                return
            end
            if Value.Parent and Value.Parent ~= Parent then
                Value:Destroy( )
            end
        end )
    end
end

function Table.Park( Parent3 )
    if not IsServer then
        return nil
    end

    local Of = Table.Of( Parent3 )

    if not Of then
        return nil
    end

    Link( Parent3, Of )

    for Key, Value in Of:GetChildren( ) do
        if Value:IsA( "JointInstance" ) then
            if Value.Name == "ItemGrip" or Value.Name == "LocalGrip" then
                Value:Destroy( )
            end
        end
    end

    local Parent2
    local Parent = game:GetService( "ServerStorage" )
    local FoundChild = Parent:FindFirstChild( Table.STORE )

    if FoundChild then
        Parent2 = FoundChild
    else
        local Folder = Instance.new( "Folder" )
        Folder.Name = Table.STORE
        Folder.Parent = Parent
        Parent2 = Folder
    end
    if Of.Parent ~= Parent2 then
        Of.Parent = Parent2
    end

    return Of
end
function Table.TakeOut( Parent2 )
    local Of = Table.Of( Parent2 )

    if not Of then
        return nil
    end

    local Parent = Table.Folder( )

    if not Parent then
        return Of
    end
    if IsServer then
        Link( Parent2, Of )

        if Of.Parent ~= Parent then
            Of.Parent = Parent
        end

        return Of
    end
    if Of.Parent ~= Parent2 then
        return Of
    end

    Class[ Parent2 ] = Of

    if Of.Parent ~= Parent then
        Of.Parent = Parent
    end

    return Of
end
function Table.PutBack( Parent )
    local Entry = Class[ Parent ]
    Class[ Parent ] = nil

    if Entry and Entry.Parent and Entry.Parent ~= Parent then
        Entry.Parent = Parent
    end

    return Entry
end
function Table.WatchBackpacks( Argument1 )
    if not IsServer then
        return
    end

    local function OnTool( Object )
        if Object:IsA( "Tool" ) and Argument1( Object ) and Object:FindFirstChild( "Item" ) then
            Table.Park( Object )
        end
    end

    local function OnBackpack( Self )
        if not Self:IsA( "Backpack" ) then
            return
        end

        Self.ChildAdded:Connect( OnTool )

        for Key, Value in Self:GetChildren( ) do
            if Value:IsA( "Tool" ) and Argument1( Value ) and Value:FindFirstChild( "Item" ) then
                Table.Park( Value )
            end
        end
    end

    local function OnPlayer( Self )
        Self.ChildAdded:Connect( OnBackpack )
        local Backpack = Self:FindFirstChildOfClass( "Backpack" )

        if Backpack then
            OnBackpack( Backpack )
        end
    end

    Players.PlayerAdded:Connect( OnPlayer )

    for Key, Value in Players:GetPlayers( ) do
        Value.ChildAdded:Connect( OnBackpack )
        local Backpack = Value:FindFirstChildOfClass( "Backpack" )

        if Backpack then
            OnBackpack( Backpack )
        end
    end
end
return Table
