-- StarterPlayer.StarterPlayerScripts.VehicleClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local CollectionService = game:GetService( "CollectionService" )
local ContextActionService = game:GetService( "ContextActionService" )
local UserInputService = game:GetService( "UserInputService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Debris = game:GetService( "Debris" )
local VehicleSystem = ReplicatedStorage:WaitForChild( "VehicleSystem" )
local VehiclePhysics = require( VehicleSystem:WaitForChild( "VehiclePhysics" ) )
local EngineAudio = require( VehicleSystem:WaitForChild( "EngineAudio" ) )
local BurnoutFX = require( VehicleSystem:WaitForChild( "BurnoutFX" ) )
local VehicleSync = require( VehicleSystem:WaitForChild( "VehicleSync" ) )
local ExitSpot = require( VehicleSystem:WaitForChild( "ExitSpot" ) )
local VehicleImpact = require( VehicleSystem:WaitForChild( "VehicleImpact" ) )
VehicleSync.StartClient( )
local VehicleAction = VehicleSystem:WaitForChild( "VehicleAction" )
local VehicleFX = VehicleSystem:WaitForChild( "VehicleFX" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local CarSteer = setmetatable( { }, { __mode = "k" } )
ClientState.CarSteer = CarSteer
local AnimWorkers = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "AnimWorkers" ) )
local Effects = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "Effects" ) )
local WeaponData = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "WeaponData" ) )
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local F = Enum.KeyCode.F
local Value = Enum.ContextActionPriority.High.Value + 150
local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "Notify", 10 ) )

if not Success then
    Result = nil
end

local Value2 = Enum.ContextActionPriority.High.Value + 50
local Table = { }
local Vehicle = CollectionService:GetTagged( "Vehicle" )
local Table2 = { }
local Value1 = nil
local Flag = false
local Flag2 = false
local Flag3 = false
local Flag4 = false
local Flag5 = false
local Flag6 = false
local Flag7 = false
local Value3 = nil
local Value4 = nil
local Value5 = nil
task.spawn( function()
    local PlayerModule3
    local StarterPlayer = game:GetService( "StarterPlayer" )
    local PlayerScripts = LocalPlayer:WaitForChild( "PlayerScripts" )
    local I = 1
    PlayerModule3 = nil

    for I = 1, 200 do
        local PlayerModule2
        local PlayerModule = PlayerScripts:FindFirstChild( "PlayerModule" )

        if PlayerModule then
            PlayerModule2 = PlayerModule
        else
            PlayerModule2 = StarterPlayer:FindFirstChild( "PlayerModule" )
        end
        if PlayerModule2 then
            PlayerModule3 = PlayerModule2
            break
        end

        task.wait( 0.1 )
        PlayerModule3 = PlayerModule2
    end
    if PlayerModule3 then
        pcall( function()
            local Captured = require( PlayerModule3 )

            if type( Captured ) == "table" and Captured.GetControls then
                Value5 = Captured:GetControls( )
                return
            end
            if PlayerModule3:FindFirstChild( "ControlModule" ) then
                Value5 = require( PlayerModule3.ControlModule )
            end
        end )
        return
    end
    return
end )
local Controls = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Controls" ) )
local KeyCode = Enum.KeyCode
task.spawn( function()
    local InputContexts
    local PlayerModule = game:GetService( "StarterPlayer" ):WaitForChild( "PlayerModule", 30 )

    if PlayerModule then
        InputContexts = PlayerModule:WaitForChild( "InputContexts", 30 )
    else
        InputContexts = PlayerModule
    end

    local VehicleContext

    if InputContexts then
        VehicleContext = InputContexts:WaitForChild( "VehicleContext", 30 )
    else
        VehicleContext = InputContexts
    end

    local SteerAction

    if VehicleContext then
        SteerAction = VehicleContext:WaitForChild( "SteerAction", 30 )
    else
        SteerAction = VehicleContext
    end
    if not SteerAction then
        return
    end

    local function Clear( Object )
        if not Object:IsA( "InputBinding" ) then
            return
        end

        local function None()
            if Object.Up ~= Enum.KeyCode.None then
                Object.Up = Enum.KeyCode.None
            end
            if Object.Down ~= Enum.KeyCode.None then
                Object.Down = Enum.KeyCode.None
            end
        end

        if Object.Up ~= Enum.KeyCode.None then
            Object.Up = Enum.KeyCode.None
        end
        if Object.Down ~= Enum.KeyCode.None then
            Object.Down = Enum.KeyCode.None
        end

        Object:GetPropertyChangedSignal( "Up" ):Connect( None )
        Object:GetPropertyChangedSignal( "Down" ):Connect( None )
    end

    for Key, Value in SteerAction:GetChildren( ) do
        if Value.Name:find( "Keyboard" ) then
            Clear( Value )
        end
    end

    SteerAction.ChildAdded:Connect( function( Object )
        if Object.Name:find( "Keyboard" ) then
            Clear( Object )
        end
    end )
end )

local function RawInput()
    local Number3, Number6

    if UserInputService:GetFocusedTextBox( ) then
        Number3 = 0
        Number6 = 0
    else
        local Number = not Controls.IsDown( "MoveForward" ) and 0 or 1
        local Number2 = not Controls.IsDown( "MoveBack" ) and 0 or 1
        local Number4
        Number3 = Number - Number2
        Number4 = not Controls.IsDown( "MoveRight" ) and 0 or 1
        local Number5 = not Controls.IsDown( "MoveLeft" ) and 0 or 1
        Number6 = Number4 - Number5
    end

    local Success, Result = pcall( UserInputService.GetGamepadState, UserInputService, Enum.UserInputType.Gamepad1 )

    if Success and Result then
        local Value1 = nil

        for Key, Value in Result, nil, nil do
            if Value.KeyCode == KeyCode.Thumbstick1 and math.abs( Value.Position.X ) > 0.2 then
                Number6 = Value.Position.X
            end
            if Value.KeyCode == KeyCode.ButtonR2 and Value.Position.Z > 0.1 then
                Number3 = Value.Position.Z
            end
            if Value.KeyCode == KeyCode.ButtonL2 and Value.Position.Z > 0.1 then
                Number3 = -Value.Position.Z
            end
        end
    end
    if Number3 == 0 and Number6 == 0 and Value5 then
        local Success2, Result2 = pcall( function()
            if Value5.GetMoveVector then
                return Value5:GetMoveVector( )
            end
            return Value5.inputMoveVector
        end )

        if Success2 and typeof( Result2 ) == "Vector3" then
            Number3 = -Result2.Z
            Number6 = Result2.X
        end
    end
    if math.abs( Number3 ) < 0.05 then
        Number3 = 0
    end
    if math.abs( Number6 ) < 0.05 then
        Number6 = 0
    end

    return Number3, Number6
end

local function PadInput()
    local Number5, Number6
    local Success, Result = pcall( UserInputService.GetGamepadState, UserInputService, Enum.UserInputType.Gamepad1 )

    if not Success or not Result then
        Number5 = 0
        Number6 = 0
    else
        local Value1, Number, Number2
        Value1 = nil
        Number = 0
        Number2 = 0
        Number6 = 0

        for Key, Value in Result, nil, nil do
            if Value.KeyCode == KeyCode.Thumbstick1 and math.abs( Value.Position.X ) > 0.15 then
                Number6 = Value.Position.X
            end
            if Value.KeyCode == KeyCode.ButtonR2 then
                Number = Value.Position.Z
            end
            if Value.KeyCode == KeyCode.ButtonL2 then
                Number2 = Value.Position.Z
            end
        end

        local Number3 = ( not ( Number > 0.05 ) or not Number ) and 0 or Number
        local Number4 = ( not ( Number2 > 0.05 ) or not Number2 ) and 0 or Number2
        Number5 = Number3 - Number4
    end

    return Number5, Number6
end

local function TouchInput( Argument1 )
    local IsVirtualDown2
    local IsVirtualDown = Controls.IsVirtualDown( "DriveGas" )
    IsVirtualDown2 = if IsVirtualDown then IsVirtualDown else Controls.IsVirtualDown( "DriveWheelie" )
    local Number = not IsVirtualDown2 and 0 or 1
    local Number2 = not Controls.IsVirtualDown( "DriveReverse" ) and 0 or 1
    local SteerFloat2
    local Number3 = Number - Number2
    local SteerFloat = Argument1.SteerFloat
    SteerFloat2 = if math.abs( SteerFloat ) < 0.05 then 0 else SteerFloat
    return Number3, SteerFloat2
end

local Table3 = { left = false, right = false }

local function DriverInput( Argument1 )
    if Controls.Locked then
        return 0, 0
    end
    if Controls.IsGamepad then
        return PadInput( )
    end
    if Controls.TouchMode( ) then
        return TouchInput( Argument1 )
    end

    local ThrottleFloat2, SteerFloat2
    local ThrottleFloat = Argument1.ThrottleFloat
    local SteerFloat = Argument1.SteerFloat

    if ThrottleFloat ~= 0 or SteerFloat ~= 0 then
        SteerFloat2 = SteerFloat
        ThrottleFloat2 = ThrottleFloat
    else
        ThrottleFloat2, SteerFloat2 = RawInput( )
    end
    if Table3.left and not Controls.IsDown( "MoveLeft" ) then
        Table3.left = false
    end
    if Table3.right and not Controls.IsDown( "MoveRight" ) then
        Table3.right = false
    end
    if not ( SteerFloat2 < 0 ) or not Table3.left then
        if SteerFloat2 > 0 and Table3.right then
            SteerFloat2 = 0
        end
    else
        SteerFloat2 = 0
    end

    return ThrottleFloat2, SteerFloat2
end

local function BurnPedals()
    if Controls.Locked then
        return false
    end
    if Controls.TouchMode( ) then
        local IsVirtualDown2
        local IsVirtualDown = Controls.IsVirtualDown( "DriveGas" )
        IsVirtualDown2 = if IsVirtualDown then Controls.IsVirtualDown( "DriveReverse" ) else IsVirtualDown
        return IsVirtualDown2
    end
    if Controls.IsGamepad then
        local Z, Number
        local Success, Result = pcall( UserInputService.GetGamepadState, UserInputService, Enum.UserInputType.Gamepad1 )

        if not Success or not Result then
            Z = 0
            Number = 0
        else
            local Value1 = nil
            Z = 0
            Number = 0

            for Key, Value in Result, nil, nil do
                if Value.KeyCode == KeyCode.ButtonR2 then
                    Z = Value.Position.Z
                elseif Value.KeyCode == KeyCode.ButtonL2 then
                    Number = Value.Position.Z
                end
            end
        end

        local Flag

        if Z > 0.3 then
            if Number > 0.3 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end

        return Flag
    end
    local IsDown2
    local NotFocusedTextBox = not UserInputService:GetFocusedTextBox( )

    if NotFocusedTextBox then
        local IsDown = Controls.IsDown( "MoveForward" )

        if IsDown then
            IsDown2 = Controls.IsDown( "MoveBack" )
        else
            IsDown2 = IsDown
        end
    else
        IsDown2 = NotFocusedTextBox
    end

    return IsDown2
end

local function WheelieHeld()
    if Controls.Locked or UserInputService:GetFocusedTextBox( ) then
        return false
    end
    if Controls.IsDown( "DriveWheelie" ) then
        return true
    end
    if Controls.IsGamepad then
        local Result2
        local Success, Result = pcall( UserInputService.GetGamepadState, UserInputService, Enum.UserInputType.Gamepad1 )
        Result2 = Success and Result or { }
        local Value1 = nil

        for Key, Value in Result2, nil, nil do
            if Value.KeyCode == KeyCode.Thumbstick1 then
                if Value.Position.Y < -0.6 then
                    return true
                end
            end
        end
    end

    return false
end

