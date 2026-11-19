-- Players.perkbrokeyou.PlayerGui.RankedModes.RankedModesClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #90

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Text2
local Text = InfoName or ""
Text2 = if Text == "" or not Text then Upvalue1 else Text

if Upvalue2.Text ~= Text2 then
    Upvalue2.Text = Text2
end

local TextColor3 = Text ~= "" and Upvalue3 or Upvalue4

if Upvalue2.TextColor3 ~= TextColor3 then
    Upvalue2.TextColor3 = TextColor3
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue1:GetAttribute( "Enabled" ) == false or not Upvalue1:IsDescendantOf( workspace ) then
    return false
end

local ZoneCF = Upvalue1:GetAttribute( "ZoneCF" )
local ZoneSize = Upvalue1:GetAttribute( "ZoneSize" )

if typeof( ZoneCF ) ~= "CFrame" or typeof( ZoneSize ) ~= "Vector3" then
    return false
end

local HumanoidRootPart
local Character = Upvalue2.Character

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
if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 or Character:GetAttribute( "Downed" ) then
    return false
end
if Upvalue2:GetAttribute( "InTutorial" ) or Upvalue2:GetAttribute( "Onboarding" ) or Upvalue2:GetAttribute( "InWardrobe" ) then
    return false
end

local Flag
local PointToObjectSpace = ZoneCF:PointToObjectSpace( HumanoidRootPart.Position )
local ZoneSize2 = ZoneSize / 2

if math.abs( PointToObjectSpace.X ) <= ZoneSize2.X then
    if math.abs( PointToObjectSpace.Y ) <= ZoneSize2.Y then
        if math.abs( PointToObjectSpace.Z ) <= ZoneSize2.Z then
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

return Flag
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Hotbar
local Inventory = Upvalue1.PlayerGui:FindFirstChild( "Inventory" )

if Inventory then
    local Enabled = Inventory.Enabled

    if Enabled then
        Hotbar = Inventory:FindFirstChild( "Hotbar" )
    else
        Hotbar = Enabled
    end
else
    Hotbar = Inventory
end
if not Hotbar or not Hotbar.Visible then
    return nil
end

local Number = math.huge

for Key, Value in Hotbar:GetChildren( ) do
    local Tile
    local IsA = Value:IsA( "GuiObject" )

    if IsA then
        local Visible = Value.Visible

        if Visible then
            Tile = Value:FindFirstChild( "Tile" )
        else
            Tile = Visible
        end
    else
        Tile = IsA
    end
    if Tile and Tile:IsA( "GuiObject" ) and Tile.AbsoluteSize.Y > 2 then
        Number = math.min( Number, Tile.AbsolutePosition.Y )
    end
end
if Number == math.huge then
    Number = Hotbar.AbsolutePosition.Y
end

local Y = Upvalue2.AbsoluteSize.Y

if Y <= 0 then
    return nil
end
return ( Number + Inventory.AbsolutePosition.Y - Upvalue2.AbsolutePosition.Y ) / Y
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Scale
local UIScale = Upvalue1.UIScale
local TweenInfo2 = TweenInfo.new( 0.12, Enum.EasingStyle.Quad )
local Table = { }
Scale = not Upvalue3.ranked and 1 or 1.04
local Transparency
Table.Scale = Scale
Upvalue2:Create( UIScale, TweenInfo2, Table ):Play( )
local InnerStroke = Upvalue1.InnerStroke
Transparency = not Upvalue3.ranked and 0.84 or 0.55
InnerStroke.Transparency = Transparency
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local ZBase2
local ZBase = Self:GetAttribute( "ZBase" )

if ZBase == nil then
    local ZIndex = Self.ZIndex
    Self:SetAttribute( "ZBase", ZIndex )
    ZBase2 = ZIndex
else
    ZBase2 = ZBase
end

local ZIndex2 = ZBase2 + Argument2

if Self.ZIndex ~= ZIndex2 then
    Self.ZIndex = ZIndex2
end
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Argument1

for Key, Value in Upvalue2:GetDescendants( ) do
    if Value:IsA( "GuiButton" ) and Value.Name:sub( 1, 6 ) == "Carte_" then
        local Flag = Value.Name == "Carte_" .. tostring( Argument1 ) and true or false
        local NotFlag2
        local NotFlag = not Flag

        if NotFlag then
            if Value == Upvalue3 then
                NotFlag2 = true
            else
                NotFlag2 = false
            end
        else
            NotFlag2 = NotFlag
        end

        local Selection = Value:FindFirstChild( "Selection" )

        if Selection then
            local Transparency

            if Flag then
                Transparency = 0
            elseif NotFlag2 then
                Transparency = 0.6
            else
                Transparency = 1
            end

            Selection.Transparency = Transparency
        end

        local Parent = Value.Parent

        if Parent and Parent:IsA( "GuiObject" ) and Parent ~= Upvalue2 then
            local Number

            if Flag then
                Number = 2
            elseif NotFlag2 then
                Number = 1
            else
                Number = 0
            end

            local ZBase2
            local ZBase = Parent:GetAttribute( "ZBase" )

            if ZBase == nil then
                local ZIndex = Parent.ZIndex
                Parent:SetAttribute( "ZBase", ZIndex )
                ZBase2 = ZIndex
            else
                ZBase2 = ZBase
            end

            local ZIndex2 = ZBase2 + Number

            if Parent.ZIndex ~= ZIndex2 then
                Parent.ZIndex = ZIndex2
            end
        end

        local BackgroundTransparency

        if Flag then
            BackgroundTransparency = 0.06
        elseif NotFlag2 then
            BackgroundTransparency = 0.2
        else
            BackgroundTransparency = 0.35
        end

        Value.BackgroundTransparency = BackgroundTransparency
        local UIScale = Value:FindFirstChildOfClass( "UIScale" )

        if UIScale then
            local Scale
            local TweenInfo2 = TweenInfo.new( 0.12, Enum.EasingStyle.Quad )
            local Table = { }

            if Flag then
                Scale = 1
            elseif NotFlag2 then
                Scale = 0.985
            else
                Scale = 0.97
            end

            Table.Scale = Scale
            Upvalue4:Create( UIScale, TweenInfo2, Table ):Play( )
        end
    end
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1

if Upvalue2 then
    Upvalue2( )
    return
end

local Text
Upvalue3.Texte.Text = Upvalue4
Text = if true or not true then Upvalue5 else ""

if Upvalue6.Text ~= Text then
    Upvalue6.Text = Text
end

local TextColor3 = not true and Upvalue7 or Upvalue8

if Upvalue6.TextColor3 ~= TextColor3 then
    Upvalue6.TextColor3 = TextColor3
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
for Key, Value in Upvalue1:GetChildren( ) do
    local Type
    local IsA = Value:IsA( "GuiButton" )

    if IsA then
        Type = Value:GetAttribute( "Type" )
    else
        Type = IsA
    end
    if Type then
        local Flag = Type == Upvalue2 and true or false
        local Text2

        if Flag then
            local Text = "Fond_" .. ( Upvalue3 or Upvalue4[ 1 ] )

            if Text then
                Text2 = Text
            else
                Text2 = "Inactif"
            end
        else
            Text2 = "Inactif"
        end
        for Key2, Value2 in Value:GetChildren( ) do
            if Value2:IsA( "UIGradient" ) then
                local Enabled = Value2.Name == Text2 and true or false
                Value2.Enabled = Enabled
            end
        end

        local Texte = Value:FindFirstChild( "Texte" )

        if Texte then
            local TextTransparency = not Flag and 0.4 or 0
            Texte.TextTransparency = TextTransparency
        end
    end
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1 == "unranked" and true or false

if Upvalue2 then
    local Value1 = nil

    for Key, Value in Upvalue3, nil, nil do
        for Key2, Value2 in Value:GetChildren( ) do
            if Value2:IsA( "UIGradient" ) then
                local Match2
                local Match = Value2.Name:match( "^Fond_(.+)$" )

                if Match then
                    Match2 = Match
                else
                    Match2 = Value2.Name:match( "^Couleur_(.+)$" )
                end
                if Match2 then
                    local Enabled = Match2 == Upvalue2 and true or false
                    Value2.Enabled = Enabled
                end
            end
        end
    end
end

local Value3 = nil

for Key3, Value4 in Upvalue4, nil, nil do
    for Key4, Value5 in Key3:GetChildren( ) do
        if Value5:IsA( "UIGradient" ) then
            if Value5.Name == "Fond" then
                Value5.Enabled = true
            elseif Value5.Name == "Fond_Unranked" then
                Value5.Enabled = false
            end
        end
    end

    local Titre = Key3:FindFirstChild( "Titre" )

    if Titre then
        for Key5, Value6 in Titre:GetChildren( ) do
            if Value6:IsA( "UIGradient" ) then
                if Value6.Name == "Couleur" then
                    Value6.Enabled = true
                elseif Value6.Name == "Couleur_Unranked" then
                    Value6.Enabled = false
                end
            end
        end
    end

    local Accent = Key3:FindFirstChild( "Accent" )
    local Sous = Key3:FindFirstChild( "Sous" )
    local BackgroundColor3 = Value4.accent

    if Accent and typeof( BackgroundColor3 ) == "Color3" and Accent.BackgroundColor3 ~= BackgroundColor3 then
        Accent.BackgroundColor3 = BackgroundColor3
    end

    local TextColor32 = Value4.sous

    if Sous and typeof( TextColor32 ) == "Color3" and Sous.TextColor3 ~= TextColor32 then
        Sous.TextColor3 = TextColor32
    end

    local Text = Flag and Value4.sousUnranked or Value4.sousText

    if Sous and Text and Sous.Text ~= Text then
        Sous.Text = Text
    end
