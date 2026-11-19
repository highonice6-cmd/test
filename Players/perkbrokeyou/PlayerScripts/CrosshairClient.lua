-- Players.perkbrokeyou.PlayerScripts.CrosshairClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local HitAudio = require( ReplicatedStorage.Weapons:WaitForChild( "HitAudio" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local SpawnShield = require( ReplicatedStorage:WaitForChild( "SpawnShield" ) )
local Spec = require( ReplicatedStorage.Controls:WaitForChild( "Spec" ) )
local Table = { XhMode = true, XhHitmarker = true, XhHitmarkerOn = true }
local WeaponData = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "WeaponData" ) )
local Table2 = {
    XhShape = "Circle",
    XhLength = 4,
    XhGap = 9,
    XhThickness = 1,
    XhDot = true,
    XhDotSize = 3
}
local Table3 = { XhShape = "Dot", XhDot = true, XhDotSize = 5, XhThickness = 1 }
local Table4 = {
    XhShape = "Circle",
    XhLength = 4,
    XhGap = 7,
    XhThickness = 1,
    XhDot = true,
    XhDotSize = 3
}
local Table5 = { XhLength = 5, XhGap = 4 }
local Value1 = nil
RunService.Heartbeat:Connect( function()
    local Tool
    local Character = Players.LocalPlayer.Character

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Character2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    local Character3 = if Character2 then Character2.Handling else Character2
    local Flag

    if not Tool or Tool:GetAttribute( "Melee" ) == nil then
        local NotCharacter = not Tool

        if NotCharacter then
            if ClientState.FistsReady == true then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = NotCharacter
        end
    else
        Flag = true
    end

    local Captured

    if not Flag or not Table4 then
        if not Character2 or not Character2.Fire or not Character2.Fire.Pellets or not Table2 then
            if not Character3 or not Character3.Scope or not Table3 then
                Captured = nil
            else
                Captured = Table3
            end
        else
            Captured = Table2
        end
    else
        Captured = Table4
    end

    Value1 = Captured
end )
local Class = setmetatable( { }, {
    __index = function( Argument1, Key )
        if Controls.Settings.XhMode ~= "Custom" and type( Key ) == "string" and Key:sub( 1, 2 ) == "Xh" and not Table[ Key ] then
            if Value1 and Value1[ Key ] ~= nil then
                return Value1[ Key ]
            end
            if Table5[ Key ] ~= nil then
                return Table5[ Key ]
            end

            local Entry = Spec[ Key ]

            if type( Entry ) == "table" and Entry.default ~= nil then
                return Entry.default
            end
        end

        return Controls.Settings[ Key ]
    end
} )
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Crosshair = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "Crosshair", math.huge )
Crosshair.Enabled = true
task.spawn( function()
    LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "WeaponHUD", math.huge ).Enabled = true
end )
local Clone = Crosshair:WaitForChild( "CrosshairRoot" ):Clone( )

local function NewSet( Clone )
    local function Piece( Name )
        local Child = Clone:WaitForChild( Name )
        return {
            f = Child,
            s = Child:FindFirstChildOfClass( "UIStroke" ),
            c = Child:FindFirstChildOfClass( "UICorner" )
        }
    end

    return {
        root = Clone,
        lines = {
            Piece( "Haut" ),
            Piece( "Bas" ),
            Piece( "Gauche" ),
            ( Piece( "Droite" ) )
        },
        ringOutline = Piece( "RingOutline" ),
        ring = Piece( "Ring" ),
        dot = Piece( "Dot" )
    }
end

local Set = NewSet( Crosshair.CrosshairRoot )
local NoFire = Crosshair:FindFirstChild( "NoFire" )

if NoFire then
    NoFire.Visible = false
end