local function StateOf( Key )
    local Entry2
    local Entry = Table[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local State = VehiclePhysics.newState( Key ) or false
        Table[ Key ] = State
        Entry2 = State
    end

    return Entry2 or nil
end

CollectionService:GetInstanceRemovedSignal( "Vehicle" ):Connect( function( Key )
    Table[ Key ] = nil
    Table2[ Key ] = nil
    Vehicle = CollectionService:GetTagged( "Vehicle" )
end )
CollectionService:GetInstanceAddedSignal( "Vehicle" ):Connect( function()
    Vehicle = CollectionService:GetTagged( "Vehicle" )
end )

local function GetCharacter()
    local Character2
    local Character = LocalPlayer.Character
    Character2 = if Character then Character:FindFirstChildOfClass( "Humanoid" ) else Character
    local Character3 = if Character then Character:FindFirstChild( "HumanoidRootPart" ) else Character
    return Character, Character2, Character3
end

local Table4 = { }
local Number = 0
local Table5 = { }
local Value6 = nil
local Flag8 = false
local Number2 = 0

local function PromptScore( Value, Argument2, Argument3, Magnitude )
    local Position
    local LookVector = Value.CFrame.LookVector
    local RightVector = Value.CFrame.RightVector
    local Abs = math.abs( ( ( Argument3 - Value.Position ):Dot( LookVector ) ) )
    Position = Argument2 and Argument2.Position or Value.Position
    local Flag
    local Dot = ( Value.Position - Position ):Dot( RightVector )
    local Dot2 = ( Argument3 - Position ):Dot( RightVector )

    if math.abs( Dot ) > 0.5 then
        if Dot * Dot2 < 0 then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    local Number = not Flag and 0 or 4
    return Abs + Number + Magnitude * 0.1
end

local function UpdatePrompts()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local HumanoidRootPart

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local CarriedBy

    if Character then
        local Downed = Character:GetAttribute( "Downed" )

        if Downed then
            CarriedBy = Downed
        else
            CarriedBy = Character:GetAttribute( "CarriedBy" )
        end
    else
        CarriedBy = Character
    end
    if Flag8 and Value6 then
        local Clock = os.clock( ) - Number2

        if Value6.HoldDuration + 0.75 < Clock then
            Flag8 = false
        end
    end

    local Value5

    if Value1 or not ( Number <= os.clock( ) ) or not Humanoid or not HumanoidRootPart or not ( Humanoid.Health > 0 ) or CarriedBy then
        Value5 = nil
    else
        local Value2, Value3
        Value2 = nil
        Value3 = nil
        Value5 = nil

        for Key, Value in pairs( Table4 ) do
            local Parent = Key.Parent
            local Model = Value:FindFirstAncestorWhichIsA( "Model" )

            if not Value.Occupant and Parent and Parent:IsDescendantOf( workspace ) and Model and not Model:GetAttribute( "Destroyed" ) and not Model:GetAttribute( "Noyee" ) then
                local WorldPosition = Parent.WorldPosition - HumanoidRootPart.Position
                local X = WorldPosition.X
                local Magnitude = Vector3.new( X, 0, WorldPosition.Z ).Magnitude
                local Entry = Table5[ Key ] or 6
                local Parent2 = Parent.Parent
                local PromptScore2 = PromptScore( Value, Parent2, HumanoidRootPart.Position, Magnitude )

                if Key == Value6 then
                    local NumberInner = not Flag8 and 1 or 3

                    if Magnitude <= Entry + NumberInner then
                        Value2 = PromptScore2
                    end
                end
                if Magnitude <= Entry then
                    if not Value3 or PromptScore2 < Value3 then
                        Value3 = PromptScore2
                        Value5 = Key
                    end
                end
            end
        end
        if Value2 then
            if Flag8 or not Value3 or Value2 - 0.6 < Value3 then
                Value5 = Value6
            end
        end
    end
    if Value5 ~= Value6 then
        Flag8 = false
    end

    Value6 = Value5

    for Value7 in pairs( Table4 ) do
        local Enabled = Value7 == Value5 and true or false

        if Value7.Enabled ~= Enabled then
            Value7.Enabled = Enabled
        end
    end
end

local function AddPrompts( PromptsName )
    if Table2[ PromptsName ] then
        return
    end

    local VehicleSeats2
    Table2[ PromptsName ] = true
    local VehicleSeats = PromptsName:WaitForChild( "VehicleSeats", 10 )
    local Parent = PromptsName:WaitForChild( "VehicleHitbox", 10 )

    if VehicleSeats then
        if Parent then
            local Entry2
            local Entry = Table[ PromptsName ]

            if Entry then
                Entry2 = Entry
            else
                local State = VehiclePhysics.newState( PromptsName ) or false
                Table[ PromptsName ] = State
                Entry2 = State
            end

            VehicleSeats2 = Entry2 or nil
        else
            VehicleSeats2 = Parent
        end
    else
        VehicleSeats2 = VehicleSeats
    end
    if not VehicleSeats2 then
        return
    end
    for Index, Value in ipairs( Parent:GetChildren( ) ) do
        if Value.Name == "EnterPrompt" then
            Value:Destroy( )
        end
    end
    for Index2, Value3 in ipairs( VehicleSeats:GetChildren( ) ) do
        local ActionText
        local PointToObjectSpace = Parent.CFrame:PointToObjectSpace( Value3.Position )
        local Parent2 = Instance.new( "Attachment" )
        Parent2.Name = "EnterPrompt"
        Parent2.Position = PointToObjectSpace + Vector3.new( 0, 1.2000000476837158, 0 )
        local ProximityPrompt = Instance.new( "ProximityPrompt" )
        ActionText = Value3:GetAttribute( "Role" ) ~= "Driver" and "Passenger" or "Drive"
        ProximityPrompt.ActionText = ActionText
        ProximityPrompt.ObjectText = PromptsName.Name
        ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
        ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonY
        ProximityPrompt:AddTag( "InteractPrompt" )
        ProximityPrompt:AddTag( "NoHoldGauge" )
        ProximityPrompt.HoldDuration = VehicleSeats2.cfg.EnterHold
        ProximityPrompt.MaxActivationDistance = VehicleSeats2.cfg.EnterDistance + 3
        Table5[ ProximityPrompt ] = VehicleSeats2.cfg.EnterDistance
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.ClickablePrompt = UserInputService.TouchEnabled
        ProximityPrompt.Enabled = false
        ProximityPrompt.Parent = Parent2
        ProximityPrompt.PromptButtonHoldBegan:Connect( function()
            if ProximityPrompt == Value6 then
                Flag8 = true
                Number2 = os.clock( )
            end
        end )
        ProximityPrompt.PromptButtonHoldEnded:Connect( function()
            Flag8 = false
        end )
        ProximityPrompt.Triggered:Connect( function()
            Flag8 = false

            if Value1 or os.clock( ) < Number then
                return
            end

            local Character = LocalPlayer.Character

            if Character then
                if Character:GetAttribute( "Downed" ) or Character:GetAttribute( "CarriedBy" ) then
                    return
                end
            end
            if Value3:GetAttribute( "Role" ) ~= "Driver" or not PromptsName:GetAttribute( "Locked" ) or PromptsName:GetAttribute( "OwnerId" ) == LocalPlayer.UserId then
                Number = os.clock( ) + 1.5
                UpdatePrompts( )
                VehicleAction:FireServer( "Enter", PromptsName, Value3 )
                return
            end
            if Result and Result.Error then
                Result.Error( "This vehicle is locked​⁠​⁠​⁠​⁠​⁠​⁠​​⁠​​​​⁠⁠​​​" )
            end
        end )
        ProximityPrompt.Destroying:Connect( function()
            Table4[ ProximityPrompt ] = nil
            Table5[ ProximityPrompt ] = nil
        end )
        Table4[ ProximityPrompt ] = Value3
        Parent2.Parent = Parent
    end

    UpdatePrompts( )
end

CollectionService:GetInstanceAddedSignal( "Vehicle" ):Connect( AddPrompts )

for Index, Value8 in ipairs( CollectionService:GetTagged( "Vehicle" ) ) do
    task.spawn( AddPrompts, Value8 )
end

task.spawn( function()
    while true do
        UpdatePrompts( )
        task.wait( 0.1 )
    end
end )
local Value9 = nil

local function DoExit()
    if not Value1 then
        return
    end

    VehicleAction:FireServer( "Exit" )

    if Value1.driver then
        local SeatWeld
        local Seat = Value1.seat

        if Seat then
            SeatWeld = Value1.seat:FindFirstChild( "SeatWeld" )
        else
            SeatWeld = Seat
        end
        if SeatWeld then
            SeatWeld:Destroy( )
        end

        local Humanoid
        local Character = LocalPlayer.Character

        if Character then
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end
        if Character then
            Character:FindFirstChild( "HumanoidRootPart" )
        end
        if Humanoid then
            Humanoid.Sit = false
        end
    end
end

local function OnExit( Argument1, Begin, Argument3 )
    if Begin ~= Enum.UserInputState.Begin or not Value1 then
        if Begin ~= Enum.UserInputState.End or not Value9 then
            if Begin == Enum.UserInputState.Cancel then
                Value9 = nil
            end
        else
            Value9 = nil

            if Value1 and Value1.driver then
                VehicleAction:FireServer( "Horn" )
            end
        end

        return Enum.ContextActionResult.Sink
    end
    Value9 = nil

    if Value1 then
        VehicleAction:FireServer( "Exit" )

        if Value1.driver then
            local SeatWeld
            local Seat = Value1.seat

            if Seat then
                SeatWeld = Value1.seat:FindFirstChild( "SeatWeld" )
            else
                SeatWeld = Seat
            end
            if SeatWeld then
                SeatWeld:Destroy( )
            end

            local Humanoid
            local Character = LocalPlayer.Character

            if Character then
                Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if Character then
                Character:FindFirstChild( "HumanoidRootPart" )
            end
            if Humanoid then
                Humanoid.Sit = false
            end
        end
    end

    return Enum.ContextActionResult.Sink
end

local function SetJumpBlocked( Argument1, Argument2 )
    local JumpButton
    Argument1:SetStateEnabled( Enum.HumanoidStateType.Jumping, not Argument2 )
    local TouchGui = LocalPlayer.PlayerGui:FindFirstChild( "TouchGui" )

    if TouchGui then
        JumpButton = TouchGui:FindFirstChild( "JumpButton", true )
    else
        JumpButton = TouchGui
    end
    if JumpButton then
        JumpButton.Visible = not Argument2
    end
end

local function MobileExitButton()
    local Descendants
    local MobileGui = LocalPlayer.PlayerGui:FindFirstChild( "MobileGui" )
    Descendants = MobileGui and MobileGui:GetDescendants( ) or { }
    local Value1 = nil

    for Key, Value in Descendants, nil, nil do
        if Value:IsA( "GuiButton" ) then
            if Value:GetAttribute( "Action" ) == "VehicleExit" then
                return Value
            end
        end
    end

    return nil
end

local function Sink()
    return Enum.ContextActionResult.Sink
end

local function OnHandbrake( Argument1, Argument2 )
    local FlagInner

    if Argument2 == Enum.UserInputState.Begin then
        FlagInner = true
    elseif Argument2 == Enum.UserInputState.Change then
        FlagInner = true
    else
        FlagInner = false
    end
    if FlagInner ~= Flag then
        Flag = FlagInner
        VehicleAction:FireServer( "Handbrake", FlagInner )
    end

    return Enum.ContextActionResult.Sink
end

Controls.Pressed:Connect( function( Name, Argument2 )
    if Name ~= "DriveBrake" or not Value1 or not Value1.driver then
        if Name == "VehicleExit" and Argument2 and Value1 then
            OnExit( nil, Enum.UserInputState.Begin )
        end

        return
    end
    local Begin = Argument2 and Enum.UserInputState.Begin or Enum.UserInputState.End
    local FlagInner

    if Begin == Enum.UserInputState.Begin then
        FlagInner = true
    elseif Begin == Enum.UserInputState.Change then
        FlagInner = true
    else
        FlagInner = false
    end
    if FlagInner ~= Flag then
        Flag = FlagInner
        VehicleAction:FireServer( "Handbrake", FlagInner )
    end

    return
end )

local function WithInputs( Argument1, Argument2 )
    local Clone = table.clone( Argument1 )

    for Key, Value in Controls.InputsFor( Argument2 ) do
        if not table.find( Clone, Value ) then
            table.insert( Clone, Value )
        end
    end

    return Clone
end

local function BindSeatActions( Actions )
    local Table = { }

    for Key, ValueInner in Controls.InputsFor( "Interact" ) do
        if ValueInner ~= F then
            table.insert( Table, ValueInner )
        end
    end

    local Table2 = if #Table == 0 then { Enum.KeyCode.E, Enum.KeyCode.ButtonY } else Table

    if Actions then
        ContextActionService:BindActionAtPriority( "VehicleHorn", function( Argument1, Argument2 )
            if Argument2 == Enum.UserInputState.Begin and Value1 and Value1.driver then
                VehicleAction:FireServer( "Horn" )
            end

            return Enum.ContextActionResult.Sink
        end, false, Value, F )
    else
        ContextActionService:UnbindAction( "VehicleHorn" )
    end

    local FlagInner = MobileExitButton( ) == nil and true or false
    ContextActionService:BindActionAtPriority( "VehicleExit", OnExit, FlagInner, Value2, table.unpack( Table2 ) )
    ContextActionService:SetTitle( "VehicleExit", "Exit" )

    if FlagInner and UserInputService.TouchEnabled then
        task.spawn( function()
            local VehicleExit2
            local VehicleExit = ContextActionService:GetButton( "VehicleExit" )
            VehicleExit2 = if VehicleExit then VehicleExit.Parent else VehicleExit

            if VehicleExit2 and VehicleExit2:IsA( "GuiBase2d" ) and VehicleExit2.AbsoluteSize.X >= 10 and VehicleExit2.AbsoluteSize.Y >= 10 then
                local Y2
                local CurrentCamera = workspace.CurrentCamera

                if not CurrentCamera or not ( CurrentCamera.ViewportSize.Y > 0 ) then
                    Y2 = 1
                else
                    local Y = CurrentCamera.ViewportSize.Y / 1080

                    if Y then
                        Y2 = Y
                    else
                        Y2 = 1
                    end
                end

                local AbsoluteSize = VehicleExit2.AbsoluteSize
                ContextActionService:SetPosition( "VehicleExit", UDim2.fromScale( math.max( 0, 1 - 150 * Y2 / AbsoluteSize.X ), ( math.max( 0, 1 - 190 * Y2 / AbsoluteSize.Y ) ) ) )
            end
        end )
    end

    local Callback
    local Table3 = { Enum.KeyCode.ButtonA }
    Callback = Actions and function( Argument1, Argument2, Argument3 )
        if Argument2 == Enum.UserInputState.Begin and ClientState.HotbarCycle and Argument3 and Controls.Is( "DriveSwap", Argument3 ) then
            ClientState.HotbarCycle( 1 )
        end

        return Enum.ContextActionResult.Sink
    end or Sink
    local Table4

    if Actions then
        local WithInputs2 = WithInputs( Table3, "DriveSwap" )

        if WithInputs2 then
            Table4 = WithInputs2
        else
            Table4 = Table3
        end
    else
        Table4 = Table3
    end

    ContextActionService:BindActionAtPriority( "VehicleBlockJump", Callback, false, Value2, table.unpack( Table4 ) )
    local Table5 = { Enum.KeyCode.Space, Enum.KeyCode.ButtonB }

    for Key2, Value2Inner in Controls.InputsFor( "Roll" ) do
        if typeof( Value2Inner ) == "EnumItem" and Value2Inner.EnumType == Enum.KeyCode and not Controls.IsPadKey( Value2Inner ) and not table.find( Table5, Value2Inner ) then
            table.insert( Table5, Value2Inner )
        end
    end

    local Callback2 = Actions and function( Argument1, Argument2, Argument3 )
        if not Argument3 or not Controls.Is( "DriveBrake", Argument3 ) then
            return Enum.ContextActionResult.Sink
        end

        local FlagInner

        if Argument2 == Enum.UserInputState.Begin then
            FlagInner = true
        elseif Argument2 == Enum.UserInputState.Change then
            FlagInner = true
        else
            FlagInner = false
        end
        if FlagInner ~= Flag then
            Flag = FlagInner
            VehicleAction:FireServer( "Handbrake", FlagInner )
        end

        return Enum.ContextActionResult.Sink
    end or Sink
    local Table6

    if Actions then
        local WithInputs3 = WithInputs( Table5, "DriveBrake" )

        if WithInputs3 then
            Table6 = WithInputs3
        else
            Table6 = Table5
        end
    else
        Table6 = Table5
    end

    ContextActionService:BindActionAtPriority( "VehicleHandbrake", Callback2, false, Value2, table.unpack( Table6 ) )
end

Controls.BindsChanged:Connect( function()
    if Value1 then
        BindSeatActions( Value1.driver )
    end
end )

local function IsRepairKey( Argument1 )
    return Controls.Is( "VehicleRepair", Argument1 )
end

local function DrivesWith( Argument1 )
    local Value1
    local Table = { "MoveForward", "MoveBack", "MoveLeft", "MoveRight" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        if Controls.Is( Value, Argument1 ) then
            return true
        end
    end

    return false
end

local Table6 = { }
local Value10 = nil
local Value11 = nil
local Value12 = nil

local function BuildRepairPanel()
    if Value11 and Value11.Parent then
        return true
    end

    local Reparation
    Value10 = LocalPlayer.PlayerGui:FindFirstChild( "VehicleRepair" )

    if Value10 then
        Reparation = Value10:FindFirstChild( "Reparation" )
    else
        Reparation = Value10
    end

    local Bar

    if Reparation then
        Bar = Reparation:FindFirstChild( "Bar" )
    else
        Bar = Reparation
    end

    local Captured = if Bar then Bar:FindFirstChild( "Fill" ) else Bar
    local Captured2
    Value11 = Captured
    Captured2 = if Reparation then Reparation:FindFirstChild( "Value" ) else Reparation
    local Flag
    Value12 = Captured2
    Flag = Value11 ~= nil and true or false
    return Flag
end

local Value13 = nil
local Flag9 = false
local Value14 = nil
local RepairPrices = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "RepairPrices" ) )
local Number3 = 0

local function CostOf( Self )
    if LocalPlayer:WaitForChild( "PlayerGui" ):GetAttribute( "IsAdmin" ) == true then
        return 0
    end
    return RepairPrices.VehicleCost( Self:GetAttribute( "Health" ), Self:GetAttribute( "MaxHealth" ), Self.Name ) or 0
end

local function CanRepair()
    local Flag = if Value1 == nil then false else Value1.driver
    return Flag
end

local function NeedsRepair( Self )
    if Self:GetAttribute( "Destroyed" ) then
        return false
    end

    local Health = Self:GetAttribute( "Health" )
    local MaxHealth = Self:GetAttribute( "MaxHealth" )

    if Health and MaxHealth and Health < MaxHealth then
        return true
    end
    for Key, Value in Self:GetDescendants( ) do
        local BaseTransparency
        local IsA = Value:IsA( "BasePart" )

        if IsA then
            BaseTransparency = Value:GetAttribute( "BaseTransparency" )
        else
            BaseTransparency = IsA
        end
        if BaseTransparency ~= nil and BaseTransparency ~= false and Value.Transparency ~= BaseTransparency then
            return true
        end
        if Value:GetAttribute( "VehicleWheel" ) then
            if not Value:GetAttribute( "TireHits" ) then
                if not Value:GetAttribute( "Flat" ) then
                    continue
                end
            end

            return true
        end
    end

    return false
end

local function StopRepair()
    Value13 = nil
    Flag9 = false
    Value14 = nil

    if Value10 then
        Value10.Enabled = false
    end
end

UserInputService.InputBegan:Connect( function( Argument1 )
    local Is = Controls.Is( "VehicleRepair", Argument1 )

    if not Is and not Table6[ Argument1.KeyCode ] then
        return
    end
    if UserInputService:GetFocusedTextBox( ) then
        return
    end
    if Argument1.KeyCode == Enum.KeyCode.Left and DrivesWith( Argument1 ) then
        return
    end
    if Is and Value13 and Flag9 then
        ClientState.RepairPressAt = os.clock( )
        Value13 = nil
        Flag9 = false
        Value14 = nil

        if Value10 then
            Value10.Enabled = false
        end

        return
    end
    local Flag = if Value1 == nil then false else Value1.driver

    if not Flag then
        return
    end
    if not NeedsRepair( Value1.model ) then
        return
    end

    local OwnerId = Value1.model:GetAttribute( "OwnerId" )

    if OwnerId and OwnerId ~= LocalPlayer.UserId then
        if Success and Result then
            Result.Error( "Only the owner can repair this vehicle" )
        end

        return
    end
    Number3 = CostOf( Value1.model )

    if not ( Number3 > 0 ) or not ( ( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) < Number3 ) then
        local Flag2
        ClientState.RepairPressAt = os.clock( )
        VehicleAction:FireServer( "RepairStart" )
        Value13 = os.clock( )
        Flag2 = Is == true and true or false
        local Model = Value1.model
        Flag9 = Flag2
        Value14 = Model
        return
    end
    if Success and Result then
        Result.Error( ( "Not enough money to repair ($%d)" ):format( Number3 ) )
    end

    return
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    if Table6[ Argument1.KeyCode ] and not Flag9 then
        Value13 = nil
        Flag9 = false
        Value14 = nil

        if Value10 then
            Value10.Enabled = false
        end
    end
end )
RunService.Heartbeat:Connect( function()
    if not Value13 then
        return
    end

    local Flag = if Value1 == nil then false else Value1.driver

    if not Flag or Value1.model ~= Value14 then
        Value13 = nil
        Flag9 = false
        Value14 = nil

        if Value10 then
            Value10.Enabled = false
        end

        return
    end
    local Clock = ( os.clock( ) - Value13 ) / 4

    if Clock < 0.08 and not Flag9 then
        return
    end
    if not Value10 or not Value10.Enabled then
        if not BuildRepairPanel( ) then
            Value13 = nil
            Flag9 = false
            Value14 = nil

            if Value10 then
                Value10.Enabled = false
            end

            return
        end
        Value10.Enabled = true
    end

    Value11.Size = UDim2.fromScale( math.min( Clock, 1 ), 1 )

    if Value12 then
        local Text3
        local Text = math.floor( math.min( Clock, 1 ) * 100 ) .. "%"

        if Number3 > 0 then
            local Text2 = Text .. "  $" .. Number3

            if Text2 then
                Text3 = Text2
            else
                Text3 = Text
            end
        else
            Text3 = Text
        end

        Value12.Text = Text3
    end
    if Clock >= 1 then
        VehicleAction:FireServer( "Repair" )
        Value13 = nil
        Flag9 = false
        Value14 = nil

        if Value10 then
            Value10.Enabled = false
        end
    end

    return
end )
local Table7 = { Throttle = 0, Steer = 0, Handbrake = true, Parked = true }
local Table8 = {
    Throttle = 0,
    Steer = 0,
    Handbrake = true,
    Parked = true,
    Pushed = true
}
local Coasting = { }
ClientState.Coasting = Coasting
local Callback = nil

local function SimStep( Argument1 )
    local Success, Result = pcall( function()
        return RunService:BindToSimulation( Argument1, Enum.StepFrequency.Hz60 )
    end )

    if not Success or not Result then
        return RunService.PreSimulation:Connect( Argument1 )
    end
    return Result
end

