-- StarterPlayer.StarterPlayerScripts.EauClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local SoundService = game:GetService( "SoundService" )
local Terrain = workspace.Terrain
local Eau = require( ReplicatedStorage:WaitForChild( "Eau" ) )
local LocalPlayer = Players.LocalPlayer
local FromRGB = Color3.fromRGB( 120, 205, 230 )
local Table = { "Master_Effects", "Master_Weapons", "Master_Vehicles" }
local Value1 = nil

local function EchelleProche( Argument1 )
    if not Value1 or not Value1.Parent then
        local Map2
        local Map = workspace:FindFirstChild( "Map" )
        Map2 = if Map then Map:FindFirstChild( "LadderTrusses" ) else Map
        Value1 = Map2

        if not Value1 then
            return nil
        end
    end

    local Value1Inner, Magnitude
    Value1Inner = nil
    Magnitude = nil

    for Key, Value in Value1:GetChildren( ) do
        if Value:IsA( "TrussPart" ) then
            local Position = Value.Position - Argument1
            local CFrame = Value.CFrame
            local Size = Value.Size / 2
            local Abs = math.abs( CFrame.RightVector.Y ) * Size.X + math.abs( CFrame.UpVector.Y ) * Size.Y + math.abs( CFrame.LookVector.Y ) * Size.Z

            if math.abs( Position.Y ) <= Abs + 2 then
                local Magnitude2 = ( Position * Vector3.new( 1, 0, 1 ) ).Magnitude

                if not Magnitude or Magnitude2 < Magnitude then
                    Value1Inner = Value
                    Magnitude = Magnitude2
                end
            end
        end
    end

    return Value1Inner, Magnitude
end

local Value2 = nil
local Value3 = nil

local function Contraintes( Parent )
    if Value2 and Value2.root == Parent and Value2.vitesse.Parent == Parent then
        return Value2
    end
    if Value2 then
        Value2.vitesse:Destroy( )
        Value2.droit:Destroy( )
    end

    local Attachment0 = Instance.new( "Attachment" )
    Attachment0.Name = "EauNageAttachment"
    Attachment0.Parent = Parent
    local LinearVelocity = Instance.new( "LinearVelocity" )
    LinearVelocity.Name = "EauNageVitesse"
    LinearVelocity.Attachment0 = Attachment0
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis
    local AssemblyMass = Parent.AssemblyMass
    local AssemblyMass2 = AssemblyMass * 400
    local AssemblyMass3 = AssemblyMass * 300
    LinearVelocity.MaxAxesForce = Vector3.new( AssemblyMass2, AssemblyMass3, AssemblyMass * 400 )
    LinearVelocity.Enabled = false
    LinearVelocity.Parent = Parent
    local AlignOrientation = Instance.new( "AlignOrientation" )
    AlignOrientation.Name = "EauNageDroit"
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    AlignOrientation.Attachment0 = Attachment0
    AlignOrientation.RigidityEnabled = true
    AlignOrientation.Enabled = false
    AlignOrientation.Parent = Parent
    Value2 = { root = Parent, vitesse = LinearVelocity, droit = AlignOrientation }
    return Value2
end

local Table2 = {
    haut = { etat = "libre", t = 0, jusqu = 0, ou = 0, sens = 0 },
    plat = { etat = "libre", t = 0, jusqu = 0, ou = 0, n = Vector3.new( 1, 0, 0 ) }
}

local function Contre( Argument1, Amount, Amount2, Amount3, Ou, Min, Clock )
    local Value1

    if Amount <= 0.05 then
        Argument1.etat = "libre"
        Argument1.t = 0
        return Amount
    end
    if Argument1.etat == "libre" then
        if not ( Amount2 > 1 ) or not ( Amount3 < 0.4 * Amount2 ) then
            Argument1.t = 0
        else
            Argument1.t = Argument1.t + Min

            if Argument1.t > 0.12 then
                local Jusqu = Clock + 0.6
                Argument1.etat = "bloque"
                Argument1.jusqu = Jusqu
                Argument1.t = 0
                Argument1.ou = Ou
                return Amount
            end
        end

        return Amount
    end
    if Argument1.etat == "bloque" then
        if Argument1.jusqu <= Clock then
            Argument1.etat = "sonde"
            Argument1.t = 0
        end

        return 0
    end
    if Ou - Argument1.ou > 0.6 then
        Argument1.etat = "libre"
        Argument1.t = 0
        return Amount
    end
    if Amount3 < 0.4 then
        Argument1.t = Argument1.t + Min

        if Argument1.t > 0.15 then
            local Jusqu2 = Clock + 0.6
            local Ou2 = math.max( Argument1.ou, Ou )
            Argument1.etat = "bloque"
            Argument1.jusqu = Jusqu2
            Argument1.t = 0
            Argument1.ou = Ou2
            return 0
        end
        Value1 = Amount
    else
        Argument1.t = 0
        Value1 = Amount
    end

    return ( math.min( Value1, 1 ) )
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true

