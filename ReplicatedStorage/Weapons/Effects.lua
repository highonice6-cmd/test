-- ReplicatedStorage.Weapons.Effects
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Debris = game:GetService( "Debris" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local Parent = workspace:WaitForChild( "FX" )
local FX = game:GetService( "ReplicatedStorage" ):WaitForChild( "FX" )
local Table = { }

local function AddFlash( Flash )
    if Flash.Name:sub( 1, 11 ) == "MuzzleFlash" and not Flash.Name:find( "FX" ) then
        table.insert( Table, Flash )
    end
end

for Key, Value in FX:GetChildren( ) do
    if Value.Name:sub( 1, 11 ) == "MuzzleFlash" and not Value.Name:find( "FX" ) then
        table.insert( Table, Value )
    end
end

local Tracer6
FX.ChildAdded:Connect( AddFlash )
local SilencerMuzzle = game:GetService( "ReplicatedStorage" ):WaitForChild( "WeaponFX" ):WaitForChild( "SilencerMuzzle", 10 )

local function FxAttachment( Parent, Name, CFrame, Object )
    local FoundChild = Parent:FindFirstChild( Name )

    if FoundChild then
        if FoundChild.CFrame ~= CFrame then
            FoundChild.CFrame = CFrame
        end

        return FoundChild
    end
    local Parent2 = Instance.new( "Attachment" )
    Parent2.Name = Name
    Parent2.CFrame = CFrame
    Parent2.Visible = false

    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            local Clone = Value:Clone( )
            Clone.Enabled = false
            Clone.Parent = Parent2
        end
    end

    Parent2.Parent = Parent
    return Parent2
end

local WeaponVisuals = game:GetService( "ReplicatedStorage" ):WaitForChild( "WeaponVisuals" )
local VisualRegistry = require( script.Parent:WaitForChild( "VisualRegistry" ) )
local GunAudio = require( script.Parent:WaitForChild( "GunAudio" ) )
local Poignee = require( script.Parent:WaitForChild( "Poignee" ) )
local BoltAction = require( script.Parent:WaitForChild( "BoltAction" ) )
local ClientState = require( script.Parent:WaitForChild( "ClientState" ) )
local BulletHoles = require( script.Parent:WaitForChild( "BulletHoles" ) )
local VehicleSurface = require( script.Parent:WaitForChild( "VehicleSurface" ) )
local MetalImpactAudio = require( script.Parent:WaitForChild( "MetalImpactAudio" ) )
local WeaponData = require( script.Parent:WaitForChild( "WeaponData" ) )
local Eau = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Eau" ) )
local FarmZone = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "FarmZone" ) )
local Class = setmetatable( { }, { __mode = "k" } )

