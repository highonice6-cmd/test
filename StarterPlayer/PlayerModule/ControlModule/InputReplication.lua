-- StarterPlayer.PlayerModule.ControlModule.InputReplication
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag4
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationD" )
UserFlag4 = if UserFlag then UserFlag else Get.getUserFlag( "UserPlayerScriptsCCLIntegrationDGA" )
local Text
local UserFlag2 = Get.getUserFlag( "UserControlModuleDisabledUpdate" )
local StarterPlayer = game:GetService( "StarterPlayer" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local Workspace = game:GetService( "Workspace" )
local AvatarAbilitiesInterface = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) )
local UserFlag3 = Get.getUserFlag( "UserAbilitiesUserInterfaceB" )
Text = not UserFlag3 and "PlayerControlState" or "ControlState"
local __index = { }
__index.__index = __index
function __index._calculatePlayerInputValues( Self )
    local Character = Self.Character

    if Character == nil then
        return Vector3.new( 0, 0, 0 ), Vector3.new( 0, 0, 1 ), false
    end

    local Humanoid = Character:FindFirstChild( "Humanoid" )

    if Humanoid == nil then
        return Vector3.new( 0, 0, 0 ), Vector3.new( 0, 0, 1 ), false
    end

    local InputContexts = Self:FindFirstChild( "InputContexts" )

    if InputContexts == nil then
        return Vector3.new( 0, 0, 0 ), Vector3.new( 0, 0, 1 ), false
    end

    local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

    if CharacterContext == nil then
        return Vector3.new( 0, 0, 0 ), Vector3.new( 0, 0, 1 ), false
    end

    local State
    local MoveAction = CharacterContext.MoveAction
    local RotationAction = CharacterContext:FindFirstChild( "RotationAction" )

    if RotationAction == nil then
        State = false
    else
        State = RotationAction:GetState( )
    end

    local State2

    local function IsValidInput2D( Argument1 )
        local Flag

        if Argument1.X == Argument1.X then
            if Argument1.Y == Argument1.Y then
                if Argument1.X == math.huge then
                    Flag = true
                elseif Argument1.Y == math.huge then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = true
            end
        else
            Flag = true
        end

        return not Flag
    end

    local function IsValidInput3D( Argument1 )
        local Flag

        if Argument1.X == Argument1.X then
            if Argument1.Y == Argument1.Y then
                if Argument1.Z == Argument1.Z then
                    if Argument1.X == math.huge then
                        Flag = true
                    elseif Argument1.Y == math.huge then
                        Flag = true
                    elseif Argument1.Z == math.huge then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = true
                end
            else
                Flag = true
            end
        else
            Flag = true
        end

        return not Flag
    end

    if MoveAction == nil then
        State2 = Vector2.new( 0, 0 )
    else
        State2 = MoveAction:GetState( )
    end

    local Flag
    local LookVector = Self:GetCameraState( ).CFrame.LookVector

    if State2.X == State2.X then
        if State2.Y == State2.Y then
            if State2.X == math.huge then
                Flag = true
            elseif State2.Y == math.huge then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = true
        end
    else
        Flag = true
    end
    if not Flag then
        local Flag2

        if LookVector.X == LookVector.X then
            if LookVector.Y == LookVector.Y then
                if LookVector.Z == LookVector.Z then
                    if LookVector.X == math.huge then
                        Flag2 = true
                    elseif LookVector.Y == math.huge then
                        Flag2 = true
                    elseif LookVector.Z == math.huge then
                        Flag2 = true
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = true
                end
            else
                Flag2 = true
            end
        else
            Flag2 = true
        end
        if not Flag2 and LookVector.Magnitude > 0 then
            local LookVector2

            if not Humanoid or Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
                LookVector2 = LookVector
            else
                local X = LookVector.X
                LookVector2 = Vector3.new( X, 0, LookVector.Z ).Unit
            end

            local Unit = LookVector2:Cross( Vector3.new( 0, 1, 0 ) ).Unit
            return LookVector2 * State2.Y + Unit * State2.X, LookVector2, State
        end
    end

    return Vector3.new( 0, 0, 0 ), Vector3.new( 0, 0, 1 ), false
end
function __index.CloneInputsIfAbsent( Parent )
    if Parent:FindFirstChild( "InputContexts" ) then
        return
    end
    local Clone = StarterPlayer.PlayerModule.InputContexts:Clone( )
    Clone.CharacterContext.Enabled = true
    Clone.CameraContext.Enabled = true
    Clone.Parent = Parent
    return
