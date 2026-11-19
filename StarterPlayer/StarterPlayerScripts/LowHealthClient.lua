-- StarterPlayer.StarterPlayerScripts.LowHealthClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local Parent = game:GetService( "Lighting" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Hurt = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Hurt" )
ClientState.DamageVignetteExternal = true
local LocalPlayer = Players.LocalPlayer
local Parent2 = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "LowHealth", math.huge )
local Table = { }
local Table2 = {
    "Oval",
    "Shade",
    "Pulse",
    "Crescent",
    "CrescentRim",
    "CrescentBurst",
    "Flash",
    "Probe"
}
Value1 = nil

for Key, Value in Table2, nil, nil do
    Table[ Value ] = Parent2:WaitForChild( Value )
end

local LowHealthGrade = Parent2:WaitForChild( "Effets" ):WaitForChild( "LowHealthGrade" )

local function Attr( Object, Attribute, Argument3 )
    local Attribute3
    local Attribute2 = Object:GetAttribute( Attribute )
    Attribute3 = typeof( Attribute2 ) == "Color3" and Attribute2 or Argument3
    return Attribute3
end

local Image = Table.Oval.Image
local Image2 = Table.Crescent.Image
local Image3 = Table.CrescentRim.Image
local ImageColor3 = Table.Oval.ImageColor3
local Oval = Table.Oval
local FromRGB = Color3.fromRGB( 80, 0, 0 )
local ColorDark = Oval:GetAttribute( "ColorDark" )

if typeof( ColorDark ) ~= "Color3" or not ColorDark then
else
    FromRGB = ColorDark
end

local Table3 = { 2.1, 1.32 }
local Table4 = { 0.25, 0.74 }
local Table5 = { from = 0.3, to = 0.05, scale = { 1.6, 1.38 }, opacity = 0.45 }
local Crescent = Table.Crescent
local FromRGB2 = Color3.fromRGB( 235, 25, 25 )
local HitColor = Crescent:GetAttribute( "HitColor" )

if typeof( HitColor ) ~= "Color3" or not HitColor then
else
    FromRGB2 = HitColor
end

local CrescentRim = Table.CrescentRim
local FromRGB3 = Color3.fromRGB( 255, 120, 100 )
local HitColor2 = CrescentRim:GetAttribute( "HitColor" )

if typeof( HitColor2 ) ~= "Color3" or not HitColor2 then
else
    FromRGB3 = HitColor2
end

local Crescent2 = Table.Crescent
local FromRGB4 = Color3.fromRGB( 40, 120, 255 )
local ArmorColor = Crescent2:GetAttribute( "ArmorColor" )

if typeof( ArmorColor ) ~= "Color3" or not ArmorColor then
else
    FromRGB4 = ArmorColor
end

local CrescentRim2 = Table.CrescentRim
local FromRGB5 = Color3.fromRGB( 150, 205, 255 )
local ArmorColor2 = CrescentRim2:GetAttribute( "ArmorColor" )

if typeof( ArmorColor2 ) ~= "Color3" or not ArmorColor2 then
else
    FromRGB5 = ArmorColor2
end

local CrescentRim3 = Table.CrescentRim
local FromRGB6 = Color3.fromRGB( 255, 240, 225 )
local HeadColor = CrescentRim3:GetAttribute( "HeadColor" )

if typeof( HeadColor ) ~= "Color3" or not HeadColor then
else
    FromRGB6 = HeadColor
end

local HitColor4
local HitColor3 = Table.Flash:GetAttribute( "HitColor" )
HitColor4 = typeof( HitColor3 ) == "Color3" and HitColor3 or FromRGB2
local ArmorColor4
local ArmorColor3 = Table.Flash:GetAttribute( "ArmorColor" )
ArmorColor4 = typeof( ArmorColor3 ) == "Color3" and ArmorColor3 or FromRGB4
local CrescentRim4 = Table.CrescentRim
local FromRGB7 = Color3.fromRGB( 215, 240, 255 )
local BreakColor = CrescentRim4:GetAttribute( "BreakColor" )

if typeof( BreakColor ) ~= "Color3" or not BreakColor then
else
    FromRGB7 = BreakColor
end

