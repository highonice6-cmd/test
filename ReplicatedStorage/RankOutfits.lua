-- ReplicatedStorage.RankOutfits
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Body2
local Table = {
    Dark = Color3.fromRGB( 38, 38, 42 ),
    Stencil = Color3.fromRGB( 24, 24, 28 ),
    AnimeBodies = {
        [ 979 ] = true,
        [ 980 ] = true,
        [ 982 ] = true,
        [ 983 ] = true,
        [ 984 ] = true,
        [ 985 ] = true,
        [ 986 ] = true,
        [ 987 ] = true
    },
    Pieces = {
        { key = "ShoeL", id = 75499229523141, type = "LeftShoe", order = 1 },
        { key = "ShoeR", id = 101242467027541, type = "RightShoe", order = 1 },
        {
            key = "Pants",
            id = 117128296983703,
            type = "Pants",
            order = 2,
            match = "Black_Tactical_Pants"
        },
        {
            key = "Hoodie",
            id = 118503592138957,
            type = "Jacket",
            order = 7,
            match = "bluehoodie_mesh",
            paint = "body"
        },
        {
            key = "Hood",
            id = 130995090159200,
            type = "Neck",
            match = "Accessory (Hoodie)",
            paint = "body",
            scale = Vector3.new( 0.7400000095367432, 0.7400000095367432, 0.7400000095367432 ),
            pos = Vector3.new( 0, -0.05000000074505806, 0.03999999910593033 )
        },
        {
            key = "Mask",
            id = 86002241591390,
            type = "Jacket",
            order = 8,
            match = "Rose Balaclava"
        },
        {
            key = "Gloves",
            id = 137593190188013,
            type = "Jacket",
            order = 8,
            match = "Combat Gloves",
            paint = "rank"
        },
        {
            key = "Vest",
            id = 125693078572709,
            type = "Jacket",
            order = 9,
            match = "Tac Vest",
            paint = "rank"
        },
        {
            key = "Glasses",
            id = 74204514122512,
            type = "Face",
            match = "Tactical_Sunglasses"
        }
    },
    Badges = { }
}

local function Rank( Argument1 )
    local Body2
    Argument1.badge = "rbxassetid://" .. Argument1.badge
    local Body = Argument1.body
    Body2 = if Body then Body else Table.Dark
    Argument1.body = Body2
    return Argument1
end

local function All( Argument1, Argument2, Argument3, List )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        Table[ Value ] = { sa = Argument1, part = Argument2, tint = Argument3 }
    end

    return Table
end

