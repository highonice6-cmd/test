-- Players.perkbrokeyou.PlayerScripts.HotbarClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #53

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local I = 1

for I = 1, 20 do
    if pcall( Upvalue1.SetCoreGuiEnabled, Upvalue1, Enum.CoreGuiType.Backpack, false ) then
        return
    end

    task.wait( 0.5 )
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
local Play = Upvalue1.Play
Text = ( not Object or not Object:GetAttribute( "Weapon" ) ) and "ItemSwitch" or "WeaponSwitch"
Play( Text )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Error( "This weapon is broken: repair it first" )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsBroken( Object ) then
    return true
end
if Object:GetAttribute( "Weapon" ) or Object:GetAttribute( "Melee" ) then
    local Humanoid
    local Character = Upvalue2.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid

    if Character2 and Character2:GetAttribute( "NoWeapons" ) then
        return true
    end
end

local Entry = Upvalue3[ Object:GetAttribute( "Weapon" ) ]

if not Entry or not Entry.Fire or Entry.Fire.Mode ~= "Rocket" then
    return false
end

local Humanoid2
local Character3 = Upvalue2.Character

if Character3 then
    Humanoid2 = Character3:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid2 = Character3
end

local Character4 = if Humanoid2 then Humanoid2.SeatPart else Humanoid2
local Model

if Character4 then
    Model = Character4:FindFirstAncestorWhichIsA( "Model" )
else
    Model = Character4
end

local HasTag

if Model == nil then
    HasTag = false
else
    HasTag = Upvalue4:HasTag( Model, "Vehicle" )
end

return HasTag
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end
if not Humanoid or Humanoid.Health <= 0 then
    return nil
end
if Character:GetAttribute( "Downed" ) then
    return nil
end
if Character:GetAttribute( "CarRagdoll" ) then
    return nil
end
if Upvalue2.WardrobeOpen or Upvalue1:GetAttribute( "InWardrobe" ) == true or Upvalue2.BetaReveal then
    return nil
end
return Character, Humanoid
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local CarId2
local InvokeServer = Upvalue1.InvokeServer
local CarId = Upvalue2:GetAttribute( "CarId" )
CarId2 = if CarId then CarId else Upvalue2:GetAttribute( "Vehicle" )
local Success, Result = pcall( InvokeServer, Upvalue1, "Spawn", CarId2 )

if not Success or type( Result ) ~= "table" or not Result.ok then
    local Err
    local Error = Upvalue3.Error
    Err = type( Result ) == "table" and Result.err or "Error"
    Error( Err )
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Spectating and Upvalue1.HotbarViewUid then
    return
end

Upvalue2 = nil
local Value1, Value2 = Upvalue3( )

if not Value1 then
    return
end
if SlotName == 1 then
    local Flag = Value1:FindFirstChildOfClass( "Tool" ) ~= nil and true or false

    if not Upvalue1.FistsSelected or Flag then
        Value2:UnequipTools( )
        Upvalue1.FistsSelected = true
        Upvalue4.Play( "ItemSwitch" )
    else
        Upvalue1.FistsSelected = false
    end

    Upvalue5( )
    return
end
local Entry = Upvalue6.Layout( )[ SlotName ]

if not Entry then
    return
end
if not Entry:GetAttribute( "Vehicle" ) then
    if Entry.Parent == Value1 then
        Value2:UnequipTools( )
        return
    end
    if Upvalue6.IsBroken( Entry ) then
        Upvalue8.Error( "This weapon is broken: repair it first" )
        return
    end
    if not Upvalue9( Entry ) then
        local Text
        Value2:EquipTool( Entry )
        local Play = Upvalue4.Play
        Text = ( not Entry or not Entry:GetAttribute( "Weapon" ) ) and "ItemSwitch" or "WeaponSwitch"
        Play( Text )
    end

    return
end
local CarItem
local Remotes = Upvalue7:FindFirstChild( "Remotes" )

if Remotes then
    CarItem = Upvalue7.Remotes:FindFirstChild( "CarItem" )
else
    CarItem = Remotes
end
if CarItem then
    task.spawn( function()
        local CarId2
        local InvokeServer = CarItem.InvokeServer
        local CarId = Entry:GetAttribute( "CarId" )
        CarId2 = if CarId then CarId else Entry:GetAttribute( "Vehicle" )
        local Success, Result = pcall( InvokeServer, CarItem, "Spawn", CarId2 )

        if not Success or type( Result ) ~= "table" or not Result.ok then
            local Err
            local Error = Upvalue8.Error
            Err = type( Result ) == "table" and Result.err or "Error"
            Error( Err )
        end
    end )
    return
end
return
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Fire2
local Fire = Upvalue1.Actions.Fire
Fire2 = if Fire then Upvalue1.Actions.Fire.pad else Fire

