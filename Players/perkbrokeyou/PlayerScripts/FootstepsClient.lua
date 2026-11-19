-- Players.perkbrokeyou.PlayerScripts.FootstepsClient
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
local ContentProvider = game:GetService( "ContentProvider" )
local CollectionService = game:GetService( "CollectionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local CrouchAnim = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "CrouchAnim" ) )
local FrameCache = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "FrameCache" ) )
local LocalPlayer = Players.LocalPlayer
local Table = { concrete = 1.04, tile = 1.1, wood = 0.96, planks = 0.9 }
local Table2 = { concrete = 1, tile = 1.05, wood = 0.95, planks = 1 }
local Table3 = {
    shoes = { 8659587201, 8659587560, 8659587981, 8659588451 },
    concrete = {
        80761632071414,
        76353333185990,
        78911742598635,
        74355740947839,
        76917027608612,
        105287229875125
    },
    grass = {
        74613570357402,
        115467805684506,
        139667774868914,
        96838481971398,
        113824261411922
    },
    wood = {
        112726790019701,
        104712504124080,
        92827480730622,
        120411580927469,
        103685821949790,
        136048161800254
    },
    planks = {
        92923866257079,
        134105481033647,
        140525304232464,
        86804973630253,
        126265702355433,
        111687616849025
    },
    metal = {
        95628179959591,
        133926071537516,
        82985997827353,
        104835096742020,
        73876215935116,
        116836614726509
    },
    grate = {
        106405856376224,
        140728903346385,
        94198658283840,
        96252464848099,
        122747308545707,
        106572515637869
    },
    tile = {
        137739068850330,
        123505484715995,
        80080835937086,
        90064835964777,
        82889124715470,
        134697988648544
    },
    gravel = {
        86417628408625,
        137126382236044,
        74788199242398,
        103840048741486,
        88618834689506,
        106444978081713
    },
    sand = {
        137457789801100,
        128159562878534,
        84244171574112,
        118803514277035,
        107705372674807,
        126609314397448
    },
    water = {
        127535679679925,
        131880769929031,
        96891952448950,
        103863982209862,
        115018079861770,
        95647321550529
    }
}
local Table4 = {
    water = 1.1,
    shoes = 1,
    concrete = 1,
    grass = 1.1,
    wood = 1,
    planks = 0.95,
    metal = 0.85,
    grate = 0.8,
    tile = 0.95,
    gravel = 0.9,
    sand = 1.05
}
local Table5 = {
    crouch = { volume = 0.4, pitch = 0.75, stride = 3.2 },
    walk = { volume = 0.4, pitch = 1, stride = 5.5 },
    sprint = { volume = 0.42, pitch = 0.96, stride = 7 }
}
local Table6 = { }
local Table7 = {
    Grass = "grass",
    LeafyGrass = "grass",
    Ground = "grass",
    Mud = "grass",
    Sand = "sand",
    Snow = "sand",
    Pebble = "gravel",
    Wood = "wood",
    WoodPlanks = "planks",
    Metal = "metal",
    CorrodedMetal = "metal",
    DiamondPlate = "grate",
    Foil = "metal",
    Marble = "tile",
    Glass = "tile",
    Ice = "tile",
    Granite = "tile"
}
Value1 = nil

for Key, Value in Table7, nil, nil do
    local Success, Result = pcall( function()
        return Enum.Material[ Key ]
    end )

    if Success and Result then
        Table6[ Result ] = Value
    end
end

local Value2
local Table8 = {
    { "WATER_SEWER", "water" },
    { "GRATE", "grate" },
    { "GRILL", "grate" },
    { "CATWALK", "grate" },
    { "GRASS", "grass" },
    { "LAWN", "grass" },
    { "PELOUSE", "grass" },
    { "DIRT", "grass" },
    { "MUD", "grass" },
    { "GRAVEL", "gravel" },
    { "SAND", "sand" },
    { "PLANK", "planks" },
    { "DECK", "planks" },
    { "PIER", "planks" },
    { "DOCK", "planks" },
    { "WOOD", "wood" },
    { "PARQUET", "wood" },
    { "FLOOR", "wood" },
    { "METAL", "metal" },
    { "STEEL", "metal" },
    { "IRON", "metal" },
    { "CONTAINER", "metal" },
    { "ROOF", "metal" },
    { "TILE", "tile" },
    { "MARBLE", "tile" },
    { "CERAMIC", "tile" },
    { "BATH", "tile" },
    { "CARPET", "carpet" },
    { "RUG", "carpet" }
}
local Class = setmetatable( { }, { __mode = "k" } )

