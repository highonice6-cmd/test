-- Players.perkbrokeyou.PlayerScripts.ShopClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #64

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute2
local Attribute = Upvalue1:GetAttribute( "PackProduct_" .. Argument1.id )
Attribute2 = if Attribute then Attribute else Argument1.ProductId
return Attribute2
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
Upvalue2( )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
task.delay( 0.05, function()
    Upvalue1 = false
    Upvalue2( )
end )
return
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local ProductId2 = Value.pack.ProductId

    if Upvalue2.Pending( ProductId2 ) then
        local SetBuy7 = Upvalue2.SetBuy
        SetBuy7( Value.buy, "wait", "..." )
    else
        local SetBuy8 = Upvalue2.SetBuy
        local Buy3 = Value.buy
        SetBuy8( Buy3, "buy", Upvalue2.PriceText( ProductId2, Upvalue3 ) )
    end
end
if Upvalue4 then
    local ProductId = Upvalue5.ProductId

    if Upvalue2.Pending( ProductId ) then
        Upvalue2.SetBuy( Upvalue4, "wait", "..." )
    else
        local PriceText2
        local PriceText = Upvalue2.PriceText( ProductId, Upvalue3 )
        PriceText2 = if PriceText == "..." then Upvalue2.ROBUX .. " 499" else PriceText
        Upvalue2.SetBuy( Upvalue4, "buy", PriceText2 )
    end
end
if Upvalue6 then
    if Upvalue7:GetAttribute( "StarterPackOwned" ) or Upvalue8.Owned( Upvalue7, "StarterPack" ) then
        Upvalue2.SetBuy( Upvalue6, "equipped", "OWNED" )
    else
        local PriceText4
        local PriceText3 = Upvalue8.PriceText( "StarterPack", Upvalue3 )

        if PriceText3 == "..." or PriceText3 == "" then
            local ROBUX = Upvalue2.ROBUX
            PriceText4 = ROBUX .. " " .. Upvalue9.Price
        else
            PriceText4 = PriceText3
        end

        Upvalue2.SetBuy( Upvalue6, "buy", PriceText4 )
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue10, nil, nil do
    if Value3.buy then
        local Attribute2
        local Pack = Value3.pack
        local Attribute = Upvalue7:GetAttribute( "PackProduct_" .. Pack.id )
        Attribute2 = if Attribute then Attribute else Pack.ProductId

        if Upvalue7:GetAttribute( "PackBought_" .. Value3.pack.id ) == true or Upvalue7:GetAttribute( "Pack_" .. Value3.pack.id ) == true then
            local SetBuy6 = Upvalue2.SetBuy
            SetBuy6( Value3.buy, "equipped", "OWNED" )
        elseif Attribute2 then
            if Upvalue2.Pending( Attribute2 ) then
                local SetBuy4 = Upvalue2.SetBuy
                SetBuy4( Value3.buy, "wait", "..." )
            else
                local SetBuy5 = Upvalue2.SetBuy
                local Buy2 = Value3.buy
                SetBuy5( Buy2, "buy", Upvalue2.PriceText( Attribute2, Upvalue3 ) )
            end
        else
            local SetBuy3 = Upvalue2.SetBuy
            SetBuy3( Value3.buy, "wait", "SOON" )
        end
    end
end

local Value4 = nil

for Key3, Value5 in Upvalue11, nil, nil do
    local Show2

    if Value5.show then
        local Show = Value5.show( )

        if Show then
            Show2 = Show
        else
            Show2 = Value5.pass
        end
    else
        Show2 = Value5.pass
    end
    if Upvalue8.Owned( Upvalue7, Show2.id ) then
        local SetBuy = Upvalue2.SetBuy
        SetBuy( Value5.buy, "equipped", "OWNED" )
    else
        local SetBuy2 = Upvalue2.SetBuy
        local Buy = Value5.buy
        SetBuy2( Buy, "buy", Upvalue8.PriceText( Show2.id, Upvalue3 ) )
    end
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Value then
        Value.Visible = true
    end
end
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Value then
        Value.Visible = false
    end
end

Upvalue2:Open( {
    title = Argument1,
    onSend = Argument2,
    onClose = function()
        local Value1 = nil

        for Key, Value in Upvalue1, nil, nil do
            if Value then
                Value.Visible = true
            end
        end
    end
} )
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Gift = Upvalue1.Gift
Gift( "Cash", Upvalue2.id, Argument1, Argument2 )
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( "GIFT " .. Upvalue2( Gift.Amount ), function( Argument1, Argument2 )
    local GiftInner = Upvalue3.Gift
    GiftInner( "Cash", Gift.id, Argument1, Argument2 )
end )
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1:GetAttribute( "StarterPackOwned" ) or Upvalue2.Owned( Upvalue1, "StarterPack" ) then
    return
end
Upvalue2.Offer( "StarterPack" )
return
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Pending( Upvalue2.ProductId ) then
    return
end
if Upvalue1.Buy( Upvalue2.Category, Upvalue2.Item ) then
    Upvalue3( )
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Pending( Upvalue2.ProductId ) and ( Upvalue3:GetAttribute( "Stat_Kills" ) or 0 ) == 0 then
    Upvalue1.Done( Upvalue2.ProductId )
end
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Pending( Upvalue2.ProductId ) then
    return
end

local Buy = Upvalue1.Buy

if Buy( "Cash", Upvalue2.id ) then
    Upvalue3( )
end
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue2( "GIFT " .. Upvalue3( Upvalue1.Amount ), function( Argument1, Argument2 )
    local Gift = Upvalue4.Gift
    Gift( "Cash", Upvalue1.id, Argument1, Argument2 )
end )
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1 == nil then
    Flag = false
elseif Upvalue2:GetAttribute( Upvalue3.Attr ) == true then
    Flag = false
elseif Upvalue2:GetAttribute( "CrewPass" ) == true then
    Flag = true
elseif Upvalue2:GetAttribute( "ClanPass" ) == true then
    Flag = true
else
    Flag = false
end
if Flag ~= Upvalue4 then
    Upvalue4 = Flag

    if Upvalue5 then
        local Text

        if Flag then
            local AltTag = Upvalue6:GetAttribute( "AltTag" )

            if AltTag then
                Text = AltTag
            else
                Text = "GAME PASS"
            end
        else
            Text = Upvalue7[ 1 ]
        end

        Upvalue5.Text = Text
    end
    if Upvalue8 then
        local Text2

        if Flag then
            local AltName = Upvalue6:GetAttribute( "AltName" )

            if AltName then
                Text2 = AltName
            else
                Text2 = "CREATE A CLAN"
            end
        else
            Text2 = Upvalue7[ 2 ]
        end

        Upvalue8.Text = Text2
    end
    if Upvalue9 then
        local Text3

        if Flag then
            local AltSub = Upvalue6:GetAttribute( "AltSub" )

            if AltSub then
                Text3 = AltSub
            else
                local Item = Upvalue7[ 3 ]

                if Item then
                    Text3 = Item
                else
                    Text3 = Upvalue7[ 3 ]
                end
            end
        else
            Text3 = Upvalue7[ 3 ]
        end

        Upvalue9.Text = Text3
    end
    if Upvalue10 then
        Upvalue10.Visible = not Flag
    end
end

local Captured = Flag and Upvalue1 or Upvalue3
return Captured
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
local Find = Upvalue1.Find( Argument2.Alt )
local Tag = Object:FindFirstChild( "Tag" )

if Tag then
    Text = Object.Tag:FindFirstChild( "Text" )
else
    Text = Tag
end

local Tag2
local Name = Object:FindFirstChild( "Name" )
local Sub = Object:FindFirstChild( "Sub" )
local SubPlate = Object:FindFirstChild( "SubPlate", true )
local Table = { }
Tag2 = if Text then Text.Text else Text
local Name2 = if Name then Name.Text else Name
local Sub2 = if Sub then Sub.Text else Sub
Table[ 1 ] = Tag2
Table[ 2 ] = Name2
Table[ 3 ] = Sub2
local Value1 = nil

