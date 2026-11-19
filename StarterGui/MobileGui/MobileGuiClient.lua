-- StarterGui.MobileGui.MobileGuiClient
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
local UserInputService = game:GetService( "UserInputService" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local MobileLayout = require( ReplicatedStorage:WaitForChild( "Controls" ):WaitForChild( "MobileLayout" ) )
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
local Right = Parent:WaitForChild( "Right" )
local Table = { }

for Key, Value in Parent:GetChildren( ) do
    if Value:IsA( "GuiObject" ) then
        table.insert( Table, Value )
        Value.Visible = false
    end
end

Parent.Enabled = true
local IsStudio = RunService:IsStudio( )
local Touch = Enum.UserInputType.Touch
local MouseButton1 = Enum.UserInputType.MouseButton1

local function FireAimsOn()
    local Flag = Controls.Settings.FireAims ~= false and true or false
    return Flag
end

local Table2 = { }
local Table3 = { }
local Flag = false
local Flag2 = false
local Flag3 = false
local Number = 0
local Number2 = 0
local Flag4 = false

local function ShowOnPC()
    local Captured

    if IsStudio then
        if Parent:GetAttribute( "ShowOnPC" ) == true then
            Captured = true
        else
            Captured = false
        end
    else
        Captured = IsStudio
    end

    return Captured
end

local function Attr( Object, Attribute, Argument3 )
    local Attribute2 = Object:GetAttribute( Attribute )

    if Attribute2 == nil then
        return Argument3
    end
    return Attribute2
end

local function HeldTool()
    local Character2
    local Character = LocalPlayer.Character
    Character2 = if Character then Character:FindFirstChildOfClass( "Tool" ) else Character
    return Character2
end

local function IsSniper( Object )
    local Flag

    if type( Object and WeaponData[ Object:GetAttribute( "Weapon" ) or "" ] ) == "table" then
        if type( ( Object and WeaponData[ Object:GetAttribute( "Weapon" ) or "" ] ).Handling ) == "table" then
            if ( Object and WeaponData[ Object:GetAttribute( "Weapon" ) or "" ] ).Handling.Scope == nil then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local function ShowPressed( Argument1, Visible )
    if Argument1.pressed and Argument1.pressed.Visible ~= Visible then
        Argument1.pressed.Visible = Visible
    end
end

local function SyncAim()
    local Press = Controls.Press
    local Value1
    Press( "Aim", Flag or Flag2 or Flag3 )
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value.action == "Aim" then
            local Visible

            if Flag then
                Visible = Flag
            elseif Flag3 then
                Visible = Flag3
            elseif next( Value.inputs ) == nil then
                Visible = false
            else
                Visible = true
            end
            if Value.pressed and Value.pressed.Visible ~= Visible then
                Value.pressed.Visible = Visible
            end
        end
    end
end

local function SniperShot( Argument1 )
    Number = Number + 1
    local LastShot = ClientState.LastShot
    Controls.Press( "Fire", true )
    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < 0.3 do
            if ClientState.LastShot ~= LastShot then
                break
            end

            local Character2
            local Character = LocalPlayer.Character
            Character2 = if Character then Character:FindFirstChildOfClass( "Tool" ) else Character

            if Character2 ~= Argument1 then
                break
            end

            RunService.Heartbeat:Wait( )
        end

        Controls.Press( "Fire", false )

        if Number == Number then
            Flag3 = false
            SyncAim( )
            return
        end
        return
    end )
end

local Table4 = {
    DriveGas = true,
    DriveReverse = true,
    DriveBrake = true,
    DriveWheelie = true
}
local Table5 = { DriveGas = "DriveReverse", DriveReverse = "DriveGas" }

local function Unlatch( Argument1 )
    if not Argument1.latched then
        return
    end

    Argument1.latched = nil

    if Argument1.pressed and Argument1.pressed.Visible ~= false then
        Argument1.pressed.Visible = false
    end

    local Press = Controls.Press
    Press( Argument1.action, false )
