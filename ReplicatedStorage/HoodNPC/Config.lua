-- ReplicatedStorage.HoodNPC.Config
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return {
    Live = true,
    TestSpawnAt = nil,
    MaxAlive = 10,
    PoolSize = 12,
    MaxCorpses = 10,
    SpawnEvery = 4,
    SpawnMin = 45,
    SpawnMax = 75,
    SpawnZones = {
        "Structures.Structure_004.Structure_004_Grass_01",
        "Ground.Grass.Roads_Grass_08",
        {
            "Buildings.RemoteWarehouse.Structure.Floors.RemoteWarehouse_WAREFLOOR02_VAULT",
            indoor = true
        }
    },
    DespawnDist = 170,
    Health = 60,
    Speed = 15,
    AttackRange = 4.5,
    AttackCooldown = 1.2,
    AttackDamage = 12,
    UpGrace = 2,
    CorpseTime = 60,
    LootCash = { 1500, 1500 },
    Weapons = {
        { key = "Knife", w = 30, mult = 0.65, rarity = "Common" },
        { key = "BrokenBottle", w = 18, mult = 0.65, rarity = "Common" },
        { key = "Baton", w = 14, mult = 0.9, rarity = "Uncommon" },
        { key = "MetalPipe", w = 12, mult = 0.9, rarity = "Uncommon" },
        { key = "Crowbar", w = 9, mult = 1.4, rarity = "Rare" },
        { key = "Shovel", w = 7, mult = 1.4, rarity = "Rare" },
        { key = "Batte", w = 4.5, mult = 2.2, rarity = "Epic" },
        { key = "Bayonneta", w = 3.5, mult = 2.2, rarity = "Epic" },
        { key = "BrassKnuckle", w = 1.7, mult = 4, rarity = "Legendary" }
    },
    FarmCash = { { w = 100, min = 1500, max = 1500 } }
}