local function LiveFlashes( FlashesName )
    if not ( FlashesName and FlashesName.Parent and VisualRegistry[ FlashesName and FlashesName.Parent ] ) or not ( FlashesName and FlashesName.Parent and VisualRegistry[ FlashesName and FlashesName.Parent ] ).Parent then
        return nil
    end

    local Entry2
    local Entry = Class[ FlashesName and FlashesName.Parent and VisualRegistry[ FlashesName and FlashesName.Parent ] ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { }

        for Key, Value in ( FlashesName and FlashesName.Parent and VisualRegistry[ FlashesName and FlashesName.Parent ] ):GetDescendants( ) do
            if Value:IsA( "Attachment" ) and Value.Name:sub( 1, 11 ) == "MuzzleFlash" then
                table.insert( Table, Value )
            end
        end

        Class[ FlashesName and FlashesName.Parent and VisualRegistry[ FlashesName and FlashesName.Parent ] ] = Table
        Entry2 = Table
    end

    local Entry3 = if not ( #Entry2 > 0 ) or not Entry2 then nil else Entry2
    return Entry3
end

local Class2 = setmetatable( { }, { __mode = "k" } )

local function MaxSize( SizeName )
    local Entry = Class2[ SizeName ]

    if Entry then
        return Entry
    end

    local Value1, Number3
    local Keypoints = SizeName.Size.Keypoints
    Value1 = nil
    Number3 = 0

    for Key, Value in Keypoints, nil, nil do
        Number3 = math.max( Number3, Value.Value + Value.Envelope )
    end

    local Value2, Number
    local Keypoints2 = SizeName.Squash.Keypoints
    Value2 = nil
    Number = 0

    for Key2, Value3 in Keypoints2, nil, nil do
        Number = math.max( Number, math.abs( Value3.Value ) + Value3.Envelope )
    end

    local Number2 = Number3 * ( Number + 1 )
    Class2[ SizeName ] = Number2
    return Number2
end

local function EmitAll( Object, Argument2 )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "ParticleEmitter" ) then
            if not Argument2 or not ( MaxSize( Value ) < Argument2 ) then
                local Max
                local EmitCount = Value:GetAttribute( "EmitCount" )

                if EmitCount then
                    Max = EmitCount
                else
                    Max = math.max( 1, ( math.round( Value.Rate * Value.Lifetime.Max ) ) )
                end

                local EmitDelay = Value:GetAttribute( "EmitDelay" )

                if type( EmitDelay ) ~= "number" or not ( EmitDelay > 0 ) then
                    Value:Emit( Max )
                else
                    task.delay( EmitDelay, Value.Emit, Value, Max )
                end
            end
        elseif Value:IsA( "Light" ) then
            Value.Enabled = true
            task.delay( 0.05, function()
                Value.Enabled = false
            end )
        end
    end
end

local function IsSilenced( Self )
    local Silenced = Self:GetAttribute( "Silenced" )

    if Silenced == nil then
        local FoundChild
        local Model = Self:FindFirstChild( "Model" )

        if Model then
            FoundChild = Model
        else
            FoundChild = WeaponVisuals:FindFirstChild( Self:GetAttribute( "Weapon" ) or "" )
        end

        local Flag2

        if FoundChild == nil then
            Flag2 = false
        elseif FoundChild:FindFirstChild( "Silencer", true ) == nil then
            Flag2 = false
        else
            Flag2 = true
        end

        return Flag2
    end
    local Flag = Silenced == true and true or false
    return Flag
end

local Table2 = { IsSilenced = IsSilenced, OnImpact = nil }
local Table3 = {
    Enemy = {
        life = 0.25,
        width = 0.06,
        minAngle = 0.0018,
        taper = 0.15,
        color = Color3.fromRGB( 255, 255, 255 ),
        core = 0.55,
        colored = 0.05,
        brightness = 1.4
    },
    Self = {
        life = 0.12,
        width = 0.035,
        minAngle = 0.0016,
        color = Color3.fromRGB( 255, 255, 255 ),
        core = 0.6,
        colored = 0.05,
        brightness = 1.2
    }
}
local Part = Instance.new( "Part" )
Part.Name = "TracerAnchor"
Part.Anchored = true
Part.Transparency = 1
Part.Size = Vector3.new( 0.10000000149011612, 0.10000000149011612, 0.10000000149011612 )
Part.CanCollide = false
Part.CanQuery = false
Part.CanTouch = false
Part.CastShadow = false
Part.CFrame = CFrame.new( )
Part.Parent = Parent
local Players = game:GetService( "Players" )
local Cosmetics = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Cosmetics" ) )
local Table4 = { }
local Tracer = Cosmetics.Items.Tracer
Tracer6 = if Tracer then Tracer else { }
local Value1 = nil

for Key2, Value2 in Tracer6, nil, nil do
    Table4[ Value2.id ] = Value2.Color
end

local Tracer5

local function ShooterColor( ColorName )
    local PlayerFromCharacter

    if ColorName and ColorName.Parent then
        PlayerFromCharacter = Players:GetPlayerFromCharacter( ColorName and ColorName.Parent )
    else
        PlayerFromCharacter = ColorName and ColorName.Parent
    end

    local TracerFX

    if PlayerFromCharacter then
        TracerFX = PlayerFromCharacter:GetAttribute( "TracerFX" )
    else
        TracerFX = PlayerFromCharacter
    end

    local Entry2

    if TracerFX then
        local Entry = Table4[ TracerFX ]

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

local Table5 = { }
local Tracer2 = Cosmetics.Items.Tracer
Tracer5 = if Tracer2 then Tracer2 else { }
local Value3 = nil

for Key3, Value4 in Tracer5, nil, nil do
    if type( Value4.Template ) == "string" then
        Table5[ Value4.id ] = Value4.Template
    end
end

local Value6
local Table6 = { }

local function GetStyle( TracerFX )
    local Entry = Table6[ TracerFX ]

    if Entry ~= nil or not Table5[ TracerFX ] then
        return Entry or nil
    end

    local Captured = FX

    for Value in string.gmatch( Table5[ TracerFX ], "[^%.]+" ) do
        local Captured2 = if Captured then Captured:FindFirstChild( Value ) else Captured
        Captured = Captured2
    end

    local Tracer

    if Captured then
        Tracer = Captured:FindFirstChild( "Tracer" )
    else
        Tracer = Captured
    end
    if not Tracer then
        return nil
    end

    local Number
    local Table = { }
    local Table2 = { }
    Number = math.huge

    for Key2, Value2 in Tracer:GetDescendants( ) do
        if Value2:IsA( "Beam" ) then
            table.insert( Table, Value2 )
            local Width0 = Value2.Width0
            Number = math.min( Number, Width0, Value2.Width1 )
        elseif Value2:IsA( "BasePart" ) and Value2:FindFirstChildWhichIsA( "ParticleEmitter" ) then
            table.insert( Table2, Value2 )
        end
    end
    if #Table == 0 then
        Table6[ TracerFX ] = false
        return nil
    end
    local Table3 = {
        id = TracerFX,
        beams = Table,
        parts = Table2,
        flash = Captured:FindFirstChild( "MuzzleFlash" ),
        thin = math.max( Number, 0.01 ),
        life = tonumber( ( Tracer:GetAttribute( "LifeScale" ) ) ) or 1.5,
        wscale = tonumber( ( Tracer:GetAttribute( "WidthScale" ) ) ) or 1
    }
    Table6[ TracerFX ] = Table3
    return Table3
end

local function ShooterStyle( StyleName )
    local PlayerFromCharacter

    if StyleName and StyleName.Parent then
        PlayerFromCharacter = Players:GetPlayerFromCharacter( StyleName and StyleName.Parent )
    else
        PlayerFromCharacter = StyleName and StyleName.Parent
    end

    local TracerFX

    if PlayerFromCharacter then
        TracerFX = PlayerFromCharacter:GetAttribute( "TracerFX" )
    else
        TracerFX = PlayerFromCharacter
    end

    local Value2

    if not TracerFX or not Table5[ TracerFX ] then
        Value2 = nil
    else
        local Style = GetStyle( TracerFX )

        if Style then
            Value2 = Style
        else
            Value2 = nil
        end
    end

    return Value2
end

local Table7 = { }

local function SkinShotOf( Key )
    local SkinShot

    if Key and Key.Parent and VisualRegistry[ Key and Key.Parent ] then
        local Parent = ( Key and Key.Parent and VisualRegistry[ Key and Key.Parent ] ).Parent

        if Parent then
            SkinShot = ( Key and Key.Parent and VisualRegistry[ Key and Key.Parent ] ):GetAttribute( "SkinShot" )
        else
            SkinShot = Parent
        end
    else
        SkinShot = Key and Key.Parent and VisualRegistry[ Key and Key.Parent ]
    end
    if type( SkinShot ) == "string" then
        return SkinShot, Key and Key.Parent and VisualRegistry[ Key and Key.Parent ]
    end
    return nil, nil
end

local function SkinStyle( Name )
    local Entry = Table7[ Name ]

    if Entry ~= nil then
        return Entry or nil
    end

    local FoundChild
    local WeaponSkins = game:GetService( "ReplicatedStorage" ):FindFirstChild( "WeaponSkins" )

    if WeaponSkins then
        FoundChild = WeaponSkins:FindFirstChild( Name )
    else
        FoundChild = WeaponSkins
    end

    local Tracer

    if FoundChild then
        Tracer = FoundChild:FindFirstChild( "Tracer" )
    else
        Tracer = FoundChild
    end

    local Tracer2

    if FoundChild then
        Tracer2 = FoundChild:GetAttribute( "Tracer" )
    else
        Tracer2 = FoundChild
    end
    if not Tracer and type( Tracer2 ) == "string" then
        local Captured = FX

        for Value in string.gmatch( Tracer2, "[^%.]+" ) do
            local Captured3 = if Captured then Captured:FindFirstChild( Value ) else Captured
            Captured = Captured3
        end

        local Captured2 = if Captured then Captured:FindFirstChild( "Tracer" ) else Captured
        Tracer = Captured2
    end
    if not Tracer then
        return nil
    end

    local Number
    local Table = { }
    local Table2 = { }
    Number = math.huge

    for Key, Value2 in Tracer:GetDescendants( ) do
        if Value2:IsA( "Beam" ) then
            table.insert( Table, Value2 )
            local Width0 = Value2.Width0
            Number = math.min( Number, Width0, Value2.Width1 )
        elseif Value2:IsA( "BasePart" ) and Value2:FindFirstChildWhichIsA( "ParticleEmitter" ) then
            table.insert( Table2, Value2 )
        end
    end
    if #Table == 0 then
        Table7[ Name ] = false
        return nil
    end
    local Table3 = {
        id = "Skin_" .. Name,
        beams = Table,
        thin = math.max( Number, 0.01 ),
        parts = Table2,
        folder = FoundChild,
        life = tonumber( ( Tracer:GetAttribute( "LifeScale" ) ) ) or 1.5,
        wscale = tonumber( ( Tracer:GetAttribute( "WidthScale" ) ) ) or 1
    }
    Table7[ Name ] = Table3
    return Table3
end

function GunAudio.SkinTone( Name )
    local SkinShot

    if Name and Name.Parent and VisualRegistry[ Name and Name.Parent ] then
        local Parent = ( Name and Name.Parent and VisualRegistry[ Name and Name.Parent ] ).Parent

        if Parent then
            SkinShot = ( Name and Name.Parent and VisualRegistry[ Name and Name.Parent ] ):GetAttribute( "SkinShot" )
        else
            SkinShot = Parent
        end
    else
        SkinShot = Name and Name.Parent and VisualRegistry[ Name and Name.Parent ]
    end

    local Parent2 = if type( SkinShot ) == "string" then SkinShot else nil

    if not Parent2 then
        return nil
    end

    local FoundChild
    local WeaponSkins = game:GetService( "ReplicatedStorage" ):FindFirstChild( "WeaponSkins" )

    if WeaponSkins then
        FoundChild = WeaponSkins:FindFirstChild( Parent2 )
    else
        FoundChild = WeaponSkins
    end

    local ShotTone

    if FoundChild then
        ShotTone = FoundChild:GetAttribute( "ShotTone" )
    else
        ShotTone = FoundChild
    end

    local WeaponSkins2 = if type( ShotTone ) ~= "string" or ShotTone == "" or not ShotTone then nil else ShotTone
    return WeaponSkins2
end
local ModCatalog = require( script.Parent:WaitForChild( "ModCatalog" ) )
function GunAudio.CustomShot( ShotName )
    local ShotSound

    if ShotName then
        ShotSound = ShotName:GetAttribute( "ShotSound" )
    else
        ShotSound = ShotName
    end

    local Entry2

    if type( ShotSound ) == "string" then
        local Entry = ModCatalog.ShotSounds[ ShotSound ]

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
local Value5 = nil
function GunAudio.HearOthersCustom()
    if not Value5 then
        local Controls
        local IsClient = RunService:IsClient( )

        if IsClient then
            Controls = game:GetService( "ReplicatedStorage" ):FindFirstChild( "Controls" )
        else
            Controls = IsClient
        end

        local Success, Result

        if Controls then
            Success, Result = pcall( require, Controls )
        else
            Success = false
            Result = nil
        end
        if not Success or type( Result ) ~= "table" then
            return true
        end

        Value5 = Result
    end

    local Flag

    if type( Value5.Settings ) == "table" then
        if Value5.Settings.EnemyGunSounds == false then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return not Flag
end
local Table8 = { }
local ShotSounds = ModCatalog.ShotSounds
Value6 = nil

for Key4, Value7 in ShotSounds, nil, nil do
    if not Value7.Hidden and type( Value7.Sound ) == "number" then
        table.insert( Table8, Value7.Sound )
    end
end

local Tracer4
GunAudio.PreloadIds( Table8 )
local Class3 = setmetatable( { }, { __mode = "k" } )

local function BullesOf( Key )
    local Entry2
    local Entry = Class3[ Key ]

    if Entry == nil then
        local Bulles = Key:FindFirstChild( "Bulles", true ) or false
        Class3[ Key ] = Bulles
        Entry2 = Bulles
    else
        Entry2 = Entry
    end

    return Entry2 or nil
end

local Table9 = { }

local function SkinLoop( LoopName, Parent, Argument3, Argument4, Flag )
    local SoundId
    local Folder = Argument3.folder

    if Folder then
        SoundId = Argument3.folder:GetAttribute( "Sound" )
    else
        SoundId = Folder
    end
    if type( SoundId ) ~= "string" or SoundId == "" then
        return false
    end

    local Entry2
    local Entry = Table9[ LoopName ]

    if not Entry or Entry.s.Parent == Parent then
        Entry2 = Entry
    else
        Entry.s:Destroy( )
        Table9[ LoopName ] = nil
        Entry2 = nil
    end
    if not Entry2 then
        local Sound = Instance.new( "Sound" )
        Sound.Name = "SkinLoop"
        Sound.SoundId = SoundId
        Sound.Looped = true
        Sound.Volume = 0
        Sound.SoundGroup = GunAudio.FallbackGroup( )
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound.RollOffMinDistance = 20
        Sound.RollOffMaxDistance = 900
        Sound.Parent = Parent
        local Table = { s = Sound }
        Table9[ LoopName ] = Table
        Entry2 = Table
    end

    local Number2
    local Entry3 = WeaponData[ LoopName:GetAttribute( "Weapon" ) ]

    if not Entry3 or not Entry3.Fire then
        Number2 = 600
    else
        local Number = tonumber( Entry3.Fire.RPM )

        if Number then
            Number2 = Number
        else
            Number2 = 600
        end
    end

    local Gap
    Entry2.last = os.clock( )

    if Argument4 then
        local Max = math.max( 0.15, 120 / Number2 )

        if Max then
            Gap = Max
        else
            Gap = 0.35
        end
    else
        Gap = 0.35
    end

    Entry2.gap = Gap

    if Entry2.fade then
        Entry2.fade:Cancel( )
        Entry2.fade = nil
    end

    local Number4
    local S = Entry2.s
    local Number3 = tonumber( Argument3.folder:GetAttribute( "SoundVolume" ) ) or 1
    Number4 = not Flag and 1 or 0.5
    S.Volume = Number3 * Number4

    if not Entry2.s.IsPlaying then
        Entry2.s.TimePosition = 0
        Entry2.s:Play( )
    end

    return true
end

RunService.Heartbeat:Connect( function()
    if next( Table9 ) == nil then
        return
    end

    local Value1
    local Clock = os.clock( )
    Value1 = nil

    for Key, Value in Table9, nil, nil do
        if not Value.s.Parent or not Key.Parent then
            Value.s:Destroy( )
            Table9[ Key ] = nil
        elseif Value.s.IsPlaying and not Value.fade then
            local Clock2 = Clock - Value.last

            if Value.gap < Clock2 then
                local Fade = TweenService:Create( Value.s, TweenInfo.new( 0.12 ), { Volume = 0 } )
                Value.fade = Fade
                Fade.Completed:Connect( function( Argument1 )
                    if Argument1 == Enum.PlaybackState.Completed and Value.fade == Fade then
                        Value.s:Stop( )
                        Value.fade = nil
                    end
                end )
                Fade:Play( )
            end
        end
    end
end )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )

