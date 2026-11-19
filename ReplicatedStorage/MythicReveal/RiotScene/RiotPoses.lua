-- ReplicatedStorage.MythicReveal.RiotScene.RiotPoses
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Result2
local Table = { }
local Rad = math.rad
local Success, Result = pcall( require, script.Parent:WaitForChild( "RiotAnims", 5 ) )
Result2 = ( not Success or type( Result ) ~= "table" ) and { } or Result
local Table2 = {
    start = 3,
    arrive = 6,
    rate = 0.5,
    accel = 0.45,
    decel = 0.55,
    settle = 0.7
}

local function WalkProgress( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 3 )

    if Clamp < 0.45 then
        return 0.2 * Clamp * Clamp / 0.45
    end
    if Clamp < 2.45 then
        return 0.4 * ( 0.225 + ( Clamp - 0.45 ) )
    end
    local Clamp2 = 3 - Clamp
    return 1 - 0.2 * Clamp2 * Clamp2 / 0.55
end

local function PrepAnim( AnimName )
    local Entry = Result2[ AnimName ]

    if type( Entry ) ~= "table" or not Entry.parts then
        return nil
    end
    if not Entry._cf then
        local Value1
        Entry._cf = { }
        local Parts = Entry.parts
        Value1 = nil

        for Key, Value in Parts, nil, nil do
            local Value8
            local Table2 = { }
            Value8 = nil

            for Key5, Value9 in Value, nil, nil do
                Table2[ Key5 ] = CFrame.new( 0, 0, 0, Value9[ 1 ], Value9[ 2 ], Value9[ 3 ], Value9[ 4 ] )
            end

            Entry._cf[ Key ] = Table2
        end

        local Value2, Number
        local Frames = Entry.frames
        local _cf = Entry._cf
        Value2 = nil
        Number = 0

        for Key2, Value3 in _cf, nil, nil do
            local Item3 = Value3[ 1 ]
            local Entry4 = Value3[ Frames ]
            local _, ToAxisAngle2 = ( Item3:Inverse( ) * Entry4 ):ToAxisAngle( )
            Number = math.max( Number, ( math.abs( ( math.deg( ToAxisAngle2 ) ) ) ) )
        end

        Entry.loopStart = 1

        if Number > 12 and Frames > 12 then
            local Value4
            local Floor = math.floor( Frames / 3 )
            local _cf2 = Entry._cf
            Value4 = nil

            for Key3, Value5 in _cf2, nil, nil do
                local Clone = table.clone( Value5 )
                local Frames5 = Frames - Floor
                local J = Frames5

                for J = Frames5, Frames do
                    local Frames6 = ( J - ( Frames - Floor ) ) / Floor
                    local Frames7 = Frames6 * Frames6 * ( 3 - 2 * Frames6 )
                    local Entry3 = Clone[ J ]
                    Value5[ J ] = Entry3:Lerp( Clone[ Floor + 1 - ( Frames - J ) ], Frames7 )
                end
            end

            local Value6
            local Table = { }
            local Root = Entry.root
            Value6 = nil

            for Key4, Value7 in Root, nil, nil do
                local Item = Value7[ 1 ]
                local Item2 = Value7[ 2 ]
                Table[ Key4 ] = Vector3.new( Item, Item2, Value7[ 3 ] )
            end

            local Frames2 = Frames - Floor
            local I = Frames2

            for I = Frames2, Frames do
                local Frames3 = ( I - ( Frames - Floor ) ) / Floor
                local Frames4 = Frames3 * Frames3 * ( 3 - 2 * Frames3 )
                local Entry2 = Table[ I ]
                local Lerp = Entry2:Lerp( Table[ Floor + 1 - ( Frames - I ) ], Frames4 )
                local Root2 = Entry.root
                Root2[ I ] = { Lerp.X, Lerp.Y, Lerp.Z }
            end

            Entry.loopStart = Floor + 1
        end
    end

    return Entry
end

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function Lerp( Argument1, Argument2, Argument3 )
    return Argument1 + ( Argument2 - Argument1 ) * Argument3
end

local function Jc( Self )
    if Self:IsA( "Motor6D" ) then
        return Self.C0, Self.C1
    end
    return Self.Attachment0.CFrame, Self.Attachment1.CFrame
end

local function ChildW( Argument1, Object )
    local C0, C1

    if Object:IsA( "Motor6D" ) then
        C0 = Object.C0
        C1 = Object.C1
    else
        C0 = Object.Attachment0.CFrame
        C1 = Object.Attachment1.CFrame
    end

    return Argument1 * C0 * Object.Transform * C1:Inverse( )
end

local function SetJ( Self, Argument2, Argument3 )
    local C0, C1

    if Self:IsA( "Motor6D" ) then
        C0 = Self.C0
        C1 = Self.C1
    else
        C0 = Self.Attachment0.CFrame
        C1 = Self.Attachment1.CFrame
    end

    Self.Transform = ( Argument2 * C0 ):Inverse( ) * Argument3 * C1
end

local function MapBasis( Argument1, Argument2, Argument3, Argument4 )
    local Unit = ( Argument2 - Argument1 * Argument2:Dot( Argument1 ) ).Unit
    local Unit2 = ( Argument4 - Argument3 * Argument4:Dot( Argument3 ) ).Unit
    local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit, Argument1, Unit:Cross( Argument1 ) )
    return CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit2, Argument3, Unit2:Cross( Argument3 ) ) * FromMatrix:Inverse( )
end

