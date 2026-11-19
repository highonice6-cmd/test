-- ReplicatedStorage.Weapons.AimAssist
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( script.Parent:WaitForChild( "ClientState" ) )
local Table = {
    Scale = 0.75,
    MaxRange = 400,
    DefaultRange = 300,
    FullPart = 0.65,
    EdgeStrength = 0.4,
    Radius = { Hip = 2.2, Aim = 3, Scope = 2 },
    MinAngle = {
        Hip = 0.031415926535897934,
        Aim = 0.038397243543875255,
        Scope = 0.017453292519943295
    },
    MaxAngle = 0.15707963267948966,
    Slow = { Hip = 0.2, Aim = 0.3, Scope = 0.25 },
    Follow = { Hip = 0.1, Aim = 0.35, Scope = 0 },
    FollowMax = 0.6981317007977318,
    Keep = 1.5,
    MouseCooldown = 0.6,
    InputMin = 0.2,
    LosEvery = 0.1,
    Touch = {
        Scale = 0.5,
        Radius = { Hip = 2.8, Aim = 4, Scope = 2.3 },
        MinAngle = {
            Hip = 0.04014257279586958,
            Aim = 0.05235987755982989,
            Scope = 0.024434609527920613
        },
        MaxAngle = 0.20943951023931956,
        Slow = { Hip = 0.22, Aim = 0.38, Scope = 0.3 },
        Follow = { Hip = 0, Aim = 0.55, Scope = 0.25 },
        FollowMax = 0.8726646259971648,
        Pull = { Hip = 0, Aim = 3, Scope = 0 },
        PullMax = 0.3490658503988659,
        Snap = 0.08726646259971647,
        SnapTime = 0.18,
        SnapCooldown = 1,
        ActWindow = 0.25
    }
}
local Table2 = { Params = Table, Debug = nil }
local LocalPlayer = Players.LocalPlayer
local WeaponData = require( script.Parent:WaitForChild( "WeaponData" ) )
local CrewShared = require( ReplicatedStorage:WaitForChild( "CrewShared" ) )

local function HeldConfig( Object )
    local Tool2
    local Tool = Object:FindFirstChildOfClass( "Tool" )
    Tool2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    return Tool2
end

local function RangeOf( Object )
    local Tool2
    local Tool = Object:FindFirstChildOfClass( "Tool" )
    Tool2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    local Range2

    if not Tool2 or not Tool2.Damage then
        Range2 = Table.DefaultRange
    else
        local Range = Tool2.Damage.Range

        if Range then
            Range2 = Range
        else
            Range2 = Table.DefaultRange
        end
    end

    return ( math.min( Range2, Table.MaxRange ) )
end

local function AssistOff( Object )
    local Tool2
    local Tool = Object:FindFirstChildOfClass( "Tool" )
    Tool2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    local Flag

    if Tool2 == nil then
        Flag = false
    elseif Tool2.Fire == nil then
        Flag = false
    elseif Tool2.Fire.Mode == "Rocket" then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function Scoped( Object )
    local Tool2
    local Tool = Object:FindFirstChildOfClass( "Tool" )
    Tool2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    local Flag

    if type( Tool2 ) == "table" then
        if type( Tool2.Handling ) == "table" then
            if Tool2.Handling.Scope == nil then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local CurrentCamera = workspace.CurrentCamera
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
local Value1 = nil
local Value2 = nil
local Class = setmetatable( { }, { __mode = "k" } )
local Value3 = nil
local Number = -math.huge
local Value4 = nil

local function Candidates()
    local Table = { }

    for Key, Value in Players:GetPlayers( ) do
        local Flag = if Value == LocalPlayer then false else Value.Character

        if Flag and not Flag:GetAttribute( "InSafeZone" ) and Value:GetAttribute( "InTutorial" ) == nil and not CrewShared.Same( LocalPlayer, Value ) then
            table.insert( Table, Flag )
        end
    end

    local Children2
    local Find = WorldRefs.Find( "Dummies" )
    Children2 = Find and Find:GetChildren( ) or { }
    local Value1 = nil

    for Key2, Value2 in Children2, nil, nil do
        if Value2:IsA( "Model" ) then
            table.insert( Table, Value2 )
        end
    end

    local Children
    local HoodLocal = workspace:FindFirstChild( "HoodLocal" )
    Children = HoodLocal and HoodLocal:GetChildren( ) or { }
    local Value3 = nil

    for Key3, Value4 in Children, nil, nil do
        local Torso
        local IsA = Value4:IsA( "Model" )

        if IsA then
            local UpperTorso = Value4:FindFirstChild( "UpperTorso" )

            if UpperTorso then
                Torso = UpperTorso
            else
                Torso = Value4:FindFirstChild( "Torso" )
            end
        else
            Torso = IsA
        end
        if Torso and Torso:IsA( "BasePart" ) and Torso.CanQuery then
            table.insert( Table, Value4 )
        end
    end

    return Table
end

