-- Players.perkbrokeyou.PlayerScripts.PortesClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local LocalPlayer = Players.LocalPlayer
local PousserPorte = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "PousserPorte" )
local PorteSim = require( ReplicatedStorage:WaitForChild( "PorteSim" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Grid = PorteSim.Grid( )
local Table = { }

local function Physique( Object, Argument2 )
    if not Argument2.sim and Object:GetAttribute( "Physique" ) then
        Argument2.sim = PorteSim.FromModel( Object )

        if Argument2.sim then
            PorteSim.Add( Grid, Argument2.sim )
        end
    end

    return Argument2.sim
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
RaycastParams2.IgnoreWater = true
local Value1 = nil

local function PlaceLibre( Part, Argument2, Amount )
    if Value1 ~= Part.Parent then
        Value1 = Part.Parent
        RaycastParams2.FilterDescendantsInstances = { Value1 }
    end

    local Value1Inner, Min
    local Table = { 0, 1.4, -1.4 }
    Value1Inner = nil
    Min = Amount

    for Key, Value in Table, nil, nil do
        local Raycast = workspace:Raycast( Part.Position + Vector3.new( 0, Value, 0 ), Argument2 * ( Amount + 0.6 ), RaycastParams2 )

        if Raycast then
            Min = math.min( Min, Raycast.Distance - 0.6 )
        end
    end

    return ( math.max( Min, 0 ) )
end

local function TenirHors( Argument1, Theta, Part )
    local Position = Part.Position

    if Position.Y < Argument1.yMin - 3 or Argument1.yMax + 1 < Position.Y then
        return
    end

    local VectorToWorldSpace = CFrame.fromAxisAngle( Argument1.A, Theta ):VectorToWorldSpace( Argument1.u )
    local Unit = Argument1.A:Cross( VectorToWorldSpace ).Unit
    local Position2 = Position - Argument1.H
    local Position3 = Position2 - Argument1.A * Position2:Dot( Argument1.A )
    local Dot = Position3:Dot( VectorToWorldSpace )
    local Dot2 = Position3:Dot( Unit )

    if Dot < -0.3 or Argument1.L + 0.4 < Dot then
        Argument1.cote = nil
        return
    end
    if math.abs( Dot2 ) >= 1.2 then
        local Cote = not ( Dot2 > 0 ) and -1 or 1
        Argument1.cote = Cote
        return
    end
    local Cote3
    local Cote2 = Argument1.cote

    if Cote2 then
        Cote3 = Cote2
    elseif Dot2 >= 0 then
        Cote3 = 1
    else
        Cote3 = -1
    end
    if Dot2 * Cote3 < -0.9 then
        return
    end

    local Number
    Argument1.cote = Cote3
    local Cote4 = Cote3 * 1.2 - Dot2
    Number = not ( Cote4 >= 0 ) and -1 or 1
    local PlaceLibre2 = PlaceLibre( Part, Unit * Number, ( math.abs( Cote4 ) ) )

    if PlaceLibre2 > 0 then
        Part.CFrame = Part.CFrame + Unit * ( Number * PlaceLibre2 )
    end

    local AssemblyLinearVelocity = Part.AssemblyLinearVelocity
    local Dot3 = AssemblyLinearVelocity:Dot( Unit ) * Cote3

    if Dot3 < 0 then
        Part.AssemblyLinearVelocity = AssemblyLinearVelocity - Unit * Cote3 * Dot3
    end

    return
end

local Table2 = { }
local Table3 = { }
local Table4 = { }

local function EaseOpen( Amount )
    return 1 - ( 1 - Amount ) ^ 3
end

local function EaseClose( Amount )
    return Amount * Amount * ( 3 - 2 * Amount )
end

local function Pose( Value, Argument2, Amount )
    if Value.charniere then
        return CFrame.new( Value.charniere ) * CFrame.fromAxisAngle( Value.axe, ( Amount or 1 ) * Value.angle * Argument2 ) * CFrame.new( -Value.charniere ) * Value.ferme
    end
    return Value.ferme + Value.decalage * Argument2
end

local function Animer( Key, Target, Signe, T0, Argument5 )
    if Key.target == Target and Key.signe == Signe and Key.anim then
        return
    end

    local Signe3
    Key.from = Key.alpha

    if Signe then
        Signe3 = Signe
    else
        local Signe2 = Key.signe

        if Signe2 then
            Signe3 = Signe2
        else
            Signe3 = 1
        end
    end

    Key.target = Target
    Key.signe = Signe3
    local Dur = math.max( Argument5, 0.05 )
    Key.t0 = T0
    Key.dur = Dur
    Key.anim = true
    Table3[ Key ] = true
end

local function Suivre( Key )
    if Table2[ Key ] or not Key:IsA( "Model" ) then
        return
    end

    local function Setup()
        if Table2[ Key ] or not Key:GetAttribute( "PF" ) then
            return
        end

        local Table = { m = Key, ferme = Key:GetAttribute( "PF" ), alpha = 0, target = 0 }
        local Charniere = Key:GetAttribute( "PCh" )
        local Axe = Key:GetAttribute( "PAx" )
        local Decalage = Key:GetAttribute( "PDec" )
        Table.charniere = Charniere
        Table.axe = Axe
        Table.decalage = Decalage

        if not Table.charniere and not Table.decalage then
            return
        end

        local Ferme2
        Table.angle = math.rad( Key:GetAttribute( "Angle" ) or 90 )
        local PrimaryPart = Key.PrimaryPart

        if PrimaryPart then
            local Ferme = Table.ferme * Key:GetPivot( ):ToObjectSpace( PrimaryPart.CFrame )

            if Ferme then
                Ferme2 = Ferme
            else
                Ferme2 = Table.ferme
            end
        else
            Ferme2 = Table.ferme
        end

        local C2
        Table.c = Ferme2.Position

        if Table.charniere then
            local C = ( Table.c - Table.charniere ) * Vector3.new( 1, 0, 1 )

            if C then
                C2 = C
            else
                C2 = Table.decalage * Vector3.new( 1, 0, 1 )
            end
        else
            C2 = Table.decalage * Vector3.new( 1, 0, 1 )
        end
        if C2.Magnitude < 0.05 then
            C2 = Ferme2.LookVector * Vector3.new( 1, 0, 1 )
        end

        local Size
        Table.largeur = C2.Unit
        Table.normale = Table.largeur:Cross( Vector3.new( 0, 1, 0 ) ).Unit
        Size = PrimaryPart and PrimaryPart.Size or Vector3.new( 1, 1, 1 )
        local Value1, DemiLargeur
        local Table2Inner = { -1, 1 }
        Value1 = nil
        DemiLargeur = 0

        for KeyInner, Value in Table2Inner, nil, nil do
            local Value2
            local Table3Inner = { -1, 1 }
            Value2 = nil

            for Key2, Value3 in Table3Inner, nil, nil do
                local Value4
                local Table4 = { -1, 1 }
                Value4 = nil

                for Key3, Value5 in Table4, nil, nil do
                    DemiLargeur = math.max( DemiLargeur, ( math.abs( ( ( Ferme2:PointToWorldSpace( Size / 2 * Vector3.new( Value, Value3, Value5 ) ) - Table.c ):Dot( Table.largeur ) ) ) ) )
                end
            end
        end

        local DemiHauteur = Size.Y / 2
        Table.demiLargeur = DemiLargeur
        Table.demiHauteur = DemiHauteur

        if not Table.sim and Key:GetAttribute( "Physique" ) then
            Table.sim = PorteSim.FromModel( Key )

            if Table.sim then
                PorteSim.Add( Grid, Table.sim )
            end
        end

        local Sim = Table.sim

        if Key:GetAttribute( "Etat" ) then
            local Signe = Key:GetAttribute( "Signe" ) or 1
            Table.alpha = 1
            Table.target = 1
            Table.signe = Signe
        end

        local function OnState()
            local Etat = Key:GetAttribute( "Etat" )

            if Etat == nil then
                return
            end

            local Target = not Etat and 0 or 1
            local T02
            local Signe = Key:GetAttribute( "Signe" )
            local T0 = Key:GetAttribute( "T0" )
            T02 = if T0 then T0 else workspace:GetServerTimeNow( )
            local DureeAnim = Key:GetAttribute( "DureeAnim" ) or 0.6

            if Table.target == Target and Table.signe == Signe and Table.anim then
                return
            end

            local Signe3
            Table.from = Table.alpha

            if Signe then
                Signe3 = Signe
            else
                local Signe2 = Table.signe

                if Signe2 then
                    Signe3 = Signe2
                else
                    Signe3 = 1
                end
            end

            Table.target = Target
            Table.signe = Signe3
            local Dur = math.max( DureeAnim, 0.05 )
            Table.t0 = T02
            Table.dur = Dur
            Table.anim = true
            Table3[ Table ] = true
        end

        Key:GetAttributeChangedSignal( "Etat" ):Connect( OnState )
        Key:GetAttributeChangedSignal( "T0" ):Connect( OnState )
        Table2[ Key ] = Table
    end

    Setup( )

    if not Table2[ Key ] then
        local Connect = nil
        Connect = Key:GetAttributeChangedSignal( "PF" ):Connect( function()
            Setup( )

            if Table2[ Key ] then
                Connect:Disconnect( )
            end
        end )
    end
end

local Value2 = nil
task.spawn( function()
    Value2 = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "PorteCapteur" )
end )

local function SuivreCapteur( Object )
    if Object:IsA( "BasePart" ) then
        Object.Touched:Connect( function( Argument1 )
            local Humanoid
            local Character = LocalPlayer.Character

            if Character then
                Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if not Humanoid or Humanoid.Health <= 0 or Argument1 ~= Character:FindFirstChild( "HumanoidRootPart" ) then
                return
            end
            if ClientState.Downed then
                return
            end
            if Value2 then
                Value2:FireServer( Object )
            end

            local Value1
            local Size = Object.Size / 2
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                if Value.target == 0 and Key:GetAttribute( "Auto" ) then
                    local PointToObjectSpace = Object.CFrame:PointToObjectSpace( Value.c )

                    if math.abs( PointToObjectSpace.X ) <= Size.X and math.abs( PointToObjectSpace.Y ) <= Size.Y and math.abs( PointToObjectSpace.Z ) <= Size.Z then
                        local T0 = workspace:GetServerTimeNow( )
                        local Max = math.max( ( 1 - Value.alpha ) * 0.45, 0.05 )

                        if Value.target ~= 1 or Value.signe ~= nil or not Value.anim then
                            local Signe2
                            Value.from = Value.alpha
                            local Signe = Value.signe
                            Signe2 = if Signe then Signe else 1
                            Value.target = 1
                            Value.signe = Signe2
                            local Dur = math.max( Max, 0.05 )
                            Value.t0 = T0
                            Value.dur = Dur
                            Value.anim = true
                            Table3[ Value ] = true
                        end

                        Value.predit = os.clock( )
                        Table4[ Key ] = true
                    end
                end
            end
        end )
        return
    end
    return
end

for Key, Value in CollectionService:GetTagged( "PorteCapteur" ) do
    if Value:IsA( "BasePart" ) then
        Value.Touched:Connect( function( Argument1 )
            local Humanoid
            local Character = LocalPlayer.Character

            if Character then
                Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if not Humanoid or Humanoid.Health <= 0 or Argument1 ~= Character:FindFirstChild( "HumanoidRootPart" ) then
                return
            end
            if ClientState.Downed then
                return
            end
            if Value2 then
                Value2:FireServer( Value )
            end

            local Value1
            local Size = Value.Size / 2
            Value1 = nil

            for Key, ValueInner in Table2, nil, nil do
                if ValueInner.target == 0 and Key:GetAttribute( "Auto" ) then
                    local PointToObjectSpace = Value.CFrame:PointToObjectSpace( ValueInner.c )

                    if math.abs( PointToObjectSpace.X ) <= Size.X and math.abs( PointToObjectSpace.Y ) <= Size.Y and math.abs( PointToObjectSpace.Z ) <= Size.Z then
                        local T0 = workspace:GetServerTimeNow( )
                        local Max = math.max( ( 1 - ValueInner.alpha ) * 0.45, 0.05 )

                        if ValueInner.target ~= 1 or ValueInner.signe ~= nil or not ValueInner.anim then
                            local Signe2
                            ValueInner.from = ValueInner.alpha
                            local Signe = ValueInner.signe
                            Signe2 = if Signe then Signe else 1
                            ValueInner.target = 1
                            ValueInner.signe = Signe2
                            local Dur = math.max( Max, 0.05 )
                            ValueInner.t0 = T0
                            ValueInner.dur = Dur
                            ValueInner.anim = true
                            Table3[ ValueInner ] = true
                        end

                        ValueInner.predit = os.clock( )
                        Table4[ Key ] = true
                    end
                end
            end
        end )
    end
end

CollectionService:GetInstanceAddedSignal( "PorteCapteur" ):Connect( SuivreCapteur )

for Key2, Value3 in CollectionService:GetTagged( "Porte" ) do
    task.spawn( Suivre, Value3 )
end

CollectionService:GetInstanceAddedSignal( "Porte" ):Connect( Suivre )
CollectionService:GetInstanceRemovedSignal( "Porte" ):Connect( function( Key )
    local Entry = Table2[ Key ]

    if Entry then
        Table3[ Entry ] = nil
    end

    Table2[ Key ] = nil
end )
RunService.RenderStepped:Connect( function()
    local Value1
    local ServerTimeNow = workspace:GetServerTimeNow( )
    Value1 = nil

    for Value in Table3, nil, nil do
        if Value.m.Parent then
            local Clamp3
            local Clamp = math.clamp( ( ServerTimeNow - Value.t0 ) / Value.dur, 0, 1 )
            local Target = Value.target

            if not ( Value.from < Target ) or Value.m:GetAttribute( "OuvertureDouce" ) then
                Clamp3 = Clamp * Clamp * ( 3 - 2 * Clamp )
            else
                local Clamp2 = 1 - ( 1 - Clamp ) ^ 3

                if Clamp2 then
                    Clamp3 = Clamp2
                else
                    Clamp3 = Clamp * Clamp * ( 3 - 2 * Clamp )
                end
            end

            Value.alpha = Value.from + ( Value.target - Value.from ) * Clamp3
            Value.m:PivotTo( ( Pose( Value, Value.alpha, Value.signe ) ) )

            if Clamp >= 1 then
                Value.anim = false
                Table3[ Value ] = nil
            end
        else
            Table3[ Value ] = nil
        end
    end
end )
local Table5 = { }

for Key3, Value4 in CollectionService:GetTagged( "GunBot" ) do
    Table5[ Value4 ] = true
end

CollectionService:GetInstanceAddedSignal( "GunBot" ):Connect( function( Key )
    Table5[ Key ] = true
end )
CollectionService:GetInstanceRemovedSignal( "GunBot" ):Connect( function( Key )
    Table5[ Key ] = nil
end )
local Clock = os.clock( )
RunService:BindToRenderStep( "PortesPhysiques", Enum.RenderPriority.Last.Value - 5, function()
    local Position2
    local ClockInner = os.clock( )
    local Clock2 = ClockInner - Clock
    Clock = ClockInner
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Position = CurrentCamera.CFrame.Position

        if Position then
            Position2 = Position
        else
            Position2 = Vector3.new( 0, 0, 0 )
        end
    else
        Position2 = Vector3.new( 0, 0, 0 )
    end

    local TableInner = { }

    for Key, Value in Players:GetPlayers( ) do
        local HumanoidRootPart3
        local Character2 = Value.Character

        if Character2 then
            HumanoidRootPart3 = Character2:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart3 = Character2
        end

        local Humanoid2

        if Character2 then
            Humanoid2 = Character2:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid2 = Character2
        end
        if HumanoidRootPart3 and Humanoid2 and Humanoid2.Health > 0 then
            table.insert( TableInner, { id = Character2, pos = HumanoidRootPart3.Position } )
        end
    end

    local Value1 = nil

    for Value2 in Table5, nil, nil do
        local HumanoidRootPart2 = Value2:FindFirstChild( "HumanoidRootPart" )

        if HumanoidRootPart2 then
            table.insert( TableInner, { id = Value2, pos = HumanoidRootPart2.Position } )
        end
    end
    if ClientState.HoodBodies then
        ClientState.HoodBodies( TableInner )
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Humanoid

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 or Humanoid.SeatPart or HumanoidRootPart.Anchored then
        HumanoidRootPart = nil
    end

    local Value3
    local Near = PorteSim.Near( Grid, TableInner )
    Value3 = nil

    for Value4 in Table, nil, nil do
        local Entry2
        local Entry = Near[ Value4 ]
        Entry2 = if Entry then Entry else { }
        Near[ Value4 ] = Entry2
    end

    local Value5 = nil

    for Key2, Value6 in Near, nil, nil do
        local M = Key2.m

        if M.Parent then
            if ( Key2.H - Position2 ).Magnitude > 90 then
                Table[ Key2 ] = nil
            else
                local Theta
                local Step = PorteSim.Step
                local Step2 = Step( Key2, Value6, ( math.min( Clock2, 0.1 ) ) )
                Theta = if not ( math.abs( Step2 ) < 0.002 ) or #Value6 ~= 0 then Step2 else 0
                Key2.theta = Theta
                M:PivotTo( PorteSim.Pose( Key2, Theta ) )

                if HumanoidRootPart then
                    TenirHors( Key2, Theta, HumanoidRootPart )
                end

                local Flag = if Theta == 0 then nil else true
                Table[ Key2 ] = Flag
            end
        else
            Table[ Key2 ] = nil
        end
    end
end )
local Class = setmetatable( { }, { __mode = "k" } )
local Table6 = { }
local Number = -math.huge
local Position = Vector3.new( 0, 0, 0 )
RunService.Heartbeat:Connect( function()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Humanoid

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 or Humanoid.SeatPart then
        return
    end
    if ClientState.Downed then
        return
    end

    local Value1
    local PositionInner = HumanoidRootPart.Position
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
    local Predit = os.clock( )
    Value1 = nil

    for Value in Table4, nil, nil do
        local Entry2 = Table2[ Value ]

        if not Entry2 or not Entry2.predit or Entry2.sim then
            Table4[ Value ] = nil
        elseif Predit - Entry2.predit > 1.5 then
            Entry2.predit = nil
            Table4[ Value ] = nil

            if Value:GetAttribute( "Etat" ) ~= true then
                local Signe5 = Entry2.signe
                local T03 = workspace:GetServerTimeNow( )

                if Entry2.target ~= 0 or Entry2.signe ~= Signe5 or not Entry2.anim then
                    local Signe7
                    Entry2.from = Entry2.alpha

                    if Signe5 then
                        Signe7 = Signe5
                    else
                        local Signe6 = Entry2.signe

                        if Signe6 then
                            Signe7 = Signe6
                        else
                            Signe7 = 1
                        end
                    end

                    Entry2.target = 0
                    Entry2.signe = Signe7
                    Entry2.t0 = T03
                    Entry2.dur = 0.4
                    Entry2.anim = true
                    Table3[ Entry2 ] = true
                end
            end
        end
    end
    if Predit - Number > 0.25 or ( PositionInner - Position ).Magnitude > 10 then
        local Value2
        Number = Predit
        Position = PositionInner
        table.clear( Table6 )
        Value2 = nil

        for Key, Value3 in Table2, nil, nil do
            if not Value3.sim and ( PositionInner - Value3.c ).Magnitude <= Value3.demiLargeur + Value3.demiHauteur + 30 then
                table.insert( Table6, Key )
            end
        end
    end

    local Value4 = nil

    for Key2, Value5 in Table6, nil, nil do
        local Entry = Table2[ Value5 ]

        if Entry and not Entry.sim and Entry.target == 0 and not Entry.anim then
            local Magnitude = ( PositionInner - Entry.c ).Magnitude

            if not ( Entry.demiLargeur + Entry.demiHauteur + 20 < Magnitude ) and not Value5:GetAttribute( "Physique" ) and not Value5:GetAttribute( "Auto" ) and not Value5:GetAttribute( "Garage" ) then
                local TutoLock = Value5:GetAttribute( "TutoLock" )
                local InTutorial = LocalPlayer:GetAttribute( "InTutorial" )

                if TutoLock and InTutorial then
                    if TutoLock == "all" or InTutorial == "farm" then
                        continue
                    end
                end
                if Value5:GetAttribute( "Approche" ) then
                    local Position2 = PositionInner - Entry.c
                    local X = Position2.X

                    if Vector3.new( X, 0, Position2.Z ).Magnitude < ( Value5:GetAttribute( "ApprocheRayon" ) or 6 ) and math.abs( Position2.Y ) < ( Value5:GetAttribute( "ApprocheHaut" ) or 16 ) and Predit - ( Class[ Value5 ] or 0 ) > 0.8 then
                        Class[ Value5 ] = Predit
                        local T0 = workspace:GetServerTimeNow( )
                        local Min = math.min( Value5:GetAttribute( "Duree" ) or 1, 0.55 )

                        if Entry.target ~= 1 or Entry.signe ~= nil or not Entry.anim then
                            local Signe2
                            Entry.from = Entry.alpha
                            local Signe = Entry.signe
                            Signe2 = if Signe then Signe else 1
                            Entry.target = 1
                            Entry.signe = Signe2
                            local Dur = math.max( Min, 0.05 )
                            Entry.t0 = T0
                            Entry.dur = Dur
                            Entry.anim = true
                            Table3[ Entry ] = true
                        end

                        Entry.predit = Predit
                        Table4[ Value5 ] = true
                        PousserPorte:FireServer( Value5 )
                    end
                else
                    local Position3 = PositionInner - Entry.c
                    local Magnitude2 = Position3.Magnitude

                    if not ( Entry.demiLargeur + Entry.demiHauteur + 4 < Magnitude2 ) then
                        local Dot = Position3:Dot( Entry.normale )

                        if math.abs( Dot ) < 2.8 and math.abs( ( Position3:Dot( Entry.largeur ) ) ) < Entry.demiLargeur + 0.3 and math.abs( Position3.Y ) < Entry.demiHauteur + 2 then
                            local NumberInner = not ( Dot >= 0 ) and -1 or 1

                            if -NumberInner * AssemblyLinearVelocity:Dot( Entry.normale ) > 2.5 and Predit - ( Class[ Value5 ] or 0 ) > 0.8 then
                                local Number4
                                Class[ Value5 ] = Predit

                                if Entry.charniere then
                                    if Value5:GetAttribute( "SensUnique" ) then
                                        local Number2 = not Value5:GetAttribute( "SensInverse" ) and 1 or -1
                                        Number4 = Number2
                                    else
                                        local Number3
                                        local C = Entry.c
                                        local Cross = Entry.axe:Cross( C - Entry.charniere )
                                        Number3 = not ( ( PositionInner - C ):Dot( Cross ) > 0 ) and 1 or -1
                                        Number4 = Number3
                                    end
                                else
                                    Number4 = nil
                                end

                                local T02 = workspace:GetServerTimeNow( )
                                local Min2 = math.min( Value5:GetAttribute( "Duree" ) or 1, 0.55 )

                                if Entry.target ~= 1 or Entry.signe ~= Number4 or not Entry.anim then
                                    local Signe4
                                    Entry.from = Entry.alpha

                                    if Number4 then
                                        Signe4 = Number4
                                    else
                                        local Signe3 = Entry.signe

                                        if Signe3 then
                                            Signe4 = Signe3
                                        else
                                            Signe4 = 1
                                        end
                                    end

                                    Entry.target = 1
                                    Entry.signe = Signe4
                                    local Dur2 = math.max( Min2, 0.05 )
                                    Entry.t0 = T02
                                    Entry.dur = Dur2
                                    Entry.anim = true
                                    Table3[ Entry ] = true
                                end

                                Entry.predit = Predit
                                Table4[ Value5 ] = true
                                PousserPorte:FireServer( Value5, Number4 )
                            end
                        end
                    end
                end
            end
        end
    end
end )
task.spawn( function()
    while true do
        local Value1
        task.wait( 0.5 )
        Value1 = nil

        for Key, Value in Table2, nil, nil do
            if not Value.sim then
                if not Value.sim and Key:GetAttribute( "Physique" ) then
                    Value.sim = PorteSim.FromModel( Key )

                    if Value.sim then
                        PorteSim.Add( Grid, Value.sim )
                    end
                end

                local Sim = Value.sim
            end
        end
    end
end )