local function Solve2( Self, Object, Object2, Argument4, Argument5, Argument6, Amount )
    local C0, C1

    if Self:IsA( "Motor6D" ) then
        C0 = Self.C0
        C1 = Self.C1
    else
        C1 = Self.Attachment1.CFrame
        C0 = Self.Attachment0.CFrame
    end

    local C02, C12

    if Object:IsA( "Motor6D" ) then
        C02 = Object.C0
        C12 = Object.C1
    else
        C02 = Object.Attachment0.CFrame
        C12 = Object.Attachment1.CFrame
    end

    local C03, C13

    if Object2:IsA( "Motor6D" ) then
        C03 = Object2.C0
        C13 = Object2.C1
    else
        C03 = Object2.Attachment0.CFrame
        C13 = Object2.Attachment1.CFrame
    end

    local Position8
    local Position = C02.Position - C1.Position
    local Position2 = C03.Position - C12.Position
    local Magnitude = Position.Magnitude
    local Magnitude2 = Position2.Magnitude
    local Position3 = ( Argument4 * C0 ).Position
    local Position4 = ( Argument5 * C13 ).Position
    local Position5 = Position4 - Position3
    local Magnitude3 = Position5.Magnitude
    local Clamp = math.clamp( Magnitude3, 0.05, Magnitude + Magnitude2 - 0.005 )
    local Unit = Position5.Unit
    local Clamp2 = math.clamp( ( Magnitude * Magnitude + Clamp * Clamp - Magnitude2 * Magnitude2 ) / ( 2 * Magnitude * Clamp ), -1, 1 )
    local Sqrt = math.sqrt( 1 - Clamp2 * Clamp2 )
    local Position6 = Argument6 - Position3
    local Position7 = Position6 - Unit * Position6:Dot( Unit )
    Position8 = if Position7.Magnitude < 0.001 then Argument4.LookVector else Position7
    local CFrame4
    local Unit2 = Position8.Unit
    local Position9 = Position3 + Unit * ( Magnitude * Clamp2 ) + Unit2 * ( Magnitude * Sqrt )
    local Position10 = Position3 + Unit * Clamp
    CFrame4 = if ( Position4 - Position10 ).Magnitude > 0.001 then CFrame.new( Position10 - Argument5.Rotation * C13.Position ) * Argument5.Rotation else Argument5
    local Cross2
    local Cross = ( Position9 - Position3 ):Cross( Position10 - Position9 )
    Cross2 = if Cross.Magnitude < 0.0001 then Argument4.RightVector else Cross
    local C04, C14
    local Cross3 = Cross2 * ( Amount or 1 )
    local Unit3 = Position.Unit
    local MapBasis2 = MapBasis( Unit3, Vector3.new( 1, 0, 0 ), ( Position9 - Position3 ).Unit, Cross3 )
    local CFrame2 = CFrame.new( Position3 - MapBasis2 * C1.Position ) * MapBasis2
    local Unit4 = Position2.Unit
    local MapBasis3 = MapBasis( Unit4, Vector3.new( 1, 0, 0 ), ( Position10 - Position9 ).Unit, Cross3 )
    local CFrame3 = CFrame.new( Position9 - MapBasis3 * C12.Position ) * MapBasis3

    if Self:IsA( "Motor6D" ) then
        C04 = Self.C0
        C14 = Self.C1
    else
        C04 = Self.Attachment0.CFrame
        C14 = Self.Attachment1.CFrame
    end

    local C05, C15
    Self.Transform = ( Argument4 * C04 ):Inverse( ) * CFrame2 * C14

    if Object:IsA( "Motor6D" ) then
        C05 = Object.C0
        C15 = Object.C1
    else
        C05 = Object.Attachment0.CFrame
        C15 = Object.Attachment1.CFrame
    end

    local C06, C16
    Object.Transform = ( CFrame2 * C05 ):Inverse( ) * CFrame3 * C15

    if Object2:IsA( "Motor6D" ) then
        C06 = Object2.C0
        C16 = Object2.C1
    else
        C06 = Object2.Attachment0.CFrame
        C16 = Object2.Attachment1.CFrame
    end

    Object2.Transform = ( CFrame3 * C06 ):Inverse( ) * CFrame4 * C16
end

local Table3 = {
    M4 = "low",
    SPAS12 = "low",
    AWP = "scope",
    M60 = "hip",
    MP5 = "high",
    M4A1 = "signal"
}
local Table4 = {
    Garde = {
        Drop = 0.56,
        Fwd = 0.04,
        Blade = 16,
        Pitch = -15,
        Lean = -5,
        LeanAim = -9,
        FootL = { -0.6, -0.68, -4, 0 },
        FootR = { 0.64, 0.72, -28, 0 }
    },
    Genou = {
        Drop = 1.6,
        Fwd = 0.06,
        Blade = 10,
        Pitch = -10,
        Lean = -5,
        LeanAim = -8,
        FootL = { -0.5, -1.15, -6, 0 },
        FootR = { 0.5, 1.2, -6, -72, 0.33 },
        Knee = true
    }
}
local Table5 = {
    M4 = -1.22,
    M4A1 = -1.22,
    MP5 = -1.02,
    AWP = -1.38,
    M60 = -1.46,
    SPAS12 = -1.52
}
local Table6 = { Ready = 24, Aim = 24, Long = 26 }

local function GunGeometry( Argument1 )
    local Table = { rear = 0.8, sight = 0.42, butt = 0.12 }
    local Origin = Argument1.origin

    if not Origin or not Argument1.vis then
        return Table
    end

    local Number, Number2
    local CFrame = Origin.CFrame
    Number = -math.huge
    Number2 = -math.huge

    for Key, Value in Argument1.vis:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            local Value1
            local ToObjectSpace = CFrame:ToObjectSpace( Value.CFrame )
            local Size = Value.Size / 2
            local Table2 = { -1, 1 }
            Value1 = nil

            for Key2, Value2 in Table2, nil, nil do
                local Value3
                local Table3 = { -1, 1 }
                Value3 = nil

                for Key3, Value4 in Table3, nil, nil do
                    local Value5
                    local Table4 = { -1, 1 }
                    Value5 = nil

                    for Key4, Value6 in Table4, nil, nil do
                        local X = Value2 * Size.X
                        local Y4 = Value4 * Size.Y
                        local ToObjectSpace2 = ToObjectSpace * Vector3.new( X, Y4, Value6 * Size.Z )

                        if Number < ToObjectSpace2.Z then
                            Number = ToObjectSpace2.Z
                        end
                        if ToObjectSpace2.Z > -1.4 and ToObjectSpace2.Z < 0.4 and Number2 < ToObjectSpace2.Y then
                            Number2 = ToObjectSpace2.Y
                        end
                    end
                end
            end
        elseif not Value:IsA( "Attachment" ) or Value.Name ~= "LeftGrip" then
            if Value:IsA( "Attachment" ) and Value.Name == "Muzzle" then
                Table.muzzle = CFrame:PointToObjectSpace( Value.WorldPosition )
            end
        else
            Table.lh = CFrame:PointToObjectSpace( Value.WorldPosition )
            Table.lhCF = CFrame:ToObjectSpace( Value.WorldCFrame )
        end
    end
    if Number > -math.huge then
        Table.rear = math.clamp( Number, 0.3, 1.4 )
    end

    local Y2

    if Table.muzzle then
        local Y = Table.muzzle.Y

        if Y then
            Y2 = Y
        else
            Y2 = 0.28
        end
    else
        Y2 = 0.28
    end
    if Number2 > -math.huge then
        local Number3 = Number2 - 0.08
        local Y3 = Y2 + 0.05
        Table.sight = math.clamp( Number3, Y3, Y2 + 0.4 )
    end

    Table.butt = math.clamp( Y2 - 0.12, 0, 0.3 )
    return Table
end

