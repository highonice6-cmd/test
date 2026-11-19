-- StarterPlayer.StarterPlayerScripts.RbxCharacterSounds
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local SoundService = game:GetService( "SoundService" )
local AtomicBinding = require( script:WaitForChild( "AtomicBinding" ) )

local function LoadFlag( Argument1 )
    local Success, Result = pcall( function()
        return UserSettings( ):IsUserFeatureEnabled( Argument1 )
    end )
    return Success and Result
end

local Text = "UserSoundsUseRelativeVelocity2"
local Success, Result = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( Text )
end )
local Success2 = Success and Result
local Text2 = "UserNewCharacterSoundsApi3"
local Success3, Result2 = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( Text2 )
end )
local Success4 = Success3 and Result2
local Text3 = "UserFixCharSoundsEmitters"
local Success5, Result3 = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( Text3 )
end )
local Success6 = Success5 and Result3
local Text4 = "UserFixCharSoundsEmitterRootPart"
local Success7, Result4 = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( Text4 )
end )
local Success8 = Success7 and Result4
local Table = {
    Climbing = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true
    },
    Died = { SoundId = "rbxasset://sounds/uuhhh.mp3" },
    FreeFalling = { SoundId = "rbxasset://sounds/action_falling.ogg", Looped = true },
    GettingUp = { SoundId = "rbxasset://sounds/action_get_up.mp3" },
    Jumping = { SoundId = "rbxasset://sounds/action_jump.mp3" },
    Landing = { SoundId = "rbxasset://sounds/action_jump_land.mp3" },
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true,
        Pitch = 1.85
    },
    Splash = { SoundId = "rbxasset://sounds/impact_water.mp3" },
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3",
        Looped = true,
        Pitch = 1.6
    }
}
local Table2 = {
    Climbing = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true
    },
    Died = { AssetId = "rbxasset://sounds/uuhhh.mp3" },
    FreeFalling = { AssetId = "rbxasset://sounds/action_falling.ogg", Looping = true },
    GettingUp = { AssetId = "rbxasset://sounds/action_get_up.mp3" },
    Jumping = { AssetId = "rbxasset://sounds/action_jump.mp3" },
    Landing = { AssetId = "rbxasset://sounds/action_jump_land.mp3" },
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true,
        PlaybackSpeed = 1.85
    },
    Splash = { AssetId = "rbxasset://sounds/impact_water.mp3" },
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3",
        Looping = true,
        PlaybackSpeed = 1.6
    }
}

local function Map( Argument1, Argument2, Argument3, Argument4, Argument5 )
    return ( Argument1 - Argument2 ) * ( Argument5 - Argument4 ) / ( Argument3 - Argument2 ) + Argument4
end

local function GetRelativeVelocity( Manager, AssemblyLinearVelocity )
    if not Manager then
        return AssemblyLinearVelocity
    end

    local ActiveController2
    local ActiveController = Manager.ActiveController

    if ActiveController then
        if not Manager.ActiveController:IsA( "GroundController" ) or not Manager.GroundSensor then
            local IsA = Manager.ActiveController:IsA( "ClimbController" )

            if IsA then
                ActiveController2 = Manager.ClimbSensor
            else
                ActiveController2 = IsA
            end
        else
            ActiveController2 = Manager.GroundSensor
        end
    else
        ActiveController2 = ActiveController
    end
    if not ActiveController2 or not ActiveController2.SensedPart then
        return AssemblyLinearVelocity
    end
    return AssemblyLinearVelocity - ActiveController2.SensedPart:GetVelocityAtPosition( Manager.RootPart.Position )
end

local function PlaySound( Track, Argument2 )
    if not Argument2 then
        Track.TimePosition = 0
    end
    if not Success4 or not Track:IsA( "AudioPlayer" ) then
        Track.Playing = true
        return
    end
    Track:Play( )
    return
end

local function StopSound( Self )
    if not Success4 or not Self:IsA( "AudioPlayer" ) then
        Self.Playing = false
        return
    end
    Self:Stop( )
    return
end

local function PlaySoundIf( Track, Playing )
    if not Success4 or not Track:IsA( "AudioPlayer" ) then
        Track.Playing = Playing
    else
        if Track.IsPlaying and not Playing then
            Track:Stop( )
            return
        end
        if not Track.IsPlaying and Playing then
            Track:Play( )
            return
        end
    end
