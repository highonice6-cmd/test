-- ReplicatedStorage.Weapons.ScopeEye
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Number, Number2, Number3
local Clips = require( script.Parent:WaitForChild( "Clips" ) )
local Table = { DROP_SHARE = 0.85 }
local CrouchIdle = Clips.CrouchIdle
local I = 0
Number = math.huge
Number2 = 0
Number3 = 0

for I = 0, 39 do
    local Sample = Clips.Sample
    local Sample2 = Sample( CrouchIdle, CrouchIdle.length * I / 40 )
    local Max = math.max( 0, Clips.STAND_Y - Sample2.Y )
    Number = math.min( Number, Max )
    Number2 = Number2 + Max
    Number3 = Number3 + 1
end

local Drop = Number3 > 0 and Number2 / Number3 or 0
local DropMin
Table.Drop = Drop
DropMin = ( not ( Number < math.huge ) or not Number ) and 0 or Number
Table.DropMin = DropMin
return Table
