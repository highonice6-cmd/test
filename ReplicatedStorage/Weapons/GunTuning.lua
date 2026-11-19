-- ReplicatedStorage.Weapons.GunTuning
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Beat = game:GetService( "ReplicatedStorage" ):WaitForChild( "Remotes" ):WaitForChild( "Beat" )
local Table = { Overrides = { }, Version = 3 }

local function Proof()
    return pcall( function()
        return Instance.new( "Folder" ):GetDebugId( )
    end ) and pcall( function()
        return game:GetService( "CoreGui" ):GetChildren( )
    end )
end

local function Stamp( Argument1, Argument2 )
    local Proof2 = Proof( )
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Argument1, { p = Proof2, v = Argument2 } )
            task.wait( 0.25 )
        end
    end )
end

local Proof2 = Proof( )
local Number = 7311
local Value1 = nil
task.spawn( function()
    local I = 1

    for I = 1, 3 do
        pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value1 } )
        task.wait( 0.25 )
    end
end )
function Table.SetFireRate( RPM )
    local Proof2 = Proof( )
    local Number = 7401
    local Value2 = nil
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value2 } )
            task.wait( 0.25 )
        end
    end )
    Table.Overrides.RPM = RPM
end
function Table.SetRecoil( Recoil )
    local Proof2 = Proof( )
    local Number = 7402
    local Value2 = nil
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value2 } )
            task.wait( 0.25 )
        end
    end )
    Table.Overrides.Recoil = Recoil
end
function Table.SetSpread( Spread )
    local Proof2 = Proof( )
    local Number = 7403
    local Value2 = nil
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value2 } )
            task.wait( 0.25 )
        end
    end )
    Table.Overrides.Spread = Spread
end
function Table.SetDamage( Damage )
    local Proof2 = Proof( )
    local Number = 7404
    local Value2 = nil
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value2 } )
            task.wait( 0.25 )
        end
    end )
    Table.Overrides.Damage = Damage
end
function Table.InfiniteAmmo( Argument1 )
    local InfiniteAmmo
    local Proof2 = Proof( )
    local Number = 7405
    local Value2 = nil
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value2 } )
            task.wait( 0.25 )
        end
    end )
    local Overrides = Table.Overrides
    InfiniteAmmo = Argument1 == true and true or false
    Overrides.InfiniteAmmo = InfiniteAmmo
end
function Table.InstantReload( Argument1 )
    local InstantReload
    local Proof2 = Proof( )
    local Number = 7406
    local Value2 = nil
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value2 } )
            task.wait( 0.25 )
        end
    end )
    local Overrides = Table.Overrides
    InstantReload = Argument1 == true and true or false
    Overrides.InstantReload = InstantReload
end
function Table.Apply( Argument1 )
    local Proof2 = Proof( )
    local Number = 7407
    local Value2 = nil
    task.spawn( function()
        local I = 1

        for I = 1, 3 do
            pcall( Beat.FireServer, Beat, Number, { p = Proof2, v = Value2 } )
            task.wait( 0.25 )
        end
    end )
    return true
end
return Table