end

local ProximityPromptService = game:GetService( "ProximityPromptService" )
local Table6 = { }
ProximityPromptService.PromptShown:Connect( function( Key )
    Table6[ Key ] = true
end )
ProximityPromptService.PromptHidden:Connect( function( Key )
    Table6[ Key ] = nil
end )

local function PromptPos( Value )
    local Parent = Value.Parent

    if not Parent then
        return nil
    end
    if Parent:IsA( "Attachment" ) then
        return Parent.WorldPosition
    end
    if Parent:IsA( "BasePart" ) then
        return Parent.Position
    end
    if Parent:IsA( "Model" ) then
        return Parent:GetPivot( ).Position
    end
    return nil
end

local function FindInteraction()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not HumanoidRootPart then
        return nil
    end

    local Value1, Magnitude, Value2
    Value1 = nil
    Magnitude = nil
    Value2 = nil

    for Value in Table6, nil, nil do
        if Value.Parent then
            if Value.Enabled then
                local Magnitude2
                local PromptPos2 = PromptPos( Value )
                Magnitude2 = if PromptPos2 then ( PromptPos2 - HumanoidRootPart.Position ).Magnitude else PromptPos2

                if Magnitude2 then
                    if not Magnitude or Magnitude2 < Magnitude then
                        Magnitude = Magnitude2
                        Value2 = Value
                    end
                end
            end
        else
            Table6[ Value ] = nil
        end
    end

    local HoodLootNear2
    local HoodLootNear = ClientState.HoodLootNear

    if HoodLootNear then
        HoodLootNear2 = ClientState.HoodLootNear( )
    else
        HoodLootNear2 = HoodLootNear
    end
    if HoodLootNear2 then
        if not Magnitude or HoodLootNear2 <= Magnitude then
            return "loot", HoodLootNear2
        end
    end

    return Value2, Magnitude
end

local function InteractPress( Argument1 )
    local Holding = FindInteraction( )

    if Holding == "loot" then
        ClientState.HoodLootNow( )
        return
    end
    if Holding then
        Argument1.holding = Holding
        Holding:InputHoldBegin( )
    end
end

local function InteractRelease( Argument1 )
    local Holding = Argument1.holding
    Argument1.holding = nil

    if Holding and Holding.Parent then
        Holding:InputHoldEnd( )
    end
end

local Callback = nil

