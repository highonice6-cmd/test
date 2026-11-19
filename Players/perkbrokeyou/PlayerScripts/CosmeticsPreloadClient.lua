-- Players.perkbrokeyou.PlayerScripts.CosmeticsPreloadClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Tracer2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ContentProvider = game:GetService( "ContentProvider" )
local Cosmetics = require( ReplicatedStorage:WaitForChild( "Cosmetics" ) )
local LocalPlayer = Players.LocalPlayer
local Table = { }
local Tracer = Cosmetics.Items.Tracer
Tracer2 = if Tracer then Tracer else { }
local Value1 = nil

for Key, Value in Tracer2, nil, nil do
    if type( Value.Template ) == "string" then
        Table[ Value.id ] = Value.Template
    end
end

local Flag2
local Class = setmetatable( { }, { __mode = "k" } )

local function Preload( Key )
    if not Key or Class[ Key ] then
        return
    end
    Class[ Key ] = true
    task.spawn( function()
        if not pcall( ContentProvider.PreloadAsync, ContentProvider, { Key } ) then
            Class[ Key ] = nil
        end
    end )
    return
end

local function KillModel( Name )
    local FoundChild
    local KillFX = ReplicatedStorage:FindFirstChild( "KillFX" )
    FoundChild = KillFX and type( Name ) == "string" and KillFX:FindFirstChild( Name ) or nil
    return FoundChild
end

local function TracerModel( ModelName )
    local Entry = Table[ ModelName ]

    if not Entry then
        return nil
    end

    local FX = ReplicatedStorage:FindFirstChild( "FX" )

    for Value in string.gmatch( Entry, "[^%.]+" ) do
        local FX2 = if FX then FX:FindFirstChild( Value ) else FX
        FX = FX2
    end

    return FX
end

local function SkyModel()
    local SkyData
    local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui then
        SkyData = PlayerGui:FindFirstChild( "SkyData" )
    else
        SkyData = PlayerGui
    end

    local FoundChild2

    if not SkyData or not SkyFX then
        FoundChild2 = nil
    else
        local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

        if FoundChild then
            FoundChild2 = FoundChild
        else
            FoundChild2 = nil
        end
    end

    return FoundChild2
end

local function ForPlayer( Self )
    local FoundChild
    local KillFX = Self:GetAttribute( "KillFX" )
    local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
    FoundChild = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

    if FoundChild then
        if not Class[ FoundChild ] then
            Class[ FoundChild ] = true
            task.spawn( function()
                if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild } ) then
                    Class[ FoundChild ] = nil
                end
            end )
        end
    end

    local TracerModel2 = TracerModel( Self:GetAttribute( "TracerFX" ) )

    if TracerModel2 then
        if Class[ TracerModel2 ] then
            return
        end

        Class[ TracerModel2 ] = true
        task.spawn( function()
            if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                Class[ TracerModel2 ] = nil
            end
        end )
    end
end

local function All()
    for Key, Value in Players:GetPlayers( ) do
        local FoundChild3
        local KillFX = Value:GetAttribute( "KillFX" )
        local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
        FoundChild3 = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

        if FoundChild3 then
            if not Class[ FoundChild3 ] then
                Class[ FoundChild3 ] = true
                task.spawn( function()
                    if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild3 } ) then
                        Class[ FoundChild3 ] = nil
                    end
                end )
            end
        end

        local TracerModel2 = TracerModel( Value:GetAttribute( "TracerFX" ) )

        if TracerModel2 then
            if not Class[ TracerModel2 ] then
                Class[ TracerModel2 ] = true
                task.spawn( function()
                    if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                        Class[ TracerModel2 ] = nil
                    end
                end )
            end
        end
    end

    local SkyData
    local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
    local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if PlayerGui then
        SkyData = PlayerGui:FindFirstChild( "SkyData" )
    else
        SkyData = PlayerGui
    end

    local FoundChild2

    if not SkyData or not SkyFX then
        FoundChild2 = nil
    else
        local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

        if FoundChild then
            FoundChild2 = FoundChild
        else
            FoundChild2 = nil
        end
    end
    if FoundChild2 then
        if Class[ FoundChild2 ] then
            return
        end

        Class[ FoundChild2 ] = true
        task.spawn( function()
            if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild2 } ) then
                Class[ FoundChild2 ] = nil
            end
        end )
    end
