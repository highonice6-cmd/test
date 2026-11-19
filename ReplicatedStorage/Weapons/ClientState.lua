-- ReplicatedStorage.Weapons.ClientState
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    Equipped = false,
    Aiming = false,
    Reloading = false,
    Sprinting = false,
    LastShot = 0,
    AimWalkSpeed = 12,
    AimFOV = 55,
    Combat = false,
    Stance = "Low",
    Shoulder = 1,
    CursorFree = false,
    GamepadNav = false,
    CamYaw = 0,
    CamPitch = 0
}
local Value1 = nil
function Table.RecoilKey()
    if Value1 then
        return Value1
    end

    local Clock = os.clock( )
    local RK = script:GetAttribute( "RK" )

    while type( RK ) ~= "string" do
        if not ( os.clock( ) - Clock < 10 ) then
            break
        end

        task.wait( 0.1 )

        if Value1 then
            return Value1
        end

        RK = script:GetAttribute( "RK" )
    end

    local Captured

    if Value1 then
        Captured = Value1
    elseif type( RK ) ~= "string" or not RK then
        Captured = "RecoilKick"
    else
        Captured = RK
    end

    Value1 = Captured
    return Value1
end
return Table
