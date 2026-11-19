-- StarterPlayer.StarterPlayerScripts.CarGarageClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #51

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue1.Error then
    warn( "[Garage] " .. Text )
    return
end
Upvalue1.Error( Text )
return
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local FoundChild2
local FoundChild = Upvalue1:FindFirstChild( Name )
FoundChild2 = FoundChild and FoundChild:IsA( "Sound" ) and FoundChild or nil
return FoundChild2
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local BuySound2
local BuySound = Upvalue1:FindFirstChild( "BuySound" )
BuySound2 = BuySound and BuySound:IsA( "Sound" ) and BuySound or nil

if BuySound2 then
    local Clone = BuySound2:Clone( )
    Clone.Parent = BuySound2.Parent
    Clone.Ended:Once( function()
        Clone:Destroy( )
    end )
    Clone:Play( )
    return
end
return
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local HornPreview2
local HornPreview = Upvalue1:FindFirstChild( "HornPreview" )
HornPreview2 = HornPreview and HornPreview:IsA( "Sound" ) and HornPreview or nil

if not HornPreview2 or not Argument1 or not Argument1.Sound then
    return
end
HornPreview2:Stop( )
HornPreview2.SoundId = "rbxassetid://" .. Argument1.Sound
HornPreview2.TimePosition = 0
HornPreview2:Play( )
return
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1.TILE_GRAD[ GradName ]

if Entry then
    Entry2 = Entry
elseif GradName == "mythical" then
    local Super = Upvalue1.TILE_GRAD.super

    if Super then
        Entry2 = Super
    else
        Entry2 = Upvalue1.TILE_GRAD.common
    end
else
    Entry2 = Upvalue1.TILE_GRAD.common
end

return Entry2
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Rarity = Parent:FindFirstChild( "Rarity" )

if Rarity then
    local Color

    if Model and Upvalue1.ITEMS[ Model ] then
        local Rarity2 = ( Model and Upvalue1.ITEMS[ Model ] ).Rarity
        local Entry = Upvalue2.TILE_GRAD[ Rarity2 ]

        if Entry then
            Color = Entry
        elseif Rarity2 == "mythical" then
            local Super = Upvalue2.TILE_GRAD.super

            if Super then
                Color = Super
            else
                Color = Upvalue2.TILE_GRAD.common
            end
        else
            Color = Upvalue2.TILE_GRAD.common
        end
        if not Color then
            Color = ColorSequence.new( Color3.fromRGB( 70, 74, 84 ), Color3.fromRGB( 30, 32, 38 ) )
        end
    else
        Color = ColorSequence.new( Color3.fromRGB( 70, 74, 84 ), Color3.fromRGB( 30, 32, 38 ) )
    end

    Rarity.Color = Color
end

local Parent2 = Parent:FindFirstChild( "Swatch" )
local Pattern = Parent:FindFirstChild( "Pattern" )
local Icon = Parent:FindFirstChild( "Icon" )

if Parent2 then
    Parent2.Visible = false
end
if Pattern then
    Pattern.Visible = false
end
if Icon then
    Icon.Visible = false
end

local RimPreview = Parent:FindFirstChild( "RimPreview" )

if RimPreview then
    RimPreview:Destroy( )
end

local FoundChild

if Model and Upvalue1.ITEMS[ Model ] then
    local Model2 = ( Model and Upvalue1.ITEMS[ Model ] ).Model

    if Model2 then
        if ( Model and Upvalue1.ITEMS[ Model ] ).Category == "Rims" then
            local CarRims = Upvalue3:FindFirstChild( "CarRims" )

            if CarRims then
                FoundChild = Upvalue3.CarRims:FindFirstChild( ( Model and Upvalue1.ITEMS[ Model ] ).Model )
            else
                FoundChild = CarRims
            end
        else
            FoundChild = false
        end
    else
        FoundChild = Model2
    end
else
    FoundChild = Model and Upvalue1.ITEMS[ Model ]
end

local FoundChild2

if Model and Upvalue1.ITEMS[ Model ] then
    local Model3 = ( Model and Upvalue1.ITEMS[ Model ] ).Model

    if Model3 then
        if ( Model and Upvalue1.ITEMS[ Model ] ).Category == "Spoiler" then
            local CarSpoilers = Upvalue3:FindFirstChild( "CarSpoilers" )

            if CarSpoilers then
                FoundChild2 = Upvalue3.CarSpoilers:FindFirstChild( ( Model and Upvalue1.ITEMS[ Model ] ).Model )
            else
                FoundChild2 = CarSpoilers
            end
        else
            FoundChild2 = false
        end
    else
        FoundChild2 = Model3
    end
else
    FoundChild2 = Model and Upvalue1.ITEMS[ Model ]
end
if FoundChild2 then
    local Select
    local Parent3 = Instance.new( "ViewportFrame" )
    Parent3.Name = "RimPreview"
    Parent3.BackgroundTransparency = 1
    Parent3.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Parent3.Position = UDim2.new( 0.5, 0, 0.4, 0 )
    Parent3.Size = UDim2.new( 0.96, 0, 0.72, 0 )
    local Ambient = Color3.fromRGB( 200, 200, 210 )
    local LightColor = Color3.new( 1, 1, 1 )
    Parent3.Ambient = Ambient
    Parent3.LightColor = LightColor
    Parent3.LightDirection = Vector3.new( -0.4000000059604645, -1, 0.6000000238418579 )
    FoundChild2:Clone( ).Parent = Parent3
    local Size = FoundChild2:GetAttribute( "Size" )

    if Size then
        Select = Size
    else
        Select = select( 2, FoundChild2:GetBoundingBox( ) )
    end

    local Vector32 = Vector3.new( 0, Select.Y * 0.45, 0 )
    local CurrentCamera = Instance.new( "Camera" )
    CurrentCamera.FieldOfView = 30
    local X = Select.X / 2 / 0.2679491924311227 * 0.82 + Select.Z / 2
    CurrentCamera.CFrame = CFrame.lookAt( Vector32 + Vector3.new( 0.4000000059604645, 0.6200000047683716, -1 ).Unit * X, Vector32 )
    CurrentCamera.Parent = Parent3
    Parent3.CurrentCamera = CurrentCamera
    local UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
    UIAspectRatioConstraint.AspectRatio = 1.3
    UIAspectRatioConstraint.Parent = Parent3
    Parent3.Parent = Parent
