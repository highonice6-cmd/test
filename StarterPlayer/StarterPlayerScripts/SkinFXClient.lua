-- StarterPlayer.StarterPlayerScripts.SkinFXClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local RunService = game:GetService( "RunService" )
local CurrentCamera = workspace.CurrentCamera
local FX = workspace:WaitForChild( "FX", 10 )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer
local VisualRegistry = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "VisualRegistry" ) )
local Number = 0
local FromRGB = Color3.fromRGB( 190, 80, 255 )
local FromRGB2 = Color3.fromRGB( 255, 110, 225 )
local Vector22 = Vector2.new( 0.18, 0.11 )
local FromRGB3 = Color3.fromRGB( 255, 105, 30 )
local FromRGB4 = Color3.fromRGB( 255, 195, 110 )
local Table = {
    { vel = Vector2.new( 0.05, -0.035 ) },
    { vel = Vector2.new( 0.015, -0.26 ), twinkle = true }
}
local FromRGB5 = Color3.fromRGB( 175, 110, 255 )
local FromRGB6 = Color3.fromRGB( 120, 130, 255 )
local Table2 = {
    { depth = 1, vel = Vector2.new( 0.012, -0.007 ) },
    { depth = 0.5, vel = Vector2.new( 0.03, -0.012 ) },
    { depth = 0.18, vel = Vector2.new( 0, 0 ), twinkle = true }
}
local FromRGB7 = Color3.fromRGB( 80, 255, 110 )
local Table3 = { { fall = 0.07 }, { fall = 0.125 }, { fall = 0.21, twinkle = true } }
local Table4 = {
    { vel = Vector2.new( 0.07, -0.035 ), surge = true },
    { sweep = 2.2 },
    { vel = Vector2.new( 0.012, 0.02 ), twinkle = true }
}
local Table5 = {
    { vel = Vector2.new( 0.03, -0.015 ) },
    { vel = Vector2.new( 0.012, 0.006 ) }
}
local Vector23 = Vector2.new( 0.05, -0.022 )
local Table6 = { { depth = 0.035 }, { depth = 0.015 } }
local CamoFlow = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "CamoFlow" ) )
local Color32 = Color3.new( 1, 1, 1 )

local function Pulse( Argument1, Argument2 )
    return ( math.exp( -( Argument1 / Argument2 ) ^ 2 ) )
end

local function HellBeat( Clock, Phase )
    local Result = ( Clock / 1.6 + Phase / 6.283185307179586 ) % 1
    return ( math.min( 1, math.exp( -( Result / 0.055 ) ^ 2 ) + math.exp( -( ( Result - 1 ) / 0.055 ) ^ 2 ) + 0.6 * ( math.exp( -( ( Result - 0.2 ) / 0.06 ) ^ 2 ) + math.exp( -( ( Result - 1.2 ) / 0.06 ) ^ 2 ) ) ) )
end

local Table7 = {
    [ Enum.NormalId.Top ] = Vector3.new( 0, 0, 1 ),
    [ Enum.NormalId.Bottom ] = Vector3.new( 0, 0, 1 )
}

local function AnchorOf( Argument1, Key, Pivot )
    local FromNormalId = Vector3.FromNormalId( Argument1.Face )
    local Entry = Table7[ Argument1.Face ] or Vector3.new( 0, 1, 0 )
    local Cross = ( -FromNormalId ):Cross( Entry )
    local Size = Key.Size

    local function Ext( Argument1 )
        return math.abs( Argument1.X ) * Size.X + math.abs( Argument1.Y ) * Size.Y + math.abs( Argument1.Z ) * Size.Z
    end

    local FromNormalId2 = FromNormalId * ( math.abs( FromNormalId.X ) * Size.X + math.abs( FromNormalId.Y ) * Size.Y + math.abs( FromNormalId.Z ) * Size.Z ) / 2 + Entry * ( math.abs( Entry.X ) * Size.X + math.abs( Entry.Y ) * Size.Y + math.abs( Entry.Z ) * Size.Z ) / 2 - Cross * ( math.abs( Cross.X ) * Size.X + math.abs( Cross.Y ) * Size.Y + math.abs( Cross.Z ) * Size.Z ) / 2
    local ToObjectSpace = Pivot:ToObjectSpace( Key.CFrame )
    local ToObjectSpace2 = ToObjectSpace * FromNormalId2
    return ToObjectSpace2:Dot( ToObjectSpace:VectorToWorldSpace( Cross ) ), -ToObjectSpace2:Dot( ToObjectSpace:VectorToWorldSpace( Entry ) )
