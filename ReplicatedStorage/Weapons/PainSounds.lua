-- ReplicatedStorage.Weapons.PainSounds
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return {
    Voices = {
        Female = {
            ids = {
                138342969298657,
                107974385512164,
                71719940575270,
                112659994701586,
                83896466626271
            },
            pain = { 1, 2, 3, 4, 5 },
            death = { 1, 2, 3, 4, 5 },
            gains = { 1.76, 1.33, 1.88, 0.49, 1.05 }
        },
        Male = {
            ids = {
                110363095834115,
                135710162488445,
                71784643631908,
                93723195457525,
                121148300913464
            },
            pain = { 1, 2, 3, 4 },
            death = { 1, 2, 3, 4, 5 },
            gains = { 0.82, 1.25, 1.62, 0.97, 0.67 }
        }
    },
    Default = "Male",
    ENTRY_GAP = 5,
    CHANCE = 0.3,
    MIN_GAP = 1.6,
    VOLUME = 3
}