local Saturation = LowHealthGrade.Saturation
local Brightness = LowHealthGrade.Brightness
local Contrast = LowHealthGrade.Contrast
local TintColor = LowHealthGrade.TintColor
local CurrentCamera = workspace.CurrentCamera
Parent2.Enabled = true
local Table6 = { }
local Table7 = { }

local function Layer( Argument1 )
    Argument1.Visible = false
    table.insert( Table6, Argument1 )

    if Argument1.Image == Image then
        table.insert( Table7, Argument1 )
    end

    return Argument1
end

local Oval2 = Table.Oval
Oval2.Visible = false
table.insert( Table6, Oval2 )

if Oval2.Image == Image then
    table.insert( Table7, Oval2 )
end

local Shade = Table.Shade
Shade.Visible = false
table.insert( Table6, Shade )

if Shade.Image == Image then
    table.insert( Table7, Shade )
end

local Pulse = Table.Pulse
Pulse.Visible = false
table.insert( Table6, Pulse )

if Pulse.Image == Image then
    table.insert( Table7, Pulse )
end

local Table8 = { }
local I = 1

for I = 1, 4 do
    local Img

    local function Copy( Object )
        if I == 1 then
            return Object
        end
        local Clone = Object:Clone( )
        Clone.Name = Object.Name .. I
        Clone.Parent = Parent2
        return Clone
    end

    local Table9 = {
        t0 = -1000000000,
        last = -1000000000,
        dir = nil,
        power = 0,
        head = false,
        life = 1.6,
        breakAt = -1000000000
    }
    local Crescent3 = Table.Crescent

    if I == 1 then
        Img = Crescent3
    else
        local Clone = Crescent3:Clone( )
        Clone.Name = Crescent3.Name .. I
        Clone.Parent = Parent2
        Img = Clone
    end

    Img.Visible = false
    table.insert( Table6, Img )

    if Img.Image == Image then
        table.insert( Table7, Img )
    end

    local Edge
    Table9.img = Img
    local CrescentRim5 = Table.CrescentRim

    if I == 1 then
        Edge = CrescentRim5
    else
        local Clone2 = CrescentRim5:Clone( )
        Clone2.Name = CrescentRim5.Name .. I
        Clone2.Parent = Parent2
        Edge = Clone2
    end

    Edge.Visible = false
    table.insert( Table6, Edge )

    if Edge.Image == Image then
        table.insert( Table7, Edge )
    end

    local Burst
    Table9.edge = Edge
    local CrescentBurst = Table.CrescentBurst

    if I == 1 then
        Burst = CrescentBurst
    else
        local Clone3 = CrescentBurst:Clone( )
        Clone3.Name = CrescentBurst.Name .. I
        Clone3.Parent = Parent2
        Burst = Clone3
    end

    Burst.Visible = false
    table.insert( Table6, Burst )

    if Burst.Image == Image then
        table.insert( Table7, Burst )
    end

    Table9.burst = Burst
    Table8[ I ] = Table9
end

local Flash = Table.Flash
Flash.Visible = false
table.insert( Table6, Flash )

if Flash.Image == Image then
    table.insert( Table7, Flash )
end

local Table10 = { [ Image ] = false, [ Image2 ] = false, [ Image3 ] = false }
task.spawn( function()
    local Value1
    local ContentProvider = game:GetService( "ContentProvider" )
    local TableInner = {
        [ Image ] = Table.Oval,
        [ Image2 ] = Table.Crescent,
        [ Image3 ] = Table.CrescentRim
    }

    local function Probe( Key )
        local Entry = TableInner[ Key ]
        task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, { Entry or Key }, function( Argument1, Argument2 )
            if Argument2 == Enum.AssetFetchStatus.Success then
                Table10[ Key ] = true
            end
        end )
    end

    Value1 = nil

    for Value in Table10, nil, nil do
        Probe( Value )
    end

    local Clock = os.clock( )
    local Clock2 = os.clock( )

    while true do
        local Value2, Flag2
        Value2 = nil
        Flag2 = false

        for Key, Value3 in Table10, nil, nil do
            if not Value3 then
                local Success, Result = pcall( ContentProvider.GetAssetFetchStatus, ContentProvider, Key )

                if not Success or Result ~= Enum.AssetFetchStatus.Success then
                    Flag2 = true
                else
                    Table10[ Key ] = true
                end
            end
        end

        local Flag = os.clock( ) - Clock > 8 and true or false
        local ImageInner

        if Table10[ Image ] or not Flag then
            if Image then
                ImageInner = Image
            else
                ImageInner = "rbxassetid://12754479702"
            end
        else
            ImageInner = "rbxassetid://12754479702"
        end

        local Value4 = nil

        for Key2, Value5 in Table7, nil, nil do
            if Value5.Image ~= ImageInner then
                Value5.Image = ImageInner
            end
        end
        if not Flag2 then
            break
        end
        if os.clock( ) - Clock > 600 then
            local Value6
            local Table2 = { }
            Value6 = nil

            for Key3, Value7 in Table10, nil, nil do
                local Match = Key3:match( "%d+" )
                table.insert( Table2, Match .. "=" .. tostring( Value7 ) )
            end

            warn( "[LowHealth] textures du vignettage non chargées : " .. table.concat( Table2, ", " ) )
            return
        end
        if Flag and os.clock( ) - Clock2 > 20 then
            local Value8
            Clock2 = os.clock( )
            Value8 = nil

            for Key4, Value9 in Table10, nil, nil do
                if not Value9 then
                    Probe( Key4 )
                end
            end
        end

        task.wait( 0.5 )
    end