end

local Table8 = { }
local Table9 = { }

local function Add( Key )
    if not Key:IsA( "BasePart" ) then
        return
    end

    local Entry = Table8[ Key ]

    if Entry and Entry.lodOff then
        local Value1
        local Tex = Entry.tex
        Value1 = nil

        for Key2, Value in Tex, nil, nil do
            if Value.Parent == nil then
                pcall( function()
                    Value.Parent = Key
                end )
            end
        end
    end
    if Entry and Entry.conn then
        Entry.conn:Disconnect( )
    end

    local Model
    local Table = {
        sa = Key:FindFirstChildWhichIsA( "SurfaceAppearance" ),
        tex = { },
        layer = { },
        tile = { },
        au = { },
        av = { },
        style = Key:GetAttribute( "SkinFX" ),
        rl = { },
        ul = { },
        tv = { },
        kind = { },
        spd = { },
        tagGlow = { },
        tagTint = { },
        vset = { },
        lastTr = { },
        bright = { },
        lastCol = { }
    }
    Model = Key:FindFirstAncestorWhichIsA( "Model" ) or Key

    while Model.Parent do
        if not Model.Parent:IsA( "Model" ) or Model.Parent:IsA( "WorldRoot" ) then
            break
        end

        Model = Model.Parent
    end

    local Pivot = Model:IsA( "Model" ) and Model:GetPivot( ) or Key.CFrame

    for Key3, Value2 in Key:GetChildren( ) do
        if Value2:IsA( "Texture" ) then
            if Value2.Name == "SkinFlow" or Value2.Name == "SkinBase" then
                local Value3, Value4 = AnchorOf( Value2, Key, Pivot )

                if Value2.Name == "SkinBase" then
                    local OffsetStudsU = Value3 % Value2.StudsPerTileU
                    local OffsetStudsV = Value4 % Value2.StudsPerTileV
                    Value2.OffsetStudsU = OffsetStudsU
                    Value2.OffsetStudsV = OffsetStudsV
                else
                    table.insert( Table.tex, Value2 )
                    local Layer = Table.layer
                    local Tile = Table.tile
                    local FlowLayer = Value2:GetAttribute( "FlowLayer" ) or 1
                    local StudsPerTileU = Value2.StudsPerTileU
                    Layer[ Value2 ] = FlowLayer
                    Tile[ Value2 ] = StudsPerTileU
                    local Tv = Table.tv
                    local Kind = Table.kind
                    local StudsPerTileV = Value2.StudsPerTileV
                    local FlowKind = Value2:GetAttribute( "FlowKind" )
                    Tv[ Value2 ] = StudsPerTileV
                    Kind[ Value2 ] = FlowKind
                    local Spd = Table.spd
                    Spd[ Value2 ] = Value2:GetAttribute( "FlowSpeed" )

                    if Value2:GetAttribute( "FlowFlip" ) then
                        Table.kind[ Value2 ] = "tagflip"
                    end
                    if Table.kind[ Value2 ] == "tag" or Table.kind[ Value2 ] == "tagflip" then
                        local TagGlow = Table.tagGlow
                        local TagTint = Table.tagTint
                        local TagGlow2 = Value2:GetAttribute( "TagGlow" )
                        local TagTint2 = Value2:GetAttribute( "TagTint" )
                        TagGlow[ Value2 ] = TagGlow2
                        TagTint[ Value2 ] = TagTint2
                        local OffsetStudsV2 = Value2:GetAttribute( "TagV" )

                        if OffsetStudsV2 then
                            Value2.OffsetStudsV = OffsetStudsV2
                        end
                    end

                    local Au = Table.au
                    local Av = Table.av
                    Au[ Value2 ] = Value3
                    Av[ Value2 ] = Value4

                    if Table.style == "Data" then
                        Value2.OffsetStudsU = Value3 % Value2.StudsPerTileU
                    end
                    if Table.style == "Chrome" then
                        local OffsetStudsU2 = Value3 % Value2.StudsPerTileU
                        local OffsetStudsV3 = Value4 % Value2.StudsPerTileV
                        Value2.OffsetStudsU = OffsetStudsU2
                        Value2.OffsetStudsV = OffsetStudsV3
                    end
                    if Table.style == "Ice" then
                        local OffsetStudsU3 = Value3 % Value2.StudsPerTileU
                        local OffsetStudsV4 = Value4 % Value2.StudsPerTileV
                        Value2.OffsetStudsU = OffsetStudsU3
                        Value2.OffsetStudsV = OffsetStudsV4
                    end

                    local FromNormalId = Vector3.FromNormalId( Value2.Face )
                    local Entry2 = Table7[ Value2.Face ] or Vector3.new( 0, 1, 0 )
                    local Rl = Table.rl
                    local Ul = Table.ul
                    Rl[ Value2 ] = ( -FromNormalId ):Cross( Entry2 )
                    Ul[ Value2 ] = Entry2
                end
            end
        end
    end

    local Vp
    Table.phase = string.len( ( Model:GetFullName( ) ) ) * 0.37 % 6.283185307179586
    Table.inWorld = Key:IsDescendantOf( workspace )
    Table.model = Model
    Vp = not Table.inWorld and Key:FindFirstAncestorWhichIsA( "ViewportFrame" ) or nil
    local Showcase
    Table.vp = Vp
    local ArmoryPreview = workspace:FindFirstChild( "ArmoryPreview" )

    if ArmoryPreview == nil then
        Showcase = false
    else
        Showcase = Key:IsDescendantOf( ArmoryPreview )
    end

    Table.showcase = Showcase
    Table8[ Key ] = Table

    if Table.showcase then
        Table9[ Key ] = Table
    end

    Table.conn = Key.ChildAdded:Connect( function( p1 )
        -- Could not structure function #6
    end )
