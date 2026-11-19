-- StarterPlayer.PlayerModule.ControlModule
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag3
local __index = { }
__index.__index = __index
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local UserInputService = game:GetService( "UserInputService" )
local GuiService = game:GetService( "GuiService" )
local Workspace = game:GetService( "Workspace" )
local StarterPlayer = game:GetService( "StarterPlayer" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local VRService = game:GetService( "VRService" )
local ContextActionService = game:GetService( "ContextActionService" )
local CommonUtils = require( script.Parent:WaitForChild( "CommonUtils" ) )
local Get = CommonUtils.get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserVRFixCameraCloseArticulation" )
local UserFlag2 = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationD" )

if UserFlag2 then
    UserFlag3 = UserFlag2
else
    UserFlag3 = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationDGA" )
end

local UserFlag6
local UserFlag4 = Get.getUserFlag( "UserPlayerScriptsBindActivateOnIAS" )
local UserFlag5 = Get.getUserFlag( "UserPlayerScriptsPlayerControlState2" )

if UserFlag5 then
    UserFlag6 = UserFlag5
else
    UserFlag6 = Get.getUserFlag( "UserPlayerScriptsPlayerControlState2GA" )
end

local InputReplication
local UserFlag7 = Get.getUserFlag( "UserPlayerScriptsTaskDeferSimulation" )
local UserFlag8 = Get.getUserFlag( "UserPlayerScriptsFixSAuthRenderStepMove" )
local UserFlag9 = Get.getUserFlag( "UserPlayerScriptsSupportMicroGamepad" )
local UserFlag10 = Get.getUserFlag( "UserAbilitiesUserInterfaceA" )
local UserFlag11 = Get.getUserFlag( "UserAbilitiesUserInterfaceC" )
local UserFlag12 = Get.getUserFlag( "UserPSUseBindToAnimation" )
local UserFlag13 = Get.getUserFlag( "UserServerAuthorityDontSetAutoRotate" )
local UserFlag14 = Get.getUserFlag( "UserPlayerModuleEngineAPI" )
local UserFlag15 = Get.getUserFlag( "UserControlModuleDisabledUpdate" )
local Table = { SERVER_AUTHORITY_CHANGED = "SERVER_AUTHORITY_CHANGED" }
local ActionController = require( script:WaitForChild( "ActionController" ) )

if UserFlag3 or UserFlag6 then
    InputReplication = require( script:WaitForChild( "InputReplication" ) )
else
    InputReplication = nil
end

local InputSlots

if UserFlag3 then
    InputSlots = require( script:WaitForChild( "InputSlots" ) )
else
    InputSlots = nil
end

local DynamicThumbstick

if RunService:IsClient( ) then
    DynamicThumbstick = require( script:WaitForChild( "DynamicThumbstick" ) )
else
    DynamicThumbstick = nil
end

local TouchAbilities
local ClassicThumbstick = require( script:WaitForChild( "ClassicThumbstick" ) )
local ClickToMoveController = require( script:WaitForChild( "ClickToMoveController" ) )
local TouchJump = require( script:WaitForChild( "TouchJump" ) )

if UserFlag3 then
    TouchAbilities = require( script:WaitForChild( "TouchAbilities" ) )
else
    TouchAbilities = nil
end

local AbilitiesOverflowMenu

if UserFlag3 then
    AbilitiesOverflowMenu = require( script:WaitForChild( "AbilitiesOverflowMenu" ) )
else
    AbilitiesOverflowMenu = nil
end

local AbilitiesKeybindBar

if UserFlag3 then
    AbilitiesKeybindBar = require( script:WaitForChild( "AbilitiesKeybindBar" ) )
else
    AbilitiesKeybindBar = nil
end

local Get2, AvatarAbilitiesInterface2
local VehicleController = require( script:WaitForChild( "VehicleController" ) )

if UserFlag3 then
    local AvatarAbilitiesInterface = require( script:WaitForChild( "AvatarAbilitiesInterface" ) )
    Get2 = AvatarAbilitiesInterface.get( Players.LocalPlayer )
    AvatarAbilitiesInterface2 = AvatarAbilitiesInterface
else
    Get2 = nil
    AvatarAbilitiesInterface2 = nil
end

local CameraRotationAction = script.Parent:WaitForChild( "InputContexts" ):WaitForChild( "CameraContext" ):WaitForChild( "CameraRotationAction" )
local Value = Enum.ContextActionPriority.Medium.Value
local Get3 = CommonUtils.get( "VRFirstPersonState" )
local Table2 = {
    [ Enum.TouchMovementMode.DPad ] = DynamicThumbstick,
    [ Enum.DevTouchMovementMode.DPad ] = DynamicThumbstick,
    [ Enum.TouchMovementMode.Thumbpad ] = DynamicThumbstick,
    [ Enum.DevTouchMovementMode.Thumbpad ] = DynamicThumbstick,
    [ Enum.TouchMovementMode.Thumbstick ] = ClassicThumbstick,
    [ Enum.DevTouchMovementMode.Thumbstick ] = ClassicThumbstick,
    [ Enum.TouchMovementMode.DynamicThumbstick ] = DynamicThumbstick,
    [ Enum.DevTouchMovementMode.DynamicThumbstick ] = DynamicThumbstick,
    [ Enum.TouchMovementMode.ClickToMove ] = ClickToMoveController,
    [ Enum.DevTouchMovementMode.ClickToMove ] = ClickToMoveController,
    [ Enum.TouchMovementMode.Default ] = DynamicThumbstick,
    [ Enum.ComputerMovementMode.Default ] = ActionController,
    [ Enum.ComputerMovementMode.KeyboardMouse ] = ActionController,
    [ Enum.DevComputerMovementMode.KeyboardMouse ] = ActionController,
    [ Enum.DevComputerMovementMode.Scriptable ] = nil,
    [ Enum.ComputerMovementMode.ClickToMove ] = ClickToMoveController,
    [ Enum.DevComputerMovementMode.ClickToMove ] = ClickToMoveController
}
function __index.new()
    local Self = setmetatable( { }, __index )

    if RunService:IsServer( ) then
        return Self
    end

    Self.controllers = { }
    Self.activeControlModule = nil
    Self.activeController = nil
    Self.touchJumpController = nil
    Self.touchAbilitiesController = nil
    Self.abilitiesOverflowController = nil
    Self.abilitiesKeybindBarController = nil
    Self.moveFunction = Players.LocalPlayer.Move
    Self.humanoid = nil
    Self.controlsEnabled = true
    Self.enabled = false
    Self.humanoidSeatedConn = nil
    Self.vehicleController = nil
    Self.touchControlFrame = nil
    Self.abilitiesGui = nil
    Self.abilitiesFrame = nil
    Self.currentTorsoAngle = 0
    Self.inputMoveVector = Vector3.new( 0, 0, 0 )
    Self.renderedRotationOverride = nil
    Self.vehicleController = VehicleController.new( )

    if not UserFlag14 then
        Players.LocalPlayer.CharacterAdded:Connect( function( Argument1 )
            Self:OnCharacterAdded( Argument1 )
        end )
        Players.LocalPlayer.CharacterRemoving:Connect( function( Argument1 )
            Self:OnCharacterRemoving( Argument1 )
        end )

        if Players.LocalPlayer.Character then
            Self:OnCharacterAdded( Players.LocalPlayer.Character )
        end
    end

    UserGameSettings:GetPropertyChangedSignal( "TouchMovementMode" ):Connect( function()
        Self:UpdateMovementMode( )
    end )
    Players.LocalPlayer:GetPropertyChangedSignal( "DevTouchMovementMode" ):Connect( function()
        Self:UpdateMovementMode( )
    end )
    UserGameSettings:GetPropertyChangedSignal( "ComputerMovementMode" ):Connect( function()
        Self:UpdateMovementMode( )
    end )
    Players.LocalPlayer:GetPropertyChangedSignal( "DevComputerMovementMode" ):Connect( function()
        Self:UpdateMovementMode( )
    end )

    if UserFlag3 then
        Get2:GetEnabledChangedSignal( ):Connect( function()
            Self:UpdateAbilitiesControllers( )
        end )
    end

    Self.playerGui = nil
    Self.touchGui = nil
    Self.playerGuiAddedConn = nil
    GuiService:GetPropertyChangedSignal( "TouchControlsEnabled" ):Connect( function()
        Self:UpdateMovementMode( )
        Self:UpdateActiveControlModuleEnabled( )
    end )
    UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( function()
        Self:UpdateMovementMode( )
    end )
    Self.playerGui = Players.LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if not Self.playerGui then
        Self.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect( function( PlayerGui )
            if PlayerGui:IsA( "PlayerGui" ) then
                Self.playerGui = PlayerGui
                Self.playerGuiAddedConn:Disconnect( )
                Self.playerGuiAddedConn = nil
                Self:UpdateMovementMode( )

                if UserFlag3 then
                    Self:UpdateAbilitiesControllers( )
                end
            end
        end )
    end
    if UserFlag4 then
        ContextActionService:BindActivate( Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2 )
    end

    return Self
end

local function _fireCustomInputs( Object )
    assert( not UserFlag15 )
    local InputContexts = Object:FindFirstChild( "InputContexts" )

    if InputContexts == nil then
        return
    end

    local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

    if CharacterContext == nil then
        return
    end

    local RotationAction = CharacterContext:FindFirstChild( "RotationAction" )

    if RotationAction and RotationAction:FindFirstChild( "RotationScriptableBinding" ) then
        local Flag = UserGameSettings.RotationType == Enum.RotationType.CameraRelative and true or false
        RotationAction:FindFirstChild( "RotationScriptableBinding" ):Fire( Flag )
    end
end

function __index.restoreSimulatedRotation( Argument1 )
    local RenderedRotationOverride = Argument1.renderedRotationOverride

    if RenderedRotationOverride == nil then
        return
    end
    if RenderedRotationOverride.rootPart.Parent ~= nil then
        local RootPart = RenderedRotationOverride.rootPart
        RootPart.CFrame = CFrame.new( RenderedRotationOverride.rootPart.CFrame.Position ) * RenderedRotationOverride.simulatedRotation
    end

    Argument1.renderedRotationOverride = nil
end
function __index.applyRenderedRotation( Self )
    local Humanoid2
    local CurrentCamera = Workspace.CurrentCamera
    local Humanoid = Self.humanoid
    Humanoid2 = if Humanoid then Humanoid.RootPart else Humanoid

    if CurrentCamera == nil or Humanoid2 == nil or Humanoid.Sit or Humanoid.SeatPart ~= nil or Humanoid2:IsGrounded( ) or Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
        return
    end

    local LookVector = CurrentCamera.CFrame.LookVector
    local X = LookVector.X
    local Vector32 = Vector3.new( X, 0, LookVector.Z )

    if Vector32.Magnitude < 0.001 then
        return
    end
    if Self.renderedRotationOverride ~= nil and Self.renderedRotationOverride.rootPart ~= Humanoid2 then
        Self:restoreSimulatedRotation( )
    end
    if Self.renderedRotationOverride == nil then
        Self.renderedRotationOverride = { rootPart = Humanoid2, simulatedRotation = Humanoid2.CFrame.Rotation }
    end

    local Position = Humanoid2.CFrame.Position
    Humanoid2.CFrame = CFrame.lookAt( Position, Position + Vector32 )
end

local function _cloneInputs( Parent )
    local Clone = StarterPlayer.PlayerModule.InputContexts:Clone( )
    Clone.CharacterContext.Enabled = true
    Clone.CameraContext.Enabled = true
    Clone.Parent = Parent
end

function __index.InitializeServerAuthority( Authority )
    if RunService:IsServer( ) then
        if UserFlag3 then
            for Key, Value in Players:GetPlayers( ) do
                InputReplication.CloneInputsIfAbsent( Value )
            end

            Players.PlayerAdded:Connect( InputReplication.CloneInputsIfAbsent )
        else
            for Key2, Value2 in Players:GetPlayers( ) do
                local Clone = StarterPlayer.PlayerModule.InputContexts:Clone( )
                Clone.CharacterContext.Enabled = true
                Clone.CameraContext.Enabled = true
                Clone.Parent = Value2
            end

            Players.PlayerAdded:Connect( _cloneInputs )
        end
        if UserFlag6 then
            for Key3, Value3 in Players:GetPlayers( ) do
                InputReplication.createPlayerControlState( Value3 )
            end

            Players.PlayerAdded:Connect( InputReplication.createPlayerControlState )
        end
        if UserFlag3 and UserFlag7 then
            for Key4, Value4 in Players:GetPlayers( ) do
                AvatarAbilitiesInterface2.get( Value4 )
            end

            Players.PlayerAdded:Connect( function( Argument1 )
                AvatarAbilitiesInterface2.get( Argument1 )
            end )
        end
        if UserFlag12 then
            RunService:BindToAnimation( function( Argument1 )
                for Key, Value in Players:GetPlayers( ) do
                    Authority:ProcessInputs( Value, Argument1 )
                end
            end, Enum.StepFrequency.Hz60 )
        else
            RunService:BindToSimulation( function( Argument1 )
                for Key, Value in Players:GetPlayers( ) do
                    Authority:ProcessInputs( Value, Argument1 )
                end
            end, Enum.StepFrequency.Hz60 )
        end
    else
        if UserFlag6 then
            InputReplication.watchForPlayerControlState( Players.LocalPlayer )
        end
        if UserFlag13 then
            RunService.PreAnimation:Connect( function()
                Authority:restoreSimulatedRotation( )
            end )
        end

        RunService:BindToRenderStep( "CameraInput", Enum.RenderPriority.Last.Value, function()
            if not UserFlag15 then
                if UserFlag6 then
                    InputReplication.writeInputToCS( Players.LocalPlayer, Authority )
                elseif UserFlag3 then
                    InputReplication.FireCustomInputs( Players.LocalPlayer )
                else
                    _fireCustomInputs( Players.LocalPlayer )
                end
            end
            if UserFlag13 and UserGameSettings.RotationType == Enum.RotationType.CameraRelative then
                if not UserFlag3 or not Get2:isEnabled( ) then
                    Authority:applyRenderedRotation( )
                end
            end
        end )

        if UserFlag12 then
            RunService:BindToAnimation( function( Argument1 )
                Authority:ProcessInputs( Players.LocalPlayer, Argument1 )
            end, Enum.StepFrequency.Hz60 )
        else
            RunService:BindToSimulation( function( Argument1 )
                Authority:ProcessInputs( Players.LocalPlayer, Argument1 )
            end, Enum.StepFrequency.Hz60 )
        end
    end
    if Authority.data and Authority.data.eventBus then
        Authority.data.isServerAuthority = true
        Authority.data.eventBus:publish( "SERVER_AUTHORITY_CHANGED", true )
    end
end

local function NormalizeAngle( Amount )
    local Total2
    local Total = ( Amount + 12.566370614359172 ) % 6.283185307179586
    Total2 = if Total > 3.141592653589793 then Total - 6.283185307179586 else Total
    return Total2
end

local function AverageAngle( Argument1, Argument2 )
    local Total2
    local Total = ( Argument2 - Argument1 + 12.566370614359172 ) % 6.283185307179586
    Total2 = if Total > 3.141592653589793 then Total - 6.283185307179586 else Total
    local Total4
    local Total3 = ( Argument1 + Total2 / 2 + 12.566370614359172 ) % 6.283185307179586
    Total4 = if Total3 > 3.141592653589793 then Total3 - 6.283185307179586 else Total3
    return Total4
end

function __index.GetEstimatedVRTorsoFrame( Argument1 )
    local UserCFrame = VRService:GetUserCFrame( Enum.UserCFrame.Head )
    local _, ToEulerAnglesYXZ2 = UserCFrame:ToEulerAnglesYXZ( )
    local CurrentTorsoAngle = -ToEulerAnglesYXZ2

    if not VRService:GetUserCFrameEnabled( Enum.UserCFrame.RightHand ) or not VRService:GetUserCFrameEnabled( Enum.UserCFrame.LeftHand ) then
        Argument1.currentTorsoAngle = CurrentTorsoAngle
    else
        local Amount3
        local UserCFrame2 = VRService:GetUserCFrame( Enum.UserCFrame.LeftHand )
        local UserCFrame3 = VRService:GetUserCFrame( Enum.UserCFrame.RightHand )
        local Position = UserCFrame.Position - UserCFrame2.Position
        local Position2 = UserCFrame.Position - UserCFrame3.Position
        local X = Position.X
        local Amount = -math.atan2( X, Position.Z )
        local X2 = Position2.X
        local Amount2 = ( -math.atan2( X2, Position2.Z ) - Amount + 12.566370614359172 ) % 6.283185307179586
        Amount3 = if Amount2 > 3.141592653589793 then Amount2 - 6.283185307179586 else Amount2
        local Amount6
        local Amount4 = ( Amount + Amount3 / 2 + 12.566370614359172 ) % 6.283185307179586
        Amount6 = if Amount4 > 3.141592653589793 then Amount4 - 6.283185307179586 else Amount4
        local Amount9
        local Amount5 = ( CurrentTorsoAngle - Argument1.currentTorsoAngle + 12.566370614359172 ) % 6.283185307179586
        Amount9 = if Amount5 > 3.141592653589793 then Amount5 - 6.283185307179586 else Amount5
        local Amount8
        local Amount7 = ( Amount6 - Argument1.currentTorsoAngle + 12.566370614359172 ) % 6.283185307179586

        if Amount7 > 3.141592653589793 then
            Amount8 = Amount7 - 6.283185307179586
        else
            Amount8 = Amount7
        end

        local Flag

        if Amount8 > -1.5707963267948966 then
            if Amount8 < 1.5707963267948966 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
        if not Flag then
            Amount8 = Amount9
        end

        local Min2
        local Min = math.min( Amount8, Amount9 )
        local Max = math.max( Amount8, Amount9 )

        if Min > 0 then
            Min2 = Min
        elseif Max < 0 then
            Min2 = Max
        else
            Min2 = 0
        end

        Argument1.currentTorsoAngle = Min2 + Argument1.currentTorsoAngle
    end

    return CFrame.new( UserCFrame.Position ) * CFrame.fromEulerAnglesYXZ( 0, -Argument1.currentTorsoAngle, 0 )
end
function __index.GetActiveController( Argument1 )
    return Argument1.activeController
end
function __index.UpdateAbilitiesControllers( Self )
    local Enabled2
    local Enabled = Self.enabled

    if Enabled then
        local TouchControlFrame = Self.touchControlFrame

        if TouchControlFrame then
            if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                if Self.activeControlModule == ClickToMoveController then
                    Enabled2 = true
                elseif Self.activeControlModule == ClassicThumbstick then
                    Enabled2 = true
                elseif Self.activeControlModule == DynamicThumbstick then
                    Enabled2 = true
                else
                    Enabled2 = false
                end
            else
                Enabled2 = false
            end
        else
            Enabled2 = TouchControlFrame
        end
    else
        Enabled2 = Enabled
    end

    local Enabled3 = if Enabled2 then not Get2:isEnabled( ) else Enabled2
    local IsEnabled

    if Enabled2 then
        IsEnabled = Get2:isEnabled( )
    else
        IsEnabled = Enabled2
    end
    if Enabled3 then
        if not Self.controllers[ TouchJump ] then
            Self.controllers[ TouchJump ] = TouchJump.new( Self.data )
        end

        Self.touchJumpController = Self.controllers[ TouchJump ]
        local TouchJumpController = Self.touchJumpController
        TouchJumpController:Enable( true, Self.touchControlFrame )
    elseif Self.touchJumpController then
        if IsEnabled then
            Self.touchJumpController:Destroy( )
            Self.controllers[ TouchJump ] = nil
            Self.touchJumpController = nil
        else
            Self.touchJumpController:Enable( false )
        end
    end
    if IsEnabled then
        if not Self.controllers[ TouchAbilities ] then
            Self.controllers[ TouchAbilities ] = TouchAbilities.new( Self.touchControlFrame )
        end

        Self.touchAbilitiesController = Self.controllers[ TouchAbilities ]
        Self.touchAbilitiesController:Enable( true )
    elseif Self.touchAbilitiesController then
        if Enabled3 then
            Self.touchAbilitiesController:Destroy( )
            Self.controllers[ TouchAbilities ] = nil
            Self.touchAbilitiesController = nil
        else
            Self.touchAbilitiesController:Enable( false )
        end
    end

    local IsEnabled2
    local Enabled4 = Self.enabled

    if Enabled4 then
        if UserFlag10 then
            if UserFlag11 then
                IsEnabled2 = Get2:isEnabled( )
            else
                IsEnabled2 = UserFlag11
            end
        else
            IsEnabled2 = UserFlag10
        end
    else
        IsEnabled2 = Enabled4
    end
    if IsEnabled2 then
        if not Self.abilitiesGui then
            Self:CreateAbilitiesGuiContainer( )
        end
        if Self.abilitiesGui then
            if not Self.controllers[ AbilitiesOverflowMenu ] then
                Self.controllers[ AbilitiesOverflowMenu ] = AbilitiesOverflowMenu.new( Self.abilitiesFrame )
            end

            Self.abilitiesOverflowController = Self.controllers[ AbilitiesOverflowMenu ]
            Self.abilitiesOverflowController:Enable( true )

            if AbilitiesKeybindBar then
                if not Self.controllers[ AbilitiesKeybindBar ] then
                    Self.controllers[ AbilitiesKeybindBar ] = AbilitiesKeybindBar.new( Self.abilitiesGui )
                end

                Self.abilitiesKeybindBarController = Self.controllers[ AbilitiesKeybindBar ]
                Self.abilitiesKeybindBarController:Enable( true )
            end

            Self.abilitiesGui.Enabled = true
            return
        end
    else
        if Self.abilitiesOverflowController then
            Self.abilitiesOverflowController:Enable( false )
        end
        if Self.abilitiesKeybindBarController then
            Self.abilitiesKeybindBarController:Enable( false )
        end
        if Self.abilitiesGui then
            Self.abilitiesGui.Enabled = false
        end
    end
end
function __index.UpdateActiveControlModuleEnabled( Enabled )
    local function Callback()
        if UserFlag3 then
            Enabled.enabled = false
        end

        Enabled.activeController:Enable( false )

        if UserFlag3 then
            Enabled:UpdateAbilitiesControllers( )
        elseif Enabled.touchJumpController then
            Enabled.touchJumpController:Enable( false )
        end
        if Enabled.moveFunction then
            if not UserFlag3 or not Get2:isEnabled( ) then
                local MoveFunction = Enabled.moveFunction
                MoveFunction( Players.LocalPlayer, Vector3.new( 0, 0, 0 ), true )
            end
        end
    end

    local function Callback2()
        if UserFlag3 then
            Enabled.enabled = true
            Enabled:UpdateAbilitiesControllers( )
        elseif not Enabled.touchControlFrame or UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then
            if Enabled.touchJumpController then
                Enabled.touchJumpController:Enable( false )
            end
        elseif Enabled.activeControlModule == ClickToMoveController or Enabled.activeControlModule == ClassicThumbstick or Enabled.activeControlModule == DynamicThumbstick then
            if not Enabled.controllers[ TouchJump ] then
                Enabled.controllers[ TouchJump ] = TouchJump.new( Enabled.data )
            end

            Enabled.touchJumpController = Enabled.controllers[ TouchJump ]
            local TouchJumpController = Enabled.touchJumpController
            TouchJumpController:Enable( true, Enabled.touchControlFrame )
        elseif Enabled.touchJumpController then
            Enabled.touchJumpController:Enable( false )
        end
        if Enabled.activeControlModule == ClickToMoveController then
            local Flag
            local ActiveController = Enabled.activeController
            Flag = Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice and true or false
            ActiveController:Enable( true, Flag, Enabled.touchJumpController )
            return
        end
        if Enabled.touchControlFrame then
            local ActiveController2 = Enabled.activeController
            ActiveController2:Enable( true, Enabled.touchControlFrame )
            return
        end
        Enabled.activeController:Enable( true )
        return
    end

    if not Enabled.activeController then
        return
    end
    if not Enabled.controlsEnabled then
        Callback( )
        return
    end
    if not GuiService.TouchControlsEnabled and UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        if Enabled.activeControlModule == ClickToMoveController or Enabled.activeControlModule == ClassicThumbstick or Enabled.activeControlModule == DynamicThumbstick then
            Callback( )
            return
        end
    end

    Callback2( )
end
function __index.Enable( Self, ControlsEnabled )
    if UserFlag15 then
        warn( "ControlModule:Enable() and ControlModule:Disable() are deprecated and will be removed soon; set require(\"@rbx/PlayerModule\").ControlModule.Enabled instead" )
        return
    end

    local ControlsEnabled2 = if ControlsEnabled == nil then true else ControlsEnabled

    if Self.controlsEnabled == ControlsEnabled2 then
        return
    end

    Self.controlsEnabled = ControlsEnabled2

    if Self.activeController then
        Self:UpdateActiveControlModuleEnabled( )
        return
    end
    return
end
function __index.Disable( Argument1 )
    Argument1:Enable( false )
end
function __index.SelectComputerMovementModule( Argument1 )
    local Flag = false

    if UserFlag9 then
        pcall( function()
            local FlagInner = UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad and true or false
            Flag = FlagInner
        end )
    end
    if UserInputService.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse and UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad and not Flag then
        return nil, false
    end

    local Captured
    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode

    if DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice then
        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
            Captured = ClickToMoveController
        else
            Captured = ActionController
        end
    else
        local Entry = Table2[ DevComputerMovementMode ]

        if Entry or DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
            Captured = Entry
        else
            warn( "No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode )
            Captured = Entry
        end
    end
    if Captured then
        return Captured, true
    end
    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true
    end
    return nil, false
end
function __index.SelectTouchModule( Argument1 )
    local Entry
    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        Entry = Table2[ UserGameSettings.TouchMovementMode ]
    else
        if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true
        end

        Entry = Table2[ DevTouchMovementMode ]
    end

    return Entry, true
end
function __index.calculateRawMoveVector( Argument1, Humanoid, Argument3 )
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return Argument3
    end

    local CFrame3
    local CFrame2 = CurrentCamera.CFrame

    if not VRService.VREnabled or not Humanoid.RootPart then
        CFrame3 = CFrame2
    else
        local EstimatedVRTorsoFrame = Argument1:GetEstimatedVRTorsoFrame( )

        if ( CurrentCamera.Focus.Position - CFrame2.Position ).Magnitude < 3 then
            CFrame3 = CFrame2 * EstimatedVRTorsoFrame
        else
            CFrame3 = CurrentCamera.CFrame * ( EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * CurrentCamera.HeadScale )
        end
    end
    if Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
        if not VRService.VREnabled then
            return CFrame3:VectorToWorldSpace( Argument3 )
        end

        local X = Argument3.X
        local Vector32 = Vector3.new( X, 0, Argument3.Z )

        if Vector32.Magnitude < 0.01 then
            return Vector3.new( 0, 0, 0 )
        end

        local Number = if not CameraRotationAction or not CameraRotationAction.Enabled then 0 else -CameraRotationAction:GetState( ).Y / 2.31
        local Amount = -Vector32.X
        local Atan2 = math.atan2( Amount, -Vector32.Z )
        local _, ToEulerAnglesYXZ2 = CFrame3:ToEulerAnglesYXZ( )
        return CFrame.fromEulerAnglesYXZ( Number, Atan2 + ToEulerAnglesYXZ2, 0 ).LookVector
    end
    _, _, _, Components4, Components5, Components6, _, _, Components9, _, _, Components4 = CFrame3:GetComponents( )

    if not ( Components9 < 1 ) or not ( Components9 > -1 ) then
        Components6 = -Components5 * math.sign( Components9 )
    end

    local Sqrt = math.sqrt( Components4 * Components4 + Components6 * Components6 )
    local Components12 = ( Components4 * Argument3.X + Components6 * Argument3.Z ) / Sqrt
    return ( Vector3.new( Components12, 0, ( Components4 * Argument3.Z - Components6 * Argument3.X ) / Sqrt ) )
end
function __index.initialize( Self, Data )
    Self.data = Data
    Self:UpdateMovementMode( )

    if not UserFlag14 then
        ActionController.initializeActions( Self.data )
    end
    if UserFlag3 then
        InputSlots.setupSlotActions( Self.data.engineInterface.player, Self.data.isServerAuthority, Self.data.eventBus )
    end
end
function __index.Update( Argument1, Argument2, Argument3 )
    local Value1, Value2
    assert( Argument2.engineInterface.player )
    local ControlModule = Argument2.controlModule
    local ControlModule2 = Argument2.playerModule.ControlModule
    local EngineInterface = Argument2.engineInterface

    if UserFlag14 then
        local Humanoid = EngineInterface.humanoid

        if EngineInterface.characterChanged then
            Argument1:OnCharacterChanged( Humanoid )
        end
        if not UserFlag15 and not Humanoid then
            return
        end
        Value1 = Argument1
        Value2 = Argument2
        Argument3 = Argument3
    else
        assert( EngineInterface.character )

        if not UserFlag15 and not Argument1.humanoid then
            return
        end
        Value1 = Argument1
        Value2 = Argument2
        Argument3 = Argument3
    end

    local Enabled = ControlModule2.Enabled

    if UserFlag15 then
        ControlModule.enabled = Enabled

        if Enabled == Value1.controlsEnabled then
            if not Enabled then
                return
            end
        else
            Value1.controlsEnabled = Enabled
            Value1:UpdateActiveControlModuleEnabled( )
        end
    end
    if Enabled then
        if UserFlag15 and not Value1.humanoid then
            return
        end

        ActionController.initializeActions( Value2 )

        if UserFlag15 then
            if not ControlModule.actions.MoveAction or not ControlModule.actions.JumpAction then
                return
            end
        end
        if Value1.activeController and Value1.activeController.enabled and Value1.humanoid then
            local Update
            ActionController.update( Value2 )
            Value1:GetClickToMoveController( ):Update( Value2, Argument3 )
            local X = ControlModule.moveVector.X
            local Vector32 = Vector3.new( X, 0, -ControlModule.moveVector.Y )

            if Value1.vehicleController then
                Update, Update2 = Value1.vehicleController:Update( Vector32, true )
                _ = Update2
            else
                Update = Vector32
            end

            local WorldMoveVector
            local InputMoveVector = Value1:calculateRawMoveVector( Value1.humanoid, Update )
            Value1.inputMoveVector = InputMoveVector

            if VRService.VREnabled then
                WorldMoveVector = Value1:updateVRMoveVector( InputMoveVector )
            else
                WorldMoveVector = InputMoveVector
            end

            ControlModule.worldMoveVector = WorldMoveVector
            Value1:characterMove( Value2 )
        end

        return
    end
    ControlModule.isJumping = false
    ControlModule.moveVector = Vector2.new( )
    ControlModule.worldMoveVector = Vector3.new( )
    ActionController.update( Value2 )
    Value1.inputMoveVector = Vector3.new( )

    if Value1.vehicleController then
        local VehicleController = Value1.vehicleController
        VehicleController:Update( Vector3.new( ), true )
    end

    Value1:characterMove( Value2 )
    return
end
function __index.characterMove( Argument1, Argument2 )
    if UserFlag15 and not Argument1.humanoid then
        return
    end

    local ControlModule = Argument2.controlModule

    if UserFlag6 then
        if not Argument2.isServerAuthority then
            if not UserFlag3 or not Get2:isEnabled( ) then
                local MoveFunction = Argument1.moveFunction
                local LocalPlayer = Players.LocalPlayer
                MoveFunction( LocalPlayer, ControlModule.worldMoveVector, false )
                local Humanoid = Argument1.humanoid
                Humanoid.Jump = ControlModule.isJumping
                return
            end
            if not UserFlag15 then
                local WriteInputToCS = InputReplication.writeInputToCS
                WriteInputToCS( Players.LocalPlayer, Argument1 )
                return
            end
        end
    elseif not UserFlag8 or not Argument2.isServerAuthority then
        if not UserFlag3 or not Get2:isEnabled( ) then
            local MoveFunction2 = Argument1.moveFunction
            local LocalPlayer2 = Players.LocalPlayer
            MoveFunction2( LocalPlayer2, ControlModule.worldMoveVector, false )
            local Humanoid2 = Argument1.humanoid
            Humanoid2.Jump = ControlModule.isJumping
        end
    end
end
function __index.updateVRMoveVector( Argument1, Argument2 )
    local InFirstPerson
    local CurrentCamera = workspace.CurrentCamera
    local Position = CurrentCamera.Focus.Position - CurrentCamera.CFrame.Position

    if UserFlag then
        InFirstPerson = Get3.inFirstPerson
    else
        local Flag = if Position.Magnitude < 5 then true else false
        InFirstPerson = Flag
    end
    if Argument2.Magnitude ~= 0 or not InFirstPerson or not VRService.AvatarGestures or not Argument1.humanoid or Argument1.humanoid.Sit then
        return Argument2
    end

    local UserCFrame = VRService:GetUserCFrame( Enum.UserCFrame.Head )
    local Rotation = UserCFrame.Rotation + UserCFrame.Position * CurrentCamera.HeadScale
    local Y = -0.7 * Argument1.humanoid.RootPart.Size.Y / 2
    local Position2 = ( CurrentCamera.CFrame * Rotation * CFrame.new( 0, Y, 0 ) ).Position - Argument1.humanoid.RootPart.CFrame.Position
    local X = Position2.x
    local Vector32 = Vector3.new( X, 0, Position2.z )

    if UserFlag then
        local Magnitude = ( CurrentCamera.Focus.Position - CurrentCamera.CFrame.Position ).Magnitude

        if math.max( 4 * CurrentCamera.HeadScale, 1 ) < Magnitude then
            return Argument2
        end
    end

    return Vector32
end
function __index.OnHumanoidSeated( Argument1, Argument2, Object )
    if Argument2 then
        if Object and Object:IsA( "VehicleSeat" ) then
            if not Argument1.vehicleController then
                Argument1.vehicleController = Argument1.vehicleController.new( )
            end

            Argument1.vehicleController:Enable( true, Object )
            return
        end
    elseif Argument1.vehicleController then
        Argument1.vehicleController:Enable( false, Object )
    end
end

if UserFlag14 then
    function __index.OnCharacterChanged( Argument1, Humanoid )
        Argument1.humanoid = Humanoid
        Argument1:UpdateMovementMode( )

        if not Humanoid then
            return
        end
        if Argument1.humanoidSeatedConn then
            Argument1.humanoidSeatedConn:Disconnect( )
            Argument1.humanoidSeatedConn = nil
        end

        Argument1.humanoidSeatedConn = Humanoid.Seated:Connect( function( Argument1Inner, Argument2 )
            Argument1:OnHumanoidSeated( Argument1Inner, Argument2 )
        end )
    end
else
    function __index.OnCharacterAdded( Argument1, Object )
        Argument1.humanoid = Object:FindFirstChildOfClass( "Humanoid" )

        while not Argument1.humanoid do
            Object.ChildAdded:wait( )
            Argument1.humanoid = Object:FindFirstChildOfClass( "Humanoid" )
        end
        if Argument1.humanoidSeatedConn then
            Argument1.humanoidSeatedConn:Disconnect( )
            Argument1.humanoidSeatedConn = nil
        end

        Argument1.humanoidSeatedConn = Argument1.humanoid.Seated:Connect( function( Argument1Inner, Argument2 )
            Argument1:OnHumanoidSeated( Argument1Inner, Argument2 )
        end )
        Argument1:UpdateMovementMode( )
    end
    function __index.OnCharacterRemoving( Self, Argument2 )
        Self.humanoid = nil
        Self:UpdateMovementMode( )
    end
end

function __index.UpdateTouchGuiVisibility( Self )
    local Humanoid2
    local Humanoid = Self.humanoid

    if Humanoid then
        local TouchControlsEnabled = GuiService.TouchControlsEnabled

        if TouchControlsEnabled then
            if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                Humanoid2 = true
            else
                Humanoid2 = false
            end
        else
            Humanoid2 = TouchControlsEnabled
        end
    else
        Humanoid2 = Humanoid
    end
    if Humanoid2 and not Self.touchGui then
        Self:CreateTouchGuiContainer( )
    end
    if Self.touchGui then
        local TouchGui = Self.touchGui
        TouchGui.Enabled = not not Humanoid2
    end
end
function __index.SwitchToController( Self, ActiveControlModule )
    if ActiveControlModule then
        if not Self.controllers[ ActiveControlModule ] then
            local Controllers = Self.controllers
            Controllers[ ActiveControlModule ] = ActiveControlModule.new( Self.data )
        end
        if Self.activeController ~= Self.controllers[ ActiveControlModule ] then
            if Self.activeController then
                Self.activeController:Enable( false )
            end

            Self.activeController = Self.controllers[ ActiveControlModule ]
            Self.activeControlModule = ActiveControlModule
            Self:UpdateActiveControlModuleEnabled( )
        end

        return
    end
    if Self.activeController then
        Self.activeController:Enable( false )
    end

    Self.activeController = nil
    Self.activeControlModule = nil
    return
end
function __index.UpdateMovementMode( Self )
    Self:UpdateTouchGuiVisibility( )

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        local SelectTouchModule, SelectTouchModule2 = Self:SelectTouchModule( )

        if SelectTouchModule2 and Self.touchControlFrame then
            Self:SwitchToController( SelectTouchModule )
            return
        end
    else
        Self:SwitchToController( ( Self:SelectComputerMovementModule( ) ) )
    end
end
function __index.CreateTouchGuiContainer( Argument1 )
    if not Argument1.playerGui then
        return
    end
    if Argument1.touchGui then
        Argument1.touchGui:Destroy( )
    end

    Argument1.touchGui = Instance.new( "ScreenGui" )
    Argument1.touchGui.Name = "TouchGui"
    Argument1.touchGui.ResetOnSpawn = false
    Argument1.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    if UserFlag3 and UserFlag11 then
        Argument1.touchGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    end

    Argument1.touchGui.ClipToDeviceSafeArea = false
    Argument1.touchControlFrame = Instance.new( "Frame" )
    Argument1.touchControlFrame.Name = "TouchControlFrame"
    local TouchControlFrame = Argument1.touchControlFrame
    TouchControlFrame.Size = UDim2.new( 1, 0, 1, 0 )
    Argument1.touchControlFrame.BackgroundTransparency = 1
    local TouchControlFrame2 = Argument1.touchControlFrame
    TouchControlFrame2.Parent = Argument1.touchGui
    local TouchGui = Argument1.touchGui
    TouchGui.Parent = Argument1.playerGui
end
function __index.CreateAbilitiesGuiContainer( Argument1 )
    if not Argument1.playerGui then
        return
    end
    if Argument1.abilitiesGui then
        Argument1.abilitiesGui:Destroy( )
    end

    Argument1.abilitiesGui = Instance.new( "ScreenGui" )
    Argument1.abilitiesGui.Name = "AbilitiesGui"
    Argument1.abilitiesGui.ResetOnSpawn = false
    Argument1.abilitiesGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Argument1.abilitiesGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    Argument1.abilitiesGui.ClipToDeviceSafeArea = false
    Argument1.abilitiesFrame = Instance.new( "Frame" )
    Argument1.abilitiesFrame.Name = "AbilitiesFrame"
    local AbilitiesFrame = Argument1.abilitiesFrame
    AbilitiesFrame.Size = UDim2.new( 1, 0, 1, 0 )
    Argument1.abilitiesFrame.BackgroundTransparency = 1
    local AbilitiesFrame2 = Argument1.abilitiesFrame
    AbilitiesFrame2.Parent = Argument1.abilitiesGui
    local AbilitiesGui = Argument1.abilitiesGui
    AbilitiesGui.Parent = Argument1.playerGui
end
function __index.GetClickToMoveController( Argument1 )
    if not Argument1.controllers[ ClickToMoveController ] then
        Argument1.controllers[ ClickToMoveController ] = ClickToMoveController.new( )
    end

    return Argument1.controllers[ ClickToMoveController ]
end
function __index.ProcessInputs( Argument1, Object, Argument3 )
    if UserFlag3 then
        if not AvatarAbilitiesInterface2.get( Object ):isEnabled( ) then
            if UserFlag6 then
                InputReplication.processPCSInputs( Object )
                return
            end
            InputReplication.SendInputToHumanoidForServerAuth( Object )
            return
        end
    else
        if UserFlag6 then
            InputReplication.processPCSInputs( Object )
            return
        end

        local Character = Object.Character

        if Character == nil then
            return
        end

        local Humanoid = Character:FindFirstChild( "Humanoid" )

        if Humanoid == nil then
            return
        end

        local InputContexts = Object:FindFirstChild( "InputContexts" )

        if InputContexts == nil then
            return
        end

        local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

        if CharacterContext == nil then
            return
        end

        local State
        local MoveAction = CharacterContext.MoveAction
        local RotationAction = CharacterContext.RotationAction
        local JumpAction = CharacterContext.JumpAction

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
            State = Vector2.new( 0, 0 )
        else
            State = MoveAction:GetState( )
        end

        local Flag
        local LookVector = Object:GetCameraState( ).CFrame.LookVector

        if State.X == State.X then
            if State.Y == State.Y then
                if State.X == math.huge then
                    Flag = true
                elseif State.Y == math.huge then
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

                if Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
                    LookVector2 = LookVector
                else
                    local X = LookVector.X
                    LookVector2 = Vector3.new( X, 0, LookVector.Z ).Unit
                end

                local Unit = LookVector2:Cross( Vector3.new( 0, 1, 0 ) ).Unit
                Humanoid:Move( LookVector2 * State.Y + Unit * State.X )

                if RotationAction:GetState( ) then
                    Humanoid.AutoRotate = false

                    if Humanoid.SeatPart == nil and Humanoid.RootPart ~= nil and not Humanoid.Sit and not Humanoid.RootPart:IsGrounded( ) then
                        local RootPart = Humanoid.RootPart
                        RootPart.CFrame = CFrame.new( Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + LookVector2 )
                    end
                else
                    Humanoid.AutoRotate = true
                end
            end
        end

        local Jump

        if JumpAction == nil then
            Jump = false
        else
            Jump = JumpAction:GetState( )
        end

        Humanoid.Jump = Jump
    end
end

if RunService:IsClient( ) then
    local New = __index.new( )
    return New
end
return __index