if Fire2 and Fire2[ 1 ] then
    local KeyName3
    local KeyName = Upvalue1.KeyName
    local KeyName2 = KeyName( Fire2[ 1 ].Name, true )
    KeyName3 = if KeyName2 then KeyName2 else Upvalue2
    Upvalue2 = KeyName3
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Spectating and Upvalue1.HotbarViewUid then
    return
end

local Value1, Value2 = Upvalue2( )

if not Value1 then
    return
end

local Number
local Layout = Upvalue3.Layout( )

if Upvalue1.FistsSelected then
    Number = 1
else
    Number = 0
end

local I = 1

for I = 1, 5 do
    if Layout[ I ] and Layout[ I ].Parent == Value1 then
        Number = I
    end
end
if Number == 0 and Upvalue4 and Layout[ Upvalue4 ] and Layout[ Upvalue4 ]:GetAttribute( "Vehicle" ) then
    Number = Upvalue4
end

local I2 = 1

for I2 = 1, 5 do
    local Number2 = ( Number - 1 + Argument1 * I2 ) % 5 + 1

    if Number2 == 1 then
        Upvalue4 = nil

        if Number ~= 1 then
            Value2:UnequipTools( )
        end

        Upvalue1.FistsSelected = true
        Upvalue5.Play( "ItemSwitch" )
        Upvalue6( )
        return
    end
    local Entry = Layout[ Number2 ]

    if Entry and Entry:GetAttribute( "Vehicle" ) then
        if Value1:FindFirstChildOfClass( "Tool" ) then
            Value2:UnequipTools( )
        end

        local DisplayName2
        Upvalue1.FistsSelected = false
        Upvalue4 = Number2
        pcall( Upvalue7, nil )
        local Text = "RT"
        pcall( function()
            local Fire2
            local Fire = Upvalue8.Actions.Fire
            Fire2 = if Fire then Upvalue8.Actions.Fire.pad else Fire

            if Fire2 and Fire2[ 1 ] then
                local KeyName3
                local KeyName = Upvalue8.KeyName
                local KeyName2 = KeyName( Fire2[ 1 ].Name, true )
                KeyName3 = if KeyName2 then KeyName2 else Text
                Text = KeyName3
            end
        end )
        local Pickup = Upvalue9.Pickup
        local DisplayName = Entry:GetAttribute( "DisplayName" )
        DisplayName2 = if DisplayName then DisplayName else Entry.Name
        local Format = ( "%s · Spawn %s" ):format( Text, ( tostring( DisplayName2 ) ) )
        pcall( Pickup, Format, Color3.fromRGB( 235, 235, 240 ) )
        Upvalue6( )
        return
    end
    if Entry and Entry.Parent ~= Value1 and not Upvalue10( Entry ) and not Entry:GetAttribute( "Vehicle" ) then
        local Text2
        Upvalue4 = nil
        Value2:EquipTool( Entry )
        local Play = Upvalue5.Play
        Text2 = ( not Entry or not Entry:GetAttribute( "Weapon" ) ) and "ItemSwitch" or "WeaponSwitch"
        Play( Text2 )
        return
    end
end
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1.CaseRolling == true and true or false

if Flag ~= Upvalue2 then
    Upvalue2 = Flag
    Upvalue3.Visible = not Flag
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Self:GetChildren( ) do
    if Value:IsA( "UIGradient" ) then
        if Value.Enabled then
            return Value
        end
    end
end

return Self:FindFirstChildWhichIsA( "UIGradient" )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Icon = Object:WaitForChild( "Icon" )
return { pos = Icon.Position, size = Icon.Size, anchor = Icon.AnchorPoint }
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1[ Key ] then
    local Entry2
    local Entry = Upvalue2.TILE_GRAD[ Key ]
    Entry2 = if Entry then Entry else Upvalue2.TILE_GRAD.gun
    local Keypoints = Entry2.Keypoints
    local Value = Keypoints[ 1 ].Value
    local Value2 = Keypoints[ #Keypoints ].Value
    Upvalue1[ Key ] = ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Value2 ),
        ColorSequenceKeypoint.new( Upvalue3, Value ),
        ColorSequenceKeypoint.new( 1, Value2 )
    } )
end

return Upvalue1[ Key ]
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1( )
end
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Text = not Argument2 and "item" or "weapon"
local IconScale2
local Entry = Upvalue1[ Text ]
local PlaceIcon = Upvalue2.PlaceIcon
local Art = Argument1.art
local Anchor = Entry.anchor
local Pos = Entry.pos
local Size = Entry.size

if Argument3 then
    local IconScale = Upvalue2.IconScale( Argument3 )

    if IconScale then
        IconScale2 = IconScale
    else
        IconScale2 = 1
    end
else
    IconScale2 = 1
end

PlaceIcon( Art, Anchor, Pos, Size, IconScale2 )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if not Argument1 then
    return
end

