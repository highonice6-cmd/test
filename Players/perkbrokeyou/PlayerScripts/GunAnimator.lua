-- Players.perkbrokeyou.PlayerScripts.GunAnimator
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Storage = { }
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Config = require( Weapons:WaitForChild( "Config" ) )
local WeaponData = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "WeaponData" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local GunRig = require( Weapons:WaitForChild( "GunRig" ) )
local Poignee = require( Weapons:WaitForChild( "Poignee" ) )
local ArmIK = require( Weapons:WaitForChild( "ArmIK" ) )
local BodyLife = require( Weapons:WaitForChild( "BodyLife" ) )
local RunGait = require( Weapons:WaitForChild( "RunGait" ) )

if script:FindFirstAncestorOfClass( "Actor" ) then
    Storage.Controls2 = nil
else
    local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )

    if Controls then
        Storage.Controls2 = Controls
    else
        Storage.Controls2 = nil
    end
end
local BoltAction = require( Weapons:WaitForChild( "BoltAction" ) )
local CrouchAnim = require( Weapons:WaitForChild( "CrouchAnim" ) )
local Holds = require( Weapons:WaitForChild( "Holds" ) )
local SeatedArms = require( Weapons:WaitForChild( "SeatedArms" ) )
local FistAnim = require( Weapons:WaitForChild( "FistAnim" ) )
local SwimTilt = require( Weapons:WaitForChild( "SwimTilt" ) )
local FrameCache = require( Weapons:WaitForChild( "FrameCache" ) )
local AnimWorkers = require( Weapons:WaitForChild( "AnimWorkers" ) )
AnimWorkers.Init( script )
local Callback = nil
local Callback2 = nil
local Callback3 = nil
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local CurrentCamera = workspace.CurrentCamera
local Table = { 80, 180, 350 }
local Flag = false
local Number = 0
local Class = setmetatable( { }, { __mode = "k" } )
local Table2 = { 30, 20 }
local Flag2 = true
local Number2 = -math.huge
local Number3 = 0
local Number4 = 0
local Number5 = 0
local Number6 = 0
local OnScreen = require( Weapons:WaitForChild( "OnScreen" ) )
local List = OnScreen.list

local function Visible( Key )
    local Flag = List[ Key ] ~= false and true or false
    return Flag
end

local Number7 = 0
local Value1 = nil
local Value2 = nil

local function UpdateOnScreen( Screen )
    local CFrame = CurrentCamera.CFrame
    local Clock = os.clock( )

    if Value1 then
        local Max = math.max( Clock - Value2, 0.001 )
        local Acos = math.acos( ( math.clamp( CFrame.LookVector:Dot( Value1 ), -1, 1 ) ) ) / Max
        Number7 = math.max( Acos, Number7 * math.exp( Max * -4 ) )
    end

    local Value1Inner
    Value1 = CFrame.LookVector
    Value2 = Clock
    local Clamp = math.clamp( Number7 * 0.05 + 0.17453292519943295, 0.17453292519943295, 1.0471975511965976 )
    local ViewportSize = CurrentCamera.ViewportSize
    local Rad = math.rad( CurrentCamera.FieldOfView ) / 2
    local Atan = math.atan( math.tan( Rad ) * ViewportSize.X / math.max( ViewportSize.Y, 1 ) )
    local Tan = math.tan( ( math.min( Rad + Clamp, 1.5533430342749532 ) ) )
    local Tan2 = math.tan( ( math.min( Atan + Clamp, 1.5533430342749532 ) ) )
    local Sqrt = math.sqrt( Tan * Tan + 1 )
    local Sqrt2 = math.sqrt( Tan2 * Tan2 + 1 )
    Value1Inner = nil

    for Key, Value in Screen, nil, nil do
        local HumanoidRootPart

        if Value == Character then
            HumanoidRootPart = false
        else
            HumanoidRootPart = Value:FindFirstChild( "HumanoidRootPart" )
        end

        local Flag2

        if HumanoidRootPart then
            local PointToObjectSpace = CFrame:PointToObjectSpace( HumanoidRootPart.Position )

            if PointToObjectSpace.Magnitude > 30 then
                local Flag
                local Amount = -PointToObjectSpace.Z

                if Amount > -7 then
                    if math.abs( PointToObjectSpace.X ) <= Amount * Tan2 + Sqrt2 * 7 then
                        if math.abs( PointToObjectSpace.Y ) <= Amount * Tan + Sqrt * 7 then
                            Flag = true
                        else
                            Flag = false
                        end
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end

                Flag2 = Flag
            else
                Flag2 = true
            end
        else
            Flag2 = true
        end
        if OnScreen.forceOff and Value ~= Character then
            Flag2 = false
        end
        if not Flag2 and Value:GetAttribute( "RankedPose" ) then
            Flag2 = true
        end

        List[ Value ] = Flag2
    end
end

local Table3 = {
    Aim = true,
    Reload = true,
    Low = true,
    Sprint = true,
    ReloadAim = true
}
local CFrame2 = CFrame.new( 0, 0.15, -0.15 ) * CFrame.Angles( 0.7853981633974483, 0, 0 )
local Low = Config.Poses.Low
local PistolGrip = Config.Poses.PistolGrip
Storage.PistolGrip2 = if PistolGrip then PistolGrip else CFrame.identity
local PistolAim2
local PistolAim = Config.Poses.PistolAim
PistolAim2 = if PistolAim then PistolAim else Config.Poses.Aim
local Inverse

if Config.Poses.PistolReload then
    local GunInHand = Config.Poses.PistolReload.GunInHand

    if GunInHand then
        Inverse = GunInHand
    else
        Inverse = PistolAim2.RightHand:Inverse( )
    end
else
    Inverse = PistolAim2.RightHand:Inverse( )
end

local Table9
local Table4 = {
    Waist = "UpperTorso",
    Neck = "Head",
    RightShoulder = "RightUpperArm",
    RightElbow = "RightLowerArm",
    RightWrist = "RightHand",
    LeftShoulder = "LeftUpperArm",
    LeftElbow = "LeftLowerArm",
    LeftWrist = "LeftHand"
}
local Class2 = setmetatable( { }, { __mode = "k" } )

local function IsJoint( Self )
    local IsA2
    local IsA = Self:IsA( "JointInstance" )
    IsA2 = if IsA then IsA else Self:IsA( "AnimationConstraint" )
    return IsA2
end

local function NewCache( Key )
    AnimWorkers.Sync( )
    local Table = { }
    Class2[ Key ] = Table

    local function Clear()
        table.clear( Table )
    end

    Key.ChildAdded:Connect( Clear )
    Key.ChildRemoved:Connect( Clear )
    Key.DescendantAdded:Connect( function( Self )
        local IsA2
        local IsA = Self:IsA( "JointInstance" )
        IsA2 = if IsA then IsA else Self:IsA( "AnimationConstraint" )

        if IsA2 then
            table.clear( Table )
        end
    end )
    Key.DescendantRemoving:Connect( function( Self )
        local IsA2
        local IsA = Self:IsA( "JointInstance" )
        IsA2 = if IsA then IsA else Self:IsA( "AnimationConstraint" )

        if IsA2 then
            table.clear( Table )
        end
    end )
    return Table
end