local function FLASH_TRACER_COLOR()
    local Flag = ReplicatedStorage:GetAttribute( "FlashTraceur" ) == true and true or false
    return Flag
end

local function FlashSaturated( Argument1 )
    local ToHSV, ToHSV2 = Argument1:ToHSV( )

    if ToHSV2 < 0.15 then
        return Argument1
    end

    local FromHSV = Color3.fromHSV( ToHSV, 1, 1 )
    local Table = { FromHSV.R, FromHSV.G, FromHSV.B }
    local I = 1

    for I = 1, 3 do
        if Table[ I ] > 0 and Table[ I ] < 1 then
            Table[ I ] = Table[ I ] * Table[ I ]
        end
    end

    return Color3.new( Table[ 1 ], Table[ 2 ], Table[ 3 ] )
end

local Table10 = { }
local Tracer3 = Cosmetics.Items.Tracer
Tracer4 = if Tracer3 then Tracer3 else { }
local Value8 = nil

for Key5, Value9 in Tracer4, nil, nil do
    local StreakColor2
    local Id = Value9.id
    local StreakColor = Value9.StreakColor
    StreakColor2 = if StreakColor then StreakColor else Value9.Color
    Table10[ Id ] = FlashSaturated( StreakColor2 )
end

local function ShooterFlashColor( Parent )
    local Flag = ReplicatedStorage:GetAttribute( "FlashTraceur" ) == true and true or false

    if not Flag then
        return nil
    end

    local PlayerFromCharacter

    if Parent and Parent.Parent then
        PlayerFromCharacter = Players:GetPlayerFromCharacter( Parent and Parent.Parent )
    else
        PlayerFromCharacter = Parent and Parent.Parent
    end
    if not PlayerFromCharacter or PlayerFromCharacter:GetAttribute( "TracerFlash" ) == false then
        return nil
    end

    local Entry2
    local TracerFX = PlayerFromCharacter:GetAttribute( "TracerFX" )

    if TracerFX then
        local Entry = Table10[ TracerFX ]

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

local function TintSequence( Argument1, Argument2 )
    local Value1
    local Keypoints = Argument1.Keypoints
    local Value = Keypoints[ 1 ].Value
    local R = Value.R
    local G = Value.G
    local Max = math.max( R, G, Value.B, 0.001 )
    local Table = { }
    Value1 = nil

    for Key, Value2 in Keypoints, nil, nil do
        local R2 = Value2.Value.R
        local G2 = Value2.Value.G
        local Clamp = math.clamp( math.max( R2, G2, Value2.Value.B ) / Max, 0, 1 )
        table.insert( Table, ColorSequenceKeypoint.new( Value2.Time, Color3.new( Argument2.R * Clamp, Argument2.G * Clamp, Argument2.B * Clamp ) ) )
    end

    return ColorSequence.new( Table )
end

