-- ReplicatedStorage.Weapons.BodyLife
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local FrameCache = require( script.Parent:WaitForChild( "FrameCache" ) )
local AnimWorkers = require( script.Parent:WaitForChild( "AnimWorkers" ) )
local Class = setmetatable( { }, { __mode = "k" } )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer

local function Publish( Key, Argument2 )
    if AnimWorkers.IsWorker or AnimWorkers.COUNT <= 0 then
        return
    end
    if LocalPlayer and Key == LocalPlayer.Character then
        return
    end
    if not Class[ Key ] then
        if not Argument2 then
            return
        end

        Class[ Key ] = true
        Key.AncestryChanged:Connect( function()
            if not Key:IsDescendantOf( game ) then
                local Id = AnimWorkers.Id( Key )

                if Id then
                    AnimWorkers.Life[ Id ] = nil
                end
            end
        end )
    end

    local Id = AnimWorkers.Id( Key )

    if not Id then
        return
    end
    if not Argument2 then
        AnimWorkers.Life[ Id ] = nil
        return
    end

    local Entry = AnimWorkers.Life[ Id ]

    if Entry then
        local Root = Argument2.root
        local Waist = Argument2.waist
        local Neck = Argument2.neck
        Entry.root = Root
        Entry.waist = Waist
        Entry.neck = Neck
        return
    end
    local Life = AnimWorkers.Life
    Life[ Id ] = SharedTable.new( {
        root = Argument2.root,
        waist = Argument2.waist,
        neck = Argument2.neck
    } )
    return
end

local Table = {
    Settings = {
        MaxLean = 11,
        LeanSpeed = 26,
        RootShare = 0.4,
        AccelLean = 0.22,
        MaxAccelLean = 7,
        TurnBank = 0.12,
        MaxBank = 8,
        StepYaw = 5,
        StepRoll = 2.5,
        StepPitch = 1.5,
        HeadStabilize = 0.7,
        BreathPitch = 0.9,
        BreathSpeed = 1.6,
        LandDip = 7,
        LandDrop = 0.25,
        ArmedScale = 0.3,
        AimScale = 0.3
    }
}
local Settings = Table.Settings
local Class2 = setmetatable( { }, { __mode = "k" } )

local function Approach( Argument1, Argument2, Argument3, Argument4 )
    return Argument1 + ( Argument2 - Argument1 ) * ( 1 - math.exp( -Argument3 * Argument4 ) )
end

local Class3 = setmetatable( { }, { __mode = "k" } )

local function GaitPhase( Humanoid, Argument2, Magnitude, Amount )
    local Value1
    local Animator = Humanoid:FindFirstChildOfClass( "Animator" )

    if Animator then
        local Number2 = 0.05
        Value1 = nil

        for Key, Value in Animator:GetPlayingAnimationTracks( ) do
            local Entry2
            local Entry = Class3[ Value ]

            if Entry == nil then
                local Name
                local Animation = Value.Animation
                Name = Animation and Animation.Name or ""
                Class3[ Value ] = Name
                Entry2 = Name
            else
                Entry2 = Entry
            end
            if Entry2 == "RifleLoco" or Entry2 == "RunAnim" or Entry2 == "WalkAnim" then
                local Number
                local WeightCurrent = Value.WeightCurrent
                Number = Entry2 ~= "RifleLoco" and 1 or 10
                local WeightCurrent2 = WeightCurrent * Number

                if Number2 < WeightCurrent2 and Value.Length > 0 then
                    Number2 = WeightCurrent2
                    Value1 = Value
                end
            end
        end
    else
        Value1 = nil
    end
    if Value1 then
        return Value1.TimePosition / Value1.Length * 3.141592653589793 * 2
    end
    Argument2.fallbackPhase = ( Argument2.fallbackPhase or 0 ) + Magnitude * Amount / 5 * 3.141592653589793 * 2
    return Argument2.fallbackPhase
end