end

local Flag = false

local function Soon()
    if Flag then
        return
    end
    Flag = true
    task.delay( 0.5, function()
        Flag = false

        for Key, Value in Players:GetPlayers( ) do
            local FoundChild3
            local KillFX = Value:GetAttribute( "KillFX" )
            local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
            FoundChild3 = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

            if FoundChild3 then
                if not Class[ FoundChild3 ] then
                    Class[ FoundChild3 ] = true
                    task.spawn( function()
                        if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild3 } ) then
                            Class[ FoundChild3 ] = nil
                        end
                    end )
                end
            end

            local TracerModel2 = TracerModel( Value:GetAttribute( "TracerFX" ) )

            if TracerModel2 then
                if not Class[ TracerModel2 ] then
                    Class[ TracerModel2 ] = true
                    task.spawn( function()
                        if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                            Class[ TracerModel2 ] = nil
                        end
                    end )
                end
            end
        end

        local SkyData
        local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

        if PlayerGui then
            SkyData = PlayerGui:FindFirstChild( "SkyData" )
        else
            SkyData = PlayerGui
        end

        local FoundChild2

        if not SkyData or not SkyFX then
            FoundChild2 = nil
        else
            local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

            if FoundChild then
                FoundChild2 = FoundChild
            else
                FoundChild2 = nil
            end
        end
        if FoundChild2 then
            if Class[ FoundChild2 ] then
                return
            end

            Class[ FoundChild2 ] = true
            task.spawn( function()
                if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild2 } ) then
                    Class[ FoundChild2 ] = nil
                end
            end )
        end
    end )
    return
end

local function WatchPlayer( Self )
    Self:GetAttributeChangedSignal( "KillFX" ):Connect( Soon )
    Self:GetAttributeChangedSignal( "TracerFX" ):Connect( Soon )

    if Flag then
        return
    end
    Flag = true
    task.delay( 0.5, function()
        Flag = false

        for Key, Value in Players:GetPlayers( ) do
            local FoundChild3
            local KillFX = Value:GetAttribute( "KillFX" )
            local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
            FoundChild3 = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

            if FoundChild3 then
                if not Class[ FoundChild3 ] then
                    Class[ FoundChild3 ] = true
                    task.spawn( function()
                        if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild3 } ) then
                            Class[ FoundChild3 ] = nil
                        end
                    end )
                end
            end

            local TracerModel2 = TracerModel( Value:GetAttribute( "TracerFX" ) )

            if TracerModel2 then
                if not Class[ TracerModel2 ] then
                    Class[ TracerModel2 ] = true
                    task.spawn( function()
                        if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                            Class[ TracerModel2 ] = nil
                        end
                    end )
                end
            end
        end

        local SkyData
        local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

        if PlayerGui then
            SkyData = PlayerGui:FindFirstChild( "SkyData" )
        else
            SkyData = PlayerGui
        end

        local FoundChild2

        if not SkyData or not SkyFX then
            FoundChild2 = nil
        else
            local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

            if FoundChild then
                FoundChild2 = FoundChild
            else
                FoundChild2 = nil
            end
        end
        if FoundChild2 then
            if Class[ FoundChild2 ] then
                return
            end

            Class[ FoundChild2 ] = true
            task.spawn( function()
                if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild2 } ) then
                    Class[ FoundChild2 ] = nil
                end
            end )
        end
    end )
    return
end

Players.PlayerAdded:Connect( WatchPlayer )
Flag2 = Flag