local function TintFlash( Object, Argument2 )
    local ToHex = Argument2 and Argument2:ToHex( ) or nil

    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "ParticleEmitter" ) and Value.LightEmission > 0 and Value:GetAttribute( "FlashTint" ) ~= ToHex then
            local FlashBaseColor2
            local FlashBaseColor = Value:GetAttribute( "FlashBaseColor" )
            local FlashBaseBrightness = Value:GetAttribute( "FlashBaseBrightness" )

            if typeof( FlashBaseColor ) == "ColorSequence" then
                FlashBaseColor2 = FlashBaseColor
            else
                local Color = Value.Color
                Value:SetAttribute( "FlashBaseColor", Color )
                FlashBaseColor2 = Color
            end

            local FlashBaseBrightness2

            if type( FlashBaseBrightness ) == "number" then
                FlashBaseBrightness2 = FlashBaseBrightness
            else
                local Brightness = Value.Brightness
                Value:SetAttribute( "FlashBaseBrightness", Brightness )
                FlashBaseBrightness2 = Brightness
            end

            local Color2
            Value:SetAttribute( "FlashTint", ToHex )

            if Argument2 then
                local TintSequence2 = TintSequence( FlashBaseColor2, Argument2 )

                if TintSequence2 then
                    Color2 = TintSequence2
                else
                    Color2 = FlashBaseColor2
                end
            else
                Color2 = FlashBaseColor2
            end

            local Brightness2
            Value.Color = Color2
            Brightness2 = Argument2 and FlashBaseBrightness2 * 0.5 or FlashBaseBrightness2
            Value.Brightness = Brightness2
        end
    end
end

local function TintLight( Self, Argument2 )
    local ToHex = Argument2 and Argument2:ToHex( ) or nil

    if Self:GetAttribute( "FlashTint" ) == ToHex then
        return
    end

    local FlashBaseColor2
    local FlashBaseColor = Self:GetAttribute( "FlashBaseColor" )

    if typeof( FlashBaseColor ) == "Color3" then
        FlashBaseColor2 = FlashBaseColor
    else
        local Color = Self.Color
        Self:SetAttribute( "FlashBaseColor", Color )
        FlashBaseColor2 = Color
    end

    Self:SetAttribute( "FlashTint", ToHex )
    Self.Color = Argument2 or FlashBaseColor2
end

local Table11 = { }
local Table12 = { }
local Table13 = { }

local function Seq( Amount, Argument2, Argument3 )
    local Total = 1 - ( 1 - Amount ) * Argument2
    return NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 1 ),
        NumberSequenceKeypoint.new( Argument3, Total ),
        NumberSequenceKeypoint.new( 0.85, Total ),
        NumberSequenceKeypoint.new( 1, 1 )
    } )
end

local function NewTracer()
    local Attachment0 = Instance.new( "Attachment" )
    local Attachment1 = Instance.new( "Attachment" )
    Attachment0.Parent = Part
    Attachment1.Parent = Part

    local function Beam()
        local Beam = Instance.new( "Beam" )
        Beam.Attachment0 = Attachment0
        Beam.Attachment1 = Attachment1
        Beam.FaceCamera = true
        Beam.LightEmission = 1
        Beam.LightInfluence = 0
        Beam.Segments = 10
        Beam.Enabled = false
        Beam.Parent = Part
        return Beam
    end

    local Beam2 = Instance.new( "Beam" )
    Beam2.Attachment0 = Attachment0
    Beam2.Attachment1 = Attachment1
    Beam2.FaceCamera = true
    Beam2.LightEmission = 1
    Beam2.LightInfluence = 0
    Beam2.Segments = 10
    Beam2.Enabled = false
    Beam2.Parent = Part
    return { a0 = Attachment0, a1 = Attachment1, core = Beam2 }
end

local function Release( Argument1 )
    Argument1.follow = nil

    if not Argument1.beams then
        Argument1.core.Enabled = false
        table.insert( Table11, Argument1 )
        return
    end

    local Value1
    local Beams = Argument1.beams
    Value1 = nil

    for Key, Value in Beams, nil, nil do
        Value.beam.Enabled = false
    end

    table.insert( Table13[ Argument1.style ], Argument1 )
end

local function NewStyled( Argument1 )
    local Value1
    local Attachment0 = Instance.new( "Attachment" )
    local Attachment1 = Instance.new( "Attachment" )
    Attachment0.Parent = Part
    Attachment1.Parent = Part
    local Table = { }
    local Beams = Argument1.beams
    Value1 = nil

    for Key, Value in Beams, nil, nil do
        local Clone = Value:Clone( )
        Clone.Attachment0 = Attachment0
        Clone.Attachment1 = Attachment1
        Clone.Enabled = false
        Clone.Parent = Part
        local Value2 = Value.Transparency.Keypoints[ 1 ].Value
        local Width0 = Value.Width0
        table.insert( Table, {
            beam = Clone,
            src = Value,
            alpha = Value2,
            rel = math.max( Width0, Value.Width1 ) / Argument1.thin,
            ws = Argument1.wscale
        } )
    end

    return { a0 = Attachment0, a1 = Attachment1, beams = Table, style = Argument1 }
end

local CurrentCamera = workspace.CurrentCamera

local function ClosestOnSegment( Argument1, Argument2, Argument3 )
    local Total = Argument3 - Argument2
    return Argument2 + Total * math.clamp( ( Argument1 - Argument2 ):Dot( Total ) / Total:Dot( Total ), 0, 1 )
end

local function Widths( Argument1, Argument2, Argument3, Argument4 )
    local Max2
    local Position = CurrentCamera.CFrame.Position
    local Width = Argument1.width
    local Max = math.max( Width, ( Argument2 - Position ).Magnitude * Argument1.minAngle )

    if Argument1.taper then
        Max2 = Max * Argument1.taper
    else
        local Width2 = Argument1.width * 0.8
        Max2 = math.max( Width2, ( Argument3 - Position ).Magnitude * Argument1.minAngle * 0.8 )
    end

    return Max * Argument4, Max2 * Argument4
end

local function StyledWidths( St, Argument2, WorldPosition, Argument4, Argument5 )
    local Position = CurrentCamera.CFrame.Position
    local Width0 = Argument2.src.Width0 * Argument2.ws
    local Max = math.max( Width0, ( WorldPosition - Position ).Magnitude * St.minAngle * Argument2.rel )
    local Width1 = Argument2.src.Width1 * Argument2.ws
    local Max2 = math.max( Width1, ( Argument4 - Position ).Magnitude * St.minAngle * Argument2.rel )
    return Max * Argument5, Max2 * Argument5
end

local Table14 = { }

local function TracerBubbles( Argument1, WorldPosition, Argument3 )
    local Total = Argument3 - WorldPosition
    local Magnitude = Total.Magnitude

    if Magnitude < 0.5 then
        return
    end

    local Position = CurrentCamera.CFrame.Position
    local Total2 = Argument3 - WorldPosition

    if ( WorldPosition + Total2 * math.clamp( ( Position - WorldPosition ):Dot( Total2 ) / Total2:Dot( Total2 ), 0, 1 ) - Position ).Magnitude > 250 then
        return
    end

    local Position2
    Position2 = not ( math.abs( Total.Unit.Y ) > 0.99 ) and Vector3.new( 0, 1, 0 ) or Vector3.new( 1, 0, 0 )
    local Value1
    local CFrame2 = CFrame.lookAt( ( WorldPosition + Argument3 ) / 2, Argument3, Position2 ) * CFrame.Angles( 0, 1.5707963267948966, 0 )
    local Parts = Argument1.parts
    Value1 = nil

    for Key, Value in Parts, nil, nil do
        local Entry2
        local Entry = Table14[ Value ]

        if Entry then
            Entry2 = Entry
        else
            local Table = { list = { }, i = 0 }
            Table14[ Value ] = Table
            Entry2 = Table
        end

        local Entry4
        Entry2.i = Entry2.i % 8 + 1
        local Entry3 = Entry2.list[ Entry2.i ]

        if not Entry3 or not Entry3.Parent then
            local Clone = Value:Clone( )

            for Key2, Value2 in Clone:GetChildren( ) do
                if Value2:IsA( "ParticleEmitter" ) then
                    Value2.Enabled = false
                else
                    Value2:Destroy( )
                end
            end

            Clone.Anchored = true
            Clone.CanCollide = false
            Clone.CanQuery = false
            Clone.CanTouch = false
            Clone.CastShadow = false
            Clone.Transparency = 1
            Clone.Parent = Parent
            local List = Entry2.list
            List[ Entry2.i ] = Clone
            Entry4 = Clone
        else
            Entry4 = Entry3
        end

        local Y = Value.Size.Y
        Entry4.Size = Vector3.new( Magnitude, Y, Value.Size.Z )
        Entry4.CFrame = CFrame2

        for Key3, Value3 in Entry4:GetChildren( ) do
            if Value3:IsA( "ParticleEmitter" ) then
                local EmitCount2
                local EmitCount = Value3:GetAttribute( "EmitCount" )
                EmitCount2 = if EmitCount then EmitCount else math.max( 1, ( math.round( Value3.Rate * Value3.Lifetime.Max ) ) )
                Value3:Emit( EmitCount2 )
            end
        end
    end
