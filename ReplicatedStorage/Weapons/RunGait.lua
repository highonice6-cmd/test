-- ReplicatedStorage.Weapons.RunGait
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value2
local Config = require( script.Parent.Config )
local Table = { }
local Value1 = nil
pcall( function()
    Value1 = require( script.Parent:FindFirstChild( "FastRunData" ) )
end )
local Table2 = {
    "Waist",
    "Neck",
    "RightShoulder",
    "RightElbow",
    "RightWrist",
    "LeftShoulder",
    "LeftElbow",
    "LeftWrist",
    "RightHip",
    "RightKnee",
    "RightAnkle",
    "LeftHip",
    "LeftKnee",
    "LeftAnkle"
}
local Table3 = {
    Waist = true,
    Neck = true,
    RightHip = true,
    RightKnee = true,
    RightAnkle = true,
    LeftHip = true,
    LeftKnee = true,
    LeftAnkle = true
}
local Table4 = { }
Value2 = nil

for Key, Value in Table2, nil, nil do
    Table4[ Value ] = true
end

local Value3 = nil

local function GetFastFrames()
    if Value3 then
        return Value3
    end

    local Value1Inner
    Value3 = { }
    local Frames = Value1.frames
    Value1Inner = nil

    for Key, Value in Frames, nil, nil do
        local Value2, Number
        local Table = {
            Root = CFrame.new( Value[ 2 ], Value[ 3 ], Value[ 4 ], Value[ 5 ], Value[ 6 ], Value[ 7 ], Value[ 8 ] )
        }
        Value2 = nil
        Number = 9

        for Key2, Value3Inner in Table2, nil, nil do
            Table[ Value3Inner ] = CFrame.new( 0, 0, 0, Value[ Number ], Value[ Number + 1 ], Value[ Number + 2 ], Value[ Number + 3 ] )
            Number = Number + 4
        end

        Value3[ Key ] = Table
    end

    return Value3
end

function Table.HasFastRun()
    local Flag = Value1 ~= nil and true or false
    return Flag
end

local function SafePhase( Amount )
    if type( Amount ) ~= "number" or Amount ~= Amount or Amount == math.huge or Amount == -math.huge then
        return 0
    end
    return Amount
end

function Table.SampleFastRun( Amount, Argument2 )
    local Number = ( type( Amount ) ~= "number" or Amount ~= Amount or Amount == math.huge or Amount == -math.huge ) and 0 or Amount
    local Captured
    local FastFrames = GetFastFrames( )
    local Count = #FastFrames - 1
    local StrikeFrame = ( ( Value1.StrikeFrame or 1 ) - 1 + Number % 1 * Count ) % Count
    local Floor = math.floor( StrikeFrame )
    local StrikeFrame2 = StrikeFrame - Floor
    local Entry = FastFrames[ Floor + 1 ]
    local Entry2 = FastFrames[ Floor + 2 ]
    local Root = Entry.Root
    local Table = { Root = Root:Lerp( Entry2.Root, StrikeFrame2 ) }
    Captured = Argument2 and Table4 or Table3
    local Value2 = nil

    for Value in Captured, nil, nil do
        local Entry3 = Entry[ Value ]
        Table[ Value ] = Entry3:Lerp( Entry2[ Value ], StrikeFrame2 )
    end

    return Table
end
Table.Curves = {
    Hip = {
        { 0, 18 },
        { 0.1, 12 },
        { 0.22, 0 },
        { 0.36, -22 },
        { 0.46, -14 },
        { 0.58, 10 },
        { 0.7, 38 },
        { 0.8, 50 },
        { 0.9, 36 }
    },
    Knee = {
        { 0, 18 },
        { 0.1, 28 },
        { 0.22, 20 },
        { 0.36, 12 },
        { 0.48, 70 },
        { 0.6, 122 },
        { 0.7, 115 },
        { 0.8, 80 },
        { 0.92, 30 }
    },
    Ankle = {
        { 0, 2 },
        { 0.1, 16 },
        { 0.22, 10 },
        { 0.36, -30 },
        { 0.48, -26 },
        { 0.62, -10 },
        { 0.78, 4 },
        { 0.92, 4 }
    }
}