local function Callback()
    local Flag

    if Find == nil then
        Flag = false
    elseif Upvalue2:GetAttribute( Argument2.Attr ) == true then
        Flag = false
    elseif Upvalue2:GetAttribute( "CrewPass" ) == true then
        Flag = true
    elseif Upvalue2:GetAttribute( "ClanPass" ) == true then
        Flag = true
    else
        Flag = false
    end
    if Flag ~= Value1 then
        Value1 = Flag

        if Text then
            local TextInner

            if Flag then
                local AltTag = Object:GetAttribute( "AltTag" )

                if AltTag then
                    TextInner = AltTag
                else
                    TextInner = "GAME PASS"
                end
            else
                TextInner = Table[ 1 ]
            end

            Text.Text = TextInner
        end
        if Name then
            local Text2

            if Flag then
                local AltName = Object:GetAttribute( "AltName" )

                if AltName then
                    Text2 = AltName
                else
                    Text2 = "CREATE A CLAN"
                end
            else
                Text2 = Table[ 2 ]
            end

            Name.Text = Text2
        end
        if Sub then
            local Text3

            if Flag then
                local AltSub = Object:GetAttribute( "AltSub" )

                if AltSub then
                    Text3 = AltSub
                else
                    local Item = Table[ 3 ]

                    if Item then
                        Text3 = Item
                    else
                        Text3 = Table[ 3 ]
                    end
                end
            else
                Text3 = Table[ 3 ]
            end

            Sub.Text = Text3
        end
        if SubPlate then
            SubPlate.Visible = not Flag
        end
    end

    local Captured = Flag and Find or Argument2
    return Captured
end

return Callback
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Show2

if Upvalue1.show then
    local Show = Upvalue1.show( )

    if Show then
        Show2 = Show
    else
        Show2 = Upvalue2
    end
else
    Show2 = Upvalue2
end
if not Upvalue3.Owned( Upvalue4, Show2.id ) then
    Upvalue3.Offer( Show2.id )
end
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Gift = Upvalue1.Gift
Gift( "Pass", Upvalue2.id, Argument1, Argument2 )
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Show2

if Upvalue1.show then
    local Show = Upvalue1.show( )

    if Show then
        Show2 = Show
    else
        Show2 = Upvalue2
    end
else
    Show2 = Upvalue2
end
if ( Show2.GiftProduct or 0 ) <= 0 then
    Show2 = Upvalue2
end

Upvalue3( "GIFT " .. string.upper( Show2.Name ), function( Argument1, Argument2 )
    local Gift = Upvalue4.Gift
    Gift( "Pass", Show2.id, Argument1, Argument2 )
end )
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

Upvalue1 = true

if Upvalue2 then
    Upvalue2.Visible = false
end

local Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    if Value.fx and Value.fx.showModel then
        Value.fx.showModel.Parent = nil
    end
    if Value.fx and Value.fx.flowModel then
        Value.fx.flowModel.Parent = nil
    end
end
if Upvalue4 ~= Upvalue5 then
    local Scale = Upvalue5.CanvasSize.Y.Scale * Upvalue4.Size.Y.Scale
    Upvalue4.Position = UDim2.fromScale( 0, 0 )
    Upvalue4.Size = UDim2.fromScale( 1, 1 )
    local Scale2 = Upvalue5.CanvasSize.X.Scale
    Upvalue5.CanvasSize = UDim2.new( Scale2, Upvalue5.CanvasSize.X.Offset, Scale, 0 )
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

return math.abs( Argument1.X ) * Upvalue1.X + math.abs( Argument1.Y ) * Upvalue1.Y + math.abs( Argument1.Z ) * Upvalue1.Z
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local FromNormalId = Vector3.FromNormalId( Argument1.Face )
local Entry = Upvalue1[ Argument1.Face ] or Vector3.new( 0, 1, 0 )
local Cross = ( -FromNormalId ):Cross( Entry )
local Size = Argument2.Size

local function Ext( Argument1 )
    return math.abs( Argument1.X ) * Size.X + math.abs( Argument1.Y ) * Size.Y + math.abs( Argument1.Z ) * Size.Z
end

local FromNormalId2 = FromNormalId * ( math.abs( FromNormalId.X ) * Size.X + math.abs( FromNormalId.Y ) * Size.Y + math.abs( FromNormalId.Z ) * Size.Z ) / 2 + Entry * ( math.abs( Entry.X ) * Size.X + math.abs( Entry.Y ) * Size.Y + math.abs( Entry.Z ) * Size.Z ) / 2 - Cross * ( math.abs( Cross.X ) * Size.X + math.abs( Cross.Y ) * Size.Y + math.abs( Cross.Z ) * Size.Z ) / 2
local ToObjectSpace = Argument3:ToObjectSpace( Argument2.CFrame )
local ToObjectSpace2 = ToObjectSpace * FromNormalId2
return ToObjectSpace2:Dot( ToObjectSpace:VectorToWorldSpace( Cross ) ), -ToObjectSpace2:Dot( ToObjectSpace:VectorToWorldSpace( Entry ) )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local FoundChild
local Model = Parent:FindFirstChildWhichIsA( "Model" )
local Weapon = Parent:GetAttribute( "Weapon" ) or "M60"
local Table = { Skin = Parent:GetAttribute( "Skin" ) or "Hellspawn" }
local SkinVisual = Upvalue1.SkinVisual( Weapon, Table )

if SkinVisual then
    FoundChild = SkinVisual
else
    FoundChild = Upvalue2:FindFirstChild( Weapon )
end

local Name

if FoundChild then
    Name = Weapon
else
    local SkinVisual3
    local FallbackWeapon = Parent:GetAttribute( "FallbackWeapon" ) or ""
    local SkinVisual2 = Upvalue1.SkinVisual( FallbackWeapon, Table )
    SkinVisual3 = if SkinVisual2 then SkinVisual2 else Upvalue2:FindFirstChild( FallbackWeapon )
    FoundChild = SkinVisual3
    Name = FallbackWeapon
end
if not FoundChild then
    return nil
end

local Clone = FoundChild:Clone( )
pcall( Upvalue1.Apply, Clone, Name, Table )

for Key, Value in Clone:GetDescendants( ) do
    if Value:IsA( "LuaSourceContainer" ) or Value:IsA( "Sound" ) or Value:IsA( "ParticleEmitter" ) or Value:IsA( "Light" ) or Value:IsA( "Beam" ) then
        Value:Destroy( )
    elseif Value:IsA( "BasePart" ) then
        Value.Anchored = true
    end
end
if Model then
    Clone:PivotTo( Model:GetPivot( ) )
    Model:Destroy( )
end

local Unit2
Clone.Name = Name
local WorldPivot = Clone:GetPivot( )
local Position = Clone:GetBoundingBox( ).Position

if Argument2 then
    local Unit = ( Argument2 - Position ).Unit

    if Unit then
        Unit2 = Unit
    else
        Unit2 = Vector3.new( 1, 0, 0 )
    end
else
    Unit2 = Vector3.new( 1, 0, 0 )
end

local Parent2 = Instance.new( "Model" )
Parent2.Name = Name .. "_Flow"

for Key2, Value2 in Clone:GetDescendants( ) do
    if Value2:IsA( "BasePart" ) then
        local SkinFX = Value2:GetAttribute( "SkinFX" )

        if Value2:HasTag( "SkinFX" ) then
            Value2:RemoveTag( "SkinFX" )
        end

        Value2:SetAttribute( "SkinFX", nil )
        local Table2 = { }

        for Key3, Value3 in Value2:GetChildren( ) do
            if Value3:IsA( "Texture" ) and Value3.Name == "SkinFlow" then
                if ( Value3:GetAttribute( "FlowLayer" ) or 1 ) >= 2 then
                    if Value2.CFrame:VectorToWorldSpace( Vector3.FromNormalId( Value3.Face ) ):Dot( Unit2 ) > -0.25 then
                        table.insert( Table2, Value3 )
                    else
                        Value3:Destroy( )
                    end
                else
                    local Value6, Value7 = Upvalue3( Value3, Value2, WorldPivot )
                    local OffsetStudsU = Value6 % Value3.StudsPerTileU
                    local OffsetStudsV = Value7 % Value3.StudsPerTileV
                    Value3.OffsetStudsU = OffsetStudsU
                    Value3.OffsetStudsV = OffsetStudsV
                end
            end
        end
        if #Table2 > 0 and SkinFX then
            local Parent3 = Value2:Clone( )

            for Key4, Value4 in Parent3:GetChildren( ) do
                Value4:Destroy( )
            end

            local Value1
            Parent3.Transparency = 1
            Value1 = nil

            for Key5, Value5 in Table2, nil, nil do
                Value5.Parent = Parent3
            end

            Parent3:SetAttribute( "SkinFX", SkinFX )
            Parent3:AddTag( "SkinFX" )
            Parent3.Parent = Parent2
        end
    end
