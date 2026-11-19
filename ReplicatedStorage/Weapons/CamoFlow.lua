-- ReplicatedStorage.Weapons.CamoFlow
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table2 = {
    [ Enum.NormalId.Top ] = Vector3.new( 0, 0, 1 ),
    [ Enum.NormalId.Bottom ] = Vector3.new( 0, 0, 1 )
}
local Table = {
    STYLES = { EventChroma = { cycle = 6.2 }, EventNeon = { }, EventMagma = { } },
    AnchorOf = function( Argument1, Argument2, Argument3 )
        local FromNormalId = Vector3.FromNormalId( Argument1.Face )
        local Entry = Table2[ Argument1.Face ] or Vector3.new( 0, 1, 0 )
        local Cross = ( -FromNormalId ):Cross( Entry )
        local Size = Argument2.Size

        local function Ext( Argument1 )
            return math.abs( Argument1.X ) * Size.X + math.abs( Argument1.Y ) * Size.Y + math.abs( Argument1.Z ) * Size.Z
        end

        local FromNormalId2 = FromNormalId * ( math.abs( FromNormalId.X ) * Size.X + math.abs( FromNormalId.Y ) * Size.Y + math.abs( FromNormalId.Z ) * Size.Z ) / 2 + Entry * ( math.abs( Entry.X ) * Size.X + math.abs( Entry.Y ) * Size.Y + math.abs( Entry.Z ) * Size.Z ) / 2 - Cross * ( math.abs( Cross.X ) * Size.X + math.abs( Cross.Y ) * Size.Y + math.abs( Cross.Z ) * Size.Z ) / 2
        local ToObjectSpace = Argument3:ToObjectSpace( Argument2.CFrame )
        local ToObjectSpace2 = ToObjectSpace * FromNormalId2
        return ToObjectSpace2:Dot( ToObjectSpace:VectorToWorldSpace( Cross ) ), -ToObjectSpace2:Dot( ToObjectSpace:VectorToWorldSpace( Entry ) )
    end
}
function Table.Rec( Object, Argument2 )
    local TableInner = {
        style = Object:GetAttribute( "SkinFX" ),
        tex = { },
        au = { },
        av = { },
        tile = { },
        tv = { }
    }

    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "Texture" ) and Value.Name == "SkinFlow" then
            table.insert( TableInner.tex, Value )
            local Au = TableInner.au
            local Av = TableInner.av
            local AnchorOf, AnchorOf2 = Table.AnchorOf( Value, Object, Argument2 )
            Au[ Value ] = AnchorOf
            Av[ Value ] = AnchorOf2
            local Tile = TableInner.tile
            local Tv = TableInner.tv
            local StudsPerTileU = Value.StudsPerTileU
            local StudsPerTileV = Value.StudsPerTileV
            Tile[ Value ] = StudsPerTileU
            Tv[ Value ] = StudsPerTileV
        end
    end

    return TableInner
end

local function Hue( LastHue )
    local Result = LastHue % 360 / 60

    local function F( Argument1 )
        local Captured = ( Argument1 + Result ) % 6
        return 1 - math.max( 0, ( math.min( Captured, 4 - Captured, 1 ) ) )
    end

    local Result2 = ( 5 + Result ) % 6
    local Max = 1 - math.max( 0, ( math.min( Result2, 4 - Result2, 1 ) ) )
    local Result3 = ( 3 + Result ) % 6
    local Max2 = 1 - math.max( 0, ( math.min( Result3, 4 - Result3, 1 ) ) )
    local Result4 = ( 1 + Result ) % 6
    local Max3 = 1 - math.max( 0, ( math.min( Result4, 4 - Result4, 1 ) ) )
    return Max, Max2, Max3
end

local function Q( Argument1, Argument2 )
    return math.floor( Argument1 / Argument2 + 0.5 ) * Argument2
end

function Table.Step( Argument1, Argument2, Argument3, Amount, Amount2 )
    local Entry = Table.STYLES[ Argument1.style ]

    if not Entry then
        return
    end

    local Cf3
    local Number = Amount2 or 1
    local Cf = Argument1.cf

    if Cf then
        Cf3 = Cf
    else
        local Cf2 = { }
        Argument1.cf = Cf2
        Cf3 = Cf2
    end

    local Floor5

    if Entry.cycle then
        local LastHue = math.floor( ( Argument3 / Entry.cycle * 360 + Amount * 30 ) / 4 + 0.5 ) * 4

        if Argument1.lastHue == LastHue then
            Floor5 = LastHue
        else
            Argument1.lastHue = LastHue
            Argument2.Color = Color3.new( Hue( LastHue ) )
            Floor5 = LastHue
        end
    else
        Floor5 = nil
    end

    local Value1
    local Tex = Argument1.tex
    Value1 = nil

    for Key, Value in Tex, nil, nil do
        local Entry3
        local Entry2 = Cf3[ Value ]

        if Entry2 then
            Entry3 = Entry2
        else
            local TableInner = {
                vel = Value:GetAttribute( "FlowVel" ),
                hue = Value:GetAttribute( "FlowHue" ),
                b = Value:GetAttribute( "FlowBright" ) or 1
            }
            Cf3[ Value ] = TableInner
            Entry3 = TableInner
        end

        local Vel = Entry3.vel

        if typeof( Vel ) == "Vector2" then
            local Entry6
            local Entry4 = Argument1.tile[ Value ]
            Entry6 = if Entry4 then Entry4 else Value.StudsPerTileU
            local Entry7
            local Entry5 = Argument1.tv[ Value ]
            Entry7 = if Entry5 then Entry5 else Value.StudsPerTileV
            local Lu = math.floor( ( ( Argument1.au[ Value ] or 0 ) + Number * ( Argument3 * Vel.X + Amount * 0.3 ) ) % Entry6 / 0.006 + 0.5 ) * 0.006
            local Lv = math.floor( ( ( Argument1.av[ Value ] or 0 ) + Number * Argument3 * Vel.Y ) % Entry7 / 0.006 + 0.5 ) * 0.006

            if Entry3.lu ~= Lu then
                Entry3.lu = Lu
                Value.OffsetStudsU = Lu
            end
            if Entry3.lv ~= Lv then
                Entry3.lv = Lv
                Value.OffsetStudsV = Lv
            end
        end
        if Floor5 and Entry3.hue then
            local Lh = Floor5 + Entry3.hue

            if Entry3.lh ~= Lh then
                Entry3.lh = Lh
                local Floor = Lh % 360 / 60

                local function F( Argument1 )
                    local Captured = ( Argument1 + Floor ) % 6
                    return 1 - math.max( 0, ( math.min( Captured, 4 - Captured, 1 ) ) )
                end

                local Floor2 = ( 5 + Floor ) % 6
                local Max = 1 - math.max( 0, ( math.min( Floor2, 4 - Floor2, 1 ) ) )
                local Floor3 = ( 3 + Floor ) % 6
                local Max2 = 1 - math.max( 0, ( math.min( Floor3, 4 - Floor3, 1 ) ) )
                local Floor4 = ( 1 + Floor ) % 6
                local Max3 = 1 - math.max( 0, ( math.min( Floor4, 4 - Floor4, 1 ) ) )
                Value.Color3 = Color3.new( Max * Entry3.b, Max2 * Entry3.b, Max3 * Entry3.b )
            end
        end
    end
end
return Table
