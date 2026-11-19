-- Players.perkbrokeyou.PlayerScripts.VehicleCrateClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Lighting = game:GetService( "Lighting" )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Parent = game:GetService( "SoundService" )
local StarterGui = game:GetService( "StarterGui" )
local TweenService = game:GetService( "TweenService" )
local VehicleCrates = require( ReplicatedStorage:WaitForChild( "VehicleCrates" ) )
local Studios = ReplicatedStorage:WaitForChild( "Studios" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local Remotes = ReplicatedStorage:WaitForChild( "Remotes" )
local OpenVehicleCrate = Remotes:WaitForChild( "OpenVehicleCrate" )
local VehicleGarage = Remotes:WaitForChild( "VehicleGarage" )
local VehicleModels = ReplicatedStorage:WaitForChild( "VehicleModels" )
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local RollSkip = require( ReplicatedStorage:WaitForChild( "RollSkip" ) )
local Class = setmetatable( { }, { __mode = "k" } )

local function Sound( Text, Volume, Amount )
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. Text
    Sound.Volume = Volume
    Sound.PlaybackSpeed = Amount or 1
    Sound:SetAttribute( "Speed", Amount or 1 )
    Sound:SetAttribute( "CaseSound", true )
    Sound.Parent = Parent
    Class[ Sound ] = Volume
    return Sound
end

local Sound2 = Instance.new( "Sound" )
Sound2.SoundId = "rbxassetid://" .. 93076868992220
Sound2.Volume = 0.67
Sound2.PlaybackSpeed = 1
Sound2:SetAttribute( "Speed", 1 )
Sound2:SetAttribute( "CaseSound", true )
Sound2.Parent = Parent
Class[ Sound2 ] = 0.67
local Sound3 = Instance.new( "Sound" )
Sound3.SoundId = "rbxassetid://" .. 9126228631
Sound3.Volume = 0.5
Sound3.PlaybackSpeed = 1
Sound3:SetAttribute( "Speed", 1 )
Sound3:SetAttribute( "CaseSound", true )
Sound3.Parent = Parent
Class[ Sound3 ] = 0.5
local Sound4 = Instance.new( "Sound" )
Sound4.SoundId = "rbxassetid://" .. 104157091834980
Sound4.Volume = 1
Sound4.PlaybackSpeed = 1
Sound4:SetAttribute( "Speed", 1 )
Sound4:SetAttribute( "CaseSound", true )
Sound4.Parent = Parent
Class[ Sound4 ] = 1
local Sound5 = Instance.new( "Sound" )
Sound5.SoundId = "rbxassetid://" .. 166047422
Sound5.Volume = 1.1
Sound5.PlaybackSpeed = 1
Sound5:SetAttribute( "Speed", 1 )
Sound5:SetAttribute( "CaseSound", true )
Sound5.Parent = Parent
Class[ Sound5 ] = 1.1
local Sound6 = Instance.new( "Sound" )
Sound6.SoundId = "rbxassetid://" .. 9126102694
Sound6.Volume = 0.5
Sound6.PlaybackSpeed = 1
Sound6:SetAttribute( "Speed", 1 )
Sound6:SetAttribute( "CaseSound", true )
Sound6.Parent = Parent
Class[ Sound6 ] = 0.5
local Sound7 = Instance.new( "Sound" )
Sound7.SoundId = "rbxassetid://" .. 9126009571
Sound7.Volume = 0.9
Sound7.PlaybackSpeed = 1
Sound7:SetAttribute( "Speed", 1 )
Sound7:SetAttribute( "CaseSound", true )
Sound7.Parent = Parent
Class[ Sound7 ] = 0.9
local Sound8 = Instance.new( "Sound" )
Sound8.SoundId = "rbxassetid://" .. 95619349451044
Sound8.Volume = 0.7
Sound8.PlaybackSpeed = 1
Sound8:SetAttribute( "Speed", 1 )
Sound8:SetAttribute( "CaseSound", true )
Sound8.Parent = Parent
Class[ Sound8 ] = 0.7
local Sound9 = Instance.new( "Sound" )
Sound9.SoundId = "rbxassetid://" .. 109541594740226
Sound9.Volume = 0.65
Sound9.PlaybackSpeed = 1
Sound9:SetAttribute( "Speed", 1 )
Sound9:SetAttribute( "CaseSound", true )
Sound9.Parent = Parent
Class[ Sound9 ] = 0.65
local Sound10 = Instance.new( "Sound" )
Sound10.SoundId = "rbxassetid://" .. 9126009571
Sound10.Volume = 0.3
Sound10.PlaybackSpeed = 0.75
Sound10:SetAttribute( "Speed", 0.75 )
Sound10:SetAttribute( "CaseSound", true )
Sound10.Parent = Parent
Class[ Sound10 ] = 0.3
local Sound11 = Instance.new( "Sound" )
Sound11.SoundId = "rbxassetid://" .. 133743196377753
Sound11.Volume = 0.55
Sound11.PlaybackSpeed = 1
Sound11:SetAttribute( "Speed", 1 )
Sound11:SetAttribute( "CaseSound", true )
Sound11.Parent = Parent
Class[ Sound11 ] = 0.55
local Sound12 = Instance.new( "Sound" )
Sound12.SoundId = "rbxassetid://" .. 85953550219863
Sound12.Volume = 0.7
Sound12.PlaybackSpeed = 1
Sound12:SetAttribute( "Speed", 1 )
Sound12:SetAttribute( "CaseSound", true )
Sound12.Parent = Parent
Class[ Sound12 ] = 0.7
local Sound13 = Instance.new( "Sound" )
Sound13.SoundId = "rbxassetid://" .. 88975449185829
Sound13.Volume = 0.85
Sound13.PlaybackSpeed = 1
Sound13:SetAttribute( "Speed", 1 )
Sound13:SetAttribute( "CaseSound", true )
Sound13.Parent = Parent
Class[ Sound13 ] = 0.85
local Sound14 = Instance.new( "Sound" )
Sound14.SoundId = "rbxassetid://" .. 87153286298561
Sound14.Volume = 1
Sound14.PlaybackSpeed = 1
Sound14:SetAttribute( "Speed", 1 )
Sound14:SetAttribute( "CaseSound", true )
Sound14.Parent = Parent
Class[ Sound14 ] = 1
local Sound15 = Instance.new( "Sound" )
Sound15.SoundId = "rbxassetid://" .. 137131055688140
Sound15.Volume = 1
Sound15.PlaybackSpeed = 1
Sound15:SetAttribute( "Speed", 1 )
Sound15:SetAttribute( "CaseSound", true )
Sound15.Parent = Parent
Class[ Sound15 ] = 1
local Sound16 = Instance.new( "Sound" )
Sound16.SoundId = "rbxassetid://" .. 87679073738459
Sound16.Volume = 1
Sound16.PlaybackSpeed = 1
Sound16:SetAttribute( "Speed", 1 )
Sound16:SetAttribute( "CaseSound", true )
Sound16.Parent = Parent
Class[ Sound16 ] = 1
local Table = {
    common = Sound11,
    uncommon = Sound12,
    rare = Sound13,
    epic = Sound14,
    legendary = Sound15,
    mythical = Sound16
}
local Table2 = { }
Value1 = nil

for Key, Value in Table, nil, nil do
    Table2[ Key ] = Value.Volume
end

local SPECIAL_SOUND2

local function Play( Track, PlaybackSpeed )
    local PlaybackSpeed2

    if PlaybackSpeed then
        PlaybackSpeed2 = PlaybackSpeed
    else
        local Speed = Track:GetAttribute( "Speed" )

        if Speed then
            PlaybackSpeed2 = Speed
        else
            PlaybackSpeed2 = 1
        end
    end

    Track.PlaybackSpeed = PlaybackSpeed2
    Track.TimePosition = 0
    Track:Play( )
end

local Table3 = { }
local SPECIAL_SOUND = VehicleCrates.SPECIAL_SOUND
SPECIAL_SOUND2 = if SPECIAL_SOUND then SPECIAL_SOUND else { }
local Value2 = nil

for Key2, Value3 in SPECIAL_SOUND2, nil, nil do
    if Value3 ~= 0 then
        local Sound17 = Instance.new( "Sound" )
        Sound17.SoundId = "rbxassetid://" .. Value3
        Sound17.Volume = 1.5
        Sound17.PlaybackSpeed = 1
        Sound17:SetAttribute( "Speed", 1 )
        Sound17:SetAttribute( "CaseSound", true )
        Sound17.Parent = Parent
        Class[ Sound17 ] = 1.5
        Sound17.Name = "Special_" .. Key2
        Table3[ Key2 ] = Sound17
    end
end

local UIScale2
task.spawn( function()
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Table3, nil, nil do
        table.insert( Table, Value )
    end
    if #Table > 0 then
        pcall( function()
            game:GetService( "ContentProvider" ):PreloadAsync( Table )
        end )
    end
end )
local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )

local function Template( Text )
    local Get = Screens.Get( Text, 30 )

    if not Get then
        error( "[VehicleCrateClient] StarterGui." .. Text .. " introuvable", 0 )
    end

    local Count2
    local Find = Screens.Find( Text, StarterGui )

    if Find then
        local Count = #Find:GetDescendants( )

        if Count then
            Count2 = Count
        else
            Count2 = 0
        end
    else
        Count2 = 0
    end

    local Clock = os.clock( )

    while #Get:GetDescendants( ) < Count2 do
        if not ( os.clock( ) - Clock < 10 ) then
            break
        end

        task.wait( 0.1 )
    end

    return Get
end

local function Need( Self, Name, ClassName )
    local FoundChild = Self:FindFirstChild( Name, true )

    if not FoundChild or not FoundChild:IsA( ClassName ) then
        error( ( "[VehicleCrateClient] %s : élément « %s » (%s) introuvable" ):format( Self:GetFullName( ), Name, ClassName ), 0 )
    end

    return FoundChild
end

local function Opt( Object, Name, ClassName, Argument4 )
    local FoundChild = Object:FindFirstChild( Name, true )

    if not FoundChild or not FoundChild:IsA( ClassName ) then
        return Instance.new( Argument4 or ClassName )
    end
    return FoundChild
end

local function SetState( Self, Text )
    local Value1, Value2
    Value1 = nil
    Value2 = nil

    for Key, Value in Self:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            Value2 = Value2 or Value

            if Value.Name == Text then
                Value1 = Value
            end
        end
    end

    local Value3 = Value1 or Value2

    for Key2, Value4 in Self:GetChildren( ) do
        if Value4:IsA( "UIGradient" ) then
            local Enabled = Value4 == Value3 and true or false
            Value4.Enabled = Enabled
        end
    end
end

local Template2 = Template( "VehicleCrateMenu" )
Template2.Visible = false
local Need2 = Need( Template2, "Panel", "GuiObject" )
local UIScale = Need2:FindFirstChildOfClass( "UIScale" )

if UIScale then
    UIScale2 = UIScale
else
    UIScale2 = Instance.new( "UIScale", Need2 )
end

local TextLabel
local Scale = UIScale2.Scale
local Need3 = Need( Template2, "Close", "GuiButton" )
local Need4 = Need( Template2, "Open", "GuiButton" )
local Text = Need4:FindFirstChild( "Text", true )

if not Text or not Text:IsA( "TextLabel" ) then
    TextLabel = Instance.new( "TextLabel" )
else
    TextLabel = Text
end

local TextLabel2
local Text2 = TextLabel.Text
local CaseName = Template2:FindFirstChild( "CaseName", true )

if not CaseName or not CaseName:IsA( "TextLabel" ) then
    TextLabel2 = Instance.new( "TextLabel" )
else
    TextLabel2 = CaseName
end

local TextLabel3
local Price = Template2:FindFirstChild( "Price", true )

if not Price or not Price:IsA( "TextLabel" ) then
    TextLabel3 = Instance.new( "TextLabel" )
else
    TextLabel3 = Price
end

local TextLabel4
local Status = Template2:FindFirstChild( "Status", true )

if not Status or not Status:IsA( "TextLabel" ) then
    TextLabel4 = Instance.new( "TextLabel" )
