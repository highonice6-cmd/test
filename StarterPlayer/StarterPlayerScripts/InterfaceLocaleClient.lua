-- StarterPlayer.StarterPlayerScripts.InterfaceLocaleClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local StarterGui = game:GetService( "StarterGui" )
local LocalPlayer = Players.LocalPlayer

if not game:IsLoaded( ) then
    game.Loaded:Wait( )
end
if StarterGui:GetAttribute( "CopieLocale" ) ~= true then
    return
end

local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Table = { }
local Table2 = { }

local function ARenouveler( Self )
    if Self:IsA( "LayerCollector" ) then
        return Self.ResetOnSpawn
    end
    return true
end

local function Copier( Argument1 )
    Argument1.Archivable = true
    local Success, Result = pcall( Argument1.Clone, Argument1 )

    if not Success or not Result then
        local Name = Argument1.Name
        warn( "[Interface] copie impossible : " .. Name .. " (" .. tostring( Result ) .. ")" )
        return nil
    end
    if Result:IsA( "LayerCollector" ) then
        Result.ResetOnSpawn = false
    end

    Result.Parent = PlayerGui
    return Result
end

local Value1 = nil

local function Apparition( Argument1 )
    if Argument1 == Value1 then
        return
    end

    local Value1Inner
    Value1 = Argument1
    Value1Inner = nil

    for Key, Value in Table, nil, nil do
        if Key.Parent ~= StarterGui then
            local ResetOnSpawn2

            if Key:IsA( "LayerCollector" ) then
                ResetOnSpawn2 = Key.ResetOnSpawn
            else
                ResetOnSpawn2 = true
            end
            if ResetOnSpawn2 then
                if Value.Parent then
                    Value:Destroy( )
                end

                Table[ Key ] = nil
            end
        end
    end
    for Key2, Value2 in StarterGui:GetChildren( ) do
        if Value2:GetAttribute( "CopieServeur" ) ~= true then
            local ResetOnSpawn
            local Entry = Table[ Value2 ]

            if Value2:IsA( "LayerCollector" ) then
                ResetOnSpawn = Value2.ResetOnSpawn
            else
                ResetOnSpawn = true
            end
            if ResetOnSpawn then
                if Entry and Entry.Parent then
                    Entry:Destroy( )
                end

                Table[ Value2 ] = nil
            elseif Table2[ Value2 ] then
                continue
            end

            Table2[ Value2 ] = true
            local FoundChild = PlayerGui:FindFirstChild( Value2.Name )

            if not FoundChild or FoundChild.ClassName ~= Value2.ClassName then
                Table[ Value2 ] = Copier( Value2 )
            end
        end
    end
end

LocalPlayer.CharacterAdded:Connect( Apparition )

if LocalPlayer.Character then
    Apparition( LocalPlayer.Character )
end