end

local FoundChild

if Upvalue2 then
    FoundChild = Upvalue5:FindFirstChild( "Carte_" .. Upvalue2, true )
else
    FoundChild = Upvalue2
end

local TextColor3

if FoundChild then
    local Entry = Upvalue4[ FoundChild ]

    if Entry then
        TextColor3 = Upvalue4[ FoundChild ].sous
    else
        TextColor3 = Entry
    end
else
    TextColor3 = FoundChild
end
if typeof( TextColor3 ) == "Color3" and Upvalue6.Sous.TextColor3 ~= TextColor3 then
    Upvalue6.Sous.TextColor3 = TextColor3
end

Upvalue7( )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

if Open == Upvalue1 then
    return
end

Upvalue1 = Open

if Open then
    Upvalue2 = Open
    Upvalue3( Open )

    if not Upvalue4.Visible and Upvalue5 then
        Upvalue5( )
    end

    Upvalue6( )
    Upvalue7 = Upvalue7 + 1

    if Upvalue8 then
        Upvalue8( )
    else
        local Text
        Upvalue9.Texte.Text = Upvalue10
        Text = if true or not true then Upvalue11 else ""

        if Upvalue12.Text ~= Text then
            Upvalue12.Text = Text
        end

        local TextColor3 = not true and Upvalue13 or Upvalue14

        if Upvalue12.TextColor3 ~= TextColor3 then
            Upvalue12.TextColor3 = TextColor3
        end
    end
    if Upvalue15 then
        task.spawn( Upvalue15 )
    end
    if not Upvalue4.Visible then
        Upvalue4.Visible = true

        if Upvalue16 then
            Upvalue16:Cancel( )
        end

        Upvalue4.UIScale.Scale = 0.92
        Upvalue16 = Upvalue17:Create( Upvalue4.UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
        Upvalue16:Play( )
    end

    Upvalue18.ActiveMenu = "Ranked"
    Upvalue18.CursorFree = true
else
    if Upvalue16 then
        Upvalue16:Cancel( )
        Upvalue16 = nil
    end

    Upvalue4.UIScale.Scale = 1
    Upvalue4.Visible = false
    Upvalue7 = Upvalue7 + 1

    if Upvalue8 then
        Upvalue8( )
    else
        local Text2
        Upvalue9.Texte.Text = Upvalue10
        Text2 = if true or not true then Upvalue11 else ""

        if Upvalue12.Text ~= Text2 then
            Upvalue12.Text = Text2
        end

        local TextColor32 = not true and Upvalue13 or Upvalue14

        if Upvalue12.TextColor3 ~= TextColor32 then
            Upvalue12.TextColor3 = TextColor32
        end
    end
    if Upvalue18.ActiveMenu == "Ranked" then
        Upvalue18.ActiveMenu = nil
        Upvalue18.CursorFree = false
    end
end

Upvalue19( )
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.ranked = true
Upvalue2( )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.ranked = nil
Upvalue2( )
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 ~= Upvalue2 then
    Upvalue3( Upvalue2 )
end
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2
Upvalue3( Upvalue4 )
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    Upvalue1 = nil
end

Upvalue3( Upvalue4 )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == nil then
    return
end

Upvalue1 = nil

if Upvalue2 then
    Upvalue2:Cancel( )
    Upvalue2 = nil
end

Upvalue3.UIScale.Scale = 1
Upvalue3.Visible = false
Upvalue4 = Upvalue4 + 1

if Upvalue5 then
    Upvalue5( )
else
    local Text
    Upvalue6.Texte.Text = Upvalue7
    Text = if true or not true then Upvalue8 else ""

    if Upvalue9.Text ~= Text then
        Upvalue9.Text = Text
    end

    local TextColor3 = not true and Upvalue10 or Upvalue11

    if Upvalue9.TextColor3 ~= TextColor3 then
        Upvalue9.TextColor3 = TextColor3
    end
end
if Upvalue12.ActiveMenu == "Ranked" then
    Upvalue12.ActiveMenu = nil
    Upvalue12.CursorFree = false
end

Upvalue13( )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Create( Upvalue2.UIScale, TweenInfo.new( 0.1 ), { Scale = 1.03 } ):Play( )
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Create( Upvalue2.UIScale, TweenInfo.new( 0.1 ), { Scale = 1 } ):Play( )
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Upvalue1.queue then
    if ( Upvalue1 and Upvalue1.queue ).kind == "unranked" then
        return "unranked"
    end
    return "ranked"
else
    if not Upvalue1 or Upvalue1.eligible == nil then
        return Upvalue2
    end
    if Upvalue1.eligible then
        return "ranked"
    end
    return "unranked"
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local Text = KindName ~= "unranked" and "ranked" or "unranked"

if Argument2 then
    Upvalue1 = true
end

Upvalue2 = Text
Upvalue3( )

if Upvalue4 then
    Upvalue4( )
end
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue2 ~= nil and true or false
Upvalue1 = Flag
local Text

if Upvalue2 and Upvalue2.queue then
    if ( Upvalue2 and Upvalue2.queue ).kind == "unranked" then
        Text = "unranked"
    else
        Text = "ranked"
    end
elseif not Upvalue2 or Upvalue2.eligible == nil then
    Text = Upvalue3
elseif Upvalue2.eligible then
    Text = "ranked"
else
    Text = "unranked"
end

Upvalue3 = Text
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Text = Upvalue2 ~= "unranked" and "ranked" or "unranked"
    Upvalue3 = true
    Upvalue4 = Text
    Upvalue5( )

    if Upvalue6 then
        Upvalue6( )
    end
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

if type( Name ) == "string" and Name ~= "" then
    Upvalue1.Error( Name )
end
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

return ( tostring( ( math.floor( ( tonumber( Text ) or 0 ) + 0.5 ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( ):gsub( "^,", "" ) )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

local Max = math.max( 0, ( math.floor( Argument1 ) ) )
return ( "%d:%02d" ):format( Max // 60, Max % 60 )
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = tonumber( Argument1.rev )

if Number == nil then
    return true
end
if Number <= Upvalue1 then
    return false
end
Upvalue1 = Number
return true
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "status" )

if Success and type( Result ) == "table" then
    local Flag
    local Number = tonumber( Result.rev )

    if Number == nil then
        Flag = true
    elseif Number <= Upvalue2 then
        Flag = false
    else
        Upvalue2 = Number
        Flag = true
    end
    if Flag then
        Upvalue3 = Result
        Upvalue4 = os.clock( )

        if Upvalue5 and not Upvalue6 then
            Upvalue6 = true
            local Text

            if Upvalue3 and Upvalue3.queue then
                if ( Upvalue3 and Upvalue3.queue ).kind == "unranked" then
                    Text = "unranked"
                else
                    Text = "ranked"
                end
            elseif not Upvalue3 or Upvalue3.eligible == nil then
                Text = Upvalue7
            elseif Upvalue3.eligible then
                Text = "ranked"
            else
                Text = "unranked"
            end

            Upvalue7 = Text
            Upvalue8( )
        end

        Upvalue9( )
        Upvalue10( )
    end
end
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

return ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Argument1 )
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1( )
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Groupe = Upvalue1:FindFirstChild( "Groupe" )

if not Groupe then
    return
end

local Size2

if Upvalue3.Modes[ Upvalue4 ] then
    local Size = Upvalue3.Modes[ Upvalue4 ].size

    if Size then
        Size2 = Size
    else
        Size2 = 1
    end
else
    Size2 = 1
end
if Upvalue4 == "1v1" and Upvalue5 == "unranked" then
    Size2 = 2
end

local Members = Upvalue2 and Upvalue2.party and ( Upvalue2 and Upvalue2.party ).members or { { id = Upvalue6.UserId, name = Upvalue6.DisplayName, barge = true } }
local Leader = Upvalue2 and Upvalue2.party and ( Upvalue2 and Upvalue2.party ).leader or Upvalue6.UserId
local Flag

if Leader == Upvalue6.UserId then
    if #Members < Upvalue3.PartyMax then
        Flag = not ( Upvalue2 and Upvalue2.queue )
    else
        Flag = false
    end
else
    Flag = false
end

local Visible
local Max = math.max( Size2, #Members )
local Quitter = Groupe.Quitter
Visible = ( Upvalue2 and Upvalue2.party ) ~= nil and true or false
local Value1
Quitter.Visible = Visible
local Table = { tostring( Upvalue4 ), Max, tostring( Flag ), Leader }
Value1 = nil

for Key, Value in Members, nil, nil do
    local Text4
    local Text3 = tostring( Value.id )
    Text4 = not Value.barge and "" or "b"
    local Text5 = not Value.remote and "" or "r"
    table.insert( Table, Text3 .. Text4 .. Text5 .. tostring( Value.name ) )
end

local Concat = table.concat( Table, "|" )

if Concat == Upvalue7 then
    return
end

local Value2
Upvalue7 = Concat
Value2 = nil

for Key2, Value3 in Upvalue8, nil, nil do
    Value3:Destroy( )
end

local SlotLarge2
table.clear( Upvalue8 )

if Max <= 2 then
    local SlotLarge = Upvalue9.SlotLarge

    if SlotLarge then
        SlotLarge2 = SlotLarge
    else
        SlotLarge2 = Upvalue9.Slot
    end
else
    SlotLarge2 = Upvalue9.Slot
end

local I = 1

for I = 1, Max do
    local Name
    local Entry = Members[ I ]
    local Clone = SlotLarge2:Clone( )

    if Entry then
        local Text = "Membre_" .. tostring( Entry.id )

        if Text then
            Name = Text
        else
            Name = "Libre_" .. I
        end
    else
        Name = "Libre_" .. I
    end

    local Visible2
    Clone.Name = Name
    Clone.LayoutOrder = I
    Clone.Visible = true
    local Avatar = Clone.Avatar

    if Entry == nil then
        if SlotLarge2 == Upvalue9.Slot then
            Visible2 = true
        else
            Visible2 = false
        end
    else
        Visible2 = true
    end

    local Image
    Avatar.Visible = Visible2
    local Avatar2 = Clone.Avatar

    if Entry then
        local Format = ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Entry.id )

        if Format then
            Image = Format
        else
            Image = ""
        end
    else
        Image = ""
    end

    local Visible3
    Avatar2.Image = Image
    local Nom = Clone.Nom
    Visible3 = Entry ~= nil and true or false
    local Visible4
    Nom.Visible = Visible3
    local Plus = Clone.Plus
    Visible4 = Entry == nil and true or false
    local Visible5
    Plus.Visible = Visible4

    if Entry == nil then
        Visible5 = false
    elseif Entry.id == Leader then
        if #Members > 1 then
            Visible5 = true
        else
            Visible5 = false
        end
    else
        Visible5 = false
    end

    local Chef = Clone:FindFirstChild( "Chef" )
    local Role = Clone:FindFirstChild( "Role" )

    if Chef then
        Chef.Visible = Visible5
    end
    if Role then
        local Flag2 = if Entry == nil then false else not Entry.barge
        local Flag3

        if Entry == nil then
            Flag3 = false
        elseif Entry.remote == true then
            Flag3 = not Visible5
        else
            Flag3 = false
        end

        local Visible6

        if Visible5 then
            Visible6 = Visible5
        elseif Flag2 then
            Visible6 = Flag2
        else
            Visible6 = Flag3
        end

        local Text2
        Role.Visible = Visible6

        if Flag2 then
            Text2 = "NOT ON THE BOAT"
        elseif Visible5 then
            Text2 = "LEADER"
        else
            Text2 = "OTHER SERVER"
        end

        local TextColor3
        Role.Text = Text2
        TextColor3 = Flag2 and Upvalue10 or Upvalue11
        local Position
        Role.TextColor3 = TextColor3
        local Nom2 = Clone.Nom
        Position = Role.Visible and Upvalue12 or Upvalue13
        Nom2.Position = Position
    end
    if Entry then
        local ImageTransparency
        local Nom3 = Clone.Nom
        Nom3.Text = tostring( Entry.name )
        local Avatar3 = Clone.Avatar
        ImageTransparency = not Entry.barge and 0.5 or 0
        local TextTransparency
        Avatar3.ImageTransparency = ImageTransparency
        local Nom4 = Clone.Nom
        TextTransparency = not Entry.barge and 0.45 or 0
        Nom4.TextTransparency = TextTransparency
    else
        local TextTransparency2
        local Plus2 = Clone.Plus
        TextTransparency2 = not Flag and 0.65 or 0
        Plus2.TextTransparency = TextTransparency2

        if Flag then
            Clone.Activated:Connect( function()
                if Upvalue14 then
                    Upvalue14( )
                end
            end )
        end
    end

    Clone.Parent = Groupe.Membres
    table.insert( Upvalue8, Clone )
end
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return "Loading..."
end

local Queue = Upvalue1.queue

if Queue then
    local Text
    local Elapsed = ( Queue.elapsed or 0 ) + ( os.clock( ) - Upvalue2 )
    Text = Queue.kind ~= "unranked" and "RANKED " or "CASUAL "
    local Entry2
    local Entry = Upvalue3[ Queue.mode ]
    Entry2 = if Entry then Entry else Queue.mode
    local Text4
    local Text2 = Text .. Entry2

    if Queue.mode ~= Upvalue4 or ( Queue.kind or "ranked" ) ~= Upvalue5 then
        local Text3 = "Searching for a " .. Text2 .. " match"

        if Text3 then
            Text4 = Text3
        else
            Text4 = "Searching for opponents"
        end
    else
        Text4 = "Searching for opponents"
    end

    local Max = math.max( 0, ( math.floor( Elapsed ) ) )
    return Text4 .. "  ·  " .. ( "%d:%02d" ):format( Max // 60, Max % 60 )
end
if Upvalue5 ~= "unranked" then
    if not Upvalue1.eligible then
        return ""
    end

    local Number = ( tonumber( Upvalue1.lock ) or 0 ) - ( os.clock( ) - Upvalue2 )

    if Number > 0 then
        local Max2 = math.max( 0, ( math.floor( Number ) ) )
        return "You left a match: Ranked is locked for " .. ( "%d:%02d" ):format( Max2 // 60, Max2 % 60 )
    end
end

local Entry3 = Upvalue6.Modes[ Upvalue4 ]

if Entry3 and Entry3.clan and Upvalue5 == "unranked" then
    return "5V5 casual: solo or with friends, teams are filled"
end
if Entry3 and Entry3.clan and not Upvalue1.clan then
    return "5V5 is clan vs clan: join a clan first"
end
if Entry3 and Entry3.clan then
    return "Make a party of 5 members of your clan, then search"
end
if Upvalue1.weapon then
    return ""
end
if Upvalue5 == "unranked" then
    return "You need a weapon to play"
end
return "You need a weapon to play Ranked"
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = false

for Key, Value in Self:GetChildren( ) do
    if Value:IsA( "UIGradient" ) then
        local Enabled = Value.Name == Id and true or false
        local Flag2
        Value.Enabled = Enabled

        if Flag then
            Flag2 = Flag
        elseif Value.Name == Id then
            Flag2 = true
        else
            Flag2 = false
        end

        Flag = Flag2
    end
end
if not Flag and Self:FindFirstChild( "Unranked" ) then
    Self:FindFirstChild( "Unranked" ).Enabled = true
end
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local Text2

if Amount >= 1000 then
    local Text = math.floor( Amount / 1000 + 0.5 ) .. "K"

    if Text then
        Text2 = Text
    else
        Text2 = tostring( Amount )
    end
else
    Text2 = tostring( Amount )
end

return Text2
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

local FoundChild = Upvalue1:FindFirstChild( "Carte_" .. CardName, true )

if not FoundChild then
    return
end
if Upvalue2 == "unranked" then
    local Floor = math.floor( tonumber( Upvalue3:GetAttribute( "Level" ) ) or 1 )
    local Floor2 = math.floor( tonumber( Upvalue3:GetAttribute( "XP" ) ) or 0 )
    local Number = tonumber( Upvalue3:GetAttribute( "XPNext" ) )
    local Text = "u|" .. Floor .. "|" .. Floor2 .. "|" .. tostring( Number )

    if Upvalue4[ CardName ] == Text then
        return
    end

    local Text3
    Upvalue4[ CardName ] = Text
    FoundChild.Badge.Visible = false
    Upvalue5( FoundChild.Palier, "Casual" )
    local Palier = FoundChild.Palier
    Palier.Text = "LEVEL " .. Floor
    local Elo = FoundChild.Elo

    if Number then
        local Value1 = Upvalue6( Floor2 )
        local Text2 = Value1 .. " / " .. Upvalue6( Number ) .. " XP"

        if Text2 then
            Text3 = Text2
        else
            Text3 = "MAX LEVEL"
        end
    else
        Text3 = "MAX LEVEL"
    end

    local Clamp2
    Elo.Text = Text3
    local Rempli = FoundChild.Piste.Rempli
    Upvalue5( Rempli, "Casual" )

    if not Number or not ( Number > 0 ) then
        Clamp2 = 1
    else
        local Clamp = math.clamp( Floor2 / Number, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 1
        end
    end

    local Visible = Clamp2 > 0.002 and true or false
    local XP2
    Rempli.Visible = Visible
    Rempli.Size = UDim2.fromScale( Clamp2, 1 )
    local XP = Upvalue7.XP
    XP2 = if XP then Upvalue7.XP.unranked else XP
    local Text8

    local function K( Amount )
        local Text2

        if Amount >= 1000 then
            local Text = math.floor( Amount / 1000 + 0.5 ) .. "K"

            if Text then
                Text2 = Text
            else
                Text2 = tostring( Amount )
            end
        else
            Text2 = tostring( Amount )
        end

        return Text2
    end

    local Statut = FoundChild.Statut

    if XP2 then
        local Text5
        local Win = XP2.win

        if Win >= 1000 then
            local Text4 = math.floor( Win / 1000 + 0.5 ) .. "K"

            if Text4 then
                Text5 = Text4
            else
                Text5 = tostring( Win )
            end
        else
            Text5 = tostring( Win )
        end

        local Text7
        local Loss = XP2.loss

        if Loss >= 1000 then
            local Text6 = math.floor( Loss / 1000 + 0.5 ) .. "K"

            if Text6 then
                Text7 = Text6
            else
                Text7 = tostring( Loss )
            end
        else
            Text7 = tostring( Loss )
        end

        local Format = ( "WIN +%s XP · LOSS +%s XP" ):format( Text5, Text7 )

        if Format then
            Text8 = Format
        else
            Text8 = ""
        end
    else
        Text8 = ""
    end

    Statut.Text = Text8
    return
end
local Table
FoundChild.Badge.Visible = true
Table = type( Captured ) == "table" and Captured or { }
local Flag
local Number2 = tonumber( Table.placed ) or 0
local Number3 = tonumber( Table.elo ) or 0
Flag = Number2 < Upvalue8 and true or false
local Text9 = tostring( Flag )
local Text10 = "r|" .. Text9 .. "|" .. Number2 .. "|" .. Number3 .. "|" .. tostring( Table.label )

if Upvalue4[ CardName ] == Text10 then
    return
end

local Number4, Text11, Text12, Id, Division, Text13
Upvalue4[ CardName ] = Text10

if Flag then
    Number4 = Number2 / Upvalue8
    Text11 = ( "PLACEMENTS %d / %d" ):format( Number2, Upvalue8 )
    Text12 = ( "RANK AFTER %d MATCHES" ):format( Upvalue8 )
    Id = "Unranked"
    Division = nil
    Text13 = "UNRANKED"
else
    local Value2
    local Of = Upvalue9.Of( Number3 )
    Id = Of.rank.id
    Division = Of.division
    Text13 = Of.label:upper( )
    local Top = Upvalue7.Top
    Value2 = nil

    for Key, Value in Top, nil, nil do
        if Table.label == Value.name then
            Id = Value.id
            Text13 = Value.name:upper( )
            Division = nil
        end
    end

    local Clamp4

    if Of.ceil then
        local Clamp3 = math.clamp( ( Number3 - Of.floor ) / ( Of.ceil - Of.floor ), 0, 1 )

        if Clamp3 then
            Clamp4 = Clamp3
        else
            Clamp4 = 1
        end
    else
        Clamp4 = 1
    end

    local Format3

    if Of.ceil then
        local Format2 = ( "%s TO %s" ):format( Upvalue6( Of.ceil - Number3 ), Upvalue9.NextOf( Of ).label:upper( ) )

        if Format2 then
            Format3 = Format2
        else
            Format3 = "CLIMB THE LEADERBOARD"
        end
    else
        Format3 = "CLIMB THE LEADERBOARD"
    end

    Number4 = Clamp4
    Text11 = Upvalue6( Number3 ) .. " ELO"
    Text12 = Format3
end

local Visible2
local Badge = FoundChild.Badge
local Image = Upvalue10.Image( Id, Division )
local Image2 = Badge.Image
Image2.Image = Image or ""
local Image3 = Badge.Image
Visible2 = Image ~= nil and true or false
local Visible3
Image3.Visible = Visible2
local Repere = Badge.Repere
Visible3 = Image == nil and true or false
local Text14
Repere.Visible = Visible3
Upvalue5( Badge.Repere.Forme, Id )
local Division2 = Badge.Repere.Division

if Id == "Unranked" then
    Text14 = "?"
elseif Id == "Top100" then
    Text14 = "100"
elseif Id == "Top1" then
    Text14 = "1"
elseif Division then
    local Entry = Upvalue11[ Division ]

    if Entry then
        Text14 = Entry
    else
        Text14 = ""
    end
else
    Text14 = ""
end

local Visible4
Division2.Text = Text14
Upvalue5( FoundChild.Palier, Id )
local Rempli2 = FoundChild.Piste.Rempli
Upvalue5( Rempli2, Id )
Visible4 = Number4 > 0.002 and true or false
Rempli2.Visible = Visible4
Rempli2.Size = UDim2.fromScale( Number4, 1 )
FoundChild.Palier.Text = Text13
FoundChild.Elo.Text = Text11
FoundChild.Statut.Text = Text12
return
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Captured

    if Upvalue3 then
        local Modes = Upvalue3.modes

        if Modes then
            Captured = Upvalue3.modes[ Value ]
        else
            Captured = Modes
        end
    else
        Captured = Upvalue3
    end

    Upvalue2( Value, Captured )
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return "SEASON", ""
end

local Number4
local Match, Match2 = tostring( Upvalue1.season or "" ):match( "^(%d+)%-(%d+)$" )
local Match3, Match22 = tostring( Upvalue2.FirstSeason or "" ):match( "^(%d+)%-(%d+)$" )

if not Match or not Match3 then
    Number4 = nil
else
    local Number = tonumber( Match ) * 12 + tonumber( Match2 ) - ( tonumber( Match3 ) * 12 + tonumber( Match22 ) ) + 1

    if Number then
        Number4 = Number
    else
        Number4 = nil
    end
end

local Format2
local Number2 = ( tonumber( Upvalue1.seasonEnds ) or 0 ) - os.time( )

if Number2 >= 86400 then
    local Text
    local Number3 = Number2 // 86400
    Text = Number2 // 86400 ~= 1 and "s" or ""
    local Format = ( "%d day%s" ):format( Number3, Text )

    if Format then
        Format2 = Format
    else
        Format2 = ( "%d h" ):format( ( math.max( 0, Number2 // 3600 ) ) )
    end
else
    Format2 = ( "%d h" ):format( ( math.max( 0, Number2 // 3600 ) ) )
end

local Text2 = Number4 and "SEASON " .. Number4 or "SEASON"
return Text2, ( "Season ends in %s · rewards for your final rank" ):format( Format2 )
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

-- empty function
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured

if Upvalue1 then
    local Queue = Upvalue1.queue

    if Queue then
        Captured = Upvalue1.queue.mode
    else
        Captured = Queue
    end
else
    Captured = Upvalue1
end

local Captured2

if not Captured or not Upvalue3.Modes[ Captured ] or not Captured then
    if Upvalue4 then
        Captured2 = Upvalue4
    else
        Captured2 = Upvalue5[ 1 ]
    end
else
    Captured2 = Captured
end

Upvalue2( Captured2 )
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if Upvalue1 == nil then
        return
    end

    Upvalue1 = nil

    if Upvalue2 then
        Upvalue2:Cancel( )
        Upvalue2 = nil
    end

    Upvalue3.UIScale.Scale = 1
    Upvalue3.Visible = false
    Upvalue4 = Upvalue4 + 1

    if Upvalue5 then
        Upvalue5( )
    else
        local Text
        Upvalue6.Texte.Text = Upvalue7
        Text = if true or not true then Upvalue8 else ""

        if Upvalue9.Text ~= Text then
            Upvalue9.Text = Text
        end

        local TextColor3 = not true and Upvalue10 or Upvalue11

        if Upvalue9.TextColor3 ~= TextColor3 then
            Upvalue9.TextColor3 = TextColor3
        end
    end
    if Upvalue12.ActiveMenu == "Ranked" then
        Upvalue12.ActiveMenu = nil
        Upvalue12.CursorFree = false
    end

    Upvalue13( )
    return
end
local Captured

if Upvalue14 then
    local Queue = Upvalue14.queue

    if Queue then
        Captured = Upvalue14.queue.mode
    else
        Captured = Queue
    end
else
    Captured = Upvalue14
end

local Captured2

if not Captured or not Upvalue16.Modes[ Captured ] or not Captured then
    if Upvalue17 then
        Captured2 = Upvalue17
    else
        Captured2 = Upvalue18[ 1 ]
    end
else
    Captured2 = Captured
end

Upvalue15( Captured2 )
return
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if type( Key ) ~= "string" or not Upvalue1.Modes[ Key ] then
    if not Upvalue7 then
        local Captured

        if Upvalue8 then
            local Queue = Upvalue8.queue

            if Queue then
                Captured = Upvalue8.queue.mode
            else
                Captured = Queue
            end
        else
            Captured = Upvalue8
        end

        local Captured2

        if not Captured or not Upvalue1.Modes[ Captured ] or not Captured then
            if Upvalue9 then
                Captured2 = Upvalue9
            else
                Captured2 = Upvalue10[ 1 ]
            end
        else
            Captured2 = Captured
        end

        Upvalue2( Captured2 )
    end

    return
end
Upvalue2( Key )

if Name == "ranked" or Name == "unranked" then
    local Text = Name ~= "unranked" and "ranked" or "unranked"
    Upvalue3 = true
    Upvalue4 = Text
    Upvalue5( )

    if Upvalue6 then
        Upvalue6( )
    end
end

return
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2 then
    return
end

local Progress2

if type( Upvalue2.progress ) == "table" then
    local Progress = Upvalue2.progress

    if Progress then
        Progress2 = Progress
    else
        Progress2 = { }
    end
else
    Progress2 = { }
end

local Floor = math.floor( tonumber( Progress2.wins ) or 0 )
local UnrankedWins = Upvalue3.Access.unrankedWins
local Sous = Upvalue1:FindFirstChild( "Sous" )
local Text = ( "Win %d Casual matches to play Ranked" ):format( UnrankedWins )

if Sous and Sous.Text ~= Text then
    Sous.Text = Text
end

local Victoires = Upvalue1:FindFirstChild( "Victoires" )

if not Victoires then
    return
end

local Rempli
local Valeur = Victoires.Valeur
Valeur.Text = ( "%s / %s" ):format( Upvalue4( ( math.min( Floor, UnrankedWins ) ) ), ( Upvalue4( UnrankedWins ) ) )
local Piste = Victoires:FindFirstChild( "Piste" )

if Piste then
    Rempli = Victoires.Piste:FindFirstChild( "Rempli" )
else
    Rempli = Piste
end
if Rempli then
    local Visible
    local Clamp = math.clamp( Floor / UnrankedWins, 0, 1 )
    Visible = Clamp > 0.002 and true or false
    Rempli.Visible = Visible
    Rempli.Size = UDim2.fromScale( Clamp, 1 )
end

local Text3
local UnrankedWins2 = UnrankedWins - Floor
local Reste = Victoires.Reste

if UnrankedWins2 <= 0 then
    Text3 = "DONE"
else
    local Text2
    local Value1 = Upvalue4( UnrankedWins2 )
    Text2 = UnrankedWins2 ~= 1 and " WINS TO GO" or " WIN TO GO"
    Text3 = Value1 .. Text2
end

Reste.Text = Text3
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Text = Upvalue2 ~= "unranked" and "RANKED" or "CASUAL"

if Upvalue3.Titre.Text ~= Text then
    Upvalue3.Titre.Text = Text
end
if Upvalue2 == "unranked" then
    local Text2 = Upvalue4( )

    if Upvalue3.Sous.Text ~= Text2 then
        Upvalue3.Sous.Text = Text2
    end

    Upvalue5 = "Casual matches · no ELO, no rank · earn XP"
elseif Upvalue6 then
    local Text3, Value1 = Upvalue4( )

    if Upvalue3.Sous.Text ~= Text3 then
        Upvalue3.Sous.Text = Text3
    end

    Upvalue5 = Value1
end

local Text5
local Text4 = Upvalue7( ) or ""
Text5 = if Text4 == "" or not Text4 then Upvalue5 else Text4

if Upvalue8.Text ~= Text5 then
    Upvalue8.Text = Text5
end

local TextColor3 = Text4 ~= "" and Upvalue9 or Upvalue10

if Upvalue8.TextColor3 ~= TextColor3 then
    Upvalue8.TextColor3 = TextColor3
end
if not Upvalue6 then
    return
end

local Visible

if Upvalue2 == "unranked" then
    Visible = false
elseif Upvalue6.eligible == false then
    Visible = true
else
    Visible = false
end
if Upvalue11.Visible == Visible then
    Upvalue11.Visible = not Visible
end
if Upvalue12 and Upvalue12.Visible ~= Visible then
    Upvalue12.Visible = Visible
end
if Visible then
    Upvalue13( )
end

local Entry2

if Upvalue6.modes then
    local Entry = Upvalue6.modes[ Upvalue1 ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = { }
    end
else
    Entry2 = { }
end

local Flag = ( tonumber( Entry2.placed ) or 0 ) < Upvalue14 and true or false
Upvalue15( Entry2, Flag )
local Stats = Upvalue3:FindFirstChild( "Stats" )

if Stats then
    local Text7
    local Number = tonumber( Entry2.wins ) or 0
    local Number2 = tonumber( Entry2.losses ) or 0
    local Valeur = Stats.Victoires.Valeur
    Valeur.Text = Upvalue16( Number )
    local Valeur2 = Stats.Defaites.Valeur
    Valeur2.Text = Upvalue16( Number2 )
    local Valeur3 = Stats.Ratio.Valeur

    if Number + Number2 > 0 then
        local Text6 = math.floor( Number / ( Number + Number2 ) * 100 + 0.5 ) .. "%"

        if Text6 then
            Text7 = Text6
        else
            Text7 = "-"
        end
    else
        Text7 = "-"
    end

    Valeur3.Text = Text7
end

Upvalue17( )

if Upvalue18 then
    Upvalue19.Texte.Text = "MATCH FOUND!"
elseif Upvalue6.queue then
    local Texte = Upvalue19.Texte
    local Max = math.max( 0, ( math.floor( ( Upvalue6.queue.elapsed or 0 ) + ( os.clock( ) - Upvalue20 ) ) ) )
    Texte.Text = "CANCEL  " .. ( "%d:%02d" ):format( Max // 60, Max % 60 )
elseif Upvalue2 == "unranked" then
    if Upvalue2 ~= "unranked" or Upvalue1 ~= "1v1" or type( Upvalue6.party ) ~= "table" or type( Upvalue6.party.members ) ~= "table" or #Upvalue6.party.members ~= 2 then
        Upvalue19.Texte.Text = "FIND MATCH"
    else
        Upvalue19.Texte.Text = "DUEL"
    end
elseif Upvalue6.eligible == false or ( tonumber( Upvalue6.lock ) or 0 ) - ( os.clock( ) - Upvalue20 ) > 0 then
    Upvalue19.Texte.Text = "LOCKED"
elseif Upvalue2 ~= "unranked" or Upvalue1 ~= "1v1" or type( Upvalue6.party ) ~= "table" or type( Upvalue6.party.members ) ~= "table" or #Upvalue6.party.members ~= 2 then
    Upvalue19.Texte.Text = "FIND MATCH"
else
    Upvalue19.Texte.Text = "DUEL"
end

local Flag2 = Upvalue19.Texte.Text == "LOCKED" and true or false
local BackgroundTransparency = not Flag2 and 0 or 0.45

if Upvalue19.BackgroundTransparency ~= BackgroundTransparency then
    local TextTransparency
    Upvalue19.BackgroundTransparency = BackgroundTransparency
    local Texte2 = Upvalue19.Texte
    TextTransparency = not Flag2 and 0 or 0.3
    Texte2.TextTransparency = TextTransparency
end
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

local Text = ( not Upvalue1 or not Upvalue1.queue ) and "queue" or "cancel"
local Success, Result = pcall( Upvalue2.InvokeServer, Upvalue2, Text, Upvalue3, Upvalue4 )

if Success and type( Result ) == "table" and not Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
    Upvalue5.Error( Result.msg )
end

Upvalue6( )
Upvalue7 = false
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue2 or Upvalue3 then
    return
end
Upvalue2 = true
task.spawn( function()
    local Text = ( not Upvalue4 or not Upvalue4.queue ) and "queue" or "cancel"
    local Success, Result = pcall( Upvalue5.InvokeServer, Upvalue5, Text, Upvalue1, Upvalue6 )

    if Success and type( Result ) == "table" and not Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
        Upvalue7.Error( Result.msg )
    end

    Upvalue8( )
    Upvalue2 = false
end )
return
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if Self.Visible then
    return
end

local UIScale2
Self.Visible = true
local UIScale = Self:FindFirstChildOfClass( "UIScale" )

if UIScale then
    UIScale2 = UIScale
else
    local Fenetre = Self:FindFirstChild( "Fenetre" )

    if Fenetre then
        UIScale2 = Self.Fenetre:FindFirstChildOfClass( "UIScale" )
    else
        UIScale2 = Fenetre
    end
end
if UIScale2 then
    UIScale2.Scale = 0.92
    Upvalue1:Create( UIScale2, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
end
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1:GetFriendsOnlineAsync( 200 )
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1:GetFriendsOnline( 200 )
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = tostring( Argument1.name ):lower( ) < tostring( Argument2.name ):lower( ) and true or false
return Flag
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

local InvokeServer = Upvalue1.InvokeServer
local Success, Result = pcall( InvokeServer, Upvalue1, "invite", Upvalue2.id )

if Success and type( Result ) == "table" and Result.ok then
    Upvalue3.Bouton.Texte.Text = "SENT"
    return
end

local Msg
Upvalue3:SetAttribute( "Envoye", nil )
Upvalue3.Bouton.Texte.Text = "INVITE"
Msg = Success and type( Result ) == "table" and Result.msg or "Could not invite"

if type( Msg ) == "string" and Msg ~= "" then
    Upvalue4.Error( Msg )
end
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.party or Upvalue2:GetAttribute( "Envoye" ) then
    return
end
Upvalue2:SetAttribute( "Envoye", true )
Upvalue2.Bouton.Texte.Text = "..."
task.spawn( function()
    local InvokeServer = Upvalue3.InvokeServer
    local Success, Result = pcall( InvokeServer, Upvalue3, "invite", Upvalue1.id )

    if Success and type( Result ) == "table" and Result.ok then
        Upvalue2.Bouton.Texte.Text = "SENT"
        return
    end

    local Msg
    Upvalue2:SetAttribute( "Envoye", nil )
    Upvalue2.Bouton.Texte.Text = "INVITE"
    Msg = Success and type( Result ) == "table" and Result.msg or "Could not invite"

    if type( Msg ) == "string" and Msg ~= "" then
        Upvalue4.Error( Msg )
    end
end )
return
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "players" )

if not Success or type( Result ) ~= "table" then
    return false
end

local Value1
local Table = { }
Value1 = nil

for Key, Value in Result, nil, nil do
    Table[ Value.id ] = true
end

local Success3
local Table2 = { }
local Success2, Result2 = pcall( function()
    return Upvalue2:GetFriendsOnlineAsync( 200 )
end )

if Success2 then
    Success3 = Success2
else
    Success3, Result2 = pcall( function()
        return Upvalue2:GetFriendsOnline( 200 )
    end )
end
if Success3 and type( Result2 ) == "table" then
    local Value2 = nil

    for Key2, Value3 in Result2, nil, nil do
        local Number = tonumber( Value3.VisitorId )

        if Number and not Table[ Number ] and tonumber( Value3.PlaceId ) == game.PlaceId and type( Value3.GameId ) == "string" and Value3.GameId ~= "" and Value3.GameId ~= game.JobId then
            local Name
            Table[ Number ] = true
            local Table3 = { id = Number, friend = true, remote = true }
            local DisplayName = Value3.DisplayName

            if DisplayName then
                Name = DisplayName
            else
                local UserName = Value3.UserName

                if UserName then
                    Name = UserName
                else
                    Name = tostring( Number )
                end
            end

            Table3.name = Name
            Table3.user = Value3.UserName
            table.insert( Table2, Table3 )
        end
    end
end

local Value4
table.sort( Table2, function( Argument1, Argument2 )
    local Flag = tostring( Argument1.name ):lower( ) < tostring( Argument2.name ):lower( ) and true or false
    return Flag
end )
local Table4 = { }
Value4 = nil

for Key3, Value5 in Result, nil, nil do
    if Value5.friend then
        table.insert( Table4, Value5 )
    end
end

local Value6 = nil

for Key4, Value7 in Table2, nil, nil do
    table.insert( Table4, Value7 )
end

local Value8 = nil

for Key5, Value9 in Result, nil, nil do
    if not Value9.friend then
        table.insert( Table4, Value9 )
    end
end

local Value10 = nil

for Key6, Value11 in Upvalue3, nil, nil do
    Value11:Destroy( )
end

table.clear( Upvalue3 )
local Parent = Upvalue4.Liste

if Parent:FindFirstChild( "Vide" ) then
    local Visible
    local Vide = Parent.Vide
    Visible = #Table4 == 0 and true or false
    Vide.Visible = Visible
end

local Value12 = nil

for Key7, Value13 in Table4, nil, nil do
    local Clone = Upvalue5.JoueurLigne:Clone( )
    Clone.Name = "Joueur_" .. tostring( Value13.id )
    Clone.LayoutOrder = Key7
    local Nom = Clone.Nom
    Nom.Text = tostring( Value13.name )

    if Clone:FindFirstChild( "Avatar" ) then
        local Avatar = Clone.Avatar
        Avatar.Image = ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Value13.id )
    end

    local Text
    local Tag = Clone.Tag

    if Value13.remote then
        Text = "FRIEND · OTHER SERVER"
    elseif Value13.friend then
        Text = "FRIEND"
    elseif Value13.barge then
        Text = "ON THE BOAT"
    else
        Text = "@" .. tostring( Value13.user )
    end

    local TextTransparency
    Tag.Text = Text
    local Tag2 = Clone.Tag
    TextTransparency = ( Value13.friend or Value13.barge ) and 0 or 0.4
    local Text2
    Tag2.TextTransparency = TextTransparency
    local Texte = Clone.Bouton.Texte
    Text2 = not Value13.party and "INVITE" or "IN PARTY"
    local TextTransparency2
    Texte.Text = Text2
    local Texte2 = Clone.Bouton.Texte
    TextTransparency2 = not Value13.party and 0 or 0.5
    Texte2.TextTransparency = TextTransparency2
    Clone.Bouton.Activated:Connect( function()
        if Value13.party or Clone:GetAttribute( "Envoye" ) then
            return
        end
        Clone:SetAttribute( "Envoye", true )
        Clone.Bouton.Texte.Text = "..."
        task.spawn( function()
            local InvokeServer = Upvalue1.InvokeServer
            local Success, Result = pcall( InvokeServer, Upvalue1, "invite", Value13.id )

            if Success and type( Result ) == "table" and Result.ok then
                Clone.Bouton.Texte.Text = "SENT"
                return
            end

            local Msg
            Clone:SetAttribute( "Envoye", nil )
            Clone.Bouton.Texte.Text = "INVITE"
            Msg = Success and type( Result ) == "table" and Result.msg or "Could not invite"

            if type( Msg ) == "string" and Msg ~= "" then
                Upvalue6.Error( Msg )
            end
        end )
        return
    end )
    Clone.Parent = Parent
    table.insert( Upvalue3, Clone )
end

return true
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1( ) then
    Upvalue2( Upvalue3 )
end
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    Upvalue1.Visible = false
    return
end
task.spawn( function()
    if Upvalue2( ) then
        Upvalue3( Upvalue1 )
    end
end )
return
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

pcall( Upvalue1.InvokeServer, Upvalue1, "leave" )
Upvalue2( )
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( function()
    pcall( Upvalue1.InvokeServer, Upvalue1, "leave" )
    Upvalue2( )
end )
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = false
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = false
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.ScrollBarThickness = math.max( 2, ( math.floor( Upvalue1.AbsoluteSize.X * 0.015 + 0.5 ) ) )
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

while Upvalue1 == Upvalue2 do
    if not Upvalue3.Visible then
        break
    end

    local Clock = 1 - ( os.clock( ) - Upvalue4 ) / Upvalue5

    if Clock <= 0 then
        Upvalue3.Visible = false
        return
    end

    local Barre = Upvalue3.Barre
    Barre.Size = UDim2.fromScale( Clock, Upvalue3.Barre.Size.Y.Scale )
    task.wait( 0.05 )
end
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

if type( Invite ) ~= "table" then
    return
end
if workspace:GetAttribute( "RankedMatch" ) then
    return
end

local Success, Result = pcall( require, game:GetService( "ReplicatedStorage" ):WaitForChild( "Controls" ) )

if Success and type( Result ) == "table" and type( Result.Settings ) == "table" and Result.Settings.PartyInvites == false then
    return
end

Upvalue1 = Upvalue1 + 1
local Titre = Upvalue2:FindFirstChild( "Titre" )

if Titre then
    if Titre:GetAttribute( "TitreGroupe" ) == nil then
        Titre:SetAttribute( "TitreGroupe", Titre.Text )
    end

    local Text

    if Invite.duel then
        Text = "DUEL REQUEST"
    else
        Text = Titre:GetAttribute( "TitreGroupe" )
    end

    Titre.Text = Text
end
if Invite.duel then
    local Texte = Upvalue2.Texte
    Texte.Text = tostring( Invite.name or "A player" ) .. " challenges you to a 1V1 Casual duel"
else
    local Text3
    local Texte2 = Upvalue2.Texte
    local Text2 = tostring( Invite.name or "A player" )
    Text3 = not Invite.remote and "" or " (from another server, you stay in yours)"
    Texte2.Text = Text2 .. " invited you to their Ranked party" .. Text3
end

Upvalue2:SetAttribute( "Id", Invite.id )

if Upvalue2:FindFirstChild( "Avatar" ) then
    local Image
    local Avatar = Upvalue2.Avatar

    if ( tonumber( Invite.from ) or 0 ) > 1 then
        local Format = ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( ( tonumber( Invite.from ) ) )

        if Format then
            Image = Format
        else
            Image = ""
        end
    else
        Image = ""
    end

    Avatar.Image = Image
end

local Number2
Upvalue2.Visible = false
Upvalue3( Upvalue2 )
local Number = tonumber( Invite.time )
Number2 = if Number then Number else Upvalue4.InviteTime
local Clock = os.clock( )
task.spawn( function()
    while Upvalue1 == Upvalue1 do
        if not Upvalue2.Visible then
            break
        end

        local ClockInner = 1 - ( os.clock( ) - Clock ) / Number2

        if ClockInner <= 0 then
            Upvalue2.Visible = false
            return
        end

        local Barre = Upvalue2.Barre
        Barre.Size = UDim2.fromScale( ClockInner, Upvalue2.Barre.Size.Y.Scale )
        task.wait( 0.05 )
    end
end )
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, Upvalue2, Upvalue3 )

if Upvalue2 == "accept" and Success and type( Result ) == "table" and not Result.ok and type( Result.msg ) == "string" and Result.msg ~= "" then
    Upvalue4.Error( Result.msg )
end
if Upvalue2 == "accept" and Success and type( Result ) == "table" and Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
    Upvalue4.Error( Result.msg )
end

Upvalue5( )
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

local Id = Upvalue1:GetAttribute( "Id" )
Upvalue2 = Upvalue2 + 1
Upvalue1.Visible = false

if Id then
    task.spawn( function()
        local Success, Result = pcall( Upvalue3.InvokeServer, Upvalue3, Argument1, Id )

        if Argument1 == "accept" and Success and type( Result ) == "table" and not Result.ok and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end
        if Argument1 == "accept" and Success and type( Result ) == "table" and Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end

        Upvalue5( )
    end )
    return
end
return
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

local Id = Upvalue1:GetAttribute( "Id" )
Upvalue2 = Upvalue2 + 1
Upvalue1.Visible = false

if Id then
    local Text = "accept"
    task.spawn( function()
        local Success, Result = pcall( Upvalue3.InvokeServer, Upvalue3, Text, Id )

        if Text == "accept" and Success and type( Result ) == "table" and not Result.ok and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end
        if Text == "accept" and Success and type( Result ) == "table" and Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end

        Upvalue5( )
    end )
    return
end
return
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

if workspace:GetAttribute( "RankedMatch" ) and Upvalue1.Visible then
    Upvalue2 = Upvalue2 + 1
    Upvalue1.Visible = false
end
]]

--[[
Function #64 has no emitted closure site
It is reproduced here so that nothing is lost

local Id = Upvalue1:GetAttribute( "Id" )
Upvalue2 = Upvalue2 + 1
Upvalue1.Visible = false

if Id then
    local Text = "decline"
    task.spawn( function()
        local Success, Result = pcall( Upvalue3.InvokeServer, Upvalue3, Text, Id )

        if Text == "accept" and Success and type( Result ) == "table" and not Result.ok and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end
        if Text == "accept" and Success and type( Result ) == "table" and Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end

        Upvalue5( )
    end )
    return
end
return
]]

--[[
Function #65 has no emitted closure site
It is reproduced here so that nothing is lost

require( Upvalue1:WaitForChild( "Sfx" ) ).Preload( { "MatchTrouve" } )
]]

--[[
Function #66 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
Upvalue2( )
]]

--[[
Function #67 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "state" then
    if type( Name2 ) == "table" then
        local Flag
        local Number = tonumber( Name2.rev )

        if Number == nil then
            Flag = true
        elseif Number <= Upvalue1 then
            Flag = false
        else
            Upvalue1 = Number
            Flag = true
        end
        if Flag then
            Upvalue2 = Name2
            Upvalue3 = os.clock( )

            if Upvalue4 and not Upvalue5 then
                Upvalue5 = true
                Upvalue7( )
            end

            Upvalue8( )
            Upvalue9( )
            return
        end
    end

    return
end
if Name == "notice" then
    if type( Name2 ) == "string" and Name2 ~= "" then
        Upvalue10.Error( Name2 )
        return
    end
else
    if Name == "invite" then
        Upvalue11( Name2 )
        return
    end
    if Name == "reward" and type( Name2 ) == "table" then
        local Announce = Upvalue10.Announce
        Announce( "SEASON REWARD", ( "You finished season %s %s: your rank outfit is in the wardrobe (Skins)" ):format( tostring( Name2.season ), ( tostring( Name2.name ) ) ), 8 )
        return
    end
    if Name == "found" then
        Upvalue12 = true

        if Upvalue2 then
            Upvalue2.queue = nil
        end

        local Text
        local Announce2 = Upvalue10.Announce
        Text = ( type( Name2 ) ~= "table" or Name2.kind ~= "unranked" ) and "Joining the ranked server..." or "Joining the match server..."
        Announce2( "MATCH FOUND", Text, 4 )
        require( Upvalue13:WaitForChild( "Sfx" ) ).Play( "MatchTrouve" )
        Upvalue8( )
        task.delay( 12, function()
            Upvalue12 = false
            Upvalue8( )
        end )
    end
end

return
]]

--[[
Function #68 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Visible

if ( Upvalue2 and Upvalue2.queue ) == nil then
    if Upvalue3 == true then
        Visible = true
    else
        Visible = false
    end
else
    Visible = true
end
if Upvalue1.Visible ~= Visible then
    local UIScale
    Upvalue1.Visible = Visible

    if Visible then
        UIScale = Upvalue1:FindFirstChildOfClass( "UIScale" )
    else
        UIScale = Visible
    end
    if UIScale then
        UIScale.Scale = 0.92
        Upvalue4:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
    end
end
if not Visible then
    return
end

local Visible2

if ( Upvalue2 and Upvalue2.party ) == nil then
    Visible2 = true
elseif ( Upvalue2 and Upvalue2.party ).leader == Upvalue5.UserId then
    Visible2 = true
else
    Visible2 = false
end
if Upvalue3 then
    Upvalue1.Titre.Text = "MATCH FOUND!"
    Upvalue1.Texte.Text = "Joining the match server..."
    Upvalue1.Annuler.Visible = false
else
    local Entry2
    local Entry = Upvalue6[ ( Upvalue2 and Upvalue2.queue ).mode ]
    Entry2 = if Entry then Entry else tostring( ( Upvalue2 and Upvalue2.queue ).mode )
    local Text = ( Upvalue2 and Upvalue2.queue ).kind ~= "unranked" and " RANKED" or " CASUAL"
    local Text4
    local Text2 = Entry2 .. Text
    local Titre = Upvalue1.Titre
    Titre.Text = "SEARCHING · " .. Text2
    local Max = math.max( 0, ( math.floor( ( ( Upvalue2 and Upvalue2.queue ).elapsed or 0 ) + ( os.clock( ) - Upvalue7 ) ) ) )
    local Format = ( "%d:%02d" ):format( Max // 60, Max % 60 )

    if not ( Upvalue2 and Upvalue2.party ) or type( ( Upvalue2 and Upvalue2.party ).members ) ~= "table" then
        Text4 = Format
    else
        local Size2

        if Upvalue8.Modes[ ( Upvalue2 and Upvalue2.queue ).mode ] then
            local Size = Upvalue8.Modes[ ( Upvalue2 and Upvalue2.queue ).mode ].size

            if Size then
                Size2 = Size
            else
                Size2 = #( Upvalue2 and Upvalue2.party ).members
            end
        else
            Size2 = #( Upvalue2 and Upvalue2.party ).members
        end

        local Text3 = Format .. ( "  ·  Party %d/%d" ):format( #( Upvalue2 and Upvalue2.party ).members, Size2 )

        if Visible2 then
            Text4 = Text3
        else
            local Value1
            local Members = ( Upvalue2 and Upvalue2.party ).members
            Value1 = nil

            for Key, Value in Members, nil, nil do
                if Value.id == ( Upvalue2 and Upvalue2.party ).leader then
                    Text4 = Text3 .. "  ·  " .. tostring( Value.name ) .. " is leading"
                    break
                end

                Text4 = Text3
            end
        end
    end
    if Upvalue1.Texte.Text ~= Text4 then
        Upvalue1.Texte.Text = Text4
    end

    local Text5
    Upvalue1.Annuler.Visible = Visible2
    local Texte = Upvalue1.Annuler.Texte
    Text5 = not Upvalue9 and "CANCEL" or "..."
    Texte.Text = Text5
end

local Clock = os.clock( ) % 1.6 / 1.6
local Barre = Upvalue1.Barre
Barre.Position = UDim2.fromScale( -0.25 + Clock * 1.25, Upvalue1.Barre.Position.Y.Scale )
]]

--[[
Function #69 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false

if Upvalue2 then
    Upvalue2.queue = nil
end
if not workspace:GetAttribute( "RankedMatch" ) then
    task.delay( 1, Upvalue3 )
end
]]

--[[
Function #70 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "cancel" )

if Success and type( Result ) == "table" and not Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
    Upvalue2.Error( Result.msg )
end

Upvalue3( )
Upvalue4 = false
]]

--[[
Function #71 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end
Upvalue1 = true
task.spawn( function()
    local Success, Result = pcall( Upvalue3.InvokeServer, Upvalue3, "cancel" )

    if Success and type( Result ) == "table" and not Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
        Upvalue4.Error( Result.msg )
    end

    Upvalue5( )
    Upvalue1 = false
end )
return
]]

--[[
Function #72 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2( )

    if os.clock( ) - Upvalue3 > 5 and not Upvalue4 then
        Upvalue3 = os.clock( )
        task.spawn( Upvalue5 )
        return
    end
elseif Upvalue6.Visible then
    Upvalue6.Visible = false
end
]]

--[[
Function #73 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Members = Upvalue2 and Upvalue2.party and type( ( Upvalue2 and Upvalue2.party ).members ) == "table" and #( Upvalue2 and Upvalue2.party ).members > 0 and ( Upvalue2 and Upvalue2.party ).members or {
    { id = Upvalue3.UserId, name = Upvalue3.DisplayName, barge = Argument1 }
}
local Visible
local Count = #Members

if Argument2 then
    if Upvalue4 == nil then
        if Count > 1 then
            Visible = true
        else
            Visible = Argument1
        end
    else
        Visible = false
    end
else
    Visible = Argument2
end
if Upvalue1.Visible ~= Visible then
    Upvalue1.Visible = Visible
end
if not Visible then
    return
end

local Leader = Upvalue2 and Upvalue2.party and ( Upvalue2 and Upvalue2.party ).leader or Upvalue3.UserId
local Value1
local Table = { Count, Leader }
Value1 = nil

for Key, Value in Members, nil, nil do
    local Text4
    local Text3 = tostring( Value.id )
    Text4 = not Value.barge and "" or "b"
    table.insert( Table, Text3 .. Text4 .. tostring( Value.name ) )
end

local Concat = table.concat( Table, "|" )

if Concat == Upvalue5 then
    return
end

local Text
Upvalue5 = Concat
local PartyMax = Upvalue6.PartyMax or 5
local Vivants = Upvalue1.Entete.Vivants

if Count <= 1 then
    Text = "SOLO"
elseif Count == 2 then
    Text = "2V2"
elseif PartyMax <= Count then
    Text = "5V5"
else
    Text = ( "5V5 %d/%d" ):format( Count, PartyMax )
end

local Value2
Vivants.Text = Text
Value2 = nil

for Key2, Value3 in Upvalue7, nil, nil do
    Value3:Destroy( )
end

local Value4
table.clear( Upvalue7 )
Value4 = nil

for Key3, Value5 in Members, nil, nil do
    local Flag
    local Clone = Upvalue8.GroupeLigne:Clone( )
    Clone.Name = "Membre_" .. tostring( Value5.id )
    Clone.LayoutOrder = Key3
    Clone.Visible = true
    local Avatar = Clone.Avatar
    Avatar.Image = ( "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150" ):format( Value5.id )
    local Nom = Clone.Nom
    Nom.Text = tostring( Value5.name )
    local NotBarge = not Value5.barge

    if Count > 1 then
        if Value5.id == Leader then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    local Visible2
    local Rang = Clone.Rang
    Visible2 = Count > 1 and true or false
    local Text2
    Rang.Visible = Visible2
    local Rang2 = Clone.Rang

    if NotBarge then
        Text2 = "NOT ON THE BOAT"
    elseif Flag then
        Text2 = "LEADER"
    else
        Text2 = "MEMBER"
    end

    local TextColor3
    Rang2.Text = Text2
    local Rang3 = Clone.Rang

    if not NotBarge or not Upvalue9 then
        if not Flag or not Upvalue10 then
            TextColor3 = Color3.new( 1, 1, 1 )
        else
            TextColor3 = Upvalue10
        end
    else
        TextColor3 = Upvalue9
    end

    local ImageTransparency
    Rang3.TextColor3 = TextColor3
    local Avatar2 = Clone.Avatar
    ImageTransparency = not NotBarge and 0 or 0.5
    local TextTransparency
    Avatar2.ImageTransparency = ImageTransparency
    local Nom2 = Clone.Nom
    TextTransparency = not NotBarge and 0 or 0.45
    Nom2.TextTransparency = TextTransparency
    Clone.Parent = Upvalue1
    table.insert( Upvalue7, Clone )
end
]]

--[[
Function #74 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
Upvalue2 = Upvalue2 + Argument1

if Upvalue2 < 0.1 then
    if Upvalue3 and not Upvalue4.CursorFree then
        Upvalue4.CursorFree = true
    end

    return
end
local Flag
Upvalue2 = 0
Upvalue5( )
local Value1 = Upvalue6( )

if Value1 == nil then
    Flag = false
else
    Flag = Upvalue7( )
end
if Flag then
    Upvalue8.Position = UDim2.fromScale( 0.5, ( math.max( Value1 - 0.012, 0.3 ) ) )
end

local RankedHub
local PlayerGui = Upvalue9:FindFirstChildOfClass( "PlayerGui" )

if PlayerGui then
    RankedHub = Upvalue9.PlayerGui:FindFirstChild( "RankedHub" )
else
    RankedHub = PlayerGui
end

local Use

if RankedHub then
    Use = RankedHub:FindFirstChild( "Use" )
else
    Use = RankedHub
end

local Visible

if Flag then
    if Upvalue3 == nil then
        local PlayerGui2 = if Use then Use.Visible else Use
        Visible = not PlayerGui2
    else
        Visible = false
    end
else
    Visible = Flag
end
if Upvalue8.Visible ~= Visible then
    Upvalue8.Visible = Visible
end

local Flag2 = Value1 ~= nil and true or false
Upvalue10( Flag, Flag2 )

if not Flag or Upvalue11 then
    if Flag and Upvalue13 and os.clock( ) - Upvalue12 > 3 then
        Upvalue13 = false

        if not Upvalue14 then
            Upvalue15 = os.clock( )
            task.spawn( Upvalue16 )
        end
    end
else
    Upvalue12 = os.clock( )
    Upvalue13 = true

    if not Upvalue14 and os.clock( ) - Upvalue15 > 1 then
        Upvalue15 = os.clock( )
        task.spawn( Upvalue16 )
    end
end

Upvalue11 = Flag

if Flag and not Upvalue17 and not Upvalue14 and os.clock( ) - Upvalue15 > 5 then
    Upvalue15 = os.clock( )
    task.spawn( Upvalue16 )
end
if Upvalue3 then
    if not Flag or Upvalue4.ActiveMenu ~= "Ranked" then
        if Upvalue3 ~= nil then
            Upvalue3 = nil

            if Upvalue18 then
                Upvalue18:Cancel( )
                Upvalue18 = nil
            end

            Upvalue19.UIScale.Scale = 1
            Upvalue19.Visible = false
            Upvalue20 = Upvalue20 + 1

            if Upvalue21 then
                Upvalue21( )
            else
                local Text
                Upvalue22.Texte.Text = Upvalue23
                Text = if true or not true then Upvalue24 else ""

                if Upvalue25.Text ~= Text then
                    Upvalue25.Text = Text
                end

                local TextColor3 = not true and Upvalue26 or Upvalue27

                if Upvalue25.TextColor3 ~= TextColor3 then
                    Upvalue25.TextColor3 = TextColor3
                end
            end
            if Upvalue4.ActiveMenu == "Ranked" then
                Upvalue4.ActiveMenu = nil
                Upvalue4.CursorFree = false
            end

            Upvalue28( )
        end
    end
end
if Upvalue3 and not Upvalue4.CursorFree then
    Upvalue4.CursorFree = true
end

return
]]

--[[
Function #75 has no emitted closure site
It is reproduced here so that nothing is lost

return require( Upvalue1:WaitForChild( "GamepadNav", 10 ) )
]]

--[[
Function #76 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == "unranked" then
    return "ranked"
end
return "unranked"
]]

--[[
Function #77 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Text = Upvalue2 ~= "unranked" and "unranked" or "ranked"
    local Text2 = Text ~= "unranked" and "ranked" or "unranked"
    Upvalue3 = true
    Upvalue2 = Text2
    Upvalue4( )

    if Upvalue5 then
        Upvalue5( )
    end
end
]]

--[[
Function #78 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #79 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == nil then
    return
end

Upvalue1 = nil

if Upvalue2 then
    Upvalue2:Cancel( )
    Upvalue2 = nil
end

Upvalue3.UIScale.Scale = 1
Upvalue3.Visible = false
Upvalue4 = Upvalue4 + 1

if Upvalue5 then
    Upvalue5( )
else
    local Text
    Upvalue6.Texte.Text = Upvalue7
    Text = if true or not true then Upvalue8 else ""

    if Upvalue9.Text ~= Text then
        Upvalue9.Text = Text
    end

    local TextColor3 = not true and Upvalue10 or Upvalue11

    if Upvalue9.TextColor3 ~= TextColor3 then
        Upvalue9.TextColor3 = TextColor3
    end
end
if Upvalue12.ActiveMenu == "Ranked" then
    Upvalue12.ActiveMenu = nil
    Upvalue12.CursorFree = false
end

Upvalue13( )
]]

--[[
Function #80 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    if not Upvalue2.IsOpen( "Ranked" ) then
        Upvalue2.Open( "Ranked", {
            root = Upvalue1,
            first = function()
                return Upvalue3
            end,
            onBack = function()
                if Upvalue4 == nil then
                    return
                end

                Upvalue4 = nil

                if Upvalue5 then
                    Upvalue5:Cancel( )
                    Upvalue5 = nil
                end

                Upvalue1.UIScale.Scale = 1
                Upvalue1.Visible = false
                Upvalue6 = Upvalue6 + 1

                if Upvalue7 then
                    Upvalue7( )
                else
                    local Text
                    Upvalue3.Texte.Text = Upvalue8
                    Text = if true or not true then Upvalue9 else ""

                    if Upvalue10.Text ~= Text then
                        Upvalue10.Text = Text
                    end

                    local TextColor3 = not true and Upvalue11 or Upvalue12

                    if Upvalue10.TextColor3 ~= TextColor3 then
                        Upvalue10.TextColor3 = TextColor3
                    end
                end
                if Upvalue13.ActiveMenu == "Ranked" then
                    Upvalue13.ActiveMenu = nil
                    Upvalue13.CursorFree = false
                end

                Upvalue14( )
            end,
            tabs = { prev = Upvalue15, next = Upvalue15, label = "Ranked / Casual" }
        } )
        return
    end
else
    Upvalue2.Close( "Ranked" )
end
]]

--[[
Function #81 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1:GetDescendants( ) do
    if Value:IsA( "GuiButton" ) and Value.Name == "Bouton" and Value.Visible and Value.AbsoluteSize.Y > 2 then
        if not Value1 or Value.AbsolutePosition.Y < Value1.AbsolutePosition.Y then
            Value1 = Value
        end
    end
end

local Value2 = if Value1 then Value1 else Upvalue1:FindFirstChild( "Close" )
return Value2
]]

--[[
Function #82 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = false
]]

--[[
Function #83 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Visible or not Upvalue2.Visible then
    Upvalue3.Close( "RankedPlayers" )
elseif not Upvalue3.IsOpen( "RankedPlayers" ) then
    Upvalue3.Open( "RankedPlayers", {
        root = Upvalue4,
        first = Upvalue5,
        onBack = function()
            Upvalue1.Visible = false
        end
    } )
    return
end
]]

--[[
Function #84 has no emitted closure site
It is reproduced here so that nothing is lost

local Id = Upvalue1:GetAttribute( "Id" )
Upvalue2 = Upvalue2 + 1
Upvalue1.Visible = false

if Id then
    local Text = "decline"
    task.spawn( function()
        local Success, Result = pcall( Upvalue3.InvokeServer, Upvalue3, Text, Id )

        if Text == "accept" and Success and type( Result ) == "table" and not Result.ok and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end
        if Text == "accept" and Success and type( Result ) == "table" and Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
            Upvalue4.Error( Result.msg )
        end

        Upvalue5( )
    end )
    return
end
return
]]

--[[
Function #85 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    local Open = Upvalue2.Open
    Open( "RankedInvite", {
        root = Upvalue1,
        passive = not Upvalue3.Visible,
        engageLabel = "Reply",
        first = Upvalue1.Accepter,
        onBack = function()
            local Id = Upvalue1:GetAttribute( "Id" )
            Upvalue4 = Upvalue4 + 1
            Upvalue1.Visible = false

            if Id then
                local Text = "decline"
                task.spawn( function()
                    local Success, Result = pcall( Upvalue5.InvokeServer, Upvalue5, Text, Id )

                    if Text == "accept" and Success and type( Result ) == "table" and not Result.ok and type( Result.msg ) == "string" and Result.msg ~= "" then
                        Upvalue6.Error( Result.msg )
                    end
                    if Text == "accept" and Success and type( Result ) == "table" and Result.ok and Result.msg and type( Result.msg ) == "string" and Result.msg ~= "" then
                        Upvalue6.Error( Result.msg )
                    end

                    Upvalue7( )
                end )
                return
            end
            return
        end
    } )
    return
end
Upvalue2.Close( "RankedInvite" )
return
]]

--[[
Function #86 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
Upvalue2( )
]]

--[[
Function #87 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false

if Upvalue2.IsOpen( "RankedPlayers" ) then
    Upvalue2.Refresh( "RankedPlayers" )
end
if Upvalue2.IsOpen( "Ranked" ) then
    Upvalue2.Refresh( "Ranked" )
end
]]

--[[
Function #88 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
task.delay( 0.1, function()
    Upvalue1 = false

    if Upvalue2.IsOpen( "RankedPlayers" ) then
        Upvalue2.Refresh( "RankedPlayers" )
    end
    if Upvalue2.IsOpen( "Ranked" ) then
        Upvalue2.Refresh( "Ranked" )
    end
end )
return
]]

--[[
Function #89 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "GuiButton" ) then
    if Upvalue1 then
        return
    end

    Upvalue1 = true
    task.delay( 0.1, function()
        Upvalue1 = false

        if Upvalue2.IsOpen( "RankedPlayers" ) then
            Upvalue2.Refresh( "RankedPlayers" )
        end
        if Upvalue2.IsOpen( "Ranked" ) then
            Upvalue2.Refresh( "Ranked" )
        end
    end )
end
]]