local function Coast( Value, Argument2, Argument3, Argument4, Argument5 )
    if Coasting[ Value ] then
        Coasting[ Value ]:Disconnect( )
    end

    local Captured = if Argument4 then Argument4 else Table7
    local Clock = os.clock( )
    local Connect
    local Clock2 = Clock + ( Argument5 or Argument2.cfg.CoastTime + 0.5 )
    local SetOwned = VehicleSync.SetOwned
    SetOwned( Value, Argument2.root )

    local function CallbackInner( Argument1 )
        VehiclePhysics.step( Argument2, Argument1, Captured )
    end

    local Success, Result = pcall( function()
        return RunService:BindToSimulation( CallbackInner, Enum.StepFrequency.Hz60 )
    end )

    if not Success or not Result then
        Connect = RunService.PreSimulation:Connect( CallbackInner )
    else
        Connect = Result
    end

    local Connect2 = RunService.PreSimulation:Connect( function()
        local Root = Argument2.root

        if Root.Anchored or not Root.Parent or Argument3.Occupant or Value:GetAttribute( "Destroyed" ) or Clock2 < os.clock( ) or Value:GetAttribute( "Noyee" ) then
            Coasting[ Value ]:Disconnect( )
            Coasting[ Value ] = nil
            VehicleSync.SetOwned( Value, nil )
            VehiclePhysics.stop( Argument2 )
            Callback( )
        elseif Captured == Table8 and Value:GetAttribute( "PushOwner" ) ~= LocalPlayer.UserId then
            Coasting[ Value ]:Disconnect( )
            Coasting[ Value ] = nil
            VehicleSync.SetOwned( Value, nil )
            VehiclePhysics.stop( Argument2 )
            Callback( )
        end
    end )
    Coasting[ Value ] = {
        Disconnect = function()
            Connect:Disconnect( )
            Connect2:Disconnect( )
        end
    }
end

local function IsRocket( Self )
    local IsA2
    local IsA = Self:IsA( "Tool" )
    IsA2 = if IsA then WeaponData[ Self:GetAttribute( "Weapon" ) ] else IsA
    local Flag = if not IsA2 or not IsA2.Fire or IsA2.Fire.Mode ~= "Rocket" then false else true
    return Flag
end

local Table9 = { }

local function SetSeatedMassless( MasslessName, Argument2 )
    if Argument2 then
        local Entry2
        local Entry = Table9[ MasslessName ]

        if Entry then
            Entry2 = Entry
        else
            local Table = { }
            Table9[ MasslessName ] = Table
            Entry2 = Table
        end
        for Index, Value in ipairs( MasslessName:GetDescendants( ) ) do
            if Value:IsA( "BasePart" ) and Entry2[ Value ] == nil then
                Entry2[ Value ] = Value.Massless
                Value.Massless = true
            end
        end

        return
    end
    local Entry4
    local Entry3 = Table9[ MasslessName ]
    Table9[ MasslessName ] = nil
    Entry4 = if Entry3 then Entry3 else { }

    for Key, Value3 in pairs( Entry4 ) do
        if Key.Parent then
            Key.Massless = Value3
        end
    end

    return
end

Callback = function()
    local VehicleSeats
    local Table = { }

    if Value1 then
        local Driver = Value1.driver

        if Driver then
            VehicleSeats = Value1.model:FindFirstChild( "VehicleSeats" )
        else
            VehicleSeats = Driver
        end
    else
        VehicleSeats = Value1
    end

    local Children = VehicleSeats and VehicleSeats:GetChildren( ) or { }

    for Index, Value in ipairs( Children ) do
        local IsA2
        local IsA = Value:IsA( "BasePart" )
        IsA2 = if IsA then Value.Occupant else IsA

        if IsA2 and IsA2.Parent then
            Table[ IsA2.Parent ] = true
        end
    end
    for Value3 in pairs( Table9 ) do
        if Value3 ~= LocalPlayer.Character and not Table[ Value3 ] then
            local Entry2
            local Entry = Table9[ Value3 ]
            Table9[ Value3 ] = nil
            Entry2 = if Entry then Entry else { }

            for Key, Value5 in pairs( Entry2 ) do
                if Key.Parent then
                    Key.Massless = Value5
                end
            end
        end
    end
end

local function Leave()
    if not Value1 then
        return
    end

    local Character = LocalPlayer.Character

    if Character then
        local Entry2
        local Entry = Table9[ Character ]
        Table9[ Character ] = nil
        Entry2 = if Entry then Entry else { }

        for Key, Value in pairs( Entry2 ) do
            if Key.Parent then
                Key.Massless = Value
            end
        end
    end
    if Value3 then
        Value3:Disconnect( )
        Value3 = nil
    end
    if Value4 then
        Value4:Disconnect( )
        Value4 = nil
    end
    if Value1.toolConn then
        Value1.toolConn:Disconnect( )
    end

    local ImpactConns2
    local ImpactConns = Value1.impactConns
    ImpactConns2 = if ImpactConns then ImpactConns else { }

    for Index, Value3Inner in ipairs( ImpactConns2 ) do
        Value3Inner:Disconnect( )
    end
    if Value1.driver then
        Coast( Value1.model, Value1.state, Value1.seat )
    else
        local SetOwned = VehicleSync.SetOwned
        SetOwned( Value1.model, nil )
    end

    ContextActionService:UnbindAction( "VehicleExit" )
    ContextActionService:UnbindAction( "VehicleHorn" )
    Value13 = nil
    Flag9 = false
    Value14 = nil

    if Value10 then
        Value10.Enabled = false
    end

    ContextActionService:UnbindAction( "VehicleHandbrake" )
    ContextActionService:UnbindAction( "VehicleBlockJump" )
    Flag = false
    Flag2 = false
    Flag3 = false
    Flag4 = false
    Flag5 = false
    Flag6 = false
    Flag7 = false

    if Value1.state then
        Value1.state.wheelieOn = false
    end

    local Humanoid
    ClientState.Vehicle = nil
    local Character2 = LocalPlayer.Character

    if Character2 then
        Humanoid = Character2:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character2
    end
    if Character2 then
        Character2:FindFirstChild( "HumanoidRootPart" )
    end
    if Humanoid then
        local JumpButton
        Humanoid:SetStateEnabled( Enum.HumanoidStateType.Jumping, true )
        local TouchGui = LocalPlayer.PlayerGui:FindFirstChild( "TouchGui" )

        if TouchGui then
            JumpButton = TouchGui:FindFirstChild( "JumpButton", true )
        else
            JumpButton = TouchGui
        end
        if JumpButton then
            JumpButton.Visible = true
        end
        if Humanoid.Health > 0 and Humanoid.SeatPart == nil then
            if Humanoid.Sit or Humanoid:GetState( ) == Enum.HumanoidStateType.Seated then
                Humanoid.Sit = false
                Humanoid:ChangeState( Enum.HumanoidStateType.GettingUp )
            end
        end
    end

    Value1 = nil
    Number = os.clock( ) + 0.35
    UpdatePrompts( )
end

task.spawn( function()
    while true do
        task.wait( 0.1 )
        local Character = LocalPlayer.Character

        if Value1 and Character then
            if Character:GetAttribute( "Downed" ) or Character:GetAttribute( "CarriedBy" ) then
                pcall( OnExit, nil, Enum.UserInputState.Begin )

                if Value1 then
                    pcall( Leave )
                end
            end
        end
    end
end )

local function Enter( Model, SeatPart )
    local Entry2
    Leave( )
    local Entry = Table[ Model ]

    if Entry then
        Entry2 = Entry
    else
        local State = VehiclePhysics.newState( Model ) or false
        Table[ Model ] = State
        Entry2 = State
    end

    local Entry3 = Entry2 or nil

    if not Entry3 then
        return
    end

    local FlagInner = SeatPart:GetAttribute( "Role" ) == "Driver" and true or false
    Value1 = { model = Model, seat = SeatPart, driver = FlagInner, state = Entry3 }

    if FlagInner then
        local SetOwned = VehicleSync.SetOwned
        SetOwned( Model, Entry3.root )
    end

    local TwoWheels
    Number = 0
    UpdatePrompts( )
    local Vehicle = {
        Model = Model,
        Root = Entry3.root,
        Distance = Entry3.cfg.CameraDistance,
        Height = Entry3.cfg.CameraHeight,
        Driver = FlagInner
    }
    TwoWheels = Entry3.cfg.TwoWheels == true and true or false
    local Humanoid
    Vehicle.TwoWheels = TwoWheels
    ClientState.Vehicle = Vehicle
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if Character then
        Character:FindFirstChild( "HumanoidRootPart" )
    end
    if Character then
        SetSeatedMassless( Character, true )
    end
    if Humanoid then
        local JumpButton
        Humanoid:SetStateEnabled( Enum.HumanoidStateType.Jumping, false )
        local TouchGui = LocalPlayer.PlayerGui:FindFirstChild( "TouchGui" )

        if TouchGui then
            JumpButton = TouchGui:FindFirstChild( "JumpButton", true )
        else
            JumpButton = TouchGui
        end
        if JumpButton then
            JumpButton.Visible = false
        end

        local Flag2Inner = SeatPart:GetAttribute( "NoWeapons" ) == true and true or false

        local function Forbidden( Self )
            local IsA2
            local IsA = Self:IsA( "Tool" )
            IsA2 = if IsA then WeaponData[ Self:GetAttribute( "Weapon" ) ] else IsA
            local Flag = if not IsA2 or not IsA2.Fire or IsA2.Fire.Mode ~= "Rocket" then false else true

            if Flag then
                return true
            end

            local Captured

            if Flag2Inner then
                local IsA3 = Self:IsA( "Tool" )

                if IsA3 then
                    local Weapon2
                    local Weapon = Self:GetAttribute( "Weapon" )
                    Weapon2 = if Weapon then Weapon else Self:GetAttribute( "Melee" )

                    if Weapon2 == nil then
                        Captured = false
                    else
                        Captured = true
                    end
                else
                    Captured = IsA3
                end
            else
                Captured = Flag2Inner
            end

            return Captured
        end

        local Tool = Character:FindFirstChildOfClass( "Tool" )

        if Tool then
            local IsA2
            local IsA = Tool:IsA( "Tool" )
            IsA2 = if IsA then WeaponData[ Tool:GetAttribute( "Weapon" ) ] else IsA
            local Flag3Inner = if not IsA2 or not IsA2.Fire or IsA2.Fire.Mode ~= "Rocket" then false else true
            local Flag4Inner

            if Flag3Inner then
                Flag4Inner = true
            elseif Flag2Inner then
                local IsA3 = Tool:IsA( "Tool" )

                if IsA3 then
                    local Weapon2
                    local Weapon = Tool:GetAttribute( "Weapon" )
                    Weapon2 = if Weapon then Weapon else Tool:GetAttribute( "Melee" )

                    if Weapon2 == nil then
                        Flag4Inner = false
                    else
                        Flag4Inner = true
                    end
                else
                    Flag4Inner = IsA3
                end
            else
                Flag4Inner = Flag2Inner
            end
            if Flag4Inner then
                Humanoid:UnequipTools( )
            end
        end

        Value1.toolConn = Character.ChildAdded:Connect( function( Self )
            local IsA2
            local IsA = Self:IsA( "Tool" )
            IsA2 = if IsA then WeaponData[ Self:GetAttribute( "Weapon" ) ] else IsA
            local Flag = if not IsA2 or not IsA2.Fire or IsA2.Fire.Mode ~= "Rocket" then false else true
            local Flag2

            if Flag then
                Flag2 = true
            elseif Flag2Inner then
                local IsA3 = Self:IsA( "Tool" )

                if IsA3 then
                    local Weapon2
                    local Weapon = Self:GetAttribute( "Weapon" )
                    Weapon2 = if Weapon then Weapon else Self:GetAttribute( "Melee" )

                    if Weapon2 == nil then
                        Flag2 = false
                    else
                        Flag2 = true
                    end
                else
                    Flag2 = IsA3
                end
            else
                Flag2 = Flag2Inner
            end
            if Flag2 then
                task.defer( Humanoid.UnequipTools, Humanoid )
            end
        end )
    end

    BindSeatActions( FlagInner )

    if not FlagInner then
        return
    end

    local Left

    if Controls.IsGamepad then
        Left = false
    else
        local IsDown = Controls.IsDown( "MoveLeft" )

        if IsDown then
            Left = IsDown
        else
            Left = false
        end
    end

    local Right
    Table3.left = Left

    if Controls.IsGamepad then
        Right = false
    else
        local IsDown2 = Controls.IsDown( "MoveRight" )

        if IsDown2 then
            Right = IsDown2
        else
            Right = false
        end
    end

    Table3.right = Right
    local NumberInner = 0
    local Number2 = 0
    local Number3 = 0
    local TableInner = { Throttle = 0, Steer = 0, Handbrake = false }
    Value1.impactConns = { }
    local Number4 = 0

    local function OnImpact( Part )
        local Parent = Part.Parent

        if Parent == Model or os.clock( ) - Number4 < 0.4 then
            return
        end
        if Part.Name:sub( 1, 17 ) ~= "VehicleCollision_" then
            if Part.Name ~= "VehicleHitbox" or not Part.CanCollide then
                return
            end
        end

        local VehicleRoot

        if Parent then
            VehicleRoot = Parent:FindFirstChild( "VehicleRoot" )
        else
            VehicleRoot = Parent
        end
        if not VehicleRoot then
            return
        end

        local RemoteState
        local Root = Entry3.root

        if Parent:GetAttribute( "PushOwner" ) == LocalPlayer.UserId then
            RemoteState = false
        else
            RemoteState = VehicleSync.RemoteState( Parent )
        end

        local VehicleHitbox = Model:FindFirstChild( "VehicleHitbox" )
        local VehicleHitbox2 = Parent:FindFirstChild( "VehicleHitbox" )

        if RemoteState and VehicleHitbox and VehicleHitbox2 then
            local PrevVel2
            local Resolve = VehicleImpact.Resolve
            local PrevVel = Entry3.prevVel
            PrevVel2 = if PrevVel then PrevVel else Root.AssemblyLinearVelocity
            local Resolve2, Resolve22 = Resolve( Root, VehicleHitbox, PrevVel2, VehicleRoot, VehicleHitbox2, RemoteState, Entry3.cfg )

            if Resolve2 then
                Number4 = os.clock( )
                VehicleSync.Nudge( Parent, Resolve2, Resolve22 )
            end

            return
        end
        local Position = ( VehicleRoot.Position - Root.Position ) * Vector3.new( 1, 0, 1 )

        if Position.Magnitude < 0.1 then
            return
        end

        local Unit = Position.Unit
        local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
        local Dot = ( Entry3.prevVel or AssemblyLinearVelocity ):Dot( Unit ) - AssemblyLinearVelocity:Dot( Unit )

        if Dot < Entry3.cfg.ImpactMinSpeed then
            return
        end
        Number4 = os.clock( )
        local Dot2 = Dot * Entry3.cfg.ImpactSlowdown
        Root.AssemblyLinearVelocity = AssemblyLinearVelocity - Unit * math.min( Dot2, ( math.max( AssemblyLinearVelocity:Dot( Unit ), 0 ) ) )
        return
    end

    for Index, Value in ipairs( Model:GetChildren( ) ) do
        if Value.Name:sub( 1, 17 ) == "VehicleCollision_" then
            local ImpactConns = Value1.impactConns
            table.insert( ImpactConns, Value.Touched:Connect( OnImpact ) )
        end
    end

    local Connect

    local function Callback( Argument1 )
        if SeatPart.Parent and Entry3.root.Parent then
            VehiclePhysics.step( Entry3, Argument1, TableInner )
        end
    end

    local Success, Result = pcall( function()
        return RunService:BindToSimulation( Callback, Enum.StepFrequency.Hz60 )
    end )

    if not Success or not Result then
        Connect = RunService.PreSimulation:Connect( Callback )
    else
        Connect = Result
    end

    Value4 = Connect
    Value3 = RunService.PreSimulation:Connect( function( Argument1 )
        if not SeatPart.Parent or not Entry3.root.Parent then
            return
        end

        Entry3.prevVel = Entry3.root.AssemblyLinearVelocity
        local Throttle, Steer = DriverInput( SeatPart )
        local TestThrottle = LocalPlayer:GetAttribute( "TestThrottle" )

        if TestThrottle then
            Throttle = TestThrottle
        end

        local TestSteer = LocalPlayer:GetAttribute( "TestSteer" )

        if TestSteer then
            Steer = TestSteer
        end
        if LocalPlayer:GetAttribute( "TestHandbrake" ) ~= nil then
            Flag = LocalPlayer:GetAttribute( "TestHandbrake" )
        end
        if UserInputService:GetLastInputType( ) == Enum.UserInputType.Keyboard then
            local Abs = math.abs( Throttle )
            local Max = math.max( Abs, ( math.abs( Steer ) ) )

            if Max > 0.05 then
                Throttle = Throttle / Max
                Steer = Steer / Max
            end
        end

        local Flag6Inner
        local Cfg = Entry3.cfg
        local AssemblyLinearVelocity = Entry3.root.AssemblyLinearVelocity
        local UpVector = Entry3.root.CFrame.UpVector
        local Magnitude = ( AssemblyLinearVelocity - UpVector * AssemblyLinearVelocity:Dot( UpVector ) ).Magnitude
        Flag6Inner = if BurnPedals( ) or LocalPlayer:GetAttribute( "TestBurn" ) == true then not Flag else false
        local Number, Position
        Number = 0
        Position = Vector3.new( 0, 0, 0 )

        for Index, Value in ipairs( Entry3.wheels ) do
            if Value.front and Value.origin then
                Number = Number + 1
                Position = Position + Value.origin
            end
        end

        local Magnitude2

        if Number > 0 then
            local VelocityAtPosition = Entry3.root:GetVelocityAtPosition( Position / Number )
            Magnitude2 = ( VelocityAtPosition - UpVector * VelocityAtPosition:Dot( UpVector ) ).Magnitude
        else
            Magnitude2 = Magnitude
        end

        local FlagInner

        if Flag6Inner then
            local BurnHoldSpeed

            if Flag4 then
                BurnHoldSpeed = Cfg.BurnHoldSpeed
            else
                BurnHoldSpeed = Cfg.BurnEntrySpeed
            end
            if Magnitude2 <= BurnHoldSpeed then
                FlagInner = true
            else
                FlagInner = false
            end
        else
            FlagInner = Flag6Inner
        end

        Flag4 = FlagInner

        if Flag4 then
            Throttle = 0
        elseif Flag6Inner then
            if AssemblyLinearVelocity:Dot( Entry3.root.CFrame.LookVector ) >= 0 then
                Throttle = -1
            else
                Throttle = 1
            end
        end

        local Captured
        local State = BurnoutFX.State( Entry3 )
        local Step = BurnoutFX.Step

        if Flag4 then
            Captured = Flag4
        elseif Throttle > 0.2 then
            Captured = true
        else
            Captured = false
        end

        Step( State, Cfg, Argument1, Flag4, Captured, Magnitude )

        if Entry3.gearbox then
            local Gearbox = Entry3.gearbox
            local Gearbox2 = Entry3.gearbox
            local LaunchSlip = State.slip
            local LaunchHold = State.hold
            Gearbox.launchSlip = LaunchSlip
            Gearbox2.launchHold = LaunchHold
        end

        local Flag2Inner

        if State.slip > 0 then
            Flag2Inner = true
        elseif State.hold > 0 then
            Flag2Inner = true
        else
            Flag2Inner = false
        end
        if Flag2Inner ~= Flag6 then
            Flag6 = Flag2Inner
            VehicleAction:FireServer( "BurnLaunch", Flag2Inner )
        end
        if Flag4 ~= Flag5 then
            Flag5 = Flag4
            VehicleAction:FireServer( "Burn", Flag4 )
        end

        local LaunchSlip2 = State.slip
        TableInner.Burn = Flag4
        TableInner.LaunchSlip = LaunchSlip2

        if Cfg.TwoWheels then
            local Flag3Inner
            local WheelieHeld2 = WheelieHeld( )

            if WheelieHeld2 then
                if Throttle > 0.3 then
                    local NotCaptured = not Flag

                    if NotCaptured then
                        local NotCaptured2 = not Flag4

                        if NotCaptured2 then
                            if AssemblyLinearVelocity:Dot( Entry3.root.CFrame.LookVector ) > -1 then
                                Flag3Inner = true
                            else
                                Flag3Inner = false
                            end
                        else
                            Flag3Inner = NotCaptured2
                        end
                    else
                        Flag3Inner = NotCaptured
                    end
                else
                    Flag3Inner = false
                end
            else
                Flag3Inner = WheelieHeld2
            end
            if Flag3Inner ~= Flag7 then
                Flag7 = Flag3Inner
                VehicleAction:FireServer( "Wheelie", Flag3Inner )
            end

            Entry3.wheelieOn = Flag7
            Entry3.wheelieBrake = Flag2
            Steer = Steer * ( 1 - ( 1 - Cfg.WheelieSteer ) * math.clamp( ( Entry3.wheelie or 0 ) / Cfg.WheelieAngle, 0, 1 ) )
        end

        local Captured2
        TableInner.Throttle = Throttle
        TableInner.Steer = Steer
        TableInner.Handbrake = Flag
        local Dot = Entry3.root.AssemblyLinearVelocity:Dot( Entry3.root.CFrame.LookVector )

        if Flag4 then
            Captured2 = Flag4
        elseif not ( Throttle < -0.05 ) or not ( Dot > 1.5 ) then
            if Throttle > 0.05 then
                if Dot < -1.5 then
                    Captured2 = true
                else
                    Captured2 = false
                end
            else
                Captured2 = false
            end
        else
            Captured2 = true
        end

        local Flag4Inner

        if Dot < -1.5 then
            Flag4Inner = true
        elseif Throttle < -0.05 then
            if Dot <= 1.5 then
                Flag4Inner = true
            else
                Flag4Inner = false
            end
        else
            Flag4Inner = false
        end
        if Captured2 ~= Flag2 then
            Flag2 = Captured2
            VehicleAction:FireServer( "Brake", Captured2 )
        end
        if Flag4Inner ~= Flag3 then
            Flag3 = Flag4Inner
            VehicleAction:FireServer( "Reverse", Flag4Inner )
        end

        local DriveAccel2

        if Entry3.gearbox then
            local DriveAccel = Entry3.gearbox:DriveAccel( )

            if DriveAccel then
                DriveAccel2 = DriveAccel
            else
                DriveAccel2 = nil
            end
        else
            DriveAccel2 = nil
        end

        TableInner.DriveAccel = DriveAccel2

        if not Entry3.force or not Entry3.torque then
            if Entry3.engineAudio then
                Entry3.engineAudio:Destroy( )
            end

            local Entry2
            Table[ Model ] = nil
            local Entry = Table[ Model ]

            if Entry then
                Entry2 = Entry
            else
                local State2 = VehiclePhysics.newState( Model ) or false
                Table[ Model ] = State2
                Entry2 = State2
            end

            local Entry4
            local Entry3Inner = Entry2 or nil
            Entry4 = if Entry3Inner then Entry3Inner else Entry3
            Entry3 = Entry4
            Value1.state = Entry3
        end
        if LocalPlayer:GetAttribute( "DbgDrive" ) then
            LocalPlayer:SetAttribute( "DbgDriveOut", string.format( "siège %.2f/%.2f -> gaz %.2f volant %.2f fam %s accel %s", SeatPart.ThrottleFloat, SeatPart.SteerFloat, TableInner.Throttle, TableInner.Steer, tostring( TableInner.Handbrake ), ( tostring( TableInner.DriveAccel ) ) ) )
        end

        Number3 = Number3 - Argument1

        if Number3 <= 0 then
            local Children
            Number3 = 0.5
            local VehicleSeats = Model:FindFirstChild( "VehicleSeats" )
            local TableInner2 = { }
            Children = VehicleSeats and VehicleSeats:GetChildren( ) or { }

            for Index2, Value4 in ipairs( Children ) do
                local IsA2
                local IsA = Value4:IsA( "BasePart" )
                IsA2 = if IsA then Value4.Occupant else IsA
                local IsA3 = if IsA2 then IsA2.Parent else IsA2

                if IsA3 and IsA3 ~= LocalPlayer.Character then
                    TableInner2[ IsA3 ] = true
                    SetSeatedMassless( IsA3, true )
                end
            end
            for Value6 in pairs( Table9 ) do
                if Value6 ~= LocalPlayer.Character and not TableInner2[ Value6 ] then
                    local Entry6
                    local Entry5 = Table9[ Value6 ]
                    Table9[ Value6 ] = nil
                    Entry6 = if Entry5 then Entry5 else { }

                    for Key, Value8 in pairs( Entry6 ) do
                        if Key.Parent then
                            Key.Massless = Value8
                        end
                    end
                end
            end
        end
        if not ( math.abs( Throttle ) > 0.5 ) or Flag or not ( Entry3.root.AssemblyLinearVelocity.Magnitude < 1.5 ) then
            NumberInner = 0
        else
            NumberInner = NumberInner + Argument1
        end
        if NumberInner > 1 and os.clock( ) - Number2 > 3 then
            local Number2Inner
            Number2 = os.clock( )
            NumberInner = 0
            Number2Inner = 0

            for Index3, Value10 in ipairs( Entry3.wheels ) do
                local Number3Inner = not Value10.grounded and 0 or 1
                Number2Inner = Number2Inner + Number3Inner
            end

            local Flag5Inner
            local Table2 = { }
            local VehicleHitbox = Model:FindFirstChild( "VehicleHitbox" )

            if VehicleHitbox then
                local OverlapParams2 = OverlapParams.new( )
                OverlapParams2.FilterType = Enum.RaycastFilterType.Exclude
                OverlapParams2.FilterDescendantsInstances = { Model, LocalPlayer.Character }
                OverlapParams2.RespectCanCollide = true
                Flag5Inner = false

                for Index4, Value12 in ipairs( workspace:GetPartsInPart( VehicleHitbox, OverlapParams2 ) ) do
                    if Value12.Name ~= "Baseplate" and #Table2 < 6 then
                        local Text
                        local FullName = Value12:GetFullName( )
                        Text = not Value12.Anchored and "" or "(ancré)"
                        table.insert( Table2, FullName .. Text )
                    end
                    if Value12.Name:sub( 1, 17 ) == "VehicleCollision_" or Value12.Name == "VehicleHitbox" then
                        Flag5Inner = true
                    end
                end
            else
                Flag5Inner = false
            end
            if not Flag5Inner then
                local Force2
                local Name = Model.Name
                local Text2 = tostring( Entry3.root.Anchored )
                local Count = #Entry3.wheels
                local Y = Entry3.root.CFrame.UpVector.Y
                local Force = Entry3.force
                Force2 = if Force then Entry3.force.Force else Force
                local Concat2
                local Text3 = tostring( Force2 )

                if #Table2 > 0 then
                    local Concat = table.concat( Table2, ", " )

                    if Concat then
                        Concat2 = Concat
                    else
                        Concat2 = "rien"
                    end
                else
                    Concat2 = "rien"
                end

                warn( string.format( "[Vehicles] %s bloquée : gaz=%.2f racine ancrée=%s roues au sol=%d/%d haut=%.2f force=%s | touche : %s", Name, Throttle, Text2, Number2Inner, Count, Y, Text3, Concat2 ) )
            end

            VehicleAction:FireServer( "Unstick", Flag5Inner )
        end
    end )