local function ReloadProgress()
    local DebugReloadFade = LocalPlayer:GetAttribute( "DebugReloadFade" )

    if type( DebugReloadFade ) == "number" then
        return ( math.clamp( DebugReloadFade, 0, 1 ) )
    end
    if not ClientState.Reloading or not ClientState.ReloadStart then
        return nil
    end

    local Tool
    local Character = LocalPlayer.Character

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end
    if not Tool then
        return nil
    end

    local ReloadTime2
    local ReloadTime = Tool:GetAttribute( "ReloadTime" )

    if ReloadTime then
        ReloadTime2 = ReloadTime
    else
        local Success2
        local Success, Result = pcall( require, ReplicatedStorage.Weapons.WeaponData )
        Success2 = if Success then Result[ Tool:GetAttribute( "Weapon" ) or "" ] else Success
        local Success3

        if Success2 then
            local Ammo = Success2.Ammo

            if Ammo then
                Success3 = Success2.Ammo.ReloadTime
            else
                Success3 = Ammo
            end
        else
            Success3 = Success2
        end

        ReloadTime2 = Success3
    end
    if not ReloadTime2 or ReloadTime2 <= 0 then
        return nil
    end
    return ( math.clamp( ( os.clock( ) - ClientState.ReloadStart ) / ( ReloadTime2 * ( ClientState.ReloadMul or 1 ) ), 0, 1 ) )
end

local function AlignRoot( Argument1, Flag )
    local Parent = Argument1.root.Parent
    local AbsolutePosition = Parent.AbsolutePosition
    local AbsoluteSize = Parent.AbsoluteSize

    if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
        return
    end

    local Floor2
    local AbsolutePosition2 = AbsolutePosition + AbsoluteSize / 2

    if Flag then
        local Floor = math.floor( AbsolutePosition2.X )

        if Floor then
            Floor2 = Floor
        else
            Floor2 = math.floor( AbsolutePosition2.X + 0.5 )
        end
    else
        Floor2 = math.floor( AbsolutePosition2.X + 0.5 )
    end

    local Floor4

    if Flag then
        local Floor3 = math.floor( AbsolutePosition2.Y )

        if Floor3 then
            Floor4 = Floor3
        else
            Floor4 = math.floor( AbsolutePosition2.Y + 0.5 )
        end
    else
        Floor4 = math.floor( AbsolutePosition2.Y + 0.5 )
    end

    local Floor5 = Floor2 - AbsolutePosition.X
    local Floor6 = Floor4 - AbsolutePosition.Y
    local Floor7 = math.floor( Floor5 )
    local Floor8 = math.floor( Floor6 )
    local Root = Argument1.root
    local Floor9 = ( Floor5 - Floor7 ) / AbsoluteSize.X
    Root.Position = UDim2.new( Floor9, Floor7, ( Floor6 - Floor8 ) / AbsoluteSize.Y, Floor8 )
end

local function DynamicGap()
    if not ClientState.Equipped then
        return 0
    end

    local Spread = ClientState.Spread or 0
    local SpreadRest = ClientState.SpreadRest or 0

    if Spread <= SpreadRest then
        return 0
    end
    local Y = CurrentCamera.ViewportSize.Y / 2 / math.tan( ( math.rad( CurrentCamera.FieldOfView / 2 ) ) )
    return ( math.round( ( math.tan( ( math.rad( Spread ) ) ) - math.tan( ( math.rad( SpreadRest ) ) ) ) * Y ) )
end

