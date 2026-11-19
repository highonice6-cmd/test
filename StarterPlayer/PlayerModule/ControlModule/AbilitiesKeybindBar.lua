-- StarterPlayer.PlayerModule.ControlModule.AbilitiesKeybindBar
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local UserInputService = game:GetService( "UserInputService" )
local CommonUtils = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) )
local InputSlots = require( script.Parent:WaitForChild( "InputSlots" ) )
local Get = CommonUtils.get( "ConnectionUtil" )
local DPadUp = Enum.KeyCode.DPadUp
local M = Enum.KeyCode.M
local FromRGB = Color3.fromRGB( 18, 18, 21 )
local BuilderSans = Enum.Font.BuilderSans
local FromRGB2 = Color3.fromRGB( 247, 247, 248 )
local BuilderSansBold = Enum.Font.BuilderSansBold
local FromRGB3 = Color3.fromRGB( 247, 247, 248 )
local FromRGB4 = Color3.fromRGB( 18, 18, 21 )
local Table = { }
local Table2 = {
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonB,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.ButtonY,
    Enum.KeyCode.ButtonL1,
    Enum.KeyCode.ButtonR1,
    Enum.KeyCode.ButtonL2,
    Enum.KeyCode.ButtonR2,
    Enum.KeyCode.ButtonL3,
    Enum.KeyCode.ButtonR3,
    Enum.KeyCode.ButtonStart,
    Enum.KeyCode.ButtonSelect,
    Enum.KeyCode.DPadLeft,
    Enum.KeyCode.DPadRight,
    Enum.KeyCode.DPadUp,
    Enum.KeyCode.DPadDown,
    Enum.KeyCode.Thumbstick1,
    Enum.KeyCode.Thumbstick2
}
Value1 = nil

for Key, Value in Table2, nil, nil do
    Table[ Value ] = true
end

local Table3 = {
    [ Enum.KeyCode.ButtonCenter ] = true,
    [ Enum.KeyCode.ButtonUp ] = true,
    [ Enum.KeyCode.ButtonDown ] = true,
    [ Enum.KeyCode.ButtonLeft ] = true,
    [ Enum.KeyCode.ButtonRight ] = true
}

local function ActionKeyCode( FoundChild )
    for Key, Value in FoundChild:GetChildren( ) do
        if Value:IsA( "InputBinding" ) then
            local Flag2
            local KeyCode = Value.KeyCode

            if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
                if Table[ KeyCode ] == true then
                    Flag2 = true
                else
                    Flag2 = false
                end
            else
                local Flag

                if KeyCode == Enum.KeyCode.None then
                    Flag = false
                else
                    local NotEntry = not Table[ KeyCode ]

                    if NotEntry then
                        Flag = not Table3[ KeyCode ]
                    else
                        Flag = NotEntry
                    end
                end

                Flag2 = Flag
            end
            if Flag2 then
                return KeyCode
            end
        end
    end

    return nil
end

local function CreateEntryFrame( Parent, Name, Text )
    local Parent2 = Instance.new( "Frame" )
    Parent2.Name = Name
    Parent2.LayoutOrder = Text
    Parent2.Size = UDim2.new( 0, 0, 0, 28 )
    Parent2.AutomaticSize = Enum.AutomaticSize.X
    Parent2.BackgroundTransparency = 1
    Parent2.BorderSizePixel = 0
    Parent2.Parent = Parent
    local UIPadding = Instance.new( "UIPadding" )
    UIPadding.PaddingRight = UDim.new( 0, 8 )
    UIPadding.Parent = Parent2
    local UIListLayout = Instance.new( "UIListLayout" )
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new( 0, 4 )
    UIListLayout.Parent = Parent2
    return Parent2
end