end )
local Clone4 = LowHealthGrade:Clone( )
Clone4.Enabled = false
Clone4.Parent = Parent

local function Lerp( Argument1, Argument2, Argument3 )
    return Argument1 + ( Argument2 - Argument1 ) * Argument3
end

local function Ramp( Argument1, Argument2, Amount )
    return ( math.clamp( ( Argument2 - Argument1 ) / ( Argument2 - ( Amount or 0 ) ), 0, 1 ) )
end

local function HeartShape( Amount )
    local function Bump( Argument1, Argument2 )
        local Abs = math.abs( Amount - Argument1 )
        return ( math.exp( -( math.min( Abs, 1 - Abs ) / Argument2 ) ^ 2 ) )
    end

    local Abs = math.abs( Amount - 0 )
    local Exp = math.exp( -( math.min( Abs, 1 - Abs ) / 0.055 ) ^ 2 )
    local Abs2 = math.abs( Amount - 0.24 )
    return ( math.max( Exp, 0.6 * math.exp( -( math.min( Abs2, 1 - Abs2 ) / 0.05 ) ^ 2 ) ) )
end

local function Show( Argument1, Visible )
    if Argument1.Visible ~= Visible then
        Argument1.Visible = Visible
    end
end

local function Scale( Argument1, Argument2 )
    Argument1.Size = UDim2.fromScale( Argument2, Argument2 )
end

local function Sq( Argument1, Argument2 )
    return UDim2.fromScale( Argument1 / math.max( 2 * Argument2.X, 1 ), Argument1 / math.max( 2 * Argument2.Y, 1 ) )
end

local Value2 = nil
local Value3 = nil
local Number = 1
local Flag = false
local Number2 = 0
local Number3 = 0
local Number4 = 0
local Value4 = nil
local Number5 = -1000000000
local Number6 = 0
local Number7 = -1000000000
local Number8 = -1000000000
local Flag2 = true

local function Flash2( Name )
    local ImageColor3
    Number3 = 1
    ImageColor3 = Name == "armor" and ArmorColor4 or HitColor4
    Flash.ImageColor3 = ImageColor3
end

local function PowerOf( Amount )
    return ( math.clamp( 0.55 + Amount * 0.025, 0.55, 1 ) )
end

local function MarkBreak( Argument1, BreakAt )
    Argument1.breakAt = BreakAt
    Argument1.life = 2.2
    Argument1.power = 1
    Argument1.img.ImageColor3 = FromRGB4
    Argument1.edge.ImageColor3 = FromRGB7
    Argument1.burst.ImageColor3 = FromRGB7
end

