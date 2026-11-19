-- StarterPlayer.StarterPlayerScripts.StashClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local TweenService = game:GetService( "TweenService" )
local GuiService = game:GetService( "GuiService" )
local LocalPlayer = Players.LocalPlayer
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ItemRender = require( Weapons:WaitForChild( "ItemRender" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ScaleUI = require( ReplicatedStorage:WaitForChild( "ScaleUI" ) )
local HitAudio = require( Weapons:WaitForChild( "HitAudio" ) )
local Inventory = require( Weapons:WaitForChild( "Inventory" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local LootShared = require( ReplicatedStorage:WaitForChild( "LootShared" ) )
local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "Notify", 10 ) )

if not Success then
    Result = nil
end

local Scale5
local Stash = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Stash" )
local Parent = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "Stash", math.huge )
Parent.Enabled = false
local Window = Parent:WaitForChild( "Window" )
local Count = Window:WaitForChild( "Count" )
local Close = Window:WaitForChild( "Close" )
local Carried = Window:WaitForChild( "Carried" )
local NoWeapon = Window:WaitForChild( "NoWeapon" )
local Parent2 = Window:WaitForChild( "Grid" )
local Cell = Parent2:WaitForChild( "Cell" )
Cell.Visible = false
Cell.Parent = nil
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
Scale5 = UIScale and UIScale.Scale or 1
local Find2
local Number = 50
local GamePasses = require( ReplicatedStorage:WaitForChild( "GamePasses" ) )
local Find = GamePasses.Find( "StashPlus" )
Find2 = if Find then Find else { }
local UIPadding2
local MaxSlots = Find2.MaxSlots or 100
local Plus = Parent2:FindFirstChild( "Plus" )
local UIPadding = Parent2:FindFirstChildOfClass( "UIPadding" )
UIPadding2 = if UIPadding then {
    t = UIPadding.PaddingTop.Scale,
    b = UIPadding.PaddingBottom.Scale,
    l = UIPadding.PaddingLeft.Scale,
    r = UIPadding.PaddingRight.Scale
} else UIPadding

if UIPadding then
    UIPadding:SetAttribute( "OffsetOK", true )
end

local Scale3

local function FixPadding()
    if not UIPadding then
        return
    end

    local AbsoluteSize = Parent2.AbsoluteSize

    if AbsoluteSize.Y < 1 then
        return
    end
    UIPadding.PaddingTop = UDim.new( 0, ( math.ceil( ( UIPadding2.t + 0.006 ) * AbsoluteSize.Y ) ) )
    UIPadding.PaddingBottom = UDim.new( 0, ( math.ceil( ( UIPadding2.b + 0.006 ) * AbsoluteSize.Y ) ) )
    UIPadding.PaddingLeft = UDim.new( 0, ( math.ceil( UIPadding2.l * AbsoluteSize.X ) ) )
    UIPadding.PaddingRight = UDim.new( 0, ( math.ceil( UIPadding2.r * AbsoluteSize.X ) ) )
    return
end

Parent2:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( FixPadding )
FixPadding( )
local Table = { }
local Flag = false
local Flag2 = false
local Flag3 = false
local Table2 = {
    far = "Stand in the blue circle",
    full = "Your safe is full",
    owned = "You already carry this weapon",
    starter = "Your starter weapon can't be stored",
    notweapon = "This can't be stored",
    wait = "",
    loading = "Loading, try again",
    invfull = "Your inventory is full",
    combat = "You can't use your safe during combat",
    lastweapon = "Keep a weapon in your hotbar",
    basecar = "Your starter car can't be stored"
}

local function Err( Key )
    local Entry = Table2[ Key ]

    if Entry == "" then
        return
    end

    local Entry2 = Entry or "Something went wrong, try again"

    if not Result or not Result.Error then
        warn( "[Safe] " .. Entry2 )
        return
    end
    Result.Error( Entry2 )
    return
end

local VehicleCrates = require( ReplicatedStorage:WaitForChild( "VehicleCrates" ) )

local function FakeTool( Argument1, Argument2 )
    return {
        GetAttribute = function( Argument1Inner, Name )
            if Argument2 == "V" then
                local Captured = Name == "Vehicle" and Argument1 or nil
                return Captured
            end
            if Argument2 then
                local Captured2 = Name == "Item" and Argument1 or nil
                return Captured2
            end
            if Name == "Weapon" and WeaponData[ Argument1 ] then
                return Argument1
            end
            if Name ~= "Melee" or WeaponData[ Argument1 ] then
                return nil
            end
            return Argument1
        end
    }
end

local Table3 = { }

local function GradFor( ForName )
    if not Table3[ ForName ] then
        local Entry2
        local Entry = ItemRender.TILE_GRAD[ ForName ]
        Entry2 = if Entry then Entry else ItemRender.TILE_GRAD.gun
        local Keypoints = Entry2.Keypoints
        local Value = Keypoints[ 1 ].Value
        local Value2 = Keypoints[ #Keypoints ].Value
        Table3[ ForName ] = ColorSequence.new( {
            ColorSequenceKeypoint.new( 0, Value2 ),
            ColorSequenceKeypoint.new( 0.5, Value ),
            ColorSequenceKeypoint.new( 1, Value2 )
        } )
    end

    return Table3[ ForName ]
end

local BackgroundTransparency = Cell.BackgroundTransparency
local AmmoBar = Cell:FindFirstChild( "AmmoBar" )

if AmmoBar then
    local Scale = AmmoBar.Size.X.Scale

    if Scale then
        Scale3 = Scale
    else
        Scale3 = 0.87
    end
else
    Scale3 = 0.87
end

local Scale4

if AmmoBar then
    local Scale2 = AmmoBar.Size.Y.Scale

    if Scale2 then
        Scale4 = Scale2
    else
        Scale4 = 0.09
    end
else
    Scale4 = 0.09
end

local function NameOf( Key )
    local Info = VehicleCrates.Info( Key )

    if Info and Info.Name then
        return Info.Name
    end

    local Entry = WeaponData[ Key ]

    if Entry and Entry.Name then
        return Entry.Name
    end

    local Value1
    local Table = {
        ReplicatedStorage:FindFirstChild( "BetaRollWeapons" ),
        game:GetService( "StarterPack" )
    }
    Value1 = nil

    for Key2, Value in Table, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value2 = nil

        for Key3, Value3 in Children, nil, nil do
            local Item
            local Weapon = Value3:GetAttribute( "Weapon" )

            if Weapon then
                Item = Weapon
            else
                local Melee = Value3:GetAttribute( "Melee" )

                if Melee then
                    Item = Melee
                else
                    Item = Value3:GetAttribute( "Item" )
                end
            end
            if Item == Key then
                local DisplayName2
                local DisplayName = Value3:GetAttribute( "DisplayName" )
                DisplayName2 = if DisplayName then DisplayName else Value3.Name
                return DisplayName2
            end
        end
    end

    return Key
end

local function Paint( Self, Object, Key, Amount, Argument5, Text, Text2 )
    local Icon = Self:FindFirstChild( "Icon" )
    local AmmoBar = Self:FindFirstChild( "AmmoBar" )
    local Ammo = Self:FindFirstChild( "Ammo" )
    local UIGradient = Self:FindFirstChildOfClass( "UIGradient" )

    if Key then
        Self.BackgroundTransparency = 0.1

        if UIGradient then
            UIGradient.Color = GradFor( ItemRender.Category( Object or {
                GetAttribute = function( Argument1, Name )
                    if Argument5 == "V" then
                        local Captured = Name == "Vehicle" and Key or nil
                        return Captured
                    end
                    if Argument5 then
                        local Captured2 = Name == "Item" and Key or nil
                        return Captured2
                    end
                    if Name == "Weapon" and WeaponData[ Key ] then
                        return Key
                    end
                    if Name ~= "Melee" or WeaponData[ Key ] then
                        return nil
                    end
                    return Key
                end
            } ) )
            UIGradient.Enabled = true
        end
        if Icon then
            Icon.Visible = true
            local Vehicle = ( Object or {
                GetAttribute = function( Argument1, Name )
                    if Argument5 == "V" then
                        local Captured = Name == "Vehicle" and Key or nil
                        return Captured
                    end
                    if Argument5 then
                        local Captured2 = Name == "Item" and Key or nil
                        return Captured2
                    end
                    if Name == "Weapon" and WeaponData[ Key ] then
                        return Key
                    end
                    if Name ~= "Melee" or WeaponData[ Key ] then
                        return nil
                    end
                    return Key
                end
            } ):GetAttribute( "Vehicle" ) or nil
            local Icon2 = ItemRender.Icon( Object or {
                GetAttribute = function( Argument1, Name )
                    if Argument5 == "V" then
                        local Captured = Name == "Vehicle" and Key or nil
                        return Captured
                    end
                    if Argument5 then
                        local Captured2 = Name == "Item" and Key or nil
                        return Captured2
                    end
                    if Name == "Weapon" and WeaponData[ Key ] then
                        return Key
                    end
                    if Name ~= "Melee" or WeaponData[ Key ] then
                        return nil
                    end
                    return Key
                end
            } )
            local SetIcon = ItemRender.SetIcon
            SetIcon( Icon, Icon2 or "" )
            ItemRender.CarArt( Icon, Vehicle, Icon2 )
        end
        if AmmoBar then
            local Visible

            if Amount == nil then
                Visible = false
            elseif Amount > 0 then
                Visible = true
            else
                Visible = false
            end

            AmmoBar.Visible = Visible

            if Amount then
                AmmoBar.Size = UDim2.fromScale( Scale3 * math.clamp( Amount, 0, 1 ), Scale4 )
            end
        end
        if Ammo then
            local Text5
            local Number = tonumber( Text )
            local NameOf2 = NameOf( Key )

            if Argument5 ~= true or not Number or not ( Number > 1 ) then
                Text5 = ""
            else
                local Text3 = " x" .. math.floor( Number )

                if Text3 then
                    Text5 = Text3
                else
                    Text5 = ""
                end
            end

            local Text6

            if tonumber( Text2 ) then
                local Text4 = "  " .. LootShared.WeightText( Text2 )

                if Text4 then
                    Text6 = Text4
                else
                    Text6 = ""
                end
            else
                Text6 = ""
            end

            Ammo.Text = NameOf2 .. Text5 .. Text6
        end

        return
    end
    Self.BackgroundTransparency = BackgroundTransparency

    if UIGradient then
        UIGradient.Enabled = false
    end
    if Icon then
        ItemRender.SetIcon( Icon, "" )
        Icon.Visible = false
    end
    if Icon then
        ItemRender.CarArt( Icon, nil )
    end
    if AmmoBar then
        AmmoBar.Visible = false
    end
    if Ammo then
        Ammo.Text = ""
    end

    return
end

local Table4 = { }
local Table5 = { }
local I = 1

for I = 1, MaxSlots do
    local Visible
    local Clone = Cell:Clone( )
    Clone.Name = "Cell" .. I
    Clone.LayoutOrder = I
    Visible = I <= Number and true or false
    Clone.Visible = Visible
    Clone.Parent = Parent2
    Table4[ I ] = Clone
    Table5[ Clone ] = I
end

local Hint2
local CarriedLabel = Window:WaitForChild( "CarriedLabel" )
local Hint = Window:FindFirstChild( "Hint" )
Hint2 = if Hint then Hint.Text else Hint
local Ghost2
local Highlight = Carried:FindFirstChild( "Highlight" )
local Ghost = Parent:WaitForChild( "Ghost", 5 )

if Ghost then
    Ghost2 = Ghost
else
    local Clone2 = Cell:Clone( )
    Clone2.Name = "Ghost"
    Clone2.ZIndex = 20
    Clone2.Parent = Parent
    Ghost2 = Clone2
end

local Value4
Ghost2.Visible = false
Ghost2.Active = false
Ghost2.Selectable = false
local Table6 = { }
local Table7 = { }
local Table8 = { }
local Value1 = nil
local Value2 = nil
local Value3 = nil

local function KeyOf( Self )
    local Item
    local Weapon = Self:GetAttribute( "Weapon" )

    if Weapon then
        Item = Weapon
    else
        local Melee = Self:GetAttribute( "Melee" )

        if Melee then
            Item = Melee
        else
            Item = Self:GetAttribute( "Item" )
        end
    end

    return Item
end

local function FracOf( Argument1 )
    local D4

    if not Argument1 or not Argument1.M then
        D4 = nil
    else
        local D2
        local D = Argument1.D
        D2 = if D then D else Argument1.M
        local D3 = D2 / Argument1.M

        if D3 then
            D4 = D3
        else
            D4 = nil
        end
    end

    return D4
end

local function IsSource( Argument1, Argument2 )
    local Flag

    if Value1 == nil or Value1.kind ~= Argument1 or Value1.from ~= Argument2 then
        if Value3 == nil then
            Flag = false
        elseif Value3.kind == Argument1 then
            if Value3.from == Argument2 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = true
    end

    return Flag
end

local function Dim( Self, Argument2 )
    local Icon = Self:FindFirstChild( "Icon" )
    local Ammo = Self:FindFirstChild( "Ammo" )
    local AmmoBar = Self:FindFirstChild( "AmmoBar" )

    if Icon then
        local ImageTransparency = not Argument2 and 0 or 0.6
        Icon.ImageTransparency = ImageTransparency
    end
    if Ammo then
        Ammo.Visible = not Argument2
    end
    if Argument2 then
        if AmmoBar then
            AmmoBar.Visible = false
        end

        Self.BackgroundTransparency = 0.5
    end
end

local function SetStroke( Object, Name, Argument3 )
    local FoundChild = Object:FindFirstChild( Name )

    if FoundChild then
        local Transparency = not Argument3 and 1 or 0
        FoundChild.Transparency = Transparency
    end
end

local function Decorate()
    local Value1Inner = nil

    for Key, Value in Table4, nil, nil do
        local Flag3

        if Value1 == nil or Value1.kind ~= "grid" or Value1.from ~= Key then
            if Value3 == nil then
                Flag3 = false
            elseif Value3.kind == "grid" then
                if Value3.from == Key then
                    Flag3 = true
                else
                    Flag3 = false
                end
            else
                Flag3 = false
            end
        else
            Flag3 = true
        end

        local Icon2 = Value:FindFirstChild( "Icon" )
        local Ammo2 = Value:FindFirstChild( "Ammo" )
        local AmmoBar2 = Value:FindFirstChild( "AmmoBar" )

        if Icon2 then
            local ImageTransparency2 = not Flag3 and 0 or 0.6
            Icon2.ImageTransparency = ImageTransparency2
        end
        if Ammo2 then
            Ammo2.Visible = not Flag3
        end
        if Flag3 then
            if AmmoBar2 then
                AmmoBar2.Visible = false
            end

            Value.BackgroundTransparency = 0.5
        end

        local Flag5

        if Value1 == nil then
            Flag5 = false
        elseif Value2 == Key then
            local Flag4

            if Value1.kind == "grid" then
                if Value1.from == Key then
                    Flag4 = true
                else
                    Flag4 = false
                end
            else
                Flag4 = false
            end

            Flag5 = not Flag4
        else
            Flag5 = false
        end

        local HighlightInner = Value:FindFirstChild( "Highlight" )

        if HighlightInner then
            local Transparency3 = not Flag5 and 1 or 0
            HighlightInner.Transparency = Transparency3
        end

        local Flag6

        if Value3 == nil then
            Flag6 = false
        elseif Value3.kind == "grid" then
            if Value3.from == Key then
                Flag6 = true
            else
                Flag6 = false
            end
        else
            Flag6 = false
        end

        local Picked2 = Value:FindFirstChild( "Picked" )

        if Picked2 then
            local Transparency4 = not Flag6 and 1 or 0
            Picked2.Transparency = Transparency4
        end
    end

    local Value2Inner = nil

    for Key2, Value3Inner in Table6, nil, nil do
        local Flag
        local Entry = Table7[ Value3Inner ]

        if Value1 == nil or Value1.kind ~= "carried" or Value1.from ~= Entry then
            if Value3 == nil then
                Flag = false
            elseif Value3.kind == "carried" then
                if Value3.from == Entry then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = true
        end
        if not Flag then
            if Table8[ Entry ] == nil then
                Flag = false
            else
                Flag = true
            end
        end

        local Icon = Value3Inner:FindFirstChild( "Icon" )
        local Ammo = Value3Inner:FindFirstChild( "Ammo" )
        local AmmoBar = Value3Inner:FindFirstChild( "AmmoBar" )

        if Icon then
            local ImageTransparency = not Flag and 0 or 0.6
            Icon.ImageTransparency = ImageTransparency
        end
        if Ammo then
            Ammo.Visible = not Flag
        end
        if Flag then
            if AmmoBar then
                AmmoBar.Visible = false
            end

            Value3Inner.BackgroundTransparency = 0.5
        end
        if Table8[ Entry ] and Value3Inner:FindFirstChild( "Ammo" ) then
            Value3Inner.Ammo.Visible = true
        end

        local Flag2

        if Value3 == nil then
            Flag2 = false
        elseif Value3.kind == "carried" then
            if Value3.from == Entry then
                Flag2 = true
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end

        local Picked = Value3Inner:FindFirstChild( "Picked" )

        if Picked then
            local Transparency2 = not Flag2 and 1 or 0
            Picked.Transparency = Transparency2
        end
    end
    if Highlight then
        local Transparency = ( Value1 == nil or Value1.kind ~= "grid" or Value2 ~= "carried" ) and 1 or 0
        Highlight.Transparency = Transparency
    end
end

local function Redraw()
    local I = 1

    for I = 1, MaxSlots do
        local Visible
        local Entry = Table4[ I ]
        Visible = I <= Number and true or false
        Entry.Visible = Visible
    end

    local NumberInner
    local I2 = 1
    NumberInner = 0

    for I2 = 1, Number do
        local Entry2 = Table[ tostring( I2 ) ]

        if Entry2 then
            NumberInner = NumberInner + 1
        end

        local Entry4
        local Entry3 = Table4[ I2 ]
        Entry4 = if Entry2 then Entry2.W else Entry2
        local D4

        if not Entry2 or not Entry2.M then
            D4 = nil
        else
            local D2
            local D = Entry2.D
            D2 = if D then D else Entry2.M
            local D3 = D2 / Entry2.M

            if D3 then
                D4 = D3
            else
                D4 = nil
            end
        end

        local Flag

        if Entry2 == nil then
            Flag = false
        elseif Entry2.T == "V" then
            Flag = "V"
        elseif Entry2.T == "I" then
            Flag = true
        else
            Flag = false
        end

        local Entry5 = if Entry2 then Entry2.C else Entry2
        local Entry6 = if Entry2 then Entry2.Kg else Entry2
        Paint( Entry3, nil, Entry4, D4, Flag, Entry5, Entry6 )
    end

    local Find = GamePasses.Find( "StashPlus" )

    if Plus then
        local Visible2

        if Number < MaxSlots then
            if not Find or not ( ( Find.Product or 0 ) > 0 ) then
                Visible2 = not GamePasses.Owned( LocalPlayer, "StashPlus" )
            else
                Visible2 = true
            end
        else
            Visible2 = false
        end

        Plus.Visible = Visible2
    end

    Count.Text = NumberInner .. "/" .. Number
    Decorate( )
end

local function PaintCarried()
    local Value1 = nil

    for Key, Value in Table6, nil, nil do
        local Item
        local Entry = Table7[ Value ]
        local Weapon = Entry:GetAttribute( "Weapon" )

        if Weapon then
            Item = Weapon
        else
            local Melee = Entry:GetAttribute( "Melee" )

            if Melee then
                Item = Melee
            else
                Item = Entry:GetAttribute( "Item" )
            end
        end
        if not Item then
            Item = Entry:GetAttribute( "Vehicle" )
        end

        local Flag
        local DurabilityFrac = ItemRender.DurabilityFrac( Entry )
        Flag = Entry:GetAttribute( "Item" ) ~= nil and true or false
        Paint( Value, Entry, Item, DurabilityFrac, Flag, Entry:GetAttribute( "Count" ), Entry:GetAttribute( "Kg" ) )
    end

    Decorate( )
end

local function Refresh()
    Redraw( )
    PaintCarried( )
end

local function Call( Name, Argument2, Argument3 )
    if Flag then
        return false
    end

    Flag = true
    local Success, ResultInner = pcall( Stash.InvokeServer, Stash, Name, Argument2, Argument3 )
    Flag = false

    if not Success or type( ResultInner ) ~= "table" or not ResultInner.ok then
        local Err = Success and type( ResultInner ) == "table" and ResultInner.err or nil
        local Entry = Table2[ Err ]

        if Entry ~= "" then
            local Entry2 = Entry or "Something went wrong, try again"

            if not Result or not Result.Error then
                warn( "[Safe] " .. Entry2 )
            else
                Result.Error( Entry2 )
            end
        end

        return false
    end
    local Slots2
    local Slots = ResultInner.Slots
    Slots2 = if Slots then Slots else Table
    Table = Slots2

    if tonumber( ResultInner.Size ) then
        Number = math.clamp( math.floor( ResultInner.Size ), 1, MaxSlots )
    end

    Redraw( )
    return true
end

local Callback = nil

local function Transfer( Name, Argument2, Argument3 )
    local Call2 = Call( Name, Argument2, Argument3 )

    if Call2 then
        HitAudio.Play( "InventoryDrop" )

        if Name ~= "Move" then
            task.defer( Callback )
        end
    end

    Redraw( )
    PaintCarried( )
    return Call2
end

local function MousePos()
    return UserInputService:GetMouseLocation( ) - GuiService:GetGuiInset( )
end

local function PointerPos( Argument1 )
    if Argument1.UserInputType == Enum.UserInputType.Touch then
        return Vector2.new( Argument1.Position.X, Argument1.Position.Y )
    end
    return UserInputService:GetMouseLocation( ) - GuiService:GetGuiInset( )
end

local function Inside( Argument1, Argument2 )
    local Flag
    local AbsolutePosition = Argument1.AbsolutePosition
    local AbsoluteSize = Argument1.AbsoluteSize
    local X = Argument2.X

    if AbsolutePosition.X <= X then
        if Argument2.X <= AbsolutePosition.X + AbsoluteSize.X then
            local Y = Argument2.Y

            if AbsolutePosition.Y <= Y then
                if Argument2.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local function TargetAt( Argument1 )
    local Flag
    local AbsolutePosition = Parent2.AbsolutePosition
    local AbsoluteSize = Parent2.AbsoluteSize
    local X = Argument1.X

    if AbsolutePosition.X <= X then
        if Argument1.X <= AbsolutePosition.X + AbsoluteSize.X then
            local Y = Argument1.Y

            if AbsolutePosition.Y <= Y then
                if Argument1.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end
    if Flag then
        local Value1 = nil

        for Key, Value in Table4, nil, nil do
            if Key <= Number then
                local Flag2
                local AbsolutePosition2 = Value.AbsolutePosition
                local AbsoluteSize2 = Value.AbsoluteSize
                local X2 = Argument1.X

                if AbsolutePosition2.X <= X2 then
                    if Argument1.X <= AbsolutePosition2.X + AbsoluteSize2.X then
                        local Y2 = Argument1.Y

                        if AbsolutePosition2.Y <= Y2 then
                            if Argument1.Y <= AbsolutePosition2.Y + AbsoluteSize2.Y then
                                Flag2 = true
                            else
                                Flag2 = false
                            end
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
                if Flag2 then
                    return Key
                end
            end
        end

        return nil
    end
    local Flag3
    local AbsolutePosition3 = Carried.AbsolutePosition
    local AbsoluteSize3 = Carried.AbsoluteSize
    local X3 = Argument1.X

    if AbsolutePosition3.X <= X3 then
        if Argument1.X <= AbsolutePosition3.X + AbsoluteSize3.X then
            local Y3 = Argument1.Y

            if AbsolutePosition3.Y <= Y3 then
                if Argument1.Y <= AbsolutePosition3.Y + AbsoluteSize3.Y then
                    Flag3 = true
                else
                    Flag3 = false
                end
            else
                Flag3 = false
            end
        else
            Flag3 = false
        end
    else
        Flag3 = false
    end
    if not Flag3 then
        local Flag4
        local AbsolutePosition4 = CarriedLabel.AbsolutePosition
        local AbsoluteSize4 = CarriedLabel.AbsoluteSize
        local X4 = Argument1.X

        if AbsolutePosition4.X <= X4 then
            if Argument1.X <= AbsolutePosition4.X + AbsoluteSize4.X then
                local Y4 = Argument1.Y

                if AbsolutePosition4.Y <= Y4 then
                    if Argument1.Y <= AbsolutePosition4.Y + AbsoluteSize4.Y then
                        Flag4 = true
                    else
                        Flag4 = false
                    end
                else
                    Flag4 = false
                end
            else
                Flag4 = false
            end
        else
            Flag4 = false
        end
        if not Flag4 then
            return nil
        end
    end

    return "carried"
end

local function CarriedAt( Argument1 )
    local Value1 = nil

    for Key, Value in Table6, nil, nil do
        local Flag
        local AbsolutePosition = Value.AbsolutePosition
        local AbsoluteSize = Value.AbsoluteSize
        local X = Argument1.X

        if AbsolutePosition.X <= X then
            if Argument1.X <= AbsolutePosition.X + AbsoluteSize.X then
                local Y = Argument1.Y

                if AbsolutePosition.Y <= Y then
                    if Argument1.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end
        if Flag then
            return Table7[ Value ]
        end
    end

    return nil
end

local function PlaceGhost( Argument1 )
    local Grab = Argument1 - Value1.grab - Parent.AbsolutePosition
    Ghost2.Position = ScaleUI.FromAbs( Ghost2, Grab.X, Grab.Y )
end

local function IsPointer( Argument1 )
    local Flag

    if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
        Flag = true
    elseif Argument1.UserInputType == Enum.UserInputType.Touch then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function BeginDrag( DragName, DragName2, Argument3, Argument4 )
    if Flag2 and not Flag and not Value1 then
        local FlagInner

        if Argument4.UserInputType == Enum.UserInputType.MouseButton1 then
            FlagInner = true
        elseif Argument4.UserInputType == Enum.UserInputType.Touch then
            FlagInner = true
        else
            FlagInner = false
        end
        if FlagInner then
            if DragName ~= "carried" or not Table8[ DragName2 ] then
                if Controls.IsGamepad then
                    return
                end
                if DragName == "grid" and not Table[ tostring( DragName2 ) ] then
                    return
                end

                local Vector22

                if Argument4.UserInputType == Enum.UserInputType.Touch then
                    Vector22 = Vector2.new( Argument4.Position.X, Argument4.Position.Y )
                else
                    Vector22 = UserInputService:GetMouseLocation( ) - GuiService:GetGuiInset( )
                end

                Value3 = nil
                Value1 = {
                    kind = DragName,
                    from = DragName2,
                    grab = Vector22 - Argument3.AbsolutePosition,
                    start = Vector22
                }
                Value2 = TargetAt( Vector22 )
                Ghost2.Size = ScaleUI.FromAbs( Ghost2, Argument3.AbsoluteSize.X, Argument3.AbsoluteSize.Y )

                if DragName == "grid" then
                    local D4
                    local Entry3 = Table[ tostring( DragName2 ) ]
                    local W = Entry3.W

                    if not Entry3 or not Entry3.M then
                        D4 = nil
                    else
                        local D2
                        local D = Entry3.D
                        D2 = if D then D else Entry3.M
                        local D3 = D2 / Entry3.M

                        if D3 then
                            D4 = D3
                        else
                            D4 = nil
                        end
                    end

                    local Text

                    if Entry3.T == "V" then
                        Text = "V"
                    elseif Entry3.T == "I" then
                        Text = true
                    else
                        Text = false
                    end

                    Paint( Ghost2, nil, W, D4, Text, Entry3.C, Entry3.Kg )
                else
                    local Item
                    local Weapon = DragName2:GetAttribute( "Weapon" )

                    if Weapon then
                        Item = Weapon
                    else
                        local Melee = DragName2:GetAttribute( "Melee" )

                        if Melee then
                            Item = Melee
                        else
                            Item = DragName2:GetAttribute( "Item" )
                        end
                    end
                    if not Item then
                        Item = DragName2:GetAttribute( "Vehicle" )
                    end

                    local Flag2Inner
                    local DurabilityFrac = ItemRender.DurabilityFrac( DragName2 )
                    Flag2Inner = DragName2:GetAttribute( "Item" ) ~= nil and true or false
                    Paint( Ghost2, DragName2, Item, DurabilityFrac, Flag2Inner, DragName2:GetAttribute( "Count" ), DragName2:GetAttribute( "Kg" ) )
                end

                local Vector23 = Vector22 - Value1.grab - Parent.AbsolutePosition
                Ghost2.Position = ScaleUI.FromAbs( Ghost2, Vector23.X, Vector23.Y )
                Ghost2.Visible = true
                Redraw( )
                PaintCarried( )
                return
            end
            local Entry = Table2[ Table8[ DragName2 ] ]

            if Entry == "" then
                return
            end

            local Entry2 = Entry or "Something went wrong, try again"

            if not Result or not Result.Error then
                warn( "[Safe] " .. Entry2 )
                return
            end
            Result.Error( Entry2 )
            return
        end
    end
end

local function EndDrag( Argument1 )
    if not Value1 then
        return
    end

    local Vector22
    Value1 = nil
    Value2 = nil
    Ghost2.Visible = false

    if Argument1 then
        if Argument1.UserInputType == Enum.UserInputType.Touch then
            Vector22 = Vector2.new( Argument1.Position.X, Argument1.Position.Y )
        else
            Vector22 = UserInputService:GetMouseLocation( ) - GuiService:GetGuiInset( )
        end
        if not Vector22 then
            Vector22 = UserInputService:GetMouseLocation( ) - GuiService:GetGuiInset( )
        end
    else
        Vector22 = UserInputService:GetMouseLocation( ) - GuiService:GetGuiInset( )
    end

    local Flag
    local TargetAt2 = TargetAt( Vector22 )
    Flag = ( Vector22 - Value1.start ).Magnitude < 10 and true or false

    if Value1.kind == "grid" then
        if TargetAt2 == Value1.from and Flag then
            if Call( "Withdraw", Value1.from, nil ) then
                HitAudio.Play( "InventoryDrop" )
                task.defer( Callback )
            end

            Redraw( )
            PaintCarried( )
            return
        end
        if type( TargetAt2 ) ~= "number" or TargetAt2 == Value1.from then
            if TargetAt2 ~= "carried" then
                Redraw( )
                PaintCarried( )
                return
            end
            if Call( "Withdraw", Value1.from, nil ) then
                HitAudio.Play( "InventoryDrop" )
                task.defer( Callback )
            end

            Redraw( )
            PaintCarried( )
            return
        end
        if Call( "Move", Value1.from, TargetAt2 ) then
            HitAudio.Play( "InventoryDrop" )
        end

        Redraw( )
        PaintCarried( )
        return
    else
        if not Value1.from.Parent then
            Redraw( )
            PaintCarried( )
            return
        end
        if type( TargetAt2 ) == "number" then
            if Call( "Deposit", Value1.from, TargetAt2 ) then
                HitAudio.Play( "InventoryDrop" )
                task.defer( Callback )
            end

            Redraw( )
            PaintCarried( )
            return
        end
        if Flag then
            local Value2Inner, Entry
            Value2Inner = nil

            for Key, Value in Table6, nil, nil do
                local Flag2
                local AbsolutePosition = Value.AbsolutePosition
                local AbsoluteSize = Value.AbsoluteSize
                local X = Vector22.X

                if AbsolutePosition.X <= X then
                    if Vector22.X <= AbsolutePosition.X + AbsoluteSize.X then
                        local Y = Vector22.Y

                        if AbsolutePosition.Y <= Y then
                            if Vector22.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
                                Flag2 = true
                            else
                                Flag2 = false
                            end
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
                if Flag2 then
                    Entry = Table7[ Value ]

                    if Entry ~= Value1.from then
                        Redraw( )
                        PaintCarried( )
                        return
                    end
                    if Call( "Deposit", Value1.from, nil ) then
                        HitAudio.Play( "InventoryDrop" )
                        task.defer( Callback )
                    end

                    Redraw( )
                    PaintCarried( )
                    return
                end
            end

            Entry = nil

            if Entry == Value1.from then
                if Call( "Deposit", Value1.from, nil ) then
                    HitAudio.Play( "InventoryDrop" )
                    task.defer( Callback )
                end

                Redraw( )
                PaintCarried( )
                return
            end
        end

        Redraw( )
        PaintCarried( )
        return
    end
end

local function PadPress( p1, Key, p3 )
    -- Could not structure function #27
end

local function QuickMove( MoveName )
    if Flag or not MoveName then
        return
    end

    Value3 = nil
    local Entry = Table5[ MoveName ]
    local Entry2 = Table7[ MoveName ]

    if not Entry or not Table[ tostring( Entry ) ] then
        if not Entry2 or not Entry2.Parent then
            Redraw( )
            PaintCarried( )
            return
        end
        if Call( "Deposit", Entry2, nil ) then
            HitAudio.Play( "InventoryDrop" )
            task.defer( Callback )
        end

        Redraw( )
        PaintCarried( )
        return
    end
    if Call( "Withdraw", Entry, nil ) then
        HitAudio.Play( "InventoryDrop" )
        task.defer( Callback )
    end

    Redraw( )
    PaintCarried( )
    return
end

Value4 = nil

for Key, Value in Table4, nil, nil do
    Value.InputBegan:Connect( function( Argument1 )
        BeginDrag( "grid", Key, Value, Argument1 )
    end )
    Value.Activated:Connect( function( Argument1 )
        PadPress( "grid", Key, Argument1 )
    end )
end

UserInputService.InputChanged:Connect( function( Argument1 )
    if not Value1 then
        return
    end

    local MouseLocation

    if Argument1.UserInputType == Enum.UserInputType.MouseMovement then
        MouseLocation = UserInputService:GetMouseLocation( ) - GuiService:GetGuiInset( )
        local MouseLocation2 = MouseLocation - Value1.grab - Parent.AbsolutePosition
        Ghost2.Position = ScaleUI.FromAbs( Ghost2, MouseLocation2.X, MouseLocation2.Y )
        local TargetAt2 = TargetAt( MouseLocation )

        if TargetAt2 ~= Value2 then
            Value2 = TargetAt2
            Decorate( )
        end

        return
    end
    if Argument1.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    MouseLocation = Vector2.new( Argument1.Position.X, Argument1.Position.Y )
    local MouseLocation2 = MouseLocation - Value1.grab - Parent.AbsolutePosition
    Ghost2.Position = ScaleUI.FromAbs( Ghost2, MouseLocation2.X, MouseLocation2.Y )
    local TargetAt2 = TargetAt( MouseLocation )

    if TargetAt2 ~= Value2 then
        Value2 = TargetAt2
        Decorate( )
    end

    return
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    if Value1 then
        local Flag

        if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
            Flag = true
        elseif Argument1.UserInputType == Enum.UserInputType.Touch then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            EndDrag( Argument1 )
        end
    end
end )

local function Storable( Self )
    if Self:IsA( "Tool" ) and Self:GetAttribute( "Vehicle" ) and Self:GetAttribute( "CarId" ) then
        return true
    end
    if Self:IsA( "Tool" ) and Self:GetAttribute( "Vehicle" ) and ReplicatedStorage:GetAttribute( "StarterCarStashable" ) == true then
        return true
    end

    local IsA2
    local IsA = Self:IsA( "Tool" )

    if IsA then
        local Item
        local Weapon = Self:GetAttribute( "Weapon" )

        if Weapon then
            Item = Weapon
        else
            local Melee = Self:GetAttribute( "Melee" )

            if Melee then
                Item = Melee
            else
                Item = Self:GetAttribute( "Item" )
            end
        end
        if Item == nil then
            IsA2 = false
        else
            local NotVehicle = not Self:GetAttribute( "Vehicle" )

            if NotVehicle then
                local NotAdminTest = not Self:GetAttribute( "AdminTest" )

                if NotAdminTest then
                    local Unbreakable2
                    local Unbreakable = Self:GetAttribute( "Unbreakable" )

                    if Unbreakable then
                        if game:GetService( "ReplicatedStorage" ):GetAttribute( "StarterStashable" ) == true then
                            Unbreakable2 = false
                        else
                            Unbreakable2 = true
                        end
                    else
                        Unbreakable2 = Unbreakable
                    end

                    local NotUnbreakable = not Unbreakable2

                    if NotUnbreakable then
                        IsA2 = not Self:GetAttribute( "TestKit" )
                    else
                        IsA2 = NotUnbreakable
                    end
                else
                    IsA2 = NotAdminTest
                end
            else
                IsA2 = NotVehicle
            end
        end
    else
        IsA2 = IsA
    end

    return IsA2
end

local Table9 = { }

local function SizeCarried()
    local UIGridLayout = Parent2:FindFirstChildOfClass( "UIGridLayout" )
    local UIGridLayout2 = Carried:FindFirstChildOfClass( "UIGridLayout" )

    if UIGridLayout and UIGridLayout2 then
        local CellSize = UIGridLayout.CellSize
        local CellPadding = UIGridLayout.CellPadding
        UIGridLayout2.CellSize = CellSize
        UIGridLayout2.CellPadding = CellPadding
    end
end

Callback = function()
    local Value1Inner = nil

    for Key, Value in Table6, nil, nil do
        Value:Destroy( )
    end

    local Value2Inner
    table.clear( Table6 )
    table.clear( Table7 )
    Value2Inner = nil

    for Key2, Value3Inner in Table9, nil, nil do
        Value3Inner:Disconnect( )
    end

    local Value4
    table.clear( Table9 )
    local Table = { }
    table.clear( Table8 )
    local Table2 = {
        LocalPlayer.Character,
        LocalPlayer:FindFirstChildOfClass( "Backpack" )
    }
    Value4 = nil

    for Key3, Value5 in Table2, nil, nil do
        local Children = Value5 and Value5:GetChildren( ) or { }
        local Value9 = nil

        for Key6, Value10 in Children, nil, nil do
            if Storable( Value10 ) then
                table.insert( Table, Value10 )
            elseif Value10:IsA( "Tool" ) then
                if Value10:GetAttribute( "Weapon" ) or Value10:GetAttribute( "Melee" ) or Value10:GetAttribute( "Item" ) or Value10:GetAttribute( "Vehicle" ) then
                    local Text
                    table.insert( Table, Value10 )

                    if Value10:GetAttribute( "Vehicle" ) then
                        Text = "basecar"
                    elseif Value10:GetAttribute( "Unbreakable" ) then
                        Text = "starter"
                    else
                        Text = "notweapon"
                    end

                    Table8[ Value10 ] = Text
                end
            end
        end
    end

    local Table3 = { }

    for Key4, Value6 in Inventory.Layout( ) do
        Table3[ Value6 ] = Key4
    end

    local Count = #Table
    local I = Count

    for I = Count, 1, -1 do
        if Table3[ Table[ I ] ] == Inventory.FISTS then
            table.remove( Table, I )
        end
    end

    table.sort( Table, function( Key, Key2 )
        local Entry = Table3[ Key ] or 99
        local Entry2 = Table3[ Key2 ] or 99

        if Entry == Entry2 then
            local Flag2 = Key.Name .. tostring( Key:GetAttribute( "CopyId" ) or "" ) < Key2.Name .. tostring( Key2:GetAttribute( "CopyId" ) or "" ) and true or false
            return Flag2
        end
        local Flag = Entry < Entry2 and true or false
        return Flag
    end )

    if Value1 and Value1.kind == "carried" and not table.find( Table, Value1.from ) then
        Value1 = nil
        Value2 = nil
        Ghost2.Visible = false
    end
    if Value3 and Value3.kind == "carried" and not table.find( Table, Value3.from ) then
        Value3 = nil
    end

    local Value7 = nil

    for Key5, Value8 in Table, nil, nil do
        local Clone = Cell:Clone( )
        Clone.Name = "Carried" .. Key5
        Clone.Visible = true
        Clone.LayoutOrder = Key5
        Table7[ Clone ] = Value8
        Clone.InputBegan:Connect( function( Argument1 )
            BeginDrag( "carried", Value8, Clone, Argument1 )
        end )
        Clone.Activated:Connect( function( Argument1 )
            PadPress( "carried", Value8, Argument1 )
        end )
        Clone.Parent = Carried
        table.insert( Table6, Clone )

        if Value8:GetAttribute( "Item" ) then
            table.insert( Table9, Value8:GetAttributeChangedSignal( "Count" ):Connect( function()
                if Flag2 then
                    PaintCarried( )
                end
            end ) )
        end
    end

    local UIGridLayout = Parent2:FindFirstChildOfClass( "UIGridLayout" )
    local UIGridLayout2 = Carried:FindFirstChildOfClass( "UIGridLayout" )

    if UIGridLayout and UIGridLayout2 then
        local CellSize = UIGridLayout.CellSize
        local CellPadding = UIGridLayout.CellPadding
        UIGridLayout2.CellSize = CellSize
        UIGridLayout2.CellPadding = CellPadding
    end

    local Visible = #Table == 0 and true or false
    NoWeapon.Visible = Visible
    PaintCarried( )
end

local Table10 = { }
Inventory.Changed.Event:Connect( function()
    if Flag2 then
        task.defer( Callback )
    end
end )
NoWeapon.Text = "Nothing to store​⁠​⁠​⁠​⁠​⁠​⁠​​⁠​​​​⁠​⁠⁠⁠"

local function Watch()
    local Value1 = nil

    for Key, Value in Table10, nil, nil do
        Value:Disconnect( )
    end

    local Value2
    table.clear( Table10 )
    local Table = {
        LocalPlayer.Character,
        LocalPlayer:FindFirstChildOfClass( "Backpack" )
    }
    Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        if Value3 then
            table.insert( Table10, Value3.ChildAdded:Connect( function()
                if Flag2 then
                    task.defer( Callback )
                end
            end ) )
            table.insert( Table10, Value3.ChildRemoved:Connect( function()
                if Flag2 then
                    task.defer( Callback )
                end
            end ) )
        end
    end
end

local Value5 = nil
local Number2 = 0

local function SetOpen( Open )
    if Flag2 == Open then
        return
    end

    Flag2 = Open
    Number2 = Number2 + 1
    Value1 = nil
    Value2 = nil
    Value3 = nil
    Ghost2.Visible = false

    if Value5 then
        Value5:Cancel( )
        Value5 = nil
    end
    if Open then
        local Success, Result = pcall( Stash.InvokeServer, Stash, "State" )

        if Number2 ~= Number2 then
            return
        end
        if Success and type( Result ) == "table" and Result.ok then
            local Slots2
            local Slots = Result.Slots
            Slots2 = if Slots then Slots else { }
            Table = Slots2

            if tonumber( Result.Size ) then
                Number = math.clamp( math.floor( Result.Size ), 1, MaxSlots )
            end
        end

        Redraw( )
        Watch( )
        Callback( )
        Parent2.CanvasPosition = Vector2.zero

        if Hint and Hint2 then
            local Text = if Controls.IsGamepad then "A: pick / place  ·  X: quick store / take  ·  B to close" else Hint2
            Hint.Text = Text
        end
        if UIScale then
            UIScale.Scale = 0.92 * Scale5
        end

        Parent.Enabled = true
        ClientState.ActiveMenu = "Stash"

        if UIScale then
            Value5 = TweenService:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Scale5 } )
            Value5:Play( )
        end

        local First
        local Open2 = GamepadNav.Open
        local TableInner = {
            root = Parent,
            freeze = false,
            backLabel = "Close",
            selectLabel = "Take / Place"
        }
        local Item = Table6[ 1 ]
        First = if Item then Item else Table4[ 1 ]
        TableInner.first = First
        TableInner.actions = {
            [ Enum.KeyCode.ButtonX ] = {
                label = "Quick move",
                fn = function()
                    QuickMove( GuiService.SelectedObject )
                end
            }
        }
        function TableInner.onBack()
            if Value3 then
                Value3 = nil
                Redraw( )
                PaintCarried( )
                return
            end
            Flag3 = true
            SetOpen( false )
            return
        end
        Open2( "Stash", TableInner )
        return
    end
    Parent.Enabled = false

    if UIScale then
        UIScale.Scale = Scale5
    end

    local Value1Inner = nil

    for Key, Value in Table10, nil, nil do
        Value:Disconnect( )
    end

    table.clear( Table10 )
    GamepadNav.Close( "Stash" )
    return