function Table.Init( Argument1, Argument2 )
    local M = Argument1.m
    local J = { }

    for Key, Value in M:GetDescendants( ) do
        if Value:IsA( "Motor6D" ) or Value:IsA( "AnimationConstraint" ) then
            if not J[ Value.Name ] then
                J[ Value.Name ] = Value
            end
        end
    end

    local Role2
    Argument1.J = J
    Argument1.floorY = Argument2.floorY
    Argument1.target = Argument2.target
    Argument1.geo = GunGeometry( Argument1 )
    local Role = M:GetAttribute( "Role" )

    if Role then
        Role2 = Role
    else
        local Entry = Table3[ Argument1.weapon or "" ]

        if Entry then
            Role2 = Entry
        else
            Role2 = "low"
        end
    end

    local St
    Argument1.role = Role2
    local Entry2 = Table4[ M:GetAttribute( "Stance" ) or "Garde" ]
    St = if Entry2 then Entry2 else Table4.Garde
    local AimPose2
    Argument1.st = St
    local AimPose = Argument2.aimPose
    AimPose2 = if AimPose then AimPose else { }
    local RH
    local RightHand = AimPose2.RightHand
    RH = if RightHand then RightHand else CFrame.new( 0.04, -0.1, -0.08 ) * CFrame.Angles( 1.5707963267948966, 0.10471975511965978, -0.2617993877991494 )
    local LHback
    Argument1.RH = RH
    local LeftHand = AimPose2.LeftHand

    if LeftHand then
        LHback = LeftHand
    else
        LHback = CFrame.new( -0.15, 0.09, -0.88 ) * CFrame.Angles( -0.017453292519943295, 0.33161255787892263, 1.8675022996339325 )
    end
    if Argument1.geo.lhCF then
        LHback = Argument1.geo.lhCF
    end

    local Long
    Argument1.LHback = LHback

    if Argument1.weapon == "M60" then
        Long = true
    elseif Argument1.weapon == "AWP" then
        Long = true
    elseif Argument1.weapon == "SPAS12" then
        Long = true
    else
        Long = false
    end

    Argument1.long = Long
    local Entry3 = Table5[ Argument1.weapon or "" ]

    if Entry3 then
        local X = LHback.X
        LHback = CFrame.new( X, LHback.Y - 0.03, Entry3 ) * LHback.Rotation
    end

    Argument1.LH = LHback

    if J.LeftShoulder and J.LeftElbow and J.LeftWrist then
        local C1
        local LeftShoulder = J.LeftShoulder

        if LeftShoulder:IsA( "Motor6D" ) then
            local C0 = LeftShoulder.C0
            C1 = LeftShoulder.C1
        else
            local CFrame2 = LeftShoulder.Attachment0.CFrame
            C1 = LeftShoulder.Attachment1.CFrame
        end

        local C02, C12
        local LeftElbow = J.LeftElbow

        if LeftElbow:IsA( "Motor6D" ) then
            C02 = LeftElbow.C0
            C12 = LeftElbow.C1
        else
            C02 = LeftElbow.Attachment0.CFrame
            C12 = LeftElbow.Attachment1.CFrame
        end

        local C03, C13
        local LeftWrist = J.LeftWrist

        if LeftWrist:IsA( "Motor6D" ) then
            C03 = LeftWrist.C0
            C13 = LeftWrist.C1
        else
            C03 = LeftWrist.Attachment0.CFrame
            C13 = LeftWrist.Attachment1.CFrame
        end

        Argument1.reachL = ( C02.Position - C1.Position ).Magnitude + ( C03.Position - C12.Position ).Magnitude
        Argument1.wristL = C13.Position
    end

    Argument1.RH = CFrame.new( Argument1.RH.Position + Vector3.new( 0, -0.019999999552965164, 0.05000000074505806 ) ) * CFrame.Angles( -0.5585053606381855, 0, 0 ) * Argument1.RH.Rotation
    local Target = Argument1.target - Argument1.pos
    local Amount = -Target.X
    Argument1.yaw = math.atan2( Amount, -Target.Z ) * 0.8
    Argument1.rng = Random.new( math.floor( ( Argument1.phase or 0 ) * 1000 ) + #M.Name * 31 )
    Argument1.scan = {
        y = 0,
        p = 0,
        fy = 0,
        fp = 0,
        ty = 0,
        tp = 0,
        t0 = 0,
        dur = 0.3,
        nextT = Argument1.rng:NextNumber( 0.2, 1.2 )
    }
    Argument1.settle = 0
    Argument1.lastK = 0

    if J.Root and J.LeftHip and J.LeftKnee and J.LeftAnkle then
        local C04, C14
        local Root = J.Root

        if Root:IsA( "Motor6D" ) then
            C04 = Root.C0
            C14 = Root.C1
        else
            C04 = Root.Attachment0.CFrame
            C14 = Root.Attachment1.CFrame
        end

        local C05, C15
        local LeftHip = J.LeftHip

        if LeftHip:IsA( "Motor6D" ) then
            C05 = LeftHip.C0
            C15 = LeftHip.C1
        else
            C05 = LeftHip.Attachment0.CFrame
            C15 = LeftHip.Attachment1.CFrame
        end

        local C06, C16
        local LeftKnee = J.LeftKnee

        if LeftKnee:IsA( "Motor6D" ) then
            C06 = LeftKnee.C0
            C16 = LeftKnee.C1
        else
            C06 = LeftKnee.Attachment0.CFrame
            C16 = LeftKnee.Attachment1.CFrame
        end

        local C07, C17
        local LeftAnkle = J.LeftAnkle

        if LeftAnkle:IsA( "Motor6D" ) then
            C07 = LeftAnkle.C0
            C17 = LeftAnkle.C1
        else
            C07 = LeftAnkle.Attachment0.CFrame
            C17 = LeftAnkle.Attachment1.CFrame
        end

        local CFrame3 = CFrame.new( Argument1.pos ) * C04 * C14:Inverse( ) * C05 * C15:Inverse( ) * C06 * C16:Inverse( )
        Argument1.ankleH = ( CFrame3 * C07 ).Position.Y - Argument2.floorY
        Argument1.footH = ( CFrame3 * C07 * C17:Inverse( ) ).Position.Y - Argument2.floorY
    end

    local Size2

    if M:FindFirstChild( "LeftFoot" ) then
        local Size = M.LeftFoot.Size

        if Size then
            Size2 = Size
        else
            Size2 = Vector3.new( 0.4000000059604645, 0.5, 0.8500000238418579 )
        end
    else
        Size2 = Vector3.new( 0.4000000059604645, 0.5, 0.8500000238418579 )
    end

    local Value2
    local Amount2 = -Size2.X / 2
    local Amount3 = -Size2.Y / 2
    local Vector32 = Vector3.new( Amount2, Amount3, -Size2.Z / 2 )
    local X2 = Size2.X / 2
    local Amount4 = -Size2.Y / 2
    local Vector33 = Vector3.new( X2, Amount4, -Size2.Z / 2 )
    local Amount5 = -Size2.X / 2
    local Amount6 = -Size2.Y / 2
    local Vector34 = Vector3.new( Amount5, Amount6, Size2.Z / 2 )
    local X3 = Size2.X / 2
    local Amount7 = -Size2.Y / 2
    local Table = {
        Vector32,
        Vector33,
        Vector34,
        ( Vector3.new( X3, Amount7, Size2.Z / 2 ) )
    }
    function Argument1.soleMin( Argument1 )
        local Value1, Number
        Value1 = nil
        Number = math.huge

        for Key, Value in Table, nil, nil do
            Number = math.min( Number, ( Argument1 * Value ).Y )
        end

        return Number
    end
    local Anim = M:GetAttribute( "Anim" )

    if type( Anim ) == "string" then
        local PrepAnim2 = PrepAnim( Anim )

        if PrepAnim2 then
            Value2 = PrepAnim2
        else
            Value2 = nil
        end
    else
        Value2 = nil
    end
    if Value2 then
        local Dir2
        local Dir = Value2.dir
        Dir2 = if Dir then Dir else { 0, -1 }
        local Speed = ( Value2.speed or 5 ) * 0.5 * 3
        local Angles = CFrame.Angles( 0, Argument1.yaw, 0 )
        local Item = Dir2[ 1 ]
        Argument1.walk = {
            data = Value2,
            dist = Speed,
            dirW = Angles:VectorToWorldSpace( ( Vector3.new( Item, 0, Dir2[ 2 ] ) ) ).Unit
        }
    end
end
local Table7 = {
    { "LeftHip", "LeftUpperLeg", "LowerTorso" },
    { "LeftKnee", "LeftLowerLeg", "LeftUpperLeg" },
    { "LeftAnkle", "LeftFoot", "LeftLowerLeg" },
    { "RightHip", "RightUpperLeg", "LowerTorso" },
    { "RightKnee", "RightLowerLeg", "RightUpperLeg" },
    { "RightAnkle", "RightFoot", "RightLowerLeg" }
}

local function AnimLegs( Argument1, Argument2, LegsName, LegsName2, Argument5 )
    local C0, C1
    local Data = Argument1.walk.data
    local J = Argument1.J
    local Rotation = Argument2.Rotation

    local function Q( Key )
        local Lerp2
        local Entry = Data._cf[ Key ]

        if Entry then
            local Lerp = Entry[ LegsName ]:Lerp( Entry[ LegsName2 ], Argument5 )

            if Lerp then
                Lerp2 = Lerp
            else
                Lerp2 = nil
            end
        else
            Lerp2 = nil
        end

        return Lerp2
    end

    local Table = { }
    local Root = J.Root

    if Root:IsA( "Motor6D" ) then
        C0 = Root.C0
        C1 = Root.C1
    else
        C0 = Root.Attachment0.CFrame
        C1 = Root.Attachment1.CFrame
    end

    local Lerp3
    local C02 = Argument2 * C0 * C1:Inverse( )
    local Entry = Data.root[ LegsName ]
    local Entry2 = Data.root[ LegsName2 ]
    local Item = Entry[ 1 ]
    local Item2 = Entry[ 2 ]
    local Vector32 = Vector3.new( Item, Item2, Entry[ 3 ] )
    local Item3 = Entry2[ 1 ]
    local Item4 = Entry2[ 2 ]
    local Lerp = Vector32:Lerp( Vector3.new( Item3, Item4, Entry2[ 3 ] ), Argument5 )
    local LowerTorso = Data._cf.LowerTorso

    if LowerTorso then
        local Entry3 = LowerTorso[ LegsName ]
        local Lerp2 = Entry3:Lerp( LowerTorso[ LegsName2 ], Argument5 )

        if Lerp2 then
            Lerp3 = Lerp2
        else
            Lerp3 = nil
        end
    else
        Lerp3 = nil
    end
    if not Lerp3 then
        Lerp3 = CFrame.identity
    end

    local Value1
    local CFrame2 = CFrame.new( C02.Position + Rotation:VectorToWorldSpace( Lerp ) ) * ( Rotation * Lerp3 )
    Table.Root = ( Argument2 * C0 ):Inverse( ) * CFrame2 * C1
    local Table2 = { LowerTorso = CFrame2 }
    Value1 = nil

    for Key, Value in Table7, nil, nil do
        local Lerp5
        local Entry4 = J[ Value[ 1 ] ]
        local Entry5 = Table2[ Value[ 3 ] ]
        local Item5 = Value[ 2 ]
        local Entry6 = Data._cf[ Item5 ]

        if Entry6 then
            local Entry7 = Entry6[ LegsName ]
            local Lerp4 = Entry7:Lerp( Entry6[ LegsName2 ], Argument5 )

            if Lerp4 then
                Lerp5 = Lerp4
            else
                Lerp5 = nil
            end
        else
            Lerp5 = nil
        end
        if Entry4 and Entry5 and Lerp5 then
            local C03, C12

            if Entry4:IsA( "Motor6D" ) then
                C03 = Entry4.C0
                C12 = Entry4.C1
            else
                C03 = Entry4.Attachment0.CFrame
                C12 = Entry4.Attachment1.CFrame
            end

            local CFrame3 = CFrame.new( ( Entry5 * C03 ).Position ) * ( Rotation * Lerp5 * C12.Rotation )
            Table[ Value[ 1 ] ] = ( Entry5 * C03 ):Inverse( ) * CFrame3
            Table2[ Value[ 2 ] ] = CFrame3 * C12:Inverse( )

            if Value[ 2 ] == "LeftFoot" or Value[ 2 ] == "RightFoot" then
                local SoleMin2

                if Argument1.soleMin then
                    local SoleMin = Argument1.soleMin( Table2[ Value[ 2 ] ] )

                    if SoleMin then
                        SoleMin2 = SoleMin
                    else
                        SoleMin2 = CFrame3.Position.Y
                    end
                else
                    SoleMin2 = CFrame3.Position.Y
                end

                local MinSole

                if Table.minSole then
                    local Min = math.min( Table.minSole, SoleMin2 )

                    if Min then
                        MinSole = Min
                    else
                        MinSole = SoleMin2
                    end
                else
                    MinSole = SoleMin2
                end

                Table.minSole = MinSole
                Table[ Value[ 2 ] ] = Table2[ Value[ 2 ] ]
            end
        end
    end

    return Table
end

local function Scan( Argument1, T0 )
    local Scan = Argument1.scan

    if T0 < Scan.t0 then
        local NextT = T0 + Argument1.rng:NextNumber( 0.4, 1.4 )
        Scan.t0 = T0
        Scan.nextT = NextT
    end
    if Scan.nextT <= T0 then
        local Number
        local Fy = Scan.y
        local Fp = Scan.p
        Scan.fy = Fy
        Scan.fp = Fp
        Number = Argument1.role ~= "signal" and 0.32 or 0.5
        local Rng = Argument1.rng
        Scan.ty = Rng:NextNumber( -Number, Number )
        Scan.tp = Argument1.rng:NextNumber( -0.08, 0.04 )
        local Dur = Argument1.rng:NextNumber( 0.55, 0.9 )
        Scan.t0 = T0
        Scan.dur = Dur
        Scan.nextT = T0 + Scan.dur + Argument1.rng:NextNumber( 1, 2.4 )
    end

    local Clamp = math.clamp( ( T0 - Scan.t0 ) / Scan.dur, 0, 1 )
    local Clamp2 = Clamp * Clamp * Clamp * ( Clamp * ( Clamp * 6 - 15 ) + 10 )
    local Fy2 = Scan.fy
    local Y = Fy2 + ( Scan.ty - Fy2 ) * Clamp2
    local Fp2 = Scan.fp
    local P = Fp2 + ( Scan.tp - Fp2 ) * Clamp2
    Scan.y = Y
    Scan.p = P
    return Scan.y, Scan.p
end

local function GunFromButt( Geo, Argument2, Argument3, Amount )
    local Cross2
    local Cross = Argument3:Cross( Vector3.new( 0, 1, 0 ) )
    Cross2 = if Cross.Magnitude < 0.001 then Vector3.new( 1, 0, 0 ) else Cross
    local Unit = Cross2.Unit
    local Unit2 = Unit:Cross( Argument3 ).Unit
    local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit, Unit2, -Argument3 ) * CFrame.Angles( 0, 0, ( Rad( Amount or 0 ) ) )
    return CFrame.new( Argument2 ) * FromMatrix * CFrame.new( 0, -Geo.butt, -Geo.rear )
