-- ReplicatedStorage.IntroCinematic
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local StarterGui = game:GetService( "StarterGui" )
local SoundService = game:GetService( "SoundService" )
local ContextActionService = game:GetService( "ContextActionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local Table = {
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.EmotesMenu,
    Enum.CoreGuiType.Health
}

local function Shot()
    local Cameras2
    local Cameras = workspace:FindFirstChild( "Cameras" )
    Cameras2 = if Cameras then Cameras else workspace
    local Depart
    local IntroCamera = Cameras2:FindFirstChild( "IntroCamera" )

    if IntroCamera then
        Depart = IntroCamera:FindFirstChild( "Depart" )
    else
        Depart = IntroCamera
    end

    local Fin

    if IntroCamera then
        Fin = IntroCamera:FindFirstChild( "Fin" )
    else
        Fin = IntroCamera
    end
    if not Depart or not Fin or not Depart:IsA( "BasePart" ) or not Fin:IsA( "BasePart" ) or IntroCamera:GetAttribute( "Actif" ) == false then
        return nil
    end
    return IntroCamera, Depart, Fin
end

local function Music()
    return SoundService:FindFirstChild( "TitleMusic" )
end

return {
    Enabled = function()
        local Flag = Shot( ) ~= nil and true or false
        return Flag
    end,
    ResumeMusic = function()
        local TitleMusic = SoundService:FindFirstChild( "TitleMusic" )

        if not TitleMusic or not TitleMusic:IsA( "Sound" ) then
            return
        end

        TitleMusic:SetAttribute( "Resumed", true )

        if TitleMusic.IsPlaying and TitleMusic.Volume > 0 then
            return
        end

        local MusicPart
        local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )

        if SPAWN_CHARACTER then
            MusicPart = SPAWN_CHARACTER:FindFirstChild( "MusicPart" )
        else
            MusicPart = SPAWN_CHARACTER
        end

        local SpawnMusic

        if MusicPart then
            SpawnMusic = MusicPart:FindFirstChild( "SpawnMusic" )
        else
            SpawnMusic = MusicPart
        end
        if SpawnMusic and SpawnMusic:IsA( "Sound" ) and SpawnMusic.IsPlaying and SpawnMusic.SoundId == TitleMusic.SoundId then
            pcall( function()
                TitleMusic.TimePosition = SpawnMusic.TimePosition
            end )
        end

        local Number = tonumber( TitleMusic:GetAttribute( "BaseVolume" ) ) or 0.5
        TitleMusic.Volume = 0

        if TitleMusic.IsPaused then
            TitleMusic:Resume( )
        elseif not TitleMusic.IsPlaying then
            TitleMusic:Play( )
        end

        TweenService:Create( TitleMusic, TweenInfo.new( 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out ), { Volume = Number } ):Play( )
    end,
    StopMusic = function( Amount )
        local TitleMusic = SoundService:FindFirstChild( "TitleMusic" )

        if not TitleMusic or not TitleMusic:IsA( "Sound" ) then
            return
        end
        local Create = TweenService:Create( TitleMusic, TweenInfo.new( Amount or 1.2 ), { Volume = 0 } )
        Create:Play( )
        Create.Completed:Connect( function()
            if TitleMusic.Parent then
                TitleMusic:Stop( )
                TitleMusic:Destroy( )
            end
        end )
        return
    end,
    Prepare = function()
        local Flag = false
        task.spawn( function()
            local Intro
            local Wardrobe = ReplicatedStorage:FindFirstChild( "Wardrobe" )

            if Wardrobe then
                Intro = Wardrobe:WaitForChild( "Intro", 2 )
            else
                Intro = Wardrobe
            end
            if Intro and Intro:IsA( "RemoteFunction" ) then
                pcall( Intro.InvokeServer, Intro )
            end

            Flag = true
        end )

        local function Callback()
            return Flag
        end

        return Callback
    end,
    Play = function( Argument1, Callback )
        local Value1, Value2, Value3 = Shot( )

        if not Value1 then
            return
        end

        local Value4
        local Max = math.max( 1, tonumber( Value1:GetAttribute( "Duree" ) ) or 5 )
        local FixedFOV = tonumber( Value1:GetAttribute( "FovDepart" ) ) or 70
        local Number = tonumber( Value1:GetAttribute( "FovFin" ) ) or 70
        local FixedCamera = Value2.CFrame
        local CFrame = Value3.CFrame
        ClientState.IntroCinematic = true
        ClientState.FixedCamera = FixedCamera
        ClientState.FixedFOV = FixedFOV
        local TableInner = { }
        Value4 = nil

        for Key, Value in Table, nil, nil do
            local Success, Result = pcall( StarterGui.GetCoreGuiEnabled, StarterGui, Value )

            if Success then
                TableInner[ Value ] = Result
                pcall( StarterGui.SetCoreGuiEnabled, StarterGui, Value, false )
            end
        end

        ContextActionService:BindActionAtPriority( "IntroCinematicBlock", function()
            return Enum.ContextActionResult.Sink
        end, false, 3000, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Z, Enum.KeyCode.Q, Enum.KeyCode.Space, Enum.KeyCode.ButtonA, Enum.KeyCode.Thumbstick1 )
        local Value5 = nil
        pcall( function()
            local PlayerModule
            local PlayerScripts = LocalPlayer:FindFirstChild( "PlayerScripts" )

            if PlayerScripts then
                PlayerModule = PlayerScripts:FindFirstChild( "PlayerModule" )
            else
                PlayerModule = PlayerScripts
            end
            if PlayerModule then
                Value5 = require( PlayerModule ):GetControls( )
                Value5:Disable( )
                return
            end
            return
        end )
        local RaycastParams2 = RaycastParams.new( )
        RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
        RaycastParams2.FilterDescendantsInstances = { Value1, workspace.CurrentCamera, LocalPlayer.Character }

        local function Loaded()
            local Flag = workspace:Raycast( Value3.Position, Value3.CFrame.LookVector * 80, RaycastParams2 ) ~= nil and true or false
            return Flag
        end

        local Clock = os.clock( )

        while Callback do
            if Callback( ) then
                break
            end

            local Flag
            local Position = Value3.Position
            Flag = workspace:Raycast( Position, Value3.CFrame.LookVector * 80, RaycastParams2 ) ~= nil and true or false

            if Flag or not ( os.clock( ) - Clock < 1.5 ) then
                break
            end

            task.wait( 0.05 )
        end

        local Clock2 = os.clock( )
        local Flag2 = false

        if Argument1 then
            Argument1.BackgroundTransparency = 0
            TweenService:Create( Argument1, TweenInfo.new( 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out ), { BackgroundTransparency = 1 } ):Play( )
        end

        RunService:BindToRenderStep( "IntroCinematic", Enum.RenderPriority.Camera.Value - 1, function()
            local Clamp = math.clamp( ( os.clock( ) - Clock2 ) / Max, 0, 1 )
            ClientState.FixedCamera = FixedCamera:Lerp( CFrame, Clamp )
            ClientState.FixedFOV = FixedFOV + ( Number - FixedFOV ) * Clamp

            if Argument1 and not Flag2 then
                local Clock = os.clock( ) - Clock2

                if Max - 0.6 <= Clock then
                    Flag2 = true
                    TweenService:Create( Argument1, TweenInfo.new( 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In ), { BackgroundTransparency = 0 } ):Play( )
                end
            end
        end )
        task.wait( Max )
        RunService:UnbindFromRenderStep( "IntroCinematic" )

        if Argument1 then
            Argument1.BackgroundTransparency = 0
        end

        local Value6
        ClientState.FixedCamera = nil
        ClientState.FixedFOV = nil
        Value6 = nil

        for Key2, Value7 in TableInner, nil, nil do
            pcall( StarterGui.SetCoreGuiEnabled, StarterGui, Key2, Value7 )
        end

        ContextActionService:UnbindAction( "IntroCinematicBlock" )

        if Value5 then
            pcall( Value5.Enable, Value5 )
        end

        ClientState.IntroCinematic = false
    end
}