end

Parent2.WorldPivot = WorldPivot
Clone.Parent = Parent
return Clone, Parent2, Position
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

local Part = Instance.new( "Part" )
Part.Name = Name
Part.Shape = Enum.PartType.Ball
Part.Material = Material
Part.Color = Color
Part.Transparency = Transparency
Part.Anchored = true
Part.CanCollide = false
Part.CanQuery = false
Part.CanTouch = false
Part.CastShadow = false
Part.Parent = Upvalue1
return Part
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = tonumber( Self:GetAttribute( "TankBubbles" ) ) or 0
local TankPart = Self:GetAttribute( "TankPart" )

if Number <= 0 or type( TankPart ) ~= "string" then
    return nil
end

local FoundChild = Parent

for Value in TankPart:gmatch( "[^/]+" ) do
    local FoundChild2 = if FoundChild then FoundChild:FindFirstChild( Value ) else FoundChild
    FoundChild = FoundChild2
end
if not FoundChild or not FoundChild:IsA( "BasePart" ) then
    return nil
end

local NumberRange2
local BubbleSize = Self:GetAttribute( "BubbleSize" )
local BubbleSpeed = Self:GetAttribute( "BubbleSpeed" )

if typeof( BubbleSize ) ~= "NumberRange" or not BubbleSize then
    NumberRange2 = NumberRange.new( 0.05, 0.09 )
else
    NumberRange2 = BubbleSize
end

local NumberRange3

if typeof( BubbleSpeed ) ~= "NumberRange" or not BubbleSpeed then
    NumberRange3 = NumberRange.new( 0.08, 0.15 )
else
    NumberRange3 = BubbleSpeed
end

local Color
local BubbleColor = Self:GetAttribute( "BubbleColor" )

if typeof( BubbleColor ) ~= "Color3" or not BubbleColor then
    Color = Color3.fromRGB( 225, 247, 255 )
else
    Color = BubbleColor
end

local function Ball( Name, Material, Color, Transparency )
    local Part = Instance.new( "Part" )
    Part.Name = Name
    Part.Shape = Enum.PartType.Ball
    Part.Material = Material
    Part.Color = Color
    Part.Transparency = Transparency
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Parent = Parent
    return Part
end

local Random2 = Random.new( )
local Table = {
    box = FoundChild,
    list = { },
    rise = tonumber( Self:GetAttribute( "BubbleRise" ) ) or 0.2,
    bottom = -FoundChild.Size.Y / 2,
    last = 0
}
local I = 1

for I = 1, Number do
    local NextNumber = Random2:NextNumber( NumberRange2.Min, NumberRange2.Max )
    local List = Table.list
    local Part = Instance.new( "Part" )
    Part.Name = "Bulle"
    Part.Shape = Enum.PartType.Ball
    Part.Material = Enum.Material.ForceField
    Part.Color = Color
    Part.Transparency = 0
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Parent = Parent
    local Color2 = Color3.new( 1, 1, 1 )
    local Part2 = Instance.new( "Part" )
    Part2.Name = "Reflet"
    Part2.Shape = Enum.PartType.Ball
    Part2.Material = Enum.Material.Neon
    Part2.Color = Color2
    Part2.Transparency = 0.2
    Part2.Anchored = true
    Part2.CanCollide = false
    Part2.CanQuery = false
    Part2.CanTouch = false
    Part2.CastShadow = false
    Part2.Parent = Parent
    table.insert( List, {
        b = Part,
        h = Part2,
        d = NextNumber,
        x = Random2:NextNumber( -0.5, 0.5 ) * math.max( FoundChild.Size.X - NextNumber, 0 ),
        z = Random2:NextNumber( -0.5, 0.5 ) * math.max( FoundChild.Size.Z - NextNumber, 0 ),
        v = Random2:NextNumber( NumberRange3.Min, NumberRange3.Max ),
        ph = Random2:NextNumber( ),
        w = Random2:NextNumber( 0, 6.28 )
    } )
end

return Table
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local CFrame2 = Argument1.box.CFrame
local RightVector = Argument3.RightVector
local UpVector = Argument3.UpVector
local LookVector = Argument3.LookVector
local List = Argument1.list
Value1 = nil

for Key, Value in List, nil, nil do
    local V = ( Amount * Value.v / Argument1.rise + Value.ph ) % 1
    local D = Value.d * ( math.clamp( math.min( V, 1 - V ) * 7, 0, 1 ) * 0.65 + 0.35 )
    local X = Value.x + math.sin( Amount * 2.6 + Value.w ) * 0.01
    local Bottom = Argument1.bottom + V * Argument1.rise
    local CFrame3 = CFrame2 * Vector3.new( X, Bottom, Value.z )
    local B = Value.b
    B.Size = Vector3.new( 1, 1, 1 ) * D
    local B2 = Value.b
    B2.CFrame = CFrame.new( CFrame3 )
    local H = Value.h
    H.Size = Vector3.new( 1, 1, 1 ) * ( D * 0.22 )
    local H2 = Value.h
    H2.CFrame = CFrame.new( CFrame3 + ( UpVector * 0.24 - RightVector * 0.26 - LookVector * 0.3 ) * D )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

return ( math.exp( -( Argument1 / Argument2 ) ^ 2 ) )
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local Result = Amount / 1.6 % 1

local function Pulse( Argument1, Argument2 )
    return ( math.exp( -( Argument1 / Argument2 ) ^ 2 ) )
end

return ( math.min( 1, math.exp( -( Result / 0.055 ) ^ 2 ) + math.exp( -( ( Result - 1 ) / 0.055 ) ^ 2 ) + 0.6 * ( math.exp( -( ( Result - 0.2 ) / 0.06 ) ^ 2 ) + math.exp( -( ( Result - 1.2 ) / 0.06 ) ^ 2 ) ) ) )
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local CurrentCamera = Instance.new( "Camera" )
CurrentCamera.Name = "Vitrine"
CurrentCamera.CFrame = Upvalue1
CurrentCamera.FieldOfView = Upvalue2
CurrentCamera.Parent = Parent
Parent.CurrentCamera = CurrentCamera
return CurrentCamera
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Parent
local Table = { embers = { } }
local Showcase = Self:FindFirstChild( "Showcase" )

if Showcase then
    Parent = Showcase:FindFirstChild( "View" )
else
    Parent = Showcase
end
if Parent and Parent:IsA( "ViewportFrame" ) then
    local CFrame3
    local CameraCFrame = Parent:GetAttribute( "CameraCFrame" )

    if typeof( CameraCFrame ) == "CFrame" then
        CFrame3 = CameraCFrame
    else
        local CFrame2
        local Camera = Parent:FindFirstChildOfClass( "Camera" )

        if not Camera or not Camera.CFrame then
            CFrame2 = CFrame.new( )
        else
            CFrame2 = Camera.CFrame
        end

        CFrame3 = CFrame2
    end

    local FieldOfView = tonumber( Parent:GetAttribute( "CameraFOV" ) ) or 24

    local function NewCam( Parent )
        local CurrentCamera = Instance.new( "Camera" )
        CurrentCamera.Name = "Vitrine"
        CurrentCamera.CFrame = CFrame3
        CurrentCamera.FieldOfView = FieldOfView
        CurrentCamera.Parent = Parent
        Parent.CurrentCamera = CurrentCamera
        return CurrentCamera
    end

    local Success, ShowModel, FlowModel, ShowCenter = pcall( Upvalue1, Parent, CFrame3.Position )

    if not Success or not ShowModel then
        warn( "[ShopClient] vitrine : " .. tostring( ShowModel ) )
    else
        local CurrentCamera = Instance.new( "Camera" )
        CurrentCamera.Name = "Vitrine"
        CurrentCamera.CFrame = CFrame3
        CurrentCamera.FieldOfView = FieldOfView
        CurrentCamera.Parent = Parent
        Parent.CurrentCamera = CurrentCamera
        Table.showView = Parent
        Table.showModel = ShowModel
        Table.showCam = CurrentCamera
        Table.showBase = CFrame3
        Table.showCenter = ShowCenter
        Table.tank = Upvalue2( Parent, ShowModel )

        if Table.tank then
            Upvalue3( Table.tank, 0, CFrame3 )
        end

        local PulseRest2
        Table.orbit = math.rad( tonumber( Parent:GetAttribute( "OrbitDeg" ) ) or 16 )
        Table.orbitPeriod = math.max( tonumber( Parent:GetAttribute( "OrbitPeriod" ) ) or 7, 1 )
        Table.bob = tonumber( Parent:GetAttribute( "Bob" ) ) or 0.05
        local PulseRest = Parent:GetAttribute( "PulseRest" )
        PulseRest2 = typeof( PulseRest ) == "Color3" and PulseRest or nil
        Table.pulseRest = PulseRest2
        ShowModel.Parent = nil
        local Parent2 = Showcase:FindFirstChild( "Flow" )

        if Parent2 and Parent2:IsA( "ViewportFrame" ) and FlowModel and #FlowModel:GetChildren( ) > 0 then
            local CurrentCamera2 = Instance.new( "Camera" )
            CurrentCamera2.Name = "Vitrine"
            CurrentCamera2.CFrame = CFrame3
            CurrentCamera2.FieldOfView = FieldOfView
            CurrentCamera2.Parent = Parent2
            Parent2.CurrentCamera = CurrentCamera2
            Table.flowView = Parent2
            Table.flowModel = FlowModel
            Table.flowCam = CurrentCamera2
        end
    end

    local ShowGlow = Showcase:FindFirstChild( "Glow" )

    if ShowGlow and ShowGlow:IsA( "ImageLabel" ) then
        local ShowGlowT = ShowGlow.ImageTransparency
        local ShowGlowSize = ShowGlow.Size
        Table.showGlow = ShowGlow
        Table.showGlowT = ShowGlowT
        Table.showGlowSize = ShowGlowSize
    end
