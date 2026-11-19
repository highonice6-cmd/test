-- ReplicatedStorage.RankedShared.Sfx
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local SoundService = game:GetService( "SoundService" )
local TweenService = game:GetService( "TweenService" )
local ContentProvider = game:GetService( "ContentProvider" )
local Sons = script.Parent:WaitForChild( "Sons" )
local Table2 = { }
local Value1 = nil

local function GetFolder()
    if Value1 and Value1.Parent then
        return Value1
    end

    local RankedSfx2
    local RankedSfx = SoundService:FindFirstChild( "RankedSfx" )
    RankedSfx2 = if RankedSfx then RankedSfx else Instance.new( "Folder" )
    Value1 = RankedSfx2
    Value1.Name = "RankedSfx"
    Value1.Parent = SoundService
    return Value1
end

local function FadeOut( Key, Amount, Flag )
    Table2[ Key ] = nil

    if not Key.Parent then
        return
    end

    local TweenInfo3

    if Flag then
        local TweenInfo2 = TweenInfo.new( Amount or 0.35, Enum.EasingStyle.Linear )

        if TweenInfo2 then
            TweenInfo3 = TweenInfo2
        else
            TweenInfo3 = TweenInfo.new( Amount or 0.35 )
        end
    else
        TweenInfo3 = TweenInfo.new( Amount or 0.35 )
    end

    local Create = TweenService:Create( Key, TweenInfo3, { Volume = 0 } )
    Create.Completed:Once( function()
        Key:Destroy( )
    end )
    Create:Play( )
end

local function Start( Self, Argument2 )
    local Parent
    local Clone = Self:Clone( )
    Clone.Volume = Self.Volume * ( Argument2.volume or 1 )
    Clone.PlaybackSpeed = Self.PlaybackSpeed * ( Argument2.pitch or 1 )
    Clone.Looped = false

    if not Value1 or not Value1.Parent then
        local RankedSfx2
        local RankedSfx = SoundService:FindFirstChild( "RankedSfx" )
        RankedSfx2 = if RankedSfx then RankedSfx else Instance.new( "Folder" )
        Value1 = RankedSfx2
        Value1.Name = "RankedSfx"
        Value1.Parent = SoundService
        Parent = Value1
    else
        Parent = Value1
    end

    Clone.Parent = Parent
    Clone.TimePosition = tonumber( Self:GetAttribute( "Debut" ) ) or 0
    Clone:Play( )
    Table2[ Clone ] = true
    Clone.Ended:Once( function()
        Table2[ Clone ] = nil
        Clone:Destroy( )
    end )
    local Number = tonumber( Self:GetAttribute( "Fin" ) )
    local Number2 = tonumber( Self:GetAttribute( "Fondu" ) )

    if Number then
        task.delay( Number / Clone.PlaybackSpeed, function()
            if Table2[ Clone ] then
                local Captured2

                if Number2 then
                    local Captured = Number2 / Clone.PlaybackSpeed

                    if Captured then
                        Captured2 = Captured
                    else
                        Captured2 = 0.35
                    end
                else
                    Captured2 = 0.35
                end

                local Flag = Number2 ~= nil and true or false
                FadeOut( Clone, Captured2, Flag )
            end
        end )
    end

    task.delay( 15, function()
        if Clone.Parent then
            Table2[ Clone ] = nil
            Clone:Destroy( )
        end
    end )
    return Clone
end

local function Play( Name, Argument2 )
    local FoundChild = Sons:FindFirstChild( Name )

    if not FoundChild or not FoundChild:IsA( "Sound" ) or FoundChild.SoundId == "" then
        return nil
    end
    if not ( Argument2 or { } ).delay or not ( ( Argument2 or { } ).delay > 0 ) then
        return ( Start( FoundChild, Argument2 or { } ) )
    end
    task.delay( ( Argument2 or { } ).delay, Start, FoundChild, Argument2 or { } )
    return nil
end

local function StopAll( Amount )
    local Value1 = nil

    for Value in Table2, nil, nil do
        FadeOut( Value, Amount )
    end
end

local Flag = false
local Table = {
    Play = Play,
    StopAll = StopAll,
    Preload = function( List )
        if List then
            local Value1
            local Table = { }
            Value1 = nil

            for Key, Value in List, nil, nil do
                local FoundChild = Sons:FindFirstChild( Value )

                if FoundChild then
                    table.insert( Table, FoundChild )
                end
            end

            task.spawn( function()
                pcall( ContentProvider.PreloadAsync, ContentProvider, Table )
            end )
            return
        end
        if Flag then
            return
        end
        Flag = true
        task.spawn( function()
            local PreloadAsync = ContentProvider.PreloadAsync
            pcall( PreloadAsync, ContentProvider, Sons:GetChildren( ) )
        end )
        return
    end
}
return Table
