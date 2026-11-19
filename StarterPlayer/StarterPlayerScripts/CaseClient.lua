-- StarterPlayer.StarterPlayerScripts.CaseClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Storage = { }
local ContentProvider = game:GetService( "ContentProvider" )
local Debris = game:GetService( "Debris" )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Parent = game:GetService( "SoundService" )
local TweenService = game:GetService( "TweenService" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local ItemRender = require( Weapons:WaitForChild( "ItemRender" ) )
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local WeaponCases = require( ReplicatedStorage:WaitForChild( "WeaponCases" ) )
local AttachmentCases = require( ReplicatedStorage:WaitForChild( "AttachmentCases" ) )
local ModCatalog = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ModCatalog" ) )
local WeaponMods = ReplicatedStorage:WaitForChild( "WeaponMods" )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local RollSkip = require( ReplicatedStorage:WaitForChild( "RollSkip" ) )
local OpenCase = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "OpenCase" )
local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "MythicReveal", 10 ) )

if not Success then
    Result = nil
end

local Value1
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Table = { }

local function Sound( Text, Volume )
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. Text
    Sound.Volume = Volume
    Sound:SetAttribute( "CaseSound", true )
    Sound.Parent = Parent
    Table[ Sound ] = Volume
    return Sound
end

local Sound2 = Instance.new( "Sound" )
Sound2.SoundId = "rbxassetid://" .. 93076868992220
Sound2.Volume = 0.67
Sound2:SetAttribute( "CaseSound", true )
Sound2.Parent = Parent
Table[ Sound2 ] = 0.67
local Sound3 = Instance.new( "Sound" )
Sound3.SoundId = "rbxassetid://" .. 113309821562539
Sound3.Volume = 1.2
Sound3:SetAttribute( "CaseSound", true )
Sound3.Parent = Parent
Table[ Sound3 ] = 1.2
local Sound4 = Instance.new( "Sound" )
Sound4.SoundId = "rbxassetid://" .. 140635119444127
Sound4.Volume = 1.6
Sound4:SetAttribute( "CaseSound", true )
Sound4.Parent = Parent
Table[ Sound4 ] = 1.6
local Sound5 = Instance.new( "Sound" )
Sound5.SoundId = "rbxassetid://" .. 82758229356190
Sound5.Volume = 0.3
Sound5:SetAttribute( "CaseSound", true )
Sound5.Parent = Parent
Table[ Sound5 ] = 0.3
local Sound6 = Instance.new( "Sound" )
Sound6.SoundId = "rbxassetid://" .. 9126228631
Sound6.Volume = 0.5
Sound6:SetAttribute( "CaseSound", true )
Sound6.Parent = Parent
Table[ Sound6 ] = 0.5
local Sound7 = Instance.new( "Sound" )
Sound7.SoundId = "rbxassetid://" .. 104157091834980
Sound7.Volume = 1
Sound7:SetAttribute( "CaseSound", true )
Sound7.Parent = Parent
Table[ Sound7 ] = 1
local Sound8 = Instance.new( "Sound" )
Sound8.SoundId = "rbxassetid://" .. 166047422
Sound8.Volume = 1.1
Sound8:SetAttribute( "CaseSound", true )
Sound8.Parent = Parent
Table[ Sound8 ] = 1.1
local Sound9 = Instance.new( "Sound" )
Sound9.SoundId = "rbxassetid://" .. 9126102694
Sound9.Volume = 0.5
Sound9:SetAttribute( "CaseSound", true )
Sound9.Parent = Parent
Table[ Sound9 ] = 0.5
local Sound10 = Instance.new( "Sound" )
Sound10.SoundId = "rbxassetid://" .. 9126009571
Sound10.Volume = 0.9
Sound10:SetAttribute( "CaseSound", true )
Sound10.Parent = Parent
Table[ Sound10 ] = 0.9
local Sound11 = Instance.new( "Sound" )
Sound11.SoundId = "rbxassetid://" .. 95619349451044
Sound11.Volume = 0.7
Sound11:SetAttribute( "CaseSound", true )
Sound11.Parent = Parent
Table[ Sound11 ] = 0.7
local Sound12 = Instance.new( "Sound" )
Sound12.SoundId = "rbxassetid://" .. 109541594740226
Sound12.Volume = 0.65
Sound12:SetAttribute( "CaseSound", true )
Sound12.Parent = Parent
Table[ Sound12 ] = 0.65
local Sound13 = Instance.new( "Sound" )
Sound13.SoundId = "rbxassetid://" .. 9126009571
Sound13.Volume = 0.3
Sound13:SetAttribute( "CaseSound", true )
Sound13.Parent = Parent
Table[ Sound13 ] = 0.3
local Sound14 = Instance.new( "Sound" )
Sound14.SoundId = "rbxassetid://" .. 137131055688140
Sound14.Volume = 1
Sound14:SetAttribute( "CaseSound", true )
Sound14.Parent = Parent
Table[ Sound14 ] = 1
local Sound15 = Instance.new( "Sound" )
Sound15.SoundId = "rbxassetid://" .. 133743196377753
Sound15.Volume = 0.55
Sound15:SetAttribute( "CaseSound", true )
Sound15.Parent = Parent
Table[ Sound15 ] = 0.55
local Sound16 = Instance.new( "Sound" )
Sound16.SoundId = "rbxassetid://" .. 85953550219863
Sound16.Volume = 0.7
Sound16:SetAttribute( "CaseSound", true )
Sound16.Parent = Parent
Table[ Sound16 ] = 0.7
local Sound17 = Instance.new( "Sound" )
Sound17.SoundId = "rbxassetid://" .. 88975449185829
Sound17.Volume = 0.85
Sound17:SetAttribute( "CaseSound", true )
Sound17.Parent = Parent
Table[ Sound17 ] = 0.85
local Sound18 = Instance.new( "Sound" )
Sound18.SoundId = "rbxassetid://" .. 87153286298561
Sound18.Volume = 1
Sound18:SetAttribute( "CaseSound", true )
Sound18.Parent = Parent
Table[ Sound18 ] = 1
local Sound19 = Instance.new( "Sound" )
Sound19.SoundId = "rbxassetid://" .. 87679073738459
Sound19.Volume = 1
Sound19:SetAttribute( "CaseSound", true )
Sound19.Parent = Parent
Table[ Sound19 ] = 1
local Table2 = {
    common = Sound15,
    uncommon = Sound16,
    rare = Sound17,
    epic = Sound18,
    legendary = Sound14,
    mythical = Sound19
}
Table2.secret = Table2.mythical
local Table3 = { }
Value1 = nil

for Key, Value in Table2, nil, nil do
    Table3[ Key ] = Value.Volume
end

local UIScale2
local StarterGui = game:GetService( "StarterGui" )
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
local ScaleUI = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ScaleUI" ) )

local function Template( Text )
    local Get = Screens.Get( Text, 30 )

    if not Get then
        error( "[CaseClient] StarterGui." .. Text .. " introuvable : l'interface des caisses est dans StarterGui", 0 )
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
        error( ( "[CaseClient] %s : élément « %s » (%s) introuvable, il est nécessaire" ):format( Self:GetFullName( ), Name, ClassName ), 0 )
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

local function ScaleOf( Object )
    local UIScale2
    local UIScale = Object:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        UIScale2 = UIScale
    else
        UIScale2 = Instance.new( "UIScale" )
    end

    return UIScale2, UIScale2.Scale
end

local function SetState( Self, Argument2 )
    local Value1, Value2
    Value1 = nil
    Value2 = nil

    for Key, Value in Self:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            Value2 = Value2 or Value

            if Value.Name == Argument2 then
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

local Table4 = { }