local function CreateKeyIndicator( Parent, Argument2, LayoutOrder )
    if Argument2 and UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        local Image = UserInputService:GetImageForKeyCode( Argument2 )

        if Image ~= "" then
            local ImageLabel = Instance.new( "ImageLabel" )
            ImageLabel.Name = "Key"
            ImageLabel.LayoutOrder = LayoutOrder
            ImageLabel.Size = UDim2.new( 0, 24, 0, 24 )
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Image = Image
            ImageLabel.Parent = Parent
            return
        end
    end

    local Text

    if not Argument2 or Argument2 == Enum.KeyCode.None then
        Text = "?"
    else
        local StringForKeyCode = UserInputService:GetStringForKeyCode( Argument2, Enum.KeyCodeStringFormat.Abbreviated )

        if StringForKeyCode:match( "^%s*$" ) then
            Text = Argument2.Name
        else
            Text = StringForKeyCode
        end
    end

    local Parent2 = Instance.new( "TextLabel" )
    Parent2.Name = "Key"
    Parent2.LayoutOrder = LayoutOrder
    Parent2.AutomaticSize = Enum.AutomaticSize.XY
    Parent2.Size = UDim2.new( 0, 0, 0, 0 )
    Parent2.BackgroundColor3 = FromRGB3
    Parent2.BackgroundTransparency = 0
    Parent2.BorderSizePixel = 0
    Parent2.Font = BuilderSansBold
    Parent2.TextSize = 14
    Parent2.TextColor3 = FromRGB4
    Parent2.Text = Text
    Parent2.Parent = Parent
    local UICorner = Instance.new( "UICorner" )
    UICorner.CornerRadius = UDim.new( 0, 2 )
    UICorner.Parent = Parent2
    local UISizeConstraint = Instance.new( "UISizeConstraint" )
    UISizeConstraint.MinSize = Vector2.new( 10, 10 )
    UISizeConstraint.Parent = Parent2
    local UIPadding = Instance.new( "UIPadding" )
    UIPadding.PaddingLeft = UDim.new( 0, 5 )
    UIPadding.PaddingRight = UDim.new( 0, 5 )
    UIPadding.PaddingTop = UDim.new( 0, 1 )
    UIPadding.PaddingBottom = UDim.new( 0, 2 )
    UIPadding.Parent = Parent2
end

local function CreateLabel( Parent, Text, LayoutOrder )
    local Parent2 = Instance.new( "TextLabel" )
    Parent2.Name = "Label"
    Parent2.LayoutOrder = LayoutOrder
    Parent2.AutomaticSize = Enum.AutomaticSize.X
    Parent2.Size = UDim2.new( 0, 0, 0, 28 )
    Parent2.BackgroundTransparency = 1
    Parent2.Font = BuilderSans
    Parent2.TextSize = 18
    Parent2.TextColor3 = FromRGB2
    Parent2.Text = Text
    Parent2.Parent = Parent
    local UIPadding = Instance.new( "UIPadding" )
    UIPadding.PaddingTop = UDim.new( 0, -0 )
    UIPadding.PaddingBottom = UDim.new( 0, 0 )
    UIPadding.Parent = Parent2
end

local __index = { }
__index.__index = __index
function __index.new( Parent )
    local Self = setmetatable( { }, __index )
    Self.parent = Parent
    Self.characterContext = nil
    Self.created = false
    Self.enabled = false
    Self.bar = nil
    Self.connections = Get.new( )
    Self.contextConnections = Get.new( )
    return Self
end
function __index.GetInputContextsParent( Argument1 )
    return script:FindFirstAncestor( "PlayerModule" )
end
function __index.ResolveCharacterContext( Argument1 )
    local InputContexts
    local InputContextsParent = Argument1:GetInputContextsParent( )

    if InputContextsParent then
        InputContexts = InputContextsParent:FindFirstChild( "InputContexts" )
    else
        InputContexts = InputContextsParent
    end
    if InputContexts then
        return InputContexts:FindFirstChild( "CharacterContext" )
    end
    return nil