end

local Pumpkin2
local Pumpkin = Self:FindFirstChild( "Pumpkin" )
Pumpkin2 = if Pumpkin then Pumpkin else Self:FindFirstChild( "Emblem" )
local PumpkinPos
Table.pumpkin = Pumpkin2
local Pumpkin3 = Table.pumpkin
PumpkinPos = if Pumpkin3 then Table.pumpkin.Position else Pumpkin3
local CandlePos
Table.pumpkinPos = PumpkinPos
Table.candle = Self:FindFirstChild( "Candle" )
local Candle = Table.candle
CandlePos = if Candle then Table.candle.Position else Candle
local CandleT
Table.candlePos = CandlePos
local Candle2 = Table.candle
CandleT = if Candle2 then Table.candle.BackgroundTransparency else Candle2
local GlowSize
Table.candleT = CandleT
Table.glow = Self:FindFirstChild( "Glow" )
local Glow = Table.glow
GlowSize = if Glow then Table.glow.Size else Glow
local GlowPos
Table.glowSize = GlowSize
local Glow2 = Table.glow
GlowPos = if Glow2 then Table.glow.Position else Glow2
local GlowT
Table.glowPos = GlowPos
local Glow3 = Table.glow
GlowT = if Glow3 then Table.glow.ImageTransparency else Glow3
local Shine2
Table.glowT = GlowT
local Shine = Self:FindFirstChild( "Shine" )
Shine2 = if Shine then Shine:FindFirstChildOfClass( "UIGradient" ) else Shine
local StrokeT
Table.shine = Shine2
Table.stroke = Self:FindFirstChildOfClass( "UIStroke" )
local Stroke = Table.stroke
StrokeT = if Stroke then Table.stroke.Transparency else Stroke
local NameGrad
Table.strokeT = StrokeT
local Name = Self:FindFirstChild( "Name" )
NameGrad = if Name then Name:FindFirstChildOfClass( "UIGradient" ) else Name
local Children2
Table.nameGrad = NameGrad
local Embers = Self:FindFirstChild( "Embers" )
local Random2 = Random.new( )
Children2 = Embers and Embers:GetChildren( ) or { }
local Value1 = nil

for Key, Value in Children2, nil, nil do
    if Value:IsA( "GuiObject" ) then
        local Base
        local Img = Value:IsA( "ImageLabel" )
        local Embers2 = Table.embers
        local Table2 = {
            o = Value,
            x = Value.Position.X.Scale,
            speed = Random2:NextNumber( 0.12, 0.32 ),
            phase = Random2:NextNumber( ),
            sway = Random2:NextNumber( 0.004, 0.014 )
        }
        Base = Img and Value.ImageTransparency or Value.BackgroundTransparency
        Table2.base = Base
        Table2.img = Img
        table.insert( Embers2, Table2 )
    end
end

local Children
Table.caustics = { }
local Caustics = Self:FindFirstChild( "Caustics" )
Children = Caustics and Caustics:GetChildren( ) or { }
local Value2 = nil

for Key2, Value3 in Children, nil, nil do
    if Value3:IsA( "ImageLabel" ) then
        local Caustics2 = Table.caustics
        table.insert( Caustics2, {
            o = Value3,
            box = Caustics,
            ratio = tonumber( Value3:GetAttribute( "TileRatio" ) ) or 0.8,
            speed = tonumber( Value3:GetAttribute( "Speed" ) ) or 0.02,
            phase = Random2:NextNumber( )
        } )
    end
end

return Table
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1:GetAttribute( "PackBought_" .. Upvalue2.id ) ~= true and Upvalue1:GetAttribute( "Pack_" .. Upvalue2.id ) ~= true then
    local Attribute2
    local Pending = Upvalue3.Pending
    local Attribute = Upvalue1:GetAttribute( "PackProduct_" .. Upvalue2.id )
    Attribute2 = if Attribute then Attribute else Upvalue2.ProductId

    if not Pending( Attribute2 ) then
        local Attribute4
        local Attribute3 = Upvalue1:GetAttribute( "PackProduct_" .. Upvalue2.id )
        Attribute4 = if Attribute3 then Attribute3 else Upvalue2.ProductId

        if not Attribute4 then
            Upvalue4.Error( "Coming soon" )
            return
        end
        if not Upvalue5.Active( Upvalue2 ) then
            Upvalue4.Error( "This limited offer has ended" )
            return
        end

        local Buy = Upvalue3.Buy

        if Buy( "Pack", Upvalue2.id ) then
            Upvalue6( )
        end

        return
    end
end
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

local Gift = Upvalue1.Gift
Gift( "Pack", Upvalue2.id, Argument1, Argument2 )
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.ProductId then
    Upvalue3( "GIFT THE " .. string.upper( Upvalue1.Name ), function( Argument1, Argument2 )
        local Gift = Upvalue4.Gift
        Gift( "Pack", Upvalue1.id, Argument1, Argument2 )
    end )
    return
end
Upvalue2.Error( "Coming soon" )
return
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute2
Upvalue1.Done( Upvalue2.ProductId )
local Attribute = Upvalue3:GetAttribute( "PackProduct_" .. Upvalue2.id )
Attribute2 = if Attribute then Attribute else Upvalue2.ProductId

if Attribute2 ~= Upvalue2.ProductId then
    local Attribute4
    local Done = Upvalue1.Done
    local Attribute3 = Upvalue3:GetAttribute( "PackProduct_" .. Upvalue2.id )
    Attribute4 = if Attribute3 then Attribute3 else Upvalue2.ProductId
    Done( Attribute4 )
end
if Upvalue4 then
    return
end
Upvalue4 = true
task.delay( 0.05, function()
    Upvalue4 = false
    Upvalue5( )
end )
return
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

local Scale = Argument1.pos.Y.Scale + Argument1.size.Y.Scale

if Scale <= 1 then
    return 1
end
return Scale + ( Upvalue1.gap or 0.071 )
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue2 == Upvalue3 then
    return
end
if not Upvalue4 then
    local Value1
    local Scale = Upvalue3.CanvasSize.Y.Scale
    Upvalue4 = {
        H = Scale,
        limH = Upvalue1.Size.Y.Scale * Scale,
        mainY = Upvalue2.Position.Y.Scale * Scale,
        mainH = Upvalue2.Size.Y.Scale * Scale,
        cards = { }
    }
    Value1 = nil

    for Key, Value in Upvalue5, nil, nil do
        local Table = { pos = Value.card.Position, size = Value.card.Size }
        local Cards = Upvalue4.cards
        Cards[ Value.card ] = Table
        local Scale2 = Table.pos.Y.Scale + Table.size.Y.Scale

        if Scale2 <= 1 and not Upvalue4.gap then
            Upvalue4.gap = 1 - Scale2
        end
    end