local function TileShape( ShapeName )
    if not Table4[ ShapeName ] then
        local Entry2
        local Entry = ItemRender.TILE_GRAD[ ShapeName ]
        Entry2 = if Entry then Entry else ItemRender.TILE_GRAD.common
        local Keypoints = Entry2.Keypoints
        local Value = Keypoints[ 1 ].Value
        local Value2 = Keypoints[ #Keypoints ].Value
        Table4[ ShapeName ] = ColorSequence.new( {
            ColorSequenceKeypoint.new( 0, Value2 ),
            ColorSequenceKeypoint.new( 0.51, Value ),
            ColorSequenceKeypoint.new( 1, Value2 )
        } )
    end

    return Table4[ ShapeName ]
end

local Template2 = Template( "CaseMenu" )
Template2.Visible = false
local Need2 = Need( Template2, "Panel", "GuiObject" )
local UIScale = Need2:FindFirstChildOfClass( "UIScale" )

if UIScale then
    UIScale2 = UIScale
else
    UIScale2 = Instance.new( "UIScale" )
end

local Frame
local Scale = UIScale2.Scale
local Need3 = Need( Template2, "Close", "GuiButton" )
local Tile = Template2:FindFirstChild( "Tile", true )

if not Tile or not Tile:IsA( "GuiObject" ) then
    Frame = Instance.new( "Frame" )
else
    Frame = Tile
end

local ImageLabel
local Icon = Frame:FindFirstChild( "Icon", true )

if not Icon or not Icon:IsA( "ImageLabel" ) then
    ImageLabel = Instance.new( "ImageLabel" )
else
    ImageLabel = Icon
end

local TextLabel
local CaseName = Template2:FindFirstChild( "CaseName", true )

if not CaseName or not CaseName:IsA( "TextLabel" ) then
    TextLabel = Instance.new( "TextLabel" )
else
    TextLabel = CaseName
end

local TextLabel2
local Price = Template2:FindFirstChild( "Price", true )

if not Price or not Price:IsA( "TextLabel" ) then
    TextLabel2 = Instance.new( "TextLabel" )
else
    TextLabel2 = Price
end

local TextLabel3
local Description = Template2:FindFirstChild( "Description", true )

if not Description or not Description:IsA( "TextLabel" ) then
    TextLabel3 = Instance.new( "TextLabel" )
else
    TextLabel3 = Description
end

local TextLabel4
local Text = TextLabel3.Text
local Need4 = Need( Template2, "Open", "GuiButton" )
local Text2 = Need4:FindFirstChild( "Text", true )

if not Text2 or not Text2:IsA( "TextLabel" ) then
    TextLabel4 = Instance.new( "TextLabel" )
else
    TextLabel4 = Text2
end

local TextLabel5
local Text3 = TextLabel4.Text
local Status = Template2:FindFirstChild( "Status", true )

if not Status or not Status:IsA( "TextLabel" ) then
    TextLabel5 = Instance.new( "TextLabel" )
else
    TextLabel5 = Status
end

local Frame2
TextLabel5.Text = ""
local Template3 = Template( "CaseFX" )
Template3.Visible = false
local Template4 = Template( "CaseToast" )
Template4.Visible = false
local Table5 = { }
local Config = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Tutorial" ):WaitForChild( "Config" ) )

local function TutoRoll()
    local Entry2
    local InTutorial = game:GetService( "Players" ).LocalPlayer:GetAttribute( "InTutorial" )

    if InTutorial then
        local Entry = Config.Rolls[ InTutorial ]

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

local function ChoicesOf( Name )
    local CaseChoices

    if Name then
        CaseChoices = Name:GetAttribute( "CaseChoices" )
    else
        CaseChoices = Name
    end
    if type( CaseChoices ) ~= "string" or CaseChoices == "" then
        return nil
    end

    local Entry2
    local Split = string.split( CaseChoices, "," )
    local InTutorial = game:GetService( "Players" ).LocalPlayer:GetAttribute( "InTutorial" )

    if InTutorial then
        local Entry = Config.Rolls[ InTutorial ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = nil
        end
    else
        Entry2 = nil
    end
    if Entry2 and table.find( Split, Entry2.Case ) then
        return { Entry2.Case }
    end
    if game:GetService( "Players" ).LocalPlayer:GetAttribute( "InTutorial" ) then
        return { Split[ 1 ] }
    end
    return Split
end

local function CaseIdOf( Name )
    local ChoicesOf2 = ChoicesOf( Name )

    if ChoicesOf2 then
        local Entry2
        local Entry = Table5[ Name ]
        Entry2 = if Entry then Entry else ChoicesOf2[ 1 ]
        return Entry2
    end
    return Name and Name:GetAttribute( "CaseId" )
end

local function CaseInfo( InfoName )
    local Entry2
    local Entry = AttachmentCases.INFO[ InfoName ]
    Entry2 = if Entry then Entry else WeaponCases.INFO[ InfoName ]
    return Entry2
end

local function InfoOf( Name, Attribute )
    local Entry3
    local ChoicesOf2 = ChoicesOf( Name )

    if ChoicesOf2 then
        local Item
        local ChoicesOf3 = ChoicesOf( Name )

        if ChoicesOf3 then
            local Entry = Table5[ Name ]

            if Entry then
                Item = Entry
            else
                Item = ChoicesOf3[ 1 ]
            end
        elseif Name then
            Item = Name:GetAttribute( "CaseId" )
        else
            Item = Name
        end

        local Entry2 = AttachmentCases.INFO[ Item ]

        if Entry2 then
            Entry3 = Entry2
        else
            Entry3 = WeaponCases.INFO[ Item ]
        end
    else
        Entry3 = ChoicesOf2
    end
    if Entry3 and Entry3[ Attribute ] ~= nil then
        return Entry3[ Attribute ]
    end

    return Name and Name:GetAttribute( Attribute )
end

local Choices = Template2:FindFirstChild( "Choices", true )

if not Choices or not Choices:IsA( "GuiObject" ) then
    Frame2 = Instance.new( "Frame" )
else
    Frame2 = Choices
end

local Table6 = { }
local I = 1

for I = 1, 8 do
    local FoundChild = Frame2:FindFirstChild( "Choice" .. I )

    if FoundChild and FoundChild:IsA( "GuiButton" ) then
        Table6[ I ] = FoundChild
    end
end

local CamoPicker = Template2:FindFirstChild( "CamoPicker", true )
local Table7 = { }

if CamoPicker then
    for Key2, Value2 in CamoPicker:GetDescendants( ) do
        if Value2:IsA( "GuiButton" ) and type( Value2:GetAttribute( "CaseId" ) ) == "string" then
            Table7[ Value2:GetAttribute( "CaseId" ) ] = Value2
        end
    end
end

local Odds

local function RowIdsOf( Name )
    local ChoicesOf2 = ChoicesOf( Name )

    if not ChoicesOf2 then
        return nil
    end

    local Value2
    local Table = { }
    Value2 = nil

    for Key, Value in ChoicesOf2, nil, nil do
        if not Table7[ Value ] then
            table.insert( Table, Value )
        end
    end

    return Table
end

local DisplayModel = nil
local ItemThumb = nil
local CamoSwatch = nil
local TierKey = nil
local Flag = false
local Value3 = nil
local Value4 = nil
local Flag2 = false
local Flag3 = false
local OddsBox = Need2:FindFirstChild( "OddsBox" )

if OddsBox then
    Odds = OddsBox:FindFirstChild( "Odds", true )
else
    Odds = OddsBox
end

local OddRow

if Odds then
    OddRow = Odds:FindFirstChild( "OddRow" )
else
    OddRow = Odds
end
if OddRow then
    OddRow.Parent = nil
end

local Value6
local Value5 = nil

local function ChanceText( Amount )
    if not ( Amount >= 1 ) or Amount ~= math.floor( Amount ) then
        return string.format( "%.6f", Amount ):gsub( "0+$", "" ):gsub( "%.$", "" ) .. "%"
    end
    return string.format( "%d%%", Amount )
end

local function OddsTop()
    if not Odds then
        return
    end

    local Value1
    Odds.CanvasPosition = Vector2.zero
    local Table = { 0.05, 0.2 }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        task.delay( Value, function()
            Odds.CanvasPosition = Vector2.zero
        end )
    end
end

local function ShownKeys( List )
    local Entry2

    if List then
        local Entry = AttachmentCases.CASES[ List ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = WeaponCases.Table( List )
        end
    else
        Entry2 = List
    end
    if not Entry2 then
        return nil
    end

    local Flag2
    local Table = { }

    if ReplicatedStorage:GetAttribute( "NoMythicWeapons" ) == true then
        if WeaponCases.ODDS[ List ] == nil then
            Flag2 = false
        else
            Flag2 = true
        end
    else
        Flag2 = false
    end

    local IsCase

    if ReplicatedStorage:GetAttribute( "NoMythicRolls" ) == true then
        IsCase = AttachmentCases.IsCase( List )
    else
        IsCase = false
    end

    local Value1 = nil

    for Key, Value in Entry2, nil, nil do
        local Flag
        local Entry3 = ItemRender.RARITY[ Key ]

        if Flag2 then
            if Entry3 == "mythical" then
                Flag = true
            elseif Entry3 == "super" then
                Flag = true
            elseif Entry3 == "secret" then
                Flag = true
            elseif IsCase then
                if AttachmentCases.Tier( Key ) == "mythical" then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = IsCase
            end
        elseif IsCase then
            if AttachmentCases.Tier( Key ) == "mythical" then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = IsCase
        end
        if Value > 0 and not Flag then
            table.insert( Table, Key )
        end
    end

    table.sort( Table, function( Key, Key2 )
        if Entry2[ Key ] == Entry2[ Key2 ] then
            local Flag2 = Key < Key2 and true or false
            return Flag2
        end
        local Flag
        local Entry = Entry2[ Key ]
        Flag = Entry2[ Key2 ] < Entry and true or false
        return Flag
    end )
    return Table
end

local function LosableMythic( MythicName )
    if ReplicatedStorage:GetAttribute( "MythicLosable" ) ~= true or type( MythicName ) ~= "string" or AttachmentCases.Split( MythicName ) ~= nil then
        return false
    end

    local Flag
    local Entry = ItemRender.RARITY[ MythicName ]

    if Entry == "mythical" then
        Flag = true
    elseif Entry == "super" then
        Flag = true
    elseif Entry == "secret" then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function FillOdds( List )
    if not OddsBox or not Odds or not OddRow then
        return
    end

    local Entry2

    if List then
        local Entry = AttachmentCases.CASES[ List ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = WeaponCases.Table( List )
        end
    else
        Entry2 = List
    end

    local Visible = Entry2 ~= nil and true or false
    OddsBox.Visible = Visible

    if not Entry2 or Value5 == List then
        return
    end

    Value5 = List

    for Key, Value in Odds:GetChildren( ) do
        if Value:IsA( "GuiObject" ) then
            Value:Destroy( )
        end
    end

    local ShownKeys2 = ShownKeys( List )
    local Table = { }

    if ReplicatedStorage:GetAttribute( "NoMythicWeapons" ) == true and WeaponCases.ODDS[ List ] ~= nil then
        local Value2 = nil

        for Key2, Value3 in Entry2, nil, nil do
            local Entry3 = ItemRender.RARITY[ Key2 ]

            if Value3 > 0 then
                if Entry3 == "mythical" or Entry3 == "super" or Entry3 == "secret" then
                    Table[ Key2 ] = true
                    table.insert( ShownKeys2, Key2 )
                end
            end
        end

        local Value4, Number
        local Count = #ShownKeys2
        Value4 = nil
        Number = 0

        for Value5Inner in Table, nil, nil do
            Number = Number + 1
        end

        local Count2 = Count - Number + 1
        local Table2 = { }
        local Count3 = #ShownKeys2
        local I = Count2

        for I = Count2, Count3 do
            table.insert( Table2, ShownKeys2[ I ] )
        end

        local Value6
        table.sort( Table2 )
        Value6 = nil

        for Key3, Value7 in Table2, nil, nil do
            ShownKeys2[ Count2 + Key3 - 1 ] = Value7
        end
    end

    local Value8, Flag, Flag2
    Value8 = nil
    Flag = false
    Flag2 = false

    for Key4, Value9 in ShownKeys2, nil, nil do
        local Text2
        local Clone2 = OddRow:Clone( )
        Clone2.Visible = true
        Clone2.LayoutOrder = Key4

        if TierKey then
            local TierKey2 = TierKey( Value9 )

            if TierKey2 then
                Text2 = TierKey2
            else
                Text2 = "common"
            end
        else
            Text2 = "common"
        end
        if Text2 == "super" then
            Text2 = "mythical"
        end

        local Entry5
        local Entry4 = ItemRender.TILE_GRAD[ Text2 ]

        if Entry4 then
            Entry5 = Entry4
        elseif Text2 == "mythical" then
            local Super = ItemRender.TILE_GRAD.super

            if Super then
                Entry5 = Super
            else
                Entry5 = ItemRender.TILE_GRAD.common
            end
        else
            Entry5 = ItemRender.TILE_GRAD.common
        end

        local FoundChild2
        local BackgroundColor3 = Entry5.Keypoints[ 1 ].Value
        local FoundChild = game:GetService( "StarterPack" ):FindFirstChild( Value9 )

        if FoundChild then
            FoundChild2 = FoundChild
        else
            local BetaRollWeapons2
            local BetaRollWeapons = ReplicatedStorage:FindFirstChild( "BetaRollWeapons" )
            BetaRollWeapons2 = if BetaRollWeapons then BetaRollWeapons:FindFirstChild( Value9 ) else BetaRollWeapons
            FoundChild2 = BetaRollWeapons2
        end

        local Text3

        if AttachmentCases.Split( Value9 ) then
            local Name = AttachmentCases.Name( Value9 )

            if Name then
                Text3 = Name
            elseif WeaponData[ Value9 ] then
                local Name2 = WeaponData[ Value9 ].Name

                if Name2 then
                    Text3 = Name2
                elseif not FoundChild2 or not FoundChild2:GetAttribute( "Melee" ) or not FoundChild2:GetAttribute( "DisplayName" ) then
                    if WeaponCases.UPCOMING then
                        local Entry6 = WeaponCases.UPCOMING[ Value9 ]

                        if Entry6 then
                            Text3 = Entry6
                        else
                            Text3 = Value9
                        end
                    else
                        Text3 = Value9
                    end
                else
                    Text3 = FoundChild2:GetAttribute( "DisplayName" )
                end
            elseif not FoundChild2 or not FoundChild2:GetAttribute( "Melee" ) or not FoundChild2:GetAttribute( "DisplayName" ) then
                if WeaponCases.UPCOMING then
                    local Entry6 = WeaponCases.UPCOMING[ Value9 ]

                    if Entry6 then
                        Text3 = Entry6
                    else
                        Text3 = Value9
                    end
                else
                    Text3 = Value9
                end
            else
                Text3 = FoundChild2:GetAttribute( "DisplayName" )
            end
        elseif WeaponData[ Value9 ] then
            local Name2 = WeaponData[ Value9 ].Name

            if Name2 then
                Text3 = Name2
            elseif not FoundChild2 or not FoundChild2:GetAttribute( "Melee" ) or not FoundChild2:GetAttribute( "DisplayName" ) then
                if WeaponCases.UPCOMING then
                    local Entry6 = WeaponCases.UPCOMING[ Value9 ]

                    if Entry6 then
                        Text3 = Entry6
                    else
                        Text3 = Value9
                    end
                else
                    Text3 = Value9
                end
            else
                Text3 = FoundChild2:GetAttribute( "DisplayName" )
            end
        elseif not FoundChild2 or not FoundChild2:GetAttribute( "Melee" ) or not FoundChild2:GetAttribute( "DisplayName" ) then
            if WeaponCases.UPCOMING then
                local Entry6 = WeaponCases.UPCOMING[ Value9 ]

                if Entry6 then
                    Text3 = Entry6
                else
                    Text3 = Value9
                end
            else
                Text3 = Value9
            end
        else
            Text3 = FoundChild2:GetAttribute( "DisplayName" )
        end

        local ItemName2 = Clone2:FindFirstChild( "ItemName" )
        local Rarity2 = Clone2:FindFirstChild( "Rarity" )
        local Chance2 = Clone2:FindFirstChild( "Chance" )
        local RarityBar2 = Clone2:FindFirstChild( "RarityBar" )

        if ItemName2 then
            ItemName2.Text = Text3
        end
        if Rarity2 then
            Rarity2.Text = string.upper( Text2 )
            Rarity2.TextColor3 = ItemRender.TextColor( Text2 )
        end
        if Chance2 then
            Chance2.Text = ChanceText( Entry2[ Value9 ] )
        end
        if RarityBar2 then
            RarityBar2.BackgroundColor3 = BackgroundColor3
        end
        if Rarity2 and not Table[ Value9 ] then
            local Flag3

            if ReplicatedStorage:GetAttribute( "MythicLosable" ) ~= true or type( Value9 ) ~= "string" or AttachmentCases.Split( Value9 ) ~= nil then
                Flag3 = false
            else
                local Entry7 = ItemRender.RARITY[ Value9 ]

                if Entry7 == "mythical" then
                    Flag3 = true
                elseif Entry7 == "super" then
                    Flag3 = true
                elseif Entry7 == "secret" then
                    Flag3 = true
                else
                    Flag3 = false
                end
            end
            if Flag3 then
                Rarity2.RichText = true
                Rarity2.Text = string.upper( Text2 ) .. " · <font color=\"#FF5A5A\">LOSABLE</font>"

                if Text2 == "secret" then
                    Flag = true
                    Flag2 = true
                else
                    Flag = true
                end
            end
        end
        if Table[ Value9 ] then
            if Chance2 then
                Chance2.Text = "UNAVAILABLE"
                Chance2.TextColor3 = Color3.fromRGB( 150, 150, 150 )
            end
            for Key5, Value11 in Clone2:GetDescendants( ) do
                if Value11:IsA( "TextLabel" ) then
                    Value11.TextTransparency = math.max( Value11.TextTransparency, 0.45 )
                end
            end
            if RarityBar2 then
                RarityBar2.BackgroundTransparency = math.max( RarityBar2.BackgroundTransparency, 0.6 )
            end
        end

        Clone2.Parent = Odds
    end
    if Flag then
        local Clone = OddRow:Clone( )
        Clone.Name = "LosableWarning"
        Clone.Visible = true
        Clone.LayoutOrder = 0
        local ItemName = Clone:FindFirstChild( "ItemName" )
        local Rarity = Clone:FindFirstChild( "Rarity" )
        local Chance = Clone:FindFirstChild( "Chance" )
        local RarityBar = Clone:FindFirstChild( "RarityBar" )

        if RarityBar then
            RarityBar.BackgroundColor3 = Color3.fromRGB( 255, 70, 70 )
        end
        if Chance then
            Chance.Visible = false
        end

        local UIAspectRatioConstraint = Clone:FindFirstChildOfClass( "UIAspectRatioConstraint" )

        if UIAspectRatioConstraint then
            UIAspectRatioConstraint.AspectRatio = UIAspectRatioConstraint.AspectRatio / 1.9
        end
        if ItemName then
            local Text = not Flag2 and "⚠ MYTHIC WEAPONS ARE LOSABLE" or "⚠ MYTHIC & SECRET WEAPONS ARE LOSABLE"
            ItemName.Text = Text
            ItemName.TextColor3 = Color3.fromRGB( 255, 90, 90 )
            ItemName.Position = UDim2.fromScale( ItemName.Position.X.Scale, 0.07 )
            ItemName.Size = UDim2.fromScale( 0.9, 0.34 )
        end
        if Rarity then
            Rarity.RichText = false
            Rarity.Text = "You drop it if you die in combat, unless it is in a protected slot"
            Rarity.TextColor3 = Color3.fromRGB( 235, 235, 235 )
            Rarity.TextWrapped = true
            Rarity.Position = UDim2.fromScale( Rarity.Position.X.Scale, 0.45 )
            Rarity.Size = UDim2.fromScale( 0.9, 0.48 )
        end

        Clone.Parent = Odds
    end

    OddsTop( )
end

local function Cost()
    local Entry2
    local InTutorial = game:GetService( "Players" ).LocalPlayer:GetAttribute( "InTutorial" )

    if InTutorial then
        local Entry = Config.Rolls[ InTutorial ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = nil
        end
    else
        Entry2 = nil
    end
    if Entry2 and Entry2.Free and Value3 then
        local Item
        local ChoicesOf2 = ChoicesOf( Value3 )

        if ChoicesOf2 then
            local Entry3 = Table5[ Value3 ]

            if Entry3 then
                Item = Entry3
            else
                Item = ChoicesOf2[ 1 ]
            end
        elseif Value3 then
            Item = Value3:GetAttribute( "CaseId" )
        else
            Item = Value3
        end
        if Item == Entry2.Case then
            return 0
        end
    end
    if Entry2 and tonumber( Entry2.Cost ) and Value3 then
        local Item2
        local ChoicesOf3 = ChoicesOf( Value3 )

        if ChoicesOf3 then
            local Entry4 = Table5[ Value3 ]

            if Entry4 then
                Item2 = Entry4
            else
                Item2 = ChoicesOf3[ 1 ]
            end
        elseif Value3 then
            Item2 = Value3:GetAttribute( "CaseId" )
        else
            Item2 = Value3
        end
        if Item2 == Entry2.Case then
            return ( tonumber( Entry2.Cost ) )
        end
    end

    local Cost

    if Value3 then
        local Entry7
        local ChoicesOf4 = ChoicesOf( Value3 )

        if ChoicesOf4 then
            local Item3
            local ChoicesOf5 = ChoicesOf( Value3 )

            if ChoicesOf5 then
                local Entry5 = Table5[ Value3 ]

                if Entry5 then
                    Item3 = Entry5
                else
                    Item3 = ChoicesOf5[ 1 ]
                end
            elseif Value3 then
                Item3 = Value3:GetAttribute( "CaseId" )
            else
                Item3 = Value3
            end

            local Entry6 = AttachmentCases.INFO[ Item3 ]

            if Entry6 then
                Entry7 = Entry6
            else
                Entry7 = WeaponCases.INFO[ Item3 ]
            end
        else
            Entry7 = ChoicesOf4
        end
        if not Entry7 or Entry7.Cost == nil then
            if Value3 then
                Cost = Value3:GetAttribute( "Cost" )
            else
                Cost = Value3
            end
        else
            Cost = Entry7.Cost
        end
        if not Cost then
            Cost = 0
        end
    else
        Cost = 0
    end

    return Cost
end

local function RefreshMenu()
    if not Value3 then
        return
    end

    local Entry3
    local ChoicesOf2 = ChoicesOf( Value3 )

    if ChoicesOf2 then
        local Item
        local ChoicesOf3 = ChoicesOf( Value3 )

        if ChoicesOf3 then
            local Entry = Table5[ Value3 ]

            if Entry then
                Item = Entry
            else
                Item = ChoicesOf3[ 1 ]
            end
        elseif Value3 then
            Item = Value3:GetAttribute( "CaseId" )
        else
            Item = Value3
        end

        local Entry2 = AttachmentCases.INFO[ Item ]

        if Entry2 then
            Entry3 = Entry2
        else
            Entry3 = WeaponCases.INFO[ Item ]
        end
    else
        Entry3 = ChoicesOf2
    end

    local DisplayName

    if not Entry3 or Entry3.DisplayName == nil then
        if Value3 then
            DisplayName = Value3:GetAttribute( "DisplayName" )
        else
            DisplayName = Value3
        end
    else
        DisplayName = Entry3.DisplayName
    end

    local Entry6
    TextLabel.Text = DisplayName or "Case"
    local ChoicesOf4 = ChoicesOf( Value3 )

    if ChoicesOf4 then
        local Item2
        local ChoicesOf5 = ChoicesOf( Value3 )

        if ChoicesOf5 then
            local Entry4 = Table5[ Value3 ]

            if Entry4 then
                Item2 = Entry4
            else
                Item2 = ChoicesOf5[ 1 ]
            end
        elseif Value3 then
            Item2 = Value3:GetAttribute( "CaseId" )
        else
            Item2 = Value3
        end

        local Entry5 = AttachmentCases.INFO[ Item2 ]

        if Entry5 then
            Entry6 = Entry5
        else
            Entry6 = WeaponCases.INFO[ Item2 ]
        end
    else
        Entry6 = ChoicesOf4
    end

    local TextInner

    if not Entry6 or Entry6.Description == nil then
        if Value3 then
            TextInner = Value3:GetAttribute( "Description" )
        else
            TextInner = Value3
        end
    else
        TextInner = Entry6.Description
    end
    if not TextInner then
        TextInner = Text
    end

    local Visible
    TextLabel3.Text = TextInner
    Flag = true
    local RowIdsOf2 = RowIdsOf( Value3 )

    if RowIdsOf2 == nil then
        Visible = false
    elseif #RowIdsOf2 > 0 then
        Visible = true
    else
        Visible = false
    end

    Frame2.Visible = Visible

    if CamoPicker then
        local Table
        local ChoicesOf6 = ChoicesOf( Value3 )
        Table = if ChoicesOf6 then ChoicesOf6 else { }
        local Item3
        local ChoicesOf7 = ChoicesOf( Value3 )

        if ChoicesOf7 then
            local Entry7 = Table5[ Value3 ]

            if Entry7 then
                Item3 = Entry7
            else
                Item3 = ChoicesOf7[ 1 ]
            end
        elseif Value3 then
            Item3 = Value3:GetAttribute( "CaseId" )
        else
            Item3 = Value3
        end

        local Value8, Visible2
        Value8 = nil
        Visible2 = false

        for Key, Value in Table7, nil, nil do
            local Visible3 = table.find( Table, Key ) ~= nil and true or false
            Value.Visible = Visible3
            Visible2 = Visible2 or Visible3

            if Visible3 then
                local Entry9
                local Entry8 = AttachmentCases.INFO[ Key ]

                if Entry8 then
                    Entry9 = Entry8
                else
                    Entry9 = WeaponCases.INFO[ Key ]
                end
                if not Entry9 then
                    Entry9 = { }
                end

                local CaseName = Value:FindFirstChild( "CaseName", true )
                local Price = Value:FindFirstChild( "Price", true )

                if CaseName and CaseName:IsA( "TextLabel" ) then
                    local Text2
                    local Short = Entry9.Short

                    if Short then
                        Text2 = Short
                    else
                        local DisplayName2 = Entry9.DisplayName

                        if DisplayName2 then
                            Text2 = DisplayName2
                        else
                            Text2 = Key
                        end
                    end

                    CaseName.Text = Text2
                end
                if Price and Price:IsA( "TextLabel" ) then
                    Price.Text = MoneyFormat( Entry9.Cost or 0 )
                end

                local Selected = Value:FindFirstChild( "Selected" )

                if Selected and Selected:IsA( "UIStroke" ) then
                    local Enabled = Key == Item3 and true or false
                    Selected.Enabled = Enabled
                end
            end
        end

        CamoPicker.Visible = Visible2
    end
    if RowIdsOf2 then
        local Item4
        local ChoicesOf8 = ChoicesOf( Value3 )

        if ChoicesOf8 then
            local Entry10 = Table5[ Value3 ]

            if Entry10 then
                Item4 = Entry10
            else
                Item4 = ChoicesOf8[ 1 ]
            end
        elseif Value3 then
            Item4 = Value3:GetAttribute( "CaseId" )
        else
            Item4 = Value3
        end

        local Scale2

        if Frame2:FindFirstChildOfClass( "UIListLayout" ) then
            local Scale = Frame2:FindFirstChildOfClass( "UIListLayout" ).Padding.Scale

            if Scale then
                Scale2 = Scale
            else
                Scale2 = 0.012
            end
        else
            Scale2 = 0.012
        end

        local Value10
        local Min = math.min( 0.24, ( 1 - Scale2 * ( #RowIdsOf2 - 1 ) ) / #RowIdsOf2 )
        Value10 = nil

        for Key2, Value11 in Table6, nil, nil do
            Value11.Size = UDim2.new( Min, 0, Value11.Size.Y.Scale, Value11.Size.Y.Offset )
        end

        local Value12 = nil

        for Key3, Value13 in Table6, nil, nil do
            local Visible4
            local Entry11 = RowIdsOf2[ Key3 ]
            Visible4 = Entry11 ~= nil and true or false
            Value13.Visible = Visible4

            if Entry11 then
                local Text3Inner = Value13:FindFirstChild( "Text" )

                if Text3Inner and Text3Inner:IsA( "TextLabel" ) then
                    local Entry13
                    local Entry12 = AttachmentCases.INFO[ Entry11 ]

                    if Entry12 then
                        Entry13 = Entry12
                    else
                        Entry13 = WeaponCases.INFO[ Entry11 ]
                    end
                    if not Entry13 then
                        Entry13 = { }
                    end

                    Text3Inner.Text = Entry13.Short or Entry11
                end

                local Selected2 = Value13:FindFirstChild( "Selected" )

                if Selected2 and Selected2:IsA( "UIStroke" ) then
                    local Enabled2 = Entry11 == Item4 and true or false
                    Selected2.Enabled = Enabled2
                end
            end
        end
    end

    local Item5
    local ChoicesOf9 = ChoicesOf( Value3 )

    if ChoicesOf9 then
        local Entry14 = Table5[ Value3 ]

        if Entry14 then
            Item5 = Entry14
        else
            Item5 = ChoicesOf9[ 1 ]
        end
    elseif Value3 then
        Item5 = Value3:GetAttribute( "CaseId" )
    else
        Item5 = Value3
    end

    local AutoButtonColor
    FillOdds( Item5 )
    TextLabel2.Text = MoneyFormat( ( Cost( ) ) )
    local Number = tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0
    AutoButtonColor = Cost( ) <= Number and true or false
    local Text4 = not AutoButtonColor and "NoMoney" or "CanOpen"
    local Text5
    SetState( Need4, Text4 )
    Text5 = AutoButtonColor and Text3 or Need4:GetAttribute( "NoMoneyText" ) or "NO MONEY"
    TextLabel4.Text = Text5
    Need4.AutoButtonColor = AutoButtonColor
end

LocalPlayer:GetAttributeChangedSignal( "Money" ):Connect( RefreshMenu )

local function ChooseCase( CaseName )
    local RowIdsOf2 = RowIdsOf( Value3 )

    if RowIdsOf2 and RowIdsOf2[ CaseName ] and not Flag2 and not Flag3 then
        Table5[ Value3 ] = RowIdsOf2[ CaseName ]
        RefreshMenu( )
    end
end

Value6 = nil

for Key3, Value7 in Table6, nil, nil do
    Value7.Activated:Connect( function()
        local RowIdsOf2 = RowIdsOf( Value3 )

        if RowIdsOf2 and RowIdsOf2[ Key3 ] and not Flag2 and not Flag3 then
            Table5[ Value3 ] = RowIdsOf2[ Key3 ]
            RefreshMenu( )
        end
    end )
end

local Value8

local function ChooseCard( Argument1 )
    local ChoicesOf2 = ChoicesOf( Value3 )

    if ChoicesOf2 and table.find( ChoicesOf2, Argument1 ) and not Flag2 and not Flag3 then
        Table5[ Value3 ] = Argument1
        RefreshMenu( )
    end
end

Value8 = nil

for Key4, Value9 in Table7, nil, nil do
    Value9.Activated:Connect( function()
        local ChoicesOf2 = ChoicesOf( Value3 )

        if ChoicesOf2 and table.find( ChoicesOf2, Key4 ) and not Flag2 and not Flag3 then
            Table5[ Value3 ] = Key4
            RefreshMenu( )
        end
    end )
end

local CaseRolls
local Number = 0
local Flag4 = false
game:GetService( "UserInputService" ).InputEnded:Connect( function( Argument1 )
    if Argument1.KeyCode == Enum.KeyCode.ButtonA then
        Flag4 = false
    end
end )
local Callback = nil

local function ShowMenu( Visible )
    if Template2.Visible == Visible then
        return
    end

    Template2.Visible = Visible

    if not Visible then
        GamepadNav.Close( "CaseMenu" )
        return
    end

    local Result2
    Number = os.clock( )
    local Success, Result = pcall( function()
        return game:GetService( "UserInputService" ):IsGamepadButtonDown( Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA )
    end )
    Result2 = Success and Result or false
    Flag4 = Result2
    TextLabel5.Text = ""
    RefreshMenu( )
    OddsTop( )
    UIScale2.Scale = 0.9 * Scale
    TweenService:Create( UIScale2, TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Scale } ):Play( )
    local Open = GamepadNav.Open
    local Table = {
        root = Template2,
        first = Need4,
        freeze = false,
        virtual = true,
        onSelect = function()
            if Callback then
                Callback( )
            end
        end,
        selectLabel = "Select (hold to buy)",
        backLabel = "Close"
    }
    local VirtualActions = {
        [ Need4 ] = function()
            if Callback then
                Callback( )
            end
        end,
        [ Need3 ] = function()
            Value4 = Value3
            ShowMenu( false )
        end
    }

    if ChoicesOf( Value3 ) then
        local Value1 = nil

        for Key, Value in Table6, nil, nil do
            VirtualActions[ Value ] = function()
                local Value1 = RowIdsOf( Value3 )

                if Value1 and Value1[ Key ] and not Flag2 and not Flag3 then
                    Table5[ Value3 ] = Value1[ Key ]
                    RefreshMenu( )
                end
            end
        end

        local Value2 = nil

        for Key2, Value3Inner in Table7, nil, nil do
            VirtualActions[ Value3Inner ] = function()
                local Value1 = ChoicesOf( Value3 )

                if Value1 and table.find( Value1, Key2 ) and not Flag2 and not Flag3 then
                    Table5[ Value3 ] = Key2
                    RefreshMenu( )
                end
            end
        end
    end

    Table.virtualActions = VirtualActions
    Table.holdButtons = { [ Need4 ] = 0.7 }
    Table.hints = { { Enum.KeyCode.DPadRight, "Choose" } }
    function Table.onBack()
        Value4 = Value3
        ShowMenu( false )
    end
    Open( "CaseMenu", Table )
end

Need3.Activated:Connect( function()
    Value4 = Value3

    if Template2.Visible == false then
        return
    end
    Template2.Visible = false
    GamepadNav.Close( "CaseMenu" )
    return
end )
task.spawn( function()
    local Value1
    local Table = { }
    local Table2 = { }
    local ODDS = WeaponCases.ODDS
    Value1 = nil

    for Value in ODDS, nil, nil do
        local Table9
        local ShownKeys3 = ShownKeys( Value )
        Table9 = if ShownKeys3 then ShownKeys3 else { }
        local Value13 = nil

        for Key5, Value14 in Table9, nil, nil do
            if ItemRender.ICONS[ Value14 ] and not Table2[ Value14 ] then
                Table2[ Value14 ] = true
                table.insert( Table, Value14 )
            end
        end
    end

    local Value2
    table.sort( Table )
    local ContentProvider = game:GetService( "ContentProvider" )
    local Table3 = { }
    local Table4 = { }

    local function Signature( Argument1, Object )
        if AttachmentCases.Split( Argument1 ) == "Skin" then
            return Argument1
        end

        local Table = { }

        for Key, Value in Object:GetDescendants( ) do
            if Value:IsA( "BasePart" ) and Value.Transparency < 0.9 then
                local MeshId = Value:IsA( "MeshPart" ) and Value.MeshId or Value.ClassName
                table.insert( Table, MeshId .. string.format( "%.1f/%.1f/%.1f", Value.Size.X, Value.Size.Y, Value.Size.Z ) )
            end
        end

        table.sort( Table )
        return table.concat( Table, "|" )
    end

    local function ListFor( ForName )
        if Table4[ ForName ] then
            return Table4[ ForName ]
        end

        local Pool = AttachmentCases.Pool( ForName )

        if not Pool or #Pool == 0 then
            return nil
        end

        local Value1
        local Table = { }
        local Table2 = { }
        local Table3Inner = { }
        Value1 = nil

        for Key, Value in Pool, nil, nil do
            local DisplayModel2 = DisplayModel( Value )

            if DisplayModel2 then
                local Signature2 = Signature( Value, DisplayModel2 )

                if not Table2[ Signature2 ] then
                    local Entry2
                    Table2[ Signature2 ] = true
                    local Entry = Table3[ Value ]

                    if Entry then
                        Entry2 = Entry
                    elseif AttachmentCases.Split( Value ) == "Skin" then
                        local CamoSwatch2 = CamoSwatch( ImageLabel, Value )

                        if CamoSwatch2 then
                            Entry2 = CamoSwatch2
                        else
                            Entry2 = ItemThumb( ImageLabel, DisplayModel2 )
                        end
                    else
                        Entry2 = ItemThumb( ImageLabel, DisplayModel2 )
                    end
                    if Entry2 then
                        Entry2.Name = "ItemView_" .. Value
                        Entry2.Size = UDim2.fromOffset( 1, 1 )
                        Table3[ Value ] = Entry2
                        table.insert( Table, Value )
                        table.insert( Table3Inner, Entry2 )
                    end
                end
            end
        end

        task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table3Inner )
        Table4[ ForName ] = Table
        return Table
    end

    local function ShowView( View )
        local Value1 = nil

        for Key, Value in Table3, nil, nil do
            local Size
            Value.Visible = true

            if Key == View then
                local FromScale = UDim2.fromScale( 1, 1 )

                if FromScale then
                    Size = FromScale
                else
                    Size = UDim2.fromOffset( 1, 1 )
                end
            else
                Size = UDim2.fromOffset( 1, 1 )
            end

            Value.Size = Size
        end
    end

    local Table5Inner = { }

    local function ShowWeapon( WeaponName )
        if WeaponName and not Table5Inner[ WeaponName ] then
            local Table = {
                GetAttribute = function( Argument1, Name )
                    local Captured = Name == "Weapon" and WeaponName or nil
                    return Captured
                end
            }
            local Image = ItemRender.Icon( Table )

            if type( Image ) == "string" and Image ~= "" then
                local ImageLabelInner = Instance.new( "ImageLabel" )
                ImageLabelInner.Name = "WeaponIcon_" .. WeaponName
                ImageLabelInner.BackgroundTransparency = 1
                ImageLabelInner.Size = UDim2.fromScale( 1, 1 )
                ImageLabelInner.ScaleType = ImageLabel.ScaleType
                ImageLabelInner.Image = Image
                ImageLabelInner.Parent = ImageLabel
                Table5Inner[ WeaponName ] = ImageLabelInner
            end
        end

        local Value1 = nil

        for Key, Value in Table5Inner, nil, nil do
            local Flag = Key == WeaponName and true or false
            local Size

            if Flag then
                local FromScale = UDim2.fromScale( 1, 1 )

                if FromScale then
                    Size = FromScale
                else
                    Size = UDim2.fromOffset( 1, 1 )
                end
            else
                Size = UDim2.fromOffset( 1, 1 )
            end

            local ImageTransparency
            Value.Size = Size
            ImageTransparency = not Flag and 0.9 or 0
            Value.ImageTransparency = ImageTransparency
        end
    end

    Value2 = nil

    for Key, Value3Inner in Table, nil, nil do
        ShowWeapon( Value3Inner )
    end

    local Value4
    ShowWeapon( nil )
    local Table6 = { }
    Value4 = nil

    for Key2, Value5 in Table5Inner, nil, nil do
        table.insert( Table6, Value5 )
    end
    for Key3, Value6 in ReplicatedStorage:WaitForChild( "Weapons" ):GetChildren( ) do
        if Value6:IsA( "SurfaceAppearance" ) then
            table.insert( Table6, Value6 )
        end
    end

    local Number
    task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table6 )

    local function TileRarity( Argument1 )
        local Rarity2
        local Rarity = Frame:FindFirstChild( "Rarity" )

        if Rarity then
            Rarity2 = Rarity
        else
            local UIGradient = Instance.new( "UIGradient" )
            UIGradient.Name = "Rarity"
            UIGradient.Rotation = 90
            UIGradient.Parent = Frame
            Rarity2 = UIGradient
        end

        Rarity2.Color = TileShape( TierKey( Argument1 ) )
        SetState( Frame, "Rarity" )
    end

    Number = 0

    while true do
        local ListFor2
        local Visible = Template2.Visible

        if Visible then
            if Value3 then
                local Item
                local ChoicesOf2 = ChoicesOf( Value3 )

                if ChoicesOf2 then
                    local Entry = Table5[ Value3 ]

                    if Entry then
                        Item = Entry
                    else
                        Item = ChoicesOf2[ 1 ]
                    end
                elseif Value3 then
                    Item = Value3:GetAttribute( "CaseId" )
                else
                    Item = Value3
                end

                ListFor2 = ListFor( Item )
            else
                ListFor2 = Value3
            end
        else
            ListFor2 = Visible
        end
        if not ListFor2 or not ( #ListFor2 > 0 ) then
            if Template2.Visible and #Table > 0 then
                local Table8
                ShowView( nil )
                local Table7 = { }

                if Value3 then
                    local Item2
                    local ChoicesOf3 = ChoicesOf( Value3 )

                    if ChoicesOf3 then
                        local Entry2 = Table5[ Value3 ]

                        if Entry2 then
                            Item2 = Entry2
                        else
                            Item2 = ChoicesOf3[ 1 ]
                        end
                    elseif Value3 then
                        Item2 = Value3:GetAttribute( "CaseId" )
                    else
                        Item2 = Value3
                    end

                    local ShownKeys2 = ShownKeys( Item2 )

                    if ShownKeys2 then
                        Table8 = ShownKeys2
                    else
                        Table8 = Table
                    end
                else
                    Table8 = Table
                end

                local Value10 = nil

                for Key4, Value11 in Table8, nil, nil do
                    if ItemRender.ICONS[ Value11 ] then
                        table.insert( Table7, Value11 )
                    end
                end
                if #Table7 > 0 then
                    local Number3 = Number % #Table7 + 1
                    ImageLabel.Image = ""
                    ShowWeapon( Table7[ Number3 ] )
                    TileRarity( Table7[ Number3 ] )
                    Number = Number3
                end
            end
        else
            local Number2 = Number % #ListFor2 + 1
            ImageLabel.Image = ""
            ShowWeapon( nil )
            ShowView( ListFor2[ Number2 ] )
            TileRarity( ListFor2[ Number2 ] )
            Number = Number2
        end

        local Number4 = 0

        while Number4 < 0.9 do
            if Flag then
                break
            end

            Number4 = Number4 + task.wait( 0.05 )
        end

        Flag = false
    end
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

            local Value1
            local CaseStations = workspace:FindFirstChild( "CaseStations" )

            if not HumanoidRootPart or not CaseStations or ClientState.Downed then
                Value1 = nil
            else
                for Key, Value in CaseStations:GetChildren( ) do
                    if LocalPlayer:GetAttribute( "InTutorial" ) then
                        if Value.Name ~= "WeaponStation" then
                            continue
                        end

                        local Entry2
                        local InTutorial = game:GetService( "Players" ).LocalPlayer:GetAttribute( "InTutorial" )

                        if InTutorial then
                            local Entry = Config.Rolls[ InTutorial ]

                            if Entry then
                                Entry2 = Entry
                            else
                                Entry2 = nil
                            end
                        else
                            Entry2 = nil
                        end
                        if not Entry2 then
                            continue
                        end
                    end

                    local Pad = Value:FindFirstChild( "Pad" )

                    if Pad then
                        local Position = HumanoidRootPart.Position - Pad.Position
                        local Number = tonumber( Value:GetAttribute( "PadRadius" ) ) or 4
                        local X = Position.X

                        if Vector3.new( X, 0, Position.Z ).Magnitude < Number then
                            if math.abs( Position.Y ) < 6 then
                                Value1 = Value
                                break
                            end
                        end
                    end

                    Value1 = nil
                end
            end
            if Value1 ~= Value3 then
                Value3 = Value1
                RefreshMenu( )

                if not Value1 then
                    Value4 = nil
                end
            end

            local Flag

            if Value3 == nil then
                Flag = false
            elseif Value4 == Value3 then
                Flag = false
            else
                Flag = true
            end

            ShowMenu( Flag )
        end
    end
end )
local FromRGB = Color3.fromRGB( 255, 238, 210 )
local FromRGB2 = Color3.fromRGB( 255, 120, 30 )

local function Rnd( Argument1, Argument2 )
    return Argument1 + math.random( ) * ( Argument2 - Argument1 )
end

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

local function OutBack( Argument1, Amount )
    local Number = Amount or 1.7
    local Clamp = math.clamp( Argument1, 0, 1 ) - 1
    return 1 + ( Number + 1 ) * Clamp ^ 3 + Number * Clamp ^ 2
end

local function Kp( Argument1, Argument2 )
    return NumberSequenceKeypoint.new( Argument1, Argument2 )
end

local Flag5 = false
local Table8 = { }

local function Tween( List, Argument2, List2, Argument4, Argument5 )
    local Number = if Flag5 then 0 else Argument2
    local Create = TweenService:Create( List, TweenInfo.new( Number, Argument4 or Enum.EasingStyle.Quad, Argument5 or Enum.EasingDirection.Out ), List2 )

    if not Flag5 then
        Table8[ Create ] = { List, List2 }
        Create.Completed:Once( function()
            Table8[ Create ] = nil
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

local Flag6 = false

local function During( Amount, Callback )
    local Clock = os.clock( )
    local Clock2 = os.clock( )

    while true do
        if Flag6 then
            error( "CaseAborted", 0 )
        end

        local Min2
        local Clock3 = os.clock( )
        local Clock4 = Clock3 - Clock

        if Amount > 0 then
            local Min = math.min( Clock4 / Amount, 1 )

            if Min then
                Min2 = Min
            else
                Min2 = 1
            end
        else
            Min2 = 1
        end

        local Max

        if Flag5 then
            Max = math.max( Clock4, Amount )
            Min2 = 1
        else
            Max = Clock4
        end
        if Callback then
            Callback( Min2, Max, Clock3 - Clock2 )
        end
        if Min2 >= 1 then
            return
        end

        RunService.RenderStepped:Wait( )
        Clock2 = Clock3
    end
end

local function Pause( Amount )
    During( Amount )
end

local function MuteSounds( Argument1 )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        local Volume
        Key:Stop( )
        Volume = if Argument1 then 0 else Value
        Key.Volume = Volume
    end
end

local function StartSkip()
    if Flag5 then
        return
    end

    local Value1
    Flag5 = true
    Value1 = nil

    for Value in Table, nil, nil do
        Value:Stop( )
        Value.Volume = 0
    end

    local Value2 = nil

    for Key, Value3 in Table8, nil, nil do
        local Value4
        Table8[ Key ] = nil
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
    if not Flag5 then
        return
    end

    local Value1
    Flag5 = false
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Key:Stop( )
        Key.Volume = Value
    end
end

local function FakeTool( Argument1 )
    return {
        GetAttribute = function( Argument1Inner, Name )
            local Captured = Name == "Weapon" and Argument1 or nil
            return Captured
        end
    }
end

local function IsItem( Argument1 )
    local Flag = AttachmentCases.Split( Argument1 ) ~= nil and true or false
    return Flag
end

local function ToolName( Argument1 )
    local Value1
    local Table = {
        game:GetService( "StarterPack" ),
        ReplicatedStorage:FindFirstChild( "BetaRollWeapons" )
    }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Children = Value and Value:GetChildren( ) or { }
        local Value2 = nil

        for Key2, Value3 in Children, nil, nil do
            if Value3:GetAttribute( "Melee" ) ~= Argument1 then
                if Value3:GetAttribute( "Weapon" ) ~= Argument1 then
                    continue
                end
            end

            return Value3:GetAttribute( "DisplayName" )
        end
    end

    return nil
end

local function DisplayName( NameName )
    local Flag = AttachmentCases.Split( NameName ) ~= nil and true or false

    if Flag then
        return AttachmentCases.Name( NameName )
    end

    local Name
    local Entry = WeaponData[ NameName ]

    if not Entry or not Entry.Name then
        local ToolName2 = ToolName( NameName )

        if ToolName2 then
            Name = ToolName2
        else
            Name = NameName
        end
    else
        Name = Entry.Name
    end

    return Name
end

local Table9 = {
    common = true,
    uncommon = true,
    rare = true,
    epic = true,
    legendary = true,
    super = true,
    mythical = true,
    secret = true
}

TierKey = function( Argument1 )
    local Flag = AttachmentCases.Split( Argument1 ) ~= nil and true or false

    if Flag then
        return AttachmentCases.Tier( Argument1 )
    end

    local Category2
    local Category = ItemRender.Category( {
        GetAttribute = function( Argument1Inner, Name )
            local Captured = Name == "Weapon" and Argument1 or nil
            return Captured
        end
    } )
    Category2 = Table9[ Category ] and Category or "common"
    return Category2
end

local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Vector3.new( 0, 0, -1 ), Vector3.new( 0, 1, 0 ), Vector3.new( 1, 0, 0 ) )
local Angles = CFrame.Angles( -0.13962634015954636, 0, 0 )

local function WeaponLength( Amount )
    return ( math.clamp( 4.8 * ( Amount / 5 ) ^ 0.8, 1.2, 4.8 ) )
end

local Table10 = { "M4", "AK", "MP5" }
local Table11 = { "M4", "AK", "MP5", "M60", "G15", "AWP", "DRAGON", "SPAS12" }

local function ItemSource( Argument1 )
    local Split, Name = AttachmentCases.Split( Argument1 )

    if Split == "Skin" then
        local Entry = ModCatalog.Skins[ Name ]

        if not Entry then
            return nil
        end

        local Color2
        local Parent = Instance.new( "Model" )
        Parent.Name = Name
        local Parent2 = Instance.new( "Part" )
        Parent2.Name = "Plate"
        Parent2.Size = Vector3.new( 0.05999999865889549, 1.600000023841858, 1.600000023841858 )
        Parent2.CFrame = CFrame.new( )
        local Color = Entry.Color
        Color2 = if Color then Color else Color3.fromRGB( 128, 128, 128 )
        Parent2.Color = Color2
        Parent2.Material = Enum.Material.SmoothPlastic
        Parent2.TopSurface = Enum.SurfaceType.Smooth
        Parent2.BottomSurface = Enum.SurfaceType.Smooth
        Parent2.Parent = Parent

        if Entry.Texture then
            local Value1
            local Table = { Enum.NormalId.Right, Enum.NormalId.Left }
            Value1 = nil

            for Key, Value in Table, nil, nil do
                local Texture = Instance.new( "Texture" )
                Texture.Texture = Entry.Texture
                Texture.Face = Value
                Texture.StudsPerTileU = 1.6
                Texture.StudsPerTileV = 1.6
                Texture.Parent = Parent2
            end
        end

        Parent.PrimaryPart = Parent2
        return Parent, true
    end
    local Clone = table.clone( Table11 )

    for Key2, Value2 in WeaponMods:GetChildren( ) do
        table.insert( Clone, Value2.Name )
    end

    local Value3 = nil

    for Key3, Value4 in Clone, nil, nil do
        local FoundChild3
        local FoundChild = WeaponVisuals:FindFirstChild( Value4 )
        local FoundChild2 = WeaponMods:FindFirstChild( Value4 )

        if FoundChild2 then
            FoundChild3 = WeaponMods[ Value4 ]:FindFirstChild( Name )
        else
            FoundChild3 = FoundChild2
        end
        if FoundChild and FoundChild.PrimaryPart then
            if FoundChild3 then
                local Parent3 = Instance.new( "Model" )
                Parent3.Name = Name
                local PrimaryPart = Instance.new( "Part" )
                PrimaryPart.Name = "Frame"
                PrimaryPart.Size = Vector3.new( 0.05000000074505806, 0.05000000074505806, 0.05000000074505806 )
                PrimaryPart.Transparency = 1
                PrimaryPart.CFrame = FoundChild.PrimaryPart.CFrame
                PrimaryPart.Parent = Parent3
                Parent3.PrimaryPart = PrimaryPart
                FoundChild3:Clone( ).Parent = Parent3
                return Parent3, true
            end
        end
    end

    return nil
end

DisplayModel = function( p1 )
    -- Could not structure function #69
end

local function Place( Model, Argument2, Argument3, Amount )
    if Amount then
        Model:ScaleTo( Model:GetAttribute( "BaseScale" ) * Amount )
    end

    local Center = ( Model:GetAttribute( "Center" ) or Vector3.new( 0, 0, 0 ) ) * ( Amount or 1 )
    Model:PivotTo( CFrame.new( Argument2 ) * Argument3 * CFrame.new( -Center ) )
end

local function LidParts( Model )
    local Table = { }

    for Key, Value in Model:GetChildren( ) do
        if Value:IsA( "BasePart" ) and typeof( Value:GetAttribute( "ClosedOffset" ) ) == "CFrame" then
            table.insert( Table, Value )
        end
    end

    return Table
end

local function SetLid( Model, Argument2 )
    local Pivot = Model:GetPivot( )
    local LidHinge = Model:GetAttribute( "LidHinge" )

    if not LidHinge then
        return
    end

    local CFrame2 = CFrame.new( LidHinge ) * CFrame.Angles( math.rad( Argument2 ), 0, 0 ) * CFrame.new( -LidHinge )

    for Key, Value in LidParts( Model ) do
        Value.CFrame = Pivot * CFrame2 * Value:GetAttribute( "ClosedOffset" )
    end
end

local function AnimateLid( Argument1, Argument2, Argument3, Amount )
    During( Amount, function( Argument1Inner )
        local Clamp3
        local Captured = Argument3 - Argument2
        local Clamp = math.clamp( Argument1Inner, 0, 1 )

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

        SetLid( Argument1, Argument2 + Captured * Clamp3 )
    end )
end

local function FxPart( Parent, List )
    local Value1
    local Part = Instance.new( "Part" )
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Value1 = nil

    for Key, Value in List, nil, nil do
        Part[ Key ] = Value
    end

    Part.Parent = Parent
    return Part
end

local function Emitter( Parent, List )
    local Value1
    local ParticleEmitter = Instance.new( "ParticleEmitter" )
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Rate = 0
    Value1 = nil

    for Key, Value in List, nil, nil do
        ParticleEmitter[ Key ] = Value
    end

    ParticleEmitter.Parent = Parent
    return ParticleEmitter
end

local function BuildStage( Parent4, Argument2, Amount, Color, Argument5 )
    local Value1
    local Parent = FxPart( Parent4, {
        Name = "StageLamp",
        Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 ),
        Transparency = 1,
        CFrame = CFrame.lookAt( Argument2 + Vector3.new( 0, 9, 0 ) + Amount * 1.5 + ( Argument5 or Vector3.new( 0, 0, 0 ) ), Argument2 )
    } )
    local SpotLight = Instance.new( "SpotLight" )
    SpotLight.Face = Enum.NormalId.Front
    SpotLight.Angle = 48
    SpotLight.Range = 16
    SpotLight.Brightness = 0
    SpotLight.Color = Color or FromRGB
    SpotLight.Shadows = true
    SpotLight.Parent = Parent
    local Parent2 = FxPart( Parent4, {
        Name = "StageFloor",
        Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 ),
        Transparency = 1,
        CFrame = CFrame.new( Argument2 - Vector3.new( 0, 0.699999988079071, 0 ) )
    } )
    local Attachment0 = Instance.new( "Attachment" )
    Attachment0.Parent = Parent
    local Attachment1 = Instance.new( "Attachment" )
    Attachment1.Parent = Parent2
    local Table = { }
    local Table2 = { 2.5, 4, 5.5, 7, 8.5 }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Beam = Instance.new( "Beam" )
        Beam.Attachment0 = Attachment0
        Beam.Attachment1 = Attachment1
        Beam.Width0 = 0.4
        Beam.Width1 = Value
        Beam.FaceCamera = true
        Beam.Segments = 1
        Beam.LightEmission = 1
        Beam.LightInfluence = 0
        Beam.Color = ColorSequence.new( Color or FromRGB )
        Beam.Transparency = NumberSequence.new( 1 )
        Beam.Parent = Parent
        Table[ Key ] = Beam
    end

    local Value2
    local Parent3 = FxPart( Parent4, {
        Name = "StageDust",
        Size = Vector3.new( 4.5, 6, 3 ),
        Transparency = 1,
        CFrame = CFrame.new( Argument2 + Vector3.new( 0, 3.200000047683716, 0 ) )
    } )
    local Table3 = {
        Shape = Enum.ParticleEmitterShape.Box,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
        Color = ColorSequence.new( Color or FromRGB ),
        LightEmission = 0.5,
        Size = NumberSequence.new( 0.04 ),
        Transparency = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 1 ),
            NumberSequenceKeypoint.new( 0.3, 0.35 ),
            NumberSequenceKeypoint.new( 0.7, 0.35 ),
            Kp( 1, 1 )
        } ),
        Lifetime = NumberRange.new( 3, 5 ),
        Speed = NumberRange.new( 0.05, 0.25 ),
        SpreadAngle = Vector2.new( 180, 180 ),
        RotSpeed = NumberRange.new( -30, 30 )
    }
    local ParticleEmitter = Instance.new( "ParticleEmitter" )
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Rate = 0
    Value2 = nil

    for Key2, Value3 in Table3, nil, nil do
        ParticleEmitter[ Key2 ] = Value3
    end

    ParticleEmitter.Parent = Parent3
    local Table4 = { light = SpotLight }
    function Table4.set( Amount )
        local Value1
        SpotLight.Brightness = 4 * Amount
        local Clamp = math.clamp( Amount, 0, 1.3 )
        Value1 = nil

        for Key, Value in Table, nil, nil do
            local Clamp2 = 1 - Clamp * 0.05
            Value.Transparency = NumberSequence.new( {
                NumberSequenceKeypoint.new( 0, 1 - ( 1 - Clamp2 ) * 0.6 ),
                NumberSequenceKeypoint.new( 0.6, Clamp2 ),
                Kp( 1, 1 )
            } )
        end

        ParticleEmitter.Rate = math.clamp( Amount, 0, 1 ) * 14
    end
    Table4.set( 0 )
    return Table4
end

local FX = game:GetService( "ReplicatedStorage" ):WaitForChild( "FX", 10 )

if FX then
    CaseRolls = FX:WaitForChild( "CaseRolls", 10 )
else
    CaseRolls = FX
end

local function IsFX( Self )
    local IsA4
    local IsA = Self:IsA( "ParticleEmitter" )

    if IsA then
        IsA4 = IsA
    else
        local IsA2 = Self:IsA( "Beam" )

        if IsA2 then
            IsA4 = IsA2
        else
            local IsA3 = Self:IsA( "Trail" )

            if IsA3 then
                IsA4 = IsA3
            else
                IsA4 = Self:IsA( "Light" )
            end
        end
    end

    return IsA4
end

if CaseRolls then
    local function Sleep( Self )
        local IsA4
        local IsA = Self:IsA( "ParticleEmitter" )

        if IsA then
            IsA4 = IsA
        else
            local IsA2 = Self:IsA( "Beam" )

            if IsA2 then
                IsA4 = IsA2
            else
                local IsA3 = Self:IsA( "Trail" )

                if IsA3 then
                    IsA4 = IsA3
                else
                    IsA4 = Self:IsA( "Light" )
                end
            end
        end
        if IsA4 and Self:GetAttribute( "DesignOn" ) == nil then
            Self:SetAttribute( "DesignOn", Self.Enabled )
            Self.Enabled = false
        end
    end

    for Key5, Value10 in CaseRolls:GetDescendants( ) do
        Sleep( Value10 )
    end

    CaseRolls.DescendantAdded:Connect( Sleep )
else
    warn( "[CaseClient] ReplicatedStorage.FX.CaseRolls introuvable : ouverture des caisses sans effets" )
end

local function FxClone( Parent, Name, CFrame, Flag )
    local FoundChild

    if CaseRolls then
        FoundChild = CaseRolls:FindFirstChild( Name )
    else
        FoundChild = CaseRolls
    end
    if not FoundChild or not FoundChild:IsA( "BasePart" ) then
        return nil
    end

    local CFrame2
    local Clone = FoundChild:Clone( )
    Clone.Anchored = true
    Clone.CanCollide = false
    Clone.CanQuery = false
    Clone.CanTouch = false
    Clone.CastShadow = false
    CFrame2 = if Flag then CFrame * CFrame.new( 0, Clone.Size.Y / 2, 0 ) else CFrame
    local CFrame4
    local Offset = Clone:GetAttribute( "Offset" )

    if typeof( Offset ) == "Vector3" then
        local CFrame3 = CFrame2 * CFrame.new( Offset )

        if CFrame3 then
            CFrame4 = CFrame3
        else
            CFrame4 = CFrame2
        end
    else
        CFrame4 = CFrame2
    end

    Clone.CFrame = CFrame4
    Clone.Parent = Parent
    return Clone
end

local function FxEmit( Object )
    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) and Value:GetAttribute( "DesignOn" ) ~= false then
            local Number = tonumber( Value:GetAttribute( "EmitCount" ) ) or 1
            local Number2 = tonumber( Value:GetAttribute( "EmitDelay" ) ) or 0

            if Number2 > 0 then
                task.delay( Number2, function()
                    if Value.Parent then
                        Value:Emit( Number )
                    end
                end )
            else
                Value:Emit( Number )
            end
        end
    end
