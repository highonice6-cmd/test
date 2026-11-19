-- ReplicatedStorage.Weapons.Clips
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

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

local function Load( Argument1 )
    local Value1
    local Table = { }
    local Frames = Argument1.frames
    Value1 = nil

    for Key, Value in Frames, nil, nil do
        local Value2, Number
        local Item = Value[ 1 ]
        local Item2 = Value[ 2 ]
        local Item3 = Value[ 3 ]
        local Table3 = {
            t = Item,
            pos = Vector3.new( Item2, Item3, Value[ 4 ] ),
            rot = CFrame.new( 0, 0, 0, Value[ 5 ], Value[ 6 ], Value[ 7 ], Value[ 8 ] ),
            j = { }
        }
        Value2 = nil
        Number = 9

        for Key2, Value3 in Table2, nil, nil do
            local J = Table3.j
            J[ Value3 ] = CFrame.new( 0, 0, 0, Value[ Number ], Value[ Number + 1 ], Value[ Number + 2 ], Value[ Number + 3 ] )
            Number = Number + 4
        end

        Table[ Key ] = Table3
    end

    local BaseY2
    local Table2Inner = { frames = Table, length = Table[ #Table ].t }
    local BaseY = Argument1.baseY
    BaseY2 = if BaseY then BaseY else Table[ 1 ].pos.Y
    Table2Inner.baseY = BaseY2
    return Table2Inner
end

local Table = {
    ARMS = {
        RightShoulder = true,
        RightElbow = true,
        RightWrist = true,
        LeftShoulder = true,
        LeftElbow = true,
        LeftWrist = true
    },
    Jump = Load( require( script.Parent:WaitForChild( "JumpData" ) ) ),
    Roll = Load( require( script.Parent:WaitForChild( "RollData" ) ) ),
    CrouchIdle = Load( require( script.Parent:WaitForChild( "CrouchIdleData" ) ) ),
    CrouchWalk = Load( require( script.Parent:WaitForChild( "CrouchWalkData" ) ) ),
    CrouchStand = Load( require( script.Parent:WaitForChild( "CrouchStandData" ) ) )
}
local Table3 = {
    PhonkDance = "PhonkDanceData",
    GModDance = "GModDanceData",
    HipHopDance = "HipHopDanceData",
    ZombieRun = "ZombieRunData",
    ZombieIdle = "ZombieIdleData",
    CrouchLeft = "CrouchLeftData",
    CrouchRight = "CrouchRightData"
}
local Parent = script.Parent
setmetatable( Table, {
    __index = function( Argument1, Key )
        local Entry = Table3[ Key ]

        if Entry then
            local Load2 = Load( require( Parent:WaitForChild( Entry ) ) )
            rawset( Argument1, Key, Load2 )
            return Load2
        end
        return nil
    end
} )
Table.STAND_Y = -0.3
function Table.FaceForward( Argument1, List )
    local Value1
    local FromEulerAnglesYXZ = CFrame.fromEulerAnglesYXZ( Argument1:ToEulerAnglesYXZ( ), 0, 0 )
    local Inverse = FromEulerAnglesYXZ:Inverse( ) * Argument1
    local Table = { "RightHip", "LeftHip" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        if List[ Value ] then
            List[ Value ] = Inverse * List[ Value ]
        end
    end
    if List.Waist then
        List.Waist = CFrame.fromEulerAnglesYXZ( List.Waist:ToEulerAnglesYXZ( ), 0, 0 )
    end
    if List.Neck then
        List.Neck = CFrame.fromEulerAnglesYXZ( List.Neck:ToEulerAnglesYXZ( ), 0, 0 )
    end

    return FromEulerAnglesYXZ, List
end
function Table.Sample( Argument1, Argument2 )
    local Number
    local Frames = Argument1.frames
    local Clamp = math.clamp( Argument2, 0, Argument1.length )
    Number = 1

    while Number < #Frames - 1 do
        if not ( Frames[ Number + 1 ].t <= Clamp ) then
            break
        end

        Number = Number + 1
    end

    local Clamp3
    local Entry = Frames[ Number ]
    local Number2 = Number + 1
    local Entry2 = Frames[ math.min( Number2, #Frames ) ]
    local T = Entry2.t

    if Entry.t < T then
        local Clamp2 = math.clamp( ( Clamp - Entry.t ) / ( Entry2.t - Entry.t ), 0, 1 )

        if Clamp2 then
            Clamp3 = Clamp2
        else
            Clamp3 = 0
        end
    else
        Clamp3 = 0
    end

    local Value1
    local Table = { }
    local J = Entry.j
    Value1 = nil

    for Key, Value in J, nil, nil do
        Table[ Key ] = Value:Lerp( Entry2.j[ Key ], Clamp3 )
    end

    local Pos = Entry.pos
    local Lerp = Pos:Lerp( Entry2.pos, Clamp3 )
    local Rot = Entry.rot
    return Lerp, Rot:Lerp( Entry2.rot, Clamp3 ), Table
end
function Table.Velocity( Argument1, Amount )
    local Sample = Table.Sample
    local Sample2 = Sample( Argument1, Amount - 0.03333333333333333 )
    local Sample3 = Table.Sample
    return ( Sample3( Argument1, Amount + 0.03333333333333333 ) - Sample2 ) / 0.06666666666666667
end
return Table