else
    TextLabel4 = Status
end

local ViewportFrame
TextLabel4.Text = ""
local Preview = Template2:FindFirstChild( "Preview", true )

if not Preview or not Preview:IsA( "ViewportFrame" ) then
    ViewportFrame = Instance.new( "ViewportFrame" )
else
    ViewportFrame = Preview
end

local TextLabel5
local PreviewName = Template2:FindFirstChild( "PreviewName", true )

if not PreviewName or not PreviewName:IsA( "TextLabel" ) then
    TextLabel5 = Instance.new( "TextLabel" )
else
    TextLabel5 = PreviewName
end

local Frame
local Odds = Template2:FindFirstChild( "Odds", true )

if not Odds or not Odds:IsA( "GuiObject" ) then
    Frame = Instance.new( "Frame" )
else
    Frame = Odds
end

local OddRow = Frame:FindFirstChild( "OddRow" )

if OddRow then
    OddRow.Visible = false
end

local CRATE_ORDER2
local Template3 = Template( "VehicleCrateFX" )
Template3.Visible = false
local DEFAULT_CRATE = VehicleCrates.DEFAULT_CRATE or "Mythic"
local Table4 = { }
local Choices = Need2:FindFirstChild( "Choices" )
local CRATE_ORDER = VehicleCrates.CRATE_ORDER
CRATE_ORDER2 = if CRATE_ORDER then CRATE_ORDER else { }
local Value4 = nil

for Key3, Value5 in CRATE_ORDER2, nil, nil do
    local FoundChild

    if Choices then
        FoundChild = Choices:FindFirstChild( "Choice" .. Key3 )
    else
        FoundChild = Choices
    end
    if FoundChild and FoundChild:IsA( "GuiButton" ) then
        Table4[ Value5 ] = FoundChild
    end
end

local Value7

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function InOut( Argument1 )
    local Clamp3
    local Clamp = math.clamp( Argument1, 0, 1 )

    if Clamp < 0.5 then
        local Clamp2 = 4 * Clamp ^ 3

        if Clamp2 then
            Clamp3 = Clamp2
        else
            Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
        end
    else
        Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
    end

    return Clamp3
end

local function OutCubic( Argument1 )
    return 1 - ( 1 - math.clamp( Argument1, 0, 1 ) ) ^ 3
end