end

local function FxSwitch( Object, Enabled )
    for Key, Value in Object:GetDescendants( ) do
        local IsA4
        local IsA = Value:IsA( "ParticleEmitter" )

        if IsA then
            IsA4 = IsA
        else
            local IsA2 = Value:IsA( "Beam" )

            if IsA2 then
                IsA4 = IsA2
            else
                local IsA3 = Value:IsA( "Trail" )

                if IsA3 then
                    IsA4 = IsA3
                else
                    IsA4 = Value:IsA( "Light" )
                end
            end
        end
        if IsA4 and Value:GetAttribute( "DesignOn" ) ~= false then
            if Value:IsA( "ParticleEmitter" ) then
                if Enabled then
                    local Number2

                    if Value.Rate > 0 then
                        Number2 = 1
                    else
                        local Number = tonumber( Value:GetAttribute( "EmitCount" ) )

                        if Number then
                            Number2 = Number
                        else
                            Number2 = 1
                        end
                    end

                    Value:Emit( Number2 )
                end

                local Enabled2

                if Enabled then
                    if Value.Rate > 0 then
                        Enabled2 = true
                    else
                        Enabled2 = false
                    end
                else
                    Enabled2 = Enabled
                end

                Value.Enabled = Enabled2
            else
                Value.Enabled = Enabled
            end
        end
    end