local function Press( Argument1, Key )
    if MobileLayout.Editing then
        return
    end

    local Button = Argument1.button
    local Action = Argument1.action

    if Key.UserInputType == Touch and Controls.Settings.ButtonsMoveCamera ~= false then
        Controls.LookTouch( Key )
    end
    if Action == "Interact" then
        Argument1.inputs[ Key ] = true

        if Argument1.pressed and Argument1.pressed.Visible ~= true then
            Argument1.pressed.Visible = true
        end
        if not Argument1.holding then
            local Holding = FindInteraction( )

            if Holding == "loot" then
                ClientState.HoodLootNow( )
                return
            end
            if Holding then
                Argument1.holding = Holding
                Holding:InputHoldBegin( )
            end
        end

        return
    end
    local Mode = MobileLayout.Mode( Button )

    if Table5[ Action ] then
        local Value1 = nil

        for Key2, Value in Table2, nil, nil do
            if Value.action == Table5[ Action ] then
                if Value.latched then
                    Value.latched = nil

                    if Value.pressed and Value.pressed.Visible ~= false then
                        Value.pressed.Visible = false
                    end

                    local Press = Controls.Press
                    Press( Value.action, false )
                end
            end
        end
    end
    if Mode ~= "t" or not Table4[ Action ] then
        if Action == "Aim" then
            local Tool
            local Character = LocalPlayer.Character

            if Character then
                Tool = Character:FindFirstChildOfClass( "Tool" )
            else
                Tool = Character
            end

            local FlagInner
            local SniperReleaseFire = Button:GetAttribute( "SniperReleaseFire" )
            FlagInner = if SniperReleaseFire == nil then true else SniperReleaseFire

            if not FlagInner or not ClientState.Equipped then
                if Mode == "t" then
                    Flag = not Flag
                else
                    Argument1.inputs[ Key ] = true
                    Flag = true
                end
            else
                local Character2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
                local Flag2Inner

                if type( Character2 ) == "table" then
                    if type( Character2.Handling ) == "table" then
                        if Character2.Handling.Scope == nil then
                            Flag2Inner = false
                        else
                            Flag2Inner = true
                        end
                    else
                        Flag2Inner = false
                    end
                else
                    Flag2Inner = false
                end
                if Flag2Inner then
                    Argument1.inputs[ Key ] = { sniper = Tool }
                    Number = Number + 1
                    Flag3 = true
                elseif Mode == "t" then
                    Flag = not Flag
                else
                    Argument1.inputs[ Key ] = true
                    Flag = true
                end
            end

            SyncAim( )
            return
        end
        if Action == "Sprint" then
            if Flag or Flag3 or Flag2 or ClientState.Aiming then
                Callback( )
            end
        end

        Argument1.inputs[ Key ] = true

        if Argument1.pressed and Argument1.pressed.Visible ~= true then
            Argument1.pressed.Visible = true
        end
        if Action == "Fire" and ClientState.Equipped then
            local Flag3Inner = Controls.Settings.FireAims ~= false and true or false

            if Flag3Inner then
                Number2 = Number2 + 1
                Flag2 = true
                SyncAim( )
            else
                local Flag4
                local AimWhileFiring = Button:GetAttribute( "AimWhileFiring" )
                Flag4 = if AimWhileFiring == nil then true else AimWhileFiring

                if Flag4 then
                    Number2 = Number2 + 1
                    Flag2 = true
                    SyncAim( )
                end
            end
        end

        local Flag5
        local Press3 = Controls.Press
        Flag5 = Mode == "h" and true or false
        Press3( Action, true, Flag5 )
        return
    elseif Argument1.latched then
        if not Argument1.latched then
            return
        end

        Argument1.latched = nil

        if Argument1.pressed and Argument1.pressed.Visible ~= false then
            Argument1.pressed.Visible = false
        end

        local Press2 = Controls.Press
        Press2( Argument1.action, false )
        return
    else
        Argument1.latched = true

        if Argument1.pressed and Argument1.pressed.Visible ~= true then
            Argument1.pressed.Visible = true
        end

        Controls.Press( Action, true )
        return
    end
end

local function Release( Value, Key, Argument3 )
    local Entry = Value.inputs[ Key ]

    if not Entry then
        return
    end

    Value.inputs[ Key ] = nil

    if next( Value.inputs ) then
        return
    end
    if Value.action == "Interact" then
        if Value.pressed and Value.pressed.Visible ~= false then
            Value.pressed.Visible = false
        end

        local Holding = Value.holding
        Value.holding = nil

        if Holding and Holding.Parent then
            Holding:InputHoldEnd( )
        end

        return
    end
    if Value.action == "Aim" then
        if type( Entry ) == "table" then
            if Argument3 or not Flag3 then
                Flag3 = false
            else
                local Character2
                local Character = LocalPlayer.Character
                Character2 = if Character then Character:FindFirstChildOfClass( "Tool" ) else Character

                if Character2 == Entry.sniper then
                    local Sniper = Entry.sniper
                    Number = Number + 1
                    local LastShot = ClientState.LastShot
                    Controls.Press( "Fire", true )
                    task.spawn( function()
                        local Clock = os.clock( )

                        while os.clock( ) - Clock < 0.3 do
                            if ClientState.LastShot ~= LastShot then
                                break
                            end

                            local Character2
                            local Character = LocalPlayer.Character
                            Character2 = if Character then Character:FindFirstChildOfClass( "Tool" ) else Character

                            if Character2 ~= Sniper then
                                break
                            end

                            RunService.Heartbeat:Wait( )
                        end

                        Controls.Press( "Fire", false )

                        if Number == Number then
                            Flag3 = false
                            SyncAim( )
                            return
                        end
                        return
                    end )
                else
                    Flag3 = false
                end
            end
        else
            Flag = false
        end

        SyncAim( )
        return
    end
    local Visible

    if Value.action == "Sprint" then
        if ClientState.Sprinting == true then
            Visible = true
        else
            Visible = false
        end
    else
        Visible = false
    end
    if Value.pressed and Value.pressed.Visible ~= Visible then
        Value.pressed.Visible = Visible
    end

    local Press = Controls.Press
    Press( Value.action, false )

    if Value.action == "Fire" and Flag2 then
        Number2 = Number2 + 1
        Flag2 = false
        SyncAim( )
    end

    return
