-- ReplicatedStorage.Weapons.Holds
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Parent = script.Parent
local Config = require( Parent:WaitForChild( "Config" ) )
local WeaponData = require( Parent:WaitForChild( "WeaponData" ) )
local Table = {
    IsPistol = function( Key )
        local Flag

        if ( Key and WeaponData[ Key ] ) == nil then
            Flag = false
        elseif ( Key and WeaponData[ Key ] ).Handling.Pistol == true then
            Flag = true
        else
            Flag = false
        end

        return Flag
    end
}
function Table.Pose( Key, Name )
    if Table.IsPistol( Key ) then
        local PistolAim2

        if Name == "Aim" or Name == "ReloadAim" then
            local PistolAim = Config.Poses.PistolAim

            if PistolAim then
                PistolAim2 = PistolAim
            else
                PistolAim2 = nil
            end
        else
            PistolAim2 = nil
        end

        return PistolAim2
    end
    if not ( Key and WeaponData[ Key ] and ( Key and WeaponData[ Key ] ).Handling.Poses ) or not ( Key and WeaponData[ Key ] and ( Key and WeaponData[ Key ] ).Handling.Poses )[ Name ] or not Config.Poses[ ( Key and WeaponData[ Key ] and ( Key and WeaponData[ Key ] ).Handling.Poses )[ Name ] ] then
        return Config.Poses[ Name ]
    end
    return Config.Poses[ ( Key and WeaponData[ Key ] and ( Key and WeaponData[ Key ] ).Handling.Poses )[ Name ] ]
end
function Table.IsRocket( Key )
    local Flag

    if ( Key and WeaponData[ Key ] ) == nil then
        Flag = false
    elseif ( Key and WeaponData[ Key ] ).Handling.RocketReload == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
function Table.Free( Argument1, Name )
    local IsPistol2
    local IsPistol = Table.IsPistol( Argument1 )

    if IsPistol then
        if Name == "Aim" then
            IsPistol2 = false
        elseif Name == "ReloadAim" then
            IsPistol2 = false
        else
            IsPistol2 = true
        end
    else
        IsPistol2 = IsPistol
    end

    return IsPistol2
end
function Table.AimTwist( Argument1 )
    local Twist
    local Pose = Table.Pose( Argument1, "Aim" )
    Twist = Pose and Pose.Twist or 0
    return ( math.rad( Twist ) )
end
return Table
