-- Players.perkbrokeyou.PlayerScripts.ThermalScopeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local Parent = game:GetService( "Lighting" )
local CollectionService = game:GetService( "CollectionService" )
local ContextActionService = game:GetService( "ContextActionService" )
local Weapons = game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local LocalPlayer = Players.LocalPlayer
local Parent2 = workspace.CurrentCamera
local FillColor = Color3.fromRGB( 255, 205, 30 )
local OutlineColor = Color3.fromRGB( 255, 110, 0 )
local Table = {
    Density = 0.5,
    Offset = 0,
    Haze = 2,
    Glare = 0,
    Color = Color3.fromRGB( 28, 44, 92 ),
    Decay = Color3.fromRGB( 14, 22, 60 )
}
local Table2 = { on = 2.5, off = 10 }
local Table3 = { }
local Table4 = {
    on = "rbxassetid://110679410093440",
    off = "rbxassetid://87290057705170"
}
Value1 = nil

for Key, Value in Table4, nil, nil do
    local Sound = Instance.new( "Sound" )
    Sound.Name = "Thermal_" .. Key
    Sound.SoundId = Value
    Sound.Volume = Table2[ Key ]
    Sound.Parent = game:GetService( "SoundService" )
    Table3[ Key ] = Sound
end

local GrainPx2
task.spawn( pcall, game:GetService( "ContentProvider" ).PreloadAsync, game:GetService( "ContentProvider" ), { Table3.on, Table3.off } )
local Get = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) ).Get( "ThermalGrain" )
Get.Visible = false
local Grain = Get:WaitForChild( "Grain" )
local GrainPx = Grain:GetAttribute( "GrainPx" )

if GrainPx then
    GrainPx2 = GrainPx
elseif Grain.TileSize.X.Offset > 0 then
    local Offset = Grain.TileSize.X.Offset

    if Offset then
        GrainPx2 = Offset
    else
        GrainPx2 = 256
    end
else
    GrainPx2 = 256
end

local ScaleUI = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ScaleUI" ) )

local function GrainLayout()
    local AbsoluteSize = Get.AbsoluteSize

    if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
        return
    end
    local FromPx = ScaleUI.FromPx
    local X = AbsoluteSize.X + GrainPx2
    Grain.Size = FromPx( X, AbsoluteSize.Y + GrainPx2, AbsoluteSize )
    Grain.TileSize = UDim2.fromScale( GrainPx2 / ( AbsoluteSize.X + GrainPx2 ), GrainPx2 / ( AbsoluteSize.Y + GrainPx2 ) )
    return
end

Get:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( GrainLayout )
GrainLayout( )
local Clone = Get:WaitForChild( "Effets" ):WaitForChild( "ThermalVision" ):Clone( )
Clone.Enabled = false
Clone.Parent = Parent
local Parent3 = Instance.new( "Folder" )
Parent3.Name = "ThermalHighlights"
Parent3.Parent = Parent2
local Table5 = { }
local I = 1

for I = 1, 28 do
    local Highlight = Instance.new( "Highlight" )
    Highlight.FillColor = FillColor
    Highlight.FillTransparency = 0
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0.15
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Enabled = false
    Highlight.Parent = Parent3
    Table5[ I ] = Highlight
end

local Success

if Grain.Image == "" then
    Success = pcall( function()
        local CreateEditableImage = game:GetService( "AssetService" ):CreateEditableImage( { Size = Vector2.new( GrainPx2, GrainPx2 ) } )
        local Captured = GrainPx2 * GrainPx2
        local Create = buffer.create( Captured * 4 )
        local Random2 = Random.new( 7 )
        local Captured2 = Captured - 1
        local I = 0

        for I = 0, Captured2 do
            local NextInteger = Random2:NextInteger( 0, 255 )
            buffer.writeu8( Create, I * 4, NextInteger )
            buffer.writeu8( Create, I * 4 + 1, NextInteger )
            buffer.writeu8( Create, I * 4 + 2, NextInteger )
            buffer.writeu8( Create, I * 4 + 3, 255 )
        end

        CreateEditableImage:WritePixelsBuffer( Vector2.zero, CreateEditableImage.Size, Create )
        Grain.ImageContent = Content.fromObject( CreateEditableImage )
    end )
else
    Success = true
end

local Flag = false
local Value2 = nil
local Flag2 = false
local Flag3 = false
local Table6 = { }

local function WeaponCfg()
    local Tool
    local Character = LocalPlayer.Character

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Character2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    return Character2
end

local Table7 = { }

local function AddChar( Object, Position )
    if not Object or not Object:IsA( "Model" ) or Object == LocalPlayer.Character then
        return
    end

    local Humanoid = Object:FindFirstChildOfClass( "Humanoid" )
    local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )

    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 then
        return
    end

    local Magnitude = ( HumanoidRootPart.Position - Position ).Magnitude

    if Magnitude <= 1500 then
        table.insert( Table7, { m = Object, d = Magnitude } )
    end
end