elseif FoundChild then
    local Parent4 = Instance.new( "ViewportFrame" )
    Parent4.Name = "RimPreview"
    Parent4.BackgroundTransparency = 1
    Parent4.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Parent4.Position = UDim2.new( 0.5, 0, 0.42, 0 )
    Parent4.Size = UDim2.new( 0.62, 0, 0.62, 0 )
    local Ambient2 = Color3.fromRGB( 170, 170, 180 )
    local LightColor2 = Color3.new( 1, 1, 1 )
    Parent4.Ambient = Ambient2
    Parent4.LightColor = LightColor2
    Parent4.LightDirection = Vector3.new( -1, -0.6000000238418579, -0.4000000059604645 )
    FoundChild:Clone( ).Parent = Parent4
    local CurrentCamera2 = Instance.new( "Camera" )
    CurrentCamera2.FieldOfView = 30
    CurrentCamera2.CFrame = CFrame.lookAt( Vector3.new( 4.099999904632568, 0.5, 1.2000000476837158 ), Vector3.new( 0, 0, 0 ) )
    CurrentCamera2.Parent = Parent4
    Parent4.CurrentCamera = CurrentCamera2
    Instance.new( "UIAspectRatioConstraint" ).Parent = Parent4
    Parent4.Parent = Parent
elseif not ( Model and Upvalue1.ITEMS[ Model ] ) or not ( Model and Upvalue1.ITEMS[ Model ] ).Texture or not Pattern then
    if not ( Model and Upvalue1.ITEMS[ Model ] ) or not ( Model and Upvalue1.ITEMS[ Model ] ).Color or not Parent2 then
        if Icon then
            local ImageTransparency
            Icon.Image = Upvalue1.CATEGORY[ TileName ].Icon
            ImageTransparency = not ( Model and Upvalue1.ITEMS[ Model ] ) and 0.45 or 0
            Icon.ImageTransparency = ImageTransparency
            Icon.Visible = true
        end
    else
        Parent2.BackgroundColor3 = ( Model and Upvalue1.ITEMS[ Model ] ).Color
        local Rainbow = Parent2:FindFirstChild( "Rainbow" )

        if not ( Model and Upvalue1.ITEMS[ Model ] ).Rainbow or Rainbow then
            if Rainbow and not ( Model and Upvalue1.ITEMS[ Model ] ).Rainbow then
                Rainbow:Destroy( )
            end
        else
            local UIGradient = Instance.new( "UIGradient" )
            UIGradient.Name = "Rainbow"
            local Table = { }
            local I = 0

            for I = 0, 6 do
                table.insert( Table, ColorSequenceKeypoint.new( I / 6, Color3.fromHSV( I / 6, 0.85, 1 ) ) )
            end

            UIGradient.Color = ColorSequence.new( Table )
            UIGradient.Parent = Parent2
        end

        Parent2.Visible = true
    end
else
    Pattern.Image = ( Model and Upvalue1.ITEMS[ Model ] ).Texture
    Pattern.Visible = true
end

local ItemName = Parent:FindFirstChild( "ItemName" )

if ItemName then
    local Text2 = Model and Upvalue1.ITEMS[ Model ] and ( Model and Upvalue1.ITEMS[ Model ] ).Name or "Stock"
    ItemName.Text = Text2
end

local Count = Parent:FindFirstChild( "Count" )

if Count then
    local Text3 = ( Text or 0 ) >= 2 and "X" .. Text or ""
    Count.Text = Text3
end

local Check = Parent:FindFirstChild( "Check" )

if Check then
    local Visible = Flag == true and true or false
    Check.Visible = Visible
end

local Price = Parent:FindFirstChild( "Price" )
local PriceFor = Upvalue1.PriceFor
local Entry2
local PriceFor2 = PriceFor( Model and Upvalue1.ITEMS[ Model ], Upvalue4 and Upvalue4.model.Name )

if Model and Upvalue1.ITEMS[ Model ] then
    if PriceFor2 then
        if ( Text or 0 ) < 1 then
            Entry2 = true
        else
            Entry2 = false
        end
    else
        Entry2 = PriceFor2
    end
else
    Entry2 = Model and Upvalue1.ITEMS[ Model ]
end
if Price then
    local Visible2 = if Entry2 then true else false
    Price.Visible = Visible2

    if Entry2 then
        Price.Text = Upvalue5( PriceFor2 )
        Price.TextColor3 = Color3.fromRGB( 130, 220, 114 )
    end
end
if Entry2 and Icon and Icon.Visible then
    Icon.ImageTransparency = 0.45
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1 and Upvalue2[ Upvalue1.model.Name ] and ( Upvalue1 and Upvalue2[ Upvalue1.model.Name ] )[ Key ] or nil
return Entry
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.Unlocked( Upvalue2, Argument1 )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1[ Upvalue2.OwnKey( Argument1, Upvalue3 ) ] or 0
Entry2 = if not ( Entry < 1 ) or not Upvalue2.Owns( Upvalue1, Argument1, Upvalue3, Upvalue4 ) then Entry else 1
return Entry2
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

if Key == false then
    local Flag = Key2 ~= false and true or false
    return Flag
end
if Key2 == false then
    return false
end

local Flag2 = Upvalue1.ITEMS[ Key ].Category ~= Upvalue2 and true or false
local Flag3 = Upvalue1.ITEMS[ Key2 ].Category ~= Upvalue2 and true or false

if Flag2 ~= Flag3 then
    return Flag2
end
if Flag2 and Flag3 then
    local Flag4 = Upvalue1.ITEMS[ Key ].Order < Upvalue1.ITEMS[ Key2 ].Order and true or false
    return Flag4
end
local Order = Upvalue1.Rarity( Upvalue1.ITEMS[ Key ].Rarity ).Order
local Order2 = Upvalue1.Rarity( Upvalue1.ITEMS[ Key2 ].Rarity ).Order

if Order == Order2 then
    local Flag6 = Upvalue1.ITEMS[ Key ].Order < Upvalue1.ITEMS[ Key2 ].Order and true or false
    return Flag6
end
local Flag5 = Order2 < Order and true or false
return Flag5
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 <= os.clock( ) and Upvalue2 and Upvalue2.Parent then
    local PriceFor = Upvalue4.PriceFor
    Upvalue2.Text = Upvalue3( PriceFor( Upvalue5, Upvalue6 and Upvalue6.model.Name ) )
    Upvalue2.TextColor3 = Color3.fromRGB( 130, 220, 114 )
end
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Upvalue2 then
    return
end

local Captured = if Upvalue3 then Upvalue4.ITEMS[ Upvalue3 ] else Upvalue3

if Captured and Captured.Category == "Horn" then
    local HornPreview2
    local HornPreview = Upvalue5:FindFirstChild( "HornPreview" )
    HornPreview2 = HornPreview and HornPreview:IsA( "Sound" ) and HornPreview or nil

    if HornPreview2 and Captured then
        if Captured.Sound then
            HornPreview2:Stop( )
            HornPreview2.SoundId = "rbxassetid://" .. Captured.Sound
            HornPreview2.TimePosition = 0
            HornPreview2:Play( )
        end
    end