local function Crescent4( Name, Argument2 )
    if not Table10[ Image2 ] or not Table10[ Image3 ] then
        return false
    end

    local LastHitDir

    if Value2 then
        LastHitDir = Value2:GetAttribute( "LastHitDir" )
    else
        LastHitDir = Value2
    end
    if typeof( LastHitDir ) ~= "Vector3" then
        return false
    end

    local Amount = -LastHitDir.X
    local Vector32 = Vector3.new( Amount, 0, -LastHitDir.Z )

    if Vector32.Magnitude < 0.05 then
        return false
    end

    local Value1, Value2Inner, Value3
    local Dir = Vector32.Unit
    local T0 = os.clock( )
    Value1 = nil
    Value3 = nil

    for Key, Value in Table8, nil, nil do
        if Value.dir and T0 - Value.last < Value.life and Value.dir:Dot( Dir ) > 0.8660254037844387 then
            Value2Inner = Value
            break
        end
        if not Value3 or Value.last < Value3.last then
            Value3 = Value
        end

        Value2Inner = nil
    end

    local Power

    if not ( T0 - Number7 < 0.25 ) or not ( Number6 > 0 ) then
        Power = 0.7
    else
        local Clamp = math.clamp( 0.55 + Number6 * 0.025, 0.55, 1 )

        if Clamp then
            Power = Clamp
        else
            Power = 0.7
        end
    end

    Number6 = 0

    if Value2Inner then
        local Clock = ( 1 - ( T0 - Value2Inner.last ) / Value2Inner.life ) ^ 1.5
        Value2Inner.power = math.max( Power, Value2Inner.power * Clock )
    else
        Value3.t0 = T0
        Value3.power = Power
        Value3.life = 1.6
        Value3.breakAt = -1000000000
        Value2Inner = Value3
    end

    local Head = Argument2 == true and true or false
    Value2Inner.dir = Dir
    Value2Inner.last = T0
    Value2Inner.head = Head

    if T0 - Value2Inner.breakAt > 0.5 then
        local Flag = Name == "armor" and true or false
        local ImageColor3
        local Img = Value2Inner.img
        ImageColor3 = Flag and FromRGB4 or FromRGB2
        local ImageColor32
        Img.ImageColor3 = ImageColor3
        local Edge = Value2Inner.edge

        if not Argument2 or not FromRGB6 then
            if not Flag or not FromRGB5 then
                ImageColor32 = FromRGB3
            else
                ImageColor32 = FromRGB5
            end
        else
            ImageColor32 = FromRGB6
        end

        Edge.ImageColor3 = ImageColor32
    end
    if T0 - Number8 < 0.3 then
        Number8 = -1000000000
        Value2Inner.breakAt = T0
        Value2Inner.life = 2.2
        Value2Inner.power = 1
        Value2Inner.img.ImageColor3 = FromRGB4
        Value2Inner.edge.ImageColor3 = FromRGB7
        Value2Inner.burst.ImageColor3 = FromRGB7
    end

    Value4 = Value2Inner
    Number5 = T0
    return true
end

local function Damaged( Name, Amount )
    local Clock = os.clock( )

    if Name == "health" and Value2 and Value2.MaxHealth > 0 then
        Number4 = math.min( 0.5, Number4 + Amount / Value2.MaxHealth * 2.5 )
    end
    if Value4 and Clock - Number5 < 0.25 then
        local Power = Value4.power
        Value4.power = math.max( Power, ( math.clamp( 0.55 + Amount * 0.025, 0.55, 1 ) ) )
        return
    end
    if Clock - Number7 > 0.25 then
        Number6 = 0
    end

    Number6 = Number6 + Amount
    Number7 = Clock
    task.delay( 0.15, function()
        if not Flag and os.clock( ) - Number5 > 0.35 then
            local ImageColor3
            Number3 = 1
            ImageColor3 = Name == "armor" and ArmorColor4 or HitColor4
            Flash.ImageColor3 = ImageColor3
        end
    end )
end

local function ArmorBroke()
    local BreakAt = os.clock( )

    if not Value4 or not ( BreakAt - Number5 < 0.3 ) then
        Number8 = BreakAt
        return
    end
    Value4.breakAt = BreakAt
    Value4.life = 2.2
    Value4.power = 1
    Value4.img.ImageColor3 = FromRGB4
    Value4.edge.ImageColor3 = FromRGB7
    Value4.burst.ImageColor3 = FromRGB7
    return
end

