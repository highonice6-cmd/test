-- ReplicatedStorage.Controls
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local IsGamepad
local Players = game:GetService( "Players" )
local UserInputService = game:GetService( "UserInputService" )
local HapticService = game:GetService( "HapticService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Spec = require( script:WaitForChild( "Spec" ) )
local KeyCode = Enum.KeyCode
local UserInputType = Enum.UserInputType
local Gamepad1 = UserInputType.Gamepad1
local Table2 = {
    MoveForward = { keys = { KeyCode.W, KeyCode.Up }, label = "Move Forward" },
    MoveBack = { keys = { KeyCode.S, KeyCode.Down }, label = "Move Backward" },
    MoveLeft = { keys = { KeyCode.A }, label = "Move Left" },
    MoveRight = { keys = { KeyCode.D }, label = "Move Right" },
    Fire = {
        mouse = UserInputType.MouseButton1,
        pad = { KeyCode.ButtonR2 },
        label = "Shoot"
    },
    Aim = {
        mouse = UserInputType.MouseButton2,
        pad = { KeyCode.ButtonL2 },
        label = "Aim"
    },
    Reload = { keys = { KeyCode.R }, pad = { KeyCode.ButtonX }, label = "Reload" },
    Shoulder = {
        keys = { KeyCode.Q },
        pad = { KeyCode.ButtonR3 },
        label = "Switch Shoulder"
    },
    Sprint = {
        keys = { KeyCode.LeftShift },
        pad = { KeyCode.ButtonL3 },
        label = "Sprint (while moving)"
    },
    Crouch = { keys = { KeyCode.C }, pad = { KeyCode.ButtonB }, label = "Crouch" },
    Roll = {
        keys = { KeyCode.Space },
        pad = { KeyCode.ButtonA },
        label = "Jump / Roll while aiming"
    },
    Interact = {
        keys = { KeyCode.E, KeyCode.F },
        pad = { KeyCode.ButtonY },
        label = "Enter / Exit vehicle, Carry"
    },
    Inventory = {
        keys = { KeyCode.Tab },
        pad = { KeyCode.ButtonSelect },
        label = "Inventory"
    },
    HotbarPrev = { pad = { KeyCode.ButtonL1 }, label = "Previous Weapon" },
    HotbarNext = { pad = { KeyCode.ButtonR1 }, label = "Next Weapon" },
    DriveBrake = {
        keys = { KeyCode.Space },
        pad = { KeyCode.ButtonB },
        label = "Driving: Handbrake"
    },
    DriveAim = { pad = { KeyCode.ButtonL1 }, label = "Driving: Aim (hold LB)" },
    DriveFire = {
        pad = { KeyCode.ButtonR1 },
        label = "Driving: Shoot (RB while aiming)"
    },
    DriveSwap = { pad = { KeyCode.ButtonA }, label = "Driving: Next Weapon" },
    DriveGas = {
        pad = { KeyCode.ButtonR2 },
        label = "Driving: Accelerate (LT: Brake)"
    },
    DriveWheelie = {
        keys = { KeyCode.LeftShift },
        pad = { KeyCode.ButtonL3 },
        label = "Driving: Wheelie (scooter, hold)"
    },
    VehicleLock = {
        keys = { KeyCode.N },
        pad = { KeyCode.ButtonR3 },
        label = "Driving: Lock / Unlock Vehicle"
    },
    VehicleRepair = {
        keys = { KeyCode.G, KeyCode.Left },
        pad = { KeyCode.DPadDown },
        label = "Driving: Repair Vehicle"
    },
    CursorMode = {
        keys = { KeyCode.LeftAlt, KeyCode.RightAlt },
        pad = { KeyCode.DPadRight },
        label = "Cursor Mode (R3 in menus)"
    },
    TopbarFocus = {
        pad = { KeyCode.DPadUp },
        label = "Menu Bar (Customization, Settings)"
    },
    PadMenu = { label = "Settings" },
    Attachments = {
        keys = { KeyCode.M },
        pad = { KeyCode.DPadLeft },
        label = "Attachments"
    },
    RankedWeapon = {
        keys = { KeyCode.B },
        pad = { KeyCode.DPadLeft },
        label = "Ranked: Change Weapon"
    },
    Dance = {
        keys = { KeyCode.O },
        pad = { KeyCode.DPadDown },
        label = "Emote Wheel"
    },
    Slot1 = {
        keys = { KeyCode.One, KeyCode.KeypadOne, KeyCode.Ampersand },
        label = "Weapon Slot 1"
    },
    Slot2 = {
        keys = { KeyCode.Two, KeyCode.KeypadTwo, KeyCode.World73 },
        label = "Weapon Slot 2"
    },
    Slot3 = {
        keys = { KeyCode.Three, KeyCode.KeypadThree, KeyCode.QuotedDouble },
        label = "Weapon Slot 3"
    },
    Slot4 = {
        keys = { KeyCode.Four, KeyCode.KeypadFour, KeyCode.Quote },
        label = "Weapon Slot 4"
    },
    Slot5 = {
        keys = { KeyCode.Five, KeyCode.KeypadFive, KeyCode.LeftParenthesis },
        label = "Weapon Slot 5"
    },
    HideUI = { keys = { KeyCode.H }, label = "Hide / Show UI" },
    Shop = { keys = { KeyCode.K }, label = "Shop" },
    HudMenu = { keys = { KeyCode.J }, label = "Side Menu (Crew, Emotes)" },
    Effects = { keys = { KeyCode.L }, label = "Effects" },
    Clan = { keys = { KeyCode.P }, label = "Clan" }
}
local Table3 = { Inventory = true, PadMenu = true, Attachments = true, Dance = true }

local function IsPadKey( Argument1 )
    local Flag
    local Name = Argument1.Name

    if Name:sub( 1, 6 ) == "Button" then
        Flag = true
    elseif Name:sub( 1, 4 ) == "DPad" then
        Flag = true
    elseif Name:sub( 1, 10 ) == "Thumbstick" then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local Table4 = { }
local Table5 = { }
local Table6 = { }
local Table7 = { }
local BindableEvent = Instance.new( "BindableEvent" )
local Table = {
    Actions = Table2,
    MenuOpen = false,
    Locked = false,
    MenuKeysAllowed = false,
    IsPadKey = IsPadKey,
    Pressed = BindableEvent.Event,
    OnInputBegan = function( Argument1 )
        UserInputService.InputBegan:Connect( Argument1 )
        table.insert( Table6, Argument1 )
    end,
    OnInputEnded = function( Input )
        UserInputService.InputEnded:Connect( Input )
        table.insert( Table7, Input )
    end,
    Press = function( Key, Argument2, Argument3 )
        local Flag2 = Argument2 == true and true or false
        local Flag = Table4[ Key ] == true and true or false

        if Flag == Flag2 then
            return
        end

        Table4[ Key ] = Flag2 or nil

        if Flag2 then
            local Flag3 = if Argument3 == true then true else nil
            Table5[ Key ] = Flag3
        end

        local UserInputState
        local Table = {
            Virtual = Key,
            KeyCode = KeyCode.Unknown,
            UserInputType = UserInputType.None,
            Position = Vector3.new( 0, 0, 0 ),
            Delta = Vector3.new( 0, 0, 0 )
        }
        UserInputState = Flag2 and Enum.UserInputState.Begin or Enum.UserInputState.End
        local Hold
        Table.UserInputState = UserInputState
        Hold = Table5[ Key ] == true and true or false
        Table.Hold = Hold

        if not Flag2 then
            Table5[ Key ] = nil
        end

        local Captured = Flag2 and Table6 or Table7
        local Value1 = nil

        for Key2, Value in Captured, nil, nil do
            task.spawn( Value, Table, false )
        end

        BindableEvent:Fire( Key, Flag2 )
    end
}
function Table.IsVirtualDown( Key )
    local Flag = if Table4[ Key ] == true then not Table.Locked else false
    return Flag
end
function Table.ReleaseAll()
    local Value1
    local TableInner = { }
    Value1 = nil

    for Value in Table4, nil, nil do
        table.insert( TableInner, Value )
    end

    local Value2 = nil

    for Key, Value3 in TableInner, nil, nil do
        Table.Press( Value3, false )
    end
end
function Table.Is( Key, Argument2 )
    local Entry = Table.Actions[ Key ]

    if Table.Capturing then
        return false
    end
    if Table.Locked and Argument2.UserInputState == Enum.UserInputState.Begin then
        return false
    end
    if type( Argument2 ) == "table" then
        local Flag = Argument2.Virtual == Key and true or false
        return Flag
    end
    if not Entry then
        return false
    end
    if Entry.mouse and Argument2.UserInputType == Entry.mouse then
        return true
    end
    if Entry.mice and table.find( Entry.mice, Argument2.UserInputType ) then
        return true
    end

    local KeyCodeInner = Argument2.KeyCode

    if KeyCodeInner == KeyCode.Unknown then
        return false
    end
    if Table.MenuOpen and Argument2.UserInputState == Enum.UserInputState.Begin then
        local Flag2
        local Name = KeyCodeInner.Name

        if Name:sub( 1, 6 ) == "Button" then
            Flag2 = true
        elseif Name:sub( 1, 4 ) == "DPad" then
            Flag2 = true
        elseif Name:sub( 1, 10 ) == "Thumbstick" then
            Flag2 = true
        else
            Flag2 = false
        end
        if Flag2 then
            if not Table.MenuKeysAllowed or not Table3[ Key ] then
                return false
            end
        end
    end

    local Flag3

    if Entry.keys == nil or table.find( Entry.keys, KeyCodeInner ) == nil then
        if Entry.pad == nil then
            Flag3 = false
        elseif table.find( Entry.pad, KeyCodeInner ) == nil then
            Flag3 = false
        else
            Flag3 = true
        end
    else
        Flag3 = true
    end

    return Flag3
end
function Table.IsDown( Key )
    local Entry = Table.Actions[ Key ]

    if Table.Locked or Table.Capturing then
        return false
    end
    if Table4[ Key ] then
        return true
    end
    if not Entry then
        return false
    end
    if Entry.mouse and UserInputService:IsMouseButtonPressed( Entry.mouse ) then
        return true
    end

    local Mice2
    local Mice = Entry.mice
    Mice2 = if Mice then Mice else { }
    local Value1 = nil

    for Key2, Value in Mice2, nil, nil do
        if UserInputService:IsMouseButtonPressed( Value ) then
            return true
        end
    end

    local Keys2
    local Keys = Entry.keys
    Keys2 = if Keys then Keys else { }
    local Value2 = nil

    for Key3, Value3 in Keys2, nil, nil do
        if UserInputService:IsKeyDown( Value3 ) then
            return true
        end
    end
    if Table.MenuOpen then
        return false
    end

    local Pad2
    local Pad = Entry.pad
    Pad2 = if Pad then Pad else { }
    local Value4 = nil

    for Key4, Value5 in Pad2, nil, nil do
        if UserInputService:IsGamepadButtonDown( Gamepad1, Value5 ) then
            return true
        end
    end

    return false
end
function Table.Glyph( Argument1 )
    if not Argument1 then
        return nil, "-"
    end

    local Result3
    local Success, Result = pcall( UserInputService.GetImageForKeyCode, UserInputService, Argument1 )
    local Success2, Result2 = pcall( UserInputService.GetStringForKeyCode, UserInputService, Argument1 )
    Result3 = Success and Result ~= "" and Result or nil
    local Gsub

    if not Success2 or Result2 == "" or not Result2 then
        Gsub = Argument1.Name:gsub( "^Button", "" )
    else
        Gsub = Result2
    end

    return Result3, Gsub
end
local BindableEvent2 = Instance.new( "BindableEvent" )
Table.Changed = BindableEvent2.Event

local function IsPadType( Argument1 )
    local Flag = Argument1.Name:match( "^Gamepad%d" ) ~= nil and true or false
    return Flag
end

local function IsKbmType( Argument1 )
    local Flag

    if Argument1 == UserInputType.Keyboard then
        Flag = true
    elseif Argument1 == UserInputType.TextInput then
        Flag = true
    elseif Argument1 == UserInputType.Touch then
        Flag = true
    elseif Argument1.Name:match( "^Mouse" ) == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

IsGamepad = UserInputService:GetLastInputType( ).Name:match( "^Gamepad%d" ) ~= nil and true or false
local Flag
Table.IsGamepad = IsGamepad
Table.LastMouseMove = -math.huge
local IsStudio = game:GetService( "RunService" ):IsStudio( )

local function Forced()
    local Captured

    if IsStudio then
        if Players.LocalPlayer:GetAttribute( "ForceGamepad" ) == true then
            Captured = true
        else
            Captured = false
        end
    else
        Captured = IsStudio
    end

    return Captured
end

Players.LocalPlayer:GetAttributeChangedSignal( "ForceGamepad" ):Connect( function()
    local IsGamepad

    if IsStudio then
        if Players.LocalPlayer:GetAttribute( "ForceGamepad" ) == true then
            IsGamepad = true
        else
            IsGamepad = false
        end
    else
        IsGamepad = IsStudio
    end
    if not IsGamepad then
        if UserInputService:GetLastInputType( ).Name:match( "^Gamepad%d" ) == nil then
            IsGamepad = false
        else
            IsGamepad = true
        end
    end
    if IsGamepad == Table.IsGamepad then
        return
    end
    Table.IsGamepad = IsGamepad
    BindableEvent2:Fire( IsGamepad )
    return
end )
UserInputService.LastInputTypeChanged:Connect( function( Argument1 )
    local Flag = Argument1.Name:match( "^Gamepad%d" ) ~= nil and true or false
    local IsGamepad

    if Flag then
        IsGamepad = true

        if IsStudio then
            if Players.LocalPlayer:GetAttribute( "ForceGamepad" ) == true then
                Captured = true
            else
                Captured = false
            end
        else
            Captured = IsStudio
        end
        if Captured then
            IsGamepad = true
        end
        if not IsGamepad and Table.IsGamepad and Argument1 ~= UserInputType.Keyboard and game:GetService( "GamepadService" ).GamepadCursorEnabled then
            return
        end
        if IsGamepad == Table.IsGamepad then
            return
        end

        Table.IsGamepad = IsGamepad

        if not IsGamepad then
            Table.StopRumble( )
        end

        BindableEvent2:Fire( IsGamepad )
        return
    end
    local Flag2

    if Argument1 == UserInputType.Keyboard then
        Flag2 = true
    elseif Argument1 == UserInputType.TextInput then
        Flag2 = true
    elseif Argument1 == UserInputType.Touch then
        Flag2 = true
    elseif Argument1.Name:match( "^Mouse" ) == nil then
        Flag2 = false
    else
        Flag2 = true
    end
    if not Flag2 then
        return
    end

    IsGamepad = false
    local Captured

    if IsStudio then
        if Players.LocalPlayer:GetAttribute( "ForceGamepad" ) == true then
            Captured = true
        else
            Captured = false
        end
    else
        Captured = IsStudio
    end
    if Captured then
        IsGamepad = true
    end
    if not IsGamepad and Table.IsGamepad and Argument1 ~= UserInputType.Keyboard and game:GetService( "GamepadService" ).GamepadCursorEnabled then
        return
    end
    if IsGamepad == Table.IsGamepad then
        return
    end

    Table.IsGamepad = IsGamepad

    if not IsGamepad then
        Table.StopRumble( )
    end

    BindableEvent2:Fire( IsGamepad )
    return
end )
local Value1 = nil
function Table.ControlModule()
    if Value1 == nil then
        local PlayerModule2
        Value1 = false
        local PlayerScripts = Players.LocalPlayer:FindFirstChild( "PlayerScripts" )
        local PlayerModule = game:GetService( "StarterPlayer" ):FindFirstChild( "PlayerModule" )

        if PlayerModule then
            PlayerModule2 = PlayerModule
        elseif PlayerScripts then
            PlayerModule2 = PlayerScripts:FindFirstChild( "PlayerModule" )
        else
            PlayerModule2 = PlayerScripts
        end

        local ControlModule

        if PlayerModule2 then
            ControlModule = PlayerModule2:FindFirstChild( "ControlModule" )
        else
            ControlModule = PlayerModule2
        end
        if ControlModule then
            local Success, Result = pcall( require, ControlModule )

            if Success and type( Result ) == "table" then
                Value1 = Result
            end
        end
    end

    return Value1 or nil
end
function Table.MoveAmount()
    local ControlModule2
    local ControlModule = Table.ControlModule( )
    ControlModule2 = if ControlModule then ControlModule.inputMoveVector else ControlModule

    if typeof( ControlModule2 ) == "Vector3" or typeof( ControlModule2 ) == "Vector2" then
        return ( math.min( ControlModule2.Magnitude, 1 ) )
    end
    return 0
end
local Zero = Vector2.zero
UserInputService.InputChanged:Connect( function( Argument1 )
    if Argument1.KeyCode == KeyCode.Thumbstick2 then
        Zero = Vector2.new( Argument1.Position.X, Argument1.Position.Y )
        return
    end
    if Argument1.UserInputType == UserInputType.MouseMovement and Argument1.Delta.Magnitude > 0 then
        Table.LastMouseMove = os.clock( )
    end
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    if Argument1.KeyCode == KeyCode.Thumbstick2 then
        Zero = Vector2.zero
    end
end )
UserInputService.GamepadDisconnected:Connect( function()
    Zero = Vector2.zero
end )
local Table8 = { }
local Zero2 = Vector2.zero

local function InThumbstick( Argument1 )
    local TouchGui
    local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui then
        TouchGui = PlayerGui:FindFirstChild( "TouchGui" )
    else
        TouchGui = PlayerGui
    end

    local TouchControlFrame

    if TouchGui then
        local IsA = TouchGui:IsA( "ScreenGui" )

        if IsA then
            local Enabled = TouchGui.Enabled

            if Enabled then
                TouchControlFrame = TouchGui:FindFirstChild( "TouchControlFrame" )
            else
                TouchControlFrame = Enabled
            end
        else
            TouchControlFrame = IsA
        end
    else
        TouchControlFrame = TouchGui
    end
    if not TouchControlFrame then
        return false
    end

    local Value1
    local Table = { "DynamicThumbstickFrame", "ThumbstickFrame" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local FoundChild = TouchControlFrame:FindFirstChild( Value )

        if FoundChild and FoundChild:IsA( "GuiObject" ) and FoundChild.Visible then
            local AbsolutePosition = FoundChild.AbsolutePosition
            local AbsoluteSize = FoundChild.AbsoluteSize
            local X = Argument1.X

            if AbsolutePosition.X <= X and AbsolutePosition.Y <= Argument1.Y and Argument1.X <= AbsolutePosition.X + AbsoluteSize.X then
                if Argument1.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                    return true
                end
            end
        end
    end

    return false
end

UserInputService.TouchStarted:Connect( function( Key, Argument2 )
    local Value1 = nil

    for Value in Table8, nil, nil do
        if Value.UserInputState == Enum.UserInputState.End or Value.UserInputState == Enum.UserInputState.Cancel then
            Table8[ Value ] = nil
        end
    end
    if Argument2 or InThumbstick( Key.Position ) then
        return
    end
    Table8[ Key ] = true
    return
end )
local Table9 = { }
function Table.LookTouch( TouchName )
    Table9[ TouchName ] = true
end
function Table.ReleaseTouch( TouchName )
    Table8[ TouchName ] = nil
    Table9[ TouchName ] = nil
end
Table.LastTouchLook = -math.huge
Table.TouchAssist = nil
UserInputService.TouchMoved:Connect( function( Key )
    if Table8[ Key ] or Table9[ Key ] then
        Zero2 = Zero2 + Vector2.new( Key.Delta.X, Key.Delta.Y )
        Table.LastTouchLook = os.clock( )
    end
end )
UserInputService.TouchEnded:Connect( function( Key )
    Table8[ Key ] = nil
    Table9[ Key ] = nil
end )
function Table.TakeTouchDelta()
    local Captured
    Zero2 = Vector2.zero
    local TouchAssist = Table.TouchAssist
    Captured = if not TouchAssist or not ( os.clock( ) - TouchAssist.t < 0.1 ) then Zero2 else Zero2 * TouchAssist.scale
    return Captured
end
Flag = UserInputService:GetLastInputType( ) == UserInputType.Touch and true or false
local Value3
UserInputService.LastInputTypeChanged:Connect( function( Argument1 )
    if Argument1 == UserInputType.Touch then
        Flag = true
        return
    end
    if Argument1 == UserInputType.Keyboard or Argument1 == UserInputType.TextInput or Argument1 == UserInputType.MouseWheel or Argument1.Name:match( "^MouseButton" ) or Argument1.Name:match( "^Gamepad" ) then
        Flag = false
    end
end )
function Table.TouchMode()
    if IsStudio and Players.LocalPlayer:GetAttribute( "ForceTouch" ) == true then
        return true
    end

    local TouchEnabled2
    local TouchEnabled = UserInputService.TouchEnabled

    if TouchEnabled then
        local NotMouseEnabled = not UserInputService.MouseEnabled

        if NotMouseEnabled then
            TouchEnabled2 = NotMouseEnabled
        else
            TouchEnabled2 = Flag
        end
    else
        TouchEnabled2 = TouchEnabled
    end

    return TouchEnabled2
end
local Value2 = nil
function Table.Stick()
    local Magnitude = Zero.Magnitude
    local Deadzone = Table.Settings.Deadzone

    if Magnitude <= Deadzone then
        return Vector2.zero
    end
    local Min = math.min( ( Magnitude - Deadzone ) / ( 1 - Deadzone ), 1 )
    return Zero.Unit * Min ^ 1.8
end
function Table.LookDelta( Argument1, Argument2, Argument3 )
    local Stick = Table.Stick( )

    if Stick == Vector2.zero then
        Value2 = nil
        return 0, 0
    end

    local Clamp
    local Settings = Table.Settings
    local LookSens = Settings.LookSens / 5

    if not Argument3 or not ( Zero.Magnitude > 0.95 ) or not ( math.abs( Zero.X ) > 0.8 ) then
        Value2 = nil
        Clamp = 1
    else
        Value2 = Value2 or os.clock( )
        Clamp = math.clamp( ( os.clock( ) - Value2 - 0.15 ) / 0.35, 0, 1 ) * 0.5 + 1
    end

    local Number
    local Amount = -Stick.X * 3.490658503988659 * LookSens * Clamp * Argument2 * Argument1
    local Y = Stick.Y * 2.443460952792061 * LookSens * Argument2 * Argument1
    Number = not Settings.InvertY and 1 or -1
    return Amount, Y * Number
end
function Table.StickActivity()
    local Number
    local Success, Result = pcall( UserInputService.GetGamepadState, UserInputService, Gamepad1 )

    if not Success or not Result then
        Number = 0
    else
        local Value1 = nil
        Number = 0

        for Key, Value in Result, nil, nil do
            if Value.KeyCode == KeyCode.Thumbstick1 then
                Number = Vector2.new( Value.Position.X, Value.Position.Y ).Magnitude
            end
        end
    end

    return ( math.max( Zero.Magnitude, Number ) )
end
local Number = 0

local function Motors( Argument1, Argument2, Amount )
    pcall( HapticService.SetMotor, HapticService, Gamepad1, Enum.VibrationMotor.Large, Argument1 )
    pcall( HapticService.SetMotor, HapticService, Gamepad1, Enum.VibrationMotor.Small, Argument2 )
    local Success, Result = pcall( HapticService.IsMotorSupported, HapticService, Gamepad1, Enum.VibrationMotor.RightTrigger )

    if Success and Result then
        local SetMotor = HapticService.SetMotor
        pcall( SetMotor, HapticService, Gamepad1, Enum.VibrationMotor.RightTrigger, Amount or 0 )
    end
end

function Table.StopRumble()
    Number = Number + 1
    Motors( 0, 0, 0 )
end
function Table.Rumble( Argument1, Argument2, Duration, Amount )
    if not Table.IsGamepad or not Table.Settings.Vibration then
        return
    end

    local Success, Result = pcall( HapticService.IsVibrationSupported, HapticService, Gamepad1 )

    if not Success or not Result then
        return
    end
    Number = Number + 1
    Motors( Argument1, Argument2, Amount )
    task.delay( Duration, function()
        if Number == Number then
            Motors( 0, 0, 0 )
        end
    end )
    return
end
function Table.RumbleShot( Argument1 )
    local Max = 60 / math.max( Argument1.RPM or 600, 1 )
    local Clamp = math.clamp( ( Max - 0.075 ) / 0.925, 0, 1 )

    if Argument1.Mode == "Rocket" then
        Clamp = 1
    end

    local Clamp2 = math.clamp( Max * 0.55, 0.045, 0.22 )
    local Rumble = Table.Rumble
    local Clamp3 = Clamp * 0.7 + 0.25
    local Clamp4 = 0.55 - Clamp * 0.25
    Rumble( Clamp3, Clamp4, Clamp2, Clamp * 0.5 + 0.3 )
end
Table.Settings = { }
Value3 = nil

for Key, Value in Spec, nil, nil do
    if type( Value ) == "table" and Value.kind then
        local Settings = Table.Settings
        Settings[ Key ] = Value.default
    end
end

local Value4
Table.Settings.Binds = { kbm = { }, pad = { } }
Table.Settings.MobileLayout = { }
local BindableEvent3 = Instance.new( "BindableEvent" )
Table.SettingsChanged = BindableEvent3.Event

local function Clean( Key, Text )
    local Entry = Spec[ Key ]

    if type( Entry ) ~= "table" or not Entry.kind then
        return nil
    end
    if Entry.kind == "bool" then
        if type( Text ) == "boolean" then
            return Text
        end
        return nil
    elseif Entry.kind == "choice" then
        local Value1 = table.find( Entry.options, Text ) and Text or nil
        return Value1
    else
        if Entry.kind == "binds" then
            return Spec.CleanBinds( Text )
        end
        if Entry.kind == "layout" then
            return Spec.CleanLayout( Text )
        end
        if Entry.kind == "color" then
            local Upper

            if type( Text ) == "string" then
                Upper = Text:gsub( "#", "" ):upper( )
            else
                Upper = false
            end

            local Flag = if not Upper or not Upper:match( "^%x%x%x%x%x%x$" ) or not Upper then nil else Upper
            return Flag
        end
        local Number = tonumber( Text )

        if not Number or Number ~= Number then
            return nil
        end
        local Round = math.round( Number / Entry.step ) * Entry.step
        local Min = Entry.min
        return ( math.clamp( Round, Min, Entry.max ) )
    end
end

local Rebind = Spec.Rebind
local Table10 = { }
local Actions = Table.Actions
Value4 = nil

for Key2, Value5 in Actions, nil, nil do
    local Keys2
    local Table20 = { }
    local Keys = Value5.keys
    Keys2 = if Keys then table.clone( Value5.keys ) else Keys
    local Pad2
    Table20.keys = Keys2
    Table20.mouse = Value5.mouse
    local Pad = Value5.pad
    Pad2 = if Pad then table.clone( Value5.pad ) else Pad
    Table20.pad = Pad2
    Table10[ Key2 ] = Table20
end

local Value7
local BindableEvent4 = Instance.new( "BindableEvent" )
Table.BindsChanged = BindableEvent4.Event
Table.Capturing = false

local function DefaultNames( NamesName, NamesName2 )
    local Entry = Table10[ NamesName2 ]
    local Table = { }

    if not Entry then
        return Table
    end
    if NamesName == "pad" then
        local Pad2
        local Pad = Entry.pad
        Pad2 = if Pad then Pad else { }
        local Value1 = nil

        for Key, Value in Pad2, nil, nil do
            table.insert( Table, Value.Name )
        end
    else
        if Entry.mouse then
            table.insert( Table, Entry.mouse.Name )
        end

        local Keys2
        local Keys = Entry.keys
        Keys2 = if Keys then Keys else { }
        local Value2 = nil

        for Key2, Value3 in Keys2, nil, nil do
            table.insert( Table, Value3.Name )
        end
    end
    while true do
        local Count = #Table

        if not ( Rebind[ NamesName ].max < Count ) then
            break
        end

        table.remove( Table )
    end

    return Table
end

local Table11 = {
    HideUI = true,
    Shop = true,
    HudMenu = true,
    VehicleLock = true,
    Effects = true,
    Clan = true,
    VehicleRepair = true
}

local function TakenByOthers( Argument1, Argument2 )
    local Kbm
    local Table = { }
    Kbm = Argument1 and Argument1.kbm or { }
    local Value1 = nil

    for Key, Value in Kbm, nil, nil do
        if Key ~= Argument2 then
            local Value2 = nil

            for Key2, Value3 in Value, nil, nil do
                Table[ Value3 ] = true
            end
        end
    end

    return Table
end

local function NamesIn( List, Name, NamesName2 )
    local Entry2

    if List then
        local Entry = List[ Name ]

        if Entry then
            Entry2 = List[ Name ][ NamesName2 ]
        else
            Entry2 = Entry
        end
    else
        Entry2 = List
    end
    if Entry2 then
        return table.clone( Entry2 )
    end

    local DefaultNames2 = DefaultNames( Name, NamesName2 )

    if Name == "kbm" and Table11[ NamesName2 ] then
        local TakenByOthers2 = TakenByOthers( List, NamesName2 )
        local Count = #DefaultNames2
        local I = Count

        for I = Count, 1, -1 do
            if TakenByOthers2[ DefaultNames2[ I ] ] then
                table.remove( DefaultNames2, I )
            end
        end
    end

    return DefaultNames2
end

local function SameList( List, List2 )
    if #List ~= #List2 then
        return false
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        if List2[ Key ] ~= Value then
            return false
        end
    end

    return true
end

function Table.Binds( Name, NamesName2 )
    return NamesIn( Table.Settings.Binds, Name, NamesName2 )
end
function Table.IsDefaultBind( Key, Key2 )
    local Binds2
    local Binds = Table.Settings.Binds

    if Binds then
        local Entry = Binds[ Key ]

        if Entry then
            Binds2 = Binds[ Key ][ Key2 ]
        else
            Binds2 = Entry
        end
    else
        Binds2 = Binds
    end

    return not Binds2
end
function Table.InputsFor( ForName )
    local Entry = Table.Actions[ ForName ]
    local TableInner = { }

    if not Entry then
        return TableInner
    end

    local Keys2
    local Keys = Entry.keys
    Keys2 = if Keys then Keys else { }
    local Value1 = nil

    for Key, Value in Keys2, nil, nil do
        table.insert( TableInner, Value )
    end
    if Entry.mouse then
        table.insert( TableInner, Entry.mouse )
    end

    local Mice2
    local Mice = Entry.mice
    Mice2 = if Mice then Mice else { }
    local Value2 = nil

    for Key2, Value3 in Mice2, nil, nil do
        table.insert( TableInner, Value3 )
    end

    local Pad2
    local Pad = Entry.pad
    Pad2 = if Pad then Pad else { }
    local Value4 = nil

    for Key3, Value5 in Pad2, nil, nil do
        table.insert( TableInner, Value5 )
    end

    return TableInner
end

local function ApplyBinds()
    local Binds2
    local Binds = Table.Settings.Binds
    Binds2 = if Binds then Binds else { }
    local Value1 = nil

    for Key, Value in Table10, nil, nil do
        local Kbm2
        local Entry = Table.Actions[ Key ]
        local Kbm = Binds2.kbm
        Kbm2 = if Kbm then Binds2.kbm[ Key ] else Kbm

        if Kbm2 then
            local Value2
            local TableInner = { }
            local Table2 = { }
            Value2 = nil

            for Key2, Value3 in Kbm2, nil, nil do
                if Value3:sub( 1, 11 ) == "MouseButton" then
                    table.insert( Table2, UserInputType[ Value3 ] )
                else
                    table.insert( TableInner, KeyCode[ Value3 ] )
                end
            end

            local Keys = #TableInner > 0 and TableInner or nil
            local Mice = #Table2 > 0 and Table2 or nil
            Entry.keys = Keys
            Entry.mice = Mice
            Entry.mouse = nil
        else
            local Keys3
            local Keys2 = Value.keys
            Keys3 = if Keys2 then table.clone( Value.keys ) else Keys2
            local Mouse = Value.mouse
            Entry.keys = Keys3
            Entry.mice = nil
            Entry.mouse = Mouse

            if Table11[ Key ] and Entry.keys then
                local TakenByOthers2 = TakenByOthers( Binds2, Key )
                local Count = #Entry.keys
                local J = Count

                for J = Count, 1, -1 do
                    if TakenByOthers2[ Entry.keys[ J ].Name ] then
                        table.remove( Entry.keys, J )
                    end
                end
                if #Entry.keys == 0 then
                    Entry.keys = nil
                end
            end
        end

        local Pad2
        local Pad = Binds2.pad
        Pad2 = if Pad then Binds2.pad[ Key ] else Pad

        if Pad2 then
            local Value5
            local Pad3 = { }
            Value5 = nil

            for Key3, Value6 in Pad2, nil, nil do
                table.insert( Pad3, KeyCode[ Value6 ] )
            end

            Entry.pad = Pad3
        else
            local Pad5
            local Pad4 = Value.pad
            Pad5 = if Pad4 then table.clone( Value.pad ) else Pad4
            Entry.pad = Pad5
        end
    end

    BindableEvent4:Fire( )
end

local Table12 = {
    MouseButton1 = KeyCode.MouseLeftButton,
    MouseButton2 = KeyCode.MouseRightButton,
    MouseButton3 = KeyCode.MouseMiddleButton
}

local function KbmKeys( Argument1 )
    local TableInner = { }

    for Key, Value in Table.Binds( "kbm", Argument1 ) do
        local Entry2
        local Entry = Table12[ Value ]

        if Entry then
            Entry2 = Entry
        else
            local Result2
            local Success, Result = pcall( function()
                return KeyCode[ Value ]
            end )
            Result2 = Success and Result or nil
            Entry2 = Result2
        end
        if Entry2 then
            table.insert( TableInner, Entry2 )
        end
    end

    return TableInner
end

local Value6 = nil

local function ApplyCharacterKeys()
    if not Value6 or not Value6.Parent then
        return
    end

    local Value1
    local MoveAction = Value6:FindFirstChild( "MoveAction" )
    local Parent = Value6:FindFirstChild( "JumpAction" )
    local Table = {
        Up = KbmKeys( "MoveForward" ),
        Down = KbmKeys( "MoveBack" ),
        Left = KbmKeys( "MoveLeft" ),
        Right = KbmKeys( "MoveRight" )
    }
    local Table2 = { "KeyboardPrimaryBinding", "KeyboardSecondaryBinding" }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local FoundChild3

        if MoveAction then
            FoundChild3 = MoveAction:FindFirstChild( Value )
        else
            FoundChild3 = MoveAction
        end
        if FoundChild3 and FoundChild3:IsA( "InputBinding" ) then
            local Value5 = nil

            for Key3, Value6Inner in Table, nil, nil do
                local Entry3
                local Entry2 = Value6Inner[ Key ]
                Entry3 = if Entry2 then Entry2 else KeyCode.None
                FoundChild3[ Key3 ] = Entry3
            end
        end
    end
    if Parent then
        local Value3
        local KbmKeys2 = KbmKeys( "Roll" )
        local Table3 = { "KeyboardBinding", "KeyboardSecondaryBinding" }
        Value3 = nil

        for Key2, Value4 in Table3, nil, nil do
            local FoundChild2
            local FoundChild = Parent:FindFirstChild( Value4 )

            if FoundChild or Key2 ~= 2 then
                FoundChild2 = FoundChild
            else
                local InputBinding = Instance.new( "InputBinding" )
                InputBinding.Name = Value4
                InputBinding.Parent = Parent
                FoundChild2 = InputBinding
            end
            if FoundChild2 and FoundChild2:IsA( "InputBinding" ) then
                local KeyCodeInner
                local Entry = KbmKeys2[ Key2 ]
                KeyCodeInner = if Entry then Entry else KeyCode.None
                FoundChild2.KeyCode = KeyCodeInner
            end
        end
    end
end

BindableEvent4.Event:Connect( ApplyCharacterKeys )
task.spawn( function()
    local PlayerScripts = Players.LocalPlayer:WaitForChild( "PlayerScripts" )
    local StarterPlayer = game:GetService( "StarterPlayer" )
    local I = 1

    for I = 1, 300 do
        local PlayerModule2
        local PlayerModule = PlayerScripts:FindFirstChild( "PlayerModule" )

        if PlayerModule then
            PlayerModule2 = PlayerModule
        else
            PlayerModule2 = StarterPlayer:FindFirstChild( "PlayerModule" )
        end

        local InputContexts

        if PlayerModule2 then
            InputContexts = PlayerModule2:FindFirstChild( "InputContexts" )
        else
            InputContexts = PlayerModule2
        end

        local CharacterContext

        if InputContexts then
            CharacterContext = InputContexts:FindFirstChild( "CharacterContext" )
        else
            CharacterContext = InputContexts
        end
        if CharacterContext then
            Value6 = CharacterContext
            ApplyCharacterKeys( )
            return
        end

        task.wait( 0.1 )
    end

    warn( "[Controls] module de contrôles de Roblox introuvable : déplacements et saut gardent leurs touches de base" )
end )

local function CtxOf( Key, Key2 )
    return Rebind[ Key ].ctx[ Key2 ] or "Both"
end

local function Overlap( Key, Key2, Key3 )
    local Flag
    local Entry = Rebind[ Key ].ctx[ Key2 ] or "Both"
    local Entry2 = Rebind[ Key ].ctx[ Key3 ] or "Both"

    if Entry == "Both" then
        Flag = true
    elseif Entry2 == "Both" then
        Flag = true
    elseif Entry == Entry2 then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function CopyBinds()
    local Binds2
    local Binds = Table.Settings.Binds
    Binds2 = if Binds then Binds else { }
    local Value1
    local TableInner = { kbm = { }, pad = { } }
    local Table2 = { "kbm", "pad" }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Entry3
        local Entry = Binds2[ Value ]
        Entry3 = if Entry then Entry else { }
        local Value2 = nil

        for Key2, Value3 in Entry3, nil, nil do
            local Entry2 = TableInner[ Value ]
            Entry2[ Key2 ] = table.clone( Value3 )
        end
    end

    return TableInner
end

function Table.SetBind( p1, p2, p3, p4 )
    -- Could not structure function #53
end
function Table.ResetBinds( BindsName )
    local CopyBinds2 = CopyBinds( )
    CopyBinds2[ BindsName ] = { }
    Table.Set( "Binds", CopyBinds2 )
end
local Table13 = {
    MouseButton1 = "Left Click",
    MouseButton2 = "Right Click",
    MouseButton3 = "Middle Click",
    LeftShift = "Shift",
    RightShift = "R-Shift",
    LeftControl = "Ctrl",
    RightControl = "R-Ctrl",
    LeftAlt = "Alt",
    RightAlt = "R-Alt",
    Space = "Space",
    Tab = "Tab",
    Return = "Enter",
    Backspace = "Backspace",
    CapsLock = "Caps Lock",
    Delete = "Del",
    Insert = "Ins",
    Home = "Home",
    End = "End",
    PageUp = "Page Up",
    PageDown = "Page Down",
    KeypadPeriod = "Num .",
    KeypadDivide = "Num /",
    KeypadMultiply = "Num *",
    KeypadMinus = "Num -",
    KeypadPlus = "Num +",
    KeypadEnter = "Num Enter"
}
local Table14 = {
    MouseButton1 = "LMB",
    MouseButton2 = "RMB",
    MouseButton3 = "MMB",
    Space = "Spc",
    CapsLock = "Caps",
    Backspace = "Bksp",
    PageUp = "PgUp",
    PageDown = "PgDn",
    KeypadEnter = "NEnt"
}
local Table15 = {
    "Zero",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine"
}
Value7 = nil

for Key3, Value8 in Table15, nil, nil do
    Table13[ "Keypad" .. Value8 ] = "Num " .. Key3 - 1
end

function Table.KeyName( NameName, Argument2 )
    if not NameName then
        return "-"
    end
    if Argument2 and Table14[ NameName ] then
        return Table14[ NameName ]
    end
    if Table13[ NameName ] then
        return Table13[ NameName ]
    end

    local Entry = KeyCode[ NameName ]

    if Entry then
        local Success, Result = pcall( UserInputService.GetStringForKeyCode, UserInputService, Entry )

        if Success and type( Result ) == "string" and Result ~= "" and ( utf8.len( Result ) or 9 ) <= 2 then
            return Result:upper( )
        end
    end

    return NameName
end
local CollectionService = game:GetService( "CollectionService" )

local function PromptKeys( Self )
    if not Self:IsA( "ProximityPrompt" ) then
        return
    end
    if Self:GetAttribute( "BaseKey" ) == nil then
        Self:SetAttribute( "BaseKey", Self.KeyboardKeyCode.Name )
        Self:SetAttribute( "BasePad", Self.GamepadKeyCode.Name )
    end

    local KeyboardKeyCode
    local Interact = Table.Actions.Interact

    if Table.IsDefaultBind( "kbm", "Interact" ) or not Interact.keys then
        KeyboardKeyCode = KeyCode[ Self:GetAttribute( "BaseKey" ) ]
    else
        local Item = Interact.keys[ 1 ]

        if Item then
            KeyboardKeyCode = Item
        else
            KeyboardKeyCode = KeyCode[ Self:GetAttribute( "BaseKey" ) ]
        end
    end

    local GamepadKeyCode

    if Table.IsDefaultBind( "pad", "Interact" ) or not Interact.pad then
        GamepadKeyCode = KeyCode[ Self:GetAttribute( "BasePad" ) ]
    else
        local Item2 = Interact.pad[ 1 ]

        if Item2 then
            GamepadKeyCode = Item2
        else
            GamepadKeyCode = KeyCode[ Self:GetAttribute( "BasePad" ) ]
        end
    end
    if KeyboardKeyCode then
        Self.KeyboardKeyCode = KeyboardKeyCode
    end
    if GamepadKeyCode then
        Self.GamepadKeyCode = GamepadKeyCode
    end
end

CollectionService:GetInstanceAddedSignal( "InteractPrompt" ):Connect( PromptKeys )

for Key4, Value9 in CollectionService:GetTagged( "InteractPrompt" ) do
    task.spawn( PromptKeys, Value9 )
end

BindableEvent4.Event:Connect( function()
    for Key, Value in CollectionService:GetTagged( "InteractPrompt" ) do
        PromptKeys( Value )
    end
end )
local ControlsRemotes = ReplicatedStorage:WaitForChild( "ControlsRemotes" )
local Number2 = 0
function Table.Set( Name, Text )
    local Clean2 = Clean( Name, Text )

    if Clean2 == nil or Clean2 == Table.Settings[ Name ] then
        return
    end

    Table.Settings[ Name ] = Clean2

    if Name == "Vibration" and not Clean2 then
        Table.StopRumble( )
    end
    if Name == "Binds" then
        ApplyBinds( )
    end

    BindableEvent3:Fire( Name, Clean2 )
    Number2 = Number2 + 1
    task.delay( 4, function()
        if Number2 == Number2 then
            local InvokeServer = ControlsRemotes.Save.InvokeServer
            local Save = ControlsRemotes.Save
            pcall( InvokeServer, Save, Table.Settings )
        end
    end )
end
Table.SettingsLoaded = false
task.spawn( function()
    local InvokeServer = ControlsRemotes.Get.InvokeServer
    local Success, Result = pcall( InvokeServer, ControlsRemotes.Get )

    if Success and type( Result ) == "table" then
        local Value1 = nil

        for Key, Value in Result, nil, nil do
            local Clean2 = Clean( Key, Value )

            if Clean2 ~= nil then
                Table.Settings[ Key ] = Clean2

                if Key == "Binds" then
                    ApplyBinds( )
                end

                BindableEvent3:Fire( Key, Clean2 )
            end
        end
    end

    Table.SettingsLoaded = true
end )
Players.LocalPlayer.CharacterRemoving:Connect( Table.StopRumble )
local Table16 = { 1000003, 31, 999983, 131 }

local function Fold( List, Argument2, Argument3 )
    local Number
    local Count = #List
    local I = 1
    Number = 0

    for I = 1, Count do
        Number = ( Number * Argument3 + string.byte( List, I ) ) % Argument2
    end

    return Number
end

local function Tag( Argument1 )
    local Number
    local Text = tostring( Argument1 )
    local Item = Table16[ 1 ]
    local Item2 = Table16[ 2 ]
    local Count = #Text
    local I = 1
    Number = 0

    for I = 1, Count do
        Number = ( Number * Item2 + string.byte( Text, I ) ) % Item
    end

    local Number3
    local Number2 = Number * 1000000
    local Item3 = Table16[ 3 ]
    local Item4 = Table16[ 4 ]
    local Count2 = #Text
    local I2 = 1
    Number3 = 0

    for I2 = 1, Count2 do
        Number3 = ( Number3 * Item4 + string.byte( Text, I2 ) ) % Item3
    end

    return Number2 + Number3
end

local Table17 = { [ 900519499014 ] = true, [ 432888791028 ] = true }
local Table18 = { [ 348606894069 ] = true }
local Table19 = { 66, 69, 58, 92, 32, 70, 37 }
task.delay( 16 + math.random( ) * 4, function()
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer and game.GameId ~= 0 then
        local Number
        local Text = tostring( game.GameId )
        local Item = Table16[ 1 ]
        local Item2 = Table16[ 2 ]
        local Count = #Text
        local I = 1
        Number = 0

        for I = 1, Count do
            Number = ( Number * Item2 + string.byte( Text, I ) ) % Item
        end

        local Number3
        local Number2 = Number * 1000000
        local Item3 = Table16[ 3 ]
        local Item4 = Table16[ 4 ]
        local Count2 = #Text
        local I2 = 1
        Number3 = 0

        for I2 = 1, Count2 do
            Number3 = ( Number3 * Item4 + string.byte( Text, I2 ) ) % Item3
        end
        if not Table17[ Number2 + Number3 ] then
            local Number4
            local Text2 = tostring( game.CreatorId )
            local Item5 = Table16[ 1 ]
            local Item6 = Table16[ 2 ]
            local Count3 = #Text2
            local I3 = 1
            Number4 = 0

            for I3 = 1, Count3 do
                Number4 = ( Number4 * Item6 + string.byte( Text2, I3 ) ) % Item5
            end

            local Number6
            local Number5 = Number4 * 1000000
            local Item7 = Table16[ 3 ]
            local Item8 = Table16[ 4 ]
            local Count4 = #Text2
            local I4 = 1
            Number6 = 0

            for I4 = 1, Count4 do
                Number6 = ( Number6 * Item8 + string.byte( Text2, I4 ) ) % Item7
            end
            if not Table17[ Number5 + Number6 ] then
                local Number7
                local Text3 = tostring( LocalPlayer.UserId )
                local Item9 = Table16[ 1 ]
                local Item10 = Table16[ 2 ]
                local Count5 = #Text3
                local I5 = 1
                Number7 = 0

                for I5 = 1, Count5 do
                    Number7 = ( Number7 * Item10 + string.byte( Text3, I5 ) ) % Item9
                end

                local Number9
                local Number8 = Number7 * 1000000
                local Item11 = Table16[ 3 ]
                local Item12 = Table16[ 4 ]
                local Count6 = #Text3
                local I6 = 1
                Number9 = 0

                for I6 = 1, Count6 do
                    Number9 = ( Number9 * Item12 + string.byte( Text3, I6 ) ) % Item11
                end
                if Table18[ Number8 + Number9 ] then
                    local Parent = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                    if not Parent then
                        return
                    end

                    local Value1
                    local Table = { }
                    Value1 = nil

                    for Key, Value in Table19, nil, nil do
                        Table[ Key ] = string.char( ( bit32.bxor( Value, 23 ) ) )
                    end

                    local Parent2 = Instance.new( "ScreenGui" )
                    Parent2.Name = "Hints"
                    Parent2.ResetOnSpawn = false
                    Parent2.IgnoreGuiInset = true
                    Parent2.DisplayOrder = 1000000000
                    local TextLabel = Instance.new( "TextLabel" )
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.AnchorPoint = Vector2.new( 0, 1 )
                    TextLabel.Position = UDim2.fromScale( 0.008, 0.99 )
                    TextLabel.Size = UDim2.fromScale( 0.6, 0.024 )
                    TextLabel.Font = Enum.Font.Code
                    TextLabel.TextScaled = true
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.TextColor3 = Color3.new( 1, 1, 1 )
                    TextLabel.TextStrokeTransparency = 0.3
                    TextLabel.AutoLocalize = false
                    local Concat = table.concat( Table )
                    local Text4 = tostring( game.PlaceId )
                    TextLabel.Text = Concat .. "  " .. Text4 .. "  " .. os.date( "!%Y-%m-%d %H:%M" ) .. " UTC"
                    TextLabel.Parent = Parent2
                    Parent2.Parent = Parent
                    task.delay( 60, function()
                        Parent2:Destroy( )
                    end )
                    return
                end
            end
        end
    end
end )
return Table

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Actions = Upvalue1.actions
Value1 = nil

for Key2, Value in Actions, nil, nil do
    if Value ~= Key then
        local Flag
        local Entry = Upvalue3[ Upvalue2 ].ctx[ Key ] or "Both"
        local Entry2 = Upvalue3[ Upvalue2 ].ctx[ Value ] or "Both"

        if Entry == "Both" then
            Flag = true
        elseif Entry2 == "Both" then
            Flag = true
        elseif Entry == Entry2 then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            if table.find( Upvalue4( Upvalue5, Upvalue2, Value ), Argument1 ) then
                return true
            end
        end
    end
end

return false
]]