end
if Captured and Captured.Price then
    local Entry2
    local Entry = Upvalue6[ Upvalue4.OwnKey( Upvalue3, Upvalue7 ) ] or 0
    Entry2 = if not ( Entry < 1 ) or not Upvalue4.Owns( Upvalue6, Upvalue3, Upvalue7, Upvalue8 ) then Entry else 1

    if Entry2 < 1 then
        local Price = Upvalue9:FindFirstChild( "Price" )

        if os.clock( ) - Upvalue10 < 0.35 then
            return
        end
        if Upvalue11 < os.clock( ) then
            Upvalue10 = os.clock( )
            Upvalue11 = os.clock( ) + 3

            if Price then
                Price.Text = "CLICK TO BUY"
                Price.TextColor3 = Color3.fromRGB( 255, 210, 90 )
            end

            task.delay( 3.05, function()
                if Upvalue11 <= os.clock( ) and Price and Price.Parent then
                    local PriceFor = Upvalue4.PriceFor
                    Price.Text = Upvalue12( PriceFor( Captured, Upvalue2 and Upvalue2.model.Name ) )
                    Price.TextColor3 = Color3.fromRGB( 130, 220, 114 )
                end
            end )
            return
        end
        Upvalue11 = 0
        Upvalue1 = true
        local Success, Result = pcall( Upvalue13.InvokeServer, Upvalue13, "Buy", Upvalue3 )
        Upvalue1 = false

        if not Success or type( Result ) ~= "table" or not Result.ok then
            local Success2

            if Success then
                if type( Result ) == "table" then
                    Success2 = Upvalue17[ Result.err ]
                else
                    Success2 = false
                end
            else
                Success2 = Success
            end
            if Success2 ~= "" then
                local Success3 = Success2 or "Something went wrong, try again"

                if not Upvalue18 or not Upvalue18.Error then
                    warn( "[Garage] " .. Success3 )
                else
                    Upvalue18.Error( Success3 )
                end
            end

            Upvalue16( )
            return
        end
        local Items2
        Upvalue14( )
        local Items = Result.Items
        Items2 = if Items then Items else Upvalue6
        local Setup2
        local Setup = Result.Setup
        Setup2 = if Setup then Setup else Upvalue15
        Upvalue6 = Items2
        Upvalue15 = Setup2
        Upvalue16( )
        return
    end
end
if os.clock( ) - Upvalue19 < 0.35 then
    return
end

Upvalue19 = os.clock( )
Upvalue1 = true
local Captured2 = Upvalue3 or nil

if Upvalue20 ~= Upvalue21 then
    local Entry3 = Upvalue2 and Upvalue15[ Upvalue2.model.Name ] and ( Upvalue2 and Upvalue15[ Upvalue2.model.Name ] )[ Upvalue20 ] or nil

    if Entry3 == Upvalue3 then
        Captured2 = nil
    end
end

local InvokeServer = Upvalue13.InvokeServer
local Success4, Result2 = pcall( InvokeServer, Upvalue13, "Equip", Upvalue2.model, Upvalue20, Captured2 )
Upvalue1 = false

if not Success4 or type( Result2 ) ~= "table" or not Result2.ok then
    local Success5

    if Success4 then
        if type( Result2 ) == "table" then
            Success5 = Upvalue17[ Result2.err ]
        else
            Success5 = false
        end
    else
        Success5 = Success4
    end
    if Success5 ~= "" then
        local Success6 = Success5 or "Something went wrong, try again"

        if Upvalue18 and Upvalue18.Error then
            Upvalue18.Error( Success6 )
            return
        end

        warn( "[Garage] " .. Success6 )
    end

    return
end
local Setup4
local Setup3 = Result2.Setup
Setup4 = if Setup3 then Setup3 else Upvalue15
Upvalue15 = Setup4
Upvalue16( )
return
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetChildren( ) do
    if Value:GetAttribute( "Live" ) then
        Value:Destroy( )
    end
end

local Captured
Upvalue4.Text = string.upper( Upvalue2.CATEGORY[ Upvalue3 ].Name )
local Table = { false }
Captured = if Upvalue5 then Upvalue5.model.Name else Upvalue5
local Entry14

local function HasSkin( Argument1 )
    return Upvalue6.Unlocked( Upvalue7, Argument1 )
end

local function Owned( Argument1 )
    local Entry2
    local Entry = Upvalue8[ Upvalue2.OwnKey( Argument1, Captured ) ] or 0
    Entry2 = if not ( Entry < 1 ) or not Upvalue2.Owns( Upvalue8, Argument1, Captured, HasSkin ) then Entry else 1
    return Entry2
end

local Entry = Upvalue2.BY_CATEGORY[ Upvalue3 ]
Entry14 = if Entry then Entry else { }
local Value1 = nil

for Key2, Value2 in Entry14, nil, nil do
    local Entry11 = Upvalue2.ITEMS[ Value2 ]

    if Upvalue2.Allowed( Entry11, Captured ) then
        local Entry13
        local Entry12 = Upvalue8[ Upvalue2.OwnKey( Value2, Captured ) ] or 0
        Entry13 = if not ( Entry12 < 1 ) or not Upvalue2.Owns( Upvalue8, Value2, Captured, HasSkin ) then Entry12 else 1

        if Entry13 > 0 or Entry11.Price then
            table.insert( Table, Value2 )
        end
    end
end

local Value3
local CATEGORIES = Upvalue2.CATEGORIES
Value3 = nil

for Key3, Value4 in CATEGORIES, nil, nil do
    if Value4.ShowIn == Upvalue3 then
        local Entry10
        local Entry6 = Upvalue2.BY_CATEGORY[ Value4.Key ]
        Entry10 = if Entry6 then Entry6 else { }
        local Value11 = nil

        for Key6, Value12 in Entry10, nil, nil do
            local Entry7 = Upvalue2.ITEMS[ Value12 ]

            if Upvalue5 and Upvalue2.Allowed( Entry7, Captured ) then
                local Entry9
                local Entry8 = Upvalue8[ Upvalue2.OwnKey( Value12, Captured ) ] or 0
                Entry9 = if not ( Entry8 < 1 ) or not Upvalue2.Owns( Upvalue8, Value12, Captured, HasSkin ) then Entry8 else 1

                if Entry9 > 0 or Entry7.Price then
                    table.insert( Table, Value12 )
                end
            end
        end
    end
end