end

for Key, Value in CollectionService:GetTagged( "SkinFX" ) do
    Add( Value )
end

CollectionService:GetInstanceAddedSignal( "SkinFX" ):Connect( Add )
CollectionService:GetInstanceRemovedSignal( "SkinFX" ):Connect( function( Parent )
    local Entry = Table8[ Parent ]

    if Entry and Entry.lodOff and Parent.Parent then
        local Value1
        local Tex = Entry.tex
        Value1 = nil

        for Key, Value in Tex, nil, nil do
            Value.Parent = Parent
        end
    end
    if Entry and Entry.conn then
        Entry.conn:Disconnect( )
    end

    Table8[ Parent ] = nil
    Table9[ Parent ] = nil
end )
local Class = setmetatable( { }, { __mode = "k" } )
local Number2 = -1
local Table10 = { }
local Number3 = 0

local function LodWant( Model, Argument2, Number )
    if Number2 ~= Number then
        Number2 = Number
        Number3 = 0
        table.clear( Table10 )
    end

    local Entry = Table10[ Model ]

    if Entry ~= nil then
        return Entry
    end

    local Flag = Class[ Model ] == true and true or false
    local Position2

    if Model:IsA( "Model" ) then
        local Position = Model:GetPivot( ).Position

        if Position then
            Position2 = Position
        else
            Position2 = nil
        end
    else
        Position2 = nil
    end

    local Flag2

    if Position2 then
        local Magnitude = ( Position2 - Argument2 ).Magnitude * math.clamp( CurrentCamera.FieldOfView / 70, 0.05, 1 )

        if not Flag or not ( Magnitude < 34 ) then
            if Flag or not ( Magnitude > 40 ) then
                Flag2 = Flag
            else
                Flag2 = true
            end
        else
            Flag2 = false
        end
    else
        Flag2 = Flag
    end
    if Flag2 ~= Flag then
        if Number3 < 2 then
            Number3 = Number3 + 1
            Class[ Model ] = Flag2 or nil
        else
            Flag2 = Flag
        end
    end

    Table10[ Model ] = Flag2
    return Flag2
