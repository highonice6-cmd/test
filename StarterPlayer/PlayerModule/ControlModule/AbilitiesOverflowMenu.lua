-- StarterPlayer.PlayerModule.ControlModule.AbilitiesOverflowMenu
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local UserInputService = game:GetService( "UserInputService" )
local GuiService = game:GetService( "GuiService" )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "ConnectionUtil" )
local Get2 = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) ).get( Players.LocalPlayer )
local InputSlots = require( script.Parent:WaitForChild( "InputSlots" ) )
local AbilityButton = require( script.Parent:WaitForChild( "AbilityButton" ) )
local Table = { 28, 44 }
local Table2 = { 36, 56 }
local Table3 = { 16, 12 }
local Table4 = { 16, 12 }

local function IsPortrait()
    local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if not PlayerGui then
        return false
    end

    local Flag = PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait and true or false
    return Flag
end

local __index = { }
__index.__index = __index
function __index.new( ParentUIFrame )
    local Self = setmetatable( { }, __index )
    Self.parentUIFrame = ParentUIFrame
    Self.managedButtons = { }
    Self.created = false
    Self.enabled = false
    Self.enabledChangedEvent = Instance.new( "BindableEvent" )
    Self.selectionMode = false
    Self.selectedVisibleSlot = 1
    Self.numVisibleSlots = 0
    Self.abilityButtonsByVisibleSlot = { }
    Self.selectionRing = nil
    Self.activeActionSlot = nil
    Self.activeButton = nil
    Self.scrollHighlightDirection = "none"
    Self.connections = Get.new( )
    Self.inputFolder = nil
    Self.navContext = nil
    return Self
end
function __index.Enable( Self, Enabled )
    if Self.enabled == Enabled then
        return
    end

    Self.enabled = Enabled

    if Enabled and not Self.created then
        Self:Create( )
        Self.created = true
    end
    if not Enabled then
        Self:ExitSelectionMode( )
    end
    if Self.created then
        Self:UpdateInputMode( )
    end

    Self.enabledChangedEvent:Fire( )
end
function __index.CreateOverflowScrollButton( Argument1, Argument2 )
    local ImageButton = Instance.new( "ImageButton" )
    ImageButton.Name = "ScrollButton"
    ImageButton.BackgroundTransparency = 1
    ImageButton.Image = "rbxassetid://120193229129639"
    ImageButton.PressedImage = "rbxassetid://122643389561468"
    ImageButton.Parent = Argument1.parentUIFrame

    local function ResizeButton()
        local Flag2
        local X = Argument1.parentUIFrame.AbsoluteSize.x
        local Min = math.min( X, Argument1.parentUIFrame.AbsoluteSize.y )
        local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

        if PlayerGui then
            if PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
                Flag2 = true
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end

        local Flag = Min <= 500 and true or false
        local Captured = Flag and Table or Table2
        local Captured2 = Flag and Table3 or Table4
        local Number2 = not Flag and 10 or 8
        local Number = not Flag and 56 or 44
        local Item = Captured[ 1 ]
        local Item2 = Captured[ 2 ]
        local Item3 = Captured2[ 1 ]
        local Item4 = Captured2[ 2 ]
        local Item5 = 0.5 * ( Item2 - Item )
        local NumOverflowSlots = InputSlots.GetNumOverflowSlots( )
        local NumOverflowSlots2 = NumOverflowSlots * Number + ( NumOverflowSlots + 1 ) * Number2
        ImageButton.Size = UDim2.new( 0, Item, 0, Item2 )

        if Argument2 == "previous" then
            if Flag2 then
                local Amount = -Item3 - Item2 + Item5
                ImageButton.Position = UDim2.new( 1, Amount, 0, Item4 + Item + NumOverflowSlots2 - Item5 )
                ImageButton.Rotation = 270
                return
            end
            ImageButton.Position = UDim2.new( 1, -Item3 - 2 * Item - NumOverflowSlots2, 0, Item4 )
            ImageButton.Rotation = 0
            return
        elseif Flag2 then
            local Amount2 = -Item3 - Item2 + Item5
            ImageButton.Position = UDim2.new( 1, Amount2, 0, Item4 - Item5 )
            ImageButton.Rotation = 90
            return
        else
            ImageButton.Position = UDim2.new( 1, -Item3 - Item, 0, Item4 )
            ImageButton.Rotation = 180
            return
        end
    end

    ResizeButton( )
    local New = Get.new( )
    New:trackConnection( "ParentResize", Argument1.parentUIFrame:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( ResizeButton ) )
    ImageButton.Activated:Connect( function()
        if Argument2 == "previous" then
            InputSlots.setOverflowScrollIndex( InputSlots.getOverflowScrollIndex( ) + 1 )
            return
        end
        InputSlots.setOverflowScrollIndex( InputSlots.getOverflowScrollIndex( ) - 1 )
        return
    end )
    ImageButton.Destroying:Connect( function()
        New:disconnectAll( )
    end )
    ImageButton.Selectable = false

    if __index.IsGamepad( ) then
        ImageButton.Active = false
        ImageButton.AutoButtonColor = false
    end

    return ImageButton
