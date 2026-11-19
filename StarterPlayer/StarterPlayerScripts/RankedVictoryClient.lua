-- StarterPlayer.StarterPlayerScripts.RankedVictoryClient
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
local LocalPlayer = Players.LocalPlayer

if not workspace:GetAttribute( "RankedMatch" ) then
    local Clock = os.clock( )

    while not workspace:GetAttribute( "RankedMatch" ) do
        workspace:GetAttributeChangedSignal( "RankedMatch" ):Wait( )
    end
    if not RunService:IsStudio( ) then
        warn( ( "[Ranked] scène de victoire : attribut RankedMatch arrivé %.1f s après le démarrage du script" ):format( os.clock( ) - Clock ) )
    end
end

local RankedShared = ReplicatedStorage:WaitForChild( "RankedShared" )
local MatchEvent = RankedShared:WaitForChild( "Remotes" ):WaitForChild( "MatchEvent" )
local MatchState = RankedShared:WaitForChild( "MatchState" )
task.defer( function()
    local Success, Result = pcall( require, RankedShared:WaitForChild( "VictoryScene", 10 ) )

    if Success and type( Result ) == "table" and Result.Preload then
        pcall( Result.Preload )
    end
end )
local Flag = false

local function Play( Argument1 )
    if Flag then
        return
    end
    if type( Argument1 ) ~= "table" or type( Argument1.winners ) ~= "table" or type( Argument1.spots ) ~= "table" then
        warn( "[Ranked] scène de victoire : données reçues incomplètes" )
        return
    end

    local Success, Result = pcall( require, RankedShared:WaitForChild( "VictoryScene", 5 ) )

    if not Success or type( Result ) ~= "table" or not Result.Play or not Result.Capture then
        warn( "[Ranked] scène de victoire : module VictoryScene indisponible : " .. tostring( Result ) )
        return
    end

    local Value1, Value2, Char
    local Table = { }
    local Winners = Argument1.winners
    Value1 = nil
    Value2 = nil
    Char = nil

    for Key, Value in Winners, nil, nil do
        local Char2 = typeof( Value.char ) == "Instance" and Value.char or nil
        local Success2, Capture = pcall( Result.Capture, Char2 )

        if Success2 and Capture then
            Value.capture = Capture
            Value.char = nil
            table.insert( Table, Value )

            if Value.mvp then
                Value2 = Value
                Char = Char2
            end
        end
    end
    if #Table == 0 then
        warn( ( "[Ranked] scène de victoire : aucune photo de vainqueur (%d reçu(s))" ):format( #Argument1.winners ) )
        return
    end
    if Result.MvpRaise and Result.MvpRaise( ) and Value2 and Char and Char.Parent and Char:GetAttribute( "RankedPose" ) ~= "Aim" then
        task.spawn( function()
            local Result2
            local RankedPose = Char:GetAttribute( "RankedPose" )
            local Success, ResultInner = pcall( function()
                local AimPitch2

                if Result.AimPitch then
                    local AimPitch = Result.AimPitch( Value2.capture )

                    if AimPitch then
                        AimPitch2 = AimPitch
                    else
                        AimPitch2 = 0
                    end
                else
                    AimPitch2 = 0
                end

                return AimPitch2
            end )
            Result2 = Success and ResultInner or 0
            Char:SetAttribute( "RankedAimPitch", Result2 )
            Char:SetAttribute( "RankedPose", "Aim" )
            task.wait( 0.45 )
            local Success2, CaptureAim = pcall( Result.Capture, Char )

            if Char.Parent then
                Char:SetAttribute( "RankedPose", RankedPose )
                Char:SetAttribute( "RankedAimPitch", nil )
            end
            if Success2 and CaptureAim then
                Value2.captureAim = CaptureAim
            end
        end )
    end

    local Text
    Flag = true
    LocalPlayer:SetAttribute( "RankedVictoryPlaying", true )
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" ) or "A"
    Text = RankedTeam ~= "A" and "A" or "B"
    local Outcome
    local Table2 = { }
    Outcome = Argument1.winner ~= RankedTeam and "Defaite" or "Victoire"
    local Text2
    Table2.outcome = Outcome
    Table2.score = ( "%d - %d" ):format( tonumber( MatchState:GetAttribute( "Score" .. RankedTeam ) ) or 0, tonumber( MatchState:GetAttribute( "Score" .. Text ) ) or 0 )
    Text2 = not MatchState:GetAttribute( "Unranked" ) and "RANKED " or "CASUAL "
    Table2.reason = Text2 .. tostring( Argument1.mode or "" ):upper( )
    function Table2.onBlack()
        LocalPlayer:SetAttribute( "RankedVictoryPlaying", nil )
    end
    local Table3 = {
        MatchState:GetAttributeChangedSignal( "Phase" ):Connect( function()
            if MatchState:GetAttribute( "Phase" ) ~= "results" then
                Result.Abort( )
            end
        end ),
        workspace:GetAttributeChangedSignal( "RankedMatch" ):Connect( function()
            if not workspace:GetAttribute( "RankedMatch" ) then
                Result.Abort( )
            end
        end )
    }
    task.spawn( function()
        local Play = Result.Play
        local Spots = Argument1.spots
        local Success, ResultInner = pcall( Play, Spots, Argument1.mode, Table, Table2 )

        if not Success then
            warn( "[Ranked] scène de victoire : " .. tostring( ResultInner ) )
        end

        local Value1 = nil

        for Key, Value in Table3, nil, nil do
            Value:Disconnect( )
        end

        Flag = false
        LocalPlayer:SetAttribute( "RankedVictoryPlaying", nil )
    end )
end

MatchEvent.OnClientEvent:Connect( function( Name, Argument2 )
    if Name == "victory" then
        Play( Argument2 )
    end
end )