local Visible
local Glyph, Glyph2 = Upvalue1.Glyph( Argument2 )
local Icon = Argument1.Icon
Icon.Image = Glyph or ""
local Icon2 = Argument1.Icon
Visible = Glyph ~= nil and true or false
local Visible2
Icon2.Visible = Visible
local Text = Argument1.Text
Text.Text = Glyph2 or ""
local Text2 = Argument1.Text
Visible2 = Glyph == nil and true or false
Text2.Visible = Visible2
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1.Actions[ Key ]
Entry2 = if Entry then Upvalue1.Actions[ Key ].pad else Entry
local Entry3 = if Entry2 then Entry2[ 1 ] else Entry2
return Entry3
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Vehicle = Upvalue1.Vehicle

if Vehicle == nil then
    Flag = false
elseif Vehicle.Driver == true then
    Flag = true
else
    Flag = false
end

local Text = not Visible and "k" or "p"
local Text2 = not Flag and "" or "d"
Upvalue2 = Text .. Text2

if Upvalue3 then
    Upvalue3.Visible = Visible and not Flag
end
if Upvalue4 then
    Upvalue4.Visible = Visible
end
if Visible then
    local HotbarPrev2

    local function PadOf( Key )
        local Entry2
        local Entry = Upvalue5.Actions[ Key ]
        Entry2 = if Entry then Upvalue5.Actions[ Key ].pad else Entry
        local Entry3 = if Entry2 then Entry2[ 1 ] else Entry2
        return Entry3
    end

    local HotbarPrev = Upvalue5.Actions.HotbarPrev
    HotbarPrev2 = if HotbarPrev then Upvalue5.Actions.HotbarPrev.pad else HotbarPrev
    local HotbarPrev3 = if HotbarPrev2 then HotbarPrev2[ 1 ] else HotbarPrev2

    if Upvalue3 then
        local Visible2
        local Glyph, Glyph2 = Upvalue5.Glyph( HotbarPrev3 )
        local Icon = Upvalue3.Icon
        Icon.Image = Glyph or ""
        local Icon2 = Upvalue3.Icon
        Visible2 = Glyph ~= nil and true or false
        local Visible3
        Icon2.Visible = Visible2
        local Text3 = Upvalue3.Text
        Text3.Text = Glyph2 or ""
        local Text4 = Upvalue3.Text
        Visible3 = Glyph == nil and true or false
        Text4.Visible = Visible3
    end

    local DriveSwap3

    if Flag then
        local DriveSwap2
        local DriveSwap = Upvalue5.Actions.DriveSwap
        DriveSwap2 = if DriveSwap then Upvalue5.Actions.DriveSwap.pad else DriveSwap

        if DriveSwap2 then
            DriveSwap3 = DriveSwap2[ 1 ]
        else
            DriveSwap3 = DriveSwap2
        end
        if not DriveSwap3 then
            local HotbarNext = Upvalue5.Actions.HotbarNext

            if HotbarNext then
                HotbarNext2 = Upvalue5.Actions.HotbarNext.pad
            else
                HotbarNext2 = HotbarNext
            end
            if HotbarNext2 then
                DriveSwap3 = HotbarNext2[ 1 ]
            else
                DriveSwap3 = HotbarNext2
            end
        end
    else
        local HotbarNext2
        local HotbarNext = Upvalue5.Actions.HotbarNext

        if HotbarNext then
            HotbarNext2 = Upvalue5.Actions.HotbarNext.pad
        else
            HotbarNext2 = HotbarNext
        end
        if HotbarNext2 then
            DriveSwap3 = HotbarNext2[ 1 ]
        else
            DriveSwap3 = HotbarNext2
        end
    end
    if Upvalue4 then
        local Visible4
        local Glyph3, Glyph22 = Upvalue5.Glyph( DriveSwap3 )
        local Icon3 = Upvalue4.Icon
        Icon3.Image = Glyph3 or ""
        local Icon4 = Upvalue4.Icon
        Visible4 = Glyph3 ~= nil and true or false
        local Visible5
        Icon4.Visible = Visible4
        local Text5 = Upvalue4.Text
        Text5.Text = Glyph22 or ""
        local Text6 = Upvalue4.Text
        Visible5 = Glyph3 == nil and true or false
        Text6.Visible = Visible5
    end
end

local Value1 = nil

for Key, Value in Upvalue6, nil, nil do
    local Key2 = Value.key
    Key2.Visible = not Visible
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2.IsGamepad )
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
local Vehicle = Upvalue1.Vehicle
Text = not Upvalue3.IsGamepad and "k" or "p"
local Text2 = ( not Vehicle or not Vehicle.Driver ) and "" or "d"

if Upvalue2 ~= Text .. Text2 then
    Upvalue4( Upvalue3.IsGamepad )
