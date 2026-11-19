-- ReplicatedStorage.TopbarPlus.Icon
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Object2
local UserInputService = game:GetService( "UserInputService" )
local ContentProvider = game:GetService( "ContentProvider" )
local StarterGui = game:GetService( "StarterGui" )
local Players = game:GetService( "Players" )
require( script.Types )
local Script = script
local Reference = require( Script.Reference )
local Object = Reference.getObject( )
Object2 = if Object then Object.Value else Object

if Object2 and Object2 ~= Script then
    return ( require( Object2 ) )
end
if not Object then
    Reference.addToReplicatedStorage( )
end

local GoodSignal = require( Script.Packages.GoodSignal )
local Janitor = require( Script.Packages.Janitor )
local Utility = require( Script.Utility )
local Themes = require( Script.Features.Themes )
local Gamepad = require( Script.Features.Gamepad )
local Overflow = require( Script.Features.Overflow )
local __index = { }
__index.__index = __index
local LocalPlayer = Players.LocalPlayer
local Themes2 = Script.Features.Themes
local IconsDictionary = { }
local New = GoodSignal.new( )
local Elements = Script.Elements
local Number = 0
local Table = {
    mobile = Enum.PreferredInput.Touch,
    desktop = Enum.PreferredInput.KeyboardAndMouse,
    console = Enum.PreferredInput.Gamepad
}
__index.baseDisplayOrderChanged = GoodSignal.new( )
__index.baseDisplayOrder = 10
__index.baseTheme = require( Themes2.Default )
__index.isOldTopbar = false
__index.iconsDictionary = IconsDictionary
__index.insetHeightChanged = GoodSignal.new( )
__index.container = require( Elements.Container )( __index )
__index.topbarEnabled = true
__index.iconAdded = GoodSignal.new( )
__index.iconRemoved = GoodSignal.new( )
__index.iconChanged = GoodSignal.new( )
function __index.getIcons()
    return __index.iconsDictionary
end
function __index.getIconByUID( Key )
    local Entry = __index.iconsDictionary[ Key ]

    if Entry then
        return Entry
    end
    return nil
end
function __index.getIcon( Argument1 )
    local IconByUID = __index.getIconByUID( Argument1 )

    if IconByUID then
        return IconByUID
    end
    for Key, Value in pairs( IconsDictionary ) do
        if Value.name == Argument1 then
            return Value
        end
    end

    return nil
end
function __index.setTopbarEnabled( TopbarEnabled, Argument2 )
    local TopbarEnabled2
    TopbarEnabled2 = if typeof( TopbarEnabled ) == "boolean" then TopbarEnabled else __index.topbarEnabled

    if not Argument2 then
        __index.topbarEnabled = TopbarEnabled2
    end
    for Key, Value in pairs( __index.container ) do
        Value.Enabled = TopbarEnabled2
    end
end
function __index.modifyBaseTheme( Argument1 )
    for Key, Value in pairs( ( Themes.getModifications( Argument1 ) ) ) do
        for Key3, Value5 in pairs( __index.baseTheme ) do
            Themes.merge( Value5, Value )
        end
    end
    for Key2, Value3 in pairs( IconsDictionary ) do
        Value3:setTheme( __index.baseTheme )
    end
end
function __index.setDisplayOrder( BaseDisplayOrder )
    __index.baseDisplayOrder = BaseDisplayOrder
    __index.baseDisplayOrderChanged:Fire( BaseDisplayOrder )
