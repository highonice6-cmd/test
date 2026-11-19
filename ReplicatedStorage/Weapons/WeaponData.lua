-- ReplicatedStorage.Weapons.WeaponData
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = {
    M4A1 = {
        Name = "M4A1",
        Fire = { Mode = "Auto", RPM = 700 },
        Damage = {
            Base = 10,
            Headshot = 2,
            Limb = 0.85,
            Range = 450,
            FalloffStart = 60,
            FalloffEnd = 200,
            MinScale = 0.6,
            HoleScale = 0.7
        },
        Ammo = { Mag = 30, Reserve = 120, ReloadTime = 2 },
        Recoil = { Up = 1.8, Side = 0.75, AimScale = 0.65, Return = 7 },
        Bloom = {
            Hip = 2,
            Aim = 0.2,
            Move = 0.6,
            Air = 3,
            PerShot = 0.06,
            Max = 0.8,
            Recovery = 8
        },
        Handling = {
            EquipTime = 0.35,
            DrawFromBack = true,
            AimFOV = 50,
            AimWalkSpeed = 11,
            ButtOffset = Vector3.new( 0, 0.3199999928474426, 0.8399999737739563 )
        }
    }
}

local function Copy( List )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Value3

        if type( Value ) == "table" then
            local Copy2 = Copy( Value )

            if Copy2 then
                Value3 = Copy2
            else
                Value3 = Value
            end
        else
            Value3 = Value
        end

        Table[ Key ] = Value3
    end

    return Table
end

local function Rifle( Name, List )
    local Copy2 = Copy( Table.M4A1 )
    Copy2.Name = Name
    local Value2 = nil

    for Key, Value in List or { }, nil, nil do
        local Entry2
        local Entry = Copy2[ Key ]
        Entry2 = if Entry then Entry else { }
        local Value3
        Copy2[ Key ] = Entry2
        Value3 = nil

        for Key2, Value4 in Value, nil, nil do
            Copy2[ Key ][ Key2 ] = Value4
        end
    end

    return Copy2
end

