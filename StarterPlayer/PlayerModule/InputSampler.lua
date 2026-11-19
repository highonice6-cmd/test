-- StarterPlayer.PlayerModule.InputSampler
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local UserFlag6
local Players = game:GetService( "Players" )
local Workspace = game:GetService( "Workspace" )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local CommonUtils = require( script.Parent:WaitForChild( "CommonUtils" ) )
require( script.Parent.Types )
local Get = CommonUtils.get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserPlayerScriptsCCLIntegrationD" )
UserFlag6 = if UserFlag then UserFlag else Get.getUserFlag( "UserPlayerScriptsCCLIntegrationDGA" )
local UserFlag7
local UserFlag2 = Get.getUserFlag( "UserPlayerScriptsPlayerControlState2" )
UserFlag7 = if UserFlag2 then UserFlag2 else Get.getUserFlag( "UserPlayerScriptsPlayerControlState2GA" )
local Get2
local UserFlag3 = Get.getUserFlag( "UserAbilitiesUserInterfaceB" )
local UserFlag4 = Get.getUserFlag( "UserControlModuleDisabledUpdate" )
local UserFlag5 = Get.getUserFlag( "UserPlayerModuleEngineAPI" )
local AvatarAbilitiesInterface = require( script.Parent:WaitForChild( "ControlModule" ):WaitForChild( "AvatarAbilitiesInterface" ) )

if UserFlag6 then
    Get2 = AvatarAbilitiesInterface.get( Players.LocalPlayer )
else
    Get2 = nil
end

local Text = not UserFlag3 and "PlayerControlState" or "ControlState"
local __index = { }
__index.__index = __index
function __index.new()
    return ( setmetatable( {
        controlData = {
            enabled = true,
            isJumping = false,
            worldMoveVector = Vector3.new( 0, 0, 0 )
        }
    }, __index ) )
end
function __index.Update( Argument1, Argument2 )
    if not UserFlag4 then
        return
    end

    local Player = Argument2.engineInterface.player

    if not Player then
        return
    end
    if UserFlag7 then
        local Character

        if UserFlag5 then
            Character = Argument2.engineInterface.character
        else
            Character = Player.Character
        end
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

        local Humanoid

        if UserFlag5 then
            Humanoid = Argument2.engineInterface.humanoid
        else
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        end
        if not Humanoid then
            return
        end

        local Flag = UserGameSettings.RotationType == Enum.RotationType.CameraRelative and true or false
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

        local Table = { RotateToLookDirection = Flag, LookDirection = Unit }

        if Argument2.controlModule.enabled or Argument1.controlData.enabled then
            Table.Move = Argument2.controlModule.worldMoveVector

            if not Get2 or not Get2:isEnabled( ) then
                Table.Jump = Argument2.controlModule.isJumping
            end
        end

        local ControlData = Argument1.controlData
        ControlData.enabled = Argument2.controlModule.enabled
        local ControlData2 = Argument1.controlData
        ControlData2.isJumping = Argument2.controlModule.isJumping
        local ControlData3 = Argument1.controlData
        ControlData3.worldMoveVector = Argument2.controlModule.worldMoveVector
        FoundChildOfClass:UpdateFields( Table )
        return
    end
    if Argument2.isServerAuthority then
        local InputContexts = Player:FindFirstChild( "InputContexts" )

        if not InputContexts then
            return
        end

        local CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )

        if not CharacterContext then
            return
        end

        local RotationAction = CharacterContext:FindFirstChild( "RotationAction" )

        if RotationAction and RotationAction:FindFirstChild( "RotationScriptableBinding" ) then
            local Flag2 = UserGameSettings.RotationType == Enum.RotationType.CameraRelative and true or false
            RotationAction:FindFirstChild( "RotationScriptableBinding" ):Fire( Flag2 )
        end
    end

    return
end
return __index