end

local Table12 = {
    common = { },
    uncommon = { fx = "CaseRoll_Uncommon" },
    rare = { fx = "CaseRoll_Rare" },
    epic = { fx = "CaseRoll_Epic" },
    legendary = { fx = "CaseRoll_Legendary", weapon = true },
    mythical = { fx = "CaseRoll_Mythical", weapon = true },
    secret = { fx = "CaseRoll_Secret", weapon = true }
}
local Table13 = { super = "mythical" }

local function RarityColor( ColorName )
    local Entry2
    local Entry = ItemRender.TILE_GRAD[ ColorName ]

    if Entry then
        Entry2 = Entry
    elseif ColorName == "mythical" then
        local Super = ItemRender.TILE_GRAD.super

        if Super then
            Entry2 = Super
        else
            Entry2 = ItemRender.TILE_GRAD.fist
        end
    else
        Entry2 = ItemRender.TILE_GRAD.fist
    end

    return Entry2.Keypoints[ 1 ].Value
end

local function RarityOf( Argument1 )
    local DebugCaseRarity2
    local DebugCaseRarity = LocalPlayer:GetAttribute( "DebugCaseRarity" )

    if DebugCaseRarity then
        DebugCaseRarity2 = DebugCaseRarity
    else
        DebugCaseRarity2 = TierKey( Argument1 )
    end

    local Entry2
    local Entry = Table13[ DebugCaseRarity2 ] or DebugCaseRarity2
    Entry2 = if Table12[ Entry ] then Entry else "common"
    local Entry4
    local Entry3 = ItemRender.TILE_GRAD[ Entry2 ]

    if Entry3 then
        Entry4 = Entry3
    elseif Entry2 == "mythical" then
        local Super = ItemRender.TILE_GRAD.super

        if Super then
            Entry4 = Super
        else
            Entry4 = ItemRender.TILE_GRAD.fist
        end
    else
        Entry4 = ItemRender.TILE_GRAD.fist
    end

    local Value = Entry4.Keypoints[ 1 ].Value

    if Entry2 == "secret" then
        return Entry2, Value, Color3.fromRGB( 225, 228, 240 )
    end
    return Entry2, Value, Value:Lerp( Color3.new( 1, 1, 1 ), 0.55 )