end
function __index.SetScrollHighlight( Self, ScrollHighlightDirection )
    if Self.scrollHighlightDirection == ScrollHighlightDirection then
        return
    end

    Self.scrollHighlightDirection = ScrollHighlightDirection

    if Self.created then
        Self:CreateButtons( )
    end
end
function __index.GetScrollDirectionForMove( Argument1, Name )
    if not Argument1.selectionMode or Argument1.activeActionSlot or Name == "none" then
        return "none"
    end

    local Number = Name ~= "previous" and -1 or 1
    local Max = math.max( 0, #InputSlots.GetAbilitiesInOverflow( ) - InputSlots.GetNumOverflowSlots( ) )
    local OverflowScrollIndex = InputSlots.getOverflowScrollIndex( )
    local SelectedVisibleSlot = Argument1.selectedVisibleSlot + Number

    if SelectedVisibleSlot < 1 and OverflowScrollIndex > 0 then
        return "next"
    end
    if not ( Argument1.numVisibleSlots < SelectedVisibleSlot ) or not ( OverflowScrollIndex < Max ) then
        return "none"
    end
    return "previous"
end
function __index.IsGamepad()
    local Flag
    Flag = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and true or false
    return Flag
end
function __index.IsKeyboardMouse()
    local Flag
    Flag = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and true or false
    return Flag
end
function __index.SupportsSelection()
    local IsGamepad2
    local IsGamepad = __index.IsGamepad( )
    IsGamepad2 = if IsGamepad then IsGamepad else __index.IsKeyboardMouse( )
    return IsGamepad2
end
function __index.EnsureSelectionRing( Argument1 )
    if Argument1.selectionRing then
        return
    end
    local Parent = Instance.new( "Frame" )
    Parent.Name = "SelectionRing"
    Parent.BackgroundTransparency = 1
    Parent.Size = UDim2.new( 1, 8, 1, 8 )
    Parent.Position = UDim2.new( 0, -4, 0, -4 )
    local UICorner = Instance.new( "UICorner" )
    UICorner.CornerRadius = UDim.new( 1, 0 )
    UICorner.Parent = Parent
    local UIStroke = Instance.new( "UIStroke" )
    UIStroke.Thickness = 3
    UIStroke.Color = Color3.new( 1, 1, 1 )
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = Parent
    Argument1.selectionRing = Parent
    return
end
function __index.EnsureInputObjects( Argument1 )
    if Argument1.inputFolder then
        return
    end

    local AbilitiesOverflowInput = script:FindFirstChild( "AbilitiesOverflowInput" )

    if AbilitiesOverflowInput then
        AbilitiesOverflowInput:Destroy( )
    end

    local Parent = Instance.new( "Folder" )
    Parent.Name = "AbilitiesOverflowInput"
    local NavContext = Instance.new( "InputContext" )
    NavContext.Name = "AbilitiesOverflowNavContext"
    NavContext.Priority = 500
    NavContext.Sink = true
    NavContext.Enabled = false
    NavContext.Parent = Parent

    local function CreateNavAction( Name, List )
        local Value1
        local Parent = Instance.new( "InputAction" )
        Parent.Name = Name
        Parent.Type = Enum.InputActionType.Bool
        Parent.Parent = NavContext
        Value1 = nil

        for Key, Value in List, nil, nil do
            local InputBinding = Instance.new( "InputBinding" )
            InputBinding.Name = "Binding" .. Key
            InputBinding.KeyCode = Value
            InputBinding.Parent = Parent
        end

        return Parent
    end

    local NavAction = CreateNavAction( "NavPreviousAction", { Enum.KeyCode.ButtonL1, Enum.KeyCode.DPadLeft, Enum.KeyCode.Left } )
    local Connections = Argument1.connections
    Connections:trackConnection( "NavPrevious", NavAction.StateChanged:Connect( function( Argument1Inner )
        if Argument1Inner then
            Argument1:SetScrollHighlight( Argument1:GetScrollDirectionForMove( "previous" ) )
            return
        end
        Argument1:SetScrollHighlight( "none" )
        Argument1:MoveSelection( "previous" )
        return
    end ) )
    local NavAction2 = CreateNavAction( "NavNextAction", { Enum.KeyCode.ButtonR1, Enum.KeyCode.DPadRight, Enum.KeyCode.Right } )
    local Connections2 = Argument1.connections
    Connections2:trackConnection( "NavNext", NavAction2.StateChanged:Connect( function( Argument1Inner )
        if Argument1Inner then
            Argument1:SetScrollHighlight( Argument1:GetScrollDirectionForMove( "next" ) )
            return
        end
        Argument1:SetScrollHighlight( "none" )
        Argument1:MoveSelection( "next" )
        return
    end ) )
    local NavAction3 = CreateNavAction( "ExitAction", { Enum.KeyCode.ButtonB } )
    local Connections3 = Argument1.connections
    Connections3:trackConnection( "Exit", NavAction3.Pressed:Connect( function()
        Argument1:ExitSelectionMode( )
    end ) )
    local NavAction4 = CreateNavAction( "ActivateAction", { Enum.KeyCode.ButtonA, Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter } )
    local Connections4 = Argument1.connections
    Connections4:trackConnection( "Activate", NavAction4.StateChanged:Connect( function( Argument1Inner )
        if Argument1Inner then
            Argument1.activeActionSlot = Argument1.selectedVisibleSlot
            Argument1.activeButton = Argument1.abilityButtonsByVisibleSlot[ Argument1.activeActionSlot ]

            if Argument1.activeButton then
                Argument1.activeButton:SetSelectionPressed( true )
                return
            end
        elseif Argument1.activeActionSlot then
            Argument1:ExitSelectionMode( )
        end
    end ) )
    CreateNavAction( "AbilitySinkAction", {
        Enum.KeyCode.ButtonX,
        Enum.KeyCode.ButtonY,
        Enum.KeyCode.ButtonL2,
        Enum.KeyCode.ButtonR2,
        Enum.KeyCode.DPadDown
    } )
    Parent.Parent = script
    Argument1.inputFolder = Parent
    Argument1.navContext = NavContext
end
function __index.UpdateInputMode( Self )
    if not Self.parentUIFrame then
        return
    end
    if __index.SupportsSelection( ) then
        Self:EnsureInputObjects( )

        if not Self.enabled and Self.selectionMode then
            Self:ExitSelectionMode( )
        end
    elseif Self.selectionMode then
        Self:ExitSelectionMode( )
    end

    Self.parentUIFrame.Visible = true
end
function __index.EnterSelectionMode( Self )
    if Self.selectionMode then
        return
    end
    if not __index.SupportsSelection( ) or not Self.enabled then
        return
    end
    if Self.numVisibleSlots <= 0 then
        return
    end

    Self.selectionMode = true

    if Self.navContext then
        Self.navContext.Enabled = true
    end

    Self.parentUIFrame.Visible = true
    local SelectedVisibleSlot = Self.selectedVisibleSlot
    Self.selectedVisibleSlot = math.clamp( SelectedVisibleSlot, 1, Self.numVisibleSlots )
    Self:RefreshSelection( )
end
function __index.ExitSelectionMode( Self )
    Self.selectionMode = false

    if Self.navContext then
        Self.navContext.Enabled = false
    end
    if Self.scrollHighlightDirection ~= "none" then
        Self.scrollHighlightDirection = "none"

        if Self.created then
            Self:CreateButtons( )
        end
    end
    if Self.activeButton then
        Self.activeButton:SetSelectionPressed( false )
        Self.activeButton = nil
    end

    Self.activeActionSlot = nil

    if Self.selectionRing then
        Self.selectionRing.Parent = nil
    end
end
function __index.MoveSelection( Self, SelectionName )
    if not Self.selectionMode then
        return
    end
    if Self.activeActionSlot then
        return
    end
    if SelectionName == "none" then
        return
    end

    local Number = SelectionName ~= "previous" and -1 or 1
    local Max = math.max( 0, #InputSlots.GetAbilitiesInOverflow( ) - InputSlots.GetNumOverflowSlots( ) )
    local OverflowScrollIndex = InputSlots.getOverflowScrollIndex( )
    local SelectedVisibleSlot = Self.selectedVisibleSlot + Number

    if SelectedVisibleSlot < 1 then
        if OverflowScrollIndex > 0 then
            Self.selectedVisibleSlot = 1
            InputSlots.setOverflowScrollIndex( OverflowScrollIndex - 1 )
        end
    elseif Self.numVisibleSlots < SelectedVisibleSlot then
        if OverflowScrollIndex < Max then
            Self.selectedVisibleSlot = Self.numVisibleSlots
            InputSlots.setOverflowScrollIndex( OverflowScrollIndex + 1 )
        end
    else
        Self.selectedVisibleSlot = SelectedVisibleSlot
    end

    Self:RefreshSelection( )
end
function __index.RefreshSelection( Self )
    if not __index.SupportsSelection( ) or not Self.selectionMode then
        return
    end
    if Self.numVisibleSlots <= 0 then
        return
    end

    local SelectedVisibleSlot = Self.selectedVisibleSlot
    Self.selectedVisibleSlot = math.clamp( SelectedVisibleSlot, 1, Self.numVisibleSlots )
    local Entry = Self.abilityButtonsByVisibleSlot[ Self.selectedVisibleSlot ]

    if Entry then
        Self:EnsureSelectionRing( )
        local SelectionRing = Self.selectionRing
        SelectionRing.Parent = Entry.instance
        Self.selectionRing.Visible = true
    end
end
function __index.Teardown( Self )
    Self.connections:disconnectAll( )
    Self.created = false
    Self:ExitSelectionMode( )

    if Self.inputFolder then
        Self.inputFolder:Destroy( )
        Self.inputFolder = nil
        Self.navContext = nil
    end
    if Self.selectionRing then
        Self.selectionRing:Destroy( )
        Self.selectionRing = nil
    end
end
function __index.CreateButtons( Argument1 )
    if Argument1.selectionRing then
        Argument1.selectionRing.Parent = nil
    end

    local Value1
    local ManagedButtons = Argument1.managedButtons
    Value1 = nil

    for Key, Value in ManagedButtons, nil, nil do
        Value:Destroy( )
    end

    Argument1.managedButtons = { }
    Argument1.abilityButtonsByVisibleSlot = { }
    Argument1.numVisibleSlots = 0

    if not Get2:isEnabled( ) then
        return
    end

    local CreateOverflowScrollButton3, CreateOverflowScrollButton4, Number, Number2
    local AbilitiesInOverflow = InputSlots.GetAbilitiesInOverflow( )
    local Count = #AbilitiesInOverflow
    local Min = math.min( Count, InputSlots.GetNumOverflowSlots( ) )
    local Count2 = #AbilitiesInOverflow

    if InputSlots.GetNumOverflowSlots( ) < Count2 then
        local OverflowScrollIndex = InputSlots.getOverflowScrollIndex( )
        local Count3 = #AbilitiesInOverflow - InputSlots.GetNumOverflowSlots( )

        if OverflowScrollIndex > 0 then
            local CreateOverflowScrollButton = Argument1:CreateOverflowScrollButton( "next" )
            table.insert( Argument1.managedButtons, CreateOverflowScrollButton )
            CreateOverflowScrollButton4 = CreateOverflowScrollButton
        else
            CreateOverflowScrollButton4 = nil
        end
        if OverflowScrollIndex < Count3 then
            local CreateOverflowScrollButton2 = Argument1:CreateOverflowScrollButton( "previous" )
            table.insert( Argument1.managedButtons, CreateOverflowScrollButton2 )
            CreateOverflowScrollButton3 = CreateOverflowScrollButton2
        else
            CreateOverflowScrollButton3 = nil
        end

        Number = Table[ 1 ] + 8
        Number2 = Table2[ 1 ] + 10
    else
        CreateOverflowScrollButton3 = nil
        CreateOverflowScrollButton4 = nil
        Number = 0
        Number2 = 0
    end
    if Argument1.scrollHighlightDirection ~= "previous" or not CreateOverflowScrollButton3 then
        if Argument1.scrollHighlightDirection == "next" and CreateOverflowScrollButton4 then
            CreateOverflowScrollButton4.Image = "rbxassetid://122643389561468"
        end
    else
        CreateOverflowScrollButton3.Image = "rbxassetid://122643389561468"
    end

    local I = 1

    for I = 1, Min do
        local Entry = AbilitiesInOverflow[ I + InputSlots.getOverflowScrollIndex( ) ]
        local OverflowAction = InputSlots.GetOverflowAction( I )

        if Entry and OverflowAction then
            local Flag
            local AbilityConfig = Get2:GetAbilityConfig( Entry )
            local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

            if PlayerGui then
                if PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = false
            end

            local TableInner = not Flag and {
                small = { 44, Table3[ 1 ] + Number + ( I - 1 ) * 52, Table3[ 2 ] },
                large = { 56, Table4[ 1 ] + Number2 + ( I - 1 ) * 66, Table4[ 2 ] }
            } or {
                small = { 44, Table3[ 1 ], Table3[ 2 ] + Number + ( I - 1 ) * 52 },
                large = { 56, Table4[ 1 ], Table4[ 2 ] + Number2 + ( I - 1 ) * 66 }
            }
            local ActiveButton = AbilityButton.create( Argument1, Entry, AbilityConfig, OverflowAction, TableInner, true, true )
            table.insert( Argument1.managedButtons, ActiveButton )
            Argument1.abilityButtonsByVisibleSlot[ I ] = ActiveButton
            Argument1.numVisibleSlots = I

            if I == Argument1.activeActionSlot then
                Argument1.activeButton = ActiveButton
                ActiveButton:SetSelectionPressed( true )
            end
        end
    end

    Argument1.parentUIFrame.Visible = true

    if Argument1.selectionMode then
        if Argument1.numVisibleSlots <= 0 then
            Argument1:ExitSelectionMode( )
            return
        end
        if __index.SupportsSelection( ) then
            Argument1:RefreshSelection( )
        end
    end
end
function __index.Create( Argument1 )
    if not Argument1.parentUIFrame then
        return
    end

    Argument1:CreateButtons( )
    local Connections = Argument1.connections
    Connections:trackConnection( "SlotMapChanged", InputSlots.GetSlotMapChangedSignal( ):Connect( function()
        Argument1:CreateButtons( )
        Argument1.selectedVisibleSlot = Argument1.numVisibleSlots
        Argument1:RefreshSelection( )
    end ) )
    local Connections2 = Argument1.connections
    Connections2:trackConnection( "AbilitiesEnabledChanged", Get2:GetEnabledChangedSignal( ):Connect( function()
        Argument1:CreateButtons( )
    end ) )
    local Connections3 = Argument1.connections
    Connections3:trackConnection( "ScrollIndexChanged", InputSlots.getScrollIndexChangedEvent( ):Connect( function()
        Argument1:CreateButtons( )
    end ) )
    local Connections4 = Argument1.connections
    Connections4:trackConnection( "PreferredInput", UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( function()
        Argument1:UpdateInputMode( )
        Argument1:CreateButtons( )
    end ) )
    local Connections5 = Argument1.connections
    Connections5:trackConnection( "InputBegan", UserInputService.InputBegan:Connect( function( Argument1Inner, Argument2 )
        if Argument2 then
            return
        end
        if not Argument1.enabled then
            return
        end

        local Flag

        if not __index.IsGamepad( ) or Argument1Inner.KeyCode ~= Enum.KeyCode.DPadUp then
            local IsKeyboardMouse = __index.IsKeyboardMouse( )

            if IsKeyboardMouse then
                if Argument1Inner.KeyCode == Enum.KeyCode.M then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = IsKeyboardMouse
            end
        else
            Flag = true
        end
        if not Flag then
            return
        end
        if Argument1.selectionMode then
            Argument1:ExitSelectionMode( )
            return
        end
        Argument1:EnterSelectionMode( )
        return
    end ) )
    local Connections6 = Argument1.connections
    Connections6:trackConnection( "MenuOpened", GuiService.MenuOpened:Connect( function()
        if Argument1.selectionMode then
            Argument1:ExitSelectionMode( )
        end
    end ) )
    local PlayerGui = Players.LocalPlayer:WaitForChild( "PlayerGui", 5 )

    if PlayerGui then
        local Connections7 = Argument1.connections
        Connections7:trackConnection( "ScreenOrientation", PlayerGui:GetPropertyChangedSignal( "CurrentScreenOrientation" ):Connect( function()
            Argument1:CreateButtons( )
        end ) )
    end

    Argument1.parentUIFrame.Destroying:Connect( function()
        Argument1:Teardown( )
    end )
    Argument1:UpdateInputMode( )
end
return __index