local function SetOf( Raycast )
    local Instance = Raycast.Instance

    if Instance:IsA( "Terrain" ) then
        return Table6[ Raycast.Material ] or "concrete"
    end

    local Entry = Class[ Instance ]

    if Entry then
        return Entry
    end

    local Item
    local Entry2 = Table6[ Instance.Material ]

    if Entry2 then
        Item = Entry2
    else
        local Name3
        local Name = Instance.Name

        if Instance.Parent then
            local Name2 = Instance.Parent.Name

            if Name2 then
                Name3 = Name2
            else
                Name3 = ""
            end
        else
            Name3 = ""
        end

        local Value1
        local Upper = ( Name .. " " .. Name3 ):upper( )
        Value1 = nil

        for Key, Value in Table8, nil, nil do
            if Upper:find( Value[ 1 ], 1, true ) then
                Item = Value[ 2 ]
                break
            end

            Item = Entry2
        end
    end

    local Entry3 = Item or "concrete"
    Class[ Instance ] = Entry3
    return Entry3
end

local Table9 = { }
Value2 = nil

for Key2, Value3 in Table3, nil, nil do
    local Value12 = nil

    for Key7, Value13 in Value3, nil, nil do
        table.insert( Table9, "rbxassetid://" .. Value13 )
    end
end

local Value4
local Table10 = { }
Value4 = nil

for Key3, Value5 in Table9, nil, nil do
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = Value5
    table.insert( Table10, Sound )
end

task.spawn( function()
    pcall( ContentProvider.PreloadAsync, ContentProvider, Table10 )
end )
local Random2 = Random.new( )
local Class2 = setmetatable( { }, { __mode = "k" } )

local function Voice( Argument1, Parent, Key )
    if not Argument1.att or Argument1.att.Parent ~= Parent then
        local Att = Instance.new( "Attachment" )
        Att.Name = "Footsteps"
        Att.Position = Vector3.new( 0, -2.5999999046325684, 0 )
        Att.Parent = Parent
        local Sounds = { }
        Argument1.att = Att
        Argument1.sounds = Sounds
    end

    local Entry2
    local Entry = Argument1.sounds[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local Sound = Instance.new( "Sound" )
        Sound.Name = "Footstep"
        Sound.SoundId = "rbxassetid://" .. Key
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound.RollOffMinDistance = 6
        Sound.RollOffMaxDistance = 70
        Sound.Parent = Argument1.att
        Argument1.sounds[ Key ] = Sound
        Entry2 = Sound
    end

    return Entry2
end

local Value6 = nil
local Value7 = nil
local Value8 = nil

local function SplashFX()
    if not Value6 or not Value6.Parent then
        Value6 = Instance.new( "Attachment" )
        Value6.Name = "Flaques"
        Value6.Parent = workspace.Terrain
        Value7 = Instance.new( "ParticleEmitter" )
        Value7.Name = "Gouttes"
        Value7.Texture = "rbxassetid://134104347850283"
        Value7.Color = ColorSequence.new( Color3.fromRGB( 150, 165, 158 ) )
        Value7.Transparency = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 0.2 ),
            NumberSequenceKeypoint.new( 1, 1 )
        } )
        Value7.Size = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 0.2 ),
            NumberSequenceKeypoint.new( 1, 0.07 )
        } )
        Value7.Lifetime = NumberRange.new( 0.25, 0.45 )
        Value7.Speed = NumberRange.new( 5, 9 )
        Value7.SpreadAngle = Vector2.new( 40, 40 )
        Value7.EmissionDirection = Enum.NormalId.Top
        Value7.Acceleration = Vector3.new( 0, -60, 0 )
        Value7.Rate = 0
        Value7.LightInfluence = 1
        Value7.Parent = Value6
        Value8 = Instance.new( "ParticleEmitter" )
        Value8.Name = "Onde"
        Value8.Texture = "rbxassetid://78408215674963"
        Value8.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
        Value8.EmissionDirection = Enum.NormalId.Top
        Value8.Speed = NumberRange.new( 0.01 )
        Value8.Lifetime = NumberRange.new( 0.6, 0.85 )
        Value8.Size = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 0.4 ),
            NumberSequenceKeypoint.new( 1, 2.6 )
        } )
        Value8.Transparency = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 0.3 ),
            NumberSequenceKeypoint.new( 1, 1 )
        } )
        Value8.Color = ColorSequence.new( Color3.fromRGB( 205, 215, 210 ) )
        Value8.Rate = 0
        Value8.LightInfluence = 1
        Value8.Parent = Value6
        return
    end
    return