local function Lacher()
    Value3 = nil
    local Haut = Table2.haut
    local Haut2 = Table2.haut
    local Plat = Table2.plat
    local Plat2 = Table2.plat
    Haut.etat = "libre"
    Haut2.t = 0
    Plat.etat = "libre"
    Plat2.t = 0

    if Value2 then
        if Value2.vitesse.Enabled then
            Value2.vitesse.Enabled = false
        end
        if Value2.droit.Enabled then
            Value2.droit.Enabled = false
        end
    end
end

local Flag = false
local Flag2 = false
local Value4 = nil
local Value5 = nil
local Number = 0
RunService:BindToRenderStep( "EauSaut", Enum.RenderPriority.Input.Value + 1, function( Amount )
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
    if not Humanoid or not HumanoidRootPart then
        Flag = false
        Flag2 = false
        Value4 = nil
        Value5 = nil
        Value3 = nil
        local Haut4 = Table2.haut
        local Haut5 = Table2.haut
        local Plat4 = Table2.plat
        local Plat5 = Table2.plat
        Haut4.etat = "libre"
        Haut5.t = 0
        Plat4.etat = "libre"
        Plat5.t = 0

        if Value2 then
            if Value2.vitesse.Enabled then
                Value2.vitesse.Enabled = false
            end
            if Value2.droit.Enabled then
                Value2.droit.Enabled = false
            end
        end

        return
    end
    local Jump = Humanoid.Jump

    if Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
        if not Value4 then
            Value4 = Humanoid.JumpHeight
        end

        local FlagInner
        local Profondeur = Eau.Profondeur( HumanoidRootPart.Position ) or 0
        FlagInner = Profondeur < 1.6 and true or false
        local Clock = os.clock( )

        if FlagInner then
            if Clock - Number >= 0.15 then
                Number = Clock
                Value5 = EchelleProche( HumanoidRootPart.Position )
            end
        else
            Value5 = nil
        end

        local Position2

        if not Value5 or not Value5.Parent then
            Position2 = nil
        else
            local Position = ( Value5.Position - HumanoidRootPart.Position ) * Vector3.new( 1, 0, 1 )

            if Position then
                Position2 = Position
            else
                Position2 = nil
            end
        end

        local Flag2Inner

        if Position2 == nil then
            Flag2Inner = false
        elseif Position2.Magnitude <= 4.5 then
            Flag2Inner = true
        else
            Flag2Inner = false
        end

        local JumpHeight = Flag2Inner and Value4 or 1.5

        if Humanoid.JumpHeight ~= JumpHeight then
            Humanoid.JumpHeight = JumpHeight
        end
        if Jump and not Flag then
            Flag2 = FlagInner
        end
        if not Jump then
            Flag2 = false
        end

        local StateEnabled = Humanoid:GetStateEnabled( Enum.HumanoidStateType.Jumping )

        if Jump and FlagInner then
            if not Flag2 or not StateEnabled then
                Humanoid.Jump = false
            end
        end

        local MoveDirection = Humanoid.MoveDirection

        if Flag2Inner and StateEnabled and not Humanoid.Jump and Position2.Magnitude <= 3.6 and Position2.Magnitude > 0.05 and ( MoveDirection * Vector3.new( 1, 0, 1 ) ).Magnitude > 0.3 and ( MoveDirection * Vector3.new( 1, 0, 1 ) ).Unit:Dot( Position2.Unit ) > 0.6 then
            Humanoid.Jump = true
        end

        local Contraintes2 = Contraintes( HumanoidRootPart )

        if not Humanoid.Jump or not FlagInner then
            local Vector33
            local WalkSpeed = Humanoid.WalkSpeed * 1.04
            local X = MoveDirection.X
            local Vector32 = Vector3.new( X, 0, MoveDirection.Z ) * WalkSpeed
            local Min = math.min( Amount or 0.016, 0.1 )
            local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
            local Captured = Value3 or AssemblyLinearVelocity
            local Plat = Table2.plat

            if Plat.etat == "libre" then
                local Captured2 = Captured * Vector3.new( 1, 0, 1 )
                local Captured3 = Captured2 - AssemblyLinearVelocity * Vector3.new( 1, 0, 1 )

                if not ( Captured2.Magnitude > 1 ) or not ( 0.5 * Captured2.Magnitude < Captured3.Magnitude ) then
                    Plat.t = 0
                    Vector33 = Vector32
                else
                    Plat.t = Plat.t + Min

                    if Plat.t > 0.12 then
                        local Jusqu = Clock + 0.6
                        local N = Captured3.Unit
                        Plat.etat = "bloque"
                        Plat.jusqu = Jusqu
                        Plat.t = 0
                        Plat.n = N
                        Plat.ou = HumanoidRootPart.Position:Dot( Plat.n )
                        Vector33 = Vector32
                    else
                        Vector33 = Vector32
                    end
                end
            else
                local Dot = Vector32:Dot( Plat.n )
                local Dot2 = ( Captured * Vector3.new( 1, 0, 1 ) ):Dot( Plat.n )
                local Dot3 = ( AssemblyLinearVelocity * Vector3.new( 1, 0, 1 ) ):Dot( Plat.n )
                local Contre2 = Contre( Plat, Dot, Dot2, Dot3, HumanoidRootPart.Position:Dot( Plat.n ), Min, Clock )
                Vector33 = Vector32 + Plat.n * ( Contre2 - Dot )
            end

            local WalkSpeed2
            local Clamp = math.clamp( ( Vector33.Magnitude - 1.5 ) / 3, 0, 1 )

            if Humanoid.Jump then
                WalkSpeed2 = Humanoid.WalkSpeed
            else
                local Y = MoveDirection.Y

                if FlagInner then
                    if Y < -0.42 then
                        WalkSpeed2 = Y * WalkSpeed
                    else
                        local Profondeur2 = ( Profondeur - ( Clamp * -0.15000000000000002 + 0.5 ) ) * 6
                        WalkSpeed2 = math.clamp( Profondeur2, -4, ( math.max( 4, Y * WalkSpeed ) ) )
                    end
                else
                    local NumberInner = if math.abs( Y ) < 0.08 then 0 else Y * WalkSpeed
                    WalkSpeed2 = NumberInner
                end
            end

            RaycastParams2.FilterDescendantsInstances = { Character }
            RaycastParams2.CollisionGroup = HumanoidRootPart.CollisionGroup
            local Raycast = workspace:Raycast( HumanoidRootPart.Position, Vector3.new( 0, -5, 0 ), RaycastParams2 )

            if Raycast then
                local Y2 = HumanoidRootPart.Position.Y - Raycast.Position.Y
                local Clamp2 = ( 1 - Clamp ) * 2.6 + 1.4

                if Y2 < Clamp2 then
                    WalkSpeed2 = math.max( WalkSpeed2, ( math.min( ( Clamp2 - Y2 ) * 5, 4 ) ) )
                elseif WalkSpeed2 < 0 then
                    WalkSpeed2 = math.max( WalkSpeed2, -( Y2 - Clamp2 ) * 6 )
                end
            end

            local Sens
            local Haut = Table2.haut
            Sens = not ( WalkSpeed2 >= 0 ) and -1 or 1

            if Haut.sens ~= Sens then
                Haut.etat = "libre"
                Haut.t = 0
                Haut.sens = Sens
            end

            local WalkSpeed3 = WalkSpeed2 * Sens
            local Y3 = Captured.Y * Sens
            local Y4 = AssemblyLinearVelocity.Y * Sens
            local Vector34 = Vector33 + Vector3.new( 0, Contre( Haut, WalkSpeed3, Y3, Y4, HumanoidRootPart.Position.Y * Sens, Min, Clock ) * Sens, 0 )
            local Captured4 = Value3 or AssemblyLinearVelocity
            Value3 = Captured4:Lerp( Vector34, 1 - math.exp( Min * -8 ) )
            Contraintes2.vitesse.VectorVelocity = Value3

            if not Contraintes2.vitesse.Enabled then
                Contraintes2.vitesse.Enabled = true
            end
        else
            if Contraintes2.vitesse.Enabled then
                Contraintes2.vitesse.Enabled = false
            end

            Value3 = nil
        end
    else
        if Value4 then
            Humanoid.JumpHeight = Value4
            Value4 = nil
        end

        Flag2 = false
        Value5 = nil
        Value3 = nil
        local Haut2 = Table2.haut
        local Haut3 = Table2.haut
        local Plat2 = Table2.plat
        local Plat3 = Table2.plat
        Haut2.etat = "libre"
        Haut3.t = 0
        Plat2.etat = "libre"
        Plat3.t = 0

        if Value2 then
            if Value2.vitesse.Enabled then
                Value2.vitesse.Enabled = false
            end
            if Value2.droit.Enabled then
                Value2.droit.Enabled = false
            end
        end
    end

    Flag = Jump
    return
end )
RunService:BindToRenderStep( "EauDroit", Enum.RenderPriority.Camera.Value + 2, function()
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
    if not Humanoid or not HumanoidRootPart or not Value2 or Value2.root ~= HumanoidRootPart then
        return
    end
    if Humanoid:GetState( ) == Enum.HumanoidStateType.Swimming then
        local LookVector = HumanoidRootPart.CFrame.LookVector * Vector3.new( 1, 0, 1 )

        if LookVector.Magnitude > 0.05 then
            local Droit = Value2.droit
            Droit.CFrame = CFrame.lookAt( Vector3.new( 0, 0, 0 ), LookVector )
        end
        if not Value2.droit.Enabled then
            Value2.droit.Enabled = true
            return
        end
    elseif Value2.droit.Enabled then
        Value2.droit.Enabled = false
    end
end )
local ColorCorrectionEffect = Instance.new( "ColorCorrectionEffect" )
ColorCorrectionEffect.Name = "EauTeinte"
ColorCorrectionEffect.Enabled = false
local BlurEffect = Instance.new( "BlurEffect" )
BlurEffect.Name = "EauFlou"
BlurEffect.Enabled = false