end

local function ExitBeside( Model, Humanoid, BesideName, Argument4, Argument5 )
    local VehicleRoot = BesideName:FindFirstChild( "VehicleRoot" )
    local Parent = Model:FindFirstChild( "HumanoidRootPart" )

    if not VehicleRoot or not Parent then
        return
    end

    local Position

    if Argument5 then
        local IsOutside = ExitSpot.IsOutside

        if IsOutside( BesideName, Parent.Position, 1 ) then
            Position = Parent.Position
        else
            local Find = ExitSpot.Find( BesideName, Argument4, Model, Humanoid, Parent )
            Model:PivotTo( ExitSpot.Facing( BesideName, Find ) * Parent.CFrame:Inverse( ) * Model:GetPivot( ) )
            Position = Find
        end
    else
        local Find = ExitSpot.Find( BesideName, Argument4, Model, Humanoid, Parent )
        Model:PivotTo( ExitSpot.Facing( BesideName, Find ) * Parent.CFrame:Inverse( ) * Model:GetPivot( ) )
        Position = Find
    end

    local Entry2
    local Entry = Table[ BesideName ]

    if Entry then
        Entry2 = Entry
    else
        local State = VehiclePhysics.newState( BesideName ) or false
        Table[ BesideName ] = State
        Entry2 = State
    end

    local Entry4
    local Entry3 = Entry2 or nil
    Entry4 = if Entry3 then Entry3.cfg else Entry3
    local AssemblyLinearVelocity, Launch2

    if Entry4 then
        AssemblyLinearVelocity, Launch2 = ExitSpot.Launch( BesideName, Entry4, Position )
    else
        Launch2 = nil
        AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
    end
    if Model:GetAttribute( "Downed" ) == true then
        for Key, Value in Model:GetDescendants( ) do
            if Value:IsA( "BasePart" ) then
                local AssemblyLinearVelocity2 = ( not Launch2 or not AssemblyLinearVelocity ) and Vector3.new( 0, 0, 0 ) or AssemblyLinearVelocity
                Value.AssemblyLinearVelocity = AssemblyLinearVelocity2
                Value.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
            end
        end

        return
    end
    if Launch2 then
        local AssemblyLinearVelocity3 = VehicleRoot.AssemblyLinearVelocity * Vector3.new( 1, 0, 1 ) * Entry4.EjectCarry
        local VehicleHitbox = BesideName:FindFirstChild( "VehicleHitbox" ) or VehicleRoot

        local function EjectVelocity( Argument1 )
            local EjectVelocity = ExitSpot.EjectVelocity
            local EjectVelocity2, EjectVelocity22, EjectVelocity3 = EjectVelocity( VehicleRoot, VehicleHitbox, Entry4, Parent.Position, Launch2, AssemblyLinearVelocity3, Argument1 )
            Launch2 = EjectVelocity22
            return EjectVelocity2, EjectVelocity3
        end

        Parent.AssemblyLinearVelocity = AssemblyLinearVelocity
        Parent.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
        local StateEnabled = Humanoid:GetStateEnabled( Enum.HumanoidStateType.FallingDown )
        local StateEnabled2 = Humanoid:GetStateEnabled( Enum.HumanoidStateType.Ragdoll )
        Humanoid:SetStateEnabled( Enum.HumanoidStateType.FallingDown, false )
        Humanoid:SetStateEnabled( Enum.HumanoidStateType.Ragdoll, false )
        local Attachment0 = Instance.new( "Attachment" )
        Attachment0.Name = "EjectAttachment"
        Attachment0.Parent = Parent
        local LinearVelocity = Instance.new( "LinearVelocity" )
        LinearVelocity.Name = "Eject"
        LinearVelocity.Attachment0 = Attachment0
        LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
        LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
        LinearVelocity.PrimaryTangentAxis = Vector3.new( 1, 0, 0 )
        LinearVelocity.SecondaryTangentAxis = Vector3.new( 0, 0, 1 )
        LinearVelocity.MaxForce = Parent.AssemblyMass * 1000
        LinearVelocity.PlaneVelocity = Vector2.new( AssemblyLinearVelocity.X, AssemblyLinearVelocity.Z )
        LinearVelocity.Parent = Parent
        local Clock = os.clock( )
        local Connect = nil
        Connect = RunService.Heartbeat:Connect( function()
            local Parent3
            local ClockInner = os.clock( ) - Clock
            local Max = math.max( 1 - ClockInner / Entry4.EjectSlide, 0 )
            local ParentInner = VehicleRoot.Parent

            if ParentInner then
                local Parent2 = LinearVelocity.Parent

                if Parent2 then
                    if Humanoid.Health > 0 then
                        local NotSeatPart = not Humanoid.SeatPart

                        if NotSeatPart then
                            if ClockInner < Entry4.EjectSlide + Entry4.EjectHold then
                                Parent3 = true
                            else
                                Parent3 = false
                            end
                        else
                            Parent3 = NotSeatPart
                        end
                    else
                        Parent3 = false
                    end
                else
                    Parent3 = Parent2
                end
            else
                Parent3 = ParentInner
            end

            local EjectVelocity32

            if Parent3 then
                local EjectVelocity = ExitSpot.EjectVelocity
                local EjectVelocity2, EjectVelocity22, EjectVelocity3 = EjectVelocity( VehicleRoot, VehicleHitbox, Entry4, Parent.Position, Launch2, AssemblyLinearVelocity3, Max )
                Launch2 = EjectVelocity22
                AssemblyLinearVelocity = EjectVelocity2

                if not ( Humanoid.MoveDirection.Magnitude > 0.1 ) or not ( ( Entry4.EjectControlAfter or 0.1 ) <= ClockInner ) or not ( EjectVelocity3 < 1 ) then
                    EjectVelocity32 = EjectVelocity3
                else
                    Parent3 = false
                    EjectVelocity32 = EjectVelocity3
                end
            else
                EjectVelocity32 = nil
            end
            if Parent3 then
                if Max ~= 0 or not ( EjectVelocity32 < 1 ) then
                    LinearVelocity.PlaneVelocity = Vector2.new( AssemblyLinearVelocity.X, AssemblyLinearVelocity.Z )
                    return
                end
            end

            Connect:Disconnect( )
            LinearVelocity:Destroy( )
            Attachment0:Destroy( )
            Humanoid:SetStateEnabled( Enum.HumanoidStateType.FallingDown, StateEnabled )
            Humanoid:SetStateEnabled( Enum.HumanoidStateType.Ragdoll, StateEnabled2 )
        end )
        return
    end
    Parent.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
    Parent.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
    return
end

local function Watch( Object )
    Leave( )
    local Humanoid = Object:WaitForChild( "Humanoid" )
    Humanoid:GetPropertyChangedSignal( "SeatPart" ):Connect( function()
        local Model
        local SeatPart = Humanoid.SeatPart

        if SeatPart then
            Model = SeatPart:FindFirstAncestorWhichIsA( "Model" )
        else
            Model = SeatPart
        end
        if Model and CollectionService:HasTag( Model, "Vehicle" ) then
            Enter( Model, SeatPart )
            return
        end

        Leave( )

        if Value1 and Humanoid.Health > 0 and Value1.model.Parent then
            ExitBeside( Object, Humanoid, Value1.model, Value1.seat, not Value1.driver )
        end
    end )
    Humanoid.Died:Connect( function()
        Leave( )
        UpdatePrompts( )
    end )
    UpdatePrompts( )
end

LocalPlayer.CharacterAdded:Connect( Watch )

if LocalPlayer.Character then
    task.spawn( Watch, LocalPlayer.Character )
end

local SoundService = game:GetService( "SoundService" )
local Table10 = { }

local function EngineGroup( Argument1, Cfg )
    local Text = not Argument1 and "Others" or "Own"

    if Table10[ Text ] then
        return Table10[ Text ]
    end

    local EngineReverb2
    local EngineReverb = Cfg.EngineReverb
    EngineReverb2 = if EngineReverb then Cfg.EngineReverb[ Text ] else EngineReverb

    if EngineReverb2 then
        local Parent = Instance.new( "SoundGroup" )
        Parent.Name = "EngineReverb" .. Text
        Parent.Volume = 0.5
        local ReverbSoundEffect = Instance.new( "ReverbSoundEffect" )
        ReverbSoundEffect.DecayTime = EngineReverb2.Decay or 1.5
        ReverbSoundEffect.Density = 1
        ReverbSoundEffect.Diffusion = 1
        ReverbSoundEffect.WetLevel = EngineReverb2.Wet or -12
        ReverbSoundEffect.DryLevel = 0
        ReverbSoundEffect.Parent = Parent
        Parent.Parent = SoundService
        Table10[ Text ] = Parent
        return Parent
    end
    return nil
