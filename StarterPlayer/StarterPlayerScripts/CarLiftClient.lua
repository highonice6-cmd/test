-- StarterPlayer.StarterPlayerScripts.CarLiftClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local CarLift = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "CarLift" )
local Get = Screens.Get( "CarLiftMenu" )

if not Get then
    warn( "[CarLift] fenêtre CarLiftMenu introuvable (StarterGui.Cases.CarLift)" )
    return
end

local Scale
Screens.SetShown( Get, false )
local Panel = Get:WaitForChild( "Panel" )
local Yes = Panel:WaitForChild( "Yes" )
local No = Panel:WaitForChild( "No" )
local UIScale = Panel:FindFirstChildOfClass( "UIScale" )
Scale = UIScale and UIScale.Scale or 1
local Value1 = nil

local function Close()
    if Value1 then
        Value1 = nil
        Screens.SetShown( Get, false )
        GamepadNav.Close( "CarLiftMenu" )
        return
    end
    return
end

local function Answer( Argument1 )
    if not Value1 then
        return
    end
    if Value1 then
        Value1 = nil
        Screens.SetShown( Get, false )
        GamepadNav.Close( "CarLiftMenu" )
    end

    CarLift:FireServer( Argument1, Value1 )
end

local function Open( Argument1 )
    Value1 = Argument1
    Screens.SetShown( Get, true )

    if UIScale then
        UIScale.Scale = 0.9 * Scale
        TweenService:Create( UIScale, TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Scale } ):Play( )
    end

    GamepadNav.Open( "CarLiftMenu", {
        root = Get,
        first = Yes,
        freeze = false,
        virtual = true,
        onSelect = function()
            if not Value1 then
                return
            end
            if Value1 then
                Value1 = nil
                Screens.SetShown( Get, false )
                GamepadNav.Close( "CarLiftMenu" )
            end

            CarLift:FireServer( "yes", Value1 )
        end,
        virtualActions = {
            [ Yes ] = function()
                if not Value1 then
                    return
                end
                if Value1 then
                    Value1 = nil
                    Screens.SetShown( Get, false )
                    GamepadNav.Close( "CarLiftMenu" )
                end

                CarLift:FireServer( "yes", Value1 )
            end,
            [ No ] = function()
                if not Value1 then
                    return
                end
                if Value1 then
                    Value1 = nil
                    Screens.SetShown( Get, false )
                    GamepadNav.Close( "CarLiftMenu" )
                end

                CarLift:FireServer( "no", Value1 )
            end
        },
        selectLabel = "Yes",
        backLabel = "No",
        onBack = function()
            if not Value1 then
                return
            end
            if Value1 then
                Value1 = nil
                Screens.SetShown( Get, false )
                GamepadNav.Close( "CarLiftMenu" )
            end

            CarLift:FireServer( "no", Value1 )
        end
    } )
end

Yes.Activated:Connect( function()
    if not Value1 then
        return
    end
    if Value1 then
        Value1 = nil
        Screens.SetShown( Get, false )
        GamepadNav.Close( "CarLiftMenu" )
    end

    CarLift:FireServer( "yes", Value1 )
end )
No.Activated:Connect( function()
    if not Value1 then
        return
    end
    if Value1 then
        Value1 = nil
        Screens.SetShown( Get, false )
        GamepadNav.Close( "CarLiftMenu" )
    end

    CarLift:FireServer( "no", Value1 )
end )
CarLift.OnClientEvent:Connect( function( Name, Argument2 )
    if Name == "ask" and type( Argument2 ) == "number" then
        Open( Argument2 )
        return
    end
    if Name == "hide" or Name == "garage" then
        if not Value1 then
            return
        end

        Value1 = nil
        Screens.SetShown( Get, false )
        GamepadNav.Close( "CarLiftMenu" )
    end
end )
local RunService = game:GetService( "RunService" )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer
RunService.Heartbeat:Connect( function()
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid

    if not Character2 then
        return
    end

    local Parent2
    local Parent = Character2.Parent
    Parent2 = if Parent then Character2.Parent.Parent else Parent
    local PrimaryPart = Parent2 and Parent2:IsA( "Model" ) and Parent2.PrimaryPart or Character2.AssemblyRootPart

    if PrimaryPart and PrimaryPart.Anchored then
        if PrimaryPart.AssemblyLinearVelocity.Magnitude > 0 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 0 then
            PrimaryPart.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
            PrimaryPart.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
        end
    end
end )
local CollectionService = game:GetService( "CollectionService" )

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local Table = { }