local function InCubic( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * Clamp
end

local function OutBack( Argument1, Amount )
    local Number = Amount or 1.7
    local Clamp = math.clamp( Argument1, 0, 1 ) - 1
    return 1 + ( Number + 1 ) * Clamp ^ 3 + Number * Clamp ^ 2
end

local function Rnd( Argument1, Argument2 )
    return Argument1 + math.random( ) * ( Argument2 - Argument1 )
end

local Flag = false
local Table5 = { }

local function Tween( List, Amount, List2, Argument4, Argument5 )
    local Number = if Flag then 0 else Amount
    local Create = TweenService:Create( List, TweenInfo.new( Number, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out ), List2 )

    if not Flag then
        Table5[ Create ] = { List, List2 }
        Create.Completed:Once( function()
            Table5[ Create ] = nil
        end )
        Create:Play( )
        return Create
    end

    local Value1 = nil

    for Key, Value in List2, nil, nil do
        List[ Key ] = Value
    end

    return Create
end

local function RiseIn( Argument1 )
    local TimeLength2

    if Sound8.TimeLength > 0 then
        local TimeLength = Sound8.TimeLength

        if TimeLength then
            TimeLength2 = TimeLength
        else
            TimeLength2 = 1.44
        end
    else
        TimeLength2 = 1.44
    end

    Sound8.PlaybackSpeed = 1

    if Argument1 <= TimeLength2 then
        Sound8.TimePosition = TimeLength2 - Argument1
        Sound8:Play( )
        return
    end
    task.delay( Argument1 - TimeLength2, function()
        Sound8.TimePosition = 0
        Sound8:Play( )
    end )
    return
end

local Value6 = nil

local function PlayRarity( RarityName )
    local Entry = Table[ RarityName ]

    if not Entry then
        return
    end

    local PlaybackSpeed
    Entry.Volume = Table2[ RarityName ]
    local Speed = Entry:GetAttribute( "Speed" )
    PlaybackSpeed = if Speed then Speed else 1
    Entry.PlaybackSpeed = PlaybackSpeed
    Entry.TimePosition = 0
    Entry:Play( )
    Value6 = Entry
end

local function FadeRarity( Amount )
    Value6 = nil

    if Value6 and Value6.IsPlaying then
        Tween( Value6, Amount, { Volume = 0 } )
        task.delay( Amount + 0.05, function()
            Value6:Stop( )
        end )
    end
end

local function CarInfo( Argument1 )
    local Name
    local Info, Info2 = VehicleCrates.Info( Argument1 )
    Name = Info and Info.Name or Argument1
    local Info22 = if Info2 then Info2 else VehicleCrates.Rarities.common
    local Rarity = Info and Info.Rarity or "common"
    return Name, Info22, Rarity
end

local function Circle()
    local Interactions2
    local Interactions = workspace:FindFirstChild( "Interactions" )
    Interactions2 = if Interactions then Interactions else workspace
    return Interactions2:FindFirstChild( "EntryCircle" )
end

local function Cost()
    local Cost2
    local _, Crate2 = VehicleCrates.Crate( DEFAULT_CRATE )
    local Cost = Crate2.Cost
    Cost2 = if Cost then Cost else VehicleCrates.DEFAULT_COST
    return Cost2
end

local function BuildOdds()
    if not OddRow then
        return
    end
    for Key, Value in Frame:GetChildren( ) do
        if Value:GetAttribute( "Live" ) then
            Value:Destroy( )
        end
    end
    for Key2, Value2 in VehicleCrates.List( DEFAULT_CRATE ) do
        local TextLabel
        local Clone = OddRow:Clone( )
        Clone:SetAttribute( "Live", true )
        Clone.Name = "Odd_" .. Value2.Key
        Clone.LayoutOrder = Key2
        Clone.Visible = true
        local CarName = Clone:FindFirstChild( "CarName", true )

        if not CarName or not CarName:IsA( "TextLabel" ) then
            TextLabel = Instance.new( "TextLabel" )
        else
            TextLabel = CarName
        end

        local TextLabel2
        TextLabel.Text = Value2.Name
        local Rarity = Clone:FindFirstChild( "Rarity", true )

        if not Rarity or not Rarity:IsA( "TextLabel" ) then
            TextLabel2 = Instance.new( "TextLabel" )
        else
            TextLabel2 = Rarity
        end

        local FrameInner
        TextLabel2.Text = VehicleCrates.Rarities[ Value2.Rarity ].Name
        TextLabel2.TextColor3 = Value2.Color
        local RarityBar = Clone:FindFirstChild( "RarityBar", true )

        if not RarityBar or not RarityBar:IsA( "GuiObject" ) then
            FrameInner = Instance.new( "Frame" )
        else
            FrameInner = RarityBar
        end

        local TextLabel3
        FrameInner.BackgroundColor3 = Value2.Color
        local Text = ( "%.3f" ):format( Value2.Chance ):gsub( "0+$", "" ):gsub( "%.$", "" ) .. "%"
        local Chance = Clone:FindFirstChild( "Chance", true )

        if not Chance or not Chance:IsA( "TextLabel" ) then
            TextLabel3 = Instance.new( "TextLabel" )
        else
            TextLabel3 = Chance
        end

        TextLabel3.Text = Text
        Clone.Parent = Frame
    end
end

BuildOdds( )
local Table6 = { }
local Callback = nil

local function RefreshMenu()
    local Value1
    local _, Crate2 = VehicleCrates.Crate( DEFAULT_CRATE )
    TextLabel2.Text = Crate2.Name or "Prestige Crate​⁠​⁠​⁠​⁠​⁠​⁠​​⁠​​​​⁠​⁠⁠​"
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        local Text3 = Value:FindFirstChild( "Text" )

        if Text3 and Text3:IsA( "TextLabel" ) then
            Text3.Text = VehicleCrates.CRATES[ Key ].Short or Key
        end

        local Selected = Value:FindFirstChild( "Selected" )

        if Selected and Selected:IsA( "UIStroke" ) then
            local Enabled = Key == DEFAULT_CRATE and true or false
            Selected.Enabled = Enabled
        end
    end

    local Cost2
    local _, Crate22 = VehicleCrates.Crate( DEFAULT_CRATE )
    local Cost = Crate22.Cost
    Cost2 = if Cost then Cost else VehicleCrates.DEFAULT_COST
    local Cost4
    TextLabel3.Text = MoneyFormat( Cost2 )
    local Number = tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0
    local _, Crate23 = VehicleCrates.Crate( DEFAULT_CRATE )
    local Cost3 = Crate23.Cost
    Cost4 = if Cost3 then Cost3 else VehicleCrates.DEFAULT_COST
    local AutoButtonColor = Cost4 <= Number and true or false
    local Text = not AutoButtonColor and "NoMoney" or "CanOpen"
    local Text2Inner
    SetState( Need4, Text )
    Text2Inner = AutoButtonColor and Text2 or Need4:GetAttribute( "NoMoneyText" ) or "NO MONEY"
    TextLabel.Text = Text2Inner
    Need4.AutoButtonColor = AutoButtonColor
end

LocalPlayer:GetAttributeChangedSignal( "Money" ):Connect( RefreshMenu )

local function ChooseCrate( CrateName )
    if not Template2.Visible or CrateName == DEFAULT_CRATE or not VehicleCrates.CRATES[ CrateName ] then
        return
    end
    DEFAULT_CRATE = CrateName
    BuildOdds( )
    RefreshMenu( )
    return
end

Value7 = nil

for Key4, Value8 in Table4, nil, nil do
    Value8.Activated:Connect( function()
        if Template2.Visible and Key4 ~= DEFAULT_CRATE then
            if not VehicleCrates.CRATES[ Key4 ] then
                return
            end

            DEFAULT_CRATE = Key4
            BuildOdds( )
            RefreshMenu( )
        end
    end )
end

local Number = 0

local function ShowMenu( Visible )
    if Template2.Visible == Visible then
        return
    end

    Template2.Visible = Visible

    if not Visible then
        GamepadNav.Close( "CrateMenu" )
        return
    end

    local Value1
    Number = os.clock( )
    TextLabel4.Text = ""
    RefreshMenu( )
    UIScale2.Scale = 0.9 * Scale
    Tween( UIScale2, 0.15, { Scale = Scale } )
    Table6[ Need4 ] = function()
        if Callback then
            Callback( )
        end
    end
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        Table6[ Value ] = function()
            if Template2.Visible and Key ~= DEFAULT_CRATE then
                if not VehicleCrates.CRATES[ Key ] then
                    return
                end

                DEFAULT_CRATE = Key
                BuildOdds( )
                RefreshMenu( )
            end
        end
    end

    Table6[ Need3 ] = function()
        dismissed = true
        ShowMenu( false )
    end
    GamepadNav.Open( "CrateMenu", {
        root = Template2,
        first = Need4,
        freeze = false,
        virtual = true,
        onSelect = function()
            if Callback then
                Callback( )
            end
        end,
        virtualActions = Table6,
        holdButtons = { [ Need4 ] = 0.7 },
        hints = { { Enum.KeyCode.DPadRight, "Choose" } },
        selectLabel = "Select (hold to buy)",
        backLabel = "Close",
        onBack = function()
            dismissed = true
            ShowMenu( false )
        end
    } )
end

task.spawn( function()
    local Table = { }

    for Key, Value in VehicleCrates.List( ) do
        table.insert( Table, Value.Key )
    end

    local Clone, Number, Number2
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 30
    CurrentCamera.Parent = ViewportFrame
    ViewportFrame.CurrentCamera = CurrentCamera
    Clone = nil
    Number = 0
    Number2 = 0

    while true do
        if not Template2.Visible or not ( #Table > 0 ) then
            task.wait( 0.25 )
        else
            if not Clone or os.clock( ) - Number > 2.6 then
                if Clone then
                    Clone:Destroy( )
                end

                local Number3 = Number2 % #Table + 1
                local FoundChild = VehicleModels:FindFirstChild( Table[ Number3 ] )

                if FoundChild then
                    local Text
                    local Clone2 = FoundChild:Clone( )
                    Clone2.Parent = ViewportFrame
                    local Entry = Table[ Number3 ]
                    local Info, Info2 = VehicleCrates.Info( Entry )
                    Text = Info and Info.Name or Entry

                    if not Info2 then
                        local Common = VehicleCrates.Rarities.common
                    end

                    TextLabel5.Text = Text
                    Clone = Clone2
                end

                Number = os.clock( )
                Number2 = Number3
            end
            if Clone then
                local Clock = os.clock( ) * 0.6
                local Sin = math.sin( Clock ) * 34
                CurrentCamera.CFrame = CFrame.lookAt( Vector3.new( Sin, 9, math.cos( Clock ) * 34 ), Vector3.new( 0, 2.200000047683716, 0 ) )
            end

            RunService.RenderStepped:Wait( )
        end
    end
end )
local Flag2 = false
local Flag3 = false
local Value9 = nil
local Flag4 = false
local Flag5 = false
local Flag6 = false

local function During( Amount, Callback )
    local Clock = os.clock( )

    while true do
        if Flag5 then
            error( "VehicleCrateAborted", 0 )
        end

        local Min2

        if Amount > 0 then
            local Min = math.min( ( os.clock( ) - Clock ) / Amount, 1 )

            if Min then
                Min2 = Min
            else
                Min2 = 1
            end
        else
            Min2 = 1
        end

        local Max
        local Clock2 = os.clock( ) - Clock

        if Flag then
            Max = math.max( Clock2, Amount )
            Min2 = 1
        else
            Max = Clock2
        end
        if Callback then
            Callback( Min2, Max )
        end
        if Min2 >= 1 then
            break
        end

        RunService.RenderStepped:Wait( )
    end
end

local function Pause( Amount )
    During( Amount )
end

local function MuteSounds( Argument1 )
    local Value1 = nil

    for Key, Value in Class, nil, nil do
        local Volume
        Key:Stop( )
        Volume = if Argument1 then 0 else Value
        Key.Volume = Volume
    end
end

local function StartSkip()
    if Flag or not Flag2 then
        return
    end

    local Value1
    Flag = true
    Flag6 = true
    Value1 = nil

    for Value in Class, nil, nil do
        Value:Stop( )
        Value.Volume = 0
    end

    local Value2 = nil

    for Key, Value3 in Table5, nil, nil do
        local Value4
        Table5[ Key ] = nil
        Key:Cancel( )
        local Item = Value3[ 2 ]
        Value4 = nil

        for Key2, Value5 in Item, nil, nil do
            pcall( function()
                Value3[ 1 ][ Key2 ] = Value5
            end )
        end
    end
end

local function EndSkip()
    if not Flag then
        return
    end

    local Value1
    Flag = false
    Value1 = nil

    for Key, Value in Class, nil, nil do
        Key:Stop( )
        Key.Volume = Value
    end
end

local Table7 = { }

local function Later( Argument1 )
    table.insert( Table7, Argument1 )
end

local function RunCleanups()
    local Count = #Table7
    local I = Count

    for I = Count, 1, -1 do
        pcall( Table7[ I ] )
    end

    table.clear( Table7 )
end

local function HideHud( Argument1 )
    local Table = { }

    for Key, Value in Screens.All( PlayerGui ) do
        local Obj = Value.obj
        local Name = Value.name

        if Obj ~= Argument1 and Name ~= "GamepadHints" and Name ~= "GamepadSelection" and Name ~= "Notifications" and Screens.IsShown( Obj ) then
            Screens.SetShown( Obj, false )
            table.insert( Table, Obj )
        end
    end

    return function()
        local Value1 = nil

        for Key, Value in Table, nil, nil do
            if Value.Parent then
                Screens.SetShown( Value, true )
            end
        end
    end
end

local Table8 = { cf = CFrame.identity, fov = 55, shake = 0, kick = 0, punch = 0 }

local function Director( Amount )
    Table8.kick = Table8.kick * math.exp( -5 * Amount )
    Table8.punch = Table8.punch * math.exp( -5 * Amount )
    local Clock = os.clock( ) * 11
    local Rad = math.rad( Table8.shake + Table8.kick )
    local Angles = CFrame.Angles( Rad * 2 * math.noise( Clock, 0.31 ), Rad * 2 * math.noise( 0.73, Clock ), Rad * 1.2 * math.noise( Clock, 4.17 ) )
    ClientState.FixedCamera = Table8.cf * Angles
    ClientState.FixedFOV = Table8.fov + Table8.punch
end

local Value10 = nil

local function Part( List )
    local Value1
    local Part = Instance.new( "Part" )
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Value1 = nil

    for Key, Value in List, nil, nil do
        Part[ Key ] = Value
    end

    local Parent2
    local Parent = List.Parent
    Parent2 = if Parent then Parent else Value10
    Part.Parent = Parent2
    return Part
end

local function Emitter( Parent, List )
    local Value1
    local ParticleEmitter = Instance.new( "ParticleEmitter" )
    ParticleEmitter.Enabled = false
    ParticleEmitter.LightEmission = 1
    Value1 = nil

    for Key, Value in List, nil, nil do
        ParticleEmitter[ Key ] = Value
    end

    ParticleEmitter.Parent = Parent
    return ParticleEmitter
end

local function Kp( Argument1, Argument2 )
    return NumberSequenceKeypoint.new( Argument1, Argument2 )
end

local function DisplayCar( Name )
    local FoundChild = VehicleModels:FindFirstChild( Name )

    if not FoundChild then
        return nil
    end

    local Clone = FoundChild:Clone( )

    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            Value.Anchored = true
            Value.CanCollide = false
            Value.CanQuery = false
            Value.CanTouch = false
        elseif Value:IsA( "LuaSourceContainer" ) or Value:IsA( "Sound" ) or Value:IsA( "ProximityPrompt" ) then
            Value:Destroy( )
        end
    end

    Clone:SetAttribute( "Base", Clone:GetPivot( ) )
    return Clone
end

local function PlaceCar( Model, Argument2, Argument3, Amount )
    Model:PivotTo( Argument2 * CFrame.new( 0, Amount or 0, 0 ) * CFrame.Angles( 0, Argument3, 0 ) * Model:GetAttribute( "Base" ) )
end

local function Shockwave( Argument1, Argument2, Amount, Argument4, Argument5, Amount2 )
    local Number = Amount2 or 0.12
    local Result = Amount * 2
    local Part2 = Part( {
        Shape = Enum.PartType.Cylinder,
        Material = Enum.Material.Neon,
        Color = Argument2,
        Transparency = 0.15,
        Size = Vector3.new( Number, Result, Amount * 2 ),
        CFrame = CFrame.new( Argument1 ) * CFrame.Angles( 0, 0, 1.5707963267948966 )
    } )
    task.spawn( function()
        local Clock = os.clock( )

        while Part2.Parent do
            local Min = math.min( ( os.clock( ) - Clock ) / Argument5, 1 )
            local Captured = Amount + ( Argument4 - Amount ) * ( 1 - ( 1 - math.clamp( Min, 0, 1 ) ) ^ 3 )
            local Captured2 = Amount2 or 0.12
            local Captured3 = Captured * 2
            Part2.Size = Vector3.new( Captured2, Captured3, Captured * 2 )
            Part2.Transparency = Min * 0.85 + 0.15

            if Min >= 1 then
                Part2:Destroy( )
                return
            end

            RunService.RenderStepped:Wait( )
        end
    end )
end

local function CarRollFX( Name, Argument2, Argument3 )
    local FoundChild
    local CarRollFX = ReplicatedStorage:FindFirstChild( "CarRollFX" )

    if CarRollFX then
        FoundChild = CarRollFX:FindFirstChild( Name )
    else
        FoundChild = CarRollFX
    end
    if not FoundChild then
        return nil
    end

    local FloorY2
    local Clone = FoundChild:Clone( )
    local Pivot = FoundChild:GetPivot( )
    local FloorY = FoundChild:GetAttribute( "FloorY" )
    FloorY2 = if FloorY then FloorY else Pivot.Y
    local Value1
    Clone:PivotTo( CFrame.new( Argument2 + Vector3.new( 0, Pivot.Y - FloorY2, 0 ) ) * Pivot.Rotation )
    local Descendants = Clone:GetDescendants( )
    table.insert( Descendants, Clone )
    Value1 = nil

    for Key, Value in Descendants, nil, nil do
        if Value:IsA( "BasePart" ) then
            Value.Anchored = true
            Value.CanCollide = false
            Value.CanQuery = false
            Value.CanTouch = false
        end
        if Argument3 and Value:IsA( "ParticleEmitter" ) then
            Value.Enabled = false
        end
    end

    Clone.Parent = Value10
    return Clone
end

local function Decode( Argument1, Text, Amount )
    During( Amount, function( Argument1Inner )
        local Floor = math.floor( #Text * Argument1Inner )
        local TextInner = Text:sub( 1, Floor )
        local Floor2 = Floor + 1
        local Count = #Text
        local I = Floor2

        for I = Floor2, Count do
            local Random = math.random( 40 )
            TextInner = TextInner .. ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&" ):sub( Random, Random )
        end

        Argument1.Text = TextInner
    end )
    Argument1.Text = Text
end

local function Roll( p1 )
    -- Could not structure function #199
end

local Table9 = {
    money = "Not enough money",
    far = "Stand on the circle",
    busy = "Wait %ds",
    dead = "",
    nocase = "Unavailable",
    roll = "Cases reopen after the weapon roll (%ds)",
    garage = "Your vehicles are loading, try again",
    invfull = "Your inventory is full"
}

Callback = function()
    if Flag2 or Flag3 or not Value9 then
        return
    end
    if os.clock( ) - Number < 0.35 then
        return
    end

    local Cost2
    local NumberInner = tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0
    local _, Crate2 = VehicleCrates.Crate( DEFAULT_CRATE )
    local Cost = Crate2.Cost
    Cost2 = if Cost then Cost else VehicleCrates.DEFAULT_COST

    if NumberInner < Cost2 then
        Notify.Error( "Not enough money" )
        return
    end

    Flag3 = true
    local Success, Result = pcall( OpenVehicleCrate.InvokeServer, OpenVehicleCrate, DEFAULT_CRATE )
    Flag3 = false

    if not Success or type( Result ) ~= "table" or not Result.ok then
        local Entry2

        if type( Result ) == "table" then
            local Entry = Table9[ Result.err ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = "Something went wrong, try again"
            end
        else
            Entry2 = "Something went wrong, try again"
        end
        if Entry2:find( "%%d" ) then
            local Flag = if type( Result ) == "table" then Result.left else false
            Entry2 = Entry2:format( ( math.max( 1, ( math.ceil( tonumber( Flag ) or 1 ) ) ) ) )
        end
        if Entry2 ~= "" then
            Notify.Error( Entry2 )
        end

        return
    end
    Flag2 = true
    ClientState.CaseRolling = true

    if Template2.Visible ~= false then
        Template2.Visible = false
        GamepadNav.Close( "CrateMenu" )
    end

    local Success2, Result2 = pcall( Roll, Result )

    if not Success2 and Result2 ~= "VehicleCrateAborted" then
        warn( "[VehicleCrateClient] " .. tostring( Result2 ) )
    end

    local Count = #Table7
    local I = Count

    for I = Count, 1, -1 do
        pcall( Table7[ I ] )
    end

    table.clear( Table7 )
    Flag5 = false
    ClientState.FixedCamera = nil
    ClientState.FixedFOV = nil
    ClientState.CaseRolling = false
    Flag2 = false
    Flag4 = false
    pcall( VehicleGarage.InvokeServer, VehicleGarage, "Done" )
    return
end

Need4.Activated:Connect( function()
    Callback( )
end )

if RunService:IsStudio( ) then
    LocalPlayer:GetAttributeChangedSignal( "TestOpenCrate" ):Connect( function()
        if LocalPlayer:GetAttribute( "TestOpenCrate" ) == true then
            LocalPlayer:SetAttribute( "TestOpenCrate", nil )
            Callback( )
            return
        end
        return
    end )
    LocalPlayer:GetAttributeChangedSignal( "TestCrateRoll" ):Connect( function()
        local TestCrateRoll = LocalPlayer:GetAttribute( "TestCrateRoll" )

        if type( TestCrateRoll ) ~= "string" or Flag2 then
            return
        end

        local Value1
        LocalPlayer:SetAttribute( "TestCrateRoll", nil )
        local Table = { }
        local Cars = VehicleCrates.Cars
        Value1 = nil

        for Value in Cars, nil, nil do
            table.insert( Table, Value )
        end

        Flag2 = true
        ClientState.CaseRolling = true

        if Template2.Visible ~= false then
            Template2.Visible = false
            GamepadNav.Close( "CrateMenu" )
        end

        local Success, Result = pcall( Roll, {
            ok = true,
            car = TestCrateRoll,
            pool = Table,
            already = true,
            refund = 0
        } )

        if not Success and Result ~= "VehicleCrateAborted" then
            warn( "[VehicleCrateClient] " .. tostring( Result ) )
        end

        local Count = #Table7
        local I = Count

        for I = Count, 1, -1 do
            pcall( Table7[ I ] )
        end

        table.clear( Table7 )
        Flag5 = false
        ClientState.FixedCamera = nil
        ClientState.FixedFOV = nil
        ClientState.CaseRolling = false
        Flag2 = false
    end )
end

Need3.Activated:Connect( function()
    Flag4 = true

    if Template2.Visible == false then
        return
    end
    Template2.Visible = false
    GamepadNav.Close( "CrateMenu" )
    return
end )
task.spawn( function()
    while true do
        task.wait( 0.2 )

        if not Flag2 then
            local HumanoidRootPart
            local Character = LocalPlayer.Character

            if Character then
                HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
            else
                HumanoidRootPart = Character
            end

            local Interactions2
            local Interactions = workspace:FindFirstChild( "Interactions" )
            Interactions2 = if Interactions then Interactions else workspace
            local Flag2Inner
            local EntryCircle = Interactions2:FindFirstChild( "EntryCircle" )

            if not HumanoidRootPart or not EntryCircle or ClientState.Downed then
                Flag2Inner = false
            else
                local Flag
                local Position = HumanoidRootPart.Position - EntryCircle:GetPivot( ).Position
                local X = Position.X

                if Vector3.new( X, 0, Position.Z ).Magnitude < 4 then
                    if math.abs( Position.Y ) < 6 then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end

                Flag2Inner = Flag
            end

            local Flag3 = Value9 ~= nil and true or false

            if Flag2Inner ~= Flag3 then
                local EntryCircle2 = Flag2Inner and EntryCircle or nil
                Value9 = EntryCircle2

                if not Flag2Inner then
                    Flag4 = false
                end
            end

            local Flag4Inner = if Flag2Inner then not Flag4 else Flag2Inner
            ShowMenu( Flag4Inner )
        end
    end
end )

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
pcall( PreloadAsync, game:GetService( "ContentProvider" ), { Upvalue1 } )
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = true
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1:IsDescendantOf( workspace ) then
    Upvalue2 = true
end
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Disconnect( )
end
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue1.Anchored = false
end
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetDescendants( ) do
    if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
        local LocalTransparencyModifier = not Argument1 and 0 or 1
        Value.LocalTransparencyModifier = LocalTransparencyModifier
    end
end
]]

--[[
Function #64 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( false )
]]

--[[
Function #65 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Value.Parent then
        Value.Enabled = true
    end
end
]]

--[[
Function #66 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #67 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.BackgroundColor3 = BackgroundColor3
Upvalue1.BackgroundTransparency = BackgroundTransparency
Upvalue2( Upvalue1, Argument3, { BackgroundTransparency = 1 } )
]]

--[[
Function #68 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    Upvalue2.Request( Upvalue3 )
end
]]

--[[
Function #69 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1.Visible and Upvalue1 or nil
return Captured
]]

--[[
Function #70 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
]]

--[[
Function #71 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Close( "CrateRoll" )
]]

--[[
Function #72 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #73 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #74 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2.Ambient = Color3.fromRGB( 5, 5, 7 )
    Upvalue2.OutdoorAmbient = Color3.fromRGB( 5, 5, 7 )
    Upvalue3 = Upvalue3 + ( Upvalue4 - Upvalue3 ) * 0.12
    Upvalue2.ExposureCompensation = Upvalue5.ExposureCompensation + Upvalue3
    Upvalue2.Brightness = 0
    Upvalue2.EnvironmentDiffuseScale = Upvalue5.EnvironmentDiffuseScale * Upvalue6
    Upvalue2.EnvironmentSpecularScale = Upvalue5.EnvironmentSpecularScale * Upvalue6
    return
end
Upvalue2.EnvironmentDiffuseScale = Upvalue5.EnvironmentDiffuseScale
Upvalue2.EnvironmentSpecularScale = Upvalue5.EnvironmentSpecularScale
local Ambient = Upvalue5.Ambient
Upvalue2.Ambient = Ambient:Lerp( Color3.fromRGB( 10, 10, 14 ), Upvalue7 )
local OutdoorAmbient = Upvalue5.OutdoorAmbient
Upvalue2.OutdoorAmbient = OutdoorAmbient:Lerp( Color3.fromRGB( 10, 10, 14 ), Upvalue7 )
Upvalue2.ExposureCompensation = Upvalue5.ExposureCompensation - Upvalue7 * 0.6
Upvalue2.Brightness = Upvalue5.Brightness * ( 1 - Upvalue7 * 0.75 )
return
]]

--[[
Function #75 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Upvalue2[ Key ] = Value
end
]]

--[[
Function #76 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue1:PivotTo( Upvalue2 )
end
]]

--[[
Function #77 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local P = Value.p
    P.Color = Value.c
end
]]

--[[
Function #78 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value.p.Color = Color
end
]]

--[[
Function #79 has no emitted closure site
It is reproduced here so that nothing is lost

local Parent = Upvalue1( {
    Size = Vector3.new( 0.6000000238418579, 0.6000000238418579, 0.6000000238418579 ),
    Transparency = 1,
    CFrame = CFrame.lookAt( Argument1, Argument2 )
} )
local SpotLight = Instance.new( "SpotLight" )
SpotLight.Face = Enum.NormalId.Front
SpotLight.Angle = Angle
SpotLight.Range = Range
SpotLight.Brightness = 0
SpotLight.Shadows = true
SpotLight.Parent = Parent
table.insert( Upvalue2, SpotLight )
return SpotLight
]]

--[[
Function #80 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
Upvalue2:Destroy( )
]]

--[[
Function #81 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Number
    Value.Color = Upvalue2
    Number = not ( Key <= 4 ) and 6 or 4
    Value.Brightness = Number * Upvalue3
end

local Value2 = nil

for Key2, Value3 in Upvalue4, nil, nil do
    local Enabled
    local Lens = Value3.lens
    Lens.Color = Color3.fromRGB( 40, 40, 40 ):Lerp( Upvalue2, ( math.clamp( Upvalue3, 0, 1 ) ) )
    local Beam = Value3.beam
    Enabled = Upvalue3 > 0.05 and true or false
    Beam.Enabled = Enabled
    local Beam2 = Value3.beam
    Beam2.Color = ColorSequence.new( Upvalue2 )
    local Beam3 = Value3.beam
    Beam3.Transparency = NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 1 - math.clamp( Upvalue3, 0, 1 ) * 0.5 ),
        Upvalue5( 1, 1 )
    } )
end
]]

