-- StarterPlayer.PlayerModule.ControlModule.ClickToMoveController
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Success, Result = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( "UserExcludeNonCollidableForPathfinding" )
end )
local Success2 = Success and Result
local Success3, Result2 = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( "UserClickToMoveSupportAgentCanClimb2" )
end )
local Success4 = Success3 and Result2
local UserInputService = game:GetService( "UserInputService" )
local PathfindingService = game:GetService( "PathfindingService" )
local Players = game:GetService( "Players" )
game:GetService( "Debris" )
local Workspace = game:GetService( "Workspace" )
local CollectionService = game:GetService( "CollectionService" )
local GuiService = game:GetService( "GuiService" )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserRaycastUpdateAPI2" )
local UserFlag2 = Get.getUserFlag( "UserPSIASClickToMoveRelaxTeleport" )
local UserFlag3 = Get.getUserFlag( "UserPlayerScriptsRefactor2" )
local UserFlag4 = Get.getUserFlag( "UserDoubleJumpButtonFix" )
local CharacterContext = script.Parent.Parent:WaitForChild( "InputContexts" ):WaitForChild( "CharacterContext" )
local ClickToMoveAction = CharacterContext:WaitForChild( "ClickToMoveAction" )
local ClickToMovePositionAction = CharacterContext:WaitForChild( "ClickToMovePositionAction" )
local Flag = true
local Flag2 = true
local Flag3 = false
local Number = 1
local Number2 = 8
local LocalPlayer = Players.LocalPlayer
local ClickToMoveDisplay = require( script.Parent:WaitForChild( "ClickToMoveDisplay" ) )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
local Table = { }

if not UserFlag then
    local function FindCharacterAncestor( Object )
        if not Object then
            return
        end

        local Humanoid = Object:FindFirstChildOfClass( "Humanoid" )

        if Humanoid then
            return Object, Humanoid
        end
        return FindCharacterAncestor( Object.Parent )
    end

    Table.FindCharacterAncestor = FindCharacterAncestor

    local function Raycast( Argument1, Argument2, List )
        local FoundPartOnRayWithIgnoreList, FoundPartOnRayWithIgnoreList2, FoundPartOnRayWithIgnoreList3, FoundPartOnRayWithIgnoreList4 = Workspace:FindPartOnRayWithIgnoreList( Argument1, List or { } )

        if not FoundPartOnRayWithIgnoreList then
            return nil, nil
        end
        if Argument2 and FoundPartOnRayWithIgnoreList.CanCollide == false then
            local Humanoid2

            if FoundPartOnRayWithIgnoreList then
                local Humanoid = FoundPartOnRayWithIgnoreList:FindFirstChildOfClass( "Humanoid" )

                if Humanoid then
                    Humanoid2 = Humanoid
                else
                    _, Humanoid2 = FindCharacterAncestor( FoundPartOnRayWithIgnoreList.Parent )
                end
            else
                Humanoid2 = nil
            end
            if Humanoid2 == nil then
                table.insert( List or { }, FoundPartOnRayWithIgnoreList )
                return Raycast( Argument1, Argument2, List or { } )
            end
        end

        return FoundPartOnRayWithIgnoreList, FoundPartOnRayWithIgnoreList2, FoundPartOnRayWithIgnoreList3, FoundPartOnRayWithIgnoreList4
    end

    Table.Raycast = Raycast
end

local Table2 = { }

local function FindPlayerHumanoid( Key )
    if not ( Key and Key.Character ) then
        return
    end

    local Entry = Table2[ Key ]

    if Entry and Entry.Parent == ( Key and Key.Character ) then
        return Entry
    end

    Table2[ Key ] = nil
    local Humanoid = ( Key and Key.Character ):FindFirstChildOfClass( "Humanoid" )

    if Humanoid then
        Table2[ Key ] = Humanoid
    end

    return Humanoid
end

local Value1 = nil
local Value2 = nil
local Value3 = nil
local Value4 = nil

local function GetCharacter()
    return LocalPlayer and LocalPlayer.Character
end