Table.M4 = Rifle( "M4", { Damage = { Base = 20, Headshot = 1.75 } } )
Table.AK = Rifle( "AK", {
    Fire = { RPM = 600 },
    Damage = { Base = 16, FalloffStart = 100, FalloffEnd = 320, MinScale = 0.8 },
    Recoil = { Up = 2.4, Side = 1.1 },
    Bloom = { PerShot = 0.07, Max = 0.9, Recovery = 7 },
    Ammo = { ReloadTime = 2.3 }
} )
Table.MP5 = Rifle( "MP5", {
    Fire = { RPM = 780 },
    Damage = {
        Base = 9,
        Range = 300,
        FalloffStart = 25,
        FalloffEnd = 90,
        MinScale = 0.5,
        HoleScale = 0.5
    },
    Recoil = { Up = 1.6, Side = 0.75 },
    Bloom = { Hip = 1.6, Move = 0.35, PerShot = 0.05, Max = 0.7, Recovery = 10 },
    Ammo = { Mag = 30, Reserve = 100, ReloadTime = 1.7 },
    Handling = {
        EquipTime = 0.25,
        AimWalkSpeed = 13,
        Kick = { Pitch = 2, Back = 0.07, Speed = 1.8 }
    }
} )
Table.M60 = Rifle( "M60", {
    Fire = { RPM = 480 },
    Damage = {
        Base = 27,
        Headshot = 1.8518518518518519,
        FalloffStart = 90,
        FalloffEnd = 300,
        MinScale = 0.75,
        HoleScale = 1
    },
    Recoil = { Up = 3.2, Side = 1.4 },
    Ammo = { Mag = 30, Reserve = 150, ReloadTime = 2 }
} )
Table.M60.Sounds = {
    Single = {
        98818052766495,
        112145641516623,
        102516012957561,
        72428112058989,
        92365012429879
    },
    SingleStart = { 0.039, 0.047, 0.049, 0.047, 0.043 },
    SingleGain = { 1.16, 0.89, 0.92, 1.23, 1 },
    Final = 115028283116274,
    FarSingle = {
        128964377354579,
        102827921613615,
        122739122183227,
        136242103004413,
        92186486455651,
        74939589316833
    },
    FarSingleStart = { 0.032, 0.032, 0.028, 0.032, 0.037, 0.037 },
    FarSingleGain = { 1, 1.04, 1, 1.4, 0.96, 1.04 },
    FinalStart = 0.039,
    FarFinalStart = 0.044,
    FarFinal = 139335119614433,
    Volume = 1.56,
    FarVolume = 2.08,
    PitchVar = 0.025,
    VolVar = 0.04,
    EqVar = 1,
    FirstShotBoost = 1.05,
    ShotFade = 0.03,
    TailVolume = 1,
    TailDelay = 0.07,
    TailFadeIn = 0.03,
    TailHold = 0.25,
    TailFadeOut = 0.4,
    FarStart = 60,
    FarEnd = 180,
    RollMin = 12,
    RollMax = 250,
    FarRollMin = 45,
    FarRollMax = 900
}
Table.AK.Sounds = {
    Single = {
        78446965119386,
        74533503931856,
        89699298715550,
        126740521718207,
        77055488375202
    },
    SingleStart = { 0.026, 0.028, 0.03, 0.028, 0.03 },
    SingleGain = { 1.17, 0.95, 0.95, 0.91, 1.05 },
    Final = 106067476124111,
    FinalStart = 0.033,
    FarSingle = {
        113590177234500,
        103693682530544,
        97427649619425,
        124103423748351,
        134513995014736
    },
    FarSingleStart = { 0.03, 0.032, 0.03, 0.032, 0.028 },
    FarSingleGain = { 0.91, 0.94, 1.14, 1, 1.07 },
    FarFinal = 83436636126823,
    FarFinalStart = 0.033,
    Volume = 3.38,
    FarVolume = 1.62,
    PitchVar = 0.025,
    VolVar = 0.04,
    EqVar = 1,
    FirstShotBoost = 1.05,
    FarStart = 60,
    FarEnd = 180,
    RollMin = 12,
    RollMax = 250,
    FarRollMin = 45,
    FarRollMax = 900,
    ShotFade = 0.03,
    TailVolume = 1,
    TailDelay = 0.03,
    TailFadeIn = 0.02,
    TailHold = 0.2,
    TailFadeOut = 0.35
}
Table.M4.Sounds = {
    Pitch = 0.82,
    Single = { 86894253447642, 100175972479988, 85537003808981, 71926302754924 },
    SingleStart = { 0.034, 0.03, 0.034, 0.03 },
    SingleGain = { 1.15, 0.94, 1.07, 0.94 },
    Final = 134957633891952,
    FinalStart = 0.033,
    FarSingle = { 132968701510308, 106851992879539 },
    FarSingleStart = { 0.032, 0.032 },
    FarSingleGain = { 0.84, 1.23 },
    FarFinal = 130285064765212,
    FarFinalStart = 0.033,
    Volume = 2.86,
    FarVolume = 1.95,
    PitchVar = 0.025,
    VolVar = 0.04,
    EqVar = 1,
    FirstShotBoost = 1.05,
    FarStart = 60,
    FarEnd = 180,
    RollMin = 12,
    RollMax = 250,
    FarRollMin = 45,
    FarRollMax = 900,
    ShotFade = 0.03,
    TailVolume = 1,
    TailDelay = 0.03,
    TailFadeIn = 0.02,
    TailHold = 0.2,
    TailFadeOut = 0.35
}
Table.MP5.Sounds = {
    Single = { 90999817300487, 109068950542604, 81721923070059 },
    SingleStart = { 0.037, 0.028, 0.028 },
    SingleGain = { 0.97, 1, 1 },
    Final = 117514070151845,
    FinalStart = 0.033,
    FarSingle = { 111706761668244, 82452587480170, 75959055596491 },
    FarSingleStart = { 0.028, 0.032, 0.028 },
    FarSingleGain = { 0.92, 0.94, 1.22 },
    FarFinal = 107251949672770,
    FarFinalStart = 0.033,
    Volume = 2.73,
    FarVolume = 1.17,
    PitchVar = 0.025,
    VolVar = 0.04,
    EqVar = 1,
    FirstShotBoost = 1.05,
    FarStart = 50,
    FarEnd = 150,
    RollMin = 10,
    RollMax = 220,
    FarRollMin = 40,
    FarRollMax = 750,
    ShotFade = 0.03,
    TailVolume = 1,
    TailDelay = 0.04,
    TailFadeIn = 0.02,
    TailHold = 0.15,
    TailFadeOut = 0.3
}

local function RifleSuppressed()
    return {
        Single = 111059830795221,
        SingleStart = 0.02,
        FarSingle = 111059830795221,
        FarSingleStart = 0.02,
        Final = false,
        TailVolume = false,
        Volume = 0.26,
        FarVolume = 0.11,
        SingleGain = 1,
        FarSingleGain = 1,
        FarStart = 40,
        FarEnd = 120,
        RollMin = 8,
        RollMax = 200,
        FarRollMin = 30,
        FarRollMax = 500
    }
end