local Table2 = { tint = Color3.fromRGB( 255, 120, 40 ), strength = 2.6 }
local Table3 = { Color3.fromRGB( 255, 220, 170 ), Color3.fromRGB( 255, 110, 30 ) }
local Table4 = { "Gloves", "Hood" }
local Ranks = { }
local Table5 = {
    id = "Bronze",
    name = "Bronze",
    color = Color3.fromRGB( 205, 127, 50 ),
    badge = "120782597473295",
    look = All( "TitaneBronze", Color3.fromRGB( 120, 70, 35 ), nil, Table4 ),
    glow = { tint = Color3.fromRGB( 255, 160, 90 ), strength = 2.5 },
    glint = { Color3.fromRGB( 255, 230, 200 ), Color3.fromRGB( 235, 150, 105 ) }
}
Table5.badge = "rbxassetid://" .. Table5.badge
local Body = Table5.body
Body2 = if Body then Body else Table.Dark
local Body4
Table5.body = Body2
local Table6 = {
    id = "Silver",
    name = "Silver",
    color = Color3.fromRGB( 200, 205, 215 ),
    badge = "120782597473295",
    look = All( "TitaneSilver", Color3.fromRGB( 150, 152, 158 ), nil, Table4 ),
    glow = { tint = Color3.fromRGB( 225, 235, 255 ), strength = 2.2 },
    glint = { Color3.fromRGB( 255, 255, 255 ), Color3.fromRGB( 200, 205, 215 ) }
}
Table6.badge = "rbxassetid://" .. Table6.badge
local Body3 = Table6.body
Body4 = if Body3 then Body3 else Table.Dark
local Body6
Table6.body = Body4
local Table7 = {
    id = "Gold",
    name = "Gold",
    color = Color3.fromRGB( 255, 205, 60 ),
    badge = "120782597473295",
    look = All( "TitaneGold", Color3.fromRGB( 200, 160, 60 ), nil, Table4 ),
    glow = { tint = Color3.fromRGB( 255, 205, 80 ), strength = 2.6 },
    glint = { Color3.fromRGB( 255, 250, 220 ), Color3.fromRGB( 255, 205, 60 ) }
}
Table7.badge = "rbxassetid://" .. Table7.badge
local Body5 = Table7.body
Body6 = if Body5 then Body5 else Table.Dark
local Body8
Table7.body = Body6
local Table8 = {
    id = "Diamond",
    name = "Diamond",
    color = Color3.fromRGB( 120, 190, 255 ),
    badge = "120782597473295",
    look = All( "TitaneDiamond", Color3.fromRGB( 45, 110, 255 ), nil, Table4 ),
    glow = { tint = Color3.fromRGB( 170, 220, 255 ), strength = 2.4 },
    glint = { Color3.fromRGB( 255, 255, 255 ), Color3.fromRGB( 150, 210, 255 ) }
}
Table8.badge = "rbxassetid://" .. Table8.badge
local Body7 = Table8.body
Body8 = if Body7 then Body7 else Table.Dark
local Body10
Table8.body = Body8
local Table9 = {
    id = "Ruby",
    name = "Ruby",
    color = Color3.fromRGB( 225, 25, 60 ),
    badge = "120782597473295",
    look = All( "TitaneRuby", Color3.fromRGB( 200, 8, 42 ), nil, Table4 ),
    glow = { tint = Color3.fromRGB( 255, 35, 75 ), strength = 3.2 },
    glint = { Color3.fromRGB( 255, 220, 230 ), Color3.fromRGB( 255, 40, 80 ) }
}
Table9.badge = "rbxassetid://" .. Table9.badge
local Body9 = Table9.body
Body10 = if Body9 then Body9 else Table.Dark
local Body12
Table9.body = Body10
local Table10 = {
    id = "Champion",
    name = "Champion",
    color = Color3.fromRGB( 150, 70, 255 ),
    badge = "120782597473295",
    look = All( "TitaneChampion", Color3.fromRGB( 40, 40, 48 ), nil, Table4 ),
    glint = { Color3.fromRGB( 255, 255, 255 ), Color3.fromRGB( 200, 120, 255 ) }
}
Table10.badge = "rbxassetid://" .. Table10.badge
local Body11 = Table10.body
Body12 = if Body11 then Body11 else Table.Dark
local Body14
Table10.body = Body12
local Table11 = {
    id = "Top100",
    name = "Top 100",
    color = Color3.fromRGB( 255, 200, 60 ),
    badge = "120782597473295",
    look = {
        Gloves = { sa = "TopGants", part = Color3.fromRGB( 20, 20, 22 ) },
        Hood = { sa = "Top100Capuche", part = Color3.fromRGB( 20, 20, 22 ) },
        Glasses = { sa = "Top100Lunettes", part = Color3.fromRGB( 20, 20, 22 ) }
    },
    glow = Table2,
    glint = Table3
}
Table11.badge = "rbxassetid://" .. Table11.badge
local Body13 = Table11.body
Body14 = if Body13 then Body13 else Table.Dark
local Body16
Table11.body = Body14
local Table12 = {
    id = "Top1",
    name = "Top 1",
    color = Color3.fromRGB( 255, 200, 60 ),
    badge = "120782597473295",
    look = {
        Gloves = { sa = "TopGants", part = Color3.fromRGB( 20, 20, 22 ) },
        Hood = { sa = "Top1Capuche", part = Color3.fromRGB( 20, 20, 22 ) }
    },
    drop = { Mask = true, Glasses = true },
    skull = true,
    fx = "Top1",
    glow = Table2,
    glint = Table3
}
Table12.badge = "rbxassetid://" .. Table12.badge
local Body15 = Table12.body
Body16 = if Body15 then Body15 else Table.Dark
Table12.body = Body16
Ranks[ 1 ] = Table5
Ranks[ 2 ] = Table6
Ranks[ 3 ] = Table7
Ranks[ 4 ] = Table8
Ranks[ 5 ] = Table9
Ranks[ 6 ] = Table10
Ranks[ 7 ] = Table11
Ranks[ 8 ] = Table12
Table.Ranks = Ranks
function Table.Rank( Argument1 )
    local Value1
    local Ranks = Table.Ranks
    Value1 = nil

    for Key, Value in Ranks, nil, nil do
        if Value.id == Argument1 then
            return Value
        end
    end