function Table.Update( Key2, Amount, Argument3, Argument4 )
    local Humanoid = Key2:FindFirstChildOfClass( "Humanoid" )
    local HumanoidRootPart = Key2:FindFirstChild( "HumanoidRootPart" )

    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 or Humanoid.SeatPart then
        Class2[ Key2 ] = nil

        if not AnimWorkers.IsWorker then
            if not ( AnimWorkers.COUNT <= 0 ) then
                if not LocalPlayer or Key2 ~= LocalPlayer.Character then
                    if Class[ Key2 ] then
                        local Id = AnimWorkers.Id( Key2 )

                        if Id then
                            AnimWorkers.Life[ Id ] = nil
                        end
                    end
                end
            end
        end

        return nil
    end
    local Entry2
    local Entry = Class2[ Key2 ]
    local _, Yaw = HumanoidRootPart.CFrame:ToOrientation( )

    if Entry then
        Entry2 = Entry
    else
        local Table = {
            vSmooth = Vector3.new( 0, 0, 0 ),
            yaw = Yaw,
            lean = 0,
            accel = 0,
            bank = 0,
            motion = 0,
            land = 0,
            wasAir = false,
            t = 0
        }
        Class2[ Key2 ] = Table
        Entry2 = Table
    end

    local Flag
    Entry2.t = Entry2.t + Amount
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
    local X = AssemblyLinearVelocity.X
    local Vector32 = Vector3.new( X, 0, AssemblyLinearVelocity.Z )
    local LookVector = HumanoidRootPart.CFrame.LookVector
    local X2 = LookVector.X
    local Unit = Vector3.new( X2, 0, LookVector.Z ).Unit
    local Magnitude = Vector32.Magnitude
    local Dot = Vector32:Dot( Unit )
    Flag = FrameCache.Floor( Humanoid ) == Enum.Material.Air and true or false
    local AimScale2

    if Argument3 then
        local AimScale = Settings.AimScale

        if AimScale then
            AimScale2 = AimScale
        elseif Argument4 then
            local ArmedScale = Settings.ArmedScale

            if ArmedScale then
                AimScale2 = ArmedScale
            else
                AimScale2 = 1
            end
        else
            AimScale2 = 1
        end
    elseif Argument4 then
        local ArmedScale = Settings.ArmedScale

        if ArmedScale then
            AimScale2 = ArmedScale
        else
            AimScale2 = 1
        end
    else
        AimScale2 = 1
    end

    local MaxLean = Settings.MaxLean * math.clamp( Dot / Settings.LeanSpeed, -0.3, 1 ) * AimScale2
    local Lean = Entry2.lean

    if not Flag or not Entry2.lean then
    else
        MaxLean = Entry2.lean
    end

    local ToOrientation22
    Entry2.lean = Lean + ( MaxLean - Lean ) * ( 1 - math.exp( -6 * Amount ) )
    local VSmooth = Entry2.vSmooth
    Entry2.vSmooth = VSmooth:Lerp( Vector32, 1 - math.exp( -4 * Amount ) )
    local Dot2 = ( Vector32 - Entry2.vSmooth ):Dot( Unit ) * Settings.AccelLean
    local Amount2 = -Settings.MaxAccelLean
    local Clamp = math.clamp( Dot2, Amount2, Settings.MaxAccelLean ) * AimScale2
    local Accel = Entry2.accel
    Entry2.accel = Accel + ( Clamp - Accel ) * ( 1 - math.exp( -10 * Amount ) )
    local ToOrientation2 = ( Yaw - Entry2.yaw + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793
    Entry2.yaw = Yaw
    ToOrientation22 = Amount > 0 and ToOrientation2 / Amount or 0
    local ToOrientation23 = ToOrientation22 * Magnitude * Settings.TurnBank
    local Amount3 = -Settings.MaxBank
    local Clamp2 = math.clamp( ToOrientation23, Amount3, Settings.MaxBank ) * AimScale2
    local Bank = Entry2.bank

    if Flag then
        Clamp2 = 0
    end

    local Clamp3
    Entry2.bank = Bank + ( Clamp2 - Bank ) * ( 1 - math.exp( -8 * Amount ) )
    local Motion = Entry2.motion

    if Flag then
        Clamp3 = 0
    else
        Clamp3 = math.clamp( Magnitude / 16, 0, 1 )
    end

    Entry2.motion = Motion + ( Clamp3 - Motion ) * ( 1 - math.exp( -8 * Amount ) )
    local GaitPhase2 = GaitPhase( Humanoid, Entry2, Magnitude, Amount )
    local Motion2 = Entry2.motion * AimScale2
    local Sin = math.sin( GaitPhase2 ) * Settings.StepYaw * Motion2
    local Sin2 = math.sin( GaitPhase2 ) * Settings.StepRoll * Motion2
    local Cos = math.cos( GaitPhase2 * 2 ) * Settings.StepPitch * Motion2

    if Flag then
        Entry2.airTime = ( Entry2.airTime or 0 ) + Amount
    else
        if ( Entry2.airTime or 0 ) > 0.3 then
            Entry2.land = 1
        end

        Entry2.airTime = 0
    end

    local Land = Entry2.land
    Entry2.land = Land + ( 0 - Land ) * ( 1 - math.exp( -9 * Amount ) )
    local Sin3 = math.sin( Entry2.t * Settings.BreathSpeed ) * Settings.BreathPitch * ( 1 - Entry2.motion )
    local Lean2 = Entry2.lean + Entry2.accel + Entry2.land * Settings.LandDip
    local Lean3 = Lean2 * Settings.RootShare
    local Lean4 = Lean2 * ( 1 - Settings.RootShare ) + Cos + Sin3
    local CFrame2 = CFrame.new( 0, -Entry2.land * Settings.LandDrop, 0 )
    local Rad = math.rad( -Lean3 )
    Entry2.root = CFrame2 * CFrame.Angles( Rad, 0, ( math.rad( Entry2.bank * 0.6 ) ) )
    Entry2.waist = CFrame.Angles( math.rad( -Lean4 ), math.rad( Sin ), ( math.rad( Entry2.bank * 0.4 + Sin2 ) ) )
    local HeadStabilize = Settings.HeadStabilize
    Entry2.neck = CFrame.Angles( math.rad( Lean2 * HeadStabilize ), math.rad( -Sin * HeadStabilize ), ( math.rad( -( Entry2.bank + Sin2 ) * HeadStabilize ) ) )
    Publish( Key2, Entry2 )
    return Entry2
end
function Table.Get( Key )
    if not AnimWorkers.IsWorker then
        return Class2[ Key ]
    end

    local Entry2
    local Id = AnimWorkers.Id( Key )

    if Id then
        local Entry = AnimWorkers.Life[ Id ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = nil
        end
    else
        Entry2 = nil
    end

    return Entry2
end
return Table