table.sort( Table, function( Key, Key2 )
    if Key == false then
        local Flag = Key2 ~= false and true or false
        return Flag
    end
    if Key2 == false then
        return false
    end

    local Flag2 = Upvalue2.ITEMS[ Key ].Category ~= Upvalue3 and true or false
    local Flag3 = Upvalue2.ITEMS[ Key2 ].Category ~= Upvalue3 and true or false

    if Flag2 ~= Flag3 then
        return Flag2
    end
    if Flag2 and Flag3 then
        local Flag4 = Upvalue2.ITEMS[ Key ].Order < Upvalue2.ITEMS[ Key2 ].Order and true or false
        return Flag4
    end
    local Order = Upvalue2.Rarity( Upvalue2.ITEMS[ Key ].Rarity ).Order
    local Order2 = Upvalue2.Rarity( Upvalue2.ITEMS[ Key2 ].Rarity ).Order

    if Order == Order2 then
        local Flag6 = Upvalue2.ITEMS[ Key ].Order < Upvalue2.ITEMS[ Key2 ].Order and true or false
        return Flag6
    end
    local Flag5 = Order2 < Order and true or false
    return Flag5
end )
local Entry5 = Upvalue5 and Upvalue9[ Upvalue5.model.Name ] and ( Upvalue5 and Upvalue9[ Upvalue5.model.Name ] )[ Upvalue3 ] or nil
local Value5 = nil

for Key4, Value6 in Table, nil, nil do
    local Name
    local Clone = Upvalue10:Clone( )
    Name = Value6 and "Item_" .. Value6 or "Item_Stock"
    local Category2
    Clone.Name = Name
    Clone:SetAttribute( "Live", true )
    Clone.LayoutOrder = Key4
    Clone.Visible = true

    if Value6 then
        local Category = Upvalue2.ITEMS[ Value6 ].Category

        if Category then
            Category2 = Category
        else
            Category2 = Upvalue3
        end
    else
        Category2 = Upvalue3
    end

    local Entry3
    local Value9 = Value6 or nil

    if Value6 then
        local Entry2 = Upvalue8[ Upvalue2.OwnKey( Value6, Captured ) ] or 0

        if not ( Entry2 < 1 ) or not Upvalue2.Owns( Upvalue8, Value6, Captured, HasSkin ) then
            Entry3 = Entry2
        else
            Entry3 = 1
        end
        if not Entry3 then
            Entry3 = 0
        end
    else
        Entry3 = 0
    end

    local Entry4
    local Value10 = Value6 or nil

    if Category2 ~= Upvalue3 or not Entry5 then
        if not ( Upvalue5 and Upvalue9[ Upvalue5.model.Name ] ) or not ( Upvalue5 and Upvalue9[ Upvalue5.model.Name ] )[ Category2 ] then
            Entry4 = nil
        else
            Entry4 = ( Upvalue5 and Upvalue9[ Upvalue5.model.Name ] )[ Category2 ]
        end
    else
        Entry4 = Entry5
    end

    local Flag = Value10 == Entry4 and true or false
    Upvalue11( Clone, Upvalue3, Value9, Entry3, Flag )
    local Number = 0
    local Number2 = 0
    Clone.Activated:Connect( function()
        if Upvalue12 or not Upvalue5 then
            return
        end

        local CapturedInner = if Value6 then Upvalue2.ITEMS[ Value6 ] else Value6

        if CapturedInner and CapturedInner.Category == "Horn" then
            local HornPreview2
            local HornPreview = Upvalue13:FindFirstChild( "HornPreview" )
            HornPreview2 = HornPreview and HornPreview:IsA( "Sound" ) and HornPreview or nil

            if HornPreview2 and CapturedInner then
                if CapturedInner.Sound then
                    HornPreview2:Stop( )
                    HornPreview2.SoundId = "rbxassetid://" .. CapturedInner.Sound
                    HornPreview2.TimePosition = 0
                    HornPreview2:Play( )
                end
            end
        end
        if CapturedInner and CapturedInner.Price then
            local Entry2
            local Entry = Upvalue8[ Upvalue2.OwnKey( Value6, Captured ) ] or 0
            Entry2 = if not ( Entry < 1 ) or not Upvalue2.Owns( Upvalue8, Value6, Captured, HasSkin ) then Entry else 1

            if Entry2 < 1 then
                local Price = Clone:FindFirstChild( "Price" )

                if os.clock( ) - Number2 < 0.35 then
                    return
                end
                if Number < os.clock( ) then
                    Number2 = os.clock( )
                    Number = os.clock( ) + 3

                    if Price then
                        Price.Text = "CLICK TO BUY"
                        Price.TextColor3 = Color3.fromRGB( 255, 210, 90 )
                    end

                    task.delay( 3.05, function()
                        if Number <= os.clock( ) and Price and Price.Parent then
                            local PriceFor = Upvalue2.PriceFor
                            Price.Text = Upvalue14( PriceFor( CapturedInner, Upvalue5 and Upvalue5.model.Name ) )
                            Price.TextColor3 = Color3.fromRGB( 130, 220, 114 )
                        end
                    end )
                    return
                end
                Number = 0
                Upvalue12 = true
                local Success, Result = pcall( Upvalue15.InvokeServer, Upvalue15, "Buy", Value6 )
                Upvalue12 = false

                if not Success or type( Result ) ~= "table" or not Result.ok then
                    local Success2

                    if Success then
                        if type( Result ) == "table" then
                            Success2 = Upvalue18[ Result.err ]
                        else
                            Success2 = false
                        end
                    else
                        Success2 = Success
                    end
                    if Success2 ~= "" then
                        local Success3 = Success2 or "Something went wrong, try again"

                        if not Upvalue19 or not Upvalue19.Error then
                            warn( "[Garage] " .. Success3 )
                        else
                            Upvalue19.Error( Success3 )
                        end
                    end

                    Upvalue17( )
                    return
                end
                local Items2
                Upvalue16( )
                local Items = Result.Items
                Items2 = if Items then Items else Upvalue8
                local Setup2
                local Setup = Result.Setup
                Setup2 = if Setup then Setup else Upvalue9
                Upvalue8 = Items2
                Upvalue9 = Setup2
                Upvalue17( )
                return
            end
        end
        if os.clock( ) - Upvalue20 < 0.35 then
            return
        end

        Upvalue20 = os.clock( )
        Upvalue12 = true
        local Captured2 = Value6 or nil

        if Category2 ~= Upvalue3 then
            local Entry3 = Upvalue5 and Upvalue9[ Upvalue5.model.Name ] and ( Upvalue5 and Upvalue9[ Upvalue5.model.Name ] )[ Category2 ] or nil

            if Entry3 == Value6 then
                Captured2 = nil
            end
        end

        local InvokeServer = Upvalue15.InvokeServer
        local Success4, Result2 = pcall( InvokeServer, Upvalue15, "Equip", Upvalue5.model, Category2, Captured2 )
        Upvalue12 = false

        if not Success4 or type( Result2 ) ~= "table" or not Result2.ok then
            local Success5

            if Success4 then
                if type( Result2 ) == "table" then
                    Success5 = Upvalue18[ Result2.err ]
                else
                    Success5 = false
                end
            else
                Success5 = Success4
            end
            if Success5 ~= "" then
                local Success6 = Success5 or "Something went wrong, try again"

                if Upvalue19 and Upvalue19.Error then
                    Upvalue19.Error( Success6 )
                    return
                end

                warn( "[Garage] " .. Success6 )
            end

            return
        end
        local Setup4
        local Setup3 = Result2.Setup
        Setup4 = if Setup3 then Setup3 else Upvalue9
        Upvalue9 = Setup4
        Upvalue17( )
        return
    end )
    Clone.Parent = Upvalue1