end

function Table2.Tracer( WorldPosition, WorldPosition2, Argument3, Follow, Argument5, Key )
    local WorldPosition3

    if Argument3 then
        local Position = CurrentCamera.CFrame.Position
        local Total = WorldPosition2 - WorldPosition

        if ( WorldPosition + Total * math.clamp( ( Position - WorldPosition ):Dot( Total ) / Total:Dot( Total ), 0, 1 ) - Position ).Magnitude < 5 then
            local Number
            local RightVector = CurrentCamera.CFrame.RightVector
            Number = not ( math.random( ) < 0.5 ) and 1 or -1
            WorldPosition3 = WorldPosition2 + RightVector * Number * 1.3 + CurrentCamera.CFrame.UpVector * 0.35
        else
            WorldPosition3 = WorldPosition2
        end
    else
        WorldPosition3 = WorldPosition2
    end
    if ( WorldPosition3 - WorldPosition ).Magnitude < 2 then
        return
    end
    if #Table12 >= 80 then
        local Remove = table.remove( Table12, 1 )
        Remove.follow = nil

        if Remove.beams then
            local Value1
            local Beams = Remove.beams
            Value1 = nil

            for Key2, Value in Beams, nil, nil do
                Value.beam.Enabled = false
            end

            table.insert( Table13[ Remove.style ], Remove )
        else
            Remove.core.Enabled = false
            table.insert( Table11, Remove )
        end
    end

    local St

    if Argument3 then
        local Enemy = Table3.Enemy

        if Enemy then
            St = Enemy
        else
            St = Table3.Self
        end
    else
        St = Table3.Self
    end
    if Key then
        local Entry2
        local Entry = Table13[ Key ]
        Entry2 = if Entry then Entry else { }
        local Remove3
        Table13[ Key ] = Entry2
        local Remove2 = table.remove( Table13[ Key ] )

        if Remove2 then
            Remove3 = Remove2
        else
            Remove3 = NewStyled( Key )
        end

        local Wk
        local T0 = os.clock( )
        Remove3.st = St
        Remove3.t0 = T0
        Remove3.follow = Follow
        Remove3.life = St.life * Key.life
        Wk = not Argument3 and 0.85 or 1
        local Value2
        Remove3.wk = Wk
        local A0 = Remove3.a0
        local A1 = Remove3.a1
        A0.WorldPosition = WorldPosition
        A1.WorldPosition = WorldPosition3
        local Beams2 = Remove3.beams
        Value2 = nil

        for Key3, Value3 in Beams2, nil, nil do
            Value3.beam.Segments = 50
            local Beam = Value3.beam
            local Beam2 = Value3.beam
            local Width0, Width1 = StyledWidths( St, Value3, WorldPosition, WorldPosition3, Remove3.wk )
            Beam.Width0 = Width0
            Beam2.Width1 = Width1
            local Beam3 = Value3.beam
            Beam3.Transparency = Seq( Value3.alpha, 1, 0.02 )
            Value3.beam.Enabled = true
        end
        if Key.parts and #Key.parts > 0 then
            TracerBubbles( Key, WorldPosition, WorldPosition3 )
        end

        table.insert( Table12, Remove3 )
        return
    end
    local Remove5
    local Remove4 = table.remove( Table11 )

    if Remove4 then
        Remove5 = Remove4
    else
        Remove5 = NewTracer( )
    end

    local Alpha
    local T02 = os.clock( )
    Remove5.st = St
    Remove5.t0 = T02
    Remove5.follow = Follow
    Alpha = Argument5 and St.colored or St.core
    local Wk2
    Remove5.alpha = Alpha
    Wk2 = not Argument5 and 1 or 1.8
    local Muzzle
    Remove5.wk = Wk2
    Muzzle = not Argument5 and 0.15 or 0.02
    local Segments
    Remove5.muzzle = Muzzle
    local Core = Remove5.core
    Segments = not Argument5 and 10 or 50
    local Max2
    Core.Segments = Segments
    local A02 = Remove5.a0
    local A12 = Remove5.a1
    A02.WorldPosition = WorldPosition
    A12.WorldPosition = WorldPosition3
    local Core2 = Remove5.core
    local Core3 = Remove5.core
    local Wk3 = Remove5.wk
    local Position2 = CurrentCamera.CFrame.Position
    local Width = St.width
    local Max = math.max( Width, ( WorldPosition - Position2 ).Magnitude * St.minAngle )

    if St.taper then
        Max2 = Max * St.taper
    else
        local Width2 = St.width * 0.8
        Max2 = math.max( Width2, ( WorldPosition3 - Position2 ).Magnitude * St.minAngle * 0.8 )
    end

    local Width02 = Max * Wk3
    local Width12 = Max2 * Wk3
    Core2.Width0 = Width02
    Core3.Width1 = Width12
    local Core4 = Remove5.core
    local LightEmission
    Core4.Color = ColorSequence.new( Argument5 or St.color )
    local Core5 = Remove5.core
    Core5.Brightness = St.brightness
    local Core6 = Remove5.core
    LightEmission = not Argument5 and 1 or 0.4
    Core6.LightEmission = LightEmission
    local Core7 = Remove5.core
    local Alpha2 = Remove5.alpha
    Core7.Transparency = Seq( Alpha2, 1, Remove5.muzzle )
    Remove5.core.Enabled = true
    table.insert( Table12, Remove5 )
    return