local function Poser()
    local Parent = workspace.CurrentCamera

    if Parent then
        ColorCorrectionEffect.Parent = Parent
        BlurEffect.Parent = Parent
    end
end

local Parent = workspace.CurrentCamera

if Parent then
    ColorCorrectionEffect.Parent = Parent
    BlurEffect.Parent = Parent
end

workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( Poser )
local WaterTransparency = Terrain.WaterTransparency
local AmbientReverb = SoundService.AmbientReverb

local function Egaliseur( Name )
    local Parent = SoundService:FindFirstChild( Name )

    if not Parent then
        return nil
    end

    local EauEtouffe2
    local EauEtouffe = Parent:FindFirstChild( "EauEtouffe" )

    if EauEtouffe then
        EauEtouffe2 = EauEtouffe
    else
        local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
        EqualizerSoundEffect.Name = "EauEtouffe"
        EqualizerSoundEffect.LowGain = 0
        EqualizerSoundEffect.MidGain = 0
        EqualizerSoundEffect.HighGain = 0
        EqualizerSoundEffect.Enabled = false
        EqualizerSoundEffect.Parent = Parent
        EauEtouffe2 = EqualizerSoundEffect
    end

    return EauEtouffe2
end

local Number2 = 0
local Number3 = -1
local Number4 = -1

