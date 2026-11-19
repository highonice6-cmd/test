-- StarterPlayer.StarterPlayerScripts.HealClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #14

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = false

    if Upvalue2.Crouching then
        Upvalue2.Crouching = false
        Upvalue3:FireServer( false )
    end
end

Upvalue2.HealItem = nil
Upvalue2.HealStart = nil
Upvalue2.Healing = false
Upvalue4 = false
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if not workspace:GetAttribute( "RankedMatch" ) then
    return false
end

local MatchState
local RankedShared = Upvalue1:FindFirstChild( "RankedShared" )

if RankedShared then
    MatchState = RankedShared:FindFirstChild( "MatchState" )
else
    MatchState = RankedShared
end

local Flag

if MatchState == nil then
    Flag = false
elseif MatchState:GetAttribute( "Phase" ) == "countdown" then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag, Entry2, HealItem

if workspace:GetAttribute( "RankedMatch" ) then
    local MatchState
    local RankedShared = Upvalue1:FindFirstChild( "RankedShared" )

    if RankedShared then
        MatchState = RankedShared:FindFirstChild( "MatchState" )
    else
        MatchState = RankedShared
    end
    if MatchState == nil then
        Flag = false
    elseif MatchState:GetAttribute( "Phase" ) == "countdown" then
        Flag = true
    else
        Flag = false
    end
else
    Flag = false
end
if Flag then
    return
end

local Humanoid
local Character = Upvalue2.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local Item = Self:GetAttribute( "Item" )

if not Humanoid or Humanoid.Health <= 0 or Self.Parent ~= Character or not Upvalue3.Items[ Item ] then
    return
end
if Upvalue4.HealItem or Upvalue4.CursorFree then
    return
end

local Entry = Upvalue3.Items[ Item ]

if Entry.Armor then
    local Armor = Character:GetAttribute( "Armor" ) or 0

    if Upvalue5.Armor.Max <= Armor then
        Upvalue4.HealDenied = os.clock( )
        Upvalue4.HealDeniedText = "ARMOR FULL"
        return
    end
    Entry2 = Entry
    HealItem = Item
else
    local Health = Humanoid.Health

    if Humanoid.MaxHealth <= Health then
        Upvalue4.HealDenied = os.clock( )
        Upvalue4.HealDeniedText = nil
        return
    end
    Entry2 = Entry
    HealItem = Item
end
if Entry2.Crouch and not Upvalue4.Crouching then
    Upvalue4.Crouching = true
    Upvalue6:FireServer( true )
    Upvalue7 = true
end

local HealStart = os.clock( )
Upvalue4.HealItem = HealItem
Upvalue4.HealStart = HealStart
Upvalue4.Healing = true
Upvalue8 = false
Upvalue9:FireServer( )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetChildren( ) do
    if Value.Name == "ItemGrip" then
        if not Value:GetAttribute( "Local" ) then
            return true
        end
    end
end

return false
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Self.Name == "ItemGrip" and not Self:GetAttribute( "Local" ) then
    for Key, Value in Upvalue1:GetChildren( ) do
        if Value.Name == "ItemGrip" and Value:GetAttribute( "Local" ) then
            Value:Destroy( )
        end
    end
end
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1.Items[ Object2:GetAttribute( "Item" ) ]
local Part1 = Upvalue2.Of( Object2 )
local Part0 = Object:FindFirstChild( "RightHand" )

if not Entry or not Part1 or not Part0 then
    return
end

Upvalue2.TakeOut( Object2 )

if not ( function()
    for Key, Value in Part1:GetChildren( ) do
        if Value.Name == "ItemGrip" then
            if not Value:GetAttribute( "Local" ) then
                return true
            end
        end
    end

    return false
end )( ) then
    local Weld = Instance.new( "Weld" )
    Weld.Name = "ItemGrip"
    Weld:SetAttribute( "Local", true )
    local C0 = Entry.Carry
    Weld.Part0 = Part0
    Weld.Part1 = Part1
    Weld.C0 = C0
    Weld.Parent = Part1
end
if not Upvalue3[ Part1 ] then
    Upvalue3[ Part1 ] = true
    Part1.ChildAdded:Connect( function( Self )
        if Self.Name == "ItemGrip" and not Self:GetAttribute( "Local" ) then
            for Key, Value in Part1:GetChildren( ) do
                if Value.Name == "ItemGrip" and Value:GetAttribute( "Local" ) then
                    Value:Destroy( )
                end
            end
        end
    end )
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.TouchMode( ) then
    Upvalue2( Upvalue3 )
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if not ToolName:IsA( "Tool" ) or not ToolName:GetAttribute( "Item" ) or Upvalue1[ ToolName ] then
    return
