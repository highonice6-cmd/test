-- StarterPlayer.StarterPlayerScripts.BipodSansPatinsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local AssetService = game:GetService( "AssetService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local WeaponMods = ReplicatedStorage:WaitForChild( "WeaponMods" )
local Success, Result = pcall( function()
    return AssetService:CreateEditableMeshAsync( Content.fromUri( "rbxassetid://113111458560978" ) )
end )

if not Success or not Result then
    warn( "[BipodSansPatins] mesh non chargé : " .. tostring( Result ) )
    return
end

local function Bounds()
    local Position, Position2
    Position = Vector3.new( math.huge, math.huge, math.huge )
    Position2 = Vector3.new( -math.huge, -math.huge, -math.huge )

    for Key, Value in Result:GetVertices( ) do
        local Position3 = Result:GetPosition( Value )
        Position = Position:Min( Position3 )
        Position2 = Position2:Max( Position3 )
    end

    return Position, Position2
end

local Bounds2, Bounds22 = Bounds( )
local Table = { }

local function Find( Key )
    while Table[ Key ] ~= Key do
        Table[ Key ] = Table[ Table[ Key ] ]
        Key = Table[ Key ]
    end

    return Key
end

local function Union( Key, Key2 )
    while Table[ Key ] ~= Key do
        Table[ Key ] = Table[ Table[ Key ] ]
        Key = Table[ Key ]
    end

    Key2 = Key2

    while Table[ Key2 ] ~= Key2 do
        Table[ Key2 ] = Table[ Table[ Key2 ] ]
        Key2 = Table[ Key2 ]
    end
    if Key ~= Key2 then
        Table[ Key ] = Key2
    end
end

local Table2 = { }

for Key, Value in Result:GetVertices( ) do
    Table[ Value ] = Value
    local Position2 = Result:GetPosition( Value )
    local Format = string.format( "%.3f,%.3f,%.3f", Position2.X, Position2.Y, Position2.Z )

    if Table2[ Format ] then
        local Entry5
        local Entry4 = Table2[ Format ]
        Entry5 = Value

        while Table[ Entry5 ] ~= Entry5 do
            Table[ Entry5 ] = Table[ Table[ Entry5 ] ]
            Entry5 = Table[ Entry5 ]
        end
        while Table[ Entry4 ] ~= Entry4 do
            Table[ Entry4 ] = Table[ Table[ Entry4 ] ]
            Entry4 = Table[ Entry4 ]
        end
        if Entry5 ~= Entry4 then
            Table[ Entry5 ] = Entry4
        end
    else
        Table2[ Format ] = Value
    end
end

local Value1
local Faces = Result:GetFaces( )
Value1 = nil

for Key2, Value2 in Faces, nil, nil do
    local Item2
    local FaceVertices = Result:GetFaceVertices( Value2 )
    local Item = FaceVertices[ 2 ]
    Item2 = FaceVertices[ 1 ]

    while Table[ Item2 ] ~= Item2 do
        Table[ Item2 ] = Table[ Table[ Item2 ] ]
        Item2 = Table[ Item2 ]
    end
    while Table[ Item ] ~= Item do
        Table[ Item ] = Table[ Table[ Item ] ]
        Item = Table[ Item ]
    end
    if Item2 ~= Item then
        Table[ Item2 ] = Item
    end

    local Item4
    local Item3 = FaceVertices[ 3 ]
    Item4 = FaceVertices[ 2 ]

    while Table[ Item4 ] ~= Item4 do
        Table[ Item4 ] = Table[ Table[ Item4 ] ]
        Item4 = Table[ Item4 ]
    end
    while Table[ Item3 ] ~= Item3 do
        Table[ Item3 ] = Table[ Table[ Item3 ] ]
        Item3 = Table[ Item3 ]
    end
    if Item4 ~= Item3 then
        Table[ Item4 ] = Item3
    end
end

local Table3 = { }
local Table4 = { }

for Key3, Value3 in Result:GetVertices( ) do
    local Entry2 = Value3

    while Table[ Entry2 ] ~= Entry2 do
        Table[ Entry2 ] = Table[ Table[ Entry2 ] ]
        Entry2 = Table[ Entry2 ]
    end

    local Position = Result:GetPosition( Value3 )
    local Entry3 = Table3[ Entry2 ] or math.huge
    Table3[ Entry2 ] = math.min( Entry3, Position.Y )

    if not Table4[ Entry2 ] or Table4[ Entry2 ].Y < Position.Y then
        Table4[ Entry2 ] = Position
    end
end
for Key4, Value4 in Result:GetVertices( ) do
    local Entry = Value4

    while Table[ Entry ] ~= Entry do
        Table[ Entry ] = Table[ Table[ Entry ] ]
        Entry = Table[ Entry ]
    end
    if Table3[ Entry ] < Bounds2.Y + 0.01 then
        Result:SetPosition( Value4, Table4[ Entry ] )
    end
end

local Bounds3, Bounds23 = Bounds( )
local Success2, Result2 = pcall( function()
    return AssetService:CreateMeshPartAsync( Content.fromObject( Result ) )
end )

if not Success2 or not Result2 then
    warn( "[BipodSansPatins] mesh découpé non créé : " .. tostring( Result2 ) )
    return
end

local Bounds24 = Bounds22 - Bounds2
local Bounds25 = Bounds23 - Bounds3
local Bounds4 = ( Bounds3 + Bounds23 ) / 2 - ( Bounds2 + Bounds22 ) / 2

local function Apply( Self )
    if not Self:IsA( "MeshPart" ) or Self.MeshId ~= "rbxassetid://113111458560978" or Self:GetAttribute( "SansPatins" ) then
        return
    end
    local Size = Self.Size / Bounds24
    local CFrame2 = Self.CFrame * CFrame.new( Bounds4 * Size )
    Self:ApplyMesh( Result2 )
    Self.Size = Bounds25 * Size
    Self.CFrame = CFrame2
    Self:SetAttribute( "SansPatins", true )
    return
end

for Key5, Value5 in WeaponMods:GetDescendants( ) do
    Apply( Value5 )
end

WeaponMods.DescendantAdded:Connect( Apply )
local Table5 = { }

local function Watch( Key )
    if not Key or Table5[ Key ] then
        return
    end

    Table5[ Key ] = true

    for Key2, Value in Key:GetDescendants( ) do
        Apply( Value )
    end

    Key.DescendantAdded:Connect( Apply )
end

Watch( ReplicatedStorage:FindFirstChild( "WeaponSkins" ) )
ReplicatedStorage.ChildAdded:Connect( function( Key )
    if Key.Name == "WeaponSkins" then
        Watch( Key )
    end
end )