end
task.defer( Gamepad.start, __index )
task.defer( Overflow.start, __index )
task.defer( function()
    local Parent = LocalPlayer:WaitForChild( "PlayerGui" )

    for Key, Value in pairs( __index.container ) do
        Value.Parent = Parent
    end

    require( Script.Attribute )
end )
function __index.new()
    local Game, OriginsScreenGui
    local TableInner = { }
    setmetatable( TableInner, __index )
    local JanitorInner = Janitor.new( )
    TableInner.janitor = JanitorInner
    TableInner.themesJanitor = JanitorInner:add( Janitor.new( ) )
    TableInner.singleClickJanitor = JanitorInner:add( Janitor.new( ) )
    TableInner.captionJanitor = JanitorInner:add( Janitor.new( ) )
    TableInner.joinJanitor = JanitorInner:add( Janitor.new( ) )
    TableInner.menuJanitor = JanitorInner:add( Janitor.new( ) )
    TableInner.dropdownJanitor = JanitorInner:add( Janitor.new( ) )
    local UID = Utility.generateUID( )
    IconsDictionary[ UID ] = TableInner
    JanitorInner:add( function()
        IconsDictionary[ UID ] = nil
    end )
    TableInner.selected = JanitorInner:add( GoodSignal.new( ) )
    TableInner.deselected = JanitorInner:add( GoodSignal.new( ) )
    TableInner.toggled = JanitorInner:add( GoodSignal.new( ) )
    TableInner.viewingStarted = JanitorInner:add( GoodSignal.new( ) )
    TableInner.viewingEnded = JanitorInner:add( GoodSignal.new( ) )
    TableInner.stateChanged = JanitorInner:add( GoodSignal.new( ) )
    TableInner.notified = JanitorInner:add( GoodSignal.new( ) )
    TableInner.noticeStarted = JanitorInner:add( GoodSignal.new( ) )
    TableInner.noticeChanged = JanitorInner:add( GoodSignal.new( ) )
    TableInner.endNotices = JanitorInner:add( GoodSignal.new( ) )
    TableInner.toggleKeyAdded = JanitorInner:add( GoodSignal.new( ) )
    TableInner.fakeToggleKeyChanged = JanitorInner:add( GoodSignal.new( ) )
    TableInner.alignmentChanged = JanitorInner:add( GoodSignal.new( ) )
    TableInner.updateSize = JanitorInner:add( GoodSignal.new( ) )
    TableInner.resizingComplete = JanitorInner:add( GoodSignal.new( ) )
    TableInner.joinedParent = JanitorInner:add( GoodSignal.new( ) )
    TableInner.menuSet = JanitorInner:add( GoodSignal.new( ) )
    TableInner.dropdownSet = JanitorInner:add( GoodSignal.new( ) )
    TableInner.updateMenu = JanitorInner:add( GoodSignal.new( ) )
    TableInner.startMenuUpdate = JanitorInner:add( GoodSignal.new( ) )
    TableInner.childThemeModified = JanitorInner:add( GoodSignal.new( ) )
    TableInner.indicatorSet = JanitorInner:add( GoodSignal.new( ) )
    TableInner.dropdownChildAdded = JanitorInner:add( GoodSignal.new( ) )
    TableInner.menuChildAdded = JanitorInner:add( GoodSignal.new( ) )
    TableInner.iconModule = Script
    TableInner.UID = UID
    TableInner.isEnabled = true
    TableInner.enabled = TableInner.isEnabled
    TableInner.isSelected = false
    TableInner.isViewing = false
    TableInner.joinedFrame = false
    TableInner.parentIconUID = false
    TableInner.deselectWhenOtherIconSelected = true
    TableInner.totalNotices = 0
    TableInner.activeState = "Deselected"
    TableInner.alignment = ""
    TableInner.originalAlignment = ""
    TableInner.appliedTheme = { }
    TableInner.appearance = { }
    TableInner.cachedInstances = { }
    TableInner.cachedNamesToInstances = { }
    TableInner.cachedCollectives = { }
    TableInner.bindedToggleKeys = { }
    TableInner.customBehaviours = { }
    TableInner.toggleItems = { }
    TableInner.bindedEvents = { }
    TableInner.notices = { }
    TableInner.menuIcons = { }
    TableInner.dropdownIcons = { }
    TableInner.childIconsDict = { }
    TableInner.creationTime = os.clock( )
    TableInner.widget = JanitorInner:add( require( Elements.Widget )( TableInner, __index ) )
    TableInner:setAlignment( )
    Number = Number + 1
    local Captured = Number * 0.01 + 1
    TableInner:setOrder( Captured, "deselected" )
    TableInner:setOrder( Captured, "selected" )
    TableInner:setTheme( __index.baseTheme )
    local GetInstance = TableInner:getInstance( "ClickRegion" )
    local Flag = false
    local NumberInner = 0

    local function HandleToggle()
        if TableInner.locked then
            return
        end

        local Tick = tick( )

        if Tick - NumberInner < 0.1 then
            return
        end

        NumberInner = Tick

        if TableInner.isSelected then
            TableInner:deselect( "User", TableInner )
            return
        end
        TableInner:select( "User", TableInner )
        return
    end

    GetInstance.MouseButton1Click:Connect( function()
        Flag = true

        if TableInner.locked then
            return
        end

        local Tick = tick( )

        if Tick - NumberInner < 0.1 then
            return
        end

        NumberInner = Tick

        if TableInner.isSelected then
            TableInner:deselect( "User", TableInner )
            return
        end
        TableInner:select( "User", TableInner )
        return
    end )
    GetInstance.TouchTap:Connect( function()
        if not Flag then
            if TableInner.locked then
                return
            end

            local Tick = tick( )

            if Tick - NumberInner < 0.1 then
                return
            end

            NumberInner = Tick

            if TableInner.isSelected then
                TableInner:deselect( "User", TableInner )
                return
            end

            TableInner:select( "User", TableInner )
        end
    end )
    JanitorInner:add( UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
        if TableInner.locked then
            return
        end
        if TableInner.bindedToggleKeys[ Argument1.KeyCode ] and not Argument2 then
            if TableInner.locked then
                return
            end

            local Tick = tick( )

            if Tick - NumberInner < 0.1 then
                return
            end

            NumberInner = Tick

            if TableInner.isSelected then
                TableInner:deselect( "User", TableInner )
                return
            end

            TableInner:select( "User", TableInner )
        end
    end ) )

    local function ViewingStarted( Argument1 )
        if TableInner.locked then
            return
        end

        TableInner.isViewing = true
        TableInner.viewingStarted:Fire( true )

        if not Argument1 then
            TableInner:setState( "Viewing", "User", TableInner )
        end
    end

    local function ViewingEnded()
        if TableInner.locked then
            return
        end
        TableInner.isViewing = false
        TableInner.viewingEnded:Fire( true )
        TableInner:setState( nil, "User", TableInner )
        return
    end

    TableInner.joinedParent:Connect( function()
        if TableInner.isViewing then
            if TableInner.locked then
                return
            end

            TableInner.isViewing = false
            TableInner.viewingEnded:Fire( true )
            TableInner:setState( nil, "User", TableInner )
        end
    end )
    GetInstance.MouseEnter:Connect( function()
        local Flag = UserInputService.PreferredInput ~= Table.desktop and true or false

        if TableInner.locked then
            return
        end

        TableInner.isViewing = true
        TableInner.viewingStarted:Fire( true )

        if not Flag then
            TableInner:setState( "Viewing", "User", TableInner )
        end
    end )
    local Number2 = 0
    JanitorInner:add( UserInputService.TouchEnded:Connect( ViewingEnded ) )
    GetInstance.MouseLeave:Connect( ViewingEnded )
    GetInstance.SelectionGained:Connect( ViewingStarted )
    GetInstance.SelectionLost:Connect( ViewingEnded )
    GetInstance.MouseButton1Down:Connect( function()
        if not TableInner.locked and UserInputService.PreferredInput == Table.mobile then
            Number2 = Number2 + 1
            task.delay( 0.2, function()
                if Number2 == Number2 then
                    if TableInner.locked then
                        return
                    end

                    TableInner.isViewing = true
                    TableInner.viewingStarted:Fire( true )
                    TableInner:setState( "Viewing", "User", TableInner )
                end
            end )
        end
    end )
    GetInstance.MouseButton1Up:Connect( function()
        Number2 = Number2 + 1
    end )
    local GetInstance2 = TableInner:getInstance( "IconOverlay" )
    TableInner.viewingStarted:Connect( function()
        GetInstance2.Visible = not TableInner.overlayDisabled
    end )
    TableInner.viewingEnded:Connect( function()
        GetInstance2.Visible = false
    end )
    JanitorInner:add( New:Connect( function( Argument1 )
        if Argument1 ~= TableInner and TableInner.deselectWhenOtherIconSelected and Argument1.deselectWhenOtherIconSelected then
            TableInner:deselect( "AutoDeselect", Argument1 )
        end
    end ) )
    Game = game
    OriginsScreenGui = nil

    for Key, Value in pairs( ( string.split( debug.info( 2, "s" ), "." ) ) ) do
        local FoundChild = Game:FindFirstChild( Value )

        if not FoundChild then
            Game = FoundChild
            break
        end
        if FoundChild:IsA( "ScreenGui" ) then
            Game = FoundChild
            OriginsScreenGui = FoundChild
        else
            Game = FoundChild
        end
    end
    if Game and OriginsScreenGui and OriginsScreenGui.ResetOnSpawn == true then
        TableInner.originsScreenGui = OriginsScreenGui
        Utility.localPlayerRespawned( function()
            TableInner:destroy( )
        end )
    end

    TableInner.toggled:Connect( function( Argument1 )
        TableInner.noticeChanged:Fire( TableInner.totalNotices )

        for Value in pairs( TableInner.childIconsDict ) do
            local IconByUID = __index.getIconByUID( Value )
            IconByUID.noticeChanged:Fire( IconByUID.totalNotices )

            if not Argument1 and IconByUID.isSelected then
                for Value3 in pairs( IconByUID.childIconsDict ) do
                    IconByUID:deselect( "HideParentFeature", TableInner )
                end
            end
        end
    end )
    TableInner.selected:Connect( function()
        local Flag = #TableInner.dropdownIcons > 0 and true or false

        if Flag then
            if StarterGui:GetCore( "ChatActive" ) and TableInner.alignment ~= "Right" then
                TableInner.chatWasPreviouslyActive = true
                StarterGui:SetCore( "ChatActive", false )
            end
            if StarterGui:GetCoreGuiEnabled( "PlayerList" ) and TableInner.alignment ~= "Left" then
                TableInner.playerlistWasPreviouslyActive = true
                StarterGui:SetCoreGuiEnabled( Enum.CoreGuiType.PlayerList, false )
            end
        end
    end )
    TableInner.deselected:Connect( function()
        if TableInner.chatWasPreviouslyActive then
            TableInner.chatWasPreviouslyActive = nil
            StarterGui:SetCore( "ChatActive", true )
        end
        if TableInner.playerlistWasPreviouslyActive then
            TableInner.playerlistWasPreviouslyActive = nil
            StarterGui:SetCoreGuiEnabled( Enum.CoreGuiType.PlayerList, true )
        end
    end )
    task.delay( 0.1, function()
        if TableInner.activeState == "Deselected" then
            TableInner.stateChanged:Fire( "Deselected" )
            TableInner:refresh( )
        end
    end )
    __index.iconAdded:Fire( TableInner )
    return TableInner
