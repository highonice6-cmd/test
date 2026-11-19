-- Players.perkbrokeyou.PlayerScripts.AnimWorker3.MeleeAnimator
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Controls2
local Players = game:GetService( "Players" )
game:GetService( "UserInputService" )
local CollectionService = game:GetService( "CollectionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local AnimWorkers = require( Weapons:WaitForChild( "AnimWorkers" ) )
AnimWorkers.Init( script )

if AnimWorkers.IsWorker then
    Controls2 = nil
else
    local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )

    if Controls then
        Controls2 = Controls
    else
        Controls2 = nil
    end
end

local MeleeData = require( Weapons:WaitForChild( "MeleeData" ) )
local ClientHitboxes = require( Weapons:WaitForChild( "ClientHitboxes" ) )
local RiotShield = require( Weapons:WaitForChild( "RiotShield" ) )
local FarmZone = require( ReplicatedStorage:WaitForChild( "FarmZone" ) )
local Config = require( ReplicatedStorage:WaitForChild( "VehicleSystem" ):WaitForChild( "Config" ) )
local MeleeAnims = Weapons:WaitForChild( "MeleeAnims" )
local BatteAim = Weapons:WaitForChild( "BatteAim" )
local BatteSwing = Weapons:WaitForChild( "BatteSwing" )
local BatteHit = Weapons:WaitForChild( "BatteHit" )
local BatteFX = Weapons:WaitForChild( "BatteFX" )
local MeleeSounds = Weapons:WaitForChild( "MeleeSounds" )
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Table = {
    UpperTorso = "Waist",
    Head = "Neck",
    RightUpperArm = "RightShoulder",
    RightLowerArm = "RightElbow",
    RightHand = "RightWrist",
    LeftUpperArm = "LeftShoulder",
    LeftLowerArm = "LeftElbow",
    LeftHand = "LeftWrist"
}

local function Load( Object )
    local TableInner = { }

    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "Keyframe" ) then
            local Table2 = { }

            for Key2, Value2 in Value:GetDescendants( ) do
                if Value2:IsA( "Pose" ) and Table[ Value2.Name ] and Value2.Weight > 0 then
                    Table2[ Value2.Name ] = Value2.CFrame
                end
            end

            table.insert( TableInner, { t = Value.Time, poses = Table2, grip = Value:GetAttribute( "Grip" ) } )
        end
    end

    table.sort( TableInner, function( Argument1, Argument2 )
        local Flag = Argument1.t < Argument2.t and true or false
        return Flag
    end )
    return TableInner
end

