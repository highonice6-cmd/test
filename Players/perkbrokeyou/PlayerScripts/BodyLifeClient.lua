-- Players.perkbrokeyou.PlayerScripts.BodyLifeClient
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
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Config = require( Weapons:WaitForChild( "Config" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local BodyLife = require( Weapons:WaitForChild( "BodyLife" ) )
local Poignee = require( Weapons:WaitForChild( "Poignee" ) )
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Class = setmetatable( { }, { __mode = "k" } )

local function AddTo( Key, Argument2 )
    local Base
    local Entry = Class[ Key ]
    local Transform = Key.Transform
    Base = Entry and Transform == Entry.written and Entry.base or Transform
    local Transform2 = Argument2 * Base
    Key.Transform = Transform2

    if Entry then
        Entry.base = Base
        Entry.written = Transform2
        return
    end
    Class[ Key ] = { base = Base, written = Transform2 }
    return
end

local function IsArmed( Object )
    local Of
    local Tool = Object:FindFirstChildOfClass( "Tool" )

    if Tool then
        Of = Poignee.Of( Tool )
    else
        Of = Tool
    end

    local Flag

    if Of == nil then
        Flag = false
    elseif Of:FindFirstChild( "GunJoint" ) == nil then
        Flag = false
    else
        Flag = true
    end

    return Flag
end

local function IsAiming( Object )
    if Object == LocalPlayer.Character then
        local Flag = if ClientState.Stance == "Aim" then ClientState.Equipped else false
        return Flag
    end
    local Flag2
    local GunStance = Object:GetAttribute( "GunStance" )

    if GunStance == Config.StanceIds.Aim then
        Flag2 = true
    elseif GunStance == Config.StanceIds.ReloadAim then
        Flag2 = true
    else
        Flag2 = false
    end

    return Flag2
end

local Table = { }
local OnScreen = require( Weapons:WaitForChild( "OnScreen" ) )
RunService.PreAnimation:Connect( function( Argument1 )
    table.clear( Table )
    local Position = CurrentCamera.CFrame.Position

    for Key, Value in Players:GetPlayers( ) do
        local HumanoidRootPart
        local Character = Value.Character

        if Character then
            HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Character
        end
        if HumanoidRootPart and ( HumanoidRootPart.Position - Position ).Magnitude < 250 and OnScreen.Is( Character ) and not Character:GetAttribute( "DanceStart" ) then
            local Of
            local Tool = Character:FindFirstChildOfClass( "Tool" )

            if Tool then
                Of = Poignee.Of( Tool )
            else
                Of = Tool
            end

            local Flag

            if Of == nil then
                Flag = false
            elseif Of:FindFirstChild( "GunJoint" ) == nil then
                Flag = false
            else
                Flag = true
            end

            local Equipped
            local Update = BodyLife.Update

            if Flag then
                if Character == LocalPlayer.Character then
                    if ClientState.Stance == "Aim" then
                        Equipped = ClientState.Equipped
                    else
                        Equipped = false
                    end
                else
                    local GunStance = Character:GetAttribute( "GunStance" )

                    if GunStance == Config.StanceIds.Aim then
                        Equipped = true
                    elseif GunStance == Config.StanceIds.ReloadAim then
                        Equipped = true
                    else
                        Equipped = false
                    end
                end
            else
                Equipped = Flag
            end
            if Update( Character, Argument1, Equipped, Flag ) then
                Table[ Character ] = Flag
            end
        end
    end
end )
RunService.PreSimulation:Connect( function()
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        local Get = BodyLife.Get( Key )

        if Get then
            local Root
            local LowerTorso = Key:FindFirstChild( "LowerTorso" )

            if LowerTorso then
                Root = LowerTorso:FindFirstChild( "Root" )
            else
                Root = LowerTorso
            end
            if Root then
                local Base
                local Root2 = Get.root
                local Entry = Class[ Root ]
                local Transform = Root.Transform
                Base = Entry and Transform == Entry.written and Entry.base or Transform
                local Transform2 = Root2 * Base
                Root.Transform = Transform2

                if Entry then
                    Entry.base = Base
                    Entry.written = Transform2
                else
                    Class[ Root ] = { base = Base, written = Transform2 }
                end
            end
            if not Value then
                local Waist
                local UpperTorso = Key:FindFirstChild( "UpperTorso" )

                if UpperTorso then
                    Waist = UpperTorso:FindFirstChild( "Waist" )
                else
                    Waist = UpperTorso
                end
                if Waist then
                    local Base2
                    local Waist2 = Get.waist
                    local Entry2 = Class[ Waist ]
                    local Transform3 = Waist.Transform
                    Base2 = Entry2 and Transform3 == Entry2.written and Entry2.base or Transform3
                    local Transform4 = Waist2 * Base2
                    Waist.Transform = Transform4

                    if Entry2 then
                        Entry2.base = Base2
                        Entry2.written = Transform4
                    else
                        Class[ Waist ] = { base = Base2, written = Transform4 }
                    end
                end

                local Neck
                local Head = Key:FindFirstChild( "Head" )

                if Head then
                    Neck = Head:FindFirstChild( "Neck" )
                else
                    Neck = Head
                end
                if Neck then
                    local Base3
                    local Neck2 = Get.neck
                    local Entry3 = Class[ Neck ]
                    local Transform5 = Neck.Transform
                    Base3 = Entry3 and Transform5 == Entry3.written and Entry3.base or Transform5
                    local Transform6 = Neck2 * Base3
                    Neck.Transform = Transform6

                    if Entry3 then
                        Entry3.base = Base3
                        Entry3.written = Transform6
                    else
                        Class[ Neck ] = { base = Base3, written = Transform6 }
                    end
                end
            end
        end
    end
end )