end
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Entry2
    local Table = { }
    local Entry = Upvalue2[ Key ]
    Entry2 = if Entry then Upvalue2[ Key ].key else Entry
    local Key2

    if Upvalue3 then
        local FoundChild = Upvalue3:FindFirstChild( "Case" .. Key )

        if FoundChild then
            Key2 = Upvalue3[ "Case" .. Key ]:FindFirstChild( "Key" )
        else
            Key2 = FoundChild
        end
    else
        Key2 = Upvalue3
    end

    local Value2
    Table[ 1 ] = Entry2
    Table[ 2 ] = Key2
    Value2 = nil

    for Key3, Value3 in Table, nil, nil do
        if Value3 then
            if Value3:IsA( "TextLabel" ) or Value3:IsA( "TextButton" ) then
                if Value3:GetAttribute( "BaseText" ) == nil then
                    Value3:SetAttribute( "BaseText", Value3.Text )
                end

                local Text

                if not Upvalue4.IsDefaultBind( "kbm", Value ) or not Value3:GetAttribute( "BaseText" ) then
                    local KeyName = Upvalue4.KeyName
                    Text = KeyName( Upvalue4.Binds( "kbm", Value )[ 1 ], true )
                else
                    Text = Value3:GetAttribute( "BaseText" )
                end

                Value3.Text = Text
            end
        end
    end
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil
Upvalue2( )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local ScaleTarget
local Grad = Argument1.grad
Grad.Color = Upvalue1( Argument3 )
ScaleTarget = not Argument2 and 1 or 1.12

if Argument1.scaleTarget ~= ScaleTarget then
    Argument1.scaleTarget = ScaleTarget
    Upvalue2:Create( Argument1.scale, Upvalue3, { Scale = ScaleTarget } ):Play( )
end

local TextColor3
local Key = Argument1.key
TextColor3 = Argument2 and Upvalue4 or Upvalue5
Key.TextColor3 = TextColor3
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

local Visible
local DurabilityFrac = Upvalue1.DurabilityFrac( Argument2 )
local AmmoBar = Argument1.ammoBar

if DurabilityFrac == nil then
    Visible = false
elseif DurabilityFrac > 0 then
    Visible = true
else
    Visible = false
end

AmmoBar.Visible = Visible

if DurabilityFrac then
    local AmmoBar2 = Argument1.ammoBar
    AmmoBar2.Size = UDim2.fromScale( Upvalue2 * DurabilityFrac, Upvalue3 )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = tonumber( ( Self:GetAttribute( "Kg" ) ) )

if Number then
    Upvalue1 = Upvalue1 or require( game:GetService( "ReplicatedStorage" ):WaitForChild( "LootShared" ) ).WeightText
    return Upvalue1( Number )
end
local Count = Self:GetAttribute( "Count" )

if Count and tostring( Self:GetAttribute( "Item" ) or "" ):sub( 1, 7 ) == "CashBag" and ( tonumber( Count ) or 1 ) <= 1 then
    return ""
end
if Count then
    return "x" .. Count
end

local Ammo = Self:GetAttribute( "Ammo" )
local MagSize = Self:GetAttribute( "MagSize" )

if not Self:GetAttribute( "Weapon" ) or Ammo == nil then
    return ""
end

local Text

if not MagSize or not ( Ammo .. "/" .. MagSize ) then
    Text = tostring( Ammo )
else
    Text = Ammo .. "/" .. MagSize
end

return Text
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local Vehicle = Object and Object:GetAttribute( "Vehicle" ) or nil
local Icon2
local CarArt = Upvalue1.CarArt
local Art = Argument1.art

if Object then
    local Icon = Upvalue1.Icon( Object )

    if Icon then
        Icon2 = Icon
    else
        Icon2 = nil
    end
else
    Icon2 = nil
end

CarArt( Art, Vehicle, Icon2 )
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local Remotes2
local Remotes = Upvalue1:WaitForChild( "Remotes", 60 )
Remotes2 = if Remotes then Remotes:WaitForChild( "HotbarShare", 60 ) else Remotes
Upvalue2 = Remotes2
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while not Upvalue1 do
    if not ( os.clock( ) - Clock < 60 ) then
        break
    end

    task.wait( 1 )
end

Upvalue2 = false

if Upvalue1 and Upvalue3 and Upvalue3 ~= Upvalue4 then
    Upvalue4 = Upvalue3
    Upvalue1:FireServer( Upvalue3 )
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { h = Upvalue1 or 0, f = Argument2 or nil, s = { } }
local I = 2