local function Appliquer( Amount, Amount2 )
    local Floor = math.floor( math.clamp( Amount2 / 50, 0, 1 ) * 20 + 0.5 ) / 20

    if Amount == Number3 and Floor == Number4 then
        return
    end

    local Enabled
    Number3 = Amount
    Number4 = Floor
    Enabled = Amount > 0 and true or false
    ColorCorrectionEffect.Enabled = Enabled
    BlurEffect.Enabled = Enabled

    if Enabled then
        ColorCorrectionEffect.TintColor = Color3.new( 1, 1, 1 ):Lerp( FromRGB, Amount )
        local Saturation = -0.1 * Amount
        local Contrast = 0.12 * Amount
        ColorCorrectionEffect.Saturation = Saturation
        ColorCorrectionEffect.Contrast = Contrast
        ColorCorrectionEffect.Brightness = ( Floor * -0.12 + -0.04 ) * Amount
        BlurEffect.Size = 6 * Amount
    end

    local Value1
    Terrain.WaterTransparency = WaterTransparency + ( 0.05 - WaterTransparency ) * Amount
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local EauEtouffe3
        local Parent = SoundService:FindFirstChild( Value )

        if Parent then
            local EauEtouffe2
            local EauEtouffe = Parent:FindFirstChild( "EauEtouffe" )

            if EauEtouffe then
                EauEtouffe2 = EauEtouffe
            else
                local EqualizerSoundEffect = Instance.new( "EqualizerSoundEffect" )
                EqualizerSoundEffect.Name = "EauEtouffe"
                EqualizerSoundEffect.LowGain = 0
                EqualizerSoundEffect.MidGain = 0
                EqualizerSoundEffect.HighGain = 0
                EqualizerSoundEffect.Enabled = false
                EqualizerSoundEffect.Parent = Parent
                EauEtouffe2 = EqualizerSoundEffect
            end

            EauEtouffe3 = EauEtouffe2
        else
            EauEtouffe3 = nil
        end
        if EauEtouffe3 then
            EauEtouffe3.Enabled = Enabled
            local HighGain = -30 * Amount
            local MidGain = -12 * Amount
            EauEtouffe3.HighGain = HighGain
            EauEtouffe3.MidGain = MidGain
        end
    end

    local AmbientReverbInner = Amount > 0.5 and Enum.ReverbType.UnderWater or AmbientReverb
    SoundService.AmbientReverb = AmbientReverbInner