end

local function Tilt( Argument1, Argument2, Amount )
    local Unit
    local X = Argument1.X
    local Vector32 = Vector3.new( X, 0, Argument1.Z )
    Unit = Vector32.Magnitude > 0.001 and Vector32.Unit or Vector3.new( 0, 0, -1 )
    return ( CFrame.lookAt( Vector3.new( 0, 0, 0 ), Unit ) * CFrame.Angles( 0, Rad( Amount or 0 ), 0 ) * CFrame.Angles( Rad( Argument2 ), 0, 0 ) ).LookVector
end

local IsStudio = game:GetService( "RunService" ):IsStudio( )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer

local function Calibrate( Argument1, Argument2 )
    local Number
    local CFrame2 = CFrame.new( Argument1.pos ) * CFrame.Angles( 0, Argument1.yaw, 0 )
    local Frames = Argument2.data.frames
    local Table = { }
    local I = 1
    Number = math.huge

    for I = 1, Frames do
        local AnimLegs2 = AnimLegs( Argument1, CFrame2, I, I, 0 )

        if not AnimLegs2.LeftFoot or not AnimLegs2.RightFoot then
            return
        end

        local Position = AnimLegs2.LeftFoot.Position
        local Position2 = AnimLegs2.RightFoot.Position
        Table[ I ] = { L = Position, R = Position2 }
        local Y = Position.Y
        Number = math.min( Number, Y, Position2.Y )
    end

    local Position3, Number2
    local I2 = 2
    Position3 = Vector3.new( 0, 0, 0 )
    Number2 = 0

    for I2 = 2, Frames do
        local Value2
        local Table2 = { "L", "R" }
        Value2 = nil

        for Key, Value in Table2, nil, nil do
            local Entry = Table[ I2 - 1 ][ Value ]
            local Entry2 = Table[ I2 ][ Value ]

            if Entry.Y - Number < 0.12 and Entry2.Y - Number < 0.12 then
                local Entry3 = Entry2 - Entry
                local X = Entry3.X
                Position3 = Position3 + Vector3.new( X, 0, Entry3.Z )
                Number2 = Number2 + 1
            end
        end
    end
    if Number2 < 3 or Position3.Magnitude < 0.0001 then
        return
    end

    local Position4 = Position3 / Number2
    local Speed = Position4.Magnitude * Argument2.data.fps
    local Speed2 = Argument2.data.speed or Speed

    if Speed < Speed2 * 0.5 or Speed2 * 2 < Speed then
        return
    end
    Argument2.speed = Speed
    Argument2.dirW = -Position4.Unit
    Argument2.dist = Argument2.speed * 0.5 * 3
    return