end
function Table.List( Argument1, Key )
    local Rank = Table.Rank( Argument1 )
    local TableInner = { }

    if not Rank then
        return TableInner
    end

    local Value1
    local Entry = Table.AnimeBodies[ Key ]
    local Pieces = Table.Pieces
    Value1 = nil

    for Key2, Value in Pieces, nil, nil do
        if not Rank.drop or not Rank.drop[ Value.key ] then
            local Pos
            local Table2 = { id = Value.id, type = Value.type, order = Value.order }
            Pos = Entry and Value.animePos or Value.pos
            Table2.pos = Pos
            Table2.scale = Value.scale
            table.insert( TableInner, Table2 )
        end
    end

    local Add2
    local Add = Rank.add
    Add2 = if Add then Add else { }
    local Value2 = nil

    for Key3, Value3 in Add2, nil, nil do
        table.insert( TableInner, Value3 )
    end

    return TableInner
end
local FromRGB = Color3.fromRGB( 10, 10, 12 )

local function PieceOf( Object, Argument2 )
    local Value1
    local Pieces = Table.Pieces
    Value1 = nil

    for Key, Value in Pieces, nil, nil do
        if Value.key == Argument2 and Value.match then
            for Key2, Value2 in Object:GetChildren( ) do
                if Value2:IsA( "Accessory" ) then
                    local Name = Value2.Name

                    if string.find( Name, Value.match, 1, true ) then
                        return Value2:FindFirstChild( "Handle" )
                    end
                end
            end
        end
    end
end

local function Dress( Parent, Argument2, Color, Argument4 )
    local SurfaceAppearance = Parent:FindFirstChildOfClass( "SurfaceAppearance" )

    if not Argument2 or not Argument2.sa then
        if SurfaceAppearance then
            local Color2 = Argument2 and Argument2.color or Color
            SurfaceAppearance.Color = Color2

            if Argument2 and Argument2.reflect then
                Parent.Reflectance = Argument2.reflect
                return
            end
        elseif Parent:IsA( "MeshPart" ) then
            local Color3
            Parent.TextureID = ""
            Color3 = Argument2 and Argument2.color or Color
            Parent.Color = Color3
        end
    else
        if SurfaceAppearance then
            SurfaceAppearance:Destroy( )
        end
        if Parent:IsA( "MeshPart" ) then
            Parent.TextureID = ""
        end

        local FoundChild2
        local Matieres = script:FindFirstChild( "Matieres" )

        if Matieres then
            local FoundChild = Matieres:FindFirstChild( Argument2.sa )

            if FoundChild then
                FoundChild2 = FoundChild
            else
                FoundChild2 = game:GetService( "ReplicatedStorage" ).Weapons[ Argument2.sa ]
            end
        else
            FoundChild2 = game:GetService( "ReplicatedStorage" ).Weapons[ Argument2.sa ]
        end

        local Clone = FoundChild2:Clone( )
        Clone.Name = "RankLook"
        Parent.Reflectance = 0

        if Argument2.tint then
            Clone.Color = Argument2.tint
        end

        local Uri = Clone.EmissiveMaskContent.Uri

        if Uri and Uri ~= "" then
            if Argument4 then
                Clone.EmissiveTint = Argument4.tint
                Clone.EmissiveStrength = Argument4.strength
            end

            Clone:SetAttribute( "GlowBase", Clone.EmissiveStrength )
            Clone:SetAttribute( "GlowTint", Clone.EmissiveTint )
            Clone:AddTag( "RankGlow" )
        end

        Clone.Parent = Parent

        if Argument2.part then
            Parent.Color = Argument2.part
            return
        end
    end
end

local Table13 = { Hoodie = "hoodie", Vest = "vest", Pants = "pants", Mask = "mask" }
local Table14 = { "RankBeforeColor", "RankBeforeReflectance", "RankBeforeTexture" }

local function Stash( Parent )
    if Parent:FindFirstChild( "RankStash" ) then
        return
    end

    local Parent2 = Instance.new( "Folder" )
    Parent2.Name = "RankStash"
    Parent:SetAttribute( "RankBeforeColor", Parent.Color )
    Parent:SetAttribute( "RankBeforeReflectance", Parent.Reflectance )

    if Parent:IsA( "MeshPart" ) then
        Parent:SetAttribute( "RankBeforeTexture", Parent.TextureID )
    end
    for Key, Value in Parent:GetChildren( ) do
        if Value:IsA( "SurfaceAppearance" ) then
            if Value.Name == "RankLook" then
                Value:Destroy( )
            else
                Value.Parent = Parent2
            end
        end
    end

    Parent2.Parent = Parent