local function BodyPoints( Self )
    local Humanoid = Self:FindFirstChildOfClass( "Humanoid" )

    if not Humanoid or Humanoid.Health <= 0 then
        return nil
    end

    local UpperTorso2
    local HumanoidRootPart = Self:FindFirstChild( "HumanoidRootPart" )
    local UpperTorso = Self:FindFirstChild( "UpperTorso" )

    if UpperTorso then
        UpperTorso2 = UpperTorso
    else
        local Torso = Self:FindFirstChild( "Torso" )

        if Torso then
            UpperTorso2 = Torso
        else
            UpperTorso2 = HumanoidRootPart
        end
    end
    if not HumanoidRootPart or not UpperTorso2 then
        return nil
    end

    local Position2
    local Head = Self:FindFirstChild( "Head" )
    local Position = UpperTorso2.Position
    Position2 = Head and Head.Position or UpperTorso2.Position + Vector3.new( 0, 1.5, 0 )
    return Position, Position2, HumanoidRootPart.Position - Vector3.new( 0, 2.5999999046325684, 0 )
end

local function Visible( Key, Argument2, List )
    local Entry = Class[ Key ]
    local Clock = os.clock( )

    if Entry and Clock - Entry.t < Table.LosEvery then
        return Entry.v
    end

    local Vehicle2
    local TableInner = { LocalPlayer.Character }
    local Table2 = { }
    local FX = workspace:FindFirstChild( "FX" )
    local ClientHitboxes = workspace:FindFirstChild( "ClientHitboxes" )
    local Vehicle = ClientState.Vehicle
    Vehicle2 = if Vehicle then ClientState.Vehicle.Model else Vehicle
    local Value1
    Table2[ 1 ] = FX
    Table2[ 2 ] = ClientHitboxes
    Table2[ 3 ] = Vehicle2
    Value1 = nil

    for Key2, Value in Table2, nil, nil do
        table.insert( TableInner, Value )
    end

    local Value2, Flag
    Value2 = nil

    for Key3, Value3 in List, nil, nil do
        local FilterDescendantsInstances = table.clone( TableInner )
        RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
        local Raycast = workspace:Raycast( Argument2, Value3 - Argument2, RaycastParams2 )
        local J = 1

        for J = 1, 3 do
            if not Raycast or not ( Raycast.Instance.Transparency > 0.3 ) or Raycast.Instance:IsDescendantOf( Key ) then
                break
            end

            table.insert( FilterDescendantsInstances, Raycast.Instance )
            RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
            Raycast = workspace:Raycast( Argument2, Value3 - Argument2, RaycastParams2 )
        end
        if Raycast then
            if not Raycast.Instance:IsDescendantOf( Key ) then
                continue
            end
        end

        Flag = true
        break
    end

    Class[ Key ] = { t = Clock, v = Flag }
    return Flag
end

local function AngleDiff( Argument1, Argument2 )
    return ( Argument2 - Argument1 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793
end

local function AnglesOf( Argument1 )
    local Unit = Argument1.Unit
    local Amount = -Unit.X
    return math.atan2( Amount, -Unit.Z ), ( math.asin( ( math.clamp( Unit.Y, -1, 1 ) ) ) )
end

local function ErrorTo( Argument1, Argument2 )
    local Position = Argument2 - Argument1.Position

    if Position.Magnitude < 0.01 then
        return 0, 0
    end
    local Unit = Argument1.LookVector.Unit
    local Amount = -Unit.X
    local Atan2 = math.atan2( Amount, -Unit.Z )
    local Asin = math.asin( ( math.clamp( Unit.Y, -1, 1 ) ) )
    local Unit2 = Position.Unit
    local Amount2 = -Unit2.X
    local Atan22 = math.atan2( Amount2, -Unit2.Z )
    local Asin2 = math.asin( ( math.clamp( Unit2.Y, -1, 1 ) ) )
    return ( Atan22 - Atan2 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793, Asin2 - Asin
end

local function ClampRot( Argument1, Argument2, Argument3 )
    local Sqrt = math.sqrt( Argument1 * Argument1 + Argument2 * Argument2 )

    if Argument3 < Sqrt then
        return Argument1 * Argument3 / Sqrt, Argument2 * Argument3 / Sqrt
    end
    return Argument1, Argument2
end

local function Reset()
    Value1 = nil
    Value2 = nil
    Table2.Debug = nil
    Value3 = nil
    Controls.TouchAssist = nil
end

local function TouchActing( Humanoid )
    local IsDown

    if os.clock( ) - ( Controls.LastTouchLook or -math.huge ) < Table.Touch.ActWindow then
        IsDown = true
    elseif Humanoid.MoveDirection.Magnitude > 0.1 then
        IsDown = true
    else
        IsDown = Controls.IsDown( "Fire" )
    end

    return IsDown
end

function Table2.Step( p1, p2 )
    -- Could not structure function #16
end
return Table2

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Acos2
local Captured = Argument1 - Upvalue1
local Magnitude = Captured.Magnitude

if Magnitude > 0.01 then
    local Acos = math.acos( ( math.clamp( Upvalue2:Dot( Captured / Magnitude ), -1, 1 ) ) )

    if Acos then
        Acos2 = Acos
    else
        Acos2 = 3.141592653589793
    end
else
    Acos2 = 3.141592653589793
end

return Acos2
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

return 1 - ( 1 - Upvalue1.EdgeStrength ) * math.clamp( ( Argument1 - Upvalue2 ) / ( Upvalue3 - Upvalue2 ), 0, 1 )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Argument1.score < Argument2.score and true or false
return Flag
]]