local function Curve( List, Amount )
    local Total
    local Result = Amount % 1
    local Count = #List
    local I = 1
    Total = Count

    for I = 1, Count do
        if Result < List[ I ][ 1 ] then
            Total = I - 1
            break
        end

        Total = Count
    end
    if Total < 1 then
        Total = Count
    end

    local Result2

    local function Pt( Amount )
        local Total = ( Amount - 1 ) % Count + 1
        return List[ Total ][ 1 ] + math.floor( ( Amount - 1 ) / Count ), List[ Total ][ 2 ]
    end

    local Count2 = Total - 1
    local Count3 = ( Count2 - 1 ) % Count + 1
    local Item = List[ Count3 ][ 1 ] + math.floor( ( Count2 - 1 ) / Count )
    local Item2 = List[ Count3 ][ 2 ]
    local Count4 = ( Total - 1 ) % Count + 1
    local Item3 = List[ Count4 ][ 1 ] + math.floor( ( Total - 1 ) / Count )
    local Item4 = List[ Count4 ][ 2 ]
    local Count5 = Total + 1
    local Count6 = ( Count5 - 1 ) % Count + 1
    local Item5 = List[ Count6 ][ 1 ] + math.floor( ( Count5 - 1 ) / Count )
    local Item6 = List[ Count6 ][ 2 ]
    local Count7 = Total + 2
    local Count8 = ( Count7 - 1 ) % Count + 1
    local Item7 = List[ Count8 ][ 1 ] + math.floor( ( Count7 - 1 ) / Count )
    local Item8 = List[ Count8 ][ 2 ]
    Result2 = Result < Item3 and Result + 1 or Result
    local Result3 = ( Result2 - Item3 ) / ( Item5 - Item3 )
    local Result4 = Result3 * Result3
    local Result5 = Result3 * Result3 * Result3
    return 0.5 * ( 2 * Item4 + ( Item6 - Item2 ) * Result3 + ( 2 * Item2 - 5 * Item4 + 4 * Item6 - Item8 ) * Result4 + ( 3 * Item4 - Item2 - 3 * Item6 + Item8 ) * Result5 )
end

Table.Curve = Curve
local Table5 = {
    "Waist",
    "Neck",
    "RightShoulder",
    "RightElbow",
    "RightWrist",
    "LeftShoulder",
    "LeftElbow",
    "LeftWrist"
}
local Table6 = {
    Root = true,
    RightHip = true,
    RightKnee = true,
    RightAnkle = true,
    LeftHip = true,
    LeftKnee = true,
    LeftAnkle = true
}
local Table7 = {
    "Root",
    "Waist",
    "Neck",
    "RightShoulder",
    "RightElbow",
    "RightWrist",
    "LeftShoulder",
    "LeftElbow",
    "LeftWrist",
    "RightHip",
    "RightKnee",
    "RightAnkle",
    "LeftHip",
    "LeftKnee",
    "LeftAnkle",
    "Gun",
    "RightHand",
    "LeftHand"
}

local function ToQuat( Argument1 )
    local ToAxisAngle, ToAxisAngle2 = Argument1:ToAxisAngle( )

    if ToAxisAngle2 == ToAxisAngle2 then
        local Sin = math.sin( ToAxisAngle2 / 2 )
        return {
            ToAxisAngle.X * Sin,
            ToAxisAngle.Y * Sin,
            ToAxisAngle.Z * Sin,
            ( math.cos( ToAxisAngle2 / 2 ) )
        }
    end
    return { 0, 0, 0, 1 }
end

local function Cr( Amount, Amount2, Amount3, Argument4, Argument5 )
    local Result = Argument5 * Argument5
    local Result2 = Argument5 * Argument5 * Argument5
    return 0.5 * ( 2 * Amount2 + ( Amount3 - Amount ) * Argument5 + ( 2 * Amount - 5 * Amount2 + 4 * Amount3 - Argument4 ) * Result + ( 3 * Amount2 - Amount - 3 * Amount3 + Argument4 ) * Result2 )