end

local function Splash( Argument1, Name )
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera and ( CurrentCamera.CFrame.Position - Argument1 ).Magnitude > 70 then
        return
    end

    local Number
    SplashFX( )
    Value6.WorldPosition = Argument1 + Vector3.new( 0, 0.05000000074505806, 0 )

    if Name == "sprint" then
        Number = 1.5
    elseif Name == "crouch" then
        Number = 0.5
    else
        Number = 1
    end

    Value7:Emit( ( math.max( 2, ( math.floor( 7 * Number + 0.5 ) ) ) ) )
    Value8:Emit( 1 )
end

local Table11 = { }

local function AddWater( WaterName )
    if WaterName:IsA( "BasePart" ) and WaterName.Name:upper( ):find( "WATER_SEWER", 1, true ) then
        Table11[ WaterName ] = true
    end
end

for Key4, Value9 in workspace:GetDescendants( ) do
    if Value9:IsA( "BasePart" ) and Value9.Name:upper( ):find( "WATER_SEWER", 1, true ) then
        Table11[ Value9 ] = true
    end
end

workspace.DescendantAdded:Connect( AddWater )
workspace.DescendantRemoving:Connect( function( Key )
    Table11[ Key ] = nil
end )

local function WaterSurface( Argument1 )
    local Value1 = nil

    for Value in Table11, nil, nil do
        if Value.Parent then
            local PointToObjectSpace = Value.CFrame:PointToObjectSpace( Argument1 )
            local Size = Value.Size / 2

            if math.abs( PointToObjectSpace.X ) <= Size.X and math.abs( PointToObjectSpace.Z ) <= Size.Z and PointToObjectSpace.Y <= Size.Y + 0.2 then
                local Y = PointToObjectSpace.Y

                if -Size.Y - 1.5 <= Y then
                    local CFrame = Value.CFrame
                    local X = PointToObjectSpace.X
                    local Y2 = Size.Y
                    return CFrame:PointToWorldSpace( ( Vector3.new( X, Y2, PointToObjectSpace.Z ) ) ).Y
                end
            end
        end
    end

    return nil
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true

