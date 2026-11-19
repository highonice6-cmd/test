-- StarterPlayer.StarterPlayerScripts.NeutralFaceClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local LocalPlayer = Players.LocalPlayer
local Table = {
    "ChinRaiser",
    "ChinRaiserUpperLip",
    "Corrugator",
    "EyesLookDown",
    "EyesLookLeft",
    "EyesLookRight",
    "EyesLookUp",
    "FlatPucker",
    "Funneler",
    "JawDrop",
    "JawLeft",
    "JawRight",
    "LipPresser",
    "LipsTogether",
    "LowerLipSuck",
    "MouthLeft",
    "MouthRight",
    "Pucker",
    "TongueDown",
    "TongueOut",
    "TongueUp",
    "UpperLipSuck",
    "LeftBrowLowerer",
    "LeftCheekPuff",
    "LeftCheekRaiser",
    "LeftDimpler",
    "LeftEyeClosed",
    "LeftEyeUpperLidRaiser",
    "LeftInnerBrowRaiser",
    "LeftLipCornerDown",
    "LeftLipCornerPuller",
    "LeftLipStretcher",
    "LeftLowerLipDepressor",
    "LeftNoseWrinkler",
    "LeftOuterBrowRaiser",
    "LeftUpperLipRaiser",
    "RightBrowLowerer",
    "RightCheekPuff",
    "RightCheekRaiser",
    "RightDimpler",
    "RightEyeClosed",
    "RightEyeUpperLidRaiser",
    "RightInnerBrowRaiser",
    "RightLipCornerDown",
    "RightLipCornerPuller",
    "RightLipStretcher",
    "RightLowerLipDepressor",
    "RightNoseWrinkler",
    "RightOuterBrowRaiser",
    "RightUpperLipRaiser"
}

local function IsMood( Argument1, Object )
    local Mood
    local Animate = Object:FindFirstChild( "Animate" )

    if Animate then
        Mood = Animate:FindFirstChild( "mood" )
    else
        Mood = Animate
    end

    local Animation = Argument1.Animation

    if not Mood or not Animation then
        return false
    end
    if Animation:IsDescendantOf( Mood ) then
        return true
    end
    for Key, Value in Mood:GetChildren( ) do
        if Value:IsA( "Animation" ) then
            if Value.AnimationId == Animation.AnimationId then
                return true
            end
        end
    end

    return false
end

local function OnCharacter( Object2 )
    local Animator = Object2:WaitForChild( "Humanoid" ):WaitForChild( "Animator" )
    Animator.AnimationPlayed:Connect( function( Argument1 )
        if IsMood( Argument1, Object2 ) then
            Argument1:Stop( 0 )
        end
    end )

    for Key, Value in Animator:GetPlayingAnimationTracks( ) do
        if IsMood( Value, Object2 ) then
            Value:Stop( 0 )
        end
    end
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end

local OnScreen = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "OnScreen" ) )
RunService.Heartbeat:Connect( function()
    local CurrentCamera = workspace.CurrentCamera
    local Position = CurrentCamera.CFrame.Position
    local Clamp = math.clamp( CurrentCamera.FieldOfView / 70, 0.05, 1 )

    for Key, Value in Players:GetPlayers( ) do
        local Head
        local Character = Value.Character

        if Character then
            Head = Value.Character:FindFirstChild( "Head" )
        else
            Head = Character
        end
        if Head and Value ~= LocalPlayer then
            if ( Head.Position - Position ).Magnitude * Clamp > 60 or not OnScreen.Is( Value.Character ) then
                continue
            end
        end

        local FaceControls

        if Head then
            FaceControls = Head:FindFirstChildOfClass( "FaceControls" )
        else
            FaceControls = Head
        end
        if FaceControls then
            local Value1 = nil

            for Key2, Value2 in Table, nil, nil do
                if FaceControls[ Value2 ] ~= 0 then
                    FaceControls[ Value2 ] = 0
                end
            end
        end
    end
end )