for Key2, Value2 in Players:GetPlayers( ) do
    Value2:GetAttributeChangedSignal( "KillFX" ):Connect( Soon )
    Value2:GetAttributeChangedSignal( "TracerFX" ):Connect( Soon )

    if not Flag2 then
        Flag = true
        task.delay( 0.5, function()
            Flag = false

            for Key, Value in Players:GetPlayers( ) do
                local FoundChild3
                local KillFX = Value:GetAttribute( "KillFX" )
                local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
                FoundChild3 = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

                if FoundChild3 then
                    if not Class[ FoundChild3 ] then
                        Class[ FoundChild3 ] = true
                        task.spawn( function()
                            if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild3 } ) then
                                Class[ FoundChild3 ] = nil
                            end
                        end )
                    end
                end

                local TracerModel2 = TracerModel( Value:GetAttribute( "TracerFX" ) )

                if TracerModel2 then
                    if not Class[ TracerModel2 ] then
                        Class[ TracerModel2 ] = true
                        task.spawn( function()
                            if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                                Class[ TracerModel2 ] = nil
                            end
                        end )
                    end
                end
            end

            local SkyData
            local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
            local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

            if PlayerGui then
                SkyData = PlayerGui:FindFirstChild( "SkyData" )
            else
                SkyData = PlayerGui
            end

            local FoundChild2

            if not SkyData or not SkyFX then
                FoundChild2 = nil
            else
                local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

                if FoundChild then
                    FoundChild2 = FoundChild
                else
                    FoundChild2 = nil
                end
            end
            if FoundChild2 then
                if Class[ FoundChild2 ] then
                    return
                end

                Class[ FoundChild2 ] = true
                task.spawn( function()
                    if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild2 } ) then
                        Class[ FoundChild2 ] = nil
                    end
                end )
            end
        end )
        Flag2 = Flag
    end
end