end
function __index.ResolveAndBind( Argument1 )
    Argument1.connections:disconnect( "ResolveWatcher" )
    local ResolveCharacterContext = Argument1:ResolveCharacterContext( )

    if ResolveCharacterContext then
        Argument1:BindCharacterContext( ResolveCharacterContext )
        return
    end

    local InputContextsParent = Argument1:GetInputContextsParent( )

    if not InputContextsParent then
        return
    end

    local function BindWhenCharacterContextReady( Self )
        local CharacterContext = Self:FindFirstChild( "CharacterContext" )

        if CharacterContext then
            Argument1.connections:disconnect( "ResolveWatcher" )
            Argument1:BindCharacterContext( CharacterContext )
            return
        end
        local Connections = Argument1.connections
        Connections:trackConnection( "ResolveWatcher", Self.ChildAdded:Connect( function( Argument1Inner )
            if Argument1Inner.Name == "CharacterContext" then
                Argument1.connections:disconnect( "ResolveWatcher" )
                Argument1:BindCharacterContext( Argument1Inner )
            end
        end ) )
        return
    end

    local InputContexts = InputContextsParent:FindFirstChild( "InputContexts" )

    if InputContexts then
        BindWhenCharacterContextReady( InputContexts )
        return
    end
    local Connections = Argument1.connections
    Connections:trackConnection( "ResolveWatcher", InputContextsParent.ChildAdded:Connect( function( Self )
        if Self.Name == "InputContexts" then
            BindWhenCharacterContextReady( Self )
        end
    end ) )
    return
end
function __index.BindCharacterContext( Argument1, CharacterContext )
    Argument1.characterContext = CharacterContext
    Argument1.contextConnections:disconnectAll( )

    if CharacterContext then
        local function WatchAction( Self )
            Argument1.contextConnections:trackConnection( Self.Name .. "_Enabled", Self:GetPropertyChangedSignal( "Enabled" ):Connect( function()
                Argument1:Rebuild( )
            end ) )
            Argument1.contextConnections:trackConnection( Self.Name .. "_AttributeChanged", Self.AttributeChanged:Connect( function()
                Argument1:Rebuild( )
            end ) )
        end

        local NumAbilitySlots = InputSlots.GetNumAbilitySlots( )
        local I = 1

        for I = 1, NumAbilitySlots do
            local FoundChild = CharacterContext:FindFirstChild( "AbilityAction" .. I )

            if FoundChild then
                WatchAction( FoundChild )
            end
        end

        local ContextConnections = Argument1.contextConnections
        ContextConnections:trackConnection( "ChildAdded", CharacterContext.ChildAdded:Connect( function( Self )
            if Self:IsA( "InputAction" ) and string.match( Self.Name, "^AbilityAction%d+$" ) then
                WatchAction( Self )
                Argument1:Rebuild( )
            end
        end ) )
        local ContextConnections2 = Argument1.contextConnections
        ContextConnections2:trackConnection( "ChildRemoved", CharacterContext.ChildRemoved:Connect( function( Self )
            if Self:IsA( "InputAction" ) and string.match( Self.Name, "^AbilityAction%d+$" ) then
                Argument1.contextConnections:disconnect( Self.Name .. "_Enabled" )
                Argument1.contextConnections:disconnect( Self.Name .. "_AttributeChanged" )
                Argument1:Rebuild( )
            end
        end ) )
    end

    Argument1:Rebuild( )
end
function __index.IsVisiblePlatform( Argument1 )
    local Flag
    local PreferredInput = UserInputService.PreferredInput

    if PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
        Flag = true
    elseif PreferredInput == Enum.PreferredInput.Gamepad then
        Flag = true
    else
        Flag = false
    end

    return Flag
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

    Self:Rebuild( )
end
function __index.CreateEntry( Argument1, Text, Text2, Argument4 )
    local Bar = Argument1.bar
    local EntryFrame = CreateEntryFrame( Bar, "Slot" .. Text, Text )
    CreateKeyIndicator( EntryFrame, Argument4, 1 )
    CreateLabel( EntryFrame, Text2, 2 )
end
function __index.CreateActionEntry( Argument1, Name, Argument3, Text, Argument5 )
    local EntryFrame = CreateEntryFrame( Argument1.bar, Name, Argument3 )
    CreateKeyIndicator( EntryFrame, Argument5, 1 )
    CreateLabel( EntryFrame, Text, 2 )