end

local function SetSoundLooped( Track, Looping )
    if not Success4 or not Track:IsA( "AudioPlayer" ) then
        Track.Looped = Looping
        return
    end
    Track.Looping = Looping
    return
end

local function ShallowCopy( List )
    local Table = { }

    for Key, Value in pairs( List ) do
        Table[ Key ] = Value
    end

    return Table
end

local function InitializeSoundSystem( System )
    local ControllerManager
    local Humanoid = System.humanoid
    local Parent = System.rootPart

    if Success2 then
        ControllerManager = Humanoid.Parent:FindFirstChild( "ControllerManager" )
    else
        ControllerManager = nil
    end

    local TargetInstance
    local TableInner = { }

    if not Success4 or SoundService.CharacterSoundsUseNewApi ~= Enum.RolloutState.Enabled then
        for Key3, Value5 in pairs( Table ) do
            local Sound = Instance.new( "Sound" )
            Sound.Name = Key3
            Sound.Archivable = false
            Sound.RollOffMinDistance = 5
            Sound.RollOffMaxDistance = 150
            Sound.Volume = 0.65

            for Key4, Value7 in pairs( Value5 ) do
                Sound[ Key4 ] = Value7
            end

            Sound.Parent = Parent
            TableInner[ Key3 ] = Sound
            TargetInstance = nil
        end

        TargetInstance = nil
    else
        local RootPart3, Character

        if Success6 then
            if Success8 then
                local RootPart2
                local RootPart = Humanoid.RootPart
                RootPart2 = if RootPart then RootPart else Humanoid.Parent
                RootPart3 = RootPart2
                Character = nil
            else
                RootPart3 = Humanoid.RootPart
                Character = nil
            end
        else
            RootPart3 = nil
            Character = Players.LocalPlayer.Character
        end

        local Number
        local Table2Inner = { }
        Number = 5

        while Number < 150 do
            Table2Inner[ Number ] = 5 / Number
            Number = Number * 1.25
        end

        Table2Inner[ 150 ] = 0

        if Success6 then
            TargetInstance = Instance.new( "AudioEmitter", RootPart3 )
        else
            TargetInstance = Instance.new( "AudioEmitter", Character )
        end

        TargetInstance.Name = "RbxCharacterSoundsEmitter"
        TargetInstance:SetDistanceAttenuation( Table2Inner )

        for Key, Value in pairs( Table2 ) do
            local Parent2 = Instance.new( "AudioPlayer" )
            local Wire = Instance.new( "Wire" )
            Parent2.Name = Key
            Wire.Name = Key .. "Wire"
            Parent2.Archivable = false
            Parent2.Volume = 0.65

            for Key2, Value3 in pairs( Value ) do
                Parent2[ Key2 ] = Value3
            end

            Parent2.Parent = Parent
            Wire.Parent = Parent2
            Wire.SourceInstance = Parent2
            Wire.TargetInstance = TargetInstance
            TableInner[ Key ] = Parent2
        end
    end

    local State
    local Table3 = { }

    local function StopPlayingLoopedSounds( Climbing )
        local Value1 = Climbing or nil
        local Table = { }

        for Key, Value in pairs( Table3 ) do
            Table[ Key ] = Value
        end
        for Value4 in pairs( Table ) do
            if Value4 ~= Value1 then
                if not Success4 or not Value4:IsA( "AudioPlayer" ) then
                    Value4.Playing = false
                else
                    Value4:Stop( )
                end

                Table3[ Value4 ] = nil
            end
        end
    end

    local Table4 = {
        [ Enum.HumanoidStateType.FallingDown ] = function()
            StopPlayingLoopedSounds( )
        end,
        [ Enum.HumanoidStateType.GettingUp ] = function()
            StopPlayingLoopedSounds( )
            local GettingUp = TableInner.GettingUp
            GettingUp.TimePosition = 0

            if not Success4 or not GettingUp:IsA( "AudioPlayer" ) then
                GettingUp.Playing = true
                return
            end
            GettingUp:Play( )
            return
        end,
        [ Enum.HumanoidStateType.Jumping ] = function()
            StopPlayingLoopedSounds( )
            local Jumping = TableInner.Jumping
            Jumping.TimePosition = 0

            if not Success4 or not Jumping:IsA( "AudioPlayer" ) then
                Jumping.Playing = true
                return
            end
            Jumping:Play( )
            return
        end,
        [ Enum.HumanoidStateType.Swimming ] = function()
            local Abs = math.abs( Parent.AssemblyLinearVelocity.Y )

            if Abs > 0.1 then
                local Splash = TableInner.Splash
                Splash.Volume = math.clamp( ( Abs - 100 ) * 0.72 / 250 + 0.28, 0, 1 )
                local Splash2 = TableInner.Splash
                Splash2.TimePosition = 0

                if not Success4 or not Splash2:IsA( "AudioPlayer" ) then
                    Splash2.Playing = true
                else
                    Splash2:Play( )
                end
            end

            StopPlayingLoopedSounds( TableInner.Swimming )
            local Swimming = TableInner.Swimming

            if not Success4 or not Swimming:IsA( "AudioPlayer" ) then
                Swimming.Playing = true
            else
                Swimming:Play( )
            end

            Table3[ TableInner.Swimming ] = true
        end,
        [ Enum.HumanoidStateType.Freefall ] = function()
            TableInner.FreeFalling.Volume = 0
            StopPlayingLoopedSounds( TableInner.FreeFalling )
            local FreeFalling = TableInner.FreeFalling

            if not Success4 or not FreeFalling:IsA( "AudioPlayer" ) then
                FreeFalling.Looped = true
            else
                FreeFalling.Looping = true
            end
            if TableInner.FreeFalling:IsA( "Sound" ) then
                TableInner.FreeFalling.PlaybackRegionsEnabled = true
            end

            local FreeFalling2 = TableInner.FreeFalling
            FreeFalling2.LoopRegion = NumberRange.new( 2, 9 )
            local FreeFalling3 = TableInner.FreeFalling
            FreeFalling3.TimePosition = 0

            if not Success4 or not FreeFalling3:IsA( "AudioPlayer" ) then
                FreeFalling3.Playing = true
            else
                FreeFalling3:Play( )
            end

            Table3[ TableInner.FreeFalling ] = true
        end,
        [ Enum.HumanoidStateType.Landed ] = function()
            StopPlayingLoopedSounds( )
            local Abs = math.abs( Parent.AssemblyLinearVelocity.Y )

            if Abs > 75 then
                local Landing = TableInner.Landing
                Landing.Volume = math.clamp( ( Abs - 50 ) * 1 / 50 + 0, 0, 1 )
                local Landing2 = TableInner.Landing
                Landing2.TimePosition = 0

                if Success4 and Landing2:IsA( "AudioPlayer" ) then
                    Landing2:Play( )
                    return
                end

                Landing2.Playing = true
            end
        end,
        [ Enum.HumanoidStateType.Running ] = function()
            StopPlayingLoopedSounds( TableInner.Running )
            local Running = TableInner.Running

            if not Success4 or not Running:IsA( "AudioPlayer" ) then
                Running.Playing = true
            else
                Running:Play( )
            end

            Table3[ TableInner.Running ] = true
        end,
        [ Enum.HumanoidStateType.Climbing ] = function()
            local AssemblyLinearVelocity2
            local Climbing = TableInner.Climbing
            local AssemblyLinearVelocity = Parent.AssemblyLinearVelocity

            if Success2 then
                AssemblyLinearVelocity2 = GetRelativeVelocity( ControllerManager, AssemblyLinearVelocity )
            else
                AssemblyLinearVelocity2 = AssemblyLinearVelocity
            end
            if math.abs( AssemblyLinearVelocity2.Y ) > 0.1 then
                if not Success4 or not Climbing:IsA( "AudioPlayer" ) then
                    Climbing.Playing = true
                else
                    Climbing:Play( )
                end

                StopPlayingLoopedSounds( Climbing )
            else
                StopPlayingLoopedSounds( )
            end

            Table3[ Climbing ] = true
        end,
        [ Enum.HumanoidStateType.Seated ] = function()
            StopPlayingLoopedSounds( )
        end,
        [ Enum.HumanoidStateType.Dead ] = function()
            StopPlayingLoopedSounds( )
            local Died = TableInner.Died
            Died.TimePosition = 0

            if not Success4 or not Died:IsA( "AudioPlayer" ) then
                Died.Playing = true
                return
            end
            Died:Play( )
            return
        end
    }
    local Table5 = {
        [ TableInner.Climbing ] = function( Argument1, Track, Argument3 )
            local RelativeVelocity

            if Success2 then
                RelativeVelocity = GetRelativeVelocity( ControllerManager, Argument3 )
            else
                Value1 = Argument3
            end

            local Playing = Value1.Magnitude > 0.1 and true or false

            if not Success4 or not Track:IsA( "AudioPlayer" ) then
                Track.Playing = Playing
            else
                if Track.IsPlaying and not Playing then
                    Track:Stop( )
                    return
                end
                if not Track.IsPlaying and Playing then
                    Track:Play( )
                    return
                end
            end
        end,
        [ TableInner.FreeFalling ] = function( Amount, Argument2, Argument3 )
            if Argument3.Magnitude > 75 then
                Argument2.Volume = math.clamp( Argument2.Volume + Amount * 0.9, 0, 1 )
                return
            end
            Argument2.Volume = 0
            return
        end,
        [ TableInner.Running ] = function( Argument1, Track, Argument3 )
            local Playing

            if Argument3.Magnitude > 0.5 then
                if Humanoid.MoveDirection.Magnitude > 0.5 then
                    Playing = true
                else
                    Playing = false
                end
            else
                Playing = false
            end
            if not Success4 or not Track:IsA( "AudioPlayer" ) then
                Track.Playing = Playing
            else
                if Track.IsPlaying and not Playing then
                    Track:Stop( )
                    return
                end
                if not Track.IsPlaying and Playing then
                    Track:Play( )
                    return
                end
            end
        end
    }
    local Table6 = {
        [ Enum.HumanoidStateType.RunningNoPhysics ] = Enum.HumanoidStateType.Running
    }
    local Entry = Table6[ Humanoid:GetState( ) ]

    if Entry then
        State = Entry
    else
        State = Humanoid:GetState( )
    end

    local function TransitionTo( Key )
        local Entry = Table4[ Key ]

        if Entry then
            Entry( )
        end

        State = Key
    end

    local Entry2 = Table4[ State ]

    if Entry2 then
        Entry2( )
    end

    local Connect = Humanoid.StateChanged:Connect( function( Argument1, Key )
        local Entry = Table6[ Key ] or Key

        if Entry ~= State then
            local Entry2 = Table4[ Entry ]

            if Entry2 then
                Entry2( )
            end

            State = Entry
        end
    end )
    local Connect2 = RunService.Stepped:Connect( function( Argument1, Argument2 )
        for Value in pairs( Table3 ) do
            local Entry = Table5[ Value ]

            if Entry then
                Entry( Argument2, Value, Parent.AssemblyLinearVelocity )
            end
        end
    end )

    local function Terminate()
        Connect:Disconnect( )
        Connect2:Disconnect( )

        if Success8 and TargetInstance then
            TargetInstance:Destroy( )
        end
        for Key, Value in pairs( TableInner ) do
            Value:Destroy( )
        end

        table.clear( TableInner )
    end

    return Terminate