end

local function Drop( Argument1 )
    if Argument1.latched then
        Argument1.latched = nil

        if Argument1.pressed and Argument1.pressed.Visible ~= false then
            Argument1.pressed.Visible = false
        end

        local Press = Controls.Press
        Press( Argument1.action, false )
    end
    if next( Argument1.inputs ) then
        local Value1
        local Table = { }
        local Inputs = Argument1.inputs
        Value1 = nil

        for Value in Inputs, nil, nil do
            table.insert( Table, Value )
        end

        local Value2 = nil

        for Key, Value3 in Table, nil, nil do
            Release( Argument1, Value3, true )
        end
    end
    if Argument1.action == "Aim" then
        if Flag or Flag3 then
            Flag = false
            Flag3 = false
            SyncAim( )
        end
    end
end

Callback = function()
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value.action ~= "Aim" then
            if Value.action ~= "Fire" or not Flag2 then
                continue
            end
        end

        Drop( Value )
    end

    Flag = false
    Flag3 = false
    Flag2 = false
    Number = Number + 1
    Number2 = Number2 + 1
    SyncAim( )
end

local function ReleaseAll()
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        table.clear( Value.inputs )
        Value.latched = nil

        if Value.holding then
            local Holding = Value.holding
            Value.holding = nil

            if Holding and Holding.Parent then
                Holding:InputHoldEnd( )
            end
        end
        if Value.pressed and Value.pressed.Visible ~= false then
            Value.pressed.Visible = false
        end
    end

    Flag = false
    Flag2 = false
    Flag3 = false
    Number = Number + 1
    Number2 = Number2 + 1
    Controls.ReleaseAll( )
end

local Table7 = { Global = true, OnFoot = true, Weapon = true, Car = true }

local function GroupOf( Argument1 )
    local ParentInner = Argument1.Parent

    while ParentInner do
        if ParentInner == Parent then
            break
        end
        if Table7[ ParentInner.Name ] then
            return ParentInner
        end

        ParentInner = ParentInner.Parent
    end

    local Parent2 = Argument1

    while Parent2.Parent do
        if Parent2.Parent == Right then
            break
        end

        Parent2 = Parent2.Parent
    end

    local Parent3 = if Parent2.Parent ~= Right or Parent2 == Argument1 or not Parent2 then nil else Parent2
    return Parent3
end

for Key2, Value2 in Parent:GetDescendants( ) do
    if Value2:IsA( "GuiButton" ) and type( Value2:GetAttribute( "Action" ) ) == "string" then
        local Table12 = {
            button = Value2,
            action = Value2:GetAttribute( "Action" ),
            group = GroupOf( Value2 ),
            pressed = Value2:FindFirstChild( "Pressed" ),
            inputs = { }
        }
        table.insert( Table2, Table12 )

        if Table12.group then
            Table3[ Table12.group ] = true
        end
        if Table12.pressed and Table12.pressed.Visible ~= false then
            Table12.pressed.Visible = false
        end

        Value2.InputBegan:Connect( function( Key )
            if Key.UserInputState ~= Enum.UserInputState.Begin then
                return
            end
            if Key.UserInputType == Touch then
                Press( Table12, Key )
            elseif Key.UserInputType == MouseButton1 then
                local Captured

                if IsStudio then
                    if Parent:GetAttribute( "ShowOnPC" ) == true then
                        Captured = true
                    else
                        Captured = false
                    end
                else
                    Captured = IsStudio
                end
                if Captured then
                    Press( Table12, Key )
                end
            end
        end )
    end
