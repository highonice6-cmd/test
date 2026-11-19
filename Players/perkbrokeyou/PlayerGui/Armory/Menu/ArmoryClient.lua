-- Players.perkbrokeyou.PlayerGui.Armory.Menu.ArmoryClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Storage = { }
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
game:GetService( "GuiService" )
local ContextActionService = game:GetService( "ContextActionService" )
local LocalPlayer = Players.LocalPlayer
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local Parent = script.Parent
local Main = Parent:WaitForChild( "Main" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ModCatalog = require( Weapons:WaitForChild( "ModCatalog" ) )
local LimitedPacks = require( ReplicatedStorage:WaitForChild( "LimitedPacks" ) )
local ItemRender = require( Weapons:WaitForChild( "ItemRender" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local MeleeData = require( Weapons:WaitForChild( "MeleeData" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local GunAudio = require( Weapons:WaitForChild( "GunAudio" ) )
local AttachmentCases = require( ReplicatedStorage:WaitForChild( "AttachmentCases" ) )

local function IsLocked( Argument1 )
    local Lockable2
    local Lockable = AttachmentCases.Lockable( Argument1 )
    Lockable2 = if Lockable then not AttachmentCases.Unlocked( LocalPlayer, Argument1 ) else Lockable
    return Lockable2
end

local Remotes = ReplicatedStorage:WaitForChild( "Remotes" )
local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local WeaponMods = ReplicatedStorage:WaitForChild( "WeaponMods" )
local CurrentCamera = workspace.CurrentCamera
local Value1 = nil
local Table = { G15 = 0.4 }
local FromRGB = Color3.fromRGB( 80, 220, 120 )
Color3.fromRGB( 255, 166, 48 )
local FromRGB2 = Color3.fromRGB( 14, 14, 18 )
local Table2 = {
    Optic = "Sights",
    Muzzle = "Muzzle",
    Underbarrel = "Underbarrel",
    Rail = "Laser / Light",
    Mag = "Magazine",
    Camo = "Camos",
    Sound = "Shot Sound",
    Skin = "Skins"
}
local Table3 = {
    reflex = "Red Dot",
    HoloPoint = "Holographic",
    DoubleSight = "Dual Sight",
    Acog = "ACOG",
    Silencieux = "Suppressor",
    Compensator = "Compensator",
    HBarrel = "Muzzle Brake",
    AFG = "Angled Grip",
    ForeGrip = "Vertical Grip",
    Bipod = "Bipod",
    LaserRed = "Red Laser",
    LaserGreen = "Green Laser",
    LaserBlue = "Blue Laser",
    LaserPurple = "Purple Laser",
    LaserWhite = "White Laser",
    LaserDouble = "Double Laser",
    Flashlight = "Flashlight",
    FlashlightRed = "Red Flashlight",
    FlashlightGreen = "Green Flashlight",
    Drum = "Drum Mag",
    DoubleDrum = "Double Drum"
}
local Table4 = { Mag = "Default Mag" }
local Categories = Main:WaitForChild( "Categories" )
local CategoryTemplate = Categories:WaitForChild( "CategoryTemplate" )
local Grid = Main:WaitForChild( "Grid" )
local ItemTemplate = Grid:WaitForChild( "ItemTemplate" )
local SoundIcon = ItemTemplate:FindFirstChild( "SoundIcon" )

if SoundIcon and SoundIcon:IsA( "ImageLabel" ) then
    task.spawn( function()
        local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
        pcall( PreloadAsync, game:GetService( "ContentProvider" ), { SoundIcon } )
    end )
end

local UIStroke2
local UIStroke = ItemTemplate:FindFirstChild( "UIStroke" )
UIStroke2 = if UIStroke then UIStroke else ItemTemplate:FindFirstChildOfClass( "UIStroke" )
local OpenButton
local Thickness = UIStroke2.Thickness
local Status = Main:WaitForChild( "Status" )
local CategoryTitle = Main:WaitForChild( "CategoryTitle" )
local Hint = Parent:WaitForChild( "Hint" )
local WeaponName = Parent:WaitForChild( "WeaponName" )
local Get = Screens.Get( "ArmoryOpen", 10 )

if Get then
    OpenButton = Get:WaitForChild( "OpenButton" )
else
    OpenButton = Get
end

local Value8
local Flag = false
local Value2 = nil
local Value3 = nil
local Table5 = { }
local Table6 = { }
local Table7 = { }
local Table8 = { }
local Value4 = nil
local Value5 = nil
local Number = 3.141592653589793
local Number2 = 0
local Number3 = 1
local Number4 = 3.141592653589793
local Number5 = 0
local Value6 = nil
local Flag2 = false
local Value7 = nil
local Number6 = 0

local function WeaponName2( NameName )
    local Name3

    if WeaponData[ NameName ] then
        local Name = WeaponData[ NameName ].Name

        if Name then
            Name3 = Name
        elseif MeleeData[ NameName ] then
            local Name2 = MeleeData[ NameName ].Name

            if Name2 then
                Name3 = Name2
            else
                Name3 = NameName
            end
        else
            Name3 = NameName
        end
    elseif MeleeData[ NameName ] then
        local Name2 = MeleeData[ NameName ].Name

        if Name2 then
            Name3 = Name2
        else
            Name3 = NameName
        end
    else
        Name3 = NameName
    end

    return Name3
end

local function ItemName( NameName )
    local Entry2
    local Entry = Table3[ NameName ]

    if Entry then
        Entry2 = Entry
    elseif ModCatalog.Items[ NameName ] then
        local Name = ModCatalog.Items[ NameName ].name

        if Name then
            Entry2 = Name
        else
            Entry2 = NameName
        end
    else
        Entry2 = NameName
    end

    return Entry2
end

local function OwnedWeapons()
    local IsStudio2
    local Table = { }
    local Table2 = { }
    local IsStudio = game:GetService( "RunService" ):IsStudio( )

    if IsStudio then
        if script:GetAttribute( "StudioAllWeapons" ) == true then
            IsStudio2 = true
        else
            IsStudio2 = false
        end
    else
        IsStudio2 = IsStudio
    end

    local Table3 = IsStudio2 and { } or {
        LocalPlayer:FindFirstChildOfClass( "Backpack" ),
        LocalPlayer.Character
    }
    local Value1 = nil

    for Key, Value in Table3, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value3 = nil

        for Key3, Value4 in Children, nil, nil do
            local Melee
            local IsA = Value4:IsA( "Tool" )

            if IsA then
                local Weapon = Value4:GetAttribute( "Weapon" )

                if Weapon then
                    Melee = Weapon
                else
                    Melee = Value4:GetAttribute( "Melee" )
                end
            else
                Melee = IsA
            end
            if Melee and not Table2[ Melee ] and WeaponMods:FindFirstChild( Melee ) and WeaponVisuals:FindFirstChild( Melee ) then
                Table2[ Melee ] = true
                table.insert( Table, {
                    id = Melee,
                    slot = Value4:GetAttribute( "Slot" ) or 99,
                    mods = Value4:GetAttribute( "Mods" )
                } )
            end
        end
    end
    if #Table == 0 then
        for Key2, Value2 in WeaponMods:GetChildren( ) do
            if WeaponVisuals:FindFirstChild( Value2.Name ) then
                table.insert( Table, { id = Value2.Name, slot = 99 } )
            end
        end
    end

    table.sort( Table, function( Argument1, Argument2 )
        if Argument1.slot == Argument2.slot then
            local Flag2 = Argument1.id < Argument2.id and true or false
            return Flag2
        end
        local Flag = Argument1.slot < Argument2.slot and true or false
        return Flag
    end )
    return Table
end

local function ClearClones( Object, Argument2 )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "GuiObject" ) and Value ~= Argument2 then
            Value:Destroy( )
        end
    end
end

local function SameMods( List, List2 )
    local Value1 = nil

    for Key, Value in List or { }, nil, nil do
        if ( List2 or { } )[ Key ] ~= Value then
            return false
        end
    end

    local Value2 = nil

    for Key2, Value3 in List2 or { }, nil, nil do
        if ( List or { } )[ Key2 ] ~= Value3 then
            return false
        end
    end

    return true
end

local Table9 = { }
local Table10 = { -1, 1 }
Value8 = nil

for Key, Value in Table10, nil, nil do
    Storage.Table27 = { -1, 1 }
    Storage.Value19 = nil

    for Key4, Value20 in Storage.Table27, nil, nil do
        Storage.Table28 = { -1, 1 }
        Storage.Value21 = nil

        for Key5, Value22 in Storage.Table28, nil, nil do
            table.insert( Table9, ( Vector3.new( Value, Value20, Value22 ) ) )
        end
    end
end

local Number7

local function VisibleBounds( Model )
    local Table = Model:IsA( "BasePart" ) and { Model } or { }

    for Key, Value in Model:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            table.insert( Table, Value )
        end
    end

    local Value1, Min, Max
    Value1 = nil
    Min = nil
    Max = nil

    for Key2, Value2 in Table, nil, nil do
        if Value2.Transparency < 0.98 then
            local Value3
            local Size = Value2.Size / 2
            Value3 = nil

            for Key3, Value4 in Table9, nil, nil do
                local Min2
                local PointToWorldSpace = Value2.CFrame:PointToWorldSpace( Size * Value4 )
                Min2 = Min and Min:Min( PointToWorldSpace ) or PointToWorldSpace
                local Max2 = Max and Max:Max( PointToWorldSpace ) or PointToWorldSpace
                Min = Min2
                Max = Max2
            end
        end
    end
    if Min then
        return CFrame.new( ( Min + Max ) / 2 ), Max - Min
    end
    if Model:IsA( "Model" ) then
        return Model:GetBoundingBox( )
    end
    return Model.CFrame, Model.Size
end

local Model3D = ItemTemplate:FindFirstChild( "Model3D" )
Number7 = if not Model3D or not ( Model3D.Size.Y.Scale > 0 ) then 1.3 else Model3D.Size.X.Scale / Model3D.Size.Y.Scale
local Buy

local function Thumb( Parent, Model, Argument3 )
    local Table2
    Model.Parent = Parent
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 30
    CurrentCamera.Parent = Parent
    Parent.CurrentCamera = CurrentCamera
    local Value1, Value2 = VisibleBounds( Model )
    local Magnitude = Value2.Magnitude / 2 / 0.2679491924311227 * 1.02
    local CFrame2 = CFrame.lookAt( Value1.Position + Argument3:VectorToWorldSpace( Vector3.new( 1, 0.3499999940395355, 0.30000001192092896 ).Unit ) * Magnitude, Value1.Position, Argument3.UpVector )
    local Table = { }
    Table2 = Model:IsA( "BasePart" ) and { Model } or { }

    for Key, Value in Model:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            table.insert( Table2, Value )
        end
    end

    local Value3 = nil

    for Key2, Value4 in Table2, nil, nil do
        if Value4.Transparency < 0.98 then
            local Value7 = nil

            for Key4, Value8 in Table9, nil, nil do
                table.insert( Table, Value4.CFrame:PointToWorldSpace( Value4.Size / 2 * Value8 ) )
            end
        end
    end

    local I = 1

    for I = 1, 3 do
        local Value5, Number, Number2, Number4, Number5
        Value5 = nil
        Number = -math.huge
        Number2 = math.huge
        Number4 = math.huge
        Number5 = -math.huge

        for Key3, Value6 in Table, nil, nil do
            local PointToObjectSpace = CFrame2:PointToObjectSpace( Value6 )
            local Amount = -PointToObjectSpace.Z

            if Amount > 0.001 then
                local X = PointToObjectSpace.X / ( Amount * 0.2679491924311227 * Number7 )
                local Y = PointToObjectSpace.Y / ( Amount * 0.2679491924311227 )
                Number2 = math.min( Number2, X )
                Number = math.max( Number, X )
                Number4 = math.min( Number4, Y )
                Number5 = math.max( Number5, Y )
            end
        end
        if Number < Number2 then
            break
        end

        local Number3 = ( Number2 + Number ) / 2
        local Number6 = ( Number4 + Number5 ) / 2

        if math.abs( Number3 ) < 0.002 and math.abs( Number6 ) < 0.002 then
            break
        end

        CFrame2 = CFrame2 + ( CFrame2.RightVector * ( Number3 * Magnitude * 0.2679491924311227 * Number7 ) + CFrame2.UpVector * ( Number6 * Magnitude * 0.2679491924311227 ) )
    end

    CurrentCamera.CFrame = CFrame2
end

local function IsModelSkin( Key )
    local Flag

    if ( Key and ModCatalog.Skins[ Key ] ) == nil then
        Flag = false
    elseif ( Key and ModCatalog.Skins[ Key ] ).Model == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function CamosBlocked()
    local Entry2
    local Entry = Table5[ Value2 ]
    Entry2 = if Entry then Entry else { }
    local Skin2
    local Skin = Entry2.Skin
    Skin2 = if Skin then ModCatalog.Skins[ Skin ] else Skin
    local Flag

    if Skin2 == nil then
        Flag = false
    elseif Skin2.Model == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local Callback = nil

local function StyleCards()
    local Entry2
    local Entry = Table5[ Value2 ]
    Entry2 = if Entry then Entry else { }
    local Skin2
    local Skin = Entry2.Skin
    Skin2 = if Skin then ModCatalog.Skins[ Skin ] else Skin
    local Flag

    if Skin2 == nil then
        Flag = false
    elseif Skin2.Model == nil then
        Flag = false
    else
        Flag = true
    end

    local Value1 = nil

    for Key, Value in Table7, nil, nil do
        local NotFlag3

        if Value.family == "Camo" then
            local NotFlag2
            local NotFlag = not Flag

            if NotFlag then
                if ( Entry2.Skin or false ) == ( Value.id or false ) then
                    NotFlag2 = true
                else
                    NotFlag2 = false
                end
            else
                NotFlag2 = NotFlag
            end

            NotFlag3 = NotFlag2
        elseif Value.family == "Skin" then
            local Skin3 = Flag and Entry2.Skin or false

            if Skin3 == ( Value.id or false ) then
                NotFlag3 = true
            else
                NotFlag3 = false
            end
        elseif Value.family == "Sound" then
            if ( Entry2.Sound or false ) == ( Value.id or false ) then
                NotFlag3 = true
            else
                NotFlag3 = false
            end
        elseif Value.base then
            if Entry2[ Value.family ] == nil then
                NotFlag3 = true
            else
                NotFlag3 = false
            end
        elseif Entry2[ Value.family ] == Value.id then
            NotFlag3 = true
        else
            NotFlag3 = false
        end

        local Color
        local Stroke = Value.stroke
        Color = NotFlag3 and FromRGB or FromRGB2
        local ThicknessInner
        Stroke.Color = Color
        local Stroke2 = Value.stroke

        if NotFlag3 then
            local Captured = Thickness * 2

            if Captured then
                ThicknessInner = Captured
            else
                ThicknessInner = Thickness
            end
        else
            ThicknessInner = Thickness
        end

        Stroke2.Thickness = ThicknessInner
        local Greyed = Value.button:FindFirstChild( "Greyed" )

        if Greyed then
            local Visible = if Value.family == "Camo" then Flag else false
            Greyed.Visible = Visible
        end
    end
    if Callback then
        Callback( )
    end
end

local function BuildPreview()
end

local function SameMods2( List, List2 )
    if type( List ) ~= "table" or type( List2 ) ~= "table" then
        return false
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        if List2[ Key ] ~= Value then
            return false
        end
    end

    local Value2 = nil

    for Key2, Value3 in List2, nil, nil do
        if List[ Key2 ] ~= Value3 then
            return false
        end
    end

    return true
end

local function Send( Argument1, Argument2 )
    Number6 = Number6 + 1
    task.spawn( function()
        local InvokeServer = Remotes.SetMods.InvokeServer
        local Success, Result = pcall( InvokeServer, Remotes.SetMods, Argument1, Argument2 )

        if Success and type( Result ) == "table" and Number6 == Number6 then
            local SameMods22 = SameMods2( Table5[ Argument1 ], Result )
            Table5[ Argument1 ] = Result

            if Flag and Argument1 == Value2 and not SameMods22 then
                BuildPreview( )
                StyleCards( )
            end
        end
    end )
end

local function SetMods( Mods )
    Table5[ Value2 ] = Mods
    BuildPreview( )
    StyleCards( )
    Number6 = Number6 + 1
    task.spawn( function()
        local InvokeServer = Remotes.SetMods.InvokeServer
        local Success, Result = pcall( InvokeServer, Remotes.SetMods, Value2, Mods )

        if Success and type( Result ) == "table" and Number6 == Number6 then
            local SameMods22 = SameMods2( Table5[ Value2 ], Result )
            Table5[ Value2 ] = Result

            if Flag and Value2 == Value2 and not SameMods22 then
                BuildPreview( )
                StyleCards( )
            end
        end
    end )
end

local function PackLocked( LockedName )
    if ModCatalog.HasPack( LocalPlayer, LockedName ) then
        return false
    end

    local Text2
    local Find = LimitedPacks.Find( LockedName )
    local Error = require( ReplicatedStorage:WaitForChild( "Notify" ) ).Error

    if Find then
        local Text = Find.Name .. " exclusive: get it in the Shop"

        if Text then
            Text2 = Text
        else
            Text2 = LockedName .. " Pack exclusive"
        end
    else
        Text2 = LockedName .. " Pack exclusive"
    end

    Error( Text2 )
    local Entry = ModCatalog.PackPasses[ LockedName ]

    if Entry then
        GamepadNav.Prompt( function()
            game:GetService( "MarketplaceService" ):PromptGamePassPurchase( LocalPlayer, Entry )
        end )
    end

    return true
end

local RobuxShopUI = require( ReplicatedStorage:WaitForChild( "RobuxShopUI" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local BuyPanel = Parent:FindFirstChild( "BuyPanel" )

if BuyPanel then
    Buy = BuyPanel:FindFirstChild( "Buy" )
else
    Buy = BuyPanel
end

local Gift

if BuyPanel then
    Gift = BuyPanel:FindFirstChild( "Gift" )
else
    Gift = BuyPanel
end

local Picker
local GiftPicker = Parent:FindFirstChild( "GiftPicker" )

if GiftPicker then
    Picker = RobuxShopUI.Picker( GiftPicker, "ArmoryGift" )
else
    Picker = GiftPicker
end
if BuyPanel then
    BuyPanel.Visible = false
end

local Table11 = { Skin = "Skin", Sound = "ShotSound" }
local Value9 = nil

local function SoloOf( Key, Key2 )
    local Entry = Table11[ Key ]

    if not Entry or not Key2 then
        return nil
    end

    local Flag = if Entry == "ShotSound" then ModCatalog.ShotSounds[ Key2 ] else false

    if not Flag or not Flag.Paid then
        local PackOf, PackOf2 = LimitedPacks.PackOf( Entry, Key2 )

        if not PackOf or not PackOf2 or not ( ( PackOf2.ProductId or 0 ) > 0 ) then
            return nil
        end
        return {
            cat = Entry,
            id = Key2,
            product = PackOf2.ProductId,
            name = PackOf2.Name or Key2,
            pack = PackOf,
            sub = tostring( PackOf.Name ) .. " item · also sold alone"
        }
    elseif ( tonumber( ModCatalog.ShotSoundProduct ) or 0 ) <= 0 then
        return nil
    else
        return {
            cat = Entry,
            id = Key2,
            product = ModCatalog.ShotSoundProduct,
            name = Flag.name or Key2,
            pack = nil,
            sub = "Gun sound · works on all your guns"
        }
    end
end

local function OnSale( Argument1 )
    local Active

    if Argument1.pack == nil then
        Active = true
    else
        Active = LimitedPacks.Active( Argument1.pack )
    end

    return Active
end

local function SoloOwned( Argument1 )
    if Argument1.cat == "Skin" then
        return ModCatalog.OwnsSkin( LocalPlayer, Argument1.id )
    end
    return ModCatalog.OwnsSound( LocalPlayer, Argument1.id )
end

local function RefreshBuy()
    if not BuyPanel then
        return
    end

    local Active

    if Value9 == nil then
        Active = false
    elseif Flag then
        if Value9.pack == nil then
            Active = true
        else
            Active = LimitedPacks.Active( Value9.pack )
        end
    else
        Active = Flag
    end

    local Visible = Active == true and true or false
    BuyPanel.Visible = Visible

    if not Active then
        return
    end

    local Title = BuyPanel:FindFirstChild( "Title" )

    if Title and Title:IsA( "TextLabel" ) then
        Title.Text = Value9.name
    end

    local Sub = BuyPanel:FindFirstChild( "Sub" )

    if Sub and Sub:IsA( "TextLabel" ) and Value9.sub then
        Sub.Text = Value9.sub
    end
    if Buy then
        local OwnsSkin

        if Value9.cat == "Skin" then
            OwnsSkin = ModCatalog.OwnsSkin( LocalPlayer, Value9.id )
        else
            OwnsSkin = ModCatalog.OwnsSound( LocalPlayer, Value9.id )
        end
        if OwnsSkin then
            RobuxShopUI.SetBuy( Buy, "equipped", "OWNED" )
            return
        end
        if RobuxShopUI.Pending( Value9.product ) then
            RobuxShopUI.SetBuy( Buy, "wait", "..." )
            return
        end

        local SetBuy = RobuxShopUI.SetBuy
        SetBuy( Buy, "buy", RobuxShopUI.PriceText( Value9.product, RefreshBuy ) )
    end
end

local function ShowBuy( Key, Key2 )
    Value9 = SoloOf( Key, Key2 )
    RefreshBuy( )
end

if Buy then
    Buy.Activated:Connect( function()
        if Value9 then
            local OwnsSkin

            if Value9.cat == "Skin" then
                OwnsSkin = ModCatalog.OwnsSkin( LocalPlayer, Value9.id )
            else
                OwnsSkin = ModCatalog.OwnsSound( LocalPlayer, Value9.id )
            end
            if not OwnsSkin and not RobuxShopUI.Pending( Value9.product ) then
                local Active

                if Value9.pack == nil then
                    Active = true
                else
                    Active = LimitedPacks.Active( Value9.pack )
                end
                if Active then
                    task.spawn( function()
                        RobuxShopUI.Buy( Value9.cat, Value9.id )
                        RefreshBuy( )
                    end )
                    return
                end
                Notify.Error( "This limited offer has ended" )
                return
            end
        end
    end )
end
if Gift and Picker then
    Gift.Activated:Connect( function()
        if not Value9 or RobuxShopUI.Pending( Value9.product ) then
            return
        end

        local Active

        if Value9.pack == nil then
            Active = true
        else
            Active = LimitedPacks.Active( Value9.pack )
        end
        if not Active then
            Notify.Error( "This limited offer has ended" )
            return
        end

        Picker:Open( {
            title = "GIFT THE " .. string.upper( Value9.name ),
            onSend = function( Argument1, Argument2 )
                local Gift = RobuxShopUI.Gift
                local Cat = Value9.cat
                Gift( Cat, Value9.id, Argument1, Argument2 )
            end
        } )
        local OpenScale = GiftPicker:FindFirstChild( "OpenScale" )

        if OpenScale and OpenScale:IsA( "UIScale" ) then
            OpenScale.Scale = 0.92
            local TweenService = game:GetService( "TweenService" )
            TweenService:Create( OpenScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end
    end )
end
RobuxShopUI.Changed:Connect( RefreshBuy )

local function SoloLocked( Key, Key2 )
    local SoloOf2 = SoloOf( Key, Key2 )

    if SoloOf2 then
        local Active

        if SoloOf2.pack == nil then
            Active = true
        else
            Active = LimitedPacks.Active( SoloOf2.pack )
        end
        if Active then
            local OwnsSkin

            if SoloOf2.cat == "Skin" then
                OwnsSkin = ModCatalog.OwnsSkin( LocalPlayer, SoloOf2.id )
            else
                OwnsSkin = ModCatalog.OwnsSound( LocalPlayer, SoloOf2.id )
            end
            if not OwnsSkin then
                local Text2

                if SoloOf2.pack then
                    local Text = "Buy or gift it on the right, or get the " .. tostring( SoloOf2.pack.Name ) .. " in the Shop"

                    if Text then
                        Text2 = Text
                    else
                        Text2 = "Locked: buy or gift it on the right"
                    end
                else
                    Text2 = "Locked: buy or gift it on the right"
                end

                Status.Text = Text2
                task.delay( 3, function()
                    if Status.Text == Text2 then
                        Status.Text = ""
                    end
                end )
                return true
            end
        end
    end

    return false
end

local function LockedSkin( SkinName )
    if ( SkinName and ModCatalog.Skins[ SkinName ] ) == nil or ModCatalog.OwnsSkin( LocalPlayer, SkinName ) then
        return false
    end
    if not ( SkinName and ModCatalog.Skins[ SkinName ] ).Model or not SoloLocked( "Skin", SkinName ) then
        return ( PackLocked( ( SkinName and ModCatalog.Skins[ SkinName ] ).Pack ) )
    end
    return true
end

local function LockedSound( SoundName )
    if ( SoundName and ModCatalog.ShotSounds[ SoundName ] ) == nil or ModCatalog.OwnsSound( LocalPlayer, SoundName ) then
        return false
    end
    if SoloLocked( "Sound", SoundName ) then
        return true
    end
    return ( PackLocked( ( SoundName and ModCatalog.ShotSounds[ SoundName ] ).Pack ) )
end

local function ShotDef( DefName )
    local Entry2

    if DefName then
        local Entry = ModCatalog.ShotSounds[ DefName ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = nil
        end
    else
        Entry2 = nil
    end

    return Entry2
end

local function PreviewShot( ShotName, Argument2 )
    local Entry2
    local Effects = ModCatalog.Effects
    local Entry = Table5[ Value2 ]
    Entry2 = if Entry then Entry else { }
    local Flag = Effects( Entry2 ).Silenced == true and true or false
    local Entry4
    local PreviewShot = GunAudio.PreviewShot

    if ShotName then
        local Entry3 = ModCatalog.ShotSounds[ ShotName ]

        if Entry3 then
            Entry4 = Entry3
        else
            Entry4 = nil
        end
    else
        Entry4 = nil
    end

    pcall( PreviewShot, Value2, Entry4, Flag, Argument2 )
end

local Table12 = { 127227035135991, 81324157952319 }
local Table13 = { }
local Parent2 = game:GetService( "SoundService" )
local ArmoryEquipSounds = Parent2:FindFirstChild( "ArmoryEquipSounds" )

if ArmoryEquipSounds then
    Storage.Parent6 = ArmoryEquipSounds
else
    local Folder = Instance.new( "Folder" )
    Folder.Name = "ArmoryEquipSounds"
    Folder.Parent = Parent2
    Storage.Parent6 = Folder
end

local Value10 = nil

for Key2, Value11 in Table12, nil, nil do
    Storage.FoundChild2 = Storage.Parent6:FindFirstChild( "Equip" .. Key2 )

    if Storage.FoundChild2 then
        Storage.Sound4 = Storage.FoundChild2
    else
        Storage.Sound4 = Instance.new( "Sound" )
    end

    Storage.Sound4.Name = "Equip" .. Key2
    Storage.Sound4.SoundId = "rbxassetid://" .. Value11
    Storage.Sound4.Parent = Storage.Parent6
    Table13[ Key2 ] = Storage.Sound4
end

local Sound
task.spawn( function()
    local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
    pcall( PreloadAsync, game:GetService( "ContentProvider" ), Table13 )
end )

local function PlayEquipSound()
    local Value1
    local Random = math.random( 1, 3 )
    Value1 = nil

    for Key, Value in Table13, nil, nil do
        if Random == 3 or Random == Key then
            local Volume = Random ~= 3 and 0.8 or 0.55
            Value.Volume = Volume
            Value.TimePosition = 0
            Value:Play( )
        end
    end
end

local Parent3 = Table13[ 1 ].Parent
local Unequip = Parent3:FindFirstChild( "Unequip" )

if Unequip then
    Sound = Unequip
else
    Sound = Instance.new( "Sound" )
end
Sound.Name = "Unequip"
Sound.SoundId = "rbxassetid://" .. 129018209008555
Sound.Volume = 0.8
Sound.Parent = Parent3
task.spawn( function()
    local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
    pcall( PreloadAsync, game:GetService( "ContentProvider" ), { Sound } )
end )

local function PlayUnequipSound()
    Sound.TimePosition = 0.07
    Sound:Play( )
end

local Table14 = {
    { id = 92512886783083, start = 0.57 },
    { id = 122019089776674, start = 0.74 }
}
local Table15 = { }
local Parent4 = game:GetService( "SoundService" )
local Parent5 = Table13[ 1 ].Parent
local ArmoryWrapGain = Parent4:FindFirstChild( "ArmoryWrapGain", true )

if ArmoryWrapGain then
    Storage.SoundGroup2 = ArmoryWrapGain
else
    local SoundGroup = Instance.new( "SoundGroup" )
    SoundGroup.Name = "ArmoryWrapGain"
    SoundGroup.Volume = 3
    SoundGroup.Parent = Parent4
    Storage.SoundGroup2 = SoundGroup
end

local Value12 = nil

for Key3, Value13 in Table14, nil, nil do
    Storage.FoundChild = Parent5:FindFirstChild( "Wrap" .. Key3 )

    if Storage.FoundChild then
        Storage.Sound3 = Storage.FoundChild
    else
        Storage.Sound3 = Instance.new( "Sound" )
    end

    Storage.Sound3.Name = "Wrap" .. Key3
    Storage.Sound3.SoundId = "rbxassetid://" .. Value13.id
    Storage.Sound3.Volume = 10
    Storage.Sound3.SoundGroup = Storage.SoundGroup2
    Storage.Sound3.Parent = Parent5
    Table15[ Key3 ] = Storage.Sound3
end

task.spawn( function()
    local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
    pcall( PreloadAsync, game:GetService( "ContentProvider" ), Table15 )
end )

local function PlayWrapSound()
    local Random = math.random( 1, #Table15 )
    local Entry = Table15[ Random ]
    Entry.TimePosition = Table14[ Random ].start
    Table15[ Random ]:Play( )
end

local function Equip( Name, SoundInner )
    if Name == "Sound" then
        PreviewShot( SoundInner )
        Value9 = SoloOf( "Sound", SoundInner )
        RefreshBuy( )
        local FlagInner

        if ( SoundInner and ModCatalog.ShotSounds[ SoundInner ] ) == nil or ModCatalog.OwnsSound( LocalPlayer, SoundInner ) then
            FlagInner = false
        elseif SoloLocked( "Sound", SoundInner ) then
            FlagInner = true
        else
            FlagInner = PackLocked( ( SoundInner and ModCatalog.ShotSounds[ SoundInner ] ).Pack )
        end
        if FlagInner then
            return
        end

        local Entry2
        local Entry = Table5[ Value2 ]
        Entry2 = if Entry then Entry else { }

        if ( Entry2.Sound or nil ) == ( SoundInner or nil ) then
            return
        end
        local Clone = table.clone( Entry2 )
        Clone.Sound = SoundInner
        Table5[ Value2 ] = Clone
        BuildPreview( )
        StyleCards( )
        Number6 = Number6 + 1
        task.spawn( function()
            local InvokeServer = Remotes.SetMods.InvokeServer
            local Success, Result = pcall( InvokeServer, Remotes.SetMods, Value2, Clone )

            if Success and type( Result ) == "table" and Number6 == Number6 then
                local SameMods22 = SameMods2( Table5[ Value2 ], Result )
                Table5[ Value2 ] = Result

                if Flag and Value2 == Value2 and not SameMods22 then
                    BuildPreview( )
                    StyleCards( )
                end
            end
        end )
        return
    elseif Name == "Skin" then
        Value9 = SoloOf( "Skin", SoundInner )
        RefreshBuy( )
        local Flag2

        if ( SoundInner and ModCatalog.Skins[ SoundInner ] ) == nil or ModCatalog.OwnsSkin( LocalPlayer, SoundInner ) then
            Flag2 = false
        elseif not ( SoundInner and ModCatalog.Skins[ SoundInner ] ).Model or not SoloLocked( "Skin", SoundInner ) then
            Flag2 = PackLocked( ( SoundInner and ModCatalog.Skins[ SoundInner ] ).Pack )
        else
            Flag2 = true
        end
        if Flag2 then
            return
        end

        local Entry4
        local Entry3 = Table5[ Value2 ]
        Entry4 = if Entry3 then Entry3 else { }

        if SoundInner == nil then
            local Skin2
            local Skin = Entry4.Skin
            Skin2 = if Skin then ModCatalog.Skins[ Skin ] else Skin
            local Flag3

            if Skin2 == nil then
                Flag3 = false
            elseif Skin2.Model == nil then
                Flag3 = false
            else
                Flag3 = true
            end
            if not Flag3 then
                return
            end
        end
        if SoundInner ~= nil and Entry4.Skin == SoundInner then
            return
        end

        local Clone2 = table.clone( Entry4 )
        Clone2.Skin = SoundInner

        if SoundInner ~= nil then
            local Random = math.random( 1, #Table15 )
            local Entry5 = Table15[ Random ]
            Entry5.TimePosition = Table14[ Random ].start
            Table15[ Random ]:Play( )
        end

        Table5[ Value2 ] = Clone2
        BuildPreview( )
        StyleCards( )
        Number6 = Number6 + 1
        task.spawn( function()
            local InvokeServer = Remotes.SetMods.InvokeServer
            local Success, Result = pcall( InvokeServer, Remotes.SetMods, Value2, Clone2 )

            if Success and type( Result ) == "table" and Number6 == Number6 then
                local SameMods22 = SameMods2( Table5[ Value2 ], Result )
                Table5[ Value2 ] = Result

                if Flag and Value2 == Value2 and not SameMods22 then
                    BuildPreview( )
                    StyleCards( )
                end
            end
        end )
        return
    else
        if Name == "Camo" then
            local Entry7
            local Entry6 = Table5[ Value2 ]
            Entry7 = if Entry6 then Entry6 else { }
            local Skin4
            local Skin3 = Entry7.Skin
            Skin4 = if Skin3 then ModCatalog.Skins[ Skin3 ] else Skin3
            local Flag4

            if Skin4 == nil then
                Flag4 = false
            elseif Skin4.Model == nil then
                Flag4 = false
            else
                Flag4 = true
            end
            if Flag4 then
                require( ReplicatedStorage:WaitForChild( "Notify" ) ).Error( "Skin applied: remove it in Skins to use camos" )
                return
            end
        end
        if Name == "Camo" then
            local Flag5

            if ( SoundInner and ModCatalog.Skins[ SoundInner ] ) == nil or ModCatalog.OwnsSkin( LocalPlayer, SoundInner ) then
                Flag5 = false
            elseif not ( SoundInner and ModCatalog.Skins[ SoundInner ] ).Model or not SoloLocked( "Skin", SoundInner ) then
                Flag5 = PackLocked( ( SoundInner and ModCatalog.Skins[ SoundInner ] ).Pack )
            else
                Flag5 = true
            end
            if Flag5 then
                return
            end
        end

        local Entry9
        local Entry8 = Table5[ Value2 ]
        Entry9 = if Entry8 then Entry8 else { }
        local Clone3 = table.clone( Entry9 )

        if Name == "Camo" then
            if ( Clone3.Skin or nil ) == ( SoundInner or nil ) then
                return
            end

            Clone3.Skin = SoundInner

            if SoundInner ~= nil then
                local Random2 = math.random( 1, #Table15 )
                local Entry10 = Table15[ Random2 ]
                Entry10.TimePosition = Table14[ Random2 ].start
                Table15[ Random2 ]:Play( )
            end
        else
            if SoundInner == nil and Clone3[ Name ] == nil then
                return
            end

            local Value1
            local Entry11 = Clone3[ Name ]
            Value1 = SoundInner ~= nil and Clone3[ Name ] ~= SoundInner and SoundInner or nil
            Clone3[ Name ] = Value1

            if Clone3[ Name ] == nil then
                if Entry11 ~= nil then
                    Sound.TimePosition = 0.07
                    Sound:Play( )
                end
            else
                PlayEquipSound( )
            end
        end

        Table5[ Value2 ] = Clone3
        BuildPreview( )
        StyleCards( )
        Number6 = Number6 + 1
        task.spawn( function()
            local InvokeServer = Remotes.SetMods.InvokeServer
            local Success, Result = pcall( InvokeServer, Remotes.SetMods, Value2, Clone3 )

            if Success and type( Result ) == "table" and Number6 == Number6 then
                local SameMods22 = SameMods2( Table5[ Value2 ], Result )
                Table5[ Value2 ] = Result

                if Flag and Value2 == Value2 and not SameMods22 then
                    BuildPreview( )
                    StyleCards( )
                end
            end
        end )
        return
    end
end

local UIGradient = ItemTemplate:FindFirstChildOfClass( "UIGradient" )
local Table16 = {
    common = 1,
    uncommon = 2,
    rare = 3,
    epic = 4,
    legendary = 5,
    mythical = 6,
    super = 6,
    secret = 7
}
local Table17 = { }

local function RarityGradient( GradientName )
    if not ( GradientName and ItemRender.TILE_GRAD[ GradientName ] ) or not UIGradient then
        return nil
    end
    if not Table17[ GradientName ] then
        local Value1, Number, Number2
        local Value = ( GradientName and ItemRender.TILE_GRAD[ GradientName ] ).Keypoints[ 1 ].Value
        local Value2 = ( GradientName and ItemRender.TILE_GRAD[ GradientName ] ).Keypoints[ #( GradientName and ItemRender.TILE_GRAD[ GradientName ] ).Keypoints ].Value

        local function Lum( Argument1 )
            return Argument1.R + Argument1.G + Argument1.B
        end

        local Keypoints = UIGradient.Color.Keypoints
        Value1 = nil
        Number = math.huge
        Number2 = -math.huge

        for Key, Value3 in Keypoints, nil, nil do
            local Value7 = Value3.Value
            Number = math.min( Number, Value7.R + Value7.G + Value7.B )
            local Value8 = Value3.Value
            Number2 = math.max( Number2, Value8.R + Value8.G + Value8.B )
        end

        local Value4
        local Table = { }
        local Keypoints2 = UIGradient.Color.Keypoints
        Value4 = nil

        for Key2, Value5 in Keypoints2, nil, nil do
            local R2
            local Time = Value5.Time

            if Number < Number2 then
                local Value6 = Value5.Value
                local R = ( Value6.R + Value6.G + Value6.B - Number ) / ( Number2 - Number )

                if R then
                    R2 = R
                else
                    R2 = 1
                end
            else
                R2 = 1
            end

            table.insert( Table, ColorSequenceKeypoint.new( Time, Value2:Lerp( Value, R2 ) ) )
        end

        Table17[ GradientName ] = ColorSequence.new( Table )
    end

    return Table17[ GradientName ]
end

local FromRGB3 = Color3.fromRGB( 130, 220, 114 )
local FromRGB4 = Color3.fromRGB( 240, 110, 110 )
local Effects = WeaponName.Parent:FindFirstChild( "Effects" )

local function EffectList( ListName )
    if not ( ListName and ModCatalog.Items[ ListName ] ) then
        return nil
    end

    local Table = { }

    local function Add( Argument1, Argument2 )
        table.insert( Table, { text = Argument1, good = Argument2 } )
    end

    local NotEntry = not ModCatalog.NoBigMag[ Value2 ]

    if ( ListName and ModCatalog.Items[ ListName ] ).MagSize and NotEntry then
        table.insert( Table, {
            text = ( "%d rounds per magazine" ):format( ( ListName and ModCatalog.Items[ ListName ] ).MagSize ),
            good = true
        } )
    end
    if ( ListName and ModCatalog.Items[ ListName ] ).SpreadScale and ( ListName and ModCatalog.Items[ ListName ] ).SpreadScale < 1 then
        table.insert( Table, {
            text = ( "-%d%% bullet spread" ):format( ( math.floor( ( 1 - ( ListName and ModCatalog.Items[ ListName ] ).SpreadScale ) * 100 + 0.5 ) ) ),
            good = true
        } )
    end
    if ( ListName and ModCatalog.Items[ ListName ] ).Zoom and ( ListName and ModCatalog.Items[ ListName ] ).Zoom < 1 then
        table.insert( Table, { text = "Stronger zoom when aiming", good = true } )
    end
    if ( ListName and ModCatalog.Items[ ListName ] ).AltZoom and ( ListName and ModCatalog.Items[ ListName ] ).AltZoom < 1 then
        table.insert( Table, { text = "Zoom toggle while aiming", good = true } )
    end
    if ( ListName and ModCatalog.Items[ ListName ] ).HipFire and ModCatalog.HipFire( { Rail = ListName }, Value2 ) then
        table.insert( Table, { text = "Shoot without aiming", good = true } )
    end

    local Effects2
    local Effects = ( ListName and ModCatalog.Items[ ListName ] ).Effects
    Effects2 = if Effects then Effects else { }

    if Effects2.Silenced then
        table.insert( Table, { text = "Silenced, no flash", good = true } )
    end
    if Effects2.FalloffRange and Effects2.FalloffRange > 1 then
        table.insert( Table, {
            text = ( "+%d%% range" ):format( ( math.floor( ( Effects2.FalloffRange - 1 ) * 100 + 0.5 ) ) ),
            good = true
        } )
    end
    if Effects2.FalloffKeep and Effects2.FalloffKeep > 0 then
        table.insert( Table, {
            text = ( "-%d%% damage drop-off" ):format( ( math.floor( Effects2.FalloffKeep * 100 + 0.5 ) ) ),
            good = true
        } )
    end
    if Effects2.RollSpeed and Effects2.RollSpeed > 1 then
        table.insert( Table, {
            text = ( "+%d%% roll speed" ):format( ( math.floor( ( Effects2.RollSpeed - 1 ) * 100 + 0.5 ) ) ),
            good = true
        } )
    end
    if not NotEntry or not ( ListName and ModCatalog.Items[ ListName ] ).ReloadScale or not ( ( ListName and ModCatalog.Items[ ListName ] ).ReloadScale < 1 ) then
        if NotEntry and ( ListName and ModCatalog.Items[ ListName ] ).ReloadAdd and ( ListName and ModCatalog.Items[ ListName ] ).ReloadAdd > 0 then
            table.insert( Table, {
                text = ( "+%gs reload time" ):format( ( ListName and ModCatalog.Items[ ListName ] ).ReloadAdd ),
                good = false
            } )
        end
    else
        table.insert( Table, {
            text = ( "Reload time ÷%d" ):format( ( math.floor( 1 / ( ListName and ModCatalog.Items[ ListName ] ).ReloadScale + 0.5 ) ) ),
            good = true
        } )
    end

    local Table2 = #Table > 0 and Table or nil
    return Table2
end

local Number8 = 0
local Value14 = nil

Callback = function()
    if not Effects then
        return
    end

    local Captured

    if Value14 ~= nil or Value3 == "Camo" or Value3 == "Sound" or Value3 == "Skin" then
        Captured = Value14
    else
        local Entry2
        local Entry = Table5[ Value2 ]
        Entry2 = if Entry then Entry else { }
        Captured = Entry2[ Value3 ]
    end

    local Value2Inner

    if Captured then
        local EffectList2 = EffectList( Captured )

        if EffectList2 then
            Value2Inner = EffectList2
        else
            Value2Inner = nil
        end
    else
        Value2Inner = nil
    end

    local Visible = Value2Inner ~= nil and true or false
    Effects.Visible = Visible

    if not Value2Inner then
        return
    end

    local Title = Effects:FindFirstChild( "Title", true )

    if Title then
        local Text
        local Entry3 = Table3[ Captured ]

        if Entry3 then
            Text = Entry3
        elseif ModCatalog.Items[ Captured ] then
            local Name = ModCatalog.Items[ Captured ].name

            if Name then
                Text = Name
            else
                Text = Captured
            end
        else
            Text = Captured
        end

        Title.Text = Text
    end

    local I = 1

    for I = 1, 4 do
        local FoundChild = Effects:FindFirstChild( "Line" .. I, true )

        if FoundChild then
            local Visible2
            local Entry4 = Value2Inner[ I ]
            Visible2 = Entry4 ~= nil and true or false
            FoundChild.Visible = Visible2

            if Entry4 then
                local TextColor3
                FoundChild.Text = Entry4.text
                TextColor3 = Entry4.good and FromRGB3 or FromRGB4
                FoundChild.TextColor3 = TextColor3
            end
        end
    end

    Number8 = Number8 + 1
    local Table = { }
    local I2 = 1

    for I2 = 1, 4 do
        local Parent = Effects:FindFirstChild( "Line" .. I2, true )

        if Parent then
            local UITextSizeConstraint
            local FxSize = Parent:FindFirstChild( "FxSize" )

            if FxSize then
                UITextSizeConstraint = FxSize
            else
                UITextSizeConstraint = Instance.new( "UITextSizeConstraint" )
            end

            UITextSizeConstraint.Name = "FxSize"
            UITextSizeConstraint.MinTextSize = 1
            UITextSizeConstraint.MaxTextSize = 100
            UITextSizeConstraint.Parent = Parent

            if Parent.Visible then
                table.insert( Table, { Parent, UITextSizeConstraint } )
            end
        end
    end
    if #Table < 2 then
        return
    end
    task.spawn( function()
        RunService.Heartbeat:Wait( )

        if Number8 ~= Number8 then
            return
        end

        local Value1, Number
        Value1 = nil
        Number = math.huge

        for Key, Value in Table, nil, nil do
            if Value[ 1 ].TextBounds.Y > 0 then
                Number = math.min( Number, Value[ 1 ].TextBounds.Y )
            end
        end
        if Number < math.huge then
            local Value2 = nil

            for Key2, Value3 in Table, nil, nil do
                local Item = Value3[ 2 ]
                Item.MaxTextSize = math.max( 1, ( math.floor( Number ) ) )
            end
        end
    end )
    return
end

local function AddCard( LayoutOrder, CardName, CardName2, Text, Argument5 )
    local UIStroke2
    local Clone = ItemTemplate:Clone( )
    Clone.Name = "Item_" .. tostring( CardName2 or "None" )
    Clone.LayoutOrder = LayoutOrder
    Clone.Visible = true
    Clone.Text.Text = Text
    local UIStroke = Clone:FindFirstChild( "UIStroke" )
    UIStroke2 = if UIStroke then UIStroke else Clone:FindFirstChildOfClass( "UIStroke" )
    local Color = RarityGradient( Argument5.tier )

    if Color then
        Clone:FindFirstChildOfClass( "UIGradient" ).Color = Color
    end
    if Argument5.model then
        Clone.Model3D.Visible = true
        Thumb( Clone.Model3D, Argument5.model, Argument5.O )
        Clone.Thumb.Visible = false
    else
        Clone.Model3D.Visible = false

        if Argument5.image then
            local ThumbInner = Clone.Thumb
            ThumbInner.Image = Argument5.image
            Clone.Thumb.ScaleType = Enum.ScaleType.Crop
            Clone.Thumb.BackgroundTransparency = 1
        elseif Argument5.swatch then
            local Thumb2 = Clone.Thumb
            Thumb2.BackgroundColor3 = Argument5.swatch
            Clone.Thumb.BackgroundTransparency = 0
        else
            Clone.Thumb.Visible = false
        end
    end
    if Argument5.badge then
        local Badge = Clone.Badge
        Badge.Text = Argument5.badge
        Clone.Badge.Visible = true
    end
    if Argument5.locked then
        Clone.Model3D.ImageTransparency = 0.55
        Clone.Thumb.ImageTransparency = 0.55

        if Clone.Thumb.BackgroundTransparency < 1 then
            Clone.Thumb.BackgroundTransparency = 0.55
        end

        Clone.Badge.Text = "🔒 Locked"
        Clone.Badge.Visible = true
    end
    if Argument5.pack and Clone:FindFirstChild( "PackBadge" ) then
        Clone:FindFirstChild( "PackBadge" ).Text = Clone.Badge.Text
        Clone:FindFirstChild( "PackBadge" ).Visible = Clone.Badge.Visible
        Clone.Badge.Visible = false
    end

    local SoundIcon = Clone:FindFirstChild( "SoundIcon" )

    if SoundIcon then
        local Visible = CardName == "Sound" and true or false
        SoundIcon.Visible = Visible
    end

    Clone.Parent = Grid

    if CardName ~= "Camo" and CardName ~= "Sound" and CardName ~= "Skin" then
        local Flag = CardName2 or false
        GamepadNav.Hover( Clone, function()
            Value14 = Flag
            Callback( )
        end, function()
            if Value14 == Flag then
                Value14 = nil
                Callback( )
            end
        end )
    end

    Clone.Activated:Connect( function()
        if Argument5.locked then
            if CardName ~= "Camo" then
                Status.Text = "Win it in an Attachment Case"
                task.delay( 2.5, function()
                    if Status.Text == "Win it in an Attachment Case" then
                        Status.Text = ""
                    end
                end )
                return
            end

            local Entry2
            local Entry = Table5[ Value2 ]
            Entry2 = if Entry then Entry else { }
            local Skin2
            local Skin = Entry2.Skin
            Skin2 = if Skin then ModCatalog.Skins[ Skin ] else Skin
            local Flag

            if Skin2 == nil then
                Flag = false
            elseif Skin2.Model == nil then
                Flag = false
            else
                Flag = true
            end
            if not Flag then
                Status.Text = "Win it in an Attachment Case"
                task.delay( 2.5, function()
                    if Status.Text == "Win it in an Attachment Case" then
                        Status.Text = ""
                    end
                end )
                return
            end
        end

        Equip( CardName, CardName2 )
    end )
    Table7[ Clone.Name ] = {
        button = Clone,
        stroke = UIStroke2,
        family = CardName,
        id = CardName2,
        base = Argument5.base
    }
    return Clone
end

local function ShownSkins( Argument1 )
    local Value1
    local Table = { }
    local Skins = ModCatalog.Skins
    Value1 = nil

    for Key, Value in Skins, nil, nil do
        local Flag = Value.Model ~= nil and true or false

        if Flag == Argument1 then
            local Pack2
            local Pack = Value.Pack

            if Pack then
                local Find = LimitedPacks.Find( Value.Pack )

                if Find then
                    local NotActive = not LimitedPacks.Active( Value.Pack )

                    if NotActive then
                        Pack2 = not ModCatalog.OwnsSkin( LocalPlayer, Key )
                    else
                        Pack2 = NotActive
                    end
                else
                    Pack2 = Find
                end
            else
                Pack2 = Pack
            end

            local Flag2

            if Value.Event == nil then
                Flag2 = false
            else
                local NotUnlocked = not AttachmentCases.Unlocked( LocalPlayer, "Skin:" .. Key )

                if NotUnlocked then
                    if LocalPlayer:GetAttribute( "StudioEventCamos" ) == true then
                        Flag2 = false
                    else
                        Flag2 = true
                    end
                else
                    Flag2 = NotUnlocked
                end
            end

            local ClanSkinAllowed

            if Value.Clan == nil then
                ClanSkinAllowed = false
            else
                ClanSkinAllowed = ModCatalog.ClanSkinAllowed( LocalPlayer, Key )
            end

            local Flag3 = if Value.Weapons == nil then false else not Value.Weapons[ Value2 ]
            local Flag4

            if Argument1 then
                if ModCatalog.SkinVisual( Value2, { Skin = Key } ) == nil then
                    Flag4 = true
                else
                    Flag4 = false
                end
            else
                Flag4 = Argument1
            end
            if not Value.Hidden or ClanSkinAllowed then
                if not Pack2 and not Flag2 and not Flag3 and not Flag4 then
                    table.insert( Table, { id = Key, s = Value } )
                end
            end
        end
    end

    table.sort( Table, function( Argument1, Argument2 )
        local Flag = ( Argument1.s.Order or 99 ) < ( Argument2.s.Order or 99 ) and true or false
        return Flag
    end )
    return Table
end

local Table18 = { }

local function PreloadCamos( List )
    local Value1
    local Table = { }

    local function Img( Image )
        if type( Image ) == "string" and Image:find( "rbxassetid://" ) then
            local ImageLabel = Instance.new( "ImageLabel" )
            ImageLabel.Image = Image
            table.insert( Table, ImageLabel )
        end
    end

    Value1 = nil

    for Key, Value in List, nil, nil do
        local S = Value.s

        if not Table18[ Value.id ] and not S.Model then
            local NotOwnsSkin2

            if S.Pack then
                local NotOwnsSkin = not ModCatalog.OwnsSkin( LocalPlayer, Value.id )

                if NotOwnsSkin then
                    NotOwnsSkin2 = NotOwnsSkin
                else
                    local NotPack = not S.Pack

                    if NotPack then
                        local Text = "Skin:" .. Value.id
                        local Lockable = AttachmentCases.Lockable( Text )

                        if Lockable then
                            NotOwnsSkin2 = not AttachmentCases.Unlocked( LocalPlayer, Text )
                        else
                            NotOwnsSkin2 = Lockable
                        end
                    else
                        NotOwnsSkin2 = NotPack
                    end
                end
            else
                local NotPack = not S.Pack

                if NotPack then
                    local Text = "Skin:" .. Value.id
                    local Lockable = AttachmentCases.Lockable( Text )

                    if Lockable then
                        NotOwnsSkin2 = not AttachmentCases.Unlocked( LocalPlayer, Text )
                    else
                        NotOwnsSkin2 = Lockable
                    end
                else
                    NotOwnsSkin2 = NotPack
                end
            end
            if not NotOwnsSkin2 then
                Table18[ Value.id ] = true
                local Image = S.Texture

                if type( Image ) == "string" and Image:find( "rbxassetid://" ) then
                    local ImageLabel = Instance.new( "ImageLabel" )
                    ImageLabel.Image = Image
                    table.insert( Table, ImageLabel )
                end
                if type( S.Flow ) == "table" then
                    local Value2
                    local Flow = S.Flow
                    Value2 = nil

                    for Key2, Value3 in Flow, nil, nil do
                        if type( Value3 ) == "table" and type( Value3.Image ) == "string" and Value3.Image:find( "rbxassetid://" ) then
                            local ImageLabel2 = Instance.new( "ImageLabel" )
                            ImageLabel2.Image = Value3.Image
                            table.insert( Table, ImageLabel2 )
                        end
                    end
                else
                    local Image2 = S.Flow

                    if type( Image2 ) == "string" and Image2:find( "rbxassetid://" ) then
                        local ImageLabel3 = Instance.new( "ImageLabel" )
                        ImageLabel3.Image = Image2
                        table.insert( Table, ImageLabel3 )
                    end
                end

                local Value4
                local Table2 = { S.SurfaceAppearance, S.Aura }
                Value4 = nil

                for Key3, Value5 in Table2, nil, nil do
                    local FoundChild

                    if type( Value5 ) == "string" then
                        FoundChild = Weapons:FindFirstChild( Value5 )
                    else
                        FoundChild = false
                    end
                    if FoundChild then
                        table.insert( Table, FoundChild )
                    end
                end
            end
        end
    end
    if #Table > 0 then
        task.spawn( function()
            local ContentProvider = game:GetService( "ContentProvider" )
            pcall( ContentProvider.PreloadAsync, ContentProvider, Table )
        end )
    end
end

local Table19 = { Skin = "ArmoryNew_Skins_1311", Sound = "ArmoryNew_ShotSound_1311" }
local Sound2 = Table19.Sound
local Table20 = { }

local function IsSeen( Key )
    if Table20[ Key ] then
        return true
    end

    local Flag
    local SeenNotifs = LocalPlayer:GetAttribute( "SeenNotifs" )

    if type( SeenNotifs ) == "string" then
        if table.find( string.split( SeenNotifs, "," ), Key ) == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    return Flag
end

local function RefreshNew()
    local Value1 = nil

    for Key, Value in Table19, nil, nil do
        local Notificiation
        local Entry = Table8[ Key ]

        if Entry then
            Notificiation = Entry:FindFirstChild( "Notificiation" )
        else
            Notificiation = Entry
        end
        if Notificiation then
            local Flag2

            if Table20[ Value ] then
                Flag2 = true
            else
                local SeenNotifs2 = LocalPlayer:GetAttribute( "SeenNotifs" )

                if type( SeenNotifs2 ) == "string" then
                    if table.find( string.split( SeenNotifs2, "," ), Value ) == nil then
                        Flag2 = false
                    else
                        Flag2 = true
                    end
                else
                    Flag2 = false
                end
            end

            Notificiation.Visible = not Flag2
        end
    end

    local ArmoryStation
    local Interactions = workspace:FindFirstChild( "Interactions" )

    if Interactions then
        ArmoryStation = Interactions:FindFirstChild( "ArmoryStation" )
    else
        ArmoryStation = Interactions
    end

    local Sign

    if ArmoryStation then
        Sign = ArmoryStation:FindFirstChild( "Sign" )
    else
        Sign = ArmoryStation
    end

    local New

    if Sign then
        New = Sign:FindFirstChild( "New" )
    else
        New = Sign
    end
    if New and New:IsA( "GuiObject" ) then
        local Flag

        if Table20[ Sound2 ] then
            Flag = true
        else
            local SeenNotifs = LocalPlayer:GetAttribute( "SeenNotifs" )

            if type( SeenNotifs ) == "string" then
                if table.find( string.split( SeenNotifs, "," ), Sound2 ) == nil then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end
        end

        New.Visible = not Flag
    end
end

local function MarkSeen( SeenName )
    local Entry = Table19[ SeenName ]

    if Entry then
        local Flag

        if Table20[ Entry ] then
            Flag = true
        else
            local SeenNotifs = LocalPlayer:GetAttribute( "SeenNotifs" )

            if type( SeenNotifs ) == "string" then
                if table.find( string.split( SeenNotifs, "," ), Entry ) == nil then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end
        end
        if not Flag then
            Table20[ Entry ] = true
            RefreshNew( )
            task.spawn( function()
                local HudNotifSeen = ReplicatedStorage:WaitForChild( "HudNotifSeen", 10 )

                if HudNotifSeen then
                    HudNotifSeen:FireServer( Entry )
                end
            end )
            return
        end
    end
end

LocalPlayer:GetAttributeChangedSignal( "SeenNotifs" ):Connect( RefreshNew )
task.spawn( function()
    local Interactions = workspace:WaitForChild( "Interactions", 60 )

    if Interactions then
        Interactions.ChildAdded:Connect( function( Argument1 )
            if Argument1.Name == "ArmoryStation" then
                task.defer( RefreshNew )
            end
        end )
        RefreshNew( )
        return
    end
    return
end )

local function SelectCategory( CategoryName, Argument2 )
    if CategoryName ~= Value3 then
        Value9 = nil

        if Picker then
            Picker:Close( )
        end
    end

    Value3 = CategoryName
    local Entry = Table19[ CategoryName ]

    if Entry then
        local Flag

        if Table20[ Entry ] then
            Flag = true
        else
            local SeenNotifs = LocalPlayer:GetAttribute( "SeenNotifs" )

            if type( SeenNotifs ) == "string" then
                if table.find( string.split( SeenNotifs, "," ), Entry ) == nil then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end
        end
        if not Flag then
            Table20[ Entry ] = true
            RefreshNew( )
            task.spawn( function()
                local HudNotifSeen = ReplicatedStorage:WaitForChild( "HudNotifSeen", 10 )

                if HudNotifSeen then
                    HudNotifSeen:FireServer( Entry )
                end
            end )
        end
    end

    local Value1
    RefreshBuy( )
    Value14 = nil
    CategoryTitle.Text = Table2[ CategoryName ] or CategoryName
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        local Transparency
        local UIStroke = Value:FindFirstChildOfClass( "UIStroke" )
        Transparency = Key ~= CategoryName and 0.8 or 0.1
        UIStroke.Transparency = Transparency
    end

    local Number, Text4
    ClearClones( Grid, ItemTemplate )
    table.clear( Table7 )

    if CategoryName == "Sound" then
        local Value2Inner
        AddCard( 0, "Sound", nil, "Default", { } )
        local Table = { }
        local ShotSounds = ModCatalog.ShotSounds
        Value2Inner = nil

        for Key2, Value3Inner in ShotSounds, nil, nil do
            local Pack3
            local Pack2 = Value3Inner.Pack

            if Pack2 then
                local Find2 = LimitedPacks.Find( Value3Inner.Pack )

                if Find2 then
                    local NotActive = not LimitedPacks.Active( Value3Inner.Pack )

                    if NotActive then
                        Pack3 = not ModCatalog.OwnsSound( LocalPlayer, Key2 )
                    else
                        Pack3 = NotActive
                    end
                else
                    Pack3 = Find2
                end
            else
                Pack3 = Pack2
            end
            if not Value3Inner.Hidden and not Pack3 then
                table.insert( Table, { id = Key2, s = Value3Inner } )
            end
        end

        local Value4
        table.sort( Table, function( Argument1, Argument2 )
            local Flag = ( Argument1.s.Order or 99 ) < ( Argument2.s.Order or 99 ) and true or false
            return Flag
        end )
        Value4 = nil
        Number = 0

        for Key3, Value5 in Table, nil, nil do
            local Paid2
            local Pack = Value5.s.Pack

            if Pack then
                Paid2 = not ModCatalog.OwnsSound( LocalPlayer, Value5.id )
            else
                local Paid = Value5.s.Paid

                if Paid then
                    Paid2 = not ModCatalog.OwnsSound( LocalPlayer, Value5.id )
                else
                    Paid2 = Paid
                end
            end

            local Find

            if Pack then
                Find = LimitedPacks.Find( Pack )
            else
                Find = Pack
            end

            local Name2

            if not Find or not Find.Name then
                if Pack then
                    Name2 = Pack .. " Pack"
                else
                    Name2 = Pack
                end
            else
                Name2 = Find.Name
            end

            local Name3
            local Id = Value5.id
            local Name = Value5.s.name
            Name3 = if Name then Name else Value5.id
            local Badge
            local Table2Inner = { pack = Pack }

            if Pack then
                local Text = not Paid2 and "" or "🔒 "
                local Text2 = Text .. Name2

                if Text2 then
                    Badge = Text2
                elseif Paid2 then
                    Badge = "🔒 Locked"
                else
                    Badge = nil
                end
            elseif Paid2 then
                Badge = "🔒 Locked"
            else
                Badge = nil
            end

            Table2Inner.badge = Badge
            AddCard( Key3, "Sound", Id, Name3, Table2Inner )
            Number = Number + 1
        end

        local Value6
        PreviewShot( nil, true )
        Value6 = nil

        for Key4, Value7 in Table, nil, nil do
            PreviewShot( Value7.id, true )
        end

        Text4 = nil
    elseif CategoryName == "Camo" or CategoryName == "Skin" then
        if CategoryName == "Skin" then
            local Clone2 = WeaponVisuals[ Value2 ]:Clone( )
            AddCard( 0, "Skin", nil, "Default", { model = Clone2, O = Clone2.PrimaryPart.CFrame } )
            Text4 = nil
        else
            local Entry7
            AddCard( 0, "Camo", nil, "None", { } )
            local Entry6 = Table5[ Value2 ]
            Entry7 = if Entry6 then Entry6 else { }
            local Skin2
            local Skin = Entry7.Skin
            Skin2 = if Skin then ModCatalog.Skins[ Skin ] else Skin
            local Flag2

            if Skin2 == nil then
                Flag2 = false
            elseif Skin2.Model == nil then
                Flag2 = false
            else
                Flag2 = true
            end
            if Flag2 then
                Text4 = "Skin applied: remove it in Skins to use camos"
            else
                Text4 = nil
            end
        end

        local Flag3 = CategoryName == "Skin" and true or false
        local Value13
        local ShownSkins2 = ShownSkins( Flag3 )
        Value13 = nil
        Number = 0

        for Key7, Value14Inner in ShownSkins2, nil, nil do
            local Pack6
            local Pack4 = Value14Inner.s.Pack
            Pack6 = if Pack4 then not ModCatalog.OwnsSkin( LocalPlayer, Value14Inner.id ) else Pack4
            local Find3

            if Pack4 then
                Find3 = LimitedPacks.Find( Pack4 )
            else
                Find3 = Pack4
            end

            local Name5

            if not Find3 or not Find3.Name then
                if Pack4 then
                    Name5 = Pack4 .. " Pack"
                else
                    Name5 = Pack4
                end
            else
                Name5 = Find3.Name
            end

            local Text7

            if Value14Inner.s.Clan then
                local ClanTag2

                if LocalPlayer:GetAttribute( "ClanId" ) == Value14Inner.s.Clan then
                    local ClanTag = LocalPlayer:GetAttribute( "ClanTag" )

                    if ClanTag then
                        ClanTag2 = ClanTag
                    else
                        local TagText = Value14Inner.s.TagText

                        if TagText then
                            ClanTag2 = TagText
                        else
                            ClanTag2 = ""
                        end
                    end
                else
                    local TagText = Value14Inner.s.TagText

                    if TagText then
                        ClanTag2 = TagText
                    else
                        ClanTag2 = ""
                    end
                end

                local Text6 = "Clan [" .. tostring( ClanTag2 ) .. "]"

                if Text6 then
                    Text7 = Text6
                else
                    Text7 = nil
                end
            else
                Text7 = nil
            end

            local Image
            local Table5Inner = { }
            local Swatch = Value14Inner.s.Swatch
            Image = if Swatch then Swatch else Value14Inner.s.Texture
            local Pack5
            Table5Inner.image = Image
            Table5Inner.swatch = Value14Inner.s.Color

            if Pack4 then
                Pack5 = Pack4
            else
                local Event = Value14Inner.s.Event

                if Event then
                    Pack5 = Event
                else
                    Pack5 = Text7
                end
            end

            local Badge2
            Table5Inner.pack = Pack5

            if Pack4 then
                local Text8 = not Pack6 and "" or "🔒 "
                local Text9 = Text8 .. Name5

                if Text9 then
                    Badge2 = Text9
                elseif Value14Inner.s.Event then
                    if Value14Inner.s.Rank then
                        Badge2 = "Ranked"
                    else
                        Badge2 = "Event"
                    end
                else
                    Badge2 = Text7
                end
            elseif Value14Inner.s.Event then
                if Value14Inner.s.Rank then
                    Badge2 = "Ranked"
                else
                    Badge2 = "Event"
                end
            else
                Badge2 = Text7
            end

            local Locked2
            Table5Inner.badge = Badge2
            local NotPack = not Pack4

            if NotPack then
                local Text10 = "Skin:" .. Value14Inner.id
                local Lockable2 = AttachmentCases.Lockable( Text10 )

                if Lockable2 then
                    Locked2 = not AttachmentCases.Unlocked( LocalPlayer, Text10 )
                else
                    Locked2 = Lockable2
                end
            else
                Locked2 = NotPack
            end

            Table5Inner.locked = Locked2

            if CategoryName == "Skin" then
                local Model = ModCatalog.SkinVisual( Value2, { Skin = Value14Inner.id } ):Clone( )

                for Key9, Value18 in Model:GetDescendants( ) do
                    if Value18:IsA( "BaseScript" ) or Value18:IsA( "Sound" ) or Value18:IsA( "ParticleEmitter" ) then
                        Value18:Destroy( )
                    end
                end

                local O = Model.PrimaryPart.CFrame
                Table5Inner.model = Model
                Table5Inner.O = O
                Table5Inner.image = nil
                Table5Inner.swatch = nil
            end

            local Name7
            local Id2 = Value14Inner.id
            local Name6 = Value14Inner.s.name
            Name7 = if Name6 then Name6 else Value14Inner.id
            AddCard( Key7, CategoryName, Id2, Name7, Table5Inner )
            Number = Number + 1
        end
        if CategoryName == "Camo" then
            PreloadCamos( ShownSkins2 )
        end
    else
        local CFrame = WeaponVisuals[ Value2 ].PrimaryPart.CFrame
        local BaseModel = ModCatalog.BaseModel( Value2, CategoryName )

        if BaseModel then
            AddCard( 0, CategoryName, nil, Table4[ CategoryName ] or "Default", { model = BaseModel, O = CFrame, base = true, badge = "Default" } )
        end

        local Available2
        local Available = ModCatalog.Available( Value2 )
        Available2 = if Available then Available else { }
        local Entry3
        local Entry2 = Available2[ CategoryName ]
        Entry3 = if Entry2 then Entry2 else { }
        local Value8
        local Clone = table.clone( Entry3 )
        local Table3Inner = { }
        Value8 = nil

        for Key5, Value9Inner in Clone, nil, nil do
            Table3Inner[ Value9Inner ] = Key5
        end

        local Value10

        local function Rank( Text )
            return Table16[ AttachmentCases.TIER[ "Mod:" .. Text ] ] or 0
        end

        table.sort( Clone, function( Key, Key2 )
            if ( Table16[ AttachmentCases.TIER[ "Mod:" .. Key ] ] or 0 ) == ( Table16[ AttachmentCases.TIER[ "Mod:" .. Key2 ] ] or 0 ) then
                local Flag2 = Table3Inner[ Key ] < Table3Inner[ Key2 ] and true or false
                return Flag2
            end
            local Flag = ( Table16[ AttachmentCases.TIER[ "Mod:" .. Key ] ] or 0 ) < ( Table16[ AttachmentCases.TIER[ "Mod:" .. Key2 ] ] or 0 ) and true or false
            return Flag
        end )
        Value10 = nil
        Number = 0

        for Key6, Value11 in Clone, nil, nil do
            local Entry5
            local Entry4 = Table3[ Value11 ]

            if Entry4 then
                Entry5 = Entry4
            elseif ModCatalog.Items[ Value11 ] then
                local Name4 = ModCatalog.Items[ Value11 ].name

                if Name4 then
                    Entry5 = Name4
                else
                    Entry5 = Value11
                end
            else
                Entry5 = Value11
            end

            local Locked
            local Table4Inner = { model = ModCatalog.Mount( Value2, Value11 ):Clone( ), O = CFrame }
            local Text3 = "Mod:" .. Value11
            local Lockable = AttachmentCases.Lockable( Text3 )
            Locked = if Lockable then not AttachmentCases.Unlocked( LocalPlayer, Text3 ) else Lockable
            Table4Inner.locked = Locked
            Table4Inner.tier = AttachmentCases.TIER[ "Mod:" .. Value11 ]
            AddCard( Key6, CategoryName, Value11, Entry5, Table4Inner )
            Number = Number + 1
            Text4 = nil
        end

        Text4 = nil
    end

    local Text5 = if Text4 then Text4 else ( "%d item(s)" ):format( Number )
    local Value16
    Status.Text = Text5
    Grid.CanvasPosition = Vector2.zero
    StyleCards( )
    Value16 = nil

    for Key8, Value15 in Grid:GetChildren( ) do
        if Value15:IsA( "GuiButton" ) and Value15.Visible then
            if not Value16 or Value15.LayoutOrder < Value16.LayoutOrder then
                Value16 = Value15
            end
        end
    end

    local Value17
    local Refresh = GamepadNav.Refresh
    Value17 = if not Argument2 or not Value16 then Table8[ CategoryName ] else Value16
    Refresh( "Armory", Value17 )
end

local function CycleCategory( Argument1 )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        if Value.Visible then
            table.insert( Table, { f = Key, o = Value.LayoutOrder } )
        end
    end
    if #Table == 0 then
        return
    end

    local Value2, Number
    table.sort( Table, function( Argument1, Argument2 )
        local Flag = Argument1.o < Argument2.o and true or false
        return Flag
    end )
    Value2 = nil
    Number = 1

    for Key2, Value3Inner in Table, nil, nil do
        if Value3Inner.f == Value3 then
            Number = Key2
        end
    end

    SelectCategory( Table[ ( Number - 1 + Argument1 ) % #Table + 1 ].f, true )
end

local function BuildCategories()
    local Available2
    ClearClones( Categories, CategoryTemplate )
    table.clear( Table8 )
    local Available = ModCatalog.Available( Value2 )
    Available2 = if Available then Available else { }
    local Value1, Number, Id
    local Families = ModCatalog.Families
    Value1 = nil
    Number = 0
    Id = nil

    for Key, Value in Families, nil, nil do
        if Available2[ Value.id ] then
            local Text2
            local LayoutOrder2 = Number + 1
            local Clone = CategoryTemplate:Clone( )
            Clone.Name = "Cat_" .. Value.id
            local Text = Clone.Text
            local Entry2 = Table2[ Value.id ]
            Text2 = if Entry2 then Entry2 else Value.name
            local Id2
            Text.Text = Text2
            Clone.LayoutOrder = LayoutOrder2
            Clone.Visible = true
            Clone.Parent = Categories
            Clone.Activated:Connect( function()
                SelectCategory( Value.id )
            end )
            Table8[ Value.id ] = Clone
            Id2 = if Id then Id else Value.id
            Number = LayoutOrder2
            Id = Id2
        end
    end
    if #ShownSkins( true ) > 0 then
        local LayoutOrder = Number + 1
        local Skin = CategoryTemplate:Clone( )
        Skin.Name = "Cat_Skin"
        Skin.Text.Text = "Skins"
        Skin.LayoutOrder = LayoutOrder
        Skin.Visible = true
        Skin.Parent = Categories
        Skin.Activated:Connect( function()
            SelectCategory( "Skin" )
        end )
        Table8.Skin = Skin
        Number = LayoutOrder
    end

    local Camo = CategoryTemplate:Clone( )
    Camo.Name = "Cat_Camo"
    Camo.Text.Text = "Camos"
    Camo.LayoutOrder = Number + 1
    Camo.Visible = true
    Camo.Parent = Categories
    Camo.Activated:Connect( function()
        SelectCategory( "Camo" )
    end )
    Table8.Camo = Camo

    if WeaponData[ Value2 ] then
        local Sound = CategoryTemplate:Clone( )
        Sound.Name = "Cat_Sound"
        Sound.Text.Text = "Shot Sound"
        Sound.LayoutOrder = Number + 2
        Sound.Visible = true
        Sound.Parent = Categories
        Sound.Activated:Connect( function()
            SelectCategory( "Sound" )
        end )
        Table8.Sound = Sound
    end

    local Captured
    RefreshNew( )

    if Value3 then
        local Entry = Table8[ Value3 ]

        if Entry then
            Captured = Value3
        else
            Captured = Entry
        end
    else
        Captured = Value3
    end

    local Captured2

    if Captured then
        Captured2 = Captured
    elseif Id then
        Captured2 = Id
    else
        Captured2 = "Camo"
    end

    SelectCategory( Captured2 )
end

LocalPlayer:GetAttributeChangedSignal( "Unlocks" ):Connect( function()
    if Flag and Value2 and Value3 then
        SelectCategory( Value3 )
    end
end )
LocalPlayer:GetAttributeChangedSignal( "ClanId" ):Connect( function()
    if Flag and Value2 and Value3 then
        SelectCategory( Value3 )
    end
end )
local Table21 = { }
local Folder2 = Instance.new( "Folder" )
Folder2.Name = "ArmoryPreview"

BuildPreview = function()
    if Value4 then
        Value4:Destroy( )
        Value4 = nil
    end
    if not Flag or not Value2 then
        return
    end

    local Entry2
    local Entry = Table5[ Value2 ]
    Entry2 = if Entry then Entry else { }
    local SkinVisual2
    local Apply = ModCatalog.Apply
    local SkinVisual = ModCatalog.SkinVisual( Value2, Entry2 )
    SkinVisual2 = if SkinVisual then SkinVisual else WeaponVisuals[ Value2 ]
    local Apply2 = Apply( SkinVisual2:Clone( ), Value2, Entry2 )

    for Key, Value in Apply2:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            Value.Anchored = true
            Value.CanCollide = false
            Value.CanQuery = false
            Value.CanTouch = false
        elseif Value:IsA( "BaseScript" ) then
            Value:Destroy( )
        end
    end

    local Pivot

    if Apply2.PrimaryPart then
        local CFrame = Apply2.PrimaryPart.CFrame

        if CFrame then
            Pivot = CFrame
        else
            Pivot = Apply2:GetPivot( )
        end
    else
        Pivot = Apply2:GetPivot( )
    end

    local Entry5
    local Entry3 = Table21[ Value2 ]

    if Entry3 then
        Entry5 = Entry3
    else
        local Pivot2
        local Entry4 = WeaponVisuals[ Value2 ]

        if Entry4.PrimaryPart then
            local CFrame2 = Entry4.PrimaryPart.CFrame

            if CFrame2 then
                Pivot2 = CFrame2
            else
                Pivot2 = Entry4:GetPivot( )
            end
        else
            Pivot2 = Entry4:GetPivot( )
        end

        local Value1, Value2Inner = VisibleBounds( Entry4 )
        local Table = { Value2Inner.X, Value2Inner.Y, Value2Inner.Z }
        table.sort( Table )
        local Table2 = {
            center = Pivot2:PointToObjectSpace( Value1.Position ),
            radius = math.sqrt( Table[ 2 ] ^ 2 + Table[ 3 ] ^ 2 ) / 2
        }
        Table21[ Value2 ] = Table2
        Entry5 = Table2
    end

    Value5 = {
        O = Pivot,
        center = Entry5.center,
        pivot = Pivot:ToObjectSpace( Apply2:GetPivot( ) ),
        radius = Entry5.radius,
        scale0 = Apply2:GetScale( ),
        k = 1
    }
    Folder2.Parent = workspace
    Apply2.Parent = Folder2
    Value4 = Apply2
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
local Value15 = nil
local Value16 = nil
local Table22 = {
    GlobalGui = true,
    HealthBar = true,
    Freecam = true,
    ScopePreload = true,
    GamepadHints = true,
    GamepadSelection = true,
    Notifications = true
}
local Table23 = { }
local Table24 = { }

local function HideOne( OneName, OneName2 )
    if OneName == Parent or Table22[ OneName2 ] or OneName2:sub( 1, 6 ) == "Topbar" or Table23[ OneName ] ~= nil then
        return
    end
    Table23[ OneName ] = Screens.IsShown( OneName )
    Screens.SetShown( OneName, false )
    table.insert( Table24, Screens.ShownChanged( OneName ):Connect( function()
        if Screens.IsShown( OneName ) then
            Table23[ OneName ] = true
            Screens.SetShown( OneName, false )
        end
    end ) )
    return
end

local function HideOthers( Visible )
    local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )

    if Visible then
        for Key, Value in Screens.All( PlayerGui ) do
            HideOne( Value.obj, Value.name )
        end

        table.insert( Table24, PlayerGui.ChildAdded:Connect( function( OneName )
            if OneName:IsA( "ScreenGui" ) and not Screens.GROUPS[ OneName.Name ] then
                HideOne( OneName, OneName.Name )
            end
        end ) )
        return
    end
    local Value1 = nil

    for Key2, Value2 in Table24, nil, nil do
        Value2:Disconnect( )
    end

    local Value3
    table.clear( Table24 )
    Value3 = nil

    for Key3, Value4 in Table23, nil, nil do
        if Key3.Parent then
            Screens.SetShown( Key3, Value4 )
        end
    end

    table.clear( Table23 )
    return
end

local function UpdateView( View )
    if not Value4 or not Value5 or not Value1 then
        return
    end

    local Number5Inner, Number6
    local FixedCamera = Value1.eye
    local LookVector = FixedCamera.LookVector
    local Unit = LookVector:Cross( Vector3.new( 0, 1, 0 ) ).Unit
    local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), -LookVector, Vector3.new( 0, 1, 0 ) )
    local Exp = 1 - math.exp( -18 * View )
    Number4 = Number4 + ( Number - Number4 ) * Exp
    Number5 = Number5 + ( Number2 - Number5 ) * Exp
    local FromAxisAngle = CFrame.fromAxisAngle( Unit, Number5 ) * CFrame.fromAxisAngle( Vector3.new( 0, 1, 0 ), Number4 ) * FromMatrix
    local Radius = Value5.radius
    local X = CurrentCamera.ViewportSize.X / math.max( CurrentCamera.ViewportSize.Y, 1 )
    local Radius2 = Radius / 0.34577172255289224
    local Grid = Main.Grid
    local Clamp = math.clamp( ( Grid.AbsolutePosition.X + Grid.AbsoluteSize.X ) / math.max( CurrentCamera.ViewportSize.X, 1 ), 0.15, 0.7 )
    local Clamp2 = ( Clamp + 1 ) / 2
    local Max = math.max( Radius2, Radius / ( 0.36397023426620234 * X * ( 1 - Clamp ) * 0.86 ) )

    if Value1.from then
        local Interactions2
        local Interactions = workspace:FindFirstChild( "Interactions" )
        Interactions2 = if Interactions then Interactions else workspace
        local Number2Inner
        local ArmoryStation = Interactions2:FindFirstChild( "ArmoryStation" )

        if ArmoryStation then
            local NumberInner = tonumber( ArmoryStation:GetAttribute( "WeaponDist" ) )

            if NumberInner then
                Number2Inner = NumberInner
            else
                Number2Inner = 6
            end
        else
            Number2Inner = 6
        end

        local Number4Inner

        if ArmoryStation then
            local Number3Inner = tonumber( ArmoryStation:GetAttribute( "WeaponFill" ) )

            if Number3Inner then
                Number4Inner = Number3Inner
            else
                Number4Inner = 1
            end
        else
            Number4Inner = 1
        end

        Number5Inner = Number2Inner
        Number6 = Number4Inner
    else
        Number5Inner = 6
        Number6 = 0.9
    end

    local Entry3
    local Number7 = Number5Inner / Max * Number6
    local Entry = Table[ Value2 ]

    if Entry then
        Entry3 = Entry
    else
        local Entry2 = ItemRender.ICON_SCALE[ Value2 ]

        if Entry2 then
            Entry3 = Entry2
        else
            Entry3 = 1
        end
    end

    local K = Number7 * Entry3
    local Abs = math.abs( K - Value5.k )

    if 0.01 * Value5.k < Abs then
        Value5.k = K
        pcall( function()
            Value4:ScaleTo( Value5.scale0 * K )
        end )
    end

    K = Value5.k
    local Radius3 = Radius * K
    local Number8 = Number5Inner / Number3
    Value6 = Value6 or { radius = Radius3 }
    local Number9 = Number8 * 0.36397023426620234 * X
    local Clamp3 = ( Clamp2 - 0.5 ) * 2 * Number9
    local LookVector2 = LookVector * Number8 + Unit * Clamp3
    local FilterDescendantsInstances = {
        Folder2,
        workspace:FindFirstChild( "FX" ),
        workspace:FindFirstChild( "ClientHitboxes" )
    }

    for Key, Value in Players:GetPlayers( ) do
        if Value.Character then
            table.insert( FilterDescendantsInstances, Value.Character )
        end
    end

    local LookVector3
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Position = FixedCamera.Position
    local Spherecast = workspace:Spherecast( Position, math.max( Radius3 * 0.6, 0.5 ), LookVector2, RaycastParams2 )
    LookVector3 = if Spherecast then LookVector2.Unit * math.max( Spherecast.Distance - Radius3 * 0.3, 1.5 ) else LookVector2
    local Position2 = FixedCamera.Position + LookVector3
    local CFrame2 = CFrame.new( Position2 ) * FromAxisAngle * CFrame.new( -Value5.center * K )
    local Pivot = Value5.pivot
    Value4:PivotTo( CFrame2 * ( CFrame.new( Pivot.Position * K ) * Pivot.Rotation ) )

    if Value15 then
        Value15.CFrame = CFrame.new( FixedCamera.Position + ( Position2 - FixedCamera.Position ) * 0.4 + Vector3.new( 0, 1.5, 0 ) )
    end
    if not Value1.from then
        ClientState.FixedCamera = FixedCamera
        ClientState.FixedFOV = 40
        Value16 = FixedCamera
        return
    end

    local Clamp4 = math.clamp( ( os.clock( ) - Value1.t0 ) / 0.9, 0, 1 )
    local Clamp5 = Clamp4 * Clamp4 * ( 3 - Clamp4 * 2 )
    Value1.fade = math.clamp( Clamp4 / 0.4, 0, 1 )

    if Clamp4 < 1 or not Value1.faded then
        local Faded = Clamp4 >= 1 and true or false
        local Descendants
        Value1.faded = Faded
        local Character = LocalPlayer.Character
        Descendants = Character and Character:GetDescendants( ) or { }
        local Value1Inner = nil

        for Key2, Value2Inner in Descendants, nil, nil do
            if Value2Inner:IsA( "BasePart" ) or Value2Inner:IsA( "Decal" ) then
                Value2Inner.LocalTransparencyModifier = Value1.fade
            end
        end
    end

    local FixedCamera2 = Value1.from:Lerp( FixedCamera, Clamp5 )
    local FixedFOV = Value1.fovFrom + ( 40 - Value1.fovFrom ) * Clamp5
    ClientState.FixedCamera = FixedCamera2
    ClientState.FixedFOV = FixedFOV
    Value16 = ClientState.FixedCamera
end

local function SelectWeapon( Name )
    if not WeaponVisuals:FindFirstChild( Name ) then
        return
    end

    local Text
    Value2 = Name

    if WeaponData[ Name ] then
        local Name2 = WeaponData[ Name ].Name

        if Name2 then
            Text = Name2
        elseif MeleeData[ Name ] then
            local Name3 = MeleeData[ Name ].Name

            if Name3 then
                Text = Name3
            else
                Text = Name
            end
        else
            Text = Name
        end
    elseif MeleeData[ Name ] then
        local Name3 = MeleeData[ Name ].Name

        if Name3 then
            Text = Name3
        else
            Text = Name
        end
    else
        Text = Name
    end

    WeaponName.Text = Text
    Number = 3.141592653589793
    Number2 = 0
    Number3 = 1
    Number4 = 3.141592653589793
    Number5 = 0
    Value6 = nil
    BuildCategories( )
    BuildPreview( )
    StyleCards( )
end

local SetOpen = nil
Main.SaveButton.Activated:Connect( function()
    SetOpen( false )
end )
Main.CancelButton.Activated:Connect( function()
    local Value1 = nil

    for Key, Value in Table6, nil, nil do
        if not SameMods2( Value, Table5[ Key ] ) then
            Table5[ Key ] = Value
            Number6 = Number6 + 1
            task.spawn( function()
                local InvokeServer = Remotes.SetMods.InvokeServer
                local Success, Result = pcall( InvokeServer, Remotes.SetMods, Key, Value )

                if Success and type( Result ) == "table" and Number6 == Number6 then
                    local SameMods22 = SameMods2( Table5[ Key ], Result )
                    Table5[ Key ] = Result

                    if Flag and Key == Value2 and not SameMods22 then
                        BuildPreview( )
                        StyleCards( )
                    end
                end
            end )
        end
    end

    SetOpen( false )
end )
UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if not Flag or Argument2 then
        return
    end
    if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
        local Position = Argument1.Position
        Flag2 = true
        Value7 = Position
    end
end )
UserInputService.InputChanged:Connect( function( Argument1, Argument2 )
    if not Flag then
        return
    end
    if Argument1.UserInputType == Enum.UserInputType.MouseWheel and not Argument2 then
        Number3 = math.clamp( Number3 * ( 1 + 0.12 * Argument1.Position.Z ), 0.7, 2.6 )
        return
    end
    if not Flag2 then
        return
    end
    if Argument1.UserInputType == Enum.UserInputType.MouseMovement then
        local Vector23
        local Vector22 = Vector2.new( Argument1.Delta.X, Argument1.Delta.Y )

        if Vector22.Magnitude < 0.01 then
            Vector23 = Vector2.new( Argument1.Position.X - Value7.X, Argument1.Position.Y - Value7.Y )
        else
            Vector23 = Vector22
        end

        Value7 = Argument1.Position
        Number = Number + Vector23.X * 0.005
        Number2 = math.clamp( Number2 + Vector23.Y * 0.005, -1.2, 1.2 )
        return
    end
    if Argument1.UserInputType == Enum.UserInputType.Touch then
        local Position = Argument1.Position - Value7
        Value7 = Argument1.Position
        Number = Number + Position.X * 0.005
        Number2 = math.clamp( Number2 + Position.Y * 0.005, -1.2, 1.2 )
    end

    return
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
        Flag2 = false
    end
end )
UserInputService.TouchPinch:Connect( function( Argument1, Amount, Argument3, Argument4, Argument5 )
    if not Flag or Argument5 then
        return
    end
    if Argument4 == Enum.UserInputState.Change then
        Number3 = math.clamp( Number3 * ( 1 + ( Amount - 1 ) * 0.05 ), 0.7, 2.6 )
    end
end )
RunService:BindToRenderStep( "ArmoryView", Enum.RenderPriority.Camera.Value - 1, function( View )
    if not Flag then
        return
    end
    for Key, Value in UserInputService:GetGamepadState( Enum.UserInputType.Gamepad1 ) do
        if Value.KeyCode ~= Enum.KeyCode.Thumbstick2 or not ( Value.Position.Magnitude > 0.15 ) then
            if Value.KeyCode ~= Enum.KeyCode.ButtonR2 or not ( Value.Position.Z > 0.1 ) then
                if Value.KeyCode == Enum.KeyCode.ButtonL2 and Value.Position.Z > 0.1 then
                    Number3 = math.clamp( Number3 * ( 1 - Value.Position.Z * View ), 0.7, 2.6 )
                end
            else
                Number3 = math.clamp( Number3 * ( 1 + Value.Position.Z * View ), 0.7, 2.6 )
            end
        else
            Number = Number + Value.Position.X * 2.6 * View
            Number2 = math.clamp( Number2 - Value.Position.Y * 2.6 * View, -1.2, 1.2 )
        end
    end
    if not ClientState.CursorFree then
        ClientState.CursorFree = true
    end

    UpdateView( View )
end )
RunService:BindToRenderStep( "ArmoryMouse", Enum.RenderPriority.Camera.Value + 1, function()
    if not Flag or not Flag2 then
        return
    end
    if UserInputService:IsMouseButtonPressed( Enum.UserInputType.MouseButton1 ) then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
        return
    end
    if not UserInputService.TouchEnabled then
        Flag2 = false
    end
end )

local function Sink()
    return Enum.ContextActionResult.Sink
end

local function HintText()
    if Controls.IsGamepad then
        return "Right stick: rotate · LT / RT: zoom"
    end
    if not UserInputService.TouchEnabled or UserInputService.MouseEnabled then
        return "Drag to rotate · Scroll to zoom"
    end
    return "Drag to rotate · Pinch to zoom"
end

local function HeldWeapon()
    local Tool
    local Character = LocalPlayer.Character

    if Character then
        Tool = LocalPlayer.Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Melee

    if Tool then
        local Weapon = Tool:GetAttribute( "Weapon" )

        if Weapon then
            Melee = Weapon
        else
            Melee = Tool:GetAttribute( "Melee" )
        end
    else
        Melee = Tool
    end
    if not Melee or not WeaponMods:FindFirstChild( Melee ) or not WeaponVisuals:FindFirstChild( Melee ) then
        return nil
    end
    return Melee, Tool
end

local function OpenBtnLabel( Text, TextColor3 )
    if not OpenButton then
        return
    end

    local IsGamepad2
    local PadGlyph = OpenButton:FindFirstChild( "PadGlyph" )
    local IsGamepad = Controls.IsGamepad

    if IsGamepad then
        if PadGlyph == nil then
            IsGamepad2 = false
        else
            IsGamepad2 = true
        end
    else
        IsGamepad2 = IsGamepad
    end
    if IsGamepad2 then
        PadGlyph.Image = Controls.Glyph( Controls.Actions.Attachments.pad[ 1 ] ) or ""
    end
    if PadGlyph then
        local Visible

        if IsGamepad2 then
            if PadGlyph.Image == "" then
                Visible = false
            else
                Visible = true
            end
        else
            Visible = IsGamepad2
        end

        PadGlyph.Visible = Visible
    end

    local Text3
    local Text2 = OpenButton.Text

    if Text then
        Text3 = Text
    elseif IsGamepad2 then
        Text3 = "Attachments"
    else
        Text3 = "Attachments (M)"
    end

    local Number
    Text2.Text = Text3
    local Text4 = OpenButton.Text
    Number = not IsGamepad2 and 0.5 or 0.61
    local Number2
    Text4.Position = UDim2.fromScale( Number, 0.5 )
    local Text5 = OpenButton.Text
    Number2 = not IsGamepad2 and 0.93 or 0.66
    Text5.Size = UDim2.fromScale( Number2, 0.7 )
    local Text6 = OpenButton.Text
    Text6.TextColor3 = TextColor3 or Color3.fromRGB( 235, 235, 240 )
end

OpenBtnLabel( )
Controls.Changed:Connect( function()
    OpenBtnLabel( )
end )

local function SyncOpenGui()
    if Get then
        Screens.SetShown( Get, false )
    end
end

SyncOpenGui( )
Controls.Changed:Connect( SyncOpenGui )
UserInputService.LastInputTypeChanged:Connect( SyncOpenGui )
LocalPlayer:GetAttributeChangedSignal( "ForceTouch" ):Connect( SyncOpenGui )
local Number9 = 0

local function NeedWeapon()
    Number9 = Number9 + 1
    require( ReplicatedStorage:WaitForChild( "Notify" ) ).Error( "Hold a weapon first" )
end

local Value17 = nil
local Table25 = { }
local VisualRegistry = require( Weapons:WaitForChild( "VisualRegistry" ) )
local Value18 = nil
local Table26 = { }

local function SetVisHidden( Object, Argument2 )
    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
            local LocalTransparencyModifier = not Argument2 and 0 or 1
            Value.LocalTransparencyModifier = LocalTransparencyModifier
        elseif Value:IsA( "ParticleEmitter" ) or Value:IsA( "Light" ) or Value:IsA( "Beam" ) or Value:IsA( "Trail" ) then
            local Enabled = Value:GetAttribute( "ArmoryFxWas" )

            if Argument2 then
                if Enabled == nil then
                    Value:SetAttribute( "ArmoryFxWas", Value.Enabled )
                end

                Value.Enabled = false
            elseif Enabled ~= nil then
                Value.Enabled = Enabled
                Value:SetAttribute( "ArmoryFxWas", nil )
            end
        end
    end
end

local function HideCharacter( Argument1 )
    local Character = LocalPlayer.Character

    if Value17 then
        Value17:Disconnect( )
        Value17 = nil
    end
    if Value18 then
        Value18:Disconnect( )
        Value18 = nil
    end
    if Argument1 then
        Value18 = RunService.RenderStepped:Connect( function()
            local Character2
            local Character = LocalPlayer.Character
            Character2 = if Character then VisualRegistry[ LocalPlayer.Character ] else Character

            if Character2 and Character2.Parent then
                if Value1 and Value1.fade and Value1.fade < 1 then
                    for Key, Value in Character2:GetDescendants( ) do
                        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
                            Value.LocalTransparencyModifier = Value1.fade
                        end
                    end

                    Table26[ Character2 ] = true
                    return
                end
                Table26[ Character2 ] = true
                SetVisHidden( Character2, true )
            end
        end )
    else
        local Value1Inner = nil

        for Value in Table26, nil, nil do
            if Value.Parent then
                SetVisHidden( Value, false )
            end
        end

        table.clear( Table26 )
    end
    if not Argument1 or not Character then
        local Value3 = nil

        for Key2, Value4 in Table25, nil, nil do
            if Key2.Parent then
                Key2.Enabled = Value4
            end
        end

        table.clear( Table25 )
        return
    end
    local function Hide( Key )
        if Key:IsA( "BasePart" ) or Key:IsA( "Decal" ) then
            Key.LocalTransparencyModifier = 1
            return
        end
        if Key:IsA( "BillboardGui" ) and Table25[ Key ] == nil then
            Table25[ Key ] = Key.Enabled
            Key.Enabled = false
        end
    end

    for Key, Value2 in Character:GetDescendants( ) do
        if Value2:IsA( "BasePart" ) or Value2:IsA( "Decal" ) then
            Value2.LocalTransparencyModifier = 1
        elseif Value2:IsA( "BillboardGui" ) and Table25[ Value2 ] == nil then
            Table25[ Value2 ] = Value2.Enabled
            Value2.Enabled = false
        end
    end

    Value17 = Character.DescendantAdded:Connect( Hide )
    return
end

SetOpen = function( Visible, Eye )
    if Visible == Flag then
        return
    end
    if Visible then
        if ClientState.CursorFree or ClientState.FixedCamera then
            return
        end
    end

    local Value1Inner, Value2 = HeldWeapon( )

    if Visible and not Value1Inner then
        Number9 = Number9 + 1
        require( ReplicatedStorage:WaitForChild( "Notify" ) ).Error( "Hold a weapon first" )
        return
    end

    Flag = Visible
    Parent.Visible = Visible
    HideOthers( Visible )
    Flag2 = false

    if Visible then
        local Head
        ClientState.CursorFree = true
        local Character = LocalPlayer.Character

        if Character then
            Head = Character:FindFirstChild( "Head" )
        else
            Head = Character
        end

        local LookVector2
        local LookVector = CurrentCamera.CFrame.LookVector * Vector3.new( 1, 0, 1 )
        LookVector2 = if LookVector.Magnitude < 0.01 then Vector3.new( 0, 0, -1 ) else LookVector
        local Position2

        if Head then
            local Position = Head.Position + Vector3.new( 0, 0.30000001192092896, 0 )

            if Position then
                Position2 = Position
            else
                Position2 = CurrentCamera.CFrame.Position
            end
        else
            Position2 = CurrentCamera.CFrame.Position
        end

        local Table = { }
        Table.eye = Eye or CFrame.lookAt( Position2, Position2 + LookVector2.Unit )
        Value1 = Table

        if Eye then
            local From = CurrentCamera.CFrame
            local FovFrom = CurrentCamera.FieldOfView
            local T0 = os.clock( )
            Value1.from = From
            Value1.fovFrom = FovFrom
            Value1.t0 = T0
            Value1.fade = 0
        end

        local Brightness
        HideCharacter( true )
        local FillLight = Parent:GetAttribute( "FillLight" )

        if FillLight == nil then
            Brightness = 0.8
        else
            Brightness = FillLight
        end

        local ArmoryStation

        if Eye then
            local Interactions2
            local Interactions = workspace:FindFirstChild( "Interactions" )
            Interactions2 = if Interactions then Interactions else workspace
            ArmoryStation = Interactions2:FindFirstChild( "ArmoryStation" )
        else
            ArmoryStation = Eye
        end
        if ArmoryStation then
            Brightness = Brightness * ( tonumber( ArmoryStation:GetAttribute( "FillMult" ) ) or 1 )
            local ColorCorrectionEffect = Instance.new( "ColorCorrectionEffect" )
            ColorCorrectionEffect.Name = "ArmoryViewCC"
            ColorCorrectionEffect.Brightness = tonumber( ArmoryStation:GetAttribute( "ViewBrightness" ) ) or 0
            ColorCorrectionEffect.Contrast = tonumber( ArmoryStation:GetAttribute( "ViewContrast" ) ) or 0
            ColorCorrectionEffect.Parent = CurrentCamera
        end
        if Brightness > 0 then
            Value15 = Instance.new( "Part" )
            Value15.Name = "ArmoryFill"
            Value15.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
            Value15.Transparency = 1
            Value15.Anchored = true
            Value15.CanCollide = false
            Value15.CanQuery = false
            Value15.CanTouch = false
            local PointLight = Instance.new( "PointLight" )
            PointLight.Brightness = Brightness
            PointLight.Range = 10
            PointLight.Shadows = false
            PointLight.Parent = Value15
            Value15.Parent = Folder2
        end

        local Text
        ContextActionService:BindActionAtPriority( "ArmoryFreeze", Sink, false, 3000, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump )
        RunService:BindToRenderStep( "ArmoryHandover", Enum.RenderPriority.Last.Value - 1, function()
            if ClientState.WardrobeOpen == true or ClientState.IntroCinematic == true then
                SetOpen( false )
            end
        end )

        if Controls.IsGamepad then
            Text = "Right stick: rotate · LT / RT: zoom"
        elseif not UserInputService.TouchEnabled or UserInputService.MouseEnabled then
            Text = "Drag to rotate · Scroll to zoom"
        else
            Text = "Drag to rotate · Pinch to zoom"
        end

        Hint.Text = Text
        local Mods = Value2:GetAttribute( "Mods" )

        if Mods then
            Table5[ Value1Inner ] = ModCatalog.Decode( Mods )
        end

        local Value3Inner
        table.clear( Table6 )
        Value3Inner = nil

        for Key, Value in Table5, nil, nil do
            Table6[ Key ] = table.clone( Value )
        end

        SelectWeapon( Value1Inner )
        task.spawn( function()
            local InvokeServer = Remotes.GetMods.InvokeServer
            local Success, Result = pcall( InvokeServer, Remotes.GetMods )

            if Success and type( Result ) == "table" and Flag then
                local Value1 = nil

                for Key, Value in Result, nil, nil do
                    Table5[ Key ] = Value

                    if Table6[ Key ] == nil then
                        Table6[ Key ] = table.clone( Value )
                    end
                end

                BuildPreview( )
                StyleCards( )
            end
        end )
        GamepadNav.Open( "Armory", {
            root = Parent,
            first = function()
                return Table8[ Value3 ]
            end,
            onBack = function()
                SetOpen( false )
            end,
            tabs = {
                prev = function()
                    CycleCategory( -1 )
                end,
                next = function()
                    CycleCategory( 1 )
                end,
                label = "Category"
            },
            selectLabel = "Equip"
        } )
        return
    end
    local FlagInner

    if ClientState.WardrobeOpen == true then
        FlagInner = true
    elseif ClientState.IntroCinematic == true then
        FlagInner = true
    else
        FlagInner = false
    end
    if Picker then
        Picker:Close( )
    end

    Value9 = nil
    RefreshBuy( )
    RunService:UnbindFromRenderStep( "ArmoryHandover" )
    GamepadNav.Close( "Armory" )
    ContextActionService:UnbindAction( "ArmoryFreeze" )

    if Value4 then
        Value4:Destroy( )
        Value4 = nil
    end
    if Value15 then
        Value15:Destroy( )
        Value15 = nil
    end

    local NotFlag2
    Folder2.Parent = nil
    local NotFlag = not FlagInner

    if NotFlag then
        if Value1 then
            local From2 = Value1.from

            if From2 then
                local FixedCamera = ClientState.FixedCamera

                if FixedCamera then
                    NotFlag2 = {
                        from = ClientState.FixedCamera,
                        to = Value1.from,
                        fovFrom = ClientState.FixedFOV or 40,
                        fovTo = Value1.fovFrom
                    }
                else
                    NotFlag2 = FixedCamera
                end
            else
                NotFlag2 = From2
            end
        else
            NotFlag2 = Value1
        end
    else
        NotFlag2 = NotFlag
    end

    local ArmoryViewCC = CurrentCamera:FindFirstChild( "ArmoryViewCC" )

    if ArmoryViewCC then
        ArmoryViewCC:Destroy( )
    end

    local Descendants
    Value1 = nil
    HideCharacter( false )
    local Character2 = LocalPlayer.Character
    Descendants = Character2 and Character2:GetDescendants( ) or { }
    local Value4Inner = nil

    for Key2, Value5 in Descendants, nil, nil do
        if Value5:IsA( "BasePart" ) or Value5:IsA( "Decal" ) then
            Value5.LocalTransparencyModifier = 0
        end
    end
    if not FlagInner or ClientState.FixedCamera == Value16 then
        ClientState.FixedCamera = nil
        ClientState.FixedFOV = nil
    end

    Value16 = nil

    if not FlagInner then
        ClientState.CursorFree = false
    end
    if NotFlag2 then
        local FixedCamera2 = NotFlag2.from
        local FixedFOV = NotFlag2.fovFrom
        ClientState.FixedCamera = FixedCamera2
        ClientState.FixedFOV = FixedFOV
        local Clock = os.clock( )
        local Connect = nil
        Connect = RunService.RenderStepped:Connect( function()
            if Flag then
                Connect:Disconnect( )
                return
            end

            local Clamp = math.clamp( ( os.clock( ) - Clock ) / 0.6, 0, 1 )
            local Clamp2 = Clamp * Clamp * ( 3 - Clamp * 2 )
            local From = NotFlag2.from
            ClientState.FixedCamera = From:Lerp( NotFlag2.to, Clamp2 )
            ClientState.FixedFOV = NotFlag2.fovFrom + ( NotFlag2.fovTo - NotFlag2.fovFrom ) * Clamp2

            if Clamp >= 1 then
                Connect:Disconnect( )
                ClientState.FixedCamera = nil
                ClientState.FixedFOV = nil
            end
        end )
    end

    return
end

if OpenButton then
    OpenButton.Activated:Connect( function()
        if Flag then
            SetOpen( false )
        end
    end )
end

UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if Argument2 or not Flag or not Controls.Is( "Attachments", Argument1 ) then
        return
    end
    if UserInputService:GetFocusedTextBox( ) then
        return
    end
    SetOpen( false )
    return
end )
LocalPlayer.CharacterAdded:Connect( function()
    if Flag then
        SetOpen( false )
    end
end )
Parent:GetPropertyChangedSignal( "Visible" ):Connect( function()
    if Parent.Visible and not Flag then
        Parent.Visible = false
    end
end )
LocalPlayer.AttributeChanged:Connect( function( Self )
    local FlagInner

    if Self:sub( 1, 5 ) == "Pack_" then
        FlagInner = true
    elseif Self:sub( 1, 11 ) == "WeaponSkin_" then
        FlagInner = true
    elseif Self:sub( 1, 10 ) == "ShotSound_" then
        FlagInner = true
    else
        FlagInner = false
    end
    if FlagInner and Flag then
        if Value3 == "Camo" or Value3 == "Sound" or Value3 == "Skin" then
            SelectCategory( Value3 )
        end
    end
    if FlagInner then
        if Value9 then
            RobuxShopUI.Done( Value9.product )
        end

        RefreshBuy( )
    end
end )
LocalPlayer:GetAttributeChangedSignal( "ModsAchat" ):Connect( function()
    if Flag then
        task.spawn( function()
            local InvokeServer = Remotes.GetMods.InvokeServer
            local Success, Result = pcall( InvokeServer, Remotes.GetMods )

            if not Success or type( Result ) ~= "table" or not Flag then
                return
            end

            local Value1, FlagInner
            Value1 = nil
            FlagInner = false

            for Key, Value in Result, nil, nil do
                if not SameMods2( Table5[ Key ], Value ) then
                    Table5[ Key ] = Value
                    Table6[ Key ] = table.clone( Value )
                    FlagInner = true
                end
            end
            if FlagInner then
                BuildPreview( )
                SelectCategory( Value3 )
            end
        end )
        return
    end
    return
end )
RunService.Heartbeat:Connect( function()
    if Flag and HeldWeapon( ) ~= Value2 then
        SetOpen( false )
    end
end )

local function EquipFirstWeapon()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Backpack = LocalPlayer:FindFirstChildOfClass( "Backpack" )

    if not Humanoid or not Backpack then
        return false
    end

    local Value1 = nil

    for Key, Value in Backpack:GetChildren( ) do
        local Melee
        local IsA = Value:IsA( "Tool" )

        if IsA then
            local Weapon = Value:GetAttribute( "Weapon" )

            if Weapon then
                Melee = Weapon
            else
                Melee = Value:GetAttribute( "Melee" )
            end
        else
            Melee = IsA
        end
        if Melee and WeaponMods:FindFirstChild( Melee ) and WeaponVisuals:FindFirstChild( Melee ) then
            if not Value1 or ( Value:GetAttribute( "Slot" ) or 99 ) < ( Value1:GetAttribute( "Slot" ) or 99 ) then
                Value1 = Value
            end
        end
    end
    if Value1 then
        Humanoid:EquipTool( Value1 )
        return true
    end
    return false
end

Storage.Flag3 = false
Storage.Flag4 = false
task.spawn( function()
    while true do
        local HumanoidRootPart
        task.wait( 0.2 )
        local Character = LocalPlayer.Character

        if Character then
            HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Character
        end

        local Interactions2
        local Interactions = workspace:FindFirstChild( "Interactions" )
        Interactions2 = if Interactions then Interactions else workspace
        local Pads
        local ArmoryStation = Interactions2:FindFirstChild( "ArmoryStation" )
        local Ranked = workspace:FindFirstChild( "Ranked" )

        if Ranked then
            Pads = workspace.Ranked:FindFirstChild( "Pads" )
        else
            Pads = Ranked
        end

        local Etabli

        if Pads then
            Etabli = Pads:FindFirstChild( "Etabli" )
        else
            Etabli = Pads
        end

        local Pad

        if Etabli then
            Pad = Etabli:FindFirstChild( "Pad" )
        else
            Pad = Etabli
        end
        if Pad and HumanoidRootPart and ( HumanoidRootPart.Position - Pad.Position ).Magnitude < 12 then
            ArmoryStation = Etabli
        end

        local Pad2

        if ArmoryStation then
            Pad2 = ArmoryStation:FindFirstChild( "Pad" )
        else
            Pad2 = ArmoryStation
        end

        local CamPoint

        if ArmoryStation then
            CamPoint = ArmoryStation:FindFirstChild( "CamPoint" )
        else
            CamPoint = ArmoryStation
        end
        if Flag and ClientState.Downed then
            SetOpen( false )
        end

        local Flag2

        if not Pad2 or not HumanoidRootPart or ClientState.Downed then
            Flag2 = false
        else
            local FlagInner
            local Position = HumanoidRootPart.Position - Pad2.Position
            local X = Position.X

            if Vector3.new( X, 0, Position.Z ).Magnitude < ( tonumber( ArmoryStation:GetAttribute( "PadRadius" ) ) or 3 ) then
                if math.abs( Position.Y ) < 6 then
                    FlagInner = true
                else
                    FlagInner = false
                end
            else
                FlagInner = false
            end
            if FlagInner then
                FlagInner = not Players.LocalPlayer:GetAttribute( "InTutorial" )
            end

            Flag2 = FlagInner
        end
        if Flag2 then
            if not Flag and not Storage.Flag3 and CamPoint and not ClientState.CursorFree and not ClientState.FixedCamera then
                if HeldWeapon( ) then
                    Storage.Flag3 = true
                    SetOpen( true, CamPoint.CFrame )
                elseif not Storage.Flag4 then
                    Storage.Flag4 = true
                    Number9 = Number9 + 1
                    require( ReplicatedStorage:WaitForChild( "Notify" ) ).Error( "Hold a weapon first" )
                end
            end
        else
            Storage.Flag3 = false
            Storage.Flag4 = false
        end
    end
end )