end
RunService:BindToRenderStep( "Tracers", Enum.RenderPriority.Last.Value, function()
    local Clock = os.clock( )
    local Count = #Table12
    local I = Count

    for I = Count, 1, -1 do
        local Life2
        local Entry = Table12[ I ]
        local Clock2 = Clock - Entry.t0
        local Life = Entry.life
        Life2 = if Life then Life else Entry.st.life
        local Clock3 = Clock2 / Life2

        if Clock3 >= 1 then
            table.remove( Table12, I )
            Entry.follow = nil

            if Entry.beams then
                local Value1
                local Beams = Entry.beams
                Value1 = nil

                for Key, Value in Beams, nil, nil do
                    Value.beam.Enabled = false
                end

                table.insert( Table13[ Entry.style ], Entry )
            else
                Entry.core.Enabled = false
                table.insert( Table11, Entry )
            end
        else
            if Entry.follow and Entry.follow.Parent then
                local A0 = Entry.a0
                A0.WorldPosition = Entry.follow.WorldPosition
            end

            local Clock4 = ( 1 - Clock3 ) ^ 1.6
            local Clock5 = 0.6 + 0.4 * Clock4

            if Entry.beams then
                local Value2
                local Beams2 = Entry.beams
                Value2 = nil

                for Key2, Value3 in Beams2, nil, nil do
                    local Beam = Value3.beam
                    Beam.Transparency = Seq( Value3.alpha, Clock4, 0.02 )
                    local Beam2 = Value3.beam
                    local Beam3 = Value3.beam
                    local St = Entry.st
                    local Width0, Width1 = StyledWidths( St, Value3, Entry.a0.WorldPosition, Entry.a1.WorldPosition, Clock5 * Entry.wk )
                    Beam2.Width0 = Width0
                    Beam3.Width1 = Width1
                end
            else
                local Max2
                local Core = Entry.core
                local Alpha = Entry.alpha
                Core.Transparency = Seq( Alpha, Clock4, Entry.muzzle )
                local Core2 = Entry.core
                local Core3 = Entry.core
                local St2 = Entry.st
                local WorldPosition = Entry.a0.WorldPosition
                local WorldPosition2 = Entry.a1.WorldPosition
                local Clock6 = Clock5 * Entry.wk
                local Position = CurrentCamera.CFrame.Position
                local Width = St2.width
                local Max = math.max( Width, ( WorldPosition - Position ).Magnitude * St2.minAngle )

                if St2.taper then
                    Max2 = Max * St2.taper
                else
                    local Width2 = St2.width * 0.8
                    Max2 = math.max( Width2, ( WorldPosition2 - Position ).Magnitude * St2.minAngle * 0.8 )
                end

                local Width02 = Max * Clock6
                local Width12 = Max2 * Clock6
                Core2.Width0 = Width02
                Core3.Width1 = Width12
            end
        end
    end
end )
local Table15 = {
    metal = "Hit_Sparks",
    grass = "Hit_Grass",
    wood = "Hit_Wood",
    concrete = "Hit_Concrete",
    glass = "Hit_Glass",
    blood = "Hit_Blood",
    water = "Hit_Water",
    plunge = "Player_Plundge_Water"
}
local Number = 3
local Number2 = 0
RunService.Heartbeat:Connect( function()
    Number = 3
    Number2 = Number2 + 1
end )
local Table16 = {
    [ Enum.Material.Metal ] = true,
    [ Enum.Material.DiamondPlate ] = true,
    [ Enum.Material.CorrodedMetal ] = true,
    [ Enum.Material.Foil ] = true
}

local function IsMetal( Object )
    if typeof( Object ) ~= "Instance" or not Object:IsA( "BasePart" ) then
        return false
    end
    if Table16[ Object.Material ] then
        return true
    end

    local Find = WorldRefs.Find( "Cars" )

    if not Find or not Object:IsDescendantOf( Find ) then
        return false
    end

    local Flag
    local Lower = Object.Name:lower( )

    if Lower:sub( 1, 5 ) == "glass" then
        Flag = false
    elseif Lower:sub( 1, 5 ) == "wheel" then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local Table17 = { blood = true, water = true, plunge = true }
local Table18 = { }

local function HitFX( Name, Argument2, Argument3, Argument4 )
    local Entry = Table15[ Name ]

    if not Entry then
        return
    end

    local Magnitude = ( Argument2 - CurrentCamera.CFrame.Position ).Magnitude

    if Magnitude * CurrentCamera.FieldOfView / 70 > 250 then
        return
    end
    if Argument4 then
        if Number <= 0 then
            return
        end

        Number = Number - 1
    end

    local FoundChild
    local Hits = FX:FindFirstChild( "Hits" )

    if not Hits or not Hits:FindFirstChild( Entry ) then
        FoundChild = FX:FindFirstChild( Entry )
    else
        FoundChild = Hits:FindFirstChild( Entry )
    end
    if not FoundChild then
        return
    end

    local Entry3
    local Entry2 = Table18[ Name ]

    if Entry2 then
        Entry3 = Entry2
    else
        local NumberInner, Share, Big
        local Table = { list = { }, next = 0, frame = { }, time = { }, pos = { } }
        Table18[ Name ] = Table
        NumberInner = 0
        Share = true
        Big = 0

        for Key, Value in FoundChild:GetDescendants( ) do
            if Value:IsA( "ParticleEmitter" ) then
                if Value:GetAttribute( "EmitDelay" ) or Value.LockedToPart then
                    Share = false
                end

                NumberInner = math.max( NumberInner, Value.Lifetime.Max )
                Big = math.max( Big, ( MaxSize( Value ) ) )
            elseif Value:IsA( "Light" ) then
                Share = false
            end
        end
        if Name == "metal" and FX:FindFirstChild( "SmokeAndSparks" ) then
            Big = math.huge
        end

        local Life = NumberInner + 0.1
        Table.share = Share
        Table.life = Life
        Table.big = Big
        Entry3 = Table
    end

    local Magnitude3

    if Table17[ Name ] then
        Magnitude3 = nil
    elseif Argument4 or Magnitude > 60 then
        local Magnitude2 = 1 * Magnitude * 2 * math.tan( math.rad( CurrentCamera.FieldOfView ) / 2 ) / math.max( CurrentCamera.ViewportSize.Y, 1080 )

        if Entry3.big < Magnitude2 then
            return
        end
        Magnitude3 = Magnitude2
    else
        Magnitude3 = nil
    end

    local Count2, Flag

    if Entry3.share then
        local Value1, Value2
        local Clock = os.clock( )
        local Count = #Entry3.list
        local I = 1
        Value1 = nil
        Value2 = nil
        Flag = nil

        for I = 1, Count do
            if Number2 - Entry3.frame[ I ] >= 2 then
                local Clock2 = Clock - Entry3.time[ I ]

                if Entry3.life < Clock2 then
                    Value1 = Value1 or I
                elseif ( Entry3.pos[ I ] - Argument2 ).Magnitude <= -1 then
                    Value2 = I
                    Flag = true
                    break
                end
            end

            Value2 = nil
            Flag = nil
        end

        Count2 = Value2 or Value1
    else
        Count2 = nil
        Flag = nil
    end
    if not Count2 and #Entry3.list < 8 then
        local SmokeAndSparks
        local Clone = FoundChild:Clone( )
        Clone.Name = Entry .. "FX"
        Clone.Anchored = true
        Clone.CanCollide = false
        Clone.CanQuery = false
        Clone.CanTouch = false

        if Name == "metal" then
            SmokeAndSparks = FX:FindFirstChild( "SmokeAndSparks" )
        else
            SmokeAndSparks = false
        end

        local ParentInner = Clone:FindFirstChildWhichIsA( "Attachment", true )

        if SmokeAndSparks and ParentInner then
            local Number2Inner = 0

            for Key2, Value3 in ParentInner:GetChildren( ) do
                if Value3:IsA( "ParticleEmitter" ) then
                    Number2Inner = math.max( Number2Inner, Value3.Lifetime.Max )
                end
            end
            for Key3, Value4 in SmokeAndSparks:GetDescendants( ) do
                if Value4:IsA( "ParticleEmitter" ) and Value4.Name == "Smoke" then
                    local Clone2 = Value4:Clone( )
                    Clone2.Enabled = false
                    Clone2.LockedToPart = false
                    Class2[ Clone2 ] = math.huge

                    if not Clone2:GetAttribute( "EmitCount" ) then
                        Clone2:SetAttribute( "EmitCount", 1 )
                    end
                    if Number2Inner > 0 then
                        Clone2.Lifetime = NumberRange.new( Number2Inner )
                    end

                    Clone2.Parent = ParentInner
                end
            end
        end

        Clone.Parent = Parent
        table.insert( Entry3.list, Clone )

        if Entry3.share then
            Count2 = #Entry3.list
        end
    end
    if not Count2 then
        if Entry3.share then
            local Count3 = #Entry3.list
            local I2 = 2

            if Count3 >= 2 then
                Count2 = 1

                for I2 = 2, Count3 do
                    if Entry3.time[ I2 ] < Entry3.time[ Count2 ] then
                        Count2 = I2
                    end
                end
            else
                Count2 = 1
            end
        else
            Entry3.next = Entry3.next % #Entry3.list + 1
            Count2 = Entry3.next
        end
    end

    local Frame = Entry3.frame
    local Time = Entry3.time
    local Clock3 = os.clock( )
    Frame[ Count2 ] = Number2
    Time[ Count2 ] = Clock3

    if not Flag then
        Entry3.pos[ Count2 ] = Argument2
    end

    local Cross2
    local Entry4 = Entry3.list[ Count2 ]
    local Cross = Argument3:Cross( Vector3.new( 0, 0, 1 ) )

    if Cross.Magnitude < 0.1 then
        Cross2 = Argument3:Cross( Vector3.new( 1, 0, 0 ) )
    else
        Cross2 = Cross
    end

    Entry4.CFrame = CFrame.fromMatrix( Argument2, Cross2.Unit, Argument3 )
    EmitAll( Entry4, Magnitude3 )

    for Key4, Value5 in Entry4:GetDescendants( ) do
        if Value5:IsA( "Attachment" ) then
            EmitAll( Value5, Magnitude3 )
        end
    end
