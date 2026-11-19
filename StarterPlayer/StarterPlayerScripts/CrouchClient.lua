-- StarterPlayer.StarterPlayerScripts.CrouchClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Crouch = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Crouch" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local LocalPlayer = Players.LocalPlayer
local Number = 0

local function Set( Crouching )
    local Flag = ClientState.Crouching == true and true or false

    if Flag == Crouching then
        return
    end
    ClientState.Crouching = Crouching
    Number = os.clock( )
    Crouch:FireServer( Crouching )
    return
end

Controls.OnInputBegan( function( Argument1, Argument2 )
    if Argument2 or ClientState.CursorFree then
        return
    end
    if Controls.Is( "Crouch", Argument1 ) then
        local Humanoid
        local Character = LocalPlayer.Character

        if Character then
            Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end
        if not Humanoid or Humanoid.Health <= 0 or ClientState.Rolling then
            return
        end

        local Flag
        local State = Humanoid:GetState( )

        if Humanoid.FloorMaterial == Enum.Material.Air then
            Flag = true
        elseif State == Enum.HumanoidStateType.Jumping then
            Flag = true
        elseif State == Enum.HumanoidStateType.Freefall then
            Flag = true
        elseif State == Enum.HumanoidStateType.Swimming then
            Flag = true
        else
            Flag = false
        end
        if Flag and not ClientState.Crouching then
            return
        end
        if type( Argument1 ) ~= "table" or not Argument1.Hold then
            local Flag3
            local Crouching = not ClientState.Crouching
            Flag3 = ClientState.Crouching == true and true or false

            if Flag3 == Crouching then
                return
            end

            ClientState.Crouching = Crouching
            Number = os.clock( )
            Crouch:FireServer( Crouching )
        else
            local Flag2 = ClientState.Crouching == true and true or false

            if Flag2 == true then
                return
            end
            ClientState.Crouching = true
            Number = os.clock( )
            Crouch:FireServer( true )
            return
        end
    end
end )
Controls.OnInputEnded( function( Argument1 )
    if type( Argument1 ) == "table" and Argument1.Hold and Argument1.Virtual == "Crouch" and ClientState.Crouching then
        local Flag = ClientState.Crouching == true and true or false

        if Flag == false then
            return
        end

        ClientState.Crouching = false
        Number = os.clock( )
        Crouch:FireServer( false )
    end
end )
RunService.Heartbeat:Connect( function()
    if not ClientState.Crouching then
        return
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or Humanoid.Health <= 0 or ClientState.Rolling or ClientState.Sprinting or Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
        local Flag = ClientState.Crouching == true and true or false

        if Flag == false then
            return
        end

        ClientState.Crouching = false
        Number = os.clock( )
        Crouch:FireServer( false )
    end
end )

local function OnCharacter( Object )
    ClientState.Crouching = false
    Object:GetAttributeChangedSignal( "Crouch" ):Connect( function()
        if Object:GetAttribute( "Crouch" ) == false and ClientState.Crouching and os.clock( ) - Number > 1 then
            ClientState.Crouching = false
        end
    end )
    Object:WaitForChild( "Humanoid" ).StateChanged:Connect( function( Argument1, Argument2 )
        if Argument2 == Enum.HumanoidStateType.Jumping then
            local Flag = ClientState.Crouching == true and true or false

            if Flag == false then
                return
            end

            ClientState.Crouching = false
            Number = os.clock( )
            Crouch:FireServer( false )
        end
    end )
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end