end

local Class = setmetatable( { }, { __mode = "k" } )

local function Prepare( List )
    local Entry = Class[ List ]

    if Entry then
        return Entry
    end

    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Table7, nil, nil do
        local Value2
        local Table2 = { }
        Value2 = nil

        for Key2, Value3 in List, nil, nil do
            local Entry3
            local Entry2 = Value3[ Value ]
            Entry3 = if Entry2 then Entry2 else CFrame.identity
            Table2[ Key2 ] = { pos = Entry3.Position, q = ToQuat( Entry3 ) }
        end

        Table[ Value ] = Table2
    end

    Class[ List ] = Table
    return Table
end

local function SampleKey( List, Result )
    local Item18, Item22, Item26, Item30
    local Count = #List
    local Floor = math.floor( Result )
    local Floor2 = Result - Floor
    local Entry = List[ ( Floor - 1 ) % Count + 1 ]
    local Entry2 = List[ Floor % Count + 1 ]
    local Entry3 = List[ ( Floor + 1 ) % Count + 1 ]
    local Entry4 = List[ ( Floor + 2 ) % Count + 1 ]
    local Q = Entry2.q
    local Item = Q[ 1 ]
    local Item2 = Q[ 2 ]
    local Item3 = Q[ 3 ]
    local Item4 = Q[ 4 ]
    local Q2 = Entry.q
    local Q3 = Entry3.q
    local Q4 = Entry4.q
    local Item5 = Q2[ 1 ]
    local Item6 = Q2[ 2 ]
    local Item7 = Q2[ 3 ]
    local Item8 = Q2[ 4 ]

    if Item5 * Item + Item6 * Item2 + Item7 * Item3 + Item8 * Item4 < 0 then
        Item18 = -Item5
        Item22 = -Item6
        Item26 = -Item7
        Item30 = -Item8
    else
        Item18 = Item5
        Item22 = Item6
        Item26 = Item7
        Item30 = Item8
    end

    local Item17, Item21, Item25, Item29
    local Item9 = Q3[ 1 ]
    local Item10 = Q3[ 2 ]
    local Item11 = Q3[ 3 ]
    local Item12 = Q3[ 4 ]

    if Item9 * Item + Item10 * Item2 + Item11 * Item3 + Item12 * Item4 < 0 then
        Item17 = -Item9
        Item21 = -Item10
        Item25 = -Item11
        Item29 = -Item12
    else
        Item17 = Item9
        Item21 = Item10
        Item25 = Item11
        Item29 = Item12
    end

    local Item19, Item23, Item27, Item31
    local Item13 = Q4[ 1 ]
    local Item14 = Q4[ 2 ]
    local Item15 = Q4[ 3 ]
    local Item16 = Q4[ 4 ]

    if Item13 * Item + Item14 * Item2 + Item15 * Item3 + Item16 * Item4 < 0 then
        Item19 = -Item13
        Item23 = -Item14
        Item27 = -Item15
        Item31 = -Item16
    else
        Item19 = Item13
        Item23 = Item14
        Item27 = Item15
        Item31 = Item16
    end

    local Floor3 = Floor2 * Floor2
    local Floor4 = Floor2 * Floor2 * Floor2
    local Item20 = 0.5 * ( 2 * Item + ( Item17 - Item18 ) * Floor2 + ( 2 * Item18 - 5 * Item + 4 * Item17 - Item19 ) * Floor3 + ( 3 * Item - Item18 - 3 * Item17 + Item19 ) * Floor4 )
    local Floor5 = Floor2 * Floor2
    local Floor6 = Floor2 * Floor2 * Floor2
    local Item24 = 0.5 * ( 2 * Item2 + ( Item21 - Item22 ) * Floor2 + ( 2 * Item22 - 5 * Item2 + 4 * Item21 - Item23 ) * Floor5 + ( 3 * Item2 - Item22 - 3 * Item21 + Item23 ) * Floor6 )
    local Floor7 = Floor2 * Floor2
    local Floor8 = Floor2 * Floor2 * Floor2
    local Item28 = 0.5 * ( 2 * Item3 + ( Item25 - Item26 ) * Floor2 + ( 2 * Item26 - 5 * Item3 + 4 * Item25 - Item27 ) * Floor7 + ( 3 * Item3 - Item26 - 3 * Item25 + Item27 ) * Floor8 )
    local Floor9 = Floor2 * Floor2
    local Floor10 = Floor2 * Floor2 * Floor2
    local Item32 = 0.5 * ( 2 * Item4 + ( Item29 - Item30 ) * Floor2 + ( 2 * Item30 - 5 * Item4 + 4 * Item29 - Item31 ) * Floor9 + ( 3 * Item4 - Item30 - 3 * Item29 + Item31 ) * Floor10 )
    local Sqrt = math.sqrt( 0 + Item20 * Item20 + Item24 * Item24 + Item28 * Item28 + Item32 * Item32 )
    local Pos = Entry.pos
    local Pos2 = Entry2.pos
    local Pos3 = Entry3.pos
    local Pos4 = Entry4.pos
    local X = Pos.X
    local X2 = Pos2.X
    local X3 = Pos3.X
    local X4 = Pos4.X
    local Floor11 = Floor2 * Floor2
    local Floor12 = Floor2 * Floor2 * Floor2
    local X5 = 0.5 * ( 2 * X2 + ( X3 - X ) * Floor2 + ( 2 * X - 5 * X2 + 4 * X3 - X4 ) * Floor11 + ( 3 * X2 - X - 3 * X3 + X4 ) * Floor12 )
    local Y = Pos.Y
    local Y2 = Pos2.Y
    local Y3 = Pos3.Y
    local Y4 = Pos4.Y
    local Floor13 = Floor2 * Floor2
    local Floor14 = Floor2 * Floor2 * Floor2
    local Y5 = 0.5 * ( 2 * Y2 + ( Y3 - Y ) * Floor2 + ( 2 * Y - 5 * Y2 + 4 * Y3 - Y4 ) * Floor13 + ( 3 * Y2 - Y - 3 * Y3 + Y4 ) * Floor14 )
    local Z = Pos.Z
    local Z2 = Pos2.Z
    local Z3 = Pos3.Z
    local Z4 = Pos4.Z
    local Floor15 = Floor2 * Floor2
    local Floor16 = Floor2 * Floor2 * Floor2
    local Vector32 = Vector3.new( X5, Y5, 0.5 * ( 2 * Z2 + ( Z3 - Z ) * Floor2 + ( 2 * Z - 5 * Z2 + 4 * Z3 - Z4 ) * Floor15 + ( 3 * Z2 - Z - 3 * Z3 + Z4 ) * Floor16 ) )
    return CFrame.new( Vector32.X, Vector32.Y, Vector32.Z, Item20 / Sqrt, Item24 / Sqrt, Item28 / Sqrt, Item32 / Sqrt )