end

local Value2, Number

local function Slots( Argument1 )
    local Scale = Argument1.pos.Y.Scale + Argument1.size.Y.Scale

    if Scale <= 1 then
        return 1
    end
    return Scale + ( Upvalue4.gap or 0.071 )
end

Value2 = nil
Number = 0

for Key2, Value3 in Upvalue5, nil, nil do
    local Entry2 = Upvalue4.cards[ Value3.card ]

    if Entry2 and Value3.card.Visible then
        local Number4
        local Scale8 = Entry2.pos.Y.Scale + Entry2.size.Y.Scale
        Number4 = if Scale8 <= 1 then 1 else Scale8 + ( Upvalue4.gap or 0.071 )
        Number = Number + Number4
    end
end

local Value4, Number2
local Max = math.max( Number, 1 )
local LimH = Upvalue4.limH * Max
local LimH2 = LimH - Upvalue4.limH
local H = Upvalue4.H + LimH2
local Scale3 = Upvalue1.Size.X.Scale
local Offset = Upvalue1.Size.X.Offset
Upvalue1.Size = UDim2.new( Scale3, Offset, LimH / H, 0 )
local Scale4 = Upvalue2.Position.X.Scale
local Offset2 = Upvalue2.Position.X.Offset
Upvalue2.Position = UDim2.new( Scale4, Offset2, ( Upvalue4.mainY + LimH2 ) / H, 0 )
local Scale5 = Upvalue2.Size.X.Scale
local Offset3 = Upvalue2.Size.X.Offset
Upvalue2.Size = UDim2.new( Scale5, Offset3, Upvalue4.mainH / H, 0 )
local Scale6 = Upvalue3.CanvasSize.X.Scale
Upvalue3.CanvasSize = UDim2.new( Scale6, Upvalue3.CanvasSize.X.Offset, H, 0 )
Value4 = nil
Number2 = 0

for Key3, Value5 in Upvalue5, nil, nil do
    local Entry = Upvalue4.cards[ Value5.card ]

    if Entry and Value5.card.Visible then
        local Number3
        local Card = Value5.card
        Card.Size = UDim2.new( Entry.size.X.Scale, Entry.size.X.Offset, Entry.size.Y.Scale / Max, Entry.size.Y.Offset )
        local Card2 = Value5.card
        Card2.Position = UDim2.new( Entry.pos.X.Scale, Entry.pos.X.Offset, ( Number2 + Entry.pos.Y.Scale ) / Max, Entry.pos.Y.Offset )
        local Scale7 = Entry.pos.Y.Scale + Entry.size.Y.Scale
        Number3 = if Scale7 <= 1 then 1 else Scale7 + ( Upvalue4.gap or 0.071 )
        Number2 = Number2 + Number3
    end
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Flag
Value1 = nil
Flag = false

for Key, Value in Upvalue1, nil, nil do
    local Visible = Upvalue2.Active( Value.pack )

    if Value.card.Visible ~= Visible then
        Value.card.Visible = Visible
    end
    if Visible then
        local Urgent
        local TimeLeft = Upvalue2.TimeLeft( Value.pack )
        Urgent = TimeLeft < 86400 and true or false
        Value.urgent = Urgent

        if Value.countdown then
            local TextColor3
            local Countdown = Value.countdown
            Countdown.Text = "ENDS IN " .. Upvalue2.Format( TimeLeft )
            local UrgentColor = Value.countdown:GetAttribute( "UrgentColor" )
            TextColor3 = Value.urgent and typeof( UrgentColor ) == "Color3" and UrgentColor or Value.cdColor

            if not TextColor3 or Value.countdown.TextColor3 == TextColor3 then
                Flag = true
            else
                Value.countdown.TextColor3 = TextColor3
                Flag = true
            end
        else
            Flag = true
        end
    end
end
if not Flag then
    Upvalue3( )
    return
end

local Value2, Number
Value2 = nil
Number = 0

for Key2, Value3 in Upvalue1, nil, nil do
    if Value3.card.Visible then
        Number = Number + 1
    end
end
if Number ~= Upvalue4 then
    Upvalue4 = Number
    Upvalue5( Number )
end
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

while not Upvalue1 do
    task.wait( 1 )
    Upvalue2( )
end
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Clock = os.clock( ) - Upvalue1
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    if Value.card.Visible then
        local Fx = Value.fx
        local FromScale = UDim2.fromScale( 0, math.sin( Clock * 1.8 ) * 0.022 )

        if Fx.pumpkin then
            local Pumpkin = Fx.pumpkin
            Pumpkin.Position = Fx.pumpkinPos + FromScale
            local Pumpkin2 = Fx.pumpkin
            Pumpkin2.Rotation = math.sin( Clock * 1.1 ) * 5
        end
        if Fx.candle then
            local Candle = Fx.candle
            Candle.Position = Fx.candlePos + FromScale
            local Candle2 = Fx.candle
            Candle2.BackgroundTransparency = math.clamp( Fx.candleT + 0.12 + math.noise( Clock * 7, 0.37 ) * 0.45, 0, 0.75 )
        end
        if Fx.glow then
            local Sin = math.sin( Clock * 2.4 ) * 0.5 + 0.5
            local Sin2 = Sin * 0.1 + 0.94
            local Glow = Fx.glow
            Glow.Size = UDim2.fromScale( Fx.glowSize.X.Scale * Sin2, Fx.glowSize.Y.Scale * Sin2 )
            local Glow2 = Fx.glow
            Glow2.Position = Fx.glowPos + FromScale
            local Glow3 = Fx.glow
            Glow3.ImageTransparency = math.min( Fx.glowT + ( 1 - Sin ) * 0.12, 1 )
        end
        if Fx.shine then
            local Clock2 = Clock % 3.4 / 1.1
            local Shine = Fx.shine
            Shine.Offset = Vector2.new( math.min( Clock2, 1 ) * 2 + -1, 0 )
        end
        if Fx.stroke then
            local Stroke = Fx.stroke
            Stroke.Transparency = math.min( Fx.strokeT + ( math.sin( Clock * 2.2 ) * 0.5 + 0.5 ) * 0.3, 1 )
        end
        if Fx.nameGrad then
            local NameGrad = Fx.nameGrad
            NameGrad.Offset = Vector2.new( 0, math.sin( Clock * 1.3 ) * 0.12 )
        end
        if Fx.showCam then
            local Orbit = Fx.orbit * math.sin( Clock * 2 * 3.141592653589793 / Fx.orbitPeriod )
            local CFrame2 = CFrame.new( Fx.showCenter )
            local CFrame3 = CFrame2 * CFrame.Angles( 0, Orbit, 0 ) * CFrame2:Inverse( ) * Fx.showBase + Vector3.new( 0, Fx.bob * math.sin( Clock * 1.3 ), 0 )
            Fx.showCam.CFrame = CFrame3

            if Fx.flowCam then
                Fx.flowCam.CFrame = CFrame3
            end

            local Last = os.clock( )

            if Fx.tank and Last - Fx.tank.last >= 0.03333333333333333 then
                Fx.tank.last = Last
                Upvalue3( Fx.tank, Clock, CFrame3 )
            end
        end

        local Value2 = Upvalue4( Clock )

        if Fx.pulseRest and Fx.showView then
            local ShowView = Fx.showView
            local PulseRest = Fx.pulseRest
            ShowView.ImageColor3 = PulseRest:Lerp( Color3.new( 1, 1, 1 ), Value2 )
        end
        if Fx.showGlow then
            local Max = math.max( math.sin( Clock * 2.1 ) * 0.5 + 0.5, Value2 )
            local ShowGlow = Fx.showGlow
            ShowGlow.ImageTransparency = math.min( Fx.showGlowT + ( 1 - Max ) * 0.18, 1 )
            local Max2 = Max * 0.08 + 0.95
            local ShowGlow2 = Fx.showGlow
            local Scale = Fx.showGlowSize.X.Scale * Max2
            ShowGlow2.Size = UDim2.new( Scale, 0, Fx.showGlowSize.Y.Scale * Max2, 0 )
        end

        local Value3
        local Embers = Fx.embers
        Value3 = nil

        for Key2, Value4 in Embers, nil, nil do
            local Clock5 = ( Clock * Value4.speed + Value4.phase ) % 1
            local O4 = Value4.o
            O4.Position = UDim2.fromScale( Value4.x + math.sin( Clock * 2 + Value4.phase * 6.28 ) * Value4.sway, 1.05 - Clock5 * 1.1 )
            local BackgroundTransparency = 1 - ( 1 - Value4.base ) * math.sin( 3.141592653589793 * Clock5 )

            if Value4.img then
                Value4.o.ImageTransparency = BackgroundTransparency
            else
                Value4.o.BackgroundTransparency = BackgroundTransparency
            end
        end

        local Value5
        local Caustics = Fx.caustics
        Value5 = nil

        for Key3, Value6 in Caustics, nil, nil do
            local Clock4
            local AbsoluteSize = Value6.box.AbsoluteSize
            local Max3 = math.max( 8, ( math.floor( AbsoluteSize.Y * Value6.ratio + 0.5 ) ) )
            local Clock3 = ( Clock * math.abs( Value6.speed ) + Value6.phase ) * Max3 % Max3
            local Max4 = math.max( AbsoluteSize.X, 1 )
            local O = Value6.o
            O.TileSize = UDim2.fromOffset( Max3, Max3 )
            local O2 = Value6.o
            O2.Size = UDim2.fromScale( Max3 / Max4 + 1, 1 )
            local O3 = Value6.o
            Clock4 = Value6.speed >= 0 and Clock3 - Max3 or -Clock3
            O3.Position = UDim2.fromScale( Clock4 / Max4, 0 )
        end
        if Value.countdown then
            local TextTransparency
            local Countdown = Value.countdown

            if Value.urgent then
                local Sin3 = ( math.sin( Clock * 6 ) * 0.5 + 0.5 ) * 0.35

                if Sin3 then
                    TextTransparency = Sin3
                else
                    TextTransparency = 0
                end
            else
                TextTransparency = 0
            end

            Countdown.TextTransparency = TextTransparency
        end
    end
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Disconnect( )
    Upvalue1 = nil