end

local ClientState = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Table11 = { }

local function SceneAuras( Object )
    local Flag2

    if ClientState.FixedCamera ~= nil or ClientState.RobloxCamera ~= nil then
        local Flag

        if ClientState.WardrobeOpen == true then
            Flag = true
        elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            Flag = true
        else
            Flag = false
        end

        Flag2 = not Flag
    else
        Flag2 = false
    end
    if Flag2 then
        local SkinAura

        if Object then
            SkinAura = Object:FindFirstChild( "SkinAura", true )
        else
            SkinAura = Object
        end
        if SkinAura then
            for Key, Value in SkinAura:GetDescendants( ) do
                if Value:IsA( "ParticleEmitter" ) or Value:IsA( "Beam" ) or Value:IsA( "Trail" ) then
                    if Table11[ Value ] == nil then
                        Table11[ Value ] = Value.Enabled
                        Value.Enabled = false

                        if Value:IsA( "ParticleEmitter" ) then
                            Value:Clear( )
                        end
                    end
                end
            end

            return
        end
    elseif next( Table11 ) then
        local Value1 = nil

        for Key2, Value2 in Table11, nil, nil do
            if Key2.Parent then
                Key2.Enabled = Value2
            end
        end

        table.clear( Table11 )
    end
end

local Table12 = { }

for Key2, Value2 in CollectionService:GetTagged( "ClanTagSweep" ) do
    Table12[ Value2 ] = true
end