end

local Table8 = { RightHip = 1, LeftHip = -1 }

local function SampleFrames( List, Number, Amount2, Argument4, List2 )
    local Prepare2 = Prepare( List )
    local Result = Number % 1 * #List
    local Table = { }
    local Value2 = nil

    for Key, Value in List2 or Table7, nil, nil do
        local Lerp
        local SampleKey2 = SampleKey( Prepare2[ Value ], Result )

        if not Table6[ Value ] or not ( Amount2 < 1 ) then
            Lerp = SampleKey2
        else
            Lerp = CFrame.identity:Lerp( SampleKey2, Amount2 )
        end

        Table[ Value ] = Lerp
    end
    if Argument4 and Argument4.LegSpread then
        local Value3 = nil

        for Key2, Value4 in Table8, nil, nil do
            local Entry = Table[ Key2 ]

            if Entry then
                local ToOrientation, ToOrientation2 = Entry:ToOrientation( )
                Table[ Key2 ] = CFrame.new( Entry.Position ) * CFrame.fromOrientation( ToOrientation, ToOrientation2, ( math.rad( Argument4.LegSpread * Value4 ) ) )
            end
        end
    end

    return Table
end

function Table.Lift( Amount, Argument2 )
    local RunCycle = ( Argument2 or Config ).RunCycle
    local Result = Amount * 2 % 1
    local FlightStart = RunCycle.FlightStart or 0.6

    if Result < FlightStart then
        return 0
    end
    local Result2 = ( Result - FlightStart ) / ( 1 - FlightStart )
    return ( RunCycle.Bounce or 0 ) * math.sin( 3.141592653589793 * Result2 )