local function UpdateIgnoreTag( Tag )
    if Tag == Value2 then
        return
    end
    if Value3 then
        Value3:Disconnect( )
        Value3 = nil
    end
    if Value4 then
        Value4:Disconnect( )
        Value4 = nil
    end

    Value2 = Tag
    local Table = { }
    Table[ 1 ] = LocalPlayer and LocalPlayer.Character
    Value1 = Table

    if Value2 ~= nil then
        for Index, Value in ipairs( ( CollectionService:GetTagged( Value2 ) ) ) do
            table.insert( Value1, Value )
        end

        Value3 = CollectionService:GetInstanceAddedSignal( Value2 ):Connect( function( Argument1 )
            table.insert( Value1, Argument1 )
        end )
        Value4 = CollectionService:GetInstanceRemovedSignal( Value2 ):Connect( function( Argument1 )
            local Count = #Value1
            local I = 1

            for I = 1, Count do
                if Value1[ I ] == Argument1 then
                    Value1[ I ] = Value1[ #Value1 ]
                    table.remove( Value1 )
                    return
                end
            end
        end )
    end
end

local function GetIgnoreList()
    if Value1 then
        return Value1
    end

    Value1 = { }
    assert( Value1, "" )
    table.insert( Value1, LocalPlayer and LocalPlayer.Character )
    return Value1
end

local function MinV( Argument1, Argument2 )
    local X = Argument1.X
    local Min = math.min( X, Argument2.X )
    local Y = Argument1.Y
    local Min2 = math.min( Y, Argument2.Y )
    local Z = Argument1.Z
    return ( Vector3.new( Min, Min2, ( math.min( Z, Argument2.Z ) ) ) )
end

local function MaxV( Argument1, Argument2 )
    local X = Argument1.X
    local Max = math.max( X, Argument2.X )
    local Y = Argument1.Y
    local Max2 = math.max( Y, Argument2.Y )
    local Z = Argument1.Z
    return ( Vector3.new( Max, Max2, ( math.max( Z, Argument2.Z ) ) ) )
end

local function GetCollidableExtentsSize( Model )
    if Model == nil or Model.PrimaryPart == nil then
        return
    end

    local Position, Position2
    assert( Model, "" )
    assert( Model.PrimaryPart, "" )
    local Inverse = Model.PrimaryPart.CFrame:Inverse( )
    Position = Vector3.new( -math.huge, -math.huge, -math.huge )
    Position2 = Vector3.new( math.huge, math.huge, math.huge )

    for Key, Value in pairs( Model:GetDescendants( ) ) do
        if Value:IsA( "BasePart" ) and Value.CanCollide then
            local Inverse2 = Inverse * Value.CFrame
            local X = Value.Size.X / 2
            local Y = Value.Size.Y / 2
            local Vector32 = Vector3.new( X, Y, Value.Size.Z / 2 )
            local X2 = Vector32.X
            local Y2 = Vector32.Y
            local Vector33 = Vector3.new( X2, Y2, Vector32.Z )
            local X3 = Vector32.X
            local Y3 = Vector32.Y
            local Vector34 = Vector3.new( X3, Y3, -Vector32.Z )
            local X4 = Vector32.X
            local Amount = -Vector32.Y
            local Vector35 = Vector3.new( X4, Amount, Vector32.Z )
            local X5 = Vector32.X
            local Amount2 = -Vector32.Y
            local Vector36 = Vector3.new( X5, Amount2, -Vector32.Z )
            local Amount3 = -Vector32.X
            local Y4 = Vector32.Y
            local Vector37 = Vector3.new( Amount3, Y4, Vector32.Z )
            local Amount4 = -Vector32.X
            local Y5 = Vector32.Y
            local Vector38 = Vector3.new( Amount4, Y5, -Vector32.Z )
            local Amount5 = -Vector32.X
            local Amount6 = -Vector32.Y
            local Vector39 = Vector3.new( Amount5, Amount6, Vector32.Z )
            local Amount7 = -Vector32.X
            local Amount8 = -Vector32.Y

            for Index, Value3 in ipairs( {
                Vector33,
                Vector34,
                Vector35,
                Vector36,
                Vector37,
                Vector38,
                Vector39,
                ( Vector3.new( Amount7, Amount8, -Vector32.Z ) )
            } ) do
                local Inverse3 = Inverse2 * Value3
                local X6 = Position2.X
                local Min = math.min( X6, Inverse3.X )
                local Y6 = Position2.Y
                local Min2 = math.min( Y6, Inverse3.Y )
                local Z = Position2.Z
                Position2 = Vector3.new( Min, Min2, ( math.min( Z, Inverse3.Z ) ) )
                local X7 = Position.X
                local Max = math.max( X7, Inverse3.X )
                local Y7 = Position.Y
                local Max2 = math.max( Y7, Inverse3.Y )
                local Z2 = Position.Z
                Position = Vector3.new( Max, Max2, ( math.max( Z2, Inverse3.Z ) ) )
            end
        end
    end

    local Position3 = Position - Position2

    if Position3.X < 0 or Position3.Y < 0 or Position3.Z < 0 then
        return nil
    end
    return Position3
end

local function Pather( OriginalTargetPoint, TargetSurfaceNormal, DirectPath )
    local DirectPath2, DirectPath3
    local Table = { }

    if DirectPath == nil then
        DirectPath2 = true
        DirectPath3 = Flag3
    else
        DirectPath2 = DirectPath
        DirectPath3 = DirectPath
    end

    Table.Cancelled = false
    Table.Started = false
    Table.Finished = Instance.new( "BindableEvent" )
    Table.PathFailed = Instance.new( "BindableEvent" )
    Table.PathComputing = false
    Table.PathComputed = false
    Table.OriginalTargetPoint = OriginalTargetPoint
    Table.TargetPoint = OriginalTargetPoint
    Table.TargetSurfaceNormal = TargetSurfaceNormal
    Table.DiedConn = nil
    Table.SeatedConn = nil
    Table.BlockedConn = nil
    Table.TeleportedConn = nil
    Table.CurrentPoint = 0
    Table.HumanoidOffsetFromPath = Vector3.new( 0, 0, 0 )
    Table.CurrentWaypointPosition = nil
    Table.CurrentWaypointPlaneNormal = Vector3.new( 0, 0, 0 )
    Table.CurrentWaypointPlaneDistance = 0
    Table.CurrentWaypointNeedsJump = false
    Table.CurrentHumanoidPosition = Vector3.new( 0, 0, 0 )
    Table.CurrentHumanoidVelocity = 0
    Table.NextActionMoveDirection = Vector3.new( 0, 0, 0 )
    Table.NextActionJump = false
    Table.Timeout = 0
    local Humanoid2

    if LocalPlayer and LocalPlayer.Character then
        local Entry = Table2[ LocalPlayer ]

        if not Entry or Entry.Parent ~= ( LocalPlayer and LocalPlayer.Character ) then
            Table2[ LocalPlayer ] = nil
            local Humanoid = ( LocalPlayer and LocalPlayer.Character ):FindFirstChildOfClass( "Humanoid" )

            if Humanoid then
                Table2[ LocalPlayer ] = Humanoid
            end

            Humanoid2 = Humanoid
        else
            Humanoid2 = Entry
        end
    else
        Humanoid2 = nil
    end

    local Humanoid4
    Table.Humanoid = Humanoid2
    Table.OriginPoint = nil
    Table.AgentCanFollowPath = false
    Table.DirectPath = false
    Table.DirectPathRiseFirst = false
    Table.stopTraverseFunc = nil
    Table.setPointFunc = nil
    Table.pointList = nil
    local Humanoid3 = Table.Humanoid
    Humanoid4 = if Humanoid3 then Table.Humanoid.RootPart else Humanoid3

    if Humanoid4 then
        local Captured, Captured2, FlagInner
        Table.OriginPoint = Humanoid4.CFrame.Position
        local PrimaryPart = Table.Humanoid.SeatPart

        if not PrimaryPart or not PrimaryPart:IsA( "VehicleSeat" ) then
            local ExtentsSize2

            if Success2 then
                if ( LocalPlayer and LocalPlayer.Character ) == nil then
                    ExtentsSize2 = nil
                else
                    ExtentsSize2 = GetCollidableExtentsSize( LocalPlayer and LocalPlayer.Character )
                end
            else
                ExtentsSize2 = nil
            end
            if ExtentsSize2 == nil then
                ExtentsSize2 = ( LocalPlayer and LocalPlayer.Character ):GetExtentsSize( )
            end

            assert( ExtentsSize2, "" )
            Captured = Number * 0.5 * math.sqrt( ExtentsSize2.X * ExtentsSize2.X + ExtentsSize2.Z * ExtentsSize2.Z )
            Captured2 = Number * ExtentsSize2.Y

            if Table.Humanoid.JumpPower > 0 then
                FlagInner = true
            else
                FlagInner = false
            end

            Table.AgentCanFollowPath = true
            Table.DirectPath = DirectPath3
            Table.DirectPathRiseFirst = Table.Humanoid.Sit
        else
            local Model = PrimaryPart:FindFirstAncestorOfClass( "Model" )

            if Model then
                local PrimaryPart2 = Model.PrimaryPart
                Model.PrimaryPart = PrimaryPart

                if DirectPath2 then
                    local ExtentsSize = Model:GetExtentsSize( )
                    Captured = Number * 0.5 * math.sqrt( ExtentsSize.X * ExtentsSize.X + ExtentsSize.Z * ExtentsSize.Z )
                    Captured2 = Number * ExtentsSize.Y
                    Table.AgentCanFollowPath = true
                    Table.DirectPath = DirectPath2
                    FlagInner = false
                else
                    Captured = 2
                    Captured2 = 5
                    FlagInner = true
                end

                Model.PrimaryPart = PrimaryPart2
            else
                Captured = 2
                Captured2 = 5
                FlagInner = true
            end
        end
        if Success4 then
            Table.pathResult = PathfindingService:CreatePath( {
                AgentRadius = Captured,
                AgentHeight = Captured2,
                AgentCanJump = FlagInner,
                AgentCanClimb = true
            } )
        else
            Table.pathResult = PathfindingService:CreatePath( {
                AgentRadius = Captured,
                AgentHeight = Captured2,
                AgentCanJump = FlagInner
            } )
        end
    end

    function Table.Cleanup( Argument1 )
        if Table.stopTraverseFunc then
            Table.stopTraverseFunc( )
            Table.stopTraverseFunc = nil
        end
        if Table.BlockedConn then
            Table.BlockedConn:Disconnect( )
            Table.BlockedConn = nil
        end
        if Table.DiedConn then
            Table.DiedConn:Disconnect( )
            Table.DiedConn = nil
        end
        if Table.SeatedConn then
            Table.SeatedConn:Disconnect( )
            Table.SeatedConn = nil
        end
        if Table.TeleportedConn then
            Table.TeleportedConn:Disconnect( )
            Table.TeleportedConn = nil
        end

        Table.Started = false
    end
    function Table.Cancel( Argument1 )
        Table.Cancelled = true
        Table:Cleanup( )
    end
    function Table.IsActive( Argument1 )
        local AgentCanFollowPath2
        local AgentCanFollowPath = Table.AgentCanFollowPath

        if AgentCanFollowPath then
            local Started = Table.Started

            if Started then
                AgentCanFollowPath2 = not Table.Cancelled
            else
                AgentCanFollowPath2 = Started
            end
        else
            AgentCanFollowPath2 = AgentCanFollowPath
        end

        return AgentCanFollowPath2
    end
    function Table.OnPathInterrupted( Argument1 )
        Table.Cancelled = true
        Table:OnPointReached( false )
    end
    function Table.ComputePath( p1 )
        -- Could not structure function #18
    end
    function Table.IsValidPath( Argument1 )
        local PathComputed2
        Table:ComputePath( )
        local PathComputed = Table.PathComputed
        PathComputed2 = if PathComputed then Table.AgentCanFollowPath else PathComputed
        return PathComputed2
    end
    Table.Recomputing = false
    function Table.OnPathBlocked( Argument1, Argument2 )
        local FlagInner = Table.CurrentPoint <= Argument2 and true or false

        if not FlagInner or Table.Recomputing then
            return
        end

        Table.Recomputing = true

        if Table.stopTraverseFunc then
            Table.stopTraverseFunc( )
            Table.stopTraverseFunc = nil
        end

        Table.OriginPoint = Table.Humanoid.RootPart.CFrame.Position
        Table.pathResult:ComputeAsync( Table.OriginPoint, Table.TargetPoint )
        Table.pointList = Table.pathResult:GetWaypoints( )

        if #Table.pointList > 0 then
            Table.HumanoidOffsetFromPath = Table.pointList[ 1 ].Position - Table.OriginPoint
        end

        local PathComputed = Table.pathResult.Status == Enum.PathStatus.Success and true or false
        Table.PathComputed = PathComputed

        if Flag then
            local StopTraverseFunc, SetPointFunc = ClickToMoveDisplay.CreatePathDisplay( Table.pointList )
            Table.stopTraverseFunc = StopTraverseFunc
            Table.setPointFunc = SetPointFunc
        end
        if Table.PathComputed then
            Table.CurrentPoint = 1
            Table:OnPointReached( true )
        else
            Table.PathFailed:Fire( )
            Table:Cleanup( )
        end

        Table.Recomputing = false
    end
    function Table.OnRenderStepped( Argument1, Argument2 )
        if Table.Started and not Table.Cancelled then
            Table.Timeout = Table.Timeout + Argument2

            if Number2 < Table.Timeout then
                Table:OnPointReached( false )
                return
            end

            Table.CurrentHumanoidPosition = Table.Humanoid.RootPart.Position + Table.HumanoidOffsetFromPath
            Table.CurrentHumanoidVelocity = Table.Humanoid.RootPart.Velocity

            while Table.Started do
                if not Table:IsCurrentWaypointReached( ) then
                    break
                end

                Table:OnPointReached( true )
            end
            if Table.Started then
                Table.NextActionMoveDirection = Table.CurrentWaypointPosition - Table.CurrentHumanoidPosition

                if Table.NextActionMoveDirection.Magnitude > 1e-06 then
                    Table.NextActionMoveDirection = Table.NextActionMoveDirection.Unit
                else
                    Table.NextActionMoveDirection = Vector3.new( 0, 0, 0 )
                end
                if Table.CurrentWaypointNeedsJump then
                    Table.NextActionJump = true
                    Table.CurrentWaypointNeedsJump = false
                    return
                end

                Table.NextActionJump = false
            end
        end
    end
    function Table.IsCurrentWaypointReached( Argument1 )
        local Flag

        if Table.CurrentWaypointPlaneNormal == Vector3.new( 0, 0, 0 ) then
            Flag = true
        elseif Table.CurrentWaypointPlaneNormal:Dot( Table.CurrentHumanoidPosition ) - Table.CurrentWaypointPlaneDistance < math.max( 1, 0.0625 * -Table.CurrentWaypointPlaneNormal:Dot( Table.CurrentHumanoidVelocity ) ) then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            Table.CurrentWaypointPosition = nil
            Table.CurrentWaypointPlaneNormal = Vector3.new( 0, 0, 0 )
            Table.CurrentWaypointPlaneDistance = 0
        end

        return Flag
    end
    function Table.OnPointReached( Argument1, Argument2 )
        if not Argument2 or Table.Cancelled then
            Table.PathFailed:Fire( )
            Table:Cleanup( )
            return
        end
        if Table.setPointFunc then
            Table.setPointFunc( Table.CurrentPoint )
        end

        local CurrentPoint = Table.CurrentPoint + 1

        if #Table.pointList < CurrentPoint then
            if Table.stopTraverseFunc then
                Table.stopTraverseFunc( )
            end

            Table.Finished:Fire( )
            Table:Cleanup( )
            return
        end
        local Flag
        local Entry = Table.pointList[ Table.CurrentPoint ]
        local Entry2 = Table.pointList[ CurrentPoint ]
        local State = Table.Humanoid:GetState( )

        if State == Enum.HumanoidStateType.FallingDown then
            Flag = true
        elseif State == Enum.HumanoidStateType.Freefall then
            Flag = true
        elseif State == Enum.HumanoidStateType.Jumping then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            local Flag2

            if Entry2.Action == Enum.PathWaypointAction.Jump then
                Flag2 = true
            else
                Flag2 = false
            end
            if not Flag2 and Table.CurrentPoint > 1 then
                local Entry3 = Table.pointList[ Table.CurrentPoint - 1 ]
                local Position = Entry.Position - Entry3.Position
                local Position2 = Entry2.Position - Entry.Position

                if Vector2.new( Position.x, Position.z ).Unit:Dot( Vector2.new( Position2.x, Position2.z ).Unit ) < 0.996 then
                    Flag2 = true
                else
                    Flag2 = false
                end
            end
            if Flag2 then
                Table.Humanoid.FreeFalling:Wait( )
                wait( 0.1 )
            end
        end

        Table:MoveToNextWayPoint( Entry, Entry2, CurrentPoint )
        return
    end
    function Table.MoveToNextWayPoint( Argument1, Argument2, Argument3, CurrentPoint )
        Table.CurrentWaypointPlaneNormal = Argument2.Position - Argument3.Position

        if not Success4 or Argument3.Label ~= "Climb" then
            local X = Table.CurrentWaypointPlaneNormal.X
            Table.CurrentWaypointPlaneNormal = Vector3.new( X, 0, Table.CurrentWaypointPlaneNormal.Z )
        end
        if Table.CurrentWaypointPlaneNormal.Magnitude > 1e-06 then
            Table.CurrentWaypointPlaneNormal = Table.CurrentWaypointPlaneNormal.Unit
            Table.CurrentWaypointPlaneDistance = Table.CurrentWaypointPlaneNormal:Dot( Argument3.Position )
        else
            Table.CurrentWaypointPlaneNormal = Vector3.new( 0, 0, 0 )
            Table.CurrentWaypointPlaneDistance = 0
        end

        local CurrentWaypointNeedsJump = Argument3.Action == Enum.PathWaypointAction.Jump and true or false
        Table.CurrentWaypointNeedsJump = CurrentWaypointNeedsJump
        Table.CurrentWaypointPosition = Argument3.Position
        Table.CurrentPoint = CurrentPoint
        Table.Timeout = 0
    end
    function Table.Start( Argument1, Argument2 )
        if not Table.AgentCanFollowPath then
            Table.PathFailed:Fire( )
            return
        end
        if Table.Started then
            return
        end

        Table.Started = true
        ClickToMoveDisplay.CancelFailureAnimation( )

        if Flag then
            if Argument2 == nil or Argument2 then
                local StopTraverseFunc, SetPointFunc = ClickToMoveDisplay.CreatePathDisplay( Table.pointList, Table.OriginalTargetPoint )
                Table.stopTraverseFunc = StopTraverseFunc
                Table.setPointFunc = SetPointFunc
            end
        end
        if #Table.pointList > 0 then
            Table.HumanoidOffsetFromPath = Vector3.new( 0, Table.pointList[ 1 ].Position.Y - Table.OriginPoint.Y, 0 )
            Table.CurrentHumanoidPosition = Table.Humanoid.RootPart.Position + Table.HumanoidOffsetFromPath
            Table.CurrentHumanoidVelocity = Table.Humanoid.RootPart.Velocity
            Table.SeatedConn = Table.Humanoid.Seated:Connect( function( Argument1, Argument2 )
                Table:OnPathInterrupted( )
            end )
            Table.DiedConn = Table.Humanoid.Died:Connect( function()
                Table:OnPathInterrupted( )
            end )

            if UserFlag2 then
                Table.lastPosition = Table.Humanoid.RootPart.CFrame.Position
                Table.TeleportedConn = Table.Humanoid.RootPart:GetPropertyChangedSignal( "CFrame" ):Connect( function()
                    local LastPosition = Table.Humanoid.RootPart.CFrame.Position
                    local Magnitude = ( LastPosition - Table.lastPosition ).Magnitude
                    Table.lastPosition = LastPosition

                    if Table.Humanoid.WalkSpeed < Magnitude then
                        Table:OnPathInterrupted( )
                    end
                end )
            else
                Table.TeleportedConn = Table.Humanoid.RootPart:GetPropertyChangedSignal( "CFrame" ):Connect( function()
                    Table:OnPathInterrupted( )
                end )
            end

            Table.CurrentPoint = 1
            Table:OnPointReached( true )
            return
        end
        Table.PathFailed:Fire( )

        if Table.stopTraverseFunc then
            Table.stopTraverseFunc( )
        end

        return
    end
    local TargetPoint = Table.TargetPoint + Table.TargetSurfaceNormal * 1.5

    if UserFlag then
        local FilterDescendantsInstances

        if Value1 then
            FilterDescendantsInstances = Value1
        else
            Value1 = { }
            assert( Value1, "" )
            table.insert( Value1, LocalPlayer and LocalPlayer.Character )
            FilterDescendantsInstances = Value1
        end

        RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
        local Raycast = Workspace:Raycast( TargetPoint, Vector3.new( -0, -50, -0 ), RaycastParams2 )

        if Raycast then
            Table.TargetPoint = Raycast.Position
        end
    else
        local Captured3
        local Ray2 = Ray.new( TargetPoint, Vector3.new( 0, -50, 0 ) )

        if Value1 then
            Captured3 = Value1
        else
            Value1 = { }
            assert( Value1, "" )
            table.insert( Value1, LocalPlayer and LocalPlayer.Character )
            Captured3 = Value1
        end

        local FoundPartOnRayWithIgnoreList, TargetPoint2 = Workspace:FindPartOnRayWithIgnoreList( Ray2, Captured3 )

        if FoundPartOnRayWithIgnoreList then
            Table.TargetPoint = TargetPoint2
        end
    end

    Table:ComputePath( )
    return Table
end

local function CheckAlive()
    local Entry2

    if LocalPlayer and LocalPlayer.Character then
        local Entry = Table2[ LocalPlayer ]

        if not Entry or Entry.Parent ~= ( LocalPlayer and LocalPlayer.Character ) then
            Table2[ LocalPlayer ] = nil
            local Humanoid = ( LocalPlayer and LocalPlayer.Character ):FindFirstChildOfClass( "Humanoid" )

            if Humanoid then
                Table2[ LocalPlayer ] = Humanoid
            end

            Entry2 = Humanoid
        else
            Entry2 = Entry
        end
    else
        Entry2 = nil
    end

    local Flag

    if Entry2 == nil then
        Flag = false
    elseif Entry2.Health > 0 then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function GetEquippedTool( Character )
    if Character ~= nil then
        for Key, Value in pairs( Character:GetChildren( ) ) do
            if Value:IsA( "Tool" ) then
                return Value
            end
        end
    end
end

local function DisconnectEvent( Connection )
    if Connection then
        Connection:Disconnect( )
    end
end

local function CalculateLocalMoveVector( Argument1 )
    local X = Argument1.X
    local Vector32 = Vector3.new( X, 0, Argument1.Z )

    if Vector32.Magnitude < 1e-06 then
        return Vector2.zero
    end

    local Unit = Vector32.Unit
    local CurrentCamera = Workspace.CurrentCamera

    if CurrentCamera then
        local _, ToEulerAnglesYXZ2 = CurrentCamera.CFrame:ToEulerAnglesYXZ( )
        local VectorToObjectSpace = CFrame.Angles( 0, ToEulerAnglesYXZ2, 0 ):VectorToObjectSpace( Unit )
        return Vector2.new( VectorToObjectSpace.X, -VectorToObjectSpace.Z )
    end
    return Vector2.new( Unit.X, -Unit.Z )
end

local __index = { }
__index.__index = __index
function __index.new( Argument1 )
    local Self = setmetatable( { }, __index )
    Self.mouse2DownTime = tick( )
    Self.mouse2DownPos = Vector2.new( )
    Self.mouse2UpTime = tick( )
    Self.humanoidDiedConn = nil
    Self.characterChildAddedConn = nil
    Self.onCharacterAddedConn = nil
    Self.characterChildRemovedConn = nil
    Self.renderSteppedConn = nil
    Self.menuOpenedConnection = nil
    Self.preferredInputChangedConnection = nil

    if not UserFlag4 then
        Self.jumpEnabled = true
    end

    Self.clickPressedConn = nil
    Self.clickReleasedConn = nil
    Self.shouldCleanupPath = false
    Self.lastPatherJumped = false
    Self.data = nil
    Self.running = false
    return Self
end
local Value5 = nil
local Value6 = nil
local Value7 = nil
function __index.CleanupPath( Argument1 )
    if Value5 then
        Value5:Cancel( )
        Value5 = nil
    end
    if Value6 then
        Value6:Disconnect( )
        Value6 = nil
    end
    if Value7 then
        Value7:Disconnect( )
        Value7 = nil
    end

    Argument1.shouldCleanupPath = true
end
function __index.HandleMoveTo( Argument1, Argument2, Argument3, Argument4, Argument5, Argument6 )
    Argument1.shouldCleanupPath = false

    if Value5 then
        Argument1:CleanupPath( )
    end

    Value5 = Argument2
    Argument2:Start( Argument6 )
    Value6 = Argument2.Finished.Event:Connect( function()
        Argument1:CleanupPath( )

        if Argument4 then
            local EquippedTool = GetEquippedTool( Argument5 )

            if EquippedTool then
                EquippedTool:Activate( )
            end
        end
    end )
    Value7 = Argument2.PathFailed.Event:Connect( function()
        Argument1:CleanupPath( )

        if Argument6 == nil or Argument6 then
            local Captured = if Flag2 then not ( Value5 and Value5:IsActive( ) ) else Flag2

            if Captured then
                ClickToMoveDisplay.PlayFailureAnimation( )
            end

            ClickToMoveDisplay.DisplayFailureWaypoint( Argument3 )
        end
    end )
end
function __index.ShowPathFailedFeedback( Argument1, Argument2 )
    if Value5 and Value5:IsActive( ) then
        Value5:Cancel( )
    end
    if Flag2 then
        ClickToMoveDisplay.PlayFailureAnimation( )
    end

    ClickToMoveDisplay.DisplayFailureWaypoint( Argument2 )
end
function __index.OnTap( Self, List, OriginalTargetPoint )
    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local Entry2

    if LocalPlayer and LocalPlayer.Character then
        local Entry = Table2[ LocalPlayer ]

        if not Entry or Entry.Parent ~= ( LocalPlayer and LocalPlayer.Character ) then
            Table2[ LocalPlayer ] = nil
            local Humanoid = ( LocalPlayer and LocalPlayer.Character ):FindFirstChildOfClass( "Humanoid" )

            if Humanoid then
                Table2[ LocalPlayer ] = Humanoid
            end

            Entry2 = Humanoid
        else
            Entry2 = Entry
        end
    else
        Entry2 = nil
    end

    local Flag

    if Entry2 == nil then
        Flag = false
    elseif Entry2.Health > 0 then
        Flag = true
    else
        Flag = false
    end
    if not Flag then
        return
    end
    if #List == 1 or OriginalTargetPoint then
        if CurrentCamera then
            local ScreenPointToRay = CurrentCamera:ScreenPointToRay( List[ 1 ].X, List[ 1 ].Y )

            if UserFlag then
                local FilterDescendantsInstances

                if Value1 then
                    FilterDescendantsInstances = Value1
                else
                    Value1 = { }
                    assert( Value1, "" )
                    table.insert( Value1, LocalPlayer and LocalPlayer.Character )
                    FilterDescendantsInstances = Value1
                end

                local Raycast, Instance3

                if FilterDescendantsInstances then
                    Instance3 = nil
                else
                    FilterDescendantsInstances = { }
                    Instance3 = nil
                end
                while true do
                    local Flag2
                    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
                    Raycast = Workspace:Raycast( ScreenPointToRay.Origin, ScreenPointToRay.Direction * 1000, RaycastParams2 )

                    if Raycast then
                        local Instance2, Humanoid2, Parent
                        local Instance = Raycast.Instance

                        if Instance.CanCollide then
                            Flag2 = true
                        else
                            Instance2 = Instance

                            while true do
                                Humanoid2 = Instance2:FindFirstChildOfClass( "Humanoid" )
                                Parent = Instance2.Parent

                                if Humanoid2 then
                                    break
                                end
                                if not Parent then
                                    break
                                end

                                Instance2 = Parent
                            end
                            if Humanoid2 or not Parent then
                                Flag2 = true
                                Instance3 = Instance2
                            else
                                table.insert( FilterDescendantsInstances, Parent )
                                Flag2 = false
                                Instance3 = nil
                            end
                        end
                    else
                        Flag2 = true
                    end
                    if Flag2 then
                        break
                    end
                end
                if not Raycast or not Character then
                    return
                end

                local Position = Raycast.Position

                if OriginalTargetPoint then
                    Position = OriginalTargetPoint
                    Instance3 = nil
                end

                Self:CleanupPath( )
                local Pather2 = Pather( Position, Raycast.Normal )

                if Pather2:IsValidPath( ) then
                    Self:HandleMoveTo( Pather2, Position, Instance3, Character )
                    return
                end
                Pather2:Cleanup( )
                Self:ShowPathFailedFeedback( Position )
                return
            else
                local Captured
                local Ray2 = Ray.new( ScreenPointToRay.Origin, ScreenPointToRay.Direction * 1000 )
                local Raycast2 = Table.Raycast

                if Value1 then
                    Captured = Value1
                else
                    Value1 = { }
                    assert( Value1, "" )
                    table.insert( Value1, LocalPlayer and LocalPlayer.Character )
                    Captured = Value1
                end

                local Raycast3, Raycast22, Raycast32 = Raycast2( Ray2, true, Captured )
                local FindCharacterAncestor = Table.FindCharacterAncestor( Raycast3 )

                if OriginalTargetPoint then
                    Raycast22 = OriginalTargetPoint
                    FindCharacterAncestor = nil
                end
                if Raycast22 and Character then
                    Self:CleanupPath( )
                    local Pather3 = Pather( Raycast22, Raycast32 )

                    if Pather3:IsValidPath( ) then
                        Self:HandleMoveTo( Pather3, Raycast22, FindCharacterAncestor, Character )
                        return
                    end
                    Pather3:Cleanup( )
                    Self:ShowPathFailedFeedback( Raycast22 )
                    return
                end
            end
        end
    elseif #List >= 2 and CurrentCamera then
        local EquippedTool = GetEquippedTool( Character )

        if EquippedTool then
            EquippedTool:Activate( )
        end
    end
end
function __index.DisconnectEvents( Argument1 )
    local HumanoidDiedConn = Argument1.humanoidDiedConn

    if HumanoidDiedConn then
        HumanoidDiedConn:Disconnect( )
    end

    local CharacterChildAddedConn = Argument1.characterChildAddedConn

    if CharacterChildAddedConn then
        CharacterChildAddedConn:Disconnect( )
    end

    local OnCharacterAddedConn = Argument1.onCharacterAddedConn

    if OnCharacterAddedConn then
        OnCharacterAddedConn:Disconnect( )
    end

    local RenderSteppedConn = Argument1.renderSteppedConn

    if RenderSteppedConn then
        RenderSteppedConn:Disconnect( )
    end

    local CharacterChildRemovedConn = Argument1.characterChildRemovedConn

    if CharacterChildRemovedConn then
        CharacterChildRemovedConn:Disconnect( )
    end

    local MenuOpenedConnection = Argument1.menuOpenedConnection

    if MenuOpenedConnection then
        MenuOpenedConnection:Disconnect( )
    end

    local PreferredInputChangedConnection = Argument1.preferredInputChangedConnection

    if PreferredInputChangedConnection then
        PreferredInputChangedConnection:Disconnect( )
    end

    local ClickPressedConn = Argument1.clickPressedConn

    if ClickPressedConn then
        ClickPressedConn:Disconnect( )
    end

    local ClickReleasedConn = Argument1.clickReleasedConn

    if ClickReleasedConn then
        ClickReleasedConn:Disconnect( )
    end
end
function __index.OnPreferredInputChanged( Input )
    local Character = LocalPlayer.Character

    if Character then
        local ManualActivationOnly = UserInputService.PreferredInput == Enum.PreferredInput.Touch and true or false

        for Key, Value in pairs( Character:GetChildren( ) ) do
            if Value:IsA( "Tool" ) then
                Value.ManualActivationOnly = ManualActivationOnly
            end
        end
    end
end
function __index.OnCharacterAdded( Argument1, Object )
    Argument1:DisconnectEvents( )
    Argument1.clickPressedConn = ClickToMoveAction.Pressed:Connect( function()
        local GuiInset = GuiService:GetGuiInset( )
        local State = ClickToMovePositionAction:GetState( )

        if State.X == -1 and State.Y == -1 then
            return
        end

        local Mouse2DownPos

        if UserFlag3 then
            local Min = GuiService:GetInsetArea( Enum.ScreenInsets.None ).Min
            Mouse2DownPos = Vector2.new( State.X + Min.X, State.Y + Min.Y )
        else
            Mouse2DownPos = Vector2.new( State.X - GuiInset.X, State.Y - GuiInset.Y )
        end

        Argument1.mouse2DownPos = Mouse2DownPos
        Argument1.mouse2DownTime = tick( )
    end )
    Argument1.clickReleasedConn = ClickToMoveAction.Released:Connect( function()
        Argument1.mouse2UpTime = tick( )
        local Mouse2DownPos = Argument1.mouse2DownPos

        if not Argument1.data or not Argument1.data.controlModule.actions.MoveAction then
            return
        end

        local Captured

        if Value5 then
            Captured = Value5
        elseif Argument1.data.controlModule.actions.MoveAction:GetState( ).Magnitude <= 0 then
            Captured = true
        else
            Captured = false
        end
        if Argument1.mouse2UpTime - Argument1.mouse2DownTime < 0.25 and Captured then
            Argument1:OnTap( { Mouse2DownPos } )
        end
    end )
    Argument1.menuOpenedConnection = GuiService.MenuOpened:Connect( function()
        Argument1:CleanupPath( )
    end )

    local function OnCharacterChildAdded( Self )
        if UserInputService.PreferredInput == Enum.PreferredInput.Touch and Self:IsA( "Tool" ) then
            Self.ManualActivationOnly = true
        end
        if Self:IsA( "Humanoid" ) then
            local HumanoidDiedConn = Argument1.humanoidDiedConn

            if HumanoidDiedConn then
                HumanoidDiedConn:Disconnect( )
            end

            Argument1.humanoidDiedConn = Self.Died:Connect( function()
            end )
        end
    end

    Argument1.characterChildAddedConn = Object.ChildAdded:Connect( function( Self )
        OnCharacterChildAdded( Self )
    end )
    Argument1.characterChildRemovedConn = Object.ChildRemoved:Connect( function( Self )
        if UserInputService.PreferredInput == Enum.PreferredInput.Touch and Self:IsA( "Tool" ) then
            Self.ManualActivationOnly = false
        end
    end )

    for Key, Value in pairs( Object:GetChildren( ) ) do
        OnCharacterChildAdded( Value )
    end

    Argument1.preferredInputChangedConnection = UserInputService:GetPropertyChangedSignal( "PreferredInput" ):Connect( function()
        Argument1:OnPreferredInputChanged( )
    end )
end
function __index.Start( Argument1 )
    Argument1:Enable( true )
end
function __index.Stop( Argument1 )
    Argument1:Enable( false )
end
function __index.Enable( Argument1, Enabled, WasdEnabled, TouchJumpController )
    if Enabled then
        if not Argument1.running then
            if LocalPlayer.Character then
                Argument1:OnCharacterAdded( LocalPlayer.Character )
            end

            Argument1.onCharacterAddedConn = LocalPlayer.CharacterAdded:Connect( function( Argument1Inner )
                Argument1:OnCharacterAdded( Argument1Inner )
            end )
            Argument1.running = true
        end
        if not UserFlag4 then
            Argument1.touchJumpController = TouchJumpController

            if Argument1.touchJumpController then
                Argument1.touchJumpController:Enable( Argument1.jumpEnabled )
            end
        end
    else
        if Argument1.running then
            Argument1:DisconnectEvents( )
            Argument1:CleanupPath( )

            if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                local Character = LocalPlayer.Character

                if Character then
                    for Key, Value in pairs( Character:GetChildren( ) ) do
                        if Value:IsA( "Tool" ) then
                            Value.ManualActivationOnly = false
                        end
                    end
                end
            end

            Argument1.running = false
        end
        if not UserFlag4 then
            if Argument1.touchJumpController and not Argument1.jumpEnabled then
                Argument1.touchJumpController:Enable( true )
            end

            Argument1.touchJumpController = nil
        end
    end

    local WasdEnabled2
    ClickToMoveAction.Enabled = Enabled
    ClickToMovePositionAction.Enabled = Enabled
    WasdEnabled2 = Enabled and WasdEnabled or false
    Argument1.wasdEnabled = WasdEnabled2
    Argument1.enabled = Enabled
end
function __index.Update( Argument1, Data, Argument3 )
    assert( Data.controlModule.actions.MoveAction )
    assert( Data.controlModule.actions.JumpAction )

    if not Argument1.data then
        Argument1.data = Data
    end
    if Value5 then
        Value5:OnRenderStepped( Argument3 )

        if not Value5 or Value5 ~= Value5 then
            if Argument1.lastPatherJumped then
                if Data.controlModule.actions.JumpAction:GetState( ) == true then
                    local ClickToMoveScriptableBinding4 = Data.controlModule.actions.JumpAction:FindFirstChild( "ClickToMoveScriptableBinding" )

                    if ClickToMoveScriptableBinding4 then
                        ClickToMoveScriptableBinding4:Fire( false )
                    end
                end

                Argument1.lastPatherJumped = false
            end
        else
            local MoveVector = CalculateLocalMoveVector( Value5.NextActionMoveDirection )
            local ClickToMoveScriptableBinding = Data.controlModule.actions.MoveAction:FindFirstChild( "ClickToMoveScriptableBinding" )

            if ClickToMoveScriptableBinding then
                ClickToMoveScriptableBinding:Fire( MoveVector )
            end

            Data.controlModule.moveVector = MoveVector

            if Value5.NextActionJump then
                if Data.controlModule.actions.JumpAction:GetState( ) ~= true then
                    local ClickToMoveScriptableBinding2 = Data.controlModule.actions.JumpAction:FindFirstChild( "ClickToMoveScriptableBinding" )

                    if ClickToMoveScriptableBinding2 then
                        ClickToMoveScriptableBinding2:Fire( true )
                    end
                end

                Argument1.lastPatherJumped = true
                Data.controlModule.isJumping = true
            elseif Argument1.lastPatherJumped then
                if Data.controlModule.actions.JumpAction:GetState( ) == true then
                    local ClickToMoveScriptableBinding3 = Data.controlModule.actions.JumpAction:FindFirstChild( "ClickToMoveScriptableBinding" )

                    if ClickToMoveScriptableBinding3 then
                        ClickToMoveScriptableBinding3:Fire( false )
                    end
                end

                Argument1.lastPatherJumped = false
                Data.controlModule.isJumping = false
            end
        end
    end
    if Argument1.shouldCleanupPath then
        Argument1.shouldCleanupPath = false
        local ClickToMoveScriptableBinding5 = Data.controlModule.actions.MoveAction:FindFirstChild( "ClickToMoveScriptableBinding" )

        if ClickToMoveScriptableBinding5 then
            ClickToMoveScriptableBinding5:Fire( Vector2.zero )
        end

        Data.controlModule.moveVector = Vector2.zero
        Argument1.lastPatherJumped = false
        local ClickToMoveScriptableBinding6 = Data.controlModule.actions.JumpAction:FindFirstChild( "ClickToMoveScriptableBinding" )

        if ClickToMoveScriptableBinding6 then
            ClickToMoveScriptableBinding6:Fire( false )
        end

        Data.controlModule.isJumping = false
    end
end
function __index.SetShowPath( Argument1, Argument2 )
    Flag = Argument2
end
function __index.GetShowPath( Argument1 )
    return Flag
end
function __index.SetWaypointTexture( Argument1, Argument2 )
    ClickToMoveDisplay.SetWaypointTexture( Argument2 )
end
function __index.GetWaypointTexture( Argument1 )
    return ClickToMoveDisplay.GetWaypointTexture( )
end
function __index.SetWaypointRadius( Argument1, Argument2 )
    ClickToMoveDisplay.SetWaypointRadius( Argument2 )
end
function __index.GetWaypointRadius( Argument1 )
    return ClickToMoveDisplay.GetWaypointRadius( )
end
function __index.SetEndWaypointTexture( Argument1, Argument2 )
    ClickToMoveDisplay.SetEndWaypointTexture( Argument2 )
end
function __index.GetEndWaypointTexture( Argument1 )
    return ClickToMoveDisplay.GetEndWaypointTexture( )
end
function __index.SetWaypointsAlwaysOnTop( Argument1, Argument2 )
    ClickToMoveDisplay.SetWaypointsAlwaysOnTop( Argument2 )
end
function __index.GetWaypointsAlwaysOnTop( Argument1 )
    return ClickToMoveDisplay.GetWaypointsAlwaysOnTop( )
end
function __index.SetFailureAnimationEnabled( Argument1, Argument2 )
    Flag2 = Argument2
end
function __index.GetFailureAnimationEnabled( Argument1 )
    return Flag2
end
function __index.SetIgnoredPartsTag( Argument1, Tag )
    UpdateIgnoreTag( Tag )
end
function __index.GetIgnoredPartsTag( Argument1 )
    return Value2
end
function __index.SetUseDirectPath( Argument1, Argument2 )
    Flag3 = Argument2
end
function __index.GetUseDirectPath( Argument1 )
    return Flag3
end
function __index.SetAgentSizeIncreaseFactor( Argument1, Amount )
    Number = Amount / 100 + 1
end
function __index.GetAgentSizeIncreaseFactor( Argument1 )
    return ( Number - 1 ) * 100
end
function __index.SetUnreachableWaypointTimeout( Argument1, Argument2 )
    Number2 = Argument2
end
function __index.GetUnreachableWaypointTimeout( Argument1 )
    return Number2
end

if not UserFlag4 then
    function __index.SetUserJumpEnabled( Argument1, JumpEnabled )
        Argument1.jumpEnabled = JumpEnabled

        if Argument1.touchJumpController then
            Argument1.touchJumpController:Enable( JumpEnabled )
        end
    end
    function __index.GetUserJumpEnabled( Argument1 )
        return Argument1.jumpEnabled
    end
end

function __index.MoveTo( Argument1, OriginalTargetPoint, Argument3, DirectPath )
    local Character = LocalPlayer.Character

    if Character == nil then
        return false
    end

    local Pather2 = Pather( OriginalTargetPoint, Vector3.new( 0, 1, 0 ), DirectPath )

    if not Pather2 or not Pather2:IsValidPath( ) then
        return false
    end
    Argument1:HandleMoveTo( Pather2, OriginalTargetPoint, nil, Character, Argument3 )
    return true
end
return __index

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:OnPathBlocked( Argument1 )
]]
