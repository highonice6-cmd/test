-- ReplicatedStorage.Weapons.AnimLibrary
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Table = {
    Ids = {
        [ "Rifle Idle" ] = "",
        [ "Rifle Aiming Idle" ] = "",
        [ "Rifle Run (NoAim)" ] = "",
        [ "Rifle Run" ] = "",
        [ "Rifle Walk" ] = "",
        [ "Run Left" ] = "",
        [ "Run Right" ] = "",
        [ "Run Forward Left" ] = "",
        [ "Run Forward Right" ] = "",
        [ "Run Backward Left" ] = "",
        [ "Run Backward Right" ] = "",
        [ "Walk Left" ] = "",
        [ "Walk Right" ] = "",
        [ "Walk Forward Left" ] = "",
        [ "Walk Forward Right" ] = "",
        [ "Walk Backward Left" ] = "",
        [ "Walk Backward Right" ] = ""
    }
}
local Table2 = { }
function Table.Get( Name )
    if Table2[ Name ] then
        return Table2[ Name ]
    end

    local RegisterKeyframeSequence
    local Entry = Table.Ids[ Name ]

    if not Entry or Entry == "" then
        if RunService:IsStudio( ) then
            local FoundChild
            local Animations = ReplicatedStorage:FindFirstChild( "Animations" )

            if Animations then
                FoundChild = Animations:FindFirstChild( Name, true )
            else
                FoundChild = Animations
            end
            if FoundChild then
                RegisterKeyframeSequence = game:GetService( "KeyframeSequenceProvider" ):RegisterKeyframeSequence( FoundChild )
            else
                RegisterKeyframeSequence = Entry
            end
        else
            RegisterKeyframeSequence = Entry
        end
    else
        RegisterKeyframeSequence = Entry
    end
    if not RegisterKeyframeSequence or RegisterKeyframeSequence == "" then
        warn( "Animation non publiée :", Name )
        return nil
    end

    local AnimationId
    local Animation = Instance.new( "Animation" )
    Animation.Name = "RifleLoco"
    AnimationId = RegisterKeyframeSequence:match( "^%d+$" ) and "rbxassetid://" .. RegisterKeyframeSequence or RegisterKeyframeSequence
    Animation.AnimationId = AnimationId
    Table2[ Name ] = Animation
    return Animation
end
return Table
