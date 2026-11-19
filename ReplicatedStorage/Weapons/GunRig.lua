-- ReplicatedStorage.Weapons.GunRig
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    RemoveDefaultGrip = function( Self )
        if Self.Name ~= "RightGrip" or not Self:IsA( "JointInstance" ) then
            return
        end

        local Part1 = Self.Part1

        if Part1 and Part1:FindFirstChild( "GunJoint" ) then
            Self:Destroy( )
        end
    end
}
function Table.CleanGrips( Self )
    local RightArm
    local RightHand = Self:FindFirstChild( "RightHand" )

    if RightHand then
        RightArm = RightHand
    else
        RightArm = Self:FindFirstChild( "Right Arm" )
    end
    if not RightArm then
        return
    end
    for Key, Value in RightArm:GetChildren( ) do
        Table.RemoveDefaultGrip( Value )
    end
end
return Table