end

local function StartRev( Argument1, Argument2, PrevEngineSpeed, Amount2 )
    local StartRev = Argument2.StartRev

    if not StartRev or not Argument1.revStart then
        return nil
    end

    local Clock = os.clock( ) - Argument1.revStart

    if PrevEngineSpeed > 3 or Amount2 > 0.1 or ( StartRev.Rise or 0.22 ) + ( StartRev.Fall or 0.7 ) < Clock then
        Argument1.revStart = nil
        return nil
    end
    if Clock < 0 then
        return nil
    end

    local Rise = StartRev.Rise or 0.22

    if Clock < Rise then
        local Clock2 = Clock / Rise
        return ( StartRev.Peak or 0.6 ) * ( 1 - ( 1 - Clock2 ) ^ 2 ), 1, Clock2
    end
    local Clock3 = ( Clock - Rise ) / ( StartRev.Fall or 0.7 )
    return ( StartRev.Peak or 0.6 ) * ( 1 - Clock3 ) ^ 1.4, ( StartRev.FallLoad or 0 ) * ( 1 - Clock3 ) ^ 1.5, ( 1 - Clock3 ) ^ 1.5
end

local function UpdateEngine( Object, Argument2, Amount )
    local DriverSeat3, Engine3, Value4, Value5, Value6, EngineAudio2, Cfg2
    local Cfg = Argument2.cfg

    if not Cfg.EngineSound and not Cfg.Engine then
        return
    end
    if Cfg.Engine and not Argument2.engineAudio then
        Argument2.engineAudio = EngineAudio.new( Argument2.root, Cfg.Engine )
        Argument2.rpm = 0
        Argument2.load = 0
    end

    local Engine = Argument2.engine

    if Engine or Argument2.engineAudio then
        Engine3 = Engine
    else
        local Engine2 = Instance.new( "Sound" )
        Engine2.Name = "EngineSound"
        Engine2.SoundId = Cfg.EngineSound
        Engine2.Looped = true
        Engine2.Volume = 0
        Engine2.RollOffMode = Enum.RollOffMode.InverseTapered
        Engine2.RollOffMinDistance = 12
        Engine2.RollOffMaxDistance = 170
        Engine2.Parent = Argument2.root
        Argument2.engine = Engine2
        Argument2.rpm = 0
        Argument2.load = 0
        Engine3 = Engine2
    end

    local DriverSeat = Argument2.driverSeat

    if DriverSeat then
        DriverSeat3 = DriverSeat
    else
        local DriverSeat2
        local VehicleSeats = Object:FindFirstChild( "VehicleSeats" )

        if VehicleSeats then
            DriverSeat2 = VehicleSeats:FindFirstChild( "Driver" )
        else
            DriverSeat2 = VehicleSeats
        end

        Argument2.driverSeat = DriverSeat2
        DriverSeat3 = DriverSeat2
    end

    local FlagInner

    if DriverSeat3 == nil then
        FlagInner = false
    elseif DriverSeat3.Occupant == nil then
        FlagInner = false
    else
        local NotDestroyed = not Object:GetAttribute( "Destroyed" )

        if NotDestroyed then
            FlagInner = not Object:GetAttribute( "OnLift" )
        else
            FlagInner = NotDestroyed
        end
    end

    local ReverbOwn
    local EngineAudioInner = Argument2.engineAudio

    if Value1 == nil then
        ReverbOwn = false
    elseif Value1.model == Object then
        ReverbOwn = true
    else
        ReverbOwn = false
    end
    if Argument2.reverbOwn ~= ReverbOwn then
        Argument2.reverbOwn = ReverbOwn
        local SoundGroup = EngineGroup( ReverbOwn, Cfg )

        if EngineAudioInner then
            local Value1Inner
            local Loops = EngineAudioInner.loops
            Value1Inner = nil

            for Key, Value in Loops, nil, nil do
                Value.sound.SoundGroup = SoundGroup
            end
            if EngineAudioInner.startup then
                EngineAudioInner.startup.SoundGroup = SoundGroup
            end
            if EngineAudioInner.inner then
                local Value2
                local Loops2 = EngineAudioInner.inner.loops
                Value2 = nil

                for Key2, Value3 in Loops2, nil, nil do
                    Value3.sound.SoundGroup = SoundGroup
                end
                if EngineAudioInner.inner.startup then
                    EngineAudioInner.inner.startup.SoundGroup = SoundGroup
                end
            end
        end
        if Engine3 then
            Engine3.SoundGroup = SoundGroup
        end
    end
    if EngineAudioInner then
        local InteriorWant

        if ReverbOwn then
            InteriorWant = 1
        elseif Cfg.Engine.Interior then
            local OthersLevel = Cfg.Engine.Interior.OthersLevel

            if OthersLevel then
                InteriorWant = OthersLevel
            else
                InteriorWant = 0
            end
        else
            InteriorWant = 0
        end

        local Occ
        EngineAudioInner.interiorWant = InteriorWant
        Occ = if DriverSeat3 then DriverSeat3.Occupant else DriverSeat3

        if Argument2.occSeen == nil then
            Argument2.occSeen = true
            Argument2.occ = Occ
            Argument2.occAt = -math.huge
        elseif Occ ~= Argument2.occ then
            local OccAt = os.clock( )
            Argument2.occ = Occ
            Argument2.occAt = OccAt
        end
        if not FlagInner or Argument2.engineOn then
            if not FlagInner and Argument2.engineOn then
                Argument2.engineOn = false
                EngineAudioInner:Stop( )
            end
        else
            local Flag2
            Argument2.engineOn = true
            Flag2 = os.clock( ) - Argument2.occAt <= 1 and true or false
            local TimeLength2
            EngineAudioInner:Start( not Flag2 )

            if not EngineAudioInner.startup or not ( EngineAudioInner.startup.TimeLength > 0 ) then
                TimeLength2 = 0
            else
                local TimeLength = EngineAudioInner.startup.TimeLength - 0.15

                if TimeLength then
                    TimeLength2 = TimeLength
                else
                    TimeLength2 = 0
                end
            end

            local RevStart

            if Flag2 then
                local Delay2
                local Clock = os.clock( ) + math.max( Cfg.Engine.StartDelay or 0.45, TimeLength2 )

                if Cfg.StartRev then
                    local Delay = Cfg.StartRev.Delay

                    if Delay then
                        Delay2 = Delay
                    else
                        Delay2 = 0.15
                    end
                else
                    Delay2 = 0.15
                end

                local Clock2 = Clock + Delay2

                if Clock2 then
                    RevStart = Clock2
                else
                    RevStart = nil
                end
            else
                RevStart = nil
            end

            Argument2.revStart = RevStart
        end
        if not FlagInner then
            EngineAudioInner:Update( Argument2.rpm, 0, Amount )
            return
        end
        Value4 = Argument2
        Value5 = Amount
        Value6 = Object
        EngineAudio2 = EngineAudioInner
        Cfg2 = Cfg
    elseif not FlagInner then
        Engine3.Volume = math.max( Engine3.Volume - Amount * 2, 0 )

        if Engine3.Volume <= 0 and Engine3.IsPlaying then
            Engine3:Stop( )
        end

        return
    elseif Engine3.IsPlaying then
        Value4 = Argument2
        Value5 = Amount
        Value6 = Object
        EngineAudio2 = EngineAudioInner
        Cfg2 = Cfg
    else
        local Delay4
        Engine3:Play( )
        local Clock3 = os.clock( )

        if Cfg.StartRev then
            local Delay3 = Cfg.StartRev.Delay

            if Delay3 then
                Delay4 = Delay3
            else
                Delay4 = 0.15
            end
        else
            Delay4 = 0.15
        end

        Argument2.revStart = Clock3 + Delay4 + 0.3
        Value4 = Argument2
        Value5 = Amount
        Value6 = Object
        EngineAudio2 = EngineAudioInner
        Cfg2 = Cfg
    end

    local Abs3
    local Dot = Value4.root.AssemblyLinearVelocity:Dot( Value4.root.CFrame.LookVector )
    local PrevEngineSpeed = math.abs( Dot )

    if Value4.prevEngineSpeed then
        local Abs = ( PrevEngineSpeed - Value4.prevEngineSpeed ) / math.max( Value5, 0.004166666666666667 )

        if Abs then
            Abs3 = Abs
        else
            Abs3 = 0
        end
    else
        Abs3 = 0
    end

    local TestThrottle
    Value4.prevEngineSpeed = PrevEngineSpeed

    if not Value1 or not Value1.driver or Value1.model ~= Value6 then
        TestThrottle = DriverSeat3.ThrottleFloat
    else
        TestThrottle = DriverInput( DriverSeat3 )
    end
    if Value1 and Value1.driver and Value1.model == Value6 and LocalPlayer:GetAttribute( "TestThrottle" ) then
        TestThrottle = LocalPlayer:GetAttribute( "TestThrottle" )
    end

    local Burn
    local NotDestroyed2 = not Value6:GetAttribute( "Destroyed" )

    if NotDestroyed2 then
        if not Value1 or not Value1.driver or Value1.model ~= Value6 then
            if Value6:GetAttribute( "Burn" ) == true then
                Burn = true
            else
                Burn = false
            end
        else
            Burn = Flag4
        end
    else
        Burn = NotDestroyed2
    end
    if Burn then
        TestThrottle = 1
    end

    local NotNotDestroyed2
    local NotNotDestroyed = not Burn

    if NotNotDestroyed then
        if not ( Dot > 1.5 ) or not ( TestThrottle < -0.05 ) then
            if Dot < -1.5 then
                if TestThrottle > 0.05 then
                    NotNotDestroyed2 = true
                else
                    NotNotDestroyed2 = false
                end
            else
                NotNotDestroyed2 = false
            end
        else
            NotNotDestroyed2 = true
        end
    else
        NotNotDestroyed2 = NotNotDestroyed
    end

    local Abs2

    if NotNotDestroyed2 then
        Abs2 = 0.1
    else
        Abs2 = math.abs( TestThrottle )
    end
    if not Value1 or not Value1.driver or Value1.model ~= Value6 then
        local Number = not ( Abs3 > 3 ) and 0 or 1
        Abs2 = math.max( Abs2, Number )
    end
    if not EngineAudio2 then
        local Clamp2
        Value4.load = Value4.load + ( Abs2 - Value4.load ) * math.clamp( Value5 * 6, 0, 1 )

        if Dot < -1 then
            Clamp2 = math.clamp( PrevEngineSpeed / Cfg2.ReverseSpeed, 0, 1 ) * 0.6 + 0.2
        else
            if not Value4.gears then
                Value4.gears = { }

                for Index, Value10 in ipairs( Cfg2.GearFractions ) do
                    local Gears = Value4.gears
                    Gears[ Index ] = Value10 * Cfg2.TopSpeed
                end
            end

            local Number3, Number5
            Number3 = 0

            for Index2, Value12 in ipairs( Value4.gears ) do
                if PrevEngineSpeed <= Value12 or Index2 == #Value4.gears then
                    local Number4 = Index2 ~= 1 and 0.45 or 0.2
                    Number5 = Number4 + math.clamp( ( PrevEngineSpeed - Number3 ) / ( Value12 - Number3 ), 0, 1 ) * ( 1 - Number4 )
                    break
                end
                Number3 = Value12

                Number5 = nil
            end

            local Max = math.max( Number5, Value4.load * 0.55 )

            if Burn then
                Clamp2 = math.max( Max, 0.95 )
            else
                Clamp2 = Max
            end
        end

        local Value13, Value14, Value15 = StartRev( Value4, Cfg2, PrevEngineSpeed, Abs2 )

        if Value13 then
            Clamp2 = math.max( Clamp2, Value13 )
            Value4.load = math.max( Value4.load, Value14 )
        end

        local Boost4

        if Cfg2.StartRev then
            local Boost3 = Cfg2.StartRev.Boost

            if Boost3 then
                Boost4 = Boost3
            else
                Boost4 = 0
            end
        else
            Boost4 = 0
        end

        Value4.revBoost = 1 + Boost4 * ( Value15 or 0 )
        Value4.rpm = Value4.rpm + ( Clamp2 - Value4.rpm ) * math.clamp( Value5 * 10, 0, 1 )
        Engine3.PlaybackSpeed = Cfg2.EnginePitchIdle + Value4.rpm * ( Cfg2.EnginePitchMax - Cfg2.EnginePitchIdle )
        Engine3.Volume = Cfg2.EngineVolume * ( 0.4 + 0.6 * Value4.load ) * ( Value4.revBoost or 1 )
        return
    end
    local UnityDemo = Cfg2.Engine.UnityDemo

    if UnityDemo then
        local NotNotNotDestroyed2
        local Engine4 = Cfg2.Engine
        local NotNotNotDestroyed = not NotNotDestroyed2

        if NotNotNotDestroyed then
            if Abs2 > 0.5 then
                NotNotNotDestroyed2 = true
            else
                NotNotNotDestroyed2 = false
            end
        else
            NotNotNotDestroyed2 = NotNotNotDestroyed
        end

        local DemoRpm2
        local DemoRpm = Value4.demoRpm
        DemoRpm2 = if DemoRpm then DemoRpm else Engine4.IdleRPM
        local Number2
        Value4.demoRpm = DemoRpm2
        Value4.demoPedal = Value4.demoPedal or 0
        local DemoPedal = Value4.demoPedal
        Number2 = not NotNotNotDestroyed2 and 0 or 1
        Value4.demoPedal = DemoPedal + ( Number2 - Value4.demoPedal ) * math.clamp( Value5 * ( UnityDemo.PedalSpeed or 5.5 ), 0, 1 )

        if NotNotNotDestroyed2 then
            if Value4.demoRpm <= Engine4.RedlineRPM then
                Value4.demoRpm = Value4.demoRpm + ( UnityDemo.Accel or 2000 ) * Value5
            end
        else
            local DemoRpm3 = Value4.demoRpm

            if Engine4.IdleRPM < DemoRpm3 then
                local IdleRPM = Engine4.IdleRPM
                Value4.demoRpm = math.max( IdleRPM, Value4.demoRpm - ( UnityDemo.Decel or 2200 ) * Value5 )
            end
        end

        Value4.rpm = math.clamp( ( Value4.demoRpm - Engine4.IdleRPM ) / ( Engine4.RedlineRPM - Engine4.IdleRPM ), 0, 1 )
        Value4.load = Value4.demoPedal
        local Rpm = Value4.rpm
        EngineAudio2:Update( Rpm, Value4.load, Value5 )

        if Value1 and Value1.model == Value6 then
            ClientState.EngineDebug = {
                Gear = 0,
                Rpm = Value4.demoRpm,
                Load = Value4.load,
                Speed = PrevEngineSpeed,
                Car = Value6.Name,
                Burn = Burn
            }
        end

        return
    end
    local Gearbox2
    local Gearbox = Value4.gearbox
    Gearbox2 = if Gearbox then Gearbox else EngineAudio.Gearbox( Cfg2 )
    local Captured
    Value4.gearbox = Gearbox2

    if Value1 then
        local Driver = Value1.driver

        if Driver then
            if Value1.model == Value6 then
                Captured = true
            else
                Captured = false
            end
        else
            Captured = Driver
        end
    else
        Captured = Value1
    end

    local Handbrake
    local Gearbox3 = Value4.gearbox
    Handbrake = Captured and Flag or false
    local Clamp
    Gearbox3.handbrake = Handbrake
    Value4.gearbox.burn = Burn
    local Gearbox4 = Value4.gearbox

    if NotNotDestroyed2 then
        Clamp = 0
    else
        Clamp = math.clamp( Abs2, 0, 1 )
    end

    local NotNotDestroyed3 = if Captured then NotNotDestroyed2 else nil
    local Step, Load = Gearbox4:Step( Value5, Dot, Clamp, nil, NotNotDestroyed3 )

    if Captured and LocalPlayer:GetAttribute( "TestThrottle" ) ~= nil then
        local Text = tostring( Value4.gearbox.handbrake )
        local Text2 = tostring( NotNotDestroyed2 )
        local Format = string.format( "hb=%s brk=%s thr=%.2f decel=%.0f fwd=%.0f", Text, Text2, Abs2, Value4.gearbox.decel or -1, Dot )
        local Gear = Value4.gearbox.gear
        local _wheelRpm = Value4.gearbox:_wheelRpm( math.abs( Dot ), Value4.gearbox.gear )
        LocalPlayer:SetAttribute( "DbgBox", Format .. string.format( " g=%d roues=%.0f dt=%.2f ls=%.2f", Gear, _wheelRpm, Value5, os.clock( ) - ( Value4.gearbox.lastShift or 0 ) ) )
    end

    local Rpm2
    Value7, Load, Value8 = StartRev( Value4, Cfg2, PrevEngineSpeed, Abs2 )

    if Value7 then
        Rpm2 = math.max( Step, Value7 )
    else
        Rpm2 = Step
    end

    local Boost2

    if Cfg2.StartRev then
        local Boost = Cfg2.StartRev.Boost

        if Boost then
            Boost2 = Boost
        else
            Boost2 = 0
        end
    else
        Boost2 = 0
    end

    EngineAudio2.boost = 1 + Boost2 * ( Value8 or 0 )
    Value4.rpm = Rpm2
    Value4.load = Load
    EngineAudio2:Update( Rpm2, Load, Value5 )

    if Value1 and Value1.model == Value6 then
        local Engine5 = Cfg2.Engine
        ClientState.EngineDebug = {
            Gear = Value4.gearbox.gear,
            Rpm = Engine5.IdleRPM + Rpm2 * ( Engine5.RedlineRPM - Engine5.IdleRPM ),
            Load = Load,
            Speed = PrevEngineSpeed,
            Car = Value6.Name,
            Burn = Burn
        }
    end

    return