end

Storage.FxTint = function( Object, TintName )
    if TintName == "legendary" then
        return
    end

    local Legendary2
    local Legendary = ItemRender.TILE_GRAD.legendary
    Legendary2 = if Legendary then Legendary else ItemRender.TILE_GRAD.fist
    local Entry2
    local ToHSV, ToHSV2 = Legendary2.Keypoints[ 1 ].Value:ToHSV( )
    local Entry = ItemRender.TILE_GRAD[ TintName ]

    if Entry then
        Entry2 = Entry
    elseif TintName == "mythical" then
        local Super = ItemRender.TILE_GRAD.super

        if Super then
            Entry2 = Super
        else
            Entry2 = ItemRender.TILE_GRAD.fist
        end
    else
        Entry2 = ItemRender.TILE_GRAD.fist
    end

    local ToHSV3, ToHSV22 = Entry2.Keypoints[ 1 ].Value:ToHSV( )

    local function Turn( Argument1 )
        local ToHSVInner, ToHSV2Inner, ToHSV3Inner = Argument1:ToHSV( )
        local Captured = ( ToHSV3 + ( ( ToHSVInner - ToHSV + 0.5 ) % 1 - 0.5 ) * 0.5 ) % 1
        return Color3.fromHSV( Captured, math.clamp( ToHSV2Inner * ToHSV22 / math.max( ToHSV2, 0.01 ), 0, 1 ), ToHSV3Inner )
    end

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) or Value:IsA( "Beam" ) or Value:IsA( "Trail" ) then
            local Value1
            local Table = { }
            local Keypoints = Value.Color.Keypoints
            Value1 = nil

            for Key2, Value2 in Keypoints, nil, nil do
                Table[ Key2 ] = ColorSequenceKeypoint.new( Value2.Time, Turn( Value2.Value ) )
            end

            Value.Color = ColorSequence.new( Table )
        elseif Value:IsA( "Light" ) then
            local ToHSV4, ToHSV23, ToHSV32 = Value.Color:ToHSV( )
            local ToHSV5 = ( ToHSV3 + ( ( ToHSV4 - ToHSV + 0.5 ) % 1 - 0.5 ) * 0.5 ) % 1
            Value.Color = Color3.fromHSV( ToHSV5, math.clamp( ToHSV23 * ToHSV22 / math.max( ToHSV2, 0.01 ), 0, 1 ), ToHSV32 )
        end
    end
end

Storage.FxPaint = function( Object, Color )
    local ToHSV, ToHSV2, ToHSV3 = Color:ToHSV( )

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) or Value:IsA( "Beam" ) or Value:IsA( "Trail" ) then
            local Value1, Number
            local Keypoints = Value.Color.Keypoints
            Value1 = nil
            Number = 0

            for Key2, Value2 in Keypoints, nil, nil do
                Number = math.max( Number, ( select( 3, Value2.Value:ToHSV( ) ) ) )
            end

            local Value3
            local Table = { }
            local Keypoints2 = Value.Color.Keypoints
            Value3 = nil

            for Key3, Value4 in Keypoints2, nil, nil do
                local ToHSV33
                local _, _, ToHSV32 = Value4.Value:ToHSV( )
                local Time = Value4.Time
                ToHSV33 = Number > 0 and ToHSV32 / Number or 1
                Table[ Key3 ] = ColorSequenceKeypoint.new( Time, Color3.fromHSV( ToHSV, ToHSV2, ToHSV3 * ToHSV33 ) )
            end

            Value.Color = ColorSequence.new( Table )
        elseif Value:IsA( "Light" ) then
            Value.Color = Color
        end
    end
end

Storage.ShowcaseOff = function( Self )
    local PadVisual = Self:FindFirstChild( "PadVisual" )
    local Table = { }

    for Key, Value in Self:GetDescendants( ) do
        local IsA4
        local IsA = Value:IsA( "ParticleEmitter" )

        if IsA then
            IsA4 = IsA
        else
            local IsA2 = Value:IsA( "Beam" )

            if IsA2 then
                IsA4 = IsA2
            else
                local IsA3 = Value:IsA( "Trail" )

                if IsA3 then
                    IsA4 = IsA3
                else
                    IsA4 = Value:IsA( "Light" )
                end
            end
        end
        if IsA4 or Value:IsA( "Fire" ) or Value:IsA( "Smoke" ) or Value:IsA( "Sparkles" ) then
            if Value.Enabled then
                if not PadVisual or not Value:IsDescendantOf( PadVisual ) then
                    Value.Enabled = false
                    table.insert( Table, Value )
                end
            end
        end
    end

    return function()
        local Value1 = nil

        for Key, Value in Table, nil, nil do
            if Value.Parent then
                Value.Enabled = true
            end
        end
    end
end