end

RunService:BindToRenderStep( "EauImage", Enum.RenderPriority.Last.Value, function( Amount )
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Number
    local Profondeur = Eau.Profondeur( CurrentCamera.CFrame.Position )
    Number = not Profondeur and 0 or 1

    if Number2 ~= Number then
        local Amount2 = Number2 < Number and Amount or -Amount
        Number2 = math.clamp( Number2 + Amount2 / 0.25, 0, 1 )
    end

    Appliquer( Number2, Profondeur or 0 )
end )
local Value6 = nil
task.spawn( function()
    Value6 = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "Effects" ) )
end )
local Value7 = nil
local Value8 = nil
task.spawn( function()
    local Player_WaterRipples
    local FX = workspace:WaitForChild( "FX", 30 )
    local FX2 = ReplicatedStorage:WaitForChild( "FX", 30 )

    if FX2 then
        Player_WaterRipples = FX2:WaitForChild( "Player_WaterRipples", 30 )
    else
        Player_WaterRipples = FX2
    end

    local Clone

    if Player_WaterRipples then
        local IsA = Player_WaterRipples:IsA( "PVInstance" )

        if IsA then
            Clone = Player_WaterRipples:Clone( )
        else
            Clone = IsA
        end
    else
        Clone = Player_WaterRipples
    end
    if not Clone then
        return
    end
    for Key, Value in Player_WaterRipples:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) then
            Value.Enabled = false
        end
    end

    local Value1
    local Descendants = Clone:GetDescendants( )
    table.insert( Descendants, Clone )
    Value1 = nil

    for Key2, Value2 in Descendants, nil, nil do
        if Value2:IsA( "BasePart" ) then
            Value2.Anchored = true
            Value2.CanCollide = false
            Value2.CanQuery = false
            Value2.CanTouch = false
        end
    end

    Value8 = FX
    Value7 = Clone
end )
local Class = setmetatable( { }, { __mode = "k" } )

local function RidesPour( Character, Argument2 )
    local Number
    local Clone = Value7:Clone( )
    Clone.Name = "Player_WaterRipplesFX"
    local Table = { }
    Number = 0

    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) and Value.Enabled then
            table.insert( Table, { e = Value, rate = Value.Rate, ecrit = -1 } )
            Number = math.max( Number, Value.Lifetime.Max )
            Value.Enabled = false
        end
    end

    local Rides = {
        part = Clone,
        emetteurs = Table,
        actif = false,
        rot = Clone:GetPivot( ).Rotation
    }
    Argument2.rides = Rides
    Clone.Parent = Value8
    local Connect = nil
    Connect = Character.AncestryChanged:Connect( function()
        if Character:IsDescendantOf( workspace ) then
            return
        end

        local Value1
        Connect:Disconnect( )
        Value1 = nil

        for Key, Value in Table, nil, nil do
            Value.e.Enabled = false
        end

        Argument2.rides = nil
        task.delay( Number + 0.5, Clone.Destroy, Clone )
    end )
    return Rides
end