end

function Table.Step( Argument1, Settle )
    local J = Argument1.J
    local St = Argument1.st
    local Geo = Argument1.geo

    if not J.Root or not J.Waist or not J.Neck then
        return
    end
    if IsStudio and LocalPlayer and tonumber( LocalPlayer:GetAttribute( "DebugRiotT" ) ) then
        Settle = tonumber( LocalPlayer:GetAttribute( "DebugRiotT" ) )
    end
    if Argument1.walk and not Argument1.walk.cal then
        Argument1.walk.cal = true
        Calibrate( Argument1, Argument1.walk )
    end

    local Clamp = math.clamp( Argument1.k or 0, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )

    if ( Argument1.k or 0 ) >= 0.999 and Argument1.lastK < 0.999 then
        Argument1.settle = Settle
    end

    local Number2
    Argument1.lastK = Argument1.k or 0

    if Argument1.settle > 0 then
        local Number = Settle - Argument1.settle

        if Number then
            Number2 = Number
        else
            Number2 = 99
        end
    else
        Number2 = 99
    end

    local Exp2

    if Number2 < 0.6 then
        local Exp = math.exp( -Number2 * 9 ) * math.sin( Number2 * 26 )

        if Exp then
            Exp2 = Exp
        else
            Exp2 = 0
        end
    else
        Exp2 = 0
    end

    local DirW, Clamp5, Floor2, Min, Number4
    local Phase = Argument1.phase or 0
    local Walk = Argument1.walk

    if Walk then
        local Arrive3
        local Number3 = Settle - 3
        local Arrive = Table2.arrive - Table2.start
        local Accel = Table2.accel
        local Decel = Table2.decel
        local Clamp3 = math.clamp( Number3, 0, Arrive )
        local Arrive2 = 1 / ( Arrive - Accel / 2 - Decel / 2 )

        if Clamp3 < Accel then
            Arrive3 = 0.5 * Arrive2 * Clamp3 * Clamp3 / Accel
        elseif Clamp3 < Arrive - Decel then
            Arrive3 = Arrive2 * ( Accel / 2 + ( Clamp3 - Accel ) )
        else
            local Arrive4 = Arrive - Clamp3
            Arrive3 = 1 - 0.5 * Arrive2 * Arrive4 * Arrive4 / Decel
        end

        local Speed3
        local Dist = Walk.dist * Arrive3
        DirW = Walk.dirW * -( Walk.dist - Dist )
        local Clamp4 = math.clamp( ( Settle - 6 ) / 0.7, 0, 1 )
        Clamp5 = 1 - Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 )
        local Frames = Walk.data.frames
        local Speed = Walk.speed

        if Speed then
            Speed3 = Speed
        else
            local Speed2 = Walk.data.speed

            if Speed2 then
                Speed3 = Speed2
            else
                Speed3 = 5
            end
        end

        local Dist3
        local Dist2 = Dist / math.max( Speed3, 0.1 ) * Walk.data.fps
        local LoopStart = Walk.data.loopStart or 1
        Dist3 = if Frames - 1 <= Dist2 then LoopStart - 1 + ( Dist2 - ( Frames - 1 ) ) % ( Frames - LoopStart ) else Dist2
        local Floor = math.floor( Dist3 )
        Floor2 = Floor + 1
        Min = math.min( Floor + 2, Frames )
        Number4 = Dist3 % 1
    else
        DirW = Vector3.new( 0, 0, 0 )
        Clamp5 = 0
        Floor2 = 1
        Min = 1
        Number4 = 0
    end

    local Value2
    local CFrame2 = CFrame.new( Argument1.pos + DirW ) * CFrame.Angles( 0, Argument1.yaw, 0 )
    Argument1.root.CFrame = CFrame2
    local CFrame3 = CFrame.new( Argument1.pos.X + DirW.X, Argument1.floorY, Argument1.pos.Z + DirW.Z ) * CFrame.Angles( 0, Argument1.yaw, 0 )
    local Sin = math.sin( Settle * 0.42 + Phase ) * 0.05 + math.sin( Settle * 0.17 + Phase * 2 ) * 0.03
    local Drop = St.Drop + Clamp2 * 0.04 - Exp2 * 0.03
    local Root = J.Root
    Root.Transform = CFrame.new( Sin, -Drop, St.Fwd - Clamp2 * 0.04 ) * CFrame.Angles( Rad( St.Pitch - Clamp2 * 2 ), Rad( -St.Blade ), ( Rad( -Sin * 18 ) ) )

    if Clamp5 > 0.001 then
        local AnimLegs2 = AnimLegs( Argument1, CFrame2, Floor2, Min, Number4 )

        if AnimLegs2 then
            Value2 = AnimLegs2
        else
            Value2 = nil
        end
    else
        Value2 = nil
    end

    local CFrame5

    if Value2 then
        if Value2.minSole then
            local Clamp7
            local FloorY = Argument1.floorY - Value2.minSole

            if not Argument1.ground or not Argument1.lastStep then
                Clamp7 = 0
            else
                local Clamp6 = math.clamp( Settle - Argument1.lastStep, 0, 0.1 )

                if Clamp6 then
                    Clamp7 = Clamp6
                else
                    Clamp7 = 0
                end
            end

            local Ground2

            if Argument1.ground then
                local Ground = Argument1.ground + ( FloorY - Argument1.ground ) * ( 1 - math.exp( -25 * Clamp7 ) )

                if Ground then
                    Ground2 = Ground
                else
                    Ground2 = FloorY
                end
            else
                Ground2 = FloorY
            end

            Argument1.ground = Ground2
            local Vector32 = Vector3.new( 0, Argument1.ground * Clamp5, 0 )
            local CFrame4 = CFrame2 + Vector32
            Argument1.root.CFrame = CFrame4

            if Value2.LeftFoot then
                Value2.LeftFoot = Value2.LeftFoot + Vector32
            end
            if Value2.RightFoot then
                Value2.RightFoot = Value2.RightFoot + Vector32
                CFrame5 = CFrame4
            else
                CFrame5 = CFrame4
            end
        else
            CFrame5 = CFrame2
        end

        local Root2 = J.Root
        local Transform = J.Root.Transform
        Root2.Transform = Transform:Lerp( Value2.Root, Clamp5 )
    else
        CFrame5 = CFrame2
    end

    local C0, C1
    local Root3 = J.Root

    if Root3:IsA( "Motor6D" ) then
        C0 = Root3.C0
        C1 = Root3.C1
    else
        C0 = Root3.Attachment0.CFrame
        C1 = Root3.Attachment1.CFrame
    end

    local FootRot2
    local CFrame6 = CFrame5 * C0 * Root3.Transform * C1:Inverse( )
    local FootH = Argument1.footH or 0.18

    local function Foot( List )
        local Item3
        local Item = List[ 1 ]

        if List[ 5 ] then
            local Item2 = List[ 5 ] + FootH - 0.18

            if Item2 then
                Item3 = Item2
            else
                Item3 = FootH
            end
        else
            Item3 = FootH
        end

        return CFrame3 * CFrame.new( Item, Item3, List[ 2 ] ) * CFrame.Angles( 0, Rad( List[ 3 ] ), 0 ) * CFrame.Angles( Rad( List[ 4 ] or 0 ), 0, 0 )
    end

    local FootRot = Argument1.footRot
    FootRot2 = if FootRot then FootRot else { }
    local Clamp9
    Argument1.footRot = FootRot2

    if Argument1.lastStep then
        local Clamp8 = math.clamp( Settle - Argument1.lastStep, 0, 0.1 )

        if Clamp8 then
            Clamp9 = Clamp8
        else
            Clamp9 = 0
        end
    else
        Clamp9 = 0
    end
    if Value2 and Value2.LeftFoot and Value2.RightFoot then
        if Clamp5 < 0.999 and not Argument1.firstFoot then
            local FirstFoot

            if Settle < 4 then
                FirstFoot = "L"
            else
                local Y = Value2.LeftFoot.Position.Y

                if Value2.RightFoot.Position.Y < Y then
                    FirstFoot = "L"
                else
                    FirstFoot = "R"
                end
            end

            Argument1.firstFoot = FirstFoot
        end
        if Clamp5 >= 0.999 then
            Argument1.firstFoot = nil
        end
    end

    local function WalkFoot( Argument1Inner, Argument2, FootName )
        if not Value2 or not Argument2 then
            Argument1.footRot[ FootName ] = nil
            return Argument1Inner
        end

        local Flag
        local Captured = 1 - Clamp5
        Flag = ( Argument1.firstFoot or "L" ) == FootName and true or false
        local Clamp2

        if Flag then
            local Clamp = math.clamp( Captured * 2, 0, 1 )

            if Clamp then
                Clamp2 = Clamp
            else
                Clamp2 = math.clamp( Captured * 2 - 1, 0, 1 )
            end
        else
            Clamp2 = math.clamp( Captured * 2 - 1, 0, 1 )
        end

        local Lerp2
        local Clamp3 = math.clamp( Clamp2, 0, 1 )
        local Clamp4 = Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 )
        local Lerp = Argument2:Lerp( Argument1Inner, Clamp4 )
        local X = Argument1Inner.X - Argument2.X
        local Magnitude = Vector3.new( X, 0, Argument1Inner.Z - Argument2.Z ).Magnitude
        Lerp2 = if not ( Magnitude > 0.05 ) or not ( Clamp4 > 0 ) or not ( Clamp4 < 1 ) then Lerp else Lerp + Vector3.new( 0, math.sin( 3.141592653589793 * Clamp4 ) * math.min( 0.4, 0.12 + Magnitude * 0.35 ), 0 )
        local Lerp4
        local Entry = Argument1.footRot[ FootName ]

        if Entry then
            local Lerp3 = Entry:Lerp( Lerp2.Rotation, 1 - math.exp( -22 * Clamp9 ) )

            if Lerp3 then
                Lerp4 = Lerp3
            else
                Lerp4 = Lerp2.Rotation
            end
        else
            Lerp4 = Lerp2.Rotation
        end

        local SoleMin2
        Argument1.footRot[ FootName ] = Lerp4
        local CFrame2 = CFrame.new( Lerp2.Position ) * Lerp4

        if Argument1.soleMin then
            local SoleMin = Argument1.soleMin( CFrame2 )

            if SoleMin then
                SoleMin2 = SoleMin
            else
                SoleMin2 = CFrame2.Position.Y
            end
        else
            SoleMin2 = CFrame2.Position.Y
        end

        local CFrame3 = if SoleMin2 < Argument1.floorY then CFrame2 + Vector3.new( 0, ( Argument1.floorY - SoleMin2 ) * math.min( 1, Clamp5 * 4 ), 0 ) else CFrame2
        return CFrame3
    end

    if J.LeftHip and J.LeftKnee and J.LeftAnkle then
        local LeftFoot
        local Foot2 = Foot( St.FootL )
        LeftFoot = if Value2 then Value2.LeftFoot else Value2
        local WalkFoot2 = WalkFoot( Foot2, LeftFoot, "L" )
        local LeftHip = J.LeftHip
        local LeftKnee = J.LeftKnee
        local LeftAnkle = J.LeftAnkle
        local Item = St.FootL[ 1 ] - 0.25
        Solve2( LeftHip, LeftKnee, LeftAnkle, CFrame6, WalkFoot2, ( CFrame3 * CFrame.new( Item, 2.4, St.FootL[ 2 ] - 3 ) ).Position, -1 )
    end
    if J.RightHip and J.RightKnee and J.RightAnkle then
        local RightFoot
        local Foot3 = Foot( St.FootR )
        RightFoot = if Value2 then Value2.RightFoot else Value2
        local Position3
        local WalkFoot3 = WalkFoot( Foot3, RightFoot, "R" )
        local Item2 = St.FootR[ 1 ] + 0.3
        local Position = ( CFrame3 * CFrame.new( Item2, 2.4, St.FootR[ 2 ] - 3 ) ).Position

        if St.Knee then
            local Position2 = ( CFrame3 * CFrame.new( St.FootR[ 1 ], -1.5, -2.5 ) ).Position

            if Position2 then
                Position3 = Position2
            else
                Position3 = Position
            end
        else
            Position3 = Position
        end
        if Value2 then
            Position3 = Position3:Lerp( Position, Clamp5 )
        end

        local RightHip = J.RightHip
        local RightKnee = J.RightKnee
        Solve2( RightHip, RightKnee, J.RightAnkle, CFrame6, WalkFoot3, Position3, -1 )
    end

    local Number5
    local Sin2 = math.sin( Settle * 1.45 + Phase ) * 0.7
    local Lean = St.Lean
    local Lean2 = Lean + ( St.LeanAim - Lean ) * Clamp2 + Sin2 + Exp2 * 1.2
    local Target = Argument1.target
    local Noise = math.noise( Settle * 0.6, Phase ) * 0.35
    local Target2 = Target + Vector3.new( Noise, math.noise( Phase, Settle * 0.6 ) * 0.25, 0 )
    local VectorToObjectSpace = CFrame6:VectorToObjectSpace( Target2 - CFrame6.Position )
    local Amount = -VectorToObjectSpace.X
    local Deg = math.deg( ( math.atan2( Amount, -VectorToObjectSpace.Z ) ) )
    Number5 = not Argument1.long and 24 or 26
    local Number6 = 24 + ( Number5 - 24 ) * Clamp2

    if IsStudio and LocalPlayer and tonumber( LocalPlayer:GetAttribute( "DebugRiotLacet" ) ) then
        Number6 = tonumber( LocalPlayer:GetAttribute( "DebugRiotLacet" ) )
    end

    local Clamp11
    local Clamp10 = math.clamp( Deg - Number6, -45, 15 )
    local Value3, Number7 = Scan( Argument1, Settle )
    Clamp11 = if ( Argument1.look or 0 ) == 0 then Clamp10 + math.deg( Value3 ) * 0.3 * ( 1 - Clamp2 ) else Clamp10
    local C02, C12
    local Waist = J.Waist
    Waist.Transform = CFrame.Angles( Rad( Lean2 ), Rad( Clamp11 ), ( Rad( Sin * 10 ) ) )
    local Waist2 = J.Waist

    if Waist2:IsA( "Motor6D" ) then
        C02 = Waist2.C0
        C12 = Waist2.C1
    else
        C02 = Waist2.Attachment0.CFrame
        C12 = Waist2.Attachment1.CFrame
    end

    local C03, C13
    local CFrame7 = CFrame6 * C02 * Waist2.Transform * C12:Inverse( )
    local Neck = J.Neck

    if Neck:IsA( "Motor6D" ) then
        C03 = Neck.C0
        C13 = Neck.C1
    else
        C03 = Neck.Attachment0.CFrame
        C13 = Neck.Attachment1.CFrame
    end

    local Number8
    local Position4 = ( CFrame7 * C03 ).Position

    if ( Argument1.look or 0 ) == 0 then
        Number8 = Value3
    else
        Number8 = 0
        Number7 = 0
    end

    local C04, C14
    local Number9 = Number8 + ( Argument1.look or 0 )
    local Angles = CFrame.Angles( 0, Argument1.yaw + Number9, 0 ) * CFrame.Angles( Number7, 0, 0 )
    local Lerp = Angles:Lerp( CFrame.lookAt( Vector3.new( 0, 0, 0 ), ( Target2 - ( Position4 + ( CFrame7.Rotation * CFrame.new( 0, 0.55, -0.35 ) ).Position ) ).Unit ) * CFrame.Angles( -0.29670597283903605, 0, -0.22689280275926285 ), Clamp2 )
    local CFrame8 = CFrame.new( Position4 ) * Lerp * C13:Inverse( )
    local Neck2 = J.Neck

    if Neck2:IsA( "Motor6D" ) then
        C04 = Neck2.C0
        C14 = Neck2.C1
    else
        C04 = Neck2.Attachment0.CFrame
        C14 = Neck2.Attachment1.CFrame
    end

    local C05, C15
    Neck2.Transform = ( CFrame7 * C04 ):Inverse( ) * CFrame8 * C14
    local Neck3 = J.Neck

    if Neck3:IsA( "Motor6D" ) then
        C05 = Neck3.C0
        C15 = Neck3.C1
    else
        C05 = Neck3.Attachment0.CFrame
        C15 = Neck3.Attachment1.CFrame
    end

    local GunFromButt2
    local Position5 = ( CFrame7 * C05 * Neck3.Transform * C15:Inverse( ) * CFrame.new( Vector3.new( 0.17000000178813934, 0.10000000149011612, -0.41999998688697815 ) ) ).Position
    local Unit = ( Target2 - Position5 ).Unit
    local Position6 = ( CFrame7 * CFrame.new( Vector3.new( 0.36000001430511475, 0.3799999952316284, -0.41999998688697815 ) ) ).Position
    local Unit2 = Unit:Cross( Vector3.new( 0, 1, 0 ) ).Unit
    local Unit3 = Unit2:Cross( Unit ).Unit
    local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit2, Unit3, -Unit ) * CFrame.Angles( 0, 0, -0.03490658503988659 )
    local Rear = Geo.rear + ( Position6 - Position5 ):Dot( Unit ) + 0.05
    local CFrame9 = CFrame.new( Position5 + Unit2 * ( Position6 - Position5 ):Dot( Unit2 ) - Unit3 * ( Geo.sight + 0.42 ) + Unit * Rear ) * FromMatrix
    local Role = Argument1.role

    if Role == "high" then
        local Position7 = ( CFrame7 * CFrame.new( 0.3, 0.02, -0.5 ) ).Position
        GunFromButt2 = GunFromButt( Geo, Position7, Tilt( Unit, 30, 14 ), -6 )
    elseif Role == "hip" then
        local Position8 = ( CFrame7 * CFrame.new( 0.3, -0.38, -0.3 ) ).Position
        GunFromButt3 = GunFromButt( Geo, Position8, Tilt( Unit, -7, 20 ), -4 )
    elseif Role == "scope" then
        local Butt = Geo.butt
        local CFrame10 = CFrame9 * Vector3.new( 0, Butt, Geo.rear ) - Vector3.new( 0, 0.11999999731779099, 0 )
        GunFromButt4 = GunFromButt( Geo, CFrame10, Tilt( Unit, -9, 4 ), -2 )
    elseif Role == "signal" then
        local Position9 = ( CFrame7 * CFrame.new( 0.4, 0.26, -0.46 ) ).Position
        GunFromButt5 = GunFromButt( Geo, Position9, Tilt( Unit, -38, 16 ), -8 )
    else
        GunFromButt6 = GunFromButt( Geo, Position6, Tilt( Unit, -30, 24 ), -4 )
    end

    local Jolt2
    local Lerp2 = Value4:Lerp( CFrame9, Clamp2 ) * CFrame.Angles( Rad( Exp2 * 2.5 ), 0, 0 )
    local Jolt = Argument1.jolt
    Jolt2 = if Jolt then Jolt else CFrame.identity
    local Lerp3 = Lerp2 * Jolt2

    if Argument1.joint then
        local Joint = Argument1.joint
        Joint.C0 = CFrame7:Inverse( ) * Lerp3
    end
    if J.RightShoulder and J.RightElbow and J.RightWrist then
        local RightShoulder = J.RightShoulder
        local RightElbow = J.RightElbow
        local RightWrist = J.RightWrist
        Solve2( RightShoulder, RightElbow, RightWrist, CFrame7, Lerp3 * Argument1.RH, ( CFrame7 * CFrame.new( Vector3.new( 1.5, -1.7000000476837158, 0.6000000238418579 ) ) ).Position )
    end
    if J.LeftShoulder and J.LeftElbow and J.LeftWrist then
        local Lerp4 = Lerp3 * Argument1.LH

        if Argument1.reachL then
            local C06
            local LeftShoulder = J.LeftShoulder

            if LeftShoulder:IsA( "Motor6D" ) then
                C06 = LeftShoulder.C0
                local C16 = LeftShoulder.C1
            else
                C06 = LeftShoulder.Attachment0.CFrame
                local CFrame11 = LeftShoulder.Attachment1.CFrame
            end

            local Lerp6
            local Position10 = ( CFrame7 * C06 ).Position
            local CFrame12 = CFrame.new( 0, 0, 0.3 ) * Argument1.LHback

            local function At( Amount )
                local Lerp2

                if Amount <= 1 then
                    local LH = Argument1.LH
                    local Lerp = LH:Lerp( Argument1.LHback, Amount )

                    if Lerp then
                        Lerp2 = Lerp
                    else
                        Lerp2 = Argument1.LHback:Lerp( CFrame12, Amount - 1 )
                    end
                else
                    Lerp2 = Argument1.LHback:Lerp( CFrame12, Amount - 1 )
                end

                return Lerp2
            end

            local function Ok( Amount )
                local Lerp2

                if Amount <= 1 then
                    local LH = Argument1.LH
                    local Lerp = LH:Lerp( Argument1.LHback, Amount )

                    if Lerp then
                        Lerp2 = Lerp
                    else
                        Lerp2 = Argument1.LHback:Lerp( CFrame12, Amount - 1 )
                    end
                else
                    Lerp2 = Argument1.LHback:Lerp( CFrame12, Amount - 1 )
                end

                local Flag = ( Lerp3 * Lerp2 * Argument1.wristL - Position10 ).Magnitude <= Argument1.reachL * 0.93 and true or false
                return Flag
            end

            local LH = Argument1.LH
            local Lerp5 = LH:Lerp( Argument1.LHback, 0 )
            Lerp6 = if Lerp5 then Lerp5 else Argument1.LHback:Lerp( CFrame12, -1 )
            local Flag = ( Lerp3 * Lerp6 * Argument1.wristL - Position10 ).Magnitude <= Argument1.reachL * 0.93 and true or false
            local Number13

            if Flag then
                Number13 = 0
            else
                local Flag2 = ( Lerp3 * Argument1.LHback:Lerp( CFrame12, 1 ) * Argument1.wristL - Position10 ).Magnitude <= Argument1.reachL * 0.93 and true or false
                local Number11

                if Flag2 then
                    local Number10
                    local I = 1
                    Number10 = 0
                    Number11 = 2
                    Number11 = 2

                    for I = 1, 10 do
                        local Lerp8
                        local Number12 = ( Number10 + Number11 ) / 2

                        if Number12 <= 1 then
                            local LH2 = Argument1.LH
                            local Lerp7 = LH2:Lerp( Argument1.LHback, Number12 )

                            if Lerp7 then
                                Lerp8 = Lerp7
                            else
                                local LHback = Argument1.LHback
                                Lerp8 = LHback:Lerp( CFrame12, Number12 - 1 )
                            end
                        else
                            local LHback = Argument1.LHback
                            Lerp8 = LHback:Lerp( CFrame12, Number12 - 1 )
                        end

                        local Flag3 = ( Lerp3 * Lerp8 * Argument1.wristL - Position10 ).Magnitude <= Argument1.reachL * 0.93 and true or false

                        if Flag3 then
                            Number11 = Number12
                        else
                            Number10 = Number12
                        end
                    end
                else
                    Number11 = 2
                end

                Number13 = Number11
            end

            local Clamp13

            if Argument1.lastStep then
                local Clamp12 = math.clamp( Settle - Argument1.lastStep, 0, 0.1 )

                if Clamp12 then
                    Clamp13 = Clamp12
                else
                    Clamp13 = 0
                end
            else
                Clamp13 = 0
            end

            local LhS2

            if Argument1.lhS then
                local LhS = Argument1.lhS + ( Number13 - Argument1.lhS ) * ( 1 - math.exp( -12 * Clamp13 ) )

                if LhS then
                    LhS2 = LhS
                else
                    LhS2 = Number13
                end
            else
                LhS2 = Number13
            end

            Argument1.lhS = LhS2

            if Argument1.lhS < Number13 then
                local LhS3 = Argument1.lhS
                Argument1.lhS = math.max( LhS3, Number13 - 0.04 )
            end

            local Lerp10
            local LhS4 = Argument1.lhS

            if LhS4 <= 1 then
                local LH3 = Argument1.LH
                local Lerp9 = LH3:Lerp( Argument1.LHback, LhS4 )

                if Lerp9 then
                    Lerp10 = Lerp9
                else
                    local LHback2 = Argument1.LHback
                    Lerp10 = LHback2:Lerp( CFrame12, LhS4 - 1 )
                end
            else
                local LHback2 = Argument1.LHback
                Lerp10 = LHback2:Lerp( CFrame12, LhS4 - 1 )
            end

            Lerp4 = Lerp3 * Lerp10
        end

        local Lerp11
        local Position11 = ( CFrame7 * CFrame.new( Vector3.new( -0.699999988079071, -2, -0.6000000238418579 ) ) ).Position

        if Role == "signal" then
            local Clamp17
            local Clamp14 = math.clamp( ( Argument1.k or 0 ) * 1.6, 0, 1 )
            local Clamp15 = 1 - Clamp14 * Clamp14 * ( 3 - 2 * Clamp14 )

            if Argument1.lastStep then
                local Clamp16 = math.clamp( Settle - Argument1.lastStep, 0, 0.1 )

                if Clamp16 then
                    Clamp17 = Clamp16
                else
                    Clamp17 = 0
                end
            else
                Clamp17 = 0
            end

            local SigS2

            if Argument1.sigS then
                local SigS = Argument1.sigS + ( Clamp15 - Argument1.sigS ) * ( 1 - math.exp( -9 * Clamp17 ) )

                if SigS then
                    SigS2 = SigS
                else
                    SigS2 = Clamp15
                end
            else
                SigS2 = Clamp15
            end

            Argument1.sigS = SigS2
            local Clamp18 = math.clamp( Argument1.sigS, 0, 1 )
            local Clamp19 = Clamp18 * Clamp18 * ( 3 - 2 * Clamp18 )

            if Clamp19 > 0.001 then
                Lerp4 = Lerp4:Lerp( CFrame7 * CFrame.new( -1.2, math.sin( Settle * 1.45 + Phase ) * 0.02 + 1.62, -0.12 ) * CFrame.Angles( 3.141592653589793, 0, 0.06981317007977318 ), Clamp19 )
                Lerp11 = Position11:Lerp( ( CFrame7 * CFrame.new( -2.8, 0.5, 0.3 ) ).Position, Clamp19 )
            else
                Lerp11 = Position11
            end
        else
            Lerp11 = Position11
        end

        local LeftShoulder2 = J.LeftShoulder
        local LeftElbow = J.LeftElbow
        Solve2( LeftShoulder2, LeftElbow, J.LeftWrist, CFrame7, Lerp4, Lerp11 )
    end

    Argument1.lastStep = Settle
end
return Table