local function Sample( List, Argument2 )
    local Count = #List - 1
    local I = 1

    for I = 1, Count do
        local Entry = List[ I ]
        local Entry2 = List[ I + 1 ]

        if Argument2 <= Entry2.t then
            local Value1
            local Clamp = math.clamp( ( Argument2 - Entry.t ) / math.max( Entry2.t - Entry.t, 0.0001 ), 0, 1 )
            local Table = { }
            local Poses = Entry.poses
            Value1 = nil

            for Key, Value in Poses, nil, nil do
                Table[ Key ] = Value:Lerp( Entry2.poses[ Key ] or Value, Clamp )
            end

            return Table
        end
    end

    return List[ #List ].poses
end

local function SampleGrip( List, Argument2 )
    local Count = #List - 1
    local I = 1

    for I = 1, Count do
        local Entry = List[ I ]
        local Entry2 = List[ I + 1 ]

        if Argument2 <= Entry2.t and Entry.grip and Entry2.grip then
            return Entry.grip:Lerp( Entry2.grip, ( math.clamp( ( Argument2 - Entry.t ) / math.max( Entry2.t - Entry.t, 0.0001 ), 0, 1 ) ) )
        end
    end

    return List[ #List ].grip
end

local Table2 = { }

local function KindData( DataName )
    if Table2[ DataName ] then
        return Table2[ DataName ]
    end

    local Table3
    AnimWorkers.Sync( )
    local Entry = MeleeData[ DataName ]
    local AIM = Load( MeleeAnims:WaitForChild( Entry.Visee ) )
    local SWING = Load( MeleeAnims:WaitForChild( Entry.Frappe ) )

    if Entry.Parts then
        local Value1
        local Table = { }
        local Parts = Entry.Parts
        Value1 = nil

        for Key, Value in Parts, nil, nil do
            Table[ Value ] = true
            Table3 = Table
        end

        Table3 = Table
    else
        Table3 = nil
    end

    local HOLD
    local Table2Inner = { d = Entry, PARTS = Table3 }
    HOLD = Entry.FreeHold and { } or Load( MeleeAnims:WaitForChild( Entry.Tenue ) )[ 1 ].poses
    local CUT
    Table2Inner.HOLD = HOLD
    Table2Inner.AIM = AIM
    Table2Inner.AIM_LEN = AIM[ #AIM ].t
    Table2Inner.SWING = SWING
    local Cut = MeleeAnims[ Entry.Frappe ]:GetAttribute( "Cut" )
    CUT = if Cut then Cut else SWING[ #SWING ].t
    Table2Inner.CUT = CUT
    Table2[ DataName ] = Table2Inner
    return Table2Inner
end

local function MeleeOf( Key )
    local Tool

    if Key then
        Tool = Key:FindFirstChildOfClass( "Tool" )
    else
        Tool = Key
    end

    local Melee

    if Tool then
        Melee = Tool:GetAttribute( "Melee" )
    else
        Melee = Tool
    end
    if not Melee or not MeleeData[ Melee ] or MeleeData[ Melee ].Fists then
        return nil
    end
    return Melee, Tool
end

local Flag = false

local function SetAim( MeleeAim )
    if Flag == MeleeAim then
        return
    end

    Flag = MeleeAim
    ClientState.MeleeAim = MeleeAim

    if MeleeAim then
        ClientState.AimFOV = 62
        ClientState.AimWalkSpeed = 12
    end

    ClientState.Aiming = MeleeAim
    BatteAim:FireServer( MeleeAim )
end

local function PlaySound( List, Parent, WorldPosition, Amount )
    local Table = { }

    for Key, Value in MeleeSounds:GetChildren( ) do
        local Name = Value.Name

        if Name:sub( 1, #List ) == List then
            table.insert( Table, Value )
        end
    end
    if #Table == 0 then
        return
    end

    local Random2
    local Clone = Table[ math.random( #Table ) ]:Clone( )
    local PlaybackSpeed = Clone.PlaybackSpeed
    local Number = Amount or 1

    if Amount then
        local Random = 0.97 + math.random( ) * 0.06

        if Random then
            Random2 = Random
        else
            Random2 = 0.94 + math.random( ) * 0.12
        end
    else
        Random2 = 0.94 + math.random( ) * 0.12
    end

    local Parent2
    Clone.PlaybackSpeed = PlaybackSpeed * ( Number * Random2 )

    if Parent then
        Parent2 = Parent
    else
        local Attachment = Instance.new( "Attachment" )
        Attachment.WorldPosition = WorldPosition
        Attachment.Parent = workspace.Terrain
        Parent2 = Attachment
    end

    Clone.Parent = Parent2
    Clone:Play( )
    Clone.Ended:Once( function()
        Clone:Destroy( )

        if not Parent then
            Parent2:Destroy( )
        end
    end )
end

local function Swoosh( Object, Argument2 )
    local Handle
    local Tool = Object:FindFirstChildOfClass( "Tool" )

    if Tool then
        Handle = Tool:FindFirstChild( "Handle" )
    else
        Handle = Tool
    end
    if Handle then
        if Object == LocalPlayer.Character or FarmZone.SameSide( Handle.Position ) then
            PlaySound( Argument2.Sounds.Swing, Handle )
        end
    end
end

local function ImpactSound( Argument1, SoundName, WorldPosition, Amount )
    if SoundName == "Car" then
        local Value1
        local Car = Argument1.Sounds.Car
        Value1 = nil

        for Key, Value in Car, nil, nil do
            local Value2 = Key == 1 and Amount or nil
            PlaySound( Value, nil, WorldPosition, Value2 )
        end

        return
    end
    local Value3
    local Body = Argument1.Sounds.Body
    Value3 = nil

    for Key2, Value4 in Body, nil, nil do
        PlaySound( Value4, nil, WorldPosition )
    end

    return
end

BatteFX.OnClientEvent:Connect( function( SoundName, WorldPosition, Amount, Key )
    if AnimWorkers.IsWorker then
        return
    end

    local Entry2
    local Entry = MeleeData[ Key ]
    Entry2 = if Entry then Entry else MeleeData.Batte

    if typeof( WorldPosition ) == "Vector3" and FarmZone.SameSide( WorldPosition ) then
        local Value1 = type( Amount ) == "number" and Amount or nil
        ImpactSound( Entry2, SoundName, WorldPosition, Value1 )
    end
end )

local function CanSwing( Character )
    local Humanoid

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or Humanoid.Health <= 0 or Humanoid.SeatPart then
        return false
    end
    if Character:GetAttribute( "Downed" ) or Character:GetAttribute( "CarriedBy" ) or Character:GetAttribute( "Carrying" ) or Character:GetAttribute( "DanceStart" ) or Character:GetAttribute( "CarRagdoll" ) then
        return false
    end

    local Rolling2
    local Rolling = ClientState.Rolling

    if Rolling then
        Rolling2 = Rolling
    else
        local WardrobeOpen = ClientState.WardrobeOpen

        if WardrobeOpen then
            Rolling2 = WardrobeOpen
        else
            local Carrying = ClientState.Carrying

            if Carrying then
                Rolling2 = Carrying
            else
                Rolling2 = ClientState.CaseRolling
            end
        end
    end

    return not Rolling2
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Include
RaycastParams2.CollisionGroup = "Bullet"
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams3.CollisionGroup = "Bullet"
local RaycastParams4 = RaycastParams.new( )
RaycastParams4.FilterType = Enum.RaycastFilterType.Include

local function VehicleOf( Instance )
    local Model = Instance:FindFirstAncestorWhichIsA( "Model" )

    while Model do
        if CollectionService:HasTag( Model, "Vehicle" ) then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end

    return Model
end

local function FindTarget( Character, D )
    if ClientHitboxes.Refresh then
        ClientHitboxes.Refresh( )
    end

    local HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )

    if not HumanoidRootPart then
        return nil
    end

    local Unit
    local LookVector = CurrentCamera.CFrame.LookVector
    local X = LookVector.X
    local Vector32 = Vector3.new( X, 0, LookVector.Z )
    Unit = Vector32.Magnitude > 0.1 and Vector32.Unit or HumanoidRootPart.CFrame.LookVector
    local Position
    local UpperTorso = Character:FindFirstChild( "UpperTorso" )
    Position = UpperTorso and UpperTorso.Position or HumanoidRootPart.Position + Vector3.new( 0, 1, 0 )
    local Position2 = Position - Unit * 0.8
    local ClientHitboxesInner = workspace:FindFirstChild( "ClientHitboxes" )
    local FX = workspace:FindFirstChild( "FX" )

    if ClientHitboxesInner then
        local Spherecast2
        RaycastParams2.FilterDescendantsInstances = { ClientHitboxesInner }
        local Spherecast = workspace:Spherecast( Position2, D.HitRadius, Unit * ( D.Reach + 0.8 ), RaycastParams2 )
        Spherecast2 = if Spherecast then ClientHitboxes.parts[ Spherecast.Instance ] else Spherecast

        if Spherecast2 and Spherecast2.char ~= Character then
            RaycastParams3.FilterDescendantsInstances = { Character, Spherecast2.char, ClientHitboxesInner, FX }

            if not workspace:Raycast( Position2, Spherecast.Position - Position2, RaycastParams3 ) then
                return "Char", Spherecast2.char, Spherecast2.name, Spherecast.Position
            end
        end
    end
    if ClientState.HoodMelee then
        local HoodMelee = ClientState.HoodMelee( Position2, Unit, D )

        if HoodMelee then
            return "Hood", nil, nil, HoodMelee
        end
    end

    local FilterDescendantsInstances = { Character, ClientHitboxesInner, FX }
    local I = 1

    for I = 1, 4 do
        RaycastParams3.FilterDescendantsInstances = FilterDescendantsInstances
        local Spherecast3 = workspace:Spherecast( Position2, 0.6, Unit * ( D.Reach + 0.8 ), RaycastParams3 )

        if not Spherecast3 then
            return nil
        end

        local Instance = Spherecast3.Instance

        if Instance.Name:sub( 1, 6 ) ~= "Glass_" or not ( Instance.Transparency >= 1 ) then
            local VehicleOf2 = VehicleOf( Instance )

            if not VehicleOf2 then
                return nil
            end
            if D.BreaksGlass and Instance.Name:sub( 1, 6 ) ~= "Glass_" then
                local FilterDescendantsInstances2 = { }

                for Key, Value in VehicleOf2:GetDescendants( ) do
                    if Value:IsA( "BasePart" ) and Value.Name:sub( 1, 6 ) == "Glass_" and Value.CanQuery and Value.Transparency < 1 then
                        table.insert( FilterDescendantsInstances2, Value )
                    end
                end
                if #FilterDescendantsInstances2 > 0 then
                    RaycastParams4.FilterDescendantsInstances = FilterDescendantsInstances2
                    local Spherecast4 = workspace:Spherecast( Position2, 0.6, Unit * ( D.Reach + 0.8 ), RaycastParams4 )

                    if Spherecast4 and Spherecast4.Distance <= Spherecast3.Distance + 1.5 then
                        return "Car", Spherecast4.Instance, Spherecast4.Position, Spherecast4.Position
                    end
                end
            end

            return "Car", Instance, Spherecast3.Position, Spherecast3.Position
        end
        table.insert( FilterDescendantsInstances, Instance )
    end

    return nil
end

local Table3 = { }
local Number = -math.huge

local function Same( Argument1, Argument2 )
    local Flag

    if ( Argument1.Position - Argument2.Position ).Magnitude < 0.001 then
        if Argument1.LookVector:Dot( Argument2.LookVector ) > 0.99999 then
            if Argument1.UpVector:Dot( Argument2.UpVector ) > 0.99999 then
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

    return Flag
end

local function Restore( Character, Argument2 )
    if not Argument2.base then
        return
    end

    local Value1
    local Base = Argument2.base
    Value1 = nil

    for Key, Value in Base, nil, nil do
        local FoundChild2
        local FoundChild = Character:FindFirstChild( Key )

        if FoundChild then
            FoundChild2 = FoundChild:FindFirstChild( Table[ Key ] )
        else
            FoundChild2 = FoundChild
        end
        if FoundChild2 and Argument2.wr and Argument2.wr[ Key ] then
            local Flag
            local GetT = AnimWorkers.getT( FoundChild2 )
            local Entry = Argument2.wr[ Key ]

            if ( GetT.Position - Entry.Position ).Magnitude < 0.001 then
                if GetT.LookVector:Dot( Entry.LookVector ) > 0.99999 then
                    if GetT.UpVector:Dot( Entry.UpVector ) > 0.99999 then
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
            if Flag then
                AnimWorkers.setT( FoundChild2, Value )
            end
        end
    end
end

local function RankedFrozen()
    if not workspace:GetAttribute( "RankedMatch" ) then
        return false
    end

    local MatchState
    local RankedShared = game:GetService( "ReplicatedStorage" ):FindFirstChild( "RankedShared" )

    if RankedShared then
        MatchState = RankedShared:FindFirstChild( "MatchState" )
    else
        MatchState = RankedShared
    end

    local Flag

    if MatchState == nil then
        Flag = false
    elseif MatchState:GetAttribute( "Phase" ) == "fight" then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

if not AnimWorkers.IsWorker then
    Controls2.OnInputBegan( function( Argument1, Argument2 )
        if AnimWorkers.IsWorker then
            return
        end
        if Argument2 then
            return
        end

        local Tool
        local Character = LocalPlayer.Character

        if Character then
            Tool = Character:FindFirstChildOfClass( "Tool" )
        else
            Tool = Character
        end

        local Melee

        if Tool then
            Melee = Tool:GetAttribute( "Melee" )
        else
            Melee = Tool
        end

        local Kind = if not Melee or not MeleeData[ Melee ] or MeleeData[ Melee ].Fists then nil else Melee

        if not Kind or ClientState.CursorFree then
            return
        end

        local D = KindData( Kind ).d

        if not Controls2.Is( "Aim", Argument1 ) then
            if Controls2.Is( "Fire", Argument1 ) then
                local Clock = os.clock( ) - Number

                if D.Gap <= Clock and CanSwing( Character ) and not RankedFrozen( ) then
                    if ClientState.Exhausted or ( ClientState.Stamina or 0 ) < D.Stamina then
                        return
                    end

                    local LastStaminaUse = os.clock( )
                    ClientState.Stamina = ClientState.Stamina - D.Stamina
                    ClientState.LastStaminaUse = LastStaminaUse

                    if ClientState.Stamina <= 0 then
                        ClientState.Exhausted = true
                    end

                    Number = LastStaminaUse
                    local Entry = Table3[ Character ]

                    if Entry then
                        Entry.swing = LastStaminaUse
                        Entry.kind = Kind
                    end

                    local Handle
                    BatteSwing:FireServer( )
                    local Tool2 = Character:FindFirstChildOfClass( "Tool" )

                    if Tool2 then
                        Handle = Tool2:FindFirstChild( "Handle" )
                    else
                        Handle = Tool2
                    end
                    if Handle then
                        if Character == LocalPlayer.Character or FarmZone.SameSide( Handle.Position ) then
                            PlaySound( D.Sounds.Swing, Handle )
                        end
                    end

                    task.delay( D.HitDelay, function()
                        if LocalPlayer.Character == Character then
                            local Tool

                            if Character then
                                Tool = Character:FindFirstChildOfClass( "Tool" )
                            else
                                Tool = Character
                            end

                            local Melee

                            if Tool then
                                Melee = Tool:GetAttribute( "Melee" )
                            else
                                Melee = Tool
                            end

                            local Captured = if not Melee or not MeleeData[ Melee ] or MeleeData[ Melee ].Fists then nil else Melee

                            if Captured == Kind then
                                local Value1, Value2, Value3, Value4 = FindTarget( Character, D )

                                if not Value1 then
                                    return
                                end
                                if Value1 == "Hood" then
                                    local Value5
                                    local Body = D.Sounds.Body
                                    Value5 = nil

                                    for Key, Value in Body, nil, nil do
                                        PlaySound( Value, nil, Value4 )
                                    end

                                    return
                                end
                                BatteHit:FireServer( Value1, Value2, Value3 )

                                if Value1 == "Char" then
                                    local HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )

                                    if HumanoidRootPart then
                                        local BlocksMelee = RiotShield.BlocksMelee

                                        if BlocksMelee( Value2, HumanoidRootPart.Position ) then
                                            local Value6
                                            local Car = D.Sounds.Car
                                            Value6 = nil

                                            for Key2, Value7 in Car, nil, nil do
                                                local Number = if Key2 == 1 then 1.1 else nil
                                                PlaySound( Value7, nil, Value4, Number )
                                            end

                                            return
                                        end
                                    end

                                    local Value8
                                    local Body2 = D.Sounds.Body
                                    Value8 = nil

                                    for Key3, Value9 in Body2, nil, nil do
                                        PlaySound( Value9, nil, Value4 )
                                    end

                                    return
                                end
                                if not D.BreaksGlass or Value2.Name:sub( 1, 6 ) ~= "Glass_" then
                                    local Get
                                    local VehicleOf2 = VehicleOf( Value2 )

                                    if VehicleOf2 then
                                        Get = Config.Get( VehicleOf2:GetAttribute( "VehicleConfig" ) )
                                    else
                                        Get = VehicleOf2
                                    end

                                    local BatHitPitch2 = Get and Get.BatHitPitch or 1
                                    local Value11
                                    local Car2 = D.Sounds.Car
                                    Value11 = nil

                                    for Key4, Value12 in Car2, nil, nil do
                                        local BatHitPitch = if Key4 ~= 1 or not BatHitPitch2 then nil else BatHitPitch2
                                        PlaySound( Value12, nil, Value4, BatHitPitch )
                                    end
                                end

                                return
                            end
                        end
                    end )
                end
            end

            return
        end
        if Flag == true then
            return
        end
        Flag = true
        ClientState.MeleeAim = true
        ClientState.AimFOV = 62
        ClientState.AimWalkSpeed = 12
        ClientState.Aiming = true
        BatteAim:FireServer( true )
        return
    end )
    Controls2.OnInputEnded( function( Argument1 )
        if AnimWorkers.IsWorker then
            return
        end
        if Controls2.Is( "Aim", Argument1 ) and Flag then
            if Flag == false then
                return
            end

            Flag = false
            ClientState.MeleeAim = false
            ClientState.Aiming = false
            BatteAim:FireServer( false )
        end
    end )
end

function ClientState.AfterGunAnimator( Amount )
    local MeleeSwing
    local Swing = os.clock( )
    MeleeSwing = false

    for Key, Value in Players:GetPlayers( ) do
        local Character = Value.Character

        if Character and AnimWorkers.Owns( Character ) then
            local Tool
            local Entry = Table3[ Character ]

            if Character then
                Tool = Character:FindFirstChildOfClass( "Tool" )
            else
                Tool = Character
            end

            local Melee

            if Tool then
                Melee = Tool:GetAttribute( "Melee" )
            else
                Melee = Tool
            end

            local Character2, Character3

            if not Melee or not MeleeData[ Melee ] or MeleeData[ Melee ].Fists then
                Character2 = nil
                Character3 = nil
            else
                Character2 = Melee
                Character3 = Tool
            end
            if Character2 then
                local KindData2 = KindData( Character2 )
                local D = KindData2.d

                if Character == LocalPlayer.Character then
                    local Animator
                    local Humanoid = Character:FindFirstChildOfClass( "Humanoid" )

                    if Humanoid then
                        Animator = Humanoid:FindFirstChildOfClass( "Animator" )
                    else
                        Animator = Humanoid
                    end
                    if Animator then
                        for Key2, Value2 in Animator:GetPlayingAnimationTracks( ) do
                            if Value2.Name == "ToolNoneAnim" then
                                Value2:Stop( 0.1 )
                            end
                        end
                    end
                end

                local Entry2

                if not Entry or Entry.kind == Character2 then
                    Entry2 = Entry
                else
                    Restore( Character, Entry )
                    Entry2 = nil
                end
                if not Entry2 then
                    local TableInner = { w = 0, aim = 0, kind = Character2 }
                    Table3[ Character ] = TableInner
                    Entry2 = TableInner
                end
                if Character ~= LocalPlayer.Character and Character:GetAttribute( "BatteSwing" ) and Character:GetAttribute( "BatteSwing" ) ~= Entry2.seen then
                    if Entry2.seen ~= nil then
                        Entry2.swing = Swing
                        AnimWorkers.Defer( Swoosh, Character, D )
                    end

                    Entry2.seen = Character:GetAttribute( "BatteSwing" )
                end

                local Swing3
                local Swing2 = Entry2.swing
                Swing3 = if Swing2 then Swing - Entry2.swing else Swing2
                local Captured

                if Character ~= LocalPlayer.Character or not Flag then
                    if Character:GetAttribute( "BatteAim" ) == true then
                        Captured = true
                    else
                        Captured = false
                    end
                else
                    Captured = Flag
                end

                local FlagInner

                if Swing3 == nil then
                    FlagInner = false
                elseif Swing3 < KindData2.CUT + D.SwingOut then
                    FlagInner = true
                else
                    FlagInner = false
                end
                if not FlagInner then
                    Entry2.swing = nil
                end
                if Character == LocalPlayer.Character then
                    MeleeSwing = FlagInner
                end

                local Captured2

                if Captured then
                    Captured2 = Captured
                elseif FlagInner then
                    if Swing3 < KindData2.CUT then
                        Captured2 = not D.FreeHold
                    else
                        Captured2 = false
                    end
                else
                    Captured2 = FlagInner
                end

                local Number
                Entry2.w = math.min( 1, Entry2.w + Amount * 8 )
                local Aim = Entry2.aim
                Number = not Captured2 and 0 or 1
                local Min2
                Entry2.aim = Aim + ( Number - Entry2.aim ) * math.clamp( Amount * 12, 0, 1 )

                if FlagInner then
                    local Min = math.min( Swing3, KindData2.CUT )

                    if Min then
                        Min2 = Min
                    else
                        Min2 = 0
                    end
                else
                    Min2 = 0
                end

                local Value7

                if FlagInner then
                    local Sample2 = Sample( KindData2.SWING, Min2 )

                    if Sample2 then
                        Value7 = Sample2
                    else
                        Value7 = nil
                    end
                else
                    Value7 = nil
                end

                local Clamp2

                if FlagInner then
                    local Clamp = math.clamp( Swing3 / D.SwingIn, 0, 1 )

                    if Clamp then
                        Clamp2 = Clamp
                    else
                        Clamp2 = 0
                    end
                else
                    Clamp2 = 0
                end
                if FlagInner and KindData2.CUT < Swing3 then
                    Clamp2 = Clamp2 * ( 1 - math.clamp( ( Swing3 - KindData2.CUT ) / D.SwingOut, 0, 1 ) )
                end

                local MeleeGrip
                local FoundChild = Character:FindFirstChild( D.Hand )

                if FoundChild then
                    MeleeGrip = FoundChild:FindFirstChild( "MeleeGrip" )
                else
                    MeleeGrip = FoundChild
                end

                local Attribute3
                local Attribute = Character3:GetAttribute( D.GripAttr )

                if D.AimGripAttr then
                    local Attribute2 = Character3:GetAttribute( D.AimGripAttr )

                    if Attribute2 then
                        Attribute3 = Attribute2
                    else
                        Attribute3 = Attribute
                    end
                else
                    Attribute3 = Attribute
                end
                if MeleeGrip and Attribute and Attribute3 then
                    local Flag2
                    local Lerp = Attribute:Lerp( Attribute3, Entry2.aim )

                    if FlagInner then
                        if D.StrikeGripAttr then
                            local Attribute4 = Character3:GetAttribute( D.StrikeGripAttr )

                            if Attribute4 then
                                Flag2 = Attribute4
                            else
                                Flag2 = SampleGrip( KindData2.SWING, Min2 )
                            end
                        else
                            Flag2 = SampleGrip( KindData2.SWING, Min2 )
                        end
                    else
                        Flag2 = FlagInner
                    end

                    local Lerp2

                    if Flag2 then
                        Lerp2 = Lerp:Lerp( Flag2, Clamp2 )
                    else
                        Lerp2 = Lerp
                    end

                    AnimWorkers.setC0( MeleeGrip, Lerp2 )
                end

                local Clock2
                local AIM = KindData2.AIM

                if KindData2.AIM_LEN > 0 then
                    local Clock = Swing % KindData2.AIM_LEN

                    if Clock then
                        Clock2 = Clock
                    else
                        Clock2 = 0
                    end
                else
                    Clock2 = 0
                end

                local Value5
                local Sample3 = Sample( AIM, Clock2 )
                Value5 = nil

                for Key3, Value6 in Table, nil, nil do
                    if not KindData2.PARTS or KindData2.PARTS[ Key3 ] then
                        local FoundChild3
                        local FoundChild2 = Character:FindFirstChild( Key3 )

                        if FoundChild2 then
                            FoundChild3 = FoundChild2:FindFirstChild( Value6 )
                        else
                            FoundChild3 = FoundChild2
                        end
                        if FoundChild3 then
                            local Base2
                            local Base = Entry2.base
                            Base2 = if Base then Base else { }
                            local Wr2
                            Entry2.base = Base2
                            local Wr = Entry2.wr
                            Wr2 = if Wr then Wr else { }
                            local Entry4
                            Entry2.wr = Wr2
                            local GetT = AnimWorkers.getT( FoundChild3 )

                            if Entry2.wr[ Key3 ] then
                                local Flag3
                                local Entry3 = Entry2.wr[ Key3 ]

                                if ( GetT.Position - Entry3.Position ).Magnitude < 0.001 then
                                    if GetT.LookVector:Dot( Entry3.LookVector ) > 0.99999 then
                                        if GetT.UpVector:Dot( Entry3.UpVector ) > 0.99999 then
                                            Flag3 = true
                                        else
                                            Flag3 = false
                                        end
                                    else
                                        Flag3 = false
                                    end
                                else
                                    Flag3 = false
                                end
                                if Flag3 then
                                    Entry4 = Entry2.base[ Key3 ] or GetT
                                else
                                    Entry2.base[ Key3 ] = GetT
                                    Entry4 = GetT
                                end
                            else
                                Entry2.base[ Key3 ] = GetT
                                Entry4 = GetT
                            end

                            local Lerp4
                            local Entry5 = KindData2.HOLD[ Key3 ] or Entry4
                            local Lerp3 = Entry5:Lerp( Sample3[ Key3 ] or Entry5, Entry2.aim )

                            if not Value7 or not Value7[ Key3 ] then
                                Lerp4 = Lerp3
                            else
                                Lerp4 = Lerp3:Lerp( Value7[ Key3 ], Clamp2 )
                            end

                            local Lerp5 = Entry4:Lerp( Lerp4, Entry2.w )
                            AnimWorkers.setT( FoundChild3, Lerp5 )
                            Entry2.wr[ Key3 ] = Lerp5
                        end
                    end
                end
            else
                if Entry then
                    Restore( Character, Entry )
                    Table3[ Character ] = nil
                end
                if Character == LocalPlayer.Character then
                    if Flag then
                        if Flag ~= false then
                            Flag = false
                            ClientState.MeleeAim = false
                            ClientState.Aiming = false
                            BatteAim:FireServer( false )
                        end
                    end

                    ClientState.MeleeSwing = false
                end
            end
        end
    end

    ClientState.MeleeSwing = MeleeSwing
end

if AnimWorkers.IsWorker then
    local Value1 = nil

    for Key, Value in MeleeData, nil, nil do
        if type( Value ) == "table" and Value.Visee and Value.Frappe then
            pcall( KindData, Key )
        end
    end
end