Storage.Decode = function( Argument1, Argument2, Argument3 )
    task.spawn( function()
        local Clock = os.clock( )

        while Argument1.Parent do
            local Clock2 = ( os.clock( ) - Clock ) / Argument3

            if Clock2 >= 1 then
                Argument1.Text = Argument2
                return
            end

            local Floor = math.floor( #Argument2 * Clock2 )
            local Table = { Argument2:sub( 1, Floor ) }
            local Floor2 = Floor + 1
            local Count = #Argument2
            local I = Floor2

            for I = Floor2, Count do
                if Argument2:sub( I, I ) == " " then
                    table.insert( Table, " " )
                else
                    local Random = math.random( 1, 40 )
                    table.insert( Table, ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&" ):sub( Random, Random ) )
                end
            end

            Argument1.Text = table.concat( Table )
            RunService.RenderStepped:Wait( )
        end
    end )
end

Storage.FadeProps = function( Object, Callback )
    if Object:IsA( "GuiObject" ) then
        Callback( Object, "BackgroundTransparency" )

        if Object:IsA( "TextLabel" ) or Object:IsA( "TextButton" ) or Object:IsA( "TextBox" ) then
            Callback( Object, "TextTransparency" )
            Callback( Object, "TextStrokeTransparency" )
            return
        end
        if Object:IsA( "ImageLabel" ) or Object:IsA( "ImageButton" ) or Object:IsA( "ViewportFrame" ) then
            Callback( Object, "ImageTransparency" )
            return
        end
    elseif Object:IsA( "UIStroke" ) then
        Callback( Object, "Transparency" )
    end
end

Storage.NewFader = function( Object2, Argument2 )
    local Table = { }

    local function Add( List, Key )
        if List[ Key ] < 1 then
            table.insert( Table, { List, Key, 1 - List[ Key ] } )
        end
    end

    Storage.FadeProps( Object2, Add )

    for Key, Value in Object2:GetDescendants( ) do
        if Argument2 then
            if Value == Argument2 or Value:IsDescendantOf( Argument2 ) then
                continue
            end
        end

        Storage.FadeProps( Value, Add )
    end

    return {
        set = function( Argument1 )
            local Value1 = nil

            for Key, Value in Table, nil, nil do
                Value[ 1 ][ Value[ 2 ] ] = math.max( 1 - Value[ 3 ] * Argument1, 0 )
            end
        end,
        to = function( Argument1, Argument2, Argument3, Argument4 )
            local Value1 = nil

            for Key, Value in Table, nil, nil do
                local Item = Value[ 1 ]
                Tween( Item, Argument2, { [ Value[ 2 ] ] = math.max( 1 - Value[ 3 ] * Argument1, 0 ) }, Argument3, Argument4 )
            end
        end
    }
end

Storage.Toast = function( Argument1, Argument2, Enabled, Name )
    local Value1, FoundChild
    local Clone = Template4:Clone( )
    Clone.Name = "CaseToastLive"
    Clone:SetAttribute( "Screen", "CaseToastLive" )
    local Table = { "New", "Owned" }
    Value1 = nil
    FoundChild = nil

    for Key, Value in Table, nil, nil do
        local FoundChild2 = Clone:FindFirstChild( Value, true )

        if FoundChild2 and FoundChild2:IsA( "GuiObject" ) then
            local Flag = Value == "New" and true or false
            local Visible = Flag == Argument2 and true or false
            FoundChild2.Visible = Visible

            if FoundChild2.Visible then
                FoundChild = FoundChild2
            end
        end
    end
    if not FoundChild then
        Clone:Destroy( )
        return
    end

    local TextLabel
    local Text = FoundChild:FindFirstChild( "Text", true )

    if not Text or not Text:IsA( "TextLabel" ) then
        TextLabel = Instance.new( "TextLabel" )
    else
        TextLabel = Text
    end
    if not Argument2 and Name == "safe" then
        TextLabel.Text = TextLabel:GetAttribute( "SafeText" ) or "{weapon} is already in your safe"
    end

    TextLabel.Text = TextLabel.Text:gsub( "{weapon}", function()
        return Argument1
    end )
    local StrokeLegendary = FoundChild:FindFirstChild( "StrokeLegendary" )
    local Stroke = FoundChild:FindFirstChild( "Stroke" )

    if StrokeLegendary and StrokeLegendary:IsA( "UIStroke" ) then
        StrokeLegendary.Enabled = Enabled

        if Stroke and Stroke:IsA( "UIStroke" ) then
            Stroke.Enabled = not Enabled
        end
    end

    local UIScale2
    local UIScale = FoundChild:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        UIScale2 = UIScale
    else
        UIScale2 = Instance.new( "UIScale" )
    end

    local Scale = UIScale2.Scale
    local Value2 = Storage.NewFader( FoundChild )
    UIScale2.Scale = 0.6 * Scale
    Clone.Visible = true
    Clone.Parent = Template4.Parent
    Tween( UIScale2, 0.35, { Scale = Scale }, Enum.EasingStyle.Back )
    task.delay( 2.3, function()
        Value2.to( 0, 0.4 )
    end )
    Debris:AddItem( Clone, 3 )
end

Storage.Table14 = {
    {
        "Damage",
        function( Argument1 )
            local Number

            if type( Argument1.Damage ) == "table" then
                Number = tonumber( Argument1.Damage.Base )
            else
                Number = false
            end

            return Number
        end
    },
    {
        "FireRate",
        function( Argument1 )
            local Number

            if type( Argument1.Fire ) == "table" then
                Number = tonumber( Argument1.Fire.RPM )
            else
                Number = false
            end

            return Number
        end
    },
    {
        "Magazine",
        function( Argument1 )
            local Number

            if type( Argument1.Ammo ) == "table" then
                Number = tonumber( Argument1.Ammo.Mag )
            else
                Number = false
            end

            return Number
        end
    }
}

Storage.HiddenPlace = function( Argument1, Argument2, Argument3 )
    local Amount
    local Position = Argument1.Position
    Amount = Position.X.Scale >= 0.5 and Argument2 or -Argument2
    local Amount2 = Position.Y.Scale >= 0.5 and Argument3 or -Argument3
    return Position + UDim2.fromScale( Amount, Amount2 )
end

Storage.BuildScreen = function()
    local Value1
    local Clone = Template3:Clone( )
    Clone.Name = "CaseFXLive"
    Clone:SetAttribute( "Screen", "CaseFXLive" )
    local Table = { gui = Clone, fade = { } }
    Table.bars = { }
    local Table2 = { "BarTop", "BarBottom" }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Frame
        local FoundChild2 = Clone:FindFirstChild( Value, true )

        if not FoundChild2 or not FoundChild2:IsA( "GuiObject" ) then
            Frame = Instance.new( "Frame" )
        else
            Frame = FoundChild2
        end

        local Number5 = Key ~= 1 and 1.2 or -1.2
        local Position3 = Frame.Position
        local Position4 = Position3 + UDim2.new( 0, 0, Number5 * Frame.Size.Y.Scale, Number5 * Frame.Size.Y.Offset )
        Frame.Position = Position4
        Frame.Visible = true
        Table.bars[ Key ] = { frame = Frame, shown = Position3, hidden = Position4 }
    end

    local Flash2
    local Flash = Clone:FindFirstChild( "Flash", true )

    if not Flash or not Flash:IsA( "GuiObject" ) then
        Flash2 = Instance.new( "Frame" )
    else
        Flash2 = Flash
    end

    local Title2
    Table.flash = Flash2
    local Flash3 = Table.flash
    local Flash4 = Table.flash
    Flash3.BackgroundTransparency = 1
    Flash4.Visible = true
    local Title = Clone:FindFirstChild( "Title", true )

    if not Title or not Title:IsA( "TextLabel" ) then
        Title2 = Instance.new( "TextLabel" )
    else
        Title2 = Title
    end

    local Current2
    Table.title = Title2
    local Current = Clone:FindFirstChild( "Current", true )

    if not Current or not Current:IsA( "TextLabel" ) then
        Current2 = Instance.new( "TextLabel" )
    else
        Current2 = Current
    end

    local Name
    Table.current = Current2
    local WeaponName = Clone:FindFirstChild( "WeaponName", true )

    if not WeaponName or not WeaponName:IsA( "TextLabel" ) then
        Name = Instance.new( "TextLabel" )
    else
        Name = WeaponName
    end

    local Badge2
    Table.name = Name
    local Badge = Clone:FindFirstChild( "Badge", true )

    if not Badge or not Badge:IsA( "GuiObject" ) then
        Badge2 = Instance.new( "Frame" )
    else
        Badge2 = Badge
    end

    local YouGot2
    Table.badge = Badge2
    local Table3 = {
        title = Table.title,
        current = Table.current,
        name = Table.name,
        badge = Table.badge
    }
    local YouGot = Clone:FindFirstChild( "YouGot", true )

    if not YouGot or not YouGot:IsA( "GuiObject" ) then
        YouGot2 = Instance.new( "Frame" )
    else
        YouGot2 = YouGot
    end

    local Note2
    Table3.youGot = YouGot2
    local Note = Clone:FindFirstChild( "Note", true )

    if not Note or not Note:IsA( "GuiObject" ) then
        Note2 = Instance.new( "Frame" )
    else
        Note2 = Note
    end

    local Banner2
    Table3.note = Note2
    local Banner = Clone:FindFirstChild( "Banner", true )

    if not Banner or not Banner:IsA( "GuiObject" ) then
        Banner2 = Instance.new( "Frame" )
    else
        Banner2 = Banner
    end

    local Edge
    Table3.banner = Banner2
    local EdgeGlow = Clone:FindFirstChild( "EdgeGlow", true )

    if not EdgeGlow or not EdgeGlow:IsA( "GuiObject" ) then
        Edge = Instance.new( "Frame" )
    else
        Edge = EdgeGlow
    end

    local Value2
    Table3.edge = Edge
    Table.note = Table3.note
    Value2 = nil

    for Key2, Value3 in Table3, nil, nil do
        Value3.Visible = true
        local Fade2 = Table.fade
        Fade2[ Key2 ] = Storage.NewFader( Value3 )
        Table.fade[ Key2 ].set( 0 )
    end

    local NameScale
    local UIScale = Table.name:FindFirstChildOfClass( "UIScale" )

    if UIScale then
        NameScale = UIScale
    else
        NameScale = Instance.new( "UIScale" )
    end

    local BannerScale
    local NameFull = NameScale.Scale
    Table.nameScale = NameScale
    Table.nameFull = NameFull
    local UIScale2 = Table3.banner:FindFirstChildOfClass( "UIScale" )

    if UIScale2 then
        BannerScale = UIScale2
    else
        BannerScale = Instance.new( "UIScale" )
    end

    local BadgeScale
    local BannerFull = BannerScale.Scale
    Table.bannerScale = BannerScale
    Table.bannerFull = BannerFull
    local UIScale3 = Table.badge:FindFirstChildOfClass( "UIScale" )

    if UIScale3 then
        BadgeScale = UIScale3
    else
        BadgeScale = Instance.new( "UIScale" )
    end

    local BadgeText
    local BadgeFull = BadgeScale.Scale
    Table.badgeScale = BadgeScale
    Table.badgeFull = BadgeFull
    local Text = Table.badge:FindFirstChild( "Text", true )

    if not Text or not Text:IsA( "TextLabel" ) then
        BadgeText = Instance.new( "TextLabel" )
    else
        BadgeText = Text
    end

    local Card
    Table.badgeText = BadgeText
    local Stats = Clone:FindFirstChild( "Stats", true )

    if not Stats or not Stats:IsA( "GuiObject" ) then
        Card = Instance.new( "Frame" )
    else
        Card = Stats
    end

    local Number
    Table.card = Card
    local CardShown = Table.card.Position
    local Position = Table.card.Position
    Number = not ( Position.X.Scale >= 0.5 ) and -0.34 or 0.34
    local Number2 = not ( Position.Y.Scale >= 0.5 ) and -0 or 0
    local Value4
    local CardHidden = Position + UDim2.fromScale( Number, Number2 )
    Table.cardShown = CardShown
    Table.cardHidden = CardHidden
    local Card2 = Table.card
    local Card3 = Table.card
    Card2.Position = Table.cardHidden
    Card3.Visible = true
    Table.statRows = { }
    Value4 = nil

    for Key3, Value5 in Storage.Table14, nil, nil do
        local Card4 = Table.card
        local FoundChild = Card4:FindFirstChild( Value5[ 1 ], true )

        if FoundChild then
            local Fill2
            local Fill = FoundChild:FindFirstChild( "Fill", true )

            if not Fill or not Fill:IsA( "GuiObject" ) then
                Fill2 = Instance.new( "Frame" )
            else
                Fill2 = Fill
            end

            local Value7
            local StatRows = Table.statRows
            local Table4 = { }
            local Value6 = FoundChild:FindFirstChild( "Value", true )

            if not Value6 or not Value6:IsA( "TextLabel" ) then
                Value7 = Instance.new( "TextLabel" )
            else
                Value7 = Value6
            end

            Table4.value = Value7
            Table4.fill = Fill2
            Table4.height = Fill2.Size.Y
            Table4.suffix = FoundChild:GetAttribute( "Suffix" ) or ""
            StatRows[ Key3 ] = Table4
            Fill2.Size = UDim2.new( UDim.new( 0, 0 ), Fill2.Size.Y )
        end
    end

    local Glow2
    Table.wrap = Need( Clone, "Reel", "GuiObject" )
    Table.canvas = Need( Table.wrap, "Canvas", "GuiObject" )
    Table.strip = Need( Table.wrap, "Strip", "GuiObject" )
    Table.tileModel = Need( Table.strip, "Tile", "GuiObject" )
    local Glow = Table.wrap:FindFirstChild( "Glow", true )

    if not Glow or not Glow:IsA( "GuiObject" ) then
        Glow2 = Instance.new( "Frame" )
    else
        Glow2 = Glow
    end

    local Number3
    Table.glow = Glow2
    Table.glowFade = Storage.NewFader( Table.glow )
    local Fade = Table.fade
    Fade.reel = Storage.NewFader( Table.wrap, Table.strip )
    local ReelShown = Table.wrap.Position
    local Position2 = Table.wrap.Position
    Number3 = not ( Position2.X.Scale >= 0.5 ) and -0 or 0
    local Number4 = not ( Position2.Y.Scale >= 0.5 ) and -0.485 or 0.485
    local ReelHidden = Position2 + UDim2.fromScale( Number3, Number4 )
    Table.reelShown = ReelShown
    Table.reelHidden = ReelHidden
    local Wrap = Table.wrap
    local Wrap2 = Table.wrap
    Wrap.Position = Table.reelHidden
    Wrap2.Visible = true
    Clone.Visible = true
    Clone.Parent = Template3.Parent
    return Table
end

Storage.Luma = function( Argument1 )
    return 0.299 * Argument1.R + 0.587 * Argument1.G + 0.114 * Argument1.B
end

Storage.RarityGradient = function( GradientName, Argument2 )
    local Entry2
    local Entry = ItemRender.TILE_GRAD[ GradientName ]
    Entry2 = if Entry then Entry else ItemRender.TILE_GRAD.gun
    local Value9, Value10
    local Keypoints = Entry2.Keypoints
    local Value = Keypoints[ 1 ].Value
    local Value2 = Keypoints[ #Keypoints ].Value

    if 0.299 * Value.R + 0.587 * Value.G + 0.114 * Value.B < 0.299 * Value2.R + 0.587 * Value2.G + 0.114 * Value2.B then
        Value9 = Value2
        Value10 = Value
    else
        Value9 = Value
        Value10 = Value2
    end

    local Value1, Number, Number2
    local Keypoints2 = Argument2.Keypoints
    Value1 = nil
    Number = -math.huge
    Number2 = math.huge

    for Key, Value3 in Keypoints2, nil, nil do
        local Value7 = Value3.Value
        Number2 = math.min( Number2, 0.299 * Value7.R + 0.587 * Value7.G + 0.114 * Value7.B )
        local Value8 = Value3.Value
        Number = math.max( Number, 0.299 * Value8.R + 0.587 * Value8.G + 0.114 * Value8.B )
    end

    local Value4
    local Table = { }
    local Keypoints3 = Argument2.Keypoints
    Value4 = nil

    for Key2, Value5 in Keypoints3, nil, nil do
        local R2
        local Time = Value5.Time

        if Number - Number2 > 0.001 then
            local Value6 = Value5.Value
            local R = ( 0.299 * Value6.R + 0.587 * Value6.G + 0.114 * Value6.B - Number2 ) / ( Number - Number2 )

            if R then
                R2 = R
            else
                R2 = 1
            end
        else
            R2 = 1
        end

        Table[ Key2 ] = ColorSequenceKeypoint.new( Time, Value10:Lerp( Value9, R2 ) )
    end

    return ColorSequence.new( Table )
end

CamoSwatch = function( Parent, Argument2 )
    local _, Split2 = AttachmentCases.Split( Argument2 )
    local Entry = ModCatalog.Skins[ Split2 ]

    if not Entry then
        return nil
    end

    local BackgroundColor3
    local Parent2 = Instance.new( "Frame" )
    Parent2.Name = "ItemView"
    Parent2.BackgroundTransparency = 1
    Parent2.Size = UDim2.fromScale( 1, 1 )
    local Parent3 = Instance.new( "ImageLabel" )
    Parent3.Name = "Swatch"
    Parent3.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Parent3.Position = UDim2.fromScale( 0.5, 0.5 )
    Parent3.Size = UDim2.fromScale( 0.86, 0.86 )
    local Color = Entry.Color
    BackgroundColor3 = if Color then Color else Color3.fromRGB( 128, 128, 128 )
    Parent3.BackgroundColor3 = BackgroundColor3
    Parent3.BackgroundTransparency = 0
    Parent3.Image = Entry.Texture or ""
    Parent3.ScaleType = Enum.ScaleType.Crop
    Parent3.Parent = Parent2
    local UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
    UIAspectRatioConstraint.AspectRatio = 1
    UIAspectRatioConstraint.Parent = Parent3
    local UICorner = Instance.new( "UICorner" )
    UICorner.CornerRadius = UDim.new( 0.08, 0 )
    UICorner.Parent = Parent3
    local UIStroke = Instance.new( "UIStroke" )
    UIStroke.Color = Color3.fromRGB( 14, 14, 18 )
    UIStroke.Thickness = 0.03
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = Parent3
    Parent2.Parent = Parent
    return Parent2
end

ItemThumb = function( Parent, Object )
    local Pivot
    Parent.Image = ""
    local Parent2 = Instance.new( "ViewportFrame" )
    Parent2.Name = "ItemView"
    Parent2.Size = UDim2.fromScale( 1, 1 )
    Parent2.BackgroundTransparency = 1
    Parent2.Ambient = Color3.fromRGB( 190, 190, 196 )
    Parent2.LightColor = Color3.new( 1, 1, 1 )
    Parent2.LightDirection = Vector3.new( -0.4000000059604645, -1, -0.6000000238418579 )
    local Clone = Object:Clone( )
    Clone.Parent = Parent2
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 30
    CurrentCamera.Parent = Parent2
    Parent2.CurrentCamera = CurrentCamera

    if Clone.PrimaryPart then
        local CFrame2 = Clone.PrimaryPart.CFrame

        if CFrame2 then
            Pivot = CFrame2
        else
            Pivot = Clone:GetPivot( )
        end
    else
        Pivot = Clone:GetPivot( )
    end

    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Transparency < 0.9 then
            local Value1
            local Size = Value.Size / 2
            local Table = { -1, 1 }
            Value1 = nil

            for Key2, Value2 in Table, nil, nil do
                local Value3
                local Table2 = { -1, 1 }
                Value3 = nil

                for Key3, Value4 in Table2, nil, nil do
                    local Value5
                    local Table3 = { -1, 1 }
                    Value5 = nil

                    for Key4, Value6 in Table3, nil, nil do
                        local PointToObjectSpace = Pivot:PointToObjectSpace( Value.CFrame:PointToWorldSpace( Size * Vector3.new( Value2, Value4, Value6 ) ) )
                        Result = Result:Min( PointToObjectSpace )
                        Result2 = Result2:Max( PointToObjectSpace )
                    end
                end
            end
        end
    end
    if Result.X == math.huge then
        return
    end

    local X2
    local PointToWorldSpace = Pivot:PointToWorldSpace( ( Result + Result2 ) / 2 )
    local Result3 = Result2 - Result
    local AbsoluteSize = Parent.AbsoluteSize

    if not ( AbsoluteSize.X > 1 ) or not ( AbsoluteSize.Y > 1 ) then
        X2 = 1.45
    else
        local X = AbsoluteSize.X / AbsoluteSize.Y

        if X then
            X2 = X
        else
            X2 = 1.45
        end
    end

    local Z = Result3.Z / X2
    local Max = math.max( Z, Result3.Y, 0.1 ) / 2 / 0.2679491924311227 * 1.12 + Result3.X / 2
    local PointToWorldSpace2 = PointToWorldSpace + Pivot:VectorToWorldSpace( Vector3.new( -1, 0.2199999988079071, 0.14000000059604645 ).Unit ) * Max
    CurrentCamera.CFrame = CFrame.lookAt( PointToWorldSpace2, PointToWorldSpace, Pivot.UpVector )
    Parent2.Parent = Parent
    return Parent2
end

Storage.BuildTiles = function( Argument1, List, List2 )
    local Vector22
    local TileModel = Argument1.tileModel
    local Y = Argument1.canvas.AbsoluteSize.Y
    local AbsoluteSize = TileModel.AbsoluteSize

    if AbsoluteSize.Y < 2 then
        Vector22 = Vector2.new( Y * 0.78 * 1.45, Y * 0.78 )
    else
        Vector22 = AbsoluteSize
    end

    local Max = math.max( math.floor( Vector22.Y ), 1 )
    local Max2 = math.max( math.floor( Max * Vector22.X / Vector22.Y ), 1 )
    local Max3 = math.max( 6, ( math.floor( Y * ( tonumber( TileModel:GetAttribute( "Gap" ) ) or 0.06 ) ) ) )
    TileModel.Parent = nil

    for Key, Value in TileModel:GetChildren( ) do
        if Value:IsA( "UIAspectRatioConstraint" ) or Value:IsA( "UISizeConstraint" ) then
            Value:Destroy( )
        end
    end

    local Color
    local AbsoluteSize2 = Argument1.canvas.AbsoluteSize
    TileModel.Size = ScaleUI.FromPx( Max2, Max, AbsoluteSize2 )
    local X = TileModel.AnchorPoint.X
    local Y2 = TileModel.Position.Y
    local UIGradient = TileModel:FindFirstChildOfClass( "UIGradient" )
    Color = UIGradient and TileModel:GetAttribute( "RarityColor" ) ~= false and UIGradient.Color or nil
    local Value1
    local Number = tonumber( TileModel:GetAttribute( "WonScale" ) ) or 1.1
    local Table = { }
    local Table2 = { }
    local Table3 = { }
    Value1 = nil

    for Key2, Value2 in List, nil, nil do
        local ImageLabel
        local Clone = TileModel:Clone( )
        Clone.Name = "Tile" .. Key2
        Clone.Position = UDim2.new( UDim.new( ( ( Key2 - 1 ) * ( Max2 + Max3 ) + Max2 * X ) / math.max( AbsoluteSize2.X, 1 ), 0 ), Y2 )
        Clone.Visible = true
        local Icon = Clone:FindFirstChild( "Icon", true )

        if not Icon or not Icon:IsA( "ImageLabel" ) then
            ImageLabel = Instance.new( "ImageLabel" )
        else
            ImageLabel = Icon
        end

        local TextLabel
        local Label = Clone:FindFirstChild( "Label", true )

        if not Label or not Label:IsA( "TextLabel" ) then
            TextLabel = Instance.new( "TextLabel" )
        else
            TextLabel = Label
        end

        local Frame
        local Dim = Clone:FindFirstChild( "Dim", true )

        if not Dim or not Dim:IsA( "GuiObject" ) then
            Frame = Instance.new( "Frame" )
        else
            Frame = Dim
        end

        local Stroke = Clone:FindFirstChild( "Stroke" )
        local StrokeWon = Clone:FindFirstChild( "StrokeWon" )
        Frame.Visible = true

        if Color then
            local UIGradient2 = Clone:FindFirstChildOfClass( "UIGradient" )
            UIGradient2.Color = TileShape( TierKey( Value2 ) )
            UIGradient2.Rotation = 90
        end

        local Flag = AttachmentCases.Split( Value2 ) ~= nil and true or false

        if Flag then
            if AttachmentCases.Split( Value2 ) == "Skin" then
                ImageLabel.Image = ""
                CamoSwatch( ImageLabel, Value2 )
            elseif not List2 or not List2[ Value2 ] then
                ImageLabel.Image = ""
            else
                ItemThumb( ImageLabel, List2[ Value2 ] )
            end
        else
            local SetIcon = ItemRender.SetIcon
            SetIcon( ImageLabel, ItemRender.Icon( {
                GetAttribute = function( Argument1, Name )
                    local Captured = Name == "Weapon" and Value2 or nil
                    return Captured
                end
            } ) )
        end

        local Flag2 = AttachmentCases.Split( Value2 ) ~= nil and true or false
        local Text

        if Flag2 then
            Text = AttachmentCases.Name( Value2 )
        else
            local Entry = WeaponData[ Value2 ]

            if not Entry or not Entry.Name then
                local ToolName2 = ToolName( Value2 )

                if ToolName2 then
                    Text = ToolName2
                else
                    Text = Value2
                end
            else
                Text = Entry.Name
            end
        end

        TextLabel.Text = Text
        local Table4 = { }

        local function Add( List, Key )
            if List[ Key ] >= 1 then
                return
            end

            local Number

            if List == Frame or List:IsDescendantOf( Frame ) then
                Number = 4
            elseif List == StrokeWon then
                Number = 5
            elseif List == ImageLabel or List:IsDescendantOf( ImageLabel ) then
                Number = 2
            elseif List == TextLabel or List:IsDescendantOf( TextLabel ) then
                Number = 3
            else
                Number = 1
            end

            table.insert( Table4, { List, Key, 1 - List[ Key ], Number } )
            List[ Key ] = 1
        end

        Storage.FadeProps( Clone, Add )

        for Key3, Value4 in Clone:GetDescendants( ) do
            Storage.FadeProps( Value4, Add )
        end

        local UIScale2
        local UIScale = Clone:FindFirstChildOfClass( "UIScale" )

        if UIScale then
            UIScale2 = UIScale
        else
            UIScale2 = Instance.new( "UIScale" )
        end

        local Scale = UIScale2.Scale
        Table2[ Key2 ] = {
            frame = Clone,
            img = ImageLabel,
            imgSize = ImageLabel.Size,
            items = Table4,
            stroke = Stroke,
            strokeWon = StrokeWon,
            scale = UIScale2,
            wonScale = Scale * Number
        }
        Clone.Parent = Argument1.strip
        table.insert( Table3, ImageLabel )
    end

    TileModel:Destroy( )
    return Table2, Table3, Max2, Max3, AbsoluteSize2
end

Storage.FillStats = function( Argument1, StatsName, List )
    local Value1
    local Entry = WeaponData[ StatsName ]
    Value1 = nil

    for Key, Value in Storage.Table14, nil, nil do
        local Entry2 = Argument1.statRows[ Key ]

        if Entry2 then
            local Value2, Number
            Value2 = nil
            Number = 0

            for Key2, Value3 in List, nil, nil do
                local Flag
                local Entry3 = WeaponData[ Value3 ]

                if type( Entry3 ) == "table" then
                    Flag = Value[ 2 ]( Entry3 )
                else
                    Flag = false
                end
                if Flag and Number < Flag then
                    Number = Flag
                end
            end

            local Value6

            if type( Entry ) == "table" then
                local Value4 = Value[ 2 ]( Entry )

                if Value4 then
                    Value6 = Value4
                else
                    Value6 = nil
                end
            else
                Value6 = nil
            end

            local Text2
            local Value5 = Entry2.value

            if Value6 then
                local Text = tostring( ( math.floor( Value6 + 0.5 ) ) ) .. Entry2.suffix

                if Text then
                    Text2 = Text
                else
                    Text2 = "-"
                end
            else
                Text2 = "-"
            end

            local Clamp2
            Value5.Text = Text2

            if not Value6 or not ( Number > 0 ) then
                Clamp2 = 0
            else
                local Clamp = math.clamp( Value6 / Number, 0.05, 1 )

                if Clamp then
                    Clamp2 = Clamp
                else
                    Clamp2 = 0
                end
            end

            task.delay( 0.3 + Key * 0.12, function()
                local Fill = Entry2.fill
                Tween( Fill, 0.6, { Size = UDim2.new( UDim.new( Clamp2, 0 ), Entry2.height ) }, Enum.EasingStyle.Quart )
            end )
        end
    end
end

Storage.Flash = function( Argument1, Attribute, Amount, Argument4 )
    local BackgroundColor3 = Argument1.flash:GetAttribute( Attribute )

    if typeof( BackgroundColor3 ) == "Color3" then
        Argument1.flash.BackgroundColor3 = BackgroundColor3
    end

    local Flash = Argument1.flash
    Flash.BackgroundTransparency = 1 - Amount
    Tween( Argument1.flash, Argument4, { BackgroundTransparency = 1 } )
end

Storage.HideHud = function( Argument1 )
    local Table = { }

    for Key, Value in Screens.All( PlayerGui ) do
        local Obj = Value.obj
        local Name = Value.name

        if Obj ~= Argument1 and Obj ~= Template2 and Name ~= "GamepadHints" and Name ~= "GamepadSelection" and Name ~= "Notifications" and Screens.IsShown( Obj ) then
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

Storage.Table15 = { cf = CFrame.identity, fov = 70, shake = 0, kick = 0, punch = 0 }

Storage.Director = function( Amount )
    Storage.Table15.kick = Storage.Table15.kick * math.exp( -5 * Amount )
    Storage.Table15.punch = Storage.Table15.punch * math.exp( -6 * Amount )
    local Clock = os.clock( ) * 11
    local Rad = math.rad( Storage.Table15.shake + Storage.Table15.kick )
    local Angles = CFrame.Angles( Rad * 2 * math.noise( Clock, 0.31 ), Rad * 2 * math.noise( 0.73, Clock ), Rad * 1.2 * math.noise( Clock, 4.17 ) )
    ClientState.FixedCamera = Storage.Table15.cf * Angles
    ClientState.FixedFOV = Storage.Table15.fov + Storage.Table15.punch
end

Storage.Table16 = { }

Storage.Later = function( Argument1 )
    table.insert( Storage.Table16, Argument1 )
end

Storage.RunCleanups = function()
    local Count = #Storage.Table16
    local I = Count

    for I = Count, 1, -1 do
        pcall( Storage.Table16[ I ] )
    end

    table.clear( Storage.Table16 )
end

Storage.Roll = function( p1, p2 )
    -- Could not structure function #180
end

Storage.Table17 = {
    money = "Not enough money",
    far = "Stand on the circle",
    busy = "Wait %ds",
    dead = "",
    nocase = "Case unavailable",
    roll = "Cases reopen after the weapon roll (%ds)",
    invfull = "Your inventory is full",
    loading = "Your data is still loading, try again"
}

Callback = function()
    if Flag2 or Flag3 or not Value3 then
        return
    end
    if os.clock( ) - Number < 0.35 then
        return
    end
    if Flag4 then
        return
    end
    if ( tonumber( LocalPlayer:GetAttribute( "Money" ) ) or 0 ) < Cost( ) then
        Notify.Error( "Not enough money" )
        return
    end

    local Item
    Flag3 = true
    local InvokeServer = OpenCase.InvokeServer
    local ChoicesOf2 = ChoicesOf( Value3 )

    if ChoicesOf2 then
        local Entry = Table5[ Value3 ]

        if Entry then
            Item = Entry
        else
            Item = ChoicesOf2[ 1 ]
        end
    elseif Value3 then
        Item = Value3:GetAttribute( "CaseId" )
    else
        Item = Value3
    end

    local Success, Result = pcall( InvokeServer, OpenCase, Item )
    Flag3 = false

    if not Success or type( Result ) ~= "table" or not Result.ok then
        local Entry3

        if type( Result ) == "table" then
            local Entry2 = Storage.Table17[ Result.err ]

            if Entry2 then
                Entry3 = Entry2
            else
                Entry3 = "Something went wrong, try again"
            end
        else
            Entry3 = "Something went wrong, try again"
        end
        if Entry3:find( "%%d" ) then
            local Flag = if type( Result ) == "table" then Result.left else false
            Entry3 = Entry3:format( ( math.max( 1, ( math.ceil( tonumber( Flag ) or 1 ) ) ) ) )
        end
        if Entry3 ~= "" then
            Notify.Error( Entry3 )
        end

        return
    end
    Flag2 = true
    ClientState.CaseRolling = true

    if Template2.Visible ~= false then
        Template2.Visible = false
        GamepadNav.Close( "CaseMenu" )
    end

    local Success2, Result2 = pcall( Storage.Roll, Value3, Result )

    if not Success2 and Result2 ~= "CaseAborted" then
        warn( "[CaseClient] " .. tostring( Result2 ) )
    end

    local Count = #Storage.Table16
    local I = Count

    for I = Count, 1, -1 do
        pcall( Storage.Table16[ I ] )
    end

    table.clear( Storage.Table16 )
    Flag6 = false
    ClientState.FixedCamera = nil
    ClientState.FixedFOV = nil
    ClientState.CaseRolling = false
    Flag2 = false
    Value4 = nil
    return
end

Need4.Activated:Connect( function()
    Callback( )
end )
function ClientState.PlayCaseRoll( Argument1, Argument2 )
    if Flag2 then
        return false
    end

    Flag2 = true
    ClientState.CaseRolling = true

    if Template2.Visible ~= false then
        Template2.Visible = false
        GamepadNav.Close( "CaseMenu" )
    end

    local Success, Result = pcall( Storage.Roll, Argument1, Argument2 )

    if not Success and Result ~= "CaseAborted" then
        warn( "[CaseClient] " .. tostring( Result ) )
    end

    local Count = #Storage.Table16
    local I = Count

    for I = Count, 1, -1 do
        pcall( Storage.Table16[ I ] )
    end

    table.clear( Storage.Table16 )
    Flag6 = false
    ClientState.FixedCamera = nil
    ClientState.FixedFOV = nil
    ClientState.CaseRolling = false
    Flag2 = false
    Value4 = nil
    return true
end

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Number
Value1 = nil
Number = 0

for Value in Upvalue1, nil, nil do
    Number = Number + 1
end

return Number
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = {
    [ Upvalue1 ] = function()
        if Upvalue2 then
            Upvalue2( )
        end
    end,
    [ Upvalue3 ] = function()
        Upvalue4 = Upvalue5
        Upvalue6( false )
    end
}

if Upvalue7( Upvalue5 ) then
    local Value1 = nil

    for Key, Value in Upvalue8, nil, nil do
        Table[ Value ] = function()
            local Value1 = Upvalue9( Upvalue5 )

            if Value1 and Value1[ Key ] and not Upvalue10 and not Upvalue11 then
                Upvalue12[ Upvalue5 ] = Value1[ Key ]
                Upvalue13( )
            end
        end
    end

    local Value2 = nil

    for Key2, Value3 in Upvalue14, nil, nil do
        Table[ Value3 ] = function()
            local Value1 = Upvalue7( Upvalue5 )

            if Value1 and table.find( Value1, Key2 ) and not Upvalue10 and not Upvalue11 then
                Upvalue12[ Upvalue5 ] = Key2
                Upvalue13( )
            end
        end
    end
end

return Table
]]

--[[
Function #68 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:ScaleTo( Upvalue1:GetScale( ) * Upvalue2 )
]]

--[[
Function #121 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = true
]]

--[[
Function #122 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = true
]]

--[[
Function #123 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
Upvalue2:Disconnect( )
]]

--[[
Function #124 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue1.Anchored = false
end
]]

--[[
Function #125 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Object:GetDescendants( ) do
    if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
        Value.LocalTransparencyModifier = LocalTransparencyModifier
    end
end
]]

--[[
Function #126 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2, 1 )
local Entry = Upvalue3[ Upvalue2 ]

if Entry and Entry.Parent then
    Upvalue1( Entry, 1 )
end
]]

--[[
Function #127 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )

if Upvalue2.Parent then
    Upvalue3( Upvalue2, 0 )
end

local Entry = Upvalue4[ Upvalue2 ]

if Entry and Entry.Parent then
    Upvalue3( Entry, 0 )
end

local Value1 = nil

for Value in Upvalue5, nil, nil do
    if Value.Parent then
        Value.Enabled = true
    end
end
]]

--[[
Function #128 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:PivotTo( Upvalue2 )
Upvalue3( Upvalue1, 0 )
local Pivot = Upvalue1:GetPivot( )

for Key, Value in Upvalue4( Upvalue1 ) do
    local RestOffset = Value:GetAttribute( "RestOffset" )

    if RestOffset then
        Value.CFrame = Pivot * RestOffset
    end
end
]]

--[[
Function #129 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = true
]]

--[[
Function #130 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 * Upvalue2 * CFrame.Angles( 0, Argument1, 0 ) * Upvalue3
]]

--[[
Function #131 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #132 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #133 has no emitted closure site
It is reproduced here so that nothing is lost

-- empty function
]]

--[[
Function #134 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1.set( Argument1 )
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    Value.set( Argument1 )
end
]]

--[[
Function #135 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
Upvalue2:Destroy( )
]]

--[[
Function #136 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.gui:Destroy( )
]]

--[[
Function #137 has no emitted closure site
It is reproduced here so that nothing is lost

return nil
]]

--[[
Function #138 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Request( Upvalue2 )
]]

--[[
Function #139 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Close( "CaseRoll" )
]]

--[[
Function #140 has no emitted closure site
It is reproduced here so that nothing is lost

return ( math.max( Upvalue1[ Key ] or 0, 1.5 ) )
]]

--[[
Function #141 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return Upvalue3.Pick( Upvalue2, function( Key )
        return ( math.max( Upvalue1[ Key ] or 0, 1.5 ) )
    end, Upvalue4 )
end
return Upvalue2[ math.random( 1, #Upvalue2 ) ]
]]

--[[
Function #142 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Value then
        Value:Destroy( )
    end
end
]]

--[[
Function #143 has no emitted closure site
It is reproduced here so that nothing is lost

local Strip = Upvalue1.strip
Strip.Position = Upvalue2.FromPx( Argument1, 0, Upvalue3 )
]]

--[[
Function #144 has no emitted closure site
It is reproduced here so that nothing is lost

local Canvas = Upvalue1.canvas

if not Upvalue2 or Canvas.AbsoluteSize.X < 2 then
    return 0.5
end
return ( math.clamp( ( Upvalue2.AbsolutePosition.X + Upvalue2.AbsoluteSize.X / 2 - Canvas.AbsolutePosition.X ) / Canvas.AbsoluteSize.X, 0, 1 ) )
]]

--[[
Function #145 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp6
local X = Upvalue1.X
local Scale = Upvalue2.strip.Position.X.Scale * X + Upvalue2.strip.Position.X.Offset

if not Upvalue3 or not ( Amount > 0 ) then
    Clamp6 = 0
else
    local Clamp = math.clamp( math.abs( Scale - Upvalue3 ) / Amount / ( Upvalue4 * 12 ), 0, 1 )

    if Clamp then
        Clamp6 = Clamp
    else
        Clamp6 = 0
    end
end

local Min3
Upvalue3 = Scale

if Upvalue5 then
    local Min = 1 - ( 1 - math.min( ( os.clock( ) - Upvalue5 ) / 0.4, 1 ) ) ^ 2

    if Min then
        Min3 = Min
    else
        Min3 = 0
    end
else
    Min3 = 0
end

local Max = math.max( 1, ( math.floor( -Scale / Upvalue4 ) ) )
local Count = #Upvalue6
local Min2 = math.min( Count, Max + math.ceil( X / Upvalue4 ) + 2 )
local I = Max

for I = Max, Min2 do
    local Number
    local Entry = Upvalue6[ I ]
    local Scale2 = Scale + ( I - 1 ) * Upvalue4 + Upvalue7 / 2
    local Clamp2 = math.clamp( math.min( Scale2, X - Scale2 ) / ( X * 0.2 ), 0, 1 )
    local Clamp3 = Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 ) * ( 1 - Upvalue8 )
    local Clamp4 = Clamp3 * ( 1 - 0.5 * Clamp6 )
    local Clamp5 = Clamp3 * ( 1 - 0.7 * Clamp6 )
    Number = if Entry.won then 0 else Clamp3 * Min3
    local Clamp8 = Entry.won and Clamp3 or 0
    local Value1
    local Items = Entry.items
    Value1 = nil

    for Key, Value in Items, nil, nil do
        local Clamp7
        local Item = Value[ 4 ]
        local Item2 = Value[ 1 ]
        local Item3 = Value[ 2 ]
        local Item4 = Value[ 3 ]

        if Item ~= 1 or not Clamp3 then
            if Item ~= 2 or not Clamp4 then
                if Item ~= 3 or not Clamp5 then
                    if Item ~= 4 or not Number then
                        Clamp7 = Clamp8
                    else
                        Clamp7 = Number
                    end
                else
                    Clamp7 = Clamp5
                end
            else
                Clamp7 = Clamp4
            end
        else
            Clamp7 = Clamp3
        end

        Item2[ Item3 ] = 1 - Item4 * Clamp7
    end

    local ImgSize = Entry.imgSize
    local Img = Entry.img
    Img.Size = UDim2.new( ImgSize.X.Scale * ( 1 + 0.5 * Clamp6 ), ImgSize.X.Offset * ( 1 + 0.5 * Clamp6 ), ImgSize.Y.Scale, ImgSize.Y.Offset )
end
]]

--[[
Function #146 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #147 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.pop = Upvalue1.pop * math.exp( -14 * Amount )

if Upvalue2 and not Upvalue1.hold then
    local Value1
    local Clock = os.clock( ) - Upvalue3
    local Captured = Upvalue4 + Vector3.new( 0, Upvalue1.lift + math.sin( Clock * 3 ) * 0.06 + 0.22 * Upvalue1.pop, 0 )
    local Spin = Upvalue1.spin + math.sin( Clock * 1.3 ) * Upvalue1.sway
    local Captured2 = Upvalue5 * Upvalue6 * CFrame.Angles( 0, Spin, 0 ) * Upvalue7
    local Center = ( Upvalue2:GetAttribute( "Center" ) or Vector3.new( 0, 0, 0 ) ) * 1
    Upvalue2:PivotTo( CFrame.new( Captured ) * Captured2 * CFrame.new( -Center ) )
    Value1 = nil

    for Key, Value in Upvalue8, nil, nil do
        local Item = Value[ 1 ]
        Item.CFrame = CFrame.new( Captured ) * Value[ 2 ]
    end
end
]]

--[[
Function #148 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #149 has no emitted closure site
It is reproduced here so that nothing is lost

local FoundChild

if Upvalue1 then
    FoundChild = Upvalue1:FindFirstChild( Name )
else
    FoundChild = Upvalue1
end

local Anchor = FoundChild and FoundChild:GetAttribute( "Anchor" ) or Name2

if Anchor == "Weapon" then
    local Captured = Upvalue2 + Vector3.new( 0, Upvalue3.lift, 0 )
    local FxClone2 = Upvalue4( Upvalue5, Name, CFrame.new( Captured ) * Upvalue6 )

    if FxClone2 then
        table.insert( Upvalue7, { FxClone2, CFrame.new( Captured ):ToObjectSpace( FxClone2.CFrame ) } )
    end

    return FxClone2
end
local Flag = Anchor == "Case" and true or false
return ( Upvalue4( Upvalue5, Name, Upvalue8, Flag ) )
]]

--[[
Function #150 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Upvalue2[ Key ] ] or nil

if Upvalue3 and Upvalue3 ~= Entry then
    Upvalue3.Parent = nil
end
if Entry and Entry.Parent ~= Upvalue4 then
    Entry.Parent = Upvalue4
end

local Flag
Upvalue3 = Entry
local Current = Upvalue5.current
local Entry2 = Upvalue2[ Key ]
Flag = Upvalue6.Split( Entry2 ) ~= nil and true or false
local Text

if Flag then
    Text = Upvalue6.Name( Entry2 )
else
    local Entry3 = Upvalue7[ Entry2 ]

    if not Entry3 or not Entry3.Name then
        local ToolName2 = Upvalue8( Entry2 )

        if ToolName2 then
            Text = ToolName2
        else
            Text = Entry2
        end
    else
        Text = Entry3.Name
    end
end

Current.Text = Text
]]

--[[
Function #151 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:UnbindFromRenderStep( "CaseDirector" )
]]

--[[
Function #152 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp3
local Clamp = math.clamp( Amount, 0, 1 )

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

local Lerp = Upvalue1:Lerp( Upvalue2, Clamp3 )
local Lerp2 = Lerp:Lerp( Upvalue2:Lerp( Upvalue3, Clamp3 ), Clamp3 )
local Clamp4 = math.clamp( Amount * 1.3, 0, 1 )
Upvalue4.cf = CFrame.lookAt( Lerp2, Upvalue5:Lerp( Upvalue6, Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 ) ) ) * CFrame.Angles( 0, 0, math.sin( Clamp3 * 3.141592653589793 ) * 0.12217304763960307 )
Upvalue4.fov = Upvalue7 + ( 50 - Upvalue7 ) * Clamp3
]]