end

Close.Activated:Connect( function()
    Flag3 = true

    if Flag2 == false then
        return
    end

    Flag2 = false
    Number2 = Number2 + 1
    Value1 = nil
    Value2 = nil
    Value3 = nil
    Ghost2.Visible = false

    if Value5 then
        Value5:Cancel( )
        Value5 = nil
    end

    Parent.Enabled = false

    if UIScale then
        UIScale.Scale = Scale5
    end

    local Value1Inner = nil

    for Key, Value in Table10, nil, nil do
        Value:Disconnect( )
    end

    table.clear( Table10 )
    GamepadNav.Close( "Stash" )
end )

local function ReloadState()
    if not Flag2 then
        return
    end

    local Success, Result = pcall( Stash.InvokeServer, Stash, "State" )

    if Success and type( Result ) == "table" and Result.ok then
        local Slots2
        local Slots = Result.Slots
        Slots2 = if Slots then Slots else Table
        Table = Slots2

        if tonumber( Result.Size ) then
            Number = math.clamp( math.floor( Result.Size ), 1, MaxSlots )
        end
    end

    Redraw( )
end

if Plus then
    Plus.Visible = false
    local Value6 = nil

    local function BuyPlus()
        if not Flag2 then
            return
        end

        local Find = GamePasses.Find( "StashPlus" )

        if not Find or not ( ( Find.Product or 0 ) > 0 ) then
            if Find and not ( ( Find.PassId or 0 ) <= 0 ) then
                GamePasses.Offer( "StashPlus", function()
                    task.delay( 1, ReloadState )
                end )
                return
            end
            if Result and Result.Error then
                Result.Error( "Coming soon" )
            end

            return
        end
        Value6 = Value6 or require( ReplicatedStorage:WaitForChild( "RobuxShopUI" ) )
        Value6.Buy( "Slots", "StashPlus" )
        return
    end

    Plus.Activated:Connect( BuyPlus )