end

local function Stencil( Parent, Object )
    for Key, Value in Parent:GetChildren( ) do
        if Value:IsA( "SurfaceAppearance" ) then
            Value:Destroy( )
        end
    end
    if Parent:IsA( "MeshPart" ) then
        Parent.TextureID = ""
    end

    Parent.Color = Table.Stencil
    Parent.Reflectance = 0
    local Clone = Object:Clone( )
    Clone.Name = "RankLook"
    Clone.Parent = Parent
end

local Table15 = { UpperTorso = 2, LeftHand = 1, RightHand = 1 }
local NumberSequence2 = NumberSequence.new( {
    NumberSequenceKeypoint.new( 0, 0 ),
    NumberSequenceKeypoint.new( 0.35, 0.1 ),
    NumberSequenceKeypoint.new( 1, 0 )
} )
local NumberSequence3 = NumberSequence.new( 0.45 )

local function AddGlint( Parent, List, Rate )
    local RankGlint2
    local RankGlint = Parent:FindFirstChild( "RankGlint" )

    if RankGlint then
        RankGlint2 = RankGlint
    else
        local ParticleEmitter = Instance.new( "ParticleEmitter" )
        ParticleEmitter.Name = "RankGlint"
        ParticleEmitter.LightEmission = 1
        ParticleEmitter.LightInfluence = 0
        ParticleEmitter.Lifetime = NumberRange.new( 0.25, 0.55 )
        ParticleEmitter.Speed = NumberRange.new( 0 )
        ParticleEmitter.Rotation = NumberRange.new( 0, 360 )
        ParticleEmitter.ZOffset = 0.3
        ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box
        ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
        ParticleEmitter.LockedToPart = true
        ParticleEmitter.Parent = Parent
        RankGlint2 = ParticleEmitter
    end

    local Item3
    RankGlint2.Texture = "rbxassetid://116403060004639"
    local Item = List[ 1 ]
    local Item2 = List[ 2 ]
    Item3 = if Item2 then Item2 else List[ 1 ]
    RankGlint2.Color = ColorSequence.new( Item, Item3 )
    RankGlint2.Rate = Rate
    RankGlint2.Size = NumberSequence2
    RankGlint2.Brightness = 1.5
    RankGlint2.Transparency = NumberSequence3
end