RunService.Heartbeat:Connect( function( Amount )
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Position = CurrentCamera.CFrame.Position
    local Lu = os.clock( )

    for Key, Value in Players:GetPlayers( ) do
        local HumanoidRootPart
        local Character = Value.Character

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
        if HumanoidRootPart and Humanoid then
            local Entry2
            local Entry = Class[ Character ]

            if Entry then
                Entry2 = Entry
            else
                local Table = { t = 0 }
                Class[ Character ] = Table
                Entry2 = Table
            end

            local Flag
            local Racine = HumanoidRootPart.Position
            local Magnitude = ( Racine - Position ).Magnitude
            Flag = Humanoid.SeatPart ~= nil and true or false
            local Niveau2

            if not Value7 or Flag or not ( Magnitude <= 200 ) or not ( Humanoid.Health > 0 ) or not Character:IsDescendantOf( workspace ) then
                Niveau2 = nil
            else
                if Lu - ( Entry2.lu or 0 ) >= 0.15 then
                    local Niveau
                    Entry2.lu = Lu
                    local Profondeur = Eau.Profondeur( Racine )

                    if Profondeur then
                        local Y = Racine.Y + Profondeur

                        if Y then
                            Niveau = Y
                        else
                            Niveau = nil
                        end
                    else
                        Niveau = nil
                    end

                    Entry2.niveau = Niveau
                end
                if not Entry2.niveau or not ( Racine.Y < Entry2.niveau ) or not ( Entry2.niveau - Racine.Y < 1.6 ) then
                    Niveau2 = nil
                else
                    Niveau2 = Entry2.niveau
                end
            end

            local Rides = Entry2.rides

            if Niveau2 then
                local Rides2

                if Rides then
                    Rides2 = Rides
                else
                    Rides2 = RidesPour( Character, Entry2 )
                end

                local Min2
                local Racine2 = Entry2.racine
                Entry2.racine = Racine

                if not Racine2 or not ( Amount > 0 ) then
                    Min2 = 0
                else
                    local Min = math.min( ( ( Racine - Racine2 ) * Vector3.new( 1, 0, 1 ) ).Magnitude / Amount, 40 )

                    if Min then
                        Min2 = Min
                    else
                        Min2 = 0
                    end
                end

                local Value1
                Entry2.v = ( Entry2.v or Min2 ) + ( Min2 - ( Entry2.v or Min2 ) ) * ( 1 - math.exp( -6 * Amount ) )
                local Clamp = math.clamp( Entry2.v / 14, 0.25, 1.6 )
                Rides2.part:PivotTo( CFrame.new( Racine.X, Niveau2 + 0.05, Racine.Z ) * Rides2.rot )
                local Emetteurs = Rides2.emetteurs
                Value1 = nil

                for Key2, Value2 in Emetteurs, nil, nil do
                    local Ecrit = Value2.rate * Clamp
                    local Abs = math.abs( Ecrit - Value2.ecrit )

                    if 0.02 * Value2.rate < Abs then
                        Value2.ecrit = Ecrit
                        Value2.e.Rate = Ecrit
                    elseif Ecrit ~= Value2.ecrit then
                        if Clamp == 0.25 or Clamp == 1.6 then
                            Value2.ecrit = Ecrit
                            Value2.e.Rate = Ecrit
                        end
                    end
                    if not Rides2.actif then
                        Value2.e.Enabled = true
                    end
                end

                Rides2.actif = true
            else
                Entry2.racine = nil
                Entry2.v = nil

                if Rides and Rides.actif then
                    local Value3
                    Rides.actif = false
                    local Emetteurs2 = Rides.emetteurs
                    Value3 = nil

                    for Key3, Value4 in Emetteurs2, nil, nil do
                        Value4.e.Enabled = false
                    end
                end
            end
            if Flag or Magnitude > 300 then
                Entry2.pos = nil
            else
                local Pos = Racine - Vector3.new( 0, Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2 - 0.5, 0 )
                local Pos2 = Entry2.pos
                Entry2.pos = Pos

                if Value6 and Pos2 and HumanoidRootPart.AssemblyLinearVelocity.Y < -12 and Lu - Entry2.t > 0.6 and ( Pos - Pos2 ).Magnitude < 20 then
                    local Entree = Eau.Entree
                    local Entree2 = Entree( Pos2, Pos - Pos2 )

                    if Entree2 then
                        local Flag2
                        Entry2.t = Lu
                        local Plunge = Value6.Plunge
                        local X = Pos.X
                        local Y2 = Entree2.Y
                        local Vector32 = Vector3.new( X, Y2, Pos.Z )
                        Flag2 = Value ~= LocalPlayer and true or false
                        Plunge( Vector32, Flag2 )
                    end
                end
            end
        end
    end
end )