end

local function PlayAt( Parent, SoundId, TimePosition, Amount, Amount2 )
    if SoundId then
        local RollOffMinDistance
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = SoundId
        Sound.PlaybackSpeed = Amount or 1
        Sound.Volume = Amount2 or 0.5
        RollOffMinDistance = ( not Amount2 or not ( Amount2 > 1 ) ) and 10 or 14
        local RollOffMaxDistance
        Sound.RollOffMinDistance = RollOffMinDistance
        RollOffMaxDistance = ( not Amount2 or not ( Amount2 > 1 ) ) and 120 or 150
        Sound.RollOffMaxDistance = RollOffMaxDistance
        Sound.Parent = Parent

        if TimePosition then
            Sound.TimePosition = TimePosition
        end

        Sound:Play( )
    end
end

local function EmitTemplate( WorldPosition, Name, SoundId, TimePosition, Amount )
    local FoundChild
    local ClientFX = VehicleSystem:FindFirstChild( "ClientFX" )

    if ClientFX then
        FoundChild = ClientFX:FindFirstChild( Name )
    else
        FoundChild = ClientFX
    end

    local Parent = Instance.new( "Attachment" )
    Parent.Parent = workspace.Terrain
    Parent.WorldPosition = WorldPosition

    if SoundId then
        local RollOffMinDistance
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = SoundId
        Sound.PlaybackSpeed = 1
        Sound.Volume = Amount or 0.5
        RollOffMinDistance = ( not Amount or not ( Amount > 1 ) ) and 10 or 14
        local RollOffMaxDistance
        Sound.RollOffMinDistance = RollOffMinDistance
        RollOffMaxDistance = ( not Amount or not ( Amount > 1 ) ) and 120 or 150
        Sound.RollOffMaxDistance = RollOffMaxDistance
        Sound.Parent = Parent

        if TimePosition then
            Sound.TimePosition = TimePosition
        end

        Sound:Play( )
    end

    local Children = FoundChild and FoundChild:GetChildren( ) or { }
    local Number = 0

    for Index, Value in ipairs( Children ) do
        if Value:IsA( "ParticleEmitter" ) then
            local Clone = Value:Clone( )
            Clone.Enabled = false
            Clone.Parent = Parent
            local EmitCount = Value:GetAttribute( "EmitCount" ) or 10
            local EmitDelay = Value:GetAttribute( "EmitDelay" ) or 0

            if EmitDelay > 0 then
                task.delay( EmitDelay, Clone.Emit, Clone, EmitCount )
            else
                Clone:Emit( EmitCount )
            end

            Number = math.max( Number, EmitDelay + Clone.Lifetime.Max )
        end
    end

    Debris:AddItem( Parent, math.max( Number, 3 ) + 1 )
end

local Table11 = { 0.9, 0.96, 1, 1.05, 1.11 }

