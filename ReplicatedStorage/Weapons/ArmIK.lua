-- ReplicatedStorage.Weapons.ArmIK
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local AnimWorkers = require( script.Parent:WaitForChild( "AnimWorkers" ) )
local Class = setmetatable( { }, { __mode = "k" } )

local function Frames( Key )
    local Entry2
    local Entry = Class[ Key ]

    if Entry == nil then
        local IsA = Key:IsA( "Motor6D" )
        Class[ Key ] = IsA
        Entry2 = IsA
    else
        Entry2 = Entry
    end
    if Entry2 then
        return AnimWorkers.getC0( Key ), Key.C1
    end
    return Key.Attachment0.CFrame, Key.Attachment1.CFrame
end

local Table = { }

local function NamesOf( Key )
    local Entry2
    local Entry = Table[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local TableInner = {
            ua = Key .. "UpperArm",
            la = Key .. "LowerArm",
            hand = Key .. "Hand",
            s = Key .. "Shoulder",
            e = Key .. "Elbow",
            w = Key .. "Wrist"
        }
        Table[ Key ] = TableInner
        Entry2 = TableInner
    end

    return Entry2
end

local Class2 = setmetatable( { }, { __mode = "k" } )

local function IsJoint( Self )
    local IsA2
    local IsA = Self:IsA( "JointInstance" )
    IsA2 = if IsA then IsA else Self:IsA( "AnimationConstraint" )
    return IsA2
end

local function CharCache( CacheName )
    local Entry2
    local Entry = Class2[ CacheName ]

    if Entry then
        Entry2 = Entry
    else
        AnimWorkers.Sync( )
        local Table = { }
        Class2[ CacheName ] = Table

        local function Clear()
            table.clear( Table )
        end

        CacheName.ChildAdded:Connect( Clear )
        CacheName.ChildRemoved:Connect( Clear )
        CacheName.DescendantAdded:Connect( function( Self )
            local IsA2
            local IsA = Self:IsA( "JointInstance" )
            IsA2 = if IsA then IsA else Self:IsA( "AnimationConstraint" )

            if IsA2 then
                table.clear( Table )
            end
        end )
        CacheName.DescendantRemoving:Connect( function( Self )
            local IsA2
            local IsA = Self:IsA( "JointInstance" )
            IsA2 = if IsA then IsA else Self:IsA( "AnimationConstraint" )

            if IsA2 then
                table.clear( Table )
            end
        end )
        Entry2 = Table
    end

    return Entry2
end

local function Arm( CacheName, Key )
    local CharCache2 = CharCache( CacheName )
    local Entry = CharCache2[ Key ]

    if Entry then
        return Entry
    end

    local Entry3
    local Entry2 = Table[ Key ]

    if Entry2 then
        Entry3 = Entry2
    else
        local TableInner = {
            ua = Key .. "UpperArm",
            la = Key .. "LowerArm",
            hand = Key .. "Hand",
            s = Key .. "Shoulder",
            e = Key .. "Elbow",
            w = Key .. "Wrist"
        }
        Table[ Key ] = TableInner
        Entry3 = TableInner
    end

    local FoundChild4
    local FoundChild = CacheName:FindFirstChild( Entry3.ua )
    local FoundChild2 = CacheName:FindFirstChild( Entry3.la )
    local FoundChild3 = CacheName:FindFirstChild( Entry3.hand )

    if FoundChild then
        FoundChild4 = FoundChild:FindFirstChild( Entry3.s )
    else
        FoundChild4 = FoundChild
    end

    local FoundChild5

    if FoundChild2 then
        FoundChild5 = FoundChild2:FindFirstChild( Entry3.e )
    else
        FoundChild5 = FoundChild2
    end

    local FoundChild6 = if FoundChild3 then FoundChild3:FindFirstChild( Entry3.w ) else FoundChild3

    if not FoundChild4 or not FoundChild5 then
        CharCache2[ Key ] = nil
        return nil
    end
    local Table2 = { jS = FoundChild4, jE = FoundChild5, jW = FoundChild6 }
    CharCache2[ Key ] = Table2
    return Table2
end

local function ChildWorld( Argument1, WorldName )
    local Entry2
    local Entry = Class[ WorldName ]

    if Entry == nil then
        local IsA = WorldName:IsA( "Motor6D" )
        Class[ WorldName ] = IsA
        Entry2 = IsA
    else
        Entry2 = Entry
    end

    local C0, C1

    if Entry2 then
        C0 = AnimWorkers.getC0( WorldName )
        C1 = WorldName.C1
    else
        C0 = WorldName.Attachment0.CFrame
        C1 = WorldName.Attachment1.CFrame
    end

    return Argument1 * C0 * AnimWorkers.getT( WorldName ) * C1:Inverse( )
end

local function SetJoint( JointName, Argument2, Argument3 )
    local Entry2
    local Entry = Class[ JointName ]

    if Entry == nil then
        local IsA = JointName:IsA( "Motor6D" )
        Class[ JointName ] = IsA
        Entry2 = IsA
    else
        Entry2 = Entry
    end

    local C0, C1

    if Entry2 then
        C0 = AnimWorkers.getC0( JointName )
        C1 = JointName.C1
    else
        C0 = JointName.Attachment0.CFrame
        C1 = JointName.Attachment1.CFrame
    end

    local SetT = AnimWorkers.setT
    SetT( JointName, ( Argument2 * C0 ):Inverse( ) * Argument3 * C1 )
end

local function MapBasis( Argument1, Argument2, Argument3, Argument4 )
    local Unit = ( Argument2 - Argument1 * Argument2:Dot( Argument1 ) ).Unit
    local Unit2 = ( Argument4 - Argument3 * Argument4:Dot( Argument3 ) ).Unit
    local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit, Argument1, Unit:Cross( Argument1 ) )
    return CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit2, Argument3, Unit2:Cross( Argument3 ) ) * FromMatrix:Inverse( )