end
function __index.FireCustomInputs( Object )
    local InputContexts = Object:FindFirstChild( "InputContexts" )

    if not InputContexts then
        return
    end

    local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

    if not CharacterContext then
        return
    end
    if not InputContexts:FindFirstChild( "CameraContext" ) then
        return
    end

    local RotationAction = CharacterContext:FindFirstChild( "RotationAction" )

    if RotationAction and RotationAction:FindFirstChild( "RotationScriptableBinding" ) then
        local Flag = UserGameSettings.RotationType == Enum.RotationType.CameraRelative and true or false
        RotationAction:FindFirstChild( "RotationScriptableBinding" ):Fire( Flag )
    end
end
function __index.SendInputToCCLCharacter( Character )
    if not Character then
        return
    end

    local Get = AvatarAbilitiesInterface.get( Character )
    local InputContexts = Character:FindFirstChild( "InputContexts" )

    if not InputContexts then
        return
    end

    local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

    if not CharacterContext then
        return
    end
    for Key, Value in Get:GetAbilities( ) do
        local FoundChild = CharacterContext:FindFirstChild( Value .. "Action" )

        if FoundChild then
            Get:SendInput( Value, FoundChild:GetState( ) )
        end
    end

    local _calculatePlayerInputValues, _calculatePlayerInputValues2, _calculatePlayerInputValues3 = __index._calculatePlayerInputValues( Character )
    Get:SendInput( "Move", _calculatePlayerInputValues )
    Get:SendInput( "CameraLookDirection", _calculatePlayerInputValues2 )
    Get:SendInput( "CameraRelativeRotation", _calculatePlayerInputValues3 )
end
function __index.SendInputToHumanoidForServerAuth( Auth )
    local Character = Auth.Character

    if Character == nil then
        return
    end

    local Humanoid = Character:FindFirstChild( "Humanoid" )

    if Humanoid == nil then
        return
    end

    local InputContexts = Auth:FindFirstChild( "InputContexts" )

    if InputContexts == nil then
        return
    end

    local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

    if CharacterContext == nil then
        return
    end

    local JumpAction = CharacterContext.JumpAction
    local _calculatePlayerInputValues, _calculatePlayerInputValues2, _calculatePlayerInputValues3 = __index._calculatePlayerInputValues( Auth )
    Humanoid:Move( _calculatePlayerInputValues )
    Humanoid.AutoRotate = not _calculatePlayerInputValues3

    if _calculatePlayerInputValues3 and Humanoid.SeatPart == nil and Humanoid.RootPart ~= nil and not Humanoid.Sit and not Humanoid.RootPart:IsGrounded( ) then
        local RootPart = Humanoid.RootPart
        RootPart.CFrame = CFrame.new( Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + _calculatePlayerInputValues2 )
    end

    local Jump

    if JumpAction == nil then
        Jump = false
    else
        Jump = JumpAction:GetState( )
    end

    Humanoid.Jump = Jump
end
function __index.setupPlayerControlState( Self )
    Self:AddVector3Field( "Move", Vector3.new( 0, 0, 0 ), 1 )
    Self:AddBoolField( "Jump", false )
    Self:AddBoolField( "RotateToLookDirection", false )
    Self:AddUnitVector3Field( "LookDirection", Vector3.new( 0, 0, 1 ) )
end
function __index.watchForPlayerControlState( Argument1 )
    local function WatchCharacter( Self )
        local function OnPCSAdded( Object )
            if Object:IsA( Text ) then
                __index.setupPlayerControlState( Object )
            end
        end

        local FoundChildOfClass = Self:FindFirstChildOfClass( Text )

        if FoundChildOfClass then
            __index.setupPlayerControlState( FoundChildOfClass )
        end

        Self.ChildAdded:Connect( OnPCSAdded )
    end

    if Argument1.Character then
        local Character = Argument1.Character

        local function OnPCSAdded( Object )
            if Object:IsA( Text ) then
                __index.setupPlayerControlState( Object )
            end
        end

        local FoundChildOfClass = Character:FindFirstChildOfClass( Text )

        if FoundChildOfClass then
            __index.setupPlayerControlState( FoundChildOfClass )
        end

        Character.ChildAdded:Connect( OnPCSAdded )
    end

    Argument1.CharacterAdded:Connect( WatchCharacter )
