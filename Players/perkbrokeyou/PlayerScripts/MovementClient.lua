-- Players.perkbrokeyou.PlayerScripts.MovementClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Global = require( Weapons:WaitForChild( "Config" ) ).Global
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local Holds = require( Weapons:WaitForChild( "Holds" ) )
local LocalPlayer = Players.LocalPlayer

local function AimTwist()
    local Tool
    local Character = LocalPlayer.Character

    if Character then
        Tool = LocalPlayer.Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Weapon
    local AimTwist = Holds.AimTwist
    Weapon = Tool and Tool:GetAttribute( "Weapon" ) or "M4A1"
    return AimTwist( Weapon )
end

local Flag = false
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local Flag2 = false
local Value1 = nil
local Flag3 = false
local Flag4 = false
ClientState.StaminaMax = 150
ClientState.StaminaResprint = 20
ClientState.JumpCost = 10
ClientState.Stamina = 150
ClientState.Exhausted = false
local Number = 0
local Table = { [ "507765000" ] = true, [ "507767968" ] = true }

local function Spend( Argument1 )
    ClientState.Stamina = math.max( ClientState.Stamina - Argument1, 0 )
    Number = os.clock( )

    if ClientState.Stamina <= 0 then
        ClientState.Exhausted = true
        Flag3 = true
        Flag2 = false
    end
end

local function Boost()
    local EDrinkUntil
    local Character = LocalPlayer.Character

    if Character then
        EDrinkUntil = Character:GetAttribute( "EDrinkUntil" )
    else
        EDrinkUntil = Character
    end
    if not EDrinkUntil or not ( workspace:GetServerTimeNow( ) < EDrinkUntil ) then
        return 1, 1
    end
    return Character:GetAttribute( "EDrinkSpeed" ) or 1, Character:GetAttribute( "EDrinkDrain" ) or 1
end

local function OnCharacter( Object )
    ClientState.Stamina = 150
    ClientState.Exhausted = false
    local Humanoid = Object:WaitForChild( "Humanoid" )
    Humanoid.StateChanged:Connect( function( Argument1, Argument2 )
        if Argument2 == Enum.HumanoidStateType.Jumping and Argument1 ~= Enum.HumanoidStateType.Seated and not Humanoid.SeatPart and not Object:GetAttribute( "Downed" ) then
            ClientState.Stamina = math.max( ClientState.Stamina - 10, 0 )
            Number = os.clock( )

            if ClientState.Stamina <= 0 then
                ClientState.Exhausted = true
                Flag3 = true
                Flag2 = false
            end
        end
    end )
    Humanoid:WaitForChild( "Animator" ).AnimationPlayed:Connect( function( Track )
        if Table[ Track.Animation.AnimationId:match( "%d+$" ) or "" ] then
            Track:AdjustSpeed( 0.6 )
        end
    end )
    Object:GetAttributeChangedSignal( "EDrinkUntil" ):Connect( function()
        if Object:GetAttribute( "EDrinkUntil" ) then
            ClientState.Stamina = math.min( ClientState.Stamina + ( Object:GetAttribute( "EDrinkStamina" ) or 0 ), 150 )
        end
    end )
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end

Controls.OnInputBegan( function( Argument1, Argument2 )
    if Argument2 or not Controls.Is( "Sprint", Argument1 ) then
        return
    end
    if type( Argument1 ) == "table" and Argument1.Hold then
        Flag = true
        Flag3 = false
        return
    end
    if type( Argument1 ) ~= "table" then
        if Argument1.UserInputType == Enum.UserInputType.Keyboard or Argument1.UserInputType.Name:sub( 1, 11 ) == "MouseButton" then
            Flag = true
            Flag3 = false
            return
        end
        if Argument1.UserInputType.Name:sub( 1, 7 ) == "Gamepad" and Controls.Settings.PadSprint == "Hold" then
            Flag = true
            Flag3 = false
            return
        end
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if type( Argument1 ) == "table" and Flag2 and ClientState.Sprinting then
        Flag2 = false
        return
    end
    if Humanoid and Humanoid.MoveDirection.Magnitude > 0.1 then
        Flag2 = true
        Value1 = nil
        Flag3 = false
    end
end )
Controls.OnInputEnded( function()
    if Flag and not Controls.IsDown( "Sprint" ) then
        Flag = false
    end
end )