local function Rescan()
    table.clear( Table7 )
    local Position = Parent2.CFrame.Position
    local Table = { }

    for Key, Value in Players:GetPlayers( ) do
        if Value.Character then
            Table[ Value.Character ] = true
            AddChar( Value.Character, Position )
        end
    end

    local Find = WorldRefs.Find( "Dummies" )

    if Find then
        for Key2, Value2 in Find:GetChildren( ) do
            if not Table[ Value2 ] then
                Table[ Value2 ] = true
                AddChar( Value2, Position )
            end
        end
    end
    for Key3, Value3 in CollectionService:GetTagged( "GunBot" ) do
        if not Table[ Value3 ] then
            Table[ Value3 ] = true
            AddChar( Value3, Position )
        end
    end
    for Key4, Value4 in workspace:GetChildren( ) do
        if not Table[ Value4 ] and Value4:IsA( "Model" ) and Value4:FindFirstChildOfClass( "Humanoid" ) then
            Table[ Value4 ] = true
            AddChar( Value4, Position )
        end
    end

    local Value1
    table.sort( Table7, function( Argument1, Argument2 )
        local Flag = Argument1.d < Argument2.d and true or false
        return Flag
    end )
    Value1 = nil

    for Key5, Value5 in Table5, nil, nil do
        local Adornee
        local Entry = Table7[ Key5 ]
        Adornee = Entry and Entry.m or nil

        if Value5.Adornee ~= Adornee then
            Value5.Adornee = Adornee
        end

        local Enabled = Adornee ~= nil and true or false

        if Value5.Enabled ~= Enabled then
            Value5.Enabled = Enabled
        end
    end
end

local function SetActive( Enabled )
    if Enabled == Flag2 then
        return
    end

    Flag2 = Enabled
    Clone.Enabled = Enabled
    Get.Visible = Enabled and Success
    local Atmosphere = Parent:FindFirstChildOfClass( "Atmosphere" )

    if Enabled then
        Table3.on.TimePosition = 0
        Table3.on:Play( )

        for Key, Value in Parent:GetChildren( ) do
            if Value:IsA( "PostEffect" ) and Value ~= Clone and Value.Enabled then
                Value.Enabled = false
                Table6[ Value ] = true
            end
        end
        if Atmosphere then
            local Value1
            Value2 = { atmo = Atmosphere }
            Value1 = nil

            for Key2, Value2Inner in Table, nil, nil do
                Value2[ Key2 ] = Atmosphere[ Key2 ]
                Atmosphere[ Key2 ] = Value2Inner
            end
        end

        Rescan( )
        return
    end
    local Value3 = nil

    for Value4 in Table6, nil, nil do
        if Value4.Parent then
            Value4.Enabled = true
        end
    end

    table.clear( Table6 )

    if Value2 then
        local Value5 = nil

        for Value6 in Table, nil, nil do
            local Atmo = Value2.atmo
            Atmo[ Value6 ] = Value2[ Value6 ]
        end

        Value2 = nil
    end

    local Value7 = nil

    for Key3, Value8 in Table5, nil, nil do
        Value8.Enabled = false
        Value8.Adornee = nil
    end

    return
end

local function OnToggle( Argument1, Argument2 )
    if Argument2 == Enum.UserInputState.Begin then
        Flag = not Flag

        if not Flag then
            Table3.off.TimePosition = 0
            Table3.off:Play( )
        end
    end

    return Enum.ContextActionResult.Sink
end

local Number = 0
local Number2 = 0
RunService:BindToRenderStep( "ThermalScope", Enum.RenderPriority.Camera.Value + 3, function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Tool
    local Character2 = LocalPlayer.Character

    if Character2 then
        Tool = Character2:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character2
    end

    local Character3 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    local FlagInner

    if ClientState.Scoped == true then
        if Humanoid == nil then
            FlagInner = false
        elseif Humanoid.Health > 0 then
            if Character3 == nil then
                FlagInner = false
            elseif Character3.Handling.Thermal == true then
                FlagInner = true
            else
                FlagInner = false
            end
        else
            FlagInner = false
        end
    else
        FlagInner = false
    end
    if FlagInner ~= Flag3 then
        Flag3 = FlagInner

        if FlagInner then
            ContextActionService:BindActionAtPriority( "ThermalToggle", OnToggle, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.F, Enum.KeyCode.ButtonL3 )
        else
            ContextActionService:UnbindAction( "ThermalToggle" )
        end
    end

    local Flag2Inner = if FlagInner then Flag else FlagInner
    SetActive( Flag2Inner )

    if Flag2 then
        local Clock = os.clock( )

        if Number <= Clock then
            Number = Clock + 0.2
            Rescan( )
        end
        if Success and Number2 <= Clock then
            Number2 = Clock + 0.03333333333333333
            Grain.Position = ScaleUI.FromAbs( Grain, -math.random( 0, GrainPx2 - 1 ), -math.random( 0, GrainPx2 - 1 ) )
        end
    end
end )