local function Draw( Set, Visible )
    local IsMissing2
    local BackgroundColor3 = Color3.fromHex( Class.XhColor )
    local IsMissing = not Visible

    if IsMissing then
        IsMissing2 = ReloadProgress( )
    else
        IsMissing2 = IsMissing
    end

    local IsMissing4
    local XhOpacity = Class.XhOpacity

    if IsMissing2 then
        local IsMissing3 = 0.1 + 0.9 * IsMissing2

        if IsMissing3 then
            IsMissing4 = IsMissing3
        else
            IsMissing4 = 1
        end
    else
        IsMissing4 = 1
    end

    local Y2
    local BackgroundTransparency = 1 - XhOpacity * IsMissing4
    local Transparency = 0.3 + 0.7 * BackgroundTransparency

    if CurrentCamera.ViewportSize.Y > 0 then
        local Y = CurrentCamera.ViewportSize.Y / 1080

        if Y then
            Y2 = Y
        else
            Y2 = 1
        end
    else
        Y2 = 1
    end

    local Round2
    local Thickness = math.max( 1, ( math.round( Y2 ) ) )
    local Round = math.round( Class.XhGap * Y2 )
    Round2 = if not Class.XhDynamic or Visible then Round else Round + DynamicGap( )
    local NotXhCombatOnly2
    local XhShape = Class.XhShape

    if Visible then
        NotXhCombatOnly2 = Visible
    else
        local NotXhCombatOnly = not Class.XhCombatOnly

        if NotXhCombatOnly then
            NotXhCombatOnly2 = NotXhCombatOnly
        else
            local Combat = ClientState.Combat

            if Combat then
                NotXhCombatOnly2 = Combat
            elseif ClientState.FistCombat == true then
                NotXhCombatOnly2 = true
            elseif ClientState.MeleeAim == true then
                NotXhCombatOnly2 = true
            elseif ClientState.MeleeSwing == true then
                NotXhCombatOnly2 = true
            else
                NotXhCombatOnly2 = false
            end
        end
    end

    local Flag
    local Max = math.max( 1, ( math.round( Class.XhLength * Y2 ) ) )
    local Thickness2 = math.max( 1, ( math.round( Class.XhThickness * Y2 ) ) )
    local Odd = Thickness2 % 2
    Flag = Odd == 1 and true or false
    AlignRoot( Set, Flag )
    local Rot = math.clamp( tonumber( Class.XhRotation ) or 0, 0, 45 )

    if Set.rot ~= Rot then
        Set.rot = Rot
        Set.root.Rotation = Rot
    end
    if Set.odd ~= Odd then
        Set.odd = Odd
        local Root = Set.root
        Root.Size = UDim2.fromOffset( Odd, Odd )
    end

    local Value1
    local Amount = -math.floor( Thickness2 / 2 )
    local Table = {
        Vector2.new( Amount, -Round2 - Max ),
        Vector2.new( Amount, Round2 + Odd ),
        Vector2.new( -Round2 - Max, Amount ),
        Vector2.new( Round2 + Odd, Amount )
    }
    local Lines = Set.lines
    Value1 = nil

    for Key, Value in Lines, nil, nil do
        local Visible5
        local F10 = Value.f

        if NotXhCombatOnly2 then
            if XhShape == "Cross" then
                Visible5 = true
            elseif XhShape == "T" then
                if Key == 1 then
                    Visible5 = false
                else
                    Visible5 = true
                end
            else
                Visible5 = false
            end
        else
            Visible5 = NotXhCombatOnly2
        end

        local Size
        F10.Visible = Visible5
        local F11 = Value.f

        if Key <= 2 then
            local FromOffset = UDim2.fromOffset( Thickness2, Max )

            if FromOffset then
                Size = FromOffset
            else
                Size = UDim2.fromOffset( Max, Thickness2 )
            end
        else
            Size = UDim2.fromOffset( Max, Thickness2 )
        end

        F11.Size = Size
        local F12 = Value.f
        F12.Position = UDim2.fromOffset( Table[ Key ].X, Table[ Key ].Y )
        Value.f.BackgroundColor3 = BackgroundColor3
        Value.f.BackgroundTransparency = BackgroundTransparency
        local S3 = Value.s
        S3.Enabled = Class.XhOutline
        Value.s.Thickness = Thickness
        Value.s.Transparency = Transparency
    end

    local Flag2
    local Ring = Set.ring
    local RingOutline = Set.ringOutline

    if XhShape == "Circle" then
        Flag2 = true
    elseif XhShape == "Square" then
        Flag2 = true
    else
        Flag2 = false
    end

    local Round4
    local Round3 = Round2 * 2 + Max
    Round4 = if Round3 % 2 == Odd then Round3 else Round3 + 1
    local CornerRadius
    local Max2 = ( Odd - Round4 ) / 2

    if XhShape == "Circle" then
        local UDim3 = UDim.new( 1, 0 )

        if UDim3 then
            CornerRadius = UDim3
        else
            CornerRadius = UDim.new( 0, 0 )
        end
    else
        CornerRadius = UDim.new( 0, 0 )
    end

    local Visible3
    local F = Ring.f
    F.Visible = NotXhCombatOnly2 and Flag2
    local F2 = Ring.f
    F2.Size = UDim2.fromOffset( Round4, Round4 )
    local F3 = Ring.f
    F3.Position = UDim2.fromOffset( Max2, Max2 )
    Ring.f.BackgroundTransparency = 1
    Ring.c.CornerRadius = CornerRadius
    Ring.s.Color = BackgroundColor3
    Ring.s.Thickness = Thickness2
    Ring.s.Transparency = BackgroundTransparency
    local F4 = RingOutline.f
    local Visible2 = Ring.f.Visible
    Visible3 = if Visible2 then Class.XhOutline else Visible2
    local Visible4
    F4.Visible = Visible3
    local F5 = RingOutline.f
    F5.Size = UDim2.fromOffset( Round4 - Thickness * 2, Round4 - Thickness * 2 )
    local F6 = RingOutline.f
    F6.Position = UDim2.fromOffset( Max2 + Thickness, Max2 + Thickness )
    RingOutline.f.BackgroundTransparency = 1
    RingOutline.c.CornerRadius = CornerRadius
    local S = RingOutline.s
    S.Thickness = Thickness2 + Thickness * 2
    RingOutline.s.Transparency = Transparency
    local Dot = Set.dot
    local F7 = Dot.f
    local XhDot = Class.XhDot

    if XhDot then
        Visible4 = XhDot
    elseif XhShape == "Dot" then
        Visible4 = true
    else
        Visible4 = false
    end

    F7.Visible = Visible4
    local Max3 = math.max( 1, ( math.round( Class.XhDotSize * Y2 ) ) )
    local Floor = math.floor( Odd / 2 - Max3 / 2 + 0.5 )
    local F8 = Dot.f
    F8.Size = UDim2.fromOffset( Max3, Max3 )
    local F9 = Dot.f
    F9.Position = UDim2.fromOffset( Floor, Floor )
    Dot.f.BackgroundColor3 = BackgroundColor3
    Dot.f.BackgroundTransparency = BackgroundTransparency
    local S2 = Dot.s
    S2.Enabled = Class.XhOutline
    Dot.s.Thickness = Thickness
    Dot.s.Transparency = Transparency
