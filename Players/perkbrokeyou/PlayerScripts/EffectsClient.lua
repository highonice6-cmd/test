-- Players.perkbrokeyou.PlayerScripts.EffectsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #56

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Tint
local Normal = Self:FindFirstChild( "Normal" )

if Normal then
    Tint = Normal
else
    Tint = Self:FindFirstChild( "Tint" )
end

local Selected = Self:FindFirstChild( "Selected" )

if Tint and Tint:IsA( "UIGradient" ) then
    Tint.Enabled = not Enabled
end
if Selected and Selected:IsA( "UIGradient" ) then
    Selected.Enabled = Enabled
end

local UIStroke = Self:FindFirstChildWhichIsA( "UIStroke" )

if UIStroke then
    if UIStroke:GetAttribute( "RestTransparency" ) == nil then
        UIStroke:SetAttribute( "RestTransparency", UIStroke.Transparency )
    end

    local Transparency2

    if Enabled then
        local SelectedTransparency = UIStroke:GetAttribute( "SelectedTransparency" )

        if SelectedTransparency then
            Transparency2 = SelectedTransparency
        else
            local Transparency = UIStroke.Transparency

            if Transparency then
                Transparency2 = Transparency
            else
                Transparency2 = UIStroke:GetAttribute( "RestTransparency" )
            end
        end
    else
        Transparency2 = UIStroke:GetAttribute( "RestTransparency" )
    end

    UIStroke.Transparency = Transparency2
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if type( Argument1 ) == "table" then
    Upvalue1 = Argument1
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Enabled and Upvalue2 then
    Upvalue2.redraw( )
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false

if not Upvalue2.IsOpen and Upvalue3.Enabled and Upvalue4 then
    Upvalue4.redraw( )
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
task.delay( 0.05, function()
    Upvalue1 = false

    if not Upvalue2.IsOpen and Upvalue3.Enabled and Upvalue4 then
        Upvalue4.redraw( )
    end
end )
return
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.id == "KillMsg" then
    return "GIFT A KILL SCREEN"
end

local Text

if Argument1.id == "KillFX" then
    Text = " KILL EFFECT"
elseif Argument1.id == "Tracer" then
    Text = " TRACERS"
else
    Text = ""
end

return "GIFT " .. string.upper( Argument2.name ) .. Text
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Gift = Upvalue1.Gift
local Id = Upvalue2.id
Gift( Id, Upvalue3.id, Argument1, Argument2 )
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = true
Upvalue2.Visible = true

if Upvalue3.Enabled and Upvalue4 then
    Upvalue4.redraw( )
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Title
Upvalue1.Visible = false
Upvalue2.Visible = false
Upvalue3.Visible = false
local Table = { }

if Argument1.id == "KillMsg" then
    Title = "GIFT A KILL SCREEN"
else
    local Text

    if Argument1.id == "KillFX" then
        Text = " KILL EFFECT"
    elseif Argument1.id == "Tracer" then
        Text = " TRACERS"
    else
        Text = ""
    end

    Title = "GIFT " .. string.upper( Argument2.name ) .. Text
end

Table.title = Title
function Table.onSend( Argument1Inner, Argument2Inner )
    local Gift = Upvalue5.Gift
    local Id = Argument1.id
    Gift( Id, Argument2.id, Argument1Inner, Argument2Inner )
end
function Table.onClose()
    Upvalue1.Visible = true
    Upvalue2.Visible = true

    if Upvalue6.Enabled and Upvalue7 then
        Upvalue7.redraw( )
    end
end
Upvalue4:Open( Table )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.ReducedMotionEnabled
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local Success2
local Success, Result = pcall( function()
    return Upvalue1.ReducedMotionEnabled
end )

if Success then
    if Result == true then
        Success2 = true
    else
        Success2 = false
    end
else
    Success2 = Success
end

return Success2
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Argument2 == Enum.AssetFetchStatus.Success and true or false
Upvalue1 = Flag
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local ImageLabel = Instance.new( "ImageLabel" )
ImageLabel.Image = Upvalue1
local Flag = false
pcall( Upvalue2.PreloadAsync, Upvalue2, { ImageLabel }, function( Argument1, Argument2 )
    local FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
    Flag = FlagInner
end )
ImageLabel:Destroy( )
Upvalue3[ Upvalue1 ] = nil

if Flag then
    Upvalue4[ Upvalue1 ] = true
else
    Upvalue5[ Upvalue1 ] = true
end
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ Key ] or Upvalue2[ Key ] or Upvalue3[ Key ] then
    return