local function OnCharacter( Object )
    local Value1
    Number = 1
    Flag = false
    Number2 = 0
    Number3 = 0
    Number4 = 0
    Number6 = 0
    Number8 = -1000000000
    Value1 = nil

    for Key, Value in Table8, nil, nil do
        Value.t0 = -1000000000
        Value.last = -1000000000
        Value.dir = nil
        Value.life = 1.6
        Value.breakAt = -1000000000
    end

    Value4 = nil
    Value3 = Object
    Value2 = Object:WaitForChild( "Humanoid", 10 )

    if not Value2 or Value3 ~= Object then
        return
    end
    local Health = Value2.Health
    Value2.HealthChanged:Connect( function( Amount )
        if Amount < Health - 0.5 then
            Damaged( "health", Health - Amount )
        end

        Health = Amount
    end )
    local Armor = Object:GetAttribute( "Armor" ) or 0
    Object:GetAttributeChangedSignal( "Armor" ):Connect( function()
        local ArmorInner = Object:GetAttribute( "Armor" ) or 0

        if Object:GetAttribute( "ArmorSilent" ) then
            Armor = ArmorInner
            return
        end
        if ArmorInner < Armor then
            Damaged( "armor", Armor - ArmorInner )
        end
        if Armor > 0 and ArmorInner <= 0 then
            local BreakAt = os.clock( )

            if not Value4 or not ( BreakAt - Number5 < 0.3 ) then
                Number8 = BreakAt
            else
                Value4.breakAt = BreakAt
                Value4.life = 2.2
                Value4.power = 1
                Value4.img.ImageColor3 = FromRGB4
                Value4.edge.ImageColor3 = FromRGB7
                Value4.burst.ImageColor3 = FromRGB7
            end
        end

        Armor = ArmorInner
    end )
    Value2.Died:Connect( function()
        Flag = true
    end )
    return
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end