end

local Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    local NotCaptured2
    local Fx = Value.fx

    if Argument1 then
        local NotCaptured = not Upvalue3

        if NotCaptured then
            NotCaptured2 = Value.card.Visible
        else
            NotCaptured2 = NotCaptured
        end
    else
        NotCaptured2 = Argument1
    end
    if Fx.showModel then
        local Parent = NotCaptured2 and Fx.showView or nil

        if Fx.showModel.Parent ~= Parent then
            Fx.showModel.Parent = Parent
        end
    end
    if Fx.flowModel then
        local Parent2 = NotCaptured2 and Fx.flowView or nil

        if Fx.flowModel.Parent ~= Parent2 then
            Fx.flowModel.Parent = Parent2
        end
    end
end
if not Argument1 or Upvalue3 or #Upvalue2 == 0 then
    return
end
local Clock = os.clock( )
Upvalue1 = Upvalue4.RenderStepped:Connect( function()
    local Value1
    local ClockInner = os.clock( ) - Clock
    Value1 = nil

    for Key, Value in Upvalue2, nil, nil do
        if Value.card.Visible then
            local Fx = Value.fx
            local FromScale = UDim2.fromScale( 0, math.sin( ClockInner * 1.8 ) * 0.022 )

            if Fx.pumpkin then
                local Pumpkin = Fx.pumpkin
                Pumpkin.Position = Fx.pumpkinPos + FromScale
                local Pumpkin2 = Fx.pumpkin
                Pumpkin2.Rotation = math.sin( ClockInner * 1.1 ) * 5
            end
            if Fx.candle then
                local Candle = Fx.candle
                Candle.Position = Fx.candlePos + FromScale
                local Candle2 = Fx.candle
                Candle2.BackgroundTransparency = math.clamp( Fx.candleT + 0.12 + math.noise( ClockInner * 7, 0.37 ) * 0.45, 0, 0.75 )
            end
            if Fx.glow then
                local Sin = math.sin( ClockInner * 2.4 ) * 0.5 + 0.5
                local Sin2 = Sin * 0.1 + 0.94
                local Glow = Fx.glow
                Glow.Size = UDim2.fromScale( Fx.glowSize.X.Scale * Sin2, Fx.glowSize.Y.Scale * Sin2 )
                local Glow2 = Fx.glow
                Glow2.Position = Fx.glowPos + FromScale
                local Glow3 = Fx.glow
                Glow3.ImageTransparency = math.min( Fx.glowT + ( 1 - Sin ) * 0.12, 1 )
            end
            if Fx.shine then
                local Clock2 = ClockInner % 3.4 / 1.1
                local Shine = Fx.shine
                Shine.Offset = Vector2.new( math.min( Clock2, 1 ) * 2 + -1, 0 )
            end
            if Fx.stroke then
                local Stroke = Fx.stroke
                Stroke.Transparency = math.min( Fx.strokeT + ( math.sin( ClockInner * 2.2 ) * 0.5 + 0.5 ) * 0.3, 1 )
            end
            if Fx.nameGrad then
                local NameGrad = Fx.nameGrad
                NameGrad.Offset = Vector2.new( 0, math.sin( ClockInner * 1.3 ) * 0.12 )
            end
            if Fx.showCam then
                local Orbit = Fx.orbit * math.sin( ClockInner * 2 * 3.141592653589793 / Fx.orbitPeriod )
                local CFrame2 = CFrame.new( Fx.showCenter )
                local CFrame3 = CFrame2 * CFrame.Angles( 0, Orbit, 0 ) * CFrame2:Inverse( ) * Fx.showBase + Vector3.new( 0, Fx.bob * math.sin( ClockInner * 1.3 ), 0 )
                Fx.showCam.CFrame = CFrame3

                if Fx.flowCam then
                    Fx.flowCam.CFrame = CFrame3
                end

                local Last = os.clock( )

                if Fx.tank and Last - Fx.tank.last >= 0.03333333333333333 then
                    Fx.tank.last = Last
                    Upvalue5( Fx.tank, ClockInner, CFrame3 )
                end
            end

            local Value2 = Upvalue6( ClockInner )

            if Fx.pulseRest and Fx.showView then
                local ShowView = Fx.showView
                local PulseRest = Fx.pulseRest
                ShowView.ImageColor3 = PulseRest:Lerp( Color3.new( 1, 1, 1 ), Value2 )
            end
            if Fx.showGlow then
                local Max = math.max( math.sin( ClockInner * 2.1 ) * 0.5 + 0.5, Value2 )
                local ShowGlow = Fx.showGlow
                ShowGlow.ImageTransparency = math.min( Fx.showGlowT + ( 1 - Max ) * 0.18, 1 )
                local Max2 = Max * 0.08 + 0.95
                local ShowGlow2 = Fx.showGlow
                local Scale = Fx.showGlowSize.X.Scale * Max2
                ShowGlow2.Size = UDim2.new( Scale, 0, Fx.showGlowSize.Y.Scale * Max2, 0 )
            end

            local Value3
            local Embers = Fx.embers
            Value3 = nil

            for Key2, Value4 in Embers, nil, nil do
                local Clock5 = ( ClockInner * Value4.speed + Value4.phase ) % 1
                local O4 = Value4.o
                O4.Position = UDim2.fromScale( Value4.x + math.sin( ClockInner * 2 + Value4.phase * 6.28 ) * Value4.sway, 1.05 - Clock5 * 1.1 )
                local BackgroundTransparency = 1 - ( 1 - Value4.base ) * math.sin( 3.141592653589793 * Clock5 )

                if Value4.img then
                    Value4.o.ImageTransparency = BackgroundTransparency
                else
                    Value4.o.BackgroundTransparency = BackgroundTransparency
                end
            end

            local Value5
            local Caustics = Fx.caustics
            Value5 = nil

            for Key3, Value6 in Caustics, nil, nil do
                local Clock4
                local AbsoluteSize = Value6.box.AbsoluteSize
                local Max3 = math.max( 8, ( math.floor( AbsoluteSize.Y * Value6.ratio + 0.5 ) ) )
                local Clock3 = ( ClockInner * math.abs( Value6.speed ) + Value6.phase ) * Max3 % Max3
                local Max4 = math.max( AbsoluteSize.X, 1 )
                local O = Value6.o
                O.TileSize = UDim2.fromOffset( Max3, Max3 )
                local O2 = Value6.o
                O2.Size = UDim2.fromScale( Max3 / Max4 + 1, 1 )
                local O3 = Value6.o
                Clock4 = Value6.speed >= 0 and Clock3 - Max3 or -Clock3
                O3.Position = UDim2.fromScale( Clock4 / Max4, 0 )
            end
            if Value.countdown then
                local TextTransparency
                local Countdown = Value.countdown

                if Value.urgent then
                    local Sin3 = ( math.sin( ClockInner * 6 ) * 0.5 + 0.5 ) * 0.35

                    if Sin3 then
                        TextTransparency = Sin3
                    else
                        TextTransparency = 0
                    end
                else
                    TextTransparency = 0
                end

                Countdown.TextTransparency = TextTransparency
            end
        end
    end
end )
return
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Value.buy and Value.card.Visible and not Upvalue2 and Upvalue3:GetAttribute( "PackBought_" .. Value.pack.id ) ~= true then
        if Upvalue3:GetAttribute( "Pack_" .. Value.pack.id ) ~= true then
            return Value.buy
        end
    end
