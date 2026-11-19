-- StarterPlayer.StarterPlayerScripts.SewerReverbClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local SoundService = game:GetService( "SoundService" )
local AmbientReverb = SoundService.AmbientReverb
local Table = { Decay = 0.9, Wet = -22 }

if not workspace:FindFirstChild( "Map" ) and workspace:GetAttribute( "RankedMatch" ) then
    return
end

local Flag
local Sewers = workspace:WaitForChild( "Map" ):WaitForChild( "Sewers" )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Include
RaycastParams2.FilterDescendantsInstances = { Sewers }

local function InSewer( Argument1 )
    for Key, Value in Sewers:GetChildren( ) do
        local ZoneMin = Value:GetAttribute( "ZoneMin" )
        local ZoneMax = Value:GetAttribute( "ZoneMax" )

        if typeof( ZoneMin ) == "Vector3" and typeof( ZoneMax ) == "Vector3" and ZoneMin.X - 2 < Argument1.X and Argument1.X < ZoneMax.X + 2 and ZoneMin.Y - 2 < Argument1.Y and Argument1.Y < ZoneMax.Y + 2 and ZoneMin.Z - 2 < Argument1.Z and Argument1.Z < ZoneMax.Z + 2 then
            if workspace:Raycast( Argument1, Vector3.new( 0, 60, 0 ), RaycastParams2 ) then
                return true
            end
        end
    end

    return false
end

local function SetGunReverb( Reverb )
    for Key, Value in SoundService:GetDescendants( ) do
        if Value:IsA( "SoundGroup" ) and Value.Name:sub( 1, 6 ) == "GunFX_" and Value:FindFirstChildOfClass( "ReverbSoundEffect" ) then
            if Value:FindFirstChildOfClass( "ReverbSoundEffect" ):GetAttribute( "OrigDecay" ) == nil then
                Value:FindFirstChildOfClass( "ReverbSoundEffect" ):SetAttribute( "OrigDecay", Value:FindFirstChildOfClass( "ReverbSoundEffect" ).DecayTime )
                Value:FindFirstChildOfClass( "ReverbSoundEffect" ):SetAttribute( "OrigWet", Value:FindFirstChildOfClass( "ReverbSoundEffect" ).WetLevel )
            end
            if Reverb then
                Value:FindFirstChildOfClass( "ReverbSoundEffect" ).DecayTime = 0.9
                Value:FindFirstChildOfClass( "ReverbSoundEffect" ).WetLevel = -22
            else
                local DecayTime = Value:FindFirstChildOfClass( "ReverbSoundEffect" ):GetAttribute( "OrigDecay" )
                local WetLevel = Value:FindFirstChildOfClass( "ReverbSoundEffect" ):GetAttribute( "OrigWet" )
                Value:FindFirstChildOfClass( "ReverbSoundEffect" ).DecayTime = DecayTime
                Value:FindFirstChildOfClass( "ReverbSoundEffect" ).WetLevel = WetLevel
            end
        end
    end
end

Flag = false

while true do
    local InSewer3
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local InSewer2 = InSewer( CurrentCamera.CFrame.Position )

        if InSewer2 then
            InSewer3 = InSewer2
        else
            InSewer3 = false
        end
    else
        InSewer3 = false
    end
    if InSewer3 ~= Flag then
        SoundService.AmbientReverb = AmbientReverb
        Flag = InSewer3
    end
    if Flag then
        SetGunReverb( true )
    end
    if InSewer3 == false and Flag == false then
        SetGunReverb( false )
    end

    task.wait( 0.25 )
end
