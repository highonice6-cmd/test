-- ReplicatedFirst.BlocageVR
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #5

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.VREnabled
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.VREnabled
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( function()
    return Upvalue1.VREnabled
end )
local Success2, Result2 = pcall( function()
    return Upvalue2.VREnabled
end )

if Success and Result == true then
    return true
end
if Success2 and Result2 == true then
    return true
end

local Captured

if Upvalue3 then
    if Upvalue4:GetAttribute( "TestVR" ) == true then
        Captured = true
    else
        Captured = false
    end
else
    Captured = Upvalue3
end

return Captured
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Upvalue2( ) then
    return
end
Upvalue1 = true
warn( "[BlocageVR] casque VR détecté : joueur renvoyé du jeu" )
Upvalue3:Kick( "VR headsets are not allowed in this game. Please rejoin without VR." )
return
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:GetPropertyChangedSignal( "VREnabled" ):Connect( Upvalue2 )
]]