local function GlassBreak( Self, Argument2, SoundId )
    local Unit3
    local CFrame2 = Self.CFrame
    local Size = Self.Size
    local Table = {
        CFrame2.RightVector * Size.X,
        CFrame2.UpVector * Size.Y,
        CFrame2.LookVector * Size.Z
    }
    table.sort( Table, function( Argument1, Argument2 )
        local Flag
        local Magnitude = Argument1.Magnitude
        Flag = Argument2.Magnitude < Magnitude and true or false
        return Flag
    end )

    if typeof( Argument2 ) ~= "Vector3" or Argument2.Magnitude < 0.001 then
        local Unit2
        local Model = Self:FindFirstAncestorWhichIsA( "Model" )

        if Table[ 3 ].Magnitude > 1e-06 then
            local Unit = Table[ 3 ].Unit

            if Unit then
                Unit2 = Unit
            else
                Unit2 = CFrame2.LookVector
            end
        else
            Unit2 = CFrame2.LookVector
        end
        if not Model or not ( Unit2:Dot( Model:GetPivot( ).Position - CFrame2.Position ) < 0 ) then
            Unit3 = Unit2
        else
            Unit3 = -Unit2
        end
    else
        Unit3 = Argument2
    end

    local Item2
    local Unit4 = Unit3.Unit
    local Item = Table[ 1 ] - Unit4 * Table[ 1 ]:Dot( Unit4 )
    Item2 = if Item.Magnitude < 0.001 then Table[ 2 ] - Unit4 * Table[ 2 ]:Dot( Unit4 ) else Item
    local Unit5 = Item2.Unit
    local Cross = Unit5:Cross( Unit4 )

    local function Extent( Self )
        return math.abs( ( Self:Dot( CFrame2.RightVector ) ) ) * Size.X + math.abs( ( Self:Dot( CFrame2.UpVector ) ) ) * Size.Y + math.abs( ( Self:Dot( CFrame2.LookVector ) ) ) * Size.Z
    end

    local Parent = Instance.new( "Attachment" )
    Parent.Parent = workspace.Terrain
    Parent.WorldPosition = CFrame2.Position
    local Entry = Table11[ math.random( #Table11 ) ] * ( 1 + ( math.random( ) - 0.5 ) * 0.04 )

    if SoundId then
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = SoundId
        Sound.PlaybackSpeed = Entry or 1
        Sound.Volume = 0.5
        Sound.RollOffMinDistance = 10
        Sound.RollOffMaxDistance = 120
        Sound.Parent = Parent
        Sound:Play( )
    end

    local GlassBreak
    Debris:AddItem( Parent, 4 )
    local ClientFX = VehicleSystem:FindFirstChild( "ClientFX" )

    if ClientFX then
        GlassBreak = ClientFX:FindFirstChild( "GlassBreak" )
    else
        GlassBreak = ClientFX
    end
    if not GlassBreak then
        return
    end

    local Number
    local Clone = GlassBreak:Clone( )
    Clone.Anchored = true
    Clone.CanCollide = false
    Clone.CanQuery = false
    Clone.CanTouch = false
    Clone.Transparency = 1
    local Max = math.max( Extent( Unit5 ), 0.2 )
    local Clamp = math.clamp( Extent( Unit4 ), 0.05, 0.4 )
    Clone.Size = Vector3.new( Max, Clamp, ( math.max( Extent( Cross ), 0.2 ) ) )
    Clone.CFrame = CFrame.fromMatrix( CFrame2.Position, Unit5, Unit4, Cross )
    Clone.Parent = workspace
    Number = 0

    for Index, Value in ipairs( Clone:GetDescendants( ) ) do
        if Value:IsA( "ParticleEmitter" ) then
            Value.Enabled = false
            Value:Emit( Value:GetAttribute( "EmitCount" ) or 30 )
            Number = math.max( Number, Value.Lifetime.Max )
        end
    end

    Debris:AddItem( Clone, Number + 1 )
end

local function CarStateOf( Self )
    local Model = Self:FindFirstAncestorWhichIsA( "Model" )

    while Model do
        if CollectionService:HasTag( Model, "Vehicle" ) then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end

    local Model2

    if Model then
        local Entry2
        local Entry = Table[ Model ]

        if Entry then
            Entry2 = Entry
        else
            local State = VehiclePhysics.newState( Model ) or false
            Table[ Model ] = State
            Entry2 = State
        end

        Model2 = Entry2 or nil
    else
        Model2 = Model
    end

    return Model2, Model
end

local Class = setmetatable( { }, { __mode = "k" } )
function Effects.OnGlass( Self, Argument2 )
    if typeof( Self ) ~= "Instance" or not Self:IsA( "BasePart" ) or Self.Transparency >= 1 then
        return
    end
    if Class[ Self ] and os.clock( ) - Class[ Self ] < 2 then
        return
    end

    local Value1, Value2 = CarStateOf( Self )

    if not Value1 or Value2:GetAttribute( "Destroyed" ) then
        return
    end
    Class[ Self ] = os.clock( )
    Self.LocalTransparencyModifier = 1
    task.delay( 2, function()
        Self.LocalTransparencyModifier = 0
    end )
    GlassBreak( Self, Argument2, Value1.cfg.GlassBreakSound )
    return
end

local function WheelOf( Argument1 )
    local Model = Argument1:FindFirstAncestorWhichIsA( "Model" )

    while Model do
        if Model:GetAttribute( "VehicleWheel" ) then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end

    return Model
end

local Class2 = setmetatable( { }, { __mode = "k" } )
function Effects.OnImpact( Object, WorldPosition, Argument3 )
    if Argument3 or typeof( Object ) ~= "Instance" or not Object:IsA( "BasePart" ) or typeof( WorldPosition ) ~= "Vector3" then
        return
    end

    local Model
    local WheelOf2 = WheelOf( Object )

    if WheelOf2 then
        Model = WheelOf2:FindFirstAncestorWhichIsA( "Model" )
    else
        Model = WheelOf2
    end
    while Model do
        if CollectionService:HasTag( Model, "Vehicle" ) then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end

    local Model2

    if Model then
        local Entry2
        local Entry = Table[ Model ]

        if Entry then
            Entry2 = Entry
        else
            local State = VehiclePhysics.newState( Model ) or false
            Table[ Model ] = State
            Entry2 = State
        end

        Model2 = Entry2 or nil
    else
        Model2 = Model
    end
    if not Model2 or WheelOf2:GetAttribute( "Flat" ) or Model:GetAttribute( "Destroyed" ) or Model:GetAttribute( "TireProof" ) then
        return
    end

    local Cfg = Model2.cfg
    local Match = Object.Name:match( "^[^%.]+" )

    if Match ~= Cfg.TirePart and Match ~= Cfg.RimPart then
        return
    end
    if ( WheelOf2:GetAttribute( "TireHits" ) or 0 ) + 1 < Cfg.TireHits then
        return
    end
    if not Class2[ WheelOf2 ] or not ( os.clock( ) - Class2[ WheelOf2 ] < 2 ) then
        Class2[ WheelOf2 ] = os.clock( )
        EmitTemplate( WorldPosition, "TireBurst", Cfg.TireBurstSound, Cfg.TireBurstStart, Cfg.TireBurstVolume )
        return
    end
    return
end
VehicleFX.OnClientEvent:Connect( function( Name, Self, WorldPosition, Argument4 )
    if Name == "Explosion" then
        if typeof( WorldPosition ) == "Vector3" and ( WorldPosition - CurrentCamera.CFrame.Position ).Magnitude < 1200 then
            EmitTemplate( WorldPosition, "Explosion" )
        end

        return
    end
    if typeof( Self ) ~= "Instance" or not Self:IsA( "BasePart" ) then
        return
    end

    local Model = Self:FindFirstAncestorWhichIsA( "Model" )

    while Model do
        if CollectionService:HasTag( Model, "Vehicle" ) then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end

    local Model2

    if Model then
        local Entry2
        local Entry = Table[ Model ]

        if Entry then
            Entry2 = Entry
        else
            local State = VehiclePhysics.newState( Model ) or false
            Table[ Model ] = State
            Entry2 = State
        end

        Model2 = Entry2 or nil
    else
        Model2 = Model
    end
    if not Model2 or ( Self.Position - CurrentCamera.CFrame.Position ).Magnitude > 400 then
        return
    end
    if Name ~= "Glass" then
        if Name == "Tire" then
            local WheelOf2 = WheelOf( Self )

            if WheelOf2 and Class2[ WheelOf2 ] and os.clock( ) - Class2[ WheelOf2 ] < 2 then
                Class2[ WheelOf2 ] = nil
                return
            end

            local Position = typeof( WorldPosition ) == "Vector3" and WorldPosition or Self.Position
            EmitTemplate( Position, "TireBurst", Model2.cfg.TireBurstSound, Model2.cfg.TireBurstStart, Model2.cfg.TireBurstVolume )
        end

        return
    end
    if not Class[ Self ] or not ( os.clock( ) - Class[ Self ] < 2 ) then
        GlassBreak( Self, Argument4, Model2.cfg.GlassBreakSound )
        return
    end
    return
end )
local Table12 = { { 0, -80 }, { 0.03, -32 }, { 0.1, -11.7 }, { 0.4, -3 }, { 1, 3 } }
local Table13 = { { 0, -12.5 }, { 0.097, 0 }, { 1, 3 } }
local Table14 = { { 0, -12 }, { 30, -3 }, { 250, 2 } }
local Table15 = { { 0, -5 }, { 120, 0 } }

local function Piecewise( List, Argument2 )
    if Argument2 <= List[ 1 ][ 1 ] then
        return List[ 1 ][ 2 ]
    end

    local Count = #List - 1
    local I = 1

    for I = 1, Count do
        local Entry = List[ I ]
        local Entry2 = List[ I + 1 ]

        if Argument2 <= Entry2[ 1 ] then
            return Entry[ 2 ] + ( Entry2[ 2 ] - Entry[ 2 ] ) * ( Argument2 - Entry[ 1 ] ) / ( Entry2[ 1 ] - Entry[ 1 ] )
        end
    end

    return List[ #List ][ 2 ]
end

local function DbGain( Amount )
    if Amount <= -79 then
        return 0
    end
    return 10 ^ ( Amount / 20 )
end

local function StopTireSound( Argument1 )
    if Argument1.tire then
        local Value1
        local Sounds = Argument1.tire.sounds
        Value1 = nil

        for Key, Value in Sounds, nil, nil do
            Value:Stop( )
            Value.Volume = 0
        end

        Argument1.tire.power = 0
    end
end

local function UpdateTireSound( Argument1, Argument2, Argument3, Slide, Destroyed )
    local Cfg = Argument2.cfg
    local TireSkid = Cfg.TireSkid

    if not TireSkid then
        return
    end

    local Tire3
    local Tire = Argument2.tire

    if Tire then
        Tire3 = Tire
    else
        local Value1Inner
        local Tire2 = { power = 0, sounds = { } }
        local Sounds = TireSkid.Sounds
        Value1Inner = nil

        for Key, Value in Sounds, nil, nil do
            local Sound = Instance.new( "Sound" )
            Sound.Name = "TireSkid" .. Key
            Sound.SoundId = "rbxassetid://" .. Value
            Sound.Looped = true
            Sound.Volume = 0
            Sound.RollOffMode = Enum.RollOffMode.InverseTapered
            local RollOffMinDistance = TireSkid.RollMin or 10
            local RollOffMaxDistance = TireSkid.RollMax or 160
            Sound.RollOffMinDistance = RollOffMinDistance
            Sound.RollOffMaxDistance = RollOffMaxDistance
            Sound.Parent = Argument2.root
            Tire2.sounds[ Key ] = Sound
        end

        Argument2.tire = Tire2
        Tire3 = Tire2
    end

    local Number
    local AssemblyLinearVelocity = Argument2.root.AssemblyLinearVelocity
    local CFrame = Argument2.root.CFrame
    local X = AssemblyLinearVelocity.X
    local Magnitude = Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude
    local PrevFwd = AssemblyLinearVelocity:Dot( CFrame.LookVector )
    local Abs = math.abs( ( AssemblyLinearVelocity:Dot( CFrame.RightVector ) ) )
    Number = 0

    for Index, Value3 in ipairs( Argument2.wheels ) do
        local Number8 = not Value3.grounded and 0 or 1
        Number = Number + Number8
    end

    local Max

    if not Slide or Destroyed or not ( Number >= 2 ) or not ( Magnitude > 3 ) then
        Max = 0
    else
        local Clamp = math.clamp( ( Abs - ( TireSkid.LatStart or 4 ) ) / ( ( TireSkid.LatFull or 18 ) - ( TireSkid.LatStart or 4 ) ), 0, 1 )
        Max = math.max( Clamp, math.clamp( Magnitude / 40, 0, 1 ) * 0.35 )
    end

    local Rise2
    Tire3.prevFwd = PrevFwd

    if Tire3.power < Max then
        local Rise = TireSkid.Rise

        if Rise then
            Rise2 = Rise
        else
            Rise2 = 2.5
        end
    else
        Rise2 = TireSkid.Fall or 1.5
    end

    local Power = Tire3.power
    local Number2 = Max - Tire3.power
    local Amount = -Rise2 * Argument3
    Tire3.power = Power + math.clamp( Number2, Amount, Rise2 * Argument3 )
    local Power2 = Tire3.power

    if Power2 <= 0.001 then
        local Value4
        local Sounds2 = Tire3.sounds
        Value4 = nil

        for Key2, Value5 in Sounds2, nil, nil do
            if Value5.IsPlaying then
                Value5:Stop( )
                Value5.Volume = 0
            end
        end

        return
    end
    local Own

    if Value1 == nil then
        Own = false
    elseif Value1.model == Argument1 then
        Own = true
    else
        Own = false
    end
    if Tire3.own ~= Own then
        local Value6
        Tire3.own = Own
        local SoundGroup = EngineGroup( Own, Cfg )
        local Sounds3 = Tire3.sounds
        Value6 = nil

        for Key3, Value7 in Sounds3, nil, nil do
            Value7.SoundGroup = SoundGroup
        end
    end

    local Number3
    local Magnitude2 = Magnitude * 1.94
    local Total = Piecewise( Table12, Power2 ) + Piecewise( Table15, Magnitude2 )
    Number3 = if Total <= -79 then 0 else 10 ^ ( Total / 20 )
    local Value8
    local Number4 = Number3 * ( TireSkid.Volume or 0.7 )
    local Total2 = 2 ^ ( ( Piecewise( Table13, Power2 ) + Piecewise( Table14, Magnitude2 ) ) / 12 )
    local Sounds4 = Tire3.sounds
    Value8 = nil

    for Key4, Value9 in Sounds4, nil, nil do
        local Clamp2

        if Key4 == 1 then
            Clamp2 = 1
        else
            Clamp2 = math.clamp( ( Power2 - 0.26 ) / 0.14, 0, 1 )
        end

        local Number6
        local Number5 = Number4 * Clamp2
        Number6 = if Key4 == 1 then 1 else TireSkid.SecondLevel or 0.8
        local Volume = Number5 * Number6

        if Volume > 0.002 then
            if not Value9.IsPlaying then
                Value9.TimePosition = math.random( ) * 2
                Value9:Play( )
            end

            local Number7
            Value9.Volume = Volume
            Number7 = Key4 ~= 1 and 1.03 or 1
            Value9.PlaybackSpeed = math.clamp( Total2 * Number7, 0.3, 2 )
        elseif Value9.IsPlaying then
            Value9:Stop( )
            Value9.Volume = 0
        end
    end

    return
end

local function UpdateSmokeRate( Object, Argument2 )
    if not Argument2.smoke then
        local EngineFX = Object:FindFirstChild( "EngineFX" )

        if not EngineFX then
            return
        end

        Argument2.smoke = { }

        for Index, Value in ipairs( EngineFX:GetChildren( ) ) do
            if Value:IsA( "ParticleEmitter" ) then
                local Base
                local Smoke = Argument2.smoke
                local Table = { emitter = Value }
                local BaseRate = Value:GetAttribute( "BaseRate" )
                Base = if BaseRate then BaseRate else Value.Rate
                Table.base = Base
                table.insert( Smoke, Table )
            end
        end
    end

    local Magnitude = nil

    for Index2, Value3 in ipairs( Argument2.smoke ) do
        if Value3.emitter.Enabled then
            local Magnitude2 = if Magnitude then Magnitude else Argument2.root.AssemblyLinearVelocity.Magnitude
            local Base2 = Value3.base + Magnitude2 * Argument2.cfg.SmokeRatePerSpeed
            local Rate = math.min( Base2, Argument2.cfg.SmokeMaxRate )

            if math.abs( Rate - Value3.emitter.Rate ) >= 1 then
                Value3.emitter.Rate = Rate
                Magnitude = Magnitude2
            else
                Magnitude = Magnitude2
            end
        end
    end
end

local function RimSparks( Argument1, Argument2 )
    if not Argument2.sparks then
        local RimSparks
        local ClientFX = VehicleSystem:FindFirstChild( "ClientFX" )

        if ClientFX then
            RimSparks = ClientFX:FindFirstChild( "RimSparks" )
        else
            RimSparks = ClientFX
        end
        if not RimSparks then
            return nil
        end

        local Parent = Instance.new( "Attachment" )
        Parent.Name = "RimSparks"
        local Table = { }

        for Index, Value in ipairs( RimSparks:GetChildren( ) ) do
            if Value:IsA( "ParticleEmitter" ) then
                local Clone = Value:Clone( )
                Clone.Enabled = false
                Clone.Parent = Parent
                table.insert( Table, { emitter = Clone, base = Value.Rate } )
            end
        end

        local Sound2
        local RimScrape = Argument1.cfg.RimScrape

        if not RimScrape or not Argument1.cfg.RimScrapeSound then
            Sound2 = nil
        else
            local Sound = Instance.new( "Sound" )
            Sound.Name = "RimScrape"
            Sound.SoundId = Argument1.cfg.RimScrapeSound
            Sound.Looped = true
            Sound.Volume = 0
            Sound.RollOffMode = Enum.RollOffMode.InverseTapered
            local RollOffMinDistance = RimScrape.RollMin
            local RollOffMaxDistance = RimScrape.RollMax
            Sound.RollOffMinDistance = RollOffMinDistance
            Sound.RollOffMaxDistance = RollOffMaxDistance
            Sound.Parent = Parent
            Sound2 = Sound
        end

        Parent.Parent = Argument1.root
        Argument2.sparks = {
            att = Parent,
            emitters = Table,
            on = false,
            sound = Sound2,
            level = 0,
            gain = 0,
            pitch = 1,
            detune = 0.96 + 0.08 * math.random( )
        }
    end

    return Argument2.sparks
end

local function UpdateSparks( Argument1, Argument2, Amount, SoundGroup )
    if not Argument2 and not Argument1.sparksOn then
        return
    end

    local SparksOn, RimScraping
    local Cfg = Argument1.cfg
    local RimScrape = Cfg.RimScrape
    local Position = CurrentCamera.CFrame.Position
    SparksOn = false
    RimScraping = 0

    for Index, Value in ipairs( Argument1.wheels ) do
        local Dot

        if not Argument2 or not Value.flat or not Value.grounded or not Value.contact then
            Dot = 0
        else
            Dot = Argument1.root:GetVelocityAtPosition( Value.contact ):Dot( Argument1.root.CFrame.LookVector )
        end

        local Enabled
        local Abs = math.abs( Dot )
        Enabled = Cfg.RimSparkSpeed < Abs and true or false
        local Sparks2
        local Sparks = Value.sparks

        if Sparks then
            Sparks2 = Sparks
        elseif Enabled then
            Sparks2 = RimSparks( Argument1, Value )
        else
            Sparks2 = Enabled
        end
        if Sparks2 then
            if Enabled then
                local Number
                local Center = Value.center + Vector3.new( 0, Cfg.TravelUp - Value.d - Value.rim, 0 )
                local Att = Sparks2.att
                Number = not ( Dot > 0 ) and -0.8 or 0.8
                Att.CFrame = CFrame.fromMatrix( Center, Vector3.new( 1, 0, 0 ), ( Vector3.new( 0, 0.6, Number ) ) )
                local Clamp = math.clamp( math.abs( Dot ) / 30, 0.3, 1.5 )

                for Index2, Value3 in ipairs( Sparks2.emitters ) do
                    local Emitter = Value3.emitter
                    Emitter.Rate = Value3.base * Clamp
                end
            end
            if Sparks2.on ~= Enabled then
                for Index3, Value5 in ipairs( Sparks2.emitters ) do
                    Value5.emitter.Enabled = Enabled
                end

                Sparks2.on = Enabled
            end

            local Sound = Sparks2.sound

            if Sound then
                local Number2

                if Enabled then
                    RimScraping = RimScraping + 1

                    if ( Sparks2.att.WorldPosition - Position ).Magnitude < RimScrape.RollMax then
                        local Clamp2 = math.clamp( ( math.abs( Dot ) - Cfg.RimSparkSpeed ) / ( RimScrape.FullSpeed - Cfg.RimSparkSpeed ), 0, 1 )
                        Sparks2.gain = RimScrape.SlowLevel + ( 1 - RimScrape.SlowLevel ) * Clamp2 ^ 0.6
                        Sparks2.pitch = ( RimScrape.PitchSlow + ( RimScrape.PitchFast - RimScrape.PitchSlow ) * Clamp2 ) * Sparks2.detune
                        Number2 = 1
                    else
                        Number2 = 0
                    end
                else
                    Number2 = 0
                end
                if Number2 > 0 or Sparks2.level > 0 then
                    local Rise = Sparks2.level < Number2 and RimScrape.Rise or RimScrape.Fall
                    local Rise2 = Rise * ( Amount or 0.016666666666666666 )
                    local Level = Sparks2.level
                    local Number3 = Number2 - Sparks2.level
                    Sparks2.level = Level + math.clamp( Number3, -Rise2, Rise2 )

                    if Sparks2.level > 0.005 then
                        if SoundGroup and Sound.SoundGroup ~= SoundGroup then
                            Sound.SoundGroup = SoundGroup
                        end

                        Sound.Volume = Sparks2.level * Sparks2.gain * RimScrape.Volume / math.max( Argument1.rimScraping or 1, 1 ) ^ RimScrape.Shared
                        Sound.PlaybackSpeed = Sparks2.pitch

                        if not Sound.IsPlaying then
                            Sound.TimePosition = math.random( ) * math.max( Sound.TimeLength - 0.2, 0 )
                            Sound:Play( )
                        end
                    else
                        Sparks2.level = 0
                        Sound:Stop( )
                        Sound.Volume = 0
                    end
                end
            end
        end

        local Flag

        if SparksOn then
            Flag = SparksOn
        elseif Enabled then
            Flag = Enabled
        elseif not Sparks2 or not ( Sparks2.level > 0 ) then
            Flag = false
        else
            Flag = true
        end

        SparksOn = Flag
    end

    Argument1.sparksOn = SparksOn
    Argument1.rimScraping = RimScraping
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
local Table16 = {
    Vector3.new( -1, -1, -1 ),
    Vector3.new( -1, -1, 1 ),
    Vector3.new( -1, 1, -1 ),
    Vector3.new( -1, 1, 1 ),
    Vector3.new( 1, -1, -1 ),
    Vector3.new( 1, -1, 1 ),
    Vector3.new( 1, 1, -1 ),
    Vector3.new( 1, 1, 1 )
}
local Create = table.create( 8 )

local function KeepWreckAboveGround( Object, Argument2 )
    local VehicleHitbox = Object:FindFirstChild( "VehicleHitbox" )

    if not VehicleHitbox then
        return
    end

    local Number, Number2
    RaycastParams2.CollisionGroup = VehicleHitbox.CollisionGroup
    RaycastParams2.FilterDescendantsInstances = { Object }
    local CFrame = VehicleHitbox.CFrame
    local Size = VehicleHitbox.Size / 2
    Number = -math.huge
    Number2 = math.huge

    for Index, Value in ipairs( Table16 ) do
        local PointToWorldSpace = CFrame:PointToWorldSpace( Value * Size )
        Create[ Index ] = PointToWorldSpace
        Number = math.max( Number, PointToWorldSpace.Y )
        Number2 = math.min( Number2, PointToWorldSpace.Y )
    end

    local Max4
    local Max = math.max( Number, Argument2.wreckGround or Number )
    local Max2 = Max + 0.5
    local Number3 = ( Number + Number2 ) / 2
    local Position = CFrame.Position
    local X = Position.X
    local Raycast = workspace:Raycast( Vector3.new( X, Max2, Position.Z ), Vector3.new( 0, Number2 - 50 - Max2, 0 ), RaycastParams2 )

    if Raycast then
        local Max3
        local Y = Raycast.Position.Y
        Max3 = if Number < Max then Max2 else Number

        if Y < Max3 then
            Argument2.wreckGround = Raycast.Position.Y
            Max4 = math.max( Number3, Raycast.Position.Y + 1 )
        else
            Max4 = Number3
        end
    else
        Max4 = Number3
    end

    local Number4 = 0

    for Index2, Value3 in ipairs( Create ) do
        if Value3.Y < Max4 then
            local X2 = Value3.X
            local Raycast2 = workspace:Raycast( Vector3.new( X2, Max2, Value3.Z ), Vector3.new( 0, Value3.Y - Max2, 0 ), RaycastParams2 )

            if Raycast2 and Raycast2.Position.Y < Max4 then
                Number4 = math.max( Number4, Raycast2.Position.Y - Value3.Y )
            end
        end
    end
    if Number4 > 0.01 then
        local Root = Argument2.root
        Root.CFrame = Root.CFrame + Vector3.new( 0, Number4, 0 )
    end
end

local SmoothPlastic = Enum.Material.SmoothPlastic
local Table17 = {
    Brake = {
        Color = Color3.fromRGB( 255, 30, 20 ),
        Brightness = 8,
        Range = 18,
        Angle = 120,
        Down = 0.35
    },
    Reverse = {
        Color = Color3.fromRGB( 255, 248, 235 ),
        Brightness = 5,
        Range = 22,
        Angle = 100,
        Down = 0.35
    }
}
local Table18 = { Brightness = 2, Range = 80, Angle = 70, Down = 0.08, Tint = 0.6 }

local function ExtentsIn( Argument1, Argument2 )
    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge
    local Size = Argument2.Size / 2

    for Index, Value in ipairs( Table16 ) do
        local PointToObjectSpace = Argument1.CFrame:PointToObjectSpace( Argument2.CFrame:PointToWorldSpace( Value * Size ) )
        Result = Result:Min( PointToObjectSpace )
        Result2 = Result2:Max( PointToObjectSpace )
    end

    return Result, Result2
end

local function RearSpot( Argument1, List, SpotName )
    if #List == 0 then
        return { }
    end

    local FoundChild2
    local Name = SpotName .. "LightFX"
    local Parent = List[ 1 ]
    local FoundChild = Parent:FindFirstChild( Name )

    if FoundChild then
        FoundChild2 = FoundChild
    else
        local Entry = Table17[ SpotName ]
        local Result = Vector3.new( 1, 1, 1 ) * math.huge
        local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

        for Index, Value in ipairs( List ) do
            local Value2, Value3 = ExtentsIn( Argument1, Value )
            Result = Result:Min( Value2 )
            Result2 = Result2:Max( Value3 )
        end

        local X = ( Result.X + Result2.X ) / 2
        local Y = ( Result.Y + Result2.Y ) / 2
        local Vector32 = Vector3.new( X, Y, Result2.Z + 0.2 )
        local Parent2 = Instance.new( "Attachment" )
        Parent2.Name = Name
        Parent2.CFrame = Parent.CFrame:ToObjectSpace( Argument1.CFrame * CFrame.lookAt( Vector32, Vector32 + Vector3.new( 0, -Entry.Down, 1 ) ) )
        local SpotLight = Instance.new( "SpotLight" )
        SpotLight.Face = Enum.NormalId.Front
        local Color = Entry.Color
        local Brightness = Entry.Brightness
        local Range = Entry.Range
        local Angle = Entry.Angle
        SpotLight.Color = Color
        SpotLight.Brightness = Brightness
        SpotLight.Range = Range
        SpotLight.Angle = Angle
        SpotLight.Shadows = false
        SpotLight.Enabled = false
        SpotLight.Parent = Parent2
        Parent2.Parent = Parent
        FoundChild2 = Parent2
    end

    return { FoundChild2:FindFirstChildOfClass( "SpotLight" ) }
end

local function RestIn( Argument1, Argument2 )
    for Index, Value in ipairs( Argument2:GetJoints( ) ) do
        if Value:IsA( "Motor6D" ) and Value.Name == "VehicleBody" and Value.Part0 == Argument1 then
            if Value.Part1 == Argument2 then
                return Value.C0 * Value.C1:Inverse( )
            end
        end
    end

    return Argument1.CFrame:ToObjectSpace( Argument2.CFrame )
end

local function HeadlightSpots( Argument1, List )
    local Table = { }

    for Index, Value in ipairs( List ) do
        for Index7, Value14 in ipairs( Value:GetChildren( ) ) do
            if Value14.Name == "HeadlightFX" and Value14:FindFirstChildOfClass( "SpotLight" ) then
                table.insert( Table, Value14:FindFirstChildOfClass( "SpotLight" ) )
            end
        end
    end
    if #Table > 0 then
        return Table
    end

    local Table2 = { }

    for Index2, Value3 in ipairs( List ) do
        local Flag
        local RestIn2 = RestIn( Argument1, Value3 )
        Flag = false

        for Index4, Value8 in ipairs( Value3:GetChildren( ) ) do
            if Value8:IsA( "Attachment" ) and Value8.Name:sub( 1, 5 ) == "Phare" then
                table.insert( Table2, { part = Value3, rest = RestIn2, pos = RestIn2 * Value8.Position } )
                Flag = true
            end
        end
        if not Flag then
            local Size = Value3.Size / 2
            local Result = Vector3.new( 1, 1, 1 ) * math.huge
            local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

            for Index5, Value10 in ipairs( Table16 ) do
                local Size2 = RestIn2 * ( Value10 * Size )
                Result = Result:Min( Size2 )
                Result2 = Result2:Max( Size2 )
            end

            local Min = math.min( 0.6, ( Result2.X - Result.X ) / 4 )

            for Index6, Value12 in ipairs( { Result.X + Min, Result2.X - Min } ) do
                local Y = ( Result.Y + Result2.Y ) / 2
                table.insert( Table2, {
                    part = Value3,
                    rest = RestIn2,
                    pos = Vector3.new( Value12, Y, Result.Z )
                } )
            end
        end
    end

    local Brightness = 4 / math.max( #Table2, 2 )

    for Index3, Value5 in ipairs( Table2 ) do
        local Pos = Value5.pos + Vector3.new( 0, 0, -0.20000000298023224 )
        local Parent = Instance.new( "Attachment" )
        Parent.Name = "HeadlightFX"
        Parent.CFrame = Value5.rest:Inverse( ) * CFrame.lookAt( Pos, Pos + Vector3.new( 0, -0.07999999821186066, -1 ) )
        local SpotLight = Instance.new( "SpotLight" )
        SpotLight.Face = Enum.NormalId.Front
        local Color = Value5.part.Color
        SpotLight.Color = Color:Lerp( Color3.new( 1, 1, 1 ), 0.6 )
        SpotLight.Brightness = Brightness
        SpotLight.Range = 80
        SpotLight.Angle = 70
        SpotLight.Shadows = false
        SpotLight.Enabled = false
        SpotLight.Parent = Parent
        Parent.Parent = Value5.part
        table.insert( Table, SpotLight )
    end

    return Table
end

local function SetLights( List, Enabled )
    for Index, Value in ipairs( List ) do
        Value.Enabled = Enabled
    end
end

local function SetRearLights( List, List2, Enabled, Argument4 )
    for Index, Value in ipairs( List ) do
        local Material
        local LitColor = Value:GetAttribute( "LitColor" )

        if Enabled then
            Material = Enum.Material[ Value:GetAttribute( "LitMaterial" ) ]
        else
            Material = SmoothPlastic
        end

        Value.Material = Material

        if not Argument4 then
            local Color

            if Enabled then
                Color = LitColor
            else
                Color = LitColor:Lerp( Color3.new( ), 0.55 )
            end

            Value.Color = Color
        end
    end
    for Index2, Value3 in ipairs( List2 ) do
        Value3.Enabled = Enabled
    end
end

local function HasDriver( Object, Argument2 )
    local DriverSeat3
    local DriverSeat = Argument2.driverSeat

    if DriverSeat then
        DriverSeat3 = DriverSeat
    else
        local DriverSeat2
        local VehicleSeats = Object:FindFirstChild( "VehicleSeats" )

        if VehicleSeats then
            DriverSeat2 = VehicleSeats:FindFirstChild( "Driver" )
        else
            DriverSeat2 = VehicleSeats
        end

        Argument2.driverSeat = DriverSeat2
        DriverSeat3 = DriverSeat2
    end

    local Flag

    if DriverSeat3 == nil then
        Flag = false
    elseif DriverSeat3.Occupant == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function UpdateLamps( Object, Argument2, BrakeOn, ReverseOn, HeadOn, Destroyed )
    if not Argument2.brakeLights then
        local ReverseLights = { }
        Argument2.brakeLights = { }
        Argument2.reverseLights = ReverseLights
        local Table = { }
        local Headlights = Argument2.cfg.Headlights or "FrontLights"
        local BrakeLights = Argument2.cfg.BrakeLights or "BackLights"

        for Index, Value in ipairs( Object:GetDescendants( ) ) do
            if Value:IsA( "BasePart" ) then
                local Name = Value.Name

                if Name:sub( 1, #BrakeLights ) == BrakeLights then
                    if Value:GetAttribute( "LitColor" ) == nil then
                        Value:SetAttribute( "LitMaterial", Value.Material.Name )
                        Value:SetAttribute( "LitColor", Value.Color )
                    end

                    local ReverseLights2
                    local Name2 = Value.Name

                    if Name2:find( "White", #BrakeLights + 1, true ) then
                        ReverseLights2 = Argument2.reverseLights
                    else
                        ReverseLights2 = Argument2.brakeLights
                    end

                    table.insert( ReverseLights2, Value )
                else
                    local Name3 = Value.Name

                    if Name3:sub( 1, #Headlights ) == Headlights then
                        table.insert( Table, Value )
                    end
                end
            end
        end

        local Root = Argument2.root
        Argument2.brakeLamps = RearSpot( Root, Argument2.brakeLights, "Brake" )
        local Root2 = Argument2.root
        Argument2.reverseLamps = RearSpot( Root2, Argument2.reverseLights, "Reverse" )
        Argument2.headLamps = HeadlightSpots( Argument2.root, Table )
    end
    if HeadOn ~= Argument2.headOn then
        Argument2.headOn = HeadOn

        for Index2, Value3 in ipairs( Argument2.headLamps ) do
            Value3.Enabled = HeadOn
        end
    end
    for Index3, Value5 in ipairs( Argument2.headLamps ) do
        local Parent2
        local Parent = Value5.Parent
        Parent2 = if Parent then Value5.Parent.Parent else Parent

        if Parent2 and Parent2:IsA( "BasePart" ) then
            local Color = Parent2.Color
            local Color2 = Color:Lerp( Color3.new( 1, 1, 1 ), 0.6 )

            if Value5.Color ~= Color2 then
                Value5.Color = Color2
            end
        end
    end
    if BrakeOn ~= Argument2.brakeOn then
        Argument2.brakeOn = BrakeOn
        local BrakeLights2 = Argument2.brakeLights
        SetRearLights( BrakeLights2, Argument2.brakeLamps, BrakeOn, Destroyed )
    end
    if ReverseOn ~= Argument2.reverseOn then
        Argument2.reverseOn = ReverseOn
        local ReverseLights3 = Argument2.reverseLights
        SetRearLights( ReverseLights3, Argument2.reverseLamps, ReverseOn, Destroyed )
    end
end

local Table19 = { { "LeftLowerLeg", "LeftKnee" }, { "RightLowerLeg", "RightKnee" } }
local Table20 = { }
local Class3 = setmetatable( { }, { __mode = "k" } )

local function WatchSeat( SeatsName, SeatName )
    if not SeatName:IsA( "Seat" ) and not SeatName:IsA( "VehicleSeat" ) then
        return
    end

    local Value1

    local function Sync()
        local Captured = SeatName.Occupant ~= nil and SeatName:IsDescendantOf( workspace ) and SeatsName or nil
        Table20[ SeatName ] = Captured
    end

    SeatName:GetPropertyChangedSignal( "Occupant" ):Connect( Sync )
    SeatName.AncestryChanged:Connect( Sync )
    Value1 = SeatName.Occupant ~= nil and SeatName:IsDescendantOf( workspace ) and SeatsName or nil
    Table20[ SeatName ] = Value1
end

local function WatchSeats( SeatsName )
    local VehicleSeats = SeatsName:FindFirstChild( "VehicleSeats" )

    if not VehicleSeats then
        return
    end

    Class3[ SeatsName ] = true

    for Key, Value in VehicleSeats:GetChildren( ) do
        WatchSeat( SeatsName, Value )
    end

    VehicleSeats.ChildAdded:Connect( function( SeatName )
        WatchSeat( SeatsName, SeatName )
    end )
end

RunService.PreSimulation:Connect( function()
    local Value1 = nil

    for Key, Value in Vehicle, nil, nil do
        if not Class3[ Value ] then
            WatchSeats( Value )
        end
    end

    local Value2 = nil

    for Key2, Value3 in Table20, nil, nil do
        local Occupant2
        local Occupant = Key2.Occupant
        Occupant2 = if Occupant then Occupant.Parent else Occupant

        if Occupant2 then
            local SeatKnee2
            local Entry = Table[ Value3 ]

            if Entry then
                local SeatKnee = Entry.cfg.SeatKnee

                if SeatKnee then
                    SeatKnee2 = SeatKnee
                else
                    SeatKnee2 = -25
                end
            else
                SeatKnee2 = -25
            end

            local Value4
            local Transform = CFrame.Angles( math.rad( SeatKnee2 ), 0, 0 )
            Value4 = nil

            for Key3, Value5 in Table19, nil, nil do
                local FoundChild2
                local FoundChild = Occupant2:FindFirstChild( Value5[ 1 ] )

                if FoundChild then
                    FoundChild2 = FoundChild:FindFirstChild( Value5[ 2 ] )
                else
                    FoundChild2 = FoundChild
                end
                if FoundChild2 then
                    FoundChild2.Transform = Transform
                end
            end
        end
    end
end )
local Table21 = { }
RunService.PreRender:Connect( function( Amount )
    local Position = CurrentCamera.CFrame.Position

    for Index, Value in ipairs( Vehicle ) do
        local Entry2
        local Entry = Table[ Value ]

        if Entry then
            Entry2 = Entry
        else
            local State = VehiclePhysics.newState( Value ) or false
            Table[ Value ] = State
            Entry2 = State
        end

        local Entry3 = Entry2 or nil

        if Entry3 and Entry3.root.Parent then
            if ( Entry3.root.Position - Position ).Magnitude < 350 then
                local Mine
                Entry3.farNext = nil

                if Value1 then
                    local Driver = Value1.driver

                    if Driver then
                        if Value1.model == Value then
                            Mine = true
                        else
                            Mine = false
                        end
                    else
                        Mine = Driver
                    end
                else
                    Mine = Value1
                end
                if Mine or Coasting[ Value ] or not Entry3.root.Anchored then
                    Entry3.idleSince = nil
                    Entry3.idleNext = nil
                else
                    local DriverSeat3
                    local DriverSeat = Entry3.driverSeat

                    if DriverSeat then
                        DriverSeat3 = DriverSeat
                    else
                        local DriverSeat2
                        local VehicleSeats = Value:FindFirstChild( "VehicleSeats" )

                        if VehicleSeats then
                            DriverSeat2 = VehicleSeats:FindFirstChild( "Driver" )
                        else
                            DriverSeat2 = VehicleSeats
                        end

                        Entry3.driverSeat = DriverSeat2
                        DriverSeat3 = DriverSeat2
                    end

                    local FlagInner

                    if DriverSeat3 == nil then
                        FlagInner = false
                    elseif DriverSeat3.Occupant == nil then
                        FlagInner = false
                    else
                        FlagInner = true
                    end
                    if FlagInner then
                        Entry3.idleSince = nil
                        Entry3.idleNext = nil
                    else
                        local Clock = os.clock( )
                        Entry3.idleSince = Entry3.idleSince or Clock

                        if Clock - Entry3.idleSince > 3 then
                            if Clock < ( Entry3.idleNext or 0 ) then
                                continue
                            end

                            Entry3.idleNext = Clock + 0.25
                        end
                    end
                end

                local Destroyed = Value:GetAttribute( "Destroyed" )

                if not Mine and not Coasting[ Value ] and not Entry3.root.Anchored and Value:GetAttribute( "PushOwner" ) == LocalPlayer.UserId then
                    local Driver2
                    local VehicleSeats2 = Value:FindFirstChild( "VehicleSeats" )

                    if VehicleSeats2 then
                        Driver2 = VehicleSeats2:FindFirstChild( "Driver" )
                    else
                        Driver2 = VehicleSeats2
                    end
                    if Driver2 then
                        Coast( Value, Entry3, Driver2, Table8, Entry3.cfg.PushTime + 0.5 )
                    end
                end

                local Slide
                local NotDestroyed = not Destroyed

                if NotDestroyed then
                    if Mine then
                        Slide = Flag
                    elseif Value:GetAttribute( "Handbrake" ) == true then
                        Slide = true
                    else
                        Slide = false
                    end
                else
                    Slide = NotDestroyed
                end

                local NotDestroyed3
                local NotDestroyed2 = not Destroyed

                if NotDestroyed2 then
                    if Mine then
                        NotDestroyed3 = Flag3
                    elseif Value:GetAttribute( "Reverse" ) == true then
                        NotDestroyed3 = true
                    else
                        NotDestroyed3 = false
                    end
                else
                    NotDestroyed3 = NotDestroyed2
                end

                local NotDestroyed5

                if Slide then
                    NotDestroyed5 = Slide
                elseif NotDestroyed3 then
                    NotDestroyed5 = NotDestroyed3
                else
                    local NotDestroyed4 = not Destroyed

                    if NotDestroyed4 then
                        if Mine then
                            NotDestroyed5 = Flag2
                        elseif Value:GetAttribute( "Brake" ) == true then
                            NotDestroyed5 = true
                        else
                            NotDestroyed5 = false
                        end
                    else
                        NotDestroyed5 = NotDestroyed4
                    end
                end

                local NotDestroyed7
                local NotDestroyed6 = not Destroyed

                if NotDestroyed6 then
                    local DriverSeat6
                    local DriverSeat4 = Entry3.driverSeat

                    if DriverSeat4 then
                        DriverSeat6 = DriverSeat4
                    else
                        local DriverSeat5
                        local VehicleSeats3 = Value:FindFirstChild( "VehicleSeats" )

                        if VehicleSeats3 then
                            DriverSeat5 = VehicleSeats3:FindFirstChild( "Driver" )
                        else
                            DriverSeat5 = VehicleSeats3
                        end

                        Entry3.driverSeat = DriverSeat5
                        DriverSeat6 = DriverSeat5
                    end
                    if DriverSeat6 == nil then
                        NotDestroyed7 = false
                    elseif DriverSeat6.Occupant == nil then
                        NotDestroyed7 = false
                    else
                        NotDestroyed7 = true
                    end
                else
                    NotDestroyed7 = NotDestroyed6
                end

                UpdateLamps( Value, Entry3, NotDestroyed5, NotDestroyed3, NotDestroyed7, Destroyed )
                local Anchored = Entry3.root.Anchored

                if Destroyed then
                    local CFrame

                    if Anchored then
                        CFrame = Value:GetAttribute( "WreckRest" )
                    else
                        CFrame = Anchored
                    end
                    if CFrame then
                        local CFrame2 = Entry3.root.CFrame

                        if ( CFrame2.Position - CFrame.Position ).Magnitude > 0.01 or CFrame2.UpVector:Dot( CFrame.UpVector ) < 0.99999 or CFrame2.LookVector:Dot( CFrame.LookVector ) < 0.99999 then
                            Entry3.root.CFrame = CFrame
                        end
                    else
                        KeepWreckAboveGround( Value, Entry3 )
                    end
                end

                local Flag2Inner
                local Number = tonumber( ( Value:GetAttribute( "RideDrop" ) ) ) or 0

                if Entry3.rideShown == Number then
                    if ( Entry3.rideVis or 0 ) == Number then
                        Flag2Inner = false
                    else
                        Flag2Inner = true
                    end
                else
                    Flag2Inner = true
                end
                if Mine then
                    if not Mine then
                        VehiclePhysics.castWheels( Entry3 )

                        if Entry3.cfg.TwoWheels then
                            local WheelieOn

                            if Value:GetAttribute( "Wheelie" ) == true then
                                WheelieOn = true
                            else
                                WheelieOn = false
                            end

                            local WheelieBrake

                            if Value:GetAttribute( "Brake" ) == true then
                                WheelieBrake = true
                            else
                                WheelieBrake = false
                            end

                            Entry3.wheelieOn = WheelieOn
                            Entry3.wheelieBrake = WheelieBrake
                        end
                    end

                    local Steer
                    local UpdateVisuals = VehiclePhysics.updateVisuals

                    if not Mine or not Entry3.steer then
                        Steer = nil
                    else
                        Steer = Entry3.steer
                    end

                    local VisualCF
                    UpdateVisuals( Entry3, Amount, Steer, Slide )

                    if Anchored then
                        local CFrame3 = Entry3.root.CFrame

                        if CFrame3 then
                            VisualCF = CFrame3
                        else
                            VisualCF = nil
                        end
                    else
                        VisualCF = nil
                    end

                    Entry3.visualCF = VisualCF
                    CarSteer[ Value ] = ( Entry3.shownSteer or 0 ) / math.rad( Entry3.cfg.MaxSteer )
                    local SetSteer = AnimWorkers.SetSteer
                    SetSteer( Value, CarSteer[ Value ] )
                elseif not Destroyed then
                    if not Anchored or Entry3.visualCF ~= Entry3.root.CFrame or Flag2Inner then
                        if not Mine then
                            VehiclePhysics.castWheels( Entry3 )

                            if Entry3.cfg.TwoWheels then
                                if Value:GetAttribute( "Wheelie" ) == true then
                                    WheelieOn = true
                                else
                                    WheelieOn = false
                                end
                                if Value:GetAttribute( "Brake" ) == true then
                                    WheelieBrake = true
                                else
                                    WheelieBrake = false
                                end

                                Entry3.wheelieOn = WheelieOn
                                Entry3.wheelieBrake = WheelieBrake
                            end
                        end

                        local UpdateVisuals = VehiclePhysics.updateVisuals

                        if not Mine or not Entry3.steer then
                            Steer = nil
                        else
                            Steer = Entry3.steer
                        end

                        UpdateVisuals( Entry3, Amount, Steer, Slide )

                        if Anchored then
                            local CFrame3 = Entry3.root.CFrame

                            if CFrame3 then
                                VisualCF = CFrame3
                            else
                                VisualCF = nil
                            end
                        else
                            VisualCF = nil
                        end

                        Entry3.visualCF = VisualCF
                        CarSteer[ Value ] = ( Entry3.shownSteer or 0 ) / math.rad( Entry3.cfg.MaxSteer )
                        local SetSteer = AnimWorkers.SetSteer
                        SetSteer( Value, CarSteer[ Value ] )
                    end
                end

                local Held
                Table21.mine = Mine
                Table21.slide = Slide
                Table21.destroyed = Destroyed
                Held = Value:GetAttribute( "Burn" ) == true and true or false
                local Gas = Value:GetAttribute( "BurnLaunch" ) == true and true or false
                local Flag3Inner
                Table21.held = Held
                Table21.gas = Gas

                if Value1 == nil then
                    Flag3Inner = false
                elseif Value1.model == Value then
                    Flag3Inner = true
                else
                    Flag3Inner = false
                end

                Table21.group = EngineGroup( Flag3Inner, Entry3.cfg )
                BurnoutFX.Update( Value, Entry3, Amount, Table21 )
                local NotDestroyed8 = not Destroyed
                UpdateSparks( Entry3, NotDestroyed8, Amount, Table21.group )
                UpdateSmokeRate( Value, Entry3 )
                UpdateEngine( Value, Entry3, Amount )
                UpdateTireSound( Value, Entry3, Amount, Slide, Destroyed )
            else
                local Clock2 = os.clock( )

                if not Entry3.farNext or not ( Clock2 < Entry3.farNext ) or Entry3.sparksOn then
                    Entry3.farNext = Clock2 + 1
                    UpdateLamps( Value, Entry3, false, false, false, Value:GetAttribute( "Destroyed" ) )
                    BurnoutFX.Stop( Entry3 )

                    if Entry3.tire then
                        local Value2
                        local Sounds = Entry3.tire.sounds
                        Value2 = nil

                        for Key, Value3 in Sounds, nil, nil do
                            Value3:Stop( )
                            Value3.Volume = 0
                        end

                        Entry3.tire.power = 0
                    end

                    UpdateSparks( Entry3, false, Amount )

                    if Entry3.engine and Entry3.engine.IsPlaying then
                        Entry3.engine:Stop( )
                    end
                    if Entry3.engineAudio then
                        Entry3.engineAudio:Silence( )
                        Entry3.engineOn = false
                    end
                end
            end
        end
    end
end )

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    Upvalue1 = nil

    if not Upvalue3 then
        return
    end

    Upvalue4:FireServer( "Exit" )

    if Upvalue3.driver then
        local SeatWeld
        local Seat = Upvalue3.seat

        if Seat then
            SeatWeld = Upvalue3.seat:FindFirstChild( "SeatWeld" )
        else
            SeatWeld = Seat
        end
        if SeatWeld then
            SeatWeld:Destroy( )
        end

        local Humanoid
        local Character = Upvalue5.Character

        if Character then
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end
        if Character then
            Character:FindFirstChild( "HumanoidRootPart" )
        end
        if Humanoid then
            Humanoid.Sit = false
        end
    end
end
]]