end

local Value1
table.insert( Table, MobileLayout.Init( Parent, Table2 ) )
local Table8 = { }
Value1 = nil

for Key3, Value3 in Table2, nil, nil do
    if Value3.action == "Jump" then
        table.insert( Table8, Value3.button )
    end
end
if #Table8 > 0 then
    ClientState.MobileJump = true
    task.spawn( function()
        local Parent
        local PlayerScripts = LocalPlayer:WaitForChild( "PlayerScripts" )
        local StarterPlayer = game:GetService( "StarterPlayer" )
        local I = 1
        Parent = nil

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

            local JumpAction

            if CharacterContext then
                JumpAction = CharacterContext:FindFirstChild( "JumpAction" )
            else
                JumpAction = CharacterContext
            end
            if JumpAction then
                Parent = JumpAction
                break
            end

            task.wait( 0.1 )
            Parent = JumpAction
        end
        if not Parent then
            warn( "[MobileGui] saut du module de Roblox introuvable : le bouton Jump ne fait pas sauter" )
            return
        end

        local Value1 = nil

        for Key, Value in Table8, nil, nil do
            local Name = Key ~= 1 and "MobileGuiJump" .. Key or "MobileGuiJump"
            local InputBinding
            local FoundChild = Parent:FindFirstChild( Name )

            if FoundChild then
                InputBinding = FoundChild
            else
                InputBinding = Instance.new( "InputBinding" )
            end

            InputBinding.Name = Name
            InputBinding.UIButton = Value
            InputBinding.Parent = Parent
        end
    end )
    local Value4 = nil
    RunService.RenderStepped:Connect( function()
        if not Value4 or not Value4.Parent then
            local TouchGui
            local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

            if PlayerGui then
                TouchGui = PlayerGui:FindFirstChild( "TouchGui" )
            else
                TouchGui = PlayerGui
            end

            local JumpButton

            if TouchGui then
                JumpButton = TouchGui:FindFirstChild( "JumpButton", true )
            else
                JumpButton = TouchGui
            end

            local PlayerGui2 = if not JumpButton or not JumpButton:IsA( "GuiObject" ) or not JumpButton then nil else JumpButton
            Value4 = PlayerGui2
        end
        if Value4 and Value4.Visible then
            Value4.Visible = false
        end
    end )
end

UserInputService.TouchEnded:Connect( function( Key2 )
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        Release( Value, Key2 )
    end
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    if Argument1.UserInputType ~= MouseButton1 then
        return
    end

    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Value2
        local Table = { }
        local Inputs = Value.inputs
        Value2 = nil

        for Value3 in Inputs, nil, nil do
            if Value3.UserInputType == MouseButton1 then
                table.insert( Table, Value3 )
            end
        end

        local Value4 = nil

        for Key2, Value5 in Table, nil, nil do
            Release( Value, Value5 )
        end
    end
end )

local function OnTool( Object )
    if Object:IsA( "Tool" ) then
        task.defer( function()
            if not Flag then
                return
            end
            if ClientState.Equipped then
                local Tool
                local Character = LocalPlayer.Character

                if Character then
                    Tool = Character:FindFirstChildOfClass( "Tool" )
                else
                    Tool = Character
                end

                local Character2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
                local FlagInner

                if type( Character2 ) == "table" then
                    if type( Character2.Handling ) == "table" then
                        if Character2.Handling.Scope == nil then
                            FlagInner = false
                        else
                            FlagInner = true
                        end
                    else
                        FlagInner = false
                    end
                else
                    FlagInner = false
                end
                if FlagInner then
                    Flag = false
                else
                    Controls.Press( "Aim", false )
                end
            else
                Controls.Press( "Aim", false )
            end

            SyncAim( )
        end )
        return
    end
    return
