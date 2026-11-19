-- StarterPlayer.StarterPlayerScripts.WardrobeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Storage = { }
local Value1
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local AvatarEditorService = game:GetService( "AvatarEditorService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Wardrobe = ReplicatedStorage:WaitForChild( "Wardrobe" )
local WardrobeCatalog = require( ReplicatedStorage:WaitForChild( "WardrobeCatalog" ) )
local LocalPlayer = Players.LocalPlayer
local LimitedPacks = require( ReplicatedStorage:WaitForChild( "LimitedPacks" ) )
local RobuxShopUI = require( ReplicatedStorage:WaitForChild( "RobuxShopUI" ) )

local function SkinOwnedMe( Argument1 )
    local Skin2

    if Argument1 == nil then
        Skin2 = nil
    else
        local Skin = Argument1.skin

        if Skin then
            Skin2 = Skin
        else
            local BodySkin = Argument1.bodySkin

            if BodySkin then
                Skin2 = BodySkin
            else
                Skin2 = nil
            end
        end
    end

    local Flag

    if Skin2 == nil then
        Flag = false
    elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin2 ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function SkinShown( Argument1 )
    local Skin2

    if Argument1 == nil then
        Skin2 = nil
    else
        local Skin = Argument1.skin

        if Skin then
            Skin2 = Skin
        else
            local BodySkin = Argument1.bodySkin

            if BodySkin then
                Skin2 = BodySkin
            else
                Skin2 = nil
            end
        end
    end

    local Flag

    if Skin2 == nil then
        Flag = false
    elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin2 ) == true then
        Flag = true
    else
        Flag = false
    end
    if not Flag then
        if Argument1 == nil or Argument1.pack == nil then
            if Argument1 == nil or Argument1.rank == nil then
                if Argument1 == nil then
                    Flag = false
                elseif Argument1.users == nil then
                    if Argument1.devs == true then
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
            local Active = LimitedPacks.Active( Argument1.pack )

            if Active then
                Flag = Active
            elseif Argument1 == nil or Argument1.rank == nil then
                if Argument1 == nil then
                    Flag = false
                elseif Argument1.users == nil then
                    if Argument1.devs == true then
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
        end
    end

    return Flag
end

local Callback = nil
local Number = -math.huge

local function FetchPrivate()
    local Private
    local Wardrobe = ReplicatedStorage:WaitForChild( "Wardrobe", 30 )

    if Wardrobe then
        Private = Wardrobe:WaitForChild( "Private", 30 )
    else
        Private = Wardrobe
    end
    if not Private then
        return
    end

    local Clock = 5.2 - ( os.clock( ) - Number )

    if Clock > 0 then
        task.wait( Clock )
    end

    Number = os.clock( )
    local Success, Result = pcall( Private.InvokeServer, Private )

    if Success and type( Result ) == "table" then
        WardrobeCatalog.AddPrivate( Result )

        if Callback then
            Callback( )
        end
    end
end

task.spawn( FetchPrivate )
LocalPlayer:GetAttributeChangedSignal( "ReaperTier" ):Connect( function()
    task.spawn( FetchPrivate )
end )
LocalPlayer:GetAttributeChangedSignal( "RankOutfitsRev" ):Connect( function()
    task.spawn( FetchPrivate )
end )