--[[
Function #82 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value.Enabled = Enabled
end
]]

--[[
Function #83 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Emit( Argument1 )
end
]]

--[[
Function #84 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )
local Min = math.min( Clock - Upvalue1, 0.1 )
Upvalue1 = Clock
Upvalue2 = Upvalue2 + Upvalue3 * Min

if Upvalue4.Parent then
    Upvalue4:PivotTo( CFrame.new( Upvalue5.Position ) * CFrame.Angles( 0, Upvalue2, 0 ) * ( Upvalue5 - Upvalue5.Position ) )
end
if Upvalue6 and Upvalue6.Parent then
    Upvalue7( Upvalue6, Upvalue8, Upvalue9 + Upvalue2, Upvalue10 )
end

Upvalue11( )
Upvalue12( )
Upvalue13( true )
]]

--[[
Function #85 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #86 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:UnbindFromRenderStep( "VehicleCrateDirector" )
]]

--[[
Function #87 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = ( 3 - 2 * Amount ) * Amount * Amount + Upvalue1 * ( Amount * Amount * Amount - Amount * Amount )
Upvalue2.cf = Upvalue3:Lerp( Upvalue4, Result ) * CFrame.new( 0, math.sin( Result * 3.141592653589793 ) * 2.5, 0 )
Upvalue2.fov = Upvalue5 + ( 55 - Upvalue5 ) * Result
local Clamp = math.clamp( Amount * 1.2, 0, 1 )
Upvalue6 = 0.5 * ( Clamp * Clamp * ( 3 - 2 * Clamp ) )
]]

--[[
Function #88 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.cf = Upvalue2 * CFrame.new( 0, 0, -Argument1 * 1.5 )
]]

--[[
Function #89 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1[ ModelName ] then
    Upvalue1[ ModelName ] = Upvalue2( ModelName )
end

return Upvalue1[ ModelName ]
]]

--[[
Function #90 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Destroy( )
end
]]

--[[
Function #91 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1.Parent = nil
end
if not Upvalue2[ CarName ] then
    Upvalue2[ CarName ] = Upvalue3( CarName )
end

Upvalue1 = Upvalue2[ CarName ]

if Upvalue1 then
    if Argument2 then
        local Position = Upvalue4.cf.Position
        local X = Position.X - Upvalue5.X
        Upvalue6 = math.atan2( X, Position.Z - Upvalue5.Z ) - 0.55 - Upvalue7
    end

    Upvalue8( Upvalue1, Upvalue9, Upvalue6 + Upvalue7, Upvalue10 )
    Upvalue1.Parent = Upvalue11
end
]]

--[[
Function #92 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1 + Argument1
local Sin = math.sin( Captured ) * Argument2
return CFrame.lookAt( Upvalue2 + Vector3.new( Sin, Argument3, math.cos( Captured ) * Argument2 ), Upvalue2 + Vector3.new( 0, Amount or 2.3, 0 ) )
]]

--[[
Function #93 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = 0.6 * ( 1 - ( 1 - ( 1 - math.clamp( math.min( Amount * 3, 1 ), 0, 1 ) ) ^ 3 ) )
Upvalue2 = Upvalue3 + Argument2
local Captured = Upvalue2 * 0.12 + -0.35
local Captured2 = Upvalue5 - 2
local Captured3 = Upvalue6 - 0.8
local Captured4 = Upvalue7 + Captured
local Sin = math.sin( Captured4 ) * Captured2
Upvalue4.cf = CFrame.lookAt( Upvalue8 + Vector3.new( Sin, Captured3, math.cos( Captured4 ) * Captured2 ), Upvalue8 + Vector3.new( 0, 2.299999952316284, 0 ) )
]]