function Table.Paint( Parent, Argument2 )
    local Rank = Table.Rank( Argument2 )

    if not Rank then
        return false
    end

    local FoundChild
    local Pochoirs = script:FindFirstChild( "Pochoirs" )

    if Pochoirs then
        FoundChild = Pochoirs:FindFirstChild( Rank.id )
    else
        FoundChild = Pochoirs
    end

    local Value1
    local Pieces = Table.Pieces
    Value1 = nil

    for Key, Value in Pieces, nil, nil do
        if Value.match then
            local FoundChild4
            local PieceOf2 = PieceOf( Parent, Value.key )

            if PieceOf2 then
                if FoundChild then
                    local Entry = Table13[ Value.key ]

                    if Entry then
                        local Look2
                        local Look = Rank.look
                        Look2 = if Look then Rank.look[ Value.key ] else Look
                        local NotLook = not Look2

                        if NotLook then
                            FoundChild4 = FoundChild:FindFirstChild( Table13[ Value.key ] )
                        else
                            FoundChild4 = NotLook
                        end
                    else
                        FoundChild4 = Entry
                    end
                else
                    FoundChild4 = FoundChild
                end
            else
                FoundChild4 = PieceOf2
            end
            if FoundChild4 then
                Stash( PieceOf2 )
                Stencil( PieceOf2, FoundChild4 )
            elseif PieceOf2 then
                if not Value.paint then
                    if not Rank.look or not Rank.look[ Value.key ] then
                        continue
                    end
                end

                local Look4
                Stash( PieceOf2 )
                local Look3 = Rank.look
                Look4 = if Look3 then Rank.look[ Value.key ] else Look3
                local Color = Value.paint == "rank" and Rank.color or Rank.body
                Dress( PieceOf2, Look4, Color, Rank.glow )
            end
        end
    end
    for Key2, Value2 in Parent:GetChildren( ) do
        if Value2.Name == "RankBadge" then
            Value2:Destroy( )
        end
    end

    local Value3 = nil

    for Key3, Value4 in Table15, nil, nil do
        local FoundChild3 = Parent:FindFirstChild( Key3 )

        if FoundChild3 and FoundChild3:IsA( "BasePart" ) then
            if Rank.glint then
                AddGlint( FoundChild3, Rank.glint, Value4 )
            else
                local RankGlint = FoundChild3:FindFirstChild( "RankGlint" )

                if RankGlint then
                    RankGlint:Destroy( )
                end
            end
        end
    end

    local Part0 = Parent:FindFirstChild( "UpperTorso" )

    if Part0 then
        local Value5
        local Badges = Table.Badges
        Value5 = nil

        for Key4, Value6 in Badges, nil, nil do
            local FoundChild2 = Part0:FindFirstChild( "Body" .. Value6.side .. "Attachment" )

            if FoundChild2 then
                local Amount
                local Width = Value6.width
                local Width2 = Value6.width / 2
                local Parent2 = Instance.new( "Part" )
                Parent2.Name = "RankBadge"
                Parent2.Size = Vector3.new( Width, Width2, 0.1 )
                Parent2.Color = FromRGB
                Parent2.Material = Enum.Material.SmoothPlastic
                Parent2.CanCollide = false
                Parent2.CanQuery = false
                Parent2.CanTouch = false
                Parent2.Massless = true
                Parent2.CastShadow = false
                local Out = Value6.out - 0.05
                Amount = Value6.side == "Front" and -Out or Out
                local C0 = CFrame.new( FoundChild2.Position.X, Value6.y, FoundChild2.Position.Z + Amount )
                Parent2.CFrame = Part0.CFrame * C0
                local StudsPerTileU = Width / 0.48828125
                local Texture = Instance.new( "Texture" )
                Texture.Texture = Rank[ Value6.field ]
                Texture.Color3 = Rank.color
                Texture.Face = Enum.NormalId[ Value6.side ]
                Texture.StudsPerTileU = StudsPerTileU
                Texture.StudsPerTileV = StudsPerTileU
                local OffsetStudsU = StudsPerTileU / 2 - Width / 2
                local OffsetStudsV = StudsPerTileU / 2 - Width2 / 2
                Texture.OffsetStudsU = OffsetStudsU
                Texture.OffsetStudsV = OffsetStudsV
                Texture.Parent = Parent2
                local Weld = Instance.new( "Weld" )
                Weld.Part0 = Part0
                Weld.Part1 = Parent2
                Weld.C0 = C0
                Weld.Parent = Parent2
                Parent2.Parent = Parent
            end
        end
    end

    return true
end
function Table.Unpaint( Object )
    for Key, Value in Object:GetChildren( ) do
        local Parent
        local IsA2 = Value:IsA( "Accessory" )

        if IsA2 then
            Parent = Value:FindFirstChild( "Handle" )
        else
            Parent = IsA2
        end

        local RankStash

        if Parent then
            RankStash = Parent:FindFirstChild( "RankStash" )
        else
            RankStash = Parent
        end
        if RankStash then
            for Key3, Value3 in Parent:GetChildren( ) do
                if Value3:IsA( "SurfaceAppearance" ) and Value3.Name == "RankLook" then
                    Value3:Destroy( )
                end
            end
            for Key4, Value4 in RankStash:GetChildren( ) do
                Value4.Parent = Parent
            end

            RankStash:Destroy( )
            local Color = Parent:GetAttribute( "RankBeforeColor" )
            local Reflectance = Parent:GetAttribute( "RankBeforeReflectance" )
            local TextureID = Parent:GetAttribute( "RankBeforeTexture" )

            if typeof( Color ) == "Color3" then
                Parent.Color = Color
            end
            if type( Reflectance ) == "number" then
                Parent.Reflectance = Reflectance
            end
            if type( TextureID ) == "string" and Parent:IsA( "MeshPart" ) then
                Parent.TextureID = TextureID
            end

            local Value1 = nil

            for Key5, Value5 in Table14, nil, nil do
                Parent:SetAttribute( Value5, nil )
            end
        end
    end
    for Key2, Value2 in Object:GetChildren( ) do
        if Value2.Name == "RankBadge" then
            Value2:Destroy( )
        end

        local RankGlint
        local IsA = Value2:IsA( "BasePart" )

        if IsA then
            RankGlint = Value2:FindFirstChild( "RankGlint" )
        else
            RankGlint = IsA
        end
        if RankGlint then
            RankGlint:Destroy( )
        end
    end

    Table.SkullOff( Object )