CollectionService:GetInstanceAddedSignal( "ClanTagSweep" ):Connect( function( Key )
    Table12[ Key ] = true
end )
CollectionService:GetInstanceRemovedSignal( "ClanTagSweep" ):Connect( function( Key )
    Table12[ Key ] = nil
end )
local Number4 = 0
RunService.RenderStepped:Connect( function()
    local Flag
    local Clock = os.clock( )
    Flag = Clock - Number4 >= 0.03333333333333333 and true or false

    if not Flag and next( Table9 ) == nil then
        return
    end
    if Flag then
        Number4 = Clock
        Number = Number + 1
    end

    local Entry2
    local Position = CurrentCamera.CFrame.Position

    if LocalPlayer.Character then
        local Entry = VisualRegistry[ LocalPlayer.Character ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = nil
        end
    else
        Entry2 = nil
    end
    if Flag then
        SceneAuras( Entry2 )
    end
    if Flag and next( Table12 ) then
        local Value1
        local Clock2 = Clock / 6 % 1 * 3 - 1.5
        Value1 = nil

        for Value in Table12, nil, nil do
            if Value.Parent then
                Value.Offset = Vector2.new( Clock2, 0 )
            else
                Table12[ Value ] = nil
            end
        end
    end

    local Flag4 = Number % 2 == 0 and true or false
    local Captured3
    local TableInner = { }
    Captured3 = Flag and Table8 or Table9
    local Value2 = nil

    for Key, Value3 in Captured3, nil, nil do
        if Key.Parent then
            if Flag and #Value3.tex > 0 then
                local InWorld2
                local InWorld = Value3.inWorld

                if InWorld then
                    if Value3.model == Entry2 then
                        InWorld2 = false
                    else
                        local NotShowcase = not Value3.showcase

                        if NotShowcase then
                            if FX == nil then
                                InWorld2 = false
                            elseif Value3.model.Parent == FX then
                                InWorld2 = true
                            else
                                InWorld2 = false
                            end
                        else
                            InWorld2 = NotShowcase
                        end
                    end
                else
                    InWorld2 = InWorld
                end

                local Flag2

                if InWorld2 then
                    local LodWant2 = LodWant( Value3.model, Position, Number )

                    if LodWant2 then
                        Flag2 = LodWant2
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end

                local Flag3 = Value3.lodOff == true and true or false

                if Flag2 ~= Flag3 then
                    local Parent
                    Value3.lodOff = Flag2 or nil
                    Parent = not Flag2 and Key or nil
                    local Value5
                    local Tex = Value3.tex
                    Value5 = nil

                    for Key2, Value6 in Tex, nil, nil do
                        Value6.Parent = Parent
                    end
                end
                if Flag2 then
                    continue
                end
            end
            if not Value3.inWorld or not ( ( Key.Position - Position ).Magnitude > 120 ) then
                if Value3.inWorld and Value3.model ~= Entry2 and not Value3.showcase then
                    if not Flag4 or ( Key.Position - Position ).Magnitude > 70 then
                        continue
                    end
                end

                local Phase = Value3.phase

                if CamoFlow.STYLES[ Value3.style ] then
                    CamoFlow.Step( Value3, Key, Clock, Phase )
                elseif Value3.style == "Chrome" then
                    local Value7
                    local Tex2 = Value3.tex
                    Value7 = nil

                    for Key3, Value8 in Tex2, nil, nil do
                        local Entry3 = Value3.tile[ Value8 ] or 2.2
                        Value8.OffsetStudsU = ( Value3.au[ Value8 ] + Clock * Vector23.X ) % Entry3
                        Value8.OffsetStudsV = ( Value3.av[ Value8 ] + Clock * Vector23.Y ) % Entry3
                    end
                elseif Value3.style == "Hyperstar" then
                    local Value9
                    local Tex3 = Value3.tex
                    Value9 = nil

                    for Key4, Value10 in Tex3, nil, nil do
                        local Entry6
                        local Entry4 = Table5[ Value3.layer[ Value10 ] ]
                        Entry6 = if Entry4 then Entry4 else Table5[ 1 ]
                        local Entry5 = Value3.tile[ Value10 ] or 2.2
                        Value10.OffsetStudsU = ( Value3.au[ Value10 ] + Clock * Entry6.vel.X ) % Entry5
                        Value10.OffsetStudsV = ( Value3.av[ Value10 ] + Clock * Entry6.vel.Y ) % Entry5
                    end
                elseif Value3.style == "Data" then
                    if Value3.sa and Value3.sa.Parent == Key then
                        local Sa = Value3.sa
                        Sa.EmissiveStrength = math.sin( Clock * 23.1 + Phase ) * 0.6 * math.sin( Clock * 9.7 + Phase * 1.7 ) + 2.4

                        if Value3.sa.EmissiveTint ~= FromRGB7 then
                            Value3.sa.EmissiveTint = FromRGB7
                        end
                    end
                    if #Value3.tex > 0 then
                        local Value11
                        local Transparency = ( math.sin( Clock * 3.1 + Phase ) + 1 ) * 0.2 / 2 + 0.05
                        local Tex4 = Value3.tex
                        Value11 = nil

                        for Key5, Value12 in Tex4, nil, nil do
                            local Entry9
                            local Entry7 = Table3[ Value3.layer[ Value12 ] ]
                            Entry9 = if Entry7 then Entry7 else Table3[ 1 ]
                            local Entry8 = Value3.tile[ Value12 ] or 2.2
                            Value12.OffsetStudsV = ( Value3.av[ Value12 ] - Clock * Entry9.fall ) % Entry8

                            if Entry9.twinkle then
                                Value12.Transparency = Transparency
                            end
                        end
                    end
                elseif Value3.style == "Ice" then
                    if #Value3.tex > 0 then
                        local Entry13
                        local Entry10 = TableInner[ Value3.model ]

                        if Entry10 then
                            Entry13 = Entry10
                        else
                            local Captured

                            if not Value3.inWorld or not CurrentCamera then
                                local Vp = Value3.vp

                                if Vp then
                                    Captured = Value3.vp.CurrentCamera
                                else
                                    Captured = Vp
                                end
                            else
                                Captured = CurrentCamera
                            end

                            local Pivot2

                            if Value3.model:IsA( "Model" ) then
                                local Pivot = Value3.model:GetPivot( )

                                if Pivot then
                                    Pivot2 = Pivot
                                else
                                    Pivot2 = Key.CFrame
                                end
                            else
                                Pivot2 = Key.CFrame
                            end

                            local Position3

                            if Captured then
                                local Position2 = Captured.CFrame.Position - Pivot2.Position

                                if Position2 then
                                    Position3 = Position2
                                else
                                    Position3 = Vector3.new( 0, 0, 0 )
                                end
                            else
                                Position3 = Vector3.new( 0, 0, 0 )
                            end

                            TableInner[ Value3.model ] = Position3
                            Entry13 = Position3
                        end

                        local Value13
                        local CFrame = Key.CFrame
                        local Tex5 = Value3.tex
                        Value13 = nil

                        for Key6, Value14 in Tex5, nil, nil do
                            local Entry11 = Table6[ Value3.layer[ Value14 ] ]

                            if Entry11 then
                                local Entry12 = Value3.tile[ Value14 ] or 2.2
                                Value14.OffsetStudsU = ( Value3.au[ Value14 ] - Entry11.depth * Entry13:Dot( CFrame:VectorToWorldSpace( Value3.rl[ Value14 ] ) ) ) % Entry12
                                Value14.OffsetStudsV = ( Value3.av[ Value14 ] + Entry11.depth * Entry13:Dot( CFrame:VectorToWorldSpace( Value3.ul[ Value14 ] ) ) ) % Entry12
                            end
                        end
                    end
                elseif Value3.style == "Void" then
                    if Value3.sa and Value3.sa.Parent == Key then
                        local Sin = ( math.sin( Clock * 1.1 + Phase ) + 1 ) / 2
                        local Sa2 = Value3.sa
                        Sa2.EmissiveStrength = Sin * 2 + 2.2
                        local Sa3 = Value3.sa
                        Sa3.EmissiveTint = FromRGB5:Lerp( FromRGB6, ( math.sin( Clock * 0.37 + Phase ) + 1 ) / 2 )
                    end
                    if #Value3.tex > 0 then
                        local Entry18
                        local Entry14 = TableInner[ Value3.model ]

                        if Entry14 then
                            Entry18 = Entry14
                        else
                            local Captured2

                            if not Value3.inWorld or not CurrentCamera then
                                local Vp2 = Value3.vp

                                if Vp2 then
                                    Captured2 = Value3.vp.CurrentCamera
                                else
                                    Captured2 = Vp2
                                end
                            else
                                Captured2 = CurrentCamera
                            end

                            local Pivot4

                            if Value3.model:IsA( "Model" ) then
                                local Pivot3 = Value3.model:GetPivot( )

                                if Pivot3 then
                                    Pivot4 = Pivot3
                                else
                                    Pivot4 = Key.CFrame
                                end
                            else
                                Pivot4 = Key.CFrame
                            end

                            local Position5

                            if Captured2 then
                                local Position4 = Captured2.CFrame.Position - Pivot4.Position

                                if Position4 then
                                    Position5 = Position4
                                else
                                    Position5 = Vector3.new( 0, 0, 0 )
                                end
                            else
                                Position5 = Vector3.new( 0, 0, 0 )
                            end

                            TableInner[ Value3.model ] = Position5
                            Entry18 = Position5
                        end

                        local Value15
                        local CFrame2 = Key.CFrame
                        local Transparency2 = ( math.sin( Clock * 2.7 + Phase ) + 1 ) * 0.3 / 2 + 0.12
                        local Tex6 = Value3.tex
                        Value15 = nil

                        for Key7, Value16 in Tex6, nil, nil do
                            local Entry17
                            local Entry15 = Table2[ Value3.layer[ Value16 ] ]
                            Entry17 = if Entry15 then Entry15 else Table2[ 1 ]
                            local Entry16 = Value3.tile[ Value16 ] or 2.2
                            local Dot = Entry18:Dot( CFrame2:VectorToWorldSpace( Value3.rl[ Value16 ] ) )
                            local Dot2 = Entry18:Dot( CFrame2:VectorToWorldSpace( Value3.ul[ Value16 ] ) )
                            Value16.OffsetStudsU = ( Value3.au[ Value16 ] - Entry17.depth * Dot + Clock * Entry17.vel.X ) % Entry16
                            Value16.OffsetStudsV = ( Value3.av[ Value16 ] + Entry17.depth * Dot2 + Clock * Entry17.vel.Y ) % Entry16

                            if Entry17.twinkle then
                                Value16.Transparency = Transparency2
                            end
                        end
                    end
                elseif Value3.style == "Clan" then
                    local LastSa
                    local Sa4 = Value3.sa

                    if not Sa4 or Sa4.Parent ~= Key then
                        local Sa5 = Key:FindFirstChildWhichIsA( "SurfaceAppearance" )
                        Value3.sa = Sa5
                        LastSa = Sa5
                    else
                        LastSa = Sa4
                    end

                    local Sin2 = ( math.sin( Clock * 1.6 + Phase ) + 1 ) / 2
                    local Clock3 = ( Clock / 3.2 + Phase / 6.283185307179586 ) % 1
                    local Min = math.min( 1, math.exp( -( ( Clock3 - 0.5 ) / 0.05 ) ^ 2 ) + 0.5 * math.exp( -( ( Clock3 - 0.58 ) / 0.04 ) ^ 2 ) )

                    if LastSa then
                        LastSa.EmissiveStrength = Sin2 * 1.8 + 2.4 + Min * 6
                        local ClanTint = LastSa:GetAttribute( "ClanTint" )

                        if typeof( ClanTint ) == "Color3" then
                            local LastTint = ClanTint:Lerp( Color32, math.floor( Min * 0.4 * 100 + 0.5 ) / 100 )

                            if Value3.lastTint ~= LastTint or Value3.lastSa ~= LastSa then
                                Value3.lastTint = LastTint
                                Value3.lastSa = LastSa
                                LastSa.EmissiveTint = LastTint
                            end
                        end
                    end

                    local Value17
                    local Transparency3 = ( math.sin( Clock * 4.3 + Phase ) + 1 ) * 0.7 / 2 + 0.15
                    local Tex7 = Value3.tex
                    Value17 = nil

                    for Key8, Value18 in Tex7, nil, nil do
                        local Entry21
                        local Entry19 = Table4[ Value3.layer[ Value18 ] ]
                        Entry21 = if Entry19 then Entry19 else Table4[ 1 ]
                        local Entry20 = Value3.tile[ Value18 ] or 2.2

                        if Value3.kind[ Value18 ] == "tag" or Value3.kind[ Value18 ] == "tagflip" then
                            local NumberInner
                            local Entry25 = Value3.au[ Value18 ]
                            local Clock4 = Clock * 0.22
                            NumberInner = Value3.kind[ Value18 ] ~= "tagflip" and 1 or -1
                            Value18.OffsetStudsU = ( Entry25 - Clock4 * NumberInner ) % Entry20
                            local Entry26 = Value3.tagGlow[ Value18 ]

                            if Entry26 then
                                local Entry28
                                local Sin3 = ( math.sin( Clock * 2.2 + Phase ) + 1 ) / 2
                                local Sin4 = Sin3 * Sin3
                                local Entry27 = Value3.tagTint[ Value18 ]
                                Entry28 = if Entry27 then Entry27 else Color32
                                Value18.Color3 = Entry28:Lerp( Entry26, Sin4 )
                                Value18.Transparency = 0.3 - Sin4 * 0.3
                            end
                        elseif Entry21.sweep then
                            local Entry24
                            local Entry22 = Value3.au[ Value18 ]
                            local Entry23 = Value3.spd[ Value18 ]
                            Entry24 = if Entry23 then Entry23 else Entry21.sweep
                            Value18.OffsetStudsU = ( Entry22 - Clock * Entry24 - Phase ) % Entry20

                            if not Value3.vset[ Value18 ] then
                                Value3.vset[ Value18 ] = true
                                Value18.OffsetStudsV = Value3.av[ Value18 ] % Entry20
                            end
                        else
                            Value18.OffsetStudsU = ( Value3.au[ Value18 ] + Clock * Entry21.vel.X + Phase ) % Entry20
                            Value18.OffsetStudsV = ( Value3.av[ Value18 ] + Clock * Entry21.vel.Y ) % Entry20

                            if Entry21.surge then
                                local Transparency4 = math.floor( ( 0.3 - Min * 0.3 ) * 200 + 0.5 ) / 200

                                if Value3.lastTr[ Value18 ] ~= Transparency4 then
                                    Value3.lastTr[ Value18 ] = Transparency4
                                    Value18.Transparency = Transparency4
                                end
                            end
                            if Entry21.twinkle then
                                Value18.Transparency = Transparency3
                            end
                        end
                    end
                elseif Value3.style == "Hellspawn" then
                    local HellBeat2 = HellBeat( Clock, Phase )
                    local Sin5 = math.sin( Clock * 11.3 + Phase ) * 0.35 * math.sin( Clock * 6.7 + Phase * 2 )

                    if Value3.sa and Value3.sa.Parent == Key then
                        local Sa6 = Value3.sa
                        Sa6.EmissiveStrength = math.max( 1, 2.4 + 5 * HellBeat2 + Sin5 )
                        local Sa7 = Value3.sa
                        Sa7.EmissiveTint = FromRGB3:Lerp( FromRGB4, ( math.clamp( HellBeat2 * 0.85 + ( math.sin( Clock * 0.5 + Phase ) + 1 ) * 0.15 / 2, 0, 1 ) ) )
                    end

                    local Value20
                    local Transparency5 = ( math.sin( Clock * 3.3 + Phase ) + 1 ) * 0.12 / 2 + 0.1
                    local Tex8 = Value3.tex
                    Value20 = nil

                    for Key9, Value21 in Tex8, nil, nil do
                        local Entry31
                        local Entry29 = Table[ Value3.layer[ Value21 ] ]
                        Entry31 = if Entry29 then Entry29 else Table[ 1 ]
                        local Entry30 = Value3.tile[ Value21 ] or 2.2
                        Value21.OffsetStudsU = ( Value3.au[ Value21 ] + Clock * Entry31.vel.X + Phase ) % Entry30
                        Value21.OffsetStudsV = ( Value3.av[ Value21 ] + Clock * Entry31.vel.Y ) % Entry30

                        if Entry31.twinkle then
                            Value21.Transparency = Transparency5
                        end
                    end
                else
                    if Value3.sa and Value3.sa.Parent == Key then
                        local Sin6 = ( math.sin( Clock * 2 + Phase ) + 1 ) / 2
                        local Sa8 = Value3.sa
                        Sa8.EmissiveStrength = Sin6 * 3.5 + 3.5
                        local Sa9 = Value3.sa
                        Sa9.EmissiveTint = FromRGB:Lerp( FromRGB2, ( math.sin( Clock * 0.7 + Phase * 0.5 ) + 1 ) / 2 )
                    end
                    if #Value3.tex > 0 then
                        local Value22
                        local Clock5 = ( Clock * Vector22.X + Phase ) % 2.2
                        local Clock6 = Clock * Vector22.Y % 2.2
                        local Transparency6 = ( math.sin( Clock * 2 + Phase + 3.141592653589793 ) + 1 ) * 0.2 / 2 + 0.35
                        local Tex9 = Value3.tex
                        Value22 = nil

                        for Key10, Value23 in Tex9, nil, nil do
                            local OffsetStudsU = ( Clock5 + Value3.au[ Value23 ] ) % 2.2
                            local OffsetStudsV = ( Clock6 + Value3.av[ Value23 ] ) % 2.2
                            Value23.OffsetStudsU = OffsetStudsU
                            Value23.OffsetStudsV = OffsetStudsV
                            Value23.Transparency = Transparency6
                        end
                    end
                end
            end
        else
            Table8[ Key ] = nil
            Table9[ Key ] = nil
        end
    end
end )

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ Upvalue2 ] == Upvalue3 and Upvalue2.Parent and Upvalue2:HasTag( "SkinFX" ) then
    Upvalue4( Upvalue2 )
end
]]