end
function __index.setName( Argument1, Name )
    Argument1.widget.Name = Name
    Argument1.name = Name
    return Argument1
end
function __index.setState( Argument1, Argument2, Argument3, Argument4 )
    local Text2

    if Argument2 then
        Text2 = Argument2
    else
        local Text = not Argument1.isSelected and "Deselected" or "Selected"
        Text2 = Text
    end

    local ActiveState = Utility.formatStateName( Text2 )

    if Argument1.activeState == ActiveState then
        return
    end

    local IsSelected = Argument1.isSelected
    Argument1.activeState = ActiveState

    if ActiveState == "Deselected" then
        Argument1.isSelected = false

        if IsSelected then
            Argument1.toggled:Fire( false, Argument3, Argument4 )
            Argument1.deselected:Fire( Argument3, Argument4 )
        end

        Argument1:_setToggleItemsVisible( false, Argument3, Argument4 )
    elseif ActiveState == "Selected" then
        Argument1.isSelected = true

        if not IsSelected then
            Argument1.toggled:Fire( true, Argument3, Argument4 )
            Argument1.selected:Fire( Argument3, Argument4 )
            New:Fire( Argument1, Argument3, Argument4 )
        end

        Argument1:_setToggleItemsVisible( true, Argument3, Argument4 )
    end

    Argument1.stateChanged:Fire( ActiveState, Argument3, Argument4 )