end

local function OnCharacter( Argument1 )
    ReleaseAll( )
    Argument1.ChildAdded:Connect( OnTool )
    Argument1.ChildRemoved:Connect( OnTool )
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    local Character = LocalPlayer.Character
    ReleaseAll( )
    Character.ChildAdded:Connect( OnTool )
    Character.ChildRemoved:Connect( OnTool )
end

local function SetVisible( Argument1, Visible )
    if Argument1.Visible ~= Visible then
        Argument1.Visible = Visible
    end
end

local function GroupShown( ShownName, Argument2 )
    if ShownName == "Global" then
        return true
    end
    if ShownName == "OnFoot" then
        local NotSeated2
        local NotSeated = not Argument2.seated
        NotSeated2 = if NotSeated then not Argument2.menu else NotSeated
        return NotSeated2
    end
    if ShownName == "Weapon" then
        local Gear = ( Argument2.weapon or Argument2.gear ) and not Argument2.menu
        return Gear
    end
    if ShownName == "Car" then
        return Argument2.seated
    end
    return true
end

local function ButtonShown( ShownName, Argument2 )
    if ShownName == "Fire" then
        if Argument2.gun then
            local Flag

            if Argument2.aiming then
                local NotSniper = not Argument2.sniper

                if NotSniper then
                    Flag = not Argument2.menu
                else
                    Flag = NotSniper
                end
            else
                if Controls.Settings.FireAims == false then
                    Flag = false
                else
                    Flag = true
                end
                if Flag then
                    local NotSniper = not Argument2.sniper

                    if NotSniper then
                        Flag = not Argument2.menu
                    else
                        Flag = NotSniper
                    end
                end
            end

            return Flag
        end
        local Gear = ( Argument2.weapon or Argument2.gear ) and not Argument2.menu
        return Gear
    elseif ShownName == "Aim" then
        local Weapon2
        local Weapon = Argument2.weapon
        Weapon2 = if Weapon then not Argument2.menu else Weapon
        return Weapon2
    elseif ShownName == "Reload" then
        local Gun2
        local Gun = Argument2.gun
        Gun2 = if Gun then not Argument2.menu else Gun
        return Gun2
    elseif ShownName == "Crouch" or ShownName == "Sprint" or ShownName == "Jump" then
        local NotSeated2
        local NotSeated = not Argument2.seated
        NotSeated2 = if NotSeated then not Argument2.menu else NotSeated
        return NotSeated2
    else
        if ShownName == "DriveGas" or ShownName == "DriveReverse" or ShownName == "DriveBrake" then
            return Argument2.driver
        end
        if ShownName == "DriveWheelie" then
            local Driver2
            local Driver = Argument2.driver
            Driver2 = if Driver then Argument2.twoWheels else Driver
            return Driver2
        end
        if ShownName == "VehicleExit" then
            return Argument2.seated
        end
        if ShownName == "DropPlayer" then
            local Carrying2
            local Carrying = Argument2.carrying
            Carrying2 = if Carrying then not Argument2.menu else Carrying
            return Carrying2
        end
        if ShownName ~= "Interact" then
            return true
        end

        local Interact2
        local Interact = Argument2.interact
        Interact2 = if Interact then not Argument2.menu else Interact
        return Interact2
    end
end

local Table9 = { }
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local Table10 = { }

local function HideHuds( Argument1 )
    if not Argument1 and next( Table10 ) == nil then
        return
    end

    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if not PlayerGui then
        return
    end

    local Value1 = nil

    for Key, Value in Table9, nil, nil do
        local Find = Screens.Find( Value, PlayerGui )

        if Find then
            if not Argument1 or not Screens.IsShown( Find ) then
                if not Argument1 and Table10[ Find ] then
                    Table10[ Find ] = nil
                    Screens.SetShown( Find, true )
                end
            else
                Screens.SetShown( Find, false )
                Table10[ Find ] = true
            end
        end
    end