LocalPlayer:GetAttributeChangedSignal( "SkyFX" ):Connect( Soon )
task.spawn( function()
    local KillFX = ReplicatedStorage:WaitForChild( "KillFX", 60 )

    if KillFX then
        KillFX.ChildAdded:Connect( Soon )
    end
end )
task.spawn( function()
    local Tracers
    local FX = ReplicatedStorage:WaitForChild( "FX", 60 )

    if FX then
        Tracers = FX:WaitForChild( "Tracers", 60 )
    else
        Tracers = FX
    end
    if Tracers then
        Tracers.ChildAdded:Connect( Soon )
    end
end )
task.spawn( function()
    local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )

    local function Hook( Argument1 )
        Argument1.ChildAdded:Connect( Soon )

        if Flag2 then
            return
        end
        Flag2 = true
        task.delay( 0.5, function()
            Flag2 = false

            for Key, Value in Players:GetPlayers( ) do
                local FoundChild3
                local KillFX = Value:GetAttribute( "KillFX" )
                local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
                FoundChild3 = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

                if FoundChild3 then
                    if not Class[ FoundChild3 ] then
                        Class[ FoundChild3 ] = true
                        task.spawn( function()
                            if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild3 } ) then
                                Class[ FoundChild3 ] = nil
                            end
                        end )
                    end
                end

                local TracerModel2 = TracerModel( Value:GetAttribute( "TracerFX" ) )

                if TracerModel2 then
                    if not Class[ TracerModel2 ] then
                        Class[ TracerModel2 ] = true
                        task.spawn( function()
                            if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                                Class[ TracerModel2 ] = nil
                            end
                        end )
                    end
                end
            end

            local SkyData
            local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
            local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

            if PlayerGui then
                SkyData = PlayerGui:FindFirstChild( "SkyData" )
            else
                SkyData = PlayerGui
            end

            local FoundChild2

            if not SkyData or not SkyFX then
                FoundChild2 = nil
            else
                local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

                if FoundChild then
                    FoundChild2 = FoundChild
                else
                    FoundChild2 = nil
                end
            end
            if FoundChild2 then
                if Class[ FoundChild2 ] then
                    return
                end

                Class[ FoundChild2 ] = true
                task.spawn( function()
                    if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild2 } ) then
                        Class[ FoundChild2 ] = nil
                    end
                end )
            end
        end )
        return
    end

    local SkyData = PlayerGui:FindFirstChild( "SkyData" )

    if SkyData then
        SkyData.ChildAdded:Connect( Soon )

        if not Flag2 then
            Flag2 = true
            task.delay( 0.5, function()
                Flag2 = false

                for Key, Value in Players:GetPlayers( ) do
                    local FoundChild3
                    local KillFX = Value:GetAttribute( "KillFX" )
                    local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
                    FoundChild3 = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

                    if FoundChild3 then
                        if not Class[ FoundChild3 ] then
                            Class[ FoundChild3 ] = true
                            task.spawn( function()
                                if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild3 } ) then
                                    Class[ FoundChild3 ] = nil
                                end
                            end )
                        end
                    end

                    local TracerModel2 = TracerModel( Value:GetAttribute( "TracerFX" ) )

                    if TracerModel2 then
                        if not Class[ TracerModel2 ] then
                            Class[ TracerModel2 ] = true
                            task.spawn( function()
                                if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                                    Class[ TracerModel2 ] = nil
                                end
                            end )
                        end
                    end
                end

                local SkyData
                local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
                local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                if PlayerGui then
                    SkyData = PlayerGui:FindFirstChild( "SkyData" )
                else
                    SkyData = PlayerGui
                end

                local FoundChild2

                if not SkyData or not SkyFX then
                    FoundChild2 = nil
                else
                    local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

                    if FoundChild then
                        FoundChild2 = FoundChild
                    else
                        FoundChild2 = nil
                    end
                end
                if FoundChild2 then
                    if Class[ FoundChild2 ] then
                        return
                    end

                    Class[ FoundChild2 ] = true
                    task.spawn( function()
                        if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild2 } ) then
                            Class[ FoundChild2 ] = nil
                        end
                    end )
                end
            end )
        end
    end

    PlayerGui.ChildAdded:Connect( function( Argument1 )
        if Argument1.Name == "SkyData" then
            Argument1.ChildAdded:Connect( Soon )

            if Flag2 then
                return
            end

            Flag2 = true
            task.delay( 0.5, function()
                Flag2 = false

                for Key, Value in Players:GetPlayers( ) do
                    local FoundChild3
                    local KillFX = Value:GetAttribute( "KillFX" )
                    local KillFX2 = ReplicatedStorage:FindFirstChild( "KillFX" )
                    FoundChild3 = KillFX2 and type( KillFX ) == "string" and KillFX2:FindFirstChild( KillFX ) or nil

                    if FoundChild3 then
                        if not Class[ FoundChild3 ] then
                            Class[ FoundChild3 ] = true
                            task.spawn( function()
                                if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild3 } ) then
                                    Class[ FoundChild3 ] = nil
                                end
                            end )
                        end
                    end

                    local TracerModel2 = TracerModel( Value:GetAttribute( "TracerFX" ) )

                    if TracerModel2 then
                        if not Class[ TracerModel2 ] then
                            Class[ TracerModel2 ] = true
                            task.spawn( function()
                                if not pcall( ContentProvider.PreloadAsync, ContentProvider, { TracerModel2 } ) then
                                    Class[ TracerModel2 ] = nil
                                end
                            end )
                        end
                    end
                end

                local SkyData
                local SkyFX = LocalPlayer:GetAttribute( "SkyFX" )
                local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                if PlayerGui then
                    SkyData = PlayerGui:FindFirstChild( "SkyData" )
                else
                    SkyData = PlayerGui
                end

                local FoundChild2

                if not SkyData or not SkyFX then
                    FoundChild2 = nil
                else
                    local FoundChild = SkyData:FindFirstChild( ( tostring( SkyFX ) ) )

                    if FoundChild then
                        FoundChild2 = FoundChild
                    else
                        FoundChild2 = nil
                    end
                end
                if FoundChild2 then
                    if Class[ FoundChild2 ] then
                        return
                    end

                    Class[ FoundChild2 ] = true
                    task.spawn( function()
                        if not pcall( ContentProvider.PreloadAsync, ContentProvider, { FoundChild2 } ) then
                            Class[ FoundChild2 ] = nil
                        end
                    end )
                end
            end )
        end
    end )
end )