end
function __index.Rebuild( Self )
    if not Self.bar then
        return
    end
    for Key, Value in Self.bar:GetChildren( ) do
        if Value:IsA( "Frame" ) then
            Value:Destroy( )
        end
    end

    local CharacterContext = Self.characterContext

    if not Self.enabled or not Self:IsVisiblePlatform( ) or not CharacterContext then
        Self.bar.Visible = false
        return
    end

    local Visible
    local PreferredInput = UserInputService.PreferredInput

    if #InputSlots.GetAbilitiesInOverflow( ) > 0 then
        local Captured

        if PreferredInput == Enum.PreferredInput.Gamepad then
            Captured = DPadUp
        elseif PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
            Captured = M
        else
            Captured = nil
        end
        if Captured then
            Self:CreateActionEntry( "MoreActions", InputSlots.GetNumAbilitySlots( ) + 1, "More Actions", Captured )
            Visible = true
        else
            Visible = false
        end
    else
        Visible = false
    end

    local NumAbilitySlots = InputSlots.GetNumAbilitySlots( )
    local I = 1

    for I = 1, NumAbilitySlots do
        local FoundChild = CharacterContext:FindFirstChild( "AbilityAction" .. I )

        if FoundChild and FoundChild.Enabled and type( FoundChild.DisplayName ) == "string" and FoundChild.DisplayName ~= "" then
            Self:CreateEntry( I, FoundChild.DisplayName, ( ActionKeyCode( FoundChild ) ) )
            Visible = true
        end
    end

    Self.bar.Visible = Visible
end
function __index.Create( Argument1 )
    if Argument1.parent then
        local Bar = Instance.new( "Frame" )
        Bar.Name = "AbilityKeybindBar"
        Bar.AnchorPoint = Vector2.new( 1, 1 )
        Bar.Position = UDim2.new( 1, -17, 1, -17 )
        Bar.Size = UDim2.new( 0, 0, 0, 28 )
        Bar.AutomaticSize = Enum.AutomaticSize.XY
        Bar.BackgroundColor3 = FromRGB
        Bar.BackgroundTransparency = 0.4
        Bar.BorderSizePixel = 0
        Bar.Visible = false
        Bar.Parent = Argument1.parent
        Argument1.bar = Bar
        local UICorner = Instance.new( "UICorner" )
        UICorner.CornerRadius = UDim.new( 1, 0 )
        UICorner.Parent = Bar
        local UIPadding = Instance.new( "UIPadding" )
        UIPadding.PaddingLeft = UDim.new( 0, 16 )
        UIPadding.PaddingRight = UDim.new( 0, 12 )
        UIPadding.PaddingTop = UDim.new( 0, 4 )
        UIPadding.PaddingBottom = UDim.new( 0, 4 )
        UIPadding.Parent = Bar
        local UIListLayout = Instance.new( "UIListLayout" )
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new( 0, 8 )
        UIListLayout.Parent = Bar
        local Connections = Argument1.connections
        Connections:trackConnection( "PreferredInput", UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( function()
            Argument1:Rebuild( )
        end ) )
        local Connections2 = Argument1.connections
        Connections2:trackConnection( "SlotMapChanged", InputSlots.GetSlotMapChangedSignal( ):Connect( function()
            Argument1:Rebuild( )
        end ) )
        local Connections3 = Argument1.connections
        Connections3:trackConnection( "ParentDestroying", Argument1.parent.Destroying:Connect( function()
            Argument1:Teardown( )
        end ) )
        Argument1:ResolveAndBind( )
        return
    end
    return
end
function __index.Teardown( Argument1 )
    Argument1.connections:disconnectAll( )
    Argument1.contextConnections:disconnectAll( )

    if Argument1.bar then
        Argument1.bar:Destroy( )
        Argument1.bar = nil
    end

    Argument1.created = false
end
return __index
