-- Players.perkbrokeyou.PlayerScripts.CombatTagClient
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
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
RunService.RenderStepped:Connect( function()
    local CombatUntil3
    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if CombatUntil then
        local CombatUntil2 = CombatUntil - workspace:GetServerTimeNow( )

        if CombatUntil2 then
            CombatUntil3 = CombatUntil2
        else
            CombatUntil3 = 0
        end
    else
        CombatUntil3 = 0
    end

    local InCombat = CombatUntil3 > 0 and true or false
    local TopRight
    ClientState.InCombat = InCombat
    local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

    if GlobalGui then
        TopRight = GlobalGui:FindFirstChild( "TopRight" )
    else
        TopRight = GlobalGui
    end

    local Combat

    if TopRight then
        Combat = TopRight:FindFirstChild( "Combat" )
    else
        Combat = TopRight
    end
    if not Combat then
        return
    end

    local Visible = if CombatUntil3 > 0 then not ClientState.Spectating else false
    Combat.Visible = Visible

    if CombatUntil3 > 0 then
        local Timer = Combat.Timer
        Timer.Text = tostring( ( math.ceil( CombatUntil3 ) ) )
    end
end )