end
function __index.getInstance( Argument1, Name )
    local Entry = Argument1.cachedNamesToInstances[ Name ]

    if Entry then
        return Entry
    end

    local function CacheInstance( InstanceName, InstanceName2 )
        if not Argument1.cachedInstances[ InstanceName2 ] then
            local Collective2
            local Collective = InstanceName2:GetAttribute( "Collective" )
            Collective2 = if Collective then Argument1.cachedCollectives[ Collective ] else Collective

            if Collective2 then
                table.insert( Collective2, InstanceName2 )
            end

            Argument1.cachedNamesToInstances[ InstanceName ] = InstanceName2
            Argument1.cachedInstances[ InstanceName2 ] = true
            InstanceName2.Destroying:Once( function()
                Argument1.cachedNamesToInstances[ InstanceName ] = nil
                Argument1.cachedInstances[ InstanceName2 ] = nil
            end )
        end
    end

    local Widget = Argument1.widget
    CacheInstance( "Widget", Widget )

    if Name == "Widget" then
        return Widget
    end
    local Value1 = nil

    local function ScanChildren( Object )
        for Key, Value in pairs( Object:GetChildren( ) ) do
            local WidgetUID = Value:GetAttribute( "WidgetUID" )

            if not WidgetUID or WidgetUID == Argument1.UID then
                local RealInstance2
                local RealInstance = Themes.getRealInstance( Value )
                RealInstance2 = if RealInstance then RealInstance else Value
                ScanChildren( RealInstance2 )

                if RealInstance2:IsA( "GuiBase" ) or RealInstance2:IsA( "UIBase" ) or RealInstance2:IsA( "ValueBase" ) then
                    local NameInner = RealInstance2.Name
                    CacheInstance( NameInner, RealInstance2 )

                    if NameInner == Name then
                        Value1 = RealInstance2
                    end
                end
            end
        end
    end

    ScanChildren( Widget )
    return Value1
end
function __index.getCollective( Argument1, Key )
    local Entry = Argument1.cachedCollectives[ Key ]

    if Entry then
        return Entry
    end

    local Table = { }

    for Value in pairs( Argument1.cachedInstances ) do
        if Value:GetAttribute( "Collective" ) == Key then
            table.insert( Table, Value )
        end
    end

    Argument1.cachedCollectives[ Key ] = Table
    return Table
end
function __index.getInstanceOrCollective( Self, Argument2 )
    local Table = { }
    local GetInstance = Self:getInstance( Argument2 )

    if GetInstance then
        table.insert( Table, GetInstance )
    end

    local GetCollective

    if #Table == 0 then
        GetCollective = Self:getCollective( Argument2 )
    else
        GetCollective = Table
    end

    return GetCollective