end
Upvalue2[ Key ] = true
task.spawn( function()
    local ImageLabel = Instance.new( "ImageLabel" )
    ImageLabel.Image = Key
    local Flag = false
    pcall( Upvalue4.PreloadAsync, Upvalue4, { ImageLabel }, function( Argument1, Argument2 )
        local FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
        Flag = FlagInner
    end )
    ImageLabel:Destroy( )
    Upvalue2[ Key ] = nil

    if Flag then
        Upvalue1[ Key ] = true
    else
        Upvalue3[ Key ] = true
    end
end )
return
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    local Anim = Upvalue2.Anim

    if not Upvalue3[ Anim.Id ] then
        local Id = Anim.Id

        if not Upvalue3[ Id ] and not Upvalue4[ Id ] then
            if Upvalue5[ Id ] then
                return
            end

            Upvalue4[ Id ] = true
            task.spawn( function()
                local ImageLabel = Instance.new( "ImageLabel" )
                ImageLabel.Image = Id
                local Flag = false
                pcall( Upvalue6.PreloadAsync, Upvalue6, { ImageLabel }, function( Argument1, Argument2 )
                    local FlagInner = Argument2 == Enum.AssetFetchStatus.Success and true or false
                    Flag = FlagInner
                end )
                ImageLabel:Destroy( )
                Upvalue4[ Id ] = nil

                if Flag then
                    Upvalue3[ Id ] = true
                else
                    Upvalue5[ Id ] = true
                end
            end )
        end

        return
    end
    local Cols = Anim.Cols or 4
    local Fps = Anim.Fps or 12
    local Frames = Anim.Frames
    Upvalue7 = Cols
    Upvalue8 = Fps
    Upvalue9 = Frames
    Upvalue10 = ( Anim.Size or 1024 ) / Upvalue7
    local Image = Anim.Id
    local Image2 = Anim.Id
    Upvalue11.Image = Image
    Upvalue12.Image = Image2
    local ImageRectSize = Vector2.new( Upvalue10, Upvalue10 )
    local ImageRectSize2 = Vector2.new( Upvalue10, Upvalue10 )
    Upvalue11.ImageRectSize = ImageRectSize
    Upvalue12.ImageRectSize = ImageRectSize2
    Upvalue1 = true
    Upvalue13 = 0
    Upvalue14 = nil
end

Upvalue13 = Upvalue13 + Argument1
local Captured = Upvalue13 * Upvalue8
local Floor = math.floor( Captured ) % Upvalue9