--[[
Function #94 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = 1
local Clamp = math.clamp( Amount * 2, 0, 1 )
Upvalue2 = 0.9 * ( 1 - Clamp * Clamp * ( 3 - 2 * Clamp ) )
local Clamp2 = math.clamp( Amount, 0, 1 )
Upvalue3.Saturation = -0.8 * ( Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 ) )
Upvalue4 = 0.5 + 2.5 * Amount
Upvalue5.shake = 0.6 * Amount
local Captured = Upvalue6 + 0.12 * Amount2 + Upvalue7 * Amount2 * Amount2
local Captured2 = Upvalue8 - 2 + 3 * Amount
local Captured3 = Upvalue9 - 0.8 + 0.5 * Amount
local Captured4 = Upvalue10 + Captured
local Sin = math.sin( Captured4 ) * Captured2
Upvalue5.cf = CFrame.lookAt( Upvalue11 + Vector3.new( Sin, Captured3, math.cos( Captured4 ) * Captured2 ), Upvalue11 + Vector3.new( 0, 2.299999952316284, 0 ) )

if not ( Amount2 > 0.15 ) or not ( Amount2 < 0.2 ) then
    if Amount2 > 0.65 and Amount2 < 0.7 then
        if not Upvalue12.IsPlaying then
            local PlaybackSpeed
            local Speed = Upvalue12:GetAttribute( "Speed" )

            if Speed then
                PlaybackSpeed = Speed
            else
                PlaybackSpeed = 1
            end

            Upvalue12.PlaybackSpeed = PlaybackSpeed
            Upvalue12.TimePosition = 0
            Upvalue12:Play( )
        end
    end
elseif not Upvalue12.IsPlaying then
    local Speed = Upvalue12:GetAttribute( "Speed" )

    if Speed then
        PlaybackSpeed = Speed
    else
        PlaybackSpeed = 1
    end

    Upvalue12.PlaybackSpeed = PlaybackSpeed
    Upvalue12.TimePosition = 0
    Upvalue12:Play( )
end
]]

--[[
Function #95 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = true
Upvalue2.Visible = false
Upvalue3.Visible = false
Upvalue4.Visible = false
Upvalue5.Text = Upvalue6.Name
Upvalue5.TextColor3 = Upvalue7
Upvalue5.TextTransparency = 1
local Glow = Upvalue8:FindFirstChild( "Glow" )

if Glow and Glow:IsA( "UIStroke" ) then
    Glow.Color = Upvalue7
end

Upvalue8.Text = ""
Upvalue9.Visible = false
]]

--[[
Function #96 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2, 0.4, { TextTransparency = 0 } )
Upvalue3.Scale = 1.6
Upvalue1( Upvalue3, 0.45, { Scale = 1 }, Enum.EasingStyle.Back )
pcall( Upvalue4, Upvalue5, string.upper( Upvalue6 ), 0.6 )
Upvalue7.Visible = true

if Upvalue8.already then
    local Text2
    Upvalue9( Upvalue7, "Owned" )

    if ( Upvalue8.refund or 0 ) > 0 then
        local Text = "ALREADY OWNED +" .. Upvalue11( Upvalue8.refund )

        if Text then
            Text2 = Text
        elseif Upvalue8.notGiven then
            Text2 = "ALREADY OWNED"
        else
            local OwnedText = Upvalue7:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
            Text2 = OwnedText:gsub( "{refund}", Upvalue11( Upvalue8.refund or 0 ) )
        end
    elseif Upvalue8.notGiven then
        Text2 = "ALREADY OWNED"
    else
        local OwnedText = Upvalue7:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
        Text2 = OwnedText:gsub( "{refund}", Upvalue11( Upvalue8.refund or 0 ) )
    end

    Upvalue10.Text = Text2
else
    Upvalue9( Upvalue7, "New" )
    Upvalue10.Text = Upvalue7:GetAttribute( "NewText" ) or "NEW VEHICLE!"
end

local UIScale2
local UIScale = Upvalue7:FindFirstChildOfClass( "UIScale" )

if UIScale then
    UIScale2 = UIScale
else
    UIScale2 = Instance.new( "UIScale", Upvalue7 )
end

UIScale2.Scale = 0.5
Upvalue1( UIScale2, 0.35, { Scale = 1 }, Enum.EasingStyle.Back )
]]

--[[
Function #97 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( function()
    Upvalue1( Upvalue2, 0.4, { TextTransparency = 0 } )
    Upvalue3.Scale = 1.6
    Upvalue1( Upvalue3, 0.45, { Scale = 1 }, Enum.EasingStyle.Back )
    pcall( Upvalue4, Upvalue5, string.upper( Upvalue6 ), 0.6 )
    Upvalue7.Visible = true

    if Upvalue8.already then
        local Text2
        Upvalue9( Upvalue7, "Owned" )

        if ( Upvalue8.refund or 0 ) > 0 then
            local Text = "ALREADY OWNED +" .. Upvalue11( Upvalue8.refund )

            if Text then
                Text2 = Text
            elseif Upvalue8.notGiven then
                Text2 = "ALREADY OWNED"
            else
                local OwnedText = Upvalue7:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
                Text2 = OwnedText:gsub( "{refund}", Upvalue11( Upvalue8.refund or 0 ) )
            end
        elseif Upvalue8.notGiven then
            Text2 = "ALREADY OWNED"
        else
            local OwnedText = Upvalue7:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
            Text2 = OwnedText:gsub( "{refund}", Upvalue11( Upvalue8.refund or 0 ) )
        end

        Upvalue10.Text = Text2
    else
        Upvalue9( Upvalue7, "New" )
        Upvalue10.Text = Upvalue7:GetAttribute( "NewText" ) or "NEW VEHICLE!"
    end

    local UIScale2
    local UIScale = Upvalue7:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        UIScale2 = UIScale
    else
        UIScale2 = Instance.new( "UIScale", Upvalue7 )
    end

    UIScale2.Scale = 0.5
    Upvalue1( UIScale2, 0.35, { Scale = 1 }, Enum.EasingStyle.Back )
end )
]]

--[[
Function #98 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Vector3.new( Argument1, Argument2, Argument3 )
]]

--[[
Function #99 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute3
local Attribute2 = Upvalue1:GetAttribute( Attribute )
Attribute3 = typeof( Attribute2 ) == "Vector3" and Attribute2 or Argument2
return Upvalue2 + Attribute3
]]

--[[
Function #100 has no emitted closure site
It is reproduced here so that nothing is lost

return Color3.new( Argument1.R * Argument2, Argument1.G * Argument2, Argument1.B * Argument2 )
]]

--[[
Function #101 has no emitted closure site
It is reproduced here so that nothing is lost

local Table3
local Table = { neons = { }, lights = { }, level = 0, mult = Amount or 1 }

if Object then
    if Object:IsA( "BasePart" ) then
        local Table2 = { Object, unpack( Object:GetDescendants( ) ) }

        if Table2 then
            Table3 = Table2
        else
            local Descendants = Object:GetDescendants( )

            if Descendants then
                Table3 = Descendants
            else
                Table3 = { }
            end
        end
    else
        local Descendants = Object:GetDescendants( )

        if Descendants then
            Table3 = Descendants
        else
            Table3 = { }
        end
    end
else
    Table3 = { }
end

local Value1 = nil

for Key2, Value in Table3, nil, nil do
    if not Value:IsA( "BasePart" ) or not Value:GetAttribute( "OnColor" ) then
        if Value:IsA( "Light" ) then
            local Lights = Table.lights
            table.insert( Lights, {
                l = Value,
                base = Upvalue1[ Value.ClassName ] or 2,
                orig = Value.Brightness
            } )
        end
    else
        local Neons = Table.neons
        local Color = Value.Color
        local OnColor = Value:GetAttribute( "OnColor" )
        table.insert( Neons, {
            p = Value,
            off = Color,
            on = Color3.new( OnColor.R * 0.85, OnColor.G * 0.85, OnColor.B * 0.85 )
        } )
    end
end

Upvalue2[ Key ] = Table
return Table
]]

--[[
Function #102 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Value4
    local Neons = Value.neons
    Value4 = nil

    for Key3, Value5 in Neons, nil, nil do
        local P2 = Value5.p
        P2.Color = Value5.off
    end

    local Value6
    local Lights = Value.lights
    Value6 = nil

    for Key4, Value7 in Lights, nil, nil do
        local L = Value7.l
        L.Brightness = Value7.orig
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue2, nil, nil do
    local P = Value3.p
    P.Color = Value3.off
end
if Upvalue3 then
    Upvalue3.CFrame = Upvalue4
end
]]

--[[
Function #103 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value[ 1 ]:Destroy( )
end
]]

--[[
Function #104 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #105 has no emitted closure site
It is reproduced here so that nothing is lost

local Sound = Instance.new( "Sound" )
Sound.SoundId = "rbxassetid://" .. Text
Sound.Volume = Volume
Sound.PlaybackSpeed = Amount or 1
Sound:SetAttribute( "Speed", Amount or 1 )
Sound:SetAttribute( "CaseSound", true )
Sound.Parent = Upvalue1
Upvalue2[ Sound ] = Volume
Sound.Looped = Argument5 or false
Upvalue3[ Key ] = Sound
return Sound
]]

--[[
Function #106 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Stop( )
    Value:Destroy( )
end
]]

--[[
Function #107 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #108 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]

if Entry then
    local PlaybackSpeed2

    if PlaybackSpeed then
        PlaybackSpeed2 = PlaybackSpeed
    else
        local Speed = Entry:GetAttribute( "Speed" )

        if Speed then
            PlaybackSpeed2 = Speed
        else
            PlaybackSpeed2 = 1
        end
    end

    Entry.PlaybackSpeed = PlaybackSpeed2
    Entry.TimePosition = 0
    Entry:Play( )
end
]]

--[[
Function #109 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #110 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Captured2

if Upvalue2 then
    local Captured = Upvalue3 + Upvalue4 * math.sin( os.clock( ) * 3.141592653589793 * 3.2 )

    if Captured then
        Captured2 = Captured
    else
        Captured2 = Upvalue5
    end
else
    Captured2 = Upvalue5
end

local Max
local Captured3 = Captured2 - Upvalue6

if Captured3 > 0 then
    local Min = math.min( Captured3, Amount * Upvalue7 )

    if Min then
        Max = Min
    else
        Max = math.max( Captured3, -Amount * 1.35 )
    end
else
    Max = math.max( Captured3, -Amount * 1.35 )
end

Upvalue6 = Upvalue6 + Max
Upvalue8 = Upvalue8 + ( Upvalue9 - Upvalue8 ) * math.clamp( Amount * 12, 0, 1 )
Upvalue1:Update( Upvalue6, Upvalue8, Amount )
]]

--[[
Function #111 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue1:PivotTo( Upvalue2 )
end
]]

--[[
Function #112 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured2

if Upvalue1 then
    local Captured = Upvalue2 * math.exp( -( os.clock( ) - Upvalue1 ) / 0.3 )

    if Captured then
        Captured2 = Captured
    else
        Captured2 = 0
    end
else
    Captured2 = 0
end

local Clock = os.clock( )
local Max = math.max( Argument1, Captured2 )
Upvalue1 = Clock
Upvalue2 = Max
]]

--[[
Function #113 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Clock = os.clock( ) - Upvalue1

if Clock > 1.4 then
    Upvalue1 = nil
    Upvalue2:PivotTo( Upvalue3 )
    return
end
local Rad = math.rad( Upvalue4 ) * math.exp( -Clock / 0.3 ) * math.sin( Clock * 2 * 3.141592653589793 * 3.2 )
local Rad2 = math.rad( Upvalue4 * 0.4 ) * math.exp( -Clock / 0.25 ) * math.sin( Clock * 2 * 3.141592653589793 * 2.4 + 0.8 )
Upvalue2:PivotTo( CFrame.new( Upvalue5 ) * CFrame.Angles( Rad2, 0, Rad ) * CFrame.new( -Upvalue5 ) * Upvalue3 )
return
]]

--[[
Function #114 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1 = false
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    Value.e.Enabled = false
end
]]

--[[
Function #115 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1 = true
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    Value.e.Rate = 260
    Value.e.Enabled = true
end

task.delay( Duration, function()
    local Value1
    Upvalue1 = false
    Value1 = nil

    for Key, Value in Upvalue2, nil, nil do
        Value.e.Enabled = false
    end
end )
]]

--[[
Function #116 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
Upvalue2:Destroy( )
]]