end

local Table11 = { }
RunService.Heartbeat:Connect( function()
    local Editing = MobileLayout.Editing

    if Editing then
        if Flag4 then
            ReleaseAll( )
        end

        local Value1
        Flag4 = false
        Value1 = nil

        for Key, Value in Table, nil, nil do
            if not Table3[ Value ] and Value.Visible ~= true then
                Value.Visible = true
            end
        end

        local Value2 = nil

        for Value3 in Table3, nil, nil do
            local Visible2 = MobileLayout.OnPage( Value3, Editing )

            if Value3.Visible ~= Visible2 then
                Value3.Visible = Visible2
            end
        end

        local Value4 = nil

        for Key2, Value5 in Table2, nil, nil do
            local Visible
            local Button = Value5.button
            local OnPage = MobileLayout.OnPage
            local OnPage2 = OnPage( Value5.group, Editing )

            if OnPage2 then
                Visible = MobileLayout.Usable( Value5.button )
            else
                Visible = OnPage2
            end
            if Button.Visible ~= Visible then
                Button.Visible = Visible
            end
        end

        return
    end
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Visible3
    local Enabled = Parent.Enabled

    if Enabled then
        if Controls.TouchMode( ) then
            if Humanoid == nil then
                Visible3 = false
            elseif Humanoid.Health > 0 then
                local NotWardrobeOpen = not ClientState.WardrobeOpen

                if NotWardrobeOpen then
                    local NotCaseRolling = not ClientState.CaseRolling

                    if NotCaseRolling then
                        Visible3 = not Controls.Locked
                    else
                        Visible3 = NotCaseRolling
                    end
                else
                    Visible3 = NotWardrobeOpen
                end
            else
                Visible3 = false
            end
        else
            if IsStudio then
                if Parent:GetAttribute( "ShowOnPC" ) == true then
                    Visible3 = true
                else
                    Visible3 = false
                end
            else
                Visible3 = IsStudio
            end
            if Visible3 then
                if Humanoid == nil then
                    Visible3 = false
                elseif Humanoid.Health > 0 then
                    local NotWardrobeOpen = not ClientState.WardrobeOpen

                    if NotWardrobeOpen then
                        local NotCaseRolling = not ClientState.CaseRolling

                        if NotCaseRolling then
                            Visible3 = not Controls.Locked
                        else
                            Visible3 = NotCaseRolling
                        end
                    else
                        Visible3 = NotWardrobeOpen
                    end
                else
                    Visible3 = false
                end
            end
        end
    else
        Visible3 = Enabled
    end

    local Value6 = nil

    for Key3, Value7 in Table, nil, nil do
        if Table3[ Value7 ] then
            if not Visible3 and Value7.Visible ~= false then
                Value7.Visible = false
            end
        elseif Value7.Visible ~= Visible3 then
            Value7.Visible = Visible3
        end
    end
    if Visible3 then
        local Tool
        Flag4 = true
        local Vehicle = ClientState.Vehicle
        local Character2 = LocalPlayer.Character

        if Character2 then
            Tool = Character2:FindFirstChildOfClass( "Tool" )
        else
            Tool = Character2
        end

        local Menu = ClientState.CursorFree == true and true or false
        local Gun
        Table11.menu = Menu
        Gun = ClientState.Equipped == true and true or false
        local Sniper
        Table11.gun = Gun
        HideHuds( Table11.gun )
        local Gun2 = Table11.gun

        if Gun2 then
            local Character3 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool

            if type( Character3 ) == "table" then
                if type( Character3.Handling ) == "table" then
                    if Character3.Handling.Scope == nil then
                        Sniper = false
                    else
                        Sniper = true
                    end
                else
                    Sniper = false
                end
            else
                Sniper = false
            end
        else
            Sniper = Gun2
        end

        local Aiming
        Table11.sniper = Sniper
        Aiming = ClientState.Aiming == true and true or false
        local Weapon
        Table11.aiming = Aiming
        local Gun3 = Table11.gun

        if Gun3 then
            Weapon = Gun3
        elseif ClientState.FistsReady == true then
            Weapon = true
        elseif Tool == nil then
            Weapon = false
        elseif Tool:GetAttribute( "Melee" ) == nil then
            Weapon = false
        else
            Weapon = true
        end

        local Gear
        Table11.weapon = Weapon

        if Tool == nil then
            Gear = false
        elseif Tool:GetAttribute( "Gear" ) == nil then
            Gear = false
        else
            Gear = true
        end

        local Seated
        Table11.gear = Gear
        Seated = Vehicle ~= nil and true or false
        local Driver
        Table11.seated = Seated

        if Vehicle == nil then
            Driver = false
        elseif Vehicle.Driver == true then
            Driver = true
        else
            Driver = false
        end

        local TwoWheels
        Table11.driver = Driver

        if Vehicle == nil then
            TwoWheels = false
        elseif Vehicle.TwoWheels == true then
            TwoWheels = true
        else
            TwoWheels = false
        end

        local Carrying
        Table11.twoWheels = TwoWheels
        Carrying = Character:GetAttribute( "Carrying" ) == true and true or false
        local Value8
        Table11.carrying = Carrying
        Table11.interact = false
        Value8 = nil

        for Key4, Value9 in Table2, nil, nil do
            if Value9.action == "Interact" then
                if MobileLayout.Usable( Value9.button ) then
                    local Interact = FindInteraction( ) ~= nil and true or false
                    Table11.interact = Interact
                    break
                end
            end
        end

        local Value10 = nil

        for Value11 in Table3, nil, nil do
            local Visible6
            local Name = Value11.Name

            if Name == "Global" then
                Visible6 = true
            elseif Name == "OnFoot" then
                local NotSeated = not Table11.seated

                if NotSeated then
                    Visible6 = not Table11.menu
                else
                    Visible6 = NotSeated
                end
            elseif Name == "Weapon" then
                if Table11.weapon or Table11.gear then
                    Visible6 = not Table11.menu
                else
                    Visible6 = Table11.gear
                end
            elseif Name == "Car" then
                Visible6 = Table11.seated
            else
                Visible6 = true
            end
            if Value11.Visible ~= Visible6 then
                Value11.Visible = Visible6
            end
        end

        local Value12 = nil

        for Key5, Value13 in Table2, nil, nil do
            local Visible4
            local ButtonShown2 = ButtonShown( Value13.action, Table11 )

            if ButtonShown2 then
                local Usable = MobileLayout.Usable( Value13.button )

                if Usable then
                    if Value13.group == nil then
                        Visible4 = true
                    else
                        Visible4 = Value13.group.Visible
                    end
                else
                    Visible4 = Usable
                end
            else
                Visible4 = ButtonShown2
            end

            local Button2 = Value13.button

            if Button2.Visible ~= Visible4 then
                Button2.Visible = Visible4
            end
            if not Visible4 then
                Drop( Value13 )
            end
            if Value13.action == "Sprint" then
                local Visible5

                if next( Value13.inputs ) == nil then
                    if ClientState.Sprinting == true then
                        Visible5 = true
                    else
                        Visible5 = false
                    end
                else
                    Visible5 = true
                end
                if Value13.pressed and Value13.pressed.Visible ~= Visible5 then
                    Value13.pressed.Visible = Visible5
                end
            end
            if Value13.latched and not Controls.IsVirtualDown( Value13.action ) then
                Value13.latched = nil

                if Value13.pressed and Value13.pressed.Visible ~= false then
                    Value13.pressed.Visible = false
                end
            end
        end

        return
    end
    if Flag4 then
        ReleaseAll( )
    end

    Flag4 = false
    HideHuds( false )
    return
end )