Table.M4.Sounds.Suppressed = {
    Single = 111059830795221,
    SingleStart = 0.02,
    FarSingle = 111059830795221,
    FarSingleStart = 0.02,
    Final = false,
    TailVolume = false,
    Volume = 0.26,
    FarVolume = 0.11,
    SingleGain = 1,
    FarSingleGain = 1,
    FarStart = 40,
    FarEnd = 120,
    RollMin = 8,
    RollMax = 200,
    FarRollMin = 30,
    FarRollMax = 500
}
Table.AK.Sounds.Suppressed = {
    Single = 111059830795221,
    SingleStart = 0.02,
    FarSingle = 111059830795221,
    FarSingleStart = 0.02,
    Final = false,
    TailVolume = false,
    Volume = 0.26,
    FarVolume = 0.11,
    SingleGain = 1,
    FarSingleGain = 1,
    FarStart = 40,
    FarEnd = 120,
    RollMin = 8,
    RollMax = 200,
    FarRollMin = 30,
    FarRollMax = 500
}
Table.M4.Sounds.Suppressed.Pitch = 1.1
Table.AK.Sounds.Suppressed.Pitch = 1.1
Table.M60.Sounds.Suppressed = {
    Single = 111059830795221,
    SingleStart = 0.02,
    FarSingle = 111059830795221,
    FarSingleStart = 0.02,
    Final = false,
    TailVolume = false,
    Volume = 0.26,
    FarVolume = 0.11,
    SingleGain = 1,
    FarSingleGain = 1,
    FarStart = 40,
    FarEnd = 120,
    RollMin = 8,
    RollMax = 200,
    FarRollMin = 30,
    FarRollMax = 500
}
Table.M60.Sounds.Suppressed.Volume = 0.3
Table.M60.Sounds.Suppressed.FarVolume = 0.13
Table.MP5.Sounds.Suppressed = {
    Single = 111059830795221,
    SingleStart = 0.02,
    FarSingle = 111059830795221,
    FarSingleStart = 0.02,
    Final = false,
    TailVolume = false,
    Volume = 0.26,
    FarVolume = 0.11,
    SingleGain = 1,
    FarSingleGain = 1,
    FarStart = 40,
    FarEnd = 120,
    RollMin = 8,
    RollMax = 200,
    FarRollMin = 30,
    FarRollMax = 500
}
Table.MP5.Sounds.Suppressed.Pitch = 1.2
Table.MP5.Sounds.Suppressed.Volume = 0.29
Table.MP5.Sounds.Suppressed.FarVolume = 0.125
Table.M4.Sounds.Reload = {
    { Id = 18920777557, At = 0.025, Volume = 1.4 },
    { Id = 18920780846, At = 0.525, Volume = 3 },
    { Id = 87258888424979, At = 0.88, Volume = 0.37 }
}
Table.AK.Sounds.Reload = {
    { Id = 114521394756549, At = 0.054, Volume = 0.8 },
    { Id = 133155222578089, At = 0.733, Volume = 0.53 },
    { Id = 137689041763020, At = 0.883, Volume = 0.36 }
}
Table.M60.Sounds.Reload = {
    { Id = 114521394756549, At = 0.046, Volume = 0.9, Pitch = 0.88 },
    { Id = 133155222578089, At = 0.716, Volume = 0.53, Pitch = 0.88 },
    { Id = 137689041763020, At = 0.877, Volume = 0.36, Pitch = 0.88 }
}
Table.MP5.Sounds.Reload = {
    { Id = 84355663573408, At = 0, Volume = 0.41 },
    { Id = 81556969137486, At = 0.737, Volume = 0.28 },
    { Id = 113256341928287, At = 0.825, Volume = 0.45 }
}
Table.AWP = Rifle( "AWP", {
    Fire = { Mode = "Bolt", RPM = 33, BoltTime = 1.8, Burst = 1.3 },
    Damage = {
        Base = 150,
        Headshot = 1,
        Limb = 1,
        Range = 1500,
        FalloffStart = math.huge,
        FalloffEnd = math.huge,
        MinScale = 1,
        Collateral = true,
        PierceGlass = true,
        HoleScale = 1
    },
    Ammo = { Mag = 5, Reserve = 25, ReloadTime = 3.2 },
    Recoil = { Up = 6, Side = 1.2, AimScale = 1, Return = 4.5 },
    Bloom = {
        Hip = 6,
        Aim = 0,
        Move = 1.2,
        Air = 5,
        PerShot = 0,
        Max = 6,
        Recovery = 20
    },
    Handling = {
        EquipTime = 0.6,
        AimFOV = 40,
        AimWalkSpeed = 8,
        HitboxScale = Vector3.new( 1.149999976158142, 1.149999976158142, 1.399999976158142 ),
        Scope = { FOV = 12, Overlay = 117659227535716, Delay = 0 },
        Thermal = true
    }
} )
Table.AWP.Sounds = {
    Single = 130318339037373,
    SingleStart = 0.039,
    FarSingle = 88178592497071,
    FarSingleStart = 0.06,
    Bolt = 102219448775889,
    BoltAt = 0.72,
    BoltVolume = 1.5,
    Volume = 0.45,
    FarVolume = 0.6,
    PitchVar = 0.015,
    VolVar = 0.03,
    EqVar = 0.5,
    FarStart = 80,
    FarEnd = 250,
    RollMin = 20,
    RollMax = 600,
    FarRollMin = 80,
    FarRollMax = 2500,
    ShotFade = 0.05,
    Reverb = { Decay = 1.6, Wet = -15, Dry = 0 },
    FarReverb = { Decay = 2, Wet = -18, Dry = 0 },
    Suppressed = {
        Single = 140122740840400,
        SingleStart = 0.06,
        FarSingle = 93857995661420,
        FarSingleStart = 0.06,
        Volume = 0.68,
        FarVolume = 0.45,
        LocalGain = 4.5,
        FarStart = 40,
        FarEnd = 120,
        RollMin = 10,
        RollMax = 250,
        FarRollMin = 40,
        FarRollMax = 700
    }
}
Table.DRAGON = Rifle( "DRAGON", {
    Fire = { Mode = "Semi", RPM = 200 },
    Damage = {
        Base = 40,
        Headshot = 1.75,
        Limb = 1,
        Range = 1500,
        FalloffStart = math.huge,
        FalloffEnd = math.huge,
        MinScale = 1,
        HoleScale = 1
    },
    Ammo = { Mag = 10, Reserve = 40, ReloadTime = 2.6 },
    Recoil = { Up = 3.4, Side = 1.8, AimScale = 1, Return = 5 },
    Bloom = {
        Hip = 5,
        Aim = 0,
        Move = 1,
        Air = 4,
        PerShot = 0.25,
        Max = 2,
        Recovery = 5
    },
    Handling = {
        EquipTime = 0.5,
        AimFOV = 40,
        AimWalkSpeed = 9,
        Scope = { FOV = 18, Overlay = 139824897871510, Delay = 0 }
    }
} )
Table.DRAGON.Sounds = {
    Single = { 93359703122478, 87834417956253 },
    SingleStart = { 0.039, 0.039 },
    Final = 83461826283249,
    FinalStart = 0.039,
    FarSingle = 103026865114589,
    FarSingleStart = 0.039,
    Volume = 3,
    FarVolume = 2.5,
    PitchVar = 0.02,
    VolVar = 0.04,
    EqVar = 1,
    FarStart = 70,
    FarEnd = 220,
    RollMin = 20,
    RollMax = 550,
    FarRollMin = 70,
    FarRollMax = 2000,
    ShotFade = 0.03,
    TailVolume = 1,
    TailDelay = 0.05,
    TailFadeIn = 0.02,
    TailHold = 0.15,
    TailFadeOut = 0.3,
    Suppressed = {
        Single = { 95256113748644, 134341742055329, 95328159843040 },
        SingleStart = { 0.039, 0.039, 0.039 },
        FarSingle = { 95256113748644, 134341742055329, 95328159843040 },
        FarSingleStart = { 0.039, 0.039, 0.039 },
        Final = false,
        TailVolume = false,
        Volume = 1.1,
        FarVolume = 0.6,
        FarStart = 40,
        FarEnd = 120,
        RollMin = 10,
        RollMax = 220,
        FarRollMin = 40,
        FarRollMax = 600
    }
}
Table.MK14 = Rifle( "MK14", {
    Fire = { Mode = "Semi", RPM = 400 },
    Damage = {
        Base = 34,
        Headshot = 1.7647058823529411,
        Limb = 1,
        Range = 1000,
        FalloffStart = 120,
        FalloffEnd = 400,
        MinScale = 0.9,
        HoleScale = 1
    },
    Ammo = { Mag = 25, Reserve = 80, ReloadTime = 2.1 },
    Recoil = { Up = 2.2, Side = 0.7, AimScale = 0.8, Return = 7 },
    Bloom = {
        Hip = 3.5,
        Aim = 0,
        Move = 1,
        Air = 4,
        PerShot = 0.07,
        Max = 2.4,
        Recovery = 2.5
    },
    Handling = {
        EquipTime = 0.5,
        AimFOV = 45,
        AimWalkSpeed = 10,
        Kick = { Pitch = 1, Back = 0.2, Speed = 2.8 }
    }
} )
Table.MK14.Sounds = {
    Single = 7001094555,
    SingleStart = 0,
    FarSingle = 4020514800,
    FarSingleStart = 0,
    Volume = 0.5,
    FarVolume = 0.4,
    PitchVar = 0.02,
    VolVar = 0.05,
    EqVar = 1.5,
    SoloPitchVar = 0.04,
    FarStart = 70,
    FarEnd = 220,
    RollMin = 18,
    RollMax = 450,
    FarRollMin = 60,
    FarRollMax = 1500,
    ShotFade = 0.05,
    Suppressed = {
        Single = 111059830795221,
        SingleStart = 0.02,
        FarSingle = 111059830795221,
        FarSingleStart = 0.02,
        Final = false,
        TailVolume = false,
        Volume = 0.26,
        FarVolume = 0.11,
        SingleGain = 1,
        FarSingleGain = 1,
        FarStart = 40,
        FarEnd = 120,
        RollMin = 8,
        RollMax = 200,
        FarRollMin = 30,
        FarRollMax = 500
    },
    Reload = {
        { Id = 92208011852431, At = 0, Volume = 0.9 },
        { Id = 85991057490246, At = 0.75, Volume = 0.55 },
        { Id = 95362277088351, At = 0.79, Volume = 0.5 },
        { Id = 122869059884188, At = 0.91, Volume = 0.4 }
    }
}
Table.MK14.Sounds.Suppressed.Pitch = 0.95
Table.G36 = Rifle( "G36", {
    Fire = { RPM = 600 },
    Damage = { Base = 25, Headshot = 1.75, FalloffStart = 50 },
    Recoil = { Up = 1.8, Side = 0.75 },
    Bloom = { PerShot = 0.05, Max = 0.7 },
    Ammo = { ReloadTime = 2.1 },
    Handling = { EquipTime = 0.3 }
} )
Table.G36.Sounds = {
    Single = 137265694859672,
    SingleStart = 0,
    FarSingle = 124088122551162,
    FarSingleStart = 0,
    Volume = 0.45,
    FarVolume = 0.35,
    PitchVar = 0.02,
    VolVar = 0.04,
    EqVar = 1,
    SoloPitchVar = 0.03,
    FarStart = 60,
    FarEnd = 180,
    RollMin = 12,
    RollMax = 250,
    FarRollMin = 45,
    FarRollMax = 900,
    ShotFade = 0.03,
    Suppressed = {
        Single = 111059830795221,
        SingleStart = 0.02,
        FarSingle = 111059830795221,
        FarSingleStart = 0.02,
        Final = false,
        TailVolume = false,
        Volume = 0.26,
        FarVolume = 0.11,
        SingleGain = 1,
        FarSingleGain = 1,
        FarStart = 40,
        FarEnd = 120,
        RollMin = 8,
        RollMax = 200,
        FarRollMin = 30,
        FarRollMax = 500
    },
    Reload = {
        { Id = 95334500022258, At = 0, Volume = 0.7 },
        { Id = 73807774909052, At = 0.701, Volume = 0.55 },
        { Id = 74473872447035, At = 0.825, Volume = 1 },
        { Id = 74735694264703, At = 0.896, Volume = 0.75 },
        { Id = 106987362181073, At = 0.931, Volume = 0.35 }
    }
}
Table.G36.Sounds.Suppressed.Pitch = 1.15
Table.G15 = Rifle( "G15", {
    Fire = { Mode = "Semi", RPM = 400 },
    Damage = {
        Base = 12,
        Headshot = 1.3333333333333333,
        Limb = 0.8,
        Range = 300,
        FalloffStart = 30,
        FalloffEnd = 120,
        MinScale = 0.6,
        HoleScale = 0.5
    },
    Ammo = { Mag = 15, Reserve = 60, ReloadTime = 1.7 },
    Recoil = { Up = 2.2, Side = 0.9, AimScale = 0.8, Return = 8 },
    Bloom = {
        Hip = 2.5,
        Aim = 0.15,
        Move = 0.5,
        Air = 3,
        PerShot = 0.3,
        Max = 1.2,
        Recovery = 7
    },
    Handling = {
        EquipTime = 0.25,
        DrawFromBack = false,
        AimFOV = 55,
        AimWalkSpeed = 13,
        Pistol = true,
        Kick = { Pitch = 10, Arm = true }
    }
} )
Table.G15.Sounds = {
    Single = 81713964902782,
    SingleStart = 0,
    Volume = 1.1,
    PitchVar = 0.02,
    VolVar = 0.04,
    EqVar = 1,
    SoloPitchVar = 0.03,
    RollMin = 10,
    RollMax = 250,
    ShotFade = 0.05,
    Suppressed = {
        Single = { 108977767860532, 137755197178375, 92894806513813 },
        SingleStart = { 0.03, 0.03, 0.03 },
        SingleGain = { 1.05, 1.05, 0.95 },
        Volume = 0.9,
        RollMin = 6,
        RollMax = 110
    },
    Reload = {
        { Id = 103661905986263, At = 0, Volume = 2.5 },
        { Id = 128241610178087, At = 0.78, Volume = 1.45 }
    }
}
Table.SPAS12 = Rifle( "SPAS-12", {
    Fire = {
        Mode = "Semi",
        RPM = 70,
        BoltTime = 0.85,
        Pump = true,
        SwapCooldown = 0.7,
        Pellets = {
            Pattern = {
                Vector2.new( 0, 0 ),
                Vector2.new( -0.5, 0.8 ),
                Vector2.new( 0.5, 0.8 ),
                Vector2.new( -0.5, -0.8 ),
                Vector2.new( 0.5, -0.8 )
            },
            Jitter = 0.25
        }
    },
    Damage = {
        Base = 12,
        Headshot = 1.5,
        Range = 150,
        FalloffStart = 25,
        HoleScale = 0.6,
        Curve = {
            { 0, 1.6 },
            { 10, 1.6 },
            { 20, 1.4 },
            { 45, 1 },
            { 70, 0.5 },
            { 100, 0.15 },
            { 130, 0.05 }
        }
    },
    Ammo = {
        Mag = 8,
        Reserve = 32,
        ReloadTime = 4.6,
        Shell = {
            Start = 0.35,
            Each = 0.5,
            InsertAt = 0.8,
            End = 0.25,
            Interrupt = 0.15
        }
    },
    Sounds = {
        Single = 82651111765871,
        SingleStart = 0,
        FarSingle = 101737466526184,
        FarSingleStart = 0,
        BoltInShot = true,
        Bolt = {
            { Id = 126161725690062, At = 0.27 },
            { Id = 112863196810371, At = 0.65 }
        },
        BoltVolume = 0.9,
        Shell = 104910000431982,
        ShellVolume = 0.75,
        Volume = 0.45,
        FarVolume = 0.5,
        PitchVar = 0.02,
        VolVar = 0.04,
        EqVar = 0.5,
        FarStart = 70,
        FarEnd = 220,
        RollMin = 15,
        RollMax = 500,
        FarRollMin = 60,
        FarRollMax = 1800,
        ShotFade = 0.05,
        Reverb = { Decay = 1.2, Wet = -18, Dry = 0 },
        FarReverb = { Decay = 1.8, Wet = -20, Dry = 0 },
        Suppressed = {
            Single = 126408032863466,
            SingleStart = 0,
            FarSingle = 90402641791317,
            FarSingleStart = 0,
            BoltInShot = false,
            Volume = 0.3,
            FarVolume = 0.14,
            BoltVolume = 0.45,
            FarStart = 35,
            FarEnd = 110,
            RollMin = 8,
            RollMax = 220,
            FarRollMin = 30,
            FarRollMax = 600
        }
    },
    Recoil = { Up = 10, Side = 2.4 },
    Bloom = { Hip = 3, Aim = 0.15, PerShot = 0.1, Max = 0.4, Recovery = 5 },
    Handling = {
        EquipTime = 0.4,
        ButtOffset = Vector3.new( 0, 0.18000000715255737, 0.9399999976158142 ),
        HitboxScale = Vector3.new( 1.149999976158142, 1.149999976158142, 1.399999976158142 ),
        Kick = { Pitch = 12, Back = 0.32, Speed = 2.2 }
    }
} )
Table.RPG = Rifle( "RPG", {
    Fire = {
        Mode = "Rocket",
        RPM = 60,
        Rocket = {
            Speed = 150,
            Gravity = 0,
            Range = 400,
            Radius = 16,
            Damage = 150,
            CarDirect = 3,
            HitRadius = 1.6
        }
    },
    Damage = {
        Base = 0,
        Range = 400,
        FalloffStart = 400,
        FalloffEnd = 500,
        MinScale = 1
    },
    Ammo = { Mag = 1, Reserve = 10, ReloadTime = 3.2 },
    Recoil = { Up = 7, Side = 1.5, AimScale = 1, Return = 4 },
    Bloom = {
        Hip = 3,
        Aim = 0.3,
        Move = 0.8,
        Air = 3,
        PerShot = 0,
        Max = 3,
        Recovery = 8
    },
    Handling = {
        EquipTime = 0.6,
        AimFOV = 55,
        AimWalkSpeed = 9,
        Poses = {
            Aim = "RPGAim",
            ReloadAim = "RPGAim",
            Reload = "RPGAim",
            Low = "RPGLow",
            Sprint = "RPGLow"
        },
        RocketReload = true,
        Kick = { Pitch = 6, Back = 0.3, Speed = 1.6 }
    }
} )
Table.RPG.RocketSounds = {
    Flight = 140307246312623,
    FlightVolume = 0.9,
    Launch = 2706228430,
    LaunchVolume = 0.45,
    Explosion = 131756915295707,
    ExplosionVolume = 1.4,
    ExplosionFar = 126641453194191,
    ExplosionFarVolume = 3.4,
    FarStart = 60,
    FarEnd = 220,
    RollMin = 25,
    RollMax = 1500,
    FarRollMin = 300,
    FarRollMax = 4000,
    FlightRollMin = 40,
    FlightRollMax = 1500,
    LaunchRollMin = 30,
    LaunchRollMax = 2500,
    BackBlast = 108660561169614,
    BackBlastVolume = 0.6,
    BackBlastRollMin = 30,
    BackBlastRollMax = 2500
}
Table.RPG.Sounds = {
    Reload = {
        { Id = 71140779481370, At = 0.297, Volume = 2 },
        { Id = 116111946395804, At = 0.6625, Volume = 0.9 }
    }
}
Table.Eagle = Rifle( "Deagle", {
    Fire = { Mode = "Semi", RPM = 170 },
    Damage = {
        Base = 40,
        Headshot = 2.5,
        Limb = 0.8,
        Range = 350,
        FalloffStart = 50,
        FalloffEnd = 150,
        MinScale = 0.7,
        HoleScale = 0.7,
        PierceGlass = true
    },
    Ammo = { Mag = 7, Reserve = 28, ReloadTime = 2 },
    Recoil = { Up = 6, Side = 1.6, AimScale = 0.85, Return = 6 },
    Bloom = {
        Hip = 3,
        Aim = 0.15,
        Move = 0.7,
        Air = 3.5,
        PerShot = 0.6,
        Max = 2,
        Recovery = 5
    },
    Handling = {
        EquipTime = 0.35,
        DrawFromBack = false,
        AimFOV = 52,
        AimWalkSpeed = 12,
        Pistol = true,
        Kick = { Pitch = 18, Arm = true }
    }
} )
Table.Eagle.Sounds = {
    Single = 82286818216627,
    SingleStart = 0.015,
    FarSingle = 128332149733965,
    FarSingleStart = 0.015,
    Volume = 0.44,
    FarVolume = 0.28,
    PitchVar = 0.02,
    VolVar = 0.04,
    EqVar = 1,
    SoloPitchVar = 0.025,
    FarStart = 60,
    FarEnd = 180,
    RollMin = 14,
    RollMax = 320,
    FarRollMin = 50,
    FarRollMax = 1100,
    ShotFade = 0.05,
    Reload = { { Id = 799999260, At = 0, Volume = 0.42 } }
}
Table.M9 = Rifle( "C6", {
    Fire = { Mode = "Semi", RPM = 360 },
    Damage = {
        Base = 16,
        Headshot = 1.25,
        Limb = 0.8,
        Range = 300,
        FalloffStart = 30,
        FalloffEnd = 120,
        MinScale = 0.6,
        HoleScale = 0.5
    },
    Ammo = { Mag = 15, Reserve = 60, ReloadTime = 2 },
    Recoil = { Up = 2.5, Side = 0.9, AimScale = 0.8, Return = 8 },
    Bloom = {
        Hip = 2.4,
        Aim = 0.15,
        Move = 0.5,
        Air = 3,
        PerShot = 0.3,
        Max = 1.2,
        Recovery = 7
    },
    Handling = {
        EquipTime = 0.25,
        DrawFromBack = false,
        AimFOV = 55,
        AimWalkSpeed = 13,
        Pistol = true,
        Kick = { Pitch = 11, Arm = true }
    }
} )
Table.M9.Sounds = {
    Single = 799960407,
    SingleStart = 0.03,
    FarSingle = 137236120745115,
    FarSingleStart = 0.03,
    Volume = 0.33,
    FarVolume = 0.42,
    PitchVar = 0.02,
    VolVar = 0.04,
    EqVar = 1,
    SoloPitchVar = 0.03,
    FarStart = 60,
    FarEnd = 180,
    RollMin = 10,
    RollMax = 250,
    FarRollMin = 45,
    FarRollMax = 900,
    ShotFade = 0.05,
    Reload = { { Id = 799960619, At = 0, Volume = 0.63 } }
}
Table.Uzi = Rifle( "Uzi", {
    Fire = { Mode = "Auto", RPM = 900 },
    Damage = {
        Base = 7,
        Headshot = 1.6,
        Range = 220,
        FalloffStart = 20,
        FalloffEnd = 80,
        MinScale = 0.5,
        HoleScale = 0.5
    },
    Ammo = { Mag = 32, Reserve = 128, ReloadTime = 2.4 },
    Recoil = { Up = 1.3, Side = 1, AimScale = 0.75, Return = 9 },
    Bloom = {
        Hip = 2.2,
        Aim = 0.45,
        Move = 0.4,
        Air = 3,
        PerShot = 0.07,
        Max = 1.3,
        Recovery = 9
    },
    Handling = {
        EquipTime = 0.22,
        DrawFromBack = false,
        AimFOV = 56,
        AimWalkSpeed = 13,
        Pistol = true,
        Kick = { Pitch = 3, Arm = true }
    }
} )
Table.Uzi.Sounds = {
    Single = 115614641644380,
    SingleStart = 0.015,
    FarSingle = 93098487940752,
    FarSingleStart = 0.03,
    Volume = 0.64,
    FarVolume = 0.88,
    PitchVar = 0.025,
    VolVar = 0.04,
    EqVar = 1,
    FirstShotBoost = 1.05,
    FarStart = 50,
    FarEnd = 150,
    RollMin = 10,
    RollMax = 220,
    FarRollMin = 40,
    FarRollMax = 750,
    ShotFade = 0.03,
    Reload = { { Id = 116417929617463, At = 0, Volume = 1.36 } }
}
Table.Uzi.Sounds.Suppressed = {
    Single = 111059830795221,
    SingleStart = 0.02,
    FarSingle = 111059830795221,
    FarSingleStart = 0.02,
    Final = false,
    TailVolume = false,
    Volume = 0.26,
    FarVolume = 0.11,
    SingleGain = 1,
    FarSingleGain = 1,
    FarStart = 40,
    FarEnd = 120,
    RollMin = 8,
    RollMax = 200,
    FarRollMin = 30,
    FarRollMax = 500
}
Table.Uzi.Sounds.Suppressed.Pitch = 1.2
Table.Uzi.Sounds.Suppressed.Volume = 0.29
Table.Uzi.Sounds.Suppressed.FarVolume = 0.125