--[[
Function #153 has no emitted closure site
It is reproduced here so that nothing is lost

local Number

if Amount < 0.06 then
    Number = 1
elseif not ( Amount > 0.12 ) or not ( Amount < 0.17 ) then
    if Amount > 0.24 then
        Number = 1
    else
        Number = 0.12
    end
else
    Number = 1
end

local Set = Upvalue1.set
local Clamp = math.clamp( Amount / 0.45, 0, 1 )
Set( Number * ( 0.6 + 0.4 * ( Clamp * Clamp * ( 3 - 2 * Clamp ) ) ) )
]]

--[[
Function #154 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Stop( )
]]

--[[
Function #155 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 and Upvalue2 <= Amount2 then
    Upvalue1 = true
    Upvalue3:PlayLocalSound( Upvalue4 )
end

local Number
local Result = Amount ^ 1.6

if Upvalue5 then
    Number = 0.5
elseif Upvalue6 then
    Number = 1.3
else
    Number = 1
end

local Clamp2
local Result2 = Result * Number
local Result3 = Amount2 * 38

if Upvalue6 then
    local Clamp = 0.45 * ( 1 - ( 1 - math.clamp( Amount, 0, 1 ) ) ^ 3 )

    if Clamp then
        Clamp2 = Clamp
    else
        Clamp2 = 0
    end
else
    Clamp2 = 0
end
if Upvalue6 and Upvalue7 <= Amount2 then
    Upvalue7 = Amount2 + 0.55 - 0.35 * Amount
    Upvalue3:PlayLocalSound( Upvalue8 )
    Upvalue9.punch = Upvalue9.punch - 1.2
end

local Number2
Upvalue10:PivotTo( Upvalue11 * CFrame.new( 0, Clamp2, 0 ) * CFrame.new( math.noise( Result3, 1.3 ) * 0.09 * Result2, math.abs( ( math.noise( Result3, 7.7 ) ) ) * 0.06 * Result2, math.noise( 3.1, Result3 ) * 0.07 * Result2 ) * CFrame.Angles( math.noise( Result3, 5.5 ) * 0.05235987755982989 * Result2, math.noise( 9.2, Result3 ) * 0.04363323129985824 * Result2, math.noise( Result3, 2.2 ) * 0.05235987755982989 * Result2 ) )
local Clamp3 = math.clamp( Amount * 1.15, 0, 1 )
local Clamp4 = Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) * ( math.sin( Amount2 * 22 ) * 0.25 + 0.75 )
Number2 = not Upvalue5 and 1 or 0.5
local Clamp5 = Clamp4 * Number2
local OutlineTransparency = 1 - 0.9 * Clamp5
local FillTransparency = 1 - 0.3 * Clamp5
Upvalue12.OutlineTransparency = OutlineTransparency
Upvalue12.FillTransparency = FillTransparency
local Range = 10 * Amount
local Brightness = 2.5 * Amount
Upvalue13.Range = Range
Upvalue13.Brightness = Brightness
Upvalue14.set( 1 + 0.12 * math.noise( Amount2 * 14, 0.5 ) )
Upvalue9.shake = 0.35 * Result2
local Clamp6 = math.clamp( Amount, 0, 1 )
Upvalue9.cf = Upvalue15:Lerp( Upvalue16, Clamp6 * Clamp6 * ( 3 - 2 * Clamp6 ) )
]]