local function J( Key2, Name, Name2 )
    local Entry2
    local Entry = Class2[ Key2 ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = NewCache( Key2 )
    end

    local Entry4
    local Entry3 = Entry2[ Name ]
    Entry4 = if Entry3 then Entry3[ Name2 ] else Entry3

    if Entry4 then
        return Entry4
    end

    local FoundChild2
    local FoundChild = Key2:FindFirstChild( Name )

    if FoundChild then
        FoundChild2 = FoundChild:FindFirstChild( Name2 )
    else
        FoundChild2 = FoundChild
    end
    if FoundChild2 then
        local Entry5

        if Entry3 then
            Entry5 = Entry3
        else
            local Table = { }
            Entry2[ Name ] = Table
            Entry5 = Table
        end

        Entry5[ Name2 ] = FoundChild2
    end

    return FoundChild2
end

local Table5 = { }

local function P( Key2, Name )
    local Entry2
    local Entry = Class2[ Key2 ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = NewCache( Key2 )
    end

    local Entry4
    local Entry3 = Entry2[ Table5 ]

    if Entry3 then
        Entry4 = Entry3
    else
        local Table = { }
        Entry2[ Table5 ] = Table
        Entry4 = Table
    end

    local Entry5 = Entry4[ Name ]

    if Entry5 and Entry5.Parent == Key2 then
        return Entry5
    end

    local Humanoid

    if Name == "@Humanoid" then
        Humanoid = Key2:FindFirstChildOfClass( "Humanoid" )
    elseif Name == "@Tool" then
        Humanoid = Key2:FindFirstChildOfClass( "Tool" )
    else
        Humanoid = Key2:FindFirstChild( Name )
    end

    Entry4[ Name ] = Humanoid
    return Humanoid
end

local function HandleOf( Key2, Object )
    local Entry2
    local Entry = Class2[ Key2 ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = NewCache( Key2 )
    end

    local Entry4
    local Entry3 = Entry2[ Table5 ]

    if Entry3 then
        Entry4 = Entry3
    else
        local Table = { }
        Entry2[ Table5 ] = Table
        Entry4 = Table
    end

    local Handle = Entry4[ "@Handle" ]

    if Handle and Handle.Parent == Object then
        return Handle
    end
    if Handle and Entry4[ "@HandleTool" ] == Object and Handle.Parent then
        local Ready = Poignee.Ready

        if Ready( Handle, Object:GetAttribute( "Weapon" ) ) then
            return Handle
        end
    end

    local Handle2 = Poignee.Of( Object )
    Entry4[ "@Handle" ] = Handle2
    Entry4[ "@HandleTool" ] = Object
    return Handle2
end

local Value3 = nil
pcall( function()
    Value3 = require( Weapons:WaitForChild( "ReloadData", 5 ) )
end )
local Table6 = {
    RightShoulder = 3,
    RightElbow = 4,
    RightWrist = 5,
    LeftShoulder = 6,
    LeftElbow = 7,
    LeftWrist = 8
}

if Value3 then
    local Value4
    local Table7 = { }
    local Frames = Value3.frames
    Value4 = nil

    for Key, Value in Frames, nil, nil do
        local Value5
        local Table8 = { t = Value[ 1 ] }
        Value5 = nil

        for Key2, Value6 in Table6, nil, nil do
            local Total = 9 + ( Value6 - 1 ) * 4
            Table8[ Key2 ] = CFrame.new( 0, 0, 0, Value[ Total ], Value[ Total + 1 ], Value[ Total + 2 ], Value[ Total + 3 ] )
        end

        local CFrame3 = CFrame.new( 0, 0, 0, Value[ 5 ], Value[ 6 ], Value[ 7 ], Value[ 8 ] ) * CFrame.new( 0, 0, 0, Value[ 9 ], Value[ 10 ], Value[ 11 ], Value[ 12 ] )
        Table8.RightShoulder = CFrame3 * Table8.RightShoulder
        Table8.LeftShoulder = CFrame3 * Table8.LeftShoulder
        Table7[ Key ] = Table8
        Table9 = Table7
    end

    Table9 = Table7
else
    Table9 = nil
end

local function SampleReload( Argument1 )
    local Number
    local Count = #Table9
    Number = 1

    while Number < Count - 1 do
        if not ( Table9[ Number + 1 ].t <= Argument1 ) then
            break
        end

        Number = Number + 1
    end

    local Clamp2
    local Entry = Table9[ Number ]
    local Entry2 = Table9[ math.min( Number + 1, Count ) ]
    local T = Entry2.t

    if Entry.t < T then
        local Clamp = math.clamp( ( Argument1 - Entry.t ) / ( Entry2.t - Entry.t ), 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 0
        end
    else
        Clamp2 = 0
    end

    local Value1
    local Table = { }
    Value1 = nil

    for Value in Table6, nil, nil do
        local Entry3 = Entry[ Value ]
        Table[ Value ] = Entry3:Lerp( Entry2[ Value ], Clamp2 )
    end

    return Table
end

local Class3 = setmetatable( { }, { __mode = "k" } )
local Class4 = setmetatable( { }, { __mode = "k" } )

local function WatchTool( ToolName )
    if Class4[ ToolName ] then
        return
    end

    AnimWorkers.Sync( )
    Class4[ ToolName ] = true
    ToolName:GetAttributeChangedSignal( "Reloading" ):Connect( function()
        local Clock2

        if ToolName:GetAttribute( "Reloading" ) then
            local Clock = os.clock( )

            if Clock then
                Clock2 = Clock
            else
                Clock2 = nil
            end
        else
            Clock2 = nil
        end

        Class3[ ToolName ] = Clock2
    end )
    ToolName:GetAttributeChangedSignal( "ReloadPump" ):Connect( function()
        BoltAction.Start( ToolName )
    end )

    if ToolName:GetAttribute( "Reloading" ) then
        Class3[ ToolName ] = os.clock( )
    end
end

local Class5 = setmetatable( { }, { __mode = "k" } )
local CollectionService = game:GetService( "CollectionService" )
local Table10 = { }
local Flag3 = true

local function MarkCharsDirty()
    Flag3 = true
end

local function HookCharsOf( Argument1 )
    Argument1.CharacterAdded:Connect( MarkCharsDirty )
    Argument1.CharacterRemoving:Connect( MarkCharsDirty )
end

Players.PlayerAdded:Connect( function( Argument1 )
    Argument1.CharacterAdded:Connect( MarkCharsDirty )
    Argument1.CharacterRemoving:Connect( MarkCharsDirty )
    Flag3 = true
end )
Players.PlayerRemoving:Connect( MarkCharsDirty )

for Key3, Value7 in Players:GetPlayers( ) do
    Value7.CharacterAdded:Connect( MarkCharsDirty )
    Value7.CharacterRemoving:Connect( MarkCharsDirty )
end

local function HookBotChar( Argument1 )
    Argument1.AncestryChanged:Connect( MarkCharsDirty )
    Flag3 = true
end

CollectionService:GetInstanceAddedSignal( "GunBot" ):Connect( HookBotChar )
CollectionService:GetInstanceRemovedSignal( "GunBot" ):Connect( MarkCharsDirty )

for Key4, Value8 in CollectionService:GetTagged( "GunBot" ) do
    Value8.AncestryChanged:Connect( MarkCharsDirty )
    Flag3 = true
end

local Value9
local Table11 = { }
local Table12 = { }

local function AnimatedChars()
    if Flag3 and not AnimWorkers.InParallel then
        Flag3 = false
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

        local Value1
        Table11 = Table
        AnimWorkers.Assign( Table )
        local Table2 = { }
        local Table3 = { }
        Value1 = nil

        for Key3, Value3 in Table, nil, nil do
            Table2[ Value3 ] = Key3

            if AnimWorkers.Owns( Value3 ) then
                table.insert( Table3, Value3 )
            end
        end

        Table12 = Table2
        Table10 = Table3
    end

    return Table10
end

local function AllChars()
    AnimatedChars( )
    return Table11
end

local function GetStance( Object )
    local RankedPose = Object:GetAttribute( "RankedPose" )

    if RankedPose then
        if RankedPose == "Aim" then
            return "Aim", ( math.rad( tonumber( Object:GetAttribute( "RankedAimPitch" ) ) or 0 ) )
        end
        return "Low", 0
    elseif Object == Character then
        return ClientState.Stance, ClientState.CamPitch
    else
        return Config.StanceNames[ Object:GetAttribute( "GunStance" ) or 0 ] or "Low", ( math.rad( Object:GetAttribute( "GunPitch" ) or 0 ) )
    end
end

local function HandFit( Argument1, Argument2 )
    local _, _, ArmWorld3 = ArmIK.ArmWorld( Argument1, "Right", Argument2 )
    local _, _, ArmWorld32 = ArmIK.ArmWorld( Argument1, "Left", Argument2 )

    if not ArmWorld3 or not ArmWorld32 then
        return nil
    end

    local ArmWorld34
    local RightHand = Low.RightHand
    local LeftHand = Low.LeftHand
    local ArmWorld33 = ArmWorld3 * RightHand:Inverse( )
    local Unit = ArmWorld33:VectorToWorldSpace( LeftHand.Position - RightHand.Position ).Unit
    local Unit2 = ( ArmWorld32.Position - ArmWorld3.Position ).Unit
    local Cross = Unit:Cross( Unit2 )

    if Cross.Magnitude > 0.0001 then
        local Acos = math.acos( ( math.clamp( Unit:Dot( Unit2 ), -1, 1 ) ) )
        local Position = ArmWorld3.Position
        ArmWorld34 = CFrame.new( Position ) * CFrame.fromAxisAngle( Cross.Unit, Acos ) * CFrame.new( -Position ) * ArmWorld33
    else
        ArmWorld34 = ArmWorld33
    end

    return Argument2:ToObjectSpace( ArmWorld34 )
end

local Angles = CFrame.Angles( -0.4886921905584123, 0, 0 )
local Table13 = { "RightShoulder", "LeftShoulder" }

local function ReloadArms( Argument1, Argument2, Root )
    local Value2
    local SampleReload2 = SampleReload( Argument1 )
    Value2 = nil

    for Key, Value in Table13, nil, nil do
        SampleReload2[ Value ] = Angles * Argument2.Rotation:Inverse( ) * Root.CFrame.Rotation * SampleReload2[ Value ]
    end

    return SampleReload2
end

local function ReloadGrip( Key22, Root )
    local UpperTorsoWorld = ArmIK.UpperTorsoWorld( Key22 )

    if not UpperTorsoWorld then
        return nil
    end

    local Table = { }

    for Key, Value in ReloadArms( 0, UpperTorsoWorld, Root ) do
        local J2 = J( Key22, Table4[ Key ], Key )

        if J2 then
            Table[ J2 ] = AnimWorkers.getT( J2 )
            AnimWorkers.setT( J2, Value )
        end
    end

    local Value3
    local HandFit2 = HandFit( Key22, UpperTorsoWorld )
    local _, _, ArmWorld3 = ArmIK.ArmWorld( Key22, "Right", UpperTorsoWorld )
    Value3 = nil

    for Key2, Value4 in Table, nil, nil do
        AnimWorkers.setT( Key2, Value4 )
    end

    local ToObjectSpace

    if HandFit2 then
        if ArmWorld3 then
            ToObjectSpace = ArmWorld3:ToObjectSpace( UpperTorsoWorld * HandFit2 )
        else
            ToObjectSpace = ArmWorld3
        end
    else
        ToObjectSpace = HandFit2
    end

    return ToObjectSpace
end

local Reload = Config.Poses.Reload

local function GripAt( Argument1 )
    if not Reload.GripStart or not Reload.GripMid then
        return nil
    end

    local GripMidT2
    local GripMidT = Reload.GripMidT or 0.4
    GripMidT2 = Argument1 <= GripMidT and Argument1 / GripMidT or 1 - ( Argument1 - GripMidT ) / ( 1 - GripMidT )
    local GripMidT3 = GripMidT2 * GripMidT2 * ( 3 - 2 * GripMidT2 )
    local GripStart = Reload.GripStart
    return GripStart:Lerp( Reload.GripMid, GripMidT3 )
end

local RunCycle = Config.RunCycle
local Table14 = {
    Root = "LowerTorso",
    RightHip = "RightUpperLeg",
    RightKnee = "RightLowerLeg",
    RightAnkle = "RightFoot",
    LeftHip = "LeftUpperLeg",
    LeftKnee = "LeftLowerLeg",
    LeftAnkle = "LeftFoot"
}
Value9 = nil

for Key5, Value10 in Table4, nil, nil do
    Table14[ Key5 ] = Value10
end

local Number9, Number10

local function Spring( Argument1, Cf, Min, Amount, Argument5 )
    if not Argument1.cf then
        Argument1.cf = Cf
        Argument1.w = Vector3.new( 0, 0, 0 )
        Argument1.v = Vector3.new( 0, 0, 0 )
        return Cf
    end

    local ToAxisAngle3
    local Result = 6.283185307179586 * Amount
    local ToAxisAngle, ToAxisAngle2 = Argument1.cf:ToObjectSpace( Cf ):ToAxisAngle( )
    ToAxisAngle3 = ToAxisAngle2 == ToAxisAngle2 and ToAxisAngle * ToAxisAngle2 or Vector3.new( 0, 0, 0 )
    local FromAxisAngle2
    Argument1.w = Argument1.w + ( ToAxisAngle3 * Result * Result - Argument1.w * 2 * Argument5 * Result ) * Min
    Argument1.v = Argument1.v + ( ( Cf.Position - Argument1.cf.Position ) * Result * Result - Argument1.v * 2 * Argument5 * Result ) * Min
    local Magnitude = Argument1.w.Magnitude

    if Magnitude > 1e-06 then
        local FromAxisAngle = CFrame.fromAxisAngle( Argument1.w / Magnitude, Magnitude * Min )

        if FromAxisAngle then
            FromAxisAngle2 = FromAxisAngle
        else
            FromAxisAngle2 = CFrame.identity
        end
    else
        FromAxisAngle2 = CFrame.identity
    end

    Argument1.cf = CFrame.new( Argument1.cf.Position + Argument1.v * Min ) * Argument1.cf.Rotation * FromAxisAngle2
    return Argument1.cf
end

local function FootHeights( Self, Argument2 )
    local function Step( Argument1, Argument2Inner )
        local GetT
        local Frames, Frames2 = ArmIK.Frames( Argument2Inner )
        local Frames3 = Argument1 * Frames

        if not Argument2 or not CFrame.identity then
            GetT = AnimWorkers.getT( Argument2Inner )
        else
            GetT = CFrame.identity
        end

        return Frames3 * GetT * Frames2:Inverse( )
    end

    local LowerTorso = Self:FindFirstChild( "LowerTorso" )

    if not LowerTorso or not LowerTorso:FindFirstChild( "Root" ) then
        return nil
    end

    local GetT
    local Root = LowerTorso.Root
    local Frames, Frames2 = ArmIK.Frames( Root )
    local Identity = CFrame.identity * Frames

    if not Argument2 or not CFrame.identity then
        GetT = AnimWorkers.getT( Root )
    else
        GetT = CFrame.identity
    end

    local Value1
    local Identity2 = Identity * GetT * Frames2:Inverse( )
    local Table = { }
    local Table2 = { "Right", "Left" }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local FoundChild4
        local FoundChild = Self:FindFirstChild( Value .. "UpperLeg" )
        local FoundChild2 = Self:FindFirstChild( Value .. "LowerLeg" )
        local FoundChild3 = Self:FindFirstChild( Value .. "Foot" )

        if FoundChild then
            FoundChild4 = FoundChild:FindFirstChild( Value .. "Hip" )
        else
            FoundChild4 = FoundChild
        end

        local FoundChild5

        if FoundChild2 then
            FoundChild5 = FoundChild2:FindFirstChild( Value .. "Knee" )
        else
            FoundChild5 = FoundChild2
        end

        local FoundChild6

        if FoundChild3 then
            FoundChild6 = FoundChild3:FindFirstChild( Value .. "Ankle" )
        else
            FoundChild6 = FoundChild3
        end
        if not FoundChild4 or not FoundChild5 or not FoundChild6 then
            return nil
        end

        local GetT2
        local Frames3, Frames22 = ArmIK.Frames( FoundChild4 )
        local Identity3 = Identity2 * Frames3

        if not Argument2 or not CFrame.identity then
            GetT2 = AnimWorkers.getT( FoundChild4 )
        else
            GetT2 = CFrame.identity
        end

        local GetT3
        local Identity4 = Identity3 * GetT2 * Frames22:Inverse( )
        local Frames4, Frames23 = ArmIK.Frames( FoundChild5 )
        local Identity5 = Identity4 * Frames4

        if not Argument2 or not CFrame.identity then
            GetT3 = AnimWorkers.getT( FoundChild5 )
        else
            GetT3 = CFrame.identity
        end

        local GetT4
        local Identity6 = Identity5 * GetT3 * Frames23:Inverse( )
        local Frames5, Frames24 = ArmIK.Frames( FoundChild6 )
        local Identity7 = Identity6 * Frames5

        if not Argument2 or not CFrame.identity then
            GetT4 = AnimWorkers.getT( FoundChild6 )
        else
            GetT4 = CFrame.identity
        end

        table.insert( Table, ( Identity7 * GetT4 * Frames24:Inverse( ) * Vector3.new( 0, -FoundChild3.Size.Y / 2, 0 ) ).Y )
    end

    return math.log( math.exp( -Table[ 1 ] / 0.06 ) + math.exp( -Table[ 2 ] / 0.06 ) ) * -0.06
end

local Table15 = {
    "Waist",
    "RightShoulder",
    "RightElbow",
    "RightWrist",
    "LeftShoulder",
    "LeftElbow",
    "LeftWrist",
    "Gun",
    "RightHand",
    "LeftHand"
}
local Table16 = {
    Root = "Root",
    Waist = "Waist",
    Neck = "Neck",
    RightHip = "Legs",
    RightKnee = "Legs",
    RightAnkle = "Legs",
    LeftHip = "Legs",
    LeftKnee = "Legs",
    LeftAnkle = "Legs",
    RightShoulder = "Arms",
    RightElbow = "Arms",
    RightWrist = "Arms",
    LeftShoulder = "Arms",
    LeftElbow = "Arms",
    LeftWrist = "Arms"
}
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.IgnoreWater = true
local Class6 = setmetatable( { }, { __mode = "k" } )
local Number8 = 0
local Class7 = setmetatable( { }, { __mode = "k" } )

local function RayParamsOf( Key )
    local Entry2
    local Entry = Class7[ Key ]

    if Entry then
        Entry2 = Entry
    else
        AnimWorkers.Sync( )
        local RaycastParams2 = RaycastParams.new( )
        RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
        RaycastParams2.IgnoreWater = true
        RaycastParams2.FilterDescendantsInstances = { Key }
        Class7[ Key ] = RaycastParams2
        Entry2 = RaycastParams2
    end

    return Entry2
end

local function OnGround( Argument1, Humanoid )
    if not Humanoid then
        return false
    end
    if FrameCache.Floor( Humanoid ) ~= Enum.Material.Air then
        return true
    end

    local Parent = Argument1.Parent

    if Parent == Character then
        return false
    end

    local Entry = Class6[ Parent ]

    if Entry and Entry[ 1 ] == Number8 then
        return Entry[ 2 ]
    end

    local Flag
    local HipHeight = Humanoid.HipHeight + Argument1.Size.Y / 2 + 1.5
    local Raycast = workspace:Raycast( Argument1.Position, Vector3.new( 0, -HipHeight, 0 ), ( RayParamsOf( Parent ) ) )
    Flag = Raycast ~= nil and true or false

    if Entry then
        local Raycast2 = if Raycast then Raycast.Distance else Raycast
        Entry[ 1 ] = Number8
        Entry[ 2 ] = Flag
        Entry[ 3 ] = Raycast2
        return Flag
    end
    local Raycast3
    local Table = { }
    Raycast3 = if Raycast then Raycast.Distance else Raycast
    Table[ 1 ] = Number8
    Table[ 2 ] = Flag
    Table[ 3 ] = Raycast3
    Class6[ Parent ] = Table
    return Flag
end

game:GetService( "RunService" ).PreAnimation:Connect( function()
    Number8 = Number8 + 1
end )

local function RunSpeed( Part, Humanoid )
    if Part.Anchored then
        return 0
    end

    local Max
    local AssemblyLinearVelocity = Part.AssemblyLinearVelocity
    local X = AssemblyLinearVelocity.X
    local Magnitude = Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude

    if not Humanoid or not ( Humanoid.MoveDirection.Magnitude > 0.1 ) or not OnGround( Part, Humanoid ) then
        Max = Magnitude
    else
        local MoveAmount2

        if Humanoid.Parent == Character then
            local MoveAmount = Storage.Controls2.MoveAmount( )

            if MoveAmount then
                MoveAmount2 = MoveAmount
            else
                MoveAmount2 = Humanoid.MoveDirection.Magnitude
            end
        else
            MoveAmount2 = Humanoid.MoveDirection.Magnitude
        end

        Max = math.max( Magnitude, MoveAmount2 * Humanoid.WalkSpeed )
    end

    return Max
end

local Class8 = setmetatable( { }, { __mode = "k" } )

local function IsClimbing( Key, Humanoid, State )
    if not Humanoid then
        return false
    end
    if ( State or Humanoid:GetState( ) ) == Enum.HumanoidStateType.Climbing then
        return true
    end
    if Key == Character then
        return false
    end

    local Entry = Class8[ Key ]

    if Entry and Number8 - Entry[ 1 ] < 3 then
        return Entry[ 2 ]
    end
    if AnimWorkers.InParallel then
        local Item = Entry ~= nil and Entry[ 2 ] or false
        return Item
    end
    local Flag
    local Animator = Humanoid:FindFirstChildOfClass( "Animator" )

    if Animator then
        for Key2, Value in Animator:GetPlayingAnimationTracks( ) do
            if Value.WeightTarget > 0.5 then
                if Value.Animation.Name ~= "ClimbAnim" then
                    if not string.find( Value.Animation.AnimationId, "507765644", 1, true ) then
                        continue
                    end
                end

                Flag = true
                break
            end

            Flag = false
        end
    else
        Flag = false
    end
    if Entry then
        Entry[ 1 ] = Number8
        Entry[ 2 ] = Flag
        return Flag
    end
    Class8[ Key ] = { Number8, Flag }
    return Flag
end

local Class9 = setmetatable( { }, { __mode = "k" } )
local Table17 = { }

local function LocoOnG( Argument1, Humanoid )
    local OnG3
    local OnG = Table17.onG

    if OnG == nil then
        local OnG2 = OnGround( Argument1, Humanoid )
        Table17.onG = OnG2
        OnG3 = OnG2
    else
        OnG3 = OnG
    end

    return OnG3
end

local function LocoClimb( Key, Humanoid )
    local Climb3
    local Climb = Table17.climb

    if Climb == nil then
        local Climb2 = IsClimbing( Key, Humanoid )
        Table17.climb = Climb2
        Climb3 = Climb2
    else
        Climb3 = Climb
    end

    return Climb3
end

local function LocoSwim( Argument1 )
    local Swim3
    local Swim = Table17.swim

    if Swim == nil then
        local Swim2 = SwimTilt.EnNage( Argument1 )
        Table17.swim = Swim2
        Swim3 = Swim2
    else
        Swim3 = Swim
    end

    return Swim3
end

local function LocoCrouch( Argument1 )
    local Crouch3
    local Crouch = Table17.crouch

    if Crouch == nil then
        local Crouch2 = CrouchAnim.IsCrouched( Argument1 )
        Table17.crouch = Crouch2
        Crouch3 = Crouch2
    else
        Crouch3 = Crouch
    end

    return Crouch3
end

local function LocoSeated( Argument1 )
    local Seated3
    local Seated = Table17.seated

    if Seated == nil then
        local Seated2
        local Sit = Argument1.Sit

        if Sit then
            Seated2 = Sit
        elseif Argument1.SeatPart == nil then
            Seated2 = false
        else
            Seated2 = true
        end

        Table17.seated = Seated2
        Seated3 = Seated2
    else
        Seated3 = Seated
    end

    return Seated3
end

local function UpdateBare( BareName, Part, Amount, Argument4 )
    local Entry2
    local Entry = Class9[ BareName ]
    Entry2 = if Entry then Entry else { runW = 0, phase = 0 }
    local Entry4
    Class9[ BareName ] = Entry2
    local Entry3 = Class2[ BareName ]

    if Entry3 then
        Entry4 = Entry3
    else
        Entry4 = NewCache( BareName )
    end

    local Entry6
    local Entry5 = Entry4[ Table5 ]

    if Entry5 then
        Entry6 = Entry5
    else
        local Table = { }
        Entry4[ Table5 ] = Table
        Entry6 = Table
    end

    local Humanoid3
    local Humanoid = Entry6[ "@Humanoid" ]

    if not Humanoid or Humanoid.Parent ~= BareName then
        local Humanoid2 = BareName:FindFirstChildOfClass( "Humanoid" )
        Entry6[ "@Humanoid" ] = Humanoid2
        Humanoid3 = Humanoid2
    else
        Humanoid3 = Humanoid
    end

    local OnG3
    local Speed = RunSpeed( Part, Humanoid3 )
    Table17.speed = Speed

    if Humanoid3 == nil then
        OnG3 = false
    elseif Humanoid3.Health > 0 then
        local Seated3
        local Seated = Table17.seated

        if Seated == nil then
            local Seated2
            local Sit = Humanoid3.Sit

            if Sit then
                Seated2 = Sit
            elseif Humanoid3.SeatPart == nil then
                Seated2 = false
            else
                Seated2 = true
            end

            Table17.seated = Seated2
            Seated3 = Seated2
        else
            Seated3 = Seated
        end

        local NotSeated = not Seated3

        if NotSeated then
            local OnG = Table17.onG

            if OnG == nil then
                local OnG2 = OnGround( Part, Humanoid3 )
                Table17.onG = OnG2
                OnG3 = OnG2
            else
                OnG3 = OnG
            end
            if OnG3 then
                if RunCycle.MinSpeed < Speed then
                    local Climb3
                    local Climb = Table17.climb

                    if Climb == nil then
                        local Climb2 = IsClimbing( BareName, Humanoid3 )
                        Table17.climb = Climb2
                        Climb3 = Climb2
                    else
                        Climb3 = Climb
                    end

                    local NotClimb = not Climb3

                    if NotClimb then
                        local Swim3
                        local Swim = Table17.swim

                        if Swim == nil then
                            local Swim2 = SwimTilt.EnNage( BareName )
                            Table17.swim = Swim2
                            Swim3 = Swim2
                        else
                            Swim3 = Swim
                        end

                        local NotSwim = not Swim3

                        if NotSwim then
                            local Crouch3
                            local Crouch = Table17.crouch

                            if Crouch == nil then
                                local Crouch2 = CrouchAnim.IsCrouched( BareName )
                                Table17.crouch = Crouch2
                                Crouch3 = Crouch2
                            else
                                Crouch3 = Crouch
                            end

                            local NotCrouch = not Crouch3

                            if NotCrouch then
                                local BatteAim2
                                local BatteAim = BareName:GetAttribute( "BatteAim" )

                                if BatteAim then
                                    BatteAim2 = BatteAim
                                elseif BareName == Character then
                                    BatteAim2 = ClientState.MeleeAim
                                else
                                    BatteAim2 = false
                                end

                                OnG3 = not BatteAim2
                            else
                                OnG3 = NotCrouch
                            end
                        else
                            OnG3 = NotSwim
                        end
                    else
                        OnG3 = NotClimb
                    end
                else
                    OnG3 = false
                end
            end
        else
            OnG3 = NotSeated
        end
    else
        OnG3 = false
    end

    local Number
    local RunW = Entry2.runW
    Number = not OnG3 and 0 or 1
    Entry2.runW = RunW + ( Number - Entry2.runW ) * ( 1 - math.exp( -10 * Amount ) )
    Entry2.phaseRate = Speed / RunCycle.CycleLength
    Entry2.phase = ( Entry2.phase + Entry2.phaseRate * ( Argument4 or Amount ) ) % 1

    if Entry2.phase ~= Entry2.phase then
        Entry2.phase = 0
    end
end

local function ApplyBare( BareName )
    local Entry = Class9[ BareName ]

    if not Entry or Entry.runW < 0.001 then
        return
    end

    local SampleFastRun = RunGait.SampleFastRun

    for Key, Value in SampleFastRun( Entry.phase, true ) do
        local J2 = J( BareName, Table14[ Key ] or "", Key )

        if J2 then
            local Lerp
            local SetT = AnimWorkers.setT

            if not ( Entry.runW >= 0.999 ) or not Value then
                local GetT = AnimWorkers.getT( J2 )
                Lerp = GetT:Lerp( Value, Entry.runW )
            else
                Lerp = Value
            end

            SetT( J2, Lerp )
        end
    end
end

local Draw = Config.Poses.Draw
local Gun = Draw[ 1 ].Gun

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function PathPos( List, Argument2 )
    local Entry5
    local Count = #List
    local Clamp = math.clamp( Argument2, 0, 1 ) * ( Count - 1 )
    local Floor = math.floor( Clamp )
    local Clamp2 = math.clamp( Floor, 0, Count - 2 )
    local Clamp3 = Clamp - Clamp2
    local Entry = List[ Clamp2 + 1 ]
    local Entry2 = List[ Clamp2 + 2 ]
    local Entry3 = List[ Clamp2 ]
    Entry5 = if Entry3 then Entry3 else Entry + ( Entry - Entry2 )
    local Entry6
    local Entry4 = List[ Clamp2 + 3 ]
    Entry6 = if Entry4 then Entry4 else Entry2 + ( Entry2 - Entry )
    local Clamp4 = Clamp3 * Clamp3
    local Clamp5 = Clamp3 * Clamp3 * Clamp3
    return 0.5 * ( 2 * Entry + ( -Entry5 + Entry2 ) * Clamp3 + ( 2 * Entry5 - 5 * Entry + 4 * Entry2 - Entry6 ) * Clamp4 + ( -Entry5 + 3 * Entry - 3 * Entry2 + Entry6 ) * Clamp5 )
end

local function DrawAtK( Argument1, Argument2 )
    local Value1
    local Clone = table.clone( Draw )
    table.insert( Clone, {
        Gun = Argument2,
        Hand = Config.Poses.Low.RightHand,
        Pole = Draw[ #Draw ].Pole
    } )
    local Table = { }
    Value1 = nil

    for Key, Value in Clone, nil, nil do
        Table[ Key ] = Value.Gun.Position
    end

    local Count = Argument1 * ( #Clone - 1 )
    local Floor = math.floor( Count )
    local Clamp = math.clamp( Floor, 0, #Clone - 2 )
    local Count2 = Count - Clamp
    local Entry = Clone[ Clamp + 1 ]
    local Entry2 = Clone[ Clamp + 2 ]
    local CFrame2 = CFrame.new( ( PathPos( Table, Argument1 ) ) )
    local Rotation = Entry.Gun.Rotation
    local CFrame3 = CFrame2 * Rotation:Lerp( Entry2.Gun.Rotation, Count2 )
    local Hand = Entry.Hand
    local Lerp = Hand:Lerp( Entry2.Hand, Count2 )
    local Pole = Entry.Pole
    return CFrame3, Lerp, Pole:Lerp( Entry2.Pole, Count2 )
end

local function DrawAt( Amount, Argument2 )
    local Clamp = math.clamp( ( Amount - 0 ) / 0.85, 0, 1 )
    return DrawAtK( Clamp * Clamp * ( 3 - 2 * Clamp ), Argument2 )
end

local Table18 = { LeftShoulder = true, LeftElbow = true, LeftWrist = true }

local function LeftToGun( Key22, Argument2, Argument3, Amount )
    if Amount <= 0.001 then
        return
    end

    local Value1
    local Table = { }
    local Table2 = {
        { "LeftUpperArm", "LeftShoulder" },
        { "LeftLowerArm", "LeftElbow" },
        { "LeftHand", "LeftWrist" }
    }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local J2 = J( Key22, Value[ 1 ], Value[ 2 ] )

        if J2 then
            Table[ J2 ] = AnimWorkers.getT( J2 )
        end
    end

    local CurrentPole = ArmIK.CurrentPole
    local CurrentPole2 = CurrentPole( Key22, "Left", Argument2, Argument3.Position )

    if not CurrentPole2 then
        return
    end

    ArmIK.Solve( Key22, "Left", Argument2, Argument3, CurrentPole2 )

    if Amount < 0.999 then
        local Value2 = nil

        for Key2, Value3 in Table, nil, nil do
            local SetT = AnimWorkers.setT
            SetT( Key2, Value3:Lerp( AnimWorkers.getT( Key2 ), Amount ) )
        end
    end
end

local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local VisualRegistry = require( Weapons:WaitForChild( "VisualRegistry" ) )
local ModCatalog = require( Weapons:WaitForChild( "ModCatalog" ) )
local FX = workspace:WaitForChild( "FX" )
local CFrame4 = CFrame.new( 0, -5000, 0 )

local function HandAura( Clone )
    local SkinAura = Clone:FindFirstChild( "SkinAura", true )

    if not SkinAura then
        return
    end
    for Key, Value in SkinAura:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            local HandScale = Value:GetAttribute( "HandScale" )
            local HandRate = Value:GetAttribute( "HandRate" )
            local ZOffset = Value:GetAttribute( "HandZOffset" )

            if type( HandScale ) == "number" then
                local Value1
                local Table = { }
                local Keypoints = Value.Size.Keypoints
                Value1 = nil

                for Key2, Value2 in Keypoints, nil, nil do
                    table.insert( Table, NumberSequenceKeypoint.new( Value2.Time, Value2.Value * HandScale, Value2.Envelope * HandScale ) )
                end

                Value.Size = NumberSequence.new( Table )
            end
            if type( HandRate ) == "number" then
                Value.Rate = Value.Rate * HandRate
            end
            if type( ZOffset ) == "number" then
                Value.ZOffset = ZOffset
            end
        end
    end
end

local Flag4 = true
local Class10 = setmetatable( { }, { __mode = "k" } )

local function AttachVisual( Argument1, Part0, C0 )
    if Argument1.attached and Argument1.attachPart == Part0 and Argument1.attachC0 == C0 then
        return
    end

    local Attach3
    local Part1 = Argument1.movers[ 1 ]
    local Attach = Argument1.attach

    if Attach then
        Attach3 = Attach
    else
        local Attach2 = Instance.new( "Weld" )
        Attach2.Name = "GA_Attach"
        Attach2.Part1 = Part1
        Attach2.Parent = Part1
        Argument1.attach = Attach2
        Attach3 = Attach2
    end
    if Part1.Anchored then
        Part1.Anchored = false
    end

    Attach3.C0 = C0
    Attach3.Part0 = Part0
    Argument1.attached = true
    Argument1.attachPart = Part0
    Argument1.attachC0 = C0
end

local function DetachVisual( Argument1 )
    local Item = Argument1.movers[ 1 ]

    if Argument1.attach then
        Argument1.attach.Part0 = nil
    end

    Item.Anchored = true
    Item.CFrame = CFrame4
    Argument1.attached = false
    Argument1.attachPart = nil
    Argument1.attachC0 = nil
end

local LeftHand = Config.Poses.Aim.LeftHand
local Table19 = { }

local function LeftShift( Name )
    local Text = Name or ""
    local Entry = Table19[ Text ]

    if Entry then
        return Entry
    end

    local FoundChild

    if Name then
        FoundChild = WeaponVisuals:FindFirstChild( Name )
    else
        FoundChild = Name
    end

    local LeftGrip

    if FoundChild then
        local PrimaryPart = FoundChild.PrimaryPart

        if PrimaryPart then
            LeftGrip = FoundChild.PrimaryPart:FindFirstChild( "LeftGrip" )
        else
            LeftGrip = PrimaryPart
        end
    else
        LeftGrip = FoundChild
    end

    local CFrame3

    if LeftGrip then
        local CFrame2 = LeftGrip.CFrame * LeftHand:Inverse( )

        if CFrame2 then
            CFrame3 = CFrame2
        else
            CFrame3 = CFrame.identity
        end
    else
        CFrame3 = CFrame.identity
    end

    Table19[ Text ] = CFrame3
    return CFrame3
end

local Table20 = { }

local function BarrelDir( Name )
    local Text = Name or ""

    if Table20[ Text ] then
        return Table20[ Text ]
    end

    local FoundChild

    if Name then
        FoundChild = WeaponVisuals:FindFirstChild( Name )
    else
        FoundChild = Name
    end

    local Position

    if not FoundChild or not FoundChild.PrimaryPart then
        Position = Vector3.new( 0, 0, -1 )
    else
        local Number
        local CFrame = FoundChild.PrimaryPart.CFrame
        Number = 0
        Position = Vector3.new( 0, 0, -1 )

        for Key, Value in FoundChild:GetDescendants( ) do
            if Value:IsA( "BasePart" ) and Value.Name:lower( ):find( "barrel" ) then
                local X2
                local Size = Value.Size
                local RightVector = Value.CFrame.RightVector
                local X = Size.X

                if X < Size.Y then
                    X2 = Size.Y
                    RightVector = Value.CFrame.UpVector
                else
                    X2 = X
                end
                if X2 < Size.Z then
                    X2 = Size.Z
                    RightVector = Value.CFrame.LookVector
                end
                if Number < X2 then
                    local VectorToObjectSpace = CFrame:VectorToObjectSpace( RightVector )

                    if VectorToObjectSpace.Z > 0 then
                        Number = X2
                        Position = -VectorToObjectSpace
                    else
                        Number = X2
                        Position = VectorToObjectSpace
                    end
                end
            end
        end
    end

    Table20[ Text ] = Position.Unit
    return Table20[ Text ]
end

local RaycastParams3 = RaycastParams.new( )
RaycastParams3.IgnoreWater = true
RaycastParams3.FilterType = Enum.RaycastFilterType.Exclude

local function AimConverge( Object, Argument2, Argument3, Argument4 )
    local Muzzle
    local Handle = Argument4.handle

    if Handle then
        Muzzle = Argument4.handle:FindFirstChild( "Muzzle" )
    else
        Muzzle = Handle
    end
    if not Muzzle then
        return Argument3
    end

    local Max2
    local Result = Argument2 * Argument3
    local ViewportSize = CurrentCamera.ViewportSize
    local ViewportPointToRay = CurrentCamera:ViewportPointToRay( ViewportSize.X / 2, ViewportSize.Y / 2 )
    RaycastParams3.FilterDescendantsInstances = { Object, FX }
    local Head = Object:FindFirstChild( "Head" )
    local Unit = ViewportPointToRay.Direction.Unit

    if Head then
        local Max = math.max( 0, ( Head.Position - ViewportPointToRay.Origin ):Dot( Unit ) )

        if Max then
            Max2 = Max
        else
            Max2 = 0
        end
    else
        Max2 = 0
    end

    local Distance
    local Raycast = workspace:Raycast( ViewportPointToRay.Origin + Unit * Max2, Unit * 1000, RaycastParams3 )
    local Origin = ViewportPointToRay.Origin
    Distance = Raycast and Raycast.Distance or 1000
    local Origin2 = Origin + Unit * ( Max2 + math.max( Distance, 15 ) )
    local Result2 = Result * Muzzle.Position
    local VectorToWorldSpace = Result:VectorToWorldSpace( ( BarrelDir( Argument4.weapon ) ) )
    local Unit2 = ( Origin2 - Result2 ).Unit
    local Cross = VectorToWorldSpace:Cross( Unit2 )
    local Acos = math.acos( ( math.clamp( VectorToWorldSpace:Dot( Unit2 ), -1, 1 ) ) )

    if Cross.Magnitude < 1e-06 or Acos < 0.0001 then
        return Argument3
    end
    local FromAxisAngle = CFrame.fromAxisAngle( Cross.Unit, ( math.min( Acos, 0.3490658503988659 ) ) )
    local Position = Result.Position
    return Argument2:ToObjectSpace( CFrame.new( Position ) * FromAxisAngle * CFrame.new( -Position ) * Result )
end

local Table21 = {
    Mag = true,
    Slide = true,
    Bolt = true,
    Pump = true,
    forend = true,
    bolt_carrier = true,
    RocketPart = true
}
local Table22 = { }

local function PruneSmall( Model, Name )
    local Entry2
    local Entry = Table22[ Name ]

    if Entry then
        Entry2 = Entry
    else
        local ExtentsSize
        local FoundChild = WeaponVisuals:FindFirstChild( Name )
        ExtentsSize = FoundChild and FoundChild:GetExtentsSize( ) or Vector3.new( 1, 1, 1 )
        local X = ExtentsSize.X
        local Y = ExtentsSize.Y
        local Max = math.max( X, Y, ExtentsSize.Z )
        Table22[ Name ] = Max
        Entry2 = Max
    end

    local Entry3 = Entry2 * 0.12

    for Key, Value in Model:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Parent and Value ~= Model.PrimaryPart and not Table21[ Value.Name ] and Value:GetAttribute( "ModFamily" ) == nil then
            local X2 = Value.Size.X
            local Y2 = Value.Size.Y

            if math.max( X2, Y2, Value.Size.Z ) < Entry3 then
                local Find3
                local Lower = Value.Name:lower( )
                local Find = Lower:find( "sight" )

                if Find then
                    Find3 = Find
                else
                    local Find2 = Lower:find( "dot" )

                    if Find2 then
                        Find3 = Find2
                    else
                        Find3 = Lower:find( "muzzle" )
                    end
                end
                if not Find3 then
                    for Key3, Value3 in Value:GetChildren( ) do
                        if not Value3:IsA( "Attachment" ) and not Value3:IsA( "ParticleEmitter" ) and not Value3:IsA( "Light" ) and not Value3:IsA( "Beam" ) and not Value3:IsA( "Trail" ) then
                            if not Value3:IsA( "Sound" ) then
                                continue
                            end
                        end

                        Find3 = true
                        break
                    end
                end
                if not Find3 then
                    Value:Destroy( )
                end
            end
        end
    end
    for Key2, Value2 in Model:GetDescendants( ) do
        if Value2:IsA( "Model" ) and Value2.Parent and not Value2:FindFirstChildWhichIsA( "BasePart", true ) then
            Value2:Destroy( )
        end
    end
end

local Class11 = setmetatable( { }, { __mode = "k" } )

local function GetVisual( Key, Name, Name2 )
    local Entry = Class10[ Key ]

    if Entry and Entry.name == Name then
        if Name2 == false or Entry.mods == Name2 then
            return Entry
        end
    end
    if Entry then
        if Entry.welded then
            local Item = Entry.movers[ 1 ]

            if Entry.attach then
                Entry.attach.Part0 = nil
            end

            Item.Anchored = true
            Item.CFrame = CFrame4
            Entry.attached = false
            Entry.attachPart = nil
            Entry.attachC0 = nil
        else
            workspace:BulkMoveTo( Entry.movers, table.create( #Entry.movers, CFrame4 ), Enum.BulkMoveMode.FireCFrameChanged )
        end

        Entry.shown = false
    end

    local Flag
    Class10[ Key ] = nil
    VisualRegistry[ Key ] = nil
    Flag = Name2 == false and true or false
    local Entry3
    local Text = Name2 or ""
    local Entry2 = Class11[ Key ]

    if Entry2 then
        Entry3 = Entry2
    else
        local Table = { }
        Class11[ Key ] = Table
        Entry3 = Table
    end

    local Key3
    local Text2 = tostring( Name ) .. "|" .. Text
    local Entry4 = Entry3[ Text2 ]

    if Flag then
        local Value1 = nil
        Key3 = Text2

        for Key2, Value in Entry3, nil, nil do
            if Value.name == Name then
                if not Entry4 or Entry4.used < Value.used then
                    Entry4 = Value
                    Key3 = Key2
                end
            end
        end
    else
        Key3 = Text2
    end
    if Entry4 and Entry4.model.Parent then
        Entry4.used = os.clock( )
        Class10[ Key ] = Entry4
        VisualRegistry[ Key ] = Entry4.model
        return Entry4
    end

    local FoundChild
    Entry3[ Key3 ] = nil
    local Decode = ModCatalog.Decode( Text )

    if Name then
        local SkinVisual = ModCatalog.SkinVisual( Name, Decode )

        if SkinVisual then
            FoundChild = SkinVisual
        else
            FoundChild = WeaponVisuals:FindFirstChild( Name )
        end
    else
        FoundChild = Name
    end
    if not FoundChild or not FoundChild.PrimaryPart then
        return nil
    end

    local Clone = FoundChild:Clone( )
    Clone.Name = Name

    if AnimWorkers.IsWorker then
        Clone:SetAttribute( "GA_Worker", AnimWorkers.Index )
    end

    ModCatalog.Apply( Clone, Name, Decode )
    HandAura( Clone )

    if Key ~= LocalPlayer.Character then
        PruneSmall( Clone, Name )
    end

    local Part0 = Clone.PrimaryPart
    local Table2 = { }
    local Table3 = { }
    local Table4 = { }
    local Table5 = { }
    local Table6 = { }
    local Table7 = { }

    for Key4, Value2 in Clone:GetDescendants( ) do
        if Value2:IsA( "BasePart" ) and Value2 ~= Part0 then
            table.insert( Table2, Value2 )
            table.insert( Table3, Part0.CFrame:ToObjectSpace( Value2.CFrame ) )
            local IsMovingPart = BoltAction.IsMovingPart

            if IsMovingPart( Name, Value2.Name ) then
                Table4[ #Table2 ] = true
            end
            if Value2.Name == "RocketPart" then
                Table7[ #Table2 ] = true
            end

            local ModFamily = Value2:GetAttribute( "ModFamily" )

            if Value2.Name == "Mag" or ModFamily == "Mag" then
                Table5[ #Table2 ] = true
            end

            local Lower = Value2.Name:lower( )

            if ModFamily then
                if ModFamily == "Optic" or ModFamily == "TagSlide" then
                    Table6[ #Table2 ] = true
                end
            elseif Value2.Name == "Slide" or Lower:find( "sight" ) or Lower:find( "dot" ) then
                Table6[ #Table2 ] = true
            end
        end
    end

    local Value3, Number, Position
    Value3 = nil
    Number = 0
    Position = Vector3.new( 0, 0, 0 )

    for Value4 in Table5, nil, nil do
        Number = Number + 1
        Position = Position + Table3[ Value4 ].Position
    end

    local Flag2

    if ModCatalog.Decode( Text ).Mag == nil then
        Flag2 = false
    elseif Number > 0 then
        Flag2 = not Holds.IsRocket( Name )
    else
        Flag2 = false
    end

    local Value5
    Clone.Parent = FX
    local Movers = { Part0 }
    local MoverIdx = { 0 }
    Part0.Anchored = true
    Value5 = nil

    for Key5, Value6 in Table2, nil, nil do
        if Table4[ Key5 ] or Table5[ Key5 ] or Table6[ Key5 ] or Table7[ Key5 ] then
            table.insert( Movers, Value6 )
            table.insert( MoverIdx, Key5 )
        else
            Value6.Anchored = false
            local WeldConstraint = Instance.new( "WeldConstraint" )
            WeldConstraint.Part0 = Part0
            WeldConstraint.Part1 = Value6
            WeldConstraint.Parent = Value6
        end
    end

    local Welded

    if Flag4 then
        if Key == LocalPlayer.Character then
            Welded = false
        else
            Welded = true
        end
    else
        Welded = Flag4
    end

    local MoverWelds, MoverC0

    if Welded then
        local Value7
        local Table8 = { }
        local Table9 = { }
        Part0.Massless = true
        Value7 = nil

        for Key6, Value8 in Table2, nil, nil do
            Value8.Massless = true
        end

        local Count = #Movers
        local I = 2
        MoverWelds = Table8
        MoverC0 = Table9

        for I = 2, Count do
            local Part1 = Movers[ I ]
            local Weld = Instance.new( "Weld" )
            local C0 = Table3[ MoverIdx[ I ] ]
            Weld.Part0 = Part0
            Weld.Part1 = Part1
            Weld.C0 = C0
            Weld.Parent = Part1
            Part1.Anchored = false
            local Entry5 = Table3[ MoverIdx[ I ] ]
            Table8[ I ] = Weld
            Table9[ I ] = Entry5
            MoverWelds = Table8
            MoverC0 = Table9
        end
    else
        MoverWelds = nil
        MoverC0 = nil
    end

    local MagCenter
    local Table10 = {
        name = Name,
        mods = Text,
        model = Clone,
        parts = Table2,
        rel = Table3,
        bolt = Table4,
        mag = Table5,
        slide = Table6,
        rocket = Table7,
        shown = true,
        drum = Flag2
    }
    MagCenter = Number > 0 and Position / Number or nil
    local Value9, Number2, Value11, Number3
    Table10.magCenter = MagCenter
    Table10.movers = Movers
    Table10.moverIdx = MoverIdx
    Table10.welded = Welded
    Table10.moverWelds = MoverWelds
    Table10.moverC0 = MoverC0
    local Used = os.clock( )
    Table10.key = Key3
    Table10.used = Used
    Entry3[ Key3 ] = Table10
    Value9 = nil
    Number2 = 0
    Value11 = nil
    Number3 = math.huge

    for Key7, Value10 in Entry3, nil, nil do
        Number2 = Number2 + 1

        if Value10 ~= Table10 and Value10.used < Number3 then
            Value11 = Key7
            Number3 = Value10.used
        end
    end
    if Number2 > 4 and Value11 then
        Entry3[ Value11 ].model:Destroy( )
        Entry3[ Value11 ] = nil
    end

    Class10[ Key ] = Table10
    VisualRegistry[ Key ] = Clone
    return Table10
end

local function MoverCF( Argument1, Key, Argument3, Argument4, Argument5, Argument6 )
    local Result2
    local Entry = Argument1.rel[ Key ]

    if not Argument4 or not Argument1.bolt[ Key ] then
        Result2 = Argument3 * Entry
    else
        local Result = Argument3 * Argument4 * Entry

        if Result then
            Result2 = Result
        else
            Result2 = Argument3 * Entry
        end
    end
    if not Argument1.rocket[ Key ] or not Argument5 or not Argument5.rocket then
        if Argument5 and Argument5.drum and Argument1.mag[ Key ] then
            local Captured = Argument5.drum.hidden and CFrame4 or Argument5.drum.M * Argument5.drum.MgInv * Result2
            return Captured
        end
        if Argument5 then
            if Argument1.mag[ Key ] then
                if Argument5.hidden then
                    return CFrame4
                end
                if not Argument5.inHand or not Argument6 then
                    return Argument3 * Entry * CFrame.new( 0, -( Argument5.d or 0 ), 0 )
                end
                return Argument6.CFrame * Argument5.handToMag
            elseif Argument1.slide[ Key ] and Argument5.slide ~= 0 then
                Result2 = Argument3 * CFrame.new( 0, 0, Argument5.slide ) * Entry
            end
        end
    else
        if Argument5.rocket == "hidden" then
            return CFrame4
        end
        if Argument5.rocket == "hand" and Argument6 then
            return Argument6.CFrame * Argument5.handToRocket
        end
    end

    return Result2
end

local function PlaceVisual( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Cfs3
    local Movers = Argument1.movers
    local MoverIdx = Argument1.moverIdx
    local Cfs = Argument1.cfs

    if not Cfs or #Cfs ~= #Movers then
        local Cfs2 = table.create( #Movers )
        Argument1.cfs = Cfs2
        Cfs3 = Cfs2
    else
        Cfs3 = Cfs
    end

    local BoltTransform2
    Cfs3[ 1 ] = Argument2

    if Argument3 then
        local BoltTransform = BoltAction.BoltTransform
        BoltTransform2 = BoltTransform( Argument1.name, Argument3 )
    else
        BoltTransform2 = Argument3
    end

    local Count = #Movers
    local I = 2

    for I = 2, Count do
        Cfs3[ I ] = MoverCF( Argument1, MoverIdx[ I ], Argument2, BoltTransform2, Argument4, Argument5 )
    end

    workspace:BulkMoveTo( Movers, Cfs3, Enum.BulkMoveMode.FireCFrameChanged )
end

local function PlaceMovers( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local BoltTransform2
    local Movers = Argument1.movers
    local MoverIdx = Argument1.moverIdx
    local MoverWelds = Argument1.moverWelds
    local MoverC0 = Argument1.moverC0

    if Argument3 then
        local BoltTransform = BoltAction.BoltTransform
        BoltTransform2 = BoltTransform( Argument1.name, Argument3 )
    else
        BoltTransform2 = Argument3
    end

    local Inverse
    local Count = #Movers
    local I = 2
    Inverse = nil

    for I = 2, Count do
        local Entry = MoverIdx[ I ]
        local C0 = Argument1.rel[ Entry ]

        if BoltTransform2 or Argument4 then
            local Inverse2

            if Inverse then
                Inverse2 = Inverse
            else
                Inverse2 = Argument2:Inverse( )
            end

            C0 = Inverse2 * MoverCF( Argument1, Entry, Argument2, BoltTransform2, Argument4, Argument5 )
            Inverse = Inverse2
        end
        if MoverC0[ I ] ~= C0 then
            MoverC0[ I ] = C0
            MoverWelds[ I ].C0 = C0
        end
    end
end

local Class12 = setmetatable( { }, { __mode = "k" } )
local Class13 = setmetatable( { }, { __mode = "k" } )
local I = 1
Number9 = 0
Number10 = 1

for I = 1, 30 do
    local Number11 = ( Number9 + Number10 ) / 2

    if Number11 * Number11 * ( 3 - Number11 * 2 ) < 0.15000000000000002 then
        Number9 = Number11
    else
        Number10 = Number11
    end
end

local Number12 = Number9 * 0.85 + 0
local Table23 = { RightShoulder = true, RightElbow = true, RightWrist = true }

local function StopHolster( HolsterName )
    Class12[ HolsterName ] = nil
end

local Table24 = {
    RightShoulder = true,
    RightElbow = true,
    RightWrist = true,
    LeftShoulder = true,
    LeftElbow = true,
    LeftWrist = true
}

local function StartHolster( HolsterName, Entry )
    local UpperTorso = HolsterName:FindFirstChild( "UpperTorso" )
    local Humanoid = HolsterName:FindFirstChildOfClass( "Humanoid" )

    if not UpperTorso or not Entry.lastC0 or not Entry.weapon or not Humanoid or Humanoid.Health <= 0 then
        return
    end

    local LastPose2
    Class13[ HolsterName ] = 0
    local FromPose = { }
    local LastPose = Entry.lastPose
    LastPose2 = if LastPose then LastPose else { }
    local Value1 = nil

    for Key, Value in LastPose2, nil, nil do
        if Table24[ Key.Name ] then
            FromPose[ Key ] = Value
        end
    end

    local HoldC0
    local Table = {
        gone = true,
        c0 = Entry.lastC0,
        weapon = Entry.weapon,
        start = os.clock( ),
        dur = Entry.drawDur
    }
    local LastHold = Entry.lastHold
    HoldC0 = if LastHold then LastHold else Entry.lastC0
    Table.holdC0 = HoldC0
    Table.fromPose = FromPose
    Table.lh = Entry.lh
    Class12[ HolsterName ] = Table
end

local Class14 = setmetatable( { }, { __mode = "k" } )

local function WatchChar( CharName )
    if Class14[ CharName ] then
        return
    end
    AnimWorkers.Sync( )
    Class14[ CharName ] = true
    CharName.ChildRemoved:Connect( function( Object )
        if not Object:IsA( "Tool" ) then
            return
        end

        local Entry = Class5[ CharName ]

        if Entry and Entry.drawDur and Entry.handle then
            if Entry.tool == Object or Entry.handle.Parent == Object then
                StartHolster( CharName, Entry )
                Class5[ CharName ] = nil

                if AnimWorkers.IsWorker then
                    AnimWorkers.SetAim( CharName, false )
                end
            end
        end
    end )
    return
end

local function UpdateHolster( HolsterName, Argument2, Clips )
    if not HolsterName.Parent then
        Class12[ HolsterName ] = nil
        return
    end

    local Clock = ( os.clock( ) - Argument2.start ) / 0.25

    if Clock >= 1 then
        Class12[ HolsterName ] = nil
        return
    end

    local FromPose2
    local Clamp = math.clamp( Clock, 0, 1 )
    local Clamp2 = 1 - Clamp * Clamp * ( 3 - 2 * Clamp )
    local FromPose = Argument2.fromPose
    FromPose2 = if FromPose then FromPose else { }
    local Value1 = nil

    for Key, Value in FromPose2, nil, nil do
        if Key.Parent then
            local SetT = AnimWorkers.setT
            SetT( Key, AnimWorkers.getT( Key ):Lerp( Value, Clamp2 ) )
        end
    end
end

local Class15 = setmetatable( { }, { __mode = "k" } )

local function GunJointsOf( Key )
    local Entry2
    local Entry = Class15[ Key ]

    if Entry then
        Entry2 = Entry
    else
        AnimWorkers.Sync( )
        local Table = { dirty = true }
        Class15[ Key ] = Table

        local function Dirty()
            Table.dirty = true
        end

        Key.ChildAdded:Connect( Dirty )
        Key.ChildRemoved:Connect( Dirty )
        Entry2 = Table
    end
    if not Entry2.dirty and Entry2.serverJ and not Entry2.localJ and Entry2.serverJ.Parent == Key then
        local ServerJ = Entry2.serverJ
        return ServerJ, nil
    end

    local ServerJ2, LocalJ
    Entry2.dirty = false
    ServerJ2 = nil
    LocalJ = nil

    for Key2, Value in Key:GetChildren( ) do
        if Value.Name == "GunJoint" then
            if Value:GetAttribute( "Local" ) then
                LocalJ = Value
            else
                ServerJ2 = Value
            end
        end
    end

    Entry2.serverJ = ServerJ2
    Entry2.localJ = LocalJ
    return ServerJ2, LocalJ
end

local Number13 = -math.huge
local Position = Vector3.new( 0, 0, 0 )

local function PreAnimChar( Argument1, Part1, Amount2, Argument4 )
    local Storage = { }
    local Root
    table.clear( Table17 )

    if Part1 then
        local Entry2
        local Entry = Class2[ Part1 ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = NewCache( Part1 )
        end

        local Entry4
        local Entry3 = Entry2[ Table5 ]

        if Entry3 then
            Entry4 = Entry3
        else
            local TableInner = { }
            Entry2[ Table5 ] = TableInner
            Entry4 = TableInner
        end

        local HumanoidRootPart = Entry4.HumanoidRootPart

        if not HumanoidRootPart or HumanoidRootPart.Parent ~= Part1 then
            local HumanoidRootPart2 = Part1:FindFirstChild( "HumanoidRootPart" )
            Entry4.HumanoidRootPart = HumanoidRootPart2
            Root = HumanoidRootPart2
        else
            Root = HumanoidRootPart
        end
    else
        Root = Part1
    end

    local HumanoidRootPart3 = if Root then ( Root.Position - Argument4 ).Magnitude else Root
    local Entry7

    if not Part1 or Part1 == Character or not Root or ClientState.Scoped then
        Entry7 = Amount2
    else
        local Number2
        local HumanoidRootPart4 = HumanoidRootPart3 * math.clamp( CurrentCamera.FieldOfView / 70, 0.05, 1 )

        if HumanoidRootPart4 > 500 then
            Number2 = 3
        elseif HumanoidRootPart4 > 220 then
            Number2 = 2
        else
            Number2 = 1
        end
        if Flag then
            local NumberInner

            if Table[ 3 ] < HumanoidRootPart4 then
                NumberInner = 4
            elseif Table[ 2 ] < HumanoidRootPart4 then
                NumberInner = 3
            elseif Table[ 1 ] < HumanoidRootPart4 then
                NumberInner = 2
            else
                NumberInner = 1
            end

            Number2 = NumberInner
        end

        local FlagInner = List[ Part1 ] ~= false and true or false

        if not FlagInner then
            Number2 = 4
        end
        if Number2 > 1 and ( Number + Argument1 ) % Number2 ~= 0 then
            Class[ Part1 ] = ( Class[ Part1 ] or 0 ) + Amount2
            local Entry5 = Class9[ Part1 ]

            if Entry5 and Entry5.phaseRate then
                Entry5.phase = ( Entry5.phase + Entry5.phaseRate * Amount2 ) % 1

                if Entry5.phase ~= Entry5.phase then
                    Entry5.phase = 0
                end
            end

            local Entry6 = Class5[ Part1 ]

            if Entry6 and Entry6.runRate then
                Entry6.runPhase = ( ( Entry6.runPhase or 0 ) + Entry6.runRate * Amount2 ) % 1

                if Entry6.runPhase ~= Entry6.runPhase then
                    Entry6.runPhase = 0
                end
            end

            return
        end
        Entry7 = Amount2 + ( Class[ Part1 ] or 0 )
        Class[ Part1 ] = 0
    end

    local Exp = 1 - math.exp( -18 * Entry7 )

    if Part1 then
        if not Class14[ Part1 ] then
            AnimWorkers.Sync( )
            Class14[ Part1 ] = true
            Part1.ChildRemoved:Connect( function( Object )
                if not Object:IsA( "Tool" ) then
                    return
                end

                local Entry = Class5[ Part1 ]

                if Entry and Entry.drawDur and Entry.handle then
                    if Entry.tool == Object or Entry.handle.Parent == Object then
                        StartHolster( Part1, Entry )
                        Class5[ Part1 ] = nil

                        if AnimWorkers.IsWorker then
                            AnimWorkers.SetAim( Part1, false )
                        end
                    end
                end
            end )
        end
    end
    if not Root or not RunCycle or not RunGait.HasFastRun( ) or not ( HumanoidRootPart3 <= math.huge ) then
        if Part1 then
            Class9[ Part1 ] = nil
        end
    else
        UpdateBare( Part1, Root, Entry7, Amount2 )
    end

    local Tool3

    if Part1 then
        local Entry9
        local Entry8 = Class2[ Part1 ]

        if Entry8 then
            Entry9 = Entry8
        else
            Entry9 = NewCache( Part1 )
        end

        local Entry11
        local Entry10 = Entry9[ Table5 ]

        if Entry10 then
            Entry11 = Entry10
        else
            local Table2 = { }
            Entry9[ Table5 ] = Table2
            Entry11 = Table2
        end

        local Tool = Entry11[ "@Tool" ]

        if not Tool or Tool.Parent ~= Part1 then
            local Tool2 = Part1:FindFirstChildOfClass( "Tool" )
            Entry11[ "@Tool" ] = Tool2
            Tool3 = Tool2
        else
            Tool3 = Tool
        end
    else
        Tool3 = Part1
    end

    local Part12

    if Tool3 then
        Part12 = HandleOf( Part1, Tool3 )
    else
        Part12 = Tool3
    end

    local Weapon

    if Part12 then
        Weapon = Tool3:GetAttribute( "Weapon" )
    else
        Weapon = Part12
    end

    local Joint

    if Part12 then
        if not Weapon or not Root then
            local GunJoint = Part12:FindFirstChild( "GunJoint" )

            if GunJoint then
                Joint = GunJoint
            else
                Joint = nil
            end
        else
            Joint = nil
        end
    else
        Joint = nil
    end
    if Part1 == Character and Tool3 and Tool3:GetAttribute( "NoToolAnim" ) then
        local Entry13
        local Entry12 = Class2[ Part1 ]

        if Entry12 then
            Entry13 = Entry12
        else
            Entry13 = NewCache( Part1 )
        end

        local Entry15
        local Entry14 = Entry13[ Table5 ]

        if Entry14 then
            Entry15 = Entry14
        else
            local Table3Inner = { }
            Entry13[ Table5 ] = Table3Inner
            Entry15 = Table3Inner
        end

        local Humanoid3
        local Humanoid = Entry15[ "@Humanoid" ]

        if not Humanoid or Humanoid.Parent ~= Part1 then
            local Humanoid2 = Part1:FindFirstChildOfClass( "Humanoid" )
            Entry15[ "@Humanoid" ] = Humanoid2
            Humanoid3 = Humanoid2
        else
            Humanoid3 = Humanoid
        end

        local Animator

        if Humanoid3 then
            Animator = Humanoid3:FindFirstChildOfClass( "Animator" )
        else
            Animator = Humanoid3
        end
        if Animator then
            for Key, Value in Animator:GetPlayingAnimationTracks( ) do
                if Value.Animation and Value.Animation.Name == "ToolNoneAnim" then
                    Value:Stop( 0 )
                end
            end
        end
    end
    if Part12 and Weapon and Root then
        local Motor6D
        local Value1, Value2 = GunJointsOf( Part12 )

        if not Value1 or not Value2 then
            Motor6D = Value2
        else
            local SetC0 = AnimWorkers.setC0
            SetC0( Value1, AnimWorkers.getC0( Value2 ) )
            AnimWorkers.Sync( )
            Value2:Destroy( )
            Motor6D = nil
        end

        local Entry17
        local Entry16 = Class2[ Part1 ]

        if Entry16 then
            Entry17 = Entry16
        else
            Entry17 = NewCache( Part1 )
        end

        local Entry19
        local Entry18 = Entry17[ Table5 ]

        if Entry18 then
            Entry19 = Entry18
        else
            local Table4Inner = { }
            Entry17[ Table5 ] = Table4Inner
            Entry19 = Table4Inner
        end

        local Part0
        local UpperTorso = Entry19.UpperTorso

        if not UpperTorso or UpperTorso.Parent ~= Part1 then
            local UpperTorso2 = Part1:FindFirstChild( "UpperTorso" )
            Entry19.UpperTorso = UpperTorso2
            Part0 = UpperTorso2
        else
            Part0 = UpperTorso
        end
        if not Value1 and not Motor6D and Part0 then
            local LastC02
            AnimWorkers.Sync( )
            local Motor6D2 = Instance.new( "Motor6D" )
            Motor6D2.Name = "GunJoint"
            Motor6D2:SetAttribute( "Local", true )
            Motor6D2.Part0 = Part0
            Motor6D2.Part1 = Part12
            local SetC02 = AnimWorkers.setC0

            if Class5[ Part1 ] then
                local LastC0 = Class5[ Part1 ].lastC0

                if LastC0 then
                    LastC02 = LastC0
                else
                    LastC02 = Config.Poses.Low.Gun
                end
            else
                LastC02 = Config.Poses.Low.Gun
            end

            SetC02( Motor6D2, LastC02 )
            Motor6D2.Parent = Part12
            Motor6D = Motor6D2
        end

        Joint = Value1 or Motor6D
    end
    if not Joint or not Root or HumanoidRootPart3 > math.huge then
        if Part1 then
            Storage.Entry47 = Class5[ Part1 ]

            if Storage.Entry47 and not Joint and Root and Storage.Entry47.drawDur and not Class12[ Part1 ] then
                StartHolster( Part1, Storage.Entry47 )
            end

            Class5[ Part1 ] = nil
        end

        return
    end
    if Class12[ Part1 ] then
        Class12[ Part1 ] = nil
    end

    local Entry21
    local Entry20 = Class2[ Part1 ]

    if Entry20 then
        Entry21 = Entry20
    else
        Entry21 = NewCache( Part1 )
    end

    local Entry23
    local Entry22 = Entry21[ Table5 ]

    if Entry22 then
        Entry23 = Entry22
    else
        local Table5Inner = { }
        Entry21[ Table5 ] = Table5Inner
        Entry23 = Table5Inner
    end

    local RightHand3
    local RightHand = Entry23.RightHand

    if not RightHand or RightHand.Parent ~= Part1 then
        local RightHand2 = Part1:FindFirstChild( "RightHand" )
        Entry23.RightHand = RightHand2
        RightHand3 = RightHand2
    else
        RightHand3 = RightHand
    end
    if not RightHand3 then
        local Entry25
        local Entry24 = Class2[ Part1 ]

        if Entry24 then
            Entry25 = Entry24
        else
            Entry25 = NewCache( Part1 )
        end

        local Entry27
        local Entry26 = Entry25[ Table5 ]

        if Entry26 then
            Entry27 = Entry26
        else
            local Table6 = { }
            Entry25[ Table5 ] = Table6
            Entry27 = Table6
        end

        local RightArm = Entry27[ "Right Arm" ]

        if not RightArm or RightArm.Parent ~= Part1 then
            local RightArm2 = Part1:FindFirstChild( "Right Arm" )
            Entry27[ "Right Arm" ] = RightArm2
            RightHand3 = RightArm2
        else
            RightHand3 = RightArm
        end
    end
    if RightHand3 and RightHand3:FindFirstChild( "RightGrip" ) then
        AnimWorkers.Sync( )
        GunRig.CleanGrips( Part1 )
    end

    local SmPose
    local Stance, Value3 = GetStance( Part1 )
    local Free = Holds.Free( Weapon, Stance )
    local Pose = Holds.Pose( Weapon, Stance )

    if Pose then
        SmPose = Pose
    elseif Free then
        local Pose2 = Holds.Pose( Weapon, "Aim" )

        if Pose2 then
            SmPose = Pose2
        else
            SmPose = Config.Poses.Low
        end
    else
        SmPose = Config.Poses.Low
    end

    local Entry31
    local Entry28 = Class5[ Part1 ]

    if Entry28 then
        Entry31 = Entry28
    else
        local RunPhase
        local Table7 = {
            pitch = Value3,
            twist = 0,
            gun = SmPose.Gun,
            joints = { },
            rh = SmPose.RightHand,
            lh = SmPose.LeftHand,
            poseW = 0,
            equipStart = os.clock( )
        }

        if Class9[ Part1 ] then
            local Phase = Class9[ Part1 ].phase

            if Phase then
                RunPhase = Phase
            else
                RunPhase = 0
            end
        else
            RunPhase = 0
        end

        local FreeW
        Table7.runPhase = RunPhase
        FreeW = not Free and 0 or 1
        local Value4
        Table7.freeW = FreeW
        Value4 = nil

        for Value5 in Table4, nil, nil do
            local Entry30
            local Joints = Table7.joints
            local Entry29 = SmPose[ Value5 ]
            Entry30 = if Entry29 then Entry29 else CFrame.identity
            Joints[ Value5 ] = Entry30
        end

        Class5[ Part1 ] = Table7
        Entry31 = Table7
    end
    if Entry31.rpg and Stance == "Reload" and Entry31.reloadT and Entry31.reloadDur and Entry31.reloadT / Entry31.reloadDur > 0.85 then
        SmPose = Holds.Pose( Weapon, "Low" ) or SmPose
    end

    local ReloadDur
    Entry31.stance = Stance
    Entry31.handle = Part12
    Entry31.joint = Joint
    Entry31.root = Root
    Entry31.tool = Tool3
    local Entry32 = WeaponData[ Weapon ]
    local ReloadTime = Tool3:GetAttribute( "ReloadTime" )

    if ReloadTime then
        ReloadDur = ReloadTime
    elseif Entry32 then
        local ReloadTime2 = Entry32.Ammo.ReloadTime

        if ReloadTime2 then
            ReloadDur = ReloadTime2
        else
            ReloadDur = 2
        end
    else
        ReloadDur = 2
    end

    local DrawDur
    Entry31.reloadDur = ReloadDur

    if not Entry32 or not Entry32.Handling.DrawFromBack then
        DrawDur = nil
    else
        local EquipTime = Entry32.Handling.EquipTime

        if EquipTime then
            DrawDur = EquipTime
        else
            DrawDur = nil
        end
    end

    local Shell2
    Entry31.drawDur = DrawDur
    Entry31.weapon = Weapon
    Entry31.pistol = Holds.IsPistol( Weapon )
    Entry31.rpg = Holds.IsRocket( Weapon )

    if Entry32 then
        local Shell = Entry32.Ammo.Shell

        if Shell then
            Shell2 = Shell
        else
            Shell2 = nil
        end
    else
        Shell2 = nil
    end

    Entry31.shell = Shell2

    if Entry31.shell and Stance == "Reload" then
        SmPose = Holds.Pose( Weapon, "Low" ) or SmPose
    end
    if Entry31.shell and Stance == "ReloadAim" then
        SmPose = Holds.Pose( Weapon, "Aim" ) or SmPose
    end

    local OwnPose

    if Entry32 == nil then
        OwnPose = false
    elseif Entry32.Handling.Poses == nil then
        OwnPose = false
    else
        OwnPose = true
    end

    local ReloadStart3
    Entry31.ownPose = OwnPose
    Entry31.free = Free

    if Part1 == Character then
        local ReloadStart2

        if ClientState.Reloading then
            local ReloadStart = ClientState.ReloadStart

            if ReloadStart then
                ReloadStart2 = ReloadStart
            else
                ReloadStart2 = nil
            end
        else
            ReloadStart2 = nil
        end

        ReloadStart3 = ReloadStart2
    else
        WatchTool( Tool3 )
        ReloadStart3 = Class3[ Tool3 ]
    end
    if ReloadStart3 and Part1:GetAttribute( "RankedPose" ) then
        ReloadStart3 = nil
    end

    local ReloadMul3

    if Part1 == Character then
        local ReloadMul = ClientState.ReloadMul

        if ReloadMul then
            ReloadMul3 = ReloadMul
        else
            local ReloadMul2 = Tool3:GetAttribute( "ReloadMul" )

            if ReloadMul2 then
                ReloadMul3 = ReloadMul2
            else
                ReloadMul3 = 1
            end
        end
    else
        local ReloadMul2 = Tool3:GetAttribute( "ReloadMul" )

        if ReloadMul2 then
            ReloadMul3 = ReloadMul2
        else
            ReloadMul3 = 1
        end
    end

    local ReloadT

    if ReloadStart3 then
        local Clock = ( os.clock( ) - ReloadStart3 ) / ReloadMul3

        if Clock then
            ReloadT = Clock
        else
            ReloadT = nil
        end
    else
        ReloadT = nil
    end

    local DebugReloadT
    Entry31.reloadT = ReloadT

    if Part1 == Character then
        DebugReloadT = LocalPlayer:GetAttribute( "DebugReloadT" )
    else
        DebugReloadT = false
    end
    if DebugReloadT then
        if Stance == "Reload" or Entry31.pistol or Entry31.rpg then
            Entry31.reloadT = DebugReloadT * Entry31.reloadDur
        end
    end

    local Number3

    if not Entry31.reloadT or not Table9 or Entry31.pistol or Entry31.rpg or Entry31.shell then
        Number3 = 0
    else
        local Clamp = math.clamp( ( Entry31.reloadT / Entry31.reloadDur - 0.8 ) / 0.2, 0, 1 )
        Number3 = 1 - Clamp * Clamp * ( 3 - Clamp * 2 )
    end

    local Pitch
    Entry31.reloadW = ( Entry31.reloadW or 0 ) + ( Number3 - ( Entry31.reloadW or 0 ) ) * ( 1 - math.exp( -14 * Entry7 ) )
    Pitch = Part1 == Character and Value3 or Entry31.pitch + ( Value3 - Entry31.pitch ) * Exp
    local Number4
    Entry31.pitch = Pitch
    local PoseW = Entry31.poseW
    Number4 = ( not Table3[ Stance ] or Free ) and 0 or 1
    Entry31.poseW = PoseW + ( Number4 - Entry31.poseW ) * Exp

    if Entry31.ownPose then
        local TwistT4
        Entry31.smPose = nil
        local Exp2 = 1 - math.exp( -30.599999999999998 * Entry7 )
        local Rad = math.rad( SmPose.Twist or 0 )
        local TwistT = Entry31.twistT
        TwistT4 = if TwistT then TwistT else Entry31.twist
        local TwistT3
        local TwistT2 = Entry31.twistT
        TwistT3 = if TwistT2 then TwistT2 else Entry31.twist
        local GunT2
        Entry31.twistT = TwistT4 + ( Rad - TwistT3 ) * Exp2
        Entry31.twist = Entry31.twist + ( Entry31.twistT - Entry31.twist ) * Exp2
        local GunT = Entry31.gunT
        GunT2 = if GunT then GunT else Entry31.gun
        local RhT2
        Entry31.gunT = GunT2:Lerp( SmPose.Gun, Exp2 )
        local Gun = Entry31.gun
        Entry31.gun = Gun:Lerp( Entry31.gunT, Exp2 )
        local RhT = Entry31.rhT
        RhT2 = if RhT then RhT else Entry31.rh
        local LhT2
        Entry31.rhT = RhT2:Lerp( SmPose.RightHand, Exp2 )
        local Rh = Entry31.rh
        Entry31.rh = Rh:Lerp( Entry31.rhT, Exp2 )
        local LhT = Entry31.lhT
        LhT2 = if LhT then LhT else Entry31.lh
        local JointsT2
        Entry31.lhT = LhT2:Lerp( SmPose.LeftHand, Exp2 )
        local Lh = Entry31.lh
        Entry31.lh = Lh:Lerp( Entry31.lhT, Exp2 )
        local JointsT = Entry31.jointsT
        JointsT2 = if JointsT then JointsT else { }
        local Value6
        Entry31.jointsT = JointsT2
        Value6 = nil

        for Value7 in Table4, nil, nil do
            local Entry35
            local JointsT3 = Entry31.jointsT
            local Entry33 = Entry31.jointsT[ Value7 ]
            Entry35 = if Entry33 then Entry33 else Entry31.joints[ Value7 ]
            local Entry36
            local Entry34 = SmPose[ Value7 ]
            Entry36 = if Entry34 then Entry34 else CFrame.identity
            JointsT3[ Value7 ] = Entry35:Lerp( Entry36, Exp2 )
            local Joints2 = Entry31.joints
            local Entry37 = Entry31.joints[ Value7 ]
            Joints2[ Value7 ] = Entry37:Lerp( Entry31.jointsT[ Value7 ], Exp2 )
        end
    else
        if SmPose ~= Entry31.smPose then
            local SmT = os.clock( )
            Entry31.smPose = SmPose
            Entry31.smT = SmT
            Entry31.smDone = false
        end
        if not Entry31.smDone then
            if os.clock( ) - Entry31.smT >= 1 then
                local Value8
                Entry31.twist = math.rad( SmPose.Twist or 0 )
                local Gun2 = SmPose.Gun
                local Rh2 = SmPose.RightHand
                local Lh2 = SmPose.LeftHand
                Entry31.gun = Gun2
                Entry31.rh = Rh2
                Entry31.lh = Lh2
                Value8 = nil

                for Value9 in Table4, nil, nil do
                    local Entry39
                    local Joints3 = Entry31.joints
                    local Entry38 = SmPose[ Value9 ]
                    Entry39 = if Entry38 then Entry38 else CFrame.identity
                    Joints3[ Value9 ] = Entry39
                end

                Entry31.smDone = true
            else
                local Value10
                Entry31.twist = Entry31.twist + ( math.rad( SmPose.Twist or 0 ) - Entry31.twist ) * Exp
                local Gun3 = Entry31.gun
                Entry31.gun = Gun3:Lerp( SmPose.Gun, Exp )
                local Rh3 = Entry31.rh
                Entry31.rh = Rh3:Lerp( SmPose.RightHand, Exp )
                local Lh3 = Entry31.lh
                Entry31.lh = Lh3:Lerp( SmPose.LeftHand, Exp )
                Value10 = nil

                for Value11 in Table4, nil, nil do
                    local Entry42
                    local Joints4 = Entry31.joints
                    local Entry40 = Entry31.joints[ Value11 ]
                    local Entry41 = SmPose[ Value11 ]
                    Entry42 = if Entry41 then Entry41 else CFrame.identity
                    Joints4[ Value11 ] = Entry40:Lerp( Entry42, Exp )
                end
            end
        end
    end
    if RunCycle then
        local Entry44
        local Entry43 = Class2[ Part1 ]

        if Entry43 then
            Entry44 = Entry43
        else
            Entry44 = NewCache( Part1 )
        end

        local Entry46
        local Entry45 = Entry44[ Table5 ]

        if Entry45 then
            Entry46 = Entry45
        else
            local Table8 = { }
            Entry44[ Table5 ] = Table8
            Entry46 = Table8
        end

        local Humanoid6
        local Humanoid4 = Entry46[ "@Humanoid" ]

        if not Humanoid4 or Humanoid4.Parent ~= Part1 then
            local Humanoid5 = Part1:FindFirstChildOfClass( "Humanoid" )
            Entry46[ "@Humanoid" ] = Humanoid5
            Humanoid6 = Humanoid5
        else
            Humanoid6 = Humanoid4
        end

        local Speed2
        local Speed = Table17.speed

        if Speed then
            Speed2 = Speed
        else
            Speed2 = RunSpeed( Root, Humanoid6 )
        end

        local OnG3

        if Humanoid6 == nil then
            OnG3 = false
        else
            local OnG = Table17.onG

            if OnG == nil then
                local OnG2 = OnGround( Root, Humanoid6 )
                Table17.onG = OnG2
                OnG3 = OnG2
            else
                OnG3 = OnG
            end
            if OnG3 then
                local Climb3
                local Climb = Table17.climb

                if Climb == nil then
                    local Climb2 = IsClimbing( Part1, Humanoid6 )
                    Table17.climb = Climb2
                    Climb3 = Climb2
                else
                    Climb3 = Climb
                end

                local NotClimb = not Climb3

                if NotClimb then
                    local Swim3
                    local Swim = Table17.swim

                    if Swim == nil then
                        local Swim2 = SwimTilt.EnNage( Part1 )
                        Table17.swim = Swim2
                        Swim3 = Swim2
                    else
                        Swim3 = Swim
                    end

                    OnG3 = not Swim3
                else
                    OnG3 = NotClimb
                end
            end
        end

        if Stance == "Low" or Stance == "Sprint" or Stance == "Reload" then
            if OnG3 then
                if RunCycle.MinSpeed < Speed2 then
                    local Seated3
                    local Seated = Table17.seated

                    if Seated == nil then
                        local Seated2
                        local Sit = Humanoid6.Sit

                        if Sit then
                            Seated2 = Sit
                        elseif Humanoid6.SeatPart == nil then
                            Seated2 = false
                        else
                            Seated2 = true
                        end

                        Table17.seated = Seated2
                        Seated3 = Seated2
                    else
                        Seated3 = Seated
                    end

                    local NotSeated = not Seated3

                    if NotSeated then
                        local Crouch = Table17.crouch

                        if Crouch == nil then
                            local Crouch2 = CrouchAnim.IsCrouched( Part1 )
                            Table17.crouch = Crouch2
                            Storage.Crouch3 = Crouch2
                        else
                            Storage.Crouch3 = Crouch
                        end

                        Storage.NotCrouch = not Storage.Crouch3

                        if Storage.NotCrouch then
                            Storage.Flag2 = not Free
                        else
                            Storage.Flag2 = Storage.NotCrouch
                        end
                    else
                        Storage.Flag2 = NotSeated
                    end
                else
                    Storage.Flag2 = false
                end
            else
                Storage.Flag2 = OnG3
            end
        else
            Storage.Flag2 = false
        end
        Storage.RunW = Entry31.runW or 0
        Storage.Number5 = not Storage.Flag2 and 0 or 1
        Entry31.runW = Storage.RunW + ( Storage.Number5 - ( Entry31.runW or 0 ) ) * ( 1 - math.exp( -10 * Entry7 ) )
        Storage.RunRate = RunCycle.CadenceBase + RunCycle.CadencePerSpeed * Speed2
        Entry31.runPhase = ( ( Entry31.runPhase or 0 ) + Storage.RunRate * Amount2 ) % 1
        Entry31.runRate = Storage.RunRate

        if RunCycle.UseFastRun and RunGait.HasFastRun( ) then
            Entry31.runPhase = ( ( Entry31.runPhase or 0 ) - Storage.RunRate * Amount2 + Speed2 / RunCycle.CycleLength * Amount2 ) % 1
            Entry31.runRate = Speed2 / RunCycle.CycleLength
        end
        Storage.UseFastRun = RunCycle.UseFastRun
        Storage.UseFastRun2 = if Storage.UseFastRun then RunGait.HasFastRun( ) else Storage.UseFastRun
        Storage.NotUseFastRun = not Storage.UseFastRun2

        if Storage.NotUseFastRun then
            if Humanoid6 then
                Storage.Animator2 = Humanoid6:FindFirstChildOfClass( "Animator" )
            else
                Storage.Animator2 = Humanoid6
            end
        else
            Storage.Animator2 = Storage.NotUseFastRun
        end
        if Storage.Animator2 then
            AnimWorkers.Sync( )

            for Key2, Value12 in Storage.Animator2:GetPlayingAnimationTracks( ) do
                if Value12.Animation and Value12.Animation.Name == "RunAnim" and Value12.WeightCurrent > 0.1 then
                    if Value12.Length > 0 then
                        Entry31.runPhase = ( Value12.TimePosition / Value12.Length + ( RunCycle.BasePhaseOffset or 0 ) ) % 1
                        Entry31.runRate = nil
                        break
                    end
                end
            end
        end
        if Entry31.runPhase ~= Entry31.runPhase then
            Entry31.runPhase = 0
        end

        Storage.Speed3 = Speed2 / 26
        Entry31.runK = math.clamp( Storage.Speed3, RunCycle.MinIntensity, 1 )

        if Entry31.runK ~= Entry31.runK then
            Entry31.runK = 1
        end
    end

    return
end

local function PaceInterval( Position )
    if ClientState.Scoped or workspace:GetAttribute( "TestPaceOff" ) == true then
        return 0
    end

    local Number, Number3

    if Flag then
        Number = Table2[ 2 ]
        Number3 = Table2[ 1 ]
    else
        Number = 30
        Number3 = 60
    end

    local TestPaceHz = workspace:GetAttribute( "TestPaceHz" )

    if type( TestPaceHz ) == "number" and TestPaceHz > 0 then
        Number = TestPaceHz
        Number3 = TestPaceHz
    end

    local Clamp = math.clamp( CurrentCamera.FieldOfView / 70, 0.05, 1 )
    local Number2 = 1 / Number

    for Key, Value in AnimatedChars( ) do
        local FlagInner = List[ Value ] ~= false and true or false

        if FlagInner then
            local Entry2
            local Entry = Class2[ Value ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = NewCache( Value )
            end

            local Entry4
            local Entry3 = Entry2[ Table5 ]

            if Entry3 then
                Entry4 = Entry3
            else
                local Table = { }
                Entry2[ Table5 ] = Table
                Entry4 = Table
            end

            local HumanoidRootPart3
            local HumanoidRootPart = Entry4.HumanoidRootPart

            if not HumanoidRootPart or HumanoidRootPart.Parent ~= Value then
                local HumanoidRootPart2 = Value:FindFirstChild( "HumanoidRootPart" )
                Entry4.HumanoidRootPart = HumanoidRootPart2
                HumanoidRootPart3 = HumanoidRootPart2
            else
                HumanoidRootPart3 = HumanoidRootPart
            end
            if HumanoidRootPart3 then
                local Magnitude = ( HumanoidRootPart3.Position - Position ).Magnitude * Clamp

                if Magnitude < 35 then
                    return 0
                end
                if Magnitude < 80 then
                    Number2 = 1 / Number3
                end
            end
        end
    end

    return Number2
end

RunService.PreAnimation:Connect( function( Argument1 )
    if not AnimWorkers.IsWorker then
        Number = Number + 1
    end

    Character = LocalPlayer.Character

    if not AnimWorkers.IsWorker then
        AnimWorkers.CheckReady( )
        AnimWorkers.Watch( os.clock( ), Callback3 )
    end
    if AnimWorkers.Tick( ) then
        Flag3 = true
        AnimatedChars( )

        if Callback2 then
            Callback2( )
        end

        AnimWorkers.ClearReplay( )
        Number2 = -math.huge
    end
    if AnimWorkers.IsWorker then
        local FlagInner
        ClientState.Scoped = AnimWorkers.State.Scoped or nil
        OnScreen.forceOff = AnimWorkers.State.ForceOff or nil
        FlagInner = AnimWorkers.State.LightPlayers == true and true or false
        Flag = FlagInner
    else
        local Scoped
        local State = AnimWorkers.State
        Scoped = ClientState.Scoped == true and true or false
        local ForceOff
        State.Scoped = Scoped
        local State2 = AnimWorkers.State
        ForceOff = OnScreen.forceOff == true and true or false
        local Flag2Inner
        State2.ForceOff = ForceOff
        Flag2Inner = ClientState.LightPlayers == true and true or false
        Flag = Flag2Inner

        if AnimWorkers.State.LightPlayers ~= Flag then
            AnimWorkers.State.LightPlayers = Flag
        end
    end

    local Captured
    local PositionInner = CurrentCamera.CFrame.Position

    if AnimWorkers.IsWorker then
        local AnimatedChars2 = AnimatedChars( )

        if AnimatedChars2 then
            Captured = AnimatedChars2
        else
            AnimatedChars( )
            Captured = Table11
        end
    else
        AnimatedChars( )
        Captured = Table11
    end

    UpdateOnScreen( Captured )

    if AnimWorkers.IsWorker then
        local Flag3Inner
        Number3 = Number3 + Argument1
        local Clock = os.clock( )
        local PaceInterval2 = PaceInterval( PositionInner )

        if PaceInterval2 <= 0 then
            Flag3Inner = true
        else
            local Clock2 = Clock - Number2

            if PaceInterval2 - 0.004 <= Clock2 then
                Flag3Inner = true
            else
                Flag3Inner = false
            end
        end

        Flag2 = Flag3Inner

        if not Flag2 then
            return
        end

        Number2 = Clock
        Number5 = Number3
        Number3 = 0
        Number = Number + 1
        AnimWorkers.CachePlayers( )

        if Callback then
            Callback( )
        end

        Position = PositionInner
        return
    end
    for Key, Value in AnimatedChars( ) do
        local Success, Result = pcall( PreAnimChar, Table12[ Value ] or 0, Value, Argument1, PositionInner )

        if not Success and os.clock( ) - Number13 > 10 then
            Number13 = os.clock( )
            warn( "[GunAnimator] " .. tostring( Result ) )
        end
    end

    return
end )

if AnimWorkers.IsWorker then
    RunService.PreAnimation:ConnectParallel( function()
        if not Flag2 then
            return
        end

        local Result
        AnimWorkers.InParallel = true
        Result = nil

        for Key, Value in AnimatedChars( ) do
            Success, Result = pcall( PreAnimChar, Table12[ Value ] or 0, Value, Number5, Position )
        end
        for Key2, Value3 in AnimatedChars( ) do
            local Flag
            local Entry = Class5[ Value3 ]
            local SetAim = AnimWorkers.SetAim

            if Entry == nil then
                Flag = false
            elseif Entry.stance == "Aim" then
                Flag = true
            elseif Entry.stance == "ReloadAim" then
                Flag = true
            else
                Flag = false
            end

            SetAim( Value3, Flag )
        end

        task.synchronize( )
        AnimWorkers.Flush( )

        if Result and os.clock( ) - Number13 > 10 then
            Number13 = os.clock( )
            warn( "[GunAnimator] " .. tostring( Result ) )
        end
    end )
end
local Clips = require( Weapons:WaitForChild( "Clips" ) )
Storage.HealAnim = require( Weapons:WaitForChild( "HealAnim" ) )
Storage.Global = Config.Global
Storage.RollTimeScale = Storage.Global.RollTimeScale or 1.35
Storage.RollEnd = Storage.Global.RollEnd or 1.6
Storage.RollBackStart = Storage.Global.RollBackStart or 1.2

Storage.RollDuration = function( DurationName )
    local Captured = string.sub( DurationName or "", 1, 1 ) == "B" and Storage.RollBackStart or Storage.RollEnd
    return Captured / Storage.RollTimeScale
end

Storage.Class16 = setmetatable( { }, { __mode = "k" } )
Storage.RaycastParams4 = RaycastParams.new( )
Storage.RaycastParams4.IgnoreWater = true
Storage.RaycastParams4.FilterType = Enum.RaycastFilterType.Exclude

Storage.JointOf = function( Key2, Name2 )
    return ( J( Key2, Table14[ Name2 ] or "", Name2 ) )
end

Storage.RollInfo = function( Object )
    if Object:GetAttribute( "RankedPose" ) then
        return nil
    end
    if Object == Character then
        if ClientState.Rolling then
            local RollMode = ClientState.RollMode
            return RollMode, ( os.clock( ) - ClientState.RollStart ) * ( ClientState.RollSpeed or 1 ), 1
        end

        local RollCancel = ClientState.RollCancel

        if RollCancel then
            local Clock = ( os.clock( ) - RollCancel.at ) / 0.18

            if Clock < 1 then
                local Mode = RollCancel.mode
                local T = RollCancel.t
                local Clamp = math.clamp( Clock, 0, 1 )
                return Mode, T, 1 - Clamp * Clamp * ( 3 - 2 * Clamp )
            end

            ClientState.RollCancel = nil
        end

        return nil
    end
    local RollStart = Object:GetAttribute( "RollStart" )
    local RollMode2 = Object:GetAttribute( "RollMode" )

    if RollStart and RollMode2 then
        local RollSpeed = Object:GetAttribute( "RollSpeed" ) or 1
        local RollCancel2 = Object:GetAttribute( "RollCancel" )

        if not RollCancel2 or not ( RollStart <= RollCancel2 ) then
            local ServerTimeNow2 = ( workspace:GetServerTimeNow( ) - RollStart ) * RollSpeed

            if ServerTimeNow2 >= 0 then
                local Captured = string.sub( RollMode2 or "", 1, 1 ) == "B" and Storage.RollBackStart or Storage.RollEnd

                if ServerTimeNow2 < Captured / Storage.RollTimeScale then
                    return RollMode2, ServerTimeNow2, 1
                end
            end
        else
            local ServerTimeNow = ( workspace:GetServerTimeNow( ) - RollCancel2 ) / 0.18

            if not ( ServerTimeNow >= 0 ) or not ( ServerTimeNow < 1 ) then
                return nil
            end
            local RollCancel3 = ( RollCancel2 - RollStart ) * RollSpeed
            local Clamp2 = math.clamp( ServerTimeNow, 0, 1 )
            return RollMode2, RollCancel3, 1 - Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 )
        end
    end

    return nil
end

Storage.ApplyClip = function( Key2, Argument2, Argument3, List, Argument5, Argument6, Argument7, Argument8 )
    local J2 = J( Key2, Table14.Root or "", "Root" )

    if J2 then
        local Min
        local Y = Argument2.Y - Argument5

        if Argument6 then
            Min = math.min( Y, 0 )
        else
            Min = Y
        end

        local SetT = AnimWorkers.setT
        local GetT = AnimWorkers.getT( J2 )
        SetT( J2, GetT:Lerp( CFrame.new( 0, Min, 0 ) * Argument3, Argument7 ) )
    end

    local Value2 = nil

    for Key, Value in List, nil, nil do
        if Argument8 or not Clips.ARMS[ Key ] then
            local J3 = J( Key2, Table14[ Key ] or "", Key )

            if J3 then
                local SetT2 = AnimWorkers.setT
                SetT2( J3, AnimWorkers.getT( J3 ):Lerp( Value, Argument7 ) )
            end
        end
    end
end

Storage.GroundedNear = function( NearName, Argument2, Humanoid )
    local HipHeight = Humanoid.HipHeight + Argument2.Size.Y / 2 + 0.7
    local Entry = Class6[ NearName ]

    if not Entry or Entry[ 1 ] ~= Number8 then
        local Flag = workspace:Raycast( Argument2.Position, Vector3.new( 0, -HipHeight, 0 ), ( RayParamsOf( NearName ) ) ) ~= nil and true or false
        return Flag
    end
    local Item2
    local Item = Entry[ 2 ]

    if Item then
        if Entry[ 3 ] == nil then
            Item2 = false
        elseif Entry[ 3 ] <= HipHeight then
            Item2 = true
        else
            Item2 = false
        end
    else
        Item2 = Item
    end

    return Item2
end

Storage.ApplyMoveClips = function( ClipsInner )
    ClientState.JumpBusy = false

    for Key, Value in AnimatedChars( ) do
        local Flag = List[ Value ] ~= false and true or false

        if Flag then
            local HumanoidRootPart3

            if Value then
                local Entry2
                local Entry = Class2[ Value ]

                if Entry then
                    Entry2 = Entry
                else
                    Entry2 = NewCache( Value )
                end

                local Entry4
                local Entry3 = Entry2[ Table5 ]

                if Entry3 then
                    Entry4 = Entry3
                else
                    local Table = { }
                    Entry2[ Table5 ] = Table
                    Entry4 = Table
                end

                local HumanoidRootPart = Entry4.HumanoidRootPart

                if not HumanoidRootPart or HumanoidRootPart.Parent ~= Value then
                    local HumanoidRootPart2 = Value:FindFirstChild( "HumanoidRootPart" )
                    Entry4.HumanoidRootPart = HumanoidRootPart2
                    HumanoidRootPart3 = HumanoidRootPart2
                else
                    HumanoidRootPart3 = HumanoidRootPart
                end
            else
                HumanoidRootPart3 = Value
            end

            local Humanoid3

            if Value then
                local Entry6
                local Entry5 = Class2[ Value ]

                if Entry5 then
                    Entry6 = Entry5
                else
                    Entry6 = NewCache( Value )
                end

                local Entry8
                local Entry7 = Entry6[ Table5 ]

                if Entry7 then
                    Entry8 = Entry7
                else
                    local Table2 = { }
                    Entry6[ Table5 ] = Table2
                    Entry8 = Table2
                end

                local Humanoid = Entry8[ "@Humanoid" ]

                if not Humanoid or Humanoid.Parent ~= Value then
                    local Humanoid2 = Value:FindFirstChildOfClass( "Humanoid" )
                    Entry8[ "@Humanoid" ] = Humanoid2
                    Humanoid3 = Humanoid2
                else
                    Humanoid3 = Humanoid
                end
            else
                Humanoid3 = Value
            end
            if HumanoidRootPart3 and Humanoid3 and not ( Humanoid3.Health <= 0 ) then
                local Entry9 = Class5[ Value ]
                local Value2, Value3, Value4 = Storage.RollInfo( Value )

                if Value2 then
                    local Captured2
                    local Captured = Value3 * Storage.RollTimeScale
                    Captured2 = string.sub( Value2 or "", 1, 1 ) == "B" and Storage.RollBackStart or Storage.RollEnd
                    local Captured4
                    local Min = math.min( Captured, Captured2 )

                    if string.sub( Value2 or "", 1, 1 ) == "B" then
                        local Captured3 = Storage.RollBackStart - Min

                        if Captured3 then
                            Captured4 = Captured3
                        else
                            Captured4 = Min
                        end
                    else
                        Captured4 = Min
                    end

                    local Captured5
                    local Sample = Clips.Sample
                    local Sample2, Sample22, Sample3 = Sample( Clips.Roll, Captured4 )
                    local Clamp = math.clamp( Value3 / 0.08, 0, 1 )
                    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
                    Captured5 = string.sub( Value2 or "", 1, 1 ) == "B" and Storage.RollBackStart or Storage.RollEnd
                    local Flag2
                    local Clamp3 = math.clamp( ( Value3 - ( Captured5 / Storage.RollTimeScale - 0.2 ) ) / 0.2, 0, 1 )
                    local Clamp4 = Clamp2 * ( 1 - Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) ) * ( Value4 or 1 )
                    local BaseY = Clips.Roll.baseY
                    Flag2 = if Entry9 == nil then true else Entry9.pistol
                    Storage.ApplyClip( Value, Sample2, Sample22, Sample3, BaseY, false, Clamp4, Flag2 )

                    if Entry9 and not Entry9.pistol then
                        local Value5
                        local ARMS = Clips.ARMS
                        Value5 = nil

                        for Value6 in ARMS, nil, nil do
                            local J2 = J( Value, Table14[ Value6 ] or "", Value6 )

                            if J2 then
                                local Entry11
                                local SetT = AnimWorkers.setT
                                local GetT = AnimWorkers.getT( J2 )
                                local Entry10 = Config.Poses.Low[ Value6 ]
                                Entry11 = if Entry10 then Entry10 else CFrame.identity
                                SetT( J2, GetT:Lerp( Entry11, Clamp4 ) )
                            end
                        end

                        local SetC0 = AnimWorkers.setC0
                        local Joint = Entry9.joint
                        local C0 = AnimWorkers.getC0( Entry9.joint )
                        SetC0( Joint, C0:Lerp( Config.Poses.Low.Gun, Clamp4 ) )
                    end

                    Storage.Class16[ Value ] = nil
                elseif SwimTilt.EnNage( Value ) then
                    Storage.Class16[ Value ] = nil
                else
                    local State = Humanoid3:GetState( )

                    if Humanoid3.Sit or Humanoid3.SeatPart or State == Enum.HumanoidStateType.Seated then
                        Storage.Class16[ Value ] = nil
                    elseif IsClimbing( Value, Humanoid3, State ) then
                        Storage.Class16[ Value ] = {
                            wasGrounded = false,
                            prevVy = HumanoidRootPart3.AssemblyLinearVelocity.Y
                        }
                    else
                        local Flag3

                        if State == Enum.HumanoidStateType.Freefall then
                            Flag3 = true
                        elseif State == Enum.HumanoidStateType.Jumping then
                            Flag3 = true
                        else
                            Flag3 = false
                        end

                        local WasGrounded

                        if FrameCache.Floor( Humanoid3 ) == Enum.Material.Air then
                            if Value ~= Character or Flag3 or not ( math.abs( HumanoidRootPart3.AssemblyLinearVelocity.Y ) < 1.5 ) then
                                WasGrounded = Storage.GroundedNear( Value, HumanoidRootPart3, Humanoid3 )
                            else
                                WasGrounded = true
                            end
                        else
                            WasGrounded = true
                        end

                        local Entry13
                        local Entry12 = Storage.Class16[ Value ]
                        Entry13 = if Entry12 then Entry12 else { wasGrounded = true }
                        Storage.Class16[ Value ] = Entry13
                        local PrevVy = HumanoidRootPart3.AssemblyLinearVelocity.Y

                        if Entry13.active then
                            Entry13.age = Entry13.age + ClipsInner

                            if Entry13.landed then
                                local Number
                                local AssemblyLinearVelocity = HumanoidRootPart3.AssemblyLinearVelocity
                                local T = Entry13.t
                                local X = AssemblyLinearVelocity.X
                                Number = not ( Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude > 4 ) and 1 or 1.7
                                Entry13.t = T + ClipsInner * Number
                            else
                                Entry13.t = math.min( Entry13.t + ClipsInner, 0.58 )

                                if WasGrounded and Entry13.age > 0.15 then
                                    Entry13.landed = true
                                    Entry13.t = math.max( Entry13.t, 0.6 )
                                end
                            end

                            local T2 = Entry13.t

                            if Clips.Jump.length <= T2 then
                                Entry13.active = false
                            else
                                local Flag5
                                local Sample4, Sample23, Sample32 = Clips.Sample( Clips.Jump, Entry13.t )
                                local Clamp5 = math.clamp( Entry13.age / 0.06, 0, 1 )
                                local Clamp6 = Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 )
                                local Clamp7 = math.clamp( ( Entry13.t - ( Clips.Jump.length - 0.1 ) ) / 0.1, 0, 1 )
                                local Clamp8 = Clamp6 * ( 1 - Clamp7 * Clamp7 * ( 3 - 2 * Clamp7 ) )
                                local BaseY2 = Clips.Jump.baseY
                                Flag5 = if Entry9 == nil then true else Entry9.free
                                Storage.ApplyClip( Value, Sample4, Sample23, Sample32, BaseY2, true, Clamp8, Flag5 )
                            end
                        else
                            local Flag4

                            if PrevVy > 12 then
                                if PrevVy - ( Entry13.prevVy or PrevVy ) > 15 then
                                    Flag4 = true
                                else
                                    Flag4 = false
                                end
                            else
                                Flag4 = false
                            end
                            if not WasGrounded and PrevVy > 12 then
                                if Entry13.wasGrounded or Flag4 then
                                    Entry13.active = true
                                    Entry13.t = 0.07
                                    Entry13.landed = false
                                    Entry13.age = 0
                                end
                            end
                        end

                        Entry13.wasGrounded = WasGrounded
                        Entry13.prevVy = PrevVy

                        if Value == Character then
                            local JumpBusy = Entry13.active == true and true or false
                            ClientState.JumpBusy = JumpBusy
                        end
                    end
                end
            end
        else
            Storage.Class16[ Value ] = nil
        end
    end
end

Storage.VectorToWorldSpace = Inverse:VectorToWorldSpace( Vector3.new( 1, 0, 0 ) )

Storage.UpdateKick = function( Argument1, Argument2, KickShot, Clips, Argument5 )
    local Speed = Argument5 and Argument5.Speed or 3.2
    local KickShot2
    local Speed2 = 6.283185307179586 * Speed

    if KickShot then
        KickShot2 = KickShot:GetAttribute( "ShotFX" )
    else
        KickShot2 = KickShot
    end
    if Argument1.kickInit then
        if KickShot2 and KickShot2 ~= Argument1.kickShot then
            Argument1.kickShot = KickShot2
            Argument1.kickV = ( Argument1.kickV or 0 ) + Speed2 * 2.718281828459045
        end
    else
        Argument1.kickInit = true
        Argument1.kickShot = KickShot2
    end

    local KickX = Argument1.kickX or 0
    local KickV = Argument1.kickV or 0
    local Clamp = math.clamp( math.ceil( Clips * 240 ), 1, 16 )
    local Clamp2 = Clips / Clamp
    local I = 1

    for I = 1, Clamp do
        local KickV2 = KickV + ( -2 * Speed2 * KickV - Speed2 * Speed2 * KickX ) * Clamp2
        KickX = KickX + KickV2 * Clamp2
        KickV = KickV2
    end

    local DebugKick

    if Argument2 == Character then
        DebugKick = LocalPlayer:GetAttribute( "DebugKick" )
    else
        DebugKick = false
    end
    if DebugKick then
        KickX = DebugKick
        KickV = 0
    end

    Argument1.kickX = KickX
    Argument1.kickV = KickV
    return KickX
end

Storage.PistolReload = Config.Poses.PistolReload
Storage.Table25 = {
    { "RightUpperArm", "RightShoulder" },
    { "RightLowerArm", "RightElbow" },
    { "RightHand", "RightWrist" },
    { "LeftUpperArm", "LeftShoulder" },
    { "LeftLowerArm", "LeftElbow" },
    { "LeftHand", "LeftWrist" }
}
Storage.Class17 = setmetatable( { }, { __mode = "k" } )

Storage.Seg = function( Argument1, Argument2, Argument3 )
    local Clamp = math.clamp( ( Argument1 - Argument2 ) / ( Argument3 - Argument2 ), 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

Storage.Table26 = {
    { "UpperArm", "Shoulder" },
    { "LowerArm", "Elbow" },
    { "Hand", "Wrist" }
}
Storage.Table27 = { "Right", "Left" }

Storage.ArmTo = function( Key22, Text, UpperTorsoWorld, Argument4, Amount )
    if Amount <= 0.001 then
        return
    end

    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Storage.Table26, nil, nil do
        local J2 = J( Key22, Text .. Value[ 1 ], Text .. Value[ 2 ] )

        if J2 then
            Table[ J2 ] = AnimWorkers.getT( J2 )
        end
    end

    local CurrentPole = ArmIK.CurrentPole
    local CurrentPole2 = CurrentPole( Key22, Text, UpperTorsoWorld, Argument4.Position )

    if not CurrentPole2 then
        return
    end

    ArmIK.Solve( Key22, Text, UpperTorsoWorld, Argument4, CurrentPole2 )

    if Amount < 0.999 then
        local Value2 = nil

        for Key2, Value3 in Table, nil, nil do
            local SetT = AnimWorkers.setT
            SetT( Key2, Value3:Lerp( AnimWorkers.getT( Key2 ), Amount ) )
        end
    end
end

Storage.Table28 = {
    { 0, "Prise" },
    { 0.08, "Prise" },
    { 0.26, "Chemin" },
    { 0.42, "Rangement" },
    { 0.5, "Rangement" },
    { 0.66, "Chemin" },
    { 0.84, "Prise" },
    { 1, "Prise" }
}

Storage.CrJoint = function( JointName, Sin )
    local Number
    local Count = #Storage.Table28
    Number = 1

    while Number < Count - 1 do
        if not ( Storage.Table28[ Number + 1 ][ 1 ] <= Sin ) then
            break
        end

        Number = Number + 1
    end

    local Item3
    local Entry = Storage.Table28[ Number ]
    local Entry2 = Storage.Table28[ Number + 1 ]
    local Item = Entry[ 1 ]
    local Item2 = Entry2[ 1 ]
    local Entry3 = Storage.PistolReload[ Entry[ 2 ] ][ JointName ]
    local Entry4 = Storage.PistolReload[ Entry2[ 2 ] ][ JointName ]
    local Entry5 = Storage.Table28[ Number - 1 ]
    local Entry6 = Storage.Table28[ Number + 2 ]
    Item3 = Entry5 and Entry5[ 1 ] or Item - ( Item2 - Item )
    local Entry9

    if Entry5 then
        local Entry7 = Storage.PistolReload[ Entry5[ 2 ] ][ JointName ]

        if Entry7 then
            Entry9 = Entry7
        else
            Entry9 = Entry3
        end
    else
        Entry9 = Entry3
    end

    local Item4 = Entry6 and Entry6[ 1 ] or Item2 + ( Item2 - Item )
    local Entry10

    if Entry6 then
        local Entry8 = Storage.PistolReload[ Entry6[ 2 ] ][ JointName ]

        if Entry8 then
            Entry10 = Entry8
        else
            Entry10 = Entry4
        end
    else
        Entry10 = Entry4
    end

    local Clamp = math.clamp( Sin, Item, Item2 )
    local Lerp = Entry9:Lerp( Entry3, ( Clamp - Item3 ) / ( Item - Item3 ) )
    local Lerp2 = Entry3:Lerp( Entry4, ( Clamp - Item ) / ( Item2 - Item ) )
    local Lerp3 = Entry4:Lerp( Entry10, ( Clamp - Item2 ) / ( Item4 - Item2 ) )
    return Lerp:Lerp( Lerp2, ( Clamp - Item3 ) / ( Item2 - Item3 ) ):Lerp( Lerp2:Lerp( Lerp3, ( Clamp - Item ) / ( Item4 - Item ) ), ( Clamp - Item ) / ( Item2 - Item ) )
end

Storage.Bump = function( Argument1, Argument2, Argument3 )
    local Total = ( Argument1 - Argument2 ) / Argument3

    if Total <= 0 or Total >= 1 then
        return 0
    end
    local Sin = math.sin( Total * 3.141592653589793 )
    return Sin * Sin
end

if Storage.PistolReload then
    Storage.VectorToWorldSpace2 = Storage.PistolReload.GunInHand:VectorToWorldSpace( Vector3.new( 0, 0, -1 ) )

    if Storage.VectorToWorldSpace2 then
        Storage.VectorToWorldSpace3 = Storage.VectorToWorldSpace2
    else
        Storage.VectorToWorldSpace3 = Vector3.new( 0, 0, -1 )
    end
else
    Storage.VectorToWorldSpace3 = Vector3.new( 0, 0, -1 )
end

Storage.ReloadStyle = function( Amount )
    local Number
    local Clamp = math.clamp( ( Amount - 0.02 ) / 0.14, 0, 1 )
    local Clamp2 = 24 * ( Clamp * Clamp * ( 3 - 2 * Clamp ) )
    local Clamp3 = math.clamp( ( Amount - 0.24 ) / 0.18, 0, 1 )
    local Clamp4 = Clamp2 - 12 * ( Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
    local Clamp5 = math.clamp( ( Amount - 0.58 ) / 0.20000000000000007, 0, 1 )
    local Clamp6 = Clamp4 + 12 * ( Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 ) )
    local Clamp7 = math.clamp( ( Amount - 0.84 ) / 0.14, 0, 1 )
    local Clamp8 = Clamp6 - 24 * ( Clamp7 * Clamp7 * ( 3 - 2 * Clamp7 ) )
    local Total = ( Amount - 0.8 ) / 0.14

    if Total <= 0 or Total >= 1 then
        Number = 0
    else
        local Sin = math.sin( Total * 3.141592653589793 )
        Number = Sin * Sin
    end

    local Number2
    local Total2 = ( Amount - 0.89 ) / 0.08

    if Total2 <= 0 or Total2 >= 1 then
        Number2 = 0
    else
        local Sin2 = math.sin( Total2 * 3.141592653589793 )
        Number2 = Sin2 * Sin2
    end

    local Number3
    local Total3 = ( Amount - 0.06 ) / 0.16

    if Total3 <= 0 or Total3 >= 1 then
        Number3 = 0
    else
        local Sin3 = math.sin( Total3 * 3.141592653589793 )
        Number3 = Sin3 * Sin3
    end

    return Clamp8 * 1, Number, Number2, Number3
end

Storage.PrTime = function( Amount )
    return Amount + math.sin( 6.283185307179586 * Amount ) * 0.35 / 6.283185307179586
end

Storage.PistolReload2 = function( ReloadName, Argument2, Amount3, Clips )
    if not Storage.PistolReload then
        return
    end

    local Value5
    local Clamp = math.clamp( Amount3 / 0.08, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    local Clamp3 = math.clamp( ( Amount3 - 0.92 ) / 0.08, 0, 1 )
    local Clamp4 = Clamp2 * ( 1 - Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
    local Sin = Amount3 + math.sin( 6.283185307179586 * Amount3 ) * 0.35 / 6.283185307179586
    local Value1, Value2, Value3, Value4 = Storage.ReloadStyle( Sin )
    local Table = {
        RightWrist = CFrame.fromAxisAngle( Storage.VectorToWorldSpace3, ( math.rad( Value1 ) ) ),
        RightShoulder = CFrame.Angles( math.rad( 4 * Value2 + 2 * Value3 ), 0, 0 ),
        RightElbow = CFrame.Angles( math.rad( -3 * Value3 ), 0, 0 ),
        LeftShoulder = CFrame.Angles( math.rad( 6 * Value2 - 6 * Value4 ), 0, 0 )
    }
    Value5 = nil

    for Key, Value in Storage.Table25, nil, nil do
        local J2 = J( ReloadName, Value[ 1 ], Value[ 2 ] )

        if J2 and Storage.PistolReload.Prise[ Value[ 2 ] ] then
            local Entry2
            local Value7 = Storage.CrJoint( Value[ 2 ], Sin )
            local Entry = Table[ Value[ 2 ] ]
            Entry2 = if Entry then Entry else CFrame.identity
            local PrSmooth2
            local Entry3 = Value7 * Entry2
            local PrSmooth = Argument2.prSmooth
            PrSmooth2 = if PrSmooth then PrSmooth else { }
            local Lerp2
            Argument2.prSmooth = PrSmooth2
            local Entry4 = Argument2.prSmooth[ Value[ 2 ] ]

            if not Entry4 or not Clips then
                Lerp2 = Entry3
            else
                local Lerp = Entry4:Lerp( Entry3, 1 - math.exp( -30 * Clips ) )

                if Lerp then
                    Lerp2 = Lerp
                else
                    Lerp2 = Entry3
                end
            end

            local PrSmooth3 = Argument2.prSmooth
            PrSmooth3[ Value[ 2 ] ] = Lerp2
            local SetT = AnimWorkers.setT
            SetT( J2, AnimWorkers.getT( J2 ):Lerp( Lerp2, Clamp4 ) )
        end
    end

    local UpperTorsoWorld = ArmIK.UpperTorsoWorld( ReloadName )

    if UpperTorsoWorld then
        local _, _, ArmWorld3 = ArmIK.ArmWorld( ReloadName, "Right", UpperTorsoWorld )

        if ArmWorld3 then
            local SetC0 = AnimWorkers.setC0
            local Joint = Argument2.joint
            local C0 = AnimWorkers.getC0( Argument2.joint )
            SetC0( Joint, C0:Lerp( UpperTorsoWorld:ToObjectSpace( ArmWorld3 * Storage.PistolReload.GunInHand ), Clamp4 ) )
        end
    end

    local Table2 = {
        d = 0,
        slide = 0,
        handToMag = Storage.PistolReload.MagInHand,
        weapon = Argument2.weapon
    }

    if not ( Sin >= 0.1 ) or not ( Sin < 0.42 ) then
        if not ( Sin >= 0.42 ) or not ( Sin < 0.47 ) then
            if Sin >= 0.47 and Sin < 0.84 then
                Table2.inHand = true
            end
        else
            Table2.hidden = true
        end
    else
        Table2.inHand = true
    end

    local Number
    local Sin2 = ( Sin - 0.87 ) / 0.08

    if Sin2 <= 0 or Sin2 >= 1 then
        Number = 0
    else
        local Sin3 = math.sin( Sin2 * 3.141592653589793 )
        Number = Sin3 * Sin3
    end

    Table2.slide = 0.18 * Number
    Storage.Class17[ ReloadName ] = Table2
end

Storage.CFrame5 = CFrame.new( 0.05, 0.1, 0 ) * CFrame.Angles( 0.10471975511965978, 0, -0.5585053606381855 )
Storage.Angles2 = CFrame.Angles( 0, 0, -0.3141592653589793 )

Storage.ShellEase = function( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

Storage.ShellHand = function( Argument1, Argument2, Argument3 )
    local Shell = Argument1.shell
    local ReloadT = Argument1.reloadT
    local Rotation = Argument3.Rotation
    local CFrame2 = CFrame.new( Vector3.new( 0.05999999865889549, -0.07999999821186066, -0.7799999713897705 ) ) * Rotation
    local CFrame3 = CFrame.new( Vector3.new( 0.019999999552965164, -0.3799999952316284, -0.699999988079071 ) ) * Rotation
    local CFrame4 = CFrame.new( Argument2:Inverse( ) * Vector3.new( -0.550000011920929, -1.100000023841858, -0.3499999940395355 ) ) * Rotation * CFrame.Angles( 0, 0, 0.4363323129985824 )

    if ReloadT < Shell.Start then
        local Clamp = math.clamp( ReloadT / Shell.Start, 0, 1 )
        return Argument3:Lerp( CFrame3, Clamp * Clamp * ( 3 - 2 * Clamp ) )
    end

    local ReloadT2 = ( ReloadT - Shell.Start ) % Shell.Each / Shell.Each

    if ReloadT2 < 0.35 then
        local Clamp2 = math.clamp( ReloadT2 / 0.35, 0, 1 )
        return CFrame3:Lerp( CFrame4, Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 ) )
    end
    if ReloadT2 < 0.48 then
        return CFrame4 * CFrame.new( 0, math.sin( ( ReloadT2 - 0.35 ) / 0.13 * 3.141592653589793 ) * -0.06, 0 )
    end
    if ReloadT2 < 0.72 then
        local Clamp3 = math.clamp( ( ReloadT2 - 0.48 ) / 0.24, 0, 1 )
        return CFrame4:Lerp( CFrame3, Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
    end
    if ReloadT2 < 0.84 then
        local Clamp4 = math.clamp( ( ReloadT2 - 0.72 ) / 0.12, 0, 1 )
        return CFrame3:Lerp( CFrame2, Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 ) )
    end
    local Clamp5 = math.clamp( ( ReloadT2 - 0.84 ) / 0.16, 0, 1 )
    return CFrame2:Lerp( CFrame3, Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 ) )
end

Storage.RPGReload = Config.Poses.RPGReload
Storage.Table29 = {
    { 0, "Clip" },
    { 0.07, "Clip" },
    { 0.22, "Aller" },
    { 0.36, "Dos" },
    { 0.43, "Dos" },
    { 0.52, "Aller" },
    { 0.62, "Chemin" },
    { 0.72, "Insertion" },
    { 0.78, "Insertion" },
    { 0.88, "Clip" },
    { 1, "Clip" }
}
Storage.Class18 = setmetatable( { }, { __mode = "k" } )

Storage.CrKeys = function( List, List2, KeysName, Sin )
    local Number
    local Count = #List
    Number = 1

    while Number < Count - 1 do
        if not ( List[ Number + 1 ][ 1 ] <= Sin ) then
            break
        end

        Number = Number + 1
    end

    local Item3
    local Entry = List[ Number ]
    local Entry2 = List[ Number + 1 ]
    local Item = Entry[ 1 ]
    local Item2 = Entry2[ 1 ]
    local Entry3 = List2[ Entry[ 2 ] ][ KeysName ]
    local Entry4 = List2[ Entry2[ 2 ] ][ KeysName ]
    local Entry5 = List[ Number - 1 ]
    local Entry6 = List[ Number + 2 ]
    Item3 = Entry5 and Entry5[ 1 ] or Item - ( Item2 - Item )
    local Entry9

    if Entry5 then
        local Entry7 = List2[ Entry5[ 2 ] ][ KeysName ]

        if Entry7 then
            Entry9 = Entry7
        else
            Entry9 = Entry3
        end
    else
        Entry9 = Entry3
    end

    local Item4 = Entry6 and Entry6[ 1 ] or Item2 + ( Item2 - Item )
    local Entry10

    if Entry6 then
        local Entry8 = List2[ Entry6[ 2 ] ][ KeysName ]

        if Entry8 then
            Entry10 = Entry8
        else
            Entry10 = Entry4
        end
    else
        Entry10 = Entry4
    end

    local Clamp = math.clamp( Sin, Item, Item2 )
    local Lerp = Entry9:Lerp( Entry3, ( Clamp - Item3 ) / ( Item - Item3 ) )
    local Lerp2 = Entry3:Lerp( Entry4, ( Clamp - Item ) / ( Item2 - Item ) )
    local Lerp3 = Entry4:Lerp( Entry10, ( Clamp - Item2 ) / ( Item4 - Item2 ) )
    return Lerp:Lerp( Lerp2, ( Clamp - Item3 ) / ( Item2 - Item3 ) ):Lerp( Lerp2:Lerp( Lerp3, ( Clamp - Item ) / ( Item4 - Item ) ), ( Clamp - Item ) / ( Item2 - Item ) )
end

Storage.RocketInHand = function( Sin )
    local Number = 1

    while Number < #Storage.Table29 - 1 do
        if not ( Storage.Table29[ Number + 1 ][ 1 ] <= Sin ) then
            break
        end

        Number = Number + 1
    end

    local Entry = Storage.Table29[ Number ]
    local Entry2 = Storage.Table29[ Number + 1 ]
    return Storage.RPGReload.RocketInHand[ Entry[ 2 ] ]:Lerp( Storage.RPGReload.RocketInHand[ Entry2[ 2 ] ], ( math.clamp( ( Sin - Entry[ 1 ] ) / ( Entry2[ 1 ] - Entry[ 1 ] ), 0, 1 ) ) )
end

Storage.RpgReload = function( ReloadName, Argument2, Amount, Clips )
    if not Storage.RPGReload then
        return
    end

    local RrSmooth2
    local Clamp = math.clamp( Amount / 0.1, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    local Clamp3 = math.clamp( ( Amount - 0.9 ) / 0.1, 0, 1 )
    local Clamp4 = Clamp2 * ( 1 - Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
    local Sin = Amount + math.sin( 6.283185307179586 * Amount ) * 0.35 / 6.283185307179586
    local RrSmooth = Argument2.rrSmooth
    RrSmooth2 = if RrSmooth then RrSmooth else { }
    local Value1
    Argument2.rrSmooth = RrSmooth2
    Value1 = nil

    for Key, Value in Storage.Table25, nil, nil do
        local J2 = J( ReloadName, Value[ 1 ], Value[ 2 ] )

        if J2 and Storage.RPGReload.Clip[ Value[ 2 ] ] then
            local Lerp2
            local Value3 = Storage.CrKeys( Storage.Table29, Storage.RPGReload, Value[ 2 ], Sin )
            local Entry = Argument2.rrSmooth[ Value[ 2 ] ]

            if not Entry or not Clips then
                Lerp2 = Value3
            else
                local Lerp = Entry:Lerp( Value3, 1 - math.exp( -30 * Clips ) )

                if Lerp then
                    Lerp2 = Lerp
                else
                    Lerp2 = Value3
                end
            end

            local RrSmooth3 = Argument2.rrSmooth
            RrSmooth3[ Value[ 2 ] ] = Lerp2
            local SetT = AnimWorkers.setT
            SetT( J2, AnimWorkers.getT( J2 ):Lerp( Lerp2, Clamp4 ) )
        end
    end

    local UpperTorsoWorld = ArmIK.UpperTorsoWorld( ReloadName )

    if UpperTorsoWorld then
        local _, _, ArmWorld3 = ArmIK.ArmWorld( ReloadName, "Right", UpperTorsoWorld )

        if ArmWorld3 then
            local SetC0 = AnimWorkers.setC0
            local Joint = Argument2.joint
            local C0 = AnimWorkers.getC0( Argument2.joint )
            SetC0( Joint, C0:Lerp( UpperTorsoWorld:ToObjectSpace( ArmWorld3 * Storage.RPGReload.GunInHand ), Clamp4 ) )
        end
    end

    local Rocket
    local Table = { weapon = Argument2.weapon }

    if Sin < 0.38 then
        Rocket = "hidden"
    elseif Sin < 0.88 then
        Rocket = "hand"
    else
        Rocket = "tube"
    end

    Table.rocket = Rocket
    Table.handToRocket = Storage.RocketInHand( Sin )
    Storage.Class18[ ReloadName ] = Table
end

Storage.Value11 = nil

Storage.RunGunMean = function()
    if Storage.Value11 then
        return Storage.Value11
    end

    local Lerp
    local I = 0
    Lerp = nil

    for I = 0, 23 do
        local Lerp3
        local Sample = RunGait.Sample
        local Gun = Sample( I / 24, 1 ).Gun

        if Lerp then
            local Lerp2 = Lerp:Lerp( Gun, 1 / ( I + 1 ) )

            if Lerp2 then
                Lerp3 = Lerp2
            else
                Lerp3 = Gun
            end
        else
            Lerp3 = Gun
        end

        Lerp = Lerp3
    end

    local Lerp4 = if Lerp then Lerp else CFrame.identity
    Storage.Value11 = Lerp4
    return Storage.Value11
end

Storage.PreSimulation = function( Clips )
    local Storage = { }
    local Min = math.min( Clips, 0.03333333333333333 )
    Character = LocalPlayer.Character
    AnimWorkers.SetMyChar( Character )
    local TestAnimBrute = workspace:GetAttribute( "TestAnimBrute" )

    if AnimWorkers.IsWorker then
        local AnimatedChars2 = AnimatedChars( )

        if AnimatedChars2 then
            Storage.Captured2 = AnimatedChars2
        else
            AnimatedChars( )
            Storage.Captured2 = Table11
        end
    else
        AnimatedChars( )
        Storage.Captured2 = Table11
    end

    local Value2 = nil

    for Key, Value in Storage.Captured2, nil, nil do
        Storage.Entry16 = Class2[ Value ]

        if Storage.Entry16 then
            Storage.Entry17 = Storage.Entry16
        else
            Storage.Entry17 = NewCache( Value )
        end
        Storage.Entry18 = Storage.Entry17[ Table5 ]

        if Storage.Entry18 then
            Storage.Entry19 = Storage.Entry18
        else
            Storage.Table8 = { }
            Storage.Entry17[ Table5 ] = Storage.Table8
            Storage.Entry19 = Storage.Table8
        end
        Storage.HumanoidRootPart = Storage.Entry19.HumanoidRootPart

        if not Storage.HumanoidRootPart or Storage.HumanoidRootPart.Parent ~= Value then
            Storage.HumanoidRootPart2 = Value:FindFirstChild( "HumanoidRootPart" )
            Storage.Entry19.HumanoidRootPart = Storage.HumanoidRootPart2
            Storage.HumanoidRootPart3 = Storage.HumanoidRootPart2
        else
            Storage.HumanoidRootPart3 = Storage.HumanoidRootPart
        end
        Storage.Entry20 = Class2[ Value ]

        if Storage.Entry20 then
            Storage.Entry21 = Storage.Entry20
        else
            Storage.Entry21 = NewCache( Value )
        end
        Storage.Entry22 = Storage.Entry21[ Table5 ]

        if Storage.Entry22 then
            Storage.Entry23 = Storage.Entry22
        else
            Storage.Table9 = { }
            Storage.Entry21[ Table5 ] = Storage.Table9
            Storage.Entry23 = Storage.Table9
        end
        Storage.Humanoid = Storage.Entry23[ "@Humanoid" ]

        if not Storage.Humanoid or Storage.Humanoid.Parent ~= Value then
            Storage.Humanoid2 = Value:FindFirstChildOfClass( "Humanoid" )
            Storage.Entry23[ "@Humanoid" ] = Storage.Humanoid2
            Storage.Humanoid3 = Storage.Humanoid2
        else
            Storage.Humanoid3 = Storage.Humanoid
        end
        Storage.Entry24 = Class2[ Value ]

        if Storage.Entry24 then
            Storage.Entry25 = Storage.Entry24
        else
            Storage.Entry25 = NewCache( Value )
        end
        Storage.Entry26 = Storage.Entry25[ Table5 ]

        if Storage.Entry26 then
            Storage.Entry27 = Storage.Entry26
        else
            Storage.Table10 = { }
            Storage.Entry25[ Table5 ] = Storage.Table10
            Storage.Entry27 = Storage.Table10
        end
        Storage.LowerTorso5 = Storage.Entry27.LowerTorso

        if not Storage.LowerTorso5 or Storage.LowerTorso5.Parent ~= Value then
            Storage.LowerTorso6 = Value:FindFirstChild( "LowerTorso" )
            Storage.Entry27.LowerTorso = Storage.LowerTorso6
            Storage.LowerTorso7 = Storage.LowerTorso6
        else
            Storage.LowerTorso7 = Storage.LowerTorso5
        end

        if Storage.LowerTorso7 then
            Storage.LowerTorso8 = J( Value, "LowerTorso", "Root" )
        else
            Storage.LowerTorso8 = Storage.LowerTorso7
        end
        if Storage.HumanoidRootPart3 and Storage.Humanoid3 and Storage.LowerTorso8 then

            if AnimWorkers.IsWorker then
                Storage.Get5 = SwimTilt.Get( Value )
            else
                Storage.Entry28 = Class5[ Value ]

                if Value == Character then
                    if Storage.Humanoid3:GetState( ) == Enum.HumanoidStateType.Swimming then
                        Storage.Flag8 = true
                    else
                        Storage.Flag8 = false
                    end
                else
                    Storage.Flag8 = nil
                end

                if Storage.Entry28 == nil then
                    Storage.AimOf = false
                elseif Storage.Entry28.stance == "Aim" then
                    Storage.AimOf = true
                elseif Storage.Entry28.stance == "ReloadAim" then
                    Storage.AimOf = true
                else
                    Storage.AimOf = false
                end
                if not AnimWorkers.Owns( Value ) then
                    Storage.AimOf = AnimWorkers.AimOf( Value )
                end

                Storage.Get5 = SwimTilt.Update( Value, Storage.HumanoidRootPart3, Storage.Humanoid3, Storage.AimOf, Storage.Flag8 )
            end
            if Storage.Get5 and AnimWorkers.Owns( Value ) then
                Storage.SetT10 = AnimWorkers.setT
                Storage.Root2 = SwimTilt.Root
                Storage.SetT10( Storage.LowerTorso8, Storage.Root2( Storage.Get5, ( ArmIK.Frames( Storage.LowerTorso8 ) ) ) * AnimWorkers.getT( Storage.LowerTorso8 ) )
            end
        end
    end

    local Value3 = nil

    for Value4 in Class9, nil, nil do
        if not Class5[ Value4 ] and Value4.Parent then
            Storage.Flag7 = List[ Value4 ] ~= false and true or false

            if Storage.Flag7 and not Value4:GetAttribute( "DanceStart" ) then
                ApplyBare( Value4 )
            end
        end
    end

    local Value5 = nil

    for Key2, Value6 in Class12, nil, nil do
        Storage.Flag6 = List[ Key2 ] ~= false and true or false

        if Storage.Flag6 then
            UpdateHolster( Key2, Value6, Clips )
        end
    end

    local Value7 = nil

    for Key3, Value8 in Class5, nil, nil do
        if Key3.Parent and Value8.handle and Value8.root then
            local Flag4 = List[ Key3 ] ~= false and true or false

            if Flag4 then
                local Entry4
                local Root = Value8.root
                local Entry3 = Class2[ Key3 ]

                if Entry3 then
                    Entry4 = Entry3
                else
                    Entry4 = NewCache( Key3 )
                end

                local Entry6
                local Entry5 = Entry4[ Table5 ]

                if Entry5 then
                    Entry6 = Entry5
                else
                    local Table2 = { }
                    Entry4[ Table5 ] = Table2
                    Entry6 = Table2
                end

                local LowerTorso3
                local LowerTorso = Entry6.LowerTorso

                if not LowerTorso or LowerTorso.Parent ~= Key3 then
                    local LowerTorso2 = Key3:FindFirstChild( "LowerTorso" )
                    Entry6.LowerTorso = LowerTorso2
                    LowerTorso3 = LowerTorso2
                else
                    LowerTorso3 = LowerTorso
                end

                local LowerTorso4

                if LowerTorso3 then
                    LowerTorso4 = J( Key3, "LowerTorso", "Root" )
                else
                    LowerTorso4 = LowerTorso3
                end
                if LowerTorso4 then
                    local Min2

                    if Value8.drawDur then
                        local DebugDrawU
                        Min2 = math.min( 1, ( Class13[ Key3 ] or 0 ) + Clips / Value8.drawDur )

                        if Key3 == Character then
                            DebugDrawU = LocalPlayer:GetAttribute( "DebugDrawU" )
                        else
                            DebugDrawU = false
                        end
                        if DebugDrawU then
                            Min2 = DebugDrawU
                        end

                        Class13[ Key3 ] = Min2
                    else
                        Min2 = 1
                    end

                    if Min2 < 1 then
                        local Value23
                        ApplyBare( Key3 )
                        local Table3 = { }
                        Value23 = nil

                        for Key8, Value24 in Table14, nil, nil do
                            local J4 = J( Key3, Value24, Key8 )

                            if J4 then
                                Table3[ J4 ] = AnimWorkers.getT( J4 )
                            end

                            Storage.Table5 = Table3
                        end

                        Storage.Table5 = Table3
                    else
                        Storage.Table5 = nil
                    end
                    if Value8.free and Min2 >= 1 then
                        ApplyBare( Key3 )
                    end

                    local PoseW = Value8.poseW

                    if TestAnimBrute then
                        PoseW = 0
                    end

                    local Number2 = ( Value8.stance == "Aim" or Value8.stance == "ReloadAim" ) and 1 or 0
                    local HasFastRun
                    Value8.aimPitchW = ( Value8.aimPitchW or Number2 ) + ( Number2 - ( Value8.aimPitchW or Number2 ) ) * ( 1 - math.exp( -12 * Clips ) )
                    local Pitch = Value8.pitch * Value8.aimPitchW
                    local Amount2 = -Value8.twist
                    local Angles = CFrame.Angles( 0, Amount2, 0 ) * CFrame.Angles( Pitch, 0, 0 ) * CFrame.Angles( 0, -Amount2, 0 )

                    if ( Value8.runW or 0 ) >= 0.999 then
                        local NotOwnPose = not Value8.ownPose

                        if NotOwnPose then
                            if RunCycle == nil then
                                HasFastRun = false
                            else
                                local UseFastRun = RunCycle.UseFastRun

                                if UseFastRun then
                                    HasFastRun = RunGait.HasFastRun( )
                                else
                                    HasFastRun = UseFastRun
                                end
                            end
                        else
                            HasFastRun = NotOwnPose
                        end
                    else
                        HasFastRun = false
                    end
                    if PoseW > 0.001 and not HasFastRun then
                        local Value26
                        local Frames, Frames2 = ArmIK.Frames( LowerTorso4 )
                        local CFrame2Inner = Root.CFrame * Frames * AnimWorkers.getT( LowerTorso4 ) * Frames2:Inverse( )
                        local _, Get2 = SwimTilt.Get( Key3 )
                        Value26 = nil

                        for Key9, Value27 in Table4, nil, nil do
                            if Key9 ~= "Neck" then
                                local J6 = J( Key3, Value27, Key9 )

                                if J6 then
                                    local GetT2 = AnimWorkers.getT( J6 )
                                    local Entry7 = Value8.joints[ Key9 ]

                                    if Key9 == "Waist" then
                                        local Waist
                                        local Frames3, Frames22 = ArmIK.Frames( J6 )
                                        local Get4 = BodyLife.Get( Key3 )
                                        Waist = Get4 and Get4.waist or CFrame.identity
                                        local Get22
                                        local Rotation = Root.CFrame.Rotation
                                        Get22 = if Get2 then Get2 else CFrame.identity
                                        local Rotation2 = Rotation * Get22 * Waist * Angles * Value8.joints.Waist
                                        Entry7 = ( CFrame2Inner * Frames3 ).Rotation:Inverse( ) * Rotation2 * Frames22.Rotation
                                    end

                                    local Lerp2

                                    if not ( PoseW >= 0.999 ) or not Entry7 then
                                        Lerp2 = GetT2:Lerp( Entry7, PoseW )
                                    else
                                        Lerp2 = Entry7
                                    end
                                    if Key9 == "Waist" and ( Value8.runW or 0 ) > 0 then
                                        Lerp2 = Lerp2:Lerp( GetT2, Value8.runW )
                                    end

                                    AnimWorkers.setT( J6, Lerp2 )
                                end
                            end
                        end

                        local J5 = J( Key3, "Head", "Neck" )

                        if J5 then
                            local Neck
                            local GetT = AnimWorkers.getT( J5 )
                            local Get3 = BodyLife.Get( Key3 )
                            Neck = Get3 and Get3.neck or CFrame.identity
                            local Lerp
                            local Neck2 = Neck * Value8.joints.Neck

                            if not ( PoseW >= 0.999 ) or not Neck2 then
                                Lerp = GetT:Lerp( Neck2, PoseW )
                            else
                                Lerp = Neck2
                            end
                            if ( Value8.runW or 0 ) > 0 then
                                Lerp = Lerp:Lerp( GetT, Value8.runW )
                            end

                            AnimWorkers.setT( J5, Lerp )
                        end
                    end

                    local Sample3
                    local RunW = Value8.runW or 0

                    if RunW > 0.001 then
                        local Sample = RunGait.Sample
                        local RunPhase = Value8.runPhase or 0
                        local Sample2 = Sample( RunPhase, Value8.runK or 1, nil, Table15 )

                        if Sample2 then
                            Sample3 = Sample2
                        else
                            Sample3 = nil
                        end
                    else
                        Sample3 = nil
                    end
                    if Sample3 then
                        local Springs2
                        local Springs = Value8.springs
                        Springs2 = if Springs then Springs else { }
                        local Value30
                        Value8.springs = Springs2
                        Value30 = nil

                        for Key10, Value31 in Table14, nil, nil do
                            local J8 = J( Key3, Value31, Key10 )

                            if J8 then
                                local Entry9
                                local Entry8 = Value8.springs[ Key10 ]
                                Entry9 = if Entry8 then Entry8 else { }
                                Value8.springs[ Key10 ] = Entry9
                                local Entry10 = Table16[ Key10 ]

                                if Entry10 ~= "Waist" then
                                    if Entry10 ~= "Arms" or Value8.ownPose then
                                        continue
                                    end
                                end

                                local Lerp4
                                local Entry11 = RunCycle.Springs[ Entry10 ]
                                local Entry12 = Sample3[ Key10 ]
                                local Spring2 = Spring( Entry9, Entry12, Min, Entry11[ 1 ], Entry11[ 2 ] )
                                local SetT4 = AnimWorkers.setT

                                if not ( RunW >= 0.999 ) or not Spring2 then
                                    Lerp4 = AnimWorkers.getT( J8 ):Lerp( Spring2, RunW )
                                else
                                    Lerp4 = Spring2
                                end

                                SetT4( J8, Lerp4 )
                            end
                        end
                        if RunCycle.UseFastRun and RunGait.HasFastRun( ) then
                            local Value32
                            local SampleFastRun = RunGait.SampleFastRun( Value8.runPhase or 0 )
                            Value32 = nil

                            for Key11, Value33 in SampleFastRun, nil, nil do
                                local J7 = J( Key3, Table14[ Key11 ] or "", Key11 )

                                if J7 then
                                    local Lerp3
                                    local SetT3 = AnimWorkers.setT

                                    if not ( RunW >= 0.999 ) or not Value33 then
                                        Lerp3 = AnimWorkers.getT( J7 ):Lerp( Value33, RunW )
                                    else
                                        Lerp3 = Value33
                                    end

                                    SetT3( J7, Lerp3 )
                                end
                            end
                        end

                        local Gun2
                        local Gun = Value8.springs.Gun
                        Gun2 = if Gun then Gun else { }
                        Value8.springs.Gun = Gun2
                        local Gun3 = Sample3.Gun
                        Sample3.Gun = Spring( Gun2, Gun3, Min, RunCycle.Springs.Gun[ 1 ], RunCycle.Springs.Gun[ 2 ] )
                    else
                        Value8.springs = nil
                        Value8.drop = nil
                    end

                    local ReloadW = Value8.reloadW or 0

                    if ReloadW > 0.001 and Table9 then
                        local Min3 = math.min( 2.75, Table9[ #Table9 ].t )
                        local UpperTorsoWorld2 = ArmIK.UpperTorsoWorld( Key3 )

                        if UpperTorsoWorld2 then
                            if not Reload.GripStart then
                                local ReloadGrip2
                                local ReloadGripInner = Value8.reloadGrip
                                ReloadGrip2 = if ReloadGripInner then ReloadGripInner else ReloadGrip( Key3, Root )
                                Value8.reloadGrip = ReloadGrip2
                            end
                            for Key12, Value38 in ReloadArms( math.clamp( ( Value8.reloadT or Min3 ) / Value8.reloadDur, 0, 1 ) * Min3, UpperTorsoWorld2, Root ) do
                                local J9 = J( Key3, Table4[ Key12 ], Key12 )

                                if J9 then
                                    local Lerp5
                                    local SetT5 = AnimWorkers.setT

                                    if not ( ReloadW >= 0.999 ) or not Value38 then
                                        Lerp5 = AnimWorkers.getT( J9 ):Lerp( Value38, ReloadW )
                                    else
                                        Lerp5 = Value38
                                    end

                                    SetT5( J9, Lerp5 )
                                end
                            end
                        end
                    end

                    local UpperTorsoWorld3 = ArmIK.UpperTorsoWorld( Key3 )

                    if UpperTorsoWorld3 then
                        if Sample3 then
                            if not RunCycle.UseFastRun or not RunGait.HasFastRun( ) then
                                local J10 = J( Key3, "Head", "Neck" )

                                if J10 then
                                    local Lerp6
                                    local Frames4, Frames23 = ArmIK.Frames( J10 )
                                    local InverseInner = ( UpperTorsoWorld3 * Frames4 ).Rotation:Inverse( ) * Root.CFrame.Rotation * Frames23.Rotation
                                    local SetT6 = AnimWorkers.setT

                                    if not ( RunW >= 0.999 ) or not InverseInner then
                                        Lerp6 = AnimWorkers.getT( J10 ):Lerp( InverseInner, RunW )
                                    else
                                        Lerp6 = InverseInner
                                    end

                                    SetT6( J10, Lerp6 )
                                end
                            end
                        end

                        local Gun4 = Value8.gun

                        if PoseW < 0.999 and not Value8.pistol then
                            local HandFit2 = HandFit( Key3, UpperTorsoWorld3 )

                            if HandFit2 then
                                local Lerp7

                                if not ( PoseW <= 0.001 ) or not HandFit2 then
                                    Lerp7 = HandFit2:Lerp( Value8.gun, PoseW )
                                else
                                    Lerp7 = HandFit2
                                end

                                Gun4 = Lerp7
                            end
                        end

                        local Lerp8, Lerp9
                        local Rh = Value8.rh
                        local Lh = Value8.lh

                        if Sample3 then
                            local Entry13 = WeaponData[ Value8.weapon ]

                            if not Entry13 or not Entry13.Handling.Poses then
                                Gun4 = Gun4:Lerp( Sample3.Gun, RunW )
                                Lerp8 = Rh:Lerp( Sample3.RightHand, RunW )
                                Lerp9 = Lh:Lerp( Sample3.LeftHand, RunW )
                            else
                                local RunGunMean2
                                local RunGunMean = Value8.runGunMean
                                RunGunMean2 = if RunGunMean then RunGunMean else Storage.RunGunMean( )
                                Value8.runGunMean = RunGunMean2
                                Gun4 = Gun4:Lerp( Gun4 * ( Value8.runGunMean:Inverse( ) * Sample3.Gun ), RunW )
                                Lerp8 = Rh
                                Lerp9 = Lh
                            end
                        else
                            Lerp8 = Rh
                            Lerp9 = Lh
                        end
                        if ReloadW > 0.001 then
                            local ReloadT7
                            local _, _, ArmWorld32 = ArmIK.ArmWorld( Key3, "Right", UpperTorsoWorld3 )
                            local ReloadT6 = Value8.reloadT
                            ReloadT7 = if ReloadT6 then ReloadT6 else Value8.reloadDur
                            local Lerp10
                            local Clamp = math.clamp( ReloadT7 / Value8.reloadDur, 0, 1 )

                            if not Reload.GripStart or not Reload.GripMid then
                                Lerp10 = nil
                            else
                                local Clamp2
                                local GripMidT = Reload.GripMidT or 0.4
                                Clamp2 = Clamp <= GripMidT and Clamp / GripMidT or 1 - ( Clamp - GripMidT ) / ( 1 - GripMidT )
                                local Clamp3 = Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 )
                                local GripStart = Reload.GripStart
                                Lerp10 = GripStart:Lerp( Reload.GripMid, Clamp3 )
                            end
                            if not Lerp10 then
                                Lerp10 = Value8.reloadGrip
                            end
                            if ArmWorld32 and Lerp10 then
                                Gun4 = Gun4:Lerp( UpperTorsoWorld3:ToObjectSpace( ArmWorld32 * Lerp10 ), ReloadW )
                            end
                        end

                        local Number3
                        local CrouchW = Value8.crouchW or 0
                        Number3 = ( not CrouchAnim.IsCrouched( Key3 ) or Value8.stance == "Aim" or Value8.stance == "ReloadAim" or Value8.free ) and 0 or 1
                        Value8.crouchW = CrouchW + ( Number3 - ( Value8.crouchW or 0 ) ) * ( 1 - math.exp( -10 * Clips ) )
                        local CrouchW2 = Value8.crouchW * ( 1 - math.min( ReloadW, 1 ) )

                        if CrouchW2 > 0.001 then
                            Gun4 = Gun4:Lerp( CFrame2 * Gun4, CrouchW2 )
                        end

                        local Flag5

                        if Value8.shell == nil then
                            Flag5 = false
                        elseif Value8.reloadT == nil then
                            Flag5 = false
                        else
                            Flag5 = true
                        end
                        local ShellW = Value8.shellW or 0
                        Storage.Number4 = not Flag5 and 0 or 1
                        Value8.shellW = ShellW + ( Storage.Number4 - ( Value8.shellW or 0 ) ) * ( 1 - math.exp( -12 * Clips ) )

                        if Value8.shellW > 0.001 then
                            Storage.Captured = Value8.stance == "ReloadAim" and Storage.Angles2 or Storage.CFrame5
                            Gun4 = Gun4:Lerp( Gun4 * Storage.Captured, Value8.shellW )
                        end

                        Storage.Progress = BoltAction.Progress( Value8.tool )

                        if Storage.Progress and Value8.stance ~= "Aim" and ReloadW < 0.5 and not BoltAction.IsPump( Value8.weapon ) then
                            Storage.Aim = Config.Poses.Aim
                            Storage.Progress2 = Storage.Progress / 0.08
                            Storage.Min4 = math.min( 1, Storage.Progress2, ( 1 - Storage.Progress ) / 0.12 )
                            Storage.Min5 = Storage.Min4 * Storage.Min4 * ( 3 - Storage.Min4 * 2 )
                            Gun4 = Gun4:Lerp( Storage.Aim.Gun, Storage.Min5 )
                            Lerp8 = Lerp8:Lerp( Storage.Aim.RightHand, Storage.Min5 )
                            Lerp9 = Lerp9:Lerp( Storage.Aim.LeftHand, Storage.Min5 )
                        end
                        if Key3 == Character then
                            Storage.Number5 = ( Value8.stance ~= "Aim" or not ( ReloadW < 0.5 ) ) and 0 or 1
                            Value8.convergeW = ( Value8.convergeW or 0 ) + ( Storage.Number5 - ( Value8.convergeW or 0 ) ) * ( 1 - math.exp( -14 * Clips ) )

                            if Value8.convergeW > 0.001 then
                                Gun4 = Gun4:Lerp( AimConverge( Key3, UpperTorsoWorld3, Gun4, Value8 ), Value8.convergeW )
                            end
                        end
                        Storage.Entry14 = WeaponData[ Value8.weapon ]
                        Storage.Entry15 = if Storage.Entry14 then WeaponData[ Value8.weapon ].Handling.Kick else Storage.Entry14
                        Storage.Value42 = Storage.UpdateKick( Value8, Key3, Value8.tool, Clips, Storage.Entry15 )

                        if Storage.Entry15 and not Storage.Entry15.Arm and Storage.Value42 > 0.0001 then
                            Gun4 = Gun4 * CFrame.new( 0, 0, ( Storage.Entry15.Back or 0 ) * Storage.Value42 ) * CFrame.Angles( math.rad( ( Storage.Entry15.Pitch or 0 ) * Storage.Value42 ), 0, 0 )
                        end
                        if Storage.Progress then
                            Storage.GunJolt = BoltAction.GunJolt
                            Gun4 = Gun4 * Storage.GunJolt( Value8.weapon, Storage.Progress )
                        end
                        Storage.SetC0 = AnimWorkers.setC0
                        Storage.SetC0( Value8.joint, Gun4 )
                        Storage.Progress3 = BoltAction.Progress( Value8.tool )
                        Storage.Lh2 = LeftShift( Value8.weapon ) * Lerp9

                        if Storage.Progress3 then
                            Storage.Hand = BoltAction.Hand
                            Storage.Hand2 = Storage.Hand( Value8.weapon, Storage.Lh2, Storage.Progress3 )
                        else
                            Storage.Hand2 = Storage.Lh2
                        end
                        if Flag5 then
                            Value8.shellHand = Storage.ShellHand( Value8, Gun4, Storage.Hand2 )
                        end
                        if not ( Value8.shellW > 0.001 ) or not Value8.shellHand then
                            if not Flag5 then
                                Value8.shellHand = nil
                            end
                        else
                            Storage.Hand2 = Storage.Hand2:Lerp( Value8.shellHand, Value8.shellW )
                        end
                        if PoseW > 0.5 or RunW > 0.5 or Storage.Progress3 or Value8.shellW > 0.001 then
                            if ReloadW < 0.999 and not Value8.pistol then
                                Storage.UpperTorsoWorld4 = UpperTorsoWorld3 * Gun4
                                Storage.Value43 = nil

                                for Key13, Value44 in Storage.Table27, nil, nil do
                                    Storage.Rh2 = if Value44 ~= "Right" or not Lerp8 then Storage.Hand2 else Lerp8
                                    Storage.UpperTorsoWorld5 = Storage.UpperTorsoWorld4 * Storage.Rh2
                                    _, _, Storage.ArmWorld33 = ArmIK.ArmWorld( Key3, Value44, UpperTorsoWorld3 )

                                    if Storage.ArmWorld33 then
                                        if RunW > 0.5 or Value8.ownPose or ( Storage.ArmWorld33.Position - Storage.UpperTorsoWorld5.Position ).Magnitude > 0.03 then
                                            Storage.CurrentPole = ArmIK.CurrentPole
                                            Storage.CurrentPole2 = Storage.CurrentPole( Key3, Value44, UpperTorsoWorld3, Storage.UpperTorsoWorld5.Position )

                                            if Storage.CurrentPole2 then
                                                Storage.Table4 = { }

                                                if ReloadW > 0.001 then
                                                    Storage.Value45 = nil

                                                    for Key14, Value46 in Storage.Table26, nil, nil do
                                                        Storage.Value47 = J( Key3, Value44 .. Value46[ 1 ], Value44 .. Value46[ 2 ] )

                                                        if Storage.Value47 then
                                                            Storage.Table4[ Storage.Value47 ] = AnimWorkers.getT( Storage.Value47 )
                                                        end
                                                    end
                                                end
                                                ArmIK.Solve( Key3, Value44, UpperTorsoWorld3, Storage.UpperTorsoWorld5, Storage.CurrentPole2 )
                                                Storage.Value48 = nil

                                                for Key15, Value49 in Storage.Table4, nil, nil do
                                                    Storage.SetT7 = AnimWorkers.setT
                                                    Storage.SetT7( Key15, AnimWorkers.getT( Key15 ):Lerp( Value49, ReloadW ) )
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        Value8.lastHold = AnimWorkers.getC0( Value8.joint )

                        if Storage.Table5 then
                            Storage.Clamp4 = math.clamp( ( Min2 - 0.65 ) / 0.35, 0, 1 )
                            Storage.Clamp5 = Storage.Clamp4 * Storage.Clamp4 * ( 3 - 2 * Storage.Clamp4 )
                            Storage.Table6 = { }
                            Storage.Value50 = nil

                            for Key16, Value51 in Storage.Table5, nil, nil do
                                Storage.Table6[ Key16 ] = AnimWorkers.getT( Key16 )
                                Storage.SetT9 = AnimWorkers.setT

                                if not Table18[ Key16.Name ] or not Value51 then
                                    Storage.Lerp12 = Value51:Lerp( AnimWorkers.getT( Key16 ), Storage.Clamp5 )
                                else
                                    Storage.Lerp12 = Value51
                                end

                                Storage.SetT9( Key16, Storage.Lerp12 )
                            end

                            Storage.UpperTorsoWorld6 = ArmIK.UpperTorsoWorld( Key3 )

                            if Storage.UpperTorsoWorld6 then
                                Storage.C0 = AnimWorkers.getC0( Value8.joint )
                                Storage.Clamp6 = math.clamp( ( Min2 - 0 ) / 0.85, 0, 1 )
                                Storage.Value52, Storage.Value53, Storage.Value54 = DrawAtK( Storage.Clamp6 * Storage.Clamp6 * ( 3 - 2 * Storage.Clamp6 ), Storage.C0 )
                                Storage.Solve = ArmIK.Solve
                                Storage.Solve( Key3, "Right", Storage.UpperTorsoWorld6, Storage.UpperTorsoWorld6 * Storage.Value52 * Storage.Value53, Storage.UpperTorsoWorld6 * Storage.Value54 )
                                Storage.Table7 = {
                                    { "RightUpperArm", "RightShoulder" },
                                    { "RightLowerArm", "RightElbow" },
                                    { "RightHand", "RightWrist" }
                                }
                                Storage.Value55 = nil

                                for Key17, Value56 in Storage.Table7, nil, nil do
                                    Storage.Value57 = J( Key3, Value56[ 1 ], Value56[ 2 ] )

                                    if Storage.Value57 and Storage.Table6[ Storage.Value57 ] then
                                        Storage.SetT8 = AnimWorkers.setT
                                        Storage.GetT3 = AnimWorkers.getT( Storage.Value57 )
                                        Storage.SetT8( Storage.Value57, Storage.GetT3:Lerp( Storage.Table6[ Storage.Value57 ], Storage.Clamp5 ) )
                                    end
                                end

                                Storage.Lerp11 = Storage.Value52:Lerp( Storage.C0, Storage.Clamp5 )
                                Storage.SetC02 = AnimWorkers.setC0
                                Storage.SetC02( Value8.joint, Storage.Lerp11 )
                                Storage.UpperTorsoWorld7 = Storage.UpperTorsoWorld6 * Storage.Lerp11 * LeftShift( Value8.weapon ) * Value8.lh
                                Storage.Clamp7 = math.clamp( ( Min2 - 0.4 ) / 0.6, 0, 1 )
                                LeftToGun( Key3, Storage.UpperTorsoWorld6, Storage.UpperTorsoWorld7, Storage.Clamp7 * Storage.Clamp7 * ( 3 - 2 * Storage.Clamp7 ) )
                            end
                        end
                        Value8.lastC0 = AnimWorkers.getC0( Value8.joint )
                        Storage.LastPose = Value8.lastPose
                        Storage.LastPose2 = if Storage.LastPose then Storage.LastPose else { }
                        Value8.lastPose = Storage.LastPose2
                        Storage.Value58 = nil

                        for Value59 in Table24, nil, nil do
                            Storage.Value60 = J( Key3, Table4[ Value59 ], Value59 )

                            if Storage.Value60 then
                                Storage.LastPose3 = Value8.lastPose
                                Storage.LastPose3[ Storage.Value60 ] = AnimWorkers.getT( Storage.Value60 )
                            end
                        end
                    end
                end
            elseif Value8.drawDur then
                Class13[ Key3 ] = math.min( 1, ( Class13[ Key3 ] or 0 ) + Clips / Value8.drawDur )
            end
        end
    end

    local Value9
    CrouchAnim.Update( Clips )
    Storage.ApplyMoveClips( Clips )
    FistAnim.Update( Clips )
    Storage.HealAnim.Update( )
    Value9 = nil

    for Key4, Value10 in Class5, nil, nil do
        if Value10.pistol and Key4.Parent and Value10.joint then
            local Flag2 = List[ Key4 ] ~= false and true or false

            if Flag2 then
                local Flag3 = Storage.RollInfo( Key4 ) ~= nil and true or false
                local Number = ( Value10.free or Flag3 ) and 1 or 0
                local ReloadT4
                Value10.freeW = ( Value10.freeW or 0 ) + ( Number - ( Value10.freeW or 0 ) ) * ( 1 - math.exp( -18 * Clips ) )
                local ReloadT3 = Value10.reloadT

                if ReloadT3 then
                    local ReloadDur2 = Value10.reloadDur

                    if ReloadDur2 then
                        ReloadT4 = Value10.reloadT / Value10.reloadDur
                    else
                        ReloadT4 = ReloadDur2
                    end
                else
                    ReloadT4 = ReloadT3
                end

                local ReloadT5

                if ReloadT4 then
                    if ReloadT4 >= 0 then
                        if ReloadT4 < 1 then
                            ReloadT5 = not Flag3
                        else
                            ReloadT5 = false
                        end
                    else
                        ReloadT5 = false
                    end
                else
                    ReloadT5 = ReloadT4
                end

                local Entry2
                local Entry = WeaponData[ Value10.weapon ]
                Entry2 = if Entry then WeaponData[ Value10.weapon ].Handling.Kick else Entry
                local KickX = Value10.kickX or 0

                if Entry2 and Entry2.Arm and KickX > 0.0001 and not ReloadT5 then
                    local Value20
                    local Rad = math.rad( Entry2.Pitch or 0 ) * KickX
                    local Table = {
                        { "RightUpperArm", "RightShoulder", CFrame.Angles( Rad * 0.35, 0, 0 ) },
                        { "RightLowerArm", "RightElbow", CFrame.Angles( Rad * 0.5, 0, 0 ) },
                        {
                            "RightHand",
                            "RightWrist",
                            CFrame.fromAxisAngle( Storage.VectorToWorldSpace, Rad * 0.8 )
                        }
                    }
                    Value20 = nil

                    for Key7, Value21 in Table, nil, nil do
                        local J3 = J( Key4, Value21[ 1 ], Value21[ 2 ] )

                        if J3 then
                            local SetT2 = AnimWorkers.setT
                            SetT2( J3, AnimWorkers.getT( J3 ) * Value21[ 3 ] )
                        end
                    end
                end

                local UpperTorsoWorld = ArmIK.UpperTorsoWorld( Key4 )

                if UpperTorsoWorld then
                    local _, _, ArmWorld3 = ArmIK.ArmWorld( Key4, "Right", UpperTorsoWorld )

                    if ArmWorld3 then
                        AnimWorkers.setC0( Value10.joint, UpperTorsoWorld:ToObjectSpace( ArmWorld3 * Storage.PistolGrip2:Lerp( Inverse, 1 - Value10.freeW ) ) )

                        if not ReloadT5 and Value10.freeW < 0.999 then
                            Storage.ArmTo( Key4, "Left", UpperTorsoWorld, UpperTorsoWorld * AnimWorkers.getC0( Value10.joint ) * PistolAim2.LeftHand, 1 - Value10.freeW )
                        end
                    end
                end
                if ReloadT5 then
                    Storage.PistolReload2( Key4, Value10, ReloadT4, Clips )
                else
                    Storage.Class17[ Key4 ] = nil
                    Value10.prSmooth = nil
                end

                Value10.lastC0 = AnimWorkers.getC0( Value10.joint )
            end
        end
    end

    local Value11 = nil

    for Value12 in Storage.Class17, nil, nil do
        if not Class5[ Value12 ] then
            Storage.Class17[ Value12 ] = nil
        end
    end

    local Value13 = nil

    for Key5, Value14 in Class5, nil, nil do
        if Value14.rpg and Key5.Parent and Value14.joint then
            local Flag = List[ Key5 ] ~= false and true or false

            if Flag then
                local ReloadT2
                local ReloadT = Value14.reloadT

                if ReloadT then
                    local ReloadDur = Value14.reloadDur

                    if ReloadDur then
                        ReloadT2 = Value14.reloadT / Value14.reloadDur
                    else
                        ReloadT2 = ReloadDur
                    end
                else
                    ReloadT2 = ReloadT
                end
                if not ReloadT2 or not ( ReloadT2 >= 0 ) or not ( ReloadT2 < 1 ) or Storage.RollInfo( Key5 ) ~= nil then
                    Storage.Class18[ Key5 ] = nil
                    Value14.rrSmooth = nil
                else
                    Storage.RpgReload( Key5, Value14, ReloadT2, Clips )
                end

                Value14.lastC0 = AnimWorkers.getC0( Value14.joint )
            end
        end
    end

    local Value15 = nil

    for Value16 in Storage.Class18, nil, nil do
        if not Class5[ Value16 ] then
            Storage.Class18[ Value16 ] = nil
        end
    end
    for Key6, Value18 in AnimatedChars( ) do
        local Get = SwimTilt.Get( Value18 )

        if Get then
            local J2 = J( Value18, "Head", "Neck" )

            if J2 then
                local SetT = AnimWorkers.setT
                SetT( J2, AnimWorkers.getT( J2 ) * SwimTilt.Neck( Get ) )
            end
        end
    end

    SeatedArms.Update( Clips, Class5, BarrelDir )

    if ClientState.AfterGunAnimator then
        ClientState.AfterGunAnimator( Clips )
    end
end

if AnimWorkers.IsWorker then
    Storage.Number14 = -math.huge
    RunService.PreSimulation:Connect( function( Argument1 )
        Number4 = Number4 + Argument1

        if Flag2 then
            Number6 = Number4
            Number4 = 0
            return
        end
        AnimWorkers.Replay( )
        AnimWorkers.Beat( )
        return
    end )
    RunService.PreSimulation:ConnectParallel( function()
        if not Flag2 then
            return
        end

        AnimWorkers.InParallel = true
        AnimWorkers.StartRecord( )
        local Success, Result = pcall( Storage.PreSimulation, Number6 )
        task.synchronize( )
        AnimWorkers.Flush( )
        AnimWorkers.EndRecord( )
        AnimWorkers.Beat( )

        if not Success and os.clock( ) - Storage.Number14 > 10 then
            Storage.Number14 = os.clock( )
            local Index = AnimWorkers.Index
            warn( "[GunAnimator, ouvrier " .. Index .. "] " .. tostring( Result ) )
        end
    end )
else
    RunService.PreSimulation:Connect( Storage.PreSimulation )
end
Storage.Table30 = { grab = { 0.04, 0.12 }, hide = { 0.3, 0.36 }, insert = { 0.62, 0.8 } }
Storage.CFrame6 = CFrame.new( 0, -0.25, 0 )
Storage.Class19 = setmetatable( { }, { __mode = "k" } )

Storage.DrumReload = function( ReloadName, Argument2, Argument3, Argument4 )
    local Entry2
    local Entry = Class5[ ReloadName ]

    if Entry then
        local NotPistol = not Entry.pistol

        if NotPistol then
            local NotRpg = not Entry.rpg

            if NotRpg then
                local ReloadT = Entry.reloadT

                if ReloadT then
                    local ReloadDur = Entry.reloadDur

                    if ReloadDur then
                        Entry2 = Entry.reloadT / Entry.reloadDur
                    else
                        Entry2 = ReloadDur
                    end
                else
                    Entry2 = ReloadT
                end
            else
                Entry2 = NotRpg
            end
        else
            Entry2 = NotPistol
        end
    else
        Entry2 = Entry
    end
    if not Argument2.drum or not Argument2.magCenter or not Argument4 or not Entry2 or not ( Entry2 >= 0 ) or not ( Entry2 < 1 ) then
        Storage.Class19[ ReloadName ] = nil
        return nil
    end

    local Clamp2

    if Entry2 < Storage.Table30.grab[ 1 ] then
        Clamp2 = 0
    elseif Entry2 < Storage.Table30.grab[ 2 ] then
        local Clamp = math.clamp( ( Entry2 - Storage.Table30.grab[ 1 ] ) / ( Storage.Table30.grab[ 2 ] - Storage.Table30.grab[ 1 ] ), 0, 1 )
        Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    elseif Entry2 < Storage.Table30.insert[ 1 ] then
        Clamp2 = 1
    elseif Entry2 < Storage.Table30.insert[ 2 ] then
        local Clamp3 = math.clamp( ( Entry2 - Storage.Table30.insert[ 1 ] ) / ( Storage.Table30.insert[ 2 ] - Storage.Table30.insert[ 1 ] ), 0, 1 )
        Clamp2 = 1 - Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 )
    else
        Clamp2 = 0
    end
    if Clamp2 <= 0 then
        return nil
    end

    local Entry4
    local CFrame2 = Argument3 * CFrame.new( Argument2.magCenter )
    local Entry3 = Storage.Class19[ ReloadName ]

    if Entry3 then
        Entry4 = Entry3
    else
        local Table = {
            rot = ( Argument4.CFrame * Storage.CFrame6 ):ToObjectSpace( CFrame2 ).Rotation
        }
        Storage.Class19[ ReloadName ] = Table
        Entry4 = Table
    end

    local Hidden
    local Table2 = {
        M = CFrame2:Lerp( Argument4.CFrame * Storage.CFrame6 * Entry4.rot, Clamp2 ),
        MgInv = CFrame2:Inverse( )
    }

    if Storage.Table30.hide[ 1 ] <= Entry2 then
        if Entry2 < Storage.Table30.hide[ 2 ] then
            Hidden = true
        else
            Hidden = false
        end
    else
        Hidden = false
    end

    Table2.hidden = Hidden
    return Table2
end

Storage.Index = AnimWorkers.IsWorker and AnimWorkers.Index or ""
RunService:BindToRenderStep( "WeaponVisuals" .. Storage.Index, Enum.RenderPriority.Last.Value - 1, function()
    local Flag = AnimWorkers.State.NoWeld ~= true and true or false

    if Flag ~= Flag4 then
        local Value1
        Flag4 = Flag
        Value1 = nil

        for Key, Value in Class11, nil, nil do
            local Value4 = nil

            for Key2, Value5 in Value, nil, nil do
                Value5.model:Destroy( )
            end
        end

        local Value2
        table.clear( Class11 )
        Value2 = nil

        for Value3 in Class10, nil, nil do
            VisualRegistry[ Value3 ] = nil
        end

        table.clear( Class10 )
    end
    for Key3, Value7 in AnimatedChars( ) do
        local Flag2
        local Entry = Table12[ Value7 ] or 0
        Flag2 = List[ Value7 ] ~= false and true or false

        if Flag2 or ( Number + Entry ) % 2 == 0 then
            local Entry3
            local Entry2 = Class2[ Value7 ]

            if Entry2 then
                Entry3 = Entry2
            else
                Entry3 = NewCache( Value7 )
            end

            local Entry5
            local Entry4 = Entry3[ Table5 ]

            if Entry4 then
                Entry5 = Entry4
            else
                local Table = { }
                Entry3[ Table5 ] = Table
                Entry5 = Table
            end

            local Tool3
            local Tool = Entry5[ "@Tool" ]

            if not Tool or Tool.Parent ~= Value7 then
                local Tool2 = Value7:FindFirstChildOfClass( "Tool" )
                Entry5[ "@Tool" ] = Tool2
                Tool3 = Tool2
            else
                Tool3 = Tool
            end

            local Weapon

            if Tool3 then
                Weapon = Tool3:GetAttribute( "Weapon" )
            else
                Weapon = Tool3
            end

            local Tool4

            if Tool3 then
                Tool4 = HandleOf( Value7, Tool3 )
            else
                Tool4 = Tool3
            end

            local Entry6 = Class12[ Value7 ]

            if not Weapon or not Tool4 then
                if not Entry6 or Entry6.gone or not Value7:FindFirstChild( "UpperTorso" ) then
                    local Entry16 = Class10[ Value7 ]

                    if Entry16 and Entry16.shown then
                        if Entry16.welded then
                            local Item = Entry16.movers[ 1 ]

                            if Entry16.attach then
                                Entry16.attach.Part0 = nil
                            end

                            Item.Anchored = true
                            Item.CFrame = CFrame4
                            Entry16.attached = false
                            Entry16.attachPart = nil
                            Entry16.attachC0 = nil
                        else
                            PlaceVisual( Entry16, CFrame4 )
                        end

                        Entry16.shown = false
                    end
                else
                    local Visual2 = GetVisual( Value7, Entry6.weapon, false )

                    if Visual2 then
                        if Visual2.welded then
                            AttachVisual( Visual2, Value7.UpperTorso, Entry6.c0 )
                            local CFrame4Inner = Value7.UpperTorso.CFrame * Entry6.c0
                            local Movers = Visual2.movers
                            local MoverIdx = Visual2.moverIdx
                            local MoverWelds = Visual2.moverWelds
                            local MoverC0 = Visual2.moverC0
                            local Count = #Movers
                            local J = 2

                            if Count >= 2 then
                                for J = 2, Count do
                                    local Entry15 = MoverIdx[ J ]
                                    local C0 = Visual2.rel[ Entry15 ]

                                    if MoverC0[ J ] ~= C0 then
                                        MoverC0[ J ] = C0
                                        MoverWelds[ J ].C0 = C0
                                    end
                                end
                            end
                        else
                            PlaceVisual( Visual2, Value7.UpperTorso.CFrame * Entry6.c0 )
                        end

                        Visual2.shown = true
                    end
                end
            else
                local Entry8
                local Visual = GetVisual( Value7, Weapon, Tool3:GetAttribute( "Mods" ) or "" )
                local Entry7 = Storage.Class17[ Value7 ]

                if Entry7 then
                    Entry8 = Entry7
                else
                    Entry8 = Storage.Class18[ Value7 ]
                end
                if Entry8 and Entry8.weapon ~= Weapon then
                    Entry8 = nil
                end

                local Entry9

                if Entry8 then
                    Entry9 = Entry8
                elseif Holds.IsRocket( Weapon ) then
                    local Rocket
                    local Table2 = { }
                    Rocket = not ( ( Tool3:GetAttribute( "Ammo" ) or 1 ) > 0 ) and "hidden" or "tube"
                    Table2.rocket = Rocket

                    if Table2 then
                        Entry9 = Table2
                    else
                        Entry9 = nil
                    end
                else
                    Entry9 = nil
                end

                local Entry11
                local Entry10 = Class2[ Value7 ]

                if Entry10 then
                    Entry11 = Entry10
                else
                    Entry11 = NewCache( Value7 )
                end

                local Entry13
                local Entry12 = Entry11[ Table5 ]

                if Entry12 then
                    Entry13 = Entry12
                else
                    local Table3 = { }
                    Entry11[ Table5 ] = Table3
                    Entry13 = Table3
                end

                local LeftHand3
                local LeftHand = Entry13.LeftHand

                if not LeftHand or LeftHand.Parent ~= Value7 then
                    local LeftHand2 = Value7:FindFirstChild( "LeftHand" )
                    Entry13.LeftHand = LeftHand2
                    LeftHand3 = LeftHand2
                else
                    LeftHand3 = LeftHand
                end

                local Entry14

                if not Visual or Entry9 or not Visual.drum then
                    Entry14 = Entry9
                else
                    local Value15 = Storage.DrumReload( Value7, Visual, Tool4.CFrame, LeftHand3 )

                    if Value15 then
                        Entry14 = { drum = Value15 }
                    else
                        Entry14 = Entry9
                    end
                end
                if Visual then
                    if Visual.welded then
                        AttachVisual( Visual, Tool4, CFrame.identity )
                        local CFrame2 = Tool4.CFrame
                        PlaceMovers( Visual, CFrame2, BoltAction.Progress( Tool3 ), Entry14, LeftHand3 )
                    else
                        local CFrame3 = Tool4.CFrame
                        PlaceVisual( Visual, CFrame3, BoltAction.Progress( Tool3 ), Entry14, LeftHand3 )
                    end

                    Visual.shown = true
                end
            end
        end
    end

    local Value8 = nil

    for Key4, Value9 in Class10, nil, nil do
        if not Key4.Parent then
            Value9.model:Destroy( )
            Class10[ Key4 ] = nil
        end
    end

    local Value10 = nil

    for Key5, Value11 in Class11, nil, nil do
        if not Key5.Parent then
            local Value12 = nil

            for Key6, Value13 in Value11, nil, nil do
                Value13.model:Destroy( )
            end

            Class11[ Key5 ] = nil
        end
    end
end )

Callback = function()
    for Key, Value in AnimatedChars( ) do
        local Entry2
        local Entry = Class2[ Value ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = NewCache( Value )
        end

        local Entry4
        local Entry3 = Entry2[ Table5 ]

        if Entry3 then
            Entry4 = Entry3
        else
            local Table = { }
            Entry2[ Table5 ] = Table
            Entry4 = Table
        end

        local Humanoid3
        local Humanoid = Entry4[ "@Humanoid" ]

        if not Humanoid or Humanoid.Parent ~= Value then
            local Humanoid2 = Value:FindFirstChildOfClass( "Humanoid" )
            Entry4[ "@Humanoid" ] = Humanoid2
            Humanoid3 = Humanoid2
        else
            Humanoid3 = Humanoid
        end

        ArmIK.Warm( Value )
        RayParamsOf( Value )

        if not Class14[ Value ] then
            AnimWorkers.Sync( )
            Class14[ Value ] = true
            Value.ChildRemoved:Connect( function( Object )
                if not Object:IsA( "Tool" ) then
                    return
                end

                local Entry = Class5[ Value ]

                if Entry and Entry.drawDur and Entry.handle then
                    if Entry.tool == Object or Entry.handle.Parent == Object then
                        StartHolster( Value, Entry )
                        Class5[ Value ] = nil

                        if AnimWorkers.IsWorker then
                            AnimWorkers.SetAim( Value, false )
                        end
                    end
                end
            end )
        end
        if Humanoid3 and Humanoid3.Health > 0 then
            IsClimbing( Value, Humanoid3 )
        end
    end
end

Callback2 = function()
    local Value1 = nil

    for Value in Class5, nil, nil do
        if not AnimWorkers.Owns( Value ) then
            Class5[ Value ] = nil
        end
    end

    local Value2 = nil

    for Value3 in Class9, nil, nil do
        if not AnimWorkers.Owns( Value3 ) then
            Class9[ Value3 ] = nil
        end
    end

    local Value4 = nil

    for Value5 in Class12, nil, nil do
        if not AnimWorkers.Owns( Value5 ) then
            Class12[ Value5 ] = nil
        end
    end

    local Value6 = nil

    for Value7 in Storage.Class16, nil, nil do
        if not AnimWorkers.Owns( Value7 ) then
            Storage.Class16[ Value7 ] = nil
        end
    end

    local Value8 = nil

    for Value9 in Storage.Class17, nil, nil do
        if not AnimWorkers.Owns( Value9 ) then
            Storage.Class17[ Value9 ] = nil
        end
    end

    local Value10 = nil

    for Value11 in Storage.Class18, nil, nil do
        if not AnimWorkers.Owns( Value11 ) then
            Storage.Class18[ Value11 ] = nil
        end
    end

    local Value12 = nil

    for Value13 in Storage.Class19, nil, nil do
        if not AnimWorkers.Owns( Value13 ) then
            Storage.Class19[ Value13 ] = nil
        end
    end

    local Value14 = nil

    for Value15 in Class13, nil, nil do
        if not AnimWorkers.Owns( Value15 ) then
            Class13[ Value15 ] = nil
        end
    end

    local Value16 = nil

    for Value17 in Class, nil, nil do
        if not AnimWorkers.Owns( Value17 ) then
            Class[ Value17 ] = nil
        end
    end

    local Value18 = nil

    for Value19 in Class10, nil, nil do
        if not AnimWorkers.Owns( Value19 ) then
            Class10[ Value19 ] = nil
            VisualRegistry[ Value19 ] = nil
        end
    end

    local Value20 = nil

    for Key, Value21 in Class11, nil, nil do
        if not AnimWorkers.Owns( Key ) then
            local Value22 = nil

            for Key2, Value23 in Value21, nil, nil do
                Value23.model:Destroy( )
            end

            Class11[ Key ] = nil
        end
    end
end

Callback3 = function()
    Flag3 = true

    for Key, Value in FX:GetChildren( ) do
        if Value:GetAttribute( "GA_Worker" ) then
            Value:Destroy( )
        end
    end

    local Value1
    AnimatedChars( )
    Value1 = nil

    for Key2, Value2 in Table11, nil, nil do
        local GA_Visual = Value2:FindFirstChild( "GA_Visual" )

        if GA_Visual then
            GA_Visual:Destroy( )
        end
    end
end

if AnimWorkers.IsWorker then
    ClientState.CarSteer = AnimWorkers.SteerProxy( )
    Storage.State = AnimWorkers.State
    Storage.State[ "Ready" .. AnimWorkers.Index ] = true
else
    Storage.MeleeAnimator = script.Parent:WaitForChild( "MeleeAnimator", 10 )

    if Storage.MeleeAnimator then
        AnimWorkers.Spawn( { script, Storage.MeleeAnimator } )
    else
        warn( "[GunAnimator] MeleeAnimator introuvable : animations sans ouvriers (fil principal seul)" )
    end
end