local function PlayStep( Argument1, Value, Parent, Name, Clamp )
    local HipHeight
    local Humanoid = Value:FindFirstChildOfClass( "Humanoid" )
    RaycastParams2.FilterDescendantsInstances = { Value }
    local Position = Parent.Position
    HipHeight = Humanoid and Humanoid.HipHeight or 2
    local Raycast = workspace:Raycast( Position, Vector3.new( 0, -HipHeight - 4, 0 ), RaycastParams2 )

    if not Raycast then
        return
    end

    local Value3
    local SetOf2 = SetOf( Raycast )

    if SetOf2 == "water" then
        Value3 = nil
    else
        local WaterSurface2 = WaterSurface( Raycast.Position )

        if WaterSurface2 then
            Value3 = WaterSurface2
        else
            Value3 = nil
        end
    end

    local Text

    if Value3 then
        Text = "water"
    else
        Text = SetOf2
    end
    if Text == "water" then
        local Vector33

        if Value3 then
            local X = Raycast.Position.X
            local Vector32 = Vector3.new( X, Value3, Raycast.Position.Z )

            if Vector32 then
                Vector33 = Vector32
            else
                Vector33 = Raycast.Position
            end
        else
            Vector33 = Raycast.Position
        end

        Splash( Vector33, Name )
    end

    local Number

    if Text == "carpet" then
        Text = "wood"
        Number = 0.35
    else
        Number = 1
    end

    local Number3
    local Entry = Table4[ Text ] or 1

    if Table[ Text ] then
        Text = "shoes"
        Entry = Table2[ Text ] or 1
        Number3 = Table[ Text ]
    else
        Number3 = 1
    end

    local Entry3
    local Entry2 = Table3[ Text ]
    Entry3 = if Entry2 then Entry2 else Table3.shoes
    local Last
    local NextInteger = Random2:NextInteger( 1, #Entry3 )
    Last = if not ( #Entry3 > 1 ) or NextInteger ~= Argument1.last then NextInteger else NextInteger % #Entry3 + 1
    local Number2
    Argument1.last = Last
    local Entry4 = Table5[ Name ]
    local Voice2 = Voice( Argument1, Parent, Entry3[ Last ] )
    local Volume = Entry4.volume * Entry * Number
    Number2 = Value ~= LocalPlayer.Character and 1 or 0.7
    Voice2.Volume = Volume * Number2 * ( Clamp or 1 ) * Random2:NextNumber( 0.85, 1.05 )
    Voice2.PlaybackSpeed = Entry4.pitch * Number3 * Random2:NextNumber( 0.95, 1.05 )
    Voice2.TimePosition = 0
    Voice2:Play( )
end

local Table12 = { }
local Flag = true

local function MarkDirty()
    Flag = true
end

local function Chars()
    if Flag then
        Flag = false
        local Table = { }

        for Key, Value in Players:GetPlayers( ) do
            if Value.Character then
                table.insert( Table, Value.Character )
            end
        end
        for Key2, Value2 in CollectionService:GetTagged( "GunBot" ) do
            if Value2:IsDescendantOf( workspace ) then
                table.insert( Table, Value2 )
            end
        end

        Table12 = Table
    end

    return Table12
end

local function WatchPlayer( Self )
    if Self:IsA( "Player" ) then
        Self:GetPropertyChangedSignal( "Character" ):Connect( MarkDirty )
    end

    Flag = true
end

Players.ChildAdded:Connect( WatchPlayer )
Players.ChildRemoved:Connect( MarkDirty )

for Key5, Value10 in Players:GetChildren( ) do
    if Value10:IsA( "Player" ) then
        Value10:GetPropertyChangedSignal( "Character" ):Connect( MarkDirty )
    end

    Flag = true
end

local Table13 = { }

local function WatchBot( BotName )
    if Table13[ BotName ] then
        Table13[ BotName ]:Disconnect( )
    end

    Table13[ BotName ] = BotName.AncestryChanged:Connect( MarkDirty )
    Flag = true
end

CollectionService:GetInstanceAddedSignal( "GunBot" ):Connect( WatchBot )
CollectionService:GetInstanceRemovedSignal( "GunBot" ):Connect( function( Key )
    if Table13[ Key ] then
        Table13[ Key ]:Disconnect( )
        Table13[ Key ] = nil
    end

    Flag = true
end )

for Key6, Value11 in CollectionService:GetTagged( "GunBot" ) do
    if Table13[ Value11 ] then
        Table13[ Value11 ]:Disconnect( )
    end

    Table13[ Value11 ] = Value11.AncestryChanged:Connect( MarkDirty )
    Flag = true
end

local Class3 = setmetatable( { }, { __mode = "k" } )

local function PartOf( List, Object, Key, Name )
    local Entry = List[ Key ]

    if not Entry or Entry.Parent ~= Object then
        local FoundChild = Object:FindFirstChild( Name )
        List[ Key ] = FoundChild
        return FoundChild
    end
    return Entry
end

local function HumOf( Argument1, Object )
    local Hum = Argument1.hum

    if not Hum or Hum.Parent ~= Object then
        local Hum2 = Object:FindFirstChildOfClass( "Humanoid" )
        Argument1.hum = Hum2
        return Hum2
    end
    return Hum
end

local Table14 = { "LeftFoot", "RightFoot" }
RunService.Heartbeat:Connect( function( Argument1 )
    local Position2
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Position = CurrentCamera.CFrame.Position

        if Position then
            Position2 = Position
        else
            Position2 = Vector3.new( 0, 0, 0 )
        end
    else
        Position2 = Vector3.new( 0, 0, 0 )
    end

    local T = os.clock( )

    for Key, Value in Chars( ) do
        local Entry2
        local Entry = Class3[ Value ]

        if Entry then
            Entry2 = Entry
        else
            local Table = { }
            Class3[ Value ] = Table
            Entry2 = Table
        end

        local Root3
        local Root = Entry2.root

        if not Root or Root.Parent ~= Value then
            local Root2 = Value:FindFirstChild( "HumanoidRootPart" )
            Entry2.root = Root2
            Root3 = Root2
        else
            Root3 = Root
        end
        if Root3 and not ( ( Root3.Position - Position2 ).Magnitude > 90 ) then
            local Hum3
            local Hum = Entry2.hum

            if not Hum or Hum.Parent ~= Value then
                local Hum2 = Value:FindFirstChildOfClass( "Humanoid" )
                Entry2.hum = Hum2
                Hum3 = Hum2
            else
                Hum3 = Hum
            end
            if Hum3 and not ( Hum3.Health <= 0 ) then
                local Entry4
                local Entry3 = Class2[ Value ]

                if Entry3 then
                    Entry4 = Entry3
                else
                    local Table2 = { feet = { }, dist = 0, air = false }
                    Class2[ Value ] = Table2
                    Entry4 = Table2
                end

                local Flag
                local AssemblyLinearVelocity = Root3.AssemblyLinearVelocity
                local X = AssemblyLinearVelocity.X
                local Magnitude = Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude
                local State = Hum3:GetState( )

                if FrameCache.Floor( Hum3 ) == Enum.Material.Air then
                    Flag = false
                else
                    local NotSeatPart = not Hum3.SeatPart

                    if NotSeatPart then
                        if State == Enum.HumanoidStateType.Swimming then
                            Flag = false
                        elseif State == Enum.HumanoidStateType.Climbing then
                            Flag = false
                        else
                            Flag = true
                        end
                    else
                        Flag = NotSeatPart
                    end
                end

                local Text

                if CrouchAnim.IsCrouched( Value ) then
                    Text = "crouch"
                elseif Magnitude > 21 then
                    Text = "sprint"
                else
                    Text = "walk"
                end
                if Flag and Entry4.air then
                    local Amount = -( Entry4.fallV or 0 )

                    if Amount > 18 then
                        local Clamp = math.clamp( Amount / 50, 0.8, 1.8 )
                        PlayStep( Entry4, Value, Root3, "sprint", Clamp )
                        task.delay( 0.06, function()
                            if Root3.Parent then
                                PlayStep( Entry4, Value, Root3, "walk", Clamp * 0.6 )
                            end
                        end )
                        Entry4.dist = 0
                    end
                end

                Entry4.air = not Flag
                Entry4.fallV = AssemblyLinearVelocity.Y

                if not Flag or Magnitude < 1.2 then
                    local Value4
                    Entry4.dist = 0
                    local Feet = Entry4.feet
                    Value4 = nil

                    for Key3, Value5 in Feet, nil, nil do
                        Value5.min = nil
                        Value5.max = nil
                    end
                else
                    local Value2, Flag2
                    Entry4.dist = Entry4.dist + Magnitude * Argument1
                    Value2 = nil
                    Flag2 = false

                    for Key2, Value3 in Table14, nil, nil do
                        local Entry6
                        local Entry5 = Entry2[ Value3 ]

                        if not Entry5 or Entry5.Parent ~= Value then
                            local FoundChild = Value:FindFirstChild( Value3 )
                            Entry2[ Value3 ] = FoundChild
                            Entry6 = FoundChild
                        else
                            Entry6 = Entry5
                        end
                        if Entry6 then
                            local Entry8
                            local Max = Root3.CFrame:PointToObjectSpace( Entry6.Position ).Y
                            local Entry7 = Entry4.feet[ Value3 ]

                            if Entry7 then
                                Entry8 = Entry7
                            else
                                local Table3 = { prev = Max, down = false }
                                Entry4.feet[ Value3 ] = Table3
                                Entry8 = Table3
                            end

                            local Flag3 = Max < Entry8.prev - 0.002 and true or false

                            if Entry8.down and Entry8.prev + 0.002 < Max then
                                if ( Entry8.max or Max ) - Entry8.prev > 0.12 and T - ( Entry8.t or 0 ) > 0.16 and Entry4.dist > 1 then
                                    Entry8.t = T
                                    Flag2 = true
                                end

                                Entry8.max = Max
                            end
                            if Flag3 then
                                Entry8.down = true
                            elseif Entry8.prev + 0.002 < Max then
                                Entry8.down = false
                            end

                            Entry8.max = math.max( Entry8.max or Max, Max )
                            Entry8.prev = Max
                        end
                    end
                    if not Flag2 and Table5[ Text ].stride * 1.35 < Entry4.dist then
                        Flag2 = true
                    end
                    if Flag2 then
                        Entry4.dist = 0
                        PlayStep( Entry4, Value, Root3, Text )
                    end
                end
            end
        end
    end
end )