end
Table.SKULL = "RankSkull"
Table.SKULL_PART = "Crane"
Table.Skull = {
    head = 89074783383153,
    scale = 0.7,
    headColor = Color3.fromRGB( 20, 20, 22 ),
    hood = Vector3.new( -0.0015999999595806003, 0.5950999855995178, -0.23270000517368317 ),
    refHood = Vector3.new( 1.007099986076355, 0.8657000064849854, 1.026900053024292 ),
    neck = Vector3.new( 0, 0.48750001192092896, -0.08529999852180481 ),
    size = Vector3.new( 0.6092000007629395, 1.0197999477386475, 0.8478000164031982 ),
    refHead = Vector3.new( 0.6559000015258789, 1.1725000143051147, 0.9126999974250793 )
}

local function SkullSkin( Parent )
    local CraneTop1
    local Matieres = script:FindFirstChild( "Matieres" )

    if Matieres then
        CraneTop1 = script.Matieres:FindFirstChild( "CraneTop1" )
    else
        CraneTop1 = Matieres
    end
    if not CraneTop1 then
        return
    end

    local SurfaceAppearance = Parent:FindFirstChildOfClass( "SurfaceAppearance" )

    if SurfaceAppearance and SurfaceAppearance.Name == "RankLook" then
        return
    end
    if SurfaceAppearance then
        SurfaceAppearance:Destroy( )
    end

    local Clone = CraneTop1:Clone( )
    Clone.Name = "RankLook"
    Clone.Parent = Parent
end

function Table.SkullOn( Object2 )
    local Part0 = Object2:FindFirstChild( "Head" )
    local UpperTorso = Object2:FindFirstChild( "UpperTorso" )

    if not Part0 or not Part0:IsA( "MeshPart" ) or not UpperTorso then
        return false
    end

    local NeckRigAttachment = UpperTorso:FindFirstChild( "NeckRigAttachment" )
    local NeckRigAttachment2 = Part0:FindFirstChild( "NeckRigAttachment" )

    if not NeckRigAttachment or not NeckRigAttachment2 then
        return false
    end

    local Children
    local Skull = Table.Skull
    local Size = Part0.Size / Skull.refHead
    local CFrame2 = NeckRigAttachment.CFrame * NeckRigAttachment2.CFrame:Inverse( )
    local Position = NeckRigAttachment.Position + Skull.neck * Size
    local PieceOf2 = PieceOf( Object2, "Hood" )
    Children = PieceOf2 and PieceOf2:GetChildren( ) or { }
    local Value2, Value3
    Value2 = nil

    for Key, Value in Children, nil, nil do
        if Value:IsA( "Attachment" ) then
            if UpperTorso:FindFirstChild( Value.Name ) then
                Value3 = Value
                break
            end
        end

        Value3 = nil
    end

    local Size3

    if Value3 then
        local CFrame3 = UpperTorso[ Value3.Name ].CFrame * Value3.CFrame:Inverse( )
        local Size2 = PieceOf2.Size / Skull.refHood
        Position = CFrame3.Position + Skull.hood * Size2
        Size3 = Size2
    else
        Size3 = Size
    end

    local FoundChild2
    local C0 = CFrame2:Inverse( ) * CFrame.new( Position )
    local FoundChild = Part0:FindFirstChild( Table.SKULL )

    if not FoundChild or FoundChild:IsA( "Model" ) then
        FoundChild2 = FoundChild
    else
        FoundChild:Destroy( )
        FoundChild2 = nil
    end

    local FoundChild3

    if FoundChild2 then
        FoundChild3 = FoundChild2:FindFirstChild( Table.SKULL_PART )
    else
        FoundChild3 = FoundChild2
    end
    if not FoundChild3 then
        if FoundChild2 then
            FoundChild2:Destroy( )
        end

        local Archivable = Part0.Archivable
        Part0.Archivable = true
        local Part1 = Part0:Clone( )
        Part0.Archivable = Archivable

        if not Part1 then
            return false
        end
        for Key2, Value4 in Part1:GetChildren( ) do
            if not Value4:IsA( "SurfaceAppearance" ) then
                Value4:Destroy( )
            end
        end
        for Value5 in Part1:GetAttributes( ) do
            Part1:SetAttribute( Value5, nil )
        end

        Part1.Name = Table.SKULL_PART
        Part1.Anchored = false
        Part1.Massless = true
        Part1.CastShadow = true
        Part1.CanCollide = false
        Part1.CanQuery = false
        Part1.CanTouch = false
        local Weld = Instance.new( "Weld" )
        Weld.Name = "SurLaTete"
        Weld.Part0 = Part0
        Weld.Part1 = Part1
        Weld.C0 = C0
        Weld.Parent = Part1
        Part1.CFrame = Part0.CFrame * C0
        local Parent = Instance.new( "Model" )
        Parent.Name = Table.SKULL
        Part1.Parent = Parent
        Parent.PrimaryPart = Part1
        Parent.Parent = Part0
        FoundChild3 = Part1
    end

    FoundChild3.Size = Skull.size * Size3
    FoundChild3.Transparency = 0
    FoundChild3.Color = Skull.headColor
    SkullSkin( FoundChild3 )
    local SurLaTete = FoundChild3:FindFirstChild( "SurLaTete" )

    if SurLaTete and SurLaTete.C0 ~= C0 then
        SurLaTete.C0 = C0
    end
    if Part0:GetAttribute( "RankBeforeHeadT" ) == nil then
        Part0:SetAttribute( "RankBeforeHeadT", Part0.Transparency )
    end

    Part0.Transparency = 1
    return true
