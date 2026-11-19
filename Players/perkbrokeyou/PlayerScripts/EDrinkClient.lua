-- Players.perkbrokeyou.PlayerScripts.EDrinkClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local Drink = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Drink" )
local LocalPlayer = Players.LocalPlayer
local Class = setmetatable( { }, { __mode = "k" } )

local function RankedFrozen()
    if not workspace:GetAttribute( "RankedMatch" ) then
        return false
    end

    local MatchState
    local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

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
end

local function Drink2( Argument1 )
    local Character = LocalPlayer.Character

    if ClientState.CursorFree or not Character or Character:GetAttribute( "Drinking" ) or Argument1.Parent ~= Character then
        return
    end
    if ClientState.DrinkStart then
        return
    end

    local Flag

    if workspace:GetAttribute( "RankedMatch" ) then
        local MatchState
        local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

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
    ClientState.DrinkStart = os.clock( )
    Drink:FireServer( )
    return
end

local function HookTool( ToolName )
    if not ToolName:IsA( "Tool" ) or ToolName:GetAttribute( "Item" ) ~= "EDrink" or Class[ ToolName ] then
        return
    end
    Class[ ToolName ] = true
    ToolName.Activated:Connect( function()
        if Controls.TouchMode( ) then
            Drink2( ToolName )
        end
    end )
    return
end

Controls.OnInputBegan( function( Argument1, Argument2 )
    if Argument2 or ClientState.CaseRolling or not Controls.Is( "Fire", Argument1 ) then
        return
    end

    local Tool
    local Character = LocalPlayer.Character

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end
    if Tool and Tool:GetAttribute( "Item" ) == "EDrink" then
        Drink2( Tool )
    end
end )
local ObjetTenu = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ObjetTenu" ) )

local function GripLocally( Object, ToolName )
    local Part1 = ObjetTenu.Of( ToolName )
    local Part0 = Object:FindFirstChild( "RightHand" )

    if not Part1 or not Part0 or Part1:FindFirstChild( "ItemGrip" ) then
        return
    end

    local C0
    ObjetTenu.TakeOut( ToolName )
    local Weld = Instance.new( "Weld" )
    Weld.Name = "LocalGrip"
    Weld.Part0 = Part0
    Weld.Part1 = Part1
    local Carry = ToolName:GetAttribute( "Carry" )
    C0 = if Carry then Carry else CFrame.new( 0, -0.3, 0 )
    Weld.C0 = C0
    Weld.Parent = Part1
    local Connect = nil
    Connect = Part1.ChildAdded:Connect( function( Argument1 )
        if Argument1.Name == "ItemGrip" then
            Weld:Destroy( )
            Connect:Disconnect( )
        end
    end )
end

local function OnCharacter( Argument1 )
    Argument1.ChildAdded:Connect( function( ToolName )
        if ToolName:IsA( "Tool" ) and ToolName:GetAttribute( "Item" ) == "EDrink" then
            HookTool( ToolName )
            GripLocally( Argument1, ToolName )
        end
    end )
    Argument1.ChildRemoved:Connect( function( Object )
        if Object:IsA( "Tool" ) and Object:GetAttribute( "Item" ) == "EDrink" then
            local LocalGrip
            local Of = ObjetTenu.Of( Object )

            if Of then
                LocalGrip = Of:FindFirstChild( "LocalGrip" )
            else
                LocalGrip = Of
            end
            if LocalGrip then
                LocalGrip:Destroy( )
            end

            ObjetTenu.PutBack( Object )
            ClientState.DrinkStart = nil
        end
    end )
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end