end

return nil
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Upvalue2.Pending( Value.pack.ProductId ) then
        Upvalue2.Done( Value.pack.ProductId )
    end
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Text
Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Upvalue2.Active( Value.pack ) then
        local Id = Value.pack.id
        Text = "Pack_" .. Id .. "_" .. tostring( Value.pack.EndsAt )
        break
    end

    Text = nil
end
if Upvalue3:GetAttribute( "NotifKey" ) ~= Text then
    Upvalue3:SetAttribute( "NotifKey", Text )
end
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1.Text = SayName or ""
end
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Enabled

if Upvalue2.sub == true then
    Enabled = true
elseif Upvalue2.free == true then
    Enabled = true
elseif Upvalue2.pending == true then
    Enabled = true
elseif Upvalue3:GetAttribute( "VIP" ) == true then
    Enabled = true
else
    Enabled = false
end

local Normal = Upvalue1:FindFirstChild( "Normal" )
local Actif = Upvalue1:FindFirstChild( "Actif" )

if Normal then
    Normal.Enabled = not Enabled
end
if Actif then
    Actif.Enabled = Enabled
end
if Upvalue4 then
    local Text

    if Enabled then
        local ActiveText = Upvalue1:GetAttribute( "ActiveText" )

        if ActiveText then
            Text = ActiveText
        else
            Text = "ACTIVE"
        end
    else
        Text = Upvalue5
    end

    Upvalue4.Text = Text
end
if Upvalue6 then
    local Text2

    if Enabled then
        if not Upvalue2.pending or Upvalue2.sub then
            local ActiveSub = Upvalue1:GetAttribute( "ActiveSub" )

            if ActiveSub then
                Text2 = ActiveSub
            else
                Text2 = ""
            end
        else
            Text2 = "Activating, please wait..."
        end
    else
        Text2 = Upvalue7
    end

    Upvalue6.Text = Text2
end

Upvalue1.AutoButtonColor = not Enabled
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return Upvalue2
end

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "status" )

if Success and type( Result ) == "table" then
    local Pending2

    if Result.sub == true then
        Pending2 = nil
    else
        local Pending = Upvalue2.pending

        if Pending then
            Pending2 = Pending
        else
            Pending2 = nil
        end
    end

    Upvalue2 = Result
    Upvalue2.pending = Pending2
end

Upvalue3( )
return Upvalue2
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

if type( TextName ) ~= "string" or TextName == "" then
    return nil
end
if Upvalue1 and Upvalue2 == TextName and os.clock( ) - Upvalue3 < 600 then
    return Upvalue1
end

local Success, Result = pcall( Upvalue4.GetSubscriptionProductInfoAsync, Upvalue4, TextName )

if not Success or type( Result ) ~= "table" then
    local Captured = Upvalue2 == TextName and Upvalue1 or nil
    return Captured
end
local DisplayPrice
local Number = tonumber( Result.PriceInRobux )

if type( Result.DisplayPrice ) ~= "string" or not Result.DisplayPrice:match( "%S" ) or not Result.DisplayPrice then
    DisplayPrice = nil
else
    DisplayPrice = Result.DisplayPrice
end
if DisplayPrice and Number and DisplayPrice:match( "^[%d%s,%.]+$" ) then
    DisplayPrice = DisplayPrice .. " Robux"
end

local DisplayPrice2

if DisplayPrice then
    DisplayPrice2 = DisplayPrice
elseif Number then
    DisplayPrice2 = tostring( Number ) .. " Robux"
else
    DisplayPrice2 = Number
end
if not DisplayPrice2 then
    return nil
end

local Lower2
local SubscriptionPeriod = Result.SubscriptionPeriod

if typeof( SubscriptionPeriod ) == "EnumItem" then
    local Lower = SubscriptionPeriod.Name:lower( )

    if Lower then
        Lower2 = Lower
    else
        Lower2 = "month"
    end
else
    Lower2 = "month"
end

local Format = ( "%s / %s" ):format( DisplayPrice2, Lower2 )
local Clock = os.clock( )
Upvalue1 = Format
Upvalue2 = TextName
Upvalue3 = Clock
return Upvalue1
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured

if Upvalue1 then
    local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "status" )

    if Success and type( Result ) == "table" then
        local Pending2

        if Result.sub == true then
            Pending2 = nil
        else
            local Pending = Upvalue2.pending

            if Pending then
                Pending2 = Pending
            else
                Pending2 = nil
            end
        end

        Upvalue2 = Result
        Upvalue2.pending = Pending2
    end

    Upvalue3( )
    Captured = Upvalue2
else
    Captured = Upvalue2
end

local Text

if Upvalue4 then
    Text = Upvalue5( Captured.id )
else
    Text = Upvalue4
end
if Text and Upvalue6.Visible then
    Upvalue4.Text = Text
end
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured

if Upvalue1 then
    local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "status" )

    if Success and type( Result ) == "table" then
        local Pending2

        if Result.sub == true then
            Pending2 = nil
        else
            local Pending = Upvalue2.pending

            if Pending then
                Pending2 = Pending
            else
                Pending2 = nil
            end
        end

        Upvalue2 = Result
        Upvalue2.pending = Pending2
    end

    Upvalue3( )
    Captured = Upvalue2
else
    Captured = Upvalue2
end
if Captured.sub or Captured.free or Captured.pending or Upvalue4:GetAttribute( "VIP" ) == true then
    return
end
if Captured.enabled == false or type( Captured.id ) ~= "string" then
    if Upvalue5 then
        Upvalue5.Text = "The VIP subscription is not available right now"
    end

    return
end
if Upvalue5 then
    Upvalue5.Text = "Opening the Roblox subscription window..."
end

local PromptSubscriptionPurchase = Upvalue6.PromptSubscriptionPurchase

if not pcall( PromptSubscriptionPurchase, Upvalue6, Upvalue4, Captured.id ) and Upvalue5 then
    Upvalue5.Text = "The VIP subscription is not available right now"
end

return
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while Upvalue1 == Upvalue2 do
    if not ( os.clock( ) - Clock < 45 ) then
        break
    end

    task.wait( 3 )

    if Upvalue1 ~= Upvalue2 then
        return
    end

    local Captured

    if Upvalue3 then
        local Success, Result = pcall( Upvalue3.InvokeServer, Upvalue3, "status" )

        if Success and type( Result ) == "table" then
            local Pending2

            if Result.sub == true then
                Pending2 = nil
            else
                local Pending = Upvalue4.pending

                if Pending then
                    Pending2 = Pending
                else
                    Pending2 = nil
                end
            end

            Upvalue4 = Result
            Upvalue4.pending = Pending2
        end

        Upvalue5( )
        Captured = Upvalue4
    else
        Captured = Upvalue4
    end
    if Captured.sub then
        Upvalue4.pending = nil
        Upvalue5( )
        return
    end
end
if Upvalue1 == Upvalue2 then
    Upvalue4.pending = nil
    Upvalue5( )

    if Upvalue6 then
        Upvalue6.Text = "Your VIP is not active yet, try again in a minute"
    end
end
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 ~= Upvalue1 then
    return
end
if Upvalue2 then
    Upvalue2.Text = ""