end

return {
    Frames = Frames,
    Warm = function( CacheName )
        CharCache( CacheName )
    end,
    UpperTorsoWorld = function( CacheName )
        local Torso3
        local CharCache2 = CharCache( CacheName )
        local Torso = CharCache2.torso

        if Torso then
            Torso3 = Torso
        else
            local Root
            local HumanoidRootPart = CacheName:FindFirstChild( "HumanoidRootPart" )
            local LowerTorso = CacheName:FindFirstChild( "LowerTorso" )
            local UpperTorso = CacheName:FindFirstChild( "UpperTorso" )

            if LowerTorso then
                Root = LowerTorso:FindFirstChild( "Root" )
            else
                Root = LowerTorso
            end

            local Waist

            if UpperTorso then
                Waist = UpperTorso:FindFirstChild( "Waist" )
            else
                Waist = UpperTorso
            end
            if not HumanoidRootPart or not Root or not Waist then
                CharCache2.torso = nil
                return nil
            end

            local Torso2 = { root = HumanoidRootPart, rootJoint = Root, waist = Waist }
            CharCache2.torso = Torso2
            Torso3 = Torso2
        end

        local Entry2
        local CFrame = Torso3.root.CFrame
        local RootJoint = Torso3.rootJoint
        local Entry = Class[ RootJoint ]

        if Entry == nil then
            local IsA = RootJoint:IsA( "Motor6D" )
            Class[ RootJoint ] = IsA
            Entry2 = IsA
        else
            Entry2 = Entry
        end

        local C0, C1

        if Entry2 then
            C0 = AnimWorkers.getC0( RootJoint )
            C1 = RootJoint.C1
        else
            C0 = RootJoint.Attachment0.CFrame
            C1 = RootJoint.Attachment1.CFrame
        end

        local Entry4
        local CFrame2 = CFrame * C0 * AnimWorkers.getT( RootJoint ) * C1:Inverse( )
        local Waist2 = Torso3.waist
        local Entry3 = Class[ Waist2 ]

        if Entry3 == nil then
            local IsA2 = Waist2:IsA( "Motor6D" )
            Class[ Waist2 ] = IsA2
            Entry4 = IsA2
        else
            Entry4 = Entry3
        end

        local C02, C12

        if Entry4 then
            C02 = AnimWorkers.getC0( Waist2 )
            C12 = Waist2.C1
        else
            C02 = Waist2.Attachment0.CFrame
            C12 = Waist2.Attachment1.CFrame
        end

        return CFrame2 * C02 * AnimWorkers.getT( Waist2 ) * C12:Inverse( )
    end,
    ArmWorld = function( CacheName, Key, Argument3 )
        local Arm2 = Arm( CacheName, Key )

        if not Arm2 or not Arm2.jW then
            return
        end

        local Entry2
        local JS = Arm2.jS
        local JE = Arm2.jE
        local JW = Arm2.jW
        local Entry = Class[ JS ]

        if Entry == nil then
            local IsA = JS:IsA( "Motor6D" )
            Class[ JS ] = IsA
            Entry2 = IsA
        else
            Entry2 = Entry
        end

        local C0, C1

        if Entry2 then
            C0 = AnimWorkers.getC0( JS )
            C1 = JS.C1
        else
            C0 = JS.Attachment0.CFrame
            C1 = JS.Attachment1.CFrame
        end

        local Entry4
        local C02 = Argument3 * C0 * AnimWorkers.getT( JS ) * C1:Inverse( )
        local Entry3 = Class[ JE ]

        if Entry3 == nil then
            local IsA2 = JE:IsA( "Motor6D" )
            Class[ JE ] = IsA2
            Entry4 = IsA2
        else
            Entry4 = Entry3
        end

        local C03, C12

        if Entry4 then
            C03 = AnimWorkers.getC0( JE )
            C12 = JE.C1
        else
            C03 = JE.Attachment0.CFrame
            C12 = JE.Attachment1.CFrame
        end

        local Entry6
        local C04 = C02 * C03 * AnimWorkers.getT( JE ) * C12:Inverse( )
        local Entry5 = Class[ JW ]

        if Entry5 == nil then
            local IsA3 = JW:IsA( "Motor6D" )
            Class[ JW ] = IsA3
            Entry6 = IsA3
        else
            Entry6 = Entry5
        end

        local C05, C13

        if Entry6 then
            C05 = AnimWorkers.getC0( JW )
            C13 = JW.C1
        else
            C05 = JW.Attachment0.CFrame
            C13 = JW.Attachment1.CFrame
        end

        return C02, C04, C04 * C05 * AnimWorkers.getT( JW ) * C13:Inverse( )
    end,
    CurrentPole = function( CacheName, PoleName, Argument3, Argument4 )
        local Arm2 = Arm( CacheName, PoleName )

        if not Arm2 then
            return nil
        end

        local Entry2
        local JS = Arm2.jS
        local JE = Arm2.jE
        local Entry = Class[ JS ]

        if Entry == nil then
            local IsA = JS:IsA( "Motor6D" )
            Class[ JS ] = IsA
            Entry2 = IsA
        else
            Entry2 = Entry
        end

        local C0

        if Entry2 then
            C0 = AnimWorkers.getC0( JS )
            local C1 = JS.C1
        else
            C0 = JS.Attachment0.CFrame
            local CFrame = JS.Attachment1.CFrame
        end

        local Entry4
        local Entry3 = Class[ JE ]

        if Entry3 == nil then
            local IsA2 = JE:IsA( "Motor6D" )
            Class[ JE ] = IsA2
            Entry4 = IsA2
        else
            Entry4 = Entry3
        end

        local C02

        if Entry4 then
            C02 = AnimWorkers.getC0( JE )
            local C12 = JE.C1
        else
            C02 = JE.Attachment0.CFrame
            local CFrame2 = JE.Attachment1.CFrame
        end

        local Entry6
        local Position = ( Argument3 * C0 ).Position
        local Entry5 = Class[ JS ]

        if Entry5 == nil then
            local IsA3 = JS:IsA( "Motor6D" )
            Class[ JS ] = IsA3
            Entry6 = IsA3
        else
            Entry6 = Entry5
        end

        local C03, C13

        if Entry6 then
            C03 = AnimWorkers.getC0( JS )
            C13 = JS.C1
        else
            C03 = JS.Attachment0.CFrame
            C13 = JS.Attachment1.CFrame
        end

        local VectorToWorldSpace
        local Position2 = ( Argument3 * C03 * AnimWorkers.getT( JS ) * C13:Inverse( ) * C02 ).Position
        local Unit = ( Argument4 - Position ).Unit
        local Position3 = Position2 - Position - Unit * ( Position2 - Position ):Dot( Unit )

        if Position3.Magnitude < 0.08 then
            local Number = PoleName ~= "Right" and -0.5 or 0.5
            VectorToWorldSpace = Argument3:VectorToWorldSpace( ( Vector3.new( Number, -1, 0.3 ) ) )
        else
            VectorToWorldSpace = Position3
        end

        return Position2 + VectorToWorldSpace.Unit * 2
    end,
    Solve = function( CacheName, Key, Argument3, Argument4, Argument5 )
        local Arm2 = Arm( CacheName, Key )

        if not Arm2 or not Arm2.jW then
            return
        end

        local Entry2
        local JS = Arm2.jS
        local JE = Arm2.jE
        local JW = Arm2.jW
        local Entry = Class[ JS ]

        if Entry == nil then
            local IsA = JS:IsA( "Motor6D" )
            Class[ JS ] = IsA
            Entry2 = IsA
        else
            Entry2 = Entry
        end

        local C0, C1

        if Entry2 then
            C0 = AnimWorkers.getC0( JS )
            C1 = JS.C1
        else
            C1 = JS.Attachment1.CFrame
            C0 = JS.Attachment0.CFrame
        end

        local Entry4
        local Entry3 = Class[ JE ]

        if Entry3 == nil then
            local IsA2 = JE:IsA( "Motor6D" )
            Class[ JE ] = IsA2
            Entry4 = IsA2
        else
            Entry4 = Entry3
        end

        local C02, C12

        if Entry4 then
            C02 = AnimWorkers.getC0( JE )
            C12 = JE.C1
        else
            C02 = JE.Attachment0.CFrame
            C12 = JE.Attachment1.CFrame
        end

        local Entry6
        local Entry5 = Class[ JW ]

        if Entry5 == nil then
            local IsA3 = JW:IsA( "Motor6D" )
            Class[ JW ] = IsA3
            Entry6 = IsA3
        else
            Entry6 = Entry5
        end

        local C03, C13

        if Entry6 then
            C03 = AnimWorkers.getC0( JW )
            C13 = JW.C1
        else
            C03 = JW.Attachment0.CFrame
            C13 = JW.Attachment1.CFrame
        end

        local Position7
        local Position = C02.Position - C1.Position
        local Position2 = C03.Position - C12.Position
        local Magnitude = Position.Magnitude
        local Magnitude2 = Position2.Magnitude
        local Position3 = ( Argument3 * C0 ).Position
        local Position4 = ( Argument4 * C13 ).Position - Position3
        local Magnitude3 = Position4.Magnitude
        local Clamp = math.clamp( Magnitude3, 0.05, Magnitude + Magnitude2 - 0.01 )
        local Unit = Position4.Unit
        local Clamp2 = math.clamp( ( Magnitude * Magnitude + Clamp * Clamp - Magnitude2 * Magnitude2 ) / ( 2 * Magnitude * Clamp ), -1, 1 )
        local Sqrt = math.sqrt( 1 - Clamp2 * Clamp2 )
        local Position5 = Argument5 - Position3
        local Position6 = Position5 - Unit * Position5:Dot( Unit )
        Position7 = if Position6.Magnitude < 0.001 then -Argument3.UpVector - Unit * ( -Argument3.UpVector ):Dot( Unit ) else Position6
        local Cross2
        local Unit2 = Position7.Unit
        local Position8 = Position3 + Unit * ( Magnitude * Clamp2 ) + Unit2 * ( Magnitude * Sqrt )
        local Position9 = Position3 + Unit * Clamp
        local Cross = ( Position8 - Position3 ):Cross( Position9 - Position8 )
        Cross2 = if Cross.Magnitude < 0.0001 then Argument3.RightVector else Cross
        local Entry8
        local Unit3 = Position.Unit
        local MapBasis2 = MapBasis( Unit3, Vector3.new( 1, 0, 0 ), ( Position8 - Position3 ).Unit, Cross2 )
        local CFrame2 = CFrame.new( Position3 - MapBasis2 * C1.Position ) * MapBasis2
        local Unit4 = Position2.Unit
        local MapBasis3 = MapBasis( Unit4, Vector3.new( 1, 0, 0 ), ( Position9 - Position8 ).Unit, Cross2 )
        local CFrame3 = CFrame.new( Position8 - MapBasis3 * C12.Position ) * MapBasis3
        local Entry7 = Class[ JS ]

        if Entry7 == nil then
            local IsA4 = JS:IsA( "Motor6D" )
            Class[ JS ] = IsA4
            Entry8 = IsA4
        else
            Entry8 = Entry7
        end

        local C04, C14

        if Entry8 then
            C04 = AnimWorkers.getC0( JS )
            C14 = JS.C1
        else
            C04 = JS.Attachment0.CFrame
            C14 = JS.Attachment1.CFrame
        end

        local Entry10
        local SetT = AnimWorkers.setT
        SetT( JS, ( Argument3 * C04 ):Inverse( ) * CFrame2 * C14 )
        local Entry9 = Class[ JE ]

        if Entry9 == nil then
            local IsA5 = JE:IsA( "Motor6D" )
            Class[ JE ] = IsA5
            Entry10 = IsA5
        else
            Entry10 = Entry9
        end

        local C05, C15

        if Entry10 then
            C05 = AnimWorkers.getC0( JE )
            C15 = JE.C1
        else
            C05 = JE.Attachment0.CFrame
            C15 = JE.Attachment1.CFrame
        end

        local Entry12
        local SetT2 = AnimWorkers.setT
        SetT2( JE, ( CFrame2 * C05 ):Inverse( ) * CFrame3 * C15 )
        local Entry11 = Class[ JW ]

        if Entry11 == nil then
            local IsA6 = JW:IsA( "Motor6D" )
            Class[ JW ] = IsA6
            Entry12 = IsA6
        else
            Entry12 = Entry11
        end

        local C06, C16

        if Entry12 then
            C06 = AnimWorkers.getC0( JW )
            C16 = JW.C1
        else
            C06 = JW.Attachment0.CFrame
            C16 = JW.Attachment1.CFrame
        end

        local SetT3 = AnimWorkers.setT
        SetT3( JW, ( CFrame3 * C06 ):Inverse( ) * Argument4 * C16 )
    end
}