local function PistolSuppressed( Argument1 )
    local Rawget = rawget( Table.G15.Sounds, "Suppressed" )
    return {
        Single = table.clone( Rawget.Single ),
        SingleStart = table.clone( Rawget.SingleStart ),
        SingleGain = table.clone( Rawget.SingleGain ),
        FarSingle = table.clone( Rawget.Single ),
        FarSingleStart = table.clone( Rawget.SingleStart ),
        FarSingleGain = table.clone( Rawget.SingleGain ),
        Final = false,
        TailVolume = false,
        Volume = Rawget.Volume,
        FarVolume = 0.3,
        FarStart = 40,
        FarEnd = 120,
        RollMin = Rawget.RollMin,
        RollMax = Rawget.RollMax,
        FarRollMin = 20,
        FarRollMax = 300,
        Pitch = Argument1
    }
end

local Sounds = Table.M9.Sounds
Sounds.Suppressed = PistolSuppressed( 0.95 )
local Sounds2 = Table.Eagle.Sounds
Sounds2.Suppressed = PistolSuppressed( 0.85 )
Table.SawedOff = Rifle( "Sawed-Off", {
    Fire = {
        Mode = "Semi",
        RPM = 240,
        Pellets = {
            Pattern = {
                Vector2.new( 0, 0 ),
                Vector2.new( -0.9, 0.9 ),
                Vector2.new( 0.9, 0.9 ),
                Vector2.new( -0.9, -0.9 ),
                Vector2.new( 0.9, -0.9 ),
                Vector2.new( 0, 1.3 ),
                Vector2.new( 0, -1.3 )
            },
            Jitter = 0.5
        }
    },
    Damage = {
        Base = 9,
        Headshot = 1.5,
        Range = 110,
        FalloffStart = 15,
        HoleScale = 0.6,
        Curve = {
            { 0, 1.5 },
            { 8, 1.5 },
            { 15, 1.2 },
            { 25, 0.8 },
            { 40, 0.35 },
            { 60, 0.1 },
            { 80, 0.03 }
        }
    },
    Ammo = { Mag = 2, Reserve = 24, ReloadTime = 2.5 },
    Recoil = { Up = 12, Side = 3 },
    Bloom = { Hip = 3.5, Aim = 0.4, PerShot = 0.2, Max = 0.8, Recovery = 4 },
    Handling = {
        EquipTime = 0.35,
        ButtOffset = Vector3.new( 0, -0.019999999552965164, 0.47999998927116394 ),
        HitboxScale = Vector3.new( 1.149999976158142, 1.149999976158142, 1.399999976158142 ),
        Kick = { Pitch = 14, Back = 0.35, Speed = 2 }
    }
} )
Table.SawedOff.Sounds = {
    Single = 6141025551,
    SingleStart = 0.015,
    FarSingle = 90365204399312,
    FarSingleStart = 0.015,
    Volume = 0.3,
    FarVolume = 0.24,
    PitchVar = 0.02,
    VolVar = 0.04,
    EqVar = 0.5,
    FarStart = 70,
    FarEnd = 220,
    RollMin = 15,
    RollMax = 500,
    FarRollMin = 60,
    FarRollMax = 1800,
    ShotFade = 0.05,
    Reload = { { Id = 7552630907, At = 0, Volume = 0.45 } }
}
local Table2 = {
    M4 = 800,
    AK = 800,
    MP5 = 800,
    M60 = 800,
    DRAGON = 267,
    SPAS12 = 213,
    AWP = 133,
    RPG = 27,
    Eagle = 187,
    M9 = 400,
    Uzi = 854,
    SawedOff = 53,
    MK14 = 534,
    G36 = 800
}
Value1 = nil

for Key, Value in Table2, nil, nil do
    if Table[ Key ] then
        Table[ Key ].Durability = Value
    end
end

Table.G15.Unbreakable = true
return Table