end
function Table.Sample( Amount2, Amount22, Argument3, List2 )
    local Number = ( type( Amount2 ) ~= "number" or Amount2 ~= Amount2 or Amount2 == math.huge or Amount2 == -math.huge ) and 0 or Amount2
    local Number2 = ( type( Amount22 ) ~= "number" or Amount22 ~= Amount22 ) and 1 or Amount22

    if ( Argument3 or Config ).RunFrames and #( Argument3 or Config ).RunFrames >= 2 then
        local RunFrames = ( Argument3 or Config ).RunFrames
        return ( SampleFrames( RunFrames, Number, Number2, ( Argument3 or Config ).RunCycle, List2 ) )
    end

    local Value1
    local RunCycle = ( Argument3 or Config ).RunCycle
    local Curves = Table.Curves
    local Number3 = Number % 1
    local TableInner = { }
    local Table2 = { Right = 0, Left = 0.5 }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local LegSpread
        local Number4 = Number3 + Value
        LegSpread = Key == "Right" and RunCycle.LegSpread or -RunCycle.LegSpread
        local Text = Key .. "Hip"
        local Rad = math.rad( Curve( Curves.Hip, Number4 ) * Number2 )
        TableInner[ Text ] = CFrame.Angles( Rad, 0, ( math.rad( LegSpread ) ) )
        TableInner[ Key .. "Knee" ] = CFrame.Angles( -math.rad( Curve( Curves.Knee, Number4 ) * Number2 ), 0, 0 )
        TableInner[ Key .. "Ankle" ] = CFrame.Angles( math.rad( Curve( Curves.Ankle, Number4 ) * Number2 ), 0, 0 )
    end

    local Value2
    local Cos = math.cos( Number3 * 2 * 3.141592653589793 )
    local Sin = math.sin( Number3 * 2 * 3.141592653589793 )
    local PelvisYaw = RunCycle.PelvisYaw * Cos * Number2
    local PelvisRoll = RunCycle.PelvisRoll * Sin * Number2
    TableInner.Root = CFrame.Angles( -math.rad( RunCycle.HipLean ), math.rad( PelvisYaw ), ( math.rad( PelvisRoll ) ) )
    local Item = RunCycle.Poses[ 1 ]
    local Item2 = RunCycle.Poses[ 2 ]
    local Cos2 = 0.5 - Cos * 0.5 * ( RunCycle.ArmSwing or 1 )
    Value2 = nil

    for Key2, Value3 in Table5, nil, nil do
        local Entry = Item[ Value3 ]
        TableInner[ Value3 ] = Entry:Lerp( Item2[ Value3 ], Cos2 )
    end

    TableInner.Waist = CFrame.Angles( 0, -math.rad( PelvisYaw + RunCycle.TorsoTwist * Cos * Number2 ), -math.rad( PelvisRoll * 0.8 ) ) * TableInner.Waist
    local Gun = Item.Gun
    TableInner.Gun = Gun:Lerp( Item2.Gun, Cos2 )
    local RightHand = Item.RightHand
    TableInner.RightHand = RightHand:Lerp( Item2.RightHand, Cos2 )
    local LeftHand = Item.LeftHand
    TableInner.LeftHand = LeftHand:Lerp( Item2.LeftHand, Cos2 )
    return TableInner
end
return Table