end

local Value2 = nil
RunService:BindToRenderStep( "Crosshair", Enum.RenderPriority.Camera.Value + 1, function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Flag

    if Humanoid == nil then
        Flag = false
    elseif Humanoid.Health > 0 then
        if Character:FindFirstChildOfClass( "Tool" ) == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    local Flag2 = if ClientState.Equipped or ClientState.FistsReady == true or Flag then not ClientState.Scoped else Flag
    local Visible

    if Flag2 then
        Visible = SpawnShield.Active( Character )
    else
        Visible = Flag2
    end

    local Visible2
    local Root = Set.root
    Visible2 = if Flag2 then not Visible else Flag2
    Root.Visible = Visible2

    if NoFire and NoFire.Visible ~= Visible then
        NoFire.Visible = Visible
    end
    if Set.root.Visible then
        Draw( Set, false )
    end

    local Parent = ClientState.CrosshairPreview

    if not Parent or not Parent.Parent then
        if Value2 then
            Value2.root:Destroy( )
            Value2 = nil
        end
    else
        if not Value2 or Value2.root.Parent ~= Parent then
            if Value2 then
                Value2.root:Destroy( )
            end

            local CloneInner = Clone:Clone( )
            CloneInner.Visible = true
            CloneInner.Parent = Parent
            Value2 = NewSet( CloneInner )
        end

        Draw( Value2, true )
    end

    local HitmarkerOn
    ClientState.HitmarkerScale = Class.XhHitmarker
    HitmarkerOn = Class.XhHitmarkerOn ~= false and true or false
    ClientState.HitmarkerOn = HitmarkerOn
end )
HitAudio.SetHitmarker( Class.HitSound )
Controls.SettingsChanged:Connect( function( Name )
    if Name == "HitSound" then
        HitAudio.SetHitmarker( Class.HitSound )
    end
end )
