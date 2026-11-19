-- StarterPlayer.StarterPlayerScripts.RollClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local JumpGravity2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Config = require( Weapons:WaitForChild( "Config" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local Clips = require( Weapons:WaitForChild( "Clips" ) )
local Roll = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Roll" )
local Global = Config.Global
local RollTimeScale = Global.RollTimeScale or 1.35
local RollEnd = Global.RollEnd or 1.6
local RollBackStart = Global.RollBackStart or 1.2

local function Duration( Name )
    local Captured = string.sub( Name or "", 1, 1 ) == "B" and RollBackStart or RollEnd
    return Captured / RollTimeScale
end

local RollCooldown = Global.RollCooldown or 0.5
local RollDistance = Global.RollDistance or 1

local function RollSpeed( Text )
    local EDrinkUntil

    if Text then
        EDrinkUntil = Text:GetAttribute( "EDrinkUntil" )
    else
        EDrinkUntil = Text
    end

    local EDrinkRoll2

    if not EDrinkUntil or not ( workspace:GetServerTimeNow( ) < EDrinkUntil ) then
        EDrinkRoll2 = 1
    else
        local EDrinkRoll = Text:GetAttribute( "EDrinkRoll" )

        if EDrinkRoll then
            EDrinkRoll2 = EDrinkRoll
        else
            EDrinkRoll2 = 1
        end
    end

    local Tool

    if Text then
        Tool = Text:FindFirstChildOfClass( "Tool" )
    else
        Tool = Text
    end

    local Tool2 = if Tool then Tool:GetAttribute( "RollBoost" ) else Tool
    return EDrinkRoll2 * math.clamp( tonumber( Tool2 ) or 1, 1, 1.5 )
end

local LocalPlayer = Players.LocalPlayer
local Number = -math.huge
local Value1 = nil
local Value2 = nil
local Value3 = nil
local Number2 = 0
local Holds = require( Weapons:WaitForChild( "Holds" ) )

local function AimTwist()
    local Tool
    local Character = Players.LocalPlayer.Character

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Weapon
    local AimTwist = Holds.AimTwist
    Weapon = Tool and Tool:GetAttribute( "Weapon" ) or "M4A1"
    return AimTwist( Weapon )
end

local function AngleDiff( Argument1, Argument2 )
    return ( Argument2 - Argument1 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793
end

local Flag = false
local JumpCooldown = Global.JumpCooldown or 3
local Number3 = -math.huge
local JumpGravity = Global.JumpGravity
JumpGravity2 = if JumpGravity then JumpGravity else workspace.Gravity
local Value4 = nil

local function SetJumpForce( Parent, Flag )
    local Parent2

    if Parent then
        Parent2 = Parent:FindFirstChild( "HumanoidRootPart" )
    else
        Parent2 = Parent
    end
    if not Parent2 then
        return
    end
    if not Value4 or Value4.Parent ~= Parent2 then
        local Attachment0
        local RootAttachment = Parent2:FindFirstChild( "RootAttachment" )

        if RootAttachment then
            Attachment0 = RootAttachment
        else
            local Attachment = Instance.new( "Attachment" )
            Attachment.Name = "RootAttachment"
            Attachment.Parent = Parent2
            Attachment0 = Attachment
        end

        Value4 = Instance.new( "VectorForce" )
        Value4.Name = "SautLeger"
        Value4.Attachment0 = Attachment0
        Value4.RelativeTo = Enum.ActuatorRelativeTo.World
        Value4.ApplyAtCenterOfMass = true
        Value4.Force = Vector3.new( 0, 0, 0 )
        Value4.Enabled = true
        Value4.Parent = Parent2
    end

    local Force

    if Flag then
        local Vector32 = Vector3.new( 0, Parent2.AssemblyMass * math.max( 0, workspace.Gravity - JumpGravity2 ), 0 )

        if Vector32 then
            Force = Vector32
        else
            Force = Vector3.new( 0, 0, 0 )
        end
    else
        Force = Vector3.new( 0, 0, 0 )
    end
    if Value4.Force ~= Force then
        Value4.Force = Force
    end
    if not Value4.Enabled then
        Value4.Enabled = true
    end
end

local function RollVelocity( Parent )
    local RollVelocity = Parent:FindFirstChild( "RollVelocity" )

    if RollVelocity and RollVelocity:IsA( "LinearVelocity" ) then
        return RollVelocity
    end

    local Attachment0
    local RootAttachment = Parent:FindFirstChild( "RootAttachment" )
    Attachment0 = if RootAttachment then RootAttachment else Instance.new( "Attachment", Parent )
    local LinearVelocity = Instance.new( "LinearVelocity" )
    LinearVelocity.Name = "RollVelocity"
    LinearVelocity.Attachment0 = Attachment0
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis
    LinearVelocity.MaxAxesForce = Vector3.new( 0, 0, 0 )
    LinearVelocity.VectorVelocity = Vector3.new( 0, 0, 0 )
    LinearVelocity.Parent = Parent
    return LinearVelocity
end

local Table = {
    [ Enum.HumanoidStateType.Jumping ] = true,
    [ Enum.HumanoidStateType.Freefall ] = true
}

local function Grounded( Humanoid )
    local Flag = Humanoid.FloorMaterial ~= Enum.Material.Air and true or false
    return Flag
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
local Table2 = { Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Ragdoll }

local function SetFallStates( Argument1, Argument2 )
    if not Argument1 then
        return
    end

    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        Argument1:SetStateEnabled( Value, Argument2 )
    end
end

local function StopRoll()
    if Value1 then
        Value1.MaxAxesForce = Vector3.new( 0, 0, 0 )
        Value1.VectorVelocity = Vector3.new( 0, 0, 0 )
        Value1 = nil
    end
    if ClientState.Rolling then
        Number = os.clock( )
    end

    local Humanoid
    ClientState.Rolling = false
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid then
        return
    end

    local Value1Inner = nil

    for Key, Value in Table2, nil, nil do
        Humanoid:SetStateEnabled( Value, true )
    end
end

local function StartRoll()
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
    if Humanoid and HumanoidRootPart and not ( Humanoid.Health <= 0 ) then
        local Flag = Humanoid.FloorMaterial ~= Enum.Material.Air and true or false

        if Flag then
            if Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
                return
            end
            if Humanoid.SeatPart then
                return
            end
            if ClientState.Frozen then
                return
            end
            if HumanoidRootPart.Anchored then
                return
            end
            if Character:GetAttribute( "StaminaOut" ) then
                return
            end

            local Select
            local CamYaw = ClientState.CamYaw

            if CamYaw then
                Select = CamYaw
            else
                Select = select( 2, HumanoidRootPart.CFrame:ToOrientation( ) )
            end

            local RollMode, LookVector2, CamYaw2
            local Angles = CFrame.Angles( 0, Select, 0 )
            local LookVector = Angles.LookVector
            local RightVector = Angles.RightVector
            local MoveDirection = Humanoid.MoveDirection

            if MoveDirection.Magnitude > 0.1 then
                local Dot = MoveDirection:Dot( LookVector )
                local Round = math.round( math.atan2( MoveDirection:Dot( RightVector ), Dot ) / 0.7853981633974483 ) % 8
                RollMode = ( { [ 0 ] = "F", "FR", "R", "BR", "B", "BL", "L", "FL" } )[ Round ]
                local Round2 = Round * 3.141592653589793 / 4
                LookVector2 = LookVector * math.cos( Round2 ) + RightVector * math.sin( Round2 )

                if not ( Round >= 3 ) or not ( Round <= 5 ) then
                    CamYaw2 = Select - Round2
                else
                    CamYaw2 = Select - ( Round2 - 3.141592653589793 )
                end
            else
                LookVector2 = LookVector
                CamYaw2 = Select
                RollMode = "F"
            end

            local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
            local X = AssemblyLinearVelocity.X
            Number2 = math.max( 0, Vector3.new( X, 0, AssemblyLinearVelocity.Z ):Dot( LookVector2 ) )
            HumanoidRootPart.CFrame = CFrame.new( HumanoidRootPart.Position ) * CFrame.Angles( 0, CamYaw2, 0 )
            Value2 = LookVector2
            Value3 = CamYaw2

            if Humanoid then
                local Value1Inner = nil

                for Key, Value in Table2, nil, nil do
                    Humanoid:SetStateEnabled( Value, false )
                end
            end

            local RollStart = os.clock( )
            ClientState.Rolling = true
            ClientState.RollMode = RollMode
            ClientState.RollStart = RollStart
            ClientState.RollSpeed = RollSpeed( Character )
            Value1 = RollVelocity( HumanoidRootPart )
            Value1.VectorVelocity = LookVector2 * Number2
            Value1.MaxAxesForce = Vector3.new( 1000000, 0, 1000000 )
            Roll:FireServer( RollMode )
            return
        end
    end
end

local Controls = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Controls" ) )

local function TryRoll()
    if not ClientState.Equipped or not ClientState.Aiming or ClientState.Rolling then
        return
    end
    if os.clock( ) - Number < RollCooldown then
        return
    end
    StartRoll( )
    return
end

UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    if Argument2 or ClientState.Freecam or not Controls.Is( "Roll", Argument1 ) then
        return
    end
    if ClientState.Equipped and ClientState.Aiming then
        if ClientState.Rolling then
            return
        end
        if os.clock( ) - Number < RollCooldown then
            return
        end

        StartRoll( )
    end
end )
Controls.Pressed:Connect( function( Name, Argument2 )
    if Name == "Jump" and Argument2 and ClientState.Equipped and ClientState.Aiming then
        if ClientState.Rolling then
            return
        end
        if os.clock( ) - Number < RollCooldown then
            return
        end

        StartRoll( )
    end
end )
local Value5 = nil
local Flag2 = false

local function FindTouchJump()
    if Value5 and Value5.Parent then
        return Value5
    end

    local TouchGui
    Value5 = nil
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui then
        TouchGui = PlayerGui:FindFirstChild( "TouchGui" )
    else
        TouchGui = PlayerGui
    end

    local JumpButton

    if TouchGui then
        JumpButton = TouchGui:FindFirstChild( "JumpButton", true )
    else
        JumpButton = TouchGui
    end
    if not JumpButton or not JumpButton:IsA( "GuiButton" ) then
        return nil
    end
    Value5 = JumpButton
    JumpButton.InputBegan:Connect( function( Argument1 )
        if Argument1.UserInputType == Enum.UserInputType.Touch and Argument1.UserInputState == Enum.UserInputState.Begin and ClientState.Equipped and ClientState.Aiming then
            if ClientState.Rolling then
                return
            end
            if os.clock( ) - Number < RollCooldown then
                return
            end

            StartRoll( )
        end
    end )
    return JumpButton
end

local function TouchJumpWanted( Argument1 )
    if ClientState.MobileJump then
        return false
    end

    local TouchMode
    local Equipped = ClientState.Equipped

    if Equipped then
        local Aiming = ClientState.Aiming

        if Aiming then
            local NotSeatPart = not Argument1.SeatPart

            if NotSeatPart then
                local NotFrozen = not ClientState.Frozen

                if NotFrozen then
                    local NotNavFreeze = not ClientState.NavFreeze

                    if NotNavFreeze then
                        TouchMode = Controls.TouchMode( )
                    else
                        TouchMode = NotNavFreeze
                    end
                else
                    TouchMode = NotFrozen
                end
            else
                TouchMode = NotSeatPart
            end
        else
            TouchMode = Aiming
        end
    else
        TouchMode = Equipped
    end

    return TouchMode
end

RunService.RenderStepped:Connect( function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if Humanoid then
        local TouchMode

        if ClientState.MobileJump then
            TouchMode = false
        else
            local Equipped = ClientState.Equipped

            if Equipped then
                local Aiming = ClientState.Aiming

                if Aiming then
                    local NotSeatPart = not Humanoid.SeatPart

                    if NotSeatPart then
                        local NotFrozen = not ClientState.Frozen

                        if NotFrozen then
                            local NotNavFreeze = not ClientState.NavFreeze

                            if NotNavFreeze then
                                TouchMode = Controls.TouchMode( )
                            else
                                TouchMode = NotNavFreeze
                            end
                        else
                            TouchMode = NotFrozen
                        end
                    else
                        TouchMode = NotSeatPart
                    end
                else
                    TouchMode = Aiming
                end
            else
                TouchMode = Equipped
            end
        end
        if TouchMode then
            local FindTouchJump2 = FindTouchJump( )

            if FindTouchJump2 and not FindTouchJump2.Visible then
                FindTouchJump2.Visible = true
            end

            Flag2 = true
            return
        end
    end
end )
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

    local FlagInner
    local State = Humanoid:GetState( )

    if ClientState.Stamina == nil then
        FlagInner = false
    elseif ClientState.Stamina < ( ClientState.JumpCost or 0 ) then
        local NotSeatPart = not Humanoid.SeatPart

        if NotSeatPart then
            if State == Enum.HumanoidStateType.Swimming then
                FlagInner = false
            else
                FlagInner = true
            end
        else
            FlagInner = NotSeatPart
        end
    else
        FlagInner = false
    end

    local Aiming2

    if ClientState.Equipped then
        local Aiming = ClientState.Aiming

        if Aiming then
            Aiming2 = Aiming
        else
            local Rolling = ClientState.Rolling

            if Rolling then
                Aiming2 = Rolling
            else
                local JumpBusy = ClientState.JumpBusy

                if JumpBusy then
                    Aiming2 = JumpBusy
                elseif os.clock( ) - Number3 < JumpCooldown then
                    Aiming2 = true
                elseif FlagInner then
                    Aiming2 = FlagInner
                else
                    local NavFreeze = ClientState.NavFreeze

                    if NavFreeze then
                        Aiming2 = NavFreeze
                    elseif Character:FindFirstChild( "HumanoidRootPart" ) == nil then
                        Aiming2 = false
                    else
                        Aiming2 = Character.HumanoidRootPart.Anchored
                    end
                end
            end
        end
    else
        local Rolling = ClientState.Rolling

        if Rolling then
            Aiming2 = Rolling
        else
            local JumpBusy = ClientState.JumpBusy

            if JumpBusy then
                Aiming2 = JumpBusy
            elseif os.clock( ) - Number3 < JumpCooldown then
                Aiming2 = true
            elseif FlagInner then
                Aiming2 = FlagInner
            else
                local NavFreeze = ClientState.NavFreeze

                if NavFreeze then
                    Aiming2 = NavFreeze
                elseif Character:FindFirstChild( "HumanoidRootPart" ) == nil then
                    Aiming2 = false
                else
                    Aiming2 = Character.HumanoidRootPart.Anchored
                end
            end
        end
    end
    if Aiming2 ~= Flag then
        Flag = Aiming2
        Humanoid:SetStateEnabled( Enum.HumanoidStateType.Jumping, not Aiming2 )
    end
    if Flag2 then
        local TouchMode

        if ClientState.MobileJump then
            TouchMode = false
        else
            local Equipped = ClientState.Equipped

            if Equipped then
                local Aiming3 = ClientState.Aiming

                if Aiming3 then
                    local NotSeatPart2 = not Humanoid.SeatPart

                    if NotSeatPart2 then
                        local NotFrozen = not ClientState.Frozen

                        if NotFrozen then
                            local NotNavFreeze = not ClientState.NavFreeze

                            if NotNavFreeze then
                                TouchMode = Controls.TouchMode( )
                            else
                                TouchMode = NotNavFreeze
                            end
                        else
                            TouchMode = NotFrozen
                        end
                    else
                        TouchMode = NotSeatPart2
                    end
                else
                    TouchMode = Aiming3
                end
            else
                TouchMode = Equipped
            end
        end
        if not TouchMode then
            Flag2 = false
            local FindTouchJump2 = FindTouchJump( )

            if FindTouchJump2 then
                local Visible
                local NotSeatPart3 = not Humanoid.SeatPart

                if NotSeatPart3 then
                    if Humanoid.JumpHeight > 0 then
                        Visible = Humanoid:GetStateEnabled( Enum.HumanoidStateType.Jumping )
                    else
                        Visible = false
                    end
                else
                    Visible = NotSeatPart3
                end

                FindTouchJump2.Visible = Visible
            end
        end
    end
    if not ClientState.Rolling then
        return
    end

    local Captured
    local Clock = ( os.clock( ) - ClientState.RollStart ) * ( ClientState.RollSpeed or 1 )
    Captured = string.sub( ClientState.RollMode or "", 1, 1 ) == "B" and RollBackStart or RollEnd

    if Captured / RollTimeScale <= Clock or Humanoid.Health <= 0 or not Value1 or not Value1.Parent then
        if Value1 then
            Value1.MaxAxesForce = Vector3.new( 0, 0, 0 )
            Value1.VectorVelocity = Vector3.new( 0, 0, 0 )
            Value1 = nil
        end
        if ClientState.Rolling then
            Number = os.clock( )
        end

        local Humanoid2
        ClientState.Rolling = false
        local Character3 = LocalPlayer.Character

        if Character3 then
            Humanoid2 = Character3:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid2 = Character3
        end
        if not Humanoid2 then
            return
        end

        local Value2Inner = nil

        for Key, Value in Table2, nil, nil do
            Humanoid2:SetStateEnabled( Value, true )
        end

        return
    end
    local Captured2 = string.sub( ClientState.RollMode or "", 1, 1 ) == "B" and RollBackStart or RollEnd
    local Clock2 = ( Clock / ( Captured2 / RollTimeScale ) - 0.55 ) / 0.44999999999999996
    local HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )

    if Clock2 > 0 and HumanoidRootPart and Value3 then
        local CamYaw2
        local Min = math.min( Clock2, 1 )
        local Min2 = Min * Min * ( 3 - 2 * Min )
        local CamYaw = ClientState.CamYaw
        CamYaw2 = if CamYaw then CamYaw else Value3
        local Tool
        local Character2 = Players.LocalPlayer.Character

        if Character2 then
            Tool = Character2:FindFirstChildOfClass( "Tool" )
        else
            Tool = Character2
        end

        local Weapon
        local AimTwist = Holds.AimTwist
        Weapon = Tool and Tool:GetAttribute( "Weapon" ) or "M4A1"
        local CamYaw3 = CamYaw2 + AimTwist( Weapon )
        HumanoidRootPart.CFrame = CFrame.new( HumanoidRootPart.Position ) * CFrame.Angles( 0, Value3 + ( ( CamYaw3 - Value3 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * Min2, 0 )
    end

    local Captured4
    local Clock3 = Clock * RollTimeScale

    if string.sub( ClientState.RollMode, 1, 1 ) == "B" then
        local Captured3 = RollBackStart - Clock3

        if Captured3 then
            Captured4 = Captured3
        else
            Captured4 = Clock3
        end
    else
        Captured4 = Clock3
    end

    local VectorVelocity
    local Velocity = Clips.Velocity
    local Captured5 = Value2 * math.max( -Velocity( Clips.Roll, Captured4 ).Z * RollTimeScale * ( ClientState.RollSpeed or 1 ) * RollDistance, Number2, 0 )

    if not HumanoidRootPart or not ( Captured5.Magnitude > 0.01 ) then
        VectorVelocity = Captured5
    else
        RaycastParams2.FilterDescendantsInstances = {
            Character,
            workspace:FindFirstChild( "FX" ),
            workspace:FindFirstChild( "ClientHitboxes" )
        }
        local Position = HumanoidRootPart.Position
        local Spherecast = workspace:Spherecast( Position, 1.1, Value2 * ( Captured5.Magnitude * 0.1 + 0.4 ), RaycastParams2 )

        if Spherecast then
            local X = Spherecast.Normal.X
            local Vector32 = Vector3.new( X, 0, Spherecast.Normal.Z )

            if Vector32.Magnitude > 0.05 then
                local Unit = Vector32.Unit
                local Dot = Captured5:Dot( Unit )

                if Dot < 0 then
                    VectorVelocity = Captured5 - Unit * Dot
                else
                    VectorVelocity = Captured5
                end
            else
                VectorVelocity = Captured5
            end
        else
            VectorVelocity = Captured5
        end
    end

    Value1.VectorVelocity = VectorVelocity
    return
end )
local Value6 = nil

local function CancelRoll()
    if not ClientState.Rolling then
        return
    end

    ClientState.RollCancel = {
        mode = ClientState.RollMode,
        t = ( os.clock( ) - ClientState.RollStart ) * ( ClientState.RollSpeed or 1 ),
        at = os.clock( )
    }

    if Value1 then
        Value1.MaxAxesForce = Vector3.new( 0, 0, 0 )
        Value1.VectorVelocity = Vector3.new( 0, 0, 0 )
        Value1 = nil
    end
    if ClientState.Rolling then
        Number = os.clock( )
    end

    local Humanoid
    ClientState.Rolling = false
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if Humanoid then
        local Value1Inner = nil

        for Key, Value in Table2, nil, nil do
            Humanoid:SetStateEnabled( Value, true )
        end
    end

    Roll:FireServer( "cancel" )
end

local function OnCharacter( Parent )
    Value1 = nil
    ClientState.Rolling = false
    Value6 = nil
    Parent.ChildRemoved:Connect( function( Object )
        if Object:IsA( "Tool" ) and ClientState.Rolling then
            Value6 = ClientState.RollStart
        end
    end )
    Parent.ChildAdded:Connect( function( Object )
        if Object:IsA( "Tool" ) and ClientState.Rolling and Value6 == ClientState.RollStart then
            CancelRoll( )
        end
    end )
    Flag = false
    Number3 = -math.huge
    local Humanoid = Parent:WaitForChild( "Humanoid" )
    Value4 = nil
    local HumanoidRootPart = Parent:WaitForChild( "HumanoidRootPart", 10 )

    if HumanoidRootPart then
        SetJumpForce( Parent, false )
        RollVelocity( HumanoidRootPart )
    end

    Humanoid.StateChanged:Connect( function( Argument1, Key )
        if Key == Enum.HumanoidStateType.Jumping then
            local Flag
            Number3 = os.clock( )
            Flag = JumpGravity2 < workspace.Gravity and true or false
            SetJumpForce( Parent, Flag )
            return
        end
        if not Table[ Key ] then
            SetJumpForce( Parent, false )
        end

        return
    end )
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end
