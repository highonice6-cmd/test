-- ReplicatedStorage.RankedShared.VictoryScene
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ContextActionService = game:GetService( "ContextActionService" )
local Lighting = game:GetService( "Lighting" )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local SoundService = game:GetService( "SoundService" )
local StarterGui = game:GetService( "StarterGui" )
local CollectionService = game:GetService( "CollectionService" )
game:GetService( "TextService" )
local TweenService = game:GetService( "TweenService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local ClanShared = require( ReplicatedStorage:WaitForChild( "ClanShared" ) )
local Badges = require( script.Parent:WaitForChild( "Badges" ) )
local FromRGB = Color3.fromRGB( 255, 196, 64 )
local Table2 = { vignette = "rbxassetid://114856980838470" }
local Table3 = {
    whoosh = 9126232192,
    roll = 9126009571,
    victory = 9046538285,
    defeat = 9043786245,
    swoosh = 9120972321
}
local Table4 = {
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Health
}
local FromRGB2 = Color3.fromRGB( 255, 222, 186 )
local FromRGB3 = Color3.fromRGB( 255, 196, 132 )
local FromRGB4 = Color3.fromRGB( 158, 188, 255 )
local FromRGB5 = Color3.fromRGB( 176, 206, 255 )
local LocalPlayer = Players.LocalPlayer

local function PairParts( Object, Object2, List )
    local Table = { }

    for Key, Value in Object:GetChildren( ) do
        for Key2, Value2 in Object2:GetChildren( ) do
            if not Table[ Value2 ] and Value2.Name == Value.Name then
                if Value2.ClassName == Value.ClassName then
                    Table[ Value2 ] = true

                    if Value:IsA( "BasePart" ) then
                        table.insert( List, { part = Value2, world = Value.CFrame, src = Value } )
                    end

                    PairParts( Value, Value2, List )
                    break
                end
            end
        end
    end
end

local Table5 = {
    "LuaSourceContainer",
    "JointInstance",
    "Constraint",
    "BillboardGui",
    "SurfaceGui",
    "Highlight",
    "Sound",
    "ForceField",
    "ProximityPrompt"
}

local function Strip( Parent )
    for Key, Value in Parent:GetDescendants( ) do
        local Value1 = nil

        for Key2, Value2 in Table5, nil, nil do
            if Value:IsA( Value2 ) then
                Value:Destroy( )
                break
            end
        end
    end
end

local function HeldWeapon( Humanoid, HumanoidRootPart )
    local Tool = Humanoid:FindFirstChildOfClass( "Tool" )
    local FX = workspace:FindFirstChild( "FX" )

    if not Tool or not FX then
        return nil
    end

    local Value1, Number
    Value1 = nil
    Number = 8

    for Key, Value in FX:GetChildren( ) do
        if Value.Name == Tool.Name and Value:IsA( "Model" ) then
            local Magnitude = ( Value:GetPivot( ).Position - HumanoidRootPart.Position ).Magnitude

            if Magnitude < Number then
                Value1 = Value
                Number = Magnitude
            end
        end
    end

    return Value1
end

local Table6 = {
    RightHip = true,
    LeftHip = true,
    RightKnee = true,
    LeftKnee = true,
    RightAnkle = true,
    LeftAnkle = true,
    Root = true,
    [ "Right Hip" ] = true,
    [ "Left Hip" ] = true,
    RootJoint = true
}
local Table7 = {
    RightUpperLeg = "RightHip",
    LeftUpperLeg = "LeftHip",
    RightLowerLeg = "RightKnee",
    LeftLowerLeg = "LeftKnee",
    RightFoot = "RightAnkle",
    LeftFoot = "LeftAnkle",
    LowerTorso = "Root"
}
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true

local function StandingStill( Object, Part, Humanoid )
    if not Part or not Humanoid or Humanoid.Health <= 0 then
        return false
    end

    local AssemblyLinearVelocity = Part.AssemblyLinearVelocity

    if not Part.Anchored and Vector3.new( AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z ).Magnitude > 0.6 then
        return false
    end
    if math.abs( AssemblyLinearVelocity.Y ) > 2 and not Part.Anchored then
        return false
    end
    if Object:GetAttribute( "Crouch" ) ~= true then
        if Object ~= LocalPlayer.Character then
            if math.abs( Part.CFrame.UpVector.Y ) < 0.97 then
                return false
            end
            if Object == LocalPlayer.Character then
                local State = Humanoid:GetState( )

                if Humanoid.FloorMaterial == Enum.Material.Air then
                    return false
                end
                if State ~= Enum.HumanoidStateType.Running and State ~= Enum.HumanoidStateType.RunningNoPhysics then
                    return false
                end
            end

            local Flag
            RaycastParams2.FilterDescendantsInstances = { Object }

            if workspace:Raycast( Part.Position, Vector3.new( 0, -( Humanoid.HipHeight + Part.Size.Y / 2 + 0.8 ), 0 ), RaycastParams2 ) == nil then
                Flag = false
            else
                Flag = true
            end

            return Flag
        end
        if not ClientState.Crouching and not ClientState.Rolling then
            if math.abs( Part.CFrame.UpVector.Y ) < 0.97 then
                return false
            end
            if Object == LocalPlayer.Character then
                local State = Humanoid:GetState( )

                if Humanoid.FloorMaterial == Enum.Material.Air then
                    return false
                end
                if State ~= Enum.HumanoidStateType.Running and State ~= Enum.HumanoidStateType.RunningNoPhysics then
                    return false
                end
            end

            RaycastParams2.FilterDescendantsInstances = { Object }

            if workspace:Raycast( Part.Position, Vector3.new( 0, -( Humanoid.HipHeight + Part.Size.Y / 2 + 0.8 ), 0 ), RaycastParams2 ) == nil then
                Flag = false
            else
                Flag = true
            end

            return Flag
        end
    end

    return false
end

local Table8 = { }
local Table9 = { }
local Table10 = { }
task.spawn( function()
    local CollectionService = game:GetService( "CollectionService" )

    while true do
        local Value1
        task.wait( 0.3 )
        Value1 = nil

        for Value in Table8, nil, nil do
            if not Value.Parent then
                Table8[ Value ] = nil
            end
        end

        local Value2 = nil

        for Value3 in Table9, nil, nil do
            if not Value3.Parent then
                Table9[ Value3 ] = nil
            end
        end

        local Value4 = nil

        for Value5 in Table10, nil, nil do
            if not Value5.Parent then
                Table10[ Value5 ] = nil
            end
        end

        local Table = { }

        for Key, Value6 in Players:GetPlayers( ) do
            if Value6.Character then
                table.insert( Table, Value6.Character )
            end
        end
        for Key2, Value7 in CollectionService:GetTagged( "GunBot" ) do
            table.insert( Table, Value7 )
        end

        local Value8 = nil

        for Key3, Value9 in Table, nil, nil do
            if not Value9:GetAttribute( "RankedPose" ) then
                local HumanoidRootPart2
                local HumanoidRootPart = Value9:FindFirstChild( "HumanoidRootPart" )
                local Success, Result = pcall( StandingStill, Value9, HumanoidRootPart, ( Value9:FindFirstChildOfClass( "Humanoid" ) ) )
                HumanoidRootPart2 = if HumanoidRootPart then HumanoidRootPart.Position else HumanoidRootPart
                local Flag

                if HumanoidRootPart2 == nil then
                    Flag = true
                elseif Table10[ Value9 ] == nil then
                    Flag = true
                elseif ( HumanoidRootPart2 - Table10[ Value9 ] ).Magnitude > 0.2 then
                    Flag = true
                else
                    Flag = false
                end

                local Entry2
                Table10[ Value9 ] = HumanoidRootPart2

                if not Success or not Result or Flag then
                    Entry2 = 0
                else
                    local Entry = ( Table9[ Value9 ] or 0 ) + 1

                    if Entry then
                        Entry2 = Entry
                    else
                        Entry2 = 0
                    end
                end

                Table9[ Value9 ] = Entry2

                if Table9[ Value9 ] >= 2 then
                    local Value10
                    local Table2 = { }
                    Value10 = nil

                    for Key4, Value11 in Table7, nil, nil do
                        local FoundChild2
                        local FoundChild = Value9:FindFirstChild( Key4 )

                        if FoundChild then
                            FoundChild2 = FoundChild:FindFirstChild( Value11 )
                        else
                            FoundChild2 = FoundChild
                        end
                        if FoundChild2 then
                            if FoundChild2:IsA( "Motor6D" ) or FoundChild2:IsA( "AnimationConstraint" ) then
                                Table2[ Value11 ] = FoundChild2.Transform
                            end
                        end
                    end

                    local Value12, Flag2
                    Value12 = nil

                    for Key5, Value13 in Table2, nil, nil do
                        local _, ToAxisAngle2 = Value13:ToAxisAngle( )

                        if math.abs( ToAxisAngle2 ) > 0.5 then
                            Flag2 = false
                            break
                        end

                        Flag2 = true
                    end
                    if next( Table2 ) and Flag2 then
                        Table8[ Value9 ] = Table2
                    end
                end
            end
        end
    end
end )

local function BasePose( Object, Argument2, Argument3, List )
    local LookVector2
    local LookVector = Argument2.CFrame.LookVector * Vector3.new( 1, 0, 1 )
    LookVector2 = if LookVector.Magnitude < 0.1 then Vector3.new( 0, 0, -1 ) else LookVector
    local Table = {
        [ Argument2 ] = CFrame.lookAt( Argument2.Position, Argument2.Position + LookVector2.Unit )
    }
    local Table2 = { }
    local Table3 = { }

    local function Link( Key, Key2 )
        if Key and Key2 then
            local Entry2
            local Entry = Table3[ Key ]
            Entry2 = if Entry then Entry else { }
            local Entry4
            Table3[ Key ] = Entry2
            table.insert( Table3[ Key ], Key2 )
            local Entry3 = Table3[ Key2 ]
            Entry4 = if Entry3 then Entry3 else { }
            Table3[ Key2 ] = Entry4
            table.insert( Table3[ Key2 ], Key )
        end
    end

    local function AddJoint( JointName, Object, Argument3, Argument4, Argument5, Argument6 )
        if not JointName or not Object or not JointName:IsA( "BasePart" ) or not Object:IsA( "BasePart" ) then
            return
        end

        local Entry2
        local Entry = Table2[ JointName ]
        Entry2 = if Entry then Entry else { }
        Table2[ JointName ] = Entry2
        table.insert( Table2[ JointName ], {
            p1 = Object,
            c0 = Argument3,
            c1 = Argument4,
            t = Argument5,
            name = Argument6
        } )
    end

    for Key, Value in Object:GetDescendants( ) do
        if not Value:IsA( "Motor6D" ) or not Value.Part0 or not Value.Part1 or not Value.Enabled then
            if not Value:IsA( "AnimationConstraint" ) or not Value.Enabled or not Value.Attachment0 or not Value.Attachment1 then
                if Value:IsA( "JointInstance" ) or Value:IsA( "WeldConstraint" ) then
                    Link( Value.Part0, Value.Part1 )
                elseif Value:IsA( "RigidConstraint" ) and Value.Attachment0 and Value.Attachment1 then
                    Link( Value.Attachment0.Parent, Value.Attachment1.Parent )
                end
            else
                AddJoint( Value.Attachment0.Parent, Value.Attachment1.Parent, Value.Attachment0.CFrame, Value.Attachment1.CFrame, Value.Transform, Value.Name )
            end
        else
            AddJoint( Value.Part0, Value.Part1, Value.C0, Value.C1, Value.Transform, Value.Name )
        end
    end

    local Number
    local Table4 = { Argument2 }
    Number = 1

    while Table4[ Number ] do
        local Entry5
        local Entry = Table4[ Number ]
        Number = Number + 1
        local Entry2 = Table2[ Entry ]
        Entry5 = if Entry2 then Entry2 else { }
        local Value1 = nil

        for Key2, Value2 in Entry5, nil, nil do
            if Table[ Value2.p1 ] == nil and Value2.p1:IsDescendantOf( Object ) then
                local T = Value2.t

                if List and Table6[ Value2.name ] then
                    local Entry4

                    if type( List ) == "table" then
                        local Entry3 = List[ Value2.name ]

                        if Entry3 then
                            Entry4 = Entry3
                        else
                            Entry4 = CFrame.identity
                        end
                    else
                        Entry4 = CFrame.identity
                    end

                    T = Entry4
                end

                Table[ Value2.p1 ] = Table[ Entry ] * Value2.c0 * T * Value2.c1:Inverse( )
                table.insert( Table4, Value2.p1 )
            end
        end
    end

    local Value3
    local Table5 = { }
    Value3 = nil

    for Value4 in Table, nil, nil do
        local Number2
        table.insert( Table5, Value4 )
        Number2 = 1
    end

    Number2 = 1

    while Table5[ Number2 ] do
        local Entry8
        local Entry6 = Table5[ Number2 ]
        Number2 = Number2 + 1
        local Entry7 = Table3[ Entry6 ]
        Entry8 = if Entry7 then Entry7 else { }
        local Value5 = nil

        for Key3, Value6 in Entry8, nil, nil do
            if Value6:IsA( "BasePart" ) and Table[ Value6 ] == nil then
                Table[ Value6 ] = Table[ Entry6 ] * Entry6.CFrame:ToObjectSpace( Value6.CFrame )
                table.insert( Table5, Value6 )
            end
        end
    end

    local RightHand2
    local RightHand = Object:FindFirstChild( "RightHand" )
    RightHand2 = if RightHand then RightHand else Object:FindFirstChild( "Right Arm" )
    return function( Key )
        if Table[ Key ] then
            return Table[ Key ]
        end

        local Captured = Argument3 and Key:IsDescendantOf( Argument3 ) and RightHand2 or Argument2

        if not Captured or not Table[ Captured ] then
            return Key.CFrame
        end
        return Table[ Captured ] * Captured.CFrame:ToObjectSpace( Key.CFrame )
    end
end

local function Place( Argument1, Argument2, Parent )
    local Value1
    local CFrame2 = Argument2 * CFrame.new( 0, Argument1.foot, 0 )
    local Parts = Argument1.parts
    Value1 = nil

    for Key, Value in Parts, nil, nil do
        Value.part.Anchored = true
        Value.part.CanCollide = false
        Value.part.CanTouch = false
        Value.part.CanQuery = false
        local Part = Value.part
        Part.CFrame = CFrame2 * Argument1.origin:ToObjectSpace( Value.world )
    end

    Argument1.model.Parent = Parent
    return ( CFrame2 * CFrame.new( 0, Argument1.top + 0.45, 0 ) ).Position
end

local function Setting( Attribute, Argument2 )
    local Attribute2 = script:GetAttribute( Attribute )

    if Attribute2 == nil then
        return Argument2
    end
    return Attribute2
end

local function PartKeys( Argument1 )
    local Value1
    local Table = { }
    local Table2 = { }
    local Parts = Argument1.parts
    Value1 = nil

    for Key, Value in Parts, nil, nil do
        local Part
        local Table3 = { }
        Part = Value.part

        while Part do
            if Part == Argument1.model then
                break
            end

            table.insert( Table3, 1, Part.Name )
            Part = Part.Parent
        end

        local Concat = table.concat( Table3, "/" )
        Table2[ Concat ] = ( Table2[ Concat ] or 0 ) + 1
        Table[ Key ] = Concat .. "#" .. Table2[ Concat ]
    end

    return Table
end

local function AimMoves( E, Capture, CaptureAim )
    local Value3
    local PartKeys2 = PartKeys( Capture )
    local PartKeys3 = PartKeys( CaptureAim )
    local Table = { }
    local Parts = CaptureAim.parts
    Value3 = nil

    for Key, Value in Parts, nil, nil do
        Table[ PartKeys3[ Key ] ] = Value
    end

    local Value4, Position2
    local Spot = E.spot * CFrame.new( 0, CaptureAim.foot, 0 )
    local Table2 = { }
    local Table3 = { }
    local Parts2 = Capture.parts
    Value4 = nil
    Position2 = nil

    for Key2, Value5 in Parts2, nil, nil do
        local Entry = Table[ PartKeys2[ Key2 ] ]

        if Entry and Value5.part.Parent then
            local Table4 = {
                part = Value5.part,
                from = Value5.part.CFrame,
                to = Spot * CaptureAim.origin:ToObjectSpace( Entry.world ) + Vector3.new( 0, 1, 0 ) * ( E.dy or 0 )
            }
            table.insert( Table2, Table4 )

            if CaptureAim.weapon and Entry.part:IsDescendantOf( CaptureAim.weapon ) then
                table.insert( Table3, Table4.to.Position )
            end
            if Entry.part.Name == "UpperTorso" or Entry.part.Name == "Torso" then
                Position2 = Table4.to.Position
            end
        end
    end

    local Flag
    local Position = E.spot.Position
    local MvpAutoAim = script:GetAttribute( "MvpAutoAim" )
    Flag = if MvpAutoAim == nil then true else MvpAutoAim
    local Number3

    if Flag == false or not ( #Table3 >= 2 ) or not Position2 then
        Number3 = 0
    else
        local Value6, Position4, Value8, Number
        local Position3 = ( E.spot * CFrame.new( Vector3.new( 3, 3, -8.199999809265137 ) ) ).Position
        Value6 = nil
        Position4 = Vector3.new( 0, 0, 0 )
        Value8 = nil
        Number = -1

        for Key3, Value7 in Table3, nil, nil do
            Position4 = Position4 + Value7
            local Magnitude = ( Value7 - Position2 ).Magnitude

            if Number < Magnitude then
                Value8 = Value7
                Number = Magnitude
            end
        end

        local Position5 = Position4 / #Table3
        local Vector22 = Vector2.new( Value8.X - Position5.X, Value8.Z - Position5.Z )
        local Vector23 = Vector2.new( Value8.X - Position.X, Value8.Z - Position.Z )
        local Vector24 = Vector2.new( Position3.X - Position.X, Position3.Z - Position.Z )

        if Vector22.Magnitude > 0.05 then
            local Unit = Vector22.Unit
            local Dot = Vector23:Dot( Unit )
            local Dot2 = Dot * Dot - Vector23:Dot( Vector23 ) + Vector24:Dot( Vector24 )

            if Dot2 >= 0 then
                local Vector25 = Vector23 + Unit * ( -Dot + math.sqrt( Dot2 ) )
                local Amount = -Vector24.X
                local Atan2 = math.atan2( Amount, -Vector24.Y )
                local Amount2 = -Vector25.X
                local Atan22 = ( Atan2 - math.atan2( Amount2, -Vector25.Y ) + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793

                if math.abs( Atan22 ) <= 1.3962634015954636 then
                    Number3 = Atan22
                else
                    Number3 = 0
                end
            else
                Number3 = 0
            end
        else
            Number3 = 0
        end
    end

    local Number2
    local MvpYawOffset = script:GetAttribute( "MvpYawOffset" )
    Number2 = if MvpYawOffset == nil then 0 else MvpYawOffset
    local Number4 = Number3 + math.rad( tonumber( Number2 ) or 0 )

    if Number4 ~= 0 then
        local Value9
        local CFrame2 = CFrame.new( Position ) * CFrame.Angles( 0, Number4, 0 ) * CFrame.new( -Position )
        Value9 = nil

        for Key4, Value10 in Table2, nil, nil do
            Value10.to = CFrame2 * Value10.to
        end
    end

    return Table2, { pivot = Position, auto = Number3, total = Number4 }
end

local Table = {
    Capture = function( Humanoid )
        local HumanoidRootPart

        if Humanoid then
            HumanoidRootPart = Humanoid:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Humanoid
        end

        local Humanoid2

        if Humanoid then
            Humanoid2 = Humanoid:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid2 = Humanoid
        end
        if not HumanoidRootPart or not Humanoid2 then
            return nil
        end

        local Table2
        local HeldWeapon2 = HeldWeapon( Humanoid, HumanoidRootPart )
        Table2 = HeldWeapon2 and { HeldWeapon2 } or { }
        local Archivable = Humanoid.Archivable
        Humanoid.Archivable = true
        local Parent = Humanoid:Clone( )
        Humanoid.Archivable = Archivable

        if not Parent then
            return nil
        end

        local Value2, Clone
        local Table = { }
        PairParts( Humanoid, Parent, Table )
        local Count = #Table
        Value2 = nil
        Clone = nil

        for Key, Value in Table2, nil, nil do
            local Archivable2 = Value.Archivable
            Value.Archivable = true
            local Clone2 = Value:Clone( )
            Value.Archivable = Archivable2

            if Clone2 then
                Clone2.Parent = Parent
                PairParts( Value, Clone2, Table )

                if Value == HeldWeapon2 then
                    Clone = Clone2
                end
            end
        end
        for Key2, Value3 in Parent:GetDescendants( ) do
            if Value3:HasTag( "SkinFX" ) then
                Value3:RemoveTag( "SkinFX" )
            end
        end
        if Humanoid:GetAttribute( "RankedPose" ) then
            local Entry4
            local Success, Result = pcall( StandingStill, Humanoid, HumanoidRootPart, Humanoid2 )

            if Humanoid == LocalPlayer.Character then
                if not Success or not Result then
                    Entry4 = Table8[ Humanoid ] or "rest"
                else
                    Entry4 = nil
                end
            else
                local Entry3
                local Entry = Table8[ Humanoid ]

                if Entry then
                    Entry3 = Entry
                elseif LocalPlayer.Character then
                    local Entry2 = Table8[ LocalPlayer.Character ]

                    if Entry2 then
                        Entry3 = Entry2
                    else
                        Entry3 = "rest"
                    end
                else
                    Entry3 = "rest"
                end

                Entry4 = Entry3
            end

            local Success2, Result2 = pcall( BasePose, Humanoid, HumanoidRootPart, HeldWeapon2, Entry4 )

            if Success2 and Result2 then
                local Value4 = nil

                for Key3, Value5 in Table, nil, nil do
                    local Success3, World = pcall( Result2, Value5.src )

                    if Success3 and World then
                        Value5.world = World
                    end
                end
            end
        end

        local LookVector2
        local LookVector = HumanoidRootPart.CFrame.LookVector * Vector3.new( 1, 0, 1 )
        LookVector2 = if LookVector.Magnitude < 0.1 then Vector3.new( 0, 0, -1 ) else LookVector
        local World2
        local LookAt = CFrame.lookAt( HumanoidRootPart.Position, HumanoidRootPart.Position + LookVector2.Unit )
        local I = 1
        World2 = nil

        for I = 1, Count do
            if Table[ I ].src.Name == "Head" and Table[ I ].src.Parent == Humanoid then
                World2 = Table[ I ].world
                break
            end

            World2 = nil
        end

        local Y3
        local Head = Humanoid:FindFirstChild( "Head" )

        if not World2 or not Head then
            Y3 = 2.5
        else
            local Y = LookAt:PointToObjectSpace( World2.Position ).Y + Head.Size.Y / 2

            if Y then
                Y3 = Y
            else
                Y3 = 2.5
            end
        end

        local Number
        local I2 = 1
        Number = math.huge

        for I2 = 1, Count do
            local Entry5 = Table[ I2 ]

            if Entry5.part.Transparency < 0.95 then
                local ToObjectSpace = LookAt:ToObjectSpace( Entry5.world )
                local Size = Entry5.part.Size / 2
                local Y2 = ToObjectSpace.Y - ( math.abs( ToObjectSpace.RightVector.Y ) * Size.X + math.abs( ToObjectSpace.UpVector.Y ) * Size.Y + math.abs( ToObjectSpace.LookVector.Y ) * Size.Z )

                if Y2 < Number then
                    Number = Y2
                end
            end
        end

        local Amount = Number < 0 and Number > -12 and -Number or Humanoid2.HipHeight + HumanoidRootPart.Size.Y / 2
        Strip( Parent )

        if Parent:GetAttribute( "CostumeFX" ) then
            CollectionService:AddTag( Parent, "SceneCostume" )
        end

        local Humanoid3 = Parent:FindFirstChildOfClass( "Humanoid" )

        if Humanoid3 then
            Humanoid3.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            Humanoid3.BreakJointsOnDeath = false
            Humanoid3.EvaluateStateMachine = false
            local Animator = Humanoid3:FindFirstChildOfClass( "Animator" )

            if Animator then
                Animator:Destroy( )
            end
        end

        return {
            model = Parent,
            parts = Table,
            origin = LookAt,
            foot = Amount,
            top = Y3,
            weapon = Clone
        }
    end,
    MvpRaise = function()
        local Flag
        local MvpRaise = script:GetAttribute( "MvpRaise" )
        Flag = if MvpRaise == nil then false else MvpRaise
        local Flag2 = Flag == true and true or false
        return Flag2
    end,
    AimPitch = function( Argument1 )
        local Parts = Argument1 and Argument1.parts or { }
        local Value1, Y
        Value1 = nil

        for Key, Value in Parts, nil, nil do
            if Value.part.Name ~= "UpperTorso" then
                if Value.part.Name ~= "Torso" then
                    continue
                end
            end

            Y = Argument1.origin:PointToObjectSpace( Value.world.Position ).Y + Argument1.foot
            break
        end

        local Number
        local MvpPitchOffset = script:GetAttribute( "MvpPitchOffset" )
        Number = if MvpPitchOffset == nil then 0 else MvpPitchOffset
        local Number2 = tonumber( Number ) or 0

        if Y then
            local Y2 = 3 - ( Y + 0.9 )
            return math.deg( ( math.atan2( Y2, Vector3.new( 3, 0, -8.199999809265137 ).Magnitude ) ) ) + Number2
        end
        return Number2
    end,
    _mvp = nil
}

local function RaiseAim( Argument1 )
    local Capture = Argument1.w.capture
    local CaptureAim = Argument1.w.captureAim

    if not Capture or not CaptureAim or not Table.MvpRaise( ) then
        return
    end

    Argument1.w.captureAim = nil
    local Value1, Value2 = AimMoves( Argument1, Capture, CaptureAim )
    CaptureAim.model:Destroy( )

    if #Value1 == 0 then
        return
    end
    Table._mvp = {
        e = Argument1,
        moves = Value1,
        pivot = Value2.pivot,
        auto = Value2.auto,
        total = Value2.total
    }
    task.spawn( function()
        local Clock = os.clock( )

        while true do
            local Value1Inner
            local Min = math.min( 1, ( os.clock( ) - Clock ) / 0.4 )
            local Min2 = Min * Min * ( 3 - Min * 2 )
            Value1Inner = nil

            for Key, Value in Value1, nil, nil do
                if Value.part.Parent then
                    local Part = Value.part
                    local From = Value.from
                    Part.CFrame = From:Lerp( Value.to, Min2 )
                end
            end
            if Min >= 1 then
                break
            end

            RunService.Heartbeat:Wait( )
        end
    end )
    return
end

function Table.DebugApplyYaw()
    local _mvp = Table._mvp

    if not _mvp then
        return false
    end

    local Flag
    local MvpAutoAim = script:GetAttribute( "MvpAutoAim" )
    Flag = if MvpAutoAim == nil then true else MvpAutoAim
    local Auto = Flag ~= false and _mvp.auto or 0
    local Number
    local MvpYawOffset = script:GetAttribute( "MvpYawOffset" )
    Number = if MvpYawOffset == nil then 0 else MvpYawOffset
    local Total = Auto + math.rad( tonumber( Number ) or 0 )
    local Auto2 = Total - _mvp.total

    if math.abs( Auto2 ) > 1e-06 then
        local Value1
        local CFrame2 = CFrame.new( _mvp.pivot ) * CFrame.Angles( 0, Auto2, 0 ) * CFrame.new( -_mvp.pivot )
        local Moves = _mvp.moves
        Value1 = nil

        for Key, Value in Moves, nil, nil do
            Value.to = CFrame2 * Value.to

            if Value.part.Parent then
                local Part = Value.part
                Part.CFrame = CFrame2 * Value.part.CFrame
            end
        end

        _mvp.total = Total
    end

    return true
end
function Table.DebugSwapAim( Argument1 )
    local _mvp = Table._mvp

    if not _mvp or not Argument1 or not _mvp.e.w.capture then
        if Argument1 then
            Argument1.model:Destroy( )
        end

        return false
    end
    local Value2
    local E = _mvp.e
    local Moves, Value1 = AimMoves( E, _mvp.e.w.capture, Argument1 )
    Argument1.model:Destroy( )
    Value2 = nil

    for Key, Value in Moves, nil, nil do
        if Value.part.Parent then
            local Part = Value.part
            Part.CFrame = Value.to
        end
    end

    local Auto = Value1.auto
    local Total = Value1.total
    _mvp.moves = Moves
    _mvp.auto = Auto
    _mvp.total = Total
    return true
end

local function Tween( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Create = TweenService:Create( Argument1, TweenInfo.new( Argument2, Argument4 or Enum.EasingStyle.Quint, Argument5 or Enum.EasingDirection.Out ), Argument3 )
    Create:Play( )
    return Create
end

local Table11 = { }

local function Sfx( Text, Amount, Amount2, TimePosition )
    local Sound = Instance.new( "Sound" )
    Sound.SoundId = "rbxassetid://" .. Text
    Sound.Volume = Amount or 0.6
    Sound.PlaybackSpeed = Amount2 or 1
    Sound:SetAttribute( "CaseSound", true )
    Sound.Parent = SoundService

    if TimePosition and TimePosition > 0 then
        Sound.TimePosition = TimePosition
    end

    Sound:Play( )
    Table11[ Sound ] = true
    task.delay( 10, function()
        Table11[ Sound ] = nil
        Sound:Destroy( )
    end )
end

local function Make( Argument1, List, Parent )
    local Value1
    local Instance2 = Instance.new( Argument1 )
    Value1 = nil

    for Key, Value in List, nil, nil do
        Instance2[ Key ] = Value
    end

    Instance2.Parent = Parent
    return Instance2
end

local function House( Parent, Bold, Amount )
    local Value1
    Parent.FontFace = Font.new( "rbxasset://fonts/families/Merriweather.json", Bold )
    Parent.AutoLocalize = false
    local Table = {
        Name = "Contour",
        Thickness = Amount or 0.035,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = Color3.new( 0, 0, 0 ),
        LineJoinMode = Enum.LineJoinMode.Round,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    }
    local UIStroke = Instance.new( "UIStroke" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        UIStroke[ Key ] = Value
    end

    UIStroke.Parent = Parent

    local function Sync()
        UIStroke.Transparency = Parent.TextTransparency
    end

    Parent:GetPropertyChangedSignal( "TextTransparency" ):Connect( Sync )
    UIStroke.Transparency = Parent.TextTransparency
    return Parent
end

local function SetGrad( Object, Argument2 )
    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "UIGradient" ) then
            if Value.Name == "Victoire" or Value.Name == "Defaite" or Value.Name == "Nul" then
                local Enabled = Value.Name == Argument2 and true or false
                Value.Enabled = Enabled
            end
        end
    end
end

local function ResultBanner( Parent, Argument2, Text, BannerName, BannerName2 )
    local RankedMatch2
    local RankedMatch = StarterGui:FindFirstChild( "RankedMatch" )

    if RankedMatch then
        RankedMatch2 = RankedMatch
    else
        RankedMatch2 = LocalPlayer.PlayerGui:FindFirstChild( "RankedMatch" )
    end

    local Resultats

    if RankedMatch2 then
        Resultats = RankedMatch2:FindFirstChild( "Resultats" )
    else
        Resultats = RankedMatch2
    end

    local Ecran

    if Resultats then
        Ecran = Resultats:FindFirstChild( "Ecran" )
    else
        Ecran = Resultats
    end

    local Bandeau

    if Ecran then
        Bandeau = Ecran:FindFirstChild( "Bandeau" )
    else
        Bandeau = Ecran
    end
    if not Bandeau then
        return nil
    end

    local Value1
    local Scale = Bandeau.Position.Y.Scale
    local Scale2 = Bandeau.Size.Y.Scale
    local Table = {
        Name = "Bandeau",
        AnchorPoint = Vector2.new( 0.5, 0 ),
        Position = UDim2.fromScale( 0.5, 0.838 ),
        Size = UDim2.fromScale( 1, 0.156 ),
        BackgroundTransparency = 1,
        ZIndex = 5
    }
    local Parent2 = Instance.new( "Frame" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Parent2[ Key ] = Value
    end

    local Value2
    Parent2.Parent = Parent
    local Table2 = { "Bandeau", "LigneHaut", "LigneBas", "Titre", "Score", "Raison" }
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        local FoundChild4 = Ecran:FindFirstChild( Value3 )

        if FoundChild4 then
            local Clone2 = FoundChild4:Clone( )
            local Scale3 = Clone2.Position.X.Scale
            local Offset = Clone2.Position.X.Offset
            Clone2.Position = UDim2.new( Scale3, Offset, ( Clone2.Position.Y.Scale - Scale ) / Scale2, 0 )
            local Scale4 = Clone2.Size.X.Scale
            local Offset2 = Clone2.Size.X.Offset
            Clone2.Size = UDim2.new( Scale4, Offset2, Clone2.Size.Y.Scale / Scale2, 0 )
            Clone2.Parent = Parent2
        end
    end

    local Titre = Parent2:FindFirstChild( "Titre" )
    local Score = Parent2:FindFirstChild( "Score" )
    local Raison = Parent2:FindFirstChild( "Raison" )

    if not Titre or not Score or not Raison or not Parent2:FindFirstChild( "Bandeau" ) then
        Parent2:Destroy( )
        return nil
    end

    local Reflet = Titre:FindFirstChild( "Reflet" )
    Titre.Text = Text

    if Reflet then
        Reflet.Text = Text
        Reflet.Visible = false
    end

    local Visible
    Score.Text = BannerName or ""
    Visible = BannerName ~= nil and true or false
    local Value4
    Score.Visible = Visible
    Raison.Text = BannerName2 or ""
    local Table3 = { "Bandeau", "LigneHaut", "LigneBas", "Titre" }
    Value4 = nil

    for Key3, Value5 in Table3, nil, nil do
        local FoundChild3 = Parent2:FindFirstChild( Value5 )

        if FoundChild3 then
            SetGrad( FoundChild3, Argument2 )
        end
    end

    local Value6
    local Table4 = { }
    local Table5 = { "Bandeau", "LigneHaut", "LigneBas" }
    Value6 = nil

    for Key4, Value7 in Table5, nil, nil do
        local FoundChild2 = Parent2:FindFirstChild( Value7 )

        if FoundChild2 then
            Table4[ FoundChild2 ] = FoundChild2.Size
            FoundChild2.Size = UDim2.fromScale( 0, FoundChild2.Size.Y.Scale )
        end
    end

    local Value8
    local Table6 = { }
    local Table7 = { Titre, Score, Raison }
    Value8 = nil

    for Key5, Value9 in Table7, nil, nil do
        local St
        local Stroke = Value9:FindFirstChild( "Contour" )
        local Table12 = { tt = Value9.TextTransparency }
        St = Stroke and Stroke.Transparency or 0
        Table12.st = St
        Table12.stroke = Stroke
        Table12.pos = Value9.Position
        Table6[ Value9 ] = Table12
        Value9.TextTransparency = 1

        if Stroke then
            Stroke.Transparency = 1
        end
    end

    local Reflet2 = Parent2.Bandeau:FindFirstChild( "Reflet" )

    if Reflet2 then
        Reflet2.BackgroundTransparency = 1
    end

    local Value10
    local Bandeau2 = Parent2:FindFirstChild( "Bandeau" )
    local Table8 = {
        Name = "Eclair",
        AnchorPoint = Bandeau2.AnchorPoint,
        Position = Bandeau2.Position,
        Size = Bandeau2.Size,
        BackgroundColor3 = Color3.new( 1, 1, 1 ),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2
    }
    local Parent3 = Instance.new( "Frame" )
    Value10 = nil

    for Key6, Value11 in Table8, nil, nil do
        Parent3[ Key6 ] = Value11
    end

    local Value12
    Parent3.Parent = Parent2
    local Table9 = {
        Transparency = NumberSequence.new( {
            NumberSequenceKeypoint.new( 0, 1 ),
            NumberSequenceKeypoint.new( 0.3, 0.05 ),
            NumberSequenceKeypoint.new( 0.7, 0.05 ),
            NumberSequenceKeypoint.new( 1, 1 )
        } )
    }
    local UIGradient = Instance.new( "UIGradient" )
    Value12 = nil

    for Key7, Value13 in Table9, nil, nil do
        UIGradient[ Key7 ] = Value13
    end

    local Value14
    UIGradient.Parent = Parent3
    local Table10 = { }
    local Table11 = { "LigneHaut", "LigneBas" }
    Value14 = nil

    for Key8, Value15 in Table11, nil, nil do
        local FoundChild = Parent2:FindFirstChild( Value15 )

        if FoundChild then
            local Clone = FoundChild:Clone( )
            Clone.Name = Value15 .. "Chaud"
            Clone.BackgroundColor3 = Color3.new( 1, 1, 1 )
            Clone.BackgroundTransparency = 1

            for Key9, Value16 in Clone:GetChildren( ) do
                if Value16:IsA( "UIGradient" ) then
                    Value16.Color = ColorSequence.new( Color3.new( 1, 1, 1 ) )
                end
            end

            Clone.Parent = Parent2
            table.insert( Table10, Clone )
        end
    end

    return function()
        local Value1 = nil

        for Key, Value in Table4, nil, nil do
            Key.Size = Value
        end

        Parent3.BackgroundTransparency = 0
        local Table = { BackgroundTransparency = 1 }
        local Value2
        TweenService:Create( Parent3, TweenInfo.new( 0.32, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
        Value2 = nil

        for Key2, Value3 in Table10, nil, nil do
            Value3.BackgroundTransparency = 0.2
            local Table4Inner = { BackgroundTransparency = 1 }
            TweenService:Create( Value3, TweenInfo.new( 0.6, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table4Inner ):Play( )
        end

        local Value4
        local Position = Parent2.Position
        local X = Parent.AbsoluteSize.X / math.max( Parent.AbsoluteSize.Y, 1 )
        local Table2 = {
            { 0.0025, -0.0012 },
            { -0.002, 0.001 },
            { 0.0012, 0 },
            { -0.0006, 0 },
            { 0, 0 }
        }
        Value4 = nil

        for Key3, Value5 in Table2, nil, nil do
            task.delay( 0.02 + ( Key3 - 1 ) * 0.06, function()
                local Table = {
                    Position = Position + UDim2.fromScale( Value5[ 1 ], Value5[ 2 ] * X )
                }
                TweenService:Create( Parent2, TweenInfo.new( 0.06, Enum.EasingStyle.Linear or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
            end )
        end

        local Pos = Table6[ Titre ].pos
        local X2 = 0.022 * X / 0.156
        Titre.Position = Pos - UDim2.fromScale( 0, X2 )
        task.delay( 0.04, function()
            local Table = { Position = Pos + UDim2.fromScale( 0, X2 * 0.11 ) }
            TweenService:Create( Titre, TweenInfo.new( 0.23, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
            task.delay( 0.23, function()
                local Table = { Position = Pos }
                TweenService:Create( Titre, TweenInfo.new( 0.15, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut or Enum.EasingDirection.Out ), Table ):Play( )
            end )
            local Table2 = { TextTransparency = Table6[ Titre ].tt }
            TweenService:Create( Titre, TweenInfo.new( 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )

            if Table6[ Titre ].stroke then
                local Stroke = Table6[ Titre ].stroke
                local Table3 = { Transparency = Table6[ Titre ].st }
                TweenService:Create( Stroke, TweenInfo.new( 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table3 ):Play( )
            end
        end )

        if Reflet2 then
            Reflet2.Position = UDim2.fromScale( 0.22, Reflet2.Position.Y.Scale )
            task.delay( 0.55, function()
                local Table = { Position = UDim2.fromScale( 0.78, Reflet2.Position.Y.Scale ) }
                TweenService:Create( Reflet2, TweenInfo.new( 0.9, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut or Enum.EasingDirection.Out ), Table ):Play( )
                local Table2 = { BackgroundTransparency = 0 }
                TweenService:Create( Reflet2, TweenInfo.new( 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )
                task.delay( 0.62, function()
                    local Table = { BackgroundTransparency = 1 }
                    TweenService:Create( Reflet2, TweenInfo.new( 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
                end )
            end )
        end
        if Reflet and Argument2 == "Victoire" then
            task.delay( 0.7, function()
                Reflet.Visible = true
                local Brillance = Reflet:FindFirstChild( "Brillance" )

                if Brillance then
                    CollectionService:AddTag( Brillance, "VipName" )
                end
            end )
        end

        local Value6
        local Table3 = { Score, Raison }
        Value6 = nil

        for Key4, Value7 in Table3, nil, nil do
            local Entry = Table6[ Value7 ]
            Value7.Position = Entry.pos + UDim2.fromScale( 0, 0.07 )
            task.delay( 0.18 + Key4 * 0.07, function()
                local Table = { TextTransparency = Entry.tt }
                TweenService:Create( Value7, TweenInfo.new( 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )

                if Entry.stroke then
                    local Stroke = Entry.stroke
                    local Table2 = { Transparency = Entry.st }
                    TweenService:Create( Stroke, TweenInfo.new( 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )
                end

                local Table3 = { Position = Entry.pos }
                TweenService:Create( Value7, TweenInfo.new( 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table3 ):Play( )
            end )
        end
    end
end

local function BuildUi( Argument1 )
    local Value1
    local Table = {
        Name = "RankedVictoryScene",
        IgnoreGuiInset = true,
        DisplayOrder = 2000,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local Parent = Instance.new( "ScreenGui" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Parent[ Key ] = Value
    end

    local Value2
    Parent.Parent = nil
    local Table2 = {
        Size = UDim2.fromScale( 1, 1 ),
        BackgroundTransparency = 1,
        Image = "rbxassetid://114856980838470",
        ImageTransparency = 0.6,
        ImageColor3 = Color3.new( 0, 0, 0 ),
        ScaleType = Enum.ScaleType.Stretch,
        ZIndex = 2
    }
    local ImageLabel = Instance.new( "ImageLabel" )
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        ImageLabel[ Key2 ] = Value3
    end

    local Value4
    ImageLabel.Parent = Parent
    local Table3 = {
        Size = UDim2.fromScale( 1, 1 ),
        BackgroundColor3 = Color3.new( 0, 0, 0 ),
        BorderSizePixel = 0,
        ZIndex = 20
    }
    local Frame = Instance.new( "Frame" )
    Value4 = nil

    for Key3, Value5 in Table3, nil, nil do
        Frame[ Key3 ] = Value5
    end

    local Value6
    Frame.Parent = Parent
    local Table4 = {
        AnchorPoint = Vector2.new( 0.5, 0.5 ),
        Position = UDim2.fromScale( 0.5, 0.5 ),
        Size = UDim2.fromScale( 0.3, 0.032 ),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = "LOADING",
        TextScaled = true,
        TextColor3 = Color3.fromRGB( 200, 200, 200 ),
        ZIndex = 21
    }
    local TextLabel = Instance.new( "TextLabel" )
    Value6 = nil

    for Key4, Value7 in Table4, nil, nil do
        TextLabel[ Key4 ] = Value7
    end

    local Text
    TextLabel.Parent = Parent

    local function Bar( Argument1 )
        local Value1
        local Table = {
            AnchorPoint = Vector2.new( 0, Argument1 ),
            Position = UDim2.fromScale( 0, Argument1 ),
            Size = UDim2.fromScale( 1, 0 ),
            BackgroundColor3 = Color3.new( 0, 0, 0 ),
            BorderSizePixel = 0,
            ZIndex = 3
        }
        local Frame = Instance.new( "Frame" )
        Value1 = nil

        for Key, Value in Table, nil, nil do
            Frame[ Key ] = Value
        end

        Frame.Parent = Parent
        return Frame
    end

    local Bar2 = Bar( 0 )
    local Bar3 = Bar( 1 )
    Text = Argument1.outcome ~= "Defaite" and "Victoire" or "Defaite"
    local Title2
    local Title = Argument1.title

    if Title then
        Title2 = Title
    elseif Text == "Defaite" then
        Title2 = "DEFEAT"
    else
        Title2 = "VICTORY"
    end

    local Reason2
    local Score = Argument1.score
    local Reason = Argument1.reason
    Reason2 = if Reason then Reason else Argument1.subtitle
    local CasesFX2
    local ResultBanner2 = ResultBanner( Parent, Text, Title2, Score, Reason2 )
    House( TextLabel, Enum.FontWeight.Bold, 0.03 )
    local CasesFX = LocalPlayer.PlayerGui:FindFirstChild( "CasesFX" )

    if CasesFX then
        CasesFX2 = CasesFX
    else
        CasesFX2 = StarterGui:FindFirstChild( "CasesFX" )
    end

    local Skip

    if CasesFX2 then
        local Weapon = CasesFX2:FindFirstChild( "Weapon" )

        if Weapon then
            Skip = CasesFX2.Weapon:FindFirstChild( "Skip" )
        else
            Skip = Weapon
        end
    else
        Skip = CasesFX2
    end

    local Clone2

    if Skip then
        local Clone = Skip:Clone( )
        Clone.Name = "Passer"
        local Price = Clone:FindFirstChild( "Price" )

        if Price then
            Price:Destroy( )
        end

        Clone.AnchorPoint = Vector2.new( 0.5, 0.5 )
        Clone.Position = UDim2.fromScale( 0.945, 0.0425 )
        Clone.Visible = false
        Clone.ZIndex = 6

        for Key5, Value9 in Clone:GetDescendants( ) do
            if Value9:IsA( "GuiObject" ) then
                Value9.ZIndex = 7
            end
            if Value9:IsA( "TextLabel" ) then
                Value9.AutoLocalize = false
            end
        end

        Clone.Parent = Parent
        Clone2 = Clone
    else
        Clone2 = nil
    end

    return {
        gui = Parent,
        vignette = ImageLabel,
        black = Frame,
        loading = TextLabel,
        top = Bar2,
        bottom = Bar3,
        banner = ResultBanner2,
        outcome = Text,
        skip = Clone2
    }
end

local Value1 = nil

local function NameTagTemplate()
    if Value1 and Value1.Parent then
        return Value1
    end

    local WorldUI2
    local WorldUI = StarterGui:FindFirstChild( "WorldUI" )

    if WorldUI then
        WorldUI2 = WorldUI
    else
        WorldUI2 = Players.LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "WorldUI", 10 )
    end

    local WorldUI3 = if WorldUI2 then WorldUI2:FindFirstChild( "NameTag" ) else WorldUI2
    Value1 = WorldUI3
    return Value1
end

local function PaintTag( Tag, Argument2, TextTransparency )
    local Captured

    if not Value1 or not Value1.Parent then
        local WorldUI2
        local WorldUI = StarterGui:FindFirstChild( "WorldUI" )

        if WorldUI then
            WorldUI2 = WorldUI
        else
            WorldUI2 = Players.LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "WorldUI", 10 )
        end

        local WorldUI3 = if WorldUI2 then WorldUI2:FindFirstChild( "NameTag" ) else WorldUI2
        Value1 = WorldUI3
        Captured = Value1
    else
        Captured = Value1
    end
    if not Captured then
        return
    end
    for Key, Value in Captured:GetChildren( ) do
        Value:Clone( ).Parent = Tag
    end

    local Nom = Tag:FindFirstChild( "Nom" )
    local Plate = Tag:FindFirstChild( "Plate" )

    if Nom then
        local Enabled
        Nom.RichText = false
        Nom.Text = Argument2.name or ""
        local Vip = Nom:FindFirstChild( "Vip" )
        local VipStroke = Nom:FindFirstChild( "VipStroke" )
        local Reflet = Nom:FindFirstChild( "Reflet" )
        local Dev = Nom:FindFirstChild( "Dev" )

        if Dev == nil then
            Enabled = false
        elseif Argument2.dev == true then
            Enabled = true
        else
            Enabled = false
        end

        local Enabled2

        if Enabled then
            Enabled2 = Enabled
        elseif Vip == nil then
            Enabled2 = false
        elseif Argument2.vip == true then
            Enabled2 = true
        else
            Enabled2 = false
        end

        local Dev2 = Enabled and Dev or Vip
        local TextTransparency2

        if Enabled2 then
            local Number = tonumber( Dev2:GetAttribute( "TextTransparency" ) )

            if Number then
                TextTransparency2 = Number
            else
                TextTransparency2 = 0
            end
        else
            TextTransparency2 = TextTransparency
        end

        Nom.TextTransparency = TextTransparency2

        if Vip then
            local Enabled3 = if Enabled2 then not Enabled else Enabled2
            Vip.Enabled = Enabled3
        end
        if Dev then
            Dev.Enabled = Enabled
        end
        if VipStroke then
            VipStroke.Enabled = Enabled2
        end
        if Reflet then
            local RefletColor
            Reflet.Text = Nom.Text
            Reflet.Visible = Enabled2

            if Enabled2 then
                RefletColor = Dev2:GetAttribute( "RefletColor" )
            else
                RefletColor = Enabled2
            end

            local TextColor3

            if typeof( RefletColor ) ~= "Color3" or not RefletColor then
                TextColor3 = Color3.new( 1, 1, 1 )
            else
                TextColor3 = RefletColor
            end

            Reflet.TextColor3 = TextColor3
            local Brillance = Reflet:FindFirstChild( "Brillance" )

            if Brillance and Enabled2 then
                CollectionService:AddTag( Brillance, "VipName" )
            end
        end
    end
    if Plate then
        local Enabled5
        local Enabled4 = ClanShared.Enabled( )
        Enabled5 = if Enabled4 then Argument2.tag else Enabled4
        local Visible

        if type( Enabled5 ) == "string" then
            if Enabled5 == "" then
                Visible = false
            else
                Visible = true
            end
        else
            Visible = false
        end

        local Dev3
        Plate.Visible = Visible
        local Tag2 = Plate:FindFirstChild( "Tag" )

        if Tag2 then
            Dev3 = Tag2:FindFirstChild( "Dev" )
        else
            Dev3 = Tag2
        end

        local Reflet2

        if Tag2 then
            Reflet2 = Tag2:FindFirstChild( "Reflet" )
        else
            Reflet2 = Tag2
        end

        local Enabled6

        if Visible then
            if Dev3 == nil then
                Enabled6 = false
            elseif Argument2.cid == "4bf51d50fbf6" then
                Enabled6 = true
            else
                Enabled6 = false
            end
        else
            Enabled6 = Visible
        end
        if Dev3 then
            Dev3.Enabled = Enabled6
        end
        if Reflet2 then
            Reflet2.Visible = Enabled6
            local Brillance2 = Reflet2:FindFirstChild( "Brillance" )

            if Brillance2 and Enabled6 then
                CollectionService:AddTag( Brillance2, "VipName" )
            end
        end

        Plate:SetAttribute( "DevStyle", Enabled6 or nil )

        if Visible then
            local UIGradient
            local ColorDef = ClanShared.ColorDef( Argument2.cc )

            if Tag2 then
                UIGradient = Tag2:FindFirstChild( "UIGradient" )
            else
                UIGradient = Tag2
            end
            if Tag2 then
                Tag2.Text = "[" .. Enabled5 .. "]"
            end
            if Reflet2 and Tag2 then
                Reflet2.Text = Tag2.Text
            end
            if UIGradient then
                local Rotation
                UIGradient.Enabled = not Enabled6
                UIGradient.Color = ClanShared.GradientOf( Argument2.cc )
                Rotation = not ColorDef.keys and 90 or 15
                UIGradient.Rotation = Rotation
            end

            local UIStroke = Plate:FindFirstChildOfClass( "UIStroke" )

            if UIStroke then
                local Color

                if ColorDef.keys then
                    local Item = ColorDef.keys[ 1 ]

                    if Item then
                        Color = Item
                    else
                        Color = ColorDef.c
                    end
                else
                    Color = ColorDef.c
                end

                UIStroke.Color = Color
            end

            local Flag = if ColorDef.keys == nil then false else not Enabled6
            Plate:SetAttribute( "Animated", Flag )
            Plate:SetAttribute( "ColorId", Argument2.cc )
        end

        CollectionService:AddTag( Tag, "NameTagPlate" )
    end
end

local function NameTag( Parent, Argument2 )
    local Value1
    local Table = {
        AnchorPoint = Vector2.new( 0.5, 1 ),
        Size = UDim2.fromScale( 0.1, 0.05 ),
        BackgroundTransparency = 1,
        GroupTransparency = 1,
        ZIndex = 4
    }
    local Parent2 = Instance.new( "CanvasGroup" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Parent2[ Key ] = Value
    end

    local Value2
    Parent2.Parent = Parent
    local Table2 = {
        Size = UDim2.fromScale( 1, 1 ),
        Position = UDim2.fromScale( 0, 0.18 ),
        BackgroundTransparency = 1
    }
    local Parent3 = Instance.new( "Frame" )
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        Parent3[ Key2 ] = Value3
    end

    Parent3.Parent = Parent2
    local Image = Badges.Image( Argument2.rk or "Unranked", Argument2.dv )

    if Image then
        local Value4
        local Table3 = {
            Name = "Rang",
            AnchorPoint = Vector2.new( 0.5, 0 ),
            Position = UDim2.fromScale( 0.5, 0 ),
            Size = UDim2.fromScale( 0.2613636363636363, 0.6686046511627907 ),
            BackgroundTransparency = 1,
            Image = Image,
            ScaleType = Enum.ScaleType.Fit
        }
        local ImageLabel = Instance.new( "ImageLabel" )
        Value4 = nil

        for Key3, Value5 in Table3, nil, nil do
            ImageLabel[ Key3 ] = Value5
        end

        ImageLabel.Parent = Parent3

        if Badges.Place then
            Badges.Place( Parent3.Rang )
        end
    end

    local Value6
    local Table4 = {
        Name = "Tag",
        AnchorPoint = Vector2.new( 0, 1 ),
        Position = UDim2.fromScale( 0, 1 ),
        Size = UDim2.fromScale( 1, 0.2558139534883721 ),
        BackgroundTransparency = 1
    }
    local Frame = Instance.new( "Frame" )
    Value6 = nil

    for Key4, Value7 in Table4, nil, nil do
        Frame[ Key4 ] = Value7
    end

    Frame.Parent = Parent3
    PaintTag( Frame, Argument2, 0.05 )
    return Parent2, function()
        local Table = { GroupTransparency = 0 }
        TweenService:Create( Parent2, TweenInfo.new( 0.3, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
        local Table2 = { Position = UDim2.fromScale( 0, 0 ) }
        TweenService:Create( Parent3, TweenInfo.new( 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )
    end, function()
        local Table = { GroupTransparency = 1 }
        TweenService:Create( Parent2, TweenInfo.new( 0.25, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
    end
end

local function Lamp( Parent, Argument2, Argument3, List )
    local Value1
    local Table = {
        Anchored = true,
        CanCollide = false,
        CanTouch = false,
        CanQuery = false,
        CastShadow = false,
        Transparency = 1,
        Size = Vector3.new( 1, 1, 1 ),
        CFrame = CFrame.lookAt( Argument2, Argument3 )
    }
    local Parent2 = Instance.new( "Part" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Parent2[ Key ] = Value
    end

    local Value2
    Parent2.Parent = Parent
    List.Face = Enum.NormalId.Front
    List.Brightness = 0
    local SpotLight = Instance.new( "SpotLight" )
    Value2 = nil

    for Key2, Value3 in List, nil, nil do
        SpotLight[ Key2 ] = Value3
    end

    SpotLight.Parent = Parent2
    return SpotLight
end

local function TeamRig( Parent, Argument2, Amount, Argument4, Amount2 )
    local Total = Argument2 + Vector3.new( 0, 3, 0 )
    local Total2 = Argument2 + Vector3.new( 0, 5, 0 )
    return {
        key = Lamp( Parent, Argument2 + Amount * 17 - Argument4 * ( Amount2 + 2 ) + Vector3.new( 0, 8.5, 0 ), Argument2 + Vector3.new( 0, 4.199999809265137, 0 ), { Angle = 64, Range = 52, Color = FromRGB2, Shadows = true } ),
        fill = Lamp( Parent, Argument2 + Amount * 10 + Argument4 * ( Amount2 + 6 ) + Vector3.new( 0, 2.5, 0 ), Total, { Angle = 75, Range = 32, Color = FromRGB4, Shadows = false } ),
        rimL = Lamp( Parent, Argument2 - Amount * 6 - Argument4 * ( Amount2 + 3 ) + Vector3.new( 0, 9, 0 ), Total2 - Argument4 * ( Amount2 * 0.4 ), { Angle = 45, Range = 30, Color = FromRGB3, Shadows = false } ),
        rimR = Lamp( Parent, Argument2 - Amount * 6 + Argument4 * ( Amount2 + 3 ) + Vector3.new( 0, 9, 0 ), Total2 + Argument4 * ( Amount2 * 0.4 ), { Angle = 45, Range = 30, Color = FromRGB3, Shadows = false } ),
        wash = Lamp( Parent, Argument2 - Amount * 2 + Vector3.new( 0, 11, 0 ), Argument2 - Amount * 13 + Vector3.new( 0, 3, 0 ), {
            Angle = 95,
            Range = 26,
            Color = Color3.fromRGB( 255, 168, 92 ),
            Shadows = false
        } )
    }
end

local function MvpRig( Parent, Argument2 )
    local Value1
    local Position = ( Argument2 * CFrame.new( 0, 4.5, 0 ) ).Position
    local Position2 = ( Argument2 * CFrame.new( 0, 3.4, 0 ) ).Position
    local Table = {
        key = Lamp( Parent, ( Argument2 * CFrame.new( -3.2, 6.4, -5.2 ) ).Position, Position, { Angle = 28, Range = 22, Color = FromRGB2, Shadows = true } ),
        hair = Lamp( Parent, ( Argument2 * CFrame.new( -0.6, 8.8, 3.6 ) ).Position, Position, { Angle = 38, Range = 16, Color = FromRGB3, Shadows = false } ),
        edge = Lamp( Parent, ( Argument2 * CFrame.new( 3.6, 4.6, 2.4 ) ).Position, Position2, { Angle = 44, Range = 14, Color = FromRGB5, Shadows = false } )
    }
    local Position3 = ( Argument2 * CFrame.new( 5, 5.2, -4 ) ).Position
    Table.sweep = Lamp( Parent, Position3, Position2, {
        Angle = 30,
        Range = 16,
        Color = Color3.fromRGB( 255, 236, 214 ),
        Shadows = false
    } )
    function Table.sweepGo()
        local Parent = Table.sweep.Parent
        Parent.CFrame = CFrame.lookAt( ( Argument2 * CFrame.new( 5, 5.2, -4 ) ).Position, Position2 )
        local TableInner = {
            CFrame = CFrame.lookAt( ( Argument2 * CFrame.new( -5, 5.2, -4 ) ).Position, Position2 )
        }
        TweenService:Create( Parent, TweenInfo.new( 1.15, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut or Enum.EasingDirection.Out ), TableInner ):Play( )
        local Sweep = Table.sweep
        local Table2 = { Brightness = 3.2 }
        TweenService:Create( Sweep, TweenInfo.new( 0.35, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )
        task.delay( 0.55, function()
            local Sweep = Table.sweep
            local TableInner = { Brightness = 0 }
            TweenService:Create( Sweep, TweenInfo.new( 0.6, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), TableInner ):Play( )
        end )
    end
    local Table2 = {
        Anchored = true,
        CanCollide = false,
        CanTouch = false,
        CanQuery = false,
        CastShadow = false,
        Transparency = 1,
        Size = Vector3.new( 1, 1, 1 ),
        CFrame = Argument2 * CFrame.new( 0.9, 4.5, -2.1 )
    }
    local Parent2 = Instance.new( "Part" )
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        Parent2[ Key ] = Value
    end

    local Value2
    Parent2.Parent = Parent
    local Table3 = { Range = 3.4, Brightness = 0, Color = FromRGB2, Shadows = false }
    local Face = Instance.new( "PointLight" )
    Value2 = nil

    for Key2, Value3 in Table3, nil, nil do
        Face[ Key2 ] = Value3
    end

    Face.Parent = Parent2
    Table.face = Face
    return Table
end

local Table12 = {
    "DeathScreenCC",
    "DeathScreenBlur",
    "LowHealthGrade",
    "KillFlash",
    "ThermalVision"
}

local function HoldLighting()
    local Value1
    local CaseRolling = ClientState.CaseRolling
    ClientState.CaseRolling = true
    local Table = { }
    Value1 = nil

    for Key, Value in Table12, nil, nil do
        local FoundChild = Lighting:FindFirstChild( Value )

        if FoundChild and FoundChild:IsA( "PostEffect" ) then
            Table[ FoundChild ] = FoundChild.Enabled
            FoundChild.Enabled = false
        end
    end

    return function()
        local Value1
        ClientState.CaseRolling = CaseRolling
        Value1 = nil

        for Key, Value in Table, nil, nil do
            if Key.Parent then
                Key.Enabled = Value
            end
        end
    end, function()
        local Value1 = nil

        for Value in Table, nil, nil do
            if Value.Enabled then
                Value.Enabled = false
            end
        end
    end
end

local Number = 0
function Table.Abort()
    Number = Number + 1
end

local function Handheld( Amount )
    local Noise = math.noise( Amount * 0.33, 1.7 ) * 0.06
    return CFrame.new( Noise, math.noise( Amount * 0.29, 7.3 ) * 0.045, 0 ) * CFrame.Angles( math.noise( Amount * 0.27, 3.1 ) * 0.005, math.noise( Amount * 0.23, 9.4 ) * 0.006, math.noise( Amount * 0.31, 5.9 ) * 0.0035 )
end

local function Ease( Amount )
    local Result2

    if Amount < 0.5 then
        local Result = 4 * Amount * Amount * Amount

        if Result then
            Result2 = Result
        else
            Result2 = 1 - ( -2 * Amount + 2 ) ^ 3 / 2
        end
    else
        Result2 = 1 - ( -2 * Amount + 2 ) ^ 3 / 2
    end

    return Result2
end

local function Ease4( Amount )
    local Result2

    if Amount < 0.5 then
        local Result = 8 * Amount ^ 4

        if Result then
            Result2 = Result
        else
            Result2 = 1 - ( -2 * Amount + 2 ) ^ 4 / 2
        end
    else
        Result2 = 1 - ( -2 * Amount + 2 ) ^ 4 / 2
    end

    return Result2
end

local Table13 = {
    Bronze = "BRONZE",
    Silver = "SILVER",
    Gold = "GOLD",
    Diamond = "DIAMOND",
    Ruby = "RUBY",
    Champion = "CHAMPION",
    Top100 = "TOP 100",
    Top1 = "TOP 1",
    Unranked = "UNRANKED"
}
local Table14 = { "I", "II", "III" }

local function RankLabel( LabelName, LabelName2 )
    local Upper
    local Text = LabelName or "Unranked"
    local Entry = Table13[ Text ]

    if Entry then
        Upper = Entry
    else
        Upper = string.upper( ( tostring( Text ) ) )
    end
    if Text ~= "Top100" and Text ~= "Top1" and Text ~= "Unranked" and Table14[ LabelName2 or 0 ] then
        Upper = Upper .. " " .. Table14[ LabelName2 ]
    end

    return Upper
end

local function LowerThird( Parent, Argument2 )
    local Value1
    local Table = {
        AnchorPoint = Vector2.new( 0, 1 ),
        Position = UDim2.fromScale( 0.035, 0.8 ),
        Size = UDim2.fromScale( 0.6, 0.12 ),
        BackgroundTransparency = 1,
        GroupTransparency = 1,
        Visible = false,
        ZIndex = 6
    }
    local Parent2 = Instance.new( "CanvasGroup" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Parent2[ Key ] = Value
    end

    local Value2
    Parent2.Parent = Parent
    local Table2 = {
        AspectRatio = 4.181818181818182,
        DominantAxis = Enum.DominantAxis.Height
    }
    local UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        UIAspectRatioConstraint[ Key2 ] = Value3
    end

    local ImageLabel
    UIAspectRatioConstraint.Parent = Parent2

    local function At( Amount, Amount2, Amount3, Amount4 )
        return UDim2.fromScale( Amount / 460, Amount2 / 110 ), UDim2.fromScale( Amount3 / 460, Amount4 / 110 )
    end

    local Image = Badges.Image( Argument2.rk or "Unranked", Argument2.dv )

    if Image then
        local Value4
        local Table3 = {
            AnchorPoint = Vector2.new( 0.5, 0.5 ),
            Position = UDim2.fromScale( 0.11956521739130435, 0.5 ),
            Size = UDim2.fromScale( 0.22608695652173913, 0.9454545454545454 ),
            BackgroundTransparency = 1,
            Image = Image,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = 6
        }
        local Parent3 = Instance.new( "ImageLabel" )
        Value4 = nil

        for Key3, Value5 in Table3, nil, nil do
            Parent3[ Key3 ] = Value5
        end

        Parent3.Parent = Parent2

        if Badges.Place then
            Badges.Place( Parent3 )
        end

        local Value6
        local Table4 = { Scale = 0.6 }
        local UIScale = Instance.new( "UIScale" )
        Value6 = nil

        for Key4, Value7 in Table4, nil, nil do
            UIScale[ Key4 ] = Value7
        end

        UIScale.Parent = Parent3
        ImageLabel = Parent3
    else
        ImageLabel = nil
    end

    local Number = not Image and 0 or 122
    local Value8
    local FromScale = UDim2.fromScale( Number / 460, 0.12727272727272726 )
    local Table5 = {
        Position = FromScale,
        Size = UDim2.fromScale( 0.717391304347826, 0.41818181818181815 ),
        BackgroundTransparency = 1,
        ZIndex = 6
    }
    local Frame = Instance.new( "Frame" )
    Value8 = nil

    for Key5, Value9 in Table5, nil, nil do
        Frame[ Key5 ] = Value9
    end

    local Text
    Frame.Parent = Parent2
    PaintTag( Frame, Argument2, 0 )
    local Table6 = {
        Position = UDim2.fromScale( Number / 460, 0.6181818181818182 ),
        Size = UDim2.fromScale( 0.717391304347826, 0.21818181818181817 ),
        BackgroundTransparency = 1,
        TextScaled = true,
        ZIndex = 6
    }
    local Rk = Argument2.rk
    local Dv = Argument2.dv
    local Rk2 = Rk or "Unranked"
    local Entry = Table13[ Rk2 ]

    if Entry then
        Text = Entry
    else
        Text = string.upper( ( tostring( Rk2 ) ) )
    end
    if Rk2 ~= "Top100" and Rk2 ~= "Top1" and Rk2 ~= "Unranked" and Table14[ Dv or 0 ] then
        Text = Text .. " " .. Table14[ Dv ]
    end

    local Value10
    Table6.Text = Text
    Table6.TextColor3 = Color3.fromRGB( 205, 205, 210 )
    Table6.TextXAlignment = Enum.TextXAlignment.Left
    local TextLabel = Instance.new( "TextLabel" )
    Value10 = nil

    for Key6, Value11 in Table6, nil, nil do
        TextLabel[ Key6 ] = Value11
    end

    local Value12
    TextLabel.Parent = Parent2
    House( TextLabel, Enum.FontWeight.Bold, 0.03 )
    local FromScale2 = UDim2.fromScale( ( Number + 2 ) / 460, 0.5727272727272728 )
    UDim2.fromScale( 0, 0.01818181818181818 )
    local Table7 = {
        Position = FromScale2,
        Size = UDim2.fromScale( 0, 0.01818181818181818 ),
        BackgroundColor3 = FromRGB,
        BorderSizePixel = 0,
        ZIndex = 6
    }
    local Frame2 = Instance.new( "Frame" )
    Value12 = nil

    for Key7, Value13 in Table7, nil, nil do
        Frame2[ Key7 ] = Value13
    end

    Frame2.Parent = Parent2

    local function Show()
        Parent2.Visible = true
        Parent2.Position = UDim2.fromScale( 0.02, 0.8 )
        local Table = { Position = UDim2.fromScale( 0.035, 0.8 ) }
        TweenService:Create( Parent2, TweenInfo.new( 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
        local Table2 = { GroupTransparency = 0 }
        TweenService:Create( Parent2, TweenInfo.new( 0.22, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )

        if ImageLabel then
            local UIScale = ImageLabel:FindFirstChildOfClass( "UIScale" )
            UIScale.Scale = 0.6
            local Table3 = { Scale = 1 }
            TweenService:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table3 ):Play( )
        end

        Frame2.Size = UDim2.fromScale( 0, 0.01818181818181818 )
        local Table4 = { Size = UDim2.fromScale( 0.2391304347826087, 0.01818181818181818 ) }
        TweenService:Create( Frame2, TweenInfo.new( 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table4 ):Play( )
        task.spawn( function()
            RunService.Heartbeat:Wait( )
            local Nom = Frame:FindFirstChild( "Nom" )
            local Plate = Frame:FindFirstChild( "Plate" )
            local X = Frame.AbsoluteSize.X
            local X2 = Parent2.AbsoluteSize.X

            if Nom and X > 0 and X2 > 0 then
                local Tag
                local Max = math.max( Nom.TextBounds.Y, 1 )

                if Plate then
                    local Visible = Plate.Visible

                    if Visible then
                        Tag = Plate:FindFirstChild( "Tag" )
                    else
                        Tag = Visible
                    end
                else
                    Tag = Plate
                end

                local Min2

                if Tag then
                    local X3 = Tag.TextBounds.X
                    local Min = math.min( X3, Max * 3.6 ) + Max * 0.22

                    if Min then
                        Min2 = Min
                    else
                        Min2 = 0
                    end
                else
                    Min2 = 0
                end

                local Max2 = math.max( 0, ( X - ( Min2 + Nom.TextBounds.X ) ) / 2 )
                Frame.Position = UDim2.fromScale( FromScale.X.Scale - Max2 / X2, FromScale.Y.Scale )
            end
        end )
    end

    local function Hide()
        local Table = { GroupTransparency = 1 }
        local Create = TweenService:Create( Parent2, TweenInfo.new( 0.2, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table )
        Create:Play( )
        Create.Completed:Once( function()
            if Parent2.GroupTransparency > 0.99 then
                Parent2.Visible = false
            end
        end )
    end

    return Show, Hide
end

local Table15 = {
    Bronze = Color3.fromRGB( 200, 120, 63 ),
    Silver = Color3.fromRGB( 159, 176, 198 ),
    Gold = Color3.fromRGB( 224, 173, 60 ),
    Diamond = Color3.fromRGB( 63, 180, 255 ),
    Ruby = Color3.fromRGB( 255, 45, 76 ),
    Champion = Color3.fromRGB( 178, 60, 255 ),
    Top100 = Color3.fromRGB( 242, 204, 42 ),
    Top1 = Color3.fromRGB( 223, 231, 242 ),
    Unranked = Color3.fromRGB( 159, 176, 198 )
}
local FromRGB6 = Color3.fromRGB( 5, 6, 10 )
local FromRGB7 = Color3.fromRGB( 4, 5, 9 )
local FromRGB8 = Color3.fromRGB( 255, 240, 194 )
local FromRGB9 = Color3.fromRGB( 230, 180, 76 )
local FromRGB10 = Color3.fromRGB( 168, 114, 26 )

local function SeqC( List )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        table.insert( Table, ColorSequenceKeypoint.new( Value[ 1 ], Value[ 2 ] ) )
    end

    return ColorSequence.new( Table )
end

local function SeqN( List )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        table.insert( Table, NumberSequenceKeypoint.new( Value[ 1 ], Value[ 2 ] ) )
    end

    return NumberSequence.new( Table )
end

local function TailTriangle( Parent, Argument2, Argument3, Argument4, Amount, Argument6, Argument7, Argument8 )
    local Value1
    local Table = {
        Position = UDim2.fromScale( Argument2, Argument3 ),
        Size = UDim2.fromScale( Argument4, Amount ),
        BackgroundTransparency = 1,
        ZIndex = Argument8
    }
    local Parent2 = Instance.new( "CanvasGroup" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Parent2[ Key ] = Value
    end

    local Number
    Parent2.Parent = Parent
    local Result = Amount / 0.537109375 / Argument4
    Number = not Argument6 and 1 or -1
    local Value2
    local Number2 = Number * math.atan( Result )
    local Table2 = {
        AnchorPoint = Vector2.new( 0.5, 0.5 ),
        Size = UDim2.fromScale( 4, 4 / Result ),
        Rotation = math.deg( Number2 ),
        Position = UDim2.fromScale( math.sin( Number2 ) * 2 + 0.5, 0.5 - math.cos( Number2 ) * 2 / Result ),
        BackgroundColor3 = Argument7,
        BorderSizePixel = 0,
        ZIndex = Argument8
    }
    local Frame = Instance.new( "Frame" )
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        Frame[ Key2 ] = Value3
    end

    Frame.Parent = Parent2
    return Parent2
end

local function MvpBanner( Parent, Argument2 )
    local Entry3
    local Entry = Table15[ Argument2.rk or "Unranked" ]
    Entry3 = if Entry then Entry else Table15.Unranked
    local Value1
    local Table = {
        Name = "BanniereMVP",
        AnchorPoint = Vector2.new( 0, 0.5 ),
        Position = UDim2.fromScale( 0.045, 0.085 ),
        Size = UDim2.fromScale( 0.3, 1.36 ),
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 2
    }
    local Parent2 = Instance.new( "Frame" )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        Parent2[ Key ] = Value
    end

    local Value2
    Parent2.Parent = Parent
    local Table2 = { AspectRatio = 0.2685546875, DominantAxis = Enum.DominantAxis.Height }
    local UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        UIAspectRatioConstraint[ Key2 ] = Value3
    end

    local Value4
    UIAspectRatioConstraint.Parent = Parent2
    local Table3 = {
        Name = "Rideau",
        Position = UDim2.fromScale( 0, 0.5 ),
        Size = UDim2.fromScale( 1, 0 ),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 2
    }
    local Parent3 = Instance.new( "Frame" )
    Value4 = nil

    for Key3, Value5 in Table3, nil, nil do
        Parent3[ Key3 ] = Value5
    end

    local Value6
    Parent3.Parent = Parent2
    local Table4 = {
        Size = UDim2.fromScale( 1, 1 ),
        BackgroundTransparency = 1,
        ZIndex = 2
    }
    local Parent4 = Instance.new( "Frame" )
    Value6 = nil

    for Key4, Value7 in Table4, nil, nil do
        Parent4[ Key4 ] = Value7
    end

    local Value8
    Parent4.Parent = Parent3
    local Table5 = {
        Size = UDim2.fromScale( 1, 0.89 ),
        BackgroundColor3 = Color3.new( 1, 1, 1 ),
        BorderSizePixel = 0,
        ZIndex = 2
    }
    local Parent5 = Instance.new( "Frame" )
    Value8 = nil

    for Key5, Value9 in Table5, nil, nil do
        Parent5[ Key5 ] = Value9
    end

    local Value10
    Parent5.Parent = Parent4
    local Table6 = {
        Rotation = 90,
        Color = SeqC( {
            { 0, FromRGB8 },
            { 0.45, FromRGB9 },
            { 1, FromRGB9:Lerp( FromRGB10, 0.82 ) }
        } )
    }
    local UIGradient = Instance.new( "UIGradient" )
    Value10 = nil

    for Key6, Value11 in Table6, nil, nil do
        UIGradient[ Key6 ] = Value11
    end

    local Value12
    UIGradient.Parent = Parent5
    local Table7 = {
        Size = UDim2.fromScale( 1, 1 ),
        BackgroundColor3 = Color3.new( 1, 1, 1 ),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2
    }
    local Frame = Instance.new( "Frame" )
    Value12 = nil

    for Key7, Value13 in Table7, nil, nil do
        Frame[ Key7 ] = Value13
    end

    local Value14
    Frame.Parent = Parent5
    TailTriangle( Parent4, 0, 0.89, 0.5, 0.11, true, FromRGB10, 2 )
    TailTriangle( Parent4, 0.5, 0.89, 0.5, 0.11, false, FromRGB10, 2 )
    local Lerp = FromRGB6:Lerp( Entry3, 0.2 )
    local Lerp2 = FromRGB6:Lerp( Entry3, 0.6 )
    local Table8 = {
        Position = UDim2.fromScale( 0.019, 0 ),
        Size = UDim2.fromScale( 0.962, 0.879 ),
        BackgroundColor3 = Color3.new( 1, 1, 1 ),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 3
    }
    local Parent6 = Instance.new( "Frame" )
    Value14 = nil

    for Key8, Value15 in Table8, nil, nil do
        Parent6[ Key8 ] = Value15
    end

    local Value16
    Parent6.Parent = Parent4
    local Table9 = { Color = SeqC( { { 0, Lerp }, { 0.5, Lerp2 }, { 1, Lerp } } ) }
    local UIGradient2 = Instance.new( "UIGradient" )
    Value16 = nil

    for Key9, Value17 in Table9, nil, nil do
        UIGradient2[ Key9 ] = Value17
    end

    local Value18
    UIGradient2.Parent = Parent6
    local Table10 = {
        Size = UDim2.fromScale( 1, 1 ),
        BackgroundColor3 = FromRGB7,
        BorderSizePixel = 0,
        ZIndex = 3
    }
    local Parent7 = Instance.new( "Frame" )
    Value18 = nil

    for Key10, Value19 in Table10, nil, nil do
        Parent7[ Key10 ] = Value19
    end

    local Value20
    Parent7.Parent = Parent6
    local Table11 = {
        Rotation = 90,
        Transparency = SeqN( { { 0, 1 }, { 0.41, 1 }, { 0.635, 0.2 }, { 1, 0.13 } } )
    }
    local UIGradient3 = Instance.new( "UIGradient" )
    Value20 = nil

    for Key11, Value21 in Table11, nil, nil do
        UIGradient3[ Key11 ] = Value21
    end

    local Value22
    UIGradient3.Parent = Parent7
    local Lerp3 = Lerp:Lerp( Lerp2, 0.5 ):Lerp( FromRGB7, 0.87 )
    TailTriangle( Parent4, 0.019, 0.879, 0.481, 0.105, true, Lerp3, 3 )
    TailTriangle( Parent4, 0.5, 0.879, 0.481, 0.105, false, Lerp3, 3 )
    local Table12 = {
        AnchorPoint = Vector2.new( 0.5, 0 ),
        Position = UDim2.fromScale( 0.5, 0.04 ),
        Size = UDim2.fromScale( 0.42, 0.091 ),
        BackgroundColor3 = Color3.new( 1, 1, 1 ),
        BorderSizePixel = 0,
        ZIndex = 5
    }
    local Parent8 = Instance.new( "Frame" )
    Value22 = nil

    for Key12, Value23 in Table12, nil, nil do
        Parent8[ Key12 ] = Value23
    end

    local Value24
    Parent8.Parent = Parent4
    local Table13Inner = {
        Rotation = 90,
        Color = SeqC( { { 0, FromRGB8 }, { 0.55, FromRGB9 }, { 1, FromRGB10 } } )
    }
    local UIGradient4 = Instance.new( "UIGradient" )
    Value24 = nil

    for Key13, Value25 in Table13Inner, nil, nil do
        UIGradient4[ Key13 ] = Value25
    end

    local Value26
    UIGradient4.Parent = Parent8
    local Table14Inner = { CornerRadius = UDim.new( 0.22, 0 ) }
    local UICorner = Instance.new( "UICorner" )
    Value26 = nil

    for Key14, Value27 in Table14Inner, nil, nil do
        UICorner[ Key14 ] = Value27
    end

    local Value28
    UICorner.Parent = Parent8
    local Table15Inner = {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.new( 0, 0, 0 ),
        Thickness = 0.035,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    }
    local UIStroke = Instance.new( "UIStroke" )
    Value28 = nil

    for Key15, Value29 in Table15Inner, nil, nil do
        UIStroke[ Key15 ] = Value29
    end

    local Value30
    UIStroke.Parent = Parent8
    local Table16 = {
        AnchorPoint = Vector2.new( 0.5, 0.5 ),
        Position = UDim2.fromScale( 0.5, 0.53 ),
        Size = UDim2.fromScale( 0.78, 0.7 ),
        BackgroundTransparency = 1,
        Text = "MVP",
        TextScaled = true,
        TextColor3 = Color3.fromRGB( 27, 18, 4 ),
        ZIndex = 6
    }
    local TextLabel = Instance.new( "TextLabel" )
    Value30 = nil

    for Key16, Value31 in Table16, nil, nil do
        TextLabel[ Key16 ] = Value31
    end

    local ImageLabel
    TextLabel.Parent = Parent8
    TextLabel.FontFace = Font.new( "rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Heavy )
    TextLabel.AutoLocalize = false
    local Image = Badges.Image( Argument2.rk or "Unranked", Argument2.dv )

    if Image then
        local Visible, Visible2

        if Badges.Visible then
            Visible, Visible2 = Badges.Visible( Image )
        else
            Visible = -0.5
            Visible2 = 0.5
        end

        local Value32
        local Table17 = {
            AnchorPoint = Vector2.new( 0.5, 0.5 ),
            Position = UDim2.fromScale( 0.5, 0.325 - ( Visible + Visible2 ) / 2 * 0.335693359375 ),
            Size = UDim2.fromScale( 0.625, 0.335693359375 ),
            BackgroundTransparency = 1,
            ZIndex = 5
        }
        local Parent9 = Instance.new( "Frame" )
        Value32 = nil

        for Key17, Value33 in Table17, nil, nil do
            Parent9[ Key17 ] = Value33
        end

        local Value34
        Parent9.Parent = Parent4
        local Table18 = {
            AnchorPoint = Vector2.new( 0.5, 0.5 ),
            Position = UDim2.fromScale( 0.5, 0.5 ),
            Size = UDim2.fromScale( 1, 1 ),
            BackgroundTransparency = 1,
            Image = Image,
            ImageTransparency = 1,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = 5
        }
        local Parent10 = Instance.new( "ImageLabel" )
        Value34 = nil

        for Key18, Value35 in Table18, nil, nil do
            Parent10[ Key18 ] = Value35
        end

        Parent10.Parent = Parent9

        if Badges.Place then
            Badges.Place( Parent10 )
        end

        local Value36
        local Table19 = { Scale = 1.3 }
        local UIScale = Instance.new( "UIScale" )
        Value36 = nil

        for Key19, Value37 in Table19, nil, nil do
            UIScale[ Key19 ] = Value37
        end

        UIScale.Parent = Parent10
        ImageLabel = Parent10
    else
        ImageLabel = nil
    end

    local Value38
    local Table20 = {
        Position = UDim2.fromScale( 0.04, 0.505 ),
        Size = UDim2.fromScale( 0.92, 0.066 ),
        BackgroundTransparency = 1,
        GroupTransparency = 1,
        ZIndex = 5
    }
    local CanvasGroup = Instance.new( "CanvasGroup" )
    Value38 = nil

    for Key20, Value39 in Table20, nil, nil do
        CanvasGroup[ Key20 ] = Value39
    end

    local VipStroke
    CanvasGroup.Parent = Parent4
    PaintTag( CanvasGroup, Argument2, 0 )
    local Parent11 = CanvasGroup:FindFirstChild( "Nom" )

    if Parent11 then
        VipStroke = Parent11:FindFirstChild( "VipStroke" )
    else
        VipStroke = Parent11
    end
    if Parent11 then
        if not VipStroke or not VipStroke.Enabled then
            local Value40
            local Table21 = {
                Name = "Contour",
                Thickness = 0.05,
                StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
                Color = Color3.new( 0, 0, 0 ),
                LineJoinMode = Enum.LineJoinMode.Round,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
            }
            local UIStroke2 = Instance.new( "UIStroke" )
            Value40 = nil

            for Key21, Value41 in Table21, nil, nil do
                UIStroke2[ Key21 ] = Value41
            end

            UIStroke2.Parent = Parent11
        end
    end

    local Upper
    local Table22 = { }

    local function Label( Argument1, Argument2, Argument3, Argument4, Argument5, Amount, Amount2 )
        local Value1
        local Table = {
            Position = UDim2.fromScale( Amount or 0.05, Argument1 ),
            Size = UDim2.fromScale( Amount2 or 0.9, Argument2 ),
            BackgroundTransparency = 1,
            Text = Argument4,
            TextScaled = true,
            TextColor3 = Argument5,
            TextTransparency = 1,
            ZIndex = 5
        }
        local TextLabel = Instance.new( "TextLabel" )
        Value1 = nil

        for Key, Value in Table, nil, nil do
            TextLabel[ Key ] = Value
        end

        TextLabel.Parent = Parent4
        local House2 = House( TextLabel, Argument3, 0.055 )
        table.insert( Table22, House2 )
        return House2
    end

    local Rk = Argument2.rk
    local Dv = Argument2.dv
    local Rk2 = Rk or "Unranked"
    local Entry2 = Table13[ Rk2 ]

    if Entry2 then
        Upper = Entry2
    else
        Upper = string.upper( ( tostring( Rk2 ) ) )
    end
    if Rk2 ~= "Top100" and Rk2 ~= "Top1" and Rk2 ~= "Unranked" and Table14[ Dv or 0 ] then
        Upper = Upper .. " " .. Table14[ Dv ]
    end

    local Value42
    Label( 0.585, 0.04, Enum.FontWeight.Bold, Upper, Color3.fromRGB( 243, 239, 231 ) )
    local Table23 = {
        AnchorPoint = Vector2.new( 0.5, 0.5 ),
        Position = UDim2.fromScale( 0.5, 0.662 ),
        Size = UDim2.fromScale( 0, 0.0045 ),
        BackgroundColor3 = FromRGB9,
        BorderSizePixel = 0,
        ZIndex = 5
    }
    local Parent12 = Instance.new( "Frame" )
    Value42 = nil

    for Key22, Value43 in Table23, nil, nil do
        Parent12[ Key22 ] = Value43
    end

    local Value44
    Parent12.Parent = Parent4
    local Table24 = { Transparency = SeqN( { { 0, 1 }, { 0.5, 0 }, { 1, 1 } } ) }
    local UIGradient5 = Instance.new( "UIGradient" )
    Value44 = nil

    for Key23, Value45 in Table24, nil, nil do
        UIGradient5[ Key23 ] = Value45
    end

    local Value46
    UIGradient5.Parent = Parent12
    local Text = tostring( Argument2.kills or 0 )
    Label( 0.69, 0.088, Enum.FontWeight.Heavy, Text, Color3.new( 1, 1, 1 ), 0.11, 0.39 )
    local Text2 = tostring( Argument2.deaths or 0 )
    Label( 0.69, 0.088, Enum.FontWeight.Heavy, Text2, Color3.new( 1, 1, 1 ), 0.5, 0.39 )
    Label( 0.783, 0.036, Enum.FontWeight.Bold, "ELIMS", Color3.fromRGB( 232, 228, 220 ), 0.11, 0.39 )
    Label( 0.783, 0.036, Enum.FontWeight.Bold, "DEATHS", Color3.fromRGB( 232, 228, 220 ), 0.5, 0.39 )
    local Table25 = {
        AnchorPoint = Vector2.new( 0.5, 0 ),
        Position = UDim2.fromScale( 0.5, 0.697 ),
        Size = UDim2.fromScale( 0.004, 0.122 ),
        BackgroundColor3 = Color3.new( 1, 1, 1 ),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5
    }
    local Frame2 = Instance.new( "Frame" )
    Value46 = nil

    for Key24, Value47 in Table25, nil, nil do
        Frame2[ Key24 ] = Value47
    end

    Frame2.Parent = Parent4

    local function Callback( Amount )
        local Number = Amount or 0.32
        Parent2.Visible = true
        local NumberValue = Instance.new( "NumberValue" )

        local function Apply()
            local Clamp = math.clamp( NumberValue.Value, 0.002, 1 )
            Parent3.Size = UDim2.fromScale( 1, Clamp * 0.5 )
            Parent4.Size = UDim2.fromScale( 1, 1 / Clamp )
        end

        NumberValue.Value = 0.002
        local Clamp = math.clamp( NumberValue.Value, 0.002, 1 )
        Parent3.Size = UDim2.fromScale( 1, Clamp * 0.5 )
        Parent4.Size = UDim2.fromScale( 1, 1 / Clamp )
        NumberValue.Changed:Connect( Apply )
        local Table = { Value = 1 }
        local Value1
        local Create = TweenService:Create( NumberValue, TweenInfo.new( Number, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.In or Enum.EasingDirection.Out ), Table )
        Create:Play( )
        Create.Completed:Once( function()
            NumberValue.Value = 1
            local Clamp = math.clamp( NumberValue.Value, 0.002, 1 )
            Parent3.Size = UDim2.fromScale( 1, Clamp * 0.5 )
            Parent4.Size = UDim2.fromScale( 1, 1 / Clamp )
            NumberValue:Destroy( )
        end )
        task.delay( Number, function()
            Frame.BackgroundTransparency = 0.25
            local Table = { BackgroundTransparency = 1 }
            TweenService:Create( Frame, TweenInfo.new( 0.45, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )

            if ImageLabel then
                local Table2 = { ImageTransparency = 0 }
                TweenService:Create( ImageLabel, TweenInfo.new( 0.1, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )
                local UIScale = ImageLabel:FindFirstChildOfClass( "UIScale" )
                local Table3 = { Scale = 1 }
                TweenService:Create( UIScale, TweenInfo.new( 0.35, Enum.EasingStyle.Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table3 ):Play( )
            end
        end )
        task.delay( Number + 0.12, function()
            local Table = { GroupTransparency = 0 }
            TweenService:Create( CanvasGroup, TweenInfo.new( 0.35, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
        end )
        Value1 = nil

        for Key, Value in Table22, nil, nil do
            task.delay( Number + 0.18 + ( Key - 1 ) * 0.06, function()
                local Table = { TextTransparency = 0 }
                TweenService:Create( Value, TweenInfo.new( 0.35, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
            end )
        end

        task.delay( Number + 0.22, function()
            local Table = { Size = UDim2.fromScale( 0.65, 0.0045 ) }
            TweenService:Create( Parent12, TweenInfo.new( 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
            local Table2 = { BackgroundTransparency = 0.76 }
            TweenService:Create( Frame2, TweenInfo.new( 0.4, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )
        end )
    end

    return Callback
end

local Table16 = {
    riser = 1837834264,
    boom = 1837830050,
    mvp = 1837830671,
    riserPeak = 3.92,
    vol = {
        whoosh = 4.5,
        whoosh4 = 4,
        roll1 = 0.22,
        roll = 0.18,
        riser = 0.5,
        boom = 1,
        victory = 0.5,
        defeat = 0.65,
        mvp = 0.85
    }
}
function Table.Preload()
    if Table._preloaded then
        return
    end

    local Value1
    Table._preloaded = true
    local Parent = Instance.new( "Folder" )
    Parent.Name = "SonsSceneVictoire"
    local TableInner = { }
    local Table2 = { Table3, Table16 }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Value2 = nil

        for Key2, Value3 in Value, nil, nil do
            if type( Value3 ) == "number" and Value3 > 100000 then
                local Sound = Instance.new( "Sound" )
                Sound.SoundId = "rbxassetid://" .. Value3
                Sound.Volume = 0
                Sound.Parent = Parent
                table.insert( TableInner, Sound )
            end
        end
    end

    Parent.Parent = SoundService
    task.spawn( function()
        pcall( function()
            game:GetService( "ContentProvider" ):PreloadAsync( TableInner )
        end )
    end )
end

local function Smoother( Amount )
    return Amount * Amount * Amount * ( Amount * ( Amount * 6 - 15 ) + 10 )
end

local function HideWorld( Argument1 )
    local Table = { }
    local Table2 = { }
    local Table3 = { }

    local function HidePart( PartName )
        if PartName:IsA( "BasePart" ) or PartName:IsA( "Decal" ) then
            if not PartName:IsDescendantOf( Argument1 ) then
                if Table[ PartName ] == nil then
                    Table[ PartName ] = PartName.LocalTransparencyModifier
                end

                PartName.LocalTransparencyModifier = 1
            end
        end
    end

    local function HideModel( Self )
        if Self:IsDescendantOf( Argument1 ) then
            return
        end
        for Key, Value in Self:GetDescendants( ) do
            if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
                if not Value:IsDescendantOf( Argument1 ) then
                    if Table[ Value ] == nil then
                        Table[ Value ] = Value.LocalTransparencyModifier
                    end

                    Value.LocalTransparencyModifier = 1
                end
            end
        end
    end

    local function Off( Key )
        if Key:IsA( "BillboardGui" ) or Key:IsA( "Highlight" ) then
            if Key.Enabled and not Key:IsDescendantOf( Argument1 ) then
                Table2[ Key ] = true
                Key.Enabled = false
            end
        end
    end

    local FX = workspace:FindFirstChild( "FX" )

    local function InHidden( Self )
        if FX and Self:IsDescendantOf( FX ) then
            return true
        end

        local Model = Self:FindFirstAncestorOfClass( "Model" )

        while Model do
            if Model:FindFirstChildOfClass( "Humanoid" ) then
                return true
            end

            local Parent2
            local Parent = Model.Parent
            Parent2 = if Parent then Model.Parent:FindFirstAncestorOfClass( "Model" ) else Parent
            Model = Parent2
        end

        return false
    end

    for Key, Value in workspace:GetDescendants( ) do
        if Value:IsA( "Humanoid" ) and Value.Parent and not Value:IsDescendantOf( Argument1 ) then
            local Parent = Value.Parent

            if not Parent:IsDescendantOf( Argument1 ) then
                for Key4, Value4 in Parent:GetDescendants( ) do
                    if Value4:IsA( "BasePart" ) or Value4:IsA( "Decal" ) then
                        if not Value4:IsDescendantOf( Argument1 ) then
                            if Table[ Value4 ] == nil then
                                Table[ Value4 ] = Value4.LocalTransparencyModifier
                            end

                            Value4.LocalTransparencyModifier = 1
                        end
                    end
                end
            end
        end
        if Value:IsA( "BillboardGui" ) or Value:IsA( "Highlight" ) then
            if Value.Enabled and not Value:IsDescendantOf( Argument1 ) then
                Table2[ Value ] = true
                Value.Enabled = false
            end
        end
    end
    if FX then
        if not FX:IsDescendantOf( Argument1 ) then
            for Key2, Value2 in FX:GetDescendants( ) do
                if Value2:IsA( "BasePart" ) or Value2:IsA( "Decal" ) then
                    if not Value2:IsDescendantOf( Argument1 ) then
                        if Table[ Value2 ] == nil then
                            Table[ Value2 ] = Value2.LocalTransparencyModifier
                        end

                        Value2.LocalTransparencyModifier = 1
                    end
                end
            end
        end
    end
    for Key3, Value3 in LocalPlayer.PlayerGui:GetDescendants( ) do
        if Value3:IsA( "BillboardGui" ) or Value3:IsA( "Highlight" ) then
            if Value3.Enabled and not Value3:IsDescendantOf( Argument1 ) then
                Table2[ Value3 ] = true
                Value3.Enabled = false
            end
        end
    end

    table.insert( Table3, workspace.DescendantAdded:Connect( function( Self )
        if Self:IsDescendantOf( Argument1 ) then
            return
        end
        if Self:IsA( "BillboardGui" ) or Self:IsA( "Highlight" ) then
            if Self.Enabled and not Self:IsDescendantOf( Argument1 ) then
                Table2[ Self ] = true
                Self.Enabled = false
            end
        end
        if Self:IsA( "Humanoid" ) then
            task.defer( function()
                if Self.Parent then
                    local Parent = Self.Parent

                    if Parent:IsDescendantOf( Argument1 ) then
                        return
                    end
                    for Key, Value in Parent:GetDescendants( ) do
                        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
                            if not Value:IsDescendantOf( Argument1 ) then
                                if Table[ Value ] == nil then
                                    Table[ Value ] = Value.LocalTransparencyModifier
                                end

                                Value.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end
            end )
            return
        end
        if Self:IsA( "BasePart" ) or Self:IsA( "Decal" ) then
            if InHidden( Self ) then
                if Self:IsA( "BasePart" ) or Self:IsA( "Decal" ) then
                    if not Self:IsDescendantOf( Argument1 ) then
                        if Table[ Self ] == nil then
                            Table[ Self ] = Self.LocalTransparencyModifier
                        end

                        Self.LocalTransparencyModifier = 1
                    end
                end
            end
        end
    end ) )
    table.insert( Table3, LocalPlayer.PlayerGui.DescendantAdded:Connect( function( Argument1 )
        task.defer( Off, Argument1 )
    end ) )
    return function()
        local Value1 = nil

        for Value in Table, nil, nil do
            if Value.LocalTransparencyModifier < 1 and Value.Parent then
                Value.LocalTransparencyModifier = 1
            end
        end

        local Value2 = nil

        for Value3 in Table2, nil, nil do
            if Value3.Enabled and Value3.Parent then
                Value3.Enabled = false
            end
        end
    end, function()
        local Value1 = nil

        for Key, Value in Table3, nil, nil do
            Value:Disconnect( )
        end

        local Value2 = nil

        for Key2, Value3 in Table, nil, nil do
            if Key2.Parent then
                Key2.LocalTransparencyModifier = Value3
            end
        end

        local Value4 = nil

        for Value5 in Table2, nil, nil do
            if Value5.Parent then
                Value5.Enabled = true
            end
        end

        table.clear( Table )
        table.clear( Table2 )
    end
end

local function PlayScene( p1, p2, p3, p4, p5 )
    -- Could not structure function #118
end

function Table.Play( Argument1, Argument2, Argument3, Argument4 )
    local Table = { }
    local Success, Result = pcall( PlayScene, Argument1, Argument2, Argument3, Argument4, Table )

    if Success then
        return Result
    end

    local Count = #Table
    local I = Count

    for I = Count, 1, -1 do
        pcall( Table[ I ] )
    end

    error( Result, 0 )
end
return Table

--[[
Function #88 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #89 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Value.captureAim then
        Value.captureAim.model:Destroy( )
        Value.captureAim = nil
    end
end
]]

--[[
Function #90 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Argument1.x < Argument2.x and true or false
return Flag
]]

--[[
Function #91 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
Upvalue2.gui:Destroy( )
]]

--[[
Function #92 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = 0

while Upvalue1 do
    local Number2 = Number % 3 + 1
    local Loading = Upvalue2.loading
    Loading.Text = "LOADING" .. string.rep( ".", Number2 )
    task.wait( 0.35 )
    Number = Number2
end
]]

--[[
Function #93 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Value in Upvalue1, nil, nil do
    if Value.Parent then
        Value.Enabled = true
    end
end
]]

--[[
Function #94 has no emitted closure site
It is reproduced here so that nothing is lost

return Enum.ContextActionResult.Sink
]]

--[[
Function #95 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    pcall( Upvalue2.SetCoreGuiEnabled, Upvalue2, Key, Value )
end

Upvalue3:UnbindAction( "RankedVictoryBlock" )
]]

--[[
Function #96 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Value = UserSettings( ):GetService( "UserGameSettings" ).SavedQualityLevel.Value

if Value >= 1 then
    if Value <= 4 then
        Flag = true
    else
        Flag = false
    end
else
    Flag = false
end

Upvalue1 = Flag
]]

--[[
Function #97 has no emitted closure site
It is reproduced here so that nothing is lost

if Light:IsA( "Light" ) then
    if Upvalue1 then
        Light.Shadows = false
    end

    table.insert( Upvalue2, Light )
end
]]

--[[
Function #98 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Disconnect( )
]]

--[[
Function #99 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Enabled2

    if Value.Parent == nil then
        Enabled2 = false
    elseif Value.Brightness > 0.001 then
        Enabled2 = true
    else
        Enabled2 = false
    end
    if Value.Enabled ~= Enabled2 then
        Value.Enabled = Enabled2
    end
end

local Value2 = nil

for Key2, Value3 in Upvalue2, nil, nil do
    local Shade = Value3.shade

    if Shade and Shade.Parent then
        local Enabled

        if Shade.FillTransparency < 0.999 then
            Enabled = true
        elseif Shade.OutlineTransparency < 0.999 then
            Enabled = true
        else
            Enabled = false
        end
        if Shade.Enabled ~= Enabled then
            Shade.Enabled = Enabled
        end
    end
end
]]

--[[
Function #100 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Destroy( )
end

Upvalue2( )
]]

--[[
Function #101 has no emitted closure site
It is reproduced here so that nothing is lost

local Total = 1 - ( 1 - Amount ) ^ 3
local Captured = Upvalue1 + Upvalue2 * ( Upvalue3 - 1.6 * Total ) + Vector3.new( 0, 1, 0 ) * ( 1.35 + 0.3 * Total )
return CFrame.lookAt( Captured, Upvalue4 ), Captured
]]

--[[
Function #102 has no emitted closure site
It is reproduced here so that nothing is lost

local X2
local ViewportSize = workspace.CurrentCamera.ViewportSize

if ViewportSize.Y > 0 then
    local X = ViewportSize.X / ViewportSize.Y

    if X then
        X2 = X
    else
        X2 = 1.7777777777777777
    end
else
    X2 = 1.7777777777777777
end

return ( math.clamp( math.deg( math.atan( 0.6008606190275604 / X2 ) * 2 ), 26, 60 ) )
]]

--[[
Function #103 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1 ~= Upvalue2 and true or false
return Flag
]]

--[[
Function #104 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1:IsStudio( ) then
    return nil
end

local DebugVictoryAt2
local DebugVictoryAt = Upvalue2:GetAttribute( "DebugVictoryAt" )
DebugVictoryAt2 = type( DebugVictoryAt ) == "number" and DebugVictoryAt or nil
return DebugVictoryAt2
]]

--[[
Function #105 has no emitted closure site
It is reproduced here so that nothing is lost

while Upvalue1 < Argument1 do
    local Flag = Upvalue2 ~= Upvalue3 and true or false

    if Flag or Upvalue4 then
        error( "__RankedVictoryAbort", 0 )
    end

    Upvalue5.Heartbeat:Wait( )
end
]]

--[[
Function #106 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.t0 = Upvalue2
Upvalue1.amp = Amp
]]

--[[
Function #107 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:UnbindFromRenderStep( "RankedVictoryCam" )
Upvalue1:UnbindFromRenderStep( "RankedVictoryNames" )
Upvalue2.FixedCamera = nil
Upvalue2.FixedFOV = nil
]]

--[[
Function #108 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local DebugVictoryAt2

    if Upvalue2:IsStudio( ) then
        local DebugVictoryAt = Upvalue3:GetAttribute( "DebugVictoryAt" )

        if type( DebugVictoryAt ) ~= "number" or not DebugVictoryAt then
            DebugVictoryAt2 = nil
        else
            DebugVictoryAt2 = DebugVictoryAt
        end
    else
        DebugVictoryAt2 = nil
    end
    if not DebugVictoryAt2 or not ( DebugVictoryAt2 <= Upvalue4 ) then
        Upvalue4 = Upvalue4 + math.min( Argument1, 0.1 )
    end
    if DebugVictoryAt2 then
        Upvalue3:SetAttribute( "DebugVictoryClock", Upvalue4 )
    end
end

local LookAt, FocusDistance, FixedFOV, InFocusRadius, FarIntensity

if Upvalue4 < 1.6 then
    local Lerp = Upvalue5:Lerp( Upvalue6, ( math.clamp( Upvalue4 / 1.6, 0, 1 ) ) )
    local Captured = Upvalue7 + Upvalue8 * ( Upvalue8:Dot( Lerp - Upvalue7 ) + 1.1 ) + Vector3.new( 0, 2.0999999046325684, 0 )
    LookAt = CFrame.lookAt( Lerp, Captured )
    FocusDistance = ( Captured - Lerp ).Magnitude
    InFocusRadius = 3
    FarIntensity = 0.35
    FixedFOV = 38
elseif Upvalue4 < Upvalue9 then
    local Floor2
    local Max = math.max( 0, Upvalue4 - 1.6 - 0.35 ) / Upvalue10
    local Floor = math.floor( Max )
    local Max2 = Max - Floor

    if #Upvalue11 - 1 <= Floor then
        Floor2 = #Upvalue11 - 1
        Max2 = 0
    else
        Floor2 = Floor
    end

    local Entry = Upvalue11[ Floor2 + 1 ]
    local Floor3 = Floor2 + 2
    local Entry2 = Upvalue11[ math.min( Floor3, #Upvalue11 ) ]
    local Clamp = math.clamp( Max2, 0, 1 )
    local Clamp2 = Clamp * Clamp * Clamp * ( Clamp * ( Clamp * 6 - 15 ) + 10 )
    local Pos = Entry.pos
    local Lerp2 = Pos:Lerp( Entry2.pos, Clamp2 ) - Upvalue12 * ( ( Upvalue4 - 1.6 ) * 0.4 / Upvalue13 )
    local Aim = Entry.aim
    LookAt = CFrame.lookAt( Lerp2, Aim:Lerp( Entry2.aim, Clamp2 ) )
    local Head = Entry.head
    FocusDistance = ( Lerp2 - Head:Lerp( Entry2.head, Clamp2 ) ).Magnitude
    InFocusRadius = 2.2
    FarIntensity = 0.42
    FixedFOV = 30
elseif Upvalue4 < Upvalue14 or not Upvalue15 then
    local X6
    local Clamp5 = 1 - ( 1 - math.clamp( ( Upvalue4 - Upvalue9 ) / 2.4, 0, 1 ) ) ^ 3
    local Captured4 = Upvalue7 + Upvalue12 * ( Upvalue16 - 1.6 * Clamp5 ) + Vector3.new( 0, 1, 0 ) * ( 1.35 + 0.3 * Clamp5 )
    LookAt = CFrame.lookAt( Captured4, Upvalue17 )
    local ViewportSize3 = workspace.CurrentCamera.ViewportSize

    if ViewportSize3.Y > 0 then
        local X5 = ViewportSize3.X / ViewportSize3.Y

        if X5 then
            X6 = X5
        else
            X6 = 1.7777777777777777
        end
    else
        X6 = 1.7777777777777777
    end

    FixedFOV = math.clamp( math.deg( math.atan( 0.6008606190275604 / X6 ) * 2 ), 26, 60 )
    FocusDistance = ( Captured4 - Upvalue7 ).Magnitude
    InFocusRadius = Upvalue18 + 6
    FarIntensity = 0.18
else
    local Captured2 = Upvalue4 - Upvalue14

    if Captured2 < 0.7 then
        local X2
        local Captured3 = 1 - ( 1 - Captured2 / 0.7 ) ^ 4
        LookAt = CFrame.lookAt( Upvalue7 + Upvalue12 * ( Upvalue16 - 1.6 ) + Vector3.new( 0, 1.649999976158142, 0 ), Upvalue17 ):Lerp( Upvalue15, Captured3 )
        local ViewportSize = workspace.CurrentCamera.ViewportSize

        if ViewportSize.Y > 0 then
            local X = ViewportSize.X / ViewportSize.Y

            if X then
                X2 = X
            else
                X2 = 1.7777777777777777
            end
        else
            X2 = 1.7777777777777777
        end

        local X4
        local Clamp3 = math.clamp( math.deg( math.atan( 0.6008606190275604 / X2 ) * 2 ), 26, 60 )
        local ViewportSize2 = workspace.CurrentCamera.ViewportSize

        if ViewportSize2.Y > 0 then
            local X3 = ViewportSize2.X / ViewportSize2.Y

            if X3 then
                X4 = X3
            else
                X4 = 1.7777777777777777
            end
        else
            X4 = 1.7777777777777777
        end

        FixedFOV = Clamp3 + ( 30 - math.clamp( math.deg( math.atan( 0.6008606190275604 / X4 ) * 2 ), 26, 60 ) ) * Captured3
    else
        local Clamp4 = math.clamp( ( Captured2 - 0.7 ) / 3.2, 0, 1 )
        local Position = Upvalue19.spot.Position
        LookAt = CFrame.new( Position ) * CFrame.Angles( 0, math.rad( Clamp4 * -3.5 ), 0 ) * CFrame.new( -Position ) * Upvalue15 * CFrame.new( 0, 0, Clamp4 * -0.5 )
        FixedFOV = 30 - Clamp4 * 2.5
    end

    FocusDistance = ( LookAt.Position - Upvalue19.head ).Magnitude
    InFocusRadius = 3
    FarIntensity = 0.36
end

local Amp = Upvalue20.amp * math.max( 0, 1 - ( Upvalue4 - Upvalue20.t0 ) / 0.35 ) ^ 2

if Amp > 0 then
    LookAt = LookAt * CFrame.Angles( math.noise( Upvalue4 * 23, 1.1 ) * Amp, math.noise( Upvalue4 * 21, 4.3 ) * Amp, math.noise( Upvalue4 * 19, 7.7 ) * Amp * 0.5 )
end

Upvalue21.FocusDistance = FocusDistance
Upvalue21.InFocusRadius = InFocusRadius
Upvalue21.FarIntensity = FarIntensity
Upvalue22( )
Upvalue23( )

if Upvalue24 then
    Upvalue24( )
end
if Upvalue25.skip and Upvalue25.skip.Visible and not Upvalue26.CursorFree then
    Upvalue26.CursorFree = true
end

Upvalue26.FixedCamera = LookAt * Upvalue27( Upvalue4 )
Upvalue26.FixedFOV = FixedFOV
]]

--[[
Function #109 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local CurrentCamera = workspace.CurrentCamera
local ViewportSize = CurrentCamera.ViewportSize
local WorldToViewportPoint = CurrentCamera:WorldToViewportPoint( Upvalue1 )
local Y = ViewportSize.Y / ( math.max( WorldToViewportPoint.Z, 1 ) * 2 * math.tan( math.rad( CurrentCamera.FieldOfView ) / 2 ) )
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    local WorldToViewportPoint2 = CurrentCamera:WorldToViewportPoint( Value.pos )
    local Y2 = WorldToViewportPoint2.Y / math.max( ViewportSize.Y, 1 )
    local Sw = 4.4 * Y / math.max( ViewportSize.X, 1 )
    local Sh = 1.72 * Y / math.max( ViewportSize.Y, 1 )

    if Value.sw then
        local Abs = math.abs( Sw - Value.sw )

        if Value.sw * 0.02 < Abs then
            Value.sw = Sw
            Value.sh = Sh
            local Label = Value.label
            Label.Size = UDim2.fromScale( Sw, Sh )
        else
            local Abs2 = math.abs( Sh - Value.sh )

            if Value.sh * 0.02 < Abs2 then
                Value.sw = Sw
                Value.sh = Sh
                local Label = Value.label
                Label.Size = UDim2.fromScale( Sw, Sh )
            end
        end
    else
        Value.sw = Sw
        Value.sh = Sh
        local Label = Value.label
        Label.Size = UDim2.fromScale( Sw, Sh )
    end

    local Visible
    local Label2 = Value.label
    Label2.Position = UDim2.fromScale( WorldToViewportPoint2.X / math.max( ViewportSize.X, 1 ), Y2 )
    local Label3 = Value.label

    if Value.label.GroupTransparency < 0.99 then
        if Y2 - Value.label.Size.Y.Scale > 0.09 then
            Visible = true
        else
            Visible = false
        end
    else
        Visible = false
    end

    Label3.Visible = Visible
end
]]

--[[
Function #110 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if workspace:Raycast( Upvalue1 + Vector3.new( 0, 3, 0 ), Vector3.new( 0, -8, 0 ), Upvalue2 ) == nil then
    Flag = false
elseif workspace:Raycast( Upvalue1 + Vector3.new( 0, 3, 0 ), -Upvalue3 * 60, Upvalue2 ) == nil then
    Flag = false
else
    Flag = true
end

return Flag
]]

--[[
Function #111 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if Upvalue2 then
    pcall( Upvalue2 )
end
]]

--[[
Function #112 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.CursorFree = Upvalue2
Upvalue3:UnbindAction( "RankedVictorySkip" )
]]

--[[
Function #113 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    local Flag = Upvalue2 ~= Upvalue3 and true or false

    if not Flag then
        Upvalue1 = true

        if Upvalue4.skip then
            Upvalue4.skip.Visible = false
        end

        Upvalue5.Abort( )
        return
    end
end
]]

--[[
Function #114 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 == Enum.UserInputState.Begin and not Upvalue1 then
    local Flag = Upvalue2 ~= Upvalue3 and true or false

    if not Flag then
        Upvalue1 = true

        if Upvalue4.skip then
            Upvalue4.skip.Visible = false
        end

        Upvalue5.Abort( )
    end
end

return Enum.ContextActionResult.Sink
]]

--[[
Function #115 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1 - Upvalue2.riserPeak

if not ( Captured > 0 ) or pcall( Upvalue3, Captured ) then
    local Riser = Upvalue2.riser
    local Riser2 = Upvalue2.vol.riser
    Upvalue4( Riser, Riser2, 1, ( math.max( 0, -Captured ) ) )
    return
end
return
]]

--[[
Function #116 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1 ~= Upvalue2 and true or false

if not Flag then
    pcall( Upvalue3, Upvalue4 )
end
]]

--[[
Function #117 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1 ~= Upvalue2 and true or false

if Flag then
    error( "__RankedVictoryAbort", 0 )
end

Upvalue3( Upvalue4.whoosh, Upvalue5.vol.whoosh )
task.spawn( function()
    local Captured = Upvalue6 - Upvalue5.riserPeak

    if not ( Captured > 0 ) or pcall( Upvalue7, Captured ) then
        local Riser = Upvalue5.riser
        local Riser2 = Upvalue5.vol.riser
        Upvalue3( Riser, Riser2, 1, ( math.max( 0, -Captured ) ) )
        return
    end
    return
end )
local Black = Upvalue8.black
local Table = { BackgroundTransparency = 1 }
local Value1
Upvalue9:Create( Black, TweenInfo.new( 0.9, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table ):Play( )
local Top = Upvalue8.top
local Table2 = { Size = UDim2.fromScale( 1, 0.085 ) }
Upvalue9:Create( Top, TweenInfo.new( 0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table2 ):Play( )
local Bottom = Upvalue8.bottom
local Table3 = { Size = UDim2.fromScale( 1, 0.17 ) }
Upvalue9:Create( Bottom, TweenInfo.new( 0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table3 ):Play( )
Upvalue10.fill.Brightness = 0.25
Upvalue10.key.Brightness = 0
local Table4 = { Upvalue10.rimL, Upvalue10.rimR }
Value1 = nil

for Key, Value in Table4, nil, nil do
    local Table26 = { Brightness = 3.2 }
    Upvalue9:Create( Value, TweenInfo.new( 0.9, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table26 ):Play( )
end

local Wash = Upvalue10.wash
local Table5 = { Brightness = 3.4 }
Upvalue9:Create( Wash, TweenInfo.new( 1, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table5 ):Play( )
Upvalue7( 1.6 )
Upvalue3( Upvalue4.roll, Upvalue5.vol.roll1 )
local Key2 = Upvalue10.key
local Table6 = { Brightness = 0.55 }
local Value2, Value4
Upvalue9:Create( Key2, TweenInfo.new( Upvalue11, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table6 ):Play( )
Value2 = nil
Value4 = nil

for Key3, Value3 in Upvalue12, nil, nil do
    Upvalue7( 1.9500000000000002 + ( Key3 - 1 ) * Upvalue13 - 0.06 )

    if Value4 then
        Value4.thirdHide( )
    end

    Value3.spotL.Brightness = 3
    local SpotL3 = Value3.spotL
    local Table24 = { Brightness = 1.5 }
    Upvalue9:Create( SpotL3, TweenInfo.new( 0.5, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table24 ):Play( )
    Value3.face.Brightness = 2
    local Face3 = Value3.face
    local Table25 = { Brightness = 1.3 }
    Upvalue9:Create( Face3, TweenInfo.new( 0.5, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table25 ):Play( )
    Value3.thirdShow( )
    Upvalue3( Upvalue4.roll, Upvalue5.vol.roll )
    Value4 = Value3
end

Upvalue7( Upvalue6 )

if Value4 then
    Value4.thirdHide( )
end
if Upvalue8.outcome == "Defaite" then
    Upvalue3( Upvalue4.defeat, Upvalue5.vol.defeat )
else
    Upvalue3( Upvalue4.victory, Upvalue5.vol.victory )
end

Upvalue3( Upvalue5.boom, Upvalue5.vol.boom )
Upvalue14.t0 = Upvalue15
Upvalue14.amp = 0.012
local Key4 = Upvalue10.key
local Table7 = { Brightness = 2.3 }
Upvalue9:Create( Key4, TweenInfo.new( 0.25, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table7 ):Play( )
local Fill = Upvalue10.fill
local Table8 = { Brightness = 0.85 }
local Value5
Upvalue9:Create( Fill, TweenInfo.new( 0.25, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table8 ):Play( )
Value5 = nil

for Key5, Value6 in Upvalue12, nil, nil do
    local SpotL2 = Value6.spotL
    local Table23 = { Brightness = 0.6 }
    Upvalue9:Create( SpotL2, TweenInfo.new( 0.4, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table23 ):Play( )
end

local Value7
local Table9 = { Upvalue10.rimL, Upvalue10.rimR }
Value7 = nil

for Key6, Value8 in Table9, nil, nil do
    Value8.Brightness = 6.5
    local Table22 = { Brightness = 4.5 }
    Upvalue9:Create( Value8, TweenInfo.new( 0.9, Enum.EasingStyle.Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table22 ):Play( )
end
if Upvalue8.banner then
    Upvalue8.banner( )
end

local Value9 = nil

for Key7, Value10 in Upvalue12, nil, nil do
    task.delay( ( Key7 - 1 ) * 0.05, Value10.plateShow )
end

Upvalue7( Upvalue16 )

if Upvalue17 then
    local Value11
    Upvalue3( Upvalue4.whoosh, Upvalue5.vol.whoosh4 )
    task.delay( 0.175, function()
        local Flag = Upvalue1 ~= Upvalue2 and true or false

        if not Flag then
            pcall( Upvalue18, Upvalue17 )
        end
    end )
    Value11 = nil

    for Key8, Value12 in Upvalue12, nil, nil do
        Value12.plateHide( )
    end

    local Value13 = nil

    for Key9, Value14 in Upvalue12, nil, nil do
        if Value14.shade then
            local Shade = Value14.shade
            local Table21 = { FillTransparency = 0.3 }
            Upvalue9:Create( Shade, TweenInfo.new( 1.2999999999999998, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table21 ):Play( )
        end
    end

    local Key10 = Upvalue10.key
    local Table10 = { Brightness = 0.6 }
    Upvalue9:Create( Key10, TweenInfo.new( 0.8, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table10 ):Play( )
    local Fill2 = Upvalue10.fill
    local Table11 = { Brightness = 0.35 }
    Upvalue9:Create( Fill2, TweenInfo.new( 0.8, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table11 ):Play( )
    local Wash2 = Upvalue10.wash
    local Table12 = { Brightness = 2.2 }
    local Value15
    Upvalue9:Create( Wash2, TweenInfo.new( 0.8, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table12 ):Play( )
    local Table13 = { Upvalue10.rimL, Upvalue10.rimR }
    Value15 = nil

    for Key11, Value16 in Table13, nil, nil do
        local Table20 = { Brightness = 2.2 }
        Upvalue9:Create( Value16, TweenInfo.new( 0.8, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table20 ):Play( )
    end

    local Value17 = nil

    for Key12, Value18 in Upvalue12, nil, nil do
        local SpotL = Value18.spotL
        local Table18 = { Brightness = 0 }
        Upvalue9:Create( SpotL, TweenInfo.new( 0.5, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table18 ):Play( )
        local Face2 = Value18.face
        local Table19 = { Brightness = 0 }
        Upvalue9:Create( Face2, TweenInfo.new( 0.5, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table19 ):Play( )
    end
    if Upvalue19 then
        local Key13 = Upvalue19.key
        local Table14 = { Brightness = 1 }
        Upvalue9:Create( Key13, TweenInfo.new( 0.9, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table14 ):Play( )
        local Face = Upvalue19.face
        local Table15 = { Brightness = 0.55 }
        Upvalue9:Create( Face, TweenInfo.new( 0.9, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table15 ):Play( )
        local Hair = Upvalue19.hair
        local Table16 = { Brightness = 1.5 }
        Upvalue9:Create( Hair, TweenInfo.new( 0.9, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table16 ):Play( )
        local Edge = Upvalue19.edge
        local Table17 = { Brightness = 0.8 }
        Upvalue9:Create( Edge, TweenInfo.new( 0.9, Enum.EasingStyle.Sine or Enum.EasingStyle.Quint, Enum.EasingDirection.Out ), Table17 ):Play( )
    end

    Upvalue7( Upvalue16 + 0.5249999999999999 - 0.32 )

    if Upvalue20 then
        Upvalue20( 0.32 )
    end

    Upvalue7( Upvalue16 + 0.5249999999999999 )
    Upvalue3( Upvalue5.mvp, Upvalue5.vol.mvp )
    Upvalue14.t0 = Upvalue15
    Upvalue14.amp = 0.006

    if Upvalue19 then
        Upvalue19.sweepGo( )
    end
end

Upvalue7( Upvalue21 - 0.7 )
]]