end
function __index.createPlayerControlState( Owner )
    local Owner2, Parent

    local function CreateForCharacter( Parent )
        local Parent2

        if UserFlag3 then
            if Parent:FindFirstChildOfClass( Text ) then
                return
            end
            Parent2 = Parent
        elseif Parent:FindFirstChild( Text ) then
            return
        else
            Parent2 = Parent
        end

        local Instance2 = Instance.new( Text )
        Instance2.Owner = Owner
        Instance2.Parent = Parent2
        __index.setupPlayerControlState( Instance2 )
    end

    if Owner.Character then
        local Character = Owner.Character

        if UserFlag3 then
            if Character:FindFirstChildOfClass( Text ) then
                Owner2 = Owner
            else
                Owner2 = Owner
                Parent = Character
                local Instance2 = Instance.new( Text )
                Instance2.Owner = Owner2
                Instance2.Parent = Parent
                __index.setupPlayerControlState( Instance2 )
            end
        elseif Character:FindFirstChild( Text ) then
            Owner2 = Owner
        else
            Owner2 = Owner
            Parent = Character
            local Instance2 = Instance.new( Text )
            Instance2.Owner = Owner2
            Instance2.Parent = Parent
            __index.setupPlayerControlState( Instance2 )
        end
    else
        Owner2 = Owner
    end

    Owner2.CharacterAdded:Connect( CreateForCharacter )
end
function __index.writeInputToCS( Argument1, Argument2 )
    assert( not UserFlag2 )
    local Data = Argument2.data
    local Character = Argument1.Character

    if not Character then
        return
    end

    local FoundChildOfClass

    if UserFlag3 then
        FoundChildOfClass = Character:FindFirstChildOfClass( Text )
    else
        FoundChildOfClass = Character:FindFirstChild( Text )
    end
    if not FoundChildOfClass then
        return
    end
    if not Argument2.humanoid then
        return
    end

    local Flag
    local Jump = Data.controlModule.isJumping
    local WorldMoveVector = Data.controlModule.worldMoveVector
    Flag = UserGameSettings.RotationType == Enum.RotationType.CameraRelative and true or false
    local LookVector2

    if Workspace.CurrentCamera then
        local LookVector = Workspace.CurrentCamera.CFrame.LookVector

        if LookVector then
            LookVector2 = LookVector
        else
            LookVector2 = Vector3.new( 0, 0, 1 )
        end
    else
        LookVector2 = Vector3.new( 0, 0, 1 )
    end

    local Unit
    local X = LookVector2.X
    local Vector32 = Vector3.new( X, 0, LookVector2.Z )

    if Vector32.Magnitude > 0.001 then
        Unit = Vector32.Unit
    else
        Unit = Vector3.new( 0, 0, 1 )
    end

    local Table = {
        Move = WorldMoveVector,
        RotateToLookDirection = Flag,
        LookDirection = Unit
    }

    if not UserFlag4 or not AvatarAbilitiesInterface.get( Argument1 ):isEnabled( ) then
        Table.Jump = Jump
    end

    FoundChildOfClass:UpdateFields( Table )
end
function __index.processPCSInputs( Argument1 )
    local Character = Argument1.Character

    if Character == nil then
        return
    end

    local Humanoid = Character:FindFirstChild( "Humanoid" )

    if Humanoid == nil then
        return
    end

    local FoundChildOfClass

    if UserFlag3 then
        FoundChildOfClass = Character:FindFirstChildOfClass( Text )
    else
        FoundChildOfClass = Character:FindFirstChild( Text )
    end
    if FoundChildOfClass == nil then
        return
    end

    local State = FoundChildOfClass:GetState( )
    local Move = State.Move
    local Jump = State.Jump
    local RotateToLookDirection = State.RotateToLookDirection
    local LookDirection = State.LookDirection

    if Move then
        Humanoid:Move( Move )
    end

    Humanoid.AutoRotate = not RotateToLookDirection

    if RotateToLookDirection and LookDirection ~= nil and Humanoid.RootPart ~= nil and not Humanoid.Sit and Humanoid.SeatPart == nil and not Humanoid.RootPart:IsGrounded( ) then
        local RootPart = Humanoid.RootPart
        RootPart.CFrame = CFrame.new( Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + LookDirection )
    end

    Humanoid.Jump = Jump or false
end
return __index