--[[
Function #117 has no emitted closure site
It is reproduced here so that nothing is lost

local Random = 0.95 + math.random( ) * 0.15
local Backfire = Upvalue1.backfire

if Backfire then
    local PlaybackSpeed

    if Random then
        PlaybackSpeed = Random
    else
        local Speed = Backfire:GetAttribute( "Speed" )

        if Speed then
            PlaybackSpeed = Speed
        else
            PlaybackSpeed = 1
        end
    end

    Backfire.PlaybackSpeed = PlaybackSpeed
    Backfire.TimePosition = 0
    Backfire:Play( )
end

local Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    Value.e:Emit( Amount or 26 )
    Value.l.Brightness = 6
    Upvalue3( Value.l, 0.18, { Brightness = 0 } )
end

Upvalue4.kick = math.max( Upvalue4.kick, 0.8 )
]]

--[[
Function #118 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured3
Upvalue1 = false
Upvalue2 = Upvalue4
Upvalue3 = 1
local Captured = 0.25 + 0.45 * Upvalue4

if Upvalue5 then
    local Captured2 = Upvalue6 * math.exp( -( os.clock( ) - Upvalue5 ) / 0.3 )

    if Captured2 then
        Captured3 = Captured2
    else
        Captured3 = 0
    end
else
    Captured3 = 0
end

local Clock = os.clock( )
local Max = math.max( Captured, Captured3 )
Upvalue5 = Clock
Upvalue6 = Max
task.wait( Upvalue7 )

if Upvalue8 ~= Upvalue9 then
    return
end

Upvalue1 = true
Upvalue3 = 0
task.wait( 0.12 )
local Captured4 = Upvalue10 or 0
local I = 1

for I = 1, Captured4 do
    if Upvalue11 then
        return
    end

    Upvalue12( math.random( 16, 28 ) )
    task.wait( 0.11 + math.random( ) * 0.15000000000000002 )
end
]]

--[[
Function #119 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1
task.spawn( function()
    local Captured3
    Upvalue2 = false
    Upvalue3 = Argument1
    Upvalue4 = 1
    local Captured = 0.25 + 0.45 * Argument1

    if Upvalue5 then
        local Captured2 = Upvalue6 * math.exp( -( os.clock( ) - Upvalue5 ) / 0.3 )

        if Captured2 then
            Captured3 = Captured2
        else
            Captured3 = 0
        end
    else
        Captured3 = 0
    end

    local Clock = os.clock( )
    local Max = math.max( Captured, Captured3 )
    Upvalue5 = Clock
    Upvalue6 = Max
    task.wait( Argument2 )

    if Upvalue1 ~= Upvalue1 then
        return
    end

    Upvalue2 = true
    Upvalue4 = 0
    task.wait( 0.12 )
    local Captured4 = Argument3 or 0
    local I = 1

    for I = 1, Captured4 do
        if Upvalue7 then
            return
        end

        Upvalue8( math.random( 16, 28 ) )
        task.wait( 0.11 + math.random( ) * 0.15000000000000002 )
    end
end )
]]

--[[
Function #120 has no emitted closure site
It is reproduced here so that nothing is lost

task.wait( 0.62 )

if Upvalue1 then
    return
end

Upvalue2.master = 1
Upvalue3 = Upvalue3 + 1
Upvalue4 = false
Upvalue5 = 7
Upvalue6 = 0.47
Upvalue7 = 1
local Catch = Upvalue8.catch

if Catch then
    local PlaybackSpeed
    local Speed = Catch:GetAttribute( "Speed" )
    PlaybackSpeed = if Speed then Speed else 1
    Catch.PlaybackSpeed = PlaybackSpeed
    Catch.TimePosition = 0
    Catch:Play( )
end

local Captured2

if Upvalue9 then
    local Captured = Upvalue10 * math.exp( -( os.clock( ) - Upvalue9 ) / 0.3 )

    if Captured then
        Captured2 = Captured
    else
        Captured2 = 0
    end
else
    Captured2 = 0
end

local Clock = os.clock( )
local Max = math.max( 1.1, Captured2 )
Upvalue9 = Clock
Upvalue10 = Max
Upvalue11.kick = math.max( Upvalue11.kick, 0.9 )
task.wait( 0.34 )
Upvalue5 = 3.6
Upvalue12 = 0.15
Upvalue13 = 0.012
Upvalue4 = true
Upvalue7 = 0.22
local Clock2 = os.clock( )

while os.clock( ) - Clock2 < 9 do
    if Upvalue1 then
        break
    end

    local Clock3 = ( os.clock( ) - Clock2 ) / 9
    Upvalue12 = 0.15 - 0.08 * ( 1 - ( 1 - Clock3 ) ^ 2 )
    Upvalue13 = 0.012 * ( 1 - 0.6 * Clock3 )

    if Upvalue4 then
        Upvalue7 = 0.22 * ( 1 - Clock3 )
    end

    Upvalue14.Heartbeat:Wait( )
end
]]

--[[
Function #121 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Start( )
    task.spawn( function()
        task.wait( 0.62 )

        if Upvalue2 then
            return
        end

        Upvalue1.master = 1
        Upvalue3 = Upvalue3 + 1
        Upvalue4 = false
        Upvalue5 = 7
        Upvalue6 = 0.47
        Upvalue7 = 1
        local Catch = Upvalue8.catch

        if Catch then
            local PlaybackSpeed
            local Speed = Catch:GetAttribute( "Speed" )
            PlaybackSpeed = if Speed then Speed else 1
            Catch.PlaybackSpeed = PlaybackSpeed
            Catch.TimePosition = 0
            Catch:Play( )
        end

        local Captured2

        if Upvalue9 then
            local Captured = Upvalue10 * math.exp( -( os.clock( ) - Upvalue9 ) / 0.3 )

            if Captured then
                Captured2 = Captured
            else
                Captured2 = 0
            end
        else
            Captured2 = 0
        end

        local Clock = os.clock( )
        local Max = math.max( 1.1, Captured2 )
        Upvalue9 = Clock
        Upvalue10 = Max
        Upvalue11.kick = math.max( Upvalue11.kick, 0.9 )
        task.wait( 0.34 )
        Upvalue5 = 3.6
        Upvalue12 = 0.15
        Upvalue13 = 0.012
        Upvalue4 = true
        Upvalue7 = 0.22
        local Clock2 = os.clock( )

        while os.clock( ) - Clock2 < 9 do
            if Upvalue2 then
                break
            end

            local Clock3 = ( os.clock( ) - Clock2 ) / 9
            Upvalue12 = 0.15 - 0.08 * ( 1 - ( 1 - Clock3 ) ^ 2 )
            Upvalue13 = 0.012 * ( 1 - 0.6 * Clock3 )

            if Upvalue4 then
                Upvalue7 = 0.22 * ( 1 - Clock3 )
            end

            Upvalue14.Heartbeat:Wait( )
        end
    end )
    return
end
return
]]

--[[
Function #122 has no emitted closure site
It is reproduced here so that nothing is lost

local L = Upvalue1.l
local P = Upvalue1.p
L.Brightness = 0
P.Transparency = 1
]]

--[[
Function #123 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1( ( math.min( Argument1, 0.1 ) ) )
Upvalue2( )
local Clock = os.clock( )
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    Value.b.Enabled = Upvalue4

    if Upvalue4 then
        local Sin = math.sin( Clock * 1.3 + Value.ph ) * 0.9
        local Cos = math.cos( Clock * 0.9 + Value.ph * 1.7 )
        local Dst = Value.dst
        local Sin2 = math.sin( Sin ) * 22
        local Amount = -Upvalue5.Y / 2 + 0.05 + math.max( 0, Cos ) * 6
        Dst.WorldPosition = Upvalue6 + Vector3.new( Sin2, Amount, math.cos( Sin ) * 14 + 10 )
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue7, nil, nil do
    local Brightness
    local L2 = Value3.l

    if Upvalue8 then
        local Random = 0.8 + math.random( ) * 1.2

        if Random then
            Brightness = Random
        else
            Brightness = 0
        end
    else
        Brightness = 0
    end

    L2.Brightness = Brightness
end

local Value4 = nil

for Key3, Value5 in Upvalue9, nil, nil do
    if Upvalue10 and Value5.l.Brightness <= 0.01 and math.random( ) < 0.035 then
        local L = Value5.l
        local P = Value5.p
        L.Brightness = 2.5
        P.Transparency = 0
        task.delay( 0.06, function()
            local L = Value5.l
            local P = Value5.p
            L.Brightness = 0
            P.Transparency = 1
        end )
    end
end
]]

--[[
Function #124 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #125 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #126 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 then
    Argument1.level = Level
end
]]

--[[
Function #127 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < ( Upvalue1 or 0.35 ) do
    local Level

    if math.random( ) < 0.5 then
        local Random = ( 0.3 + math.random( ) * 0.7 ) * Upvalue3

        if Random then
            Level = Random
        else
            Level = 0.05
        end
    else
        Level = 0.05
    end

    Upvalue2.level = Level
    task.wait( 0.03 + math.random( ) * 0.05 )
end

Upvalue2.level = Upvalue3
]]

--[[
Function #128 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 then
    task.spawn( function()
        local Clock = os.clock( )

        while os.clock( ) - Clock < ( Argument3 or 0.35 ) do
            local Level

            if math.random( ) < 0.5 then
                local Random = ( 0.3 + math.random( ) * 0.7 ) * Argument2

                if Random then
                    Level = Random
                else
                    Level = 0.05
                end
            else
                Level = 0.05
            end

            Argument1.level = Level
            task.wait( 0.03 + math.random( ) * 0.05 )
        end

        Argument1.level = Argument2
    end )
    return
end
return
]]

--[[
Function #129 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value.level = 0
end

Upvalue2 = 0
]]

--[[
Function #130 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Clock = os.clock( )
Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Value8
    local Clamp5 = math.clamp( Value.level, 0, 1.5 )
    local Neons = Value.neons
    Value8 = nil

    for Key5, Value9 in Neons, nil, nil do
        local P2 = Value9.p
        P2.Color = Value9.off:Lerp( Value9.on, ( math.min( Clamp5, 1 ) ) )
    end

    local Value10
    local Lights = Value.lights
    Value10 = nil

    for Key6, Value11 in Lights, nil, nil do
        local L = Value11.l
        L.Brightness = Value11.base * Value.mult * Clamp5
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue2, nil, nil do
    local Item = Value3[ 1 ]
    Item.Brightness = Value3[ 2 ] * Upvalue3
end

local Value4 = nil

for Key3, Value5 in Upvalue4, nil, nil do
    local Level2

    if Upvalue5[ Key3 ] then
        local Level = Upvalue5[ Key3 ].level

        if Level then
            Level2 = Level
        else
            Level2 = 0
        end
    else
        Level2 = 0
    end

    local Enabled = Level2 > 0.02 and true or false
    Value5.Enabled = Enabled
    Value5.Transparency = NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 1 - math.min( Level2, 1 ) * 0.55 ),
        Upvalue6( 1, 1 )
    } )
end

local Value6 = nil

for Key4, Value7 in Upvalue7, nil, nil do
    local Max

    if Upvalue8 == "chase" then
        local Clock2 = Clock * 22 % #Upvalue7
        Max = math.max( 0, 1 - ( Value7.i - Clock2 ) % #Upvalue7 / 9 )
    elseif Upvalue8 == "full" then
        Max = math.sin( Clock * 5 + Value7.i * 0.4 ) * 0.15 + 0.85
    else
        Max = 0
    end

    local P = Value7.p
    P.Color = Value7.off:Lerp( Value7.on, Max * Upvalue9 )
end
if Upvalue10 and Upvalue11 then
    local Clamp4
    local Clamp = math.clamp( ( Clock - Upvalue11 ) / 3.6, 0, 1 )
    local Z = -2 * ( Upvalue12.Position.Z - Upvalue13.Z )
    local Clamp2 = math.clamp( Clamp, 0, 1 )

    if Clamp2 < 0.5 then
        local Clamp3 = 4 * Clamp2 ^ 3

        if Clamp3 then
            Clamp4 = Clamp3
        else
            Clamp4 = 1 - ( -2 * Clamp2 + 2 ) ^ 3 / 2
        end
    else
        Clamp4 = 1 - ( -2 * Clamp2 + 2 ) ^ 3 / 2
    end

    Upvalue10.CFrame = Upvalue12 * CFrame.new( 0, 0, Z * Clamp4 )
end
if Upvalue14 then
    Upvalue15.FocusDistance = ( Upvalue16.CFrame.Position - Upvalue14 ).Magnitude
end
]]