end

local Value7 = nil

for Key5, Value8 in Upvalue21, nil, nil do
    local Selected = Value8:FindFirstChild( "Selected" )

    if Selected and Selected:IsA( "UIStroke" ) then
        local Enabled = Key5 == Upvalue3 and true or false
        Selected.Enabled = Enabled
    end
end
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2
Upvalue3( )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1.ITEMS[ RevealName ]

if not Entry then
    return
end
if Upvalue2 then
    local Text2

    if Argument3 then
        if ( Amount or 0 ) > 0 then
            local Text = "ALREADY OWNED +" .. Upvalue3( Amount )

            if Text then
                Text2 = Text
            else
                Text2 = "ALREADY OWNED"
            end
        else
            Text2 = "ALREADY OWNED"
        end
    else
        Text2 = Upvalue4
    end

    Upvalue2.Text = Text2
end

local UIScale2
Upvalue5( Upvalue6, Entry.Category, RevealName, Argument2, false )
local Rarity = Upvalue1.Rarity( Entry.Rarity )
local Name = Rarity.Name
Upvalue7.Text = Name .. "  ·  " .. Upvalue1.CATEGORY[ Entry.Category ].Name
Upvalue7.TextColor3 = Rarity.Color
Upvalue8.Visible = true
local UIScale = Upvalue8:FindFirstChildOfClass( "UIScale" )

if UIScale then
    UIScale2 = UIScale
else
    UIScale2 = Instance.new( "UIScale", Upvalue8 )
end