end

function Table2.Impact( Object, Argument2, Amount, Argument4, Argument5, Argument6 )
    if not Argument2 or not Amount then
        return
    end
    if Table2.OnImpact then
        pcall( Table2.OnImpact, Object, Argument2, Argument5 )
    end

    local Find4, Find32, Find22

    if typeof( Object ) ~= "Instance" or Object.Name:sub( 1, 6 ) ~= "Armor_" then
        Find4 = Object
        Find32 = Amount
        Find22 = Argument2
    else
        local Find, Find2, Find3

        if Argument4 then
            Find, Find2, Find3 = VehicleSurface.Find( Object, Argument2, Argument4 )
        else
            Find = nil
            Find2 = nil
            Find3 = nil
        end
        if not Find then
            return
        end

        Find4 = Find
        Find32 = Find3
        Find22 = Find2
    end

    local Text
    local SurfaceOf = MetalImpactAudio.SurfaceOf( Find4 )
    Text = if IsMetal( Find4 ) then "metal" else SurfaceOf
    local Find23 = Find22 + Find32 * 0.05
    HitFX( Text, Find23, Find32.Unit, Argument5 )

    if SurfaceOf then
        if not Argument5 or FarmZone.SameSide( Find22 ) then
            MetalImpactAudio.Play( Find4, Find22, SurfaceOf )
        end
    end

    local Spawn = BulletHoles.Spawn
    local Unit = Find32.Unit
    Spawn( Find4, Find22, Unit, not Argument5, Argument6 )