end
function Table.SkullOff( Object )
    local Head = Object:FindFirstChild( "Head" )

    if not Head then
        return
    end

    local FoundChild = Head:FindFirstChild( Table.SKULL )

    if FoundChild then
        FoundChild:Destroy( )
    end

    local Transparency = Head:GetAttribute( "RankBeforeHeadT" )

    if type( Transparency ) == "number" then
        Head.Transparency = Transparency
        Head:SetAttribute( "RankBeforeHeadT", nil )
    end
end
Table.GLASSES_REL = Vector3.new( 0, 0.004840000066906214, 0.22499999403953552 )
Table.EYE_Y = 0.083
Table.EyeFit = {
    [ "18948278237" ] = { -0.371 },
    [ "132152333177791" ] = { -0.358 },
    [ "18938673844" ] = { -0.34 },
    [ "18938198660" ] = { -0.378 },
    [ "18948419303" ] = { -0.378 },
    [ "18948457873" ] = { -0.344 },
    [ "18939706742" ] = { -0.371 },
    [ "18948329355" ] = { -0.354 },
    [ "18936240081" ] = { -0.358, 0.05 },
    [ "110671572770711" ] = { -0.375, 0.067 }
}
Table.EyeFitOther = { -0.385 }
function Table.FitGlasses( Object2 )
    local Head = Object2:FindFirstChild( "Head" )
    local PieceOf2 = PieceOf( Object2, "Glasses" )

    if not Head or not PieceOf2 then
        return false
    end

    local Entry, Value2

    for Key, Value in PieceOf2:GetChildren( ) do
        if Value:IsA( "Attachment" ) then
            if Head:FindFirstChild( Value.Name ) then
                Entry = Head[ Value.Name ]
                Value2 = Value
                break
            end
        end

        Value2 = nil
        Entry = nil
    end
    if not Value2 then
        return false
    end

    local Entry3
    local Entry2 = Table.EyeFit[ tostring( Head.MeshId ):match( "(%d+)%s*$" ) or "" ]
    Entry3 = if Entry2 then Entry2 else Table.EyeFitOther
    local Item2
    local Size = Head.Size
    local Item = Entry3[ 2 ]
    Item2 = if Item then Item else Table.EYE_Y
    local Item3 = ( Item2 + Table.GLASSES_REL.Y ) * Size.Y
    local Vector32 = Vector3.new( 0, Item3, ( Entry3[ 1 ] + Table.GLASSES_REL.Z ) * Size.Z )
    local CFrame2 = Entry.CFrame * Value2.CFrame:Inverse( )
    Value2.CFrame = ( CFrame.new( Vector32 ) * CFrame2.Rotation ):Inverse( ) * Entry.CFrame
    return true
end
return Table