UIScale2.Scale = 0.6
Upvalue9:Create( UIScale2, TweenInfo.new( 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Random = math.random( ) * 100
Value1 = nil

for Key, Value in List, nil, nil do
    local Random2 = Random - Value.Chance

    if Random2 <= 0 then
        return Value.Id
    end
    Random = Random2
end

local Entry2
local Entry = List[ #List ]
Entry2 = if Entry then List[ #List ].Id else Entry
return Entry2
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Owned( ) then
    Upvalue2 = true
end
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    Upvalue2 = true
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

return 0.5 - ( ( Amount - 1 ) * Upvalue1 + Upvalue2 / 2 ) + ( Amount2 or 0 )
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local Window

if Upvalue1 then
    Window = Upvalue1:FindFirstChild( "Window" )
else
    Window = Upvalue1
end

local Parent

if Window then
    Parent = Window:FindFirstChild( "Strip" )
else
    Parent = Window
end
if not Parent then
    Callback( )
    return
end
for Key, Value in Parent:GetChildren( ) do
    Value:Destroy( )
end

Upvalue2 = false
local UIScale = Upvalue1:FindFirstChildOfClass( "UIScale" )

if UIScale then
    UIScale.Scale = 0.85
    Upvalue3:Create( UIScale, TweenInfo.new( 0.2, Enum.EasingStyle.Back ), { Scale = 1 } ):Play( )
end

local Y2
Upvalue1.Visible = true
task.wait( )
local Odds = Upvalue4.Odds( Argument1 )
local AbsoluteSize = Window.AbsoluteSize

if AbsoluteSize.X > 0 then
    local Y = AbsoluteSize.Y * 0.9 * 0.86 / AbsoluteSize.X

    if Y then
        Y2 = Y
    else
        Y2 = 0.15
    end
else
    Y2 = 0.15
end

local Y3 = Y2 * 1.08
local Table = { }
local I = 1

for I = 1, 34 do
    local Value1

    if I ~= 29 or not RollName then
        Value1 = Upvalue5( Odds )
    else
        Value1 = RollName
    end

    local Entry = Upvalue4.ITEMS[ Value1 ]
    local Clone = Upvalue6:Clone( )
    Clone.Name = "RollTile" .. I
    Clone.AnchorPoint = Vector2.new( 0, 0.5 )
    Clone.Size = UDim2.fromScale( Y2, 0.9 )
    Clone.Position = UDim2.fromScale( ( I - 1 ) * Y3, 0.5 )

    if Clone:IsA( "GuiButton" ) then
        Clone.AutoButtonColor = false
    end

    local Entry2 = if Entry then Entry.Category else Entry
    Upvalue7( Clone, Entry2, Value1, 0, false )

    for Key2, Value2 in Clone:GetDescendants( ) do
        if Value2:IsA( "GuiObject" ) then
            Value2.ZIndex = 22
        end
    end

    Clone.ZIndex = 22
    Clone.Parent = Parent
    Table[ I ] = Clone
end

local RollTick2

local function XFor( Amount, Amount2 )
    return 0.5 - ( ( Amount - 1 ) * Y3 + Y2 / 2 ) + ( Amount2 or 0 )
end

local Y4 = 0.5 - ( 0 * Y3 + Y2 / 2 ) + 0
local Random = ( math.random( ) - 0.5 ) * Y2 * 0.7
local Y5 = 0.5 - ( 28 * Y3 + Y2 / 2 ) + ( Random or 0 )
local RollTick = Upvalue8:FindFirstChild( "RollTick" )
RollTick2 = RollTick and RollTick:IsA( "Sound" ) and RollTick or nil
local Number
local Clock = os.clock( )
Number = 1

while true do
    local Min = math.min( ( os.clock( ) - Clock ) / 4.2, 1 )

    if Upvalue2 or not Upvalue8.Visible then
        Min = 1
    end

    local Min2 = 1 - ( 1 - Min ) ^ 4
    local Y6 = Y4 + ( Y5 - Y4 ) * Min2
    Parent.Position = UDim2.fromScale( Y6, 0 )
    local Floor = math.floor( ( 0.5 - Y6 ) / Y3 ) + 1

    if Floor ~= Number and Min < 1 then
        if RollTick2 then
            local Clone2 = RollTick2:Clone( )
            Clone2.PlaybackSpeed = 0.95 + math.random( ) * 0.1
            Clone2.Parent = RollTick2.Parent
            Clone2.Ended:Once( function()
                Clone2:Destroy( )
            end )
            Clone2:Play( )
            Number = Floor
        else
            Number = Floor
        end
    end
    if Min >= 1 then
        break
    end

    Upvalue9.RenderStepped:Wait( )
end

local UIScale3
Upvalue3:Create( Parent, TweenInfo.new( 0.25, Enum.EasingStyle.Quad ), { Position = UDim2.fromScale( 0.5 - ( 28 * Y3 + Y2 / 2 ) + 0, 0 ) } ):Play( )
local Item = Table[ 29 ]

if Item then
    local UIScale2 = Item:FindFirstChildOfClass( "UIScale" )

    if UIScale2 then
        UIScale3 = UIScale2
    else
        UIScale3 = Instance.new( "UIScale", Item )
    end
else
    UIScale3 = Item
end
if UIScale3 then
    Upvalue3:Create( UIScale3, TweenInfo.new( 0.3, Enum.EasingStyle.Back ), { Scale = 1.1 } ):Play( )
end

local RollWin2
local RollWin = Upvalue8:FindFirstChild( "RollWin" )
RollWin2 = RollWin and RollWin:IsA( "Sound" ) and RollWin or nil

if RollWin2 then
    RollWin2.TimePosition = 0
    RollWin2:Play( )
end
if not Upvalue2 and Upvalue8.Visible then
    task.wait( 0.7 )
end

Upvalue1.Visible = false

for Key3, Value3 in Parent:GetChildren( ) do
    Value3:Destroy( )
end

Callback( )
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
Upvalue2.SetShown( Upvalue3, false )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local TestGarageRoll = Upvalue1:GetAttribute( "TestGarageRoll" )

if type( TestGarageRoll ) ~= "string" or Upvalue2 then
    return
end

Upvalue1:SetAttribute( "TestGarageRoll", nil )
local Odds = Upvalue3.Odds( TestGarageRoll )

if not Odds or #Odds == 0 then
    return
end
Upvalue2 = true
Upvalue4.SetShown( Upvalue5, true )
Upvalue6( TestGarageRoll, Upvalue7( Odds ), function()
    Upvalue2 = false
    Upvalue4.SetShown( Upvalue5, false )
end )
return
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Amount >= 1 and math.abs( Amount - math.floor( Amount + 0.5 ) ) < 1e-09 then
    return string.format( "%d%%", ( math.floor( Amount + 0.5 ) ) )
end

local Text = not ( Amount >= 1 ) and "%.4f" or "%.2f"
return string.format( Text, Amount ):gsub( "0+$", "" ):gsub( "%.$", "" ) .. "%"
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Enabled

if ( Upvalue2 and Upvalue3.CRATES[ Upvalue2 ] ) == nil then
    Enabled = false
else
    local Number = tonumber( Upvalue4:GetAttribute( "Money" ) ) or 0

    if ( ( Upvalue2 and Upvalue3.CRATES[ Upvalue2 ] ).Cost or 0 ) <= Number then
        Enabled = true
    else
        Enabled = false
    end
end

local CanOpen = Upvalue1:FindFirstChild( "CanOpen" )
local NoMoney = Upvalue1:FindFirstChild( "NoMoney" )

if CanOpen then
    CanOpen.Enabled = Enabled
end
if NoMoney then
    NoMoney.Enabled = not Enabled
end
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2 then
    return
end
for Key, Value in Upvalue1:GetChildren( ) do
    if Value:IsA( "GuiObject" ) then
        Value:Destroy( )
    end
end

local Odds2

if Argument1 then
    local Odds = Upvalue3.Odds( Argument1 )

    if Odds then
        Odds2 = Odds
    else
        Odds2 = { }
    end
else
    Odds2 = { }
end

local Count = #Odds2
local I = Count

for I = Count, 1, -1 do
    local Entry = Odds2[ I ]
    local Entry2 = Upvalue3.ITEMS[ Entry.Id ]

    if Entry2 then
        local Rarity = Upvalue3.Rarity( Entry2.Rarity )
        local Clone = Upvalue2:Clone( )
        Clone.LayoutOrder = #Odds2 - I + 1
        local ItemName = Clone:FindFirstChild( "ItemName" )
        local Rarity2 = Clone:FindFirstChild( "Rarity" )
        local Chance = Clone:FindFirstChild( "Chance" )
        local RarityBar = Clone:FindFirstChild( "RarityBar" )

        if ItemName then
            ItemName.Text = Entry2.Name
        end
        if Rarity2 then
            Rarity2.Text = Rarity.Name
            Rarity2.TextColor3 = Rarity.Color
        end
        if Chance then
            Chance.Text = Upvalue4( Entry.Chance )
        end
        if RarityBar then
            RarityBar.BackgroundColor3 = Rarity.Color
        end

        Clone.Parent = Upvalue1
    end
end

Upvalue1.CanvasPosition = Vector2.zero
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1 = Argument1
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    local Selected = Value:FindFirstChild( "Selected" )

    if Selected and Selected:IsA( "UIStroke" ) then
        local Enabled = Key == Argument1 and true or false
        Selected.Enabled = Enabled
    end
end
if Upvalue3 then
    local Visible = Argument1 ~= nil and true or false
    Upvalue3.Visible = Visible
end
if Argument1 then
    Upvalue4( Argument1 )
end

Upvalue5( )
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
Upvalue2( Upvalue3.Item, Upvalue3.Count, Upvalue3.already, Upvalue3.refund )
local Entry = Upvalue4.ITEMS[ Upvalue3.Item ]

if Entry then
    Upvalue5 = Entry.Category
end

Upvalue6( )
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Upvalue2 then
    return
end

Upvalue1 = true
local Success, Result = pcall( Upvalue3.InvokeServer, Upvalue3, "OpenCrate", CrateName )
Upvalue1 = false

if not Success or type( Result ) ~= "table" or not Result.ok then
    local Success2

    if Success then
        if type( Result ) == "table" then
            Success2 = Upvalue14[ Result.err ]
        else
            Success2 = false
        end
    else
        Success2 = Success
    end
    if Success2 ~= "" then
        local Success3 = Success2 or "Something went wrong, try again"

        if Upvalue15 and Upvalue15.Error then
            Upvalue15.Error( Success3 )
            return
        end

        warn( "[Garage] " .. Success3 )
    end

    return
end
local Items2
Upvalue4( )
local Items = Result.Items
Items2 = if Items then Items else Upvalue5
local Entry2
Upvalue5 = Items2
local Entry = Upvalue8.CRATES[ CrateName ]
Entry2 = if Entry then Upvalue8.CRATES[ CrateName ].Group else Entry
Upvalue6 = Entry2
Upvalue7 = CrateName
Upvalue9.Visible = false
Upvalue1 = true
Upvalue10( CrateName, Result.Item, function()
    Upvalue1 = false
    Upvalue11( Result.Item, Result.Count, Result.already, Result.refund )
    local Entry = Upvalue8.ITEMS[ Result.Item ]

    if Entry then
        Upvalue12 = Entry.Category
    end

    Upvalue13( )
end )
return
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2( Upvalue1 )
end
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue2 then
    local Visible = ( GroupName and Upvalue1.CRATE_GROUP[ GroupName ] ) == nil and true or false
    Upvalue2.Visible = Visible
end
if Upvalue3 then
    local Visible2 = ( GroupName and Upvalue1.CRATE_GROUP[ GroupName ] ) ~= nil and true or false
    Upvalue3.Visible = Visible2
end
if Upvalue4 then
    local Visible3 = ( GroupName and Upvalue1.CRATE_GROUP[ GroupName ] ) ~= nil and true or false
    Upvalue4.Visible = Visible3
end
if Upvalue5 then
    local Text

    if GroupName and Upvalue1.CRATE_GROUP[ GroupName ] then
        local Upper = string.upper( ( GroupName and Upvalue1.CRATE_GROUP[ GroupName ] ).Name )

        if Upper then
            Text = Upper
        else
            Text = "CRATES"
        end
    else
        Text = "CRATES"
    end

    local Number
    Upvalue5.Text = Text
    local Position = Upvalue5.Position
    Number = not ( GroupName and Upvalue1.CRATE_GROUP[ GroupName ] ) and 0.06 or 0.16
    Upvalue5.Position = UDim2.new( Number, Position.X.Offset, Position.Y.Scale, Position.Y.Offset )
end

local Value1 = nil

for Key, Value in Upvalue6, nil, nil do
    local Visible4

    if ( GroupName and Upvalue1.CRATE_GROUP[ GroupName ] ) == nil then
        Visible4 = false
    elseif Upvalue1.CRATES[ Key ].Group == GroupName then
        Visible4 = true
    else
        Visible4 = false
    end

    Value.Visible = Visible4
end

local Item2

if GroupName and Upvalue1.CRATE_GROUP[ GroupName ] then
    local Item = ( GroupName and Upvalue1.CRATE_GROUP[ GroupName ] ).Crates[ 1 ]

    if Item then
        Item2 = Item
    else
        Item2 = nil
    end
else
    Item2 = nil
end

Upvalue7( Item2 )
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1.Visible = true
end
if Upvalue2 then
    Upvalue2.Visible = false
end
if Upvalue3 then
    Upvalue3.Visible = false
end
if Upvalue4 then
    Upvalue4.Text = "CRATES"
    local Position = Upvalue4.Position
    Upvalue4.Position = UDim2.new( 0.06, Position.X.Offset, Position.Y.Scale, Position.Y.Offset )
end

local Value1 = nil

for Key, Value in Upvalue5, nil, nil do
    Value.Visible = false
end

Upvalue6( nil )
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = false

if Upvalue2 then
    Upvalue2.Visible = true
end
if Upvalue3 then
    Upvalue3.Visible = false
end
if Upvalue4 then
    Upvalue4.Visible = false
end
if Upvalue5 then
    Upvalue5.Text = "CRATES"
    local Position = Upvalue5.Position
    Upvalue5.Position = UDim2.new( 0.06, Position.X.Offset, Position.Y.Scale, Position.Y.Offset )
end

local Value1 = nil

for Key, Value in Upvalue6, nil, nil do
    Value.Visible = false
end

Upvalue7( nil )
Upvalue8.Visible = not Upvalue8.Visible
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = false

if Upvalue2 then
    Upvalue2.Visible = true
end
if Upvalue3 then
    Upvalue3.Visible = false
end
if Upvalue4 then
    Upvalue4.Visible = false
end
if Upvalue5 then
    Upvalue5.Text = "CRATES"
    local Position = Upvalue5.Position
    Upvalue5.Position = UDim2.new( 0.06, Position.X.Offset, Position.Y.Scale, Position.Y.Offset )
end

local Value1 = nil

for Key, Value in Upvalue6, nil, nil do
    Value.Visible = false
end

Upvalue7( nil )
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = false

if not Upvalue2 or not Upvalue3 or not Upvalue4.CRATE_GROUP[ Upvalue3 ] then
    return
end

Upvalue5( Upvalue3 )

if Upvalue6 then
    Upvalue7( Upvalue6 )
end

Upvalue8.Visible = true

if Upvalue6 and Upvalue9[ Upvalue6 ] and ( Upvalue6 and Upvalue9[ Upvalue6 ] ).Visible then
    Upvalue10.Refresh( "CarGarage", Upvalue6 and Upvalue9[ Upvalue6 ] )
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Argument1.UserInputType == Enum.UserInputType.MouseButton2 then
    Upvalue2 = true
end
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton2 then
    Upvalue1 = false
end
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Argument1.UserInputType == Enum.UserInputType.MouseMovement and Upvalue2 then
    Upvalue3 = Upvalue3 + Argument1.Delta.X * 0.008
    Upvalue4 = math.clamp( Upvalue4 + Argument1.Delta.Y * 0.008, 0.05, 1.1 )
    return
end
if Argument1.UserInputType == Enum.UserInputType.MouseWheel and not Argument2 then
    Upvalue5 = math.clamp( Upvalue5 - Argument1.Position.Z * 0.08, 0.55, 1.5 )
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Model = Upvalue1.model

if not Model.Parent then
    return
end
for Key, Value in Upvalue2:GetGamepadState( Enum.UserInputType.Gamepad1 ) do
    if Value.KeyCode == Enum.KeyCode.Thumbstick2 and Value.Position.Magnitude > 0.15 then
        Upvalue3 = Upvalue3 + Value.Position.X * 2.2 * ( Amount or 0.016666666666666666 )
        Upvalue4 = math.clamp( Upvalue4 - Value.Position.Y * 1.6 * ( Amount or 0.016666666666666666 ), 0.05, 1.1 )
    end
end

local Max3
local BoundingBox, BoundingBox2 = Model:GetBoundingBox( )
local Position = BoundingBox.Position
local X = BoundingBox2.X
local Max = ( math.max( X, BoundingBox2.Z ) * 1.05 + 6 ) * Upvalue5
local Cos = math.cos( Upvalue4 ) * Max
local Cos2 = math.cos( Upvalue3 ) * Cos
local Sin = math.sin( Upvalue4 ) * Max
local Vector32 = Vector3.new( Cos2, Sin, math.sin( Upvalue3 ) * Cos )
Upvalue6.FilterDescendantsInstances = { Model, Upvalue7.Character }
local Spherecast = workspace:Spherecast( Position, 0.6, Vector32, Upvalue6 )

if Spherecast then
    local Max2 = math.max( Spherecast.Distance - 0.4, 3 )

    if Max2 then
        Max3 = Max2
    else
        Max3 = Vector32.Magnitude
    end
else
    Max3 = Vector32.Magnitude
end

local FixedFOV
local Position2 = Position + Vector32.Unit * Max3
local FixedCamera = CFrame.lookAt( Position2, Position + Vector3.new( 0, 0.30000001192092896, 0 ) )
FixedFOV = not ( Max3 < Vector32.Magnitude * 0.7 ) and 55 or 70
Upvalue8.FixedCamera = FixedCamera
Upvalue8.FixedFOV = FixedFOV
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character

if Character then
    Humanoid = Upvalue1.Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
local IsDescendantOf

if Character2 == nil then
    IsDescendantOf = false
elseif typeof( Argument1 ) == "Instance" then
    IsDescendantOf = Character2:IsDescendantOf( Argument1 )
else
    IsDescendantOf = false
end

return IsDescendantOf
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    if not Upvalue2.IsShown( Upvalue3 ) then
        return
    end

    Upvalue1 = { index = 0, model = nil }
    Argument1 = false
end

local Index = Upvalue1.index
Upvalue1 = nil
Upvalue4:UnbindFromRenderStep( "GarageCam" )
Upvalue5.FixedCamera = nil
Upvalue5.FixedFOV = nil
Upvalue5.RobloxCamera = nil

if Upvalue6 ~= nil then
    Upvalue7.Enabled = Upvalue6
    Upvalue6 = nil
end

local Value1
Upvalue8.Visible = false
Upvalue9.Visible = false
Upvalue2.SetShown( Upvalue3, false )
Value1 = nil

for Value in Upvalue10, nil, nil do
    Upvalue2.SetShown( Value, true )
end

table.clear( Upvalue10 )
Upvalue5.AdminUIHidden = Upvalue11
Upvalue12.Close( "CarGarage" )

if Argument1 then
    Upvalue13:FireServer( "done", Index )
end
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

local Horn2
local Table = { }
local Horn = Upvalue1.BY_CATEGORY.Horn
Horn2 = if Horn then Horn else { }
local Value1 = nil

for Key, Value in Horn2, nil, nil do
    local Entry = Upvalue1.ITEMS[ Value ]

    if Entry and Entry.Sound then
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = "rbxassetid://" .. Entry.Sound
        table.insert( Table, Sound )
    end
end

local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
pcall( PreloadAsync, game:GetService( "ContentProvider" ), Table )
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    Upvalue2( )
    return
end
if Upvalue3.Visible then
    Upvalue3.Visible = false
    return
end
Upvalue4( true )
return
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or typeof( Model ) ~= "Instance" then
    return
end

local Humanoid
local Character = Upvalue2.Character

if Character then
    Humanoid = Upvalue2.Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
local IsDescendantOf

if Character2 == nil then
    IsDescendantOf = false
elseif typeof( Model ) == "Instance" then
    IsDescendantOf = Character2:IsDescendantOf( Model )
else
    IsDescendantOf = false
end
if not IsDescendantOf then
    Upvalue3:FireServer( "done", Argument1 )
    return
end

local Table = { index = Argument1, model = Model }
Upvalue1 = Table
local Success, Result = pcall( Upvalue4.InvokeServer, Upvalue4, "State" )

if Upvalue1 == Table then
    local Humanoid2
    local Character3 = Upvalue2.Character

    if Character3 then
        Humanoid2 = Upvalue2.Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid2 = Character3
    end

    local Character4 = if Humanoid2 then Humanoid2.SeatPart else Humanoid2
    local IsDescendantOf2

    if Character4 == nil then
        IsDescendantOf2 = false
    elseif typeof( Model ) == "Instance" then
        IsDescendantOf2 = Character4:IsDescendantOf( Model )
    else
        IsDescendantOf2 = false
    end
    if IsDescendantOf2 then
        if Success and type( Result ) == "table" and Result.ok then
            local Items2
            local Items = Result.Items
            Items2 = if Items then Items else { }
            local Setup2
            local Setup = Result.Setup
            Setup2 = if Setup then Setup else { }
            Upvalue5 = Items2
            Upvalue6 = Setup2
        end

        local Value1
        Upvalue7 = Upvalue8.CATEGORIES[ 1 ].Key
        Upvalue9( )
        task.spawn( function()
            local Horn2
            local Table = { }
            local Horn = Upvalue8.BY_CATEGORY.Horn
            Horn2 = if Horn then Horn else { }
            local Value1 = nil

            for Key, Value in Horn2, nil, nil do
                local Entry = Upvalue8.ITEMS[ Value ]

                if Entry and Entry.Sound then
                    local Sound = Instance.new( "Sound" )
                    Sound.SoundId = "rbxassetid://" .. Entry.Sound
                    table.insert( Table, Sound )
                end
            end

            local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
            pcall( PreloadAsync, game:GetService( "ContentProvider" ), Table )
        end )
        local Table2 = { "CrewHUD", "ShopHUD" }
        Value1 = nil

        for Key, Value in Table2, nil, nil do
            if Upvalue10.IsShown( Value ) then
                Upvalue11[ Value ] = true
                Upvalue10.SetShown( Value, false )
            end
        end

        local RobloxCamera
        Upvalue12 = Upvalue13.AdminUIHidden
        Upvalue13.AdminUIHidden = true
        Upvalue10.SetShown( Upvalue14, true )
        Model:GetBoundingBox( )
        local Position = workspace.CurrentCamera.CFrame.Position - Model:GetPivot( ).Position
        local Z = Position.Z
        Upvalue15 = math.atan2( Z, Position.X )
        Upvalue16 = 0.32
        Upvalue17 = 1
        Upvalue18 = false
        local PrimaryPart = Model.PrimaryPart
        RobloxCamera = if PrimaryPart then PrimaryPart else Model:FindFirstChild( "VehicleRoot" )
        Upvalue13.RobloxCamera = RobloxCamera

        if Upvalue19 == nil then
            Upvalue19 = Upvalue20.Enabled
        end

        Upvalue20.Enabled = false
        local Entry = Upvalue21[ Upvalue7 ]
        Upvalue22.Open( "CarGarage", {
            root = Upvalue14,
            first = Entry,
            freeze = false,
            backLabel = "Back",
            onBack = function()
                if Upvalue23.Visible then
                    Upvalue24( )
                    return
                end
                if Upvalue25.Visible then
                    Upvalue25.Visible = false
                    return
                end
                Upvalue26( true )
                return
            end
        } )
        return
    end
end
if Upvalue1 == Table then
    Upvalue1 = nil
    Upvalue3:FireServer( "done", Argument1 )
end
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( true )
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "garage" and type( Argument2 ) == "number" then
    Upvalue1( Argument2, Argument3 )
    return
end
if Name == "close" then
    Upvalue2( false )
end
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( false )
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Upvalue1.model then
    local Humanoid
    local Model = Upvalue1.model
    local Character = Upvalue2.Character

    if Character then
        Humanoid = Upvalue2.Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
    local IsDescendantOf

    if Character2 == nil then
        IsDescendantOf = false
    elseif typeof( Model ) == "Instance" then
        IsDescendantOf = Character2:IsDescendantOf( Model )
    else
        IsDescendantOf = false
    end
    if not IsDescendantOf then
        Upvalue3( true )
    end
end
]]