local function IsAdminMe()
    local Flag
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui == nil then
        Flag = false
    elseif PlayerGui:GetAttribute( "IsDev" ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function IsAdminRoleMe()
    local Flag
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui == nil then
        Flag = false
    elseif PlayerGui:GetAttribute( "IsAdmin" ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function IsCreatorMe()
    local Flag
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui == nil then
        Flag = false
    elseif PlayerGui:GetAttribute( "IsContentCreator" ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local Table = { { name = "Corps", bodies = true, group = 0 } }
local Table2 = { }
local Table3 = { }
local Categories = WardrobeCatalog.Categories
Value1 = nil

for Key, Value in Categories, nil, nil do
    Table2[ Value.name ] = Value
end
local Groups = WardrobeCatalog.Groups
Storage.Groups2 = if Groups then Groups else { }
local Value2 = nil

for Key2, Value3 in Storage.Groups2, nil, nil do
    Storage.Value35 = nil

    for Key11, Value36 in Value3, nil, nil do
        Storage.Entry5 = Table2[ Value36 ]

        if Storage.Entry5 and not Table3[ Value36 ] then
            Table3[ Value36 ] = true
            table.insert( Table, {
                name = Storage.Entry5.name,
                items = Storage.Entry5.items,
                group = Key2
            } )
        end
    end
end

local Value4
local Categories2 = WardrobeCatalog.Categories
Value4 = nil

for Key3, Value5 in Categories2, nil, nil do
    if not Table3[ Value5.name ] then
        table.insert( Table, { name = Value5.name, items = Value5.items, group = 99 } )
    end
end

game:GetService( "TweenService" )
local RunService = game:GetService( "RunService" )
local Table4 = {
    bg = Color3.fromRGB( 18, 18, 22 ),
    panel = Color3.fromRGB( 28, 28, 34 ),
    card = Color3.fromRGB( 38, 38, 46 ),
    accent = Color3.fromRGB( 255, 170, 60 ),
    text = Color3.fromRGB( 235, 235, 240 ),
    dim = Color3.fromRGB( 150, 150, 160 ),
    equipped = Color3.fromRGB( 80, 220, 120 ),
    edge = Color3.fromRGB( 14, 14, 18 ),
    cardTop = Color3.fromRGB( 112, 116, 125 ),
    cardBottom = Color3.fromRGB( 50, 53, 60 ),
    finish = Color3.fromRGB( 70, 200, 40 ),
    cancel = Color3.fromRGB( 200, 55, 55 ),
    dev = Color3.fromRGB( 215, 40, 40 ),
    eventTop = Color3.fromRGB( 128, 76, 214 ),
    eventBottom = Color3.fromRGB( 46, 22, 86 )
}
local Table5 = { }
local Value6 = nil
local Table6 = { }
local Table7 = { }
local Item = Table[ 2 ]
local Table8 = { }
local Text = ""

local function IsEquipped( Argument1 )
    local Flag = table.find( Table5, Argument1 ) ~= nil and true or false
    return Flag
end

local function MyLevel()
    return tonumber( LocalPlayer:GetAttribute( "Level" ) ) or 1
end

local function LockedLevel( Argument1 )
    local Flag
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui == nil then
        Flag = false
    elseif PlayerGui:GetAttribute( "IsDev" ) == true then
        Flag = true
    else
        Flag = false
    end
    if Flag then
        return nil
    end
    local LockedLevel = WardrobeCatalog.LockedLevel
    return LockedLevel( Argument1, tonumber( LocalPlayer:GetAttribute( "Level" ) ) or 1 )
end

local function SetLockOrder( Self, Amount )
    local Result2

    if Amount then
        local Result = 50000 + Amount * 200

        if Result then
            Result2 = Result
        else
            Result2 = 0
        end
    else
        Result2 = 0
    end

    local Result3
    Self.LayoutOrder = Self.LayoutOrder + ( Result2 - ( Self:GetAttribute( "LockOffset" ) or 0 ) )
    Result3 = if Result2 == 0 or not Result2 then nil else Result2
    Self:SetAttribute( "LockOffset", Result3 )
end

local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
local Get = Screens.Get( "Wardrobe" )
Get.Visible = false
local Main = Get:WaitForChild( "Main" )
local CategoryTitle = Main:WaitForChild( "CategoryTitle" )
local Parent = Main:WaitForChild( "Categories" )
local Table9 = { }
local Grid = Main:WaitForChild( "Grid" )
local Clone = Grid:WaitForChild( "ItemCard" ):Clone( )

local function IsCard( Self )
    local IsA2
    local IsA = Self:IsA( "GuiButton" )

    if IsA then
        if Self.Name == "InvisPadding" then
            IsA2 = false
        else
            IsA2 = true
        end
    else
        IsA2 = IsA
    end

    return IsA2
end

for Key4, Value7 in Grid:GetChildren( ) do
    Storage.IsA = Value7:IsA( "GuiButton" )

    if Storage.IsA then
        if Value7.Name == "InvisPadding" then
            Storage.IsA2 = false
        else
            Storage.IsA2 = true
        end
    else
        Storage.IsA2 = Storage.IsA
    end
    if Storage.IsA2 then
        Value7:Destroy( )
    end
end

local EquippedRow
local Status = Main:WaitForChild( "Status" )
local UIPadding = Grid:FindFirstChildWhichIsA( "UIPadding" )

local function FitGridPadding()
    local TopBottomOfWindow

    if UIPadding then
        TopBottomOfWindow = UIPadding:GetAttribute( "TopBottomOfWindow" )
    else
        TopBottomOfWindow = UIPadding
    end

    local Y = Grid.AbsoluteCanvasSize.Y

    if not TopBottomOfWindow or Y <= 0 then
        return
    end

    local Captured = TopBottomOfWindow * Grid.AbsoluteWindowSize.Y / Y

    if math.abs( UIPadding.PaddingTop.Scale - Captured ) > 0.0001 then
        UIPadding.PaddingTop = UDim.new( Captured, 0 )
        UIPadding.PaddingBottom = UDim.new( Captured, 0 )
    end
end

Grid:GetPropertyChangedSignal( "AbsoluteCanvasSize" ):Connect( FitGridPadding )
Grid:GetPropertyChangedSignal( "AbsoluteWindowSize" ):Connect( FitGridPadding )
task.defer( FitGridPadding )

local function TextOf( Object )
    return Object:FindFirstChild( "Text" ) or Object
end

local AnnulerButton = Main:WaitForChild( "AnnulerButton" )
local SauvegarderButton = Main:WaitForChild( "SauvegarderButton" )
local TweenService = game:GetService( "TweenService" )

local function BrightOnHover( Self )
    local Table = { }

    for Key, Value in Self:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            Table[ Value ] = Value.Color
        end
    end

    local NumberValue = Instance.new( "NumberValue" )
    NumberValue.Changed:Connect( function( Amount )
        local Value1 = nil

        for Key, Value in Table, nil, nil do
            local Value2
            local TableInner = { }
            local Keypoints = Value.Keypoints
            Value2 = nil

            for Key2, Value3 in Keypoints, nil, nil do
                local ToHSV, ToHSV2, ToHSV3 = Value3.Value:ToHSV( )
                local Result = 0.45 * Amount * ( 0.25 + 0.75 * ToHSV2 )
                table.insert( TableInner, ColorSequenceKeypoint.new( Value3.Time, Color3.fromHSV( ToHSV, ToHSV2, ( math.min( 1, ToHSV3 + ( 1 - ToHSV3 ) * Result ) ) ) ) )
            end

            Key.Color = ColorSequence.new( TableInner )
        end
    end )

    local function To( Argument1 )
        TweenService:Create( NumberValue, TweenInfo.new( 0.12, Enum.EasingStyle.Quad ), { Value = Argument1 } ):Play( )
    end

    Self.MouseEnter:Connect( function()
        To( 1 )
    end )
    Self.MouseLeave:Connect( function()
        To( 0 )
    end )
    Self.SelectionGained:Connect( function()
        To( 1 )
    end )
    Self.SelectionLost:Connect( function()
        To( 0 )
    end )
end

BrightOnHover( AnnulerButton )
BrightOnHover( SauvegarderButton )
local Flag = false
local Text2 = ( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text
local DoneText = SauvegarderButton:GetAttribute( "DoneText" ) or "Done"

local function SetSaved( Saved )
    local Text2Inner
    Flag = Saved
    local Text = SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton
    Text2Inner = Saved and DoneText or Text2
    Text.Text = Text2Inner
end

local function MarkDirty()
    if Flag then
        Flag = false
        ;( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text = Text2
    end
end

local Table10 = { items = { }, slot = 1 }
local Equipped = Main:WaitForChild( "Equipped" )
local EquippedTitle = Equipped:WaitForChild( "EquippedTitle" )
local EquippedList = Equipped:FindFirstChild( "EquippedList" )

if EquippedList then
    EquippedRow = EquippedList:FindFirstChild( "EquippedRow" )
else
    EquippedRow = EquippedList
end

local EquippedList2 = if EquippedRow then EquippedRow:Clone( ) else EquippedRow

if EquippedList then
    for Key5, Value8 in EquippedList:GetChildren( ) do
        if Value8:IsA( "Frame" ) then
            Value8:Destroy( )
        end
    end
end

local Buy
local Text3 = EquippedTitle.Text
local Number2 = 1
local Table11 = { }
local Table12 = { }
Table12[ 1 ] = Equipped:WaitForChild( "Slot" .. 1 )
Table12[ 2 ] = Equipped:WaitForChild( "Slot" .. 2 )
Table12[ 3 ] = Equipped:WaitForChild( "Slot" .. 3 )
local ClearButton = Equipped:WaitForChild( "ClearButton" )

local function SetStatus( StatusName )
    Status.Text = StatusName or ""
end

local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local BuyPanel = Main:FindFirstChild( "BuyPanel" )

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
local GiftPicker = Get:FindFirstChild( "GiftPicker" )

if GiftPicker then
    Picker = RobuxShopUI.Picker( GiftPicker, "WardrobeGift" )
else
    Picker = GiftPicker
end
if BuyPanel then
    BuyPanel.Visible = false
end

local Value9 = nil

local function SkinBuyName( Argument1 )
    local Text
    local PackOf = LimitedPacks.PackOf
    local _, PackOf2 = PackOf( "BodySkin", Argument1.bodySkin )

    if not PackOf2 or not PackOf2.Name then
        Text = tostring( Argument1.bodySkin )
    else
        Text = PackOf2.Name
    end

    return Text
end

local function RefreshSkinBuy()
    if not BuyPanel then
        return
    end

    local Active

    if Value9 == nil then
        Active = false
    else
        local Visible = Get.Visible

        if Visible then
            if Value9.product == nil then
                Active = false
            elseif Value9.pack == nil then
                Active = true
            else
                Active = LimitedPacks.Active( Value9.pack )
            end
        else
            Active = Visible
        end
    end

    local Visible2 = Active == true and true or false
    BuyPanel.Visible = Visible2

    if not Active then
        return
    end

    local Title = BuyPanel:FindFirstChild( "Title" )

    if Title and Title:IsA( "TextLabel" ) then
        local Text
        local PackOf = LimitedPacks.PackOf
        local _, PackOf2 = PackOf( "BodySkin", Value9.bodySkin )

        if not PackOf2 or not PackOf2.Name then
            Text = tostring( Value9.bodySkin )
        else
            Text = PackOf2.Name
        end

        Title.Text = Text
    end
    if Buy then
        local Skin2

        if Value9 == nil then
            Skin2 = nil
        else
            local Skin = Value9.skin

            if Skin then
                Skin2 = Skin
            else
                local BodySkin = Value9.bodySkin

                if BodySkin then
                    Skin2 = BodySkin
                else
                    Skin2 = nil
                end
            end
        end

        local Flag

        if Skin2 == nil then
            Flag = false
        elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin2 ) == true then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            RobuxShopUI.SetBuy( Buy, "equipped", "OWNED" )
            return
        end
        if RobuxShopUI.Pending( Value9.product ) then
            RobuxShopUI.SetBuy( Buy, "wait", "..." )
            return
        end

        local SetBuy = RobuxShopUI.SetBuy
        SetBuy( Buy, "buy", RobuxShopUI.PriceText( Value9.product, RefreshSkinBuy ) )
    end
end

local function ShowSkinBuy( Buy )
    local Value1 = Buy and Buy.bodySkin and Buy.product and Buy or nil
    Value9 = Value1
    RefreshSkinBuy( )
end

if Buy then
    Buy.Activated:Connect( function()
        if Value9 then
            local Skin2

            if Value9 == nil then
                Skin2 = nil
            else
                local Skin = Value9.skin

                if Skin then
                    Skin2 = Skin
                else
                    local BodySkin = Value9.bodySkin

                    if BodySkin then
                        Skin2 = BodySkin
                    else
                        Skin2 = nil
                    end
                end
            end

            local Flag

            if Skin2 == nil then
                Flag = false
            elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin2 ) == true then
                Flag = true
            else
                Flag = false
            end
            if not Flag and not RobuxShopUI.Pending( Value9.product ) then
                if not Value9.pack or LimitedPacks.Active( Value9.pack ) then
                    task.spawn( function()
                        local Buy = RobuxShopUI.Buy
                        Buy( "BodySkin", Value9.bodySkin )
                        RefreshSkinBuy( )
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
        if Value9.pack and not LimitedPacks.Active( Value9.pack ) then
            Notify.Error( "This limited offer has ended" )
            return
        end

        local Text
        local Table = { }
        local PackOf = LimitedPacks.PackOf
        local _, PackOf2 = PackOf( "BodySkin", Value9.bodySkin )

        if not PackOf2 or not PackOf2.Name then
            Text = tostring( Value9.bodySkin )
        else
            Text = PackOf2.Name
        end

        Table.title = "GIFT THE " .. string.upper( Text )
        function Table.onSend( Argument1, Argument2 )
            local Gift = RobuxShopUI.Gift
            Gift( "BodySkin", Value9.bodySkin, Argument1, Argument2 )
        end
        Picker:Open( Table )
        local OpenScale = GiftPicker:FindFirstChild( "OpenScale" )

        if OpenScale and OpenScale:IsA( "UIScale" ) then
            OpenScale.Scale = 0.92
            TweenService:Create( OpenScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end
    end )
end

local List
RobuxShopUI.Changed:Connect( RefreshSkinBuy )
Get:GetPropertyChangedSignal( "Visible" ):Connect( function()
    if not Get.Visible then
        if Picker then
            Picker:Close( )
        end

        Value9 = nil
    end

    RefreshSkinBuy( )
end )

local function RefreshSlots()
    local Value1 = nil

    for Key, Value in Table12, nil, nil do
        local Flag = Key == Number2 and true or false
        local BackgroundColor3

        if Flag then
            local Accent = Table4.accent

            if Accent then
                BackgroundColor3 = Accent
            else
                BackgroundColor3 = Table4.card
            end
        else
            BackgroundColor3 = Table4.card
        end

        local TextColor3
        Value.BackgroundColor3 = BackgroundColor3
        local Text = Value:FindFirstChild( "Text" ) or Value

        if Flag then
            local Color32 = Color3.new( 0, 0, 0 )

            if Color32 then
                TextColor3 = Color32
            elseif Table11[ Key ] then
                local Text2 = Table4.text

                if Text2 then
                    TextColor3 = Text2
                else
                    TextColor3 = Table4.dim
                end
            else
                TextColor3 = Table4.dim
            end
        elseif Table11[ Key ] then
            local Text2 = Table4.text

            if Text2 then
                TextColor3 = Text2
            else
                TextColor3 = Table4.dim
            end
        else
            TextColor3 = Table4.dim
        end

        Text.TextColor3 = TextColor3
    end
end

local function FetchName( Key, Label )
    if not Table6[ Key ] and WardrobeCatalog.Items[ Key ] then
        Table6[ Key ] = WardrobeCatalog.Items[ Key ].name
    end
    if not Table6[ Key ] then
        task.spawn( function()
            local Name
            local Success, Result = pcall( AvatarEditorService.GetItemDetailsAsync, AvatarEditorService, Key, Enum.AvatarItemType.Asset )
            Name = Success and Result and Result.Name or "Article " .. Key
            Table6[ Key ] = Name

            if Label and Label.Parent then
                Label.Text = Table6[ Key ]
            end
        end )
        return
    end
    if Label then
        Label.Text = Table6[ Key ]
    end
end

local RefreshEquipped = nil

local function StyleCard( Self, Argument2 )
    local Value1

    for Key, Value in Self:GetChildren( ) do
        if Value:IsA( "UIStroke" ) then
            if Value.Name ~= "DevOutline" then
                Value1 = Value
                break
            end
        end

        Value1 = nil
    end

    local Flag

    if Self:GetAttribute( "Body" ) then
        if Value6 == Argument2 then
            Flag = true
        else
            Flag = false
        end
    elseif table.find( Table5, Argument2 ) == nil then
        Flag = false
    else
        Flag = true
    end

    local Color

    if Flag then
        local Equipped = Table4.equipped

        if Equipped then
            Color = Equipped
        else
            Color = Table4.edge
        end
    else
        Color = Table4.edge
    end

    local NotBody2
    Value1.Color = Color
    local NotBody = not Self:GetAttribute( "Body" )

    if NotBody then
        local NotFlag = not Flag

        if NotFlag then
            if WardrobeCatalog.BlockedBy( Table5, Argument2 ) == nil then
                NotBody2 = false
            else
                NotBody2 = true
            end
        else
            NotBody2 = NotFlag
        end
    else
        NotBody2 = NotBody
    end

    local BackgroundTransparency = not NotBody2 and 0 or 0.6
    Self.BackgroundTransparency = BackgroundTransparency
    local Thumb = Self:FindFirstChild( "Thumb" )
    local Model3D = Self:FindFirstChild( "Model3D" )

    if Thumb then
        local ImageTransparency = not NotBody2 and 0 or 0.65
        Thumb.ImageTransparency = ImageTransparency
    end
    if Model3D then
        local ImageTransparency2 = not NotBody2 and 0 or 0.65
        Model3D.ImageTransparency = ImageTransparency2
    end
end

local Flag2 = false
local Value10 = nil
local Value11 = nil

local function ShowChar()
    if Value10 then
        Value10:Disconnect( )
        Value10 = nil
    end

    local Character = LocalPlayer.Character

    if Character then
        for Key, Value in Character:GetDescendants( ) do
            if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
                Value.LocalTransparencyModifier = 0
            end
        end
    end
end

local function HideUntilFitted()
    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    local CostumeFitAt = Character:GetAttribute( "CostumeFitAt" )
    Value11 = os.clock( ) + 4

    if Value10 then
        Value10:Disconnect( )
    end

    Value10 = RunService.RenderStepped:Connect( function()
        if Value11 < os.clock( ) or LocalPlayer.Character ~= Character or Character:GetAttribute( "CostumeFitAt" ) ~= CostumeFitAt then
            ShowChar( )
            return
        end
        for Key, Value in Character:GetDescendants( ) do
            if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
                Value.LocalTransparencyModifier = 1
            end
        end
    end )
end

local function NeedsFit( List )
    local Value1 = nil

    for Key, Value in List, nil, nil do
        local Entry = WardrobeCatalog.Items[ Value ]

        if Entry and Entry.family then
            if Entry.body then
                return true
            end
        end
    end

    return false
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

local function PushOutfit()
    if Flag2 then
        return
    end
    Flag2 = true
    task.delay( 0.05, function()
        -- Could not structure function #42
    end )
    return
end

local function Toggle( Key )
    local Entry2
    local Entry = WardrobeCatalog.Items[ Key ]
    Entry2 = Entry and Entry.bodySkin and Entry.product and Entry or nil
    Value9 = Entry2
    RefreshSkinBuy( )
    local Find = table.find( Table5, Key )

    if Find then
        local Entry4
        local Clone = table.clone( Table5 )
        table.remove( Clone, Find )
        local MissingRequired = WardrobeCatalog.MissingRequired( Clone )
        local Entry3 = WardrobeCatalog.Items[ Key ]

        if Entry3 then
            if Entry3.category == "Mods" then
                Entry4 = true
            elseif Entry3.category == "Event" then
                Entry4 = true
            elseif Entry3.category == "Skins" then
                Entry4 = true
            elseif Entry3.category == "Ensemble haut" then
                Entry4 = true
            elseif Entry3.category == "Ensemble bas" then
                Entry4 = true
            elseif Entry3.category == "Ensemble tête" then
                Entry4 = true
            else
                Entry4 = false
            end
        else
            Entry4 = Entry3
        end
        if MissingRequired and Entry3 and not Entry4 and table.find( MissingRequired.cats, Entry3.category ) and not WardrobeCatalog.MissingRequired( Table5 ) then
            Status.Text = "You need at least one " .. MissingRequired.label .. " (pick another one to replace it)" or ""
            return
        end

        table.remove( Table5, Find )
    else
        local Entry5 = WardrobeCatalog.Items[ Key ]

        if Entry5 and Entry5.bodySkin then
            local Skin2

            if Entry5 == nil then
                Skin2 = nil
            else
                local Skin = Entry5.skin

                if Skin then
                    Skin2 = Skin
                else
                    local BodySkin = Entry5.bodySkin

                    if BodySkin then
                        Skin2 = BodySkin
                    else
                        Skin2 = nil
                    end
                end
            end

            local FlagInner

            if Skin2 == nil then
                FlagInner = false
            elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin2 ) == true then
                FlagInner = true
            else
                FlagInner = false
            end
            if not FlagInner then
                if not Entry5.pack or LimitedPacks.Active( Entry5.pack ) then
                    Status.Text = "Buy or gift it on the right, or get the Bubble Pack in the Shop"
                    return
                end
                Status.Text = "This limited offer has ended"
                return
            end
        end
        if Entry5 and Entry5.skin then
            local Skin4

            if Entry5 == nil then
                Skin4 = nil
            else
                local Skin3 = Entry5.skin

                if Skin3 then
                    Skin4 = Skin3
                else
                    local BodySkin2 = Entry5.bodySkin

                    if BodySkin2 then
                        Skin4 = BodySkin2
                    else
                        Skin4 = nil
                    end
                end
            end

            local Flag2Inner

            if Skin4 == nil then
                Flag2Inner = false
            elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin4 ) == true then
                Flag2Inner = true
            else
                Flag2Inner = false
            end
            if not Flag2Inner then
                if not Entry5.pack or LimitedPacks.Active( Entry5.pack ) then
                    Status.Text = "Unlock the " .. tostring( Entry5.name ) .. " skin" or ""
                    local Buy = RobuxShopUI.Buy
                    task.spawn( Buy, "BodySkin", Entry5.skin )
                    return
                end
                Status.Text = "This limited offer has ended"
                return
            end
        end

        local Flag3
        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

        if PlayerGui == nil then
            Flag3 = false
        elseif PlayerGui:GetAttribute( "IsDev" ) == true then
            Flag3 = true
        else
            Flag3 = false
        end

        local LockedLevel2

        if Flag3 then
            LockedLevel2 = nil
        else
            local LockedLevel = WardrobeCatalog.LockedLevel
            LockedLevel2 = LockedLevel( Key, tonumber( LocalPlayer:GetAttribute( "Level" ) ) or 1 )
        end
        if LockedLevel2 then
            Status.Text = "Unlocks at level " .. LockedLevel2 or ""
            return
        end

        local BlockedBy = WardrobeCatalog.BlockedBy( Table5, Key )

        if BlockedBy then
            Status.Text = "Not allowed with " .. WardrobeCatalog.Label( BlockedBy ):lower( ) .. " (remove it first)" or ""
            return
        end

        table.insert( Table5, Key )
        local Count = #Table5
        Table5 = WardrobeCatalog.Clean( Table5 )

        if #Table5 < Count then
            local Entry7
            local Entry6 = WardrobeCatalog.Items[ Key ]
            local RuleText = WardrobeCatalog.RuleText

            if Entry6 then
                local Slot = Entry6.slot

                if Slot then
                    Entry7 = Slot
                else
                    Entry7 = Entry6.category
                end
            else
                Entry7 = Entry6
            end

            Status.Text = RuleText( Entry7 ) or "Incompatible pieces removed" or ""
        end
    end
    if Flag then
        Flag = false
        ;( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text = Text2
    end

    RefreshEquipped( )

    if Flag2 then
        return
    end
    Flag2 = true
    task.delay( 0.05, function()
        -- Could not structure function #42
    end )
    return
end

local Callback2 = nil

RefreshEquipped = function()
    if Callback2 then
        Callback2( )
    end
    if EquippedList and EquippedList2 then
        for Key, Value in EquippedList:GetChildren( ) do
            if Value:IsA( "Frame" ) then
                Value:Destroy( )
            end
        end

        local Value1 = nil

        for Key2, Value2 in Table5, nil, nil do
            local Clone = EquippedList2:Clone( )
            Clone.Visible = true
            Clone.Parent = EquippedList
            local Label = Clone:WaitForChild( "Label" )
            Label.Text = Table6[ Value2 ] or "..."
            FetchName( Value2, Label )
            Clone:WaitForChild( "Remove" ).Activated:Connect( function()
                Toggle( Value2 )
            end )
        end
    end

    local Text
    local Gsub, Gsub2 = Text3:gsub( "%(%d+%)", "(" .. #Table5 .. ")" )
    Text = Gsub2 > 0 and Gsub or Text3 .. " (" .. #Table5 .. ")"
    local Value3
    EquippedTitle.Text = Text
    Value3 = nil

    for Key3, Value4 in Table8, nil, nil do
        StyleCard( Value4, Key3 )
    end
end

local function Pose( Argument1, Argument2 )
    local Part = Argument1.part
    Part.CFrame = CFrame.Angles( 0, Argument2, 0 ) * Argument1.worn
end

local Table13 = { }
local Value12 = nil

local function AttachModel( ModelName, ModelName2 )
    local FoundChild

    if Value12 then
        FoundChild = Value12:FindFirstChild( ( tostring( ModelName ) ) )
    else
        FoundChild = Value12
    end

    local Parent = ModelName2:FindFirstChild( "Model3D" )

    if not FoundChild or not Parent or Table13[ ModelName2 ] then
        return
    end

    local Size2
    local Clone = FoundChild:Clone( )
    Clone.CFrame = CFrame.new( )
    Clone.Parent = Parent
    local Size = Clone.Size
    local SpecialMesh = Clone:FindFirstChildWhichIsA( "SpecialMesh" )
    Size2 = if SpecialMesh then Size * SpecialMesh.Scale else Size
    local Inverse
    local Max = math.max( Size2.Magnitude / 2, 0.1 )
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 30
    local Max2 = Max / math.sin( ( math.rad( CurrentCamera.FieldOfView / 2 ) ) ) * 0.95
    CurrentCamera.CFrame = CFrame.lookAt( Vector3.new( 0, Max * 0.2, Max2 ), Vector3.new( 0, 0, 0 ) )
    CurrentCamera.Parent = Parent
    Parent.CurrentCamera = CurrentCamera
    Parent.Visible = true
    ModelName2.Thumb.Visible = false
    local WornRot = FoundChild:GetAttribute( "WornRot" )
    Inverse = typeof( WornRot ) == "CFrame" and WornRot:Inverse( ) or CFrame.identity
    local Inverse2
    local Entry = WardrobeCatalog.Items[ ModelName ]
    Inverse2 = if not Entry or not Entry.view then Inverse else CFrame.Angles( 0, math.rad( Entry.view ), 0 ) * Inverse
    local Table = { part = Clone, angle = 3.490658503988659, worn = Inverse2 }
    Table13[ ModelName2 ] = Table
    local Part = Table.part
    Part.CFrame = CFrame.Angles( 0, 3.490658503988659, 0 ) * Table.worn
end

task.spawn( function()
    local Value1
    Value12 = ReplicatedStorage:WaitForChild( "WardrobeModels" )
    Value12.ChildAdded:Connect( function( Argument1 )
        local Number2
        local Number = tonumber( Argument1.Name )
        Number2 = if Number then Table8[ Number ] else Number

        if Number2 then
            AttachModel( Number, Number2 )
        end
    end )
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        AttachModel( Key, Value )
    end
end )
RunService.RenderStepped:Connect( function( Amount )
    if not Get.Visible then
        return
    end

    local Value1 = nil

    for Key, Value in Table13, nil, nil do
        if Key.Parent then
            if Key:GetAttribute( "Hover" ) then
                Value.angle = ( Value.angle + Amount * 1.7453292519943295 ) % 6.283185307179586
            else
                local Angle = ( 3.490658503988659 - Value.angle + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793

                if math.abs( Angle ) < 0.002 then
                    if Value.angle == 3.490658503988659 then
                        continue
                    end

                    Value.angle = 3.490658503988659
                    local Part = Value.part
                    Part.CFrame = CFrame.Angles( 0, 3.490658503988659, 0 ) * Value.worn
                    continue
                end
                Value.angle = Value.angle + Angle * ( 1 - math.exp( -8 * Amount ) )
            end

            local Angle2 = Value.angle
            local Part2 = Value.part
            Part2.CFrame = CFrame.Angles( 0, Angle2, 0 ) * Value.worn
        else
            Table13[ Key ] = nil
        end
    end
end )
local TweenInfo2 = TweenInfo.new( 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
local Value13 = nil

local function NewCard( Image, Argument2 )
    local CloneInner = Clone:Clone( )
    CloneInner.Name = "ItemCard"
    CloneInner.Visible = true
    CloneInner.LayoutOrder = #Grid:GetChildren( )
    local UIScale = CloneInner:FindFirstChildOfClass( "UIScale" )
    CloneInner:WaitForChild( "Thumb" ).Image = Image
    GamepadNav.Hover( CloneInner, function()
        Value13 = CloneInner
        CloneInner:SetAttribute( "Hover", true )
        TweenService:Create( UIScale, TweenInfo2, { Scale = 1.05 } ):Play( )
        Status.Text = Argument2( ) or "" or ""
    end, function()
        CloneInner:SetAttribute( "Hover", nil )
        TweenService:Create( UIScale, TweenInfo2, { Scale = 1 } ):Play( )

        if Value13 == CloneInner then
            Value13 = nil
            Status.Text = Text or ""
        end
    end )
    CloneInner.Parent = Grid
    return CloneInner
end

local function UpdateSkinLock( Object, LockName )
    local Entry = WardrobeCatalog.Items[ LockName ]
    local BuyLock = Object:FindFirstChild( "BuyLock" )

    if Entry then
        if Entry.skin or Entry.bodySkin then
            if BuyLock then
                local Skin2

                if Entry == nil then
                    Skin2 = nil
                else
                    local Skin = Entry.skin

                    if Skin then
                        Skin2 = Skin
                    else
                        local BodySkin = Entry.bodySkin

                        if BodySkin then
                            Skin2 = BodySkin
                        else
                            Skin2 = nil
                        end
                    end
                end

                local Flag

                if Skin2 == nil then
                    Flag = false
                elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin2 ) == true then
                    Flag = true
                else
                    Flag = false
                end

                local Visible = not Flag
                BuyLock.Visible = Visible
                local PriceText = BuyLock:FindFirstChild( "PriceText", true )

                if Visible and PriceText and PriceText:IsA( "TextLabel" ) and Entry.product then
                    PriceText.Text = RobuxShopUI.PriceText( Entry.product, function()
                        if Object.Parent then
                            UpdateSkinLock( Object, LockName )
                        end
                    end )
                end

                return
            end
        end
    end
end

local function AddCard( p1, p2 )
    -- Could not structure function #59
end

local Table14 = { }

local function AddBodyCard( CardName )
    local Card = NewCard( ( "rbxthumb://type=BundleThumbnail&id=%d&w=420&h=420" ):format( CardName ), function()
        return Table7[ CardName ]
    end )
    Card:SetAttribute( "Body", true )

    if not Table7[ CardName ] then
        task.spawn( function()
            local Text
            local Success, Result = pcall( AvatarEditorService.GetItemDetailsAsync, AvatarEditorService, CardName, Enum.AvatarItemType.Bundle )

            if Table14[ CardName ] == "Female" then
                Text = "Female"
            elseif Table14[ CardName ] == "Male" then
                Text = "Male"
            else
                Text = ""
            end

            local Name = Success and Result and Result.Name or "Body " .. CardName
            local Text2
            local Gsub = Name:gsub( "Corps de base %- ", "" )
            Text2 = Text ~= "" and " · " .. Text or ""
            Table7[ CardName ] = Gsub .. Text2
        end )
    end

    Card.Activated:Connect( function()
        Status.Text = "Changing body..."
        local InvokeServer = Wardrobe.SetBody.InvokeServer
        local Success, Result = pcall( InvokeServer, Wardrobe.SetBody, CardName )

        if Success and Result then
            Value6 = Result

            if Flag then
                Flag = false
                ;( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text = Text2
            end
        end

        local Value1
        Status.Text = Text or ""
        Value1 = nil

        for Key, Value in Table8, nil, nil do
            StyleCard( Value, Key )
        end
    end )
    Table8[ CardName ] = Card
    StyleCard( Card, CardName )
end

local function ClearGrid()
    for Key, Value in Grid:GetChildren( ) do
        local IsA2
        local IsA = Value:IsA( "GuiButton" )

        if IsA then
            if Value.Name == "InvisPadding" then
                IsA2 = false
            else
                IsA2 = true
            end
        else
            IsA2 = IsA
        end
        if IsA2 then
            Value:Destroy( )
        end
    end

    table.clear( Table8 )
    table.clear( Table13 )
    Grid.CanvasPosition = Vector2.zero
end

local DoSearch = nil
local Table15 = { }
local Value14 = nil
local StyleBar = Main:FindFirstChild( "StyleBar" )

if StyleBar then
    List = StyleBar:FindFirstChild( "List" )
else
    List = StyleBar
end

local StyleTile

if List then
    StyleTile = List:FindFirstChild( "StyleTile" )
else
    StyleTile = List
end
if StyleTile then
    StyleTile.Parent = nil
end

local UIStroke

if StyleTile then
    UIStroke = StyleTile:FindFirstChildOfClass( "UIStroke" )
else
    UIStroke = StyleTile
end

local Thickness = UIStroke and UIStroke.Thickness or 0.0133
local TankToggle
local Table16 = { }

if List then
    TankToggle = List:FindFirstChild( "TankToggle" )
else
    TankToggle = List
end

local UIStroke2

if TankToggle then
    UIStroke2 = TankToggle:FindFirstChildOfClass( "UIStroke" )
else
    UIStroke2 = TankToggle
end

local Text4

if TankToggle then
    Text4 = TankToggle:FindFirstChild( "Text" )
else
    Text4 = TankToggle
end

local StyleBar3 = if UIStroke2 then UIStroke2.Color else UIStroke2
local StyleBar2 = if Text4 then Text4.TextColor3 else Text4

local function TankOn()
    local Flag = Controls.Settings.DiverTank ~= false and true or false
    return Flag
end

local function PaintTank()
    if not TankToggle then
        return
    end

    local Flag = Controls.Settings.DiverTank ~= false and true or false

    if Text4 then
        local Text = not Flag and "Tank: OFF" or "Tank: ON"
        local TextColor3
        Text4.Text = Text
        TextColor3 = Flag and StyleBar2 or Table4.dim
        Text4.TextColor3 = TextColor3
    end
    if UIStroke2 then
        local Color

        if Flag then
            local Equipped = Table4.equipped

            if Equipped then
                Color = Equipped
            else
                Color = StyleBar3
            end
        else
            Color = StyleBar3
        end

        UIStroke2.Color = Color
    end
end

if TankToggle then
    TankToggle.Visible = false

    if TankToggle then
        local Flag3 = Controls.Settings.DiverTank ~= false and true or false

        if Text4 then
            local Text5 = not Flag3 and "Tank: OFF" or "Tank: ON"
            local TextColor3
            Text4.Text = Text5
            TextColor3 = if not Flag3 or not StyleBar2 then Table4.dim else StyleBar2
            Text4.TextColor3 = TextColor3
        end
        if UIStroke2 then
            local Color = Flag3 and Table4.equipped or StyleBar3
            UIStroke2.Color = Color
        end
    end

    Controls.SettingsChanged:Connect( function( Name )
        if Name == "DiverTank" then
            if not TankToggle then
                return
            end

            local Flag = Controls.Settings.DiverTank ~= false and true or false

            if Text4 then
                local Text = not Flag and "Tank: OFF" or "Tank: ON"
                local TextColor3
                Text4.Text = Text
                TextColor3 = Flag and StyleBar2 or Table4.dim
                Text4.TextColor3 = TextColor3
            end
            if UIStroke2 then
                local Color

                if Flag then
                    local Equipped = Table4.equipped

                    if Equipped then
                        Color = Equipped
                    else
                        Color = StyleBar3
                    end
                else
                    Color = StyleBar3
                end

                UIStroke2.Color = Color
            end
        end
    end )
    local ControlsRemotes = ReplicatedStorage:WaitForChild( "ControlsRemotes" )
    local UIScale = TankToggle:FindFirstChildOfClass( "UIScale" )

    local function TankInfo()
        local Flag = Controls.Settings.DiverTank ~= false and true or false
        local Text = not Flag and "OFF" or "ON"
        return "Oxygen tank: " .. Text
    end

    TankToggle.Activated:Connect( function()
        local Flag
        local Set = Controls.Set
        Flag = Controls.Settings.DiverTank ~= false and true or false
        Set( "DiverTank", not Flag )
        local DiverTank = ControlsRemotes:FindFirstChild( "DiverTank" )

        if DiverTank then
            local Flag2 = Controls.Settings.DiverTank ~= false and true or false
            DiverTank:FireServer( Flag2 )
        end

        local Flag3 = Controls.Settings.DiverTank ~= false and true or false
        local Text = not Flag3 and "OFF" or "ON"
        Status.Text = "Oxygen tank: " .. Text or ""
    end )
    GamepadNav.Hover( TankToggle, function()
        if UIScale then
            TweenService:Create( UIScale, TweenInfo2, { Scale = 1.05 } ):Play( )
        end

        local Flag = Controls.Settings.DiverTank ~= false and true or false
        local Text = not Flag and "OFF" or "ON"
        Status.Text = "Oxygen tank: " .. Text or ""
    end, function()
        if UIScale then
            TweenService:Create( UIScale, TweenInfo2, { Scale = 1 } ):Play( )
        end

        Status.Text = Text or ""
    end )
end

local Value17

local function FamilyCard( CardName )
    local Families2
    local Families = WardrobeCatalog.Families
    Families2 = if Families then WardrobeCatalog.Families[ CardName ] else Families

    if not Families2 then
        return nil
    end

    local Value1
    local Styles = Families2.styles
    Value1 = nil

    for Key, Value in Styles, nil, nil do
        local Flag = table.find( Table5, Value.id ) ~= nil and true or false

        if Flag then
            return Value.id
        end
    end
    if Table15[ CardName ] and WardrobeCatalog.Items[ Table15[ CardName ] ] then
        return Table15[ CardName ]
    end

    local Value2
    local Styles2 = Families2.styles
    Value2 = nil

    for Key2, Value3 in Styles2, nil, nil do
        if WardrobeCatalog.Items[ Value3.id ] then
            return Value3.id
        end
    end

    return nil
end

local function PlaceStyleBar()
    local Captured

    if Value14 then
        Captured = FamilyCard( Value14 )
    else
        Captured = Value14
    end

    local Captured2 = if Captured then Table8[ Captured ] else Captured
    local Y = Main.AbsoluteSize.Y

    if not StyleBar or not Captured2 or not ( Y > 0 ) then
        return
    end

    local Families2
    local Families = WardrobeCatalog.Families
    Families2 = if Families then WardrobeCatalog.Families[ Value14 ] else Families

    if Families2 and Families2.vertical then
        StyleBar.Position = UDim2.fromScale( 1.015, Grid.Position.Y.Scale )
        return
    end

    local X3
    local X = Main.AbsoluteSize.X
    local Y2 = ( Captured2.AbsolutePosition.Y + Captured2.AbsoluteSize.Y - Main.AbsolutePosition.Y ) / Y + 0.015

    if X > 0 then
        local X2 = ( Captured2.AbsolutePosition.X - Main.AbsolutePosition.X ) / X

        if X2 then
            X3 = X2
        else
            X3 = StyleBar.Position.X.Scale
        end
    else
        X3 = StyleBar.Position.X.Scale
    end

    StyleBar.Position = UDim2.fromScale( X3, Y2 )
end

local Value15 = nil
local Value16 = nil

local function SetStyleLayout( Argument1, Text )
    local UIListLayout = List:FindFirstChildOfClass( "UIListLayout" )
    local Title = StyleBar:FindFirstChild( "Title" )
    local Line = StyleBar:FindFirstChild( "Line" )

    if not Value15 then
        local Dir
        local Table = { size = StyleBar.Size, listPos = List.Position, listSize = List.Size }
        Dir = if UIListLayout then UIListLayout.FillDirection else UIListLayout
        local Pad
        Table.dir = Dir
        Pad = if UIListLayout then UIListLayout.Padding else UIListLayout
        local TtlSize
        Table.pad = Pad
        TtlSize = if Title then Title.Size else Title
        local TtlText
        Table.ttlSize = TtlSize
        TtlText = if Title then Title.Text else Title
        local Line2
        Table.ttlText = TtlText
        Line2 = if Line then Line.Visible else Line
        Table.line = Line2
        Value15 = Table
    end
    if Argument1 then
        StyleBar.Size = UDim2.fromScale( 0.13, 0.86 )
        local Position = UDim2.fromScale( 0, 0.06 )
        local Size = UDim2.fromScale( 1, 0.94 )
        List.Position = Position
        List.Size = Size

        if UIListLayout then
            UIListLayout.FillDirection = Enum.FillDirection.Vertical
            UIListLayout.Padding = UDim.new( 0.012, 0 )
        end
        if Title then
            Title.Size = UDim2.fromScale( 1, 0.045 )
            Title.Text = Text or Value15.ttlText
        end
        if Line then
            Line.Visible = false
        end
    else
        local Size2 = Value15.size
        local Position2 = Value15.listPos
        local Size3 = Value15.listSize
        StyleBar.Size = Size2
        List.Position = Position2
        List.Size = Size3

        if UIListLayout then
            UIListLayout.FillDirection = Value15.dir
            UIListLayout.Padding = Value15.pad
        end
        if Title then
            Title.Size = Value15.ttlSize
            Title.Text = Value15.ttlText
        end
        if Line then
            Line.Visible = Value15.line
        end
    end

    Value16 = Argument1
end

local function UpdateStyleBar()
    if not StyleBar or not List or not StyleTile then
        return
    end

    local StyleId
    local SelectedObject = game:GetService( "GuiService" ).SelectedObject

    if SelectedObject then
        local Value1 = nil

        for Key, Value in Table16, nil, nil do
            if SelectedObject ~= Value then
                if not SelectedObject:IsDescendantOf( Value ) then
                    continue
                end
            end

            StyleId = Value:GetAttribute( "StyleId" )
            break
        end
    else
        StyleId = nil
    end

    local Value2 = nil

    for Key2, Value3 in Table16, nil, nil do
        Value3:Destroy( )
    end

    local Captured
    table.clear( Table16 )

    if Value14 then
        local Families = WardrobeCatalog.Families

        if Families then
            Captured = WardrobeCatalog.Families[ Value14 ]
        else
            Captured = Families
        end
    else
        Captured = Value14
    end

    local Styles = Captured and Captured.styles or { }
    local Value4, Flag2
    Value4 = nil

    for Key3, Value5 in Styles, nil, nil do
        local Flag = table.find( Table5, Value5.id ) ~= nil and true or false

        if Flag then
            Flag2 = true
            break
        end

        Flag2 = false
    end

    local Visible

    if Captured == nil then
        Visible = false
    elseif Captured.vertical == true then
        Visible = Flag2
    else
        Visible = true
    end

    local Visible2
    StyleBar.Visible = Visible
    Visible2 = if Value14 == "Diver" then Flag2 else false

    if TankToggle then
        TankToggle.Visible = Visible2

        if Visible2 then
            if TankToggle then
                local Flag3 = Controls.Settings.DiverTank ~= false and true or false

                if Text4 then
                    local TextInner = not Flag3 and "Tank: OFF" or "Tank: ON"
                    local TextColor3
                    Text4.Text = TextInner
                    TextColor3 = Flag3 and StyleBar2 or Table4.dim
                    Text4.TextColor3 = TextColor3
                end
                if UIStroke2 then
                    local Color

                    if Flag3 then
                        local Equipped = Table4.equipped

                        if Equipped then
                            Color = Equipped
                        else
                            Color = StyleBar3
                        end
                    else
                        Color = StyleBar3
                    end

                    UIStroke2.Color = Color
                end
            end
        end
    end
    if not StyleBar.Visible then
        return
    end

    local Flag4 = Captured.vertical == true and true or false
    local Value7
    SetStyleLayout( Flag4, Captured.title )
    local FamilyCard2 = FamilyCard( Value14 )
    local Styles2 = Captured.styles
    Value7 = nil

    for Key4, Value8 in Styles2, nil, nil do
        local Entry = WardrobeCatalog.Items[ Value8.id ]

        if not Value8.hidden or Entry then
            local Flag5

            if Entry == nil then
                Flag5 = false
            elseif Entry.bodySkin == nil then
                Flag5 = true
            else
                local Skin2

                if Entry == nil then
                    Skin2 = nil
                else
                    local Skin = Entry.skin

                    if Skin then
                        Skin2 = Skin
                    else
                        local BodySkin = Entry.bodySkin

                        if BodySkin then
                            Skin2 = BodySkin
                        else
                            Skin2 = nil
                        end
                    end
                end
                if Skin2 == nil then
                    Flag5 = false
                elseif LocalPlayer:GetAttribute( "BodySkin_" .. Skin2 ) == true then
                    Flag5 = true
                else
                    Flag5 = false
                end
            end

            local Flag6 = Value8.id == FamilyCard2 and true or false
            local Clone = StyleTile:Clone( )
            Clone.Name = "Style_" .. Value8.name
            Clone.LayoutOrder = Key4

            if Value16 then
                Clone.Size = UDim2.fromScale( 0.82, 0.14 )
                local UIAspectRatioConstraint = Clone:FindFirstChildOfClass( "UIAspectRatioConstraint" )

                if UIAspectRatioConstraint then
                    UIAspectRatioConstraint.AspectRatio = 1.35
                    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
                end
            end

            local Parent = Clone:FindFirstChild( "Thumb" )

            if Parent then
                local ImageColor3
                Parent.Size = UDim2.fromScale( Parent.Size.X.Scale, Parent.Size.Y.Scale * ( Value8.frame or 1 ) )
                Parent.Image = Value8.image or ""

                if Flag5 then
                    local Color32 = Color3.new( 1, 1, 1 )

                    if Color32 then
                        ImageColor3 = Color32
                    else
                        ImageColor3 = Color3.fromRGB( 70, 66, 80 )
                    end
                else
                    ImageColor3 = Color3.fromRGB( 70, 66, 80 )
                end

                Parent.ImageColor3 = ImageColor3

                if type( Value8.swatch ) == "table" then
                    local BackgroundTransparency
                    Parent.BackgroundColor3 = Color3.fromRGB( Value8.swatch[ 1 ], Value8.swatch[ 2 ], Value8.swatch[ 3 ] )
                    BackgroundTransparency = not Flag5 and 0.65 or 0
                    local UICorner2
                    Parent.BackgroundTransparency = BackgroundTransparency
                    local UICorner = Parent:FindFirstChildOfClass( "UICorner" )

                    if UICorner then
                        UICorner2 = UICorner
                    else
                        UICorner2 = Instance.new( "UICorner" )
                    end

                    local UIAspectRatioConstraint3
                    UICorner2.CornerRadius = UDim.new( 0.5, 0 )
                    UICorner2.Parent = Parent
                    local UIAspectRatioConstraint2 = Parent:FindFirstChildOfClass( "UIAspectRatioConstraint" )
                    UIAspectRatioConstraint3 = if UIAspectRatioConstraint2 then UIAspectRatioConstraint2 else Instance.new( "UIAspectRatioConstraint" )
                    local UIStroke
                    UIAspectRatioConstraint3.Parent = Parent
                    local SwatchEdge = Parent:FindFirstChild( "SwatchEdge" )

                    if SwatchEdge then
                        UIStroke = SwatchEdge
                    else
                        UIStroke = Instance.new( "UIStroke" )
                    end

                    UIStroke.Name = "SwatchEdge"
                    UIStroke.Color = Color3.new( 1, 1, 1 )
                    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
                    UIStroke.Thickness = 0.05
                    UIStroke.Parent = Parent
                    local SwatchSplit = Parent:FindFirstChild( "SwatchSplit" )

                    if type( Value8.swatch2 ) == "table" then
                        local UIGradient

                        if SwatchSplit then
                            UIGradient = SwatchSplit
                        else
                            UIGradient = Instance.new( "UIGradient" )
                        end

                        UIGradient.Name = "SwatchSplit"
                        local FromRGB = Color3.fromRGB( Value8.swatch[ 1 ], Value8.swatch[ 2 ], Value8.swatch[ 3 ] )
                        local FromRGB2 = Color3.fromRGB( Value8.swatch2[ 1 ], Value8.swatch2[ 2 ], Value8.swatch2[ 3 ] )
                        UIGradient.Color = ColorSequence.new( {
                            ColorSequenceKeypoint.new( 0, FromRGB ),
                            ColorSequenceKeypoint.new( 0.5, FromRGB ),
                            ColorSequenceKeypoint.new( 0.501, FromRGB2 ),
                            ColorSequenceKeypoint.new( 1, FromRGB2 )
                        } )
                        UIGradient.Rotation = 45
                        UIGradient.Parent = Parent
                        Parent.BackgroundColor3 = Color3.new( 1, 1, 1 )
                    elseif SwatchSplit then
                        SwatchSplit:Destroy( )
                    end
                end
            end

            local StyleName = Clone:FindFirstChild( "StyleName" )

            if StyleName then
                local TextColor32
                StyleName.Text = Value8.name

                if Flag5 then
                    local Color33 = Color3.new( 1, 1, 1 )

                    if Color33 then
                        TextColor32 = Color33
                    else
                        TextColor32 = Table4.dim
                    end
                else
                    TextColor32 = Table4.dim
                end

                StyleName.TextColor3 = TextColor32
            end

            local Lock = Clone:FindFirstChild( "Lock" )

            if Lock then
                Lock.Visible = not Flag5
            end

            local Need = Clone:FindFirstChild( "Need" )

            if Need then
                Need.Visible = not Flag5
                Need.Text = Value8.need or ""
            end

            local UIStroke2Inner = Clone:FindFirstChildOfClass( "UIStroke" )

            if UIStroke2Inner then
                local Color2

                if Flag6 then
                    local Flag7 = table.find( Table5, Value8.id ) ~= nil and true or false

                    if Flag7 then
                        local Equipped2 = Table4.equipped

                        if Equipped2 then
                            Color2 = Equipped2
                        else
                            local Accent = Table4.accent

                            if Accent then
                                Color2 = Accent
                            else
                                Color2 = Table4.edge
                            end
                        end
                    else
                        local Accent = Table4.accent

                        if Accent then
                            Color2 = Accent
                        else
                            Color2 = Table4.edge
                        end
                    end
                else
                    Color2 = Table4.edge
                end

                local ThicknessInner
                UIStroke2Inner.Color = Color2

                if Flag6 then
                    local Captured2 = Thickness * 2

                    if Captured2 then
                        ThicknessInner = Captured2
                    else
                        ThicknessInner = Thickness
                    end
                else
                    ThicknessInner = Thickness
                end

                UIStroke2Inner.Thickness = ThicknessInner
            end

            local function Info()
                local Text2

                if Flag5 then
                    local Name = Captured.name
                    local Text = Name .. " · " .. Value8.name

                    if Text then
                        Text2 = Text
                    else
                        Text2 = "Locked · " .. Value8.unlock
                    end
                else
                    Text2 = "Locked · " .. Value8.unlock
                end

                return Text2
            end

            local UIScale = Clone:FindFirstChildOfClass( "UIScale" )
            GamepadNav.Hover( Clone, function()
                if UIScale then
                    TweenService:Create( UIScale, TweenInfo2, { Scale = 1.05 } ):Play( )
                end

                local Text2

                if Flag5 then
                    local Name = Captured.name
                    local Text = Name .. " · " .. Value8.name

                    if Text then
                        Text2 = Text
                    else
                        Text2 = "Locked · " .. Value8.unlock
                    end
                else
                    Text2 = "Locked · " .. Value8.unlock
                end

                Status.Text = Text2 or ""
            end, function()
                if UIScale then
                    TweenService:Create( UIScale, TweenInfo2, { Scale = 1 } ):Play( )
                end

                Status.Text = Text or ""
            end )
            Clone.Activated:Connect( function()
                if Flag5 then
                    local Flag
                    Table15[ Value14 ] = Value8.id
                    Flag = table.find( Table5, Value8.id ) ~= nil and true or false

                    if not Flag then
                        Toggle( Value8.id )
                    end

                    DoSearch( )
                    return
                end
                local Text2

                if Flag5 then
                    local Name = Captured.name
                    local Text = Name .. " · " .. Value8.name

                    if Text then
                        Text2 = Text
                    else
                        Text2 = "Locked · " .. Value8.unlock
                    end
                else
                    Text2 = "Locked · " .. Value8.unlock
                end

                Status.Text = Text2 or ""
                return
            end )
            Clone:SetAttribute( "StyleId", Value8.id )
            Clone.Parent = List
            table.insert( Table16, Clone )
        end
    end
    if StyleId ~= nil then
        local Value9 = nil

        for Key5, Value10 in Table16, nil, nil do
            if Value10:GetAttribute( "StyleId" ) == StyleId then
                GamepadNav.Select( Value10 )
                break
            end
        end
    end

    task.defer( PlaceStyleBar )
end

Main:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
    task.defer( PlaceStyleBar )
end )

Callback2 = function()
    if StyleBar then
        if StyleBar.Visible or Value14 then
            task.defer( UpdateStyleBar )
        end
    end
end

DoSearch = function()
    ClearGrid( )
    Value14 = nil
    CategoryTitle.Text = WardrobeCatalog.Label( Item.name )

    if Item.bodies then
        local InvokeServer = Wardrobe.GetState.InvokeServer
        local Success, Result = pcall( InvokeServer, Wardrobe.GetState )

        if not Success or not Result then
            Text = "Couldn't load the bodies"
        else
            local Genders2
            Value6 = Result.body
            local Genders = Result.genders
            Genders2 = if Genders then Genders else { }
            local Value1
            Table14 = Genders2
            local Bodies = Result.bodies
            Value1 = nil

            for Key, Value in Bodies, nil, nil do
                AddBodyCard( Value )
            end

            Text = "Choose your body"
        end
    else
        local Value2, Number
        local Categories = WardrobeCatalog.Categories
        Value2 = nil
        Number = 0

        for Key2, Value3 in Categories, nil, nil do
            local Flag

            if Value3.name == "Mods" then
                local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                if PlayerGui == nil then
                    Flag = false
                elseif PlayerGui:GetAttribute( "IsDev" ) == true then
                    Flag = true
                else
                    Flag = false
                end
                if not Flag then
                    local PlayerGui2 = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                    if PlayerGui2 == nil then
                        Flag = false
                    elseif PlayerGui2:GetAttribute( "IsAdmin" ) == true then
                        Flag = true
                    else
                        Flag = false
                    end
                end
            else
                Flag = true
            end
            if Flag then
                if Item.all or Value3.items == Item.items then
                    local Value4
                    local Items = Value3.items
                    Value4 = nil

                    for Key3, Value5 in Items, nil, nil do
                        if Value5.admin then
                            local Flag2
                            local PlayerGui3 = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                            if PlayerGui3 == nil then
                                Flag2 = false
                            elseif PlayerGui3:GetAttribute( "IsDev" ) == true then
                                Flag2 = true
                            else
                                Flag2 = false
                            end
                            if not Flag2 then
                                if not Value5.creators then
                                    continue
                                end

                                local Flag3
                                local PlayerGui4 = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                                if PlayerGui4 == nil then
                                    Flag3 = false
                                elseif PlayerGui4:GetAttribute( "IsContentCreator" ) == true then
                                    Flag3 = true
                                else
                                    Flag3 = false
                                end
                                if not Flag3 then
                                    continue
                                end
                            end
                        end
                        if Value3.name == "Mods" then
                            local Flag4
                            local PlayerGui5 = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                            if PlayerGui5 == nil then
                                Flag4 = false
                            elseif PlayerGui5:GetAttribute( "IsDev" ) == true then
                                Flag4 = true
                            else
                                Flag4 = false
                            end
                            if not Flag4 and not Value5.adminRole then
                                continue
                            end
                        end
                        if Value3.name ~= "Skins" or SkinShown( WardrobeCatalog.Items[ Value5[ 1 ] ] ) then
                            local Entry2
                            local Entry = WardrobeCatalog.Items[ Value5[ 1 ] ]
                            Entry2 = if Entry then WardrobeCatalog.Items[ Value5[ 1 ] ].family else Entry

                            if Entry2 then
                                if Entry2 ~= Value14 and not Table8[ FamilyCard( Entry2 ) or 0 ] then
                                    Value14 = Value14 or Entry2
                                    local FamilyCard2 = FamilyCard( Entry2 )

                                    if FamilyCard2 then
                                        AddCard( FamilyCard2 )
                                        Number = Number + 1
                                    end
                                end
                            else
                                AddCard( Value5[ 1 ], Value5[ 2 ] )
                                Number = Number + 1
                            end
                        end
                    end
                end
            end
        end

        Text = Number .. " item(s)"
    end

    UpdateStyleBar( )
    Status.Text = Text or ""
    GamepadNav.Refresh( "Wardrobe" )
end

local function CatColor( Self, Argument2 )
    if Argument2 then
        local CouleurChoisie2
        local CouleurChoisie = Self:GetAttribute( "CouleurChoisie" )
        CouleurChoisie2 = if CouleurChoisie then CouleurChoisie else Table4.accent
        return CouleurChoisie2
    end
    local CouleurFond2
    local CouleurFond = Self:GetAttribute( "CouleurFond" )
    CouleurFond2 = if CouleurFond then CouleurFond else Table4.card
    return CouleurFond2
end

local function ChooseCategory( CategoryName, Argument2 )
    if CategoryName ~= Item then
        Value9 = nil
        RefreshSkinBuy( )

        if Picker then
            Picker:Close( )
        end
    end

    local Value1
    Item = CategoryName
    Value1 = nil

    for Key, Value in Table9, nil, nil do
        local Flag = Key == CategoryName and true or false
        local BackgroundColor3

        if Flag then
            local CouleurChoisie = Value:GetAttribute( "CouleurChoisie" )

            if CouleurChoisie then
                BackgroundColor3 = CouleurChoisie
            else
                BackgroundColor3 = Table4.accent
            end
        else
            local CouleurFond = Value:GetAttribute( "CouleurFond" )

            if CouleurFond then
                BackgroundColor3 = CouleurFond
            else
                BackgroundColor3 = Table4.card
            end
        end

        Value.BackgroundColor3 = BackgroundColor3
        local Text = Value:FindFirstChild( "Text" ) or Value
        Text.TextColor3 = Table4.text
    end

    local Value3
    DoSearch( )

    if Argument2 then
        Value3 = nil

        for Key2, Value2 in Grid:GetChildren( ) do
            local IsA2
            local IsA = Value2:IsA( "GuiButton" )

            if IsA then
                if Value2.Name == "InvisPadding" then
                    IsA2 = false
                else
                    IsA2 = true
                end
            else
                IsA2 = IsA
            end
            if IsA2 and Value2.Visible then
                if not Value3 or Value2.LayoutOrder < Value3.LayoutOrder then
                    Value3 = Value2
                end
            end
        end
    else
        Value3 = nil
    end

    local Value4
    local Refresh = GamepadNav.Refresh
    Value4 = if Value3 then Value3 else Table9[ CategoryName ]
    Refresh( "Wardrobe", Value4 )
end

local function CatAllowed( Argument1 )
    if Argument1.name == "Event" then
        local Flag

        if Argument1.items == nil then
            Flag = false
        elseif #Argument1.items > 0 then
            Flag = true
        else
            Flag = false
        end

        return Flag
    end
    if Argument1.name == "Skins" then
        local Items2
        local Items = Argument1.items
        Items2 = if Items then Items else { }
        local Value1 = nil

        for Key, Value in Items2, nil, nil do
            if SkinShown( WardrobeCatalog.Items[ Value[ 1 ] ] ) then
                return true
            end
        end

        return false
    end
    local Flag2

    if Argument1.name == "Mods" then
        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

        if PlayerGui == nil then
            Flag2 = false
        elseif PlayerGui:GetAttribute( "IsDev" ) == true then
            Flag2 = true
        else
            Flag2 = false
        end
        if not Flag2 then
            local PlayerGui2 = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

            if PlayerGui2 == nil then
                Flag2 = false
            elseif PlayerGui2:GetAttribute( "IsAdmin" ) == true then
                Flag2 = true
            else
                Flag2 = false
            end
        end
    else
        Flag2 = true
    end

    return Flag2
end

local function CycleCategory( Argument1 )
    local Find3
    local Find = table.find( Table, Item ) or 1
    local Count = #Table
    local I = 1
    Find3 = Find

    for I = 1, Count do
        local Find2 = ( Find - 1 + Argument1 ) % #Table + 1

        if CatAllowed( Table[ Find2 ] ) then
            Find3 = Find2
            break
        end

        Find3 = Find2
        Find = Find2
    end

    ChooseCategory( Table[ Find3 ], true )
end

Value17 = nil

for Key6, Value18 in Table, nil, nil do
    if Key6 > 1 and Value18.group ~= Table[ Key6 - 1 ].group then
        Storage.FoundChild = Parent:FindFirstChild( "Espace_" .. Value18.group )

        if Storage.FoundChild then
            Storage.FoundChild2 = Storage.FoundChild
        else
            Storage.Parent2 = Instance.new( "Frame" )
            Storage.Parent2.Name = "Espace_" .. Value18.group
            Storage.Parent2.BackgroundTransparency = 1
            Storage.Parent2.Size = UDim2.fromScale( 1, 1 )
            Storage.UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
            Storage.UIAspectRatioConstraint.AspectRatio = 18.75
            Storage.UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
            Storage.UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
            Storage.UIAspectRatioConstraint.Parent = Storage.Parent2
            Storage.Parent2.Parent = Parent
            Storage.FoundChild2 = Storage.Parent2
        end

        Storage.FoundChild2.LayoutOrder = Key6 * 2 - 1
    end
    Storage.FoundChild3 = Parent:FindFirstChild( Value18.name )

    if not Storage.FoundChild3 or not Storage.FoundChild3:IsA( "GuiButton" ) then
        Storage.FoundChild4 = Parent:FindFirstChild( Table[ 1 ].name )
        Storage.FoundChild5 = if Storage.FoundChild4 then Storage.FoundChild4 else Parent:FindFirstChildWhichIsA( "GuiButton" )
        Storage.Clone2 = Storage.FoundChild5:Clone( )
        Storage.Clone2.Name = Value18.name
        Storage.TextOf2 = TextOf( Storage.Clone2 )
        Storage.TextOf2.Text = WardrobeCatalog.Label( Value18.name )
        Storage.Clone2.Parent = Parent
        Storage.FoundChild6 = Storage.Clone2
    else
        Storage.FoundChild6 = Storage.FoundChild3
    end

    Storage.FoundChild6.BackgroundColor3 = CatColor( Storage.FoundChild6, false )
    Storage.TextOf3 = TextOf( Storage.FoundChild6 )
    Storage.TextOf3.TextColor3 = Table4.text
    Storage.FoundChild6.LayoutOrder = Key6 * 2
    Table9[ Value18 ] = Storage.FoundChild6
    Storage.FoundChild6.Activated:Connect( function()
        if CatAllowed( Value18 ) then
            ChooseCategory( Value18 )
        end
    end )
end

local Value19

local function SyncAdminCats()
    local Value1 = nil

    for Key, Value in Table9, nil, nil do
        local Visible = CatAllowed( Key )
        Value.Visible = Visible

        if not Visible and Item == Key then
            ChooseCategory( Table[ 1 ] )
        end
    end
end

SyncAdminCats( )

Callback = function()
    SyncAdminCats( )

    if next( Table8 ) ~= nil then
        DoSearch( )
    end
end

local Table17 = { "IsDev", "IsAdmin" }
Value19 = nil

for Key7, Value20 in Table17, nil, nil do
    LocalPlayer:WaitForChild( "PlayerGui" ):GetAttributeChangedSignal( Value20 ):Connect( function()
        SyncAdminCats( )

        if next( Table8 ) ~= nil then
            DoSearch( )
        end
    end )
end

local Value21
LocalPlayer:GetAttributeChangedSignal( "Level" ):Connect( function()
    local Value1 = nil

    for Key, Value in Table8, nil, nil do
        local LevelLock = Value:FindFirstChild( "LevelLock" )

        if LevelLock and not Value:GetAttribute( "Body" ) then
            local Flag
            local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

            if PlayerGui == nil then
                Flag = false
            elseif PlayerGui:GetAttribute( "IsDev" ) == true then
                Flag = true
            else
                Flag = false
            end

            local LockedLevel2

            if Flag then
                LockedLevel2 = nil
            else
                local LockedLevel = WardrobeCatalog.LockedLevel
                LockedLevel2 = LockedLevel( Key, tonumber( LocalPlayer:GetAttribute( "Level" ) ) or 1 )
            end

            local Visible = LockedLevel2 ~= nil and true or false
            local LockedLevel4
            LevelLock.Visible = Visible

            if LockedLevel2 then
                local LockedLevel3 = 50000 + LockedLevel2 * 200

                if LockedLevel3 then
                    LockedLevel4 = LockedLevel3
                else
                    LockedLevel4 = 0
                end
            else
                LockedLevel4 = 0
            end

            local LockedLevel5
            Value.LayoutOrder = Value.LayoutOrder + ( LockedLevel4 - ( Value:GetAttribute( "LockOffset" ) or 0 ) )
            LockedLevel5 = if LockedLevel4 == 0 or not LockedLevel4 then nil else LockedLevel4
            Value:SetAttribute( "LockOffset", LockedLevel5 )
        end
    end
end )

local function SkinsChanged()
    if Value9 then
        RobuxShopUI.Done( Value9.product )
    end

    local Value1
    RefreshSkinBuy( )
    SyncAdminCats( )
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        UpdateSkinLock( Value, Key )
    end
    if Item and Item.name == "Skins" and next( Table8 ) ~= nil then
        DoSearch( )
    end
end

local Table18 = { }
local Categories3 = WardrobeCatalog.Categories
Value21 = nil

for Key8, Value22 in Categories3, nil, nil do
    Storage.Items = Value22.name == "Skins" and Value22.items or { }
    Storage.Value33 = nil

    for Key10, Value34 in Storage.Items, nil, nil do
        Storage.Entry3 = WardrobeCatalog.Items[ Value34[ 1 ] ]

        if Storage.Entry3 then
            Storage.Skin = Storage.Entry3.skin

            if Storage.Skin then
                Storage.Entry4 = Storage.Skin
            else
                Storage.Entry4 = Storage.Entry3.bodySkin
            end
        else
            Storage.Entry4 = Storage.Entry3
        end
        if Storage.Entry4 and not Table18[ "B" .. Storage.Entry4 ] then
            Table18[ "B" .. Storage.Entry4 ] = true
            LocalPlayer:GetAttributeChangedSignal( "BodySkin_" .. Storage.Entry4 ):Connect( SkinsChanged )
        end

        if Storage.Entry3 then
            Storage.Pack = Storage.Entry3.pack

            if Storage.Pack then
                Storage.Find = LimitedPacks.Find( Storage.Entry3.pack )
            else
                Storage.Find = Storage.Pack
            end
        else
            Storage.Find = Storage.Entry3
        end
        if Storage.Find and type( Storage.Find.Event ) == "string" and not Table18[ "E" .. Storage.Find.Event ] then
            Table18[ "E" .. Storage.Find.Event ] = true
            ReplicatedStorage:GetAttributeChangedSignal( Storage.Find.Event ):Connect( SkinsChanged )
        end
    end
end

local BackgroundColor3
LocalPlayer:WaitForChild( "PlayerGui" ):GetAttributeChangedSignal( "IsContentCreator" ):Connect( function()
    if next( Table8 ) ~= nil then
        DoSearch( )
    end
end )
local Entry = Table9[ Item ]
local CouleurChoisie = Table9[ Item ]:GetAttribute( "CouleurChoisie" )
BackgroundColor3 = if CouleurChoisie then CouleurChoisie else Table4.accent
Entry.BackgroundColor3 = BackgroundColor3
local Entry2 = Table9[ Item ]
local Text6 = Entry2:FindFirstChild( "Text" ) or Entry2
Text6.TextColor3 = Table4.text
local Callback3 = nil
local Callback4 = nil

Storage.DoSave = function()
    if Flag then
        Callback3( true )
        return
    end

    local Entry = Table11[ Number2 ]
    Table11[ Number2 ] = true
    RefreshSlots( )
    Flag = true
    local Text = SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton
    Text.Text = DoneText or Text2
    Table10 = {
        items = table.clone( Table5 ),
        body = Value6,
        slot = Number2,
        saved = true
    }
    Status.Text = "Outfit " .. Number2 .. " saved" or ""
    task.spawn( function()
        local InvokeServer = Wardrobe.Save.InvokeServer
        local Save = Wardrobe.Save
        local Success, Result, Success3 = pcall( InvokeServer, Save, table.clone( Table5 ) )

        if Success and Result then
            return
        end

        local Success32 = Success and Success3 or "Save error"
        Status.Text = Success32 or ""
        Table11[ Number2 ] = Entry
        RefreshSlots( )
        Table10 = Table10

        if Get.Visible then
            Flag = false
            ;( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text = Text2
        end
    end )
end

SauvegarderButton.Activated:Connect( Storage.DoSave )
Storage.Value23 = nil

for Key9, Value24 in Table12, nil, nil do
    Value24.Activated:Connect( function()
        if Key9 == Number2 then
            return
        end

        Status.Text = "Outfit " .. Key9 .. "..." or ""
        local InvokeServer = Wardrobe.SelectSlot.InvokeServer
        local Success, Result = pcall( InvokeServer, Wardrobe.SelectSlot, Key9 )

        if not Success or not Result then
            Status.Text = "Try again"
            return
        end

        local Active = Result.active
        local Filled = Result.filled
        Number2 = Active
        Table11 = Filled
        local Current = Result.current
        local Body = Result.body
        Table5 = Current
        Value6 = Body

        if Flag then
            Flag = false
            ;( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text = Text2
        end

        local Value1
        RefreshSlots( )
        RefreshEquipped( )
        Value1 = nil

        for Key, Value in Table8, nil, nil do
            StyleCard( Value, Key )
        end

        local Text2Inner

        if Table11[ Key9 ] then
            local Text = "Outfit " .. Key9

            if Text then
                Text2Inner = Text
            else
                Text2Inner = "Outfit " .. Key9 .. " is empty: dress up, then save"
            end
        else
            Text2Inner = "Outfit " .. Key9 .. " is empty: dress up, then save"
        end

        Status.Text = Text2Inner or ""
    end )
end
ClearButton.Activated:Connect( function()
    table.clear( Table5 )

    if Flag then
        Flag = false
        ;( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text = Text2
    end

    RefreshEquipped( )

    if Flag2 then
        return
    end
    Flag2 = true
    task.delay( 0.05, function()
        -- Could not structure function #42
    end )
    return
end )
Storage.OutfitApi = script:FindFirstChild( "OutfitApi" )

if Storage.OutfitApi then
    Storage.BindableFunction = Storage.OutfitApi
else
    Storage.BindableFunction = Instance.new( "BindableFunction" )
end
Storage.BindableFunction.Name = "OutfitApi"
Storage.Flag4 = false

Storage.SameSet = function( List, List2 )
    if #List ~= #List2 then
        return false
    end

    local Clone = table.clone( List )
    local Clone2 = table.clone( List2 )
    table.sort( Clone )
    table.sort( Clone2 )

    if #Clone ~= #Clone2 then
        return false
    end

    local Value1 = nil

    for Key, Value in Clone, nil, nil do
        if Clone2[ Key ] ~= Value then
            return false
        end
    end

    return true
end

Storage.Wear = function( List, Text )
    local Number = tonumber( Text )

    if Number and Number ~= Value6 then
        task.wait( 0.3 )

        if not Get.Visible then
            return nil, "Open the wardrobe first"
        end

        local InvokeServer = Wardrobe.SetBody.InvokeServer
        local Success, Result = pcall( InvokeServer, Wardrobe.SetBody, Number )

        if Success and Result then
            Value6 = Result
        end
    end

    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        if tonumber( Value ) then
            table.insert( Table, ( tonumber( Value ) ) )
        end
    end

    local Result3
    local Clone = table.clone( Table5 )
    local I = 1
    Result3 = nil
    Result3 = nil

    for I = 1, 2 do
        task.wait( 0.3 )

        if not Get.Visible then
            return nil, "Open the wardrobe first"
        end

        local InvokeServer2 = Wardrobe.Apply.InvokeServer
        local Success2, Result2 = pcall( InvokeServer2, Wardrobe.Apply, Table )

        if Success2 and type( Result2 ) == "table" then
            Result3 = Result2
        end
        if Result3 then
            if not Storage.SameSet( Result3, Clone ) or Storage.SameSet( Clone, Table ) then
                break
            end
        end
    end
    if not Result3 then
        return nil, "Try again"
    end

    local Value2, Number2
    Value2 = nil
    Number2 = 0

    for Key2, Value3 in Table, nil, nil do
        if not table.find( Result3, Value3 ) then
            Number2 = Number2 + 1
        end
    end

    Table5 = Result3

    if Value6 ~= Value6 or not Storage.SameSet( Result3, Clone ) then
        if Flag then
            Flag = false
            ;( SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton ).Text = Text2
        end
    end

    local Value4
    RefreshEquipped( )
    Value4 = nil

    for Key3, Value5 in Table8, nil, nil do
        StyleCard( Value5, Key3 )
    end

    return Number2
end

function Storage.BindableFunction.OnInvoke( Name, Argument2, Argument3 )
    if Name == "Get" then
        return { items = table.clone( Table5 ), body = Value6 }
    end
    if Name ~= "Wear" or type( Argument2 ) ~= "table" then
        return nil
    end
    if not Get.Visible then
        return nil, "Open the wardrobe first"
    end
    if Storage.Flag4 then
        return nil, "Please wait"
    end

    Storage.Flag4 = true
    local Success, Result, Success3 = pcall( Storage.Wear, Argument2, Argument3 )
    Storage.Flag4 = false

    if Success then
        return Result, Success3
    end
    warn( "[OutfitApi] " .. tostring( Result ) )
    return nil, "Try again"
end
Storage.BindableFunction.Parent = script
Storage.Value25 = nil

Storage.GetCube = function()
    if not Storage.Value25 or not Storage.Value25.Parent then
        local SPAWN_CHARACTER2
        local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )
        SPAWN_CHARACTER2 = if SPAWN_CHARACTER then SPAWN_CHARACTER:FindFirstChild( "spawn_cloth" ) else SPAWN_CHARACTER
        Storage.Value25 = SPAWN_CHARACTER2
    end

    return Storage.Value25
end

Storage.OnCube = function( HumanoidRootPart )
    if not Storage.Value25 or not Storage.Value25.Parent then
        local SPAWN_CHARACTER2
        local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )
        SPAWN_CHARACTER2 = if SPAWN_CHARACTER then SPAWN_CHARACTER:FindFirstChild( "spawn_cloth" ) else SPAWN_CHARACTER
        Storage.Value25 = SPAWN_CHARACTER2
    end
    if not Storage.Value25 then
        return false
    end

    local Flag
    local PointToObjectSpace = Storage.Value25.CFrame:PointToObjectSpace( HumanoidRootPart.Position )
    local Size = Storage.Value25.Size / 2

    if math.abs( PointToObjectSpace.X ) <= Size.X + 1.5 then
        if math.abs( PointToObjectSpace.Z ) <= Size.Z + 1.5 then
            if PointToObjectSpace.Y >= 0 then
                if PointToObjectSpace.Y <= Size.Y + 8 then
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

Storage.StandOnCube = function( HumanoidRootPart, Humanoid )
    if not Storage.Value25 or not Storage.Value25.Parent then
        local SPAWN_CHARACTER2
        local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )
        SPAWN_CHARACTER2 = if SPAWN_CHARACTER then SPAWN_CHARACTER:FindFirstChild( "spawn_cloth" ) else SPAWN_CHARACTER
        Storage.Value25 = SPAWN_CHARACTER2
    end
    if not Storage.Value25 then
        return
    end

    local Y = Storage.Value25.Position.Y + Storage.Value25.Size.Y / 2 + Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2

    if math.abs( HumanoidRootPart.Position.Y - Y ) > 0.01 then
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new( 0, Y - HumanoidRootPart.Position.Y, 0 )
    end
end

Storage.Value26 = nil

Storage.Freeze = function( Part )
    if Storage.Value26 then
        Storage.Value26.Anchored = false
    end

    Storage.Value26 = nil
    local HumanoidRootPart

    if Part and LocalPlayer.Character then
        HumanoidRootPart = ( Part and LocalPlayer.Character ):FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Part and LocalPlayer.Character
    end
    if HumanoidRootPart then
        local Humanoid = ( Part and LocalPlayer.Character ):FindFirstChildOfClass( "Humanoid" )

        if Humanoid and Storage.OnCube( HumanoidRootPart ) then
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
            Storage.StandOnCube( HumanoidRootPart, Humanoid )
            local State = Humanoid:GetState( )

            if State ~= Enum.HumanoidStateType.Running and State ~= Enum.HumanoidStateType.Dead then
                Humanoid:ChangeState( Enum.HumanoidStateType.Running )
            end
        end

        HumanoidRootPart.Anchored = true
        Storage.Value26 = HumanoidRootPart
    end
end

RunService.RenderStepped:Connect( function()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Humanoid

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not HumanoidRootPart or not Humanoid or not ( Humanoid.Health > 0 ) or not Storage.OnCube( HumanoidRootPart ) then
        if not HumanoidRootPart or not Humanoid or not ( Humanoid.Health > 0 ) then
            if Storage.Value26 and not Get.Visible then
                if Storage.Value26 then
                    Storage.Value26.Anchored = false
                end

                Storage.Value26 = nil
            end
        else
            if not Storage.Value25 or not Storage.Value25.Parent then
                local SPAWN_CHARACTER2
                local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )
                SPAWN_CHARACTER2 = if SPAWN_CHARACTER then SPAWN_CHARACTER:FindFirstChild( "spawn_cloth" ) else SPAWN_CHARACTER
                Storage.Value25 = SPAWN_CHARACTER2
            end
            if Storage.Value25 or LocalPlayer:GetAttribute( "InWardrobe" ) ~= true then
                if Storage.Value26 and not Get.Visible then
                    if Storage.Value26 then
                        Storage.Value26.Anchored = false
                    end

                    Storage.Value26 = nil
                end
            elseif Storage.Value26 ~= HumanoidRootPart or not HumanoidRootPart.Anchored then
                Storage.Freeze( true )
                return
            end
        end

        return
    end
    if Storage.Value26 ~= HumanoidRootPart or not HumanoidRootPart.Anchored then
        Storage.Freeze( true )
    end

    Storage.StandOnCube( HumanoidRootPart, Humanoid )
    return
end )
Storage.Value27 = nil
game:GetService( "RunService" ).RenderStepped:Connect( function()
    if not Get.Visible then
        return
    end

    ClientState.CursorFree = true

    if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        local HumanoidRootPart
        local Character = LocalPlayer.Character

        if Character then
            HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Character
        end
        if HumanoidRootPart then
            if Storage.Value26 ~= HumanoidRootPart or not HumanoidRootPart.Anchored then
                Storage.Freeze( true )
            end
        end
    end

    ClientState.FixedCamera = ReplicatedStorage:GetAttribute( "WardrobeCamera" )
    ClientState.FixedFOV = ReplicatedStorage:GetAttribute( "WardrobeCameraFOV" )

    if not ClientState.FixedCamera then
        local X = Main.AbsolutePosition.X + Main.AbsoluteSize.X
        ClientState.WardrobeFocusX = X + ( Get.AbsoluteSize.X - X ) / 2
    end
end )
Storage.Flag5 = false
Storage.Value28 = nil
Storage.Number3 = 0
Storage.Number4 = 0
Storage.Number5 = 0
Main.Active = true

Storage.IsDragButton = function( Argument1 )
    local Flag

    if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
        Flag = true
    elseif Argument1.UserInputType == Enum.UserInputType.MouseButton2 then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if not Argument2 and Storage.Value26 then
        local Flag

        if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
            Flag = true
        elseif Argument1.UserInputType == Enum.UserInputType.MouseButton2 then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            local X = UserInputService:GetMouseLocation( ).X
            Storage.Flag5 = true
            Storage.Value28 = X
            Storage.Number5 = 0
        end
    end
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    local Flag

    if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
        Flag = true
    elseif Argument1.UserInputType == Enum.UserInputType.MouseButton2 then
        Flag = true
    else
        Flag = false
    end
    if Flag then
        Storage.Flag5 = false
    end
end )
game:GetService( "RunService" ).RenderStepped:Connect( function( Amount )
    if not Storage.Value26 then
        Storage.Number3 = 0
        Storage.Number4 = 0
        Storage.Number5 = 0
        return
    end

    local Stick2

    if Controls.IsGamepad then
        local Stick = Controls.Stick( )

        if Stick then
            Stick2 = Stick
        else
            Stick2 = Vector2.zero
        end
    else
        Stick2 = Vector2.zero
    end
    if Stick2.X == 0 then
        if Storage.Flag5 then
            local X = UserInputService:GetMouseLocation( ).X
            local X2 = ( X - Storage.Value28 ) * 0.008726646259971648
            Storage.Value28 = X
            Storage.Number3 = Storage.Number3 + X2
            Storage.Number5 = Storage.Number5 + ( X2 / math.max( Amount, 0.004166666666666667 ) - Storage.Number5 ) * math.min( 1, 12 * Amount )
        else
            Storage.Number3 = Storage.Number3 + Storage.Number5 * Amount
            Storage.Number5 = Storage.Number5 * math.exp( -3 * Amount )
        end
    else
        Storage.Number3 = Storage.Number3 + Stick2.X * 3.839724354387525 * Amount
        Storage.Number5 = 0
    end

    local Captured = ( Storage.Number3 - Storage.Number4 ) * ( 1 - math.exp( -10 * Amount ) )
    Storage.Number4 = Storage.Number4 + Captured

    if math.abs( Captured ) > 1e-05 then
        Storage.Value26.CFrame = Storage.Value26.CFrame * CFrame.Angles( 0, Captured, 0 )
    end
end )
Storage.Flag6 = false
Storage.Flag7 = false
Storage.Flag8 = false

Storage.SetOpen = function( Visible, Argument2 )
    Get.Visible = Visible

    if Visible and Storage.Flag8 then
        Storage.Flag7 = true
    end

    AnnulerButton.Visible = Visible and Storage.Flag7

    if not Visible then
        Storage.Flag7 = false

        if LocalPlayer:GetAttribute( "Onboarding" ) ~= true then
            Storage.Flag8 = true
        end
    end

    ClientState.WardrobeOpen = Visible
    ClientState.CursorFree = Visible
    ClientState.Frozen = Visible

    if not Visible or not Argument2 or not Storage.Value26 then
        Storage.Freeze( Visible and not Argument2 )
    end
    if Visible then
        local Humanoid
        local Character = LocalPlayer.Character

        if Character then
            Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end
        if Humanoid then
            Humanoid:UnequipTools( )
        end
    else
        ClientState.FixedCamera = nil
        ClientState.FixedFOV = nil
        ClientState.WardrobeFocusX = nil
    end
    if Visible and not Storage.Flag6 then
        Storage.Flag6 = true
        local InvokeServer = Wardrobe.GetState.InvokeServer
        local Success, Result = pcall( InvokeServer, Wardrobe.GetState )

        if Success and Result then
            local Filled2
            Table5 = Result.current
            Value6 = Result.body
            local Active = Result.active or 1
            local Filled = Result.filled
            Filled2 = if Filled then Filled else { }
            Number2 = Active
            Table11 = Filled2
        end

        RefreshSlots( )
        RefreshEquipped( )
        DoSearch( )
    end
    if not Visible then
        GamepadNav.Close( "Wardrobe" )
        return
    end

    local FlagInner = LocalPlayer:GetAttribute( "Onboarding" ) == true and true or false
    local Text2Inner
    Table10 = {
        items = table.clone( Table5 ),
        body = Value6,
        slot = Number2,
        saved = FlagInner or nil
    }
    Flag = FlagInner
    local Text = SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton
    Text2Inner = FlagInner and DoneText or Text2
    Text.Text = Text2Inner
    GamepadNav.Open( "Wardrobe", {
        root = Main,
        freezeKeyboard = true,
        first = function()
            return Table9[ Item ]
        end,
        onBack = function()
            if Flag then
                Callback3( true )
                return
            end
            GamepadNav.Select( SauvegarderButton )
            return
        end,
        backLabel = "Leave",
        selectLabel = "Wear",
        tabs = {
            prev = function()
                CycleCategory( -1 )
            end,
            next = function()
                CycleCategory( 1 )
            end,
            label = "Category"
        },
        actions = {
            [ Enum.KeyCode.ButtonX ] = {
                label = "Cancel",
                fn = function()
                    if Callback4 and Storage.Flag7 then
                        Callback4( )
                    end
                end
            },
            [ Enum.KeyCode.ButtonY ] = {
                label = "Save",
                fn = function()
                    if not Flag then
                        Storage.DoSave( )
                    end
                end
            }
        },
        hints = { { Enum.KeyCode.Thumbstick2, "Rotate" } }
    } )
end

Storage.ReloadState = function()
    local InvokeServer = Wardrobe.GetState.InvokeServer
    local Success, Result = pcall( InvokeServer, Wardrobe.GetState )

    if not Success or not Result then
        return
    end

    local Filled2
    local Current = Result.current
    local Body = Result.body
    Table5 = Current
    Value6 = Body
    local Active = Result.active or 1
    local Filled = Result.filled
    Filled2 = if Filled then Filled else { }
    local Value1
    Number2 = Active
    Table11 = Filled2
    RefreshSlots( )
    RefreshEquipped( )
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        StyleCard( Value, Key )
    end

    Table10 = {
        items = table.clone( Table5 ),
        body = Value6,
        slot = Number2,
        saved = true
    }
    Flag = true
    local Text = SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton
    Text.Text = DoneText or Text2
end

Storage.Table19 = { on = false, start = nil }
Storage.Asked = LocalPlayer:GetAttribute( "NeedsGender" ) == true and true or false
Storage.Table19.asked = Storage.Asked
function Storage.Table19.wanted()
    local On2
    local On = Storage.Table19.on

    if On then
        On2 = On
    else
        local Asked = Storage.Table19.asked

        if Asked then
            if LocalPlayer:GetAttribute( "NeedsGender" ) == false then
                if LocalPlayer:GetAttribute( "Onboarding" ) == true then
                    if LocalPlayer:GetAttribute( "InTutorial" ) == nil then
                        On2 = false
                    else
                        On2 = true
                    end
                else
                    On2 = false
                end
            else
                On2 = false
            end
        else
            On2 = Asked
        end
    end

    return On2
end
LocalPlayer:GetAttributeChangedSignal( "NeedsGender" ):Connect( function()
    local NeedsGender = LocalPlayer:GetAttribute( "NeedsGender" )

    if NeedsGender == true then
        Storage.Table19.asked = true
    end
    if NeedsGender ~= false then
        return
    end
    if Storage.Table19.wanted( ) then
        Storage.Table19.asked = false
        Storage.Table19.on = true

        if Storage.Table19.start then
            task.spawn( Storage.Table19.start )
        end

        return
    end
    if Storage.Flag6 then
        Storage.ReloadState( )
    end

    return
end )
Storage.Flag9 = false

Callback4 = function()
    if Storage.Flag9 or not Storage.Flag7 then
        return
    end

    Storage.Flag9 = true
    Status.Text = "Cancelling..."

    if Number2 ~= Table10.slot then
        local InvokeServer = Wardrobe.SelectSlot.InvokeServer
        local SelectSlot = Wardrobe.SelectSlot
        local Success, Result = pcall( InvokeServer, SelectSlot, Table10.slot )

        if Success and Result then
            local Active = Result.active
            local Filled = Result.filled
            Number2 = Active
            Table11 = Filled
        end
    end

    Table5 = table.clone( Table10.items )
    local InvokeServer2 = Wardrobe.Apply.InvokeServer
    pcall( InvokeServer2, Wardrobe.Apply, Table5 )

    if Table10.body and Value6 ~= Table10.body then
        local InvokeServer3 = Wardrobe.SetBody.InvokeServer
        local SetBody = Wardrobe.SetBody
        local Success2, Result2 = pcall( InvokeServer3, SetBody, Table10.body )

        if Success2 and Result2 then
            Value6 = Result2
        end
    end

    local Value1
    RefreshSlots( )
    RefreshEquipped( )
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        StyleCard( Value, Key )
    end

    local FlagInner = Table10.saved == true and true or false
    local Text2Inner
    Flag = FlagInner
    local Text = SauvegarderButton:FindFirstChild( "Text" ) or SauvegarderButton
    Text2Inner = FlagInner and DoneText or Text2
    Text.Text = Text2Inner
    Status.Text = "Changes cancelled"
    Storage.Flag9 = false
    Callback3( )
end

AnnulerButton.Activated:Connect( Callback4 )
Storage.Value29 = nil

Storage.Sync = function()
    local Flag

    if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    else
        Flag = false
    end
    if LocalPlayer:GetAttribute( "NeedsGender" ) == true or Storage.Table19.wanted( ) then
        Flag = false
    end

    local Flag2

    if Storage.Value27 == nil then
        Flag2 = false
    elseif os.clock( ) - Storage.Value27 < 3 then
        Flag2 = true
    else
        Flag2 = false
    end
    if Flag then
        Storage.Value27 = nil
    end
    if not Flag or Get.Visible then
        if not Flag and Get.Visible and not Flag2 then
            local Clock = os.clock( )
            Storage.Value29 = Storage.Value29 or Clock

            if Clock - Storage.Value29 < 0.8 then
                task.delay( 0.8, Storage.Sync )
                return
            end

            Storage.Value29 = nil
            Storage.Value27 = nil
            Get.Visible = false
            AnnulerButton.Visible = false
            Storage.Flag7 = false

            if LocalPlayer:GetAttribute( "Onboarding" ) ~= true then
                Storage.Flag8 = true
            end

            ClientState.WardrobeOpen = false
            ClientState.CursorFree = false
            ClientState.Frozen = false

            if Storage.Value26 then
                Storage.Value26.Anchored = false
            end

            Storage.Value26 = nil
            ClientState.FixedCamera = nil
            ClientState.FixedFOV = nil
            ClientState.WardrobeFocusX = nil
            GamepadNav.Close( "Wardrobe" )
        end
    else
        Storage.SetOpen( true, true )
    end
    if Flag then
        Storage.Value29 = nil
    end
end

Storage.Get2 = Screens.Get( "WardrobeFade" )
Storage.Fade = Storage.Get2:WaitForChild( "Fade" )
Storage.Value30 = nil

Storage.FadeFromBlack = function()
    if Storage.Value30 then
        Storage.Value30:Cancel( )
    end

    Storage.Fade.BackgroundTransparency = 0
    Storage.Get2.Visible = true
    Storage.Value30 = TweenService:Create( Storage.Fade, TweenInfo.new( 3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut ), { BackgroundTransparency = 1 } )
    Storage.Value30.Completed:Connect( function( Argument1 )
        if Argument1 == Enum.PlaybackState.Completed then
            Storage.Get2.Visible = false
        end
    end )
    Storage.Value30:Play( )
end

Storage.Sound = Instance.new( "Sound" )
Storage.Sound.Name = "WardrobeLaugh"
Storage.Sound.SoundId = "rbxassetid://130665625557386"
Storage.Sound.Volume = 0.5
Storage.Sound.PlaybackRegionsEnabled = true
Storage.Sound.PlaybackRegion = NumberRange.new( 0, 2 )
Storage.Sound.Parent = game:GetService( "SoundService" )
task.spawn( pcall, game:GetService( "ContentProvider" ).PreloadAsync, game:GetService( "ContentProvider" ), { Storage.Sound } )
Storage.Value31 = nil

Storage.PlayLaugh = function()
    if Storage.Value31 then
        Storage.Value31:Disconnect( )
        Storage.Value31 = nil
    end

    Storage.Sound:Stop( )
    Storage.Sound.Volume = 0.5
    Storage.Sound.TimePosition = 0
    Storage.Sound:Play( )
    Storage.Value31 = RunService.Heartbeat:Connect( function()
        local TimePosition = Storage.Sound.TimePosition

        if not ( TimePosition >= 1.98 ) then
            if Storage.Sound.IsPlaying or not ( TimePosition > 0 ) then
                if TimePosition >= 1.85 then
                    Storage.Sound.Volume = math.max( 0, ( 2 - TimePosition ) / 0.15 ) * 0.5
                end

                return
            end
        end

        Storage.Sound:Stop( )
        Storage.Value31:Disconnect( )
        Storage.Value31 = nil
    end )
end

Storage.ExitAudio = function( Argument1, Amount )
    game:GetService( "SoundService" )

    if Argument1 and game:GetService( "ReplicatedStorage" ):GetAttribute( "HalloweenEvent" ) == true then
        Storage.PlayLaugh( )
    end

    local MusicPart
    local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )

    if SPAWN_CHARACTER then
        MusicPart = SPAWN_CHARACTER:FindFirstChild( "MusicPart" )
    else
        MusicPart = SPAWN_CHARACTER
    end

    local SpawnMusic

    if MusicPart then
        SpawnMusic = MusicPart:FindFirstChild( "SpawnMusic" )
    else
        SpawnMusic = MusicPart
    end
    if not SpawnMusic or not SpawnMusic.IsPlaying or not ( SpawnMusic.Volume > 0 ) then
        return nil
    end
    local Volume = SpawnMusic.Volume
    local Create = TweenService:Create( SpawnMusic, TweenInfo.new( Amount or 3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut ), { Volume = 0 } )
    Create:Play( )
    return function()
        Create:Cancel( )

        if SpawnMusic.Parent then
            SpawnMusic.Volume = Volume
        end
    end
end

Storage.IntroCinematic = require( ReplicatedStorage:WaitForChild( "IntroCinematic" ) )
Storage.Flag10 = false
Storage.Value32 = nil

Storage.IntroFor = function()
    local Flag

    if LocalPlayer:GetAttribute( "Onboarding" ) == true then
        if LocalPlayer:GetAttribute( "InTutorial" ) == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    return Flag
end

Storage.IntroPrepare = function()
    if not Storage.Value32 then
        local Flag

        if LocalPlayer:GetAttribute( "Onboarding" ) == true then
            if LocalPlayer:GetAttribute( "InTutorial" ) == nil then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
        if Flag then
            Storage.Value32 = Storage.IntroCinematic.Prepare( )
        end
    end
end

LocalPlayer:GetAttributeChangedSignal( "Onboarding" ):Connect( Storage.IntroPrepare )
LocalPlayer:GetAttributeChangedSignal( "InTutorial" ):Connect( Storage.IntroPrepare )
task.defer( Storage.IntroPrepare )
Storage.Flag11 = false

Callback3 = function( Argument1 )
    if Storage.Flag11 then
        return
    end

    local Flag
    Storage.Flag11 = true

    if Argument1 == true then
        if LocalPlayer:GetAttribute( "Onboarding" ) == true then
            if LocalPlayer:GetAttribute( "InTutorial" ) == nil then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
        if Flag then
            local NotCaptured = not Storage.Flag10

            if NotCaptured then
                Flag = Storage.IntroCinematic.Enabled( )
            else
                Flag = NotCaptured
            end
        end
    else
        Flag = false
    end
    if Flag then
        Storage.Flag10 = true
        pcall( Storage.IntroCinematic.ResumeMusic )

        if not Storage.Value32 then
            local Flag2

            if LocalPlayer:GetAttribute( "Onboarding" ) == true then
                if LocalPlayer:GetAttribute( "InTutorial" ) == nil then
                    Flag2 = false
                else
                    Flag2 = true
                end
            else
                Flag2 = false
            end
            if Flag2 then
                Storage.Value32 = Storage.IntroCinematic.Prepare( )
            end
        end
    elseif LocalPlayer:GetAttribute( "Onboarding" ) == true then
        pcall( Storage.IntroCinematic.StopMusic, 0.1 )
    end

    local Flag3 = if Argument1 == true then not Storage.Table19.on else false
    local Number = if Flag then 0.8 else nil
    local Success, Result = pcall( Storage.ExitAudio, Flag3, Number )

    if not Success then
        Result = nil
    end
    if Result then
        pcall( function()
            Get.Interactable = false
        end )
    end
    if Storage.Value30 then
        Storage.Value30:Cancel( )
    end

    local BackgroundTransparency
    Storage.Get2.Visible = true
    BackgroundTransparency = not Storage.Table19.on and 1 or 0
    local Number2
    Storage.Fade.BackgroundTransparency = BackgroundTransparency

    if Storage.Table19.on then
        Number2 = 0.05
    elseif Flag then
        Number2 = 0.8
    elseif Result then
        Number2 = 3
    else
        Number2 = 0.5
    end

    Storage.Value30 = TweenService:Create( Storage.Fade, TweenInfo.new( Number2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut ), { BackgroundTransparency = 0 } )
    Storage.Value30:Play( )
    Storage.Value30.Completed:Wait( )
    Wardrobe:WaitForChild( "Leave" ):FireServer( )

    if Storage.Table19.on then
        local Clock = os.clock( )
        local Clock2 = os.clock( )

        while LocalPlayer:GetAttribute( "Onboarding" ) == true do
            if not ( os.clock( ) - Clock < 10 ) then
                break
            end
            if LocalPlayer:GetAttribute( "InWardrobe" ) == true and os.clock( ) - Clock2 >= 2.5 then
                Clock2 = os.clock( )
                Wardrobe.Leave:FireServer( )
            end

            task.wait( 0.1 )
        end
    end

    local Clock3 = os.clock( )

    while Get.Visible do
        if not ( os.clock( ) - Clock3 < 4 ) then
            break
        end

        task.wait( )
    end

    task.wait( 0.2 )

    if Result then
        pcall( Result )
        pcall( function()
            Get.Interactable = true
        end )
    end
    if Flag then
        if not pcall( Storage.IntroCinematic.Play, Storage.Fade, Storage.Value32 ) then
            ClientState.IntroCinematic = false
            ClientState.FixedCamera = nil
            ClientState.FixedFOV = nil
            local UnbindAction = game:GetService( "ContextActionService" ).UnbindAction
            pcall( UnbindAction, game:GetService( "ContextActionService" ), "IntroCinematicBlock" )
        end

        pcall( Storage.IntroCinematic.StopMusic, 1.2 )
    end

    Storage.FadeFromBlack( )
    Storage.Flag11 = false
    Storage.Table19.on = false
end

function Storage.Table19.start()
    if Storage.Value30 then
        Storage.Value30:Cancel( )
    end

    Storage.Get2.Visible = true
    Storage.Fade.BackgroundTransparency = 0
    Callback3( true )
end

if Storage.Table19.on then
    task.spawn( Storage.Table19.start )
end

function ClientState.OpenWardrobe()
    if Get.Visible then
        return
    end
    if LocalPlayer.Character and LocalPlayer.Character:GetAttribute( "BetaReveal" ) then
        return
    end
    if not LocalPlayer.Character or LocalPlayer.Character:GetAttribute( "InSafeZone" ) ~= true then
        require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Notify" ) ).Error( "You must be in a safe zone to change your outfit" )
        return
    end

    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if CombatUntil and workspace:GetServerTimeNow( ) < CombatUntil then
        require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Notify" ) ).Error( "You can't use the wardrobe during a fight" )
        return
    end
    if not LocalPlayer.Character or not LocalPlayer.Character:GetAttribute( "Downed" ) then
        Storage.FadeFromBlack( )
        Storage.Value27 = os.clock( )
        Wardrobe:WaitForChild( "Enter" ):FireServer( )
        Storage.Flag7 = true
        Storage.SetOpen( true, true )
        task.delay( 3.1, Storage.Sync )
        return
    end
    return
end
LocalPlayer:GetAttributeChangedSignal( "InWardrobe" ):Connect( Storage.Sync )
LocalPlayer:GetAttributeChangedSignal( "NeedsGender" ):Connect( Storage.Sync )
Storage.Sync( )
Storage.Status2 = Wardrobe:WaitForChild( "Status", 10 )
task.spawn( function()
    local Number, Number3
    Number = 0
    Number3 = -math.huge

    while true do
        local Flag
        task.wait( 1 )
        Flag = LocalPlayer:GetAttribute( "InWardrobe" ) == true and true or false

        if not Flag or LocalPlayer:GetAttribute( "NeedsGender" ) == true or Get.Visible or Storage.Flag11 then
            Number = 0
        else
            local Number2 = Number + 1

            if Number2 >= 2 then
                warn( "[Garde-robe] sur le cube mais fermée : rouverte" )
                Storage.Sync( )
                Number = 0
            else
                Number = Number2
            end
        end
        if Storage.Status2 then
            if Flag or LocalPlayer:GetAttribute( "Onboarding" ) == true then
                if os.clock( ) - Number3 >= 3 then
                    local HumanoidRootPart
                    Number3 = os.clock( )
                    local Character = LocalPlayer.Character

                    if Character then
                        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
                    else
                        HumanoidRootPart = Character
                    end

                    local Gender
                    local Find = Screens.Find( "GenderChoice", PlayerGui )
                    local FireServer = Storage.Status2.FireServer
                    local Table = { open = Get.Visible }
                    Gender = if Find == nil then false else Find.Visible
                    local Loading
                    Table.gender = Gender
                    Loading = PlayerGui:FindFirstChild( "EcranChargement" ) ~= nil and true or false
                    local Cube
                    Table.loading = Loading

                    if HumanoidRootPart == nil then
                        Cube = false
                    else
                        Cube = Storage.OnCube( HumanoidRootPart )
                    end

                    Table.cube = Cube

                    if not Storage.Value25 or not Storage.Value25.Parent then
                        local SPAWN_CHARACTER2
                        local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )
                        SPAWN_CHARACTER2 = if SPAWN_CHARACTER then SPAWN_CHARACTER:FindFirstChild( "spawn_cloth" ) else SPAWN_CHARACTER
                        Storage.Value25 = SPAWN_CHARACTER2
                    end

                    local Room = Storage.Value25 ~= nil and true or false
                    local Frozen
                    Table.room = Room
                    Frozen = Storage.Value26 ~= nil and true or false
                    Table.frozen = Frozen
                    pcall( FireServer, Storage.Status2, Table )
                end
            end
        end
    end
end )

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local PlayerGui = Upvalue2:FindFirstChildOfClass( "PlayerGui" )

if PlayerGui == nil then
    Flag = false
elseif PlayerGui:GetAttribute( "IsDev" ) == true then
    Flag = true
else
    Flag = false
end

local LockedLevel2

if Flag then
    LockedLevel2 = nil
else
    local LockedLevel = Upvalue3.LockedLevel
    LockedLevel2 = LockedLevel( Upvalue1, tonumber( Upvalue2:GetAttribute( "Level" ) ) or 1 )
end

local Text2

if not Upvalue4[ Upvalue1 ] or not LockedLevel2 then
    Text2 = Upvalue4[ Upvalue1 ]
else
    local Text = Upvalue4[ Upvalue1 ] .. " · Unlocks at level " .. LockedLevel2

    if Text then
        Text2 = Text
    else
        Text2 = Upvalue4[ Upvalue1 ]
    end
end

return Text2
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]