end
Upvalue1[ ToolName ] = true
ToolName.Activated:Connect( function()
    if Upvalue2.TouchMode( ) then
        Upvalue3( ToolName )
    end
end )
return
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 or Upvalue1.CaseRolling or not Upvalue2.Is( "Fire", Argument1 ) then
    return
end

local Tool
local Character = Upvalue3.Character

if Character then
    Tool = Character:FindFirstChildOfClass( "Tool" )
else
    Tool = Character
end
if Tool and Tool:GetAttribute( "Item" ) and Upvalue4.Items[ Tool:GetAttribute( "Item" ) ] then
    Upvalue5( Tool )
end
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Tool" ) and Object:GetAttribute( "Item" ) then
    Upvalue1( Object )
    Upvalue2( Upvalue3, Object )
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Tool" ) and Object:GetAttribute( "Item" ) then
    local Children
    local Of = Upvalue1.Of( Object )
    Children = Of and Of:GetChildren( ) or { }
    local Value1 = nil

    for Key, Value in Children, nil, nil do
        if Value.Name == "ItemGrip" and Value:GetAttribute( "Local" ) then
            Value:Destroy( )
        end
    end

    Upvalue1.PutBack( Object )

    if Upvalue2.HealItem then
        if Upvalue3 then
            Upvalue3 = false

            if Upvalue2.Crouching then
                Upvalue2.Crouching = false
                Upvalue4:FireServer( false )
            end
        end

        Upvalue2.HealItem = nil
        Upvalue2.HealStart = nil
        Upvalue2.Healing = false
        Upvalue5 = false
    end
end
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = false

    if Upvalue2.Crouching then
        Upvalue2.Crouching = false
        Upvalue3:FireServer( false )
    end
end

Upvalue2.HealItem = nil
Upvalue2.HealStart = nil
Upvalue2.Healing = false
Upvalue4 = false
Argument1.ChildAdded:Connect( function( Object )
    if Object:IsA( "Tool" ) and Object:GetAttribute( "Item" ) then
        Upvalue5( Object )
        Upvalue6( Argument1, Object )
    end
end )
Argument1.ChildRemoved:Connect( function( Object )
    if Object:IsA( "Tool" ) and Object:GetAttribute( "Item" ) then
        local Children
        local Of = Upvalue7.Of( Object )
        Children = Of and Of:GetChildren( ) or { }
        local Value1 = nil

        for Key, Value in Children, nil, nil do
            if Value.Name == "ItemGrip" and Value:GetAttribute( "Local" ) then
                Value:Destroy( )
            end
        end

        Upvalue7.PutBack( Object )

        if Upvalue2.HealItem then
            if Upvalue1 then
                Upvalue1 = false

                if Upvalue2.Crouching then
                    Upvalue2.Crouching = false
                    Upvalue3:FireServer( false )
                end
            end

            Upvalue2.HealItem = nil
            Upvalue2.HealStart = nil
            Upvalue2.Healing = false
            Upvalue4 = false
        end
    end
end )
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if Self:IsA( "Backpack" ) then
    Self.ChildAdded:Connect( Upvalue1 )
end
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.HealItem then
    return
end

local Character2
local Character = Upvalue2.Character
local Entry = Upvalue3.Items[ Upvalue1.HealItem ]
local Clock = os.clock( ) - Upvalue1.HealStart

if Character then
    if Character:GetAttribute( "HealItem" ) == nil then
        Character2 = false
    else
        Character2 = true
    end
else
    Character2 = Character
end
if Character2 then
    Upvalue4 = true
end
if not Entry or Entry.Time < Clock then
    if Upvalue5 then
        Upvalue5 = false

        if Upvalue1.Crouching then
            Upvalue1.Crouching = false
            Upvalue6:FireServer( false )
        end
    end

    Upvalue1.HealItem = nil
    Upvalue1.HealStart = nil
    Upvalue1.Healing = false
    Upvalue4 = false
elseif not Upvalue4 or Character2 or not ( Clock < Entry.Time - 0.15 ) then
    if not Upvalue4 and Clock > 1 then
        if Upvalue5 then
            Upvalue5 = false

            if Upvalue1.Crouching then
                Upvalue1.Crouching = false
                Upvalue6:FireServer( false )
            end
        end

        Upvalue1.HealItem = nil
        Upvalue1.HealStart = nil
        Upvalue1.Healing = false
        Upvalue4 = false
    end
else
    if Upvalue5 then
        Upvalue5 = false

        if Upvalue1.Crouching then
            Upvalue1.Crouching = false
            Upvalue6:FireServer( false )
        end
    end

    Upvalue1.HealItem = nil
    Upvalue1.HealStart = nil
    Upvalue1.Healing = false
    Upvalue4 = false
end
]]