local function AddPart( PartName )
    local LiftIndex = PartName:GetAttribute( "LiftIndex" )
    local LiftBase = PartName:GetAttribute( "LiftBase" )

    if not PartName:IsA( "BasePart" ) or not LiftIndex or typeof( LiftBase ) ~= "CFrame" then
        return
    end

    local Entry2
    local Entry = Table[ LiftIndex ]
    Entry2 = if Entry then Entry else { }
    Table[ LiftIndex ] = Entry2
    Table[ LiftIndex ][ PartName ] = LiftBase
end

for Key, Value in CollectionService:GetTagged( "CarLiftPart" ) do
    AddPart( Value )
end

CollectionService:GetInstanceAddedSignal( "CarLiftPart" ):Connect( AddPart )
CollectionService:GetInstanceRemovedSignal( "CarLiftPart" ):Connect( function( Key )
    local Value1 = nil

    for Key2, Value in Table, nil, nil do
        Value[ Key ] = nil
    end
end )

local function Movable( Model )
    local Parent2

    if Model then
        local Parent = Model.Parent

        if Parent then
            Parent2 = Model.PrimaryPart
        else
            Parent2 = Parent
        end
    else
        Parent2 = Model
    end

    local Flag = if Parent2 == nil then false else Parent2.Anchored
    return Flag
end

local CarLiftAnim = ReplicatedStorage:WaitForChild( "CarLiftAnim", 30 )

if CarLiftAnim then
    RunService:BindToRenderStep( "CarLiftSmooth", Enum.RenderPriority.Camera.Value - 10, function()
        local ServerTimeNow = workspace:GetServerTimeNow( )

        for Key, Value in CarLiftAnim:GetChildren( ) do
            local SnapT0 = Value:GetAttribute( "SnapT0" )
            local SnapTime = Value:GetAttribute( "SnapTime" )

            if SnapT0 and SnapTime and SnapTime > 0 and SnapT0 <= ServerTimeNow and ServerTimeNow <= SnapT0 + SnapTime + 0.3 then
                local SnapCar2
                local SnapCar = Value:FindFirstChild( "SnapCar" )
                SnapCar2 = if SnapCar then SnapCar.Value else SnapCar
                local SnapFrom = Value:GetAttribute( "SnapFrom" )
                local SnapTo = Value:GetAttribute( "SnapTo" )

                if typeof( SnapFrom ) == "CFrame" and typeof( SnapTo ) == "CFrame" then
                    local SnapCar3

                    if SnapCar2 then
                        local Parent = SnapCar2.Parent

                        if Parent then
                            SnapCar3 = SnapCar2.PrimaryPart
                        else
                            SnapCar3 = Parent
                        end
                    else
                        SnapCar3 = SnapCar2
                    end

                    local Flag = if SnapCar3 == nil then false else SnapCar3.Anchored

                    if Flag then
                        local Clamp = math.clamp( ( ServerTimeNow - SnapT0 ) / SnapTime, 0, 1 )
                        SnapCar2:PivotTo( SnapFrom:Lerp( SnapTo, Clamp * Clamp * ( 3 - 2 * Clamp ) ) )
                    end
                end
            end

            local T0 = Value:GetAttribute( "T0" )
            local Time = Value:GetAttribute( "Time" )

            if T0 and Time and Time > 0 and T0 <= ServerTimeNow and ServerTimeNow <= T0 + Time + 0.3 then
                local Entry2
                local From = Value:GetAttribute( "From" ) or 0
                local To = ( Value:GetAttribute( "To" ) or 0 ) - From
                local Clamp2 = math.clamp( ( ServerTimeNow - T0 ) / Time, 0, 1 )
                local Vector32 = Vector3.new( 0, From + To * ( Clamp2 * Clamp2 * ( 3 - 2 * Clamp2 ) ), 0 )
                local Entry = Table[ Value:GetAttribute( "Index" ) ]
                Entry2 = if Entry then Entry else { }
                local Value1 = nil

                for Key2, Value2 in Entry2, nil, nil do
                    if Key2.Parent then
                        Key2.CFrame = Value2 + Vector32
                    end
                end

                local Car2
                local Car = Value:FindFirstChild( "Car" )
                local CarBase = Value:GetAttribute( "CarBase" )
                Car2 = if Car then Car.Value else Car

                if typeof( CarBase ) == "CFrame" then
                    local Car3

                    if Car2 then
                        local Parent2 = Car2.Parent

                        if Parent2 then
                            Car3 = Car2.PrimaryPart
                        else
                            Car3 = Parent2
                        end
                    else
                        Car3 = Car2
                    end

                    local Flag2 = if Car3 == nil then false else Car3.Anchored

                    if Flag2 then
                        Car2:PivotTo( CarBase + Vector32 )
                    end
                end
            end
        end
    end )