end

LocalPlayer:GetAttributeChangedSignal( "StashPlus" ):Connect( function()
    task.defer( ReloadState )
end )
LocalPlayer:GetAttributeChangedSignal( "StashPacks" ):Connect( function()
    task.defer( ReloadState )
end )

local function InCircle()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not HumanoidRootPart or Character:GetAttribute( "Downed" ) then
        return false
    end
    if LocalPlayer:GetAttribute( "InTutorial" ) then
        return false
    end

    local Interactions2
    local Interactions = workspace:FindFirstChild( "Interactions" )
    Interactions2 = if Interactions then Interactions else workspace

    for Key, Value in Interactions2:GetChildren( ) do
        if Value:GetAttribute( "Stash" ) then
            local BoundingBox

            if not Value:IsA( "Model" ) or not Value:GetBoundingBox( ) then
                local IsA = Value:IsA( "BasePart" )

                if IsA then
                    BoundingBox = Value.CFrame
                else
                    BoundingBox = IsA
                end
            else
                BoundingBox = Value:GetBoundingBox( )
            end
            if BoundingBox then
                local Position = HumanoidRootPart.Position - BoundingBox.Position
                local X = Position.X

                if Vector3.new( X, 0, Position.Z ).Magnitude <= 3.6 then
                    if math.abs( Position.Y ) < 6 then
                        return true
                    end
                end
            end
        end
    end

    return false
end

task.spawn( function()
    while true do
        task.wait( 0.2 )
        local InCircle2 = InCircle( )

        if not InCircle2 then
            Flag3 = false
        end

        local ActiveMenu = ClientState.ActiveMenu

        if Flag2 and ActiveMenu ~= nil and ActiveMenu ~= "Stash" then
            Flag3 = true
        end

        local NotCaptured = if InCircle2 then not Flag3 else InCircle2
        SetOpen( NotCaptured )
    end
end )
LocalPlayer.CharacterAdded:Connect( function()
    if Flag2 then
        Watch( )
        Callback( )
    end
end )
