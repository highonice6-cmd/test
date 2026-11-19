-- StarterPlayer.StarterPlayerScripts.FistsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
game:GetService( "UserInputService" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local FistAnim = require( Weapons:WaitForChild( "FistAnim" ) )
local MeleeData = require( Weapons:WaitForChild( "MeleeData" ) )
local ClientHitboxes = require( Weapons:WaitForChild( "ClientHitboxes" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local Fists = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Fists" )
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Text = "Right"
local Number = -math.huge
local Value1 = nil
local Flag = false
local Value2 = nil
local Flag2 = false
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Include
RaycastParams2.CollisionGroup = "Bullet"
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams3.CollisionGroup = "Bullet"

local function FistTool( ToolName )
    local Tool

    if ToolName then
        Tool = ToolName:FindFirstChildOfClass( "Tool" )
    else
        Tool = ToolName
    end

    local Melee

    if Tool then
        Melee = Tool:GetAttribute( "Melee" )
    else
        Melee = Tool
    end

    local Flag

    if Melee == nil then
        Flag = false
    elseif MeleeData[ Melee ] == nil then
        Flag = false
    elseif MeleeData[ Melee ].Fists == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function CanFist()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or Humanoid.Health <= 0 or Humanoid.SeatPart then
        return false
    end

    local Tool

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Melee

    if Tool then
        Melee = Tool:GetAttribute( "Melee" )
    else
        Melee = Tool
    end

    local Flag

    if Melee == nil then
        Flag = false
    elseif MeleeData[ Melee ] == nil then
        Flag = false
    elseif MeleeData[ Melee ].Fists == true then
        Flag = true
    else
        Flag = false
    end
    if not Flag and not ClientState.FistsSelected then
        return false
    end
    if not Flag and Character:FindFirstChildOfClass( "Tool" ) then
        return false
    end
    if Character:GetAttribute( "Downed" ) or Character:GetAttribute( "CarriedBy" ) or Character:GetAttribute( "Carrying" ) or Character:GetAttribute( "DanceStart" ) or Character:GetAttribute( "CarRagdoll" ) then
        return false
    end
    if ClientState.Rolling or ClientState.WardrobeOpen or ClientState.Carrying then
        return false
    end
    if ClientState.CaseRolling then
        return false
    end
    if workspace:GetAttribute( "RankedMatch" ) then
        local MatchState
        local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

        if RankedShared then
            MatchState = RankedShared:FindFirstChild( "MatchState" )
        else
            MatchState = RankedShared
        end
        if not MatchState or MatchState:GetAttribute( "Phase" ) ~= "fight" then
            return false
        end
    end

    return true
end

local function FindTarget()
    if ClientHitboxes.Refresh then
        ClientHitboxes.Refresh( )
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local ClientHitboxesInner = workspace:FindFirstChild( "ClientHitboxes" )

    if not HumanoidRootPart or not ClientHitboxesInner then
        return nil
    end

    local Unit
    local LookVector = CurrentCamera.CFrame.LookVector
    local X = LookVector.X
    local Vector32 = Vector3.new( X, 0, LookVector.Z )
    Unit = Vector32.Magnitude > 0.1 and Vector32.Unit or HumanoidRootPart.CFrame.LookVector
    local Position
    local UpperTorso = Character:FindFirstChild( "UpperTorso" )
    Position = UpperTorso and UpperTorso.Position or HumanoidRootPart.Position + Vector3.new( 0, 1, 0 )
    local Spherecast2
    local Position2 = Position - Unit * 0.8
    RaycastParams2.FilterDescendantsInstances = { ClientHitboxesInner }
    local Spherecast = workspace:Spherecast( Position2, 1.2, Unit * 5.3999999999999995, RaycastParams2 )
    Spherecast2 = if Spherecast then ClientHitboxes.parts[ Spherecast.Instance ] else Spherecast

    if not Spherecast2 or Spherecast2.char == Character then
        return nil
    end

    RaycastParams3.FilterDescendantsInstances = {
        Character,
        Spherecast2.char,
        ClientHitboxesInner,
        workspace:FindFirstChild( "FX" )
    }

    if workspace:Raycast( Position2, Spherecast.Position - Position2, RaycastParams3 ) then
        return nil
    end
    return Spherecast2.char, Spherecast2.name
end

local function PunchGap()
    local EDrinkUntil
    local Character = LocalPlayer.Character

    if Character then
        EDrinkUntil = Character:GetAttribute( "EDrinkUntil" )
    else
        EDrinkUntil = Character
    end
    if not EDrinkUntil or not ( workspace:GetServerTimeNow( ) < EDrinkUntil ) then
        return 1.05
    end
    return 0.65625
end

local function RankedFrozen()
    if not workspace:GetAttribute( "RankedMatch" ) then
        return false
    end

    local MatchState
    local RankedShared = game:GetService( "ReplicatedStorage" ):FindFirstChild( "RankedShared" )

    if RankedShared then
        MatchState = RankedShared:FindFirstChild( "MatchState" )
    else
        MatchState = RankedShared
    end

    local Flag

    if MatchState == nil then
        Flag = false
    elseif MatchState:GetAttribute( "Phase" ) == "fight" then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function Punch()
    if RankedFrozen( ) then
        return
    end
    if ClientState.Exhausted or ( ClientState.Stamina or 0 ) < 8 then
        return
    end

    local LastStaminaUse = os.clock( )
    ClientState.Stamina = ClientState.Stamina - 8
    ClientState.LastStaminaUse = LastStaminaUse

    if ClientState.Stamina <= 0 then
        ClientState.Exhausted = true
    end

    local TextInner
    Number = LastStaminaUse
    TextInner = Text ~= "Right" and "Right" or "Left"
    Text = TextInner
    FistAnim.Punch( Text )
    Fists:FireServer( "punch" )
    task.delay( 0.1, function()
        local Value1, Value2 = FindTarget( )

        if Value1 then
            Fists:FireServer( "hit", Value1, Value2 )
        end
    end )
end

Controls.OnInputBegan( function( Argument1, Argument2 )
    if Argument2 or not Controls.Is( "Fire", Argument1 ) then
        return
    end
    if CanFist( ) and not ClientState.CursorFree then
        Value1 = os.clock( )
        Flag = true
    end
end )
Controls.OnInputEnded( function( Argument1 )
    if Controls.Is( "Fire", Argument1 ) then
        Flag = false
    end
end )
LocalPlayer.CharacterAdded:Connect( function()
    Text = "Right"
    Value1 = nil
    Flag = false
end )
RunService.Heartbeat:Connect( function()
    local FistAim
    local Clock = os.clock( )
    local FistsReady = CanFist( )
    ClientState.FistsReady = FistsReady
    local Character = LocalPlayer.Character

    if FistsReady then
        local NotCursorFree = not ClientState.CursorFree

        if NotCursorFree then
            FistAim = Controls.IsDown( "Aim" )
        else
            FistAim = NotCursorFree
        end
    else
        FistAim = FistsReady
    end
    if FistAim ~= Flag2 then
        Flag2 = FistAim

        if FistAim then
            ClientState.AimFOV = 62
            ClientState.AimWalkSpeed = 12
            ClientState.Aiming = true
        elseif not Character or not Character:FindFirstChildOfClass( "Tool" ) then
            ClientState.Aiming = false
        else
            local Tool

            if Character then
                Tool = Character:FindFirstChildOfClass( "Tool" )
            else
                Tool = Character
            end

            local Melee

            if Tool then
                Melee = Tool:GetAttribute( "Melee" )
            else
                Melee = Tool
            end

            local FlagInner

            if Melee == nil then
                FlagInner = false
            elseif MeleeData[ Melee ] == nil then
                FlagInner = false
            elseif MeleeData[ Melee ].Fists == true then
                FlagInner = true
            else
                FlagInner = false
            end
            if FlagInner then
                ClientState.Aiming = false
            end
        end
    end

    ClientState.FistAim = FistAim

    if FistsReady then
        if not Value1 or not ( Clock - Value1 < 0.25 ) then
            if Flag and Controls.IsDown( "Fire" ) and not ClientState.CursorFree then
                local EDrinkUntil
                local Clock2 = Clock - Number
                local Character2 = LocalPlayer.Character

                if Character2 then
                    EDrinkUntil = Character2:GetAttribute( "EDrinkUntil" )
                else
                    EDrinkUntil = Character2
                end

                local NumberInner

                if not EDrinkUntil or not ( workspace:GetServerTimeNow( ) < EDrinkUntil ) then
                    NumberInner = 1.05
                else
                    NumberInner = 0.65625
                end
                if NumberInner <= Clock2 then
                    Value1 = nil
                    Punch( )
                end
            end
        else
            local Clock2 = Clock - Number
            local Character2 = LocalPlayer.Character

            if Character2 then
                EDrinkUntil = Character2:GetAttribute( "EDrinkUntil" )
            else
                EDrinkUntil = Character2
            end
            if not EDrinkUntil or not ( workspace:GetServerTimeNow( ) < EDrinkUntil ) then
                NumberInner = 1.05
            else
                NumberInner = 0.65625
            end
            if NumberInner <= Clock2 then
                Value1 = nil
                Punch( )
            end
        end
    end
    if Value1 and Clock - Value1 >= 0.25 then
        Value1 = nil
    end

    local FistCombat

    if FistsReady then
        if FistAim then
            FistCombat = FistAim
        elseif Clock - Number < 0.6 then
            FistCombat = true
        else
            FistCombat = false
        end
    else
        FistCombat = FistsReady
    end

    ClientState.FistCombat = FistCombat
    ClientState.FistGuard = FistCombat

    if FistCombat ~= Value2 then
        Value2 = FistCombat
        Fists:FireServer( "guard", FistCombat )
    end
end )