end

local Table2 = { }

local function AddButton( ButtonName )
    if ButtonName:IsA( "ProximityPrompt" ) then
        Table2[ ButtonName ] = true
        ButtonName.Enabled = false
    end
end

for Key2, Value2 in CollectionService:GetTagged( "CarLiftButton" ) do
    if Value2:IsA( "ProximityPrompt" ) then
        Table2[ Value2 ] = true
        Value2.Enabled = false
    end
end

CollectionService:GetInstanceAddedSignal( "CarLiftButton" ):Connect( AddButton )
CollectionService:GetInstanceRemovedSignal( "CarLiftButton" ):Connect( function( Key )
    Table2[ Key ] = nil
end )

local function LiftCenterNear( Position )
    local Children
    local CarLiftAnim = ReplicatedStorage:FindFirstChild( "CarLiftAnim" )
    Children = CarLiftAnim and CarLiftAnim:GetChildren( ) or { }
    local Value1, Center, Flag2
    Value1 = nil
    Center = nil
    Flag2 = nil

    for Key, Value in Children, nil, nil do
        local Flag
        local Center2 = Value:GetAttribute( "Center" )
        Flag = if typeof( Center2 ) == "Vector3" then ( Center2 - Position ).Magnitude else false

        if Flag and Flag <= 12 then
            if not Flag2 or Flag < Flag2 then
                Center = Center2
                Flag2 = Flag
            end
        end
    end

    return Center
end

local function CarOnLift( Argument1 )
    for Key, Value in CollectionService:GetTagged( "Vehicle" ) do
        local IsA2
        local IsA = Value:IsA( "Model" )
        IsA2 = if IsA then Value.PrimaryPart else IsA

        if IsA2 and not Value:GetAttribute( "OnLift" ) and not Value:GetAttribute( "Destroyed" ) then
            local Position = IsA2.Position - Argument1

            if math.abs( Position.X ) <= 9 and math.abs( Position.Z ) <= 4.5 and Position.Y > -1 and Position.Y < 6 then
                local Driver
                local VehicleSeats = Value:FindFirstChild( "VehicleSeats" )

                if VehicleSeats then
                    Driver = VehicleSeats:FindFirstChild( "Driver" )
                else
                    Driver = VehicleSeats
                end

                local OwnerId = Value:GetAttribute( "OwnerId" )

                if Driver and Driver:IsA( "VehicleSeat" ) and not Driver.Occupant then
                    if OwnerId and Value:GetAttribute( "Locked" ) then
                        if OwnerId ~= LocalPlayer.UserId then
                            continue
                        end
                    end

                    return Value
                end
            end
        end
    end

    return nil
end

local function OnFoot()
    if Value1 ~= nil or LocalPlayer:GetAttribute( "InCarGarage" ) == true then
        return false
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Flag

    if Humanoid == nil then
        Flag = false
    elseif Humanoid.Health > 0 then
        if Humanoid.SeatPart == nil then
            local NotDowned = not Character:GetAttribute( "Downed" )

            if NotDowned then
                Flag = not Character:GetAttribute( "CarriedBy" )
            else
                Flag = NotDowned
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local Number = 0
RunService.Heartbeat:Connect( function()
    local Clock = os.clock( )

    if Clock < Number or next( Table2 ) == nil then
        return
    end

    local Value2
    Number = Clock + 0.15
    local OnFoot2 = OnFoot( )
    Value2 = nil

    for Value in Table2, nil, nil do
        local Position
        local Parent = Value.Parent

        if Parent then
            if not Parent:IsA( "BasePart" ) or not Parent.Position then
                if not Parent:IsA( "Attachment" ) or not Parent.WorldPosition then
                    Position = nil
                else
                    Position = Parent.WorldPosition
                end
            else
                Position = Parent.Position
            end
        else
            Position = nil
        end

        local Value4

        if not OnFoot2 or not Position then
            Value4 = nil
        else
            local LiftCenterNear2 = LiftCenterNear( Position )

            if LiftCenterNear2 then
                Value4 = LiftCenterNear2
            else
                Value4 = nil
            end
        end

        local Enabled

        if Value4 == nil then
            Enabled = false
        elseif CarOnLift( Value4 ) == nil then
            Enabled = false
        else
            Enabled = true
        end
        if Value.Enabled ~= Enabled then
            Value.Enabled = Enabled
        end
    end
end )