end

local New = AtomicBinding.new( { humanoid = "Humanoid", rootPart = "HumanoidRootPart" }, InitializeSoundSystem )
local Table3 = { }

local function CharacterAdded( Argument1 )
    New:bindRoot( Argument1 )
end

local function CharacterRemoving( Argument1 )
    New:unbindRoot( Argument1 )
end

local function PlayerAdded( Key )
    local Entry2
    local Entry = Table3[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { }
        Table3[ Key ] = Table
        Entry2 = Table
    end
    if Key.Character then
        New:bindRoot( Key.Character )
    end

    table.insert( Entry2, Key.CharacterAdded:Connect( CharacterAdded ) )
    table.insert( Entry2, Key.CharacterRemoving:Connect( CharacterRemoving ) )
end

local function PlayerRemoving( Key )
    local Entry = Table3[ Key ]

    if Entry then
        for Index, Value in ipairs( Entry ) do
            Value:Disconnect( )
        end

        Table3[ Key ] = nil
    end
    if Key.Character then
        New:unbindRoot( Key.Character )
    end
end

for Index, Value in ipairs( Players:GetPlayers( ) ) do
    task.spawn( PlayerAdded, Value )
end

Players.PlayerAdded:Connect( PlayerAdded )
Players.PlayerRemoving:Connect( PlayerRemoving )