end
if Argument3 then
    Upvalue3 = Upvalue3 + 1
    Upvalue4.pending = true
    Upvalue5( )
    task.spawn( function()
        local Clock = os.clock( )

        while Upvalue3 == Upvalue3 do
            if not ( os.clock( ) - Clock < 45 ) then
                break
            end

            task.wait( 3 )

            if Upvalue3 ~= Upvalue3 then
                return
            end

            local Captured

            if Upvalue6 then
                local Success, Result = pcall( Upvalue6.InvokeServer, Upvalue6, "status" )

                if Success and type( Result ) == "table" then
                    local Pending2

                    if Result.sub == true then
                        Pending2 = nil
                    else
                        local Pending = Upvalue4.pending

                        if Pending then
                            Pending2 = Pending
                        else
                            Pending2 = nil
                        end
                    end

                    Upvalue4 = Result
                    Upvalue4.pending = Pending2
                end

                Upvalue5( )
                Captured = Upvalue4
            else
                Captured = Upvalue4
            end
            if Captured.sub then
                Upvalue4.pending = nil
                Upvalue5( )
                return
            end
        end
        if Upvalue3 == Upvalue3 then
            Upvalue4.pending = nil
            Upvalue5( )

            if Upvalue2 then
                Upvalue2.Text = "Your VIP is not active yet, try again in a minute"
            end
        end
    end )
    return
end
return
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1.WardrobeOpen == true then
    Flag = true
elseif Upvalue2:GetAttribute( "InWardrobe" ) == true then
    Flag = true
elseif Upvalue1.BetaReveal == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

local Icon
local GetIcon = Upvalue1.getIcon

if GetIcon then
    Icon = Upvalue1.getIcon( "Settings" )
else
    Icon = GetIcon
end

local Flag = if Icon == nil then false else Icon.isSelected
return Flag
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = Upvalue1( )

if Value1 then
    return Value1
end
if Upvalue2 and not Upvalue3:GetAttribute( "StarterPackOwned" ) then
    return Upvalue2
end

return Upvalue4 or Upvalue5
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( false )
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

if Visible == Upvalue1 then
    return
end
if Visible then
    local Flag

    if Upvalue2.WardrobeOpen == true then
        Flag = true
    elseif Upvalue3:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    elseif Upvalue2.BetaReveal == true then
        Flag = true
    else
        Flag = false
    end
    if Flag then
        Upvalue4.Error( "You can't open the shop in the wardrobe" )
        return
    end
end

Upvalue1 = Visible
Upvalue5:Close( )
Upvalue6.Visible = Visible

if Visible and not Upvalue7.Visible then
    Upvalue7.Visible = true
end
if Upvalue8 then
    Upvalue8:Cancel( )
    Upvalue8 = nil
end
if Upvalue9 then
    if not Visible or Argument2 then
        Upvalue9.Scale = 1
    else
        Upvalue9.Scale = 0.92
        Upvalue8 = Upvalue10:Create( Upvalue9, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
        Upvalue8:Play( )
    end
end
if Visible then
    Upvalue2.ActiveMenu = "Shop"
end
if Visible then
    local NotifSeen
    local ScreenGui = Upvalue11:FindFirstAncestorWhichIsA( "ScreenGui" )

    if ScreenGui then
        NotifSeen = ScreenGui:FindFirstChild( "NotifSeen" )
    else
        NotifSeen = ScreenGui
    end
    if NotifSeen then
        NotifSeen:Fire( Upvalue11 )
    end
end

Upvalue2.CursorFree = Visible

if not Visible then
    Upvalue16( false )
    Upvalue17.Close( "Shop" )
    return
end

local Icon
Upvalue12( )
task.spawn( Upvalue13 )
local GetIcon = Upvalue14.getIcon

if GetIcon then
    Icon = Upvalue14.getIcon( "Settings" )
else
    Icon = GetIcon
end

local Flag2 = if Icon == nil then false else Icon.isSelected

if Flag2 then
    Upvalue14.getIcon( "Settings" ):deselect( )
end

Upvalue15.CanvasPosition = Vector2.zero
Upvalue16( true )
Upvalue17.Open( "Shop", {
    root = Upvalue7,
    first = function()
        local Value1 = Upvalue18( )

        if Value1 then
            return Value1
        end
        if Upvalue19 and not Upvalue3:GetAttribute( "StarterPackOwned" ) then
            return Upvalue19
        end

        return Upvalue20 or Upvalue21
    end,
    onBack = function()
        Upvalue22( false )
    end
} )
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.EffectsOpen or not Upvalue1.CloseEffects then
    Upvalue2( not Upvalue3 )
    return
end

Upvalue1.CloseEffects( )
Upvalue2( true, true )

if not Upvalue3 and Upvalue1.OpenEffects then
    Upvalue1.OpenEffects( true )
end
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

if not Argument2 and Upvalue1.Is( "Shop", Argument1 ) then
    if not Upvalue2.EffectsOpen or not Upvalue2.CloseEffects then
        Upvalue3( not Upvalue4 )
    else
        Upvalue2.CloseEffects( )
        Upvalue3( true, true )

        if not Upvalue4 and Upvalue2.OpenEffects then
            Upvalue2.OpenEffects( true )
            return
        end
    end
end
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( true, Argument1 )
return Upvalue2
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == false then
    return
end

Upvalue1 = false
Upvalue2:Close( )
Upvalue3.Visible = false

if Upvalue4 then
    Upvalue4:Cancel( )
    Upvalue4 = nil
end
if Upvalue5 then
    Upvalue5.Scale = 1
end

Upvalue6.CursorFree = false
Upvalue7( false )
Upvalue8.Close( "Shop" )
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2.OpenEffects then
    return
end
if Upvalue1 ~= false then
    Upvalue1 = false
    Upvalue3:Close( )
    Upvalue4.Visible = false

    if Upvalue5 then
        Upvalue5:Cancel( )
        Upvalue5 = nil
    end
    if Upvalue6 then
        Upvalue6.Scale = 1
    end

    Upvalue2.CursorFree = false
    Upvalue7( false )
    Upvalue8.Close( "Shop" )
end
if not Upvalue2.OpenEffects( true ) then
    Upvalue9( true, true )
end
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == false then
    return
end

Upvalue1 = false
Upvalue2:Close( )
Upvalue3.Visible = false

if Upvalue4 then
    Upvalue4:Cancel( )
    Upvalue4 = nil
end
if Upvalue5 then
    Upvalue5.Scale = 1
end

Upvalue6.CursorFree = false
Upvalue7( false )
Upvalue8.Close( "Shop" )
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

local Vector22

if Upvalue1 then
    local ViewportSize = Upvalue1.ViewportSize

    if ViewportSize then
        Vector22 = ViewportSize
    else
        Vector22 = Vector2.new( 1920, 1080 )
    end
else
    Vector22 = Vector2.new( 1920, 1080 )
end

local Size = Vector22.Y < 600 and Upvalue3 or Upvalue4
Upvalue2.Size = Size
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Disconnect( )
end

Upvalue2 = workspace.CurrentCamera

if Upvalue2 then
    Upvalue1 = Upvalue2:GetPropertyChangedSignal( "ViewportSize" ):Connect( Upvalue3 )
end

local Vector22

if Upvalue2 then
    local ViewportSize = Upvalue2.ViewportSize

    if ViewportSize then
        Vector22 = ViewportSize
    else
        Vector22 = Vector2.new( 1920, 1080 )
    end
else
    Vector22 = Vector2.new( 1920, 1080 )
end

local Size = Vector22.Y < 600 and Upvalue5 or Upvalue6
Upvalue4.Size = Size
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Flag

if Upvalue2.WardrobeOpen == true then
    Flag = true
elseif Upvalue3:GetAttribute( "InWardrobe" ) == true then
    Flag = true
elseif Upvalue2.BetaReveal == true then
    Flag = true
else
    Flag = false
end
if not Flag and Upvalue2.ActiveMenu == "Shop" then
    local Icon
    local GetIcon = Upvalue4.getIcon

    if GetIcon then
        Icon = Upvalue4.getIcon( "Settings" )
    else
        Icon = GetIcon
    end

    local Flag2 = if Icon == nil then false else Icon.isSelected

    if not Flag2 then
        if not Upvalue2.CursorFree then
            Upvalue2.CursorFree = true
        end

        return
    end
end
if Upvalue1 == false then
    return
end

Upvalue1 = false
Upvalue5:Close( )
Upvalue6.Visible = false

if Upvalue7 then
    Upvalue7:Cancel( )
    Upvalue7 = nil
end
if Upvalue8 then
    Upvalue8.Scale = 1
end

Upvalue2.CursorFree = false
Upvalue9( false )
Upvalue10.Close( "Shop" )
]]