local function AngleDiff( Argument1, Argument2 )
    return ( Argument2 - Argument1 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793
end

local Value2 = nil
local Value3 = nil

local function TurnAlignFor( Parent )
    if Value3 == Parent and Value2 and Value2.Parent == Parent then
        return Value2
    end

    local Attachment0
    local TurnAtt = Parent:FindFirstChild( "TurnAtt" )

    if TurnAtt then
        Attachment0 = TurnAtt
    else
        Attachment0 = Instance.new( "Attachment" )
    end

    local AlignOrientation
    Attachment0.Name = "TurnAtt"
    Attachment0.Parent = Parent
    local TurnAlign = Parent:FindFirstChild( "TurnAlign" )

    if TurnAlign then
        AlignOrientation = TurnAlign
    else
        AlignOrientation = Instance.new( "AlignOrientation" )
    end

    AlignOrientation.Name = "TurnAlign"
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    AlignOrientation.Attachment0 = Attachment0
    AlignOrientation.RigidityEnabled = false
    AlignOrientation.Responsiveness = 200
    AlignOrientation.MaxAngularVelocity = 25
    AlignOrientation.MaxTorque = 0
    AlignOrientation.Parent = Parent
    Value2 = AlignOrientation
    Value3 = Parent
    return AlignOrientation
end

local Value4 = nil

local function ReleaseTurn()
    Value4 = nil

    if Value2 and Value2.MaxTorque ~= 0 then
        Value2.MaxTorque = 0
    end
end

RunService.PreSimulation:Connect( function()
    if not Value2 or Value2.MaxTorque == 0 or not Value3 or not Value3.Parent then
        return
    end

    local Humanoid = Value3.Parent:FindFirstChildOfClass( "Humanoid" )

    if Value3.AssemblyRootPart == Value3 then
        if Humanoid then
            if Humanoid.Sit or Humanoid.SeatPart ~= nil or Humanoid.PlatformStand then
                Value4 = nil

                if Value2 and Value2.MaxTorque ~= 0 then
                    Value2.MaxTorque = 0
                end
            end
        end
    else
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end
    end
end )
RunService:BindToRenderStep( "Movement", Enum.RenderPriority.Camera.Value + 1, function( Amount )
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local HumanoidRootPart

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 then
        ClientState.Sprinting = false
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end

        return
    end
    local FlagInner = script:GetAttribute( "RotationCFrame" ) ~= true and true or false

    if FlagInner then
        TurnAlignFor( HumanoidRootPart )
    end

    local Flag3Inner
    local MoveDirection = Humanoid.MoveDirection
    local Anchored = HumanoidRootPart.Anchored
    Flag3Inner = if MoveDirection.Magnitude > 0.1 then not Anchored else false
    local Flag2Inner = Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming and true or false
    local Flag6 = if Flag2Inner then Humanoid.Jump else Flag2Inner
    local Combat2

    if ClientState.Equipped then
        local Combat = ClientState.Combat

        if Combat then
            Combat2 = Combat
        elseif ClientState.FistCombat == true then
            Combat2 = true
        elseif ClientState.MeleeAim == true then
            Combat2 = true
        else
            Combat2 = false
        end
    elseif ClientState.FistCombat == true then
        Combat2 = true
    elseif ClientState.MeleeAim == true then
        Combat2 = true
    else
        Combat2 = false
    end
    if not Flag2 or Flag3Inner then
        Value1 = nil
    else
        Value1 = Value1 or os.clock( )

        if os.clock( ) - Value1 > 0.15 then
            Flag2 = false
        end
    end

    local Flag4Inner = ClientState.Crouching == true and true or false

    if Flag4Inner and not Flag4 then
        Flag2 = false
    end

    local Captured
    Flag4 = Flag4Inner
    Captured = ( Flag or Flag2 ) and not Flag3

    if ClientState.Equipped then
        local Reloading = ClientState.Reloading
    end

    local NotExhausted2
    local NotExhausted = not ClientState.Exhausted
    NotExhausted2 = if NotExhausted then not Character:GetAttribute( "StaminaOut" ) else NotExhausted
    local Flag5

    if Character:GetAttribute( "Downed" ) == true then
        Flag5 = true
    elseif Character:GetAttribute( "CarRagdoll" ) == true then
        Flag5 = true
    else
        Flag5 = false
    end

    local Sit2
    local Sit = Humanoid.Sit

    if Sit then
        Sit2 = Sit
    elseif Humanoid.SeatPart == nil then
        Sit2 = Flag5
    else
        Sit2 = true
    end

    local Sprinting

    if Captured then
        if Flag3Inner or Flag6 then
            local NotCombat = not Combat2

            if NotCombat then
                if NotExhausted2 then
                    Sprinting = not Sit2
                else
                    Sprinting = NotExhausted2
                end
            else
                Sprinting = NotCombat
            end
        else
            Sprinting = Flag6
        end
    else
        Sprinting = Captured
    end

    local CrouchSpeed2, Flag7
    ClientState.Sprinting = Sprinting

    if Sprinting then
        local NumberInner = if Flag2Inner then 21 else Global.SprintSpeed
        CrouchSpeed2 = NumberInner
        Flag7 = true
    elseif ClientState.Crouching then
        local Number2
        local CrouchSpeed = Global.CrouchSpeed or 8

        if ClientState.Equipped or ClientState.FistAim or ClientState.MeleeAim then
            if not ClientState.Aiming or ClientState.LaserFire then
                Number2 = 1
            else
                Number2 = 0.8
            end
        else
            Number2 = 1
        end

        CrouchSpeed2 = CrouchSpeed * Number2
        Flag7 = false
    elseif ClientState.Equipped or ClientState.FistAim or ClientState.MeleeAim then
        if not ClientState.Aiming or ClientState.LaserFire then
            local Number3

            if Flag2Inner then
                Number3 = 14
            else
                Number3 = Global.WalkSpeed
            end

            CrouchSpeed2 = Number3
            Flag7 = false
        else
            local Captured2

            if Captured then
                if Flag3Inner then
                    if NotExhausted2 then
                        Captured2 = not Sit2
                    else
                        Captured2 = NotExhausted2
                    end
                else
                    Captured2 = Flag3Inner
                end
            else
                Captured2 = Captured
            end

            local AimSprintMultiplier2
            local AimWalkSpeed = ClientState.AimWalkSpeed

            if Captured2 then
                local AimSprintMultiplier = Global.AimSprintMultiplier

                if AimSprintMultiplier then
                    AimSprintMultiplier2 = AimSprintMultiplier
                else
                    AimSprintMultiplier2 = 1.35
                end
            else
                AimSprintMultiplier2 = 1
            end

            CrouchSpeed2 = AimWalkSpeed * AimSprintMultiplier2
            Flag7 = Captured2
        end
    else
        if Flag2Inner then
            Number3 = 14
        else
            Number3 = Global.WalkSpeed
        end

        CrouchSpeed2 = Number3
        Flag7 = false
    end

    local EDrinkUntil
    local Character2 = LocalPlayer.Character

    if Character2 then
        EDrinkUntil = Character2:GetAttribute( "EDrinkUntil" )
    else
        EDrinkUntil = Character2
    end

    local EDrinkSpeed, EDrinkDrain

    if not EDrinkUntil or not ( workspace:GetServerTimeNow( ) < EDrinkUntil ) then
        EDrinkSpeed = 1
        EDrinkDrain = 1
    else
        EDrinkSpeed = Character2:GetAttribute( "EDrinkSpeed" ) or 1
        EDrinkDrain = Character2:GetAttribute( "EDrinkDrain" ) or 1
    end

    local WalkSpeed = CrouchSpeed2 * ( EDrinkSpeed * ( Global.MoveSpeedMul or 1 ) )

    if ClientState.NavFreeze or ClientState.Freecam then
        WalkSpeed = 0
        Flag7 = false
    end
    if Humanoid.WalkSpeed ~= WalkSpeed then
        Humanoid.WalkSpeed = WalkSpeed
    end
    if not ClientState.Rolling then
        if Flag7 then
            local EDrinkDrain2 = 20 * EDrinkDrain * Amount
            ClientState.Stamina = math.max( ClientState.Stamina - EDrinkDrain2, 0 )
            Number = os.clock( )

            if ClientState.Stamina <= 0 then
                ClientState.Exhausted = true
                Flag3 = true
                Flag2 = false
            end
        elseif os.clock( ) - math.max( Number, ClientState.LastStaminaUse or 0 ) > 0.8 then
            ClientState.Stamina = math.min( ClientState.Stamina + 30 * Amount, 150 )
        end
    end
    if ClientState.Exhausted and ClientState.Stamina >= 20 then
        ClientState.Exhausted = false
    end
    if Humanoid.AutoRotate then
        Humanoid.AutoRotate = false
    end
    if Humanoid.Sit or Humanoid.SeatPart or Humanoid.PlatformStand then
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end

        return
    end
    if ClientState.Rolling then
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end

        return
    end
    if Anchored then
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end

        return
    end
    if ClientState.Frozen or ClientState.NavFreeze or ClientState.Freecam then
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end

        return
    end
    local CamYaw2, CombatTurnSpeed
    local _, ToOrientation2 = HumanoidRootPart.CFrame:ToOrientation( )

    if Combat2 then
        local AimTwist3
        local CamYaw = ClientState.CamYaw

        if ClientState.Equipped then
            local Tool
            local Character3 = LocalPlayer.Character

            if Character3 then
                Tool = LocalPlayer.Character:FindFirstChildOfClass( "Tool" )
            else
                Tool = Character3
            end

            local Weapon
            local AimTwist = Holds.AimTwist
            Weapon = Tool and Tool:GetAttribute( "Weapon" ) or "M4A1"
            local AimTwist2 = AimTwist( Weapon )

            if AimTwist2 then
                AimTwist3 = AimTwist2
            else
                AimTwist3 = 0
            end
        else
            AimTwist3 = 0
        end

        CamYaw2 = CamYaw + AimTwist3
        CombatTurnSpeed = Global.CombatTurnSpeed

        if not FlagInner or not Value2 then
            local ToOrientation22 = ToOrientation2 + ( ( CamYaw2 - ToOrientation2 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * ( 1 - math.exp( -CombatTurnSpeed * Amount ) )
            HumanoidRootPart.CFrame = CFrame.new( HumanoidRootPart.Position ) * CFrame.Angles( 0, ToOrientation22, 0 )
        else
            if not Value4 or math.abs( ( Value4 - ToOrientation2 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) > 0.6 then
                Value4 = ToOrientation2
            end

            Value4 = Value4 + ( ( CamYaw2 - Value4 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * ( 1 - math.exp( -CombatTurnSpeed * Amount ) )
            Value2.CFrame = CFrame.Angles( 0, Value4, 0 )

            if Value2.MaxTorque ~= math.huge then
                Value2.MaxTorque = math.huge
                return
            end
        end

        return
    end
    if not Flag3Inner then
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end

        return
    end
    if MoveDirection.X * MoveDirection.X + MoveDirection.Z * MoveDirection.Z < 0.01 then
        Value4 = nil

        if Value2 and Value2.MaxTorque ~= 0 then
            Value2.MaxTorque = 0
        end

        return
    end
    local SprintTurnSpeed2
    local Amount2 = -MoveDirection.X
    CamYaw2 = math.atan2( Amount2, -MoveDirection.Z )

    if Sprinting then
        local SprintTurnSpeed = Global.SprintTurnSpeed

        if SprintTurnSpeed then
            SprintTurnSpeed2 = SprintTurnSpeed
        else
            SprintTurnSpeed2 = Global.TurnSpeed
        end
    else
        SprintTurnSpeed2 = Global.TurnSpeed
    end

    CombatTurnSpeed = SprintTurnSpeed2

    if not FlagInner or not Value2 then
        local ToOrientation22 = ToOrientation2 + ( ( CamYaw2 - ToOrientation2 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * ( 1 - math.exp( -CombatTurnSpeed * Amount ) )
        HumanoidRootPart.CFrame = CFrame.new( HumanoidRootPart.Position ) * CFrame.Angles( 0, ToOrientation22, 0 )
    else
        if not Value4 or math.abs( ( Value4 - ToOrientation2 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) > 0.6 then
            Value4 = ToOrientation2
        end

        Value4 = Value4 + ( ( CamYaw2 - Value4 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * ( 1 - math.exp( -CombatTurnSpeed * Amount ) )
        Value2.CFrame = CFrame.Angles( 0, Value4, 0 )

        if Value2.MaxTorque ~= math.huge then
            Value2.MaxTorque = math.huge
            return
        end
    end

    return
end )
local Table2 = { }
local Table3 = { }
local Table4 = { }
local Folder = Instance.new( "Folder" )
Folder.Name = "LocalStepBlockers"
Folder.Parent = workspace
local Wait = WorldRefs.Wait( "Cars", 10 )

local function Track( Value )
    if Value:IsA( "BasePart" ) and Value.Parent and Value.Parent.Name == "WalkBoxes" then
        local Flag
        Table3[ Value ] = true

        local function Upd()
            local Flag = if Value:GetAttribute( "Step" ) == true then true else nil
            Table2[ Value ] = Flag
        end

        Flag = if Value:GetAttribute( "Step" ) == true then true else nil
        Table2[ Value ] = Flag
        Value:GetAttributeChangedSignal( "Step" ):Connect( Upd )
    end
end

local function Untrack( Key )
    Table2[ Key ] = nil
    Table3[ Key ] = nil

    if Table4[ Key ] then
        Table4[ Key ]:Destroy( )
        Table4[ Key ] = nil
    end
end

if Wait then
    for Key, Value in Wait:GetDescendants( ) do
        Track( Value )
    end

    Wait.DescendantAdded:Connect( Track )
    Wait.DescendantRemoving:Connect( Untrack )
end

local function UpdateBlockers( HumanoidRootPart, Y )
    local Value1
    local Coasting = ClientState.Coasting
    local Position = HumanoidRootPart.Position
    Value1 = nil

    for Value in Table3, nil, nil do
        local NotEntry2
        local NotEntry = not Table2[ Value ]

        if NotEntry then
            if ( Value.Position - Position ).Magnitude < 30 then
                if Value.Parent == nil then
                    NotEntry2 = false
                else
                    NotEntry2 = true
                end
            else
                NotEntry2 = false
            end
        else
            NotEntry2 = NotEntry
        end

        local Entry = Table4[ Value ]

        if NotEntry2 then
            local Entry2

            if Entry then
                Entry2 = Entry
            else
                local Part = Instance.new( "Part" )
                Part.Name = "StepBlocker"
                Part.Transparency = 1
                Part.Anchored = true
                Part.CanQuery = false
                Part.CanTouch = false
                Part.CollisionGroup = Value.CollisionGroup
                Part.Parent = Folder
                Table4[ Value ] = Part
                Entry2 = Part
            end

            local CanCollide
            Entry2.Size = Value.Size + Vector3.new( 0, 3, 0 )
            Entry2.CFrame = Value.CFrame * CFrame.new( 0, 1.5, 0 )

            if Y < Value.Position.Y + Value.Size.Y / 2 - 0.6 then
                local Coasting2 = if Coasting then Coasting[ Value.Parent.Parent ] else Coasting
                CanCollide = not Coasting2
            else
                CanCollide = false
            end

            Entry2.CanCollide = CanCollide
        elseif Entry then
            Entry:Destroy( )
            Table4[ Value ] = nil
        end
    end
end

local Value5 = nil
local Value6 = nil
local Value7 = nil
RunService.PreSimulation:Connect( function( Amount )
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local HumanoidRootPart

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 or Humanoid.SeatPart or Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
        local Value3
        Value5 = nil
        Value3 = nil

        for Key, Value4 in Table4, nil, nil do
            Value4.CanCollide = false
        end

        return
    end
    local HipHeight = Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2
    local Y = HumanoidRootPart.Position.Y - HipHeight
    UpdateBlockers( HumanoidRootPart, Y )

    if not Value5 then
        local State = Humanoid:GetState( )

        if State ~= Enum.HumanoidStateType.Running and State ~= Enum.HumanoidStateType.RunningNoPhysics then
            return
        end

        local MoveDirection = Humanoid.MoveDirection

        if MoveDirection.Magnitude < 0.1 then
            return
        end

        local Value1, Y3, Value2
        local X2 = MoveDirection.X
        local Unit = Vector3.new( X2, 0, MoveDirection.Z ).Unit
        local Position = HumanoidRootPart.Position
        local X3 = Position.X
        local Y2 = Y + 0.2
        local Vector32 = Vector3.new( X3, Y2, Position.Z ) + Unit * 1.6
        Value1 = nil
        Y3 = nil
        Value2 = nil

        for Value in Table2, nil, nil do
            if ( Value.Position - Position ).Magnitude < 25 and Value.Parent then
                local Size = Value.Size / 2
                local PointToObjectSpace = Value.CFrame:PointToObjectSpace( Vector32 )
                local PointToObjectSpace2 = Value.CFrame:PointToObjectSpace( Position )

                if math.abs( PointToObjectSpace.X ) <= Size.X and math.abs( PointToObjectSpace.Z ) <= Size.Z then
                    if not ( math.abs( PointToObjectSpace2.X ) <= Size.X ) or not ( math.abs( PointToObjectSpace2.Z ) <= Size.Z ) then
                        local Y5 = ( Value.CFrame * CFrame.new( PointToObjectSpace.X, Size.Y, PointToObjectSpace.Z ) ).Position.Y
                        local Y6 = Y5 - Y

                        if Y6 > 0.4 and Y6 <= 6 then
                            if not Y3 or Y3 < Y5 then
                                Y3 = Y5
                                Value2 = Value
                            end
                        end
                    end
                end
            end
        end
        if Y3 then
            local Y4 = Y3 + 0.05
            local Clock = os.clock( ) + 0.6
            Value5 = Y4
            Value6 = Value2
            Value7 = Clock
        end

        return
    end
    local Captured = Value5 - Y

    if Captured <= 0.08 or not Value6.Parent or Value7 < os.clock( ) then
        Value5 = nil
        Value6 = nil
        return
    end
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new( 0, math.min( Captured, 45 * Amount ), 0 )
    local X = AssemblyLinearVelocity.X
    HumanoidRootPart.AssemblyLinearVelocity = Vector3.new( X, 0, AssemblyLinearVelocity.Z )
    return
end )
local Table5 = {
    walk = "http://www.roblox.com/asset/?id=913402848",
    run = "rbxassetid://913376220"
}
local Value8 = nil

local function SetBaseLocomotion( Character, Flag )
    local Animate = Character:FindFirstChild( "Animate" )

    if not Animate then
        return
    end

    local Value1 = nil

    for Key, Value in Table5, nil, nil do
        local Animation
        local Parent = Animate:FindFirstChild( Key )

        if Parent then
            Animation = Parent:FindFirstChildOfClass( "Animation" )
        else
            Animation = Parent
        end

        local AnimationId = Flag and Value or "http://www.roblox.com/asset/?id=507766666"

        if Animation and Animation.AnimationId ~= AnimationId then
            local Clone = Animation:Clone( )
            Clone.AnimationId = AnimationId
            Animation.Parent = nil
            Clone.Parent = Parent
        end
    end
end

RunService.Heartbeat:Connect( function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid then
        return
    end

    local Flag

    if Humanoid.Health > 0 then
        if ClientState.Equipped then
            if ClientState.Aiming or ClientState.Combat then
                local NotCrouching = not ClientState.Crouching

                if NotCrouching then
                    local NotRolling = not ClientState.Rolling

                    if NotRolling then
                        Flag = not Humanoid.SeatPart
                    else
                        Flag = NotRolling
                    end
                else
                    Flag = NotCrouching
                end
            elseif ClientState.FistCombat == true or ClientState.MeleeAim == true or ClientState.MeleeSwing == true then
                local NotCrouching = not ClientState.Crouching

                if NotCrouching then
                    local NotRolling = not ClientState.Rolling

                    if NotRolling then
                        Flag = not Humanoid.SeatPart
                    else
                        Flag = NotRolling
                    end
                else
                    Flag = NotCrouching
                end
            else
                Flag = false
            end
        elseif ClientState.FistCombat == true or ClientState.MeleeAim == true or ClientState.MeleeSwing == true then
            local NotCrouching = not ClientState.Crouching

            if NotCrouching then
                local NotRolling = not ClientState.Rolling

                if NotRolling then
                    Flag = not Humanoid.SeatPart
                else
                    Flag = NotRolling
                end
            else
                Flag = NotCrouching
            end
        else
            Flag = false
        end
    else
        Flag = false
    end
    if Flag ~= Value8 then
        Value8 = Flag
        SetBaseLocomotion( Character, Flag )
    end
end )
RunService.PreAnimation:Connect( function()
    if not Value8 then
        return
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Animator

    if Humanoid then
        Animator = Humanoid:FindFirstChildOfClass( "Animator" )
    else
        Animator = Humanoid
    end

    local PlayingAnimationTracks = Animator and Animator:GetPlayingAnimationTracks( ) or { }
    local Value1 = nil

    for Key, Value in PlayingAnimationTracks, nil, nil do
        local Animation2
        local Animation = Value.Animation
        Animation2 = if Animation then Value.Animation.Name else Animation

        if Animation2 == "WalkAnim" or Animation2 == "RunAnim" then
            if math.abs( Value.Speed - 0.85 ) > 0.01 then
                Value:AdjustSpeed( 0.85 )
            end
        end
    end
end )
LocalPlayer.CharacterAdded:Connect( function()
    Value8 = nil
end )