end
function Table2.Shot( Parent, Argument2, Argument3, Argument4, Argument5, Argument6, Argument7, Argument8 )
    local Parent2

    if Parent then
        Parent2 = Poignee.Of( Parent )
    else
        Parent2 = Parent
    end

    local Muzzle

    if Parent2 then
        Muzzle = Parent2:FindFirstChild( "Muzzle" )
    else
        Muzzle = Parent2
    end
    if Parent and not Argument8 then
        BoltAction.Start( Parent )
    end
    if Parent and not Argument8 then
        Parent:SetAttribute( "ShotFX", os.clock( ) )
    end

    local LiveFlashes2 = LiveFlashes( Parent )
    local SkinShot

    if Parent and Parent.Parent and VisualRegistry[ Parent and Parent.Parent ] then
        local Parent3 = ( Parent and Parent.Parent and VisualRegistry[ Parent and Parent.Parent ] ).Parent

        if Parent3 then
            SkinShot = ( Parent and Parent.Parent and VisualRegistry[ Parent and Parent.Parent ] ):GetAttribute( "SkinShot" )
        else
            SkinShot = Parent3
        end
    else
        SkinShot = Parent and Parent.Parent and VisualRegistry[ Parent and Parent.Parent ]
    end

    local Parent4, Parent5

    if type( SkinShot ) == "string" then
        Parent4 = SkinShot
        Parent5 = Parent and Parent.Parent and VisualRegistry[ Parent and Parent.Parent ]
    else
        Parent4 = nil
        Parent5 = nil
    end

    local Value3

    if Parent4 then
        local SkinStyle2 = SkinStyle( Parent4 )

        if SkinStyle2 then
            Value3 = SkinStyle2
        else
            Value3 = nil
        end
    else
        Value3 = nil
    end

    local IsMissing2
    local IsMissing = not Argument5

    if IsMissing then
        if ClientState.Scoped == true then
            IsMissing2 = true
        else
            IsMissing2 = false
        end
    else
        IsMissing2 = IsMissing
    end

    local Flag

    if Parent == nil then
        Flag = false
    else
        Flag = IsSilenced( Parent )
    end

    local SilencerMuzzleInner

    if Parent2 then
        SilencerMuzzleInner = Parent2:FindFirstChild( "SilencerMuzzle" )
    else
        SilencerMuzzleInner = Parent2
    end

    local Of

    if Parent2 then
        if not Parent5 or not LiveFlashes2 or not LiveFlashes2[ 1 ] then
            if not SilencerMuzzleInner or not Flag or not SilencerMuzzleInner then
                if not LiveFlashes2 or not LiveFlashes2[ 1 ] then
                    Of = Muzzle
                else
                    Of = LiveFlashes2[ 1 ]
                end
            else
                Of = SilencerMuzzleInner
            end
        else
            Of = LiveFlashes2[ 1 ]
        end
    else
        Of = Parent2
    end

    local Value5

    if not Value3 or not Parent or Parent:GetAttribute( "Essai" ) == nil or not Value3 then
        local PlayerFromCharacter

        if Parent and Parent.Parent then
            PlayerFromCharacter = Players:GetPlayerFromCharacter( Parent and Parent.Parent )
        else
            PlayerFromCharacter = Parent and Parent.Parent
        end

        local TracerFX

        if PlayerFromCharacter then
            TracerFX = PlayerFromCharacter:GetAttribute( "TracerFX" )
        else
            TracerFX = PlayerFromCharacter
        end
        if not TracerFX or not Table5[ TracerFX ] then
            Value5 = nil
        else
            local Style = GetStyle( TracerFX )

            if Style then
                Value5 = Style
            else
                Value5 = nil
            end
        end
    else
        Value5 = Value3
    end
    if not IsMissing2 then
        if not Argument3 or not Argument6 then
            if Argument3 then
                local WorldPosition
                local Tracer2 = Table2.Tracer
                WorldPosition = Of and Of.WorldPosition or Argument2
                local PlayerFromCharacter3

                if Parent and Parent.Parent then
                    PlayerFromCharacter3 = Players:GetPlayerFromCharacter( Parent and Parent.Parent )
                else
                    PlayerFromCharacter3 = Parent and Parent.Parent
                end

                local TracerFX3

                if PlayerFromCharacter3 then
                    TracerFX3 = PlayerFromCharacter3:GetAttribute( "TracerFX" )
                else
                    TracerFX3 = PlayerFromCharacter3
                end

                local Entry4

                if TracerFX3 then
                    local Entry3 = Table4[ TracerFX3 ]

                    if Entry3 then
                        Entry4 = Entry3
                    else
                        Entry4 = nil
                    end
                else
                    Entry4 = nil
                end

                Tracer2( WorldPosition, Argument3, Argument5, Of, Entry4, Value5 )
            end
        else
            local Tracer = Table2.Tracer
            local PlayerFromCharacter2

            if Parent and Parent.Parent then
                PlayerFromCharacter2 = Players:GetPlayerFromCharacter( Parent and Parent.Parent )
            else
                PlayerFromCharacter2 = Parent and Parent.Parent
            end

            local TracerFX2

            if PlayerFromCharacter2 then
                TracerFX2 = PlayerFromCharacter2:GetAttribute( "TracerFX" )
            else
                TracerFX2 = PlayerFromCharacter2
            end

            local Entry2

            if TracerFX2 then
                local Entry = Table4[ TracerFX2 ]

                if Entry then
                    Entry2 = Entry
                else
                    Entry2 = nil
                end
            else
                Entry2 = nil
            end

            Tracer( Argument6, Argument3, Argument5, nil, Entry2, Value5 )
        end
    end

    local Flag2

    if Argument5 then
        if Parent2 == nil then
            Flag2 = false
        else
            Flag2 = not FarmZone.SameSide( Parent2.Position )
        end
    else
        Flag2 = Argument5
    end

    local Flag4

    if Argument8 or Flag2 or not Parent or not Parent2 then
        Flag4 = false
    else
        local Value6 = if Value3 then SkinLoop( Parent, Parent2, Value3, not Argument5, Flag ) else Value3
        local Flag3
        local Shot = GunAudio.Shot
        local Shot2 = Shot( Parent, Parent2, not Argument5, Flag )
        Flag3 = ( Value6 or Shot2 ) and true or false
        Flag4 = Flag3
    end
    if not Argument8 and Parent and Parent2 and not Argument5 then
        GunAudio.Bolt( Parent, Parent2, true, Flag )
    end

    local Fire
    local IsMissing3 = not Argument8

    if IsMissing3 then
        local NotFlag = not Flag2

        if NotFlag then
            local NotFlag2 = not Flag4

            if NotFlag2 then
                if Parent2 then
                    Fire = Parent2:FindFirstChild( "Fire" )
                else
                    Fire = Parent2
                end
            else
                Fire = NotFlag2
            end
        else
            Fire = NotFlag
        end
    else
        Fire = IsMissing3
    end
    if Fire then
        local Clone = Fire:Clone( )
        Clone.PlaybackSpeed = 1 + ( math.random( ) - 0.5 ) * 0.08
        Clone.SoundGroup = GunAudio.FallbackGroup( )
        Clone.Parent = Parent2
        Clone:Play( )
        Debris:AddItem( Clone, 3 )
    end
    if IsMissing2 or Argument8 then
        Muzzle = nil
    elseif SilencerMuzzleInner and SilencerMuzzle and Flag and not Parent5 then
        for Key, Value in FxAttachment( Parent2, "SilencerMuzzleFX", SilencerMuzzleInner.CFrame, SilencerMuzzle ):GetChildren( ) do
            if Value:IsA( "ParticleEmitter" ) then
                Value:Emit( Value:GetAttribute( "EmitCount" ) or 3 )
            end
        end

        Muzzle = nil
    end

    local Value10

    if not Muzzle or Parent4 then
        Value10 = nil
    else
        local ShooterFlashColor2 = ShooterFlashColor( Parent )

        if ShooterFlashColor2 then
            Value10 = ShooterFlashColor2
        else
            Value10 = nil
        end
    end
    if not Muzzle or not Value5 or not Value5.flash then
        if not Muzzle or not LiveFlashes2 then
            if Muzzle then
                local Entry6
                local Entry5 = Table[ math.random( ( math.max( #Table, 1 ) ) ) ]

                if Entry5 then
                    local Text2 = "MuzzleFlashFX_" .. Entry5.Name
                    Entry6 = FxAttachment( Parent2, Text2, Muzzle.CFrame * CFrame.Angles( -1.5707963267948966, 0, 0 ), Entry5 )
                else
                    Entry6 = Entry5
                end
                if Entry6 then
                    TintFlash( Entry6, Value10 )
                    EmitAll( Entry6 )
                end

                local Light2 = Muzzle:FindFirstChild( "Light" )

                if Light2 then
                    TintLight( Light2, Value10 )
                    Light2.Enabled = true
                    task.delay( 0.05, function()
                        Light2.Enabled = false
                    end )
                end
            end
        else
            local Value8 = nil

            for Key2, Value9 in LiveFlashes2, nil, nil do
                TintFlash( Value9, Value10 )
                EmitAll( Value9 )
            end
        end
    else
        local Item = if LiveFlashes2 then LiveFlashes2[ 1 ] else LiveFlashes2
        local Parent6 = Item and Item.Parent or Parent2
        local CFrame2
        local Text = "StyleFlash_" .. Value5.id
        CFrame2 = Item and Item.CFrame or Muzzle.CFrame * CFrame.Angles( -1.5707963267948966, 0, 0 )
        local Light
        EmitAll( ( FxAttachment( Parent6, Text, CFrame2, Value5.flash ) ) )
        local NotItem = not Item

        if NotItem then
            Light = Muzzle:FindFirstChild( "Light" )
        else
            Light = NotItem
        end
        if Light then
            if Light:GetAttribute( "FlashTint" ) ~= nil then
                local Color2
                local FlashBaseColor = Light:GetAttribute( "FlashBaseColor" )

                if typeof( FlashBaseColor ) == "Color3" then
                    Color2 = FlashBaseColor
                else
                    local Color = Light.Color
                    Light:SetAttribute( "FlashBaseColor", Color )
                    Color2 = Color
                end

                Light:SetAttribute( "FlashTint", nil )
                Light.Color = Color2
            end

            Light.Enabled = true
            task.delay( 0.05, function()
                Light.Enabled = false
            end )
        end
    end
    if Parent5 and not IsMissing2 and not Argument8 then
        local Entry8
        local Entry7 = Class3[ Parent5 ]

        if Entry7 == nil then
            local Bulles = Parent5:FindFirstChild( "Bulles", true ) or false
            Class3[ Parent5 ] = Bulles
            Entry8 = Bulles
        else
            Entry8 = Entry7
        end

        local Entry9 = Entry8 or nil

        if Entry9 then
            EmitAll( Entry9 )
        end
    end
    if Argument2 and Argument3 then
        local Entree = Eau.Entree
        local Entree2 = Entree( Argument2, Argument3 - Argument2 )

        if Entree2 then
            HitFX( "water", Entree2, Vector3.new( 0, 1, 0 ), Argument5 )
        end
    end

    local Total
    local Impact = Table2.Impact
    Total = Argument2 and Argument3 and Argument3 - Argument2 or nil

    if Parent and WeaponData[ Parent:GetAttribute( "Weapon" ) ] then
    end

    Impact( Argument7, Argument3, Argument4, Total, Argument5, Parent and WeaponData[ Parent:GetAttribute( "Weapon" ) ] and ( Parent and WeaponData[ Parent:GetAttribute( "Weapon" ) ] ).Damage.HoleScale )
end
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Include
function Table2.Blood( Argument1, Argument2, Argument3 )
    if typeof( Argument1 ) ~= "Instance" or not Argument1.Parent or typeof( Argument2 ) ~= "Vector3" then
        return
    end

    local Position, Normal3

    if typeof( Argument3 ) ~= "Vector3" or not ( Argument3.Magnitude > 0.01 ) then
        Position = Argument2
        Normal3 = nil
    else
        local Normal
        local Unit = Argument3.Unit
        RaycastParams2.FilterDescendantsInstances = { Argument1 }
        local Raycast = workspace:Raycast( Argument2 - Unit * 3, Unit * 6, RaycastParams2 )

        if Raycast then
            Normal = Raycast.Normal
            Position = Raycast.Position
        else
            Normal = nil
            Position = Argument2
        end

        local Normal2 = if Normal then Normal else -Unit
        Normal3 = Normal2
    end

    HitFX( "blood", Position, Normal3 or Vector3.new( 0, 1, 0 ), false )
end
function Table2.Plunge( Argument1, Argument2 )
    local Flag = Argument2 == true and true or false
    HitFX( "plunge", Argument1, Vector3.new( 0, 1, 0 ), Flag )
end
function Table2.WaterHit( Argument1, Argument2 )
    local Flag = Argument2 == true and true or false
    HitFX( "water", Argument1, Vector3.new( 0, 1, 0 ), Flag )
end
return Table2