--[[
Function #131 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #132 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Stop( )
Upvalue1.Volume = 1.5
]]

--[[
Function #133 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
]]

--[[
Function #134 has no emitted closure site
It is reproduced here so that nothing is lost

local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
pcall( PreloadAsync, game:GetService( "ContentProvider" ), { Upvalue1 } )
]]

--[[
Function #135 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = true
]]

--[[
Function #136 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = Argument1 - ( os.clock( ) - Upvalue1 )

if Clock > 0 then
    Upvalue2( Clock )
end
]]

--[[
Function #137 has no emitted closure site
It is reproduced here so that nothing is lost

task.delay( math.max( 0, Argument1 - ( os.clock( ) - Upvalue1 ) ), Upvalue2, Argument2, Argument3 )
]]

--[[
Function #138 has no emitted closure site
It is reproduced here so that nothing is lost

return ( 0.8 * Amount + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Amount ) ) ) / 1.0546479089470326
]]

--[[
Function #139 has no emitted closure site
It is reproduced here so that nothing is lost

local Cf
local LookAt = CFrame.lookAt( Argument1.pos( Argument2 ), Argument1.look( Argument2 ) )
Cf = if Argument1.roll then LookAt * CFrame.Angles( 0, 0, Argument1.roll( Argument2 ) ) else LookAt
local Fov = Argument1.fov( Argument2 )
Upvalue1.cf = Cf
Upvalue1.fov = Fov

if Argument1.focus then
    Upvalue2 = Argument1.focus( Argument2 )
end
]]