for I = 2, 5 do
    local Entry = List[ I ]

    if Entry then
        local Value1
        local Table2 = { }
        Value1 = nil

        for Key, Value in Upvalue2, nil, nil do
            local Attribute = Entry:GetAttribute( Value )
            local Kind = type( Attribute )

            if Kind ~= "number" and Kind ~= "boolean" then
                if Kind ~= "string" or not ( #Attribute <= 40 ) then
                    continue
                end
            end

            Table2[ Value ] = Attribute
        end

        local S = Table.s
        S[ tostring( I ) ] = Table2
    end
end

local Success, Result = pcall( Upvalue3.JSONEncode, Upvalue3, Table )

if not Success or Result == Upvalue4 then
    return
end

Upvalue5 = Result

if Upvalue6 then
    return
end
Upvalue6 = true
task.delay( 0.25, function()
    local Clock = os.clock( )

    while not Upvalue7 do
        if not ( os.clock( ) - Clock < 60 ) then
            break
        end

        task.wait( 1 )
    end

    Upvalue6 = false

    if Upvalue7 and Upvalue5 and Upvalue5 ~= Upvalue4 then
        Upvalue4 = Upvalue5
        Upvalue7:FireServer( Upvalue5 )
    end
end )
return
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1.Spectating == true then
    if Upvalue1.HotbarViewUid == nil then
        Flag = false
    else
        Flag = true
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

local HotbarViewJson = Upvalue1.HotbarViewJson

if HotbarViewJson ~= Upvalue2 then
    local HotbarViewJson2
    Upvalue2 = HotbarViewJson
    local JSONDecode = Upvalue3.JSONDecode
    HotbarViewJson2 = type( HotbarViewJson ) == "string" and HotbarViewJson or ""
    local Result2
    local Success, Result = pcall( JSONDecode, Upvalue3, HotbarViewJson2 )
    Result2 = Success and type( Result ) == "table" and Result or nil
    Upvalue4 = Result2
end

return Upvalue4
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local PlayerByUserId2
local PlayerByUserId = Upvalue1:GetPlayerByUserId( Upvalue2.HotbarViewUid or 0 )
PlayerByUserId2 = if PlayerByUserId then PlayerByUserId.Character else PlayerByUserId
local PlayerByUserId3 = if PlayerByUserId2 then PlayerByUserId2:FindFirstChildOfClass( "Tool" ) else PlayerByUserId2
return PlayerByUserId3
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1[ Key ]
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

return {
    GetAttribute = function( Argument1Inner, Key )
        return Argument1[ Key ]
    end
}
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil
local HotbarViewJson = Upvalue2.HotbarViewJson

if HotbarViewJson ~= Upvalue3 then
    local HotbarViewJson2
    Upvalue3 = HotbarViewJson
    local JSONDecode = Upvalue4.JSONDecode
    HotbarViewJson2 = type( HotbarViewJson ) == "string" and HotbarViewJson or ""
    local Result2
    local Success, Result = pcall( JSONDecode, Upvalue4, HotbarViewJson2 )
    Result2 = Success and type( Result ) == "table" and Result or nil
    Upvalue5 = Result2
end

local PlayerByUserId2
local PlayerByUserId = Upvalue6:GetPlayerByUserId( Upvalue2.HotbarViewUid or 0 )
PlayerByUserId2 = if PlayerByUserId then PlayerByUserId.Character else PlayerByUserId
local Tool

if PlayerByUserId2 then
    Tool = PlayerByUserId2:FindFirstChildOfClass( "Tool" )
else
    Tool = PlayerByUserId2
end

local Number2

if Upvalue5 then
    local Number = tonumber( Upvalue5.h )

    if Number then
        Number2 = Number
    else
        Number2 = 0
    end
else
    Number2 = 0
end

local Flag
Upvalue7[ 1 ].holder.Visible = true
local Item = Upvalue7[ 1 ]

if Upvalue5 == nil then
    Flag = false
elseif Upvalue5.f == true then
    if Tool == nil then
        Flag = true
    else
        Flag = false
    end
else
    Flag = false
end

local Value1
Upvalue8( Item, Flag, "fist" )
Value1 = nil

for Key, Value in Upvalue7, nil, nil do
    if Key ~= 1 then
        local Entry2

        if not Upvalue5 or type( Upvalue5.s ) ~= "table" then
            Entry2 = nil
        else
            local Entry = Upvalue5.s[ tostring( Key ) ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = nil
            end
        end

        local Table2

        if type( Entry2 ) == "table" then
            local Table = {
                GetAttribute = function( Argument1, Key )
                    return Entry2[ Key ]
                end
            }

            if Table then
                Table2 = Table
            else
                Table2 = nil
            end
        else
            Table2 = nil
        end
        if Table2 and Key == Number2 and Tool then
            Table2 = Tool
        end

        local Visible
        local Holder = Value.holder
        Visible = Table2 ~= nil and true or false
        Holder.Visible = Visible
        Upvalue9[ Key ] = Table2

        if Table2 then
            local Vehicle
            local Weapon = Table2:GetAttribute( "Weapon" )

            if Weapon then
                Vehicle = Weapon
            else
                local Melee = Table2:GetAttribute( "Melee" )

                if Melee then
                    Vehicle = Melee
                else
                    Vehicle = Table2:GetAttribute( "Vehicle" )
                end
            end

            local Flag2 = Vehicle ~= nil and true or false
            local Text = not Flag2 and "item" or "weapon"
            local IconScale2
            local Entry3 = Upvalue10[ Text ]
            local PlaceIcon = Upvalue11.PlaceIcon
            local Art = Value.art
            local Anchor = Entry3.anchor
            local Pos = Entry3.pos
            local Size = Entry3.size

            if Table2 then
                local IconScale = Upvalue11.IconScale( Table2 )

                if IconScale then
                    IconScale2 = IconScale
                else
                    IconScale2 = 1
                end
            else
                IconScale2 = 1
            end

            local ImageTransparency
            PlaceIcon( Art, Anchor, Pos, Size, IconScale2 )
            Upvalue11.SetIcon( Value.art, Upvalue11.Icon( Table2 ) )
            local Visible2 = Upvalue12.IsBroken( Table2 )
            local Art2 = Value.art
            ImageTransparency = not Visible2 and 0 or 0.65
            local TextTransparency
            Art2.ImageTransparency = ImageTransparency
            local Ammo = Value.ammo
            Ammo.Text = Upvalue13( Table2 )
            local Ammo2 = Value.ammo
            TextTransparency = not Visible2 and 0 or 0.6
            local Visible3
            Ammo2.TextTransparency = TextTransparency
            local DurabilityFrac = Upvalue11.DurabilityFrac( Table2 )
            local AmmoBar = Value.ammoBar

            if DurabilityFrac == nil then
                Visible3 = false
            elseif DurabilityFrac > 0 then
                Visible3 = true
            else
                Visible3 = false
            end

            AmmoBar.Visible = Visible3

            if DurabilityFrac then
                local AmmoBar2 = Value.ammoBar
                AmmoBar2.Size = UDim2.fromScale( Upvalue14 * DurabilityFrac, Upvalue15 )
            end

            local Flag3

            if Key == Number2 then
                if Tool == nil then
                    Flag3 = false
                else
                    Flag3 = true
                end
            else
                Flag3 = false
            end

            Upvalue8( Value, Flag3, Upvalue11.Category( Table2 ) )

            if Value.broken then
                Value.broken.Visible = Visible2
            end
        end

        local Vehicle2 = Table2 and Table2:GetAttribute( "Vehicle" ) or nil
        local Icon2
        local CarArt = Upvalue11.CarArt
        local Art3 = Value.art

        if Table2 then
            local Icon = Upvalue11.Icon( Table2 )

            if Icon then
                Icon2 = Icon
            else
                Icon2 = nil
            end
        else
            Icon2 = nil
        end

        CarArt( Art3, Vehicle2, Icon2 )
    end
end
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1.Spectating == true then
    if Upvalue1.HotbarViewUid == nil then
        Flag = false
    else
        Flag = true
    end
else
    Flag = false
end
if Flag then
    Upvalue2( )
    return
end

local Layout = Upvalue3.Layout( )
local Character = Upvalue4.Character
Upvalue5 = nil

if Upvalue6 then
    if not Layout[ Upvalue6 ] or not Layout[ Upvalue6 ]:GetAttribute( "Vehicle" ) then
        Upvalue6 = nil
    end
end

local Flag2

if Character == nil then
    Flag2 = false
elseif Character:FindFirstChildOfClass( "Tool" ) == nil then
    Flag2 = false
else
    Flag2 = true
end

local FistsSelected2
local Item = Upvalue7[ 1 ]
Item.holder.Visible = true
local FistsSelected = Upvalue1.FistsSelected
FistsSelected2 = if FistsSelected then not Flag2 else FistsSelected
local Value1
Upvalue8( Item, FistsSelected2, "fist" )
Value1 = nil

for Key, Value in Upvalue7, nil, nil do
    if Key ~= 1 then
        local Visible
        local Entry = Layout[ Key ]
        local Holder = Value.holder
        Visible = Entry ~= nil and true or false
        Holder.Visible = Visible
        Upvalue9[ Key ] = Entry

        if Entry then
            local Vehicle
            local Weapon = Entry:GetAttribute( "Weapon" )

            if Weapon then
                Vehicle = Weapon
            else
                local Melee = Entry:GetAttribute( "Melee" )

                if Melee then
                    Vehicle = Melee
                else
                    Vehicle = Entry:GetAttribute( "Vehicle" )
                end
            end

            local Flag3 = Vehicle ~= nil and true or false
            local Text = not Flag3 and "item" or "weapon"
            local IconScale2
            local Entry2 = Upvalue10[ Text ]
            local PlaceIcon = Upvalue11.PlaceIcon
            local Art = Value.art
            local Anchor = Entry2.anchor
            local Pos = Entry2.pos
            local Size = Entry2.size

            if Entry then
                local IconScale = Upvalue11.IconScale( Entry )

                if IconScale then
                    IconScale2 = IconScale
                else
                    IconScale2 = 1
                end
            else
                IconScale2 = 1
            end

            local ImageTransparency
            PlaceIcon( Art, Anchor, Pos, Size, IconScale2 )
            Upvalue11.SetIcon( Value.art, Upvalue11.Icon( Entry ) )
            local Value2 = Upvalue12( Entry )
            local Art2 = Value.art
            ImageTransparency = not Value2 and 0 or 0.65
            local TextTransparency
            Art2.ImageTransparency = ImageTransparency
            local Ammo = Value.ammo
            Ammo.Text = Upvalue13( Entry )
            local Ammo2 = Value.ammo
            TextTransparency = not Value2 and 0 or 0.6
            local Visible2
            Ammo2.TextTransparency = TextTransparency
            local DurabilityFrac = Upvalue11.DurabilityFrac( Entry )
            local AmmoBar = Value.ammoBar

            if DurabilityFrac == nil then
                Visible2 = false
            elseif DurabilityFrac > 0 then
                Visible2 = true
            else
                Visible2 = false
            end

            AmmoBar.Visible = Visible2

            if DurabilityFrac then
                local AmmoBar2 = Value.ammoBar
                AmmoBar2.Size = UDim2.fromScale( Upvalue14 * DurabilityFrac, Upvalue15 )
            end

            local Flag4

            if Entry.Parent == Character then
                Flag4 = true
            elseif Upvalue6 == Key then
                Flag4 = not Flag2
            else
                Flag4 = false
            end

            Upvalue8( Value, Flag4, Upvalue11.Category( Entry ) )

            if Value.broken then
                local Broken = Value.broken
                Broken.Visible = Upvalue3.IsBroken( Entry )
            end
            if Entry.Parent == Character then
                Upvalue5 = Key
            end
        end

        local Vehicle2 = Entry and Entry:GetAttribute( "Vehicle" ) or nil
        local Icon2
        local CarArt = Upvalue11.CarArt
        local Art3 = Value.art

        if Entry then
            local Icon = Upvalue11.Icon( Entry )

            if Icon then
                Icon2 = Icon
            else
                Icon2 = nil
            end
        else
            Icon2 = nil
        end

        CarArt( Art3, Vehicle2, Icon2 )
    end
end

local FistsSelected4
local FistsSelected3 = Upvalue1.FistsSelected
FistsSelected4 = if FistsSelected3 then not Flag2 else FistsSelected3
Upvalue16( Layout, FistsSelected4 )
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    local Flag
    task.wait( 0.1 )

    if Upvalue1.Spectating == true then
        if Upvalue1.HotbarViewUid == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    local Text4

    if Flag then
        local PlayerByUserId2
        local Text = tostring( Upvalue1.HotbarViewUid )
        local Text2 = tostring( Upvalue1.HotbarViewJson )
        local PlayerByUserId = Upvalue2:GetPlayerByUserId( Upvalue1.HotbarViewUid or 0 )
        PlayerByUserId2 = if PlayerByUserId then PlayerByUserId.Character else PlayerByUserId
        local PlayerByUserId3 = if PlayerByUserId2 then PlayerByUserId2:FindFirstChildOfClass( "Tool" ) else PlayerByUserId2
        local Text3 = Text .. "|" .. Text2 .. "|" .. tostring( PlayerByUserId3 )

        if Text3 then
            Text4 = Text3
        else
            Text4 = "self"
        end
    else
        Text4 = "self"
    end
    if Text4 ~= Upvalue3 then
        Upvalue3 = Text4
        pcall( Upvalue4 )
    end

    local Value1 = nil

    for Key, Value in Upvalue5, nil, nil do
        local Entry = Upvalue6[ Key ]

        if Value and Entry then
            local Visible
            local Ammo = Entry.ammo
            Ammo.Text = Upvalue7( Value )
            local DurabilityFrac = Upvalue8.DurabilityFrac( Value )
            local AmmoBar = Entry.ammoBar

            if DurabilityFrac == nil then
                Visible = false
            elseif DurabilityFrac > 0 then
                Visible = true
            else
                Visible = false
            end

            AmmoBar.Visible = Visible

            if DurabilityFrac then
                local AmmoBar2 = Entry.ammoBar
                AmmoBar2.Size = UDim2.fromScale( Upvalue9 * DurabilityFrac, Upvalue10 )
            end
        end
    end
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1:GetAttribute( "Broken" ) == true then
    local Name
    local Entry = Upvalue2[ Upvalue1:GetAttribute( "Weapon" ) ]
    local Error = Upvalue3.Error
    Name = Entry and Entry.Name or Upvalue1.Name
    Error( Name .. " broke: repair it to use it again" )
end

Upvalue4( )
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if not BreakName:IsA( "Tool" ) or Upvalue1[ BreakName ] then
    return
end
Upvalue1[ BreakName ] = true
BreakName:GetAttributeChangedSignal( "Broken" ):Connect( function()
    if BreakName:GetAttribute( "Broken" ) == true then
        local Name
        local Entry = Upvalue2[ BreakName:GetAttribute( "Weapon" ) ]
        local Error = Upvalue3.Error
        Name = Entry and Entry.Name or BreakName.Name
        Error( Name .. " broke: repair it to use it again" )
    end

    Upvalue4( )
end )
return
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

Self.ChildAdded:Connect( Upvalue1 )
Self.ChildRemoved:Connect( Upvalue1 )
Self.ChildAdded:Connect( Upvalue2 )

for Key, Value in Self:GetChildren( ) do
    Upvalue2( Value )
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Backpack" ) then
    Upvalue1( Object )
    Upvalue2( )
end
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid = Object:WaitForChild( "Humanoid", 10 )

if Humanoid then
    Humanoid:GetPropertyChangedSignal( "SeatPart" ):Connect( Upvalue1 )
end
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

if Self:IsA( "Tool" ) and Upvalue1 then
    Upvalue1 = nil
    Upvalue2( )
end
if Self:IsA( "Tool" ) and Upvalue3.FistsSelected then
    Upvalue3.FistsSelected = false
    Upvalue2( )
end
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.ChildAdded:Connect( function( Self )
    if Self:IsA( "Tool" ) and Upvalue1 then
        Upvalue1 = nil
        Upvalue2( )
    end
    if Self:IsA( "Tool" ) and Upvalue3.FistsSelected then
        Upvalue3.FistsSelected = false
        Upvalue2( )
    end
end )
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

task.defer( Upvalue1 )
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.FistsSelected = false
Upvalue2 = nil
Upvalue3( Argument1 )
Argument1.ChildAdded:Connect( function( Self )
    if Self:IsA( "Tool" ) and Upvalue2 then
        Upvalue2 = nil
        Upvalue4( )
    end
    if Self:IsA( "Tool" ) and Upvalue1.FistsSelected then
        Upvalue1.FistsSelected = false
        Upvalue4( )
    end
end )
task.defer( Upvalue4 )
task.spawn( Upvalue5, Argument1 )
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

local Layout = Upvalue1.Layout( )
local HOTBAR = Upvalue1.HOTBAR
local I = 1

for I = 1, HOTBAR do
    local Entry = Layout[ I ]

    if Entry and Entry.Parent == Upvalue2:FindFirstChildOfClass( "Backpack" ) and Upvalue1.IsWeapon( Entry ) and not Upvalue1.IsBroken( Entry ) then
        return Entry
    end
end

return nil
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Value2 = Upvalue1( )

if not Value1 or Upvalue2[ Value1 ] then
    return
end
if Upvalue3:GetAttribute( "Onboarding" ) ~= false then
    return
end
if Value1:FindFirstChildOfClass( "Tool" ) then
    Upvalue2[ Value1 ] = true
    return
end

local Value3 = Upvalue4( )

if not Value3 or Upvalue5( Value3 ) then
    return
end
Upvalue2[ Value1 ] = true
Upvalue6.FistsSelected = false
Value2:EquipTool( Value3 )
Upvalue7( )
return
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while SpawnName.Parent do
    if Upvalue1.Character ~= SpawnName or Upvalue2[ SpawnName ] then
        break
    end
    if Upvalue1:GetAttribute( "Onboarding" ) ~= false then
        Clock = os.clock( )
    end
    if os.clock( ) - Clock > 15 then
        Upvalue2[ SpawnName ] = true
        return
    end
    if Upvalue3.FistsSelected then
        Upvalue2[ SpawnName ] = true
        return
    end

    Upvalue4( )
    task.wait( 0.25 )
end
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( Upvalue1, Argument1 )
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

local Tool
local Value1, Value2 = Upvalue2( )

if Value1 then
    Tool = Value1:FindFirstChildOfClass( "Tool" )
else
    Tool = Value1
end
if Upvalue1 and Tool then
    local Entry = Upvalue3.Layout( )[ Upvalue1 ]

    if Entry ~= Tool then
        if not Entry or Entry:GetAttribute( "Vehicle" ) or Upvalue4( Entry ) then
            Value2:UnequipTools( )
        else
            local Text
            Value2:EquipTool( Entry )
            local Play = Upvalue5.Play
            Text = ( not Entry or not Entry:GetAttribute( "Weapon" ) ) and "ItemSwitch" or "WeaponSwitch"
            Play( Text )
        end
    end
end

Upvalue6( )
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 then
    return
end
if Upvalue1 and Upvalue2.Is( "Fire", Argument1 ) then
    local Character = Upvalue3.Character

    if Character and not Character:FindFirstChildOfClass( "Tool" ) and not Upvalue4.FistsSelected then
        Upvalue5( Upvalue1 )
        Upvalue6( )
        return
    end
end

local Value1, Value2
Value1 = nil

for Key, Value in Upvalue7, nil, nil do
    if Upvalue2.Is( Value, Argument1 ) then
        Value2 = Key
        break
    end

    Value2 = nil
end
if Value2 then
    Upvalue5( Value2 )
    return
end

local Vehicle = Upvalue4.Vehicle

if Vehicle and Vehicle.Driver then
    return
end
if Upvalue2.Is( "HotbarNext", Argument1 ) then
    Upvalue8( 1 )
    return
end
if Upvalue2.Is( "HotbarPrev", Argument1 ) then
    Upvalue8( -1 )
end
]]