Hurt.OnClientEvent:Connect( function( Argument1 )
    task.delay( 0.03, function()
        if Flag or not Value2 then
            return
        end

        local Text = ( not Value3 or not ( ( Value3:GetAttribute( "Armor" ) or 0 ) > 0 ) ) and "health" or "armor"
        local FlagInner

        if type( Argument1 ) == "table" then
            if Argument1.Headshot == true then
                FlagInner = true
            else
                FlagInner = false
            end
        else
            FlagInner = false
        end
        if not Crescent4( Text, FlagInner ) then
            local ImageColor3
            Number3 = 1
            ImageColor3 = Text == "armor" and ArmorColor4 or HitColor4
            Flash.ImageColor3 = ImageColor3
        end
    end )
end )
RunService.RenderStepped:Connect( function( Amount )
    if not Parent2.Enabled and ClientState.WardrobeOpen ~= true then
        Parent2.Enabled = true
    end

    local Clamp
    local Clock = os.clock( )

    if not Value2 or not Value2.Parent or Flag or not ( Value2.MaxHealth > 0 ) then
        Clamp = 1
    else
        Clamp = math.clamp( Value2.Health / Value2.MaxHealth, 0, 1 )
    end

    local NumberInner

    if Flag then
        NumberInner = 8
    elseif Clamp < Number then
        NumberInner = 12
    else
        NumberInner = 1.6
    end

    Number = Number + ( Clamp - Number ) * ( 1 - math.exp( -NumberInner * Amount ) )
    Number3 = Number3 * math.exp( -7 * Amount )
    Number4 = Number4 * math.exp( -2.5 * Amount )

    if Flag then
        Number3 = 0
        Number4 = 0
    end
    if ClientState.Spectating then
        local Value1
        Number3 = 0
        Number4 = 0
        Value1 = nil

        for Key, Value in Table8, nil, nil do
            Value.last = -1000000000
        end
        if not Flag2 then
            local Value2Inner
            Flag2 = true
            Value2Inner = nil

            for Key2, Value3 in Table6, nil, nil do
                if Value3.Visible ~= false then
                    Value3.Visible = false
                end
            end

            Clone4.Enabled = false
        end

        return
    end
    local Value4, Flag2Inner
    Value4 = nil

    for Key3, Value5 in Table8, nil, nil do
        if Clock - Value5.last < Value5.life then
            if not Flag then
                Flag2Inner = true
                break
            end
        end

        Flag2Inner = false
    end

    local FlagInner

    if Number >= 0.969 then
        if Clamp >= 0.97 then
            FlagInner = true
        else
            FlagInner = false
        end
    else
        FlagInner = false
    end
    if FlagInner then
        Number = 1
    end
    if not FlagInner or not ( Number3 < 0.01 ) or not ( Number4 < 0.01 ) or Flag2Inner then
        local Max
        Flag2 = false
        local Clamp2 = math.clamp( ( 0.35 - Number ) / 0.35, 0, 1 )

        if Clamp2 > 0 then
            Number2 = ( Number2 + Amount * ( 45 + 45 * Clamp2 ) / 60 ) % 1

            local function Bump( Argument1, Argument2 )
                local Abs = math.abs( Number2 - Argument1 )
                return ( math.exp( -( math.min( Abs, 1 - Abs ) / Argument2 ) ^ 2 ) )
            end

            local Abs = math.abs( Number2 - 0 )
            local Exp = math.exp( -( math.min( Abs, 1 - Abs ) / 0.055 ) ^ 2 )
            local Abs2 = math.abs( Number2 - 0.24 )
            Max = math.max( Exp, 0.6 * math.exp( -( math.min( Abs2, 1 - Abs2 ) / 0.05 ) ^ 2 ) ) * Clamp2
        else
            Number2 = 0
            Max = 0
        end

        local Clamp3 = math.clamp( ( 0.97 - Number ) / 0.97, 0, 1 )
        local Clamp4 = Clamp3 ^ 1.6

        if Clamp3 > 0 or Number4 > 0.01 then
            local Item = Table3[ 1 ]
            local Item2 = ( Item + ( Table3[ 2 ] - Item ) * Clamp4 ) * ( 1 - Number4 * 0.1 ) * ( 1 - Max * 0.03 )

            if Oval2.Visible ~= true then
                Oval2.Visible = true
            end

            local Item5
            Oval2.Size = UDim2.fromScale( Item2, Item2 )
            Oval2.ImageColor3 = ImageColor3:Lerp( FromRGB, Clamp3 ^ 1.2 )

            if Clamp3 > 0 then
                local Item3 = Table4[ 1 ]
                local Item4 = Item3 + ( Table4[ 2 ] - Item3 ) * Clamp4

                if Item4 then
                    Item5 = Item4
                else
                    Item5 = 0
                end
            else
                Item5 = 0
            end

            Oval2.ImageTransparency = 1 - math.min( 1, Item5 + Number4 * 0.35 )
        elseif Oval2.Visible ~= false then
            Oval2.Visible = false
        end

        local From = Table5.from
        local To = Table5.to
        local Clamp5 = math.clamp( ( From - Number ) / ( From - ( To or 0 ) ), 0, 1 )

        if Clamp5 > 0 then
            if Shade.Visible ~= true then
                Shade.Visible = true
            end

            local Item6 = Table5.scale[ 1 ]
            local Item7 = Table5.scale[ 2 ]
            local Clamp6 = Clamp5 ^ 0.75
            local Item8 = ( Item6 + ( Item7 - Item6 ) * Clamp6 ) * ( 1 - Max * 0.03 )
            Shade.Size = UDim2.fromScale( Item8, Item8 )
            Shade.ImageTransparency = 1 - Table5.opacity * Clamp5 ^ 1.2
        elseif Shade.Visible ~= false then
            Shade.Visible = false
        end
        if Max > 0.005 then
            if Pulse.Visible ~= true then
                Pulse.Visible = true
            end

            Pulse.ImageTransparency = 1 - Max * 0.2
        elseif Pulse.Visible ~= false then
            Pulse.Visible = false
        end

        local Value8
        local CFrame = CurrentCamera.CFrame
        local AbsoluteSize = Parent2.AbsoluteSize / 2
        Value8 = nil

        for Key5, Value9 in Table8, nil, nil do
            local Clock2 = Clock - Value9.last

            if not Value9.dir or not ( Clock2 < Value9.life ) or Flag then
                local Img4 = Value9.img

                if Img4.Visible ~= false then
                    Img4.Visible = false
                end

                local Edge4 = Value9.edge

                if Edge4.Visible ~= false then
                    Edge4.Visible = false
                end

                local Burst5 = Value9.burst

                if Burst5.Visible ~= false then
                    Burst5.Visible = false
                end
            else
                local Flag3
                local VectorToObjectSpace = CFrame:VectorToObjectSpace( Value9.dir )
                local Z = VectorToObjectSpace.Z
                local Atan2 = math.atan2( Z, VectorToObjectSpace.X )
                local Y = 2 * ( 0.72 * AbsoluteSize.Y ) / 0.9
                local Min = math.min( 1, ( Clock - Value9.t0 ) / 0.06 ) * ( 1 - Clock2 / Value9.life ) ^ 1.5 * Value9.power
                local Exp2 = math.exp( -Clock2 / 0.05 )
                local Clock3 = Clock - Value9.breakAt
                Flag3 = Clock3 < Value9.life and true or false
                local Exp4

                if Flag3 then
                    local Exp3 = math.exp( -Clock3 / 0.12 )

                    if Exp3 then
                        Exp4 = Exp3
                    else
                        Exp4 = 0
                    end
                else
                    Exp4 = 0
                end

                local Rotation = math.deg( Atan2 )
                local Img = Value9.img

                if Img.Visible ~= true then
                    Img.Visible = true
                end

                local Number2Inner
                local Img2 = Value9.img
                Img2.Size = UDim2.fromScale( Y / math.max( 2 * AbsoluteSize.X, 1 ), Y / math.max( 2 * AbsoluteSize.Y, 1 ) )
                Value9.img.Rotation = Rotation
                local Img3 = Value9.img
                Number2Inner = not Flag3 and 0.4 or 0.75
                Img3.ImageTransparency = 1 - math.min( 1, Number2Inner * Min )
                local Edge = Value9.edge

                if Edge.Visible ~= true then
                    Edge.Visible = true
                end

                local Number3Inner = not Value9.head and 0.03 or 0.06
                local Number4Inner = Number3Inner * Exp2
                local Y2 = Y * ( math.max( Number4Inner, 0.1 * Exp4 ) + 1 )
                local Edge2 = Value9.edge
                Edge2.Size = UDim2.fromScale( Y2 / math.max( 2 * AbsoluteSize.X, 1 ), Y2 / math.max( 2 * AbsoluteSize.Y, 1 ) )
                Value9.edge.Rotation = Rotation
                local Edge3 = Value9.edge
                Edge3.ImageTransparency = 1 - math.min( 1, 0.85 * Min * ( Exp2 * 0.2 + 1 + 0.6 * Exp4 ) )

                if Clock3 < 0.5 then
                    local Clock4 = Clock3 / 0.5
                    local Y3 = Y * ( 1 + 0.3 * ( 1 - ( 1 - Clock4 ) ^ 2 ) )
                    local Burst = Value9.burst

                    if Burst.Visible ~= true then
                        Burst.Visible = true
                    end

                    local Burst2 = Value9.burst
                    Burst2.Size = UDim2.fromScale( Y3 / math.max( 2 * AbsoluteSize.X, 1 ), Y3 / math.max( 2 * AbsoluteSize.Y, 1 ) )
                    Value9.burst.Rotation = Rotation
                    local Burst3 = Value9.burst
                    Burst3.ImageTransparency = 1 - 0.9 * ( 1 - Clock4 ) ^ 1.5
                else
                    local Burst4 = Value9.burst

                    if Burst4.Visible ~= false then
                        Burst4.Visible = false
                    end
                end
            end
        end
        if Number3 > 0.01 then
            if Flash.Visible ~= true then
                Flash.Visible = true
            end

            Flash.ImageTransparency = 1 - Number3 * 0.3
        elseif Flash.Visible ~= false then
            Flash.Visible = false
        end

        local Clamp7 = math.clamp( ( 0.4 - Number ) / 0.4, 0, 1 )

        if Clamp7 > 0 then
            Clone4.Enabled = true
            Clone4.Saturation = Saturation * Clamp7 ^ 1.2
            Clone4.Brightness = Brightness * Clamp7 - Max * 0.02
            Clone4.Contrast = Contrast * Clamp7
            Clone4.TintColor = Color3.new( 1, 1, 1 ):Lerp( TintColor, Clamp7 )
            return
        end
        if Clone4.Enabled then
            Clone4.Enabled = false
        end

        return
    end
    if not Flag2 then
        local Value6
        Flag2 = true
        Value6 = nil

        for Key4, Value7 in Table6, nil, nil do
            if Value7.Visible ~= false then
                Value7.Visible = false
            end
        end

        Clone4.Enabled = false
    end

    return
end )