end
function __index.getStateGroup( Argument1, Key )
    local Entry2
    local Entry = Argument1.appearance[ Key or Argument1.activeState ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { }
        Argument1.appearance[ Key or Argument1.activeState ] = Table
        Entry2 = Table
    end

    return Entry2
end
function __index.refreshAppearance( Argument1, Argument2, Argument3 )
    Themes.refresh( Argument1, Argument2, Argument3 )
    return Argument1
end
function __index.refresh( Argument1 )
    Argument1:refreshAppearance( Argument1.widget )
    Argument1.updateSize:Fire( )
    return Argument1
end
function __index.updateParent( Parent )
    local IconByUID = __index.getIconByUID( Parent.parentIconUID )

    if IconByUID then
        IconByUID.updateSize:Fire( )
    end
end
function __index.setBehaviour( Self, Text, Text2, Argument4, Argument5 )
    local Text3 = Text .. "-" .. Text2
    Self.customBehaviours[ Text3 ] = Argument4

    if Argument5 then
        for Key, Value in pairs( ( Self:getInstanceOrCollective( Text ) ) ) do
            Self:refreshAppearance( Value, Text2 )
        end
    end
end
function __index.modifyTheme( Argument1, Argument2, Argument3 )
    return Argument1, ( Themes.modify( Argument1, Argument2, Argument3 ) )
end
function __index.modifyChildTheme( Argument1, ChildModifications, ChildModificationsUID )
    Argument1.childModifications = ChildModifications
    Argument1.childModificationsUID = ChildModificationsUID

    for Value in pairs( Argument1.childIconsDict ) do
        __index.getIconByUID( Value ):modifyTheme( ChildModifications, ChildModificationsUID )
    end

    Argument1.childThemeModified:Fire( )
    return Argument1
end
function __index.removeModification( Argument1, Argument2 )
    Themes.remove( Argument1, Argument2 )
    return Argument1
end
function __index.removeModificationWith( Argument1, Argument2, Argument3, Argument4 )
    Themes.removeWith( Argument1, Argument2, Argument3, Argument4 )
    return Argument1
end
function __index.setTheme( Argument1, Argument2 )
    Themes.set( Argument1, Argument2 )
    return Argument1
end
function __index.setEnabled( Argument1, IsEnabled )
    Argument1.isEnabled = IsEnabled
    Argument1.enabled = Argument1.isEnabled
    Argument1.widget.Visible = IsEnabled
    Argument1:updateParent( )
    return Argument1
end
function __index.select( Argument1, Argument2, Argument3 )
    Argument1:setState( "Selected", Argument2, Argument3 )
    return Argument1
end
function __index.deselect( Argument1, Argument2, Argument3 )
    Argument1:setState( "Deselected", Argument2, Argument3 )
    return Argument1
end
function __index.notify( Argument1, Argument2, Argument3 )
    if not Argument1.notice then
        Argument1.notice = require( Elements.Notice )( Argument1, __index )
    end

    Argument1.noticeStarted:Fire( Argument2, Argument3 )
    return Argument1
end
function __index.clearNotices( Argument1 )
    Argument1.endNotices:Fire( )
    return Argument1
end
function __index.disableOverlay( Argument1, OverlayDisabled )
    Argument1.overlayDisabled = OverlayDisabled
    return Argument1
end
__index.disableStateOverlay = __index.disableOverlay
function __index.setImage( Argument1, Argument2, Argument3 )
    Argument1:modifyTheme( { "IconImage", "Image", Argument2, Argument3 } )
    task.spawn( function()
        local Format

        if tonumber( Argument2 ) then
            Format = ( "rbxassetid://%*" ):format( Argument2 )
        else
            Format = Argument2
        end
        if ContentProvider:GetAssetFetchStatus( Format ) ~= Enum.AssetFetchStatus.Success then
            pcall( ContentProvider.PreloadAsync, ContentProvider, { Format } )
        end
    end )
    return Argument1
end
function __index.setLabel( Argument1, Argument2, Argument3 )
    Argument1:modifyTheme( { "IconLabel", "Text", Argument2, Argument3 } )
    return Argument1
end
function __index.setOrder( Argument1, Amount, Argument3 )
    local Result = Amount * 100
    Argument1:modifyTheme( { "IconSpot", "LayoutOrder", Result, Argument3 } )
    Argument1:modifyTheme( { "Widget", "LayoutOrder", Result, Argument3 } )
    return Argument1
end
function __index.setCornerRadius( Argument1, Argument2, Argument3 )
    Argument1:modifyTheme( { "IconCorners", "CornerRadius", Argument2, Argument3 } )
    return Argument1
end
function __index.align( Argument1, Argument2, Argument3 )
    local Lower2
    local Lower = tostring( Argument2 ):lower( )

    if Lower == "mid" or Lower == "centre" then
        Lower2 = "center"
    else
        Lower2 = Lower
    end
    if Lower2 ~= "left" and Lower2 ~= "center" and Lower2 ~= "right" then
        Lower2 = "left"
    end

    local ScreenGui

    if Lower2 == "center" then
        local TopbarCentered = __index.container.TopbarCentered

        if TopbarCentered then
            ScreenGui = TopbarCentered
        else
            ScreenGui = __index.container.TopbarStandard
        end
    else
        ScreenGui = __index.container.TopbarStandard
    end

    local Holders = ScreenGui.Holders
    local OriginalAlignment = string.upper( ( string.sub( Lower2, 1, 1 ) ) ) .. string.sub( Lower2, 2 )

    if not Argument3 then
        Argument1.originalAlignment = OriginalAlignment
    end

    local JoinedFrame = Argument1.joinedFrame
    local AlignmentHolder = Holders[ OriginalAlignment ]
    Argument1.screenGui = ScreenGui
    Argument1.alignmentHolder = AlignmentHolder

    if not Argument1.isDestroyed then
        local Widget = Argument1.widget
        Widget.Parent = JoinedFrame or AlignmentHolder
    end

    Argument1.alignment = OriginalAlignment
    Argument1.alignmentChanged:Fire( OriginalAlignment )
    __index.iconChanged:Fire( Argument1 )
    return Argument1
end
__index.setAlignment = __index.align
function __index.setLeft( Left )
    Left:setAlignment( "Left" )
    return Left
end
function __index.setMid( Mid )
    Mid:setAlignment( "Center" )
    return Mid
end
function __index.setRight( Right )
    Right:setAlignment( "Right" )
    return Right
end
function __index.setWidth( Argument1, Argument2, Argument3 )
    Argument1:modifyTheme( { "Widget", "DesiredWidth", Argument2, Argument3 } )
    return Argument1
end
function __index.setImageScale( Argument1, Argument2, Argument3 )
    Argument1:modifyTheme( { "IconImageScale", "Value", Argument2, Argument3 } )
    return Argument1
end
function __index.setImageRatio( Argument1, Argument2, Argument3 )
    Argument1:modifyTheme( { "IconImageRatio", "AspectRatio", Argument2, Argument3 } )
    return Argument1
end
function __index.setTextSize( Argument1, Argument2, Argument3 )
    Argument1:modifyTheme( { "IconLabel", "TextSize", Argument2, Argument3 } )
    return Argument1
end
function __index.setTextFont( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local FromId
    local Kind = typeof( Argument2 )

    if Kind == "number" then
        FromId = Font.fromId( Argument2, Argument3 or Enum.FontWeight.Regular, Argument4 or Enum.FontStyle.Normal )
    elseif Kind == "EnumItem" then
        FromId = Font.fromEnum( Argument2 )
    elseif Kind ~= "string" or Argument2:match( "rbxasset" ) then
        FromId = nil
    else
        FromId = Font.fromName( Argument2, Argument3 or Enum.FontWeight.Regular, Argument4 or Enum.FontStyle.Normal )
    end
    if not FromId then
        FromId = Font.new( Argument2, Argument3 or Enum.FontWeight.Regular, Argument4 or Enum.FontStyle.Normal )
    end

    Argument1:modifyTheme( { "IconLabel", "FontFace", FromId, Argument5 } )
    return Argument1
end
function __index.setTextColor( Argument1, ColorName, Argument3 )
    local FromRGB

    if ColorName == nil or ColorName == "" or type( ColorName ) ~= "userdata" or typeof( ColorName ) ~= "Color3" then
        if ColorName ~= nil and ColorName ~= "" then
            warn( "setTextColor item must be a Color3 value! Changed the color to white." )
        end

        FromRGB = Color3.fromRGB( 255, 255, 255 )
    else
        FromRGB = ColorName
    end

    Argument1:modifyTheme( { "IconLabel", "TextColor3", FromRGB, Argument3 } )
    return Argument1
end
function __index.bindToggleItem( Argument1, ItemName )
    if not ItemName:IsA( "GuiObject" ) and not ItemName:IsA( "LayerCollector" ) then
        error( "Toggle item must be a GuiObject or LayerCollector!" )
    end

    Argument1.toggleItems[ ItemName ] = true
    Argument1:_updateSelectionInstances( )
    return Argument1
end
function __index.unbindToggleItem( Argument1, ItemName )
    Argument1.toggleItems[ ItemName ] = nil
    Argument1:_updateSelectionInstances( )
    return Argument1
end
function __index._updateSelectionInstances( Instances )
    for Value in pairs( Instances.toggleItems ) do
        local Table = { }

        for Key, Value3 in pairs( Value:GetDescendants( ) ) do
            if Value3:IsA( "TextButton" ) or Value3:IsA( "ImageButton" ) then
                if Value3.Active then
                    table.insert( Table, Value3 )
                end
            end
        end

        Instances.toggleItems[ Value ] = Table
    end
end
function __index._setToggleItemsVisible( Argument1, Argument2, Argument3, Argument4 )
    for Value in pairs( Argument1.toggleItems ) do
        if not Argument4 or Argument4 == Argument1 or Argument4.toggleItems[ Value ] == nil then
            local Text = if Value:IsA( "LayerCollector" ) then "Enabled" else "Visible"
            Value[ Text ] = Argument2
        end
    end
end
function __index.bindEvent( List, EventName, Argument3 )
    local Entry2
    local Entry = List[ EventName ]

    if Entry then
        if typeof( Entry ) == "table" then
            Entry2 = Entry.Connect
        else
            Entry2 = false
        end
    else
        Entry2 = Entry
    end

    local Flag
    assert( Entry2, "argument[1] must be a valid topbarplus icon event name!" )
    Flag = typeof( Argument3 ) == "function" and true or false
    assert( Flag, "argument[2] must be a function!" )
    local BindedEvents = List.bindedEvents
    BindedEvents[ EventName ] = Entry:Connect( function( ... )
        Argument3( List, ... )
    end )
    return List
end
function __index.unbindEvent( Argument1, EventName )
    local Entry = Argument1.bindedEvents[ EventName ]

    if Entry then
        Entry:Disconnect( )
        Argument1.bindedEvents[ EventName ] = nil
    end

    return Argument1
end
function __index.bindToggleKey( Argument1, KeyName )
    local Flag = typeof( KeyName ) == "EnumItem" and true or false
    assert( Flag, "argument[1] must be a KeyCode EnumItem!" )
    Argument1.bindedToggleKeys[ KeyName ] = true
    Argument1.toggleKeyAdded:Fire( KeyName )
    Argument1:setCaption( "_hotkey_" )
    return Argument1
end
function __index.unbindToggleKey( Argument1, KeyName )
    local Flag = typeof( KeyName ) == "EnumItem" and true or false
    assert( Flag, "argument[1] must be a KeyCode EnumItem!" )
    Argument1.bindedToggleKeys[ KeyName ] = nil
    return Argument1
end
function __index.call( Argument1, Argument2, ... )
    local Pack = table.pack( ... )
    task.spawn( function()
        Argument2( Argument1, table.unpack( Pack ) )
    end )
    return Argument1
end
function __index.addToJanitor( Argument1, Argument2, Argument3, Argument4 )
    Argument1.janitor:add( Argument2, Argument3, Argument4 )
    return Argument1
end
function __index.lock( Argument1 )
    Argument1:getInstance( "ClickRegion" ).Visible = false
    Argument1.locked = true
    return Argument1
end
function __index.unlock( Argument1 )
    Argument1:getInstance( "ClickRegion" ).Visible = true
    Argument1.locked = false
    return Argument1
end
function __index.debounce( Argument1, Duration )
    Argument1:lock( )
    task.wait( Duration )
    Argument1:unlock( )
    return Argument1
end
function __index.autoDeselect( Argument1, DeselectWhenOtherIconSelected )
    local DeselectWhenOtherIconSelected2 = if DeselectWhenOtherIconSelected == nil then true else DeselectWhenOtherIconSelected
    Argument1.deselectWhenOtherIconSelected = DeselectWhenOtherIconSelected2
    return Argument1
end
function __index.oneClick( Argument1, Argument2 )
    local SingleClickJanitor = Argument1.singleClickJanitor
    SingleClickJanitor:clean( )

    if Argument2 or Argument2 == nil then
        SingleClickJanitor:add( Argument1.selected:Connect( function()
            Argument1:deselect( "OneClick", Argument1 )
        end ) )
    end

    Argument1.oneClickEnabled = true
    return Argument1
end
function __index.setCaption( Argument1, CaptionText )
    if CaptionText == "_hotkey_" and Argument1.captionText then
        return Argument1
    end

    local CaptionJanitor = Argument1.captionJanitor
    Argument1.captionJanitor:clean( )

    if not CaptionText or CaptionText == "" then
        Argument1.caption = nil
        Argument1.captionText = nil
        return Argument1
    end
    local Caption = CaptionJanitor:add( require( Elements.Caption )( Argument1 ) )
    Caption:SetAttribute( "CaptionText", CaptionText )
    Argument1.caption = Caption
    Argument1.captionText = CaptionText
    return Argument1
end
function __index.setCaptionHint( Argument1, FakeToggleKey )
    local Flag = typeof( FakeToggleKey ) == "EnumItem" and true or false
    assert( Flag, "argument[1] must be a KeyCode EnumItem!" )
    Argument1.fakeToggleKey = FakeToggleKey
    Argument1.fakeToggleKeyChanged:Fire( FakeToggleKey )
    Argument1:setCaption( "_hotkey_" )
    return Argument1
end
function __index.leave( Argument1 )
    Argument1.joinJanitor:clean( )
    return Argument1
end
function __index.joinMenu( Argument1, Argument2 )
    local JoinFeature = Utility.joinFeature
    JoinFeature( Argument1, Argument2, Argument2.menuIcons, Argument2:getInstance( "Menu" ) )
    Argument2.menuChildAdded:Fire( Argument1 )
    return Argument1
end
function __index.setMenu( Argument1, Argument2 )
    Argument1.menuSet:Fire( Argument2 )
    return Argument1
end
function __index.setFixedMenu( Self, Argument2 )
    Self:freezeMenu( Argument2 )
    Self:setMenu( Argument2 )
end
__index.setFrozenMenu = __index.setFixedMenu
function __index.freezeMenu( Argument1 )
    Argument1:select( "FrozenMenu", Argument1 )
    Argument1:bindEvent( "deselected", function( Argument1Inner )
        Argument1Inner:select( "FrozenMenu", Argument1 )
    end )
    Argument1:modifyTheme( { "IconSpot", "Visible", false } )
end
function __index.joinDropdown( Argument1, Argument2 )
    Argument2:getDropdown( )
    local JoinFeature = Utility.joinFeature
    JoinFeature( Argument1, Argument2, Argument2.dropdownIcons, Argument2:getInstance( "DropdownScroller" ) )
    Argument2.dropdownChildAdded:Fire( Argument1 )
    return Argument1
end
function __index.getDropdown( Argument1 )
    local Dropdown3
    local Dropdown = Argument1.dropdown

    if Dropdown then
        Dropdown3 = Dropdown
    else
        local Dropdown2 = require( Elements.Dropdown )( Argument1 )
        Argument1.dropdown = Dropdown2
        Argument1:clipOutside( Dropdown2 )
        Dropdown3 = Dropdown2
    end

    return Dropdown3
end
function __index.setDropdown( Argument1, Argument2 )
    Argument1:getDropdown( )
    Argument1.dropdownSet:Fire( Argument2 )
    return Argument1
end
function __index.clipOutside( Argument1, Argument2 )
    local ClipOutside = Utility.clipOutside( Argument1, Argument2 )
    Argument1:refreshAppearance( Argument2 )
    return Argument1, ClipOutside
end
function __index.setIndicator( Argument1, Argument2 )
    if not Argument1.indicator then
        Argument1.indicator = Argument1.janitor:add( require( Elements.Indicator )( Argument1, __index ) )
    end

    Argument1.indicatorSet:Fire( Argument2 )
end
function __index.convertLabelToNumberSpinner( Argument1, Argument2, Argument3 )
    task.defer( function()
        local GetInstance = Argument1:getInstance( "IconLabel" )
        GetInstance.Transparency = 1
        Argument2.Parent = GetInstance.Parent
        Argument2.Size = UDim2.fromScale( 1, 1 )
        Argument2.AnchorPoint = Vector2.new( 0.5, 0.5 )
        Argument2.Position = UDim2.new( 0.5, 0, 0.5, 0 )
        Argument2.TextXAlignment = Enum.TextXAlignment.Center
        Argument2.ClipsDescendants = false

        for Index, Value in ipairs( {
            "FontFace",
            "BorderSizePixel",
            "BorderColor3",
            "Rotation",
            "TextStrokeTransparency",
            "TextStrokeColor3",
            "TextStrokeTransparency",
            "TextColor3"
        } ) do
            Argument2[ Value ] = GetInstance[ Value ]
            Argument1:addToJanitor( GetInstance:GetPropertyChangedSignal( Value ):Connect( function()
                Argument2[ Value ] = GetInstance[ Value ]
            end ) )
        end

        local function GetSpinnerSizeAndDigitCount()
            local Number, Number2
            Number = 0
            Number2 = 0

            for Key, Value in Argument2.Frame:GetChildren( ) do
                local Lower = string.lower( Value.Name )

                if Lower == "digit" then
                    Number = Number + Value.AbsoluteSize.X
                    Number2 = Number2 + 1
                elseif Lower == "prefix" or Lower == "suffix" or Lower == "comma" then
                    if Value.Text ~= "" then
                        Number = Number + Value.AbsoluteSize.X
                        Number2 = Number2 + 1
                    end
                end
            end

            return Number, Number2
        end

        local function GetLabelParentContainerXSize()
            local Parent2
            local Parent = GetInstance.Parent
            Parent2 = if Parent then Parent.Parent else Parent

            if Parent2 == nil then
                return 0
            end
            if Parent2.IconImage.Visible == true then
                return Argument2.Frame.AbsoluteSize.X + GetInstance.Parent.Parent.IconImage.AbsoluteSize.X
            end
            return Parent2.AbsoluteSize.X
        end

        local function GetNumberSpinnerXSize()
            return Argument2.Frame.AbsoluteSize.X
        end

        local function AdjustSize()
            local Value1, Value2 = GetSpinnerSizeAndDigitCount( )

            if Value2 < 18 then
                Argument1:setLabel( Argument2.Value )
            end

            local X, Value3
            X = Argument2.Frame.AbsoluteSize.X
            Value3 = Value2

            while Value1 < X do
                if Argument1.isDestroyed == true then
                    break
                end

                task.wait( 0.05 )

                if Value3 > 0 and Value3 < 8 then
                    Argument2.TextSize = GetInstance.TextSize
                    break
                end
                Argument2.TextSize = Argument2.TextSize + 1
                X = Argument2.Frame.AbsoluteSize.X
                Value1, Value3 = GetSpinnerSizeAndDigitCount( )
            end

            local Parent2
            local Parent = GetInstance.Parent
            Parent2 = if Parent then Parent.Parent else Parent
            local X2

            if Parent2 == nil then
                X2 = 0
            elseif Parent2.IconImage.Visible == true then
                X2 = Argument2.Frame.AbsoluteSize.X + GetInstance.Parent.Parent.IconImage.AbsoluteSize.X
            else
                X2 = Parent2.AbsoluteSize.X
            end
            while X2 < Value1 do
                if Argument1.isDestroyed == true then
                    break
                end

                task.wait( 0.05 )

                if Value3 < 8 and Value3 > 0 then
                    Argument2.TextSize = GetInstance.TextSize
                    return
                end

                local Parent4
                Argument2.TextSize = Argument2.TextSize - 1
                local Parent3 = GetInstance.Parent
                Parent4 = if Parent3 then Parent3.Parent else Parent3

                if Parent4 == nil then
                    X2 = 0
                elseif Parent4.IconImage.Visible == true then
                    X2 = Argument2.Frame.AbsoluteSize.X + GetInstance.Parent.Parent.IconImage.AbsoluteSize.X
                else
                    X2 = Parent4.AbsoluteSize.X
                end

                Value1, Value3 = GetSpinnerSizeAndDigitCount( )
            end
        end

        Argument1:addToJanitor( Argument2.Frame.ChildAdded:Connect( AdjustSize ) )
        Argument1:addToJanitor( Argument2.Frame.ChildRemoved:Connect( AdjustSize ) )
        Argument1:addToJanitor( Argument1.iconAdded:Connect( function()
            task.wait( 1 )
            AdjustSize( )
        end ) )
        Argument1:updateParent( )
        Argument2.Name = "LabelSpinner"
        Argument2.Prefix = "$"
        Argument2.Commas = true
        Argument2.Decimals = 0
        Argument2.Duration = 0.25
        Argument2.Value = 10
        task.wait( 0.2 )

        if typeof( Argument3 ) == "function" then
            Argument3( )
        end
    end )
    return Argument1
end
function __index.destroy( Argument1 )
    if Argument1.isDestroyed then
        return
    end

    Argument1:clearNotices( )

    if Argument1.parentIconUID then
        Argument1:leave( )
    end

    Argument1.isDestroyed = true
    Argument1.janitor:clean( )
    __index.iconRemoved:Fire( Argument1 )
end
__index.Destroy = __index.destroy
return __index
