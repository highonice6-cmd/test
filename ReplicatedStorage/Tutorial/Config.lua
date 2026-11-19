-- ReplicatedStorage.Tutorial.Config
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return {
    Steps = {
        {
            Id = "roll1",
            Title = "GET YOUR FIRST GUN",
            Desc = "Step on the <b>red circle</b>",
            Banner = "WELCOME TO THE CITY",
            BannerSub = "First things first: get strapped"
        },
        {
            Id = "fight1",
            Title = "THEY'RE COMING",
            Desc = "Every kill pays <b>cash</b>",
            Banner = "OPPS OUTSIDE",
            BannerSub = "Kill them and take their cash"
        },
        {
            Id = "roll2",
            Title = "UPGRADE YOUR GUN",
            Desc = "Back to the <b>red circle</b>",
            Banner = "BAG SECURED",
            BannerSub = "Spend it on a better gun"
        },
        {
            Id = "fight2",
            Title = "FINISH THEM",
            Desc = "",
            Banner = "THEY CALLED BACKUP",
            BannerSub = "Show them who runs this block"
        }
    },
    DoneBanner = "YOU'RE ONE OF US",
    DoneSub = "The streets are yours. Watch your back.",
    Version = 3,
    StudioAlways = true,
    Rolls = {
        roll1 = { Case = "Basic", Weapon = "MP5", Free = true },
        roll2 = { Case = "Normal", Weapon = "AK", Free = false, Cost = 10000 }
    },
    Fights = {
        fight1 = { MaxAlive = 4, SpawnEvery = 2.5, BodyCash = 3000 },
        fight2 = { MaxAlive = 5, SpawnEvery = 2, BodyCash = 500, Kills = 6 }
    },
    CashGoal = 10000,
    RegenPerTick = 6,
    RegenDelay = 3.5,
    CaseStation = "WeaponStation",
    CaseStationPos = Vector3.new( -73.5, 17.600000381469727, 904 ),
    ShopSpawn = CFrame.lookAt( Vector3.new( -78, 17.600000381469727, 884 ), Vector3.new( -74, 17.600000381469727, 904 ) ),
    ShopExitSpawn = CFrame.lookAt( Vector3.new( -79, 17.600000381469727, 882 ), Vector3.new( -79, 17.600000381469727, 860 ) ),
    ShopExitPos = Vector3.new( -79, 17.600000381469727, 868 ),
    ShopBox = {
        CFrame = CFrame.new( -79, 25, 899 ),
        Size = Vector3.new( 62, 30, 54 )
    },
    ArenaBox = {
        CFrame = CFrame.new( -75, 30, 852 ),
        Size = Vector3.new( 150, 50, 136 )
    },
    ArenaSpawnMin = 30,
    ArenaSpawnMax = 70,
    BotBox = {
        CFrame = CFrame.new( -85, 20, 800 ),
        Size = Vector3.new( 220, 30, 132 )
    },
    BotDoorGap = 22,
    BotMaxDist = 90,
    BotReach = 150,
    FightZoneHint = 100,
    BotHealth = { 40, 60 },
    BotArmor = 10,
    OutTime = 1.5,
    CaseRevealTime = 1,
    GuideTexture = "rbxassetid://90219058157829"
}