--[[
Function #156 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:PivotTo( Upvalue2 * CFrame.new( 0, 0.45 * ( 1 - Argument1 * Argument1 ), 0 ) )
]]

--[[
Function #157 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2, 0.8, { Brightness = 2.2, Range = 12 } )
]]

--[[
Function #158 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( Argument1, 0, 1 ) - 1
Upvalue1( Upvalue2, Upvalue3 * ( 1 + 3.4 * Clamp ^ 3 + 2.4 * Clamp ^ 2 ) )
]]

--[[
Function #159 has no emitted closure site
It is reproduced here so that nothing is lost

return ( Amount - 1 ) * Upvalue1 + Upvalue2 / 2
]]

--[[
Function #160 has no emitted closure site
It is reproduced here so that nothing is lost

local Floor = math.floor( ( Upvalue1 - Argument1 + Upvalue2 / 2 ) / Upvalue3 ) + 1
return ( math.clamp( Floor, 1, #Upvalue4 ) )
]]

--[[
Function #161 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
Upvalue2.TimePosition = 0
Upvalue2:Play( )
return
]]

--[[
Function #162 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 <= Argument2 then
    if not Upvalue2 then
        Upvalue2 = true
        Upvalue3.TimePosition = 0
        Upvalue3:Play( )
    end
end

local Captured = Upvalue4 + ( Upvalue5 - Upvalue4 ) * ( 1 - ( 1 - Amount ) ^ 3.4 )
local Strip = Upvalue6.strip
Strip.Position = Upvalue7.FromPx( Captured, 0, Upvalue8 )
local Floor = math.floor( ( Upvalue9 - Captured + Upvalue10 / 2 ) / Upvalue11 ) + 1
local Clamp = math.clamp( Floor, 1, #Upvalue12 )

if Clamp ~= Upvalue13 then
    Upvalue13 = Clamp
    local Entry = Upvalue14[ Upvalue12[ Clamp ] ] or nil

    if Upvalue15 and Upvalue15 ~= Entry then
        Upvalue15.Parent = nil
    end
    if Entry and Entry.Parent ~= Upvalue16 then
        Entry.Parent = Upvalue16
    end

    local Flag
    Upvalue15 = Entry
    local Current = Upvalue6.current
    local Entry2 = Upvalue12[ Clamp ]
    Flag = Upvalue17.Split( Entry2 ) ~= nil and true or false
    local Text

    if Flag then
        Text = Upvalue17.Name( Entry2 )
    else
        local Entry3 = Upvalue18[ Entry2 ]

        if not Entry3 or not Entry3.Name then
            local ToolName2 = Upvalue19( Entry2 )

            if ToolName2 then
                Text = ToolName2
            else
                Text = Entry2
            end
        else
            Text = Entry3.Name
        end
    end

    Current.Text = Text
    Upvalue20.pop = 1

    if os.clock( ) - Upvalue21 > 0.035 then
        Upvalue21 = os.clock( )
        Upvalue22.PlaybackSpeed = 0.92 + math.random( ) * 0.12
        Upvalue23:PlayLocalSound( Upvalue22 )
    end

    Upvalue24 = 3.05

    if Amount > 0.55 and not Upvalue25 then
        Upvalue26.punch = math.max( Upvalue26.punch - 0.6 * Amount, -4 )
    end
end

Upvalue24 = math.max( 1, Upvalue24 - Amount2 * 11 )
Upvalue6.glowFade.set( Upvalue24 )
local Clamp2 = math.clamp( Amount, 0, 1 )
Upvalue26.cf = Upvalue27:Lerp( Upvalue28, Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 ) )
local Clamp3 = math.clamp( Amount, 0, 1 )
Upvalue26.fov = 50 - 3 * ( Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
Upvalue26.shake = 0.06
]]

--[[
Function #163 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp3
local Captured = Upvalue2 - Upvalue1
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

local Number
local Captured2 = Upvalue1 + Captured * Clamp3
local Strip = Upvalue3.strip
Strip.Position = Upvalue4.FromPx( Captured2, 0, Upvalue5 )
local Set = Upvalue6.set
Number = not Upvalue7 and 0.35 or 0.9
Set( 1 - Number * Argument1 )
]]

--[[
Function #164 has no emitted closure site
It is reproduced here so that nothing is lost

warn( ( "[Caisse] case gagnée décalée (%s) : %.0f px, case %.0f px, écran %.0fx%.0f, canevas %.0fx%.0f, construction %.0fx%.0f" ):format( Upvalue1, Upvalue2, Upvalue3.AbsoluteSize.X, Upvalue4.ViewportSize.X, Upvalue4.ViewportSize.Y, Upvalue5, Upvalue6.AbsoluteSize.Y, Upvalue7.X, Upvalue7.Y ) )
]]

--[[
Function #165 has no emitted closure site
It is reproduced here so that nothing is lost

local Canvas = Upvalue1.canvas
local Frame = Upvalue2[ 47 ].frame
local X = Canvas.AbsoluteSize.X

if X <= 1 or not Frame.Parent then
    return
end

local X3

if Upvalue3 then
    local X2 = Upvalue3.AbsolutePosition.X + Upvalue3.AbsoluteSize.X / 2

    if X2 then
        X3 = X2
    else
        X3 = Canvas.AbsolutePosition.X + X / 2
    end
else
    X3 = Canvas.AbsolutePosition.X + X / 2
end

local X4 = X3 - ( Frame.AbsolutePosition.X + Frame.AbsoluteSize.X / 2 )

if math.abs( X4 ) <= 0.5 then
    return
end
if not Upvalue4 then
    local Abs = math.abs( X4 )

    if Frame.AbsoluteSize.X / 3 < Abs then
        Upvalue4 = true
        pcall( function()
            warn( ( "[Caisse] case gagnée décalée (%s) : %.0f px, case %.0f px, écran %.0fx%.0f, canevas %.0fx%.0f, construction %.0fx%.0f" ):format( Argument1, X4, Frame.AbsoluteSize.X, Upvalue5.ViewportSize.X, Upvalue5.ViewportSize.Y, X, Canvas.AbsoluteSize.Y, Upvalue6.X, Upvalue6.Y ) )
        end )
    end
end

local Strip = Upvalue1.strip
Strip.Position = Strip.Position + UDim2.fromScale( X4 / X, 0 )
]]

--[[
Function #166 has no emitted closure site
It is reproduced here so that nothing is lost

pcall( Upvalue1, "révélation" )
]]

--[[
Function #167 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #168 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #169 has no emitted closure site
It is reproduced here so that nothing is lost

local SetShown = Upvalue1.SetShown
pcall( SetShown, Upvalue2.gui, Argument1 )
]]

--[[
Function #170 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    Upvalue2( Upvalue1, false )
end
]]

--[[
Function #171 has no emitted closure site
It is reproduced here so that nothing is lost

local Text2 = Text .. "_" .. Upvalue1:sub( 1, 1 ):upper( ) .. Upvalue1:sub( 2 )

if Upvalue2 and Upvalue2:FindFirstChild( Text2 ) then
    return ( Upvalue3( Text2, "Weapon" ) )
end

local Value1 = Upvalue3( Text, "Weapon" )

if Value1 then
    Upvalue4( Value1, Upvalue1 )
end

return Value1
]]

--[[
Function #172 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2, 1, { Brightness = 2, Range = 12 } )
]]

--[[
Function #173 has no emitted closure site
It is reproduced here so that nothing is lost

local BadgeScale = Upvalue2.badgeScale
Upvalue1( BadgeScale, 0.4, { Scale = Upvalue2.badgeFull }, Enum.EasingStyle.Back )
]]

--[[
Function #174 has no emitted closure site
It is reproduced here so that nothing is lost

local Sway
local Clamp = math.clamp( Amount / 0.7, 0, 1 ) - 1
Upvalue1.lift = 0.95 + 0.6000000000000001 * ( 1 + 2.6 * Clamp ^ 3 + 1.6 * Clamp ^ 2 )
Upvalue1.spin = 6.283185307179586 * ( 1 - ( 1 - math.clamp( Amount / 1.2, 0, 1 ) ) ^ 3 )

if Amount < 1.2 then
    local Clamp2 = math.clamp( Amount / 0.5, 0, 1 )
    local Captured = Upvalue2 * ( 1 - Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 ) )

    if Captured then
        Sway = Captured
    else
        local Clamp3 = math.clamp( ( Amount - 1.2 ) / 0.8, 0, 1 )
        Sway = 0.15 * ( Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
    end
else
    local Clamp3 = math.clamp( ( Amount - 1.2 ) / 0.8, 0, 1 )
    Sway = 0.15 * ( Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
end

Upvalue1.sway = Sway

if Upvalue3 then
    local Set = Upvalue4.fade.edge.set
    local Sin = math.sin( Amount * 5 ) * 0.36 + 0.64
    local Clamp4 = math.clamp( Amount / 0.3, 0, 1 )
    Set( Sin * ( Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 ) ) )
end

local Clamp5 = math.clamp( Amount / 0.8, 0, 1 )
local Lerp = Upvalue5:Lerp( Upvalue6, Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 ) )
local Captured2 = Upvalue7 - Lerp
local Clamp6 = math.clamp( Argument1, 0, 1 )
local Angles = CFrame.Angles( 0, 0.20943951023931956 * ( Clamp6 * Clamp6 * ( 3 - 2 * Clamp6 ) ), 0 ) * Captured2
local Clamp7 = math.clamp( Argument1, 0, 1 )
Upvalue8.cf = CFrame.lookAt( Lerp + Angles * ( 1 - 0.06 * ( Clamp7 * Clamp7 * ( 3 - 2 * Clamp7 ) ) ), Lerp )
local Clamp8 = math.clamp( Argument1, 0, 1 )
Upvalue8.fov = Upvalue9 + 2 * ( Clamp8 * Clamp8 * ( 3 - 2 * Clamp8 ) )
]]

--[[
Function #175 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Stop( )
]]

--[[
Function #176 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Amount
Upvalue2.lift = Upvalue3 + ( -1.2 - Upvalue3 ) * Amount * Amount

if Upvalue4 then
    Upvalue4.OutlineTransparency = 0.35 + 0.65 * Amount
end
]]

--[[
Function #177 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = math.min( Amount * 1.6, 1 )
local Result = Amount ^ 2.4
local Lerp = Upvalue3:Lerp( ( Upvalue2.cf * CFrame.new( 0, -2.4, -3.2 ) ).Position, Result ) + Vector3.new( 0, math.sin( Amount * 3.141592653589793 ) * 0.8, 0 )
local Captured = Upvalue6 + Amount * 6
Upvalue4( Upvalue5, Lerp, Upvalue7 * Upvalue8 * CFrame.Angles( 0, Captured, 0 ) * Upvalue9, ( math.max( 1 - Result, 0.06 ) ) )

if Upvalue10 then
    Upvalue10.FillTransparency = 0.82 + 0.18 * Amount
end
]]

--[[
Function #178 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Argument1
]]

--[[
Function #179 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp3
local Clamp = math.clamp( Amount, 0, 1 )

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

Upvalue1.cf = Upvalue2:Lerp( Upvalue3, Clamp3 )
Upvalue1.fov = Upvalue4 + ( Upvalue5 - Upvalue4 ) * Clamp3
local Set = Upvalue6.set
local Clamp4 = math.clamp( Amount * 1.4, 0, 1 )
Set( 1.3 * ( 1 - Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 ) ) )
]]