if Floor ~= Upvalue14 then
    Upvalue14 = Floor
    local Floor2 = ( Floor + 1 ) % Upvalue9
    Upvalue11.ImageRectOffset = Vector2.new( Floor % Upvalue7 * Upvalue10, Floor // Upvalue7 * Upvalue10 )
    Upvalue12.ImageRectOffset = Vector2.new( Floor2 % Upvalue7 * Upvalue10, Floor2 // Upvalue7 * Upvalue10 )
end

local Captured2 = Captured - math.floor( Captured )
Upvalue12.ImageTransparency = 1 - Captured2 * Captured2 * ( 3 - 2 * Captured2 )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Argument1
Upvalue2 = false
Upvalue3.Image = Argument1.Icon or ""
Upvalue3.ImageRectSize = Vector2.zero
Upvalue3.ImageRectOffset = Vector2.zero
Upvalue4.Image = ""
Upvalue4.ImageTransparency = 1
local Entry = Upvalue5.Effects[ Argument1.id ]

if Entry and Entry.Sound then
    Upvalue6.SoundId = "rbxassetid://" .. Entry.Sound
    Upvalue6.Volume = ( Entry.Volume or 1 ) * 0.6
    Upvalue6.TimePosition = Entry.SoundStart or 0
    Upvalue6:Play( )
end
if not Upvalue7 then
    local Success2
    local Success, Result = pcall( function()
        return Upvalue8.ReducedMotionEnabled
    end )

    if Success then
        if Result == true then
            Success2 = true
        else
            Success2 = false
        end
    else
        Success2 = Success
    end
    if not Success2 then
        Upvalue7 = Upvalue9.RenderStepped:Connect( Upvalue10 )
    end
end
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil
Upvalue2 = false

if Upvalue3 then
    Upvalue3:Disconnect( )
    Upvalue3 = nil
end

Upvalue4.Image = ""
Upvalue5.Image = ""
Upvalue5.ImageTransparency = 1
Upvalue6:Stop( )
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

return ColorSequence.new( {
    ColorSequenceKeypoint.new( 0, Self:Lerp( Color3.new( 1, 1, 1 ), 0.25 ) ),
    ColorSequenceKeypoint.new( 0.45, Self:Lerp( Color3.new( 0, 0, 0 ), 0.45 ) ),
    ColorSequenceKeypoint.new( 1, Self:Lerp( Color3.new( 0, 0, 0 ), 0.8 ) )
} )
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil
    Upvalue2.Visible = false
    Upvalue3.Stop( )
    Upvalue4.Close( "EffectsShowcase" )
    return
end
return
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Argument1
local Title = Upvalue2:FindFirstChild( "Title" )
local Tint = Upvalue2:FindFirstChild( "Tint" )

if Title then
    Title.Text = Argument1.name
end
if Tint and Argument1.Color then
    Tint.Color = Upvalue3( Argument1.Color )
end

Upvalue4.Visible = true
Upvalue5.Play( Argument1 )
local Close = Upvalue2:FindFirstChild( "Close" )
Upvalue6.Open( "EffectsShowcase", {
    root = Upvalue2,
    first = function()
        return Close
    end,
    onBack = Upvalue7
} )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

return ( "<font color=\"#%s\">%s</font>" ):format( Upvalue1, Upvalue2.Escape( Argument1 ) )
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.Image = Upvalue1.Icon
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.id == "Sky" and Upvalue2 ~= nil then
    if Upvalue3 == "equip" or Upvalue3 == "equipped" then
        if Upvalue4.Settings.NoSky == true then
            local Callback
            Upvalue4.Set( "NoSky", false )
            local Pickup = Upvalue5.Pickup
            local Color = Upvalue2.Color
            Callback = type( Upvalue2.Icon ) == "string" and Upvalue2.Icon ~= "" and function( Argument1 )
                Argument1.Image = Upvalue2.Icon
            end or nil
            Pickup( "No Sky turned off: your sky is visible", Color, Callback )
        end
    end
end
if Upvalue3 == "equip" then
    local InvokeServer = Upvalue6.InvokeServer
    local Success, Result = pcall( InvokeServer, Upvalue6, "equip", Upvalue1.id, Upvalue7 )

    if Success and type( Result ) == "table" then
        Upvalue8 = Result
    end
    if Upvalue9.Enabled and Upvalue10 then
        Upvalue10.redraw( )
        return
    end
elseif Upvalue3 == "buy" then
    if Upvalue11.Buy( Upvalue1.id, Upvalue7 ) and Upvalue9.Enabled and Upvalue10 then
        Upvalue10.redraw( )
        return
    end
elseif Upvalue3 == "pack" and Upvalue12 then
    Upvalue12( )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2, Upvalue3 )
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local Id = Argument2 and Argument2.id or nil
local Flag2

if Argument2 == nil then
    Flag2 = true
else
    local Entry2
    local Entry = Upvalue1.owned[ TabName.id ]
    Entry2 = if Entry then Entry else { }

    if Entry2[ Id ] == true then
        Flag2 = true
    else
        Flag2 = false
    end
end

local Flag = ( Upvalue1.equipped[ TabName.id ] or nil ) == Id and true or false
local Captured = TabName.id == "KillMsg" and Upvalue2 or Upvalue3
local Clone = Captured:Clone( )
Clone.Name = "Item_" .. ( Id or "None" )
Clone.LayoutOrder = LayoutOrder
local Swatch = Clone:FindFirstChild( "Swatch" )
local Icon = Clone:FindFirstChild( "Icon" )
local Streak = Clone:FindFirstChild( "Streak" )

if Argument2 and Argument2.Color then
    local BackgroundColor3 = Argument2.Color
    local Tint = Clone:FindFirstChild( "Tint" )

    if Tint then
        Tint.Color = Upvalue4( BackgroundColor3 )
    end
    if Swatch then
        Swatch.BackgroundColor3 = BackgroundColor3
    end
end

Upvalue5( Clone, Flag )
local Text = Clone:FindFirstChild( "Text" )
local Preview = Clone:FindFirstChild( "Preview" )

if TabName.id == "KillMsg" then
    local Value1
    local Table = { Swatch, Icon, Streak, Text }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        if Value then
            Value.Visible = false
        end
    end
    if Preview then
        local FromRGB
        Preview.Visible = true

        if not Argument2 or not Argument2.Color then
            FromRGB = Color3.fromRGB( 230, 230, 240 )
        else
            FromRGB = Argument2.Color
        end

        local ToHex = FromRGB:ToHex( )
        local Format = Upvalue6.Format
        Preview.Text = Format( Id, Upvalue7.DisplayName, Upvalue6.LocalLang( ), function( Argument1 )
            return ( "<font color=\"#%s\">%s</font>" ):format( ToHex, Upvalue6.Escape( Argument1 ) )
        end )
    end
else
    if Preview then
        Preview.Visible = false
    end
    if Text then
        local Text2 = Argument2 and Argument2.name or "None"
        Text.Text = Text2
    end

    local Visible

    if Argument2 == nil then
        Visible = false
    elseif type( Argument2.Icon ) == "string" then
        if Argument2.Icon == "" then
            Visible = false
        else
            Visible = true
        end
    else
        Visible = false
    end

    local Visible3

    if Argument2 == nil then
        Visible3 = false
    elseif TabName.id == "Tracer" then
        Visible3 = not Visible
    else
        Visible3 = false
    end
    if Icon then
        Icon.Visible = Visible

        if Visible then
            Icon.Image = Argument2.Icon
        end
    end

    local Eye = Clone:FindFirstChild( "Eye" )

    if Eye then
        local Visible2

        if TabName.id == "KillFX" then
            if Argument2 == nil then
                Visible2 = false
            elseif Argument2.Anim == nil then
                Visible2 = false
            else
                Visible2 = true
            end
        else
            Visible2 = false
        end

        Eye.Visible = Visible2

        if Eye.Visible then
            Eye.Activated:Connect( function()
                Upvalue8( Argument2 )
            end )
        end
    end
    if Streak then
        Streak.Visible = Visible3
        local Core = Streak:FindFirstChild( "Core" )

        if not Visible3 or not Argument2.StreakOutline or not Core then
            if Visible3 and Argument2.Color then
                Streak.BackgroundColor3 = Argument2.Color
            end
        else
            local BackgroundColor32
            Streak.BackgroundColor3 = Argument2.StreakOutline
            local StreakColor = Argument2.StreakColor
            BackgroundColor32 = if StreakColor then StreakColor else Color3.new( 1, 1, 1 )
            Core.BackgroundColor3 = BackgroundColor32
            Core.Visible = true
        end
    end
    if Swatch then
        local Visible4
        local NotFlag = not Visible
        Visible4 = if NotFlag then not Visible3 else NotFlag
        Swatch.Visible = Visible4
    end
end

local Buy
local Price = Clone:FindFirstChild( "Price" )

if Price then
    Buy = Price:FindFirstChild( "Buy" )
else
    Buy = Price
end

local Gift

if Price then
    Gift = Price:FindFirstChild( "Gift" )
else
    Gift = Price
end

local Find

if Argument2 then
    local Pack = Argument2.Pack

    if Pack then
        Find = Upvalue9.Find( Argument2.Pack )
    else
        Find = Pack
    end
else
    Find = Argument2
end

local Limited = Clone:FindFirstChild( "Limited" )

if Limited then
    local Visible5 = Find ~= nil and true or false
    Limited.Visible = Visible5
end

local PriceText, Text3

if Flag then
    Text3 = "equipped"
    PriceText = "EQUIPPED"
elseif Flag2 then
    Text3 = "equip"
    PriceText = "EQUIP"
elseif Argument2 and Argument2.ProductId or not Find or not Upvalue9.Active( Find ) then
    if Argument2 and Argument2.ProductId then
        if Upvalue10.Pending( Argument2 and Argument2.ProductId ) then
            Text3 = "wait"
            PriceText = "..."
        else
            local Credits2
            local Credits = Upvalue1.credits
            Credits2 = if Credits then Credits else { }

            if ( tonumber( Credits2[ tostring( Argument2 and Argument2.ProductId ) ] ) or 0 ) > 0 then
                Text3 = "buy"
                PriceText = "FREE"
            else
                PriceText = Upvalue10.PriceText( Argument2 and Argument2.ProductId, Upvalue11 )
                Text3 = "buy"
            end
        end
    else
        Text3 = "soon"
        PriceText = "SOON"
    end
else
    Text3 = "pack"
    PriceText = "GET PACK"
end
if Buy then
    local Text4
    local SetBuy = Upvalue10.SetBuy
    Text4 = if Text3 == "pack" then "buy" else Text3
    SetBuy( Buy, Text4, PriceText )

    if not ( Argument2 and Argument2.ProductId ) then
        local Size
        local FullSize = Buy:GetAttribute( "FullSize" )
        Size = if FullSize then FullSize else Buy.Size
        Buy.Size = Size
    end
end
if Gift then
    local Visible6 = ( Argument2 and Argument2.ProductId ) ~= nil and true or false
    Gift.Visible = Visible6
end

local function Act()
    if TabName.id == "Sky" and Argument2 ~= nil then
        if Text3 == "equip" or Text3 == "equipped" then
            if Upvalue12.Settings.NoSky == true then
                local Callback
                Upvalue12.Set( "NoSky", false )
                local Pickup = Upvalue13.Pickup
                local Color = Argument2.Color
                Callback = type( Argument2.Icon ) == "string" and Argument2.Icon ~= "" and function( Argument1 )
                    Argument1.Image = Argument2.Icon
                end or nil
                Pickup( "No Sky turned off: your sky is visible", Color, Callback )
            end
        end
    end
    if Text3 == "equip" then
        local InvokeServer = Upvalue14.InvokeServer
        local Success, Result = pcall( InvokeServer, Upvalue14, "equip", TabName.id, Id )

        if Success and type( Result ) == "table" then
            Upvalue1 = Result
        end
        if Upvalue15.Enabled and Upvalue16 then
            Upvalue16.redraw( )
            return
        end
    elseif Text3 == "buy" then
        if Upvalue10.Buy( TabName.id, Id ) and Upvalue15.Enabled and Upvalue16 then
            Upvalue16.redraw( )
            return
        end
    elseif Text3 == "pack" and Upvalue17 then
        Upvalue17( )
    end
end

if Buy then
    Buy.Activated:Connect( Act )
end

Clone.Activated:Connect( Act )

if Gift and Argument2 and Argument2.ProductId then
    Gift.Activated:Connect( function()
        Upvalue18( TabName, Argument2 )
    end )
end

Clone.Parent = Upvalue19
return Clone
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1:GetAttribute( "TracerFlash" ) ~= false and true or false
return Flag
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Box

if Upvalue1 then
    Box = Upvalue1:FindFirstChild( "Box" )
else
    Box = Upvalue1
end
if not Box then
    return
end

local On = Box:FindFirstChild( "On" )
local Off = Box:FindFirstChild( "Off" )
local Tick = Box:FindFirstChild( "Tick" )

if On then
    On.Enabled = Enabled
end
if Off then
    Off.Enabled = not Enabled
end
if Tick then
    Tick.Visible = Enabled
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue2:GetAttribute( "TracerFlash" ) ~= false and true or false
Upvalue1( Flag )
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Flag
Upvalue1 = true
Flag = Upvalue2:GetAttribute( "TracerFlash" ) ~= false and true or false
local NotFlag = not Flag
Upvalue3( NotFlag )
local Success, Result = pcall( Upvalue4.InvokeServer, Upvalue4, "flash", NotFlag )

if Success and type( Result ) == "table" then
    Upvalue5 = Result
end

local Flash

if not Success or type( Result ) ~= "table" or type( Result.flash ) ~= "boolean" then
    if Upvalue2:GetAttribute( "TracerFlash" ) == false then
        Flash = false
    else
        Flash = true
    end
else
    Flash = Result.flash
end

Upvalue3( Flash )
Upvalue1 = false
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

local Name, Name2
local SelectedObject = Upvalue1.SelectedObject

if not SelectedObject or not SelectedObject:IsDescendantOf( Upvalue2 ) then
    Name = nil
    Name2 = nil
else
    local SelectedObject2 = SelectedObject

    while SelectedObject2.Parent do
        if SelectedObject2.Parent == Upvalue2 then
            break
        end

        SelectedObject2 = SelectedObject2.Parent
    end

    Name = SelectedObject2.Name
    Name2 = SelectedObject.Name
end
for Key, Value in Upvalue2:GetChildren( ) do
    if Value:IsA( "GuiObject" ) then
        Value:Destroy( )
    end
end

local Entry4
local Table = { }
local Entry = Upvalue3.Items[ Upvalue4.id ]
Entry4 = if Entry then Entry else { }
local Value1 = nil

for Key2, Value2 in Entry4, nil, nil do
    if Value2.Pack and not Upvalue5.Active( Value2.Pack ) then
        local Entry3
        local Entry2 = Upvalue6.owned[ Upvalue4.id ]
        Entry3 = if Entry2 then Entry2 else { }

        if not Entry3[ Value2.id ] then
            continue
        end
    end

    table.insert( Table, Value2 )
end

local Visible = if #Table == 0 then not Upvalue8.IsOpen else false
Upvalue7.Visible = Visible

if #Table > 0 then
    local Value3
    Upvalue9( Upvalue4, nil, 0 )
    Value3 = nil

    for Key3, Value4 in Table, nil, nil do
        Upvalue9( Upvalue4, Value4, Key3 )
    end
end
if Name then
    local FoundChild2
    local FoundChild = Upvalue2:FindFirstChild( Name )
    local Refresh = Upvalue10.Refresh
    FoundChild2 = FoundChild and FoundChild:FindFirstChild( Name2, true ) or nil
    Refresh( "Effects", FoundChild2 )
end
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = { cat = TabName }

if Upvalue2 then
    local Visible

    if TabName.id == "Tracer" then
        if Upvalue3:GetAttribute( "FlashTraceur" ) == true then
            Visible = true
        else
            Visible = false
        end
    else
        Visible = false
    end

    Upvalue2.Visible = Visible
end

local Captured = TabName.id == "KillMsg" and Upvalue4 or Upvalue5
Upvalue6.FillDirectionMaxCells = Captured.max
Upvalue6.CellSize = Captured.cell

if Upvalue7 then
    Upvalue7.AspectRatio = Captured.aspect
end

local Value1
function Upvalue1.redraw()
    local Name, Name2
    local SelectedObject = Upvalue8.SelectedObject

    if not SelectedObject or not SelectedObject:IsDescendantOf( Upvalue9 ) then
        Name = nil
        Name2 = nil
    else
        local SelectedObject2 = SelectedObject

        while SelectedObject2.Parent do
            if SelectedObject2.Parent == Upvalue9 then
                break
            end

            SelectedObject2 = SelectedObject2.Parent
        end

        Name = SelectedObject2.Name
        Name2 = SelectedObject.Name
    end
    for Key, Value in Upvalue9:GetChildren( ) do
        if Value:IsA( "GuiObject" ) then
            Value:Destroy( )
        end
    end

    local Entry4
    local Table = { }
    local Entry = Upvalue10.Items[ TabName.id ]
    Entry4 = if Entry then Entry else { }
    local Value1 = nil

    for Key2, Value2 in Entry4, nil, nil do
        if Value2.Pack and not Upvalue11.Active( Value2.Pack ) then
            local Entry3
            local Entry2 = Upvalue12.owned[ TabName.id ]
            Entry3 = if Entry2 then Entry2 else { }

            if not Entry3[ Value2.id ] then
                continue
            end
        end

        table.insert( Table, Value2 )
    end

    local Visible = if #Table == 0 then not Upvalue14.IsOpen else false
    Upvalue13.Visible = Visible

    if #Table > 0 then
        local Value3
        Upvalue15( TabName, nil, 0 )
        Value3 = nil

        for Key3, Value4 in Table, nil, nil do
            Upvalue15( TabName, Value4, Key3 )
        end
    end
    if Name then
        local FoundChild2
        local FoundChild = Upvalue9:FindFirstChild( Name )
        local Refresh = Upvalue16.Refresh
        FoundChild2 = FoundChild and FoundChild:FindFirstChild( Name2, true ) or nil
        Refresh( "Effects", FoundChild2 )
    end
end
Upvalue1.redraw( )
Upvalue9.CanvasPosition = Vector2.zero
Value1 = nil

for Key, Value in Upvalue17, nil, nil do
    local Flag = Key == TabName and true or false
    Upvalue18( Value, Flag )
end

local Buy
local Item_None = Upvalue9:FindFirstChild( "Item_None" )
local Refresh = Upvalue16.Refresh

if Argument2 then
    if not Item_None or not Item_None:FindFirstChild( "Buy", true ) then
        local Entry = Upvalue17[ TabName ]

        if Entry then
            Buy = Entry
        else
            Buy = Upvalue17[ TabName ]
        end
    else
        Buy = Item_None:FindFirstChild( "Buy", true )
    end
else
    Buy = Upvalue17[ TabName ]
end

Refresh( "Effects", Buy )
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

local Categories = Upvalue1.Categories
local Find = table.find( Categories, Upvalue2 and Upvalue2.cat ) or 1
Upvalue3( Upvalue1.Categories[ ( Find - 1 + Argument1 ) % #Upvalue1.Categories + 1 ], true )
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.IsOpen then
    Upvalue2( Upvalue3 )
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1.WardrobeOpen == true then
    Flag = true
elseif Upvalue2:GetAttribute( "InWardrobe" ) == true then
    Flag = true
elseif Upvalue1.BetaReveal == true then
    Flag = true
elseif Upvalue1.Downed == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #36 has no emitted closure site
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
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "get" )

if Success and type( Result ) == "table" then
    Upvalue2 = Result
end
if Upvalue3 then
    local Cat2

    if Upvalue5 then
        local Cat = Upvalue5.cat

        if Cat then
            Cat2 = Cat
        else
            Cat2 = Upvalue6.Categories[ 1 ]
        end
    else
        Cat2 = Upvalue6.Categories[ 1 ]
    end

    Upvalue4( Cat2 )
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

local Cat2

if Upvalue2 then
    local Cat = Upvalue2.cat

    if Cat then
        Cat2 = Cat
    else
        Cat2 = Upvalue3.Categories[ 1 ]
    end
else
    Cat2 = Upvalue3.Categories[ 1 ]
end

return Upvalue1[ Cat2 ]
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( false )
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.IsOpen then
    local Categories = Upvalue2.Categories
    local Find = table.find( Categories, Upvalue3 and Upvalue3.cat ) or 1
    Upvalue4( Upvalue2.Categories[ ( Find - 1 + -1 ) % #Upvalue2.Categories + 1 ], true )
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.IsOpen then
    local Categories = Upvalue2.Categories
    local Find = table.find( Categories, Upvalue3 and Upvalue3.cat ) or 1
    Upvalue4( Upvalue2.Categories[ ( Find - 1 + 1 ) % #Upvalue2.Categories + 1 ], true )
end
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

if EffectsOpen == Upvalue1 then
    return
end
if EffectsOpen then
    local Flag

    if Upvalue2.WardrobeOpen == true then
        Flag = true
    elseif Upvalue3:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    elseif Upvalue2.BetaReveal == true then
        Flag = true
    elseif Upvalue2.Downed == true then
        Flag = true
    else
        Flag = false
    end
    if Flag then
        if not Upvalue2.Downed then
            Upvalue4.Error( "You can't open the effects in the wardrobe" )
        end

        return
    end
end

Upvalue1 = EffectsOpen
Upvalue2.EffectsOpen = EffectsOpen
Upvalue5:Close( )

if not EffectsOpen then
    if Upvalue6 then
        Upvalue6 = nil
        Upvalue7.Visible = false
        Upvalue8.Stop( )
        Upvalue9.Close( "EffectsShowcase" )
    end
end

Upvalue10.Enabled = EffectsOpen

if Upvalue11 then
    Upvalue11:Cancel( )
    Upvalue11 = nil
end
if Upvalue12 then
    if not EffectsOpen or Argument2 then
        Upvalue12.Scale = 1
    else
        Upvalue12.Scale = 0.92
        Upvalue11 = Upvalue13:Create( Upvalue12, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
        Upvalue11:Play( )
    end
end
if EffectsOpen then
    Upvalue2.ActiveMenu = "Effects"
end

Upvalue2.CursorFree = EffectsOpen

if not EffectsOpen then
    Upvalue9.Close( "Effects" )
    return
end

local Icon
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

task.spawn( function()
    local Success, Result = pcall( Upvalue15.InvokeServer, Upvalue15, "get" )

    if Success and type( Result ) == "table" then
        Upvalue16 = Result
    end
    if Upvalue1 then
        local Cat2

        if Upvalue18 then
            local Cat = Upvalue18.cat

            if Cat then
                Cat2 = Cat
            else
                Cat2 = Upvalue19.Categories[ 1 ]
            end
        else
            Cat2 = Upvalue19.Categories[ 1 ]
        end

        Upvalue17( Cat2 )
    end
end )
Upvalue9.Open( "Effects", {
    root = Upvalue20,
    first = function()
        local Cat2

        if Upvalue18 then
            local Cat = Upvalue18.cat

            if Cat then
                Cat2 = Cat
            else
                Cat2 = Upvalue19.Categories[ 1 ]
            end
        else
            Cat2 = Upvalue19.Categories[ 1 ]
        end

        return Upvalue21[ Cat2 ]
    end,
    onBack = function()
        Upvalue22( false )
    end,
    tabs = {
        prev = function()
            if not Upvalue5.IsOpen then
                local Categories = Upvalue19.Categories
                local Find = table.find( Categories, Upvalue18 and Upvalue18.cat ) or 1
                Upvalue17( Upvalue19.Categories[ ( Find - 1 + -1 ) % #Upvalue19.Categories + 1 ], true )
            end
        end,
        next = function()
            if not Upvalue5.IsOpen then
                local Categories = Upvalue19.Categories
                local Find = table.find( Categories, Upvalue18 and Upvalue18.cat ) or 1
                Upvalue17( Upvalue19.Categories[ ( Find - 1 + 1 ) % #Upvalue19.Categories + 1 ], true )
            end
        end,
        label = "Category"
    }
} )
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if Upvalue1 == false then
        return
    end

    Upvalue1 = false
    Upvalue2.EffectsOpen = false
    Upvalue3:Close( )

    if Upvalue4 then
        Upvalue4 = nil
        Upvalue5.Visible = false
        Upvalue6.Stop( )
        Upvalue7.Close( "EffectsShowcase" )
    end

    Upvalue8.Enabled = false

    if Upvalue9 then
        Upvalue9:Cancel( )
        Upvalue9 = nil
    end
    if Upvalue10 then
        Upvalue10.Scale = 1
    end

    Upvalue2.CursorFree = false
    Upvalue7.Close( "Effects" )
    return
end
local IsShown2
local IsShown = Upvalue11.IsShown( "ShopMenu" )

if IsShown then
    if Upvalue2.CloseShop == nil then
        IsShown2 = false
    else
        IsShown2 = true
    end
else
    IsShown2 = IsShown
end
if IsShown2 then
    Upvalue2.CloseShop( )
end

Upvalue12( true, IsShown2 )

if IsShown2 and not Upvalue1 and Upvalue2.OpenShop then
    Upvalue2.OpenShop( true )
end

return
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 or not Upvalue1.Is( "Effects", Argument1 ) then
    return
end
Upvalue2( )
return
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == false then
    return
end

Upvalue1 = false
Upvalue2.EffectsOpen = false
Upvalue3:Close( )

if Upvalue4 then
    Upvalue4 = nil
    Upvalue5.Visible = false
    Upvalue6.Stop( )
    Upvalue7.Close( "EffectsShowcase" )
end

Upvalue8.Enabled = false

if Upvalue9 then
    Upvalue9:Cancel( )
    Upvalue9 = nil
end
if Upvalue10 then
    Upvalue10.Scale = 1
end

Upvalue2.CursorFree = false
Upvalue7.Close( "Effects" )
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( true, Argument1 )
return Upvalue2
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == false then
    return
end

Upvalue1 = false
Upvalue2.EffectsOpen = false
Upvalue3:Close( )

if Upvalue4 then
    Upvalue4 = nil
    Upvalue5.Visible = false
    Upvalue6.Stop( )
    Upvalue7.Close( "EffectsShowcase" )
end

Upvalue8.Enabled = false

if Upvalue9 then
    Upvalue9:Cancel( )
    Upvalue9 = nil
end
if Upvalue10 then
    Upvalue10.Scale = 1
end

Upvalue2.CursorFree = false
Upvalue7.Close( "Effects" )
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2.OpenShop then
    return
end
if Upvalue1 ~= false then
    Upvalue1 = false
    Upvalue2.EffectsOpen = false
    Upvalue3:Close( )

    if Upvalue4 then
        Upvalue4 = nil
        Upvalue5.Visible = false
        Upvalue6.Stop( )
        Upvalue7.Close( "EffectsShowcase" )
    end

    Upvalue8.Enabled = false

    if Upvalue9 then
        Upvalue9:Cancel( )
        Upvalue9 = nil
    end
    if Upvalue10 then
        Upvalue10.Scale = 1
    end

    Upvalue2.CursorFree = false
    Upvalue7.Close( "Effects" )
end
if not Upvalue2.OpenShop( true ) then
    Upvalue11( true, true )
end
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2.OpenShop then
    return
end
if Upvalue1 ~= false then
    Upvalue1 = false
    Upvalue2.EffectsOpen = false
    Upvalue3:Close( )

    if Upvalue4 then
        Upvalue4 = nil
        Upvalue5.Visible = false
        Upvalue6.Stop( )
        Upvalue7.Close( "EffectsShowcase" )
    end

    Upvalue8.Enabled = false

    if Upvalue9 then
        Upvalue9:Cancel( )
        Upvalue9 = nil
    end
    if Upvalue10 then
        Upvalue10.Scale = 1
    end

    Upvalue2.CursorFree = false
    Upvalue7.Close( "Effects" )
end
if not Upvalue2.OpenShop( true ) then
    Upvalue11( true, true )
end
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while not Upvalue1.SettingsLoaded do
    if not ( os.clock( ) - Clock < 20 ) then
        break
    end

    task.wait( 0.2 )
end
if Upvalue1.Settings.NoSky == true then
    Upvalue1.Set( "NoSky", false )
end
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "Sky" and Argument3 ~= true then
    task.spawn( function()
        local Clock = os.clock( )

        while not Upvalue1.SettingsLoaded do
            if not ( os.clock( ) - Clock < 20 ) then
                break
            end

            task.wait( 0.2 )
        end
        if Upvalue1.Settings.NoSky == true then
            Upvalue1.Set( "NoSky", false )
        end
    end )
end

local Success, Result = pcall( Upvalue2.InvokeServer, Upvalue2, "get" )

if Success and type( Result ) == "table" then
    Upvalue3 = Result
end

local Value1
local Categories = Upvalue4.Categories
Value1 = nil

for Key, Value in Categories, nil, nil do
    local Entry4
    local Entry = Upvalue4.Items[ Value.id ]
    Entry4 = if Entry then Entry else { }
    local Value2 = nil

    for Key2, Value3 in Entry4, nil, nil do
        if Value3.ProductId then
            local Entry3
            local Entry2 = Upvalue3.owned[ Value.id ]
            Entry3 = if Entry2 then Entry2 else { }

            if Entry3[ Value3.id ] then
                Upvalue5.Done( Value3.ProductId )
            end
        end
    end
end
if Upvalue6 and not Upvalue7.IsOpen and Upvalue8.Enabled and Upvalue9 then
    Upvalue9.redraw( )
end
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if Upvalue2 then
        return
    end

    Upvalue2 = true
    task.delay( 0.05, function()
        Upvalue2 = false

        if not Upvalue3.IsOpen and Upvalue4.Enabled and Upvalue5 then
            Upvalue5.redraw( )
        end
    end )
end
]]

--[[
Function #53 has no emitted closure site
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
Function #54 has no emitted closure site
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
Function #55 has no emitted closure site
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
elseif Upvalue2.Downed == true then
    Flag = true
else
    Flag = false
end
if not Flag and Upvalue2.ActiveMenu == "Effects" then
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
Upvalue2.EffectsOpen = false
Upvalue5:Close( )

if Upvalue6 then
    Upvalue6 = nil
    Upvalue7.Visible = false
    Upvalue8.Stop( )
    Upvalue9.Close( "EffectsShowcase" )
end

Upvalue10.Enabled = false

if Upvalue11 then
    Upvalue11:Cancel( )
    Upvalue11 = nil
end
if Upvalue12 then
    Upvalue12.Scale = 1
end

Upvalue2.CursorFree = false
Upvalue9.Close( "Effects" )
]]