--[[
Function #140 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( ( Upvalue3 + Argument2 - Upvalue4 ) / ( Upvalue5 - Upvalue4 ), 0, 1 )
Upvalue1( Upvalue2, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
]]

--[[
Function #141 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1

if not Argument3.focus then
    Upvalue2 = nil
end
if Upvalue3:IsStudio( ) and Upvalue4:GetAttribute( "DebugStudioShot" ) == Upvalue1 then
    local Clock = os.clock( )
    Upvalue4:SetAttribute( "DebugStudioHolding", Upvalue1 )

    while Upvalue4:GetAttribute( "DebugStudioShot" ) == Upvalue1 do
        if Upvalue5 then
            break
        end

        local Clamp = math.clamp( tonumber( Upvalue4:GetAttribute( "DebugStudioShotK" ) ) or 0, 0, 1 )
        Upvalue6( Argument3, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
        Upvalue3.RenderStepped:Wait( )
    end

    Upvalue4:SetAttribute( "DebugStudioHolding", nil )
    Upvalue7 = Upvalue7 + ( os.clock( ) - Clock )
end

local Clock2 = os.clock( ) - Upvalue7
Upvalue8( math.max( Argument2 - Clock2, 0.01 ), function( Argument1Inner, Argument2Inner )
    local Clamp = math.clamp( ( Clock2 + Argument2Inner - Argument1 ) / ( Argument2 - Argument1 ), 0, 1 )
    Upvalue6( Argument3, ( 0.8 * Clamp + 0.12732395447351627 * ( 1 - math.cos( 3.141592653589793 * Clamp ) ) ) / 1.0546479089470326 )
end )
]]

--[[
Function #142 has no emitted closure site
It is reproduced here so that nothing is lost

return Argument1 + ( Argument2 - Argument1 ) * Argument3
]]

--[[
Function #143 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Argument1.X + math.sin( Argument2 ) * Argument3
local Y = Upvalue1.Y + Argument4
return ( Vector3.new( X, Y, Argument1.Z + math.cos( Argument2 ) * Argument3 ) )
]]

--[[
Function #144 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 1.0821041362364843 + -0.593411945678072 * Amount
local Result2 = ( 5.6 + -1 * Amount ) * Upvalue2
local Y = Upvalue1.Y - Upvalue3.Y + ( -0.55 + 0.30000000000000004 * Amount )
local X = Upvalue1.X + math.sin( Result ) * Result2
local Y2 = Upvalue3.Y + Y
return ( Vector3.new( X, Y2, Upvalue1.Z + math.cos( Result ) * Result2 ) )
]]

--[[
Function #145 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = -0.5 + 0.2 * Amount
return Upvalue1 + Upvalue2( Result, 0.05, -0.9 + 0.4 * Amount ) * Upvalue3
]]

--[[
Function #146 has no emitted closure site
It is reproduced here so that nothing is lost

return 30 + -3 * Amount
]]

--[[
Function #147 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 3.5 + -2.5 * Amount ) )
]]

--[[
Function #148 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #149 has no emitted closure site
It is reproduced here so that nothing is lost

while os.clock( ) - Upvalue1 < 5.9 do
    if Upvalue2 then
        return
    end

    Upvalue3.RenderStepped:Wait( )
end

local Value1 = nil

for Key, Value in Upvalue4, nil, nil do
    Value.level = 0
end

Upvalue5 = 0
Upvalue6 = "off"
]]

--[[
Function #150 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 1.8325957145940461 + -0.6108652381980155 * Amount
local Result2 = ( 7.2 + -1.2000000000000002 * Amount ) * Upvalue2
local Y = Upvalue1.Y - Upvalue3.Y + ( -0.25 + 0.35 * Amount )
local X = Upvalue1.X + math.sin( Result ) * Result2
local Y2 = Upvalue3.Y + Y
return ( Vector3.new( X, Y2, Upvalue1.Z + math.cos( Result ) * Result2 ) )
]]

--[[
Function #151 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 0.45 + 0.10000000000000003 * Amount
return Upvalue1 + Upvalue2( -0.2, Result, -0.3 + 0.7 * Amount ) * Upvalue3
]]

--[[
Function #152 has no emitted closure site
It is reproduced here so that nothing is lost

return 38 + -4 * Amount
]]

--[[
Function #153 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -2.5 + 2.5 * Amount ) )
]]

--[[
Function #154 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #155 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 0.6632251157578453 + 0.3141592653589793 * Amount
local Result2 = ( 8 + -1.4000000000000004 * Amount ) * Upvalue2
local Y = Upvalue3.Y - Upvalue4.Y + ( -0.35 + 0.19999999999999998 * Amount ) * Upvalue2
local X = Upvalue1.X + math.sin( Result ) * Result2
local Y2 = Upvalue4.Y + Y
return ( Vector3.new( X, Y2, Upvalue1.Z + math.cos( Result ) * Result2 ) )
]]

--[[
Function #156 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = -1.6 + 0.7000000000000001 * Amount
local Result2 = -0.2 + -0.14999999999999997 * Amount
return Upvalue1 + Upvalue2( Result, Result2, 0.6 + -0.39999999999999997 * Amount ) * Upvalue3
]]

--[[
Function #157 has no emitted closure site
It is reproduced here so that nothing is lost

return 40 + -4 * Amount
]]

--[[
Function #158 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -2.5 + 2.5 * Amount ) )
]]

--[[
Function #159 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #160 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = -2.6179938779914944 + 0.3839724354387526 * Amount
local Result2 = ( 17 + -4.5 * Amount ) * Upvalue2
local Result3 = -1.5 + 1 * Amount + Upvalue3 * 0.4
local X = Upvalue1.X + math.sin( Result ) * Result2
local Y = Upvalue1.Y + Result3
return ( Vector3.new( X, Y, Upvalue1.Z + math.cos( Result ) * Result2 ) )
]]

--[[
Function #161 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = -0.4 + 0.5 * Amount
return Upvalue1 + Vector3.new( 0, Result, -1 + 1 * Amount )
]]

--[[
Function #162 has no emitted closure site
It is reproduced here so that nothing is lost

return 58 + -6 * Amount
]]

--[[
Function #163 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 6 + -6 * Amount ) )
]]

--[[
Function #164 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #165 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1 + ( 7 - math.sin( 3.141592653589793 * Amount ) * 0.8 ) * Upvalue2
local Captured2 = -1 + Upvalue3 * 0.3
return Upvalue5 + Vector3.new( Captured, Captured2, ( -7.5 + 14 * Amount ) * Upvalue4 )
]]

--[[
Function #166 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1 * 0.3
local Captured2 = Upvalue2 * 0.3
local Result = ( -7.5 + 14 * Amount + 3 ) * Upvalue3
return Upvalue5 + Vector3.new( Captured, Captured2, ( math.clamp( Result, -Upvalue4, Upvalue4 ) ) )
]]

--[[
Function #167 has no emitted closure site
It is reproduced here so that nothing is lost

return 46
]]

--[[
Function #168 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -1.5 + 3 * Amount ) )
]]

--[[
Function #169 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue3 + Vector3.new( Upvalue1, -0.2, ( -7.5 + 14 * Amount ) * Upvalue2 )
]]

--[[
Function #170 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 0.4886921905584123 + -0.4188790204786391 * Amount
local Result2 = ( 11.5 + -4.7 * Amount ) * Upvalue2
local Captured = Upvalue3 + ( 5.2 + -2.4000000000000004 * Amount )
local X = Upvalue1.X + math.sin( Result ) * Result2
local Y = Upvalue1.Y + Captured
return ( Vector3.new( X, Y, Upvalue1.Z + math.cos( Result ) * Result2 ) )
]]

--[[
Function #171 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 0.5 + -0.09999999999999998 * Amount + Upvalue1 * 0.5
return Upvalue3 + Vector3.new( 0, Result, ( 4.5 + -4 * Amount ) * Upvalue2 )
]]

--[[
Function #172 has no emitted closure site
It is reproduced here so that nothing is lost

return 50 + -6 * Amount
]]

--[[
Function #173 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( 0 + -2 * Amount ) )
]]

--[[
Function #174 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = 1 + Upvalue1 * 0.5
return Upvalue3 + Vector3.new( 0, Captured, 3 * Upvalue2 )
]]

--[[
Function #175 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = -3.4 + 6 * Amount
return Upvalue1 + Upvalue2( Result, -0.35 + 0.19999999999999998 * Amount, -5.8 ) * Upvalue3
]]

--[[
Function #176 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 + Upvalue2( -1.6 + 2.6 * Amount, -0.35, 0 ) * Upvalue3
]]

--[[
Function #177 has no emitted closure site
It is reproduced here so that nothing is lost

return 32
]]

--[[
Function #178 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Upvalue1( -1 + 2.5 * Amount ) )
]]

--[[
Function #179 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #180 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = 0.08726646259971647 + -0.13962634015954636 * Amount
local Min = math.min( Upvalue2 + 17, 25.5 )
local Min2 = Min + ( math.min( Upvalue2 + 10.5, 21 ) - Min ) * Amount
local Result2 = -0.9 + 0.4 * Amount + Upvalue3 * 0.5
local X = Upvalue1.X + math.sin( Result ) * Min2
local Y = Upvalue1.Y + Result2
return ( Vector3.new( X, Y, Upvalue1.Z + math.cos( Result ) * Min2 ) )
]]

--[[
Function #181 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue3 + Vector3.new( 0, -0.15 + 0.15 * Amount + Upvalue1 * 0.2 - Upvalue2 * 1.2, 0 )
]]

--[[
Function #182 has no emitted closure site
It is reproduced here so that nothing is lost

return 30 + 3 * Amount + Upvalue1 * 8
]]

--[[
Function #183 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #184 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
]]

--[[
Function #185 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { 0.2, 1, 0.2, 1 }
Value1 = nil

for Key, Value in Table, nil, nil do
    Upvalue1 = Value
    task.wait( 0.09 )
end
]]

--[[
Function #186 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = if Upvalue1:IsStudio( ) then tonumber( Upvalue2:GetAttribute( "DebugFinalT" ) ) or Amount else Amount
local Max3
local Clamp = math.clamp( Number / 12, 0, 1 )
local Clamp2 = 1 - ( 1 - Clamp ) * ( 1 - Clamp )
local Captured = Upvalue3 + 6.5
local Min = math.min( Upvalue3 + 16.3, 24.5 )
local Max = math.max( Number - 6, 0 )

if Max < 4 then
    local Max2 = Max * Max / 8

    if Max2 then
        Max3 = Max2
    else
        Max3 = Max - 2
    end
else
    Max3 = Max - 2
end

local Max4 = 0.05235987755982989 * Max3
local Captured2 = Captured + ( Min - Captured ) * Clamp2
local Sin = math.sin( Max4 ) * Captured2
local Captured3 = 0.1 + Upvalue4 * 0.3 + Clamp2 * 0.35
return CFrame.lookAt( Upvalue5 + Vector3.new( Sin, Captured3, math.cos( Max4 ) * Captured2 ), Upvalue5 + Vector3.new( 0, Clamp2 * 0.6 + -1.8 - Upvalue4 * 0.4, 0 ) ), Clamp2 * 6 + 46
]]

--[[
Function #187 has no emitted closure site
It is reproduced here so that nothing is lost

local Cf, Fov = Upvalue2( os.clock( ) - Upvalue3 )
Upvalue1.cf = Cf
Upvalue1.fov = Fov

if not Upvalue4 and Amount > 0.6 then
    Upvalue4 = true
    task.spawn( function()
        Upvalue5( Upvalue6, 0.4, { TextTransparency = 0 } )
        Upvalue7.Scale = 1.6
        Upvalue5( Upvalue7, 0.45, { Scale = 1 }, Enum.EasingStyle.Back )
        pcall( Upvalue8, Upvalue9, string.upper( Upvalue10 ), 0.6 )
        Upvalue11.Visible = true

        if Upvalue12.already then
            local Text2
            Upvalue13( Upvalue11, "Owned" )

            if ( Upvalue12.refund or 0 ) > 0 then
                local Text = "ALREADY OWNED +" .. Upvalue15( Upvalue12.refund )

                if Text then
                    Text2 = Text
                elseif Upvalue12.notGiven then
                    Text2 = "ALREADY OWNED"
                else
                    local OwnedText = Upvalue11:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
                    Text2 = OwnedText:gsub( "{refund}", Upvalue15( Upvalue12.refund or 0 ) )
                end
            elseif Upvalue12.notGiven then
                Text2 = "ALREADY OWNED"
            else
                local OwnedText = Upvalue11:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
                Text2 = OwnedText:gsub( "{refund}", Upvalue15( Upvalue12.refund or 0 ) )
            end

            Upvalue14.Text = Text2
        else
            Upvalue13( Upvalue11, "New" )
            Upvalue14.Text = Upvalue11:GetAttribute( "NewText" ) or "NEW VEHICLE!"
        end

        local UIScale2
        local UIScale = Upvalue11:FindFirstChildOfClass( "UIScale" )

        if UIScale then
            UIScale2 = UIScale
        else
            UIScale2 = Instance.new( "UIScale", Upvalue11 )
        end

        UIScale2.Scale = 0.5
        Upvalue5( UIScale2, 0.35, { Scale = 1 }, Enum.EasingStyle.Back )
    end )
    local Aura = Upvalue16.aura

    if Aura then
        local PlaybackSpeed
        local Speed = Aura:GetAttribute( "Speed" )
        PlaybackSpeed = if Speed then Speed else 1
        Aura.PlaybackSpeed = PlaybackSpeed
        Aura.TimePosition = 0
        Aura:Play( )
    end

    local AuraHit = Upvalue16.auraHit

    if AuraHit then
        local PlaybackSpeed2
        local Speed2 = AuraHit:GetAttribute( "Speed" )
        PlaybackSpeed2 = if Speed2 then Speed2 else 1
        AuraHit.PlaybackSpeed = PlaybackSpeed2
        AuraHit.TimePosition = 0
        AuraHit:Play( )
    end
    if Upvalue16.crowd then
        local PlaybackSpeed3
        Upvalue16.crowd.Volume = 0
        local Crowd = Upvalue16.crowd
        local Speed3 = Crowd:GetAttribute( "Speed" )
        PlaybackSpeed3 = if Speed3 then Speed3 else 1
        Crowd.PlaybackSpeed = PlaybackSpeed3
        Crowd.TimePosition = 0
        Crowd:Play( )
        Upvalue5( Upvalue16.crowd, 1.2, { Volume = 0.45 } )
    end

    local Shutter = Upvalue16.shutter

    if Shutter then
        local PlaybackSpeed4
        local Speed4 = Shutter:GetAttribute( "Speed" )
        PlaybackSpeed4 = if Speed4 then Speed4 else 1
        Shutter.PlaybackSpeed = PlaybackSpeed4
        Shutter.TimePosition = 0
        Shutter:Play( )
    end

    task.delay( 1.6, Upvalue17, "shutter", 1.1 )
end
]]

--[[
Function #188 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1( os.clock( ) - Upvalue2 )
]]

--[[
Function #189 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Upvalue2( Value, 0.8, { Volume = 0 } )
end
if Upvalue3 then
    Upvalue3:Stop( )
end

Upvalue4 = false
Upvalue5 = false
]]

-- Could not structure function #190

--[[
Function #191 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #192 has no emitted closure site
It is reproduced here so that nothing is lost

if Amount < 0.4 then
    local Result2

    if Upvalue2 then
        local Result = 8.8 * ( Amount / 0.4 ) * ( 1 - Amount / 0.4 )

        if Result then
            Result2 = Result
        else
            Result2 = 7 * ( 1 - ( Amount / 0.4 ) ^ 2 )
        end
    else
        Result2 = 7 * ( 1 - ( Amount / 0.4 ) ^ 2 )
    end

    Upvalue1 = Result2
elseif Amount < 1.1 then
    local Total = ( Amount - 0.4 ) / 0.7
    Upvalue1 = math.abs( ( math.sin( Total * 3.141592653589793 * 2 ) ) ) * 0.7 * ( 1 - Total ) ^ 1.5

    if not Upvalue3 then
        local PlaybackSpeed
        Upvalue3 = true
        Upvalue4.kick = math.max( Upvalue4.kick, 2.5 )
        local Speed = Upvalue5:GetAttribute( "Speed" )
        PlaybackSpeed = if Speed then Speed else 1
        Upvalue5.PlaybackSpeed = PlaybackSpeed
        Upvalue5.TimePosition = 0
        Upvalue5:Play( )
        local Captured = Upvalue7 + Vector3.new( 0, 0.10000000149011612, 0 )
        Upvalue6( Captured, Upvalue8:Lerp( Color3.new( 1, 1, 1 ), 0.3 ), 5, 15, 0.6, 0.15 )
        Upvalue9:Emit( 30 )
    end
else
    Upvalue1 = 0
end

local Number3

if Amount > 0.7 then
    local Number
    local Total2 = Amount - 0.7

    if Total2 < 0.12 then
        Number = 1
    elseif not ( Total2 > 0.24 ) or not ( Total2 < 0.36 ) then
        if Total2 > 0.5 then
            Number = 1
        else
            Number = 0
        end
    else
        Number = 1
    end

    Number3 = Number
else
    Number3 = 0
end

local Value1 = nil

for Key, Value in Upvalue10, nil, nil do
    local Number2 = not Value:IsA( "SpotLight" ) and 2 or 5
    Value.Brightness = Number3 * Number2
end

local Clamp3
local Clamp = math.clamp( Argument1, 0, 1 )

if Clamp < 0.5 then
    local Clamp2 = 4 * Clamp ^ 3

    if Clamp2 then
        Clamp3 = Clamp2
    else
        Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
    end
else
    Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
end

local Sin = math.sin( Clamp3 * 3.141592653589793 ) * 0.06 + -0.15
local Captured2 = Upvalue11 - 2 * Clamp3
local Captured3 = Upvalue12 - 1.2
local Captured4 = Upvalue13 + Sin
local Sin2 = math.sin( Captured4 ) * Captured2
local LookAt = CFrame.lookAt( Upvalue7 + Vector3.new( Sin2, Captured3, math.cos( Captured4 ) * Captured2 ), Upvalue7 + Vector3.new( 0, 2, 0 ) )
local Clamp4 = math.clamp( math.min( Amount / 0.6, 1 ), 0, 1 )
Upvalue4.cf = Upvalue14:Lerp( LookAt, Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 ) )
Upvalue4.fov = 55 - math.sin( Clamp3 * 3.141592653589793 ) * 4
Upvalue15 = 0.75
Upvalue16.TintColor = Color3.new( 1, 1, 1 ):Lerp( Upvalue8, math.sin( Amount * 6 ) * 0.06 + 0.12 )

if not Upvalue17 and Amount > 0.35 then
    Upvalue17 = true
    task.spawn( function()
        Upvalue18( Upvalue19, 0.4, { TextTransparency = 0 } )
        Upvalue20.Scale = 1.6
        Upvalue18( Upvalue20, 0.45, { Scale = 1 }, Enum.EasingStyle.Back )
        pcall( Upvalue21, Upvalue22, string.upper( Upvalue23 ), 0.6 )
        Upvalue24.Visible = true

        if Upvalue25.already then
            local Text2
            Upvalue26( Upvalue24, "Owned" )

            if ( Upvalue25.refund or 0 ) > 0 then
                local Text = "ALREADY OWNED +" .. Upvalue28( Upvalue25.refund )

                if Text then
                    Text2 = Text
                elseif Upvalue25.notGiven then
                    Text2 = "ALREADY OWNED"
                else
                    local OwnedText = Upvalue24:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
                    Text2 = OwnedText:gsub( "{refund}", Upvalue28( Upvalue25.refund or 0 ) )
                end
            elseif Upvalue25.notGiven then
                Text2 = "ALREADY OWNED"
            else
                local OwnedText = Upvalue24:GetAttribute( "OwnedText" ) or "DUPLICATE · ADDED TO INVENTORY"
                Text2 = OwnedText:gsub( "{refund}", Upvalue28( Upvalue25.refund or 0 ) )
            end

            Upvalue27.Text = Text2
        else
            Upvalue26( Upvalue24, "New" )
            Upvalue27.Text = Upvalue24:GetAttribute( "NewText" ) or "NEW VEHICLE!"
        end

        local UIScale2
        local UIScale = Upvalue24:FindFirstChildOfClass( "UIScale" )

        if UIScale then
            UIScale2 = UIScale
        else
            UIScale2 = Instance.new( "UIScale", Upvalue24 )
        end

        UIScale2.Scale = 0.5
        Upvalue18( UIScale2, 0.35, { Scale = 1 }, Enum.EasingStyle.Back )
    end )
end
]]

--[[
Function #193 has no emitted closure site
It is reproduced here so that nothing is lost

-- empty function
]]

--[[
Function #194 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = "close"
]]

--[[
Function #195 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = "close"
]]

--[[
Function #196 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
Upvalue2:Disconnect( )
]]

--[[
Function #197 has no emitted closure site
It is reproduced here so that nothing is lost

local Cf, Fov = Upvalue2( )
Upvalue1.cf = Cf
Upvalue1.fov = Fov
]]

--[[
Function #198 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp3
local Clamp = math.clamp( Argument1, 0, 1 )

if Clamp < 0.5 then
    local Clamp2 = 4 * Clamp ^ 3

    if Clamp2 then
        Clamp3 = Clamp2
    else
        Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
    end
else
    Clamp3 = 1 - ( -2 * Clamp + 2 ) ^ 3 / 2
end

local Value1
Upvalue1.cf = Upvalue2:Lerp( Upvalue3, Clamp3 )
Upvalue1.fov = 55 + 15 * Clamp3
Upvalue4 = 0.75 * ( 1 - Clamp3 )
Upvalue5 = Upvalue6 * ( 1 - Clamp3 )
Upvalue7.Saturation = 0.15 * ( 1 - Clamp3 )
local TintColor = Upvalue7.TintColor
Upvalue7.TintColor = TintColor:Lerp( Color3.new( 1, 1, 1 ), Clamp3 )
Value1 = nil

for Key, Value in Upvalue8, nil, nil do
    Value.Enabled = false
end

Upvalue9.Enabled = false
]]
