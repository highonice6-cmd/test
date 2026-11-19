-- ReplicatedStorage.VehicleSystem.VehiclePhysics
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local Config = require( script.Parent.Config )

local function Lerp( Argument1, Argument2, Argument3 )
    return Argument1 + ( Argument2 - Argument1 ) * Argument3
end

local function MoveToward( Argument1, Argument2, Argument3 )
    if Argument1 < Argument2 then
        return ( math.min( Argument1 + Argument3, Argument2 ) )
    end
    return ( math.max( Argument1 - Argument3, Argument2 ) )
end

local Table2 = { 0, 0.75, -0.75 }
local Table = {
    newState = function( Object )
        local VehicleRoot = Object:FindFirstChild( "VehicleRoot" )
        local Get = Config.Get( Object:GetAttribute( "VehicleConfig" ) )

        if not VehicleRoot or not Get then
            return nil
        end

        local Table = {
            model = Object,
            root = VehicleRoot,
            cfg = Get,
            force = VehicleRoot:FindFirstChild( "VehicleForce" ),
            torque = VehicleRoot:FindFirstChild( "VehicleTorque" ),
            steer = 0,
            wheels = { },
            rayParams = RaycastParams.new( )
        }
        Table.rayParams.FilterType = Enum.RaycastFilterType.Exclude
        Table.rayParams.RespectCanCollide = true
        Table.rayParams.IgnoreWater = true

        for Index, Value in ipairs( Object:GetChildren( ) ) do
            if Value:GetAttribute( "VehicleWheel" ) then
                local Rim
                local Table2 = {
                    model = Value,
                    center = Value:GetAttribute( "Center" ),
                    radius = Value:GetAttribute( "Radius" ),
                    grounded = false,
                    load = 0,
                    spin = 0
                }
                local RimRadius = Value:GetAttribute( "RimRadius" )
                Rim = if RimRadius then RimRadius else Value:GetAttribute( "Radius" )
                local Flat
                Table2.rim = Rim
                Flat = Value:GetAttribute( "Flat" ) == true and true or false
                Table2.flat = Flat
                Table2.front = Value:GetAttribute( "Front" )
                Table2.left = Value:GetAttribute( "Left" )
                Table2.d = Get.TravelUp
                Table2.spinMotors = { }
                Table2.steerMotors = { }
                Table2.fixedMotors = { }

                for Index8, Value15 in ipairs( Value:GetDescendants( ) ) do
                    if Value15:IsA( "Motor6D" ) and Value15.Name == "VehicleJoint" then
                        local SpinMotors

                        if not Value15:GetAttribute( "Spin" ) or not Table2.spinMotors then
                            if not Value15:GetAttribute( "SteerOnly" ) or not Table2.fixedMotors then
                                SpinMotors = Table2.steerMotors
                            else
                                SpinMotors = Table2.fixedMotors
                            end
                        else
                            SpinMotors = Table2.spinMotors
                        end

                        local C03
                        table.insert( SpinMotors, Value15 )
                        local C02 = Table2.c0
                        C03 = if C02 then C02 else Value15.C0
                        Table2.c0 = C03
                    end
                end

                local C0inv
                local C0 = Table2.c0
                C0inv = if C0 then Table2.c0:Inverse( ) else C0
                Table2.c0inv = C0inv
                Value:GetAttributeChangedSignal( "Flat" ):Connect( function()
                    local Flat = Value:GetAttribute( "Flat" ) == true and true or false
                    Table2.flat = Flat
                end )
                table.insert( Table.wheels, Table2 )
            end
        end

        local Number, Number2, Number3, Number4
        Number = 0
        Number2 = 0
        Number3 = 0
        Number4 = 0

        for Index2, Value3 in ipairs( Table.wheels ) do
            if Value3.front then
                Number3 = Number3 + Value3.center.Z
                Number = Number + 1
            else
                Number2 = Number2 + 1
                Number4 = Number4 + Value3.center.Z
            end
        end

        local Wheelbase

        if not ( Number > 0 ) or not ( Number2 > 0 ) then
            Wheelbase = 10
        else
            local Abs = math.abs( Number3 / Number - Number4 / Number2 )

            if Abs then
                Wheelbase = Abs
            else
                Wheelbase = 10
            end
        end

        local Number5, Number6
        Table.wheelbase = Wheelbase
        Number5 = math.huge
        Number6 = -math.huge

        for Index3, Value5 in ipairs( Table.wheels ) do
            Number5 = math.min( Number5, Value5.center.X )
            Number6 = math.max( Number6, Value5.center.X )
        end

        local Track = Number5 < Number6 and Number6 - Number5 or 6
        Table.track = Track
        local SeatMotors = { }
        Table.bodyMotors = { }
        Table.seatMotors = SeatMotors

        for Index4, Value7 in ipairs( Object:GetDescendants( ) ) do
            if Value7:IsA( "Motor6D" ) and Value7.Name == "VehicleBody" then
                table.insert( Table.bodyMotors, Value7 )

                if Value7.Part1 then
                    if Value7.Part1:IsA( "Seat" ) or Value7.Part1:IsA( "VehicleSeat" ) then
                        table.insert( Table.seatMotors, Value7 )
                    end
                end
            end
        end

        local BodyReach
        Table.roll = 0
        Table.rollVel = 0
        Table.pitch = 0
        Table.pitchVel = 0
        Table.aLong = 0
        local VehicleHitbox = Object:FindFirstChild( "VehicleHitbox" )

        if VehicleHitbox then
            local X = VehicleHitbox.Size.X
            local Max = math.max( X, VehicleHitbox.Size.Y ) / 2 + 1

            if Max then
                BodyReach = Max
            else
                BodyReach = 5
            end
        else
            BodyReach = 5
        end

        local Number10, Number11
        Table.bodyReach = BodyReach
        Number10 = -math.huge
        Number11 = math.huge

        for Index5, Value9 in ipairs( Table.wheels ) do
            if Value9.front then
                Number10 = math.max( Number10, -Value9.center.Z )
            else
                Number11 = math.min( Number11, -Value9.center.Z )
            end
        end

        local Number7, Position, Number8, Position2
        Table.endParts = { }
        Number7 = 0
        Position = Vector3.new( 0, 0, 0 )
        Number8 = 0
        Position2 = Vector3.new( 0, 0, 0 )

        for Index6, Value11 in ipairs( Object:GetChildren( ) ) do
            if Value11:IsA( "BasePart" ) and Value11.Name:sub( 1, 17 ) == "VehicleCollision_" then
                local PointToObjectSpace = VehicleRoot.CFrame:PointToObjectSpace( Value11.Position )
                local Abs2 = math.abs( Value11.Size.Z ) / 2
                local Amount = -PointToObjectSpace.Z - Abs2

                if Number10 - 0.01 <= Amount then
                    table.insert( Table.endParts, Value11 )
                    Position = Position + PointToObjectSpace
                    Number7 = Number7 + 1
                elseif -PointToObjectSpace.Z + Abs2 <= Number11 + 0.01 then
                    table.insert( Table.endParts, Value11 )
                    Number8 = Number8 + 1
                    Position2 = Position2 + PointToObjectSpace
                end
            end
        end

        local NoseAt

        if not ( Number7 > 0 ) or not ( Position / Number7 ) then
            NoseAt = Vector3.new( 0, 0, -Table.wheelbase )
        else
            NoseAt = Position / Number7
        end

        local TailAt
        Table.noseAt = NoseAt

        if not ( Number8 > 0 ) or not ( Position2 / Number8 ) then
            TailAt = Vector3.new( 0, 0, Table.wheelbase )
        else
            TailAt = Position2 / Number8
        end

        Table.tailAt = TailAt
        Table.endsOff = false

        if Get.TwoWheels then
            local RollShape
            local WheelCount = math.max( #Table.wheels, 1 )
            local FrontCount = math.max( Number, 1 )
            local RearCount = math.max( Number2, 1 )
            Table.wheelCount = WheelCount
            Table.frontCount = FrontCount
            Table.rearCount = RearCount

            if VehicleHitbox then
                local X2 = ( VehicleHitbox.Size.X ^ 2 + VehicleHitbox.Size.Y ^ 2 ) / 12

                if X2 then
                    RollShape = X2
                else
                    RollShape = 2
                end
            else
                RollShape = 2
            end

            local Number9, WheeliePivot
            Table.rollShape = RollShape
            Number9 = math.huge
            WheeliePivot = Vector3.new( 0, 0, 0 )

            for Index7, Value13 in ipairs( Table.wheels ) do
                Number9 = math.min( Number9, Value13.center.Y - Value13.radius )

                if not Value13.front then
                    local Y = Value13.center.Y
                    WheeliePivot = Vector3.new( 0, Y, Value13.center.Z )
                end
            end

            local LeanPivot = ( not ( Number9 < math.huge ) or not Number9 ) and 0 or Number9
            Table.leanPivot = LeanPivot
            Table.wheeliePivot = WheeliePivot
            Table.lean = 0
            Table.leanVel = 0
            Table.wheelie = 0
            Table.wheelieVel = 0
        end

        return Table
    end,
    castWheels = function( Argument1 )
        local FilterAt = os.clock( )

        if not Argument1.filterAt or FilterAt - Argument1.filterAt > 0.5 then
            Argument1.filterAt = FilterAt
            local FilterDescendantsInstances = { Argument1.model }

            for Index, Value in ipairs( Players:GetPlayers( ) ) do
                if Value.Character then
                    table.insert( FilterDescendantsInstances, Value.Character )
                end
            end

            Argument1.rayParams.FilterDescendantsInstances = FilterDescendantsInstances
        end

        local Cfg = Argument1.cfg
        local CFrame = Argument1.root.CFrame
        local UpVector = CFrame.UpVector
        local LookVector = CFrame.LookVector

        for Index2, Value3 in ipairs( Argument1.wheels ) do
            local Rim2
            local Origin = CFrame:PointToWorldSpace( Value3.center + Vector3.new( 0, Cfg.TravelUp, 0 ) )
            Rim2 = Value3.flat and Value3.rim or Value3.radius
            local Raycast, Total
            Raycast = nil
            Total = nil

            for Index3, Value5 in ipairs( Table2 ) do
                local Rim = Value5 * Rim2
                local Sqrt = math.sqrt( Rim2 * Rim2 - Rim * Rim )
                local Raycast2 = workspace:Raycast( Origin + LookVector * Rim, -UpVector * ( Cfg.TravelUp + Cfg.TravelDown + Sqrt ), Argument1.rayParams )

                if Raycast2 then
                    if not Total or Raycast2.Distance - Sqrt < Total then
                        Raycast = Raycast2
                        Total = Raycast2.Distance - Sqrt
                    end
                end
            end

            Value3.origin = Origin

            if Raycast then
                Value3.grounded = true
                Value3.d = math.max( Total, 0 )
                Value3.contact = Raycast.Position
                Value3.normal = Raycast.Normal
            else
                Value3.grounded = false
                Value3.d = Cfg.TravelUp + Cfg.TravelDown
            end
        end
    end
}
function Table.step( Argument1, Argument2, Argument3 )
    local Storage = { }
    local Cfg = Argument1.cfg
    local Root = Argument1.root

    if not Root.Parent or not Argument1.force or not Argument1.torque then
        return
    end
    if Root.Anchored or not ( Root.AssemblyMass < math.huge ) then
        Argument1.force.Force = Vector3.new( 0, 0, 0 )
        Argument1.torque.Torque = Vector3.new( 0, 0, 0 )
        return
    end

    local Number3
    Table.castWheels( Argument1 )
    local CFrame2 = Root.CFrame
    local UpVector = CFrame2.UpVector
    local LookVector = CFrame2.LookVector
    local AssemblyMass = Root.AssemblyMass
    local AssemblyCenterOfMass = Root.AssemblyCenterOfMass
    local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
    local Dot = AssemblyLinearVelocity:Dot( LookVector )
    local Clamp = math.clamp( math.abs( Dot ) / Cfg.TopSpeed, 0, 1 )
    local MaxSteer = Cfg.MaxSteer
    local MinSteer = Cfg.MinSteer
    local Clamp2 = Clamp ^ Cfg.SteerCurve
    local Rad = math.rad( MaxSteer + ( MinSteer - MaxSteer ) * Clamp2 )

    if Argument3.Parked then
        Number3 = 0
    else
        Number3 = 0

        for Index, Value in ipairs( Argument1.wheels ) do
            if Value.flat then
                local Number = not Value.left and -1 or 1
                local Number2 = not Value.front and 0.5 or 1
                Number3 = Number3 + Number * Number2
            end
        end
    end

    local Flag
    local Amount = -Argument3.Steer * Rad + math.rad( Cfg.FlatPull ) * Number3
    local Abs = math.abs( Amount )

    if math.abs( Argument1.steer ) < Abs then
        if Amount * Argument1.steer >= 0 then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    local SteerSpeed = Flag and Cfg.SteerSpeed or Cfg.SteerReturnSpeed
    local Rad2

    if not Cfg.TwoWheels or not Rad then
        Rad2 = math.rad( Cfg.MaxSteer )
    else
        Rad2 = Rad
    end

    local Steer2
    local Steer = Argument1.steer
    local Rad3 = Rad2 * SteerSpeed * Argument2

    if Steer < Amount then
        Steer2 = math.min( Steer + Rad3, Amount )
    else
        Steer2 = math.max( Steer - Rad3, Amount )
    end

    local Number5
    Argument1.steer = Steer2
    local WheelCount = Argument1.wheelCount or 4
    local AssemblyMass2 = AssemblyMass * workspace.Gravity / WheelCount / Cfg.StaticCompression
    local Damping = 2 * Cfg.Damping * math.sqrt( AssemblyMass2 * AssemblyMass / WheelCount )
    local TravelUp = Cfg.TravelUp + Cfg.StaticCompression
    local AssemblyMass3 = AssemblyMass / WheelCount
    local Model = Argument1.model
    local BrakeDecel = Cfg.BrakeDecel

    if Model then
        local Number4 = tonumber( Model:GetAttribute( "PerfBrake" ) )

        if Number4 then
            Number5 = Number4
        else
            Number5 = 1
        end
    else
        Number5 = 1
    end

    local Number7
    local BrakeDecel2 = BrakeDecel * Number5
    local GripAccel = Cfg.GripAccel

    if Model then
        local Number6 = tonumber( Model:GetAttribute( "PerfGrip" ) )

        if Number6 then
            Number7 = Number6
        else
            Number7 = 1
        end
    else
        Number7 = 1
    end

    local Number8, Number10
    local GripAccel2 = GripAccel * Number7
    local GripAccel3 = GripAccel2 / workspace.Gravity
    Number8 = 0
    Number10 = 0

    for Index2, Value3 in ipairs( Argument1.wheels ) do
        Storage.FlatGrip2 = Value3.flat and Cfg.FlatGrip or 1
        Number8 = Number8 + Storage.FlatGrip2
        Storage.Number19 = not Value3.flat and 0 or 1
        Number10 = Number10 + Storage.Number19
    end

    local Flag2
    local Number9 = Number8 / math.max( #Argument1.wheels, 1 )

    if Number10 > 0 then
        if Number10 == #Argument1.wheels then
            Flag2 = true
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end
    if Flag2 then
        Number9 = Cfg.AllFlatAssist
    end

    local Max = math.max( Argument2, 0.004166666666666667 )
    local Min = math.min( 1, 0.8 / ( math.sqrt( workspace.Gravity / Cfg.StaticCompression ) * Max ) )
    local AssemblyMass4 = AssemblyMass2 * ( Min * Min )
    local Damping2 = Damping * Min
    local AssemblyMass5 = AssemblyMass * workspace.Gravity
    local LateralResponse = Cfg.LateralResponse
    local Max2 = math.max( LateralResponse, Max * 2.5 )
    local Max3 = math.max( Max * 2, 0.03333333333333333 )
    local TableInner = { }

    for Index3, Value5 in ipairs( Argument1.wheels ) do

        if Value5.grounded then
            Storage.TravelUp3 = TravelUp - Value5.d

            if Storage.TravelUp3 then
                Storage.TravelUp4 = Storage.TravelUp3
            else
                Storage.TravelUp4 = 0
            end
        else
            Storage.TravelUp4 = 0
        end

        TableInner[ Index3 ] = Storage.TravelUp4
    end

    local Flag4 = if Argument3.Burn == true then not Argument3.Parked else false
    local Flag3

    if Argument3.Pushed == true then
        Flag3 = true
    else
        Flag3 = false
    end
    if Flag3 then
        local Magnitude = AssemblyLinearVelocity.Magnitude

        if Cfg.PushSlowSpeed < Magnitude then
            Argument1.pushSlow = 0
        elseif Magnitude > 0.3 then
            Argument1.pushSlow = ( Argument1.pushSlow or 0 ) + Argument2
        else
            Argument1.pushSlow = math.max( ( Argument1.pushSlow or 0 ) - Argument2, 0 )
        end
        if Argument1.pushSlow <= Cfg.PushLockTime then
            Flag3 = true
        else
            Flag3 = false
        end
    else
        Argument1.pushSlow = 0
    end

    local Flag5

    if Flag3 then
        if AssemblyLinearVelocity.Magnitude > 1 then
            Flag5 = true
        else
            Flag5 = false
        end
    else
        Flag5 = Flag3
    end
    local NotFlag = not Flag4

    if NotFlag then
        if not Argument3.Parked or not not Flag5 then
            if math.abs( Argument3.Throttle ) < 0.05 then
                if math.abs( Dot ) < 2 then
                    Storage.NotFlag2 = true
                else
                    Storage.NotFlag2 = false
                end
            else
                Storage.NotFlag2 = false
            end
        else
            Storage.NotFlag2 = not Flag5
        end
    else
        Storage.NotFlag2 = NotFlag
    end
    local Steer3 = Argument1.steer / math.rad( Cfg.MaxSteer )

    if Flag4 then
        if math.abs( Steer3 ) > 0.15 then
            Storage.Flag14 = true
        else
            Storage.Flag14 = false
        end
    else
        Storage.Flag14 = Flag4
    end

    if Flag4 then
        local Number11, Position
        Number11 = 0
        Position = Vector3.new( 0, 0, 0 )

        for Index4, Value7 in ipairs( Argument1.wheels ) do
            if Value7.front then
                Number11 = Number11 + 1
                Position = Position + Value7.origin
            end
        end
        if Number11 > 0 then
            local Position2 = Position / Number11
            local VelocityAtPosition = Root:GetVelocityAtPosition( Position2 )
            Storage.Position8 = Position2
            Storage.VelocityAtPosition3 = VelocityAtPosition - UpVector * VelocityAtPosition:Dot( UpVector )
        else
            Storage.Position8 = nil
            Storage.VelocityAtPosition3 = nil
        end
    else
        Storage.Position8 = nil
        Storage.VelocityAtPosition3 = nil
    end

    local Clamp3

    if Flag4 then
        Clamp3 = 0
    else
        Clamp3 = math.clamp( Argument3.LaunchSlip or 0, 0, 1 )
    end

    local Grounded, Number12, Number13
    local Vector32 = Vector3.new( 0, -workspace.Gravity, 0 )
    local Position3 = Vector3.new( 0, 0, 0 )
    local Position4 = Vector3.new( 0, 0, 0 )

    local function Apply( Argument1, Argument2 )
        Position3 = Position3 + Argument1
        Position4 = Position4 + ( Argument2 - AssemblyCenterOfMass ):Cross( Argument1 )
    end

    Grounded = 0
    Number12 = 0
    Number13 = 0

    for Index5, Value9 in ipairs( Argument1.wheels ) do
        if Value9.grounded then

            if Cfg.SpringTiltFrom then
                Storage.Clamp9 = math.clamp( ( UpVector:Dot( Value9.normal ) - Cfg.SpringTiltTo ) / ( Cfg.SpringTiltFrom - Cfg.SpringTiltTo ), 0, 1 )

                if Storage.Clamp9 <= 0 then
                    Value9.grounded = false
                    continue
                end
                Storage.Number17 = Storage.Clamp9
            else
                Storage.Number17 = 1
            end

            if Storage.Number17 < 1 then
                Storage.Unit4 = Value9.normal:Lerp( UpVector, Storage.Number17 ).Unit
            else
                Storage.Unit4 = UpVector
            end

            Grounded = Grounded + 1
            Storage.Dot9 = Root:GetVelocityAtPosition( Value9.origin ):Dot( UpVector )

            if Storage.Dot9 < -( Cfg.LandingSpeed or math.huge ) then
                Value9.landing = Cfg.LandingTime
            elseif Value9.landing then
                Value9.landing = Value9.landing - Argument2

                if Value9.landing <= 0 then
                    Value9.landing = nil
                end
            end

            Storage.Flag15 = Value9.landing ~= nil and true or false
            Storage.AssemblyMass12 = AssemblyMass2 * Cfg.StaticCompression
            Storage.TravelUp2 = TravelUp - Value9.d
            Storage.AssemblyMass13 = Storage.AssemblyMass12 + AssemblyMass4 * ( Storage.TravelUp2 - Cfg.StaticCompression ) - Damping2 * Storage.Dot9

            for Index9, Value19 in ipairs( Argument1.wheels ) do
                if Index9 ~= Index5 and Value19.front == Value9.front and Value19.left ~= Value9.left then
                    Storage.AssemblyMass13 = Storage.AssemblyMass13 + ( TableInner[ Index5 ] - TableInner[ Index9 ] ) * AssemblyMass4 * Cfg.AntiRoll
                end
            end
            Storage.Clamp10 = math.clamp( Storage.AssemblyMass13, 0, AssemblyMass5 ) * Storage.Number17
            Storage.Unit5 = Storage.Unit4 * Storage.Clamp10
            Storage.Origin = Value9.origin
            Position3 = Position3 + Storage.Unit5
            Position4 = Position4 + ( Storage.Origin - AssemblyCenterOfMass ):Cross( Storage.Unit5 )

            if Storage.Flag15 then
                Storage.AssemblyMass14 = Storage.AssemblyMass12 + AssemblyMass4 * ( Storage.TravelUp2 - Cfg.StaticCompression ) - Damping2 * Cfg.LandingDamping * Storage.Dot9

                for Index10, Value21 in ipairs( Argument1.wheels ) do
                    if Index10 ~= Index5 and Value21.front == Value9.front and Value21.left ~= Value9.left then
                        Storage.AssemblyMass14 = Storage.AssemblyMass14 + ( TableInner[ Index5 ] - TableInner[ Index10 ] ) * AssemblyMass4 * Cfg.AntiRoll
                    end
                end

                Storage.Clamp11 = math.clamp( Storage.AssemblyMass14, 0, AssemblyMass5 * Cfg.LandingSpringCap ) * Storage.Number17 - Storage.Clamp10

                if Storage.Clamp11 > 0 then
                    Position3 = Position3 + Storage.Unit4 * Storage.Clamp11
                    Storage.Load = Storage.Clamp10 + Storage.Clamp11
                else
                    Storage.Load = Storage.Clamp10
                end
            else
                Storage.Load = Storage.Clamp10
            end
            Value9.load = Storage.Load
            Storage.Normal = Value9.normal
            Storage.SlopeNeutral = Cfg.SlopeNeutral

            if Storage.SlopeNeutral then
                if UpVector.Y > 0.5 then
                    if Storage.Normal.Y > 0.5 then
                        Storage.SlopeNeutral2 = true
                    else
                        Storage.SlopeNeutral2 = false
                    end
                else
                    Storage.SlopeNeutral2 = false
                end
            else
                Storage.SlopeNeutral2 = Storage.SlopeNeutral
            end
            if Storage.SlopeNeutral2 then
                Storage.Vector35 = Vector32 * AssemblyMass3
                Position3 = Position3 - ( Storage.Vector35 - UpVector * Storage.Vector35:Dot( UpVector ) )
            end

            if Value9.front then
                Storage.VectorToWorldSpace = CFrame.fromAxisAngle( UpVector, Argument1.steer ):VectorToWorldSpace( LookVector )

                if Storage.VectorToWorldSpace then
                    Storage.VectorToWorldSpace2 = Storage.VectorToWorldSpace
                else
                    Storage.VectorToWorldSpace2 = LookVector
                end
            else
                Storage.VectorToWorldSpace2 = LookVector
            end

            Storage.VectorToWorldSpace3 = Storage.VectorToWorldSpace2 - Storage.Normal * Storage.VectorToWorldSpace2:Dot( Storage.Normal )

            if not ( Storage.VectorToWorldSpace3.Magnitude < 0.001 ) then
                Storage.Unit6 = Storage.VectorToWorldSpace3.Unit
                Storage.Cross = Storage.Unit6:Cross( Storage.Normal )
                Storage.VelocityAtPosition2 = Root:GetVelocityAtPosition( Value9.contact )
                Storage.Dot10 = Storage.VelocityAtPosition2:Dot( Storage.Unit6 )
                Storage.Dot11 = Storage.VelocityAtPosition2:Dot( Storage.Cross )

                if Storage.VelocityAtPosition3 and Value9.front then
                    Storage.Dot10 = Storage.VelocityAtPosition3:Dot( Storage.Unit6 )
                    Storage.Dot11 = Storage.VelocityAtPosition3:Dot( Storage.Cross )
                end
                Storage.NotFront = not Value9.front
                Storage.Handbrake = Argument3.Handbrake

                if Storage.Handbrake then
                    if Storage.NotFront then
                        Storage.Handbrake2 = not Argument3.Parked
                    else
                        Storage.Handbrake2 = Storage.NotFront
                    end
                else
                    Storage.Handbrake2 = Storage.Handbrake
                end

                if not Value9.flat or not Cfg.FlatGrip then
                    Storage.FlatGrip = 1
                else
                    Storage.FlatGrip = Cfg.FlatGrip
                end
                if Flag2 then
                    Storage.AllFlatGripFront = Value9.front and Cfg.AllFlatGripFront or Cfg.AllFlatGripRear
                    Storage.FlatGrip = Storage.AllFlatGripFront
                end
                Storage.GripAccel5 = GripAccel3 * Storage.Load * Storage.FlatGrip
                Storage.Amount10 = -Storage.Dot11 * AssemblyMass3 / Max2
                Storage.DriveFront = Value9.front and Cfg.DriveFront or 1 - Cfg.DriveFront

                if Value9.front then
                    Storage.FrontCount = Argument1.frontCount

                    if Storage.FrontCount then
                        Storage.FrontCount2 = Storage.FrontCount
                    else
                        Storage.FrontCount2 = 2
                    end
                else
                    Storage.FrontCount2 = Argument1.rearCount or 2
                end
                Storage.DriveFront2 = Storage.DriveFront / Storage.FrontCount2
                Storage.Throttle2 = Argument3.Throttle
                Storage.Throttle3 = if not Argument3.Handbrake or not ( Storage.Throttle2 > 0 ) then Storage.Throttle2 else 0

                if not Argument3.Parked or not Flag3 then
                    if Argument3.Parked then
                        Storage.Amount12 = -Storage.Dot10 * AssemblyMass3 / Max3
                    elseif Flag4 then
                        Storage.Number18 = if Storage.NotFront then 0 else -Storage.Dot10 * AssemblyMass3 / Max3
                        Storage.Amount12 = Storage.Number18
                    elseif Storage.Handbrake2 then
                        Storage.Amount13 = -math.sign( Storage.Dot10 )
                        Storage.AssemblyMass16 = AssemblyMass * Cfg.HandbrakeDecel / ( Argument1.rearCount or 2 )
                        Storage.Amount12 = Storage.Amount13 * math.min( Storage.AssemblyMass16, math.abs( Storage.Dot10 ) * AssemblyMass3 / Max3 )
                    elseif Storage.Throttle3 > 0.05 then
                        if Dot < -1.5 then
                            Storage.Amount12 = -math.sign( Storage.Dot10 ) * AssemblyMass * BrakeDecel2 / WheelCount * Storage.Throttle3
                        else

                            if Argument3.DriveAccel then
                                Storage.Throttle4 = Storage.Throttle3 * AssemblyMass * Argument3.DriveAccel * Storage.DriveFront2
                            else
                                Storage.Max6 = math.max( 0, 1 - ( math.max( Dot, 0 ) / Cfg.TopSpeed ) ^ 2 )
                                Storage.Throttle4 = Storage.Throttle3 * AssemblyMass * Cfg.Acceleration * Storage.Max6 * Storage.DriveFront2
                            end

                            Storage.Amount12 = Storage.Throttle4 * ( 1 - Clamp3 * ( 1 - Cfg.BurnSlipDrive ) )
                        end
                    elseif Storage.Throttle3 < -0.05 then
                        if Dot > 1.5 then
                            Storage.Amount12 = math.sign( Storage.Dot10 ) * AssemblyMass * BrakeDecel2 / WheelCount * Storage.Throttle3
                        else
                            Storage.Max7 = math.max( 0, 1 - ( math.max( -Dot, 0 ) / Cfg.ReverseSpeed ) ^ 2 )
                            Storage.Amount12 = Storage.Throttle3 * AssemblyMass * Cfg.ReverseAcceleration * Storage.Max7 * Storage.DriveFront2
                        end
                    else
                        Storage.Amount12 = -Storage.Dot10 * AssemblyMass3 * Cfg.RollingResistance
                    end
                else
                    Storage.PushedBrake = Cfg.PushedBrake + Cfg.PushedBrakePerSpeed * math.abs( Dot )
                    Storage.Amount11 = -math.sign( Storage.Dot10 )
                    Storage.AssemblyMass15 = AssemblyMass * Storage.PushedBrake / WheelCount
                    Storage.Amount12 = Storage.Amount11 * math.min( Storage.AssemblyMass15, math.abs( Storage.Dot10 ) * AssemblyMass3 / Max3 )
                end
                if Value9.flat and not Argument3.Parked then
                    Storage.Amount12 = Storage.Amount12 - Storage.Dot10 * AssemblyMass3 * Cfg.FlatDrag
                end

                if Storage.NotFlag2 then
                    if not Argument3.Parked then
                        Storage.Amount12 = -Storage.Dot10 * AssemblyMass3 / Max3
                    end
                    Storage.Unit7 = Storage.Unit4 * Storage.Load
                    Storage.Position7 = if Storage.SlopeNeutral2 then Vector3.new( 0, 0, 0 ) else Vector32 * AssemblyMass3
                    Storage.Unit8 = Storage.Unit7 + Storage.Position7
                    Storage.Unit9 = Storage.Unit8 - UpVector * Storage.Unit8:Dot( UpVector )
                    Storage.Amount12 = Storage.Amount12 - Storage.Unit9:Dot( Storage.Unit6 )
                    Storage.Amount14 = Storage.Amount10 - Storage.Unit9:Dot( Storage.Cross )
                else
                    Storage.Amount14 = Storage.Amount10
                end
                if Flag2 and not Storage.NotFlag2 then
                    Storage.GripAccel6 = Storage.GripAccel5 * Cfg.AllFlatTraction
                    Storage.Amount12 = math.clamp( Storage.Amount12, -Storage.GripAccel6, Storage.GripAccel6 )
                end
                if Flag5 then
                    Storage.GripAccel7 = Storage.GripAccel5 * Cfg.PushedSideGrip
                    Storage.Amount14 = math.clamp( Storage.Amount14, -Storage.GripAccel7, Storage.GripAccel7 )
                end
                if not Flag4 or not Storage.NotFront then
                    if Clamp3 > 0 and Storage.NotFront then
                        Storage.GripAccel8 = Storage.GripAccel5 * ( 1 - Clamp3 * ( 1 - Cfg.BurnSlipRearGrip ) )
                        Storage.Amount14 = math.clamp( Storage.Amount14, -Storage.GripAccel8, Storage.GripAccel8 )
                    end
                else
                    Storage.Amount14 = 0
                end
                if Storage.Handbrake2 then
                    Storage.GripAccel9 = Storage.GripAccel5 * Cfg.HandbrakeGrip
                    Storage.Clamp12 = math.clamp( Storage.Amount14, -Storage.GripAccel9, Storage.GripAccel9 )
                    Storage.Sqrt = math.sqrt( ( math.max( Storage.GripAccel5 * Storage.GripAccel5 - Storage.Clamp12 * Storage.Clamp12, 0 ) ) )
                    Storage.Amount12 = math.clamp( Storage.Amount12, -Storage.Sqrt, Storage.Sqrt )
                    Storage.Amount14 = Storage.Clamp12
                else
                    Storage.Sqrt2 = math.sqrt( Storage.Amount14 * Storage.Amount14 + Storage.Amount12 * Storage.Amount12 )

                    if Storage.GripAccel5 < Storage.Sqrt2 and Storage.Sqrt2 > 0 then
                        Storage.GripAccel10 = Storage.GripAccel5 / Storage.Sqrt2

                        if Storage.Throttle3 > 0.05 and Storage.Amount12 > 0 then
                            Number13 = Number13 + Storage.Amount12 * ( 1 - Storage.GripAccel10 )
                        end

                        Storage.Amount12 = Storage.Amount12 * Storage.GripAccel10
                        Storage.Amount14 = Storage.Amount14 * Storage.GripAccel10
                    end
                end

                Storage.Contact = Value9.contact + UpVector * ( ( AssemblyCenterOfMass - Value9.contact ):Dot( UpVector ) * Cfg.RollStability )
                Storage.Unit10 = Storage.Unit6 * Storage.Amount12 + Storage.Cross * Storage.Amount14
                Position3 = Position3 + Storage.Unit10
                Position4 = Position4 + ( Storage.Contact - AssemblyCenterOfMass ):Cross( Storage.Unit10 )
                Number12 = Number12 + math.min( ( Storage.Cross * Storage.Amount14 ):Dot( LookVector ), 0 )
            end
        end
    end
    if not Flag4 or not ( Grounded > 0 ) then
        if Grounded > 0 and math.abs( Dot ) > 5 then
            local HandbrakeAssist
            local Dot3 = Root.AssemblyAngularVelocity:Dot( UpVector )
            local GripAccel4 = ( GripAccel2 + ( Cfg.ArcadeTractionMax or 0 ) ) * Number9 * 1.05 / math.abs( Dot )
            local Dot4 = Dot * math.tan( Argument1.steer ) / Argument1.wheelbase
            local Clamp4 = math.clamp( Dot4, -GripAccel4, GripAccel4 )
            local AssemblyMass8 = AssemblyMass * ( Argument1.wheelbase ^ 2 + Argument1.track ^ 2 ) / 12 * 1.5
            local StabilityAssist = Cfg.StabilityAssist
            HandbrakeAssist = Argument3.Handbrake and Cfg.HandbrakeAssist or 1
            local AllFlatAssist
            local StabilityAssist2 = StabilityAssist * HandbrakeAssist
            AllFlatAssist = Flag2 and Cfg.AllFlatAssist or 1
            local StabilityAssist3 = StabilityAssist2 * AllFlatAssist
            Position4 = Position4 + -UpVector * ( Dot3 - Clamp4 ) * AssemblyMass8 * math.min( StabilityAssist3, 0.8 / Max )

            if Flag2 then
                local Phase2
                local Phase = Argument1.phase
                Phase2 = if Phase then Phase else math.random( ) * 100
                Argument1.phase = Phase2
                local Clock = os.clock( ) + Argument1.phase
                Position4 = Position4 + UpVector * ( math.sin( Clock * 1.7 ) * 0.6 + math.sin( Clock * 2.9 + Argument1.phase ) * 0.4 ) * Cfg.AllFlatWobble * math.min( math.abs( Dot ) / 20, 1 ) * AssemblyMass8
            end
        end
    else
        local Flag6
        local Dot2 = Root.AssemblyAngularVelocity:Dot( UpVector )

        if Storage.Flag14 then
            Flag6 = Storage.Flag14
        elseif math.abs( Dot2 ) > 0.2 then
            Flag6 = true
        else
            Flag6 = false
        end

        local Steer5
        local AssemblyMass6 = AssemblyMass * ( Argument1.wheelbase ^ 2 + Argument1.track ^ 2 ) / 12 * 1.5

        if Storage.Flag14 then
            local Steer4 = Steer3 * Cfg.BurnDonutYaw

            if Steer4 then
                Steer5 = Steer4
            else
                Steer5 = 0
            end
        else
            Steer5 = 0
        end

        local BurnYawResponse = Flag6 and Cfg.BurnYawResponse or Cfg.BurnYawHoldResponse
        Position4 = Position4 + -UpVector * ( Dot2 - Steer5 ) * AssemblyMass6 * math.min( BurnYawResponse, 0.8 / Max )

        if Storage.Position8 then
            local BurnPivotResponse
            local AssemblyCenterOfMass2 = AssemblyCenterOfMass - Storage.Position8
            local AssemblyCenterOfMass3 = AssemblyCenterOfMass2 - UpVector * AssemblyCenterOfMass2:Dot( UpVector )
            BurnPivotResponse = Flag6 and Cfg.BurnPivotResponse or Cfg.BurnHoldResponse
            local Amount3
            local Amount2 = -AssemblyCenterOfMass3 * Dot2 * Dot2 * AssemblyMass - Storage.VelocityAtPosition3 * AssemblyMass * math.min( BurnPivotResponse, 0.8 / Max )
            local AssemblyMass7 = AssemblyMass * GripAccel2
            Amount3 = if AssemblyMass7 < Amount2.Magnitude then Amount2.Unit * AssemblyMass7 else Amount2
            Position3 = Position3 + Amount3
        else
            local Amount4 = -( AssemblyLinearVelocity - UpVector * AssemblyLinearVelocity:Dot( UpVector ) ) * AssemblyMass
            local BurnHoldResponse = Cfg.BurnHoldResponse
            Position3 = Position3 + Amount4 * math.min( BurnHoldResponse, 0.8 / Max )
        end
    end
    if Dot > 2 and Argument3.Throttle > -0.05 and not Flag4 then
        local CornerHandbrakeKeep2

        if Argument3.Handbrake then
            local CornerHandbrakeKeep = Cfg.CornerHandbrakeKeep

            if CornerHandbrakeKeep then
                CornerHandbrakeKeep2 = CornerHandbrakeKeep
            else
                CornerHandbrakeKeep2 = 0
            end
        elseif Argument3.Throttle > 0.05 then
            local CornerSpeedKeep = ( Cfg.CornerSpeedKeep or 0 ) * Argument3.Throttle

            if CornerSpeedKeep then
                CornerHandbrakeKeep2 = CornerSpeedKeep
            else
                CornerHandbrakeKeep2 = Cfg.CornerCoastKeep or 0
            end
        else
            CornerHandbrakeKeep2 = Cfg.CornerCoastKeep or 0
        end

        Position3 = Position3 + LookVector * ( -Number12 * CornerHandbrakeKeep2 + Number13 * ( Cfg.CornerDriveKeep or 0 ) )
    end
    if Grounded > 0 and ( Cfg.ArcadeTraction or 0 ) > 0 and not Flag4 then
        local ArcadeHandbrake
        local RightVector = CFrame2.RightVector
        local ArcadeTraction = Cfg.ArcadeTraction * Number9
        ArcadeHandbrake = Argument3.Handbrake and Cfg.ArcadeHandbrake or 1
        local ArcadeTraction2 = ArcadeTraction * ArcadeHandbrake
        local ArcadeTractionMax = Cfg.ArcadeTractionMax * Number9 * AssemblyMass
        local Amount5 = -AssemblyLinearVelocity:Dot( RightVector ) * AssemblyMass * ArcadeTraction2
        local RightVector2 = RightVector * math.clamp( Amount5, -ArcadeTractionMax, ArcadeTractionMax )
        Position3 = Position3 + RightVector2

        if Dot > 2 and Argument3.Throttle > -0.05 and AssemblyLinearVelocity.Magnitude > 1 then
            local Amount6 = -RightVector2:Dot( AssemblyLinearVelocity.Unit )

            if Amount6 > 0 then
                Position3 = Position3 + LookVector * Amount6 * ( Cfg.ArcadeSpeedKeep or 0 )
            end
        end
    end
    if Grounded >= 2 and not Argument3.Parked and not Flag4 and not Argument3.Handbrake then
        local Throttle = Argument3.Throttle

        if not ( Throttle > 0.05 ) or not ( Dot > -1.5 ) then
            if not ( Throttle < -0.05 ) or not ( Dot < 1.5 ) then
                if Throttle > 0.05 and Dot <= -1.5 and Cfg.ReverseStopDecel then
                    local Max4 = math.max( Cfg.ReverseStopDecel - BrakeDecel2, 0 ) * Throttle
                    Position3 = Position3 + LookVector * AssemblyMass * math.min( Max4, -Dot / Max )
                end
            else
                local Clamp6 = math.clamp( 1 - math.max( -Dot, 0 ) / Cfg.ReverseBoostSpeed, 0, 1 )
                Position3 = Position3 + LookVector * AssemblyMass * Cfg.ReverseAcceleration * Cfg.ReverseBoost * Throttle * Clamp6
            end
        else
            local DriveAccel2
            local Clamp5 = math.clamp( 1 - math.max( Dot, 0 ) / Cfg.LaunchBoostSpeed, 0, 1 )
            local LookVector2 = LookVector * AssemblyMass
            local DriveAccel = Argument3.DriveAccel
            DriveAccel2 = if DriveAccel then DriveAccel else Cfg.Acceleration
            Position3 = Position3 + LookVector2 * DriveAccel2 * Cfg.LaunchBoost * Throttle * Clamp5 * ( 1 - Clamp3 )
        end
    end
    if Argument3.Parked and not Flag3 and Grounded > 0 then
        local AssemblyLinearVelocity2 = AssemblyLinearVelocity - UpVector * AssemblyLinearVelocity:Dot( UpVector )
        local Magnitude2 = AssemblyLinearVelocity2.Magnitude

        if Magnitude2 > 0.05 then
            local Unit = AssemblyLinearVelocity2.Unit * AssemblyMass
            local ParkedBrake = Cfg.ParkedBrake
            Position3 = Position3 - Unit * math.min( ParkedBrake, Magnitude2 / Max )
        end
    end

    Position3 = Position3 + -AssemblyLinearVelocity * AssemblyLinearVelocity.Magnitude * Cfg.Drag * AssemblyMass

    if Grounded > 0 then
        Position3 = Position3 + -UpVector * Dot * Dot * Cfg.Downforce * AssemblyMass
    end

    local AirGravity = Cfg.AirGravity

    if Grounded == 0 and AirGravity and AirGravity < workspace.Gravity then
        local Flag7

        if UpVector.Y > 0.5 then
            Flag7 = true
        elseif workspace:Raycast( AssemblyCenterOfMass, Vector3.new( 0, -( Argument1.bodyReach or 5 ), 0 ), Argument1.rayParams ) == nil then
            Flag7 = true
        else
            Flag7 = false
        end
        if Flag7 then
            Position3 = Position3 + Vector3.new( 0, AssemblyMass * ( workspace.Gravity - AirGravity ), 0 )
        end
    end

    local Flag9
    local VectorToObjectSpace = CFrame2:VectorToObjectSpace( Root.AssemblyAngularVelocity )
    Flag9 = #Argument1.wheels <= Grounded and true or false
    local Flag8

    for Index6, Value11 in ipairs( Argument1.wheels ) do
        if Value11.grounded then
            if Value11.landing then
                Flag8 = true
                break
            end
        end

        Flag8 = false
    end

    local EndsOff2

    if UpVector.Y > 0.3 then
        local EndParts2
        local EndParts = Argument1.endParts
        EndParts2 = if EndParts then EndParts else { }

        if #EndParts2 > 0 then
            if Grounded ~= 0 or not ( ( Argument1.airTime or 0 ) > 0.1 ) or not ( AssemblyLinearVelocity.Y < -4 ) then
                local EndsOff = Argument1.endsOff

                if EndsOff then
                    if Flag8 then
                        EndsOff2 = Flag8
                    else
                        EndsOff2 = not Flag9
                    end
                else
                    EndsOff2 = EndsOff
                end
            else
                EndsOff2 = true
            end
        else
            EndsOff2 = false
        end
    else
        EndsOff2 = false
    end
    if EndsOff2 then
        local X = AssemblyLinearVelocity.X
        local Vector33 = Vector3.new( X, 0, AssemblyLinearVelocity.Z )

        if Vector33.Magnitude > 2 then
            local NoseAt = Vector33:Dot( LookVector ) >= 0 and Argument1.noseAt or Argument1.tailAt
            local PointToWorldSpace = CFrame2:PointToWorldSpace( NoseAt )
            local Raycast = workspace:Raycast( PointToWorldSpace, Vector33.Unit * ( Vector33.Magnitude * 0.12 + 2 ), Argument1.rayParams )

            if Raycast and Raycast.Normal.Y < 0.6 then
                EndsOff2 = false
            end
        end
    end
    if EndsOff2 ~= Argument1.endsOff then
        local EndParts4
        Argument1.endsOff = EndsOff2
        local EndParts3 = Argument1.endParts
        EndParts4 = if EndParts3 then EndParts3 else { }
        local Value12 = nil

        for Key, Value13 in EndParts4, nil, nil do
            if Value13.Parent then
                Value13.CanCollide = not EndsOff2
            end
        end
    end
    if Flag8 and Cfg.LandingPitchDamp then
        local Max5 = math.max( math.abs( VectorToObjectSpace.X ) - ( Cfg.LandingPitchFree or 0 ), 0 ) * math.sign( VectorToObjectSpace.X )

        if Max5 ~= 0 then
            local AssemblyMass9 = AssemblyMass * ( Argument1.wheelbase ^ 2 + Argument1.track ^ 2 ) / 12 * 1.5
            local RightVector3 = CFrame2.RightVector
            local Amount7 = -Max5 * AssemblyMass9
            local LandingPitchDamp = Cfg.LandingPitchDamp
            Position4 = Position4 + RightVector3 * ( Amount7 * math.min( LandingPitchDamp, 0.8 / Max ) )
        end
    end

    local AngularDamping2

    if Flag9 or Flag8 then
        local AngularDamping = Cfg.AngularDamping

        if AngularDamping then
            AngularDamping2 = AngularDamping
        else
            AngularDamping2 = Cfg.AirAngularDamping
        end
    else
        AngularDamping2 = Cfg.AirAngularDamping
    end

    local AngularDamping3 = Flag9 and math.abs( CFrame2.RightVector.Y ) < 0.25 and Cfg.AngularDamping or Cfg.AirAngularDamping
    local Number14
    local Amount8 = -VectorToObjectSpace.X * AngularDamping2
    Number14 = if Grounded > 0 then 0 else -VectorToObjectSpace.Y * 0.3 * Cfg.AngularDamping
    Position4 = Position4 + CFrame2:VectorToWorldSpace( Vector3.new( Amount8, Number14, -VectorToObjectSpace.Z * AngularDamping3 ) * AssemblyMass )

    if Grounded == 0 then
        Argument1.airTime = ( Argument1.airTime or 0 ) + Argument2
    else
        Argument1.airTime = 0
    end

    local Number15, Number16, Flag11
    Number15 = 0
    Number16 = 0
    Flag11 = false

    for Index7, Value15 in ipairs( Argument1.wheels ) do
        if Value15.grounded then
            if Value15.front then
                Number15 = Number15 + 1
            else
                Number16 = Number16 + 1
            end
            if Value15.landing then
                Flag11 = true
            end
        end
    end

    local Flag10

    if Grounded > 0 then
        if Number15 == 0 then
            Flag10 = true
        elseif Number16 == 0 then
            Flag10 = true
        else
            Flag10 = false
        end
    else
        Flag10 = false
    end
    if Argument1.airTime > 0.05 or Flag10 then
        if not Flag11 and not Argument3.Parked and Cfg.AirControlAccel then
            local RightVector4 = CFrame2.RightVector
            local AssemblyAngularVelocity = Root.AssemblyAngularVelocity
            local AssemblyMass10 = AssemblyMass * ( Argument1.wheelbase ^ 2 + Argument1.track ^ 2 ) / 12 * 1.5
            local AirControlAccel = Cfg.AirControlAccel * AssemblyMass10
            local Magnitude3 = AssemblyLinearVelocity.Magnitude

            if ( Cfg.AirPitchFollow or 0 ) > 0 and UpVector.Y > 0.3 and math.abs( RightVector4.Y ) < 0.5 and Magnitude3 > 20 then
                Storage.Asin = math.asin( ( math.clamp( ( AssemblyLinearVelocity / Magnitude3 ).Y, -1, 1 ) ) )
                Storage.Asin3 = if Dot < 0 then -Storage.Asin else Storage.Asin
                Storage.Asin2 = math.asin( ( math.clamp( LookVector.Y, -1, 1 ) ) )
                Storage.Asin4 = ( Storage.Asin3 * Cfg.AirPitchFollow - Storage.Asin2 ) * Cfg.AirPitchResponse
                Storage.Amount9 = -Cfg.AirPitchMaxRate
                Storage.Clamp7 = ( math.clamp( Storage.Asin4, Storage.Amount9, Cfg.AirPitchMaxRate ) - AssemblyAngularVelocity:Dot( RightVector4 ) ) * AssemblyMass10
                Storage.AirPitchResponse = Cfg.AirPitchResponse * 2
                Storage.Clamp8 = Storage.Clamp7 * math.min( Storage.AirPitchResponse, 0.8 / Max )
                Position4 = Position4 + RightVector4 * math.clamp( Storage.Clamp8, -AirControlAccel, AirControlAccel )
            end
            if ( Cfg.AirRollRate or 0 ) > 0 and math.abs( Argument3.Steer ) > 0.1 and Grounded == 0 and Argument1.airTime > 0.1 then
                Storage.Steer6 = ( Argument3.Steer * Cfg.AirRollRate - AssemblyAngularVelocity:Dot( LookVector ) ) * AssemblyMass10 * math.min( 4, 0.8 / Max )
                Position4 = Position4 + LookVector * math.clamp( Storage.Steer6, -AirControlAccel, AirControlAccel )
            end
        end
    end
    if UpVector.Y < 0.5 and Grounded < 2 and not Argument3.Parked and math.abs( Argument3.Steer ) > 0.1 and AssemblyLinearVelocity.Magnitude < Cfg.FlipMaxSpeed then
        Storage.X2 = LookVector.X
        Storage.Vector34 = Vector3.new( Storage.X2, 0, LookVector.Z )

        if Storage.Vector34.Magnitude > 0.2 then
            Storage.Unit2 = Storage.Vector34.Unit
            Storage.Dot5 = Root.AssemblyAngularVelocity:Dot( Storage.Unit2 )
            Storage.Sign = math.sign( Argument3.Steer ) * Cfg.FlipRollSpeed
            Storage.AssemblyMass11 = AssemblyMass * ( Argument1.wheelbase ^ 2 + Argument1.track ^ 2 ) / 12 * 1.5
            Storage.Unit3 = Storage.Unit2 * ( Storage.Sign - Storage.Dot5 ) * Storage.AssemblyMass11
            Storage.FlipResponse = Cfg.FlipResponse
            Position4 = Position4 + Storage.Unit3 * math.min( Storage.FlipResponse, 0.8 / Max )
        end
    end
    if Cfg.TwoWheels then
        Storage.Position5 = Vector3.new( 0, 0, 0 )

        for Index8, Value17 in ipairs( Argument1.wheels ) do
            if Value17.grounded and Value17.normal then
                Storage.Position5 = Storage.Position5 + Value17.normal
            end
        end

        Storage.Position6 = if Storage.Position5.Magnitude > 0.5 then Storage.Position5.Unit else Vector3.new( 0, 1, 0 )
        Storage.Dot6 = LookVector:Dot( UpVector:Cross( Storage.Position6 ) )
        Storage.Dot7 = Root.AssemblyAngularVelocity:Dot( LookVector )
        Storage.UprightFreq = Cfg.UprightFreq or 9
        Storage.UprightMaxAccel = Cfg.UprightMaxAccel or 80
        Storage.Dot8 = Storage.Dot6 * Storage.UprightFreq * Storage.UprightFreq - Storage.Dot7 * 2 * Storage.UprightFreq
        Position4 = Position4 + LookVector * math.clamp( Storage.Dot8, -Storage.UprightMaxAccel, Storage.UprightMaxAccel ) * AssemblyMass * ( Argument1.rollShape or 2 )
    end

    Storage.FiniteV = function( Argument1 )
        local Flag

        if Argument1.X == Argument1.X then
            if Argument1.Y == Argument1.Y then
                if Argument1.Z == Argument1.Z then
                    if math.abs( Argument1.X ) < 1000000000000 then
                        if math.abs( Argument1.Y ) < 1000000000000 then
                            if math.abs( Argument1.Z ) < 1000000000000 then
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
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end

        return Flag
    end

    Storage.Force = Argument1.force

    if Position3.X == Position3.X then
        if Position3.Y == Position3.Y then
            if Position3.Z == Position3.Z then
                if math.abs( Position3.X ) < 1000000000000 then
                    if math.abs( Position3.Y ) < 1000000000000 then
                        if math.abs( Position3.Z ) < 1000000000000 then
                            Storage.Flag12 = true
                        else
                            Storage.Flag12 = false
                        end
                    else
                        Storage.Flag12 = false
                    end
                else
                    Storage.Flag12 = false
                end
            else
                Storage.Flag12 = false
            end
        else
            Storage.Flag12 = false
        end
    else
        Storage.Flag12 = false
    end

    Storage.Force2 = ( not Storage.Flag12 or not Position3 ) and Vector3.new( 0, 0, 0 ) or Position3
    Storage.Force.Force = Storage.Force2
    Storage.Torque = Argument1.torque

    if Position4.X == Position4.X then
        if Position4.Y == Position4.Y then
            if Position4.Z == Position4.Z then
                if math.abs( Position4.X ) < 1000000000000 then
                    if math.abs( Position4.Y ) < 1000000000000 then
                        if math.abs( Position4.Z ) < 1000000000000 then
                            Storage.Flag13 = true
                        else
                            Storage.Flag13 = false
                        end
                    else
                        Storage.Flag13 = false
                    end
                else
                    Storage.Flag13 = false
                end
            else
                Storage.Flag13 = false
            end
        else
            Storage.Flag13 = false
        end
    else
        Storage.Flag13 = false
    end

    Storage.Torque2 = ( not Storage.Flag13 or not Position4 ) and Vector3.new( 0, 0, 0 ) or Position4
    Storage.Torque.Torque = Storage.Torque2
    Argument1.grounded = Grounded
end
function Table.stop( Argument1 )
    if Argument1.force then
        Argument1.force.Force = Vector3.new( 0, 0, 0 )
    end
    if Argument1.endsOff then
        local EndParts2
        Argument1.endsOff = false
        local EndParts = Argument1.endParts
        EndParts2 = if EndParts then EndParts else { }
        local Value1 = nil

        for Key, Value in EndParts2, nil, nil do
            if Value.Parent then
                Value.CanCollide = true
            end
        end
    end
    if Argument1.torque then
        Argument1.torque.Torque = Vector3.new( 0, 0, 0 )
    end

    Argument1.steer = 0
end
function Table.updateLean( Argument1, Argument2 )
    local Cfg = Argument1.cfg
    local Root = Argument1.root

    if not Cfg.TwoWheels or not Argument1.leanPivot then
        return nil
    end

    local Number
    local Clamp = math.clamp( Argument2, 0.004166666666666667, 0.05 )
    local CFrame2 = Root.CFrame
    local Dot = Root.AssemblyLinearVelocity:Dot( CFrame2.LookVector )
    Number = if Root.Anchored then 0 else Dot * Root.AssemblyAngularVelocity:Dot( CFrame2.UpVector )
    local Flag
    local Deg = math.deg( ( math.atan( Number / Cfg.LeanG ) ) ) * math.clamp( ( math.abs( Dot ) - 2 ) / 8, 0, 1 )
    local Amount = -Cfg.LeanMax
    local Clamp2 = math.clamp( Deg, Amount, Cfg.LeanMax )
    local LeanSpring = Cfg.LeanSpring
    local LeanDamping = Cfg.LeanDamping
    Argument1.leanVel = Argument1.leanVel + ( LeanSpring * LeanSpring * ( Clamp2 - Argument1.lean ) - 2 * LeanDamping * LeanSpring * Argument1.leanVel ) * Clamp
    local Lean = Argument1.lean + Argument1.leanVel * Clamp
    local Amount2 = -Cfg.LeanMax
    Argument1.lean = math.clamp( Lean, Amount2, Cfg.LeanMax )
    Flag = if Argument1.wheelieOn == true then not Root.Anchored else false

    if Flag then
        local Clamp3 = math.clamp( math.abs( Dot ) / Cfg.TopSpeed, 0, 1 )
        local WheelieRise = Cfg.WheelieRise * ( 1 - ( 1 - Cfg.WheelieRiseAtTop ) * Clamp3 )
        Argument1.wheelieVel = Argument1.wheelieVel + ( WheelieRise - Argument1.wheelieVel ) * math.min( Cfg.WheelieResponse * Clamp, 1 )
    elseif Argument1.wheelie > 0 then
        local WheelieBrakeFall
        local WheelieFallAccel = Cfg.WheelieFallAccel
        WheelieBrakeFall = Argument1.wheelieBrake and Cfg.WheelieBrakeFall or 1
        local WheelieFallAccel2 = WheelieFallAccel * WheelieBrakeFall
        local WheelieVel = Argument1.wheelieVel - WheelieFallAccel2 * Clamp
        Argument1.wheelieVel = math.max( WheelieVel, -Cfg.WheelieFallMax )
    end

    Argument1.wheelie = Argument1.wheelie + Argument1.wheelieVel * Clamp
    local Wheelie = Argument1.wheelie

    if Cfg.WheelieAngle <= Wheelie then
        local Wheelie2 = Cfg.WheelieAngle
        local WheelieVel2 = math.min( Argument1.wheelieVel, 0 )
        Argument1.wheelie = Wheelie2
        Argument1.wheelieVel = WheelieVel2
    elseif Argument1.wheelie < 0 then
        local WheelieVel4
        Argument1.wheelie = 0

        if Flag or not ( Argument1.wheelieVel < -8 ) then
            WheelieVel4 = 0
        else
            local WheelieVel3 = -0.25 * Argument1.wheelieVel

            if WheelieVel3 then
                WheelieVel4 = WheelieVel3
            else
                WheelieVel4 = 0
            end
        end

        Argument1.wheelieVel = WheelieVel4
    end

    local LeanPivot = Argument1.leanPivot
    local WheeliePivot = Argument1.wheeliePivot
    local LeanCF = CFrame.new( 0, LeanPivot, 0 ) * CFrame.Angles( 0, 0, ( math.rad( Argument1.lean ) ) ) * CFrame.new( 0, -LeanPivot, 0 ) * CFrame.new( WheeliePivot ) * CFrame.Angles( math.rad( Argument1.wheelie ), 0, 0 ) * CFrame.new( -WheeliePivot )
    Argument1.leanCF = LeanCF
    return LeanCF
end
function Table.applySeatLean( Argument1, Transform )
    local SeatMotors2
    local SeatMotors = Argument1.seatMotors
    SeatMotors2 = if SeatMotors then SeatMotors else { }

    for Index, Value in ipairs( SeatMotors2 ) do
        Value.Transform = Transform or CFrame.identity
    end
end
function Table.updateVisuals( Argument1, Amount, ShownSteer, Argument4 )
    local ShownSteer2
    local Cfg = Argument1.cfg
    local Root = Argument1.root
    local CFrame2 = Root.CFrame
    local UpVector = CFrame2.UpVector
    local LookVector = CFrame2.LookVector

    if ShownSteer == nil then
        local Atan
        local Dot = Root.AssemblyLinearVelocity:Dot( LookVector )

        if math.abs( Dot ) > 2 then
            Atan = math.atan( Argument1.wheelbase * Root.AssemblyAngularVelocity:Dot( UpVector ) / Dot )
        else
            Atan = 0
        end

        local Rad = math.rad( Cfg.MaxSteer )
        local VisualSteer = Argument1.visualSteer or 0
        local Clamp = math.clamp( Atan, -Rad, Rad )
        local Clamp2 = math.clamp( Amount * 10, 0, 1 )
        Argument1.visualSteer = VisualSteer + ( Clamp - VisualSteer ) * Clamp2
        ShownSteer2 = Argument1.visualSteer
    else
        ShownSteer2 = ShownSteer
    end

    local Lean3
    Argument1.shownSteer = ShownSteer2

    if Cfg.TwoWheels then
        local Lean = Table.updateLean( Argument1, Amount )

        if Lean then
            Lean3 = Lean
        else
            Lean3 = nil
        end
    else
        Lean3 = nil
    end

    local Cos2

    if Cfg.FrontRake then
        local Cos = 1 / math.cos( ( math.rad( Cfg.FrontRake ) ) )

        if Cos then
            Cos2 = Cos
        else
            Cos2 = 1
        end
    else
        Cos2 = 1
    end
    for Index, Value in ipairs( Argument1.wheels ) do
        local VisualSteer2 = ( not Value.front or not ShownSteer2 ) and 0 or ShownSteer2

        if not Argument1.burnSpin or Value.front then
            if not Argument4 or Value.front then
                local VectorToWorldSpace2

                if Value.front then
                    local VectorToWorldSpace = CFrame.fromAxisAngle( UpVector, VisualSteer2 ):VectorToWorldSpace( LookVector )

                    if VectorToWorldSpace then
                        VectorToWorldSpace2 = VectorToWorldSpace
                    else
                        VectorToWorldSpace2 = LookVector
                    end
                else
                    VectorToWorldSpace2 = LookVector
                end

                local Dot5

                if Root.Anchored then
                    Dot5 = 0
                else
                    Dot5 = Root:GetVelocityAtPosition( CFrame2:PointToWorldSpace( Value.center ) ):Dot( VectorToWorldSpace2 )
                end

                local Rim = Value.flat and Value.rim or Value.radius
                local LaunchSlip
                local Number2 = Dot5 / Rim * Amount
                LaunchSlip = not Value.front and Argument1.launchSlip or 0
                local Max

                if LaunchSlip > 0 then
                    local Number3 = Number2 + LaunchSlip * Cfg.BurnWheelSpin * Amount
                    Max = math.max( Number2, ( math.min( Number3, Cfg.BurnWheelMaxStep ) ) )
                else
                    Max = Number2
                end

                Value.spin = ( Value.spin - Max ) % 6.283185307179586
            end
        else
            local Spin = Value.spin
            local BurnWheelSpin = Cfg.BurnWheelSpin * Amount
            Value.spin = ( Spin - math.min( BurnWheelSpin, Cfg.BurnWheelMaxStep ) ) % 6.283185307179586
        end

        local VisualSteer3 = Value.front and VisualSteer2 * Cos2 or VisualSteer2
        local Lean2
        local CFrame5 = CFrame.new( 0, Cfg.TravelUp - Value.d, 0 ) * CFrame.Angles( 0, VisualSteer3, 0 )
        local CFrame6 = CFrame5 * CFrame.Angles( Value.spin, 0, 0 )

        if Lean3 then
            local C0 = Value.c0

            if C0 then
                Lean2 = Value.c0inv * Lean3 * Value.c0
            else
                Lean2 = C0
            end
        else
            Lean2 = Lean3
        end

        local Transform3, Transform4

        if Lean2 then
            Transform3 = Lean2 * CFrame5
            Transform4 = Lean2 * CFrame6
        else
            Transform3 = CFrame5
            Transform4 = CFrame6
        end
        for Index4, Value7 in ipairs( Value.spinMotors ) do
            Value7.Transform = Transform4
        end
        for Index5, Value9 in ipairs( Value.steerMotors ) do
            Value9.Transform = Transform3
        end
        if #Value.fixedMotors > 0 then
            local Transform2
            local Angles = CFrame.Angles( 0, VisualSteer3, 0 )
            Transform2 = if Lean2 then Lean2 * Angles else Angles

            for Index6, Value11 in ipairs( Value.fixedMotors ) do
                Value11.Transform = Transform2
            end
        end
    end
    if #Argument1.bodyMotors > 0 then
        local Dot3
        local Clamp3 = math.clamp( Amount, 0.004166666666666667, 0.05 )
        local PrevFwd = Root.AssemblyLinearVelocity:Dot( LookVector )

        if Argument1.prevFwd then
            local Dot2 = ( PrevFwd - Argument1.prevFwd ) / Clamp3

            if Dot2 then
                Dot3 = Dot2
            else
                Dot3 = 0
            end
        else
            Dot3 = 0
        end

        local Flag
        Argument1.prevFwd = PrevFwd
        local ALong = Argument1.aLong
        local Clamp4 = math.clamp( Dot3, -80, 80 )
        local Clamp5 = math.clamp( Clamp3 * 8, 0, 1 )
        Argument1.aLong = ALong + ( Clamp4 - ALong ) * Clamp5
        local Dot4 = PrevFwd * Root.AssemblyAngularVelocity:Dot( UpVector )
        Flag = false

        for Index2, Value3 in ipairs( Argument1.wheels ) do
            local Flag2 = if Flag then Flag else Value3.grounded
            Flag = Flag2
        end

        local Clamp8

        if Flag then
            local Amount2 = -Dot4 * Cfg.BodyRoll
            local Amount3 = -Cfg.MaxBodyRoll
            local Clamp6 = math.clamp( Amount2, Amount3, Cfg.MaxBodyRoll )

            if Clamp6 then
                Clamp8 = Clamp6
            else
                Clamp8 = 0
            end
        else
            Clamp8 = 0
        end

        local Clamp9

        if Flag then
            local ALong2 = Argument1.aLong * Cfg.BodyPitch
            local Amount4 = -Cfg.MaxBodyPitch
            local Clamp7 = math.clamp( ALong2, Amount4, Cfg.MaxBodyPitch )

            if Clamp7 then
                Clamp9 = Clamp7
            else
                Clamp9 = 0
            end
        else
            Clamp9 = 0
        end

        local RideShown
        local BodySpring = Cfg.BodySpring
        local BodyDamping = Cfg.BodyDamping
        Argument1.rollVel = Argument1.rollVel + ( BodySpring * BodySpring * ( Clamp8 - Argument1.roll ) - 2 * BodyDamping * BodySpring * Argument1.rollVel ) * Clamp3
        Argument1.roll = Argument1.roll + Argument1.rollVel * Clamp3
        Argument1.pitchVel = Argument1.pitchVel + ( BodySpring * BodySpring * ( Clamp9 - Argument1.pitch ) - 2 * BodyDamping * BodySpring * Argument1.pitchVel ) * Clamp3
        Argument1.pitch = Argument1.pitch + Argument1.pitchVel * Clamp3
        local Roll = Argument1.roll
        local Amount5 = -Cfg.MaxBodyRoll
        Argument1.roll = math.clamp( Roll, Amount5, Cfg.MaxBodyRoll )
        local Pitch = Argument1.pitch
        local Amount6 = -Cfg.MaxBodyPitch
        Argument1.pitch = math.clamp( Pitch, Amount6, Cfg.MaxBodyPitch )

        if Argument1.model then
            local Number = tonumber( Argument1.model:GetAttribute( "RideDrop" ) )

            if Number then
                RideShown = Number
            else
                RideShown = 0
            end
        else
            RideShown = 0
        end

        local Clock2
        local RideAt = os.clock( )
        local Clock = RideAt - ( Argument1.rideAt or RideAt )
        Clock2 = if Clock > 0.4 then 0.016666666666666666 else Clock
        local RideVis2
        Argument1.rideAt = RideAt
        Argument1.rideVis = Argument1.rideVis or RideShown
        local RideVis = Argument1.rideVis
        local Clock3 = 1.2 * Clock2

        if RideVis < RideShown then
            RideVis2 = math.min( RideVis + Clock3, RideShown )
        else
            RideVis2 = math.max( RideVis - Clock3, RideShown )
        end

        local Transform
        Argument1.rideVis = RideVis2
        Argument1.rideShown = RideShown
        local CFrame3 = CFrame.new( 0, -Argument1.rideVis, 0 )
        local Rad2 = math.rad( Argument1.pitch )
        local CFrame4 = CFrame3 * CFrame.Angles( Rad2, 0, ( math.rad( Argument1.roll ) ) )
        Transform = if Lean3 then Lean3 * CFrame4 else CFrame4

        for Index3, Value5 in ipairs( Argument1.bodyMotors ) do
            Value5.Transform = Transform
        end
    end
end
return Table
